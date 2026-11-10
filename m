Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321668;
	b=wRpXMZHqhoJXyK3G8K8vr3LbQ9K1uMYZ1LsGa0Y1NAdHiCzqF10/QdmOXA5Moov5dB+I
	 GKFhwC9lRLtfZQVdmSclL5aMWB8ykCbX7BZ6CanEDbZGHRgFI9BXt6/ZF3ttkZAMV/rHW
	 l6qpJWnlE2GFJWVyo3vW86JGkvg5NPluCllHzd+ZdaLLb7bM8plUk4eg/k1/abNT4Knkm
	 wkcBPZLRNOAh3EHMH1Qvc0pANBz35ptztk96z5ic9+uwcLHGhMfeyECxCGvQWhL+Y3m01
	 5Sw0CciOxxMLK79d6Hicmom21arucy3GMZSuUyiNUE4+3jAbZmH1d6ZaljraP17ixgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ozefx5HBxcjSqzK1TQHH3peHGbgubmX+WmLQsJVYK0M=;
	b=3rzsrA9RPxCFWhFeskKi3qS3j2nd+iwaphAmAlH0dtQGaahf01DVSIAw7y7QSq4/azG5
	 Paf+pFbejkG8EfzsiWD9sm7adKaweaqKnQISc1zSgrUY9CWyo9f7H1ypeuLUJX0h5/5NU
	 gxuWHt2npeWScuQvHI6afft02ahq4Aa1mL8Jeh/+9KJSZDA2y6lZxd8ljBTsZ2w88rCC0
	 W0X6RwDuqruz0K6u0bmFe/6z7CY9vXgoKohM+ub70u2n+rkGAxJY0/uHsY61lWpwrs9nW
	 oSEUJYBekezK48fqdbW/u+8d6XiSbJvEaJsWRCtXjk63MIVKHtgXE58UtuUimqMrN2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JXNC0oQa;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286760A2615
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E286760A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=JXNC0oQa
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ecbdf5343so23101926d6.0
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321667; x=1794926467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ozefx5HBxcjSqzK1TQHH3peHGbgubmX+WmLQsJVYK0M=;
        b=JXNC0oQaMlJAZRqID1CR21iCMpZjmfC9Vepubz85nHEXDgOwEM5Z7q1NzvmKf0aMGJ
         cmjUnCiEiCKDdYoxCVVcmdCYbO5o4naDoaNDtnElJg0PHBGieJCFQik8c8vwpPiKvVn6
         ZudfoF8P2W2phEc1Nzi7Go57Rf8BCX88aukRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321667; x=1794926467;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozefx5HBxcjSqzK1TQHH3peHGbgubmX+WmLQsJVYK0M=;
        b=oTqRnPocprBpACRHWAmAkCzxNLTX4R3IvD/L6VmGijtTz8vpHBwLN5HR1xvpOmKEbA
         XQaHuVAvk4tnNipldI/1VT+oSXe8CrgjO6zn2hZgcxpVHJtDndBaiiBOulRGOADOEmZj
         jJjtU6UOkolxOmuwfuzLE4bjKMQZlbQ1O85QhunrmZOVd1guX31IyZMYZnXiCjBXreUz
         CHUmQRR3CWQQQxXJBLZYIBJMczRn+arnqw2/xOlwSbLwWg6/f+D0Zqr+QU/8JD0rIXpB
         Lvz6Im7qOrb2MpQoIH9LJj+vXS1o6QRG0LJrGP+DEcMx/CSiyxNgc6QyZkLy5AE+q/sX
         RtQg==
X-Gm-Message-State: APuU4Z+5OZqr04IMOrDxAlvp0x6eHcrzdMo07KMys2HVwtbcwUGJLBF4
	az9vOnRY898/B+wN5G72jm6hCZt7u1nyo+cxscoC+PLlBRvWRrA8ushFRsrhLV1hRG/dM1GnO7D
	JDwM=
X-Gm-Gg: AYBFou0vAtOd07+6iUbn3IqpxjDmWaiqvkRT2lae31dRiY4D6OXm7CSpq8HNG2p1YuA
	U5em6bqVHcBmpRAWmtRhT+paSGzXqPCzOf5/Eoojrq4v2VHndJ4PYYkz8RJk8zqF2KtoFuThLc9
	d010Ksm+/p9s2k0TsX+++1Mbxeu3zWAVZ7+4tahYxFa/RjP5AR4QApusKHErwBklkjZnLIkNJ5f
	itzZPaO4KH5p8XP79P/HxX8t1XAOGBsuMxn6F3tbMT7mEOJwO08FJCGIC0KVgsFeX7rk7fpEyTS
	M7VnXusaS+ckCwjn5kxO0NK08mbvm53pHaECaP/g3f+MN2ovaoztRdyQDh5tqxwF8FljQFFhdyU
	Ll7HKWEbNZgPV1mfsqqCgOL0lWCTgcZ+tfxPNzbd/ZnXFATs3JwnkpS5b7ZwEJW3pPDQvs4LHK+
	1FkeTM8ik1dIHMQvS4n9KK4NWqgEvlcIyauwCQS0tNeqReTxHtpdExoPybYnFjlzIwlKMWVRoxP
	L/vN829FBeHWOqH+UpxTlBmaHBl/Y+yKvtbKTEoozPFSpbQT2u+g3y82bk+Mvj0mb/g1iTpzDl9
	AcErRhyeoqtGYy9mEbbTPoxwCZxLpfMtUtY/ISUmtGvNf8jIUkl6B6b8F536dxXUYMrlEIrcH8w
	=
X-Received: by 2002:a05:6214:3189:b0:91e:b7fd:8ce7 with SMTP id 6a1803df08f44-91ef04ee444mr39223216d6.28.1794321666685;
        Tue, 10 Nov 2026 06:41:06 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f00f6eb88sm1679276d6.39.2026.11.10.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:41:06 -0800 (PST)
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
Subject: [PATCH net-next v9 4/4] net/sched: cake: hash before segmenting and reject an overlong split
Date: Tue, 10 Nov 2026 09:40:55 -0500
Message-Id: <QDISC-BA27.v9.r0.20261108195325-4@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
References: <QDISC-BA27.v9.r0.20261108195325@mojatatu.com>
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
core reason. The segmentation-failure return has the same aliasing and
uses qdisc_drop_reason(..., QDISC_DROP_GENERIC) so its drop is still
reported as a qdisc drop.

Read q->config->flow_mode once with READ_ONCE() in cake_enqueue() and
pass that value to both cake_hash_keys() and cake_hash_resolve(), and to
the later flowchain calls (cake_get_flow_quantum(),
cake_inc_srchost_bulk_flow_count(), cake_inc_dsthost_bulk_flow_count()).
cake_mq_change() updates the shared cake_config outside the qdisc lock, so
a reconfiguration could extract and resolve keys in different modes.

Conditions to recreate the bug:
  ip tuntap add tun0 mode tun
  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  # hold the tun fd open without reading so the backlog persists; a stab
  # overhead of 1048468 accounts each 92-byte packet at 1048560 bytes, so
  # 4095 queued packets leave 65519 bytes below QDISC_MAX_BACKLOG.  A
  # 65000-byte UDP_SEGMENT payload with a 1400-byte segment size then has
  # a segment sum past the remaining headroom, and cake rejects the whole
  # split.  Setup needs CAP_NET_ADMIN; the payload itself does not.
  tc qdisc add dev tun0 root handle 1: stab overhead 1048468 \
      cake split-gso memlimit 512Mb

Link: https://lore.kernel.org/netdev/179231933068.3135.80340792633077986@kernel.org/
Link: https://lore.kernel.org/netdev/179269577270.3135.16072065138845192450@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v8 -> v9: use qdisc_drop_reason(QDISC_DROP_GENERIC) when segmentation
fails (__skb_gso_segment() has already clobbered the drop-reason slot),
and pass the flow_mode snapshot to the later flowchain calls.  (Sashiko
nipa review of v7)
---
 net/sched/sch_cake.c | 130 +++++++++++++++++++++++++++++++------------
 1 file changed, 94 insertions(+), 36 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 3fd13bf6f3ce..74e2b09971ee 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -709,19 +709,28 @@ static u16 cake_get_flow_quantum(struct cake_tin_data *q,
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
@@ -756,50 +765,64 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
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
 
@@ -1765,13 +1788,17 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
 
 	/* Classify first: a terminal verdict means do not enqueue. */
 	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
@@ -1788,12 +1815,50 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
+			return qdisc_drop_reason(skb, sch, to_free,
+						 QDISC_DROP_GENERIC);
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
@@ -1820,14 +1885,9 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
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
@@ -1841,7 +1901,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_qlen_inc(sch);
 			numsegs++;
 			q->buffer_used += seg->truesize;
-			slen += seg->len;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
@@ -1853,9 +1912,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
 
 		qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
-		consume_skb(skb);
 	} else {
-		/* not splitting */
+		/* not splitting - skb pointer still valid */
 		int ack_pkt_len = 0;
 
 		cobalt_set_enqueue_time(skb, now);
@@ -1949,7 +2007,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count + 1);
 
-		WRITE_ONCE(flow->deficit, cake_get_flow_quantum(b, flow, q->config->flow_mode));
+		WRITE_ONCE(flow->deficit, cake_get_flow_quantum(b, flow, flow_mode));
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
@@ -1958,8 +2016,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
 		WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
 
-		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
-		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
+		cake_inc_srchost_bulk_flow_count(b, flow, flow_mode);
+		cake_inc_dsthost_bulk_flow_count(b, flow, flow_mode);
 	}
 
 	if (q->buffer_used > u64_stats_read(&q->buffer_max_used)) {
-- 
2.43.0

