Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C282280329;
	Thu, 28 May 2026 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779931326; cv=none; b=KlMRukG2ltK+zVHDDKIizXmloDd9sDYtHvk4pXVSs+ZAXyAeN9/yII6EEwi2WPlaoBYLxCGvBGzAPJsgd/2G7uxo9UuwzMYprQwuSqv+xphJfWfGn8i4Nk4kNDNmrk+m8hMragTeJlwGi/OwrfsaKSCAqtSNiOum3+F++kDO3tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779931326; c=relaxed/simple;
	bh=SaD8cNh5Yv3GEjUQdZlHL5j1WsscAPigBnQ7l7x9mS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTESHUYesS20lyE4njCZEgpa711UbOrOAOz7qnU92cWGHwYVy5xDh14HTlTu6U4pTqEXtHkdroDCg0FsiyqILEzfveR7yqZceKZV24GgweSWlzxrHPHm4gL1rpR0a39ap/MFu6zi5+rSZ29XCkvNn1usvn3No/EZEuZRJaXg2Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=s7DYLgPR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="s7DYLgPR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mWaKDFzuKLhKxcOfsPamR8xUg18kZ2yPt0KSPvv9AS4=; b=s7DYLgPR7hCW1Va9iLAbTKY873
	vB00JO8sCRLHXVvAfl8BnjfyEsoD+guBWiT/CyUUrvu4RNQWpdAQop59DYwUMlEKcpW86rKMwh8aV
	8/ur9Mu8ytzG2yPL7X5wrPyFz0OA1zOIT1joRHk2FVsfnF7fLX99rFLLNreyTMC3aONA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSPRa-004pww-Ui; Thu, 28 May 2026 03:21:54 +0200
Date: Thu, 28 May 2026 03:21:54 +0200
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
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: Re: [PATCH net-next v11 10/10] Documentation: networking: Update the
 phy_port infrastructure description
Message-ID: <8833e5bb-3618-4733-83bc-bb3fddba5c6a@lunn.ch>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
 <20260521121040.1199622-11-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521121040.1199622-11-maxime.chevallier@bootlin.com>

> + - The SFP cage itself is a :c:type:`struct phy_port <phy_port>`. It's special
> +   in that it's not an MDI interface, buti rather a hot-pluggable MII.

buti ?

