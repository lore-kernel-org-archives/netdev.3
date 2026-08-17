Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC648442118;
	Mon, 17 Aug 2026 14:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786977109; cv=none; b=cYy3sgqu3+HGUKnsmWiU0IN64MH/8C1OPzwQDcKGE4lCkkWg4qyuVnahzkcjzj1TcWwsiekHUJuy4K3XI62Q91Kz/g9lYC+moWVF/+2kqRpmi2EljC+3Hw9YJCnV2neK2fMP52EFNA1moPvY6mWmEA0MzBXxxh6AdLycXu5FnBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786977109; c=relaxed/simple;
	bh=lKB4XBQmpdxRm2bqZKm89mcmc9u/HgJLon4GxJCLgz0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b1bZDpH+adbd0QS/lAKVvoKc4rxxJUNuMJ941HSsXybslZcpHMi0soQ9qjnY8RqVU6B7+I7T+NQS+x4UMoh8FFnoBDD/5C3erxGftKXu6hcO/MqEPcqDrswdJ0GUIRa/yFZfSUME77tWyR7s1Wme5qdjK3fEKeHarCNMIIp/no4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sN/EDymy; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sN/EDymy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786977107; x=1818513107;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=lKB4XBQmpdxRm2bqZKm89mcmc9u/HgJLon4GxJCLgz0=;
  b=sN/EDymyKMM5/no+9rfzzueRyAk94a1w0FZJ4lm9fol4Z3Jxonz9usQT
   QE3ktOH2fjHhBTQNK7gAc/uPyQcVV40nPAvC7JCx+qPSp6PDrbt2i0M60
   RVTuIajjAS3itSpRaahJ84aCgYjiWAX3ClS2xOTkSNdXkLDdCPVOXWge6
   y5uOH94gFdCHGBdguoUqq03QeVd6LHBFRwvxPvyTlwaVfXqwcEwgRuwGr
   ciGYVz3+yyaVrHWszhjycNK4Wz6i7IV73/8SlWBuK54UKheTSmah/N/FP
   PA+Kv8HY2TUOC3hi/rGENnwZyT1dnRaYcP3Eth83bl8O1BrFmCoemWEik
   w==;
X-CSE-ConnectionGUID: gvczMV3jTbCevTcQaFSGtw==
X-CSE-MsgGUID: 0Ct+44MhTP2DJN21gE1YMg==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="62556005"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 07:31:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 17 Aug 2026 07:31:46 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 07:31:43 -0700
Message-ID: <81bc1f7014f70b567a3a6e4a67728fb9796c4f02.camel@microchip.com>
Subject: Re: [PATCH net-next v11 5/9] net: dsa: lan9645x: add bridge support
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
Date: Mon, 17 Aug 2026 16:31:42 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-5-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-5-007ebc983a0a@microchip.com>
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
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D5

> --- Patch [5]: [PATCH net-next v11 5/9] net: dsa: lan9645x: add bridge su=
pport ---
> commit a6410541102bca5214b00713a7a5b063ffd47ab2
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: lan9645x: add bridge support
>
> This adds bridge offload to the lan9645x DSA driver: bridge join/leave,
> STP state and learning, port flooding flags, host flood handling through
> an ordered workqueue, and an ageing time setter. A single bridge device
> is supported.
>
> A few questions about the bridge integration below.
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index b253813518c20..c145d28ffbb99 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>
> [ ... ]
>
> > @@ -265,15 +269,34 @@ static int lan9645x_setup(struct dsa_switch *ds)
> > =20
> >  	lan9645x_port_set_tail_drop_wm(lan9645x);
> > =20
> > +	lan9645x->owq =3D alloc_ordered_workqueue("%s-owq", 0,
> > +						dev_name(lan9645x->dev));
> > +	if (!lan9645x->owq) {
> > +		err =3D -ENOMEM;
> > +		goto err_mutex;
> > +	}
> > +
> >  	ds->mtu_enforcement_ingress =3D true;
> >  	ds->assisted_learning_on_cpu_port =3D true;
> >  	ds->fdb_isolation =3D true;
>
> Discovered by: opus-5 =C2=B7 Missed by: fable-5, sashiko-gemini =C2=B7 Co=
nfirmed by: fable-5
> Should ds->max_num_bridges be set to 1 here as well, next to
> ds->fdb_isolation?
>
> In net/dsa/dsa.c, dsa_bridge_num_get() treats a zero maximum as "no FDB
> isolation" and hands back a constant bridge number:
>
> 	/* Switches without FDB isolation support don't get unique
> 	 * bridge numbering
> 	 */
> 	if (!max)
> 		return 0;
>
> and net/dsa/port.c dsa_port_bridge_create() skips the range check for the
> same reason:
>
> 	bridge->num =3D dsa_bridge_num_get(br, ds->max_num_bridges);
> 	if (ds->max_num_bridges && !bridge->num) {
> 		NL_SET_ERR_MSG_MOD(extack,
> 				   "Range of offloadable bridges exceeded");
>
> So the driver requests FDB isolation while the isolation key the core
> returns is always 0, and the single-bridge limit is then open coded in
> lan9645x_port_bridge_join() with -EBUSY and "Only one bridge supported".
> The other in-tree drivers that set fdb_isolation (felix, sja1105,
> vitesse-vsc73xx-core, rtl8365mb, netc) also set max_num_bridges.
>
> The driver does not consume db.bridge.num anywhere in the final series, s=
o
> nothing is mis-keyed today; it is the mismatch between the two fields tha=
t
> looks unintended.
>

Yes, i think this is right. I will set max_num_bridges=3D1 and remove the o=
pen
coded single-bridge limit.

> > +	/* ANA_AUTOAGE_AGE_PERIOD is a seconds-based field and entries are
> > +	 * aged after 2 * AGE_PERIOD, giving (2 * FIELD_MAX) seconds of
> > +	 * maximum aging.
> > +	 */
> > +	ds->ageing_time_max =3D 2U * MSEC_PER_SEC *
> > +			      FIELD_MAX(ANA_AUTOAGE_AGE_PERIOD);
> > +
>
> Discovered by: opus-5 =C2=B7 Missed by: fable-5, sashiko-gemini =C2=B7 Co=
nfirmed by: fable-5
> Only the upper ageing bound is published to the core here, leaving
> ds->ageing_time_min at 0.  Should ds->ageing_time_min =3D 2 * MSEC_PER_SE=
C be
> set too?
>
> net/dsa/switch.c dsa_switch_ageing_time() only rejects out-of-range
> requests when the corresponding limit is nonzero:
>
> 	if (ds->ageing_time_min && ageing_time < ds->ageing_time_min)
> 		return -ERANGE;
>
> 	if (ds->ageing_time_max && ageing_time > ds->ageing_time_max)
> 		return -ERANGE;
>
> net/bridge/br_stp.c br_set_ageing_time() imposes no lower bound either, s=
o
> a request below 2000 ms reaches lan9645x_set_ageing_time() and is clamped
> while success is reported:
>
> 	ip link set br0 type bridge ageing_time 100
> 	  -> lan9645x_set_ageing_time(ds, 1000)
> 	     age_secs =3D max(1, 1000 / 1000 / 2) =3D max(1, 0) =3D 1
> 	     ANA_AUTOAGE_AGE_PERIOD =3D 1, i.e. entries age after 2 s
>
> For any msecs in 1..3999 the division yields 0 or 1 and the clamp forces =
1,
> so every sub-2 s request silently becomes an effective 2 s hardware
> ageing while the bridge keeps and reports the value userspace asked for.
> drivers/net/dsa/netc/netc_main.c sets ds->ageing_time_min alongside
> ds->ageing_time_max.

We intentionally do not set ds->ageing_time_min because we would like to su=
pport
disabling ageing with an explicit zero value.

We generally round down to a 2s multiple, but I decided to round up in the
(0,2s] interval. If a user requests a very fast ageing time, I think it is
better to configure it to 2s, than to disable ageing.

>
> >  	dev_info(lan9645x->dev,
> >  		 "SKU features: max_ports=3D%d\n",
> >  		 lan9645x->num_phys_ports - lan9645x->num_port_dis);
> > =20
> >  	return 0;
> > +
> > +err_mutex:
> > +	mutex_destroy(&lan9645x->fwd_domain_lock);
> > +	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> > +	return err;
> >  }
>
> [ ... ]
>
> > @@ -282,6 +305,282 @@ static void lan9645x_port_phylink_get_caps(struct=
 dsa_switch *ds, int port,
> >  	lan9645x_phylink_get_caps(ds->priv, port, config);
> >  }
> > =20
> > +static int lan9645x_set_ageing_time(struct dsa_switch *ds, unsigned in=
t msecs)
> > +{
> > +	u32 age_secs =3D max(1, msecs / MSEC_PER_SEC / 2);
> > +	struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +	/* Entry must suffer two aging scans before it is removed, so it is
> > +	 * aged after 2*AGE_PERIOD, and the unit is in seconds.
> > +	 * An age period of 0 disables automatic aging.
> > +	 */
> > +	lan_rmw(ANA_AUTOAGE_AGE_PERIOD_SET(msecs ? age_secs : 0),
> > +		ANA_AUTOAGE_AGE_PERIOD,
> > +		lan9645x, ANA_AUTOAGE);
> > +	return 0;
> > +}
>
> [ ... ]
>
> > +static void __lan9645x_port_set_host_flood(struct lan9645x *lan9645x)
> > +{
> > +	bool mc_ena, uc_ena;
> > +	u16 unbridged;
> > +
> > +	lockdep_assert_held(&lan9645x->fwd_domain_lock);
> > +
> > +	/* We want promiscuous and all_multi to affect standalone ports, for
> > +	 * debug and test purposes.
> > +	 *
> > +	 * However, the linux bridge is incredibly eager to put bridged ports=
 in
> > +	 * promiscuous mode.
> > +	 *
> > +	 * This is unfortunate since lan9645x flood masks are global and not =
per
> > +	 * ingress port. When some port triggers unknown uc/mc to the CPU, th=
e
> > +	 * traffic from any port is forwarded to the CPU.
> > +	 *
> > +	 * If the host CPU is weak, this can cause tremendous stress. Therefo=
re,
> > +	 * we compromise by ignoring this host flood request for bridged port=
s.
> > +	 */
> > +	unbridged =3D ~lan9645x->bridge_mask & GENMASK(NUM_PHYS_PORTS - 1, 0)=
;
> > +
> > +	uc_ena =3D !!(lan9645x->host_flood_uc_mask & unbridged);
>
> Discovered by: fable-5, opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug, but could the commit message mention the two user
> visible behaviours added here?
>
> The log says only "Add support for hardware offloading of the bridge. We
> support a single bridge device.", while this masking means a
> .port_set_host_flood request for a bridged port is accepted and then
> dropped:
>
> net/dsa/user.c dsa_user_change_rx_flags() -> dsa_user_manage_host_flood()
> -> net/dsa/port.c dsa_port_set_host_flood() -> lan9645x_port_set_host_flo=
od()
> -> lan9645x_host_flood_work_fn() -> __lan9645x_port_set_host_flood()
>
> Since br_manage_promisc() puts bridge ports in promiscuous mode when the
> bridge has VLAN filtering disabled, the CPU port bit is never set in
> PGID_UC/PGID_MC/PGID_MCIPV4/PGID_MCIPV6 for a bridged port, and no error
> is returned to userspace.  lan9645x_port_bridge_join() also revokes an
> already granted request through __lan9645x_port_set_host_flood(), and
> lan9645x_port_bridge_leave() restores it.  The sibling driver for the sam=
e
> hardware family, felix_port_set_host_flood() in
> drivers/net/dsa/ocelot/felix.c, honours the request unconditionally.
>

I can mention this in the commit message. I would add that even when VLAN
filtering is enabled, the conditions for when a bridged port is not put in
promiscuous mode are narrow. In most regular situations a bridged port is
put into promiscuous mode, even with VLAN filtering.

> The second omission is .set_ageing_time, ds->ageing_time_max and the
> "msecs =3D=3D 0 disables automatic ageing" semantic, which are described =
only
> in the comment above and in the changelog below the --- marker.
>
> [ ... ]
>
> > +static void lan9645x_port_bridge_stp_state_set(struct dsa_switch *ds, =
int port,
> > +					       u8 state)
> > +{
>
> [ ... ]
>
> > +	lan_rmw(ANA_PORT_CFG_LEARN_ENA_SET(learn_ena),
> > +		ANA_PORT_CFG_LEARN_ENA, lan9645x,
> > +		ANA_PORT_CFG(p->chip_port));
> > +
> > +	lan9645x_update_fwd_mask(lan9645x);
> > +	mutex_unlock(&lan9645x->fwd_domain_lock);
> > +}
>
> [ ... ]
>
> >  static const struct dsa_switch_ops lan9645x_switch_ops =3D {
> >  	.get_tag_protocol		=3D lan9645x_get_tag_protocol,
> > =20
> > @@ -295,6 +594,15 @@ static const struct dsa_switch_ops lan9645x_switch=
_ops =3D {
> >  	/* MTU  */
> >  	.port_change_mtu		=3D lan9645x_change_mtu,
> >  	.port_max_mtu			=3D lan9645x_get_max_mtu,
> > +
> > +	/* Bridge integration */
> > +	.set_ageing_time		=3D lan9645x_set_ageing_time,
> > +	.port_pre_bridge_flags		=3D lan9645x_port_pre_bridge_flags,
> > +	.port_bridge_flags		=3D lan9645x_port_bridge_flags,
> > +	.port_bridge_join		=3D lan9645x_port_bridge_join,
> > +	.port_bridge_leave		=3D lan9645x_port_bridge_leave,
> > +	.port_stp_state_set		=3D lan9645x_port_bridge_stp_state_set,
> > +	.port_set_host_flood		=3D lan9645x_port_set_host_flood,
> >  };
>
> Discovered by: fable-5, opus-5 =C2=B7 Missed by: sashiko-gemini
> STP state and learning offload are registered here without .port_fast_age=
,
> so when net/dsa/port.c dsa_port_set_state() calls dsa_port_fast_age() the=
re
> is no hardware MAC table flush.  Dynamic entries learned on a port would
> stay in the ANA MAC table after the port leaves BR_STATE_FORWARDING or
> BR_STATE_LEARNING, after BR_LEARNING is cleared, and after bridge leave.
>
> This is resolved later in the same series: the follow-up patch "net: dsa:
> lan9645x: add mac table integration" adds lan9645x_port_fast_age() callin=
g
> lan9645x_mact_flush() and registers ".port_fast_age =3D
> lan9645x_port_fast_age", with the per-port flush implemented in
> lan9645x_mac.c using ANA_ANAGEFIL_PID_EN/PID_VAL plus two CMD_AGE scans.
> So the gap exists only at this intermediate patch; mentioning it here is
> just for completeness.
>
> Would it be worth reordering so the flush hook lands together with the ST=
P
> offload, or is the intermediate state acceptable?

I will reorganize the commit order so bridge support lands after vlan, mact=
able
and mdb.

