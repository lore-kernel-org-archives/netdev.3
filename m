Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0304F4FDE43;
	Wed, 16 Sep 2026 13:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565731; cv=none; b=rzhfJoTvCdDQjz9wDda7PEmicxUf+SqZjsQ3S0Exofx/Q12XxmGxVwe3aoh59U+LNMynCACRdGJ0XcuU6ZSzdzMKaGgMBDim7qQS+SWl9tmcq3guq2mOKH7cKKgZzAk99bgbBjQIgW7FLZMaJ7+rOTYXQZpdK78OsoU0O67p8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565731; c=relaxed/simple;
	bh=6cSsG/UzwDbN9PbNWB4YgTd1pn3YEnZfMtaxcaQJ6/c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pDFYMj3Ksb+LuEN01gWLRHk83TqAQPPGoAcERcK6whHLAnsxkSMOxr56PFJNjgLa3gjIOOE8WYkuvYNOLaZMokW5Nif0d4yK+9S/iPvR7HaRW2N5RzbWiC/kBKq5V/U75pwT7x8JVmM5oDQk1+q+gldHam41Jly9Fv9axM02WyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKYnDYAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKYnDYAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D721F00899;
	Wed, 16 Sep 2026 13:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789565716;
	bh=ChLlQzNrhwS4joheCtDQWKWA40+S8/MWPopMbsdf+7Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jKYnDYAfTm+39tFvqVO2fM4ZHAX2IUyiWuzylu6sHn/LOtSfhTx923Sq99iiUOdV2
	 nRVt0cx8gg8AB9TY9NSoYXXxV1VgjgJE1S+SFfKEVegoQREmFOf9wZ4K6ZtjKzH3fx
	 vEu2B24b5a0edD7jJtCFCOZLbK+kdfDNVlwaDVCg45bzNOUfrziIOxRsKrvTH82vl2
	 6k48FZGbOd8XmyxXilhBiLzHRWo7aOcyfRbfSv9dw8JGzhRBXVpTsbfVYsKKFD9ESi
	 3KZ5kllh4NcOCBuI1/yqNTxEPwd0XgJgcF+XHjGdH+HO8andH0Ez2ATQ1OcLfPcVmv
	 irDlu1TmzaQYg==
Subject: Re: [PATCH net-next v4 5/5] net: mdio: realtek-rtl9300: support
 non-default clock frequencies
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 16 Sep 2026 13:35:14 +0000
Message-ID: <178956571495.22033.15528886965131071953@kernel.org>
In-Reply-To: <20260912130451.3757276-6-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-6-markus.stockhausen@gmx.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] otto_emdio_8390_set_bus_frequency() (drivers/net/mdio/mdio-
  realtek-rtl9300.c:769-806) can reject a frequency taken from a…

--

net: mdio: realtek-rtl9300: support non-default clock frequencies

This adds support for selecting the MDC clock frequency of the Realtek
Otto switch MDIO controllers via the clock-frequency device tree
property, defaulting to 2.5 MHz. RTL839x is handled specially because
both of its MDIO buses share one frequency selector field.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 45cbefc52100a..bde0cf5e0b798 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -748,6 +766,60 @@ static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
>  	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_PHY_PATCH_DONE);
>  }
>  
> +static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 freq)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	u32 mdio_bus, child_freq, val;
> +	bool freq_set = false;
> +	int err;
> +
> +	/*
> +	 * RTL839x uses one frequency shared by both MDIO buses. Use the frequency passed by the
> +	 * caller as fallback, but prefer an explicitly requested frequency from any valid,
> +	 * available bus. Reject conflicting explicit requests. Only the first call programs the
> +	 * shared frequency.
> +	 */
> +	if (priv->bus[0] || priv->bus[1])
> +		return 0;
> +
> +	for_each_available_child_of_node_scoped(bus->parent->of_node, child) {
> +		err = of_property_read_u32(child, "reg", &mdio_bus);
> +		if (err || mdio_bus >= priv->info->num_buses)
> +			continue;
> +
> +		if (of_property_read_u32(child, "clock-frequency", &child_freq))
> +			continue;
> +
> +		if (freq_set && freq != child_freq)
> +			return -EINVAL;
> +
> +		freq = child_freq;
> +		freq_set = true;
> +	}
> +
> +	if (freq != 1250000 && freq != 2500000 && freq != 5000000)
> +		return -EINVAL;

[Severity: Low]
Can the diagnostic printed by the caller name a frequency and a bus that
were never the ones rejected here?

In otto_emdio_8390_set_bus_frequency() the freq argument is overwritten by
any sibling child node that carries clock-frequency:

	freq = child_freq;
	freq_set = true;

and the enum check afterwards then validates that inherited value, but the
bare -EINVAL carries none of that context back to
otto_emdio_probe_one().

For a RTL839x mdio-controller node where mdio-bus@0 has no
clock-frequency and mdio-bus@1 has clock-frequency = <7000000>, probing
bus 0 defaults freq to 2500000, the loop replaces it with 7000000, the
enum check fails, and the message reads:

	cannot set frequency 2500000 for MDIO bus 0

2500000 on bus 0 is a legal combination, so would it be clearer to report
the offending child node and its frequency from inside
otto_emdio_8390_set_bus_frequency() instead?

The same applies to the conflict path: with mdio-bus@0 = 1250000 and
mdio-bus@1 = 5000000, the message names bus 0 and 1250000 even though the
rejected condition is the conflict with mdio-bus@1.

> +
> +	val = FIELD_PREP(RTL8390_SMI_FREQ_SEL, freq / 2500000);
> +
> +	return regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_SMI_FREQ_SEL, val);
> +}
> +

[ ... ]

> @@ -867,6 +954,13 @@ static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv
>  
>  	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
>  
> +	if (of_property_read_u32(node, "clock-frequency", &freq))
> +		freq = 2500000;
> +	err = priv->info->set_bus_frequency(bus, freq);
> +	if (err)
> +		return dev_err_probe(dev, err, "cannot set frequency %u for MDIO bus %d\n",
> +				     freq, mdio_bus);
> +

[Severity: Low]
This is the message referred to above: it always uses the local node's
freq and mdio_bus, which for the RTL839x callback need not be the value or
the bus that was actually rejected.

>  	err = devm_of_mdiobus_register(dev, bus, node);
>  	if (err)
>  		return dev_err_probe(dev, err, "cannot register MDIO bus\n");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912130451.3757276-1-markus.stockhausen%40gmx.de
