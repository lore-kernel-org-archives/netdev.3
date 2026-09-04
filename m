Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447C3D6CA5;
	Fri,  4 Sep 2026 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509148; cv=none; b=AbbRkdf2KSmvGYusALQSWVav6NqAg19OKh+DCBwHO9lGRiXuZ7ly6lG8CuH8omgdbrW9f3OUSZRyt7bZSBeBcWPyTWFECX14ybniFxjjYfOQJtni732un5TMoi9K0Bg0fdLN5IWwaawqA1zJhhMbTEdAcxraehmSnY3TezeyYwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509148; c=relaxed/simple;
	bh=ePnqaBcOWeyOgNt5so4yYLtNXzzwmxG2dsnuykQE/14=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rnn18nyCQw/6js2X+MM04ThV756rGrE56/7z/7VZ701zYnZouO3mad55q68lX1pM4XFjJpZlhydzxjuZuGg06ZU1ScuiWQVVdaUONlA7iIh7D78Ortw141bnNE5FIFdsyHuee7hH+1IDr6RQe20tmR7UZy4BppV79Rtqqjsv+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xtrf4NM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xtrf4NM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609941F00A3D;
	Fri,  4 Sep 2026 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788509147;
	bh=W3IBYM2BK6Wix3zBHARNq8foS186+CWOMXqyLhUGZkM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Xtrf4NM1b8EMUWg5cmpUD154lwWf1Bu+Tv2RNTpdj9Hb+RTJ4AUGX/G2fOCRENIN+
	 YMQ1zvmuUDXb3iV3aRH5rfowYYE/s3mnbpK8wgIQciFou6KP23aGLAjxo8E1CL56pw
	 yTpeVospw9oFoRRmBpvTuVgcH2uP6FeeHhOWj6Epgr5VPI/X6Sv/CxUDhALSHIA5LF
	 iLWKCQSal93g77CloCpaC+D6lCvIXS8idkedrF+4DTZN9fTHgULirB05dQ5yqv1JrB
	 nbuXVsy4ykP0h4cC6qcVdArCg18sTrNnvuRHYtmRCHDbiqZbo3/3LtgRwyoRSnhCbt
	 WII2a9wWFix1w==
Subject: Re: [PATCH net v4 2/2] net: phy: restore the interrupt after a
 generic-driver bind cycle
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2026 08:05:45 +0000
Message-ID: <178850914589.4131868.9416190597237041128@kernel.org>
In-Reply-To: <20260902080511.2211261-3-f@lex.la>
References: <20260902080511.2211261-3-f@lex.la>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 3 (1) · Low: 0

- [High] phy_restore_genphy_irq() in drivers/net/phy/phy_device.c uses
  bus->irq[phydev->mdio.addr] as the recovery source and its new comment…
- [Medium] phy_restore_genphy_irq()
  (drivers/net/phy/phy_device.c:1742-1746) infers "the bind cycle…
- [Medium] The value is destroyed by phy_probe() (the driver-core ->probe
  callback, drivers/net/phy/phy_device.c:3710-3711) for ANY driver where…
- [Medium] The new phy_restore_genphy_irq() call added at
  phy_attach_direct()'s error_module_put label…

Pre-existing issues:
- [Medium] Pre-existing defect on the error label this patch extends
  (reported only because validation was requested; it is not part of…

--

net: phy: restore the interrupt after a generic-driver bind cycle

A PHY that gets the generic driver at attach time has phydev->irq forced to
PHY_POLL by phy_probe(), and nothing puts it back when the generic driver is
released or when its probe fails.  This patch adds a helper that copies
bus->irq[addr] back into phydev->irq, called from phy_detach() and from the
error_module_put label in phy_attach_direct().

Reference given below the --- separator:
https://lore.kernel.org/netdev/20260824024029.41310-3-f@lex.la/

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..20fc29355f60b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1734,6 +1734,17 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
>  	return phydrv->config_intr && phydrv->handle_interrupt;
>  }
>  
> +/* Undo the PHY_POLL that phy_probe() sets when a driver without
> + * interrupt callbacks binds. The bind cycle never writes bus->irq[],
> + * so the table still holds the pre-bind value; anything else the PHY
> + * carries did not come from the bind and must stand.
> + */
> +static void phy_restore_genphy_irq(struct phy_device *phydev)
> +{
> +	if (phydev->irq == PHY_POLL)
> +		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
> +}

[Severity: High]
The comment states that "the table still holds the pre-bind value".  Is that
true for buses whose consumers install the PHY interrupt only into
phydev->irq and never touch the table?

mdiobus_alloc_size() fills every entry with PHY_POLL:

drivers/net/phy/mdio_bus_provider.c:mdiobus_alloc_size() {
	...
	for (i = 0; i < PHY_MAX_ADDR; i++)
		bus->irq[i] = PHY_POLL;
	...
}

smsc95xx_bind() allocates its bus with mdiobus_alloc() and then only does:

drivers/net/usb/smsc95xx.c:smsc95xx_bind() {
	...
	pdata->phydev->irq = phy_irq;
	...
}

lan78xx does the same with the irq_domain mapping:

drivers/net/usb/lan78xx.c {
	...
		phydev->irq = dev->domain_data.phyirq;
	...
}

For those setups the sequence the changelog describes seems to survive
unchanged: phy_probe() writes PHY_POLL, phy_restore_genphy_irq() reads
PHY_POLL back out of the table, and the specific driver that binds later
still starts polled.  Only producers that mirror the value into the table
(fwnode_mdio.c, stmmac_mdio.c, mlxbf_gige_main.c) are recovered.

Would saving the pre-bind phydev->irq itself, rather than deriving it from
bus->irq[], cover every source?  As it stands, the in-tree comment documents
an invariant that MAC drivers are not currently required to maintain, and
nothing next to mii_bus::irq mentions the new expectation.

[Severity: Medium]
The comment also claims that "anything else the PHY carries did not come from
the bind and must stand", and the changelog says the restore happens "only
where the cycle left PHY_POLL".  Since no pre-bind value or provenance is
recorded, can the equality test really distinguish a bind-installed PHY_POLL
from a caller-installed one?

Other in-tree writers of PHY_POLL, none of which come from the bind cycle:

drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
	if (phydev->dev_flags & PHY_F_NO_IRQ)
		phydev->irq = PHY_POLL;
	...
}

drivers/net/ethernet/xscale/ixp4xx_eth.c:ixp4xx_eth_probe() {
	...
	phydev->irq = PHY_POLL;	/* right after of_phy_get_and_connect() */
	...
}

drivers/net/ethernet/asix/ax88796c_main.c:ax88796c_probe() {
	...
	ax_local->phydev->irq = PHY_POLL;	/* after phy_connect() */
	...
}

drivers/net/ethernet/qualcomm/emac/emac-mac.c also does this.

For such a PHY on a bus that does mirror a live interrupt into bus->irq[],
phy_detach() now hands back the interrupt number that the board or MAC had
deliberately taken out of service.  The next phy_connect_direct() acts on it:

drivers/net/phy/phy_device.c:phy_connect_direct() {
	...
	if (phy_interrupt_is_valid(phydev))
		phy_request_interrupt(phydev);
	...
}

and because those MACs re-assert PHY_POLL after connect, phy_disconnect()
skips phy_free_interrupt(), which is the requested-and-never-freed asymmetry
the changelog says the guard avoids.

There is one more case in the same direction: phy_probe() only overwrites the
irq when phy_interrupt_is_valid() is true:

drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

so a PHY that entered the generic bind already polling is untouched by the
probe, yet it is still "restored" on the way out.  Could the guard be keyed on
state the bind cycle actually records, or the comment reworded as a heuristic?

[Severity: Medium]
The value is destroyed in phy_probe(), which is the driver core ->probe
callback, for any driver where !phy_drv_supports_irq(phydrv).  Why is the undo
placed in the phylib attach/detach pair rather than in phy_remove(), the
matching ->remove callback installed by phy_driver_register()?

phy_remove() already reverts other probe-time state (clears phydev->drv,
re-asserts the reset, unregisters the LED triggers) but does not touch
phydev->irq, and it is reachable without going through phy_detach():

drivers/base/bus.c:unbind_store() {
	...
	if (dev && bus_rescan_devices_helper(dev, NULL) == 0) {
		device_driver_detach(dev);
	...
}

After a sysfs unbind of the generic driver, does phydev->irq stay at
PHY_POLL, so that a real interrupt-capable driver binding afterwards inherits
it and the PHY is polled for the rest of the uptime again?

The same question applies to a real, non-generic PHY driver that lacks
config_intr/handle_interrupt: phy_probe() clobbers phydev->irq for it too, but
phydev->is_genphy_driven is 0, so neither new call site restores anything.

Restoring in phy_remove() from a value saved in phy_probe() would need neither
the irq == PHY_POLL heuristic nor the assumption about bus->irq[].

The changelog says the change covers "both exits" of the bind cycle; the sysfs
unbind exit is mentioned only in the lore link below the --- separator, so it
will not be in git history.

>  
>  /**
>   * phy_attach_direct - attach a network device to a given PHY device pointer
>   * @dev: network device to attach
> @@ -1896,6 +1907,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  error_module_put:
>  	module_put(d->driver->owner);
> +	phy_restore_genphy_irq(phydev);
>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;
>  error_put_device:

[Severity: Medium]
Is this label reached only for "a generic probe that fails", as the changelog
says?  phydev->is_genphy_driven is a persistent bit on the phy_device, and the
probe/bind block in phy_attach_direct() is gated on that bit and runs before
the already-attached check:

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

So a second phy_attach_direct() on a phydev that is already attached and
genphy-driven (for instance two MACs whose phy-handle resolves to the same DT
node) re-runs probe and device_bind_driver() on an already bound device.
device_bind_driver() -> driver_sysfs_add() -> sysfs_create_link() returns
-EEXIST for the links that already exist, and control lands here.

Does that then rewrite the live PHY's irq?  The first successful attach left
it at PHY_POLL, and on a DT/fwnode bus bus->irq[addr] holds a real number.
Once phydev->irq is no longer PHY_POLL the state machine stops re-arming:

drivers/net/phy/phy.c:_phy_state_machine() {
	...
	if (phy_polling_mode(phydev) && phy_is_started(phydev))
		phy_queue_state_machine(phydev,
					phy_get_next_update_time(phydev));
	...
}

and no interrupt was ever requested for the restored number, so link changes
on the still-attached PHY would go undetected with no message.

[Severity: Medium]
This isn't a bug introduced by this patch, but the label being extended here
does not unwind a successful phy_probe().  When probe() returns 0 and
device_bind_driver() then fails, the device is not bound, so the driver core
never calls phy_remove() for this attempt, and this label only does
module_put(), clears is_genphy_driven, clears d->driver and puts the device.

Left behind from phy_probe():

drivers/net/phy/phy_device.c:phy_probe() {
	...
	/* Deassert the reset signal */
	phy_device_reset(phydev, 0);
	...
	if (!phydev->is_on_sfp_module)
		phy_led_triggers_register(phydev);
	...
}

The phydev is not freed here (the mdio bus owns it), so
phydev->phy_led_triggers keeps pointing at the array allocated by
phy_led_triggers_register(), the ports set up by phy_setup_ports() and the sfp
upstream registration stay live, and the PHY is left with its reset
de-asserted.  Should this label also assert the reset and drop those
allocations, or call into a shared unwind with phy_remove()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260902080511.2211261-1-f%40lex.la
