Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348285;
	b=BxckaVwvhP8UuZ2QXQtleyKz1Bxj1Ewb5f6F/QWpIsdOKI3iQjbGsf6dDCQK4s0J0JJS
	 rxv2p88vPUl2PnYbZwdM66Wk72dPWS3UAhnrutRt6WTXcRgcA7hDku07dPfMLvMqpvHkU
	 9EaEAcJzUzALJyufb5hIea3P9QHqYfZX8XODCx6ae/627YL1aw8AjyiPHIWiibsTKDF+l
	 dHUDKJ8ayjVB6axBmOFay8mPuHPwmqKg3MZSGjs8bXyoq/lShq5/9wp6N9ZH7v2QThCjK
	 kKYVAlfxQbM9JXDyggXmMAeSmQq5w49Lvam8xyzEl9Wnrv4gtDXVM8XxfhahEo+0nhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fwRuhVu8Ld3SI2wO0WRsv2fa9LOBGhpg24WjC0hp/so=;
	b=kzgMzkbesko7wMqWPWqp+lUACyTd4tNMTpnhC8w2oVA6k08nDIR1zsHLx/QXhVMeFJb4
	 TmPALQVJv/h2kHu2uz3pulFR4H+9vO8uF4yT/ZKQB1w5cXz40JZeqCzlJB13yRB9aOKhV
	 mbUtG4kcAPepFKBuV1AhbnhzPL7Aoj4c+8qvW/QHWb5+6lPo6cnxc4ROeY5aMzm48N4DY
	 dzU/j3ENQ54FQW6eB/0dYJnFgiM6zK65fTPISIG5D4kj6QYqnH8cRIyDtwQu3RxY0qY3s
	 3QbbcZVdQ4MW6NfHRuANZFZII9YmzchUyHCzpJy5eLlDxy8QhbPJq7sSFR/NXwzhoHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpBBh3U+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACB060A2601;
	Tue, 10 Nov 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hpBBh3U+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798C81F008AB;
	Tue, 10 Nov 2026 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348284;
	bh=fwRuhVu8Ld3SI2wO0WRsv2fa9LOBGhpg24WjC0hp/so=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hpBBh3U+jBeHihVLKZderol7qrEyzsy7mZMtPAPZCC72hkhQT7n9Hik98R7qv16oY
	 tNKz4gYIoexMwgCrGnnMcuRQo30HvVaqJjZ0HZC26MbqqgjCtlP+y6SZSa2IGhlBkA
	 SQ0dMgxzf08XLzT2/uS29a/QPehvmO50BnAOxfqneIQGBn+7zjyogqx+/vLEA+Rjj3
	 TJg36zBZt4NmhW0ahM1kRx7WQCGk/d31vCGNkPbhB3e7PgmpLggwg82k+5LMSCs/Oy
	 fG9jyuX00hfUZXBjPVQQBhO1PBibLw/M0Lv2Cp7UjXLuhukf0yiyYCXkB0ZGnMQ0ZB
	 UcbnlaqHgy+bw==
From: Jakub Kicinski <kuba@kernel.org>
To: daniel.machon@microchip.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	UNGLinuxDriver@microchip.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robert.marko@sartura.hr
Subject: Re: [PATCH net-next 6/9] net: sparx5/lan969x: add support for resizing the FDMA buffers
Date: Tue, 10 Nov 2026 14:04:43 -0800
Message-ID: <20261110220443.2337242-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105-sparx5-mtu-change-v1-6-f27bab580463@microchip.com>
References: <20261105-sparx5-mtu-change-v1-6-f27bab580463@microchip.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sparx5/lan969x: add support for resizing the FDMA buffers

This adds an fdma_resize operation for Sparx5 and lan969x. It allocates
new FDMA buffers sized for a new MTU, pauses the FDMA and port TX queues,
swaps in the new buffers and resumes. Before the FDMA is stopped, CPU port
forwarding is disabled and the CPU queues are drained. On lan969x the RX
page slot is now cleared once the page has been passed to the stack.

> diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> index 26a0815a0173b..d84663da35891 100644
> --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x_fdma.c
> @@ -153,6 +153,12 @@ static struct sk_buff *lan969x_fdma_rx_get_frame(struct sparx5 *sparx5,
>  	skb->dev->stats.rx_bytes += skb->len;
>  	skb->dev->stats.rx_packets++;
>  
> +	/* The page is passed to the stack in the skb, so clear its slot in the
> +	 * ring, so that lan969x_fdma_rx_free() does not return it to the
> +	 * page_pool.
> +	 */
> +	rx->page[fdma->dcb_index][fdma->db_index] = NULL;
> +
>  	return skb;
>  
>  free_page:

[Severity: High]
What happens to the slot on the free_page error path just below?

lan969x_fdma_rx_get_frame() takes that path on WARN_ON(!port) for a bad
IFH src_port, or when build_skb() fails:

free_page:
	page_pool_recycle_direct(rx->page_pool, page);

	return NULL;

The page goes back to the page_pool, but
rx->page[fdma->dcb_index][fdma->db_index] still points at it.
lan969x_fdma_napi_poll() then breaks without calling fdma_db_advance(),
so the stale slot stays in the ring:

	skb = lan969x_fdma_rx_get_frame(sparx5, rx);
	if (!skb)
		break;

Later, lan969x_fdma_resize() calls lan969x_fdma_rx_free() on the live
ring. lan969x_fdma_free_pages() treats every non-NULL slot as owned by
the driver:

	if (!rx->page[i][j])
		continue;

	page_pool_put_full_page(rx->page_pool,
				rx->page[i][j], false);

Can this put the already recycled page a second time? With
pp_ref_count == 1, page_pool_unref_netmem() returns 0 without
decrementing. The pool then seems to accept the page again, and
page_pool_destroy() would DMA unmap it and call put_page() on it twice.

The refill loop in the same poll could also take the recycled page from
the alloc cache for another DCB. Two slots would then reference the same
page, and it would be put once for each slot.

Clearing the slot in free_page alone does not look like enough, because
the next poll would then call page_address(NULL) for that slot. Should
the error path drop the frame and advance or re-arm the DB instead?

[ ... ]

> @@ -437,3 +445,87 @@ int lan969x_fdma_deinit(struct sparx5 *sparx5)
>  
>  	return 0;
>  }
> +
> +/* Release the TX buffers that were in flight when the FDMA was reset, and
> + * initialize the TX DCBs again.
> + */
> +static void lan969x_fdma_tx_reset(struct sparx5 *sparx5)
> +{

[ ... ]

> +	for (int i = 0; i < fdma->n_dcbs; ++i) {
> +		db = &tx->dbs[i];
> +
> +		if (!db->used)
> +			continue;
> +
> +		db->dev->stats.tx_dropped++;
> +		sparx5->tx.dropped++;

[Severity: Medium]
What happens to two-step PTP frames that are still in the ring here?

sparx5_port_xmit_impl() calls sparx5_ptp_txtstamp_request() before
ops->fdma_xmit(). That call sets SKBTX_IN_PROGRESS, queues the skb on
port->tx_skbs and increments sparx5->ptp_skbs. lan969x_fdma_xmit() then
sets db->ptp = true. Normally the PTP timestamp interrupt releases the
skb once the frame has gone out.

This loop only visits entries that lan969x_fdma_tx_clear_buf() did not
complete. Those frames were never injected, so no timestamp interrupt
will ever arrive for them. For a ptp entry the loop just skips
dev_kfree_skb_any() and clears db->used. The skb stays on
port->tx_skbs, and sparx5->ptp_skbs is never decremented.

sparx5_ptp_txtstamp_old_release() may later unlink and free the stale
skb, but it does not touch sparx5->ptp_skbs. So every MTU change that
catches a two-step frame in flight leaks one slot. Once ptp_skbs
reaches SPARX5_MAX_PTP_ID, every later two-step timestamp request on
any port fails with -EBUSY.

The NETDEV_TX_BUSY path in sparx5_port_xmit_impl() uses
sparx5_ptp_txtstamp_release() for the same situation. That helper
also decrements port->ts_id and does not free the skb, though. It may
therefore not be usable as-is for a frame in the middle of the queue.
How should a dropped two-step frame be unwound here?

[ ... ]

> +	fdma_dcbs_init(fdma,
> +		       FDMA_DCB_INFO_DATAL(fdma->db_size),
> +		       FDMA_DCB_STATUS_DONE);
> +}

[Severity: Low]
This isn't a bug, but the commit message says:

  On lan969x, where TX frames are mapped directly from the skbs, only the
  RX buffers and page_pool are replaced.

lan969x_fdma_tx_reset() drops every TX skb still in flight, counts each
one as tx_dropped and re-initialises the TX DCB ring.

On both chips, sparx5_fdma_pause() waits at most 5 ms for TX to drain
and at most 100 ms for the CPU queues to drain. Whatever is left is then
lost to the reset or discarded by sparx5_xtr_flush().

Could the commit message say that an MTU change can drop TX frames and
CPU-bound RX frames on all ports?

[ ... ]

> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> index 3a74a305d55d4..f4bb420d3f27b 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_fdma.c

[ ... ]

> +void sparx5_fdma_pause(struct sparx5 *sparx5)
> +{

[ ... ]

> +	sparx5_fdma_cpu_fwd_set(sparx5, false);
> +	if (read_poll_timeout(sparx5_fdma_cpu_queue_use,
> +			      use,
> +			      !use,
> +			      SPX5_FDMA_XTR_DRAIN_SLEEP_US,
> +			      SPX5_FDMA_XTR_DRAIN_TIMEOUT_US,
> +			      false,
> +			      sparx5))
> +		dev_warn(sparx5->dev, "CPU queue not drained, frames dropped\n");
> +
> +	sparx5_fdma_stop(sparx5);
> +
> +	/* Reset FDMA state */
> +	spx5_wr(FDMA_CTRL_NRESET_SET(0), sparx5, FDMA_CTRL);
> +	spx5_wr(FDMA_CTRL_NRESET_SET(1), sparx5, FDMA_CTRL);

[Severity: Medium]
If this drain times out, is it safe to continue with sparx5_fdma_stop()
and the NRESET pulse?

The commit message says that stopping the FDMA while frames are still
arriving for the CPU can stop extraction for good after the restart. On
a timeout CUR_INUSE is still non-zero, which looks like exactly that
state.

The TX drain timeout above is handled the same way. The channel-inactive
and XTR_BUF_IS_EMPTY poll results inside sparx5_fdma_stop() are also
ignored.

A timeout looks reachable whenever RX extraction stalls. One example is
lan969x_fdma_napi_poll() breaking on the get_frame error path without
advancing. Another is sparx5_fdma_rx_get_frame() returning false for
"Data on inactive port" without advancing.

sparx5_fdma_pause() returns void, so neither sparx5_fdma_resize() nor
lan969x_fdma_resize() can back out here, even though the old buffers are
still intact. Instead they free the old rings, resume and report
success. Should pause() return an error so the resize can fail cleanly?

> +
> +	/* Discard frames queued for the CPU, as they may not fit the new
> +	 * buffers.
> +	 */
> +	sparx5_xtr_flush(sparx5, XTR_QUEUE);
> +}
> +
> +/* Restart the FDMA and the port TX queues after sparx5_fdma_pause() */
> +void sparx5_fdma_resume(struct sparx5 *sparx5)
> +{
> +	struct sparx5_rx *rx = &sparx5->rx;
> +	struct sparx5_tx *tx = &sparx5->tx;
> +
> +	/* Enable NAPI before the RX interrupt is enabled, as the interrupt
> +	 * handler schedules NAPI, as in sparx5_fdma_start().
> +	 */
> +	napi_enable(&rx->napi);
> +
> +	sparx5_fdma_rx_activate(sparx5, rx);
> +	sparx5_fdma_tx_activate(sparx5, tx);

[Severity: Low]
On lan969x, can the TX completion interrupt stay masked after this?

sparx5_fdma_rx_activate() only sets the RX channel bit in
FDMA_INTR_DB_ENA:

	spx5_rmw(BIT(fdma->channel_id),
		 BIT(fdma->channel_id) & FDMA_INTR_DB_ENA_INTR_DB_ENA,
		 sparx5, FDMA_INTR_DB_ENA);

sparx5_fdma_tx_activate() does not touch this register. While the device
is running, lan969x_fdma_napi_poll() re-enables the full mask, which
includes the TX channel:

	if (counter < weight && napi_complete_done(napi, counter))
		spx5_wr(0xff, sparx5, FDMA_INTR_DB_ENA);

The TX bit can be left cleared during the resize in three ways:

  - sparx5_fdma_handler() writes 0 to FDMA_INTR_DB_ENA when it schedules
    NAPI.
  - napi_disable() can complete a poll that used its full budget without
    the driver writing 0xff.
  - sparx5_fdma_rx_deactivate() only clears the RX bit.

On lan969x, TX descriptors are only reclaimed from NAPI. With TX-only
traffic and no CPU-bound RX, the 64-entry ring could fill.
lan969x_fdma_get_next_dcb() would then return -ENOSPC, and
sparx5_port_xmit_impl() would keep returning NETDEV_TX_BUSY until some
RX frame triggers NAPI.

[ ... ]

> +int sparx5_fdma_resize(struct sparx5 *sparx5, struct sparx5_port *port,
> +		       int new_mtu)
> +{

[ ... ]

> +	sparx5_fdma_rx_init(sparx5, rx_new, FDMA_XTR_CHANNEL, db_size);
> +	sparx5_fdma_tx_init(sparx5, &tx_new, FDMA_INJ_CHANNEL, db_size);
> +
> +	err = sparx5_fdma_rx_alloc(rx_new);
> +	if (err)
> +		goto out;

[Severity: Medium]
This runs from ndo_change_mtu in process context. The whole new RX ring
is still filled through this chain:

sparx5_fdma_rx_alloc()->fdma_dcbs_init()->fdma_dcb_add()->
    sparx5_fdma_rx_dataptr_cb()

and that callback hard-codes GFP_ATOMIC:

	skb = __netdev_alloc_skb(rx->ndev, fdma->db_size, GFP_ATOMIC);

That is 64 * 15 = 960 skbs. For jumbo MTUs each skb head is a
kmalloc-16k object, so this is roughly 15 MB of high-order allocations
with no direct reclaim or compaction. The old ring stays allocated the
whole time.

Could this make MTU increases fail with -ENOMEM on fragmented systems?
Could it also drain the atomic reserves that the NAPI refill of the
still-running old ring depends on?

The callback is shared with the NAPI refill path. Would it be better to
give the resize path a sleepable gfp mask, or a separate allocation
callback?

lan969x_fdma_rx_dataptr_cb() also allocates with GFP_ATOMIC, through
page_pool_dev_alloc_pages(), but only for 64 pages.

[ ... ]
