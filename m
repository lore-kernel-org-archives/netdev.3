Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5250AC01;
	Wed, 14 Oct 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791976045; cv=none; b=PH7lHb799Mkhl1LObDWas/pPwkl7eD1r2dcAP0k9diia/CBiMUQ2fnWOdZitzLl9Gp/Ty4XMES2j2xRImw74JOISAoU4oBHngZ33+a6b9TD6CyIrwIQdFxCiN1nGew+0F/L8CpPeod3iV5rIzyXKGVyro9OpknS9z5awkMxerj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791976045; c=relaxed/simple;
	bh=iZuNnxKYfUPpm3dF1ygmNQWK06A5BrjtcauadsU0aq0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BiJBvg7n0WqJLVsbZS0t6MSPo+QveLvGXubRdSL3fCexfpJSCdlid2u6SB2pxlXVKhYMTukFy5Z3o5vHE4eO8iYRXtIoZNJknsyASDO7As99x4ikO9irpaozPxC82i294hbGE43hixepwVlF+/yR93RHENRip0qTnR1+gV8tNa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WFllHXuh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WFllHXuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791976041; x=1823512041;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iZuNnxKYfUPpm3dF1ygmNQWK06A5BrjtcauadsU0aq0=;
  b=WFllHXuhsE9KxTYvWADl5fMLKUbA/s9qNouyVaW1JM+RfXIAtgNc3yjj
   7n+lzUoOUNEEnvBLik/UnLd5I9l+VEQia6WoL02urPVQPHuCz8YfmxqIf
   96WSMe29FGG6gjCZMs6ffbZDa9BkVsUF3M45sAkoWRkfFtY1ugVD2u98K
   V74QBf8wKL2S805a6NNDXvEO++wZM6QIrAqS4L127xeDjOZ0wE75nc45X
   OnWhxBNP817Jb2Zj2dXlGLNjF4VdD/OvTx2ue3RoTo651XWBU9c7DDPpa
   n057aUk13Xs1ZLVbt4ZBlxmphXOqtsaZg1dIZ/lTjFAFLqLihDDx1p+vI
   g==;
X-CSE-ConnectionGUID: xA2knUu+SZaBDexVjyN9bg==
X-CSE-MsgGUID: BNJVAJHXTxmWqCF9XWfbhw==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="296438657"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 04:07:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 04:07:19 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 04:07:15 -0700
Message-ID: <2a27aeaf3332aabb34418067df1c29f90a4db2b0.camel@microchip.com>
Subject: Re: [PATCH net-next v14 8/9] net: dsa: lan9645x: add bridge support
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
Date: Wed, 14 Oct 2026 13:07:14 +0200
In-Reply-To: <179180428624.434549.14425623884223795761@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-8-3d2a72661213@microchip.com>
	 <179180428624.434549.14425623884223795761@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (1) =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] When the general-purpose PGIDs run out, L2 multicast groups
>   fall back to PGID_MC.
> - [Medium] Setting ds->ageing_time_min/max makes a bridge join fail late,
>   and the failed join leaves DSA's dp->vlan_filtering out of step with=E2=
=80=A6
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the new
>   lan9645x_set_ageing_time() is affected by it.
>=20
> --
>=20
> net: dsa: lan9645x: add bridge support
>=20
> This adds hardware bridge offload to the lan9645x DSA driver for a single
> bridge. It adds ageing time configuration with min/max limits enforced by
> the DSA core, plus bridge port flags and STP state handling. Host floodin=
g
> is done by adding the CPU port module to the global flood masks.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index a0f48f3ad9aff..cefe643fce182 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -306,6 +302,19 @@ static int lan9645x_setup(struct dsa_switch *ds)
> >       ds->fdb_isolation =3D true;
> >       ds->max_num_bridges =3D 1;
> >=20
> > +     /* ANA_AUTOAGE_AGE_PERIOD is a seconds-based field and entries ar=
e
> > +      * aged after 2 * AGE_PERIOD, giving (2 * FIELD_MAX) seconds of
> > +      * maximum aging and 2 seconds of minimum aging.
> > +      *
> > +      * An AGE_PERIOD of 0 stops the analyzer from aging at all, which=
 is
> > +      * the opposite of what a bridge ageing_time of 0 asks for. The b=
ridge
> > +      * expires every dynamic entry immediately in that case and flood=
s, so
> > +      * reject it rather than keep learned addresses forever.
> > +      */
> > +     ds->ageing_time_min =3D 2U * MSEC_PER_SEC;
> > +     ds->ageing_time_max =3D 2U * MSEC_PER_SEC *
> > +                           FIELD_MAX(ANA_AUTOAGE_AGE_PERIOD);
>=20
> [Severity: Medium]
> Can a bridge join that fails on these limits leave the port VLAN-unaware
> in hardware after the next successful join?
>=20
> With ageing_time_min set, dsa_switch_ageing_time() returns -ERANGE for an=
y
> bridge ageing_time below 2s, including 0. For example:
>=20
>   ip link add br0 type bridge vlan_filtering 1 ageing_time 0
>=20
> dsa_port_switchdev_sync_attrs() applies the ageing time last. By then,
> dsa_port_vlan_filtering(dp, br_vlan_enabled(br)) has already called
> lan9645x_port_vlan_filtering(true) and set dp->vlan_filtering =3D true.
>=20
> The rollback in dsa_port_bridge_join() then does:
>=20
> net/dsa/port.c:dsa_port_bridge_join() {
>     ...
> out_rollback_unoffload:
>         switchdev_bridge_port_unoffload(...);
>         dsa_flush_workqueue();
> out_rollback_unbridge:
>         dsa_broadcast(DSA_NOTIFIER_BRIDGE_LEAVE, &info);
> out_rollback:
>         dsa_port_bridge_destroy(dp, br);
>     ...
> }
>=20
> This path never calls dsa_port_switchdev_unsync_attrs() or
> dsa_port_reset_vlan_filtering(), so dp->vlan_filtering stays true.
>=20
> Meanwhile the BRIDGE_LEAVE notifier reaches lan9645x_port_bridge_leave().
> That function calls lan9645x_vlan_set_hostmode(), which sets
> p->vlan_aware =3D false.
>=20
> Now suppose the ageing time is fixed and the port is added to a
> vlan_filtering=3D1 bridge again. dsa_port_vlan_filtering() returns early:
>=20
>         if (dsa_port_is_vlan_filtering(dp) =3D=3D vlan_filtering)
>                 return 0;
>=20
> So .port_vlan_filtering is never called. Neither
> lan9645x_port_bridge_join() nor lan9645x_vlan_clear_hostmode() restores
> p->vlan_aware.
>=20
> Would the port then stay at VLAN_AWARE_ENA=3D0 in ANA_VLAN_CFG while it i=
s
> in a VLAN-aware bridge? That would give wrong ingress VLAN classification
> and filtering.
>=20
> The incomplete rollback is in the DSA core. This patch makes it reachable
> through the new ageing limits, and the new bridge_leave creates the
> mismatch on the driver side. The issue still seems to be there at the end
> of the series.
>=20
> [ ... ]
>=20
> > @@ -324,6 +333,246 @@ static void lan9645x_port_phylink_get_caps(struct=
 dsa_switch *ds, int port,
> >       lan9645x_phylink_get_caps(ds->priv, port, config);
> >  }
> >=20
> > +static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned in=
t msecs)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +     /* Entry must suffer two aging scans before it is removed, so it =
is
> > +      * aged after 2*AGE_PERIOD, and the unit is in seconds.
> > +      */
> > +     lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs / (2 * MSEC_PER_SEC)),
> > +             ANA_AUTOAGE_AGE_PERIOD,
> > +             lan9645x, ANA_AUTOAGE);
> > +
> > +     return 0;
> > +}
>=20
> [Severity: Medium]
> This is a pre-existing issue in the DSA core and was not introduced by
> this patch, but it affects the new lan9645x_set_ageing_time(). Does
> raising the bridge ageing time ever reach the hardware?
>=20
> dsa_port_ageing_time() sends the notifier before it updates the cached
> value:
>=20
> net/dsa/port.c:dsa_port_ageing_time() {
>     ...
>         err =3D dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
>         if (err)
>                 return err;
>=20
>         dp->ageing_time =3D ageing_time;
>     ...
> }
>=20
> dsa_switch_fastest_ageing_time() then takes the minimum over all ports,
> including the old value of the requesting port:
>=20
>         dsa_switch_for_each_port(dp, ds)
>                 if (dp->ageing_time && dp->ageing_time < ageing_time)
>                         ageing_time =3D dp->ageing_time;
>=20
> So a change from 300000 ms to 600000 ms programs 300000 ms through
> lan9645x_set_ageing_time() and returns success. 600000 ms is then cached
> in dp->ageing_time, with no further hardware write.
>=20
> The fix probably belongs in the DSA core rather than in this driver: the
> requester's cached value could be updated, or left out, before the
> minimum is computed.
>=20
> [ ... ]
>=20
> > +static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
> > +                                   struct switchdev_brport_flags f,
> > +                                   struct netlink_ext_ack *extack)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
>=20
> [ ... ]
>=20
> > +     if (f.mask & BR_MCAST_FLOOD) {
> > +             bool ena =3D !!(f.val & BR_MCAST_FLOOD);
> > +
> > +             lan9645x_port_pgid_set(lan9645x, PGID_MC, port, ena);
> > +             lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, port, ena);
> > +             lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, port, ena);
> > +     }
>=20
> [Severity: Medium]
> Does this break the PGID_MC fallback that the mdb code uses when the
> general-purpose PGIDs run out?
>=20
> When a group's PGID is shared or no PGID is free, __lan9645x_mdb_del()
> points the L2 group at PGID_MC:
>=20
> drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c:__lan9645x_mdb_del() {
>     ...
>         /* Shared PGID or on flood mask. Point the entry at the L2 MC flo=
od mask
>          * instead. This way our mac table entry survives and MAC_CPU_COP=
Y
>          * keeps host membership working.
>          */
>     ...
>         lan9645x_mdb_narrow_dest(lan9645x, mdb_entry, type, NULL, PGID_MC=
,
>                                  new_ports);
>     ...
> }
>=20
> __lan9645x_mdb_add() also keeps a group that is already on the flood mask
> pointed at PGID_MC:
>=20
>                 /* For a L2 MC group already on the flood mask, we keep i=
t there
>                  * so that the host can still join/leave a group we had t=
o give
>                  * up offloading. A front port that joins forwards accord=
ing to
>                  * the flood masks, like the other members.
>                  */
>                 if (lan9645x_mdb_on_flood_mask(mdb_entry, type))
>                         return lan9645x_mdb_widen_dest(lan9645x, mdb_entr=
y,
>                                                        type, NULL, PGID_M=
C,
>                                                        new_ports);
>=20
> This fallback depended on PGID_MC holding every front port, as
> lan9645x_setup() sets it. With this change, a port configured with:
>=20
>   bridge link set dev swpN mcast_flood off
>=20
> is removed from PGID_MC. If that port is also a registered member of an
> L2 group in the fallback state, will it stop receiving that group's
> traffic?
>=20
> The software bridge still delivers registered groups to their members
> whatever their mcast_flood setting, so hardware forwarding would no
> longer match it. Also, when such a port joins through
> __lan9645x_mdb_add(), the join reports success but the port gets no
> traffic. The issue still seems to be there at the end of the series.
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip=
.com

