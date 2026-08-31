Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9BA41F5FC;
	Mon, 31 Aug 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187134; cv=none; b=dZf+oVyxYdM2vDEh7e+LYVYL0Dhv7eyMOemtUQz4RBQ/NoPCN9M/rHN9kDIu61Pr3emfQ8+ykM7FkANXKDsYdF3zrcGIHBJNL2cTaFWWZP02njaHKi3hpjc/numue1mvJyBrxHjnCmO+oUF+F2ucaqTE3whgxgkygZDVFsRtjIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187134; c=relaxed/simple;
	bh=QlPfg7iKgXp2OWZNXymyXQJbLxgt4ZSR0mrUH+rg4wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQfDT/xXHfKOjhRZqC5YBG+gmL0pw+0TlEoDsGY2Jrj7hOUW7rBv/qQEeNx2/cg03YTYTZYtvGnx2Txq7fZqBHWBr7CWn2gUO7YKxGs6MvtvbQOISNfJzOGpaDxBaOyf1H6HvZ5b3hUAWKp72leUVRoKzEMNVikYexbXr/P9S4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zipvUa5B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zipvUa5B"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=shDKICIJ+5eRL/D4OWRP003BHZKua/5oCOgJ/0Hv044=; b=zipvUa5BDU5twH2p/ittCQtc8/
	686ftPMRy0daFDweNTI2vxKtlZgaJicrmyVbOEfc8gkyuc5BwfD76chuA9JEiKB6p6GV8EvPlMOeN
	0bR2kOHIxo7z2ePS8ZcvKMlKr55soxScP6sWc1iJ0nRp28oh13soAp2pXWz7ogdBfRkA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x139m-002CKl-OT; Mon, 31 Aug 2026 16:38:42 +0200
Date: Mon, 31 Aug 2026 16:38:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v8 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <505bb4bf-b910-4642-b4dd-d4b5fee8309d@lunn.ch>
References: <20260831-ax88179a-v8-0-de905f2ee426@birger-koblitz.de>
 <20260831-ax88179a-v8-15-de905f2ee426@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-ax88179a-v8-15-de905f2ee426@birger-koblitz.de>

> +/* AX88179A-based PHYs cannot access MMD registers via MII_MMD_CTRL/MII_MMD_DATA
> + * Make sure to use c45 access instead.
> + */
> +static int asix_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return __mdiobus_c45_read(bus, addr, devnum, reg);
> +}
> +
> +static int asix_write_mmd(struct phy_device *phydev, int devnum, u16 reg, u16 val)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int addr = phydev->mdio.addr;
> +
> +	return __mdiobus_c45_write(bus, addr, devnum, reg, val);
> +}

Please see aa63217916e1818a28b711384a9340d965ad073f

    net: phy: add generic helpers for direct C45 MMD access
    
    Some PHYs support direct C45 register access but not C22 indirect MMD
    access (registers 0xD and 0xE). When discovered via C22, phylib routes
    MMD access through the indirect path, which won't work on these
    devices.
    
    Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
    write_mmd callbacks that bypass the C22 indirect path and use the bus
    C45 accessors directly.


    Andrew

---
pw-bot: cr
