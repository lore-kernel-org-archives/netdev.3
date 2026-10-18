Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977FE442118;
	Sun, 18 Oct 2026 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792305947; cv=none; b=AN51+Dr6X+pvlF9xLW53ih6p/BIh+6NbFK7DlEKuu2sCTz2MWdA7A3R+6KhJZwx20J9a3DrcDZ3fsj8Jc1qYZ8J4NeGTIlFNErB2Hs+YzOdj2EtnVZhHNmJr8WGpj/5cV8pl5wxfQ6UE9UO6Ohw/LYsFkEZF0VSFTwmEvXB8DLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792305947; c=relaxed/simple;
	bh=Wo56oYlwkbZsDOrAr4k9FFTv5l+veJH2vxDuLXkRdcE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QWAk4ThS0DGJ1HtlSqPkQN1kZXJI7LX4o112xezjrLqvSdITW7MWlYAAkVHoG9tk9jqFWYnP0MajVcabX+O97GHYw+Rder/y8AKsBmaqBzE6DNETN+U+Er+ARIgIW/QvKlylyf/jizpdphFnBFsT1g0oFM2uqHRs8pmx06YRmso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7TiaQov; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7TiaQov"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286E31F000C4;
	Sun, 18 Oct 2026 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792305935;
	bh=5fOP/bMQXaA7taKz4VSpGw2+M+edO4QsSogcgYJEQgU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l7TiaQovMwgw7yDhFnQaELZKPzPGjLxyK8FRg14brB/pN2QmUhPhndHIcTHYH+ISD
	 ft2+aqncxJLOiYtHWQgN0dMCbw3/oziWmdokHhJt2y9lIfwTn/CSOs3DqHXAxkSO2G
	 tF/GVW0ywVDqH72/TDDyMxra6aO6kHRbY/TwoIBfO45WkBaHjMpMd0tlR2bcLckplH
	 iqh9L+BXyJVzBlBJ/Nxtijjm5zamPc2wMfmWjXvKen5zBmGhDFZaeAqcsnfbOaCUK4
	 CJ66hf0Coit5bYZCQAsvq7UI5Bvnv5HlrlJ3p+ygvdHFL6n3KPmQOBdCEtIZfVBhSE
	 56+Jf0R1HUTHQ==
Subject: Re: [PATCH net-next v12 5/6] net: stmmac: dwmac-rk: add SGMII support
 for RK3568
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
 david.wu@rock-chips.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 06:45:33 +0000
Message-ID: <179230593374.3135.1162107426363265471@kernel.org>
In-Reply-To: <20261017054406.1828061-6-coiaprant@gmail.com>
References: <20261017054406.1828061-6-coiaprant@gmail.com>
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

Critical: 0 · High: 0 · Medium: 3 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] On SGMII, phylink is offered more interface modes than the
  RK3568 glue can configure.
- [Medium] The commit message says out-of-band SGMII at 10/100 gives
  working TX and failing RX on RK3568, because the MAC clock is fixed at…
- [Medium] The new SGMII path cannot open a PHY-less in-band link, such
  as a direct SGMII connection to a switch with managed = "in-band-…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  rk_gmac_resume() throws away the return value of rk_gmac_powerup() and…
- [Medium] This problem wasn't introduced by this patch, but
  __stmmac_dvr_probe() calls pm_runtime_get_noresume(),…

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

This patch adds SGMII support to the RK3568 dwmac-rk glue. It sets the
GRF mode bit and creates the Rockchip XPCS through xpcs_rk_create() in
new pcs_init/pcs_exit/select_pcs callbacks, and it asks for in-band mode
via default_an_inband. It also reorders rk_gmac_powerup() so the clocks
are enabled before the SGMII check, and it merges the error unwinding
into one clk_disable label.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 72bdbcb5e863a..c4db919ec1640 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1211,6 +1239,44 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
>  		dev_err(bsp_priv->dev, "fail to disable phy-supply\n");
>  }
>  
> +static int rk_pcs_init(struct stmmac_priv *priv)
> +{
> +	struct rk_priv_data *bsp_priv = priv->plat->bsp_priv;
> +	struct device_node *node = priv->device->of_node;
> +	struct device_node *pcs_node;
> +	struct dw_xpcs *xpcs;
> +
> +	pcs_node = of_parse_phandle(node, "pcs-handle", 0);
> +	if (!pcs_node)
> +		return -ENODEV;
> +
> +	xpcs = xpcs_rk_create(priv->device, pcs_node, bsp_priv->id);
> +	of_node_put(pcs_node);
> +	if (IS_ERR(xpcs))
> +		return PTR_ERR(xpcs);

[Severity: Medium]
This is a pre-existing issue in the stmmac core, but this new path seems
to make it much easier to hit. xpcs_rk_create() returns -EPROBE_DEFER
until the XPCS is bound. fw_devlink does not appear to track pcs-handle,
so the MAC can probe first.

__stmmac_dvr_probe() takes a runtime PM reference before
stmmac_pcs_setup():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:__stmmac_dvr_probe() {
    ...
	pm_runtime_get_noresume(device);
	pm_runtime_set_active(device);
	if (!pm_runtime_enabled(device))
		pm_runtime_enable(device);
    ...
error_pcs_setup:
	stmmac_mdio_unregister(ndev);
    ...
}

The unwind labels never drop that reference and never disable runtime PM.

Does each deferred probe attempt leak one usage count on the GMAC device?
Runtime PM is left enabled, so pm_runtime_reinit() would not reset the
count. After the eventual successful probe, the GMAC would then never
runtime suspend and its clocks would stay on.

> +
> +	priv->hw->xpcs = xpcs;
> +	return 0;
> +}

[Severity: Medium]
Does this work for a PHY-less in-band link? An example would be
phy-mode = "sgmii" with managed = "in-band-status", a pcs-handle and no
phy-handle.

The PCS is only stored in priv->hw->xpcs, so hw->phylink_pcs stays NULL.
In stmmac_init_phy(), phylink_expects_phy() is true for MLO_AN_INBAND,
and the xpcs bypass only covers clause 73:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_init_phy() {
    ...
	if (priv->hw->xpcs &&
	    xpcs_get_an_mode(priv->hw->xpcs, mode) == DW_AN_C73)
		return 0;
    ...
		if (addr < 0) {
			/* If a custom PCS is in use, no PHY is needed */
			if (priv->hw->phylink_pcs)
				return 0;

			netdev_err(priv->dev, "no phy found\n");
			return -ENODEV;
    ...
}

SGMII uses DW_AN_C37_SGMII. With plat->phy_addr == -1, this would log
"no phy found" and stmmac_open() would fail with -ENODEV.

If the DT has no mdio subnode, the legacy MDIO scan in
stmmac_mdio_register() would instead fail probe with "No PHY found".

The commit message recommends managed = "in-band-status", so is this
configuration expected to work?

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

[Severity: Medium]
Can phylink select an interface mode here that the glue never set up?

rk_select_pcs() ignores the interface argument and returns the XPCS for
every mode. stmmac_phylink_setup() adds the XPCS supported_interfaces to
phylink's set, and the glue does not filter them:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_phylink_setup() {
    ...
	if (priv->hw->xpcs)
		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
    ...
		phy_interface_or(config->supported_interfaces,
				 config->supported_interfaces,
				 pcs->supported_interfaces);
    ...
}

If the XPCS uses the generic synopsys_xpcs_compat table,
xpcs_get_interfaces() advertises 1000BASE-X, 2500BASE-X and the 10G+
modes alongside SGMII. The GMAC4 MAC capabilities (MAC_10 | MAC_100 |
MAC_1000 | MAC_2500FD) do not rule out 1000BASE-X or 2500BASE-X, so both
would pass phylink validation.

The glue only programs SGMII, though. rk_gmac_check_ops(), the
rk_gmac_powerup() switch and rk3568_set_to_sgmii() each act once, on the
phy-mode from DT.

Take an SFP cage, or a PHY whose possible_interfaces includes 2500BASE-X.
Would phylink then move the XPCS into a mode that the GRF, SerDes and
MAC path were never configured for?

This also seems to conflict with the commit message:

    1000BASE-X is not enabled by this series; it may be added later if
    there is a user for it.

Should rk_select_pcs() reject anything other than
PHY_INTERFACE_MODE_SGMII, or should the supported interfaces be masked
down to SGMII?

[ ... ]

> @@ -1450,15 +1521,20 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)

[ ... ]

>  	ret = rk_phy_powerup(bsp_priv);
> -	if (ret) {
> -		gmac_clk_enable(bsp_priv, false);
> -		return ret;
> -	}
> +	if (ret)
> +		goto clk_disable;
>  
>  	pm_runtime_get_sync(dev);
>  
> @@ -1466,6 +1542,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
>  
>  	return 0;
> +
> +clk_disable:
> +	gmac_clk_enable(bsp_priv, false);
> +	return ret;
>  }

[Severity: Medium]
This bug was not introduced by this patch, but rk_gmac_resume() ignores
the return value of rk_gmac_powerup():

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_gmac_resume() {
    ...
	if (!device_may_wakeup(dev))
		rk_gmac_powerup(bsp_priv);

	return 0;
}

When rk_gmac_powerup() fails, the clk_disable exit runs before
rk_phy_powerup() and pm_runtime_get_sync() have been called. A later
rk_gmac_suspend() or rk_gmac_exit() still calls rk_gmac_powerdown():

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:rk_gmac_powerdown() {
    ...
	pm_runtime_put_sync(gmac->dev);

	rk_phy_powerdown(gmac);
	gmac_clk_enable(gmac, false);
}

Would a failed resume leave the runtime PM usage count and the
phy-supply regulator enable count unbalanced?

The new exits added here (the rk_get_phy_intf_sel() failure and the
default case) should not be reachable at resume, because probe has
already validated the interface. The clock enable, GRF write and
regulator enable failures can still happen.

[ ... ]

> @@ -1605,6 +1685,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
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
The commit message says out-of-band SGMII at 10/100 gives working TX and
failing RX, because the MAC clock is fixed at 125 MHz. Does anything in
the driver enforce or report that limit?

default_an_inband only states a preference. phylink_parse_mode() turns a
fixed-link node into MLO_AN_FIXED. A PHY whose phy_inband_caps() reports
only LINK_INBAND_DISABLE makes phylink_pcs_neg_mode() fall back:

drivers/net/phy/phylink.c:phylink_pcs_neg_mode() {
    ...
			neg_mode = PHYLINK_PCS_NEG_OUTBAND;
			if (pl->phydev)
				mode = MLO_AN_PHY;
    ...
}

For SGMII, xpcs_inband_caps() returns LINK_INBAND_DISABLE |
LINK_INBAND_ENABLE, so the PCS accepts the out-of-band fallback.

stmmac_mac_link_up() then sets the MAC to 10/100, and
xpcs_link_up_sgmii_1000basex() writes the speed into BMCR, but the clock
stays at 125 MHz. Would the link then report up while RX silently does
not work?

Could the driver reject out-of-band SGMII below 1000 Mbps, or at least
warn about it? fix_mac_speed() receives the mode and could do this, or
the MAC capabilities could be limited.

> +		plat_dat->pcs_init = rk_pcs_init;
> +		plat_dat->pcs_exit = rk_pcs_exit;
> +		plat_dat->select_pcs = rk_select_pcs;
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017054406.1828061-1-coiaprant%40gmail.com
