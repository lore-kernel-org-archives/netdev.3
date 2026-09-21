Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F264D1794;
	Mon, 21 Sep 2026 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034227; cv=none; b=NX4p2ZDnXJBezOsvBMwOX/6hh13yTztKDe/AGj94adMGheg4UJ3eJjHu64aq8fqVYFCE4y1s+NdhYYb46xY4OtL8kVvMcZNRkGmioBRnGyZABoBU2kgUKUz56DSyUpy7D6+fRv7I2e9E1ta3azIs05/DGugQL9InKcqJTuQ8plU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034227; c=relaxed/simple;
	bh=nvYzSHGL2j6+IugrscNC87R1PSohdgPOnRoUuLjj1/U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gsE+6CfbsCWluZQKifapVBabrQo4NtkeHiumSxPsiXagayQR7WLtCTX8G3QISvV2qf9pCbsTt0jOAEgSN9LItPmN1p0Kf+6+/dl9+g2afVQFacIbSuLyDR0p0KS+2PwaOciTDRDPwN9jAVqA8RQ2wKhPBYkQZkISQ63x/q3nBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUVoMUvB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUVoMUvB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ACD1F00893;
	Mon, 21 Sep 2026 23:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034225;
	bh=KvByGjKnRAXGzZ68wxhXamqWMqdGOJxOiVrrjTHeQFA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aUVoMUvBr4ZtRVG+InVPuvggrEWXJyGljvOrWxJ3Y02XF+XuwUaBuGjJ8jxtRFHEY
	 5QvOGWacDv1FD7zwfYAemu/R/+gqmZwLK2Wg2Zxb03T24XGax7XSH58fyZ6v+QYGyw
	 F406kjTkSxQc4Sf8PBW9XjdPmERh+JbQ+JKK/xVhkJQJMrflnUe8WGnLeVKmdUFC1r
	 BlkZdXB+UZMWkYNnrwX4p4oCPpn6H8ZVtzhHCJFoK1GpQCVb/yfnKMNGYMVh7WIoCb
	 xhGAOs7x62bBfI8C4tEMGaNiZrgBwpqBpyx2/kVKWvIWxJRI04nMfT/qoams0e4nGH
	 MsF5VjbQoh+XQ==
Subject: Re: [PATCH net-next v7 05/11] arm64: dts: rockchip: rk3568: add XPCS
 and fixed-clock nodes
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
Date: Mon, 21 Sep 2026 23:43:43 +0000
Message-ID: <179003422374.2160803.9758022128641976437@kernel.org>
In-Reply-To: <20260917204624.2427486-6-coiaprant@gmail.com>
References: <20260917204624.2427486-6-coiaprant@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new `xpcs: ethernet-pcs@fda00000` node in
  arch/arm64/boot/dts/rockchip/rk3568.dtsi omits `phys` and `phy-names`,…
- [Low] Concern as raised: the patch advertises `rockchip,rk3568-xpcs`
  and four ethernet-pcs-mii child nodes for which no driver or Rockchip…

--

arm64: dts: rockchip: rk3568: add XPCS and fixed-clock nodes

This adds the RK3568 XPCS node at 0xfda00000 with four ethernet-pcs-mii
sub-nodes, all disabled by default, plus two 125 MHz fixed-clock nodes whose
clock-output-names match the CRU mux parents so boards can reparent
SCLK_GMAC0_RX_TX / SCLK_GMAC1_RX_TX.

A couple of questions below about the omitted phys/phy-names and about the
commit message statement that justifies the omission.

> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 3bc653f027f1f..227d03e336043 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -110,6 +110,51 @@ sata0: sata@fc000000 {
>  		status = "disabled";
>  	};
>  
> +	xpcs: ethernet-pcs@fda00000 {
> +		compatible = "rockchip,rk3568-xpcs";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x0 0xfda00000 0x0 0x200000>;
> +		clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> +		clock-names = "csr", "eee";
> +		power-domains = <&power RK3568_PD_PIPE>;
> +		status = "disabled";

[Severity: Medium]
Does this node fail dtbs_check for missing phys and phy-names?

The binding added by the preceding patch in this series,
Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml, lists
them in an unconditional required block:

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

There is no status clause in that schema, and dtschema selects a node purely
on its compatible, so the required-property check applies whether or not the
node is disabled. With rk3568-photonicat.dts the only board adding the two
properties (and only at the end of the series), wouldn't the remaining rk3568
board DTBs report "'phys' is a required property" and "'phy-names' is a
required property"?

The commit message states:

  "dtbs_check only validates required properties for enabled nodes, so the
  SoC dtsi does not provide phys/phy-names"

Is that accurate? Status awareness in the DT tooling looks like an explicit
per-check opt-in rather than general behaviour, for example in
scripts/dtc/checks.c the status-aware variant is a separately named check:

static void check_unique_unit_address_if_enabled(struct check *c, struct dt_info *dti,
					      struct node *node)
{
	check_unique_unit_address_common(c, dti, node, true);
}
CHECK_ENTRY(unique_unit_address_if_enabled, check_unique_unit_address_if_enabled,
	    NULL, false, false, &avoid_default_addr_size);

The same omission also affects the enable recipe described in the commit
message. If a board only flips status to "okay", there is no serdes phandle
in the node, so xpcs_rk_serdes_phy_init() in drivers/net/pcs/pcs-xpcs-rk.c
(added later in this series) hits:

	pxpcs->serdes_phy = devm_phy_get(dev, "serdes");
	if (IS_ERR(pxpcs->serdes_phy))
		return dev_err_probe(dev, PTR_ERR(pxpcs->serdes_phy),
				     "Failed to get SerDes PHY\n");

and probe aborts with -ENODEV. Would it make sense either to drop
phys/phy-names from the binding's required list (or make them conditional),
or to provide them in the dtsi, so the binding and the dtsi agree?

[Severity: Low]
This isn't a bug, but a note on ordering within the series: at this commit
rockchip,rk3568-xpcs has no matching driver yet.

Checking the end of the series, this resolves itself:

drivers/net/pcs/pcs-xpcs-rk.c:
	static const struct of_device_id xpcs_rk_of_ids[] = {
		{ .compatible = "rockchip,rk3568-xpcs" },
		{ /* sentinel */ },
	};

and drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c installs the PCS
callbacks for SGMII:

	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
		...
		plat_dat->pcs_init = rk_pcs_init;
		plat_dat->pcs_exit = rk_pcs_exit;
		plat_dat->select_pcs = rk_select_pcs;
	}

So the node is unbound only at the intermediate revision, where it stays
disabled, and nothing breaks at build or runtime. Recording it here only for
completeness.

> +
> +		xpcs_mii0: ethernet-pcs-mii@0 {
> +			reg = <0>;
> +			status = "disabled";
> +		};

[ ... ]

> +
>  	pipe_phy_grf0: syscon@fdc70000 {
>  		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
>  		reg = <0x0 0xfdc70000 0x0 0x1000>;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
