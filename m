Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE10330DD2A;
	Tue, 14 Apr 2026 23:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209332; cv=none; b=tabJhHXXEVg/ONTMPiJpNPGW/DQiCoMkCQ04EZfJE/Gk1FpzvR3Bdv7uFc9EAuS40EuIjwkfxZaoAZs4ud2NGQg0SFxWns7raEAT4ATPptPaoVul/AJ2+a7OTj0CzAH4fPFIbNRHia2jfmcdYqZIMdYwfSnUQpB72uw6Y8S6+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209332; c=relaxed/simple;
	bh=MsjSkqueiUHhL6h517/bD/OJVNquFKu2x81u5FUeaug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/dE8dHCenQUImtFQ8YxkmyryV/7LJ/W4pxOr6XRNeRSvIvtbE8Mv2yJnfHUYxPRZ+6ABxZ+unpgvcLsR4hwI2OntRo8y46fN/sgL91Szw47Gb7T+5zpN8GiDipdBq6vNSzOBA/mnaS2IUVwFdHlm7pCoyj3dPPAO6O+6k9PCPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Sa9+yGaO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Sa9+yGaO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=7hO+Qw8sNNdUdfDGP8kojbokARZKGWzpN7C7Z1xTZRk=; b=Sa9+yGaO0KoRgSs/1KhP4p0QeE
	AKphR4LYxadG4Q8fP/pDm7WFbgF8SJqABVUmqHF4nOXtCapj/GvBRSKOvW6gtJ3TRGGZD2WzDY3+0
	SynYehinducrLN2kcV9tBGRYSrXbCdOnXTLHt0eUj0vjMBoVgWD9aM6Mk4LbDY2SGeNA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCnBV-00G6po-HX; Wed, 15 Apr 2026 01:28:45 +0200
Date: Wed, 15 Apr 2026 01:28:45 +0200
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
Subject: Re: [PATCH net-next v9 01/10] net: phy: phy_link_topology: Add a
 helper for opportunistic alloc
Message-ID: <0c2b1e94-e7c6-49c6-bb4c-622240c118a1@lunn.ch>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-2-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403123755.175742-2-maxime.chevallier@bootlin.com>

On Fri, Apr 03, 2026 at 02:37:45PM +0200, Maxime Chevallier wrote:
> The phy_link_topology structure stores information about the PHY-related
> components connected to a net_device. It is opportunistically allocated,
> when we add the first item to the topology, as this is not relevant for
> all kinds of net_devices.
> 
> In preparation for the addition of phy_port tracking in the topology,
> let's make a dedicated helper for that allocation sequence.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
