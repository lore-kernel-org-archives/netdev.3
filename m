Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D57C2C8;
	Sat, 26 Sep 2026 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790390082; cv=none; b=VElMDUiwsL4On4XcYggVEQmsu2eM0UP2G/K3UxFkT1L9CrFanmCLYitdrVBAiUajRpVeDQLP9gsOKSVCvIz+JY43Lo+Jwf6CEcO+ufst3KDbxK3umU327b/HV8HrnibneRK/Zgfe3NbU4frzBE9DUnAdZiMDN94fadQhK9+NZAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790390082; c=relaxed/simple;
	bh=WJVoY+GTZOA5UXQJpOzZY4CvB90ZR8SkRkD/aHa8jJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXB1H4HNy1Zd2H80Shb/9AK67CaGsti2WybLdcKo40dV8xNJDJ16V9h4L3C/+0F+/gQVxre2U/gj5fioIPGlKtg6fj3iLx0OTIfXex9TiI2xa41EHEItlI4y7RwUUc1uvJt5NqjQFf52sHcKSA91YCNcNOhLjuuW06KnKUCXUIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLs0/9nd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLs0/9nd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93E71F000FF;
	Sat, 26 Sep 2026 02:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790390081;
	bh=yCY15/sIwH6iQ+lRCwST3dAmRtzGiWvGa+jsp9OFjhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KLs0/9ndc1UNqO1ZN7E2eAQ8UnMcseqBK/vN2ulZ8OU5EIZFy2mP4MwAo3iozbw6N
	 eg5FeHmz4Vv5oRl0c5Xz7EJXOmlR4dHhmZDWR+aVme5WVPv68iEksFznCSz8NRHscg
	 yB5AWDbl9VHVWNs7JJFT/1XjP/GPULEKWJ5IxAISE8F4T+RTBD8I8xPKR8tAXBG2qz
	 5dBFNjJ8lfyhxvgmOZI9zLFpQ+qh7pA59ez0ix44lI+9YGBL9qoPJwKyOcDT13LccH
	 JC+4hPfrZvJdE0gcvOUfy0cficl9Vrr4wQJi6cpmCrCXYkecelZX48y0CqVD0XS8i1
	 lWrDKiOEbjmwg==
From: Jakub Kicinski <kuba@kernel.org>
To: arouhi@sitime.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiri@resnulli.us,
	vadim.fedorenko@linux.dev,
	arkadiusz.kubalewski@intel.com,
	ivecera@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	cjubran@nvidia.com,
	pabeni@redhat.com,
	Oleg.Zadorozhnyi@devoxsoftware.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	dev@kael-k.io,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 02/14] dt-bindings: dpll: add SiTime SiT95316 clock generator
Date: Fri, 25 Sep 2026 19:34:38 -0700
Message-ID: <20260926023438.1567469-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921201108.42676-3-arouhi@sitime.com>
References: <20260921201108.42676-3-arouhi@sitime.com>
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
dt-bindings: dpll: add SiTime SiT95316 clock generator

This adds a devicetree binding for the SiTime SiT95316/SiT95317 DPLL clock
generators. These are I2C devices with four PLLs, up to eight inputs and
up to twelve outputs. The binding builds on the common dpll-device schema,
adds vendor properties for per-PLL VCO overrides and output-to-PLL routing,
and adds a MAINTAINERS entry.

> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> new file mode 100644
> index 0000000000000..6f4c60ba1cb92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> @@ -0,0 +1,183 @@

[ ... ]

> +  clock-frequency:
> +    description:
> +      XO rate in Hz feeding XIN/XO_CLK.  Alternative to the "clocks"
> +      phandle for platforms where the firmware does not expose the
> +      oscillator through the clock framework.
> +

[ ... ]

> +  sitime,pll-fvco:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 4
> +    maxItems: 4
> +    description:
> +      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  The
> +      values exceed 32 bits, which requires an explicit uint64-array
> +      type; the dtschema meta-schema does not permit a type $ref on a
> +      "-hz" unit-suffix property (only opp-hz is defined as 64-bit),
> +      hence no unit suffix.  Override where the standard
> +      Fvco = Fref * DIVN derivation does not match the running VCO --
> +      for example a PLL operating in INTSYNC mode.  A value of 0 keeps
> +      the register-derived computation for that PLL.
> +
> +  sitime,output-pll-map:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 8
> +    maxItems: 12
> +    items:
> +      enum: [0, 1, 2, 3, 255]
> +    description:
> +      Source PLL index (0=PLLA .. 3=PLLD) for each output 0..11.  The
> +      value 255 (0xff) marks an output as unmapped and prevents the
> +      driver from registering it as a DPLL pin.  Override for
> +      configurations where the chip's per-PLL OUTPUT_ENABLE bitmaps do
> +      not unambiguously describe output-to-PLL routing.

[Severity: Medium]
Do clock-frequency, sitime,pll-fvco and sitime,output-pll-map describe
the hardware, or what the Linux driver and clock framework do today?

Documentation/devicetree/bindings/writing-bindings.rst says:

  DON'T refer to Linux or "device driver" in bindings. Bindings should be
  based on what the hardware has, not what an OS and driver currently
  support.

In sitime,output-pll-map, the value 255 "prevents the driver from
registering it as a DPLL pin". The property exists to override the chip's
own OUTPUT_ENABLE routing bitmaps.

In sitime,pll-fvco, a value of 0 "keeps the register-derived
computation". The property overrides cases where the driver's
Fvco = Fref * DIVN derivation is wrong.

The reason given for clock-frequency is that the firmware does not expose
the oscillator through the clock framework. A fixed-clock node can already
describe the XO, so this adds a second, mutually exclusive ABI for the
same thing.

Both vendor properties copy state that the chip already holds in its
programmed configuration, and they would become permanent DT ABI.

Can a static sitime,pll-fvco value stay correct at runtime? Later in the
series, "dpll: sit9531x: model the inter-PLL sync net as a pair of pins"
lets userspace switch INTSYNC through netlink. The sync source pin
state_set in drivers/dpll/sit9531x/dpll.c does:

    sitdev->intsync_src = sitdpll->id;

(or -1). sit9531x_get_fvco() in drivers/dpll/sit9531x/core.c returns the
override whatever the INTSYNC state is:

    if (pll_idx < SIT9531X_NUM_PLLS && sitdev->pll_fvco[pll_idx]) {
        *fvco = sitdev->pll_fvco[pll_idx];
        return 0;
    }

If the VCO rate really depends on INTSYNC, which is the reason this
binding gives for the override, would the value be stale after a runtime
switch? sit9531x_output_divo_calc() and the phase and TDC paths all divide
by sit9531x_get_fvco(). A stale value would give wrong output frequencies,
phase offsets and DIVO values. I couldn't confirm whether the VCO actually
changes with INTSYNC on this hardware.

The reasons given also don't match. This binding cites INTSYNC mode. The
later commit "dpll: sit9531x: allow the device tree to override two board
facts" cites "free-run with a divider the configuration never programmed".
Which case is the override meant for?

The commit message doesn't mention these vendor properties or the
clock-frequency alternative. Could it explain why they are needed?

> +
> +required:
> +  - compatible
> +  - reg
> +
> +oneOf:
> +  - required:
> +      - clocks
> +      - clock-names
> +  - required:
> +      - clock-frequency

[Severity: Low]
Is a node that has both clocks and clock-frequency supposed to pass this
oneOf?

Take a node with clocks = <&xo>; and clock-frequency = <...>; but no
clock-names. The first branch fails only because clock-names is missing,
and the second branch passes, so oneOf is satisfied. Nothing else in the
binding requires clock-names when clocks is present.

For such a node, sit9531x_dev_probe() does:

    xtal_clk = devm_clk_get_optional_enabled(sitdev->dev, "xtal");
    ...
        if (!device_property_read_u32(sitdev->dev, "clock-frequency",
                                      &freq))

The "xtal" lookup finds no clock-names match, so the optional getter
returns NULL. clk_get_rate(NULL) is 0, and the driver falls back to
clock-frequency. The clock referenced by clocks is never prepared or
enabled.

Would adding dependentRequired (clocks requires clock-names), or having
each oneOf branch forbid the other property, fix this?

> +
> +allOf:
> +  - $ref: /schemas/dpll/dpll-device.yaml#

[Severity: Low]
This isn't a bug introduced by this patch, but the new binding inherits a
limitation from the shared schema. In dpll-device.yaml, input-pins
children match:

    "^pin@[0-9a-f]+$":

output-pins children match:

    "^pin@[0-9]+$":

output-pins also has unevaluatedProperties: false, so pin@a and pin@b are
rejected.

The SiT95316 has outputs 0..11, and the driver matches output-pins
children by physical slot. On the SiT95317 the slots are:

    static const u8 clkout_map_95317[] = {0, 3, 4, 5, 7, 8, 9, 11};

so OUT11 is reg 11 on both parts.

Can outputs 10 and 11 be described with the usual hex unit-address names?
The only way to pass validation seems to be pin@10 with reg = <10>, which
breaks the hex convention. microchip,zl30731.yaml (20 single-ended outputs)
has the same gap. Should the output-pins pattern in dpll-device.yaml be
changed to match the input-pins one?

> +  # SiT95317 exposes 8 outputs, SiT95316 exposes 12.  Bound the
> +  # output-pll-map length to the variant so a SiT95317 node cannot
> +  # describe more outputs than the part has.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sitime,sit95317
> +    then:
> +      properties:
> +        sitime,output-pll-map:
> +          maxItems: 8
> +  # SiT95316 has 12 outputs.  When the map is supplied it must describe
> +  # all of them, otherwise the trailing outputs are left ambiguous.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sitime,sit95316
> +    then:
> +      properties:
> +        sitime,output-pll-map:
> +          minItems: 12

[Severity: Medium]
What do the reg values of input-pins and output-pins children mean on
these parts, and which values are valid for each variant?

These if/then blocks only limit sitime,output-pll-map. dpll-pin.yaml only
has reg: maxItems: 1, so nothing here limits pin reg values.

sit9531x_prop_pin_fwnode_get() in drivers/dpll/sit9531x/prop.c matches
output-pins children by physical slot:

    if (id < sitdev->info->num_outputs)
        id = sitdev->info->clkout_map[id];

On the SiT95317 this puts the eight outputs at reg 0, 3, 4, 5, 7, 8, 9 and
11. sitime,output-pll-map uses the dense logical index 0..7 instead. The
binding only says "SiT95317 drives 8 outputs" and "for each output
0..11".

Suppose a SiT95317 board, going by the binding text, numbers its output
pins 0..7. Wouldn't reg 3 then apply to logical output 1, reg 4 to logical
2, reg 5 to logical 3, and reg 7 to logical 4, with reg 1, 2 and 6
ignored? Labels, connection types and supported-frequencies-hz would end
up on the wrong outputs. Output reg 1, 2, 6 or 10, and input reg 8 or
higher, also pass validation and are silently ignored.

The binding doesn't describe the input lane layout either. In
drivers/dpll/sit9531x/core.h:

    static inline bool sit9531x_input_is_n(u8 index)
    {
        return index & 1;
    }

So reg 2k is CLKINkP and reg 2k+1 is CLKINkN. When the pair is
differential, sit9531x_input_pin_is_registrable() doesn't register the N
lane at all.

In the example, input pin@0 (10 MHz, ext) and pin@1 (156.25 MHz, synce)
are the two lanes of CLKIN0. That only works if the pair is set up as
single-ended.

Could the binding document the reg numbering and add reg limits for each
variant? microchip,zl30731.yaml labels each example pin with its physical
name (/* REF0P */), which could be a model to follow.

> +
> +unevaluatedProperties: false

[ ... ]
-- 
pw-bot: cr
