Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A034F3822A1;
	Fri, 25 Sep 2026 02:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301830; cv=none; b=gwQZjputP/FIp24a5u0R0+YFHqy3osqGk6viFqiI/8BVhXh+vqz/NLVofHkG/Au+WcYp5fdSL0RyFqCn+zjeVaW2Gm2VtJseMaZLPENhMSj0PjuOsRC2tnH/+CorxEZ8p2Ep5o2+y1cRGHkmG8K6zZrORKSS4bHz/e5txiuqpfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301830; c=relaxed/simple;
	bh=zhL7hF0bSF87fzhSKsFCpqWkLQyTR1/4ldpfM6gwJC4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m44OYHDffzmSf4R5zLdxmA7sHz/fTDLu3Ybgp01jZdNO2To8vf0AcovZnMpvZC4LnP/n17uTf1Mft3jgzaH0PYWFRvTIl/4Kz9RN1mK0bsPJrVzG3Cyg8gYyqprH9ue8rgnZ1RgCwCv5nR/TKhqm3b3kEjnJVZ15SJmVHnHmyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrZycPLl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrZycPLl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E861F00893;
	Fri, 25 Sep 2026 02:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301828;
	bh=AKeAUPt7DWxVIU4HGrAE1P8lK23xmc1gipQ4Q8H4QxM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PrZycPLlVqg2IuP7WqFFOgVm4B1Aq5VrFSkGPKr3we7KKYbpEGauYc5cw+RJvFWyH
	 zDP3urrTZxFKbfBbbZ8dHoyXfpSLUjhx/v5JigI264dNCR043Hiwdn+vn81UksRASK
	 SZdWionNcQif3LfaJ1J/jPmnhB0xJgwEa7MUTtbaCiE1k03/MuI8MHtS4a/U952IYZ
	 VBcy5/Rzfik2YRkmwGcCkxX/Q31yaElvDGLBTj2WG6zKRoOIfBxmJmSWHoBZ+rFD6o
	 wt1uqfMbVHN7EBOuRFoN3kkiPbCveNQWGyPoQ2W2jG3bgojui2fBVM1Z72N/4KvaTZ
	 L4yNu9vmrmj2w==
Subject: Re: [PATCH net-next v10 09/11] net: stmmac: dwmac-rk: add SGMII
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
 linux-renesas-soc@vger.kernel.org
Date: Fri, 25 Sep 2026 02:03:46 +0000
Message-ID: <179030182602.2160803.7636364487893366164@kernel.org>
In-Reply-To: <20260922200336.2201212-10-coiaprant@gmail.com>
References: <20260922200336.2201212-10-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In SGMII mode, the RK3568 glue tells phylink it supports
  interface modes that the hardware cannot run and that the glue never…
- [Medium] The commit's explanation of the SGMII in-band vs out-of-band
  problem does not match the code, and the driver does nothing to reject…

Pre-existing issues:
- [Medium] rk_gmac_resume() (dwmac-rk.c:1618-1627) calls
  rk_gmac_powerup() and throws away its return value, then always…
- [Medium] gmac_clk_enable(bsp_priv, true) (dwmac-rk.c:1181-1200) first
  enables the bulk clocks with clk_bulk_prepare_enable() (line 1187).
- [Medium] __stmmac_dvr_probe() calls pm_runtime_get_noresume(device) and
  enables runtime PM (stmmac_main.c:8112-8115) before calling…

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

This adds SGMII support for the RK3568 GMACs. It sets GRF bit 7 and
hooks up the Rockchip XPCS through the pcs_init, pcs_exit and select_pcs
callbacks. It also moves the clock enable in rk_gmac_powerup() earlier,
unifies its error unwinding, and for SGMII clears set_clk_tx_rate and
sets default_an_inband.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)

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
> +	of_node_put(pcs_node);
> +	if (IS_ERR(xpcs))
> +		return PTR_ERR(xpcs);

[Severity: Medium]
This is a pre-existing issue in the stmmac core, but this patch makes it
much easier to hit. rk_pcs_init() returns -EPROBE_DEFER from
xpcs_rk_create() whenever the XPCS device isn't bound yet. Does each of
those deferrals leak a runtime PM usage count?

__stmmac_dvr_probe() takes the reference before PCS setup:

    pm_runtime_get_noresume(device);
    pm_runtime_set_active(device);
    if (!pm_runtime_enabled(device))
        pm_runtime_enable(device);
    ...
error_pcs_setup:
    stmmac_mdio_unregister(ndev);
error_mdio_register:
    stmmac_napi_del(ndev);

None of the error labels drop that count or disable runtime PM.
pm_runtime_reinit() returns early while runtime PM is enabled, so
usage_count is never reset.

fw_devlink doesn't parse pcs-handle, so the GMAC can probe before the
XPCS. After the probe finally succeeds, the count can't reach zero, so
the MAC would never runtime suspend.

Deferral from stmmac_mdio_register() already hit this path before the
patch, but deferral is now likely on RK3568 SGMII boards.

> +
> +	priv->hw->xpcs = xpcs;
> +	return 0;
> +}
> +

[ ... ]

> +static struct phylink_pcs *rk_select_pcs(struct stmmac_priv *priv,
> +					 phy_interface_t interface)
> +{
> +	if (!priv->hw->xpcs)
> +		return NULL;
> +
> +	return xpcs_to_phylink_pcs(priv->hw->xpcs);
> +}

[Severity: Medium]
Does this give phylink interface modes that the RK3568 hardware can't
run?

rk_get_interfaces() still sets RGMII and RMII, because rk3568_ops now
has both set_to_rgmii and set_to_rmii. SGMII comes from the XPCS through
stmmac_phylink_setup():

    if (pcs)
        phy_interface_or(config->supported_interfaces,
                         config->supported_interfaces,
                         pcs->supported_interfaces);

xpcs_rk_create() uses the plain xpcs_create_mdiodev() and never narrows
pcs.supported_interfaces. The set is therefore filled from the generic
synopsys_xpcs_compat[] table: USXGMII, 10GKR, 25GBASER, XLGMII,
50GBASER, LAUI, 100GBASEP, 10GBASER, SGMII, 1000BASEX and 2500BASEX.

The rockchip,rk3568-xpcs.yaml binding in this series says the hardware
supports only 1000BASE-X, SGMII and QSGMII. The dwmac4 MAC caps include
MAC_2500FD, so phylink keeps 2500BASE-X and USXGMII as valid choices.

rk_select_pcs() also ignores its interface argument and returns the XPCS
for every mode. Neither the GRF nor the combphy is reprogrammed when the
interface changes: set_to_sgmii() runs once from the DT phy-mode, and
the combphy is fixed to PHY_TYPE_SGMII.

Now take an SFP cage, or a PHY that switches host interface, such as a
2.5G PHY moving between SGMII and 2500BASE-X. Could phylink pick
2500BASE-X or USXGMII, and xpcs_config() then program a mode the SerDes
and MAC clocking can't carry?

The same set is also copied into lpi_interfaces for EEE.

The in-tree Photonicat board uses a 1G PHY with a fixed SGMII interface,
so it isn't affected.

Could the RK3568 XPCS supported_interfaces be restricted, and
rk_select_pcs() return the PCS only for SGMII?

[ ... ]

> @@ -1379,16 +1449,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = gmac_clk_enable(bsp_priv, true);
> +	if (ret)
> +		return ret;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but the direct return here
only works if gmac_clk_enable() cleans up after itself. Does it?

gmac_clk_enable() {
    ...
        ret = clk_bulk_prepare_enable(bsp_priv->num_clks,
                                      bsp_priv->clks);
        if (ret)
            return ret;

        ret = clk_prepare_enable(bsp_priv->clk_phy);
        if (ret)
            return ret;
    ...
}

If clk_prepare_enable(bsp_priv->clk_phy) fails, the bulk clocks stay
enabled and clk_enabled stays false.

Every later gmac_clk_enable(bsp_priv, false) then returns early on the
clk_enabled check. That includes the new clk_disable label and
rk_gmac_powerdown(). Does this leak the enable counts of the bulk
clocks?

This only applies with an integrated PHY, because clk_phy is NULL
otherwise.

[ ... ]

> @@ -1447,15 +1517,20 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)

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
> @@ -1463,6 +1538,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
>  
>  	return 0;
> +
> +clk_disable:
> +	gmac_clk_enable(bsp_priv, false);
> +	return ret;
>  }

[Severity: Medium]
This is a pre-existing issue, but rk_gmac_resume() throws away the error
that this path returns:

    if (!device_may_wakeup(dev))
        rk_gmac_powerup(bsp_priv);

    return 0;

On the non-WoL resume path, a failure in rk_phy_powerup() takes the
clk_disable label, gates the GMAC clocks and returns an error. Nothing
sees that error.

stmmac_resume() checks the plat->resume return value, but gets 0 here.
Can it then go on to MDIO and MAC/DMA setup with pclk_mac and aclk_mac
disabled?

[ ... ]

> @@ -1602,6 +1681,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
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
Does the commit message's explanation of the in-band vs out-of-band
problem match the code? It says:

    Out-of-band mode does not work because the MAC would need to change
    the clock rate to 125/12.5/1.25 MHz for 1000/100/10 Mbps
    respectively, and the clock is fixed.

The clk_tx_i comment in include/linux/stmmac.h and
stmmac_set_clk_tx_rate() both give 125/25/2.5 MHz for 1000/100/10.

In stmmac_mac_link_up(), the negotiation mode is passed only to
plat->fix_mac_speed, which dwmac-rk doesn't set. The MAC speed
programming and the now-NULL set_clk_tx_rate call are the same in both
modes. The MAC therefore sees the same fixed 125 MHz clock whether
in-band or out-of-band is used.

The difference between the modes seems to be on the XPCS side: AN in
xpcs_config_aneg_c37_sgmii(), versus the fixed BMCR write in
xpcs_link_up_sgmii_1000basex():

    if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
        return;
    ...
    ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
                     mii_bmcr_encode_fixed(speed, duplex));

The commit message also says that fixed-link nodes, and PHYs without
in-band support, can still end up in out-of-band SGMII. TX then works
but RX fails at 10/100.

xpcs_inband_caps() returns this for SGMII:

    case DW_AN_C37_SGMII:
    case DW_AN_C37_1000BASEX:
        return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;

So phylink will accept out-of-band mode, and the glue neither rejects
nor reports it. Should rk_gmac_probe() refuse, or at least warn about, a
fixed-link or out-of-band SGMII setup, rather than bring the link up
with RX not working?

> +		plat_dat->pcs_init = rk_pcs_init;
> +		plat_dat->pcs_exit = rk_pcs_exit;
> +		plat_dat->select_pcs = rk_select_pcs;
> +	}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922200336.2201212-1-coiaprant%40gmail.com
