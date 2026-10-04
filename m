Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224DE1A9F90;
	Sun,  4 Oct 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791119863; cv=none; b=PZkc48x+GpDWvjfsWVsOBfWQA0qdw04CYojgF6Z5q9KSm3zP7Rwnr9kuAfzHxzCYqsLBWw0dy/laz9IqTwufO2LFjhNFKendBf1fN0a8lAUVuU4qki6ApXtc3nZO4xmm2Ff3sSQZH6cfnDK+bzb2RkUPdo/8VEtWgUFgfal+aMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791119863; c=relaxed/simple;
	bh=a0uLDL6xZuAxwgdZBqnQIBBcwuFMNpEgr+JaDThakKg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f49Fv/2EGblIynlDr09rfO+JkrNN/7eRbfOiJEIWP1a9YmyE9wqo7qAuVjc2n3gTyrbfUb91zGGK/EU/5zuS0BLDmLq2LV+75ahL0G8l/BzHiSP/eiv4bvbmja+VOzASc/L5hjMjXQnDzJ24jpv1JNWK9rgzzSsnwygl8/Y/uws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1zFfIXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1zFfIXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A5B1F00893;
	Sun,  4 Oct 2026 13:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791119861;
	bh=U6xYvDnIcoPAEJY89wI5sG383AN59F+emyyFMZjonH8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z1zFfIXjtdwQz63t0+Z99hPf3lgNqCJTRjoHkAkrHdGl6M5AKMBUT3Nq21HM+7ZY3
	 hLBFzwdY3LgWJ6w/66zw5TUcFiQX0xyxE9nAJyWgkjFRI5i+ymxdmMJUd+slwb7Fns
	 xB3LF2iCMxR5g7Kym32hi+YGJMQ7Aat6cuLiSUeqz6vHakcL9Cc47vpOmN2Vj7/opb
	 GLkDStfJY+uDALR+feWWj0q7aLDgc20PC9WiFjC5xdalGZkIeSelIUlBRIDYw2j/zp
	 Fu7L6/q/MjVJHGfMGT6r5FvvnvbgoPYpgb9d+86emCqf1XuOWelsYN1twJ/5hNNBRT
	 JjFLCM2PTprEA==
Subject: Re: [PATCH 2/5] net: phy: mxl-gpy: add MxL86211C MDIO I/O regulator
From: netdev-bot+sashiko@kernel.org
To: robert.marko@sartura.hr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, lxu@maxlinear.com,
 michael@walle.cc, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Date: Sun, 04 Oct 2026 13:17:40 +0000
Message-ID: <179111986048.434549.17170713963171981994@kernel.org>
In-Reply-To: <20260930122305.293686-2-robert.marko@sartura.hr>
References: <20260930122305.293686-2-robert.marko@sartura.hr>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The driver programs VSPEC1_PM_CTRL.MDIO_VOL only as a side
  effect of devm_regulator_register() in mxl86211c_probe(), via…
- [Medium] The patch adds an unconditional `depends on REGULATOR` to
  MAXLINEAR_GPHY (drivers/net/phy/Kconfig:305), so the whole mxl-gpy…

--

net: phy: mxl-gpy: add MxL86211C MDIO I/O regulator

This commit models the MxL86211C VSPEC1_PM_CTRL.MDIO_VOL bit as a
regulator. The bit selects 1.8V or 3.3V signaling for the MDIO, MDC and
MDINT pads. The regulator is registered from a new mxl86211c_probe(), and
MAXLINEAR_GPHY now depends on REGULATOR.

> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index d3835597e3795..bdaee0cb4829d 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -302,6 +302,7 @@ config MAXLINEAR_GPHY
>  	tristate "Maxlinear Ethernet PHYs"
>  	select POLYNOMIAL if HWMON
>  	depends on HWMON || HWMON=n
> +	depends on REGULATOR

[Severity: Medium]
Does this unconditional dependency hide the whole mxl-gpy driver when
REGULATOR=n?

MAXLINEAR_GPHY covers GPY2xx, GPY115B/C, GPY211B/C, GPY212B/C, GPY215B/C,
GPY241B/BM, GPY245B, MxL86211C, MxL86252 and MxL86282. Only the MxL86211C
probe path uses the regulator API.

Take an existing .config with REGULATOR=n and MAXLINEAR_GPHY=y/m. After
olddefconfig, MAXLINEAR_GPHY is silently dropped and Kconfig gives no
warning. Those PHYs then fall back to genphy and lose SGMII/2500BASE-X
handling, inband AN, LEDs, WoL and hwmon.

include/linux/regulator/driver.h has no !CONFIG_REGULATOR stubs for
devm_regulator_register() or rdev_get_drvdata(). That is probably why the
dependency covers the whole driver.

Could the regulator code in mxl86211c_probe() be guarded with
IS_ENABLED(CONFIG_REGULATOR) instead, so the rest of the PHY family does
not need the regulator framework?

The commit message does not mention this dependency change. The last patch
in the series still has the unconditional dependency.

>  	help
>  	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
>  	  GPY241, GPY245 PHYs.
> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 089a1a9e5bc61..4cbbfae046317 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c

[ ... ]

> @@ -390,6 +396,72 @@ static int gpy_probe(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int mxl86211c_mdio_reg_set_voltage_sel(struct regulator_dev *rdev,
> +					      unsigned int selector)
> +{
> +	struct phy_device *phydev = rdev_get_drvdata(rdev);
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL,
> +			      VSPEC1_PM_CTRL_MDIO_VOL,
> +			      selector ? 0 : VSPEC1_PM_CTRL_MDIO_VOL);
> +}

[ ... ]

> +static int mxl86211c_probe(struct phy_device *phydev)
> +{
> +	struct device *dev = &phydev->mdio.dev;
> +	struct regulator_config config = { };
> +	struct regulator_dev *rdev;
> +	int ret;
> +
> +	ret = gpy_probe(phydev);
> +	if (ret)
> +		return ret;
> +
> +	config.dev = dev;
> +	config.driver_data = phydev;
> +
> +	rdev = devm_regulator_register(dev, &mxl86211c_mdio_desc, &config);

[Severity: High]
Is MDIO_VOL restored after a PHY hardware reset?

The bit is written only in two cases. One is devm_regulator_register(),
when the regulator core applies the apply_uV constraints once at
registration. The other is a consumer calling set_voltage. Nothing writes
it again after that.

phylib asserts the PHY reset in phy_detach(). It releases the reset in
phy_init_hw(), which then calls only drv->config_init, not probe:

drivers/net/phy/phy_device.c:phy_detach() {
    ...
	/* Assert the reset signal */
	phy_device_reset(phydev, 1);
    ...
}

drivers/net/phy/phy_device.c:phy_init_hw() {
    ...
	/* Deassert the reset signal */
	phy_device_reset(phydev, 0);
    ...
}

Consider a board with 1.8V VDDP and reset-gpios in DT, behind a MAC that
disconnects the PHY in ndo_stop. An ifdown/ifup cycle would go through:

phy_detach()->phy_device_reset(phydev, 1)
phy_attach_direct()->phy_init_hw()->phy_device_reset(phydev, 0)
phy_init_hw()->gpy21x_config_init()

The MxL86211C entry has no soft_reset. gpy21x_config_init() never touches
VSPEC1_PM_CTRL.

The commit message says the bit defaults to 3.3V. After such a reset,
would the pads go back to 3.3V signaling and bring back the unreliable
MDIO that this patch is meant to fix? The registered regulator would then
also report 3.3V, which no longer matches the board. Losing the supply
across suspend would have the same effect.

Would it work to cache the requested selector and re-apply it from
config_init? This is still the case at the end of the series, where
mxl86211c_config_init() only adds the lane ASP mapping.

> +	if (IS_ERR(rdev)) {
> +		phydev_err(phydev, "failed to register MDIO regulator\n");
> +		return PTR_ERR(rdev);
> +	}
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930122305.293686-1-robert.marko%40sartura.hr
