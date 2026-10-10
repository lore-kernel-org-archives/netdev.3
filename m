Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8233D6F7;
	Sat, 10 Oct 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649162; cv=none; b=rcKugEyaKd2krsRqR8SMJTZoaYORbtVP4xCjTJdHi4DyUEf2YiQCJzzTmYSfyWlQffWrosKUGXZ3gnCbI1tAUzWdSmUBKD6GcsZCXGLuvYYsvAZVToS45HeisPvoa3qD3PanqKo1pUbGWOUh6Y+/s2zIPPFbYPqh0gPU/Y0ck60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649162; c=relaxed/simple;
	bh=CIwPNZSs5zJIyMSM+FDFWrmaIERPNxwvzF6kZra4IIA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pekrJUVtVyiIvCbZGSjDQBoUavSIgt0WG1nQWi65aaUSLUVylkrrU6+HvvjUY5HGZfBNm0nGzQHwYX6XYCqniwDfr7OKv0lsXhOGGTGrv+XvhanYnSfIyAyxrOVptClmzs5fOnMCuCC7DcHR1186ozkDkunEvZQgrT6Ff84jccc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By0wQmGo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By0wQmGo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672B41F000FF;
	Sat, 10 Oct 2026 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649160;
	bh=MuD/r2Z34tb6m4g3UJEPGTUz4GYaUXIuZUMsYmydmBs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=By0wQmGoY7coAsrJHB3mbrHxSxChu3BpmYA6q7LXt59aYDa3MU7VPH5Vga4RhukxK
	 OMmym8Ss2pahH16bXHrsWysRWvixAa70cteX1QEf+phM9WTRDaVruGpwXNq81/ZlTw
	 Rm6KNQV3LIQPkwRNb+1lq09OPH3Hv74e435Q1qQiZvpC3801Bjt3X88Kl0L+OnrjoC
	 qhZY+mxAt0RZTpgw970NTMRBWtffLBXJMt4ZIIzGenO5k2x6ETPGSiIROIDf2hHMnr
	 KQf+xtcA2cy+YafnwMiivh0HSi/37QRH4zlVcOSxeMTawCq8HhWFUdc2rolM0iXMwI
	 iv5T/IHltcQ0Q==
Subject: Re: [PATCH net-next v25 05/10] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
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
Date: Sat, 10 Oct 2026 16:19:18 +0000
Message-ID: <179164915893.434549.4040400769427326012@kernel.org>
In-Reply-To: <20261009161102.38961-6-ansuelsmth@gmail.com>
References: <20261009161102.38961-6-ansuelsmth@gmail.com>
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

- [Medium] The commit says the driver calibrates the AN8855 PHY from
  NVMEM cells, but the only provider of those cells cannot be enabled in…
- [Medium] The ETHTOOL_PHY_DOWNSHIFT tunable does not round-trip.
- [Medium] The PHY binding added in this series and the rest of the stack
  disagree on Clause 22 vs Clause 45.
- [Medium] net: phy: air_an8855: phy_write_mmd clobbers adjacent reserved
  fields

--

net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY

This adds a PHY driver for the internal Gigabit PHYs in the Airoha AN8855
switch. At probe time it reads R50 calibration values from NVMEM cells. In
config_init it applies them together with some noise reduction settings,
and it also exposes the downshift tunable.

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
Can this probe succeed on a kernel built without COMPILE_TEST when the DT
has nvmem-cells? The MFD binding example has them on every PHY.

The only provider of these cells is NVMEM_AN8855_EFUSE. In
drivers/nvmem/Kconfig it currently has:

config NVMEM_AN8855_EFUSE
	...
	depends on COMPILE_TEST

Commit 4796eaafd6a1 ("nvmem: an8855: drop an unused Kconfig symbol")
removed the MFD_AIROHA_AN8855 alternative because that symbol did not
exist yet.

This series adds MFD_AIROHA_AN8855 in "mfd: an8855: Add support for Airoha
AN8855 Switch". The "MFD_AIROHA_AN8855 ||" part of that dependency doesn't
seem to be added back anywhere in the series.

With NVMEM=y, an8855_get_r50ohm_val()->nvmem_cell_read_u32() ends up in
nvmem_device_match(). That never finds a provider and returns
-EPROBE_DEFER, so the probe defers forever.

With NVMEM=n, which the new "depends on NVMEM || !NVMEM" in
drivers/net/phy/Kconfig allows, the inline nvmem_cell_read_u32() stub
returns -EOPNOTSUPP and the probe fails.

Either way this driver never binds, and phy_attach_direct() falls back to
genphy when DSA attaches the port. Wouldn't that silently skip the R50
calibration, the noise reduction writes and the downshift enable in
an8855_config_init()?

Could the NVMEM_AN8855_EFUSE dependency on MFD_AIROHA_AN8855 be added back?
Separately, could the -EOPNOTSUPP case let the PHY run uncalibrated
instead of failing the probe?

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

[Severity: Medium]
Does the ETHTOOL_PHY_DOWNSHIFT tunable round-trip correctly?

In an8855_set_downshift(), any count from 1 to 255 returns success. The
requested count is dropped and only the enable bit is set. Counts the
hardware can't honour are never rejected. ethtool_phy_tunable_valid() in
net/ethtool/ioctl.c only checks len and type_id, so range checking is left
to the driver.

In an8855_get_downshift(), DOWNSHIFT_DEV_DEFAULT_COUNT (0xff) is reported
to userspace whenever the enable bit is set. That value is a request
sentinel, not a real retry count.

As a result, "ethtool --set-phy-tunable ethX downshift count 3" succeeds,
and a later get shows "Downshift count: 255".

Other drivers that use DOWNSHIFT_DEV_DEFAULT_COUNT (bcm-phy-lib.c,
bcm54140.c, marvell10g.c, microchip.c, mscc_main.c, qcom-phy-lib.c) map it
to a real count on set and reject counts they can't support. For example,
mv3310_set_downshift() does:

	if (ds == DOWNSHIFT_DEV_DEFAULT_COUNT)
		ds = 2;

None of them return 0xff from get.

[ ... ]

> +static int an8855_config_init(struct phy_device *phydev)
> +{
> +	struct air_an8855_priv *priv = phydev->priv;
> +	int ret;

[ ... ]

> +	/* Apply values to reduce signal noise */
> +	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_TX_PAIR_DLY_SEL_GBE,
> +			     AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_A_GBE |
> +			     AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_C_GBE,
> +			     FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_A_GBE, 0x4) |
> +			     FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_C_GBE, 0x4));

[Severity: Medium]
Do these two writes clear the pair B and D fields?

The other noise reduction settings in an8855_config_init() only touch
pairs A and C. The TX pair delay uses phy_modify_mmd() and the RXADC
sample phase uses phy_set_bits_mmd(), so the B and D fields keep
their reset values.

The two RXADC reserve registers are handled differently.
phy_write_mmd() replaces the whole 16-bit register.

Writing FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_A, 0x1) to
AN8855_PHY_RXADC_REV_0 therefore also sets
AN8855_PHY_RG_AD_RESERVE0_B (bits 7:0) to 0. The write to
AN8855_PHY_RXADC_REV_1 does the same to AN8855_PHY_RG_AD_RESERVE0_D.

config_init runs from phy_init_hw() on every attach and resume, so
this is applied unconditionally. If the reset values of the B and D
fields are not zero, this would change the ADC tuning of pairs B and
D. That doesn't match how the other A/C-only writes in this block are
done.

Is clearing the B and D fields intended, for example because the
vendor code writes these registers as whole values? If so, could the
code say that? If not, should these be phy_modify_mmd() calls that
mask only AN8855_PHY_RG_AD_RESERVE0_A and
AN8855_PHY_RG_AD_RESERVE0_C, like the TX pair delay write above?

[Severity: Medium]
Several parts of this driver assume Clause 22 access:

  - these MMD accesses, which go through C22-indirect access
  - the register 0x1f paging in an8855_read_page() and an8855_write_page()
  - genphy_soft_reset(), genphy_suspend() and genphy_resume()

Is the PHY binding added in this series consistent with that?

Both example nodes in
Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml use:

    compatible = "ethernet-phy-idc0ff.0410",
                 "ethernet-phy-ieee802.3-c45";

The MFD binding example in
Documentation/devicetree/bindings/mfd/airoha,an8855.yaml declares the same
PHY as "ethernet-phy-ieee802.3-c22".

The MDIO bus registered by an8855_core_probe() comes from
devm_mdio_regmap_register(), which only provides C22 accessors:

drivers/net/mdio/mdio-regmap.c:devm_mdio_regmap_register() {
    ...
	mii->read = mdio_regmap_read_c22;
	mii->write = mdio_regmap_write_c22;
    ...
}

If a DT follows the PHY binding example, the path would be:

an8855_core_probe()
  fwnode_mdiobus_register_phy()
    get_phy_device(bus, addr, true)
      get_phy_c45_ids()
        __mdiobus_c45_read()   <- -EOPNOTSUPP, no read_c45

get_phy_c45_ids() turns this into -EIO, and the whole MFD probe fails.

Even if a phydev were created with is_c45 set, wouldn't every
phy_modify_mmd() and phy_write_mmd() in an8855_config_init() take the
unsupported C45 direct access path?

Should the PHY binding examples use "ethernet-phy-ieee802.3-c22" instead?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009161102.38961-1-ansuelsmth%40gmail.com
