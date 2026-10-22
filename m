Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792669763;
	b=PC0xztcJotFLLHCKamH6F6OPqpKRKt2DefV8q+ve3zJ3rNilBYe+mlaR9bZBNsuPoZDR
	 McKBmCYxZT9fjCabx0Zh7RaL2DHTm9/Qd2LKnkHpGFL3OLq/CtRVfy4fzcFT8WEjcpVaf
	 0T6JEbrNxyjTTxNlo+Lfxwq6IGci1n0rm57Wvfm2B/oPIUVIRJKnIQQJkv4zepXnBAXoa
	 s6E5LVRZQYk2xo2hl2CnfkagsEIYVRV0CWQQjDj2KJQAfv8fBX/njmOJBDzysfkip8FOr
	 iDwjzoN5w5Bgvt8daS9KuFjaqYtkltr+9zjFc0jYSYtOwk/pibQxS8PNsds/k4IYh3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669763;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Message-ID:
	 Subject:From:To:CC:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=/VzV/VZMHqvvinJUfuaB6erP4g4VoHvf1SyJvfY8DD8=;
	b=pCfJx7G6gkzhhefpxYmc/qiJpGTbfq3Vzz+ixNOXET9k6zHMhZWHQfFRnN8EGSgzhg32
	 Mr0Y0ElYaFB1H4jXaKV7kN/PuAaj1iNk7hgdt7bV7NLcoQBstfkUIskbC8VKKj6thvPBg
	 jDTAhv04WwqPUQSbyxuAva6JF7zhNZB9819C7Bnd2Ii9Bv4iNtQkr7/Nx2yu+dNQjBm4l
	 dkvR5U1zn3m1SBoylowiEVzsjSczjA5kSsRvRsdVyUECVUXkH+SHP4GKtiAvjYcaUD4mS
	 /4hI8J2ISanCaxDlLxtkkCNabnty8gaQCmXXzn8wMwTI9SO0vT8BOnsvYMYnyvP4zcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Kt7O2QTv;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DA4606A31A;
	Thu, 22 Oct 2026 11:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94DA4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=Kt7O2QTv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792669763; x=1824205763;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=F4PgbJZxNEcw7r/FJGAa1kPqX9XUD/yLnSSc69tX1Mc=;
  b=Kt7O2QTvll9TKkjoYJJylWCPHayiMlUZJ4Lymni1GuChXI3NswVGoqJj
   EGG4V68+it7SGs0/U5iih/qq25bstKNFyIPGIoMNqncqkHqw8LCNqSzMj
   EbFReMSk5AWzleKaXfgYFhqoyqqBAB744cNhka6RHye9v3i3/8MS4uRBQ
   whbbX4w90jxvCyMXp4D1lJ5SxLf9YkdncQfr4b9s8rBECP3uytKzs7DMV
   DNGQ32tCX6meN+QFEj4r6dYLMdA8JB4wxDW1VuzTLVHb00pnaQQotXru8
   aRBE5hd7wK89vU4XUZXASI4XpIXySLALqm1ZJWicgx5Yde+X6Opl2PVzz
   A==;
X-CSE-ConnectionGUID: 6ulqlsPTSq6pnolVVnUwfA==
X-CSE-MsgGUID: 4oOqcB5GT3S9/oW8xdZ84Q==
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="296840505"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2026 04:49:16 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 22 Oct 2026 04:49:15 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 22 Oct 2026 04:49:11 -0700
Message-ID: <4503da3fc0e046494829c9368756df7fabc6d596.camel@microchip.com>
Subject: Re: [PATCH net-next v15 1/9] net: dsa: add tag driver for LAN9645X
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
Date: Thu, 22 Oct 2026 13:49:11 +0200
In-Reply-To: <179240452203.3135.15637760949369416187@kernel.org>
References: <20261015-dsa_lan9645x_switch_driver_base-v15-1-562f316f78b9@microchip.com>
	 <179240452203.3135.15637760949369416187@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-10-19 at 10:08 +0000, netdev-bot+sashiko@kernel.org wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>=20
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 (1) =C2=B7 Low: 1
>=20
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>=20
> - [Medium] In lan9645x_rcv() (net/dsa/tag_lan9645x.c), the VLAN tag is
>   restored only if the software VLAN-filtering flag is set: `if=E2=80=A6
> - [Low] In lan9645x_rcv() (net/dsa/tag_lan9645x.c), the comment above
>   skb_postpull_rcsum() lists what is subtracted from skb->csum as "what=
=E2=80=A6
>=20
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but
>   lan9645x_xmit() calls dsa_port_bridge_dev_get(dp) (`dp->bridge ?
>=20
> --
>=20
> net: dsa: add tag driver for LAN9645X
>=20
> This adds a DSA tag driver for the Microchip LAN9645x switch. A front por=
t
> is used as the NPI (CPU) port. Extraction uses a 16 byte long prefix plus
> a 28 byte IFH, and injection uses only the IFH.
>=20
> On receive, a VLAN tag popped by the hardware is restored from the IFH as
> a hwaccel C-tag. On transmit, the VLAN tag of a VLAN-aware port is moved
> from the payload into the IFH.
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
> This isn't a bug introduced by this patch, but is it safe to dereference
> dp->bridge here?
>=20
> lan9645x_xmit() runs without rtnl, and dsa_port_bridge_dev_get() uses
> plain loads with no READ_ONCE() or RCU:
>=20
> include/net/dsa.h:dsa_port_bridge_dev_get() {
>         return dp->bridge ? dp->bridge->dev : NULL;
> }
>=20
> At the same time, dsa_port_bridge_leave()->dsa_port_bridge_destroy() runs
> under rtnl and frees the dsa_bridge with no grace period:
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
> Suppose a transmit loads dp->bridge before the NULL store, and the last
> port leaves the bridge before it reads bridge->dev. Could that read be a
> use-after-free of the dsa_bridge?
>=20
> tag_dsa.c, tag_ocelot.c, tag_sja1105.c, tag_vsc73xx_8021q.c and
> dsa_software_vlan_untag() in net/dsa/tag.h already use this pattern. The
> root cause looks like the way DSA core manages the lifetime of struct
> dsa_bridge, not this tagger.


Dismissed, preexisting.

As the review notes, this is the DSA core pattern shared with tag_dsa,
tag_ocelot, tag_sja1105, tag_vsc73xx_8021q and
dsa_software_vlan_untag(). dsa_port_bridge_destroy() frees the
dsa_bridge without a grace period, so a tagger cannot fix it locally.
The fix belongs in the DSA core.


>=20
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
> This isn't a bug, but the comment in lan9645x_rcv() doesn't match the
> length passed here. "what remains of the prefix, the ifh and the gap"
> comes to 2 + 28 + gap bytes.
>=20
> The call subtracts LAN9645X_TOTAL_TAG_LEN + ifh_gap_len, which is
> 44 + gap bytes. That range also covers the 14 byte real ethernet header.
>=20
> The code looks correct, because dsa_switch_rcv() later calls
> skb_push(ETH_HLEN) and eth_type_trans() without adjusting csum. Could the
> comment also list the real ethernet header?
>=20
> [ ... ]
>=20
> > +     dp =3D dsa_user_to_port(skb->dev);
> > +
> > +     if (dsa_port_is_vlan_filtering(dp) && ifh_gap_len) {
>=20
> [Severity: Medium]
> Can a frame lose its VLAN tag here while VLAN filtering is being turned
> on?
>=20
> lan9645x_rcv() strips the gap whenever the hardware reports a pop, but
> it only restores the tag if the software flag is also set. Turning on
> vlan_filtering happens in this order:
>=20
> br_vlan_filter_toggle()
>   br_opt_toggle(br, BROPT_VLAN_ENABLED, !!val)  /* bridge VLAN-aware */
>   switchdev_port_attr_set()
>     dsa_port_vlan_filtering()
>       ds->ops->port_vlan_filtering()
>         lan9645x_port_vlan_filtering()
>           lan9645x_vlan_port_apply()
>             lan9645x_vlan_port_apply_ingress()
>               ANA_VLAN_CFG_VLAN_POP_CNT_SET(1)  /* hw starts popping */
>       dp->vlan_filtering =3D vlan_filtering;      /* tagger flag set */
>=20
> Take a frame extracted after the POP_CNT write but handled before the
> dp->vlan_filtering store. It arrives with ifh_gap_len =3D=3D 4.
> lan9645x_rcv() strips the gap but skips __vlan_hwaccel_put_tag().
>=20
> The bridge is already VLAN-aware, so it sees an untagged frame. It
> classifies the frame to the port pvid, or drops it if there is no pvid,
> and the original VID and PCP are lost.
>=20
> The same window opens when a port joins a bridge that already filters,
> through dsa_port_switchdev_sync_attrs()->dsa_port_vlan_filtering().
>=20
> The hardware only pops tags on a bridged, VLAN-aware port. Would it be
> enough to restore the tag based on ifh_gap_len alone?

Correct. The next version restores the tag whenever ifh_gap_len is non-zero=
,
without looking at dp->vlan_filtering.


>=20
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261015-dsa_lan9645x_switch_driver_base-v15-0-562f316f78b9%40microchip=
.com

pw-bot: cr

