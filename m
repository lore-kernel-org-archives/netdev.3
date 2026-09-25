Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B764CC600;
	Fri, 25 Sep 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349475; cv=none; b=T8xTUeDIjr6Zhme2XwHCqApeZcblDys/C8CNlyN+fM8xb12jNEKHi9s2R0gBTB3GrLEmZjGpwPeNDNFVYBkOOCJ+mxHtA8FyVVIrp+3um7Ui9Oh/nXZ966RAPz9c/4GQqDPRPFMvpCdyT21jCqwP8Aya4PDnVET+8of3ngYxoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349475; c=relaxed/simple;
	bh=r4jHvC8R1qGwo2iO+ASqWnDSlAhMX54J1FPDrWj5w1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0e2siTCQ1Kt2ksybdjWAPZVGJl6IzRlF/9ngTiUCNw7RKlHuBedMoIzmyBNEwUtsPa2vCqVBh7kb6rBV57ugmFWh2u3IAZyEEdh4VME/5SX4tTRRXrM3OtGpNOH+6l1P+IWWNN5PaG5dybGSCjoKs6982u26jlJhbM1XjdivUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ycp3L/Y3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ycp3L/Y3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TPq2jWBG+cE1Qwr/PmJfAp3LKpTg+6qSkEgMYh+YGc0=; b=ycp3L/Y3vWB3aD5bsRmZ5a0boe
	KKL26JRrRMZ9gXVAdzCPSHWQMzW8ZOOGWruL+clZkU2YLNEi86sIILtCe+j+Yl+jfMJAhVkNAWklb
	Dfk7Vbb6dRyulZzgfTfDBVAzIQt69VSnhe9IkBuhlNmYomlmZM3Z5djjC1hLcpHamxZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xA7g5-007ExF-MU; Fri, 25 Sep 2026 17:17:33 +0200
Date: Fri, 25 Sep 2026 17:17:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yongzhao Chen <yongzhao.derek@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [RFC PATCH net-next v3 4/5] net: dsa: qca8k: flag QCA8337
 internal CPU PHYs for SmartSpeed
Message-ID: <d2797713-9b92-43c8-a26e-bf3bc9817ad8@lunn.ch>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
 <20260923215858.1653-5-yongzhao.derek@gmail.com>
 <09d669ff-7aad-4414-880a-21c2e7bf2cd7@lunn.ch>
 <20260924234814.1734-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924234814.1734-1-yongzhao.derek@gmail.com>

> I don't know whether downshift is broken in general or only in
> switch-integrated PHYs. My only data point is the RA74 CPU link
> failure, and I have no downshift results from user ports or discrete
> at803x PHYs.

It is pretty easy to test, if you have a spare Ethernet cable you can
sacrifice.

https://en.wikipedia.org/wiki/Ethernet_over_twisted_pair

100Mbps needs pins 1-4, 5-8 are not used. So you can either cover some
of those pins with something, maybe nail varnish, or take some of the
outer cover off the cable to expose the wires, and if it follows the
colour scheme describe cut say the brown cable.

But this is testing the wrong thing. This is testing downshift
works. What you are actually interested in is downshift happening when
it should not....

So take a closer look at the user ports. phylib should report when a
downshift occurs:

https://elixir.bootlin.com/linux/v7.2.7/source/drivers/net/phy/phy-core.c#L359

phydev->advertising should contain what the user configured, even if
the hardware has cleared the 1G advertisement. So it should trigger.

	Andrew
