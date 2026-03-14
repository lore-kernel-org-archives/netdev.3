Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362E3043DE
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773511184; cv=none; b=PDeDr8Zv2WfsdDGLk96RGNKPJZnbtQP+U0xQD+Ztwa/nZXchO4n3GrC7m4vMHuaNeJ4Nncsq8e46dNRtk3uc8vko2Yf0HXcbksKv0KJry4yMrtGmwjmAudm7gA51Awz1/kPN7zeEtfoU48m+faNHrrNHdJ6iRfixyp5bzPySd7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773511184; c=relaxed/simple;
	bh=CZDJzmMzDw8LYQAfaxHUeVb/Yma7Z9s7v12CBDnXetg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1gkQhd8+V3xwQNZ/4Xofr0lC5oCMosn7zUQZI730Y1IvTBMmYFqJ8GR4emGYxN77zxDCnOSGVIQPTCXm4L4YULdlqMaZeysDjQq4sgYHZP9DyP+4uvu1v2eXYUCqEnZI0b/T9BalQk6MYYOZgVhPWcaZJSh8tTwO40uxVyIA5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1w1TGt-0000000035O-1ESO;
	Sat, 14 Mar 2026 17:59:31 +0000
Date: Sat, 14 Mar 2026 17:59:27 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	olteanv@gmail.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC v2 2/3] net: dsa: initial MT7628 tagging driver
Message-ID: <abWh_zVCnRiVLuM0@makrotopia.org>
References: <20260314150845.653866-1-joey@tinyisr.com>
 <20260314150845.653866-3-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314150845.653866-3-joey@tinyisr.com>

On Sat, Mar 14, 2026 at 05:08:44PM +0200, Joris Vaisvila wrote:
> Add support for the MT7628 embedded switch's tag.
> 
> The MT7628 tag is merged with the VLAN TPID field when a VLAN is
> appended by the switch hardware. It is not installed if the VLAN tag is
> already there on ingress. Due to this hardware quirk the tag cannot be
> trusted for port 0 if we don't know that the VLAN was added by the
> hardware. As a workaround for this the switch is configured to always
> append the port PVID tag even if the incoming packet is already tagged.
> The tagging driver can then trust that the tag is always accurate and
> the whole VLAN tag can be removed on ingress as it's only metadata for
> the tagger.
> 
> On egress the MT7628 tag allows precise TX, but the correct VLAN tag
> from tag_8021q is still appended or the switch will not forward the
> packet.
> 
> Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
> ---
>  include/net/dsa.h    |  2 +
>  net/dsa/Kconfig      |  6 +++
>  net/dsa/Makefile     |  1 +
>  net/dsa/tag_mt7628.c | 93 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 102 insertions(+)
>  create mode 100644 net/dsa/tag_mt7628.c
> 
> [...]
> +#define MT7628_TAG_TX_PORT_BIT_MASK GENMASK(5, 0)
> +#define MT7628_TAG_RX_PORT_MASK GENMASK(2, 0)
> +#define MT7628_TAG_LEN 4
> +
> +static struct sk_buff *mt7628_tag_xmit(struct sk_buff *skb,
> +				       struct net_device *dev)
> +{
> +	struct dsa_port *dp;
> +	u16 xmit_vlan;
> +	u8 *tag;
> +
> +	dp = dsa_user_to_port(dev);
> +	xmit_vlan = dsa_tag_8021q_standalone_vid(dp);
> +
> +	skb_push(skb, MT7628_TAG_LEN);
> +	dsa_alloc_etype_header(skb, MT7628_TAG_LEN);
> +
> +	tag = dsa_etype_header_pos_tx(skb);
> +
> +	tag[0] = ETH_P_8021Q >> 8;
> +	tag[1] = FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
> +			    dsa_xmit_port_mask(skb, dev));
> +
> +	tag[2] = xmit_vlan >> 8;
> +	tag[3] = xmit_vlan & 0xff;

So there are basically two 16-bit fields which need endian swapping
from host-byte order (little endian on MT7628) to network byte-order.
Imho it would be better expressed by using something along the lines
of

	__be16 *tag;
...
	tag = dsa_etype_header_pos_tx(skb);
	tag[0] = htons(ETH_P_8021Q |
		       FIELD_PREP(MT7628_TAG_TX_PORT_BIT_MASK,
				  dsa_xmit_port_mask(skb, dev)));
	tag[1] = htons(xmit_vlan);


> +	return skb;
> +}
> +
> +static struct sk_buff *mt7628_tag_rcv(struct sk_buff *skb,
> +				      struct net_device *dev)
> +{
> +	int src_port;
> +	__be16 *phdr;
> +	u16 tpid;
> +
> +	if (unlikely(!pskb_may_pull(skb, MT7628_TAG_LEN)))
> +		return NULL;
> +
> +	phdr = dsa_etype_header_pos_rx(skb);
> +	tpid = ntohs(*phdr);
> +	skb_pull_rcsum(skb, MT7628_TAG_LEN);
> +	dsa_strip_etype_header(skb, MT7628_TAG_LEN);
> +
> +	src_port = tpid & MT7628_TAG_RX_PORT_MASK;
> +
> +	skb->dev = dsa_conduit_find_user(dev, 0, src_port);
> +	if (!skb->dev)
> +		return NULL;
> +	dsa_default_offload_fwd_mark(skb);
> +	return skb;

This looks like it is semantically identical to the RX path in tag_mtk.c.

Maybe the TX-side can be added to the existing mtk_tag.c driver, so the
RX-side can be shared? tag_brcm.c also defines multiple similar protocols
in the same C source file.
