Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321667;
	b=lNsWmPUtiMjh+kufuHJt/be0CnsAYJ7TyoUzvdiQdfy+3o7u++l91+H5HeWxjvTh/8rF
	 G21GoOB6kPpEmBvRzy+7NRZu9918tnBTfQQNlUmK1wA5AYqDSUUeG3oMBj8OoF1bdq8hh
	 e+/+NSRT8G4AdRpI7Bq+mY1XyVaRwpwOQyZ8VbD6P8y0fW3WtGjWUAw5OoXNoWCNQhPLx
	 +c3vItGVN8r6fVo8WjrmYXCRjs6wUTUnM7PMaCP1d6AWMUcIw4aqzTA8X3EocsWgRhGlC
	 2vgdKsE4ib3dnSQnqoE9nr0vjvesiA6FAi634HvUgYGl6KVvN5uspaMxUjbTyqpJX0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Qwbty810uRDpC5bSfUeXC/m2lTFYQc0IMObFKQAm5JY=;
	b=TdHa7roLqcMGDzIWfMV9N+w0xB/bmvxl3ObJVCmXGJOa7gWkRT/ki0T52+p//jt7dl4+
	 0NAgJvc0s5FAvN6I2wLB/jMMo3s5DMFBEg1FcgltagvFmkGMo43Tp/KV4htkepP6xlB4G
	 8/d6BJ9lIJzDTU5LY5iMRPaKDIRka/gQBgJ+vlbtTw4Hm/7hl4MCmqRLhp1c49+D6UzWb
	 tTGFS5A9Au05NmGB0LGBWO8jHsdp8qxpPwLeBS6pFZ0Rvpzaf9Vt3NJFTuiunNQ7mUA1A
	 RUAJotNCbuv8HAE6gQhcZSnkSuWcL0hjxwPHcZP/r/IWBhjYuBYrzguO6U2WmRJz6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GYugUP9H;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374BB60A2607
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 374BB60A2607
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=GYugUP9H
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5495d549924so21465781cf.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1794321665; x=1794926465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qwbty810uRDpC5bSfUeXC/m2lTFYQc0IMObFKQAm5JY=;
        b=GYugUP9HpnIJ1qf5Bq2rYgdkn6nuR6nDUFITYAlxH4/zMrn/VtsDyM+gUz767oIPGx
         IRmmoQBAdKCLut0b8r0qhO2LucG2rotB62e/jejHpNdWDzpGwJ52PnhOeTf+9Af3MLfM
         9uwfbxfwpj5laie5x26TeypHAHaVzndwP7miw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794321665; x=1794926465;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qwbty810uRDpC5bSfUeXC/m2lTFYQc0IMObFKQAm5JY=;
        b=H0ug7L0YGnLyCb8VO9+7atNU5bOndpXns/CA1aGR0qw1OnZd0Z+AqvwXffyve5nR6L
         BzVzpse3+K0ejFr0WYfSE3XvO2TR3BITa8qX9viFRp9f66yH7X2AXrzqmWEAAz+f5Xbs
         zxJ2xVVyeh6kCu0avgh2Kkml3l79m6w0pVg8jeKKyWYB/e7sWFOWMrezYw0395maYoOZ
         X/UmH3MMazzz1boUc0pRb1zXV/DDHBbxSnTfbYfWTDlVw9sAlpqmIBSjPflmBzf4V1zC
         hteSqSENPbXmrsyIm2czRhMEUyxdlRRuiWD/VsaoggxS+R4LniklHBp8wa4vuLaD/52x
         BvxQ==
X-Gm-Message-State: APuU4Z/8Zkak0Ixc51CBhZpD1kCfrIuzg/+fR/WogoBX4HsYqpaWZPlj
	qFV4HlwxaY2awKX3jIVcF7174FZ90iWPVf1CUP1v55+monvpzKLs5Zr/lI/6Ce/gXcMDATRqMjY
	KOK8=
X-Gm-Gg: AYBFou19DPvuWcA0/DtolIC0PqwmyklCiAe7GImRyLhcaIkX8O0e4hjIqla1i8PbWXB
	P6sJqrbS8hSxYdNC3oQDQbPSa1Y0dmS6mIFL4A7th3qu+AIbBohZlZOfTuBrVqeo1ewbaRY36ZJ
	r20We/LYhedJUq61rwswVxktHTxwxJ0lPHsohRZKWJi+bJ24PNPTkp5eoLXhOEOuEh893I4WKKh
	OY9SZ20LQu/06fUQfVvsyZhB2JbDhRSyk+8KlgfOSVJjcKmB4S+4+RcM75fdKc3dIVxjxQkmfoc
	VmsUMx5UEc6ZV74X09ho0Rw11uggHBUhgp0svTqQKIEqgVgjjQCryJYt8G0kVadgWhV7SGqXFJ/
	4ExFg0YHCKx4BhKagLkBaN8EymvWHrqz0zBbW6fMB9+swSXDGNYOocmrJE0VQhMRnQVxWK/c3Th
	cXD97B+bDt9tSB691AIsHTCyVKxOnN/bSk8Btj8LXqL++GW6FWtWcMRAmH6z2rP6oYfvanazxBf
	YDE0rRNFntptQ/iX4ARppf4thNjQblQqKI7tSeKvMLiV8yDYs5Az18jsJyUyzZZ+SwSkqYipxpg
	ZJmdsz9YZK054N0pUTX4T/3jzV1FFo0rkzVs2MTCT5b7w7d6WyF8khovKWiZEsha2AHNDpKtNCc
	=
X-Received: by 2002:ac8:5c95:0:b0:533:2feb:9fe0 with SMTP id d75a77b69052e-5552771636bmr38314451cf.31.1794321664920;
        Tue, 10 Nov 2026 06:41:04 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f00f6eb88sm1679276d6.39.2026.11.10.06.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:41:04 -0800 (PST)
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
Subject: [PATCH net-next v9 3/4] net/sched: cap the accounted backlog before it can wrap
Date: Tue, 10 Nov 2026 09:40:54 -0500
Message-Id: <QDISC-BA27.v9.r0.20261108195325-3@mojatatu.com>
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

This is a followup of commit 709f34f7c28d ("net/sched: fq: add overflow
bounds to quantum and initial quantum") as reported by Sashiko.

The issue: fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo,
plug and (non-WRED) gred account every enqueued packet's stab-adjusted
length into the 32-bit sch->qstats.backlog. A crafted tc size table
inflates qdisc_pkt_len() up to QDISC_PKT_LEN_MAX (1 MiB), and a dodgy
GSO skb can account even more through qdisc_pkt_len_segs_init(), so a
few thousand packets wrap the counter mod 2^32.

The AQM then reads a small backlog and makes the wrong drop decision,
and the dequeue-side subtractions leave it corrupt (for non-WRED gred
it is the reported stats and the dequeue-side subtractions that go
wrong instead). In fq_codel a wrapped per-flow backlog can also make
fq_codel_drop()'s scan pick an empty flow, dereferencing a NULL
flow->head.

The Fix: drop at enqueue once the stored backlog cannot represent the
incoming packet's accounted length.

Ordinary packets (qdisc_pkt_len() at most QDISC_PKT_LEN_MAX) are
covered by a standing ceiling: drop once the backlog is within
QDISC_MAX_BACKLOG (U32_MAX - QDISC_PKT_LEN_MAX) of the wrap point, the
largest backlog one more 1 MiB packet cannot wrap, so there is no
per-enqueue 64-bit add.

A larger wire estimate is checked against the space that actually
remains (len > U32_MAX - backlog): qdisc_pkt_len_segs_init() adds the
headers replicated on every output segment, so a supported small-MSS
BIG TCP aggregate can carry a wire estimate above 1 MiB while its raw
length stays within GSO_MAX_SIZE, and such traffic must pass on an
empty queue.

qdisc_pkt_len() itself stays truthful for every input: it is not
clamped and the initializer keeps succeeding, so BPF
__sk_buff.wire_len, act_police and the HTB/TBF shapers read the real
length, and sch_handle_ingress() -- which ignores the initializer's
return value and reads pkt_segs for packet statistics -- keeps
complete metadata.

Cover sch_plug, pfifo and non-WRED sch_gred as well. In RED, account the
packet before handing it to the child, bound the child backlog too, and
re-derive the aggregate from pre-reservation snapshots on failure.

The guard bounds each qdisc's own enqueue path: a child that segments a
GSO skb (tbf, netem) can still grow a parent's aggregate through
qdisc_tree_reduce_backlog()'s unclamped byte delta, which is left to a
separate change.

CAKE's split-GSO branch is the other exception; 4/4 sums and checks those
segments before linking any of them.

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
Link: https://lore.kernel.org/netdev/179231932946.3135.7497478990186385688@kernel.org/
Link: https://lore.kernel.org/netdev/179269577131.3135.3967915390403138015@kernel.org/
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

---

v8 -> v9: bound the child backlog as well as RED's aggregate, and
re-derive the aggregate from the pre-reservation snapshots so both
child conventions stay in step: leaves that reduce their ancestors on
NET_XMIT_CN (pfifo_head_drop, sfq, fq_codel) and leaves that do not
(hhf, skbprio).  (Sashiko nipa review of v7)
---
 include/net/pkt_sched.h   |  1 -
 include/net/sch_generic.h | 20 +++++++++++++++++
 net/sched/sch_cake.c      |  7 ++++++
 net/sched/sch_codel.c     | 16 ++++++++------
 net/sched/sch_dualpi2.c   |  1 +
 net/sched/sch_fifo.c      |  6 +++++
 net/sched/sch_fq_codel.c  |  9 ++++++++
 net/sched/sch_fq_pie.c    |  3 ++-
 net/sched/sch_gred.c      |  9 ++++++++
 net/sched/sch_pie.c       |  3 ++-
 net/sched/sch_plug.c      |  9 +++++++-
 net/sched/sch_red.c       | 46 ++++++++++++++++++++++++++++++++++-----
 12 files changed, 114 insertions(+), 16 deletions(-)

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
index 1acaadb3e2cf..a5a6bdf55e0a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -915,6 +915,26 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
 	return qdisc_skb_cb(skb)->pkt_len;
 }
 
+#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
+
+/* Largest backlog that still has room for one more 1 MiB packet. */
+#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
+
+/* Would this packet's accounted length wrap sch->qstats.backlog?
+ * Packets up to QDISC_PKT_LEN_MAX fit below QDISC_MAX_BACKLOG; GSO
+ * can make the length larger, so compare against the real headroom.
+ */
+static inline bool qdisc_backlog_overflow(const struct Qdisc *sch,
+					  const struct sk_buff *skb)
+{
+	u32 backlog = READ_ONCE(sch->qstats.backlog);
+	u32 len = qdisc_pkt_len(skb);
+
+	if (likely(len <= QDISC_PKT_LEN_MAX))
+		return backlog > QDISC_MAX_BACKLOG;
+	return len > U32_MAX - backlog;
+}
+
 static inline unsigned int qdisc_pkt_segs(const struct sk_buff *skb)
 {
 	u32 pkt_segs = qdisc_skb_cb(skb)->pkt_segs;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index dfc187f48a2f..3fd13bf6f3ce 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1781,6 +1781,13 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return ret;
 	}
 
+	/* Drop before touching the hash or shaper state. */
+	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	/* choose flow to insert into */
 	b = cake_select_tin(sch, skb);
 	idx = cake_hash(b, skb, q->config->flow_mode, flow_override,
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index a1ba2e355f2d..78c5d72d6406 100644
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
+	    unlikely(qdisc_backlog_overflow(sch, skb))) {
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
index 4947def7c49e..7331f0ec1c8f 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -392,6 +392,7 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 	struct dualpi2_skb_cb *cb;
 
 	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_overflow(sch, skb)) ||
 	    unlikely((u64)q->memory_used + skb->truesize > q->memory_limit)) {
 		qdisc_qstats_overlimit(sch);
 		if (skb_in_l_queue(skb))
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index 1b6388d50967..16c8d4f74e7e 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -29,6 +29,9 @@ static int bfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 static int pfifo_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 struct sk_buff **to_free)
 {
+	if (unlikely(qdisc_backlog_overflow(sch, skb)))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
@@ -43,6 +46,9 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(READ_ONCE(sch->limit) == 0))
 		return qdisc_drop(skb, sch, to_free);
 
+	if (unlikely(qdisc_backlog_overflow(sch, skb)))
+		return qdisc_drop(skb, sch, to_free);
+
 	if (likely(sch->q.qlen < READ_ONCE(sch->limit)))
 		return qdisc_enqueue_tail(skb, sch);
 
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index e6c87a32950f..a83f20534be1 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -201,6 +201,15 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 	idx--;
 
+	/* Drop before the flow is touched, so a dropped packet cannot
+	 * create or update flow state.
+	 */
+	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
+		q->drop_overlimit++;
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	codel_set_enqueue_time(skb);
 	flow = &q->flows[idx];
 	flow_queue_add(flow, skb);
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 5982847df8f8..9f927a08b7bc 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -155,7 +155,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	memory_limited = q->memory_usage > q->memory_limit + skb->truesize;
 
 	/* Checks if the qdisc is full */
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_overflow(sch, skb))) {
 		q->stats.overlimit++;
 		goto out;
 	} else if (unlikely(memory_limited)) {
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index f3d9a7252949..de96badff654 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -170,6 +170,15 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned long qavg = 0;
 	u16 dp = tc_index_to_dp(skb);
 
+	/* Per-VQ limits don't bound the total: every VQ adds into the
+	 * same u32 backlog, so check it before picking a VQ.
+	 */
+	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	if (dp >= t->DPs || (q = t->tab[dp]) == NULL) {
 		dp = t->def;
 
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 3b7863ffd284..2a5fc493a7e5 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -89,7 +89,8 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct pie_sched_data *q = qdisc_priv(sch);
 	bool enqueue = false;
 
-	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
+	if (unlikely(qdisc_qlen(sch) >= sch->limit) ||
+	    unlikely(qdisc_backlog_overflow(sch, skb))) {
 		WRITE_ONCE(q->stats.overlimit, q->stats.overlimit + 1);
 		goto out;
 	}
diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
index b60ddfee6a68..c90b5ca60bc0 100644
--- a/net/sched/sch_plug.c
+++ b/net/sched/sch_plug.c
@@ -89,7 +89,14 @@ static int plug_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 {
 	struct plug_sched_data *q = qdisc_priv(sch);
 
-	if (likely((u64)sch->qstats.backlog + skb->len <= q->limit)) {
+	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
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
index d7598214270b..b5233d9fbf57 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -73,9 +73,22 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	enum qdisc_drop_reason reason = QDISC_DROP_CONGESTED;
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *child = q->qdisc;
+	u32 child_backlog;
+	u32 red_backlog;
 	unsigned int len;
 	int ret;
 
+	/* RED reads the child backlog into red_calc_qavg(), so bound both
+	 * counters: a child that evicts on NET_XMIT_CN can otherwise grow
+	 * its own backlog while RED's stays put.
+	 */
+	if (unlikely(qdisc_backlog_overflow(sch, skb) ||
+		     qdisc_backlog_overflow(child, skb))) {
+		qdisc_qstats_overlimit(sch);
+		return qdisc_drop_reason(skb, sch, to_free,
+					 QDISC_DROP_OVERLIMIT);
+	}
+
 	q->vars.qavg = red_calc_qavg(&q->parms,
 				     &q->vars,
 				     child->qstats.backlog);
@@ -136,14 +149,37 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	len = qdisc_pkt_len(skb);
+	/* Reserve the length before the child sees the packet: netem
+	 * can re-enqueue a clone here before the backlog is updated.
+	 */
+	red_backlog = READ_ONCE(sch->qstats.backlog);
+	child_backlog = READ_ONCE(child->qstats.backlog);
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
+		u32 propagated, grew;
+
+		/* Re-derive the aggregate from the snapshots: the child may
+		 * have dropped the packet or evicted another one, and may or
+		 * may not have reduced the ancestors' backlog itself
+		 * (pfifo_head_drop, sfq and fq_codel do; hhf and skbprio
+		 * return NET_XMIT_CN without qdisc_tree_reduce_backlog()).
+		 * Keep what the child actually accounted for, and pass the
+		 * difference on to the ancestors above RED.
+		 */
+		propagated = READ_ONCE(sch->qstats.backlog) -
+			     red_backlog - len;
+		grew = READ_ONCE(child->qstats.backlog) - child_backlog;
+		WRITE_ONCE(sch->qstats.backlog, red_backlog + grew);
+		if (propagated != grew)
+			qdisc_tree_reduce_backlog(sch, 0, propagated - grew);
+		if (net_xmit_drop_count(ret)) {
+			WRITE_ONCE(q->stats.pdrop,
+				   q->stats.pdrop + 1);
+			qdisc_qstats_drop(sch);
+		}
 	}
 	return ret;
 
-- 
2.43.0

