Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3F3B8D78;
	Mon, 17 Aug 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976711; cv=none; b=B9JSP7CsJRL+LmdMQ5tfrKFGcY3XBbZ1wp5MEWLAy3e7L/tbA/ZZH+FY4zB9jH8te4b/FYhJtIV8Qi1LxI/sc6OjBSDrKjW4EKo6Cmx1Po8ig1gl6J+8xPcru2yKOSFarYrcv8lrcp7t9g9XKCwaGYWqGEzM9nOoK+dTrgeYpgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976711; c=relaxed/simple;
	bh=7J+XV6eYZjQI3LiRBZOA5DfL/UG1yVp3yQcxJXn/L6A=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmZm4iWMz28cQFm/KVgHgGdAXjdFwM4RnXTxD3SOuqj5IA9Nj0VEdREvzbBukoW5zzSxwaK0odgk5/6xcAe5w7YsDWLq7RtX3K7B490Qwll64vXR3qtVOGxqxx7j0Vob7MEfIBz5a4UHIi8umwLuUxEn0C/6WPl04x0XCRXzpl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G0PaNbaD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G0PaNbaD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786976710; x=1818512710;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=7J+XV6eYZjQI3LiRBZOA5DfL/UG1yVp3yQcxJXn/L6A=;
  b=G0PaNbaD4vNvo31gqq5O8wzlh0bvEJvIp7mk2gbRx62iaRajkQaMUEow
   wZMz1m0/Ql1Dzma4bN5yTu29x8z53Qxn8lWXUWEYXbIhV3h/dGV6hUcwT
   kAbrUPWFeWyWBUbCA+2YYF4RRdQCJMYGICAvn2eLu5/+tbaeGlngW6YrC
   5J5pqjDG9q8+rHK6m/P4WGdNFQ1EtLjFGUO5XparRnEewmr4bOAhKgDo1
   VpGFXhHuTWbf1ZqN729KNFKVufsQaufC8X2fGqmKhRPf+7qeqP9MxalUS
   aBMxjjDvfm2xDk8Ogb56tP0qL0rJd01JVg0cedHdkedM+gOjb4Yv6ry1a
   Q==;
X-CSE-ConnectionGUID: c9NbsbRRQbu7Wx3PRprxNw==
X-CSE-MsgGUID: fas0JAhSSASKUpM3IRptuQ==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="62555631"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2026 07:25:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Aug 2026 07:25:08 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 07:25:05 -0700
Message-ID: <34245dc2c222181e9193c2a20f162c87997edf5a.camel@microchip.com>
Subject: Re: [PATCH net-next v11 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
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
Date: Mon, 17 Aug 2026 16:25:04 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-4-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-4-007ebc983a0a@microchip.com>
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
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D4

> --- Patch [4]: [PATCH net-next v11 4/9] net: dsa: lan9645x: add basic dsa=
 driver for LAN9645X ---
> commit 7179961df7a02e02ab3f219d400994a3b9653f9b
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: lan9645x: add basic dsa driver for LAN9645X
>
> Adds a new DSA driver for the Microchip LAN9645X switch family, wiring up
> switch reset/initialization, NPI and CPU port module setup, per-port setu=
p
> and phylink MAC integration. Register access is done through named regmap=
s
> requested from a parent device. Only the internal CuPHYs (ports 0-4) and
> the RGMII paths on ports 7-8 are supported in this patch.
>
> A few questions below.
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig
b/drivers/net/dsa/microchip/lan9645x/Kconfig
> > new file mode 100644
> > index 0000000000000..4d9fdf34104eb
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NET_DSA_MICROCHIP_LAN9645X
> > +	tristate "Microchip Lan9645x switch support"
> > +	depends on NET_DSA
> > +	select NET_DSA_TAG_LAN9645X
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, sashiko-gemini =C2=B7 C=
onfirmed by: sonnet-5
> Should this also depend on REGMAP?
>
> Every register access in the driver goes through the regmap API:
> dev_get_regmap() in lan9645x_request_target_regmaps(), and
> regmap_read()/regmap_write()/regmap_update_bits()/regmap_bulk_read()/
> regmap_read_poll_timeout() inside lan_rd()/lan_wr()/lan_rmw()/
> lan_bulk_rd()/lan9645x_rd_poll_timeout() in lan9645x_main.h.
>
> With CONFIG_REGMAP=3Dn the module still builds, because include/linux/reg=
map.h
> provides stubs:
>
> include/linux/regmap.h
>     static inline struct regmap *dev_get_regmap(struct device *dev,
> 						const char *name)
>     {
> 	    return NULL;
>     }
>
> so lan9645x_request_target_regmaps() always fails and probe returns -ENOD=
EV.
> REGMAP is not user-selectable, so NET_DSA=3Dy with REGMAP=3Dn is a normal
> randconfig outcome. The neighbouring Microchip switch drivers state the
> dependency (NET_DSA_MICROCHIP_KSZ9477_I2C selects REGMAP_I2C,
> NET_DSA_MICROCHIP_KSZ_SPI selects REGMAP_SPI).
>

I will add select REGMAP.

> [ ... ]
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> > new file mode 100644
> > index 0000000000000..b9168052fcbc1
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.h
> > @@ -0,0 +1,332 @@
>
> [ ... ]
>
> > + * 0-63:         Destination analysis
> > + * 64-79:        Aggregation analysis
> > + * 80-(80+10-1): Source port analysis
> > + *
> > + * Destination: By default the first 9 port masks =3D=3D BIT(port_num)=
. Never change
> > + * these except for aggregation. Remaining dst masks are for L2 MC and
> > + * flooding. (See FLOODING and FLOODING_IPMC).
>
> [ ... ]
>
> > +#define PGID_AGGR			64
> > +#define PGID_SRC			80
> > +#define PGID_ENTRIES			89
> > +
> > +#define PGID_AGGR_NUM			(PGID_SRC - PGID_AGGR)
> > +
> > +/* General purpose PGIDs. */
> > +#define PGID_GP_START			NUM_PHYS_PORTS
> > +#define PGID_GP_END			PGID_MRP
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, sashiko-gemini =C2=B7 C=
onfirmed by: sonnet-5
> Is destination PGID 9 really free for general purpose use?
>
> The comment above says the first 9 destination masks are the per-port
> defaults, and PGID_GP_START is NUM_PHYS_PORTS (9). But this same header
> describes index 9 as a port module:
>
>     /* Port modules 0-8 are front (user) ports. The chip additionally has=
 two
>      * logical CPU port modules at indices 9 and 10.
>      ...
>      * Therefore the CPU datapath has two port module indices of interest=
,
>      * lan9645x->npi and the cpu port module at index 9.
>      */
>
> and lan9645x_port_cpu_init() programs ANA_PORT_CFG(9), QSYS_SW_PORT_MODE(=
9),
> REW_PORT_CFG(9) and uses BIT(9) masks. The register definitions also poin=
t
> at 10 addressable port modules:
>
>     #define ANA_PGID(g)               __REG(TARGET_ANA,\
> 					0, 1, 27648, g, 90, 8, 0, 0, 1, 4)
>     #define ANA_PGID_PGID                            GENMASK(9, 0)
>
> with 90 replications (64 destination + 16 aggregation + 10 source), and
> IFH_DSTS_SZ is 10 in include/linux/dsa/lan9645x.h.
>
> The register-compatible ocelot driver skips num_phys_ports + 1 per-port
> destination entries, i.e. it treats the CPU port module's entry as reserv=
ed:
>
> include/soc/mscc/ocelot.h
>     #define for_each_nonreserved_multicast_dest_pgid(ocelot, pgid)	\
> 	    for ((pgid) =3D (ocelot)->num_phys_ports + 1;			\
> 		 (pgid) < PGID_BLACKHOLE;				\
> 		 (pgid)++)
>
> PGID_GP_START is unused in this patch, but later in the series
> lan9645x_mdb_pgid_entry_create() allocates from it:
>
>     for (index =3D PGID_GP_START; index < PGID_GP_END; index++) {
>
> so the first offloaded MDB group would rewrite ANA_PGID(9), which looks l=
ike
> the CPU port module's own default destination mask. Should PGID_GP_START =
be
> NUM_PHYS_PORTS + 1 instead, and the "first 9 port masks" comment be updat=
ed
> to 10?
>

No the current configuration is correct, and the suggestion would waste PGI=
D[9].
Only the first 9 PGIDs are special (or 'reserved'), in the sense they are u=
sed
by the forwarding engine for dynamic learning, so dynamically learned mac t=
able
entries point to one of these. This is also reflected in the hardware reset
default values. PGID[i] =3D BIT(i) for i=3D0,...,8 (front ports), but PGID[=
9] =3D 0,
like the rest of the destination pgids.

We use PGID_CPU=3D58 for to get known traffic to the CPU, PGID[9] is unused=
 and
fine to use as a general purpose PGID.

It is right the mask is 10 bits wide. But CPU port module bit is inert in t=
he
aggregation pgids and source pgids, so setting the BIT(9) has no effect. Bu=
t it
is active in the destination pgids, which is how PGID_CPU works.

I will update the comments about PGIDs and the the forwarding decisions.


> [ ... ]
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> > new file mode 100644
> > index 0000000000000..836abc74b6f7a
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> > @@ -0,0 +1,382 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include <linux/phy.h>
> > +#include <linux/phy/phy.h>
> > +
> > +#include "lan9645x_main.h"
> > +
> > +/* Port 4 or 7 is RGMII_0 and port 8 is RGMII_1 */
> > +#define RGMII_IDX(port) ((port) =3D=3D 8 ? 1 : 0)
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, sashiko-gemini =C2=B7 C=
onfirmed by: sonnet-5
> This isn't a bug, but is this comment left over from the DEV4 muxing that
> v9 dropped? Ports 0-4 only advertise GMII now, so RGMII_IDX() is only eve=
r
> evaluated for ports 7 and 8, and lan9645x_phylink_mac_prepare() in this s=
ame
> file says the opposite:
>
> 	/* DEV4 is cuphy-only, so RGMII_0 is always routed to DEV7 (its reset
> 	 * default); make it explicit on a DEV7 RGMII bring-up.
> 	 */
>

I will update the comment.

> > +
> > +void lan9645x_phylink_get_caps(struct lan9645x *lan9645x, int port,
> > +			       struct phylink_config *c)
> > +{
> > +	c->mac_capabilities =3D MAC_ASYM_PAUSE | MAC_SYM_PAUSE | MAC_10 |
> > +			      MAC_100 | MAC_1000FD;
> > +
> > +	switch (port) {
> > +	case 0 ... 4:
> > +		__set_bit(PHY_INTERFACE_MODE_GMII, c->supported_interfaces);
> > +		break;
> > +	case 5 ... 6:
> > +		/* SerDes ports: QSGMII/SGMII/1000BASEX/2500BASEX modes
> > +		 * require PCS support which is not yet implemented.
> > +		 * With empty supported_interfaces, these will end up being
> > +		 * marked unused by the DSA core, if they are declared in the
> > +		 * DT.
> > +		 */
> > +		break;
>
> Discovered by: opus-5 =C2=B7 Missed by: sonnet-5, sashiko-gemini =C2=B7 C=
onfirmed by: sonnet-5
> Does the DSA core actually mark such a port unused?

Yes, if port 5 or 6 is declared as a user port. If they are declared as
the CPU port, the probe does fail.

>
> dsa_port_phylink_create() passes dp->pl_config straight to phylink_create=
(),
> and the first thing phylink_create() does is:
>
> drivers/net/phy/phylink.c:phylink_create()
> 	if (phy_interface_empty(config->supported_interfaces)) {
> 		dev_err(config->dev,
> 			"phylink: error: empty supported_interfaces\n");
> 		return ERR_PTR(-EINVAL);
> 	}
>
> net/dsa/port.c:dsa_port_phylink_create()
> 	pl =3D phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn), mode,
> 			    mac_ops);
> 	if (IS_ERR(pl)) {
> 		pr_err("error creating PHYLINK: %ld\n", PTR_ERR(pl));
> 		return PTR_ERR(pl);
> 	}
>
> That -EINVAL propagates through dsa_port_setup() and dsa_tree_setup_ports=
()
> to dsa_register_switch(), so declaring an enabled port 5 or 6 in DT fails
> registration of the whole switch, including the working ports. Nothing in
> net/dsa demotes a port to DSA_PORT_TYPE_UNUSED based on
> supported_interfaces.
>

The agent seems to have stopped short of reading the callsite it mentions i=
n
dsa_tree_setup_ports():

net/dsa/dsa.c:dsa_tree_setup_ports()
list_for_each_entry(dp, &dst->ports, list) {
        if (dsa_port_is_dsa(dp) || dsa_port_is_cpu(dp)) {
                err =3D dsa_port_setup(dp);
                if (err)
                        goto teardown;
        }
}

list_for_each_entry(dp, &dst->ports, list) {
        if (dsa_port_is_user(dp) || dsa_port_is_unused(dp)) {
                err =3D dsa_port_setup(dp);
                if (err) {
                        err =3D dsa_port_setup_as_unused(dp);
                        if (err)
                                goto teardown;
                }
        }
}

You also get helpful errors from DSA in the user port case, but in the CPU
port case, it does not tell you the offending port. So I can add a error
log in the npi port setup to help the user figure out why it failed to prob=
e.

> The binding added in this series allows those nodes:
>
> Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-switch.yaml
>       "^ethernet-port@[0-8]$":
>
> so a schema-valid DT can hit this, with only "phylink: error: empty
> supported_interfaces" and "error creating PHYLINK: -22" to go on. Would i=
t
> be clearer to reject ports 5-6 explicitly in port_setup with a message
> naming the port, and to reword the comment?
>
> The commit message makes the same claim indirectly:
>
>     Port 5-6 have no usable interface mode in this patch, and should not =
be
>     declared in DT until SerDes support lands.
>
> Could this mention that declaring them fails the whole switch registratio=
n
> rather than just disabling those ports?
>

But as user ports the do come up as unused, switch registration only fails =
if
they are declared as CPU ports.

> [ ... ]

