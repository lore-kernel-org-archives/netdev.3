Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD3942D76A;
	Mon, 12 Oct 2026 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791831695; cv=none; b=i0bvRxO0acda0E0v/rj48t2yhVmyzLrIYx7yDIHl8YsrUAeRn5MYHTRjTd8qpBnT/eAO/+griP5TIBLeb6LpX67m7ZviDuvH3tf3FkZ8ILh3ulG/vQI7mAcYkyEIWj+5MgQ0MvhK17fY+trRZgsSr4r5kLEl+kglN+AohzbErzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791831695; c=relaxed/simple;
	bh=gFo9jUKtwIPXzvk1R06zHETr5hf/6Zn/nl484TE4/Kw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNbk4CBA4da8lj0Ek4JZs38w8x51eqirAPJhqYfE/Qxbzd+2fjmcPyLiGECZ1biz8acrFquG1p1CXP6fIs4XJG+wau1+BlSCAzrFx4AOAJdsxs21nym33EpELYpu8K1nLb6JGjqpBVp3JuTZNmYvE9aMsg5ZXjV6IFpW5qDM5QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkuFbAYL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkuFbAYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8651F008A2;
	Mon, 12 Oct 2026 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791831693;
	bh=Z9ey7sNL/x21eVb/g8qDoP/BFyldS7kgl36eyRGCz3s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YkuFbAYL5Oy+nSNiM7nfxMPeXGKXvKrouAt2zguT82diEzQtgl/2J1zm7YdTKTH8s
	 w8WEoubBkZ/wyOO/11kN9S6VOjDH82/5PxpSGlOOtvEQff5C0DIrmpFsTmq4O9oPQB
	 Qk8x3DJ/iBXcQmHUSWJZbi93qLjzysI92dos3aRvi207qSDKHKurXg75zqwujAPnd0
	 GPU+DfjVnPJf/97+GDZmSzKYlY8ieEhD9JAgQE8V5lhu75QnzLr0eYZQtmRB/I7Ud+
	 m2T0QnkEBT6tuyFouzRT/5Z7yce4ALBRpQO0JtanxOGM6UzdS3WtmjeZIkdVsdHRrt
	 vPjFSx11n3OZQ==
Subject: Re: [PATCH net-next v11 5/6] net: stmmac: dwmac-rk: add SGMII support
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
Date: Mon, 12 Oct 2026 19:01:32 +0000
Message-ID: <179183169209.434549.3228016772295700509@kernel.org>
In-Reply-To: <20261008175225.3375274-6-coiaprant@gmail.com>
References: <20261008175225.3375274-6-coiaprant@gmail.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says "1000BASE-X is not enabled by this
  series" and that SGMII "comes from the XPCS's own…
- [Medium] On an SGMII-configured RK3568, rk_get_interfaces() still
  advertises RMII and all four RGMII variants: supports_rgmii comes from…
- [Medium] For RK3568 SGMII, rk_gmac_probe() sets
  `plat_dat->set_clk_tx_rate = NULL` and only sets `default_an_inband =…

--

net: stmmac: dwmac-rk: add SGMII support for RK3568

This patch adds SGMII support to the RK3568 dwmac glue. It routes the GMAC
to the integrated Synopsys XPCS through a GRF bit, creates the XPCS with
xpcs_rk_create() in new pcs_init/pcs_exit callbacks, and returns it from
select_pcs. It also moves the clock enable earlier in rk_gmac_powerup(),
and for SGMII it forces in-band negotiation with a fixed 125 MHz MAC clock.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 72bdbcb5e863a..c4db919ec1640 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

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
rk_select_pcs() ignores its interface argument and returns the XPCS for
every mode. Is this statement in the commit message accurate?

  "1000BASE-X is not enabled by this series"

rk_pcs_init() creates a generic DW XPCS through xpcs_rk_create(). Then
xpcs_create() fills the PCS supported_interfaces from the matched compat
table:

drivers/net/pcs/pcs-xpcs.c:xpcs_get_interfaces() {
    ...
	for (compat = xpcs->desc->compat; compat->supported; compat++)
		__set_bit(compat->interface, interfaces);
    ...
}

For a Synopsys ID, synopsys_xpcs_compat[] lists SGMII, 1000BASEX,
2500BASEX, USXGMII and the 10G and faster modes. stmmac_phylink_setup()
then merges all of them into phylink's supported set:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_phylink_setup() {
    ...
	if (pcs)
		phy_interface_or(config->supported_interfaces,
				 config->supported_interfaces,
				 pcs->supported_interfaces);
    ...
}

The 1G MAC capabilities filter out the faster modes, but 1000BASE-X still
passes validation. Phylink can select it at runtime, for example through
phylink_sfp_config_optical() for a fibre SFP, or for a PHY that switches
its host interface.

rk_gmac_check_ops() and rk_gmac_powerup() only check the static DT
phy_iface, so the glue never validates or configures this mode.

Is there something meant to stop phylink from choosing 1000BASE-X on this
port, so that the SGMII-only behaviour in the commit message is actually
enforced?

[Severity: Medium]
On an RK3568 configured for SGMII, rk_get_interfaces() still advertises
RMII and the RGMII variants. supports_rgmii comes from set_to_rgmii, and
supports_rmii now comes from the new rk3568_set_to_rmii. rk_select_pcs()
returns the XPCS for those parallel modes as well.

What happens when phylink validates the whole supported_interfaces mask?
One example is phylink_validate() with PHY_INTERFACE_MODE_NA, which
phylink_validate_phy() uses for a C45 PHY without rate matching or
possible_interfaces:

drivers/net/phy/phylink.c:phylink_validate_mac_and_pcs() {
    ...
		if (!phy_interface_empty(pcs->supported_interfaces) &&
		    !test_bit(state->interface, pcs->supported_interfaces)) {
			phylink_err(pl, "MAC returned PCS which does not support %s\n",
    ...
}

Would this log an error and return -EINVAL for each RGMII and RMII mode on
that port? Should rk_select_pcs() return NULL for interfaces the XPCS does
not support?

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
default_an_inband only sets a default here. With set_clk_tx_rate cleared,
does anything prevent out-of-band operation at 10/100 Mb/s?

A fixed-link node overrides default_an_inband in phylink_parse_mode().
Phylink can also fall back to out-of-band when the PHY reports only
LINK_INBAND_DISABLE, because the XPCS allows that:

drivers/net/pcs/pcs-xpcs.c:xpcs_inband_caps() {
    ...
	case DW_AN_C37_SGMII:
	case DW_AN_C37_1000BASEX:
		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
    ...
}

In that case stmmac_mac_link_up() sets the MAC speed bits and
xpcs_link_up_sgmii_1000basex() writes the speed into BMCR, but the MAC
clock stays at 125 MHz. The commit message says this "gives working TX and
failing RX" and that "Boards must use in-band mode".

The driver does not reject out-of-band mode, does not limit the MAC
capabilities to 1000 Mb/s in that mode, and does not log anything. Can the
link then come up at 10/100 with a broken receive path and no warning?

> +		plat_dat->pcs_init = rk_pcs_init;
> +		plat_dat->pcs_exit = rk_pcs_exit;
> +		plat_dat->select_pcs = rk_select_pcs;
> +	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008175225.3375274-1-coiaprant%40gmail.com
