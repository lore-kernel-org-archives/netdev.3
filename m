Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022E349F107;
	Mon, 21 Sep 2026 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034225; cv=none; b=DFaBTKMyITm14l77tS8B4scX7mY0yA6WvJ2ajbosP62Xeqt6vD5bJYCsreIEV4p2e5FUFoY8kGb2XpsbqOlOYewSouDt7/UqBO08CXmGMO9xbUzuesSom3iurmbBuKoaSKkEenwwAPPos7vOh3m+FEhgFcWaDN39pIllLv2kxh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034225; c=relaxed/simple;
	bh=KsdjsiT//LxSqglDMxqUs0rwaR/8303vaWwzw+AF1lo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SoMReDOkTDGD7gAvqExwSwSFYp/6gSsQGzykzO5K1h55QMWbBtr6R0u6tkUaf8YocSwgVNpy4ztKFTiGAyexpnNs5f4XI3JdOlI73EjYXQT8OA1F3HedkMzPbDXmGqrPONXsANA7DS7yAZ6zWk3i/60PaFzKcIxDWtmoo275snM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMCHYpny; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMCHYpny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D261F000FF;
	Mon, 21 Sep 2026 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034223;
	bh=n97KZq/dt3+Fb3OXKCHqn4Dj5VctJrDhDo8X9t1KSnQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cMCHYpnyIm0S5Db+YyBO929/0yD6O04wu23g88ALfFmSmETUsLgn7G6jwzwNRQuTn
	 YVx2Bh31qxFwjr99ZgrwOC3KlbsefpDoUL8wbi5zxARk85ZCOEMKPY2uqh0/hX+YuA
	 nuuJFiZYl77s5PsN9h5vsyAxemtbcdwWTVnnPWswWl9vGDJkkJk6XMNH+Xi8PHATnO
	 8+mIEsa8DTMoOVzsbJ5h1SN/f+HviuXqAzf12v37MNajKkg7RuPhpv3zOFytjhODVT
	 Gwh9leRdj5v2nqJY9+mS/5oVUaT0pVX6xeBfY89Yj8WpHS3c+p5ERfgBpFXbB7dG9v
	 WBb4o+I27la4A==
Subject: Re: [PATCH net-next v7 04/11] dt-bindings: net: pcs: add
 rockchip,rk3568-xpcs support
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
Date: Mon, 21 Sep 2026 23:43:41 +0000
Message-ID: <179003422174.2160803.7756611933343461937@kernel.org>
In-Reply-To: <20260917204624.2427486-5-coiaprant@gmail.com>
References: <20260917204624.2427486-5-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern (disproved as a defect): the binding does not describe
  the CRU reset lines SRST_XPCS / SRST_XPCS_TX_DIV10 /…
- [Low] The binding's description
  (Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml…

--

dt-bindings: net: pcs: add rockchip,rk3568-xpcs support

This adds a new YAML binding for the Synopsys DesignWare XPCS as integrated
on the Rockchip RK3568, with four MII ports described as
ethernet-pcs-mii@N child nodes.  The node requires clocks, phys and a power
domain, and the CRU reset lines are deliberately left undescribed.

Two questions about the new schema below.

> diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> new file mode 100644
> index 0000000000000..703fcff0e3f70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
> @@ -0,0 +1,110 @@

[ ... ]

> +  The XPCS is accessed over the APB3 bus and internally connected to a
> +  Naneng Combo SerDes PHY.
> +  It supports 1000BASE-X, SGMII and QSGMII modes.
> +
> +  The block contains four MII ports that can be individually enabled and
> +  routed to one of the Ethernet GMAC controllers via the pcs-handle
> +  property in the MAC device tree node.

[Severity: Low]
Is the routing really controlled from the XPCS side?  On RK3568 the
SGMII data path mux looks like a single pipe-GRF bit owned by the combphy
driver, not a per-port property of this node:

drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:

    static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
        ...
        .pipe_sgmii_mac_sel = { 0x0040, 1, 1, 0x00, 0x01 },

and in the PHY_TYPE_SGMII case of rk3568_combphy_cfg():

    rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
                                 priv->sgmii_mac_sel > 0);

priv->sgmii_mac_sel comes from the rockchip,sgmii-mac-sel property and
defaults to 1 (GMAC1) in rockchip_combphy_parse_dt().

That means there is one SGMII path shared by two GMACs rather than four
independently routable ports, doesn't it?

Can a device tree then set gmac0's pcs-handle = <&xpcs_mii0> while the
combphy keeps routing to GMAC1?  Both nodes validate, the XPCS probes and
is configured, and neither driver can notice the disagreement because the
two properties describe the same mux from opposite ends, so the link would
just never come up.

Would it be worth stating here that the MII port to MAC association has to
agree with the combphy's rockchip,sgmii-mac-sel, and how the four ports map
onto the two available GMACs in QSGMII mode, instead of describing per-port
routing via pcs-handle?

> +
> +patternProperties:
> +  "^ethernet-pcs-mii@[0-3]$":
> +    type: object
> +    description:
> +      One of the four MII ports of the XPCS. The port is linked to an
> +      Ethernet MAC controller via the pcs-handle property in the MAC's
> +      device tree node.

[ ... ]

> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - clocks
> +  - clock-names
> +  - phys
> +  - phy-names
> +  - power-domains
> +
> +additionalProperties: false

[Severity: Low]
With no resets property described and additionalProperties: false here, a
device tree cannot express the CRU reset lines SRST_XPCS,
SRST_XPCS_TX_DIV10, SRST_XPCS_RX_DIV10 and SRST_XPCS_XGXS_RX from
include/dt-bindings/clock/rk3568-cru.h at all.  Does that matter for an
unusual bootloader hand-off where the block needs to be re-reset?

For what it is worth, both halves of the rationale in the commit message
check out: the glue driver drivers/net/pcs/pcs-xpcs-rk.c added later in the
series contains no reset_control_* call (it brings the block up through
devm_phy_get("serdes")/phy_power_on plus PD_PIPE runtime PM), and adding an
optional resets/reset-names pair to the schema later stays backwards
compatible.  So this is only a question about whether the DIV10 and XGXS_RX
resets are needed in practice, not an objection to the documented omission.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
