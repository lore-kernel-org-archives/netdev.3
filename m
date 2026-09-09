Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3C6534442;
	Wed,  9 Sep 2026 10:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950965; cv=none; b=YG40ckvtogEWn55VOIAw1Ze5mHAtRGVJ43izDFB1Kpv8JC2gq5R+iNKkvH7udClxdVCVYVXNBFLD8g5xQsj6eLgMdvUks5uRd7bD0HHnJUzoSt3WSS13/Ki+5HjYQiDwOLdXNUGU1c/gdk2ItNtwUVI1Eb4OSY2fo97ia7jKkhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950965; c=relaxed/simple;
	bh=NIbN3x2fe3c1+D//EHq/wwGNl7/JKtKpxd3lOinw0FI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtDsL1cFdEfkOPx95+PUivytQvLBcpq/19EM1mZIsVcQquu7a0BTKtKo3ToJkLygYcErM2ODXgXSmjZszXLumw7Rj7KZaoJ1zAT1Tu6vuyRF0sdDSgIiqnx6OB72iQ5MMWtSqR33GrysJ8QUk2ZxpZiIrWPzydkmfGBALKCJMAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfwTXteq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfwTXteq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2451F00A3D;
	Wed,  9 Sep 2026 10:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950962;
	bh=cHJTGnwrRP3s7wqMU5rB0oLtvCJJO/80I5mWj7uMgYw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MfwTXteqSRZJdBaE5H/wIuq5jiss2ozfPMhlN0tMjVAWzRDqBmHkBW6cLH2W9lXCg
	 +EKki7JraHF3YjjpxyQhqVhtlUL7IdRs+Ms3lGILEH6IT1jwWByxsp01zF2OUuoXGc
	 yaS56FPCT0MPN81eYQM5T5A7zhermUJVZa4UCEUFdeUZ6smwltnnetl3Fu2iSUUjDR
	 l8jsEwtEV9lsT3xDCLi3VoR4O7MASZB3QBnGFTkaV3T3V0BXanZaI6zmMdE6yhztMK
	 MnDALnGK1yMgmVzGpRl3ppURJmntZKwkhhtO4yMT4V98MSnTSn2Tj1mtGwH/hOpuvr
	 KZD8FuO+muThw==
Subject:
 Re: [PATCH net-next v10 2/2] net: phy: add X-Powers AC200/AC300 EPHY driver
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, arnd@arndb.de, jedrzej.jagielski@intel.com,
 andre.przywara@arm.com, wens@kernel.org, jernej.skrabec@gmail.com,
 maxime.chevallier@bootlin.com, linux-sunxi@lists.linux.dev,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 09 Sep 2026 10:49:20 +0000
Message-ID: <178895096044.219967.9072892743673097567@kernel.org>
In-Reply-To:
 <20260906-submit-acx00-of-dynamic-v1-v10-2-dd272e03b547@gmail.com>
References: <20260906-submit-acx00-of-dynamic-v1-v10-2-dd272e03b547@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] The AC200 backend cannot function in this tree:
  ac200_ephy_ctl_create() requires the phandle target (x-powers,ac200)…
- [Medium] When acx00_ephy_control_power_off() fails during suspend,
  acx00_ephy_suspend() recovers by calling…
- [Low] The binding and the driver disagree on the width/encoding of the
  'configuration' NVMEM cell.

--

net: phy: add X-Powers AC200/AC300 EPHY driver

This adds a new PHY driver for the Fast Ethernet link PHY inside the
X-Powers AC200 and AC300 companion chips, with two package backends: AC200
control registers reached over an I2C regmap, and AC300 control registers
reached through the PHY package helpers.  A few questions below about the
AC200 provider dependency, the NVMEM configuration cell, and the suspend
error recovery path.

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index b4ef927fd4a67..d3835597e3795 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -484,6 +484,17 @@ config VITESSE_PHY
>  	help
>  	  Currently supports the vsc8244
>  
> +config XPOWERS_ACX00_PHY
> +	tristate "X-Powers AC200/AC300 Ethernet PHY"
> +	depends on COMMON_CLK && NVMEM && OF_MDIO && REGULATOR
> +	depends on I2C || !I2C
> +	select PHY_PACKAGE
> +	help
> +	  Enable the Fast Ethernet PHY driver shared by the X-Powers AC200
> +	  and AC300 companion ICs. The driver configures their common MDIO PHY
> +	  registers and the package-specific AC200 I2C or AC300 MDIO control
> +	  registers.
> +

[ ... ]

> diff --git a/drivers/net/phy/xpowers/ac200.c b/drivers/net/phy/xpowers/ac200.c
> new file mode 100644
> index 0000000000000..afdd2a3dfbe41
> --- /dev/null
> +++ b/drivers/net/phy/xpowers/ac200.c
> @@ -0,0 +1,314 @@

[ ... ]

> +struct acx00_ephy_control *
> +ac200_ephy_ctl_create(struct phy_device *phydev,
> +		      struct device_node *package_node,
> +		      bool has_calibration, u8 calibration)
> +{

[ ... ]

> +	ac200_node = of_parse_phandle(package_node, "x-powers,ac200", 0);
> +	if (!ac200_node)
> +		return ERR_PTR(dev_err_probe(dev, -EINVAL,
> +					     "missing x-powers,ac200 reference\n"));
> +	client = of_find_i2c_device_by_node(ac200_node);
> +	of_node_put(ac200_node);
> +	if (!client) {
> +		ret = IS_ENABLED(CONFIG_I2C) ? -EPROBE_DEFER : -ENODEV;
> +		return ERR_PTR(dev_err_probe(dev, ret,
> +					     "AC200 device is not registered\n"));
> +	}

[ ... ]

> +	device_lock(&client->dev);
> +	if (device_is_bound(&client->dev))
> +		priv->regmap = dev_get_regmap(&client->dev, NULL);
> +	device_unlock(&client->dev);
> +	if (!priv->regmap) {
> +		ret = dev_err_probe(dev, -EPROBE_DEFER,
> +				    "AC200 driver is not ready\n");
> +		goto out_put_client;
> +	}

[Severity: Medium]
Is there anything in this tree that can satisfy this AC200 provider
contract?

ac200_ephy_ctl_create() requires the x-powers,ac200 phandle target to be a
registered I2C client that is bound to a driver and that has attached an
unnamed regmap covering 0x0014, 0x0016, 0x6000 and 0x8004, plus a clkdev
for clk_get(&client->dev, NULL):

	/* The bound AC200 provider enables and exclusively pins this rate. */
	clk_rate = clk_get_rate(clk);

Grepping for x-powers,ac200 at this commit matches only these new driver
files and the package binding added by the preceding patch in the series,
so nothing under drivers/mfd or elsewhere binds that I2C device, attaches
the regmap, or registers the clock.

Doesn't that make both the fixed x-powers,ac200-ephy-package path and the
AC200 selection of x-powers,acx00-ephy-package defer forever with
"AC200 device is not registered" or "AC200 driver is not ready"?

The commit message states the provider behaviour as an existing fact:

    The companion MFD provider enables and exclusively pins the input
    clock rate while it is bound.

and the Kconfig help text advertises "the package-specific AC200 I2C or
AC300 MDIO control registers".  Could the merge dependency on the
separately submitted provider be stated explicitly in this patch, or the
provider be included in the series?

[ ... ]

> diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
> new file mode 100644
> index 0000000000000..932ed4335d843
> --- /dev/null
> +++ b/drivers/net/phy/xpowers/acx00.c
> @@ -0,0 +1,621 @@

[ ... ]

> +static int acx00_ephy_read_nvmem_u16(struct device_node *node,
> +				     const char *name, u16 *value)
> +{

[ ... ]

> +	if (!len || len > sizeof(*value)) {
> +		kfree(buf);
> +		return len ? -ERANGE : -EINVAL;
> +	}
> +
> +	for (i = 0; i < len; i++)
> +		val |= (u16)buf[i] << (8 * i);

[Severity: Low]
Should the binding pin down the width and byte order of the
"configuration" cell?

This helper accepts a 1-byte cell and assembles the value little-endian,
so a one-byte cell can never carry bit 8, the AC300 variant bit.  The
binding for x-powers,acx00-ephy-package documents the bit assignments but
does not state a minimum cell width or an endianness, and it explicitly
allows a partial cell:

    A fixed AC200 package may provide only the low calibration bits or
    omit the cell

[ ... ]

> +	if (selectable) {
> +		priv->is_ac300 =
> +			configuration & ACX00_EPHY_CONFIG_VARIANT_AC300;
> +	} else {
> +		priv->is_ac300 = fixed_ac300;
> +		if (has_configuration &&
> +		    !!(configuration & ACX00_EPHY_CONFIG_VARIANT_AC300) !=
> +		    priv->is_ac300) {
> +			ret = dev_err_probe(dev, -EINVAL,
> +					    "configuration does not match package\n");
> +			goto out_put_node;
> +		}
> +	}

Given the above, a device tree that passes dt_binding_check with a
one-byte (or big-endian) cell would fail probe here with "configuration
does not match package" on x-powers,ac300-ephy-package, and would silently
select the AC200 backend on the generic x-powers,acx00-ephy-package.  Can
the binding require the two-byte little-endian layout that
acx00_ephy_read_nvmem_u16() and this check assume?

[ ... ]

> +static int __acx00_ephy_power_on_and_resume(struct phy_device *phydev)
> +{
> +	struct acx00_ephy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	lockdep_assert_held(&phydev->lock);
> +	lockdep_assert_held(&priv->state_lock);
> +
> +	ret = acx00_ephy_set_interface(phydev);
> +	if (ret)
> +		goto out_power_off;
> +
> +	ret = acx00_ephy_control_power_on(priv);
> +	if (ret)
> +		goto out_power_off;
> +
> +	ret = genphy_resume(phydev);
> +	if (ret)
> +		goto out_power_off;
> +
> +	/* Powering off the control block loses the vendor-page state. */
> +	ret = __acx00_ephy_config_init(phydev);
> +	if (ret)
> +		goto out_power_off;
> +
> +	return 0;
> +
> +out_power_off:
> +	acx00_ephy_control_power_off_warn(priv);
> +
> +	return ret;
> +}

[ ... ]

> +static int acx00_ephy_suspend(struct phy_device *phydev)
> +{

[ ... ]

> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		goto out_unlock;
> +
> +	ret = acx00_ephy_control_power_off(priv);
> +	if (ret) {
> +		resume_ret = __acx00_ephy_power_on_and_resume(phydev);
> +		if (resume_ret)
> +			phydev_warn(phydev,
> +				    "failed to recover from suspend error: %pe\n",
> +				    ERR_PTR(resume_ret));
> +	}

[Severity: Medium]
Does this recovery path lose the user's link configuration?

Consider the case where the register writes in ac200_ephy_ctl_disable() or
ac300_ephy_ctl_disable() succeeded, so the EPHY reset was asserted (and
for AC300 the input clock was disabled), and only the trailing
regulator_disable(priv->vcc) failed:

ac200_ephy_ctl_disable()
	ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL0_REG, 0);  /* reset asserted */
	...
	err = regulator_disable(priv->vcc);   /* fails, returned to caller */

The Clause 22 registers are back at reset defaults at that point, but
__acx00_ephy_power_on_and_resume() only clears the power-down bit through
genphy_resume() and reapplies the vendor pages plus the EEE advertisement
in __acx00_ephy_config_init().  There is no genphy_config_aneg() or
genphy_setup_forced() call to restore phydev->advertising or a configured
forced speed and duplex.

Since acx00_ephy_suspend() then returns the original error, phy_suspend()
never sets phydev->suspended and mdio_bus_phy_suspend() propagates the
failure, so mdio_bus_phy_resume() -> phy_init_hw() is not run for this
device afterwards.

Doesn't that leave the PHY running with reset-default advertising, or with
autonegotiation enabled even though a forced mode was configured?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906-submit-acx00-of-dynamic-v1-v10-0-dd272e03b547%40gmail.com
