Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0434B19A;
	Mon,  6 Apr 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479360; cv=none; b=HENTrZs8wBS5MDAF1v47G/dD9FduMHAZMLlqGCN1REcS/Gvc5CIFIRdVLxkIgJMfK6PRTGAVDlgPpPh1CRS+BwS1CcnWiiteaqOWJgPs3oH5SIiJcxxREwA200BCapHqxUB6TWRbuD1TjqSDiHHxEqaWy6z+q35m1C8sxzZqMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479360; c=relaxed/simple;
	bh=Sv0A+sHdJ2RG8qbrDbw8lVNY4v8YEFz1J6FoU7pUpSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/GYFnPpa0VO3V0QzxcyzlLf0drxOygfKZ9+l+FWLo3+ACc/JG8FJKZFS9jUswI3j9YVpap6pParZ7lGOZIkdFdUFv6+vdDGyGWuHPDxW0UbGzEkY8t6lyxHYeZYhBr5ca4YZ2IO1QK+BRVEln0dD9RdRc7k7YOjIQmv5iovDPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GYDQhlhR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GYDQhlhR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Pl89xt0XO0MVD2bqFFaXnKndIOOiqwaplxwOyuzmR+0=; b=GYDQhlhRXMtHU6pEEWhAabOk7O
	tQRg/t6VCr9oMOICTIFK0m6RC3M0inSbqgDVZ66rOCkxj5n4s30nPnl2W1MYjN6OHH34E2RUPAu2v
	sMmqKPIm9BVPQTXNIxJt2msZlgytIy1sMl2JdgS51xsqgGWn/xaR3JymsP9ZJ6Zz2ZSE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9jHh-00EzCe-Qq; Mon, 06 Apr 2026 14:42:29 +0200
Date: Mon, 6 Apr 2026 14:42:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <3597433c-ce26-43c6-9a5f-e942a3db5340@lunn.ch>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
 <20260405185730.3937952-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405185730.3937952-1-github@szelinsky.de>

On Sun, Apr 05, 2026 at 08:57:30PM +0200, Carlo Szelinsky wrote:
> Hi Andrew,
> 
> So I went and looked at whether we can just let EPROBE_DEFER do its
> thing here, like you suggested.
> 
> >From what I can tell, the issue is where it happens.
> fwnode_mdiobus_register_phy() gets called during the MDIO bus scan in
> __of_mdiobus_parse_phys(), and if any PHY returns -EPROBE_DEFER there,
> the whole scan bails out - none of the PHYs on that bus get registered.
> So you'd lose all networking on that bus just because one PHY's PSE
> controller isn't ready yet.

Something does not sounds correct here. The MDIO bus, and the devices
on the bus should have different life cycles.

If the MDIO bus itself is missing resources it needs, it can return
EPROBE_DEFFER. A typical example of this would be the MDIO bus reset,
which applies to all devices on the bus. If that GPIO is missing, the
probe of the MDIO bus will unwind.

I would expect PHYs on the bus to be just devices in the device
model. They can return EPROBE_DEFER, and the driver core will probe
them again later. This could be a per PHY reset signal, reset
controller, etc, or the PSE. If such a resource is missing, just the
PHY should fail probing, not the whole MDIO bus.

> I also dug into the timing question you raised. Correct me if I'm
> wrong, but from what I see the deferred probe timeout is 10s and
> regulator_late_cleanup fires at 30s, so the ordering would actually
> work out - the consumer would get to claim the regulator before
> cleanup kills it. It's more the bus level collateral damage that
> seemed like the real problem to me.

Your patch 0/X says:

> When a PSE controller driver is built as a module, it may not be
> probed yet when PHYs are registered on the MDIO bus. This causes
> of_pse_control_get() to return -EPROBE_DEFER, destroying the PHY
> device.  Later, regulator_late_cleanup disables the unclaimed PSE
> regulators, permanently killing PoE.

How are we getting to time t=30 without the PSE probing?

If the PSE controller is a module, and missing from the file system,
so cannot be loaded, then turning off the regulators actually seems
like a good safety policy. But if the module is there, but never gets
loaded, it sounds like we have a different sort of problem, some
cyclic dependency we need to break?

	Andrew
