Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792640049;
	b=xfSRf7bkPjGJ6eywVaypyxqpzs1F6yNKCUYZpFZcnh9O7MbSJJqmoHuoOoqjTV0q57or
	 2A2CXZyu+82+vfRZj4kvKLaCNzwoOfUCNyRRyiOy6vVhF/gYnJX5ee+0/+Q2u7OzroatO
	 L0xR+LWQzoHTHgtPIULFv7cD2de0tjJnU9FTeYpUuoOk2whq5EBprnNWnRSkcimfGQ+YN
	 aeppx3qObXs6rPU2Q01gXHXewvseKHkZ/avWeUI5t863NAd6M2WpQ8HX1oNbSnExRG7u1
	 eF/FgOL35+JPxAvmu/JTiSEfCArSZ2gM4z8xJCbwe3TehcGaCpoNlw0yGc8bMX5bqlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792640049;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fy/DQiS97mhCTBdmkTL0xt86ohBYhwHUjIks+tRyFUA=;
	b=bOt4PC0K1hfc5bvIuR0IO+Oj63xiEprioNuZ2OGjKYsWjVpoUkT+M635NJuzfl8qok6v
	 UyyVcVHHJmslzywer5codESGMbqDWdGfI8Tr0QvluqZ3tnPA1BrDIsn+byJhsACSipxxZ
	 gU5GEsbCpnxTDe+CvZtrGp2CZP6wduzh5ua/b70dRrZ52oXFQWerUT5TVLkHhp5Us/xTO
	 vp59LVWAizG+KiHXyXmsgEzVWqxISPJjP9EgBsQNQkHSdzRxQDJJ6fJNQ8cmyU532dTZR
	 9tTWECX6g+mym6bFTCA04f6PZRiTJ7ov816VrnOEV67rPy2ZEeO8IsRGbN6BFjNy3VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3FS3lyW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52392606A323;
	Thu, 22 Oct 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3FS3lyW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3973C1F000C3;
	Thu, 22 Oct 2026 03:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792640048;
	bh=fy/DQiS97mhCTBdmkTL0xt86ohBYhwHUjIks+tRyFUA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=N3FS3lyW+qnC4JVfAyc2rTdHL7j8mld6LHZlxc+TLvPRRstXh0mCDdHEsGw4kfrhV
	 Mm/oP/Qakn69gLQ9nVVpMYXuJcXBZCkt/x9MUmIA4KaArWbzha+Q7wP8FBIjB0vtxA
	 Yt2dkxkp4TEKL/TgrYgZcq51k/6ii05gaHQl3O+0l7v5bfF5JXX4tugwS5BkFVwHAi
	 DT6miGOSXxX6J+ifFk2lyz5nGgrS76Mec64OnWcG/Wi9hHqUEL8wrKDu0SUwOoxmlF
	 Fl+t2zZ9oA3yQo+kcDqg0KSFQW8GhIlOZtE0TvVPVUHb22w9cfiXaIbMQlYqIhMiLW
	 t1n6XTVIV47eA==
Subject: Re: [PATCH net v5 3/3] xfrm: hold the tunnel device reference across
 the input path
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Thu, 22 Oct 2026 03:34:07 +0000
Message-ID: <179264004781.3135.12079608241468960595@kernel.org>
In-Reply-To: <20261019153247.89957-4-q.h.hack.winter@gmail.com>
References: <20261019153247.89957-4-q.h.hack.winter@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, every outer ESP skb received through
  vti/vti6 holds a reference on the tunnel net_device (dev_hold() in…
- [Low] The new loop at the end of __input_process_payload()
  (net/xfrm/xfrm_iptfs.c) does more than release the tunnel reference…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  leaves it in place and its message overstates its coverage.
- [High] This problem wasn't introduced by this patch, but IPTFS-parked
  skbs keep a skb->dev pointer with no reference on it.

--

xfrm: hold the tunnel device reference across the input path

This patch takes a reference on the vti/vti6 tunnel net_device when the
tunnel pointer is cached in the skb control buffer. xfrm_input() then
releases it after delivery or drop. New xfrm_input_drop() and
xfrm_input_consume() helpers are added, and the IPTFS outer skb free paths
are converted to use them so the reference is released there too.

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index 517369ba9efe..369817c870ce 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c

[ ... ]

> @@ -748,7 +799,11 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  			skb_dst_drop(skb);
>  		if (async)
>  			dev_put(dev);
> +		/* gro_cells_receive() may free the skb. */
> +		tdev = xfrm_input_take_tunnel_dev(skb, family);
>  		gro_cells_receive(&gro_cells, skb);
> +		if (tdev)
> +			dev_put(tdev);
>  		rcu_read_unlock();
>  		return 0;
>  	} else {
> @@ -756,6 +811,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  		if (xo)
>  			xfrm_gro = xo->flags & XFRM_GRO;
>  
> +		tdev = xfrm_input_take_tunnel_dev(skb, family);
>  		err = -EAFNOSUPPORT;
>  		afinfo = xfrm_state_afinfo_get_rcu(family);
>  		if (likely(afinfo))
> @@ -769,6 +825,8 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  			gro_cells_receive(&gro_cells, skb);
>  		}
>  
> +		if (tdev)
> +			dev_put(tdev);

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. In both
paths in xfrm_input(), the tunnel reference is dropped right after the skb
goes onto a deferred queue. At that point skb->dev still points at the vti
device, because vti_rcv_cb() and vti6_rcv_cb() set it:

    skb->dev = dev;

The gro_cells used here is the single static instance bound to
xfrm_napi_dev. Nothing drains it when a vti device is unregistered.
flush_all_backlogs() only covers the softnet_data backlogs, and the
gro_cells_destroy() call in ip_tunnel only covers the tunnel's own
gro_cells.

The transport path has the same shape:

  transport_finish()->NF_HOOK()->xfrm4_rcv_encap_finish()
    ->xfrm_trans_queue()

net/ipv4/xfrm4_input.c:xfrm4_rcv_encap_finish() {
    ...
	if (xfrm_trans_queue(skb, xfrm4_rcv_encap_finish2))
		goto drop;
    ...
}

That defers the skb to the per-CPU xfrm_trans tasklet, and dev_put(tdev)
follows straight away.

Suppose the softirq or tasklet holding the skb is delayed, for example to
ksoftirqd or under PREEMPT_RT. Could synchronize_net() and the
rcu_barrier() in netdev_run_todo() then complete? If so,
netdev_wait_allrefs_any() would see no extra reference and the vti
net_device could be freed. gro_cell_poll()->napi_gro_receive(), or the
tasklet's ip_route_input()/dst_input(), would then use the freed
skb->dev.

The commit message says:

  "The device reference is therefore always dropped after the skb is
  gone."

For these queued paths the skb has been queued, not freed. The message
mentions the gro_cells window but not the xfrm_trans_queue() one. Could
it be updated to say so?

>  		if (async)
>  			dev_put(dev);
>  		rcu_read_unlock();

[ ... ]

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 6920940a35b4..2b202c7570f1 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -709,8 +709,9 @@ static void __iptfs_reassem_done(struct xfrm_iptfs_data *xtfs, bool free)
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

[Severity: Medium]
With this patch, the dev_hold() in vti_input(), vti6_input_proto() and
xfrm6_rcv_spi() means every outer ESP skb received through vti/vti6 pins
the tunnel net_device. The pin lasts until the skb is freed through
xfrm_input_drop() or xfrm_input_consume().

IPTFS can keep outer skbs for a long time:

  - in xtfs->ra_newskb, when the reused first_skb is a partial datagram
  - in the reorder window xtfs->w_saved[] (reorder_win_size defaults
    to 3)

While they are parked, unregister_netdevice() of the vti device waits in
netdev_wait_allrefs_any(). The wait is at least drop_time_ns: 1s by
default, and up to about 4295s through XFRMA_IPTFS_DROP_TIME.

Can that wait become unbounded? ra_newskb and w_saved share drop_timer,
and __iptfs_reassem_done() cancels it unconditionally, as shown above.
Consider this sequence:

  seq N starts reassembly, drop_timer is armed
  seq N+3 is saved in w_saved[1]; iptfs_set_window_drop_times() does
    not re-arm because the timer is already queued
  seq N+1 arrives in order; __reorder_this() shifts N+3 into
    w_saved[0] with __vec_shift(), and N+1 completes the reassembly
  __iptfs_reassem_done() cancels drop_timer

N+3 now sits in w_saved[0] with no timer. It is only released when more
traffic arrives on that SA.

Its sec_path holds a reference on the xfrm_state, so
xfrm_state_gc_destroy()->iptfs_destroy_state() never runs. The new
xfrm_input_drop() calls in iptfs_destroy_state() therefore can't release
it either.

If the vti device and its SAs are removed, or the netns is torn down,
would unregistration then hang waiting for the vti device to become
free?

The timer cancel behaviour predates this patch. Pinning the tunnel device
from these parked skbs is new, and the commit message doesn't mention it.

[ ... ]

> @@ -1204,15 +1205,23 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  	skb_abort_seq_read(skbseq);
>  
>  	if (defer) {
> -		consume_skb(defer);
> +		xfrm_input_consume(defer, x->props.family);
>  	} else if (!first_skb) {
> -		/* skb is the original passed in skb, but we didn't get far
> -		 * enough to process it as the first_skb, if we had it would
> -		 * either be save in ra_newskb, trimmed and sent on as an skb or
> -		 * placed in defer to be freed.
> -		 */
> -		kfree_skb(skb);
> +		/* The original skb was not consumed as the first inner packet. */
> +		xfrm_input_drop(skb, x->props.family,
> +				SKB_DROP_REASON_NOT_SPECIFIED);
> +	}
> +
> +	/*
> +	 * A validation failure can bypass delivery of @sublist.  Drop the
> +	 * queued skbs so the outer skb's tunnel reference is released.
> +	 */
> +	list_for_each_entry_safe(skb, next, sublist, list) {
> +		skb_list_del_init(skb);
> +		xfrm_input_drop(skb, x->props.family,
> +				SKB_DROP_REASON_NOT_SPECIFIED);
>  	}
> +
>  	return true;
>  }

[Severity: Low]
The commit message describes this loop only as "drop those as well so
the outer skb's reference is not leaked". Doesn't it also fix an older
skb leak in __input_process_payload()?

Before this patch, several validation failures jump to the done label
and skip the "Send the packets!" loop:

  - skb_copy_seq_read() failures
  - an IPv4 header with a bad ihl/tot_len
  - a version nibble that is not 0, 4 or 6

Anything already queued on @sublist was never freed. That could be
earlier inner skbs, the reused first_skb, or a datagram that
iptfs_reassem_cont() had just completed. The done label only freed the
root skb when !first_skb, and iptfs_input_ordered() never looks at
@sublist again.

Each leaked skb also kept its sec_path, which holds a reference on the
xfrm_state through sp->xvec.

That leak dates back to 6c82d24336718 ("xfrm: iptfs: add basic receive
packet (tunnel egress) handling"). Should the commit message mention
it, and should a Fixes: tag for that commit be added? The current Fixes:
tags only point at the vti commits.

[ ... ]

> @@ -1700,7 +1710,8 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
>  	spin_unlock(&xtfs->drop_lock);
>  
>  	if (skb)
> -		kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
> +		xfrm_input_drop(skb, x->props.family,
> +				SKB_DROP_REASON_FRAG_REASM_TIMEOUT);
>  
>  	if (count) {
>  		list_for_each_entry_safe(skb, next, &list, list) {

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. The
skbs IPTFS parks keep a skb->dev pointer with no reference held on it.

The device here is the physical ingress device, not the vti device.
IPTFS is ESP-only, and vti_rcv_proto() calls vti_input() with
update_skb_dev=false. The tunnel reference added in this patch therefore
doesn't cover it.

xfrm_input() only holds the ingress device across x->type->input. When
xfrm_inner_mode_input() returns -EINPROGRESS for IPTFS, it does:

	err = xfrm_inner_mode_input(x, skb);
	if (err == -EINPROGRESS) {
		if (async)
			dev_put(dev);
		return 0;

After that, two kinds of parked skb carry an unreferenced skb->dev:

  - xtfs->ra_newskb, which is either the reused outer skb or a fresh skb
    from iptfs_alloc_skb()
  - the outer skbs in xtfs->w_saved[]

iptfs_alloc_skb() copies the device without a hold:

net/xfrm/xfrm_iptfs.c:iptfs_alloc_skb() {
    ...
		/* xfrm_input resume needs dev and xfrm ext from tunnel pkt */
		skb->dev = tpl->dev;
		__skb_ext_copy(skb, tpl);
    ...
}

Suppose the ingress device is unregistered within drop_time, for example
a veth during container netns teardown, or a removed NIC. Two paths can
still deliver a parked skb afterwards. One is a completion arriving on
another interface through iptfs_reassem_cont(). The other is this timer
replay:

  iptfs_drop_timer()->__reorder_drop()->iptfs_input_ordered()
    ->__input_process_payload()->xfrm_input(skb, 0, 0, -2)

Both reach xfrm_input(), which starts with:

	struct net *net = dev_net(skb->dev);

gro_cells_receive() later reads dev->flags. Can either of these
dereference the freed net_device?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261019153247.89957-1-q.h.hack.winter%40gmail.com
