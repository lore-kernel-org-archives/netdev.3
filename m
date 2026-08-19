Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9D63A9624;
	Wed, 19 Aug 2026 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145969; cv=none; b=F8OJ6gBtQjbzypSCy+SXj2ejKkwQNMPRD+jDAlgvJq/be53mVKGKBlk7tJ1WLMstvwo7Z7l2z/g/Ee/r17p1C3g8x58LJ/dk9FHO/OYsG/AW8BeLWPU8CKW5QUhXg5j0c18XbTc2poHR7N1WN582+QJxo0YgVKeBDhDMcalIxUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145969; c=relaxed/simple;
	bh=EXhMoCV2/nQgvQ0JMfjK+XVRM5uuatqQhr5/VSeJU/0=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQgmDbAadmfqxEPfwn07mVRiwJbFFPKgOHSzyhPEvcI3pSakqvD8CcahuU4P2BcimfwAH1iOZIOilk/7KMK9WpwOmch8DKFO+k+kG28e++ZF16p5qCL3Z96S6OZSvaHrseAo5LrK0pQJPc0ssDnZVHIxJJGwmtsOCtiIVtz7Cuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aGjSeZm6; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aGjSeZm6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1787145965; x=1818681965;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=EXhMoCV2/nQgvQ0JMfjK+XVRM5uuatqQhr5/VSeJU/0=;
  b=aGjSeZm6x+mjsA6NCD9DfbD+LMLpq2WIsAPuCwYRpTJEYS+GMCWEiejh
   LokOhuf9WHZlHWVvk4wyzlmh2C33Bnrm0W7IBvb4gAudmZIndeoOHRQCx
   f8WC1/rXes/Ir5POECpkaGa8L+TJ4S0eRUXIOvpfsJGkes6D6XFag/tOf
   DjN5B07sEn/Jazs8i9FmKPsOfi7xJxhiURV2mcNTuL6JmN6qsycFKugHs
   uGkYi+Zc7hywAyeZd/G7Ulx55dgy0Je2v12U8MM5VjsxQSQ0tZxznv9VV
   hjTqzJovNDPn4wiLVNqN0/N4+lK8k+H9IFlN4iJ5CN51/9PhQTPR4C5xg
   w==;
X-CSE-ConnectionGUID: SsK9zpVCTY6/3ZIfcVR9SA==
X-CSE-MsgGUID: J9+M/d8dQ9GOasnQHHY3xA==
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="61464328"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Aug 2026 06:26:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 19 Aug 2026 06:26:01 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 19 Aug 2026 06:25:58 -0700
Message-ID: <3e4122bb1493a92f6db61d313fc0627a639cbbd4.camel@microchip.com>
Subject: Re: [PATCH net-next v11 9/9] net: dsa: lan9645x: add port statistics
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
Date: Wed, 19 Aug 2026 15:25:57 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-9-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-9-007ebc983a0a@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

This is a reply to:
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260805-dsa_lan9645x_s=
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D9

> --- Patch [9]: [PATCH net-next v11 9/9] net: dsa: lan9645x: add port stat=
istics ---
> commit 237edd60065db45a5dc8339c001c3205645d61b0
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: lan9645x: add port statistics
>
> This adds a new lan9645x_stats unit which exposes the per-port hardware
> counters through the DSA ethtool hooks and ndo_get_stats64.  Since the ch=
ip
> counters are 32 bit, a 64-bit software shadow is kept and refreshed by a
> delayed work every three seconds.  No Link: tags are present in the commi=
t
> header.
>
> A few questions below.
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > index fc604edb309b9..6a14ba3661625 100644
> > --- a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
>
> [ ... ]
>
> > @@ -800,6 +866,18 @@ static const struct dsa_switch_ops lan9645x_switch=
_ops =3D {
> >  	/* Multicast database */
> >  	.port_mdb_add			=3D lan9645x_mdb_add,
> >  	.port_mdb_del			=3D lan9645x_mdb_del,
> > +
> > +	/* Port statistics counters. */
> > +	.get_strings			=3D lan9645x_get_strings,
> > +	.get_ethtool_stats		=3D lan9645x_get_ethtool_stats,
> > +	.get_sset_count			=3D lan9645x_get_sset_count,
> > +	.get_eth_mac_stats		=3D lan9645x_get_eth_mac_stats,
> > +	.get_rmon_stats			=3D lan9645x_get_rmon_stats,
> > +	.get_stats64			=3D lan9645x_get_stats64,
> > +	.get_pause_stats		=3D lan9645x_get_pause_stats,
> > +	.get_mm_stats			=3D lan9645x_get_mm_stats,
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
>
> Is .get_mm_stats reachable without a .get_mm implementation?  A grep over
> drivers/net/dsa/microchip/lan9645x/ finds only get_mm_stats, neither
> .get_mm nor .set_mm is provided.
>
> dsa_user_get_mm() refuses the request in that case:
>
> net/dsa/user.c:dsa_user_get_mm() {
> 	if (!ds->ops->get_mm)
> 		return -EOPNOTSUPP;
> 	...
> }
>
> and mm_prepare_data() leaves before ->get_mm_stats() is invoked:
>
> net/ethtool/mm.c:mm_prepare_data() {
> 	ret =3D ops->get_mm(dev, &data->state);
> 	if (ret)
> 		goto out_complete;
>
> 	if (ops->get_mm_stats && (req_base->flags & ETHTOOL_FLAG_STATS))
> 		ops->get_mm_stats(dev, &data->stats);
> 	...
> }
>
> So does lan9645x_stats_get_mm_stats() ever run, and does
> ethtool --show-mm --include-statistics just return -EOPNOTSUPP?
>
> The same missing .get_mm makes __ethtool_dev_mm_supported() always return
> false, and both stats_prepare_data() (net/ethtool/stats.c) and
> pause_prepare_data() (net/ethtool/pause.c) reject requests carrying
> src =3D=3D EMAC or src =3D=3D PMAC on that basis.  Does that leave the
> ETHTOOL_MAC_STATS_SRC_EMAC and ETHTOOL_MAC_STATS_SRC_PMAC branches of
> lan9645x_stats_get_eth_mac_stats(), lan9645x_stats_get_rmon_stats(),
> lan9645x_stats_get_pause_stats(), lan9645x_stats_get_eth_phy_stats() and
> lan9645x_stats_get_eth_ctrl_stats() unreachable as well, with only the
> default aggregate branch ever executing?
>

Yes, this is also correct. I will remove the mac merge related code until m=
ac
merge itself lands in the driver.

> > +	.get_eth_phy_stats		=3D lan9645x_get_eth_phy_stats,
> > +	.get_eth_ctrl_stats		=3D lan9645x_get_eth_ctrl_stats,
> >  };
>
> [ ... ]
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > new file mode 100644
> > index 0000000000000..f9c4bcb308991
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.c
> > @@ -0,0 +1,935 @@
>
> [ ... ]
>
> > +void lan9645x_stats_get_stats64(struct lan9645x *lan9645x, int port,
> > +				struct rtnl_link_stats64 *stats)
> > +{
>
> [ ... ]
>
> > +	stats->rx_packets =3D c[SCNT_RX_SHORT] +
> > +			    c[SCNT_RX_FRAG] +
> > +			    c[SCNT_RX_JABBER] +
> > +			    c[SCNT_RX_SZ_64] +
> > +			    c[SCNT_RX_SZ_65_127] +
> > +			    c[SCNT_RX_SZ_128_255] +
> > +			    c[SCNT_RX_SZ_256_511] +
> > +			    c[SCNT_RX_SZ_512_1023] +
> > +			    c[SCNT_RX_SZ_1024_1526] +
> > +			    c[SCNT_RX_SZ_JUMBO] +
> > +			    c[SCNT_RX_LONG] +
> > +			    c[SCNT_RX_PMAC_SHORT] +
> > +			    c[SCNT_RX_PMAC_FRAG] +
> > +			    c[SCNT_RX_PMAC_JABBER] +
> > +			    c[SCNT_RX_PMAC_SZ_64] +
> > +			    c[SCNT_RX_PMAC_SZ_65_127] +
> > +			    c[SCNT_RX_PMAC_SZ_128_255] +
> > +			    c[SCNT_RX_PMAC_SZ_256_511] +
> > +			    c[SCNT_RX_PMAC_SZ_512_1023] +
> > +			    c[SCNT_RX_PMAC_SZ_1024_1526] +
> > +			    c[SCNT_RX_PMAC_SZ_JUMBO];
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
>
> Is the missing c[SCNT_RX_PMAC_LONG] here intentional?  The eMAC oversize
> counter c[SCNT_RX_LONG] is summed into rx_packets, but the pMAC term list
> stops at SCNT_RX_PMAC_SZ_JUMBO.  The same asymmetry appears in
> stats->rx_dropped below, which also starts from c[SCNT_RX_LONG] alone.
>

Yes, this is a mistake, I will add it.

> Every other term in this function is paired, and rx_errors does include
> the pMAC counterpart:
>
> 	stats->rx_errors =3D c[SCNT_RX_SHORT] +
> 			   ...
> 			   c[SCNT_RX_PMAC_LONG];
>
> SCNT_RX_PMAC_LONG (offset 0x42) is present in
> lan9645x_port_stats_layout[] and is accumulated by
> __lan9645x_stats_view_idx_transfer(), so on a port running frame
> preemption, would oversize frames on the preemptible MAC show up in
> rx_errors while being absent from rx_packets and rx_dropped?
>
> > +
> > +	stats->multicast =3D c[SCNT_RX_MC] + c[SCNT_RX_PMAC_MC];
> > +
> > +	stats->rx_errors =3D c[SCNT_RX_SHORT] +
> > +			   c[SCNT_RX_FRAG] +
> > +			   c[SCNT_RX_JABBER] +
> > +			   c[SCNT_RX_CRC] +
> > +			   c[SCNT_RX_SYMBOL_ERR] +
> > +			   c[SCNT_RX_LONG] +
> > +			   c[SCNT_RX_PMAC_SHORT] +
> > +			   c[SCNT_RX_PMAC_FRAG] +
> > +			   c[SCNT_RX_PMAC_JABBER] +
> > +			   c[SCNT_RX_PMAC_CRC] +
> > +			   c[SCNT_RX_PMAC_SYMBOL_ERR] +
> > +			   c[SCNT_RX_PMAC_LONG];
> > +
> > +	stats->rx_dropped =3D c[SCNT_RX_LONG] +
> > +			    c[SCNT_DR_LOCAL] +
> > +			    c[SCNT_DR_TAIL] +
> > +			    c[SCNT_RX_CAT_DROP] +
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
>
> Should one oversize frame be reported three times?  c[SCNT_RX_LONG] is
> added to rx_packets, to rx_errors and to rx_dropped, so a single frame
> appears in all three fields of ip -s link and /proc/net/dev.  The same
> applies, twice over, to c[SCNT_RX_SHORT], c[SCNT_RX_FRAG],
> c[SCNT_RX_JABBER] and their pMAC twins, which land in both rx_packets and
> rx_errors.
>
> The uAPI kernel-doc in include/uapi/linux/if_link.h describes these as
> distinct categories:
>
>  * @rx_packets: Number of good packets received by the interface.
>  * @rx_errors: Total number of bad packets received on this network devic=
e.
>  * @rx_dropped: Number of packets received but not processed, e.g. due to
>  *	lack of resources or unsupported protocol.
>
> and points length violations at @rx_length_errors, which this driver
> leaves at zero.
>
> For comparison, ocelot_port_get_stats64()
> (drivers/net/ethernet/mscc/ocelot_stats.c) does fold SHORTS, FRAGMENTS,
> JABBERS and LONGS into rx_packets, but it does not populate rx_errors at
> all and does not add RX_LONGS to rx_dropped.  Was RX_LONG in rx_dropped
> meant to be rx_length_errors instead?

I will add rx_length_errors, and move RX_LONG from rx_dropped to there.
>
> > +			    c[SCNT_RX_RED_PRIO_0] +
>
> [ ... ]
>
> > +			    c[SCNT_RX_RED_PRIO_7];
>
> [ ... ]
>
> > +void lan9645x_stats_init(struct lan9645x *lan9645x)
> > +{
> > +	struct lan9645x_stats *stats =3D lan9645x->stats;
> > +
> > +	queue_delayed_work(stats->queue, &stats->work,
> > +			   LAN9645X_STATS_CHECK_DELAY);
> > +}
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
>
> Where does the software shadow and the hardware counter get a common
> baseline?
>
> lan9645x_stats_add_cnt() keeps the previous hardware value in the low hal=
f
> of the shadow and infers a wrap from it:
>
> 	if (val < (*cnt & U32_MAX))
> 		*cnt +=3D (u64)1 << 32; /* value has wrapped */
>
> 	*cnt =3D (*cnt & ~(u64)U32_MAX) + val;
>
> vstat->cnts is devm_kcalloc()'d once in lan9645x_stats_alloc() during
> probe and never re-zeroed, and SYS_STAT_CFG.STAT_CLEAR_SHOT is defined in
> lan9645x_regs.h but never written.  lan9645x_stats_init() runs from
> lan9645x_setup() after lan9645x_reset_switch() has driven
> SYS_RESET_CFG.CORE_ENA=3D0 and run SYS_RAM_INIT, and it only re-arms the
> poll work.
>
> If the core reset does clear the counter RAM, then on a second .setup()
> of an already-probed instance (DSA tree teardown and re-setup, which the
> .setup/.teardown stats hooks appear written for) hardware restarts at 0
> while the shadow still holds the old values, so the first poll sees
> val =3D 0 < (*cnt & U32_MAX) for every non-zero counter and adds
> 4294967296 to each, permanently.
>
> If the reset does not clear them, an unbind/rebind starts with a zeroed
> shadow against non-zero hardware, so the fresh interface reports traffic
> it never saw.
>
> ocelot_init() clears the counters explicitly for the same block:
>
> drivers/net/ethernet/mscc/ocelot.c:ocelot_init() {
> 		/* Clear all counters (5 groups) */
> 		ocelot_write(ocelot, SYS_STAT_CFG_STAT_VIEW(port) |
> 				     SYS_STAT_CFG_STAT_CLEAR_SHOT(0x7f),
> 			     SYS_STAT_CFG);
> }
>
> Would it make sense to clear the hardware counters and/or memset the
> shadow in lan9645x_stats_init() so the two always start together?
>

Yes I think this makes sense, I will add this.

> [ ... ]
>
> > diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.h
b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.h
> > new file mode 100644
> > index 0000000000000..cd5db16258a09
> > --- /dev/null
> > +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_stats.h
> > @@ -0,0 +1,279 @@
>
> [ ... ]
>
> > +/* Counter indices into stat layout structs */
> > +#define SCNT_FRER_SID_IN_PKT             0
> > +#define SCNT_ISDX_GREEN_OCT              1
>
> [ ... ]
>
> > +#define SCNT_SF_MATCHING_FRAMES_COUNT    0
>
> [ ... ]
>
> > +#define SCNT_ESDX_GREEN_OCT              0
>
> [ ... ]
>
> > +enum lan9645x_view_stat_type {
> > +	LAN9645X_STAT_PORTS =3D 0,
> > +	LAN9645X_STAT_ISDX,
> > +	LAN9645X_STAT_ESDX,
> > +	LAN9645X_STAT_SFID,
> > +
> > +	LAN9645X_STAT_NUM,
> > +};
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
>
> This isn't a bug, but the ISDX, ESDX, SFID and FRER parts of this
> framework have no user in the patch.  A grep over
> drivers/net/dsa/microchip/lan9645x/ shows SCNT_ISDX_*, SCNT_SF_*,
> SCNT_ESDX_* and SCNT_FRER_SID_IN_PKT matching only in this header, and
> lan9645x_view_stat_cfgs[] populates just [LAN9645X_STAT_PORTS].
>
> lan9645x_stats_view_update() has PORTS as its only non-default case, so
> the loop in lan9645x_stats_update():
>
> 	for (int vtype =3D 0; vtype < LAN9645X_STAT_NUM; vtype++)
> 		lan9645x_stats_view_update(lan9645x, vtype);
>
> does three no-op iterations over zeroed view[] entries on every poll.
>
> Also, struct lan9645x_view_stats.name is only ever written
> (.name =3D "ports") and never read, and the back-pointer assignment
> vstat->stats =3D lan9645x->stats in lan9645x_view_stat_init() has no
> reader.  Since the commit message only describes adding "statistics
> support for the port counters", could the unused infrastructure be
> dropped until the view that needs it lands?
>

Yes I will remove the unused views and fields.

> [ ... ]

