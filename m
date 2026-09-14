Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754D249DBAC;
	Mon, 14 Sep 2026 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417497; cv=none; b=sYiPenKhCxRN0uHE0Bqp76KeeLrxPrAZygh4gaMPHuWO4/FGOTZgX2JF6dXqqk2B9e243UKZesodpfUEBSl0+bTT2NWbmqI4Nsh5tsqlMQe/NkYH+yIfSYzku3RRFCyNe9KL9tnJEs1t4F/0vDpHc+X/Q1PW1Xv/OhAk77XlNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417497; c=relaxed/simple;
	bh=K+eVhqt7YxsQ8Q2OOisrdkJG+6p9AlEiBY4wXxo3QWQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RXARn5JHG0dwxxdfEZ9EabyhMusA0ad0qHedquH3Z9/67LdLgiB7ps51QW7PXefW/NV4G5a4BV+BKNVPMSNbB8Sm7krZWTqae/BAlRXlmn4alIoImF9evpooX5t/sWQ8CzMRYRa6ah8vKJD5+NMDvjCm0cSeJaVNZFD8m2Gn70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmheNl2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmheNl2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343821F000FF;
	Mon, 14 Sep 2026 20:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417493;
	bh=EdUGey0Y6fUygZcO3oI/pgasXv1LbqpF456UVNPI0RY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KmheNl2HmKbF7QozkgpVRgt69X5wdGL7cLO/skh5x+3JrNIJd3gG5muta106qbdx/
	 mrPtYOlO1vnbXtrFdsb21CPmp5GhsUa0Sg3LGwwRi7fPT9pgsHsabJIBW8JkUMUONd
	 sXCLPRDWCdHXo062eN76E/tFT9x4dRBrX1+FDT/PhzBmp7nmAKe1M+xwzULRk/TPbt
	 qd4WgeUgaqGYgUj0XIKQxauSUnaGyTdLGnJ2yr3sM1wlI23GB3jHf5NiJsXkHSJLv8
	 QpIC6nL/1m7H82LgjNg9Jd78DoPCj09tdA+NFKfCa6exzE8P2HTURFTmhXeEyrZUlk
	 HhNlo2ZEk5ezw==
Subject: Re: [PATCH net-next v5 09/11] net: stmmac: dwmac-rk: add SGMII
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
Date: Mon, 14 Sep 2026 20:24:51 +0000
Message-ID: <178941749179.22033.3182687831989800376@kernel.org>
In-Reply-To: <20260913185849.907479-10-coiaprant@gmail.com>
References: <20260913185849.907479-10-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 3

- [Medium] DWMAC_ROCKCHIP gains an unconditional `select
  PCS_XPCS_ROCKCHIP` without inheriting the selected symbol's…
- [Medium] For SGMII the driver removes every speed-dependent clock
  programming path (rk_gmac_probe() sets plat_dat->set_clk_tx_rate =…
- [Low] rk_get_interfaces() (dwmac-rk.c:1570-1571) now sets
  PHY_INTERFACE_MODE_SGMII in phylink's supported_interfaces for every…
- [Low] The RK3568 XPCS SoC node added by the series ('arm64: dts:
  rockchip: rk3568: add XPCS and fixed-clock nodes') omits properties…
- [Low] rk_select_pcs() (dwmac-rk.c:1268-1275) ignores its `interface`
  argument and returns the SGMII XPCS for every interface mode,…

Pre-existing issues:
- [Medium] DISCARDED (valid but pre-existing and below the reporting
  threshold for pre-existing defects).

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

Adds a set_to_sgmii()/set_to_rmii() pair for rk3568 to program GRF bit 7,
wires up pcs_init/pcs_exit/select_pcs so the Rockchip XPCS is used as the
PCS, and reorders rk_gmac_powerup() so the clocks are enabled before the
interface-specific configuration.

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
Does this select produce unmet dependency warnings?  PCS_XPCS_ROCKCHIP in
drivers/net/pcs/Kconfig carries three dependency lines:

  config PCS_XPCS_ROCKCHIP
	tristate "Rockchip XPCS controller support"
	default ARCH_ROCKCHIP
	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
	depends on GENERIC_PHY || COMPILE_TEST
	depends on PM_GENERIC_DOMAINS || COMPILE_TEST

while DWMAC_ROCKCHIP only has "depends on OF && (ARCH_ROCKCHIP ||
COMPILE_TEST)".  ARCH_ROCKCHIP in arch/arm64/Kconfig.platforms selects PM
but neither GENERIC_PHY nor PM_GENERIC_DOMAINS, so a config with
ARCH_ROCKCHIP=y, COMPILE_TEST=n and GENERIC_PHY=n (or PM_GENERIC_DOMAINS=n)
force-enables PCS_XPCS_ROCKCHIP with its own depends unsatisfied:

  WARNING: unmet direct dependencies detected for PCS_XPCS_ROCKCHIP

pcs-xpcs-rk.o is then built against the phy stubs where devm_phy_get()
returns ERR_PTR(-ENOSYS), so the probe cannot succeed.

The select is also unconditional, so every Rockchip dwmac build
(RK3288/RK3328/RK3399/RK3588 ...) force-enables the RK356x-only XPCS
driver.  Would inheriting the constraints, or making the selection
conditional, be preferable here?  Note that simply adding the two depends
lines to DWMAC_ROCKCHIP would turn off Ethernet on existing RK3288/RK3399
configurations, so the choice probably needs to be explicit.

The Kconfig change is also not mentioned anywhere in the commit message.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e689261..5d501ed8d1429 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1208,6 +1237,43 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
> +static struct phylink_pcs *rk_select_pcs(struct stmmac_priv *priv,
> +					 phy_interface_t interface)
> +{
> +	if (!priv->hw->xpcs)
> +		return NULL;
> +
> +	return xpcs_to_phylink_pcs(priv->hw->xpcs);
> +}

[Severity: Low]
Should rk_select_pcs() look at its interface argument?  The mac_select_pcs
contract in include/linux/phylink.h is to return the PCS for the specified
interface, or NULL when none is required, but this returns the SGMII XPCS
for any mode.

On an RK3568 port probed as SGMII, rk_get_interfaces() also advertises the
RGMII variants and RMII, and xpcs->pcs.supported_interfaces is non-empty
(filled in by xpcs_get_interfaces()).  When phylink validates one of those
non-SGMII interfaces, phylink_validate_mac_and_pcs() hits:

	if (!phy_interface_empty(pcs->supported_interfaces) &&
	    !test_bit(state->interface, pcs->supported_interfaces)) {
		phylink_err(pl, "MAC returned PCS which does not support %s\n",
			    phy_modes(state->interface));
		return -EINVAL;
	}

Would returning the XPCS only for PHY_INTERFACE_MODE_SGMII and NULL
otherwise avoid that error path?

> @@ -1379,16 +1450,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = gmac_clk_enable(bsp_priv, true);
> +	if (ret)
> +		return ret;
> +

[Severity: Medium]
This isn't a bug introduced by this patch, but now that gmac_clk_enable()
is the first resource acquisition in rk_gmac_powerup(), its partial-failure
path becomes more visible.  Do the bulk clocks leak when the clk_phy enable
fails?

drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c:gmac_clk_enable() {
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

The second failure returns without calling clk_bulk_disable_unprepare() and
without setting bsp_priv->clk_enabled, so the later gmac_clk_enable(bsp_priv,
false) in rk_gmac_powerdown() and at the new clk_disable label is a no-op
because it is gated on clk_enabled.  This only triggers for integrated-PHY
setups where clk_phy is non-NULL.

> +	if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_SGMII)
> +		goto set_mode;
> +
>  	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
>  	if (ret < 0)
> -		return ret;
> +		goto clk_disable;

[ ... ]

> @@ -1486,6 +1566,9 @@ static void rk_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
>  
>  	if (rk->supports_rmii)
>  		__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
> +
> +	if (rk->supports_sgmii)
> +		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
>  }

[Severity: Low]
Is SGMII safe to advertise on a port that was not probed as SGMII?
rk3568_ops populates set_to_sgmii unconditionally, and rk_gmac_setup()
derives supports_sgmii from it, so every RK3568 port now advertises SGMII
in phylink's supported_interfaces (stmmac_phy_setup() copies the
get_interfaces() output verbatim into config->supported_interfaces).

All the SGMII setup, though, is keyed off the probe-time DT phy-mode:

  - rk_gmac_powerup() writes RK3568_GMAC_MODE_SGMII_QSGMII only in the
    "case PHY_INTERFACE_MODE_SGMII:" branch, which runs once at init
  - rk_gmac_probe() installs pcs_init/pcs_exit/select_pcs,
    default_an_inband and clears set_clk_tx_rate only under
    "if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII)"

So on a port probed as rgmii*/rmii, if phylink later selects SGMII (SFP
cage, or a PHY reporting SGMII as its host interface), GRF bit 7 stays
cleared by rk3568_set_to_rgmii()/rk3568_set_to_rmii(), plat->select_pcs is
NULL so stmmac_mac_select_pcs() returns NULL and there is no PCS to run
autonegotiation.  Before this patch SGMII was not in supported_interfaces
and such a configuration was rejected during validation.  Would gating the
__set_bit() on the probe-time interface be closer to what the hardware can
actually do?

> @@ -1602,6 +1685,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
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
The commit message says:

  "Enable default_an_inband for SGMII and disable the generic stmmac
   set_clk_tx_rate callback.  This forces phylink to use in-band mode,
   where the PCS is responsible for speed/duplex negotiation."

Is "forces" accurate?  default_an_inband is only a default, and the next
paragraph of the message says so itself.  In phylink_parse_mode():

	if (pl->config->default_an_inband)
		pl->cfg_link_an_mode = MLO_AN_INBAND;

	dn = fwnode_get_named_child_node(fwnode, "fixed-link");
	if (dn || fwnode_property_present(fwnode, "fixed-link"))
		pl->cfg_link_an_mode = MLO_AN_FIXED;

and xpcs_inband_caps() advertises out-of-band as acceptable:

	case DW_AN_C37_SGMII:
	case DW_AN_C37_1000BASEX:
		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;

so phylink_pcs_neg_mode() can settle on PHYLINK_PCS_NEG_OUTBAND for a
fixed-link node or a PHY without in-band support.  With set_clk_tx_rate set
to NULL, rk3568_ops.set_speed = rk_set_clk_mac_speed also becomes
unreachable, so a 10/100 Mbps link is brought up with the clocking left at
the 1 Gbps setting and nothing warns or fails.  Would rejecting a
non-inband neg_mode (for example in mac_config or pcs_validate), or failing
probe when a fixed-link node is present for SGMII, match what the message
describes?

One more observation on the series rather than on this patch: the new
binding Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
lists phys and phy-names in its unconditional required list, but the
ethernet-pcs@fda00000 node added to arch/arm64/boot/dts/rockchip/rk3568.dtsi
supplies only reg, clocks, clock-names and power-domains.  Only
rk3568-photonicat.dts adds them:

  &xpcs {
	phys = <&combphy2 PHY_TYPE_SGMII>;
	phy-names = "serdes";
	status = "okay";
  };

[Severity: Low]
Does dtbs_check report "phys is a required property" for the other RK3568
board DTBs?  dtschema validates nodes regardless of status = "disabled".
The neighbouring sata0 node in the same dtsi does carry phys/phy-names at
SoC level, so would moving them into rk3568.dtsi be an option?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
