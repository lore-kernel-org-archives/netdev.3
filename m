Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1973D3CCFCB;
	Thu,  1 Oct 2026 04:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829939; cv=none; b=ohT9Lu3AxIbwMQ8GZPEY1pvcUOoRUCHIKzNMUVuVXFaxKu2dC6XM1REGq5CIjusRfhKcm4Oi9iT0KowXmJgjoFuVAjDS9zohmdnRwgqHfxcQ885gjg4i5PUxu/oJTIZpCuEj+dM7Ttde5PITtRg68zYCbsCr5eQx0BoBXUGM6p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829939; c=relaxed/simple;
	bh=EmpBXDaL3B7l/fjcV/o7+So+ALjppOLJye/yyRCdQJc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QpAGIqxZH1y9AWsExuGxIOUkY8cKX6mCE8L7zkssxzgpcneKTtWVx1h3Ggp2SMURM2Vw8STXM9+L7BGbKxpCO/Ya70lKoQm/unqaqtTlxI698wdGy5NJVJoSM+4Wv9OzqO1Apvot7UUlvKDYpeEZfhPwGwebwvHnvpBelG3P7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZNRxb1n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZNRxb1n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2028A1F000FF;
	Thu,  1 Oct 2026 04:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829933;
	bh=TqYmry0cvhXzksJZb36O7CL9pb5vD7lkdRy+lhuR2k0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YZNRxb1nI0p2Sceqm7oBNeDoyoV3tdm3MQfgtyJg4f5FW9YQp/2G5eXb6inX45T0+
	 tV69B0Kr1KdOG+/h9EJbzyzga4agTcIVQLgcGFNX8qv6kA6bd46lqvHHT8yWMqU+hz
	 +Sm6hiSVDAgtFKgZaeyCUbCPXgEoNiuU1RXtnRT8++69Nq72GDdkO6B5xnGHEmz63L
	 7AMfya6ydgPK8qHzmRgOn8pu+iJ/3gHxbdkTGMOtkYJEMQbWkyCmQyHjepumcMUhEB
	 IlCv6DehGS4sYd/9x9DpEyA1h9T44phy+tYZ9m6fnzR547H1YlHcjwrg5RxNz42fBO
	 VwO6/yvb9runA==
Subject: Re: [PATCH net-next v24 04/10] mfd: an8855: Add support for Airoha
 AN8855 Switch
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Thu, 01 Oct 2026 04:45:31 +0000
Message-ID: <179082993165.434549.13897568032274944951@kernel.org>
In-Reply-To: <20260928194511.41878-5-ansuelsmth@gmail.com>
References: <20260928194511.41878-5-ansuelsmth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 7 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 4 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch adds the MFD_AIROHA_AN8855 symbol and registers an
  'airoha,an8855-efuse' MFD cell.
- [Medium] The MFD binding (airoha,an8855.yaml) documents `reset-gpios`
  on the AN8855 core node, and its example uses one.
- [Medium] The PHY binding example
  (Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml)…
- [Medium] an8855_phy_bus_register() checks the DT PHY 'reg' only as an
  offset from switch_addr (phy_offset = addr - switch_addr < 5), never…
- [Low] an8855_mdio_register() uses goto-based cleanup and scope-based
  cleanup in the same function.
- [Low] an8855_core_probe() writes 0 to AN8855_RG_GPHY_AFE_PWD (line
  534), which powers up the analog front end of all internal GPHYs.
- [Low] mfd: airoha-an8855: violates MFD naming conventions for private
  structures

--

mfd: an8855: Add support for Airoha AN8855 Switch

This adds an MFD core driver for the Airoha AN8855 switch. It registers
efuse (NVMEM) and DSA switch child cells. It also creates an mdio-regmap
bus and a regmap for each internal PHY, so those PHYs can serve both as
PHYs and as the path for switch register access.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index e4fd4572472f9..afbdcec0fce8f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -54,6 +54,20 @@ config MFD_ALTERA_SYSMGR
>  	  using regmap_mmio accesses for ARM32 parts and SMC calls to
>  	  EL3 for ARM64 parts.
>  
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
Now that this symbol exists, should NVMEM_AN8855_EFUSE in
drivers/nvmem/Kconfig get its dependency back?

Commit 4796eaafd6a1 ("nvmem: an8855: drop an unused Kconfig symbol")
removed "depends on MFD_AIROHA_AN8855 || COMPILE_TEST" only because this
symbol did not exist yet. The nvmem entry still has just:

config NVMEM_AN8855_EFUSE
	...
	depends on COMPILE_TEST

drivers/nvmem/Kconfig is not changed anywhere else in the series.

Without COMPILE_TEST, can any driver bind to the "airoha,an8855-efuse"
cell registered from an8855_cells? If not, the PHY calibration nvmem-cells
in the bindings can't be resolved. nvmem_cell_read_u32() in air_an8855.c
would then fail whenever a PHY node has nvmem-cells.

That seems to contradict the "NVMEM provider" described here and in the
commit message.

> diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> new file mode 100644
> index 0000000000000..cd5791ef436d9
> --- /dev/null
> +++ b/drivers/mfd/airoha-an8855.c
> @@ -0,0 +1,579 @@

[ ... ]

> +static int an8855_phy_bus_register(struct device *dev, struct an8855_core_priv *priv,
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
Is the absolute addr ever checked against PHY_MAX_ADDR?

This only checks the offset from switch_addr. With the switch at MDIO
address 28-31, a DT "reg" of 32-35 gets through. an8855_core_probe() then
passes it to fwnode_mdiobus_register_phy(), which skips the
of_mdio_parse_addr() check that the normal OF path does.

With an explicit ethernet-phy-idXXXX.XXXX compatible, as in the binding
examples, can this index past the 32-entry arrays in struct mii_bus?

fwnode_mdiobus_phy_device_register()
    mdio->irq[addr] = rc;

mdiobus_register_device()
    if (mdiodev->bus->mdio_map[mdiodev->addr])
        return -EBUSY;
    ...
    mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;

phy_device_create() also reads bus->irq[addr], and the broken-turn-around
handling computes 1 << addr.

On 64-bit, irq[34] overlays the low word of bus->reset_gpiod. After an
interrupt write, the mdio_map[] check returns -EBUSY. mdiobus_unregister()
on the unwind path then calls gpiod_set_value_cansleep() on the corrupted
pointer.

On 32-bit, mdio_map[33] overlays phy_ignore_ta_mask. The PHY ends up in a
slot that mdiobus_unregister() never walks.

Such a DT would already violate mdio.yaml (reg max 31). Would an
"addr >= PHY_MAX_ADDR" check here still be worth adding?

[ ... ]

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
This isn't a bug, but an8855_mdio_register() mixes goto-based cleanup with
the scope-based __free(device_node) from
for_each_available_child_of_node_scoped(). include/linux/cleanup.h asks
that a routine use one style or the other, not both.

Nothing leaks today, because leaving the loop scope drops phy_np. Could
mdio_np be declared with __free(device_node), and the error paths return
directly after putting the fwnodes?

[ ... ]

> +	/* Reset PHY page for switch address */
> +	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_mii_set_page(priv, priv->switch_addr,
> +				  AN8855_PHY_PAGE_STANDARD);

[Severity: Medium]
Should reset-gpios be handled before this first access?

The airoha,an8855.yaml binding documents reset-gpios on the core node, and
its example uses it. <linux/gpio/consumer.h> is included and AN8855_HWTRAP
is defined, but neither is used. an8855_core_probe() goes straight to MDIO
accesses, with no reset pulse, settle delay or HWTRAP ready poll.

The MDIO core won't handle it either. mdiobus_register_device() only sets
up the reset for PHY devices:

    if (mdiodev->flags & MDIO_DEVICE_FLAG_PHY) {
        err = mdio_device_register_reset(mdiodev);

For this plain mdio_device, reset_gpio stays NULL. The DSA driver later in
the series doesn't handle reset either.

On a board that leaves the line asserted, wouldn't the AN8855_CREV read
fail or return the wrong ID, so the whole device fails to probe? If the
line is left deasserted, the chip keeps whatever state the bootloader left.

[ ... ]

> +	/* Release global PHY power down */
> +	ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
> +	if (ret)
> +		goto err_put_fwnodes;
> +
> +	/* Register PHYs */
> +	for (i = 0; i < num_phys; i++) {
> +		ret = fwnode_mdiobus_register_phy(phy_bus_infos[i].bus,
> +						  phy_bus_infos[i].node,
> +						  phy_bus_infos[i].addr);

[Severity: Medium]
What happens here with a DT written from the PHY binding example? The
example in airoha,an8855-phy.yaml uses:

    compatible = "ethernet-phy-idc0ff.0410",
                 "ethernet-phy-ieee802.3-c45";

The bus from devm_mdio_regmap_register() only has C22 accessors:

    mii->read = mdio_regmap_read_c22;
    mii->write = mdio_regmap_write_c22;

When the c45 compatible is present, fwnode_mdiobus_register_phy() probes
as C45 even if an explicit PHY ID is given:

    is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
    if (is_c45 || fwnode_get_phy_id(child, &phy_id))
        phy = get_phy_device(bus, addr, is_c45);

get_phy_c45_ids() -> mdiobus_c45_read() then fails with -EOPNOTSUPP, and
get_phy_device() returns an error. The goto err_put_fwnodes fails the whole
probe, so the switch and efuse children are never created.

The MFD binding example uses "-c22", and air_an8855.c uses phy_*_mmd over
C22. Should the PHY binding example be changed to match? It is still
unchanged at the end of the series.

> +		fwnode_handle_put(phy_bus_infos[i].node);
> +		phy_bus_infos[i].node = NULL;
> +
> +		if (ret)
> +			goto err_put_fwnodes;
> +	}
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_cells,
> +				    ARRAY_SIZE(an8855_cells), NULL, 0,
> +				    NULL);
> +
> +err_put_fwnodes:
> +	for (i = 0; i < num_phys; i++)
> +		if (phy_bus_infos[i].node)
> +			fwnode_handle_put(phy_bus_infos[i].node);
> +
> +	return ret;
> +}

[Severity: Low]
Should the GPHYs be put back into power-down when probe fails?

AN8855_RG_GPHY_AFE_PWD is cleared before the PHYs are registered and before
devm_mfd_add_devices() runs. If either step fails, err_put_fwnodes only
drops the fwnode references. A devm_mfd_add_devices() error is returned
directly.

an8855_core_driver also has no .remove. mdio_probe() does nothing on
failure because reset_gpio is NULL here.

After a failed probe or an unbind, would the internal PHYs stay powered and
be able to bring links up with no driver owning them?

[ ... ]

> @@ -0,0 +1,579 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Core driver for Airoha AN8855 Switch
> + *
> + * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/fwnode_mdio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mdio.h>
> +#include <linux/mdio/mdio-regmap.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/phy.h>
> +#include <linux/regmap.h>
> +
> +/* Register for HW trap status */
> +#define AN8855_HWTRAP			0x1000009c
> +
> +/*
> + * Register of the Switch ID
> + * (called Project ID in Documentation)
> + */
> +#define AN8855_CREV			0x10005000
> +#define   AN8855_ID			0x8855 /* Switch ID */
> +
> +/* Register for GPHY Power Down
> + * Used to Toggle the Gigabit PHY power and enable them.
> + */
> +#define AN8855_RG_GPHY_AFE_PWD		0x1028c840
> +
> +/* MII Registers */
> +#define AN8855_PHY_SELECT_PAGE		0x1f
> +#define   AN8855_PHY_PAGE		GENMASK(2, 0)
> +#define   AN8855_PHY_PAGE_STANDARD	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x0)
> +#define   AN8855_PHY_PAGE_EXTENDED_1	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
> +#define   AN8855_PHY_PAGE_EXTENDED_4	FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x4)
> +
> +/* MII Registers Page 4 */
> +#define AN8855_PBUS_MODE		0x10
> +#define   AN8855_PBUS_MODE_ADDR_FIXED	0x0
> +#define   AN8855_PBUS_MODE_ADDR_INCR	BIT(15)
> +#define AN8855_PBUS_WR_ADDR_HIGH	0x11
> +#define AN8855_PBUS_WR_ADDR_LOW		0x12
> +#define AN8855_PBUS_WR_DATA_HIGH	0x13
> +#define AN8855_PBUS_WR_DATA_LOW		0x14
> +#define AN8855_PBUS_RD_ADDR_HIGH	0x15
> +#define AN8855_PBUS_RD_ADDR_LOW		0x16
> +#define AN8855_PBUS_RD_DATA_HIGH	0x17
> +#define AN8855_PBUS_RD_DATA_LOW		0x18
> +
> +#define AN8855_MAX_PHY_PORT		5
> +
> +struct an8855_core_priv {
> +	struct mii_bus *bus;
> +	struct mii_bus *phy_bus;
> +	unsigned int switch_addr;
> +	u16 current_page;
> +};
> +
> +struct an8855_phy_priv {
> +	u8 addr;
> +	struct an8855_core_priv *core;
> +};
> +
> +struct an8855_phy_bus {
> +	struct mii_bus *bus;
> +	struct fwnode_handle *node;
> +	u8 addr;
> +};
> +
> +static const struct mfd_cell an8855_cells[] = {
> +	MFD_CELL_OF("an8855-efuse", NULL, NULL, 0, 0,
> +		    "airoha,an8855-efuse"),
> +	MFD_CELL_OF("an8855-switch", NULL, NULL, 0, 0,
> +		    "airoha,an8855-switch"),
> +};
> +
> +static int an8855_mii_set_page(struct an8855_core_priv *priv, u8 addr,
> +			       u8 page) __must_hold(&priv->bus->mdio_lock)
> +{
> +	struct mii_bus *bus = priv->bus;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, addr, AN8855_PHY_SELECT_PAGE, page);
> +	if (ret) {
> +		dev_err_ratelimited(&bus->dev, "failed to set mii page\n");
> +		return ret;
> +	}
> +
> +	/* Cache current page if next MII read/write is for Switch page */
> +	priv->current_page = page;
> +	return 0;
> +}
> +
> +static int an8855_mii_read32(struct mii_bus *bus, u8 phy_id, u32 reg,
> +			     u32 *val) __must_hold(&bus->mdio_lock)
> +{
> +	int lo, hi, ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> +			      AN8855_PBUS_MODE_ADDR_FIXED);
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_HIGH,
> +			      upper_16_bits(reg));
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_RD_ADDR_LOW,
> +			      lower_16_bits(reg));
> +	if (ret)
> +		goto err;
> +
> +	hi = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_HIGH);
> +	if (hi < 0) {
> +		ret = hi;
> +		goto err;
> +	}
> +
> +	lo = __mdiobus_read(bus, phy_id, AN8855_PBUS_RD_DATA_LOW);
> +	if (lo < 0) {
> +		ret = lo;
> +		goto err;
> +	}
> +
> +	*val = ((u32)hi << 16) | lo;
> +
> +	return 0;
> +err:
> +	dev_err_ratelimited(&bus->dev, "failed to read register\n");
> +	return ret;
> +}
> +
> +/*
> + * Protect concurrent access to phy page if switch address also
> + * expose a PHY.
> + */
> +static void an8855_regmap_lock(struct an8855_core_priv *priv)
> +{
> +	if (priv->phy_bus)
> +		mutex_lock(&priv->phy_bus->mdio_lock);
> +	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +}
> +
> +static void an8855_regmap_unlock(struct an8855_core_priv *priv)
> +{
> +	mutex_unlock(&priv->bus->mdio_lock);
> +	if (priv->phy_bus)
> +		mutex_unlock(&priv->phy_bus->mdio_lock);
> +}
> +
> +static int an8855_regmap_read(void *ctx, uint32_t reg, uint32_t *val)
> +{
> +	struct an8855_core_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	u16 addr = priv->switch_addr;
> +	int ret;
> +
> +	an8855_regmap_lock(priv);
> +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = an8855_mii_read32(bus, addr, reg, val);
> +
> +exit:
> +	an8855_regmap_unlock(priv);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_mii_write32(struct mii_bus *bus, u8 phy_id, u32 reg,
> +			      u32 val) __must_hold(&bus->mdio_lock)
> +{
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_MODE,
> +			      AN8855_PBUS_MODE_ADDR_FIXED);
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_HIGH,
> +			      upper_16_bits(reg));
> +	if (ret)
> +		goto err;
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_ADDR_LOW,
> +			      lower_16_bits(reg));
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_HIGH,
> +			      upper_16_bits(val));
> +	if (ret)
> +		goto err;
> +
> +	ret = __mdiobus_write(bus, phy_id, AN8855_PBUS_WR_DATA_LOW,
> +			      lower_16_bits(val));
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	dev_err_ratelimited(&bus->dev,
> +			    "failed to write an8855 register\n");
> +	return ret;
> +}
> +
> +static int an8855_regmap_write(void *ctx, uint32_t reg, uint32_t val)
> +{
> +	struct an8855_core_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	u16 addr = priv->switch_addr;
> +	int ret;
> +
> +	an8855_regmap_lock(priv);
> +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> +	if (ret)
> +		goto exit;
> +
> +	ret = an8855_mii_write32(bus, addr, reg, val);
> +
> +exit:
> +	an8855_regmap_unlock(priv);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_regmap_update_bits(void *ctx, uint32_t reg, uint32_t mask,
> +				     uint32_t write_val)
> +{
> +	struct an8855_core_priv *priv = ctx;
> +	struct mii_bus *bus = priv->bus;
> +	u16 addr = priv->switch_addr;
> +	u32 val;
> +	int ret;
> +
> +	an8855_regmap_lock(priv);
> +	ret = an8855_mii_set_page(priv, addr, AN8855_PHY_PAGE_EXTENDED_4);
> +	if (ret)
> +		goto exit;
> +
> +	ret = an8855_mii_read32(bus, addr, reg, &val);
> +	if (ret < 0)
> +		goto exit;
> +
> +	val &= ~mask;
> +	val |= write_val & mask;
> +	ret = an8855_mii_write32(bus, addr, reg, val);
> +
> +exit:
> +	an8855_regmap_unlock(priv);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static const struct regmap_range an8855_readable_ranges[] = {
> +	regmap_reg_range(0x10000000, 0x10000fff), /* SCU */
> +	regmap_reg_range(0x10001000, 0x10001fff), /* RBUS */
> +	regmap_reg_range(0x10002000, 0x10002fff), /* MCU */
> +	regmap_reg_range(0x10005000, 0x10005fff), /* SYS SCU */
> +	regmap_reg_range(0x10007000, 0x10007fff), /* I2C Slave */
> +	regmap_reg_range(0x10008000, 0x10008fff), /* I2C Master */
> +	regmap_reg_range(0x10009000, 0x10009fff), /* PDMA */
> +	regmap_reg_range(0x1000a100, 0x1000a2ff), /* General Purpose Timer */
> +	regmap_reg_range(0x1000a200, 0x1000a2ff), /* GPU timer */
> +	regmap_reg_range(0x1000a300, 0x1000a3ff), /* GPIO */
> +	regmap_reg_range(0x1000a400, 0x1000a5ff), /* EFUSE */
> +	regmap_reg_range(0x1000c000, 0x1000cfff), /* GDMP CSR */
> +	regmap_reg_range(0x10010000, 0x1001ffff), /* GDMP SRAM */
> +	regmap_reg_range(0x10200000, 0x10203fff), /* Switch - ARL Global */
> +	regmap_reg_range(0x10204000, 0x10207fff), /* Switch - BMU */
> +	regmap_reg_range(0x10208000, 0x1020bfff), /* Switch - ARL Port */
> +	regmap_reg_range(0x1020c000, 0x1020cfff), /* Switch - SCH */
> +	regmap_reg_range(0x10210000, 0x10213fff), /* Switch - MAC */
> +	regmap_reg_range(0x10214000, 0x10217fff), /* Switch - MIB */
> +	regmap_reg_range(0x10218000, 0x1021bfff), /* Switch - Port Control */
> +	regmap_reg_range(0x1021c000, 0x1021ffff), /* Switch - TOP */
> +	regmap_reg_range(0x10220000, 0x1022ffff), /* SerDes */
> +	regmap_reg_range(0x10286000, 0x10286fff), /* RG Batcher */
> +	regmap_reg_range(0x1028c000, 0x1028ffff), /* ETHER_SYS */
> +	regmap_reg_range(0x30000000, 0x37ffffff), /* I2C EEPROM */
> +	regmap_reg_range(0x38000000, 0x3fffffff), /* BOOT_ROM */
> +	regmap_reg_range(0xa0000000, 0xbfffffff), /* GPHY */
> +};
> +
> +static const struct regmap_access_table an8855_readable_table = {
> +	.yes_ranges = an8855_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(an8855_readable_ranges),
> +};
> +
> +static const struct regmap_config an8855_regmap_config = {
> +	.name = "switch",
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0xbfffffff,
> +	.reg_read = an8855_regmap_read,
> +	.reg_write = an8855_regmap_write,
> +	.reg_update_bits = an8855_regmap_update_bits,
> +	.disable_locking = true,
> +	.rd_table = &an8855_readable_table,
> +};
> +
> +static int an8855_regmap_phy_reset_page(struct an8855_core_priv *priv,
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
> +
> +static int an8855_regmap_phy_read(void *ctx, uint32_t reg, uint32_t *val)
> +{
> +	struct an8855_phy_priv *priv = ctx;
> +	struct an8855_core_priv *core_priv;
> +	u32 addr = priv->addr;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	core_priv = priv->core;
> +	bus = core_priv->bus;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_regmap_phy_reset_page(core_priv, addr);
> +	if (ret)
> +		goto exit;
> +
> +	ret = __mdiobus_read(bus, addr, reg);
> +	if (ret >= 0)
> +		*val = ret;
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static int an8855_regmap_phy_write(void *ctx, uint32_t reg, uint32_t val)
> +{
> +	struct an8855_phy_priv *priv = ctx;
> +	struct an8855_core_priv *core_priv;
> +	u32 addr = priv->addr;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	core_priv = priv->core;
> +	bus = core_priv->bus;
> +
> +	mutex_lock_nested(&bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_regmap_phy_reset_page(core_priv, addr);
> +	if (ret)
> +		goto exit;
> +
> +	ret = __mdiobus_write(bus, addr, reg, val);
> +
> +exit:
> +	mutex_unlock(&bus->mdio_lock);
> +
> +	return ret;
> +}
> +
> +static const struct regmap_config an8855_phy_regmap_config = {
> +	.reg_bits = 16,
> +	.val_bits = 16,
> +	.reg_read = an8855_regmap_phy_read,
> +	.reg_write = an8855_regmap_phy_write,
> +	.disable_locking = true,
> +	.max_register = 0x1f,
> +};
> +
> +static int an8855_read_switch_id(struct device *dev, struct regmap *regmap)
> +{
> +	u32 id;
> +	int ret;
> +
> +	ret = regmap_read(regmap, AN8855_CREV, &id);
> +	if (ret)
> +		return ret;
> +
> +	if (id != AN8855_ID) {
> +		dev_err(dev, "Detected Switch ID %x but %x was expected\n",
> +			id, AN8855_ID);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static int an8855_phy_bus_register(struct device *dev, struct an8855_core_priv *priv,
> +				   struct device_node *phy_np,
> +				   struct an8855_phy_bus *phy_bus_info)
> +{
> +	struct mdio_regmap_config mrc = { };
> +	struct an8855_phy_priv *phy_priv;
> +	struct regmap *regmap;
> +	u32 addr, phy_offset;
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	ret = of_property_read_u32(phy_np, "reg", &addr);
> +	if (ret)
> +		return ret;
> +
> +	phy_offset = addr - priv->switch_addr;
> +	if (phy_offset >= AN8855_MAX_PHY_PORT)
> +		return -EINVAL;
> +
> +	phy_priv = devm_kzalloc(dev, sizeof(*phy_priv), GFP_KERNEL);
> +	if (!phy_priv)
> +		return -ENOMEM;
> +
> +	phy_priv->addr = addr;
> +	phy_priv->core = priv;
> +
> +	regmap = devm_regmap_init(dev, NULL, phy_priv, &an8855_phy_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "phy%d regmap initialization failed\n",
> +				      addr);
> +
> +	mrc.regmap = regmap;
> +	mrc.parent = dev;
> +	mrc.valid_addr = addr;
> +	snprintf(mrc.name, MII_BUS_ID_SIZE, "%s-phy%u", dev_name(dev), addr);
> +
> +	bus = devm_mdio_regmap_register(dev, &mrc);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);
> +
> +	if (addr == priv->switch_addr)
> +		priv->phy_bus = bus;
> +
> +	phy_bus_info->bus = bus;
> +	phy_bus_info->addr = addr;
> +	phy_bus_info->node = fwnode_handle_get(of_fwnode_handle(phy_np));
> +
> +	return 0;
> +}
> +
> +static int an8855_mdio_register(struct device *dev, struct an8855_core_priv *priv,
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
> +	if (ret) {
> +		while (i--)
> +			fwnode_handle_put(phy_bus_infos[i].node);
> +
> +		return ret;
> +	}
> +
> +	return i;
> +}
> +
> +static int an8855_core_probe(struct mdio_device *mdiodev)
> +{
> +	struct an8855_phy_bus phy_bus_infos[AN8855_MAX_PHY_PORT] = { };
> +	struct device *dev = &mdiodev->dev;
> +	struct an8855_core_priv *priv;
> +	struct regmap *regmap;
> +	int num_phys;
> +	int i, ret;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->bus = mdiodev->bus;
> +	priv->switch_addr = mdiodev->addr;
> +	/* No DMA for mdiobus, mute warning for DMA mask not set */
> +	dev->dma_mask = &dev->coherent_dma_mask;
> +
> +	/* Register virtual MDIO for each PHY */
> +	num_phys = an8855_mdio_register(dev, priv, phy_bus_infos);
> +	if (num_phys < 0)
> +		return num_phys;
> +
> +	regmap = devm_regmap_init(dev, NULL, priv, &an8855_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		ret = PTR_ERR(regmap);
> +		dev_err_probe(dev, ret, "regmap initialization failed\n");
> +		goto err_put_fwnodes;
> +	}
> +
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
> +
> +	/* Release global PHY power down */
> +	ret = regmap_write(regmap, AN8855_RG_GPHY_AFE_PWD, 0x0);
> +	if (ret)
> +		goto err_put_fwnodes;
> +
> +	/* Register PHYs */
> +	for (i = 0; i < num_phys; i++) {
> +		ret = fwnode_mdiobus_register_phy(phy_bus_infos[i].bus,
> +						  phy_bus_infos[i].node,
> +						  phy_bus_infos[i].addr);
> +		fwnode_handle_put(phy_bus_infos[i].node);
> +		phy_bus_infos[i].node = NULL;
> +
> +		if (ret)
> +			goto err_put_fwnodes;
> +	}
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_cells,
> +				    ARRAY_SIZE(an8855_cells), NULL, 0,
> +				    NULL);
> +
> +err_put_fwnodes:
> +	for (i = 0; i < num_phys; i++)
> +		if (phy_bus_infos[i].node)
> +			fwnode_handle_put(phy_bus_infos[i].node);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id an8855_core_of_match[] = {
> +	{ .compatible = "airoha,an8855" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, an8855_core_of_match);
> +
> +static struct mdio_driver an8855_core_driver = {
> +	.probe = an8855_core_probe,
> +	.mdiodrv.driver = {
> +		.name = "an8855",
> +		.of_match_table = an8855_core_of_match,
> +	},
> +};
> +mdio_module_driver(an8855_core_driver);
> +
> +MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
> +MODULE_DESCRIPTION("Driver for Airoha AN8855");
> +MODULE_LICENSE("GPL");

[Severity: Low]
This isn't a functional problem, but the MFD convention is to name the
private data structure after the device and to call the instance
ddata, rather than using generic names like priv or info.

Here the core state is struct an8855_core_priv, the per-PHY context is
struct an8855_phy_priv, and an8855_core_probe(), the switch regmap
callbacks and an8855_phy_bus_register() all name the instance priv.
In an8855_regmap_phy_read() and an8855_regmap_phy_write(), priv is
the PHY context while core_priv is the core state, which makes it easy
to mix up which structure a given priv refers to.

Could struct an8855_core_priv be renamed after the device, e.g. struct
an8855 with a ddata instance, and the PHY context be given a matching
device-based name?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
