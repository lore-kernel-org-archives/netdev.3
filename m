Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671208;
	b=4iJUR0VbtEmfwzlIEP9IDE37QZzyppPiFgSxIStL1tRDnsZgHEtKz4Z/VoHBFCj4PQEX
	 nDBSd9ZUJCZFDz3xV3ZtLL6BX3Gi6JwqqjdzRqhDAQI/3vayAIf5QoBXiXrvb0V8mZb1A
	 ZIdUxhcR/4qOWEC3MGmO324lIio6uICJF41XvVz05+JmGx/IOoyY9N7xi6nIhuRGhDQVV
	 kMJzAQgBFiLC3ZcHSJTLQ9RnQFb+6Epvi0+bDZOO5JY1O8SjSfakGRo8zIQ2EY2cdPkzm
	 GiltUOZkgKiAB4Hrezvcs9WubunryHUAksIac+VdQSYgBmYvevKOSr/VXMs6sHtrnJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671208;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:
	 Subject:From:To:CC:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=p8tkTWKxS2RK1QGVi4JF6MyUFnMfEeLChxsR1pKa0t0=;
	b=q51ZAoVjA8yWRbyAcPqg4G6RdfGqdU0Ev0bkvidHqisdxxPNpPIzLkGYf5/3UUfAGbUm
	 OLPoxkI6spOG9Qu81u6vJkOcwuPFXWb3G9TPb3qs+fMFp5Kk0rAAcXWMx9AYLBgBKNYcM
	 tANU5nRth6HK9DUMu/ijhWCIiON2cVTtGYU32KtPdIn+A69ETaYzQbjvdRLsZEbMzrlzY
	 jHYL0tRs0xAvtcnbkWcnD3sAhKlK3gqJghCLht6GVF8jgDTtuvUcg33HZwzHNN+mTCMEm
	 yHWhv7GW2ixFDgLBQzY7vew0oujYjua5bDv0V7yrXzdUfrf+0n6kGffAvt8na4Dz3YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=nJsVagtu;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F3606A319;
	Thu, 22 Oct 2026 12:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 276F3606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=nJsVagtu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792671209; x=1824207209;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=0KOLRV7LUmpZS4Ne5rid+xQkJIt/g+fjpQYXKWaeXVU=;
  b=nJsVagtuGG6Pv26X/sjaoZd2UrvCvgK0fLm3dNZuWcFJ5zZ8QtecJ+LU
   ZX3+B2EvMfvsHcWK71nyAFJ6YIZSlOVhbV4QzVxCIHjxrH0eVLoqQqOSb
   hCMBCJPqwN8NW+3XuXuWhw5/rAWbxgMjMXvdPvWqUobt4PJP1ZIUspF+/
   aMzveQCMJ29RGMOHWeFyOJwoXk4fU+uwAn5aE0t8Pl3ze1YocM0MztR1h
   zpmPFRXcQWCkw+mj7JBlwDRPEfwTJEYDfPsWqY/7rhd0BeqmEYGDjI8w4
   R2WK8pqP+ozURZ7NPJzL8GNcGWccm2bRsrALalxpwmn7RKcDAJWtqzV0E
   g==;
X-CSE-ConnectionGUID: SXkN3gIQTY2w83qdO/SHCw==
X-CSE-MsgGUID: plvGyXUyTpCtbe9KgXwHug==
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="65678133"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 05:13:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Thu, 22 Oct 2026 05:13:19 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 22 Oct 2026 05:13:16 -0700
Message-ID: <e8cd03fbef3af3102126ac0c9be9c72bd0537d52.camel@microchip.com>
Subject: Re: [PATCH net-next v15 8/9] net: dsa: lan9645x: add bridge support
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
Date: Thu, 22 Oct 2026 14:13:15 +0200
In-Reply-To: <179240453125.3135.11938999224472029303@kernel.org>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-8-562f316f78b9@microchip.com>
	 <179240453125.3135.11938999224472029303@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] The 802.1Q-only restriction can be bypassed by changing the
>   bridge's vlan_protocol after the port has joined.
>=20
> --
>=20
> net: dsa: lan9645x: add bridge support
>=20
> This adds hardware offload of a single bridge to the lan9645x DSA
> driver. It covers ageing time, bridge port flags, STP state handling and
> host flooding. Joining a VLAN-aware bridge whose vlan_protocol is not
> 802.1Q is refused at join time.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index d2e8c52e2a178..c6371a7b9a52a 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > +static int lan9645x_port_bridge_join(struct dsa_switch *ds, int port,
> > +                                  struct dsa_bridge bridge,
> > +                                  bool *tx_fwd_offload,
> > +                                  struct netlink_ext_ack *extack)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     if (!lan9645x_bridge_vlan_proto_ok(bridge.dev)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Only 802.1Q VLAN-aware bridges are su=
pported");
> > +             return -EINVAL;
> > +     }
>=20
> [Severity: High]
> Can the 802.1Q-only restriction be bypassed by changing vlan_protocol
> after the port has joined?
>=20
> lan9645x_bridge_vlan_proto_ok() is only checked in two places. One is
> here, at join time. The other is lan9645x_port_vlan_filtering(). DSA
> only calls lan9645x_port_vlan_filtering() when the filtering state
> changes, because dsa_port_vlan_filtering() returns early when
> dsa_port_is_vlan_filtering(dp) already matches.
>=20
> A protocol change goes through __br_vlan_set_proto():
>=20
> net/bridge/br_vlan.c:__br_vlan_set_proto() {
>         struct switchdev_attr attr =3D {
>                 .orig_dev =3D br->dev,
>                 .id =3D SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL,
>                 .flags =3D SWITCHDEV_F_SKIP_EOPNOTSUPP,
>     ...
>         err =3D switchdev_port_attr_set(br->dev, &attr, extack);
>         if (err && err !=3D -EOPNOTSUPP)
>                 return err;
>     ...
>         br->vlan_proto =3D proto;
>     ...
> }
>=20
> Only mlxsw and mlx5 handle SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL. DSA
> has no case for it and returns -EOPNOTSUPP. The bridge then commits the
> new protocol, and lan9645x never sees the change.
>=20
> br_changelink() also handles IFLA_BR_VLAN_FILTERING before
> IFLA_BR_VLAN_PROTOCOL. So both of these sequences look like they end up
> with an offloaded VLAN-aware 802.1ad bridge:
>=20
>   ip link set br0 type bridge vlan_filtering 1 vlan_protocol 802.1ad
>=20
>   ip link set br0 type bridge vlan_protocol 802.1ad
>   (on a bridge that already has vlan_filtering 1)
>=20
> In the first case, lan9645x_port_vlan_filtering() runs while
> br->vlan_proto is still 802.1Q, so the check passes.
>=20
> The hardware then keeps its 802.1Q setup in ANA_VLAN_CFG: VLAN aware,
> C-tag type, pop count 1. Would it then classify customer 0x8100-tagged
> frames by the C-VID the sender chose, and forward them in hardware to
> members of that VID?
>=20
> Under 802.1ad, the software bridge treats that tag as payload and puts
> the frame in the port PVID (the S-VLAN). If the hardware classifies by
> the C-VID instead, S-VLAN isolation breaks for traffic arriving from
> the wire.
>=20
> The v15 changelog says VLAN-aware bridges whose vlan_protocol is not
> 802.1Q are refused. Does this need handling for protocol changes, rather
> than only the join-time check? Two options would be a veto from a
> switchdev or netdev notifier, or a DSA hook for
> SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.
>=20
> The later patch in the series, "net: dsa: lan9645x: add port
> statistics", only adds statistics and does not change this logic.
>=20

Dismissed.

As noted for v14, a vlan_protocol change on a bridge that already
filters does not reach the driver. DSA does not handle
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.

The driver already refuses what it is told about such as joining a
VLAN-aware bridge and enabling VLAN filtering while vlan_protocol is not
802.1Q. Refusing a protocol change needs DSA to pass the attribute to
drivers, which is independent of this series.


> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip=
.com

