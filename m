Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2090417BCA;
	Mon, 14 Sep 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789346425; cv=none; b=d2YPM2Mt9oc3/TECPrqyI8vPq8DtdS3/87rp7ff9DGUDmPCtea0XkAx6a9b/xvWW3Luci7EeX3kXYYYML/sjP8z+1+Xnvf2unjs5sTDRa3Abw1E4IEfXIlgV39wqw4UAoQwLGdxDwAdvs/gq5oXMXmFBtVQMr4uMQC+f7tIt5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789346425; c=relaxed/simple;
	bh=fZnbyD8rRFuFpPYCkE6Hd9ubmFfpcn/WdAUWZG6iaSQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwQyw7H522wE2SY8Hweg/X4PO5v4z/gMsQVz4uUqZwUlh0a0fcEpzfLehi9wCJgCC24krF2omRBTsvYknC9XBpFSQIqpdicIFJqKSSVfxuLa2Yf9O1QPy9IcOlwMI0npm5wtso5OTHE534bd/W0AiYBVPe7aGL3epNR5FLiHK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CuHOjlvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CuHOjlvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1745A1F000FF;
	Mon, 14 Sep 2026 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789346423;
	bh=2zx8is5ict6RE822fBqKtkYDIcyzD32uO+8Bz42gMDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CuHOjlvH7z2rOKy/EF0/Nm2CkpiudpF0C7xAitkRDexb5UcdH+jaSypGUfFIfyWdC
	 EZBfw9hiKhDFZm9zCT19pVrhrGQGRVnYhtGkHLtLhTATDc2Mye+RcfSiJfTbRnyo2o
	 eE1DC+8ucaAjZzVKmrw4pkpcmF5huhahNswYcDmElCAwOIEyJbS8RBn62pIOoM4FSN
	 GAeaJyAEod6rPSB7zmpfaJdmKfwg2xBQWKtbaYEJRnVkWD21d86CgSP8mhXOAm8sjq
	 eGCpJ+gMhnBD/6F6PL8TjVSdPfdx4lHnLZ7nikkZqJzldtmB/ypAkibua7f4VtlBhI
	 GgD6heaY/dYxw==
Subject: Re: [PATCH net-next] net: phy: marvell: wake the system only from the
 WoL event
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 14 Sep 2026 00:40:22 +0000
Message-ID: <178934642262.22033.16222092605762772756@kernel.org>
In-Reply-To: <20260912235125.151370-1-rosenp@gmail.com>
References: <20260912235125.151370-1-rosenp@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 3 · Medium: 5 · Low: 0

- [High] The interrupt-masking mechanism the commit relies on is bypassed
  on the standard phylib PM route.
- [High] `marvell_wol_suspend_intrs()` overwrites the whole Copper
  Specific Interrupt Enable register with `__phy_write(phydev,…
- [High] Both new helpers, `marvell_wol_suspend_intrs()` and
  `marvell_wol_resume_intrs()`, return early when `phy_save_page()`…
- [Medium] Commit message does not match the code, and an undisclosed
  firmware/DT dependency gates the whole feature.
- [Medium] `marvell_wol_suspend_intrs()` rewrites the interrupt enable
  register (CSIER/IMASK, page 0 reg 0x12) but never reads…
- [Medium] `marvell_probe()` is the `.probe` of ~25 entries in
  `marvell_drivers[]`, but only the 88E1318S and 88E1510 entries gained…
- [Medium] The new suspend callbacks branch on `phydev->wol_enabled`, but
  the core defines that field as "the PHY *or the attached MAC* have…
- [Medium] The new wakeup-state check-then-update in `m88e1318_set_wol()`
  races with the MDIO device's `power/wakeup` sysfs control and, on a…

--

net: phy: marvell: wake the system only from the WoL event

This adds system wakeup support for WoL on the 88E1318S/88E1510 by
registering the PHY interrupt as a wake IRQ, marking the MDIO device as
wakeup capable, and adding suspend/resume callbacks that narrow the copper
specific interrupt enable register down to the WoL event bit.  A few
questions below about the interrupt enable handling, the MDIO bus lock, and
the commit message.

No Link: tags are present in the commit header.

The commit message says:

> When WoL is enabled, m88e1318_set_wol() now calls enable_irq_wake()
> on the PHY's IRQ and marks the MDIO device as a wakeup source so the
> underlying GPIO interrupt raises the system from suspend, and reverses
> both on disable.

[Severity: Medium]
Does m88e1318_set_wol() do either of those things?  In the patch it only
calls device_set_wakeup_enable(), and only when device_can_wakeup(dev) is
already true.  The wake IRQ is registered in marvell_probe() via
devm_pm_set_wake_irq(), gated on the firmware property "wakeup-source",
and device_set_wakeup_capable() is called there too.

Without "wakeup-source" in the PHY's DT node, device_can_wakeup() is false
and the new block in m88e1318_set_wol() is skipped entirely, so on existing
device trees nothing is armed.  Could the message mention the required DT
change?  The property is also not described in
Documentation/devicetree/bindings/net/ethernet-phy.yaml.

The message scopes the change to "the 88E1318S/88E1510", but marvell_probe()
is the .probe of every entry in marvell_drivers[].

> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index f71cffa884062..70aaa09f20478 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c

[ ... ]

> @@ -1902,6 +1904,61 @@ static int marvell_resume(struct phy_device *phydev)
>  	return err;
>  }
>  
> +/* marvell_wol_suspend_intrs
> + *
> + * With WoL enabled the PHY has to stay powered to keep detecting a WoL
> + * packet, so instead of entering low power mode, mask all interrupt
> + * sources except the WoL event. On the 88E1318S/88E1510 the interrupt
> + * mask (MII_M1011_IMASK) is the same register as the Copper Specific
> + * Interrupt Enable Register (MII_88E1318S_PHY_CSIER), so writing only
> + * the WoL event enable bit unmask just that event.
> + */
> +static int marvell_wol_suspend_intrs(struct phy_device *phydev)
> +{
> +	int oldpage, ret;
> +
> +	oldpage = phy_save_page(phydev);
> +	if (oldpage < 0)
> +		return oldpage;

[Severity: High]
Can this return leak the MDIO bus lock?  phy_save_page() takes the lock
before it reads the page register:

drivers/net/phy/phy-core.c:phy_save_page() {
	phy_lock_mdio_bus(phydev);
	return __phy_read_page(phydev);
}

Its kernel-doc states that phy_restore_page() must always be called after
this, irrespective of success or failure, and phy_restore_page() is the only
caller of phy_unlock_mdio_bus() (it already handles a negative oldpage).

__phy_read_page() can return -EOPNOTSUPP or propagate an MDIO transfer
error, which is not unlikely in the suspend/resume window.  If that happens
here, the same task then continues to issue MDIO accesses
(m88e1510_resume() -> marvell_resume(), downshift handling, the state
machine), so would it block forever on a mutex it cannot reacquire, taking
the rest of the bus with it?

The existing code in this file uses the documented idiom:

	oldpage = phy_save_page(phydev);
	if (oldpage < 0)
		goto error;

The same question applies to the identical early return in
marvell_wol_resume_intrs() below.

> +
> +	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_write(phydev, MII_88E1318S_PHY_CSIER,
> +			  MII_88E1318S_PHY_CSIER_WOL_EIE);

[Severity: High]
This is a full-register write to CSIER, which is the same register as
MII_M1011_IMASK, so it discards the MII_M1011_IMASK_INIT (0x6400, link
status change and aneg complete) enables programmed by
marvell_config_intr(), without saving them.  Is anything restoring them?

marvell_wol_resume_intrs() only ORs WOL_EIE back in.  drv->config_intr is
reached from phy_init_hw() and phy_config_interrupt() (attach/detach), not
from phy_start() -> __phy_resume(), and mdio_bus_phy_resume() returns early
when phydev->mac_managed_pm is set.

So after an ifdown/ifup cycle with WoL enabled, which now reaches the
suspend callback thanks to PHY_ALWAYS_CALL_SUSPEND:

	phy_stop()
	  _phy_state_machine()			/* PHY_STATE_WORK_SUSPEND */
	    _phy_state_machine_post_work()
	      phy_suspend()
	        m88e1510_suspend()
	          marvell_wol_suspend_intrs()	/* CSIER = WOL_EIE */

does the PHY come back with only WOL_EIE enabled while phydev->interrupts
still reads PHY_INTERRUPT_ENABLED and phy_polling_mode() is false?  In that
state marvell_handle_interrupt() bails out early:

	if (!(irq_status & MII_M1011_IMASK_INIT))
		return IRQ_NONE;

and INTn is not asserted for link events at all, so would link up/down go
undetected and the interface never regain carrier?  rtl8211f_suspend()
saves the enable register in priv->iner and restores it in rtl8211f_resume().

[Severity: Medium]
Should this sequence also read MII_M1011_IEVENT to clear already-latched
events before going to sleep?  marvell_config_intr() acks via
marvell_ack_interrupt() before every mask change, and the comment in
m88e1318_set_wol() says the LED[2] interrupt pin "will not be cleared unless
we reading the interrupt status register".

If a link status change latched while the interface was being taken down,
can INTn already be asserted low when the GPIO wake IRQ is armed, so the
suspend aborts or the system wakes immediately?  rtl8211f_suspend() does:

	/* Read the INSR to clear any pending interrupt */
	phy_read(phydev, RTL8211F_INSR);

> +out:
> +	return phy_restore_page(phydev, oldpage, ret);
> +}
> +
> +/* marvell_wol_resume_intrs
> + *
> + * marvell_config_intr() rewrites the whole MII_M1011_IMASK register
> + * (which is MII_88E1318S_PHY_CSIER) with MII_M1011_IMASK_INIT on
> + * resume, clearing the WoL event interrupt enable bit. Re-arm it if
> + * WoL is still enabled so a later WoL event keeps waking the system.
> + */
> +static int marvell_wol_resume_intrs(struct phy_device *phydev)
> +{
> +	int oldpage, ret;
> +
> +	if (!phydev->wol_enabled)
> +		return 0;
> +
> +	oldpage = phy_save_page(phydev);
> +	if (oldpage < 0)
> +		return oldpage;
> +
> +	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
> +			     MII_88E1318S_PHY_CSIER_WOL_EIE);
> +out:
> +	return phy_restore_page(phydev, oldpage, ret);
> +}
> +
>  /* m88e1510_resume
>   *
>   * The 88e1510 PHY has an erratum where the phy downshift counter is not cleared

[ ... ]

> @@ -1934,9 +1991,25 @@ static int m88e1510_resume(struct phy_device *phydev)
>  
>  		/* downshift enabled, with previous counter value */
>  		err = m88e1011_set_downshift(phydev, cnt);
> +		if (err < 0)
> +			return err;
>  	}
>  
> -	return err;
> +	return marvell_wol_resume_intrs(phydev);
> +}
> +
> +/* m88e1510_suspend
> + *
> + * If WoL is enabled the PHY receiver has to keep running to detect a
> + * magic packet, so keep it awake and unmask only the WoL event at the
> + * PHY. Otherwise suspend both the fiber and copper interfaces as usual.
> + */
> +static int m88e1510_suspend(struct phy_device *phydev)
> +{
> +	if (phydev->wol_enabled)
> +		return marvell_wol_suspend_intrs(phydev);

[Severity: Medium]
Is phydev->wol_enabled the right condition for "PHY WoL is configured"?
include/linux/phy.h documents it as "Set to true if the PHY or the attached
MAC have Wake-on-LAN enabled", and phy_suspend() assigns:

	phydev->wol_enabled = phy_may_wakeup(phydev) ||
			      (netdev && netdev->ethtool->wol_enabled);

With a MAC-only WoL configuration, does this branch write CSIER = WOL_EIE
even though m88e1318_set_wol() was never called, i.e. no magic packet
address and no LED[2]/INTn setup, masking the real PHY events and unmasking
a WoL source that is not armed?  rtl8211f_suspend() uses
device_may_wakeup(&phydev->mdio.dev) for this decision instead.

The same question applies to m88e1318_suspend() below.

> +
> +	return marvell_suspend(phydev);
>  }
>  
>  static int marvell_aneg_done(struct phy_device *phydev)

[ ... ]

> @@ -2075,7 +2152,49 @@ static int m88e1318_set_wol(struct phy_device *phydev,
>  	}
>  
>  error:
> -	return phy_restore_page(phydev, oldpage, err);
> +	err = phy_restore_page(phydev, oldpage, err);
> +	if (err < 0)
> +		return err;
> +
> +	if (device_can_wakeup(dev) && wol_enable != device_may_wakeup(dev)) {
> +		err = device_set_wakeup_enable(dev, wol_enable);
> +		if (err < 0) {
> +			/* Roll back the PHY WoL config if the PM state update failed */
> +			struct ethtool_wolinfo wol_off = { .wolopts = 0 };
> +			int rollback_err = m88e1318_set_wol(phydev, &wol_off);
> +
> +			if (rollback_err < 0)
> +				phydev_err(phydev,
> +					   "Failed to disable WoL after wakeup enable error %d\n",
> +					   rollback_err);
> +		}
> +	}

[Severity: Medium]
Can this check-then-update race with the MDIO device's power/wakeup sysfs
control?  phy_ethtool_set_wol() holds phydev->lock, but
drivers/base/power/sysfs.c:wakeup_store() calls device_set_wakeup_enable()
on the same device without that mutex.

The read of device_may_wakeup(dev) and the later
device_set_wakeup_enable(dev, true) are not one transaction, so if the sysfs
path enables wakeup in between, device_wakeup_enable() ->
device_wakeup_attach() returns -EEXIST.

Does the error handler then treat that as a real failure and recursively
call m88e1318_set_wol(phydev, &wol_off), tearing down the magic packet
matching and WOL_EIE that were just programmed?

> +
> +	return err;
> +}
> +
> +/* m88e1318_suspend
> + *
> + * If WoL is enabled keep the PHY awake so it can detect a magic packet
> + * while the system is asleep, unmasking only the WoL event at the PHY.
> + * Otherwise suspend the PHY normally.
> + */
> +static int m88e1318_suspend(struct phy_device *phydev)
> +{
> +	if (phydev->wol_enabled)
> +		return marvell_wol_suspend_intrs(phydev);
> +
> +	return genphy_suspend(phydev);
> +}
> +
> +static int m88e1318_resume(struct phy_device *phydev)
> +{
> +	int err = genphy_resume(phydev);
> +
> +	if (err < 0)
> +		return err;
> +
> +	return marvell_wol_resume_intrs(phydev);
>  }
>  
>  static int marvell_get_sset_count(struct phy_device *phydev)

[ ... ]

> @@ -3587,14 +3706,25 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
>  
>  static int marvell_probe(struct phy_device *phydev)
>  {
> +	struct device *dev = &phydev->mdio.dev;
>  	struct marvell_priv *priv;
>  
> -	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
>  	phydev->priv = priv;
>  
> +	if (device_property_present(dev, "wakeup-source") &&
> +	    phy_interrupt_is_valid(phydev)) {
> +		int ret = devm_pm_set_wake_irq(dev, phydev->irq);
> +
> +		if (ret)
> +			return ret;
> +
> +		device_set_wakeup_capable(dev, true);
> +	}

[Severity: Medium]
marvell_probe() is the .probe of every entry in marvell_drivers[], but only
the 88E1318S and 88E1510 entries get .set_wol, PHY_ALWAYS_CALL_SUSPEND and
the masking suspend callbacks.

For the other entries (88E1111, 88E1118, 88E1121R, 88E1116R, 88E1540,
88E1545, 88E3016, ...), a DT "wakeup-source" property now registers
phydev->irq as a dedicated wake IRQ and adds the power/wakeup sysfs
attributes via device_set_wakeup_capable() -> pm_wakeup_sysfs_add().

If root then writes "enabled" there, dev_pm_arm_wake_irq() arms INTn while
those drivers' genphy_suspend()/marvell_suspend() leave the enable register
at MII_M1011_IMASK_INIT:

	#define MII_M1011_IMASK_INIT		0x6400

Would any link event during sleep wake the system on those models, and does
phy_may_wakeup() also change for them from the register-derived state to
device_may_wakeup()?  Should this block be restricted to the models that
received the masking callbacks?

> +
>  	return marvell_hwmon_probe(phydev);
>  }
>  

[ ... ]

> @@ -3813,6 +3943,7 @@ static struct phy_driver marvell_drivers[] = {
>  		.phy_id_mask = MARVELL_PHY_ID_MASK,
>  		.name = "Marvell 88E1318S",
>  		/* PHY_GBIT_FEATURES */
> +		.flags = PHY_ALWAYS_CALL_SUSPEND,

[Severity: High]
PHY_ALWAYS_CALL_SUSPEND only affects the -EBUSY check inside phy_suspend().
On the mdio-bus PM route, is phy_suspend() reached at all when WoL is
enabled?

drivers/net/phy/phy_device.c:mdio_bus_phy_may_suspend() {
	...
	if (netdev->ethtool->wol_enabled)
		return false;
	...
}

mdio_bus_phy_suspend() calls phy_suspend() only when that helper returns
true, and both ethtool_set_wol() and ethnl_set_wol() do:

	dev->ethtool->wol_enabled = !!wol.wolopts;

after any successful ->set_wol, including PHY WoL configured with
ethtool -s ethX wol g, where the MAC delegates to phy_ethtool_set_wol() ->
m88e1318_set_wol().

So for the exact configuration this patch targets, do m88e1318_suspend() and
m88e1510_suspend() ever run from system suspend?  Meanwhile the wake side
still takes effect, since m88e1318_set_wol() sets device_set_wakeup_enable()
on the MDIO device and dpm_suspend_noirq() arms the wake IRQ registered by
devm_pm_set_wake_irq().  Does that leave an armed wake source on a PHY whose
link status change and aneg complete interrupts are still enabled?

The same applies to the 88E1510 entry below.

>  		.probe = marvell_probe,
>  		.config_init = m88e1318_config_init,
>  		.config_aneg = m88e1318_config_aneg,
> @@ -3821,8 +3952,8 @@ static struct phy_driver marvell_drivers[] = {
>  		.handle_interrupt = marvell_handle_interrupt,
>  		.get_wol = m88e1318_get_wol,
>  		.set_wol = m88e1318_set_wol,
> -		.resume = genphy_resume,
> -		.suspend = genphy_suspend,
> +		.resume = m88e1318_resume,
> +		.suspend = m88e1318_suspend,
>  		.read_page = marvell_read_page,
>  		.write_page = marvell_write_page,
>  		.get_sset_count = marvell_get_sset_count,
> @@ -3920,7 +4051,7 @@ static struct phy_driver marvell_drivers[] = {
>  		.name = "Marvell 88E1510",
>  		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
>  		.features = PHY_GBIT_FIBRE_FEATURES,
> -		.flags = PHY_POLL_CABLE_TEST,
> +		.flags = PHY_POLL_CABLE_TEST | PHY_ALWAYS_CALL_SUSPEND,

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912235125.151370-1-rosenp%40gmail.com
