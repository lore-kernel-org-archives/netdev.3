Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F27492E48;
	Mon, 21 Sep 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790034223; cv=none; b=Bj+67srWzbdeh6S6yMFFAfpsrYzCJ6bcmfqTb+LsIX/Pg2/Z+tJsToAT5U6C4yNrR8sma/a1J6AqivXMA50KouRAtH6/F6qJpSbgGHofNgF9GUtq63PcCLFy5hdqRhrvL/Iihw1864D8tRXSFKt8Nu0YfmyZe7D8l2H2o4bcB2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790034223; c=relaxed/simple;
	bh=5bRt5Jjulg+86aKt83MgUlPoY/p5oa2NmwT7BX3cCqU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vbc2fTj0+igVP8P92T2+yWuhw88ZhjtBmVErLzn667qDp4NsVvtIMS+6hp6qwEPEVTxMl27xy2M6rHyVhQQye+ZUkmWCZr5Lwf3Ej/M/pdatpzQmowzrrkAjkbxElqQSKYwHnxpDA/9z7gKTjbFjDyNVVedONi/Fvedo6ukOtGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abG50pjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abG50pjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C021F00898;
	Mon, 21 Sep 2026 23:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790034221;
	bh=QnMacYZsTiu91aBrdpT044ZXgSNU90vCzZjH5YJEaR8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=abG50pjxo97oID9LJyNoCvvx1bHpw0G7bkaDhgKsg52JHt4tluPc/0omuk5lXHCcT
	 EwbuX7kQ6mjQPkzUwls9qiW4M8CbHPWF6OAIlBfmc4gH3ZK6T3ttgElAchXKSy015I
	 7oD1DlafWHNMczh3OxEr/aesUcx1FsPztvV5MClQvERqfXqzMptWEP4oFzPB24j70r
	 lMYnQAfRjVudko70OpR/EETtw56CjidQjB8VJM8+jRapQLBhCyP8Cok3XL6nF8pv4t
	 CTCbjBy0DglmI8VTQdjXgI9EbfzTA9tsOYoTBgpy2OuYAsCXq/ifJIy+KvI75SkU2D
	 HNz5mcLBMGzqg==
Subject: Re: [PATCH net-next v7 03/11] phy: rockchip: naneng-combphy: add
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
Date: Mon, 21 Sep 2026 23:43:39 +0000
Message-ID: <179003421974.2160803.11569061351280580358@kernel.org>
In-Reply-To: <20260917204624.2427486-4-coiaprant@gmail.com>
References: <20260917204624.2427486-4-coiaprant@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/phy/rockchip/phy-rockchip-naneng-combphy.c,
  rk3568_combphy_cfg() now writes PIPE_GRF_XPCS_CON0 bit 1…

Pre-existing issues:
- [Low] Concern (validated as pre-existing style, not a new defect): the
  newly added rockchip_combphy_param_write(priv->pipe_grf,…

--

phy: rockchip: naneng-combphy: add SGMII MAC selection for RK3568

This adds a "rockchip,sgmii-mac-sel" DT property to the RK3568 naneng
combphy driver so the SGMII lane can be routed to either GMAC0 or GMAC1
through PIPE_GRF_XPCS_CON0 bit 1 (pipe_sgmii_mac_sel).  The property is
read in rockchip_combphy_parse_dt() and applied in rk3568_combphy_cfg()
when the PHY type is PHY_TYPE_SGMII.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 229)

A couple of questions below.

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

[Severity: Medium]
In rockchip_combphy_parse_dt(), the return value of
device_property_read_u32() is discarded and priv->sgmii_mac_sel is
pre-seeded with 1, so "property absent" and "property = 1" become
indistinguishable later on.

Is that intentional, or should the presence of the property be tracked
separately so the write below can be skipped when the DT says nothing?

>  	priv->phy_rst = devm_reset_control_get_exclusive(dev, "phy");
>  	/* fallback to old behaviour */
>  	if (PTR_ERR(priv->phy_rst) == -ENOENT)

[ ... ]

> @@ -873,6 +878,8 @@ static int rk3568_combphy_cfg(struct rockchip_combphy_priv *priv)
>  		break;
>  
>  	case PHY_TYPE_SGMII:
> +		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_sgmii_mac_sel,
> +					     priv->sgmii_mac_sel > 0);

[Severity: Medium]
Following on from the parse above: does this end up writing
PIPE_GRF_XPCS_CON0 bit 1 on every RK3568 SGMII init, including on DTBs
that do not carry the new property?

rockchip_combphy_param_write() is not a read-modify-preserve; it always
asserts the hiword write-enable for the bit:

drivers/phy/rockchip/phy-rockchip-naneng-combphy.c:rockchip_combphy_param_write() {
	tmp = en ? reg->enable : reg->disable;
	mask = GENMASK(reg->bitend, reg->bitstart);
	val = (tmp << reg->bitstart) | (mask << BIT_WRITEABLE_SHIFT);

	return regmap_write(base, reg->offset, val);
}

With .pipe_sgmii_mac_sel = { 0x0040, 1, 1, 0x00, 0x01 } that gives
mask = GENMASK(1, 1) and val = (tmp << 1) | (mask << BIT_WRITEABLE_SHIFT),
so bit 1 is latched to either 0 or 1 unconditionally.

Before this patch the driver never touched that bit, so whatever the
bootloader or a previous boot (kexec) left there survived PHY init.  Can a
board whose firmware routed SGMII to GMAC0, running an older DTB without
"rockchip,sgmii-mac-sel", now get the mux forced back to GMAC1 while the
MAC driving the link is still GMAC0?

The commit message says:

    The hardware reset value is 1 (GMAC1). If the property is set to 0,
    the driver routes SGMII to GMAC0; if set to 1 (or omitted), it
    remains at GMAC1.

Is "remains at GMAC1" accurate given the bit is now actively programmed
rather than left alone?  Writing the bit only when
device_property_read_u32() actually succeeds would keep the change inert
for existing DTBs; otherwise it may be worth stating in the commit message
that the driver now takes ownership of this bit from firmware.

[Severity: Low]
This isn't a bug introduced by this patch, but a pre-existing convention
worth noting: the regmap_write() error returned by
rockchip_combphy_param_write() is discarded here, as it is at all of the
other call sites in this file, so SGMII init can report success with the
MAC mux left unprogrammed.

With the in-tree DT this cannot actually fail; arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
declares the pipe-grf region as:

	pipegrf: syscon@fdc50000 {
		reg = <0x0 0xfdc50000 0x0 0x1000>;
	};

so offset 0x40 is well inside the regmap.  The neighbouring
pipe_xpcs_phy_ready write at the same offset 0x40 already ignores its
return value too.

>  		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_xpcs_phy_ready, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_phymode_sel, true);
>  		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_sel_qsgmii, true);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917204624.2427486-1-coiaprant%40gmail.com
