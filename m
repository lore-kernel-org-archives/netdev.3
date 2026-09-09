Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F57F339394;
	Wed,  9 Sep 2026 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788924016; cv=none; b=CJFWiSBGrsCsHHzsJ7PZkRi7/hbeI8fpTkq45aEDpbCshnWwNTNhnvWaFq3HAkWKbsLlKwCVeIxp3cMZ3nFgC88nM+kfMo9aVtEOj5J+lSmFKAd/L2rVefsh3LhsLJDpZmZt+8UMXG3h9V6isaFLOJhh6Zl2fcJzY14Vh5PT/2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788924016; c=relaxed/simple;
	bh=qXCC4faZu5ZewXWBNCwNBRh9mNH5SWMd3RJblkmzcQo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ghwyz/NVIEhnAAs1XlsNkL71FkXTPUAYjgaAPrN+Mo2K380Hm+0FNi2LGJ80iGzCZiGqeSdH8U4/93dNdOi6xxmSxMx0NGxZLauwH2ERMswpSX0GVMj+x40xxvXDweOSeq4w18G3ry4C2R3GTPbAMjDtLjwXKMXaEdBBdkWuPPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn+tMtD1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn+tMtD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF71E1F00A3D;
	Wed,  9 Sep 2026 03:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788924014;
	bh=QKTMvao0zPO7nUSxOCkxsOz1mmx5QrppYLcLjFFOJH0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Jn+tMtD1HtyQmtyRQe70VDNjCUIdy9vhhBwIssw75cMpLodFFLBsRdPFOsCTkE7kc
	 xXEMszxorvb+/kgKo1KqTD+ARr/zjan22mUtGhLcayMx8yT3b17IBfMDmJ2FFcxlJq
	 74DxBYIg08qhmbylruJbC3JxCBXY34Ixl9nCDQ6LqsDZyGN//QyCHFnWu0Ik0Ch2iF
	 JCSzKkFHQcTbaMrIZYvgz/i/4ykCrIudHuKt0XID41nBjouKcSw4MhfpCyyZ0xFjnw
	 90A9mSPGvvcTxISAZe7mFbST4UDi+wfrL0dHiOsrRTWDdv1f+fZgJI8BL7haGL1x2d
	 50HdHX6R8Y5fA==
Subject: Re: [PATCH net-next v2 3/3] net: mdio: realtek-rtl9300: Support
 non-default clock frequency
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 09 Sep 2026 03:20:13 +0000
Message-ID: <178892401327.219967.6510304373643539035@kernel.org>
In-Reply-To: <20260906081946.3499898-4-markus.stockhausen@gmx.de>
References: <20260906081946.3499898-4-markus.stockhausen@gmx.de>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] RTL839x: a device tree that is fully valid against
  realtek,rtl9301-mdio.yaml can make the entire MDIO controller fail to…

--

net: mdio: realtek-rtl9300: Support non-default clock frequency

This adds a per-family set_bus_frequency() callback so the MDC clock of
the Realtek Otto MDIO controllers can be selected from the device tree
via clock-frequency, defaulting to 2.5 MHz. RTL839x only has a single
global frequency field, so the driver caches the first programmed value
and rejects a second bus asking for something else.

> diff --git a/drivers/net/mdio/mdio-realtek-rtl9300.c b/drivers/net/mdio/mdio-realtek-rtl9300.c
> index 429321e9114fd..8edb0ba0bcdd1 100644
> --- a/drivers/net/mdio/mdio-realtek-rtl9300.c
> +++ b/drivers/net/mdio/mdio-realtek-rtl9300.c

[ ... ]

> @@ -749,6 +768,40 @@ static int otto_emdio_8380_setup_controller(struct otto_emdio_priv *priv)
>  	return regmap_set_bits(priv->regmap, RTL8380_SMI_GLB_CTRL, RTL8380_SMI_PHY_PATCH_DONE);
>  }
>  
> +static int otto_emdio_8390_set_bus_frequency(struct mii_bus *bus, u32 freq)
> +{
> +	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
> +	u32 val;
> +	int err;
> +
> +	if (freq != 1250000 && freq != 2500000 && freq != 5000000)
> +		return -EINVAL;
> +	if (priv->global_freq)
> +		return freq == priv->global_freq ? 0 : -EINVAL;
> +
> +	val = FIELD_PREP(RTL8390_SMI_FREQ_SEL, freq / 2500000);
> +	err = regmap_update_bits(priv->regmap, RTL8390_SMI_GLB_CTRL, RTL8390_SMI_FREQ_SEL, val);
> +	if (!err)
> +		priv->global_freq = freq;
> +
> +	return err;
> +}

[Severity: High]
Can a device tree that is valid against realtek,rtl9301-mdio.yaml make the
whole RTL839x controller fail to probe here?

The binding describes clock-frequency as an independent per-bus property of
each mdio-bus@N child, with an implicit default:

Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
      clock-frequency:
        default: 2500000

and the realtek,rtl8391-mdio / rtl8392-mdio / rtl8393-mdio conditional only
restricts the allowed values per child bus:

            clock-frequency:
              enum: [1250000, 2500000, 5000000]

There is nothing in the schema requiring the two RTL839x child buses to name
the same frequency, so the natural way to express "set the shared field to
5 MHz" is:

	mdio-bus@0 {
		reg = <0>;
		clock-frequency = <5000000>;
		...
	};

	mdio-bus@1 {
		reg = <1>;
		...
	};

Because otto_emdio_probe_one() substitutes the default before calling the
callback:

	if (of_property_read_u32(node, "clock-frequency", &freq))
		freq = 2500000;

an absent property is indistinguishable from an explicit 2.5 MHz request.
Doesn't that mean the second bus reaches
otto_emdio_8390_set_bus_frequency() with freq = 2500000 while
priv->global_freq is already 5000000, and

	if (priv->global_freq)
		return freq == priv->global_freq ? 0 : -EINVAL;

returns -EINVAL for a device tree that never asked for two different
frequencies?  The reverse node ordering fails the same way.

otto_emdio_probe() aborts on the first failing child:

	for_each_child_of_node_scoped(dev->of_node, child) {
		err = otto_emdio_probe_one(dev, priv, child);
		if (err)
			return err;
	}

so no MDIO bus is registered at all and none of the PHYs behind the switch
are reachable.  The message "cannot set frequency 2500000 for MDIO bus 1"
also does not point at anything the device tree actually contains.

Would it make sense to either express the RTL839x restriction in the binding
(a controller level property or a dedicated conditional/schema), or to treat
an absent per-bus clock-frequency as "no constraint" instead of an explicit
2.5 MHz request, so that a schema legal device tree keeps probing?

> +
>  static int otto_emdio_9300_set_bus_frequency(struct mii_bus *bus, u32 freq)

[ ... ]

> @@ -865,6 +933,13 @@ static int otto_emdio_probe_one(struct device *dev, struct otto_emdio_priv *priv
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
>  	err = devm_of_mdiobus_register(dev, bus, node);
>  	if (err)
>  		return dev_err_probe(dev, err, "cannot register MDIO bus\n");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260906081946.3499898-1-markus.stockhausen%40gmx.de
