Received: from mail-ej2-f2.google.com (mail-ej2-f2.google.com [74.125.228.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407203CEBBA
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950417; cv=pass; b=Rzzt42GxLZ2/n9bn0/MsjkxrH4WJOJ1CdOQUKUJLBLWt+iU2goufu1qIqGj3DkJjMuIr+Y1sO2z/DRy6xW1BpLj2xcNx333lEL1XicxFQVFznbaSuzlCt4kMKV//tQedGTNC5tSqfrtsjN92EwyWJG0oPOJgxEL10oESM1GbcpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950417; c=relaxed/simple;
	bh=aKGwayxXZJAIgpMYypKzK/z3u4U/f9BptutZNU+jbA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCEhRG2CB8NpW+k9dPEJP/dKBKAU2Pbi6XYO69VNE3UGQyS3RPrAFNFYMi0ebV2fURIwqMTJtFRE7mzDt5IHSwkc79CNTcceiKr+tzQ1wr90EjPcMDKZoAxVcMYQXPlhlA/YFzXgd3yftvt46gPKx/p3rxZmAoVcbgavhKOj+jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8Oet//Y; arc=pass smtp.client-ip=74.125.228.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8Oet//Y"
Received: by mail-ej2-f2.google.com with SMTP id a640c23a62f3a-c15f8dd6f18so71950666b.1
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 10:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950413; cv=none;
        d=google.com; s=arc-20260327;
        b=TMmIgIP0mssfZ2aBOsDFhW4vkWd18ettEPANJY8e1HdGlBN95uoRk+6FhkTPHDGjil
         YPa1F13lY+NpDvjea59Yn+v0KMU0lqbQi0A7wZo0waCrXdI48zXhBiO/uXElHEvcLxlz
         Tz1mh86pUbs79ZYc2n2r+6yOZ/kBuLFquhV0ixSVQvWZU+tTqLH1sjbMPUe/Sil/bfpu
         q0ZkthzvXT+7fSGe4TDupF4710i7nt7HfOSOvOGILRpXSJKcnaS4EEIK4f+sd5sQVAr2
         g6C26RgNtsv5NEvmnpT6sAz9FnqSlkDfoByKas7S4rpy7oWpr6YofNepBXgHdqfRFlGM
         PZow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ed7d3IIv5/1/YcqJUTH/1nOy3fvwpEdX0Td4yCp6N7Q=;
        fh=ZQKAAuC2PMcq8HmH/kGR6r0vsWjNfXlwGDSigWBW+3k=;
        b=qrwXcsX1sq+pR91ptb0djFoOrlJ3+dbgdShKxZRAY0OJNPA3qVkeGXJ1qfBGc0DiZ9
         U6054uKnzJgBHf32BuoIDEYUr1Rk34VT+aPPtctzQq0qXZHIyeJaiXUrvShn7BROQQ9f
         lEnpexMRLFbro+4AQK6V7AbwhbH5nETc4vUwtAIVQA2ScnoPV760L0m66IOaYz7BdYV8
         VWIEmmHkv7O6xepVkLW8s5jL8JQ7insMnto128j9Y/gwuAxqWXRfxtJGxhbFw/Qw6aAO
         8IGXbBzF8IC3ohcjRiS7kSl6+MY3A3t16spe1VqnDtBO2HYQ0pJMmodOt3oOoKSho213
         kULg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950413; x=1786555213; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ed7d3IIv5/1/YcqJUTH/1nOy3fvwpEdX0Td4yCp6N7Q=;
        b=C8Oet//Y1gY+HJznZtY2c6htUddXGZAUVXXAUfyvQ/UNVePODdfCn3oV+fk7Y0MdJB
         EdbkEIVOvkC+LdyJ5tNYA/VkFkFZ5N4f3Z8xJ7Ab5HBXvg55EEZZZ5xCq9CPANsTPU8H
         PRTYzH2VLFz5dvPdyJMFPYNeWVh88GE+EBLCTBMmBGMXJDSBbQcL9M6h7/SLyxLPPcF6
         wyx0PRvULKOJwC1WvozTySxvOlYQZKTTSApNOGHNX5JA9PbGUFLztj8au3mGQYiv+1RX
         Mij4wv0c9EjraSi6+wUEv+wop6EQ01Sxp5pysPUNO6VFTkIHVbFeBcU43YDU0oTP01tj
         F1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950413; x=1786555213;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ed7d3IIv5/1/YcqJUTH/1nOy3fvwpEdX0Td4yCp6N7Q=;
        b=TU2jQD73v7QpeGCCC796nkVsAV+SupkNuChdq2sYQb97tG5qJCVtZ54MA0ZT6nvVMP
         1l/6QoKCiK2PQNLAMTeO9vilpvL/Hn4lgR8t+UD+7jcPgGPtP4kTOm77OnowJCNkFMNL
         y8lSJeLg43bKHsTRUc10EI7GmLgbP5mHVhakta9H+bZqJqqp28JIHMKjec2Vl82f0fU9
         dwzvJ38Kx5tflgT8e5K1LFLcOTbO4RgpQgEWe40vDTNO3Nzlao2lowS113z6yZkWozvl
         hy6z0OBMzv4OpXtEVI+K5u6ipCYlxnRIizG91F3Rh3sG/K+65iNkM00cU4FAxPpDjymm
         T5cg==
X-Forwarded-Encrypted: i=1; AHgh+Ro9Jn+Dtl/GzQouvHLXrTGvd931nqRPO3epJvJ89vtzpY1obWkwfAq/eR35WUjo2FpFszxDvqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eOMWMqdVDD8peAil0S2DlktDMJzEupUmHyd41O3vxai/NhI4
	OC12Iw1t+K1wouQ70cyd0bd8C3l8fvRLLv4RP0xfzDC6e/OdBYnUnh/rYCZDegQmMLKRRsYap+V
	9CwbnvKsVDw3NrloL5667f5MHeTWtql0=
X-Gm-Gg: AR+sD12m4Ac8dzvCsEqrLa1AUWTDg3Ot5OSZaURoho2devKt/iPiQP/VJdXlkmy1yaa
	FaI+ZmtZ+z41stcBtVyAWxt/Ym877kJs2btEGt1fjH1Jf+XLF+baREhstsO77WTV3w9wb14haM5
	lqEZHqDzZ9qgbHDRl/G23bMsqsFyUjQO8wx4A6pFExGIA9yQjIvuuWzooc9fliR+9LcjJK+Q/Ia
	Oh/vMRC5Qwvtr2umJ/PIoO+3xIV23w/nVvVVMCEYSLhhE7uJpjopK1OXFlkP4ImSrMfEjd7ISAN
	OewA+yKOdYpO+jAWviZObm9UYT5ipKSoR5rqXiOUe3qy4/gtjtwcIy/y4KFax9BdffgZAQY=
X-Received: by 2002:a17:906:7315:b0:c16:b87:de64 with SMTP id
 a640c23a62f3a-c2039c22d1fmr433223466b.15.1785950412968; Wed, 05 Aug 2026
 10:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801142244.679437-2-coiaprant@gmail.com> <20260801142244.679437-6-coiaprant@gmail.com>
 <20260805-stirring-wondrous-mule-faf37d@quoll>
In-Reply-To: <20260805-stirring-wondrous-mule-faf37d@quoll>
From: Coia Prant <coiaprant@gmail.com>
Date: Thu, 6 Aug 2026 01:20:09 +0800
X-Gm-Features: AUfX_mx8UFnbdlOwigeC8DoFtEekRCvwbvHBwVKJJj31ufe5iJU09i8ffEdEzOM
Message-ID: <CALj3r0hbp-zS7Sv-6T3uBOCq2ZO4XZHKvkD4dTZ3gXRS=90JUQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs binding
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Russell King <linux@armlinux.org.uk>, 
	Shawn Lin <shawn.lin@rock-chips.com>, David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for the detailed review. Here's my response to each point:

> > +title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
> > +
> > +maintainers:
> > +  - Coia Prant <coiaprant@gmail.com>
> > +
> > +description: |
> > +  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Physic=
al
> > +  Coding Sublayer (XPCS).
> > +  The PCS provides an interface between the Media Access Control (MAC)
> > +  and the Physical Medium Attachment (PMA) sublayer through a Media
> > +  Independent Interface (GMII).
> > +
> > +  The XPCS is accessed over the APB3 bus and internally connected to a
> > +  Naneng Combo SerDes PHY.
> > +  It supports 1000BASE-X, SGMII and QSGMII modes.
> > +
> > +  The block contains four MII ports (pcs-mii@0..3) that can be
> > +  individually enabled and routed to one of the Ethernet GMAC controll=
ers
> > +  via the pcs-handle property in the MAC device tree node.

1. Commit message: I'll drop the redundant description paragraph and keep
   only the essential information.

2. Subject: I'll drop the redundant "binding" word.

> +properties:
> +  compatible:
> +    const: rockchip,rk3568-xpcs
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0

3. reg order: I'll move reg to the second property (after compatible).

4. Quotes: I'll use consistent quoting style throughout.

> +  reg:
> +    description: |
> +      Base address and size of the XPCS register space mapped over the
> +      APB3 bus.

5. reg description: I'll drop it as redundant.

> +  clocks:
> +    description: |
> +      Clock sources for the XPCS:
> +      - csr: APB3 bus interface clock (clk_csr_i), required for register
> +        access.
> +      - eee: EEE clock (clk_eee_i), required for Energy Efficient
> +        Ethernet (EEE) operation.
> +    minItems: 2
> +    maxItems: 2

6. clocks: I'll change to items with descriptions instead of min/maxItems.

> +  clock-names:
> +    items:
> +      - const: csr
> +      - const: eee
> +
> +  phys:
> +    description: |

7. description formatting: I'll remove unnecessary '|' where not needed.

> +  power-domains:
> +    description: |
> +      Power domain for the XPCS.

8. power-domains description: I'll drop the redundant part.

> +patternProperties:
> +  "^pcs-mii@[0-3]$":

9. pcs-mii naming: I used "pcs-mii" because the Rockchip TRM refers to
   these as "MII ports" and they are functionally PCS instances. I do see
   a similar pattern in the Renesas RZN1 MIIC binding (renesas,rzn1-miic.ya=
ml),
   which uses "mii-conv@[0-5]$" for its ports. So the idea of having
   child nodes per port is not new.

   If you prefer a different name (e.g., "port@0"-"port@3" or "pcs@0"-"pcs@=
3"),
   I'm happy to change it. Please let me know what naming you'd recommend.

> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 3

10. reg constraints: I'll fix the min/max constraint to use items (or drop
    it since the node name regex already enforces the range).

> +      status: true

11. status property: I'll remove it, as it's a generic property and
    doesn't need explicit declaration.

Thanks,
Coia

Krzysztof Kozlowski <krzk@kernel.org> =E4=BA=8E2026=E5=B9=B48=E6=9C=885=E6=
=97=A5=E5=91=A8=E4=B8=89 15:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Aug 01, 2026 at 10:22:28PM +0800, Coia Prant wrote:
> > Add device tree binding documentation for the Synopsys DesignWare
> > XPCS integrated on the Rockchip RK3568 SoC.
> >
> > The XPCS is accessed over the APB3 bus and internally connected to
> > a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
> > QSGMII modes, with four MII ports.
> >
> > The binding describes:
> > - Required properties: compatible, reg, clocks, clock-names
> > - Optional properties: phys, phy-names, power-domains
> > - pcs-mii sub-nodes for each MII port (reg 0..3)
>
> Irrelevant paragraph. We can read the diff. Drop.
>
> A nit, subject: drop second/last, redundant "binding". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L23
>
> >
> > Signed-off-by: Coia Prant <coiaprant@gmail.com>
> > ---
> >  .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 127 ++++++++++++++++++
> >  1 file changed, 127 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-=
dwxpcs.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.=
yaml b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
> > new file mode 100644
> > index 0000000000000..3e3f3a388d822
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
> > @@ -0,0 +1,127 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/pcs/rockchip-dwxpcs.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
> > +
> > +maintainers:
> > +  - Coia Prant <coiaprant@gmail.com>
> > +
> > +description: |
> > +  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Physic=
al
> > +  Coding Sublayer (XPCS).
> > +  The PCS provides an interface between the Media Access Control (MAC)
> > +  and the Physical Medium Attachment (PMA) sublayer through a Media
> > +  Independent Interface (GMII).
> > +
> > +  The XPCS is accessed over the APB3 bus and internally connected to a
> > +  Naneng Combo SerDes PHY.
> > +  It supports 1000BASE-X, SGMII and QSGMII modes.
> > +
> > +  The block contains four MII ports (pcs-mii@0..3) that can be
> > +  individually enabled and routed to one of the Ethernet GMAC controll=
ers
> > +  via the pcs-handle property in the MAC device tree node.
> > +
> > +properties:
> > +  compatible:
> > +    const: rockchip,rk3568-xpcs
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
>
> reg is always the second property.
>
> Also, use consistent style of quotes.
>
> > +
> > +  reg:
> > +    description: |
> > +      Base address and size of the XPCS register space mapped over the
> > +      APB3 bus.
>
> Drop description, redundant.
>
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    description: |
> > +      Clock sources for the XPCS:
> > +      - csr: APB3 bus interface clock (clk_csr_i), required for regist=
er
> > +        access.
> > +      - eee: EEE clock (clk_eee_i), required for Energy Efficient
> > +        Ethernet (EEE) operation.
> > +    minItems: 2
> > +    maxItems: 2
>
> No, instead list items with description.
>
> > +
> > +  clock-names:
> > +    items:
> > +      - const: csr
> > +      - const: eee
> > +
> > +  phys:
> > +    description: |
>
> Do not need '|' unless you need to preserve formatting.
>
> > +      The phandle of SerDes PHY (Naneng Combo PHY) that provides
> > +      the serial lanes for 1000BASE-X / SGMII / QSGMII.
> > +      The SerDes must be powered on and initialised before any XPCS
> > +      register access.
> > +    maxItems: 1
> > +
> > +  phy-names:
> > +    const: serdes
> > +
> > +  power-domains:
> > +    description: |
> > +      Power domain for the XPCS.
>
> Drop sentence and |
>
> > +      On RK3568 this is typically the PD_PIPE power domain, which also
> > +      supplies the SerDes PHY.
> > +    maxItems: 1
> > +
> > +patternProperties:
> > +  "^pcs-mii@[0-3]$":
>
> Why `git grep pcs-mii@` gives me no results? Are you doing this
> similarly to existing devices or is this quite different device than
> every other hardware?
>
> > +    type: object
> > +    description: |
>
> Same here
>
> > +      One of the four MII ports of the XPCS.
> > +      The port number is specified by the reg property (0..3).
>
> Drop sentence, redundant. Schema tells that.
>
> > +      The port is linked to an Ethernet MAC controller via the
> > +      pcs-handle property in the MAC's device tree node.
> > +
> > +    properties:
> > +      reg:
> > +        minimum: 0
> > +        maximum: 3
> > +        description: |
>
> As well
>
> > +          MII port number of PCS.
> > +
> > +      status: true
>
> Nope, do you see anywhere code like this?
>
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/rk3568-cru.h>
> > +    #include <dt-bindings/power/rk3568-power.h>
> > +    #include <dt-bindings/phy/phy.h>
> > +
> > +    pcs@fda00000 {
> > +      compatible =3D "rockchip,rk3568-xpcs";
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      reg =3D <0xfda00000 0x200000>;
> > +      clocks =3D <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
> > +      clock-names =3D "csr", "eee";
> > +      phys =3D <&combphy2 PHY_TYPE_SGMII>;
> > +      phy-names =3D "serdes";
> > +      power-domains =3D <&power RK3568_PD_PIPE>;
> > +
> > +      pcs-mii@0 {
> > +        reg =3D <0>;
> > +      };
> > +    };
> > --
> > 2.47.3
> >
