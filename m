Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803FB420889
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108509; cv=none; b=lg957rC1m3A63b88QrOpI5CZd/bpT+pSHi/uDLxHtNzMxpURNhbRzuZqCPZYvnordZNHjDeqJb3J8oWRE8uTkIURYBz/Ev28T1O30ZsU/5lKnuS5L8m2KN4R094F24/NZLTH6nmw03/u/XXtQPrFavrkZr2djhSAPXSlWZSFDwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108509; c=relaxed/simple;
	bh=q7zMw39eX7VwWYPtl3F8V009Diybh6stzXg9hcDrQYg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIODBxJ2ooa221BS7xmWhQiwXpEXft3BPdAx8TVDq1Tf4uQBKpvD8DLpQNgKL7yfsyD3NTscG5mZXLInpozf6YORIs2amokrWxB492iMmX28snkNFscXwXP381aXNcOsSVHa80jb1FFZeJvb/Ah7RT81K6Pf2bj2OahP2kJZ9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOW/vBM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOW/vBM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3C71F000FF;
	Sun,  4 Oct 2026 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791108507;
	bh=rDSavNkTrMp/lP4PpVt9NeUHEf9vsBtk2+B+HnZLens=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HOW/vBM8JIN8Iol1dpTd7RDvgqMU/aGpfJlrCXzU+4h7QzxByZmwU37KT6OXffvyD
	 Fntuydf1qOVt+8rBgYtqgsvm/qnAgmlNdhaaTAE/9mnvRWepijKbOZgP886Vk9MxIy
	 Tzbn78E5hP1UiCKWbEABDC7B1LHauPWUvP8NorkJ4VpkUTc8ATSoIzFZwDaZjHqeny
	 SXzNQIZDMUYYIItklJPta3Pzk6e4wgVjbnCAnVw1yH4V1WFJPj5BPGNrbmDAom5VCd
	 53VM1IJetdSpc/96x7Dn0AfUeQxvGr94aOd6CvThqoDVKwOa6GxPAjOKJOZVEUgGHb
	 R8rZcR/M2t+tg==
Subject: Re: [PATCH net 1/2] vti: fix tunnel device use-after-free across
 async crypto resumption
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, kuba@kernel.org
Date: Sun, 04 Oct 2026 10:08:26 +0000
Message-ID: <179110850671.434549.2584497019282941556@kernel.org>
In-Reply-To: <20260930090813.73901-2-q.h.hack.winter@gmail.com>
References: <20260930090813.73901-2-q.h.hack.winter@gmail.com>
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

Critical: 0 · High: 3 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Leaked net_device reference when a VTI tunnel uses an IPTFS SA.
- [High] vti_rcv_cb() drops the only reference that keeps the VTI device
  alive before its caller has finished using it.
- [High] The dev_hold() added in vti_input() (net/ipv4/ip_vti.c:66) leaks
  when xfrm_input() drops the skb through the early invalid-state check.

Pre-existing issues:
- [Low] Concern: the IPv6 VTI driver has the same unreferenced cached-
  tunnel pattern and this patch does not fix it.

--

vti: fix tunnel device use-after-free across async crypto resumption

This patch takes a reference on the VTI tunnel device in vti_input() when
the tunnel pointer is cached in the skb control buffer. It drops that
reference in vti_rcv_cb() on both the error and success paths, so the
device stays alive across async crypto completion.

> diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> index 3b80929994a00..9f44666139f8c 100644
> --- a/net/ipv4/ip_vti.c
> +++ b/net/ipv4/ip_vti.c
> @@ -63,6 +63,8 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
>  
>  		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
>  
> +		dev_hold(tunnel->dev);
> +

[Severity: High]
Can this reference leak when the matching SA uses IPTFS mode?

The only matching dev_put() calls are in vti_rcv_cb(). That means this
relies on xfrm_input() calling the callback exactly once per skb.

For an IPTFS SA, xfrm_input() dispatches to iptfs_input(), which always
returns -EINPROGRESS:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
		err = xfrm_inner_mode_input(x, skb);
		if (err == -EINPROGRESS) {
			if (async)
				dev_put(dev);
			return 0;
		}
    ...
}

That return skips xfrm_rcv_cb(). Only the outer skb has tunnel.ip4 in its
cb. It comes back into vti_rcv_cb() through xfrm_input(skb, 0, 0, -2) only
when __input_process_payload() reuses it as a complete first inner packet.

In these other cases the outer skb is freed without any callback:

  - consume_skb(defer) in __input_process_payload(), when the skb has a
    frag_list, is head_frag, or cannot be reused
  - kfree_skb(skb) in __input_process_payload() when there is no
    first_skb (padding-only or continuation-only outer packets)
  - kfree_skb(skb) in iptfs_input_ordered() when IPTFS header validation
    fails
  - the reorder window freelist in iptfs_input()
  - the reassembly drop timer and state teardown that free ra_newskb

iptfs_alloc_skb() builds inner skbs with alloc_skb(), so their cb is zeroed
and tunnel.ip4 is NULL. For those skbs vti_rcv_cb() returns 1, so they
can't make up the missing dev_put().

IPTFS is a tunnel mode, so it passes xfrm_tunnel_check() on a VTI device.
Once such an SA is configured, would normal traffic from the peer leak one
VTI device reference per packet? If so, ip link del or netns teardown would
block forever in netdev_wait_allrefs_any() with "waiting for vtiX to
become free". This path did not leak before this patch.

The follow-up commit "vti6: fix tunnel device use-after-free across async
crypto resumption" takes the same unconditional hold in
vti6_input_proto(), so ip6_vti looks like it has the same leak.

[Severity: Low]
This is a pre-existing issue, not one introduced by this patch.
vti6_input_proto() in net/ipv6/ip6_vti.c also caches t in
XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 without taking a device reference.
vti6_rcv_cb() may later dereference t->dev, t->parms.i_key and t->net from
an async crypto completion.

The next patch in the series, "vti6: fix tunnel device use-after-free
across async crypto resumption", adds dev_hold(t->dev) in
vti6_input_proto() and matching dev_put() calls in vti6_rcv_cb(). That
fixes the IPv6 side. It also inherits the leak and early-release
questions raised here for IPv4.

Is the IPv6 side meant to be handled only by that follow-up?

>  		if (update_skb_dev)
>  			skb->dev = tunnel->dev;
>  

[ ... ]

> @@ -109,10 +111,14 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
>  
>  	dev = tunnel->dev;
>  
> +	/* Drop the reference taken in vti_input().  -EINVAL/-EPERM make
> +	 * xfrm_input() re-invoke us with err = -1 and drop it then.
> +	 */

[Severity: High]
Does every drop in xfrm_input() actually call back here with err = -1?

In xfrm_input(), the early invalid-state check jumps to drop before family
is set:

net/xfrm/xfrm_input.c:xfrm_input() {
	unsigned int family = AF_UNSPEC;
    ...
		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
			...
			if (encap_type == -1)
				dev_put(dev);
			goto drop;
		}

		family = x->props.family;
    ...
drop:
	if (async)
		dev_put(dev);
	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
	kfree_skb(skb);
	return 0;
}

With family == AF_UNSPEC, xfrm_rcv_cb() looks up
xfrm_input_afinfo[is_ipip][0]. Nothing is registered at that index, since
only AF_INET and AF_INET6 register. So it returns without ever calling
vti_rcv_cb():

	afinfo = xfrm_input_get_afinfo(family, is_ipip);
	if (!afinfo)
		return -EAFNOSUPPORT;

The skb is then freed, and the reference taken in vti_input() is never
dropped.

This path can be reached in three ways:

  - async resume (encap_type == -1) when the SA was deleted or expired
    while decryption was in flight, e.g. ip xfrm state flush or an IKE
    rekey under traffic with an async crypto driver
  - the hardware offload entry (encap_type == 0) with a non-valid SA
  - IPTFS re-injection (encap_type == -2) with a non-valid SA

Would the VTI device then wait forever in netdev_wait_allrefs_any() on
unregister? The vti6 follow-up commit adds the same hold in
vti6_input_proto(), so it looks exposed as well.

>  	if (err) {
>  		DEV_STATS_INC(dev, rx_errors);
>  		DEV_STATS_INC(dev, rx_dropped);
>  
> +		dev_put(dev);
>  		return 0;
>  	}
>  
> @@ -141,6 +147,7 @@ static int vti_rcv_cb(struct sk_buff *skb, int err)
>  	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(skb->dev)));
>  	skb->dev = dev;
>  	dev_sw_netstats_rx_add(dev, skb->len);
> +	dev_put(dev);

[Severity: High]
Is this really after the last use of dev? The commit message says the
reference is dropped "after the last use". However, skb->dev was just set
to the VTI device, and xfrm_input() keeps using it after this returns 0:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
	err = xfrm_rcv_cb(skb, family, xfrm_proto, 0);
    ...
	nf_reset_ct(skb);

	if (decaps) {
		...
		if (async)
			dev_put(dev);
		gro_cells_receive(&gro_cells, skb);
    ...
}

xfrm_tunnel_check() forces tunnel mode for VTI, so decaps is set.
gro_cells_receive() reads skb->dev->flags. On the !IFF_UP drop path it
calls dev_core_stats_rx_dropped_inc(dev), which can allocate and cmpxchg
into dev->core_stats.

Here is the race, with an async ESP decrypt pending on the VTI device:

CPU1 (ip link del vtiX)
  unregister clears IFF_UP
  netdev_run_todo()
    netdev_wait_allrefs_any()   polling, the async skb holds a ref

CPU2 (crypto completion)
  xfrm_input_resume()
    xfrm_input(skb, ..., -1)
      xfrm_rcv_cb()
        vti_rcv_cb()
          dev_put(dev)          refcnt drops to 1

CPU1
    netdev_wait_allrefs_any() returns dev
    netdev_do_free_pcpu_stats(dev)
    dev->priv_destructor(dev)
    free_netdev(dev)

CPU2
      gro_cells_receive(&gro_cells, skb)
        reads skb->dev->flags   on the freed device

netdev_run_todo() has no RCU grace period between the refcount check and
the free, so the rcu_read_lock() in xfrm_input() gives no protection here.

Can this still reach the use-after-free the patch is meant to fix, just in
a smaller window?

The xfrm core does the same "if (async) dev_put(dev)" for the lower device
right before gro_cells_receive(). That shows the pattern is shared, but
not that it is safe.

Would the reference need to be held until after gro_cells_receive() or
transport_finish()?

The vti6 follow-up commit repeats the same early dev_put() in
vti6_rcv_cb().

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930090813.73901-1-q.h.hack.winter%40gmail.com
