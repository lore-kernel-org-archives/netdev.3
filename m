Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD34334D2
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436587; cv=none; b=IjDvegCYpSLDyZuL28VH3VdXXcxQoR8E5GiDqUptUTXFEx8F/rcIvO+OoCsSzzgwKOaPPz7Xqp/tpsuBAf0ultYMNxsGr2PjSd//1CkN+7HURm8yx1qBZrHEiOpg2JpCHbQkQqM3Z3DdxqfpLS8r7KXccM2+9bt2Zg7xC6NdM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436587; c=relaxed/simple;
	bh=UhSZnavf1rfsL93xNNoiMZ/nHNSvMycUVNT9BxpCOSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVt70QE2ygboomUsxqvlNDajXKSqMBj4NLUEN3JG52+j4/kWU0TwIa8RbG8MpayZPD4YYSWGlO9VPoZ6gnR9XmS5JKWj9UWEDXN/hKoaVoDdC8bSl9S1Qc7MOrxAa12lknbUcmRLBB7Op1QOT0+Evvy8YwPnZ8Xv4lvmgdg7ZRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jjVXHJCe; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jjVXHJCe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=rWOJY17IfC2C/vbGD9XWoQYpTnEi+ZTzO9fI1QpvjVs=; b=jj
	VXHJCeW+huqJ42pl1jpVWoNu94u1J+iBzyYLxMhIhLFE9azpZ6+DOuloT7shrAqSFLGhRr9Nc63kd
	FYGTUGuj66QRMskk6MdbIdYKjWjR6JX8RDLPN4dLohS8YEQ+aNLgReJ+y0QNxUpGAHRRmDJQnibVU
	EmD7cEAp7nGby3I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2633-002iDk-40; Thu, 03 Sep 2026 13:56:05 +0200
Date: Thu, 3 Sep 2026 13:56:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Julien Blanc <julien.blanc@sprinte.eu>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>
Subject: Re: [PATCH] Add config phase for dp83td510e phy
Message-ID: <7095ba4b-1113-42ad-b036-d46f63521f4c@lunn.ch>
References: <0d5badda1670a578b18fae293d8cdd7e57d4d01a.camel@sprinte.eu>
 <9ddbcd2d-297f-4159-9290-fd87b7fccbfb@lunn.ch>
 <9571fa4681aed864a305b29a5ebbb05a02966167.camel@sprinte.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9571fa4681aed864a305b29a5ebbb05a02966167.camel@sprinte.eu>

On Thu, Sep 03, 2026 at 07:04:00AM +0000, Julien Blanc wrote:
> Le mercredi 02 septembre 2026 à 18:21 +0200, Andrew Lunn a écrit :
> > On Wed, Sep 02, 2026 at 03:52:58PM +0000, Julien Blanc wrote:
> > > Add a config phase for the Texas Instruments DP83TD510E ethenet PHY
> > > 
> > > The config phase currently sets the following properties from the
> > > device tree:
> > >   * RMII / RGMII mode (note : RMII master / slave can only be set
> > >     by straps and cannot be changed at runtime on this phy)
> > >   * RGMII delays. These delays can be enabled on the phy side, only
> > >     as a boolean. Delays are enabled if phy-mode is rgmii-id, or
> > >     rgmii-[rx|tx]id which enables only the corresponding delay.
> > 
> > > +static int dp83td510_config_init(struct phy_device *phydev)
> > > +{
> > > +	struct device *dev = &phydev->mdio.dev;
> > > +	int rgmii_delay = 0;
> > > +	s32 rx_int_delay;
> > > +	s32 tx_int_delay;
> > > +	int ret;
> > > +
> > > +	if (phy_interface_is_rgmii(phydev)) {
> > > +		rx_int_delay = phy_get_internal_delay(phydev, dev, NULL, 0,
> > > +						      true);
> > > +
> > 
> > If delays are simple on/off, you don't need this. Do something more
> > like mxl86110_config_rgmii_delay() which just look at
> > phydev->interface.
> 
> Thanks for your feedback.
> 
> I'll trust you on this and send a v2, but this (phy_get_internal_delay)
> is actually how it is done in the dp83822 driver which i took as the base
> for these changes. Should this be changed there as well?

I would leave it alone.

phy_get_internal_delay() can be used in this way, but it is more
intended to be passed a list of possible delay values, and return the
index into the table for the nearest to the DT requests.

I also find the return value a bit odd. If you pass it a list, what
you get back is the value you need to write into the register
field. However, without a list of values, you are using it as a
Boolean. It seems inconsistent.

	Andrew
