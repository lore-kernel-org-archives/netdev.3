Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9947A51C32F
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791906901; cv=none; b=hPMGliGcvE4Sugv+hhe0UK8MhQBUnVg09B5OAUsFBNUhy+JKYeJdjGc4IQqMJLTInYUf8YkzTg7CzTebi3CXNjK0OWcXHISWT10W/7GDYnTgAF9KQcXUCP2DigQWVs29tCgOjO7bvIo2HTvCnsIseT4niyqcBEkvumVGvjZN3qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791906901; c=relaxed/simple;
	bh=lut8vTqWVl1iB0MQpzFnIFD2Pi7lRKFsso529aPT9zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+8goXN1ByoMEk5xg1jhF2H+zDelh7KfKXoItzrWanF19irfuBC4OhZVHhlYnrQxg4IxEtTY7HKAluguvzU6yDaJWxlKIyZbok1hDalMyQyvMUP/iSXMtHIrNp9Mi9ex4xrIsYnOtGKG5b9iGmjnTYAvstAhD7y70VXOOVs5e+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKpDwFAW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKpDwFAW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2BCC1F000FF;
	Tue, 13 Oct 2026 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906899;
	bh=8zZdCXAs4vHgfimJ4DiiEZocPEzfktIkrYiZQKBBqwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKpDwFAWOmCROzn++7CKt/o/UkYuRWyRKPZFbTQyKiNtZ/Myz26H3w7gll7alRqq5
	 DB4y+98NoOS5/z61QN8smRUxWjp4JnBwN62xnZD/N2mDhUzvEAjYssQhYfbZi9ykcR
	 5X+qFa8gZYm/xzWkBGJs16ImIjZMINShueT8rCAHqPZoPaAH/cnHEYav982GezyOkE
	 x4o/7u2VcJV1yVhZMFBrP9gt6/4HfaynvrqnKN7ZQNsWWe6PMhNT2drSZJk07oF7JF
	 kVAh6ddbdzHQ4ZGXlNrkQ3Fm1Ri4FX41UR6xpmxwV3zuaLVhpY/tQOMuiGyRfl4PrF
	 M6xqHbYjIpoTw==
Date: Tue, 13 Oct 2026 17:54:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: =?utf-8?B?6ZmI6ICA5piO?= <cc201008@gmail.com>
Cc: netdev@vger.kernel.org, horms@kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: airoha: Keep UPDMEM egress MAC in sync for
 offloaded IPv6 flows
Message-ID: <as5UUQuCjLTXvQ5Q@lore-desk>
References: <CAPZ+gd9d1P+xDSrxxZkGJr32zjubP=KfQegeGkWykKGvEH0=oA@mail.gmail.com>
 <CAPZ+gd8TPNnvEDOv_H=fdvy2ysG63uBD0MvmEMjhkMa8i-y1NA@mail.gmail.com>
 <as0DO7n5SCr2j3Z2@lore-desk>
 <CAPZ+gd_1JsNyhQbEAWiE1stom+T_jgvt4F2=tb68YoSvPCnFag@mail.gmail.com>
 <as3faB96PFSnC-qP@lore-desk>
 <CAPZ+gd_S4zMffbFTUbV989XxYtgxuJ3ijEBObehAXP_N20Akww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fip1EEA1bp5qMo/a"
Content-Disposition: inline
In-Reply-To: <CAPZ+gd_S4zMffbFTUbV989XxYtgxuJ3ijEBObehAXP_N20Akww@mail.gmail.com>

--Fip1EEA1bp5qMo/a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The issue is reproducible in the upstream codebase, without any of the
> out-of-tree PON code -- the PON setup is just where I first hit it.
>=20
> Reproduction with mainline code only (airoha eth + the mt7530 MMIO DSA
> driver; the "airoha,en7581-switch" binding and driver are mainline,
> the DT node just needs to be added to a board file):
>=20
> - AN7581 board, switch node with its CPU port on GDM1. Use a DSA user
>   port as a routed WAN interface with its own MAC address.
>=20
> airoha_get_dsa_port() replaces the egress netdev with the conduit, so
> routed IPv6 FOE entries carry smac_id =3D conduit port id, and the PPE
> resolves the egress source MAC through UPDMEM[conduit]. That slot is
> only programmed by airoha_set_macaddr(), which never runs when a DSA
> slave address changes, so offloaded IPv6 frames leave the port with
> the conduit's MAC instead of the user port's. IPv4 is unaffected,
> since HNAPT entries store the MACs inline. The same shape appears on a
> GDM port with two "airoha,eth-port" children carrying different MAC
> LSBs, which the recent multi-SerDES series allows by design
> (REG_FE_MAC_LMIN/LMAX); for that variant the exposure starts with the
> series introducing multiple net_devices per GDM port.
>=20
> The posted patch only reprograms the shared per-port slot at offload
> time, so a later address change on any netdev of that port re-breaks
> offloaded IPv6 flows. It is a temporary patch for this setup; the
> final solution is up to the maintainers.

I do not think the case you described is fixed with your patch. Let's consi=
der
the following case:

- time t0: you offload a flow rule for traffic egressing dsa port0
- time t1: you offload a flow rule for traffic egressing dsa port1

Since the index written in REG_UPDMEM_CTRL() subfield is still the conduit =
port
ID, you are egressing traffic from port0 with L2 address of port1. Am I rig=
ht,
or am I missing something?
Moreover, is it a bug if we use the conduit port L2 address as source mac
address for IPv6 traffic?

Regards,
Lorenzo

>=20
> A proper fix would probably give each netdev its own UPDMEM entry: the
> table is indexed by a 4-bit address (16 entries) while the FOE
> smac_id field is 5-bit with 0xf reserved for "keep original MAC", so
> there is room beyond the port ids. Slots could be programmed from
> airoha_set_macaddr() (always under RTNL, as you noted) plus a
> netdevice notifier for DSA slaves, and foe_entry_prepare() would only
> reference the slot -- removing both the race and the extra locking the
> current approach needs.
>=20
> Lorenzo Bianconi <lorenzo@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=BA=8C 15:36=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Ooo,  the new patch should be a dedicated leaf lock inside
> > > airoha_ppe_init_upd_mem().
> > > --- a/drivers/net/ethernet/airoha/airoha_ppe.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_ppe.c
> > > @@ -416,6 +416,19 @@
> > >    dsa_port);
> > >
> > >   smac_id =3D port->id;
> > > + /*
> > > + * Routed IPv6 entries resolve the egress source MAC
> > > + * through the UPDMEM table indexed by smac_id. The
> > > + * egress netdev can legally carry a different address
> > > + * than the GDM port itself: on PON setups the
> > > + * authentication MAC lives on the pon device while
> > > + * each service VLAN routes with its own address. Keep
> > > + * the table entry in sync with the source address this
> > > + * flow is actually going to use.
> >
> > Is the issue occurring just with PON or are you able to trigger the iss=
ue
> even
> > in the upstream codebase? I guess you should not post a fix for some co=
de
> that
> > is not upstream yet. Moreover, in the PON setup, I guess the approach is
> still
> > broken if the user change the device mac address.
> >
> > > + */
> > > + if (type >=3D PPE_PKT_TYPE_IPV6_ROUTE_3T)
> > > + airoha_ppe_init_upd_mem(dev,
> > > + data->eth.h_source);
> > >   }
> > >   }
> > >
> > > @@ -1529,10 +1542,21 @@
> > >
> > >  void airoha_ppe_init_upd_mem(struct airoha_gdm_dev *dev, const u8
> *addr)
> > >  {
> > > + static DEFINE_MUTEX(updmem_lock);
> > > +
> > >   struct airoha_gdm_port *port =3D dev->port;
> > >   struct airoha_eth *eth =3D dev->eth;
> > >   u32 val;
> > >
> > > + /*
> > > + * Routed IPv6 entries resolve the egress source MAC through the
> > > + * UPDMEM table indexed by smac_id; the ndo_open/ndo_set_mac_address
> > > + * writers hold flow_offload_mutex (QoS paths re-lock via
> > > + * airoha_set_macaddr()), so this lock also serializes the leaf
> > > + * against them.
> > > + */
> > > + mutex_lock(&updmem_lock);
> >
> > This is only required adding the above configuration since in the curre=
nt
> > codebase airoha_ppe_init_upd_mem() is always running holding RTNL.
> >
> > Regards,
> > Lorenzo
> >
> > > +
> > >   val =3D (addr[2] << 24) | (addr[3] << 16) | (addr[4] << 8) | addr[5=
];
> > >   airoha_fe_wr(eth, REG_UPDMEM_DATA(0), val);
> > >   airoha_fe_wr(eth, REG_UPDMEM_CTRL(0),
> > > @@ -1545,6 +1569,8 @@
> > >       FIELD_PREP(PPE_UPDMEM_ADDR_MASK, port->id) |
> > >       FIELD_PREP(PPE_UPDMEM_OFFSET_MASK, 1) |
> > >       PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
> > > +
> > > + mutex_unlock(&updmem_lock);
> > >  }
> > >
> > >  struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)

--Fip1EEA1bp5qMo/a
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCas5UUQAKCRA6cBh0uS2t
rAYFAQDficBv9jdbtC8Mk7r3GKyBesME3qEugohD1wSnjlTI1gEA5NcCKczi6hN8
qgNmVTJhPzicY32zfoQMQcLSHOOkXgc=
=FdXQ
-----END PGP SIGNATURE-----

--Fip1EEA1bp5qMo/a--
