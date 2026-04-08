Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95C389DEF;
	Wed,  8 Apr 2026 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775662617; cv=none; b=RH2aVLhs61fmZLkY6Rx8E5ckIpM0Rw+4WBNzDNCzr9nvrg7HabukYeAIkm1kBNZM1Amn15EJN/8Q5zEkCunIhZS0r2shmCyejHVLgL6L1fU5VGjMIWnsbOIrCSqv88FLABNQ9O492fiGwNFLld8Z9P9eQIXhaopJq9C6+HvIeco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775662617; c=relaxed/simple;
	bh=ym2vg1AKuyzbI8HzyzmBjv7ZUl+l33VVFBJwgLV7lHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOXBFKxEtQuyhMj6qZYRiYqTWY/f6FxAKACXl/E5S8F/tcV8VvnWXrnAHxumNx63+tjnJKkL6oHcPnXnwLxyKAUPhBhfTDlJGebkHybjOpQgwT6V4cargvpmLStUNcvq1n8dR0Bm3XR7rUHsHYmArf8YjV+0mtzpf+Sg9/I9ZOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qqqCIuF3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qqqCIuF3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tmXoZY5aOkLaEImVN2vLVAA9DnhfryMldvyw6aUObFs=; b=qqqCIuF3RhYGf2fcPvNK972dB8
	lfrtDS0g6bOxJ4GS74+lkbwq0age0DAaux/e+jwYcJzdLYB/dyJQv79qDD3uDSURwQTZCwN8kAjya
	3XgiySpkzgtYicJ6I2O3U3yIMGiEz57xt89kmlg5uW9ZpwtjAo0klB/sV9wWMPGstq5k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAUxQ-00FJGO-T3; Wed, 08 Apr 2026 17:36:44 +0200
Date: Wed, 8 Apr 2026 17:36:44 +0200
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v1 v1 4/5] net: stmmac: starfive: Add JHB100 SGMII
 interface
Message-ID: <49407bd8-f20b-46f7-9b98-8c88fc45e0f0@lunn.ch>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
 <20260408084416.29753-5-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408084416.29753-5-minda.chen@starfivetech.com>

> +	dwmac->sgmii_rx = devm_clk_get_optional(&pdev->dev, "rx");
> +	if (IS_ERR(dwmac->sgmii_rx))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(dwmac->sgmii_rx),
> +				     "error getting sgmii rx clock\n");
> +

The SGMII clock is optional...

>  	/* Generally, the rgmii_tx clock is provided by the internal clock,
>  	 * which needs to match the corresponding clock frequency according
>  	 * to different speeds. If the rgmii_tx clock is provided by the
>  	 * external rgmii_rxin, there is no need to configure the clock
>  	 * internally, because rgmii_rxin will be adaptively adjusted.
>  	 */
> -	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk"))
> -		plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
> +	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk")) {
> +		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII)
> +			plat_dat->set_clk_tx_rate = stmmac_starfive_sgmii_set_clk_rate;

So you probably want to return an error here if it is missing.

Or you might want to look at the compatible, and make the clock
mandatory for this device.

   Andrew
