Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFA399013;
	Tue,  6 Oct 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791326147; cv=none; b=K/Z+6nbHHxsn7sTaaRp0i3QQw5gQSsc8XZf9HukzDc1PPYsRNgzOXFqi5myfUCC4njuwFXiXJZyyfJFPJp56p0rbVr5N94nlmH2IWxgDBcRetjSKnwqv1MCoGj5pPlM6M+VfxQUIp5XIr1faSMOYi08AqK2H1Yr4R2QomoY3lAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791326147; c=relaxed/simple;
	bh=IVCDTnZq8y+dUc68ekWT1aDzdvRMDQZ8+mtAT6EWde8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mu5Zbeg/TH8IYxcSwzFhGrNrUWJvBejrlTwYaySNHcIc177oCZ9tQaKES5OFuP92xDewVBGAgfMEzDPSG8YAYsHVafgW2tIgUsEn18X7rXFmH6WVjY2n2XNj4rM1zy16UzffrWgyaNbHzUWR53G9SJpp4CTsk9IBJHq9r1XxYZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVVI/s48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVVI/s48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6261F0089E;
	Tue,  6 Oct 2026 22:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791326145;
	bh=0jPfxTRpk3Sf8aMZuaA94a/mttFBQCAq0u4Z9fP9AOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MVVI/s48QHMeIfmYSn1t90BOYulhv7UvTNk4WJF59go/+/zjQ4NhiplZiMWaDhERQ
	 /XqU+8n31vT71fsN1ddrxJji5MvJr41Wbzl+N+JuVsuVDgZXuvt+lDa1z8hpnoODaW
	 B8YfxlkZKCGSdKNjtAzBOWgtUhZMDn6fqogexyPJzFh/iRqZr9eBmLAoSv+VlLUTas
	 ZzymV1v6wmyB2w+HOJJVqSjQGGjNLmguYJ2ymvDiZl9XqHwRP4ENBXitOTmMidym+E
	 2JGwIQQEycC5+zW0jNz7QPobRjgH8DlL9zsVByQGEw/1ylCsDr3phUOdU6fWLMt4Ji
	 dWkXiZQfTlJMw==
Subject: Re: [PATCH net-next v2 7/7] net: bcmgenet: reassemble jumbo frames
 from status block fragments
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.stevenson@raspberrypi.com, justin.chen@broadcom.com,
 pierremarinleclercq88@gmail.com
Date: Tue, 06 Oct 2026 22:35:44 +0000
Message-ID: <179132614439.434549.8289444609097315292@kernel.org>
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-7-c4be21151912@tipi-net.de>
References: <20261006-nb-genet-mtu-nn-v2-v2-7-c4be21151912@tipi-net.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Use-after-free read of the last status block in
  bcmgenet_desc_rx() when CRC forwarding is on.
- [Medium] TX descriptor length can overflow the 12-bit length field once
  the MTU goes past about 4 KB.
- [Medium] Short SOP descriptor followed by continuation fragments can
  reach BUG() in eth_type_trans().
- [Low] The comment on bcmgenet_pkt_rdy_thld() is now stale.

--

net: bcmgenet: reassemble jumbo frames from status block fragments

The hardware splits a frame longer than the packet ready threshold across
several descriptors, each with its own status block. This patch reassembles
those descriptors into one skb by attaching the later ones as page frags.
It also raises max_mtu on v2+ to ENET_MAX_JUMBO_MTU, which is derived from
the 14-bit UMAC_MAX_FRAME_LEN.

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index e8f86374c7cd8..faa13f12ce7e6 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -84,11 +84,8 @@
>  				      ENET_THLD_MAX * ENET_THLD_UNIT, \
>  				      ENET_THLD_PAGE_LEN)
>  
> -/* Largest MTU that fits one descriptor, with room for a VLAN tag so a VLAN
> - * interface can use the parent MTU.
> - */
> -#define ENET_MAX_MTU		(ENET_THLD_MAX_LEN - GENET_RBUF_ALIGN - \
> -				 ETH_HLEN - VLAN_HLEN)
> +/* UMAC_MAX_FRAME_LEN is 14 bits wide and counts the FCS */
> +#define ENET_MAX_JUMBO_MTU	(GENMASK(13, 0) - ENET_FRAME_OVERHEAD)

[Severity: Medium]
This limit comes from the UMAC frame length only. Once bcmgenet_probe()
sets max_mtu to it, the TX path can see MTUs up to 16347. Can the TX
descriptor length field hold buffers that large?

bcmgenet_xmit() still maps the linear head and each page frag as a single
descriptor. It writes the size into len_stat with no mask, cap or split:

bcmgenet_xmit() {
    ...
		len_stat = (size << DMA_BUFLENGTH_SHIFT) |
			   (priv->hw_params->qtag_mask << DMA_TX_QTAG_SHIFT);
    ...
}

The only in-tree description of that field says it is 12 bits wide:

bcmgenet.h:
/* Tx/Rx Dma Descriptor common bits*/
#define DMA_BUFLENGTH_MASK		0x0fff
#define DMA_BUFLENGTH_SHIFT		16

At jumbo MTU, skb_headlen() can approach 16 KB, plus the 64-byte TSB that
bcmgenet_add_tsb() adds. TCP frags of around 9 KB are also common.

If the field really is 12 bits, would the length wrap modulo 4096, with the
upper bits spilling into bits 31:28? Would that truncate or corrupt the
frame on the wire? Before this patch the largest TX buffer was about 3.9 KB.

Separately, bcmgenet_init_tx_ring() still sets DMA_RING_BUF_SIZE from
priv->rx_buf_len, which is at most about 3.9 KB:

bcmgenet_init_tx_ring() {
    ...
	bcmgenet_tdma_ring_writel(priv, index,
				  ((size << DMA_RING_SIZE_SHIFT) |
				   priv->rx_buf_len), DMA_RING_BUF_SIZE);
    ...
}

Is that setting still valid now that one TX descriptor can be several times
larger? Could the commit message say whether the TX descriptor length and
the TX buffer size limits allow more than 4095 bytes?

[ ... ]

> @@ -2333,6 +2330,54 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
>  	return 0;
>  }
>  

[ ... ]

> +/* A frame longer than the threshold arrives in several descriptors, each with
> + * its own status block. Only the first one carries a header, so hand the page
> + * of every later one to the frame already being collected. Returns the frame
> + * once EOP is in, NULL while more descriptors are expected or once the frame
> + * had to be dropped.
> + */

[Severity: Low]
This isn't a bug, but the comment above bcmgenet_pkt_rdy_thld() now looks
stale:

/* Receive threshold in register units. Covers the alignment bytes and the
 * frame, but not the status block, which the hardware adds on top.
 */

With max_mtu raised to ENET_MAX_JUMBO_MTU, any MTU above about 3.5-3.8 KB
is clamped to ENET_THLD_MAX_LEN / ENET_THLD_UNIT. The threshold then no
longer covers the frame, which contradicts the comment here. Should that
comment be updated?

[ ... ]

> @@ -2490,8 +2556,18 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
>  		skb_reserve(skb, GENET_RSB_PAD);
>  		__skb_put(skb, len - GENET_RSB_PAD);
>  
> -		if (priv->crc_fwd_en) {
> -			skb_trim(skb, skb->len - ETH_FCS_LEN);
> +		if (unlikely(!(dma_flag & DMA_EOP))) {
> +			ring->frag_head = skb;
> +			goto next;
> +		}

[Severity: Medium]
Could a short SOP head lead to BUG() in eth_type_trans()?

For an SOP descriptor the only length check is len >= GENET_RSB_PAD (66). A
descriptor with SOP and no EOP that carries fewer than ETH_HLEN frame bytes
would still become ring->frag_head. Later descriptors are then added as
frags.

Nothing calls pskb_may_pull() before this line after deliver:

		skb->protocol = eth_type_trans(skb, priv->dev);

If the linear part has fewer than 14 bytes and frags are present,
__skb_pull() would see skb->len < skb->data_len and call BUG().

bcmgenet_pkt_rdy_thld() keeps the threshold at ENET_THLD_DEFAULT (2048
bytes) or more. Correct hardware should therefore always fill an SOP
descriptor without EOP to around 2 KB. Reaching this would take a
malformed status block from the MAC, so this is hardening rather than a
path reachable from the network.

Would it be worth checking that an SOP descriptor without EOP holds at
least ETH_HLEN frame bytes?

> +
> +deliver:
> +
> +		if (priv->crc_fwd_en &&
> +		    unlikely(pskb_trim(skb, skb->len - ETH_FCS_LEN))) {
> +			BCMGENET_STATS64_INC(stats, dropped);
> +			dev_kfree_skb_any(skb);
> +			goto next;
>  		}
>  
>  		/* Set up checksum offload */

[Severity: High]
Can this read the status block from a page that has already been freed?

For a reassembled frame, status still points to page_address(rx_page) +
rx_offset of the EOP descriptor. bcmgenet_add_frag() has already given that
page to the skb as its last frag.

When crc_fwd_en is set, pskb_trim() on this non-linear skb goes through
___pskb_trim(). That can release the page in two ways.

First, if the EOP descriptor carries 4 or fewer frame bytes, the last frag
is released with skb_frag_unref(). A non-SOP len of 64-68 passes the
min_len check.

Second, skb->sk is NULL, so skb_condense() runs. It may pull the remaining
frag data into the head and free every frag.

The page then goes back through napi_pp_put_page(). If it cannot be
recycled (pfmemalloc, remote NUMA node, or full cache and ring), it can be
returned to the page allocator via page_pool_return_netmem().

The very next statements read the status block:

		/* Set up checksum offload */
		if (dev->features & NETIF_F_RXCSUM) {
			rx_csum = (__force __be16)(status->rx_csum & 0xffff);

The value read there is then used as CHECKSUM_COMPLETE. Before this patch
the skb was always linear and status pointed into the head buffer, which
skb_trim() never frees.

Should rx_csum be read before pskb_trim() is called?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912%40tipi-net.de
