Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBF43932A;
	Sun,  4 Oct 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121270; cv=none; b=k64JaX/Swv+MNcXk/xReaZDDLx6Houb85zoOaIIlgzF8vXshtgpvuQVgBikvGq0OjXSLmPfrYZqxIBOBWvLM72jLfWOZcfIxEGHHIavP3Sxp4ZAgaZyr0NN1qGsixbCnynphsJaexPChIkFT8TSNwaBlhsYt1Cf5DWvhDRwaEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121270; c=relaxed/simple;
	bh=qYSHF+X139cwmIzUUroDNV1G+HYXki0eyfluRiEVUFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5pWr5u9UpznAHbdyV+RK7/eT5S1pmoTkqu0CJGSIQdRMk7QPRJBDEngIQ7HLyVQK5vOhUSafyqeUclSGSgoTzddlRXD0k8uKVpQT/yUVc1zGwLbwJPvV44FQfamI4RTAc2WwFb49giORFC2ZtIaKKYLmKcyJj2tG1C6iU+bpG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NvJQmWY6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NvJQmWY6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id CE4D41A1129;
	Sun,  4 Oct 2026 13:41:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29736604FE;
	Sun,  4 Oct 2026 13:41:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A72C1032817F;
	Sun,  4 Oct 2026 15:40:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791121263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ihd+dofvU6Mcgj3MdWdld4bUs480ZOkVZ8XCTiohnu8=;
	b=NvJQmWY6oV3Ja8xANIq3B3P9pcEN+tee1cqds4XePR5AAnzLOaknyImx+sZw2QP9RrlXLL
	eHpb9Q6y8Qr3aXJXh6klwYhtolMHCP/1xooHI/SZXhaBSs9O14zhoWt1KBOvYa5aGJyZAt
	ypm/zMhH98KMkIWI4HKqQWRMz6NE3D1apdac1VRIoszUyE8Iaz30wjhq8UqZACrqPekFTg
	CnBgGke4wA6VzRxfbOBuPy6jFZGwQjmPCX8usxGOlLV9F34mKppDxW5zsU9wkxnJfRTYjF
	VcV9c4vtzdMC3s6ZpMKmKAHHk0XGLfT8HIIXKckonFsxD8tXPqvwsrAZNQClLg==
Message-ID: <c76a27fd-4131-4a4d-a832-de96e0006a55@bootlin.com>
Date: Sun, 4 Oct 2026 15:40:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/7] net: stmmac: mediatek: add RX/TX delay
 stage divider in platform data
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
 <20260924-dwmac-mediatek-mt8189-v2-3-430bd74d5ef9@collabora.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-3-430bd74d5ef9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/24/26 09:23, Louis-Alexis Eyraud wrote:
> In preparation of newer SoC support, that have like MT8189 SoC
> different RX and TX internal delay stage steps than MT8188/MT8195, add
> the RX and TX delay stage divider values in the variant platform data
> and replace the hardcoded value use in mt8195_set_delay.
> 
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> index f7eb85110df0..1c532cc3a975 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
> @@ -100,6 +100,8 @@ struct mediatek_dwmac_variant {
>  
>  	u32 rx_delay_max;
>  	u32 tx_delay_max;
> +	u16 rx_delay_stage_div;
> +	u16 tx_delay_stage_div;
>  	u8 dma_bit_mask;
>  };
>  
> @@ -300,13 +302,25 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
>  
>  static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
>  {
> +	u16 rx_delay_stage_div = plat->variant->rx_delay_stage_div;
> +	u16 tx_delay_stage_div = plat->variant->tx_delay_stage_div;
>  	struct mac_delay_struct *mac_delay = &plat->mac_delay;
> -	u32 rx_delay_stage_val = mac_delay->rx_delay / MT8195_DLY_RXC_STAGE_DIV;
> -	u32 tx_delay_stage_val = mac_delay->tx_delay / MT8195_DLY_TXC_STAGE_DIV;
> +	u32 rx_delay_stage_val;
> +	u32 tx_delay_stage_val;
>  	u32 gtxc_delay_val = 0;
>  	u32 rmii_delay_val = 0;
>  	u32 delay_val = 0;
>  
> +	if (rx_delay_stage_div)
> +		rx_delay_stage_val = mac_delay->rx_delay / rx_delay_stage_div;
> +	else
> +		rx_delay_stage_val = 0;
> +
> +	if (tx_delay_stage_div)
> +		tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
> +	else
> +		tx_delay_stage_val = 0;
> +
>  	switch (plat->phy_mode) {
>  	case PHY_INTERFACE_MODE_MII:
>  		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
> @@ -415,6 +429,8 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
>  	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
>  	.rx_delay_max = MT8195_DLY_RXC_MAX,
>  	.tx_delay_max = MT8195_DLY_TXC_MAX,
> +	.rx_delay_stage_div = MT8195_DLY_RXC_STAGE_DIV,
> +	.tx_delay_stage_div = MT8195_DLY_TXC_STAGE_DIV,
>  	.dma_bit_mask = 35,
>  };
>  
> 

