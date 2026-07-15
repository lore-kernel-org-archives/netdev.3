Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41EB420476
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784120727; cv=none; b=jmGM4JgsPWPSuIWuyhBSFbslUs4udIAxkEAdcOzETKAqzA3sALf0Tzs6YBLxugIll1D7ULNnW8H+4NYxHq/TK3Je2T7g6VmHSobg9lupF3zCG3/dsTcK5kXIQK8b3aO5JWrI1qkKquqkpDDdRjnUEthFoPcZzG8gKoIuc9ABNFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784120727; c=relaxed/simple;
	bh=d6vXckrH3LT/Od+K7IoSaCbWpL+scZGSLtFpFYVOaj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIABXaFjR1VizzzwR5MJk1pE640S+t34Hidqe+vtx7FAwx8kNUKNUrEpdcVd+3nzJQZfHiLkgiw1EbzxkjAsszQ/qLE9PDIEWZhbNE++f++Mp4LbUhTCu9Srhz594szCHlE3wBLGXJdUUWEGXWjqAaVpinT0oxqXVLXqaAytw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pmSlGgzX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pmSlGgzX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=U1tY+9WJZuzC+S1jjydQAJ8x2isbbN5pmZMZS1++Bjc=; b=pmSlGgzXhMl8qYk1DHO5bdH7Nw
	1gqFHY2PJZ/QyQKLoFcS1dtHfLtcSEH4ZPpgO3UVsAeN3cBzOtyKmVPUPRkGqWKdMwCFZHdqjlpm0
	vwA2+5RNCK6HG9jVRhcOYhW8361nm4WB53Nx45keF8ydFCxAKHGW2w55MMs+AJDQdEJw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjzIf-00CM7Q-FC; Wed, 15 Jul 2026 15:05:21 +0200
Date: Wed, 15 Jul 2026 15:05:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ayoub Kaanich <ayoub.kaanich@technica-engineering.de>
Cc: Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: RFC: symmetric SET_MODULE_EEPROM_BY_PAGE with i2c_address for
 non-SFF pages
Message-ID: <cd58995a-6bcf-4283-a072-84651a4f0031@lunn.ch>
References: <AS4PR08MB80212ED810625BB46A8EE1B7B7FA2@AS4PR08MB8021.eurprd08.prod.outlook.com>
 <23323308-6278-47ba-834e-662b0e408705@lunn.ch>
 <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS4PR08MB8021E0A64800F977B6887141B7F82@AS4PR08MB8021.eurprd08.prod.outlook.com>

On Wed, Jul 15, 2026 at 08:09:56AM +0000, Ayoub Kaanich wrote:
> Hi,
> 
> > In general, we are trying to block user space drivers, by only allowing read.
> 
> So in principle, a write from a third party driver (not the NIC own driver) is allowed?

We would expect the code to fit in with the current architecture. So
mdio-i2c would provide a Linux MDIO bus. You "third party driver"
would be a PHY driver. 

> Our issue is that the NIC drivers (especially the netlink based
> drivers), have no standard way to expose the I2C bus of the SFP
> module to other drivers.  phylink based drivers don't have this
> issue.
> 
> The current hierarchy is
> 
> net_device => sfp_bus (missing in many drivers) => sfp (internal) => i2c_adapter
> 
> For example: ice driver does not create an i2c_adapter or sfp_bus, even though many of the NICs using that driver have SFP28 or QSFP28 pluggable cages.

So Linux Ethernet drivers fall into two classes. Those where Linux
driver the hardware, making use of phylink/phylib, and those where
firmware drive the hardware, eg ice, and pretty much all intel
hardware, and most NICs which support > 10G.

For NICs using firmware, you will need to talk to each vendor, and ask
them to extend their firmware to support your SFP.

For NICs where Linux drives the hardware, which is pretty much all
NICs used in embedded systems, with a bandwidth up to 1G, and some
10G, provide an implementation of the protocol in mdio-i2c, and a PHY
driver, and it should all just work.

Looking at the other devices you pointed to, one used a Marvell
88q2xxx, for which a Linux driver already exists. And there was
sufficient hints in the document to make writing the I2C protocol
possible. The other device explicitly described the I2C protocol, but
did not mention what PHY was used, so might need a PHY driver. But
there are not too many T1 PHYs, so it might have a driver already.

    Andrew
