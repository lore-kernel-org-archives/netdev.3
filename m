Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ABF4B338A;
	Thu,  3 Sep 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444896; cv=none; b=ghyfb0o1BDkeahKTwMGvFiABY782ulax14suwvDfbkyPbzIMqLDX+au9r+k94TXlMvphvqVc/9kDKt2p+vSUZKzBjDPypEo/mZIRs5RojV/9zGP0XoRhAFdsbUood6UkYmc1Ii6IaYoVy9kFFu8cGc1VFjgUhWMDWHdCPaTYKbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444896; c=relaxed/simple;
	bh=O1JItV6XXrMRvrBI2WKijpAIxzyMuYzBBsyXP3dHXC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBb56CkQlbXmWoMgHUGuqx82t+IWnPgUoJaLf2yVDsU9d/1naykOviaGpI868K9wyKNN44/sUS531tChKTW/3IojhoebA7SfN9fMcpRavso7BGl6PNv5dIVV98b01YBLXIHPyBE53WpQqLJzXuR6vNjfyF5hjHb8dOlZQ/VvgwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nJtdGt43; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nJtdGt43"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/pX0RQvuBiuQkLMPMZWX4AMUTOKKa6mhBzXN55ITYgE=; b=nJtdGt439VyhICcheBsN9U0gsN
	I7T97yFCHaZ+pFrjXMFA+cEP7SF/WiX5THtiy65o9avE/Ei7WphHMQIaNIasYFjeircOvjHHNPYGf
	FTYU2O7eEOC5UkOjnR84I2O/TYkxchdxDpwxwiBr/4M6n9E2Dxmt4UbKxsASe7EGIkCw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x28Co-002jrP-B1; Thu, 03 Sep 2026 16:14:18 +0200
Date: Thu, 3 Sep 2026 16:14:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: ethernet: oa_tc6: deliver the PHY
 interrupt to phylib
Message-ID: <2d313e42-3fbe-4fc9-bd57-23a951d997b9@lunn.ch>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
 <20260901130948.212914-3-parthiban.veerasooran@microchip.com>
 <713d8963-6aa6-460e-83dc-157d37d66662@lunn.ch>
 <624254b3-2aa3-47e9-aae1-d62b2dc3f5f7@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <624254b3-2aa3-47e9-aae1-d62b2dc3f5f7@microchip.com>


On Thu, Sep 03, 2026 at 06:53:40PM +0530, Parthiban Veerasooran wrote:
> Hi Andrew,
> 
> On 02/09/26 6:00 am, Andrew Lunn wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > > @@ -600,6 +642,16 @@ static int oa_tc6_phy_init(struct oa_tc6 *tc6)
> > >                return -ENODEV;
> > >        }
> > > 
> > > +     ret = oa_tc6_phy_irq_setup(tc6);
> > > +     if (ret) {
> > > +             oa_tc6_mdiobus_unregister(tc6);
> > > +             return ret;
> > > +     }
> > > +
> > > +     /* Deliver the PHY interrupt through the nested virtual IRQ. Set before
> > > +      * phy_connect_direct() so phylib enters interrupt mode.
> > > +      */
> > > +     tc6->phydev->irq = tc6->phy_virq;
> > 
> > I don't know how messy it will be, but it is better to set
> > mii_bus->irq[] to the interrupt number. phy_device_create() will then
> > copy it into phydev->irq.

> Thanks for the suggestion. To use mii_bus->irq[] so that phy_device_create()
> picks it up, we would need to set mii_bus->irq[addr] with created virtual
> irq number before mdiobus_register(). However, the PHY MDIO address is not
> known until phy_find_first() returns, so we cannot pre-populate
> mii_bus->irq[addr] before the bus scan runs.

This is why i made the comment, i did not know how messy it would be.

Where it becomes interesting is the recent patch:

https://patchwork.kernel.org/project/netdevbpf/patch/20260902080511.2211261-3-f@lex.la/

It just seems a bit brittle, phydev->irq says one thing, mii_bus->irq[]
says something else.

Maybe set all member of mii_bus->irq[]?

      Andrew
