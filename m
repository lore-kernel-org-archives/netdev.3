Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516555;
	b=oZe/xtfVkhYW1SfMqIBVAatsc3eXfWzq2EM6ibCkFNFmTyqZetMve7i4okJy6EHG+2cK
	 F6v/YlI0q4fGJqH6d0spTr7WfSBqFa5RBfS5SHffZbvRn83ZaKaE8i4ZSpGPcZAczwe4d
	 VizkBvU2pwzSSJKYCNCr0IiAhaEA3hvw+UrlPxdJhFxyf9B0cfotWAKTNQL9+fHLKZB3Y
	 cYHPgeRhgzq+e9pWJYW3C8zho5aSxLwTBRZS2s/K3HahrxWlRqmkltzlMAcsoowK6+IBk
	 CZxKlJteNJf0axcwvJcCg01QKzA2EF5vNIIi/G7aDZ5/3acINGSAXbuKUaL/COmKj4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516555;
	h=Received:Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 X-sashiko-severity:Content-Type:Content-Transfer-Encoding:
	 MIME-Version;
	bh=2C9aGTBmEw3wkVMau9GTRh6vveuhsKXE+x7UwSIHdcM=;
	b=nhJn3fiVxMNi02mttUIy67Gs9/LrWC5Ag319xeTbsN92S/sfYgFkBJMla+xakaqXIXcs
	 quXj2jFSRkDU51eQMdSVqb/xyrHUqowItqer1mx/VKarGsrmtIXzONLWpzRg139G9beQv
	 jdcxTEh38YSSkZzUTa4yM4Jl5VI7cvZNLFlVWL9fk9Em2qAtSN9l7GYs6DkU7MsXOFXfm
	 B2fh+Mj69hiHPFZ/B3CQ6McTSBGJ+DOZnpDr7q9M+JrAw/1+1K1jlxn6i/2sGo1QWQnoc
	 G4nAnnXS5MQHcaduliu5KYtFokAyzWIuXNDs1Pnv0Ry1b3eNiVLn57WUoVE5pZUnqJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3CA606A335;
	Tue, 20 Oct 2026 17:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522AF1F000CD;
	Tue, 20 Oct 2026 17:15:54 +0000 (UTC)
Subject:
 Re: [PATCH net-next] net: phy: Add JLSemi JL21xx Gigabit Ethernet PHY driver
From: netdev-bot+sashiko@kernel.org
To: cyan2254650260@gmail.com
Cc: andrew@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 hkallweit1@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Tue, 20 Oct 2026 17:15:23 +0000
Message-ID: <179251652395.3135.9790628596697229408@kernel.org>
In-Reply-To: <20261016161543.444356-1-cyan2254650260@gmail.com>
References: <20261016161543.444356-1-cyan2254650260@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 10 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 6 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] jlsemi_set_wol() can leave the MDIO bus mutex held permanently.
- [Medium] Wake-on-LAN cannot work, yet the driver tells userspace it is
  enabled.
- [Medium] When WoL is enabled, jlsemi_set_wol() writes JLSEMI_WOL_RMSQ
  (0x1fff) to page 0xd8a reg 17.
- [Medium] jlsemi_config_init() always calls
  jlsemi_disable_autonomous_eee() (clears PHYCR2 bit 5) on every…
- [Medium] When the LED's three link-speed bits are all set,
  jlsemi_led_hw_control_get() returns TRIGGER_NETDEV_LINK_10, LINK_100…
- [Medium] jlsemi_set_wol() ignores every hardware-programming error and
  always returns 0.
- [Medium] In the interrupt-disable branch of jlsemi_config_intr(), `err
  = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER, 0)` is never…
- [Low] The register map and most of the logic in
  drivers/net/phy/jlsemi.c are a near-verbatim copy of the RTL8211F…
- [Low] jlsemi_config_rgmii_delay() handles rx-/tx-internal-delay-ps
  inconsistently.
- [Low] jlsemi_handle_interrupt() reads INSR (0x1d) once.

--

net: phy: Add JLSemi JL21xx Gigabit Ethernet PHY driver

This commit adds a new phylib driver for the JLSemi JL2101, JL2121 and
generic JL21xx Gigabit PHYs. It covers paged register access, RGMII delay
configuration, vendor status register parsing, interrupts, hardware LED
control, magic packet Wake-on-LAN, autonomous EEE disable and
suspend/resume.

Link: https://www.jlsemi.com/

> diff --git a/drivers/net/phy/jlsemi.c b/drivers/net/phy/jlsemi.c
> new file mode 100644
> index 0000000000000..c3acff48d4618
> --- /dev/null
> +++ b/drivers/net/phy/jlsemi.c
> @@ -0,0 +1,551 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for JLSemi Gigabit Ethernet PHYs (JL2121 / JL2101)
> + *
> + * Copyright (C) 2026 Pufan Jin <cyan2254650260@gmail.com>
> + */

[ ... ]

> +/* Wake-on-LAN settings */
> +#define JLSEMI_WOL_PAGE			0xd8a
> +#define JLSEMI_WOL_SETTINGS_EVENTS	16
> +#define JLSEMI_WOL_EVENT_MAGIC		BIT(12)
> +#define JLSEMI_WOL_RST_RMSQ		17
> +#define JLSEMI_WOL_RG_RSTB		BIT(15)
> +#define JLSEMI_WOL_RMSQ			0x1fff

[Severity: Low]
This isn't a bug, but the register map looks identical to the RTL8211F
support in drivers/net/phy/realtek/realtek_main.c. That covers PHYCR2 0x19
bit 5, INSR 0x1d, INER page 0xa42 reg 0x12, RGMII page 0xd08 regs
0x11/0x15, WoL page 0xd8a regs 16/17 with RG_RSTB BIT(15) and RMSQ 0x1fff,
MAC page 0xd8c, and LEDCR page 0xd04 reg 0x10 with 5-bit per-LED fields.

jlsemi_led_hw_is_supported() and jlsemi_led_hw_control_get() also follow
rtl8211x_led_hw_is_supported() and rtl8211f_led_hw_control_get() closely.
The same goes for the set_wol, suspend and resume flows.

Neither the commit message nor the file header mentions this origin. The
header lists a single copyright holder, while realtek_main.c has others.

Some later fixes in the realtek code also didn't come across:

  - wakeup-source and wake IRQ setup in probe
  - disabling PME events at probe
  - the RG_RSTB pulse in suspend
  - device_can_wakeup() gating in get_wol/set_wol
  - the msleep(20) after resume

If these parts are register compatible with RTL8211F, could the IDs go into
the realtek driver, or could the code be shared, instead of keeping a copy?

[ ... ]

> +static int jlsemi_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct jlsemi_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
> +	return 0;
> +}

[Severity: Medium]
Can Wake-on-LAN work with this driver? Nothing here marks the mdio device
as wakeup capable. There is no device_set_wakeup_capable() or
device_init_wakeup(), no wakeup-source handling and no
devm_pm_set_wake_irq(). Compare rtl8211f_probe():

drivers/net/phy/realtek/realtek_main.c:rtl8211f_probe() {
    ...
	if (device_property_read_bool(dev, "wakeup-source") &&
	    phy_interrupt_is_valid(phydev)) {
		device_set_wakeup_capable(dev, true);
		devm_pm_set_wake_irq(dev, phydev->irq);
	}
    ...
}

Because dev->power.can_wakeup stays false, device_may_wakeup() is always
false. device_set_wakeup_enable() in jlsemi_set_wol() returns -EINVAL. That
error is ignored and set_wol returns 0, and jlsemi_get_wol() still reports
WAKE_MAGIC as supported and enabled.

On suspend, phy_may_wakeup() falls back to the driver's WoL state, so
phydev->wol_enabled becomes true. PHY_ALWAYS_CALL_SUSPEND then skips the
core's -EBUSY guard:

drivers/net/phy/phy_device.c:phy_suspend() {
    ...
	phydev->wol_enabled = phy_may_wakeup(phydev) ||
			      (netdev && netdev->ethtool->wol_enabled);
	/* If the device has WOL enabled, we cannot suspend the PHY */
	if (phydev->wol_enabled && !(phydrv->flags & PHY_ALWAYS_CALL_SUSPEND))
		return -EBUSY;
    ...
}

jlsemi_suspend() checks only device_may_wakeup(). It skips the INER=PME
setup and calls genphy_suspend(), which sets BMCR_PDOWN.

Doesn't this power down the PHY while magic packet matching is armed? And
since phydev->wol_enabled is never checked, doesn't this also take the
copper link down when the MAC provides WoL?

For comparison, rtl821x_suspend() checks !phydev->wol_enabled before
calling genphy_suspend(). rtl8211f_get_wol() reports no support and
rtl8211f_set_wol() returns -EOPNOTSUPP when !device_can_wakeup().

> +
> +static int jlsemi_config_rgmii_delay(struct phy_device *phydev)
> +{

[ ... ]

> +	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_TXID)
> +		rx_delay = phy_get_internal_delay(phydev, NULL, 0, true);
> +
> +	if (phydev->interface != PHY_INTERFACE_MODE_RGMII_RXID)
> +		tx_delay = phy_get_internal_delay(phydev, NULL, 0, false);

[ ... ]

> +	if (rx_delay >= 0)
> +		val_rxdly = rx_delay > 0 ? JLSEMI_RX_DELAY : 0;
> +	if (tx_delay >= 0)
> +		val_txdly = tx_delay > 0 ? JLSEMI_TX_DELAY : 0;

[Severity: Low]
With a NULL table and size 0, phy_get_internal_delay() returns the raw
picosecond value whenever rx-internal-delay-ps or tx-internal-delay-ps is
present. Any positive value is then mapped to the single fixed delay bit.

So a DT value like <100> or <500> silently enables the full fixed delay,
and unsupported values are never rejected. Would passing a delay table let
phy_get_internal_delay() validate the value or pick the nearest supported
one?

Also, the RX property is never read for rgmii-txid, and the TX property is
never read for rgmii-rxid. ethernet-phy.yaml says "If this property is
present then the PHY applies the RX delay". Is it intended that the
property is ignored in those modes?

[ ... ]

> +static int jlsemi_config_init(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = jlsemi_disable_autonomous_eee(phydev);
> +	if (ret < 0)
> +		return ret;

[Severity: Medium]
Should this be called unconditionally from config_init? The same function
is also registered as .disable_autonomous_eee. phylib calls that op only
from phy_support_eee(), when the MAC says it handles LPI, and then sets
phydev->autonomous_eee_disabled. phy_init_hw() reapplies the disable only
when that flag is set.

Calling it here turns off autonomous EEE on every phy_init_hw(). That
includes MACs that never call phy_support_eee().

phy_probe() leaves EEE advertised by default. Couldn't such a MAC
negotiate EEE and then get LPI signalling it doesn't handle, or at least
lose the power savings of autonomous mode?

For comparison, rtl8211f_disable_autonomous_eee() is wired only through
the ops table and isn't called from config_init.

The commit message says:

  - Autonomous EEE disable to prevent interoperability packet drops

Is there more detail on which packet drops this refers to?

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

[Severity: Medium]
Is the result of the INER write lost here? If phy_write_paged() fails and
the INSR read succeeds, err is overwritten with 0 and jlsemi_config_intr()
reports success.

phy_disable_interrupts() and phy_init_hw() would then assume the interrupt
sources are masked, while INER may still have LINK_STATUS enabled. Could
the PHY keep asserting its IRQ line after phylib has stopped handling it?

[ ... ]

> +static irqreturn_t jlsemi_handle_interrupt(struct phy_device *phydev)
> +{
> +	int irq_status;
> +
> +	irq_status = phy_read(phydev, JLSEMI_INSR);
> +	if (irq_status < 0) {
> +		phy_error(phydev);
> +		return IRQ_NONE;
> +	}
> +
> +	if (irq_status & JLSEMI_INER_LINK_STATUS) {
> +		phy_trigger_machine(phydev);
> +		return IRQ_HANDLED;
> +	}

[Severity: Low]
The INSR read is also what acknowledges the interrupt, since that read is
all jlsemi_ack_interrupt() does. What happens if LINK_STATUS and PME are
both latched in the same read?

The early return means pm_wakeup_event() is never called for a PME that
the hardware has already cleared. One example is a PME latched during
suspend plus a link change around resume, after jlsemi_resume() restores
INER.

Could both bits be handled from the single read?

> +
> +	if (irq_status & JLSEMI_INER_PME) {
> +		pm_wakeup_event(&phydev->mdio.dev, 0);
> +		return IRQ_HANDLED;
> +	}

[ ... ]

> +static int jlsemi_set_wol(struct phy_device *phydev, struct ethtool_wolinfo *wol)
> +{

[ ... ]

> +		oldpage = phy_select_page(phydev, JLSEMI_PHYSICAL_ADDR_PAGE);
> +		if (oldpage < 0)
> +			return oldpage;

[Severity: High]
Does this return leave the MDIO bus lock held? phy_select_page() takes the
lock in phy_save_page() before it reads the page register, and it returns
errors with the lock still held:

drivers/net/phy/phy-core.c:phy_select_page() {
	oldpage = ret = phy_save_page(phydev);
	if (ret < 0)
		return ret;

	if (oldpage != page) {
		ret = __phy_write_page(phydev, page);
		if (ret < 0)
			return ret;
	}
    ...
}

Its kernel-doc says phy_restore_page() must always be called afterwards,
whether or not it succeeded. phy_restore_page() is also what unlocks the
bus.

If the page read or write fails with an MDIO error, this early return
skips the unlock. Every later access on that bus would then block forever,
including the state machine, the threaded PHY IRQ and other PHYs on the
same bus. The disable branch below has the same early return.

> +
> +		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD0,
> +			    mac_addr[1] << 8 | mac_addr[0]);
> +		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD1,
> +			    mac_addr[3] << 8 | mac_addr[2]);
> +		__phy_write(phydev, JLSEMI_PHYSICAL_ADDR_WORD2,
> +			    mac_addr[5] << 8 | mac_addr[4]);
> +
> +		ret = __phy_write(phydev, JLSEMI_PAGE_SELECT, JLSEMI_WOL_PAGE);
> +		if (ret < 0)
> +			goto restore;
> +
> +		__phy_write(phydev, JLSEMI_WOL_SETTINGS_EVENTS,
> +			    JLSEMI_WOL_EVENT_MAGIC);
> +		__phy_write(phydev, JLSEMI_WOL_RST_RMSQ,
> +			    JLSEMI_WOL_RMSQ);
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
Can jlsemi_set_wol() return anything other than 0 once the page has been
selected? The three MAC address writes and the SETTINGS_EVENTS and RST_RMSQ
writes are all unchecked.

If the switch to JLSEMI_WOL_PAGE fails, the code jumps to restore with
ret < 0. The return value of phy_restore_page() is discarded, though, and
the function still calls device_set_wakeup_enable() and returns 0.

In the disable branch, the __phy_write() and __phy_clear_bits() results
are ignored. phy_restore_page() gets a hard-coded 0 and its result is
discarded too.

phy_ethtool_set_wol() passes that 0 back to userspace. If the page restore
fails, register 0x1f is left on page 0xd8a or 0xd8c. Wouldn't later
unpaged accesses, such as INSR 0x1d in the IRQ handler or PHYCR2 0x19, hit
the wrong registers?

The realtek version at least returns the result of phy_restore_page().

> +
> +static int jlsemi_suspend(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	if (device_may_wakeup(&phydev->mdio.dev)) {
> +		ret = phy_write_paged(phydev, JLSEMI_INER_PAGE, JLSEMI_INER,
> +				      JLSEMI_INER_PME);
> +		if (ret < 0)
> +			return ret;
> +
> +		jlsemi_ack_interrupt(phydev);
> +		return 0;
> +	}

[Severity: Medium]
Is the WoL block ever taken out of reset? jlsemi_set_wol() writes
JLSEMI_WOL_RMSQ (0x1fff) to page 0xd8a reg 17, and that clears RG_RSTB.
For the same RTL8211F register, the realtek driver's comment says "Set the
maximum packet size, and assert WoL reset". Nothing in this driver sets
RG_RSTB again.

rtl8211f_suspend() pulses RG_RSTB low and then high after enabling the PME
interrupt:

drivers/net/phy/realtek/realtek_main.c:rtl8211f_suspend() {
    ...
		/* Reset the WoL to ensure that an event is picked up.
		 * Unless we do this, even if we receive another packet,
		 * we may not have a PME interrupt raised.
		 */
		ret = phy_read_paged(phydev, RTL8211F_WOL_PAGE,
				     RTL8211F_WOL_RST_RMSQ);
    ...
		wol_rst = ret & ~RTL8211F_WOL_RG_RSTB;
		ret = phy_write_paged(phydev, RTL8211F_WOL_PAGE,
				      RTL8211F_WOL_RST_RMSQ, wol_rst);
    ...
		wol_rst |= RTL8211F_WOL_RG_RSTB;
		ret = phy_write_paged(phydev, RTL8211F_WOL_PAGE,
				      RTL8211F_WOL_RST_RMSQ, wol_rst);
    ...
}

jlsemi_suspend() has the INER=PME write and the INSR read, but not the
pulse.

If the JLSemi part has the same RG_RSTB semantics, wouldn't the magic
packet matcher stay in reset? PME would then never be raised, even after
the wakeup capability problem is fixed.

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
When all three speed bits are set, this returns LINK_10, LINK_100 and
LINK_1000 plus TRIGGER_NETDEV_LINK. That is also the hardware state that
jlsemi_led_hw_control_set() writes for a plain link rule.

netdev_trig_activate() copies the bitmap straight into trigger_data->mode.
netdev_led_attr_store() then returns -EINVAL for any write that leaves
LINK set together with a LINK_xx bit:

drivers/leds/trigger/ledtrig-netdev.c:netdev_led_attr_store() {
    ...
	if (test_bit(TRIGGER_NETDEV_LINK, &mode) &&
	    (test_bit(TRIGGER_NETDEV_LINK_10, &mode) ||
	     test_bit(TRIGGER_NETDEV_LINK_100, &mode) ||
	     test_bit(TRIGGER_NETDEV_LINK_1000, &mode) ||
    ...
}

Wouldn't toggling rx, tx, link_10 or link_1000 from sysfs then fail with
-EINVAL until link is cleared first? Should this return either the
aggregate LINK rule or the individual speed rules, but not both?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016161543.444356-1-cyan2254650260%40gmail.com
