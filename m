Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203D053ED16;
	Tue, 29 Sep 2026 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714110; cv=none; b=WatKFB54bY+qaeOroMo2RgibhQDwKDIIjMfmUt/vUY1TbTC+BIqC8sjOtkj1JJzfpVn3rEZnKgU7W3JifFcOfBuYrt4y+2s126Nedi7+wmBgxkDHO1qG5t4sOvb1D0khvFaHwft5pBbd/QgEdswPYxEL0R5iJq8jCggVGzAF3d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714110; c=relaxed/simple;
	bh=sntOCRPfpuZhRWowwbN9eKW6zC699L8aBoT4xuxrfy4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bFB/xfAqtF/b37nuC/jp54LqKelQJWmHdU7oV0fqzfwMviUveFWI4tb1UgZdip0lLcbRbsmu9lteALYujrn1mH1OUaqS7ixsnBdGZi3optHW3ijMw348HS83tqPq87zPM3zA59VjDhY0DlfDBOU05ALA8sXxsPlQo61TB3rnVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAdzN05t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAdzN05t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE61C1F00893;
	Tue, 29 Sep 2026 20:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790714107;
	bh=oSWEFYjfZmr8QmGqbYwe/fQqLI1DvcpISskDycLy0M0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lAdzN05t9naETR8e0U1gYogtIBDpnotit40QruYAznADHwNIRCNpLLuRw4C6X34Qs
	 Cm2vbj407kee0s+sXNewE0Oloq61kPJ5E2eVU9yJRQ215tAqefB0kqvM6IWhDxHiG2
	 TxHM89G/DSJgrZ4+T5ZvCRoLUl8jY7uTHRqoar7fA7dELZQInShO8w18Lx1t2IPr/6
	 DbxajA+r0+xcln6osblq8wo7AzDOkPg/uV8cghtCl9Vbsumv0nV5ciXfvO6KPjnHR4
	 nS/yWeycW8c0BD793U2RMxTblCCSStMUzDHo091FAbLA/WUQs8dDLqde+8qwzSuzWc
	 1a9NMMkANqm9A==
Subject: Re: [PATCH net-next v23 5/9] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
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
Date: Tue, 29 Sep 2026 20:35:05 +0000
Message-ID: <179071410542.434549.16347188233314238552@kernel.org>
In-Reply-To: <20260925182435.21207-6-ansuelsmth@gmail.com>
References: <20260925182435.21207-6-ansuelsmth@gmail.com>
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

Critical: 0 · High: 0 · Medium: 4 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The downshift tunable accepts retry counts the hardware cannot
  program and reports a sentinel as the count.
- [Medium] Probe fails, and the driver never binds, when the DT has
  "nvmem-cells" but NVMEM support or the AN8855 efuse provider is…
- [Medium] The PHY binding example contradicts the driver and bus.
- [Medium] net: phy: air_an8855: register clobbering in
  AN8855_PHY_RXADC_REV registers

--

net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY

This commit adds a PHY driver for the internal gigabit PHYs of the Airoha
AN8855 switch. At probe time it reads R50 ohm calibration values from NVMEM
cells. In config_init it applies them together with downshift and
noise-reduction settings.

> diff --git a/drivers/net/phy/air_an8855.c b/drivers/net/phy/air_an8855.c
> new file mode 100644
> index 0000000000000..bc22256fd5f95
> --- /dev/null
> +++ b/drivers/net/phy/air_an8855.c
> @@ -0,0 +1,275 @@

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
Do these two writes also clear the B and D reserve fields?

phy_write_mmd() writes the whole 16-bit register. The value written to
AN8855_PHY_RXADC_REV_0 is 0x0100. That sets AN8855_PHY_RG_AD_RESERVE0_A
to 0x1, but it also forces AN8855_PHY_RG_AD_RESERVE0_B (bits 7:0) to
zero. AN8855_PHY_RXADC_REV_1 has the same problem: only
AN8855_PHY_RG_AD_RESERVE0_C is meant to be set, but
AN8855_PHY_RG_AD_RESERVE0_D ends up zeroed as well.

The rest of the noise-reduction sequence in an8855_config_init() only
touches pairs A and C:

- AN8855_PHY_TX_PAIR_DLY_SEL_GBE is updated with phy_modify_mmd(),
  masking only the A and C delay fields.
- AN8855_PHY_RXADC_CTRL uses phy_set_bits_mmd() for the A and C phase
  select bits.

The B and D masks are defined but never used.

Writing the REV registers wholesale breaks that pattern. It overwrites
the hardware reset defaults in the B and D reserve fields, which could
change RX ADC behaviour on those pairs. This happens every time
phy_init_hw() runs config_init, not just once at first attach.

If B and D should keep their defaults, could these be phy_modify_mmd()
calls with AN8855_PHY_RG_AD_RESERVE0_A and AN8855_PHY_RG_AD_RESERVE0_C
as the masks? If the vendor sequence really writes the full register,
could a comment say so?

[Severity: Medium]
Can this probe fail on configurations where the NVMEM cells cannot be read?

needs_calibration depends only on whether "nvmem-cells" is present in the
DT. an8855_probe() returns any error from an8855_get_r50ohm_val().

NVMEM is a bool symbol, so the Kconfig line added in this patch is always
true and has no effect:

    depends on NVMEM || !NVMEM

With CONFIG_NVMEM=n, the stub in include/linux/nvmem-consumer.h is used, so
probe fails with -EOPNOTSUPP:

static inline int nvmem_cell_read_u32(struct device *dev,
				      const char *cell_id, u32 *val)
{
	return -EOPNOTSUPP;
}

With CONFIG_NVMEM=y, the only provider for these cells is
NVMEM_AN8855_EFUSE in drivers/nvmem/Kconfig. It currently has only "depends
on COMPILE_TEST", and nothing in this series changes that. On a
non-COMPILE_TEST config the provider can't be built. nvmem_cell_read_u32()
then keeps returning -EPROBE_DEFER, and this driver never probes.

In both cases, a DT that follows the MFD binding example leaves this driver
unbound, because that example puts nvmem-cells on every PHY.
phy_attach_direct() then falls back to genphy. The downshift and
noise-reduction settings in an8855_config_init() are lost as well, even
though they don't need NVMEM.

Could the calibration be skipped, perhaps with a warning, when the cells are
unavailable? And could the Kconfig dependency reflect what is actually
required?

> +
> +		ret = an8855_get_r50ohm_val(dev, "tx_b", &priv->calibration_data[1]);
> +		if (ret)
> +			return ret;

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
Are retry counts other than enable/disable silently accepted here?

an8855_set_downshift() maps every non-zero cnt to the same enable bit and
returns success. For ETHTOOL_PHY_DOWNSHIFT, ethtool_phy_tunable_valid() in
net/ethtool/ioctl.c only checks len and type_id, so any u8 value reaches
this function. For example, this succeeds without applying a count of 3:

    ethtool --set-phy-tunable ethX downshift on count 3

On the read side, an8855_get_downshift() reports
DOWNSHIFT_DEV_DEFAULT_COUNT (0xff) whenever the bit is set.
DOWNSHIFT_DEV_DEFAULT_COUNT is an input sentinel that means "use the default
count", so a later get shows userspace a count of 255.

Other phylib drivers reject counts they can't program. For example,
bcm54140_set_downshift() does:

	if (cnt > BCM54140_MAX_DOWNSHIFT && cnt != DOWNSHIFT_DEV_DEFAULT_COUNT)
		return -EINVAL;

Could this driver return -EINVAL for counts it can't program, and report the
count the hardware actually uses on get?

[ ... ]

> +static struct phy_driver an8855_driver[] = {
> +{
> +	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
> +	.name			= "Airoha AN8855 internal PHY",
> +	/* PHY_GBIT_FEATURES */
> +	.flags			= PHY_IS_INTERNAL,
> +	.probe			= an8855_probe,
> +	.config_init		= an8855_config_init,
> +	.soft_reset		= genphy_soft_reset,
> +	.get_tunable		= an8855_get_tunable,
> +	.set_tunable		= an8855_set_tunable,
> +	.suspend		= genphy_suspend,
> +	.resume			= genphy_resume,
> +	.read_page		= an8855_read_page,
> +	.write_page		= an8855_write_page,
> +}, };

[Severity: Medium]
This one is in another patch of the series, "dt-bindings: net: Document
support for AN8855 Switch Internal PHY". Both PHY nodes in that binding
example use:

    compatible = "ethernet-phy-idc0ff.0410",
                 "ethernet-phy-ieee802.3-c45";

Would a DT written from that example make the whole switch fail to probe?

fwnode_mdiobus_register_phy() sets is_c45 from that compatible. When is_c45
is set, it ignores the explicit PHY ID:

	is_c45 = fwnode_device_is_compatible(child, "ethernet-phy-ieee802.3-c45");
	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
		phy = get_phy_device(bus, addr, is_c45);

The per-PHY bus comes from devm_mdio_regmap_register(), which only installs
C22 ops:

	mii->read = mdio_regmap_read_c22;
	mii->write = mdio_regmap_write_c22;

So get_phy_c45_ids()->get_phy_c45_devs_in_pkg()->mdiobus_c45_read() gets
-EOPNOTSUPP. That becomes -EIO, and an8855_core_probe() aborts.

This driver is Clause 22 only: paged access through register 0x1f,
genphy_soft_reset(), and PHY_ID_MATCH_EXACT() on the C22 ID. The MFD binding
example already uses "ethernet-phy-ieee802.3-c22".

Should the PHY binding example use "ethernet-phy-ieee802.3-c22" as well?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260925182435.21207-1-ansuelsmth%40gmail.com
