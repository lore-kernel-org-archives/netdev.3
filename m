Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF0391822;
	Tue, 22 Sep 2026 02:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044141; cv=none; b=MgUOF2XsLPFfdpCHpDAky40KdT/mKUCIOsKLnWUtAIEtTn2T3HFlD5gcodGlhhugdQ4Yzs5roVi6Itx2dfeH6fdFZVRcHA5IsTiqffeYSFUY+tMMxyFzsloKgvWv9sSnvJVTI/dtwxequkWVd/a7FydJTly5PmjNl6+OvD5ZZ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044141; c=relaxed/simple;
	bh=MFDMQGfK/jj1+utY/7DiytJ7gey82j0ZX9JqOcE4f2k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RcKgNcP8/bxBbbty1NgYPcvN7s3e8b/pka1+xYrIbCweubMhm2OqlaFktJqcQIKqndZ66JVOukRI4XrBjjVd9eZUAHrIaYytEgRtmhcd53ocCZey6+D52nOLaUBXP4cQQCA61+cfqZ9pJYL6DNuCtKKE0Zl9dLKXD1as8vNfdwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8ku4bOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8ku4bOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE141F000FF;
	Tue, 22 Sep 2026 02:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790044139;
	bh=5BD9Pt+q14mFIGnlV0fMM6Bjm8EYnY2ODMz79ryRyjE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D8ku4bOokKovNmByhGNIj9WlG71TfGpTYb+RXmc81wef7k3BAdCJYWeJpzfL3wtXd
	 JHKijvVfgpDFsMoSIAdEbs3mm1CnH5cFLLVIOxKs2mq53J01SjdVVHSJpbMwUvPvE4
	 ch0tT9rDrxO1djlmeimme5R4nkf+G+IKjx2ZEVUpw0gDbtPj2V+dHvWui3oSnEhaPf
	 Jf5jRZhJmBwIoeicdvMo90pTwWdmw9ITuXyBJHh0DQAP1tNRnROMXB1EDeWHHEigm1
	 N7iTVBSnnwoP1+yV9M34ucgEa3wxVvmdn4aF9n9ouQFYc5uwtXrZGYkya3qR77b94o
	 WBEb3BQyCiDdQ==
Subject: Re: [PATCH net v8 4/4] net: phy: restore the interrupt when the
 generic bind cycle fails
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 02:28:58 +0000
Message-ID: <179004413819.2160803.14290404052748294536@kernel.org>
In-Reply-To: <20260918015029.2518425-5-f@lex.la>
References: <20260918015029.2518425-5-f@lex.la>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The exclusion the commit message relies on does not exist as a
  lock.
- [Low] The new comment added at drivers/net/phy/phy_device.c:1899
  ("Before the NULL below, which lets another probe reach this field.")…

Pre-existing issues:
- [Medium] The error_module_put label that this patch extends
  (drivers/net/phy/phy_device.c:1897-1903) unwinds only the module…

--

net: phy: restore the interrupt when the generic bind cycle fails

This adds a restore of phydev->irq from bus->irq[phydev->mdio.addr] on the
error_module_put label in phy_attach_direct(), so that the PHY_POLL value
installed by phy_probe() does not survive a hand-bind of the generic driver
that never completed. The restore is placed ahead of the d->driver = NULL
store, and the commit message argues that this ordering keeps phy_probe()
from being a second writer of phydev->irq.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 8e6b399f95d6..69d8911ea7f6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1896,6 +1896,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  error_module_put:
>  	module_put(d->driver->owner);
> +	/* Before the NULL below, which lets another probe reach this field. */

[Severity: Low]
Does the code really establish the ordering this comment describes?  The two
stores are plain and touch distinct fields, with no data dependency and no
barrier between them:

drivers/net/phy/phy_device.c:phy_attach_direct() {
	...
	phydev->irq = bus->irq[phydev->mdio.addr];
	phydev->is_genphy_driven = 0;
	d->driver = NULL;
	...
}

Can the compiler, or a weakly ordered CPU, publish the NULL driver pointer
before the IRQ restore becomes visible?  The admission check the commit
message refers to reads the field with no acquire pairing:

drivers/base/dd.c:__driver_probe_device() {
	...
	if (dev->driver)
		return -EBUSY;
	...
}

so a PHY driver registering on another CPU could pass that check and reach
phy_probe(), which writes the same field:

drivers/net/phy/phy_device.c:phy_probe() {
	...
	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;
	...
}

and then the delayed store from the unwind path overwrites PHY_POLL with the
bus interrupt number.  The attach path re-forces PHY_POLL on the next attach
in phy_attach_direct(), so the observable effect looks limited to the stated
guarantee not matching what the stores do.  Would either a real ordering
primitive, or dropping the claim from the comment and the changelog, be more
accurate here?  The same wording was added to the phy_detach() restore by the
preceding commit in the series ("net: phy: take the interrupt back from the
bus on detach"), so both would need the same treatment.

> +	phydev->irq = bus->irq[phydev->mdio.addr];

[Severity: Medium]
Is the exclusion the changelog relies on backed by a lock anywhere?  The
changelog says:

    "That store is what reopens the device to the driver core: until it runs,
    a driver registering on another CPU is turned away with -EBUSY and
    phy_probe() cannot be the second writer of this field."

phy_attach_direct() installs the generic driver, calls its probe and calls
device_bind_driver(d), and later clears d->driver on this label, without ever
taking device_lock(&phydev->mdio.dev).  The driver core documents the
opposite requirement:

drivers/base/dd.c, kernel-doc for device_bind_driver():
 * This function must be called with the device lock held.
 *
 * Callers should prefer to use device_driver_attach() instead.

and every driver-core access to dev->driver happens under that mutex, taken
by __device_driver_lock() on the driver_register() -> driver_attach() ->
__driver_attach() -> device_driver_attach() -> driver_probe_device() path.
With an empty lockset intersection, does the -EBUSY check actually serialize
the two paths?

There also seems to be a wider window than the one this patch reasons about:
if a concurrent __driver_probe_device() observes dev->driver == NULL just
before phy_attach_direct() stores the genphy pointer into it, does anything
prevent really_probe()/device_set_driver() from running while phylib is in
device_bind_driver() -> driver_sysfs_add()/driver_bound() for the same mdio
device?  Would doing the generic bind and unbind under device_lock(d), or via
device_driver_attach()/device_release_driver(), remove the need for the
ordering-by-convention argument altogether?

>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;

[Severity: Medium]
This isn't a bug introduced by this patch, but while this label is being
extended: does it leak what phy_probe() allocated when the bind fails at the
second point?

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

On that path phy_probe() already returned 0, so it has de-asserted the PHY
reset, created the port objects via phy_setup_ports() and registered the LED
triggers via phy_led_triggers_register().  device_bind_driver() returns the
driver_sysfs_add() error without calling the driver's remove callback:

drivers/base/dd.c:device_bind_driver() {
	ret = driver_sysfs_add(dev);
	if (!ret) {
		device_links_force_bind(dev);
		driver_bound(dev);
	}
	else
		bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);
	return ret;
}

Since driver_bound() never ran, the driver core will not call phy_remove(),
which is the only place that undoes those steps:

drivers/net/phy/phy_device.c:phy_remove() {
	phy_cleanup_ports(phydev);

	if (phydev->drv && phydev->drv->remove)
		phydev->drv->remove(phydev);

	/* Assert the reset signal */
	phy_device_reset(phydev, 1);

	phydev->drv = NULL;
	...
}

and the release function is a plain kfree():

drivers/net/phy/phy_device.c:phy_device_release() {
	fwnode_handle_put(dev->fwnode);
	kfree(to_phy_device(dev));
}

Does that leak the port objects and the phy_led_triggers/led_link_trigger
allocations, leave the triggers registered with the LED core for a PHY with
no driver bound, and leave the reset de-asserted?  phydev->drv also stays
pointing at genphy_driver while d->driver is cleared, so does a later
phy_attach_direct() re-run phy_setup_ports() and phy_led_triggers_register()
on top of that state, overwriting and leaking the previous trigger array?

This path was split onto its own label by 6d9f66ac7fec, the commit named in
the Fixes: tag, so it predates this change and the changelog does not claim
to address it.  Would it be worth routing this label through the same cleanup
as phy_remove(), or noting in the changelog that the label is still an
incomplete unwind?

> error_put_device:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918015029.2518425-1-f%40lex.la
