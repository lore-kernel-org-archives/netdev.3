Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1364C33B96B;
	Sat, 10 Oct 2026 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649162; cv=none; b=P3vayVCCH6OfATcP+jy1E+2V6U/aFNXTSG6xAsPDcFW4HfSi0RruDjaGIhp1+Oc1hEjQqjgogVHVPZlsPM85ZEapykD135+qY6w29jaGUBWzzULz3UqwLNFRaFoKgzwl1SkQIpv2nNhSOWDyvC1T/PgKIICDKUy6gkPY16TBiJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649162; c=relaxed/simple;
	bh=YgVIsLjp1tLqzHUZf23DB8oevOQfq+CDtB0IefTmaUk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NP6TMYludezKxLq7Z+K+5cWNAUQDCrZEf6wrXbWd0PM+NQStEd4QL2+X2FTMpjx2hXH1Rm4R/V9l36CkyySRth6Hru9m6t7Ig/w+lHq5clLi1RMtV/u5wje7VV+DfRNSKtKInJN4tKvBxjK0YUVh+MZJBw5KWf2Eag+f0H/wjns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jamvEln5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jamvEln5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372BE1F00893;
	Sat, 10 Oct 2026 16:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649158;
	bh=+kvkaBGo7Q2pmTo9BWaBu8jJRXDzDc1qbQwKXwWRWp4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jamvEln5telKX8rxoy0OgMu02WYeoTQjKedu3YX7Khz/Ng5lsBDpyo+ZzCjaRmOdg
	 hDeQaiNx/ZTPk4xPyvLaOiWybYgU6ykuXcX0qK1KNzqq40JQcxV7YYAh70R2zP2KJk
	 aQWPlzd4mnAxIA+QGNH17gOsWbbh6+15A/w1m4Fsa0hRj3FjM2Wpua6GT2YLByi/7g
	 WYxtwxGSUNqnUHwJ1wAIvNrX/LbhaUVSsVnkhp6W0AMeCn61nvvFgFDyNrow6v5X3g
	 ksoX4O8k6jRD6bxEzJu0VoTr/FwcrczbHBsvIZLybCPqJcbSCTMq4f7mNIzQAnjhM4
	 EIqPhBuHqtr9g==
Subject: Re: [PATCH net-next v25 04/10] mfd: an8855: Add support for Airoha
 AN8855 Switch
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Sat, 10 Oct 2026 16:19:16 +0000
Message-ID: <179164915675.434549.1757196298611264738@kernel.org>
In-Reply-To: <20261009161102.38961-5-ansuelsmth@gmail.com>
References: <20261009161102.38961-5-ansuelsmth@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 13 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 3 · Low: 9

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The MFD binding
  (Documentation/devicetree/bindings/mfd/airoha,an8855.yaml) defines…
- [Medium] The commit message says the driver provides "a DSA switch and
  a NVMEM provider", and so does the MFD_AIROHA_AN8855 help text.
- [Medium] The PHY binding added in this series
  (Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml) shows…
- [Medium] an8855_phy_bus_register() checks the DT PHY `reg` only as an
  offset from the switch address (`phy_offset = addr -…
- [Low] The patch leaves several loose ends: - AN8855_HWTRAP,
  AN8855_PHY_PAGE_EXTENDED_1 and AN8855_PBUS_MODE_ADDR_INCR are defined…
- [Low] an8855_phy_bus_register() registers one unnamed 16-bit regmap per
  internal PHY on the MFD parent device.
- [Low] In an8855_readable_ranges, the "General Purpose Timer" entry
  covers 0x1000a100-0x1000a2ff.
- [Low] The MFD binding leaves `efuse` out of `required`, but
  an8855_cells always adds the "an8855-efuse" cell with of_compatible…
- [Low] In an8855_phy_bus_register(), the u32 `addr` is printed with %d
  in dev_err_probe(dev, ..., "phy%d regmap initialization failed\n",…
- [Low] an8855_phy_bus_register() builds each virtual MDIO bus id with
  snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%u", dev_name(dev), addr)…
- [Low] an8855_regmap_phy_reset_page() always restores page 0
  (AN8855_PHY_PAGE_STANDARD) after a switch access.
- [Low] an8855_mdio_register() mixes scope-based and goto-based cleanup.
- [Low] an8855_core_probe() writes 0 to AN8855_RG_GPHY_AFE_PWD, releasing
  the analog front-end power-down for every internal GPHY at once,…

--

mfd: an8855: Add support for Airoha AN8855 Switch

This adds an MFD core driver for the Airoha AN8855 switch, which sits on an
MDIO bus. It exposes a 32-bit switch regmap and registers efuse and DSA
switch child cells. It also creates a virtual mdio-regmap bus, with its own
regmap, for each internal PHY, so that PHY and switch accesses sharing the
same MDIO address are serialized.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e4fd4572472f9..afbdcec0fce8f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -54,6 +54,20 @@ config MFD_ALTERA_SYSMGR

[ ... ]

> +config MFD_AIROHA_AN8855
> +	tristate "Airoha AN8855 Switch Core"
> +	select MFD_CORE
> +	select REGMAP
> +	select PHYLIB
> +	select MDIO_REGMAP
> +	depends on NETDEVICES && OF
> +	help
> +	  Support for the Airoha AN8855 Switch Core. This is an SoC
> +	  that provides various peripherals, to count, i2c, an Ethrnet
> +	  Switch, a CPU timer, GPIO, eFUSE.
> +
> +	  Currently it provides a DSA switch and a NVMEM provider.

[Severity: Medium]
The commit message and this help text both say the driver provides "a DSA
switch and a NVMEM provider". The DSA and PHY parts arrive later in the
series, in "net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver"
and "net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY".

Can the NVMEM provider be enabled on real hardware, though? The driver for
the an8855-efuse cell can still only be built with COMPILE_TEST:

drivers/nvmem/Kconfig:
config NVMEM_AN8855_EFUSE
	tristate "Airoha AN8855 eFuse support"
	depends on COMPILE_TEST

No patch in the series relaxes this to something like
"depends on MFD_AIROHA_AN8855 || COMPILE_TEST", which is what
NET_DSA_AN8855 uses.

Once the series is applied, an8855_probe() in drivers/net/phy/air_an8855.c
calls nvmem_cell_read_u32() whenever the PHY node has nvmem-cells, as both
binding examples do. With no provider registered, that returns
-EPROBE_DEFER, or an error if NVMEM is disabled. The PHY driver then never
binds, and phy_attach_direct() falls back to genphy.

Wouldn't the R50 calibration and the vendor config_init (downshift and
noise-reduction settings) then never be applied?

> diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> new file mode 100644
> index 0000000000000..a2778511dfefc
> --- /dev/null
> +++ b/drivers/mfd/airoha-an8855.c
> @@ -0,0 +1,579 @@

[ ... ]

> +#include <linux/gpio/consumer.h>

[ ... ]

> +/* Register for HW trap status */
> +#define AN8855_HWTRAP			0x1000009c

[ ... ]

> +#define   AN8855_PHY_PAGE_EXTENDED_1	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
> +#define   AN8855_PHY_PAGE_EXTENDED_4	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x4)
> +
> +/* MII Registers Page 4 */
> +#define AN8855_PBUS_MODE		0x10
> +#define   AN8855_PBUS_MODE_ADDR_FIXED	0x0
> +#define   AN8855_PBUS_MODE_ADDR_INCR	BIT(15)

[ ... ]

> +struct an8855_core {
> +	struct mii_bus *bus;
> +	struct mii_bus *phy_bus;
> +	unsigned int switch_addr;
> +	u16 current_page;
> +};

[Severity: Low]
This isn't a bug, but there are a few leftovers here.

AN8855_HWTRAP, AN8855_PHY_PAGE_EXTENDED_1 and AN8855_PBUS_MODE_ADDR_INCR
are defined but never used. linux/gpio/consumer.h is included, but no GPIO
API is used.

The MFD_AIROHA_AN8855 help text has typos: "to count" and "Ethrnet".

The MFD guidelines also prefer naming the private data struct after the
device and calling the instance ddata, rather than using
struct an8855_core *priv.

[ ... ]

> +static const struct mfd_cell an8855_cells[] = {
> +	MFD_CELL_OF("an8855-efuse", NULL, NULL, 0, 0,
> +		    "airoha,an8855-efuse"),
> +	MFD_CELL_OF("an8855-switch", NULL, NULL, 0, 0,
> +		    "airoha,an8855-switch"),
> +};

[Severity: Low]
The airoha,an8855.yaml binding does not list efuse under required, but the
an8855-efuse cell is always added.

Take a DT that is valid under the binding but has no efuse node. In that
case mfd_add_device() prints "Failed to locate of_node" and registers the
platform device anyway. The efuse driver then binds by name and registers
an NVMEM device with no OF node, which no PHY can reference.

Should the efuse cell only be added when the node exists, or should efuse
be required in the binding?

[ ... ]

> +static const struct regmap_range an8855_readable_ranges[] = {

[ ... ]

> +	regmap_reg_range(0x10009000, 0x10009fff), /* PDMA */
> +	regmap_reg_range(0x1000a100, 0x1000a2ff), /* General Purpose Timer */
> +	regmap_reg_range(0x1000a200, 0x1000a2ff), /* GPU timer */

[Severity: Low]
Should the General Purpose Timer range end at 0x1000a1ff? As written, it
fully contains the GPU timer range that follows.

Also, should "GPU timer" be "CPU timer"? That is what the Kconfig help
text calls it.

[ ... ]

> +static int an8855_regmap_phy_reset_page(struct an8855_core *priv,
> +					int phy) __must_hold(&priv->bus->mdio_lock)
> +{
> +	/* Check PHY page only for addr shared with switch */
> +	if (phy != priv->switch_addr)
> +		return 0;
> +
> +	/* Don't restore page if it's not set to Switch page */
> +	if (priv->current_page != AN8855_PHY_PAGE_EXTENDED_4)
> +		return 0;
> +
> +	/*
> +	 * Restore page to 0, PHY might change page right after but that
> +	 * will be ignored as it won't be a switch page.
> +	 */
> +	return an8855_mii_set_page(priv, phy, AN8855_PHY_PAGE_STANDARD);
> +}

[Severity: Low]
This isn't a bug for in-kernel users, but this always restores page 0
after a switch access. PHY writes to register 0x1f that go through
an8855_regmap_phy_write() don't update priv->current_page. So if a switch
regmap access runs between two PHY accesses, the page the PHY selected is
lost.

In-kernel, phy_read_paged() and phy_modify_paged() in air_an8855.c hold
the virtual bus mdio_lock across the page select, the access and the
restore. an8855_regmap_lock() takes the same phy_bus->mdio_lock, so those
paths are serialized.

The remaining case is privileged userspace that selects a page with one
SIOCSMIIREG call and then accesses a register with a separate call. Is
that an acceptable limitation, and should the existing comment mention it?

[ ... ]

> +static int an8855_phy_bus_register(struct device *dev, struct an8855_core *priv,
> +				   struct device_node *phy_np,
> +				   struct an8855_phy_bus *phy_bus_info)
> +{

[ ... ]

> +	ret = of_property_read_u32(phy_np, "reg", &addr);
> +	if (ret)
> +		return ret;
> +
> +	phy_offset = addr - priv->switch_addr;
> +	if (phy_offset >= AN8855_MAX_PHY_PORT)
> +		return -EINVAL;

[Severity: Medium]
Should this also check that addr is below PHY_MAX_ADDR?

With the switch at MDIO address 28-31, a PHY child with reg 32-35 passes
this check. of_mdio_parse_addr() would normally reject that address. This
driver calls fwnode_mdiobus_register_phy() directly, so the address reaches
code that indexes PHY_MAX_ADDR-sized arrays in struct mii_bus:

an8855_core_probe()
  fwnode_mdiobus_register_phy()
    phy_device_create()
      dev->irq = bus->irq[addr];
    fwnode_mdiobus_phy_device_register()
      mdio->irq[addr] = rc;
      mdio->phy_ignore_ta_mask |= 1 << addr;

irq[32..35] overlaps reset_delay_us, reset_post_delay_us and reset_gpiod.
Also, "1 << addr" is undefined when addr is 32 or more.

Next, phy_device_register() fails with -EBUSY, because mdio_map[addr]
overlaps fields that are non-zero. The devres unwind then runs
mdiobus_unregister(), which passes bus->reset_gpiod to
gpiod_set_value_cansleep().

Could that dereference a corrupted reset_gpiod? Triggering this needs a DT
that breaks the reg maximum in mdio.yaml, but the core enforces this bound
at runtime on its own paths.

> +
> +	phy_priv = devm_kzalloc(dev, sizeof(*phy_priv), GFP_KERNEL);
> +	if (!phy_priv)
> +		return -ENOMEM;
> +
> +	phy_priv->addr = addr;
> +	phy_priv->core = priv;
> +
> +	regmap = devm_regmap_init(dev, NULL, phy_priv, &an8855_phy_regmap_config);

[Severity: Low]
This isn't a bug with the current probe order, but these unnamed PHY
regmaps are attached to the same device as the "switch" regmap.

an8855_efuse_probe(), and the DSA driver later in the series, both call
dev_get_regmap(dev->parent, NULL). That matches any regmap on the parent
and returns the most recently added one. The children get the switch
regmap only because an8855_core_probe() creates it after all the PHY
regmaps.

Would it be more robust for the children to look up "switch" by name, or
to give the PHY regmaps names?

> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "phy%d regmap initialization failed\n",
> +				      addr);

[Severity: Low]
This isn't a bug, but addr is a u32 printed with %d here, while the
snprintf() below prints it with %u.

> +
> +	mrc.regmap = regmap;
> +	mrc.parent = dev;
> +	mrc.valid_addr = addr;
> +	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%u", dev_name(dev), addr);

[Severity: Low]
Can this truncation drop the per-PHY suffix?

dev_name(dev) for this mdio_device is PHY_ID_FMT ("%s:%02x") applied to
the parent bus id, which can be up to 60 characters long. If the parent bus
id is 53 characters or longer, "-phyN", or at least its digit, gets cut
off.

devm_mdio_regmap_register() copies this name into mii->id, so every
virtual bus would get the same id and the second bus registration would
fail. Should the snprintf() return value be checked, or a shorter naming
scheme be used?

> +
> +	bus = devm_mdio_regmap_register(dev, &mrc);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);

[Severity: Medium]
The PHY binding added in this series (airoha,an8855-phy.yaml) shows the
internal PHYs as:

	compatible = "ethernet-phy-idc0ff.0410",
	             "ethernet-phy-ieee802.3-c45";

The MFD binding example uses "ethernet-phy-ieee802.3-c22" for the same
PHYs. The bus created here only sets mdio_regmap_read_c22() and
mdio_regmap_write_c22(), with no read_c45 or write_c45.

If a DT follows the PHY binding, wouldn't probe fail?

an8855_core_probe()
  fwnode_mdiobus_register_phy()   /* is_c45 set, PHY ID shortcut skipped */
    get_phy_device(bus, addr, true)
      get_phy_c45_ids()
        mdiobus_c45_read()          /* -EOPNOTSUPP without read_c45 */

get_phy_c45_ids() turns that into -EIO, and an8855_core_probe() jumps to
err_put_fwnodes. The switch, the efuse and all the PHYs then fail to
register.

Should the PHY binding example use c22, or should the driver handle the c45
compatible?

[ ... ]

> +static int an8855_mdio_register(struct device *dev, struct an8855_core *priv,
> +				struct an8855_phy_bus *phy_bus_infos)
> +{
> +	struct device_node *mdio_np;
> +	int ret = 0;
> +	int i = 0;
> +
> +	mdio_np = of_get_child_by_name(dev->of_node, "mdio");
> +	if (!mdio_np)
> +		return -ENODEV;
> +
> +	for_each_available_child_of_node_scoped(mdio_np, phy_np) {
> +		if (i >= AN8855_MAX_PHY_PORT) {
> +			ret = -EINVAL;
> +			goto exit;
> +		}
> +
> +		ret = an8855_phy_bus_register(dev, priv, phy_np,
> +					      &phy_bus_infos[i]);
> +		if (ret)
> +			goto exit;
> +
> +		i++;
> +	}
> +
> +exit:
> +	of_node_put(mdio_np);

[Severity: Low]
This isn't a bug as written, but this function mixes the scoped iterator
(phy_np is declared __free(device_node)) with goto-based cleanup.
include/linux/cleanup.h asks that the two not be mixed in one function.

Could mdio_np use __free(device_node), with the error paths returning
directly? Alternatively, the non-scoped iterator could be used with an
explicit of_node_put() on early exit.

[ ... ]

> +static int an8855_core_probe(struct mdio_device *mdiodev)
> +{

[ ... ]

> +	/* Reset PHY page for switch address */
> +	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_mii_set_page(priv, priv->switch_addr,
> +				  AN8855_PHY_PAGE_STANDARD);
> +	mutex_unlock(&priv->bus->mdio_lock);
> +	if (ret)
> +		goto err_put_fwnodes;
> +
> +	ret = an8855_read_switch_id(dev, regmap);
> +	if (ret)
> +		goto err_put_fwnodes;

[Severity: High]
Is the reset-gpios property from the airoha,an8855.yaml binding handled
anywhere? The binding example uses reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>.
an8855_core_probe() never requests or toggles that GPIO, and starts MDIO
traffic right here.

The MDIO core doesn't handle it either. mdiobus_register_device() only
calls mdio_device_register_reset() when MDIO_DEVICE_FLAG_PHY is set, and
the AN8855 core is a plain mdio_device.

If the bootloader leaves the switch in reset, wouldn't
an8855_read_switch_id() fail and leave the whole switch unusable? If reset
was released only just before probe, nothing waits for init to finish. In
both cases the chip never gets a clean hardware reset, so switch and PHY
state configured by the bootloader carries over.

The unused linux/gpio/consumer.h include and the unused AN8855_HWTRAP
("Register for HW trap status") define suggest a reset-and-wait sequence
was removed. Was that intended?

> +
> +	/* Release global PHY power down */
> +	ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
> +	if (ret)
> +		goto err_put_fwnodes;

[Severity: Low]
This powers up the analog front end of every internal GPHY, including PHYs
that are not described in DT. Is anything expected to put them back into
power down?

If a later step fails, the err_put_fwnodes path only drops fwnode
references. There is no remove callback or devm action, and the DSA driver
later in the series never touches AN8855_RG_GPHY_AFE_PWD.

So after a failed probe or an unbind, the PHYs stay powered with no driver
managing them.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009161102.38961-1-ansuelsmth%40gmail.com
