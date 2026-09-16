Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043672F3C37;
	Wed, 16 Sep 2026 13:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565721; cv=none; b=iPtfHDz0zqvWbxugUpsStIsOkt9PJY447aTmKDm1bype3ZGsUg9HjYftYCr8tIWOYAMuaktlXbOVOS1t8n8yaSKQ2DPdP4xYXI9h3Lpvprk4mQnZC30oa8FPT9BMtnXV9p8CnOntORTAFVRmk9XID1mx/ht4s+8/sychuCwbY6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565721; c=relaxed/simple;
	bh=8c+Ih8ohBd+ZZXZ8LkJA0DAxZtXRKF7WvXeI1ZMU9xA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WX3kWnOQyhaTEHwr5YvvTuXDyhCIC2J3UGdKDgLXNgcTi7uXQqpaYcVBNV7dZ9tDAU9N4NiSDRO5oBd+ezBOBnOAbpcUi23YNsjRfSl6hyvIWffcE+tghaA3FIn6A3Zq9C5M1HpJiAnwMxOZ0kUXIn+UcniG+9yfSBKOhpHTgzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMjfjXIz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMjfjXIz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBD31F000FF;
	Wed, 16 Sep 2026 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789565712;
	bh=g+Cz0fWQu62gHPs90EXYqySa/IXT3g3HhC6uXHnEQHU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NMjfjXIznuULKbmIedHC0I9O5CsVFsLmyR6NV2S3cn4xlEuIvMcsnKoqXmZbw1Wpr
	 9Ly8LESWKPjAGtAQTIYmMC1FKDRHSwuI6k+nmvO6oECoh4+zuM2V3OkcAnarc7OaVw
	 7/QRQxuuVf+WWV5Bidk5R5YkmiOGXj5zOyLTzsgB+mAWG4Qk/HS7YSxYp3LwPUEJwy
	 egKFHqcUTGwnkrV5dt4bxuvGsCZvVftWRQgZd8FY3vJ2wpywGWJyyJm0YFhb2Altns
	 FeTuu8tabSWwj5Prws322m/4lDzTnQ/FWn4lZu7Sc43jPKR/bp4LgCPvoU73HfvcdN
	 5te/RVc5jPZTw==
Subject: Re: [PATCH net-next v4 1/5] dt-bindings: net: realtek,rtl9301-mdio:
 restrict MDIO buses by family
From: netdev-bot+sashiko@kernel.org
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Wed, 16 Sep 2026 13:35:10 +0000
Message-ID: <178956571096.22033.1324157422276350284@kernel.org>
In-Reply-To: <20260912130451.3757276-2-markus.stockhausen@gmx.de>
References: <20260912130451.3757276-2-markus.stockhausen@gmx.de>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete constraint: the new per-family `allOf`/`if-then`
  blocks in…

--

dt-bindings: net: realtek,rtl9301-mdio: restrict MDIO buses by family

This adds two per-family conditional blocks to the Realtek Otto MDIO
controller binding so that mdio-bus child node names are limited to the
number of buses each family has: one for RTL838x, two for RTL839x and
four for RTL930x/RTL931x.

> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> index 67e0b23a8470e..7f5b4897487b2 100644
> --- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> +++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
> @@ -67,6 +67,30 @@ patternProperties:
>  
>      unevaluatedProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - realtek,rtl8380-mdio
> +              - realtek,rtl8381-mdio
> +              - realtek,rtl8382-mdio
> +    then:
> +      patternProperties:
> +        '^mdio-bus@[1-3]$': false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - realtek,rtl8391-mdio
> +              - realtek,rtl8392-mdio
> +              - realtek,rtl8393-mdio
> +    then:
> +      patternProperties:
> +        '^mdio-bus@[2-3]$': false

[Severity: Medium]
These two conditionals only reject child node names, but the bus index the
driver consumes is the child's reg value.  Should the same conditionals also
bound reg?

The mdio-bus subschema keeps reg unconstrained apart from the item count,
for every compatible:

  patternProperties:
    '^mdio-bus@[0-3]$':
      $ref: mdio.yaml#

      properties:
        reg:
          maxItems: 1

      required:
        - reg

So this still validates cleanly against the RTL838x branch:

  mdio-controller@ca00 {
    compatible = "realtek,rtl8380-mdio";
    ...
    mdio-bus@0 {
      reg = <3>;
      ...
    };
  };

otto_emdio_probe_one() in drivers/net/mdio/mdio-realtek-rtl9300.c takes the
index from reg and never looks at the unit address:

  err = fwnode_property_read_u32(node, "reg", &mdio_bus);
  if (err)
          return dev_err_probe(dev, err, "undefined smi bus number\n");

  if (mdio_bus >= priv->info->num_buses)
          return dev_err_probe(dev, -EINVAL,
                               "illegal (dangling) smi bus number %d\n", mdio_bus);

and otto_emdio_map_ports() repeats the same check.

dtc does not close the gap either.  check_unit_address_vs_reg() in
scripts/dtc/checks.c only checks that a unit address exists when reg is
present:

  if (prop) {
          if (!unitname[0])
                  FAIL(c, dti, node, "node has a reg or ranges property, but no unit name");
  } else {
          if (unitname[0])
                  FAIL(c, dti, node, "node has a unit name, but no reg or ranges property");
  }

Numeric unit-address-vs-reg equality is only enforced for simple-bus, i2c,
spi and pci children, and an mdio-controller node is none of those.

The commit message says the current binding is "allowing non-existent buses
to be described for RTL838x and RTL839x devices".  With only the node names
restricted, a non-existent bus can still be described through reg and is
caught only at probe time.  Would adding a per-family maximum on the child
reg inside these conditionals match what the message describes?
Documentation/devicetree/bindings/net/marvell,pp2.yaml has the same shape
with properties: reg: maximum: inside a per-compatible conditional.

Note this is still the case at the end of the series (7c4e9351a929), where
the mdio-bus subschema declares only reg: maxItems: 1.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260912130451.3757276-1-markus.stockhausen%40gmx.de
