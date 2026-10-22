Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695773;
	b=dWtc537QHKXrDLvIRb5gL0E9yln1MR35xMJwqkoFVPPPUZuMKZpTj25Lo5sJgBUWgBc4
	 KMwowevY+K9BWtsKy5SBGKfEQP0fAyva9xmYv2y86ToFCEGdc8MG1Zd+zLZVZ9vpWIZcb
	 /CQYuop3QVjEr/ZgVEZRT4fN6zg5aEsG6tRalijO7QkGWja5rwY29F6LJsM2UCiMv/iNw
	 mbppiOxPvyI8m0hOpngqj8TKiKbrBzSf+EBU+oiOYa9fatWdCNLZNEKm6B6gHV0KXlgI2
	 9jYHJp//7w0Kd7hWNAx9Go6N/wTME8mutyVAKuM4ayxpTQn/1ZCNxocZt0fIVTHkM0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695773;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=nLZ8jXTTFcnMa4WgNgZefvmsMAB9BXoZPjsIiow8nm0=;
	b=dEWiT9x6dfKPZz9KHOGm17lrXvF/mZ2YHsXpqv6kddgbzhdyXu3bYOwgKv3md8Pcm13d
	 1HwGxyUxHBTvYSKLFJJFR9xxkkHgqBZDh4Nb2nLGDiO9IVmcO2WFfEaPXz5EjlGqvDMhs
	 MzbVJxCySrrrFqEjmyCkTmNSr8TYSIGVCeXnozacgHRH9tnXS0DpGDO3SAiOik94xhmhC
	 GKDEH7fjc8p5YkBmko+o2fvlken4PhxxFXQmgdJUbPCtFR9XHn1rmaX8lHjXs+1jom2nR
	 +cUHhpCwXNacHnpk4O6zPbykyUbSSZ8zRVuaU/s6EzIBCY5fNS9qUFvHOmKI/qvKwMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqLUqTUi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7056606A323
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 19:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CqLUqTUi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65D61F01825;
	Thu, 22 Oct 2026 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792695772;
	bh=nLZ8jXTTFcnMa4WgNgZefvmsMAB9BXoZPjsIiow8nm0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CqLUqTUi2b4cUxq4sJqPNLdJWKAU8ReoxUHuoMhWoAskAMtnBmoJCA3B7s1eBiGTe
	 Yf0MI0oP5KP/O7vNlkI36wBtAMK8Y1/rObdmztphUCan2gihetksm7U6+5SWzDlvBG
	 RvTY4xu/MsYt6uYH6o7Z2mrMW7op88LE+k0q8D5pXa3SbEXRrHCnHIyc3kHKukTdJT
	 iozmE4v9FIJdAE926qOibcxFjIb7rWMlEXDYTnxclHuCQusMhOOYU+PZ8hrFKefq15
	 OtCGFm+YYXT1LX3ltK51LAUJlIr96gZx6EyeGClnFo34dhYAKxYBcx4+pLxIoNBeJx
	 AMayUjOOQo2jw==
Subject: Re: [PATCH net-next v7 3/4] net/sched: cap the accounted backlog
 before it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, toke@toke.dk, bjorn@kernel.org, sashiko-bot@kernel.org
Date: Thu, 22 Oct 2026 19:02:51 +0000
Message-ID: <179269577131.3135.3967915390403138015@kernel.org>
In-Reply-To: <QDISC-BA27.v7.r0.20261019115505-3@mojatatu.com>
References: <QDISC-BA27.v7.r0.20261019115505-3@mojatatu.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this patch, cake_enqueue() (net/sched/sch_cake.c) runs the
  new qdisc_backlog_overflow() check on the original skb, using its…
- [Medium] net/sched: red_enqueue() fails to bound child backlog on
  NET_XMIT_CN
- [Low] The commit "net/sched: cap the accounted backlog before it can
  wrap" fixes a user-triggerable bug in about ten qdiscs: u32…

Pre-existing issues:
- [Medium] red_enqueue() (net/sched/sch_red.c:79) checks RED's own
  backlog once and reserves only the original qdisc_pkt_len() L (line…

--

net/sched: cap the accounted backlog before it can wrap

This patch adds qdisc_backlog_overflow() and calls it at enqueue in
fq_codel, cake, codel, pie, fq_pie, dualpi2, RED, pfifo, plug and gred.
These qdiscs now drop a packet once the u32 sch->qstats.backlog can no
longer represent its accounted length. RED also reserves the packet length
in its aggregate backlog before handing the packet to its child.

Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/CANn89iLfMJV7ancKH1Gjzzm7ZUG-gKcrczkJjJEWN5sCuWd-ug@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CANn89i+GOFH_8g+vSV0jUj0aBqLYVWuFOrHuDggZu9kPC_m6tQ@mail.gmail.com/
Link: https://lore.kernel.org/netdev/87a4oottcj.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/87pkxks68f.fsf@toke.dk/
Link: https://lore.kernel.org/netdev/179231932946.3135.7497478990186385688@kernel.org/

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/

[Severity: Low]

Should this have a Fixes: tag?

The commit message describes a backlog wrap that users can trigger in about
ten qdiscs, including a NULL flow->head dereference in fq_codel_drop(). The
trailers only carry Reported-by, Closes and Link.

The commit this patch follows up on, 709f34f7c28d ("net/sched: fq: add
overflow bounds to quantum and initial quantum"), carries
"Fixes: afe4fd062416". Without a Fixes: tag here, it isn't clear which
stable releases need this change.

> diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
> index 1acaadb3e2cf..a5a6bdf55e0a 100644
> --- a/include/net/sch_generic.h
> +++ b/include/net/sch_generic.h
> @@ -915,6 +915,26 @@ static inline unsigned int qdisc_pkt_len(const struct sk_buff *skb)

[ ... ]

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

[ ... ]

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 0d13c4b0bfe3..91c33295b30b 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c
> @@ -1777,6 +1777,13 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		return ret;
>  	}
>  
> +	/* Drop before touching the hash or shaper state. */
> +	if (unlikely(qdisc_backlog_overflow(sch, skb))) {
> +		qdisc_qstats_overlimit(sch);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
> +	}
> +

[Severity: Medium]
On NET_XMIT_CN, red_enqueue() now undoes the reservation with
qstats_backlog_sub(sch, len). That leaves RED's backlog where the old
code left it. Both versions assume the child has already told its
ancestors about anything it dropped. Does that hold for every qdisc
red_graft() accepts?

hhf_enqueue() queues the new skb, then hhf_drop() drops the head of
the heaviest bucket. If that is the bucket it just queued to, it
returns NET_XMIT_CN without calling qdisc_tree_reduce_backlog():

	if (hhf_drop(sch, to_free) == idx)
		return NET_XMIT_CN;

skbprio_enqueue() does the same when it evicts the tail of a lower
priority band. In both cases child->qstats.backlog moves by
qdisc_pkt_len(skb) minus the evicted packet's length, while RED's
backlog does not move.

Two things follow.

First, the new guard reads RED's own backlog, but red_calc_qavg()
reads child->qstats.backlog. Neither hhf nor skbprio checks
qdisc_backlog_overflow(). Suppose a stab inflates the arriving
packets to 1 MiB while the queued ones stay small. Each eviction of a
small packet for a 1 MiB one then grows the child backlog by about
1 MiB and leaves RED's untouched. Can the child backlog wrap mod 2^32
and hand red_calc_qavg() a small value?

Second, red_dequeue() later subtracts the full qdisc_pkt_len() of a
packet RED never counted. Once the queue drains, RED's backlog sits
at 2^32 minus the net drift. Any drift from 1 byte to 1 MiB leaves it
above QDISC_MAX_BACKLOG. Evicting one 64 byte packet to admit a
1500 byte one is enough, and no stab is needed.

Before this patch a wrapped RED backlog mostly affected the reported
stats. Now it gates admission. Wouldn't red_enqueue() drop every
packet from then on, with nothing left queued to bring the counter
back?

The commit message adds pfifo because RED reads a grafted child's
backlog. Doesn't the same reasoning apply to hhf and skbprio? Should
those children correct their ancestors on NET_XMIT_CN, or should RED
check the child's backlog as well as its own?

[Severity: Medium]

Does this check also bound what the CAKE_FLAG_SPLIT_GSO branch adds to the
backlog later in cake_enqueue()?

The check uses the original skb's qdisc_pkt_len(). When a size table is
attached, that length is recomputed from skb->len and capped:

net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
    ...
	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);
	qdisc_skb_cb(skb)->pkt_len = pkt_len;
}

So qdisc_backlog_overflow() takes the len <= QDISC_PKT_LEN_MAX branch and
only guarantees 1 MiB of headroom.

The split path then adds the raw segment sum, and nothing compares that sum
against the remaining headroom:

net/sched/sch_cake.c:cake_enqueue() {
    ...
		skb_list_walk_safe(segs, seg, nskb) {
		    ...
			slen += seg->len;
		    ...
		}

		/* stats */
		qstats_backlog_add(sch, slen);
		...
		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
    ...
}

Take cake with split_gso and a stab that inflates small packets to 1 MiB.
About 4095 queued packets bring the backlog near QDISC_MAX_BACKLOG.

Could one small-MSS GSO skb with slen above the remaining headroom then wrap
sch->qstats.backlog, b->tin_backlog and b->backlogs[idx] mod 2^32?

If b->backlogs[idx] happens to wrap to exactly zero, could cake_drop() keep
selecting an empty flow from the overflow heap? Nothing is freed in that
case:

	skb = dequeue_head(flow);
	if (unlikely(!skb)) {
		/* heap has gone wrong, rebuild it next time */
		q->overflow_timeout = 0;
		return idx + (tin << 16);
	}

The buffer_limit drop loop in cake_enqueue() would then make no progress.

The last patch in the series, "net/sched: cake: hash before segmenting and
reject an overlong split", sums slen before any segment is linked. It
rejects the split when (u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG,
so this only affects this intermediate commit.

[ ... ]

> diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
> index d7598214270b..72990d0db4fd 100644
> --- a/net/sched/sch_red.c
> +++ b/net/sched/sch_red.c

[ ... ]

> @@ -136,14 +142,21 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	}
>  
>  	len = qdisc_pkt_len(skb);
> +	/* Reserve the length before the child sees the packet: netem
> +	 * can re-enqueue a clone here before the backlog is updated.
> +	 * Undo it if the child drops the packet.
> +	 */
> +	qstats_backlog_add(sch, len);
>  	ret = qdisc_enqueue(skb, child, to_free);

[Severity: Medium]

This is a pre-existing issue and was not introduced by this patch. The
commit message already says this path is left to a separate change.

red_enqueue() runs qdisc_backlog_overflow() once and reserves only the
original qdisc_pkt_len(). A child that segments the skb can raise the
queued bytes after that point. With corruption enabled, netem re-enqueues
each segment with pkt_len = seg->len and then does:

net/sched/sch_netem.c:netem_enqueue() {
    ...
		/* Parent qdiscs accounted for 1 skb of size @prev_len */
		qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));
    ...
}

qdisc_tree_reduce_backlog() applies that negative delta to every ancestor
and never checks the headroom:

	qstats_backlog_sub(sch, len);

Suppose RED's backlog is near QDISC_MAX_BACKLOG, for example because a stab
inflates packets to 1 MiB, and a GSO skb's segment sum is above 1 MiB.

Can RED's backlog and the child backlog that red_calc_qavg() reads both
still wrap mod 2^32? RED would then base its mark and drop decisions on the
wrapped value until the counters drain. tbf_segment() appears to grow the
parent backlog the same way.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v7.r0.20261019115505%40mojatatu.com
