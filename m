Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A53ED3D7;
	Tue, 19 May 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200279; cv=none; b=A61TDF2JosEzlld3/IyynVFiA2fwbXAat5EcYuLaa+TRx+YaL6SI5TAKEOL+Fai5xqIhkz0lRMO8WkPM+ONsSg7HW/N2VQGQWNmM5RRKC9wzszNXsF6XCiszJai9X1C+mzVo9XsDV8bTQpRUVBk1wzLUWV4Y40W9F48p99AlxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200279; c=relaxed/simple;
	bh=ZK7FBzTn8EuL096Y3tJRxcMwGvSwAQayMkhLQ0y6elk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIIuRnA5GAJ0Qerh0qXQlOuCnXjfnydHMrFYrCAPH+EstFQhR+2i8ak5e4YVF4FYaOIKo1XdAODTytj/WjqnspP6m/M3obejkCF2a22jB/DiAlGQHfbxQoH9UUUn6Cnc2WFw/UloZIVLPSWbu5pzSm6dwZSDlofVq1o2iMKoFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ryV0i+6k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ryV0i+6k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QaO48AAWxgV+yw0EkvBhAuqLsdVLtj1924pNS0Io8fc=; b=ryV0i+6kdnWANvaww2wot9+ZnZ
	+wFVUgptde9fiBUK22O97D8T2cGz6UkpqXCmDH/tsHlS8ZHUFI/1tKHLSJrt0ZYLVzIufLBd9LX1t
	te94etpns18S0qBhuyuJwXV0QIUtz/6Zwt8cThdwkSvVThlp0X+v03IhbdhttoL+uE3U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPLGM-003g5i-8J; Tue, 19 May 2026 16:17:38 +0200
Date: Tue, 19 May 2026 16:17:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v4 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Message-ID: <6eff2d70-a0ac-4d9c-8261-eb5249b7c877@lunn.ch>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
 <20260519101436.111476-5-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519101436.111476-5-minda.chen@starfivetech.com>

> +static int stmmac_starfive_sgmii_set_clk_rate(void *bsp_priv, struct clk *clk_tx_i,
> +					      phy_interface_t __maybe_unused interface,
> +					      int speed)
> +{
> +	struct starfive_dwmac *dwmac = bsp_priv;
> +	long rate = rgmii_clock(speed);
> +	int ret;
> +
> +	/* MAC clock rate the same as RGMII */
> +	if (rate < 0)
> +		return 0;

You probably should return the error code, because something has gone
wrong, you have been asked to do a rate you don't support.

> +	ret = clk_set_rate(clk_tx_i, rate);
> +	if (ret)
> +		return ret;
> +
> +	return clk_set_rate(dwmac->sgmii_rx, rate);
> +}
> +
>  static int starfive_dwmac_probe(struct platform_device *pdev)
>  {
>  	struct plat_stmmacenet_data *plat_dat;
> @@ -102,23 +122,33 @@ static int starfive_dwmac_probe(struct platform_device *pdev)
>  		return dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
>  				     "error getting gtx clock\n");
>  
> -	/* Generally, the rgmii_tx clock is provided by the internal clock,
> -	 * which needs to match the corresponding clock frequency according
> -	 * to different speeds. If the rgmii_tx clock is provided by the
> -	 * external rgmii_rxin, there is no need to configure the clock
> -	 * internally, because rgmii_rxin will be adaptively adjusted.
> -	 */
> -	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
> -		plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
> -
>  	dwmac->dev = &pdev->dev;
> -	plat_dat->flags |= STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
>  	plat_dat->bsp_priv = dwmac;
> -	plat_dat->dma_cfg->dche = true;
> +	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {

Does the PCS support 1000BaseX? It is not needed now, but it is
something to keep in mind, try to avoid making to code too SGMII
specific when it might need to be more generic to support 1000BaseX as
well.

	Andrew
