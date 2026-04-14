Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDECCA6B;
	Tue, 14 Apr 2026 23:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209480; cv=none; b=ISypOcwPcnhsRRdmStlUkl8fPjgY7jgn/IzRydnMGztGfUbBUedPXSNoT9qcQBR4e6W4b64bGGQBDw77Ejh7dtiOAmpjEofR34vihEJiRRyCjOJMFCtd8XCABAIokPxD6B9/oad//mBJZEWXlgSo51IKu3vfmukhPB/DcO9vSQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209480; c=relaxed/simple;
	bh=Q6gJohhS1AKYJXX+G5/OrC4MZui65F82wif5+hEkVtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rf767tw2IBaT0xMn7e3Dx2AmTKHoQBWmtqH9hWz1CafsANwJQPnJzCW19+QMbrgeGXVayOh4v7rAZ+j4tORR+OKVbvoDXJFO8Rkev37WWiFYNdFePJJpntO+tppgQcz41sLYOVABupniWdDaFbJUUs7PQnQLEnNw657Oq2reJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AcSpfqUh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AcSpfqUh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zSSDo8sckLb7yaO0qwXduLvY+DGJprunVPrxUMqmKjQ=; b=AcSpfqUhnzoM3GIkZWyi1BnlRb
	KZ01EgYTn7TqMWpt1uvu9uykL9ObyT9RMncpPE/8Oa8MugQp5xZs9YMul3bTGInaOEYN3EjM0q05O
	AZIYjng7MXUDp42h++HPxZ8gyhh1j8tsoWXLFKNRHWYidUpIq6uhTZpJtFnl0x9mp1qI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wCnDt-00G6qx-B6; Wed, 15 Apr 2026 01:31:13 +0200
Date: Wed, 15 Apr 2026 01:31:13 +0200
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
Subject: Re: [PATCH net-next v9 02/10] net: phy: phy_link_topology: Track
 ports in phy_link_topology
Message-ID: <1810076d-745e-43ad-918b-f0913ab615ad@lunn.ch>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
 <20260403123755.175742-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403123755.175742-3-maxime.chevallier@bootlin.com>

On Fri, Apr 03, 2026 at 02:37:46PM +0200, Maxime Chevallier wrote:
> phy_port is aimed at representing the various physical interfaces of a
> net_device. They can be controlled by various components in the link,
> such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.
> 
> Let's therefore make so we keep track of all the ports connected to a
> netdev in phy_link_topology. The only ports added for now are phy-driven
> ports.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
