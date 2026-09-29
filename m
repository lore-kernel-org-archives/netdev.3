Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D4654856E
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706829; cv=none; b=ZPCRJA4o/SOLTV2mT/k/VQh8IcXFtKIueFj493Dv6LeTOUB+WZ1TKAaiKnjs0cMSPVDzyLXGq7TKAeER/BamXjcXd8mlUiRoQYOZsXqTXj10eUoWgReRIKV8pRdr1K1YEA9/xvc3OOJh/SH6Qo0/9NJMQfKoUhcef6x8mG26trI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706829; c=relaxed/simple;
	bh=UX3yQArKYdZ/6YyOXam8fPqMIH4DqhloU3etOANGjhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rzvIHuCZndrclsnDfmqFMs1B7kxL5kRyREKhUxSnN+1i8lsGCmgaOiya0UwAUg6mE9K02z+1hIDRPxWqNfz5XOauXpFE2uG2+fuSCled73siViS484xnL9aH/avYSFbzD1thL0V5CPlIM771snyNunQeuN4uRhdcrXJGVgBBEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=JROFp/08; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="JROFp/08"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bd580489dso349689585a.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790706826; x=1791311626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ae5Bk7n3tLzBenitcxI1hFKGKGzPW0L1rNPTSB0Jo1o=;
        b=JROFp/08Chg70dSAf2QJBHwKwRAe8/HiRPMLPcbb8B7jKHnxa3GvMJhdGWjYWKtZl7
         LxpAKA7pSJoca6o0eqdt4tE9BidYOrJbWu4Qi142JU1GNLi2js2Hz1POIk57yNsJHZex
         ikPSc7hkOLykC7PPWU/fYTQtFTHx4e3x66zrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790706826; x=1791311626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ae5Bk7n3tLzBenitcxI1hFKGKGzPW0L1rNPTSB0Jo1o=;
        b=aZfPSeekWCZzCYv4azsOx/OtSMc31gof1+BbGwCjaHgMa/2FERVf2Zx+E3jdgB8NS3
         FiHezG0yLdF93ZQ/IhbQwL14ZeuFmVawAkrYkdaBUmna+ZcYepENQHueCqly7JZKVjER
         nmfEG1qvsuRR7Dmdh9t3iMZG4DbrwUw5V8RaSekq3Q+P4AATKkGSKsIszpHSRZPCV0qo
         PGQew29NGsHNk+ooXzGsht20i5gKDybCArt4uxhwHtg8yCYuY2vj/VAgbJYZAiFB+8zk
         QBRbkhS8ml33a5NRRlvNMZ/95JCE0P36DiaUU+859CjRKF4TjDETqPdUMqe2HT33bSlM
         wFEg==
X-Gm-Message-State: AFuF++mCrQFLNtjdyeGrIHNAdSxgmkRO54AXm+53hg7EnmmTrAQIQtH3
	zDGuj0WFQCfRnWMaCAggF+aBOjxzsVBcs6kg8IoCzjPcJTeKb8splWkqmxGmE9ylYTOC6rQVbgZ
	8Hpaxww==
X-Gm-Gg: AYBFou32oolb9xCPlxfDPxwkO2kVxwBUbPDAGaDW4GSkk9sfn9n/1k+nxds90iRlDwy
	18HncLKZ3bSfVsemhrvZVguCKrdqZ7wKOrEQCCOKX5kfJepc5/LJELYKPbJcZI5SNxpVIl5xNg7
	CQUIKhl5vHIeGWA7BdXvuSH5/eN5BIE6qXGvnEIKUS9WUSXkCIa+CwvdT5Xau/gYXXj7G+sm0XQ
	6tnrcizCRs2zo7X/nCAnX3f++VRB4XeUJtKgjzvyrsYF4KGJOQi7RdCICBQ8DvwHscmaY1ydwDf
	LC7Kd2u6JJBa1es9UzmMqLwV5SCdHAPER9a+02849veug1hUTlk3PuC964H5FykK6XIeM2LGar9
	54DE3LMY+2FsFy0D4P85c0UMgzI6WvfLLWP8RWJr5bDOe9MijVkobsLD4SR9tugNrTu5aLGe6Et
	yBj5UzKc9l6JDhrCT26WqJJ8bPA2q+9XGDcKvWpr14qIwBfwsqo34K48he+DoSBSJ6Y628ogdzL
	SKK5GPwX+Ejvg92gs3bitdqA4TB43cYWLlutD/M1b8Bz+hQBA==
X-Received: by 2002:a05:620a:2851:b0:939:9f51:29a0 with SMTP id af79cd13be357-93c9f91ea85mr81456785a.50.1790706825699;
        Tue, 29 Sep 2026 11:33:45 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917987aa25bsm1644486d6.11.2026.09.29.11.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:33:44 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	moeller0@gmx.de,
	cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next v3] net/sched: cap the accounted backlog before it can wrap
Date: Tue, 29 Sep 2026 14:33:32 -0400
Message-Id: <QDISC-BA27.v3.20260929142417@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to an issue found by Sashiko (nipa) during review of
commit d9ebd8f9aa8b ("net/sched: fq_codel: clamp default quantum and
mtu"), part of the quantum/mtu overflow series merged as a687f2ae995f.
Clamping the per-flow quantum and the CoDel mtu does not bound the
accounted backlog, so the per-flow backlog wrap the review flagged
remained.

fq_codel, cake, codel, pie, fq_pie and dualpi2 account every enqueued
packet's stab-adjusted length into a 32-bit sch->qstats.backlog.
fq_codel/codel use it to decide if they should drop a packet at dequeue;
cake uses it to prune the longest-flow heap from per-flow backlogs; pie
and fq_pie use it to make early drop decisions and dualpi2 decides
must_drop() on it. RED can decide on a child's backlog based on it.
A crafted tc size table (TC_STAB) inflates qdisc_pkt_len() up to
QDISC_PKT_LEN_MAX (1 MiB), so a few thousand packets wrap the counter
mod 2^32. The AQM then reads a small backlog and makes the wrong drop
decision, and the dequeue-side subtractions keep the counter corrupt.

In fq_codel the wrapped value is worse than a wrong drop: a wrapped
q->backlogs[idx] can leave fq_codel_drop()'s strict '>' scan selecting
idx 0 while flow 0 is empty, so dequeue_head() dereferences a NULL
flow->head (sch_fq_codel.c:118).

Fix:
Drop at enqueue once the stored backlog is within QDISC_MAX_BACKLOG
(U32_MAX - QDISC_PKT_LEN_MAX) of the wrap point, the largest backlog one
more maximum-size packet cannot wrap. Test the stored backlog itself via
qdisc_backlog_at_max() rather than adding the incoming packet's length,
so there is no per-enqueue 64-bit add and the 1 MiB headroom already
reserved by QDISC_MAX_BACKLOG is not counted twice. This follows the
existing bfifo approach, which bounds bytes against the accounted
length; gred is a precedent only in WRED mode, where it bounds the
aggregate, while non-WRED gred bounds each virtual queue. The fixed
qdiscs' limits are packet counts or otherwise do not bound the aggregate
bytes. pfifo, reachable standalone or grafted as RED's or SFB's child,
is fixed too because RED reads a child's backlog into red_calc_qavg().
RED's guard bounds only the primary enqueue: a child that segments a GSO
skb (tbf, netem) still grows the parent aggregate through
qdisc_tree_reduce_backlog()'s unclamped byte delta, left to a separate
change.

fq_codel and cake both expose an optional external classifier whose
terminal TC actions (STOLEN/QUEUED/TRAP/SHOT) consume the packet without
enqueuing it. The ceiling check runs after that classifier and its
terminal result, but before flow-hash/shaper state, so a redirect, trap
or police action keeps working while the backlog sits at the ceiling,
and a packet about to be dropped still does not disturb the flow hash.
Only a packet admitted past the check selects or mutates a flow: for
fq_codel the guard precedes fq_codel_hash(); for cake it precedes
cake_hash() after the DSCP/wash tin selection, and the filter's
flow/host overrides survive to that call. fq_codel's external filter
selects a flow only when the result's minor is nonzero and no larger
than flows_cnt; a matched filter that supplied no class ID (classid 0)
is the no-flow result and the packet is dropped, as before.

CAKE's SPLIT_GSO path accounts the sum of the segment lengths, which a
stab recomputes from skb->len and can exceed the pre-split
qdisc_pkt_len(). The list is summed before any segment is linked and
rejected as a whole before cake_hash() commits any flow/host state, and
the whole list is dropped via to_free so the tail segment's sock_wfree()
never runs under the qdisc lock.

Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
CONFIG_NET_SCH_FQ_CODEL=y.

  ip tuntap add tun0 mode tun
  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
      fq_codel flows 1 limit 20000 ecn
  # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qdisc
  # backlog persists, then send 6000 packets. At 4096 resident 1 MiB
  # packets the counter wraps; the unfixed kernel then reports a wrapped
  # backlog for 5969 resident packets, the fixed one drops at the ceiling.

  # RED with a grafted packet-limited child reads the child's backlog the
  # same way; the default bfifo child is byte-limited and safe, pfifo is
  # packet-limited:
  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
      red limit 1000000000 min 5000 max 10000 avpkt 1000 burst 32 ecn
  tc qdisc add dev tun0 parent 1:1 handle 30: pfifo limit 100000

  # a terminal action at the ceiling: fill the queue as above, then
  #   tc filter add dev tun0 parent 1: protocol ip prio 1 matchall \
  #       action trap
  # and send more packets; the trap action's stats must advance.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+99jPh7JjZf=G3Ouaom2tuOtAEiHUf2MEsRdVPd=nz4w@mail.gmail.com/
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3  fold the v2 review (Eric Dumazet) and Sashiko gemini v2:
  - Test the stored backlog via qdisc_backlog_at_max() instead of
    (u64)backlog + qdisc_pkt_len() > QDISC_MAX_BACKLOG: no double-count
    of the reserved 1 MiB headroom, no per-enqueue 64-bit add.
  - cake: run the external classifier first, honor its terminal TC
    actions, then the ceiling check, then cake_hash() and the shaper
    state; the SPLIT_GSO segment sum is checked before any flow/host
    state is committed and the list is deferred to to_free rather than
    freed under the qdisc lock.
  - fq_codel: run the external classifier (terminal actions honored)
    first, then the ceiling check before fq_codel_hash(); document the
    fq_codel_drop() NULL flow->head consequence.
  - pfifo: same ceiling guard, since RED reads a (graftable) child's
    backlog and SFB's default child is pfifo.

v2 approach rewrite per list discussion of v1:
  v1 approached the wrap by widening the per-flow backlog counters to
  u64. Eric Dumazet rejected the framing ("Storing 4GB in a qdisc is
  absolutely insane") and asked for a drop at enqueue once the backlog
  approaches the wrap point. Sebastian Moeller noted tc-stab is the
  generic overhead-accounting mechanism, so the fix must not penalize
  normal stab use.
  v2 replaces the u64 widening with an enqueue-side pre-check against
  QDISC_MAX_BACKLOG and drops with QDISC_DROP_OVERLIMIT. No counter is
  widened, so the 32-bit sch->qstats.backlog the AQM reads can no longer
  wrap. Same-pattern siblings fixed in one patch: fq_codel, cake, codel,
  pie, fq_pie, dualpi2, RED.
 include/net/pkt_sched.h   |   1 -
 include/net/sch_generic.h |  17 ++++++
 net/sched/sch_cake.c      | 115 +++++++++++++++++++++++++++-----------
 net/sched/sch_codel.c     |  16 +++---
 net/sched/sch_dualpi2.c   |   1 +
 net/sched/sch_fifo.c      |   6 ++
 net/sched/sch_fq_codel.c  |  58 +++++++++++++++----
 net/sched/sch_fq_pie.c    |   3 +-
 net/sched/sch_pie.c       |   3 +-
 net/sched/sch_red.c       |   6 ++
 10 files changed, 172 insertions(+), 54 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 90d3e7943b19..18a419cd9d94 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -12,7 +12,6 @@
 
 #define DEFAULT_TX_QUEUE_LEN	1000
 #define STAB_SIZE_LOG_MAX	30
-#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
 
 struct qdisc_walker {
 	int	stop;
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index f35bd06a6bad..87fa65c88f03 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -906,6 +906,23 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->pkt_len;
 }
 
+#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
+
+/* Largest accounted backlog for which enqueuing one more maximum-size
+ * packet cannot wrap the 32-bit sch->qstats.backlog.
+ */
+#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
+
+/* True when the accounted backlog is close enough to U32_MAX that one
+ * more maximum-size packet could wrap it. A qdisc whose limit is a
+ * packet count (or is otherwise not a byte bound) must drop at enqueue
+ * when this holds, so the 32-bit backlog an AQM reads cannot wrap.
+ */
+static inline bool qdisc_backlog_at_max(const struct Qdisc *sch)
+{
+	return sch->qstats.backlog > QDISC_MAX_BACKLOG;
+}
+
 static inline unsigned int qdisc_pkt_segs(const struct sk_buff *skb)
 {
 	u32 pkt_segs = qdisc_skb_cb(skb)->pkt_segs;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..bd1a7aed2ebb 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1712,18 +1712,25 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
 	return &qd->tins[tin];
 }
 
-static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
-			 struct sk_buff *skb, int flow_mode, int *qerr)
+/* Run the optional external classifier. Returns true when the caller must
+ * drop (the filter's terminal TC action consumed the packet, or it matched no
+ * usable flow); the reason is then in *qerr. Otherwise *flow and *host hold
+ * the filter's flow/host overrides (0 when the filter supplied none).
+ */
+static bool cake_tcf_classify(struct Qdisc *sch, struct sk_buff *skb,
+			      u16 *flow, u16 *host, int *qerr)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
-	u16 flow = 0, host = 0;
 	int result;
 
+	*flow = 0;
+	*host = 0;
+
 	filter = rcu_dereference_bh(q->filter_list);
 	if (!filter)
-		goto hash;
+		return false;
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -1737,17 +1744,15 @@ static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
 		if (TC_H_MIN(res.classid) <= CAKE_QUEUES)
-			flow = TC_H_MIN(res.classid);
+			*flow = TC_H_MIN(res.classid);
 		if (TC_H_MAJ(res.classid) <= (CAKE_QUEUES << 16))
-			host = TC_H_MAJ(res.classid) >> 16;
+			*host = TC_H_MAJ(res.classid) >> 16;
 	}
-hash:
-	*t = cake_select_tin(sch, skb);
-	return cake_hash(*t, skb, flow_mode, flow, host) + 1;
+	return false;
 }
 
 static void cake_reconfigure(struct Qdisc *sch);
@@ -1758,22 +1763,74 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	u32 idx, tin, prev_qlen, prev_backlog, drop_id;
 	struct cake_sched_data *q = qdisc_priv(sch);
 	int len = qdisc_pkt_len(skb), ret;
+	u16 flow_override, host_override;
+	struct sk_buff *segs = NULL;
 	struct sk_buff *ack = NULL;
 	ktime_t now = ktime_get();
 	struct cake_tin_data *b;
 	struct cake_flow *flow;
 	bool same_flow = false;
+	u64 slen = 0;
 
-	/* choose flow to insert into */
-	idx = cake_classify(sch, &b, skb, q->config->flow_mode, &ret);
-	if (idx == 0) {
+	/* The optional external classifier runs first so a terminal TC action
+	 * that consumes the packet (STOLEN/QUEUED/TRAP/SHOT) keeps working
+	 * while the backlog sits at the ceiling. Its flow/host overrides are
+	 * carried forward to the post-admission cake_hash().
+	 */
+	if (cake_tcf_classify(sch, skb, &flow_override, &host_override, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* Drop before hash/shaper state: a packet we are about to reject must
+	 * not disturb it, and the 1 MiB QDISC_PKT_LEN_MAX headroom keeps a
+	 * single unsplit packet from crossing the ceiling in the same step.
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
+	/* Tin selection (DSCP/wash) must happen before segmentation, but no
+	 * flow/host state is committed until admission is known below.
+	 */
+	b = cake_select_tin(sch, skb);
+
+	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
+		struct sk_buff *nskb, *seg;
+		netdev_features_t features = netif_skb_features(skb);
+
+		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
+		if (IS_ERR_OR_NULL(segs))
+			return qdisc_drop(skb, sch, to_free);
+
+		/* The split path accounts the sum of the segment lengths
+		 * rather than the stab-adjusted qdisc_pkt_len(), so the top
+		 * check does not bound this addition. Sum the list and reject
+		 * the whole list before any flow/host state is committed.
+		 */
+		skb_list_walk_safe(segs, seg, nskb)
+			slen += seg->len;
+
+		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
+			qdisc_qstats_overlimit(sch);
+			/* skb_gso_segment() moved the sock_wfree destructor to
+			 * the tail segment; free both the original packet and
+			 * the whole list after the qdisc lock is released,
+			 * never here.
+			 */
+			__qdisc_drop_all(segs, to_free);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 QDISC_DROP_OVERLIMIT);
+		}
+	}
+
+	/* Admission is known; persistent flow/hash/shaper mutation may begin. */
+	idx = cake_hash(b, skb, q->config->flow_mode, flow_override, host_override);
 	tin = (u32)(b - q->tins);
-	idx--;
 	flow = &b->flows[idx];
 
 	/* ensure shaper state isn't stale */
@@ -1800,28 +1857,22 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		WRITE_ONCE(b->max_skblen, len);
 
-	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb;
-		netdev_features_t features = netif_skb_features(skb);
-		unsigned int slen = 0, numsegs = 0;
-
-		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-		if (IS_ERR_OR_NULL(segs))
-			return qdisc_drop(skb, sch, to_free);
+	if (segs) {
+		struct sk_buff *nskb, *seg;
+		unsigned int numsegs = 0;
 
-		skb_list_walk_safe(segs, segs, nskb) {
-			skb_mark_not_on_list(segs);
-			qdisc_skb_cb(segs)->pkt_len = segs->len;
-			qdisc_skb_cb(segs)->pkt_segs = 1;
-			cobalt_set_enqueue_time(segs, now);
-			get_cobalt_cb(segs)->adjusted_len = cake_overhead(q,
-									  segs);
-			flow_queue_add(flow, segs);
+		skb_list_walk_safe(segs, seg, nskb) {
+			skb_mark_not_on_list(seg);
+			qdisc_skb_cb(seg)->pkt_len = seg->len;
+			qdisc_skb_cb(seg)->pkt_segs = 1;
+			cobalt_set_enqueue_time(seg, now);
+			get_cobalt_cb(seg)->adjusted_len = cake_overhead(q,
+									  seg);
+			flow_queue_add(flow, seg);
 
 			qdisc_qlen_inc(sch);
 			numsegs++;
-			slen += segs->len;
-			q->buffer_used += segs->truesize;
+			q->buffer_used += seg->truesize;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
 
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 6aa5829d6961..9aa18438413a 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -116,15 +116,17 @@ static struct sk_buff *codel_peek(struct Qdisc *sch)
 static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			       struct sk_buff **to_free)
 {
-	struct codel_sched_data *q;
+	struct codel_sched_data *q = qdisc_priv(sch);
 
-	if (likely(qdisc_qlen(sch) < sch->limit)) {
-		codel_set_enqueue_time(skb);
-		return qdisc_enqueue_tail(skb, sch);
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch))) {
+		WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
 	}
-	q = qdisc_priv(sch);
-	WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
-	return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
+
+	codel_set_enqueue_time(skb);
+	return qdisc_enqueue_tail(skb, sch);
 }
 
 static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4947def7c49e..5c746e9b60cd 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -392,6 +392,7 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 	struct dualpi2_skb_cb *cb;
 
 	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch)) ||
 	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
 		qdisc_qstats_overlimit(sch);
 		if (skb_in_l_queue(skb))
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index 1b6388d50967..d5e5cd49377d 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -29,6 +29,9 @@ static int bfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static int pfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 struct sk_buff **to_free)
 {
+	if (unlikely(qdisc_backlog_at_max(sch)))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
@@ -43,6 +46,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(READ_ONCE(sch->limit) == 0))
 		return qdisc_drop(skb, sch, to_free);
 
+	if (unlikely(qdisc_backlog_at_max(sch)))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 969b2510b0b8..711bc51d3380 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -73,22 +73,35 @@ static unsigned int fq_codel_hash(const struct fq_codel_sched_data *q,
 	return reciprocal_scale(skb_get_hash(skb), q->flows_cnt);
 }
 
-static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
-				      int *qerr)
+/* Run the optional external classifier. Returns true when the caller must
+ * drop the packet (a terminal TC action consumed it, or the filter selected
+ * no usable flow); the exact reason is then in *qerr. Otherwise *idx holds
+ * the 1-based flow index, or *do_hash is set when neither skb->priority nor
+ * a filter selected a flow so the caller must fall back to fq_codel_hash().
+ */
+static bool fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
+			      unsigned int *idx, bool *do_hash, int *qerr)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	struct tcf_proto *filter;
 	struct tcf_result res;
 	int result;
 
+	*idx = 0;
+	*do_hash = false;
+
 	if (TC_H_MAJ(skb->priority) == sch->handle &&
 	    TC_H_MIN(skb->priority) > 0 &&
-	    TC_H_MIN(skb->priority) <= q->flows_cnt)
-		return TC_H_MIN(skb->priority);
+	    TC_H_MIN(skb->priority) <= q->flows_cnt) {
+		*idx = TC_H_MIN(skb->priority);
+		return false;
+	}
 
 	filter = rcu_dereference_bh(q->filter_list);
-	if (!filter)
-		return fq_codel_hash(q, skb) + 1;
+	if (!filter) {
+		*do_hash = true;
+		return false;
+	}
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	result = tcf_classify_qdisc(skb, filter, &res, false);
@@ -101,13 +114,16 @@ static unsigned int fq_codel_classify(struct sk_buff *skb, struct Qdisc *sch,
 			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
 			fallthrough;
 		case TC_ACT_SHOT:
-			return 0;
+			return true;
 		}
 #endif
-		if (TC_H_MIN(res.classid) <= q->flows_cnt)
-			return TC_H_MIN(res.classid);
+		if (TC_H_MIN(res.classid) > 0 &&
+		    TC_H_MIN(res.classid) <= q->flows_cnt) {
+			*idx = TC_H_MIN(res.classid);
+			return false;
+		}
 	}
-	return 0;
+	return true;
 }
 
 /* helper functions : might be changed when/if skb use a standard list_head */
@@ -187,18 +203,36 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
 	unsigned int idx, prev_backlog, prev_qlen;
+	bool do_hash = false;
 	struct fq_codel_flow *flow;
 	int ret;
 	unsigned int pkt_len;
 	bool memory_limited;
 
-	idx = fq_codel_classify(skb, sch, &ret);
-	if (idx == 0) {
+	/* The optional external classifier runs first, so a terminal TC action
+	 * (STOLEN/QUEUED/TRAP/SHOT) that consumes the packet keeps working
+	 * even while the backlog sits at the ceiling. Only flow hashing is
+	 * deferred past the ceiling check below.
+	 */
+	if (fq_codel_classify(skb, sch, &idx, &do_hash, &ret)) {
 		if (ret & __NET_XMIT_BYPASS)
 			qdisc_qstats_drop(sch);
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* Drop before hashing so a packet we are about to reject does not
+	 * disturb the flow hash. The 1 MiB QDISC_PKT_LEN_MAX headroom keeps
+	 * a single packet from crossing the ceiling in one step.
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		q->drop_overlimit++;
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
+	if (do_hash)
+		idx = fq_codel_hash(q, skb) + 1;
 	idx--;
 
 	codel_set_enqueue_time(skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..394f015cec36 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -155,7 +155,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
 
 	/* Checks if the qdisc is full */
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch))) {
 		q->stats.overlimit++;
 		goto out;
 	} else if (unlikely(memory_limited)) {
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3b7863ffd284..9e38f38ce923 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -89,7 +89,8 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct pie_sched_data *q = qdisc_priv(sch);
 	bool enqueue = false;
 
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_at_max(sch))) {
 		WRITE_ONCE(q->stats.overlimit, q->stats.overlimit + 1);
 		goto out;
 	}
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d7598214270b..e3a254f9dbdf 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -76,6 +76,12 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned int len;
 	int ret;
 
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	q->vars.qavg = red_calc_qavg(&q->parms,
 				     &q->vars,
 				     child->qstats.backlog);
-- 
2.43.0

