Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E018D62A;
	Sun, 18 Oct 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792320454; cv=none; b=YaS+LYXvWTYitZE7PQ+XbXvkvlVEDStJfHH1ADolBrELgjwG9XON6udSjHTkjicWMFIfnvzlsiFxNbWg8DrRK+g1Gl+WbEQ3EpSTdyUbvTz4uh9TGgC1ijCAxnC2nUzuV1mrVfMq+HZoTzA92lp/64TGFkJs0tzYtrf5HpyDGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792320454; c=relaxed/simple;
	bh=kYYvf1iNkXfeGZJSST92UoYl1vNxC3SbCyPO7Iqtmn4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ctdpg1lg42AhzGIuEb7hvLvbMVQ98y1CdlK3uPMe9iwORG+5RquLgjGh1CtjjiDjOrG4L9VRs7yIQlPqk8hUkv70TBAF2jXm1aSzhY0gp9hGcXUkHYhpVER+1wxLlfJPsvvGe4bo9xEpSa9p7TKzCCgUis+naixkMcIYKTbGR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDoA6NUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDoA6NUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C881F000C4;
	Sun, 18 Oct 2026 10:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792320452;
	bh=DnhWGak6th3C+r8+ASfIM/FXpoFd0Su7Yr8FNkAqU4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BDoA6NUDTLdOU19yijEuglWTG3E3F+wT0dc0VQSfJCxz1LQq3AWvO7DBkixZkh8XW
	 gLfl9JSc7mr6L1xsWMjUNCbwi8eCxNAetMoExTO4Z19kzURB4QlzMsxvW7qTNdha4h
	 MEMRv10X5mN7hcT8YxhYAnwKbnGthNSWfZwNH/J1ZhYt6DVFsAnbhEp38ugaplAcXg
	 hoKNPbQPcBtdsL70IhLHjs0wLSuanc56vByiLbgy7zVrdEQNgpu7sfOW59gjTyGkdS
	 FZxx3zPlrmJRVJh5AoFACr20gpBtN2Y/BK3VA3KwG1y/rZhaWQuKAgX1i55EY+VxZH
	 htszzNA5ILegg==
Subject: Re: [PATCH net-next v3 1/9] net: phy: dp83867: add regulator supply
 management
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, lorenzo.bianconi@oss.qualcomm.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Sun, 18 Oct 2026 10:47:30 +0000
Message-ID: <179232045050.3135.12351240759088487913@kernel.org>
In-Reply-To: <20261017-shikra_ethernet-v3-1-26a8beb44b8f@oss.qualcomm.com>
References: <20261017-shikra_ethernet-v3-1-26a8beb44b8f@oss.qualcomm.com>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With CONFIG_REGULATOR=n, dp83867_power_on()
  (drivers/net/phy/dp83867.c) sleeps 200 ms on every probe, even when…
- [Medium] The patch makes the driver read four new DT properties
  (vdda-2p5-supply, vdd-1p0-supply, vdda-1p8-supply, vddio-supply)…
- [Low] The commit message says the driver sleeps 200 ms "when any supply
  is newly enabled".

--

net: phy: dp83867: add regulator supply management

This commit adds dp83867_power_on(), which enables up to four optional
supplies (vdda-2p5, vdd-1p0, vdda-1p8, vddio) at the start of
dp83867_probe(). If any supply is present, the driver sleeps for 200 ms
to meet the datasheet's post power-up stabilization requirement.

> diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
> index a3cd5cb11ea0a..092bc68bb9bc6 100644
> --- a/drivers/net/phy/dp83867.c
> +++ b/drivers/net/phy/dp83867.c

[ ... ]

> @@ -730,11 +731,42 @@ static int dp83867_resume(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int dp83867_power_on(struct phy_device *phydev)
> +{
> +	static const char * const supply_names[] = {
> +		"vdda-2p5", "vdd-1p0", "vdda-1p8", "vddio",
> +	};

[Severity: Medium]
These names become four new DT properties: vdda-2p5-supply,
vdd-1p0-supply, vdda-1p8-supply and vddio-supply. Should
Documentation/devicetree/bindings/net/ti,dp83867.yaml document them in
the same series?

Right now the binding lists no *-supply properties and ends with:

  unevaluatedProperties: false

The only schema it references, ethernet-controller.yaml, has no supply
properties either. A node that uses the new properties won't validate
against this schema.

ti,dp83867.yaml has no select, so dtbs_check may never apply it to board
DTs. Even so, the properties would still be undocumented ABI.

A related question: should the binding also say that an
ethernet-phy-idXXXX.XXXX compatible is required when these rails are
switched? fwnode_mdiobus_register_phy() only skips the MDIO ID read when
that compatible is present:

drivers/net/mdio/fwnode_mdio.c:fwnode_mdiobus_register_phy() {
    ...
	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
		phy = get_phy_device(bus, addr, is_c45);
	else
		phy = phy_device_create(bus, addr, phy_id, 0, NULL);
    ...
}

Without that compatible, get_phy_device() reads the ID from a PHY that
is not powered yet. The phy_device is then never created, so
dp83867_probe() never runs to turn the rails on.

> +	struct device *dev = &phydev->mdio.dev;
> +	bool supplies_enabled = false;
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(supply_names); i++) {
> +		ret = devm_regulator_get_enable_optional(dev, supply_names[i]);
> +		if (ret == -ENODEV)
> +			continue;

[Severity: Medium]
What happens here with CONFIG_REGULATOR=n? The stub returns 0, not
-ENODEV:

include/linux/regulator/consumer.h:
static inline int devm_regulator_get_enable_optional(struct device *dev,
						     const char *id)
{
	return 0;
}

In that case the -ENODEV check never matches and supplies_enabled is set
on the first iteration. fsleep(200000) then runs on every probe, even
when the board describes no supplies.

DP83867_PHY in drivers/net/phy/Kconfig doesn't depend on REGULATOR, so
this config is valid. Each probe attempt, including -EPROBE_DEFER
retries, would add 200 ms per PHY.

This doesn't match the commit message:

    Absent supplies are silently skipped, so boards
    that do not describe them are unaffected.

Would an IS_ENABLED(CONFIG_REGULATOR) check work here? Another option is
devm_regulator_get_optional() followed by an explicit enable, so the
sleep only runs when a real regulator was found.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to enable %s supply\n",
> +					     supply_names[i]);
> +		supplies_enabled = true;

[Severity: Low]
The commit message says:

    When any supply is newly enabled the driver sleeps for 200 ms before
    returning.

Is "newly enabled" accurate? _devm_regulator_get_enable() returns the
result of regulator_enable():

drivers/regulator/devres.c:_devm_regulator_get_enable() {
    ...
	ret = regulator_enable(r);
	if (!ret)
		ret = devm_add_action_or_reset(dev, &regulator_action_disable, r);
    ...
}

That result is also 0 when the rail was already on. This covers
regulator-always-on, regulator-boot-on, a rail enabled by the
bootloader, or a rail shared with another consumer. So the 200 ms delay
runs whenever any supply is described, whatever its earlier state.

The rails are also enabled before dp83867_of_init(), which can fail with
-EPROBE_DEFER:

dp83867_probe()
  dp83867_of_init()
    dp83867_of_init_io_impedance()
      of_nvmem_cell_get() -> -EPROBE_DEFER

On that failure, devres runs regulator_action_disable for each enabled
supply and the PHY loses power.

Does each deferral then power-cycle the PHY and add another 200 ms on
the retry?

> +	}
> +
> +	/* Datasheet section 6.6 suggests a 200ms post power-up stabilization */
> +	if (supplies_enabled)
> +		fsleep(200000);
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261017-shikra_ethernet-v3-0-26a8beb44b8f%40oss.qualcomm.com
