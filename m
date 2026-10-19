Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD25D4E2F00
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407758; cv=none; b=P+Z3JL9unpHW5b0JSdO7IlVAdO+BP4Yg+1tgzoPqr4XngD2DBlU7x+kZH8maFKgPChG9A9Ttfp5WRl9HDGA1YEGwgAy73NbIzj12vw8E4dfTzbYTd1hK5c0DALitpNVO0+4SN3ul4a30TVRKZUBFedGDGfWqkqCGiWqHeZLMRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407758; c=relaxed/simple;
	bh=IgKnob41AqEqkZUIucjmVf1lZF33ZewEgdmWReY8e6Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=te6nkYqcOEaY2u2kyUNqhlJwYvXn7CtiGU1n3AcW5pyHK5ln51fPvvTf8AkRG0Izmopb5u6tYbu18rcZDkEx7KR1x054CXiEDQoRv4+xz+c12sIKCMvG6L8Ch6Upq7QVWMS3JeEeH6KaocuGZ7y27/neCz3GgYkAC5vBjU7ISXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agWMBpiI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agWMBpiI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF801F000C6;
	Mon, 19 Oct 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792407756;
	bh=ktCpF9+n8L14IIO/VaSeqgBQfT0hofkXd82RZT+KV6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=agWMBpiIK0DcixS7UCTJophA8jSYCojDXKjhCvRU0HctNMBj/Kef263gjP8iBedqI
	 hveuYRS8CsSeg8HkFZLhFhdkirGNNYM6rDtoOgT0ydqrvtTKCqU3Qr7LZ28dZ3XH10
	 XFPRD/Qpi6j4JGxNs8ERjCDC2DlphYVmwB4UNSp1toczD5+AIpPGs9BPwyHBP4M6zG
	 7r48omBF3tk+wYoZGMy7N0p7f0pxXPmTfQxLkAASAECwreiYuFwtxs9NiZ54116Pr2
	 Y24HkRgNqqaq5qdUQr2qToNZ7R2HU9pINtveNZI5Gg8Ec9l04JE0yuHmHFrvHOcCbu
	 cxuasIQfyfC5Q==
Subject:
 Re: [PATCH net-next v2 3/4] net/sched/sch_cake: widen buffer_used to u64
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, toke@toke.dk, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, victor@mojatatu.com
Date: Mon, 19 Oct 2026 11:02:35 +0000
Message-ID: <179240775548.3135.13417952956870390247@kernel.org>
In-Reply-To: <QDISC-5RTM.v2.r0.20261015051735-3@mojatatu.com>
References: <QDISC-5RTM.v2.r0.20261015051735-3@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a user-reachable unbounded-queue / OOM bug but
  has no Fixes: tag (and no stable Cc).
- [Low] Widening `q->buffer_max_used` from u32 to u64 makes the lockless
  access from the dump path non-atomic on 32-bit architectures.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  cake_enqueue()'s memory-limit drop loop can spin forever when the…

--

net/sched/sch_cake: widen buffer_used to u64

This commit widens cake_sched_data.buffer_used and buffer_max_used from
u32 to u64, so a 32-bit wrap can no longer bypass the memory limit
admission test in cake_enqueue(). It also splits the ACK-filter truesize
delta into two separate operations, and clamps the exported MEMORY_USED
statistic to U32_MAX.

Closes: https://sashiko.dev/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.com/

> Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818095927.15901-1-jhs@mojatatu.com
> Link: https://lore.kernel.org/netdev/20260818095927.15901-1-jhs@mojatatu.com/
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

[Severity: Low]
Should this patch have a Fixes: tag?

The u32 buffer_used, buffer_max_used and buffer_limit fields were added
by the original CAKE commit. That commit also added the admission test
and the drop loop in cake_enqueue().

With memlimit 4294967295, cake_reconfigure() sets buffer_limit to
U32_MAX. On those kernels the u32 test "q->buffer_used > q->buffer_limit"
can never be true.

The gred/bfifo/plug fix referenced in the commit message, 4c660ee8c809,
carries a Fixes: tag. Would this trailer work here?

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")

> diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> index 445977a235725..602c4e913c0ce 100644
> --- a/net/sched/sch_cake.c
> +++ b/net/sched/sch_cake.c

[ ... ]

> @@ -1850,7 +1851,8 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
>  			qdisc_qstats_drop(sch);
>  			ack_pkt_len = qdisc_pkt_len(ack);
>  			WRITE_ONCE(b->bytes, b->bytes + ack_pkt_len);
> -			q->buffer_used += skb->truesize - ack->truesize;
> +			q->buffer_used += skb->truesize;
> +			q->buffer_used -= ack->truesize;
>  			if (q->config->rate_flags & CAKE_FLAG_INGRESS)
>  				cake_advance_shaper(q, b, ack, now, true);
>  

[Severity: High]
This is a pre-existing issue, but the per-flow backlogs[] counter is
still u32 and seems to have the same kind of 32-bit wrap. Can that make
the drop loop in cake_enqueue() spin forever?

A size table can raise qdisc_pkt_len() up to QDISC_PKT_LEN_MAX (1 MiB) in
__qdisc_calculate_pkt_len() without changing skb->truesize. The non-split
path in cake_enqueue() then does:

    WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + len - ack_pkt_len);

So 4096 such packets queued in one flow wrap backlogs[idx] to 0.

Suppose memlimit is chosen so that the 4096th enqueue is the first one
over buffer_limit. At that point overflow_timeout is still 0, so the heap
has never been maintained. overflow_heap[0] still has its cake_init()
layout and points at tin 0/flow 0, which can be empty.

The loop then runs:

	while (q->buffer_used > q->buffer_limit) {
		drop_id = cake_drop(sch, to_free);
		...
	}

cake_drop() rebuilds the heap. Every key from cake_heap_get_backlog() is
0, and cake_heapify() only swaps when "lb > mb" or "rb > mb", so the
empty root stays at index 0. Then:

	skb = dequeue_head(flow);
	if (unlikely(!skb)) {
		/* heap has gone wrong, rebuild it next time */
		q->overflow_timeout = 0;
		return idx + (tin << 16);
	}

buffer_used is not reduced, so the loop condition stays true. Every
later rebuild picks the same empty root.

This would spin with the qdisc root lock held and BH disabled. The
preconditions are CAP_NET_ADMIN (a user namespace is enough), a stab, a
chosen memlimit, and a dequeue that is held back.

Would it make sense to also widen backlogs[], or to have the loop stop
when cake_drop() dequeues nothing?

[ ... ]

> @@ -3028,7 +3030,8 @@ static int cake_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
>  
>  	PUT_STAT_U64(CAPACITY_ESTIMATE64, READ_ONCE(q->avg_peak_bandwidth));
>  	PUT_STAT_U32(MEMORY_LIMIT, READ_ONCE(q->buffer_limit));
> -	PUT_STAT_U32(MEMORY_USED, READ_ONCE(q->buffer_max_used));
> +	PUT_STAT_U32(MEMORY_USED,
> +		     min_t(u64, READ_ONCE(q->buffer_max_used), U32_MAX));

[Severity: Low]
On 32-bit architectures, can this READ_ONCE() of the now 64-bit
buffer_max_used tear?

cake_dump_stats() runs without the qdisc root lock, because
tc_fill_qdisc() passes a NULL lock to gnet_stats_start_copy_compat().
Meanwhile cake_enqueue() updates the field:

	if (q->buffer_used > q->buffer_max_used)
		WRITE_ONCE(q->buffer_max_used, q->buffer_used);

On 32-bit, a u64 READ_ONCE()/WRITE_ONCE() is usually two 32-bit accesses.
When the peak crosses 2^32, a dump could see the new low word with the
old high word of 0. It would then export a small MEMORY_USED value
instead of the U32_MAX clamp.

The window opens at most once per qdisc lifetime. Other u64 stats in
this function, such as avg_peak_bandwidth and b->bytes, are already read
the same way.

>  	PUT_STAT_U32(AVG_NETOFF, ((READ_ONCE(q->avg_netoff) + 0x8000) >> 16));
>  	PUT_STAT_U32(MAX_NETLEN, READ_ONCE(q->max_netlen));
>  	PUT_STAT_U32(MAX_ADJLEN, READ_ONCE(q->max_adjlen));

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-5RTM.v2.r0.20261015051735%40mojatatu.com
