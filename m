Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9DE466B63;
	Fri,  7 Aug 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088915; cv=none; b=afmegaT8ZSXfXA0utFiOtW19/PTFoUPPKJrlR+pY98IfWYpLPrthQuWPV8OXbmVWgFuxBordFEH9IbevIk40vNr8Wmm1RLkRxDOZxQycXjqWxBTnGbtAsOCHaE+iZmvQZDuR1R37R/DbVKwk9vqNrx3efhOk9GCzvzkA3RH/9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088915; c=relaxed/simple;
	bh=U8JD+cRHRy1V/iZ1HtFAhRzYbT0lCPKXB4qH/RazuKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJtDRw/jaH3DLojOzPcprly44UOxxNITc5hMHPx4pcTHVzQnaTCn/bpQkPYajzG2ahhFi/esjcC+EuRlvLGvYVjNtNn+RfQ2ukw73tNdTELvWsR3359bLcMzP22+5Reeb74XwmSJgClhDXSNg4cXKl9JSTfguB2zkDlZIBA70SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErbiXG1J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErbiXG1J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8E91F000E9;
	Fri,  7 Aug 2026 07:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786088910;
	bh=WwR5b+iRaNJPvCMTiMavrLxU6Bm1KRxCDfvplVjZQ+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ErbiXG1Jj8D6C24xPGcmvhtpzVe11PUGpBHz/tRskBPGgCEk89sCMXgzXDy3d3vO7
	 wQXoqiPETUZs1KgZu7fUu8YO9UFzKZmfJOm1zZFdWTEemg/uSkH8gfM4xMMQ8GR6G6
	 k6tdc1M6NsLtAYz8Q0QY3yJrDfPKibxHuei2v2505PjsZ3KAecgEscr8iaxD+uqeJA
	 0zQbhfh8T9R8JzWLuSxJSDXpi2GCIz80LGpNk5lsc4U/TDxx/ShJC5Iplbq7a44ERg
	 MTryAiuh8TawCPQr3Xizi6Fyvt9uD6E3HBuXtUveRwYpVgaoUQh8qky1qfD/2CTIrY
	 tiwwu3L4Fykkw==
Date: Fri, 7 Aug 2026 09:48:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, 
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, 
	"arkadiusz.kubalewski@intel.com" <arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"cjubran@nvidia.com" <cjubran@nvidia.com>, 
	"Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 2/3] dt-bindings: dpll: add SiTime SiT9531x
 clock generator
Message-ID: <20260807-abiding-spirited-gazelle-16bdbd@quoll>
References: <20260806232439.27551-1-arouhi@sitime.com>
 <20260806232439.27551-3-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260806232439.27551-3-arouhi@sitime.com>

On Thu, Aug 06, 2026 at 11:24:42PM +0000, Ali Rouhi wrote:
> Add device tree binding documentation for the SiTime SiT95316
> and SiT95317 DPLL clock generators.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>  .../bindings/dpll/sitime,sit9531x.yaml        | 203 ++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml
> new file mode 100644
> index 000000000000..56a4f5135fb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit9531x.yaml

Filename: sitime,sit95316.yaml

> @@ -0,0 +1,203 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/sitime,sit9531x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiTime SiT9531x DPLL Clock Generator
> +
> +maintainers:
> +  - Ali Rouhi <arouhi@sitime.com>
> +
> +description: |
> +  SiTime SiT95316 and SiT95317 are I2C-controlled programmable clock
> +  generators with integrated DPLL for synchronization applications.  Both
> +  variants contain four PLLs with automatic/manual reference selection,
> +  DCO frequency adjustment, and phase offset measurement via an on-chip
> +  TDC (Time-to-Digital Converter).
> +
> +  SiT95317 provides 4 inputs and 8 outputs; SiT95316 provides
> +  4 inputs and 12 outputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sitime,sit95316
> +      - sitime,sit95317
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: xtal
> +
> +  clock-frequency:
> +    description:
> +      XO/xtal input frequency in Hz.  Fallback for firmware that does not

Nope, NAK.

There is no such firmware. You fully control the DTB passed to the
system and we do not care about anything non-upstream.


> +      expose the oscillator through the clock framework; prefer the
> +      "clocks" phandle when the clock is available.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the chip's active-low reset pin (RESETB).
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Interrupt from the chip's active-low INTRB output.  Asserted when
> +      the device detects a status change such as lock acquisition or loss.
> +
> +  sitime,pll-fvco:
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 4
> +    maxItems: 4
> +    description:
> +      Per-PLL VCO frequency in Hz for PLLA, PLLB, PLLC, PLLD.  The values
> +      exceed 32 bits, so this uses a uint64-array and does not carry the
> +      "-hz" unit suffix (which implies a 32-bit cell).  Override

And mhz does not work? Where is this in your example DTS?

> +      for configurations where the standard Fvco = Fref * DIVN derivation
> +      does not match the running VCO -- for example a PLL operating in
> +      INTSYNC mode, or a chip variant whose VCO falls outside the
> +      documented PLL_FVCO band.  A value of 0 keeps the register-derived
> +      computation for that PLL.
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

NAK

> +
> +allOf:
> +  - $ref: /schemas/dpll/dpll-device.yaml#
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
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dpll@68 {
> +            compatible = "sitime,sit95317";
> +            reg = <0x68>;
> +            clocks = <&xo>;
> +            clock-names = "xtal";
> +        };
> +    };
> +
> +  - |
> +    /* XO rate from a property when the clock framework cannot provide it */
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dpll@6d {
> +            compatible = "sitime,sit95316";
> +            reg = <0x6d>;
> +            clock-frequency = <96000000>;
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +

One example is enough.

> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dpll@68 {
> +            compatible = "sitime,sit95316";
> +            reg = <0x68>;
> +            clocks = <&xo2>;
> +            clock-names = "xtal";
> +            reset-gpios = <&gpio 78 GPIO_ACTIVE_LOW>;
> +            interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
> +            dpll-types = "eec", "eec", "eec", "eec";

Best regards,
Krzysztof

