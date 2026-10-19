Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929334AB1A8;
	Mon, 19 Oct 2026 09:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402858; cv=none; b=izoC7589zvKaZq+jnrNyMfTWX21n9vf0/PYpGEmeOun3xpCbTFgq1tyUdej787WmHi/bNqTHi6HYHfsyYdRtnNeOcr2LYChhnb4aKcs9Jdf6n1+HzIVafv+s8R/clF8L4XNKVg67x5ohIS7WIjK1KaVljADnP1DiZQL+36MkhH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402858; c=relaxed/simple;
	bh=YziZsDyXK5mNIHcWK20KsRPVLhaQudIhCQk9CzrI8L8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iTSpaIBQlhetgHvIEkyM11g944yI9T7vHn1J2J4ma7yKUfuLZ5qeeDUAb0b/bceZBgOf2sE/OBa5ySKoxPceq9Tunvj1wNUTZjIvbxhDS5QPQ64UIQ/eKlvNHOw3gBmRb8T49vSTsD2cHL70H4CaqUO+xbkSaW3HkuneTq+DyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkMOxs7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkMOxs7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9149E1F000C4;
	Mon, 19 Oct 2026 09:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792402857;
	bh=UDlWj922GxgoJ7a/6wkOtw2BnublV6F9zSWHJrJQv8Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SkMOxs7Jve9R33So/jOY5zSUL3Slaqod3q84j7oUjykAuyfUSCQv0tVhqSA+m9/Ir
	 8x3EeKuC4SegDaoKmTdmlUnyep3oGpL/6Uik761jbsRZAoJ3bBWA2CkHSdpp5ITw43
	 2zEocCyEI4+HVSNtbuUqYL18Tj9iN/KNiBsTp5u6euezgR+bSJ+DRRZ4iS9sq7yOhZ
	 KNvfz3u83I31xRjvAYzjoiOgNmkPUkXX+5YgnardsaZxbMVlQBsuk3/sXh8kfmHeYh
	 /bLC04yNllfzkQlWr57AE0abMypeGzO3Rbms5yItzKfnFzplNW8E/v3D/SCqlXgxUK
	 qMCyC/OlKUVVw==
Subject: Re: [PATCH net v4 3/3] xfrm: hold the tunnel device reference across
 the input path
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 09:40:56 +0000
Message-ID: <179240285617.3135.8327548143410753967@kernel.org>
In-Reply-To: <20261018090638.55686-4-q.h.hack.winter@gmail.com>
References: <20261018090638.55686-4-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch puts a dev_hold() on the vti/vti6 net_device into
  every outer skb (vti_input(), vti6_input_proto()).
- [High] __input_process_payload() can leak the outer skb and, after this
  patch, the vti/vti6 device reference it carries, so the reference is…
- [Low] The new comments describing the tunnel-device reference do not
  match the code.

--

xfrm: hold the tunnel device reference across the input path

vti_input() and vti6_input_proto() now take a reference on the tunnel
net_device when they cache the tunnel pointer in the skb control buffer.
xfrm_input() drops that reference on its delivery and drop paths. IPTFS
drops it through the new xfrm_input_drop() and xfrm_input_consume()
helpers when it frees an outer skb.

> diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> index 3b80929994a00..cbe7906a4a1ba 100644
> --- a/net/ipv4/ip_vti.c
> +++ b/net/ipv4/ip_vti.c
> @@ -63,6 +63,9 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
>  
>  		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
>  
> +		/* Kept until xfrm_input() is done with the skb. */
> +		dev_hold(tunnel->dev);
> +

[Severity: High]
Can IPTFS keep the vti device pinned for a very long time, or with no
time limit, now that every outer skb holds this reference?

IPTFS can keep the outer skb after xfrm_input() has returned. It keeps it
as xtfs->ra_newskb when __input_process_payload() reuses the outer skb as
first_skb and that skb is partial. It also keeps it in the reorder window
through __reorder_future_fits():

	xtfs->w_saved[index].skb = inskb;

Only iptfs_drop_timer(), later traffic or iptfs_destroy_state() release
these skbs. The drop time comes from XFRMA_IPTFS_DROP_TIME, which has no
upper bound (u32 microseconds, about 71 minutes).

The drop timer can also be lost. __iptfs_reassem_done() calls
hrtimer_try_to_cancel(&xtfs->drop_timer), but the reorder window uses the
same timer. iptfs_set_window_drop_times() only re-arms it here:

	if (index == -1 && !hrtimer_is_queued(&xtfs->drop_timer))
		hrtimer_start(&xtfs->drop_timer, xtfs->drop_time_ns,
			      IPTFS_HRTIMER_MODE);

With the default window of 3, this sequence seems to leave an outer skb
parked with no timer:

  wantseq = N
  N arrives, starts a reassembly, drop_timer is armed
  N+3 arrives, goes into w_saved[1]; the timer is already queued, so it
    is not re-armed
  N+1 arrives, __reorder_this() shifts N+3 into w_saved[0]
  iptfs_input_ordered(N+1) completes the reassembly
    iptfs_reassem_cont()->__iptfs_reassem_done()
      hrtimer_try_to_cancel(&xtfs->drop_timer)

N+3, and its vti device reference, then waits for more traffic or for the
SA to be destroyed.

Nothing in xfrm or IPTFS handles NETDEV_UNREGISTER for the vti device.
Would "ip link del vti0" then block in netdev_wait_allrefs_any()?

Netns teardown looks worse. vti_net_ops and vti6_net_ops are pernet device
ops, so their exit runs before the xfrm_net_ops subsys exit.
xfrm_net_pre_exit() only flushes policies. States are only flushed in
xfrm_net_exit()->xfrm_state_fini()->xfrm_state_flush().

So iptfs_destroy_state() cannot run until the device unregister finishes.
The unregister is waiting for a reference that only iptfs_destroy_state()
would drop. Could this stall cleanup_net with no end?

Before this patch the parked skbs held no device reference. The dev_hold()
added in vti6_input_proto() has the same issue.

[ ... ]

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 517369ba9efea..209fd7ffb5c82 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -120,6 +120,60 @@ static int xfrm_rcv_cb(struct sk_buff *skb, unsigned int family, u8 protocol,
>  	return ret;
>  }
>  
> +/*
> + * vti/vti6 cache the tunnel in the skb control buffer and keep a
> + * reference on its net_device.  The tunnel is the device's private
> + * area, so the reference keeps both alive.  xfrm_input() releases it
> + * once the packet has been delivered; the drop paths release it when
> + * no receive callback ran.  The caller passes the address family of the
> + * cached tunnel.
> + */

[Severity: Low]
This isn't a bug, but this comment doesn't seem to match the code.

The comment says "xfrm_input() releases it once the packet has been
delivered". In the decaps branch the reference is dropped right after
gro_cells_receive(), and gro_cells_receive() only queues the skb for the
gro_cells NAPI:

		tdev = xfrm_input_take_tunnel_dev(skb, family);
		gro_cells_receive(&gro_cells, skb);
		if (tdev)
			dev_put(tdev);

It also says "the drop paths release it when no receive callback ran".
The drop: label calls the receive callback first, and vti_rcv_cb() reads
tunnel->dev there:

	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
	tdev = xfrm_input_take_tunnel_dev(skb, family);

The comments in vti_input() ("Kept until xfrm_input() is done with the
skb.") and vti6_input_proto() have a similar problem with IPTFS.
xfrm_input() returns on -EINPROGRESS while the outer skb and its reference
are still in xtfs->w_saved[] or xtfs->ra_newskb.

Could these comments describe when the reference is actually released?

[ ... ]

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b49..657dce0c9fdf8 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c

[ ... ]

> @@ -1204,14 +1205,15 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  	skb_abort_seq_read(skbseq);
>  
>  	if (defer) {
> -		consume_skb(defer);
> +		xfrm_input_consume(defer, x->props.family);
>  	} else if (!first_skb) {
>  		/* skb is the original passed in skb, but we didn't get far
>  		 * enough to process it as the first_skb, if we had it would
>  		 * either be save in ra_newskb, trimmed and sent on as an skb or
>  		 * placed in defer to be freed.
>  		 */
> -		kfree_skb(skb);
> +		xfrm_input_drop(skb, x->props.family,
> +				SKB_DROP_REASON_NOT_SPECIFIED);
>  	}
>  	return true;
>  }

[Severity: High]
Does this path leak the outer skb, and with it the vti device reference?

On the first loop iteration, __input_process_payload() can reuse the
outer skb as first_skb while XFRM_TUNNEL_SKB_CB(skb)->tunnel is still
set. If the first inner packet is complete, the skb is queued:

		iptfs_complete_inner_skb(x, skb);
		list_add_tail(&skb->list, sublist);

If a later inner block in the same payload is malformed, the loop jumps
to done. For example:

		} else {
			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
			goto done;
		}

The IPv4 iplen < iphlen check and a skb_copy_seq_read() failure take the
same jump.

The done: label comes after the "Send the packets!" loop, so first_skb
never reaches xfrm_input(skb, 0, 0, -2). At done: defer is NULL and
first_skb is non-NULL, so neither xfrm_input_consume() nor
xfrm_input_drop() runs, and the function returns true.
iptfs_input_ordered() then sees consumed == true, and its on-stack
sublist goes out of scope.

The skb leak was already there. With this patch, each such packet also
leaks a reference on the vti/vti6 net_device, so a later unregister of
the tunnel would wait forever.

A completed reassembly skb that iptfs_reassem_cont() put on the same
sublist seems to leak the same way when it is an earlier reused outer
skb.

The commit message says the outer-skb free paths in
__input_process_payload() are covered. Should the goto done path also
free the skbs on sublist, through xfrm_input_drop()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018090638.55686-1-q.h.hack.winter%40gmail.com
