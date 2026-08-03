Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DB640315F;
	Mon,  3 Aug 2026 12:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760340; cv=none; b=opcvAMyn2y4O00OcTvFNHgTSWz/DZdQie1GXa2lThHKvBQH2wQMVYz/bfjhDeAa5yEjp5BgOVib+p32drKk3qKXJtzlbo2/IwYqtgaVrcTL38iRIC87f/VAQTRmfMC6oSuqQ/9SZWGanItNY+to1mPqaje6Qmwk5DM8YjD8YocM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760340; c=relaxed/simple;
	bh=8ovvbWvk/kXSAuErI8D86eUIeNim6QLmEIueNzqVOlE=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NQth1m1/sV4BA4ZhGIonaBUEtnRa2TpTHIe49/thO36vRMfiFgbMdUIw8WT15zaxOZZMN9hjiuJ6nBuurdy0Chq0wcd7srrZkf0yegja6ngeKUCWoqnAL/6BhhVQ0ZZDvrND4YonyiCrm4govdXvqpon78E4RP4tKjbGg698Ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=YZZSWQfp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="YZZSWQfp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785760338; x=1817296338;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=8ovvbWvk/kXSAuErI8D86eUIeNim6QLmEIueNzqVOlE=;
  b=YZZSWQfpfbPOiJwMr43CfJweo6NzzMXqCN4Ya58n6dwvYV22Jn1MxkCH
   dgRB+vTJyRkuASsmDp/AWjIRy6AS9RRmG7kthxpBDjhj6JAirMX+SJPVt
   UO36Yo+FtgS4epS84meuafGPV1cmjn/l8sbKILbq6gmuuU+BNBonFapeV
   S1d4xPi1zjqjLs9WdNZ0M/+8gpsqR00SGlc9aT/yQ8IublVdqKppAEr++
   r4fEXhX3z4rlyQ27ZVVKtunbylXvkIcQ5eEe2uCqVCpMHQ8vm7SsCZ3cI
   2HX5Qe3mdRZfhBT7nTjAGK2FoCCBz9q+LAD46s5fNyA0wF1582wE5NLpc
   w==;
X-CSE-ConnectionGUID: O+3ZSEi6RcuZohNUvWy+pw==
X-CSE-MsgGUID: sPk3HDIlRSC9U6TKhXRLdQ==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="61875292"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 05:32:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Aug 2026 05:32:16 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 3 Aug 2026 05:32:13 -0700
Message-ID: <75e008a9cb620d2a086d18320aa85c7cfe7de7d4.camel@microchip.com>
Subject: Re: [PATCH net-next v10 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>, "Andrew
 Lunn" <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Date: Mon, 3 Aug 2026 14:32:13 +0200
In-Reply-To: <430ff31a-4199-402f-b234-167f71d87fa6@redhat.com>
References: <20260713-dsa_lan9645x_switch_driver_base-v10-0-a4886a08fb15@microchip.com>
	 <20260713-dsa_lan9645x_switch_driver_base-v10-4-a4886a08fb15@microchip.com>
	 <430ff31a-4199-402f-b234-167f71d87fa6@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 15:08 +0200, Paolo Abeni wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On 7/13/26 4:32 PM, Jens Emil Schulz =C3=98stergaard wrote:
> > Add the LAN9645X basic DSA driver with initialization, parent regmap
> > requests, port module initialization for NPI, CPU ports and front ports=
,
> > and phylink integration for MAC side configuration.
> >=20
> > This patch only wires up the internal CuPHYs (ports 0-4) and the RGMII
> > paths for ports 7 and 8. The supported SerDes-based modes: SGMII,
> > QSGMII, 1000BASE-X and 2500BASE-X on ports 5-8 are deferred, and suppor=
t
> > will be added in follow-up patches. Port 5-6 have no usable interface
> > mode in this patch, and should not be declared in DT until SerDes
> > support lands.
> >=20
> > The intended way to bind this driver is using a parent MFD driver,
> > responsible for the register IO protocol, and distributing regmaps to
> > child devices. The goal is to use the same approach as the MFD driver i=
n
> > drivers/mfd/ocelot-spi.c.
> >=20
> > This driver expects to request named regmaps from a parent device. This
> > approach is similar to the DSA driver
> >=20
> > drivers/net/dsa/ocelot/ocelot_ext.c
> >=20
> > which supports being driven by an external CPU via SPI with parent
> > device drivers/mfd/ocelot-spi.c.
> >=20
> > The MFD driver will come in a later series, because there are
> > requirements on the number of child devices before a driver qualifies a=
s
> > a MFD device.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> > Changes in v9:
> > - Drop the DEV4 RGMII muxing support.
> >=20
> > Changes in v8:
> > - Remove the CPU_PORT macro, which named the chips internal CPU port
> >   module and collided with the DSA CPU port terminology. Reference the
> >   module as lan9645x->num_phys_ports.
> > - Rework the port map comment to distinguish the chip CPU port modules
> >   (indices 9-10) from the DSA CPU port (the NPI front port).
> > - Derive PGID_GP_START from NUM_PHYS_PORTS instead of CPU_PORT.
> > - Add a port_mux_lock mutex to serialize port mux arbitration in
> >   lan9645x_phylink_mac_prepare().
> >=20
> > Changes in v7:
> > - use cpu queue LAN9645X_CPUQ_TRAP for bpdu frames
> >=20
> > Changes in v5:
> > - remove dd_dis and tsn_dis, and add SKU supported port validation
> >   during setup
> > - phylink: remove MAC_2500FD
> > - phylink: add comment about empty supported_interfaces for port 5-6.
> > - phylink: fix 2:1 rgmii port muxing for port module 4 and 7 to be full=
y
> >   dynamic and validate requested mux settings.
> > - phylink: add comment about 2:1 rgmii port muxing for port module 4
> >   and 7.
> > - rx/tx-internal-delay-ps checked against support 2ns value
> > - update commit message
> > - init lan9645x->npi =3D -1 at probe and check port < 0 in npi_deinit
> >=20
> > Changes in v4:
> > - add comment to QSYS_RES_CFG configuration
> > - phylink_mac_prepare: fix to make sure we can dynamically change rgmii
> >   on port 4
> > - move ports allocation to probe
> > - tag_npi_setup: reject cascaded setups
> > - skip WARN_ON in lan9645x_to_port
> >=20
> > Changes in v3:
> > - move DEV_MAC_TAGS_CFG config to port setup, for vlan overhead in port
> >   frame maxlen
> > - remove code disabling ipv6 on conduit
> > - use of_property_read_u32 for {rx,tx}-internal-delay-ps
> > - use dsa_user_ports(ds) instead of
> >   GENMASK(lan9645x->num_phys_ports - 1, 0) as base flood mask.
> > - update obey vlan comment
> >=20
> > Changes in v2:
> > - source Kconfig from drivers/net/dsa/Kconfig
> > - sorting in Kconfig and Makefiles
> > - remove unused struct fields
> > - remote path delays
> > - use port_setup and dp->dn instead of DTS parsing
> > - phylink: split rgmii setup into dll and speed config
> > - phylink: remove pcs/sgmii/qsgmii related code
> > - phylink: simplify mac_prepare
> > - phylink: remove phylink_ops wrappers
> > - phylink: remove unrelated config from link up
> > - phylink: reorder functions according to phylink call order
> > ---
> >  drivers/net/dsa/Kconfig                            |   2 +
> >  drivers/net/dsa/microchip/Makefile                 |   1 +
> >  drivers/net/dsa/microchip/lan9645x/Kconfig         |  11 +
> >  drivers/net/dsa/microchip/lan9645x/Makefile        |   8 +
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 447 +++++++++++++=
++++++++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h | 332 +++++++++++++=
++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |  85 ++++
> >  .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  | 382 +++++++++++++=
+++++
> >  drivers/net/dsa/microchip/lan9645x/lan9645x_port.c | 214 ++++++++++
> >  9 files changed, 1482 insertions(+)
> >=20
> > diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> > index 4ab567c5bbaf..91431ef6c425 100644
> > --- a/drivers/net/dsa/Kconfig
> > +++ b/drivers/net/dsa/Kconfig
> > @@ -72,6 +72,8 @@ config NET_DSA_MV88E6060
> >=20
> >  source "drivers/net/dsa/microchip/Kconfig"
> >=20
> > +source "drivers/net/dsa/microchip/lan9645x/Kconfig"
> > +
> >  source "drivers/net/dsa/mv88e6xxx/Kconfig"
> >=20
> >  source "drivers/net/dsa/mxl862xx/Kconfig"
> > diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/micro=
chip/Makefile
> > index 9347cfb3d0b5..e75f17888f75 100644
> > --- a/drivers/net/dsa/microchip/Makefile
> > +++ b/drivers/net/dsa/microchip/Makefile
> > @@ -12,3 +12,4 @@ endif
> >  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C)  +=3D ksz9477_i2c.o
> >  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_SPI)              +=3D ksz_spi.o
> >  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI)  +=3D ksz8863_smi.o
> > +obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X)     +=3D lan9645x/
> > diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig b/drivers/net/d=
sa/microchip/lan9645x/Kconfig
> > new file mode 100644
> > index 000000000000..4d9fdf34104e
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
> > @@ -0,0 +1,11 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +config NET_DSA_MICROCHIP_LAN9645X
> > +     tristate "Microchip Lan9645x switch support"
> > +     depends on NET_DSA
> > +     select NET_DSA_TAG_LAN9645X
> > +     help
> > +       This driver adds DSA support for Microchip Lan9645x switch chip=
s.
> > +       The lan9645x switch is a multi-port Gigabit AVB/TSN Ethernet Sw=
itch
> > +       with five integrated 10/100/1000Base-T PHYs. In addition to the
> > +       integrated PHYs, it supports up to 2 RGMII/RMII, up to 2
> > +       BASE-X/SERDES/2.5GBASE-X and one Quad-SGMII/Quad-USGMII interfa=
ces.
> > diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/=
dsa/microchip/lan9645x/Makefile
> > new file mode 100644
> > index 000000000000..7cc0ae0ada40
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/Makefile
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) +=3D mchp-lan9645x.o
> > +
> > +mchp-lan9645x-objs :=3D \
> > +     lan9645x_main.o \
> > +     lan9645x_npi.o \
> > +     lan9645x_phylink.o \
> > +     lan9645x_port.o \
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > new file mode 100644
> > index 000000000000..b253813518c2
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -0,0 +1,447 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/* Copyright (C) 2026 Microchip Technology Inc.
> > + */
> > +
> > +#include <linux/platform_device.h>
> > +
> > +#include "lan9645x_main.h"
> > +
> > +static const char *lan9645x_resource_names[NUM_TARGETS + 1] =3D {
> > +     [TARGET_GCB]          =3D "gcb",
> > +     [TARGET_QS]           =3D "qs",
> > +     [TARGET_CHIP_TOP]     =3D "chip_top",
> > +     [TARGET_REW]          =3D "rew",
> > +     [TARGET_SYS]          =3D "sys",
> > +     [TARGET_HSIO]         =3D "hsio",
> > +     [TARGET_DEV]          =3D "dev",
> > +     [TARGET_DEV + 1]      =3D "dev1",
> > +     [TARGET_DEV + 2]      =3D "dev2",
> > +     [TARGET_DEV + 3]      =3D "dev3",
> > +     [TARGET_DEV + 4]      =3D "dev4",
> > +     [TARGET_DEV + 5]      =3D "dev5",
> > +     [TARGET_DEV + 6]      =3D "dev6",
> > +     [TARGET_DEV + 7]      =3D "dev7",
> > +     [TARGET_DEV + 8]      =3D "dev8",
> > +     [TARGET_QSYS]         =3D "qsys",
> > +     [TARGET_AFI]          =3D "afi",
> > +     [TARGET_ANA]          =3D "ana",
> > +     [NUM_TARGETS]         =3D NULL,
> > +};
> > +
> > +static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
> > +{
> > +     struct dsa_port *dp, *first_cpu_dp =3D NULL;
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +     dsa_switch_for_each_user_port(dp, ds) {
> > +             if (dp->cpu_dp->ds !=3D ds) {
> > +                     dev_err(ds->dev,
> > +                             "NPI port on a remote switch is not suppo=
rted\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (first_cpu_dp && dp->cpu_dp !=3D first_cpu_dp) {
> > +                     dev_err(ds->dev, "Multiple NPI ports not supporte=
d\n");
> > +                     return -EINVAL;
> > +             }
> > +
> > +             first_cpu_dp =3D dp->cpu_dp;
> > +     }
> > +
> > +     if (!first_cpu_dp)
> > +             return -EINVAL;
> > +
> > +     lan9645x_npi_port_init(lan9645x, first_cpu_dp);
> > +
> > +     return 0;
> > +}
> > +
> > +static enum dsa_tag_protocol lan9645x_get_tag_protocol(struct dsa_swit=
ch *ds,
> > +                                                    int port,
> > +                                                    enum dsa_tag_proto=
col tp)
> > +{
> > +     return DSA_TAG_PROTO_LAN9645X;
> > +}
> > +
> > +static void lan9645x_teardown(struct dsa_switch *ds)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +
> > +     lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> > +}
> > +
> > +static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int ne=
w_mtu)
> > +{
> > +     return lan9645x_port_set_maxlen(ds->priv, port, new_mtu);
> > +}
> > +
> > +static int lan9645x_get_max_mtu(struct dsa_switch *ds, int port)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     int max_mtu;
> > +
> > +     /* Actual MAC max MTU is around 16KB. We set 10000 - overhead whi=
ch
> > +      * should be sufficient for all jumbo frames. Larger frames can c=
ause
> > +      * problems especially with flow control, since we only have 160K=
 queue
> > +      * buffer.
> > +      */
> > +     max_mtu =3D 10000 - ETH_HLEN - ETH_FCS_LEN;
> > +
> > +     if (port =3D=3D lan9645x->npi) {
> > +             max_mtu -=3D LAN9645X_IFH_LEN;
> > +             max_mtu -=3D LAN9645X_LONG_PREFIX_LEN;
> > +     }
> > +
> > +     return max_mtu;
> > +}
> > +
> > +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> > +{
> > +     int val =3D 0;
> > +     int err;
> > +
> > +     lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
> > +     lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);
> > +     err =3D lan9645x_rd_poll_timeout(lan9645x, SYS_RAM_INIT, val,
> > +                                    SYS_RAM_INIT_RAM_INIT_GET(val) =3D=
=3D 0);
> > +     if (err) {
> > +             dev_err(lan9645x->dev, "Failed to init chip RAM.\n");
> > +             return err;
> > +     }
> > +     lan_wr(SYS_RESET_CFG_CORE_ENA_SET(1), lan9645x, SYS_RESET_CFG);
> > +
> > +     return 0;
> > +}
> > +
> > +static int lan9645x_setup(struct dsa_switch *ds)
> > +{
> > +     struct lan9645x *lan9645x =3D ds->priv;
> > +     struct device *dev =3D lan9645x->dev;
> > +     int supported, used =3D 0;
> > +     struct dsa_port *dp;
> > +     u32 front_ports;
> > +     int err;
> > +
> > +     lan9645x->num_phys_ports =3D ds->num_ports;
> > +     front_ports =3D dsa_user_ports(ds);
> > +     supported =3D lan9645x->num_phys_ports - lan9645x->num_port_dis;
> > +
> > +     dsa_switch_for_each_available_port(dp, ds)
> > +             used++;
> > +
> > +     if (used > supported) {
> > +             dev_err(ds->dev,
> > +                     "%d physical ports in use in DT, SKU supports at =
most %d\n",
> > +                     used, supported);
> > +             return -EINVAL;
> > +     }
> > +
> > +     err =3D lan9645x_reset_switch(lan9645x);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D lan9645x_tag_npi_setup(ds);
> > +     if (err) {
> > +             dev_err(dev, "Failed to setup NPI port.\n");
> > +             return err;
> > +     }
> > +
> > +     /* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> > +     lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
> > +            ANA_AGGR_CFG_AC_DMAC_ENA,
> > +            lan9645x, ANA_AGGR_CFG);
> > +
> > +     /* Flush queues */
> > +     lan_wr(GENMASK(1, 0), lan9645x, QS_XTR_FLUSH);
> > +
> > +     /* Allow to drain */
> > +     usleep_range(1000, 2000);
> > +
> > +     /* All Queues normal */
> > +     lan_wr(0x0, lan9645x, QS_XTR_FLUSH);
> > +
> > +     /* Set MAC age time to default value, the entry is aged after
> > +      * 2 * AGE_PERIOD
> > +      */
> > +     lan_wr(ANA_AUTOAGE_AGE_PERIOD_SET(BR_DEFAULT_AGEING_TIME / 2 / HZ=
),
> > +            lan9645x, ANA_AUTOAGE);
> > +
> > +     /* Disable learning for frames discarded by VLAN ingress filterin=
g */
> > +     lan_rmw(ANA_ADVLEARN_VLAN_CHK_SET(1),
> > +             ANA_ADVLEARN_VLAN_CHK,
> > +             lan9645x, ANA_ADVLEARN);
> > +
> > +     /* Queue system frame ageing. We target 2s ageing.
> > +      *
> > +      * Register unit is 1024 cycles.
> > +      *
> > +      * ASIC: 165.625 Mhz  ~ 6.0377 ns period
> > +      *
> > +      * 1024 * 6.0377 ns =3D~ 6182 ns
> > +      * val =3D 2000000000ns / 6182ns
> > +      */
> > +     lan_wr(SYS_FRM_AGING_AGE_TX_ENA_SET(1) |
> > +            SYS_FRM_AGING_MAX_AGE_SET((2000000000 / 6182)),
> > +            lan9645x,  SYS_FRM_AGING);
> > +
> > +     /* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and data=
plane
> > +      * use the same masks. Control frames are redirected to CPU, and
> > +      * the network stack is responsible for forwarding these.
> > +      * The dataplane is forwarding according to the offloaded MDB ent=
ries.
> > +      */
> > +     lan_wr(ANA_FLOODING_IPMC_FLD_MC4_DATA_SET(PGID_MCIPV4) |
> > +            ANA_FLOODING_IPMC_FLD_MC4_CTRL_SET(PGID_MC) |
> > +            ANA_FLOODING_IPMC_FLD_MC6_DATA_SET(PGID_MCIPV6) |
> > +            ANA_FLOODING_IPMC_FLD_MC6_CTRL_SET(PGID_MC),
> > +            lan9645x, ANA_FLOODING_IPMC);
> > +
> > +     /* There are 8 priorities */
> > +     for (int prio =3D 0; prio < 8; ++prio)
> > +             lan_wr(ANA_FLOODING_FLD_MULTICAST_SET(PGID_MC) |
> > +                    ANA_FLOODING_FLD_UNICAST_SET(PGID_UC) |
> > +                    ANA_FLOODING_FLD_BROADCAST_SET(PGID_BC),
> > +                    lan9645x, ANA_FLOODING(prio));
> > +
> > +     /* Allow VLAN table to control whether cpu copy from the pgid tab=
le is
> > +      * enabled. Index PGID_ENTRIES is CPU src pgid, so we skip it as =
the
> > +      * configuration makes little sense here.
> > +      */
> > +     for (int i =3D 0; i < PGID_ENTRIES; ++i)
> > +             lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
> > +                    lan9645x, ANA_PGID_CFG(i));
> > +
> > +     /* Disable bridging by default */
> > +     for (int p =3D 0; p < lan9645x->num_phys_ports; p++) {
> > +             lan_wr(0, lan9645x, ANA_PGID(PGID_SRC + p));
> > +
> > +             /* Do not forward BPDU frames to the front ports and copy=
 them
> > +              * to CPU
> > +              */
> > +             lan_wr(ANA_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA,
> > +                    lan9645x, ANA_CPU_FWD_BPDU_CFG(p));
> > +     }
> > +
> > +     for (int i =3D 0; i < 16; i++) {
> > +             /* The register instance number corresponds to the
> > +              * address of the extracted frame. For instance:
> > +              * CPUQ_8021_CFG[4].CPUQ_BPDU_VAL
> > +              * is the cpu extraction queue used for BPDU frames
> > +              * with address 01-80-C2-00-00-04
> > +              */
> > +             lan_rmw(ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL_SET(LAN9645X_CPUQ=
_TRAP),
> > +                     ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL,
> > +                     lan9645x, ANA_CPUQ_8021_CFG(i));
> > +     }
> > +
> > +     /* Reserve ~1700 bytes of buffer memory per (port, prio) for sour=
ce
> > +      * tracking (resource 0, indices 0..95) and destination tracking
> > +      * (resource 2, indices 512..607). These are access watermarks, n=
ot
> > +      * pre-allocations: a flow draws from its reservation first, then
> > +      * from the shared pool. Keeping the reservation above a max-size
> > +      * Ethernet frame prevents a single frame from spilling into the
> > +      * shared pool, and cause pause frames to be emitted without actu=
al
> > +      * congestion.
> > +      */
> > +     for (int i =3D 0; i <=3D QSYS_Q_RSRV; ++i) {
> > +             lan_wr(QS_SRC_BUF_RSV / 64, lan9645x, QSYS_RES_CFG(i));
> > +             lan_wr(QS_SRC_BUF_RSV / 64, lan9645x, QSYS_RES_CFG(512 + =
i));
> > +     }
> > +
> > +     lan9645x_port_cpu_init(lan9645x);
> > +
> > +     /* Multicast to all front ports */
> > +     lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MC));
> > +
> > +     /* IP multicast to all front ports */
> > +     lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
> > +     lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
> > +
> > +     /* Unicast to all front ports */
> > +     lan_wr(front_ports, lan9645x, ANA_PGID(PGID_UC));
>=20
> Sashiko noted that the port mask here should likely include the CPU
> port, to allow correct handling of unknown unicast.
>=20
> https://sashiko.dev/#/patchset/20260713-dsa_lan9645x_switch_driver_base-v=
10-0-a4886a08fb15%40microchip.com
>=20
> For the same reason I think even multicast should be forwarded to the
> CPU port.
>=20
> There are a couple of other reports, but I think they are false positives=
.
>=20
> Note that is expected that you replies to sashiko reports on the ML.
>=20
> /P
>=20

Ok understood. I have been unsure what to do with the sashiko-dev mails, si=
nce they are
not responding to the series thread. I will reply to the mails on the sashi=
ko-reviews
list. I do think all 4 are false positives.

For the one you mention here, I have split the patches to make it easier to=
 review. The
callbacks port_fdb_add and port_mdb_add are implemented in later patches in=
 the same
series, along with port_set_host_flood for controlling forwarding of unknow=
n traffic to
the CPU.

After those patches I do not think there are issues with unknown traffic to=
 the CPU.

Thanks,
Emil

