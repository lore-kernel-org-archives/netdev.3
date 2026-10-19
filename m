Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA66596E8C;
	Mon, 19 Oct 2026 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420733; cv=none; b=iCxmjTTZyQtiAWMr1QoW1suy5lFoaR1Z/1I4T+8RrT/h7/4Y6jYI2L7diFZenBJ5oiT/zIN8PZIja8CwQh5p3b3IS9oppanNg6Gi/ddLxO0TX0hYxWStMUNeG9sdIA3mcFlBYYQGFThoGE/sEYG5JGM2RertCchOf3DzUFl1Fik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420733; c=relaxed/simple;
	bh=CW91CfKKKLjEmYD2B68vSnrHjVe/P+kBuocfc7jZ6mo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QdIuFBuv+VbrTqsgIzTugtWtCU6Sphia0uUcCxbD96puXp9V33xglk3/Jsh1+4ZzgmqpZHACDGhh/IdcVQyzengcr3LlL2mLgY7LR6JZl/jaBjdNpLpvskPGU7PMqK5O2UKFxTR9oJQUZSXXhYlCzoA+PkB/yz6esWmDWvsTCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+HzM5X7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+HzM5X7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2414C1F000C4;
	Mon, 19 Oct 2026 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420732;
	bh=hYKA0XJet1RnoiHtXKCkpjdYwSNS1IMXkGEHRvokRp0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m+HzM5X7I7hbry1ukeBdsOCV71yoHnonw64VsG1jkOYQcSCNUU/OtV8P8ES+UtEDE
	 1CYklcs8bsrQGf7np6Rug8XcXL6+ZQ8lvoT1f2pMBr2NJAALdNKr0scaMPRT25eJ0k
	 jtX1jZXKMnI2KkmfQ7Drofs1jHo5yFp1qXAW6cuvd8xijJ9twwrBYI7zYAOVoAroeP
	 UVZCfY4/lqhVZ5UBZt69TwmlCjgpPWVhrxSFTbGCRRyCDGgvZ0qwxJ6h/aFbdhL/KD
	 OVsbfQs8Jy27jaGT0Mr94bt0sHc57kUUBXblQiuEUtSq7U667U544JRTHxjl9qVPmC
	 qkjWtgJRy96+A==
Subject:
 Re: [PATCH net-next v2 2/2] net: phy: qcom: qca808x: Add regulator management
From: netdev-bot+sashiko@kernel.org
To: elder@riscstar.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 daniel@riscstar.com, ansuelsmth@gmail.com, donggeunyoo.kernel@gmail.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 14:38:50 +0000
Message-ID: <179242073068.3135.7197749008820152955@kernel.org>
In-Reply-To: <20261015143849.483339-3-elder@riscstar.com>
References: <20261015143849.483339-3-elder@riscstar.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] qca808x_power_on() (drivers/net/phy/qcom/qca808x.c) turns on
  the QCA8081 supplies only after phylib has already released the PHY…
- [Low] Kept only because requires_validation=true; the baseline decision
  is a false positive.

--

net: phy: qcom: qca808x: Add regulator management

This commit adds optional regulator handling to the qca808x PHY driver.
qca808x_probe() now enables the avdd18, vdd, vdd18 and vdd125 supplies
with devm_regulator_get_enable_optional() and leaves them on for the
lifetime of the device. If any supply was found, the driver then waits
for reset_assert_delay before it continues.

> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index bab26e4c61408..4aba513b9a512 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c

[ ... ]

> @@ -181,15 +182,43 @@ static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>  }
>  
> +static int qca808x_power_on(struct phy_device *phydev)
> +{
> +	static const char * const regulator_names[] = {
> +		"avdd18", "vdd", "vdd18", "vdd125"
> +	};
> +	struct device *dev = &phydev->mdio.dev;
> +	u32 count = 0;
> +	int ret;
> +
> +	for (u32 i = 0; i < ARRAY_SIZE(regulator_names); i++) {
> +		ret = devm_regulator_get_enable_optional(dev, regulator_names[i]);
> +		if (!ret)
> +			count++;
> +		else if (ret != -ENODEV)
> +			return ret;
> +	}
> +
> +	if (count)
> +		fsleep(phydev->mdio.reset_assert_delay);

[Severity: Medium]
Is reset_assert_delay the right delay to use here?

This value comes from the reset-assert-us DT property. ethernet-phy.yaml
describes it as:

  reset-assert-us:
    description:
      Delay after the reset was asserted in microseconds. If this
      property is missing the delay will be skipped.

mdio_device_reset() only uses it when reset is being asserted:

    d = value ? mdiodev->reset_assert_delay : mdiodev->reset_deassert_delay;

The qca,qca808x.yaml example has vdd18-supply but no reset-assert-us. For
a board described that way, this call becomes fsleep(0).

The ordering is also a concern. By the time qca808x_power_on() runs,
phylib has already released the reset line, and the PHY had no power at
that point:

phy_device_register()
    phy_device_reset(phydev, 0);
    ...
    device_add()
        phy_probe()
            phy_device_reset(phydev, 0);
            phydev->drv->probe(phydev)
                qca808x_probe()
                    qca808x_power_on()
                        devm_regulator_get_enable_optional()
                        fsleep(phydev->mdio.reset_assert_delay);
            phy_disable_interrupts(phydev);
            phydrv->get_features(phydev);
            ...
            genphy_c45_read_eee_adv(phydev, ...);

So the reset-deassert-us wait has already run out before the rails come
up. MDIO accesses then start as soon as qca808x_probe() returns. The same
thing happens again on unbind and rebind.

Can this lead to MDIO accesses before the PHY has finished powering up?
That could make probe fail, or leave phylib with the wrong supported and
EEE link modes. The exact QCA8081 power-on timing isn't visible from the
code, so this depends on the datasheet.

Existing QCA8081 descriptions such as lemans-evk.dts set the two delays
to different values:

    reset-assert-us = <11000>;
    reset-deassert-us = <70000>;

So the time the PHY needs after reset release is separate from the time
reset is held asserted. If a board raised reset-assert-us to cover
power-up, every later reset assertion would also get slower.

Would it work to assert reset with phy_device_reset(phydev, 1) before
enabling the supplies, then release it with phy_device_reset(phydev, 0)?
That way both documented delays apply in the right order. A fixed,
documented power-up settle time would be another option. The commit
message doesn't mention this sequencing either.

> +
> +	return 0;
> +}
> +
>  static int qca808x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
>  	struct qca808x_priv *priv;
> +	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	ret = qca808x_power_on(phydev);
> +	if (ret)
> +		return ret;

[Severity: Low]
This isn't a bug, but a note in the binding or the commit message might
help. The supplies are only enabled after a phy_device has been created
and matched to this driver.

If the DT node lacks the ethernet-phy-id004d.d101 compatible, or is
marked c45, fwnode_mdiobus_register_phy() reads the ID registers from a
PHY that has no power:

    if (is_c45 || fwnode_get_phy_id(child, &phy_id))
        phy = get_phy_device(bus, addr, is_c45);

get_phy_c22_id() would then read all-ones and return -ENODEV. In that
case qca808x_probe() never runs and the regulators are never turned on.

ethernet-phy.yaml already says the explicit PHY ID compatible is needed
when supplies must be sequenced before the ID can be read. qca,qca808x.yaml
only allows ethernet-phy-id004d.d101, and all in-tree QCA8081 DTs already
use it. So this is mostly about making the documentation clearer.

>  	priv->led_polarity_mode = QCA808X_PHY_LED_UNSET;
>  
>  	phydev->priv = priv;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015143849.483339-1-elder%40riscstar.com
