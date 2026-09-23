Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D62737DEB5;
	Wed, 23 Sep 2026 02:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130370; cv=none; b=ELYKuM+O/vNXYBisBYF7u2EksanP/sDnMZJoAbnOjMcdPu/G1SZkez/GxsBwvzB/cIvW4iruM9qBX7qLTkJgimmhl5n8jfNqJWQa8CBqxMwiir8unjVnpUzFsnsXfy88hJvsWqA0diqxIxrbiXjkNoErtZ3yRLmHlhb9zGgDGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130370; c=relaxed/simple;
	bh=u7Zh93ehLZ3lYlwUo4/aTPMg6tJwDR6zibDxyYcBH34=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJpaCuaaJAxIaPMxcIipBAAbsCDpBQ/nOTJ2u4H5LM2/5VgqQN/il9V8l7hA3h4EbrUaY4GwRgwPZH68uU7rBKoMn2wi20rJs1X4t9v057iH/pXSOt0fCllqFhUABuEyjlAozM4QAR9c9YKa+r0wEolNRq+aESgwVDdqKNNKS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVuy3HSr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVuy3HSr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330511F000FF;
	Wed, 23 Sep 2026 02:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790130369;
	bh=jh9hXnvdGSYSzMwhJY2hg1ILgIhX9LjaBOmVRgptleQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lVuy3HSrTYUmoO0dJaHC2lY4WfUaeagZjtQH0J72dURAQFSRY4/tdrK8qltOMGHYj
	 N1gliQ6+AZzpzZUwFpOi0k3IRGqrVfNeNCmSfJk60aeah5OzY7y69mKLlgFIcaGG4u
	 JOsiRcX+NAnhmzqMEk3M/cy4HJOvvDrEP2vmWpAFhfTQP1zPXEBkVd0lFjLIhqNcVr
	 NPg+9YJe9pP2v7DCFEZuZLausgHexdxXNCCXr+f3x3sjKB2agHjQTkCTEw/ypncrQt
	 efubEyNDRRSn2yP5LbShcpHQ8oFZ0CrwXUfONxrI0RGfdOx1EYIDkctY2QBDQc9sMZ
	 xP8TA6OFNxQTg==
Subject: Re: [PATCH net v9 4/4] net: phy: restore the interrupt when the
 generic bind cycle fails
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 02:26:07 +0000
Message-ID: <179013036778.2160803.9271908860128310663@kernel.org>
In-Reply-To: <20260919015326.499479-5-f@lex.la>
References: <20260919015326.499479-5-f@lex.la>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The added restore reads bus->irq[phydev->mdio.addr] instead of
  the value phydev->irq actually held on entry to phy_attach_direct().
- [Medium] The correctness argument the patch states for the new store is
  not backed by any lock or barrier.

Pre-existing issues:
- [Medium] The error_module_put label extended by this patch performs no
  phy_remove()-equivalent rollback when d->driver->probe(d)…

--

net: phy: restore the interrupt when the generic bind cycle fails

The patch adds a restore of phydev->irq on the error_module_put label of
phy_attach_direct(), so that the PHY_POLL substitution done by phy_probe()
does not outlive a hand-bind of the generic driver that failed.  The value
is taken from bus->irq[phydev->mdio.addr] and stored before d->driver is
cleared.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8e6b399f95d6..69d8911ea7f6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1896,6 +1896,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  error_module_put:
>  	module_put(d->driver->owner);
> +	/* Before the NULL below, which lets another probe reach this field. */
> +	phydev->irq = bus->irq[phydev->mdio.addr];

[Severity: Medium]

Is bus->irq[phydev->mdio.addr] always the value phydev->irq held on entry
to phy_attach_direct()?  The array is seeded with PHY_POLL for every
address:

drivers/net/phy/mdio_bus_provider.c:mdiobus_alloc_size() {
	...
	for (i = 0; i < PHY_MAX_ADDR; i++) {
		bus->irq[i] = PHY_POLL;
	...
}

Some producers do keep the two in sync, which is why the restore works for
DT buses:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_register_phy() {
	...
	if (rc > 0) {
		phy->irq = rc;
		mdio->irq[addr] = rc;
	} else {
		phy->irq = mdio->irq[addr];
	}
	...
}

Others write only phydev->irq.  In sxgbe_mdio_register() the probed
interrupt goes into irqlist[] - which is mdio_data->irqs or the private
priv->mii_irq, never mdio_bus->irq[] - and into phy->irq:

drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c:sxgbe_mdio_register() {
	...
			if ((mdio_data->irqs == NULL) &&
			    (mdio_data->probed_phy_irq > 0)) {
				irqlist[phy_addr] = mdio_data->probed_phy_irq;
				phy->irq = mdio_data->probed_phy_irq;
			}
	...
}

On a bus like that, doesn't the new store put PHY_POLL back into
phydev->irq?  That would leave exactly the "a later attach finds a PHY that
can only be polled" state the changelog describes, since sxgbe assigns
phy->irq once at mdiobus_register() time and a later phy_connect() sees the
clobbered value.

The opposite mismatch looks possible too.  A MAC that deliberately forces
PHY_POLL before attaching:

drivers/net/ethernet/qualcomm/emac/emac-mac.c:emac_mac_up() {
	...
	adpt->phydev->irq = PHY_POLL;
	ret = phy_connect_direct(netdev, adpt->phydev, emac_adjust_link,
				 PHY_INTERFACE_MODE_SGMII);
	...
}

If the DT for that bus declares the PHY interrupt, the new line replaces the
caller's PHY_POLL with the bus number on the error path (transient for emac,
which re-sets it before every connect), and in that case phy_probe() never
substituted anything to begin with.

Would saving phydev->irq into a local before d->driver->probe(d) and
restoring that local instead be correct for every producer?

>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;

[Severity: Medium]

The changelog and the new comment rest on this claim:

  "That store is what reopens the device to the driver core: until it runs,
  a driver registering on another CPU is turned away with -EBUSY and
  phy_probe() cannot be the second writer of this field."

Which lock makes that exclusion hold?  The -EBUSY gate is a plain load taken
under device_lock(dev):

drivers/base/dd.c:__driver_probe_device() {
	...
	if (dev->driver)
		return -EBUSY;
	...
}

phy_attach_direct() never takes device_lock(d).  It writes d->driver in the
hand-bind:

	if (!d->driver) {
		if (phydev->is_c45)
			d->driver = &genphy_c45_driver.mdiodrv.driver;
		else
			d->driver = &genphy_driver.mdiodrv.driver;

		phydev->is_genphy_driven = 1;
	}

and clears it on this label, and calls device_bind_driver() in between,
whose kerneldoc states:

drivers/base/dd.c:
 * This function must be called with the device lock held.

With no lock shared between the two sides, can a concurrent
driver_register() -> driver_attach() -> device_driver_attach() ->
__driver_probe_device() observe d->driver == NULL, pass the gate, and run
really_probe() -> phy_probe(), which writes the field again?

drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

That is the "PHY driver module arrives later" case the series is about.

Separately, the intended "restore, then reopen" ordering is two plain stores
to different addresses with no smp_store_release() or smp_wmb(), and the
reader side is a plain load, so on a weakly ordered CPU can the NULL become
visible before the restored irq?

Would performing the hand-bind and this unbind under device_lock(d), as
device_bind_driver() requires, make both the exclusion and the ordering
real?

> error_put_device:

[Severity: Medium]

This isn't a bug introduced by this patch - the label came in with
6d9f66ac7fec - but since the label is being extended, what unwinds
phy_probe() when d->driver->probe(d) succeeded and device_bind_driver()
then failed?

	if (phydev->is_genphy_driven) {
		err = d->driver->probe(d);
		if (err >= 0)
			err = device_bind_driver(d);

		if (err)
			goto error_module_put;
	}

device_bind_driver() returns driver_sysfs_add()'s error and does not call
bus->remove, so the caller owns the rollback, but the label only does
module_put(), the new irq store, is_genphy_driven = 0 and d->driver = NULL.

What phy_probe() established stays live: the kzalloc'd
phydev->led_link_trigger and phy_led_triggers array plus the triggers
registered with the LED core in phy_led_triggers_register(), the phy_port
objects from phy_setup_ports(), the de-asserted reset

drivers/net/phy/phy_device.c:phy_probe() {
	...
	/* Deassert the reset signal */
	phy_device_reset(phydev, 0);
	...
}

and phydev->drv still pointing at genphy_driver while d->driver is NULL.

Because the label clears is_genphy_driven and d->driver, can any later
phy_detach() -> device_release_driver() -> phy_remove() still run the
counterpart teardown?

drivers/net/phy/phy_device.c:phy_remove() {
	...
	if (!phydev->is_on_sfp_module)
		phy_led_triggers_unregister(phydev);
	...
	phy_cleanup_ports(phydev);
	...
	/* Assert the reset signal */
	phy_device_reset(phydev, 1);

	phydev->drv = NULL;
	...
}

The leaked triggers also keep their names registered, so a later
phy_led_triggers_register() for the same MDIO address returns -EEXIST.
phy_probe() ignores that return value, so the next bind still succeeds, just
without LED triggers for that PHY.

One reachable trigger for the sysfs link failure: the bind block keys on the
persistent phydev->is_genphy_driven and runs before the

	if (phydev->attached_dev) {
		dev_err(&dev->dev, "PHY already attached\n");
		err = -EBUSY;

check, so attaching the same phydev twice can make sysfs_create_link()
return -EEXIST.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919015326.499479-1-f%40lex.la
