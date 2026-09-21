Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7392421239;
	Mon, 21 Sep 2026 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986054; cv=none; b=c1ngCynKWtigUCXCMjfuXeLKiHFzlaYuZOl/pXI8xSZ+fTdax41o4zyxeVUXAvEy9ehFeXz9FCb4Aa0QG4DuvWG3/E6jvWJAextTnzOZ8IJvdj+yYpr9PqIftTQhKK0bPxXGmEQE+mmg6To08wLZm3bVDjPYA7IsxvarNOybvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986054; c=relaxed/simple;
	bh=ZkFdrxlLVOOpYbPObEQxAjUcF+f/UYYm/hhuSp5UD/Y=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HqcYdlWdmxMpX05TVP90q/zc+engaQRCLL5YC6egs37VAU6DMGsAZXANgwxVwjpYLaFi4l7Wjms84SagTHeIVROHQ9HFS7x+T/eUffGD58cQazowOIToalJw5N+hvKx/SpbTRovKg1fpbaIyODmaXzwt+KSz84EedpOoOL9eXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DG7PK65y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DG7PK65y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88121F000FF;
	Mon, 21 Sep 2026 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986047;
	bh=B9t0ZRWU00VJFvc/Xu88sxdaJ/htyQlwpOdwOmlDdKs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DG7PK65y5WphFUhJTdkW86ETdoKmJe9WwDNC+AVVIB8g+jDDdwwIwxd8m/yPm6ZPC
	 WQCQ4Umt8iVirGQg+5VAmxna/A2MLpr7+p2cHpDKyuVQMhxKo2KQu29mIEdqZFfo8o
	 CyIH6x+foGCETWtx/M+rcCPtC5d2WxOUUtMDkXKdOdZTEteRS4Afiyo63QVydgWhlN
	 5Nc/rSUjzsUXjJv3jdOzzcONds0lrxs6pRegVvZ3KfRX8jbzhj21pvZGpU+zDufvoU
	 wScK8fijCIwCbthXH1Fcosnraep4HdVh4qCnlbz9cua6Bq7ONFBopOkCXWP0atcDNW
	 U8HQk5PGJixrw==
Subject:
 Re: [PATCH net-next v13 3/5] net: rnpgbe: Add basic RX data path support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 21 Sep 2026 10:20:46 +0000
Message-ID: <178998604635.2160803.11049996034378624333@kernel.org>
In-Reply-To: <E55C86DE587B8FE9+20260920092638.345601-1-dong100@mucse.com>
References: <E55C86DE587B8FE9+20260920092638.345601-1-dong100@mucse.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] RX descriptor length from the device (`rx_desc->wb.len`) is
  only bounded by the skb/page geometry (`max_size =…
- [Medium] `rnpgbe_clean_rx_irq()` counts a received packet in
  `rx_ring->stats.packets` / `.bytes` only when the skb is successfully…
- [Medium] For a multi-descriptor (non-EOP) frame the linear skb is built
  from the first descriptor with `__skb_put(skb, size)` where the only…

--

net: rnpgbe: Add basic RX data path support

This adds the RX DMA data path for rnpgbe: the RX write-back descriptor
format, page_pool backed RX buffers, the NAPI poll callback with RX ring
setup/teardown, and RX statistics.  A per-q_vector timer retries failed
page allocations and RX DMA quiesce timeouts are latched as terminal AXI
faults.

A few questions about the descriptor length handling and the RX
statistics below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index af5cef987051..9afd10273a62 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -174,15 +176,436 @@ static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,

[ ... ]

> +/**
> + * rnpgbe_add_rx_frag - Add non-linear data to the skb
> + * @rx_buffer: pointer to rx_buffer
> + * @skb: pointer skb for this packet
> + * @size: data size in this desc
> + **/
> +static void rnpgbe_add_rx_frag(struct mucse_rx_buffer *rx_buffer,
> +			       struct sk_buff *skb,
> +			       unsigned int size)
> +{
> +	unsigned int truesize = PAGE_SIZE;
> +
> +	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, rx_buffer->page,
> +			rx_buffer->page_offset, size, truesize);
> +}
> +
> +/**
> + * rnpgbe_build_skb - Try to build a skb based on rx_buffer
> + * @rx_buffer: pointer to rx_buffer
> + * @size: data size in this desc
> + *
> + * Return: skb for this rx_buffer
> + **/
> +static struct sk_buff *rnpgbe_build_skb(struct mucse_rx_buffer *rx_buffer,
> +					unsigned int size)
> +{
> +	void *va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> +	unsigned int truesize = PAGE_SIZE;
> +	struct sk_buff *skb;
> +
> +	net_prefetch(va);
> +	/* build an skb around the page buffer */
> +	skb = napi_build_skb(va - RNPGBE_SKB_PAD, truesize);
> +	if (unlikely(!skb))
> +		return NULL;
> +	/* update pointers within the skb to store the data */
> +	skb_reserve(skb, RNPGBE_SKB_PAD);
> +	__skb_put(skb, size);
> +	skb_mark_for_recycle(skb);
> +
> +	return skb;
> +}

[ ... ]

> +/**
> + * rnpgbe_cleanup_headers - Correct corrupted or empty headers
> + * @skb: current socket buffer containing buffer in progress
> + *
> + * Return: true if an error was encountered and skb was freed.
> + **/
> +static bool rnpgbe_cleanup_headers(struct sk_buff *skb)
> +{
> +	/* if eth_skb_pad returns an error the skb was freed */
> +	if (eth_skb_pad(skb))
> +		return true;
> +
> +	return false;
> +}
> +
> +/**
> + * rnpgbe_process_skb_fields - Set the RX queue and protocol fields
> + * @rx_ring: RX descriptor ring containing the queue information
> + * @skb: skb currently being received
> + *
> + * Records the RX queue that received the skb and sets its protocol from
> + * the Ethernet header.
> + **/
> +static void rnpgbe_process_skb_fields(struct mucse_ring *rx_ring,
> +				      struct sk_buff *skb)
> +{
> +	struct net_device *dev = rx_ring->netdev;
> +
> +	skb_record_rx_queue(skb, rx_ring->queue_index);
> +	skb->protocol = eth_type_trans(skb, dev);
> +}

[Severity: Medium]
Is there anything guaranteeing that the first descriptor of a chained
frame carries at least ETH_HLEN bytes before eth_type_trans() is called
here?

For a non-EOP first descriptor, rnpgbe_clean_rx_irq() only rejects
!size || size > max_size, so size may be as small as 1, and
rnpgbe_build_skb() puts exactly that into the linear area:

	skb_reserve(skb, RNPGBE_SKB_PAD);
	__skb_put(skb, size);

The following descriptors go into frags, so skb->len is already >= ETH_ZLEN
and the eth_skb_pad() in rnpgbe_cleanup_headers() does nothing.

eth_type_trans() -> eth_skb_pull_mac() -> skb_pull_inline(skb, ETH_HLEN)
does not return NULL because ETH_HLEN <= skb->len, so __skb_pull() runs:

include/linux/skbuff.h:__skb_pull() {
	skb->len -= len;
	if (unlikely(skb->len < skb->data_len)) {
		...
		BUG();
	}
	...
}

With a first descriptor of S bytes and F bytes of frags, after the pull
skb->len = S + F - 14 while data_len = F, so S < 14 hits the BUG().  It
also reads eth->h_proto past the bytes the device actually wrote.

The comment in rnpgbe_clean_rx_irq() states the 33-byte minimum as a
hardware guarantee, but nothing enforces it.  Would it make sense to
check size >= ETH_HLEN for a non-EOP first descriptor, or to call
pskb_may_pull() before eth_type_trans()?

[ ... ]

> +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> +			       struct mucse_ring *rx_ring,
> +			       int budget)
> +{
> +	unsigned int max_size = SKB_WITH_OVERHEAD(PAGE_SIZE) - RNPGBE_SKB_PAD;
> +	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> +	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
> +	unsigned int work_done = 0;

[ ... ]

> +		dma_rmb();
> +		/* Hardware guarantees the first descriptor of each packet is at
> +		 * least 33 bytes, including multi-descriptor packets.
> +		 * Multi-descriptor packets are only used for jumbo frames over
> +		 * 1536 bytes (M_DEFAULT_SG = 96). Each descriptor is at most
> +		 * 1536 bytes. Small packets use a single descriptor.
> +		 */
> +		size = le16_to_cpu(rx_desc->wb.len);

[ ... ]

> +		if (unlikely(!size || size > max_size)) {

[Severity: Medium]
Should this bound be the programmed per-descriptor DMA window rather than
the page geometry?

max_size is SKB_WITH_OVERHEAD(PAGE_SIZE) - RNPGBE_SKB_PAD, roughly 3.7 KB
with 4K pages, while rnpgbe_configure_rx_ring() tells the device:

	mucse_ring_wr32(ring, RNPGBE_RX_SG_LEN, M_DEFAULT_SG);

which the header documents as 1536 bytes, and the comment right above the
length read says "Each descriptor is at most 1536 bytes".

A writeback length in the range (1536, max_size] passes the check, so
rnpgbe_build_skb()'s __skb_put(skb, size) or rnpgbe_add_rx_frag()'s
skb_add_rx_frag(..., size, truesize) would publish up to ~2.1 KB of page
content the device never wrote.  page_pool pages are not zeroed, so that
is previously freed kernel memory on a fresh page and earlier packet data
on a recycled one, and it reaches napi_gro_receive() and from there
AF_PACKET or the wire.  Would clamping against the M_DEFAULT_SG derived
1536-byte limit be more appropriate here?

> +			struct mucse_rx_buffer *err_rx_buffer;
> +			u16 idx = rx_ring->next_to_clean;
> +
> +			cleaned_count++;
> +			atomic64_inc(&rx_ring->stats.dropped);

[ ... ]

> +			rx_desc->wb.cmd = 0;
> +			rx_ring->next_to_clean++;
> +			if (rx_ring->next_to_clean >= rx_ring->count)
> +				rx_ring->next_to_clean = 0;
> +			continue;
> +		}
> +
> +		rx_buffer = rnpgbe_get_buffer(rx_ring, &skb, size);
> +
> +		if (skb)
> +			rnpgbe_add_rx_frag(rx_buffer, skb, size);
> +		else
> +			skb = rnpgbe_build_skb(rx_buffer, size);
> +
> +		if (!skb) {
> +			cleaned_count++;
> +
> +			/* drop until eop if multiple descriptors */
> +			if (rnpgbe_test_staterr(rx_desc, M_RXD_STAT_EOP))
> +				work_done++;
> +			else
> +				rx_ring->drop_status = true;
> +
> +			rx_desc->wb.cmd = 0;
> +			rx_ring->next_to_clean++;
> +			atomic64_inc(&rx_ring->stats.dropped);

[Severity: Medium]
Should good frames dropped inside the driver still be counted in
rx_ring->stats.packets and .bytes?

Here, and in the MAX_SKB_FRAGS overflow path of rnpgbe_is_non_eop() and
the rnpgbe_cleanup_headers() failure path, only stats.dropped is bumped;
total_rx_packets and total_rx_bytes are updated only on successful
delivery.

rnpgbe_get_stats64() then exports those success-only counters directly:

	stats->rx_packets += packets;
	stats->rx_dropped += dropped;
	stats->rx_bytes += bytes;

include/uapi/linux/if_link.h documents rx_packets as counting "all good
packets received from the device by the host, including packets which host
had to drop at various stages of processing (even in the driver)", with
rx_bytes corresponding to rx_packets.

Under memory pressure ip -s link would show rx_dropped climbing without
those frames appearing in rx_packets/rx_bytes.  Was that intentional?

> +			if (rx_ring->next_to_clean >= rx_ring->count)
> +				rx_ring->next_to_clean = 0;
> +
> +			continue;
> +		}
> +
> +		rx_buffer->page = NULL;
> +		rx_buffer->skb = NULL;
> +		cleaned_count++;
> +
> +		if (rnpgbe_is_non_eop(rx_ring, rx_desc, skb))
> +			continue;
> +
> +		/* verify the packet layout is correct */
> +		if (rnpgbe_cleanup_headers(skb)) {
> +			/* we should clean it since we used all info in it */
> +			atomic64_inc(&rx_ring->stats.dropped);
> +			rx_desc->wb.cmd = 0;
> +			work_done++;
> +			continue;
> +		}
> +
> +		/* probably a little skewed due to removing CRC */
> +		total_rx_bytes += skb->len;
> +		rnpgbe_process_skb_fields(rx_ring, skb);
> +		rx_desc->wb.cmd = 0;
> +		napi_gro_receive(&q_vector->napi, skb);
> +		/* Update packet statistics and NAPI work accounting. */
> +		total_rx_packets++;
> +		work_done++;
> +	}
> +
> +	u64_stats_update_begin(&rx_ring->syncp);
> +	rx_ring->stats.packets += total_rx_packets;
> +	rx_ring->stats.bytes += total_rx_bytes;
> +	u64_stats_update_end(&rx_ring->syncp);
> +
> +	return work_done;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> index 1fe290ed224d..76b5b0c0ae4a 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
> @@ -9,12 +9,27 @@ struct mucse_hw;

[ ... ]

> +#define M_DEFAULT_SG              96 /* unit 16b, 1536 bytes */
> +#define RNPGBE_RX_SG_LEN          0x58

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B8AF0FDE24FAFB51%2B20260920092424.345309-1-dong100%40mucse.com
