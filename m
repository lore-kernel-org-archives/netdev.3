Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58893B14B4
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791108510; cv=none; b=hoDEMwIFPCUd8Y9Eeh4U/Bp0/Te5wGYIV+niTU2QtpWZHLs2wT8SlXPw58s1L4DLpRNPsjVX8kQ407iHpsCw+xhwctcFMmasal0+ZyCrIma/DH26tId2kwsHwKbluiy4RyBt2xUW8aAqPdQ3kYxdx228NNbA+yV8OYvKEXIspwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791108510; c=relaxed/simple;
	bh=ZOLUqWQEEg8TZeQ3pWAI7dlROHYOjzOvuoezSeRSEnA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T3LlQ5OxwUyCBKvO8Tj+XMxGkpz4KsVknXwbJYrcQLEiDyYnJmcSG7x740ZQa1Rd4P7Fh8+iD7CXknA8Gb8/pcgI7irgvHbY7A/t8INX8e4YXVfK6xOTd/9B+BUTSs5iWfa09H5977b8rWwojOJSilmdNIm/In9Z4Sa4asRsl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK/IvoLy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dK/IvoLy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F811F00899;
	Sun,  4 Oct 2026 10:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791108508;
	bh=4gX6xxDYYhSNEN2ziZbKbSZ+gL0pAeF1+GewCfGqaAA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dK/IvoLyhu/qWRwYb6ZSW5oCBUEj3Ge4/YBDQegeOoK8saW9YFGTHVs41Z17eW7ZS
	 ZSyVIUYjTEJZd/4eSmHeOAPTUv3ZbiGPuNSk2SP6jm8mRZeSK6z4sjoX1/WA9dK9vp
	 vRwDQVuXOyB841KrLj/WepGhMwtGHmkLq9MYwP+flxEqAzrSD582z2jQzyxGz81LEg
	 griFuJeAjrfbYCGR/pkxClqAj/KjMJcHCKiw28/5xQtXL2QiHmoY7EqDC5N2fmAUMs
	 R2TQQsCcR9+jPIjpUdkraajgyan075Q5cAy66szrUQ+T0KQdtK1op9II0DVS8tW/43
	 JG/ZDWe0AufQg==
Subject: Re: [PATCH net 2/2] vti6: fix tunnel device use-after-free across
 async crypto resumption
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, kuba@kernel.org
Date: Sun, 04 Oct 2026 10:08:27 +0000
Message-ID: <179110850758.434549.17852121461164878491@kernel.org>
In-Reply-To: <20260930090813.73901-3-q.h.hack.winter@gmail.com>
References: <20260930090813.73901-3-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] This patch leaks the new ip6_vti device reference whenever an
  async-resumed (or HW-offloaded) packet hits an SA that is no longer…
- [High] On a vti6 tunnel whose SA uses IP-TFS mode, the new dev_hold()
  leaks for every outer packet that IP-TFS frees instead of reinjecting.
- [High] vti6_rcv_cb() sets skb->dev to the vti6 device (line 395) and
  then calls dev_put(dev) (line 397).
- [Medium] Unloading the module can hang forever if the fallback ip6_vti0
  device still has an async receive in flight.

--

vti6: fix tunnel device use-after-free across async crypto resumption

When vti6_input_proto() caches the tunnel pointer in the skb cb, this
commit now takes a reference on the vti6 tunnel device. vti6_rcv_cb()
drops that reference on both its error path and its success path. The
change mirrors the equivalent IPv4 vti fix.

> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index ab94b3a4ba9c3..b53830d5cf54b 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -322,6 +322,9 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
>  		rcu_read_unlock();
>  
>  		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
> +
> +		dev_hold(t->dev);
> +

[Severity: High]
Can this reference leak when an async-resumed packet hits an SA that is
no longer valid?

The only dev_put() calls that match this dev_hold() are in
vti6_rcv_cb(). xfrm_input() does not always reach the protocol callback
chain.

Suppose esp6_input() returns -EINPROGRESS, and the SA is deleted or
expires before esp_input_done() calls xfrm_input_resume(). The resumed
xfrm_input() call then takes the early branch:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
			...
			if (encap_type == -1)
				dev_put(dev);
			goto drop;
		}

		family = x->props.family;
    ...
}

At the drop label family is still AF_UNSPEC, so this runs:

drop:
	if (async)
		dev_put(dev);
	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
	kfree_skb(skb);

Only AF_INET and AF_INET6 afinfo are ever registered, so
xfrm_input_get_afinfo(AF_UNSPEC, is_ipip) returns NULL. xfrm_rcv_cb()
then returns -EAFNOSUPPORT and never calls xfrm6_rcv_cb() or
vti6_rcv_cb().

The offload path can hit the same early drop without any async crypto.
Take an skb with xfrm_offload state, received with GRO disabled. It goes
through vti6_rcv()->vti6_input_proto(..., 0) and takes the early branch
because xo && encap_type == 0.

Before this patch, skipping vti6_rcv_cb() here only lost a stats
increment. With the new dev_hold(), would a later unregister of the
ip6_vti device wait forever in netdev_wait_allrefs_any()? Deleting the
old SA after an IKE rekey looks like a routine way to trigger this.

The IPv4 patch in this series has the same gap in vti_input() and
vti_rcv_cb().

[Severity: High]
What happens to this reference when the SA on the vti6 tunnel uses
IP-TFS mode?

xfrm_tunnel_check() accepts IP-TFS SAs here, because the IPTFS entry in
xfrm6_mode_map has XFRM_MODE_FLAG_TUNNEL set. After decryption,
xfrm_inner_mode_input() calls x->mode_cbs->input(), which is
iptfs_input(). That function always returns -EINPROGRESS. xfrm_input()
then returns without calling xfrm_rcv_cb() for the outer skb:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
		err = xfrm_inner_mode_input(x, skb);
		if (err == -EINPROGRESS) {
			if (async)
				dev_put(dev);
			return 0;
    ...
}

That dev_put() only drops the reference on the lower device.

The outer skb carries tunnel.ip6 in its cb. It only gets back to
vti6_rcv_cb() if IP-TFS reuses it as the first inner packet and
reinjects it with xfrm_input(skb, 0, 0, -2). In several other cases
IP-TFS frees it without any callback:

  - iptfs_input_ordered() on an invalid IP-TFS header (kfree_skb at
    done:)
  - __input_process_payload() on pad-only or continuation-only payloads
    (!first_skb leads to kfree_skb), and the defer consume_skb
  - the reorder-window freelist in iptfs_input()
  - expiry of the reassembly drop timer for ra_newskb

Inner skbs from iptfs_alloc_skb() have a zeroed cb. vti6_rcv_cb()
returns 1 for them without calling dev_put().

Would each of these outer packets leak one reference on the vti6
device? The peer controls the payload layout, and all-pad IP-TFS packets
are normal traffic. The IPv4 patch has the same issue.

[Severity: Medium]
Can rmmod ip6_vti hang forever if the fallback ip6_vti0 device has an
async receive in flight?

vti6_tnl_lookup() can return the fallback tunnel while its device is up,
so this dev_hold() can be taken on ip6_vti0. vti6_tunnel_cleanup() then
runs:

	rtnl_link_unregister(&vti6_link_ops);
	...
	xfrm6_protocol_deregister(&vti_ipcomp6_protocol, IPPROTO_COMP);
	xfrm6_protocol_deregister(&vti_ah6_protocol, IPPROTO_AH);
	xfrm6_protocol_deregister(&vti_esp6_protocol, IPPROTO_ESP);
	unregister_pernet_device(&vti6_net_ops);

rtnl_link_unregister() does not drain ip6_vti0, because vti6_dellink()
skips it:

	if (dev != ip6n->fb_tnl_dev)
		unregister_netdevice_queue(dev, head);

Suppose the crypto completion runs after the xfrm6_protocol_deregister()
calls. xfrm6_rcv_cb() only walks the handlers that are still registered,
so vti6_rcv_cb() never runs and the reference is never dropped.

Would unregister_pernet_device() then wait forever in
netdev_wait_allrefs_any() for ip6_vti0, while holding pernet_ops_rwsem?

[ ... ]

> @@ -387,6 +394,7 @@ static int vti6_rcv_cb(struct sk_buff *skb, int err)
>  	skb_scrub_packet(skb, !net_eq(t->net, dev_net(skb->dev)));
>  	skb->dev = dev;
>  	dev_sw_netstats_rx_add(dev, skb->len);
> +	dev_put(dev);

[Severity: High]
Is this reference dropped before the last use of the vti6 device?

skb->dev has just been set to the vti6 device. After xfrm_rcv_cb()
returns, xfrm_input() keeps using it in the decaps branch:

net/xfrm/xfrm_input.c:xfrm_input() {
    ...
		if (async)
			dev_put(dev);
		gro_cells_receive(&gro_cells, skb);
		rcu_read_unlock();
    ...
}

The dev_put() there only drops the reference on the original lower
device. gro_cells_receive() then dereferences skb->dev:

net/core/gro_cells.c:gro_cells_receive() {
	struct net_device *dev = skb->dev;
	...
	if (unlikely(!(dev->flags & IFF_UP)))
		goto drop;
	...
drop:
		dev_core_stats_rx_dropped_inc(dev);
    ...
}

Consider an unregister that starts while crypto is pending. It has
already cleared IFF_UP and finished its synchronize_net() calls, and is
now polling in netdev_wait_allrefs_any().

Once this dev_put() brings the refcount to 1, netdev_run_todo() goes on
to free the pcpu stats and the device with no further grace period. The
rcu_read_lock() in xfrm_input() started after the unregister's grace
periods, so it does not hold off that free.

Could gro_cells_receive() then read dev->flags and write
dev->core_stats on freed memory?

The commit message says:

    Take a device reference while the pointer is cached and drop it in
    vti6_rcv_cb() after the last use, like the IPv4 side.

The last use of the device is in xfrm_input(), after vti6_rcv_cb() has
returned, so the use-after-free window seems narrower but still
reachable. The IPv4 patch has the same ordering.

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930090813.73901-1-q.h.hack.winter%40gmail.com
