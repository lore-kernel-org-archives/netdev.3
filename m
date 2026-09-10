Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F94A3418;
	Thu, 10 Sep 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789052680; cv=none; b=dqvBzJHFUu8adwqFOAMpbvdDN47UVuMQyHrYJzP754Q/kdhB/y/W7BM2Zng2fvlPfaeViJtxe6rmouDciVqk1VvTQEMWHleD4JLsDNeAdIViJvGWnElmBIH2WFQ1CcILaYRCGooh4wK9CbjlSD5CZAbJP+dJrx1YtlZEryYvqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789052680; c=relaxed/simple;
	bh=auFCYCQBNmIB4qbI9YE6zn6eM/BBx11dyKziC4WkaUw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbAXxYpEjYcNb0jYmsy8JXE8RvPRT+fFPwhe6m3Og4KQf726gVkMYy/toMbz+4BLIN1X+elx+8NeE9spmqI4UQ7OKTF8ViGEFBC0zvQ474RI+dANsRMrHIkVJlRNM8CKoBJQlsFd7bi6DaTzIUeAht75f/7RCsdoyyUDaiOoeZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbnZPEvp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbnZPEvp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6B31F00898;
	Thu, 10 Sep 2026 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789052672;
	bh=WKDFS/bk7dwLjzl5HtuFRkL024vyqQIqeRQzeSlFSSI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TbnZPEvpNeD5eFudkQpjeYJfhG1NL3w0SkesuuwWV9L0+M1JcT03Nf3thWdPDJuc2
	 rHlD+JVVzFqgTxGlU+AwpTJBnDCBkk+k/JbAwoFvEOMuiEYHfIn9KI7xhFmanPah0f
	 E6x6dI/cES/mTl+fU1tBf/7owVeCxV67T3G/QgUW3Kk30TsAP9xP+xGV3shKQzwlis
	 P0OUdc/LxFcd8DwvepskA16b6Ld6aCRcNqV2K3dmkhpQGlIR4t+XzVnVFJopSnDExI
	 oueKydBJFOsr2b9DeiOVLSWG71rhppwxbHwDWW931lpfv4BpssvCpxh6FHkPt0mSPI
	 RrBW+Ot43ykfg==
Subject: Re: [PATCH net-next v3 4/4] net: mdio: realtek-rtl9300: Support
 non-default clock frequency
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Thu, 10 Sep 2026 15:04:31 +0000
Message-ID: <178905267175.219967.17355311264285356501@kernel.org>
In-Reply-To: <20260909150107.3602067-5-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-5-markus.stockhausen@gmx.de>
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

- [Medium] RTL839x: the single global MDC divider is derived from per-bus
  DT properties in a way that both rejects schema-valid device trees and…
- [Medium] `otto_emdio_probe_one()` now programs the MDC frequency
  selector on every probe even when the device tree says nothing: `if…
- [Low] The new diagnostic in `otto_emdio_probe_one()` prints values that
  are not the ones that were rejected on RTL839x: `dev_err_probe(dev,…

--

net: mdio: realtek-rtl9300: Support non-default clock frequency

This adds a per-family set_bus_frequency callback to the Realtek Otto
eMDIO driver and wires it into otto_emdio_probe_one(), so the MDC clock
rate can be selected from the mdio-bus child node via clock-frequency.
RTL839x is handled specially because both of its buses share a single
divider.

A few questions about the new code below.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 14fc98949fa3..d40fdd0ed2f0 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -740,6 +747,17 @@ static int otto_emdio_setup_topology(struct otto_emdio_priv *priv)
>  	return 0;
>  }
>  
> +static int otto_emdio_8380_set_bus_frequency(struct mii_bus *bus, u32 freq)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +
> +	if (freq != 2500000 && freq != 10000000)
> +		return -EINVAL;
> +
> +	return regmap_assign_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
> +				  RTL8380_SMI_FREQ_SEL, freq == 10000000);
> +}
> +
>  static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
>  {
>  	/*
> @@ -749,6 +767,57 @@ static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
>  	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_PHY_PATCH_DONE);
>  }
>  
> +static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 freq)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	bool freq_set = false;
> +	u32 child_freq, val;
> +	int err;
> +
> +	/*
> +	 * RTL839x uses a single frequency for the two MDIO buses. During registration of first
> +	 * bus pick an explicitly requested frequency from any enabled bus. Use the default only
> +	 * if no frequency is set at all.
> +	 */
> +	if (priv->bus[0] || priv->bus[1])
> +		return 0;
> +
> +	freq = 2500000;
> +	for_each_available_child_of_node_scoped(bus->parent->of_node, child) {
> +		if (of_property_read_u32(child, "clock-frequency", &child_freq))
> +			continue;
> +
> +		if (freq_set && freq != child_freq)
> +			return -EINVAL;
> +
> +		freq = child_freq;
> +		freq_set = true;
> +	}

[Severity: Medium]
Two questions about the arbitration in otto_emdio_8390_set_bus_frequency().

freq_set is only set for children that actually carry clock-frequency, so a
child without the property never takes part in the comparison. With this
device tree:

	mdio-bus@0 { };
	mdio-bus@1 { clock-frequency = <5000000>; };

does bus 0 end up physically clocked at 5 MHz, although its node requests
nothing and the binding documents 2500000 as the per-bus default? There is
no error and no warning on that path.

The other direction is the -EINVAL return when two children carry different
explicit values, which fails the probe of the whole controller. The binding
patch in this series applies the enum [1250000, 2500000, 5000000] per
mdio-bus child for the rtl8391/8392/8393 compatibles in the same way as for
930x/931x, and does not document the RTL839x "one divider for both buses"
restriction anywhere.

Should the binding express that restriction, or should the driver treat a
missing clock-frequency on an available bus as the documented 2500000 when
arbitrating?

One more thing about the loop: it walks every available child of the parent
rather than only the buses that will be registered, so a dangling child such
as mdio-bus@2 on a two-bus RTL839x, which otto_emdio_probe_one() later
rejects with

	if (mdio_bus >= priv->info->num_buses)

can still select or conflict with the global frequency. Is that intended?

Note also that this is the only one of the four implementers that discards
its freq argument and returns 0 for every bus after the first, so the
callback signature int (*set_bus_frequency)(struct mii_bus *bus, u32 freq)
is not really honoured for RTL839x.

> +
> +	if (freq != 1250000 && freq != 2500000 && freq != 5000000)
> +		return -EINVAL;
> +
> +	val = FIELD_PREP(RTL8390_SMI_FREQ_SEL, freq / 2500000);
> +	err = regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_SMI_FREQ_SEL, val);
> +
> +	return err;
> +}
> +
> +static int otto_emdio_9300_set_bus_frequency(struct mii_bus *bus, u32 freq)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	struct otto_emdio_chan *chan = bus->priv;
> +	u32 mask, val;
> +
> +	if (freq != 1250000 && freq != 2500000 && freq != 5000000)
> +		return -EINVAL;
> +
> +	mask = RTL9300_SMI_FREQ_SEL(chan->mdio_bus);
> +	val = field_prep(mask, freq / 2500000);
> +
> +	return regmap_update_bits(priv->regmap, RTL9300_SMI_GLB_CTRL, mask, val);
> +}
> +
>  static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
>  {
>  	u32 glb_ctrl_mask = 0, glb_ctrl_val = 0;
> @@ -769,6 +838,21 @@ static int otto_emdio_9300_setup_controller(struct otto_emdio_priv *priv)
>  	return 0;
>  }
>  
> +static int otto_emdio_9310_set_bus_frequency(struct mii_bus *bus, u32 freq)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	struct otto_emdio_chan *chan = bus->priv;
> +	u32 mask, val;
> +
> +	if (freq != 1250000 && freq != 2500000 && freq != 5000000)
> +		return -EINVAL;
> +
> +	mask = RTL9310_SMI_FREQ_SEL(chan->mdio_bus);
> +	val = field_prep(mask, freq / 2500000);
> +
> +	return regmap_update_bits(priv->regmap, RTL9310_SMI_GLB_CTRL0, mask, val);
> +}
> +

[ ... ]

> @@ -868,6 +952,13 @@ static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv
>  
>  	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-%d", dev_name(dev), mdio_bus);
>  
> +	if (of_property_read_u32(node, "clock-frequency", &freq))
> +		freq = 2500000;
> +	err = priv->info->set_bus_frequency(bus, freq);

[Severity: Medium]
There is no "property absent, leave the hardware alone" path here. When
clock-frequency is missing, 2500000 is synthesized and set_bus_frequency()
is still called, so the selector field is written on every probe. Before
this patch nothing in the driver touched RTL8380_SMI_GLB_CTRL bit 1,
RTL8390_SMI_GLB_CTRL bits 6:5, or the new selector fields in
RTL9300_SMI_GLB_CTRL and RTL9310_SMI_GLB_CTRL0.

For RTL838x the default path ends up in:

	regmap_assign_bits(priv->regmap, RTL8380_SMI_GLB_CTRL,
			   RTL8380_SMI_FREQ_SEL, freq == 10000000);

which clears the bit. On a board where the bootloader selected 10 MHz, does
an unmodified device tree now silently drop the MDC rate back to 2.5 MHz?

The 839x/930x/931x implementers derive the register value arithmetically as
freq / 2500000, that is 0 for 1.25 MHz, 1 for 2.5 MHz and 2 for 5 MHz. Is
that mapping taken from the datasheet? The encodings are also asymmetric:
2.5 MHz means a cleared bit on RTL838x but field value 1 on the other three.
If the two-bit field is not ordered 0/1/2 that way, every existing device
tree without clock-frequency now gets an unintended MDC rate while the
driver believes it kept the default.

The commit message says only that the change "allows to set the clock
frequency via device tree". Could it also state that the frequency selector
is now reprogrammed on every probe, including for device trees that do not
set the property?

> +	if (err)
> +		return dev_err_probe(dev, err, "cannot set frequency %u for MDIO bus %d\n",
> +				     freq, mdio_bus);

[Severity: Low]
On RTL839x, can this message name values that were not the ones rejected?
otto_emdio_8390_set_bus_frequency() overwrites freq locally with 2500000 and
decides the failure from a sibling node's clock-frequency, while the caller
prints the freq and mdio_bus of the node currently being probed. For:

	mdio-bus@0 { };
	mdio-bus@1 { clock-frequency = <10000000>; };

the log would read "cannot set frequency 2500000 for MDIO bus 0", even
though 2500000 is a legal value and bus 0 is not the offending node. A
mismatch between the two buses is likewise always reported against whichever
child is probed first.

> +
>  	err = devm_of_mdiobus_register(dev, bus, node);
>  	if (err)
>  		return dev_err_probe(dev, err, "cannot register MDIO bus\n");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909150107.3602067-1-markus.stockhausen%40gmx.de
