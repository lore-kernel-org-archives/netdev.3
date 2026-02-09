Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074662264DC;
	Mon,  9 Feb 2026 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644083; cv=none; b=RjhhThne2CueKzXb3TDWL3ib4jK5QA5GTlnyy6PtXa+3eDLZ4noFSCgV7cRpjm5NhOccyYk0/l3aYmjUucl/8PzPnTc+Yv77yc+YDfrEXjLTd9kL1dXjtYLNb9ez+YVbCQFPKOhbmxG0AiWdfuJh4pyTpFFZVB0WZt9tM4uQpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644083; c=relaxed/simple;
	bh=7FoZknSTlCEUeEaMZckB9YDk9vRC2Kga3HC5LlkyvC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iY14Qm56BZr9qu0TVe/YUfJWZs9HMBpqqiT6tiBbAw284gyuP6bFK8+nuWj4EiUo+QVZCJ5VnRc0+9MIQK26+VoTvkNaYkh/SbS8lyA/+ATUFVyvxp2ePWAY3vVC2qZXaAzabjCnt8fhIeqXGi6qs8CqEPNvip+Mj0FTOqxKkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Xa+QQuRA; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Xa+QQuRA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Sh23NSounPEoAE2h79+DwlVVBDgNeh1OQatWs/Guhyc=; b=Xa+QQuRAVaTq3QfgkF6otHND6P
	1tX50Y+PCdAxCTR75mp2UWO7wGqTlAXch2y+oT1au3UH+6n6Tn5vc22nPjgJIgScn+dfxz2scnG/R
	v8cJOik1at9Yt/X7jKqKC0AUini3O6AC+8xAQprfzp1oq6WKGdBEohe/mJ5XhJpe9BR4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vpRPL-006j5z-20; Mon, 09 Feb 2026 14:34:31 +0100
Date: Mon, 9 Feb 2026 14:34:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: lizhi2@eswincomputing.com
Cc: devicetree@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	ningyu@eswincomputing.com, linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com, weishangjuan@eswincomputing.com
Subject: Re: [PATCH v2 2/2] net: stmmac: eic7700: enable clocks before syscon
 access and correct RX sampling timing
Message-ID: <1392e400-9901-4f65-b44b-d257d8196abf@lunn.ch>
References: <20260209094628.886-1-lizhi2@eswincomputing.com>
 <20260209094832.932-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209094832.932-1-lizhi2@eswincomputing.com>

>  static int eic7700_dwmac_init(struct device *dev, void *priv)
>  {
>  	struct eic7700_qos_priv *dwc = priv;
> +	u32 eth_phy_ctrl_regset;
> +	int ret = 0;
> +
> +	ret = eic7700_clks_config(dwc, true);

No point initialising ret if the first thing you do is assign to it.

> +	if (ret)
> +		return ret;
> +
> +	regmap_read(dwc->eic7700_hsp_regmap, dwc->eth_phy_ctrl_offset,
> +		    &eth_phy_ctrl_regset);
> +	eth_phy_ctrl_regset |=
> +		(EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_phy_ctrl_offset,
> +		     eth_phy_ctrl_regset);

regmap_set_bits(dwc->eic7700_hsp_regmap, dwc->eth_phy_ctrl_offset,
		EIC7700_ETH_TX_CLK_SEL | EIC7700_ETH_PHY_INTF_SELI);

> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_axi_lp_ctrl_offset,
> +		     EIC7700_ETH_CSYSREQ_VAL);
> +
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_txd_offset, 0);
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
>  
> -	return eic7700_clks_config(dwc, true);
> +	return ret;

returning ret here seems pointless. You already know it is 0.


>  }
>  
>  static void eic7700_dwmac_exit(struct device *dev, void *priv)
> @@ -88,17 +124,33 @@ static int eic7700_dwmac_resume(struct device *dev, void *priv)
>  	return ret;
>  }
>  
> +static void eic7700_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
> +{
> +	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
> +	u32 dly_param = dwc->eth_clk_dly_param;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		if (dwc->eth_rx_clk_inv)
> +			dly_param |= EIC7700_ETH_RX_INV_DELAY;
> +		break;
> +	case SPEED_100:
> +	case SPEED_10:
> +		break;
> +	default:
> +		dev_err(dwc->dev, "invalid speed %u\n", speed);
> +		break;
> +	}
> +
> +	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset, dly_param);
> +}
> +
>  static int eic7700_dwmac_probe(struct platform_device *pdev)
>  {
> +	const struct eic7700_dwmac_data *data;
>  	struct plat_stmmacenet_data *plat_dat;
>  	struct stmmac_resources stmmac_res;
>  	struct eic7700_qos_priv *dwc_priv;
> -	struct regmap *eic7700_hsp_regmap;
> -	u32 eth_axi_lp_ctrl_offset;
> -	u32 eth_phy_ctrl_offset;
> -	u32 eth_phy_ctrl_regset;
> -	u32 eth_rxd_dly_offset;
> -	u32 eth_dly_param = 0;
>  	u32 delay_ps;
>  	int i, ret;
>  
> @@ -116,13 +168,23 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
>  	if (!dwc_priv)
>  		return -ENOMEM;
>  
> +	dwc_priv->dev = &pdev->dev;
> +
> +	data = device_get_match_data(&pdev->dev);
> +	if (!data)
> +		return dev_err_probe(&pdev->dev,
> +				     -EINVAL, "no match data found\n");
> +
> +	dwc_priv->eth_rx_clk_inv = data->rgmii_rx_clk_invert;
> +
>  	/* Read rx-internal-delay-ps and update rx_clk delay */
>  	if (!of_property_read_u32(pdev->dev.of_node,
>  				  "rx-internal-delay-ps", &delay_ps)) {
> -		u32 val = min(delay_ps / 100, EIC7700_MAX_DELAY_UNIT);
> +		u32 val = min(delay_ps / 20, EIC7700_MAX_DELAY_STEPS);

If the value it too big, please return -EINVAL. You have listed in the
DT binding what the valid range is, not that you clamp to the maximum
value.

>  
> -		eth_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
> -		eth_dly_param |= FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
> +		dwc_priv->eth_clk_dly_param &= ~EIC7700_ETH_RX_ADJ_DELAY;
> +		dwc_priv->eth_clk_dly_param |=
> +				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
>  	} else {
>  		return dev_err_probe(&pdev->dev, -EINVAL,
>  			"missing required property rx-internal-delay-ps\n");

RX and TX internal delays are generally optional, because most boards
don't require them. Default to 0 if not supplied.

    Andrew

---
pw-bot: cr
