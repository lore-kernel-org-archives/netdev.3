Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D822F01
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775467824; cv=none; b=XCmj1REZ3rn3sSO6hj30jXZ0BBGd2EpTdkfk/YJfwQyVNgFOE67MXGLMEmRozxw6l6ECPeEZkDhC42GtF7wLhq4BeWptNyG7/CwGL/7jC4+/sC1kJ+JSd+ZjvhLg+QzGnYIGiVSgOtaRAJ64uHQaWn0Y6ipK3lAEwpqPJra5Q5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775467824; c=relaxed/simple;
	bh=zoPKV2wENFibje5FRAO0JqMwLxTI7htgZwYdHm97UCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vin/nqX2/hXu+DHlNDwjf/0keDKYI11dZYlaDJRltSVc9lpw4Vaj0AMT6f7A9yfJzwrWK2NhoU/PefG2EwwLcI/u35f5H+vv1wzj5ARvUC4nEqHlg4wCVXtbZ4i4a1ArgX17+exHbF2z7mLPcAOOCRZzdVOTBKTE9yFC2vnxUHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1w9gHW-0008Oo-6b; Mon, 06 Apr 2026 11:30:06 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1w9gHV-003zYB-1X;
	Mon, 06 Apr 2026 11:30:05 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1w9gHV-0000000AzK3-1Tn5;
	Mon, 06 Apr 2026 11:30:05 +0200
Date: Mon, 6 Apr 2026 11:30:05 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Kory Maincent <kory.maincent@bootlin.com>,
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
Message-ID: <adN9Ha5FgJ8sp6gj@pengutronix.de>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
 <20260405185730.3937952-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260405185730.3937952-1-github@szelinsky.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sun, Apr 05, 2026 at 08:57:30PM +0200, Carlo Szelinsky wrote:
> Hi Andrew,
> 
> So I went and looked at whether we can just let EPROBE_DEFER do its
> thing here, like you suggested.
> 
> From what I can tell, the issue is where it happens.
> fwnode_mdiobus_register_phy() gets called during the MDIO bus scan in
> __of_mdiobus_parse_phys(), and if any PHY returns -EPROBE_DEFER there,
> the whole scan bails out - none of the PHYs on that bus get registered.
> So you'd lose all networking on that bus just because one PHY's PSE
> controller isn't ready yet.
> 
> I also dug into the timing question you raised. Correct me if I'm
> wrong, but from what I see the deferred probe timeout is 10s and
> regulator_late_cleanup fires at 30s, so the ordering would actually
> work out - the consumer would get to claim the regulator before
> cleanup kills it. It's more the bus level collateral damage that
> seemed like the real problem to me.
> 
> That's basically why I ended up treating EPROBE_DEFER as non-fatal
> for PSE during PHY registration and doing lazy resolution instead.
> The admin_state_synced flag then covers the window between PSE
> controller probe and whenever the lazy resolution actually happens.
> 
> But I might be looking at this the wrong way - would you rather we
> defer the whole bus and accept that trade-off? Or does the lazy
> approach seem reasonable for this case? Happy to hear if you have
> a different idea entirely.

The core question, do we need PSE for PHY functionality? And what it
will cost to decouple it?

We can make a step back and re-evaluate - what functionality and what
order is actually required to find potentially better implementation.

We have a lot of current flowing over wires, budget and port
prioritization issues, things which may damage HW if done not correctly.
With other word, if we do not have properly operational environment
providing system specific policies, it is better to run safe
configuration - all ports/regulators are off.

This means:
- PSE controller driver should be registered as early as possible,
  without caring about existence of PHYs, ports or network interfaces.
  And configure ports in to default safe operation - off. Accept we
  have some controller/firmware which would care about safety.
- as soon as we have all needed components, we can start provide
  controllable interfaces to serve external consumers.

If we decouple PSE and PHY registration (and we probably will need to do
it some day), we would need to have own implementation of deferred
probing in the PSE core.  Event driven or by polling - which sounds not
like very good idea. Pick your poison...

Probably there is no quick and easy fix for now.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
