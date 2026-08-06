Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F53A83A8;
	Thu,  6 Aug 2026 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785978672; cv=none; b=pQrBU/PAd+MMyruwtDBRQxE63jQ9Jk41hz9+V5VRHlhQRWvBuBVTfaHCOx4YrP1auUeyO/jE2sMAzWszs+g9Jd3UutKrEXkDErQIovKj5G+tfCgOZXNW8OxHTcp/eHn/P6fQaEa+MIeVkkvAsLE9a6uGjyIg4P4hTclwfByvN6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785978672; c=relaxed/simple;
	bh=sC0nJJGa97og3ugBOSncZ6LU3kG1fZZ1hZKkrnzRUt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieHgDGOH+V+H24hUSVbFWfxVoOSrUeBsqxGB3bp1wQlv4r6FIRmja2m3Mr4GEReqDsYpkTBXs/4bOLT6Gnvv3it3+JZlJfyl4ceYZp2swuHjHQ/wyIE1I2Scd96HOclicePMpLvrGTK10viFtZvG/4BC+DeBWgaLL2QL1FQk4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcDipZgQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcDipZgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFAD1F000E9;
	Thu,  6 Aug 2026 01:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785978670;
	bh=0nWg/VyFOnBpDM8uIIWMRncb1yFhhBefq5y9ECkxs6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LcDipZgQpnS09+uD19c5sPtMWPp+8xLdtKSZ4BYXbM0f82lw+aKQeq6yDf880lQ8Q
	 VamjEvIUiCwIDEQ5pLmHcujnpnHK7EOdVeOw+pzgIngbdxt9aJXs91pdKgu+OTikNK
	 +EjaczAXPWXeHfU3TmwvZi0SNxnV8k7rVCMWAL5vHGBvb1eJwObtmxhxLEIAAJoWlL
	 sBm0U91RzqSBfcZaSKvG0OQjphKVDsG4iK3wkPhXJ7r/lxdMs59vS8gUIZ3yCUksT2
	 7phQbBrsNSfSd5V4CIdQz1+B8r+4asIQ2XqoQc0u/C2El73UFubb944u7L4TIV6te9
	 h4AsF+7WDRXRw==
From: Jakub Kicinski <kuba@kernel.org>
To: jelonek.jonas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel@makrotopia.org,
	bjorn@mork.no,
	sander@svanheule.net
Subject: Re: [PATCH net-next v11 1/4] dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU
Date: Wed,  5 Aug 2026 18:11:07 -0700
Message-ID: <20260806011107.1855326-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260802100114.720594-2-jelonek.jonas@gmail.com>
References: <20260802100114.720594-2-jelonek.jonas@gmail.com>
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
dt-bindings: net: pse-pd: add bindings for Realtek PSE MCU

This adds a new YAML binding for the MCU that fronts the PSE silicon on a
range of managed Realtek-based switches, covering both protocol generations
and the I2C/SMBus and UART attachments.  Two questions below about the file
naming and about the serial slave node name.

> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
> new file mode 100644
> index 0000000000000..3bb32349c28c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu-gen1.yaml
> @@ -0,0 +1,182 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu-gen1.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

[ ... ]

> +properties:
> +  compatible:
> +    oneOf:
> +      # UART
> +      - items:
> +          - enum:
> +              - zyxel,gs1900-10hp-a1-pse
> +          - const: realtek,pse-mcu-gen1
> +
> +      # I2C, SMBus framing
> +      - items:
> +          - enum:
> +              - zyxel,gs1920-24hp-v2-pse
> +          - const: realtek,pse-mcu-gen1-smbus
> +
> +      # UART
> +      - items:
> +          - enum:
> +              - zyxel,gs1900-10hp-b1-pse
> +              - zyxel,xmg1915-10ep-pse
> +          - const: realtek,pse-mcu-gen2
> +
> +      # I2C, SMBus framing
> +      - items:
> +          - enum:
> +              - zyxel,xs1930-12hp-pse
> +          - const: realtek,pse-mcu-gen2-smbus
> +
> +      # I2C, raw framing
> +      - items:
> +          - enum:
> +              - linksys,lgs328mpc-v2-pse
> +          - const: realtek,pse-mcu-gen2-i2c

[Severity: Low]
This isn't a bug, but should the file be named after the family rather than
after one compatible?

The file (and $id) is realtek,pse-mcu-gen1.yaml, while the compatible list
here documents five strings across two protocol generations:

    realtek,pse-mcu-gen1
    realtek,pse-mcu-gen1-smbus
    realtek,pse-mcu-gen2
    realtek,pse-mcu-gen2-smbus
    realtek,pse-mcu-gen2-i2c

There is no file bearing the name of any realtek,pse-mcu-gen2* compatible,
so searching by that compatible name finds nothing, and the commit message
does not mention that gen2 is described in a ...-gen1.yaml file.

Would realtek,pse-mcu.yaml (with the $id updated to match) describe the
actual scope better?

To be clear, the $id path itself is consistent with the current file path
(net/pse-pd/realtek,pse-mcu-gen1.yaml#), so $ref resolution and
dt_binding_check are not affected here - this is only about the declared
scope of the name.

> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: pse-controller.yaml#

[ ... ]

> +    else:
> +      allOf:
> +        - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +      properties:
> +        reg: false

[Severity: Low]
This else branch declares the bare gen compatibles to be UART (serial
slave) attachments, and the node name is forced to ethernet-pse by
pse-controller.yaml:

Documentation/devicetree/bindings/net/pse-pd/pse-controller.yaml
  $nodename:
    pattern: "^ethernet-pse(@.*|-([0-9]|[1-9][0-9]+))?$"

But serial.yaml only enumerates these serial slave child node names:

Documentation/devicetree/bindings/serial/serial.yaml
patternProperties:
  "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
    if:
      type: object
    then:
      additionalProperties: true
      $ref: serial-peripheral-props.yaml#
      ...
      required:
        - compatible

Does a board device tree with an ethernet-pse child of serial then get the
shared slave-node subschema applied at all?  Since serial.yaml ends with
additionalProperties: true, the unmatched child looks like it just falls
through silently rather than being flagged.

Should serial.yaml's pattern list gain ethernet-pse as part of this series,
or is the intent to reuse the existing generic mcu name (which would
conflict with pse-controller.yaml's $nodename pattern)?

I checked the end of the series and serial.yaml is unchanged there, so no
counterpart update appears later either.

> +unevaluatedProperties: false
> +
> +examples:

[ ... ]

> +  # UART attachment
> +  - |
> +    serial {
> +        ethernet-pse {
> +            compatible = "zyxel,gs1900-10hp-a1-pse", "realtek,pse-mcu-gen1";
> +            current-speed = <19200>;

[ ... ]
-- 
pw-bot: cr
