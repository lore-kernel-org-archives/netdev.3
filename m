Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4343B14A8;
	Sun, 18 Oct 2026 17:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343017; cv=none; b=sFQIWqtLpCyKkL6m9fT1E0h3tQBsvpG1cRdEUppiYStNThi/maP0mihBUMd88wMHZZmDh3uNAdc5USH9zwCG13taC1gcYQV1xi2tz//50dNUOxMOxjuDTCv/ipyEe6ayT48bJcKkCyf90tTqj6qMBWw+3wxCjYDZLemPEtRpO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343017; c=relaxed/simple;
	bh=PAoow988qEN7nVv+GzQQiPaBIE17aXnnXHNAyjPdmHM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=As9I3L8xjHW1D1oL3VjUENFnSZ8Bzp608tcXbz8398u33vAhGIAXyHg7WorFUNxCzLBrIzVAnbBPYkTcdV8fahRAMrnA+VMWUnQF1K0kVeOO43SsteUboAb0Ve56szpBru45GznbL5klkpDMaS5ezj1t4FDrsrrbCjxBUdX556c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPvk7n6W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPvk7n6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E0431F000C5;
	Sun, 18 Oct 2026 17:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792343015;
	bh=DfrBIPnRBhQ3dd61XmB+HBjRbQEOKrbL4f6gvW5AGmA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EPvk7n6W16xNd5TAv5Q+x5Sy/OJXVUgO5A6TacaL+QZ3WBNfxWij81ULzibrXkumV
	 DvBqysswZXitCuzl/CFlVQbf5SCGBi9tMzU6skB5b/doalOskDjsFn9Qf0/4y9AxoH
	 Oq3iZN1jkmpUqGEhlDvDrG3aSNNrwQfG/qk39XAcsJDcwQJgOpQBzZXF1HcryBu+Iu
	 GdiZX8aH3wrVsDSurDErI1FBCbRknyjWBNIGSPzf3+3KmJKmR2TWwF8OYtaPsPk3t7
	 DWiCAzFSoeOlSQ8+HzFzT4PP2BFNx+5q57wKpbalBkKVrjMuSTQpT2MCnRb+kEcDaq
	 jX7qvi6qLcdCQ==
Subject: Re: [PATCH net-next v2] net: phy: Add JLSemi JL21xx Gigabit Ethernet
 PHY driver
From: netdev-bot+sashiko@kernel.org
To: cyan2254650260@gmail.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 hkallweit1@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Sun, 18 Oct 2026 17:03:33 +0000
Message-ID: <179234301387.3135.10569573530407999894@kernel.org>
In-Reply-To: <20261017165316.146793-1-cyan2254650260@gmail.com>
References: <20261017165316.146793-1-cyan2254650260@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 12 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] WoL support is incomplete: the WoL engine is left in reset and
  is never released, and a WoL configuration left by firmware is never…
- [High] jlsemi_set_wol() leaks the MDIO bus mutex when page selection
  fails.
- [High] MAC-based Wake-on-LAN breaks: every jlsemi entry sets
  PHY_ALWAYS_CALL_SUSPEND, and jlsemi_suspend() checks only…
- [Medium] The new driver is presented as original work.
- [Medium] jlsemi_config_rgmii_delay() calls
  phy_get_internal_delay(phydev, NULL, 0, ...) with no delay table.
- [Medium] The generic PHY_ID_MATCH_VENDOR(PHY_ID_JLSEMI) entry uses
  jlsemi_probe() and jlsemi_suspend(), but it has no .get_wol/.set_wol.
- [Medium] jlsemi_led_hw_control_get() returns a set of netdev trigger
  rules that the netdev trigger itself rejects.
- [Medium] jlsemi_set_wol() reports success even when programming fails.
- [Medium] net: phy: jlsemi: jlsemi_config_init() unconditionally
  disables autonomous EEE
- [Low] On the interrupt-disable path of jlsemi_config_intr(), `err =
  phy_write_paged(..., JLSEMI_INER, 0)` is followed unconditionally by…
- [Low] jlsemi_handle_interrupt() reads INSR once and returns IRQ_HANDLED
  as soon as it sees JLSEMI_INER_LINK_STATUS, without testing…
- [Low] jlsemi_probe() calls device_set_wakeup_capable(dev, true) and
  then devm_pm_set_wake_irq(dev, phydev->irq) without checking the…

--

net: phy: Add JLSemi JL21xx Gigabit Ethernet PHY driver

This commit adds a new phylib driver for the JLSemi JL2101, JL2121 and
generic JL21xx Gigabit Ethernet PHYs. It implements paged register access,
RGMII delay configuration, vendor status reporting, interrupts, LED
hardware control, magic packet Wake-on-LAN and suspend/resume.

Link: https://www.jlsemi.com/

> diff --git a/drivers/net/phy/jlsemi.c b/drivers/net/phy/jlsemi.c
> new file mode 100644
> index 0000000000000..c83739ad182b4
> --- /dev/null
> +++ b/drivers/net/phy/jlsemi.c
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for JLSemi Gigabit Ethernet PHYs (JL2121 / JL2101)
> + *
> + * Copyright (C) 2026 Pufan Jin <cyan2254650260@gmail.com>
> + */

[Severity: Medium]
Most of this driver looks like a copy of the RTL8211F support in
drivers/net/phy/realtek/realtek_main.c, with the RTL8211F_ prefix renamed
to JLSEMI_.

The register map is the same: 0xa43/0x1a, 0xd08/0x11/0x15, PHYCR2 0x19
bit 5, 0xa42/0x12, 0xd04/0x10, 0xd8a/16-17 and 0xd8c/16-18.

jlsemi_led_hw_control_get() and jlsemi_led_hw_control_set() are identical
to rtl8211f_led_hw_control_get() and rtl8211f_led_hw_control_set(). The
WoL, config_intr, handle_interrupt and disable_autonomous_eee code follow
the same pattern.

Neither the commit message nor this header says that JL21xx is
register-compatible with RTL8211F, and neither credits the original code.

Would it be better to add these IDs to the Realtek driver instead? If a
separate driver is preferred, could the commit message explain why, and
credit the source?

As a separate copy, fixes to the RTL8211F code will not reach this driver.
Some of the comments below look like exactly that.

[ ... ]

> +static int jlsemi_probe(struct phy_device *phydev)
> +{

[ ... ]

> +	if (device_property_read_bool(dev, "wakeup-source") &&
> +	    phy_interrupt_is_valid(phydev)) {
> +		device_set_wakeup_capable(dev, true);
> +		devm_pm_set_wake_irq(dev, phydev->irq);
> +	}
> +	return 0;
> +}

[Severity: Low]
Should the return value of devm_pm_set_wake_irq() be checked here?

dev_pm_set_wake_irq() can fail, for example with -ENOMEM. The device has
already been marked wakeup capable at that point. jlsemi_get_wol() would
still advertise WAKE_MAGIC and jlsemi_set_wol() would still succeed.
jlsemi_suspend() would then keep the PHY powered with PME armed, but the
IRQ was never set up as a wake source.

> +static int jlsemi_config_rgmii_delay(struct phy_device *phydev)
> +{

[ ... ]

> +	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_TXID)
> +		rx_delay = phy_get_internal_delay(phydev, NULL, 0, true);
> +
> +	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_RXID)
> +		tx_delay = phy_get_internal_delay(phydev, NULL, 0, false);
> +

[ ... ]

> +	if (rx_delay >= 0)
> +		val_rxdly = rx_delay > 0 ? JLSEMI_RX_DELAY : 0;
> +	if (tx_delay >= 0)
> +		val_txdly = tx_delay > 0 ? JLSEMI_TX_DELAY : 0;

[Severity: Medium]
With a NULL table and size 0, phy_get_internal_delay() returns the raw
picosecond value from rx-internal-delay-ps or tx-internal-delay-ps. This
code reduces that value to a single on/off bit.

A DT value such as rx-internal-delay-ps = <500> would therefore select the
fixed hardware delay (around 2ns), with no warning and no -EINVAL. Is that
intended?

The handling also depends on phy-mode in an inconsistent way:

  phy-mode = "rgmii": either property can turn on a PHY delay.
  phy-mode = "rgmii-txid": rx-internal-delay-ps is never read.
  phy-mode = "rgmii-rxid": tx-internal-delay-ps is ignored.

The ethernet-phy.yaml binding defines these properties as picosecond
values for PHYs with configurable delays. The RTL8211F code takes the
delay only from phy-mode.

Could this do the same? Alternatively, it could reject any value other
than 0 and the delay the hardware supports.

[ ... ]

> +static int jlsemi_config_intr(struct phy_device *phydev)
> +{

[ ... ]

> +	} else {
> +		val = 0;
> +		err = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER, val);
> +		if (!err)
> +			priv->iner = val;
> +
> +		err = jlsemi_ack_interrupt(phydev);
> +	}

[Severity: Low]
On the disable path, jlsemi_ack_interrupt() overwrites the
phy_write_paged() error before anything checks it.

If the INER write fails but the INSR read succeeds, can this return 0
while the link status interrupt is still enabled in the PHY?

The enable branch returns early on error, and rtl8211f_config_intr()
returns when the INER write fails.

> +static irqreturn_t jlsemi_handle_interrupt(struct phy_device *phydev)
> +{

[ ... ]

> +	if (irq_status & JLSEMI_INER_LINK_STATUS) {
> +		phy_trigger_machine(phydev);
> +		return IRQ_HANDLED;
> +	}

[Severity: Low]
If INSR has both LINK_STATUS and PME set, this returns before the PME bit
is checked.

The ack-by-read in jlsemi_ack_interrupt() suggests INSR is cleared on
read. If so, is pm_wakeup_event() skipped for that wakeup?

The actual wake from suspend goes through the wake IRQ. The main effect is
on wakeup source accounting and on aborting a suspend that is in progress.
The upstream Realtek handler has the same structure.

[ ... ]

> +static int jlsemi_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{

[ ... ]

> +		oldpage = phy_select_page(phydev, JLSEMI_PHYSICAL_ADDR_PAGE);
> +		if (oldpage < 0)
> +			return oldpage;

[Severity: High]
Does this leak the MDIO bus mutex?

phy_select_page() takes bus->mdio_lock in phy_save_page() before it reads
or writes the page register, and either of those can fail:

drivers/net/phy/phy-core.c:phy_save_page() {
	phy_lock_mdio_bus(phydev);
	return __phy_read_page(phydev);
}

The kerneldoc for phy_select_page() says phy_restore_page() must always be
called afterwards, whether or not the call succeeded. Returning oldpage
directly skips the only unlock.

Every later MDIO access on the bus would then block forever. That includes
the PHY state machine, the threaded phy_interrupt() handler and other PHYs
on the same bus. The path is an MDIO error during:

  ethtool -s <dev> wol g|d
    -> phy_ethtool_set_wol()
      -> jlsemi_set_wol()

The disable branch below has the same early return. The Realtek code jumps
to phy_restore_page() on this error instead.

> +
> +		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD0,
> +			    mac_addr[1] << 8 | mac_addr[0]);

[ ... ]

> +		__phy_write(phydev, JLSEMI_WOL_SETTINGS_EVENTS,
> +			    JLSEMI_WOL_EVENT_MAGIC);
> +		__phy_write(phydev, JLSEMI_WOL_RST_RMSQ,
> +			    JLSEMI_WOL_RMSQ);

[Severity: High]
JLSEMI_WOL_RMSQ is 0x1fff, so this write also clears bit 15
(JLSEMI_WOL_RG_RSTB) and puts the WoL block into reset. The disable branch
clears the same bit on purpose.

Does anything set RG_RSTB back to 1?

jlsemi_suspend() only arms INER_PME and never touches reg 17. After
"ethtool -s <dev> wol g" the WoL engine seems to stay in reset through
suspend, so no PME would be raised.

The RTL8211F code was fixed for this in commit b826bf795564 ("net: phy:
realtek: fix RTL8211F wake-on-lan support"). After that commit, set_wol
asserts the WoL reset and rtl8211f_suspend() toggles RG_RSTB low and then
high. The commit notes that without this a PME interrupt may not be
raised, even when another packet is received.

The same commit also clears WOL_SETTINGS_EVENTS in rtl8211f_probe(),
because the WoL configuration survives reboots. jlsemi_probe() does not
clear page 0xd8a reg 16.

Could a WoL setup left by firmware or a previous kernel stay armed here?
jlsemi_get_wol() would then report it as WAKE_MAGIC, even though
device_set_wakeup_enable() was never called.

> +restore:
> +		phy_restore_page(phydev, oldpage, ret);
> +	} else {
> +		oldpage = phy_select_page(phydev, JLSEMI_WOL_PAGE);
> +		if (oldpage < 0)
> +			return oldpage;
> +
> +		__phy_write(phydev, JLSEMI_WOL_SETTINGS_EVENTS, 0);
> +		__phy_clear_bits(phydev, JLSEMI_WOL_RST_RMSQ,
> +				 JLSEMI_WOL_RG_RSTB);
> +
> +		phy_restore_page(phydev, oldpage, 0);
> +	}
> +
> +	device_set_wakeup_enable(&phydev->mdio.dev, !!(wol->wolopts & WAKE_MAGIC));
> +
> +	return 0;
> +}

[Severity: Medium]
The return value of phy_restore_page() is discarded. If the __phy_write()
of JLSEMI_PAGE_SELECT fails and jumps to restore, the code still calls
device_set_wakeup_enable(..., true) and returns 0.

None of the MAC address writes or the WOL_SETTINGS_EVENTS and RST_RMSQ
writes are checked either. The disable branch passes a hard-coded 0 to
phy_restore_page() and also ignores its result.

Can "ethtool -s <dev> wol g" or "wol d" then report success while the
hardware is only partly programmed? jlsemi_get_wol() reads the hardware,
but jlsemi_suspend() follows device_may_wakeup(), so the two could
disagree.

The return value of device_set_wakeup_enable() is also ignored. With
CONFIG_PM_SLEEP, device_wakeup_enable() can fail with -ENOMEM.

> +static int jlsemi_suspend(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	if (device_may_wakeup(&phydev->mdio.dev)) {

[Severity: Medium]
jlsemi_config_init() calls jlsemi_disable_autonomous_eee() on every
phy_init_hw(). All three driver entries also register the same
function as .disable_autonomous_eee.

As far as I can tell, phylib only intends that callback to run once the
MAC has said it handles LPI itself. phy_support_eee() sets
phydev->autonomous_eee_disabled and calls the hook. phy_init_hw() then
re-applies it after .config_init() whenever that flag is set.

Calling it from jlsemi_config_init() as well turns autonomous EEE off
for every MAC. That includes MACs that never call phy_support_eee() and
cannot generate LPI themselves. On those boards the PHY was the only
thing that could put the link into low power idle, so the EEE power
savings are lost. On MACs that do call phy_support_eee(), PHYCR2 is
simply modified twice on each phy_init_hw().

The commit message says this is done to prevent interoperability packet
drops. Is that a problem in the PHY that requires autonomous EEE to be
off with every MAC? If so, a comment saying so would help, and the
.disable_autonomous_eee hook would then add nothing. If not, could the
call in jlsemi_config_init() be dropped and the job left to phylib?

[ ... ]

> +	}
> +
> +	return genphy_suspend(phydev);
> +}

[Severity: High]
All three driver entries set PHY_ALWAYS_CALL_SUSPEND, which bypasses this
check in phy_suspend():

drivers/net/phy/phy_device.c:phy_suspend() {
	...
	phydev->wol_enabled = phy_may_wakeup(phydev) ||
			      (netdev && netdev->ethtool->wol_enabled);
	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;
	...
}

Suppose the MAC handles WoL, because the PHY has no wakeup-source or PHY
wakeup is not enabled. device_may_wakeup() is then false, and
genphy_suspend() sets BMCR_PDOWN.

Doesn't that take the link down, so the MAC can never receive the magic
packet?

Before this patch these PHYs bound to genphy. In this case phy_suspend()
returned -EBUSY and left the PHY powered. That makes this a regression for
boards that use MAC WoL, for example stmmac PMT.

rtl821x_suspend() checks phydev->wol_enabled before it calls
genphy_suspend().

[ ... ]

> +static int jlsemi_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				     unsigned long *rules)
> +{

[ ... ]

> +	if ((val & JLSEMI_LEDCR_LINK_10) &&
> +	    (val & JLSEMI_LEDCR_LINK_100) &&
> +	    (val & JLSEMI_LEDCR_LINK_1000)) {
> +		__set_bit(TRIGGER_NETDEV_LINK, rules);
> +	}

[Severity: Medium]
jlsemi_led_hw_control_set() sets all three speed bits in LEDCR for a
TRIGGER_NETDEV_LINK request. When all three bits are set, this function
reports LINK_10, LINK_100 and LINK_1000 together with
TRIGGER_NETDEV_LINK.

netdev_trig_activate() copies this bitmap straight into
trigger_data->mode. However, netdev_led_attr_store() rejects LINK combined
with any of the speed-specific link rules:

drivers/leds/trigger/ledtrig-netdev.c:netdev_led_attr_store() {
	...
	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) || ...
		return -EINVAL;
	...
}

Would later sysfs writes that keep link set then fail with -EINVAL until
link is cleared first? Examples are toggling rx or tx, or one of the
link_N attributes.

Should this report either LINK or the individual speeds, but not both?

[ ... ]

> +	{
> +		PHY_ID_MATCH_VENDOR(PHY_ID_JLSEMI),
> +		.name			= "JLSemi Generic Gigabit Ethernet",
> +		.flags			= PHY_ALWAYS_CALL_SUSPEND,
> +		.probe			= jlsemi_probe,

[ ... ]

> +		.handle_interrupt	= jlsemi_handle_interrupt,
> +		.suspend		= jlsemi_suspend,
> +		.resume			= jlsemi_resume,

[Severity: Medium]
The generic entry uses jlsemi_probe() and jlsemi_suspend(), but it has no
.get_wol or .set_wol.

With wakeup-source in DT and a valid IRQ, jlsemi_probe() still marks the
device wakeup capable and registers the wake IRQ. phy_can_wakeup() then
returns true and phylink_phy_supports_wol() treats the PHY as WoL capable,
but no wake event can ever be programmed.

If power/wakeup is then enabled through sysfs, jlsemi_suspend() skips
genphy_suspend() and switches INER to PME only, which masks the link
interrupt. Nothing has been set up that could wake the system.

Should the wakeup setup in probe be limited to the entries that implement
WoL?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017165316.146793-1-cyan2254650260%40gmail.com
