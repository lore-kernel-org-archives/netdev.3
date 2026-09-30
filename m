Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92A502573;
	Wed, 30 Sep 2026 21:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803864; cv=none; b=OpUMXn7bBpDC0f5aoVa8jRLAWNW4JOkaCX9G2eTrm6Dzd9qzKnyujSoTY7GCjPqy2UtJcxDaWdu7wV2EbDqU93ITgH5tu6YegSZVSP3Vf2d6GgUjmA75AveMCulH45EqSIEvJGB7BrRh2yX3XzYqNoHLq5zQ5FiSKs+1LSoIQiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803864; c=relaxed/simple;
	bh=HEnOXgZHsTvZ4AjtnABwiO12AGhGjlUX+7loyPq4tSk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8PxWZarn4XsdvjOARJs5TSoZbHEP705ssxvpxcv3pJlx2PeDit64dgX0IN/3nh3mrNDftvaYcx1bE6T/IahDXfRvqeRRsz+zGNpPiJ0rSflsjSe1OrW18WyM/rbLjF0W5g6O/5RPCD9JsKeiwX5Mf48LEdNgtrwmXHndskI7GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks1p6wrw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks1p6wrw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B2F1F00898;
	Wed, 30 Sep 2026 21:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803862;
	bh=WvR9TuwFHwG5+pKVbqq5tt5JQ1ELDNUt0+EKTsq293I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ks1p6wrwKSWXCLYEG0YG+VVJG84Pblwqs8/DUgHTQoh4E2KhU+5yQkfb9ExeP1rBJ
	 vrWKVYJ7acqZUUlpimhf++Vbvg/aW9TnSX/fUikJrXkKfM5Z+sQ5t5K71bFwCi5ImQ
	 AZltXANuDqd48Hc9G8JepXme4JW7TFdi8RudB1UXpFzno8QEwKkyF1xEkBD9rxCgzw
	 Bgi9c3FkCsk88WpoPKH1eGjs/FxrH5wiXpNTSpEHauYHvVA1VVqIwHIz3uxZEGO2Zi
	 cB3bfA4PLrx4SGyUJqj8zFqVVjTX0kluLo+hL+S7bdYY61xNtrYlbTrMEmFA1/Y+Fz
	 lxwpbHL/FPwyA==
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
From: netdev-bot+sashiko@kernel.org
To: kyle.swenson@est.tech
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, roland.kovacs@est.tech, david.nystrom@est.tech
Date: Wed, 30 Sep 2026 21:31:01 +0000
Message-ID: <179080386104.434549.3258893771677294367@kernel.org>
In-Reply-To: <20260927212929.593366-2-kyle.swenson@est.tech>
References: <20260927212929.593366-2-kyle.swenson@est.tech>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The binding does not describe the LTC4266's board-level control
  and supply resources.
- [Low] The commit message for "dt-bindings: net: pse-pd: Add bindings
  for LTC4266 PSE Controller" is one sentence ("Add the LTC4266 Power…
- [Low] The `pse-pi@[0-3]` subschema describes `pairsets` as "exactly one
  channel phandle is expected", and the `channels` description says the…
- [Low] `interrupts` is in the top-level `required` list of
  lltc,ltc4266.yaml (line 94).

Pre-existing issues:
- [Low] This problem wasn't introduced by this patch, but the base pse-
  controller.yaml (which lltc,ltc4266.yaml inherits) and the LTC4266…

--

dt-bindings: net: pse-pd: Add bindings for LTC4266 PSE Controller

This commit adds a YAML device tree binding for the Linear Technology
LTC4266 PSE controller. The binding describes the chip's four delivery
channels, each with a sense resistor value, and PSE PIs that each map to
one channel.

> dt-bindings: net: pse-pd: Add bindings for LTC4266 PSE Controller
>
> Add the LTC4266 Power Sourcing Equipment controller device tree bindings
> documentation.

[Severity: Low]
This isn't a bug, but the subject says "binding" twice.
Documentation/devicetree/bindings/submitting-patches.rst asks submitters
to avoid that:

  Repeating "binding" again should also be avoided, so for a new device it
  is often enough for example: "dt-bindings: iio: adc: Add ROHM BD79100G"

Could the body also describe the hardware, a 4-port 802.3at PSE on I2C?
Could it also explain the ABI choices that differ from the sibling PSE
bindings? These are:

- a new required per-channel sense-resistor-micro-ohms property with a
  fixed 250000/500000 enum
- channels and pse-pis are both required (ti,tps23881.yaml requires
  neither)
- each PI is limited to a single pairset

> diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> new file mode 100644
> index 0000000000000..e11c9d601eee9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> @@ -0,0 +1,180 @@

[ ... ]

> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc4266
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1

[Severity: Low]
Should this list also have reset-gpios for the chip's active-low RESET
input? Should it have supply properties for the VDD and VEE rails?

The schema ends with unevaluatedProperties: false. A board DT that routes
RESET to a SoC GPIO, or names its VDD/VEE regulators, would fail
validation. writing-bindings.rst says:

  DO attempt to make bindings complete even if a driver doesn't support
  some features.

The sibling ti,tps23881.yaml in the same directory documents its reset
line:

  reset-gpios:
    maxItems: 1

The driver patch in this series ("net: pse-pd: Add LTC4266 PSE controller
driver") only resets the chip in software, through the RSTPB register in
ltc4266_probe():

  ret = regmap_write(regmap, LTC4266_REG_RSTPB, LTC4266_RSTPB_INTCLR | LTC4266_RSTPB_RSTALL);

Suppose a board's RESET GPIO is asserted by default. Won't the chip stay
in reset, so the ID read in probe fails? Nothing in the DT would let the
driver deassert the line.

[ ... ]

> +    patternProperties:
> +      '^pse-pi@[0-3]$':
> +        type: object
> +        additionalProperties: true
> +        properties:
> +          pairsets:
> +            description: The LTC4266 delivers power to a PI over a single
> +              pairset, driven by one of the controller's four channels. There
> +              is no 4-pair mode spreading a PI over two channels, so exactly
> +              one channel phandle is expected.
> +            maxItems: 1
> +          pairset-names:
> +            maxItems: 1

[Severity: Low]
The description says exactly one channel phandle is expected. Should
pairsets and pairset-names also be marked required in this subschema?

The only required entries inherited from pse-controller.yaml are reg and
#pse-cells. The PSE core's of_load_pse_pis() accepts a pse-pi that has no
pairsets. It takes the -ENOENT branch and leaves pairset[0].np NULL:

  } else if (ret != -ENOENT) {

The driver patch in this series then rejects that case in
ltc4266_map_pis():

  if (!pi->pairset[0].np)
          return dev_err_probe(ltc4266->dev, -EINVAL,
                               "%pOF has no pairsets\n", pi->np);

So there is no NULL dereference. However, a DT with a PI that has no
channel mapping passes dtbs_check and then makes pse_controller_register()
fail. That takes down all four ports.

Would adding this to the pse-pi subschema close the gap?

  required:
    - pairsets
    - pairset-names

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch.
Neither this subschema nor the base pse-controller.yaml requires pairsets
and pairset-names to appear together, for example with dependentRequired.

of_load_pse_pi_pairsets() in drivers/net/pse-pd/pse_core.c checks this at
runtime:

  ret = of_property_count_strings(node, "pairset-names");
  if (ret != npairsets) {
          pr_err(...);
          return -EINVAL;
  }

So a node with pairsets = <&phys0>; and no pairset-names passes schema
validation and then fails controller registration.

ti,tps23881.yaml and skyworks,si3474.yaml have the same gap. Would this be
better fixed once in pse-controller.yaml?

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - channels
> +  - pse-pis

[Severity: Low]
Does interrupts need to be required? The requirement seems to come from
the driver rather than the hardware. Without an IRQ, the driver patch in
this series fails probe in ltc4266_probe():

  if (!client->irq)
          return dev_err_probe(&client->dev, -EINVAL,
                               "Interrupt is required for power budget management\n");

On the LTC4266, INT is an open-drain output that summarises the event and
status registers. Those registers can be read over I2C, so the chip can
also be managed by polling. writing-bindings.rst says:

  - DON'T refer to Linux or "device driver" in bindings. Bindings should
    be based on what the hardware has, not what an OS and driver
    currently support.

A board that leaves INT unconnected is valid hardware, but it would fail
dtbs_check. For comparison, skyworks,si3474.yaml in the same directory
does not require interrupts, while ti,tps23881.yaml does.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260927212929.593366-1-kyle.swenson%40est.tech
