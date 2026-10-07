Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9748FF88;
	Wed,  7 Oct 2026 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383363; cv=none; b=aRWpGg+/BJ4T/xMr734q+w2HOccS6zidGI4kUO+bUPuzQtj5qUYLwDvJG9JrVO2h8rYNT+rinLO1zRBNgFjZsO7U+S4hw5z9WJengk1/2OWH445O8UXovRShyrlbO8dRnxMqDv2IikD2Lve+qDJWjKspG6FzLdhYE7WIO5gMcAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383363; c=relaxed/simple;
	bh=ji0Ea4gf07hlWO9VngK2StEqx5iVuENiFLVyL4ysbQA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQbceRf5HN69H4jZ/499ApnGL/hdLt53T6VSKl/eEbeN6Kz7Xszet9vscA1aSkc1IraExwBi5fOvfZ9b/7hG95yviSd0w/JGKvBoIEbuphwwZvmTXbCnY/OvqfP1JLHst+UkB9KNQdu3BKY8G5jb54GtegKyL59kiJyyoW7Ntso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jZG3tSKR; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jZG3tSKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791383356; x=1822919356;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ji0Ea4gf07hlWO9VngK2StEqx5iVuENiFLVyL4ysbQA=;
  b=jZG3tSKRFIccpdJbMzYMnE6kV9++SD1RiR5QcXVoMGUTGYWf2LDvVtxQ
   cUtxUPPPkWElgqAqvT7Kb5LBckyrztnxwCZYiBiokCk1EK8HSCR+4ZXEj
   wiQUhZ25EerHxmDX0pWV20eeoR4cqN/zY7Oh+Zs4TF8PSmgqu30r+nwAR
   GSEBNa1LuIHQKn81bfWuJUbP9crK6WpA9HJzW8fE1DfsoJdCf8eHc11Ao
   DqqmEUxQn3f6Fih0KCf3KLc5odJB5nKeWhaLiEctnvfqrswF2lZMHbo9o
   lYzDa5oXV2meBDVEcj1/y52aHkuJfaagShI8jlCuzejs3eCExfbBZiB3r
   g==;
X-CSE-ConnectionGUID: bpAL12EnSIyGMrGkYRvvXw==
X-CSE-MsgGUID: sryc8U6AQ62tMFwV1yqDJA==
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="74988234"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 07:29:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Wed, 7 Oct 2026 07:29:09 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 7 Oct 2026 07:29:05 -0700
Message-ID: <f37288168c35a3bcb59f29af0abec3c5f43042fe.camel@microchip.com>
Subject: Re: [PATCH net-next v13 9/9] net: dsa: lan9645x: add port statistics
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
Date: Wed, 7 Oct 2026 16:29:05 +0200
In-Reply-To: <179097566660.434549.17651613804901292493@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-9-827c2d3617f2@microchip.com>
	 <179097566660.434549.17651613804901292493@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 3 =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] lan9645x_stats_get_sset_count() returns -EOPNOTSUPP (-95) for
>   every string set other than ETH_SS_STATS.
> - [Medium] lan9645x_stats_get_stats64() counts bad frames in rx_packets.
> - [Medium] The eMAC and pMAC FRAG counters are handled inconsistently.
> - [Low] The commit message says 'The eMAC and pMAC counter sources are
>   decoded, but only the aggregate source is reachable for now'.
>=20
> --
>=20
> net: dsa: lan9645x: add port statistics
>=20
> This adds port counter support to the lan9645x DSA driver. The 32 bit
> hardware counters are copied into 64 bit software counters by a poller
> that runs every three seconds. They are reported through ethtool -S, the
> standard ethtool statistics groups and ndo_get_stats64.
>=20
> > The eMAC and pMAC counter sources are decoded, but only the aggregate
> > source is reachable for now, until MAC merge support is added.
>=20
> [Severity: Low]
> Is this sentence still accurate? None of these read the ->src field of th=
e
> structure they fill in:
>=20
>   lan9645x_stats_get_eth_mac_stats()
>   lan9645x_stats_get_rmon_stats()
>   lan9645x_stats_get_pause_stats()
>   lan9645x_stats_get_eth_phy_stats()
>   lan9645x_stats_get_eth_ctrl_stats()
>=20
> All of them always return the eMAC plus pMAC sum.
>=20
> The v12 changelog says "Drop the unreachable mac merge related code", so
> the per-source decoding seems to have been removed. This has no runtime
> effect today, because without .get_mm ethtool only allows the aggregate
> source.
>=20
> Could the message say instead that the pMAC counters are summed into the
> aggregate, and that per-source reporting is not implemented yet?
>=20

Correct, the sentence was left over from before the per-source code was
dropped. v14 says that the pMAC counters are summed into the aggregate
source, and that per-source reporting is not implemented yet.


> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c b/driv=
ers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > new file mode 100644
> > index 0000000000000..1253f77489931
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > @@ -0,0 +1,856 @@
>=20
> [ ... ]
>=20
> > +int lan9645x_stats_get_sset_count(struct lan9645x *lan9645x, int port,=
 int sset)
> > +{
> > +     if (sset !=3D ETH_SS_STATS)
> > +             return -EOPNOTSUPP;
>=20
> [Severity: Medium]
> Can this negative return value corrupt the sset counts that the conduit
> netdev reports? DSA replaces the conduit's get_sset_count with
> dsa_conduit_get_sset_count(). For every sset, that function calls:
>=20
> net/dsa/conduit.c:dsa_conduit_append_port_sset_count() {
>         if (ds->ops->get_sset_count)
>                 *count +=3D ds->ops->get_sset_count(ds, port, sset);
> }
>=20
> Nothing checks for a negative value. For ETH_SS_TEST, ETH_SS_PRIV_FLAGS
> and ETH_SS_PHY_STATS, the conduit therefore reports its own count minus
> 95.
>=20
> If the conduit has fewer than 95 entries, the count is negative. Then
> ethtool -t, the netlink priv-flags path and ETHTOOL_GSTRINGS on the
> conduit fail with a bogus errno. The conduit's self-tests and private
> flags also drop out of ethtool -i and the netlink strset reply.
>=20
> If the conduit has 95 or more entries, the result is zero or a smaller
> positive value. ethtool_self_test(), ethtool_get_phy_stats_ethtool() and
> strset_prepare_set() size their buffers from that value, but the
> conduit's own callbacks still write their full number of entries. No real
> NIC has that many entries, so this part is theoretical.
>=20
> Most other DSA drivers (hellcreek, lan9303, gswip, mt7530, qca8k, a5psw,
> vsc73xx, and others) return 0 for unsupported ssets. Should this return 0
> as well?
>=20


Correct, v14 returns 0 for the other string sets, as other DSA drivers
do.

> > +
> > +     return ARRAY_SIZE(lan9645x_port_ethtool_stats);
> > +}
>=20
> [ ... ]
>=20
> > +     r->undersize_pkts =3D c[SCNT_RX_SHORT] +
> > +                         c[SCNT_RX_PMAC_SHORT];
> > +     r->oversize_pkts =3D c[SCNT_RX_LONG] +
> > +                        c[SCNT_RX_PMAC_LONG];
> > +     /* SCNT_RX_FRAG counts frames received after the port is paused, =
and
> > +      * increments when pause frames arrive from the link partner.
> > +      * It counts neither undersize frames nor errors, so it is left o=
ut here
> > +      * and out of rx_packets, unlike lan966x which adds it to rx_erro=
rs.
> > +      * SCNT_RX_PMAC_FRAG does count number of runt frames with invali=
d CRC.
> > +      */
> > +     r->fragments =3D c[SCNT_RX_PMAC_FRAG];
>=20
> [Severity: Medium]
> Can fragments be non-zero without MAC merge support? The pMAC receives no
> traffic until MAC merge is supported, so RMON fragments always reads 0 in
> lan9645x_stats_get_rmon_stats(). That includes the case where runts with
> a bad CRC arrive on the eMAC.
>=20
> Documentation/networking/statistics.rst says drivers should leave fields
> they do not report at ETHTOOL_STAT_NOT_SET, not overwrite them with 0. If
> no accurate eMAC fragment count exists, would it be better to leave
> fragments unset?
>=20
> The two MACs are also treated differently in lan9645x_stats_get_stats64()=
.
> rx_packets includes c[SCNT_RX_PMAC_FRAG] but not c[SCNT_RX_FRAG]. As a
> result, a bad-CRC runt is counted in rx_packets only when the pMAC
> receives it.
>=20
> Does the hardware really use different meanings for the counters at
> offset 0x5 and offset 0x35, which is the same position in the pMAC block?
> If not, could both MACs be handled the same way?
>=20

The two counters do differ in hardware. c_rx_frag (0x05) counts runts
with an invalid CRC only on half-duplex links, on full-duplex links it
counts frames received after the port is paused and increments on
received pause frames. c_rx_pmac_frag (0x35) always counts runts with an
invalid CRC. That is also why only the pMAC counter is part of
rx_packets. I will leave RMON fragments unset, since reporting fragments
from the pMAC alone is misleading


> [ ... ]
>=20
> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +                             struct rtnl_link_stats64 *stats)
> > +{
>=20
> [ ... ]
>=20
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
>=20
> [Severity: Medium]
> Should rx_packets include SCNT_RX_SHORT, SCNT_RX_JABBER and SCNT_RX_LONG,
> and their pMAC equivalents? The same function counts all of them in
> rx_errors below, and counts JABBER and LONG in rx_length_errors too.
>=20
> include/uapi/linux/if_link.h describes rx_packets as "Number of good
> packets received by the interface".
>=20
> The SZ_* buckets also include frames with a bad FCS. The v5 changelog
> says: "remove rx_crc, rx_symbol_err from rx_packets, as they are already
> counted in SZ_* buckets".
>=20
> So when a link partner sends a runt, jabber, oversized or bad-FCS frame,
> it shows up in both rx_packets and rx_errors. ocelot and lan966x use a
> similar formula.
>=20
> Would the RX_UC, RX_MC and RX_BC good frame counters, which already feed
> FramesReceivedOK, be a better source here?

Dismissed, intentional. This follows mscc/ocelot, which computes
rx_packets the same way. The hardware has no good-frames-only octet
counter, c_rx_oct counts octets in good and bad frames, so rx_bytes
cannot follow the uapi description either. rx_packets is therefore made
to count the same frames rx_bytes counts octets for: the size buckets
cover good and bad frames from 64 bytes up to MAXLEN, and short, jabber
and long frames fall outside that range, so every received frame is
counted exactly once. Bad frames are also reported in rx_errors.


>=20
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
>=20
> [ ... ]
>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com

