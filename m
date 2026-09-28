Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35B466AED;
	Mon, 28 Sep 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582623; cv=none; b=LBs2Ldw2FdPT/2HMpBIewO/uQJOOlJRb/t67CEZA7dPztR6H5IbfmW7cwk6OyO1LdD8/vojlSxSPdyBZ8LXgjwExVvvU0f8wDV27enR9jdW2dDxK24j6XZ26s0vFgxzBTKmT0GzaFhYye1kUMSWK37ZLMhAbCv64u1KF3R0+iVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582623; c=relaxed/simple;
	bh=NCBjHBq6ROMBnWMjohzc9cvQDluFaiuKFu2JHXMqgtU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uCL9h2sKv6glUJLtAi8Lwt3MWdiFilQoQEPmBA2X4KYc7emqFBnzHKldLsSYO4o0zB6PK3dD05qu/6GNk7iPoJRhuN7y9F5WesXn1W/RiPJ/iBHH+HscmdUjPtmDu5QhkL0jZ9Z6NONsrii/hdt82xNtK7/9VJYvofOtAUj7Et4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPlhM0ur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPlhM0ur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00AE1F00893;
	Mon, 28 Sep 2026 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582622;
	bh=d8sZX7sedqrjKDmZIkU7rI1DLwmYGwJUxtpLg+D3HK4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DPlhM0urkOWYZf+yfDXria2xkmkIqwWNL/u29ZF44FB5lIyzOQN7JtwSOGx8rayHP
	 /nAiq8X0crQ7ID/rWp0T/+jGM7LD43/EiqonSEcqdsaRHukP3xrmCeuy+T7HHB2LWI
	 Nad/Zkmn8Axd4qcJ1J62AYkRaWjbIQ6s5qwLvmvNCKDAVftSuRkLK7bV75sMOZG0lq
	 I4scMoGDKQqCMcpKxcs+x4/ad/CmMX8y/owDOOgg/xRGBeYLIznOMzjbJnjCLHXMct
	 CBdcxoYQw4pOAIk4OikFc5RJzkVz7eKhIKu+67xpSIMPSaz+8UtHWh8iCMJIGVkXP4
	 tOXsqaAGVXfWA==
Subject: Re: [PATCH net-next v2 5/7] net: stmmac: mediatek: use TX clock phase
 shift in RGMII mode with 1Gbps speed
From: netdev-bot+sashiko@kernel.org
To: louisalexis.eyraud@collabora.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, kernel@collabora.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
Date: Mon, 28 Sep 2026 08:03:40 +0000
Message-ID: <179058262053.3145.11439692575591950530@kernel.org>
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-5-430bd74d5ef9@collabora.com>
References: <20260924-dwmac-mediatek-mt8189-v2-5-430bd74d5ef9@collabora.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At 1Gbps, mt8195_fix_mac_speed()
  (drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c) ignores the…
- [Medium] mt8195_fix_mac_speed() and mt8195_set_delay() use different
  rules for whether a TX delay is present.
- [Medium] At SPEED_1000, mt8195_fix_mac_speed() sets reg_val to
  MT8195_RGMII_TXC_PHASE_CTRL only (line 467).
- [Low] In mt8195_fix_mac_speed(), `tx_delay_stage_val` is declared
  without an initializer (line 445: `u32 tx_delay_stage_val,…

--

net: stmmac: mediatek: use TX clock phase shift in RGMII mode with 1Gbps speed

This patch adds a fix_mac_speed callback to the MediaTek dwmac glue and
implements it for MT8195. The callback runs when a TX delay is set in the
devicetree and the PHY mode is rgmii or rgmii-rxid. It enables the fixed
2ns TXC phase shift at 1Gbps and uses the HW delay macro circuit at
10/100Mbps.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index dee12cfa437d..6123efbbaf02 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

[ ... ]

> @@ -433,9 +436,62 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  	return 0;
>  }
>  
> +static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
> +				 int speed, unsigned int mode)
> +{
> +	struct mediatek_dwmac_plat_data *priv_plat = priv;
> +	const struct mediatek_dwmac_variant *variant;
> +	struct mac_delay_struct *mac_delay;
> +	u32 tx_delay_stage_val, reg_offset;
> +	u32 reg_val = 0;
> +
> +	if (!priv_plat)
> +		return;
> +
> +	mac_delay = &priv_plat->mac_delay;
> +	variant = priv_plat->variant;
> +
> +	if (!mac_delay->tx_delay ||
> +	    (interface != PHY_INTERFACE_MODE_RGMII &&
> +	     interface != PHY_INTERFACE_MODE_RGMII_RXID))
> +		return;

[Severity: Medium]
Should this check the stage count instead of the raw picosecond value?

mt8195_set_delay() decides whether there is a TX delay from the number of
stages:

	tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
	...
	gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
				     !!tx_delay_stage_val);

Take mediatek,tx-delay-ps set to a value from 1 to 289. The binding says
the value rounds down to 0, and the probe path applies no TX delay. The
same value still passes the !mac_delay->tx_delay check here, so at
SPEED_1000 the callback enables the fixed ~2ns TXC phase shift.

The 10/100 branch further down has the same mismatch:

	reg_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
			      !!mac_delay->tx_delay);

That sets GTXC_ENABLE=1 with STAGES=0, which is not what probe wrote.

Does this turn a documented "no delay" setting into a 2ns delay at 1G?

> +
> +	/*
> +	 * When link speed is 1Gbps with RGMII interface, and a TX internal
> +	 * delay needs to be applied on MAC, prefer to override the delay
> +	 * settings with a 2ns fixed delay which is controlled by
> +	 * RGMII_TXC_PHASE_CTRL. Otherwise, fallback to HW delay macro circuit
> +	 * for 10/100Mbps link speeds.
> +	 */
> +	if (speed == SPEED_1000) {
> +		reg_val = MT8195_RGMII_TXC_PHASE_CTRL;

[Severity: Medium]
Does this throw away the configured size of mediatek,tx-delay-ps at 1G?

The property is only checked for non-zero above. Any value from 1 to 9279
ps ends up writing only MT8195_RGMII_TXC_PHASE_CTRL here.
MT8195_DLY_GTXC_ENABLE and MT8195_DLY_GTXC_STAGES are in the
regmap_update_bits() mask, so the stages that mt8195_set_delay() programmed
at probe and resume get cleared. As a result, <290>, <1160>, <2030> and
<5000> all give the same 1G programming.

The binding in Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
still describes the property as the internal TX delay:

      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a
      multiple of 290, or will round down. Range 0~31*290.

It has no 1G exception, and this patch does not update it.

The in-tree users (mt8395-genio-common.dtsi and mt8395-radxa-nio-12l.dts,
both rgmii-rxid with <2030>) are close to 2ns. A board whose value was
tuned for trace skew far from 2ns would get different 1G timing than
before, with no warning.

The commit message says the phase shift is used "when a delay needs to be
inserted". It does not mention that the configured value is ignored.

The later commit "net: stmmac: mediatek: add support for MT8189 SoC" reuses
this callback unchanged, so this also applies to MT8189 with its 180 ps
stages.

Should the phase shift be used only when the configured delay is close to
2ns? Otherwise, should the binding document the override?

> +	} else {
> +		if (variant->tx_delay_stage_div)
> +			tx_delay_stage_val = mac_delay->tx_delay /
> +					     variant->tx_delay_stage_div;
> +
> +		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
> +				      !!mac_delay->tx_delay);
> +		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES,
> +				      tx_delay_stage_val);

[Severity: Low]
Can tx_delay_stage_val be used uninitialized here?

It is declared without an initializer and only assigned when
variant->tx_delay_stage_div is non-zero. FIELD_PREP() always reads it,
though, and the result is written to PERI_ETH_CTRL0.

mt8195_set_delay() handles this case with an explicit else:

	if (tx_delay_stage_div)
		tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
	else
		tx_delay_stage_val = 0;

clang's -Wsometimes-uninitialized is likely to warn here, which would break
CONFIG_WERROR builds. Every current user has a non-zero divisor (290 for
MT8195, and 180 for MT8189 later in the series), so this path is not hit at
runtime today.

> +		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_INV,
> +				      mac_delay->tx_inv);
> +	}
> +
> +	reg_offset = variant->peri_eth_ctrl_offset + MT8195_PERI_ETH_CTRL0;
> +	regmap_update_bits(priv_plat->peri_regmap,
> +			   reg_offset,
> +			   MT8195_RGMII_TXC_PHASE_CTRL |
> +			   MT8195_DLY_GTXC_ENABLE |
> +			   MT8195_DLY_GTXC_INV |
> +			   MT8195_DLY_GTXC_STAGES,
> +			   reg_val);
> +}

[Severity: Medium]
At SPEED_1000, reg_val holds only MT8195_RGMII_TXC_PHASE_CTRL, but
MT8195_DLY_GTXC_INV is part of the mask. Does this clear the TX clock
inversion requested by mediatek,txc-inverse at 1G?

mediatek_dwmac_config_dt() reads that property into mac_delay->tx_inv, and
mt8195_set_delay() programs it at probe and resume. The 10/100 branch keeps
it through FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv). The TX clock
would then be inverted at 10/100 but not at 1G.

The binding describes the property as:

      1. tx clock will be inversed in MII/RGMII case,

It has no speed exception. Neither the commit message nor the code comment
mentions dropping the inversion.

Is this intended, or does the hardware ignore GTXC_INV once PHASE_CTRL is
set?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9%40collabora.com
