Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE163EEAC4;
	Thu,  1 Oct 2026 04:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790829945; cv=none; b=iZsgXjp5KtQjw8MW54Z/IlktFkS4s0krJqszgXk91AYvHLmSdpohyGQpCvwC02hYokwsOcJRy0vDl4BJUT25vtgkBLRccX/dt3iWX5m+1Zgl2+D4kIZL4F1Hms/Mkj+wIBTn92zMGGgF55pDdNz5pNRRaAg2NEZsJcSuISL7Xlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790829945; c=relaxed/simple;
	bh=hiwg+n+AXTGYJbNrKgjBIHvuQgTU/lcY1Dzt3WBIgOU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ps5IelDeKa0h09npb+66i0ga1ARpAqkghgQTwE53rDCgOhspXLSlpKeb8Ea4nliUZ9+t8+D7ksRHCJWcdRFiSbtJYoCGKgDj1p5vr3bOGp8B8T5N2vzPBUz5lbMiB/1UN9M2EDjelZANxlztCiGfgCQN1+mzpwmsIbk+ZDfbS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dk/+SbrK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dk/+SbrK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2591F00899;
	Thu,  1 Oct 2026 04:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790829937;
	bh=9G+kUmxLkeukcMBztETwUt4ngGNy3h2GvEBHr1Zj4Ss=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dk/+SbrKttvo8bO83GzDzsnNpZCMC2SbwQ6foU7CV7/9dAORBOvpP1S1WNheTlNv1
	 kKXEG+y3X/P31/oTpsuV1SzhZcJofs+hBxk+RKHKNy54MeF0GP2hIBfcHe+DDALfhZ
	 nsCXzt4oYW/EDaFu4/fThUpbukE4o1qkYWXDNyeof1KfTnwmoyHlRDVPAGzXqsrFFe
	 8TipYbwyY0VKNrx8Ugf6d6DPjtH76ebwUJyXBtK7QfrhyJS/uQs2XRrM8VtjSN4IP+
	 w7MmGA1lAuk5RRoITMf3ZdXs+WTDLc7EPe7MzXHv7rONpdIcGIKp4SlZci6DIQKdBa
	 3Gv2//WstlVRA==
Subject: Re: [PATCH net-next v24 06/10] net: dsa: tag_mtk: add Airoha variant
 usage of this TAG
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, olteanv@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chester.a.unal@arinc9.com,
 daniel@makrotopia.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
 horms@kernel.org, joey@tinyisr.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 mfd@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew@lunn.ch
Date: Thu, 01 Oct 2026 04:45:35 +0000
Message-ID: <179082993591.434549.3461650830434233242@kernel.org>
In-Reply-To: <20260928194511.41878-7-ansuelsmth@gmail.com>
References: <20260928194511.41878-7-ansuelsmth@gmail.com>
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

- [Medium] This patch adds a new tag protocol, DSA_TAG_PROTO_AIROHA
  ("airoha").
- [Low] After this patch, tag_mtk.ko can register both the "mtk" and
  "airoha" tag drivers through…

--

net: dsa: tag_mtk: add Airoha variant usage of this TAG

This commit adds a new DSA_TAG_PROTO_AIROHA tag protocol ("airoha") that
reuses the existing MTK tag xmit/rcv handlers. It adds a comment noting
that AN8855 lacks the SA_DIS and Leaky VLAN tag bits. It also reworks
Kconfig and the Makefile so tag_mtk.o is built through a common
NET_DSA_TAG_MTK_COMMON symbol and registers either or both taggers.

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
The wire format here is the same as DSA_TAG_PROTO_MTK. However, the
conduit drivers that handle the MTK special tag in hardware check the
protocol ID, not the format. Will they still handle a conduit that uses
the "airoha" tagger correctly?

Later in the series, an8855_get_tag_protocol() returns
DSA_TAG_PROTO_AIROHA. No later patch updates these checks, which still
only match DSA_TAG_PROTO_MTK:

drivers/net/ethernet/mediatek/mtk_ppe_offload.c:mtk_flow_get_dsa_port() {
	...
	if (dp->cpu_dp->tag_ops->proto != DSA_TAG_PROTO_MTK)
		return -ENODEV;
	...
}

drivers/net/ethernet/mediatek/mtk_ppe.c:__mtk_ppe_check_skb() {
	...
		if (!netdev_uses_dsa(skb->dev) ||
		    skb->dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK)
			goto out;
	...
}

With an AN8855 behind a mtk_eth_soc conduit, it looks like PPE/flowtable
offload to the switch user ports would be silently unavailable.

On netsys v1, mtk_uses_dsa() also compares only against
DSA_TAG_PROTO_MTK:

drivers/net/ethernet/mediatek/mtk_eth_soc.c:mtk_uses_dsa() {
	return netdev_uses_dsa(dev) &&
	       dev->dsa_ptr->tag_ops->proto == DSA_TAG_PROTO_MTK;
}

So mtk_open() skips the dsa_meta allocation and takes the else branch:

	} else {
		...
		val &= ~MTK_CDMP_STAG_EN;
		mtk_w32(eth, val, MTK_CDMP_IG_CTRL);

		mtk_w32(eth, 0, MTK_CDMP_EG_CTRL);
	}

Meanwhile, mtk_gdm_config() still sets MTK_GDMA_SPECIAL_TAG and
mtk_tx_set_dma_desc_v2() still sets TX_DMA_SPTAG_V3 for any DSA conduit.
Does this leave the MAC only partly configured for the special tag?

On Airoha SoCs, airoha_get_dsa_tag() has the same kind of check:

drivers/net/ethernet/airoha/airoha_eth.c:airoha_get_dsa_tag() {
	...
	if (dev->dsa_ptr->tag_ops->proto != DSA_TAG_PROTO_MTK)
		return 0;
	...
	default:
		/* PPE module requires untagged DSA packets to work properly,
		 * so move DSA tag to DMA descriptor.
		 */
		memmove(skb->data + MTK_HDR_LEN, skb->data, 2 * ETH_ALEN);
		__skb_pull(skb, MTK_HDR_LEN);
		break;
	...
}

With the new protocol, the in-band tag stays in the frame and 0 is
written to QDMA_ETH_TXMSG_SP_TAG_MASK. airoha_dev_xmit() still requests
TCO/UCO/ICO checksum offload and TSO for that frame.

On RX, airoha_dev_open() sets GDM_STAG_EN_MASK for any DSA conduit, so
RX and TX handling of the tag would not match. Whether this corrupts
checksums or makes the hardware insert a second tag depends on hardware
behaviour, and the code alone can't show which.

The commit message says the change is about giving external tools like
libpcap a dedicated name. Should these conduit checks also accept
DSA_TAG_PROTO_AIROHA? One option is a helper that means "uses the MTK
special tag format".

> +
> +DSA_TAG_DRIVER(airoha_netdev_ops);
> +MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_AIROHA, AIROHA_NAME);
> +#endif
> +
> +static struct dsa_tag_driver *dsa_tag_driver_array[] =	{
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_MTK)
> +	&DSA_TAG_DRIVER_NAME(mtk_netdev_ops),
> +#endif
> +#if IS_ENABLED(CONFIG_NET_DSA_TAG_AIROHA)
> +	&DSA_TAG_DRIVER_NAME(airoha_netdev_ops),
> +#endif
> +};
> +
> +module_dsa_tag_drivers(dsa_tag_driver_array);
> +
> +MODULE_DESCRIPTION("DSA tag driver for Mediatek switches");

[Severity: Low]
This isn't a bug, but should the module description be updated here?
The module can now register the "airoha" tagger too. With only
CONFIG_NET_DSA_TAG_AIROHA enabled, it registers only the Airoha tagger,
but modinfo still reports "DSA tag driver for Mediatek switches".

> +MODULE_LICENSE("GPL");

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928194511.41878-1-ansuelsmth%40gmail.com
