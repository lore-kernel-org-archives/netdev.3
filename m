Received: from mail-vs2-f29.google.com (mail-vs2-f29.google.com [74.125.227.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69AA43C058
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 08:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326452; cv=none; b=fGvcDEXJgamb2mbmMSK5dG6QYTPwTYIPSc54DA+eM9BNgiuzrUVoS9rLUmO/NJXJO5FmA876RzffOKk9njD2jW3qT+BWkXAVPqtmByZr1XBrIYQiunXAUFi2YfshwB+vAtTrAc7YSz8dqGTI0JZ/OEwMZzkvp+Vz3kt3KajdphA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326452; c=relaxed/simple;
	bh=A3sRJAhw4kdTjEyOoAtXO1Lmgff+1C6HbcpmWRf5bDY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lyF9uYKAyxYfg6I3P+kndVng2G25bwu77/N7TqCyiI45JOcOvO8ZdoSv1hsgKqTG7sEjSzCRx4+a6+74tMozz72FrWnCUdBk6BnCVqEICqD1j2J7C+xSPkJk+qtYf+IXFcL+8AY1fMXBs5YFcyOitzhwokMWQtIHyI8ko3FMucA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=NTOd4odN; arc=none smtp.client-ip=74.125.227.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="NTOd4odN"
Received: by mail-vs2-f29.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so319765e0c.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 01:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790326448; x=1790931248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UP4IJZZ4jfQF5SNBe2ZEaATAJu4IZuQAw6p6RjoQuKY=;
        b=NTOd4odNK+TZMHuYkkN6zxfAtCVR9dNQzYP2v0TLHlLALVe3EU/GHKb9GI9YAQGI+P
         YSKiE0x3z6gxAGKGEQ3pTrgxoZC+MjdOZEWSKUbT6DxDffv/PVC9mFL1fGJVgxc0Gnzh
         BdJ5Ojn4cPtOkfY/NiqIYgv4qr+A0fNuBrTjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790326448; x=1790931248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UP4IJZZ4jfQF5SNBe2ZEaATAJu4IZuQAw6p6RjoQuKY=;
        b=viZ2nlfI9RaswfKgYGzj7Y4evG9hR7CQ3s0gGVYG6qPB1Ux6BKhQ5Tr9Mh2QCPQU1l
         4QmKf/X7OmzCOIdpzMHzFstePxgG3kSkAQ14UjCi0WApERXYxRIGdQUhUxspe73jkBaj
         GORDleINYBsp3IAn5qwxXiwTr0uLlZ5sXsb2L0dIOAtFwgTbMrg32fL1Q93ZSij9u3ek
         ql292pYl3Iiyd3X+QlMlAvccwdoEmLKMUpkya0qAINm9HkwYzgOTgLzXJ1CihaTdwN4I
         2PcpH+6+pmBPAG7524NsADaEj2vr4NwSn8wGwFGB5g3fBHAqNQNt8e/ROXL/uycgaomW
         cMNA==
X-Gm-Message-State: AFuF++k4zeyEKsacVxv3mHaOw1+FGCn9WAl7XF/qHE+x+DBud7MCvsZ7
	PkA/EAp1OYuXZzGChmbi8vM6hOrCJdjy1OdEnPtflIHM/i5j/vHwLMbTX4kqpwuP/qTQC/EJjg/
	ydo1QSQ==
X-Gm-Gg: AYBFou2Ufm9Kzhfe5AzLsBtXEhU6dysOhrTI3M2w+B1uz2QO298YZ9ZAE8FSRDV7qpP
	OzfhBen9e8XYT2O9JFFHd87bFy2z01gp28qXftjUNHzJ+UNtdBc8oUFAAaDc4/zazMkeH3/CH+w
	fqrX2XU8bjV8fF4fu7NreTNkEeVePRSIhVItBXQQmf845nMAVSJhrD2IOWIgNSkb8vT4DH7jYeK
	kUwzEI0mIbJGFaY0sJYrYPE7LG59XCPb8/z6hlFAbYE8PPbK82XwrIqi+lgaFEkgutnCZKgXVOq
	OQG74SA7C36VLT+pryu06isw3VMviKkpl8+VWL1L+4xAv05ETeJLK7NjkXlBS2qg1DE4QMtVI31
	MzC+aOM3LfkvOdwFUboDhHdRhP+hXZi37vV269+tuIvmWKoX0PwJ83WQ6bC+yEs42ar2epoJie7
	PERBjo/f8MF2y09oXT6cf+nGhUGwlc+Z40N51W7RAMpbj2JtcTPHk5YbRtMMLNxDJiowiz5TZRs
	9goE6Y5mVt2pqa5Hct6/9upc45023BGER9SfuD4vt+jVRrhJA==
X-Received: by 2002:a05:6122:78a:b0:5c9:a491:641a with SMTP id 71dfb90a1353d-5cb0911d0c7mr3023691e0c.4.1790326447618;
        Fri, 25 Sep 2026 01:54:07 -0700 (PDT)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cd23e654e8sm269436e0c.16.2026.09.25.01.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 01:54:06 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	cake@lists.bufferbloat.net,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net-next] net/sched: fq_codel, cake: widen backlogs to u64
Date: Fri, 25 Sep 2026 04:53:53 -0400
Message-Id: <QDISC-BA27.v1.20260922092618@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a follow-up to commit 8f735d64382d ("net/sched: bound
qdisc_pkt_len to prevent qdisc soft lockup"), which capped
qdisc_pkt_len() at QDISC_PKT_LEN_MAX (1 MiB). That cap bounds the stab
amplifier but leaves the per-flow backlog counter u32:
fq_codel_enqueue() accumulates qdisc_pkt_len(skb) into q->backlogs[idx],
so a flow can still accumulate 4096 packets of 1 MiB each and wrap the
counter mod 2^32. After a wrap, fq_codel_drop() sees a tiny maxbacklog
and drops from an almost-empty flow, and the dequeue-side subtractions
corrupt the counter further.

Widen the fq_codel backlogs table, the fat-flow scan (maxbacklog/len) and
the drop threshold to u64. fq_codel is not lockless: every writer runs
under the root qdisc lock, so plain u64 arithmetic keeps the WRITE_ONCE
publish / READ_ONCE-consume pattern. The dump path
(fq_codel_dump_class_stats) stays a lockless stat-only read.

CAKE accumulates the same generic qdisc_pkt_len(skb) into its per-flow
b->backlogs[] and per-tin b->tin_backlog and consumes the values for
longest-flow pruning (cake_heapify/cake_heapify_up) and for the shaper
staleness check, so it shares the bug. Widen those counters and the heap
comparison locals to u64; the class/tin stats keep exporting the low 32
bits through the unchanged uAPI fields.

Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
CONFIG_NET_SCH_FQ_CODEL=y.

  ip tuntap add tun0 mode tun
  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
      fq_codel flows 1 limit 4200 ecn drop_batch 4096
  # hold the tun fd open without reading (IFF_BACKPRESSURE) so the qdisc
  # backlog persists, then send at least 4300 packets (the wrap starts
  # at 4096 resident; the over-limit drop that reads the wrapped
  # threshold fires past the 4200 limit): backlogs[0] wraps at 4096 x
  # 1 MiB and the fat-flow threshold reads the wrapped value.

With a 1 MiB qdisc_pkt_len cap the counter wraps at 4096 resident
packets. At limit 4200 the first over-limit enqueue (the 4201st) sees a
wrapped 105 MiB (half-backlog threshold 52 MiB, a ~52 packet drop burst),
where the u64 counter sees 4201 MiB (threshold 2100 MiB, a ~2100 packet
drop burst).

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_cake.c     | 23 ++++++++++++-----------
 net/sched/sch_fq_codel.c | 22 ++++++++++++----------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..8e99c85dab17 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -150,7 +150,7 @@ struct cake_heap_entry {
 
 struct cake_tin_data {
 	struct cake_flow flows[CAKE_QUEUES];
-	u32	backlogs[CAKE_QUEUES];
+	u64	backlogs[CAKE_QUEUES];
 	u32	tags[CAKE_QUEUES]; /* for set association */
 	u16	overflow_idx[CAKE_QUEUES];
 	struct cake_host hosts[CAKE_QUEUES]; /* for triple isolation */
@@ -177,7 +177,7 @@ struct cake_tin_data {
 
 	u16	tin_quantum;
 	s32	tin_deficit;
-	u32	tin_backlog;
+	u64	tin_backlog;
 	u32	tin_dropped;
 	u32	tin_ecn_mark;
 
@@ -1466,17 +1466,17 @@ static void cake_heap_swap(struct cake_sched_data *q, u16 i, u16 j)
 	q->tins[jj.t].overflow_idx[jj.b] = i;
 }
 
-static u32 cake_heap_get_backlog(const struct cake_sched_data *q, u16 i)
+static u64 cake_heap_get_backlog(const struct cake_sched_data *q, u16 i)
 {
 	struct cake_heap_entry ii = q->overflow_heap[i];
 
-	return q->tins[ii.t].backlogs[ii.b];
+	return READ_ONCE(q->tins[ii.t].backlogs[ii.b]);
 }
 
 static void cake_heapify(struct cake_sched_data *q, u16 i)
 {
 	static const u32 a = CAKE_MAX_TINS * CAKE_QUEUES;
-	u32 mb = cake_heap_get_backlog(q, i);
+	u64 mb = cake_heap_get_backlog(q, i);
 	u32 m = i;
 
 	while (m < a) {
@@ -1484,7 +1484,7 @@ static void cake_heapify(struct cake_sched_data *q, u16 i)
 		u32 r = l + 1;
 
 		if (l < a) {
-			u32 lb = cake_heap_get_backlog(q, l);
+			u64 lb = cake_heap_get_backlog(q, l);
 
 			if (lb > mb) {
 				m  = l;
@@ -1493,7 +1493,7 @@ static void cake_heapify(struct cake_sched_data *q, u16 i)
 		}
 
 		if (r < a) {
-			u32 rb = cake_heap_get_backlog(q, r);
+			u64 rb = cake_heap_get_backlog(q, r);
 
 			if (rb > mb) {
 				m  = r;
@@ -1514,8 +1514,8 @@ static void cake_heapify_up(struct cake_sched_data *q, u16 i)
 {
 	while (i > 0 && i < CAKE_MAX_TINS * CAKE_QUEUES) {
 		u16 p = (i - 1) >> 1;
-		u32 ib = cake_heap_get_backlog(q, i);
-		u32 pb = cake_heap_get_backlog(q, p);
+		u64 ib = cake_heap_get_backlog(q, i);
+		u64 pb = cake_heap_get_backlog(q, p);
 
 		if (ib > pb) {
 			cake_heap_swap(q, i, p);
@@ -3046,7 +3046,8 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 
 		PUT_TSTAT_U64(THRESHOLD_RATE64, READ_ONCE(b->tin_rate_bps));
 		PUT_TSTAT_U64(SENT_BYTES64, READ_ONCE(b->bytes));
-		PUT_TSTAT_U32(BACKLOG_BYTES, READ_ONCE(b->tin_backlog));
+		PUT_TSTAT_U32(BACKLOG_BYTES,
+			      (u32)READ_ONCE(b->tin_backlog));
 
 		PUT_TSTAT_U32(TARGET_US,
 			      ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.target))));
@@ -3152,7 +3153,7 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 			}
 			sch_tree_unlock(sch);
 		}
-		qs.backlog = READ_ONCE(b->backlogs[idx % CAKE_QUEUES]);
+		qs.backlog = (u32)READ_ONCE(b->backlogs[idx % CAKE_QUEUES]);
 		qs.drops = READ_ONCE(flow->dropped);
 	}
 	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 969b2510b0b8..3c20297cef07 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -51,7 +51,7 @@ struct fq_codel_sched_data {
 	struct tcf_proto __rcu *filter_list; /* optional external classifier */
 	struct tcf_block *block;
 	struct fq_codel_flow *flows;	/* Flows table [flows_cnt] */
-	u32		*backlogs;	/* backlog table [flows_cnt] */
+	u64		*backlogs;	/* backlog table [flows_cnt] */
 	u32		flows_cnt;	/* number of flows */
 	u32		quantum;	/* psched_mtu(qdisc_dev(sch)); */
 	u32		drop_batch_size;
@@ -138,22 +138,25 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 				  struct sk_buff **to_free)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+	u64 maxbacklog = 0, len = 0;
 	struct sk_buff *skb;
-	unsigned int maxbacklog = 0, idx = 0, i, len;
 	struct fq_codel_flow *flow;
-	unsigned int threshold;
+	unsigned int idx = 0, i;
 	unsigned int mem = 0;
+	u64 threshold;
 
 	/* Queue is full! Find the fat flow and drop packet(s) from it.
 	 * This might sound expensive, but with 1024 flows, we scan
-	 * 4KB of memory, and we dont need to handle a complex tree
+	 * 8KB of memory, and we dont need to handle a complex tree
 	 * in fast path (packet queue/enqueue) with many cache misses.
 	 * In stress mode, we'll try to drop 64 packets from the flow,
 	 * amortizing this linear lookup to one cache line per drop.
 	 */
 	for (i = 0; i < q->flows_cnt; i++) {
-		if (q->backlogs[i] > maxbacklog) {
-			maxbacklog = q->backlogs[i];
+		u64 backlog = READ_ONCE(q->backlogs[i]);
+
+		if (backlog > maxbacklog) {
+			maxbacklog = backlog;
 			idx = i;
 		}
 	}
@@ -162,7 +165,6 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	threshold = maxbacklog >> 1;
 
 	flow = &q->flows[idx];
-	len = 0;
 	i = 0;
 	do {
 		skb = dequeue_head(flow);
@@ -384,7 +386,7 @@ static void fq_codel_reset(struct Qdisc *sch)
 		INIT_LIST_HEAD(&flow->flowchain);
 		codel_vars_init(&flow->cvars);
 	}
-	memset(q->backlogs, 0, q->flows_cnt * sizeof(u32));
+	memset(q->backlogs, 0, q->flows_cnt * sizeof(u64));
 	q->memory_usage = 0;
 }
 
@@ -542,7 +544,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 			err = -ENOMEM;
 			goto init_failure;
 		}
-		q->backlogs = kvcalloc(q->flows_cnt, sizeof(u32), GFP_KERNEL);
+		q->backlogs = kvcalloc(q->flows_cnt, sizeof(u64), GFP_KERNEL);
 		if (!q->backlogs) {
 			err = -ENOMEM;
 			goto alloc_failure;
@@ -720,7 +722,7 @@ static int fq_codel_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 			}
 			sch_tree_unlock(sch);
 		}
-		qs.backlog = READ_ONCE(q->backlogs[idx]);
+		qs.backlog = (u32)READ_ONCE(q->backlogs[idx]);
 		qs.drops = 0;
 	}
 	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
-- 
2.43.0

