Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D32390217;
	Tue, 22 Sep 2026 02:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044139; cv=none; b=DnfFnS8BZDYjPF4DiUvDsCUDuTDkcgdzK1Z11tzIHSrQMhMc0vZeryszGp3EwrgbHVtOK8OxEK3Wzhy0jtzv/h7GIl11/Nl+4Gn1DsgharyC4u1bdjBT9oWNlvzuFnKPpQ7dUy3yHKIwTe0gGlYUs/oRt1/uPsR2u5Mgrrh+xfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044139; c=relaxed/simple;
	bh=xxLLmsYdnOcK46oijUcFRGhcRaYOK4s/z32jJ5xVAK0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rkICqdgnsvdGHLH7+tjuOrFXxVl3KNFoEBTh3cYToPZN9QN5Uggc6fVlHjV1zUNfXAlnT6lnbNuQOE5FOWE54+zDqGCRAdPjspWllXfWVgmzaFEX3H9ZMDi8Ia5Jg0EapDXUvkuYD/zeWP2bhHOpms5hiqkPlc5Zh9DlwlJ4INc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgXAWETO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgXAWETO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046871F00893;
	Tue, 22 Sep 2026 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790044138;
	bh=OTpjwCvIzopZAsegAJhDZso6KU599FU8CKx1JdZ/IBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WgXAWETOqADLO8fNeTo95fNyXVi6vWY4GCT9MaE5w+AqlguMGjjyB7W3Dr7UAJN2N
	 DMUu5Si/2AiqMRvY2r4hQuD2WXZrIC3DJ/nKJrwcsxhryPEhWnwyG1RZ0S9zYCRram
	 1HT29dby58YGzfQESQ+eslJEt3Cl5dOTZ5gfK4Bs8EeHsLco7GvIG/xZPUckYF3zzO
	 koGC6zJ5fBtVip5x2BPTsQZ+rGWPmHkYbOFp73W6nI4LMinjRISWR+cDDjGBQz87ij
	 RHbjO5BYdAej+469ITe7Q7MmFWtf10/kLZbzWgCc9SOrwpiZAbT/6Prx/GPjCbjlsu
	 DHKx6ZBTnY63A==
Subject: Re: [PATCH net v8 3/4] net: phy: take the interrupt back from the bus
 on detach
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 02:28:56 +0000
Message-ID: <179004413652.2160803.536523626270590839@kernel.org>
In-Reply-To: <20260918015029.2518425-4-f@lex.la>
References: <20260918015029.2518425-4-f@lex.la>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new store in phy_detach()
  (drivers/net/phy/phy_device.c:1962-1963) sits above and is not guarded…
- [Medium] Incomplete fix / restore placed at the wrong layer: the
  destructive write lives in phy_probe() (`if…
- [Medium] The new store `phydev->irq =
  phydev->mdio.bus->irq[phydev->mdio.addr]` in phy_detach()…

--

net: phy: take the interrupt back from the bus on detach

phy_detach() now re-seeds phydev->irq from mdiobus->irq[phydev->mdio.addr]
just before the generic driver is released, so that a PHY which was bound to
the generic driver first (because its own driver was a module not yet
available) does not keep the PHY_POLL value phy_probe() installed once the
real driver binds.

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

This store sits above the is_genphy_driven test, so it runs on every
phy_detach() and not only on the generic-driver case the changelog
describes.  Should it be inside that branch?

As written, mii_bus->irq[] becomes the authoritative value for all PHYs, and
any phydev->irq that was never mirrored into the bus array is discarded.
Three cases that seem affected:

First, phylib's own permanent fallback in phy_request_interrupt():

  drivers/net/phy/phy.c:phy_request_interrupt() {
	...
	if (err) {
		phydev_warn(phydev, "Error %d requesting IRQ %d, falling back to polling\n",
			    err, phydev->irq);
		phydev->irq = PHY_POLL;
	...
  }

bus->irq[addr] still holds the number whose request just failed.  After the
restore, does the next connect re-request the known-bad interrupt and print
the warning again, once per cycle?

Second, MAC drivers that set PHY_MAC_INTERRUPT only in phydev->irq, which is
what Documentation/networking/phy.rst tells them to do:

  "If the MAC interrupt of your network driver also handles PHY status
   changes, just set phydev->irq to PHY_MAC_INTERRUPT before you call
   phy_start ... If you don't want to use interrupts, set phydev->irq to
   PHY_POLL."

tsnep_phy_open() does this after phy_connect_direct() has already requested
the bus interrupt:

  drivers/net/ethernet/engleder/tsnep_main.c:tsnep_phy_open() {
	...
	adapter->phydev->irq = PHY_MAC_INTERRUPT;
	phy_start(adapter->phydev);
  }

bcmgenet_mii_probe() and bcmasp_intf.c do the same for internal PHYs.  On
teardown, phy_disconnect() cannot free that registration:

  drivers/net/phy/phy_device.c:phy_disconnect() {
	...
	if (phy_interrupt_is_valid(phydev))
		phy_free_interrupt(phydev);
	...
	phy_detach(phydev);
  }

because phy_interrupt_is_valid(PHY_MAC_INTERRUPT) is false.  With the
restore, the next open calls phy_request_interrupt() again on a DT-described
interrupt that of_mdiobus_register() mirrored into bus->irq[addr].  Does
this leak one irqaction and IRQ thread per ifdown/ifup, where before the
patch the PHY_POLL substitution persisted and bounded it to one?

Third, the reverse direction for buses that record the number only in
phydev->irq plus a private array:

  drivers/net/ethernet/samsung/sxgbe/sxgbe_mdio.c:sxgbe_mdio_register() {
	...
			if ((mdio_data->irqs == NULL) &&
			    (mdio_data->probed_phy_irq > 0)) {
				irqlist[phy_addr] = mdio_data->probed_phy_irq;
				phy->irq = mdio_data->probed_phy_irq;
			}
	...
  }

bus->irq[] is left at the mdiobus_alloc_size() default:

  drivers/net/phy/mdio_bus_provider.c:mdiobus_alloc_size() {
	/* Initialise the interrupts to polling and 64-bit seqcounts */
	for (i = 0; i < PHY_MAX_ADDR; i++) {
		bus->irq[i] = PHY_POLL;
	...
  }

so does an ordinary close/open on sxgbe now silently downgrade a working
interrupt to polling?  stmmac_mdio.c mirrors into new_bus->irq[] and would
not be affected, which suggests the assumption that bus->irq[] always holds
the truth is not tree-wide.

[Severity: Medium]

The destructive write lives in phy_probe():

  drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
  }

but the restore is added to a caller of the bind/unbind sequence rather than
to phy_probe()'s counterpart phy_remove().  Would phy_remove() be the more
complete place for it?

phy_remove() is the hook the driver core runs for every unbind, and it
writes phydev->drv = NULL without touching phydev->irq.  An unbind that does
not come through phy_detach() therefore leaves PHY_POLL in place - for
example a sysfs unbind of the bound non-IRQ-capable driver on the mdio
device, which is reachable because nothing in drivers/net/phy sets
suppress_bind_attrs.  A later-loading interrupt-capable driver then inherits
PHY_POLL for the rest of the session.

phy_probe()'s own out: label also returns with the field already replaced and
never restores it.

The sibling unwind path in phy_attach_direct():

  error_module_put:
	module_put(d->driver->owner);
	phydev->is_genphy_driven = 0;
	d->driver = NULL;

is left with the same gap by this patch and is only closed by the later
patch in this series, "net: phy: restore the interrupt when the generic bind
cycle fails".  With one clobber site and now two hand-placed restores, and
phy_remove() still uncovered, is the caller-side approach the right layer?

[Severity: Medium]

The new store runs with neither device_lock(&phydev->mdio.dev) nor
phydev->lock held, while the other writer of the same field, phy_probe(),
always runs from really_probe() under the mdio device lock.  Is there a
common lock for phydev->irq here?

The comment reasons about ordering against device_release_driver(), but the
binding state is never sampled under the device lock - phy_detach() consults
its own phydev->is_genphy_driven bit, and the generic driver is installed by
a plain assignment in phy_attach_direct():

  drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
	if (!d->driver) {
		if (phydev->is_c45)
			d->driver = &genphy_c45_driver.mdiodrv.driver;
		else
			d->driver = &genphy_driver.mdiodrv.driver;

		phydev->is_genphy_driven = 1;
	}
	...
  }

A concurrent sysfs unbind clears dev->driver and makes the device bindable
independently of this path:

  drivers/base/bus.c:unbind_store() {
	...
	dev = bus_find_device_by_name(bus, NULL, buf);
	if (dev && dev->driver == drv) {
		device_driver_detach(dev);
	...
  }

If that lands while phy_detach() is between its module_put() and this store,
a phy_probe() on another CPU becomes a second unsynchronised writer of the
same int.  Can the resulting lost update drop either the restore this patch
adds or phy_probe()'s PHY_POLL for a driver without interrupt support?

Would doing the restore in phy_remove() under the device lock, or wrapping
it in device_lock()/device_unlock(), close this?  For the
is_genphy_driven == 0 case the changelog offers no exclusion argument at
all, since the pairing with the device mutex only exists on the genphy path.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918015029.2518425-1-f%40lex.la
