Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793315C613;
	Tue,  6 Oct 2026 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791271178; cv=none; b=lfWlOLkrDu86ceb8WZQLC8QgLLcWs7aqO9AO52Vbm02e2No/rh9Qx1RMN+6wVs9I/d4VPffxzqP4Z0LmEJ1C81UVOfzIIlBjcnUY1Dd3/08LuEZZzkWJH0tpsINXr/WvfollIeJzwHPrO8zzhl+YMQcpl8dpywQ9dN4f01ZvYwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791271178; c=relaxed/simple;
	bh=L7WFbUJ36fAbncKUDz+Rg+dYIndikXM9U7/PUGa6jnI=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQ44OmaJr9DK7Qipx+Jd9gamJa+70rLL7BxYGN2PuG+LQ/35ARzD3D/lVS7JYDuh7ugUcsZtMBT1lAMdfL78BbSuz+cZQycXxSHfE50AE1BRuPohk290bCQuAs+XRjdU+K0ozq4aJj5agWdKpzlOY06+/36U7OzfJOsHhdoIpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zbHwQpgG; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zbHwQpgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1791271176; x=1822807176;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=L7WFbUJ36fAbncKUDz+Rg+dYIndikXM9U7/PUGa6jnI=;
  b=zbHwQpgGElXKQnZl06EE8xE5lBYlC/UvGNznAf5engx67OKMCn7UOKyI
   ZpgLw5V7nSX+tq4bFrRTEx3ZAqpktevv3iSbh6SopLs6/SGnpk0lH8Ow2
   WKPZCVr5BVUlYjUVfSyObCG60K0gzIYLbJ+GqestVnHGV0sJwCeOdJNeY
   eSNSMp/ALzmY0gw/zTkp3vzdHcnfCA7RHcuAMlsrMe3WuaR+z30GhcnO2
   ZWzWW4Euyddgj2gLRXBFrrQM1or518W7g5wdizcxQQfIOyxtCCbDE0lkL
   8QYq4gyj12P+AD+7ibRT1tzQ3WJf3+sLtFocrPVK3hl6EQrm9KRZPmxK8
   w==;
X-CSE-ConnectionGUID: XCkaYxriR5ePT/mPDLxJ9A==
X-CSE-MsgGUID: ytcWGut0SfyHQ8DHiDAOeg==
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="74899431"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:19:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 6 Oct 2026 00:19:34 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 6 Oct 2026 00:19:30 -0700
Message-ID: <832855c460d676b1a93690389790b7e68aeac1a8.camel@microchip.com>
Subject: Re: [PATCH net-next v13 1/9] net: dsa: add tag driver for LAN9645X
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
Date: Tue, 6 Oct 2026 09:19:30 +0200
In-Reply-To: <179097565449.434549.6566178471820291955@kernel.org>
References: <20260929-dsa_lan9645x_switch_driver_base-v13-1-827c2d3617f2@microchip.com>
	 <179097565449.434549.6566178471820291955@kernel.org>
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
> Thank you for your contribution! Sashiko AI review found 6 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 1 (1) =C2=B7 Medium: 2 =C2=B7 Low: 3
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [High] In lan9645x_xmit_get_vlan_info() (net/dsa/tag_lan9645x.c), any
>   frame with no in-band tag matching the bridge protocol gets IFH_TCI=E2=
=80=A6
> - [Medium] lan9645x_netdev_ops sets no .flow_dissect, so
>   __skb_flow_dissect() (net/core/flow_dissector.c:1083-1098) falls back=
=E2=80=A6
> - [Medium] When the IFH-classified VID equals the port pvid,
>   lan9645x_rcv() skips restoring the tag (tag_lan9645x.c:451-453).
> - [Low] In lan9645x_xmit_get_vlan_info(), the condition `skb_headlen(skb)
>   >=3D VLAN_ETH_HLEN && ntohs(hdr->h_vlan_proto) =3D=3D proto` treats a V=
LAN=E2=80=A6
> - [Low] In lan9645x_xmit_get_vlan_info(), the guard `skb_headlen(skb) >=
=3D
>   VLAN_ETH_HLEN` in front of vlan_remove_tag() does not cover every byte=
=E2=80=A6
> - [Low] lan9645x_rcv() always restores the classified VLAN as
>   ETH_P_8021Q.
>=20
> Pre-existing issues:
> - [High] lan9645x_xmit() calls dsa_port_bridge_dev_get(dp)
>   (include/net/dsa.h:774-778, `dp->bridge ?
>=20
> --
>=20
> net: dsa: add tag driver for LAN9645X
>=20
> This adds a DSA tag driver for the Microchip LAN9645x switch, which uses =
a
> front port as the NPI CPU port. On extraction, frames carry a 16 byte lon=
g
> prefix plus a 28 byte IFH. On injection, frames carry only the IFH. On
> receive, the classified VLAN is restored as a hwaccel C-tag unless it
> equals the port pvid.
>=20
> > diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> > new file mode 100644
> > index 0000000000000..f54646d4b3947
> > --- /dev/null
> > +++ b/net/dsa/tag_lan9645x.c
> > @@ -0,0 +1,474 @@
>=20
> [ ... ]
>=20
> > +static struct sk_buff *lan9645x_xmit_get_vlan_info(struct sk_buff *skb=
,
> > +                                                struct net_device *br,
> > +                                                u32 *vlan_tci,
> > +                                                u32 *tag_type)
> > +{
>=20
> [ ... ]
>=20
> > +     hdr =3D skb_vlan_eth_hdr(skb);
> > +     br_vlan_get_proto(br, &proto);
> > +
> > +     if (skb_headlen(skb) >=3D VLAN_ETH_HLEN &&
> > +         ntohs(hdr->h_vlan_proto) =3D=3D proto) {
> > +             vlan_remove_tag(skb, &tci);
>=20
> [Severity: Low]
> What happens when the VLAN header is not fully in the linear area?
>=20
> Because of the skb_headlen() check, a tagged frame with a short linear he=
ad
> goes to the else branch. The original 802.1Q tag then stays in the payloa=
d,
> and IFH_TCI is set to br0's pvid.
>=20
> dsa_user_xmit() does not linearize the skb here. The user netdev inherits
> NETIF_F_SG from conduit->vlan_features in dsa_user_setup_tagger(). The
> AF_PACKET PACKET_TX_RING path, tpacket_snd()->tpacket_fill_skb(), copies
> only hard_header_len (14) bytes into the linear area.
>=20
> Could the rewriter then push a second tag, so the frame goes out
> double-tagged or in the wrong VLAN? Would a pskb_may_pull() of
> VLAN_ETH_HLEN before this check avoid that?
>=20
> [Severity: Low]
> Is the VLAN_ETH_HLEN check enough for vlan_remove_tag()?
>=20
> When h_vlan_encapsulated_proto is an 802.3 length, vlan_set_encap_proto()
> also reads the two bytes after the VLAN header:
>=20
> include/linux/if_vlan.h:vlan_set_encap_proto() {
>         ...
>         rawp =3D (unsigned short *)(vhdr + 1);
>         if (*rawp =3D=3D 0xFFFF)
>         ...
> }
>=20
> lan9645x has no needed_tailroom, so dsa_user_xmit() does not pad the fram=
e.
> skb_put_padto() in lan9645x_xmit() only runs after this function returns.
>=20
> Take an 18 or 19 byte frame such as DA SA 8100 TCI <len>. Can this read
> uninitialized tailroom past skb_tail_pointer()? The only effect is whethe=
r
> skb->protocol becomes ETH_P_802_3 or ETH_P_802_2, but KMSAN would likely
> report an uninit-value.
>=20
> > +             *vlan_tci =3D tci;
> > +     } else {
> > +             rcu_read_lock();
> > +             br_vlan_get_pvid_rcu(br, &tci);
> > +             rcu_read_unlock();
>=20
> [Severity: High]
> Is br_vlan_get_pvid_rcu() being passed the right device here?
>=20
> br comes from dsa_port_bridge_dev_get(), so it is the bridge master. This
> call returns the pvid of br0's own VLAN group. That VID is unrelated to t=
he
> egress port and to the VLAN the bridge forwarded the frame in, because
> br_handle_vlan() already cleared the tag for an egress-untagged VLAN.
>=20
> lan9645x_xmit() then writes that VID into IFH_TCI with IFH_BYPASS set, so
> the rewriter uses it as the classified VID:
>=20
>         lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
>         ...
>         lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);
>=20
> The later "net: dsa: lan9645x: add vlan support" patch changes
> lan9645x_vlan_port_apply_egress(). It programs a hybrid port (one untagge=
d
> VLAN plus tagged VLANs) as LAN9645X_TAG_NO_PVID_NO_UNAWARE, with PORT_VID
> set to the untagged VID. In that mode every frame is tagged unless
> VID =3D=3D PORT_VID or VID =3D=3D 0.
>=20
> For example, say br0 has pvid 1 (the default), and swp1 has VLAN 10 as
> pvid/untagged plus VLAN 20 tagged. A frame sent by the host in VLAN 10 (f=
rom
> br0.10, or ARP flooded by the bridge) reaches this code untagged and gets
> VID 1. So does a frame forwarded in software in VLAN 10.
>=20
> Would the switch then send it on the wire tagged with VLAN 1 instead of
> untagged in VLAN 10?


This is legitimate. I will fix this.

>=20
> > +             *vlan_tci =3D tci;
> > +     }
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
> [Severity: High]
> This isn't a bug introduced by this patch. The racy pattern is in the DSA
> core and is already used by tag_ocelot, tag_sja1105, tag_dsa and others;
> this tagger adds another user of it.
>=20
> dsa_port_bridge_dev_get() reads dp->bridge twice on the TX path. It holds
> no lock and uses neither READ_ONCE() nor RCU:
>=20
>         return dp->bridge ? dp->bridge->dev : NULL;
>=20
> The following path runs under rtnl:
>=20
> del_nbp()
>   netdev_upper_dev_unlink()
>     dsa_port_bridge_leave()
>       dsa_port_bridge_destroy()
>=20
> It clears dp->bridge and, on the last reference, frees the dsa_bridge
> without waiting for a grace period:
>=20
> net/dsa/port.c:dsa_port_bridge_destroy() {
>         ...
>         dp->bridge =3D NULL;
>=20
>         if (!refcount_dec_and_test(&bridge->refcount))
>                 return;
>         ...
>         kfree(bridge);
> }
>=20
> TX on the user port (AF_PACKET or locally generated traffic) is not
> quiesced at that point.
>=20
> Can a concurrent lan9645x_xmit() read ->dev from freed memory, or reload
> dp->bridge after it became NULL? The result is then passed to
> br_vlan_enabled(), br_vlan_get_proto() and br_vlan_get_pvid_rcu().
>=20
> [ ... ]
>=20

Dismissed.

This is preexisting and a DSA core pattern shared with tag_ocelot, tag_dsa,
tag_sja1105, tag_vsc73xx_8021q and dsa_software_vlan_untag(). dsa_bridge
is freed in dsa_port_bridge_destroy() without a grace period, so no
tagger can fix it locally.



> > +static struct sk_buff *lan9645x_rcv(struct sk_buff *skb,
> > +                                 struct net_device *ndev)
> > +{
>=20
> [ ... ]
>=20
> > +     dp =3D dsa_user_to_port(skb->dev);
> > +
> > +     if (dsa_port_is_vlan_filtering(dp) && vlan_tci) {
> > +             u16 port_pvid =3D 0;
> > +
> > +             br_vlan_get_pvid_rcu(skb->dev, &port_pvid);
> > +
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
> > +             if ((vlan_tci & VLAN_VID_MASK) !=3D port_pvid)
> > +                     __vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q),
> > +                                            vlan_tci);
>=20
> [Severity: Medium]
> What happens to a double-tagged frame whose outer VID equals the pvid?
>=20
> The later "net: dsa: lan9645x: add vlan support" patch sets
> ANA_VLAN_CFG_VLAN_POP_CNT=3D1 without VLAN_INNER_TAG_ENA, so VLAN-aware p=
orts
> pop exactly one tag.
>=20
> Take outer VID 100 (the pvid) with an inner C-tag 200. The frame is
> extracted with popcnt =3D=3D 3, the inner tag is still in the payload, an=
d
> IFH_TCI reports VID 100.
>=20
> No tag is restored here in that case. eth_type_trans() in dsa_switch_rcv(=
)
> then sets skb->protocol to 0x8100, and __netif_receive_skb_core() turns t=
he
> inner tag into hwaccel VID 200 via skb_vlan_untag().
>=20
> Would the software bridge then classify the frame to VLAN 200, while the
> hardware forwarded it in VLAN 100?
>=20

Correct. The pvid comparison in lan9645x_rcv() assumed a frame tagged
with the pvid cannot be told apart from an untagged one, but the IFH
reports whether the rewriter popped a tag. v14 restores the classified
VID as a hwaccel tag whenever a tag was popped.


> [Severity: Low]
> The commit message says this assumes an 802.1Q bridge:
>=20
>     This assumes a bridge vlan_protocol of 802.1Q, which is the only
>     protocol the driver offloads.
>=20
> The later "net: dsa: lan9645x: add vlan support" patch documents the same
> limitation. Is anything enforcing it?
>=20
> DSA does not handle SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL, and
> __br_vlan_set_proto() sends it with SWITCHDEV_F_SKIP_EOPNOTSUPP. So an
> 802.1ad bridge cannot be refused that way.
>=20
> On such a bridge, __allowed_ingress() sees skb->vlan_proto !=3D
> br->vlan_proto. It pushes the tag back into the payload and classifies th=
e
> frame to the pvid. Terminated frames on non-pvid VLANs would then land on
> the pvid, or be dropped if the port has no pvid.
>=20
> lan9645x_xmit_get_vlan_info(), on the other hand, handles 802.1ad
> explicitly:
>=20
>         *tag_type =3D (proto !=3D ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S =
:
>                                              LAN9645X_IFH_TAG_TYPE_C;
>=20
> Should 802.1ad bridges be refused in port_bridge_join? Should xmit and rc=
v
> also handle an 802.1ad bridge the same way?
>=20
> > +     }
> > +
> > +     return skb;
> > +}
> > +
> > +static const struct dsa_device_ops lan9645x_netdev_ops =3D {
> > +     .name                   =3D LAN9645X_NAME,
> > +     .proto                  =3D DSA_TAG_PROTO_LAN9645X,
> > +     .xmit                   =3D lan9645x_xmit,
> > +     .rcv                    =3D lan9645x_rcv,
> > +     /* Covers the extraction prefix too, since dsa_tag_protocol_overh=
ead()
> > +      * sizes the conduit MTU from this.
> > +      */
> > +     .needed_headroom        =3D LAN9645X_TOTAL_TAG_LEN,
> > +};
>=20
> [Severity: Medium]
> There is no .flow_dissect callback here, so __skb_flow_dissect() falls ba=
ck
> to dsa_tag_generic_flow_dissect(). That helper assumes the tag overhead i=
s
> exactly needed_headroom:
>=20
> include/net/dsa.h:dsa_tag_generic_flow_dissect() {
>         ...
>         *offset =3D tag_len;
>         *proto =3D ((__be16 *)skb->data)[(tag_len / 2) - 1];
> }
>=20
> Does that hold for this tagger? Whenever the rewriter popped tags,
> lan9645x_rcv() skips a 4 or 8 byte ifh_gap_len between the IFH and the
> real DMAC.
>=20
> The later "net: dsa: lan9645x: add vlan support" patch sets
> ANA_VLAN_CFG_VLAN_POP_CNT=3D1 on VLAN-aware ports. So every tagged frame
> received on those ports has a 4 byte gap.
>=20
> For those frames, would the generic dissector take SMAC or gap bytes as t=
he
> EtherType and use the wrong network header offset? That would misdirect R=
PS
> and skb_get_hash() on the conduit.
>=20

Correct, the generic dissector takes needed_headroom as the rx tag
length, which only holds when the rewriter did not pop a tag on
extraction. v14 adds a .flow_dissect callback.

> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260929-dsa_lan9645x_switch_driver_base-v13-0-827c2d3617f2%40microchip=
.com



pw-bot: cr

