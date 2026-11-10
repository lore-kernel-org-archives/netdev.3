Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.153.233
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318102;
	b=onZBplXS5pbuVGqEtV/MfFGpKTlYD8XF4TMIIggjMFvEXnQFwm7eDCm0ay+SamU9fvJv
	 iAmgqmJp+8FQ7HDUj+zWI4RUvTvHYQ3ztLCx/wQlG523ZFXGB9o9ME2ZRhGctEN1OVcuz
	 ObS811o5lLcqX3qGKLNCmu1857M4X4mpyVQiJdl8L8nw9bOHFI5jI4o38MqCZ5JNBFi0E
	 mFT3FyKlpn2IFntH2VwndKvXcOc5+k9id4qycRlqPUsKsrybDLjweHbDo0a2BFHi5kWVs
	 RcqtPD9OxHmRvkQnhiyxae/O2VqmRGVNktULCHB0eraLEr9Dkvmd5iVpUsmHaz4l8HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318102;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-ID:CC:From:To:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=lasqxXVeKXMxHny0oj9QIIm0EdQKa7hCoZn0gBzmIq4=;
	b=FekfZoBchlVTwebS8x6KVP5+kgbciAwZPaHK6uWaNX9qTkquEWik6nRkhCNlDHlMfiIW
	 G/NlpUUVVt6L/pfLZ0hNROYBpU7rPzlNF5afWzWIPbvXE8jfcsGv2Ly+/wRZSYClqMhpg
	 6/4Id0r59YIrHeRsgU1BGg7X9QCIi6+WawIGBsXzwp2Spu+6AJjqbLWI8bh95tYSHUF1l
	 v7JQeb2JX/fB2m/YMUPaxq4dR/wJmyy/C7J8RvqcKYHuAU0bMozK3RoS5tc6UKCFGrhHu
	 0lHD8+EvLydJ9HEqTCNbw14WIHqT9eYMHK3mzzyC1wz/m5pEtZkgmJrWClJE+F/TgOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=iW59M+8o;
	arc=none smtp.remote-ip=68.232.153.233
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99D2606A321;
	Tue, 10 Nov 2026 13:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B99D2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=iW59M+8o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1794318107; x=1825854107;
  h=mime-version:content-transfer-encoding:date:message-id:
   cc:from:to:subject:references:in-reply-to;
  bh=c/J2BX5zYovG7XXcvnry2XAw/WRw3cFjhkZ9MkToNyk=;
  b=iW59M+8oln9X+WWzxl0gG8aKrZSib7EeaX9KFoZN9Fsztq6VU6OmILYd
   dNflNr2PUJ4ruZxMPNR1KHBdcxwZPHqo6GHW2wZyn8XUFsCHc99OJteVg
   iMDaZUQJGjxxlnfRyaeZ3nbRKibkZKXYa0wSJQ09gstX4UTnuTfLKLeFG
   udDwFnMDAMzHcKG5w4LG15Ulmn+eDVZt5B/QlzCiCjTZQ0STyT2qjixT+
   IJRl2+UnZKpqjomchMUXJIALaWq1kdoe7SN34luaR9Kn7gbChKd+JJ7EC
   BjZP43wW2Mvx+OpOVzHrunbms/VagrrcHStpu4Sw5t8cc3+QOlx0alaKc
   w==;
X-CSE-ConnectionGUID: 6uO7UKHWTY+5neRwOdB0yw==
X-CSE-MsgGUID: O8hmv08iQbeHE26wbSZtlg==
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="76951348"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 06:41:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Tue, 10 Nov 2026 06:41:34 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Tue, 10 Nov 2026 06:41:33 -0700
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Nov 2026 14:41:32 +0100
Message-ID: <DMRKOG9MGJ12.7OG591B2X3XB@microchip.com>
CC: <UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <horms@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<woojung.huh@microchip.com>, <linux@armlinux.org.uk>,
	<Steen.Hegelund@microchip.com>, <daniel.machon@microchip.com>,
	<geert+renesas@glider.be>, <magnus.damm@gmail.com>, <edumazet@kernel.org>,
	<richardcochran@gmail.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>
From: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard?=
	<jensemil.schulzostergaard@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>, <jensemil.schulzostergaard@microchip.com>
Subject: Re: [PATCH net-next v16 1/4] net: dsa: add tag driver for LAN9645X
X-Mailer: aerc 0.21.0
References: <20261103-dsa_lan9645x_switch_driver_base-v16-1-781c96d735cf@microchip.com> <20261110112810.235223-1-pabeni@redhat.com>
In-Reply-To: <20261110112810.235223-1-pabeni@redhat.com>

On Tue Nov 10, 2026 at 12:28 PM CET, Paolo Abeni wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> --- Patch [1]: [PATCH net-next v16 1/4] net: dsa: add tag driver for LAN9=
645X ---
> commit 9f0c74e8611a75335b66615c753e5ac04e4a4bc9
> Author: Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@micro=
chip.com>
>
> net: dsa: add tag driver for LAN9645X
>
> This adds a DSA tag driver for the Microchip LAN9645x switch. It uses a
> front port as an NPI CPU port, with a long prefix plus a 28 byte IFH on
> extraction and a bare IFH on injection. On receive, the classified VID
> popped by the rewriter is restored as a hwaccel C-tag. On transmit, a tag
> with a non-zero VID is moved from the payload into the IFH.
>
>> diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
>> new file mode 100644
>> index 0000000000000..9b373bac91e90
>> --- /dev/null
>> +++ b/net/dsa/tag_lan9645x.c
>> @@ -0,0 +1,513 @@
>
> [ ... ]
>
>> +static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
>> +				     struct net_device *ndev)
>> +{
>
> [ ... ]
>
>> +	qos_class =3D netdev_get_num_tc(ndev) ?
>> +		    netdev_get_prio_tc_map(ndev, skb->priority) :
>> +		    skb->priority;
>> +	qos_class =3D min_t(u32, qos_class, GENMASK(IFH_QOS_CLASS_SZ - 1, 0));
>> +
>> +	/* Make room for IFH */
>> +	ifh =3D skb_push(skb, LAN9645X_IFH_LEN_BYTES);
>> +	memset(ifh, 0, LAN9645X_IFH_LEN_BYTES);
>> +
>> +	lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
>> +	lan9645x_ifh_set(ifh, tag_type, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
>> +	lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);
>> +	lan9645x_ifh_set(ifh, qos_class, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
>> +	lan9645x_ifh_set(ifh, BIT(dp->index), IFH_DSTS, IFH_DSTS_SZ);
>
> [Severity: Medium]
> [Finding: main-7-6]
> [Sources: opus-5-5]
> Should IFH_IPV be set here too?
>
> The field table at the top of the file lists IFH_IPV (pos 48, width 3)
> under "Extraction/Injection header". Nothing on the xmit path writes it,
> so after the memset() it is 0 for every injected frame.
>
> The commit message says LAN9645x is in the same family as lan966x, and th=
e
> IFH layouts are close (IFH_TCI is at bit 103 in both). lan966x_ifh.h
> describes QOS_CLASS as "Classified internal priority for queuing" and IPV
> as "Classified internal priority for resourcemgt, tagging etc".
> lan966x_port_xmit() sets both of them:
>
> drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_port_xmit()=
 {
>     ...
> 	lan966x_ifh_set_qos_class(ifh, skb->priority >=3D 7 ? 0x7 : skb->priorit=
y);
> 	lan966x_ifh_set_ipv(ifh, skb->priority >=3D 7 ? 0x7 : skb->priority);
>     ...
> }
>
> The lan9645x switch driver in this series reserves buffers per
> (port, prio) through QSYS_RES_CFG. If IPV stays at 0, would high priority
> traffic injected from the CPU be queued by QOS_CLASS but charged against
> the prio 0 reservation? Any tagging or mapping based on IPV would also
> see priority 0.
>
> Could IFH_IPV be set to the same clamped qos_class? If LAN9645x ignores
> IPV on injection when BYPASS=3D1, could a comment say so?
>

Correct. With IFH.BYPASS set the analyzer is skipped and the queue
system takes the egress queue from IFH.IPV, so every injected frame was
queued in queue 0. The next version sets IFH.IPV to the same clamped QoS
class as IFH.QOS_CLASS.

> [ ... ]
>
>> +	/* While we have REW_PORT_CFG_NO_REWRITE=3D0 on the NPI port, we still
>> +	 * disable port VLAN tag pushing with REW_TAG_CFG. A frame ingressing
>> +	 * on a vlan aware port, which is forwarded to the CPU, will not carry
>> +	 * vlan info in the frame data, because the tag is popped. The
>> +	 * classified VID is only communicated via the IFH, never in the
>> +	 * payload. We therefore restore it via hwaccel and must not pop an
>> +	 * in-band tag here.
>> +	 */
>> +	if (ifh_gap_len) {
>> +		/* The tag is restored as a C-tag, not as the TAG_TYPE the IFH
>> +		 * reports. The classifier recognizes both TPIDs as VLAN tags,
>> +		 * so an S-tag has already been used for classification by the
>> +		 * time we get here. Restoring it as 802.1AD would make the
>> +		 * bridge push it back into the payload and reclassify the frame
>> +		 * to the port pvid, on a different VID than the one the
>> +		 * hardware forwarded it on.
>> +		 */
>> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);
>
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5-5]
> Do lan9645x_xmit_get_vlan_info() and lan9645x_rcv() agree on which bridge
> VLAN protocols are supported?
>
> On xmit, the bridge TPID is read with br_vlan_get_proto(). An in-band tag
> is stripped only when its TPID matches that protocol, and an S-type tag i=
s
> signalled for 802.1ad:
>
> lan9645x_xmit_get_vlan_info() {
>     ...
> 	br_vlan_get_proto(br, &proto);
>     ...
> 		if (ntohs(hdr->h_vlan_proto) =3D=3D proto &&
> 		    ntohs(hdr->h_vlan_TCI) & VLAN_VID_MASK) {
>     ...
> 	*tag_type =3D (proto !=3D ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
> 					     LAN9645X_IFH_TAG_TYPE_C;
>     ...
> }
>
> On rcv, IFH_TAG_TYPE is never read, and the tag always comes back with
> vlan_proto 0x8100.
>
> With a VLAN-aware bridge set to vlan_protocol 802.1ad, br->vlan_proto is
> 0x88a8. Wouldn't __allowed_ingress() in net/bridge/br_vlan.c then see a
> protocol mismatch?
>
> net/bridge/br_vlan.c:__allowed_ingress() {
>     ...
> 	if (skb->vlan_proto !=3D br->vlan_proto) {
> 		/* Protocol-mismatch, empty out vlan_tci for new tag */
>     ...
> }
>
> In that case the bridge pushes the tag back into the payload and puts the
> frame on the port pvid. The comment above says the C-tag choice avoids
> exactly this, but it only does so when br->vlan_proto is 802.1Q.
>
> The commit message says:
>
>     This assumes a bridge vlan_protocol of
>     802.1Q, which is the only protocol the driver offloads.
>
> Is that enforced anywhere? DSA has no handler for
> SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL. __br_vlan_set_proto() sends that
> attribute with SWITCHDEV_F_SKIP_EOPNOTSUPP, so changing vlan_protocol to
> 802.1ad on an offloaded bridge still succeeds.
>
> If 802.1ad really is unsupported, the TAG_TYPE_S branch in xmit looks dea=
d.
> Otherwise, could rcv take the TPID from IFH TAG_TYPE or from the bridge
> protocol? tag_ocelot.c does this in ocelot_rcv():
>
> 	vlan_tpid =3D tag_type ? ETH_P_8021AD : ETH_P_8021Q;
>
> At the end of this series the lan9645x switch driver does not implement
> bridge join or program VLAN classification yet. So this path stays dorman=
t
> until bridge and VLAN offload is added, and the tagger is not changed lat=
er
> in the series.
>

Dismissed, intentional.

The driver will not support 802.1ad bridges. The hardware classifier
treats both TPIDs as VLAN tags and the egress TPID follows the ingress
tag type, so following the bridge vlan_protocol in rcv would hide one
symptom without making 802.1ad work. On xmit the TPID is taken from the
bridge because the stack picks the TPID of the frames it sends.

The bridge offload patches will reject joining a VLAN-aware bridge and
enabling VLAN filtering when vlan_protocol is not 802.1Q. A later
vlan_protocol change on a bridge that already filters is not seen by the
driver, since DSA does not handle
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL. Rejecting it needs DSA to pass
the attribute to drivers, which is independent of this series.

>> +	}
>> +
>> +	return skb;
>> +}
>
> [ ... ]

pw-bot: cr
