Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5A33ECBE4;
	Tue, 13 Oct 2026 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903467; cv=none; b=EnFLIZqeYezspcDpL8Sob81TAJV8mjnE69q8Wqj8rc0NIa2OSIrOYOVAx5XdwcRUsbhC72w2JxPwDkQPGycclJ04A+0mSP2gT2Oqt74RMLo+WmCgcmKwKE86FOtdQK31z0MrELRyYMv/lOUGSdl4JGbUBQCcBjzDo0e19r2fQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903467; c=relaxed/simple;
	bh=/c91QxCu2SOXZsPhldxV8UOiePErjv9gAeXrzyoiZls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bo7WvA5aayKu1a2iDZCISl2cAx5VA++vOpSHdI9vmrHA32JskNu+0qgt6ZYRgPWratglzcT6vO1qeDmxKGAgyv+TKTg7ONCieiOYqDaZU4PaliBqgMTkXx3anjnz/Pfb4oEWAKMfqJqSrUwKMht4Wij8Yd4hkAHCRmB4mpyVk0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QLoRC2Xk; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QLoRC2Xk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8F90FC653EF;
	Tue, 13 Oct 2026 14:58:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E5EF460362;
	Tue, 13 Oct 2026 14:57:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6492011D71780;
	Tue, 13 Oct 2026 16:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791903456; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FChtDaus9auSoHdeMFvZeQM1/di6hK/usvTVsf7gMt0=;
	b=QLoRC2Xkd5PDzyPTNolMvjOiZ4ZcCVv6E/TkXZKuk2dYnLOcR0UTzq01dCr1JMWvzHj3i0
	2yA7gM9D1rTROVwMWTOLBL5kdMg0v7OB81HXBwZPoJg7JTtWqO3LRpllAxUxlVYz/LGsRF
	4eXFxdsAyF4y4+GQ/CTtRy6YL96E7YESzFQ8lsWOmw9IGCziNr8uqndngWAt8dN4lcWof8
	iSo6kqPM0nnBARbeR17mO1VfN/D22imDy+4kCloL/tOVZO35/MZNph86WIoSkUT0j73Zgf
	WvFj2IzXWbJ0qo6I0LChC3kiwnMKXq9uO7scc/DUObyYQWi+VFFyH+G57V77FQ==
Message-ID: <92efb7e8-e69d-49aa-9cf7-9dc8fc0ead99@bootlin.com>
Date: Tue, 13 Oct 2026 16:57:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: pse-pd: Add bindings
 for LTC4266 PSE Controller
To: Kyle Swenson <kyle.swenson@est.tech>, Rob Herring <robh@kernel.org>
Cc: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Roland_Kov=C3=A1cs?= <roland.kovacs@est.tech>,
 =?UTF-8?Q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
References: <20260927212929.593366-1-kyle.swenson@est.tech>
 <20260927212929.593366-2-kyle.swenson@est.tech>
 <20261007210454.GA281943-robh@kernel.org> <asnpHkvHsFy2dX-9@est-xps15>
From: Kory Maincent <kory.maincent@bootlin.com>
Content-Language: en-US
In-Reply-To: <asnpHkvHsFy2dX-9@est-xps15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3



On 10/10/26 09:30, Kyle Swenson wrote:
> Hello Rob,
> 
> On Wed, Oct 07, 2026 at 04:04:54PM -0500, Rob Herring wrote:
>> On Sun, Sep 27, 2026 at 09:29:48PM +0000, Kyle Swenson wrote:
>>> Add the LTC4266 Power Sourcing Equipment controller device tree bindings
>>> documentation.
>>>
>>> Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
>>> ---
>>>   .../bindings/net/pse-pd/lltc,ltc4266.yaml     | 180 ++++++++++++++++++
>>>   1 file changed, 180 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
>>> new file mode 100644
>>> index 000000000000..e11c9d601eee
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.yaml
>>> @@ -0,0 +1,180 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Linear Technology LTC4266 Power Sourcing Equipment controller
>>> +
>>> +maintainers:
>>> +  - Kyle Swenson <kyle.swenson@est.tech>
>>> +
>>> +allOf:
>>> +  - $ref: pse-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - lltc,ltc4266
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  channels:
>>> +    type: object
>>> +    additionalProperties: false
>>> +    description:
>>> +      Defines the 4 physical delivery channels on the controller that can be
>>> +      referenced by PSE PIs through their "pairsets" property. The actual port
>>> +      matrix mapping is created when PSE PIs reference these channels in their
>>> +      pairsets.
>>> +
>>> +    properties:
>>> +      '#address-cells':
>>> +        const: 1
>>> +
>>> +      '#size-cells':
>>> +        const: 0
>>> +
>>> +    patternProperties:
>>> +      '^channel@[0-3]$':
>>> +        type: object
>>> +        additionalProperties: false
>>> +
>>> +        properties:
>>> +          reg:
>>> +            maxItems: 1
>>> +
>>> +          sense-resistor-micro-ohms:
>>> +            description: Sense resistor connected to the channel's MOSFET, used
>>> +              for current measurement and for overcurrent detection. The I_CUT
>>> +              and I_LIM register encodings depend on which value is fitted, so
>>> +              a wrong value programs the wrong thresholds.
>>> +            enum: [250000, 500000]
>>> +
>>> +        required:
>>> +          - reg
>>> +          - sense-resistor-micro-ohms
>>> +
>>> +    required:
>>> +      - '#address-cells'
>>> +      - '#size-cells'
>>> +
>>> +  pse-pis:
>>> +    type: object
>>> +    additionalProperties: false
>>> +
>>> +    properties:
>>> +      '#address-cells':
>>> +        const: 1
>>> +
>>> +      '#size-cells':
>>> +        const: 0
>>> +
>>> +    patternProperties:
>>> +      '^pse-pi@[0-3]$':
>>> +        type: object
>>> +        additionalProperties: true
>>
>> This cannot be true. That allows adding any property.
>>
> 
> So my intent with the additionalProperties: true was to avoid
> replicating the entire pse-pis node from pse-controller.yaml.
> Conceptually, my goal was to inherit everything from the
> pse-controller.yaml binding, except limit the maxItems to 1 (since the
> LTC4266 only supports power over a single PI).
> 
> Is there a better way to express this?

I think you can do something like this:
      patternProperties: 
  

        '^pse-pi@[0-3]$': 
  

          type: object 
  

          $ref: 
pse-controller.yaml#/properties/pse-pis/patternProperties/^pse-pi@[0-9a-f]+$ 
  

          unevaluatedProperties: false 
  

          properties: 
  

            pairsets: 
  

              description: The LTC4266 delivers power to a PI over a 
single 

                pairset, driven by one of the controller's four 
channels. There 

                is no 4-pair mode spreading a PI over two channels, so 
exactly 

                one channel phandle is expected. 
  

              maxItems: 1 
  

            pairset-names: 
  

              maxItems: 1

>>> +        properties:
>>> +          pairsets:
>>> +            description: The LTC4266 delivers power to a PI over a single
>>> +              pairset, driven by one of the controller's four channels. There
>>> +              is no 4-pair mode spreading a PI over two channels, so exactly
>>> +              one channel phandle is expected.
>>> +            maxItems: 1
>>> +          pairset-names:
>>> +            maxItems: 1
>>
>> An empty node is valid? Needs 'required'.
> 
> I thought the 'required' comes from the pse-controller.yaml binding.
> If I adjust the example dts in the binding with something like
> 
>             pse_pi2: pse-pi@2 {
> -            reg = <2>;
> -            #pse-cells = <0>;
> -            pairset-names = "alternative-a";
> -            pairsets = <&phys2>;
> -            polarity-supported = "MDI";
> -            vpwr-supply = <&vreg_pse>;
>             };
> 
> Then make dt_binding_check will fail with
> 
>    DTEX    Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dts
>    DTC [C] Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dtb
> Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dts:83.33-84.17: Warning (unit_address_vs_reg): /example-0/i2c/ethernet-pse@2f/pse-pis/pse-pi@2: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dtb: ethernet-pse@2f (lltc,ltc4266): pse-pis:pse-pi@2: 'reg' is a required property
> 	from schema $id: http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml
> Documentation/devicetree/bindings/net/pse-pd/lltc,ltc4266.example.dtb: ethernet-pse@2f (lltc,ltc4266): pse-pis:pse-pi@2: '#pse-cells' is a required property
> 	from schema $id:
> 	http://devicetree.org/schemas/net/pse-pd/lltc,ltc4266.yaml
> 
> But I'm probably missing something obvious, so please don't hesitate to
> point it out or point me to docs.
You are right on this, it should not be needed.

Regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

