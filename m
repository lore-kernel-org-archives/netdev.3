Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B63352027;
	Thu, 17 Sep 2026 01:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789608757; cv=none; b=RJyyAe0honZIj0glx5noqQnyOzQc96vEdrOExpb66PU2o701Rz/LtgFPvdUF3wyg2tbG8uSK1VPBzHXQElyLoBeIba9OT2ZMdkI8uttvM+c3W8ANKeL6VMt7liHmzFQEJL2/ynKa8TFlfO9Mkk0H8Ol1yDaBkED0WILRZi5ckSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789608757; c=relaxed/simple;
	bh=MBjD51Tqty/A0DGX0TjJSvaVCdcvoS8UHAcGpLf1JA8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fz6ze7MMqCjTHZkYGj0iVhkmqbRRgQdNhBKlr/iH3mP42OiNplHTeF4jn2e+CaCJ8LPNWN8hhRk/b8/o1dGxASHoFwQItKOpQZBt8KUBkvKkhAwDpfMKlMEPGTz85MBtNQ3f14ohZLrNGl9Skg+o8lcm7aSRFD7QhjXy4I6DRrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcIydGk+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcIydGk+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CBC1F00898;
	Thu, 17 Sep 2026 01:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789608752;
	bh=uoQ2J2cbYQOY52KYevZIQpbIJjfcfPQF3n/+9SwIyoo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fcIydGk+LZNnBUuTzIFgf+mAIZtqZbh3NF/iAbn4J8hCIb30hoUdGgJi5MIJteQ7k
	 InqLRJFlAXAx8j1KdTUuKu1Af1PBs7DzNKL6O6N5d0LpmeZ5L1WEkkJsbk0AnttGwq
	 2o+IXsFoU4JSDuU016PuVqmPs1KHzXKdLZcTbC1wDct3hchPOTgBzN6zvDZ29vn/wu
	 barA8GapIwMKa7AEPQ8vndmyMmFwG3eG/lRP6NyTSTiZwM3vupKddYrK+L0ZVrok6C
	 HEsxI8Ap/nEu7LWO49sPLUuUiF5hz/MCP9OJQzNu/rdy/NkltdxgphMcb+BQoQKkk2
	 HE571V3sMaRjA==
Subject:
 Re: [PATCH net-next v12 3/5] net: rnpgbe: Add RX packet reception support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Thu, 17 Sep 2026 01:32:31 +0000
Message-ID: <178960875124.22033.1444221735823171245@kernel.org>
In-Reply-To: <4AFB00F5B64834A7+20260914013229.2262639-1-dong100@mucse.com>
References: <4AFB00F5B64834A7+20260914013229.2262639-1-dong100@mucse.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 4

- [Low] Commit claims to add RX packet reception, but at this commit no
  MAC-level receive enable or address filtering exists (verified: `git…
- [Low] In rnpgbe_configure_rx_ring() the comment "/* Start an initial
  retry after NAPI is enabled.
- [Low] rnpgbe_stop_all_rx_rings() is documented "Return: 0 when RX DMA
  was quiesced, negative errno otherwise" and rnpgbe_configure_rx()…
- [Low] rnpgbe_free_rx_resources() is not self-contained even though its
  kernel-doc says "Free all receive software resources": it vfree()s…

--

net: rnpgbe: Add RX packet reception support

This adds the RX descriptor format, page_pool based RX buffer management,
the NAPI poll callback with RX cleanup, RX ring setup/teardown and RX
statistics for the rnpgbe driver.  A per q_vector timer retries failed
page allocations, and an RX DMA quiesce timeout is treated as a terminal
AXI fault.

A few questions below about the new RX teardown paths and some of the
new comments.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> index fed07d53e5fe1..e4b7ff992c4d0 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c

[ ... ]

> @@ -719,6 +1165,31 @@ static int rnpgbe_wait_tx_dma_idle(struct mucse *mucse)
>  	return err;
>  }
>  
> +static int rnpgbe_wait_rx_dma_idle(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_status;
> +	int err;
> +
> +	/* A timeout indicates a terminal AXI fault. Hardware stops all PCIe
> +	 * DMA requests in this state, including requests accepted before the
> +	 * fault. Teardown may therefore release mappings and descriptor memory.
> +	 * Recovery requires a chip-level reset.
> +	 */
> +	err = readl_poll_timeout(hw->hw_addr + RNPGBE_DMA_STATUS,
> +				 dma_status,
> +				 (dma_status & RNPGBE_DMA_RX_STATUS) ==
> +				 RNPGBE_DMA_RX_STATUS,
> +				 10, 100000);
> +	if (err) {
> +		set_bit(__MUCSE_AXI_FAULT, &mucse->state);
> +		dev_err(&mucse->pdev->dev,
> +			"RX DMA failed to quiesce, status %#x\n", dma_status);
> +	}
> +
> +	return err;
> +}
> +

[ ... ]

> @@ -838,6 +1309,66 @@ void rnpgbe_clean_all_tx_rings(struct mucse *mucse)
>  		rnpgbe_clean_tx_ring(mucse->tx_ring[i]);
>  }
>  
> +static void rnpgbe_stop_rx_ring(struct mucse_ring *rx_ring)
> +{
> +	/* Stop hw. hardware design guarantees:
> +	 * - No new descriptors will be fetched after RX_START=0
> +	 * - No DMA will be initiated for already-fetched descriptors
> +	 */
> +	mucse_ring_wr32(rx_ring, RNPGBE_RX_START, 0);
> +	/* Flush posted write to ensure hardware sees RX_START=0 */
> +	(void)mucse_ring_rd32(rx_ring, RNPGBE_RX_START);
> +}
> +
> +/**
> + * rnpgbe_stop_all_rx_rings - Stop RX DMA for all queues
> + * @mucse: board private structure
> + *
> + * Return: 0 when RX DMA was quiesced, negative errno otherwise
> + **/
> +static int rnpgbe_stop_all_rx_rings(struct mucse *mucse)
> +{
> +	struct mucse_hw *hw = &mucse->hw;
> +	u32 dma_axi_ctl;
> +	int err = 0;
> +
> +	for (int i = 0; i < mucse->num_rx_queues; i++)
> +		rnpgbe_stop_rx_ring(mucse->rx_ring[i]);
> +
> +	if (mucse->num_rx_queues &&
> +	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> +		err = rnpgbe_wait_rx_dma_idle(mucse);
> +
> +	dma_axi_ctl = mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +	dma_axi_ctl &= ~RX_AXI_RW_EN;
> +	mucse_hw_wr32(hw, RNPGBE_DMA_AXI_EN, dma_axi_ctl);
> +	/* Flush the posted write before continuing. */
> +	(void)mucse_hw_rd32(hw, RNPGBE_DMA_AXI_EN);
> +
> +	if (!test_bit(__MUCSE_AXI_FAULT, &mucse->state))
> +		return 0;
> +
> +	return err ? err : -EIO;
> +}

[Severity: Low]
Does the return value here match the kernel-doc "Return: 0 when RX DMA was
quiesced, negative errno otherwise"?

If __MUCSE_AXI_FAULT is already latched, for example set earlier by
rnpgbe_wait_tx_dma_idle(), then the RX wait is skipped:

	if (mucse->num_rx_queues &&
	    !test_bit(__MUCSE_AXI_FAULT, &mucse->state))
		err = rnpgbe_wait_rx_dma_idle(mucse);

err stays 0, yet the tail of the function still does:

	return err ? err : -EIO;

So -EIO is reported as "RX DMA did not quiesce" without RNPGBE_DMA_RX_STATUS
ever having been read.  rnpgbe_configure_rx() then forwards that -EIO to
rnpgbe_open() under the same wording in its own kernel-doc.

Refusing to bring the interface up after a terminal AXI fault looks
intentional, so would it be clearer to describe the sticky-fault case in
the kernel-doc of both functions rather than have it read as an RX quiesce
timeout?

[ ... ]

> @@ -1270,5 +1807,255 @@ void rnpgbe_get_stats64(struct net_device *netdev,

[ ... ]

> +/**
> + * rnpgbe_clean_rx_ring - Free Rx Buffers per Queue
> + * @rx_ring: ring to free buffers from
> + **/
> +static void rnpgbe_clean_rx_ring(struct mucse_ring *rx_ring)
> +{
> +	struct mucse_rx_buffer *rx_buffer;
> +	u16 i;
> +
> +	/* ring already cleared, nothing to do */
> +	if (!rx_ring->rx_buffer_info)
> +		return;
> +	/* Free all the Rx ring sk_buffs */
> +	for (i = 0; i < rx_ring->count; i++) {
> +		rx_buffer = &rx_ring->rx_buffer_info[i];
> +
> +		if (rx_buffer->skb) {
> +			struct sk_buff *skb = rx_buffer->skb;
> +
> +			dev_kfree_skb(skb);
> +			rx_buffer->skb = NULL;
> +		}
> +
> +		if (rx_buffer->page) {
> +			page_pool_put_full_page(rx_ring->page_pool,
> +						rx_buffer->page, false);
> +			rx_buffer->page = NULL;
> +		}
> +	}
> +
> +	rx_ring->next_to_clean = 0;
> +	rx_ring->next_to_use = 0;
> +}
> +
> +/**
> + * rnpgbe_free_rx_resources - Free Rx Resources
> + * @rx_ring: ring to clean the resources from
> + *
> + * Free all receive software resources
> + **/
> +static void rnpgbe_free_rx_resources(struct mucse_ring *rx_ring)
> +{
> +	vfree(rx_ring->rx_buffer_info);
> +	rx_ring->rx_buffer_info = NULL;
> +	/* if not set, then don't free */
> +	if (!rx_ring->desc)
> +		return;
> +
> +	dma_free_coherent(rx_ring->dev, rx_ring->size, rx_ring->desc,
> +			  rx_ring->dma);
> +	rx_ring->desc = NULL;
> +	if (rx_ring->page_pool) {
> +		page_pool_destroy(rx_ring->page_pool);
> +		rx_ring->page_pool = NULL;
> +	}
> +}

[Severity: Low]
Can this leak the page_pool pages held in rx_buffer_info?

rnpgbe_free_rx_resources() is documented as "Free all receive software
resources", but it vfree()s rx_buffer_info first, which discards every
page pointer and every chained skb pointer that rnpgbe_clean_rx_ring()
would have released:

	vfree(rx_ring->rx_buffer_info);
	rx_ring->rx_buffer_info = NULL;

page_pool_destroy() is also placed after the early bail-out:

	if (!rx_ring->desc)
		return;

so a ring that has a pool but no descriptor memory keeps the pool.

That makes rnpgbe_free_all_rx_resources() correct only when the caller has
already run rnpgbe_clean_all_rx_rings(), which is not stated anywhere.
rnpgbe_close() gets that ordering through rnpgbe_down(), but the new
err_free_rx label in rnpgbe_open() calls it with no preceding RX clean,
while the adjacent err_free_tx label does clean-then-free.

Since rnpgbe_configure_rx_ring() already posts up to ring->count -
M_RX_BUFFER_WRITE (496) pages per queue, any future failure return added at
or after that fill would reach err_free_rx with the page pointers gone, and
page_pool_destroy() would then run with inflight pages and keep warning
about a stalled pool shutdown.

Would it be safer to call rnpgbe_clean_rx_ring() from
rnpgbe_free_rx_resources() and destroy the pool before the desc check, so
the free path is self-contained?

[ ... ]

> +/**
> + * rnpgbe_configure_rx_ring - Configure Rx ring info to hw
> + * @mucse: pointer to private structure
> + * @ring: structure containing ring specific data
> + *
> + * Configure the Rx descriptor ring after a reset.
> + **/
> +static void rnpgbe_configure_rx_ring(struct mucse *mucse,
> +				     struct mucse_ring *ring)
> +{

[ ... ]

> +	mucse_ring_wr32(ring, RNPGBE_RX_INT_PKTCNT, M_DEFAULT_RX_INT_PKTCNT);
> +	/* Start an initial retry after NAPI is enabled. */
> +	rnpgbe_alloc_rx_buffers(ring, mucse_desc_unused_rx(ring));
> +}

[Severity: Low]
Is this comment describing the right call?  The call below it is the
initial synchronous fill, not a retry, and it runs before NAPI is enabled:

  rnpgbe_open() -> rnpgbe_configure() -> rnpgbe_configure_rx()
    -> rnpgbe_configure_rx_ring()

while napi_enable happens later in rnpgbe_up_complete() ->
rnpgbe_napi_enable_all().  The behaviour the comment describes looks like
rnpgbe_schedule_rx_retry(), which up_complete() calls after NAPI is
enabled.

This is also the only call site that discards the documented return value
of rnpgbe_alloc_rx_buffers() ("Return: true if alloc failed"), so a fully
failed initial fill leaves the ring empty with no rx_alloc_timer armed
until rnpgbe_schedule_rx_retry() re-checks.  Was that intended?

> +
> +/**
> + * rnpgbe_configure_rx - Configure Receive Unit after Reset
> + * @mucse: pointer to private structure
> + *
> + * Configure the Rx unit after a reset.
> + *
> + * Return: 0 on success, negative errno if RX DMA did not quiesce
> + **/
> +int rnpgbe_configure_rx(struct mucse *mucse)
> +{

[ ... ]

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 21136abe12317..6e006fbd17ad5 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> @@ -31,13 +31,19 @@ static struct pci_device_id rnpgbe_pci_tbl[] = {
>   * rnpgbe_configure - Configure the hardware
>   * @mucse: pointer to private structure
>   *
> - * Configure Tx registers in hardware.
> + * Configure Tx and Rx registers in hardware.
>   *
>   * Return: 0 on success, negative errno if hardware configuration fails
>   **/
>  static int rnpgbe_configure(struct mucse *mucse)
>  {
> -	return rnpgbe_configure_tx(mucse);
> +	int err;
> +
> +	err = rnpgbe_configure_tx(mucse);
> +	if (err)
> +		return err;
> +
> +	return rnpgbe_configure_rx(mucse);
>  }

[Severity: Low]
The changelog says "Add basic RX packet reception for the RNPGBE driver",
but at this commit only the DMA side is programmed.  There is no MAC-level
receive enable and no address filtering yet:

  git grep -E 'GMAC|set_rx_mode|set_link' drivers/net/ethernet/mucse/

returns nothing at this commit.  The pieces arrive later in the same
series, where rnpgbe_set_rx_mode() programs the RAR and multicast hash and
is registered as .ndo_set_rx_mode, and rnpgbe_set_link() sets
GMAC_CONTROL_RE plus GMAC_FRAME_FILTER = GMAC_RX_ALL on link up.

Could the changelog mention that MAC receive enable and filtering come in
follow-up patches, so it is clear packets are not yet received at this
step?

> @@ -69,13 +75,18 @@ static int rnpgbe_open(struct net_device *netdev)
>  	err = rnpgbe_setup_all_tx_resources(mucse);
>  	if (err)
>  		goto err_free_irqs;
> +	err = rnpgbe_setup_all_rx_resources(mucse);
> +	if (err)
> +		goto err_free_tx;
>  
>  	err = rnpgbe_configure(mucse);
>  	if (err)
> -		goto err_free_tx;
> +		goto err_free_rx;
>  	rnpgbe_up_complete(mucse);
>  
>  	return 0;
> +err_free_rx:
> +	rnpgbe_free_all_rx_resources(mucse);
>  err_free_tx:
>  	rnpgbe_clean_all_tx_rings(mucse);
>  	rnpgbe_free_all_tx_resources(mucse);

[Severity: Low]
Same point as above, from the caller side: should err_free_rx mirror
err_free_tx and clean the RX rings before freeing their resources?

err_free_tx does:

	rnpgbe_clean_all_tx_rings(mucse);
	rnpgbe_free_all_tx_resources(mucse);

while err_free_rx only frees.  Today every failure return reaches this
label before rnpgbe_configure_rx_ring() has posted any page, so nothing
leaks yet, but the asymmetry makes the path fragile if a later failure
return is added after the RX buffer fill.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/64BE41C2D2C0836A%2B20260914013019.2262317-1-dong100%40mucse.com
