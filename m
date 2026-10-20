Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501857;
	b=4vSfVQ9SFfWKvVMMReP78qUQ9239E6vwTQ1t1D8yhbKUcSCdQeDvlmcH7HT9NTKU7k8w
	 7hXaom5okAG+m+PuyyXBqNNoheOKSllzhn6qZ58vhsDSA1tBay8LxgJu0VzV+zTGgi701
	 XOXbGdakALk9PRBmH2uZw1X94bzvk1LAjJq4kilcmLmflkhX9r+sae3Tm9JV77avC02qK
	 MvX+A9RgXdsj8KNRgXjyCpi9cnTLJNgp0vtURZDK3l5nWct1XQn2GCuur5d8ajBpublj3
	 Q8vKCq4iLiUz8jZEYApVRTM1IsF0qz3yrhZAvpoDwZTpyXcGV0vAm3hh4pl46cc4RdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501857;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=S3Sb419tcnHgsczc/SWcwDkky5azghj0g+2RQPB3KEA=;
	b=PZBayuu4HJAZOBpvsPZNvQ70aY2JMGr4i/QkIZ0getO+eAvCaq/EQ18xm99IkUBCwAdx
	 jvhFg9ShHSVINzxO9HldDAZgvnaDHXvHwDlbYGQebVnZLylNsinuQBUG85Vf/Z/wcJolf
	 xpnholLOgT4FcIItgHduZZ9WnvDCToCaudzUA1rSBxOScPISusp/2XW42Xm6z0TsEmlWl
	 xOPU1Ko7rTbPPJJr8ti9J3O/wD4uQMFXZmC0rRHXI7xScZunv9d6Q+dGQ+c5vEB6NFAKZ
	 hyU0e45+kwXpCZlRODe9O5hWl/djssXDuxVepkJB6+L9HkMC8VIRRkidrtIcfmzbAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPZ5KfkL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A160A261E;
	Tue, 20 Oct 2026 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aPZ5KfkL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FCE1F000C7;
	Tue, 20 Oct 2026 13:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501856;
	bh=S3Sb419tcnHgsczc/SWcwDkky5azghj0g+2RQPB3KEA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aPZ5KfkLYnGUCoEyYowA72827WT2AYMDPraxg7tQjRbHfbK7xQfbqq6EMnF5mcgTY
	 dMhRaAr9lsTMy6lEdLKhzit1GSb3U4ZS3uNDAlumlimYtHhc2UCwxL5ly5PAHw20y9
	 y3vEI7ywsh9sNzRth3PPWQLBFzF5oejKvg5le4QuGY7FvJkmsWGBoBunT4/BzmUCFt
	 fzGjeOSpq6O8HSt/3JSjnqVqJWlZ56yZSFI7QJqMasnuXFehj0IN+MwqRvM1gHTx91
	 BEa+y00+xKYrL8Qiri66Jc3Z4c7Gbr5VSVLst5A3VanHjXtlKsSl5zjQ1TTCBd8uKr
	 GFFGB8mzJ9EqQ==
Subject: Re: [PATCH net-next v3 7/9] net: stmmac: mediatek: use TX clock phase
 shift in RGMII mode with 1Gbps speed
From: netdev-bot+sashiko@kernel.org
To: louisalexis.eyraud@collabora.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 richardcochran@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, biao.huang@mediatek.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, edumazet@kernel.org, kernel@collabora.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
Date: Tue, 20 Oct 2026 13:10:54 +0000
Message-ID: <179250185440.3135.3867297612747113346@kernel.org>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-7-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-7-25daf2bbcf35@collabora.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At 1Gbps on RGMII, mt8195_fix_mac_speed()
  (drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c) treats the DT…
- [Medium] At 1Gbps, mt8195_fix_mac_speed()
  (drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c) silently clears…

--

net: stmmac: mediatek: use TX clock phase shift in RGMII mode with 1Gbps speed

This commit adds a fix_mac_speed callback to the MediaTek dwmac glue and
implements it for MT8195. When an RGMII link comes up at 1Gbps and the DT
requests a TX delay, the callback turns on the fixed 2ns TX clock phase
shift (RGMII_TXC_PHASE_CTRL). At other speeds it falls back to the coarse
delay macro circuit.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 7dd46cd5a49e1..4b2d5280f7030 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c

[ ... ]

> @@ -430,9 +433,65 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  	return 0;
>  }
>  
> +static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
> +				 int speed, unsigned int mode)
> +{

[ ... ]

> +	if (!mac_delay->tx_delay ||
> +	    (interface != PHY_INTERFACE_MODE_RGMII &&
> +	     interface != PHY_INTERFACE_MODE_RGMII_RXID))
> +		return;
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
At 1Gbps, does this treat mediatek,tx-delay-ps as an on/off switch rather
than as a delay amount?

The gate checks the raw picosecond value in mac_delay->tx_delay.
mediatek_dwmac_config_dt() stores that value without rounding:

    if (tx_delay_ps < plat->variant->tx_delay_max) {
        mac_delay->tx_delay = tx_delay_ps;

Both mt8195_set_delay() and the new 10/100 branch round the value down to
290ps stages (180ps on MT8189). So a value of 1..289ps means no delay at
probe time and at 10/100. At 1G, the same DT value now gets the full ~2ns
phase shift.

For every other value (290ps, 870ps, 8990ps, ...), the configured amount is
replaced by a fixed ~2ns at 1G. GTXC_ENABLE and GTXC_STAGES are in the
update mask, so the coarse delay is also cleared, with no warning.

The same DT setting therefore gives a different MAC TX delay depending on
link speed. Could boards that tuned tx-delay-ps to their PCB skew end up
with the wrong total skew at gigabit?

The binding in Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
still describes the property as:

      For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a
      multiple of 290, or will round down. Range 0~31*290.

The commit message also doesn't say that the configured value is ignored at
1G.

None of the in-tree boards seem to hit this. mt8395-genio-common and
mt8395-radxa-nio-12l use rgmii-rxid with 2030ps. mt8390-grinn-genio-sbc uses
30ps, but its phy-mode is rgmii-id, which skips this path.

The later commit "net: stmmac: mediatek: add support for MT8189 SoC" also
wires mt8195_fix_mac_speed() into the MT8189 variant, so MT8189 gets the
same behaviour.

> +	} else {
> +		if (variant->tx_rgmii_delay_stage_div) {
> +			tx_delay_stage_val = mac_delay->tx_delay /
> +					     variant->tx_rgmii_delay_stage_div;
> +		} else {
> +			tx_delay_stage_val = 0;
> +		}
> +
> +		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
> +				      !!tx_delay_stage_val);
> +		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES,
> +				      tx_delay_stage_val);
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
Does the 1G path clear the TX clock inversion requested by
mediatek,txc-inverse?

MT8195_DLY_GTXC_INV is in the regmap_update_bits() mask. The SPEED_1000
branch, however, sets only MT8195_RGMII_TXC_PHASE_CTRL in reg_val. GTXC_INV
is therefore written as 0 whatever mac_delay->tx_inv says.

The 10/100 branch above keeps the inversion. mt8195_set_delay() also
applies it for all RGMII modes at probe and resume:

    gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv);

The 1G case is also inconsistent with itself. With tx-delay-ps = 0, the
early return leaves the inversion in place. With any non-zero tx-delay-ps,
it is cleared.

The binding describes mediatek,txc-inverse as "tx clock will be inversed in
MII/RGMII case", with no exception for any speed. Should the SPEED_1000
branch also include FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv)?

No in-tree MediaTek board uses txc-inverse today. MT8189 is affected too,
once "net: stmmac: mediatek: add support for MT8189 SoC" wires in the same
callback.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35%40collabora.com
