Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD581320CD3;
	Sun, 18 Oct 2026 04:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296627; cv=none; b=NKYRjWNED/hDuCJlJRYd9xKA/Uy5gtzFxyzNbk9fp7H/Mh6Ag9FTjabkdrQtllUanyI4eE8F+2QN445Qnb9Y3JWOTW4m43+Gi5XwADtUcRJIZlcru40ioJkPKgYdTTxr/7az1RNFxntYh4k+DsW659tWRYwBXOwcFUFMHQjZhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296627; c=relaxed/simple;
	bh=27Z+U02hpliMaolKcuVpPjxRrO4I8fXKkEvzjHMY6wI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F3RYKzHjODNc1g3ilndY9hf9yQhbJYSGV+qHLW8Z7XiNiN+A/ZGH/KEXXxim/k3ozS57Zqoc8wTgPUYPjpYVqi5D15385bdh2CatuYLnzbUwA1Ks3Kft+aJyD25i0zxECO6XEYb4m73ULAVUmJz7pHP265/fIyA/1pt/4hqroaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyLC9hcl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyLC9hcl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697EC1F000C4;
	Sun, 18 Oct 2026 04:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792296626;
	bh=0/lCwDL+RkZmZOjl0EPkil75EaPPColZ+i98IbOeoEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VyLC9hclj4XB4Ar2w/Sdp7x/T8XDkFCxin/WNd28ooOcI6FaPTszdeqcliWb1Ayfq
	 ly4MXrAwDPGJVwspDrLWz/kApDQq99i2XCFaCSpnas/0uHnfch49gro3ao1au2SwXB
	 FxaZuyULnHXsVrW9tJXvNhe218dQsmSMg4+rXo0Dw9go2B79SdPXwjLLVy5vNI+AL3
	 jzJw+XjAKOtLHd1sKu+EFxsh7kGrpfLMqj79EHg5GqbCtJ0o3tlWzcEmoPSmetzE5k
	 uzslpOiGuYL4PWYftgFXQtHR1iD7RD+diPD+dEj7ByaXNvk84I4OW4VcuOJ0VIoiHT
	 y61vY1qZ7vaZQ==
Subject:
 Re: [PATCH net-next] net: phy: qcom: qca808x: Add regulator management
From: netdev-bot+sashiko@kernel.org
To: elder@riscstar.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 daniel@riscstar.com, donggeunyoo.kernel@gmail.com, ansuelsmth@gmail.com,
 mohd.anwar@oss.qualcomm.com, lorenzo.bianconi@oss.qualcomm.com,
 danielt@kernel.org, netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 18 Oct 2026 04:10:24 +0000
Message-ID: <179229662495.3135.13650075640347971471@kernel.org>
In-Reply-To: <20261014172300.292324-1-elder@riscstar.com>
References: <20261014172300.292324-1-elder@riscstar.com>
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

- [Medium] qca808x_power_on() in drivers/net/phy/qcom/qca808x.c adds four
  new DT supply properties: avdd18-supply, vdd-supply, vdd18-supply and…
- [Medium] The power-up sequence in qca808x_power_on()
  (drivers/net/phy/qcom/qca808x.c) is wrong in two ways.
- [Low] qca808x_power_on() counts a return value of 0 from
  devm_regulator_get_enable_optional() as "a regulator was found and…

--

net: phy: qcom: qca808x: Add regulator management

This commit makes qca808x_probe() enable up to four optional supplies
(avdd18, vdd, vdd18, vdd125). If any supply is found, it then sleeps for
reset_assert_delay. The supplies stay on for as long as the PHY device
exists.

> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index bab26e4c61408..6e2bd753257d9 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c

[ ... ]

> @@ -181,15 +182,44 @@ static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
>  		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
>  }
>  
> +static int qca808x_power_on(struct phy_device *phydev)
> +{
> +#ifdef CONFIG_OF
> +	static const char * const regulator_names[] = {
> +		"avdd18", "vdd", "vdd18", "vdd125"
> +	};

[Severity: Medium]
These names add new DT properties on the PHY node: avdd18-supply,
vdd-supply, vdd18-supply and vdd125-supply. Are they documented in a
binding anywhere?

Documentation/devicetree/bindings/net/qca,qca808x.yaml declares only
compatible, and it ends with:

  unevaluatedProperties: false

The common ethernet-phy.yaml schema doesn't define any supply properties
either. Wouldn't any board DTS that uses these supplies fail dtbs_check
with "Unevaluated properties are not allowed"?

Could this series include a binding update that describes each rail?
That would also make clear what "vdd" means next to "vdd18" and
"avdd18".

> +	struct device *dev = &phydev->mdio.dev;
> +	u32 count = 0;
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(regulator_names); i++) {
> +		ret = devm_regulator_get_enable_optional(dev, regulator_names[i]);
> +		if (!ret)
> +			count++;
> +		else if (ret != -ENODEV)
> +			return ret;
> +	}

[Severity: Low]
What happens here with CONFIG_OF=y and CONFIG_REGULATOR=n? In that case
the stub in include/linux/regulator/consumer.h always returns 0:

static inline int devm_regulator_get_enable_optional(struct device *dev,
						     const char *id)
{
	return 0;
}

All four lookups would count as present (count == 4), even though
nothing was powered on, and the fsleep() below would run for no reason.
QCA808X_PHY doesn't depend on or select REGULATOR, so this configuration
can be built.

Would it be better to guard on CONFIG_REGULATOR, or to stop treating
ret == 0 as proof that the supply exists?

> +
> +	if (count)
> +		fsleep(phydev->mdio.reset_assert_delay);

[Severity: Medium]
Is reset_assert_delay the right delay to use after powering up the
rails?

This value comes only from the optional reset-assert-us property.
ethernet-phy.yaml describes that property as "Delay after the reset was
asserted in microseconds". When the property is missing the value is 0,
so boards without reset-assert-us get no wait at all after the supplies
are enabled.

The ordering also looks off. mdio_device_register_reset() requests the
reset GPIO as GPIOD_OUT_LOW. So by the time drv->probe() runs, reset has
already been deasserted and reset_deassert_delay has already been spent:

phy_device_register()
    phy_device_reset(phydev, 0);
...
phy_probe()
    phy_device_reset(phydev, 0);
    phydev->drv->probe(phydev)
        qca808x_probe()
            qca808x_power_on()
                devm_regulator_get_enable_optional() ...
                fsleep(phydev->mdio.reset_assert_delay);
    phy_disable_interrupts(phydev);
    ...

This means the rails come up while reset is already released, and reset
is never pulsed once the supplies are stable. A later
phy_init_hw()->phy_device_reset(phydev, 0) does nothing, because
reset_state is already 0.

Can the MDIO accesses that phy_probe() makes right after drv->probe()
returns, such as phy_disable_interrupts() and the get_features path,
reach a PHY that isn't ready yet?

Existing QCA8081 users such as arch/arm64/boot/dts/qcom/lemans-evk.dts
have:

    reset-assert-us = <11000>;
    reset-deassert-us = <70000>;

So even on those boards, the PHY gets only the 11ms assert time after
power-up, not the 70ms post-deassert time. The commit message doesn't
explain why this delay was chosen.

> +#endif
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014172300.292324-1-elder%40riscstar.com
