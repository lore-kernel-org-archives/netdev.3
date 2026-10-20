Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515463;
	b=zt6iCKd3j24bCgCEPerjqhJtg8+zUSBttZVhwPevlaLLCL/WSjOERI1uZ94H04sRHHs9
	 nzlDaH2Hg0FyFi/JjaOgVQQe8CbmJCors3KxQQKmVTFNjndnKsFAIdOdbQXYdfxTciYqf
	 CPoPZMx3NqxjajUYDYVlIj/jf5cMojZG4hNk+/gAxnBJe1EDCJfSPXjPRRK5DnGPbDdI9
	 zYFx7VebOsTYy+xu6nIJlNufydnoJwqG54/5NaS+TdKFOS9ctGqYdDWC13l6z/M3uQ2NS
	 UrqfKJ5ywelEiojJG4IIstjI5t7hZ7657WJu6jplNxzdrvphD0H4Q9NapJeZlYKgzgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=NgfhOOSrcf71hQzuI2PlCudVWMHX1P6q/EtWLLXXYr4=;
	b=gmT4DegHU4zSGtEEoABQbjl6Ddoti/eooLlXIHjyCdw4gCdXO/JeB1pYFRBYPHuxUB0e
	 PAId7SRhBLt8YfkVxyERpUuHSPjHUNou2sMgkZIjXYO9gx4zDECfjZpZbT8J2YkOr9W+m
	 lZv/l5hIErJTJVbwCfQdFud0KUWDkB98fRPWDQlQ1aFxCt90jN7azMkIzNrBjW45aY2x0
	 vC5l8hBenkYVklTwdvWPRALKnbkiIykThv25c5VMsATkxkhaN9SL5euQHSFCSSoaCUy9+
	 MwTL8bUaCtQBe9S9hEaNZbU9AxgFntrNQPa24u5+BiAtmM2ES9X83Us9bk77Jjdxi6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JlPXcj+H;
	arc=none smtp.remote-ip=209.85.222.172
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24893606A333
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 16:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24893606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JlPXcj+H
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93f560af6aeso29533885a.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792515462; x=1793120262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NgfhOOSrcf71hQzuI2PlCudVWMHX1P6q/EtWLLXXYr4=;
        b=JlPXcj+HBJkrcj/HEfwAcsYRdu8a7kmoFIvIBe9U0KbavoruC16JK+HeSsTKJzugra
         LbdFAm4f3SjN5JoY6wDaAuxHw+lzQg4Qm+msZ49qThUiFjRwLm7rf9/B4qn7aa8NvNVr
         xEVJYd3RGMh/Dro5/ZJmIa68VNX/8j1Ob+Dxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792515462; x=1793120262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NgfhOOSrcf71hQzuI2PlCudVWMHX1P6q/EtWLLXXYr4=;
        b=dEdgLSq84Ifdnp6gFZwYgumzh9Rpi/rMULHPCtW20Yx3dc1k8RoLWkVzgeOdOQb1I8
         f2IfAjtWrwaQ6jg/5Po5G+5jg2kZdny+96/h9D1iKlGlGRQAHcBzA3g+x3GxKi69LoPM
         SCQAlNcGDpEmZ2NVkrea4BiRWHfooFvGOYeJZhkcbF4RG4USyeqdHfGSx+hdxO/GM2sb
         iRsFwNo8iHrf/778liCtw5Mihq9GjiwbguUKcFrbl9TaalJ3CjlKDP2LHKr/QRBEWdFC
         Vp+ZOrRdVViaEkNlbvGAndv2wsGYGdItsZTaA/8+kpsnKur5/KbKbjH7IkhxR69am/6I
         CVcA==
X-Gm-Message-State: AFq9FYKDbcc9xrSg6kfG7SA27D+ab//06Nfm7vWNEuwL4gjHakHkAELe
	3m4bSHEdQ1vm2g0h2lErgIuCxPPnbaVxq65jMXR+682XNN7BUCJMBNjmTujWtaBMkqUhlTXgmHJ
	+jUE=
X-Gm-Gg: AYBFou2O/Kx3d2vxDV9/itMrgCs2212XtBDLXHxS0hliUyEou/2c24+NsXaE9/Ma0d1
	WxWQS0SknI4GxKVhilK/VaGMBaFZq5gB8+j+kyZpgjWjycJOXw6sKyNeWn4y5K4BkZDzu+Co/Gl
	2h+cn4FOjNH+PjiBCaDrb4WxvEJrxhvK6lSjpcOLe17ep4Zyvnlhd6rDs3F4Bk4X5e8f+7LHRe5
	ORZ/36Zq6Fjeojue43NR0Sh4oh3jEVRJhpicyBizAm4h1UbIevhe3zvmIrRMR4BMXiCUoBDZrv/
	2OBUsN2CKKmgXgKAnB7HPcBRzxUbEQ/3o79MXp0schnZre2VDM7qwdT7ES1IZ++ead/48gVKd15
	V7oLb563zUqxhFpsnUu5Hflcedjl/ZBskoINgbqkYz2LNlDNjaVwH/ZYmZdQwywfL2WAI1GRf2f
	uWlD949nv5FVoaAFUzb2yecab6jIb8VpB02AH/N9SABOoSQhKHdKI+sCt5W4+PDyj5J76MmL6GA
	gmm7Ku7uKWoU14t5JeRvWz8Ep/fcW+//4RtiPeiZtzm
X-Received: by 2002:a05:620a:40d2:b0:93c:720c:94e0 with SMTP id af79cd13be357-93f29d36396mr1798506485a.30.1792515461895;
        Tue, 20 Oct 2026 09:57:41 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a441acsm3034586d6.6.2026.10.20.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:57:41 -0700 (PDT)
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
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v8 4/4] net/sched: cake: hash before segmenting and reject an overlong split
Date: Tue, 20 Oct 2026 12:57:30 -0400
Message-Id: <QDISC-BA27.v8.r0.20261020063241-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
References: <QDISC-BA27.v8.r0.20261020063241@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
sock_wfree() never runs under the qdisc lock.

Tag every deferred segment with QDISC_DROP_OVERLIMIT: __skb_gso_segment()
keeps SKB_GSO_CB at cb offset 32, aliasing tc_skb_cb.drop_reason, and
__copy_skb_header() copies it into every segment, so tagging only the
head left the rest with GSO scratch (a headroom-sized value) as their
drop reason, which __tcf_kfree_skb_list() would report as an unrelated
core reason.

Read q->config->flow_mode once with READ_ONCE() in cake_enqueue() and
pass that value to both cake_hash_keys() and cake_hash_resolve().
cake_config_change() writes the mode before cake_change() takes
sch_tree_lock(), and the split introduced two separate loads with the
segmentation work between them; a concurrent reconfiguration could
extract keys in one mode and resolve them in another.

Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v7 -> v8: the original skb is consumed unconditionally right after a
successful split -- the caller's reference; a fraglist GSO takes the
list's own reference on the same skb in skb_segment_list() -- so the
reject branch tags every deferred segment and drops the whole list with
qdisc_drop_all(), the admitted path no longer consumes the skb after the
walk, and both special-case comments are gone.  (Toke
Høiland-Jørgensen, v7 review)
---
 net/sched/sch_cake.c | 123 +++++++++++++++++++++++++++++++------------
 1 file changed, 90 insertions(+), 33 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 91c33295b30b..79d6f6f76dbc 100644
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
@@ -753,50 +762,64 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
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
+/* Commit the flow into the set-associative table (q->tags[], host
+ * indices, bulk counters). Only after the packet is admitted.
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
 
@@ -1761,13 +1784,17 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
+	int flow_mode = READ_ONCE(q->config->flow_mode);
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
@@ -1784,12 +1811,49 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 					 QDISC_DROP_OVERLIMIT);
 	}
 
-	/* choose flow to insert into */
+	/* Select the tin and extract the keys before segmenting:
+	 * skb_gso_segment() rewrites encapsulated headers, which
+	 * changes the keys.
+	 */
 	b = cake_select_tin(sch, skb);
-	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
-			host_override) + 1;
+	cake_hash_keys(skb, flow_mode, flow_override, host_override, &keys);
+
+	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+		netdev_features_t features = netif_skb_features(skb);
+		struct sk_buff *nskb, *seg;
+
+		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(segs))
+			return qdisc_drop(skb, sch, to_free);
+
+		/* we never use the original skb after splitting */
+		consume_skb(skb);
+		skb = NULL;
+
+		/* The split path accounts the segment sum, not the
+		 * stab-adjusted qdisc_pkt_len(), so check it here.
+		 */
+		skb_list_walk_safe(segs, seg, nskb)
+			slen += seg->len;
+
+		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
+			qdisc_qstats_overlimit(sch);
+			/* __skb_gso_segment() puts SKB_GSO_CB at cb
+			 * offset 32, over tc_skb_cb.drop_reason; every
+			 * segment inherits it. Tag each one with the
+			 * qdisc drop reason.
+			 */
+			skb_list_walk_safe(segs, seg, nskb)
+				tcf_set_qdisc_drop_reason(seg,
+							  QDISC_DROP_OVERLIMIT);
+
+			return qdisc_drop_all(segs, sch, to_free);
+		}
+	}
+
+	/* Admitted: resolve the flow. */
+	idx = cake_hash_resolve(b, &keys, flow_mode);
 	tin = (u32)(b - q->tins);
-	idx--;
 	flow = &b->flows[idx];
 
 	/* ensure shaper state isn't stale */
@@ -1816,14 +1880,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
@@ -1837,7 +1896,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qlen_inc(sch);
 			numsegs++;
 			q->buffer_used += seg->truesize;
-			slen += seg->len;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
@@ -1849,9 +1907,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
 
 		qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
-		consume_skb(skb);
 	} else {
-		/* not splitting */
+		/* not splitting - skb pointer still valid */
 		int ack_pkt_len = 0;
 
 		cobalt_set_enqueue_time(skb, now);
-- 
2.43.0

