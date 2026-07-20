Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066F389455;
	Mon, 20 Jul 2026 14:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784556466; cv=none; b=aQHFpDXiVSluunIr8uoQ6tsFml6kG/bZu8dM2kuXHBBXoK1BwbFcXCnYYp4rd2OdRmUzX+8XwgOGb4RNcO/hy/j7RsQqgNnQHf/3n6R/5zCvnrPvfpXa7+akjcyDibFBCBAdZBCvwg2OaYqzLuscuw/i16ttOB/sEBxFXyRYhZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784556466; c=relaxed/simple;
	bh=Ld8Q9w4WAhxw0DJeG3FMYwORfV+6NQSa41nhQSNlz10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DO544AB1lVuvaJR5BjxlL+A7nEO0ZqNqyEgRBbiRye427Jg1TqHE+oH9Fn1ueNkrn+hqkwOK52dTFUO3mB9RY2PCS0iRd82OYECf0h6J4Hfowj9kEXDs/YcVUd1I3u9FKl7PsHy454zr541CzMWXMDelzyhgvm8POKEurEciLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+Q5ca6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+Q5ca6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AD41F000E9;
	Mon, 20 Jul 2026 14:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784556464;
	bh=xH5KXGQqm26xh30LTK4vSJ73rBgLBd13X9VYggvXajQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f+Q5ca6bfnpGadZ6Nv22H4thv9G8HntFP53n09ICo7+HbDCVOchXYxm5TVwJmI4gu
	 hED4MOkdXnSmwQ8zvCJuk/lbqcO6dxxegL3kzbpEI46GqOqG6XV+slwWF3xm3DHCLX
	 Qxxrfo/yx7rYaWdNWPfIwEHyVvf22DakOLjHiHRxuYbTe5/vuvojpbTkOP81eePW0l
	 xAi23qPcVeMHyqh36sI/NvdXKzUN6rIdchZmJos+EIQSZExHYrmjfrZsuHNeUUqdt4
	 O7oGGphR8B2Wc/c8wNRg5ku+fgICbLtRVj0NLgEUdrHoql/Yhd8a0/rXFGpufI/HSq
	 fJWFgc2TVItvw==
From: Simon Horman <horms@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: Simon Horman <horms@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 08/10] net: dsa: microchip: add KSZ8463 tail tag handling
Date: Mon, 20 Jul 2026 15:07:29 +0100
Message-ID: <20260720140729.166722-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-ksz-new-ptp-v2-8-7209c05058ef@bootlin.com>
References: <20260713-ksz-new-ptp-v2-8-7209c05058ef@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
https://sashiko.dev/#/patchset/20260713-ksz-new-ptp-v2-1-7209c05058ef@bootlin.com?part=8
---
--- Patch [8]: [PATCH net-next v2 08/10] net: dsa: microchip: add KSZ8463 tail tag handling ---
commit bc95662a9488a7827d30f83890008a818f0a5228
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

net: dsa: microchip: add KSZ8463 tail tag handling

KSZ8463 uses the KSZ9893 DSA TAG driver, but uses reserved fields in the PTP
header for timestamps instead of the tail tag. This commit adds a
KSZ8463-specific DSA_TAG driver to handle KSZ8463 timestamps.

> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index f8b40437c5fa4..477f2997c1a34 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c

[ ... ]

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
> +	/* Tag decoding */
> +	tag = skb_tail_pointer(skb) - KSZ_EGRESS_TAG_LEN;
> +	port = tag[0] & KSZ8463_TAIL_TAG_EG_PORT_M;
> +
> +	__skb_push(skb, ETH_HLEN);
> +	ptp_class = ptp_classify_raw(skb);
> +	__skb_pull(skb, ETH_HLEN);
> +	if (ptp_class == PTP_CLASS_NONE)
> +		goto common_rcv;
> +
> +	ptp_hdr = ptp_parse_header(skb, ptp_class);
> +	if (ptp_hdr) {
> +		ts = ksz_decode_tstamp(get_unaligned_be32(&ptp_hdr->reserved2));
> +		KSZ_SKB_CB(skb)->tstamp = ts;
> +		ptp_hdr->reserved2 = 0;
> +		skb->ip_summed = CHECKSUM_NONE;

[Severity: High]
Does this unconditionally modify the payload of all PTP packets?

If a PTPv1 packet is received, ptp_classify_raw() identifies it as PTP, but
the PTPv1 header structure is different. Blindly casting and zeroing
ptp_hdr->reserved2 aliases bytes 16-19, which corrupts the subdomain string.
Should this check that ptp_class includes PTP_CLASS_V2?

Additionally, altering the UDP payload without updating the UDP checksum and
setting skb->ip_summed = CHECKSUM_NONE forces the network stack to verify the
now-invalid checksum, which causes the packet to be dropped.

> +	}

[Severity: High]
Can this leak uninitialized memory to userspace if a truncated PTP packet is
received?

If ptp_parse_header() returns NULL, KSZ_SKB_CB(skb)->tstamp is left
uninitialized. Later, when the DSA core calls dsa_skb_defer_rx_timestamp(),
this uninitialized value is read and exposed to userspace:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_port_rxtstamp() {
    tstamp = KSZ_SKB_CB(skb)->tstamp;
    memset(hwtstamps, 0, sizeof(*hwtstamps));
    hwtstamps->hwtstamp = ksz_tstamp_reconstruct(dev, tstamp);
    ...
}

> +
> +common_rcv:
> +	return ksz_common_rcv(skb, dev, port, len);
> +}
