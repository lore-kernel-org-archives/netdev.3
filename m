Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96704A3D30
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146799; cv=none; b=iiaolCVvRikEU91DnYP0rorZCxkodq8ljCON5B/VcHpBhIkNFIebP+yFGsWL7VVa7Tq+HEGscC0shQ7FqlhHnPwGqwvUFjiZkIemmSDcx6E/vkKGZgJGNf0qrz5lYLZ5Bk8aFFLSFMIkQmT0u2unvAncFXnAEIexl5svHF9e/jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146799; c=relaxed/simple;
	bh=W41hpiHEq5x81StGzP8p4iu6lonZXDy/fmTR7Ya3y6Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kaNHnpHP3WfCvy1xCN5JoFMqroCm/MmWWAGZONDRjUkIHoIIn8KWFNMLbemD+k4nitfJe1qck4YzaJ2E3/uIyYG+Z1A8ZB1pccyayrhSbNn8dmYjIXcux3yuyl/HoYAV0XKoMXNW8ZN4swvF+qUpu57nyvcTnqYSRGS5UzBtZ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuXtslIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuXtslIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20321F00898;
	Fri, 11 Sep 2026 17:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789146797;
	bh=ex/S4un/KMdODR2crgfyXiez1n60SgZyuUpEc3ZD7uU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KuXtslIW1yA15cgBLdX95N2cxuz5G4Xo8x8YUv7tuDcfs9oE4NhWbxA80/u0UVe0Y
	 8lXEoKxHRBBRHtVbyC9F2yjb2KDqL+zcIkV7rRQuXwFXzRPax9621Rw+T9mWBEdYf5
	 m2mHsVyvSWr0OyL6AKrbUw/Eb6//zz3vd32DwP/5u6JsmmR34sUPfi9X+cdgeOKKuK
	 wJew+pFfiGFUDBaBzD4q0o+XuqRqRdy4XeqvAreVz6pP1V+4EvIp4PNI5gwSimF7Of
	 6HJy2+GJ/UaYnuydG7mXbJlmwVnuDwdM3+gUl2QwlmQRf/yTjjdwBu2Obokab2fst+
	 gF6cEC6fFC5AQ==
Subject: Re: [PATCH net-next v9 3/7] net_sched: sch_fq: clear past skb->tstamp
 if offloading pacing
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com
Date: Fri, 11 Sep 2026 17:13:16 +0000
Message-ID: <178914679635.219967.4563834866783696110@kernel.org>
In-Reply-To: <20260910171131.2532487-4-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-4-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] The two new clearing sites use different predicates, and the
  dequeue-side one folds in a schedule the offloading device never sees.
- [Low] Incomplete coverage of the new "clear an expired EDT before
  handing the skb to a pacing-offload device" logic on FQ's internal…

--

net_sched: sch_fq: clear past skb->tstamp if offloading pacing

When pacing offload is active, sch_fq now clears skb->tstamp for packets
whose EDT has already passed (or is within a 400 nsec slack window) so
the device does not have to compare the timestamp against the current
time.  The clearing is done in two places: in fq_classify() for fastpath
packets, and at the out: label of fq_dequeue() for regular flows.

A couple of questions about the coverage of the new clearing below.

> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index dfc7f98b600f8..a282812c192ee 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -159,6 +159,9 @@ struct fq_sched_data {
>  	u64		stat_allocation_errors;
>  };
>  
> +/* EDT timestamps to clear beyond now. */
> +static const int fq_offload_slack_ns = 400;
> +
>  /* return the i-th 2-bit value ("crumb") */
>  static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
>  {
> @@ -421,6 +424,10 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb,
>  			smp_store_release(&sk->sk_pacing_status,
>  					  SK_PACING_FQ);
>  
> +		if (offload_horizon &&
> +		    fq_skb_cb(skb)->time_to_send <= now + fq_offload_slack_ns)
> +			skb_set_delivery_time(skb, 0, SKB_CLOCK_REALTIME);
> +
>  		return &q->internal;
>  	}
>  

[ ... ]

> @@ -745,7 +753,7 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  	if (skb) {
>  		q->internal.qlen--;
>  		fq_dequeue_skb(sch, &q->internal, skb);
> -		goto out;
> +		return skb;
>  	}
>  
>  	now = ktime_get_ns();

[Severity: Low]
For packets on q->internal the clearing decision is now taken only once,
at enqueue time in fq_classify(), using the enqueue-time now.  With the
goto out changed to return skb, internal-queue packets no longer reach the
new block at the out: label, and they are returned before now is even
sampled.

fq_fastpath_check() admits a packet whose txtime is up to offload_horizon
in the future:

	if (fq_skb_cb(skb)->time_to_send > now + offload_horizon)
		return false;

and the internal queue is not single-slot:

		if (q->internal.qlen >= 8)
			return false;

So a packet can be admitted with a future txtime, sit behind up to seven
others (or behind a stopped tx queue), and by the time fq_dequeue()
returns it the txtime has expired, yet skb->tstamp is still set and the
device performs exactly the future-time comparison the change is meant to
avoid.  Is that gap intentional, or should the internal-queue path also
re-test at dequeue?

Relatedly, the second exit to the internal queue in fq_classify(), the
allocation failure path:

	f = kmem_cache_zalloc(fq_flow_cachep, GFP_ATOMIC | __GFP_NOWARN);
	if (unlikely(!f)) {
		q->stat_allocation_errors++;
		return &q->internal;
	}

does no clearing at all, so even an already-expired EDT survives to the
device there.  Should that path get the same treatment?

The predicate itself is conservative (nothing more than
fq_offload_slack_ns in the future is ever cleared), so this looks like a
missed optimization rather than a wrong transmit time, but the commit
message reads as though all packets whose txtime has passed get
skb->tstamp cleared.

> @@ -782,8 +790,8 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  
>  	skb = fq_peek(f);
>  	if (skb) {
> -		u64 time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
> -					     f->time_next_packet);
> +		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
> +					 f->time_next_packet);
>  
>  		if (now + offload_horizon < time_next_packet) {
>  			head->first = f->next;

[ ... ]

> @@ -862,6 +870,10 @@ static struct sk_buff *fq_dequeue(struct Qdisc *sch)
>  	}
>  
>  out:
> +	if (offload_horizon &&
> +	    time_next_packet && time_next_packet <= now + fq_offload_slack_ns)
> +		skb_set_delivery_time(skb, 0, SKB_CLOCK_REALTIME);
> +
>  	return skb;
>  }

[Severity: Medium]
Should this test the packet's own txtime rather than time_next_packet?

The fq_classify() site uses fq_skb_cb(skb)->time_to_send, while here
time_next_packet is:

		time_next_packet = max_t(u64, fq_skb_cb(skb)->time_to_send,
					 f->time_next_packet);

f->time_next_packet is FQ's own rate-pacing schedule.  Grepping
net/sched/sch_fq.c, skb->tstamp is only ever written by
fq_mono_to_skb_tstamp() on the fq_enqueue() horizon-cap path, so
f->time_next_packet is never propagated into skb->tstamp and the device
never sees it.

The effect shows up when FQ enforces its own rate, e.g.:

  tc qdisc replace dev X root fq maxrate 1gbit offload_horizon <= \
      dev->max_pacing_offload_horizon

For an EDT packet the branch that consults sk_pacing_rate is skipped:

	if (!skb->tstamp) {
		if (skb->sk)
			rate = min(READ_ONCE(skb->sk->sk_pacing_rate), rate);

so rate stays at q->flow_max_rate and the previous dequeue set
f->time_next_packet = now + len.  The flow is then throttled until
f->time_next_packet - offload_horizon, so on release:

	now + 400 < f->time_next_packet <= now + offload_horizon

and the predicate is false even though fq_skb_cb(skb)->time_to_send is
already well in the past.  In that configuration the clearing never
happens, while the fq_classify() peer site would have cleared the same
packet.  Note fq_fastpath_check() rejects the fastpath when
q->flow_max_rate != ~0UL, so maxrate flows always take this path.

Since time_next_packet is always >= time_to_send, nothing with a genuinely
future EDT gets cleared, so this looks like a silently ineffective
optimization rather than a correctness problem.  Was using
fq_skb_cb(skb)->time_to_send here considered, to keep the two sites
consistent?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260910171131.2532487-1-willemdebruijn.kernel%40gmail.com
