Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1064E3EEC
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971746; cv=none; b=hRk6UfVV5JcT2lBUXbNFviuU4gocOHGRL8/qSrp82G/ldCOo+LhrPdHZhHtW/iAmCAPoYfQ2SOJ6Kf9mcDVTUlW6+Es6JoOHSbidiuyePIgw0aY3CyPVegbDWAyYIENh96E+QqEp5x5vkVC2wywHoegUDjSk5b3qresZyFwHEiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971746; c=relaxed/simple;
	bh=7Tk2xoGdcBeqk4bHxj7n9GMPidbQlwnr7fWXpMNx8cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raqhcNPCZolMOPvbLs9gA2iUxaqf1ySMZap8FbiR9vb4MR2SiFIYgY3xcoGHrWaAFfnHaX8hLVOlirATgsCLEnqx5o/vhQB4+SmaoKMPSJWryEqqLTcGfxO9BQuigtAUXA1FLiA1rLeAzBlFFASzVvkVFO6yP+cH08tpq4lFpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=w0lkXdgI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="w0lkXdgI"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92ed3993c1eso13048085a.1
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 02:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791971743; x=1792576543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NZuLjVldpLEE8cXMxD2cN3s1UiF9/V43Sz5pKbSpW6w=;
        b=w0lkXdgIJUWmPsxD72tMMO7ZqD+snjq7mNGo7S2kKI8Aes4hx4urekIWl7CI0X5mSh
         ypFxFG4sdtfMYa1Y0euzVFebo78HlCefHtyBm+S25kso4OI0jzDevkEKBGGaBzNtVLXV
         vFuyRVsGmGRjy3Ikvm3sdAwuoIZWaY4nc1Evs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971743; x=1792576543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NZuLjVldpLEE8cXMxD2cN3s1UiF9/V43Sz5pKbSpW6w=;
        b=jXxs5jPNbnJojzBF4mn1EqQRx/lgqwFHc0NsjEj4WHcE7ddG6bPZmWkV2GX8EfLMJj
         pNCbDCtcEyXu+BHJ9lrjVCHPYetVmiYnyvsXYJPzglJp2lynN+bjdpJyao68HMiCVvKp
         GstzgzKR1GeG6Hqi4wZJKCEg6mWD0F2ysR7PWgHBIztHX/DC+8joUmgJKh9hwz4gu4Cj
         nhdwkRYM6Irq7qzItv43FhdWqLttNBMh29ySDdev3EzCWwTc1GRO4AFCdamFihbtQNnl
         6XPLCNwOK822hAdYopsmUZRIjOwc3ZgO9K410rDaD43ZM/OF7Kqc+5vqDZqFps6aIhz6
         KNeQ==
X-Gm-Message-State: AFq9FYLpUxT09FocotDmspB0/Nxl7lKUnefmewyGYgZlFVYwQnZmiRlO
	vi4H4sWHWFqhjBTvsCiXA3KM0J4H+plas89ifemsQVv+sSCmeF/TV4ToZHzvQiAxXagNs6jVtsH
	dFYw=
X-Gm-Gg: AYBFou3KOr1D66NZCOpoaxndnvKL7/XM3gzqk3XLRSSW+isBs+IchrrMHHiB9SjqK0q
	MchJqZ7K6j9LoUV5OBwd+lKZhFsPbbNpVRUjtOG7fQeY7Pg7+FmH9ww54AfS9hPPPdgm55VWhbu
	tRW5cjPf7JFCp38HRU4PPxxerOgHHoZK64HfSYMS6CFvANriHxdzodbF4TwuS51qk0wpIYm+zhW
	CbYFh05LdPO+J4pvXZ4RgsERFjCxV+Q5GLJmb6b9fokpyEYmQsf8E84DEqWhODad1n6I4eu71t2
	hv2OoDkJPevA6eLrG8/kHkUco90gDxxk6/r0i+gZtecSdgGIWBTA8DBUetT17zvU5K9JoRgUkES
	ihsx0ox6wuNQNkiFdbcP2vI33EUUPGqtKOiqNpi4lZ09gyo3m6CePt9QExBTfgYsUHx6hIipo16
	10EgBO7nx9AwgwGdS1fEsYHg6KWOhCImoHUvqC+4ikkXGetLlEI6qnqY7f+4MyaU06BRlBNlqFf
	2raSKCo0y4v+GryjQj6MfaUcCTCJZGEUf3ytMhO4dDU9Ng313BzQ16O1N6Y
X-Received: by 2002:a05:620a:3708:b0:93e:c12c:fbcc with SMTP id af79cd13be357-93ec12d072cmr2282204485a.72.1791971743216;
        Wed, 14 Oct 2026 02:55:43 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef5055eb3sm453074985a.33.2026.10.14.02.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 02:55:42 -0700 (PDT)
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
Subject: [PATCH net-next v6 3/4] net/sched: cap the accounted backlog before it can wrap
Date: Wed, 14 Oct 2026 05:55:31 -0400
Message-Id: <QDISC-BA27.v6.r0.20261014054826-3@mojatatu.com>
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

This is a followup of commit 709f34f7c28d ("net/sched: fq: add overflow
bounds to quantum and initial quantum") as reported by Sashiko.

The issue: fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo, plug
and (non-WRED) gred account every enqueued packet's stab-adjusted length
into the 32-bit sch->qstats.backlog, which the AQM logic reads back (for
non-WRED gred it is the reported stats and the dequeue-side subtractions
that go wrong instead). A crafted tc size table inflates qdisc_pkt_len()
up to QDISC_PKT_LEN_MAX (1 MiB), and a dodgy GSO skb can account even more
through qdisc_pkt_len_segs_init(), so a few thousand packets wrap the
counter mod 2^32. The AQM then reads a small backlog and makes the wrong
drop decision, and the dequeue-side subtractions leave it corrupt. In
fq_codel a wrapped per-flow backlog can also make fq_codel_drop()'s scan
pick an empty flow, dereferencing a NULL flow->head.

The Fix: drop at enqueue once the stored backlog is within
QDISC_MAX_BACKLOG (U32_MAX - QDISC_PKT_LEN_MAX) of the wrap point, the
largest backlog one more stab-clamped packet cannot wrap. Test the
stored backlog itself via qdisc_backlog_at_max() rather than adding the
incoming length, so there is no per-enqueue 64-bit add and the reserved
1 MiB headroom is not counted twice. Clamp the accounted length in
qdisc_pkt_len_segs_init() at initialization, before the non-GSO and
missing-transport-header returns, and again after the GSO header
estimate, so a dodgy or oversized skb cannot exceed the headroom either.
Cover sch_plug and non-WRED sch_gred too: plug admits on skb->len while
qdisc_enqueue_tail() adds qdisc_pkt_len(), and gred bounds each virtual
queue but adds every VQ into the one aggregate. pfifo is included because
RED reads a grafted child's backlog into red_calc_qavg(); it can be
reached standalone or as the default child of SFB. In RED, account the
packet to the aggregate before handing it to the child, because a
duplicating netem child re-enqueues its clone at the root while the
stored backlog is still un-updated -- one guard check must not authorize
two additions.

The guard bounds each qdisc's own enqueue path: a child that segments a
GSO skb (tbf, netem) can still grow a parent's aggregate through
qdisc_tree_reduce_backlog()'s unclamped byte delta, which is left to a
separate change.

Conditions to recreate the bug:
  ip tuntap add tun0 mode tun
  ip link set tun0 txqueuelen 32 up
  ip addr add 10.99.0.1/24 dev tun0
  tc qdisc add dev tun0 root handle 1: stab overhead 2000000000 \
      fq_codel flows 1 limit 20000 ecn
  # hold the tun fd open without reading so the backlog persists, then
  # send 6000 packets: the counter wraps and the unfixed kernel reports
  # a wrapped backlog, while the fixed one drops at the ceiling.

Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---
v5 -> v6: resend, rewritten as a series per review feedback.

The v5 posting carried a refactor, the overflow fix and unrelated
changes in a single patch, with a commit log the reviewer found hard to
read. It is split into four patches:

  0001  classifier refactor
  0002  split-GSO list iterator rename
  0003  enqueue ceiling guard plus qdisc_pkt_len_segs_init() producer clamp
  0004  cake hash key/resolve split and split-GSO relocation
---
 include/net/pkt_sched.h   |  1 -
 include/net/sch_generic.h | 15 +++++++++++++++
 net/core/dev.c            | 15 ++++++++++++++-
 net/sched/sch_cake.c      | 10 ++++++++++
 net/sched/sch_codel.c     | 16 +++++++++-------
 net/sched/sch_dualpi2.c   |  1 +
 net/sched/sch_fifo.c      |  6 ++++++
 net/sched/sch_fq_codel.c  | 11 +++++++++++
 net/sched/sch_fq_pie.c    |  3 ++-
 net/sched/sch_gred.c      | 10 ++++++++++
 net/sched/sch_pie.c       |  3 ++-
 net/sched/sch_plug.c      |  9 ++++++++-
 net/sched/sch_red.c       | 25 ++++++++++++++++++++-----
 13 files changed, 108 insertions(+), 17 deletions(-)

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
index 1acaadb3e2cf..43a3e1e9ee89 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -915,6 +915,21 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->pkt_len;
 }
 
+#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
+
+/* Largest accounted backlog one more maximum-size packet cannot wrap
+ * the 32-bit sch->qstats.backlog past.
+ */
+#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
+
+/* Backlog close enough to U32_MAX that one more packet could wrap it.
+ * A packet-limited qdisc must drop at enqueue when this holds.
+ */
+static inline bool qdisc_backlog_at_max(const struct Qdisc *sch)
+{
+	return READ_ONCE(sch->qstats.backlog) > QDISC_MAX_BACKLOG;
+}
+
 static inline unsigned int qdisc_pkt_segs(const struct sk_buff *skb)
 {
 	u32 pkt_segs = qdisc_skb_cb(skb)->pkt_segs;
diff --git a/net/core/dev.c b/net/core/dev.c
index a6951ea08961..5165bd531cd9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4215,7 +4215,12 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 	unsigned int hdr_len, tlen;
 	u16 gso_segs;
 
-	qdisc_skb_cb(skb)->pkt_len = skb->len;
+	/* Clamp from the start: the non-GSO and missing-transport-header
+	 * returns below leave pkt_len at this value, and a stabless skb
+	 * larger than QDISC_PKT_LEN_MAX would otherwise bypass the guard.
+	 */
+	qdisc_skb_cb(skb)->pkt_len =
+		min_t(unsigned int, skb->len, QDISC_PKT_LEN_MAX);
 	if (!shinfo->gso_size) {
 		qdisc_skb_cb(skb)->pkt_segs = 1;
 		return SKB_NOT_DROPPED_YET;
@@ -4268,6 +4273,14 @@ static enum skb_drop_reason qdisc_pkt_len_segs_init(struct sk_buff *skb)
 		qdisc_skb_cb(skb)->pkt_segs = gso_segs;
 	}
 	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;
+	/* (gso_segs - 1) * hdr_len can exceed QDISC_PKT_LEN_MAX for a dodgy
+	 * GSO skb, so clamp the accounted length as a size table does in
+	 * __qdisc_calculate_pkt_len(), keeping the backlog within one
+	 * stab-clamped packet of U32_MAX.
+	 */
+	qdisc_skb_cb(skb)->pkt_len = min_t(unsigned int,
+					   qdisc_skb_cb(skb)->pkt_len,
+					   QDISC_PKT_LEN_MAX);
 	return SKB_NOT_DROPPED_YET;
 }
 
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 0d13c4b0bfe3..adfe11737c66 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1777,6 +1777,16 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return ret;
 	}
 
+	/* Drop before hash/shaper state so a rejected packet disturbs
+	 * neither; the QDISC_MAX_BACKLOG margin leaves room for one more
+	 * stab-clamped packet.
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	/* choose flow to insert into */
 	b = cake_select_tin(sch, skb);
 	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index a1ba2e355f2d..ff7e72989dfc 100644
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
index 4cf3d379b8e9..7def7e7dff6c 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -215,6 +215,17 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		__qdisc_drop(skb, to_free);
 		return ret;
 	}
+
+	/* Drop before hashing so a rejected packet disturbs no flow hash;
+	 * the QDISC_MAX_BACKLOG margin leaves room for one more stab-clamped
+	 * packet.
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		q->drop_overlimit++;
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	if (do_hash)
 		idx = fq_codel_hash(q, skb) + 1;
 	idx--;
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
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index f04f425c6c44..3ef38d5cb5b5 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -170,6 +170,16 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned long qavg = 0;
 	u16 dp = tc_index_to_dp(skb);
 
+	/* The per-VQ limits do not bound sch->qstats.backlog: qdisc_enqueue_tail()
+	 * adds every VQ into the one u32 aggregate, so individually legal VQs
+	 * can wrap it. Guard the aggregate before dispatching.
+	 */
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	if (dp >= t->DPs || (q = t->tab[dp]) == NULL) {
 		dp = t->def;
 
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
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index b60ddfee6a68..bf707f6342b9 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -89,7 +89,14 @@ static int plug_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	struct plug_sched_data *q = qdisc_priv(sch);
 
-	if (likely((u64)sch->qstats.backlog + skb->len <= q->limit)) {
+	if (unlikely(qdisc_backlog_at_max(sch))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
+	if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
+		   q->limit)) {
 		if (!q->unplug_indefinite)
 			q->pkts_current_epoch++;
 		return qdisc_enqueue_tail(skb, sch);
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d7598214270b..99126c4b26bc 100644
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
@@ -136,14 +142,23 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	len = qdisc_pkt_len(skb);
+	/* Reserve the accounted length before handing the packet to the
+	 * child. A duplicating child (netem) re-enqueues its clone at the
+	 * root, re-entering this function while the stored backlog is still
+	 * un-updated; without the reservation one guard check would authorize
+	 * two additions. Roll the reservation back if the child rejects.
+	 */
+	qstats_backlog_add(sch, len);
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
-		qstats_backlog_add(sch, len);
 		qdisc_qlen_inc(sch);
-	} else if (net_xmit_drop_count(ret)) {
-		WRITE_ONCE(q->stats.pdrop,
-			   q->stats.pdrop + 1);
-		qdisc_qstats_drop(sch);
+	} else {
+		qstats_backlog_sub(sch, len);
+		if (net_xmit_drop_count(ret)) {
+			WRITE_ONCE(q->stats.pdrop,
+				   q->stats.pdrop + 1);
+			qdisc_qstats_drop(sch);
+		}
 	}
 	return ret;
 
-- 
2.43.0

