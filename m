Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FF4B1CF4
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971748; cv=none; b=HaioietVlTma/VZ4eL6bmrMQ9WFkQgew5pB3iWlfo3xZ5GXHc5eC9B8CCDbLfcOwf5Wa/Y6dApzF7wooN6FKtFWlv5a/nwXweRuFAG7VK+PxfFc83LelDSCcu2bb81ClDHUWIskqM1AVLDgBSCxaKuiPPg+iN8Xv4VjvCFH1r5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971748; c=relaxed/simple;
	bh=tanxS6+EcsXYKTB++mJJ3P2qch+jbMnDPaq085HiUK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jae4I/QORHSsI2CjRWYwbDS6cBFsDRnbIcXI2SXfLDFtPdRVlRIR0yXwtrlx1AQCwLIPr6AkPgff12MzShJUiEBlO2MSD7lBYhqQkii7nMw4zdmCjRbIVzc36ShQ6Ov9eS22uF+yMajhrdhmU0biO5tzM35liJsGsA3qTZeY1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=DQBLnfx0; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="DQBLnfx0"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93e441e14a1so14148385a.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791971745; x=1792576545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8amoaRo5x4tOQa/4NouaEJxL8CWcjy+23IoAkOoXYhw=;
        b=DQBLnfx0CHpWA39OuBKb/qF96Tuo3JOp4vGUxp96ODBMac/BwiAF76d5ibWYJr24Qt
         SuYyjsLXUYM4lAnVoFCvMiqX+dTci0QM38x75fW5CwkiGj2Oze/CWNgccZf0/V3GXTjS
         7bO3mTH+aocir/kaXgN/eWxCH5JpYBwskNM14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971745; x=1792576545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8amoaRo5x4tOQa/4NouaEJxL8CWcjy+23IoAkOoXYhw=;
        b=J0Wpcm3hqMeu7D1fP1qJB1DKwu+aFdRZr7MEPaSPT4/qUZmo8R4o7g0S2B6DDIbwR2
         MlvUvNpZnoHqnxlst2q8ltPo9p1iBRZ5/RuCBvSQlVFMCHJzGMHQqoYm6Nqm0VdHzYut
         ekquaAEurXINn5L16ByQZg+TwNyYyOKZDy87BKCzw9lKhx6+2tujvEdsXmmCNYvnWqHf
         xKEhrppF4A1IKURijp93+OGTUyeQRhUHg+GUjRW6hhmj3ZvZ7/DE5Ehqzi/auGFnlxRD
         qloDu74oC/sFPGRvvnvtwWNeFMwtdh5w4nethCJAD4xc6tETZC7tqYfm17mI8FebNtDu
         hVHg==
X-Gm-Message-State: AFq9FYKenwHVhZgA7habRhX2Rv+JLCTFNCeJ8MlsFznMzsq5q7MnEKoY
	2xvnySMw9QKls8UHN9s6VWgysj4Wy7x5HbWI3Lo9AUeHw5UPptkE3PIjuLh+9D4jMAZotdxZwgW
	VVcA=
X-Gm-Gg: AYBFou3+koH+qn4LJDDAJn/b0H3GC3BbtML9eV/bLjTmDitEuxy583KNolaNRv+KKoa
	IklIKnx6DTY7kUCcBvqm7ioG9Yy5W6baiYqW8BU9AAjN6uTr9T79HG2Fohtf8EiXhpy1rpmI8+X
	AUKLpmcfr/kCBCv2lmE1tyuB6HSLWBiAWQkaXlR8Ib0S1LLvkp2Gz50AuEvTToRECh5SbQMnTL6
	oJSZf1wDLAsRaGZ592YCbKmWLBBesGBkbLLTryPIaV07VMb0uRe7sDEldQ8iqC0kW2bxxP+yI6b
	g2FfWSQtDuRf+uQIngK+KboFazptFHKW3AXAW3wVEAmXznZEYh0+c9mXgVqqI8eLfkFtqfj2Fab
	PQ0xQrqASLUJAcdmcHhYok4s1LV+G0ru6lrNQ1s7DqR5Qvr+JaeD9WGN3gi/dm1KDxRbZZUlNbH
	7y5L0Mpz4qPS8pjnAmw7YB0elb79JWCX6E9feixVa7Ni70jkyDrv6hJxI+QBzRJ16RRseWuYmHw
	BGgD2kujJaFKaF17pEiNhVH72iXEps00CsglqBZqapBPYA26qcjLQens2b/
X-Received: by 2002:a05:620a:2612:b0:93c:9eb3:9f04 with SMTP id af79cd13be357-93ebd0e41c3mr2334903485a.9.1791971745267;
        Wed, 14 Oct 2026 02:55:45 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5055eb3sm453074985a.33.2026.10.14.02.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:44 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v6 4/4] net/sched: cake: hash before segmenting and reject an overlong split
Date: Wed, 14 Oct 2026 05:55:32 -0400
Message-Id: <QDISC-BA27.v6.r0.20261014054826-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
References: <QDISC-BA27.v6.r0.20261014054826@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Fix:
with CAKE_FLAG_SPLIT_GSO, cake computes the flow/host hash keys, then
splits a GSO skb into segments it accounts individually. Key extraction
must run on the unsegmented skb -- skb_gso_segment() can rewrite an
encapsulated packet's headers to the inner ones -- and the resolution
must wait until the packet is admitted, since it commits the
set-associative tags, host indices and way counters that a later
rejection would leave mutated (a GSO skb whose segmentation fails was
dropped with that state already committed).

Split cake_hash() into a side-effect-free cake_hash_keys(), run on the
unsegmented skb, and cake_hash_resolve(), run only once the packet is
admitted. Move the split-GSO path ahead of the resolution: sum the
segment list, test the total against the ceiling before linking any
segment, and drop the whole list on rejection so no persistent state is
committed. The list is deferred to to_free so the tail segment's
sock_wfree() never runs under the qdisc lock; a fraglist GSO, where
skb_segment_list() returns the original skb as the head, drops the
caller's reference and queues the list once instead of self-linking it.

Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v5 -> v6: split out of the single v5 patch; the hash logic is unchanged.
---
 net/sched/sch_cake.c | 126 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 31 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index adfe11737c66..c67db1c61a90 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -706,19 +706,28 @@ static u16 cake_get_flow_quantum(struct cake_tin_data *q,
 		get_random_u16()) >> 16;
 }
 
-static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
-		     int flow_mode, u16 flow_override, u16 host_override)
+struct cake_hash_keys {
+	u32 srchost_hash;
+	u32 dsthost_hash;
+	u32 flow_hash;
+};
+
+static void cake_hash_keys(const struct sk_buff *skb, int flow_mode,
+			   u16 flow_override, u16 host_override,
+			   struct cake_hash_keys *out)
 {
 	bool hash_flows = (!flow_override && !!(flow_mode & CAKE_FLOW_FLOWS));
 	bool hash_hosts = (!host_override && !!(flow_mode & CAKE_FLOW_HOSTS));
 	bool nat_enabled = !!(flow_mode & CAKE_FLOW_NAT_FLAG);
-	u32 flow_hash = 0, srchost_hash = 0, dsthost_hash = 0;
-	u16 reduced_hash, srchost_idx, dsthost_idx;
 	struct flow_keys keys, host_keys;
 	bool use_skbhash = skb->l4_hash;
 
+	out->flow_hash = 0;
+	out->srchost_hash = 0;
+	out->dsthost_hash = 0;
+
 	if (unlikely(flow_mode == CAKE_FLOW_NONE))
-		return 0;
+		return;
 
 	/* If both overrides are set, or we can use the SKB hash and nat mode is
 	 * disabled, we can skip packet dissection entirely. If nat mode is
@@ -753,50 +762,65 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 	switch (host_keys.control.addr_type) {
 	case FLOW_DISSECTOR_KEY_IPV4_ADDRS:
 		host_keys.addrs.v4addrs.src = 0;
-		dsthost_hash = flow_hash_from_keys(&host_keys);
+		out->dsthost_hash = flow_hash_from_keys(&host_keys);
 		host_keys.addrs.v4addrs.src = keys.addrs.v4addrs.src;
 		host_keys.addrs.v4addrs.dst = 0;
-		srchost_hash = flow_hash_from_keys(&host_keys);
+		out->srchost_hash = flow_hash_from_keys(&host_keys);
 		break;
 
 	case FLOW_DISSECTOR_KEY_IPV6_ADDRS:
 		memset(&host_keys.addrs.v6addrs.src, 0,
 		       sizeof(host_keys.addrs.v6addrs.src));
-		dsthost_hash = flow_hash_from_keys(&host_keys);
+		out->dsthost_hash = flow_hash_from_keys(&host_keys);
 		host_keys.addrs.v6addrs.src = keys.addrs.v6addrs.src;
 		memset(&host_keys.addrs.v6addrs.dst, 0,
 		       sizeof(host_keys.addrs.v6addrs.dst));
-		srchost_hash = flow_hash_from_keys(&host_keys);
+		out->srchost_hash = flow_hash_from_keys(&host_keys);
 		break;
 
 	default:
-		dsthost_hash = 0;
-		srchost_hash = 0;
+		out->dsthost_hash = 0;
+		out->srchost_hash = 0;
 	}
 
 	/* This *must* be after the above switch, since as a
 	 * side-effect it sorts the src and dst addresses.
 	 */
 	if (hash_flows && !use_skbhash)
-		flow_hash = flow_hash_from_keys(&keys);
+		out->flow_hash = flow_hash_from_keys(&keys);
 
 skip_hash:
 	if (flow_override)
-		flow_hash = flow_override - 1;
+		out->flow_hash = flow_override - 1;
 	else if (use_skbhash && (flow_mode & CAKE_FLOW_FLOWS))
-		flow_hash = skb->hash;
+		out->flow_hash = skb->hash;
 	if (host_override) {
-		dsthost_hash = host_override - 1;
-		srchost_hash = host_override - 1;
+		out->dsthost_hash = host_override - 1;
+		out->srchost_hash = host_override - 1;
 	}
 
 	if (!(flow_mode & CAKE_FLOW_FLOWS)) {
 		if (flow_mode & CAKE_FLOW_SRC_IP)
-			flow_hash ^= srchost_hash;
+			out->flow_hash ^= out->srchost_hash;
 
 		if (flow_mode & CAKE_FLOW_DST_IP)
-			flow_hash ^= dsthost_hash;
+			out->flow_hash ^= out->dsthost_hash;
 	}
+}
+
+/* Commit the resolved flow into the set-associative table. Mutates
+ * q->tags[], the flow host indices, the way counters and the host
+ * bulk-flow counts, so run only after admission.
+ */
+static u32 cake_hash_resolve(struct cake_tin_data *q,
+			     const struct cake_hash_keys *keys, int flow_mode)
+{
+	u32 flow_hash = keys->flow_hash, srchost_hash = keys->srchost_hash,
+	    dsthost_hash = keys->dsthost_hash;
+	u16 reduced_hash, srchost_idx, dsthost_idx;
+
+	if (unlikely(flow_mode == CAKE_FLOW_NONE))
+		return 0;
 
 	reduced_hash = flow_hash % CAKE_QUEUES;
 
@@ -1763,11 +1787,14 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb), ret;
 	u16 flow_override, host_override;
+	struct sk_buff *segs = NULL;
+	struct cake_hash_keys keys;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
 	bool same_flow = false;
+	u64 slen = 0;
 
 	/* Classify first: a terminal TC action consumes the packet. */
 	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
@@ -1787,12 +1814,55 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 					 QDISC_DROP_OVERLIMIT);
 	}
 
-	/* choose flow to insert into */
+	/* Tin selection and key extraction run on the unsegmented skb:
+	 * skb_gso_segment() rewrites an encapsulated GSO packet's headers to
+	 * the inner ones, changing the keys. Neither commits state.
+	 */
 	b = cake_select_tin(sch, skb);
-	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
-			host_override) + 1;
+	cake_hash_keys(skb, q->config->flow_mode, flow_override,
+		       host_override, &keys);
+
+	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+		struct sk_buff *nskb, *seg;
+		netdev_features_t features = netif_skb_features(skb);
+
+		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(segs))
+			return qdisc_drop(skb, sch, to_free);
+
+		/* The split path accounts the segment sum, not the
+		 * stab-adjusted qdisc_pkt_len(), so the top check does not
+		 * bound it. Sum the list and reject it whole.
+		 */
+		skb_list_walk_safe(segs, seg, nskb)
+			slen += seg->len;
+
+		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
+			qdisc_qstats_overlimit(sch);
+			/* skb_gso_segment() moved the sock_wfree destructor to
+			 * the tail segment; defer the whole list to to_free,
+			 * never free it under the qdisc lock.
+			 *
+			 * Fraglist GSO is the exception: skb_segment_list()
+			 * returns the original skb as the head with an extra
+			 * ref (segs == skb), so drop the caller's ref and
+			 * queue the list once, or the two drops self-link it.
+			 */
+			if (unlikely(segs == skb)) {
+				tcf_set_qdisc_drop_reason(skb,
+							  QDISC_DROP_OVERLIMIT);
+				consume_skb(skb);
+				return qdisc_drop_all(segs, sch, to_free);
+			}
+			__qdisc_drop_all(segs, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 QDISC_DROP_OVERLIMIT);
+		}
+	}
+
+	/* Admitted: resolve the keys and commit flow/shaper state. */
+	idx = cake_hash_resolve(b, &keys, q->config->flow_mode);
 	tin = (u32)(b - q->tins);
-	idx--;
 	flow = &b->flows[idx];
 
 	/* ensure shaper state isn't stale */
@@ -1819,14 +1889,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		WRITE_ONCE(b->max_skblen, len);
 
-	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb, *seg;
-		netdev_features_t features = netif_skb_features(skb);
-		unsigned int slen = 0, numsegs = 0;
-
-		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-		if (IS_ERR_OR_NULL(segs))
-			return qdisc_drop(skb, sch, to_free);
+	if (segs) {
+		struct sk_buff *nskb, *seg;
+		unsigned int numsegs = 0;
 
 		skb_list_walk_safe(segs, seg, nskb) {
 			skb_mark_not_on_list(seg);
@@ -1840,7 +1905,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qlen_inc(sch);
 			numsegs++;
 			q->buffer_used += seg->truesize;
-			slen += seg->len;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
-- 
2.43.0

