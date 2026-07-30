Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A242830D3E8;
	Thu, 30 Jul 2026 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401800; cv=none; b=quCB37PcPt0Zig/jGB9Hh9k5SWhhxe29RZvwzG0VjdManpcaCPopFVWkZqwHYlrhdUX9exhqpXh9LItSAOn7uddC3N4l61K/DmQVKNv2WaImmw6lUewN3in00/AzVmBj2hljinmv38EbDfFuxIpuHbsB19Gp2vvmdEtdDARP9co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401800; c=relaxed/simple;
	bh=eALr7vWbVLsVlbrQ4mhck/r3p/jwYJnwooIZLrLXV0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twCjLgga5KxNk80n2g2XEnvVO9lchRs/RqTb/ZrtZv73iftbFZWVxw/niL1eCrm42VjLSCcrMSWjexwv0QQeUt+rnjgEQcvqOmrIzktq8itt6w6AzQ1G+TiuuFhR+x/lFHcjz6S1Znog6OI3JDETmgf+Br5jfo4SEj201U61Et4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQ0jDwHy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQ0jDwHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA801F000E9;
	Thu, 30 Jul 2026 08:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785401798;
	bh=NSwk1yjlgGEwuKvvQxal4UzNOYWh4imc3Jz5E0gp9dE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fQ0jDwHy28al2nErz6ccpr9o7GYNo8F/HHslZBGc5s8Zg9WrAUdhJFzuz5FlPHh7e
	 FCeEg7SKS/6bJ1gn90zJPeJCrY1oSNOb0nzc+d62LVK7hfR7ULeK3DZQ1cYPN1RMjW
	 ggSGqybtqyStX/xOmWXh+nY+KKau45Yd0ZMk9KwqZw94fXMce9oofplQFzC57aZAxZ
	 Bm0VcX5e1TSnYdeF4R+1zb018BBQRylyHLsJyIBxti2OONWHlOjWxS27XRw0Nc4jpU
	 Mws9CjDJCmzgHhPVdQnaamLSwFSZbIC9m+4hedkSpRlfx8dG+UYVym8LDaUpqPJ8el
	 rcFlxt2WqAkHQ==
Date: Thu, 30 Jul 2026 10:56:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
Message-ID: <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>

On Wed, Jul 29, 2026 at 06:36:55PM +0200, Vasilij Strassheim wrote:
> Add DT schema documentation for SoC-e FPGA switch devices.
> The binding is split into:
>  - a switch IP node describing the MMIO register block
>  - a DSA MDIO node describing the DSA-facing switch instance
> Both nodes are linked through the soce,switch-ip phandle.
> 
> Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> ---
>  .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++++++++++++
>  .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
>  2 files changed, 249 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
> new file mode 100644
> index 000000000000..a04e2838d14e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/soce,switch-dsa.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC-e DSA switch MDIO device
> +
> +maintainers:
> +  - SoC-e <info@soc-e.com>

Nope, as explained more than once group boxes are not accepted.

> +
> +description: |
> +  This node is the MDIO-bus device entry for the SoC-e DSA switch driver.

Node is not for a driver. Explain the hardware, not drivers, not DTS.


> +  It is a lightweight configuration node that lives on the MDIO bus of the
> +  SoC Ethernet controller acting as the DSA conduit (CPU port).
> +
> +  The switch hardware itself (MMIO register interface) is a separate IP core
> +  described by a companion node with one of the SoC-e compatible strings,
> +  for example:
> +    - soce,mrs-<version>

How is this relevant here? do you describe this compatible?

> +  See the consolidated IP-core binding:
> +    - Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
> +  The two nodes are linked via the "soce,switch-ip" phandle property.
> +
> +  Port sub-nodes follow the DSA port binding documented in dsa-port.yaml.
> +  User ports should reference PHY nodes through "phy-handle". These PHY nodes
> +  live under the optional "mdio" child node of the switch and are exposed on
> +  the switch's synthetic DSA user MDIO bus.
> +
> +  The PHY-specific properties "soce,mdio-output" and "soce,phy-addr" describe
> +  the MDIO bus index and hardware PHY address used by the on-chip MDIO master
> +  of the switch IP core.
> +
> +properties:
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

You need to follow DTS coding style.

> +
> +  compatible:
> +    const: soce,switch-dsa

Way too generic. I understand that SoCe will NEVER - and you certify
that - develop a second, different "switch-dsa" model and they call this
one like this?

> +
> +  reg:
> +    description: MDIO address of this device on the parent MDIO bus.

Drop.

> +    maxItems: 1
> +
> +  soce,switch-ip:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: |
> +      Phandle to the SoC-e switch IP core node that provides the MMIO register
> +      window for this switch instance. The referenced node must carry a
> +      compatible string documented in
> +      Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml.
> +
> +  dsa,member:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Why do you need to redefine existing property?

> +    minItems: 2
> +    maxItems: 2
> +    description:
> +      DSA cluster membership; see Documentation/devicetree/bindings/net/dsa/dsa.yaml.

Drop. Do not redefine properties. See other bindings how this is done.

> +
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    description: |
> +      Optional child MDIO bus exposing PHY devices attached to switch user
> +      ports. PHY nodes referenced by port "phy-handle" properties should be
> +      placed here. The PHY address seen by Linux on this bus is the switch port
> +      index, not necessarily the hardware PHY address selected internally by
> +      the switch IP.
> +    unevaluatedProperties: false
> +
> +    patternProperties:
> +      "^ethernet-phy@[0-9a-f]+$":

Use consistent quotes.

> +        type: object
> +        $ref: /schemas/net/ethernet-phy.yaml#
> +        unevaluatedProperties: false
> +        description:
> +          PHY attached to a switch user port through the synthetic switch MDIO
> +          bus.
> +        properties:
> +          soce,mdio-output:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: |
> +              Zero-based index of the MDIO bus output of the switch IP core to
> +              which this PHY is connected.
> +
> +          soce,phy-addr:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            description: |
> +              Hardware PHY address on the MDIO bus selected by
> +              "soce,mdio-output".
> +
> +        required:
> +          - soce,mdio-output
> +          - soce,phy-addr
> +
> +  ports:
> +    type: object
> +    description: Container node for the switch port sub-nodes.
> +    properties:
> +      '#address-cells':
> +        const: 1
> +      '#size-cells':
> +        const: 0
> +
> +    patternProperties:
> +      "^port@[0-9a-f]+$":
> +        $ref: dsa-port.yaml#
> +        unevaluatedProperties: false
> +        description: |
> +          Switch port. In addition to the standard DSA port properties
> +          (label, phy-mode, ethernet, fixed-link) the following
> +          vendor-specific properties are used for data ports connected to
> +          external PHYs.
> +
> +    required:
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - soce,switch-ip
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    /* Excerpt from a Xilinx ZynqMP design (ARM64) */
> +    mdio {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        soce_switch: switch@10 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "soce,switch-dsa";
> +            reg = <0x10>;
> +            soce,switch-ip = <&soce_switch_ip>;
> +            dsa,member = <0 0>;
> +
> +            ports {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                port@0 {
> +                    reg = <0x0>;
> +                    label = "PORT_0";
> +                    phy-handle = <&switchphy0>;
> +                    phy-mode = "rgmii-id";
> +                };
> +
> +                port@1 {
> +                    reg = <0x1>;
> +                    label = "PORT_1";
> +                    phy-handle = <&switchphy1>;
> +                    phy-mode = "rgmii-id";
> +                };
> +
> +                port@2 {
> +                    reg = <0x2>;
> +                    label = "INTERNAL_PORT";
> +                    ethernet = <&gem3>;
> +                    phy-mode = "gmii";
> +                    fixed-link {
> +                        speed = <1000>;
> +                        full-duplex;
> +                    };
> +                };
> +            };
> +
> +            mdio {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +                switchphy0: ethernet-phy@0 {
> +                    compatible = "ethernet-phy-ieee802.3-c22";
> +                    reg = <0x0>;
> +                    soce,mdio-output = <0x00000000>;
> +                    soce,phy-addr = <1>;
> +                };
> +
> +                switchphy1: ethernet-phy@1 {
> +                    compatible = "ethernet-phy-ieee802.3-c22";
> +                    reg = <0x1>;
> +                    soce,mdio-output = <0x00000001>;
> +                    soce,phy-addr = <1>;
> +                };
> +            };
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
> new file mode 100644
> index 000000000000..ba9bb396235f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml

Filename must match compatible.

> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/soce,switch-ip.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoC-e Ethernet Switch IP core
> +
> +maintainers:
> +  - SoC-e <info@soc-e.com>
> +
> +description: |
> +  SoC-e Ethernet switch IP cores are configurable FPGA switch fabrics with
> +  Layer-2 bridging features (including STP/MSTP state control and FDB
> +  fast-age support). Some variants also provide TSN functionality.
> +
> +  This binding describes only the MMIO switch IP core node. The Linux DSA
> +  driver is bound via a companion MDIO node described in:
> +    Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - soce,mrs-21-01
> +      - soce,mrs-23-02
> +      - soce,mrs-24-01
> +
> +  reg:
> +    description: |
> +      MMIO base address and size of the switch register window.
> +      On 64-bit platforms (ARM64), this is typically encoded as two-cell
> +      address and two-cell size values.

Pointless. Please open any other existing binding.

> +    maxItems: 1
> +
> +  soce,num-ports:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: |
> +      Total number of switch ports (external/user ports plus the CPU uplink
> +      port). Must be greater than zero and not exceed the selected IP variant.

Either implied by compatible or not properly placed. Looks like propertt
of the DSA.

> +
> +required:
> +  - compatible
> +  - reg
> +  - soce,num-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    switch_ip: switch@80020000 {

ethernet-switch

And drop unused label.

Considering this wasn't tested I should not even give here review...

Best regards,
Krzysztof

