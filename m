Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5763B1B3;
	Thu, 16 Apr 2026 01:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776301204; cv=none; b=AiPBz1uMKrwntujXylDPjvH+0RcD2UwLzfc9rc85eT5cWQcbS/9rxQ5k1dS4eV0kXc1il5kXneKAX/zaKJWCqy2xdFr3D5OOxiBIx8pIQpadLfr0s37VS1JdGpMoaQndcdsQo2rJwExcWPnOvLoozv6XvKIIpDIGapXvZY2UNEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776301204; c=relaxed/simple;
	bh=iU0DwoZ+SxeK2Nw5LXlna/1Yc8q9gelYmwSDcS+gaHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEFuCI11ZgoAaSjIZEKNEf8WbYs5QHVVyxfU5+vzs3anPA5g2/jsfancFY3jqoofVmZ0NihmA1nWHbjOVgRKShbomxv9X4SWvsmUqIBuW4MKjfiqHOvzng1Sn7fsttcdvMHbo2LTlmu3b3XQU93BMVXMlccErqjOt02Q1pwPFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3B9OOmlm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3B9OOmlm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FUceXjd8N3oLV2aVukNVBUzRUd/Cx5ROPr6kA4QdZoo=; b=3B9OOmlmiEdntmaMFmrwIn9UPF
	yW2EWnldk1VsRMKi6pyT8rKOOCrRF09uEp8WPcI4VbtnGjbqycUZyZNch0eKw2mua2HgYs4kPKEXF
	2mpH2II96q2soRiZYrEEsE/mkIW6RGgdbZXdSR6y6pbImucQHxpt/uRdYbRcUi3A3EO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDB5G-00GEJF-Fx; Thu, 16 Apr 2026 02:59:54 +0200
Date: Thu, 16 Apr 2026 02:59:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: Re: [PATCH net-next v9 04/10] net: phy: Create SFP phy_port before
 registering upstream
Message-ID: <93540a3b-1a69-40fe-9b48-5d8609d497e7@lunn.ch>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-5-maxime.chevallier@bootlin.com>
 <2bdd6224-6acf-49db-955a-5552e64d4b73@lunn.ch>
 <e4f6503c-6514-46f1-bf4f-a38c12903c16@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4f6503c-6514-46f1-bf4f-a38c12903c16@bootlin.com>

On Wed, Apr 15, 2026 at 09:19:45AM +0200, Maxime Chevallier wrote:
> Hi Andrew,
> 
> On 15/04/2026 01:46, Andrew Lunn wrote:
> > On Fri, Apr 03, 2026 at 02:37:48PM +0200, Maxime Chevallier wrote:
> >> When dealing with PHY-driven SFP, we create a phy_port representing the
> >> SFP bus when we know we have such a bus.
> > 
> > I'm missing the big picture here.
> > 
> > Do we have three different things represented in the topology:
> > 
> > SFP bus-> SFP cage-> SFP module
> > 
> > 	Andrew
> 
> Ah by bad, this is a wording issue, this is the port for the cage indeed.
> 
> The model I ended-up with is to represent the SFP cage itself as a PHY
> port, but I've been calling that the "sfp bus port" in the code so far :/

I know we have sfp-bus.c, but i think most people think in terms of
cage and module. So unless we need some concepts from sfp-bus, i think
it would be better if we use phylink->sfp_cage_port and
phylink->mod_port. 

	Andrew
