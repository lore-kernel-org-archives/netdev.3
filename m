Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006C524B03;
	Thu, 17 Sep 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789651350; cv=none; b=HbqjDnYp/yuVujPWk37pwe/YeJwjNjzUllW6Sw0ZP+jdq503Qk5yw+B6W7LCSpi1zVMIuumkhR+rprZEPXeHvS3a6kPMcFO2TWW5uwIwbfvIU63sUtVSJylzXl5KI58g1osZ9TGWhqGL2plvoKE1DLJ/ZxizGNfpMr7JZVflIPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789651350; c=relaxed/simple;
	bh=XRQhpR/tdKfQvsSpgHByZsqvvnxW+2nCZMXF45X8FSw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C4jr3z5duc8ZP3F/gtoQQfvKQg1TVzxXEpJus9NSWI3+H1uWcNBFkBUC6v4QXMPwWQj82eBHMay3Q3afDkTNZi9TZ2Uh/8YPPc1KIy1Z/6V2cjFXHKy//phMq7SLFgFJjIUlUkMVMq5HfjLIwfG7afQkjaMYcRczX3zIm/rtuZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFj4jVfU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFj4jVfU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D11F00893;
	Thu, 17 Sep 2026 13:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789651348;
	bh=y37Vn5Tzn+WNN/hkMDRbiOo2Zr1jrMgf08DYagcZFyg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IFj4jVfURPlPem24Ez14o2AubmppnB7ONfPb8JrbAopKMy0C0dqwy4XGnzlBaVcLX
	 rF7ikVG9xEeW+VdOg1e0ka6cDrqCyw2lZb8aLIQ2sckVZf1hnHHx2jR2ub5adBzaIP
	 KLBLzlUYna2l8tm8POAnMwFFEOLbwjFEQWgchzDGOMIeGFvoXpg7HC/yw6vLJ7n3gT
	 mFiF1r0frQYLnkIVD9but5WO9iobl0fNb1nEjg+r3YP8atTAbGz6yiWrkCBJ37P68g
	 YY2u9bvmTLmz92WMSKnTzKRa9ViUnwEY+Gpl9rbUSEZ0cGki+U3G3vBTBR9sisl7uc
	 Js+5OCO/Ibegw==
Subject: Re: [PATCH net-next v15 2/4] net: dsa: tag_ks8995: Add the KS8995 tag
 handling
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 marex@denx.de, horms@kernel.org, linux@armlinux.org.uk, nb@tipi-net.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org
Date: Thu, 17 Sep 2026 13:22:27 +0000
Message-ID: <178965134740.22033.13313484925246996796@kernel.org>
In-Reply-To: <20260916-ks8995-to-ksz8-v15-2-8825ff5fd4be@kernel.org>
References: <20260916-ks8995-to-ksz8-v15-2-8825ff5fd4be@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] When the KS8995 special tag has been stripped into VLAN metadata
  by the conduit MAC, flow dissection of the frame fails:…

--

net: dsa: tag_ks8995: Add the KS8995 tag handling

This adds a DSA tagger for the Micrel KS8995 / Microchip KSZ8995XA switch,
where the switch tag is a modified 0x8100 ethertype with one bit per port
set in the low nibble. The tagger always inserts a distinct outer tag on
transmit and moves an in-band tag into VLAN metadata on receive.

> diff --git a/net/dsa/tag_ks8995.c b/net/dsa/tag_ks8995.c
> new file mode 100644
> index 0000000000000..f011bf01845ef
> --- /dev/null
> +++ b/net/dsa/tag_ks8995.c
> @@ -0,0 +1,180 @@

[ ... ]

> +static struct sk_buff *ks8995_rcv(struct sk_buff *skb, struct net_device *dev)
> +{
> +	int portmask;
> +	int port;
> +	u16 etype;
> +
> +	/* The special tag may be in the packet or VLAN metadata. In either
> +	 * case, its TPID must retain the source-port bits.
> +	 *
> +	 * Read the in-band TPID directly because skb->protocol contains
> +	 * ETH_P_XDSA.
> +	 */
> +	if (skb_vlan_tag_present(skb))
> +		etype = ntohs(skb->vlan_proto);
> +	else
> +		etype = ntohs(*(__be16 *)dsa_etype_header_pos_rx(skb));

[Severity: Low]

This branch accepts a special tag that the conduit MAC has already
stripped into VLAN metadata, so skb->vlan_proto then holds 0x8101,
0x8102, 0x8104 or 0x8108. For those frames, can flow dissection on the
conduit still work?

In __skb_flow_dissect(), the protocol used to reach the DSA tagger hook is
taken from the VLAN metadata when it is present:

net/core/flow_dissector.c:__skb_flow_dissect() {
	...
		proto = skb_vlan_tag_present(skb) ?
			 skb->vlan_proto : skb->protocol;
	...
		if (unlikely(skb->dev && netdev_uses_dsa(skb->dev) &&
			     proto == htons(ETH_P_XDSA))) {
			...
			ops->flow_dissect(skb, &proto, &offset);
	...
}

With proto equal to 0x810X rather than ETH_P_XDSA, ks8995_flow_dissect()
is never called, and 0x810X matches no case in the protocol switch, so
dissection ends in:

net/core/flow_dissector.c:__skb_flow_dissect() {
	...
	default:
		fdret = FLOW_DISSECT_RET_OUT_BAD;
		break;
	...
}

The result is that skb_get_hash() derives a hash from zeroed keys, so RPS,
RFS and tc-flower matching on the conduit see no L3/L4 keys.

Two details worth noting: this only happens with a conduit MAC that strips
the non-standard 0x810X TPID into metadata while preserving the port bits,
which was not demonstrated here, and the same OUT_BAD outcome already
applies to other VLAN-metadata DSA taggers such as the tag_8021q family,
where proto becomes ETH_P_XDSA and also has no case in the switch. Should
the receive path here rely only on the in-band tag, or is degraded hashing
on the conduit acceptable for this configuration?

[ ... ]

> +static void ks8995_flow_dissect(const struct sk_buff *skb, __be16 *proto,
> +				int *offset)
> +{
> +	const __be16 *encap_proto;
> +	__be16 buffer;
> +
> +	*proto = 0;
> +	*offset = 0;
> +
> +	/* Extra TX headroom does not increase the in-band RX tag length. */
> +	encap_proto = skb_header_pointer(skb, KS8995_TAG_LEN - sizeof(buffer),
> +					 sizeof(buffer), &buffer);
> +	if (!encap_proto)
> +		return;
> +
> +	*proto = *encap_proto;
> +	*offset = KS8995_TAG_LEN;
> +}
> +
> +static const struct dsa_device_ops ks8995_netdev_ops = {
> +	.name = KS8995_NAME,
> +	.proto	= DSA_TAG_PROTO_KS8995,
> +	.xmit = ks8995_xmit,
> +	.rcv = ks8995_rcv,
> +	.flow_dissect = ks8995_flow_dissect,
> +	.needed_headroom = KS8995_NEEDED_HEADROOM,
> +};

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be%40kernel.org
