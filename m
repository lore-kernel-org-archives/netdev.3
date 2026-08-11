Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6210B3B71B6;
	Tue, 11 Aug 2026 12:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450354; cv=none; b=CitaamXw5PWldBIMGbt/Og9Saqs+GQuwc2MY6aLds88rfJQfw8rBkBk6JQRGC04QK+vsaxksKwtDPTStW1MzaRPOEigEWAkS9rYLUSHQEtOCNxUWTyUxLAFGiA6J/nXNmFPRMcpn/eHiPhmjBnm2vKV0oXP+4wuRuyMaXnpyV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450354; c=relaxed/simple;
	bh=tyOQnh6HNq7BJRa5+a1xiS9D9TyMohyrBtAzdVrIKfc=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CyN+3XXOvcro2PKCBOoYmZ23ec9XCw1wwR3SrJKiezOhrNfhzqqXttSXnhtNAH6feW5iPu9SENhLSLes2ETQQe5/mmfyDXFW3hL0kQlwLLH3bMm532OiXuG/ZiphGgNz2VBTOl43Ewn05YRB8hrPgDoCHC/S1W8J1P/DH29Nyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n/1ylvhJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n/1ylvhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786450352; x=1817986352;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=tyOQnh6HNq7BJRa5+a1xiS9D9TyMohyrBtAzdVrIKfc=;
  b=n/1ylvhJz3j15BE7GIzfshc1UiMQV/zoFvLrRzQHZrcQvdq3uQ5QNqlf
   53jAekedQ11KoUvxo2opOIIIV9qpVNXwrb5cW3WG88m2czlE0/0Ebwqw3
   HlXxm+PyqG7ew21iSicZwZMRGP6B1ogEOd2ve1eQnHAxflDHZUU+O0uhI
   vwbYWJ6XvX/1/X03jrfjShzFgU4PniM/gLkKHbiHJSfDH0/tCTLgmr/ka
   q4Gq4TlujeMzoh8Hf3jxXULK7/+11wLSDnNVrCq6JUHArkVmYGRM0Aunp
   asM4wJOG22mNs/nicmD789+27soAnXu8viBzyPuT02bK+4lBz1sM00gC2
   w==;
X-CSE-ConnectionGUID: P/BqmPhsRHGdwtOClGaXKw==
X-CSE-MsgGUID: 5Rh+N3caSmKsmTt1kxtdLg==
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="61069239"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2026 05:12:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 11 Aug 2026 05:12:25 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 11 Aug 2026 05:12:22 -0700
Message-ID: <836f11544ec1a6c1b86d8264ca706078d5457726.camel@microchip.com>
Subject: Re: [PATCH net-next v11 6/9] net: dsa: lan9645x: add vlan support
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<horms@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Tue, 11 Aug 2026 14:12:21 +0200
In-Reply-To: <20260811103306.150761-1-pabeni@redhat.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-6-007ebc983a0a@microchip.com>
	 <20260811103306.150761-1-pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 12:32 +0200, Paolo Abeni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> --- Patch [6]: [PATCH net-next v11 6/9] net: dsa: lan9645x: add vlan supp=
ort ---
> commit 48ea20348797be1134c296e1f56d305fbc50bbe3
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>=20
> net: dsa: lan9645x: add vlan support
>=20
> This adds a new lan9645x_vlan.c implementing port_vlan_filtering,
> port_vlan_add and port_vlan_del, backed by a software shadow of the
> hardware VLAN table in lan9645x->vlans[]. VID 4095 is reserved as the
> port VLAN of standalone ports and VID 0 is used for VLAN-unaware bridge
> ports.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index c145d28ffbb99..3281726284dc2 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -521,6 +524,7 @@ static int lan9645x_port_bridge_join(struct dsa_swi=
tch *ds, int port,
> >=20
> >       lan9645x->bridge_mask |=3D BIT(p->chip_port);
> >       __lan9645x_port_set_host_flood(lan9645x);
> > +     lan9645x_vlan_clear_hostmode(p);
> >=20
> >       mutex_unlock(&lan9645x->fwd_domain_lock);
> >=20
>=20
> [ ... ]
>=20
> > @@ -576,11 +580,52 @@ static void lan9645x_port_bridge_leave(struct dsa=
_switch *ds, int port,
> > +static int lan9645x_port_vlan_add(struct dsa_switch *ds, int port,
> > +                               const struct switchdev_obj_port_vlan *v=
lan,
> > +                               struct netlink_ext_ack *extack)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +     bool pvid, untagged;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +     pvid =3D !!(vlan->flags & BRIDGE_VLAN_INFO_PVID);
> > +     untagged =3D !!(vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED);
> > +
> > +     return lan9645x_vlan_port_add_vlan(p, vlan->vid, pvid, untagged,
> > +                                        extack);
> > +}
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.h
> > index a0cd1707e1149..248c4ab59f1a8 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
>=20
> [ ... ]
>=20
> > @@ -156,6 +157,17 @@ enum lan9645x_vlan_port_tag {
> >       LAN9645X_TAG_ALL =3D 3,
> >  };
> >=20
> > +struct lan9645x_vlan {
> > +     u32 portmask: 10, /* ports 0-8 + CPU port module */
> > +         untagged: 9, /* ports 0-8 */
> > +         src_chk: 1,
> > +         mir: 1,
> > +         lrn_dis: 1,
> > +         prv_vlan: 1,
> > +         fld_dis: 1,
> > +         s_fwd_ena: 1;
> > +};
> > +
>=20
> [ ... ]
>=20
> > @@ -180,6 +192,9 @@ struct lan9645x {
> >       u16 bridge_fwd_mask; /* Mask for forwarding bridged ports */
> >       struct mutex fwd_domain_lock; /* lock forwarding configuration */
> >=20
> > +     /* VLAN entries */
> > +     struct lan9645x_vlan vlans[VLAN_N_VID];
> > +
> >       int num_port_dis;
> >  };
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_port.c
> > index 0642b59419c25..0548904dc4bd2 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_port.c
> > @@ -210,5 +210,8 @@ int lan9645x_port_setup(struct dsa_switch *ds, int =
port)
> >               ANA_PORT_CFG_PORTID_VAL,
> >               lan9645x, ANA_PORT_CFG(p->chip_port));
> >=20
> > +     if (p->chip_port !=3D lan9645x->npi)
> > +             lan9645x_vlan_set_hostmode(p);
> > +
> >       return 0;
> >  }
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_vlan.c
> > new file mode 100644
> > index 0000000000000..e2116132b4d48
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c
>=20
> [ ... ]
>=20
> > +static int lan9645x_vlan_hw_wr(struct lan9645x *lan9645x, u16 vid)
> > +{
> > +     struct lan9645x_vlan *v =3D &lan9645x->vlans[vid];
> > +     bool cpu_dis =3D !(v->portmask & BIT(lan9645x->num_phys_ports));
> > +     u32 val;
> > +     int err;
> > +
> > +     val =3D ANA_VLANTIDX_VLAN_PGID_CPU_DIS_SET(cpu_dis) |
> > +           ANA_VLANTIDX_V_INDEX_SET(vid) |
> > +           ANA_VLANTIDX_VLAN_SEC_FWD_ENA_SET(v->s_fwd_ena) |
> > +           ANA_VLANTIDX_VLAN_FLOOD_DIS_SET(v->fld_dis) |
> > +           ANA_VLANTIDX_VLAN_PRIV_VLAN_SET(v->prv_vlan) |
> > +           ANA_VLANTIDX_VLAN_LEARN_DISABLED_SET(v->lrn_dis) |
> > +           ANA_VLANTIDX_VLAN_MIRROR_SET(v->mir) |
> > +           ANA_VLANTIDX_VLAN_SRC_CHK_SET(v->src_chk);
> > +
> > +     lan_wr(val, lan9645x, ANA_VLANTIDX);
> > +     lan_wr(ANA_VLAN_PORT_MASK_VLAN_PORT_MASK_SET(v->portmask),
> > +            lan9645x, ANA_VLAN_PORT_MASK);
> > +     lan_wr(ANA_VLANACCESS_VLAN_TBL_CMD_SET(VLANACCESS_CMD_WRITE),
> > +            lan9645x, ANA_VLANACCESS);
>=20
> [Severity: High]
> [Finding: main-5-5]
> [Sources: opus-5]
> Should this three-register indirect transaction be serialized by a lock?
>=20
> The MAC table engine in this driver is protected by mact_lock:
>=20
>         struct mutex mact_lock; /* serialize mac table register access */
>=20
> but the VLAN table access engine has no equivalent, and there is no
> lockdep_assert_held() here.
>=20
> lan9645x_vlan_set_hostmode() is now called from .port_setup:
>=20
> lan9645x_port_setup()
>     if (p->chip_port !=3D lan9645x->npi)
>         lan9645x_vlan_set_hostmode(p)
>             lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID)
>=20
> and .port_setup runs from the DSA probe path without rtnl_lock and
> without fwd_domain_lock:
>=20
> net/dsa/devlink.c:dsa_port_devlink_setup() {
>         if (ds->ops->port_setup) {
>                 err =3D ds->ops->port_setup(ds, dp->index);
>         ...
> }
>=20
> dsa_port_devlink_setup() runs at the start of dsa_port_setup(), before
> dsa_user_create() registers this port's netdev, while the netdevs of the
> ports already processed are live. So while swp1..swpN are still going
> through lan9645x_port_setup(), userspace can enslave swp0:
>=20
> CPU0 (probe, no locks held)          CPU1 (rtnl, bridge join / vlan add)
> lan9645x_vlan_set_hostmode()         lan9645x_port_vlan_add()
>   lan9645x_vlan_hw_wr(.., 4095)        lan9645x_vlan_port_add_vlan()
>                                          lan9645x_vlan_hw_wr(.., 100)
>=20
> Can the two transactions interleave like this?
>=20
> CPU1: lan_wr(V_INDEX=3D100,   ANA_VLANTIDX)
> CPU0: lan_wr(V_INDEX=3D4095,  ANA_VLANTIDX)
> CPU0: lan_wr(mask(4095),    ANA_VLAN_PORT_MASK)
> CPU0: lan_wr(CMD_WRITE,     ANA_VLANACCESS)
> CPU1: lan_wr(mask(100),     ANA_VLAN_PORT_MASK)
> CPU1: lan_wr(CMD_WRITE,     ANA_VLANACCESS)
>=20
> That would commit mask(100) into the HOST_PVID (4095) entry and leave
> vid 100 without a member mask, i.e. either standalone ports lose their
> isolation domain or the new VLAN blackholes traffic.
>=20
> There is also the shadow update itself. lan9645x_vlan_set_hostmode() and
> lan9645x_vlan_clear_hostmode() both do a non-atomic read-modify-write of
> the same u32 bitfield word:
>=20
>         p->lan9645x->vlans[HOST_PVID].portmask |=3D BIT(p->chip_port);
>         ...
>         p->lan9645x->vlans[HOST_PVID].portmask &=3D ~BIT(p->chip_port);
>=20
> portmask:10 shares the word with untagged:9 and the flag bits, and
> lan9645x_port_bridge_join() calls lan9645x_vlan_clear_hostmode() under
> fwd_domain_lock while lan9645x_port_setup() calls
> lan9645x_vlan_set_hostmode() with no lock at all, so the lock sets do not
> intersect. Can one of these updates be lost?
>=20

Yes, this is right, I will move vlan modifications under the existing
fwd_domain_lock.

> > +
> > +     /* The VLAN access engine completes in a fixed ~1us vs the pollin=
g
> > +      * timeout of 100_000 us. A timeout here therefore likely means t=
he
> > +      * register bus itself is dead, not that the VLAN op failed. Ther=
e is no
> > +      * meaningful recovery at runtime, so this function logs via dev_=
err()
> > +      * and runtime callers discard the return value. Only
> > +      * lan9645x_vlan_init() treats this as fatal so that probe fails =
early
> > +      * on a broken bus.
> > +      */
> > +     err =3D lan9645x_vlan_wait_for_completion(lan9645x);
> > +     if (err)
> > +             dev_err(lan9645x->dev, "Vlan set mask failed\n");
> > +
> > +     return err;
> > +}
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
> > +     lan9645x_vlan_port_get_info(lan9645x, p->chip_port, &info);
> > +
> > +     if (info.untagged > 1 && info.tagged) {
> > +             *v =3D old_vlan;
> > +             p->pvid =3D old_pvid;
> > +             NL_SET_ERR_MSG_MOD(extack, "Only support 1 untagged port =
VLAN");
> > +             return -EBUSY;
> > +     }
>=20
> [Severity: Low]
> [Finding: main-1-1]
> [Sources: opus-5]
> This isn't a bug, but could the commit message mention this restriction?
>=20
> The commit message says only "Add VLAN support for VLAN-aware and
> VLAN-unaware bridges", while this rejects an otherwise legal bridge
> configuration: a second
>=20
>         bridge vlan add dev swpN vid B untagged
>=20
> fails with -EBUSY once the port already has one untagged VLAN plus at
> least one tagged VLAN.
>=20
> The changelog also notes an expected selftest failure with respect to
> ctag/stag conformance, but that text is below the --- line and is dropped
> when the patch is applied, so nothing about either limitation survives in
> the tree.
>=20

I can mention these restrictions in the commit message, that is a good idea=
.
Both are hardware limitations.

The stag/ctag limitation is that the switch considers both stagged and
ctagged frames as tagged, and the conformance requires you accept 1 as
tagged and the other as untagged.

I see ocelot has a workaround for this using the VCAP. We may be able
to do the same once the required features land, but not in this series.

> > +
> > +     lan9645x_vlan_hw_wr(lan9645x, vid);
> > +     lan9645x_vlan_port_apply_ingress(p);
> > +     lan9645x_vlan_port_apply_egress(p, &info);
> > +
> > +     return 0;
> > +}
>=20
> [ ... ]
>=20
> > +void lan9645x_vlan_set_hostmode(struct lan9645x_port *p)
> > +{
> > +     p->vlan_aware =3D false;
> > +     p->lan9645x->vlans[HOST_PVID].portmask |=3D BIT(p->chip_port);
> > +     lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
> > +     lan9645x_vlan_port_apply(p);
> > +}
> > +
> > +void lan9645x_vlan_clear_hostmode(struct lan9645x_port *p)
> > +{
> > +     p->lan9645x->vlans[HOST_PVID].portmask &=3D ~BIT(p->chip_port);
> > +     lan9645x_vlan_hw_wr(p->lan9645x, HOST_PVID);
> > +     lan9645x_vlan_port_apply(p);
> > +}
>=20
> [ ... ]
> --
> This is an AI-generated review.
>=20

Thanks,
Emil

