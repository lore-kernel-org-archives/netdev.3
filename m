Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FC336EC6;
	Thu,  9 Apr 2026 19:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764489; cv=none; b=gS2sOA48lj8VviTtbF2E6l5tfw4Hr/CwdvmufWp5PKQA4r9YoQpPiYQ0IDd6mS6lftU8oJW1v/qdNRJmuoKABoMnZH+tb1HdvbCl7NgvTKviBZXB72wgKw9Hhs8WF2yzNWxB0DCUlSHqnLNfy3nCJrYtwkvczIZ0zXAOMJJLZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764489; c=relaxed/simple;
	bh=YHbjw5Pi02GNmKksf99jT1mik4D/XDXbRuffw83653A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjdOLpCR909cvLvHfwobPoEe7UOGbKWUIzSOaxn8D/QhTuS/+UwDzbP2/BVH7QvMjczDTUsbC+qq2ihntSlGOQr06+xZwvfNWFfU6MXYgZRpRgRysomHLg+FscLEXwp19gILQDNx6hQ+RCrNfGUuFWbkRe9DmsXV+/9QJ7TX8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rENiqqgG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rENiqqgG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4m3qEQXbBSLI1c3Dofa2Pc9DqVCUH9sM2mc1pfaBTy0=; b=rENiqqgGOleRFOrUlzIVL0zkYF
	8WCpohMYTag4aFjJx19sfHY6HHrh6RwSDTUWGU8h/p529Hk1Y81AwSolAAUif3+N8hR5ezT09j6px
	gU8giOGqIxuZVyWzz2VfGii31bhGDT3BN7ohZji2v/x2xHRE+tlA1svqSb5p6yadVReA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAvST-00FTpF-Tu; Thu, 09 Apr 2026 21:54:33 +0200
Date: Thu, 9 Apr 2026 21:54:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Carlo Szelinsky <github@szelinsky.de>, o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <280018e9-4499-4a13-b692-6d6a4499477b@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
 <20260408210711.439068-1-github@szelinsky.de>
 <841e0a96-5e5c-4225-a426-24726163699f@lunn.ch>
 <20260409150922.74d82c39@kmaincent-XPS-13-7390>
 <908a84be-d403-4f59-8d8e-aa9de35bccbb@lunn.ch>
 <adfPAQDiYX6eIjrT@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfPAQDiYX6eIjrT@shell.armlinux.org.uk>

On Thu, Apr 09, 2026 at 05:08:33PM +0100, Russell King (Oracle) wrote:
> On Thu, Apr 09, 2026 at 05:34:56PM +0200, Andrew Lunn wrote:
> > I still think we should be deferring probe until we have all the parts
> > available. The question is, how do we actually do that?
> 
> Indeed...
> 
> > We could insist that MACs being used with PSE need to call
> > phylink_connect() in probe, so we can return EPROBE_DEFER. We might
> > actually need a new API method, phylink_connect_probe(). That can call
> > down into phylib, maybe again new API methods, which will not bind
> > genphy, but return EPROBE_DEFER.

I did not say i would be easy...
 
> How would MACs know whether they should call phylink_connect_probe()
> or phylink_connect_phy() ?

It would not. Anybody with a board using PSE would need to modify the
MAC driver to use phylink_connect_probe(), if they have a slow to load
PSE device.

> What do we do about MAC drivers that are a single driver and device,
> but are made up of several network devices (like Marvell PP2) ?

It would need more care, but it should work. You might end up removing
a perfectly good device because the other one is missing its PHY,
which is not ideal, but hopefully you get there in the end.

> We also have network drivers that provide a MDIO bus for a different
> network device, which makes connecting the PHY harder in the probe
> path.

Yes, we would see such setup doing more deferred probing, but again,
they should get there in the end. The most common systems doing this
are using the FEC. Are there any board using the FEC and problematic
PSE?

> Lastly, what do we do where a PHY driver hasn't been configured or
> doesn't exist for the PHY?

I was wondering if we can get from the driver core some idea where we
are in the deferred probing window. If we are 2/3 of the way through
the window, fall back to genphy?

I'm not saying we should change all MAC drivers, or recommend new MAC
drivers connect to the PHY in probe. I just want to offer the option
if you have a problematic PSE or PHY, change the MAC driver.

What we have also said in the past, it is the bootloaders problem to
download firmware into the PHY, or PSE, so that it is ready to go by
the time Linux boots. That would also be the simpler solution here.

    Andrew
