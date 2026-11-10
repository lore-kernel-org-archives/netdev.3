Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310112;
	b=YKfzBuKbvQJmxeJnoAgsEJIMyVCOx2jLuY9ccWixy/p4t7T9TwofBroprDEysArDuHb/
	 eVtnmOcuC5sMy8sylpEk0tZjpVMdyubbqGquu/A4sQ96gdRTQt+01zlfE8F5sCwE9e5qY
	 e4Kvp0cEq3BLDBrIhXhdfqqwE6zDMEiya/7virDvg0SB9LVoxCEK3Ppxk2peRb6w7vRRp
	 bWC9a2UlOvYZn3fG/gHu6wTnC7zSX4txUurQCNRnFKw8vyqlBNZF5KGhPI3RPAqBvxU3V
	 72ZsRLvefW42F+KSaaZngrrGshlrRX0TEljvHVr+g9A26xUZSp+ZCfRC8ldtOh0Csbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310112;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=W8o7mNqRXD7a/i0qeGuO80J0k6FD0xSxVpnhxn9HZxw=;
	b=VBLhxtS60cD+jQHiiVvAqehJSQ7D9BA+BE0fcIIcWgLOux7MNz+NMUvghpki6toHWqew
	 CAQAEMn4TpEpIAIb2qlA7OEFp+XEjuVUu1JT4smmmntOkcQvEyLzs1wfFSdFbI7WwIO+i
	 mmjuhOwUSuJtr1h6AGELJASaD8ecanv0JJF7egouybnGAUplNukpXzvTj2m7aEryeq+jO
	 FapHdldaE5y0GPS42LCtvmE91splai0l5z1soSvzgWCa8AD95ViTc8+h+HpUgSSiHYTTx
	 8CuLRAgOrL2DeW0tRLQaaVKYtLWy87C2t+w6AMMsvaAfE8/dqJJex91OVBDBi02VRgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcaMj9sh;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CEB60A260B
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 11:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86CEB60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FcaMj9sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794310110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8o7mNqRXD7a/i0qeGuO80J0k6FD0xSxVpnhxn9HZxw=;
	b=FcaMj9shU95vq2JPs2ES7jj77smuwbyw6u0qq2x5iFdOPZBwRtFZpUJFCbR26ldMvcEPJS
	lFQdUo9FY30tcCyPNu+A3r6BJFccQvOELeuv9/Lg/0JvQ3y9wSAcooA51IgzQNqphr9I4H
	LSYtJoN8I/FfEXU7YTPGRvqGhhG3qPw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-3ZE-n6o1PymAQnN9SAHdYA-1; Tue,
 10 Nov 2026 06:28:26 -0500
X-MC-Unique: 3ZE-n6o1PymAQnN9SAHdYA-1
X-Mimecast-MFC-AGG-ID: 3ZE-n6o1PymAQnN9SAHdYA_1794310104
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 967D21800605;
	Tue, 10 Nov 2026 11:28:20 +0000 (UTC)
Received: from pabeni-thinkpadp1gen8.rmtit.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E41C18004E9;
	Tue, 10 Nov 2026 11:28:13 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jensemil.schulzostergaard@microchip.com
Cc: UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	woojung.huh@microchip.com,
	linux@armlinux.org.uk,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	edumazet@kernel.org,
	richardcochran@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH net-next v16 1/4] net: dsa: add tag driver for LAN9645X
Date: Tue, 10 Nov 2026 12:28:02 +0100
Message-ID: <20261110112810.235223-1-pabeni@redhat.com>
In-Reply-To: <20261103-dsa_lan9645x_switch_driver_base-v16-1-781c96d735cf@microchip.com>
References: <20261103-dsa_lan9645x_switch_driver_base-v16-1-781c96d735cf@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
--- Patch [1]: [PATCH net-next v16 1/4] net: dsa: add tag driver for LAN9645X ---
commit 9f0c74e8611a75335b66615c753e5ac04e4a4bc9
Author: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>

net: dsa: add tag driver for LAN9645X

This adds a DSA tag driver for the Microchip LAN9645x switch. It uses a
front port as an NPI CPU port, with a long prefix plus a 28 byte IFH on
extraction and a bare IFH on injection. On receive, the classified VID
popped by the rewriter is restored as a hwaccel C-tag. On transmit, a tag
with a non-zero VID is moved from the payload into the IFH.

> diff --git a/net/dsa/tag_lan9645x.c b/net/dsa/tag_lan9645x.c
> new file mode 100644
> index 0000000000000..9b373bac91e90
> --- /dev/null
> +++ b/net/dsa/tag_lan9645x.c
> @@ -0,0 +1,513 @@

[ ... ]

> +static struct sk_buff *lan9645x_xmit(struct sk_buff *skb,
> +				     struct net_device *ndev)
> +{

[ ... ]

> +	qos_class = netdev_get_num_tc(ndev) ?
> +		    netdev_get_prio_tc_map(ndev, skb->priority) :
> +		    skb->priority;
> +	qos_class = min_t(u32, qos_class, GENMASK(IFH_QOS_CLASS_SZ - 1, 0));
> +
> +	/* Make room for IFH */
> +	ifh = skb_push(skb, LAN9645X_IFH_LEN_BYTES);
> +	memset(ifh, 0, LAN9645X_IFH_LEN_BYTES);
> +
> +	lan9645x_ifh_set(ifh, 1, IFH_BYPASS, IFH_BYPASS_SZ);
> +	lan9645x_ifh_set(ifh, tag_type, IFH_TAG_TYPE, IFH_TAG_TYPE_SZ);
> +	lan9645x_ifh_set(ifh, vlan_tci, IFH_TCI, IFH_TCI_SZ);
> +	lan9645x_ifh_set(ifh, qos_class, IFH_QOS_CLASS, IFH_QOS_CLASS_SZ);
> +	lan9645x_ifh_set(ifh, BIT(dp->index), IFH_DSTS, IFH_DSTS_SZ);

[Severity: Medium]
[Finding: main-7-6]
[Sources: opus-5-5]
Should IFH_IPV be set here too?

The field table at the top of the file lists IFH_IPV (pos 48, width 3)
under "Extraction/Injection header". Nothing on the xmit path writes it,
so after the memset() it is 0 for every injected frame.

The commit message says LAN9645x is in the same family as lan966x, and the
IFH layouts are close (IFH_TCI is at bit 103 in both). lan966x_ifh.h
describes QOS_CLASS as "Classified internal priority for queuing" and IPV
as "Classified internal priority for resourcemgt, tagging etc".
lan966x_port_xmit() sets both of them:

drivers/net/ethernet/microchip/lan966x/lan966x_main.c:lan966x_port_xmit() {
    ...
	lan966x_ifh_set_qos_class(ifh, skb->priority >= 7 ? 0x7 : skb->priority);
	lan966x_ifh_set_ipv(ifh, skb->priority >= 7 ? 0x7 : skb->priority);
    ...
}

The lan9645x switch driver in this series reserves buffers per
(port, prio) through QSYS_RES_CFG. If IPV stays at 0, would high priority
traffic injected from the CPU be queued by QOS_CLASS but charged against
the prio 0 reservation? Any tagging or mapping based on IPV would also
see priority 0.

Could IFH_IPV be set to the same clamped qos_class? If LAN9645x ignores
IPV on injection when BYPASS=1, could a comment say so?

[ ... ]

> +	/* While we have REW_PORT_CFG_NO_REWRITE=0 on the NPI port, we still
> +	 * disable port VLAN tag pushing with REW_TAG_CFG. A frame ingressing
> +	 * on a vlan aware port, which is forwarded to the CPU, will not carry
> +	 * vlan info in the frame data, because the tag is popped. The
> +	 * classified VID is only communicated via the IFH, never in the
> +	 * payload. We therefore restore it via hwaccel and must not pop an
> +	 * in-band tag here.
> +	 */
> +	if (ifh_gap_len) {
> +		/* The tag is restored as a C-tag, not as the TAG_TYPE the IFH
> +		 * reports. The classifier recognizes both TPIDs as VLAN tags,
> +		 * so an S-tag has already been used for classification by the
> +		 * time we get here. Restoring it as 802.1AD would make the
> +		 * bridge push it back into the payload and reclassify the frame
> +		 * to the port pvid, on a different VID than the one the
> +		 * hardware forwarded it on.
> +		 */
> +		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tci);

[Severity: Medium]
[Finding: main-1-1]
[Sources: opus-5-5]
Do lan9645x_xmit_get_vlan_info() and lan9645x_rcv() agree on which bridge
VLAN protocols are supported?

On xmit, the bridge TPID is read with br_vlan_get_proto(). An in-band tag
is stripped only when its TPID matches that protocol, and an S-type tag is
signalled for 802.1ad:

lan9645x_xmit_get_vlan_info() {
    ...
	br_vlan_get_proto(br, &proto);
    ...
		if (ntohs(hdr->h_vlan_proto) == proto &&
		    ntohs(hdr->h_vlan_TCI) & VLAN_VID_MASK) {
    ...
	*tag_type = (proto != ETH_P_8021Q) ? LAN9645X_IFH_TAG_TYPE_S :
					     LAN9645X_IFH_TAG_TYPE_C;
    ...
}

On rcv, IFH_TAG_TYPE is never read, and the tag always comes back with
vlan_proto 0x8100.

With a VLAN-aware bridge set to vlan_protocol 802.1ad, br->vlan_proto is
0x88a8. Wouldn't __allowed_ingress() in net/bridge/br_vlan.c then see a
protocol mismatch?

net/bridge/br_vlan.c:__allowed_ingress() {
    ...
	if (skb->vlan_proto != br->vlan_proto) {
		/* Protocol-mismatch, empty out vlan_tci for new tag */
    ...
}

In that case the bridge pushes the tag back into the payload and puts the
frame on the port pvid. The comment above says the C-tag choice avoids
exactly this, but it only does so when br->vlan_proto is 802.1Q.

The commit message says:

    This assumes a bridge vlan_protocol of
    802.1Q, which is the only protocol the driver offloads.

Is that enforced anywhere? DSA has no handler for
SWITCHDEV_ATTR_ID_BRIDGE_VLAN_PROTOCOL. __br_vlan_set_proto() sends that
attribute with SWITCHDEV_F_SKIP_EOPNOTSUPP, so changing vlan_protocol to
802.1ad on an offloaded bridge still succeeds.

If 802.1ad really is unsupported, the TAG_TYPE_S branch in xmit looks dead.
Otherwise, could rcv take the TPID from IFH TAG_TYPE or from the bridge
protocol? tag_ocelot.c does this in ocelot_rcv():

	vlan_tpid = tag_type ? ETH_P_8021AD : ETH_P_8021Q;

At the end of this series the lan9645x switch driver does not implement
bridge join or program VLAN classification yet. So this path stays dormant
until bridge and VLAN offload is added, and the tagger is not changed later
in the series.

> +	}
> +
> +	return skb;
> +}

[ ... ]
-- 
This is an AI-generated review.

