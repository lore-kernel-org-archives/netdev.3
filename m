Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D71E1DF0;
	Mon,  3 Aug 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773751; cv=none; b=oaQPKxfJVL964CAYohI8FxhD9R/55H5glrOLlwp/d32QuhU/yA8s8Krz1eVi79eFxlmssphA5gp9D1lglMlr570kptXxhFJqoKHn5uT3VqBkqCH7aq6XWxvjbB9z2Dr46FrrQPNicpKESGxfFbZkbrmaTjHL7TM8OUrt+H/PIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773751; c=relaxed/simple;
	bh=eiVwnGPpXLldvG1QYpMWuvnbsqt6XAD0prg9nqLhy8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hqa8PsmUn9tXDKjQCYvbjuWuIXvoJgCfRpBoot0sDKsv36oM3RwzI+n/+oQvn1Visj4qMns/lUT7pqaVqL/aywRtpoRfHHBjLL2rxNEcntSPQ8TsGDzsA6hfDN2KPwtsnlqnOpG03tox9W0udUvsPVVY6lH7EWEooNmQsxDyNLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vN5qt248; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+umJ5+H0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vN5qt248";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+umJ5+H0"
Message-ID: <411ec84fd55e152e94ac1f4edba497eac3a5623d.camel@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785773746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ek6ePpaHq1nB/PByuKcYxFoevXTAY7o/Ubz27BONoTo=;
	b=vN5qt248ue9jk6isClxGO2MndfGNMuayB0MulNHmns9lBBOYr4vSTOE2WHoZhI2MPrEe/a
	0op6jCMbW3qUehbBUZx7iOqkYhWKS4Hc41+kK7pRVwdPdv/TLcHsQS+QNywnNdNzW7qE1z
	/yGtt5Z3+L5h/y/+t6hIixLIi5deqZkqguQBnsTFxFHxBiQmWzSIYkq6B3PCH0sXO7MIvL
	2TfGTU1tV2UF2NlRmWJzq7KLsFai7WVTjf01lCjErvHYdPRjDkKI/J98z5nE4/cdjLL1VA
	nqvw+dxngMfnRIyQajJ2/wtjQY0pa6gOnmhUM23l7o1B1J0ogCvKWW+RfUCX/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785773746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ek6ePpaHq1nB/PByuKcYxFoevXTAY7o/Ubz27BONoTo=;
	b=+umJ5+H0ea1cGmtFLEqjbJuZkChWjNemaARRwFbCfpJHAWpVdg7QaRwybu1DSOoeu/u4DG
	lk50JBFa7QpYZ5Dg==
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: Add SoC-e switch IP and DSA
 bindings
From: Vasilij Strassheim <v.strassheim@linutronix.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Vladimir
 Oltean <olteanv@gmail.com>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,  Martin Kaistra
 <martin.kaistra@linutronix.de>
Date: Mon, 03 Aug 2026 18:15:45 +0200
In-Reply-To: <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
References: 
	<20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
	 <20260729-devel-vstrassheim-soce-dsa-ml-v1-2-be569dae1b20@linutronix.de>
	 <20260730-loutish-labrador-of-joviality-6e6c79@quoll>
Organization: Linutronix GmbH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-30 at 10:56 +0200, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2026 at 06:36:55PM +0200, Vasilij Strassheim wrote:
> > Add DT schema documentation for SoC-e FPGA switch devices.
> > The binding is split into:
> >  - a switch IP node describing the MMIO register block
> >  - a DSA MDIO node describing the DSA-facing switch instance
> > Both nodes are linked through the soce,switch-ip phandle.
> >=20
> > Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
> > ---
> >  .../bindings/net/dsa/soce,switch-dsa.yaml          | 195 +++++++++++++=
++++++++
> >  .../bindings/net/dsa/soce,switch-ip.yaml           |  54 ++++++
> >  2 files changed, 249 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.=
yaml b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
> > new file mode 100644
> > index 000000000000..a04e2838d14e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml
> > @@ -0,0 +1,195 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/soce,switch-dsa.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoC-e DSA switch MDIO device
> > +
> > +maintainers:
> > +  - SoC-e <info@soc-e.com>
>=20
> Nope, as explained more than once group boxes are not accepted.

That rule makes actually sense. I just saw UNGLinuxDriver@microchip.com in
several places and thought it wasn't completely forbidden here.
Will change it to my address in the next version.

>=20
> > +
> > +description: |
> > +  This node is the MDIO-bus device entry for the SoC-e DSA switch driv=
er.
>=20
> Node is not for a driver. Explain the hardware, not drivers, not DTS.

Got it, will change it for the next version.

>=20
>=20
> > +  It is a lightweight configuration node that lives on the MDIO bus of=
 the
> > +  SoC Ethernet controller acting as the DSA conduit (CPU port).
> > +
> > +  The switch hardware itself (MMIO register interface) is a separate I=
P core
> > +  described by a companion node with one of the SoC-e compatible strin=
gs,
> > +  for example:
> > +    - soce,mrs-<version>
>=20
> How is this relevant here? do you describe this compatible?

I will completely rework the documentation to reflect other code changes an=
d
take the comment into account.
>=20
> > +  See the consolidated IP-core binding:
> > +    - Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
> > +  The two nodes are linked via the "soce,switch-ip" phandle property.
> > +
> > +  Port sub-nodes follow the DSA port binding documented in dsa-port.ya=
ml.
> > +  User ports should reference PHY nodes through "phy-handle". These PH=
Y nodes
> > +  live under the optional "mdio" child node of the switch and are expo=
sed on
> > +  the switch's synthetic DSA user MDIO bus.
> > +
> > +  The PHY-specific properties "soce,mdio-output" and "soce,phy-addr" d=
escribe
> > +  the MDIO bus index and hardware PHY address used by the on-chip MDIO=
 master
> > +  of the switch IP core.
> > +
> > +properties:
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
>=20
> You need to follow DTS coding style.

I will check and correct this.

>=20
> > +
> > +  compatible:
> > +    const: soce,switch-dsa
>=20
> Way too generic. I understand that SoCe will NEVER - and you certify
> that - develop a second, different "switch-dsa" model and they call this
> one like this?

It is intentionally generic to cover the common basics of all variants and
configurations of the synthesized switch in DSA.
I'm not sure what kind of guarantee I'm supposed to provide here regarding
SoCe. If switch-dsa is already mainline in the future, then a different
compatible will be needed for incompatible new models.

> > +
> > +  reg:
> > +    description: MDIO address of this device on the parent MDIO bus.
>=20
> Drop.

Will do.

>=20
> > +    maxItems: 1
> > +
> > +  soce,switch-ip:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description: |
> > +      Phandle to the SoC-e switch IP core node that provides the MMIO =
register
> > +      window for this switch instance. The referenced node must carry =
a
> > +      compatible string documented in
> > +      Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml.
> > +
> > +  dsa,member:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
>=20
> Why do you need to redefine existing property?

This will be reworked in the next version.

>=20
> > +    minItems: 2
> > +    maxItems: 2
> > +    description:
> > +      DSA cluster membership; see Documentation/devicetree/bindings/ne=
t/dsa/dsa.yaml.
>=20
> Drop. Do not redefine properties. See other bindings how this is done.

I will do that.

>=20
> > +
> > +  mdio:
> > +    $ref: /schemas/net/mdio.yaml#
> > +    description: |
> > +      Optional child MDIO bus exposing PHY devices attached to switch =
user
> > +      ports. PHY nodes referenced by port "phy-handle" properties shou=
ld be
> > +      placed here. The PHY address seen by Linux on this bus is the sw=
itch port
> > +      index, not necessarily the hardware PHY address selected interna=
lly by
> > +      the switch IP.
> > +    unevaluatedProperties: false
> > +
> > +    patternProperties:
> > +      "^ethernet-phy@[0-9a-f]+$":
>=20
> Use consistent quotes.

Got it.

>=20
> > +        type: object
> > +        $ref: /schemas/net/ethernet-phy.yaml#
> > +        unevaluatedProperties: false
> > +        description:
> > +          PHY attached to a switch user port through the synthetic swi=
tch MDIO
> > +          bus.
> > +        properties:
> > +          soce,mdio-output:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            description: |
> > +              Zero-based index of the MDIO bus output of the switch IP=
 core to
> > +              which this PHY is connected.
> > +
> > +          soce,phy-addr:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            description: |
> > +              Hardware PHY address on the MDIO bus selected by
> > +              "soce,mdio-output".
> > +
> > +        required:
> > +          - soce,mdio-output
> > +          - soce,phy-addr
> > +
> > +  ports:
> > +    type: object
> > +    description: Container node for the switch port sub-nodes.
> > +    properties:
> > +      '#address-cells':
> > +        const: 1
> > +      '#size-cells':
> > +        const: 0
> > +
> > +    patternProperties:
> > +      "^port@[0-9a-f]+$":
> > +        $ref: dsa-port.yaml#
> > +        unevaluatedProperties: false
> > +        description: |
> > +          Switch port. In addition to the standard DSA port properties
> > +          (label, phy-mode, ethernet, fixed-link) the following
> > +          vendor-specific properties are used for data ports connected=
 to
> > +          external PHYs.
> > +
> > +    required:
> > +      - '#address-cells'
> > +      - '#size-cells'
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - soce,switch-ip
> > +  - ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    /* Excerpt from a Xilinx ZynqMP design (ARM64) */
> > +    mdio {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        soce_switch: switch@10 {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +            compatible =3D "soce,switch-dsa";
> > +            reg =3D <0x10>;
> > +            soce,switch-ip =3D <&soce_switch_ip>;
> > +            dsa,member =3D <0 0>;
> > +
> > +            ports {
> > +                #address-cells =3D <1>;
> > +                #size-cells =3D <0>;
> > +
> > +                port@0 {
> > +                    reg =3D <0x0>;
> > +                    label =3D "PORT_0";
> > +                    phy-handle =3D <&switchphy0>;
> > +                    phy-mode =3D "rgmii-id";
> > +                };
> > +
> > +                port@1 {
> > +                    reg =3D <0x1>;
> > +                    label =3D "PORT_1";
> > +                    phy-handle =3D <&switchphy1>;
> > +                    phy-mode =3D "rgmii-id";
> > +                };
> > +
> > +                port@2 {
> > +                    reg =3D <0x2>;
> > +                    label =3D "INTERNAL_PORT";
> > +                    ethernet =3D <&gem3>;
> > +                    phy-mode =3D "gmii";
> > +                    fixed-link {
> > +                        speed =3D <1000>;
> > +                        full-duplex;
> > +                    };
> > +                };
> > +            };
> > +
> > +            mdio {
> > +              #address-cells =3D <1>;
> > +              #size-cells =3D <0>;
> > +
> > +                switchphy0: ethernet-phy@0 {
> > +                    compatible =3D "ethernet-phy-ieee802.3-c22";
> > +                    reg =3D <0x0>;
> > +                    soce,mdio-output =3D <0x00000000>;
> > +                    soce,phy-addr =3D <1>;
> > +                };
> > +
> > +                switchphy1: ethernet-phy@1 {
> > +                    compatible =3D "ethernet-phy-ieee802.3-c22";
> > +                    reg =3D <0x1>;
> > +                    soce,mdio-output =3D <0x00000001>;
> > +                    soce,phy-addr =3D <1>;
> > +                };
> > +            };
> > +        };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.y=
aml b/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
> > new file mode 100644
> > index 000000000000..ba9bb396235f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/soce,switch-ip.yaml
>=20
> Filename must match compatible.

I will rewrite the entire documentation to have a single file and take that
into account.

>=20
> > @@ -0,0 +1,54 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/soce,switch-ip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SoC-e Ethernet Switch IP core
> > +
> > +maintainers:
> > +  - SoC-e <info@soc-e.com>
> > +
> > +description: |
> > +  SoC-e Ethernet switch IP cores are configurable FPGA switch fabrics =
with
> > +  Layer-2 bridging features (including STP/MSTP state control and FDB
> > +  fast-age support). Some variants also provide TSN functionality.
> > +
> > +  This binding describes only the MMIO switch IP core node. The Linux =
DSA
> > +  driver is bound via a companion MDIO node described in:
> > +    Documentation/devicetree/bindings/net/dsa/soce,switch-dsa.yaml.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - soce,mrs-21-01
> > +      - soce,mrs-23-02
> > +      - soce,mrs-24-01
> > +
> > +  reg:
> > +    description: |
> > +      MMIO base address and size of the switch register window.
> > +      On 64-bit platforms (ARM64), this is typically encoded as two-ce=
ll
> > +      address and two-cell size values.
>=20
> Pointless. Please open any other existing binding.

Got it.

>=20
> > +    maxItems: 1
> > +
> > +  soce,num-ports:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: |
> > +      Total number of switch ports (external/user ports plus the CPU u=
plink
> > +      port). Must be greater than zero and not exceed the selected IP =
variant.
>=20
> Either implied by compatible or not properly placed. Looks like propertt
> of the DSA.

This will be removed.

> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - soce,num-ports
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    switch_ip: switch@80020000 {
>=20
> ethernet-switch
>=20
> And drop unused label.

I will adjust it.

>=20
> Considering this wasn't tested I should not even give here review...
>=20
Thank you very much for the review!
I'm not sure what you mean by not tested. I ran make dt_binding_check` few
times, but forgot to do it after making the latest adjustments.
The driver also worked for different people with the device tree that I tri=
ed
to reflect here.

I will take a closer look at the documentation and other drivers, before I
send the next version.

> Best regards,
> Krzysztof
>=20

Thanks,
Vasilij

