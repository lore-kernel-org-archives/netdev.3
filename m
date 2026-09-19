Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097C38D3FD
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789851996; cv=none; b=awo8+td077I1bxDmOogteLXfiNEoV+XljZazub7ZVOiN0iwDGIrq5ePDZ5UbMdqbZuqrR+vMwWrMASGCPbla2i1l2q5YgrTxwGLo5KQDg/FHT4A+Ms3DV57U69Q3YygmyM70WTzy0Q3lrDnWikuFK4Z8tpIVbKXA4d5YvHzmbYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789851996; c=relaxed/simple;
	bh=rkeu4ZpR3DudTk78RdWRd/sRhVqmLJntTwWFB3VgecU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KbNeDBSyJgNrEAACj45QuiFnJmvTVmbHKJJO8tKo/nsXHKIhjUHJbZw+mNZ4SLcVysKW3UnrXAdpQvHRxlYO1ZHkNJgIMnAZVfIYX1txI3hJdL/ugdREK/MKeo2n+OonUD6Y9GNNCWELPi8wy+Bt6vKw+QC2gwYhFRe7EZU4A7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlFoj5GJ; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlFoj5GJ"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-8674704dab1so2671873b3a.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789851985; x=1790456785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eIqO3FqVB1dK7+YBAaOuu1DEyH3i0oVt3LwyqRR/sIQ=;
        b=QlFoj5GJwxpEizbuZzT8pElrNwtby1pgly3SiP1Wegtg+VFVPulmw2CjpZR3nn0p+i
         Ma3BRoc6JXVIIoPAJdhcufvSCD1UEgnFS0zfozHhur505J6KyM3+lfAFUUxBhqf6jaSB
         gIrUQoVRmt6qwzJqQyFTin4KN8tRwSgcljACeHhQVmkdBJyyOLFcdBZx0PlFTpFfDoIA
         bcnhJ/LD6XQaYdNb4XF5W7H/8qn5h0yOKPug0RoRvQTVDTht7AU5oUQG3ZqCN4cfE53t
         Dh+JN/xGXX04Y5oB1oxLm9BHUw2xdnuAjQJGQYtWwHCm9BBRvpS5gbBkL5AHDja2EO/+
         89Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789851986; x=1790456786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eIqO3FqVB1dK7+YBAaOuu1DEyH3i0oVt3LwyqRR/sIQ=;
        b=hb3iCJnnqKxToemjq8ZsZgYXgqNibxVo0pn8HzNvT3Va1xrk9G+eRczn1AxoOY1hv4
         hllnPZXHNCdwcxFCUtSfIzjStQZ8t21zoZQA++mlYFX+DW+nMhwZFU7T7LL4AY9FcY38
         MOdDs/rj1DWxFSe0F07bwSkga0NabQlgRUUnu6Rwkxsu1WUE0/qMCyYS4geokQ0R7OfY
         RsoALfvd0OQzAV30hQXI0fbYv14sK1v2o5/IesSOULmGd2yzM2S1efJPptwroZjzaiuD
         9Wsabwpn4fEqpn5BF+qZaJiaIA2n5xZ6tCDY91iLH/32xPj9+8nje2viuvmbcspF82Ax
         dpSw==
X-Forwarded-Encrypted: i=1; AKwUvBy8ALGrEaRX78LiEAiq4Tsrlyl+zKTzcaFaWW/e0x8rF1oqc8CyW4e+qSnfqL3Ki+8Oq5Az7fE=@vger.kernel.org
X-Gm-Message-State: AFuF++k/hhffmxCqLYQRm2Et1XlPNwJLCeIFp6a5p0uXJJgZwERygtPA
	TT2HBJFMrOFSCmU0m4sRshcC53BX5U2bIT5PkFDTX85aWjij9vjA9gdD
X-Gm-Gg: AYBFou06hPKeIo94cK0HGWhicAlGUL7Q9GKXEBPliCeuNd1kv4E6zVWUUE2Pzq4Wzsn
	amkqEtjJ/qVCJ81J4oQAjdPhr7emHXkcyJ0wocYkjcRGPJSPZ8wlERQbCnZDLPCPcjYpS7yFFyt
	Fws/HLzP3bZf5lyMoLAx69ECDHHO/HuZb0WRfDVDcinawabNkQtnWn49RPOj3zqtXkBw9I2e5La
	fRzr510UQyYajmC25yey9ujNb5A95J8Erirryk5nLp4eBF/sQSC3wQrBz7uiD1GLNNRF4QNSQCk
	uj5a1dIYoRaaz7/oXBF0dFu12WPZRZCJXa1uwP1cir1iPoLyoZwRO/JvpQwoaptSJWNMkkUJaWz
	v8LNkbW1qY5KWtk2FdLxzJ9ann91U0ANA3M1fD5NXNfOJQ45TZvVwEzdgS4tWi2D9A0SJJyYM4L
	VzLL+GZcQQNflNZmAsUpgODBEe0e2rkYy7fLrl8Jpb5o3m8h9TI8Wc19VDHAaJQJFQc9CeFXQ+2
	w49btd3ON/EbfWABsP6vaufk7kBpWMCyLOIiM0ebumncrI2hB/hKbjOFXDYJlmhBRx4weuEQGVR
	Rj2DlAp7Nw==
X-Received: by 2002:a05:6a00:bd88:b0:870:8e80:3ac0 with SMTP id d2e1a72fcca58-874dc7ee0b6mr9710984b3a.11.1789851985650;
        Sat, 19 Sep 2026 14:06:25 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a94f8c39sm1278054b3a.28.2026.09.19.14.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:06:25 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net/sched: ematch: check nla_put_nohdr() return value in tcf_em_tree_dump()
Date: Sat, 19 Sep 2026 21:06:24 +0000
Message-ID: <20260919210624.3030344-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tcf_em_tree_dump() was converted from the legacy rtnetlink
`RTA_PUT_NOHDR` macro (which contained an implicit `goto
rtattr_failure;`) to `nla_put_nohdr()`, the return value check on
`nla_put_nohdr()` was omitted for container/simple matches and raw match
payloads.

If the netlink dump skb runs out of tailroom at `nla_put_nohdr()`, the
error is silently ignored and `match_start->nla_len` is finalized
without the match payload, emitting a malformed/truncated
TCA_EMATCH_TREE_LIST attribute to userspace instead of returning `-1`
via `nla_put_failure` so rtnetlink can reallocate and retry the dump.

Check the return value of `nla_put_nohdr()` in both branches and jump to
`nla_put_failure` on error.

Fixes: add93b610a4e ("[NET_SCHED]: Convert classifiers from rtnetlink to new netlink API")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/sched/ematch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sched/ematch.c b/net/sched/ematch.c
index 5c1235e6076a..563feb1011f2 100644
--- a/net/sched/ematch.c
+++ b/net/sched/ematch.c
@@ -470,9 +470,12 @@ int tcf_em_tree_dump(struct sk_buff *skb, struct tcf_ematch_tree *tree, int tlv)
 				goto nla_put_failure;
 		} else if (tcf_em_is_container(em) || tcf_em_is_simple(em)) {
 			u32 u = em->data;
-			nla_put_nohdr(skb, sizeof(u), &u);
-		} else if (em->datalen > 0)
-			nla_put_nohdr(skb, em->datalen, (void *) em->data);
+			if (nla_put_nohdr(skb, sizeof(u), &u))
+				goto nla_put_failure;
+		} else if (em->datalen > 0) {
+			if (nla_put_nohdr(skb, em->datalen, (void *)em->data))
+				goto nla_put_failure;
+		}
 
 		tail = skb_tail_pointer(skb);
 		match_start->nla_len = tail - (u8 *)match_start;
-- 
2.55.0.1082.g2b9226bbc0-goog

