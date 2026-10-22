Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669931;
	b=zPWWDHJ/k5KrSttNClwJ4OpQvAA0LCGnW79ua6KchiXDjXgH6+CuByMQWXBzKv4eGw5G
	 lIgdqbQnUyha5UbTOOzf6BeiNydvVV5IlqbaGEAuuEILM5YDmHz8O5AdEXLnZNm9Kn7Zu
	 ijYxFMcP9kz8uBA/oM++AP8SI64phHdX/Ev+kmkvAkLr8vPFEOI9H2vnRjmvb2QTTLfU4
	 RmuZDg+B+a2FlBGQ6EPKd1ZRj6oymqfouNuAQ5EAQKPnLSFoed5FX9/6IckgaKBkf8AIY
	 VQw06eav9/pamjuU1ywvWi2fNmZuv+qMCnbfCU9yZZ3aXNH5WA+zHUsVxvQ/X1EAjAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669931;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:
	 Subject:From:To:CC:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=p5tTWHAcP3up0aXcHETS/TW5nhe+pEJEUCXg8wqne3k=;
	b=NRBFgbixjj4FbcuTwhwjhspnbw1yF9NPh7wVfY1SKF1CEV/n3+gv9a2cYodg4QphzvQW
	 dUoALQZu1DZn9uDZMTyS6HoSnunsy22cYRvijPV50Bkr85feMQJ9PXvo+0fmlK1nUE8FZ
	 X1YPSok3thHv2ofYJRKMonORjt7d5oaMVRNz1/0cV4pC+VmUT35zegrJuq/969105OzUC
	 rpPQk/b+DMvmbnddumla0vAKFvYLKxZIYu3GC/zWYm1+nS+BgCGx37YLj3oeJu+04Dq8f
	 VsLSkTnlfsWdBWjW/RVHr0waXb++kdCqcZ7SuIhtOFSWpB6PP53R05kF9tWyluvR18g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pmZwlbVI;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B4606A31F;
	Thu, 22 Oct 2026 11:52:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B4B4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=pmZwlbVI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792669931; x=1824205931;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=qvSLYwQyZw17pBQ+bwSsK6HBoBcM99ELUEMZG7MTcVE=;
  b=pmZwlbVIP+CzXAlm+M3bhe4a4pmKkIyLFad8cCyrHAyKYxKT4czCqqPu
   sNNwWei277y+pmXlPQCG7y6S+9ckQkNT4tLZDdrlqhmHzWEmABN+kooRY
   a6fbVCEJCksOPJSs+6ySCvsqX9KK1vSww7X2tD3LTzrvAfn/g0A9KkrrR
   YvktWSWMFodilAPMYS/AS4LPFPpIaVApEMvLSxCMhk/HYkINeZfKSZrDi
   UxxOU0q+8tNrNwlXHEtcrAPm4au7WhxcVPMZ35BV45G+Yw+5Fi17cyvzb
   FpueAyUgH0qSTLaEZTCNGsESqj874YrRjE9hzB+6RucZYmas0hPMuwKNh
   w==;
X-CSE-ConnectionGUID: CMRa0V6VSTCQRzDlkb4RrA==
X-CSE-MsgGUID: 0unnfKbAQ3eaIWARu00bdA==
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="65412090"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 04:52:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 22 Oct 2026 04:52:09 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 22 Oct 2026 04:52:05 -0700
Message-ID: <9856209f2cb1ee581c70d4f71aa7674cd86be685.camel@microchip.com>
Subject: Re: [PATCH net-next v15 2/9] dt-bindings: net: dsa: add Microchip
 LAN9645x switch
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>, <edumazet@kernel.org>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Thu, 22 Oct 2026 13:52:04 +0200
In-Reply-To: <179240452378.3135.9892080157783163049@kernel.org>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-2-562f316f78b9@microchip.com>
	 <179240452378.3135.9892080157783163049@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 10:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The binding (microchip,lan96455s-switch.yaml) and its RGMII
>   delay design contradict the in-tree RGMII contract in ethernet-=E2=80=
=A6
> - [Low] The binding (microchip,lan96455s-switch.yaml) does not reject
>   port nodes beyond port 8, and those nodes escape its RGMII delay=E2=80=
=A6
>=20
> --
>=20
> dt-bindings: net: dsa: add Microchip LAN9645x switch
>=20
> This adds a YAML binding for the Microchip LAN9645x DSA switch family,
> with microchip,lan96455s-switch as the fallback compatible. The switch
> registers are described with one reg entry per register target. RGMII
> ports may set a fixed 0 or 2000 ps MAC internal delay.
>=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
55s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96=
455s-switch.yaml
> > new file mode 100644
> > index 0000000000000..517bc4c00de30
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-swi=
tch.yaml
> > @@ -0,0 +1,208 @@
>=20
> [ ... ]
>=20
> > +  ethernet-ports:
> > +    type: object
> > +    additionalProperties: true
> > +    patternProperties:
> > +      "^(ethernet-)?port@[0-8]$":
>=20
> [Severity: Low]
> Can port nodes above port 8 get past this schema?
>=20
> The local pattern only matches port@0 through port@8. However,
> ethernet-ports has additionalProperties: true, and the inherited
> dsa.yaml#/$defs/ethernet-ports checks "^(ethernet-)?port@[0-9a-f]+$"
> against dsa-port.yaml. That means port@9 through port@f are evaluated
> and pass.
>=20
> Those nodes also skip the local RGMII if/then. For example, port@9 with
> phy-mode =3D "rgmii" and rx-internal-delay-ps =3D <5000> passes, because
> ethernet-controller.yaml only types that property as uint32.
>=20
> The hardware has only 9 ports, so these nodes are rejected only at probe
> time:
>=20
> net/dsa/dsa.c:dsa_switch_parse_ports_of() {
>     ...
>                 if (reg >=3D ds->num_ports) {
>                         dev_err(ds->dev, "port %pOF index %u exceeds num_=
ports (%u)\n",
>     ...
> }
>=20
> The description says the last SKU digit gives 5, 7 or 9 usable front
> ports. No compatible-based if block limits which port@N nodes the 5-port
> and 7-port SKUs may declare, so a bare microchip,lan96455s-switch node ca=
n
> describe all nine ports.
>=20
> renesas,rzn1-a5psw.yaml, which the changelog names as the model, has the
> same pattern.
>=20
> Should the schema reject port nodes outside the range each SKU supports?
>=20
> > +        type: object
> > +        description: Ethernet switch ports
> > +        additionalProperties: true
> > +
> > +        allOf:
> > +          - if:
> > +              properties:
> > +                phy-mode:
> > +                  contains:
> > +                    enum:
> > +                      - rgmii
> > +                      - rgmii-rxid
> > +                      - rgmii-txid
> > +                      - rgmii-id
> > +            then:
> > +              properties:
> > +                rx-internal-delay-ps:
> > +                  $ref: "#/$defs/internal-delay-ps"
> > +                tx-internal-delay-ps:
> > +                  $ref: "#/$defs/internal-delay-ps"
>=20
> [ ... ]
>=20
> > +$defs:
> > +  internal-delay-ps:
> > +    description:
> > +      Disable the delay line using 0 ps, or enable the 2000 ps delay. =
The
> > +      delay line is not tunable, so no other phase can be selected.
> > +    enum: [0, 2000]
> > +    default: 0
>=20
> [Severity: Medium]
> Does this delay definition conflict with the RGMII rules in
> ethernet-controller.yaml?
>=20
> The if/then above applies this 0/2000 ps enum to all four RGMII modes.
> That means the schema accepts phy-mode =3D "rgmii" together with
> tx-internal-delay-ps =3D <2000>. The informative section of
> ethernet-controller.yaml says:
>=20
>   # be used to indicate fine tuning performed by the MAC. The values
>   # expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
>   # of 'rgmii' will not be accepted by Reviewers.
>=20
> That section also says delays not added by the PCB are software
> configuration and are not described in DT. If the MAC adds the delay, it
> has to remove that delay from the phy-mode it passes to the PHY.
>=20
> The schema also accepts rgmii-id, rgmii-rxid or rgmii-txid with a 2000 ps
> MAC delay. In the driver added later in the series ("net: dsa: lan9645x:
> add basic dsa driver for LAN9645X"), nothing seems to remove that delay
> again. lan9645x_parse_mac_delay() in lan9645x_port.c sets the flag only
> from the DT property:
>=20
>         *out =3D val =3D=3D 2000;
>=20
> lan9645x_phylink_mac_config() in lan9645x_phylink.c then calls
> lan9645x_rgmii_dll_config() for any RGMII mode. That function enables the
> DLL delay whenever the flag is set:
>=20
>         if (phy_interface_mode_is_rgmii(state->interface))
>                 lan9645x_rgmii_dll_config(p);
>=20
> Meanwhile phylink passes the unmodified phy-mode to the PHY.
>=20
> Take port 7 or 8 with an external PHY, phy-mode =3D "rgmii-id" and
> tx-internal-delay-ps =3D <2000>. Both the MAC and the PHY would add 2 ns,
> for about 4 ns of skew. Wouldn't that give a non-working link, even
> though the DT passes dt_binding_check?
>=20
> The if also has no else branch. Non-RGMII ports (gmii, rmii, BASE-X,
> QSGMII) therefore accept any uint32 value for rx-internal-delay-ps and
> tx-internal-delay-ps.
>=20
> Could the MAC delay be derived from phy-mode instead of these properties,
> with the phy-mode passed to the PHY adjusted to match?

Dismissed, intended.

This is the binding model of sja1105 and microchip,lan937x.yaml, which
also limits the values to 0 and 2000 ps on RGMII ports. sja1105 and ksz
configure the MAC delay lines from rx/tx-internal-delay-ps and pass
phy-mode unmodified to the PHY in the same way.



>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip=
.com

