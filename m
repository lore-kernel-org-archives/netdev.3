Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794548528;
	b=MlXPfjp3rJM4BuIupDu+wYgVcxdYAAtk0h7X+3eyVx4AAEjwmkAyvG+7BoZlw7VM844u
	 vyYVkyY3mrzn3muCvrV293bP494ASdQbV5SAPxi6N5S0CpOJjGQVow3nx6GM6gxX98Ca3
	 Pn5b1lRpPsoMO6hWvZKs811oMxzHSyLwIfr7Ba6Ih8j4/bS7XP+1kxYS9iPc3ELwrKKF6
	 ysmq3N6y7Kn1NeGIWDgd72p3Y/me51hvYnzw8BiRAUNIc8ZysutYuvI2EMAOai9fmlZiS
	 901Ii9IOYEdwUbM6cuIvh5X2ydF198SrDnAkAPhVdzApXIH3IOz7hYfKbp3V8BqSnNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794548528;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ElOTNKrbs4yzbo+SoriTvtkj0vTROeDCGotch5zea90=;
	b=kfxc2UYtRIYqzklj6/fGaX4bBOQOkSB+AVbQ47FiLhb+BDAvE0bv+q09Jd0eCYutMqTz
	 JOVe7uwKUgr4G98p9puj7Wib0xXnL9ZMowXORJEytQHkKWA0OBZwvQ1gH9ZdQBS0Vyegq
	 /mScKGaH8vt8+SKWwF2DKop5Jn8IS7/kMmOCCxtZt84maaCSyoKOBRd4ccIOHd2XFnmWk
	 6sKJuGsniwDPhBBcBvWk4PMOJ1tTYse/50yIXi3Yv0Mzp2Lrw2RRRmJHTzC8IFve7akw+
	 1+PcnDXY0ajvyjqBk98oEnMSb9OkWOK+ZTjtlt4cKqk9UykMr0GnOaZnEzStbDGLwMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRBuAqjk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475CF606A31C
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 05:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRBuAqjk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F881F000C4;
	Fri, 13 Nov 2026 05:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794548527;
	bh=ElOTNKrbs4yzbo+SoriTvtkj0vTROeDCGotch5zea90=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CRBuAqjkIE5/MIi85EeLyoIezu/cd6LknjiapMxAr59cgSuuGHC4wYV5bQq2UNmDE
	 puO5JxNjZbckFOIRDG1ZVclLu7yX1gjNm6pjE9u0XCocwkvd0CUo5+G4XsrSZp4UDL
	 rjGiPx0KjgvTQF5HeDeLcpHl6/mkgKuizLfuy/aC9OR0bUKuHM2oRSfWhyzjNCaoJf
	 MxE6TsvU6R4xDHvozl1nLHVCj5uI10RAe7IZL/h2o4VYqEjdfh8dl6g4Udf7CN82Bn
	 CvEOPuWkk8D4kaLMokHsciK4kHtyRc87EZrRPOO/j+67zmBscIedbTkT6fBPDO64fu
	 jkpLO9xxXu07g==
Subject: Re: [PATCH net-next v9 3/4] net/sched: cap the accounted backlog
 before it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Fri, 13 Nov 2026 05:42:06 +0000
Message-ID: <179454852611.2199510.1164180308254090769@kernel.org>
In-Reply-To: <QDISC-BA27.v9.r0.20261108195325-3@mojatatu.com>
References: <QDISC-BA27.v9.r0.20261108195325-3@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The subject ('net/sched: cap the accounted backlog before it
  can wrap') reads as a general fix, but only fq_codel, cake, codel,…
- [Low] The commit message has no Fixes: tag.
- [Low] The commit message describes the current length accounting
  incorrectly in two places, and it points to an in-series patch by…
- [Low] plug_enqueue() (net/sched/sch_plug.c) changes its byte-limit
  admission test from '(u64)sch->qstats.backlog + skb->len <= q->limit'…
- [Low] In red_enqueue() (net/sched/sch_red.c:81-84), the new comment
  explains the second check, qdisc_backlog_overflow(child, skb), with:…

--

net/sched: cap the accounted backlog before it can wrap

This commit adds qdisc_backlog_overflow(), which drops a packet at enqueue
when adding its qdisc_pkt_len() would wrap the 32-bit sch->qstats.backlog.
The helper is called from fq_codel, cake, codel, pie, fq_pie, dualpi2, RED,
pfifo, plug and gred. The commit also switches plug's byte limit to
qdisc_pkt_len(), and RED now reserves the length before the child enqueue
and re-derives its backlog from snapshots when the enqueue fails.

Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/179231932946.3135.7497478990186385688@kernel.org/
Link: https://lore.kernel.org/netdev/179269577131.3135.3967915390403138015@kernel.org/

> This is a followup of commit 709f34f7c28d ("net/sched: fq: add overflow
> bounds to quantum and initial quantum") as reported by Sashiko.

[Severity: Low]
Should this have a Fixes: tag? The message describes a NULL flow->head
dereference in fq_codel_drop() after the per-flow backlog wraps. It also
describes wrong AQM drop decisions in several qdiscs.

The only commit it references is 709f34f7c28d. That commit changes sch_fq,
which this patch doesn't touch, and it doesn't look like the commit that
introduced the u32 backlog wrap.

The tags include Reported-by, Closes, Link and Reviewed-by, but none of them
names the commit(s) that introduced the problem. Examples would be the stab
size table support or the AQMs that read qstats.backlog. There is no
Cc: stable either, so stable tooling can't tell which trees need this.

> inflates qdisc_pkt_len() up to QDISC_PKT_LEN_MAX (1 MiB), and a dodgy
> GSO skb can account even more through qdisc_pkt_len_segs_init(), so a
> few thousand packets wrap the counter mod 2^32.

[Severity: Low]
Is this accurate? The SKB_GSO_DODGY branch of qdisc_pkt_len_segs_init()
already rejects wire estimates above QDISC_PKT_LEN_MAX:

net/core/dev.c:qdisc_pkt_len_segs_init() {
    ...
		if (unlikely(gso_segs > GSO_MAX_SEGS ||
			     skb->len + (u64)(gso_segs - 1) * hdr_len >
			     QDISC_PKT_LEN_MAX))
			return SKB_DROP_REASON_SKB_BAD_GSO;
    ...
}

If so, only trusted, locally built GSO can reach the
len > QDISC_PKT_LEN_MAX branch of qdisc_backlog_overflow(). That is the
BIG TCP case described later in the message.

> qdisc_pkt_len() itself stays truthful for every input: it is not
> clamped and the initializer keeps succeeding, so BPF

This doesn't match the code either. __qdisc_calculate_pkt_len() clamps
every stab-adjusted length, and the reproducer goes through that path:

net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
    ...
	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
	qdisc_skb_cb(skb)->pkt_len = pkt_len;
}

The initializer also fails for oversized dodgy GSO, as shown above. Could
this paragraph be reworded?

> CAKE's split-GSO branch is the other exception; 4/4 sums and checks those
> segments before linking any of them.

The "4/4" refers to a position in the series, which won't mean anything once
this is in git history. Could that commit be named by its subject instead?

> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 1acaadb3e2cf0..a5a6bdf55e0a1 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -915,6 +915,26 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)
>  	return qdisc_skb_cb(skb)->pkt_len;
>  }
>  
> +#define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
> +
> +/* Largest backlog that still has room for one more 1 MiB packet. */
> +#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)
> +
> +/* Would this packet's accounted length wrap sch->qstats.backlog?
> + * Packets up to QDISC_PKT_LEN_MAX fit below QDISC_MAX_BACKLOG; GSO
> + * can make the length larger, so compare against the real headroom.
> + */
> +static inline bool qdisc_backlog_overflow(const struct Qdisc *sch,
> +					  const struct sk_buff *skb)
> +{
> +	u32 backlog = READ_ONCE(sch->qstats.backlog);
> +	u32 len = qdisc_pkt_len(skb);
> +
> +	if (likely(len <= QDISC_PKT_LEN_MAX))
> +		return backlog > QDISC_MAX_BACKLOG;
> +	return len > U32_MAX - backlog;
> +}

[Severity: Medium]
The subject reads like a general fix, but this helper is only called from
fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo, plug and gred. Can
sch->qstats.backlog still wrap the same way in other qdiscs?

Several leaves add the stab-inflated qdisc_pkt_len() without the guard:

  fq_enqueue()   -> qdisc_qstats_backlog_inc(sch, skb);
  sfq_enqueue()  -> qdisc_qstats_backlog_inc(sch, skb);
  hhf_enqueue()  -> qdisc_qstats_backlog_inc(sch, skb);

fq's default limit is 10000 packets per band, across 3 bands. That is far
more than the roughly 4096 1 MiB packets needed to wrap. sfq's limit can be
set as high as maxdepth * maxflows. skbprio, netem, choke, etf and taprio
look similar.

Classful parents such as prio and htb (and also drr, ets, qfq, hfsc, cbs and
sfb) add each child's admitted length into their own u32 backlog:

  prio_enqueue() -> qstats_backlog_add(sch, len);
  htb_enqueue()  -> qstats_backlog_add(sch, len);

Each guarded child can hold a backlog just below U32_MAX, so several of them
together can still wrap the parent. The commit message names only child GSO
segmentation (tbf, netem) and CAKE split-GSO as remaining exceptions.

The patch counts stats-only corruption as in scope, since it guards pfifo and
non-WRED gred. Should the qdiscs above be covered too, or listed as known
gaps? None of the unguarded leaves seem to use sch->qstats.backlog for drop
decisions, so there the result would be wrong backlog stats in dumps.

[ ... ]

> diff --git a/net/sched/sch_plug.c b/net/sched/sch_plug.c
> index b60ddfee6a68a..c90b5ca60bc0b 100644
> --- a/net/sched/sch_plug.c
> +++ b/net/sched/sch_plug.c
> @@ -89,7 +89,14 @@ static int plug_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  {
>  	struct plug_sched_data *q = qdisc_priv(sch);
>  
> -	if (likely((u64)sch->qstats.backlog + skb->len <= q->limit)) {
> +	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
> +		qdisc_qstats_overlimit(sch);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
> +	}
> +
> +	if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
> +		   q->limit)) {

[Severity: Low]
The limit test in plug_enqueue() now uses qdisc_pkt_len(skb) instead of
skb->len, but the commit message only says "Cover sch_plug". Could this
change be mentioned?

qdisc_enqueue_tail() already counted the backlog in qdisc_pkt_len() units,
so only the measurement of the arriving packet changes (GSO replicated
headers, or stab overhead). Near the byte limit, some packets that were
admitted before will now be dropped.

This switch alone is enough to prevent the wrap. q->limit is a u32 and plug
is classless, so once this test passes,
backlog + qdisc_pkt_len(skb) <= q->limit <= U32_MAX holds.

Is the qdisc_backlog_overflow() check above it still needed? It only does
anything when q->limit > QDISC_MAX_BACKLOG. In that case it drops packets
that the limit would accept and that could not wrap the counter.

[ ... ]

> diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
> index d7598214270b8..b5233d9fbf572 100644
> --- a/net/sched/sch_red.c
> +++ b/net/sched/sch_red.c
> @@ -73,9 +73,22 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	enum qdisc_drop_reason reason = QDISC_DROP_CONGESTED;
>  	struct red_sched_data *q = qdisc_priv(sch);
>  	struct Qdisc *child = q->qdisc;
> +	u32 child_backlog;
> +	u32 red_backlog;
>  	unsigned int len;
>  	int ret;
>  
> +	/* RED reads the child backlog into red_calc_qavg(), so bound both
> +	 * counters: a child that evicts on NET_XMIT_CN can otherwise grow
> +	 * its own backlog while RED's stays put.
> +	 */
> +	if (unlikely(qdisc_backlog_overflow(sch, skb) ||
> +		     qdisc_backlog_overflow(child, skb))) {

[Severity: Low]
Is this comment still accurate, given the re-derive logic added later in
red_enqueue()? On the non-success path the patch now does:

		grew = READ_ONCE(child->qstats.backlog) - child_backlog;
		WRITE_ONCE(sch->qstats.backlog, red_backlog + grew);

The later comment names the NET_XMIT_CN cases. hhf and skbprio return CN
without calling qdisc_tree_reduce_backlog(), while pfifo_head_drop, sfq and
fq_codel do call it. In all of these, RED's backlog now moves by exactly the
child's growth, so it no longer stays put.

The comment seems to describe an earlier revision. Does the child check need
a different justification, or is it now redundant?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v9.r0.20261108195325%40mojatatu.com
