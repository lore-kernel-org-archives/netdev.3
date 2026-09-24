Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE698407CF6
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239706; cv=none; b=U3k1S9EeBgT77ObbJuQUNd++IMyoPNDZATnHydFoyv6cs4awPgIavzfSKcePMHEPFJFCWQc4DXAr9n2WLefddDuhhtwhlKVOhBzFDUlSIulqv8oyxwRMdXR3nrH9qoW5JAz3jY28GWVCzeb1HPzhinjnAKCqm39qDwxYcDOEj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239706; c=relaxed/simple;
	bh=IEM1eC0AvPaafYVyQCuoJI7R3KL9OuQGkNLrtjie44M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WGRMmsbMPJAERy7dhY19gu5ggkiL9VQKvijTrLNQz4Ol6NlBHmXfkaYzc2qpP37d6+CBh/xgs95rXdrgps99Rc1lEYtYFXZnIDJI0EhjaB03mLcTIL5XB1Gec1EySRj3LUcEaCrRsigmvWXju9WeoPn1yOAzzAT6rL2yLism1UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LABg01X5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LABg01X5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74951F000FF;
	Thu, 24 Sep 2026 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790239704;
	bh=1Vu+ynpNwnItOmcSGCl3hAv3qgBTXTUtPEBc4DxAefQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LABg01X5BprIWwyzKgkT5AvRZxrCa2+4dgmvdonWjaXbE1horVOv24Vi59nl35M6V
	 kXlLTr4bAIM/GFIGOZnziR3RpOaV3s8hNqU+wnUo3z1rhtD4f8Mjvb+men5TuF6Tz4
	 9InNQQbDHcWjXPSwzeRdVkN/VT26bx8dxKMdB/xoI0Ixg2+7v8sbLrdT8PrXN7Zjcs
	 AmyMmBvQQU6khuX+4NfVIePyXH9MG9zGAOXTbQIPuSJkcxAVX0h4M9UMcbxiLlCHla
	 B2YlqGglcIXwfgan1bH632bNJI/Pd810CuX0w6ZODto7qXfplbTnxVoSLt3F27qCTa
	 Rh5uiiyY9CtdA==
Subject:
 Re: [PATCH v2] xfrm: iptfs: hold a device reference while packets are queued
From: netdev-bot+sashiko@kernel.org
To: roshaen09@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, chopps@labn.net,
 shubham@octane.security, robert@octane.security, gio@octane.security,
 kuba@kernel.org
Date: Thu, 24 Sep 2026 08:48:23 +0000
Message-ID: <179023970333.2160803.2776986020964028023@kernel.org>
In-Reply-To: <20260921084743.817859-1-roshaen09@gmail.com>
References: <20260921084743.817859-1-roshaen09@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Unbounded net_device reference retention: the patch pins the
  ingress net_device for every skb parked in the reorder window…
- [High] Refcount/UAF race: the newly added device reference for the in-
  progress reassembly skb is released before the skb's last use.
- [Medium] The KASAN backtrace pasted in the commit message cannot have
  been produced by this code.
- [Low] Undisclosed behavioural/hot-path change and split ownership
  convention.
- [Low] Coding style (checkpatch error) in the modified hunk:
  iptfs_input_reorder() now braces the first arm of the if/else-if chain…

--

xfrm: iptfs: hold a device reference while packets are queued

This takes a net_device reference on skb->dev when an outer packet is
parked in the IPTFS reorder window (w_saved) or kept as the in-progress
reassembly skb (ra_newskb), and drops it when the retained skb is
delivered or freed.  Release sites are added in iptfs_drop_timer(),
iptfs_input(), __iptfs_reassem_done() and iptfs_destroy_state().

A few questions about the commit message and the reference accounting
below.

>   BUG: KASAN: use-after-free in xfrm_input+0x45d6/0x59c0
>    iptfs_complete_inner_skb
>    __input_process_payload
>    iptfs_input_ordered
>    iptfs_drop_timer

[Severity: Medium]
Can this backtrace be produced by the current code?  The frame order
presents iptfs_complete_inner_skb() as the caller of xfrm_input(), but
iptfs_complete_inner_skb() in net/xfrm/xfrm_iptfs.c only resets the
network and transport headers, sets ip_summed and fixes up DSCP/ECN and
skb->protocol:

net/xfrm/xfrm_iptfs.c:iptfs_complete_inner_skb() {
	skb_reset_network_header(skb);
	skb_reset_transport_header(skb);
	skb->ip_summed = CHECKSUM_NONE;
	...
		skb->protocol = htons(ETH_P_IPV6);
	}
}

The only xfrm_input() call on that path is in the delivery loop of
__input_process_payload():

		if (xfrm_input(skb, 0, 0, -2))
			kfree_skb(skb);

Both Reported-by: tags also name the patch author and there is no
Closes: tag or reproducer reference.  Could the trace be replaced with
one that matches the code, or with a reproducer?

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..ce5c6170d249d 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -709,6 +709,8 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
>  
>  	/* We don't care if it works locking takes care of things */
>  	hrtimer_try_to_cancel(&xtfs->drop_timer);
> +	if (xtfs->ra_newskb)
> +		dev_put(xtfs->ra_newskb->dev);
>  	if (free)
>  		kfree_skb(xtfs->ra_newskb);
>  	xtfs->ra_newskb = NULL;

[Severity: High]
The dev_put() here runs for both values of free, but in the free ==
false case the skb is not freed, it is handed on for delivery:

net/xfrm/xfrm_iptfs.c:iptfs_reassem_cont() {
	...
	} else {
		/* We are done with packet reassembly! */
		iptfs_reassem_done(xtfs);	/* __iptfs_reassem_done(xtfs, false) */
		iptfs_complete_inner_skb(xtfs->x, newskb);
		list_add_tail(&newskb->list, list);
	}
	...
}

and the list is then delivered in __input_process_payload():

		if (xfrm_input(skb, 0, 0, -2))
			kfree_skb(skb);

xfrm_input() dereferences the device immediately:

net/xfrm/xfrm_input.c:xfrm_input() {
	struct net *net = dev_net(skb->dev);
	struct net_device *dev = skb->dev;
	...
}

ra_newskb->dev was copied from an older outer packet in
iptfs_alloc_skb() ("xfrm_input resume needs dev and xfrm ext from tunnel
pkt"), so it need not be the device of the packet currently being
processed, and in the reorder_win_size == 0 fast path no reference is
held on the current outer skb either.

Can the dev_put() here therefore drop the last reference, so that
dev_net(skb->dev) in xfrm_input() reads a freed net_device?  Would
moving it under the free branch, matching the ordering used in the new
iptfs_input() loop, keep the reference alive until after delivery?

		struct net_device *dev = skb->dev;

		skb_list_del_init(skb);
		iptfs_input_ordered(x, skb);
		dev_put(dev);

> @@ -845,6 +847,7 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
>  			goto abandon;
>  		}
>  		xtfs->ra_newskb = newskb;
> +		dev_hold(newskb->dev);
>  
>  		/* Copy the runt data into the buffer, but leave data
>  		 * pointers the same as normal non-runt case. The extra `rrem`
> @@ -1161,6 +1164,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  			spin_lock(&xtfs->drop_lock);
>  
>  			xtfs->ra_newskb = skb;
> +			dev_hold(skb->dev);
>  			xtfs->ra_wantseq = seq + 1;
>  			if (!hrtimer_is_queued(&xtfs->drop_timer)) {
>  				/* softirq blocked lest the timer fire and interrupt us */
> @@ -1475,6 +1479,7 @@ static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
>  	}
>  
>  	xtfs->w_saved[index].skb = inskb;
> +	dev_hold(inskb->dev);
>  	xtfs->w_savedlen = max(savedlen, index + 1);
>  	iptfs_set_window_drop_times(xtfs, index);
>  }

[Severity: High]
The commit message says:

  "The drop timer and the reassembly queues are bounded by the
  configured drop time, so the extra reference delays device
  unregistration by at most that amount."

Does that bound hold for the window slots?  __iptfs_reassem_done()
cancels the drop timer unconditionally, and that single hrtimer is
shared between reassembly and the reorder window:

	hrtimer_try_to_cancel(&xtfs->drop_timer);

Once cancelled, iptfs_set_window_drop_times() only re-arms it when the
walk back reaches an empty slot 0:

	if (savedlen > index + 1) {
		/* we are below another, our drop time and the timer are already set */
		return;
	}
	...
	if (index == -1 && !hrtimer_is_queued(&xtfs->drop_timer))
		hrtimer_start(&xtfs->drop_timer, xtfs->drop_time_ns,
			      IPTFS_HRTIMER_MODE);

So with an occupied lower slot, is the timer ever re-armed?

For example, with wantseq == N: packet N starts a fragmented inner
packet (ra_newskb set, timer armed), N+2 and N+4 arrive out of order and
are saved with dev_hold(), then N+1 arrives in order and __reorder_this()
flushes N+1 and N+2 and shifts, leaving N+4 in slot 0.  If the
reassembly completes while processing N+1, iptfs_reassem_done() cancels
the timer while N+4 and its device reference are still parked.  If the
peer stops sending, does unregister_netdevice() for that ingress device
then spin forever in netdev_wait_allrefs_any(), which also blocks the
global cleanup_net worker?

The runt path above looks similar: iptfs_reassem_cont() takes
dev_hold(newskb->dev) on the path entered from iptfs_input_save_runt(),
which only sets ra_runtlen and ra_wantseq and does not start the drop
timer, unlike the __input_process_payload() site which does. Is anything
other than iptfs_destroy_state() guaranteed to release that reference?

On the bound itself, drop_time_ns comes from XFRMA_IPTFS_DROP_TIME as
u32 microseconds without a clamp, so even in the well behaved case the
delay can be around 71 minutes.  Is that worth mentioning in the
changelog?

> @@ -1610,6 +1615,7 @@ static void __reorder_future_shifts(struct xfrm_iptfs_data *xtfs,
>  	/* We've shifted. plug the packet in at the end. */
>  	xtfs->w_savedlen = nslots - 1;
>  	xtfs->w_saved[xtfs->w_savedlen - 1].skb = inskb;
> +	dev_hold(inskb->dev);
>  	iptfs_set_window_drop_times(xtfs, xtfs->w_savedlen - 1);
>  
>  	/* if we don't have a slot0 then we must wait for it */
> @@ -1641,8 +1647,10 @@ static void iptfs_input_reorder(struct xfrm_iptfs_data *xtfs,
>  	}
>  	wantseq = xtfs->w_wantseq;
>  
> -	if (likely(inseq == wantseq))
> +	if (likely(inseq == wantseq)) {
> +		dev_hold(inskb->dev);
>  		__reorder_this(xtfs, inskb, list);
> +	}

[Severity: Low]
This isn't a bug, but the changelog only mentions taking a reference
"when a packet is placed in the reorder window or kept as the in-progress
reassembly skb".  This hold is on the in-order packet, which is never
retained past iptfs_input(): it is released a few lines later in the
delivery loop of iptfs_input().  Could the changelog mention that every
in-order received packet now does a dev_hold()/dev_put() pair when
reorder_win_size is non-zero, while the reorder_win_size == 0 fast path
takes none?

The ownership convention also differs between neighbouring helpers:
iptfs_input_reorder() takes the hold for __reorder_this(), the callees
take it in __reorder_future_fits() and __reorder_future_shifts(), and
__reorder_past() plus the duplicate-future case take none, with freelist
entries freed without dev_put().  Releases are spread over both delivery
loops, __iptfs_reassem_done() and iptfs_destroy_state().  Would a short
comment stating who owns the reference help, given the v2 note already
records one near-miss leak from this ambiguity?

>  	else if (inseq < wantseq)
    ^^^^

[Severity: Low]
checkpatch reports an error for this: "else should follow close brace
'}'".  CodingStyle also asks that all arms of the chain use braces once
one arm does.

>  		__reorder_past(xtfs, inskb, freelist);
>  	else if ((inseq - wantseq) < nslots)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921084743.817859-1-roshaen09%40gmail.com
