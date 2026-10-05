Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED5E4825C4;
	Mon,  5 Oct 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205302; cv=none; b=IApjzSfNId1mFhz2G9ITVsW3GS/PMuGE/PGIRweymKYNUo+MgkxbSkwaGmUlpzrPSfBx9V+I9PZdT5NPJ+867vDqTv/mD1RbVbINQa5Oic1XdIrxd8OQw4RFAON0sZmwcayCLHgG1IFhrqddOFgYlxaRKE0oxqkan2Pgl3xlJ14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205302; c=relaxed/simple;
	bh=OAhgervoS8Zby2c/eJiYIc3MTYD3CZiAutkZSrfvqgE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dcY8d1UmI+w9dUJ2STrqn7XVp2J7Bb1oUH9b4K5pDTLWTYelIB8GrF4u5VEnQQ+0k5Apfd0wrH+IBIiZ6+ySpnGwFdYyDFY+wsKHHCSbpZ6lewDLIHcZv/MwUW4hhfrevuA4LfyxJSzf8IcdOLz7hIgrg6PDVhz8yPfH1p+vmzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dOPsSO7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dOPsSO7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AEE1F000FF;
	Mon,  5 Oct 2026 13:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791205299;
	bh=C9sUr1iGSGI6Jf+CV6dTPoghrptDKMHUMlDmxWXumII=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dOPsSO7/rcAr1Oo2z1PMblsq19ClyFF7t8PvB/vX/hAs8cEyOQUYEIuy/qRgQ7HFG
	 cSpp5hUKyHO7lbam1VLL+2Rya9VxXqp36v89+awNp9XZAdOKHDb/MXkwoc+OCfmAJP
	 6OwztBqp9mqq62glB/8qpC45zq95ppv2Qx+vngPBiXN/y9rJzNZ128mQr5SB/4SvMo
	 ReAE3Dk3gvhMLg3w/HaYSp+8OrZZWy29QA5H9BNQP/p6KPPDPyWewzj5pdksnTlx2t
	 BU5hDfh8KIDQuuSw4b8ap1uU2NmrM/Ixo3GKFQT815XaknLz7WJxweF2aSrxojZ5Tt
	 krdpYFyxe6V4w==
Subject: Re: [PATCH net-next v4 3/4] net: phy: serialise attach and detach
 with PHY driver bind and unbind
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 f.fainelli@gmail.com, woojung.huh@microchip.com, vladimir.oltean@nxp.com,
 maxime.chevallier@bootlin.com
Date: Mon, 05 Oct 2026 13:01:38 +0000
Message-ID: <179120529808.434549.3692779935939599717@kernel.org>
In-Reply-To: <20261001130120.104628-4-f@lex.la>
References: <20261001130120.104628-4-f@lex.la>
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

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0 (2)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The genphy fallback in phy_attach_direct() is not serialised
  with driver-core probing, so the race this commit says it closes ('an…
- [Medium] phy_attach_direct() now returns -EAGAIN when d->driver is set
  but phydev->bound is false, meaning a PHY driver is in the middle of…

Pre-existing issues:
- [Medium] In the genphy path of phy_attach_direct(), if __phy_probe(d)
  succeeds and device_bind_driver(d) then fails, error_module_put only…
- [Low] The new kernel-doc for phy_attach_direct() promises '-EBUSY if
  the PHY is already attached'.
- [Low] phy_detach_internal() skips phy_suspend() when `bound` is false.

--

net: phy: serialise attach and detach with PHY driver bind and unbind

This commit adds a bind_lock mutex and a bound flag to each PHY in struct
phy_device. phy_probe() sets bound once the driver's probe has finished,
and phy_remove() clears it before teardown. phy_attach_direct() and
phy_detach_internal() hold bind_lock while they call into the driver, and
an attach that finds a driver set but bound clear fails with -EAGAIN.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index b5074599c988f..544b2da6a1d94 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1702,7 +1705,10 @@ static void phy_detach_internal(struct phy_device *phydev, bool notify_bus)
>  		sysfs_remove_file(&phydev->mdio.dev.kobj,
>  				  &dev_attr_phy_standalone.attr);
>  
> -	phy_suspend(phydev);
> +	mutex_lock(&phydev->bind_lock);
> +	if (phydev->bound)
> +		phy_suspend(phydev);
> +	mutex_unlock(&phydev->bind_lock);

[Severity: Low]
This regression was not introduced by this patch, but the detach path
still leaves the PHY powered after an unbind.

phy_remove() clears bound. With the later patch in the series that makes
phy_remove() wait for the consumer to detach, the consumer's detach skips
phy_suspend() here, even though phydev->drv is still valid at that point.

phy_remove() never suspends or powers down the PHY. It only asserts the
optional reset line. On boards without a reset GPIO or reset controller,
does the PHY stay powered with its link up after the MAC has detached?

The baseline ends up in the same state. An unbind while attached ran
phy_remove() first and cleared phydev->drv. The later phy_suspend() then
returned early here:

	if (phydev->suspended || !phydrv)
		return 0;

> @@ -1780,11 +1786,15 @@ EXPORT_SYMBOL(phy_detach);

[ ... ]

> + * Return: 0 on success, -EAGAIN if a driver is being bound to or
> + * unbound from the PHY, -EBUSY if the PHY is already attached, or
> + * another negative error code.
>   */

[Severity: Low]
This is a pre-existing issue, but the -EBUSY documented here comes from a
check at the top of phy_attach_direct() that runs before bind_lock is
taken:

	if (phydev->phy_link_change) {
		phydev_err(phydev, "PHY already attached\n");
		return -EBUSY;
	}

The check is not repeated once bind_lock is held. Two attaches of the same
PHY that rtnl does not serialise could both pass it and then run one after
the other under bind_lock. Would the second one then overwrite
attached_dev, dev->phydev and drv_owner?

This needs two consumers attaching the same PHY without rtnl, which is a
misconfiguration. The baseline check was also unlocked.

> @@ -1814,6 +1824,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  	get_device(d);
>  
> +	mutex_lock(&phydev->bind_lock);
> +
>  	/* Assume that if there is no driver, that it doesn't
>  	 * exist, and we should use the genphy driver.
>  	 */
> @@ -1824,22 +1836,28 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  			d->driver = &genphy_driver.mdiodrv.driver;
>  
>  		phydev->is_genphy_driven = 1;
> +	} else if (!phydev->bound) {
> +		phydev_err(phydev, "driver is binding or unbinding\n");
> +		err = -EAGAIN;
> +		goto error_unlock;
>  	}

[Severity: Medium]
Many callers of phy_attach_direct() run from a MAC or DSA .probe(),
through phy_connect(), of_phy_connect(), phylink_of_phy_connect() or DSA
user port setup. They pass the error straight back. The driver core only
retries a probe that returns -EPROBE_DEFER.

The PHY driver's really_probe() may be somewhere between device_set_driver()
and phy_probe() setting bound when the attach happens. This can happen
during:

  - a deferred-probe retry of a PHY waiting on reset GPIOs, clocks or nvmem
  - a module load
  - a sysfs bind

Does the MAC or DSA probe then fail for good with -EAGAIN? The same applies
to the -ENODEV that of_phy_connect() callers usually return for a NULL
result.

Nothing in phy_attach_direct() or its wrappers maps this to -EPROBE_DEFER
or waits for bound to become true.

>  
>  	if (!try_module_get(d->driver->owner)) {

[ ... ]

>  	if (phydev->is_genphy_driven) {
> -		err = d->driver->probe(d);
> +		err = __phy_probe(d);
>  		if (err >= 0)
>  			err = device_bind_driver(d);
>  
>  		if (err)
>  			goto error_module_put;
> +
> +		phydev->bound = true;
>  	}

[Severity: High]
The new bound check only applies when d->driver is already set. When
d->driver is NULL, the genphy branch checks and sets it while holding only
bind_lock:

	if (!d->driver) {
		if (phydev->is_c45)
			d->driver = &genphy_c45_driver.mdiodrv.driver;
		else
			d->driver = &genphy_driver.mdiodrv.driver;

It then calls __phy_probe(d) and device_bind_driver(d) without the device
lock.

The driver core never takes bind_lock. In drivers/base/dd.c,
__driver_probe_device() checks dev->driver under device_lock():

	if (dev->driver)
		return -EBUSY;

It then calls pm_runtime_get_suppliers(), pm_runtime_get_sync() on the
parent and device_links_check_suppliers(), all of which can sleep. Only
after that does really_probe() set the driver, without any check:

	device_set_driver(dev, drv);

On the PHY side, the new phy_probe() calls __phy_probe() before it takes
bind_lock:

	err = __phy_probe(dev);
	if (err)
		return err;

	mutex_lock(&phydev->bind_lock);

A driver-core probe of the PHY may overlap with phy_attach_direct() from
ndo_open or from a MAC probe. Examples are a PHY driver module loaded after
the PHY was registered, a deferred-probe retry, or a sysfs bind. Can both
sides then see dev->driver as NULL?

These outcomes look possible:

  - In attach, __phy_probe(d) reads phydev->mdio.dev.driver after
    really_probe() has installed the real driver. The real ->probe() then
    runs twice at the same time, and priv, the LED triggers, the ports and
    the SFP upstream are set up twice.

  - phydev->drv becomes the real driver while attach is in the genphy path.
    phy_init_hw() then calls the real config_init before that driver's
    probe has finished. That is the case the commit message says this patch
    closes.

  - The two driver_sysfs_add() calls collide on the driver link with
    -EEXIST. If attach loses, error_module_put sets d->driver = NULL while
    really_probe() is still running. If really_probe() loses, its
    device_unbind_cleanup() clears dev->driver after attach's
    driver_bound() has already put the device on the driver's klist.

The kernel-doc of device_bind_driver() says "This function must be called
with the device lock held." The new @bind_lock kernel-doc in
include/linux/phy.h says "Serialises attach and detach with driver bind and
unbind". Does either hold for the genphy fallback path?

The later patch in the series, "net: phy: make an unbind wait for the
attached consumer to detach", does not touch this path.

The device lock can't be taken here, so would this need another mechanism?
One option is a check that the driver core honours before
device_set_driver(). Another is to do the genphy bind through the driver
core.

[ ... ]

> @@ -1943,7 +1964,8 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	phydev->drv_owner = NULL;
>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;
> -error_put_device:
> +error_unlock:
> +	mutex_unlock(&phydev->bind_lock);

[Severity: Medium]
This isn't a bug introduced by this patch, but the genphy error path does
not undo __phy_probe(). If __phy_probe(d) succeeds and device_bind_driver(d)
then fails, the error_module_put unwind only drops the module reference
and clears drv_owner, is_genphy_driven and d->driver.

Does this leak the LED triggers registered by phy_led_triggers_register()?
The phy_port entries and any SFP upstream registration made by
__phy_probe() also stay in place. phydev->drv still points at genphy, and
the reset line stays deasserted.

The baseline called d->driver->probe(d), which was phy_probe(), with the
same cleanup. The trigger is a driver_sysfs_add() failure such as -ENOMEM,
or a bus notifier refusing the bind.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130120.104628-1-f%40lex.la
