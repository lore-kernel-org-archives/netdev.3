Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458526B742;
	Tue, 18 Aug 2026 01:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016759; cv=none; b=Zc7RpJxgp3G3bFMKnkKA1mq5hEwSE2tH1qZv617lBcXZ1GO/HH+9OkmKwg2EyOPzA0o/YJ8XNBDpNHXNV2p8QGzWzEDiPQ9JATzYRSs75KEYzDVo5SjnZVo9RgH2uXoV1ubp5KlGoVlqw5AgfAvraTj6s2ez6lfyiIb/cqwc1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016759; c=relaxed/simple;
	bh=qax21LyP85vraGor8ysGMZr1LmTEZgPUZP0arUf0V24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbePRg7pgjzFdDQYEdjwAN55nliE31dZMeAIUwi9Xx5wJfUkZrO3fb0L3YmY/M809ZLVG+0ZglZPypkOekvLsEVTKA66AqgOP+4iqSn4t1aSqfuXi9VCJbR72T5Gx43UwdusRw24xWeoB+FFAix2TbS9A6d93q+JsJP6iWOe2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDye80Xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDye80Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7251F000E9;
	Tue, 18 Aug 2026 01:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016757;
	bh=eMfVLKP5I0mgvrReQrF33AqqrmOFxG4h9Nrjct+yc2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WDye80Xcu5lguZ1WWb5IXtK0KjWSu+5c9BJ0s+N5Wg+FsSQF95i29ZZhrOZJUyLvX
	 +0GZ4UklJydlqPCI9+3nnbmH+czHiYWKwZWFJU0x6fkqWscS1IjRZX1E0BzTzaxlEy
	 LNslTo4d7TsQg/vyD7DVSXGVr4nwHtSN088bznlXwooNL7r7gt0+R6iVlpzbb+EILG
	 lVmEDb3gnMsqHFG1f2yoFwQlb+xvgaiNeTu+YovDtg67NQFfOsje9kM1jxlvsnAfQH
	 9O3y8AiqAJF0F5SY2qIpBAQ7MRjI583qTK43ugSgq9pA/ftJbu+yT4UAICGKVGVFYj
	 Njr7LG1PpqEhA==
From: Jakub Kicinski <kuba@kernel.org>
To: james.hilliard1@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	arnd@arndb.de,
	jedrzej.jagielski@intel.com,
	andre.przywara@arm.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	maxime.chevallier@bootlin.com,
	linux-sunxi@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 2/2] net: phy: add X-Powers AC200/AC300 EPHY driver
Date: Mon, 17 Aug 2026 18:24:18 -0700
Message-ID: <20260818012418.3826560-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813-submit-acx00-of-dynamic-v1-v8-2-d2f1c52e87b4@gmail.com>
References: <20260813-submit-acx00-of-dynamic-v1-v8-2-d2f1c52e87b4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: phy: add X-Powers AC200/AC300 EPHY driver

This adds a single PHY driver for the Fast Ethernet link PHY found in the
X-Powers AC200 and AC300 companion ICs, with two package backends: AC200
control registers reached over an I2C regmap, and AC300 control registers
reached through the PHY package helpers at base address plus 16.

A few questions below about the AC200 backend, the resume/suspend return
values and the power-state bookkeeping.

> diff --git a/drivers/net/phy/xpowers/ac200.c b/drivers/net/phy/xpowers/ac200.c
> new file mode 100644
> index 0000000000000..17011b5f5e21c
> --- /dev/null
> +++ b/drivers/net/phy/xpowers/ac200.c
> @@ -0,0 +1,308 @@

[ ... ]

> +static int ac200_ephy_ctl_power_on(struct acx00_ephy_control *control,
> +				   unsigned int phy_addr)
> +{
> +	struct ac200_ephy_ctl *priv =
> +		container_of(control, struct ac200_ephy_ctl, control);
> +	u16 ephy_ctl;
> +	int ret;
> +
> +	if (phy_addr > FIELD_MAX(AC200_EPHY_PHY_ADDR_MASK))
> +		return -EINVAL;
> +
> +	if (priv->powered && priv->phy_addr == phy_addr)
> +		return 0;
> +
> +	if (priv->powered) {
> +		ret = ac200_ephy_ctl_disable(priv);
> +		if (ret)
> +			return ret;
> +	}
> +	priv->phy_addr = phy_addr;
> +
> +	if (!priv->supply_enabled) {
> +		ret = regulator_enable(priv->vcc);
> +		if (ret)
> +			return ret;
> +		priv->supply_enabled = true;
> +	}

[Severity: Medium]

What serializes these check-then-set updates of priv->supply_enabled and
priv->powered?

The same flags are read and written from ac200_ephy_ctl_power_on(),
ac200_ephy_ctl_disable() and ac200_ephy_ctl_set_interface(), reached from
four phylib entry points with different lock contexts:

  .resume    -> acx00_ephy_resume()        (phydev->lock held,
                                            __phy_resume() has
                                            lockdep_assert_held())
  .suspend   -> acx00_ephy_suspend()       (no phylib lock; phy_suspend()
                                            takes none, and
                                            _phy_state_machine_post_work()
                                            calls it after
                                            phy_state_machine() unlocked)
  .soft_reset-> acx00_ephy_soft_reset()    (via exported phy_init_hw(),
                                            no phylib lock)
  devres     -> acx00_ephy_control_release() (unbind, no lock)

If two of those interleave, the regulator enable count (and for AC300 the
clk_prepare_enable() count guarded by the same priv->powered flag) becomes
unbalanced, and the multi-register bring-up and shutdown sequences
interleave since only the regmap or MDIO bus lock is held per access. Would
a mutex in the backend private data be appropriate here?

> +
> +	ephy_ctl = ac200_ephy_ctl_config(priv);
> +
> +	/* Start from a disabled state before applying the configuration. */
> +	ret = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL0_REG, 0);
> +	if (ret)
> +		goto err_disable;
> +
> +	ret = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL1_REG,
> +				   AC200_EPHY_MII_IO_ENABLE);
> +	if (ret)
> +		goto err_disable;
> +
> +	ret = ac200_ephy_ctl_write(priv, AC200_EPHY_CTL_REG,
> +				   ephy_ctl | AC200_EPHY_SHUTDOWN);
> +	if (ret)
> +		goto err_disable;
> +
> +	ret = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL0_REG,
> +				   AC200_EPHY_RESET_DEASSERT |
> +				   AC200_EPHY_SYSCLK_ENABLE);
> +	if (ret)
> +		goto err_disable;
> +
> +	ret = ac200_ephy_ctl_write(priv, AC200_EPHY_CTL_REG, ephy_ctl);
> +	if (ret)
> +		goto err_disable;

[Severity: Low]

Is the AC200 power-on sequence really free of timing requirements?

ac200_ephy_ctl_power_on() writes the control registers immediately after
regulator_enable(), and clears AC200_EPHY_SHUTDOWN in the write directly
following the reset-deassert plus sysclk-enable write. The callers
(acx00_ephy_soft_reset() and acx00_ephy_power_on_and_resume() ->
genphy_resume()) then start Clause 22 accesses to the link PHY right away.

The AC300 backend, driving the same PHY block, treats the equivalent steps
as timed:

	/* Wait for the power-on reset interval specified by the manual. */
	fsleep(10000);
	...
	ret = ac300_ephy_ctl_write(priv, AC300_EPHY_CONFIG_REG,
				   ac300_ephy_ctl_config(priv) |
				  AC300_EPHY_SHUTDOWN);
	...
	fsleep(10000);

Is the asymmetry intentional, i.e. does the AC200 datasheet specify no
power-on-reset interval and no settling time around the shutdown
transition? I could not confirm the AC200 timing from anything in tree.

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
> +
> +	if (!device_link_add(dev, &client->dev,
> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +		ret = dev_err_probe(dev, -EINVAL,
> +				    "failed to link AC200 device\n");
> +		goto out_put_client;
> +	}
> +
> +	device_lock(&client->dev);
> +	if (device_is_bound(&client->dev))
> +		priv->regmap = dev_get_regmap(&client->dev, NULL);
> +	device_unlock(&client->dev);
> +	if (!priv->regmap) {
> +		ret = dev_err_probe(dev, -EPROBE_DEFER,
> +				    "AC200 driver is not ready\n");
> +		goto out_put_client;
> +	}

[Severity: Low]

Can this gate ever be satisfied in mainline?

The AC200 path requires that the I2C device referenced by the
x-powers,ac200 phandle is bound to a driver which has registered a regmap.
Searching the tree at this commit, x-powers,ac200 matches only the new
binding and the two new driver files, there is no AC200 companion-IC driver
(nothing in drivers/mfd), and no DTS instantiates such a node. The only
other AC200-ish DTS matches are unrelated (regulator-name = "vcc-ac200",
allwinner,sun55i-a523-gmac200).

So on any DT using x-powers,ac200-ephy-package or
x-powers,acx00-ephy-package with an AC200, of_i2c_register_devices() will
create the i2c_client, but device_is_bound() can never become true and the
probe defers forever. Everything below this point (the 0x0014, 0x0016,
0x6000 and 0x8004 register contract, the eFuse calibration read, the clock
rate selection and the whole power sequence) is then unreachable.

The Kconfig help text says:

	  Enable the Fast Ethernet PHY driver shared by the X-Powers AC200
	  and AC300 companion ICs.

and the commit message says:

    Firmware must make the selected AC200 provider path available
    before the PHY probes.

Would it be more accurate to state that the AC200 half depends on a
companion-IC MFD driver that is not merged yet, or to post that driver in
the same series so the AC200 code is testable?

> +
> +	if (!has_calibration) {
> +		ret = regmap_read(priv->regmap, AC200_EFUSE_EPHY_REG,
> +				  &internal_calibration);
> +		if (ret)
> +			goto out_error;
> +		calibration = internal_calibration;
> +	}

[ ... ]

> +	clk = clk_get(&client->dev, NULL);
> +	if (IS_ERR(clk)) {
> +		ret = PTR_ERR(clk);
> +		goto out_error;
> +	}
> +
> +	clk_rate = clk_get_rate(clk);
> +	clk_put(clk);
> +
> +	switch (clk_rate) {
> +	case AC200_EPHY_CLK_RATE_24_MHZ:
> +		priv->ephy_ctl |= AC200_EPHY_CLK_SEL_24_MHZ;
> +		break;
> +	case AC200_EPHY_CLK_RATE_27_MHZ:
> +		break;
> +	default:
> +		ret = dev_err_probe(dev, -EINVAL,
> +				    "unsupported AC200 clock rate %lu Hz\n",
> +				    clk_rate);
> +		goto out_put_client;
> +	}

[Severity: Medium]

Can the sampled rate go stale here?

ac200_ephy_ctl_create() reads the rate once, folds the result into
priv->ephy_ctl as AC200_EPHY_CLK_SEL_24_MHZ, drops the clock reference, and
every later ac200_ephy_ctl_power_on() re-writes that latched value. There is
no devm_clk_rate_exclusive_get() and no clk_prepare_enable() anywhere in
ac200.c, so if another consumer calls clk_set_rate() on the shared provider
after probe, CLK_SEL no longer describes the frequency reaching the EPHY and
the link timing is off with no error reported.

The AC300 backend handles the identical constraint the other way:

	ret = devm_add_action_or_reset(dev, ac300_ephy_clk_put, priv->clk);
	...
	ret = devm_clk_rate_exclusive_get(dev, priv->clk);

plus clk_prepare_enable() and clk_disable_unprepare() around the powered
state. Should the AC200 path pin the rate the same way? Related, the commit
message says:

    Obtain and manage the selected package supply, calibration and input
    clock

which as written seems to hold only for the AC300 backend. I could not check
whether the (unmerged) AC200 companion driver is expected to own and enable
that clock instead.

[Severity: Low]

Where is this AC200 clock requirement documented?

The package binding describes clocks as "AC300 input clock, running at 24,
25, or 27 MHz", requires it for x-powers,ac300-ephy-package and
x-powers,acx00-ephy-package, and forbids it for
x-powers,ac200-ephy-package. But the AC200 backend never looks at the
package clocks; it does clk_get(&client->dev, NULL) on the AC200 companion
I2C device and fails probe with -EINVAL unless that clock reports exactly
24 MHz or 27 MHz (and propagates the clk_get() error if the companion node
has no clock at all).

So a DT author has no in-tree description of the AC200 companion clock or
its permitted rates. Could the binding for the AC200 companion node (or at
least the package binding text) state that constraint?

> diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
> new file mode 100644
> index 0000000000000..98f2b0b639096
> --- /dev/null
> +++ b/drivers/net/phy/xpowers/acx00.c
> @@ -0,0 +1,536 @@

[ ... ]

> +static int acx00_ephy_soft_reset(struct phy_device *phydev)
> +{
> +	struct acx00_ephy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	ret = acx00_ephy_set_interface(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = acx00_ephy_control_power_on(priv);
> +	if (ret)
> +		return ret;
> +
> +	/* ACx00 can acknowledge reset in power-down without restarting. */
> +	ret = genphy_resume(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return genphy_soft_reset(phydev);
> +}

[ ... ]

> +out_restore_page:
> +	ret = phy_restore_page(phydev, oldpage, ret);
> +	if (ret)
> +		return ret;
> +
> +	/* Restore the standard EEE policy retained by phylib across resets. */
> +	return genphy_c45_an_config_eee_aneg(phydev);
> +}

[Severity: Medium]

Should this positive return value be consumed rather than propagated?

genphy_c45_an_config_eee_aneg() returns 1 when it actually changed an EEE
advertisement register, because genphy_c45_write_eee_adv() returns changed:

drivers/net/phy/phy-c45.c:genphy_c45_write_eee_adv() {
	...
		if (val > 0)
			changed = 1;
	...
	return changed;
}

acx00_ephy_config_init() forwards that 1 to acx00_ephy_power_on_and_resume()
and from there to acx00_ephy_resume(), which is the .resume callback. In
phylib:

drivers/net/phy/phy_device.c:__phy_resume() {
	...
	ret = phydrv->resume(phydev);
	if (!ret)
		phydev->suspended = false;
	...
}

so a fully successful resume that happened to change the advertisement is
reported as an error and leaves phydev->suspended set. phy_suspend() then
short-circuits:

drivers/net/phy/phy_device.c:phy_suspend() {
	if (phydev->suspended || !phydrv)
		return 0;
	...
}

which means acx00_ephy_suspend(), the only path that powers the package
down, is skipped for the rest of the device's life. Note phy_init_hw() does
not always mask this, since phylink_prepare_resume() calls phy_resume()
directly when phydev->suspended is set.

Separately, if the advertisement did change, does this path need to restart
autonegotiation for the new advertisement?

> +
> +static int acx00_ephy_power_on_and_resume(struct phy_device *phydev)
> +{
> +	struct acx00_ephy_priv *priv = phydev->priv;
> +	int ret;
> +
> +	ret = acx00_ephy_set_interface(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = acx00_ephy_control_power_on(priv);
> +	if (ret)
> +		return ret;
> +
> +	ret = genphy_resume(phydev);
> +	if (ret) {
> +		acx00_ephy_control_power_off(priv);
> +		return ret;
> +	}
> +
> +	/* Powering off the control block loses the vendor-page state. */
> +	return acx00_ephy_config_init(phydev);
> +}

[Severity: Medium]

Does the acx00_ephy_config_init() error path leave the package powered?

The genphy_resume() failure branch calls acx00_ephy_control_power_off(), but
a failure in the trailing acx00_ephy_config_init() returns with
priv->powered and priv->supply_enabled still true. acx00_ephy_soft_reset()
above has the same shape: it powers on, then returns genphy_resume() or
genphy_soft_reset() errors without a matching power off.

Because phylib only clears the suspended flag after a successful
.soft_reset:

drivers/net/phy/phy_device.c:phy_init_hw() {
	if (phydev->drv->soft_reset) {
		ret = phydev->drv->soft_reset(phydev);
		if (ret < 0)
			return ret;

		/* see comment in genphy_soft_reset for an explanation */
		phydev->suspended = 0;
	}
	...
}

and mdio_bus_phy_resume() aborts before phy_resume() when phy_init_hw()
fails, a single failed MDIO or I2C transaction on this path leaves
phydev->suspended set. phy_suspend() then returns early on that flag, so
the package supply (and the AC300 input clock enabled via
clk_prepare_enable()) stays on for all later suspend cycles until unbind
runs the devres release action. Should both paths power the control block
back off on failure?

> +
> +static int acx00_ephy_resume(struct phy_device *phydev)
> +{
> +	return acx00_ephy_power_on_and_resume(phydev);
> +}
> +
> +static int acx00_ephy_suspend(struct phy_device *phydev)
> +{
> +	struct acx00_ephy_priv *priv = phydev->priv;
> +	int resume_ret;
> +	int ret;
> +
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = acx00_ephy_control_power_off(priv);
> +	if (ret) {
> +		resume_ret = acx00_ephy_power_on_and_resume(phydev);
> +		if (resume_ret)
> +			phydev_warn(phydev,
> +				    "failed to recover from suspend error: %pe\n",
> +				    ERR_PTR(resume_ret));
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]

Is it safe to run the resume sequence from the .suspend callback?

acx00_ephy_power_on_and_resume() performs genphy_resume() (BMCR modify) and
acx00_ephy_config_init(), which does phy_select_page() plus paged vendor
writes and then genphy_c45_an_config_eee_aneg(), reading phydev->autoneg,
phydev->eee_cfg.eee_enabled and phydev->advertising_eee.

phylib requires phydev->lock for the resume operation:

drivers/net/phy/phy_device.c:__phy_resume() {
	lockdep_assert_held(&phydev->lock);
	...
}

but .suspend runs with no phylib lock held (phy_suspend() takes none, and
_phy_state_machine_post_work() invokes it after phy_state_machine() has
dropped the lock). So when the control-block write fails, this recovery
executes resume code unlocked, concurrently with phydev->lock holders such
as the state machine or phy_ethtool_set_eee(), which write the same fields
and registers it reads and rewrites. Should the recovery be restricted to
the control-block power-on, or moved to a context that holds phydev->lock?
