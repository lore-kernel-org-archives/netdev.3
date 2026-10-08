Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C83AB5CA;
	Thu,  8 Oct 2026 16:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477186; cv=none; b=pvTW6fxHIq7PfJSJXjukJ+1AK5zEG8XdC3/h6GsG6W986tHnIEIyU1+kA134lbikQ7dmvEi1ADc/BxPHkVEKB711r6RIWJFxtOti/MkGCTDOGK1As0YvvG4gkYaAoOOimCzanHOPbEe2fpTUdEdVRtfdHEUnXrjHXce9D8Vf4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477186; c=relaxed/simple;
	bh=XNtWlmjAgXPbnwi8/scXfwX6WL6ymLkd3NUowAsTuUo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lGbIipSVT0Lr5MF+66YiUK9QjzGb/zF8Se7KSQeyWCb7DxwACGuNRM0apZ/LTWnCJrUgPUYRq916p52LprmfqbB5Qirtsg5QLNPOY6v3jTwQytpPgBKKOdZiuHboFjpVuRkG+GPB9yaRDZIjgTawFmNOShSVSKiX5cC6CDPc4/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VybfSXCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VybfSXCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BF81F00899;
	Thu,  8 Oct 2026 16:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791477177;
	bh=081Z/UvAAylGQTYrX/0xuTEqlAMAWGEdnRGrQFpEPIs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VybfSXCweeCy7ato0AMX/vZG2zSmcMXyflRauL1nSE0XC9e+ZDyB9Pdz+Oc4XPPna
	 Fka9aIFTTimv4243WwtSVDXvCJACyBDZAT6Z5E8g7hL3xkok8ZSYu1PT+UVwIBH8Cx
	 4cYmHQD3KhurYkmHpr8PmycL2eKBoeNXqxQR+dUFQgYF6Sou0Ovwd9gRWU7DE2m4Eg
	 2CUNExVBJ9LxTsIbrgULcSV/L1tnXdBPOqfO0IetAcG+998I1cEIVrepgKXEt0BhbD
	 fWh9QsQMshyS/uk561PiRBtfO/uYrcXJ8aoGX89QAH6+ifjRD+to2HSmC43fvIyRPx
	 VN9wLrFuls9sA==
Subject: Re: [PATCH net-next v10 5/6] net: stmmac: dwmac-rk: add SGMII support
 for RK3568
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, maxime.chevallier@bootlin.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, david.wu@rock-chips.com,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 08 Oct 2026 16:32:56 +0000
Message-ID: <179147717619.434549.6837184634225737346@kernel.org>
In-Reply-To: <20261005223011.1124347-6-coiaprant@gmail.com>
References: <20261005223011.1124347-6-coiaprant@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] SGMII cannot work at all, and the XPCS leaks on every probe.
- [Medium] With phy-mode="sgmii", rk_gmac_probe() clears
  plat_dat->set_clk_tx_rate and sets default_an_inband=true, but that…
- [Medium] The commit message's account of in-band vs out-of-band SGMII
  is wrong in three ways.
- [Medium] xpcs_rk_create(), which the new rk_pcs_init() calls, assumes
  that 'supplier->links.status == DL_DEV_DRIVER_BOUND' right after…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rk_gmac_exit() assumes driver data already exists.
- [Medium] This problem wasn't introduced by this patch, but
  rk_gmac_resume() ignores the return value of rk_gmac_powerup() and…

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

This patch adds RK3568 SGMII support to dwmac-rk. It adds a set_to_sgmii()
GRF callback, plus pcs_init/pcs_exit/select_pcs callbacks that create the
XPCS with xpcs_rk_create(). For SGMII it also enables clocks earlier in
rk_gmac_powerup(), sets default_an_inband and clears set_clk_tx_rate.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)

> On RK3568, the MAC clock is fixed at 125 MHz and cannot be dynamically
> changed by the stmmac core's set_clk_tx_rate callback.  In-band mode
> works because the PCS handles rate adaptation internally.  Out-of-band
> mode does not work because the MAC would need to change the clock rate
> to 125/12.5/1.25 MHz for 1000/100/10 Mbps respectively, and the clock
> is fixed.

[Severity: Medium]
Are these rates correct? The clk_tx_i kernel-doc in include/linux/stmmac.h
says "SGMII 125MHz SerDes clock divided by 1, 5, or 50". Also,
rgmii_clock(), which rk_set_clk_mac_speed() uses, returns
125/25/2.5 MHz.

The reason given for in-band working and out-of-band failing also doesn't
seem to match the code:

- rk_gmac_probe() sets set_clk_tx_rate to NULL for every SGMII
  configuration, so the MAC clock is handled the same way in both modes.
- The XPCS is told the speed in both modes: through MAC_AUTO_SW in
  xpcs_config_aneg_c37_sgmii() for in-band, and through a BMCR write in
  xpcs_link_up_sgmii_1000basex() for out-of-band.

> Enable default_an_inband for SGMII and disable the generic stmmac
> set_clk_tx_rate callback.

The callback that gets cleared is rk_set_clk_tx_rate(). That is the
Rockchip-specific one, which ends up in rk_set_clk_mac_speed() on rk3568,
not a generic stmmac callback.

Could the commit message be updated on these points?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 72bdbcb5e863a..3b50ad3c600b9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1211,6 +1239,43 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
>  		dev_err(bsp_priv->dev, "fail to disable phy-supply\n");
>  }
>  
> +static int rk_pcs_init(struct stmmac_priv *priv)
> +{
> +	struct device_node *np = priv->device->of_node;
> +	struct device_node *pcs_node;
> +	struct dw_xpcs *xpcs;
> +
> +	pcs_node = of_parse_phandle(np, "pcs-handle", 0);
> +	if (!pcs_node)
> +		return -ENODEV;
> +
> +	xpcs = xpcs_rk_create(priv->device, pcs_node);

[Severity: Medium]
Can xpcs_rk_create() race with the XPCS driver binding? It does this:

drivers/net/pcs/pcs-xpcs-rk.c:xpcs_rk_create() {
    ...
	link = device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
    ...
	if (READ_ONCE(link->supplier->links.status) != DL_DEV_DRIVER_BOUND) {
    ...
}

fw_devlink does not parse "pcs-handle", so nothing orders the supplier
ahead of this probe. Suppose the XPCS device has no driver when
device_link_add() runs:

- The link starts in DL_STATE_DORMANT.
- If the XPCS driver binds before the READ_ONCE() check,
  device_links_driver_bound() moves the link to DL_STATE_AVAILABLE, not
  DL_STATE_CONSUMER_PROBE.
- The DL_DEV_DRIVER_BOUND check still passes.

device_links_unbind_consumers() only waits for links in
DL_STATE_CONSUMER_PROBE. Could a concurrent unbind of the XPCS driver then
free the devm-managed pxpcs and mii_bus while xpcs_create_mdiodev() is
still using them?

Also, if the stmmac probe then succeeds, wouldn't
device_links_driver_bound() for the consumer hit
WARN_ON(link->status != DL_STATE_CONSUMER_PROBE)?

> +	of_node_put(pcs_node);
> +	if (IS_ERR(xpcs))
> +		return PTR_ERR(xpcs);
> +
> +	priv->hw->xpcs = xpcs;

[Severity: High]
Does this XPCS pointer survive after the callback returns? On the pcs_init
branch, stmmac_pcs_setup() never sets its local xpcs, and then writes it
back unconditionally:

drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c:stmmac_pcs_setup() {
	struct dw_xpcs *xpcs = NULL;
	...
	if (priv->plat->pcs_init) {
		ret = priv->plat->pcs_init(priv);
	} else if (fwnode_property_present(devnode, "pcs-handle")) {
	...
	priv->hw->xpcs = xpcs;

	return 0;
}

So once rk_pcs_init() returns, priv->hw->xpcs is NULL again.

In stmmac_phylink_setup(), priv->hw->xpcs and priv->hw->phylink_pcs are
then both NULL, so the XPCS supported_interfaces are never merged.
rk_get_interfaces() has already set the RGMII and RMII bits for rk3568,
so PHY_INTERFACE_MODE_SGMII never ends up in supported_interfaces.

With default_an_inband set, phylink_parse_mode() takes the in-band path
and phylink_validate() fails. Doesn't that make phylink_create(), and so
the whole probe, fail with -EINVAL on every phy-mode = "sgmii" board?

Even if probe got past that, rk_select_pcs() would return NULL. Also,
rk_pcs_exit() and stmmac_pcs_clean() both return early when
priv->hw->xpcs is NULL, so xpcs_destroy() never runs. Is the dw_xpcs,
together with its mdio_device reference and clocks, leaked on every probe
attempt?

The other pcs_init users (socfpga, rzn1, renesas) avoid this by storing
their PCS in priv->hw->phylink_pcs.

Because of this, the commit message statement that SGMII "comes from the
XPCS's own supported_interfaces, merged by stmmac_phylink_setup()" does
not currently hold.

> +	return 0;
> +}
> +
> +static void rk_pcs_exit(struct stmmac_priv *priv)
> +{
> +	if (!priv->hw->xpcs)
> +		return;
> +
> +	xpcs_destroy(priv->hw->xpcs);
> +	priv->hw->xpcs = NULL;
> +}
> +
> +static struct phylink_pcs *rk_select_pcs(struct stmmac_priv *priv,
> +					 phy_interface_t interface)
> +{
> +	if (!priv->hw->xpcs)
> +		return NULL;
> +
> +	return xpcs_to_phylink_pcs(priv->hw->xpcs);
> +}

[ ... ]

> @@ -1466,6 +1541,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
>  
>  	return 0;
> +
> +clk_disable:
> +	gmac_clk_enable(bsp_priv, false);
> +	return ret;
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but rk_gmac_resume() ignores
the error returned here:

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_gmac_resume() {
	...
	if (!device_may_wakeup(dev))
		rk_gmac_powerup(bsp_priv);

	return 0;
}

If the clock enable, a GRF write or the phy regulator fails during
resume, rk_gmac_powerup() returns an error and the clocks are disabled.

Won't stmmac_resume() then go on to reinitialise the MAC with its clocks
off?

[ ... ]

> @@ -1605,6 +1684,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
>  	plat_dat->suspend = rk_gmac_suspend;
>  	plat_dat->resume = rk_gmac_resume;
>  
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> +		/* SGMII clock always runs at 125 MHz */
> +		plat_dat->set_clk_tx_rate = NULL;
> +
> +		/* SGMII requires a PCS */
> +		plat_dat->default_an_inband = true;

[Severity: Medium]
default_an_inband only picks the default. Does anything stop phylink from
running this link out-of-band?

- A fixed-link node gives MLO_AN_FIXED.
- If the PHY reports only LINK_INBAND_DISABLE: xpcs_inband_caps() returns
  LINK_INBAND_DISABLE | LINK_INBAND_ENABLE for SGMII, so
  phylink_pcs_neg_mode() selects PHYLINK_PCS_NEG_OUTBAND.

rk_select_pcs() returns the XPCS whatever the neg_mode is. With
set_clk_tx_rate cleared, the MAC clock stays at 125 MHz.

According to the commit message, 10/100 Mbps would then have working TX
and failing RX. The link would still be reported up, and nothing would be
logged.

Could the driver reject this or warn about it, for example by checking the
neg_mode or limiting the MAC capabilities? Right now it is only documented
in the commit message.

> +		plat_dat->pcs_init = rk_pcs_init;
> +		plat_dat->pcs_exit = rk_pcs_exit;
> +		plat_dat->select_pcs = rk_select_pcs;
> +	}
> +
>  	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
>  	if (IS_ERR(plat_dat->bsp_priv))
>  		return PTR_ERR(plat_dat->bsp_priv);

[Severity: Medium]
This is a pre-existing issue, but rk_gmac_exit(), which is installed as
plat_dat->exit in this function, assumes the driver data has already been
set:

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_gmac_exit() {
	struct stmmac_priv *priv = netdev_priv(dev_get_drvdata(dev));
	...
	if (priv->plat->phy_node && bsp_priv->integrated_phy)
	...
}

stmmac_dvr_probe() calls plat->init before __stmmac_dvr_probe(), and
calls plat->exit if anything fails afterwards.

Suppose __stmmac_dvr_probe() fails before dev_set_drvdata(), for example
because devm_alloc_etherdev_mqs() returns NULL. Would rk_gmac_exit() then
dereference a priv derived from a NULL net_device?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005223011.1124347-1-coiaprant%40gmail.com
