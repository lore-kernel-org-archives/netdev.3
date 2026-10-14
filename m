Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78E74E323D;
	Wed, 14 Oct 2026 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791972005; cv=none; b=HmUsDut8FdMrrDo0QeQUOICul2ZgK44udEVL0d7Z8eo9DgW11oeBlxQUY84OJBFoqQw7WTtGcLIlmPoWbdBGhyv/ug15C8tt3jILCRBc3LO5YeUaBkXCRmYChoxshVphhHZD9Zsd1TlfdGZjVJI1siTiFWg9mBmut6OTYq1CM0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791972005; c=relaxed/simple;
	bh=k5iO9wvNr9q6UBwSYLG3p7VKauGZZ9xWZCkjcGBVkkA=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z58lfh+k6ie4aT0mHClxDYaoc/Wk1SvGaZOjZjRdblQ1DKkbPyncT6p5N7X22C8W8u4IZXsU2CdjbwMd1GrebM3dEfb8pttf5jaX5X8RLpLbIiSLCoyS2bCLfRN3UeJIPfMqGWnX5HfPA6ZXOVmXcfAEtQZXwoaN8ixkdgeNj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=y7u+xHRk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="y7u+xHRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791972003; x=1823508003;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k5iO9wvNr9q6UBwSYLG3p7VKauGZZ9xWZCkjcGBVkkA=;
  b=y7u+xHRkq65EgvcR3T2AzMdDE5DfBZ0bHuDj/P1GQLh4l7ufajJ3deeC
   Dx0AtIYL1pcE4+Y7rqXWTOSLHcShKpseoawLqIYqZakt5NKApOlihBtSS
   sbeeKGyl6zhdMbpjzxS2EvHWdS+rUwi5FfjRO4OfXRSrNy7ma4p7dcjnd
   FtmM0GLlUudV08JaPYzWHspKii33lKenQIHoOMcBZHcbKBCeT6PXKXby0
   cSyrUSzhdC386+FaXxpdFGmjqTi0BLIafSCejMI0nY8oH/rlvSPW4PCWf
   6eoWflBmbZTJvR0J/qZIMiVPsfzUEIbdXpEMDU9LqGTQX0tInC7x3Xh++
   Q==;
X-CSE-ConnectionGUID: +AgjuoQ3Q1yhSnY9YAPcGA==
X-CSE-MsgGUID: 46xyAabAR4S5eetuz+uEmg==
X-IronPort-AV: E=Sophos;i="6.27,157,1787036400"; 
   d="scan'208";a="64075340"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2026 02:59:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 14 Oct 2026 02:59:56 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 14 Oct 2026 02:59:52 -0700
Message-ID: <08cf1da4e15141060ceece86fa1c03ada384ba82.camel@microchip.com>
Subject: Re: [PATCH net-next v14 1/9] net: dsa: add tag driver for LAN9645X
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
Date: Wed, 14 Oct 2026 11:59:52 +0200
In-Reply-To: <179180427718.434549.18360749106735687436@kernel.org>
References: <20261008-dsa_lan9645x_switch_driver_base-v14-1-3d2a72661213@microchip.com>
	 <179180427718.434549.18360749106735687436@kernel.org>
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
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 2
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] In lan9645x_rcv() (net/dsa/tag_lan9645x.c:459), every tag
>   popped by the hardware is restored as an 802.1Q hwaccel tag with=E2=80=
=A6
> - [Low] The comment above skb_postpull_rcsum() in lan9645x_rcv()
>   (net/dsa/tag_lan9645x.c:416-421) says the bytes to subtract are "what=
=E2=80=A6
> - [Low] lan9645x_rcv() (net/dsa/tag_lan9645x.c:450) restores the popped
>   VLAN tag only when `dsa_port_is_vlan_filtering(dp) && ifh_gap_len`.
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but the new
>   tagger adds another lockless reader of it.
>=20
> --
>=20
> net: dsa: add tag driver for LAN9645X
>=20
> This adds a DSA tag driver for the Microchip LAN9645x switch when a front
> port is used as the CPU (NPI) port. Extraction uses a long prefix plus a
> 28 byte IFH, and injection uses only the IFH. VLAN tags popped by the
> hardware are restored on receive as 802.1Q hwaccel tags, and on transmit
> the VLAN tag is moved from the payload into the IFH.
>=20
> > diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> > new file mode 100644
> > index 0000000000000..00339daecfcbd
> > --- /dev/null
> > +++ b/net/dsa/tag_lan9645x.c
> > @@ -0,0 +1,514 @@
>=20
> [ ... ]
>=20
> > +static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
> > +                                  struct net_device *ndev)
> > +{
> > +     struct dsa_port *dp =3D dsa_user_to_port(ndev);
> > +     u32 vlan_tci, tag_type;
> > +     u32 qos_class;
> > +     void *ifh;
> > +
> > +     skb =3D lan9645x_xmit_get_vlan_info(skb, dsa_port_bridge_dev_get(=
dp),
> > +                                       &vlan_tci, &tag_type);
>=20
> [Severity: Medium]
> This isn't a bug introduced by this patch, but this adds one more lockles=
s
> reader of dp->bridge in the xmit path.
>=20
> dsa_port_bridge_dev_get() does this with no READ_ONCE() and no lifetime
> protection:
>=20
>         return dp->bridge ? dp->bridge->dev : NULL;
>=20
> On bridge leave, dsa_port_bridge_leave()->dsa_port_bridge_destroy() clear=
s
> the pointer and frees the last reference right away:
>=20
>         dp->bridge =3D NULL;
>=20
>         if (!refcount_dec_and_test(&bridge->refcount))
>                 return;
>         ...
>         kfree(bridge);
>=20
> There is no RCU grace period between the two. Can a transmit on the user
> port that races with the bridge leave load the old dp->bridge and then re=
ad
> ->dev from a freed dsa_bridge?
>=20
> The window is narrow. tag_ocelot.c, tag_sja1105.c and the
> dsa_software_vlan_untag() helpers use the same pattern, so the root cause
> is in the DSA core and not in this tagger.
>=20

Dismissed, preexisting.

This is the existing DSA core pattern, shared with tag_dsa, tag_ocelot,
tag_sja1105, tag_vsc73xx_8021q and dsa_software_vlan_untag().
dsa_port_bridge_destroy() frees the dsa_bridge without waiting for a
grace period, so a tagger cannot fix this locally. The fix belongs in
the DSA core.


> [ ... ]
>=20
> > +     /* Reset skb->data past the actual ethernet header. */
> > +     skb_pull(skb, ETH_HLEN);
> > +
> > +     /* We must deliver the skb so skb->csum only covers the data beyo=
nd the
> > +      * real ethernet header. The fake ethernet header in the prefix i=
s
> > +      * not part of skb->csum already. We must subtract what remains o=
f the
> > +      * prefix, the ifh and the gap. The start is derived from the cur=
rent
> > +      * skb->data rather than saved on entry, because the pskb_may_pul=
l()
> > +      * calls above may have reallocated skb->head.
> > +      */
> > +     skb_postpull_rcsum(skb,
> > +                        skb->data - LAN9645X_TOTAL_TAG_LEN - ifh_gap_l=
en,
> > +                        LAN9645X_TOTAL_TAG_LEN + ifh_gap_len);
>=20
> [Severity: Low]
> This isn't a bug, but the comment doesn't list everything the call
> subtracts.
>=20
> The length is LAN9645X_TOTAL_TAG_LEN + ifh_gap_len, which is 44 + gap
> bytes. That is 2 bytes of prefix remainder, plus 28 bytes of IFH, plus th=
e
> gap, plus the 14 byte real Ethernet header.
>=20
> The code looks right, because dsa_switch_rcv() does skb_push(ETH_HLEN) an=
d
> then eth_type_trans() without adjusting the checksum. Could the comment
> also mention the real Ethernet header? Otherwise someone might later
> shorten the length to match the comment.
>=20
> [ ... ]
>=20
> > +     dp =3D dsa_user_to_port(skb->dev);
> > +
> > +     if (dsa_port_is_vlan_filtering(dp) && ifh_gap_len) {
>=20
> [Severity: Low]
> Can frames lose their VLAN tag while vlan_filtering is changing?
>=20
> dsa_port_vlan_filtering() calls the driver op before it updates the
> software flag:
>=20
>         err =3D ds->ops->port_vlan_filtering(ds, dp->index, vlan_filterin=
g,
>                                            extack);
>         ...
>                 dp->vlan_filtering =3D vlan_filtering;
>=20
> In this series, lan9645x_port_vlan_filtering() programs VLAN_POP_CNT righ=
t
> away through lan9645x_vlan_port_apply(). Frames that the hardware pops in
> that window reach lan9645x_rcv() with ifh_gap_len !=3D 0 while
> dsa_port_is_vlan_filtering(dp) is still false. They are delivered with no
> tag.
>=20
> The reverse transition has the same problem, including bridge leave via
> lan9645x_vlan_set_hostmode(). Frames popped before the change but handled
> after dp->vlan_filtering is cleared also lose their tag.
>=20
> POP_CNT is 0 on non-filtering ports, so the gap is already 0 there. Would
> checking only ifh_gap_len keep the CPU view consistent with what the
> hardware did?
>=20
> > +             /* The tag is restored as a C-tag, not as the TAG_TYPE th=
e IFH
> > +              * reports. The classifier recognizes both TPIDs as VLAN =
tags,
> > +              * so an S-tag has already been used for classification b=
y the
> > +              * time we get here. Restoring it as 802.1AD would make t=
he
> > +              * bridge push it back into the payload and reclassify th=
e frame
> > +              * to the port pvid, on a different VID than the one the
> > +              * hardware forwarded it on.
> > +              */
> > +             __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci)=
;
> > +     }
>=20
> [Severity: Medium]
> Is the 802.1Q-only assumption enforced anywhere? The commit message says:
>=20
>   This assumes a bridge vlan_protocol of 802.1Q, which is the only
>   protocol the driver offloads.
>=20
> The xmit side of this file does handle non-802.1Q bridges, in
> lan9645x_xmit_get_vlan_info():
>=20
>         br_vlan_get_proto(br, &proto);
>         ...
>                 if (ntohs(hdr->h_vlan_proto) =3D=3D proto &&
>                     ntohs(hdr->h_vlan_TCI) & VLAN_VID_MASK) {
>         ...
>         *tag_type =3D (proto !=3D ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S =
:
>                                              LAN9645X_IFH_TAG_TYPE_C;
>=20
> DSA doesn't handle SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.
> __br_vlan_set_proto() sends that attribute with
> SWITCHDEV_F_SKIP_EOPNOTSUPP, so setting "vlan_protocol 802.1ad" on the
> bridge seems to succeed while the lan9645x ports stay offloaded. The swit=
ch
> driver in this series doesn't appear to check the bridge vlan_protocol
> either.
>=20
> On such a bridge, every tag restored here has an 0x8100 TPID, and
> __allowed_ingress() in net/bridge/br_vlan.c then does:
>=20
>         if (skb->vlan_proto !=3D br->vlan_proto) {
>                 /* Protocol-mismatch, empty out vlan_tci for new tag */
>                 skb_push(skb, ETH_HLEN);
>                 skb =3D vlan_insert_tag_set_proto(skb, skb->vlan_proto,
>                                                 skb_vlan_tag_get(skb));
>=20
> This pushes the tag back into the payload and classifies the frame to the
> pvid. Wouldn't frames trapped or copied to the CPU then land on the pvid?
> That is the same misclassification the C-tag normalization is meant to
> avoid, only in the opposite configuration.
>=20
> Should rcv follow the bridge vlan_protocol the way xmit does? Or should t=
he
> driver refuse 802.1ad bridges?

The driver does not support 802.1ad bridges, and rcv is only one part
of that. The hardware forwarding path does not follow the bridge
vlan_protocol. The classifier treats both TPIDs as VLAN tags, and the
egress TPID follows the ingress tag type. Restoring the tag with the
bridge protocol in rcv would hide one symptom without making 802.1ad
work. On xmit the protocol is taken from the bridge because the stack
picks the TPID of the frames it sends.

In v15 I will refuse VLAN filtering on a bridge whose vlan_protocol is
not 802.1Q. That covers creating or joining a VLAN-aware 802.1ad bridge,
but not a later protocol change, since DSA does not propagate
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL.


>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261008-dsa_lan9645x_switch_driver_base-v14-0-3d2a72661213%40microchip=
.com

pw-bot: cr

