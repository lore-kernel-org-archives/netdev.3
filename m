Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DC82949E0
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790444958; cv=none; b=GwBO43fAfpu5j+V1lTEG2/7J139suItfBBH8IhDvtaWkGQWCx5EvKCcMaib2zwn/DQ8YjOfmPx0xpI5Tv1l/0uEzWcZNQnEWIo8oJIc3UKwSfcPmGM8G53v9eQxkMtv7ob8PcTwjUhTHlqgbYjF0o+b5Ip+xwIZzVaHlNm5Xlx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790444958; c=relaxed/simple;
	bh=kvpnZxKUHGSglOEbQfV7dfDRH3Tc2uFxiJgQy8zXx3A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pqb8KcwfvBxOSr94uVbitmGgCQEUKnxWc3Xei5dp36vDW5vKvG4ElI0v9+Q9S/GqF3wct1nHJJ8evosv4T8/r+CUBfAEdXB4BfIXWXdwd6Nb1nyNHPFnoTmxKPdh4b39iXcZO6ESh+2/nHnvb7N9PccKP0gVrg3GcHALHDfeW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=HI+EHjoz; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="HI+EHjoz"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bd580489dso171662085a.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1790444956; x=1791049756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4LwfMZnrjmSOTF2KrlpJYTkq/+NuFc3IB5nSeQZR7A=;
        b=HI+EHjozXWkGKVeWD0Jk3b5+2FsSpniKOLffqs2sOemPS3LOvBYkLW1ndHAVi49Opz
         jwKwLg1QrdUyOqxLtiE5hbOxsuZxNF8u/6VGtFny94Xk6v/unjGEo3OL7wGrMagyWreQ
         TU5hV/qTKRNSy6Kv8ffqVcbA9CdFOgvJXfpj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790444956; x=1791049756;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/4LwfMZnrjmSOTF2KrlpJYTkq/+NuFc3IB5nSeQZR7A=;
        b=KfmdA/DZPH0w7WZu8OJb/Ja/jZWtxYaJ9QlCyaOcv3qVJ5qmRo9xuTlZCbLu6TadyL
         BuaOG5m6Nq42ypMs9YbZAk9M51+u/wH7gio23ka4JuBDz6n9J9unzyD2+yebizwmNjQH
         kCyKjb1TMT0JZKl2bDAfvhOxLsMW0i7rtb+LNnI/eoAo9FyITz49SYC67pSUQlBxQjUo
         ntA1GcYALEb9f723s77XrzcCzPoXbB1IhwLGXWy/r806AVyZoIuFWGRcPU8o2F5rz/sK
         AWoJo304cBtEfa/KHxW1dQLcFaHIas3q25XcDwvHZfq2tau6hgL2zHiAWaeu6+fD1mJ+
         NbOQ==
X-Gm-Message-State: AFuF++nMkqQaCJuswUIEpWEGg07b8BQYhr6L2up3fs+VIMd2qrCjX9Pi
	ajTj7fMarOStifV/M/p9Yd3Ee5DXxtniU443GKmIZ/jUxqnRb9UwbQOAuEcsO4CKrVV+zzJVtIZ
	+Zq1xVw==
X-Gm-Gg: AYBFou39P4sWwt5x00BXgUPUUQzXmPbl//wzKLOimpJglOY9f9mJQVyW1hph87EL0xc
	m9+mcyrZu/I1+KjUJi+OfYC3Hb2In9PqmERT1Zex2ygZ52hm01D3StryDf+bw6+6Hc/JqyrjCv7
	sm8DpPIET0YT/bexznRFKsK6aDEDQHhaXkpxxDXtr/Ntotl9JZVqGDbJsXrc4rJqh57RCKs3gUN
	YZuolydwytHge8EYOyLoM5xTpJT35uey6AgIBnQnJdnP018K2DeR9LIuuUCs63icXX4Z3Be7WwL
	Vd4Fvbn7Dabk2h/rCJWx2U0hcuoY1i0USPUhd8PkjSO7/6u2L7e/NwdJZYko3yKUeYQlX/wjFkU
	NFRGPiAL2CXzfNhTIdSmZA06D5l4Ewp4DYxOnmOA7echE7M9oYiT/f5TexhwKnZpzCtf+nI+Hxu
	pb7tCkkrNifn+89PRFGXH7/ZLORx7+IScBqViG2GAZl94x0BMU+wnRm1QBi6l68qQbHJX0ZyhU7
	fO1P+hgGlJWsZvjkJRKLFUnPqsXMHsDs+xPgn0lgOfv/+UBC+e40Ll8OGn/
X-Received: by 2002:a05:620a:404d:b0:939:9f51:29a0 with SMTP id af79cd13be357-93c43ce6b41mr1137143885a.50.1790444955590;
        Sat, 26 Sep 2026 10:49:15 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9144d0bda89sm13676836d6.14.2026.09.26.10.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 10:49:15 -0700 (PDT)
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
Subject: [PATCH net-next v2] net/sched: cap the accounted backlog before it can wrap
Date: Sat, 26 Sep 2026 13:49:12 -0400
Message-Id: <QDISC-BA27.v2.20260926123300@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fq_codel, cake, codel, pie, fq_pie and dualpi2 account every enqueued
packet's stab-adjusted length into a 32-bit sch->qstats.backlog.
fq_codel/codel uses it do decide if they should drop a packet at deq;
cake uses it to prune the longest-flow heap from per-flow backlogs;
pie and fq_pie use it to make early drop decisions and, dualpi2 decides
must_drop() on it. RED can can decide on a child's backlog based on it.
A crafted tc size table (TC_STAB) inflates qdisc_pkt_len() up to
QDISC_PKT_LEN_MAX (1 MiB), so a few thousand packets wrap the counter
mod 2^32. The AQM algo then reads a small backlog and makes the wrong
drop decision, and the dequeue-side subtractions keep the counter corrupt.

Fix:
Drop at enqueue once the accounted backlog would cross QDISC_MAX_BACKLOG
(U32_MAX - QDISC_PKT_LEN_MAX), the largest backlog one more maximum-size
packet cannot wrap.  This follows the existing bfifo/gred approach
(safe because its limit is checked against the accounted packet length);
the fixed qdiscs' limits are packet counts or otherwise do not bound
the aggregate bytes, so they need the byte bound here.

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

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v2 (2026-09-25) — approach rewrite per list discussion of v1:

  v1 approached the wrap by widening the per-flow backlog counters to
  u64. Eric Dumazet said "Storing 4GB in a qdisc is absolutely insane" ;-)
  and asked for a drop at enqueue once the backlog approaches the wrap point.
  Sebastian Moeller noted tc-stab is the generic overhead-accounting mechanism,
  so the fix must not penalize normal stab use.

  v2 replaces the u64 widening with an enqueue-side pre-check against
  QDISC_MAX_BACKLOG (U32_MAX - QDISC_PKT_LEN_MAX) and drops with
  QDISC_DROP_OVERLIMIT. No counter is widened, so the 32-bit
  sch->qstats.backlog the AQM qdisc reads can no longer wrap. Same pattern
  in other qdiscs fixed in one patch: fq_codel, cake, codel, pie, fq_pie,
  dualpi2, RED.
  Note: v1 touched fq_codel and cake only.

 include/net/pkt_sched.h  |  5 +++++
 net/sched/sch_cake.c     | 28 ++++++++++++++++++++++++++--
 net/sched/sch_codel.c    | 17 ++++++++++-------
 net/sched/sch_dualpi2.c  |  2 ++
 net/sched/sch_fq_codel.c |  7 +++++++
 net/sched/sch_fq_pie.c   |  4 +++-
 net/sched/sch_pie.c      |  4 +++-
 net/sched/sch_red.c      |  8 +++++++-
 8 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 90d3e7943b19..351b92f956ef 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -13,6 +13,11 @@
 #define DEFAULT_TX_QUEUE_LEN	1000
 #define STAB_SIZE_LOG_MAX	30
 #define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
+/*
+ * Largest accounted backlog for which enqueuing one more maximum-size
+ * packet cannot wrap the 32-bit sch->qstats.backlog.
+ */
+#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
 
 struct qdisc_walker {
 	int	stop;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dc93267029e7..6a16546aa5b0 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1776,6 +1776,14 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	idx--;
 	flow = &b->flows[idx];
 
+	if (unlikely((u64)sch->qstats.backlog + len > QDISC_MAX_BACKLOG)) {
+		WRITE_ONCE(flow->dropped, flow->dropped + 1);
+		WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	/* ensure shaper state isn't stale */
 	if (!b->tin_backlog) {
 		if (ktime_before(b->time_next_packet, now))
@@ -1801,7 +1809,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		WRITE_ONCE(b->max_skblen, len);
 
 	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb;
+		struct sk_buff *segs, *nskb, *seg;
 		netdev_features_t features = netif_skb_features(skb);
 		unsigned int slen = 0, numsegs = 0;
 
@@ -1809,6 +1817,23 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (IS_ERR_OR_NULL(segs))
 			return qdisc_drop(skb, sch, to_free);
 
+		/* The segment list is accounted by the sum of its lengths,
+		 * which can exceed the original packet's accounted length, so
+		 * sum it before linking any segment and drop the whole list if
+		 * the post-split total would cross the ceiling.
+		 */
+		skb_list_walk_safe(segs, seg, nskb)
+			slen += seg->len;
+
+		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {
+			kfree_skb_list_reason(segs, SKB_DROP_REASON_QDISC_DROP);
+			WRITE_ONCE(flow->dropped, flow->dropped + 1);
+			WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
+			qdisc_qstats_overlimit(sch);
+			return qdisc_drop_reason(skb, sch, to_free,
+						 QDISC_DROP_OVERLIMIT);
+		}
+
 		skb_list_walk_safe(segs, segs, nskb) {
 			skb_mark_not_on_list(segs);
 			qdisc_skb_cb(segs)->pkt_len = segs->len;
@@ -1820,7 +1845,6 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 			qdisc_qlen_inc(sch);
 			numsegs++;
-			slen += segs->len;
 			q->buffer_used += segs->truesize;
 			WRITE_ONCE(b->packets, b->packets + 1);
 		}
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 6aa5829d6961..f2770a438070 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -116,15 +116,18 @@ static struct sk_buff *codel_peek(struct Qdisc *sch)
 static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			       struct sk_buff **to_free)
 {
-	struct codel_sched_data *q;
+	struct codel_sched_data *q = qdisc_priv(sch);
 
-	if (likely(qdisc_qlen(sch) < sch->limit)) {
-		codel_set_enqueue_time(skb);
-		return qdisc_enqueue_tail(skb, sch);
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
+		     QDISC_MAX_BACKLOG)) {
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
index 4947def7c49e..ff5d55d502f2 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -392,6 +392,8 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 	struct dualpi2_skb_cb *cb;
 
 	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
+		     QDISC_MAX_BACKLOG) ||
 	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
 		qdisc_qstats_overlimit(sch);
 		if (skb_in_l_queue(skb))
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 969b2510b0b8..e98bafa47da3 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -201,6 +201,13 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 	idx--;
 
+	if (unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
+		     QDISC_MAX_BACKLOG)) {
+		q->drop_overlimit++;
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	codel_set_enqueue_time(skb);
 	flow = &q->flows[idx];
 	flow_queue_add(flow, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..6e62ce991c1c 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -155,7 +155,9 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
 
 	/* Checks if the qdisc is full */
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
+		     QDISC_MAX_BACKLOG)) {
 		q->stats.overlimit++;
 		goto out;
 	} else if (unlikely(memory_limited)) {
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3b7863ffd284..64095d27decc 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -89,7 +89,9 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct pie_sched_data *q = qdisc_priv(sch);
 	bool enqueue = false;
 
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) >
+		     QDISC_MAX_BACKLOG)) {
 		WRITE_ONCE(q->stats.overlimit, q->stats.overlimit + 1);
 		goto out;
 	}
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d7598214270b..dff3d8b0556b 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -76,6 +76,13 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned int len;
 	int ret;
 
+	len = qdisc_pkt_len(skb);
+	if (unlikely((u64)sch->qstats.backlog + len > QDISC_MAX_BACKLOG)) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	q->vars.qavg = red_calc_qavg(&q->parms,
 				     &q->vars,
 				     child->qstats.backlog);
@@ -135,7 +142,6 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		break;
 	}
 
-	len = qdisc_pkt_len(skb);
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
 		qstats_backlog_add(sch, len);
-- 
2.43.0

