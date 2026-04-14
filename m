Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443EF3D667E;
	Tue, 14 Apr 2026 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210390; cv=none; b=CXaQd+Z62OXocSsYesBo0Pnfjdoq3k8xwpJIRpd9lDoYlFlIGgGnlFg02R3+QKcVN2UTlGSED+HiPxHVIzzW9bfMpbiDKZQSU4k5dqVZxbzbIAQEq3fvlMAQ4un45/O9zPpzluc1IjrTRw2uHbZf1l7JZkWbZhIPeZZoCUCOaCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210390; c=relaxed/simple;
	bh=9ekobuw0YwCcYjCKENnxiOPhUCKG+2oPuvrERcbZYUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mysmIt33zFrdNvDLqgo0tfuZLtUcCdGSdNsNQnpKvMUqJzsQIAjTrijtGpUDQiyZA4zao7ubRqn31Rio0CdAm+yekVGGyYrlCY825jPdmntaKdHxvxvLElLJQCXwRQ910eXEGEDhfgyNnOB29vjyB/BuPGaABscG0eBAJ0dbBcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=HaORRxDs; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HaORRxDs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cCepFV7laAGsiil5oyRBokTQR1awhh/rbDK3o4mDRBU=; b=HaORRxDsZaQZZjAakUGJ7oUPsA
	jBx2ONQgsI8d+w9TKSowFZEOAJkpO4zDMe7aQJkQvYuHitMGgIkaW2WUPwOKAbH718imcL4198NZf
	Wdx2eLWYz1043J65VenRXrLRCG8uIjh8+2pIzgq+GI3j3BT25O7+JVlt1fotss4A5HuY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCnSW-00G6w2-J6; Wed, 15 Apr 2026 01:46:20 +0200
Date: Wed, 15 Apr 2026 01:46:20 +0200
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
Message-ID: <2bdd6224-6acf-49db-955a-5552e64d4b73@lunn.ch>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-5-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403123755.175742-5-maxime.chevallier@bootlin.com>

On Fri, Apr 03, 2026 at 02:37:48PM +0200, Maxime Chevallier wrote:
> When dealing with PHY-driven SFP, we create a phy_port representing the
> SFP bus when we know we have such a bus.

I'm missing the big picture here.

Do we have three different things represented in the topology:

SFP bus-> SFP cage-> SFP module

	Andrew
