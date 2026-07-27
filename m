Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6BA37F74C;
	Mon, 27 Jul 2026 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167462; cv=none; b=CrOI8gjVGq9Ryj/50mIJlevJhCQIo7/VyJQaKempfVdJSTKDWieV+rKgl+js9hNa30rWFI1ltaPuEuZvJoeYKC7kJf8vreQGx1Fxra15S5I5XRnJv/O8rZTqSMIt/2Jn167J2r4DB7k38JiSqvk8RdVv7VkzNC2HMS52oHI04Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167462; c=relaxed/simple;
	bh=GUQFkp3yg7rHEw1gOx3edU3HLrUv02S4mm8be/6BKFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJTYtf3mK537DNThmKq538QPoIMKOWt72v6JMS/maUiECyjvjVBkERlXKvhtLL4znTt6nDqNDe/PVB7VcSPsWCXNAr0nrlduRUKpTDNHILwEPhWLEZ/W5NCNIJ/NRMmZP3mCC0c1OYRzd0P5wWdVefo1PQZZwzAzqCkIZ6s78+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guVeLXwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guVeLXwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1CD1F000E9;
	Mon, 27 Jul 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785167460;
	bh=a29v1I9AmtPmUzhtxOfU8juL9pMl/gW53UJw7j6i6Ec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=guVeLXwiRRIWjU5sfFTtxrq6ZfihoLYMhpq6ttv26lfDXI+FR+1oBfAvwm7XACi6+
	 DL595w1QC6+ft03CjZB9VbAOBTCWldxzMcUsYHk72qmQp2tesce2L7LatEhsG5TivV
	 QHmO/4NEpa5u+PCvwSwrkr9oWb5Xmp9AgtghdxkRz/1X7E2qwtI95OlI4XXmgUbUWl
	 X923tl53lZRzLIoNyszjrpH5DeLWci0FUwoXm48mB3g6WbU144U+oZ/r5Oa2NPusfi
	 H4BVealwAZ/i6xgJ9b0V0QyEKBIuTukZnt3KCp//s5WakSKmL4rkS4dsug7qf7g3Ju
	 IXfGH181mRiuA==
Message-ID: <02792987-7ad8-4a6b-81ad-559c63174bb0@kernel.org>
Date: Mon, 27 Jul 2026 17:50:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] dt-bindings: ptp: Document the TSCSS on Qualcomm
 Lemans and Monaco SoCs
To: Imran Shaik <imran.shaik@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260727-tscss-v1-0-beed14e72510@oss.qualcomm.com>
 <20260727-tscss-v1-1-beed14e72510@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260727-tscss-v1-1-beed14e72510@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/07/2026 16:10, Imran Shaik wrote:
> Add Devicetree bindings for the Timestamp Counter Subsystem (TSCSS) found
> on Qualcomm Lemans and Monaco SoCs.
> 
> TSCSS is a time synchronization subsystem composed of two main blocks:
> Timestamp Counter (TSC) and Event Timestamp Unit (ETU). The TSC block
> provides a continuously running counter used for timekeeping, while the
> ETU captures timestamps for external hardware event triggers.
> 
> Co-developed-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/ptp/qcom,lemans-tscss.yaml | 198 +++++++++++++++++++++
>  1 file changed, 198 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ptp/qcom,lemans-tscss.yaml b/Documentation/devicetree/bindings/ptp/qcom,lemans-tscss.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..4cbe4b00ff7dcacbd8cc111e2b4b61ebce7104aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ptp/qcom,lemans-tscss.yaml
> @@ -0,0 +1,198 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ptp/qcom,lemans-tscss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Timestamp Counter Subsystem (TSCSS) on Qualcomm Lemans and Monaco SoCs
> +
> +maintainers:
> +  - Imran Shaik <imran.shaik@oss.qualcomm.com>
> +  - Taniya Das <taniya.das@oss.qualcomm.com>
> +
> +description: |
> +  Qualcomm TSCSS is a time synchronization subsystem composed of two main
> +  blocks - the Time Stamp Counter (TSC) and the Event Timestamp Unit (ETU).
> +
> +  The TSC block is a timestamp generator that maintains a running counter used
> +  for system timekeeping, and is functional with just the AHB and counter
> +  clocks.
> +  The ETU block is optional and captures TSC timestamps for external
> +  hardware events, each ETU slice binding a slice identifier to an external
> +  event selector. Support for the ETU block requires the additional ETU
> +  clock along with the summary interrupt and slice subnodes.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: qcom,lemans-tscss

There is no such SoC upstream.


> +      - items:
> +          - const: qcom,monaco-tscss

Neither this one.


> +          - const: qcom,lemans-tscss
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: tsc

Drop names, not really useful.

> +

> +  clocks:
> +    minItems: 2
> +    items:
> +      - description: TSC AHB configuration clock.
> +      - description: TSC global counter clock.
> +      - description: TSC ETU clock.
> +
> +  clock-names:
> +    minItems: 2

Why is this flexible?

> +    items:
> +      - const: ahb
> +      - const: cntr
> +      - const: etu
> +
> +  interrupts:
> +    description: Summary interrupt raised based on external event for any of the ETU slices.

Please follow Linux coding style.

> +    maxItems: 1
> +
> +  interrupt-names:
> +    items:
> +      - const: etu_summary
> +
> +  assigned-clocks: true
> +  assigned-clock-rates: true

Drop. From where did you take it?

> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges: true
> +
> +patternProperties:
> +  "^etu-slice@[0-9a-f]+$":
> +    type: object
> +    description: ETU slice configuration
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      pinctrl-0: true
> +
> +      pinctrl-names:
> +        items:
> +          - const: default

Heh? Which code do you copy?

> +
> +      qcom,etu-event-sel:
> +        description: Event selection value for this slice.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +      qcom,etu-slice:
> +        description: ETU slice identifier.

You do not get identifiers. Please read writing bindings.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +
> +    required:
> +      - reg
> +      - qcom,etu-event-sel
> +      - qcom,etu-slice
> +      - pinctrl-0
> +      - pinctrl-names
> +    unevaluatedProperties: false

Please read writing bindings.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        clock-names:
> +          contains:
> +            const: etu

etu is third clock, what is the point of it?

> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +        clock-names:
> +          minItems: 3
> +      required:
> +        - interrupts
> +        - interrupt-names
> +        - "#address-cells"
> +        - "#size-cells"
> +        - ranges
> +
> +unevaluatedProperties: false

Please read writing bindings.
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      tscss@1c80000 {
> +        compatible = "qcom,lemans-tscss";
> +        reg = <0x0 0x01c80000 0x0 0x2000>;
> +        reg-names = "tsc";
> +
> +        clocks = <&gcc GCC_TSCSS_AHB_CLK>,
> +                 <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
> +        clock-names = "ahb", "cntr";
> +
> +        assigned-clocks = <&gcc GCC_TSCSS_GLOBAL_CNTR_CLK>;
> +        assigned-clock-rates = <15625000>;
> +      };
> +    };
> +
> +  - |
> +    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      tscss@1c80000 {

This is the same node as previous.

I don't understand this DTS.


Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).


Best regards,
Krzysztof
