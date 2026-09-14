Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1F3D890C;
	Mon, 14 Sep 2026 20:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418821; cv=none; b=n7rcrHwulSnabHUKSSqrMuFxhoUfviWtCcJ308DlgJjnKAYqIyNdUAJS0Z8FFTZEaOeC0bzPZgTcWfdNaPSUr0kjZgM6RwGOsERtgUBoy2R0S0VrHjkkTTZ7h2S0zROdwKA0L99MEijmlwtY0IgTejUbfhGyvQHLm8qze3t0UjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418821; c=relaxed/simple;
	bh=jeyrm3nsjD+chp6RCExqopzif2u4TC2+Cui31lKSicU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQbfgRMDPHmMbdwYAIaZKVDtS2XtBbsyVYjpKsn8nE/Mitr6apn0Mnfi4eoYZFUs82Dx4NLwXGUUN6dTkWpWaO9X7tBpbIHBj+LaIzHKei49MYvkChViBxdMeRbJ4st+nfbz59y/TlFmTA5HCbTVTtc14WEQaIFAhLlNcR5WSKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qtg6kM3D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qtg6kM3D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA11D1F00893;
	Mon, 14 Sep 2026 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418819;
	bh=hAw0VwPutfPW6cDbJEw48mEBwRUsKU0f6DcR+a4zSsE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qtg6kM3Di3QZpJvX8Petzt5s+mZxa9x5F1olBU6Qbe0PZwZwMMtT1A2MC3wPlZiFL
	 J0bntqWT2AJVwt8CQC1jyz9aJcQK31GJR24P24pBish5jUlweKM0Yax4pkF565sPpA
	 yrxAGufn1lzwAp4cLjVLOfHI/76Q7503D2AIbdBJ0jAh1qejKGPGBHjRQ9P6Xfur7p
	 vraAKREVdBfkxCeU/OwFzzu7UL/xx2TQsVoH6oypygQaumxc05JH1mHS2Tam/JbuRO
	 6XPNoVQtaXVh4w61oqyyTzN89fsolgxc4Rj7t553LzfrqGU3EKrecpiuUlU1gTJH5B
	 8DWcdczBdcXYw==
Subject: Re: [PATCH net-next v13 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 14 Sep 2026 20:46:58 +0000
Message-ID: <178941881840.22033.7691857514660688349@kernel.org>
In-Reply-To: <20260913-ks8995-to-ksz8-v13-2-327b16d309eb@kernel.org>
References: <20260913-ks8995-to-ksz8-v13-2-327b16d309eb@kernel.org>
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

- [Medium] net/dsa/tag_ks8995.c declares KS8995_NEEDED_HEADROOM =
  KS8995_TAG_LEN + VLAN_HLEN = 8 (needed for TX, where…
- [Low] net/dsa/tag_ks8995.c:ks8995_rcv() lines 120-134 use the special
  tag's TCI as the only discriminator between a hardware-inserted…

--

net: dsa: tag_ks8995: Add the KS8995 tag handling

This adds a new DSA tagger for the Micrel KS8995 / Microchip KSZ8995XA
switches, which carry the switch tag in a modified 0x8100 ethertype
where the low nibble is a port mask. Egress inserts the special tag at
offset 12 after pushing any hardware-accelerated VLAN tag inside, and
ingress moves the in-band tag into VLAN metadata before resolving the
source port.

A couple of questions below.

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 0000000000000..435665013a864
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,153 @@

[ ... ]

> +#define KS8995_NAME "ks8995"
> +
> +#define KS8995_TAG_LEN		VLAN_HLEN
> +/* Reserve room for the switch tag and a hardware-accelerated VLAN tag. */
> +#define KS8995_NEEDED_HEADROOM	(KS8995_TAG_LEN + VLAN_HLEN)

[Severity: Medium]
The transmit side can add two 4-byte tags, so reserving 8 bytes of
headroom makes sense there, but the in-band tag seen on receive is only
VLAN_HLEN.  Since ks8995_netdev_ops does not provide a .flow_dissect
callback, __skb_flow_dissect() falls back to the generic helper, which
takes needed_headroom as the tag length:

include/net/dsa.h:dsa_tag_generic_flow_dissect() {
	const struct dsa_device_ops *ops = skb->dev->dsa_ptr->tag_ops;
	int tag_len = ops->needed_headroom;

	*offset = tag_len;
	*proto = ((__be16 *)skb->data)[(tag_len / 2) - 1];
}

With tag_len == 8 that reads *proto from skb->data + 6 and advances
nhoff by 8, while the real EtherType of a single-tagged frame sits at
skb->data + 2.  For IPv4 the bogus proto is taken from the IP total
length field, which varies per packet, so skb_get_hash() and any tc
classifier on the conduit would see a different pseudo-protocol per
frame and RPS/RFS could steer one flow across CPUs.

Would it make sense to follow the pattern already used in
tag_sja1105.c:sja1110_flow_dissect() and tag_netc.c:netc_flow_dissect(),
which keep the larger needed_headroom but override the dissector with
*offset = VLAN_HLEN and *proto = ((__be16 *)skb->data)[(VLAN_HLEN / 2) - 1]?

[ ... ]

> +	/* The special tag's TCI is now in the hardware-accelerated VLAN
> +	 * metadata. The switch preserves the TCI of tagged
> +	 * frames, but inserts the ingress port's default tag for untagged frames.
> +	 * Since the driver programs the default tag to 0, a zero TCI identifies
> +	 * an originally untagged frame. Preserve every non-zero TCI as an
> +	 * 802.1Q tag, including VID 0 frames with PCP or DEI set.
> +	 */
> +	if (!skb->vlan_tci) {
> +		netdev_dbg(dev, "%s: clear VLAN tag from frame\n", __func__);
> +		__vlan_hwaccel_clear_tag(skb);
> +	} else {
> +		skb->vlan_proto = htons(ETH_P_8021Q);
> +		netdev_dbg(dev, "%s: vlan_tci = 0x%04x VLAN frame\n",
> +			   __func__, skb->vlan_tci);
> +	}

[Severity: Low]
Does this drop a legal 802.1Q tag whose TCI happens to be all zero?

A station sending a priority tag with VID 0, PCP 0 and DEI 0 produces
TCI == 0x0000 on the wire, and after skb_vlan_untag() moved the special
tag into the metadata that is identical to the switch-inserted default
tag, so ks8995_rcv() takes the __vlan_hwaccel_clear_tag() branch and the
frame reaches the stack untagged.  That would be visible to a VLAN 0
upper interface and to a capture on the user port.

To be clear about what was checked: the default-tag == 0 assumption in
the comment does hold at the end of the series.  The later commit
"net: dsa: microchip: Support Microchip KSZ8995XA / KS8995XA" writes
REG_PORT_CTRL_VID = 0 for every port in ksz8_port_setup():

	/* Use VID 0 to identify untagged frames in the special tag */
	ksz_pwrite16(dev, port, REG_PORT_CTRL_VID, 0);

ksz8995xa_switch_ops exposes no .port_vlan_filtering or .port_vlan_add,
so a bridge PVID cannot end up in that register, and the default port
priority lives in Port Control 0 (KSZ8995XA_PORT_BASED_PRIO in
ksz_dcb.c) rather than in the inserted TCI.  So the only remaining case
is the all-zero wire tag above.  Is that ambiguity worth a note in the
comment, given it is inherent to the tag format?

> +static const struct dsa_device_ops ks8995_netdev_ops = {
> +	.name = KS8995_NAME,
> +	.proto	= DSA_TAG_PROTO_KS8995,
> +	.xmit = ks8995_xmit,
> +	.rcv = ks8995_rcv,
> +	.needed_headroom = KS8995_NEEDED_HEADROOM,
> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260913-ks8995-to-ksz8-v13-0-327b16d309eb%40kernel.org
