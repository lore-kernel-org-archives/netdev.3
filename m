Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F47569F03;
	Tue, 29 Sep 2026 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714107; cv=none; b=QWGJrE+qaP+DiJO1pgXzHF7KBJUjhKYwjRRNdpOsFHaQ8m26kgaxtCLjhNcaZEQwIzGbZpe2INNT3lwp/dVRaU3a83ki+8hLSWyaO+syGzFVwxLKbwHs/9FTfde2OiiKTtL2JNHTfwoZ7pyuuJAxcR4KJ0wIMCSWLoxUWq9AMF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714107; c=relaxed/simple;
	bh=jPNbY5lpqzfPPtWPO7h5DF80kNPc6lnAUFm9SriLG6E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsaBaW6koU0DQnqKnbQO6EWUQebAyJ5E2W7iVfS8xs5Gn09pQw+zLihWRICBkuuuSIJITkHedrMmUhac0vkCF5uvunT01ZHdgnbGHCfILA6OzjB/h5O0bsaNyOce4gUGfv4pU0j8sJmQ92Ld0Uh7nQ6Y2fEX6pkH/VBJUqK0rqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BRFsVLAl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRFsVLAl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E441F000FF;
	Tue, 29 Sep 2026 20:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714105;
	bh=vCqxuTumssfBQgUpcKI0fXxSIr+yQ5dPzt7xGcvzVvs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BRFsVLAlmnrixGhNpvhghu8oj1Bo8WxT8UtWf2meIFdvmWKDIl06PxV0jKw5/3WXz
	 D7MqZs7k0zk2YpEpK/+hFNYkyQcl4h6lo5f3Yy7Zo8x00xXb7+NcNccHHhEVJDwqLW
	 Iz6jIBYs7bP0DUDT27MGlhHsFkysutLZn9b9CWzp8oXD5+bT76cCxsyysZQ/zRex1G
	 6FDa/QsoE5zFXdE0pTxaI6Wen2h8/n3Gu9qnNvK6W8uZ4CZWC4fl/pgo3TPG4NYOJb
	 ltEgRxlwpP+apb9npCWokeVelan1BcXGoVmiUPD+1xo+RNrDT0lh84O/s/i90hEIof
	 B7heTcniz9cBw==
Subject: Re: [PATCH net-next v23 4/9] mfd: an8855: Add support for Airoha
 AN8855 Switch
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 Sep 2026 20:35:03 +0000
Message-ID: <179071410366.434549.18339242720142610191@kernel.org>
In-Reply-To: <20260925182435.21207-5-ansuelsmth@gmail.com>
References: <20260925182435.21207-5-ansuelsmth@gmail.com>
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

Critical: 0 · High: 0 · Medium: 5 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds MFD_AIROHA_AN8855, and both the commit message
  and the Kconfig help say this MFD provides an NVMEM provider.
- [Medium] an8855_phy_bus_register() names each virtual MDIO bus with
  snprintf(mrc.name, MII_BUS_ID_SIZE, "an8855:%u-phy%u",…
- [Medium] an8855_phy_bus_register() reads the PHY address from DT "reg"
  and only checks `phy_offset = addr - priv->switch_addr; if (phy_offset…
- [Medium] In an8855_mdio_register(), of_node_put(mdio_np) comes before
  the 'exit:' label.
- [Medium] The MFD binding puts `reset-gpios` on the core `airoha,an8855`
  node, and its example wires `reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>`.
- [Low] The MFD binding (airoha,an8855.yaml) leaves the 'efuse' child
  optional: required is compatible, reg, mdio, ethernet-switch.
- [Low] Both examples in the AN8855 PHY binding (airoha,an8855-phy.yaml)
  use "ethernet-phy-idc0ff.0410", "ethernet-phy-ieee802.3-c45".
- [Low] an8855_core_probe() clears AN8855_RG_GPHY_AFE_PWD ("Release
  global PHY power down") before registering the PHYs and the MFD…

--

mfd: an8855: Add support for Airoha AN8855 Switch

This adds an MFD core driver for the Airoha AN8855 switch, which is
accessed over MDIO. It adds a paged regmap for the switch registers and
one mdio-regmap bus for each internal PHY. It also registers eFuse and
DSA switch child cells.

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
The help text and the commit message both say this provides an NVMEM
provider. However, NVMEM_AN8855_EFUSE in drivers/nvmem/Kconfig still
only has:

	depends on COMPILE_TEST

It was reduced to that by commit 4796eaafd6a1 ("nvmem: an8855: drop an
unused Kconfig symbol"), because MFD_AIROHA_AN8855 was referenced but
never defined.

Now that this patch defines the symbol, should the nvmem entry go back
to "depends on MFD_AIROHA_AN8855 || COMPILE_TEST"? NET_DSA_AN8855, added
later in the series, already uses that form.

As it stands, the eFuse driver can't be enabled when COMPILE_TEST is not
set. That leaves the an8855-efuse cell with no driver to bind. The PHY
nodes' nvmem-cells (tx_a..tx_d) then point at a provider that never
registers, so an8855_probe()->an8855_get_r50ohm_val() in the AN8855 PHY
driver can't get its calibration cells.

[ ... ]

> diff --git a/drivers/mfd/airoha-an8855.c b/drivers/mfd/airoha-an8855.c
> new file mode 100644
> index 0000000000000..a2a36704a9fca
> --- /dev/null
> +++ b/drivers/mfd/airoha-an8855.c
> @@ -0,0 +1,580 @@

[ ... ]

> +static const struct mfd_cell an8855_cells[] = {
> +	MFD_CELL_OF("an8855-efuse", NULL, NULL, 0, 0,
> +		    "airoha,an8855-efuse"),

[Severity: Low]
The MFD binding (airoha,an8855.yaml) makes the efuse child optional. Its
required list is compatible, reg, mdio and ethernet-switch. This cell is
still registered every time.

When the DT has no efuse node, won't mfd_add_device() print a "Failed to
locate of_node" warning and register the platform device anyway? The
efuse driver would then bind by platform name and register an NVMEM
device that the DT never described.

> +	MFD_CELL_OF("an8855-switch", NULL, NULL, 0, 0,
> +		    "airoha,an8855-switch"),
> +};

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
Is addr ever checked against PHY_MAX_ADDR? The only check here is
relative to switch_addr. If the switch sits at MDIO address 28..31, a
child reg of 32..35 passes.

That addr goes straight to fwnode_mdiobus_register_phy() in
an8855_core_probe(), which skips the of_mdio_parse_addr() check done on
the normal OF MDIO path. For a C22 compatible such as
ethernet-phy-idc0ff.0410, the call chain is:

an8855_core_probe()
  fwnode_mdiobus_register_phy(bus, node, addr)
    phy_device_create(bus, addr, ...)
      dev->irq = bus->irq[addr];
    fwnode_mdiobus_phy_device_register()
      mdio->irq[addr] = rc;
      mdio->phy_ignore_ta_mask |= 1 << addr;
      phy_device_register()
        mdiobus_register_device()
          mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;

Could this read and write past the end of bus->irq[] and
bus->mdio_map[]? Those writes could overwrite later fields of struct
mii_bus, such as reset_delay_us, reset_post_delay_us or reset_gpiod.

Such a DT would violate mdio.yaml (reg maximum 31), but nothing enforces
that at runtime.

[ ... ]

> +	mrc.regmap = regmap;
> +	mrc.parent = dev;
> +	mrc.valid_addr = addr;
> +	snprintf(mrc.name, MII_BUS_ID_SIZE, "an8855:%u-phy%u", priv->switch_addr,
> +		 phy_offset);
> +
> +	bus = devm_mdio_regmap_register(dev, &mrc);
> +	if (IS_ERR(bus))
> +		return PTR_ERR(bus);

[Severity: Medium]
Can two AN8855 chips on different host MDIO buses end up with the same
mii_bus name? The name is built only from switch_addr and phy_offset.
Two switches at the same address on two MACs would therefore both
produce the same "an8855:<addr>-phy<n>" names.

devm_mdio_regmap_register() copies this into mii->id, and
__mdiobus_register() then does:

	dev_set_name(&bus->dev, "%s", bus->id);

The bus is in mdio_bus_class, so the second device_add() looks like it
would fail with -EEXIST. The whole second an8855_core_probe() would fail
with it. PHY device names built with PHY_ID_FMT would collide in the
same way.

Could the name include something unique to the parent, such as
dev_name(dev)?

[ ... ]

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
> +	of_node_put(mdio_np);
> +exit:

[Severity: Medium]
Does this leak the reference on mdio_np taken by
of_get_child_by_name()? of_node_put(mdio_np) sits above the exit label.
Both gotos inside the loop skip it: the one for too many children and
the one for an8855_phy_bus_register() failing.

This function also mixes goto-based cleanup with the __free(device_node)
scoped iterator from for_each_available_child_of_node_scoped().
include/linux/cleanup.h asks that goto and cleanup helpers not be mixed
in the same function.

Would declaring mdio_np with __free(device_node) and dropping the gotos
fix both?

[ ... ]

> +static int an8855_core_probe(struct mdio_device *mdiodev)
> +{

[ ... ]

> +	/* Reset PHY page for switch address */
> +	mutex_lock_nested(&priv->bus->mdio_lock, MDIO_MUTEX_NESTED);
> +	ret = an8855_mii_set_page(priv, priv->switch_addr,
> +				  AN8855_PHY_PAGE_STANDARD);

[Severity: Medium]
The MFD binding documents reset-gpios on the airoha,an8855 node, and its
example uses reset-gpios = <&pio 39 GPIO_ACTIVE_HIGH>. Does anything
request or deassert that GPIO before this first MDIO access?

an8855_core_probe() doesn't touch it. mdiobus_register_device() only
sets up reset for MDIO_DEVICE_FLAG_PHY devices, so mdio_device_reset()
in mdio_probe() does nothing for this mdio_device. The DSA driver at the
end of the series doesn't handle the reset line either.

There is also no wait for the chip to finish its internal init before
the page select, the CREV read and the AFE_PWD write.
linux/gpio/consumer.h is included but unused, and so is this define:

#define AN8855_HWTRAP			0x1000009c

Was a reset and HWTRAP poll sequence lost when this code moved into the
MFD? On boards where reset is still asserted at boot, it looks like
an8855_read_switch_id() would fail and the switch would be unusable.

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

[Severity: Low]
Nothing appears to set the AN8855_RG_GPHY_AFE_PWD bits again later.
fwnode_mdiobus_register_phy() or devm_mfd_add_devices() can still fail
after this write. The err_put_fwnodes path only drops fwnode references,
and there is no .remove callback or devm action for unbind.

Should power down be restored on those paths, so the PHY analog front
ends aren't left powered with no driver managing the ports?

> +
> +	/* Register PHYs */
> +	for (i = 0; i < num_phys; i++) {
> +		ret = fwnode_mdiobus_register_phy(phy_bus_infos[i].bus,
> +						  phy_bus_infos[i].node,
> +						  phy_bus_infos[i].addr);

[Severity: Low]
Both examples in Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
use:

compatible = "ethernet-phy-idc0ff.0410",
             "ethernet-phy-ieee802.3-c45";

The buses created by devm_mdio_regmap_register() only provide C22
read/write callbacks. With that compatible, fwnode_mdiobus_register_phy()
does:

	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
		phy = get_phy_device(bus, addr, is_c45);

The explicit PHY ID is then ignored. get_phy_c45_ids() fails because
__mdiobus_c45_read() returns -EOPNOTSUPP when bus->read_c45 is not set.

Would a DT copied from that example make the whole an8855_core_probe()
fail? The MFD binding example uses the c22 compatible, so the two
bindings seem to disagree.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182435.21207-1-ansuelsmth%40gmail.com
