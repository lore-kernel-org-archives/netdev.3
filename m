Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234B64C77BC
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473034; cv=none; b=ijrPEIxCVcZTI22OgKKtDcHoaVixsUkm0VyWpVA0DjtyJDRBDWl5TfhhQEW689ePPLlDkr0YjAgXYtn8Oez+bFeOBmMGhhTQ3J/apDL9JGtjVnssdXFN0veysJk1UjJ5EdftOWnDz8OoJa67QYX7W0T1Mb5dh5apfsGNevjU2GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473034; c=relaxed/simple;
	bh=ECPGgu4JgyvItAu0+To4BFXt5LHk7G0SUOnIHk70ImE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDa6pt6FjVc/WLLUbgxXgTfd9m2q0yezyyZkrRUUPM5SOSm2+Rhpx558+v/YiCaAnCdCrqHaVg5TC3tn3HfDH+dUQKi+XN3zBn8bNUBPORMl+vWQk7xuWp/+Ro6TZSZLOQmk8RJbovTZHpGZaCIgmWg5EvxYW8gwprFU2kqaa7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=FwI0iAPQ; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="FwI0iAPQ"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-982d6efbeadso1222048241.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 08:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791473029; x=1792077829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qja7Eq0r+/UR0L4vnZ+r4aZxKHYJywq2TfLhDGakaM8=;
        b=FwI0iAPQHzDepT9FuXZouudVmNgc8UL8DOIC2kSUXGUFh4UM8zaThxILdpbT3AgxlI
         4Zr9GhtuqI68pjaxy2eIwZetpuOioHbAdtSa7gUTy0C5JtJUuTpFF7zXiHZSiavvcyc8
         vOrYG+hGCtcONer1Tn7R0hgGeVN1kB107swo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791473029; x=1792077829;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qja7Eq0r+/UR0L4vnZ+r4aZxKHYJywq2TfLhDGakaM8=;
        b=WlL7ItrYauE/kYefb348UTKYTpFhyKkKwDv5YBjGqC/ogn8Kv7wwb1gHHRzo1XpoOQ
         iLL9if9bf02yIZ+hpPFp9hObBij8M8ci/bsbXOEKA/cRB3J/AwCr31qO9MjekSMC9fkt
         vGVPf28BQVYAvQe5l906Z2HIDLx3L34j0/MktNJOXic/AY27ObUz3vQFBKl20Xg7MnEI
         E77ZVBLdpwUsQV7kmZmKZR09t8yiYkeNeuksu/27AT5/zJsdPsjjkhEQgY9C+jl2UcgZ
         DjqXeMeCrr2wAN2+1IB5HGyE/bxv8WOZ5DRrV1pX3oB5e6CCuKubR+7UwVTmKMS5a49G
         Uz6g==
X-Forwarded-Encrypted: i=1; AKwUvBzUFwQzTlukH55W837kep4dcCb1OzyL72pxl2WMbv23j1D0rc0qC+7rWwodBK5jcAfo0TFPsAE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIEHs6yU7LDF+XSX3DZ7YuwYkcyYUIu/4ht9V5Rnr67CZQyB8Rs
	QISLU6BkFXLILUPpH44wOPGXI4eWi/yr3bW2p+X04sVc3dCn6OhE/6p794D7fm1Wq3e+Z/U5rPN
	Ea6I=
X-Gm-Gg: AYBFou1i5P4HI9bzV+0tZztgdJg/yOOvcAiCohzWHn8QaKgP8+iwf+6LI/A96OXe7hM
	fUbt9ssye4nHpW2thYNEesYQ/FCf6lBYnLoDEhVgFyqBtjMQiY6wNZ3ZJplcC65iWst4aVzGvfI
	PC3nyWAM8L+81dxrNAbXgpQUl6lZctkmEKK3wZBqKDkA/U+Yn+aPl0TRfH/06hdSP/59OZ5pYFL
	lJE+jhVl3nC/Nct58tR1WHVNecn3jKgXb56ce1ymnLBuY3eXBSycOeGxz6wMaO3z0gr3qDv1iIm
	LFXXeGic+cjP4uUmZw5rxkiI1rZn08/+jRSeiAe/TuzSagHkegXCDswWuFkVP42CTiURWzU1VuZ
	MmZ4Synq0MWg8X7A+DEL0/LXS08BEN24o+1d9Q4XnzLSLn9iQVCBniJGI7RG5wxvBDxAA0AM7I9
	fvv+cUrBrqTfjmpzg15m6nSnhCoNmUFQJ53fNSzAaxYY56oCh9mj1NVD9QALWSF0fp/LqTxf49r
	wCb
X-Received: by 2002:a67:e70e:0:b0:7c3:8d49:2a9c with SMTP id ada2fe7eead31-7ca36f42e3emr1222340137.4.1791473028333;
        Thu, 08 Oct 2026 08:23:48 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:14d:5c54:4d67::2000])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e6c419e2bfsm4818871e0c.5.2026.10.08.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:23:47 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org
Cc: horms@kernel.org,
	sashiko-bot <sashiko-bot@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net-next 1/2] net/sched: skip empty rounds in the deficit-refill dequeue loops
Date: Thu,  8 Oct 2026 12:23:34 -0300
Message-ID: <QDISC-TIAE.v1.20261008110502@mojatatu.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DRR and ETS dequeue loops replenish one quantum per iteration while
the head packet is larger than the class deficit. A crafted size table
pushes the packet length to QDISC_PKT_LEN_MAX (1 MiB) and the clamped
quantum floor of 256 makes that ~4096 refill iterations per packet, so
a dequeue pass over N active classes costs N * 4096 list walks under
the qdisc spinlock with BH off. A single drain over 16k classes at
quantum 256 takes ~0.9s of BH-off churn, growing with the class count
and stalling traffic on the device.

Skip the rounds during which no active class can dequeue. The first
round runs the existing one-quantum walk unchanged; only after a full
round with no class becoming eligible, compute the fewest whole rounds
no class can dequeue, apply that many quantum refills to every class at
once and resume the walk. A round refills every class once and restores
the list order, so the walk that follows is unchanged: it still
dequeues the first class that becomes eligible in list order, and each
class ends with the same deficit the one-quantum loop converged to. A
class whose child qdisc peeks no packet leaves the original one-quantum
walk (and its non-work-conserving head abort) in sole charge of that
dequeue.

The same refill-and-rotate shape is shared by fq_codel, fq_pie, fq and
sfq, so bound those at the same time. In those flow-based qdiscs a flow
can leave the list mid-walk (emptied, throttled or detached); re-arm
the round sentinel when that happens, and skip a flow that cannot
dequeue on its next visit, so neither case can silently disable the
bound.

This is a follow-up to commit 8f735d64382d ("net/sched: bound
qdisc_pkt_len to prevent qdisc soft lockup"); that capped the packet
length, the refill loop itself has no bound in the number of classes.
It is not a regression and is not marked for stable: the walk has been
linear in the number of classes times the per-class refill count (up to
4096 with a crafted size table) since these schedulers were introduced,
so there is no regression commit to blame and no narrow fix to
backport.

Conditions to recreate:
- CONFIG_NET_SCH_DRR=y, CONFIG_NET_SCH_ETS=y; veth pair
- tc qdisc add dev veth0 root stab mtu 2048 tsize 0 overhead 1048576 drr
- 16384 drr classes quantum 256; one u32 filter flowid 1:1; one ping
  per class to arm them
- CAP_NET_ADMIN (namespace-local via unshare -Urn suffices)

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260819143213.57401-1-jhs@mojatatu.com
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_drr.c      | 42 ++++++++++++++++++++++++++-
 net/sched/sch_ets.c      | 41 ++++++++++++++++++++++++++-
 net/sched/sch_fq.c       | 61 +++++++++++++++++++++++++++++++++++++++-
 net/sched/sch_fq_codel.c | 53 ++++++++++++++++++++++++++++++++--
 net/sched/sch_fq_pie.c   | 51 +++++++++++++++++++++++++++++++--
 net/sched/sch_sfq.c      | 42 ++++++++++++++++++++++++++-
 6 files changed, 282 insertions(+), 8 deletions(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 8621d057edd9..27d216b777f2 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -372,7 +372,8 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 {
 	struct drr_sched *q = qdisc_priv(sch);
-	struct drr_class *cl;
+	struct drr_class *cl, *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	unsigned int len;
 
@@ -402,6 +403,45 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			return skb;
 		}
 
+		/* The head cannot dequeue. Once a full round passes with
+		 * no class becoming eligible, skip the remaining empty
+		 * rounds in a single bulk refill.
+		 */
+		if (!scanned && cl == first) {
+			unsigned int rounds = UINT_MAX;
+			struct drr_class *iter;
+			bool skip = true;
+
+			scanned = true;
+			list_for_each_entry(iter, &q->active, alist) {
+				unsigned int pkt_len;
+				struct sk_buff *peek;
+
+				peek = iter->qdisc->ops->peek(iter->qdisc);
+				if (!peek) {
+					skip = false;
+					break;
+				}
+				pkt_len = qdisc_pkt_len(peek);
+				if (pkt_len <= iter->deficit) {
+					skip = false;
+					break;
+				}
+				rounds = min(rounds,
+					     DIV_ROUND_UP(pkt_len - iter->deficit,
+							  READ_ONCE(iter->quantum)));
+			}
+			if (skip && rounds != UINT_MAX) {
+				list_for_each_entry(iter, &q->active, alist)
+					WRITE_ONCE(iter->deficit,
+						   iter->deficit + rounds *
+						   READ_ONCE(iter->quantum));
+				continue;
+			}
+		}
+
+		if (!first)
+			first = cl;
 		WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
 		list_move_tail(&cl->alist, &q->active);
 	}
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index 6cc902a03838..6d96ae2d663b 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -459,7 +459,8 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
 static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct ets_sched *q = qdisc_priv(sch);
-	struct ets_class *cl;
+	struct ets_class *cl, *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	unsigned int band;
 	unsigned int len;
@@ -493,6 +494,44 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 			return ets_qdisc_dequeue_skb(sch, skb);
 		}
 
+		/* The head cannot dequeue. Once a full round passes with
+		 * no band becoming eligible, skip the remaining empty
+		 * rounds in a single bulk refill.
+		 */
+		if (!scanned && cl == first) {
+			unsigned int rounds = UINT_MAX;
+			struct ets_class *iter;
+			bool skip = true;
+
+			scanned = true;
+			list_for_each_entry(iter, &q->active, alist) {
+				unsigned int pkt_len;
+				struct sk_buff *peek;
+
+				peek = iter->qdisc->ops->peek(iter->qdisc);
+				if (!peek) {
+					skip = false;
+					break;
+				}
+				pkt_len = qdisc_pkt_len(peek);
+				if (pkt_len <= iter->deficit) {
+					skip = false;
+					break;
+				}
+				rounds = min(rounds,
+					     DIV_ROUND_UP(pkt_len - iter->deficit,
+							  READ_ONCE(iter->quantum)));
+			}
+			if (skip && rounds != UINT_MAX) {
+				list_for_each_entry(iter, &q->active, alist)
+					iter->deficit += rounds *
+							 READ_ONCE(iter->quantum);
+				continue;
+			}
+		}
+
+		if (!first)
+			first = cl;
 		cl->deficit += READ_ONCE(cl->quantum);
 		list_move_tail(&cl->alist, &q->active);
 	}
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index a282812c192e..125c6bf836b9 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -737,8 +737,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	struct fq_sched_data *q = qdisc_priv(sch);
 	u64 offload_horizon = fq_offload_horizon(sch, q);
 	struct fq_perband_flows *pband;
+	struct fq_flow *first = NULL;
 	struct fq_flow_head *head;
 	u64 time_next_packet = 0;
+	bool scanned = false;
 	struct sk_buff *skb;
 	struct fq_flow *f;
 	unsigned long rate;
@@ -769,8 +771,16 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 			pband = &q->band_flows[q->band_nr];
 			pband->credit = min(pband->credit + pband->quantum,
 					    pband->quantum);
-			if (pband->credit > 0)
+			if (pband->credit > 0) {
+				/* first belongs to the old pband, so
+				 * both the sentinel and the scan flag
+				 * must be reset here. This is the only
+				 * goto begin that changes pband.
+				 */
+				first = NULL;
+				scanned = false;
 				goto begin;
+			}
 			retry = 0;
 		}
 		if (q->time_next_delayed_flow != ~0ULL)
@@ -782,6 +792,45 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 	f = head->first;
 	retry = 0;
 	if (f->credit <= 0) {
+		/* The head cannot dequeue. Once a full round passes with
+		 * no flow becoming eligible, skip the remaining empty
+		 * rounds in a single bulk refill.
+		 */
+		if (!scanned && f == first) {
+			unsigned int rounds = UINT_MAX;
+			struct fq_flow *iter;
+
+			scanned = true;
+			/* A completed round leaves new_flows empty, so
+			 * only old_flows still holds flows awaiting a
+			 * refill.
+			 */
+			for (iter = pband->old_flows.first; iter;
+			     iter = iter->next) {
+				/* A flow that cannot dequeue next round
+				 * (empty queue) is removed instead, so it
+				 * neither arms nor sizes the skip.
+				 */
+				if (!fq_peek(iter))
+					continue;
+				if (iter->credit > 0) {
+					rounds = 0;
+					break;
+				}
+				rounds = min(rounds,
+					     DIV_ROUND_UP(1 - iter->credit,
+							  q->quantum));
+			}
+			if (rounds && rounds != UINT_MAX) {
+				for (iter = pband->old_flows.first; iter;
+				     iter = iter->next)
+					iter->credit += rounds * q->quantum;
+				goto begin;
+			}
+		}
+
+		if (!first)
+			first = f;
 		f->credit += q->quantum;
 		head->first = f->next;
 		fq_flow_add_tail(q, f, OLD_FLOW);
@@ -796,6 +845,11 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		if (now + offload_horizon < time_next_packet) {
 			head->first = f->next;
 			f->time_next_packet = time_next_packet;
+			/* first would point at an off-list flow and
+			 * the scan would never arm; re-arm it.
+			 */
+			if (f == first)
+				first = NULL;
 			fq_flow_set_throttled(q, f);
 			goto begin;
 		}
@@ -814,6 +868,11 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
 		if (head == &pband->new_flows) {
 			fq_flow_add_tail(q, f, OLD_FLOW);
 		} else {
+			/* f leaves the list; re-arm first if it was the
+			 * sentinel (see the throttled path above).
+			 */
+			if (f == first)
+				first = NULL;
 			fq_flow_set_detached(f);
 		}
 		goto begin;
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index e6c87a32950f..79f1f25525e7 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -284,6 +284,8 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 static struct sk_buff *__fq_codel_dequeue(struct Qdisc *sch)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+	struct fq_codel_flow *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb;
 	struct fq_codel_flow *flow;
 	struct list_head *head;
@@ -298,6 +300,47 @@ static struct sk_buff *__fq_codel_dequeue(struct Qdisc *sch)
 	flow = list_first_entry(head, struct fq_codel_flow, flowchain);
 
 	if (flow->deficit <= 0) {
+		/* The head cannot dequeue. Once a full round passes with
+		 * no flow becoming eligible, skip the remaining empty
+		 * rounds in a single bulk refill.
+		 */
+		if (!scanned && flow == first) {
+			unsigned int rounds = UINT_MAX;
+			struct fq_codel_flow *iter;
+			bool skip = true;
+
+			scanned = true;
+			/* A completed round leaves new_flows empty, so
+			 * only old_flows still holds flows awaiting a
+			 * refill.
+			 */
+			list_for_each_entry(iter, &q->old_flows, flowchain) {
+				unsigned int r;
+
+				/* An empty flow cannot dequeue next round
+				 * (it is removed instead), so it neither
+				 * arms nor sizes the skip.
+				 */
+				if (!iter->head)
+					continue;
+				if (iter->deficit > 0) {
+					skip = false;
+					break;
+				}
+				r = DIV_ROUND_UP(1 - iter->deficit, q->quantum);
+				rounds = min(rounds, r);
+			}
+			if (skip && rounds != UINT_MAX) {
+				list_for_each_entry(iter, &q->old_flows, flowchain)
+					WRITE_ONCE(iter->deficit,
+						   iter->deficit +
+						   rounds * q->quantum);
+				goto begin;
+			}
+		}
+
+		if (!first)
+			first = flow;
 		WRITE_ONCE(flow->deficit, flow->deficit + q->quantum);
 		list_move_tail(&flow->flowchain, &q->old_flows);
 		goto begin;
@@ -309,10 +352,16 @@ static struct sk_buff *__fq_codel_dequeue(struct Qdisc *sch)
 
 	if (!skb) {
 		/* force a pass through old_flows to prevent starvation */
-		if ((head == &q->new_flows) && !list_empty(&q->old_flows))
+		if (head == &q->new_flows && !list_empty(&q->old_flows)) {
 			list_move_tail(&flow->flowchain, &q->old_flows);
-		else
+		} else {
+			/* first would point at an off-list flow and the
+			 * scan would never arm; re-arm it.
+			 */
+			if (flow == first)
+				first = NULL;
 			list_del_init(&flow->flowchain);
+		}
 		goto begin;
 	}
 	qdisc_bstats_update(sch, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..2cd54516a78e 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -238,6 +238,8 @@ static inline struct sk_buff *dequeue_head(struct fq_pie_flow *flow)
 static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	struct fq_pie_flow *first = NULL;
+	bool scanned = false;
 	struct sk_buff *skb = NULL;
 	struct fq_pie_flow *flow;
 	struct list_head *head;
@@ -254,6 +256,45 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 	flow = list_first_entry(head, struct fq_pie_flow, flowchain);
 	/* Flow has exhausted all its credits */
 	if (flow->deficit <= 0) {
+		/* The head cannot dequeue. Once a full round passes with
+		 * no flow becoming eligible, skip the remaining empty
+		 * rounds in a single bulk refill.
+		 */
+		if (!scanned && flow == first) {
+			unsigned int rounds = UINT_MAX;
+			struct fq_pie_flow *iter;
+			bool skip = true;
+
+			scanned = true;
+			/* A completed round leaves new_flows empty, so
+			 * only old_flows still holds flows awaiting a
+			 * refill.
+			 */
+			list_for_each_entry(iter, &q->old_flows, flowchain) {
+				unsigned int r;
+
+				/* An empty flow cannot dequeue next round
+				 * (it is removed instead), so it neither
+				 * arms nor sizes the skip.
+				 */
+				if (!iter->head)
+					continue;
+				if (iter->deficit > 0) {
+					skip = false;
+					break;
+				}
+				r = DIV_ROUND_UP(1 - iter->deficit, q->quantum);
+				rounds = min(rounds, r);
+			}
+			if (skip && rounds != UINT_MAX) {
+				list_for_each_entry(iter, &q->old_flows, flowchain)
+					iter->deficit += rounds * q->quantum;
+				goto begin;
+			}
+		}
+
+		if (!first)
+			first = flow;
 		flow->deficit += q->quantum;
 		list_move_tail(&flow->flowchain, &q->old_flows);
 		goto begin;
@@ -269,10 +310,16 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 
 	if (!skb) {
 		/* force a pass through old_flows to prevent starvation */
-		if (head == &q->new_flows && !list_empty(&q->old_flows))
+		if (head == &q->new_flows && !list_empty(&q->old_flows)) {
 			list_move_tail(&flow->flowchain, &q->old_flows);
-		else
+		} else {
+			/* first would point at an off-list flow and the
+			 * scan would never arm; re-arm it.
+			 */
+			if (flow == first)
+				first = NULL;
 			list_del_init(&flow->flowchain);
+		}
 		goto begin;
 	}
 
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 8bbcfc9e85d9..e160de8af5e1 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -479,9 +479,11 @@ static struct sk_buff *
 sfq_dequeue(struct Qdisc *sch)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
+	sfq_index first = SFQ_EMPTY_SLOT;
 	struct sk_buff *skb;
-	sfq_index a, next_a;
 	struct sfq_slot *slot;
+	bool scanned = false;
+	sfq_index a, next_a;
 
 	/* No active slots */
 	if (q->tail == NULL)
@@ -491,6 +493,44 @@ sfq_dequeue(struct Qdisc *sch)
 	a = q->tail->next;
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
+		/* The head cannot dequeue. Once a full round passes with
+		 * no slot becoming eligible, skip the remaining empty
+		 * rounds in a single bulk refill.
+		 */
+		if (!scanned && a == first) {
+			unsigned int rounds = UINT_MAX;
+			bool skip = true;
+			sfq_index i = a;
+
+			scanned = true;
+			do {
+				struct sfq_slot *s = &q->slots[i];
+				unsigned int r;
+
+				if (s->allot > 0) {
+					skip = false;
+					break;
+				}
+				r = DIV_ROUND_UP(1 - s->allot, q->quantum);
+				rounds = min(rounds, r);
+				i = s->next;
+			} while (i != a);
+			if (skip && rounds != UINT_MAX) {
+				i = a;
+				do {
+					struct sfq_slot *s = &q->slots[i];
+
+					WRITE_ONCE(s->allot,
+						   s->allot +
+						   rounds * q->quantum);
+					i = s->next;
+				} while (i != a);
+				goto next_slot;
+			}
+		}
+
+		if (!scanned && first == SFQ_EMPTY_SLOT)
+			first = a;
 		q->tail = slot;
 		WRITE_ONCE(slot->allot, slot->allot + q->quantum);
 		goto next_slot;
-- 
2.43.0

