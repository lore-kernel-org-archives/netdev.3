Received: from mail-pj2-f20.google.com (mail-pj2-f20.google.com [74.125.227.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2103F3054C7
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789924052; cv=none; b=D0HTGnbAXBrH2/iF65RWokphbuj4uyibydrnQM+WVfKLBbDhJe4qcGXkzuUPVW2NGiwWnbPhxyUbupAleeXHfePVLvX6HaM9BuS4+3pfyiBqpKXedi5SQ99bnIB0VvWGkUPP15hOF7aMJyA9/m87m7daBjMK6g5vKLxlcc/U/9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789924052; c=relaxed/simple;
	bh=CeaP3bnwxpj8S2+Z8APBuzPTZMJrXRKNnCAyqMttIh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUc07VIP9lfNk0ApvtwQjDibyo01WbYdb9GUd9crsEMjT7wkjQ+BwMm6AzeGJs1rTHd7alvh9AndbWi3bMRpRYMZHV4M4m2I7Oe7m2f9UL4Ip4QUUgi4/NdUlfGC3ezbb1oF35E7rNfYwhc/HHTTscfpqF2qjQnTC99XlAx+GT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=AYDxvoRw; arc=none smtp.client-ip=74.125.227.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="AYDxvoRw"
Received: by mail-pj2-f20.google.com with SMTP id d9443c01a7336-2d747ed9866so20685315ad.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789924050; x=1790528850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Cn3K6CRyJbs/Kf2+d4qOErSf/juRHxycpQi/wdS+68=;
        b=AYDxvoRwYMFrReLhpR/jxLPyJP/QweTKPPqJxNaKhHI6w+ZrrlssZIhAKmYWWqHCii
         gN5vn33Lmtw/SUkGWf5pk+gG7ghr37/6lP15RLRSVdkul0AaivYzDHprD3PYq46n0Y2R
         nMyiAVIyvfV4F/9/CQqP6NgDaMf8j8hWJ/0rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789924050; x=1790528850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Cn3K6CRyJbs/Kf2+d4qOErSf/juRHxycpQi/wdS+68=;
        b=cZk+ASp3tOP3gDvwaFu+mkQa3tkmdiaz85HKEnhwi/DfRrkQ02e7D4WUogt6Zrr6/2
         T/1KPQeHTAnkkdeLdcqRl2PFSZnSYFV/NmJ5LTgN/3XJ9j1xxF9CtZkInxlapqRhf8nl
         1Ih6fjGKA0BykvQJ2yi/GFInZvUzzgL/IauFTL59NVKu3l7CIfgucAgCM3CWFhZwDzf0
         AnYCCjAAteyFse0IGaJsPphcDva0Y4F02NwobgfxG+1h/wk4XVnMEwtMl8LnV9o0fuVb
         JgfF8zLxYmPnBMQTUj4vJL2tVkIW3+0t/hEzx5u8qIVPz092cZFMvx0bSVo5SuE4i60s
         xg4A==
X-Forwarded-Encrypted: i=1; AKwUvBzPVHrjgqRgeL5mvWCQGyuadMlV85exP8GvRMDBUjxWnpjD6UWtEnuvg/DzMb+0zaHIvDgR61U=@vger.kernel.org
X-Gm-Message-State: AFuF++mXWebFrpBN6ksS0QDWdDucNY/4Nv7EQOE7TcwRa+Db/Sic3bcB
	V9REj2s45vkmErmYdf5opdaeRJkZt196Q1ZBYM8T45amLRoMFg2VJIVWyqyEmq8TEQ==
X-Gm-Gg: AYBFou1VROttaMFRK2VZ2UR2hQzlOqUB+/mawn6r2qwjBISIBDXfuzbTcAYUNys3Jgd
	lVjJbxYye3f9p/d2wh9bhtUjikr4dzf7QmrJwOdCmfsEAiyq7B3bSW9X81NdwrLRi2zK+nsfeH4
	vADYk3q2fjfTZzb616LqwF1mHurfJrOocfpxNwI8NYufHxJPA59pfqCqSvxFlmunVeaGe33UYOi
	axrSQ4wfoRbVKZ5nNHVYJ2GUxiCnFW4TfTZcXyWFB8RXHVT9T5oYJ++tkl9aqHRHn147MEyvu+p
	y/lBgCk845lu1hO92z+0Qv28PHJBp7D6drnrywj3SlApy2J2Jj+Zx71+b1Eium8TYJmnu2ERN6o
	34xiF87RLO7704ixwR/tt4Y+oKUq96omzotT8VtNS9yxcAtJ7lycw1frvvYS5Da7ypRermfASV8
	3FQgOWRgRGJnuAJQ2kYeNAqyOwDBiFT9FUAMTA1Y/VP8BFY6Rqu9fCijF6aGlH+JiBONuJA6CxY
	jfQ
X-Received: by 2002:a17:902:c40a:b0:2df:49be:3136 with SMTP id d9443c01a7336-2df49be32c8mr4592825ad.34.1789924050098;
        Sun, 20 Sep 2026 10:07:30 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c33188f76sm12111482eec.21.2026.09.20.10.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:07:28 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	hybris@mojatatu.ai,
	sashiko-bot@kernel.org
Subject: [PATCH net] net/sched: act_gate: budget the per-entry list in get_fill_size
Date: Sun, 20 Sep 2026 14:07:01 -0300
Message-ID: <QDISC-3BLH.v1.20260914203033@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_gate_get_fill_size returns only the TCA_GATE_PARMS size, but
tcf_gate_dump also emits three 64-bit timestamps, the clock id, flags,
priority and the variable-length TCA_GATE_ENTRY_LIST nest. The per-entry
nest is unbounded: parse_gate_list places no cap on the number of
sched-entries, so a gate with many entries can push the real dump well
past the skb that tca_get_fill allocates from this size.

RTM_NEWACTION then fails the add-notify with -EINVAL while the action is
already committed to the IDR, and a subsequent RTM_GETACTION on the
installed gate also returns -EINVAL because its dump no longer fits.

Fix this by accounting for the missing fields in tcf_gate_get_fill_size
along with all elements in the entries list.

Note that sizing the reply from the action lets an oversized gate
install cleanly for the first time: with the input unbounded by
parse_gate_list, the sized skb can now grow well above
NLMSG_GOODSIZE per netlink request (a transient GFP_KERNEL allocation
reachable only with namespace-local CAP_NET_ADMIN). Overload from a
malicious netns admin is hardening material, not net, per the
discussion at
https://lore.kernel.org/netdev/20260914191108.55a1a4f1@kernel.org/;
a follow-up patch for net-next will cap the sched-entry count.

Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event message size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824153903.4143642-1-victor@mojatatu.com
Tested-by: hybris <hybris@mojatatu.ai>
Co-developed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/act_gate.c | 30 +++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 5d228a402204..5d8bb190a086 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -681,7 +681,35 @@ static void tcf_gate_stats_update(struct tc_action *a, u64 bytes, u64 packets,
 
 static size_t tcf_gate_get_fill_size(const struct tc_action *act)
 {
-	return nla_total_size(sizeof(struct tc_gate));
+	struct tcf_gate *gact = to_gate(act);
+	const struct tcf_gate_params *p;
+	struct tcfg_gate_entry *entry;
+	size_t size = nla_total_size(sizeof(struct tc_gate)) /* TCA_GATE_PARMS */
+		+ 3 * nla_total_size_64bit(sizeof(u64)) /* TCA_GATE_BASE_TIME
+							 * TCA_GATE_CYCLE_TIME
+							 * TCA_GATE_CYCLE_TIME_EXT
+							 */
+		+ nla_total_size(sizeof(s32)) /* TCA_GATE_CLOCKID */
+		+ nla_total_size(sizeof(u32)) /* TCA_GATE_FLAGS */
+		+ nla_total_size(sizeof(s32)) /* TCA_GATE_PRIORITY */
+		+ nla_total_size(0); /* TCA_GATE_ENTRY_LIST */
+	/* TCA_GATE_TM is budgeted by tcf_action_shared_attrs_size() */
+
+	rcu_read_lock();
+	p = rcu_dereference(gact->param);
+	if (p) {
+		list_for_each_entry_rcu(entry, &p->entries, list)
+			/* TCA_GATE_ONE_ENTRY nest and its attributes */
+			size += nla_total_size(0)
+				+ nla_total_size(sizeof(u32)) /* TCA_GATE_ENTRY_INDEX */
+				+ nla_total_size(0) /* TCA_GATE_ENTRY_GATE */
+				+ nla_total_size(sizeof(u32)) /* TCA_GATE_ENTRY_INTERVAL */
+				+ nla_total_size(sizeof(s32)) /* TCA_GATE_ENTRY_MAX_OCTETS */
+				+ nla_total_size(sizeof(s32)); /* TCA_GATE_ENTRY_IPV */
+	}
+	rcu_read_unlock();
+
+	return size;
 }
 
 static void tcf_gate_entry_destructor(void *priv)
-- 
2.43.0

