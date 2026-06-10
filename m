Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA6E7DA66;
	Wed, 10 Jun 2026 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123963; cv=none; b=acm/S2GSGaWxkN+c9TtVT6uJMk3Wg3HixvnGIKFxfLgbhXVeBNqFIN4QVhO4ZcNKVxYcmV7Ozk7yQ1pf/MkL02KPGSAb/QAxp4FWP6LjquYRArb/PIDUtupbB7+vzbwTHtMK7S6PyKQbyKFtuuVCwiSkV2SpVrfGrIOLcnPjlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123963; c=relaxed/simple;
	bh=1DaVFRtZrUGl9rPA68Kiv5B2qnc446EPNL3rTyf4hv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYkWGjLHqxncbiOrZp7cPHl2ZS62lJ8MU/WdHkfUopF6G2V18jvpwbXKM1h9nEf01bQrZ+HWxFiCoCnwHVN3voDEbzlbI68Oi5GITtDfEzOhcMxTrFhPi0WOF7+DGnG/0DRDthFLVsqsGYMDzWap/de9M0yEodzc/YSVWLbwPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=f72Xl6/l; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="f72Xl6/l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AU64uaQHZcFSJ4Xtl6UtU7OVNwH3LkcB40Z3AcnH+bQ=; b=f72Xl6/l2UNtrQTxS1GwypweC7
	2RO0TIKXs2PtQ369AA2reUz3SIiUyJfrIMA1kOE29UCLyvePD/keT7oP887d2avvp+fqYP1iP8GrZ
	NtUmhFt/x5fwdH/nZc/E6RtlE4DLPeUSlL+cuUaihugtbTGZ/7UxwNODkO4qNnEFk8x4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXPhg-007398-Ga; Wed, 10 Jun 2026 22:39:12 +0200
Date: Wed, 10 Jun 2026 22:39:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: phy: dp83869: Support 1000Base-X SFP
Message-ID: <6c4f54bf-383a-4ff8-8389-99592a8fcd16@lunn.ch>
References: <20251110-sfp-1000basex-v2-0-dd5e8c1f5652@bootlin.com>
 <20251110-sfp-1000basex-v2-3-dd5e8c1f5652@bootlin.com>
 <924891c9-fd34-4e7a-bca9-007c80bc327f@lunn.ch>
 <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5OAN5n1TlqpbApOWnEEjQ@bootlin.com>

> > Why is it safe to call dp83869_configure_mode() without the lock, but
> > dp83869_config_aneg() does need the lock? And what are the
> > consequences of not being able to get the lock and so aneg is not
> > configured?
> > 
> > Some comments would be good here.
> 
> Since phy_port has been merged, I'm currently preparing a v3 for this but I'm 
> in need of some general guidance regarding this `mutex_trylock(&phydev->lock)` 
> which has (rightfully) sparked some concerns.
> 
> What data is supposed to be protected by the `phydev->lock` mutex? Is it every 
> field of the phydev struct + standard hardware registers + vendor registers? Or 
> only a subset of these?

The phydev lock should prevent two phylib operations happening at
once. It also protects the members of phylib which are accessed during
the callback when the link changes.

Phylib operations should include access to hwmon sensors and LEDs, if
there is a danger such access could upset things. Since LEDs come
through the phylib core, locking is done for that in the core. But
hwmon sensors are not part of the core.

Since PHYs are pretty simple, and MDIO operations take a lot of time,
it is better to hold the lock than not hold the lock.

	Andrew
