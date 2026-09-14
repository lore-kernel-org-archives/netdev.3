Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE54963BA;
	Mon, 14 Sep 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789417483; cv=none; b=pPXWWZ7aSz3GmIrU+1cE/PjP0giwiDLx21KT1PeHr2NFAM/VUARhXVaA5FPfQNe5hy1z23K2WOCZ+Xuf6y2rW45PiRsMwQG0eriDKNalGuwGW0lOuia1gbB/4+A+v2dAwqKShBvqvzH/AZ+Yc/RNK1Q/1RSASk0j/gc+78rNFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789417483; c=relaxed/simple;
	bh=d8UxDlLS4Ep6rXrAZODieqBp++mTaL13UnOC5nPVHBA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mdTbR0zFmwbc5Cwo3t0Ztsm8GGjh5SlHgBQRf+OKB51u/OfO9RhVBHlwQDE5wxrFMQg51hVUZFv9K4uRTtRi+4caaYohRxemc0YoCT1vrqwiTPGeMkrQFZfnCxqNbYe2+DiUs9vv8Ne03IgoJ0gPdy5bhueQtdvluQINaVSFD9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2FLQpsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2FLQpsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C931F0089B;
	Mon, 14 Sep 2026 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789417481;
	bh=ZiBcmk8cWaqM0zhqdrD96cyC+N60s8OeNQrXU/Asq9E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=M2FLQpsM4Jpi8hGFsfsjLdGvoFDcPXyCVmBqtamWccxkqPPZ4jZzo3Hk203S0FUVe
	 IE/qBdWbEV6asBygalP5/8wGuWFAXF6AmYgigX3BzaO0RUvZBCr3EYXR/dPWA0MGXM
	 5uiNM9B1BeCfPQoeEoNkACOq54kXXALCzZhICB8eiMG8hH/zUWUPT7Rl4ZGdH+ZcqX
	 HDnhBbJcaGI9J3k0HcXI7mInhvY5HSUnNejDzVS8gYgtBV4IlbgD6mIiZ+S2marx4s
	 oSUzmDOuJzkYeWRP5CDcNNFSwgnQrcvRwvO1kMSIb2F8o9kr4ajQRbFB4Ti0OPKaEc
	 EktZ7M9fSj3uw==
Subject: Re: [PATCH net-next v5 03/11] phy: rockchip: naneng-combphy: add
 SGMII MAC selection for RK3568
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
Date: Mon, 14 Sep 2026 20:24:39 +0000
Message-ID: <178941747926.22033.15174869537556409251@kernel.org>
In-Reply-To: <20260913185849.907479-4-coiaprant@gmail.com>
References: <20260913185849.907479-4-coiaprant@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] In rk3568_combphy_cfg() (drivers/phy/rockchip/phy-rockchip-
  naneng-combphy.c:881-882) the newly added write of pipe_sgmii_mac_sel…

--

phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568

This adds a "rockchip,sgmii-mac-sel" DT property to pick whether the RK3568
SGMII interface is routed to GMAC0 or GMAC1 via PIPE_GRF_XPCS_CON0 bit 1.
The value is read in rockchip_combphy_parse_dt() and programmed from the
PHY_TYPE_SGMII branch of rk3568_combphy_cfg().

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)

One question about the commit message wording:

    The hardware reset value is 1 (GMAC1). If the property is set to 0,
    the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
    remains at GMAC1.

Does "or omitted ... it remains at GMAC1" match the code?  The write in
rk3568_combphy_cfg() is unconditional, so in the omitted case the driver
does not leave the bit alone, it actively programs it to 1.  See the
inline comment below.

> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> index 7843356a4dd47..7b867e7520064 100644
> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

[ ... ]

> @@ -375,6 +377,9 @@ static int rockchip_combphy_parse_dt(struct device *dev, struct rockchip_combphy
>  
>  	priv->ext_refclk = device_property_present(dev, "rockchip,ext-refclk");
>  
> +	priv->sgmii_mac_sel = 1;
> +	device_property_read_u32(dev, "rockchip,sgmii-mac-sel", &priv->sgmii_mac_sel);
> +

[Severity: Low]
Since device_property_read_u32() leaves the output untouched on failure,
rockchip_combphy_parse_dt() ends up with priv->sgmii_mac_sel == 1 both when
the property says 1 and when the property is absent.  Is there a way for the
driver to express "leave the bit as firmware left it"?

Before this patch the kernel never touched PIPE_GRF_XPCS_CON0 bit 1, so a
board whose bootloader routed SGMII to GMAC0 kept that routing.  With this
change, a DT that instantiates the combphy as PHY_TYPE_SGMII but does not
carry the new property has the bit re-programmed to GMAC1 on every
phy_init().  Can that break such a board's SGMII link?

>  	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
>  	/* fallback to old behaviour */
>  	if (PTR_ERR(priv->phy_rst) == -ENOENT)
> @@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		break;
>  
>  	case PHY_TYPE_SGMII:
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
> +					     priv->sgmii_mac_sel > 0);

[Severity: Low]
This write always happens, including in the "property omitted" case, and
rockchip_combphy_param_write() sets the write-enable mask along with the
value:

	tmp = en ? reg->enable : reg->disable;
	mask = GENMASK(reg->bitend, reg->bitstart);
	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);

	return regmap_write(base, reg->offset, val);

so with priv->sgmii_mac_sel defaulting to 1 the register gets
(0x1 << 1) | (GENMASK(1, 1) << 16), i.e. GMAC1 is forced.  Would it be
better to only issue this write when the property is actually present?

A second question: bit 1 of PIPE_GRF_XPCS_CON0 is a single SoC-wide mux,
while the property sits on a per-PHY node.  If two combphy instances that
share the same rockchip,pipe-grf syscon are both brought up as
PHY_TYPE_SGMII with different property values, the last phy_init() wins and
nothing is reported.  Should conflicting values be rejected or at least
warned about?

>  		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);
> @@ -984,6 +991,7 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
>  	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x4407 },
>  	/* pipe-grf */
>  	.pipe_con0_for_sata	= { 0x0000, 15, 0, 0x00, 0x2220 },
> +	.pipe_sgmii_mac_sel	= { 0x0040, 1, 1, 0x00, 0x01 },
>  	.pipe_xpcs_phy_ready	= { 0x0040, 2, 2, 0x00, 0x01 },

For what it is worth, the only in-tree SGMII consumer at the end of this
series, rk3568-photonicat.dts, sets rockchip,sgmii-mac-sel = <0>
explicitly, so no upstream DT changes behaviour today; the concern is about
out-of-tree or ported device trees and about the commit message wording.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913185849.907479-1-coiaprant%40gmail.com
