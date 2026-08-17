Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C1B153BE9;
	Mon, 17 Aug 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976470; cv=none; b=LvYVA6ejFf/HnTS1oX0ItLGeffwg9Uflv+9Zun76Nk3zLJfypFnMXoyxWAsapw47sBZZ5x4/UhhVD920G3wO01zJU5K4642O37kO5CzNLH+gfbqBM4pQPHxuzyMWO2rMQUl9+fal2UTufCh1iIg+41gkpgBymqKswz6PZDCXQA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976470; c=relaxed/simple;
	bh=c6RArJ3pLovuoEN7rKQ9hN6NGpOX2uKschttglV4SWA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e75TNjqr12RjyFXImK/WwnCYKhJCEKKRZ2JF23ZkZT9vSrDuaSM++EU7PyxpVuLsLN5I+Kqw+s4h8EWBiRyQZ9ZnmTuJtchDI+6D439EFl+Fr7n25B7Ynw1zLAHO2iHDRrYiHMVOmxM989V54zdaCfeCg7w3FNFDsnsOpmAVpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ktvomPyi; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ktvomPyi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786976468; x=1818512468;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=c6RArJ3pLovuoEN7rKQ9hN6NGpOX2uKschttglV4SWA=;
  b=ktvomPyi0SIRk+sQBAj4+SLuBf31Ws0pNIQeGfLgBQefN/fyvffgApgp
   hhVqQYomhwJR/uPul5IG24LJGUqfxU5tDszoZJaTZmuEXyZfRFrVH0F/l
   EVYHPA/4qclh1KHCNzScaiuevw9aR9qLLAiwgXjC3auzEp7DLmTazvZlM
   a/LDo+9CRr3+I0B08/eEmMfxAx55PJCOY1wS75SHYyOjmyUedR/ARNEOQ
   XM+hf1FXfUilqHIBqP87htzGRSHr9Rxt5pZRUzvZnYC8Gg7ffyXSDWRuH
   I+rrY1d8S7dL1/2VxoHb9002Sye637LYET6gp+e4BUIPskc0Ubdf8jjex
   g==;
X-CSE-ConnectionGUID: vX42fI8+ToqV1Q70wvvSeQ==
X-CSE-MsgGUID: kkFpLuHOTq2FmDJ20CtFzw==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="62555468"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 07:21:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 17 Aug 2026 07:21:07 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 07:21:04 -0700
Message-ID: <dc119def49738f5ecce9adf2f27d40374ff9045d.camel@microchip.com>
Subject: Re: [PATCH net-next v11 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Mon, 17 Aug 2026 16:21:03 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-2-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-2-007ebc983a0a@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This is my reply to:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805-dsa_lan9645x_s=
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D2

> --- Patch [2]: [PATCH net-next v11 2/9] dt-bindings: net: lan9645x: add L=
AN9645X switch bindings ---
> commit 1b95e77c1cab7610f3d242846549a69514641335
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> dt-bindings: net: lan9645x: add LAN9645X switch bindings
>
> This adds a new DSA binding for the Microchip LAN9645x switch family,
> using the smallest SKU (microchip,lan96455s-switch) as the fallback
> compatible, and adds the file to the existing MAINTAINERS entry.
>
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
55s-switch.yaml
b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
> > new file mode 100644
> > index 0000000000000..043fb48922b41
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-swi=
tch.yaml
> > @@ -0,0 +1,111 @@
>
> [ ... ]
>
> > +  ethernet-ports:
> > +    type: object
> > +    patternProperties:
> > +      "^ethernet-port@[0-8]$":
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, sashiko-gemini =C2=B7 C=
onfirmed by: sonnet-5
> Are the constraints under this pattern actually reachable for all legal
> port node names?
>
> The top-level $ref pulls in dsa.yaml#/$defs/ethernet-ports, which accepts=
:
>
>   patternProperties:
>     "^(ethernet-)?ports$":
>       patternProperties:
>         "^(ethernet-)?port@[0-9a-f]+$":
>           description: Ethernet switch ports
>           $ref: dsa-port.yaml#
>           unevaluatedProperties: false
>
> So both port@N and ethernet-port@N are valid spellings, and indices are
> not limited to 0-8. The local ethernet-ports object here has no
> additionalProperties or unevaluatedProperties of its own, so children who=
se
> names do not match "^ethernet-port@[0-8]$" are simply not checked against
> the local constraints.
>
> That means these two both pass dt_binding_check:
>
>   ethernet-ports {
>       port@7 {
>           phy-mode =3D "rgmii";
>           rx-internal-delay-ps =3D <500>;   /* const: 2000 not applied */
>       };
>   };
>
>   ethernet-ports {
>       ethernet-port@9 {                   /* index > 8 not rejected */
>           reg =3D <9>;
>       };
>   };
>
> Would using the "^(ethernet-)?port@[0-8]$" spelling here, as
> Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml does with
> "^(ethernet-)?port@6$", make the new per-port constraints effective?
>

Yes, I will update the regex.

> > +        type: object
> > +        description: Ethernet switch ports
> > +
> > +        $ref: dsa-port.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          rx-internal-delay-ps:
> > +            const: 2000
> > +
> > +          tx-internal-delay-ps:
> > +            const: 2000
>
> Discovered by: opus-5, sashiko-gemini =C2=B7 Missed by: sonnet-5 =C2=B7 C=
onfirmed by: sonnet-5
> Should these two properties be guarded by an rgmii phy-mode conditional?
>
> As written they are declared for every port index 0-8 with no phy-mode
> condition, and since they live in the same schema object that carries
> unevaluatedProperties: false, they count as evaluated for any phy-mode.
> This passes validation:
>
>   ethernet-port@0 {
>       reg =3D <0>;
>       phy-mode =3D "gmii";
>       rx-internal-delay-ps =3D <2000>;
>   };
>
> Per the driver, only ports 7 and 8 have RGMII pins
> (lan9645x_phylink_get_caps(): 0..4 GMII/cuphy, 5..6 SerDes, 7..8 RGMII),
> and only lan9645x_rgmii_dll_config() programs the delay lines, with
> RGMII_IDX(port) defined for ports 4/7/8 only. On a gmii port the value is
> stored in p->rx_internal_delay by lan9645x_port_setup() and then never
> used, with no diagnostic.
>
> The existing pattern is a conditional, see
> Documentation/devicetree/bindings/net/dsa/vitesse,vsc73xx.yaml:
>
>   "^(ethernet-)?port@6$":
>     allOf:
>       - if:
>           properties:
>             phy-mode:
>               contains:
>                 enum:
>                   - rgmii
>         then:
>           properties:
>             rx-internal-delay-ps: ...
>
> Documentation/devicetree/bindings/net/ethernet-controller.yaml also defin=
es
> these properties only inside an rgmii* phy-mode conditional.

Yes, I will a conditional here.

>
> Separately, ethernet-controller.yaml states:
>
>   A value of 2000ps, i.e 2ns, and a phy-mode of "rgmii" will not be
>   accepted by Reviewers
>
> which is the combination this binding mandates with const: 2000 and shows
> in the example below. Is a phy-mode of "rgmii" together with a 2000 ps
> internal delay intended here, rather than one of the rgmii-rxid /
> rgmii-txid / rgmii-id modes?

I think ethernet-controller.yaml talks about the situation where there is a=
 PHY
present. The intent here is a mac to mac connection. I was specifically
instructed to model it like this, and not do use rgmii-*id as a way to
communicate delay programming of the MAC. It is also clear from
Documentation/networking/phy.rst
that this is the right way to model mac to mac.

>
> > +
> > +$ref: dsa.yaml#/$defs/ethernet-ports
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - ethernet-ports
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    ethernet-switch@4000 {
> > +        compatible =3D "microchip,lan96459f-switch", "microchip,lan964=
55s-switch";
> > +        reg =3D <0x4000 0x244>;
> > +
> > +        ethernet-ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            ethernet-port@0 {
> > +                reg =3D <0>;
> > +                phy-mode =3D "gmii";
> > +                phy-handle =3D <&cuphy0>;
> > +            };
>
> [ ... ]
>
> > +
> > +            ethernet-port@7 {
> > +                reg =3D <7>;
> > +                phy-mode =3D "rgmii";
> > +                ethernet =3D <&cpu_host_port>;
> > +                rx-internal-delay-ps =3D <2000>;
> > +                tx-internal-delay-ps =3D <2000>;
> > +
> > +                fixed-link {
> > +                    speed =3D <1000>;
> > +                    full-duplex;
> > +                    pause;
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > +
>       ^^^
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, sashiko-gemini =C2=B7 C=
onfirmed by: sonnet-5
> This isn't a bug, but there is a blank line after the end-of-document
> marker at the end of the file, which git diff --check reports as "new bla=
nk
> line at EOF". The other bindings in this directory end with "..." and
> nothing after it.

I will remove this.

>
> Cross-instance finding from sashiko-gemini
(008974e58f4042f8866239fc681c104931d4e9cd342a5b5be37f42504a115cf0):
> Discovered by: sashiko-gemini, opus-5 =C2=B7 Missed by: sonnet-5 =C2=B7 C=
onfirmed by: opus-5
> The schema lacks an `mdio` node definition while setting `unevaluatedProp=
erties: false` at the root,
which inadvertently prevents instantiation of the integrated PHYs reference=
d in the example.

