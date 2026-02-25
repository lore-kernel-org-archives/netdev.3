Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085333D2FF4;
	Wed, 25 Feb 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026762; cv=none; b=mZodAChqiic5A5860/Eyx9cF1Vr4TN2l1r8l24XTyh8IG7zCNwnw8ctj4eael+zw8sNS7ARwfER3j4HmtErA/74ma7rxNI9O/wAPKzSmgK3XJu7CscqAevXQV1JqHomYfT+1bPWH+7YeNruW6So0chDZyi2dASSO+M7LXBjrsmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026762; c=relaxed/simple;
	bh=w9TTacDsMn+nFqKTYgVyxw9ETvEiQ06XOrWFPbUwPj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzlGJex+JfFFK4Xe50dwrEbZBlXnYwC3BMRB0zBRJTpF0Vx8RwvHwdUORCCcqs+jDa2G7vsL4e4cQTRsYeuTFJ4toGaIc9lb4m3qKIZXcoJDBc9BG88dHzri1/WGALHeGQLm4gjA6ItUq5+4IZz7Wf9SeFQS+/6Tci5ne70PfCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RZGrMJit; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RZGrMJit"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+JGgXRK/xFUteYEv1aGaPLDzheuYNlzBktbMXhesNc0=; b=RZGrMJitK8U2SqULVjSzjrRC75
	nX0viijBp14vOq6k40bDuV5nhyzWQCuzNb495zVZg/rJczzBpPDltMLF9Za8sTjgy/bv3U79830oW
	W8ycUiW9b8KJ46XilEDeH2F2D5mHAvcAZsbCLYYNv/8Zmdep2/F3cXfOwZy3oEXm+aBo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vvF6b-008kau-Ap; Wed, 25 Feb 2026 14:39:09 +0100
Date: Wed, 25 Feb 2026 14:39:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	o.rempel@pengutronix.de,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <42918203-276e-42a9-a9da-34d43a5e6a98@lunn.ch>
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
 <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
 <5876361bab237e2e1c73395d7e65c93279865f63.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5876361bab237e2e1c73395d7e65c93279865f63.camel@microchip.com>

> > > > > > +static int lan9645x_suspend(struct phy_device *phydev)
> > > > > > +{
> > > > > > +    int ret, val;
> > > > > > +
> > > > > > +    /* Force link down before software power down (SPD), by doing software
> > > > > > +     * soft reset. This resets the PHY, but keeps all register configuration
> > > > > > +     * intact. The bit self clears.
> > > > > > +     *
> > > > > > +     * This is needed as a workaround for an issue where performing SPD on a
> > > > > > +     * port can bring adjacent ports down, when there is traffic flowing
> > > > > > +     * through the ports.
> > > > > > +     */
> > > > > > +    ret = phy_modify(phydev, LAN9645X_CONTROL_REGISTER,
> > > > > > +                     LAN9645X_CONTROL_REGISTER_SOFT_RESET, 1);
> > > > 
> > > > Any specific reason why you use a vendor-specific register here instead of BMCR
> > > > via genphy_soft_reset()?
> > > > 
> > > > 
> > > 
> > > Sorry I missed your mail. genphy_soft_reset() will do a software (hard) reset via
> > > bit 15 (BMCR_RESET). In particular it will reset the registers. We want to do
> > > a software soft reset, which resets the PHY without changing register values.
> > > 
> > No, BMCR_RESET usually doesn't reset configuration registers. That's why the
> > function is called genphy_*soft*_reset. In case your PHY behaves different,
> > which configuration registers does it change?
> > 
> 
> Ok I tought that was the usual behavior. The register spec says BMCR_RESET will reset
> the PHY and all its registers to their default state.

Most PHYs do a soft reset when this bit is set, but some do a much
harder reset, resetting all state including registers.

Does the documentation say anything about
LAN9645X_CONTROL_REGISTER_SOFT_RESET and self clearing? BMCR_RESET
should be cleared by the PHY when the reset is
complete. genphy_soft_reset() uses phy_poll_reset() to wait for the
bit to clear. If you don't wait, it could be your start writing to
registers while the reset is still happening, and those writes get
lost. You might have the same issue here.

      Andrew
