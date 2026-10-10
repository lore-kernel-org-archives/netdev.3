Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675384B205A;
	Sat, 10 Oct 2026 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791659254; cv=none; b=GK9OuBYlYBtq4Ol2rWzIZWT20rIiAItYniWiD9Gz/UyGVN8SH4PO9PHef5vArUYoQUp+fmcEaKTR10yCoZIad19KvZzCzWQJzbzK4oGbCaEbKl5B1K3sqvq/HOr3foRKYHRXBEAK0UXtkgNuuXTx+E2nAdqE5giyRSImFKbo+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791659254; c=relaxed/simple;
	bh=E94E1uf1F1Tynjm/3MRBH4aaNhJJyvVu56q6/qnyjQo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oG8jPoPriafdvXDbh9oUggPUmEC40IbxhOxgJlxIqDWmcLXt5ti8WlhriV4Dd/HqSo6IzIcDtX/uPsQ5I0wrC3c08rG5sdprkcuD7axkfCiJYm74aVCELY3EEljb8Oq81ufDxeBezVxK5+hiQ7Ja9A7CcagvNsBkZOaldPK3yHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTeCuHjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTeCuHjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CF01F00893;
	Sat, 10 Oct 2026 19:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791659252;
	bh=UJxs76/Pxk8kiE3tiuRxPMubEzaw1bWEcApNHnJJJT0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PTeCuHjkaeHVKf/7HW1JwhwewB0Nyt7jDaHx1AOLlHGo4WXovSSKNg9vr5x57YlnK
	 YvNvaurOUnEgLYinLEa6PnrCPekNv4c83Kor4YC3T5GMDR+3tNsAQ1e/Tva1tckZg/
	 EzoSeddkB1+M9ryEUDVrCZb28CtlIldGteVSoxsrdPtkG3Iw1ooBiSFkFbc0O8SzEc
	 V3oe8p9rX5Krs4m6vKJhPDQvtjiflWtiLeByrcJ72lIN5V9dZXZtvmA+Evlx/aiwRG
	 YQLD/BGV1cBlwBVqTMoAtCBCK4xS35U92zP5PDbnzgJA1jEY+0gL+KutvePCRf0H0k
	 PfzZeQY6E2HzQ==
Subject: Re: [PATCH net-next v5 3/4] net: phy: serialise attach and detach
 with PHY driver bind and unbind
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Sat, 10 Oct 2026 19:07:31 +0000
Message-ID: <179165925160.434549.1346083587752988109@kernel.org>
In-Reply-To: <20261009180551.1234107-4-f@lex.la>
References: <20261009180551.1234107-4-f@lex.la>
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
issue(s) to consider.

Critical: 0 · High: 1 (2) · Medium: 1 (1) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] phy_detach_internal() clears phy_link_change, and swaps out
  drv_owner, inside one bind_lock section (phy_device.c:1740-1744).
- [Medium] phy_attach_direct() now returns -EAGAIN when d->driver is set
  but phydev->bound is false (drivers/net/phy/phy_device.c:1852-1855).
- [Low] The struct phy_device comment for the new mutex says `/* Protects
  bound */` (include/linux/phy.h).
- [Low] The struct mii_bus kernel-doc for notify_phy_attach lists its
  calling context: process context, may sleep, may hold RTNL, must not…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but bind_lock does
  not cover the driver core's own bookkeeping around phy_remove().
- [High] This problem wasn't introduced by this patch, but the genphy
  fallback in phy_attach_direct() still writes d->driver = genphy…
- [Medium] (Baseline: discarded, as a pre-existing medium issue.) In the
  genphy path of phy_attach_direct(), if __phy_probe(d) succeeds and…

--

net: phy: serialise attach and detach with PHY driver bind and unbind

This commit adds a per-PHY bind_lock mutex and a bound flag. Together they
serialise phy_attach_direct() and phy_detach() against phy_probe() and
phy_remove(). An attach that finds a driver bound but not done probing
returns -EAGAIN. The "already attached" test and the drv_owner hand-off
in detach now run under the new mutex.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 68691c487eee5..0ffaa456a308b 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1725,11 +1732,18 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>  		phy_link_topo_del_phy(dev, phydev);
>  	}
>  
> -	phydev->phy_link_change = NULL;
>  	phydev->phylink = NULL;
>  
> -	module_put(phydev->drv_owner);
> +	/* A new attach may pass its "already attached" test as soon as
> +	 * phy_link_change is clear, so take the owner in the same section.
> +	 */
> +	mutex_lock(&phydev->bind_lock);
> +	phydev->phy_link_change = NULL;
> +	drv_owner = phydev->drv_owner;
>  	phydev->drv_owner = NULL;
> +	mutex_unlock(&phydev->bind_lock);
> +
> +	module_put(drv_owner);
>  
>  	/* If the device had no specific driver before (i.e. - it
>  	 * was using the generic driver), we unbind the device

[Severity: High]
After this section drops bind_lock, a second consumer's phy_attach_direct()
can take it and pass the "already attached" test. The rest of the detach
then runs with no lock held:

phy_detach_internal() {
    ...
	if (phydev->is_genphy_driven) {
		/* The release below lets phy_probe() write this field. */
		phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
		device_release_driver(&phydev->mdio.dev);
		phydev->is_genphy_driven = 0;
	}

	/* Assert the reset signal */
	phy_device_reset(phydev, 1);
    ...
}

Take a genphy-driven PHY. The new attach would find d->driver still set
to genphy, bound still true and is_genphy_driven still 1. Would it then
run __phy_probe(d) and device_bind_driver(d) again on a device that is
already probed?

A few outcomes look possible from there.

phy_led_triggers_register() fails with -EEXIST on the duplicate trigger
name and sets phy_num_led_triggers to 0. phy_led_triggers still points at
the registered array. A later phy_led_triggers_unregister() loops zero
times and kfree()s that array, which leaves freed entries on the global
trigger list. phy_setup_ports() also adds duplicate ports.

If device_bind_driver() fails with -EEXIST, error_module_put sets
d->driver = NULL while the driver core still has the device bound. The
old detach's device_release_driver() then does nothing, and later
attaches keep failing with -EEXIST.

If the bind succeeds after the old detach's driver_sysfs_remove(), the
old detach's phy_remove() runs against the new attachment. With the
later patch in this series that makes an unbind wait for the attached
consumer, phy_remove() would wait for the second consumer to detach. The
first detach thread meanwhile holds the device lock and usually rtnl.

For any PHY driver, not only genphy, can the old detach's
phy_device_reset(phydev, 1) run after the new attach's phy_init_hw() has
deasserted reset? That would leave the new consumer's PHY held in reset.

The last patch in the series, "net: phy: make an unbind wait for the
attached consumer to detach", moves only the irq restore ahead of this
locked section. device_release_driver(), the is_genphy_driven clear and
the reset assert still come after it.

[ ... ]

> @@ -1829,23 +1849,29 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  			d->driver = &genphy_driver.mdiodrv.driver;
>  
>  		phydev->is_genphy_driven = 1;
> +	} else if (!phydev->bound) {
> +		phydev_err(phydev, "driver is binding or unbinding\n");
> +		err = -EAGAIN;
> +		goto error_unlock;
>  	}

[Severity: Medium]
This state only lasts while the PHY driver is probing or being removed.
Callers that attach from their own probe pass the error straight up,
for example ethoc_mdio_probe() in drivers/net/ethernet/ethoc.c:

	return dev_err_probe(&dev->dev, err, "could not attach to PHY\n");

and hbg_phy_connect() in drivers/net/ethernet/hisilicon/hibmcge/hbg_mdio.c:

	return dev_err_probe(dev, ret, "failed to connect phy\n");

driver_probe_device() in drivers/base/dd.c calls driver_deferred_probe_add()
only for -EPROBE_DEFER. Any other error, -EAGAIN included, is logged as a
failed probe and is never retried.

Suppose a MAC probe overlaps a PHY driver probe, for example while a PHY
module loads or during async probing at boot. Would the MAC stay unbound
even though the PHY finishes probing moments later?

The commit message says such a MAC "then fails that probe". Would
returning -EPROBE_DEFER here let it recover automatically? The other
option is a kernel-doc note telling probe-time callers to convert
-EAGAIN themselves.

>  
>  	drv_owner = d->driver->owner;

[ ... ]

>  	if (phydev->is_genphy_driven) {
> -		err = d->driver->probe(d);
> +		err = __phy_probe(d);
>  		if (err >= 0)
>  			err = device_bind_driver(d);
>  
>  		if (err)
>  			goto error_module_put;

[Severity: Medium]
This isn't a bug introduced by this patch, since the old
d->driver->probe(d) call had the same gap. If __phy_probe(d) succeeds
and device_bind_driver(d) then fails, error_module_put restores only a
few fields:

error_module_put:
	module_put(phydev->drv_owner);
	phydev->drv_owner = NULL;
	phydev->irq = irq;
	phydev->is_genphy_driven = 0;
	d->driver = NULL;

Several things set up by __phy_probe() are left behind:

- the LED triggers stay registered
- the phy_port entries stay on phydev->ports
- phydev->drv still points at genphy

phy_remove() never runs, because the driver core never recorded the
binding.

On the next attach, phy_led_triggers_register() would fail with -EEXIST
and zero phy_num_led_triggers while the old array is still registered.
Can a later phy_led_triggers_unregister() then kfree() triggers that are
still on the trigger list?

> +
> +		phydev->bound = true;
>  	}

[Severity: High]
This is a pre-existing issue, and the commit message says the generic
driver fallback is not covered. Still, the fallback writes d->driver
without the device lock and runs __phy_probe(d) holding only bind_lock.

A real driver can bind through the driver core at the same time, via a
sysfs bind or __driver_attach() after a module load.
__driver_probe_device() checks for that under device_lock:

	if (dev->driver)
		return -EBUSY;

really_probe() then sets dev->driver, calls driver_sysfs_add() and calls
phy_probe(). phy_probe() runs __phy_probe() before it takes bind_lock.

If that check runs before attach writes d->driver, can two __phy_probe()
calls run on the same phydev at once? Both would write phydev->drv, add
phy_port entries to phydev->ports without a lock, and register duplicate
LED triggers and SFP upstreams.

Attach's device_bind_driver() would then usually fail with -EEXIST.
error_module_put then sets d->driver = NULL while really_probe() is
still running. Would driver_bound() or device_unbind_cleanup() then
dereference a NULL dev->driver?

[ ... ]

> @@ -1928,6 +1954,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  	phy_resume(phydev);
>  
> +	mutex_unlock(&phydev->bind_lock);
> +

[Severity: Low]
bus->notify_phy_attach() is now called with phydev->bind_lock held:

	if (phydev->mdio.bus->notify_phy_attach) {
		err = phydev->mdio.bus->notify_phy_attach(phydev);
		if (err)
			goto error;
	}

The struct mii_bus kernel-doc for notify_phy_attach covers process
context, sleeping and rtnl, but does not mention bind_lock. A bus
implementation that attached, detached or rebound the PHY from this
callback would deadlock on bind_lock through phy_probe() or
phy_remove().

Should the kernel-doc say so? The only in-tree implementer,
otto_emdio_notify_phy_attach() in mdio-realtek-rtl9300.c, does not do
any of this.

A smaller point: the notify_phy_detach doc says it is called "right
after phy_suspend()". phy_detach_internal() now skips phy_suspend() when
bound is false.

>  	/**
>  	 * If the external phy used by current mac interface is managed by
>  	 * another mac interface, so we should create a device link between

[ ... ]

> @@ -3807,10 +3839,30 @@ static int phy_probe(struct device *dev)

[ ... ]

>  static int phy_remove(struct device *dev)
>  {
>  	struct phy_device *phydev = to_phy_device(dev);
>  
> +	mutex_lock(&phydev->bind_lock);
> +	phydev->bound = false;
> +	mutex_unlock(&phydev->bind_lock);
> +
>  	cancel_delayed_work_sync(&phydev->state_queue);

[Severity: High]
This isn't a bug introduced by this patch, but bind_lock does not cover
what the driver core does after phy_remove() returns. In
__device_release_driver(), device_unbind_cleanup() clears dev->driver.
Only after that do device_links_driver_cleanup() and
klist_remove(&dev->p->knode_driver) run.

An attach that takes bind_lock in that gap sees !d->driver and takes the
genphy fallback:

phy_attach_direct()
   d->driver = &genphy_driver.mdiodrv.driver;   (no device lock)
   __phy_probe(d)
   device_bind_driver(d)
      driver_sysfs_add()   succeeds, the old links are already gone
      driver_bound()       device_is_bound() still true, only warns

The unbind thread then runs klist_remove(). The device is left with
dev->driver = genphy and knode_driver on no list.

The next device_release_driver() can come from phy_detach() or from
device_del(). Can klist_remove()->klist_del()->klist_put() then
dereference a NULL knode_klist(n) in lib/klist.c?

[ ... ]

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index a5a419bc400ec..db7c8696743cf 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h

[ ... ]

> @@ -802,6 +804,10 @@ struct phy_device {
>  
>  	struct mutex lock;
>  
> +	/* Protects bound */
> +	struct mutex bind_lock;
> +	bool bound;
> +

[Severity: Low]
This isn't a bug, but the comment says bind_lock protects only bound.
The code relies on it for more than that:

- phy_attach_direct() reads phy_link_change under it as the "already
  attached" test
- phy_detach_internal() clears phy_link_change and swaps drv_owner
  under it

Meanwhile phylink_bringup_phy() in drivers/net/phy/phylink.c writes
phy_link_change without bind_lock:

	phy->phy_link_change = phylink_phy_change;

Today that write only replaces one non-NULL value with another, so the
-EBUSY test still works. It is still a plain write racing with locked
reads.

Should the comment list phy_link_change and drv_owner too? The last
patch in the series changes it to "Protects bound, attached and
removing", which still leaves them out.

>  	/* This may be modified under the rtnl lock */
>  	bool sfp_bus_attached;
>  	struct sfp_bus *sfp_bus;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009180551.1234107-1-f%40lex.la
