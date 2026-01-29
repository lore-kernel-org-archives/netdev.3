Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B024274B51;
	Thu, 29 Jan 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769697047; cv=none; b=iqoZxHUSq3Ge16zd2Hexj98V1WJ92cZ8EA26H5x9HtnqP3LFq6i1R0atgcNsvS5T61Qic4gzmOU6yepupHN9IZ0I8ygsowJiLciEBixNlYNBbWY7X3m41WeLmCEjgYECwtPxxtpSDTL/wA7RHVouoza3bx29B7Slqvm+lY8S3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769697047; c=relaxed/simple;
	bh=XHO1OFGMsbCbZprXoZQ/s8Gq1cBwoLJHIFtSENSNsL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZH0zYh5rbrqfWLEKEVxYV+lrp68cMbTui5qMZ/A2oFr/EABrsuglwYEkbmKLGsSDNmMyyp6q4y4VN2Pvg0/OkA/qEkYdQnjhQDn9wullrQ0LXnMPRyCNfNswe3ixZI408W0ZjGEteQWsJBiqtSF+jLn/qmQNd9v0EH/hKdFtjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=sHqG2f1u; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="sHqG2f1u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=C8sisnkt7vp94jPSTOLBLrOoHTDRovjotWqPGUp2sVw=; b=sHqG2f1ua7f4/8X4JAz/TeKfNJ
	ZQvt1tmge84LiJKSazALyylNtQKxGWoBpdC2YMjlF207SFqvDTHQjUH1QjvpUjbQek5UfQkFPTgO5
	nWeypQVAPBhboA6tbkjAj8nDZeTU3a2sG286Pnlt1972xlY7utg1Z3GQCInXAx0ulq/JYXxIqmxmk
	wZqygXqPFpOEl2tvBl9Qj18EqMI2a9MFWCxX2xeMNb93bLzxlP6yMy4q5Bzbk6IXjm+orxg9dbQGc
	xmPzNNHK4OpWyvRWnivLetDF4sDg6GpsGjHL6yHzvACG4W1ll0rR6g6sGrXQ3S+IUGAzicv9yD33p
	O1bNKewg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46980)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlT2Z-000000000Aq-0cGg;
	Thu, 29 Jan 2026 14:30:35 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlT2W-0000000083O-1V0f;
	Thu, 29 Jan 2026 14:30:32 +0000
Date: Thu, 29 Jan 2026 14:30:32 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Andrew Lunn <andrew@lunn.ch>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <imx@lists.linux.dev>,
	"open list:FREESCALE IMX / MXC FEC DRIVER" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] net: phy: integrate reset-after-clock quirk into
 phy_init_hw
Message-ID: <aXtvCN6-QDUGbi0P@shell.armlinux.org.uk>
References: <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <aXqJ_TtdBnkvEZ_i@shell.armlinux.org.uk>
 <20260129104123.zir4rtgeiu5qv3i7@pengutronix.de>
 <aXs8m8UodO4griTY@shell.armlinux.org.uk>
 <20260129111726.jjkcq46dpghuorco@pengutronix.de>
 <aXtcydbhclLAxDWZ@shell.armlinux.org.uk>
 <aXteX2YyH3LyDXq-@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXteX2YyH3LyDXq-@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 29, 2026 at 01:19:28PM +0000, Russell King (Oracle) wrote:
> On Thu, Jan 29, 2026 at 01:12:41PM +0000, Russell King (Oracle) wrote:
> > Another possible solution beyond those I've already stated, given that
> > this only afflicts the FEC driver, ould be for the FEC MDIO driver to
> > walk the child nodes, checking to see whether they require any clocks,
> > and ensuring that those are properly initialised before registering the
> > MDIO bus.
> > 
> > Since the MDIO bus layer can release the PHY reset just before probing
> > the driver, this seems to me to be the only way to guarantee that,
> > where boot firmware does not deal with this, the PHY manufacturers
> > specification for the initial release of reset can be met while keeping
> > this FEC specific behaviour out of the core MDIO/phylib layers.
> 
> I'll also add... as kernel developers, we're not very good at insisting
> on generic names for things like clocks (see the mess that is stmmac,
> where the dwmac's various clock signals are named differently in the
> many platform glues.)
> 
> So, I guess that FEC MDIO may need to have a list of clock names to
> look for when inspecting the PHY nodes if the clock is even specified
> there. If it isn't, then some other way of discovering that the PHY
> needs a clock (looking at the pinctrl configuration to see whether
> the pin is configured to output a clock to the PHY?) would need to be
> added.
> 
> However, care needs to be taken in the case where the PHY has already
> been setup by boot firmware, that the clock signal is not disturbed,
> as interrupting it could provoke PHY problems - especially if the
> platform doesn't have the PHY reset specified in DT.

A further issue to add following on from that last paragraph is whether
one is indeed permitted to stop the PHYs XTAL/reference clock or not
after the PHY has been setup. This would depend on the design of the
PHY.

The safe thing to do is not to stop the clock, but if it is desirable
to do so with PHYs that allow it, and provided they do not lose
settings as a result, then we would need some way to inform the MDIO
bus layer when it is safe to stop those clocks. That would require
phylib/mdio code changes to have the driver indicate that this PHY
permits the clock to be stopped.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
