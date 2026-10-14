Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96548592F;
	Wed, 14 Oct 2026 10:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974458; cv=none; b=I+6x6DIRezWns2RnThQp5ub3KBqN+Ddbv8waj58CYVVdejaOHsZJU0ncUlhJEAus4pjxn8h9ByuoLvALUeCqpbqAKZ5RP8gqT7PbRl6+pK5yYRahTLmMNaIBqGu7DjVBdyoP92NQsswdLKAuTfLj81tBokJ7apz9wtO1TqdXU2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974458; c=relaxed/simple;
	bh=IzcfgwfK/dbYwDmJS9r2SHQTK6Rqhjeh3z2M2uaOnQ8=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kry2xMuTcU3sGVQCpn+zpTm+qkFkR3vziRuJLB7lMVTg0mM7k5Eoq7ZA7DNYMbDD0Xsp/xhf/HWB7UZPDbNH/F4JJs03AsfE5CkekSmfUfBNaIms7YL8f4H8AjpyWCWnsrRFWom6JR5yS2iMVq3mRVMI//XzCEyo/Ngxk2jpWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CtkBxpEh; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CtkBxpEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791974456; x=1823510456;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IzcfgwfK/dbYwDmJS9r2SHQTK6Rqhjeh3z2M2uaOnQ8=;
  b=CtkBxpEhhfp2t11G7J+NB43+WlsxbMABl3uCzu/X0+39p+8RCy9dhEMk
   gymeZ320F793jd+P2a+p6nOjVvJQ7cg0y7sUXfgfiniR6Yv2h/6ry7ufi
   aTaLE1w6UhrbrPmHC4Mj34MMUa7baiYZo1etEgCfkGY/Bc/rXrsjsgcJp
   P4ebiSatwjd+0rpGSWsz8haKfPKBXJAWIl8Fyjaq5uJIpPGnpEK6DzvAN
   Y8rvZQWxauAI8x9kmDa3tCdILh1iuvKom1KvUUfnTbgmBQEM/nabgmKaF
   ZjT8QllFne/Zlvra2yXG1zQpnITKz/5SmXluAiTa0+M/3R2vkxvkQTS0U
   g==;
X-CSE-ConnectionGUID: voNT75EAQq6y2H38VlsPUA==
X-CSE-MsgGUID: ZDCbUwLpRACt7E8984bZGQ==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="75394086"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 03:40:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 03:40:54 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 03:40:50 -0700
Message-ID: <eadf65283d0f700be558ac4c3725de4fb06c085f.camel@microchip.com>
Subject: Re: [PATCH net-next v14 4/9] net: dsa: lan9645x: add basic dsa
 driver for LAN9645X
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
Date: Wed, 14 Oct 2026 12:40:49 +0200
In-Reply-To: <179180428064.434549.5154143843172991562@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-4-3d2a72661213@microchip.com>
	 <179180428064.434549.5154143843172991562@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 3
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] In lan9645x_phylink_mac_link_up()
>   (drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c),=E2=80=A6
> - [Low] lan_rd(), lan_wr() and lan_rmw() in lan9645x_main.h discard
>   regmap errors.
> - [Low] On RGMII ports, the MAC delay handling ignores phy-mode.
> - [Low] Nothing in the tree can bind this driver.
>=20
> --
>=20
> net: dsa: lan9645x: add basic dsa driver for LAN9645X
>=20
> This commit adds a basic DSA driver for the Microchip LAN9645x switch.
> It covers switch init, named regmaps obtained from a parent device,
> NPI/CPU/front port setup and phylink MAC configuration. Only the internal
> CuPHY ports 0-4 and the RGMII ports 7-8 are wired up. The SerDes modes
> and the MFD parent are left for later series.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drive=
rs/net/dsa/microchip/lan9645x/lan9645x_main.c
> > new file mode 100644
> > index 0000000000000..c7de3836e6967
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > @@ -0,0 +1,456 @@
>=20
> [ ... ]
>=20
> > +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> > +{
> > +     u32 val =3D 0;
> > +     int err;
> > +
> > +     /* The parent must reset the whole chip before instantiating its
> > +      * children, so the switch core is disabled when we get here. The
> > +      * sequence below must not run more than once: initializing the
> > +      * memories on a running core corrupts pointers inside the queue
> > +      * system, which eventually fills up and stops passing traffic. I=
f the
> > +      * core is already enabled the chip was not reset, so skip it.
> > +      */
> > +     if (SYS_RESET_CFG_CORE_ENA_GET(lan_rd(lan9645x, SYS_RESET_CFG)))
> > +             return 0;
>=20
> [Severity: Low]
> What happens here if the regmap_read() under lan_rd() fails? In
> lan9645x_main.h, lan_rd() only warns and then returns the value it was
> initialised with:
>=20
>     u32 addr, val =3D 0;
>     ...
>     WARN_ON_ONCE(regmap_read(lan_tgt2rmap(lan9645x, t, tinst), addr, &val=
));
>=20
>     return val;
>=20
> A failed read would look like CORE_ENA=3D0. The CORE_ENA=3D0 / RAM_INIT
> sequence would then run on a core that may already be enabled. The commen=
t
> above says that corrupts pointers inside the queue system. The parent is
> expected to be SPI based, like ocelot-spi, so bus errors can happen.
>=20
> The RAM_INIT write can't be checked either. lan_wr() returns void, and th=
e
> self-clearing bit already reads back as 0 if the write was lost.
>=20
> The same thing happens in two other places:
>=20
>   - lan9645x_set_feat_dis() turns a failed GCB_FEAT_DISABLE read into
>     num_port_dis =3D 0. That skips the SKU port limit check in
>     lan9645x_setup().
>=20
>   - lan9645x_port_set_maxlen() always returns 0. dsa_user_change_mtu()
>     therefore raises dev->mtu even when the DEV_MAC_MAXLEN_CFG write
>     failed.
>=20
> Could lan_rd(), lan_wr() and lan_rmw() pass the regmap error back, at lea=
st
> on these paths?
>=20
> > +
> > +     lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
> > +     lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);
>=20
> [ ... ]
>=20
> > +static int lan9645x_request_target_regmaps(struct lan9645x *lan9645x)
> > +{
> > +     const char *resource_name;
> > +     struct regmap *tgt_map;
> > +
> > +     for (int i =3D 0; i < NUM_TARGETS; i++) {
> > +             resource_name =3D lan9645x_resource_names[i];
> > +             if (!resource_name)
> > +                     continue;
> > +
> > +             tgt_map =3D dev_get_regmap(lan9645x->dev->parent, resourc=
e_name);
> > +             if (IS_ERR_OR_NULL(tgt_map)) {
> > +                     dev_err(lan9645x->dev, "Failed to get regmap=3D%s=
\n",
> > +                             resource_name);
> > +                     return -ENODEV;
> > +             }
>=20
> [Severity: Low]
> Does anything in the tree provide these regmaps?
> lan9645x_request_target_regmaps() needs all 17 named regmaps from
> dev->parent ("gcb", "qs", ..., "dev0" to "dev8", "qsys", "ana"). If any i=
s
> missing it returns -ENODEV. Nothing under drivers/mfd refers to lan9645x
> or lan96455.
>=20
> The commit message says:
>=20
>     The MFD driver will come in a later series, because there are
>     requirements on the number of child devices before a driver qualifies=
 as
>     a MFD device.
>=20
> Until that lands, the driver cannot probe on any in-tree configuration.
> Two things can't be tested in-tree:
>=20
>   - the regmap naming contract with the parent
>=20
>   - the assumption in lan9645x_reset_switch() that the parent has already
>     reset the chip
>=20
> The ocelot_ext driver cited as precedent was merged together with its
> drivers/mfd/ocelot-spi.c parent.
>=20
> Could the parent driver be merged in the same series?
>=20
> [ ... ]
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c b/dr=
ivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> > new file mode 100644
> > index 0000000000000..b57beee8329f9
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_phylink.c
> > @@ -0,0 +1,371 @@
>=20
> [ ... ]
>=20
> > +static void lan9645x_rgmii_dll_config(struct lan9645x_port *p)
> > +{
> > +     u32 rx_idx, tx_idx;
> > +
> > +     /* DLL register layout:
> > +      * (N*2):   RGMII_N_RX
> > +      * (N*2)+1: RGMII_N_TX
> > +      */
> > +     rx_idx =3D RGMII_IDX(p->chip_port) * 2;
> > +     tx_idx =3D RGMII_IDX(p->chip_port) * 2 + 1;
> > +
> > +     /* Enable DLL in RGMII clock paths, deassert DLL reset, and start=
 the
> > +      * delay tune FSM.
> > +      */
> > +     lan_rmw(HSIO_DLL_CFG_DLL_CLK_ENA_SET(1) |
> > +             HSIO_DLL_CFG_DLL_RST_SET(0) |
> > +             HSIO_DLL_CFG_DLL_ENA_SET(p->rx_internal_delay) |
> > +             HSIO_DLL_CFG_DELAY_ENA_SET(p->rx_internal_delay),
>=20
> [Severity: Low]
> Should the MAC delay here depend on the RGMII phy-mode?
> lan9645x_rgmii_dll_config() enables the RX/TX DLL delays based only on th=
e
> rx-/tx-internal-delay-ps values parsed by lan9645x_parse_mac_delay().
> dsa_port_phylink_create() passes the DT phy-mode unchanged to phylink and
> the PHY.
>=20
> The binding (microchip,lan96455s-switch.yaml) allows 2000 ps for all four
> RGMII modes, including rgmii-id. Take port 7 or 8 with an external PHY,
> phy-mode =3D "rgmii-id" and rx/tx-internal-delay-ps =3D <2000>. Both the =
MAC
> and the PHY would add 2ns.
>=20
> ethernet-controller.yaml says:
>=20
>     When the MAC implements the delay, it must
>     ensure that the PHY does not also implement the same delay. So it
>     must modify the phy-mode it passes to the PHY, removing the delay it
>     has added. Failure to remove the delay will result in a
>     non-functioning link.
>=20
> It also says:
>=20
>     A value of 2000ps, i.e 2ns, and a phy-mode
>     of 'rgmii' will not be accepted by Reviewers.
>=20
> Should the driver reject this combination, or remove the MAC-added delay
> from the phy-mode it passes to the PHY?
>=20
> [ ... ]
>=20
> > +     if (lan9645x_port_is_cuphy(lan9645x, port, interface)) {
> > +             lan_rmw(CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA_SET(gtx_clk),
> > +                     CHIP_TOP_CUPHY_PORT_CFG_GTX_CLK_ENA, lan9645x,
> > +                     CHIP_TOP_CUPHY_PORT_CFG(p->chip_port));
> > +     }
> > +
> > +     lan_rmw(SYS_PAUSE_CFG_PAUSE_ENA_SET(1),
> > +             SYS_PAUSE_CFG_PAUSE_ENA,
> > +             lan9645x, SYS_PAUSE_CFG(p->chip_port));
> > +
> > +     /* Flow control */
> > +     lan_rmw(SYS_MAC_FC_CFG_FC_LINK_SPEED_SET(fc_spd) |
> > +             SYS_MAC_FC_CFG_FC_LATENCY_CFG_SET(0x7) |
> > +             SYS_MAC_FC_CFG_ZERO_PAUSE_ENA_SET(1) |
> > +             SYS_MAC_FC_CFG_PAUSE_VAL_CFG_SET(0xffff) |
> > +             SYS_MAC_FC_CFG_RX_FC_ENA_SET(rx_pause ? 1 : 0) |
> > +             SYS_MAC_FC_CFG_TX_FC_ENA_SET(tx_pause ? 1 : 0),
>=20
> [Severity: Medium]
> Can this turn on PAUSE frame transmission on the NPI port? On link up,
> lan9645x_phylink_mac_link_up() sets PAUSE_ENA to 1 on every port.
> TX_FC_ENA follows tx_pause, with no exception for lan9645x->npi.
> lan9645x_npi_port_init() doesn't disable pause on the NPI port either.
>=20
> The NPI port has the long prefix extraction header enabled:
>=20
> lan9645x_npi_port_init()
>     lan_rmw(SYS_PORT_MODE_INCL_XTR_HDR_SET(LAN9645X_TAG_PREFIX_LONG) |
>     ...
>=20
> A PAUSE frame sent on the NPI port would get the prefix and IFH like any
> other extracted frame, so the conduit would not recognise it as PAUSE. Th=
e
> port would run in lossless mode while the link partner never honours the
> pause.
>=20
> The DT example in the lan9645x binding gives the NPI port a fixed-link
> with pause. MAC_SYM_PAUSE is advertised, so phylink resolves
> tx_pause =3D rx_pause =3D true for the documented example.
>=20
> mscc/ocelot uses the same NPI model and had this problem. It was fixed by
> commit 33cb0ff30cff ("net: mscc: ocelot: don't let phylink re-enable TX
> PAUSE on the NPI port"). That commit measured CPU termination throughput
> at 271 Mbit/s before the fix and 926 Mbit/s after.
>=20
> felix_npi_port_init() clears SYS_PAUSE_CFG_PAUSE_ENA on the NPI port, and
> ocelot_phylink_mac_link_up() does:
>=20
>     /* Don't attempt to send PAUSE frames on the NPI port, it's broken */
>     if (port !=3D ocelot->npi)
>         ocelot_fields_write(ocelot, port, SYS_PAUSE_CFG_PAUSE_ENA,
>                             tx_pause);
>=20
> This also seems to still be the case at the end of the series.
>=20
> Should PAUSE_ENA and TX_FC_ENA stay at 0 for lan9645x->npi? And should
> PAUSE_ENA follow tx_pause on the other ports?

Dismissed, false positive.

In this respect, the chip functions differently from ocelot. The issue has
been fixed. On lan9645x the MAC formats and transmits PAUSE frames
itself, after the queue system, so INCL_XTR_HDR does not apply to them
and they leave the NPI port without the prefix and IFH. Flow control on
the NPI port works as intended.

PAUSE_ENA only enables the pause request from the queue system to the
MAC. TX_FC_ENA decides whether the MAC turns it into PAUSE frames, and
RX_FC_ENA is handled by the MAC on its own. With tx_pause off no PAUSE
frames are sent and the port tail drops as usual.


>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip=
.com

