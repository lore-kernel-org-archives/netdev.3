Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C02388369
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 09:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791365739; cv=none; b=h8PcMp5x/Fr/7hPhQ4dxsO1S7x33aa+qTZcdUnAZrixphIrgtiL9adJaCOF+gZfXzTLCkxGUPkaTpIwO/iaQQffJ7UnadVXqmxr6ajsPik4xueFznUW+XGwH01fCPO8mr6/Hia+F/KM6gZi2t/DXMECf3GtYg4nNZ3yrDXAeh2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791365739; c=relaxed/simple;
	bh=HZ4Yai8hHKkjGNwF1DyF5ppHLfujuiudOKsOWhFEiMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TPOvKSIPlj2Eq5eRFZ06xfenPpaEgaSamE+rGTEJt2oDqBapSyOdsCype5fctrgscFPh5WyZlQMwRXTbjH1zX5OFEJHzLlwcSmsYXLBdIpEYpFzMfLemCzSMuPixg1cAJ5+hFswUgHr+HMlVCTfygXK5Y2Fitr9Eqpn7zgbDlcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F6vLO8/J; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F6vLO8/J"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 10CCD1A1152;
	Wed,  7 Oct 2026 09:35:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D0BCE6074B;
	Wed,  7 Oct 2026 09:35:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C9EC11D5006E;
	Wed,  7 Oct 2026 11:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791365718; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xQN3wQkVGd6JZIsxjTwgNRXi/qvLUOwJEvsQFsaSMuc=;
	b=F6vLO8/Jrxzbe/6VTfHp1fxHL49UWZ7bUNvCBV6S3aWj9qw4/Y+NYCnR+wXXtMVF21vtN8
	6HO18hsdYrmSr3IcUe2mcYmZiNvV8UMqDzr+mA6xQj+34muF/6X8kXoalbJzvztH26FNBa
	K5+OZbd3o0t/hlIz1fWptevr9i2LwGhB7MyPt4CWYzBcKhrRfHzLvkEgXBp/jTbEPTQObp
	7oAGJRThN3DBQLRGYmhO2A1fjO10mSyM258NnQc7qDy09Vmq/uYJdtwgPHdNMHIZeMHZRC
	JINJJrljNLVaiKtvTHsTbReOHINo7BhmDfAKbGYWXUNz9HNrGtFmjQExvdZfCQ==
Message-ID: <517a0416-3c48-4b38-865c-5c0b7e5bd143@bootlin.com>
Date: Wed, 7 Oct 2026 11:35:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/7] net: stmmac: dwmac-meson8b: let the controller
 apply the RGMII delays
To: Lucas Tanure <tanure@linux.com>, xianwei.zhao@amlogic.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261007082627.63807-1-tanure@linux.com>
 <20261007082627.63807-2-tanure@linux.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20261007082627.63807-2-tanure@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Lucas,

On 10/7/26 10:26, Lucas Tanure wrote:
> RGMII needs a delay on each of its two clocks. A board can get it from
> the length of its tracks, from the PHY, or from the controller.
> "rgmii-id" in the device tree says the delay is added inside the chips
> but not which chip adds it, and the generic tx-internal-delay-ps and
> rx-internal-delay-ps properties name the controller.
> 
> This driver ignored those properties. In the "-id" modes it switched
> its own delays off and left the whole job to the PHY, so a board that
> asks the controller for one of them does not get it, and a board whose
> PHY cannot supply that delay has no usable link at all.
> 
> Boards not using those properties behave as before.
> 
> Assisted-by: LLM
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 46 ++++++++++++++++++-
>  1 file changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> index e4d5c41294f4..d73dfd0ac167 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-meson8b.c
> @@ -92,6 +92,8 @@ struct meson8b_dwmac {
>  	struct clk			*rgmii_tx_clk;
>  	u32				tx_delay_ns;
>  	u32				rx_delay_ps;
> +	bool				mac_tx_delay;
> +	bool				mac_rx_delay;
>  	struct clk			*timing_adj_clk;
>  };
>  
> @@ -299,6 +301,22 @@ static int meson8b_init_rgmii_delays(struct meson8b_dwmac *dwmac)
>  		delay_config = rx_adj_config;
>  		break;
>  	case PHY_INTERFACE_MODE_RGMII_ID:
> +		/*
> +		 * "rgmii-id" only says the delays are internal, not which
> +		 * side applies them. The *-internal-delay-ps properties say
> +		 * it is this controller, so leave ours switched on.
> +		 */
> +		if (dwmac->mac_tx_delay || dwmac->mac_rx_delay) {
> +			delay_config = 0;
> +			if (dwmac->mac_tx_delay)
> +				delay_config |= tx_dly_config;
> +			if (dwmac->mac_rx_delay)
> +				delay_config |= rx_adj_config;
> +			else
> +				cfg_rxclk_dly = 0;
> +			break;
> +		}
> +		fallthrough;
>  	case PHY_INTERFACE_MODE_RMII:
>  		delay_config = 0;
>  		cfg_rxclk_dly = 0;
> @@ -384,6 +402,7 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct stmmac_resources stmmac_res;
>  	struct meson8b_dwmac *dwmac;
> +	u32 tx_delay_ps;
>  	int ret;
>  
>  	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
> @@ -409,9 +428,13 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>  	dwmac->dev = &pdev->dev;
>  	dwmac->phy_mode = plat_dat->phy_interface;
>  
> +	/* the generic property is preferred over the vendor one */
> +	if (!of_property_read_u32(pdev->dev.of_node, "tx-internal-delay-ps",
> +				  &tx_delay_ps))
> +		dwmac->tx_delay_ns = tx_delay_ps / 1000;
>  	/* use 2ns as fallback since this value was previously hardcoded */
> -	if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
> -				 &dwmac->tx_delay_ns))
> +	else if (of_property_read_u32(pdev->dev.of_node, "amlogic,tx-delay-ns",
> +				      &dwmac->tx_delay_ns))
>  		dwmac->tx_delay_ns = 2;
>  
>  	/* RX delay defaults to 0ps since this is what many boards use */
> @@ -424,6 +447,25 @@ static int meson8b_dwmac_probe(struct platform_device *pdev)
>  			dwmac->rx_delay_ps *= 1000;
>  	}
>  
> +	/*
> +	 * Each property names one clock this controller delays itself. The
> +	 * PHY must be asked for whatever is left, or the two would delay the
> +	 * same clock and push it past the window.
> +	 */
> +	dwmac->mac_tx_delay = of_property_present(pdev->dev.of_node,
> +						  "tx-internal-delay-ps");
> +	dwmac->mac_rx_delay = of_property_present(pdev->dev.of_node,
> +						  "rx-internal-delay-ps");
> +
> +	if (dwmac->phy_mode == PHY_INTERFACE_MODE_RGMII_ID) {
> +		if (dwmac->mac_tx_delay && dwmac->mac_rx_delay)
> +			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII;
> +		else if (dwmac->mac_tx_delay)
> +			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_RXID;
> +		else if (dwmac->mac_rx_delay)
> +			plat_dat->phy_interface = PHY_INTERFACE_MODE_RGMII_TXID;
> +	}

There's a helper for that :

phy_fix_phy_mode_for_mac_delays(), passed as parameters the mode, and wether the mac
inserts TX/RX delays, and it returns what you should hand out to the PHY :)

> +
>  	if (dwmac->data->has_prg_eth1_rgmii_rx_delay) {
>  		if (dwmac->rx_delay_ps > 3000 || dwmac->rx_delay_ps % 200) {
>  			dev_err(dwmac->dev,

This looks better, thanks for this :)

Maxime
