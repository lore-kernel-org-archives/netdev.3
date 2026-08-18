Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317745FFAC
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061460; cv=none; b=N2dP/xiV2uMUZuJOR8HU7SZx3Fq4ONOt0gPgMFHMfcWMtZfYrEB5q+iGCkXjmNQQHrUyH01E/OFZiQ3nQZiQqRxbMF+HfZFBo7+OdEsPZMpSQJLqL8V+JRIWIhJZ19wadDyalhvxR20rskpfCMeLLuT1h6UJCP+DMp2pmngeOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061460; c=relaxed/simple;
	bh=1mYmRC0YO4VEeuzc8H3cP95ghdsLHF1Tfk2R3lM4qdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0S6v9DJnUvSGsNw8mtyG5lbP/rLDpamQdGTIEBoR/9r/ZNukTzpEBvZEbAMeE/kRA7gf1NUKflEt/aBrFl5GNrEODmzsJDt5+5LfpP2LaSUEnuJH2Zocy5JxwrxyRuoAGd8HSoLdibdB3Sk+vIXMooRbt+WOPvzfyLSmDWkvkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aynD7ZoO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aynD7ZoO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787061457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xlua/OaPb0XebRUXOGf2fxKnuqFEfd/jZ8x0ehhkoI4=;
	b=aynD7ZoOZob1dRK9i9fBKZC/9aWIQNxpjgI/JyeCC4Kr5aLmw66Eu+YaQaQmxZYHcAUt1k
	SxXZTYCZRmCilqxIEznjfrbqQQgzQ6inhJi5am+y8xRhDYmwKC4gErfo2XPN/+R+rBR6V+
	zNugrwHzUF0oRyFmuRpuhGOP4vBSBbk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-9qdM49W3P-Cp7HKhn_jpSA-1; Tue,
 18 Aug 2026 09:57:32 -0400
X-MC-Unique: 9qdM49W3P-Cp7HKhn_jpSA-1
X-Mimecast-MFC-AGG-ID: 9qdM49W3P-Cp7HKhn_jpSA_1787061450
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B86A51955F1B;
	Tue, 18 Aug 2026 13:57:29 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 88DBB422;
	Tue, 18 Aug 2026 13:57:24 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: dev.taqnialabs@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux@armlinux.org.uk,
	qingfang.deng@linux.dev,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] net: stmmac: xgmac: tear the datapath down in the documented order
Date: Tue, 18 Aug 2026 15:57:19 +0200
Message-ID: <20260818135719.212831-1-pabeni@redhat.com>
In-Reply-To: <20260814-stmmac-rx-fifo-block-v4-2-1951fd3d33b7@gmail.com>
References: <20260814-stmmac-rx-fifo-block-v4-2-1951fd3d33b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: xgmac: tear the datapath down in the documented order

This adds four optional stmmac_dma_ops callbacks (tx_dma_stopped,
tx_mtl_drain, rx_mtl_drain, rx_dma_stopped), implements them for XGMAC, and
drives them from a new stmmac_datapath_teardown() used by __stmmac_release(),
stmmac_xdp_release() and the non-WoL branch of stmmac_suspend().  It also
clears the latched TPS/RPS status bits in the Tx/Rx DMA start ops and moves
phylink_stop() after the teardown in __stmmac_release().

A few questions below.

>     The driver stops all DMA channels at once and only some paths disable
>     the MAC afterwards. The databook requires the reverse order with a wait
>     at each stage, otherwise a frame can be left stranded in the MTL FIFOs
>     and reappear as corruption on the next bring-up.

[Severity: Low]
The changelog describes a user-visible failure ("reappear as corruption on
the next bring-up") but the patch carries no Fixes: tag and no statement
about stable backporting, while also adding new hwif callbacks and
reordering phylink_stop().

Is this meant as a fix for stable trees, and if so which commit does it fix?
If it is hardening for a hardware ordering requirement rather than a
regression fix, could the changelog say so explicitly?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index ff83858ebc1f3..df366b2e6bd72 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c

[ ... ]

> @@ -592,6 +599,77 @@ static int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
>  	return 0;
>  }
>  
> +static int dwxgmac2_tx_mtl_drain(struct stmmac_priv *priv,
> +				 void __iomem *ioaddr, u32 queue)
> +{
> +	u32 value;
> +	int ret;
> +
> +	/* Wait until the queue is empty and its read controller is no longer
> +	 * pulling a frame out towards the MAC.
> +	 */
> +	ret = readl_poll_timeout(ioaddr + XGMAC_MTL_TXQ_DEBUG(queue), value,
> +				 !(value & XGMAC_TXQSTS) &&
> +				 FIELD_GET(XGMAC_TRCSTS, value) !=
> +				 XGMAC_TRCSTS_READ,
> +				 100, 10000);
> +	if (ret)
> +		netdev_warn(priv->dev, "MTL Tx queue %u drain timeout\n",
> +			    queue);
> +
> +	return ret;
> +}
> +
> +static int dwxgmac2_rx_mtl_drain(struct stmmac_priv *priv,
> +				 void __iomem *ioaddr, u32 queue)
> +{
> +	u32 value;
> +	int ret;
> +
> +	/* Wait until no packet is left in the queue and the queue reports
> +	 * itself empty.
> +	 */
> +	ret = readl_poll_timeout(ioaddr + XGMAC_MTL_RXQ_DEBUG(queue), value,
> +				 !FIELD_GET(XGMAC_PRXQ, value) &&
> +				 !FIELD_GET(XGMAC_RXQSTS, value),
> +				 100, 10000);
> +	if (ret)
> +		netdev_warn(priv->dev, "MTL Rx queue %u drain timeout\n",
> +			    queue);
> +
> +	return ret;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b9d5d4aabf423..9c3a8f122b94f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -2560,6 +2560,52 @@ static void stmmac_stop_all_dma(struct stmmac_priv *priv)
>  		stmmac_deinit_chan(priv, priv->ioaddr, chan);
>  }
>  
> +/**
> + * stmmac_datapath_teardown - ordered datapath teardown as per IP specification
> + * @priv: driver private structure
> + * Description:
> + * When teardown ops are available, follow the databook ordered teardown
> + * sequence.
> + * Follows the legacy stop + MAC disable for variants without the feature.
> + */
> +static void stmmac_datapath_teardown(struct stmmac_priv *priv)
> +{
> +	u32 rx_channels_count = priv->plat->rx_queues_to_use;
> +	u32 tx_channels_count = priv->plat->tx_queues_to_use;
> +	u32 chan;
> +
> +	/* Stop all TX DMA channels */
> +	for (chan = 0; chan < tx_channels_count; chan++)
> +		stmmac_stop_tx_dma(priv, chan);

[Severity: Low]
This isn't a bug in the final tree, but at this commit stage 1 dispatches to
dwxgmac2_dma_stop_tx(), which still clears the global MAC transmit enable:

  dwxgmac2_dma_stop_tx()
      value = readl(ioaddr + XGMAC_TX_CONFIG);
      value &= ~XGMAC_CONFIG_TE;
      writel(value, ioaddr + XGMAC_TX_CONFIG);

Stage 2 then waits for MTL_TXQ_DEBUG.TXQSTS to clear, which the new helper's
own comment says depends on the read controller still pulling frames towards
the MAC, and the changelog says "stages 2 and 4 cannot progress once the MAC
is disabled".

Does this commit on its own make every XGMAC close/suspend/XDP reconfigure
burn the full 10 ms poll plus one "MTL Tx queue %u drain timeout" per Tx
queue?  The later patch "net: stmmac: xgmac: decouple the MAC Rx/Tx enables
from the DMA ops" removes the XGMAC_CONFIG_TE clear from
dwxgmac2_dma_stop_tx(), so this is only a bisect hazard within the series -
could the ordering of the two patches be swapped?

> +
> +	/* Wait for every TX DMA channel to report itself stopped */
> +	if (priv->hw->dma->tx_dma_stopped)
> +		for (chan = 0; chan < tx_channels_count; chan++)
> +			stmmac_tx_dma_stopped(priv, priv->ioaddr, chan);

[Severity: Medium]
This isn't a problem introduced by this patch - the old stmmac_stop_all_dma()
path did not wait for the hardware at all - but now that the new ops do
return a status, is it worth acting on it?

All four calls here discard the return value, so a -ETIMEDOUT only produces
a netdev_warn() and the sequence continues:

  - a Tx MTL drain timeout is followed by disabling the MAC
  - an Rx MTL drain timeout is followed by stopping the Rx DMA, leaving the
    frame the wait was supposed to drain
  - an unconfirmed Tx/Rx DMA stop is followed by free_dma_desc_resources()
    in __stmmac_release() and stmmac_xdp_release(), or by the SerDes and pin
    power-down and a success return in stmmac_suspend()

If a channel really did not stop, can it still fetch descriptors or write
packet data and completion status into memory that has already been unmapped
or freed?  Should a timeout trigger a DMA software reset, or at least
propagate out of the suspend path?

> +
> +	/* Wait for the MTL TX queues to finish pushing into the MAC */
> +	if (priv->hw->dma->tx_mtl_drain)
> +		for (chan = 0; chan < tx_channels_count; chan++)
> +			stmmac_tx_mtl_drain(priv, priv->ioaddr, chan);
> +
> +	/* Disable the MAC TX and RX */
> +	stmmac_mac_set(priv, priv->ioaddr, false);

[Severity: Medium]
Stage 2 needs MAC TE still set so the MTL Tx FIFO can push into the MAC, but
the MAC transmitter is cleared on every carrier-down event, not only by the
phylink_stop() call this patch reordered:

  stmmac_mac_link_down()
      stmmac_mac_set(priv, priv->ioaddr, false);

So on ifdown or suspend while the link is already down - cable unplugged,
autoneg incomplete, link dropped while a frame was in flight, which is
exactly when a frame is most likely to sit in the MTL Tx FIFO - TE is
already clear.

Does dwxgmac2_tx_mtl_drain() then poll for the full 10000 us per Tx queue,
warn, and return -ETIMEDOUT while the stranded frame stays where it was?
Would it make sense to check the carrier state or read back MAC_CONFIG
TE/RE before entering stage 2, and to fall back to the MTL flush-Tx-queue
path when the MAC transmitter is off?

> +
> +	/* Wait for the MTL RX queues to drain into the RX DMA */
> +	if (priv->hw->dma->rx_mtl_drain)
> +		for (chan = 0; chan < rx_channels_count; chan++)
> +			stmmac_rx_mtl_drain(priv, priv->ioaddr, chan);

[Severity: Medium]
Stage 4 waits for the Rx DMA to move frames out of the MTL Rx FIFO, but all
three callers have already stopped NAPI before reaching here:

  __stmmac_release() / stmmac_xdp_release() / stmmac_suspend()
      stmmac_disable_all_queues()
          __stmmac_disable_all_queues()   /* napi_disable() */
      ...
      stmmac_datapath_teardown()

With no NAPI to recycle descriptors and inbound traffic still arriving, can
the Rx ring run out of free descriptors so that the Rx DMA suspends on
descriptor unavailability and stops draining the FIFO?  In that case
dwxgmac2_rx_mtl_drain() cannot see PRXQ == 0 && RXQSTS == 0 and spends the
full 10000 us per Rx queue plus a warning, and the frame stays in the MTL Rx
FIFO anyway.

Stages 1 and 2 can already sleep tx_queues_to_use * 10 ms before this point,
which widens the window for the ring to be exhausted.

> +
> +	/* Stop all RX DMA channels */
> +	for (chan = 0; chan < rx_channels_count; chan++)
> +		stmmac_stop_rx_dma(priv, chan);
> +
> +	/* Wait for every RX DMA channel to report itself stopped */
> +	if (priv->hw->dma->rx_dma_stopped)
> +		for (chan = 0; chan < rx_channels_count; chan++)
> +			stmmac_rx_dma_stopped(priv, priv->ioaddr, chan);
> +}

[Severity: High]
The new helper replaces stmmac_stop_all_dma() in __stmmac_release(),
stmmac_xdp_release() and the non-WoL branch of stmmac_suspend(), but it does
not end with the loop stmmac_stop_all_dma() finishes with:

  stmmac_stop_all_dma()
      ...
      for (chan = 0; chan < dma_csr_ch; chan++)
              stmmac_deinit_chan(priv, priv->ioaddr, chan);

deinit_chan is implemented only by dwmac4_dma_ops and dwmac410_dma_ops
(dwmac4_dma_deinit_channel() and dwmac410_dma_deinit_channel()), and its only
job is to clear DMA_CHAN_INTR_DEFAULT_MASK in DMA_CHAN_INTR_ENA, i.e. it is
the matching disable for the enables written by dwmac4_dma_init_channel().
That loop was added by commit 59a57128ae5231 ("net: stmmac: dwmac4: mask
interrupts when stopping DMA in suspend", Fixes: 1b9707e6f1a9) precisely
because suspend otherwise produces an RPS interrupt storm.

DWMAC4 and DWMAC4.10 provide none of the new ordered-teardown ops, so on
those parts the new helper is plain stop plus MAC disable with the masking
gone.  Nothing else covers it: dwmac4_disable_dma_irq() only touches RIE and
TIE, and stmmac_disable_all_queues() only does napi_disable().

Does routing the non-WoL suspend path through the new helper reintroduce the
storm that 59a57128ae5231 fixed, with the IRQ handler still registered?  And
since RPS/TPS clearing moved into the start ops, do those abnormal status
bits now stay asserted for the whole time the interface is down or suspended
while the corresponding enables remain set?

> @@ -4240,9 +4286,6 @@ static void __stmmac_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>  
> -	/* Stop and disconnect the PHY */
> -	phylink_stop(priv->phylink);
> -
>  	stmmac_disable_all_queues(priv);
>  
>  	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
> @@ -4253,8 +4296,11 @@ static void __stmmac_release(struct net_device *dev)
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>  
> -	/* Stop TX/RX DMA and clear the descriptors */
> -	stmmac_stop_all_dma(priv);
> +	/* Has to run before mac_link_down() disables the MAC. */
> +	stmmac_datapath_teardown(priv);
> +
> +	/* Stop and disconnect the PHY */
> +	phylink_stop(priv->phylink);

[Severity: Medium]
phylink_stop() is the only fence against the phylink resolve worker - it
calls phylink_run_resolve_and_disable(), which sets PHYLINK_DISABLE_STOPPED
and flushes the work.  Moving it after the teardown means the whole ordered
sequence now runs concurrently with that worker, which takes only
pl->phydev_mutex, phy->lock and pl->state_mutex and never RTNL:

  phylink_resolve()            /* system_power_efficient_wq, no RTNL */
      phylink_link_up()
          stmmac_mac_link_up()
              stmmac_mac_set(priv, priv->ioaddr, true);
  or
      phylink_link_down()
          stmmac_mac_link_down()
              stmmac_mac_set(priv, priv->ioaddr, false);

stmmac_datapath_teardown() holds neither priv->lock nor any lock shared with
those callbacks, and both sides do an unsynchronized read-modify-write of
MAC_CTRL_REG.

Can a link event arriving during ifdown set TE|RE again after stage 3, so
that the MAC keeps filling the MTL Rx FIFO after stage 4's drain wait and
after stage 5 has stopped the Rx DMA?  Conversely, if the worker clears
TE/RE just after stage 1, do stages 2 and 4 each burn the full 10 ms poll and
warn per queue?

> @@ -7104,15 +7150,12 @@ void stmmac_xdp_release(struct net_device *dev)
>  	/* Free the IRQ lines */
>  	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
>  
> -	/* Stop TX/RX DMA channels */
> -	stmmac_stop_all_dma(priv);
> +	/* Stop the MAC and the TX/RX DMA channels */
> +	stmmac_datapath_teardown(priv);
>  
>  	/* Release and free the Rx/Tx resources */
>  	free_dma_desc_resources(priv, &priv->dma_conf);
>  
> -	/* Disable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, false);
> -
>  	/* set trans_start so we don't get spurious
>  	 * watchdogs during reset
>  	 */
> @@ -8190,17 +8233,15 @@ int stmmac_suspend(struct device *dev)
>  		timer_delete_sync(&priv->eee_ctrl_timer);
>  	}
>  
> -	/* Stop TX/RX DMA */
> -	stmmac_stop_all_dma(priv);
> -
> -	stmmac_legacy_serdes_power_down(priv);
> -
>  	/* Enable Power down mode by programming the PMT regs */
>  	if (priv->wolopts) {
> +		stmmac_stop_all_dma(priv);
> +		stmmac_legacy_serdes_power_down(priv);
>  		stmmac_pmt(priv, priv->hw, priv->wolopts);
>  		priv->irq_wake = 1;
>  	} else {
> -		stmmac_mac_set(priv, priv->ioaddr, false);
> +		stmmac_datapath_teardown(priv);
> +		stmmac_legacy_serdes_power_down(priv);
>  		pinctrl_pm_select_sleep_state(priv->device);
>  	}

Only the WoL branch keeps stmmac_stop_all_dma() and therefore the
stmmac_deinit_chan() interrupt masking; the plain suspend case is the one
that loses it, as noted above.
-- 
This is an AI-generated review.

