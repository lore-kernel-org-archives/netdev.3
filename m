Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A7C3EDACB;
	Thu, 19 Mar 2026 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939361; cv=none; b=jtXQNjXKBEcTPsXeVfqaLUR+Q1gZAdB0o6gFc0Jg8tkIVBpyDXNMUj6FehTs/Z0uKszJ0ZatQjiwTN1zNQZFvuTUYNnc7iWorb2Mk6jH8ZbVp4Ju5UMUckzn49FXKswXdnbD1MQ5OQBbJ/WtyOJBoT0/8yr4XqzYYHk9Jp/kRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939361; c=relaxed/simple;
	bh=Dr+uAEpjHqXv3/qjlndkWpa0dISEDuW0xo9W272ExUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTabQG6FlxscA0FSDbQelvMWZT5OIRcXv9jTtaK35IAkBHrNHJZMGcF1o6kgwmfUVMNScSlrOHHoeXbQDoxEBJ1vDArgVdmWpEEIZ5AOinbXuRsjXOEc+a7SBS4UIz0FSO0D2cXI9cY3pTkSAAoiKkZ0EKMa40fYZXNGYUanf8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UxhiqN+q; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UxhiqN+q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=OpCCAn5xRJ/+SZkKFEIofulYy8jyKi1O4LEx0OQJBHI=; b=UxhiqN+qiq5tDICKxEyPSWdWx0
	27gAoVRaRFp11Rz/uGHPHxGycIu8u6krY1+pdNgkzRAvS5kGvfC04pc/7K2tE3w+F2eC73xsVdbuc
	1wgKDgzqjYNDdRF/YBNl9iivouTsWfPyEGay4MFrv2mJ+kWXZE3bQyEzaD24yMmDOqSQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w3Geu-00CQ3g-9g; Thu, 19 Mar 2026 17:55:44 +0100
Date: Thu, 19 Mar 2026 17:55:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <6dc9a358-4140-457f-bdfb-b4fb22aaf88e@lunn.ch>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317184610.315852-3-charles.perry@microchip.com>

> +static int pic64hpsc_mdio_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct pic64hpsc_mdio_dev *priv;
> +	struct mii_bus *bus;
> +	unsigned long rate;
> +	struct clk *clk;
> +	u32 bus_freq;
> +	u32 div;
> +	int ret;
> +
> +	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
> +	if (!bus)
> +		return -ENOMEM;
> +
> +	priv = bus->priv;
> +
> +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(priv->regs))
> +		return PTR_ERR(priv->regs);
> +
> +	bus->name = KBUILD_MODNAME;
> +	bus->read = pic64hpsc_mdio_read;
> +	bus->write = pic64hpsc_mdio_write;
> +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> +	bus->parent = dev;
> +
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);

What is the use case for not listing the clock? Optional clocks are
generally because it was forgotten about in the initial driver, and
added later. In order to not break backwards compatibility, the clock
needs to be optional.

But this is a new driver. Why not make it required?

> +
> +	of_property_read_u32(np, "clock-frequency", &bus_freq);
> +
> +	if (bus_freq) {
> +		if (!clk) {
> +			dev_err(dev,
> +				"cannot use clock-frequency without a clock\n");
> +			return -EINVAL;
> +		}

And this then gets simpler.

> +
> +		rate = clk_get_rate(clk);
> +
> +		div = DIV_ROUND_UP(rate, 2 * bus_freq) - 1;
> +		if (div == 0 || div & ~MDIO_CFG_PRESCALE_MASK) {
> +			dev_err(dev, "Incorrect MDIO clock frequency\n");

I think "Out of range" is more correct.

	Andrew
