Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3DE31AF1B;
	Fri, 31 Jul 2026 02:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464627; cv=none; b=Z1yj14AdXINVrZAfeIvSmGM8/DL1W/t7jawzcmm76R3pKMbYH0x1hAcJ5bmbA7HSBVDHlEgvIpH30Vm/krSat/VMCg7G1KlhotxoBVkHABeBLGwx0ww3OTnTjqVKaiAUrnBNElyESXUOAFlRTqNZySCSPSu0dnlItty22dfQI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464627; c=relaxed/simple;
	bh=WwJGSVIIJ1fKYemV58PL1pJHWMIznBBUXARjFOKw4x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Omrjy1iJBo+0hqoxlgc5u7ezXk2lYhN27j6GvNYF1g947ziV6kllP9Jcu4DLjkvZlkeDhQXv2PIOzGXgBCkscv8wMja2KNMfVeBCSsB8uX8gYboDQPfGoZs48WEnjFuWMXmgyBs5owKuPFS/ByANboqcO0p+9Qo2rR1zt2mUYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ho9HMXe7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho9HMXe7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9221F00A3E;
	Fri, 31 Jul 2026 02:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464625;
	bh=joTOFeAi+LvcFHgMzW8uPYLHHSWRvsJOqPPFwBEpdrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ho9HMXe7vrjKsj3UbOr4IFvqXKcBl5qUk/gC63P/TB0sjhpfIeNIHycDJiZLi6fcD
	 pJx77I1H39QxSjA22p6fuMtz5YHWgD2d3M2xgusYFTouawrSQFYhefsik6omX3Csr2
	 B9w2EvHchV58hxut9V8I/LEx0aWhCju8cA2/NcchrhwzxeBrIyCJrkwpx93NNzu2qB
	 pYhOcNz0+xAa8X+Y5ggHuxCsoM6MjPqksqqZVIS3xu0YPytdYXOlt5Yfy0kZlptGTd
	 NEgB8NvGKVd7rEjb3r0Zn0eraGMiGI0IdjhqPRwIjmym9csU7mjcZOziH38H6Y0l2L
	 XpwZEv1QQUnlg==
From: Jakub Kicinski <kuba@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 08/10] net: dsa: microchip: add KSZ8463 tail tag handling
Date: Thu, 30 Jul 2026 19:23:44 -0700
Message-ID: <20260731022344.800383-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-ksz-new-ptp-v3-8-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-8-caba39e680e3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [8]: [PATCH net-next v3 08/10] net: dsa: microchip: add KSZ8463 tail tag handling ---
commit 20a43ca1297a3640a458d9df2837f23e6b9191ea
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

net: dsa: microchip: add KSZ8463 tail tag handling

This adds a KSZ8463-specific DSA tag driver so that RX timestamps can be
taken from the reserved2 field of the PTP header instead of from the tail
tag, and switches ksz8463_get_tag_protocol() over to the new
DSA_TAG_PROTO_KSZ8463.  A few questions below about the new receive and
transmit paths.

> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index 5e5bfc5cae2d..ac9e8ef5774a 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -2966,7 +2966,7 @@ static enum dsa_tag_protocol ksz8463_get_tag_protocol(struct dsa_switch *ds,
>  						      int port,
>  						      enum dsa_tag_protocol mp)
>  {
> -	return DSA_TAG_PROTO_KSZ9893;
> +	return DSA_TAG_PROTO_KSZ8463;
>  }
>  
>  static int ksz8463_connect_tag_protocol(struct dsa_switch *ds,
> @@ -2974,7 +2974,7 @@ static int ksz8463_connect_tag_protocol(struct dsa_switch *ds,
>  {
>  	struct ksz_tagger_data *tagger_data;
>  
> -	if (proto != DSA_TAG_PROTO_KSZ9893)
> +	if (proto != DSA_TAG_PROTO_KSZ8463)
>  		return -EPROTONOSUPPORT;

[Severity: Low]
This changes the user-visible tagging protocol name for KSZ8463 boards,
which is reachable both through the conduit's sysfs "tagging" attribute and
through the "dsa-tag-protocol" device tree property.

A board that currently pins the previous default:

	dsa-tag-protocol = "ksz9893";

now hits the -EPROTONOSUPPORT return in ksz8463_connect_tag_protocol()
instead of degrading to the old behaviour.  Would it be worth mentioning
this compatibility aspect in the commit message?

>  
>  	tagger_data = ksz_tagger_data(ds);

[ ... include/net/dsa.h hunks snipped ... ]

> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index f8b40437c5fa..b4d70ba930dc 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c

[ ... ]

> @@ -396,6 +397,70 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
>  DSA_TAG_DRIVER(ksz9893_netdev_ops);
>  MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
>  
> +#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
> +#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
> +
> +static struct sk_buff *ksz8463_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	u16 queue_mapping = skb_get_queue_mapping(skb);
> +	u8 prio = netdev_txq_to_tc(dev, queue_mapping);
> +
> +	return ksz_common_xmit(skb, dev, false,
> +			       FIELD_PREP(KSZ8463_TAIL_TAG_PRIO, prio),
> +			       0);
> +}

[Severity: Medium]
Is the loss of the tail tag override bit intentional here?

Until this patch KSZ8463 used ksz9893_xmit(), which passes
KSZ9893_TAIL_TAG_OVERRIDE (BIT(5)) as the override_mask argument, and
ksz8795_xmit() likewise passes KSZ8795_TAIL_TAG_OVERRIDE.  ksz8463_xmit()
passes 0, which makes this branch of ksz_common_xmit() dead for the new
tagger:

	if (is_link_local_ether_addr(hdr->h_dest))
		*tag |= override_mask;

Does that mean CPU-injected link-local frames (STP BPDUs, peer delay
multicast, LLDP) are now subject to normal port state filtering, so a port
in BLOCKING or LISTENING state drops them?

KSZ8463_TAIL_TAG_PRIO is GENMASK(4, 3), i.e. the same layout as the KSZ9893
tail tag, which suggests the override bit does exist at BIT(5) on this part.
The KSZ8463 tail tag layout is not documented anywhere in the driver, so if
BIT(5) is in fact reserved on this chip, could the change (and the now
constant override_mask argument) get an explicit note?

[Severity: Medium]
The do_tstamp = false argument means ksz_xmit_timestamp() never runs for
KSZ8463, and that is the only consumer of
KSZ_SKB_CB(skb)->update_correction:

net/dsa/tag_ksz.c:ksz_xmit_timestamp() {
	...
	/* Set correction field to 0 and update UDP checksum */
	ptp_header_update_correction(skb, ptp_type, ptp_hdr, 0);
	...
}

ksz_port_txtstamp() in drivers/net/dsa/microchip/ksz_ptp.c still sets that
field and returns without cloning, expecting the tagger to do the work:

	case PTP_MSGTYPE_PDELAY_RESP:
		if (prt->tstamp_config.tx_type == HWTSTAMP_TX_ONESTEP_P2P) {
			KSZ_SKB_CB(skb)->ptp_type = type;
			KSZ_SKB_CB(skb)->update_correction = true;
			return;
		}

ksz_get_ts_info() also keeps advertising the mode for this chip:

	ts->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ONESTEP_P2P);

	if (is_lan937x(dev))
		ts->tx_types |= BIT(HWTSTAMP_TX_ON);

So user space can select HWTSTAMP_TX_ONESTEP_P2P on a KSZ8463 port while the
tag driver performs no correction field handling at all, and
ksz_port_rxtstamp() still subtracts the ingress timestamp from the
PDelay_Req correction in that mode.  Is the correction field expected to be
handled entirely in hardware here?  If so, could the commit message say so,
since the xmit side behaviour change is not mentioned?

> +
> +static struct sk_buff *ksz8463_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	unsigned int len = KSZ_EGRESS_TAG_LEN;
> +	struct ptp_header *ptp_hdr;
> +	unsigned int ptp_class;
> +	unsigned int port;
> +	ktime_t ts;
> +	u8 *tag;
> +
> +	if (skb_linearize(skb)) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	KSZ_SKB_CB(skb)->tstamp = 0;
> +
> +	/* Tag decoding */
> +	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> +	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
> +
> +	__skb_push(skb, ETH_HLEN);
> +	ptp_class = ptp_classify_raw(skb);
> +	__skb_pull(skb, ETH_HLEN);

[Severity: Low]
This isn't a bug, but the DSA core runs the same classifier a few
instructions later and hands the result to the driver:

net/dsa/tag.c:dsa_skb_defer_rx_timestamp() {
	...
	__skb_push(skb, ETH_HLEN);
	type = ptp_classify_raw(skb);
	__skb_pull(skb, ETH_HLEN);
	if (type == PTP_CLASS_NONE)
		return false;
	return ds->ops->port_rxtstamp(ds, p->dp->index, skb, type);
}

and ksz_port_rxtstamp() already calls ptp_parse_header() itself.  So every
received frame on a KSZ8463 conduit now runs the PTP BPF classifier in the
tagger, even with hardware timestamping disabled, and PTP frames are
classified twice.

Unlike KSZ9477/KSZ9893, where the timestamp sits in the tail tag and has to
be consumed before ksz_common_rcv() trims it, ptp_hdr->reserved2 survives
into ksz_port_rxtstamp() untouched.  Could the reserved2 extraction live in
ksz_port_rxtstamp() instead, where the PTP class is already available?

> +	if (ptp_class == PTP_CLASS_NONE)
> +		goto common_rcv;
> +
> +	ptp_hdr = ptp_parse_header(skb, ptp_class);

[Severity: Medium]
Only PTP_CLASS_NONE is filtered here, but the code below interprets the
frame with the PTPv2 struct ptp_header layout.  ptp_classify_raw() also
returns PTP_CLASS_V1_IPV4/PTP_CLASS_V1_IPV6, as documented in
include/linux/ptp_classify.h:

 * PTP_CLASS_V1_IPV{4,6}, PTP_CLASS_V2_IPV{4,6} or
 * PTP_CLASS_V2_{L2,VLAN}, depending on the packet content.

and the classifier program simply masks the version nibble, so any value
1..15 comes back ORed with the encapsulation bits:

net/core/ptp_classifier.c:
	{ 0x48, 0, 0, 0x0016 },	/* ldh [22] */
	{ 0x54, 0, 0, 0x000f },	/* and #0xf */
	{ 0x44, 0, 0, 0x0010 },	/* or #0x10 */

ptp_parse_header() does no version filtering either, it only skips
VLAN/IP/UDP headers and bounds-checks sizeof(struct ptp_header).  For a
PTPv1 frame, offsets 8..11 are inside the 16-byte subdomain field rather
than a reserved field, so real header content would be read as a timestamp
and then zeroed.  Should there be a "if (!(ptp_class & PTP_CLASS_V2))" gate
before the reserved2 access?

> +	if (ptp_hdr) {
> +		ts = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
> +		KSZ_SKB_CB(skb)->tstamp = ts;
> +		ptp_hdr->reserved2 = 0;
> +	}

[Severity: Medium]
Is there anything that keeps this from running while the switch PTP unit is
disabled?  The tagger never looks at KSZ_HWTS_EN here, and does not even
fetch ksz_tagger_private(), while the transmit side in the same file does
gate on it:

net/dsa/tag_ksz.c:ksz_xmit_timestamp() {
	...
	if (!test_bit(KSZ_HWTS_EN, &priv->state))
		return;
	...
}

That bit is set together with PTP_ENABLE in ksz_ptp_enable_mode():

	tagger_data->hwtstamp_set_state(dev->ds, tag_en);

	return ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_ENABLE,
			 tag_en ? PTP_ENABLE : 0);

so "PTP disabled" is the default state, in which the hardware never wrote
anything into reserved2.  In that state, does this code destroy 4 bytes of a
genuine remote frame (messageTypeSpecific in IEEE 1588-2019) and build
KSZ_SKB_CB(skb)->tstamp out of remote bytes?  ksz_port_rxtstamp() then
publishes it with no prt->hwts_rx_en test:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_port_rxtstamp() {
	...
	tstamp = KSZ_SKB_CB(skb)->tstamp;
	memset(hwtstamps, 0, sizeof(*hwtstamps));
	hwtstamps->hwtstamp = ksz_tstamp_reconstruct(dev, tstamp);
	...
}

ksz9477_rcv() only trusts the timestamp when the hardware sets
KSZ9477_PTP_TAG_INDICATION, and the commit message says KSZ8463 provides no
such indication.  For comparison, hellcreek gates on the enable bit before
touching reserved2, in hellcreek_should_tstamp():

	if (!test_bit(HELLCREEK_HWTSTAMP_ENABLED, &ps->state))
		return NULL;

Would the same gating be appropriate here?

[Severity: Medium]
Does the "ptp_hdr->reserved2 = 0" store need checksum bookkeeping?  For PTP
over UDP (advertised by ksz_get_ts_info() through
HWTSTAMP_FILTER_PTP_V2_L4_EVENT) these 4 bytes are covered by the UDP
checksum, but neither the checksum field nor skb->csum / skb->ip_summed are
updated.

On a conduit reporting CHECKSUM_COMPLETE, skb->csum then still describes the
unmodified bytes and is carried forward by ksz_common_rcv():

	if (pskb_trim_rcsum(skb, skb->len - len)) {

In HWTSTAMP_TX_ONESTEP_P2P mode, ksz_port_rxtstamp() additionally calls
ptp_header_update_correction() on the same frame, which does:

include/linux/ptp_classify.h:ptp_header_update_correction() {
	...
	uhdr->check = csum_fold(ptp_check_diff8(correction_old, hdr->correction,
						~csum_unfold(uhdr->check)));
	...
	skb->ip_summed = CHECKSUM_NONE;
}

so the stack recomputes the UDP checksum over data whose reserved2 delta was
never accounted for.  If the switch updates the UDP checksum when it inserts
the timestamp, would PDelay_Req frames then be dropped in udp_rcv()?  The
same file already uses ptp_header_update_correction() from
ksz_xmit_timestamp() for in-place PTP header edits.

[ ... remaining tag_ksz.c hunks snipped ... ]
