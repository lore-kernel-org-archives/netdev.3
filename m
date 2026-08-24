Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F84B3EEAC4;
	Mon, 24 Aug 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568420; cv=none; b=SpqpvDbd1i9efdU35aIfPYVSn1NDlwzPAwyIgh7tZYjI9ZLv2SBwNrH8mwvmZuR9si9V+hM3/upowtXXkARQCY1e9W8ioTviCD9kV6/L3XtcDftD66QReexjZXCO9WPAQHzIUzK4KJs5lTcveIC3gIT/T2LmTVlNxFyfiswSQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568420; c=relaxed/simple;
	bh=NhHoUqjsSGGKoQ8soMQnUuRdpoAj8PLKNnRoNFbOF/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q9msis+oV89ht9Ts511pQvjaBAw/ssoBzMglWgewphOksdqJWioatmxX2W4/9rkasqZvUgQDRULTtQgV7B4VNTCHiY9VQITstaENXebojIaTxE87bw5FtiNn7efP+x6EYsfHswTnpeAzbKlkoD6rlm4fI1OuVdKLxfAzZM7vufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kZDgwjbD; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZDgwjbD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ACC091A17E4;
	Mon, 24 Aug 2026 10:46:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F59B5FFC1;
	Mon, 24 Aug 2026 10:46:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3B7111C79150;
	Mon, 24 Aug 2026 12:46:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787568402; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BhZZBUETH8qQBmbmXUyu8ssNHxGDUGnmiu0xmE5vVIQ=;
	b=kZDgwjbD6ld2yFIVAokM6lBIRAYVjgMgSJdN5/qtzvlGpNacIzB9G5EGkXX2pS9kF3A+T3
	N2F7tw70fm5la07OxIMvhsToCIe/kQ0T06O71hpbhcS3l78baTimbcmjMwcQsNEv9vGl/q
	gG2jHU3H+3uK/tD65OV7u2LETgQFbochElpWSvw2HBnhi6eAUykAFZXKJeRZDt+tmg1aTz
	TEoPqD0uszWkMuDFOxrMIZcWJuonjD8guSpcZinyizfQWAzxXasnOsmVaSU1ByjlzKLh5O
	ahNOUiECH72Q/snenLVM+AbDaqi6PxANhBZqaPW4WQtDYZiN8OD8W+Xrn0neyw==
Message-ID: <4b16ca01-a09c-49bd-8c3e-ffa9921a0823@bootlin.com>
Date: Mon, 24 Aug 2026 12:46:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH net-next v2 1/2] dt-bindings: net: pse-pd: Add
 bindings for LTC4266 PSE Controller
To: Kyle Swenson <kyle.swenson@est.tech>,
 "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Roland_Kov=C3=A1cs?= <roland.kovacs@est.tech>,
 =?UTF-8?Q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
References: <20260820142429.2285172-1-kyle.swenson@est.tech>
 <20260820142429.2285172-2-kyle.swenson@est.tech>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260820142429.2285172-2-kyle.swenson@est.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Kyle,

Glad to see the v2 landing in the mailing list.

On 8/20/26 16:25, Kyle Swenson wrote:
> Add the LTC4266 Power Sourcing Equipment controller device tree bindings
> documentation.
> 
> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> ---
>   .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
>   1 file changed, 180 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> new file mode 100644
> index 000000000000..b3da8fea0b07
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
> @@ -0,0 +1,180 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology LTC4266 Power Sourcing Equipment controller
> +
> +maintainers:
> +  - Kyle Swenson <kyle.swenson@est.tech>
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +
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
> +
> +  reset-gpios:
> +    maxItems: 1

The reset-gpios is currently not implemented in your driver. Maybe add 
it in the binding when it will be the case.

> +  channels:
> +    type: object
> +    additionalProperties: false
> +    description:
> +      Defines the 4 physical delivery channels on the controller that can be
> +      referenced by PSE PIs through their "pairsets" property. The actual port
> +      matrix mapping is created when PSE PIs reference these channels in their
> +      pairsets.
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^channel@[0-3]$':
> +        type: object
> +        additionalProperties: false
> +
> +        properties:
> +          reg:
> +            maxItems: 1
> +
> +          sense-resistor-micro-ohms:
> +            description: Sense resistor connected to the channel's MOSFET, used
> +              for current measurement for overcurrent detection.
> +            enum: [250000, 500000]
> +
> +        required:
> +          - reg
> +          - sense-resistor-micro-ohms

I am bit skeptical about having sense-resistor-micro-ohms as a mandatory 
parameter. As you have described it's only for current measurement so 
it's not a requirement for PSE functioning. Maybe set it as a default 
value if not specified.

Else LGTM.

> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +  pse-pis:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      '^pse-pi@[0-3]$':
> +        type: object
> +        properties:
> +          pairsets:
> +            description: The LTC4266 delivers power to a PI over a single
> +              pairset, driven by one of the controller's four channels. There
> +              is no 4-pair mode spreading a PI over two channels, so exactly
> +              one channel phandle is expected.
> +            maxItems: 1
> +          pairset-names:
> +            maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - channels
> +  - pse-pis
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      ethernet-pse@2f {
> +        compatible = "lltc,ltc4266";
> +        reg = <0x2f>;
> +        interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +        interrupt-parent = <&gpio>;
> +
> +        channels {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          phys0: channel@0 {
> +            reg = <0>;
> +            sense-resistor-micro-ohms = <500000>;
> +          };
> +
> +          phys1: channel@1 {
> +            reg = <1>;
> +            sense-resistor-micro-ohms = <500000>;
> +          };
> +
> +          phys2: channel@2 {
> +            reg = <2>;
> +            sense-resistor-micro-ohms = <500000>;
> +          };
> +
> +          phys3: channel@3 {
> +            reg = <3>;
> +            sense-resistor-micro-ohms = <500000>;
> +          };
> +        };
> +
> +        pse-pis {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          pse_pi0: pse-pi@0 {
> +            reg = <0>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a";
> +            pairsets = <&phys0>;
> +            polarity-supported = "MDI";
> +            vpwr-supply = <&vreg_pse>;
> +          };
> +
> +          pse_pi1: pse-pi@1 {
> +            reg = <1>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a";
> +            pairsets = <&phys1>;
> +            polarity-supported = "MDI";
> +            vpwr-supply = <&vreg_pse>;
> +          };
> +
> +          pse_pi2: pse-pi@2 {
> +            reg = <2>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a";
> +            pairsets = <&phys2>;
> +            polarity-supported = "MDI";
> +            vpwr-supply = <&vreg_pse>;
> +          };
> +
> +          pse_pi3: pse-pi@3 {
> +            reg = <3>;
> +            #pse-cells = <0>;
> +            pairset-names = "alternative-a";
> +            pairsets = <&phys3>;
> +            polarity-supported = "MDI";
> +            vpwr-supply = <&vreg_pse>;
> +          };
> +        };
> +      };
> +    };

-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

