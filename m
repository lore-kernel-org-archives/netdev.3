Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885F8311C32;
	Wed, 23 Sep 2026 00:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790124478; cv=none; b=uYav06ft8D+GWnpZ8kRdWqZXh/KBhL2p4hRH8aCJW/JzZ2ufJY63aHz6vJCmoM3b3Wm3UAYUGpZ0z9nBOX46rjNdwFbtth6wrrtmAF6I9JWmIx7kjypVwe0akN67TAq4Pq4vUSPXr5p1oDQO0VNeV08f5RUr+7howVzSa5MFSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790124478; c=relaxed/simple;
	bh=DigwotNZd9e/jSiZ5HyoTpHwORzpaWh3JuR140peKzo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mN7FYmoNnz5kPEmdl2gXNXJF8nbakTB+9czurNJ/t1vKOJ1/xqANRJEcoYKsGFqmOIdjfMH04GMH/ihnbE7bUQmEo9oCZS9AeP+0T+wlZyP6kfiUpbukTxrbluyuNzCIL3/v9uPhzrzSRLONaWdTIzh9dxSdFTM/Nh/4u8ffCl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwx+C1o/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwx+C1o/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A8B1F000FF;
	Wed, 23 Sep 2026 00:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790124477;
	bh=Q6R72z4biQuhbuvKXAohdwh9JXfySxkmEQFe+IrNTlI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kwx+C1o/fjgNP2CwNamu9O2d89TYlu2BgDdLakou4zzOuzFmSHpoJ8eUs4q2P30NJ
	 dpZIBcP/Gozj8gTQm4hUwCJzDmtgat19LZkjSeFzM5Iig52DD7oX+M7N5O9YEkJxb3
	 VHV1HWng8BSA4Rka5vyZDGGtGxeuPj1Wjnc/MFexfdvQwiebtTrZB7Nm87/hwnzj75
	 pMATWEm6SzC4CGFOtXvPb3B5YrVrrVs4Lx04KTnZg5KsGeyx6JRk0OQQV+4WXrSCDJ
	 FMwYMANHHsO8ywMtlfJEJBhFAYhCiDdzp5NaVj4UQDdqrkf8H3cPKeVakjky56dydI
	 4iYYHeX7tGZsA==
Subject: Re: [PATCH net-next v5 1/3] net: stmmac: sun8i: reset the MAC after
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
Date: Wed, 23 Sep 2026 00:47:55 +0000
Message-ID: <179012447513.2160803.15619421088202921144@kernel.org>
In-Reply-To: <20260921-submit-h616-emac1-v1-v5-1-ada661ed9e9b@gmail.com>
References: <20260921-submit-h616-emac1-v1-v5-1-ada661ed9e9b@gmail.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: on the soc_has_internal_phy variants (H3, V3s)
  the clock-dependent MAC software reset is still executed at probe time…

Pre-existing issues:
- [High] Use-after-free in the sun8i_dwmac_probe() 'dwmac_mux:' error
  path: it calls reset_control_put(gmac->rst_ephy) and…

--

net: stmmac: sun8i: reset the MAC after PHY initialization

The MAC software reset is moved out of probe and into the
stmmac_dma_ops->reset callback, so it runs during hardware setup after the
PHY has been attached and initialized. Interrupts are masked before the
reset is requested, the DMA and interrupt registers are still cleared on
timeout, and the reset error is returned through the normal hardware-setup
error path. The separate H3 MDIO-mux reset is kept.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index 48c52eb962335..9598c386bb216 100644
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
> +

[ ... ]

> @@ -895,7 +896,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
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

[Severity: High]
On the soc_has_internal_phy variants (H3, V3s), does this retained reset
still hit the exact condition the changelog says is being removed?  The
switch callback runs at probe time from PHY-ID discovery, before any
external PHY driver is bound:

sun8i_dwmac_probe()
  sun8i_dwmac_register_mdio_mux()
    mdio_mux_init()            /* pb->current_child = -1 */
      of_mdiobus_register()    /* external child bus */
        get_phy_device()
          mdio_mux_read()
            mdio_mux_syscon_switch_fn()
              sun8i_dwmac_unpower_internal_phy()   /* clock gated,
                                                      reset asserted */
              sun8i_dwmac_reset(priv->ioaddr)

On the DWMAC_SUN8I_MDIO_MUX_EXTERNAL_ID branch the internal EPHY has just
been unpowered and the external PHY has no driver-managed clock yet, which
is the same "no running receive clock" case that sun8i_dwmac_dma_reset()
now documents with:

	/* The PHY receive clock must be running for the reset to complete. */

What happens when this times out during discovery?  The -ETIMEDOUT is
returned from switch_fn instead of the register value:

drivers/net/mdio/mdio-mux.c:mdio_mux_read() {
	r = pb->switch_fn(pb->current_child, cb->bus_number, pb->switch_data);
	if (r)
		goto out;
	pb->current_child = cb->bus_number;
	...
}

get_phy_c22_id() only maps -EIO/-ENODEV to -ENODEV, so -ETIMEDOUT reaches:

drivers/net/mdio/of_mdio.c:__of_mdiobus_parse_phys() {
	if (rc == -ENODEV)
		dev_err(...);
	else if (rc)
		goto exit;
	...
}

which aborts registration of the whole external child bus, and mdio_mux_init()
then drops that child with "Error: Failed to register MDIO bus for child".
Probe still returns 0 because the internal child registered, but the external
PHY device is never created, so phylink_of_phy_connect() at open fails and
loading the PHY driver later cannot recover without reprobing the MAC.  Isn't
that the same unrecoverable failure the commit message describes?

Also, since mdio_mux_read() leaves pb->current_child unchanged on error,
does every subsequent access to that child repeat the switch and spend
another 100 ms in the timeout?

> @@ -1217,10 +1220,6 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "Failed to register mux\n");
>  			goto dwmac_mux;
>  		}
> -	} else {
> -		ret = sun8i_dwmac_reset(priv);
> -		if (ret)
> -			goto dwmac_remove;
>  	}
>  
>  	pm_runtime_put(&pdev->dev);

[Severity: High]
This isn't a bug introduced by this patch, but the "goto dwmac_mux" error
path above looks like it uses the EPHY clock and reset handles after they
have been put, and the retained mux reset makes that path easier to reach.

sun8i_dwmac_probe() error path:

dwmac_mux:
	reset_control_put(gmac->rst_ephy);
	clk_put(gmac->ephy_clk);
dwmac_remove:
	pm_runtime_put_noidle(&pdev->dev);
	stmmac_pltfr_remove(pdev);

stmmac_pltfr_remove() -> stmmac_dvr_remove() ends with:

	if (priv->plat->exit)
		priv->plat->exit(dev, priv->plat->bsp_priv);

which is sun8i_dwmac_exit():

	if (gmac->variant->soc_has_internal_phy)
		sun8i_dwmac_unpower_internal_phy(gmac);

and that still calls clk_disable_unprepare(gmac->ephy_clk) and
reset_control_assert(gmac->rst_ephy) on the handles freed just above.
Does this touch freed memory whenever mdio_mux_syscon_switch_fn() already
powered the internal PHY (gmac->internal_phy_powered == true) and
mdio_mux_init() then fails, for example a second child bus returning
-EPROBE_DEFER, "No acceptable child buses found", or the retained MAC reset
returning -ETIMEDOUT?

Would the ordering used by sun8i_dwmac_remove() work here too, i.e.
mdio_mux_uninit(), then sun8i_dwmac_unpower_internal_phy(), then
reset_control_put() and clk_put()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260921-submit-h616-emac1-v1-v5-0-ada661ed9e9b%40gmail.com
