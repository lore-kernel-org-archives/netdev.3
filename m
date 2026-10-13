Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC61A9FA8;
	Tue, 13 Oct 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895069; cv=none; b=AP8d3dWnbs6Q3emONZgHXqcuLwREFEkI9jUz1pYhrLeHfs5K7t1rGK7Ej9W0M2d33oixPGXryLMsp4w/sOanuWhs53dypXvVE9mkhUt2I7UOCY42/L3ewJJ4m9hqljMAogwuh/rMV5akVMO0pdX7uoxrTHljgpJAw4O2+yPhCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895069; c=relaxed/simple;
	bh=bTW8j8Lh4mZuNv7RmaIYvf+zWROnejDBTr8dNMVP3DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XsxW8+xhU2OfEGZzZN+0TMEnJPCT7CKj4goO/XjbagFZPo2wFmv83ZxggPf+FMRvCHW7/V8RZ/VaKNGCRH02stqVOGB5akgzhPh+eMBuklNkSIxOd9GSCovnWbPTYh4k5mZFPfTELKFOPXVcwrsEESODUa05GRNTywascdTBnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5XhKaxdK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5XhKaxdK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=awQfqpyQeTdKEKNFkvHR73Jr0KPKcP6gbazKJ0d94ZM=; b=5XhKaxdKSkvsroXYlRfRMlUNGC
	9GFK0kEjANRjlcIDPcDm4X4+3kp6ue4XqzB0iRJO2ixP1pR0dZznFp4SVsJGHD/GGqLZoZjuYeyVW
	jQF80GgfTYBnziMgtA6ls4EmrPJztjTAJinNJgnxshYe2QNbG1ZXuu3aw4xaNblC7N8E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGblB-00AWZi-KG; Tue, 13 Oct 2026 14:37:37 +0200
Date: Tue, 13 Oct 2026 14:37:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, corbet@lwn.net,
	skhan@linuxfoundation.org, o.rempel@pengutronix.de,
	vladimir.oltean@nxp.com, f.fainelli@gmail.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: pause: Validate the
 pause autonegotiation with a partner
Message-ID: <45340f54-a53b-4d3a-a773-b51cfc88c939@lunn.ch>
References: <20260925182628.214667-3-maxime.chevallier@bootlin.com>
 <179065240018.434549.346139764454021625@kernel.org>
 <40f413f0-1dfb-4968-b483-f03aa2f1bdbb@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f413f0-1dfb-4968-b483-f03aa2f1bdbb@bootlin.com>

> > Firmware-managed NICs such as ice also keep the link on close by default.
> > In drivers/net/ethernet/intel/ice/ice_main.c, the PHY is only taken down
> > on close when ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA is set:
> > 
> > 	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags)) {
> > 		int link_err = ice_phy_cfg(vsi, false);
> > 
> > On this kind of hardware, a directly connected peer would be cached as
> > cfg.lp_controllable = False. pause_aneg_resolution(), and the four later
> > tests in the series, would then skip with "is not directly connected".
> > That message points at cabling, when the real cause is that the PHY
> > stayed powered.
> > 
> > The new remote lp_advertising checks in pause_advertising_test() would
> > also be skipped without any notice.
> 
> Not much we can do if the peer doesn't behave as expected here. Not sure this
> requires attention.

I sounds like anything with a BMC is going to hit this. So i doubt you
will see it with your stmmac boards. Maybe sometime in the future we
can query the NIC to see if it supports NCSI and change the test
behaviour to fit?

	Andrew
