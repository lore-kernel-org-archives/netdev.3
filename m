Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598062EACEF;
	Sun, 27 Sep 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790534138; cv=none; b=n+3dMe3Pj/VYPbCpWQGKp2E0nnsawVfKnJZRWHQHf929NFe9vA2wu0LCFUYLtnMHrfypoJjUnuB8Sx5OE5GjjxTyL8g2xRhgS6hzWAZhaoy+UfSzibrYe+U5BnAYsEXKVH61OHkXbp24tIDSrdRP9w0mqFN8xlj/RESeOVWf9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790534138; c=relaxed/simple;
	bh=EKJrUg+UmlsM08FVZABKDpnglp3VdDMuZdnnztJ1mgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3Fp18MBf4Dcy9mV0ZrdmIj5MNvmabbZNnClBt/7h1IwBS4R7DZJNt2fGg13KbXP6ORqlbTUyM1e0Cfa2D98n6CFmNPz8UuTR6JpS16zDUaEbs4Wf18G9XOsyJpZ/+ObL9tRSZOQyeWliHo9Wp7RHApfLM53n+KV/xhfKg1tnT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SsIjXod2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SsIjXod2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=h1xRcw77CYaaidslrjZ6JCK1D3osdSyeMuCv+HAXjrQ=; b=SsIjXod2BPvTJr9B3RVB9q7oxk
	A5MdliWdu0FF329b9X37jb/Ynw74kOUOutf/w26n9gPMqxXK8kwfuQD/WWtPPYT5/l7IBzgSzBrer
	vzvehos9UhQsofk5PvJSO7dPlB5Kp9im7g9QTJUVJVGdEcCLxx3YFF8dYy0VzDQ/3kTc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAtig-007YJx-V7; Sun, 27 Sep 2026 20:35:26 +0200
Date: Sun, 27 Sep 2026 20:35:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksei Sviridkin <f@lex.la>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	olteanv@gmail.com, Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com, steve.glendinning@shawell.net,
	f.fainelli@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v11 3/4] net: phy: take the interrupt back from the
 bus on detach
Message-ID: <bfc2a494-b5a5-4a0b-bde6-ece2f83f522d@lunn.ch>
References: <20260926235024.705646-1-f@lex.la>
 <20260926235024.705646-4-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926235024.705646-4-f@lex.la>

On Sun, Sep 27, 2026 at 02:50:23AM +0300, Aleksei Sviridkin wrote:
> A PHY whose own driver is a module on a filesystem that is not mounted
> when the MAC probes gets the generic driver first. phy_probe() replaces
> phydev->irq with PHY_POLL because that driver has no interrupt support,
> nothing puts it back, and the PHY polls for the rest of the uptime once
> its real driver takes over. That is where a Keenetic KN-1012 stands,
> with an Airoha EN8811H behind an MT7531 port and its driver on the root
> filesystem: the devicetree interrupt of the PHY maps to irq 15, and once
> the real driver has taken over the field reads -1.
> 
> Take the number back in phy_detach(), from mdiobus->irq[], which is
> where phy_device_create() seeded phydev->irq from and where the bus that
> described the interrupt still holds it. Only under is_genphy_driven,
> since that is the substitution being undone: elsewhere the field belongs
> to whoever wrote it, a MAC installing PHY_MAC_INTERRUPT writes
> phydev->irq alone, and a phy_request_interrupt() that failed leaves
> PHY_POLL there while the bus table still holds the number that could not
> be requested. Under the generic driver a PHY_MAC_INTERRUPT written into
> phydev->irq alone is still replaced; bcmasp, genet and tsnep, the MACs
> that write it that way, write it again after each connect.
> 
> Do it before device_release_driver() rather than after. That call
> returns with the mdio device bindable and the device lock dropped, so
> from then on a phy_probe() on another CPU is the other writer of this
> field; before it, the generic driver is bound and the driver core turns
> such a probe away with -EBUSY. That is ordering, not exclusion: nothing
> on this side holds the device lock. Nor does the ordering hold after a
> sysfs unbind of the generic driver under a consumer, which leaves
> is_genphy_driven set with no driver bound, so the store can race or
> follow the probe of a driver that binds meanwhile. The next
> phy_attach_direct() applies the substitution again for whichever driver
> it finds bound, so the number its callers request still matches that
> driver.
> 
> Fixes: 00db8189d984 ("This patch adds a PHY Abstraction Layer to the Linux Kernel, enabling ethernet drivers to remain as ignorant as is reasonable of the connected PHY's design and operation details.")
> Assisted-by: LLM
> Signed-off-by: Aleksei Sviridkin <f@lex.la>
> ---
> 
> Notes:
>     Found and measured on a Keenetic KN-1012 (MT7981B, MT7531 switch) with an
>     Airoha EN8811H behind lan4, whose interrupt the devicetree describes and
>     whose driver is a module.
>     
>     The one condition arranged for the run is that the PHY driver module loads
>     after the root filesystem rather than from the early boot list this
>     distribution normally puts it in. The distribution's own late-PHY handling
>     was also removed, that being the one patch which could have changed the
>     outcome; upstream has nothing like it. The kernel is still a distribution
>     one and its remaining patches to phylink and phy_device do run on these
>     paths - none of them writes phydev->irq.
>     
>     DSA then sets the port up at 1.87 s, the generic driver is bound by hand,
>     phy_probe() replaces the interrupt with PHY_POLL, and phylink rejects
>     2500base-x against it:
>     
>       lan4 (uninitialized): validation of 2500base-x ... failed: -EINVAL
>       lan4 (uninitialized): failed to connect to PHY: -EINVAL
>     
>     The real driver arrives between 13.4 and 13.6 s depending on the boot, and
>     binds. phydev->irq then reads -1 without this patch and 15 with it, 15
>     being what the devicetree gave that PHY. The three switch ports alongside
>     read 79, 80 and 81 in both runs, so the reading distinguishes rather than
>     printing one answer. The field has no sysfs attribute of its own, so it was
>     read with a debug-only module parameter that walks the MDIO bus and prints
>     it.
>     
>     The reading predates the is_genphy_driven guard the store now sits
>     under, which should not be implied away. On the measured path the flag
>     is set: phylink_fwnode_phy_connect(), which DSA reaches through
>     phylink_of_phy_connect() for this port, calls phy_detach() from its own
>     failure check, and the three writes of that flag are all in
>     phy_device.c, none of them between the hand-bind and that call. So the
>     guard passes and the store is the one the reading came from. Its other
>     side, a detach with a real driver bound, was not measured.

This is still way too much text, which no human is going to read it.

I actually suggest you write this by hand. If you cannot do that, you
don't understand the code sufficiently to actually submit it with your
Signed-of-by.

    Andrew

---
pw-bot: cr
