Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE054746D7
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787061452; cv=none; b=DnyZ9U9bS0majExofjcDj2UeHDsC25FUwbCAyTjZiMbH6L42K/3ksShoNCg3R8XW63ZsGmRnT9i5I/r4PoR/udflhfH0wQsqwQl+1WuhWA/IqZPfPVLSP12oLnlUdZtzi2GTfTXUW3GOLpi1aAO3VpEYFcVt5XaaF7Ai7NOz83k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787061452; c=relaxed/simple;
	bh=8G274l5m77akC/pSqJDtcoVOPIRr/BFgizEwyIgwsrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbT7/1auN7nCWIEIdaikYJVoRpaATBjoW2CseLDMKA4pSi2Dgy3gqTP4jq+fa9bnbqKjsm2IgzcAGTQXWZuId/VpTHitQ001YDgtZV7aDkRaxnehlSLDPF/AegTtVA8xmcGdPeRnn6PYd5l9d2W7OKtko9rf/mUDXunwYrdTTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BB9gkHxP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BB9gkHxP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787061449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbVIP7eV67dMkDjvxsr26XLRzB9oQ7sc2FLS85rR1us=;
	b=BB9gkHxPDLNoaBz87Z9EV6qhpQqQLO8nUCXBnYUsLwS38UOEjuqiubdxoOj4UCRU5BT+G+
	BA3LWLxfHWd1LrgND8vmWXIXLX1A8mW685P+zMshC5GKeQITx3eRtunULuDCOcCCjIiTge
	W+wM8DcG63ZXVB/9gxNUdzLhKyRcEbs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-YmFEyuKyNDOcdfPjvUk-WA-1; Tue,
 18 Aug 2026 09:57:21 -0400
X-MC-Unique: YmFEyuKyNDOcdfPjvUk-WA-1
X-Mimecast-MFC-AGG-ID: YmFEyuKyNDOcdfPjvUk-WA_1787061439
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE24F18007FB;
	Tue, 18 Aug 2026 13:57:18 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.207])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 563B730002EA;
	Tue, 18 Aug 2026 13:57:13 +0000 (UTC)
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
Subject: Re: [PATCH net-next v4 1/3] net: stmmac: enable MAC rx/tx after DMA start
Date: Tue, 18 Aug 2026 15:57:04 +0200
Message-ID: <20260818135704.212816-1-pabeni@redhat.com>
In-Reply-To: <20260814-stmmac-rx-fifo-block-v4-1-1951fd3d33b7@gmail.com>
References: <20260814-stmmac-rx-fifo-block-v4-1-1951fd3d33b7@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: enable MAC rx/tx after DMA start

This moves the stmmac_mac_set(priv, priv->ioaddr, true) call in
stmmac_hw_setup() and stmmac_xdp_open() so that it runs after
stmmac_start_all_dma() instead of before it. The stated goal is that the
MAC only starts accepting frames once the DMA channels can drain the MTL
FIFOs.

A few questions below.

The commit body describes a concrete hardware failure ("the per-queue FIFO
overflows within this window", "never retries delivery even if the DMA
comes alive later on"), so this reads as a bug fix rather than a cleanup,
but the only trailer present is:

> Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>

[Severity: Low]
Could a Fixes: tag be added for each of the two sequences being corrected,
one for the ordering in stmmac_hw_setup() and one for the same ordering in
stmmac_xdp_open() which arrived with the AF_XDP path?

Without a Fixes: trailer, how do stable/backport tools determine the
affected release range, and is this intended for net or net-next?

Would it also help to mention the core/platform on which the stall was
reproduced and how the fix was validated, plus any Reported-by:/Closes:
reference if one exists?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index b2b7d0242dd3c..b9d5d4aabf423 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -3685,9 +3685,6 @@ static int stmmac_hw_setup(struct net_device *dev)
>  		priv->hw->rx_csum = 0;
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Set the HW DMA mode and the COE */
>  	stmmac_dma_operation_mode(priv);
>  
> @@ -3743,6 +3740,9 @@ static int stmmac_hw_setup(struct net_device *dev)
>  	/* Start the ball rolling... */
>  	stmmac_start_all_dma(priv);
>  
> +	/* Enable the MAC Rx/Tx */
> +	stmmac_mac_set(priv, priv->ioaddr, true);
> +

[Severity: Medium]
Does this reordering actually close the window on the dwmac4/dwmac5
(GMAC4+) cores?

There the MAC receiver and transmitter enables are set from inside the
per-channel DMA start callbacks:

drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c:dwmac4_dma_start_rx() {
	value |= DMA_CONTROL_SR;
	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));

	value = readl(ioaddr + GMAC_CONFIG);
	value |= GMAC_CONFIG_RE;
	writel(value, ioaddr + GMAC_CONFIG);
}

and dwmac4_dma_start_tx() does the same for GMAC_CONFIG_TE.

stmmac_start_all_dma() starts the RX channels one at a time:

	for (chan = 0; chan < rx_channels_count; chan++)
		stmmac_start_rx_dma(priv, chan);

so the global MAC receiver is already enabled by the first iteration while
channels 1..n-1 still have SR == 0. On those cores, isn't the relocated
stmmac_mac_set(priv, priv->ioaddr, true) redundant, and doesn't the
"MAC classifies frames into an MTL queue whose DMA is not running"
condition still exist whenever rx_queues_to_use > 1?

The RE-in-DMA-op coupling itself isn't introduced by this patch, but should
the commit message claim "The EMAC should only accept packets after the DMAs
are enabled" be qualified, or should the dwmac4 coupling be decoupled too?

[Severity: Low]
This isn't a bug introduced by this patch, but the mirror-image teardown
ordering used to be the reverse of what this patch establishes, i.e.
stopping the DMA before disabling the MAC Rx in __stmmac_release(),
stmmac_xdp_release() and stmmac_suspend(). The follow-on commit "net:
stmmac: xgmac: tear the datapath down in the documented order" introduces
stmmac_datapath_teardown() and converts those callers, so the MAC is
disabled before stmmac_stop_rx_dma() runs:

	/* Disable the MAC TX and RX */
	stmmac_mac_set(priv, priv->ioaddr, false);

	/* Wait for the MTL RX queues to drain into the RX DMA */
	...
	for (chan = 0; chan < rx_channels_count; chan++)
		stmmac_stop_rx_dma(priv, chan);

Noting it here only for completeness, since the remaining "MAC Rx on, DMA
off" case is the WoL branch of stmmac_suspend(), which that commit
documents as intentional.

>  	phylink_rx_clk_stop_block(priv->phylink);
>  	stmmac_set_hw_vlan_mode(priv, priv->hw);
>  	phylink_rx_clk_stop_unblock(priv->phylink);
> @@ -7184,12 +7184,12 @@ int stmmac_xdp_open(struct net_device *dev)
>  		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>  	}
>  
> -	/* Enable the MAC Rx/Tx */
> -	stmmac_mac_set(priv, priv->ioaddr, true);
> -
>  	/* Start Rx & Tx DMA Channels */
>  	stmmac_start_all_dma(priv);
>  
> +	/* Enable the MAC Rx/Tx */
> +	stmmac_mac_set(priv, priv->ioaddr, true);
> +
>  	ret = stmmac_request_irq(dev);
>  	if (ret)
>  		goto irq_error;

[Severity: High]
This isn't a bug introduced by this patch, since the DMA was already started
here before the reorder, but the MAC enable now sits inside a region whose
error path never unwinds either the DMA or the MAC.

If stmmac_request_irq() fails, the unwind in stmmac_xdp_open() is:

irq_error:
	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);

init_error:
	free_dma_desc_resources(priv, &priv->dma_conf);

There is no stmmac_stop_all_dma() and no stmmac_mac_set(priv, priv->ioaddr,
false), while free_dma_desc_resources() reaches:

__free_dma_rx_desc_resources() {
	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
	...
	if (rx_q->page_pool)
		page_pool_destroy(rx_q->page_pool);
}

Can the RX DMA then write received frames into the freed coherent
descriptor ring and the freed page-pool pages? stmmac_xdp_set_prog() also
discards the stmmac_xdp_open() return value:

	if (if_running && need_update)
		stmmac_xdp_open(dev);
	...
	return 0;

so does the device stay in that state indefinitely rather than being
reported and cleaned up?

The same gap looks present on the ifup path: __stmmac_open()'s irq_error
label only does phylink_stop(), the per-queue hrtimer_cancel() and
stmmac_release_ptp(), and stmmac_open() then falls through to
err_dma_resources: free_dma_desc_resources(priv, dma_conf), which frees the
rings that were programmed into the live DMA engine.

Should these error paths be made symmetric with the release path, which
does:

	/* Stop the MAC and the TX/RX DMA channels */
	stmmac_datapath_teardown(priv);

	/* Release and free the Rx/Tx resources */
	free_dma_desc_resources(priv, &priv->dma_conf);

[Severity: Medium]
This is a pre-existing race rather than something the patch adds, but it
bears on the invariant the patch is establishing: the ordering here is only
statement order inside stmmac_xdp_open(), and nothing serializes it against
phylink's resolve worker.

phylink_resolve() runs from a work item holding only pl->phydev_mutex,
phy->lock and pl->state_mutex, with no rtnl:

drivers/net/phy/phylink.c:phylink_resolve() {
	mutex_lock(&pl->phydev_mutex);
	phy = pl->phydev;
	if (phy)
		mutex_lock(&phy->lock);
	mutex_lock(&pl->state_mutex);
	...
		else
			phylink_link_up(pl, link_state);
}

and that reaches stmmac_mac_link_up() -> stmmac_mac_set(priv, priv->ioaddr,
true). The AF_XDP reconfiguration never quiesces phylink:

drivers/net/ethernet/stmicro/stmmac/stmmac_xdp.c:stmmac_xdp_set_prog() {
	if (if_running && need_update)
		stmmac_xdp_release(dev);
	...
	if (if_running && need_update)
		stmmac_xdp_open(dev);
}

So can a link-up resolved on another CPU re-enable MAC Rx after
stmmac_xdp_release() has stopped the DMA and before stmmac_xdp_open()
reaches stmmac_start_all_dma(), which is the same "MAC accepting frames with
no DMA to drain the MTL FIFO" condition described in the commit message?

Separately, stmmac_mac_link_up() and stmmac_mac_set() both do unlocked
read-modify-write on MAC_CTRL_REG:

	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
	ctrl = old_ctrl & ~priv->hw->link.speed_mask;
	...
	if (ctrl != old_ctrl)
		writel(ctrl, priv->ioaddr + MAC_CTRL_REG);
	...
	stmmac_mac_set(priv, priv->ioaddr, true);

Can concurrent speed/duplex and RE/TE updates lose each other's bits?
-- 
This is an AI-generated review.

