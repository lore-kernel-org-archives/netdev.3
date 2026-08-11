Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592C3FF1B7;
	Tue, 11 Aug 2026 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432525; cv=none; b=uttzwKNx3Lb33xwxFkHc4nco2vT60D04dwsivMnIUA2JuFZd+XxsQgnrpH5vjC8tNfxR1k56iMF0rfHfbQN/4frZQTMznJuoSJvMAFpxgAmTh3wKWUsRL+EYe1e9F23fJKMzLgv+5D2xME13tk49HNhsoN8xhzQKr3YulCBYAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432525; c=relaxed/simple;
	bh=I3JcvC5oTHnJrY/p7dKkXNjVsxbYm7hTwxFI6iwbUns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbeV4E96QoM7NhnXun/bw+oJAIs7O+QVE1c+gpsksXw+/0l6RBYXgwhzJZFt26rXRsStpFxHhcBFIYTZJ4WI2vK4ZNzWO4rTn6rbNUXKBwDt7QDBsxM3A9woChChlEdo21asMeM2Hwm56Dd2j2cqg+lu+mZdxLKkimkv9uS2Mn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsTuDwVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsTuDwVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593701F00A3D;
	Tue, 11 Aug 2026 07:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786432517;
	bh=RtnopSDY9LgO14LF3vwgLskfXZkmvLWqpT4jVjmFoX8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JsTuDwVaxj7Tswl2f65hiEXtO37LPlohUa//m34dIPkpN90j6yvcN44qnQP/VUG9v
	 iYPg1s+B1coX/FigWu05xUx/AVO8we8UpKfvQG704vrdUuoE2mpFSGSg8HkbDQg5wr
	 mQeY3iksQULPBIGZznIZn4BAiqfz7TIYHuHLjg1fIHmudxymAmlWBmohJ+4ga120X2
	 JdDNsqsxAqKhMC5n9uaQP5/jDxJdwuxRCX7xtH8g/pr8Ll2W7KYxoYiLlJBiIvEwpW
	 quNJdH993S64cDFZvMA13VIuOfq/MzH69uqJod81HUP01Sj5If/r6ZyLF4DrCEyM1B
	 gKSuzorkhjxNw==
Message-ID: <9d596af3-be5f-4f02-aeaf-ae5d627475c5@kernel.org>
Date: Tue, 11 Aug 2026 09:15:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/5] dt-bindings: net: x-powers: add
 AC200/AC300 EPHY packages
To: James Hilliard <james.hilliard1@gmail.com>, Lee Jones <lee@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
 <20260809-submit-acx00-of-dynamic-v1-v5-4-bfa1f8518b28@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260809-submit-acx00-of-dynamic-v1-v5-4-bfa1f8518b28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/08/2026 22:28, James Hilliard wrote:
> The AC200 and AC300 contain compatible Fast Ethernet link PHYs which
> report the same Clause 22 identifier and use the same link-side register
> layout. Their package control paths differ: AC200 uses registers in its
> I2C MFD, while the AC300 control range is at a second Clause 22 address
> fixed at 16 plus the link address.
> 
> Describe both variants as Ethernet PHY packages. The package reg value is
> the link PHY base address and the child supplies the documented PHY ID,
> because the identification registers cannot be read until package setup
> has completed. The AC300 driver reaches its control range with the PHY
> package offset helpers. The AC200 package instead references its MFD.
> 
> Give fixed hardware variant-specific compatibles. Also provide an ACx00
> compatible for systems which can contain either package, with one packed
> NVMEM field containing calibration in bits 3 through 0, the AC300 selector
> in bit 8 and its low-calibration selector in bit 9. Such a description
> contains the potential resources for both backends; the driver consumes
> only those selected by the configuration field.
> 
> Describe the package clock, supply and optional xMII receive-clock
> inversion needed by some integrations. A fixed AC200 package may omit the
> NVMEM field and use its internal calibration copy. Limit AC300-capable link
> addresses to 0 through 7 so the control address remains in the documented
> range 16 through 23.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  .../bindings/net/x-powers,acx00-ephy-package.yaml  | 207 +++++++++++++++++++++
>  1 file changed, 207 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
> new file mode 100644
> index 000000000000..ae0c5e980c39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/x-powers,acx00-ephy-package.yaml
> @@ -0,0 +1,207 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/x-powers,acx00-ephy-package.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: X-Powers AC200 and AC300 Ethernet PHY packages
> +
> +maintainers:
> +  - James Hilliard <james.hilliard1@gmail.com>
> +
> +description:
> +  The AC200 and AC300 contain compatible Fast Ethernet PHY blocks which report
> +  the same Clause 22 PHY ID and use the same link-side register layout. The
> +  package control paths differ. AC200 control registers are part of an I2C MFD,
> +  while AC300 control registers occupy a second Clause 22 address fixed at 16
> +  plus the link PHY address.
> +
> +  Systems with a known package use the corresponding AC200 or AC300 compatible.
> +  Systems which can contain either package use the ACx00 compatible and a
> +  packed NVMEM configuration field to select the backend at runtime.
> +
> +  The link PHY cannot report its ID until the package control sequence has
> +  completed, so its child node supplies the documented PHY ID. The package and
> +  child use the same base address. The AC200 driver programs that address into
> +  the package, while the AC300 driver derives its control address from it.
> +
> +select:
> +  properties:
> +    compatible:
> +      enum:
> +        - x-powers,ac200-ephy-package
> +        - x-powers,ac300-ephy-package
> +        - x-powers,acx00-ephy-package
> +  required:
> +    - compatible

Why do you need the select?

> +
> +properties:
> +  compatible:
> +    enum:
> +      - x-powers,ac200-ephy-package
> +      - x-powers,ac300-ephy-package
> +      - x-powers,acx00-ephy-package
> +
> +  reg:
> +    maximum: 31
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      AC300 input clock, running at 24, 25, or 27 MHz. The AC200 input clock
> +      belongs to the referenced AC200 MFD instead.

Drop last sentence. Just confusing - what is a referenced MFD? There is
no such thing in the bindings as MFD and the bindings cannot depend on
Linux subsystem.

> +
> +  vcc-supply:
> +    description:
> +      3.3 V package supply. This is connected to EPHY_VCC on AC200 and VCC1
> +      on AC300.
> +
> +  nvmem-cells:
> +    maxItems: 1
> +    description:
> +      Packed EPHY configuration field. Bits 3 through 0 contain the analog
> +      calibration code, bits 7 through 4 are reserved, bit 8 selects AC300
> +      when set and AC200 when clear, and bit 9 requests the AC300
> +      low-calibration tuning sequence. A fixed AC200 package may provide only
> +      the low calibration bits or omit the cell and use its internal eFuse
> +      copy instead.
> +
> +  nvmem-cell-names:
> +    const: configuration
> +
> +  x-powers,ac200:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Reference to the AC200 MFD containing this Ethernet PHY

Confusing. "Containing" means this is part of the other one, but
phandles do not express that. Anyway, there is no such thing as MFD so
describe properly without using Linuxisms what do you need here. Then
say what for (purpose).


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
> +
> +required:
> +  - compatible
> +  - vcc-supply
> +
> +dependentRequired:
> +  nvmem-cells: [ nvmem-cell-names ]

Only this is needed

> +  nvmem-cell-names: [ nvmem-cells ]

This is not.

> +
> +allOf:
> +  - $ref: ethernet-phy-package.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: x-powers,ac200-ephy-package
> +    then:
> +      properties:
> +        clocks: false
> +      required:
> +        - x-powers,ac200
> +  - if:
> +      properties:
> +        compatible:
> +          const: x-powers,ac300-ephy-package
> +    then:
> +      properties:
> +        reg:
> +          maximum: 7
> +        x-powers,ac200: false
> +      required:
> +        - clocks
> +        - nvmem-cells
> +        - nvmem-cell-names
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
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ethernet-phy-package@0 {
> +            compatible = "x-powers,acx00-ephy-package";
> +            reg = <0>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&pwm 5>;
> +            vcc-supply = <&reg_3v3>;
> +            nvmem-cells = <&ephy_configuration>;
> +            nvmem-cell-names = "configuration";
> +            x-powers,ac200 = <&ac200>;
> +
> +            ethernet-phy@0 {
> +                compatible = "ethernet-phy-id0044.1400";
> +                reg = <0>;
> +            };
> +        };
> +    };

One example is enough, they are all almost the same (difference in one
property - clocks - does not warrant a new example usually).


Best regards,
Krzysztof
