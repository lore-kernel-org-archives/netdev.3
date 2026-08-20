Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B38476061;
	Thu, 20 Aug 2026 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236015; cv=none; b=m3nQZoSX3j2oixholxz8tC7OVJJXawWfM1r7ZeYdJW9pBbbOc6o60qVxmDRCkOniCKf6DXk/UQEFpDtgaQVgk7CWN8Ne4QwiZZ6n36WZOk+TDlWDQ5SY5G/QUvLhsQTral822JUum9pCgMn7OiyRfjQ2ccZ/dyE+E61kaw9uJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236015; c=relaxed/simple;
	bh=qMqgXOuRsAM0dDqiwS6lQpMIkCZTDUKXJZXGnx92Q50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFBM9i7sl1BTlpI/Zo/T8+OAPLv5qts0oLO3kHgXeG4wSg9N3Wokq6XdmwKBZv3PjA7vtsYM4hkcrUUk96qabzJ385leMD+CIsR0XhFTxZ/1CvVbmEFKShAhHf732fLIyg1mzfx8DzQ3QyINXLkf5FCno7RVum7ytKGPOO8gVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jJEUJCmQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jJEUJCmQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=qWBGcju23PeXBkHLUnVihjuIBaPNwI0CWdDZLBNkUrg=; b=jJ
	EUJCmQ5YI0SNGAD82lX1Ufi2CBaVZ7JA73/N/Oq+GsPVuBjfcnK2ReSImYUaUWfQZeLgbScfuoFXy
	qxDoXsvAXqLyeV5xThhvWu3OS4zV3S/Df18GSnhRI/excRlvc6axfDZh7/vLS5U9L7vm4JE0WV45N
	9fY8dAR73csrrpg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wx3it-000nLQ-V2; Thu, 20 Aug 2026 16:26:27 +0200
Date: Thu, 20 Aug 2026 16:26:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com,
	hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH net v3 3/5] net: phy: set PHY_READY after LED setup
Message-ID: <47c28223-7a76-41b2-b602-03302fedd0d1@lunn.ch>
References: <20260819060236.24665-1-xuanqiang.luo@linux.dev>
 <20260819060236.24665-4-xuanqiang.luo@linux.dev>
 <6753cab4-d5ee-4760-813d-4427d880a669@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6753cab4-d5ee-4760-813d-4427d880a669@linux.dev>

On Thu, Aug 20, 2026 at 06:06:41PM +0800, Xuanqiang Luo wrote:
> 
> 在 2026/8/19 14:02, Xuanqiang Luo 写道:
> > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > 
> > phy_probe() sets PHY_READY before calling of_phy_leds(). If LED setup
> > fails, the error path releases the initialized resources while the PHY
> > state remains READY even though probing failed.
> > 
> > Set PHY_READY only after LED setup succeeds.
> > 
> > Fixes: 01e5b728e9e4 ("net: phy: Add a binding for PHY LEDs")
> > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > 
> I noticed that Sashiko found two new issues:
> 
> > > diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> > > index 538e9ca44d093..8fd6fbf378f0a 100644
> > > --- a/drivers/net/phy/phy_device.c
> > > +++ b/drivers/net/phy/phy_device.c
> > > @@ -3799,9 +3799,6 @@ static int phy_probe(struct device *dev)
> > >                   phydev->supported);
> > >      }
> > >  > -    /* Set the state to READY by default */
> > > -    phydev->state = PHY_READY;
> > > -
> > >      /* Register the PHY LED triggers */
> > >      if (!phydev->is_on_sfp_module)
> > >          phy_led_triggers_register(phydev);
> > [Severity: Critical]
> > This is a pre-existing issue, but by ignoring the return value of
> > phy_led_triggers_register() here, could we trigger a double-free later?
> > 
> > In drivers/net/phy/phy_led_triggers.c, if phy_led_triggers_register() fails,
> > it frees phy->phy_led_triggers but leaves it as a dangling pointer and sets
> > phy_num_led_triggers = 0. Since the return value is ignored here, phy_probe()
> > continues execution.
> > 	
> > If of_phy_leds() then fails, the code jumps to out_unreg_led_triggers and
> > calls phy_led_triggers_unregister(). Inside that function, the loop is
> > skipped because phy_num_led_triggers is 0, but it unconditionally calls
> > kfree(phy->phy_led_triggers). This results in a double-free of the dangling
> > pointer.	
> 
> Although this part was not introduced by the current patch, I think it
> still falls within the scope of probe failure handling, so I plan to add
> a separate patch in the next revision to fix it.
> 
> > > @@ -3815,6 +3812,9 @@ static int phy_probe(struct device *dev)
> > >  			goto out_unreg_led_triggers;
> > >  	}
> > >  > +	/* Set the state to READY by default */
> > > +	phydev->state = PHY_READY;
> > > +
> > 
> > [Severity: High]
> > Does moving this lockless state assignment to the end of phy_probe() create
> > a race condition with concurrent MAC driver attachments?

I'm not sure this is correct. If phy_probe() is still ongoing, can you
even call phy_attach()?

In the normal case the MAC driver registers the MDIO bus during its
probe. The PHYs will be scanned and probed synchronously. Once the
MDIO is registered, the MAC driver will then continue. Generally the
PHY is attached in open() but it could be later in probe. So think
this serialisation is performed by general code structure.

It gets more interesting with a shared MDIO bus, which has two or more
PHYs on it. The first MAC driver registers its MDIO bus as above, and
later attaches its PHY. However in parallel a second MAC driver can
probe, and use a phandle to point to the PHY on the MDIO bus, and try
to attach to it. But i _guess_ following the phandle does not work
until the PHY probe has completed?

> This appears to be a pre-existing issue, since phy_attach_direct() and
> phy_probe() are not serialized.
> 
> This patch does widen the race window, but phydev->state should still
> be set to PHY_READY before phy_probe() returns.

I would agree it is an old issues, if it is an issue. So i would say
it is out of scope of this patchset. You can look deeper if you want,
but it is not required.

    Andrew
