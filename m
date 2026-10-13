Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4BB3D0934;
	Tue, 13 Oct 2026 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859050; cv=none; b=TgLX3aGcRayBpiiJCuXpRM3X6YKeh3CF/f4Mz2WarPj+F4JXG4BMO0fYcVOtUne4Q7SVQAA8kYVjRaGg2o2OibSCi2JYhW8hjQ/CsOLRGhWUBM+ooGZPWaiIJRCckf7Mn61laikCq5H32X4/RjuSUEO0iE1R40DG5SWojLSNi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859050; c=relaxed/simple;
	bh=P65gMytbqCQwWjWUNdZiszGvFUDMG3n5MYW0xe1nY4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAX+lgg/y7fa3hmeRKBKMRYuqFQ/9547U0csbVefG9GfX96P2nHM7wCPfz+V9Uqt3imW07kndEZ+56a/wbFCpKGxP7k03Yeb3CG4+NFj/J8Lv/lpPbVXTlwTVLn7PPxZ/JBjYny/84xlVrOkoQWTkbUD1rouI6R9tfw8wKiW9GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u6XBwG6S; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u6XBwG6S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JxNxsDo707Wifohn+iOG3qOIbg48C36AVzw/Txj9y8c=; b=u6XBwG6SFNErBEyrrcL8HaHOGm
	aetLPOEwMcQVFPdJiBcQONNtPACrexews5NiwFz/m5yDi24/+7Bxth/VQGZL0WMQBbpy3KSUuan5C
	EpC3p/nQ7qo9Ns7xDolFU/sORp/+0Y12pDrddSovPl3iTubZ1/fWq7AZ1f7nYV21Vk2k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGSOH-00ARJe-QO; Tue, 13 Oct 2026 04:37:21 +0200
Date: Tue, 13 Oct 2026 04:37:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v5 4/4] net: phy: make an unbind wait for the
 attached consumer to detach
Message-ID: <4189a162-275c-4ca1-8fda-f77870ac767b@lunn.ch>
References: <20261009180551.1234107-1-f@lex.la>
 <20261009180551.1234107-5-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009180551.1234107-5-f@lex.la>

On Fri, Oct 09, 2026 at 09:05:50PM +0300, Aleksei Sviridkin wrote:
> With attach serialised against unbind, the unbind that loses the race
> waits for the attach and then removes the driver from a PHY that is now
> attached. phylink uses phydev->drv right after the attach returns, and
> phylib uses it again in later phy_start(), phy_stop() and state machine
> runs.

I think we should drop this one as well.

  Andrew
