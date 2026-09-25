Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D13B4FECDC;
	Fri, 25 Sep 2026 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375758; cv=none; b=l4DRiEdCL9wr6jc21Yzi0qzYX0OJQVLP+0lck8nHtnSOCnCvGHUxdyzmEvVedALMBVbL7q2TrdNoS63qdn4RQM8QYWEurwJvr3g7s13PmbIeK5FDnRO9+uWTciaCXDDMaH1Nfzx3unsMh56lCqopvB5Cw9nz5U2Ot03Noy0XBeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375758; c=relaxed/simple;
	bh=jaVMxK7jgaaTUIxoOKm28WKPj446PWhIZDCJcNT5w6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qAzrqy+9kj3OI035XHsxk6Gc9rr/oGDWYd6g/Q3Fd0fgdG1hrarxycD6Rhp4o0bax2tPtbi6zUHkRYeRoEzhiUtG3Fe4cdbTMIqeQpDZ8eiQ+qhrjq+giS++lE8zvSu+bJs4Ubp0oOfXoPnm9REFN0ktSQAcQBSl404vyst0Qdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=x+0X+7LK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="x+0X+7LK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=M7w3kztBGrRfSDFl/ts9PG2Cp22IC8Yd+8sIVRxCYEk=; b=x+0X+7LKbC1zYDEjniq7dMnnfc
	LPwpp5xCqlU0p5LsL0vf9x28IHt2AGA29H8qsdlSVV+BrYv5r7s5zHjwj8cMX/TaSwINSWnHSH4lS
	ydvMPyw/P9cSuPyhqqhDNAlMAtWxBgA4fZ/+DAOwEh4qQMDVRDl6jkk6zkymQy54WqzM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAEW7-007Jfl-1R; Sat, 26 Sep 2026 00:35:43 +0200
Date: Sat, 26 Sep 2026 00:35:43 +0200
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: Re: [PATCH net-next v17 06/10] net: phy: phy_port: Store information
 about a port's upstream
Message-ID: <08db4a62-942b-49dc-aa72-608b2701f915@lunn.ch>
References: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
 <20260909093912.1290810-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909093912.1290810-7-maxime.chevallier@bootlin.com>

On Wed, Sep 09, 2026 at 11:39:07AM +0200, Maxime Chevallier wrote:
> MII phy_ports are not meant to be connected directly to a link partner.
> They are meant to feed into some media converter devices that will
> expose an MDI phy_port, so far we only support SFP modules for that.
> 
> In the case an MDI phy_port is backed by an MII port (e.g. a SFP
> module's port, backed by the SFP cage port), let's keep track of the
> port id of the MII port backing it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
