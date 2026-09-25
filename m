Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5688C3B27F3;
	Fri, 25 Sep 2026 22:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375938; cv=none; b=nJ3qvsuaAh57nYtGvy3bZxhL3AEe1uWf6ndGxU8UNCqFLPdTmzdP8VYGi2IYHMRZIBVrH+RaFpbLT42hQzYAKyARwNZkb4McYmJ1sb+EUDECdXrk4tuZMysJRO5qOUFpt9mtso4cKSTYz3LnimO2WiunJKb08bvZ08Vrz9AKOcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375938; c=relaxed/simple;
	bh=qnlWhyiDXWMbH6kJ+qYJdGSLOHEGt5lcPj/G6tg+hDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+zD7lqfHsfJ2BySbqDNiMgyXeYXU/basqUyICWB0PgKoqjAbBjqqDXBWcSDzNADJcjB/drHesVkZvIW7/LST8kmb60BECpWboW2Akp/9CYCUMmEV1q5NMSjEfpvFhwXgt5SL0PZC3ZFg+b2kY2iQAsm8eSSZhqZJhrF7X3zu4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=M1FLBsGy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="M1FLBsGy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fPoNcKj7sFnjP5mDmN+BO2A/pIw4yLEgFvCzm5Bv3lk=; b=M1FLBsGyhvDyUFrynqj+QlJjCT
	y9OYfAMtjyhhFEcG/hQNlshmpiOpukm7SmKkk90VS29wm/HgpLFGqXUW5hrHL1hsKY2nxVN0jiEUR
	e129sUah2k+93vzyHEjaJXqV0uTpTvBUYpKjEpXROdjaffLp4sb5Q3ya9UhrgL3ZDc2Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAEZ9-007Jjh-3n; Sat, 26 Sep 2026 00:38:51 +0200
Date: Sat, 26 Sep 2026 00:38:51 +0200
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
Subject: Re: [PATCH net-next v17 07/10] net: phy: phy_link_topology: Add a
 helper to retrieve ports
Message-ID: <7aac511f-daf7-45ed-9ee4-808659a6f4db@lunn.ch>
References: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
 <20260909093912.1290810-8-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909093912.1290810-8-maxime.chevallier@bootlin.com>

On Wed, Sep 09, 2026 at 11:39:08AM +0200, Maxime Chevallier wrote:
> In order to allow netlink access to phy_ports, let's add a helper to
> retrieve them. When handling a port coming from phy_link_topology, the
> caller must hold rtnl until it's done with it.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
