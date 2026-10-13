Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233A051AEC1;
	Tue, 13 Oct 2026 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902986; cv=none; b=LHnuU4+kwJckSAPT6jvbL7QxVY6iKZikqmOmnstjrPZmX7PAk6zJRu50uhaYdpwssVd7gByng1qA7DhGIfMnWfe8PMpK6hR7ajnVFQHl9t5nzCKBU3dxYK4xr5dWOwyZwKZvaAUyvFjpkb9KjPBU/rc9/Sp7N7I0K4CcxS1Bquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902986; c=relaxed/simple;
	bh=3rsb8nWdGvpRdmiKdKsKDYrqQyeYfF2uVimuEu19udQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ghQIJ0+U2GMXLXqDDgFgsNCDtTgL5kc/m8SFpyE2JvDtbPj2NoQctBB9HU3p1Hr6HVrTCcIoBaf4CfEwgzBZLEPrSl3iy4tAz2f6r1uXaz1v24VUc+gKInvj+uq9zAGTKqgVXYzoveUfqc8mAwbKm6bTgz8TNDspGNNnq9IFxS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5kN+fdN6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5kN+fdN6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a1u08QrH8lZikaYUD/nJ/gmcgMLj5GxGBGPSTFzZ71U=; b=5kN+fdN6bPprcZLy1HLjSt2Z+X
	MFqQ3oepORbdLcCmRNnI5J7OjnTgpVq7IfGUlUDRCPuc4mBwCpxw7HQ5d3IEiWHVlQ1zsGV8Pynp1
	cvazABtUhb84Liq1KxOrIsgEV+Bacw055h2gIXtsdhsV2lvDDMKjkoT2rghkkFucQzY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xGdof-00AXbF-KF; Tue, 13 Oct 2026 16:49:21 +0200
Date: Tue, 13 Oct 2026 16:49:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev-bot+sashiko@kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	linux@armlinux.org.uk, hkallweit1@gmail.com, corbet@lwn.net,
	skhan@linuxfoundation.org, o.rempel@pengutronix.de,
	vladimir.oltean@nxp.com, f.fainelli@gmail.com,
	thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] selftests: drv-net: pause: Validate the
 pause autonegotiation with a partner
Message-ID: <669ec93e-29d5-4fba-b272-b3cf27969fc9@lunn.ch>
References: <20260925182628.214667-3-maxime.chevallier@bootlin.com>
 <179065240018.434549.346139764454021625@kernel.org>
 <40f413f0-1dfb-4968-b483-f03aa2f1bdbb@bootlin.com>
 <45340f54-a53b-4d3a-a773-b51cfc88c939@lunn.ch>
 <2a008b68-7f8f-4b30-8026-58d8a64ae5d1@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a008b68-7f8f-4b30-8026-58d8a64ae5d1@bootlin.com>

On Tue, Oct 13, 2026 at 04:02:44PM +0200, Maxime Chevallier wrote:
> 
> 
> On 10/13/26 14:37, Andrew Lunn wrote:
> >>> Firmware-managed NICs such as ice also keep the link on close by default.
> >>> In drivers/net/ethernet/intel/ice/ice_main.c, the PHY is only taken down
> >>> on close when ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA is set:
> >>>
> >>> 	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags)) {
> >>> 		int link_err = ice_phy_cfg(vsi, false);
> >>>
> >>> On this kind of hardware, a directly connected peer would be cached as
> >>> cfg.lp_controllable = False. pause_aneg_resolution(), and the four later
> >>> tests in the series, would then skip with "is not directly connected".
> >>> That message points at cabling, when the real cause is that the PHY
> >>> stayed powered.
> >>>
> >>> The new remote lp_advertising checks in pause_advertising_test() would
> >>> also be skipped without any notice.
> >>
> >> Not much we can do if the peer doesn't behave as expected here. Not sure this
> >> requires attention.
> > 
> > I sounds like anything with a BMC is going to hit this. So i doubt you
> > will see it with your stmmac boards. Maybe sometime in the future we
> > can query the NIC to see if it supports NCSI and change the test
> > behaviour to fit?
> 
> Maybe the strategy is wrong then, the goal is to check that we're directly
> connected to our test peer through a cable, or indirectly through a switch.
> 
> Link flapping seemed to me like the most generic solution, but maybe we can
> do something entirely different ? Like for example trigger a re-negotiation
> with ethtool -r and check for link flap, or maybe more reliably, ask the user
> to pass a flag to the selftest command saying if yes or no we're directly
> connected ?

Triggering a renegotiation is probably the best. I've no experience
with BMCs, but i suspect a down will not work, because it cuts the BMC
off from the network. A renegotiation does seem like a safer choice.

     Andrew
