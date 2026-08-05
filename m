Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB352418A58;
	Wed,  5 Aug 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928123; cv=none; b=PDrD/FURRUTNqs3Co/pr+g16QRt9IXXxU1qw/fuS9orX1rVYWFQPXkuCgEYMT9Gg4TPOoMo2N64H1rL+sYrRVyz6LFePhDjCLBwmgfEbh2lOyFwd4MHdC8XBf4tjPoGbU/qkfjupBNpzEGST4OPBIrH43gHw/KFuOLq53cZ3Z4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928123; c=relaxed/simple;
	bh=ghdmEV1nQFz2UkbFOfmAQ52k0blxMMSQKIBtxvDeZWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjGlgIyPn1VM/Hk/4QmuzyPGnuxUxqtc/4SypnbKkNjjkEgmcP2GVumwYdIq8OA5BU5To1mrHn16diQwwj4gvSKY6ksNZ/l0ML9V7aBdpLM9UdGg4ZrJ4DIVlwT2O8aj3eOPCuVnEFQ5vS77pwFzyGpheQkRDdGoyyV9BvNLB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3ahLAl2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3ahLAl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C78A1F000E9;
	Wed,  5 Aug 2026 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785928121;
	bh=JcbUNDZL3+LdfwEtASY4A5d0zJp3Sh4Ls1ARLjrASMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A3ahLAl2sGVZeb1JxyfFewkgfWRSX26qcnBAG9Kt9QZQOQWOCsg3LmKUhiYf26uzq
	 rC28SW23pyMnjbcxgcb+0RQXFcgVoow5Su5m3RYhy0gsrBMEEXEe6zAd+lraYhU4Mj
	 +1DEFNSdcX6wdBjL1wu+xYXDzXqu7nYPnLPQCF3olkE8gv/ZP4eMzPmYHz4lY8K7fb
	 OUQQxn3yII3LX39MSuXiaK7Ey9vBaJo8QXEsvr7zXjNE3vBHmDUpUlVjTgMHsxcL4c
	 AGaszB6tc/JyrdCX/Ehbog46hzZK9z5cG2iTpvN3mq1LI7n6JAXDnv+D9OdLAR+Cmh
	 e1J32VOenLcsg==
Message-ID: <dd38875b-1df5-42d2-acc2-98fbe86ce3fa@kernel.org>
Date: Wed, 5 Aug 2026 13:08:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: net: convert wiznet,w5x00 to YAML
To: =?UTF-8?Q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-wiznet-link-gpio-v2-0-3b1d0c870f35@marmottus.net>
 <20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260804-wiznet-link-gpio-v2-2-3b1d0c870f35@marmottus.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/08/2026 19:40, Arthur Crépin Leblond wrote:
> Convert the Wiznet w5x00 SPI Ethernet controller binding from
> text to DT schema format.

Limited review, to spare you one review cycle, as it was not tested.

Subject: s/YAML/DT schema/

See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/bindings/submitting-patches.rst#L23

> 
> Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
> ---
>  .../devicetree/bindings/net/wiznet,w5x00.txt       |  50 ----------
>  .../devicetree/bindings/net/wiznet,w5x00.yaml      | 103 +++++++++++++++++++++
>  2 files changed, 103 insertions(+), 50 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt b/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> deleted file mode 100644
> index e9665798c4be..000000000000
> --- a/Documentation/devicetree/bindings/net/wiznet,w5x00.txt
> +++ /dev/null
> @@ -1,50 +0,0 @@
> -* Wiznet w5x00
> -
> -This is a standalone 10/100 MBit Ethernet controller with SPI interface.
> -
> -For each device connected to a SPI bus, define a child node within
> -the SPI master node.
> -
> -Required properties:
> -- compatible: Should be one of the following strings:
> -	      "wiznet,w5100"
> -	      "wiznet,w5200"
> -	      "wiznet,w5500"
> -- reg: Specify the SPI chip select the chip is wired to.
> -- interrupts: Specify the interrupt index within the interrupt controller (referred
> -              to above in interrupt-parent) and interrupt type. w5x00 natively
> -              generates falling edge interrupts, however, additional board logic
> -              might invert the signal.
> -- pinctrl-names: List of assigned state names, see pinctrl binding documentation.
> -- pinctrl-0: List of phandles to configure the GPIO pin used as interrupt line,
> -             see also generic and your platform specific pinctrl binding
> -             documentation.
> -
> -Optional properties:
> -- spi-max-frequency: Maximum frequency of the SPI bus when accessing the w5500.
> -  According to the w5500 datasheet, the chip allows a maximum of 80 MHz, however,
> -  board designs may need to limit this value.
> -- local-mac-address: See ethernet.txt in the same directory.
> -
> -
> -Example (for Raspberry Pi with pin control stuff for GPIO irq):
> -
> -&spi {
> -	ethernet@0: w5500@0 {
> -		compatible = "wiznet,w5500";
> -		reg = <0>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&eth1_pins>;
> -		interrupt-parent = <&gpio>;
> -		interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> -		spi-max-frequency = <30000000>;
> -	};
> -};
> -
> -&gpio {
> -	eth1_pins: eth1_pins {
> -		brcm,pins = <25>;
> -		brcm,function = <0>; /* in */
> -		brcm,pull = <0>; /* none */
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml b/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml
> new file mode 100644
> index 000000000000..8f45a5d773fe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/wiznet,w5x00.yaml

Filename: wiznet,w5100.yaml

> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/wiznet,w5x00.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiznet w5x00 SPI Ethernet Controller
> +
> +description: |
> +  This is a standalone 10/100 MBit Ethernet controller with SPI interface.
> +
> +  For each device connected to a SPI bus, define a child node within the SPI master node.

This looks unwrapped (see Linux coding style).

> +
> +allOf:
> +  - $ref: /schemas/net/ethernet-controller.yaml#
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - wiznet,w5100
> +      - wiznet,w5200
> +      - wiznet,w5500
> +
> +  reg:
> +    description: Specify the SPI chip select the chip is wired to.
> +    maxItems: 1
> +    minItems: 1

Drop, please do not invent your own syntax. Look at recently reviewed
code or example-schema.

> +
> +  interrupts:
> +    description:
> +      Specify the interrupt index within the interrupt controller (referred to
> +      above in interrupt-parent) and interrupt type. w5x00 natively generates
> +      falling edge interrupts, however, additional board logic might invert the
> +      signal.
> +    maxItems: 1
> +    minItems: 1
> +
> +  pinctrl-names:
> +    description:
> +      List of assigned state names, see pinctrl binding documentation.
> +    enum:
> +      - default
> +    minItems: 1

Do not invent own code. Drop

> +
> +  pinctrl-0:
> +    description:
> +      List of phandles to configure the GPIO pin used as interrupt line, see
> +      also generic and your platform specific pinctrl binding documentation.
> +    minItems: 1
> +
> +  local-mac-address: true
> +
> +  spi-max-frequency:
> +    description:
> +      Maximum frequency of the SPI bus when accessing the w5500. According to
> +      the w5500 datasheet, the chip allows a maximum of 80 MHz, however, board
> +      designs may need to limit this value.
> +    maximum: 80000000
> +
> +  link-gpios:
> +    description: A GPIO line used for the link detection interrupt.
> +    maxItems: 1

This wasn't in the original binding and lacks explanation in commit msg.
Any change done to the binding must be documented with a reason WHY. If
there is no reason WHY, then maybe you wanted separate commit (although
each commit should explain WHY).

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    /* Example (for Raspberry Pi with pin control stuff for GPIO irq) */
> +
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet@0: w5500@0 {
> +          compatible = "wiznet,w5500";
> +            reg = <0>;
> +            pinctrl-names = "default";

Messed indentation.

> +            pinctrl-0 = <&eth1_pins>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> +            spi-max-frequency = <30000000>;
> +            link-gpios = <&gpio 4 GPIO_ACTIVE_HIGH>;
> +            local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
> +        };
> +    };
> +
> +    &gpio {
> +      eth1_pins: eth1_pins {
> +        brcm,pins = <25 4>;
> +        brcm,function = <0 0>; /* in */
> +        brcm,pull = <0 0>; /* none */
> +    };

Irrelevant node, drop

Best regards,
Krzysztof
