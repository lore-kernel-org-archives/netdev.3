Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111213E0232;
	Thu, 14 May 2026 13:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766217; cv=none; b=R+Y3CcOnk3aFOrx9j9Nijo7CssUgh0o2ic7tzZd8iQtXKZ4Lr8+tFpYNV/oXTCcUZgYGOkVTpVVB+BJf5LBXX1Jkh70qjDG9ECf2xT4x9aFfYaC7hnieZtsgGIGBeOXC2lpanUlKAvkEBg8gSshFzS9AK4JuLeJmFU9YuSvl0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766217; c=relaxed/simple;
	bh=6G4l1quV0B8tqaZPVN5exdSxxKk3CekyDlpib5Gt1IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQ2kdnximvdKcttcymSlenuxBSzsfBK+Q5JR6UXrUcImVimWncS/3WHcxfg+ofFgJZzYu3SSpKJwp/rzyvaEt/6GupTicUaqZohoOEhy8Bw/sxPaguV6cPu8OOFqoigNvwwb4vz93Yz/KXpqRMG4tETiFz29AM4fFJZEQfZPnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lOoz9kpJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lOoz9kpJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=F2mbeZ4V90PohGUTDnU0xsMoKQD83A0QahJF3l/tuQY=; b=lOoz9kpJKsFZy3ssixyiLwXqJ/
	KLKnmTf7WF+cKiy1z7BkHmu1lDiFK1keEyfHbEIG32NssJ5ykWn+IRb13EBViLELoYx44Aq0zdgPn
	84bvyHZs5eMHE5DtzfTSsYpehS9Vk2RtmxOIV6y1ThgH+dlGzP4HUzYsbNiPnvCrgS2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNWLU-002uXI-DF; Thu, 14 May 2026 15:43:24 +0200
Date: Thu, 14 May 2026 15:43:24 +0200
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
Subject: Re: [PATCH net-next v10 3/9] net: phylink: Register a phy_port for
 MAC-driven SFP cages
Message-ID: <d70ba0ec-703d-4d7d-8358-13b7cde00342@lunn.ch>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
 <20260513130521.1064094-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513130521.1064094-4-maxime.chevallier@bootlin.com>

On Wed, May 13, 2026 at 03:05:14PM +0200, Maxime Chevallier wrote:
> phy_port tracks the interfaces that a netdevice feeds into. SFP cages are
> such ports, but so far we are only tracking the ones that are driven by
> PHYs acting as media-converters.
> 
> Let's populate a phy_port for MAC driver SFP cages, handled by phylink.
> 
> This phy_port represents the SFP cage itself, and not the module that
> may be plugged into it. It's therefore not an MDI interface, so only the
> 'interfaces' field is relevant here.
> 
> The phy_port is only populated for 'NETDEV' phylink instances, as
> otherwise we don't have any topology to attach the port to.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
