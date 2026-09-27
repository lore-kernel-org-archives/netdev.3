Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3913E23393E;
	Sun, 27 Sep 2026 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790512113; cv=none; b=bXPxeDoKabv3vtFOlzTjCY6CuS2J8mAJ4T0RbjDky4UkDf0f/4+e7+OB6N/dJAPwR425rAnPjZ0QJ831XFokoAOacza27kDpYtcDkIAWNHbZzV0gYUbcdJkInFzChkKDSNpkKtSK+ChvR8+n9DuUiVk9KTkqLu3tRtkTZOvQovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790512113; c=relaxed/simple;
	bh=mFYye6jjimZ2DwZ5t7Du857e1VxY0+BbUH4CzU/N7Rs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEJCCrpIhiT9ISQFtDgwGdIK0tJdWpG7FbvvkHRNzbMqUCd4yotRWfBbofqQQywoWYy1ezfU4sdlFs6GRWc7jmstDOibU8882PsVIlm2Q9/frA9xLz4ICGgh/qcVZBcvqZqbtEAN6mI+B5zagpqF5eTy4JyC0PFIn77NoSKfuew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+8OIQP/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+8OIQP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BE11F000FF;
	Sun, 27 Sep 2026 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790512109;
	bh=eLCzIoer01yXG+2fCSyfbNLUl6x4kDV4QWmMFCv92pM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D+8OIQP/2S0oJcaIteHObvZLAPGhn6zowe0UCySyjCB2CRSQvChyGaUIZOScRZofK
	 kDVEFWa1qhIzl1KUjaTrtVrsRX6J0mlMAeFk8qCm9n1nR8qKfpkvBbrelyQotGNyea
	 15KSPqryCG+kNyutAMkivm0hMA58+VVzLTRGrF1Mb6ijdvr5Z+ra0oWPi+Rt1oWsN9
	 NYgwjG0/NHleJYtl9Zvd1TRpYpGW4O2D5qGt6WQRYYWWMy7V1p3twAFSVRggizTAbJ
	 v97qF3sgrj7vdsuBsq1+pu3cyD+QEkFOVSdD8kWI/t58E5z9rqVQMseu6B0cTD36sW
	 8MbpNRtVDZuyg==
Subject:
 Re: [PATCH net-next v3 4/8] net: dsa: Add tag handling for SoC-e switches
From: netdev-bot+sashiko@kernel.org
To: v.strassheim@linutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux@armlinux.org.uk,
 andrew+netdev@lunn.ch, hkallweit1@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 martin.kaistra@linutronix.de, b.spranger@linutronix.de
Date: Sun, 27 Sep 2026 12:28:27 +0000
Message-ID: <179051210768.2160803.1929188838067459585@kernel.org>
In-Reply-To:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-4-ddebafcb9ba7@linutronix.de>
References:
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-4-ddebafcb9ba7@linutronix.de>
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
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] sdsa_xmit() writes the SDSA header at offset 12 (skb_push +
  dsa_alloc_etype_header).
- [Low] Whether sdsa_xmit() puts the VLAN in the SDSA header on transmit
  depends on the conduit, and in-band 802.1Q tags are never handled.

--

net: dsa: Add tag handling for SoC-e switches

This adds a DSA tagging driver for SoC-e switches. The driver uses an
8-byte SDSA header with EtherType 0xdcdc, placed after the source MAC
address. It builds FROM_CPU frames on transmit and parses TO_CPU frames
on receive, and maps the optional 802.1Q TCI in the header to and from
skb VLAN hwaccel metadata.

> diff --git a/net/dsa/tag_sdsa.c b/net/dsa/tag_sdsa.c
> new file mode 100644
> index 0000000000000..8cc3fa357be42
> --- /dev/null
> +++ b/net/dsa/tag_sdsa.c
> @@ -0,0 +1,158 @@

[ ... ]

> +static struct sk_buff *sdsa_xmit(struct sk_buff *skb, struct net_device *dev)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	struct sdsa_tag *tag;
> +	u16 vlan_tci;
> +
> +	BUILD_BUG_ON(sizeof(*tag) != SDSA_HLEN);
> +
> +	skb_push(skb, SDSA_HLEN);
> +	dsa_alloc_etype_header(skb, SDSA_HLEN);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +	tag->ethertype = cpu_to_be16(ETH_P_SDSA);
> +	tag->reserved = 0;
> +	tag->frame_type_port_hi =
> +		FIELD_PREP(SDSA_TAG_FRAME_TYPE_MASK, SDSA_FRAME_TYPE_FROM_CPU) |
> +		FIELD_PREP(SDSA_TAG_PORT_HI_MASK,
> +			   dp->index >> SDSA_TAG_PORT_HI_SHIFT);
> +	tag->port_lo = FIELD_PREP(SDSA_TAG_PORT_LO_MASK, dp->index);
> +	/* SDSA carries no TPID, so only encode 802.1Q C-tags. */
> +	if (skb_vlan_tag_present(skb) &&
> +	    skb->vlan_proto == htons(ETH_P_8021Q)) {

[Severity: Low]
The commit message says "Encode accelerated VLAN metadata into the header
on transmit". Is the wire format meant to depend on which conduit is
used?

This branch only runs if the skb still has a hwaccel C-tag when it reaches
the tagger. The user port gets its features from the conduit:

net/dsa/user.c:dsa_user_setup_tagger() {
    ...
	user->features = conduit->vlan_features | NETIF_F_HW_TC;
    ...
}

If the conduit's vlan_features do not include NETIF_F_HW_VLAN_CTAG_TX,
validate_xmit_vlan() on the user netdev moves the tag in-band before
dsa_user_xmit() runs:

net/core/dev.c:validate_xmit_vlan() {
    ...
	if (skb_vlan_tag_present(skb) &&
	    !vlan_hw_offload_capable(features, skb->vlan_proto))
		skb = __vlan_hwaccel_push_inside(skb);
    ...
}

In that case the frame goes out with the VLAN-info bit clear, followed by
an in-band 0x8100 tag. This seems to apply to macb (Cadence GEM) on
ZynqMP, which has no HW_VLAN features. It also applies to most other
conduits, for example mlx4, nfp, bnxt, otx2, wangxun, and mtk_eth_soc,
which masks out CTAG_TX explicitly.

With stmmac (dma_cap.vlins) or bcmsysport, whose vlan_features do include
CTAG_TX, the same frame goes out with the TCI in the SDSA header instead.

Should sdsa_xmit() also handle in-band 802.1Q tags, so that the format is
the same on every conduit? Or could the commit message describe this
behaviour?

> +		vlan_tci = skb_vlan_tag_get(skb);
> +		__vlan_hwaccel_clear_tag(skb);
> +		tag->frame_type_port_hi |= SDSA_TAG_VLAN_BIT;
> +		tag->vlan = cpu_to_be16(vlan_tci);
> +	} else {
> +		tag->vlan = 0;
> +	}

[Severity: Medium]
What happens to an accelerated tag whose vlan_proto is not ETH_P_8021Q?
One example is an 802.1ad S-tag from an 802.1ad upper or from tc vlan
push.

Such a tag takes the else branch and stays in skb->vlan_all, but the SDSA
header is already at offset 12. When the skb is then sent on the conduit,
the S-tag can be inserted at ETH_HLEN, in front of the 0xDCDC EtherType.
The insertion is done either by the conduit hardware
(NETIF_F_HW_VLAN_STAG_TX) or by:

validate_xmit_vlan()
  __vlan_hwaccel_push_inside()
    __vlan_insert_tag()

The switch would then see 0x88a8 where it expects the SDSA header, and
would not recognise the FROM_CPU destination port. Depending on the
hardware, the frame could be dropped, or it could be forwarded like
ordinary CPU-port ingress.

For this to happen, the user netdev needs NETIF_F_HW_VLAN_STAG_TX, which
it can only get through conduit->vlan_features. No in-tree conduit seems
to set that today, but nothing in the tagger rules it out.

Other taggers guard against this case. ks8995_xmit() in
net/dsa/tag_ks8995.c does:

	if (unlikely(skb_vlan_tag_present(skb))) {
		skb = __vlan_hwaccel_push_inside(skb);

so that the conduit cannot insert the tag outside the special tag.
tag_sja1105.c does something similar.

Could any leftover hwaccel tag be pushed in-band with
__vlan_hwaccel_push_inside() before the SDSA header is inserted, with the
NULL return handled?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7%40linutronix.de
