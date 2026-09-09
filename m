Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04B4470126;
	Wed,  9 Sep 2026 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958170; cv=none; b=JnD1kQcZpUVOzbz18RjPPxKn+gVhn6zjBX8+wjoA7ZUkBQS95lGwb2CTqxZETJO/F8jX4i1Z/OzR6WnMUIFJC91/hg4NQRUx5Cm7dJgnVKQbtXRY0lxzYYNXoiCfVWMBRY7E0+X1LIIxjEwtwMfyQEJw1wXhxr3czpk9A3MCtkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958170; c=relaxed/simple;
	bh=B1sreMCeLgFaCbzbi9q65obJCR421TaJxtc4MCXeg6I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iFjL4hssyFv1plMUJYvK4DsTbkcpTGvzGGCQxc1JWgw28IlTPm1jduk8BCs+XQfrRAroXYPOEZLpZtI+mOlT4DEHtc3cqGi0EAKFCI7ralJ1RUJG+nhtKr/SpoSfN7Sa5cdxEy0k4NNgiXCdDyE2yCl/IeUoHuKCdMLnPXlelSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6tC2/PO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6tC2/PO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260791F00A3E;
	Wed,  9 Sep 2026 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788958168;
	bh=NDP1ROEwktuNj1VZC1oESXJyg7Fd6Z56JhsqUR9flNU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X6tC2/POiKd4wUSAFRmCt7gsXDovkyfrwn1mbHT2jLCNeb6AseJwC6j/VSJ5t+sHJ
	 wVavpgklitmKUzGWVyW9RUcCtJ308jLd0/cADHg7zVFcvfB+c3Xtx0jl4G3QoRZelL
	 +ijBImsdvwcZ0pKQ7GiHuhmrJfVI4oG9FaFh81gLOjzaw4uNDN2WbFLW2Pv3/YU5mt
	 8S5d1hUFaPtQwtUTphZ7AVZlpPcpGg6DpQp0u54Ke9s0jl8fYgPTq+Zo3Zca5pMKSe
	 Q9dOyuoQaii0MldGsZw2RETsoVCnx3tlXqlhcT8gTtLpuM6EMRqk+Gw8lwOLp+zGjo
	 pyFYHPhYjlnBw==
Subject: Re: [PATCH net v5 2/2] net: phy: restore the interrupt phy_probe()
 replaced with PHY_POLL
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 12:49:27 +0000
Message-ID: <178895816769.219967.17951898791736048702@kernel.org>
In-Reply-To: <20260906174643.4107607-3-f@lex.la>
References: <20260906174643.4107607-3-f@lex.la>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 0

- [High] Incomplete fix: only the `phydev->irq = PHY_POLL` clobber inside
  phy_probe() (drivers/net/phy/phy_device.c:3712-3715) records the…
- [Medium] phy_restore_probe_irq()
  (drivers/net/phy/phy_device.c:1742-1749) returns early when…
- [Medium] phy_restore_probe_irq()
  (drivers/net/phy/phy_device.c:1742-1749) decides whether it may…

--

net: phy: restore the interrupt phy_probe() replaced with PHY_POLL

The patch records the PHY interrupt number that phy_probe() replaces with
PHY_POLL in a new phy_device field, irq_saved, and puts it back from
phy_remove(), from the phy_probe() error path and from the
phy_attach_direct() unwind of a failed generic bind.  A new helper,
phy_restore_probe_irq(), performs the restore and skips it while
phydev->phy_link_change indicates an attached consumer.

A few questions about the new helper and its call sites below.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 94b2e85e00a37..ba117147721ad 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c

[ ... ]

> @@ -1734,6 +1735,19 @@ static bool phy_drv_supports_irq(const struct phy_driver *phydrv)
>  	return phydrv->config_intr && phydrv->handle_interrupt;
>  }
>  
> +/* Give back what phy_probe() took, but not while phy_link_change marks a
> + * consumer: it skipped phy_request_interrupt() on the value it saw, so
> + * phy_disconnect() would free an interrupt nobody requested.
> + */
> +static void phy_restore_probe_irq(struct phy_device *phydev)
> +{
> +	if (phydev->phy_link_change || phydev->irq_saved == PHY_POLL)
> +		return;
> +
> +	phydev->irq = phydev->irq_saved;
> +	phydev->irq_saved = PHY_POLL;
> +}

[Severity: Medium]
When the phy_link_change test takes the early return, the restore is
neither performed later nor disarmed.  Does that leave two loose ends?

First, is the restore simply dropped?  PHY drivers do not set
suppress_bind_attrs, so a sysfs unbind can reach phy_remove() while a
consumer is still attached.  phy_restore_probe_irq() returns, phydev->irq
stays PHY_POLL, and phy_detach() only clears phy_link_change:

	phydev->phy_link_change = NULL;
	phydev->phylink = NULL;
	...
	if (phydev->is_genphy_driven) {
		device_release_driver(&phydev->mdio.dev);
		phydev->is_genphy_driven = 0;
	}

For a normally bound specific driver is_genphy_driven is 0, so nothing
runs the helper afterwards and no further phy_remove() happens for that
bind.  The next interrupt-capable driver's phy_probe() also cannot re-arm
anything, because its condition requires phy_interrupt_is_valid(), which
is false while irq == PHY_POLL.  Is this not the same end state the patch
sets out to remove?

Second, does irq_saved go stale and get applied to an unrelated driver?
After a suppressed restore, irq_saved still holds the old number, and the
next phy_remove() or phy_probe() error path that runs with no consumer
attached writes it into phydev->irq on behalf of a driver that never took
an interrupt away.  That seems to conflict with the helper's own comment
("Give back what phy_probe() took") and with the new kernel-doc for
@irq_saved ("or PHY_POLL when there is nothing to restore"), and it can
overwrite a value another party installed in the meantime, for example
PHY_MAC_INTERRUPT as set by bcmgenet_mii_probe(), tsnep, bcmasp_intf or
icplus, or the deliberate PHY_POLL fallback in phy_request_interrupt().

>  /**
>   * phy_attach_direct - attach a network device to a given PHY device pointer
>   * @dev: network device to attach

[ ... ]

> @@ -1896,6 +1910,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  error_module_put:
>  	module_put(d->driver->owner);
> +	phy_restore_probe_irq(phydev);
>  	phydev->is_genphy_driven = 0;
>  	d->driver = NULL;
>  error_put_device:

[ ... ]

> @@ -3694,8 +3709,10 @@ static int phy_probe(struct device *dev)
>  	/* Disable the interrupt if the PHY doesn't support it
>  	 * but the interrupt is still a valid one
>  	 */
> -	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev))
> +	if (!phy_drv_supports_irq(phydrv) && phy_interrupt_is_valid(phydev)) {
> +		phydev->irq_saved = phydev->irq;
>  		phydev->irq = PHY_POLL;
> +	}

[Severity: High]
This is the only place that records the replaced number, but
phy_attach_direct() overwrites phydev->irq in two more places, one of them
with the identical condition:

	if (phydev->dev_flags & PHY_F_NO_IRQ)
		phydev->irq = PHY_POLL;

	if (!phy_drv_supports_irq(phydev->drv) && phy_interrupt_is_valid(phydev))
		phydev->irq = PHY_POLL;

Neither writes irq_saved, so irq_saved stays PHY_POLL and
phy_restore_probe_irq() returns at its irq_saved == PHY_POLL test at all
three new call sites.  Is the number then still lost for the remaining
life of the phy_device, exactly as described in the commit message ("the
PHY stays that way for the rest of the uptime")?

There are in-tree orders where phy_probe() never sees a valid number and
phy_attach_direct() does:

stmmac_mdio_register()
    of_mdiobus_register()      /* binds and probes the PHY driver,
                                  bus->irq[addr] is still PHY_POLL */
    phydev->irq = mdio_bus_data->probed_phy_irq;
  ... later ...
    phy_attach_direct()        /* driver has no config_intr/handle_interrupt,
                                  so irq = PHY_POLL, unrecorded */

mlxbf_gige_probe() does the same shape, assigning phydev->irq = phy_irq
right before phy_connect_direct().

phydev->irq is seeded from the bus array only once, in phy_device_create():

	dev->irq = bus->irq[addr];

so nothing re-reads bus->irq[addr] afterwards.  Should the two
phy_attach_direct() sites save the number too?

[ ... ]

> @@ -3820,6 +3837,8 @@ static int phy_probe(struct device *dev)
>  	if (!phydev->is_on_sfp_module)
>  		phy_led_triggers_unregister(phydev);
>  
> +	phy_restore_probe_irq(phydev);
> +
>  	/* Re-assert the reset signal on error */
>  	phy_device_reset(phydev, 1);
>  
> @@ -3848,6 +3867,8 @@ static int phy_remove(struct device *dev)
>  	if (phydev->drv && phydev->drv->remove)
>  		phydev->drv->remove(phydev);
>  
> +	phy_restore_probe_irq(phydev);
> +
>  	/* Assert the reset signal */
>  	phy_device_reset(phydev, 1);
>  

[Severity: Medium]
This adds a writer of phydev->irq from the driver core path, which holds
only device_lock(&phydev->mdio.dev).  The code that sets and clears
phy_link_change and samples phydev->irq runs under rtnl and does not take
the device lock: phy_attach_direct() sets phydev->phy_link_change and then
reads phydev->irq, phy_connect_direct() gates phy_request_interrupt() on
phy_interrupt_is_valid(), phylink_bringup_phy() does the same, and
phy_detach() clears phy_link_change before device_release_driver().  With
no common lock and no READ_ONCE/WRITE_ONCE pairing, is the phy_link_change
test in phy_restore_probe_irq() a check-then-act window rather than a
guard?

One interleaving:

CPU0 (sysfs unbind, device_lock)      CPU1 (rtnl, attach)
phy_remove()
  phy_restore_probe_irq()
    reads phy_link_change == NULL
                                      phy_attach_direct()
                                        phydev->phy_link_change = ...
                                        reads irq == PHY_POLL,
                                        skips phy_request_interrupt()
    phydev->irq = phydev->irq_saved;

The attached consumer now sees a valid IRQ nobody requested,
phy_polling_mode() turns false so link state stops being polled, and the
later phy_disconnect() takes the phy_interrupt_is_valid() branch into
phy_free_interrupt() -> phy_disable_interrupts(), where
phy_config_interrupt() dereferences phydev->drv:

drivers/net/phy/phy.c:phy_config_interrupt() {
	if (phydev->drv->config_intr)
	...
}

phy_remove() sets phydev->drv = NULL just after the restore, and free_irq()
would be called for an interrupt that was never requested.  Can this
happen?

A second interleaving loses the restore instead: phy_detach() clears
phy_link_change before calling device_release_driver(), so a concurrent
unbind that wins the device lock first still observes phy_link_change !=
NULL, skips the restore, and by the time phy_detach() reaches
device_release_driver() the driver is already unbound, so phy_remove()
never runs again.  Would it be better to serialize the guard test, the
phy_link_change transition and the irq update under one lock rather than
adding a second unlocked writer of phydev->irq?

> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index 5f8d65868e0ff..d492417572a0f 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -591,6 +591,8 @@ struct phy_oatc14_sqi_capability {
>   *      - Bits [31:24] are reserved for defining generic
>   *        PHY driver behavior.
>   * @irq: IRQ number of the PHY's interrupt (-1 if none)
> + * @irq_saved: @irq as it was before phy_probe() replaced it with PHY_POLL,
> + *             or PHY_POLL when there is nothing to restore
>   * @phylink: Pointer to phylink instance for this PHY
>   * @sfp_bus_attached: Flag indicating whether the SFP bus has been attached
>   * @sfp_bus: SFP bus attached to this PHY's fiber port

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906174643.4107607-1-f%40lex.la
