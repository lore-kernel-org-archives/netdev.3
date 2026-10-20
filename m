Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501852;
	b=JI7iR2oQfxbviiff8RyU9vYMSyyg6Pxd2tSpUCclmwfD12/mDqxkrCWFxDJWsVBssxtH
	 suI5kwXuaaa6ArDgHshB2c8IBF6asqw9zP6RTHSWWo2S0BZJTUSmrvjOarA1IjmVrC/k4
	 V+W6oexcvSO8QkX4yxM6+5ZMX65zuG0rhCJLZJpK9PUc65m2tvGLQLC3O5c10e2D9fBlP
	 DETaUEtXm6CRwiE9E6x7xcgNNpx3NPkNxKe7T+0mwRT1wIJzpogUZT1WfYPnGuEnx8tSN
	 38Yj9LovlWFWepa3UOUmtOy5kKopjmChrMba47MnEWOeOsH9VcbhpdPPso0PITjL1hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501852;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XuD6zr6E/WXraw+qY7ed3x7Km9phQJZA6ZLc39olELM=;
	b=z5oexE2QYmY11u+/qxGydHiM5Uu+3DLY/BiwX7kSYHk7HJVoVi/Pks1yzd//nszB0Qrk
	 7O0UcnuK5G1cWTbghu6ZXrDJqCxQ8nPoKEPbB9tTBlSvOoRKqXGjlRDwsicxJd6NdDvUi
	 V006NDl41GUuO3fQfI5aVLcAaREXZJ2Y/93LtPhV5NVfCPPMFNkBWlKduB9hAMitqRmhW
	 LmrlUrl1MeS/TogtjAojExWAax6K4+52ysM0JDLfObku+2ihv4DX+HIHY80dZiT5iN6Wu
	 zpaT37VdAgf5JS475Vh3tMgTtCMNlycpRt0tpHKLOgDMNUmFwTeACZGzk63Lk0A9Brw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5XeuGiX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C73606A31C;
	Tue, 20 Oct 2026 13:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b5XeuGiX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F401F000C4;
	Tue, 20 Oct 2026 13:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792501852;
	bh=XuD6zr6E/WXraw+qY7ed3x7Km9phQJZA6ZLc39olELM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b5XeuGiXV9gmpP0zjxDKguhvUm/0MEXDjHw/i5xVGXRYCHUofj/VsmDz858ZnEUH/
	 BKf7eKAHoM9GdHXBqq2xDXVSyqYyOyGmJIVigTZvd1lMGWv5cf8OiTKmv0fUyklVFE
	 YrGbF/P7Di5bGSFNs0RCsWQhgXiGZb3BFBIvLFenk0A2HtotRCJwoUaQwk8y+ei2IS
	 /al52OXUUZgBFdJAgBb7Jzu0p4P+KF10flkclPJzSnFm60toe7nf4j6H3Oe/ADszjY
	 2jSw3arIPF/AftSt0yXxwtLWmsoMP7BtXG89UNDcIOumV/eW3oXjLIWIabM/F7mYHB
	 MNr/mIx1oHVbQ==
Subject: Re: [PATCH net-next v3 4/9] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt2712_set_delay
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
Date: Tue, 20 Oct 2026 13:10:50 +0000
Message-ID: <179250185040.3135.9271701401823597487@kernel.org>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-4-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-4-25daf2bbcf35@collabora.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c,
  mt2712_set_delay() now uses the wrong picosecond-per-stage divisor for…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  mt2712_gmac_variant uses a single rx_delay_max/tx_delay_max of 17600ps…

--

net: stmmac: mediatek: simplify TX/RX delay handling in mt2712_set_delay

This commit removes mt2712_delay_ps2stage() and mt2712_delay_stage2ps().
Those helpers converted the TX/RX delays in the driver data in place. The
stage values are now computed in local variables inside mt2712_set_delay(),
and new defines are added for the MT2712 delay stage dividers and maximum
values.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index f7eb85110df08..596411d4a5b2b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -36,6 +36,14 @@
>  #define ETH_FINE_DLY_GTXC	BIT(1)
>  #define ETH_FINE_DLY_RXC	BIT(0)
>  
> +#define MT2712_RMII_DLY_RXC_STAGE_DIV	170 /* 170ps per stage */
> +#define MT2712_RMII_DLY_TXC_STAGE_DIV	170 /* 170ps per stage */
> +
> +#define MT2712_RGMII_DLY_RXC_STAGE_DIV	550 /* 550ps per stage */
> +#define MT2712_RGMII_DLY_RXC_MAX	17600 /* 32 x 550ps */
> +#define MT2712_RGMII_DLY_TXC_STAGE_DIV	550 /* 550ps per stage */
> +#define MT2712_RGMII_DLY_TXC_MAX	17600 /* 32 x 550ps */
> +

[ ... ]

> @@ -129,71 +137,36 @@ static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat,
>  	return 0;
>  }
>  
> -static void mt2712_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
> -{
> -	struct mac_delay_struct *mac_delay = &plat->mac_delay;
> -
> -	switch (plat->phy_mode) {
> -	case PHY_INTERFACE_MODE_MII:
> -	case PHY_INTERFACE_MODE_RMII:
> -		/* 550ps per stage for MII/RMII */
> -		mac_delay->tx_delay /= 550;
> -		mac_delay->rx_delay /= 550;
> -		break;
> -	case PHY_INTERFACE_MODE_RGMII:
> -	case PHY_INTERFACE_MODE_RGMII_TXID:
> -	case PHY_INTERFACE_MODE_RGMII_RXID:
> -	case PHY_INTERFACE_MODE_RGMII_ID:
> -		/* 170ps per stage for RGMII */
> -		mac_delay->tx_delay /= 170;
> -		mac_delay->rx_delay /= 170;
> -		break;

[ ... ]

>  static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>  {
>  	struct mac_delay_struct *mac_delay = &plat->mac_delay;
> -	u32 delay_val = 0, fine_val = 0;
> +	u32 rx_delay_stage_val, tx_delay_stage_val;
> +	u16 rx_delay_stage_div, tx_delay_stage_div;
> +	u32 delay_val = 0;
> +	u32 fine_val = 0;
>  
> -	mt2712_delay_ps2stage(plat);
> +	if (phy_interface_mode_is_rgmii(plat->phy_mode)) {
> +		rx_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV;
> +		tx_delay_stage_div = MT2712_RGMII_DLY_TXC_STAGE_DIV;
> +	} else {
> +		rx_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV;
> +		tx_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV;
> +	}
> +	rx_delay_stage_val = mac_delay->rx_delay / rx_delay_stage_div;
> +	tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;

[Severity: High]
Are the RGMII and MII/RMII stage dividers swapped here?

The removed mt2712_delay_ps2stage() divided MII/RMII delays by 550 and
RGMII delays by 170. The binding in
Documentation/devicetree/bindings/net/mediatek-dwmac.yaml says the same
thing for mediatek,tx-delay-ps and mediatek,rx-delay-ps:

    For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
    or will round down. Range 0~31*170.
    For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
    or will round down. Range 0~31*550.

The new defines use 550 for RGMII and 170 for MII/RMII. The commit message
describes the same reversed mapping:

    by dividing them by a constant (550 for RGMII, 170 for MII/RMII)

The in-tree arch/arm64/boot/dts/mediatek/mt2712-evb.dts uses
phy-mode = "rgmii-rxid" and mediatek,tx-delay-ps = <1530> (9 x 170ps).
For that board, the GTXC stage count written to PERI_ETH_DLY drops from 9
to 1530 / 550 = 2.

In MII/RMII mode, a binding-valid 1100ps (2 x 550ps) now becomes 6 stages,
which is roughly 3300ps on the hardware. Any value above 31 * 170 no longer
fits in the 5-bit ETH_DLY_*_STAGES fields, and FIELD_PREP() truncates it.

This path runs on every probe and resume through mediatek_dwmac_init() ->
mt2712_set_delay(). Could it keep the link from coming up, or corrupt
TX/RX data, on MT2712 boards that set a delay property?

The problem is still there at the end of the series. In the later patch
"net: stmmac: mediatek: add RX/TX delay stage divider in platform data",
mt2712_gmac_variant sets .rx_rgmii_delay_stage_div to
MT2712_RGMII_DLY_RXC_STAGE_DIV (550) and the rmii dividers to 170. It also
sets .tx_rgmii_delay_stage_div to MT2712_RMII_DLY_TXC_STAGE_DIV (170),
which looks like a typo.

That typo happens to restore the RGMII TX divider for mt2712-evb. RGMII RX
and all MII/RMII delays still appear to use the wrong divider.

[ ... ]

> @@ -263,19 +248,17 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)

[ ... ]

>  static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
> -		.dwmac_set_phy_interface = mt2712_set_interface,
> -		.dwmac_set_delay = mt2712_set_delay,
> -		.clk_list = mt2712_dwmac_clk_l,
> -		.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
> -		.rx_delay_max = 17600,
> -		.tx_delay_max = 17600,
> -		.dma_bit_mask = 33,
> +	.dwmac_set_phy_interface = mt2712_set_interface,
> +	.dwmac_set_delay = mt2712_set_delay,
> +	.clk_list = mt2712_dwmac_clk_l,
> +	.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
> +	.rx_delay_max = MT2712_RGMII_DLY_RXC_MAX,
> +	.tx_delay_max = MT2712_RGMII_DLY_TXC_MAX,
> +	.dma_bit_mask = 33,
>  };

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Should
the MT2712 delay limit depend on the phy mode?

mt2712_gmac_variant applies one 17600ps rx_delay_max/tx_delay_max to every
interface mode. mediatek_dwmac_config_dt() only rejects values at or above
that limit:

    if (tx_delay_ps < plat->variant->tx_delay_max) {
        mac_delay->tx_delay = tx_delay_ps;

The ETH_DLY_GTXC_STAGES, ETH_DLY_TXC_STAGES and ETH_DLY_RXC_STAGES fields
are 5 bits wide, so each holds at most 31 stages.

In the 170ps per stage mode (RGMII per the binding), any accepted value
above 31 * 170 = 5270ps gives a stage count between 32 and 103. FIELD_PREP()
on a runtime value just masks it (for example 100 & 0x1f = 4). The result
is an unrelated delay, written with the ENABLE bit still set and no error
reported.

The binding documents a separate range for each mode (RGMII 0~31*170,
MII/RMII 0~31*550).

This patch also moves the limit into macros named MT2712_RGMII_DLY_*_MAX
with the comment "32 x 550ps". That does not match the 170ps RGMII stage
given in the binding.

Because of the swapped dividers above, binding-valid MII/RMII values can
now overflow as well. That part goes away once the divider swap is fixed.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35%40collabora.com
