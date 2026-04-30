Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4C1B7910;
	Thu, 30 Apr 2026 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777576806; cv=none; b=BoQ6JOpJFLTJZyzoXFVYUx/I4pXWXsLMIm3qqzoqG3n0wmli/ePX26XbD6XKBdeo3yz3hryUD8bIuRGjbc5oYHeMD3D3AfRBGho57Ziq+C0NRnJUSSGQSuTzC81qUHYlOJnjZ5k8lujhw9NVFO5knpW00Gu998wfZAXv6q6ExxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777576806; c=relaxed/simple;
	bh=yngHXCdLOX9WcF1ZvGikqIbrivyRQzQ00lMFOMonbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buRY2eGtuy36qAEYomu8jentqyMpmKMC2fcpifa0kBdk/CZwhcN8hKgv42JHKE24tZ2RyRwHiDWAOpEHhkceTDMYcCGujqVNpTzIY1NDYDnD8ALSXhfJcpJ6PYe0JW7D5w4vtXtrkM5UgPDjo4xqdp/c93C3pUxs3gCE5W1rmcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4Yaj2CXC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4Yaj2CXC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=yYL0m2NpGuC8cQZ16sthHWLR12GwbfVRy713DtlQGmM=; b=4Yaj2CXCVjEJVTb1s7cgTK3IEx
	ojA14TAApXVSdC/8RvGjH1nSSxj95o0dDpNTdV/8sy2UzaN98cEEh85ytnbQKma88zKMM4hP0Cq8x
	WG9JPo3BGDuPC8tYe7AVQWXs62fTVlGUw0KOFiGO9BdvyBS4s3kxji1UxcKLzaJ1OJRE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wIWvX-000jCW-FK; Thu, 30 Apr 2026 21:19:59 +0200
Date: Thu, 30 Apr 2026 21:19:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH net-next v3 4/4] net: dsa: initial support for MT7628
 embedded switch
Message-ID: <eccbc14b-fec1-4023-b95a-b0c45eb6df22@lunn.ch>
References: <20260428185510.261521-1-joey@tinyisr.com>
 <20260428185510.261521-5-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428185510.261521-5-joey@tinyisr.com>

>  source "drivers/net/dsa/lantiq/Kconfig"
>  
> +config NET_DSA_MT7628
> +	tristate "MediaTek MT7628 Embedded Ethernet switch support"
> +	select NET_DSA_TAG_MT7628
> +	select MEDIATEK_FE_SOC_PHY
> +	help
> +	  This enables support for the built-in Ethernet switch found
> +	  in the MT7628 SoC.
> +
>  config NET_DSA_MT7530
>  	tristate "MediaTek MT7530 and MT7531 Ethernet switch support"

NET_DSA_MT7628 is > NET_DSA_MT7530 so should come second.

> +static int mt7628_mii_read(struct mii_bus *bus, int port, int regnum)
> +{
> +	struct mt7628_esw *esw = bus->priv;
> +	int ret;
> +	u32 val;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       !(val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_write(esw->regmap, MT7628_ESW_REG_PCR0,
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_REG,
> +				      regnum) |
> +			   FIELD_PREP(MT7628_ESW_PCR0_CPU_PHY_ADDR,
> +				      port) | MT7628_ESW_PCR0_RD_PHY_CMD);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_RD_DONE), 10,
> +				       5000);
> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "read failed. MDIO timeout?\n");
> +		return ret;
> +	}
> +	return FIELD_GET(MT7628_ESW_PCR1_RD_DATA, val);

This works, but it is an unusual structure. Normally the label is
after the normal exist path, and only deals with errors.

> +}
> +
> +static int mt7628_mii_write(struct mii_bus *bus, int port, int regnum, u16 dat)
> +{
> +	ret = regmap_read_poll_timeout(esw->regmap, MT7628_ESW_REG_PCR1, val,
> +				       (val & MT7628_ESW_PCR1_WT_DONE), 10,
> +				       5000);
> +out:
> +	if (ret) {
> +		dev_err(&bus->dev, "write failed. MDIO timeout?\n");
> +		return ret;
> +	}
> +	return 0;
> +}

Same here.

Otherwise this looks O.K.

	  Andrew
