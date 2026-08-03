Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76931E84E;
	Mon,  3 Aug 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769143; cv=none; b=hw76gEdjI0kGs4nGCVzHGknuoaPiRfDOePUDGMkWUBLLjrLKMXCuJFooEZkb5JkuNYwPw4rBLS4awq1XZNK3JgV3hgimccFlDqTKkWhqqFDn7wD87nI7gTJytq7k9s8Ok4DwwJXc8+1Y6dJT+DyUshamD6Jcym8q48WUWs16BXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769143; c=relaxed/simple;
	bh=KDuDbnl5Ik4EvojWyjHZUafMv5BHieWOdLiU2Wi9b3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhGE/K2vb8TmIgB0c6gQt4eULiBtR6tkbdLg5pBad0Yy3lmrf0Y+Y0KloW9cO5aa6O3JFXY7YREHgkKZcoVCvNh13bURRBlEcj3OKojaGED32YkmH2OKM1YIDJr1x6rxUAajkcnK7Gsi0etDrdebrWUXppNgvltOA8XAPWC2I9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TpeuWugh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TpeuWugh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=96dlq3idf7vxs9Ds9ETsknBLPCm+5ZDiYOvDVTO4d2o=; b=TpeuWughhwuY9zGUW1Fb0vyXwE
	sBlZyUypmv3rPvjvgf0Vn/mywokHpR8fCHLQNVHgbwHHE2jn9cKrz86AgKH89O7SIet3hGTnli5qO
	RjgGB8HmE2Jv4Giw6tH5PM/lsDimNXqqO3g26NPLD4eOyAzvsNybbizsrpSzvF7U2tqU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqu7u-00FkTI-2z; Mon, 03 Aug 2026 16:58:50 +0200
Date: Mon, 3 Aug 2026 16:58:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jianhui Xu <neuromoments@gmail.com>
Subject: Re: [PATCH net-next v5 09/13] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
Message-ID: <fa2cbf05-548b-4ce7-b69b-e46b6cbe486e@lunn.ch>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-9-dcb9fea4acd4@birger-koblitz.de>
 <1cf1c0c8-d7a7-4ff8-9a9d-02dcc993ac14@lunn.ch>
 <5e15ac01-18c1-4cdf-a800-62e2b1427087@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e15ac01-18c1-4cdf-a800-62e2b1427087@birger-koblitz.de>

On Mon, Aug 03, 2026 at 10:53:18AM +0200, Birger Koblitz wrote:
> On 02/08/2026 23:44, Andrew Lunn wrote:
> > > +	/* Enable WoL */
> > > +	if (priv->wolopts) {
> > > +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
> > > +		if (priv->wolopts & WAKE_PHY)
> > > +			tmp8 |= AX_MONITOR_MODE_RWLC;
> > 
> > Have you tested WoL?
> Yes, I tested WoL with the initially submitted driver, and I later checked that
> the register writes around suspend/resume stayed the same. In fact, without
> proper WoL settings, the AX279 will immediately wake up the host again after
> suspend once USB wakeup is enabled for the respective USB device. I successfully
> tested WoL for PHY changes (link state changes, any type of packet received) for
> the 772D, 179A and 279. I did not manage to get WoL to work with magic packets,
> but I could also not make this work with the ASIX Windows driver or ASIX's
> out-of-tree Linux driver, so I assumed I was just not able to send the right type
> of magic packets or my network setup was broken.

sudo apt install wakeonlan

wakeonlan AA:BB:CC:DD:EE:FF

I've used this in the past.

> I really look at the suspend/resume functionality and WoL as a command that is
> sent to the MCU, which then configures MAC/PHY and the USB interface in one
> go and then puts the controller to sleep. It works by configuring a monitor mode
> in the MAC (cmd AX_ACCESS_MAC, register AX_MONITOR_MODe) and then "calling"
> AX88179A_WAKEUP_SETTING, register 8, with bits specifying
> EPHY_LOW_POWER_EN | S5_WOL_EN | S5_WOL_LOW_POWER | 0x8000 which is a mix of USB
> interface options and PHY configuration options plus a the EPHY_LOW_POWER_EN
> command.
> 
> It now looks like suspend/resume is broken in v5 according to Jianhui's tests. Hhowever,
> it was probably already broken in v4. Since this is intermittent, I wonder whether
> the polling of the phy by phylink is to blame, which sometimes may still come after
> the AX88179A_WAKEUP_SETTING sleep command. Can the polling be disabled by the driver
> in the suspend() function?

Better still, the PHY driver should configure WoL in the PHY, and use
phylinks WoL support for everything PHY related. It does require you
know what registers to set in the PHY.

As for waking up too early, we need to understand how the PHY is
waking the MAC. Often the PHYs have an interrupt output pin, which is
tied to a GPIO pin of the SoC which is wake capable. With a USB device
it will be different, but probably still an output from the PHY
connected to a pin of the USB MAC, which wakes the USB device.

It could be that interrupt output is wrongly configured, so it is
reporting some other event? Or it has not been cleared after the last
link up interrupt etc.

     Andrew
