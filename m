Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57184489FAB;
	Mon,  5 Oct 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207368; cv=none; b=H/zLQEvBBEpl2Ts853VYWXfLh/+60Cwx0R8XDd6t9WZozBbDoz0Az9zlKJ3/SF1Wg4eQJBIVwKN14JrpjYfhrNGtBDQhES9syMazBvFLT1uUoVjdWB9K0A7NmGqicPV91BnLrwo/lza9DUpkcs4ybhddWtg6KZUh48lbFDIuzNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207368; c=relaxed/simple;
	bh=8Wb/dMyR/xvUvOyRtueF4XMbkzb0xb++mHjmkkE/TWc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/nu+UlgFKq6ZQ0OBnzMiWNGphqdMx2wPKM7NNZrZbPBp2rXr4IIN6+7lP+i+FvLuP9Yz98rNUNg8KaY0RrZ4UlDjFCKbjnwn453s/mvGqXVu7sEQ+xzzGojwmh/uMupLCAEDgvI1+m+L8ybYyG+ofN5cYinFs3hIJh6Nv0TtJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nujtkgo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nujtkgo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9801F000FF;
	Mon,  5 Oct 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207366;
	bh=bFbL7GOfv8IjG1jhfIRb4AfqHpOijMTMiaVoNDe1QUI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nujtkgo0U+/1KCMggbtL//kyCWL/rK4nWOejTnOy5uP6IWROFC3XX7helEkPabOk4
	 ApkxM5uPUQOpcW2pbhEe4hG/2xO6XkIsbBXNpmC+I4OtUGn1FrKtrTToBfizZTtlH3
	 M6OQX/lZSSNXWvhe5BKYPfjk3nOB5Bmqom2hD3HtmSZSv8ZNLjGLdTxZITPwQ+AOAW
	 U1GhhKZLKP1hzGAZnZU5/qunSKcLSLtI4OO87lnKSwQ+kNo6GhH6YjEnv/Z1js4eP6
	 JhSJFq/eoK6UrF3ql6sge85gilYNRV7+zAC5pN5gM/F6m7iqn3hm3LDagl8YtUjm9h
	 UvymcTzbKy4gA==
Subject: Re: [PATCH net-next v5 2/3] net: phylink: wait for PHYs that are
 known to probe late
From: netdev-bot+sashiko@kernel.org
To: f@lex.la
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conor@kernel.org, f.fainelli@gmail.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Date: Mon, 05 Oct 2026 13:36:04 +0000
Message-ID: <179120736418.434549.3034364543286173403@kernel.org>
In-Reply-To: <20261001130208.105558-3-f@lex.la>
References: <20261001130208.105558-3-f@lex.la>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 5

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The deferral gate in phylink_fwnode_phy_connect() does not
  exclude MLO_AN_INBAND.
- [Medium] phylink_phy_is_usable() checks only that a driver is bound.
- [Medium] phylink_phy_is_usable() calls
  device_is_bound(&phy_dev->mdio.dev) and reads phy_dev->drv without…
- [Low] Concern: nothing in the tree sets
  phylink_config.phy_may_probe_late, so the deferral in…
- [Low] The commit message argues that MACs which connect from ndo_open
  do not need the deferral, because "a PHY taken by genphy at one open…
- [Low] If a PHY from another path (an SFP module PHY via
  phylink_sfp_connect_phy()) attaches while the deferral is armed,…
- [Low] In phylink_late_phy_poll(), the lost-race check (`if (!ret &&
  phy_driver_is_genphy(phy_dev))`) only runs when phylink_attach_phy()…
- [Low] Concern: the deferral gate does not exclude MACs with
  phylink_config.mac_requires_rxc, so such a MAC could go through…

--

net: phylink: wait for PHYs that are known to probe late

This adds an opt-in deferral to phylink_fwnode_phy_connect() for PHYs
marked needs-host-firmware whose driver has not bound yet. A delayed work
item polls under rtnl_trylock() until the driver binds, then attaches and
brings up the PHY, with a bounded number of retries on connect failure.
Until then the ethtool link settings paths report no link modes or return
-EOPNOTSUPP.

> Found on a Keenetic KN-1012 (MT7981B with an MT7531 switch): the EN8811H
> behind lan4 has its driver on the root filesystem, the switch sets its
> ports up before that is mounted, and lan4 was lost for the uptime. With
> this change lan4 attaches once the module loads.

[Severity: Low]
Is this accurate for this commit on its own? At this point nothing in the
tree sets phylink_config.phy_may_probe_late. The deferral in
phylink_fwnode_phy_connect() cannot be reached on the KN-1012 until the
following patch, "net: dsa: let user ports wait for a PHY that probes
late". That patch sets ds->phy_may_probe_late in mt7530_probe_common() and
copies it into dp->pl_config in dsa_user_phy_setup().

With that patch applied the MT7531 path does reach the deferral, so this
is only about the wording here. Could the message say that the fix takes
effect together with the next patch?

> and lan743x do one-time PHY setup at that point that a late attach
> would skip. Those connect from ndo_open, where the problem does not
> last: a PHY taken by genphy at one open is released at close, and the
> next open finds the real driver. A MAC that connects once at setup has
> no such second chance.

[Severity: Low]
Does the next open actually find the real driver? That seems to hold only
if the PHY driver module loads while the interface is down.

Suppose the module loads while genphy is bound, for example because IP
autoconfig or early userspace brought the interface up before the rootfs
module was loaded. Then driver_attach() for the real driver skips the
device:

drivers/base/dd.c:__driver_probe_device() {
    ...
	if (dev->driver)
		return -EBUSY;
    ...
}

At close, phy_detach_internal() only releases genphy:

	if (phydev->is_genphy_driven) {
		device_release_driver(&phydev->mdio.dev);
		phydev->is_genphy_driven = 0;
	}

After that nothing re-probes the device. On the next open,
phy_attach_direct() sees d->driver == NULL and binds genphy again.

Wouldn't those ndo_open MACs then get the same "no second chance" result?
Could the reason for leaving them out be reworded?

> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index a7d086cdc9b25..a663390fdc9fd 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c

[ ... ]

> @@ -2390,6 +2412,135 @@ int phylink_connect_phy(struct phylink *pl, struct phy_device *phy)

[ ... ]

> +/* Stale the moment it returns: the device lock this wants cannot be held
> + * across the attach, whose own failure path takes it again.
> + */
> +static bool phylink_phy_is_usable(struct phy_device *phy_dev)
> +{
> +	return phy_dev && device_is_bound(&phy_dev->mdio.dev) && phy_dev->drv;
> +}

[Severity: Medium]
The kernel-doc for device_is_bound() says "This function must be called
with the device lock held." The comment explains why the lock cannot be
held across the attach. Is there a reason it cannot be taken just around
this check and dropped before phylink_attach_phy()?

Without the lock, can the check pass for a PHY whose unbind has already
started? __device_release_driver() runs device_remove(), and so
phy_remove(), before it removes knode_driver:

drivers/net/phy/phy_device.c:phy_remove() {
    ...
	phydev->drv = NULL;

	return 0;
}

klist_remove(&dev->p->knode_driver) only runs after that, so
device_is_bound() can still return true while drv is being cleared.

The poller then calls phy_attach_direct() with d->driver still set, so
there is no genphy fallback. The commit message's handling ("the generic
one binds instead") does not cover this case. If phydev->drv becomes NULL
during the attach, could phy_attach_direct()
(phy_drv_supports_irq(phydev->drv)) or phylink_bringup_phy()
(phy->drv->name) dereference NULL?

The commit message notes that the wider attach/unbind race belongs to
phylib. The unlocked device_is_bound() call, though, is new in this patch.

[ ... ]

> +	ret = phylink_attach_phy(pl, phy_dev, pl->link_interface,
> +				 pl->late_phy_flags);
> +	if (!ret && phy_driver_is_genphy(phy_dev)) {
> +		/* Lost the race: the attach bound the generic driver, which
> +		 * is the outcome this poller exists to avoid.
> +		 */
> +		phy_detach(phy_dev);
> +		lost_race = true;
> +		ret = -EAGAIN;
> +	}

[Severity: Low]
Suppose the real driver unbinds between phylink_phy_is_usable() and the
attach, and the genphy attach that phy_attach_direct() then does fails.
What happens here?

The genphy probe/bind failure path clears is_genphy_driven:

error_module_put:
	module_put(d->driver->owner);
	phydev->is_genphy_driven = 0;
	d->driver = NULL;

The later error path through phy_detach_internal() clears it as well.
In both cases ret is non-zero, so lost_race stays false. The poller then
logs "failed to connect late PHY" and uses up one of
PHYLINK_LATE_PHY_RETRIES. If none are left, it prints "giving up" and
stops, even though the real driver was never tried.

Should a failed attach with no real driver bound be kept out of the retry
count?

[ ... ]

> +	} else if (ret) {
> +		phylink_err(pl, "failed to connect late PHY: %pe\n",
> +			    ERR_PTR(ret));
> +		/* Bounded: each retry re-runs the PHY's init, maybe its reset. */
> +		if (pl->late_phy_retries) {
> +			pl->late_phy_retries--;
> +			again = true;

[Severity: Medium]
Can this retry end up attaching a PHY that another net_device owns?

phylink_phy_is_usable() does not check phydev->attached_dev. The PHY may
already be attached elsewhere, for example when two ports have a DT
phy-handle pointing at the same PHY, or when the PHY was attached through
another path. Then phy_attach_direct() fails here:

	if (phydev->attached_dev) {
		dev_err(&dev->dev, "PHY already attached\n");
		err = -EBUSY;
		goto error;
	}

The error label runs phy_detach_internal() on the other owner's
attachment. That clears attached_dev, phylink and phy_link_change while
the other phylink still holds the PHY in pl->phydev. This tear-down is
existing phylib behaviour.

What is new is that the -EBUSY arrives here and is retried. On the next
poll attached_dev is NULL, so the attach and phylink_bringup_phy()
succeed, and two phylink instances hold the same phy_device. A disconnect
on either side would then detach the PHY from under the other.

Should -EBUSY, or a PHY with attached_dev set, be treated as final rather
than retried?

[ ... ]

> @@ -2440,6 +2605,25 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
>  	}
>  
>  	phy_dev = fwnode_phy_find_device(phy_fwnode);
> +	if (pl->config->phy_may_probe_late &&
> +	    pl->link_interface != PHY_INTERFACE_MODE_NA &&
> +	    fwnode_property_present(phy_fwnode, "needs-host-firmware") &&
> +	    !phylink_phy_is_usable(phy_dev)) {

[Severity: Medium]
Should this gate exclude MLO_AN_INBAND, or hold the link down while the
deferral is pending?

With the deferral armed and phylink started, phylink_resolve() takes the
in-band path with phy == NULL. The PHY link state is not combined in:

		if (phy)
			link_state.link &= pl->phy_state.link;

If the PCS reports link, phylink_link_up() calls mac_link_up() and turns
carrier on. The PHY is not attached, and once the retries run out it may
never be.

When the poller later attaches the PHY, phy_attach_direct() calls
netif_carrier_off(phydev->attached_dev) directly, not through
phylink_link_down(). The forced major config then reads this as false:

	cur_link_state = phylink_link_is_up(pl);

so it skips phylink_link_down()/mac_link_down(). Because
pl->phy_state.link is still 0, no down transition follows either. The next
PHY link-up would then call mac_link_up() a second time with no
mac_link_down() in between.

Does that break the mac_link_up()/mac_link_down() pairing that MAC drivers
expect?

[ ... ]

> @@ -2481,6 +2665,8 @@ void phylink_disconnect_phy(struct phylink *pl)
>  
>  	ASSERT_RTNL();
>  
> +	phylink_late_phy_cancel(pl);
> +

[Severity: Low]
Is the deferred connect lost if an SFP PHY comes and goes while it is
armed?

If phylink_sfp_connect_phy() attaches a module PHY while the deferral is
armed, phylink_late_phy_poll() stops for good:

	/* A PHY arrived by another path, an SFP for one, while queued. */
	if (!phylink_late_phy_pending(pl)) {
		rtnl_unlock();
		return;
	}

When the module is removed, phylink_sfp_disconnect_phy() calls
phylink_disconnect_phy(). That now calls phylink_late_phy_cancel() and
drops late_phy_fwnode, even though the phy-handle PHY was never attached.

Nothing re-arms the deferral, so the needs-host-firmware PHY is never
connected, even after its driver binds. For a MAC that connects once, the
port stays without that PHY until the MAC is reprobed.

Reaching this needs a MAC with both an sfp property and a phy-handle to a
needs-host-firmware PHY. That may be unusual, but the comment in the
poller suggests this path is expected.

[ ... ]

> diff --git a/include/linux/phylink.h b/include/linux/phylink.h
> index 3a88a69882a61..6249156b51f15 100644
> --- a/include/linux/phylink.h
> +++ b/include/linux/phylink.h
> @@ -147,6 +147,9 @@ enum phylink_op_type {

[ ... ]

> + * @phy_may_probe_late: if true, a connect to a PHY marked needs-host-firmware
> + *			whose driver has not bound yet is deferred until that
> + *			driver binds; see phylink_fwnode_phy_connect().

[Severity: Low]
This isn't a bug today, but should phy_may_probe_late be documented as
incompatible with mac_requires_rxc, or checked against it?

While the connect is deferred, PHY_F_RXC_ALWAYS_ON is not passed to any
PHY. A MAC that needs RX_CLK during its own init would go through that
init with no PHY keeping it running.

No current configuration reaches this. In-tree only stmmac sets
mac_requires_rxc, and it does not opt in (the commit message names it as
a MAC that must not). mt7530 does not set mac_requires_rxc.

Adding !pl->config->mac_requires_rxc to the gate in
phylink_fwnode_phy_connect(), or noting the conflict here, would cover
future users.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001130208.105558-1-f%40lex.la
