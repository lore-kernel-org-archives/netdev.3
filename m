Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38F34D903;
	Thu, 19 Mar 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773948451; cv=none; b=IU89Y7DCowBIrQ6D55p0fb7ALYEhHvsoSds/oJpzapCiPOGUoIxrTioFPwlT8j9sAZidiW+iDam9xhowgQo/lDbW5AAujkYuEzYY5lVdUQIDF/5eTB40G11RsA73UMtZ7I0VxK3gNzyLjW0o+HBI1QlJypdgxm920eUyXXlxzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773948451; c=relaxed/simple;
	bh=xdg2iqRt5WEdUmwnrBOzj1R5STCTuy6eemGNuetZTdo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUZwxkpeniHY8EnTqly3LOd4BrZWiXbKdOJIk8zG6KmIax9u7ZfNgKOwdCQ/NZAqvgNrNV0397zgKJrsPnXmAXGsYaot9ilT5DFsvHoIKC76q9mAVu2ODpBEkopID9WYlSIhkCjvXLy5hRUYwVQkEVOLIXTXq1yyFEshG6ynm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gbqu2rgu; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gbqu2rgu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773948449; x=1805484449;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xdg2iqRt5WEdUmwnrBOzj1R5STCTuy6eemGNuetZTdo=;
  b=gbqu2rguqGYJKpTLuez43NSJxvxP+J4y50pCauTenmkf0O1oj6dp2ROd
   TgO6Iw3I8mnpaRre+lEkIFyL/SiXe5ktWGDBY/IA51TUgpQ0WEFUtFK9p
   1n14hQwMWTxQSBqqq6koj94B9FaeHMVL04QT5MRe8TEFtvqoi3f9TM1qu
   iv/gFZ9/cQyAYgvjagpHOhwclXrJk0t8gg9ZzLF3pXi181M3tPQOxZmo3
   GCkkG5l0pAiiWRkrmh9/EuLtR1urua1Wn7lkCWg3jmHXJswPl06sKftSH
   /hlch+SkrfY3oKcYy9iotTv9l+Ms/fQE5ZU04vyo2VR+y/83xam96tawl
   A==;
X-CSE-ConnectionGUID: 7Aa//kVqQl2cbDDWrAgImQ==
X-CSE-MsgGUID: YlUjN0kJR9KYtv+p1TqYbw==
X-IronPort-AV: E=Sophos;i="6.23,129,1770620400"; 
   d="scan'208";a="222192366"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 12:27:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 19 Mar 2026 12:26:48 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Thu, 19 Mar 2026 12:26:47 -0700
Date: Thu, 19 Mar 2026 12:26:45 -0700
From: Charles Perry <charles.perry@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Charles Perry <charles.perry@microchip.com>, <netdev@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: mdio: add a driver for PIC64-HPSC/HX
 MDIO controller
Message-ID: <abxN9aGnCYA6s13u@bby-cbu-swbuild03.eng.microchip.com>
References: <20260317184610.315852-1-charles.perry@microchip.com>
 <20260317184610.315852-3-charles.perry@microchip.com>
 <6dc9a358-4140-457f-bdfb-b4fb22aaf88e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6dc9a358-4140-457f-bdfb-b4fb22aaf88e@lunn.ch>

On Thu, Mar 19, 2026 at 05:55:44PM +0100, Andrew Lunn wrote:
> > +static int pic64hpsc_mdio_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np = pdev->dev.of_node;
> > +	struct device *dev = &pdev->dev;
> > +	struct pic64hpsc_mdio_dev *priv;
> > +	struct mii_bus *bus;
> > +	unsigned long rate;
> > +	struct clk *clk;
> > +	u32 bus_freq;
> > +	u32 div;
> > +	int ret;
> > +
> > +	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	priv = bus->priv;
> > +
> > +	priv->regs = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->regs))
> > +		return PTR_ERR(priv->regs);
> > +
> > +	bus->name = KBUILD_MODNAME;
> > +	bus->read = pic64hpsc_mdio_read;
> > +	bus->write = pic64hpsc_mdio_write;
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> > +	bus->parent = dev;
> > +
> > +	clk = devm_clk_get_optional_enabled(dev, NULL);
> > +	if (IS_ERR(clk))
> > +		return PTR_ERR(clk);
> 
> What is the use case for not listing the clock? Optional clocks are
> generally because it was forgotten about in the initial driver, and
> added later. In order to not break backwards compatibility, the clock
> needs to be optional.
> 
> But this is a new driver. Why not make it required?
> 

My idea is that if someone wants to use whatever is the hardware default
or what was set by the bootloader, they have an option to do so. For that
reason, I made the clock and the clock-frequency optional. This is
something I can do without if you think it will homogenize better with new
drivers.

Now I just realized that I can achieve this by just making the
clock-frequency optional and not the clock.

Looking at some other MDIO drivers, I can see that there's different
policies on the "clock-frequency" not specified case:

 - mdio-airoha.c: use 2.5MHz if not specified
 - mdio-ipq4019.c: detect if the prescaler is the out of reset value,
                   choose 2.5MHz if that's the case.
 - mdio-mscc-miim.c and mdio-bcm-unimac.c: keep the current settings

I can implement any of the three policy above and don't have strong
opinions about this.

> > +
> > +	of_property_read_u32(np, "clock-frequency", &bus_freq);
> > +
> > +	if (bus_freq) {
> > +		if (!clk) {
> > +			dev_err(dev,
> > +				"cannot use clock-frequency without a clock\n");
> > +			return -EINVAL;
> > +		}
> 
> And this then gets simpler.
> 

Ok, I'll make the clock mandatory.

> > +
> > +		rate = clk_get_rate(clk);
> > +
> > +		div = DIV_ROUND_UP(rate, 2 * bus_freq) - 1;
> > +		if (div == 0 || div & ~MDIO_CFG_PRESCALE_MASK) {
> > +			dev_err(dev, "Incorrect MDIO clock frequency\n");
> 
> I think "Out of range" is more correct.

Ack.

Thank you,
Charles

> 
> 	Andrew
