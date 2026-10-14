Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D3049F137;
	Wed, 14 Oct 2026 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987778; cv=none; b=YSpYPVlfuD+cWp6q7wLCByRmwxEv/okISCU9wt/jiHjiNou/xKvdP5e7RlFfw0bF1gK79ewfanPzULNQxfYXpC1fZP+XMxXueQ5zobsT3gk6btqvP8b8R515ysX8Q/Gd+KiYAFF+2w7DErrEqCcAFGIcpYxYsMQgYik5tMTYdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987778; c=relaxed/simple;
	bh=cBMcxPcfMC0yqT7auhEUlVfOw7L490mg7SrJDO7DaQY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2ixgcYQFSsw4PQB/sJ4Zx94N2DNd1F0f3DsH+kNsRxAcemR8K7uXFZFPI9li25qmUEej9KmC+tJ4U5ph8VzEgDLq88dXZYhIVniXzIjYjxO1FXexUoSIQ+7US85Kr/bYJl+ilx3sSCmJhtiKbt9mCX8+NxZ+96oNLl94o9mhXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWS+qOIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWS+qOIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4367B1F000C4;
	Wed, 14 Oct 2026 14:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791987777;
	bh=xTWoR9EguxSMrT484mKSNJsjQXjVEoWzztq/aJmEPiQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NWS+qOIGZ5DVA5hfW6cKi8IuqN7xYpNtBrT+HUrgZl1I2cebkRSWXV2hR3UcRx+i9
	 aSRy1YQJidcHqe/XEoPCt+hoew70H7slORlQENUaChpftCKONGhiC5t7jYWhMfER22
	 fmZSXZkzuVZcgYLGsFuTo3W8boNAUrkXvl9qZcRduEKwU7S71eRoKOA+xaecI+J/63
	 h7vnmNPQmI6wkssiuXhvFWxLjTUQkQjH1i/n1QpG3Mv6w1Uq5LmGT8H6OyYYN99beg
	 VDQDW1Pc71yN2oCXPZCf6sKTK8XaGlyV3Rh6JHUpcX1jkW2lJzSqkCI8YzphUGoJwZ
	 iAz/sBN8w/a0g==
Subject: Re: [PATCH net-next v5 6/8] net: bcmgenet: pad transmit frames out of
 the packet ready window
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com, f.fainelli@gmail.com
Date: Wed, 14 Oct 2026 14:22:55 +0000
Message-ID: <179198777582.434549.9712346725032064776@kernel.org>
In-Reply-To: <20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
References: <20261013-nb-genet-mtu-nn-v2-v5-6-076b6fc240be@tipi-net.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says "Nothing reaches either path until a
  later patch raises dev->max_mtu" and "Nothing below an MTU of 3809 is…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  bcmgenet_timeout()…

--

net: bcmgenet: pad transmit frames out of the packet ready window

The patch programs the transmit packet ready threshold from the MTU. In
bcmgenet_xmit() it pads frames that end just past the threshold out to 64
bytes beyond it, which avoids a Tx stall. Frames longer than the threshold
with CHECKSUM_PARTIAL get their checksum computed in software, and the skb
is unshared before either path writes to it.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 9b9ce33f081ad..e00661b2414b9 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c

[ ... ]

> @@ -2176,6 +2181,42 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
>  		goto out;
>  	}
>  
> +	/* Both paths below write to the frame, which ether_setup() lets the
> +	 * stack share. Match their conditions so nothing else is copied.
> +	 */
> +	if (unlikely(skb->len > priv->tx_thld_len &&
> +		     (skb->ip_summed == CHECKSUM_PARTIAL ||
> +		      skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN))) {
> +		skb = skb_share_check(skb, GFP_ATOMIC);
> +		if (!skb) {
> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			goto drop;
> +		}
> +	}

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The new
dropped increments here run under ring->lock, but bcmgenet_timeout()
updates the same syncp after the lock has been dropped:

drivers/net/ethernet/broadcom/genet/bcmgenet.c:bcmgenet_timeout() {
    ...
	bcmgenet_tx_reclaim(dev, ring, true);

	/* Re-enable the TX interrupt for this ring */
	bcmgenet_intrl2_1_writel(priv, 1 << txqueue, INTRL2_CPU_MASK_CLEAR);

	txq_trans_cond_update(txq);

	BCMGENET_STATS64_INC((&ring->stats64), errors);
    ...
}

bcmgenet_tx_reclaim() takes ring->lock and releases it before returning,
and the TX interrupt has just been unmasked. TX NAPI writes the same syncp
under ring->lock:

bcmgenet_tx_poll()
    spin_lock(&ring->lock);
    __bcmgenet_tx_reclaim()
        u64_stats_update_begin(&stats->syncp);
        u64_stats_add(&stats->packets, pkts_compl);
        u64_stats_add(&stats->bytes, bytes_compl);
        u64_stats_update_end(&stats->syncp);

dev_watchdog() freezes the tx queues, but it doesn't stop TX NAPI.

On 32-bit SMP kernels, such as on BCM2711 or arm32 BCM7xxx, can these two
writers overlap on ring->stats64.syncp? Readers in bcmgenet_get_stats64()
and ethtool -S could then see torn counters. A lost sequence increment
would also leave the seqcount odd, and readers would spin.

Would moving the errors increment in bcmgenet_timeout() under ring->lock
avoid this?

[ ... ]

> +	/* Keep the frame out of the window just past the threshold */
> +	if (unlikely(skb->len > priv->tx_thld_len &&
> +		     skb->len < priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {
> +		if (skb_put_padto(skb, priv->tx_thld_len + ENET_TX_SAFE_MARGIN)) {

[Severity: Low]
The commit message says:

  Nothing reaches either path until a later patch raises dev->max_mtu.

and:

  Nothing below an MTU of 3809 is affected, since no frame reaches the
  window there.

Do these claims hold for frames longer than the MTU? This check only looks
at skb->len. bcmgenet_tx_pkt_rdy_thld() assumes no frame is longer than
ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN, which is mtu + 32:

	while (thld > ENET_THLD_DEFAULT &&
	       ENET_MAX_FRAME_LEN(mtu) - ETH_FCS_LEN > thld * ENET_THLD_UNIT &&
	       thld * ENET_THLD_UNIT + ENET_TX_SAFE_MARGIN > mtu + ETH_HLEN)
		thld -= ENET_THLD_BURST / ENET_THLD_UNIT;

A longer frame seems able to get here in two ways. First, packet_snd()
skips the MTU check when a vnet header gso_type is supplied:

net/packet/af_packet.c:packet_snd() {
    ...
	if (!vnet_hdr.gso_type && (len > dev->mtu + reserve + extra_len) &&
	    !packet_extra_vlan_len_allowed(dev, skb)) {
    ...
}

__virtio_net_hdr_to_skb() doesn't bound gso_size by the MTU. It also
leaves a frame no longer than gso_size as a plain non-GSO skb. So a
CAP_NET_RAW user could send a 2049 to 2111 byte frame at MTU 1500.

Second, five or more software VLAN tags exceed mtu + 32. At MTU 3808 that
gives a 3842 byte frame, which lands in the 3840 to 3904 window.

skb_put_padto() now appends zeros to these frames. If a DSA tail tag
(e.g. KSZ) or a PRP RCT was already appended, will the receiver read the
zeros in place of the trailer?

A tail-tag switch might treat an all-zero tag as a normal address lookup
rather than the port the host selected. That depends on the switch
accepting the oversized frame at all.

These frames are already over the MTU, and before this patch they would
have stalled the transmitter instead. Should the commit message and the
comment above bcmgenet_tx_pkt_rdy_thld() be changed so they don't claim
that nothing can reach the window?

> +			BCMGENET_STATS64_INC((&ring->stats64), dropped);
> +			goto drop;
> +		}
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-nb-genet-mtu-nn-v2-v5-0-076b6fc240be%40tipi-net.de
