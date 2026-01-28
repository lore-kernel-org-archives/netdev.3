Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BA13959D;
	Wed, 28 Jan 2026 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769640494; cv=none; b=GnbMleramRJDancWzS31cFge3OIHl6tAuD5xBW3svl22449e8mEBCwLQfzMKcwJBOpnwLdQLCY9XExCzAIJLTP7+gQD9G1+zPd4VvV/kHi7zFNUJ/3IyXwqmY1eRysZzgEfeejQD6xE3Btf7SNNhDoTMfHLoRjAivdefr4VuXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769640494; c=relaxed/simple;
	bh=vrnO1W+6ac7j5M0/tiDJZSAmJBbRiTOLVFQogL8dHP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udxKy6Xg1v8ta2rnMMjU0NURNCHyWdXFlObA9Te76n3oNK02WubVLXatiycn8glV56xhSxYhQ1EwH4IJsDWr7cPRcggCPfcvy/o+FBkhnXLZ3tgIGPzOGgclfRA5+JjWwtlHiS91j3O2NfTViXlxlfUyVrTPioLetKoaDwC4udE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=n10ph/+0; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="n10ph/+0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+VMl/aaNyIVJsJjKhxjqtuqB/BkcH/0vrzYt9HocKc4=; b=n10ph/+0k7RmnEiXmw9nru7U0N
	A52Hi7TufbaUz9i+HazOFUTQdX6e/Tgh3Z/S5v7UnSz60624dspmXywzV/DtP6owUdsxukkRCYH8C
	syeCItqHkV5l9NmRwkdCd7MfHYOBfQpngRzEjyPeLQvVM14sR1MA77zdB+tYQGsISSE6AYHz3Kd19
	DQZOdn/U1Nsuu4KqrvsEF7hPWxLBOjxFsbEGdB9k9i2jMCbhJrrcWYlL+17Yf+bOev0gGaXnf8RJ3
	cY7wsEokFAeWJP2dJ0KzrqRWnjGls/zJ5WxxuFUeGOBIroEUzdFPa8jgc+ETPq8jLWliMnpoYOvp+
	pU1dW4fg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44740)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vlEKR-000000007yM-3L8V;
	Wed, 28 Jan 2026 22:48:03 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vlEKP-000000007Mo-1w2H;
	Wed, 28 Jan 2026 22:48:01 +0000
Date: Wed, 28 Jan 2026 22:48:01 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
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
Message-ID: <aXqSIU-AjGrqP8wb@shell.armlinux.org.uk>
References: <20260128094644.302313-1-michael@amarulasolutions.com>
 <13d1018c-d9aa-4838-8bb3-35c509cd3e35@lunn.ch>
 <CAOf5uwm30=AVhqm67yz8Y5TkX9FWdxizTevCGSeaQuJS0KqtNA@mail.gmail.com>
 <aXoV-U-yqcDJj2vk@shell.armlinux.org.uk>
 <20260128202634.gqevi76o6wnf5xno@pengutronix.de>
 <fe9385a5-170f-474c-af8d-24bbfa5eb3ab@lunn.ch>
 <CAOf5uwkr0Rmb_x0U88JAfozCQpkOoFOZ-V7BNteVZfcnNQF-Lw@mail.gmail.com>
 <9f6b520c-203d-48cc-8bef-18959672052c@lunn.ch>
 <aXqLBXs0fUIVkQg_@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXqLBXs0fUIVkQg_@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 28, 2026 at 10:17:41PM +0000, Russell King (Oracle) wrote:
> As I've just mentioned earlier in this thread, there seems to be nothing
> special about the LAN8710-like PHYs requiring their XTAL clock to be
> running for reset to be functional. The same is true of AR8035 used
> on i.MX6 SolidRun platforms, and Marvell 88E151x PHYs that I've looked
> at. I would suggest that, in general, _all_ PHYs require their XTAL
> clock to be running.
> 
> Therefore, this is not a work of the PHY at all.
> 
> It is a quirk of the board design to provide the PHY's XTAL clock from
> the SoC, and this _seems_ to be common with FEC based systems, probably
> because there's an easy way to get the clock from the FEC, thus saving
> the cost of a crystal.
> 
> I stated how SolidRun handles this quirk entirely in uboot so the kernel
> doesn't have to care about this at all, and the kernel doesn't get to
> even know that the PHY has a reset GPIO.

I've just been looking at the ZII dev rev B board, which uses a VF610
with a KSZ8041 PHY. It sources its clock from the SoC as well. However,
looking at the PHY datasheet, no clock is specified required during
reset.

However, from what I can see, similar to the SolidRun platforms, the
clock for the PHY isn't described in DT. It goes further though - nor
is the PHY described, nor is the PHYs reset signal (which comes from
io-expander@20).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
