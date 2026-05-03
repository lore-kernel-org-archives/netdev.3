Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513741A681B;
	Sun,  3 May 2026 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777768869; cv=none; b=dlVzaq6w6KAV8V3fXfyAjc/Z1U7jC8682+5cGYSMOA2CUM95/8012muz5Y7uMhhquwZ690cOzULXNziGO6fJTwq1n73E6EDKrpfK8wJYm9vJhr/XRk4InF3W6RqgGU9BBKtDSjySADKeKcJYbLf9xnugZ/tdcnnKoP7w3zcYuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777768869; c=relaxed/simple;
	bh=2BF3n/2wknFjKWRP+8E3iqCkDvqYI0HvhrV67GErkYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5363O4eyG//BU3/9O3FpyRzhsnOH7hUbEMmC2CB+swR2RZDHrFyYiE+lpQ8347/XTID7eEGowNAlYFd/dVJZSOnx3dHpmQLc0GVjs7E/vMJzq94EwqBsZe1XZOZ2glfnMI1QaGIqTVukaOW+3yPZ5p2G046VA4+bBKAiRlDvwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5hoDPrKC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5hoDPrKC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YWU/N5KMrK3PGj5bbF9MJMDxZIl1BT+5NZSw3ptVt+0=; b=5hoDPrKChaUD9hzjhsbt6j/ksr
	mTpLKuEx7qqOFp4/iH8qpp5J3+n5mr81f8D810/NPu3tsMvuRMhwZNzVaSHdOWQT0nkQ/iswmmk6g
	L65HilbrYVWLjiAie2ils8XGFB0fsbwMCUaWCwzVZwBECJNiHiEPtlEqjbGinfkPycms=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wJKsz-0014FM-Te; Sun, 03 May 2026 02:40:41 +0200
Date: Sun, 3 May 2026 02:40:41 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: ciprian.regus@analog.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 3/5] net: phy: Add support for the ADIN1140 PHY
Message-ID: <2cfa6680-503a-4c4a-91bc-5f9a4331967d@lunn.ch>
References: <20260503-adin1140-driver-v1-0-dd043cdd88f0@analog.com>
 <20260503-adin1140-driver-v1-3-dd043cdd88f0@analog.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260503-adin1140-driver-v1-3-dd043cdd88f0@analog.com>

> +static int adin1140_phy_read_mmd(struct phy_device *phydev, int devnum,
> +				 u16 regnum)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return __mdiobus_c45_read(bus, addr, devnum, regnum);
> +}
> +
> +static int adin1140_phy_write_mmd(struct phy_device *phydev, int devnum,
> +				  u16 regnum, u16 val)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return __mdiobus_c45_write(bus, addr, devnum, regnum, val);
> +}

Why do these exist?

> +static int adin1140_config_init(struct phy_device *phydev)
> +{
> +	/* The link status of the PHY doesn't need to be polled, because
> +	 * the device doesn't implement AN and there is no other mechanism
> +	 * to report the link state.
> +	 */
> +	phydev->irq = PHY_MAC_INTERRUPT;

I would prefer you don't abuse this.

> +static int adin1140_read_status(struct phy_device *phydev)
> +{
> +	phydev->link = 1;
> +	phydev->duplex = DUPLEX_HALF;
> +	phydev->speed = SPEED_10;
> +	phydev->autoneg = AUTONEG_DISABLE;
> +
> +	return 0;
> +}

This should have no really cost, so just let phylib poll.

	Andrew
