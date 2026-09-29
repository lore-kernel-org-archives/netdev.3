Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8321DD525;
	Tue, 29 Sep 2026 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653754; cv=none; b=dx86YWFScFeg1o2MiAp4MYwdMeVAnwucQ/+p/m3ckh3WizOVEELUgiuayN7WfheS9LiQKvYBPqjwjeQUuhqaYbjxAmFVhoLJ0EsnaIFQB/ikAKvXzPoE0k+Y8jdt/FFxngwWr2Mzjg5S/AD8XzNOpgJLD3EJwj6Li94TAdDZR0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653754; c=relaxed/simple;
	bh=NuPzFkXF+Cp2xK4J012DQwWEX2Nq+EJBWUOD4DGgNPM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Raxs8AacdL3pA/GFYmjBiYuziHtEKAfQRZDgODJK6P2nskRPuuttFEbP3ryrrZc0GAAEtZy9MayKd8ULxcWx80Z6a70R7CSoiRzoksStCzn9Owz7lP/Wr/+FcZFxFDyzFMFoi1T3hgYryjxnrAsc25VQ5DeyuOWPxPPPtBeTyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAEdmcKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAEdmcKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02051F000FF;
	Tue, 29 Sep 2026 03:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790653752;
	bh=csKY86v+F06JBBIwgLH+CI4S4jVmqKxLkT8G1pw/FOw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CAEdmcKj5PETGQzNjOiGQAvZQAPaJG/IXS5hmTOOJlx4Yalu6FWttMvVQDq2iFKZ8
	 PqGNQMRVlAFrjLzIz4bybrc7tnssEWJ2OrWa1OWXQi9hdfXV4SSiIduQFqzW0ftNb5
	 iU+RqCVJdek/ZzGgoXjFrKfSWFwE6RQ8N88kOwP1AyQ3COZqd50DuU18WaPdE7uWbe
	 +CTfC3wUW4THgnVy9ky/yHQDOzqDjfmWz18mnqDur3Cgyq6ictbeBZXd2PiXjvzsGf
	 hl3+up0YUiFAbh9M8dE21LgWJUZFveJycRgF9iMBh6An8p4Nbifk/m6ecdiarlh5XR
	 /ppuYcJ81WzuA==
Subject: Re: [PATCH net-next v6 1/3] net: stmmac: sun8i: reset the MAC after
 PHY initialization
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: richard.genoud@bootlin.com, maxime.chevallier@bootlin.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wens@kernel.org, jernej.skrabec@gmail.com,
 samuel@sholland.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 clabbe.montjoie@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, peppe.cavallaro@st.com, joabreu@synopsys.com,
 alastair@d-silva.org, mripard@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, andre.przywara@arm.com
Date: Tue, 29 Sep 2026 03:49:10 +0000
Message-ID: <179065375047.434549.7821787702167251080@kernel.org>
In-Reply-To: <20260927-submit-h616-emac1-v1-v6-1-e64971f4e414@gmail.com>
References: <20260927-submit-h616-emac1-v1-v6-1-e64971f4e414@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Before this patch, sun8i_dwmac_dma_reset() always returned 0.
- [Medium] The failure mode the patch sets out to fix can still happen on
  H3/H5 boards with an external PHY.
- [Medium] The sun8i MAC soft reset now runs on the MTU-change, ethtool
  reopen, ndo_open and resume paths.

--

net: stmmac: sun8i: reset the MAC after PHY initialization

This patch moves the sun8i EMAC software reset out of the end of probe and
into the stmmac dma_ops->reset callback. The reset then runs in
stmmac_hw_setup(), after the PHY has been attached and initialized. Reset
timeouts now go through the hardware-setup error path, and the H3
MDIO-mux reset is kept.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 38d7e71de925c..5691da796454d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -269,11 +269,33 @@ static const struct emac_variant emac_variant_h6 = {
>  #define SYSCON_ETCS_EXT_GMII	0x1
>  #define SYSCON_ETCS_INT_GMII	0x2
>  
> +static int sun8i_dwmac_reset(void __iomem *ioaddr)
> +{
> +	u32 v;
> +
> +	v = readl(ioaddr + EMAC_BASIC_CTL1);
> +	writel(v | 0x01, ioaddr + EMAC_BASIC_CTL1);
> +
> +	/* The timeout was previously set to 10ms, but some board (OrangePI0)
> +	 * need more if no cable plugged. 100ms seems OK
> +	 */
> +	return readl_poll_timeout(ioaddr + EMAC_BASIC_CTL1, v,
> +				  !(v & 0x01), 100, 100000);
> +}
> +
>  /* sun8i_dwmac_dma_reset() - reset the EMAC
>   * Called from stmmac via stmmac_dma_ops->reset
>   */
>  static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  {
> +	int ret;
> +
> +	writel(0, ioaddr + EMAC_INT_EN);
> +
> +	/* The PHY receive clock must be running for the reset to complete. */
> +	ret = sun8i_dwmac_reset(ioaddr);

[Severity: Medium]
Is the 100 ms poll in sun8i_dwmac_reset() long enough now that the reset
runs right after the PHY is resumed?

On the reopen and resume paths, __stmmac_open() and stmmac_resume() in
stmmac_main.c call phylink_prepare_resume() and then go straight into
stmmac_hw_setup():

__stmmac_open()
    phylink_prepare_resume(priv->phylink);
    stmmac_reset_queues_param(priv);
    ret = stmmac_hw_setup(dev);
        stmmac_init_dma_engine()
            stmmac_reset()
                sun8i_dwmac_dma_reset()
                    sun8i_dwmac_reset()

phylink_prepare_resume() in drivers/net/phy/phylink.c says it does not
wait for the PHY clock:

	 * then resume the PHY. Note that 802.3 allows PHYs 500ms before
	 * the clock meets requirements. We do not implement this delay.
	 */

The comment in sun8i_dwmac_reset() already says 10 ms was too short on
OrangePi0 with no cable plugged in. Other dwmac reset implementations
allow more time: dwmac1000 200 ms, dwmac4/imx 1 s, loongson 2 s.

Before this patch, sun8i_dwmac_dma_reset() did not need RXC, so these
paths could not fail here. Could a PHY that is slow but still within the
standard now make the reset time out, so that ndo_open, resume or an MTU
change fails? Could that also leave EMAC_BASIC_CTL1 with a soft reset
still pending?

> +
> +	/* Leave DMA and interrupts disabled even if the reset timed out. */
>  	writel(0, ioaddr + EMAC_RX_CTL1);
>  	writel(0, ioaddr + EMAC_TX_CTL1);
>  	writel(0, ioaddr + EMAC_RX_FRM_FLT);
> @@ -281,7 +303,7 @@ static int sun8i_dwmac_dma_reset(void __iomem *ioaddr)
>  	writel(0, ioaddr + EMAC_TX_DESC_LIST);
>  	writel(0, ioaddr + EMAC_INT_EN);
>  	writel(0x1FFFFFF, ioaddr + EMAC_INT_STA);
> -	return 0;
> +	return ret;

[Severity: High]
sun8i_dwmac_dma_reset() can now return -ETIMEDOUT. Can a failed MTU
change then free the DMA rings twice?

On a running interface, stmmac_change_mtu() in stmmac_main.c calls
__stmmac_release() and then __stmmac_open() with a newly allocated
dma_conf. __stmmac_open() copies that dma_conf into priv->dma_conf before
the reset runs:

__stmmac_open()
    memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
    ...
    ret = stmmac_hw_setup(dev);
    if (ret < 0) {
        netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
        return ret;
    }

priv->dma_conf is not restored when this fails. stmmac_change_mtu() then
frees the resources that priv->dma_conf still points to:

stmmac_change_mtu()
    ret = __stmmac_open(dev, dma_conf);
    if (ret) {
        free_dma_desc_resources(priv, dma_conf);
        kfree(dma_conf);
        netdev_err(priv->dev, "failed reopening the interface after MTU change\n");
        return ret;
    }

The interface is left IFF_UP. On a later ndo_stop, __stmmac_release()
calls free_dma_desc_resources(priv, &priv->dma_conf) again. That touches
descriptor rings, the buf_pool, tx_skbuff arrays and page_pools that
have already been freed.

The same ndo_stop also frees dev->irq a second time, calls
phylink_stop() again, and calls stmmac_release_ptp() again, so the PTP
ref clock is disabled twice.

The broken unwind is in the stmmac core. However, before this patch the
sun8i dma reset always returned 0, so this path could not be reached on
sun8i. The commit message now relies on "the normal hardware-setup error
path".

>  }
>  

[ ... ]

> @@ -899,7 +900,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
>  		/* After changing syscon value, the MAC need reset or it will
>  		 * use the last value (and so the last PHY set).
>  		 */
> -		ret = sun8i_dwmac_reset(priv);
> +		ret = sun8i_dwmac_reset(priv->ioaddr);
> +		if (ret)
> +			dev_err(priv->device, "EMAC reset timeout\n");
>  	}
>  	return ret;
>  }

[Severity: Medium]
Can the failure described in the commit message still happen on H3/H5
boards with an external PHY?

The reset in mdio_mux_syscon_switch_fn() still runs during probe, before
any PHY driver has bound. It runs when the external child bus is
registered and its PHY ID is read:

sun8i_dwmac_probe()
    sun8i_dwmac_register_mdio_mux()
        mdio_mux_init()
            of_mdiobus_register(external child)
                get_phy_device()
                    mdio_mux_read()
                        mdio_mux_syscon_switch_fn(1 -> 2)
                            sun8i_dwmac_reset()

The external PHY's RX clock may not be running yet, for example because
the PHY or one of its suppliers is not ready. The reset then returns
-ETIMEDOUT, which get_phy_c22_id() in drivers/net/phy/phy_device.c turns
into -EIO:

	return (phy_reg == -EIO || phy_reg == -ENODEV) ? -ENODEV : -EIO;

__of_mdiobus_parse_phys() treats -EIO as fatal, so of_mdiobus_register()
fails. mdio_mux_init() in drivers/net/mdio/mdio-mux.c then frees any
child bus that failed with an error other than -EPROBE_DEFER, and never
retries it:

		r = of_mdiobus_register(cb->mii_bus, child_bus_node);
		if (r) {
			mdiobus_free(cb->mii_bus);
			if (r == -EPROBE_DEFER) {
				ret_val = r;
				goto err_loop;
			}
			devm_kfree(dev, cb);

If the internal child registered, probe succeeds without the external
PHY and ndo_open cannot connect to it. If no child registered,
sun8i_dwmac_probe() fails and the MAC is removed.

Either way, loading the missing driver or supplier later cannot bring
the interface back without reprobing the MAC. The commit message
explains why this reset is kept. Should it also say that H3/H5
external-PHY configurations are still not covered by this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927-submit-h616-emac1-v1-v6-0-e64971f4e414%40gmail.com
