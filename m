Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0956B2EEE75;
	Wed, 14 Oct 2026 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974922; cv=none; b=R8WZdviAYcef5Q8103zh9jhF4cUkgt9nJ69HjdA+9vBaCbpmBzrENrPV5twa18We16C1s11DR+1pCJ4VczLJryvYRjnO7drhTWZ2wZPVKDUschIo0aWTd/LPtyyJOb0tTGNQc/6zejTbu+1oxjKL4viImJ32KGGDeXTaIS3azMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974922; c=relaxed/simple;
	bh=QdyQpu2hFChSNt4/Mjsr9hF+BuoJg4ba3p2evjP/Qeg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fkilf3ys2LibeVRVn0Ajs4cSwjJYVXkWGmoWrdIVJzbxoUlBj8VCO5OzV1i/uUCMSNwmLSrSzclC0KZmxqiJdakJljGGM0FGAflavbCbf7bdOJmKfGu9ut9u/2lhweB/e4VqVusTeDB1LmDrALZdBXu2ISpDYTI0ZR/sWEDHSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EUEh3wvS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EUEh3wvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791974919; x=1823510919;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=QdyQpu2hFChSNt4/Mjsr9hF+BuoJg4ba3p2evjP/Qeg=;
  b=EUEh3wvS0PTZ9u9759drxwZFbPOhPaAYYoRD5tcbiTEkdiPZLDVxZ34P
   yUDxYYGNQqC7TFixwmD8ei+/QtHB7hxshMk0LRzTXkm2WPpaSKonvgyR3
   bTx30ZI+SRr7ZfkhaYyQBUU/RxOFY4VYrBf3qiJTicczs8+SFy4taIbWo
   oB14iTQNq9E50H8Y1Dy+8YjSJXw020s4Qp2SwxD4ba5WuMWjMzGqQ17lc
   kwm0Y9kHVDeF9V1Yi5Z2r3VqvG8V1KH+g1eqXt8TcSHj3DoDrrRHCdgV9
   UIskFXV3L6g5ioo19NO2LcBno+lDn1f0fNwN+w61eFNg/+bmrQys7w8iy
   Q==;
X-CSE-ConnectionGUID: HFcwCrfnTUOmZMLW62kSbw==
X-CSE-MsgGUID: ZpwTliLTS2+LCr1mIXE1AQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="65300032"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:48:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 03:48:38 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 03:48:34 -0700
Message-ID: <01c0303b65b77a9b737d3346bf58feab8408231e.camel@microchip.com>
Subject: Re: [PATCH net-next v14 5/9] net: dsa: lan9645x: add vlan support
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
Date: Wed, 14 Oct 2026 12:48:33 +0200
In-Reply-To: <179180428266.434549.5526720693163836060@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-5-3d2a72661213@microchip.com>
	 <179180428266.434549.5526720693163836060@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-10-12 at 11:24 +0000, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] The commit message says "DSA does not pass
>   SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL to drivers, so an 802.1ad=E2=80=
=A6
> - [Low] Concern: the commit message promises VLAN support for VLAN-aware
>   and VLAN-unaware bridges, but at this commit no .port_bridge_join=E2=80=
=A6
> - [Low] Concern: runtime VLAN table writes ignore lan9645x_vlan_hw_wr()
>   failures.
>=20
> --
>=20
> net: dsa: lan9645x: add vlan support
>=20
> This patch adds VLAN support to the lan9645x DSA driver. HOST_PVID (4095)
> is the port VLAN for standalone ports and UNAWARE_PVID (0) is the port VL=
AN
> for VLAN-unaware bridge ports. The VLAN table and the per-port VLAN state
> are serialized with fwd_domain_lock.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index c7de3836e6967..6818b91f4bed2 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -296,6 +307,59 @@ static void lan9645x_port_phylink_get_caps(struct =
dsa_switch *ds, int port,
> >       lan9645x_phylink_get_caps(ds->priv, port, config);
> >  }
> >=20
> > +static int lan9645x_port_vlan_filtering(struct dsa_switch *ds, int por=
t,
> > +                                     bool enabled,
> > +                                     struct netlink_ext_ack *extack)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     /* DSA core does not call this for the CPU port */
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +     mutex_lock(&lan9645x->fwd_domain_lock);
> > +     p->vlan_aware =3D enabled;
> > +     lan9645x_vlan_port_apply(p);
> > +     mutex_unlock(&lan9645x->fwd_domain_lock);
> > +
> > +     return 0;
> > +}
>=20
> [Severity: Medium]
> The commit message says:
>=20
>   "Only bridge vlan_protocol 802.1Q is offloaded. DSA does not pass
>   SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL to drivers, so an 802.1ad bridge
>   cannot be refused, and the classifier does not honour it."
>=20
> Is "cannot be refused" accurate? dsa_port_vlan_filtering() in
> net/dsa/port.c passes the driver's error back to the bridge:
>=20
>     err =3D ds->ops->port_vlan_filtering(ds, dp->index, vlan_filtering,
>                                        extack);
>     if (err)
>         return err;
>=20
> Could lan9645x_port_vlan_filtering() call br_vlan_get_proto() on the
> port's bridge and refuse with an extack when the result is not
> ETH_P_8021Q?
>=20
> That would cover two cases: turning on vlan_filtering on an 802.1ad
> bridge, and joining an 802.1ad bridge that already filters, because the
> join path syncs vlan_filtering through the same callback. Only a
> vlan_protocol change on a bridge that is already filtering would still
> get through.
>=20
> As written, an 802.1ad VLAN-aware bridge is offloaded silently with
> 802.1Q semantics. lan9645x_vlan_port_apply_ingress() always marks
> untagged frames as C-tag:
>=20
>     val =3D ANA_VLAN_CFG_VLAN_VID_SET(pvid) |
>           ANA_VLAN_CFG_VLAN_TAG_TYPE_SET(0);
>=20
> With TAG_TPID_CFG=3D3, those frames would egress tagged with 0x8100, not
> 0x88a8. C-tagged frames would be classified by their C-VID, not by the
> pvid.
>=20
> The tagger already reads br_vlan_get_proto() in
> lan9645x_xmit_get_vlan_info() in net/dsa/tag_lan9645x.c:
>=20
>     *tag_type =3D (proto !=3D ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
>                                          LAN9645X_IFH_TAG_TYPE_C;
>=20
> So on such a bridge, would the CPU injection path and the switch
> datapath disagree? The later "net: dsa: lan9645x: add bridge support"
> patch also leaves lan9645x_port_vlan_filtering() unchanged.

Right, the next version refuses enabling VLAN filtering in
port_vlan_filtering() when the bridge vlan_protocol is not 802.1Q, which
also covers joining a VLAN-aware 802.1ad bridge. That leaves the
remaining case of a vlan_protocol change on a bridge that already
filters. This is not handled since DSA does not pass
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.

>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.h
> > index 3a4abedafa2c1..c61efd115aaa4 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
>=20
> [ ... ]
>=20
> > @@ -238,6 +255,11 @@ static inline struct lan9645x_port *lan9645x_to_po=
rt(struct lan9645x *lan9645x,
> >       return lan9645x->ports[port];
> >  }
> >=20
> > +static inline bool lan9645x_port_is_bridged(struct lan9645x_port *p)
> > +{
> > +     return p->lan9645x->bridge_mask & BIT(p->chip_port);
> > +}
>=20
> [Severity: Low]
> This isn't a bug, but at this commit nothing writes bridge_mask and there
> is no .port_bridge_join, so lan9645x_port_is_bridged() always returns
> false. The bridged branches in lan9645x_vlan_port_get_pvid() and
> lan9645x_vlan_port_apply_egress() can't be reached until the later "net:
> dsa: lan9645x: add bridge support" patch adds lan9645x_port_bridge_join()=
.
>=20
> Standalone ports look fine in the meantime. HOST_PVID contains all ports
> and the CPU, so enabling ANA_VLANMASK drops nothing.
>=20
> Could the commit message line "Add VLAN support for VLAN-aware and
> VLAN-unaware bridges." say that the bridged paths only become active
> with the bridge support patch?
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > new file mode 100644
> > index 0000000000000..751da53375368
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > @@ -0,0 +1,402 @@
>=20
> [ ... ]
>=20
> > +int lan9645x_vlan_port_add_vlan(struct lan9645x_port *p, u16 vid, bool=
 pvid,
> > +                             bool untagged, struct netlink_ext_ack *ex=
tack)
> > +{
>=20
> [ ... ]
>=20
> > +     if (p->chip_port =3D=3D lan9645x->npi)
> > +             return lan9645x_vlan_cpu_add(p, vid);
> > +
> > +     old_vlan =3D lan9645x->vlans[vid];
> > +     old_pvid =3D p->pvid;
> > +
> > +     v =3D lan9645x_vlan_port_modify(p, vid, pvid, untagged);
> > +     v->portmask |=3D BIT(p->chip_port);
>=20
> [ ... ]
>=20
> > +     lan9645x_vlan_hw_wr(lan9645x, vid);
> > +     lan9645x_vlan_port_apply_ingress(p);
> > +     lan9645x_vlan_port_apply_egress(p, &info);
> > +
> > +     return 0;
> > +}
>=20
> [Severity: Low]
> The return value of lan9645x_vlan_hw_wr() is dropped here. The same
> happens in lan9645x_vlan_cpu_add(), lan9645x_vlan_cpu_del(),
> lan9645x_vlan_port_del_vlan() and lan9645x_vlan_set_hostmode(). In each
> case vlans[vid] is updated and 0 is returned even if the table write
> timed out.
>=20
> The comment in lan9645x_vlan_hw_wr() says this is intentional: a timeout
> most likely means the register bus is dead. Also, the next write for the
> same VID rewrites the whole entry from the shadow portmask.
>=20
> If the parent regmap bus can have transient errors, though, would it be
> better to return the error and restore the old shadow state, as
> ocelot_vlan_member_add() does? That would keep DSA's refcounted CPU port
> VLAN state in sync with the hardware.
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip=
.com

