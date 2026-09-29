Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA582DCBEC
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 00:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643094; cv=none; b=gAzrWxC6jeiIUr0YY23N99HVfyTEWSojDYVtbCSwOKZPlAb+Z0R3+pgmqY68lg2vnA0KZKhCWDSuzyATv0Qlyzk8RQ6IPoB4/vEvmorTiLkP76FTlGPhB94qkMR2k9VD+7cC4AvmTCNFmWawP4z2XcYBVKj1xcPlfusK99rQsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643094; c=relaxed/simple;
	bh=5Jo/LVs1NiR4a23GVAHSc9ev//68bPcwvyWM+GD7oHY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZlkIYgb5Pp8S5dsxF/DiSB/mJm8uFpd8w8/u3xFvd289qkGA07AlFQu8HrwixR7XxbzdIIwotW63uCyXo18py9Ns/43iuudYIQATMSFhJ9gPsIB9AUJh9ia/RvzMFl2w9lHVt+Wg3obqQmU0KFMUAwKRXziw59V3UZwOnGOchk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGDyw3PV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGDyw3PV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C5A1F000FF;
	Tue, 29 Sep 2026 00:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790643091;
	bh=lGf2KJKzyBuljoWFWGkmxBW897TH+nbwcpbOBcWQdXI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AGDyw3PVybTKL6L2JykmGRvLRq4bWne57d+vh1+46/eNCaklu5/8pcYM5neWIgV+Z
	 KzjM5RX6Ev9HANxaolWAYHpRLiMGG73ZvqyK4WoDGWpKjHhh598exjVNsJLKabQmpB
	 fC8pu1trbo06rX+ytuAoZr6Ob2ceAp6d81o/kfVvqzDSFBTn67yWCnhCFvSGAOaP2A
	 GT0KA4oBX0fSuYKx7RGqvzlkqF5+55qofBvUaRI5zSpEk/YKtsHZH889WmxM/Wz4uO
	 mJu7nHMxZrFwY+ltCSkkbou2/cPSA0P6CmjbynFqR1hPGewNTEWufNpyKkUz7618au
	 56W7hHfZbMU9g==
Subject: Re: [PATCH net-next v2] net/sched: cap the accounted backlog before
 it can wrap
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai, toke@toke.dk, moeller0@gmx.de,
 cake@lists.bufferbloat.net, sashiko-bot@kernel.org
Date: Tue, 29 Sep 2026 00:51:29 +0000
Message-ID: <179064308977.3145.8022757162677341059@kernel.org>
In-Reply-To: <QDISC-BA27.v2.20260926123300@mojatatu.com>
References: <QDISC-BA27.v2.20260926123300@mojatatu.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 2 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] RED's new ceiling check (red_enqueue(), sch_red.c:79-84) only
  tests sch->qstats.backlog + qdisc_pkt_len(skb) before the skb goes to…
- [High] The patch moves `len = qdisc_pkt_len(skb)` in red_enqueue() from
  after the red_action() switch to the top of the function…
- [Medium] The commit message leaves GRED untouched, saying it follows a
  safe approach ("safe because its limit is checked against the…
- [Medium] In the new split-GSO pre-check in cake_enqueue(), segment
  lengths are summed into `unsigned int slen` (declared at…
- [Low] The commit fixes a user-visible bug.
- [Low] In the split-GSO path of cake_enqueue(), when the post-split
  total would cross the ceiling, the patch frees every temporary segment…
- [Low] The comment on QDISC_MAX_BACKLOG (include/net/pkt_sched.h:16-19)
  and the commit message treat QDISC_PKT_LEN_MAX (1 MiB) as the maximum…
- [Low] The new RED ceiling rejection in red_enqueue() (sch_red.c:80-84)
  only calls qdisc_qstats_overlimit() and qdisc_drop_reason().

--

net/sched: cap the accounted backlog before it can wrap

This patch adds an enqueue-side check to fq_codel, cake, codel, pie,
fq_pie, dualpi2 and RED. The check drops a packet when the 32-bit
sch->qstats.backlog would cross QDISC_MAX_BACKLOG
(U32_MAX - QDISC_PKT_LEN_MAX). The goal is to stop a crafted stab from
wrapping the backlog counter and corrupting AQM drop decisions.

Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/

> This follows the existing bfifo/gred approach
> (safe because its limit is checked against the accounted packet length);

[Severity: Medium]
Is this accurate for GRED? In non-WRED mode (plain or RIO),
gred_backlog() returns the per-VQ q->backlog. That means gred_enqueue()
only checks each virtual queue against its own q->limit:

net/sched/sch_gred.c:gred_enqueue() {
    ...
	if ((u64)gred_backlog(t, q, sch) + qdisc_pkt_len(skb) <= q->limit) {
		q->backlog += qdisc_pkt_len(skb);
		return qdisc_enqueue_tail(skb, sch);
	}
    ...
}

Every accepted packet is still added to the shared 32-bit
sch->qstats.backlog through qdisc_enqueue_tail(). Each q->limit is capped
at sch->limit, but there can be up to 16 VQs.

With two or more VQs whose limits add up to more than 4 GiB, plus the
same 1 MiB stab, can the aggregate wrap?

Once it wraps, the pass-through admission compares against a value that
is too small:

	if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=
			sch->limit))
		return qdisc_enqueue_tail(skb, sch);

gred_backlog() returns this same aggregate in WRED mode. The WRED idle
check in gred_dequeue() also reads it if the table is switched to WRED
while packets are still queued. So a wrapped value could reach
red_calc_qavg().

Should GRED get the same QDISC_MAX_BACKLOG check, or should the commit
message be changed?

> Reported-by: Sashiko (nipa) <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101130.16203-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260818101130.16203-1-jhs@mojatatu.com/
> Tested-by: hybris <hybris@mojatatu.ai>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this have a Fixes: tag? The commit message describes a bug that
can be reached from a user namespace and includes a reproducer, but
there is no Fixes: tag, so the stable tooling will not pick it up
automatically.

QDISC_MAX_BACKLOG also depends on QDISC_PKT_LEN_MAX and on the pkt_len
clamp in __qdisc_calculate_pkt_len(). Both come from commit 8f735d64382d
("net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup").

Could the commit message mention that dependency? A backport without it
will not build. 8f735d64382d has its own Fixes: 1da177e4c3f4, so it will
probably reach stable anyway.

> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 90d3e7943b19a..351b92f956efc 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -13,6 +13,11 @@
>  #define DEFAULT_TX_QUEUE_LEN	1000
>  #define STAB_SIZE_LOG_MAX	30
>  #define QDISC_PKT_LEN_MAX	(1 << 20)	/* 1 MiB */
> +/*
> + * Largest accounted backlog for which enqueuing one more maximum-size
> + * packet cannot wrap the 32-bit sch->qstats.backlog.
> + */
> +#define QDISC_MAX_BACKLOG	(U32_MAX - QDISC_PKT_LEN_MAX)

[Severity: Low]
Is QDISC_PKT_LEN_MAX really the largest possible accounted packet length?
The clamp is only applied in __qdisc_calculate_pkt_len(), which runs only
when a size table is attached:

	pkt_len = clamp_t(int, pkt_len, 1, QDISC_PKT_LEN_MAX);

Without a stab, qdisc_pkt_len_segs_init() sets the length with no clamp:

	qdisc_skb_cb(skb)->pkt_len += (gso_segs - 1) * hdr_len;

packet_snd() skips the MTU check for GSO packets and can build skbs
larger than 500 KB. virtio_net_hdr_to_skb() only forces
gso_size >= TCP_MIN_GSO_SIZE. So a GSO skb can carry an accounted length
well above 1 MiB.

The new checks compare in u64 against the real length, so they do not
wrap on their own. Still, the "one more maximum-size packet cannot wrap"
invariant in this comment and in the commit message does not hold. The
RED child segmentation question below relies on the same headroom
assumption.

>  
>  struct qdisc_walker {
>  	int	stop;
> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index dc93267029e70..6a16546aa5b0e 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1801,7 +1809,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		WRITE_ONCE(b->max_skblen, len);
>  
>  	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GSO) {
> -		struct sk_buff *segs, *nskb;
> +		struct sk_buff *segs, *nskb, *seg;
>  		netdev_features_t features = netif_skb_features(skb);
>  		unsigned int slen = 0, numsegs = 0;
>  
> @@ -1809,6 +1817,23 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		if (IS_ERR_OR_NULL(segs))
>  			return qdisc_drop(skb, sch, to_free);
>  
> +		/* The segment list is accounted by the sum of its lengths,
> +		 * which can exceed the original packet's accounted length, so
> +		 * sum it before linking any segment and drop the whole list if
> +		 * the post-split total would cross the ceiling.
> +		 */
> +		skb_list_walk_safe(segs, seg, nskb)
> +			slen += seg->len;
> +
> +		if (unlikely((u64)sch->qstats.backlog + slen > QDISC_MAX_BACKLOG)) {

[Severity: Medium]
Can slen wrap before the u64 comparison? slen is still an unsigned int.
If the segment list adds up to more than 4 GiB, the sum wraps and the
check passes with a small value.

cake would then add the wrapped slen to sch->qstats.backlog,
b->tin_backlog and b->backlogs[idx], while the queued segments keep
their real lengths. Later dequeue or cake_drop() subtractions would then
underflow those counters.

Here is how that size might be reached:

  - packet_snd() skips the MTU check for GSO packets and has no
    GSO_MAX_SIZE cap.
  - packet_alloc_skb() allows about 557 KB of order-3 frags plus a large
    linear part.
  - virtio_net_hdr_to_skb() only raises gso_size to TCP_MIN_GSO_SIZE (8).
  - ipv6_gso_pull_exthdrs() walks any number of GSO-capable extension
    headers.

A TCPv6 DODGY skb with about 60 KB of extension headers and 560 KB or
more of payload at gso_size 8 would split into more than 70k segments of
about 60 KB each. pkt_segs is a truncated u16 but is still > 1, so the
split path is taken.

This needs skb_segment() to succeed at more than 4 GiB of GFP_ATOMIC
allocations from a single packet. Not every check on the segmentation
path has been traced. Would a u64 accumulator for this pre-check be
simpler than working out whether it can happen?

> +			kfree_skb_list_reason(segs, SKB_DROP_REASON_QDISC_DROP);
> +			WRITE_ONCE(flow->dropped, flow->dropped + 1);
> +			WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
> +			qdisc_qstats_overlimit(sch);
> +			return qdisc_drop_reason(skb, sch, to_free,
> +						 QDISC_DROP_OVERLIMIT);
> +		}

[Severity: Low]
When this ceiling is hit, the segments are freed with
SKB_DROP_REASON_QDISC_DROP. The original skb is then also dropped with
QDISC_DROP_OVERLIMIT.

Doesn't that produce N+1 kfree_skb tracepoint and drop-monitor events,
under two different reasons, for one rejected packet? flow->dropped,
tin_dropped and qstats.drops each go up by only one.

The segments were never queued. Could they be consumed instead, or
dropped with the same overlimit reason, so the event is reported once?
That would also match the changelog's statement that this "drops with
QDISC_DROP_OVERLIMIT".

[ ... ]

> diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
> index d7598214270b8..dff3d8b0556bf 100644
> --- a/net/sched/sch_red.c
> +++ b/net/sched/sch_red.c
> @@ -76,6 +76,13 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  	unsigned int len;
>  	int ret;
>  
> +	len = qdisc_pkt_len(skb);
> +	if (unlikely((u64)sch->qstats.backlog + len > QDISC_MAX_BACKLOG)) {
> +		qdisc_qstats_overlimit(sch);
> +		return qdisc_drop_reason(skb, sch, to_free,
> +					 QDISC_DROP_OVERLIMIT);
> +	}

[Severity: High]
Does this check still bound RED's backlog when the child segments GSO
skbs? It only looks at the length before segmentation, before the skb
is handed to the child.

With a TBF child, tbf_enqueue() calls tbf_segment() when
qdisc_pkt_len(skb) > q->max_size. tbf_segment() re-accounts every
segment at its raw length and pushes the difference up to RED:

net/sched/sch_tbf.c:tbf_segment() {
    ...
		seg_len = segs->len;
		qdisc_skb_cb(segs)->pkt_len = seg_len;
    ...
	qstats_backlog_add(sch, len);
	if (nb > 0) {
		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
    ...
}

qdisc_tree_reduce_backlog() calls qstats_backlog_sub() on each ancestor.
A negative adjustment therefore grows RED's backlog by (len - prev_len)
with no ceiling check. netem_enqueue() does the same through its
netem_segment() path:

	qdisc_tree_reduce_backlog(sch, -(nb - 1), -(len - prev_len));

A DODGY GSO skb from packet_snd() has no GSO size cap, and gso_size can
be as small as TCP_MIN_GSO_SIZE (8). With maximum IPv4/TCP headers
(134 bytes), about 60 KB of payload then yields more than 1 MiB of
segment bytes. A stab can map that skb to a length just above TBF
max_size, while filler packets map to 1 MiB.

Take the commit's own RED reproducer, with the packet-limited pfifo
placed under a TBF, and RED's backlog near QDISC_MAX_BACKLOG. Can both
RED's and TBF's 32-bit backlogs still wrap?

If so, red_enqueue() would feed the wrapped child->qstats.backlog into
red_calc_qavg(), which is what this patch is meant to prevent for RED.
cake and dualpi2 re-check after segmentation, but RED with a segmenting
child does not.

[Severity: Low]
This new drop path only increments qstats.overlimits and qstats.drops.
Should it also update one of RED's own counters? red_dump_stats()
exports pdrop from q->stats.pdrop, and the uAPI defines it as:

	__u32           pdrop;          /* Drops due to queue limits */

Every other drop path in red_enqueue() updates prob_drop, forced_drop or
pdrop, so a drop at the byte ceiling never shows up in RED's xstats.
Qevent TC_ACT_SHOT drops are already missing from xstats, so the
breakdown did not add up to qstats.drops before this patch either.

[ ... ]

> @@ -135,7 +142,6 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  		break;
>  	}
>  
> -	len = qdisc_pkt_len(skb);
>  	ret = qdisc_enqueue(skb, child, to_free);
>  	if (likely(ret == NET_XMIT_SUCCESS)) {
>  		qstats_backlog_add(sch, len);

[Severity: High]
Since this read moved to the top of red_enqueue(), len is now taken
before the qe_mark tcf_qevent_handle() calls in the RED_PROB_MARK and
RED_HARD_MARK cases. Can a qevent action change qdisc_pkt_len(skb) in
between?

With RED in ecn mode and an act_ct action in the qe_mark block, act_ct
does this after a successful defragmentation:

net/sched/act_ct.c:tcf_ct_act() {
    ...
out_clear:
	if (defrag)
		qdisc_skb_cb(skb)->pkt_len = skb->len;
	return retval;
    ...
}

tcf_qevent_handle() returns the reassembled skb for any verdict other
than shot or stolen. RED then adds the stale len here, while
red_dequeue() subtracts the new length:

	qdisc_qstats_backlog_dec(sch, skb);

If the reassembled packet is larger, doesn't RED's u32 backlog underflow
to nearly 2^32, which is above QDISC_MAX_BACKLOG?

After that, every red_enqueue() would fail the new ceiling check even
with an empty child. RED would drop all traffic until the qdisc is
reset. If the stab-inflated fragment length is the larger one, the
backlog grows instead and eventually hits the ceiling too.

Before this patch, len was read after the qevents, so the two values
matched. Could the ceiling check use qdisc_pkt_len(skb) directly, and the
original read stay just before qdisc_enqueue()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-BA27.v2.20260926123300%40mojatatu.com
