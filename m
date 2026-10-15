Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE1E3DFC88;
	Thu, 15 Oct 2026 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035109; cv=none; b=V4BBFpPuGLpBvVwIzWjs1LIQ1sjIGXH6W4cnvgkNTAGatS8afNWp3RSku8IaVjhyE1HcV+t1QeuLlmjzZI0uycbYF2w0FqSn7Qs/pTwOLRbaqvODVRblwu1NcYZIBfaLXO6z4ZOgoShUKhiJ9L9nyuQyOVWTZSj50pDyuOorCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035109; c=relaxed/simple;
	bh=M/JkIUWwvA52ZbBOjYPkvRJ3jRJfRLAIyfI4JmOT3Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8XBYq71BcqrS+L17W0fy3BmitO5asz1P06dp1Qx+Eyy0tVpegM4pzxbViCcZpHkCvwe1HBWHkjx6k+GE35W2SvKXlIKgXXLxQv0ZluFI7aP7Ku125dEfOTuwTAzjjqUSpXIzQGEvmflALr182BJdC8D7bM3GYJl8hcLTaPpkR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVMO5ZQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVMO5ZQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611BE1F000C4;
	Thu, 15 Oct 2026 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035106;
	bh=HLb+OtDBXLBqhkqbGUcRpTHQ1hhLmdP1v2ZvEyXJ3JQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dVMO5ZQeBMy2jzjBw4CErFZmdCXrUT/M+7RpHNpp7xM030C32nfKyXxX4Fz8us+W5
	 3436tqAflwjwZdMtBnUxpuzU08Cl+uGEWWijSICPUpvKuJNkB/nNhSe8Fdx6mPvnHw
	 dU39FIM7yAEmloswZcgneh+s/CBfzcFfKdc+pUs4teJGvtu9r+HByYvX8XQvOUg8OP
	 vfm9f4BnHMvjgoS01mO0A5PMeL6G6egyT9Srqb2gTi0aKPHttnGR1ko270wGo7M0/q
	 p3AMNb3//t6kLty1Wy6WU/YyGJA7sNf6iDFMZefwehaPtRBJ8z6Mbfg6e3vG5O++Zb
	 t4PSQrG8o+CuQ==
Date: Wed, 14 Oct 2026 22:31:43 -0500
From: Rob Herring <robh@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v13 02/12] dt-bindings: dpll: add SiTime
 SiT95316 clock generator
Message-ID: <20261015033143.GA485921-robh@kernel.org>
References: <20261013224131.27149-1-arouhi@sitime.com>
 <20261013224131.27149-3-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013224131.27149-3-arouhi@sitime.com>

On Tue, Oct 13, 2026 at 10:41:33PM +0000, Ali Rouhi wrote:
> Add a binding for the SiTime SiT9531x family of clock generators: an
> I2C-controlled device with four independent PLLs, up to eight input
> clocks and up to twelve outputs, described as a DPLL provider.
> 
> The XO is given either as a clock or, for firmware that describes the
> oscillator as a property rather than as a clock provider, such as ACPI,
> as clock-frequency.
> 
> The supplies are described by their pin names: the core and input rails,
> the GPIO rail the SiT95317 has, and one per output-driver pin -- VDDO0 to
> VDDO7 on the SiT95317, VDDO0_1, VDDO2 to VDDO9 and VDDO10_11 on the
> SiT95316.  The driver does not enable them, since the boards so far
> power the part permanently; describing them gives a board with
> switchable rails a way to say so.
> 
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>
> ---
>  .../bindings/dpll/sitime,sit95316.yaml        | 213 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 219 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> new file mode 100644
> index 000000000000..200b9f709a57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dpll/sitime,sit95316.yaml
> @@ -0,0 +1,213 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dpll/sitime,sit95316.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiTime SiT95316/SiT95317 DPLL Clock Generator
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
> +  Both parts have 4 differential input pairs whose lanes can also be
> +  driven independently as single-ended references, so 8 inputs are
> +  individually selectable.  SiT95317 drives 8 outputs, SiT95316
> +  drives 12.
> +
> +  Pin numbering.  An input pin's reg is its lane: 2k is INkP and 2k + 1
> +  is INkN, 0 to 7.  A pair the loaded configuration runs differential is
> +  one input, described at 2k.  An output pin's reg is its physical output
> +  OUTn, 0 to 11; the SiT95317 bonds out OUT0, OUT3, OUT4, OUT5, OUT7, OUT8,
> +  OUT9 and OUT11.
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
> +      XO rate in Hz feeding XIN/XO_CLK, for firmware that describes the
> +      oscillator as a property rather than as a clock provider, such as
> +      ACPI.  Use either this or "clocks", not both.
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
> +  dpll-types:
> +    maxItems: 4
> +
> +  vdd-supply:
> +    description: Core supply of the PLLs, 1.8 V (the VDD pins).
> +
> +  vddin-supply:
> +    description:
> +      Supply of the input receivers and dividers, 3.3 V (VDDIN).
> +
> +  vdds-supply:
> +    description:
> +      Supply of the two GPIO pins that have their own rail (VDDS).  The
> +      SiT95316 has no such pin.
> +
> +  input-pins:
> +    type: object
> +    patternProperties:
> +      "^pin@[0-9a-f]+$":
> +        type: object
> +        properties:
> +          reg:
> +            maximum: 7
> +
> +          supported-frequencies-hz:
> +            description:
> +              The rate wired to the input, in Hz, as a single entry.  An
> +              input runs at the rate the board feeds it and has no
> +              frequency to select, so that entry is what the pin reports
> +              as its frequency.
> +
> +patternProperties:
> +  "^vddo([0-9]|1[01]|0_1|10_11)-supply$":
> +    description: |
> +      Supply of an output driver, named after its VDDO pin.  The SiT95317
> +      has one per output, VDDO0 to VDDO7, numbered as that part's
> +      datasheet numbers its outputs; in the pin numbering of this binding
> +      those are outputs 0, 3, 4, 5, 7, 8, 9 and 11, in that order.  The
> +      SiT95316 has VDDO0_1, VDDO2 to VDDO9 and VDDO10_11, the two shared
> +      pins each powering the pair of outputs they are named after.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +dependencies:
> +  clocks: [ clock-names ]
> +
> +oneOf:
> +  - required:
> +      - clocks
> +  - required:
> +      - clock-frequency
> +
> +allOf:
> +  - $ref: /schemas/dpll/dpll-device.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: sitime,sit95317
> +    then:
> +      properties:
> +        output-pins:
> +          patternProperties:
> +            "^pin@[0-9a-f]+$":
> +              properties:
> +                reg:
> +                  enum: [0, 3, 4, 5, 7, 8, 9, 11]
> +      patternProperties:
> +        "^vddo(8|9|1[01]|0_1|10_11)-supply$": false
> +    else:
> +      properties:
> +        vdds-supply: false
> +        output-pins:
> +          patternProperties:
> +            "^pin@[0-9a-f]+$":
> +              properties:
> +                reg:
> +                  maximum: 11
> +      patternProperties:
> +        "^vddo(1[01]|[01])-supply$": false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
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
> +            vdd-supply = <&reg_1v8>;
> +            vddin-supply = <&reg_3v3>;
> +            vddo0_1-supply = <&reg_3v3>;
> +            vddo10_11-supply = <&reg_1v8>;
> +            dpll-types = "eec", "eec", "eec", "eec";
> +
> +            input-pins {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* IN0P and IN0N: pair 0 runs single-ended */
> +                pin@0 {
> +                    reg = <0>;
> +                    label = "clkin0";
> +                    connection-type = "ext";
> +                    supported-frequencies-hz = /bits/ 64 <10000000>;

-hz is 32-bit.

Rob
