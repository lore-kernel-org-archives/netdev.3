Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8250A471CE7;
	Mon, 21 Sep 2026 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034241; cv=none; b=VhQq4+fF72zQOfbl30S6zAWESWowfSoUtbTR5ctU0c+ZHDL6k+DMYFko8BfwLP0KU0hiZdAc3i7L4Lg5SGRId37qgvXDqAjZN9dMtRZVtlCZdJsYAUzAwZ+djs+hQc45tbkrHByzQisfB/B/+rjo2EPEDqQQ3/9GP3nrtMiI+mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034241; c=relaxed/simple;
	bh=j5z82ekZOpCGSPbPLymg/OC1+Snq9VeDF0CPgn6/j5U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cTfigGqkRDISWk91lRN9KPNOAuyyOIY9keAGJstwBVcjXz2atzu5meOH2Vy4exiaPFVCXtwUC9mAvnbhmJPTqPbpH7Aw1Mnys/M51nALSmiHtkVM8MAEmbPpSAFyAmf83mlRll6RkQp3MBrqacZppkhsDBUpGJeee+heFzAqTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvvzkRmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvvzkRmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49C51F000FF;
	Mon, 21 Sep 2026 23:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034234;
	bh=a7lkRrvYeH/7Efr4hVD8J5zbD41Zcx51wpx+R8IFjW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WvvzkRmEYZoEvuh/9yFInp1ZKcrAHJNsq73aC3o7qXFRK08luN0M4esDGMme2VVnT
	 pLmdXUFbNCK0uXwwbOB5wG5RAcY1VMF6OaR4VLPVyOodI2W30psUBvRoUcAuf5NOBG
	 7U4kxMu9bWKFC+UtJyQRVTxABZBBl9Lx9UOoVW1NvIohc79hux5awWsnQIlRESmXzd
	 NbLKsWaY71HixQXZ2GcIHbGqxxif7splOkUlkkKYihaFj2E52CAuXpKV79ctbd9t76
	 9Lu1Sa8/wx3yNOfojXH1Ezmfx1L/2cfmG13iKYYcWqrtNKk7pvhJiBnqo41l8E36JW
	 i7Yy6UgQMcXWA==
Subject: Re: [PATCH net-next v7 09/11] net: stmmac: dwmac-rk: add SGMII
 support for RK3568
From: netdev-bot+sashiko@kernel.org
To: coiaprant@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, vkoul@kernel.org,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
 romain.gantois@bootlin.com, hkallweit1@gmail.com, neil.armstrong@linaro.org,
 linux@armlinux.org.uk, shawn.lin@rock-chips.com, david@ixit.cz,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-renesas-soc@vger.kernel.org
Date: Mon, 21 Sep 2026 23:43:52 +0000
Message-ID: <179003423242.2160803.8657739871681383034@kernel.org>
In-Reply-To: <20260917204624.2427486-10-coiaprant@gmail.com>
References: <20260917204624.2427486-10-coiaprant@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 3 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Kconfig dependency propagation violation: the new `select
  PCS_XPCS_ROCKCHIP` in DWMAC_ROCKCHIP…
- [Medium] Out-of-band SGMII, which the commit message itself declares
  unsupported on RK3568 ("Out-of-band SGMII is not supported by this…
- [Medium] xpcs_rk_create() (drivers/net/pcs/pcs-xpcs-rk.c), which the
  new rk_pcs_init() callback in dwmac-rk.c invokes, justifies its access…
- [Low] Reported for completeness (retained per validation policy, but
  disproved for the supported configuration): the concern is that for…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  gmac_clk_enable(bsp_priv, true)…

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

This adds SGMII glue to dwmac-rk for RK3568: a set_to_sgmii() GRF callback,
an explicit rk3568 set_to_rmii(), and pcs_init/pcs_exit/select_pcs hooks that
create the Rockchip XPCS.  rk_gmac_powerup() is reordered so the clocks are
enabled before the SGMII path, with error unwinding unified into one label.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> index ab3c4cf964239..c6559e749c0ce 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> @@ -170,6 +170,7 @@ config DWMAC_ROCKCHIP
>  	default ARCH_ROCKCHIP
>  	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
>  	select MFD_SYSCON
> +	select PCS_XPCS_ROCKCHIP

[Severity: Medium]
Can this select produce an unmet dependency warning on COMPILE_TEST builds?

DWMAC_ROCKCHIP is buildable via "depends on OF && (ARCH_ROCKCHIP ||
COMPILE_TEST)", and PCS_XPCS_ROCKCHIP in drivers/net/pcs/Kconfig does:

	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
	select GENERIC_PHY
	select PM_GENERIC_DOMAINS

while kernel/power/Kconfig has:

	config PM_GENERIC_DOMAINS
		bool
		depends on PM

The commit message says "PM is selected by ARCH_ROCKCHIP, so no further
selects are needed", but on a non-Rockchip architecture with CONFIG_PM=n
nothing selects PM, so the chain force-enables PM_GENERIC_DOMAINS with its
direct dependency unmet:

  WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS
    Depends on [n]: PM [=n]
    Selected by [y]:
    - PCS_XPCS_ROCKCHIP [=y]

The rest of the tree uses either "select PM_GENERIC_DOMAINS if PM"
(drivers/pmdomain/arm, bcm, mediatek, ti) or "depends on PM" first
(actions, imx, qcom, sunxi, xilinx).  Would one of those forms work here,
for instance "select PCS_XPCS_ROCKCHIP if ARCH_ROCKCHIP"?

Separately, the select is unconditional for every Rockchip dwmac SoC even
though only RK3568 has the XPCS, so all Rockchip configurations now pull in
the XPCS driver and genpd.  Is that intended?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e689261..88f09014e3a69 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1208,6 +1236,43 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
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
This is the first in-tree caller of xpcs_rk_create(), and that helper
justifies its access to supplier-owned data with a comment saying
"device_link_add() refuses to create a managed link while the supplier is
being unbound, so if it succeeds the drvdata cannot be freed under us".

Is that guarantee real?  device_link_init_status() in drivers/base/core.c
accepts a supplier that is already unbinding:

	case DL_DEV_UNBINDING:
		link->status = DL_STATE_SUPPLIER_UNBIND;
		break;

and device_link_add() itself has no unbinding check.  Since fw_devlink has
no parser for pcs-handle (no match for "pcs-handle" in
drivers/of/property.c), no managed link exists beforehand, so
device_links_busy() sees no consumer link in DL_STATE_CONSUMER_PROBE or
DL_STATE_ACTIVE, returns false and sets the supplier to DL_DEV_UNBINDING:

	dev->links.status = DL_DEV_UNBINDING;

__device_release_driver() then proceeds into remove()/devres_release_all()
concurrently with this probe.  Can the subsequent platform_get_drvdata(),
pxpcs->bus dereference and xpcs_create_mdiodev(pxpcs->bus, port) in
xpcs_rk_create() then touch devm memory and an mii_bus that have already
been released, given that drvdata is cleared only after
devres_release_all()?  The put_device() and NULL checks there do not
serialise against unbind.

> +	of_node_put(pcs_node);
> +	if (IS_ERR(xpcs))
> +		return PTR_ERR(xpcs);
> +
> +	priv->hw->xpcs = xpcs;
> +	return 0;
> +}

[ ... ]

> @@ -1379,16 +1449,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = gmac_clk_enable(bsp_priv, true);
> +	if (ret)
> +		return ret;

[Severity: Medium]
This isn't a bug introduced by this patch, but the helper being moved here
can leave the bulk clocks enabled on error.  In gmac_clk_enable():

	ret = clk_bulk_prepare_enable(bsp_priv->num_clks,
				      bsp_priv->clks);
	if (ret)
		return ret;

	ret = clk_prepare_enable(bsp_priv->clk_phy);
	if (ret)
		return ret;

If clk_prepare_enable(bsp_priv->clk_phy) fails, the successful
clk_bulk_prepare_enable() is not unwound and bsp_priv->clk_enabled stays
false, so the new clk_disable label here and rk_gmac_powerdown() both
become no-ops and the enable counts stay unbalanced.  The bare "return ret"
at this call site is fine since nothing else has been acquired yet; the
imbalance is inside the unchanged helper.  Would it be worth fixing that
separately?

> +
> +	if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_SGMII)
> +		goto set_mode;
> +
>  	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
>  	if (ret < 0)
> -		return ret;
> +		goto clk_disable;
>  
>  	intf = ret;
>  
> -	ret = gmac_clk_enable(bsp_priv, true);
> -	if (ret)
> -		return ret;
> -

[ ... ]

> @@ -1602,6 +1681,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
>  	plat_dat->suspend = rk_gmac_suspend;
>  	plat_dat->resume = rk_gmac_resume;
>  
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> +		/* SGMII clock always runs at 125 MHz */
> +		plat_dat->set_clk_tx_rate = NULL;

[Severity: Low]
This isn't a bug for the boards in this series, but the comment is only true
because of device tree.  Clearing set_clk_tx_rate makes
rk_set_clk_mac_speed()/rk3568_ops.set_speed unreachable, and
rk3568_set_to_sgmii() only writes GRF bit 7, so nothing in the driver
programs SCLK_GMACx_RX_TX.  The 125 MHz comes from the fixed
clk_gmac0_xpcs_mii / clk_gmac1_xpcs_mii clocks added to rk3568.dtsi, which
match the third parent of:

drivers/clk/rockchip/clk-rk3568.c:
	MUX(SCLK_GMAC0_RX_TX, "clk_gmac0_rx_tx", mux_gmac0_rx_tx_p,  CLK_SET_RATE_PARENT,
			RK3568_CLKSEL_CON(31), 0, 2, MFLAGS),

and are selected by the board DT:

	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>;
	assigned-clock-parents = <&clk_gmac0_xpcs_mii>;

which of_clk_set_defaults() applies from platform_probe() before
rk_gmac_probe() runs.  The rockchip-dwmac binding does not require that
assignment for phy-mode = "sgmii", so a DT that omits it would silently
mis-clock the MAC.  Could the binding require it, and could the comment say
where the 125 MHz actually comes from?

> +
> +		/* SGMII requires a PCS */
> +		plat_dat->default_an_inband = true;

[Severity: Medium]
The commit message states:

  "Out-of-band SGMII is not supported by this driver: the MAC clock would
  stay at 125 MHz for 10/100 Mbps, giving working TX but failing RX.
  Boards must use in-band mode"

Is that requirement enforced anywhere?  Nothing here rejects or warns about
out-of-band operation; default_an_inband is only a default, and
phylink_parse_mode() overrides it unconditionally:

drivers/net/phy/phylink.c:phylink_parse_mode() {
	...
	dn = fwnode_get_named_child_node(fwnode, "fixed-link");
	if (dn || fwnode_property_present(fwnode, "fixed-link"))
		pl->cfg_link_an_mode = MLO_AN_FIXED;
	...
}

The XPCS also advertises out-of-band as usable, so phylink capability
negotiation will not block it either:

drivers/net/pcs/pcs-xpcs.c:xpcs_inband_caps() {
	case DW_AN_C37_SGMII:
	case DW_AN_C37_1000BASEX:
		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
}

With set_clk_tx_rate cleared just above, stmmac never calls
rk_set_clk_mac_speed(), so no speed-dependent clock programming happens at
all in that case.  The new RK3568 SGMII condition in
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml requires only
pcs-handle:

        phy-mode:
          contains:
            const: sgmii
    then:
      required:
        - pcs-handle

so a DT with phy-mode = "sgmii" plus fixed-link validates cleanly and gives
a link that comes up but fails RX at 10/100 with no diagnostic.  Should the
driver reject or at least warn on non-in-band SGMII, or should the binding
require managed = "in-band-status" and exclude fixed-link?

> +		plat_dat->pcs_init = rk_pcs_init;
> +		plat_dat->pcs_exit = rk_pcs_exit;
> +		plat_dat->select_pcs = rk_select_pcs;
> +	}
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
