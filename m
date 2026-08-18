Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F12EDD58;
	Tue, 18 Aug 2026 01:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016262; cv=none; b=g0H3/GgWRpwwU/AOWs+MPwFVh82xN5lxbfC13wd+RrVd1UellQF3UZZUkgsyMoVhhpAzyUgmbTbhNLwZLMgmAlrZr5DxWuzmOYLNpiD/rTRrDRdjqrvWXIzm2lEOydSYyPJIBycIlj7pu581jhfQIzetLr4PWmu/vMH7kfegbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016262; c=relaxed/simple;
	bh=I/mr6Xnb9Ry80iD3NZjnITjMhapPOE95OMvrGk4Epoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EknsJLBQrjA54NO7zoBpKRFG6iYDHVpCamTY4GfsgTFMMEQ2N3SrsmZSf8JkIG63itW8WJxpVAfBw85ivkqhdQcoXLIJ5elP3GxFBqTDhKlp6YE3QSEx8CSoJYk3g3akBWDVYOUZGrGpALvKNNTlHljcTmj1RG6+zK+FrSJlJC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOQFJqBK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOQFJqBK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EDB1F000E9;
	Tue, 18 Aug 2026 01:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016258;
	bh=aNLHpkYafhg2PTCALR2xOtxs2aJBDez3cvEe7f0AVZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOQFJqBKpbip1koS0seGYL/6tHEHlP+KQ0eDDsMj3zTf1rLA4KKkwZdLVq2DPEHP1
	 ScnVdlv4bq45Cw7fAN7rQp4XPjWwFCKhBBV7LlxuGNjQMWgLkFybJEIqAHFH4Ze3tF
	 Gm/bD6+9dYEN9pyw1nb3P89lHwcGoe3ZigJ8PcDnK3Z+fKstHRWpQoPD8iV9CFk+df
	 MOzA9AQKGyMaAVTCw1Uwv7dRFsdHX2ulrPuteUmjj5hy2Ida6RvY8kp93x/HMfbg57
	 3A7FGL36ylkjOqWByGaHV8I/JiSjs2D98PUrCO9pLlfZw3dsXrWBMAPRNegT9+aXAH
	 Ze6E5bfFXOX0A==
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
Subject: Re: [PATCH net-next v8 1/2] dt-bindings: net: x-powers: add AC200/AC300 EPHY packages
Date: Mon, 17 Aug 2026 18:24:16 -0700
Message-ID: <20260818012416.3826448-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813-submit-acx00-of-dynamic-v1-v8-1-d2f1c52e87b4@gmail.com>
References: <20260813-submit-acx00-of-dynamic-v1-v8-1-d2f1c52e87b4@gmail.com>
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
dt-bindings: net: x-powers: add AC200/AC300 EPHY packages

This adds a new binding describing the X-Powers AC200 and AC300 Ethernet
PHY packages, with separate compatibles for each fixed variant plus an
ACx00 compatible for boards that can carry either part. It documents the
package clock, supply, packed NVMEM configuration field and the phandle
used to reach the AC200 companion IC.

> diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
> new file mode 100644
> index 0000000000000..afe57bd163dd7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
> @@ -0,0 +1,154 @@

[ ... ]

> +  x-powers,ac200:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the AC200 companion IC providing I2C access to the package
> +      control registers used to power and configure the Ethernet PHY.

[Severity: Low]
Is there a binding for the node this phandle is supposed to point at?

A case-insensitive grep for ac200 under Documentation/devicetree/bindings at
the end of this series matches only this new file; the x-powers mfd directory
contains just x-powers,ac100.yaml and x-powers,axp152.yaml. So the
compatible, bus position (I2C child) and properties of the phandle target
appear to be undocumented, and any device tree using the ac200 or acx00
compatibles would carry a node that dtbs_check reports as undocumented.

The same gap seems to exist on the driver side. ac200_ephy_ctl_create() in
drivers/net/phy/xpowers/ac200.c resolves the phandle and then needs a bound
I2C client with a regmap and a clock:

  client = of_find_i2c_device_by_node(ac200_node);
  ...
  device_lock(&client->dev);
  if (device_is_bound(&client->dev))
          priv->regmap = dev_get_regmap(&client->dev, NULL);
  device_unlock(&client->dev);
  if (!priv->regmap) {
          ret = dev_err_probe(dev, -EPROBE_DEFER, "AC200 driver is not ready\n");

A grep for ac200 in drivers/mfd returns nothing at the end of this series,
so is there any in-tree driver that can bind such an I2C device and provide
that regmap and clock? If not, this path can only ever return -EPROBE_DEFER,
and the AC200/ACx00 half of the new ABI, including the packed NVMEM bit
layout consumed only through that path, cannot be exercised or validated by
a conforming device tree.

Could the companion IC binding be added (or referenced) alongside this file?

> +
> +  x-powers,xmii-rx-clock-inverted:
> +    type: boolean
> +    description:
> +      Invert the xMII receive clock inside the PHY. This is required by some
> +      SoC integrations, including the Allwinner H6 AC200 connection.
> +
> +patternProperties:
> +  ^ethernet-phy@[a-f0-9]+$:
> +    $ref: ethernet-phy.yaml#
> +    properties:
> +      compatible:
> +        const: ethernet-phy-id0044.1400
> +    required:
> +      - compatible
> +    unevaluatedProperties: false

[Severity: Low]
This isn't a bug, but should the child node's reg be constrained here too?

The child schema overrides only compatible, so the link PHY's reg keeps
ethernet-phy.yaml's 0..31 range. The description in this same file says "The
package and child use the same base address", and the ac300/acx00
conditionals below limit the package reg to 7, but neither constraint reaches
the child. A tree like:

  ethernet-phy-package@0 {
          reg = <0>;
          ethernet-phy@1f {
                  reg = <0x1f>;
          };
  };

passes dt_binding_check, as does an AC300 child above address 7.

Nothing is misprogrammed at runtime: acx00_ephy_init_package() in
drivers/net/phy/xpowers/acx00.c rejects the mismatch before joining the
package,

  ret = of_property_read_u32(package_node, "reg", &base_addr);
  if (ret || base_addr != phydev->mdio.addr) {
          ret = dev_err_probe(dev, -EINVAL,
                              "package and link PHY addresses differ\n");

and ac300_ephy_ctl_create() in drivers/net/phy/xpowers/ac300.c rejects
addresses above 7 before any control-range access:

  if (phydev->mdio.addr > FIELD_MAX(AC300_PACKAGE_PHY_ADDR_MASK))
          return ERR_PTR(dev_err_probe(dev, -EINVAL,
                                       "link address is outside the package range\n"));

So the only effect is that an invalid tree fails PHY probe instead of failing
schema validation. Bounding the child reg per variant in the added
patternProperties block would move that detection to dt_binding_check. Note
the existing package binding qcom,qca807x.yaml adds no child-address
constraints either, so the omission matches current convention.

> +
> +required:
> +  - compatible
> +  - vcc-supply

[ ... ]

> +  - if:
> +      properties:
> +        compatible:
> +          const: x-powers,acx00-ephy-package
> +    then:
> +      properties:
> +        reg:
> +          maximum: 7
> +      required:
> +        - clocks
> +        - nvmem-cells
> +        - nvmem-cell-names
> +        - x-powers,ac200

[ ... ]
-- 
pw-bot: cr
