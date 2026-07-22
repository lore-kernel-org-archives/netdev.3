Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12B470E96;
	Wed, 22 Jul 2026 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747368; cv=none; b=s1qh630liQvxTwtaWNjdMODIvZMzWp02Rhx+lW+KrdZCjlnYw40GPX4PMq8H/VMSPRncDOsh16eN83bnGlQkTbJOlUaL5oEQpOz3tscW1NupercleVMbpXwc3fRg822LG/Jan7Y6KvMy5ivmmkOiO1FTLpceJrLBoppbfOXFctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747368; c=relaxed/simple;
	bh=jGczeFLd3lJJ2NFajy0wYg4HkdEDYycx/snivlN1ScY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayT9UG96paqz8wAcrLa9+vCEXvdvFcUyw37o8qfOr/V826x1X/1UFNxttLZNeFt8sFYgojd8/vWqEajB0Kfrs/zWg9yY5/XSb+JTD2DTk5FknrG/RppiIxr9b+hAXbdwFgAvRdoIRN3qFm3XxwzsBsdrPiDQqZDvTxc6gXfb5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1lqGc+Pg; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1lqGc+Pg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lp7xAXjrSqTcd731tOPr+hjOYjdeU3wnP4D7LeHfmx8=; b=1lqGc+PgNRqh8yfzUImsXfSR7w
	12fYuZI9IvBr+FLAE/ieZSgNpVwNbPfQn6c4NqnEwmI+UYXzSDc+n3iS8V4Gwv+bNK7NzDClyO5ZH
	Yt3fqNF2gTjJbsC9LSH4hvPZ5fgWfTa1vaECYYfSZ2IOR0wP0QRz7eRXcsjGCbzdtkP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmcJb-00DgGL-Oz; Wed, 22 Jul 2026 21:09:11 +0200
Date: Wed, 22 Jul 2026 21:09:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/8] net: mdio: realtek-rtl9300: Add polling
 documentation
Message-ID: <ef41a5bc-804e-4a5f-863d-7221fc1ef1ac@lunn.ch>
References: <20260722062356.12291-1-markus.stockhausen@gmx.de>
 <20260722062356.12291-3-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722062356.12291-3-markus.stockhausen@gmx.de>

> + * Each device has a SMI_POLL_CTRL register. A per-port bitmask decides if the hardware polling of
> + * the associated bus/address is active or not. The hardware runs a tight loop over this and for
> + * each set polling bit it issues a status check for the PHY. Attaching a logic analyzer to the
> + * MDIO bus of an RTL8380 and RTL8393 gives the following commands (in kernel notation):
> + *
> + *	RTL8380				RTL8393
> + *	---------------------------	---------------------------
> + *	phy_write(phy, 31, 0x0);	phy_read(phy, 0);
> + *	phy_write(phy, 13, 0x7);	phy_read(phy, 1);
> + *	phy_write(phy, 14, 0x3c);	phy_read(phy, 4);
> + *	phy_write(phy, 13, 0x8007);	phy_read(phy, 5);
> + *	phy_read(phy, 14);		phy_read(phy, 6);
> + *	phy_write(phy, 13, 0x7);	phy_read(phy, 9);
> + *	phy_write(phy, 14, 0x3d);	phy_read(phy, 10);
> + *	phy_write(phy, 13, 0x8007);	phy_read(phy, 15);
> + *	phy_read(phy, 14);		phy_write(phy, 13, 0x7);
> + *	phy_read(phy, 9);		phy_write(phy, 14, 0x3c);
> + *	phy_read(phy, 10);		phy_write(phy, 13, 0x4007);
> + *	phy_read(phy, 15);		phy_read(phy, 14);
> + *	phy_read(phy, 0);		phy_write(phy, 13, 0x7);
> + *	phy_read(phy, 1);		phy_write(phy, 14, 0x3d);
> + *	phy_read(phy, 4);		phy_write(phy, 13, 0x4007);
> + *	phy_read(phy, 5);		phy_read(phy, 14);
> + *	phy_read(phy, 6);

I've not seen anything about what you intend to do with the fact the
hardware is polling the wrong registers.

The link speed is in register 0x1a, which the polling is not looking
at. The PHY will indicate the media side is doing 100Mbps, but the MAC
polling register 10 probably thinks it is 1G. I expect bad things will
then happen.

I know it is not possible to configure the MAC, but can you at least
see how it has configured the MAC? You can then make the mac_link_up()
callback check what the phylib driver says against what the broken
polling says, and when they are different force the interface down and
report the hardware design is broken.

       Andrew

