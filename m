Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2BC41D110
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790103095; cv=none; b=J8WaYxforjOHim724sYhpQcTz/KBLu6lG8sEgSf9fTJWAZRIwcF86iHvbOUrBc1mFl7wF+wE98wmIQBnLGNAI0pfaACGVYW8uLTJZ3HLSJEPFdlAz3x78NdC4XY04PA6GvDOY+hlVAKZuhDVu+0ORyxF7+SzKMwtOJv4mXzztF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790103095; c=relaxed/simple;
	bh=+7PVrOjlnEOKEw9EYBJI733rjzEqFcdj7qhV8F0CMNo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mqW+bXtSWPukvdFdzz6GL8c/KW1OTV1kc62WKR2H7McTAx213+OZt5HFiABBbZAWvS4yyUA3BDYQnKe8O0/WzXmv0DpgCBSUCS9Ql8qoS/tiHOb6RKwz7CoeGCQlICOw5LalvGHFG0yZpZ8zo2wbmrMn8Pps/D6SesdnMlMAuDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3ZK12K3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3ZK12K3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E361F00893;
	Tue, 22 Sep 2026 18:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790103093;
	bh=G8MNtF+nQDRzXIvnMlT9+qVeEIfGSqtm84JwDOvIRoQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q3ZK12K3ikliMVFeZgP2trAhNlaweFB1IjU/4luBUFB7TY1fBM3lCEL70JZoG9RUl
	 VNQe02If2NMCM/a3CWThX1ZAbg59yS60lAcdXeux3Q9cKrD4wWuIDntnQ458MLXrLM
	 M+q2DSnFc+tsBURkfNlEHy/qdkAdBphUrFbgoTRj+ndGZSPbdcJB9ymFLMzIXSkzbB
	 1+gjUI5rSOk+/uTAANnqBnsRYy6JJlF+5Z7yj44gTLcAFeO9TB11FlHH/Y2Tot2wsr
	 iEOnfs+48+ud4Rh6BNLLSazEuOKE/p381RPTmMVWbNynJAX/t1XbGYuiXlORxbCCOp
	 ikR2qUJI/yN+g==
Subject: Re: [PATCH net-next 2/3] net: ethernet: cortina: Manage RX buffers
 with page_pool
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Tue, 22 Sep 2026 18:51:32 +0000
Message-ID: <179010309210.2160803.1756386466981857519@kernel.org>
In-Reply-To: <20260920-gemini-ethernet-fixes-3-v1-2-3a2a50a83d89@kernel.org>
References: <20260920-gemini-ethernet-fixes-3-v1-2-3a2a50a83d89@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 0 · High: 3 (2) · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] page_pool operations that manipulate BH state are performed
  while geth->freeq_lock is held with hardirqs disabled.
- [High] A failed geth_setup_freeq() leaves geth->freeq_pool,
  geth->freeq_ring, geth->freeq_pages and geth->freeq_page_bitmap NULL…
- [High] net: cortina: valid packets dropped on 0-length EOF descriptors
- [Medium] The newly added RX length guard in gmac_rx() bounds the
  fragment against the page ('if (frag_len > PAGE_SIZE - page_offs) goto…
- [Medium] geth_setup_freeq() now sizes geth->freeq_pages,
  geth->freeq_page_bitmap and geth->num_freeq_pages from…
- [Medium] The rewritten geth_fill_freeq() drops the throttle that
  bounded per-refill allocation work and moves all of it under an IRQ-…

Pre-existing issues:
- [High] geth_cleanup_freeq() destroys the page_pool, frees/NULLs
  geth->freeq_page_bitmap, frees geth->freeq_pages, zeroes…
- [High] geth_resize_freeq() dereferences the sibling port pointer before
  checking it: 'if (netdev->dev_id == 0) other_netdev =…

--

net: ethernet: cortina: Manage RX buffers with page_pool

This converts the Gemini shared software free queue from hand-rolled
alloc_page()/dma_map_single() buffers to a single page_pool owned by the
parent Ethernet device, indexes each fragment by DMA address in an xarray,
and adds sync-for-CPU plus page_pool recycling on the RX path.

A few questions below about the new locking context, the failure paths and
the fragment length validation.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 31bcd41c17fa..6d5f7dacf12a 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -782,84 +852,100 @@ static void gmac_cleanup_rxq(struct net_device *netdev)

[ ... ]

> -static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
> -					      int pn)
> +static int geth_freeq_alloc_page(struct gemini_ethernet *geth, unsigned int pn)
>  {
>  	struct gmac_rxdesc *freeq_entry;
>  	struct gmac_queue_page *gpage;
> +	unsigned int fragments;
>  	unsigned int fpp_order;
>  	unsigned int frag_len;
> +	dma_addr_t page_mapping;
>  	dma_addr_t mapping;
>  	struct page *page;
> -	int i;
> +	int ret;
> +	int slot;
> +	unsigned int i;
>
> -	/* First allocate and DMA map a single page */
> -	page = alloc_page(GFP_ATOMIC);
> +	page = page_pool_dev_alloc_pages(geth->freeq_pool);
>  	if (!page)
> -		return NULL;
> +		return -ENOMEM;
>
> -	mapping = dma_map_single(geth->dev, page_address(page),
> -				 PAGE_SIZE, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(geth->dev, mapping)) {
> -		put_page(page);
> -		return NULL;
> +	slot = geth_freeq_alloc_slot(geth);
> +	if (slot < 0) {
> +		page_pool_put_full_page(geth->freeq_pool, page, false);
> +		return slot;
>  	}

[Severity: High]
Is it safe to call into page_pool from here?  This function is only ever
called from geth_fill_freeq(), which holds geth->freeq_lock taken with
spin_lock_irqsave(), so hardirqs are disabled for the whole call.

page_pool takes and releases BH when the caller is not in softirq context.
The fresh-mapping path does:

net/core/page_pool.c:page_pool_register_dma_index() {
	if (in_softirq())
		err = xa_alloc(&pool->dma_mapped, ...);
	else
		err = xa_alloc_bh(&pool->dma_mapped, ...);

and the put path does:

net/core/page_pool.c:page_pool_producer_lock() {
	bool in_softirq = in_softirq();

	if (in_softirq)
		spin_lock(&pool->ring.producer_lock);
	else
		spin_lock_bh(&pool->ring.producer_lock);

Two of the callers of geth_fill_freeq() are not softirq context:
gmac_open() -> geth_resize_freeq() -> geth_setup_freeq(), and the threaded
handler gemini_port_irq_thread().  In those the matching xa_unlock_bh() /
spin_unlock_bh() reaches:

kernel/softirq.c:__local_bh_enable_ip() {
	WARN_ON_ONCE(in_hardirq());
	lockdep_assert_irqs_enabled();
	...
	if (unlikely(!in_interrupt() && local_softirq_pending())) {
		... do_softirq ...

so the lockdep assert fires with IRQs disabled, and when softirqs are
pending do_softirq() can run NET_RX_SOFTIRQ on the same CPU:

gmac_napi_poll() -> gmac_rx() -> geth_freeq_claim()
	-> spin_lock_irqsave(&geth->freeq_lock)

Can that self-deadlock on freeq_lock, which geth_fill_freeq() is already
holding?  Before this patch the same region only used put_page() and
page_ref_add(), neither of which touches BH state.

Would moving the page_pool allocation and the put outside the freeq_lock
critical section, or using allow_direct/softirq-safe context, address this?

>
> -	/* The assign the page mapping (physical address) to the buffer address
> -	 * in the hardware queue. PAGE_SHIFT on ARM is 12 (1 page is 4096 bytes,
> -	 * 4k), and the default RX frag order is 11 (fragments are up 20 2048
> -	 * bytes, 2k) so fpp_order (fragments per page order) is default 1. Thus
> -	 * each page normally needs two entries in the queue.
> +	/* PAGE_SHIFT is 12 on Gemini, while the default fragment order is 11,
> +	 * so each page normally supplies two free queue entries.
>  	 */
>  	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
>  	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	fragments = 1 << fpp_order;
>  	freeq_entry = geth->freeq_ring + (pn << fpp_order);
> +	page_mapping = page_pool_get_dma_addr(page);
> +	if (page_mapping > U32_MAX - (PAGE_SIZE - 1)) {
> +		dev_err_ratelimited(geth->dev,
> +				    "freeq DMA mapping exceeds 32 bits\n");
> +		ret = -EOVERFLOW;
> +		goto err_slot;
> +	}

[ ... ]

> +err_mappings:
> +	while (i--) {
> +		mapping = page_mapping + i * frag_len;
> +		xa_erase(&geth->freeq_mappings,
> +			 geth_freeq_mapping_index(geth, mapping));
> +	}
> +	gpage->page = NULL;
> +	gpage->mapping = 0;
> +err_slot:
> +	__clear_bit(slot, geth->freeq_page_bitmap);
> +	page_pool_put_full_page(geth->freeq_pool, page, false);
> +	return ret;
>  }

> @@ -890,28 +976,9 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
>
>  	/* Loop over the freeq ring buffer entries */
>  	while (pn != epn) {
> -		struct gmac_queue_page *gpage;
> -		struct page *page;
> -
> -		gpage = &geth->freeq_pages[pn];
> -		page = gpage->page;
> +		if (geth_freeq_alloc_page(geth, pn))
> +			break;
>
> -		dev_dbg(geth->dev, "fill entry %d page ref count %d add %d refs\n",
> -			pn, page_ref_count(page), 1 << fpp_order);
> -
> -		if (page_ref_count(page) > 1) {
> -			unsigned int fl = (pn - epn) & m_pn;
> -
> -			if (fl > 64 >> fpp_order)
> -				break;
> -
> -			page = geth_freeq_alloc_map_page(geth, pn);
> -			if (!page)
> -				break;
> -		}
> -
> -		/* Add one reference per fragment in the page */
> -		page_ref_add(page, 1 << fpp_order);
>  		count += 1 << fpp_order;
>  		pn++;
>  		pn &= m_pn;

[Severity: Medium]
Should the removal of the "fl > 64 >> fpp_order" bound be mentioned in the
commit message?

The old loop reused the existing page with a cheap page_ref_add() whenever
page_ref_count(page) == 1, and when a replacement was actually needed it
stopped after roughly 32 replacements.  The initial full fill was a separate
loop in geth_setup_freeq() that ran outside any lock.

The new loop calls geth_freeq_alloc_page() for every page slot between wptr
and rptr-1 with no cap, and each iteration does a page_pool allocation plus
one xa_insert(GFP_ATOMIC) per fragment, all inside
spin_lock_irqsave(&geth->freeq_lock).  With the default freeq_order 11 and
fpp_order 1 that is up to 1024 allocations and 2048 inserts with hardirqs
off; at the advertised maximum freeq_order 15 it is up to 16384 allocations
and 32768 inserts.  The same path is the SWFQ-empty threaded handler and the
NAPI poll refill.

The commit message lists the lifecycle changes but not the removal of the
refill work bound.  Could it say something about the new per-refill cost?

>  }
>
>  static int geth_setup_freeq(struct gemini_ethernet *geth)
>  {
> +	struct page_pool_params pp_params = {
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order = 0,
> +		.nid = NUMA_NO_NODE,
> +		.dev = geth->dev,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.max_len = PAGE_SIZE,
> +	};
>  	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> -	unsigned int frag_len = 1 << geth->freeq_frag_order;
>  	unsigned int len = 1 << geth->freeq_order;
>  	unsigned int pages = len >> fpp_order;
> +	unsigned int page_slots = pages;
>  	union queue_threshold qt;
>  	union dma_skb_size skbsz;
>  	unsigned int filled;
> -	unsigned int pn;
> +	int ret = -ENOMEM;
> +
> +	if (geth->port0)
> +		page_slots += 1 << geth->port0->rxq_order;
> +	if (geth->port1)
> +		page_slots += 1 << geth->port1->rxq_order;
> +	pp_params.pool_size = pages;

[Severity: Medium]
Can num_freeq_pages go stale relative to the ports' rxq_order?

This is the only place that sizes freeq_pages, freeq_page_bitmap and
num_freeq_pages, and it reads both ports' rxq_order.  The site that mutates
those inputs is gmac_set_ringparam():

	if (rp->rx_pending) {
		port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
		err = geth_resize_freeq(port);
	}

rxq_order is written unconditionally, and geth_resize_freeq() returns early:

	new_order = min(15, ilog2(new_size - 1) + 1);
	...
	if (geth->freeq_order == new_order)
		return 0;

Because new_order saturates at 15, different rxq_order pairs can map to the
same freeq_order.  Starting from the default rxq_order 9 on both ports
(freeq_order 11), "ethtool -G eth0 rx 32768" gives rxq_order 15 and
new_order 15, so a resize runs and page_slots becomes
16384 + 32768 + 512 = 49664.  A following "ethtool -G eth1 rx 32768" also
computes new_order 15, which equals geth->freeq_order, so geth_setup_freeq()
never re-runs while eth1's rxq_order is now 15 too.  num_freeq_pages stays
49664 while the two RX rings plus the free queue can need up to
16384 + 32768 + 32768 = 81920 slots.

geth_freeq_alloc_slot() then returns -ENOSPC and geth_fill_freeq() breaks
out early, silently under-filling the free queue.  Both ring sizes are
inside the range gmac_get_ringparam() advertises.

[Severity: High]
This isn't a bug introduced by this patch, but since these port pointers are
now read here as well: geth_resize_freeq() dereferences the sibling port
before checking it for NULL.

	if (netdev->dev_id == 0)
		other_netdev = geth->port1->netdev;
	else
		other_netdev = geth->port0->netdev;

	if (other_netdev && netif_running(other_netdev))
		return -EBUSY;

gemini_ethernet_port_probe() only assigns geth->port0 / geth->port1 after
the clock and reset steps, and it registers each netdev independently.  If
one port's probe defers or fails early (devm_clk_get() returning
-EPROBE_DEFER, clk_prepare_enable() or devm_reset_control_get_exclusive()
failing), the surviving port's netdev is registered while the sibling
pointer is still NULL.  Bringing that interface up then runs gmac_open() ->
geth_resize_freeq() and dereferences NULL.  Should the NULL check come
before the dereference?

>
>  	geth->freeq_ring = dma_alloc_coherent(geth->dev,
>  		sizeof(*geth->freeq_ring) << geth->freeq_order,
> @@ -946,19 +1027,25 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	}
>
>  	/* Allocate a mapping to page look-up index */
> -	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);
> +	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, page_slots);
>  	if (!geth->freeq_pages)
>  		goto err_freeq;
> -	geth->num_freeq_pages = pages;
> -
> -	dev_info(geth->dev, "allocate %d pages for queue\n", pages);
> -	for (pn = 0; pn < pages; pn++)
> -		if (!geth_freeq_alloc_map_page(geth, pn))
> -			goto err_freeq_alloc;
> +	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
> +	if (!geth->freeq_page_bitmap)
> +		goto err_freeq_pages;
> +	geth->num_freeq_pages = page_slots;
> +	geth->freeq_page_cursor = 0;
> +
> +	geth->freeq_pool = page_pool_create(&pp_params);
> +	if (IS_ERR(geth->freeq_pool)) {
> +		ret = PTR_ERR(geth->freeq_pool);
> +		geth->freeq_pool = NULL;
> +		goto err_freeq_bitmap;
> +	}
>
>  	filled = geth_fill_freeq(geth, false);
>  	if (!filled)
> -		goto err_freeq_alloc;
> +		goto err_freeq_pool;

[ ... ]

> -err_freeq_alloc:
> -	while (pn > 0) {
> -		struct gmac_queue_page *gpage;
> -		dma_addr_t mapping;
> -
> -		--pn;
> -		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
> -		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
> -		gpage = &geth->freeq_pages[pn];
> -		put_page(gpage->page);
> -	}
> -
> +err_freeq_pool:
> +	xa_destroy(&geth->freeq_mappings);
> +	page_pool_destroy(geth->freeq_pool);
> +	geth->freeq_pool = NULL;
> +err_freeq_bitmap:
> +	bitmap_free(geth->freeq_page_bitmap);
> +	geth->freeq_page_bitmap = NULL;
> +err_freeq_pages:
>  	kfree(geth->freeq_pages);
> +	geth->freeq_pages = NULL;
> +	geth->num_freeq_pages = 0;
>  err_freeq:
>  	dma_free_coherent(geth->dev,
>  			  sizeof(*geth->freeq_ring) << geth->freeq_order,
>  			  geth->freeq_ring, geth->freeq_dma_base);
>  	geth->freeq_ring = NULL;
> -	return -ENOMEM;
> +	return ret;
>  }

[Severity: High]
After these labels run, geth->freeq_pool is NULL and num_freeq_pages is 0,
but the refill path does not check either:

geth_freeq_alloc_page() {
	page = page_pool_dev_alloc_pages(geth->freeq_pool);
	if (!page)
		return -ENOMEM;

Can this oops?  geth_resize_freeq() latches the new order and arms the
free-queue-empty interrupt regardless of what geth_setup_freeq() returned:

	geth->freeq_order = new_order;
	ret = geth_setup_freeq(geth);
	...
	en |= SWFQ_EMPTY_INT_BIT;
	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);

so after a bitmap_zalloc(), page_pool_create() or "filled == 0" failure the
threaded handler gemini_port_irq_thread() -> geth_fill_freeq(geth, true)
runs with pn != epn and calls page_pool_dev_alloc_pages(NULL).  The -ENOSPC
guard in geth_freeq_alloc_slot() cannot help because the pool allocation
happens first.

There is a second effect from the latched order: on the next attempt

	if (geth->freeq_order == new_order)
		return 0;

reports success even though nothing was set up, so gmac_open() proceeds to
napi_enable(), gmac_start_dma() and gmac_enable_irq() with no free queue and
no pool.  The order-before-success assignment predates this patch, but the
NULL pool is new.  Would checking geth->freeq_pool in geth_fill_freeq(), and
only arming SWFQ_EMPTY_INT_BIT on success, cover both?

>
>  /**
> @@ -1011,23 +1093,30 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
>  	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
>
> -	for (pn = 0; pn < pages; pn++) {
> +	pool = geth->freeq_pool;
> +	for (pn = 0; pn < geth->num_freeq_pages; pn++) {
>  		struct gmac_queue_page *gpage;
> -		dma_addr_t mapping;
> -
> -		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
> -		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
>
>  		gpage = &geth->freeq_pages[pn];
> -		while (page_ref_count(gpage->page) > 0)
> -			put_page(gpage->page);
> +		while (gpage->fragments) {
> +			page_pool_put_full_page(pool, gpage->page, false);
> +			gpage->fragments--;
> +		}
>  	}
> +	xa_destroy(&geth->freeq_mappings);
>
> +	bitmap_free(geth->freeq_page_bitmap);
> +	geth->freeq_page_bitmap = NULL;
>  	kfree(geth->freeq_pages);
> +	geth->freeq_pages = NULL;
> +	geth->num_freeq_pages = 0;
>
>  	dma_free_coherent(geth->dev,
>  			  sizeof(*geth->freeq_ring) << geth->freeq_order,
>  			  geth->freeq_ring, geth->freeq_dma_base);
> +	geth->freeq_ring = NULL;
> +	geth->freeq_pool = NULL;
> +	page_pool_destroy(pool);
>  }

[Severity: High]
This is a pre-existing teardown race, but this patch adds new objects to the
unsynchronized window, so it may be worth handling here.

None of these frees is done under geth->freeq_lock, while the readers of the
very same fields do hold it:

geth_freeq_alloc_page()	-> find_next_zero_bit(geth->freeq_page_bitmap, ...)
			-> page_pool_dev_alloc_pages(geth->freeq_pool)
geth_freeq_claim()	-> xa_load(&geth->freeq_mappings, ...)

geth_resize_freeq() only masks the interrupt source before calling in:

	en &= ~SWFQ_EMPTY_INT_BIT;
	writel(en, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
	...
	/* Drop the old queue */
	if (geth->freeq_ring)
		geth_cleanup_freeq(geth);

There is no disable_irq()/synchronize_irq(), so a gemini_port_irq_thread()
that was already woken by IRQ_WAKE_THREAD can run concurrently with, or
preempt, the resize and call geth_fill_freeq(geth, true).  Can that use the
freed freeq_page_bitmap and freeq_pages, the destroyed xarray, and the
destroyed or NULL page_pool?  page_pool_destroy() also expects no concurrent
producers.  The thread re-enables SWFQ_EMPTY_INT_BIT on exit, which undoes
the mask.

>
>  /**

[ ... ]

> @@ -1544,10 +1629,18 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  		/* append page frag to skb */
>  		if (frag_nr == MAX_SKB_FRAGS)
>  			goto err_drop;
> +		if (frag_len > PAGE_SIZE - page_offs)
> +			goto err_drop;

[Severity: Medium]
Should this be bounded by the fragment size rather than by the page?

The device is told how much it may write per free queue entry in
geth_setup_freeq():

	skbsz.bits.sw_skb_size = 1 << geth->freeq_frag_order;
	writel(skbsz.bits32, geth->base + GLOBAL_DMA_SKB_SIZE_REG);

and geth_freeq_claim() returns a fragment-aligned page_offs inside
[0, PAGE_SIZE - frag_len]:

	mapping - page_mapping <= PAGE_SIZE - frag_len &&
	!((mapping - page_mapping) & (frag_len - 1));
	...
	*page_offs = mapping - page_mapping;

So with the default freeq_frag_order 11 the first fragment of a page passes
this check with up to PAGE_SIZE - 2 bytes, that is up to 2046 bytes past the
2048-byte buffer the device was allowed to write into.  frag_len comes
straight from hardware (word0.bits.buffer_size, and on EOF descriptors it is
replaced by "frame_len - skb->len" from word1.bits.byte_count), and neither
is cross-checked against the claimed fragment size.  Multi-descriptor chains
are reachable from the wire since gmac_pick_rx_max_len() selects
CONFIG0_MAXLEN_9k for the driver's max_mtu.

> -		if (frag_len == 0 && net_ratelimit())
> -			netdev_err(netdev, "Received fragment with len = 0\n");
> +		if (!frag_len) {
> +			if (net_ratelimit())
> +				netdev_err(netdev,
> +					   "Received fragment with len = 0\n");
> +			goto err_drop;
> +		}
>
> +		page_pool_dma_sync_for_cpu(geth->freeq_pool, page, page_offs,
> +					   frag_len);
>  		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

[Severity: High]
Turning the len == 0 warning into a drop looks like it changes
behaviour for frames that are actually fine.

A few lines above, EOF descriptors get their length recomputed from
the frame length rather than from the descriptor:

	if (word3.bits32 & EOF_BIT)
		frag_len = frame_len - skb->len;

so whenever the payload has already been fully accumulated by the
preceding fragments, the closing EOF descriptor legitimately
contributes zero bytes and frag_len becomes 0. With the default
freeq_frag_order 11 the first fragment carries 2048 - NET_IP_ALIGN
bytes and the following ones 2048, so the sizes where the remainder
lands exactly on 0 are ordinary on-wire frame lengths, not a hardware
fault.

Before this patch that case only emitted the ratelimited
"Received fragment with len = 0" message and then fell through to the
EOF handling, which pushed the completed skb into napi_gro_frags().
Now it takes err_drop, which calls napi_free_frags() and throws away
the whole chain including every fragment already collected, and
returns the claimed page to the pool. The frame was complete, so this
is a silent loss of good traffic driven purely by packet size, and it
also leaves the counters inconsistent: gmac_skb_if_good_frame() has
already done

	port->stats.rx_bytes += frame_len;
	port->stats.rx_packets++;

for this frame, and err_drop then adds to rx_dropped as well.

Should the zero-length case be split by descriptor type, i.e. treat
an EOF descriptor with a zero remainder as "frame already complete"
and go straight to the napi_gro_frags() path (returning the unused
fragment to the pool), and keep the drop only for a non-EOF
descriptor that reports no data? Or is there a reason the hardware
cannot produce a zero-remainder EOF descriptor on this part, in which
case it would help to say so in the commit message, since the change
from warn-and-continue to drop is not mentioned there.

Continuing the previous question: with the page-granular bound, can this
sync-for-CPU and this skb_fill_page_desc() cover the sibling fragment, which
may still be queued in the free queue and owned by the device, possibly
being written for the other port?  That would both invalidate cache lines
for a device-owned range and hand the sibling fragment's contents to the
stack.  Would a bound like

	if (frag_len > (1 << geth->freeq_frag_order) -
		       (page_offs & ((1 << geth->freeq_frag_order) - 1)))
		goto err_drop;

match what the hardware was programmed with?

>  		skb->len += frag_len;
>  		skb->data_len += frag_len;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89%40kernel.org
