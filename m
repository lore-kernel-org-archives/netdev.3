Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD7538889B;
	Thu,  1 Oct 2026 04:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829944; cv=none; b=Xm6z4tzK41VKeXJwFFC+C2uLzEUGdYaEkMiTcKk3/PQHEI3PjU9p3LJLJM9hgiwb1SwQ8/QKtK9qOiipSpOo79ZtOKcA/grroHp1nHclZ6cqkHKjdTbGYyNrC2AaLWZT+M6V/K1V5W+TQX1lC6AId+LfL8Gl6zd4guk83h6sGsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829944; c=relaxed/simple;
	bh=ODZS/Q2eQbrlK1+++1UGdiBIu66+ksfQZV0wIIoHERg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YuZiHHBlWFZAZ83s0JJmfrXP5Fw5/5V/AiQ/OEbsDXZMsqcxQHnJESOqvZ4C5CgOVUEMAmc+wsH9v4Nesrn9U2hiCts40W+Holo9wCOBBTtsqPEgThrFU/gs8HUXaJlNFbDjxpOclNmclflf2eM+HDdP90RhE2OhDCr1YDckB70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwETA3tA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwETA3tA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3E81F00898;
	Thu,  1 Oct 2026 04:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829935;
	bh=jbBNnWauchjOMUzr+fC0Pnm39itZoZ+bc1SPcjlo84o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AwETA3tAgYYOeKTHo0JgTM2qr8F4OarIatCCcyTSqdMaSHzuYndHu07tgL5Ict10Q
	 g6gvUfaJA557O7fpK9ls75MWnyT9bEGKVeqt3NS7CdOSAucwEb40wXSfPlxJF9LbTD
	 OCqnDscTljap4skm33wvzyxHfK5OQLb3FIlm1RAT7GZCn4XDuBw+qjwyFQc9S8euBF
	 pFVjAWaFjEU0jlSnZcwe0iX/0k7E1IpsuB1yczZcH3nn7HDuMgbEwVajAWiwAtzU/7
	 r+XkUu6RugnL0SwJ/MMSz7/eio7W7+L4V9yIbVnIR3BL2aSwFCf0IZHpK7p2YNWlD2
	 LawutL4BaZQHw==
Subject: Re: [PATCH net-next v24 05/10] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
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
Date: Thu, 01 Oct 2026 04:45:33 +0000
Message-ID: <179082993386.434549.17771239887397045153@kernel.org>
In-Reply-To: <20260928194511.41878-6-ansuelsmth@gmail.com>
References: <20260928194511.41878-6-ansuelsmth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] an8855_probe() (drivers/net/phy/air_an8855.c) reads the four
  eFUSE NVMEM cells in .probe and returns any error as a probe failure.
- [Medium] AIR_AN8855_PHY has 'depends on NVMEM || !NVMEM'
  (drivers/net/phy/Kconfig:101), so CONFIG_NVMEM=n is an explicitly…
- [Medium] The ETHTOOL_PHY_DOWNSHIFT tunable does not follow the retry-
  count ABI.
- [Low] The PHY binding added in the series (commit "dt-bindings: net:
  Document support for AN8855 Switch Internal PHY",…

--

net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY

This adds a phylib driver for the internal gigabit PHYs of the Airoha
AN8855 switch. At probe time it reads per-pair R50 calibration values
from eFUSE NVMEM cells. config_init then applies them, along with
noise-reduction tuning and HW downshift enable, and the downshift tunable
is exposed through ethtool.

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index d3835597e3795..eca2ce135c86b 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -96,6 +96,12 @@ config AIR_AN8801_PHY
>  	help
>  	  Currently supports the Airoha AN8801R PHY.
>  
> +config AIR_AN8855_PHY
> +	tristate "Airoha AN8855 Internal Gigabit PHY"
> +	depends on NVMEM || !NVMEM

[Severity: Medium]
This dependency allows a CONFIG_NVMEM=n build. In that build
nvmem_cell_read_u32() is the inline stub:

include/linux/nvmem-consumer.h:
static inline int nvmem_cell_read_u32(struct device *dev,
				      const char *cell_id, u32 *val)
{
	return -EOPNOTSUPP;
}

an8855_probe() still sets needs_calibration from
of_property_present(dev->of_node, "nvmem-cells"). It then returns the
-EOPNOTSUPP from an8855_get_r50ohm_val() as a probe failure.

nvmem-cells is optional in airoha,an8855-phy.yaml, and the MFD binding
example puts nvmem-cells on every PHY. On an NVMEM=n kernel, would a
DT that follows the binding leave every port bound to genphy instead of
this driver?

That would also drop the noise-reduction writes and the downshift setup
in an8855_config_init(), and neither of those depends on NVMEM.

Could probe treat -EOPNOTSUPP and -ENOENT as "no calibration" and
continue? dp83867_of_init_io_impedance() does this:

	if (ret != -ENOENT && ret != -EOPNOTSUPP)
		return phydev_err_probe(phydev, ret, ...);

> +	help
> +	  Currently supports the internal Airoha AN8855 Switch PHY.

[ ... ]

> diff --git a/drivers/net/phy/air_an8855.c b/drivers/net/phy/air_an8855.c
> new file mode 100644
> index 0000000000000..bc22256fd5f95
> --- /dev/null
> +++ b/drivers/net/phy/air_an8855.c

[ ... ]

> +static int an8855_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct air_an8855_priv *priv;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->needs_calibration = of_property_present(dev->of_node,
> +						      "nvmem-cells");
> +
> +	if (priv->needs_calibration) {
> +		int ret;
> +
> +		ret = an8855_get_r50ohm_val(dev, "tx_a", &priv->calibration_data[0]);
> +		if (ret)
> +			return ret;

[Severity: Medium]
Can this succeed on the first probe? an8855_core_probe() in
drivers/mfd/airoha-an8855.c registers the PHYs before it creates the
eFUSE provider cell:

drivers/mfd/airoha-an8855.c:an8855_core_probe() {
    ...
	/* Register PHYs */
	for (i = 0; i < num_phys; i++) {
		ret = fwnode_mdiobus_register_phy(phy_bus_infos[i].bus,
						  phy_bus_infos[i].node,
						  phy_bus_infos[i].addr);
    ...
	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, an8855_cells,
				    ARRAY_SIZE(an8855_cells), NULL, 0,
				    NULL);
}

So nvmem_cell_read_u32() here would return -EPROBE_DEFER on the first
probe of every PHY node that has nvmem-cells.

The DSA switch cell is added in the same devm_mfd_add_devices() call,
and fw_devlink does not follow phy-handle. If the switch attaches the
PHY while this driver is still deferred, phy_attach_direct() takes its
fallback:

	if (!d->driver) {
		if (phydev->is_c45)
			d->driver = &genphy_c45_driver.mdiodrv.driver;
		else
			d->driver = &genphy_driver.mdiodrv.driver;

Would genphy then stay bound? If so, the R50 calibration, the
noise-reduction writes and the downshift setup would all be skipped
with no error.

There is also a Kconfig problem. NVMEM_AN8855_EFUSE in
drivers/nvmem/Kconfig currently has:

config NVMEM_AN8855_EFUSE
	tristate "Airoha AN8855 eFuse support"
	depends on COMPILE_TEST

On a non-COMPILE_TEST kernel with CONFIG_NVMEM=y the provider can never
exist. Would a DT that follows the MFD binding example then defer here
forever and always end up on genphy?

Should a missing provider fall back to running uncalibrated? Or should
AIR_AN8855_PHY be tied to the eFUSE provider in Kconfig?

[ ... ]

> +static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
> +{
> +	int val;
> +
> +	val = phy_read_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1, AN8855_PHY_EXT_REG_14);
> +	if (val < 0)
> +		return val;
> +
> +	*data = val & AN8855_PHY_EN_DOWN_SHIFT ? DOWNSHIFT_DEV_DEFAULT_COUNT :
> +						 DOWNSHIFT_DEV_DISABLE;
> +
> +	return 0;
> +}
> +
> +static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
> +{
> +	u16 ds = cnt != DOWNSHIFT_DEV_DISABLE ? AN8855_PHY_EN_DOWN_SHIFT : 0;
> +
> +	return phy_modify_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
> +				AN8855_PHY_EXT_REG_14, AN8855_PHY_EN_DOWN_SHIFT,
> +				ds);
> +}

[Severity: Medium]
Do these follow the downshift retry-count ABI?

an8855_set_downshift() accepts any count from 1 to 254 and reduces it
to the single AN8855_PHY_EN_DOWN_SHIFT bit. It returns success even
though the hardware keeps its own fixed retry threshold.
ethtool_phy_tunable_valid() only checks length and type, so nothing
else rejects the value.

On the get side, an8855_get_downshift() reports
DOWNSHIFT_DEV_DEFAULT_COUNT (0xff) whenever the bit is set. That value
is a set-side sentinel, so ethtool would show "Downshift count: 255".
A set of 3 followed by a get would not read back 3.

Other drivers map the sentinel to a concrete count and reject counts
they cannot program. For example, bcm54140_set_downshift() does:

	if (cnt > BCM54140_MAX_DOWNSHIFT && cnt != DOWNSHIFT_DEV_DEFAULT_COUNT)
		return -EINVAL;
	...
	if (cnt == DOWNSHIFT_DEV_DEFAULT_COUNT)
		cnt = BCM54140_DEFAULT_DOWNSHIFT;

microchip.c, mscc_main.c, qcom-phy-lib.c and marvell10g.c work the
same way.

Could this driver report the count the hardware actually uses, and
return -EINVAL for counts it cannot honor?

A smaller point: an8855_config_init() runs on every phy_init_hw() call
(attach and resume) and does:

	/* Enable HW auto downshift */
	ret = an8855_set_downshift(phydev, DOWNSHIFT_DEV_DEFAULT_COUNT);

So a user's "downshift off" setting is re-enabled after resume. mtk-ge.c
and marvell10g.c do the same, so this part may be acceptable.

[ ... ]

> +static struct phy_driver an8855_driver[] = {
> +{
> +	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
> +	.name			= "Airoha AN8855 internal PHY",
> +	/* PHY_GBIT_FEATURES */
> +	.flags			= PHY_IS_INTERNAL,

[ ... ]

> +	.read_page		= an8855_read_page,
> +	.write_page		= an8855_write_page,
> +}, };

[Severity: Low]
This one is in another patch in the series, but it affects how this
driver gets probed. The examples in the PHY binding
(Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml) use:

    compatible = "ethernet-phy-idc0ff.0410",
                 "ethernet-phy-ieee802.3-c45";

mfd/airoha,an8855.yaml uses "ethernet-phy-ieee802.3-c22" for the same
PHYs. The driver and the bus are both Clause 22 only, since
devm_mdio_regmap_register() sets only mii->read and mii->write.

If a DT copies the PHY binding example, fwnode_mdiobus_register_phy()
sees the c45 compatible:

	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
		phy = get_phy_device(bus, addr, is_c45);

Wouldn't get_phy_c45_ids() then fail with -EIO on this C22-only bus?
That would make an8855_core_probe() fail for the whole MFD (switch,
PHYs and eFUSE).

Should the example use "ethernet-phy-ieee802.3-c22" instead?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
