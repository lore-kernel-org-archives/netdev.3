Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961053C09F1;
	Mon, 21 Sep 2026 10:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986046; cv=none; b=hLg/gWcXIMKAlaIAzDkmN+iIWO/pREOsTClWkxAhhAV3YHpyT33inN4qLg4WkLOY6gVXxkXNmZqDqnRyuxThEhxdq+b+BimPuqL6ZnS+aaZmQjastntJ1g+bOn77FMABDBv+dge23XurkwepBEkzw8V0ozF8NIUq013qf78tGQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986046; c=relaxed/simple;
	bh=UeCIAhOGNk15SvNM6RJjrfSzoCNngwXM5nP/V/gEFdE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=adw9zTbdu9P5glSWGPRbTw3NyMFp5fPH5tSVdmI397NsF4nQxUy9mpsIOrqUiM3N6EI09whgnh3DQ1LMfIHpNjFl8w/DSRrnRja/75zI/nRR5xKDEnwifBtNpQWXj2ppi1SVhss7FC5AH+iGUARCpSZrbP1CRtgMWHe9CqpvP+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrMUPLkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrMUPLkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B191F000FF;
	Mon, 21 Sep 2026 10:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789986041;
	bh=NNLMb5AFJCxC745nVpuaFiewc9/2MlH8Pg3ljXvOpj0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IrMUPLkKpQcDlbrGZTdQTV9W9/dlD87OAArKdawf0J895O3QCGqnTR+U4eJ++5Lbt
	 7dnOcAoBh7XoRBC+U+hxEtlbSmhqNwQtU4RZOMfGL1CYEh4GFtj50XnQLkn0ETV+5L
	 8CvdFJBCDbFqdK8DJebEsZAmPH6L+hhTCwoM54y554eWFZ4gUTzRF8fx846lz4QUUZ
	 OsJ76eMJzdbts56aagfaudVTRCcPjxgLLQ/6tTCbXRYrT7EzfUW7D5ewADoQk2cUSV
	 Y9h6vy4DiYhJV3ln9x7++PFP5PaPxiKwkhnoxDG2jCPtTv1BPT6oaQonUjCchDUynY
	 nKTjRO9RYa+hg==
Subject: Re: [PATCH net v2] net: xilinx: axienet: Free outstanding DMA buffers
 on dmaengine stop
From: netdev-bot+sashiko@kernel.org
To: suraj.gupta2@amd.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 10:20:40 +0000
Message-ID: <178998604072.2160803.17018942361014137390@kernel.org>
In-Reply-To: <20260917100525.250952-1-suraj.gupta2@amd.com>
References: <20260917100525.250952-1-suraj.gupta2@amd.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new @stopping check in axienet_dma_rx_cb() does not actually
  fence RX resubmission against the terminate in axienet_stop(), so the…

Pre-existing issues:
- [High] TX ring head/tail desynchronization causes a NULL pointer
  dereference in axienet_dma_tx_cb().

--

net: xilinx: axienet: Free outstanding DMA buffers on dmaengine stop

In the dmaengine path the driver clears the ring slot's skb pointer in the
TX and RX completion callbacks, so a non-NULL skb marks a slot that still
owns a live DMA-mapped buffer, and axienet_stop() unmaps and frees every
such buffer instead of only kfree()ing the ring shells. It also sets
@stopping before dmaengine_terminate_sync() and checks it in
axienet_dma_rx_cb() to fence RX resubmission, and releases the channels
before freeing the rings.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 1722b7038f340..fc314f67f157c 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -881,6 +881,7 @@ static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
>  	u64_stats_update_end(&lp->tx_stat_sync);
>  	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
>  	dev_consume_skb_any(skbuf_dma->skb);
> +	skbuf_dma->skb = NULL;

[Severity: High]
This isn't a bug introduced by this patch, but can clearing the slot's skb
here turn an existing TX ring desynchronization into a NULL pointer
dereference?

axienet_start_xmit_dmaengine() advances the head before the fallible steps:

	lp->tx_ring_head++;
	sg_init_table(skbuf_dma->sgl, sg_len);
	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
	if (ret < 0)
		goto xmit_error_drop_skb;

	ret = dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
	if (!ret)
		goto xmit_error_drop_skb;

None of the xmit_error_* labels rewind lp->tx_ring_head, and they return
NETDEV_TX_OK without ever calling dmaengine_submit(), so that slot is
consumed with no descriptor behind it and skbuf_dma->skb is never assigned.

axienet_dma_tx_cb() pairs completions with slots positionally:

	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
	len = skbuf_dma->skb->len;
	txq = skb_get_tx_queue(lp->ndev, skbuf_dma->skb);

so after one skipped slot the head/tail pairing is off by one for the life of
the interface and the next completion lands on the skipped slot.

Before this patch that read a stale, already consumed skb pointer. With
skbuf_dma->skb = NULL set on every completion, the skipped slot's skb is
deterministically NULL, so the dereference above runs on NULL from the DMA
channel tasklet.

The triggering condition is a single dma_map_sg() failure, i.e. the same
IOMMU aperture exhaustion the commit message describes as motivation. Would
it be reasonable to advance lp->tx_ring_head only after
device_prep_slave_sg() succeeds, or unwind it on the pre-submit error paths,
as part of this series?

> @@ -1171,6 +1172,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  						       &meta_max_len);
>  	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
>  			 DMA_FROM_DEVICE);
> +	skbuf_dma->skb = NULL;
>  
>  	if (IS_ERR(app_metadata)) {
>  		if (net_ratelimit())
> @@ -1193,6 +1195,12 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	u64_stats_update_end(&lp->rx_stat_sync);
>  
>  rx_submit:
> +	/* Do not re-arm the RX ring while a stop is in progress, or the
> +	 * teardown could free a buffer still handed to the engine.
> +	 */
> +	if (READ_ONCE(lp->stopping))
> +		return;
> +
>  	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
>  				   RX_BUF_NUM_DEFAULT); i++)
>  		axienet_rx_submit_desc(lp->ndev);

[Severity: High]
Does this check actually fence resubmission against the terminate?

axienet_dma_rx_cb() runs from the xilinx DMA channel tasklet, which drops
chan->lock around dmaengine_desc_get_callback_invoke() in
xilinx_dma_chan_desc_cleanup(), concurrently with axienet_stop() in process
context. READ_ONCE()/WRITE_ONCE() only prevent tearing, they do not make the
check-then-submit sequence atomic:

CPU0 (DMA tasklet)                     CPU1 (axienet_stop)
axienet_dma_rx_cb()
  READ_ONCE(lp->stopping) == false
                                       WRITE_ONCE(lp->stopping, true);
                                       dmaengine_terminate_sync(rx_chan);
  axienet_rx_submit_desc()
    skbuf_dma->skb = skb;
    dmaengine_submit(dma_rx_desc);
  dma_async_issue_pending(lp->rx_chan);

Note that dmaengine_terminate_sync() ends in dmaengine_synchronize(), which
for this provider is xilinx_dma_synchronize() -> tasklet_kill(): it waits for
the running tasklet to finish rather than discarding what that tasklet
submits.

Does the late submit re-arm the hardware? xilinx_dma_tx_submit() queues the
descriptor and clears the provider's terminate state:

	append_desc_queue(chan, desc);
	...
	chan->terminating = false;

and xilinx_dma_terminate_all() left the channel idle:

	chan->terminating = true;
	xilinx_dma_free_descriptors(chan);
	chan->idle = true;

so the racing dma_async_issue_pending() reaches start_transfer() and
reprograms CURDESC/TAILDESC with DMACR.RUNSTOP set.

Is anything after that point stopping the channel again? dma_release_channel()
-> dma_chan_put() only does:

	if (!chan->client_count && chan->device->device_free_chan_resources) {
		/* Make sure all operations have completed */
		dmaengine_synchronize(chan);
		chan->device->device_free_chan_resources(chan);
	}

and xilinx_dma_free_chan_resources() dma_free_coherent()s chan->seg_v without
a stop_transfer() or reset, so moving the release ahead of the ring free does
not appear to close the window.

The new teardown loop then sees the resubmitted slot:

> +		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
> +			skbuf_dma = lp->rx_skb_ring[i];
> +			if (skbuf_dma && skbuf_dma->skb) {
> +				dma_unmap_single(lp->dev, skbuf_dma->dma_address,
> +						 lp->max_frm_size, DMA_FROM_DEVICE);
> +				dev_kfree_skb_any(skbuf_dma->skb);
> +			}

Can this unmap and free a buffer the engine is still writing into, turning
the former mapping leak into DMA write-after-free?

Documentation/driver-api/dmaengine/client.rst also states:

   The behavior of this function is undefined if dma_async_issue_pending() has
   been called between dmaengine_terminate_async() and this function.

which is exactly what the racing callback does inside the window, and this
patch removes the extra dmaengine_synchronize() calls that followed the
terminates.

There is a second placement question: the ring is dereferenced before the new
check,

	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
	skb = skbuf_dma->skb;

so a completion from a re-armed channel arriving after tasklet_kill() and
after kfree(lp->rx_skb_ring) touches freed memory before the @stopping test is
reached.

The commit message says "Set @stopping before terminating and check it in the
callback to fence resubmission, and release the channels before freeing the
rings so a late completion cannot touch a freed ring." Given the above, does
the check-submit-issue sequence need real serialization against the stop
transition, or a second dmaengine_terminate_sync() once all callbacks are
known to be drained?

> @@ -1752,20 +1761,43 @@ static int axienet_stop(struct net_device *ndev)
>  		free_irq(lp->rx_irq, ndev);
>  		axienet_dma_bd_release(ndev);
>  	} else {
> +		struct skbuf_dma_descriptor *skbuf_dma;
> +
> +		WRITE_ONCE(lp->stopping, true);
>  		dmaengine_terminate_sync(lp->tx_chan);
> -		dmaengine_synchronize(lp->tx_chan);
>  		dmaengine_terminate_sync(lp->rx_chan);
> -		dmaengine_synchronize(lp->rx_chan);
> -
> -		for (i = 0; i < TX_BD_NUM_MAX; i++)
> -			kfree(lp->tx_skb_ring[i]);
> -		kfree(lp->tx_skb_ring);
> -		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
> -			kfree(lp->rx_skb_ring[i]);
> -		kfree(lp->rx_skb_ring);
>  
> +		/* Release the channels before freeing the rings, so the DMA is
> +		 * fully torn down before the memory its descriptors reference is
> +		 * freed.
> +		 */
>  		dma_release_channel(lp->rx_chan);
>  		dma_release_channel(lp->tx_chan);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917100525.250952-1-suraj.gupta2%40amd.com
