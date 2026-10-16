Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5CD39794A
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792150679; cv=none; b=o8FXjcmBgYEuX9+XtMnsDd9vCwSx0l08xstnslqFXadZxmOMR9My8CNYvmnldsuv3EhpF1w1S3AHfDUKqrUMDfjYKLu3LM6pFpn7FWW8fed5JGJ4w+7CFxxj18ei0o7F/XMcWrurWHMkQsj+tzj5tqmJRSsRa5nP1AeBBpZ5FCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792150679; c=relaxed/simple;
	bh=hURAYmRiGjFW3uRx49r6YrGzPgKt06TgM9IXY6vfPsk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OkZ77le+6szIbG0w2Lv8n8GKu5uXff6pvmlQDMeGE2RjMFDAAk9NaIDUif7RH1P3ePozi3JsnJI93/MU1l00Vt77EOrt8I1FvcambCzXiU4Wgs+S/ZTl9ICEFN7UHut6ji7IkdCxgwIw0rUEYY1bf/P1j4RmepbkpNLmpT9KsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DOVSw9oI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DOVSw9oI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1CC501A1251;
	Fri, 16 Oct 2026 11:37:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DD40E6075D;
	Fri, 16 Oct 2026 11:37:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 38F5610328153;
	Fri, 16 Oct 2026 13:37:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792150669; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9GRmkk0d7/PC2JYZ6s87MIdsq4qp1zD1dJ0+v2vwEqA=;
	b=DOVSw9oI99DtbYEp6j/IMxmzCvhQrVrV9IRzEyczUgqy6HHPbxXruaeiDSNanNAfldxFfj
	QBmgYZpLAo5JLMjFMRsN65bzPuPjoadxWuVMjgEBsuc7gtos1IvD9hrJoyUjtVpc+kgvgt
	ojQ0upsve+H0brWS+pQEPLnkB6VmNkoUU2VfkryWBniwZnaLTRjB6UNY7Mp4QuPZiilxWd
	e7QnoyiDYek5sVmIs/gOKJrB3YxCnIsaJfRQRJgJbogTl2FoAKkpuqoOOY2ia5MvI2aoZD
	pIfHxwpdC0CsLbBbaKR1KWFR1j+JBjqgZF/zoYR8P3rco2vIudsLUJo8Tg4nXg==
Message-ID: <34608ab8-18f3-4680-8276-cd8611c05cb1@bootlin.com>
Date: Fri, 16 Oct 2026 13:37:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/9] net: stmmac: mediatek: add RX/TX delay
 stage divider in platform data
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Biao Huang <biao.huang@mediatek.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Eric Dumazet <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
 <20261016-dwmac-mediatek-mt8189-v3-5-25daf2bbcf35@collabora.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-5-25daf2bbcf35@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Louis-Alexis,

On 10/16/26 12:31, Louis-Alexis Eyraud wrote:
> In preparation of newer SoC support, that have like MT8189 SoC
> different RX and TX internal delay stage steps than MT8188/MT8195, add
> the RX and TX delay stage divider values in the variant platform data
> and replace the hardcoded value uses in mt2712_set_delay and
> mt8195_set_delay.
> 
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 46 ++++++++++++++++++----
>  1 file changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index 596411d4a5b2..cb5bda53edb9 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -108,6 +108,10 @@ struct mediatek_dwmac_variant {
>  
>  	u32 rx_delay_max;
>  	u32 tx_delay_max;
> +	u16 rx_rmii_delay_stage_div;
> +	u16 tx_rmii_delay_stage_div;
> +	u16 rx_rgmii_delay_stage_div;
> +	u16 tx_rgmii_delay_stage_div;
>  	u8 dma_bit_mask;
>  };
>  
> @@ -146,14 +150,22 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
>  	u32 fine_val = 0;
>  
>  	if (phy_interface_mode_is_rgmii(plat->phy_mode)) {
> -		rx_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV;
> -		tx_delay_stage_div = MT2712_RGMII_DLY_TXC_STAGE_DIV;
> +		rx_delay_stage_div = plat->variant->rx_rgmii_delay_stage_div;
> +		tx_delay_stage_div = plat->variant->tx_rgmii_delay_stage_div;
>  	} else {
> -		rx_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV;
> -		tx_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV;
> +		rx_delay_stage_div = plat->variant->rx_rmii_delay_stage_div;
> +		tx_delay_stage_div = plat->variant->tx_rmii_delay_stage_div;

Looking closer at this, what's RMII delay ? There's no delays in RMII, and
it's a single clock not a RX and TX clock like RGMII, there's no RMII TXC/RXC.

I think it's the same as on allwinner, the delay handling has been mixed-up between
RMII and RGMII in the glue, you should be able to simplify this even more by
ditching the RMII case.

Maxime
