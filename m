Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA32356BA;
	Thu, 22 Jan 2026 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769088152; cv=none; b=BoJvPCi09hsJg85+bihv14xbRbITdGRpTcJEuIK9KeGP4PbtnobxXfc5201EOmUH1i6SbqPabTJdv78OHSuaHBj0lo+6+9ohHrcCqdA9uAuW1bQspC1yb6FPVg4dBjA9Optn7SJJm94DhoYY9MMQh73R7eoCuVZhOfd+lFuaZl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769088152; c=relaxed/simple;
	bh=P6HZxlGShiYFpi9akiZjL4xb0yUiCa5kiQ2QujmLBmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCWXyHg/YpcwPpQurBHIFzQ2XZmrcXYsJYKLMEtAi7uKmo6KoiDDUmomhKW8x3CosJLBBZhUZNAGjoB2dLkdYZdHa5WFRKBH+awPQ/M2UqvZntTIbGNeEG+56yuPS6iDtxkWsk0PPrULPKyGZwkFob4MMoEmJUiNWJzKYs6/3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1viudb-000000000Oc-0DxJ;
	Thu, 22 Jan 2026 13:22:15 +0000
Date: Thu, 22 Jan 2026 13:22:03 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: Re: [RFC PATCH v2 2/2] net: mdio: rtl9300: setup PHY polling
 registers
Message-ID: <aXIke6nASlCSJVuF@makrotopia.org>
References: <cover.1769053496.git.daniel@makrotopia.org>
 <680696024a8648535ce6dee771fe4de67802e0e8.1769053496.git.daniel@makrotopia.org>
 <aXITnCLt945xHqaP@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXITnCLt945xHqaP@shell.armlinux.org.uk>

On Thu, Jan 22, 2026 at 12:10:04PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 22, 2026 at 04:00:56AM +0000, Daniel Golle wrote:
> > +	/* Detect if PHY has 2.5G/5G/10G capabilities */
> > +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->supported) ||
> > +	    linkmode_test_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, phydev->supported) ||
> > +	    linkmode_test_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, phydev->supported))
> > +		mac_type = SMI_MAC_TYPE_CTRL_2G_PLUS;
> > +	else
> > +		mac_type = SMI_MAC_TYPE_CTRL_1G;
> 
> There are PHYs which change their support depending on how they're
> configured, and there are PHYs that aren't configured correctly at
> probe time (and thus their ->supported mask is not correct.)

Oh, right...

> 
> The next thing I'm concerned about is the need to encode register
> information into this driver for each PHY that could be connected.
> Will there only be a small subset of PHYs that get used with this
> switch, or can any PHY be connected? If the latter, then encoding
> register information doesn't scale.

Only a small subset has been seen in the wild inside RealTek switches
for now. Most, of course, come with RealTek switches. However, it is
only very recently that RealTek offers 10G PHYs, so before vendors
were using 10G PHYs of other vendors, in practise I've only seen
Aquantia.

> 
> So, I don't think this is a good solution.
> 
> I'm wondering whether it would be better to have a callback through
> the bus when the PHY is connected with a netdev (in other words,
> after phy_init_hw() in phy_attach_direct()) which should be when
> the ->supported mask is fully up to date. This also means that the
> driver is bound, and we could then consider some kind of interface
> that would allow data about the PHY to be requested, such as register
> information. That would likely eliminate your need to test the
> phydev->supported bitmask (which I think is there to determine whether
> you need to tell your MDIO polling controller where certain registers
> are.)

Yes, that does sound better, especially with your concern about
->supported mask not necessarily being correct at probe time in mind.
It also makes more sense because it's only then that the interface
is in admin-up state and actually needs to be polled for a link.

Thank you for your thoughts and input on that. I'll discuss this
with the other OpenWrt folks involved with those switches and we'll
come up with a follow-up version.
