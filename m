Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395969;
	b=DKxwBediTGG9aik3pNWZgsI0LCp+nalJNZZHuZZOglsGwe0K3WbcyZ4mHvFCQz48LgIu
	 RnrTMNjx2ydLdMAcO/QK81B+hs47AJ2nrpyDIMQ+R+scJJVJTKdQ/zP3AO9fOSRttmK6j
	 9fx1+DwV8gvvgrj6XSZ41CaggbagcUcvPS0vK5AtLFam0YeHt5CvEJp0pS7V5eN8ROXui
	 UKZU1luUiQd5k2oSugDSTMj7wthCTvoyILTfM78RpCj5J7DXXLqEqBXFCsRJtsw6JMLHk
	 VBtUpnmwJn/SOazOEnL8jckNwb37MNiAZUvNbUd8TqMgiq9jBpe/ZUTOwoVaD07scLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395969;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uob3BhIRyzjXuGomSt8dP0MqP8bCTPEwp7jEZ+lxeqU=;
	b=pJOnPPmxgBS48NsvNhpz/unbCYgYZuY+RPkkKLuZhqOLvudp2+n19Oi2AqXA5MuCywk9
	 vRWPerMxN02I6ndVefLcGZKtbMNT04PUC6OQKZg71/B50S3YKIMMirR9EkfYXDMMqAW0y
	 Lo0LcX/8RV3Y/PxtgwFN1SPPpqt23+DLRtyMyCmhlwu4J3P7b0zVFki9tX6b2YujOY7yN
	 EhL4ja3R2FFna5xzCQC8WjT7hwtGtxhiSpWWxjQgfiV1bUlbVLsO0QE9pNaa35p5JSgYx
	 pUnI8AHuOV4+5JiUPwGoIekgL3uDOZaiGNUVufrjPwkyRqb70IAtcDPCbWx0k7VYg8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXW6AgZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E609606A31C;
	Fri, 30 Oct 2026 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXW6AgZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B6E1F00A02;
	Fri, 30 Oct 2026 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793395969;
	bh=uob3BhIRyzjXuGomSt8dP0MqP8bCTPEwp7jEZ+lxeqU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PXW6AgZ1/ZOx1vRACNXmKr4OcwCPg3Ec1TJrfRspdjpGLEJyh+Q5rB9STXS2zLTj0
	 C2eHjmORjVOWydGbDqUhvCyXFll3l2ROs1PqrJ4d0l82rTQcOp/J8dlpgs5AfvN4Ce
	 muvL8GhrSzan4qBMUntlkawZIzicSbLNckS95YNDsij3Ig+G3OogVe5KYSh6gK2mVU
	 Hm0TgUCMmXlRSL9KfyyfOoCw8barRxNvdPojg+A6GLXzBtIEeaQtvNAD7Ucc/jYq6n
	 rXYc342qoow7bDxRjG/1J4eGN46VQ4WvFDpmZePwLFV+anEhm7xDTOUuiwWQUa5F+1
	 /i99VhpT4YmdQ==
Subject: Re: [PATCH net] net: lan966x: save the RX state after quiescing the
 NAPI in a reload
From: netdev-bot+sashiko@kernel.org
To: daniel.machon@microchip.com
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, devnexen@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 21:32:48 +0000
Message-ID: <179339596805.3131.15722665365949001732@kernel.org>
In-Reply-To:
 <20261029-lan966x-fdma-reload-quiesce-v1-1-daaeda5ca3aa@microchip.com>
References:
 <20261029-lan966x-fdma-reload-quiesce-v1-1-daaeda5ca3aa@microchip.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (4) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully fix the restore path, even though the
  commit message says it does.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  lan966x_fdma_rx_alloc()…
- [High] This problem wasn't introduced by this patch, but
  lan966x_fdma_reload() swaps lan966x->rx.page_pool and destroys the old…
- [High] This problem wasn't introduced by this patch, but it produces
  the same outcome the commit message describes: a page the stack still…
- [High] This problem wasn't introduced by this patch, but
  lan966x_fdma_reload() runs lan966x_fdma_rx_start() and…

--

net: lan966x: save the RX state after quiescing the NAPI in a reload

This patch moves napi_synchronize(), napi_disable() and
lan966x_fdma_stop_netdev() in lan966x_fdma_reload() so they run before
the copies of rx->page[] and the RX FDMA state are taken. A NAPI poll
can then no longer advance the ring after the snapshot. The old_pages
buffer is still allocated first, so an allocation failure returns
before anything needs to be undone.

> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 21668bbcc9063..2dbc25c098fec 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -819,21 +819,21 @@ static int lan966x_fdma_reload(struct lan966x *lan966x, int new_mtu)
>  	int page_order, max_mtu;
>  	int err, i, j;
>  
> -	old_pages = kmemdup(lan966x->rx.page, sizeof(lan966x->rx.page),
> -			   GFP_KERNEL);
> +	old_pages = kmalloc_objs(*lan966x->rx.page, FDMA_DCB_MAX);
>  	if (!old_pages)
>  		return -ENOMEM;
>  
> +	napi_synchronize(&lan966x->napi);
> +	napi_disable(&lan966x->napi);
> +	lan966x_fdma_stop_netdev(lan966x);

[Severity: High]
This is a pre-existing issue, but both the success path and the restore
path of lan966x_fdma_reload() restart things in this order:

	lan966x_fdma_rx_start(&lan966x->rx);
	[ ... ]
	lan966x_fdma_wakeup_netdev(lan966x);
	napi_enable(&lan966x->napi);

An FDMA DB interrupt can fire while NAPI is still disabled. Examples are
a TX completion after netif_wake_queue() on another CPU, or ndo_xdp_xmit
traffic, which ignores queue state. In that case lan966x_fdma_irq_handler()
does:

		lan_wr(0, lan966x, FDMA_INTR_DB_ENA);
		lan_wr(db, lan966x, FDMA_INTR_DB);

		napi_schedule(&lan966x->napi);

The napi_schedule() does nothing, because napi_disable() holds
NAPI_STATE_SCHED. napi_enable() does not schedule a poll either.
FDMA_INTR_DB_ENA is only re-armed by the poll, by rx_start, or by the
first TX activation.

Could this leave all DB interrupts masked, with RX and TX completion
dead on every port until the next reload?

There is also a narrower window between napi_disable() and rx_start().
The read-modify-write in rx_start only sets the RX channel bit, so a TX
bit cleared by the handler stays cleared until an RX poll writes 0xff.

lan966x_fdma_pci_reload() documents this hazard and calls napi_enable()
first:

	/* Order matters: napi_enable() must precede the wakes, or a TX that
	 * completes first clears FDMA_INTR_DB_ENA with nothing scheduled to
	 * restore it, leaving RX dead until the next reload.
	 */

Should the platform reload use the same ordering?

> +
>  	/* Store these for later to free them */
> +	memcpy(old_pages, lan966x->rx.page, sizeof(lan966x->rx.page));

[Severity: High]
This isn't a bug introduced by this patch, but a refill failure in
lan966x_fdma_napi_poll() seems to lead to the outcome the commit message
describes, a page the stack still owns being returned to the old pool:

allocate_new:
	while (dcb_reload != fdma->dcb_index) {
		[ ... ]
		fdma_dcb_add(fdma, old_dcb, FDMA_DCB_INFO_DATAL(fdma->db_size),
			     FDMA_DCB_STATUS_INTR);
		[ ... ]
	}

The return value of fdma_dcb_add() is ignored. If
page_pool_dev_alloc_pages() fails, lan966x_fdma_rx_dataptr_cb() returns
-ENOMEM without updating rx->page[old_dcb][0]. The slot still points at
the page that was already passed to the stack, placed in the TX ring,
redirected, or recycled.

The DCB is not relinked either. Software eventually stops at that DCB,
so the stale pointer stays in place.

The next reload copies that pointer into old_pages here and calls
page_pool_put_full_page() on it before page_pool_destroy(). Can this
cause a use-after-free or double free when the skb or xdp_frame owner
later frees the page? lan966x_fdma_rx_free_pages() at teardown seems to
have the same exposure.

>  	memcpy(&fdma_rx_old, &lan966x->rx.fdma, sizeof(struct fdma));

[Severity: High]
The commit message says:

  "...and the restore path puts back a stale DCB index and last DCB
  pointer."

With the snapshot now taken after napi_disable(), the restore path puts
back the current dcb_index (say k) and last_dcb (DCB k-1). Does the
hardware agree with that position? The restore path does:

restore:
	[ ... ]
	memcpy(&lan966x->rx.fdma, &fdma_rx_old, sizeof(struct fdma));
	[ ... ]
	lan966x_fdma_llp_configure(lan966x, lan966x->rx.fdma.dma,
				   lan966x->rx.fdma.channel_id);

	lan966x_fdma_rx_start(&lan966x->rx);

The LLP points at the ring base (DCB 0), and the channel is reactivated
without rebuilding the DCB chain.

After traffic, each NAPI refill through fdma_dcb_add()->__fdma_dcb_add()
appends the consumed DCB after last_dcb with an INVALID nextptr. The
chain is then k -> ... -> n-1 -> 0 -> ... -> k-1 (INVALID).

Starting at DCB 0, the hardware would fill DCBs 0..k-1 and stop at k-1.
lan966x_fdma_napi_poll() only checks fdma_has_frames() on DCB k. If
lan966x_fdma_rx_alloc() fails while k != 0, wouldn't RX stop on all
ports until the next successful reload?

On its restore path, lan966x_fdma_pci_reload() calls
lan966x_fdma_pci_reset_mem(). That runs fdma_dcbs_init() to reset the
indices and rebuild the chain before the LLP is programmed.

Does the platform restore path need to re-initialise the old ring in a
similar way, or program the LLP to fdma.dma + dcb_index *
sizeof(struct fdma_dcb)?

>  	page_pool = lan966x->rx.page_pool;

[Severity: High]
This is a pre-existing issue, but is it safe to destroy this page_pool
while XDP_TX pages from it can still be queued in the TX ring?

lan966x_fdma_xmit_xdpf() stores the RX page in the TX ring:

		next_dcb_buf->data.page = page;

These buffers are only reclaimed from NAPI, by
lan966x_fdma_tx_clear_buf(). That function recycles into whichever pool
is current:

			else
				page_pool_recycle_direct(rx->page_pool,
							 dcb_buf->data.page);

The TX channel is not drained during the reload. After napi_enable(),
these old-pool pages would be recycled into the new pool, and
__page_pool_put_page() does not check page->pp against the pool
argument.

Would the old pool's inflight count then never reach zero, so the
deferred page_pool_destroy() never completes? The new pool's inflight
accounting would also go negative.

When the MTU grows (page_order 0 -> 2), the new pool would DMA sync and
later unmap an order-0 page using its larger max_len and order. On
non-coherent systems, could that invalidate cache lines past the end of
the page, or let the device DMA past it? After XDP detach the dma_dir
would also mismatch (DMA_BIDIRECTIONAL vs DMA_FROM_DEVICE).

>  	page_order = lan966x->rx.page_order;
>  	max_mtu = lan966x->rx.max_mtu;
>  
> -	napi_synchronize(&lan966x->napi);
> -	napi_disable(&lan966x->napi);
> -	lan966x_fdma_stop_netdev(lan966x);
> -
>  	lan966x_fdma_rx_disable(&lan966x->rx);
>  	lan966x->rx.page_order = round_up(new_mtu, PAGE_SIZE) / PAGE_SIZE - 1;
>  	lan966x->rx.max_mtu = new_mtu;

[Severity: High]
This isn't a bug introduced by this patch, but lan966x_fdma_rx_alloc(),
called right after this, drops the return value of fdma_dcbs_init():

	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
		       FDMA_DCB_STATUS_INTR);

	lan966x_fdma_llp_configure(lan966x, fdma->dma, fdma->channel_id);

	return 0;

Suppose page_pool_dev_alloc_pages() fails at DCB k. This can happen
because it uses GFP_ATOMIC, with order > 0 for a jumbo MTU.
lan966x_fdma_rx_dataptr_cb() then returns -ENOMEM before writing
rx->page[k][0], and fdma_dcbs_init() stops there.

lan966x_fdma_reload() still takes the success path. It puts every
old_pages[i][j] back to the old pool and calls page_pool_destroy().
rx.page[k..n_dcbs-1] are never cleared, so they still point at those
old pages.

Could a later lan966x_fdma_rx_free_pages() on deinit, or the memcpy()
into old_pages on the next reload, put those freed pages again?

The new ring would also end at DCB k-1, so RX would stall once
dcb_index reaches k.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261029-lan966x-fdma-reload-quiesce-v1-1-daaeda5ca3aa%40microchip.com
