Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232337DE8D;
	Wed, 23 Sep 2026 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130369; cv=none; b=Xj2S5z+reuwYd1CAt0eYia5Ty7mQpYUk3nSWdWVW0OQ5mNUtZVOYUYIPZrWS2vTzgVzBq3MTuAxM7uTCmnxf3H0txkX5O4Kawq3qHGRPrGU0At/Wx5r2gldAsb9E4stNpsASMO2BxLGnvcLi161diDJPBhHc8I1oIQ79k/V5EwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130369; c=relaxed/simple;
	bh=rEJkopIW21nurDd7x8YzN++E5arjg7KsWWS27YK8/U8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wie8kCFXglLNv+EwdIPPUIj2a6lRnMFqCOWFWH6cicypNI+xiIVCVrQC6KXb6An0XkHOlfD9tXUDqFBu3MSHHDLpItCtnaDaUacdZlrdtHLM6lRVJaMtwI7H99kWJmstx8D/LwGm+UVPs5etXaAEcZWvMUj+PZvngCEnhJyhKl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRuJjgKs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRuJjgKs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E7A1F00893;
	Wed, 23 Sep 2026 02:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790130367;
	bh=qH/h3eu0drg6+BVYkuzoi4Bl4yrJbFJ0ChKeOgCrVhk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PRuJjgKsrHtXKAZNKCdy8Df0FOp8GyrsXg2jVs1NUnD5TUJiFgr0ouBY7hWLtGtbs
	 5nOVNNvGfGzeygFRPY44d70r/gJP3iiBwUfpPgh4Jw9MEuaAOxzS4hE8W5tCeAn6Z1
	 MIRt8ubAqjagK9CRFM3EwfrGX+31Tuy20zxIc5UwUifTEdMEvlLlr9Y9+odm6jqa6l
	 vCUenfebB+V87FHfWvEC10SO+cS2cSI3C3Vyz5we8zl/eJi137D/cj/5piC6ijqJvw
	 g7Kv4hMZsYAq3/JMPEH2/gFQQ/ousMJql56d8OEU0XD327PYMwqXvDghxP6NwuMtgy
	 3eUNQS7hToDow==
Subject: Re: [PATCH net v9 3/4] net: phy: take the interrupt back from the bus
 on detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 02:26:06 +0000
Message-ID: <179013036611.2160803.6244884374026520617@kernel.org>
In-Reply-To: <20260919015326.499479-4-f@lex.la>
References: <20260919015326.499479-4-f@lex.la>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new store in phy_detach()
  (drivers/net/phy/phy_device.c:1963) is placed before, and outside, the…
- [Medium] The restore of phydev->irq is not paired with the site that
  clobbers it.
- [Medium] phy_detach() writes phydev->irq
  (drivers/net/phy/phy_device.c:1963) with no lock held on the mdio…
- [Low] Concern that the patch's premise (mdiobus->irq[addr] is always
  where the board's PHY interrupt is recorded) is violated by sxgbe,…
- [Low] The added comment "The release below can hand this field to a
  probe on another CPU." (drivers/net/phy/phy_device.c:1962) ties the…
- [Low] Documentation/networking/phy.rst:216-223 tells MAC drivers that
  phydev->irq is theirs to set directly ("just set phydev->irq to…

--

net: phy: take the interrupt back from the bus on detach

phy_detach() now re-seeds phydev->irq from mdiobus->irq[addr] so that a PHY
which was temporarily bound to the generic driver does not keep the PHY_POLL
value that phy_probe() installed. The store is placed just before the
device_release_driver() call that unbinds the generic driver.

A few questions about the placement and the scope of the new store.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a3..8e6b399f95d6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1959,6 +1959,9 @@ void phy_detach(struct phy_device *phydev)
>  	if (phydev->mdio.dev.driver)
>  		module_put(phydev->mdio.dev.driver->owner);
>  
> +	/* The release below can hand this field to a probe on another CPU. */
> +	phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
> +

[Severity: High]

This store is outside the "if (phydev->is_genphy_driven)" block below, so it
runs on every detach, including detaches where a real driver stays bound and
no phy_probe() will re-derive the field.

Can that duplicate an irqaction for MAC drivers that install
PHY_MAC_INTERRUPT after connecting?  tsnep_phy_open() in
drivers/net/ethernet/engleder/tsnep_main.c does:

	retval = phy_connect_direct(...);	/* requests the PHY interrupt */
	...
	adapter->phydev->irq = PHY_MAC_INTERRUPT;
	phy_start(adapter->phydev);

On close, phy_disconnect() skips the free because the field no longer looks
like a valid irq:

	if (phy_interrupt_is_valid(phydev))
		phy_free_interrupt(phydev);

	phydev->adjust_link = NULL;

	phy_detach(phydev);

so the request_threaded_irq() action stays installed, and phy_detach() now
writes the real interrupt number back into phydev->irq.  On the next ifup,
phy_connect_direct() -> phy_request_interrupt() sees a valid irq and calls
request_threaded_irq() again for the same irq with the same dev_id (phydev),
so a second action is appended for every down/up cycle, and a later
free_irq() removes only one of the two identical actions.

If the trigger types disagree instead, the second request fails and
phy_request_interrupt() takes this path on every ifup:

	phydev_warn(phydev, "Error %d requesting IRQ %d, falling back to polling\n",
		    err, phydev->irq);
	phydev->irq = PHY_POLL;

phy_attach_direct() only re-sanitizes the two cases it knows about:

	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

which recomputes neither PHY_MAC_INTERRUPT nor the polling fallback above.
Would moving the store inside the is_genphy_driven branch, the only case
where a later phy_probe() reads the field, avoid this side effect?

[Severity: Medium]

Is this store synchronized against the other writer of the field?
phy_probe() runs from really_probe() with device_lock(&phydev->mdio.dev)
held, while phy_detach() holds no lock on the mdio device here, so the
lockset intersection for phydev->irq is empty.

The commit message says:

    Ahead of it the generic driver is still bound, and a driver
    registering meanwhile is turned away with -EBUSY before it can reach
    phy_probe().

The -EBUSY does exist, but it comes from __driver_probe_device():

	if (dev->driver)
		return -EBUSY;

and it is evaluated under the device lock that phy_detach() does not hold.
It also does not cover an independent unbind on another CPU:

	unbind_store() -> device_driver_detach() -> device_release_driver()

which clears mdio.dev.driver and makes the device bindable before
phy_detach() reaches its own device_release_driver().  And because the store
is unconditional, it also runs when is_genphy_driven is 0, where phy_detach()
never touches the binding at all and no exclusion of any kind applies.

Would doing the restore under device_lock(&phydev->mdio.dev), or from
phy_remove() which already runs under it, be a better fit than ordering it
before device_release_driver()?

[Severity: Medium]

The restore is not placed at the counterpart of the site that clobbers the
field.  phy_probe() writes PHY_POLL on every bind of a driver without
config_intr/handle_interrupt:

	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

but phy_remove(), which is what undoes phy_probe(), is untouched.  Does the
downgrade then survive a PHY driver swap performed while the interface stays
up?

	echo dev > /sys/bus/mdio_bus/drivers/<no-irq driver>/unbind
	echo dev > /sys/bus/mdio_bus/drivers/<irq-capable driver>/bind

unbind_store() -> device_release_driver() -> phy_remove() does not restore
the field, so the new driver's phy_probe() sees phy_interrupt_is_valid() ==
false and keeps PHY_POLL.  With no phy_detach() afterwards the PHY polls for
the rest of the uptime, which is the same outcome the commit message
describes as "nothing puts it back".  The same holds for rmmod of an
interrupt-less PHY driver followed by modprobe of an interrupt-capable one.

Worth noting that simply moving the restore into phy_remove() is not a
drop-in replacement either: restoring while the PHY is still attached makes
phy_interrupt_is_valid() true for a connection that never requested the irq,
so phy_disconnect() would call phy_free_interrupt() on a line that was never
requested.  Could the field's saved value be tracked explicitly instead of
adding one restore per unwind path?

For context, the follow-on commit in this series ("net: phy: restore the
interrupt when the generic bind cycle fails") adds the same restore to the
error_module_put label in phy_attach_direct(), so the restore is now
duplicated on two caller paths rather than living at the counterpart of the
clobber.

[Severity: Low]

Is mdiobus->irq[addr] authoritative for every bus?  sxgbe_mdio_register()
records a probed PHY interrupt directly in phydev->irq:

	if ((mdio_data->irqs == NULL) &&
	    (mdio_data->probed_phy_irq > 0)) {
		irqlist[phy_addr] = mdio_data->probed_phy_irq;
		phy->irq = mdio_data->probed_phy_irq;
	}

If a bus does that, the unconditional restore here would replace it with the
bus array value.

This particular branch looks unreachable in-tree: the only instantiation of
struct sxgbe_mdio_bus_data is the devm_kzalloc() in sxgbe_probe_config_dt(),
so probed_phy_irq is always 0, and the store above is a no-op for sxgbe.
Is the assumption that no bus keeps the number only in phydev->irq something
that should be spelled out in the commit message?

[Severity: Low]

The comment says "The release below can hand this field to a probe on
another CPU", but the release it refers to is conditional while the store is
not:

	if (phydev->is_genphy_driven) {
		device_release_driver(&phydev->mdio.dev);
		phydev->is_genphy_driven = 0;
	}

For a phydev with a real driver bound there is no release at all, yet the
field is still overwritten.  Could the comment cover that case, or the store
move inside the is_genphy_driven branch?

[Severity: Low]

Documentation/networking/phy.rst currently tells MAC drivers the field is
theirs to set:

    also handles PHY status changes, just set phydev->irq to PHY_MAC_INTERRUPT
    before you call phy_start and use phy_mac_interrupt() from the network
    driver. If you don't want to use interrupts, set phydev->irq to PHY_POLL.

with no mention of mdiobus->irq[].  After this change, mdiobus->irq[addr]
becomes the authoritative store and a MAC-written value only survives until
the next detach.  Should phy.rst and the phy_detach() kernel-doc, which
currently only says it detaches the phy from its network device and driver
and drops the reference taken in phy_attach_direct(), mention the reset?

>  	/* If the device had no specific driver before (i.e. - it
>  	 * was using the generic driver), we unbind the device
>  	 * from the generic driver so that there's a chance a

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919015326.499479-1-f%40lex.la
