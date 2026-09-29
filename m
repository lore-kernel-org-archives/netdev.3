Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E3A282F0C
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666725; cv=none; b=hBk01PEOv9FMH4YdU6zW0taoG/iROCHDYnQP8ggNH5jVH9SwMAKNkWCiUhV14e9QgX8dLTZkIWnv61qBQbYsbmS3lWaL8fskLd2u+RbGjCukIKRp98StHzlHfJCs6FEut95ZkL/QaWGwr2hMsVDV3GYo8jo4j6SvAKBjlGG6VGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666725; c=relaxed/simple;
	bh=vXiPYU0cSC0MhhcbWDuX8Ks0SSTK1cMIrJrwZV3hEkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UPbxuue+D7EmvtGQUVbD/Kqy+KdnP1+TbO+SeRCE2xjMDOzd2q8LFIFEV2p1lLpsrM6FLDq0gbWgOceVwRcnc26qOPTyDmkjCEdulKNDwlz1ULJemgZHNGGudjNeteFTAC+kplXv7ti7/rphfvKYNTr6BTVlzG+b/BaHIenVqZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=Z3wYFQA5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="Z3wYFQA5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d391aso28631935e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1790666722; x=1791271522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1LMlP+LKNpavKh20Ow5p/XPiL08oZ6Sei4hnViskqxo=;
        b=Z3wYFQA53r1Bjwe0XR9oLsWrcIfrnUEyjIt0vXrsjq5ExtTy5anEH2cs9svWCApluV
         oTRbI49wOWdX+JLhmcUDXqQ1Khvo/HD4AmmSWaehroUJdxQGVeyy2Z8RT/mGbbIh54i5
         AizkoJ9T++yPhJad+UqZfNin8Fw9wO6ru8Cnac9aLdmqAgnX5yYimi513aVuMbZVukSe
         0U891KLhWnf3t3slSL/u02yQRMXDghCQ1D+MrrSEr78EtEHzN38vXgm0b62mbKn97oIp
         Ik+/OcttCrkdVbUbzM3fPfH8FCWLFTZBJMPKd0AHkqYoViU29Ap9ZxRGBhIoBbAXTre2
         f6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666722; x=1791271522;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1LMlP+LKNpavKh20Ow5p/XPiL08oZ6Sei4hnViskqxo=;
        b=1FGUxpkyXgBhE/Tsr+oe9SxStWWrZ8XXMkK3tievEEAIsBNP7LlNJZr7KMwJ6WL/zI
         FwR+HWKZCzJ8x+Oe2jZLWOOcJY7hY4kbxEhbMBRs+2RoZQdqTelGtFo9QPXc/hAdjtIv
         jBZZWWNyhU/Z0YksJ0R0aCY4Fgyr7LznCisEqyz55cpPjwBhUq6CA3oyluHkLjBzw1wj
         h8ddsYnKgwSWZaFGBZRzHFqlrm7eyKf9Wu0ANVYZvvuma5QewkfGsB9gweq1+w2XBQ1z
         +ysYH9fpZqx+SBdwXD8RW2BQm8KoN8M2FT4kFb/QJ/j3MjBB3fp+GmNrU+rr5GU1LYtF
         59jw==
X-Gm-Message-State: AFuF++mliNZWSRh6VfqpOuJHBJjw3rAtxfecFinxHlcHLxmCikO6J3wR
	WvdTqCAEBY8T/WMZScd+XF6KvZS9tUfVI+ms7NlekEZiIGKsFoIjYtmSoMTZBWiKZewuuoRFxFC
	FYBlQ
X-Gm-Gg: AYBFou2shTeK9dFgY33l/DaiMRFOkUhpIK5mekZ07zfyOe0VAKADwO8EmeABmY4ty7i
	IPHH/xVvGI/S3OdEHXRB7VsJpvXydLyBgIF4DZKs2aTbUMpZcq5r97B7C6XfpXSTRsCD91n6gLL
	apr+1qNWvbQUowK873Lx1JHf4tT3hBWetLVKGA+s2nKWclI260SovYi/fGGH3QTLsMZ7rbTEHar
	mTLsYvQDb1dZ1MGOQkX/egq5sLo6P2knBKlgXf4bsOSBYKOsVpm0xw60AXcsC0vbvCVoKVRosgK
	/j5h3bOmS3ILvKN3dtn/3P+P1MJYuC0jBb5yzRr2+fYk6HjMfC/BYQLRiDpPuTwYJooDaU/ZmIB
	88TpOiDZHKSAlevhQFEjWS66n38mlCaT/HgePi+8EI9+k+QUM5IFGplQgQfV31pLk/COWaEwJ3W
	OZf3DTpi6DEEE2pXTFSmj81DnMT/vNUadiqSqewZ5Qyyl2d6C2LRc/KHPB08+SjTttp/w=
X-Received: by 2002:a05:600c:870e:b0:49f:c1a1:5222 with SMTP id 5b1f17b1804b1-49fe670b208mr275472285e9.33.1790666722300;
        Tue, 29 Sep 2026 00:25:22 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:5dc9:ac15:6dc5:8646])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf4598esm58896465e9.0.2026.09.29.00.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 00:25:21 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Denis V. Lunev" <den@openvz.org>,
	stable@vger.kernel.org
Subject: [PATCH net v3] openvswitch: fix soft lockup in the netlink flow dump
Date: Tue, 29 Sep 2026 09:25:18 +0200
Message-ID: <20260929072519.2803304-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis V. Lunev <den@openvz.org>

A production compute node carrying a few thousand datapath flows hit a
soft lockup inside a single netlink flow dump and panicked.

ovs_flow_cmd_dump() calls ovs_flow_stats_get() for every flow it
emits, and that releases stats->lock with spin_unlock_bh() once per
CPU that has touched the flow. Every release is a local_bh_enable(),
and each one runs the pending softirq backlog in the dumping thread's
own context.

The skb bounds the flows one callback emits, but not the softirq work
it absorbs. On a CPU that carries the box's packet load the backlog
refills as fast as it drains, so the dumping thread becomes that CPU's
softirq engine. It never sleeps and it has no reschedule point, so
under voluntary preemption nothing can take the CPU away from it:
neither the ksoftirqd the kernel woke to take the work over, nor the
stopper thread the softlockup detector dispatches to refresh its
timestamp.

Hold BH off across the whole callback instead, the way
ctnetlink_dump_table() does, so the nested spin_unlock_bh() stop
draining softirqs. The loop already runs under rcu_read_lock() and
cannot sleep. What it gives up is preemption under CONFIG_PREEMPT,
since a BH-off region is not preemptible outside PREEMPT_RT. The
region stays short: the skb caps the flows one callback emits, and
empty buckets cost no skb space but are each visited once per dump, as
the cursor only moves forward. The table grows on insert and shrinks
only on flush, so the walk is bounded by the largest flow count the
datapath has held. The softirq backlog the callback used to absorb has
no bound at all.

Fixes: 63e7959c4b9b ("openvswitch: Per NUMA node flow stats.")
Cc: stable@vger.kernel.org
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
v3:
- add the net prefix, Fixes tag and Cc stable
- explain why the BH-off walk stays bounded: the cursor visits each
  empty bucket once per dump and the table shrinks only on flush
- drop "here" from the comment, add blank lines around the
  local_bh_disable()/local_bh_enable() pair
v2: https://lore.kernel.org/netdev/20260915122401.3910188-1-den@openvz.org/
- leave ovs_vport_cmd_dump() alone: nsid_lock has not been BH-safe
  since commit aed4969f2bdf ("net: net->nsid_lock does not need BH
  safety"), so the vport dump never drained softirqs
- disable BH before the table dereference and say in a comment that
  the region is not there for safety
- drop the ovs_flow_stats_get() history, note the empty-bucket walk
  and the lost CONFIG_PREEMPT preemption in the message
- move the Cc list out of the commit message
v1: https://lore.kernel.org/netdev/20260909171920.1001074-1-den@openvz.org/

 net/openvswitch/datapath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 631a03136fa1..4fc5d0bebd85 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -1532,6 +1532,12 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return -ENODEV;
 	}
 
+	/*
+	 * Not needed for safety. Stops every spin_unlock_bh() in
+	 * ovs_flow_stats_get() from running the softirq backlog.
+	 */
+	local_bh_disable();
+
 	ti = rcu_dereference(dp->table.ti);
 	for (;;) {
 		struct sw_flow *flow;
@@ -1552,6 +1558,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		cb->args[0] = bucket;
 		cb->args[1] = obj;
 	}
+
+	local_bh_enable();
 	rcu_read_unlock();
 	return skb->len;
 }
-- 
2.53.0

