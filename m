Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFAC39FCC8;
	Sun,  4 Oct 2026 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121401; cv=none; b=XXAjhNB41C5xG+Zm56Fz6wEYWppDSq9SCc6FJwD/M/p71efPUIccLq2gJDTBYERcrwn8wBHCY5T3WKHXPNU58Fj78//nETq9EuJjefYIyUUqjxpO6WsMsQVe15F8Udc3/vigoaruPDnQTelcczhNQyF2JDtVw6U/LKW2xykSLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121401; c=relaxed/simple;
	bh=f8Ky1lmmzQgBnfR/naDlOSzFpNPuQI5ErdSdRBP8qwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0VZy+sJp20SUf+vXU5Ml+pgFEi0QSab8bBqER/U3DST8SbCnkReJ6UYTwvuvvwUWVFuD6QKHraTnPxhNCgju6nWk1dwh6f9TveGPgrtVCexoHKkRGbz4ZyGJugjeCIMq1Rw1Rzax6VtiYHcnM8V9PfNHokVHYlyXUBWqneH/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=uHEeaimB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="uHEeaimB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 68DBD4E40EF7;
	Sun,  4 Oct 2026 13:43:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3AF42604FE;
	Sun,  4 Oct 2026 13:43:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5A8B1032817F;
	Sun,  4 Oct 2026 15:43:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791121395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=CLiUHIWFmtNaLuEgpnYbT+UE8XjzCXBDvMFk3U6jpLA=;
	b=uHEeaimBReXq/2prH4nTXIvcR213XvTWIW2rRlyksLQ7FT17VdOUaG/uzW2ggPFnj/O+lM
	coDtdoU+4aq3c6b1XY6Er8NWhqBXQQXoabJB4ciCJq2QF14VlkQiSLKQbW1fZzbFeVy90D
	bk3X0jDBk83ZzLi/SX0HrFBqT1raEBOjYSfHg47331jjzN72y9iZDi82NGH5nexYoMrEk/
	Lf5XGEPBacaP+UyzZZEv5j5i5+yU4/LFkf5baL0nF5frkt6Ec9DIYqV4Jc/5oEDp7FPYVc
	XGKW8jb/xcdzt5cEz0l2rrXQGxEWSyc8AL2vc6trAx+KDyA6H7jHwQK/n/WLJA==
Message-ID: <47b9d9a2-18cb-4726-82f7-772d108b2ee8@bootlin.com>
Date: Sun, 4 Oct 2026 15:43:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/7] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt8195_set_delay
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Biao Huang <biao.huang@mediatek.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
 <20260924-dwmac-mediatek-mt8189-v2-2-430bd74d5ef9@collabora.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-2-430bd74d5ef9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hey,

On 9/24/26 09:23, Louis-Alexis Eyraud wrote:
> The mt8195_set_delay function modifies at its beginning the TX and RX
> internal delay variables, located in the driver data, by dividing
> them by a constant (290) and restores their original values by
> multiplying them again at the function end. It is done in order to
> convert them into a step value, used by the hardware registers for
> setting these delays.
> 
> But this is rather pointless to modify the driver data for that, while
> it could be done locally in the function. The original delay values
> cannot be used anymore (if needed) during mt8195_set_delay processing.
> Finally, they are altered after the function call if they are not a
> multiple of 290.
> 
> So, simplify these delay variable handling by using local variables to
> convert them into the register value and use those in the write calls.
> Also, remove the two private conversion functions, that are not useful
> anymore and add definitions for MT8195 RX/TX delay maximum and divider
> values.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Looking at this, seems like the 2712 support could benefit from the same
cleanups you've done with the weird division / remultiplication.

That can be a separate cleanup though.

Maxime


> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 77 ++++++++++------------
>  1 file changed, 36 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 30ae0dba7fff..f7eb85110df0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -63,6 +63,11 @@
>  #define MT8195_DLY_RMII_TXC_ENABLE	BIT(5)
>  #define MT8195_DLY_RMII_TXC_STAGES	GENMASK(4, 0)
>  
> +#define MT8195_DLY_RXC_STAGE_DIV	290 /* 290ps per stage */
> +#define MT8195_DLY_RXC_MAX		9280 /* 32 x 290ps */
> +#define MT8195_DLY_TXC_STAGE_DIV	290 /* 290ps per stage */
> +#define MT8195_DLY_TXC_MAX		9280 /* 32 x 290ps */
> +
>  struct mac_delay_struct {
>  	u32 tx_delay;
>  	u32 rx_delay;
> @@ -293,39 +298,27 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
>  	return 0;
>  }
>  
> -static void mt8195_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
> -{
> -	struct mac_delay_struct *mac_delay = &plat->mac_delay;
> -
> -	/* 290ps per stage */
> -	mac_delay->tx_delay /= 290;
> -	mac_delay->rx_delay /= 290;
> -}
> -
> -static void mt8195_delay_stage2ps(struct mediatek_dwmac_plat_data *plat)
> -{
> -	struct mac_delay_struct *mac_delay = &plat->mac_delay;
> -
> -	/* 290ps per stage */
> -	mac_delay->tx_delay *= 290;
> -	mac_delay->rx_delay *= 290;
> -}
> -
>  static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  {
>  	struct mac_delay_struct *mac_delay = &plat->mac_delay;
> -	u32 gtxc_delay_val = 0, delay_val = 0, rmii_delay_val = 0;
> -
> -	mt8195_delay_ps2stage(plat);
> +	u32 rx_delay_stage_val = mac_delay->rx_delay / MT8195_DLY_RXC_STAGE_DIV;
> +	u32 tx_delay_stage_val = mac_delay->tx_delay / MT8195_DLY_TXC_STAGE_DIV;
> +	u32 gtxc_delay_val = 0;
> +	u32 rmii_delay_val = 0;
> +	u32 delay_val = 0;
>  
>  	switch (plat->phy_mode) {
>  	case PHY_INTERFACE_MODE_MII:
> -		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE, !!mac_delay->tx_delay);
> -		delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES, mac_delay->tx_delay);
> +		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
> +					!!tx_delay_stage_val);
> +		delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES,
> +					tx_delay_stage_val);
>  		delay_val |= FIELD_PREP(MT8195_DLY_TXC_INV, mac_delay->tx_inv);
>  
> -		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
> -		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES, mac_delay->rx_delay);
> +		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE,
> +					!!rx_delay_stage_val);
> +		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES,
> +					rx_delay_stage_val);
>  		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
>  		break;
>  	case PHY_INTERFACE_MODE_RMII:
> @@ -336,16 +329,16 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  			 * The ingress timing can be adjusted by RMII_RXC delay macro circuit.
>  			 */
>  			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_TXC_ENABLE,
> -						     !!mac_delay->tx_delay);
> +						     !!tx_delay_stage_val);
>  			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_TXC_STAGES,
> -						     mac_delay->tx_delay);
> +						     tx_delay_stage_val);
>  			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_TXC_INV,
>  						     mac_delay->tx_inv);
>  
>  			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_RXC_ENABLE,
> -						     !!mac_delay->rx_delay);
> +						     !!rx_delay_stage_val);
>  			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_RXC_STAGES,
> -						     mac_delay->rx_delay);
> +						     rx_delay_stage_val);
>  			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_RXC_INV,
>  						     mac_delay->rx_inv);
>  		} else {
> @@ -361,9 +354,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  				 * by RXC delay macro circuit.
>  				 */
>  				delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE,
> -							!!mac_delay->rx_delay);
> +							!!rx_delay_stage_val);
>  				delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES,
> -							mac_delay->rx_delay);
> +							rx_delay_stage_val);
>  				delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV,
>  							mac_delay->rx_inv);
>  			} else {
> @@ -372,9 +365,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  				 * by TXC delay macro circuit.
>  				 */
>  				delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
> -							!!mac_delay->rx_delay);
> +							!!rx_delay_stage_val);
>  				delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES,
> -							mac_delay->rx_delay);
> +							rx_delay_stage_val);
>  				delay_val |= FIELD_PREP(MT8195_DLY_TXC_INV,
>  							mac_delay->rx_inv);
>  			}
> @@ -384,12 +377,16 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> -		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
> -		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES, mac_delay->tx_delay);
> +		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
> +					     !!tx_delay_stage_val);
> +		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES,
> +					     tx_delay_stage_val);
>  		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv);
>  
> -		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
> -		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES, mac_delay->rx_delay);
> +		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE,
> +					!!rx_delay_stage_val);
> +		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES,
> +					rx_delay_stage_val);
>  		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
>  
>  		break;
> @@ -408,8 +405,6 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL1, delay_val);
>  	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL2, rmii_delay_val);
>  
> -	mt8195_delay_stage2ps(plat);
> -
>  	return 0;
>  }
>  
> @@ -418,8 +413,8 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
>  	.dwmac_set_delay = mt8195_set_delay,
>  	.clk_list = mt8195_dwmac_clk_l,
>  	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
> -	.rx_delay_max = 9280,
> -	.tx_delay_max = 9280,
> +	.rx_delay_max = MT8195_DLY_RXC_MAX,
> +	.tx_delay_max = MT8195_DLY_TXC_MAX,
>  	.dma_bit_mask = 35,
>  };
>  
> 

