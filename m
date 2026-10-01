Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7441D10A;
	Thu,  1 Oct 2026 03:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790826004; cv=none; b=qeLUPX9ZSNTtCf7FjdsB7RKUcbC58ONPo8QeivdR16EHK6vitlnKu8aMlq35M+iRB2Ac6prQ765y6wm/Twoym2Iaw8a0Z29Ptx3ZJaciVXEtJOXtcYnzv/13/gIRFtHXX636atmTIu7mSDuvF3m5NbD75lqQOw1Xwet51gKq/Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790826004; c=relaxed/simple;
	bh=kfbEixb+6/HWRYVF46zc61zgBIN05rYNJ5YbFd1iovo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RlHp6Oys5qXG5iMlGRQu/fC7CzwWElh8yRBWotbu2rYNZi9Plp3FJ2X3Z3V/qizXsc8k27xQ/nN45R9Cl20r0upJaLPKjF6iZuwsBR4hOFQQCDfg5Ah8QlH97/M0t2g/bQ257lySW1IvIyFvdRyVjGVahsd3q5YF88GNt9HRjKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrT0BAG/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrT0BAG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45501F00899;
	Thu,  1 Oct 2026 03:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790825989;
	bh=eQYSHN6h4pOKlP73L9niPXkCw9f+UyRWeK/Tb62Gq8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YrT0BAG/XCP0YavjHokR/7P9HS8Ki95jaj5mnIWQpX7lXEizPyV0dohMkne1ZPev2
	 SAbkYcvBtUmkGc6it72gmeIs4g7Vpm7YVOJrXLlrG/Z0BGtULuRIs1/gJLeGFfB0FH
	 crRerNgcyDzCbcWe87Q6EQcAaK67ufyL02C/x/tR3zt69SbcPBj8Q/mXynIFHpepEG
	 wzj0L1N38dvugryB1rSjTNq0uSEUkykZTXr/duzT6i5YNZ5q/lmnFLakYqyOAudYbL
	 N5X9N5wQnIVU2zvgxcWHhXg9E9Vw2+CoXuOf15FXRajhNik/+KiYrNZH9rEFw4juI9
	 GC7cf9xyRU6NQ==
Subject:
 Re: [PATCH net-next v14 3/5] net: rnpgbe: Add basic RX data path support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 01 Oct 2026 03:39:48 +0000
Message-ID: <179082598848.434549.11433031150914059146@kernel.org>
In-Reply-To: <62EC8866E79CFC61+20260928033847.1033393-1-dong100@mucse.com>
References: <62EC8866E79CFC61+20260928033847.1033393-1-dong100@mucse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] rnpgbe_clean_rx_irq() counts descriptors with an invalid hardware
  length (`!size || size > RNPGBE_RX_DESC_DATA_LEN`) only in the per-…
- [Low] mucse_alloc_page_pool() creates the pool with
  PP_FLAG_DMA_SYNC_DEV, .offset = 0 and .max_len = PAGE_SIZE.
- [Low] The comment in rnpgbe_configure_rx_ring() says 'Any allocation
  shortfall is retried after NAPI is enabled by rnpgbe_up_complete()'.
- [Low] The rnpgbe_is_non_eop() kernel-doc says that for a non-EOP buffer
  the function 'will place the sk_buff in the next buffer to be chained…
- [Low] When rnpgbe_alloc_rx_buffers() fails inside
  rnpgbe_clean_rx_irq(), cleaned_count is set again from…

--

net: rnpgbe: Add basic RX data path support

This commit adds the RX DMA data path for the rnpgbe driver. RX buffers come
from page_pool at one page per descriptor, and the commit adds a NAPI poll
callback and RX ring setup and teardown. It keeps a 16-descriptor gap in the
512-entry ring, retries failed page allocations with a per q_vector timer,
and treats an RX DMA quiesce timeout as a terminal AXI fault.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index e23fc2db1aab8..7beec27991d35 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> +/**
> + * rnpgbe_is_non_eop - Process handling of non-EOP buffers
> + * @rx_ring: rx ring being processed
> + * @rx_desc: rx descriptor for current buffer
> + * @skb: current socket buffer containing buffer in progress
> + *
> + * This function updates next to clean.  If the buffer is an EOP buffer
> + * this function exits returning false, otherwise it will place the
> + * sk_buff in the next buffer to be chained and return true indicating
> + * that this is in fact a non-EOP buffer.
> + *
> + * Return: true for not end of packet
> + **/
> +static bool rnpgbe_is_non_eop(struct mucse_ring *rx_ring,
> +			      union rnpgbe_rx_desc *rx_desc,
> +			      struct sk_buff *skb)
> +{

[ ... ]

> +	if (skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS) {
> +		/* place skb in next buffer to be received */
> +		rx_ring->rx_buffer_info[ntc].skb = skb;
> +	} else {
> +		atomic64_inc(&rx_ring->stats->dropped);
> +		rx_ring->drop_bytes = skb->len;
> +		/* too much frags, force free */
> +		dev_kfree_skb_any(skb);
> +		rx_ring->drop_status = true;
> +	}

[Severity: Low]
This isn't a bug, but the kernel-doc for rnpgbe_is_non_eop() says that for a
non-EOP buffer the skb is placed in the next buffer. When nr_frags has
reached MAX_SKB_FRAGS, the skb is freed here instead, and the function still
returns true.

Could the kernel-doc say that the caller's skb may already be freed when the
function returns true? The only caller, rnpgbe_clean_rx_irq(), just does
continue, so nothing is affected at runtime today.

[ ... ]

> +static int rnpgbe_clean_rx_irq(struct mucse_q_vector *q_vector,
> +			       struct mucse_ring *rx_ring,
> +			       int budget)
> +{
> +	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
> +	u16 cleaned_count = mucse_desc_unused_rx(rx_ring);
> +	unsigned int work_done = 0;
> +
> +	while (likely(work_done < budget)) {
> +		struct mucse_rx_buffer *rx_buffer;
> +		union rnpgbe_rx_desc *rx_desc;
> +		struct sk_buff *skb;
> +		unsigned int size;
> +
> +		if (cleaned_count >= M_RX_BUFFER_WRITE) {
> +			if (rnpgbe_alloc_rx_buffers(rx_ring, cleaned_count)) {
> +				mod_timer(&q_vector->rx_alloc_timer,
> +					  jiffies + msecs_to_jiffies(500));
> +				cleaned_count = mucse_desc_unused_rx(rx_ring);
> +			} else {
> +				cleaned_count = 0;
> +			}
> +		}

[Severity: Low]
After a failed refill in rnpgbe_clean_rx_irq(), cleaned_count is recomputed
with mucse_desc_unused_rx(). If the first page allocation failed,
next_to_use has not moved. The value is then still >= M_RX_BUFFER_WRITE, and
it grows as more descriptors are consumed.

Does every later iteration of the same poll then retry the full refill? Each
retry calls page_pool_dev_alloc_pages(), which will likely fail again under
memory pressure. It then does a dma_wmb() and a writel() of the unchanged
tail in rnpgbe_alloc_rx_buffers():

	dma_wmb();
	mucse_update_rx_tail(rx_ring, i);

and calls mod_timer() again, even though the retry timer is already armed.

ixgbe-style drivers reset cleaned_count to 0 after one attempt. Would that
be enough here, since the retry timer is already armed?

> +		rx_desc = M_RX_DESC(rx_ring, rx_ring->next_to_clean);
> +

[ ... ]

> +		size = le16_to_cpu(rx_desc->wb.len);
> +
> +		if (unlikely(!size || size > RNPGBE_RX_DESC_DATA_LEN)) {
> +			struct mucse_rx_buffer *err_rx_buffer;
> +			bool dropping = rx_ring->drop_status;
> +			u16 idx = rx_ring->next_to_clean;
> +
> +			cleaned_count++;
> +			if (!dropping)
> +				atomic64_inc(&rx_ring->stats->dropped);

[Severity: Low]
Should descriptors with an invalid hardware length be counted as length
errors rather than drops?

This branch only increments the per-queue dropped counter, and
rnpgbe_get_stats64() reports that counter as rx_dropped:

	stats->rx_packets += packets;
	stats->rx_dropped += dropped;
	stats->rx_bytes += bytes;

rx_errors and rx_length_errors are never set.

include/uapi/linux/if_link.h describes rx_length_errors as "Number of
packets dropped due to invalid length". It also says rx_errors must include
the events counted by rx_length_errors. rx_dropped is meant for packets that
were received but not processed, for example due to lack of resources.

As written, malformed-length completions show up as resource drops, and
rx_errors always reads 0. struct mucse_queue_stats also has no error counter
to hold these events.

[ ... ]

> @@ -1263,4 +1863,223 @@ void rnpgbe_get_stats64(struct net_device *netdev,

[ ... ]

> +static int mucse_alloc_page_pool(struct mucse_ring *rx_ring)
> +{
> +	struct page_pool_params pp_params = {
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order = 0,
> +		.pool_size = rx_ring->count,
> +		.nid = dev_to_node(rx_ring->dev),
> +		.dev = rx_ring->dev,
> +		.napi = &rx_ring->q_vector->napi,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.offset = 0,
> +		.max_len = PAGE_SIZE,

[Severity: Low]
This isn't a bug, but does this sync window in mucse_alloc_page_pool() match
the buffer layout? mucse_alloc_mapped_page() posts buffers at an offset:

	bi->page_offset = RNPGBE_SKB_PAD;

The hardware writes at most RNPGBE_RX_DESC_DATA_LEN (1536) bytes per
descriptor.

With .offset = 0 and .max_len = PAGE_SIZE, every recycled page is synced for
the device across the whole page. That includes the headroom and the
skb_shared_info area, which the device never writes.

The reuse path in mucse_alloc_mapped_page() uses a third window:

	dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
					 bi->page_offset,
					 PAGE_SIZE - bi->page_offset,
					 DMA_FROM_DEVICE);

On non-coherent or swiotlb platforms, this adds unnecessary cache
maintenance to the hot path. Would .offset = RNPGBE_SKB_PAD and
.max_len = RNPGBE_RX_DESC_DATA_LEN match what the device actually writes?

[ ... ]

> +static void rnpgbe_configure_rx_ring(struct mucse *mucse,
> +				     struct mucse_ring *ring)
> +{

[ ... ]

> +	/* Fill the ring before RX DMA is enabled. Any allocation shortfall is
> +	 * retried after NAPI is enabled by rnpgbe_up_complete().
> +	 */
> +	rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
> +}

[Severity: Low]
Is this comment in rnpgbe_configure_rx_ring() accurate for small shortfalls?
rnpgbe_schedule_rx_retry() arms rx_alloc_timer whenever
mucse_desc_unused_rx() is non-zero:

	if (mucse_desc_unused_rx(ring)) {
		mod_timer(&q_vector->rx_alloc_timer,
			  jiffies + msecs_to_jiffies(500));

The NAPI poll that the timer schedules only refills when this holds in
rnpgbe_clean_rx_irq():

	if (cleaned_count >= M_RX_BUFFER_WRITE) {

rnpgbe_alloc_rx_buffers() stops at the first page_pool failure, so a
shortfall of 1 to 15 descriptors can happen. In that case the timer fires,
rnpgbe_clean_rx_irq() skips the refill, and the timer is not re-armed. The
retry the comment promises never happens.

The ring still has at least 481 descriptors posted, and refill resumes once
traffic frees 16 slots. So the practical effect is a misleading comment and
a timer that does nothing. The comment on mucse_desc_unused_rx() in
rnpgbe.h ("Refill is attempted once at least this many descriptors are
available") matches what the code does.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0A4D45AD9F6A0F14%2B20260928033701.1033196-1-dong100%40mucse.com
