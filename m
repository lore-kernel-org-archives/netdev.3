Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1831E2931CC;
	Tue, 15 Sep 2026 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789433990; cv=none; b=FGpdBqXJlpmBjfP91R6Ghsgr3C3910X2hHKdz7UEIIbCufBOLvqJ/6zMsewDDjLVyoP+imZ7RGq5xbpZaoV3f1Df0JjitkAZnoGDALrqXTMntx1GDGYg4HpWL+vb6Lbs4xxPM2xJo4GtN2qePCKMEi1sDcwPsjQZ88XuIYbiBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789433990; c=relaxed/simple;
	bh=KOyisDp9939la22wTxBB+DILmVWVkHObqMIBpZXdEDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7/9U/MLUriJQTKW3IlNzgkiwN8cMF+x8NNid6vzOper7ve1VWubWiRgRrdsAw9/B5759UF9+Lp4zo6xBUl2ySNAgj4Po6J6X4XO4iDQeYAQo3sTCoZRHhWbXLD7RY9W/Fzdu0OheUggXIP0866GqU0Mz8A/t6N7fKKhq/fmVnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxlEV8xK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxlEV8xK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B58C1F000FF;
	Tue, 15 Sep 2026 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789433988;
	bh=3vk/FJhiZTOaFyujTIOT+K6LzlomiJBF+vfNM/z43cY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nxlEV8xKzF5JvFYS9SZgVfhKBCaDIPdA03rW4cAprPTUzGr7JDJ2QqjWTNCHpwfN2
	 wlFMn9ETL7IHTYPasG/iEM67AKdRLvBLMXKnphWOaCUOnMGoM3z48XFiAPG4oZw81s
	 StvTjE5WYvjMWcDDvmwFaC5bGKT1xhFmJZ15aCO1TGEdu0MSwMd4drmqHQuUOp+c+4
	 LbvMtn2PuIj3O03kBK2kE9k/LLjEbks5Uk5/YtdULLUKlwmtw1od6I4DjbVIG2PYZ/
	 zoVHW0Kikwyca8TTl3eV0zScb/9iCYdpJHJyoQMLU7v/kxS0fQtB/Eo/+PVdN3pkDq
	 IUc4HOpNXOZig==
From: Jakub Kicinski <kuba@kernel.org>
To: f@lex.la
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v7 2/2] net: phy: take the interrupt back from the bus on detach
Date: Mon, 14 Sep 2026 17:59:46 -0700
Message-ID: <20260915005946.823736-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909204306.2374562-3-f@lex.la>
References: <20260909204306.2374562-3-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: take the interrupt back from the bus on detach

This adds a single store to phy_detach() that re-reads phydev->irq from
mdiobus->irq[phydev->mdio.addr], so that a PHY which spent part of its life
bound to the generic driver does not keep PHY_POLL forever. The intent is to
undo the substitutions made by phy_probe() and phy_attach_direct() without
either of them having to save the previous value.

No Link: tags are present in the commit header.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..84e2da81dbd3d 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1969,6 +1969,11 @@ void phy_detach(struct phy_device *phydev)
>  		phydev->is_genphy_driven = 0;
>  	}
>  
> +	/* Whatever this attachment did to the interrupt, the bus that
> +	 * described it still knows the number. Take it back from there.
> +	 */

[Severity: Medium]
Is the premise in this comment true for all buses?  mdiobus_alloc_size()
fills the table with PHY_POLL:

drivers/net/phy/mdio_bus_provider.c:mdiobus_alloc_size() {
	...
	for (i = 0; i < PHY_MAX_ADDR; i++) {
		bus->irq[i] = PHY_POLL;
	...
}

Only the OF/fwnode path keeps the two in sync:

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

For a bus that never populates the table, is this a restore or an
overwrite?  Documentation/networking/phy.rst tells MAC drivers to select
interrupt behaviour by assigning phydev->irq directly, and drivers do
exactly that:

drivers/net/usb/lan78xx.c:lan78xx_phy_init() {
	...
	if (dev->domain_data.phyirq > 0)
		phydev->irq = dev->domain_data.phyirq;
	...
}

drivers/net/usb/smsc95xx.c:smsc95xx_bind() {
	...
	pdata->phydev->irq = phy_irq;
	...
}

In those cases phy_detach() now stores PHY_POLL over the number the driver
supplied, so the polling-forever behaviour the commit targets is not fixed
there but the driver's own value is lost.  The reverse direction exists as
well, where a driver deliberately declines the interrupt only in
phydev->irq while its MDIO bus is OF-registered:

drivers/net/ethernet/xscale/ixp4xx_eth.c:ixp4xx_eth_probe() {
	...
	phydev->irq = PHY_POLL;
	...
}

drivers/net/ethernet/asix/ax88796c_main.c does the same.  Would a later
attach then re-impose an interrupt the driver refused?

Would saving and restoring the value that the substitution actually
overwrote, or restoring only at the sites where phylib itself wrote
PHY_POLL, avoid depending on a table that most buses leave at the default?

Checked candidates that do not appear to lose anything today: sxgbe never
assigns a real number (plat->mdio_bus_data has no ->irqs or
->probed_phy_irq set in sxgbe_platform.c, so both phy->irq and
mdio_bus->irq[] stay PHY_POLL), and emac-mac, bcmmii, bcmasp_intf and
tsnep re-establish their value on every attach.  lan78xx and smsc95xx
attach once per bind, so the loss there is latent rather than observable.

> +	phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];

[Severity: Medium]
The commit message says:

    Detach is the end of every bind cycle, so this covers the two
    substitutions phy_attach_direct() makes as well as the one in
    phy_probe()

Is that accurate?  phy_attach_direct() binds the generic driver by hand:

drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
	if (phydev->is_genphy_driven) {
		err = d->driver->probe(d);
		if (err >= 0)
			err = device_bind_driver(d);

		if (err)
			goto error_module_put;
	}
	...
}

d->driver->probe is phy_probe(), which writes PHY_POLL before its own
failure points (phydrv->get_features(), which is genphy_read_abilities()
for genphy_driver and propagates MDIO read errors), and
device_bind_driver() can return -ENOMEM from driver_sysfs_add().  The
label that failure lands on does not detach:

drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
error_module_put:
	module_put(d->driver->owner);
	phydev->is_genphy_driven = 0;
	d->driver = NULL;
error_put_device:
	put_device(d);
	...
}

So this bind cycle ends with phydev->irq == PHY_POLL and no restore, while
the other failure label in the same function (error:) does call
phy_detach().  On a retried attach phy_interrupt_is_valid(phydev) is now
false, nothing re-derives the number, and the PHY polls permanently.
Should the restore also cover this path?

[Severity: Medium]
Can this store race a concurrent phy_probe()?  It runs after
device_release_driver(&phydev->mdio.dev) has already made the mdio device
bindable again, and the device lock is not held across the return:

drivers/base/dd.c:device_release_driver_internal() {
	...
	__device_driver_lock(dev, parent);

	if (!drv || drv == dev->driver)
		__device_release_driver(dev, parent);

	__device_driver_unlock(dev, parent);
	...
}

phy_detach() runs on the rtnl side and holds nothing against the driver
core, while phy_probe() is the other reader and writer of the same field
and is serialized only by device_lock():

drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

If a real PHY driver is registered on another CPU inside that window
(phy_driver_register() -> driver_attach() -> really_probe() -> phy_probe()),
two outcomes look possible.  A driver without config_intr/handle_interrupt
demotes to PHY_POLL and this store immediately republishes a valid number,
leaving phy_interrupt_is_valid() true for a driver that cannot service it.
An interrupt-capable driver that binds in the window reads the stale
PHY_POLL and makes a permanent probe-time decision from it:

drivers/net/phy/realtek/realtek_main.c:rtl8211f_probe() {
	...
	if (device_property_read_bool(dev, "wakeup-source") &&
	    phy_interrupt_is_valid(phydev)) {
		device_set_wakeup_capable(dev, true);
		devm_pm_set_wake_irq(dev, phydev->irq);
	}
	...
}

after which the restore leaves an apparently valid runtime IRQ with no wake
IRQ configured.  Would placing the restore before device_release_driver(),
under the same device lock that serializes the next probe, order these?

>  
>  	/* Assert the reset signal */
>  	phy_device_reset(phydev, 1);
>  

[Severity: Low]
Should this carry a Fixes: tag and a stable annotation?  The defect chain is
reproducible in the tree: phy_device_create() seeds dev->irq =
bus->irq[addr], phy_probe() then demotes it with

	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

and genphy_driver has no config_intr or handle_interrupt, so the demotion
always happens for a PHY with a real IRQ.  Nothing re-derives the number
afterwards, since phy_attach_direct() only ever demotes.  The commit that
introduced the phy_probe() substitution looks like the natural Fixes:
target; without it the backport range is undefined.
-- 
pw-bot: cr
