Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67A548CD46;
	Fri,  7 Aug 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108469; cv=none; b=QBQe9MckVrt9o2uRxrDymWcnnzsw83QihHG9uHBGLNjF/79df3T0ncPjY6chQolQ8Mv8bRkgMMEmQe2cucgr1bgCghL4BhLy2zGCDx4PW2zbQD81J862GAxyD6VYwHLkaHeK7haPuph8OTMazX6u/DTib8BW9RNf5o1+n9meYYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108469; c=relaxed/simple;
	bh=ToVnByjB/LjnH1+eN8SLBsmkjrCBzy5ZTA9bYUm32NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+8W3pI7uVk2A+Gz4bagvxhg2i5pspXl60DaoYQVsdEQL8s+CkZI7JsecgXYPPCqXBYhbPvK6pEUoipY4qm23jBExl8BUwL096M4Z19OsQKHrp+w2Cvf+9/iNzrc1bQGhjbpopa0w7dgqPy+iCzveRC08Ggbf9M4p2CSs41RVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WAkSJ5sW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WAkSJ5sW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cfyN1w9xacNUFPC4+FgRwaEGqm63jUtvMyECCGvIl/w=; b=WAkSJ5sWiQoMQ1E7YMRNsUlXIF
	1eANAdQhkt1Nmu3G7S/egTHz0AL4XrjVqjGwT/fHFBRvJgm2sWtA3oohMJybs6ZmPZEeTXWSuta0e
	TjAzmI9FEQN7bpZLuolREDdpleWQjong1EAabyU2sS2Hb/mDKUcaiWCmDMEMPMuYHAHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wsKOh-00GZTn-Js; Fri, 07 Aug 2026 15:14:03 +0200
Date: Fri, 7 Aug 2026 15:14:03 +0200
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
Subject: Re: [PATCH net-next v5 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Message-ID: <527d31e5-1731-4925-bf7f-a567f3fb3774@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
 <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
 <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
 <7a91e550-ac70-4423-9aed-9f4406e71fe8@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a91e550-ac70-4423-9aed-9f4406e71fe8@birger-koblitz.de>

On Fri, Aug 07, 2026 at 08:39:00AM +0200, Birger Koblitz wrote:
> 
> 
> On 06/08/2026 23:16, Andrew Lunn wrote:
> > > > > +static int asix_ax88279_config_aneg(struct phy_device *phydev)
> > > > > +{
> > > > > +	bool adv_2500;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (phydev->autoneg == AUTONEG_DISABLE) {
> > > > > +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > 
> > > > Why is that? Now that phylink is driving the PHY, and reporting
> > > > speeds, duplex etc, you should have everything you need to program the
> > > > MAC when the link mode is forced.
> > > > 
> > > I tried forcing the PHY speed in the past, and it does not work.
> > > This is a limitation which is also acknowledged for the suspected underlying PHY
> > > hardware Airoha EN8811H, see the head of air_en8811h.c
> > 
> > How well does this unwind on error? Is phydev->autoneg put back to the
> > old state to indicate autoneg is used?
> > 
> > This is one of the areas where phylib/phylink is missing a bit of
> > support infrastructure. We have a bit indicating the PHY support
> > autoneg, ETHTOOL_LINK_MODE_Autoneg_BIT, but there is no bit
> > ETHTOOL_LINK_MODE_Force_BIT, indicating the PHY supports forced
> > mode. So the core cannot enforce this and reject it in
> > ksettings_set().
> The error is handled quite poorly:
> $ sudo ethtool -s enx6c6e07090000 autoneg off speed 1000
> $ ip a
> shows link is down
> 
> Kernel log:
> [848763.836126] Asix Electronics AX88279 usb-004:045:03: Disabling autoneg is not supported
> [848763.836134] ------------[ cut here ]------------
> [848763.836137] _phy_start_aneg+0x0/0xa0: returned: -22
> [848763.836142] WARNING: drivers/net/phy/phy.c:1352 at _phy_state_machine+0x100/0x310, CPU#8: kworker/8:1/534588
> [848763.836146] Modules linked in: ax88179_178a cdc_mbim cdc_ncm ax88179(OE)
> ax88796b(OE) cdc_ether phylink(OE) r8152 nfnetlink_queue nfnetlink_log

That is ugly.

Ideally, we want phylib/phylink to report EOPNOTSUPP in
ksetting_set. However, as i said, we currently don't have a mechanism
for the PHY to report forced link does not work.

So:

Please change EINVAL to EOPNOTSUPP.

We accept your change as is.

But if you have time/energy, it would be nice to have some follow up
patches in a new series which fixes this correctly, allow a PHY to
indicate it does not support forced. The question is, how to actually
do that. The BMSR has a bit `Auto-Negotiation Ability`. But there is
no 'Forced Ability' indication. It is simply assumed all PHYs can do
forced. All the bits we have in phydev->supported, are positive, the
PHY can do something. There are no negative, the PHY cannot do
something. So i think it would be wrong to add a negative.

What we do have is struct phy_driver flags, and currently

#define PHY_IS_INTERNAL		0x00000001
#define PHY_RST_AFTER_CLK_EN	0x00000002
#define PHY_POLL_CABLE_TEST	0x00000004
#define PHY_ALWAYS_CALL_SUSPEND	0x00000008
#define MDIO_DEVICE_IS_PHY	0x80000000

So maybe add

#define PHY_BROKEN_FORCED	0x00000010

and look for that in ksettings_set() ?

    Andrew
