Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AA4BE450;
	Mon,  5 Oct 2026 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212687; cv=none; b=fTVHDWLDLwJFqgRPFik4ugYAt4//KUUau7bp6l1JiTIc3eZUQkIrrnK8Zpz+W5XZZiK7rQpCk0H9jHGtcxklrSVP1enQbS1xK6R/b2PHs1iWiRy6lD+kmdYLj4rIq9Eba7xXqveXEzPS9epqNZoF3rdxmGR0hFnQ+n7ofA9qdlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212687; c=relaxed/simple;
	bh=PLurzGJ856+tzzLFxw7ksP1Uhf6yEBEaZIf+fRsTQAc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwdl6SH8yQRfwQV3gEg4u/ERONjPw0SEWrNfnTk8+NzWbOHGjPaLE4f3nktHSxm8B7hOmWawMhMtfd7C9kAYzqY9YqsmB/Bq7UT2RIlNKVPpU4wVgnBMdlnh1eupZzmZsMTe83wYIxDSZjtRtkZuezjcRQyKFJwo+fvgQ3FFIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Juhs2iGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Juhs2iGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5271F0089D;
	Mon,  5 Oct 2026 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212686;
	bh=5iJzK/c2ba4QpbBfb8WoQ6PmSE5y8tCldZXwxjMFDs8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Juhs2iGdb2Phqpdo3izkoe9jLXQwOop4ZBcxOHL1jrq1gQNFRWR9cVf4EZKSML1nP
	 3+qntVbTbHykqJ6V78EJcpNuo0g2HytA4wXRhBrvykne32+Hd9so8XKnLt4GPIOLjA
	 h3yIbRUUSIfOGNjAWuNzPsAq9XsCMTCvoBzHJ6yFYbzplVIk0gHs/48OYDhqjxC9KY
	 hWg2dofmn7yHvG7irBj2Yd4bFIx8CrcDBaxZ6e7iqF8WT06YEV6ljImQxeTN8Yym52
	 2J3xxCshdE+ISwbR87OpPWqTn4IbEC5QEwiHdOIdQJ0sm7AACLzAo74B4mcw0c+T1M
	 8dMgfSXn1QL1Q==
Subject: Re: [PATCH net-next 5/7] net: bcmgenet: allow the MTU to be changed
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Mon, 05 Oct 2026 15:04:44 +0000
Message-ID: <179121268489.434549.3171767518374343100@kernel.org>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-5-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-5-96dc6d54cbee@tipi-net.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In this patch, a single RX descriptor is sized for
  GENET_RBUF_ALIGN + MTU + ETH_HLEN + VLAN_HLEN; this applies to…
- [Medium] bcmgenet_change_mtu() leaves the PHY state machine running but
  reuses bcmgenet_netif_stop(dev, false).
- [Low] The commit message does not describe all of the behaviour this
  patch changes.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the new
  datapath_up flag does not cover it.

--

net: bcmgenet: allow the MTU to be changed

This commit sets dev->max_mtu to the largest MTU that fits in one RX
descriptor and adds an ndo_change_mtu handler. On a running interface the
handler resizes the rings and rewrites the MTU registers while leaving the
PHY up. If the allocation fails, it retries at the old size and closes the
interface when that also fails.

Link: https://github.com/raspberrypi/linux/issues/5561

> The driver never sets dev->max_mtu, so the MTU is stuck at ETH_DATA_LEN.

[Severity: Low]
Is this accurate? ether_setup() leaves min_mtu at 68. Before this patch
there was no ndo_change_mtu, so userspace could already lower the MTU.
That changed only dev->mtu and never touched the hardware.

With this patch, lowering the MTU has effects the commit message does not
mention.

bcmgenet_set_mtu_regs() now writes ENET_MAX_FRAME_LEN(mtu) to
UMAC_MAX_FRAME_LEN. The MAC receive limit therefore drops below the old
fixed 1536 bytes, for example to 1436 for an MTU of 1400. This also
happens on v1, because the write comes before the GENET_IS_V1() return.

On a running interface, bcmgenet_change_mtu() always runs the full
netif_device_detach() -> bcmgenet_netif_stop() -> bcmgenet_init_dma() ->
bcmgenet_netif_start() sequence. It does this even when
bcmgenet_rx_buf_len() returns the same size. That is the case for every
MTU up to about 2028, because bcmgenet_pkt_rdy_thld() clamps to
ENET_THLD_DEFAULT.

So a plain decrease interrupts traffic. It can also end in netif_close()
if both init_dma attempts fail.

GENET v1 gets the same ndo_change_mtu and the same rebuild on a decrease.
The new probe comment "v1 cannot program the thresholds, so it stays at
the default MTU" only holds for the maximum.

Could the commit message and the probe comment describe this? Could the
rebuild be skipped when rx_buf_len does not change?

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index bf889558f6ade..4634b6521ab8e 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -77,6 +77,12 @@
>  				      ENET_THLD_MAX * ENET_THLD_UNIT, \
>  				      ENET_THLD_PAGE_LEN)
>  
> +/* Largest MTU that fits one descriptor, with room for a VLAN tag so a VLAN
> + * interface can use the parent MTU.
> + */
> +#define ENET_MAX_MTU		(ENET_THLD_MAX_LEN - GENET_RBUF_ALIGN - \
> +				 ETH_HLEN - VLAN_HLEN)

[Severity: Medium]
Does one descriptor really hold the largest frame the MAC accepts at this
MTU?

bcmgenet_pkt_rdy_thld() and bcmgenet_rx_buf_len() size a descriptor for
GENET_RBUF_ALIGN + mtu + ETH_HLEN + VLAN_HLEN. However,
bcmgenet_set_mtu_regs() programs UMAC_MAX_FRAME_LEN to
mtu + ENET_FRAME_OVERHEAD (mtu + 36). That also counts the FCS, the
Broadcom tag and the padding.

With 4K pages, ENET_MAX_MTU is 3564 and the threshold is exactly 3584, so
there is no slack. Two kinds of frame are accepted by the MAC but end up
spanning two descriptors:

- a QinQ frame at full MTU (2 + 3564 + 22 = 3588 bytes)
- a VLAN tagged frame with a forwarded FCS (crc_fwd_en)

bcmgenet_desc_rx() then drops them:

	if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
		netif_err(priv, rx_status, dev,
			  "dropping fragmented packet!\n");

The same happens just below each 256 byte threshold step, for example at
MTU 2025-2028.

Later in the series, "net: bcmgenet: reassemble jumbo frames from status
block fragments" seems to fix this. It removes ENET_MAX_MTU, uses
ENET_MAX_JUMBO_MTU and reassembles frames that span several descriptors.

As of this patch, though, are these frames silently dropped and counted
as fragmented_errors?

> +
>  /* Tx/Rx DMA register offset, skip 256 descriptors */
>  #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
>  #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))

[ ... ]

> @@ -3549,7 +3556,11 @@ static int bcmgenet_close(struct net_device *dev)
>  
>  	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
>  
> -	bcmgenet_netif_stop(dev, false);
> +	/* A failed MTU change can have torn the datapath down already */
> +	if (priv->datapath_up) {
> +		bcmgenet_netif_stop(dev, false);
> +		priv->datapath_up = false;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but the new flag doesn't cover
it. datapath_up is only updated in open, close and change_mtu. The
suspend and resume paths never touch it.

A non-WoL bcmgenet_suspend() calls bcmgenet_netif_stop(dev, true). That
disables every TX and RX NAPI and then runs bcmgenet_fini_dma(), which
calls netif_napi_del() and frees priv->rx_cbs and priv->tx_cbs without
setting them to NULL. datapath_up stays set.

The WoL branch of resume that finds the MAC was reset also calls
bcmgenet_fini_dma() directly.

bcmgenet_resume() can then fail in bcmgenet_init_dma(), from a DMA halt
timeout or an allocation failure:

	ret = bcmgenet_init_dma(priv, false);
	if (ret) {
		netdev_err(dev, "failed to initialize DMA\n");
		goto out_clk_disable;
	}

In that case it returns with the clock off, netif_running() still true
and datapath_up still set.

A later bcmgenet_close() takes the new branch and stops the datapath a
second time:

bcmgenet_close()
  bcmgenet_netif_stop()
    bcmgenet_disable_tx_napi()
      napi_disable()
        napi_disable_locked()
          while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC))
                  usleep_range(20, 200);

Can this loop forever while holding RTNL and the netdev instance lock? If
it ever got past the loop, bcmgenet_fini_dma() would free the stale
rx_cbs and tx_cbs a second time.

With this patch, bcmgenet_change_mtu() on such a device reaches the same
loop through its own bcmgenet_netif_stop() call.

Should suspend and the resume error paths also keep datapath_up up to
date?

>  
>  	/* Really kill the PHY state machine and disconnect from it */
>  	phy_disconnect(dev->phydev);

[ ... ]

> @@ -3797,6 +3808,66 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
>  	return 0;
>  }
>  
> +static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
> +{
> +	struct bcmgenet_priv *priv = netdev_priv(dev);
> +	unsigned int old_mtu = dev->mtu;
> +	int ret;
> +
> +	if (!netif_running(dev)) {
> +		WRITE_ONCE(dev->mtu, new_mtu);
> +		priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
> +		return 0;
> +	}
> +
> +	/* The watchdog trips on an idle queue once the rings are gone */
> +	netif_device_detach(dev);
> +
> +	/* Only the buffers and the MTU registers change, leave the PHY up */
> +	bcmgenet_netif_stop(dev, false);

[Severity: Medium]
The commit message says "The PHY keeps running and the link stays up".
Can a link event be lost here, though?

bcmgenet_netif_stop() calls bcmgenet_intr_disable(), which does:

	bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_MASK_SET);
	bcmgenet_intrl2_0_writel(priv, 0xFFFFFFFF, INTRL2_CPU_CLEAR);

It then calls cancel_work_sync(&priv->bcmgenet_irq_work).

A UMAC_IRQ_LINK_EVENT or UMAC_IRQ_PHY_DET_R that has latched but not been
handled can be lost in two ways:

- the CLEAR wipes it before bcmgenet_isr0() reads it
- bcmgenet_isr0() has already saved it in priv->irq0_stat, but the work
  is cancelled before bcmgenet_irq_task() runs

For internal PHYs on GENET v1-v4, bcmgenet_mii_probe() does:

	dev->phydev->irq = PHY_MAC_INTERRUPT;

So phylib never polls. The only notification path is
bcmgenet_irq_task() -> phy_mac_interrupt().

Nothing on the restart path re-triggers the PHY state machine. That path
is bcmgenet_netif_start(dev, false) plus re-enabling MDIO_EVENT.

Would phylib's link state and the carrier then stay stale until the next
link event? One example is carrier still up after the cable is pulled.

A lost PHY_DET_R on v1-v3 with forced speed would also skip the
phy_init_hw() and genphy_config_aneg() calls in bcmgenet_irq_task().

Before this patch, bcmgenet_netif_stop() was only used when the PHY was
also being stopped or disconnected. Is a phy_mac_interrupt() or
phy_trigger_machine() call needed after the restart?

> +	priv->datapath_up = false;
> +
> +	WRITE_ONCE(dev->mtu, new_mtu);
> +	priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
> +	bcmgenet_set_mtu_regs(priv, new_mtu);
> +
> +	ret = bcmgenet_init_dma(priv, true);

[ ... ]

> +	bcmgenet_hfb_restore(priv);
> +	bcmgenet_netif_start(dev, false);
> +
> +	/* bcmgenet_netif_start() only restores the link interrupt */
> +	if (bcmgenet_has_mdio_intr(priv))
> +		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_MDIO_EVENT,
> +					 INTRL2_CPU_MASK_CLEAR);
> +
> +	priv->datapath_up = true;
> +	netif_device_attach(dev);
> +
> +	return ret;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee%40tipi-net.de
