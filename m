Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793282952;
	b=Zf91+7YkQa1wA7ppVAzHmk9IjVBNtAwbPzGj4U4GvIPIJc6grsS9WKWz/mclIlNMWaJC
	 Tbt9iJcP+3qgwUTTLWA3vzy6Yn+AkhiCNm4vBju6+5IfoULa0U/zZyjsCqA9K+UXpXsGr
	 rH3eBX0Pp4jrSJRnq/9h3+0CcU+1wNEc1np61RhMVTdhxKpOFGnx1ZMSKM8G2dygYFn+i
	 KAo+XQCu+m0cZAzi5QDtn7yhqw+dVsHUD9duc92QFhjzHWbteYDLW8rn8hLNLnrXmVyDb
	 g20cZsr+r8vf2Kls+0H4u3ysifXeSTTi31E4Yj2wslKSPxr5HSlIlvp5dyIhzNPl3pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282952;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=glQgYs9RQWVkxE0C1hqBW6gO3DwVtg8MXWG3xBzwrVY=;
	b=jkrk/JH/xrKeRomZGCOIwxO+LptpaROOM8WMWdVGjFFTERQDaeP9lYU+vR1IVFJgV+bv
	 iAzmcNuQQxTFw9THofNIPsE07oFZyK8Mr1njVCS+1wUaNoYr7x4MQ8mvaqz3AKSO7ZRdz
	 83Lo5+MBNyaXvau422nwR7PghqO1sQiqDw4LyImdL7g9hvpr9LBOD87/y/8Z4iI5fkVgU
	 WHcgbh1IgRFMsbm1DV3eOkquvaAkMFOukqOS02BL2yxjoN7zcOL0FK1sQNv0S2S5Uusbl
	 z6V6PaosZly9M5ARc11GJfpBmBld+Wv7A3JbyQIFBRnYJJmaKIQqNtdmsczOPeiOugw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcOO8iXt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9B606A32A;
	Thu, 29 Oct 2026 14:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcOO8iXt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD051F01829;
	Thu, 29 Oct 2026 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793282951;
	bh=glQgYs9RQWVkxE0C1hqBW6gO3DwVtg8MXWG3xBzwrVY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dcOO8iXtUcbvcHG+m5oxgFlsU/HJQj7GLi3W9Zz4mAMQaTVNGIpudmixMhci/aqXW
	 jExSS76bAZwP4US9i5sH5hnAdIS+sSmgmRo1ixDdZ6w7GMb9+zNBf26wGenfjOnsz5
	 1YV0/hYCxnhH7+qt0uFa1EEXfKk2D4Y2/CgjzFoj5wJ+nhi4D7u5FC67whRWMTot1F
	 t/OrbRn7anlsdzOXmH5Fisy5YvczW9Xz+U9fRF7YfLjRjaN5aMuhtuJoaJ6Teo48ZN
	 dF9P2eB37wQzmtQUEhpTB5ruqPSdyzeQaE5zVHBtHz1P/nKVDOCs1NEnY0NUzGCEyd
	 wjrBXo3rfda1g==
Subject: Re: [PATCH net v7 3/3] xfrm: hold the tunnel device reference across
 the input path
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Thu, 29 Oct 2026 14:09:10 +0000
Message-ID: <179328295063.3134.16653525175454122290@kernel.org>
In-Reply-To: <20261027105031.19928-4-q.h.hack.winter@gmail.com>
References: <20261027105031.19928-4-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] IPTFS outer skbs parked in the reorder window can now pin the
  vti/vti6 net_device forever, so `ip link del` hangs and netns cleanup…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the vti netdev
  can still be used after free on the decap path.

--

xfrm: hold the tunnel device reference across the input path

This patch takes a reference on the vti/vti6 tunnel net_device when the
tunnel pointer is cached in the skb control buffer. xfrm_input() releases
that reference after delivery or drop. It also adds xfrm_input_drop() and
xfrm_input_consume() so the IPTFS outer-skb free paths release the
reference too.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index ab391258a5028..2797903d078dd 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c

[ ... ]

> @@ -746,8 +797,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  			sp->olen = 0;
>  		if (skb_valid_dst(skb))
>  			skb_dst_drop(skb);
> -		/* gro_cells_receive() reads skb->dev. */
> +		/* gro_cells_receive() may free the skb. */
> +		tdev = xfrm_input_take_tunnel_dev(skb, family);
>  		gro_cells_receive(&gro_cells, skb);
> +		if (tdev)
> +			dev_put(tdev);

[Severity: High]
This isn't a bug introduced by this patch, but can the vti net_device
still be used after it is freed on this decap path?

The commit message mentions this window ("That window is pre-existing and
is not changed here"). gro_cells_receive() usually just queues the skb on
the per-CPU napi_skbs list of the global xfrm gro_cells and calls
napi_schedule():

net/core/gro_cells.c:gro_cells_receive() {
    ...
	__skb_queue_tail(&cell->napi_skbs, skb);
	if (skb_queue_len(&cell->napi_skbs) == 1)
		napi_schedule(&cell->napi);
    ...
}

At this point skb->dev is the vti device, which vti_rcv_cb() set. Later,
gro_cell_poll()->napi_gro_receive() dereferences it without holding a
reference.

These gro_cells are attached to the dummy xfrm_napi_dev, which is never
unregistered, so deleting the vti device does not drain them.
flush_all_backlogs() only drains the softnet backlogs. synchronize_net()
does not wait for a NAPI poll that has been deferred to ksoftirqd.

One possible race:

CPU0                                   CPU1
gro_cells_receive()
  passes IFF_UP check, enqueues skb
                                       unregister vti0
                                       netdev_wait_allrefs_any()
dev_put(tdev)  <- last reference
                                       device and tstats freed
gro_cell_poll()
  reads freed skb->dev

xfrm_trans_queue_net() in the same file holds skb->dev for the whole
deferral:

	if (skb->dev)
		dev_hold(skb->dev);

Does the gro_cells handoff need something similar? The same window seems
to exist on the synchronous path and for xfrm interfaces.

>  		if (async)
>  			dev_put(dev);
>  		rcu_read_unlock();

[ ... ]

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 103cf7c5dbfb9..d8e7f2052dfb3 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -708,8 +708,9 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
>  
>  	/* We don't care if it works locking takes care of things */
>  	hrtimer_try_to_cancel(&xtfs->drop_timer);
> -	if (free)
> -		kfree_skb(xtfs->ra_newskb);
> +	if (free && xtfs->ra_newskb)
> +		xfrm_input_drop(xtfs->ra_newskb, xtfs->x->props.family,
> +				SKB_DROP_REASON_NOT_SPECIFIED);
>  	xtfs->ra_newskb = NULL;
>  }

[Severity: High]
Can an outer skb parked in the IPTFS reorder window now hold the vti
net_device forever?

With the new dev_hold() in vti_input() and vti6_input_proto(), the outer
skb holds a reference on the tunnel device until IPTFS frees it. The
reorder window (xtfs->w_saved) and reassembly (xtfs->ra_newskb) share a
single drop_timer. __iptfs_reassem_done() cancels that timer
unconditionally and never checks xtfs->w_savedlen.

With the default reorder window of 3, this sequence looks possible:

  seq S arrives in order
    __input_process_payload() starts reassembly, arms drop_timer

  seq S+3 arrives
    __reorder_future_fits() stores it in w_saved[1]
    iptfs_set_window_drop_times() sees the timer queued, does not re-arm

  seq S+1 arrives
    __reorder_this() delivers only S+1 (slot 0 for S+2 is empty)
    __vec_shift() moves S+3 into w_saved[0]
    iptfs_input_ordered(S+1) completes the reassembly
      iptfs_reassem_done()->__iptfs_reassem_done()
        hrtimer_try_to_cancel(&xtfs->drop_timer)

S+3 is now parked with no timer. Later in-window packets do not re-arm the
timer either. iptfs_set_window_drop_times() either returns early or stops
its walk at the filled slot 0:

	while (index-- > 0 && !s[index].skb)
		s[index].drop_time = drop_time;

	if (index == -1 && !hrtimer_is_queued(&xtfs->drop_timer))
		hrtimer_start(&xtfs->drop_timer, xtfs->drop_time_ns,
			      IPTFS_HRTIMER_MODE);

Only two things would release the skb: a window overflow through
__reorder_future_shifts(), or the missing sequence number arriving. Once
the vti device is being deleted, no more packets reach the SA, so neither
happens.

The parked skb also holds a sec_path reference on the xfrm_state.
iptfs_destroy_state() only runs from xfrm_state_gc_destroy() after the
state refcount reaches zero. That means the new xfrm_input_drop() call in
iptfs_destroy_state() never runs for this skb.

Before this patch, this case leaked the skb and the state. With the new
reference, would unregistering vti0 block forever in
netdev_wait_allrefs_any() ("waiting for vti0 to become free")? Would
netns teardown then stall the cleanup_net worker?

The commit message says:

  The device reference is therefore always dropped after the skb is gone.

In this case, though, the skb never seems to be freed.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027105031.19928-1-q.h.hack.winter%40gmail.com
