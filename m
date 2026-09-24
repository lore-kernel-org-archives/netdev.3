Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3993D3CF7;
	Thu, 24 Sep 2026 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216490; cv=none; b=h6GnxeWw78Y17iDYCccRJJm0IjDSaVmv53LUs8exn3qCCxO5ETEXt4GZCO9NTzTCdjn/59+YG8UJscuz/+XzDKLy/ieexBOfAtZJuqcJk6Z7BaE3QTrNa13USO27Fftqw05Uar2XDn4TSuC3+G6f4918iX6/uNeXGwbZffEQFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216490; c=relaxed/simple;
	bh=e0rsG9i8VA3IfqoaL05aWFVg0odDOvx5u9ZB3tmafew=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B6sPP67Qd2b9wD8GtJrvDnTHkk+HlmEi1Rv0PKecKYzx8IW8FUq5ICV8w+IP2lDrg0Cghupv0tjv8wKCWvPSFF4AxOOHW8s3F8RvaZEuGpw7zn5EAleKhU5f/9TIOlX1tM5ioaDfNXxtdgQgqL2A5xpieOP0NQVnKYu5iomI1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxBia6D3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxBia6D3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B013F1F0089A;
	Thu, 24 Sep 2026 02:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216488;
	bh=pCyJ6J/5ty7fdTWxXuEwBtsodo+oj6JXLOjkXiQ0b+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oxBia6D3DCQM1Jq9SoxJCFSYqxiAH/+He6VdkayjjTI+I2LsChz5K140xZzof2gah
	 HBe2293s2zGVTiSURGVRXD5irEQ1PNqlCJG+BwUpkj2zOmILl5geu8gdMY9bW42Udc
	 38C2ZOfaE0AygViq6PFe/wtfJ5ClZfTFhxWC73T+s1amjUN5c5EOiMjgeS25QTWC0o
	 CTUFqQV626Jzi8kIXJ2qlhi2wgMyB/G5VlS3gkAgZfK0uPWD92y5O2Gmk+Whv6firr
	 qJfaHoGfflSZJd7L1MVP7lT3W/FS+YD4TYMobNUCWZp4K9ri1V8eLtrG5eYNR6sC0O
	 LodUS9MoQ90ag==
Subject: Re: [PATCH net v2 07/10] net: systemport: Fix out-of-bounds array
 accesses in DSA queue mapping
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, nb@tipi-net.de, opendmb@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zakkemble@gmail.com, horms@kernel.org, ryotkkr98@gmail.com,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:21:27 +0000
Message-ID: <179021648730.2160803.337599002792886677@kernel.org>
In-Reply-To: <20260922232440.598918-8-florian.fainelli@broadcom.com>
References: <20260922232440.598918-8-florian.fainelli@broadcom.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In bcm_sysport_map_queues()
  (drivers/net/ethernet/broadcom/bcmsysport.c), the new bounds check…
- [Low] The commit message understates the trigger.

Pre-existing issues:
- [Low] bcm_sysport_select_queue() runs in the TX datapath without RTNL.

--

net: systemport: Fix out-of-bounds array accesses in DSA queue mapping

This patch adds bounds checks against ARRAY_SIZE(priv->ring_map) in
bcm_sysport_select_queue(), bcm_sysport_map_queues() and
bcm_sysport_unmap_queues(). It also clamps the argument that SYSTEMPORT
Lite passes to netif_set_real_num_tx_queues() so it is never below 1.

> The priv->ring_map array has a fixed size of (DSA_MAX_PORTS * 8). In
> bcm_sysport_select_queue(), bcm_sysport_map_queues(), and
> bcm_sysport_unmap_queues(), indices calculated as
> (qp + port * num_tx_queues) were accessed without checking against
> ARRAY_SIZE(priv->ring_map). If unusual port or queue configurations are
> encountered, this could lead to out-of-bounds array accesses.

[Severity: Low]

Is "unusual port or queue configurations" the right trigger to describe
here?

With the in-tree switch drivers, ds->num_tx_queues is at most 8 and
bcm_sf2 user ports are below 9. So the map/unmap index stays under 96.

The read in bcm_sysport_select_queue() looks reachable with ordinary
traffic, though. It decodes queue_mapping for every skb once
netdev_uses_dsa(dev) is true. But only brcm_tag_xmit_ll() in
net/dsa/tag_brcm.c writes the port/queue encoding:

    skb_set_queue_mapping(skb, BRCM_TAG_SET_PORT_QUEUE(dp->index, queue));

Other skbs sent on the conduit carry unrelated values. Two examples:

  - forwarded skbs that still have the ingress queue from
    skb_record_rx_queue() (rxq + 1), e.g. from multiqueue tun/veth or
    NICs with many RX queues
  - tc-BPF writes to __sk_buff->queue_mapping

If the low byte of queue_mapping is 96 or more, the lookup reads past the
end of ring_map[], which is the last member of priv. The loaded value is
then dereferenced as tx_ring->index.

The code change covers this case. Could the commit message say that
ordinary traffic can hit it, so stable backporters can judge the urgency?

> diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
> index ed4337af58da1..4efcefd33b781 100644
> --- a/drivers/net/ethernet/broadcom/bcmsysport.c
> +++ b/drivers/net/ethernet/broadcom/bcmsysport.c

[ ... ]

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

[Severity: Low]

This is a pre-existing issue and was not introduced by this patch.
bcm_sysport_select_queue() runs in the TX path without RTNL. It reads
priv->per_port_num_tx_queues and priv->ring_map[index] with plain loads.

At the same time, bcm_sysport_map_queues() and bcm_sysport_unmap_queues()
write those fields with plain stores. They run from the NETDEV_CHANGEUPPER
notifier and hold only RTNL. For example, dsa_user_destroy() unlinks
without first draining in-flight transmits:

    netif_carrier_off(user_dev);
    rtnl_lock();
    netdev_upper_dev_unlink(conduit, user_dev);

The new index >= ARRAY_SIZE() check and the existing !tx_ring check both
assume each value is read only once. Without READ_ONCE()/WRITE_ONCE(), can
the compiler reload per_port_num_tx_queues or ring_map[index] after the
check?

Would a follow-up be worthwhile that adds READ_ONCE() in
bcm_sysport_select_queue() and WRITE_ONCE() in the map/unmap paths?

[ ... ]

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

When qp + port * num_tx_queues is out of range, does this leave the ring
half claimed? By this point ring->switch_queue, ring->switch_port and
ring->inspect are already set, and qp++ still runs. Only the ring_map[]
store is skipped.

The index goes out of range when num_tx_queues is above 8, or when the
port index is 12 or more with 8 queues.

On every open, bcm_sysport_init_tx_ring() programs the hardware from
those fields:

	if (ring->inspect) {
		reg |= ring->switch_queue & RING_QID_MASK;
		reg |= ring->switch_port << RING_PORT_ID_SHIFT;
	} else {
		reg |= RING_IGNORE_STATUS;
	}

So the switch port/queue still flow-controls the ring. The later commit
"net: systemport: Update TDMA queue mapping dynamically on changeupper"
also has bcm_sysport_map_queues() program this right away, with
RING_IGNORE_STATUS cleared.

However, no ring_map[] entry points at the ring. For that (port, queue),
bcm_sysport_select_queue() hits the new bounds check and falls back to
netdev_pick_tx(). That can hash onto any ring, including rings that
inspect other ports/queues.

Could this bring back the flow-control cross-talk and head-of-line
blocking that ring_map[] exists to prevent?

While the port stays linked, later bcm_sysport_map_queues() calls for
other ports also skip the claimed ring because of this check:

		if (ring->inspect)
			continue;

Would it be better to check the index before claiming the ring, and then
skip or reject the mapping?

The commit message also doesn't mention this half-claimed state. It is
still present at the end of the series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922232440.598918-1-florian.fainelli%40broadcom.com
