Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1713E47ACE4;
	Wed, 14 Oct 2026 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965953; cv=none; b=KZ31/m3DG54imz2ymWnerR7zfc2wRybjRtg8STyDh7I1QYjcV8fkfAvEXnuLVOZDvmSUq+QFu0k84I5VrjDiXXtvr2pIQnI3J0zuTZIDEWqms1dFv3uSHZLGaLR8Z+uHTxg+XXZQYm5ECrqOA/l9LnZ6zuhxDNgdEVcCMW42b/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965953; c=relaxed/simple;
	bh=TnqSYIPvmXi7Jlqp1PlbuouXZFSASkf6zvgyxSZGehc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mi+e65v6BjsM16ri2sKND+/xvKn2I88th+n5VT2ZF1t19G6vnleZ/UsUFNpAal7Yl/Z2zcpW9DJO1AOMcNjd2ZGTQIMkfgcr50pjDZ80DXA+5fMu1vuxxZh1DslHeTEb7f3KFGrHodam6arzwMPETwbuqUGWRd+U4ONSMVfFEB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZ7OTmlq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZ7OTmlq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20E1F00898;
	Wed, 14 Oct 2026 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791965949;
	bh=iMG0H6o2i77Q4MwIy/12e+4FfGXUgFSDm193MMw0c28=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QZ7OTmlqb/NEfvCt5w2JQZuaCzkWsEmS0L1FfANlUKUrnmTaABEQgFbk3pZ/wEQmO
	 JfExkIhYBn35z+m+VhO4iAh2aYUsccbhtuNdh4YYsS6SYn5XLo9AomMjotgHrjQcVh
	 G/fM7qhl8+2oIk/C2/qZacvBiNM+Us5PyiT0HPrOnTpUoKXx5XLY6JJGDbf444lfgS
	 oRScT1slWmKmTWHq0ik+UHJENtL0SllJ/21SuvqP3jXed3CNVPixUYPjxbHBbzaHxH
	 ChSLtNjwhGPCR6Oe1r8YvJIsZqzi7GKIYCNTd0jTSWZSfL9tVZsYL1WjIe+GvEJJIA
	 2PfLrPowtN6RA==
Subject: Re: [PATCH net v2 3/3] xfrm: transfer the skb->dev reference to the
 input path
From: netdev-bot+sashiko@kernel.org
To: q.h.hack.winter@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, chopps@labn.net,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 idosch@nvidia.com, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 08:19:08 +0000
Message-ID: <179196594850.434549.3376029552147276447@kernel.org>
In-Reply-To: <20261013074610.17808-4-q.h.hack.winter@gmail.com>
References: <20261013074610.17808-4-q.h.hack.winter@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 4 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In xfrmi_rcv_cb() (net/xfrm/xfrm_interface_core.c),
  dev_hold(dev) only runs when skb->dev != xi->dev (line 378-383), but…
- [High] vti_input() (net/ipv4/ip_vti.c:66) and vti6_input_proto()
  (net/ipv6/ip6_vti.c:326) always call dev_hold(tunnel->dev).
- [High] The dev_hold() added in vti_input()/vti6_input_proto() is only
  released if a receive callback later runs for the same skb.
- [High] In the decaps and GRO paths, xfrm_input() calls dev_put(tdev)
  right after gro_cells_receive() returns (net/xfrm/xfrm_input.c:775-777…
- [Medium] In xfrmi_rcv_cb(), the err==0 call takes the reference
  (dev_hold(xi->dev), skb->dev = xi->dev) and can still fail afterwards:…
- [Medium] For a cross-namespace collect_md xfrm interface (xnet true,
  xi->p.collect_md), xfrmi_rcv_cb() takes dev_hold(xi->dev) and calls…

--

xfrm: transfer the skb->dev reference to the input path

This patch has vti_input() and vti6_input_proto() take a reference on the
tunnel device. xfrmi_rcv_cb() takes one when it installs the device in
skb->dev. xfrm_input() then releases that reference after the skb has been
handed to gro_cells_receive() or transport_finish(), and the callbacks
drop it on their error paths.

> diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
> index 3b80929994a00..1964482064c16 100644
> --- a/net/ipv4/ip_vti.c
> +++ b/net/ipv4/ip_vti.c
> @@ -63,6 +63,8 @@ static int vti_input(struct sk_buff *skb, int nexthdr, __be32 spi,
>  
>  		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = tunnel;
>  
> +		dev_hold(tunnel->dev);
> +
>  		if (update_skb_dev)
>  			skb->dev = tunnel->dev;
>  

[Severity: High]
This hold is unconditional. On the success path, xfrm_input() only
releases it if skb->dev changed during the call:

net/xfrm/xfrm_input.c:xfrm_input() {
    struct net_device *dev = skb->dev;
    ...
    tdev = skb->dev != dev ? skb->dev : NULL;
    gro_cells_receive(&gro_cells, skb);
    if (tdev)
        dev_put(tdev);
    ...
}

What happens if skb->dev already is tunnel->dev when xfrm_input() is
entered? In that case the skb->dev = dev assignment in vti_rcv_cb()
changes nothing and tdev stays NULL. The reference taken here would then
leak for every packet that is delivered successfully.

Nested ESP decapsulated twice by the same VTI looks like one way to get
there. For a keyless inner packet, ip_tunnel_lookup() can return the same
tunnel through a wildcard VTI (saddr=daddr=0), the ip_vti0 fallback, or
matching inner endpoints, because the link is only a preference.
vti6_tnl_lookup() matches only on addresses plus tnls_wc, so the IPv6 side
looks the same.

The update_skb_dev branch just below also sets skb->dev = tunnel->dev
before xfrm_input() runs. No in-tree caller passes true today, but if one
did, wouldn't every packet leak a reference?

Would ip link del or netns teardown then hang in netdev_wait_allrefs_any()
on this device?

In this case the new comment in vti_rcv_cb(), "on success it is
transferred with skb->dev and released by xfrm_input()", doesn't hold.
xfrmi_rcv_cb() also only takes its reference when skb->dev changes, so
vti/vti6 and xfrmi follow different rules for the same release check.

[ ... ]

> diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
> index ab94b3a4ba9c3..a47acae4756c2 100644
> --- a/net/ipv6/ip6_vti.c
> +++ b/net/ipv6/ip6_vti.c
> @@ -322,6 +322,9 @@ static int vti6_input_proto(struct sk_buff *skb, int nexthdr, __be32 spi,
>  		rcu_read_unlock();
>  
>  		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = t;
> +
> +		dev_hold(t->dev);
> +
>  		XFRM_SPI_SKB_CB(skb)->family = AF_INET6;
>  		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
>  		return xfrm_input(skb, nexthdr, spi, encap_type);

[Severity: High]
The reference taken here, and the one in vti_input(), is only dropped if a
receive callback later runs for this same skb. Is that guaranteed when the
SA is in IPTFS mode?

iptfs_input() always returns -EINPROGRESS. xfrm_input() then returns
without calling xfrm_rcv_cb() and without reaching the tdev release:

	err = xfrm_inner_mode_input(x, skb);
	if (err == -EINPROGRESS) {
		if (async)
			dev_put(dev);
		return 0;

IPTFS then frees the outer skb on several paths that skip the callbacks:

net/xfrm/xfrm_iptfs.c:__input_process_payload() {
    ...
	if (defer) {
		consume_skb(defer);
    ...
}

If the original skb is reused for a partial inner packet, it becomes
xtfs->ra_newskb. That skb is later freed in one of three places:

  kfree_skb() in __iptfs_reassem_done()
  kfree_skb_reason(skb, SKB_DROP_REASON_FRAG_REASM_TIMEOUT) in
  iptfs_drop_timer()
  kfree_skb() in iptfs_delete_state()

iptfs_delete_state() also frees the reorder-window skbs in w_saved with
kfree_skb().

The inner skbs built by iptfs_alloc_skb() copy dev and the skb extensions
but not cb. Their tunnel pointer is therefore NULL, and vti_rcv_cb() and
vti6_rcv_cb() return 1 for them without dropping the outer skb's
reference.

Could each of these outer packets leak one reference on the VTI device? A
reassembly timeout after ordinary packet loss looks like enough to trigger
it. This still seems to be true with the preceding commit "xfrm: iptfs:
run the receive callbacks before freeing the skb" applied.

[ ... ]

> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index f293d5e124d47..bdd493f9d877a 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c

[ ... ]

> @@ -767,7 +768,13 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
>  			skb_dst_drop(skb);
>  		if (async)
>  			dev_put(dev);
> +		/* Release the reference a receive callback left with
> +		 * skb->dev, after the packet has been delivered.
> +		 */
> +		tdev = skb->dev != dev ? skb->dev : NULL;
>  		gro_cells_receive(&gro_cells, skb);
> +		if (tdev)
> +			dev_put(tdev);

[Severity: High]
Has the packet actually been delivered at this point?
gro_cells_receive() only queues the skb on the per-CPU xfrm gro_cells and
calls napi_schedule(). The skb is processed later, in
gro_cell_poll()->napi_gro_receive(), which dereferences skb->dev.

Nothing purges the global xfrm gro_cells when a vti or xfrmi device is
unregistered. netdev_run_todo() frees the device as soon as
netdev_wait_allrefs_any() sees the refcount at 1.

Suppose the gro_cell NAPI poll is deferred (to ksoftirqd, on PREEMPT_RT,
or after a crypto completion in process context). Can a concurrent
RTM_DELLINK then free the device before gro_cell_poll() touches skb->dev?
The xfrm_gro branch below drops tdev the same way.

xfrm_trans_queue_net() in this file holds skb->dev across deferred
delivery:

	if (skb->dev)
		dev_hold(skb->dev);

This window existed before the patch. However, the commit message says the
reference is released "once the packet has been delivered" and that
RTM_DELLINK "now waits for the completion". Neither seems to be true for
this gro_cells path, which is the tunnel-mode path from the KASAN report in
the commit message.

>  		rcu_read_unlock();
>  		return 0;
>  	} else {

[ ... ]

> diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
> index 688306bf62c5a..f4859be7ed189 100644
> --- a/net/xfrm/xfrm_interface_core.c
> +++ b/net/xfrm/xfrm_interface_core.c
> @@ -375,11 +375,18 @@ static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
>  
>  	link = skb->dev->ifindex;
>  	dev = xi->dev;
> -	skb->dev = dev;
> +	if (skb->dev != dev) {
> +		/* Reference travels with skb->dev; released by xfrm_input()
> +		 * after delivery.  Guard makes a re-invocation a no-op.
> +		 */
> +		dev_hold(dev);
> +		skb->dev = dev;
> +	}

[Severity: High]
The hold only happens when skb->dev != xi->dev, but the dev_put() added to
the err branch below always runs. What happens with nested IPsec that
terminates on the same xfrm interface?

After the outer tunnel-mode SA is decapsulated, skb->dev is the xfrmi
device. The inner ESP then comes back in through:

xfrm4_rcv()->xfrmi4_rcv()->xfrmi_input()->xfrm_input()

At that point skb->dev == xi->dev, and the secpath is still there because
the non-xnet scrub does not reset it. xfrmi_lookup() can map the inner SA
to the same xi, either through a matching if_id or through the
collect_md_xfrmi fallback:

	xi = rcu_dereference(xfrmn->collect_md_xfrmi);
	if (xi && (xi->dev->flags & IFF_UP))
		return xi;

In that case this block takes no hold. Any drop after the inner SA has been
added to the secpath (replay check, ICV failure, hard lifetime expiry and
so on) goes through the drop label in xfrm_input():

drop:
	if (async)
		dev_put(dev);
	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
	kfree_skb(skb);

That reaches the dev_put() below with no matching hold. The same happens
when the err == 0 call returns -EPERM, -EINVAL or -ENOMEM and the callback
is called again with err == -1.

Can this underflow the xfrmi refcount by one for every dropped packet? On
unregister, netdev_wait_allrefs_any() could then return while real holders
still exist. The "Guard makes a re-invocation a no-op" comment only seems
true when the first call took the reference.

>  
>  	if (err) {
>  		DEV_STATS_INC(dev, rx_errors);
>  		DEV_STATS_INC(dev, rx_dropped);
> +		dev_put(dev);
>  
>  		return 0;
>  	}

[Severity: Medium]
Suppose the err == 0 call takes the reference and then fails: -EINVAL for
a NULL inner mode or -EPERM from xfrm_policy_check() in the xnet case, or
-ENOMEM from metadata_dst_alloc(). The release then depends on the
err == -1 call from the drop label reaching this dev_put().

That second call repeats xfrmi_lookup() after xfrm_input() has done
rcu_read_unlock(), and no lock is held between the two calls:

	xi = xfrmi_lookup(xs_net(x), x);
	if (!xi)
		return 1;

If the interface is set down (IFF_UP cleared), or deleted through
xfrmi_dev_uninit()->xfrmi_unlink(), inside that window, the lookup returns
NULL and the dev_put() is skipped. If the lookup falls back to
collect_md_xfrmi instead, a different device gets held and put.

Since kfree_skb() does not release skb->dev, is the reference on the
original device leaked in either case?

[Severity: Medium]
Can the -ENOMEM path also skip this dev_put() for a cross-netns
collect_md interface? With xnet true, xfrmi_scrub_packet() runs after the
hold and resets the secpath:

	if (!xnet)
		return;

	ipvs_reset(skb);
	secpath_reset(skb);

Now suppose metadata_dst_alloc() fails:

		md_dst = metadata_dst_alloc(0, METADATA_XFRM, GFP_ATOMIC);
		if (!md_dst)
			return -ENOMEM;

The err == -1 call from xfrm_input() then returns early at the top of
xfrmi_rcv_cb(), because the secpath is gone:

	if (err && !secpath_exists(skb))
		return 0;

Would the xfrmi reference then never be released?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013074610.17808-1-q.h.hack.winter%40gmail.com
