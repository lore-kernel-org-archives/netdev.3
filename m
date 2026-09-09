Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C63550DB5;
	Wed,  9 Sep 2026 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955948; cv=none; b=kyn60ePlewH+tS43S0FbD6x8D2jVR34a2YKIn7Fqvb3y1ZxNykRxi89+Fsmzl2zMWnxQec/2eFf+NNBI/yiZYWcSiWF2DLsv+SuTL57e1BqPYINjcDIVdJ7Jk+nI311ionBeeYHMZMWgUADdMEDj8Ap08WZBOfb7+Hf0AJnjdcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955948; c=relaxed/simple;
	bh=0eza9hmbmpnwwdzaEK4z2Fzrj7wxNCMz0u5gRrWgeH8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRJYxlRsR39l+vo4gGr320gnhjZhCFuQgDz4kngNcxa8WGLT7j9gfYkDUpBr34skAzXi7Av49A26uWr/Py+SnzFugEK3omoA887TGvnkcb1ZdeNbcZAqU8GwnWEiyVvs8DtPDzEJDhD/8vCpcF/+6T8D8RP9DZxEjKOZrf1ecNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSp2dZvG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSp2dZvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E1E1F00A3A;
	Wed,  9 Sep 2026 12:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788955947;
	bh=K1YQsi/7IjjFywqyLFJ6weEnZEs1+TwcBvIgqZHVF5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MSp2dZvGMIlaC0h43j9Os59YWqitOgaiQ2aqKSgiM2RKRolfvSVrdE2iCAOY141ec
	 XAZ1L23Uv7xIrdCh5HOEe9eM2VsphL310mFuRCnaMbBXDhgzHQw0tb2bLS/dEaDw6k
	 1DeHFu1WO2E8KOCaSr0Yp5ja+I377j8uqtnxwyNipCM/DBurZ07dDZhobuhb6440Np
	 Mqu/r5dZvQ3OaPg0ce4z6S+rKuHPKCP3xiAEKW5YNxUnNQD60cHtYi1d9XZkXVJxsW
	 +a4FJriPkKv9qNxIILm/zMm0uyMeK/qiJFIGG4hXvPCtJopdN22aC/RJr32Jmfnqwt
	 RVsL8SOVDU7Ag==
Subject:
 Re: [PATCH net-next v2 3/4] net: dsa: Add tag handling for SoC-e switches
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, martin.kaistra@linutronix.de,
 b.spranger@linutronix.de
Date: Wed, 09 Sep 2026 12:12:25 +0000
Message-ID: <178895594594.219967.10703472718792333808@kernel.org>
In-Reply-To:
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-3-fb0587cb466b@linutronix.de>
References:
 <20260903-devel-vstrassheim-soce-dsa-ml-v2-3-fb0587cb466b@linutronix.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 1

- [Medium] sdsa_rcv() (net/dsa/tag_sdsa.c, lines 86-87) unconditionally
  destroys every received frame whose SDSA header has the VLAN-info bit…
- [Low] Concern (INVALIDATED by series context): 'the new DSA tag
  protocol DSA_TAG_PROTO_SDSA / CONFIG_NET_DSA_TAG_SDSA has no in-tree…

--

net: dsa: Add tag handling for SoC-e switches

This adds a new DSA tagger for SoC-e switches, which insert an 8-byte SDSA
header with EtherType 0xdcdc between the source MAC address and the original
EtherType.  Both TO_CPU and FROM_CPU directions are handled, while the VLAN
metadata fields in the header are left clear on transmit and rejected on
receive.

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 23b4b74004ed5..0032ccd3badf6 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -188,6 +188,12 @@ config NET_DSA_TAG_RZN1_A5PSW
>  	  Renesas RZ/N1 embedded switch that uses an 8 byte tag located after
>  	  destination MAC address.
>  
> +config NET_DSA_TAG_SDSA
> +	tristate "Tag driver for SoC-e switches using EtherType SDSA headers"
> +	help
> +	  Say Y or M if you want to enable support for tagging frames for the
> +	  SoC-e switches.
> +

[Severity: Low]
This isn't a bug, just a note so it does not get raised again during review.
Taken on its own, this patch adds a tagger and a protocol id with no in-tree
user.  The next patch in the series, "net: dsa: soce: Add basic support for
SoC-e switch IP cores", adds drivers/net/dsa/soce/ whose Kconfig contains
select NET_DSA_TAG_SDSA and whose soce_get_tag_protocol() returns
DSA_TAG_PROTO_SDSA, so the tagger is reachable by the end of the series.

[ ... ]

> diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
> new file mode 100644
> index 0000000000000..83bccd65b1b1d
> --- /dev/null
> +++ b/net/dsa/tag_sdsa.c
> @@ -0,0 +1,123 @@

[ ... ]

> +/* SDSA tag byte layout (after the 12-byte MAC header):
> + * Bytes 0-1: SDSA EtherType (0xDCDC)
> + * Bytes 2-3: Reserved
> + * Byte 4:    Frame type (bits 7-6), VLAN-info bit (bit 5), port[9:5] (bits 4-0)
> + * Byte 5:    Port[4:0] (bits 7-3)
> + * Bytes 6-7: PCP (bits 7-5) / CFI (bit 4) / VID (bits 3-0 + byte 7), only
> + *            meaningful when the VLAN-info bit is set.
> + */

[ ... ]

> +static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_device *dev)
> +{

[ ... ]

> +	tag->port_lo = FIELD_PREP(SDSA_TAG_PORT_LO_MASK, dp->index);
> +	tag->vlan = 0;
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *sdsa_rcv(struct sk_buff *skb, struct net_device *dev)
> +{

[ ... ]

> +	/* SDSA VLAN information is not supported. */
> +	if (tag->frame_type_port_hi & SDSA_TAG_VLAN_BIT)
> +		goto out_drop;

[Severity: Medium]
Can this drop every VLAN-tagged frame destined for the CPU?

The layout comment in this file states that bytes 6-7 carry PCP/CFI/VID and
are "only meaningful when the VLAN-info bit is set", so the hardware appears
to move the frame's VLAN identity out of the frame body and into the tag.

The SDSA layout looks like a close relative of Marvell (E)DSA: proprietary
EtherType, two reserved bytes, command in bits 7-6 of the first tag byte,
port in bits 7-3 of the second byte, and the VLAN indication in bit 5.  In
tag_dsa.c that bit means the frame arrived VLAN-tagged and the tagger
reconstructs the 802.1Q header rather than dropping the frame:

net/dsa/tag_dsa.c:dsa_rcv_ll() {
	...
	if (dsa_header[0] & 0x20) {
		u8 new_header[4];

		/* Insert 802.1Q ethertype and copy the VLAN-related
		 * fields, but clear the bit that will hold CFI (since
		 * DSA uses that bit location for another purpose).
		 */
		new_header[0] = (ETH_P_8021Q >> 8) & 0xff;
		new_header[1] = ETH_P_8021Q & 0xff;
		new_header[2] = dsa_header[2] & ~0x10;
		new_header[3] = dsa_header[3];
	...
}

If the SoC-e core sets bit 5 for ordinary tagged ingress in any supported
configuration, all such traffic towards the CPU is freed here.  The driver
added later in the series only programs SOCE_TAG_ALL_FRAMES_ENABLE and
SOCE_CUSTOM_RULES_TAGGING_ENABLE in soce_sw_enable_tagging() and implements
no VLAN operations at all, so nothing turns this hardware behaviour off.
Is it known that the core never sets that bit?

The drop itself is a bare kfree_skb() with no drop reason, counter, or
ratelimited message, so from userspace the resulting loss is hard to tell
apart from a link or MAC problem.  Would kfree_skb_reason() be worth using
for these paths?

On the transmit side, sdsa_xmit() writes tag->vlan = 0 with the VLAN-info
bit left clear while any 802.1Q header stays inline in the payload.  If the
switch expects the egress VLAN identity in the tag, as the Marvell-style
parts do in tag_dsa.c:

net/dsa/tag_dsa.c:dsa_xmit_ll() {
	...
	if (skb->protocol == htons(ETH_P_8021Q) &&
	    (!br_dev || br_vlan_enabled(br_dev))) {
		...
		dsa_header[0] = (cmd << 6) | 0x20 | tag_dev;
	...
}

would FROM_CPU frames then be injected as untagged/PVID-assigned with the
inline 802.1Q header treated as opaque payload?

The commit message does say the field could not be tested:

    SDSA VLAN metadata generation could not be tested on the available
    switch configuration yet. Leave these fields clear on transmit and
    reject receive headers which mark the metadata as valid.

Could the receive side pass such frames up (or at least count them) instead
of discarding them, so an untested field does not turn into silent packet
loss?

> +
> +	/* Determine the source port from the two port fields. */
> +	source_port = FIELD_GET(SDSA_TAG_PORT_HI_MASK,
> +				tag->frame_type_port_hi) <<
> +		      SDSA_TAG_PORT_HI_SHIFT;
> +	source_port |= FIELD_GET(SDSA_TAG_PORT_LO_MASK, tag->port_lo);
> +
> +	skb->dev = dsa_conduit_find_user(dev, 0, source_port);
> +	if (!skb->dev)
> +		goto out_drop;

[ ... ]

> +out_drop:
> +	kfree_skb(skb);
> +	return NULL;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b%40linutronix.de
