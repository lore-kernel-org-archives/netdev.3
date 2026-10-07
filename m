Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78B4854EB;
	Wed,  7 Oct 2026 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383659; cv=none; b=FuNU/W43Pzh7XjsIsps+3JfbSC1Gzx5+upj6BfXEwXoqZtSMVm7dXo2T6648sWlAwR151DaFRLfsjS6dkDpxMiH5MgohDvkU64PiowIvXefgbpofFRH45vE4uKXyWgZ1zby/M7PRWMJ4yvyUeicTUMXyL0RdSVat481v2QYy/iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383659; c=relaxed/simple;
	bh=d/Kl65sXPl3XG58MSRvKyvhLdGwm1MEO15ONeq3TPBU=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpnCMvAxn92hmXrz4ApTz+Kd1r4iiC6M5LoChQzITHZTIBkFMNt9uaLB7eM7y93z4daeoFSXXEPQZnhGDZ6566xS67SHZsgbM/xLqtkyars9a4sBVVS8SXNRR8lJD0mTUWPPg0WiG1QsQOpr0LQnVBHV92+D2sxYLrzJPh8W3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z0sUZh9K; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z0sUZh9K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791383660; x=1822919660;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=d/Kl65sXPl3XG58MSRvKyvhLdGwm1MEO15ONeq3TPBU=;
  b=Z0sUZh9KN3Jqr2bd9TmF68XLkiofqln/B9rwB6eFSdPYw0KaVfX957CX
   PlCy+F9ix8pKtjMonl/Op/6agqrmIaeFuBGr7wVQeJOckPuh473hvud7q
   2yogA9OEnYLsmkjylvvD68Z+WmlAhDbZwzjSk1iNPkf/MkZOhR0rUHTK9
   0pxPltfqmdie2TIOqu5ljABDeabUy+GAf0MZ0rgrNGbM/L6qPps3HW4r7
   wxFc8NGAvSOM4wyazqfFLVT3OXHZAtQciBruJ6tYSTp9JQH/rfc7o/gou
   9UF4/7+DYRfSkRUx0IKphJleuo+WDj201Fg5BbPMtP2QtgDYxlGAoIvS2
   w==;
X-CSE-ConnectionGUID: w3g1qPF4THS/flpQzowRVg==
X-CSE-MsgGUID: bzbRljVgTHm/71K7UOdV1g==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="231796935"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Oct 2026 07:34:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 7 Oct 2026 07:34:13 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 7 Oct 2026 07:34:09 -0700
Message-ID: <02cce6979c4902e75f2f9b94621f2f81e82b879a.camel@microchip.com>
Subject: Re: [PATCH net-next v13 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <woojung.huh@microchip.com>,
	<linux@armlinux.org.uk>, <Steen.Hegelund@microchip.com>,
	<daniel.machon@microchip.com>, <geert+renesas@glider.be>,
	<magnus.damm@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
Date: Wed, 7 Oct 2026 16:34:09 +0200
In-Reply-To: <179097565632.434549.4502209637975152299@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-2-827c2d3617f2@microchip.com>
	 <179097565632.434549.4502209637975152299@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-10-02 at 21:14 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] The binding makes rx/tx-internal-delay-ps on the MAC-side
>   switch port nodes an on/off switch for the full 2 ns RGMII delay=E2=80=
=A6
> - [Low] The per-port pattern "^(ethernet-)?port@[0-8]$" in
>   properties/ethernet-ports does not actually limit ports to the 9=E2=80=
=A6
> - [Low] The subject "dt-bindings: net: lan9645x: add LAN9645X switch
>   bindings" does not follow=E2=80=A6
>=20
> --
>=20
> dt-bindings: net: lan9645x: add LAN9645X switch bindings
>=20
> This commit adds a DT binding for the Microchip LAN9645x DSA switch. The
> smallest SKU, microchip,lan96455s-switch, is the fallback compatible. The
> switch register targets are described through reg and reg-names, followin=
g
> mscc,vsc7514-switch.yaml.
>=20
> > dt-bindings: net: lan9645x: add LAN9645X switch bindings
>=20
> [Severity: Low]
> This isn't a bug, but the subject doesn't match what
> Documentation/devicetree/bindings/submitting-patches.rst asks for. That f=
ile
> says "Repeating "binding" again should also be avoided". Its example form=
 is
> "dt-bindings: iio: adc: Add ROHM BD79100G".
>=20
> The file lives under net/dsa/, so the usual prefix is "dt-bindings: net: =
dsa:".
> Something like "dt-bindings: net: dsa: Add Microchip LAN9645x switch" wou=
ld
> fit better.
>=20

I will retitle.

> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
55s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96=
455s-switch.yaml
> > new file mode 100644
> > index 0000000000000..9deb7a427804f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-swi=
tch.yaml
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
> Does this pattern actually restrict port nodes to the 9 hardware ports
> (dev0..dev8)?
>=20
> ethernet-ports has additionalProperties: true, so nodes that don't match
> "^(ethernet-)?port@[0-8]$" are not rejected here. The inherited
> dsa.yaml#/$defs/ethernet-ports and ethernet-switch.yaml both accept any
> "^(ethernet-)?port@[0-9a-f]+$" node through dsa-port.yaml.
>=20
> So a node like ethernet-port@9 { reg =3D <9>; ... } or ethernet-port@a pa=
sses
> dt_binding_check and dtbs_check. It also skips the local RGMII delay
> constraints. The problem only shows up at probe time:
>=20
> net/dsa/dsa.c:dsa_switch_parse_ports_of() {
>     ...
>                 if (reg >=3D ds->num_ports) {
>                         dev_err(ds->dev, "port %pOF index %u exceeds num_=
ports (%u)\n",
>                                 port, reg, ds->num_ports);
>     ...
> }
>=20
> Should the schema reject port nodes outside 0-8?
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
> Is it intended that rx/tx-internal-delay-ps on the MAC side port nodes tu=
rns
> the full 2 ns RGMII delay on and off, for all four rgmii phy-modes?
>=20
> Documentation/devicetree/bindings/net/ethernet-controller.yaml says these
> MAC node properties "should be used to indicate fine tuning performed by =
the
> MAC. The values expected here are small. A value of 2000ps, i.e 2ns, and =
a
> phy-mode of 'rgmii' will not be accepted by Reviewers."
>=20
> The same document says that when the MAC adds the delay, it "must modify =
the
> phy-mode it passes to the PHY, removing the delay it has added. Failure t=
o
> remove the delay will result in a non-functioning link."
>=20
> This schema accepts phy-mode =3D "rgmii-id" together with
> rx-internal-delay-ps =3D <2000>. In the driver later in this series,
> lan9645x_parse_mac_delay() in lan9645x_port.c only checks for 0 or 2000.
> lan9645x_rgmii_dll_config() in lan9645x_phylink.c then enables the delay =
line
> directly from the parsed value:
>=20
> drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c:lan9645x_rgmii_dll_=
config() {
>     ...
>         HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
>         HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),
>     ...
> }
>=20
> Nothing there checks phy-mode or removes the delay from the interface tha=
t
> phylink passes to the PHY.
>=20
> Take port 7 or 8 with a phy-handle, phy-mode "rgmii-id" and
> rx-internal-delay-ps =3D <2000>. Wouldn't the MAC and the PHY each add 2 =
ns,
> leaving a DT that passes validation with a link that doesn't work?
>=20
> The example also uses phy-mode =3D "rgmii" on the CPU port. For any RGMII=
 mode
> other than 'rgmii-id', ethernet-controller.yaml says it "is probably wron=
g"
> unless justified.
>=20

Dismissed. This follows the binding model introduced for sja1105 in
commit ac41ac81e331 ("dt-bindings: net: dsa: sja1105: add
{rx,tx}-internal-delay-ps") and used by microchip,lan937x.yaml since
commit 8926d94e5c50, which also restricts the values to 0 and 2000 ps.
The MAC delay lines are configured only from rx/tx-internal-delay-ps,
independently of phy-mode and of whether the port uses a PHY or a
fixed-link, and phy-mode is passed unmodified to the PHY. The hardware
has a fixed 2 ns delay line, 0 and 2000 are the only values it can
express. For the CPU port, phy-mode "rgmii" with a fixed-link matches
the sja1105 and lan937x examples.

> > +
> > +examples:
>=20
> [ ... ]
>=20
> > +            ethernet-port@7 {
> > +                reg =3D <7>;
> > +                ethernet =3D <&cpu_host_port>;
> > +                phy-mode =3D "rgmii";
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com

