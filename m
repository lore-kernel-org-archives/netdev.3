Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3435A3537F1;
	Wed, 30 Sep 2026 00:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790729906; cv=none; b=MzKdGI/gdOY4jF3pb3Ctlj5DifthF34aWDD9zSgBlUO0c79VO8B37Qy1AEkE/wKLIafZzxxY90MVSyodKKqzOpRDk/EEnVwWcnRcSqGzuJppz67dFN6uezkuVWrrhsBboV0vGvdoTkfbnQDoRru1flbT7CgBhpFE0VIqwW/GiIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790729906; c=relaxed/simple;
	bh=tzZCDoSxNKsQPCDrjUSkAuDBMzxAe8ChtoLNkGU8Mtg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n9H1M4fq1bmFOokKBRYjYgBWSi6cg9J10PFxwaQnBRA49cLv/HRhRZc8ne1HN/SgE0A9S3SXJ373I6S+rzBz+9edaGT5h2bgR/j9wHLVrvPGxuNS1NCgtUfzT4BAdSFwHf0Le4Qfvduh4vtfiTU3M3zBd3JT4WMJCoFrbtkM4mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gE3VYECM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gE3VYECM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62BB1F000FF;
	Wed, 30 Sep 2026 00:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790729904;
	bh=eIYlOld1RD45fGXjoohuDFPVyi9fhKWU3CLt0C5e65E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gE3VYECM8FoW0npKH5xKpuwdggOyGLn6hFRw8CfwAWzmsssRbISeUcniXQQcvdzig
	 2qPYvMhkET/pJ4c4LIwBRm90zURRvqu18Euj1VmxG6i/YPfydGQIZnsm+gjoQkk6YU
	 neTqXMzRq2+RgZHZpnbijYaP7zV0m7o56L6qcqhozYQWDRlCV/9QS/T40sldD3HrxL
	 rT1htXwl1SrMqvM6usvF0YqU7pmMYEVQN/HNgaQE6GAQGnDN93fJHHAVjHSLLNDl2u
	 9sVuvzoY1ZQ+5dFg4oG72uWsp0ntt9SouhKlRfsXmG1F+swdFvFqIKpwlKa0YEL3r3
	 w3+3Ljgkx/1GQ==
Subject: Re: [PATCH net v12 4/4] net: phy: restore the interrupt when the
 generic bind cycle fails
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: netdev@vger.kernel.org, andrew@lunn.ch, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 olteanv@gmail.com, Thangaraj.S@microchip.com, UNGLinuxDriver@microchip.com,
 steve.glendinning@shawell.net, f.fainelli@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 30 Sep 2026 00:58:23 +0000
Message-ID: <179072990329.434549.4676052812956856566@kernel.org>
In-Reply-To: <20260927235733.2619081-5-f@lex.la>
References: <20260927235733.2619081-5-f@lex.la>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When a genphy-driven PHY is attached a second time, the
  error_module_put unwind clears the state of the live first attachment.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the
  error_module_put unwind in phy_attach_direct() does not undo a…

--

net: phy: restore the interrupt when the generic bind cycle fails

This commit saves phydev->irq on entry to phy_attach_direct() and writes it
back on the error_module_put path. The goal is that a failed genphy
probe/bind no longer leaves the PHY in PHY_POLL.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index a9c71a2861186..8bfb154402adc 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1755,6 +1755,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  	struct mii_bus *bus = phydev->mdio.bus;
>  	struct device *d = &phydev->mdio.dev;
>  	struct module *ndev_owner = NULL;
> +	int irq = phydev->irq;
>  	int err;
>  
>  	/* For Ethernet device drivers that register their own MDIO bus, we

[ ... ]

> @@ -1896,6 +1897,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  error_module_put:
>  	module_put(d->driver->owner);
> +	phydev->irq = irq;
>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;

[Severity: High]
The commit message says irq is saved because "the same label is reached
when a second attach of an already attached PHY fails, and there the field
is live". Writing irq back on that path does no harm. What about the other
two writes under this label?

Take a second phy_attach_direct() on a genphy-driven PHY that is still
attached. d->driver is non-NULL, but is_genphy_driven is still 1 from the
first attach. So this block runs again, before the attached_dev check:

    if (phydev->is_genphy_driven) {
        err = d->driver->probe(d);
        if (err >= 0)
            err = device_bind_driver(d);

        if (err)
            goto error_module_put;
    }

phy_probe() runs again on the live PHY. device_bind_driver() then fails
with -EEXIST in driver_sysfs_add(), because the sysfs links from the first
bind are still there.

That sends control to error_module_put. It clears is_genphy_driven and
d->driver on a PHY that is still bound in the driver core and still
attached to the first net_device.

Later the first owner calls phy_detach(), and both of these branches are
skipped:

    if (phydev->mdio.dev.driver)
        module_put(phydev->mdio.dev.driver->owner);
    ...
    if (phydev->is_genphy_driven) {
        /* The release below lets phy_probe() write this field. */
        phydev->irq = phydev->mdio.bus->irq[phydev->mdio.addr];
        device_release_driver(&phydev->mdio.dev);
        phydev->is_genphy_driven = 0;
    }

As a result:

  - The first attach's driver module reference leaks.
  - device_release_driver() and phy_remove() never run.
  - irq is never restored from the bus table.

Would every later attach then fail with -EEXIST, in device_bind_driver()
for genphy or in really_probe() for a real PHY driver? phydev->irq would
stay at PHY_POLL for good, and the phy_device would leak through its klist
reference.

That is the end state this patch tries to prevent, reached through the
path the commit message names.

The clearing itself is older than this patch. It comes from 6d9f66ac7fec
and from the persistent is_genphy_driven flag added in 2796ff1e3dcae7.
Since this patch depends on that path, could genphy be probed, bound and
unwound only when this call assigned d->driver (for example with a local
flag)? Another option would be to check attached_dev before the genphy
probe/bind.

[Severity: Medium]
This is a pre-existing issue, not one this patch introduces. When
phy_probe() succeeds and device_bind_driver() then fails, does
error_module_put leak what phy_probe() set up?

A successful phy_probe() leaves behind:

  - phydev->drv set
  - the reset line released by phy_device_reset(phydev, 0)
  - ports allocated by phy_setup_ports()
  - LED triggers allocated and registered by phy_led_triggers_register()

device_bind_driver() does not call the driver's remove callback when it
fails:

    ret = driver_sysfs_add(dev);
    if (!ret) {
        device_links_force_bind(dev);
        driver_bound(dev);
    }
    else
        bus_notify(dev, BUS_NOTIFY_DRIVER_NOT_BOUND);

error_module_put only restores irq, is_genphy_driven and d->driver. The
teardown that phy_remove() would do never happens:

  - phy_led_triggers_unregister() is not called
  - phy_cleanup_ports() is not called
  - phy_device_reset(phydev, 1) is not called
  - phydev->drv is not cleared

On a retried attach, phy_led_triggers_register() overwrites
phydev->led_link_trigger and phydev->phy_led_triggers. The duplicate
registrations fail with -EEXIST, so the original triggers stay registered
and leak. The PHY is also left out of reset with no driver bound.

This path is reached when driver_sysfs_add() fails on a first attach. It
is also reached on every attach after the second-attach case above.

>  error_put_device:

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927235733.2619081-1-f%40lex.la
