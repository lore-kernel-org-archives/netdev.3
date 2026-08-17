Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B563BF689;
	Mon, 17 Aug 2026 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976338; cv=none; b=Xy35UW5tn6MuWVnDPag81Bp4acpEZ3vdm9vakvMM65/OjNSTHp8iBg6xbxEgtZEgs3VVOrKXGD0F6mjqLYZcIpeTwSDaAoZVnYYOEVezDOJEkep1hKs9pBLBOxnyn8q/ZekXKnyUcDbZCJlCDwIU3p5gLTd06GWwD4SA9Rd4+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976338; c=relaxed/simple;
	bh=B9UwcCJ+EYOh/iZpIkt6JPdaA7PRb8qfLBUTpGkhZxg=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVUdnCqemuMoE7G6h7c83jvvh8/o/b19H8diwG75AFZv4eewPlBahAstzAwTfQVHK4sVl9jdpcU3rncQo/9tE/znK86i3Zz64boEVMnbe54v884OBSx0bXGME5RITAsQl6s56jKCzPyuAFPBpnHBCdV21fz5z1jlQv/qbGq+uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tdauFioE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tdauFioE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1786976337; x=1818512337;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=B9UwcCJ+EYOh/iZpIkt6JPdaA7PRb8qfLBUTpGkhZxg=;
  b=tdauFioEwZqx6DkaAH1XU03j/VbnNHt2BPK3EDrXaV1QMjpATaO0B3+W
   h9aybuZ/CR74QKTyEO/xiiYBrvjZBz4cdeCK2k/VRDOno9ym6ecBYlZwU
   N7MbgyfrjYahhRSfevb3herg77BKII2ZlsvMRoubE0t1wLPsPwgco0X8v
   sS3aCZe0NTygTjMktsXEiqSBeVxDXj1DDxZsUnAqgyyV/z8ZXUmH7aoBS
   KxTobj8r9DaHOQCbQ832jyBmWFLzN46yVFqAM3dCRGcWzhdTEV8mYABFC
   yeQ8UpKKEQhZQ+uTu95uj+At0FWeO/QzpoO9lrxQ6/pZK1tnq20zZS6dF
   w==;
X-CSE-ConnectionGUID: 9ukn+/d7SNa9u8AGaj1s8w==
X-CSE-MsgGUID: ++lwQDbyTKGsY243ZTJCEg==
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; 
   d="scan'208";a="62248563"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2026 07:18:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 17 Aug 2026 07:18:55 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 17 Aug 2026 07:18:52 -0700
Message-ID: <5e49cafe5a59227607564be2605f786ebe67999b.camel@microchip.com>
Subject: Re: [PATCH net-next v11 1/9] net: dsa: add tag driver for LAN9645X
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
Date: Mon, 17 Aug 2026 16:18:51 +0200
In-Reply-To: <20260805-dsa_lan9645x_switch_driver_base-v11-1-007ebc983a0a@microchip.com>
References: <20260805-dsa_lan9645x_switch_driver_base-v11-0-007ebc983a0a@microchip.com>
	 <20260805-dsa_lan9645x_switch_driver_base-v11-1-007ebc983a0a@microchip.com>
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
witch_driver_base-v11-0-007ebc983a0a%40microchip.com?part=3D1

> --- Patch [1]: [PATCH net-next v11 1/9] net: dsa: add tag driver for LAN9=
645X ---
> commit 16799f4195f9118fdca9d3ba803a3d4d2e6a9414
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: add tag driver for LAN9645X
>
> This adds a DSA tag driver for the LAN9645x family used with a front port
> as CPU port (NPI mode), with a long prefix on extraction and no prefix on
> injection.  A new header exports the 28 byte internal frame header (IFH)
> field table, and the tagger encodes/decodes it in lan9645x_xmit() and
> lan9645x_rcv().
>
> A few questions below.
>
> > diff --git a/include/linux/dsa/lan9645x.h b/include/linux/dsa/lan9645x.=
h
> > new file mode 100644
> > index 0000000000000..9896fab649c4d
> > --- /dev/null
> > +++ b/include/linux/dsa/lan9645x.h
> > @@ -0,0 +1,144 @@
>
> [ ... ]
>
> > +#define LAN9645X_IFH_TAG_TYPE_C	0
> > +#define LAN9645X_IFH_TAG_TYPE_S	1
> > +#define LAN9645X_IFH_LEN_U32		7
> > +#define LAN9645X_IFH_LEN		(LAN9645X_IFH_LEN_U32 * sizeof(u32))
> > +#define LAN9645X_IFH_BITS		(LAN9645X_IFH_LEN * BITS_PER_BYTE)
> > +#define LAN9645X_SHORT_PREFIX_LEN	4
> > +#define LAN9645X_LONG_PREFIX_LEN	16
> > +#define LAN9645X_TOTAL_TAG_LEN (LAN9645X_LONG_PREFIX_LEN + LAN9645X_IF=
H_LEN)
> > +
> > +#define IFH_INJ_TIMESTAMP		192
> > +#define IFH_BYPASS			191
> > +#define IFH_MASQ			190
> > +#define IFH_TIMESTAMP			186
> > +#define IFH_TIMESTAMP_NS		194
> > +#define IFH_TIMESTAMP_SUBNS		186
> > +#define IFH_MASQ_PORT			186
> > +#define IFH_RCT_INJ			185
> > +#define IFH_LEN				171
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Can this IFH_LEN definition clash with the existing ones?  There are alre=
ady
> two in-tree macros with that name and a different meaning:
>
> drivers/net/ethernet/microchip/lan966x/lan966x_ifh.h:
>     #define IFH_LEN                      7
>     #define IFH_LEN_BYTES                (IFH_LEN * sizeof(u32))
>
> drivers/net/ethernet/microchip/sparx5/sparx5_main.h:
>     #define IFH_LEN                9 /* 36 bytes */
>
> Both are u32 word counts for the IFH of sibling chips in the same family,
> while here IFH_LEN is the bit position 171 of the length field.  A
> translation unit that includes this header plus either of those gets a
> redefinition warning, or silently expands 7 or 9 where bit 171 was meant.
>
> The same header also exports LAN9645X_IFH_LEN (28 bytes), so two macros
> differing only by prefix carry unrelated quantities.  The length/format a=
nd
> tag type macros already got the LAN9645X_ prefix - would it make sense to
> prefix the whole field table exported from include/linux/dsa/ as well?
>

I will rename LAN9645X_IFH_LEN to LAN9645X_IFH_LEN_BYTES and move the field
table to tag_lan9645x.c.

> > +#define IFH_WRDMODE			169
> > +#define IFH_RTAGD			167
> > +#define IFH_CUTTHRU			166
>
> [ ... ]
>
> > +#define IFH_RTE_INB_UPDATE		148
> > +#define IFH_POP_CNT			146
> > +#define IFH_ETYPE_OFS			144
> > +#define IFH_SRCPORT			140
>
> [ ... ]
>
> > +#define IFH_INJ_TIMESTAMP_SZ		32
> > +#define IFH_BYPASS_SZ			1
> > +#define IFH_MASQ_SZ			1
> > +#define IFH_TIMESTAMP_SZ		38
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is IFH_TIMESTAMP usable with the accessors added by this patch?  Both
> lan9645x_ifh_set() and lan9645x_ifh_get() carry:
>
>     BUILD_BUG_ON_MSG(length > 32, "IFH field size wider than 32.");
>
> and pass the value through u32, so a consumer calling
>
>     lan9645x_ifh_get(ifh, IFH_TIMESTAMP, IFH_TIMESTAMP_SZ)
>
> fails to build.  The usable split already exists as IFH_TIMESTAMP_NS (30
> bits) plus IFH_TIMESTAMP_SUBNS (8 bits), so should the 38 bit alias be
> dropped or annotated?
>
> Related, the table mixes the injection and extraction layouts without
> marking which is which: IFH_TIMESTAMP, IFH_TIMESTAMP_SUBNS and
> IFH_MASQ_PORT all start at bit 186, and IFH_INJ_TIMESTAMP (32 bits at 192=
)
> overlaps IFH_BYPASS and IFH_MASQ.  Only the .c file mentions that "There
> are two field layouts, one for extraction and one for injection".  Could
> the header note the direction per field?

I will remove IFH_TIMESTAMP and just keep the NS/SUBNS subfield split, and
annotate each field with whether it is used in the injection, extraction or=
 both
headers.

>
> > +#define IFH_TIMESTAMP_NS_SZ		30
> > +#define IFH_TIMESTAMP_SUBNS_SZ		8
>
> [ ... ]
>
> > diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> > new file mode 100644
> > index 0000000000000..6a33216c7792f
> > --- /dev/null
> > +++ b/net/dsa/tag_lan9645x.c
> > @@ -0,0 +1,317 @@
>
> [ ... ]
>
> > +static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
> > +				     struct net_device *ndev)
> > +{
>
> [ ... ]
>
> > +	lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
> > +	lan9645x_ifh_set(ifh, ds->num_ports, IFH_SRCPORT, IFH_SRCPORT_SZ);
> > +	lan9645x_ifh_set(ifh, tag_type, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
> > +	lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);
> > +	lan9645x_ifh_set(ifh, qos_class, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
> > +	lan9645x_ifh_set(ifh, BIT(dp->index), IFH_DSTS, IFH_DSTS_SZ);
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> This isn't a bug today, but should the destination set use
> dsa_xmit_port_mask() instead of open-coding BIT(dp->index)?
>
> net/dsa/tag.h:dsa_xmit_port_mask() is BIT(dp->index) plus the HSR
> duplication fan-out:
>
>     unsigned long mask =3D BIT(dp->index);
>
>     if (IS_ENABLED(CONFIG_HSR) &&
>         unlikely(dev->features & NETIF_F_HW_HSR_DUP)) {
>             struct net_device *hsr_dev =3D dp->hsr_dev;
>             struct dsa_port *other_dp;
>
>             dsa_hsr_foreach_port(other_dp, dp->ds, hsr_dev)
>                     mask |=3D BIT(other_dp->index);
>     }
>
> tag_ocelot.c writes the same IFH DSTS concept through the helper:
>
>     ocelot_ifh_set_dest(injection, dsa_xmit_port_mask(skb, netdev));
>
> and net/dsa/dsa.c documents the contract as "Helpers for switches without
> specific HSR offloads, but which can implement NETIF_F_HW_HSR_DUP because
> their tagger uses dsa_xmit_port_mask()".  I checked the companion switch
> driver in this series and it implements no HSR offload, so there is no
> functional effect right now; a later HSR/PRP offload would however
> duplicate to a single port only, since the partner bit never reaches IFH
> DSTS.
>

I think this would be a bug on this chip, for HSR/PRP v1. When multiple
ports are set in the IFH_DSTS mask, each port receives a byte-identical cop=
y. But
HSR/PRP v1 require the 2 duplicates differ in a bit (lan_id) in the tag whi=
ch
tells from which port the frame egresses. Typically 0 for port A and 1 for
port B.

This chip is also capable of offloading several HSR and PRP features such a=
s
duplication and duplicate discard. When I implement the callbacks I plan on
using those capabilities.

> > +
> > +	return skb;
> > +}
> > +
> > +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> > +				    struct net_device *ndev)
> > +{
>
> [ ... ]
>
> > +	popcnt =3D lan9645x_ifh_get(ifh, IFH_POP_CNT, IFH_POP_CNT_SZ);
> > +	etype_ofs =3D lan9645x_ifh_get(ifh, IFH_ETYPE_OFS, IFH_ETYPE_OFS_SZ);
> > +	src_port =3D lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
>
> [ ... ]
>
> > +	if (popcnt =3D=3D 0 && etype_ofs =3D=3D 0)
> > +		ifh_gap_len =3D 2 * VLAN_HLEN;
> > +	else if (popcnt =3D=3D 3)
> > +		ifh_gap_len =3D VLAN_HLEN;
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Which extraction encodings does this cover?  IFH_POP_CNT and IFH_ETYPE_OF=
S
> are 2 bits each, so there are 16 combinations, and only two of them get a
> non-zero gap here.  Everything else, including popcnt =3D=3D 1, popcnt =
=3D=3D 2 and
> (popcnt =3D=3D 0, etype_ofs =3D=3D 1), falls through to the initialiser
> ifh_gap_len =3D 0.
>
> The mapping also looks internally inconsistent: on one port an untagged
> frame (popcnt =3D=3D 0, etype_ofs =3D=3D 0) gets an 8 byte gap, while a
> single-tagged frame on the same port (popcnt =3D=3D 0, etype_ofs =3D=3D 1=
) gets a 0
> byte gap.  That is an 8 byte difference for one 4 byte tag.  The two
> handled values do differ by exactly one tag, which suggests the real
> discriminator is the number of tags left in the delivered frame
> (ETYPE_OFS) rather than the two POP_CNT comparisons.  Could the full
> datasheet mapping be spelled out here?
>
> The companion switch driver added later in this series programs a pop cou=
nt
> of 1 on every VLAN-aware port:
>
> drivers/net/dsa/microchip/lan9645x/lan9645x_vlan.c:
>         val |=3D ANA_VLAN_CFG_VLAN_AWARE_ENA_SET(1) |
>                ANA_VLAN_CFG_VLAN_POP_CNT_SET(1);
>
> so POP_CNT =3D=3D 1 seems to be an expected extraction encoding that land=
s in
> the zero-gap default.
>

No the current logic covers all cases properly. The values encoded in the f=
ields
are not intuitive. On a vlan aware port ifh.pop_cnt will not be 1 for insta=
nce.

This is how the calculation goes:

DMAC_DT =3D (ifh.pop_cnt =3D=3D 0 && ifh.etype_ofs =3D=3D 0) ? 4 : ifh.pop_=
cnt
DMAC_OFFSET =3D TAG_SIZE + 4*(DMAC_DT - 2)

With tag pushing disabled we have either

popcnt=3D0 and etype_ofs=3D0     =3D> 2x pop
popcnt=3D3 and etype_ofs=3D*     =3D> 1x pop
popcnt=3D2 and etype_ofs=3D*     =3D> no pop

The remaining combinations indicate a push and will not occur.

I will include this in a comment, and add WARN_ON_ONCE and a bailout for th=
e
impossible combinations.

> > +
> > +	skb_pull(skb, LAN9645X_IFH_LEN);
> > +
> > +	if (unlikely(!pskb_may_pull(skb, ifh_gap_len + ETH_HLEN))) {
> > +		kfree_skb(skb);
> > +		return NULL;
> > +	}
> > +
> > +	skb_pull(skb, ifh_gap_len);
> > +	skb_reset_mac_header(skb);
> > +	skb_set_network_header(skb, ETH_HLEN);
> > +	skb_reset_mac_len(skb);
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Following on from the gap computation above: if ifh_gap_len is smaller th=
an
> the real gap, do these calls describe a header the hardware did not put
> there, so that eth_type_trans() in dsa_switch_rcv() derives a protocol fr=
om
> leftover tag bytes?  And if it is larger, are up to 8 bytes of the real
> DMAC pushed back into the headroom and lost?
>
> > +
> > +	/* Reset skb->data past the actual ethernet header. */
> > +	skb_pull(skb, ETH_HLEN);
>
> [ ... ]
>
> > +	skb_postpull_rcsum(skb,
> > +			   skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_len,
> > +			   LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> The same ifh_gap_len is reused as the checksum fixup length here.  Can a
> wrong gap corrupt skb->csum on a CHECKSUM_COMPLETE conduit, since the
> subtracted byte range then does not match the bytes the conduit actually
> summed?
>
> > +
> > +	skb->dev =3D dsa_conduit_find_user(ndev, 0, src_port);
> > +	if (WARN_ON_ONCE(!skb->dev)) {
> > +		/* This should never happen since we have disabled reflection
> > +		 * back to the CPU.
> > +		 */
> > +		kfree_skb(skb);
> > +		return NULL;
> > +	}
>
> Discovered by: opus-5 =C2=B7 Missed by: sashiko-gemini
> Is this WARN_ON_ONCE() reachable from frame data?  src_port comes straigh=
t
> out of the received IFH:
>
>     src_port =3D lan9645x_ifh_get(ifh, IFH_SRCPORT, IFH_SRCPORT_SZ);
>
> That is a 4 bit field, so any value 0..15 can arrive, and
> dsa_conduit_find_user() returns NULL for every index that is not a
> registered user port.  Candidates for such an index are the NPI port inde=
x
> itself (registered as DSA_PORT_TYPE_CPU), physical ports left unused by t=
he
> device tree, and masqueraded source ports from a frame injected on the ba=
re
> conduit, which the hardware parses as a bare IFH because no injection
> prefix is configured.  With panic_on_warn=3D1 that becomes a panic from t=
he
> receive path.
>
> The comment relies on reflection being disabled, but the guard in the
> companion driver only covers src_port equal to the CPU port module:
>
> drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c:
>     /* Make sure frames with src_port=3D<CPU port module> are not reflect=
ed
>      * back via the NPI port. ... The *_CPU_KILL_ENA flags above only hav=
e an
>      * effect when a frame is output due to a CPU forwarding decision suc=
h as
>      * trapping or cpu copy.
>      */
>     lan_rmw(0, BIT(port), lan9645x,
>             ANA_PGID(PGID_SRC + lan9645x->num_phys_ports));
>
> The tagger for the same hardware family deliberately drops silently here:
>
> net/dsa/tag_ocelot.c:ocelot_rcv()
>     skb->dev =3D dsa_conduit_find_user(netdev, 0, src_port);
>     if (!skb->dev) {
>             /* The switch will reflect back some frames sent through
>              * sockets opened on the bare DSA conduit. ... So don't print=
 any
>              * error message here (ignore and drop those frames).
>              */
>             kfree_skb(skb);
>             return NULL;
>     }
>
> The kfree_skb() and return NULL here are already right - would dropping t=
he
> WARN_ON_ONCE() be preferable?
>

I think it is right that a carefully constructed frame on a raw socket for =
the
conduit, could be reflected. I will remove the WARN_ON_ONCE().

> [ ... ]

