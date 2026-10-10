Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EE536A033;
	Sat, 10 Oct 2026 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791633344; cv=none; b=MMnlnsG42mc3FfsKQWbSbBHxGaINM7RYsHgfe7bAUyKLdAuQqY7GkAHWu03QyzcSMsPJBKQ3BzUKgjxmHlZmbydQnjGTm40rJ2OOd0XuaTBPO+I80Am5QEyrcNj23kOogMtwg82BGldjBT6IERcDxglFowLpPxYKg8M310D87Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791633344; c=relaxed/simple;
	bh=PhEKCgJ7fqEmIMDLwZnuYdgbGSXBncyq7U26etSroPA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YAUXxyBMT+FHA31SrCQE+6FT7STKCArcS/ZKOHQOfK7bRS113+2BYxizeyRGkRCZjASL11fVY8Bbbd0mRfxxHSII+9bKY70utItKWOVIXKzivRkbtqbDBWMOnX8c4BKgT2zH3HbghYb+JDHap7At43vhzsoH5fuYeXdc3P8Zg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxg/1PC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxg/1PC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C83CE1F000FF;
	Sat, 10 Oct 2026 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791633342;
	bh=xsPG4zfcNkAT6dXyjDki77ZwX/x2nyD+OqM/cCf911c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rxg/1PC5iZ3AffgdkfcDam6BRspq7ROgwaQivsxC5BEL3uvrfKvIGPZds34iZERWS
	 MnKbgH2v4SMVfHZ8PdYcHNZ1xK3GNCdXP7MhTGoOeSnUGEvd+cEM5mW6Fd5QvwB8Ra
	 Gk2cbNfH57if/85w5IDhl4aDO0MS7YhSthC6Z1sn9H8ocED312jOGNbMPzSAE/TKFH
	 k/KqAMdt41CrCP/fyk88cQBAg8/4WW5/GEFjam9Uyv3mdALnGezD9+8jDz618r04ye
	 sMSzrTo8G1VQFSH8f40P6GznmU49zqjhCogGGFw2H5TyFLdEPNiWUxXdvElpx99DS5
	 pRTje/vcByMqg==
Subject: Re: [PATCH net-next v4 1/6] net: xilinx: axienet: Introduce
 axienet_config for MAC-specific ops
From: netdev-bot+sashiko@kernel.org
To: suraj.gupta2@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, michal.simek@amd.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sat, 10 Oct 2026 11:55:41 +0000
Message-ID: <179163334130.434549.15131171299292504182@kernel.org>
In-Reply-To: <20261006110550.1990213-2-suraj.gupta2@amd.com>
References: <20261006110550.1990213-2-suraj.gupta2@amd.com>
X-sashiko-severity: Medium
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

Critical: 0 (1) · High: 0 · Medium: 1 (3) · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "No functional change intended for the
  existing 1G path", but the patch changes 1G behaviour in…
- [Low] axienet_dma_err_handler() ignores the return value of the new
  int-returning mac_init callback, then re-enables TX/RX through…
- [Low] The new axienet_config::jumbo flag is documented as "MAC supports
  jumbo frames", but only axienet_device_reset() reads it, and only to…
- [Low] Mismatches between the kernel-doc and the code for the optional
  members of struct axienet_config.
- [Low] The sw_padding and tx_csum capability flags are honoured in
  axienet_start_xmit_dmaengine() but not in the legacy…
- [Low] On the non-dmaengine path, axienet_device_reset() returns early
  when mac_init() fails, after axienet_dma_bd_init() has already…

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but
  axienet_start_xmit_dmaengine() increments lp->tx_ring_head before…
- [Medium] xlnx,axi-ethernet.yaml lists the interrupt order as Ethernet
  core, Tx DMA, Rx DMA.
- [Medium] axienet_open() discards the return value of
  axienet_device_reset() by overwriting ret with…
- [Medium] On the legacy-DMA path, the BD rings and mapped RX skbs
  allocated by axienet_device_reset() are leaked when axienet_open()…

--

net: xilinx: axienet: Introduce axienet_config for MAC-specific ops

This commit adds struct axienet_config, which holds capability flags and
per-MAC callbacks and is filled in from the OF match table. The shared
axienet paths now use it instead of open-coded 1G behaviour, to prepare
for more MAC types. The commit says no functional change is intended for
the existing 1G path.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index ae8ed4495ea0e..5af48d5cbed3b 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c

[ ... ]

> @@ -711,19 +744,23 @@ static void axienet_dma_stop(struct axienet_local *lp)
>   */
>  static int axienet_device_reset(struct net_device *ndev)
>  {

[ ... ]

>  	if (ndev->mtu > XAE_MTU && ndev->mtu <= XAE_JUMBO_MTU) {
>  		lp->max_frm_size = ndev->mtu + VLAN_ETH_HLEN +
>  					XAE_TRL_SIZE;
>  
> -		if (lp->max_frm_size <= lp->rxmem)
> +		if (lp->max_frm_size <= lp->rxmem && lp->axienet_config->jumbo)
>  			lp->options |= XAE_OPTION_JUMBO;
>  	}

[Severity: Low]
Should the new jumbo flag also limit the MTU range? The kernel-doc says
@jumbo means "MAC supports jumbo frames", but this is the only place the
flag is read. The MTU limits do not check it:

axienet_probe() {
    ...
	ndev->max_mtu = XAE_JUMBO_MTU;
    ...
}

axienet_change_mtu() {
    ...
	if ((new_mtu + VLAN_ETH_HLEN +
		XAE_TRL_SIZE) > lp->rxmem)
		return -EINVAL;
    ...
}

So a MAC with .jumbo = false would still accept an MTU of up to 9000,
limited only by xlnx,rxmem. axienet_device_reset() would then raise
max_frm_size to mtu + VLAN_ETH_HLEN + XAE_TRL_SIZE without setting
XAE_OPTION_JUMBO.

Later in the series, axienet_10g25g_config leaves .jumbo unset but still
gets a max_mtu of 9000.

Is the @jumbo description wrong for XXV, or should max_mtu and
axienet_change_mtu() check .jumbo?

[ ... ]

> @@ -740,26 +777,18 @@ static int axienet_device_reset(struct net_device *ndev)
>  		}
>  	}
>  

[ ... ]

> +	ret = lp->axienet_config->mac_init(ndev);
> +	if (ret)
> +		return ret;

[Severity: Low]
On the non-dmaengine path, axienet_dma_bd_init() has already allocated
the BD rings, mapped the RX skbs and started the DMA by the time this
early return runs. If mac_init() fails, does this leak the BD rings and
the mapped RX skbs?

None of the configs in this series can hit this. Only axienet_1g_config
allows non-dmaengine mode, and axienet_1g_mac_init() always returns 0. A
future MAC with both non_dmaengine set and a mac_init() that can fail
would hit it.

[Severity: Medium]
This is a pre-existing issue, but at this point in the series callers of
axienet_open() never see the new mac_init() error:

axienet_open() {
    ...
	ret = axienet_device_reset(ndev);
	axienet_unlock_mii(lp);

	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
    ...
}

The result of axienet_device_reset() is overwritten before anything
checks it. axienet_1g_mac_init() always returns 0, so this patch adds no
new failure.

The later patch "net: xilinx: axienet: Add 10G/25G (XXV) ethernet
support" in this series adds the missing check.

[Severity: Medium]
This isn't a bug introduced by this patch, but on the legacy DMA path,
does axienet_open() leak the BD rings and mapped RX skbs that
axienet_device_reset() allocated if a later step fails?

A phylink_fwnode_phy_connect() failure returns straight away:

	ret = phylink_fwnode_phy_connect(lp->phylink, dev_fwnode(lp->dev), 0);
	if (ret) {
		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
		return ret;
	}

The err_phy unwind, used for the request_irq() failures in
axienet_init_legacy_dma(), also calls neither axienet_dma_stop() nor
axienet_dma_bd_release():

err_phy:
	cancel_work_sync(&lp->rx_dim.work);
	cancel_delayed_work_sync(&lp->stats_work);
	phylink_stop(lp->phylink);
	phylink_disconnect_phy(lp->phylink);
	return ret;

ndo_stop is not called after ndo_open fails, and the next open
overwrites tx_bd_v and rx_bd_v.

[ ... ]

> @@ -941,19 +977,21 @@ axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
>  		goto xmit_error_drop_skb;
>  
>  	/* Fill up app fields for checksum */

[ ... ]

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch. Can
the error paths in axienet_start_xmit_dmaengine() knock the TX ring out
of sync? The producer index moves forward before the steps that can
fail:

	lp->tx_ring_head++;
	sg_init_table(skbuf_dma->sgl, sg_len);
	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
	if (ret < 0)
		goto xmit_error_drop_skb;

Neither xmit_error_unmap_sg nor xmit_error_drop_skb rolls it back. The
skipped slot has no DMA transaction behind it. Its skb and sg_len still
hold the previous lap's values, or NULL on the first lap.

axienet_dma_tx_cb() consumes slots strictly in order:

	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
	len = skbuf_dma->skb->len;
	...
	dev_consume_skb_any(skbuf_dma->skb);

So the next completion would process the skipped slot. On the first lap
that is a NULL pointer dereference. On later laps it calls dma_unmap_sg()
on an sgl that is already unmapped, reports a stale length to BQL, and
frees an skb that has already been freed. The off-by-one then stays for
the rest of the ring's lifetime.

Normal load seems enough to trigger this. xilinx_dma_prep_slave_sg()
returns NULL when xilinx_axidma_alloc_tx_segment() runs out of its
XILINX_DMA_NUM_DESCS (512) segments, while the axienet ring allows up to
TX_BD_NUM_MAX (4096) entries in flight. dma_map_sg() can also fail when
swiotlb or IOMMU space runs out.

The problem is still there at the end of the series.

[ ... ]

> @@ -2759,29 +2819,114 @@ static void axienet_dma_err_handler(struct work_struct *work)
>  
>  	axienet_dma_start(lp);
>  

[ ... ]

> +	lp->axienet_config->mac_init(ndev);

[Severity: Low]
Should the return value of mac_init() be checked here, as it is in
axienet_device_reset()? The handler re-enables TX and RX through
setoptions(ndev, lp->options) either way.

This handler only runs on the non-dmaengine path, which only the 1G
config can use, and axienet_1g_mac_init() always returns 0. The later XXV
patch in this series adds a comment at this call site saying so. It may
be clearer to add that comment here, where mac_init() first gets an int
return type.

[ ... ]

> @@ -2943,7 +3075,17 @@ static int axienet_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	if (lp->axienet_config->probe_init)
> +		lp->axienet_config->probe_init(lp);
> +
>  	if (!of_property_present(pdev->dev.of_node, "dmas")) {
> +		/* Non-dmaengine mode is only supported by some MACs */
> +		if (!lp->axienet_config->non_dmaengine) {
> +			dev_err(&pdev->dev,
> +				"Non-dmaengine mode not supported by this MAC, use dmaengine\n");
> +			return -EINVAL;
> +		}
> +

[Severity: Low]
This isn't a bug, but some of the new capability flags only take effect
on the dmaengine paths:

- sw_padding and tx_csum are checked in axienet_start_xmit_dmaengine()
  but not in axienet_start_xmit().
- mac_irq is checked in the dmaengine probe branch but not in this
  non-dmaengine branch.

Because of this gate, only axienet_1g_config reaches those paths today,
and its flags match what the legacy code does unconditionally. A future
config with non_dmaengine set and different flags would quietly get the
1G behaviour.

>  		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
>  		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
>  

[Severity: Medium]
This is a pre-existing issue and not introduced by this patch. The
interrupt order in Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml
doesn't seem to match what this branch reads when the DMA resources are
on the Ethernet node.

The binding lists Ethernet core, Tx DMA, Rx DMA. The driver does:

			lp->rx_irq = platform_get_irq(pdev, 1);
			lp->tx_irq = platform_get_irq(pdev, 0);
			lp->eth_irq = platform_get_irq_optional(pdev, 2);

Would a device tree written to match the binding text end up with its
IRQs misrouted?

[ ... ]

> @@ -3109,23 +3256,21 @@ static int axienet_probe(struct platform_device *pdev)
>  			goto cleanup_mdio;
>  		}
>  		of_node_put(np);
> -		lp->pcs.ops = &axienet_pcs_ops;
> +		lp->pcs.ops = lp->axienet_config->pcs_ops;
> +		lp->pcs.poll = true;
> +	}
> +
> +	if (lp->axienet_config->internal_pcs) {
> +		lp->pcs.ops = lp->axienet_config->pcs_ops;
>  		lp->pcs.poll = true;
>  	}

[Severity: Low]
This isn't a bug, but a few kernel-doc entries for struct axienet_config
don't quite match how the members are used:

- @pcs_ops is documented as "or NULL if unused", but it is assigned to
  lp->pcs.ops here without a NULL check. Every config in the series sets
  it, so nothing breaks today.
- @stats_update is NULL-checked in axienet_refresh_stats() but isn't
  documented as optional.
- @internal_pcs says "MAC always drives an internal PCS", but
  axienet_mac_select_pcs() picks the PCS by interface mode only. By the
  end of the series it also handles 10GBASER and 25GBASER, which covers
  XXV.

[ ... ]

> @@ -3168,7 +3313,8 @@ static void axienet_remove(struct platform_device *pdev)
>  	if (lp->pcs_phy)
>  		put_device(&lp->pcs_phy->dev);
>  
> -	axienet_mdio_teardown(lp);
> +	if (lp->mii_bus)
> +		axienet_mdio_teardown(lp);
>  }

[Severity: Medium]
The commit message says:

  No functional change intended for the existing 1G path.

This hunk does change 1G remove behaviour, though. Before the patch, a
failed axienet_mdio_setup() left lp->mii_bus NULL:

drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c:axienet_mdio_setup() {
    ...
unregister:
	of_node_put(mdio_node);
	mdiobus_free(bus);
	lp->mii_bus = NULL;
	return ret;
}

axienet_probe() only warns and carries on. A 1G device using a
fixed-link, or a PHY on another bus, could therefore probe without an
MDIO bus. Unbinding it then went through:

axienet_remove()->axienet_mdio_teardown()->mdiobus_unregister(NULL)

and mdiobus_unregister() dereferences bus->state.

So the new check fixes a NULL pointer dereference. Could it be split out
as a separate fix for net with a Fixes: tag, so it can reach stable, and
the commit message here updated?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006110550.1990213-1-suraj.gupta2%40amd.com
