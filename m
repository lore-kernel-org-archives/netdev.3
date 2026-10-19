Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425658;
	b=ZgsZy6o+zbD2c1guM/t0t3q223iK+x3/F+8Q8V4lOfJIRDeZGucNChcXnImRGEpz7xXo
	 BffVO63VJ6bstW6dlAIYL3c5sTzIw4sp1H/8HRQiMUR0vabsm0POeQDbp/ILz/RVyEhNV
	 7X5CKg7kzGEguXhTRC1CQOS6h9yymklEt7oNL9vibGb8tqzJvTenzYohf4evbdoBSzLlf
	 Hly1ch8oo8CnAYjdUPWyFIRR3x4p4unU0BQfpoCkusJQ2YyHL8yVfvp3m5ax/pyPPHbY3
	 Bu7NzUUj8XKjMoICI9urbPN3yReGLMKIHu2+KCb4xJvvEtVyOAbzuvIvZ2WlWLfDc/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cKS2dTyhA01XmkSWpi13gcyzgdEFBA2w22z0cfu/IS8=;
	b=L/L6vrpRRVFWa6vQF9Qfr3w0aoaL7uJPoDC18XW2/hzQRqoL1/waMYm1lvzTi9KHPPPg
	 /z/rbcHCMFdStT3Lm59WIObZ2ZyR3atu9frk6WUYFeN31zCOTvuSmPII9iBCgpypY0m1E
	 NxcbBNcQhiGmEHSkRb2HZ8nG2QOb5NhpJkPYAoC1YM0UFxzwcAvsvsIUApQT2ndXEZKRA
	 V9NZ5mLkqw6Xd4U8SGe2hJjKhd4aBwc3KelAEqJhAmiL3txl1j7mhCVRkTdvhTcsFicRK
	 0pMvnrvitXwlxe4gHU/KFXfgSqBpl1P16avY8p/+SKBB6VhAbCiRiExQQhxh6n7bKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=uV6QxUwq;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E490A60724AC
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 16:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E490A60724AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=uV6QxUwq
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-917a04338c1so21517856d6.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792425657; x=1793030457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cKS2dTyhA01XmkSWpi13gcyzgdEFBA2w22z0cfu/IS8=;
        b=uV6QxUwqn+nrrzCb+O7cwOaGyPUJBCn+ymYMJbVjK43gWL7HRexjjNqDg5KPZSk7wn
         KXIk0L5gSoXmuIusB9M87m9ptB5nlN4l1fAF2GbGTT4d4v71pGfMhbiTL4msFYwtSftw
         mpt4C/udIndr3rwtx/FumYukCGuwemzF17Sio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425657; x=1793030457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cKS2dTyhA01XmkSWpi13gcyzgdEFBA2w22z0cfu/IS8=;
        b=LGG7jf7UxmVhdJuia9VwKhlTYBAIJ2VotzmvHT9FbHHU7SNYwqfQzyv0TWtp+wxJgQ
         QIiTAW+ljCwd1XgYfV73s9T3qxTNCrh/QQwJb+UioWiEecUsavJmu7O1Rd0rOLchCozC
         l4rdpAK+S/uF/1KM0QEVnwirHekPj0htlwGkuFVP8tGyTiln7Ty3rx+2ZHLz39z0N/R3
         ytPRde9M1t4cIrzUhJ/Eh63keCH8qW0kT4DDwt7vMNwgEsxWvX9WqOagbpBXGxJCXze7
         KstTlsNfT5OP7CNbBk1EMuw8tWO5TLBbAjzuN7cmeWMLXkoHkaKU1AqH1AeBqfdjXAEm
         Y6Pg==
X-Gm-Message-State: AFq9FYIUp5so/n4dMWZ/+DzONEI68IimQkYnfJk6q9ZRy9CTkxKx0Dw2
	2HN6pxYF1mjELtocFJmEy5mAiqVAmrcYsEojAZYMwRFOfj3zKq/Cm3VuD3naCspn2Tbh9jeJmBp
	uDqc=
X-Gm-Gg: AYBFou1y7DxsWdRBGLZXpkeB0gWVw8ccU6zz7p8fX4FDRWVVdasDKkgk32T84dnDLo8
	eQ/di131wOHigE2eaVVnNB/o47FINuIuhMOLT1g+f7OGPS+Tkqd+04omGRad3XnfXYKVee1z1U7
	SergOJSnO4a7T9WMxUz5x4WTwkb+pQUbo7HwjipZYty2CubkYPt7cnmE+au3tnori1fnqRkYIJY
	U30JCcOGGPzsav1uedxC4yYZkqZs7YwqXI/jaW93AfJo/BzYaBMZlV+dCov98Evbva8e0LK1M3c
	CZvOfhqwDZrJSyYw2yEr1PEoM9yJihMoeayd3MMj8Ery8PW0fE5qcQq5nztLWm2IQwVJvwzOwLM
	jlRFk4VhIL22ONs5ElsqUvripMMJ+//vcUsZ1BnBXMl1UD4SlqPJVHTqhFvWuCqYCY1J3jZ7aYh
	3jWGTJALWY6ZIlNwg7e+4bEIJxUFZv+1wGmnB0Vr3S30NX3q+DGwxAChe6SU/prHy/wZBN+C3zB
	XY/fcv9hCLNTJ1sehYqoqxJpyNOm8mroyTVBh/5fnE1
X-Received: by 2002:a05:6214:5904:b0:91b:7656:ffea with SMTP id 6a1803df08f44-91bdf195a90mr133081436d6.35.1792425656552;
        Mon, 19 Oct 2026 09:00:56 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91be9d8acb5sm64846846d6.0.2026.10.19.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 09:00:54 -0700 (PDT)
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
Subject: [PATCH net-next v7 4/4] net/sched: cake: hash before segmenting and reject an overlong split
Date: Mon, 19 Oct 2026 12:00:35 -0400
Message-Id: <QDISC-BA27.v7.r0.20261019115505-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505@mojatatu.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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
v6 -> v7: the split-GSO reject path now sets QDISC_DROP_OVERLIMIT on
every deferred segment, not only on the head/original skb; the GSO cb
aliases tc_skb_cb.drop_reason and is copied into every segment, so
untagged segments carried GSO scratch as their drop reason. The
flow_mode is likewise snapshotted once with READ_ONCE() and passed to
both cake_hash_keys() and cake_hash_resolve(). (Sashiko nipa v6
review, gpt-6-astra-2-5, gpt-6-astra-5-9)
---
 net/sched/sch_cake.c | 130 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 31 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 91c33295b30b..730c90af14bd 100644
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
@@ -1784,12 +1811,59 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
+		struct sk_buff *nskb, *seg;
+		netdev_features_t features = netif_skb_features(skb);
+
+		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(segs))
+			return qdisc_drop(skb, sch, to_free);
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
+			/* skb_gso_segment() moved sock_wfree to the tail
+			 * segment, so defer the list to to_free rather
+			 * than free it under the qdisc lock.
+			 *
+			 * Fraglist GSO returns the original skb as head
+			 * (segs == skb), so drop our ref first.
+			 */
+			if (unlikely(segs == skb)) {
+				consume_skb(skb);
+				return qdisc_drop_all(segs, sch, to_free);
+			}
+			__qdisc_drop_all(segs, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 QDISC_DROP_OVERLIMIT);
+		}
+	}
+
+	/* Admitted: resolve the flow. The mode is read once above, so
+	 * extraction and resolution agree if cake_change() intervenes.
+	 */
+	idx = cake_hash_resolve(b, &keys, flow_mode);
 	tin = (u32)(b - q->tins);
-	idx--;
 	flow = &b->flows[idx];
 
 	/* ensure shaper state isn't stale */
@@ -1816,14 +1890,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
@@ -1837,7 +1906,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qlen_inc(sch);
 			numsegs++;
 			q->buffer_used += seg->truesize;
-			slen += seg->len;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
-- 
2.43.0

