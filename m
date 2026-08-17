Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71684331EBE;
	Mon, 17 Aug 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986247; cv=none; b=p8ex8jtly2J+8bPPT6kvMWkswVpobog2FhV2tgGerU5EKzSv4PtxDWYggbNSV5zP0kZ3tOL3abxsauleg5UK3WMj434QGdXcdL5ej6FJv1xGrMZpsb21I/OC0rc7l/xb3DQAALcGKXL0jafuazGRs0YeSIM8BYkrEvmrVPOTXUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986247; c=relaxed/simple;
	bh=aB+NVtmBB9x2nIy9fz/oEmgDw8czmVQOoCMvHTkb2Hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imH/ng443ZM4MHC87Gxi3TwtMaXxPC06QjnalsyclP4Jm5ef0kLqanvr2T9OqzhoIHrzkCg4JZL8P4ZjAY8A2Dz9VSS12VddRiSWx24zL19egR50nMC/TOcVRayQX+TpJfVMs3InzCqciYKM+VXDBvajmjHnOFBsgvuMLgAv1Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BENu0ml7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BENu0ml7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xBXRf0YZgF6Oekv2P9V3yxYLpbvIQRtTVNvKVDawMLw=; b=BENu0ml70suycsFQa073KzAhLW
	qgA0dlVo4Nc52yXdDPQofrm2Vvzu1aytWJUfujjfylsrE7snkESXt94Qg2wE6YU96KgokDX7fbeZT
	28x+0XRfMn96Qbn29CS+3KjU8nlPlAvjrCpf43g8trRqZlXlQ0IaX33NJNqKqEDKvPQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ww0kY-000LMh-Kx; Mon, 17 Aug 2026 19:03:50 +0200
Date: Mon, 17 Aug 2026 19:03:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v14 10/13] net: mdio: realtek-rtl9300: Open up
 C22 and C45 space in parallel
Message-ID: <cf8bdf97-64f9-4120-bdeb-c5a91a274490@lunn.ch>
References: <20260817162632.1208891-1-markus.stockhausen@gmx.de>
 <20260817162632.1208891-11-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817162632.1208891-11-markus.stockhausen@gmx.de>

On Mon, Aug 17, 2026 at 06:26:29PM +0200, Markus Stockhausen wrote:
> Until now the MDIO driver supports either access to the C22 or to
> the C45 address space of the PHYs. This is due to the fact that
> the polling configuration favours one of the address spaces and
> limits access to the other space. E.g. when polling is set to
> C22 most of the C45 space can not be accessed.
> 
> There are however some exceptions from that. EEE register access
> is allowed independently from the polling mode [1]. As the
> downstream driver already allows parallel C22/C45 access [2] do
> this in upstream too.

Is this enough to actually use C45?

int __phy_read_mmd(struct phy_device *phydev, int devad, u32 regnum)
{
	if (regnum > (u16)~0 || devad > 32)
		return -EINVAL;

	if (phydev->drv && phydev->drv->read_mmd)
		return phydev->drv->read_mmd(phydev, devad, regnum);

	return mmd_phy_read(phydev->mdio.bus, phydev->mdio.addr,
			    phydev->is_c45, devad, regnum);
}
EXPORT_SYMBOL(__phy_read_mmd);

int mmd_phy_read(struct mii_bus *bus, int phy_addr, bool is_c45,
		 int devad, u32 regnum)
{
	if (is_c45)
		return __mdiobus_c45_read(bus, phy_addr, devad, regnum);

	mmd_phy_indirect(bus, phy_addr, devad, regnum);
	/* Read the content of the MMD's selected register */
	return __mdiobus_read(bus, phy_addr, MII_MMD_DATA);
}

Is phydev->is_c45 true?

Some of the automotive PHYs have the same issue. Look at

commit aa63217916e1818a28b711384a9340d965ad073f
Author: Ciprian Regus <ciprian.regus@analog.com>
Date:   Wed Jul 8 01:33:38 2026 +0300

    net: phy: add generic helpers for direct C45 MMD access
    
    Some PHYs support direct C45 register access but not C22 indirect MMD
    access (registers 0xD and 0xE). When discovered via C22, phylib routes
    MMD access through the indirect path, which won't work on these
    devices.
    
    Add genphy_read_mmd_c45() and genphy_write_mmd_c45() as read_mmd/
    write_mmd callbacks that bypass the C22 indirect path and use the bus
    C45 accessors directly.

And I really think you need to block C45 over C22, since we know it
will go horribly wrong.

   Andrew
