Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801CB3C1D7B;
	Wed, 14 Oct 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791977773; cv=none; b=njBcflOqo86Bso3iQ8ZXg7/nDXIIDz+d+VsjhGh4QUTeS+e6qwGBaG0FbikPDAnPTzfK+YkPZYQaEOrY2BmX3TeGLOy467bagawQJSYbrLqCbwggZ9YAoS5wyzH94Jc621uolkSsRcakeLcsCTxqrR71Ny+OZasl70VLNNTynlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791977773; c=relaxed/simple;
	bh=G3+BwTQMQIIo+pZvUQsXZ2mhLhJzgxm9PN6ac1jR4Z0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EjLZ5Bq3LDqrZyK3bIV91PoJAA+/UQztcok3F2aMAquqqbDz4EVoqkFwUpwfettaeIJy2WKLEwBWAVKUWTFMDwMskGa5/jC8dazbMqamW/O98sUL9mMmJNg4pAMWKnxN1npdgs7byqkry6bVOFLcGyQ+8ZH8zAcrxXmMCwOIXzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=SfBdOf0Z; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="SfBdOf0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791977777; x=1823513777;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=G3+BwTQMQIIo+pZvUQsXZ2mhLhJzgxm9PN6ac1jR4Z0=;
  b=SfBdOf0Z7mTqJdVJxSZQhvaUJKbYS1Cy99wRvV4QowHoKggbbRxIvo8d
   Bct9xEO7fD0s40xTZvhQDoKmQCVljYn3uiTLi2PCKzMe0Vn8tjc2IpRPt
   7QB5AuMqqRvgmMAGx/7Kv6S90LE6hvkvvqNCanoRIM63azc8Qqepsg0s1
   xX5kPnuqFUPZoMjsh+YsmR5mDCoOWa+nIqttY1+di5fAJ9NKOmm3d3MbQ
   5c/U6vb90BH1Q2Uop5J/8wpVlAobFp/RfVpzy6gj6xblhtI+J6CTRlbfx
   pP/MPpEcdNVMWJzpTfqu0OhUQJqSJI7G1cOxILy8UaiEAdIjg9Mn6whla
   g==;
X-CSE-ConnectionGUID: z9bJHHOMQZaV62hi/jbfKQ==
X-CSE-MsgGUID: eMmMYA9QSTa0veDcAuUJ3w==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="296439960"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2026 04:36:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 14 Oct 2026 04:36:09 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 04:36:05 -0700
Message-ID: <c30e7704a5f0bbc7c064bd78c09effc79a9e755c.camel@microchip.com>
Subject: Re: [PATCH net-next v14 9/9] net: dsa: lan9645x: add port statistics
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
Date: Wed, 14 Oct 2026 13:36:05 +0200
In-Reply-To: <179180428793.434549.2970303377957273063@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-9-3d2a72661213@microchip.com>
	 <179180428793.434549.2970303377957273063@kernel.org>
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
> - [Medium] lan9645x_stats_get_stats64() counts bad frames in
>   rtnl_link_stats64.rx_packets.
> - [Low] In lan9645x_stats_get_stats64(), rx_errors is the sum
>   c[SCNT_RX_SHORT] + c[SCNT_RX_JABBER] + c[SCNT_RX_CRC] +=E2=80=A6
> - [Low] __lan9645x_stats_view_idx_hw_read() selects the port with
>   lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx), lan9645x, SYS_STAT_CFG).
>=20
> --
>=20
> net: dsa: lan9645x: add port statistics
>=20
> This commit adds port statistics support to the lan9645x DSA driver. A
> delayed work polls the 32-bit hardware counters every 3 seconds and
> accumulates them into 64-bit software counters. The counters are exposed
> through ethtool -S, the standard ethtool stats groups and get_stats64, wi=
th
> the pMAC counters summed into the aggregate source.
>=20
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > new file mode 100644
> > index 0000000000000..a21afb4d98532
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > @@ -0,0 +1,854 @@
>=20
> [ ... ]
>=20
> > +static void lan9645x_stats_update_counter(u64 *sw, u32 hw)
> > +{
> > +     if (hw < (*sw & U32_MAX))
> > +             *sw +=3D (u64)1 << 32; /* value has wrapped */
> > +
> > +     *sw =3D (*sw & ~(u64)U32_MAX) + hw;
> > +}
> > +
> > +static int __lan9645x_stats_view_idx_hw_read(struct lan9645x *lan9645x=
,
> > +                                          enum lan9645x_view_stat_type=
 vtype,
> > +                                          int idx)
> > +{
>=20
> [ ... ]
>=20
> > +     lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx), lan9645x, SYS_STAT_CFG);
>=20
> [Severity: Low]
> What happens to the counters if this lan_wr() fails?
>=20
> lan_wr() returns void and only does WARN_ON_ONCE(regmap_write(...)), so
> this function never sees a failed STAT_VIEW select. The SYS_CNT window
> read by the lan_bulk_rd() calls below is the same for every port. If the
> reads still succeed, buf holds the counters of the previously selected
> port.
>=20
> __lan9645x_stats_view_idx_transfer() then passes those values through
> lan9645x_stats_update_counter() into the requested port's shadow. If the
> wrong value is larger, the shadow takes it. On the next correct poll,
> this check:
>=20
>         if (hw < (*sw & U32_MAX))
>                 *sw +=3D (u64)1 << 32; /* value has wrapped */
>=20
> adds 2^32. That counter then stays about 4G too high until the next
> setup.
>=20
> lan9645x_stats_clear_view() has the same unchecked write:
>=20
>         lan_wr(SYS_STAT_CFG_STAT_VIEW_SET(idx) |
>                SYS_STAT_CFG_STAT_CLEAR_SHOT_SET(groups),
>                lan9645x, SYS_STAT_CFG);
>=20
> If that write is dropped, the poll for !CLEAR_SHOT passes at once and a
> clear that never happened is reported as success. That case looks
> harmless, since the shadow later takes the uncleared hardware value.
>=20
> ocelot_port_update_stats() follows the same pattern, and every other
> lan_wr() in this driver also ignores write errors. Fixing this would
> probably mean having the helper return the regmap_write() result.
>=20
> > +
> > +     /* Each region for this index contains counters which are at sequ=
ential
> > +      * addresses, so we can use bulk reads to ease lock pressure a bi=
t.
> > +      */
> > +     for (int r =3D 0; r < vstats->num_regions; r++) {
> > +             region =3D vstats->regions[r];
> > +             err =3D lan_bulk_rd(&vstats->buf[region.cnts_base_idx],
> > +                               region.cnt, lan9645x,
> > +                               SYS_CNT(region.base_offset));
>=20
> [ ... ]
>=20
> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +                             struct rtnl_link_stats64 *stats)
> > +{
>=20
> [ ... ]
>=20
> > +     stats->rx_bytes =3D c[SCNT_RX_OCT] + c[SCNT_RX_PMAC_OCT];
> > +
> > +     stats->rx_packets =3D c[SCNT_RX_SHORT] +
> > +                         c[SCNT_RX_JABBER] +
> > +                         c[SCNT_RX_SZ_64] +
> > +                         c[SCNT_RX_SZ_65_127] +
> > +                         c[SCNT_RX_SZ_128_255] +
> > +                         c[SCNT_RX_SZ_256_511] +
> > +                         c[SCNT_RX_SZ_512_1023] +
> > +                         c[SCNT_RX_SZ_1024_1526] +
> > +                         c[SCNT_RX_SZ_JUMBO] +
> > +                         c[SCNT_RX_LONG] +
> > +                         c[SCNT_RX_PMAC_SHORT] +
> > +                         c[SCNT_RX_PMAC_FRAG] +
> > +                         c[SCNT_RX_PMAC_JABBER] +
> > +                         c[SCNT_RX_PMAC_SZ_64] +
> > +                         c[SCNT_RX_PMAC_SZ_65_127] +
> > +                         c[SCNT_RX_PMAC_SZ_128_255] +
> > +                         c[SCNT_RX_PMAC_SZ_256_511] +
> > +                         c[SCNT_RX_PMAC_SZ_512_1023] +
> > +                         c[SCNT_RX_PMAC_SZ_1024_1526] +
> > +                         c[SCNT_RX_PMAC_SZ_JUMBO] +
> > +                         c[SCNT_RX_PMAC_LONG];
>=20
> [Severity: Medium]
> Should rx_packets include the error counters?
>=20
> The rtnl_link_stats64 documentation in include/uapi/linux/if_link.h
> describes rx_packets as "Number of good packets received by the
> interface". It describes rx_errors as "Total number of bad packets
> received on this network device".
>=20
> SCNT_RX_SHORT, SCNT_RX_JABBER and SCNT_RX_LONG, plus their pMAC
> versions, are added to both rx_packets and rx_errors. Each runt, jabber
> and oversize frame is therefore counted as good and as bad.
>=20
> The SZ_* buckets also seem to include CRC-errored frames. The v5
> changelog removed rx_crc from rx_packets "as they are already counted in
> SZ_* buckets". So rx_packets ends up counting every frame received.
>=20
> This also does not match FramesReceivedOK in
> lan9645x_stats_get_eth_mac_stats(), which is UC + MC + BC. The two
> standard interfaces would report different good RX counts for the same
> port.
>=20
> ocelot_port_get_stats64() uses a similar formula. Is that the intended
> meaning of rx_packets for this new driver?
>=20
> Separately, c[SCNT_RX_PMAC_FRAG] is added to rx_packets but not to
> rx_errors, while c[SCNT_RX_PMAC_SHORT] is added to both. The comment in
> lan9645x_stats_get_rmon_stats() says SCNT_RX_PMAC_FRAG counts runts with
> an invalid CRC.
>=20
> Should SCNT_RX_PMAC_FRAG go into rx_errors too, or be removed from
> rx_packets? This has no effect until MAC merge sends traffic to the pMAC.
>=20

Dismissed, intended.

As for v14, this follows mscc/ocelot, which computes rx_packets the
same way. The hardware has no good-frames-only octet counter, rx_oct
counts octets in good and bad frames, so rx_bytes cannot follow the
uapi description either. rx_packets is made to count the same frames
rx_bytes counts octets for: the size buckets cover good and bad frames
from 64 bytes up to MAXLEN, and short, fragment, jabber and long frames
fall outside that range, so every received frame is counted once. Bad
frames are also reported in rx_errors.

FramesReceivedOK is the 802.3 good frame count and is meant to differ,
as it does in ocelot, where it is the sum of the green counters.

SCNT_RX_PMAC_FRAG is the size class below 64 bytes for pMAC runts with
an invalid CRC, so it belongs in rx_packets next to the size buckets.
Its frames are already in rx_errors through SCNT_RX_PMAC_CRC, which
counts CRC errors at any frame size, in the same way a frame of 64
bytes or more with a bad CRC sits in a size bucket and in
SCNT_RX_CRC. Adding it to rx_errors would count those runts twice.



> > +
> > +     stats->multicast =3D c[SCNT_RX_MC] + c[SCNT_RX_PMAC_MC];
> > +
> > +     stats->rx_errors =3D c[SCNT_RX_SHORT] +
> > +                        c[SCNT_RX_JABBER] +
> > +                        c[SCNT_RX_CRC] +
> > +                        c[SCNT_RX_LONG] +
> > +                        c[SCNT_RX_PMAC_SHORT] +
> > +                        c[SCNT_RX_PMAC_JABBER] +
> > +                        c[SCNT_RX_PMAC_CRC] +
> > +                        c[SCNT_RX_PMAC_LONG];
> > +
> > +     stats->rx_length_errors =3D c[SCNT_RX_JABBER] +
> > +                               c[SCNT_RX_LONG] +
> > +                               c[SCNT_RX_PMAC_JABBER] +
> > +                               c[SCNT_RX_PMAC_LONG];
> > +
> > +     /* SCNT_RX_CRC counts CRC errors, alignment errors and RX_ER even=
ts at
> > +      * any frame size, so a short frame with a bad CRC is counted her=
e.
> > +      */
> > +     stats->rx_crc_errors =3D c[SCNT_RX_CRC] + c[SCNT_RX_PMAC_CRC];
>=20
> [Severity: Low]
> Is a jabber frame counted twice in rx_errors?
>=20
> This comment says SCNT_RX_CRC counts CRC errors "at any frame size". The
> v12 changelog describes SCNT_RX_JABBER as "the too-long-with-bad-CRC half
> of the event".
>=20
> If both are true, an oversize frame with a bad FCS increments both
> SCNT_RX_CRC and SCNT_RX_JABBER. rx_errors above adds the two together.
>=20
> If the hardware keeps these two counters disjoint, is the "any frame
> size" wording in this comment accurate?
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip=
.com

