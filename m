Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE3F37DE98;
	Wed,  1 Jul 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925524; cv=none; b=IsvQshr/8oZof2nxP6Mbnx4Xd1Dr6bsC6r7krLcAkZCQ8kx0Za55BNjmw1CwXzbbmoDwisTWWSb3O/QaZAaWGD4XvdR3mFWR0JrlPKYSMWkqxfDNjBoyDMOLPzFCC3BcwTtKLrBGHmHWaV65koFOumRaUVU27us39Fqh8P5Olyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925524; c=relaxed/simple;
	bh=kyikHHYq7103RTtVY1DSWkKPeB/tAEKF9dHlVnGrOrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRGfryftUauJr73KXHgKwOHic6Ymg951ZiW1oGAnrPzm5ywRgn4+xmu/9jV8i5HsbbgCs9cGvl4OKo38q9TtmPlESxQOrOZxYJILUNy+ptVjHgXFMHMaZtz8HGsA3Gis7EQ4tcjPR65y9KInDvcGGPgahZB2GQGUM2Rc+eJepPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nX6eeoJU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nX6eeoJU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MxFSTPpY0FYKfF60h712NAcU5QinacG+K9Gn0XhlhBY=; b=nX6eeoJUSnQgzOPWTnnShNnPoq
	WFe9k3hTbmCmA/U0LVQR31IrW+xbdBsoHglTvb0xuMse62n9H01BmCNrWMNQ7eunrKCIa6aUehZ1N
	/zsuj/Ywgvp4jsV43zvp2hN6cKxh+nTlOBXAB1mW45I+dPHNupv4uUhyL/Anqd4n94F0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1weyN6-00ADHN-QP; Wed, 01 Jul 2026 19:05:12 +0200
Date: Wed, 1 Jul 2026 19:05:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] ax88179_178a: Add support for ethtool pause
 parameter configuration
Message-ID: <46553470-9be3-4ae0-824d-ae85441c920d@lunn.ch>
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-5-13685df67515@birger-koblitz.de>
 <587499ee-d87e-4056-8d2a-8fda2ef3f0f1@bootlin.com>
 <947860cc-de6e-48b8-804b-e27f27b2f82c@lunn.ch>
 <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2edb164-91c8-40e4-a104-db690609cb57@birger-koblitz.de>

On Wed, Jul 01, 2026 at 06:22:31PM +0200, Birger Koblitz wrote:
> Hi Andrew,
> 
> thanks for reviewing this patch-series! I will answer to the other questions later,
> so that the answers stay together. But it is probably best if I give this answer
> immediately:
> On 7/1/26 17:08, Andrew Lunn wrote:
> > > > +static void ax88179a_get_pauseparam(struct net_device *net, struct ethtool_pauseparam *pause)
> > > > +	if (!(bmcr & BMCR_ANENABLE)) {
> > > > +		pause->autoneg = 0;
> > > > +		pause->rx_pause = 0;
> > > > +		pause->tx_pause = 0;
> > > The best way to have this correct is to use phylink, but for that you'd need to
> > > have a proper PHY driver instead of using the mii_ API here.
> > 
> > I said the some to one of the other patches.
> > 
> > Do we know what PHYs are being used? Can register 2 and 3 be read to
> > get the PHY IDs?
> > 
> > 	Andrew
> 
> I tested
>   id1 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID1);
>   id2 = ax88179_mdio_read(dev->net, dev->mii.phy_id, MII_PHYSID2);
> 
> and got:

Thanks for these numbers.

> Renkforce AX88179A: ID1 7c9f, ID2 7061
> Delock AX88279  ID1 03a2, ID2 a411

air_en8811h.c:#define EN8811H_PHY_ID		0x03a2a411

> UGreen AX88772D ID1 e65b, ID2 2c61
> TP-Link AX88179A ID1 e65b, ID2 2c61

The two ID registers contain part of an OUI, but it has some bits
missing. So it is not so easy to look it up.

However, anything using the MII framework basically assumes a very
simple PHY and only looks at the 802.3 defined registers. So the
genphy generic PHY driver might be sufficient for when there is not a
specific driver. At lot depends on how much extra code there is
accessing the PHY registers in the driver.

	 Andrew
