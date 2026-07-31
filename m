Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557E3672AA;
	Fri, 31 Jul 2026 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785516023; cv=none; b=Jfilf3EWfKcY70e3HEf4KipF0+KvacznCaeJv9V5uqAJkdu3dUO0B42baZS308NNlo8eAKyVCJ55SyjB/kq4egEuQ2lZh3n80HepmjVg2BrnT7w2ARVxky9ykoA4VisV8qGAxf2ep4oNIHUcIk3heNd284n9auD+8wN7cQ+LWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785516023; c=relaxed/simple;
	bh=8ZGf5vRUnUqC870F0s4WnUUOcFp6C6GYdjG7cRrTPnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl9b3gJewCJnYAUPPc2h8iWnxKaFkf02zOnhZVfpryvseCwiJIw85CIoiid8VfjlyhX/aKoKBuWH2jjDF600PWEZcnEqTMTBNObMJLX+KzJOdcPKpQHruJhiV3AvYA4MEiNc5+23j/xx60b5M7cvLAEXqlydXTIykw4dkQp1D3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HzLAGim5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HzLAGim5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZqXUW4OA0js/1Ov1kD+K705QFih50FrYbTw/pIg22fY=; b=HzLAGim58B3GgAj2a7ojYV0bs8
	k0Rx7AfwEhRs+yjzA73oZuR1BMGmArT7neo1WMmUDrk+kMgUm5ioBzKo7rNV3fVj0cr3+q4ljwrbX
	/kdU1O8xrme0lKrSEl7Zv9qqZi7+gxLHKKe04xnH/j3bSLU3G8t2WfBt5g/aEHXlcCx8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wpqHD-00FGhd-Tz; Fri, 31 Jul 2026 18:40:03 +0200
Date: Fri, 31 Jul 2026 18:40:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <251845b9-e477-4d00-b162-097b92c583a2@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-13-bdde4f905883@birger-koblitz.de>
 <d4f745df-715a-45c9-88a7-337b1dffd2ac@lunn.ch>
 <7d40cce5-6f82-4c40-8c94-ee674b5d0cfa@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d40cce5-6f82-4c40-8c94-ee674b5d0cfa@birger-koblitz.de>

On Fri, Jul 31, 2026 at 06:14:50PM +0200, Birger Koblitz wrote:
> On 24/07/2026 19:18, Andrew Lunn wrote:
> > > +static int asix_ax88279_read_status(struct phy_device *phydev)
> > > +{
> > 
> > > +	val = phy_read(phydev, MII_ADVERTISE);
> > > +	if (val < 0)
> > > +		return val;
> > > +
> > > +	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> > > +			 phydev->advertising, val & AX_ADVERTISE_2500);
> > 
> > This looks wrong. A PHY driver should configure the hardware to
> > advertise what is in phydev->advertising. The PHY driver itself should
> > never change this value, especially in _read_status(). It is up to
> > user space to decide on what is advertised, and the phylib core will
> > sanitise the value to ensure it is within the PHYs capabilities.
> > 
> This looks wrong, because the PHY uses the wrong bit for configuring
> advertising 2500_FD. Since phylink does not know about this behaviour
> the PHY driver needs to decipher this additional bit and then set it
> in advertising based on the value in the PHY register. But maybe
> I miss something?

We have two bitmaps.

phydev->supported lists all the modes the device supports. Generally,
that is filled out during probe, when genphy_read_abilities() or
genphy_c45_pma_read_abilities() is called, which looks at register
values which indicate what the PHY actually supports. If those
registers are wrong, because it breaks the standard, you can provide a
.get_features() callback in the PHY driver. That typically calls
genphy_read_abilities() and/or genphy_c45_pma_read_abilities(), and
them fixes up what they have discovered to fit what the device really
does.

phylink will also mask phydev->supported with what the MAC actually
supports. So the PHY might indicate it supported 1G Half, but the MAC
does not, and so it will be removed.

phydev->supported is then copied into phydev->advertised. The user can
modify phydev->advertised, but phydev->supported is fixed.

When the link is configured up, the .config_aneg() driver method is
called. It needs to push the bits in phydev->advertised into the
hardware, so it actually advertises those link modes.

If the hardware is broken and puts the bits in the wrong place, you
cannot use the helper. So the drive needs to do the interpretation and
write the correct bits in the registers. Depending on how it is
broken, you might be able to call genphy_config_aneg() to do
10/100/1G, and then do 2.5G manually in the driver.

The PHY driver should consider phydev->advertised read only.

	Andrew
