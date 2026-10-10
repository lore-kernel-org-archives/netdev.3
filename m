Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE0438E8A7;
	Sat, 10 Oct 2026 16:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791649168; cv=none; b=T+7NGILg8N9wayRLZdF302cpExINPkLtyCzZSVbFXQ7/pup5xwiCdmqHyWQSo9Q9OHZZqDhmU3Qg32KTdjHhfJWqHfzlNQXnmsVf0JJPWERdT5pIvzr1+b8T975PHs0fJjGcds6il4d8zyJQySFNWZV5pz2KhLnmi29UMYBescM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791649168; c=relaxed/simple;
	bh=eycGn+f1fK4TTlfOXIweqxPNEawgg56/4wCNqKVydwo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hEG6LyuMCRJ2CNk43M2dh0SoioT5ziXdFIVVjDdXqi5rdrV4xrbqUGNpe5cVKNTrwa6CxdV2yTicbVcCBih8ezDfPesvC7piszQHLt83wWqQtAzrzf0NKXbqeASM7NC+eHrzn/XsS8aDTeZ987I6DQJyBDvaJfMP/srOTzS+L60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeUkyjXX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeUkyjXX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE471F0089A;
	Sat, 10 Oct 2026 16:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791649163;
	bh=VBqycIfsWSTg5AKYE2ZXqo2Wk5PYKRyd2TjAONqVFxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZeUkyjXXrGcYmE8+cDWCDXQFsOe8o6E55ey7mGWSHP+YsN17x6WWkgLmK+vDZzYU6
	 eGJH7DG7vwR+GUSHvSngwFlS/wrvG602+MURt7y5ByUT/gYFoSftnD1kvfhwJhZJvr
	 Q/0PNOVslLWeqw7mZS6XoSHLhgQl1qEmlpt3N2fdbto38zVsOyTUCU5nEj+Bmi6cRO
	 UOw0GkAU3xtV4S9olau0+CP9Wz0sfTgWQS8/S6b4SWI/o0JLHOMCuJjCh2ZEJluQ4q
	 Ho5xP52W4fJS1PHvPolCqN4GLVu0DwAITtDjRQrnwqknyOzVKMJU1ZlXG81XCnhOZe
	 pC7wRtlmyP/JQ==
Subject: Re: [PATCH net-next v25 06/10] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Sat, 10 Oct 2026 16:19:21 +0000
Message-ID: <179164916112.434549.6895848060469565753@kernel.org>
In-Reply-To: <20261009161102.38961-7-ansuelsmth@gmail.com>
References: <20261009161102.38961-7-ansuelsmth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds DSA_TAG_PROTO_AIROHA as a second proto ID for
  exactly the same wire format as DSA_TAG_PROTO_MTK.

--

net: dsa: tag_mtk: add Airoha variant usage of this TAG

This commit adds a DSA_TAG_PROTO_AIROHA tag protocol. It reuses the MTK
tag xmit/rcv handlers under a separate "airoha" name. The Kconfig is
split into NET_DSA_TAG_MTK and NET_DSA_TAG_AIROHA, and both select a
common NET_DSA_TAG_MTK_COMMON symbol that builds tag_mtk.o.

> diff --git a/net/dsa/tag_mtk.c b/net/dsa/tag_mtk.c
> index c7dc7731675ec..f8087d768da6d 100644
> --- a/net/dsa/tag_mtk.c
> +++ b/net/dsa/tag_mtk.c

[ ... ]

> @@ -107,8 +112,33 @@ static const struct dsa_device_ops mtk_netdev_ops = {
>  	.needed_headroom = MTK_HDR_LEN,
>  };
>  
> -MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");
> -MODULE_LICENSE("GPL");
> +DSA_TAG_DRIVER(mtk_netdev_ops);
>  MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_MTK, MTK_NAME);
> +#endif
>  
> -module_dsa_tag_driver(mtk_netdev_ops);
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
> +static const struct dsa_device_ops airoha_netdev_ops = {
> +	.name		= AIROHA_NAME,
> +	.proto		= DSA_TAG_PROTO_AIROHA,
> +	.xmit		= mtk_tag_xmit,
> +	.rcv		= mtk_tag_rcv,
> +	.needed_headroom = MTK_HDR_LEN,
> +};

[Severity: Medium]
This adds a second proto ID for the same wire format as
DSA_TAG_PROTO_MTK. Several conduit drivers handle this tag format in
hardware, but they only check for DSA_TAG_PROTO_MTK. None of them are
updated here or later in the series.

Once an8855_get_tag_protocol() returns DSA_TAG_PROTO_AIROHA, will AN8855
switches behind these conduits lose that handling?

In drivers/net/ethernet/mediatek/mtk_ppe_offload.c:

mtk_flow_get_dsa_port() {
    ...
	if (dp->cpu_dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
		return -ENODEV;
    ...
}

After the -ENODEV, *dev is still the DSA user netdev. That means
mtk_flow_set_output_device() fails every eth->netdev[] comparison and
returns -EOPNOTSUPP.

Would this reject nft flowtable hardware offload through AN8855 user
ports, even though mtk_foe_entry_set_dsa() would build the same tag?

In drivers/net/ethernet/mediatek/mtk_ppe.c, mtk_ppe_check_skb() skips
PPE binding for ETH_P_XDSA frames:

	case htons(ETH_P_XDSA):
		if (!netdev_uses_dsa(skb->dev) ||
		    skb->dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK)
			goto out;

In drivers/net/ethernet/mediatek/mtk_eth_soc.c, mtk_uses_dsa() would
return false:

	return netdev_uses_dsa(dev) &&
	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;

On NETSYS v1, mtk_open() then takes the branch that clears
MTK_CDMP_STAG_EN. That turns off hardware special tag untagging and RX
VLAN offload.

In drivers/net/ethernet/airoha/airoha_eth.c, airoha_get_dsa_tag()
returns early:

	if (dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK)
		return 0;

So the 4-byte special tag stays in the frame and is not moved into the
QDMA descriptor. That goes against the driver's own comment:

	/* PPE module requires untagged DSA packets to work properly,
	 * so move DSA tag to DMA descriptor.

The RX side of that driver still turns on hardware special tag
stripping (GDM_STAG_EN_MASK in REG_GDM_INGRESS_CFG), based only on
netdev_uses_dsa(). TX and RX handling would then no longer match.

The DSA user netdev also inherits the conduit vlan_features
(AIROHA_HW_FEATURES). If the QDMA/FE cannot parse L3/L4 headers behind
an in-frame MTK tag, could CHECKSUM_PARTIAL or TSO frames end up with
bad checksums? I couldn't confirm that hardware behaviour from the code.

Should these conduit checks accept both DSA_TAG_PROTO_MTK and
DSA_TAG_PROTO_AIROHA, maybe through a shared helper? If not, is a
separate proto ID needed for an identical tag format?

> +
> +DSA_TAG_DRIVER(airoha_netdev_ops);
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
> +#endif

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009161102.38961-1-ansuelsmth%40gmail.com
