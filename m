Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792950445;
	b=f+8aFpvC1V0MZ74mxXts+4utLuxMZHROD8vwlvcz3QH9XGQV3qIWCU8YhuX9s0akvqXw
	 0BET1Pt40+IdnVeI6XYoB2DedJ8MY2ql1RWTH5x5tOfKr7pAZ89YZj3ssT/8KokRjl4Qg
	 sVJ/YA9UeyjpiIBM1eNM+PuJZmi73br9i4Z7Oy3WkMGk8gxbWg6zEQSHxidB/ozefNCNq
	 rjFZtevLM3pqrCntiatmaF+v/6gIKB5M/dIrsL8LIMoWJdEzfzKccLNDsrvRJZQx+2TaW
	 vAZdEnrMzISIz7ttnl2xQJ/DAuG+88sE/7Fg7ffetmmARDxFy7p3F0DTI9t5+S3sOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792950445;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JmRLzeYCdX82mXLcM2/P5to8iYH2FEbFcSMJ+Fc1J2c=;
	b=QWQjc82fj6YwM0sK6o7pCfArW1PMbqDVyKt+5BknBpLHERpIbY30vE8HXVSPxy2fRlgn
	 EoFNcOnEwafQpxBouwbEeiBXE2rYxps0cdvchRktWSS2kHTVVZoDtVij2Y2C3urVMRldn
	 F9w8nk4HySeoWGT07Mp1a0kk2N+YpW3L3lHmzOnllrrT3VqNoCVkviZ2TNJGEL2D71q4g
	 qBs+urPId5DlwhyRV3oRgworQs/M1+I3Yh/HVWJsley2WupYvzLAXN8gg9iS8GBk8nT5R
	 BES4MHNhYv3kggdwMsZoZgGEgkON+NX8N9VXOH6TKi8C5Sibu5CFymDFZjO6UTKg6nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jn1k33FD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16207606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jn1k33FD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BCC91F01825;
	Sun, 25 Oct 2026 17:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792950444;
	bh=JmRLzeYCdX82mXLcM2/P5to8iYH2FEbFcSMJ+Fc1J2c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jn1k33FDe5oXLax1eWdO/Hg1f31PgCiRW22qsXbqYjBhi4tTIQfqEV60WVJYJme1E
	 HSVgrRsHPdxQKV14e3BdAKtVMl7pAQQ0nNBa17sk+RqkD/QHf2s5cb2FSLQgxHlXd6
	 iYrs0RCgg2P8rFbkMAL9hMy+U8vj64ev3NIR0d7RGmxlOZGKkdVYJpEbDEHxt7whta
	 UW3Rq/Zb6RwtcTnAXlsed25mNocbWklBV8uVvEsdTGyqgHJFsDXFzi5+5iQh7rIdG7
	 8Lfs+RIjJiRiRxP5IuQQ7hj70eY3SnVNl9mCObN9ZlGSwW6l5PvvM3FcwJwQcpT8G2
	 KgVU/yQCLxLIQ==
Subject: Re: [PATCH net] net: xps: re-validate the queue index after switching
 to the subordinate device
From: netdev-bot+sashiko@kernel.org
To: phx0fer@gmail.com
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Date: Sun, 25 Oct 2026 17:47:23 +0000
Message-ID: <179295044377.3134.4218140441633589596@kernel.org>
In-Reply-To: <20261021155555.68167-1-phx0fer@gmail.com>
References: <20261021155555.68167-1-phx0fer@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix applies the wrong bound and leaves the faulty access in
  place.
- [Medium] The new check also runs when the queue has no sb_dev and `dev`
  is still the parent.
- [Low] The commit message describes the defect inaccurately.
- [Low] The submission notes ('Triggering conditions', below the ---
  line) say the in-tree subordinate binding happens on 'the i40e and…

--

net: xps: re-validate the queue index after switching to the subordinate device

This patch adds a check to __netif_set_xps_queue(). After dev has been
switched to the subordinate device, index is compared against that
device's real_num_tx_queues and -EINVAL is returned if it is too large.
The goal is to stop the KASAN slab-out-of-bounds write reported from
xps_cpus_store().

> A subordinate with fewer TX queues than the parent's index then
> overflows sb_dev->_tx[] / the XPS map:

[Severity: Low]
Is the "/ the XPS map" part accurate? In __netif_set_xps_queue() the XPS
maps are indexed by tci, not by index:

    tci = j * num_tc + tc;
    map = copy ? xmap_dereference(dev_maps->attr_map[tci]) : NULL;

and index is only stored as a value:

    map->queues[map->len++] = index;

The only out-of-bounds subscript seems to be netdev_get_tx_queue(dev,
index) in the NUMA node write at out_no_new_maps.

Also, netdev_set_sb_channel() rejects multiqueue devices, so every in-tree
subordinate has exactly one TX queue. That means "fewer TX queues than the
parent's index" is not a corner case. It covers every XPS write to any
offloaded queue.

Could the commit message describe this more precisely?

> CAP_NET_ADMIN to set the XPS mask.  An sb_dev is bound in-tree by
> netdev_bind_sb_channel_queue(), which the i40e and ixgbe SR-IOV paths call
> when a VF's channel is bound to the PF.

[Severity: Low]
Is this description of the trigger correct? The only callers of
netdev_bind_sb_channel_queue() are ixgbe_fwd_ring_up() and
i40e_fwd_ring_up(). Both bind queues to a macvlan netdevice for L2
forwarding offload, via ndo_dfwd_add_station (ixgbe_fwd_add() and
i40e_fwd_add()):

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_fwd_ring_up() {
    ...
	/* record configuration for macvlan interface in vdev */
	for (i = 0; i < num_tc; i++)
		netdev_bind_sb_channel_queue(adapter->netdev, vdev,
					     i, rss_i, baseq + (rss_i * i));
    ...
}

Enabling VFs alone does not seem to set up this binding. The trigger
appears to be a macvlan with l2-fwd-offload on an ixgbe or i40e parent.

> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..d5ce251448062 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -2900,6 +2900,14 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
>  		/* If queue belongs to subordinate dev use its map */
>  		dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
>  
> +		/* dev may now be the subordinate device, whose queue
> +		 * count can be smaller than the parent's.  index was only
> +		 * validated against the parent above, so re-check it before
> +		 * it is used to index the (possibly different) dev->_tx[].
> +		 */
> +		if (index >= dev->real_num_tx_queues)
> +			return -EINVAL;

[Severity: High]
Does this compare a parent-space index against the subordinate's queue
count?

netdev_bind_sb_channel_queue() checks offset + count against the parent's
real_num_tx_queues and stores the parent-space offset in
sb_dev->tc_to_txq[]. So index here is a parent queue number:

net/core/dev.c:netdev_bind_sb_channel_queue() {
    ...
	/* We cannot hand out queues we don't have */
	if ((offset + count) > dev->real_num_tx_queues)
		return -EINVAL;
    ...
	WRITE_ONCE(sb_dev->tc_to_txq[tc].combined, res.combined);
    ...
}

netdev_set_sb_channel() refuses multiqueue devices, and ixgbe_fwd_add()
rejects multiqueue macvlans. So sb_dev->real_num_tx_queues is always 1:

net/core/dev.c:netdev_set_sb_channel() {
	/* Do not use a multiqueue device to represent a subordinate channel */
	if (netif_is_multiqueue(dev))
		return -ENODEV;
    ...
}

ixgbe_fwd_ring_up() binds at baseq + (rss_i * i), where baseq is
pool * queues_per_pool. Pool 0 is reserved for the PF, so pool is at least
1. i40e_fwd_ring_up() binds at iter->base_queue, which comes after the
PF's own queues. In both cases every bound index is >= 1.

With that, won't every xps_cpus and xps_rxqs write to a parent TX queue
bound to an offloaded macvlan now fail with -EINVAL? Before this patch the
map update itself worked. Only the trailing NUMA hint write was out of
bounds.

Driver-internal callers are hit too. ixgbe_configure_tx_ring() ignores the
return value of netif_set_xps_queue() after test_and_set_bit() has already
set __IXGBE_TX_XPS_INIT_DONE. XPS setup for those rings is then never
retried.

XPS_RXQS writes through xps_rxqs_store() are now rejected as well, even
though that path never indexes _tx[index]. Meanwhile xps_cpus_show() still
accepts the same parent index on the same queue, so show and store now
disagree.

The faulty access also seems to be left unchanged:

net/core/dev.c:__netif_set_xps_queue() {
    ...
out_no_new_maps:
	if (type == XPS_CPUS)
		/* update Tx queue numa node */
		netdev_queue_numa_node_write(netdev_get_tx_queue(dev, index),
					     (numa_node_id >= 0) ?
					     numa_node_id : NUMA_NO_NODE);
    ...
}

If an index ever gets past the new check, won't the NUMA hint go to
sb_dev->_tx[index] instead of the parent's queue? The parent queue would
then keep a stale value.

Would it be better to save the original parent device (or its txq) before
the rebind and use it for the NUMA write, rather than bounding index by the
subordinate's queue count?

[Severity: Medium]
This check is inside if (dev_num_tc) and runs whether or not a rebind
happened. When the queue has no sb_dev, dev is still the parent.

On any device with num_tc != 0, the accepted range therefore shrinks from
num_tx_queues to real_num_tx_queues. num_tx_queues is the existing
contract, per the WARN_ON_ONCE() at the top of the function. Devices with
num_tc == 0 get no such check.

Can this break drivers that configure XPS before raising
real_num_tx_queues? ixgbe_open() does things in this order:

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:ixgbe_open() {
    ...
	ixgbe_configure(adapter);
    ...
	/* Notify the stack of the actual queue counts. */
	queues = adapter->num_tx_queues;
	err = netif_set_real_num_tx_queues(netdev, queues);
    ...
}

ixgbe_configure() reaches netif_set_xps_queue() through
ixgbe_configure_tx_ring(). When DCB is enabled through ixgbe_setup_tc(),
the flow is netdev_set_num_tc() -> new rings -> ixgbe_open(). If the new
ring count is larger than the previous real_num_tx_queues, XPS for the
extra queues would now fail with -EINVAL.

ixgbe_configure_tx_ring() ignores that error, and __IXGBE_TX_XPS_INIT_DONE
is already set. XPS would then be silently and permanently missing for
those queues. i40e_vsi_open() has the same ordering:
i40e_vsi_configure() runs before i40e_netif_set_realnum_tx_rx_queues().

>  		tc = netdev_txq_to_tc(dev, index);
>  		if (tc < 0 || tc >= num_tc)
>  			return -EINVAL;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021155555.68167-1-phx0fer%40gmail.com
