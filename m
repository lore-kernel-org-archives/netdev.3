Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0CD4AC179;
	Thu, 24 Sep 2026 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269663; cv=none; b=gA4ugF9KPW7y9wFt5yRpuWquim8WOABc6MTTMdylBxOP3LsUjn7XNHKf781n1PFYtsnIkm5BZE8LCU5SQtPHge0LbHQguntdejN+oji5g7p0rbNxJauKJU/GGMEDkWSFODqi/t557c6VHrtHOshpk7a6rhQCiMa3qpvzX2mSXLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269663; c=relaxed/simple;
	bh=eBY7kXWsUbCdK3XMq+M1nQQA4/Cyln6uJGihZ9fjPwQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQhLJGimlIANpbOmpj/Nmk1bpogfBT0VR+9MMMOL/VHWvwDg8eZrzNHXeWkuASBVhD2XK0NqojGMx0DWICUrpIr0M668EgVCeomwX7UTUtk7r0t4A6th+adca4vhgj33X+GGxyhQJtDwZPJ/5SjQCIsCdmsRVK+Gg1cFLGilGSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2VQRGSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2VQRGSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C471F00893;
	Thu, 24 Sep 2026 17:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269661;
	bh=/E9ni1dbdRqAR/Wr+hGMJjflP7dYxj+o6mI6TPUbxq4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=V2VQRGSbddgVVHHoZ4kmlzZ62By9EWqa57H9yRfC5rInaGSwr00usjUryP2oLjdf4
	 g4LJ+urnTb8uKAqHxG93wkECoCxLLVdmhU7fbIE/+OjaBpfXvPnbOvwTBHj33ucgvn
	 NWBlcJlg5aRNxtaKKwliGzIbvvkflj95QvD4ERG6arUWSFEz+Nwom5PTQ1dpktUQqI
	 AZZvktNoQjJdA8cIpOz1iJvJJE1unncmwAWRswRzrdRWdKHRUi06O28fQnvXwxz7lq
	 rysRKqvk0Iddw3QnvRMVfa6dRYB9/EYHVly2YKuOIvROQtDaTcyCuNWJEW2N9vMHVV
	 GNi3L3YUw3lZQ==
Subject: Re: [PATCH net 08/12] net: systemport: Fix out-of-bounds array
 accesses in DSA queue mapping
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org, nb@tipi-net.de
Date: Thu, 24 Sep 2026 17:07:39 +0000
Message-ID: <179026965981.2160803.17454387423518946405@kernel.org>
In-Reply-To: <20260921231305.394773-9-florian.fainelli@broadcom.com>
References: <20260921231305.394773-9-florian.fainelli@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bcm_sysport_map_queues()
  (drivers/net/ethernet/broadcom/bcmsysport.c:2356-2361) the new bounds…

Pre-existing issues:
- [Medium] bcm_sysport_unmap_queues()
  (drivers/net/ethernet/broadcom/bcmsysport.c:2367-2396) lacks the 'if…
- [Medium] priv->per_port_num_tx_queues and priv->ring_map[] are written
  by bcm_sysport_map_queues()/bcm_sysport_unmap_queues() (process…

--

net: systemport: Fix out-of-bounds array accesses in DSA queue mapping

This adds bounds checks against ARRAY_SIZE(priv->ring_map) in
bcm_sysport_select_queue(), bcm_sysport_map_queues() and
bcm_sysport_unmap_queues(), and clamps the SYSTEMPORT Lite call to
netif_set_real_num_tx_queues() to a minimum of one queue.

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index 95cead1df1607..130545cce045c 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c
> @@ -2273,7 +2273,7 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
>  	struct bcm_sysport_priv *priv = netdev_priv(dev);
>  	u16 queue = skb_get_queue_mapping(skb);
>  	struct bcm_sysport_tx_ring *tx_ring;
> -	unsigned int q, port;
> +	unsigned int q, port, index;
>  
>  	if (!netdev_uses_dsa(dev))
>  		return netdev_pick_tx(dev, skb, NULL);
> @@ -2281,8 +2281,11 @@ static u16 bcm_sysport_select_queue(struct net_device *dev, struct sk_buff *skb,
>  	/* DSA tagging layer will have configured the correct queue */
>  	q = BRCM_TAG_GET_QUEUE(queue);
>  	port = BRCM_TAG_GET_PORT(queue);
> -	tx_ring = priv->ring_map[q + port * priv->per_port_num_tx_queues];
> +	index = q + port * priv->per_port_num_tx_queues;
> +	if (unlikely(index >= ARRAY_SIZE(priv->ring_map)))
> +		return netdev_pick_tx(dev, skb, NULL);
>  
> +	tx_ring = priv->ring_map[index];
>  	if (unlikely(!tx_ring))
>  		return netdev_pick_tx(dev, skb, NULL);
>  

[Severity: Medium]

This isn't a race introduced by this patch, but since the new check reads
the same two fields, is it worth noting that bcm_sysport_select_queue()
combines priv->per_port_num_tx_queues and priv->ring_map[] with plain
loads on the lockless transmit path?

The writers run in process context under rtnl via
bcm_sysport_netdevice_event(), and bcm_sysport_map_queues() publishes the
new stride before it repopulates the table:

	priv->per_port_num_tx_queues = num_tx_queues;

	for (q = 0, qp = 0; q < dev->num_tx_queues && qp < num_tx_queues;
	     q++) {
		...
		priv->ring_map[qp + port * num_tx_queues] = ring;

There is no READ_ONCE/WRITE_ONCE, no RCU and no synchronize_net() between
the writers and bcm_sysport_select_queue(), so a transmit in flight during
a DSA reconfiguration (dsa_user_create, dsa_user_destroy or
dsa_user_change_conduit) can observe the new stride with the old table
contents, or a ring whose TDMA_DESC_RING_MAPPING no longer matches. The
ring pointers themselves stay alive for the netdev lifetime, so this looks
like mis-steering rather than a use-after-free. The new bounds check keeps
the index in range but does it make the stride and the table mutually
consistent?

> @@ -2329,7 +2332,8 @@ static int bcm_sysport_map_queues(struct net_device *dev,
>  	 */
>  	if (priv->is_lite)
>  		netif_set_real_num_tx_queues(slave_dev,
> -					     slave_dev->num_tx_queues / 2);
> +					     max_t(unsigned int, 1,
> +						   slave_dev->num_tx_queues / 2));
>  
>  	num_tx_queues = slave_dev->real_num_tx_queues;
>  
> @@ -2352,7 +2356,8 @@ static int bcm_sysport_map_queues(struct net_device *dev,
>  		ring->switch_queue = qp;
>  		ring->switch_port = port;
>  		ring->inspect = true;
> -		priv->ring_map[qp + port * num_tx_queues] = ring;
> +		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
> +			priv->ring_map[qp + port * num_tx_queues] = ring;
>  		qp++;
>  	}
>  

[Severity: Medium]

When the index is out of range here, only the software record is dropped:
ring->switch_queue, ring->switch_port and ring->inspect are still
committed, qp is still advanced, and bcm_sysport_map_queues() still
returns 0 (NOTIFY_OK). Does that leave hardware and software state
inconsistent?

bcm_sysport_init_tx_ring() programs the hardware mapping purely from those
ring fields on every open and resume:

	reg = tdma_readl(priv, TDMA_DESC_RING_MAPPING(index));
	reg &= ~(RING_QID_MASK | RING_PORT_ID_MASK << RING_PORT_ID_SHIFT);
	if (ring->inspect) {
		reg |= ring->switch_queue & RING_QID_MASK;
		reg |= ring->switch_port << RING_PORT_ID_SHIFT;
	} else {
		reg |= RING_IGNORE_STATUS;
	}

So the ring is bound by hardware to a switch (port, queue) pair that
bcm_sysport_select_queue() can never resolve, and those frames fall back
to netdev_pick_tx() where they can land on a ring programmed for a
different switch port and queue.

Since ring->inspect stays true, later bcm_sysport_map_queues() calls for
other ports skip the ring:

		if (ring->inspect)
			continue;

which permanently consumes the ring for a mapping that was never
recorded. Would skipping the whole iteration (not setting inspect, not
advancing qp, not programming the register), or warning and failing, be
closer to the intent than dropping only the ring_map store?

For what it's worth, I could not find an in-tree configuration that
reaches this branch today: ARRAY_SIZE(priv->ring_map) is 96, the maximum
ds->num_tx_queues is 8 and bcm_sf2 clamps num_ports to DSA_MAX_PORTS,
giving a largest index of 95.

> @@ -2383,7 +2388,8 @@ static int bcm_sysport_unmap_queues(struct net_device *dev,
>  
>  		ring->inspect = false;
>  		qp = ring->switch_queue;
> -		priv->ring_map[qp + port * num_tx_queues] = NULL;
> +		if (qp + port * num_tx_queues < ARRAY_SIZE(priv->ring_map))
> +			priv->ring_map[qp + port * num_tx_queues] = NULL;
>  	}
>  
>  	return 0;

[Severity: Medium]

Same question in the other direction: ring->inspect is cleared
unconditionally while the ring_map clear can now be skipped. Can that
leave a stale non-NULL entry in priv->ring_map[] that
bcm_sysport_select_queue() keeps returning for a ring that is no longer
set up for switch queue inspection?

[Severity: Medium]

This is a pre-existing issue and not something this patch introduces, but
while looking at the index computation in bcm_sysport_unmap_queues(): this
function has no equivalent of the guard that bcm_sysport_map_queues()
starts with:

	if (dp->ds->index)
		return 0;

Every DSA user netdev becomes an upper of the conduit regardless of its
switch index, in dsa_user_create():

	ret = netdev_upper_dev_link(conduit, user_dev, NULL);

and it is unlinked on destroy and on a conduit change via
dsa_user_change_conduit():

	netdev_upper_dev_unlink(old_conduit, dev);

bcm_sysport_netdevice_event() forwards every non-linking CHANGEUPPER of a
DSA user device to bcm_sysport_unmap_queues(). So for a user port of a
cascaded switch, where map_queues() never created a mapping, unmap_queues()
still runs with port = dp->index and num_tx_queues taken from that foreign
netdev, and matches rings with:

		if (ring->switch_port != port)
			continue;
		if (!ring->inspect)
			continue;

Those are exactly the rings mapped for the directly attached switch's port
of the same index. Can this clear inspect for a still-live port, and, when
the cascaded switch advertises a different queue count than switch 0,
write NULL into a ring_map slot that belongs to a different (port, queue)
while the de-inspected ring's own slot stays populated? The new bounds
check would not catch this since the index is in range, just computed from
the wrong stride.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921231305.394773-1-florian.fainelli%40broadcom.com
