Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6F45FFAA;
	Tue, 18 Aug 2026 11:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787051006; cv=none; b=rbZnrHuGQI4o7nh0PUJfseSthmeT1JsltU93YAgw8it5pqvcZ7WCEOYsvJzbTY5VwyPYfhX7fYANWLAffU7vLZQbTduffcDmtozbK2qLMnp8TQ+F1i7MghjE69NNukNk0sCgW4NUw7JhASkLHJfyOkx1tpHNTQ9JMEA6T1SeOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787051006; c=relaxed/simple;
	bh=zp5cqtNph3ZKxV3xYNynbx7Ksa3nGrIcKaDVVrdoyBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEaCT/F0ATjWguIsgxBsuab461B88/+n4Ook1ba9lISO4Ah+RTkWzT1oYjhz0JIicbHZHYULrk77pVpnswre/UsgX/taA6oxprOAve6PWAy4mCwAYiCqTP9biRBLWpuFV3tGEuaXdL7zWfQFlkmTWNCZrXUbH5r00XA6ybj3nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhBFHtQN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhBFHtQN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2651F000E9;
	Tue, 18 Aug 2026 11:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787051004;
	bh=O3W1hpeJ0JdrtWlh44IeE2IIDrFbFVJTnjFnoAXU8Ig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZhBFHtQNq84/Dr4o+e/LRXkFZ4eYHCcmLUl2rqRqQTnrbFfrbboVWF4Qn8PkeXz7o
	 8OHkxazF0qhHgAH8MUlw4Pv1ES0iW/+AU05gifCJ1n/d+ZBDOsB2sb2VBFdPafjdPa
	 v+kNDeQ8MlW3hITyNAczeZqhPmP+ytPKtLInkk/bgxzto7HkxfqwO9AlvhBV+UgNI2
	 hT45S97nyuWQeI6nnKRdluZeX1L0VCVByyMyUnhQVtoGn8kvCRZOHlqoJng5kNd/Rl
	 aq5bZZ9u64EErcKKgUjki3HdJBXesKe0VKil0MrjIWpRoZlY+7UcnbO50On4sJjPsR
	 p/XIGt74ruCSw==
Date: Tue, 18 Aug 2026 12:03:20 +0100
From: Simon Horman <horms@kernel.org>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v9 2/4] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <20260818110320.GB265046@horms.kernel.org>
References: <20260814111317.1741087-1-dong100@mucse.com>
 <20260814111317.1741087-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814111317.1741087-3-dong100@mucse.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260814111317.1741087-2-dong100@mucse.com?part=2
---
--- Patch [2]: [PATCH net-next v9 2/4] net: rnpgbe: Add basic TX packet transmission support ---
commit 8bff6db2aa4a278636a66ac5e08b9b7d42fd23a7
Author: Dong Yibo <dong100@mucse.com>

net: rnpgbe: Add basic TX packet transmission support

This adds the TX path for rnpgbe: the TX descriptor layout and buffer
management, rnpgbe_xmit_frame_ring(), TX ring setup/teardown, and TX
completion handling in rnpgbe_clean_tx_irq(). It also requires the 56-bit
DMA mask and enables NETIF_F_SG plus NETIF_F_HIGHDMA.

A few questions about the TX stop/wake logic and the TX DMA quiesce
handling below.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> index 0dce78e4a91ba..6dc29ebe6fa70 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
> @@ -7,13 +7,20 @@
> +#define RNPGBE_DMA_STATUS              0x0008
> +#define TX_AXI_RW_EN                   0xc
> +/* DMA_STATUS_REG[23:20]: tx_wr, tx_rd, rx_wr, rx_rd done status. */
> +#define RNPGBE_DMA_TX_STATUS           GENMASK_U32(23, 22)
>  #define RNPGBE_DMA_AXI_EN              0x0010
> +#define RNPGBE_TX_MIN_PKT_LEN          33

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index c661290d561bd..8700c48669ecb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> @@ -89,6 +91,114 @@ static void rnpgbe_irq_enable_queues(struct mucse_q_vector *q_vector)
> +static bool rnpgbe_clean_tx_irq(struct mucse_q_vector *q_vector,
> +				struct mucse_ring *tx_ring,
> +				int napi_budget)
> +{

[ ... ]

> +	i += tx_ring->count;
> +	tx_ring->next_to_clean = i;
> +	u64_stats_update_begin(&tx_ring->syncp);
> +	tx_ring->stats.bytes += total_bytes;
> +	tx_ring->stats.packets += total_packets;
> +	u64_stats_update_end(&tx_ring->syncp);
> +
> +#define TX_WAKE_THRESHOLD (DESC_NEEDED * 2)
> +	__netif_txq_completed_wake(txring_txq(tx_ring),
> +				   total_packets, total_bytes,
> +				   mucse_desc_unused(tx_ring),
> +				   TX_WAKE_THRESHOLD,
> +				   !netif_carrier_ok(tx_ring->netdev) ||
> +				   test_bit(__MUCSE_DOWN, &mucse->state));

[Severity: High]
[Finding: main-1-1]
[Sources: opus-5]
Can the TX queue end up stopped forever here?

rnpgbe_clean_tx_irq() is the only place in the driver that can clear
__QUEUE_STATE_DRV_XOFF after rnpgbe_xmit_frame_ring() stops the queue,
and the down_cond argument suppresses the wake whenever the carrier is
reported down:

	!netif_carrier_ok(tx_ring->netdev) ||
	test_bit(__MUCSE_DOWN, &mucse->state)

Since link state is polled by the service task, netif_carrier_off() can
lag the real link event. If the hardware finishes the queued descriptors
during that window, this call drains the ring but returns without waking,
and with an empty ring there is no further TX interrupt to re-evaluate
the condition.

What re-enables the queue after that? netif_tx_start_all_queues() is
called only from rnpgbe_up_complete() on ifup, and the runtime carrier-on
handler added later in the series only calls netif_carrier_on() without
touching the queues. dev_activate() does not clear DRV_XOFF either.

rnpgbe_netdev_ops also registers no .ndo_tx_timeout, and
netdev_watchdog_up() bails out early in that case:

net/sched/sch_generic.c:netdev_watchdog_up() {
	if (!dev->netdev_ops->ndo_tx_timeout)
		return;
}

so dev_watchdog() never fires and a genuine hardware TX stall (DD never
set, no TX interrupt) is equally invisible. Would it make sense to add
.ndo_tx_timeout, and to wake the queues from the carrier-on path?

> +
> +	return !!budget;
> +}

[ ... ]

> @@ -633,13 +758,144 @@ static void rnpgbe_napi_disable_all(struct mucse *mucse)
> +static void rnpgbe_stop_tx_ring(struct mucse_ring *tx_ring)
> +{
> +	if (!tx_ring->tx_buffer_info)
> +		return;
> +
> +	/* Stop hw. No new descriptors are fetched after TX_START=0.
> +	 * DMA for descriptors fetched before the stop may still be in flight.
> +	 */
> +	mucse_ring_wr32(tx_ring, RNPGBE_TX_START, 0);
> +	/* Flush posted write to ensure hardware sees TX_START=0 */
> +	(void)mucse_ring_rd32(tx_ring, RNPGBE_TX_START);
> +}
> +
> +static void rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_status;
> +	int err;
> +
> +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> +				 dma_status,
> +				 (dma_status & RNPGBE_DMA_TX_STATUS) ==
> +				 RNPGBE_DMA_TX_STATUS,
> +				 10, 100000);
> +	if (err)
> +		dev_warn(&mucse->pdev->dev,
> +			 "Timed out waiting for TX DMA to quiesce, status %#x\n",
> +			 dma_status);
> +}

[Severity: Medium]
[Finding: gpt-5-6-sol-4-6]
[Sources: gpt-5-6-sol, opus-5]
Should the timeout here be propagated to the callers?

rnpgbe_wait_tx_dma_idle() returns void, so a timeout is only logged and
both callers continue as if the engine had confirmed idle. On the ifdown
side that means rnpgbe_clean_all_tx_rings() clears TX_AXI_RW_EN and then
rnpgbe_clean_tx_ring() calls dma_unmap_single()/dma_unmap_page() on every
in-flight TX buffer, and rnpgbe_close() -> rnpgbe_free_all_tx_resources()
-> rnpgbe_free_tx_resources() then dma_free_coherent()s the descriptor
ring.

The comment in rnpgbe_stop_tx_ring() states that DMA for descriptors
fetched before the stop may still be in flight, which is what this poll
is guarding. If the poll times out, can the device still be reading the
mapped buffers or writing back into the descriptor ring after they are
released?

The same unchecked wait sits at the head of rnpgbe_configure_tx(), where
RNPGBE_TX_BASE_ADDR_LO/HI, RNPGBE_TX_LEN and TAIL are reprogrammed and
TX_START is set to 1 again. Is a device reset or an error return needed
when the engine never reports idle?

> +
> +/**
> + * rnpgbe_clean_tx_ring - Free Tx Buffers
> + * @tx_ring: ring to be cleaned
> + **/
> +static void rnpgbe_clean_tx_ring(struct mucse_ring *tx_ring)
> +{

[ ... ]

> +static void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_axi_ctl;
> +
> +	for (int i = 0; i < mucse->num_tx_queues; i++)
> +		rnpgbe_stop_tx_ring(mucse->tx_ring[i]);
> +
> +	if (mucse->num_tx_queues)
> +		rnpgbe_wait_tx_dma_idle(mucse);
> +
> +	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +	dma_axi_ctl &= ~TX_AXI_RW_EN;
> +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
> +	/* Flush the posted write before releasing the DMA mappings. */
> +	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +
> +	for (int i = 0; i < mucse->num_tx_queues; i++)
> +		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
> +}

[ ... ]

> @@ -650,11 +906,420 @@ bool rnpgbe_down(struct mucse *mucse)
> +static void rnpgbe_configure_tx_ring(struct mucse *mucse,
> +				     struct mucse_ring *ring)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +
> +	mucse_ring_wr32(ring, RNPGBE_TX_BASE_ADDR_LO, (u32)ring->dma);
> +	mucse_ring_wr32(ring, RNPGBE_TX_BASE_ADDR_HI,
> +			(u32)(((u64)ring->dma) >> 32) | (hw->pfvfnum << 24));

Simon says: I think we can skip the issue below.

[Severity: Low]
[Finding: main-2-3]
[Sources: opus-5]
This isn't a bug, but hw->pfvfnum is a u8 here and the shift is done on
the int-promoted value, while rnpgbe_tx_map() casts first for the same
field:

	fun_id = (u64)tx_ring->pfvfnum << 56;

With the kernel's -fno-strict-overflow the produced bit pattern is the
one the register wants in either form, so this is only a consistency
point; an explicit (u32) cast would match the other encoding site.

[ ... ]

> +netdev_tx_t rnpgbe_xmit_frame_ring(struct sk_buff *skb,
> +				   struct mucse_ring *tx_ring)
> +{

[ ... ]

> +	if (!netif_txq_maybe_stop(txring_txq(tx_ring),
> +				  mucse_desc_unused(tx_ring),
> +				  count + RESV_DESC_NEEDED,
> +				  count + RESV_DESC_NEEDED))
> +		return NETDEV_TX_BUSY;

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index c3296a3dde0bb..24f4cf27a307b 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -83,25 +101,37 @@ static int rnpgbe_close(struct net_device *netdev)
>  static const struct net_device_ops rnpgbe_netdev_ops = {
>  	.ndo_open       = rnpgbe_open,
>  	.ndo_stop       = rnpgbe_close,
>  	.ndo_start_xmit = rnpgbe_xmit_frame,
> +	.ndo_get_stats64 = rnpgbe_get_stats64,
>  };

[ ... ]
