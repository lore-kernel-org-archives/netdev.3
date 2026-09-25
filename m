Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A957C3375C3;
	Fri, 25 Sep 2026 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790299343; cv=none; b=Jka/fDOPRsZHH1mlLQLqLGlY6jb1qJKtUmITGX8CT8DzMGrVIy+VSdwpZsDPr0nHUKx5IiiQf25ISLtyB3MOtsnOnCZCVeq+tU6HVT8IjHasUuCV8cKA0OswaBHKGxChxEhCv8txrgyBDUA/FlMsq47jPKiQywz6s27IfoEHmjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790299343; c=relaxed/simple;
	bh=2K2h4K9jt7pGkjFOTuuCFQXIyQ8NxnZbG57GeJQuknU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=agsIG+GCh9RWswxNrvbQRUj7lHdRcIIHb1ieFOJm9X6/EYxlRnHjk1j76P1FFk5l6gtB9uBJCfO443PVi/xNzlIQxQAK5v9oT6zslACYT68o52cp6Fro7Y8l7TukLBGAYQIY9urROkGzt1sjnbncpjAEqPKrj33ZXWcViPOogPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffPKpxwy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffPKpxwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBBF1F00893;
	Fri, 25 Sep 2026 01:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790299341;
	bh=LzcTwSM6AeYh2mGQMqqHSRmA18fiJSrgxXzEy0KKnec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ffPKpxwywfgHTX189iUFtiIdeKn46+nRzYy6qiby0vRhtA+tGx1CXsW3WCb2nbdsX
	 J6AcGfDyGFHRiEncVsi6cMnyGfGtbbExHxHistnrX4rqCXdgpNDzV78qGQYn3CdxbX
	 Y4Ez4V70iL80Is4ozNhQbLOi/Uv5Fga228LDzpuPMmQXLjAZA9v1lPHTawlVLiRiYL
	 JqvDmaD0iNnHC627laKvu0r5998lFg7yKgDV70uxfCeM4thOPIQxcfBIZUU81iAXZz
	 k017+EejP3q8kWkf3b+S49AU1o7BTPSZ/zPEfAOAgAoutYdZssH+9Jz0rK8KPdtVZs
	 ibtLMCl1U0t1g==
Subject: Re: [PATCH net v10 4/4] net: phy: restore the interrupt when the
 generic bind cycle fails
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 01:22:20 +0000
Message-ID: <179029934006.2160803.15009748802759836692@kernel.org>
In-Reply-To: <20260922131955.4175785-5-f@lex.la>
References: <20260922131955.4175785-5-f@lex.la>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new unconditional store `phydev->irq =
  bus->irq[phydev->mdio.addr]` at drivers/net/phy/phy_device.c:1900 is…
- [Medium] The correctness argument the commit message gives for the new
  store ("Take the number back on that label as well, before it clears…

Pre-existing issues:
- [High] The `error_module_put` unwind in `phy_attach_direct()`
  (drivers/net/phy/phy_device.c:1897-1902), which this patch extends…

--

net: phy: restore the interrupt when the generic bind cycle fails

The hand-rolled generic driver bind in phy_attach_direct() unwinds on the
error_module_put label, which never runs phy_detach(), so the PHY_POLL
value that phy_probe() writes into phydev->irq used to survive the failed
bind.  This patch adds a store of bus->irq[phydev->mdio.addr] back into
phydev->irq on that label, before d->driver is cleared.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index a9c71a2861186..06161a73fe3f9 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1896,6 +1896,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  error_module_put:
>  	module_put(d->driver->owner);
> +	/* The NULL below lets phy_probe() write this field. */
> +	phydev->irq = bus->irq[phydev->mdio.addr];

[Severity: High]
Can this store land on a PHY that is still attached to another netdev?

phydev->is_genphy_driven is set when the hand-bind happens and is cleared
only by phy_detach() or by this label, so a PHY that attached with the
generic driver keeps is_genphy_driven == 1 and d->driver ==
&genphy_driver.mdiodrv.driver for its whole attached lifetime.  On a second
phy_attach_direct() for that same phydev, the "if (!d->driver)" assignment
is skipped, but the bind block still runs, and it runs before the guard
that is supposed to reject this case:

drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
	if (phydev->is_genphy_driven) {
		err = d->driver->probe(d);
		if (err >= 0)
			err = device_bind_driver(d);

		if (err)
			goto error_module_put;
	}

	if (phydev->attached_dev) {
		dev_err(&dev->dev, "PHY already attached\n");
		err = -EBUSY;
		goto error;
	}
	...
}

device_bind_driver() -> driver_sysfs_add() -> sysfs_create_link() returns
-EEXIST for an already bound device, so error_module_put is reached with no
hardware error involved, and the new store then writes bus->irq[addr] into
the live attachment's phydev->irq.

For a DT PHY with an interrupt, that value is a real IRQ number rather than
PHY_POLL:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_phy_device_register() {
	...
	if (rc > 0) {
		phy->irq = rc;
		mdio->irq[addr] = rc;
	} else {
		phy->irq = mdio->irq[addr];
	}
	...
}

Does the still-working netdev then stop noticing link changes?  No handler
was ever requested, because the first attach saw PHY_POLL, and after the
clobber the state machine no longer re-queues itself:

drivers/net/phy/phy.c:_phy_state_machine() {
	...
	if (phy_polling_mode(phydev) && phy_is_started(phydev))
		phy_queue_state_machine(phydev,
					phy_get_next_update_time(phydev));
	...
}

And on teardown, does phy_disconnect() call free_irq() for an interrupt
that was never requested?

drivers/net/phy/phy_device.c:phy_disconnect() {
	...
	if (phy_interrupt_is_valid(phydev))
		phy_free_interrupt(phydev);
	...
}

Separately, is reconstructing the value from bus->irq[] the same thing as
restoring what phydev->irq held on entry?  Some MACs install phydev->irq
themselves without ever touching bus->irq[]:

drivers/net/ethernet/broadcom/genet/bcmmii.c:bcmgenet_mii_probe() {
	...
	if (priv->internal_phy && !GENET_IS_V5(priv))
		dev->phydev->irq = PHY_MAC_INTERRUPT;
	...
}

Would saving the entry value in a local and writing it back on the label be
more faithful than recomputing it from the bus array?

[Severity: Medium]
The commit message says:

  "Take the number back on that label as well, before it clears d->driver.
   That store is what reopens the device to the driver core: until it runs,
   the core turns a probe away with -EBUSY. That is ordering, not
   exclusion - this bind and its unwind run without the device lock
   device_bind_driver() asks its callers to hold."

Is that ordering actually enforced anywhere?  phydev->irq and d->driver are
non-aliasing plain stores, so the compiler may sink the irq store past the
d->driver = NULL, and on a weakly ordered CPU another core may observe
d->driver == NULL before the irq store becomes visible.

There is also no lock in common with the driver core, which reads and
writes dev->driver only under the device lock:

drivers/base/dd.c:device_bind_driver() {
 * This function must be called with the device lock held.
 *
 * Callers should prefer to use device_driver_attach() instead.
}

drivers/base/dd.c:__driver_probe_device() {
	...
	if (dev->driver)
		return -EBUSY;
	...
}

So can the restore land after a competing bind has already completed?

CPU0 phy_attach_direct()
   device_bind_driver() fails
   d->driver = NULL becomes visible

CPU1 driver_attach() -> really_probe() -> mdio_probe() -> phy_probe()
   takes device_lock(), sees dev->driver == NULL, binds
   drivers/net/phy/phy_device.c:phy_probe() {
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
   }

CPU0
   phydev->irq = bus->irq[phydev->mdio.addr];   /* pending store lands */

leaving the PHY marked interrupt-driven for a driver that cannot service
interrupts, which is the inverse of what the patch intends?  And in the
mirror interleaving, where CPU1 reads phydev->irq before CPU0's store lands,
is the restore simply lost?  There are drivers keying off that value during
config:

drivers/net/phy/smsc.c:smsc_phy_config_init() {
	...
	if (!priv->edpd_mode_set_by_user && phydev->irq != PHY_POLL)
		priv->edpd_enable = false;
	...
}

The detach side does not have this problem, since the equivalent restore is
immediately followed by device_release_driver(), which takes the device lock
internally:

drivers/net/phy/phy_device.c:phy_detach() {
	if (phydev->is_genphy_driven) {
		/* The release below lets phy_probe() write this field. */
		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
		device_release_driver(&phydev->mdio.dev);
		phydev->is_genphy_driven = 0;
	}
}

Would holding device_lock(d) across the hand-bind and its unwind, or using
device_driver_attach(), be preferable to relying on source order here?

>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;
>  error_put_device:

[Severity: High]
This isn't a bug introduced by this patch, but since the patch extends this
label with another per-field restore, is a per-field restore enough here?

The label is also reached when phy_probe() succeeded and only
device_bind_driver() failed:

	if (phydev->is_genphy_driven) {
		err = d->driver->probe(d);
		if (err >= 0)
			err = device_bind_driver(d);

		if (err)
			goto error_module_put;
	}

In that case neither phy_probe()'s own out: unwind nor phy_remove() runs,
so does everything phy_probe() set up stay behind?  phy_probe() registers
LED triggers and sets up ports:

drivers/net/phy/phy_device.c:phy_probe() {
	...
	/* Deassert the reset signal */
	phy_device_reset(phydev, 0);
	...
	/* Register the PHY LED triggers */
	if (!phydev->is_on_sfp_module)
		phy_led_triggers_register(phydev);
	...
}

drivers/net/phy/phy_led_triggers.c:phy_led_triggers_register() {
	...
	phy->led_link_trigger = kzalloc_obj(*phy->led_link_trigger);
	...
	phy->phy_led_triggers = kzalloc_objs(struct phy_led_trigger,
					     phy->phy_num_led_triggers);
	...
}

and only phy_remove() undoes it:

drivers/net/phy/phy_device.c:phy_remove() {
	phy_led_triggers_unregister(phydev);
	...
	phy_cleanup_ports(phydev);
	...
	phy_device_reset(phydev, 1);

	phydev->drv = NULL;
}

Is the leak permanent?  Destroying the phydev does not unregister the
triggers or clean the ports:

drivers/net/phy/phy_device.c:phy_device_release() {
	fwnode_handle_put(dev->fwnode);
	kfree(to_phy_device(dev));
}

Is the missing re-assert of the reset also not self-correcting, given that
the level is cached?

drivers/net/phy/mdio_device.c:mdio_device_reset() {
	...
	if (mdiodev->reset_state == value)
		return;
	...
}

A later bind's de-assert would then be a no-op, so the PHY never gets the
reset pulse the bind sequence provides.

And does phydev->drv stay pointing at genphy_driver while d->driver is set
to NULL on this label, leaving phylib and the driver core disagreeing about
whether a driver is bound?  phy_attach_direct() returns err straight to
phy_connect_direct()/phy_attach(), which propagate it without calling
phy_detach().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922131955.4175785-1-f%40lex.la
