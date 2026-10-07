Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B443E4B0;
	Wed,  7 Oct 2026 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383034; cv=none; b=PMw1YtTBlVuo7V8n0+34nlPQgKbb1MSuf1Dg/aexTzxwdVVN0t4M9GbrEnti8Pzfd85Jyy817O5uCD0c2CqA1x49yC7WRn7xyjC2ZC5RRMkc8z8KmwKFT0iH+HYEaY/VX9WB31xLrq4PH0ayt5xs8SItJoqQwnfcG3NuptqIEIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383034; c=relaxed/simple;
	bh=/MPIexTjq83ZCG6vAOh2V3oBXqJDI6BdS/aHuNLsiEs=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UAdwXIT8dqgA3sDVHnvzKjNv6gilvp60Y6Kgq9ZID1wrowmsbubC1jH8hJm9L77L0DoQyRCGqFq3RPp4QrboRqTledTCKzoZTBAlxMNzMRO0u2YMc7vcLLDMwz7Qp3DyhCIddGU0aKno5KOQ1HNbnuGKTaGyRI+vn77k/qfHJY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AU3qgdAt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AU3qgdAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791383033; x=1822919033;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/MPIexTjq83ZCG6vAOh2V3oBXqJDI6BdS/aHuNLsiEs=;
  b=AU3qgdAtQGn4zcPNmzqSSuWI9FNLmi1+VKMlvW5sR4obXAK+HrR+WUt9
   oKsRk95WmTDv5g/CqmYota+bjUgHO/YtL0c0UC0BsNphddDTvS2SneKq0
   EiwcrfTmeLghQibYQN2j2gMUTo6lCUTUrImsSqhlHSugGKUxHDF3Ce374
   7SASekxU7hUDzQX4RMVNsnAwXUMoeE2gk6Dg10bkGDkwElez2NdChwbvK
   YoM0lzp+64TJV/ne0oVX2LbBy+aWeEjv3VMClASXw0QUzVOapnp7JtIng
   3JEELAnM+lYSxUg8LRrJHbkmvCYEwcVocEY5VbzVubliJrhsV5Hh8S+1P
   g==;
X-CSE-ConnectionGUID: pO9xJ5tZSTO4Ca+5H4SR9w==
X-CSE-MsgGUID: WzZMRt+SRjqs416eCdcEQQ==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="231796105"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 07:23:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 7 Oct 2026 07:23:40 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 7 Oct 2026 07:23:36 -0700
Message-ID: <3b93fce0e8a86d9d4443576b43bcd4d0af678aa1.camel@microchip.com>
Subject: Re: [PATCH net-next v13 8/9] net: dsa: lan9645x: add bridge support
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
Date: Wed, 7 Oct 2026 16:23:36 +0200
In-Reply-To: <179097566495.434549.3273751118758202353@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-8-827c2d3617f2@microchip.com>
	 <179097566495.434549.3273751118758202353@kernel.org>
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
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 0
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] __lan9645x_port_set_host_flood() computes uc_ena/mc_ena from
>   host_flood_*_mask & ~bridge_mask, so it drops every host flood request=
=E2=80=A6
> - [Medium] The MDB code falls back to the L2 multicast flood PGID
>   (PGID_MC) when it runs out of general-purpose PGIDs.
> - [Medium] The patch sets ds->ageing_time_min =3D 2000 ms, so enslaving a
>   lan9645x port to a bridge with ageing_time below 2 s (for example 0,=E2=
=80=A6
>=20
> --
>=20
> net: dsa: lan9645x: add bridge support
>=20
> This adds hardware bridge offload to the lan9645x DSA driver for a single
> bridge. It covers ageing time, bridge port flags, STP state and host floo=
d.
> The CPU port module is taken out of the default UC/MC flood PGIDs. Host
> flood requests from offloaded bridged ports are recorded, but they are no=
t
> programmed until the port leaves the bridge.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index cc85e18c5a3b3..e41a73c20606b 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>=20
> [ ... ]
>=20
> > @@ -324,6 +333,257 @@ static void lan9645x_port_phylink_get_caps(struct=
 dsa_switch *ds, int port,
>=20
> [ ... ]
>=20
> > +static int lan9645x_port_bridge_flags(struct dsa_switch *ds, int port,
> > +                                   struct switchdev_brport_flags f,
> > +                                   struct netlink_ext_ack *extack)
> > +{
>=20
> [ ... ]
>=20
> > +     if (f.mask & BR_MCAST_FLOOD) {
> > +             bool ena =3D !!(f.val & BR_MCAST_FLOOD);
> > +
> > +             lan9645x_port_pgid_set(lan9645x, PGID_MC, port, ena);
>=20
> [Severity: Medium]
> Does this work with the MDB fallback to PGID_MC?
>=20
> When the general-purpose PGIDs run out, __lan9645x_mdb_add() and
> __lan9645x_mdb_del() in lan9645x_mdb.c point a group at PGID_MC:
>=20
> drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c:__lan9645x_mdb_add() {
>     ...
>                 if (lan9645x_mdb_on_flood_mask(mdb_entry, type))
>                         return lan9645x_mdb_widen_dest(lan9645x, mdb_entr=
y,
>                                                        type, NULL, PGID_M=
C,
>                                                        new_ports);
>     ...
> }
>=20
> drivers/net/dsa/microchip/lan9645x/lan9645x_mdb.c:__lan9645x_mdb_del() {
>     ...
>         lan9645x_mdb_narrow_dest(lan9645x, mdb_entry, type, NULL, PGID_MC=
,
>                                  new_ports);
>     ...
> }
>=20
> After the fallback, the MAC table entry forwards to whatever PGID_MC
> holds, not to the member mask that the MDB code computed. That worked
> when PGID_MC was fixed to all front ports.
>=20
> With this change, "bridge link set dev swpN mcast_flood off" clears swpN
> from PGID_MC. In the software bridge, mcast_flood only affects
> unregistered multicast. Here, though, it looks like a registered member
> port with mcast_flood off would stop getting any group that has fallen
> back to PGID_MC.
>=20
> One way to reach this is more than 48 distinct front port subsets among
> non-IP L2 MDB groups, for example static "bridge mdb add" entries on a
> switch with 6 or more user ports. That would use up PGID_GP_START to
> PGID_GP_END. IP multicast should not be affected because the MAC entry
> encodes the port mask. CPU membership comes from MAC_CPU_COPY.


Dismissed. This is intended. Once a group has to fall back to PGID_MC, it i=
s
forwarded like unregistered multicast, i.e. according to the user's
mcast_flood configuration. This matches mscc/ocelot, where an mdb add
that cannot get a PGID leaves the group without a MAC table entry, so
its traffic is flooded as unknown multicast.

lan9645x cannot simply forget the entry, since host membership is carried
by MAC_CPU_COPY in the entry and not by the flood masks, so it keeps the
entry and points it at PGID_MC instead. A PGID with all ports would
forward the group to ports where mcast_flood was disabled.


>=20
> > +             lan9645x_port_pgid_set(lan9645x, PGID_MCIPV4, port, ena);
> > +             lan9645x_port_pgid_set(lan9645x, PGID_MCIPV6, port, ena);
> > +     }
>=20
> [ ... ]
>=20
> > +static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x)
> > +{
> > +     bool mc_ena, uc_ena;
> > +     u16 unbridged;
> > +
> > +     lockdep_assert_held(&lan9645x->fwd_domain_lock);
>=20
> [ ... ]
>=20
> > +     unbridged =3D ~lan9645x->bridge_mask &
> > +                 GENMASK(lan9645x->num_phys_ports - 1, 0);
> > +
> > +     uc_ena =3D !!(lan9645x->host_flood_uc_mask & unbridged);
>=20
> [Severity: Medium]
> lan9645x_setup() no longer puts the CPU port module in PGID_UC, PGID_MC,
> PGID_MCIPV4 or PGID_MCIPV6. That leaves the host flood bit as the only
> path for unknown unicast and unregistered multicast to reach the CPU.
> With the unbridged filter here, can the CPU ever get that traffic when
> only bridged ports ask for host flooding?
>=20
> The bridge calls dev_set_allmulti(dev, 1) on every port in br_add_if().
> br_manage_promisc() sets promisc when vlan_filtering=3D0, and also when
> there is more than one auto port. dsa_user_manage_host_flood() passes
> the flags through unchanged:
>=20
> net/dsa/user.c:dsa_user_manage_host_flood() {
>     bool mc =3D dev->flags & (IFF_PROMISC | IFF_ALLMULTI);
>     ...
>     bool uc =3D dev->flags & IFF_PROMISC;
>=20
>     dsa_port_set_host_flood(dp, uc, mc);
> }
>=20
> Here, however, ~bridge_mask filters those requests out.
>=20
> A few cases seem to be affected:
>=20
> - Take a bridge with a lan9645x port and a foreign port such as wlan,
>   veth or tap. The software bridge can't flood FDB misses or
>   unregistered multicast to the foreign port. Assisted learning only
>   covers addresses it has already learned. DSA returns -EOPNOTSUPP for
>   MDB entries whose orig_dev is a foreign port, so the hardware would
>   drop a multicast stream going to a wifi client.
>=20
> - With multicast snooping disabled, br0 receives no non-link-local
>   multicast.
>=20
> - Setting promisc or allmulti explicitly on br0 or on a bridged port
>   does nothing.
>=20
> Documentation/networking/switchdev.rst asks for unknown unicast to be
> flooded to every port in the domain. It also asks for flooding to the CPU
> when IFF_PROMISC or IFF_ALLMULTI is set. I'd also expect the promisc and
> allmulti cases of test_bridge in
> tools/testing/selftests/net/forwarding/local_termination.sh to fail.
>=20
> felix has the same global flood mask limitation, but it honours host
> flood for bridged ports. The commit message only presents this as
> protection for a weak CPU and doesn't mention these consequences.
>=20

Correct. This was intentional, as described in the comment and commit
message. I was aware of cases 1 and 3, but was willing to accept that
in the name of comfortably running a weak host CPU. I was not aware
of 2 though, and I would not accept that. I was also not aware of
switchdev.rst specifically asking not to do this. Therefore, I change
v14 to honours host flood requests from bridged ports as well, as
felix does, so the CPU port module is in the unicast and multicast flood
masks while any port requests it.


> > +     lan9645x_port_pgid_set(lan9645x, PGID_UC, lan9645x->num_phys_port=
s,
> > +                            uc_ena);
>=20
> [ ... ]
>=20
> > +static void lan9645x_port_bridge_leave(struct dsa_switch *ds, int port=
,
> > +                                    struct dsa_bridge bridge)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct lan9645x_port *p;
> > +
> > +     p =3D lan9645x_to_port(lan9645x, port);
> > +
> > +     mutex_lock(&lan9645x->fwd_domain_lock);
> > +
> > +     lan9645x->bridge_mask &=3D ~BIT(p->chip_port);
> > +
> > +     __lan9645x_port_set_host_flood(lan9645x);
> > +     lan9645x_vlan_set_hostmode(p);
>=20
> [Severity: Medium]
> Can the new ds->ageing_time_min =3D 2U * MSEC_PER_SEC in lan9645x_setup()
> leave the driver and the DSA core disagreeing when a bridge join fails
> partway through?
>=20
> Suppose a port joins a bridge whose ageing_time is below 2 s, for
> example 0. dsa_port_switchdev_sync_attrs() applies the brport flags, STP
> state and VLAN filtering first. Only after that does
> dsa_port_ageing_time() fail with -ERANGE:
>=20
> dsa_port_bridge_join()
>   DSA_NOTIFIER_BRIDGE_JOIN -> lan9645x_port_bridge_join()
>   dsa_port_switchdev_sync_attrs()
>     dsa_port_inherit_brport_flags()  p->learn_ena =3D true, dp->learning =
=3D true
>     dsa_port_set_state()
>     dsa_port_vlan_filtering(true)    p->vlan_aware =3D true, dp->vlan_fil=
tering =3D true
>     dsa_port_ageing_time()           -ERANGE
>   out_rollback_unoffload / out_rollback_unbridge
>     DSA_NOTIFIER_BRIDGE_LEAVE -> lan9645x_port_bridge_leave()
>=20
> The rollback never calls dsa_port_switchdev_unsync_attrs(). Here,
> lan9645x_vlan_set_hostmode() sets p->vlan_aware =3D false while
> dp->vlan_filtering stays true. p->learn_ena stays true as well.
>=20
> If the port later joins a vlan_filtering=3D1 bridge, dsa_port_vlan_filter=
ing()
> returns early:
>=20
>         if (dsa_port_is_vlan_filtering(dp) =3D=3D vlan_filtering)
>                 return 0;
>=20
> As a result, lan9645x_port_vlan_filtering() is never called. Would the
> port then run VLAN-unaware (UNAWARE_PVID, no VLAN_AWARE_ENA) inside a
> VLAN-aware bridge?
>=20
> If the port stays standalone and is brought down and up again, this path
> runs:
>=20
> dsa_port_enable_rt()
>   dsa_port_set_state_now(BR_STATE_FORWARDING)
>     lan9645x_port_bridge_stp_state_set()
>=20
> learn_ena is computed from the stale p->learn_ena, and
> ANA_PORT_CFG_LEARN_ENA gets set on a standalone port in HOST_PVID. Is
> that intended?
>=20
> The missing unsync in the DSA core rollback is older than this patch.
> However, ageing_time_min is what makes it reachable for lan9645x. On top
> of that, bridge_leave resets vlan_aware without DSA knowing.
>=20

Dismissed, preexisting. As is mentioned the missing dsa_port_switchdev_unsy=
nc
attrs() in the dsa_port_bridge_join() rollback predates this patch. I think=
 it
affects every driver for which a step of dsa_port_switchdev_sync_attrs() ca=
n fail
after VLAN filtering was applied, including all users of
ageing_time_min. Only the core can reset the cached dp->vlan_filtering and
dp->learning, so that is better fixed in DSA. In v14 I can make the driver
independent of this for the learning part though, so I can add that.

> > +     lan9645x_update_fwd_mask(lan9645x);
> > +
> > +     mutex_unlock(&lan9645x->fwd_domain_lock);
> > +}
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com

