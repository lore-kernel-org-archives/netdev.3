Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B441F5D5;
	Thu,  6 Aug 2026 21:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051007; cv=none; b=kIH1BHyYrb7ER8bBOQJAN52YTIEw/D5NAVbPYNNtvZJbe6vFOZEN9hcwT9Hys+6/VOeyR9DRLzMX7ffaKymCRtW+hlgNh0YWC1EEPSfLCnVm899ikeZiBKXz56C8wlaUcDfBcR1weZM7EFvQgs+Copvb0W+Twu4RcN/1XF27HhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051007; c=relaxed/simple;
	bh=gtXUdEoMFqSqOZqb+B4HivkDh4LRAFv64eBjObvOwDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpQjISAi3Xjc3GZvfqpGu4FFQtE/dvSmIcJL3GyjT59t2hIeqlvKAfR2X3m0Rzu8zfkhey+0DI/iuwJPceAKn+WmYTo1uRdEJWkU2EibERvXJqYZH0ErLGOtFiGSZH/uuBDMcHUeShxUbNqbizOSKzWOmwXaBcPcTsGpLe7XEaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=O6ALznRy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="O6ALznRy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CISF6n4T93pXyXll0aJ2tXI8tmqgiXw/hGJRHuNwqKA=; b=O6ALznRyXUe0v5EDhgIGbBjvo8
	zVOlD1Qh2/8GPXgC6rkGim1PDhl3Yi5wMLK7pBobUO75xIe/g6h1KrIlJjvNW7dkyywjVCVZEfgLO
	uTVfhcg3Jxq6/KHxvFVgJg/fM9ePxhrhxMxg7U5mSGbdN+akzCH0Un8ovrEVJcHMVOgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ws5S3-00GSR6-7r; Thu, 06 Aug 2026 23:16:31 +0200
Date: Thu, 6 Aug 2026 23:16:31 +0200
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
Message-ID: <f2a99d04-6d61-4cc2-814d-cfe1ef9b1395@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-13-dcb9fea4acd4@birger-koblitz.de>
 <5f32ac56-1c2f-474a-ab2a-f51464172d6d@lunn.ch>
 <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a203340-c2f1-48b3-b16f-93c31cbe2727@birger-koblitz.de>

> > > +static int asix_ax88279_config_aneg(struct phy_device *phydev)
> > > +{
> > > +	bool adv_2500;
> > > +	int ret;
> > > +
> > > +	if (phydev->autoneg == AUTONEG_DISABLE) {
> > > +		phydev_warn(phydev, "Disabling autoneg is not supported\n");
> > > +		return -EINVAL;
> > > +	}
> > 
> > Why is that? Now that phylink is driving the PHY, and reporting
> > speeds, duplex etc, you should have everything you need to program the
> > MAC when the link mode is forced.
> > 
> I tried forcing the PHY speed in the past, and it does not work.
> This is a limitation which is also acknowledged for the suspected underlying PHY
> hardware Airoha EN8811H, see the head of air_en8811h.c

How well does this unwind on error? Is phydev->autoneg put back to the
old state to indicate autoneg is used?

This is one of the areas where phylib/phylink is missing a bit of
support infrastructure. We have a bit indicating the PHY support
autoneg, ETHTOOL_LINK_MODE_Autoneg_BIT, but there is no bit
ETHTOOL_LINK_MODE_Force_BIT, indicating the PHY supports forced
mode. So the core cannot enforce this and reject it in
ksettings_set().

	Andrew
