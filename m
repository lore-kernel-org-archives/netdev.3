Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203A38A739;
	Tue, 15 Sep 2026 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789436080; cv=none; b=FclBVhhXJrS5MJ9vMyvbadBY8gYD9ShIZn+4qvLRl37yWNQ08IW45FM3wNQ/+SeMGpM9u0SCM0ttqb5GWwsenkB3PxzDB0K9TIzZnm3NJTTlzyf/AEE0+bcwMKxEcrAMZQLZ4nxdzE9cjQJrrQvhEL2oUsCDEgO7iTudnzkmE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789436080; c=relaxed/simple;
	bh=cadXg/ow2/jDyFvwx00hWf6I99/FAhS+PRSm7nt5GMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aq48gD4zBKsyRqv/hzugTEL2uUv1dMZrE7w/mcazLAcg1PY7edGQhBcQhj88iSBSrhOvk1NKdij6UrXq1Cai4ORcEpqS4WALDh9J9HZi8YZDPkOEHGT4fY31on2hKzRLbi489xTVbqIcagrKJVKHk/T1SK0XaNbEcUDvEIvYSI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AnmIad/E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AnmIad/E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nDBcHmkyit40txgehf278ksVErAv6k0lvEFELOMxFSo=; b=AnmIad/EsSdFG96A43szD+CXml
	VD9JKVAbLO/R+51QVrbBRislA64rb9ezdUj9F+2e8iozK+1joXVFKonYDvZVQHaidFRzhyWWkrmVE
	wRvs7Qpo6DGn8weKXnX/R99/KjxOI7xey9oPrEWmKI8atbOP7YulHDITpPdnuwPoVVkg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x6I47-005AIw-FT; Tue, 15 Sep 2026 03:34:31 +0200
Date: Tue, 15 Sep 2026 03:34:31 +0200
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
Subject: Re: [PATCH RESEND net-next v17 06/10] net: phy: phy_port: Store
 information about a port's upstream
Message-ID: <bd378597-0797-4551-b9c8-69ddc3be3c98@lunn.ch>
References: <20260910170103.1029108-1-maxime.chevallier@bootlin.com>
 <20260910170103.1029108-7-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910170103.1029108-7-maxime.chevallier@bootlin.com>

On Thu, Sep 10, 2026 at 07:00:58PM +0200, Maxime Chevallier wrote:
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
