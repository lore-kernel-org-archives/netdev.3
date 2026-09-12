Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC273C4574;
	Sat, 12 Sep 2026 20:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789244008; cv=none; b=NKj/g4XPuBSsaGs+rm+TcVhkRbAax7h04NMbEwNQRYuXPRS7UZq9jV4BTI7Bt58xC2KdWtjImF/z7e4luGaYBw449PRwjayoZEjmMk5a1IhAZ8CsHYBCaH+qA4TbLDsTt7alwP+wBWZalc6nruWPQKzDFDT/w2AqX8hloHgOS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789244008; c=relaxed/simple;
	bh=+LYtuS6GivF/Heaxrik/xAxl7bZ6yvsuxawU1alxXz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSBfw26z8q9Vnsbf8lj5YJnkFZyrXPqgPiiALBQG/DBAzJRHzgsBpLPOd9hvRHFwp8gGtnLYIAOKCCQxw8KdmeROtYtT4JonoZzRhn6v3kjtz+YOF5XLCNI/0Fi9QZnnMYRrB0zXLAeQhhIQFQjib2EZNZNnp9flf1hskRbcmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0MmQ30h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0MmQ30h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9CE1F00893;
	Sat, 12 Sep 2026 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789244004;
	bh=+NJwNoOVu5Lw2f15qRrrWFOurl539RxGcb8Qsu6qCEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I0MmQ30h5SiJq+iVMB+LoHrWxU7iu+LRN7wyVVy4A/D7qto9ZHf8XdClVJETygujI
	 zIW4yw3u6f6RzEL9glKC9/xM/40dnOb0vPNczffwUIM5x8goXwgJal1F/ENE+I73wn
	 UBXl2nAN1241vMF/GsQNLU5Cdn8mwAu/Plg/jMAO4UuNFNKbJoCTH7l4EChE5ts20U
	 fASguPrLxwrm0Gf6KIPKGrvIpLP9+O+vO4QxzNYqs56V0PBBP9ZfoO67DRrjC2csQu
	 k/08PfDMeS2T4CmqNOKx1ihf90sSyvqe+FDKQtjZj0q1ngf7Kh26aQnSMU1iEQuadj
	 2+Z2XHCPJuxrA==
From: Jakub Kicinski <kuba@kernel.org>
To: coiaprant@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	vkoul@kernel.org,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	romain.gantois@bootlin.com,
	hkallweit1@gmail.com,
	neil.armstrong@linaro.org,
	linux@armlinux.org.uk,
	shawn.lin@rock-chips.com,
	david@ixit.cz,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v4 03/10] phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568
Date: Sat, 12 Sep 2026 13:13:22 -0700
Message-ID: <20260912201322.126940-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907153713.2572547-5-coiaprant@gmail.com>
References: <20260907153713.2572547-5-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568

This adds a "rockchip,sgmii-mac-sel" DT property to the RK3568 combphy
driver so the SGMII interface can be routed to GMAC0 or GMAC1 through the
pipe GRF pipe_sgmii_mac_sel bit. The value defaults to 1 (GMAC1) when the
property is absent, and is written during PHY_TYPE_SGMII configuration.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)

A few questions below.

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 7843356a4dd47..919bb97a4b182 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

[ ... ]

> @@ -212,6 +213,7 @@ struct rockchip_combphy_priv {
>  	bool enable_ssc;
>  	bool ext_refclk;
>  	struct clk *refclk;
> +	u32 sgmii_mac_sel;
>  };
>  
>  static void rockchip_combphy_updatel(struct rockchip_combphy_priv *priv,
> @@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
>  
>  	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
>  
> +	priv->sgmii_mac_sel = 1;
> +	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
> +

[Severity: Medium]
Since the return value of device_property_read_u32() is discarded here,
rockchip_combphy_parse_dt() cannot distinguish "the DT asked for GMAC1"
from "the DT said nothing about the mux".

The result is that rk3568_combphy_cfg() writes PIPE_GRF 0x0040 bit 1 on
every PHY_TYPE_SGMII bring-up, including for device trees that do not have
the new property. Before this patch that bit was never touched, so whatever
routing the SoC reset or the boot firmware established was left alone.

The commit message states:

  "The hardware reset value is GMAC1 (1). If the property is set to 0,
  the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
  remains at GMAC1."

The "or omitted" case now depends entirely on that reset value being 1. If
the reset value is actually 0, or if firmware routed SGMII to GMAC0 on a
board wired that way and its DT lacks the property, does phy_init() still
return success while the XPCS ends up attached to the wrong MAC, giving a
link that never comes up and no message explaining why?

Would it make sense to only write the bit when the property is actually
present, for example:

	if (!device_property_read_u32(dev, "rockchip,sgmii-mac-sel",
				      &priv->sgmii_mac_sel))
		priv->sgmii_mac_sel_valid = true;

so that omitting the property leaves the mux untouched?

>  	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
>  	/* fallback to old behaviour */
>  	if (PTR_ERR(priv->phy_rst) == -ENOENT)
> @@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		break;
>  
>  	case PHY_TYPE_SGMII:
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
> +					priv->sgmii_mac_sel > 0);

[Severity: Low]
The binding added in the preceding patch of this series declares the
property as:

  rockchip,sgmii-mac-sel:
    $ref: /schemas/types.yaml#/definitions/uint32
    enum: [0, 1]
    default: 1

but "priv->sgmii_mac_sel > 0" collapses the value to a boolean, and
rockchip_combphy_parse_dt() does no range check.

Does that mean a device tree setting the property to 2 or 0xffffffff is
silently treated as GMAC1 rather than rejected? Similarly, a
present-but-malformed property (wrong length or type) makes
device_property_read_u32() fail, and the pre-seeded default of 1 is used
with no diagnostic.

dtschema only validates in-tree device trees, so for bootloader-supplied
DTs or overlays the driver is the only place the enum can be enforced.
Would checking the value against {0, 1} and returning an error, or
alternatively documenting the property as a plain flag, close that gap?

[Severity: Low]
The mux write is only added to the PHY_TYPE_SGMII case. The adjacent
PHY_TYPE_QSGMII case in rk3568_combphy_cfg() programs the same pipe-grf
register (pipe_xpcs_phy_ready at offset 0x0040 bit 2) but never touches
the MAC-select bit:

	case PHY_TYPE_QSGMII:
		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
		...

The binding gates the property on the compatible only, not on the PHY
type, and rockchip_combphy_parse_dt() runs at probe time before the PHY
type is known from rockchip_combphy_xlate().

If a device tree sets rockchip,sgmii-mac-sel on a combphy that a consumer
later claims with PHY_TYPE_QSGMII, is the requested routing simply dropped
with no warning? If the property is meant to be SGMII-only, would
rejecting or warning about it for other PHY types make that explicit?

>  		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> @@ -984,6 +991,7 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
>  	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
>  	/* pipe-grf */
>  	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
> +	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
>  	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },
>  	.u3otg0_port_en		= { 0x0104, 15, 0, 0x0181, 0x1100 },
>  	.u3otg1_port_en		= { 0x0144, 15, 0, 0x0181, 0x1100 },

For reference on the first two comments: this disable/enable encoding
({ 0x0040, 1, 1, 0x00, 0x01 }) is what maps the DT value onto GMAC0/GMAC1,
and rockchip_combphy_param_write() always sets the write-enable mask:

	tmp = en ? reg->enable : reg->disable;
	mask = GENMASK(reg->bitend, reg->bitstart);
	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);

so the bit is committed to hardware on every SGMII bring-up regardless of
whether the device tree expressed a preference. Could the TRM bit polarity
and the claimed reset value of 1 be confirmed in the commit message?

Note that no in-tree Rockchip device tree requests PHY_TYPE_SGMII before
this series, and the only user (rk3568-photonicat.dts) is added later in
the series, so nothing in-tree changes behaviour today.
