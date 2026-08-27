Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AB5416CF4;
	Thu, 27 Aug 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854204; cv=none; b=rownEclyDdzEzWgzsU/6+G4TmeLzPft6edAGChhHHQEQIP47MV3drrLFHL/xL+r+p2e9Fg9kYnp6VKRL+akO+p22hOPVqtYX8rdNfm0CVpp6V1LjAj/o5msximtcj631LbVD4iZ4AvWRBIoy9TlBPu5I9BhBipIBZvtZZ3LmIGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854204; c=relaxed/simple;
	bh=UIMCsVLpzvWHq+z9iEtltJCyvdqjRmLaJ77+sslW+xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECZF0aNKxH4+govjylhS+W+F1t00ZsJIHo75ksXo41GmSxTIfpGiLRIjusENDIFAQG+KQXcTlA31oukRtvXoHp+YJakuimM8hbKcYZsTH1wvXJRWhWAEqQpbKS1FyZzORCXf77UlPqbVsmiMIrenRy2Mn7zUl9dRodn3c3tuLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tpK/2Eck; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tpK/2Eck"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wl6yMmOELLW6bxlp5Du4LCsDn+qHqgXfz4pwmkLspD0=; b=tpK/2EcklDpZ5j8fv6xtVJLQWA
	ZXjRrxkd/CVR2XpyGcsYLpUE86DQ+gKRs5TogH5fhb7Upr2kmAJqrH0jSd7H6M89J7RXoR0ibtdef
	7Tkg8rpGmJ+pgayukJDyn0BoXUuko4YKzil6blWnUn3cx/O7j0Ft763P/m7x9o8ms99Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wzeXy-001hly-81; Thu, 27 Aug 2026 20:09:54 +0200
Date: Thu, 27 Aug 2026 20:09:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: restore the interrupt after a
 generic-driver bind cycle
Message-ID: <576ee16b-407d-4cc4-b5bf-67843fa16f62@lunn.ch>
References: <20260824024029.41310-1-f@lex.la>
 <20260824024029.41310-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824024029.41310-3-f@lex.la>

> Take it back from the MDIO bus interrupt table on both exits from the
> cycle: the cycle does not touch that table, so whatever the bus
> recorded there still stands. A bus that never filled it has nothing to
> give back and its PHY stays polled.

Bit of an odd phrase.

It might be better to explain that mdiobus_alloc() defaults to filling
bus->irq[] for polling.

> +static void phy_restore_genphy_irq(struct phy_device *phydev)
> +{
> +	if (phydev->irq == PHY_POLL)
> +		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];

Why conditional? Maybe it is buried deep in that wall of text?

    Andrew

