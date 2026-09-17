Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E34973AE;
	Thu, 17 Sep 2026 18:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670307; cv=none; b=pJleca6ZJizzm5nss7V3IlN3c0EBCQqlm1qbcywIhC7zVjVrZwY7xPtOopmqjuEY5k8IBQ6SPfGH7b8OekXsENPiAZNi7C/c6bkTD01mnt2ICG0y55hEQROeotZZ9aySNsQ1b2nYHj5KDibMusUgZ4MGiJi68Ph6cy1jtC2WoWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670307; c=relaxed/simple;
	bh=+qVy5uW2iNZM1Nqgrg72j2hDgwvl9ufIcWDUPo4hFj8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sTPKFVsr0cG82/psXY/bigRNU/+QY6SxBfAZoX81zFscIWJg7Yc+In+U4E9bKoLdlGd3XiGcRZH9DIDsrHAFv7Ur6hWyLcBQUCZlYD2A4btf0QLFED+Rn+rM7vxwx0mu1aMgSy69duavWHPnTPDSFW1jeck2+tsf7ykY4syYCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkgtji4L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkgtji4L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D67E1F00898;
	Thu, 17 Sep 2026 18:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670303;
	bh=GKVY4OCMvrTiVzCBvFsNx5/ahjJHyj+1OP3ea9KgS84=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bkgtji4Lbnpd/qM4sEAvLPLcun/gcqXAV73OnUmAXpPtyMHFSMYoE2AoY9O2tPOc/
	 L285o7So0KmjR5pxc/I2ClnGO1mFnr+PxtHpQlUCmNeQvyw8H9Jjry4f5nXztuHf5n
	 3I18BRYrQ0rwvfDwh4I+RTU6OxO7h7rZd+Sm3+F0nWj4rRzoNvCIGv42kke1bGP/si
	 X6Yc2uAR+uQy7rU4RwzctRE5oFsEYdE3wfrKjJ0BIaWp1h0JfUShohWYqlNjfzVtXL
	 ruQbpz6M3stvbtmPblj819pnAlomaq18gSkSo18A6fDnpyGJ5oS8H2Mhvhe1dgNZvO
	 tBxXT/1dadw0w==
Subject: Re: [PATCH net-next v6 09/11] net: stmmac: dwmac-rk: add SGMII
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
Date: Thu, 17 Sep 2026 18:38:22 +0000
Message-ID: <178967030209.22033.14039202439091501175@kernel.org>
In-Reply-To: <20260915123802.1561724-10-coiaprant@gmail.com>
References: <20260915123802.1561724-10-coiaprant@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 5

- [Medium] SGMII is advertised to phylink for every RK3568 GMAC port, but
  the SGMII PCS glue and the GRF SGMII mode bit are only wired up when…
- [Low] Claim: setting plat_dat->default_an_inband = true and clearing
  plat_dat->set_clk_tx_rate does not enforce in-band SGMII;…
- [Low] Claim: the new "phy-mode = sgmii implies pcs-handle" conditional
  in Documentation/devicetree/bindings/net/rockchip-dwmac.yaml is not…
- [Low] The XPCS node added to arch/arm64/boot/dts/rockchip/rk3568.dtsi
  (ethernet-pcs@fda00000, lines 113-142) omits `phys` and `phy-names`,…
- [Low] DWMAC_ROCKCHIP now does `select PCS_XPCS_ROCKCHIP` while having
  no PM dependency, and PCS_XPCS_ROCKCHIP…
- [Low] Claim: rk3568_set_to_sgmii() and rk3568_set_to_rmii() discard the
  regmap_write() status, so a failure to switch GRF CON1 bit 7 leaves…

Pre-existing issues:
- [Medium] gmac_clk_enable(bsp_priv, true) leaks the bulk clock
  prepare/enable references when clk_prepare_enable(bsp_priv->clk_phy)…

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

This adds SGMII glue for the RK3568 GMACs: a set_to_sgmii()/set_to_rmii()
pair that programs GRF CON1 bit 7, pcs_init/pcs_exit/select_pcs callbacks
that create the Rockchip XPCS, and default_an_inband plus a NULL
set_clk_tx_rate for SGMII.  rk_gmac_powerup() is also reordered so the
clocks are enabled before the interface-specific configuration, with the
error unwinding folded into one clk_disable label.

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

[Severity: Low]

Can this select produce an unmet dependency warning when PM is disabled?

DWMAC_ROCKCHIP only carries:

	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)

while the selected symbol in drivers/net/pcs/Kconfig is:

config PCS_XPCS_ROCKCHIP
	tristate "Rockchip XPCS controller support"
	default ARCH_ROCKCHIP
	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
	select GENERIC_PHY
	select PM_GENERIC_DOMAINS

and in kernel/power/Kconfig:

config PM_GENERIC_DOMAINS
	bool
	depends on PM

With PM=n (for example a COMPILE_TEST build with OF=y and STMMAC_ETH=m),
DWMAC_ROCKCHIP now force-enables PCS_XPCS_ROCKCHIP, which in turn
force-enables PM_GENERIC_DOMAINS against its own depends on PM, so genpd
gets built into a PM=n kernel.  Would a conditional select, or a depends
on, be more appropriate here?

Related: PCS_XPCS_ROCKCHIP lives inside the "if PCS_XPCS" block in
drivers/net/pcs/Kconfig, so it also carries depends on PCS_XPCS.  Does
DWMAC_ROCKCHIP need to select PCS_XPCS too, to avoid the same kind of
warning when PCS_XPCS=n?

>  	help
>  	  Support for Ethernet controller on Rockchip RK3288 SoC.
>  
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 8d7042e689261..b3d746dd966ff 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1330,6 +1395,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
>  
>  	bsp_priv->supports_rgmii = ops->supports_rgmii || !!ops->set_to_rgmii;
>  	bsp_priv->supports_rmii = ops->supports_rmii || !!ops->set_to_rmii;
> +	bsp_priv->supports_sgmii = ops->supports_sgmii || !!ops->set_to_sgmii;
>  
>  	if (ops->init) {
>  		ret = ops->init(bsp_priv);

[ ... ]

> @@ -1379,16 +1449,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>  
> +	ret = gmac_clk_enable(bsp_priv, true);
> +	if (ret)
> +		return ret;

[Severity: Medium]

This isn't a bug introduced by this patch, but since the clock handling in
this function is being reorganised: does gmac_clk_enable(bsp_priv, true)
leak the bulk clock prepare/enable references when the phy clock fails?

static int gmac_clk_enable(struct rk_priv_data *bsp_priv, bool enable)
{
	...
			ret = clk_bulk_prepare_enable(bsp_priv->num_clks,
						      bsp_priv->clks);
			if (ret)
				return ret;

			ret = clk_prepare_enable(bsp_priv->clk_phy);
			if (ret)
				return ret;
	...
			bsp_priv->clk_enabled = true;

On the second failure the bulk clocks stay prepared/enabled and
bsp_priv->clk_enabled is still false, so neither the bare return here nor
the new clk_disable label (which is gated on clk_enabled) undoes them.  A
later successful gmac_clk_enable(true) would then call
clk_bulk_prepare_enable() a second time.  Is it worth rolling the bulk
clocks back inside gmac_clk_enable() while this area is being touched?

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
>  	if (bsp_priv->gmac_phy_intf_sel_mask ||
>  	    bsp_priv->gmac_rmii_mode_mask) {
>  		/* If defined, encode the phy_intf_sel value */

[ ... ]

> @@ -1447,15 +1517,20 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  		if (bsp_priv->ops->set_to_rmii)
>  			bsp_priv->ops->set_to_rmii(bsp_priv);
>  		break;
> +	case PHY_INTERFACE_MODE_SGMII:
> +		dev_info(dev, "init for SGMII\n");
> +		if (bsp_priv->ops->set_to_sgmii)
> +			bsp_priv->ops->set_to_sgmii(bsp_priv);
> +		break;
>  	default:
>  		dev_err(dev, "NO interface defined!\n");
> +		ret = -EINVAL;
> +		goto clk_disable;
>  	}
>  
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
> @@ -1486,6 +1565,9 @@ static void rk_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
>  
>  	if (rk->supports_rmii)
>  		__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
> +
> +	if (rk->supports_sgmii)
> +		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
>  }

[Severity: Medium]

Is SGMII advertised more widely than the PCS glue is actually installed?

rk_gmac_setup() derives the capability purely from the ops table:

	bsp_priv->supports_sgmii = ops->supports_sgmii || !!ops->set_to_sgmii;

rk3568_ops now provides .set_to_sgmii, so supports_sgmii is true for every
rk3568 port and rk_get_interfaces() sets PHY_INTERFACE_MODE_SGMII in
config->supported_interfaces even for a port whose phy-mode is rgmii or
rmii.

The PCS side, however, is keyed off the probe-time phy-mode only (see the
rk_gmac_probe() hunk below), so on such a port priv->plat->select_pcs stays
NULL and no XPCS is ever created.  If phylink later picks SGMII out of
supported_interfaces (an SFP cage going through
phylink_sfp_select_interface(), or a PHY reporting
PHY_INTERFACE_MODE_SGMII), stmmac_mac_select_pcs() returns NULL:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_mac_select_pcs() {
	if (priv->plat->select_pcs) {
		pcs = priv->plat->select_pcs(priv, interface);
	...
}

so nothing rejects the selection.  Meanwhile rk_gmac_powerup() ran from the
probe-time bsp_priv->phy_iface, so GRF CON1 bit 7 was cleared by
rk3568_set_to_rgmii()/rk3568_set_to_rmii() and is never set, and
rk_set_clk_tx_rate() is still installed.  Would that leave the port with a
link that never comes up and no error reported?

Would gating the __set_bit(PHY_INTERFACE_MODE_SGMII, interfaces) on the same
condition that installs pcs_init/select_pcs, and programming the GRF mode
bit for the interface phylink actually selected, avoid this?

>  
>  static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
> @@ -1602,6 +1684,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
>  	plat_dat->suspend = rk_gmac_suspend;
>  	plat_dat->resume = rk_gmac_resume;
>  
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
> +		/* SGMII clock always runs at 125 MHz */
> +		plat_dat->set_clk_tx_rate = NULL;
> +
> +		/* SGMII requires a PCS */
> +		plat_dat->default_an_inband = true;
> +		plat_dat->pcs_init = rk_pcs_init;
> +		plat_dat->pcs_exit = rk_pcs_exit;
> +		plat_dat->select_pcs = rk_select_pcs;
> +	}
> +
>  	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
>  	if (IS_ERR(plat_dat->bsp_priv))
>  		return PTR_ERR(plat_dat->bsp_priv);

One more question, about the other patches in the same series rather than
this one:

[Severity: Low]

Does the xpcs node in arch/arm64/boot/dts/rockchip/rk3568.dtsi validate
against the new binding?  The binding
Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml has:

required:
  - compatible
  - reg
  - "#address-cells"
  - "#size-cells"
  - clocks
  - clock-names
  - phys
  - phy-names
  - power-domains

while the SoC-level node has neither phys nor phy-names:

	xpcs: ethernet-pcs@fda00000 {
		compatible = "rockchip,rk3568-xpcs";
		#address-cells = <1>;
		#size-cells = <0>;
		reg = <0x0 0xfda00000 0x0 0x200000>;
		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
		clock-names = "csr", "eee";
		power-domains = <&power RK3568_PD_PIPE>;
		status = "disabled";

Only rk3568-photonicat.dts adds them at board level, and dt-validate does
not skip nodes with status = "disabled", so would every other rk3568 board
report "'phys' is a required property" under CHECK_DTBS?  A board that
enables the node without adding both properties would also fail in
xpcs_rk_serdes_phy_init() -> devm_phy_get(dev, "serdes").

Would it be better to keep the PHY assignment optional in the binding, or to
move the properties into the SoC dtsi?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915123802.1561724-1-coiaprant%40gmail.com
