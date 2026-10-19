Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AFC48CD4B;
	Mon, 19 Oct 2026 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394839; cv=none; b=AjZQS+N2jyvgtkWaBiMSMMUCZW7YBldsr5DtysTEL6gC17Dx9BVoraJuS7q9SpC0EfyXh3KmZ/P1MxNriwff7XGKZxGaIsqV7Hz/djl1z5XqzPHB0NqwknycdXh0Q+l+nG9OTPU/tiVmovwSV9G34OyWKjhtkhCdX8eq31zVLao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394839; c=relaxed/simple;
	bh=YVbo28BUEwouo/P77sudfurzugaL+C1ljbMo0rMVfD0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJXl9UfeSNjLEEWBVVpPDSg07pECUmiG5GZk/V9r3h5tKd3XVcrquIbM02obOPFGREMnVTmcqJ5RksKPxM4lqjy3E7G5Lx9Myj9BNsccFYzCjfzE4cux2nyvY/rFK22Axd6N/ZB3EMcQA8B+9CSF9GtChCyg7RRNMLFh6DP705o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5ae4b8U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5ae4b8U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D41C1F000C6;
	Mon, 19 Oct 2026 07:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792394838;
	bh=4SNvH1f7t9Ik7aTrNof4lio5aOvBqmVCpb1gRipbZQM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q5ae4b8UNwHXFJ0OsUc8BC9+unt1fTV1L+TV/Ivyqja9UfO2ToKHS1MzFLf1YZL36
	 dp75C3PKN+0FtUJk/fKOfht9lDDADimE9tVcyf0UqDTnKPRJFFkAUhEOb1+Z06GBek
	 yFGNVCmHGYJpCW955Ol/t9zNnq1TWxOxnqzN4qGtx5Z2gn0RSFZmBNZb5vfYxbFIgF
	 aIZsegPZy6KY3UGEV4SMhbtLMosTPBUQ2eG1fLZ4zvpiMPcTI+B8b0MRwcDMqO3IHG
	 l0cVtdWJdFWBkE8Ln4v9E8ETnQViqR4a+JGaC64V7xAP1rprhps5wARHhlAkkYeZgh
	 RzmFXm1/5sWuQ==
Subject: Re: [PATCH net-next v3 5/6] net: ftgmac100: Add AST2700 upper DMA
 address support
From: netdev-bot+sashiko@kernel.org
To: jacky_chou@aspeedtech.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ratbert@faraday-tech.com, edumazet@kernel.org, hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 07:27:17 +0000
Message-ID: <179239483709.3135.1495121226484390316@kernel.org>
In-Reply-To: <20261015-support_ast2700-v3-5-8d7999171ac4@aspeedtech.com>
References: <20261015-support_ast2700-v3-5-8d7999171ac4@aspeedtech.com>
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

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch keeps the only copy of buffer DMA address bits 34:32
  in rxdes2[18:16].
- [Low] After this patch the descriptor layout comments in ftgmac100.h
  contradict the code.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the TX
  completion path has no read-side barrier pairing with the producer's…
- [High] This problem wasn't introduced by this patch, but the
  ftgmac100_open() failure path for ncsi_start_dev() frees the RX…

--

net: ftgmac100: Add AST2700 upper DMA address support

This patch programs the high RX and TX descriptor ring base registers on
AST2700 and stores DMA address bits 34:32 in bits 18:16 of descriptor
word 2. It rebuilds the full 64-bit DMA address from the descriptors
before unmapping and sets a 35-bit DMA mask. All of this is gated by a
new FTGMAC100_QUIRK_DMA_35BIT match-data quirk.

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
> index 5a578a62df67..263594de0e07 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.c
> +++ b/drivers/net/ethernet/faraday/ftgmac100.c

[ ... ]

> @@ -474,7 +482,10 @@ static int ftgmac100_alloc_rx_buf(struct ftgmac100 *priv, unsigned int entry,
>  	priv->rx_skbs[entry] = skb;
>  
>  	/* Store DMA address into RX desc */
> -	rxdes->rxdes3 = cpu_to_le32(map);
> +	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +		rxdes->rxdes2 = cpu_to_le32(FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI,
> +						       upper_32_bits(map)));
> +	rxdes->rxdes3 = cpu_to_le32(lower_32_bits(map));
>  
>  	/* Ensure the above is ordered vs clearing the OWN bit */
>  	dma_wmb();
> @@ -601,6 +612,9 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
>  
>  	/* Tear down DMA mapping, do necessary cache management */
>  	map = le32_to_cpu(rxdes->rxdes3);
> +	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +		map |= (u64)FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI,
> +				     le32_to_cpu(rxdes->rxdes2)) << 32;

[Severity: Medium]
With this patch, rxdes2 bits 18:16 are the only copy of the upper RX
buffer address bits. The driver reads them back here after the MAC has
completed the descriptor. Does the AST2700 MAC always leave
rxdes2[18:16] untouched when it writes the descriptor back?

The header still describes this word as one the hardware writes:

	__le32	rxdes2; /* length/type on AST2500 */

If the MAC does write it, map would no longer match the address that
ftgmac100_alloc_rx_buf() mapped. dma_unmap_single() would then get a
handle that was never mapped, so the real mapping leaks and the cache
maintenance or swiotlb/IOMMU unmap hits the wrong range.
ftgmac100_free_buffers() rebuilds the address the same way.

The drop path in ftgmac100_rx_packet() also gives the descriptor back to
the MAC by rewriting only rxdes0:

drop:
	/* Clean rxdes0 (which resets own bit) */
	rxdes->rxdes0 = cpu_to_le32(status & priv->rxdes0_edorr_mask);

A clobbered rxdes2 would then send the next frame for that slot to
lower_32_bits(map) | (clobbered_hi << 32). AST2700 DRAM starts at
0x4_0000_0000, so every buffer has non-zero high bits.

Would it be safer to keep the full dma_addr_t for each RX slot in driver
memory (for example a priv->rx_dma[] array) and rewrite rxdes2 every
time a descriptor is handed back? If not, could the hardware guarantee
be documented?

[ ... ]

> @@ -677,9 +691,14 @@ static void ftgmac100_free_tx_packet(struct ftgmac100 *priv,
>  				     struct ftgmac100_txdes *txdes,
>  				     u32 ctl_stat)
>  {
> -	dma_addr_t map = le32_to_cpu(txdes->txdes3);
> +	dma_addr_t map;
>  	size_t len;
>  
> +	map = le32_to_cpu(txdes->txdes3);
> +	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +		map |= (u64)FIELD_GET(FTGMAC100_TXDES2_TXBUF_BADR_HI,
> +				     le32_to_cpu(txdes->txdes2)) << 32;
> +

[Severity: High]
This isn't a bug introduced by this patch, but the TX completion path
has no read barrier to pair with the producer's smp_wmb(). This patch
adds the txdes2 read to the same unordered set of loads.

The producer side in ftgmac100_hard_start_xmit():

	dma_wmb();
	first->txdes0 = cpu_to_le32(f_ctl_stat);
	smp_wmb();
	priv->tx_pointer = pointer;

The consumer side in NAPI on another CPU, via
ftgmac100_poll()->ftgmac100_tx_complete():

ftgmac100_tx_buf_cleanable()
	return priv->tx_pointer != priv->tx_clean_pointer;

ftgmac100_tx_complete_packet()
	ctl_stat = le32_to_cpu(txdes->txdes0);
	if (ctl_stat & FTGMAC100_TXDES0_TXDMA_OWN)
		return false;

	skb = priv->tx_skbs[pointer];
	netdev->stats.tx_packets++;
	netdev->stats.tx_bytes += skb->len;

Nothing like smp_rmb() or smp_load_acquire() sits between the
tx_pointer load and the txdes0 and tx_skbs[] loads. There is only a
control dependency, and that does not order a load against later loads
on ARMv7/ARMv8.

Can the consumer see the new tx_pointer together with a stale txdes0?
The stale value would have OWN clear, because ftgmac100_init_rings()
writes 0 and an earlier completion writes ctl_stat & txdes0_edotr_mask.

In that case a stale NULL tx_skbs[pointer] would be dereferenced at
skb->len. Alternatively, a stale txdes3/txdes2 address would be unmapped
and the skb freed while TX DMA is still reading it.

[ ... ]

> @@ -936,7 +961,12 @@ static void ftgmac100_free_buffers(struct ftgmac100 *priv)
>  	for (i = 0; i < priv->rx_q_entries; i++) {
>  		struct ftgmac100_rxdes *rxdes = &priv->rxdes[i];
>  		struct sk_buff *skb = priv->rx_skbs[i];
> -		dma_addr_t map = le32_to_cpu(rxdes->rxdes3);
> +		dma_addr_t map;
> +
> +		map = le32_to_cpu(rxdes->rxdes3);
> +		if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
> +			map |= (u64)FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI,
> +					     le32_to_cpu(rxdes->rxdes2)) << 32;
>  
>  		if (!skb)
>  			continue;

[Severity: High]
This is a pre-existing issue, but it concerns how this function is used.
When ncsi_start_dev() fails in ftgmac100_open(), are the RX buffers and
rings freed while the MAC DMA engines are still running?

ftgmac100_open()
  ftgmac100_init_all()
    ftgmac100_init_hw()    <- ring bases, RX autopoll via APTC
    ftgmac100_start_hw()   <- MACCR TXDMA_EN | RXDMA_EN | ...
  ncsi_start_dev() fails
    goto err_ncsi

err_ncsi:
	phy_stop(netdev->phydev);
	napi_disable(&priv->napi);
	netif_stop_queue(netdev);
err_alloc:
	ftgmac100_free_buffers(priv);
	free_irq(netdev->irq, netdev);
err_irq:
	netif_napi_del(&priv->napi);
err_hw:
	iowrite32(0, priv->base + FTGMAC100_OFFSET_IER);
	ftgmac100_free_rings(priv);

Unlike ftgmac100_stop(), this path never calls ftgmac100_stop_hw() to
clear MACCR. Could the MAC keep polling the freed descriptor rings and
DMA incoming frames into the freed skb data and the freed rx_scratch
buffer? That would last until the next open resets the MAC, or forever
if the interface is never reopened.

ncsi_start_dev() returns -ENOTTY when nd->state is neither registered
nor functional. An up/down/up sequence while the asynchronous NC-SI
probe from the first open is still running looks like it can reach
this, because ncsi_stop_dev() does not reset the state.

[ ... ]

> diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
> index 8c35c895b146..0c244b1c0a35 100644
> --- a/drivers/net/ethernet/faraday/ftgmac100.h
> +++ b/drivers/net/ethernet/faraday/ftgmac100.h

[ ... ]

> @@ -226,6 +229,7 @@ struct ftgmac100_txdes {
>  #define FTGMAC100_TXDES1_TX2FIC		(1 << 30)
>  #define FTGMAC100_TXDES1_TXIC		(1 << 31)
>  
> +#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)
>  /*
>   * Receive descriptor, aligned to 16 bytes
>   */
> @@ -272,4 +276,6 @@ struct ftgmac100_rxdes {
>  #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
>  #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
>  
> +#define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
> +
>  #endif /* __FTGMAC100_H */

[Severity: Low]
This isn't a bug, but the descriptor layout comments in this header now
disagree with the code:

struct ftgmac100_txdes {
	...
	__le32	txdes2; /* Reserved */
	...
};

struct ftgmac100_rxdes {
	...
	__le32	rxdes2; /* length/type on AST2500 */
	...
};

ftgmac100_hard_start_xmit(), ftgmac100_alloc_rx_buf() and
ftgmac100_init_rings() now write buffer address bits 34:32 into these
words. ftgmac100_free_tx_packet(), ftgmac100_rx_packet() and
ftgmac100_free_buffers() read them back.

Could the comments say that with FTGMAC100_QUIRK_DMA_35BIT (AST2700),
bits 18:16 of word 2 hold buffer address bits 34:32?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-support_ast2700-v3-0-8d7999171ac4%40aspeedtech.com
