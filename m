Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6C2FA0C6
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736645; cv=none; b=DzdPfxgWwFQb7R5VYdZc3F4MSqxBrNRD58zdJu4yE2t9hRtCKFzQi5Q6k3EGBqMDLV8fucPH6E/q670YB3aNM+wBJ/L4Z2U34v33yQdWKKlnBAJOrS40ywKfhMglYMJZiYZctVnWRGVOAferlyRXTiQixVcL8gX4UALHsW2TCf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736645; c=relaxed/simple;
	bh=9qvuJyuV8MoY0XQuktyf4zVvOImtrgH3vgrio5oOzlk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhG2c6Reyr5agRsgI5fiLKpqVPT1CuqTtnxXucO8tKygFGN2h0C6A9ybZsdNcDPdKgezhwgaNmhuvH+ox+XM0lZUxk0eoWn2BkM4bf8X+AzX9IRZji0xYzsscxikD8+oACDzDm2Sv+U2fMUZbQPyDcObSSlmPs5lnNhHZOuL7WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmBawswc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmBawswc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A204A1F00893;
	Wed, 30 Sep 2026 02:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736643;
	bh=HsF4fQ8UUcB64Ech8Ix9ilEJP/f5vZ5jp/4qffmxBS8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DmBawswcCvzV03qzclUdpjMCbzzsZk46eefRxDhVYIRNIGhd/higsvgs9xoW5RwkU
	 MQK8IPCv19I0qQSfbr/n+41Jr3h3SgQhrBuszT6mJ8nXSvkwbDmVxEB+zjvCT3yfZI
	 1si3FLi855YdpGTkFi/0+IlM2283STQLrfDJ6v09rY3X4nUgzKp11EIfMhCPe5LBRH
	 68u+Qd9YuQzNiEzu/4kDuTCusO7N+aKEsf71UWYz8HMwr52pTe5wm9wiUb60G7q+XI
	 sqis7ZRLk5j3tBKd01u6u/D4UIPCF9fDIlKoKM98BE28ZsrbloXv0d3v8v6PIVBlbI
	 4exmB3OtRcHqQ==
Subject: Re: [PATCH net-next v2 05/11] net: ethernet: cortina: Preserve
 in-flight free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:42 +0000
Message-ID: <179073664220.434549.16803924890154142393@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-5-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-5-758a795d7a78@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 3 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] geth_fill_freeq() no longer recycles pages, and the commit
  message does not say so.
- [Medium] The metadata slot pool (num_freeq_pages / freeq_page_bitmap)
  is sized once in geth_setup_freeq() as pages + (1 << port0->rxq_order)…
- [Medium] In this patch, geth_freeq_claim() hands a fragment to the
  stack without dma_sync_single_range_for_cpu().
- [Low] Commit "net: ethernet: cortina: Preserve in-flight free queue
  pages" fixes an RX bug that has been in the driver since it was added,…
- [Low] When the free queue is rebuilt, geth_fill_freeq() starts at pn =
  wptr >> fpp_order, and geth_cleanup_freeq() has set wptr to the…
- [Low] geth_freeq_alloc_slot() runs find_first_zero_bit() from bit 0 on
  every page add, under the IRQ-disabled freeq_lock, and rescans the…

Pre-existing issues:
- [High] geth_fill_freeq() takes pn straight from the hardware SWFQ write
  pointer (pn = rw.bits.wptr >> fpp_order) and masks it with m_pn only…
- [High] geth_resize_freeq() dereferences the partner port
  unconditionally (other_netdev = geth->port1->netdev /…
- [Medium] gmac_stop() sets port->rx_skb = NULL without
  napi_free_frags(), so a partly assembled napi->skb and its fragment…

--

net: ethernet: cortina: Preserve in-flight free queue pages

Free queue page metadata is no longer indexed by ring position.
Metadata slots are now allocated from a bitmap, and each fragment's DMA
address stays in the XArray until its RX descriptor is claimed. Each
posted fragment owns a page reference, and refill now allocates and maps
pages outside the free queue lock and publishes them one page at a time.

> The driver currently indexes page metadata by free queue position. Step 5
> therefore overwrites page A's association with page B. When NAPI later
> processes an old descriptor containing page A's DMA address, the driver can
> no longer find the mapping. This may explain long-standing reports of the
> driver failing to find RX mappings.

[Severity: Low]
This describes an RX bug that seems to have existed since the driver was
added. Should the patch carry a Fixes: tag?

In the parent tree, geth_fill_freeq() calls geth_freeq_alloc_map_page(geth,
pn) whenever page_ref_count(page) > 1. That function erases the old page's
XArray entries and unmaps and puts gpage->page. RX descriptors pointing at
that page may still be waiting for NAPI, so the later lookup fails, the
frame is dropped and the per-fragment reference leaks.

The position-indexed metadata dates back to the original driver commit:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

The fix also depends on the earlier XArray and DMA-mapping patches in this
series. Could the commit message say so?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 3d729f4c34ef..8d216fa45287 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -733,15 +737,32 @@ geth_freeq_mapping_index(const struct gemini_ethernet *geth,
>  	return (unsigned long)(mapping >> geth->freeq_frag_order);
>  }
>  
> -static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
> -				      dma_addr_t mapping,
> -				      unsigned int *page_offs)
> +static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
> +{
> +	unsigned int slot;
> +
> +	lockdep_assert_held(&geth->freeq_lock);
> +
> +	slot = find_first_zero_bit(geth->freeq_page_bitmap,
> +				   geth->num_freeq_pages);

[Severity: Low]
Every page add scans the bitmap from bit 0 while freeq_lock is held with
interrupts disabled, so the occupied low slots are rescanned each time. Is
a first-fit scan intended here?

The next commit in the series, "net: ethernet: cortina: Rotate free queue
page allocation", appears to change this to find_next_zero_bit() starting
at freeq_page_cursor and wrapping around.

> +	if (slot == geth->num_freeq_pages)
> +		return -ENOSPC;

[ ... ]

> @@ -760,6 +781,17 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
>  	if (!valid)
>  		goto err_unlock;
>  
> +	xa_erase(&geth->freeq_mappings, index);
> +	if (!--gpage->fragments) {
> +		slot = gpage - geth->freeq_pages;
> +		dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
> +				 DMA_FROM_DEVICE);

[Severity: Medium]
geth_freeq_claim() returns the claimed fragment without calling
dma_sync_single_range_for_cpu() for it. The first fragment of a page is
therefore handed to the stack with no CPU sync at all.

When the last fragment is claimed, this dma_unmap_single() does CPU cache
maintenance over the whole PAGE_SIZE mapping. That range includes the
sibling fragment, which may already belong to an skb in the stack.

Can this corrupt or hide data in a fragment the CPU already owns?
geth_freeq_release_pages() also does a whole-page unmap with CPU sync.

This seems to be fixed later in the series by "net: ethernet: cortina:
Synchronize RX fragments for the CPU". That patch syncs each fragment
range in geth_freeq_claim() and unmaps with DMA_ATTR_SKIP_CPU_SYNC. It
also makes geth_freeq_release_pages() sync only the fragments still in
the XArray.

> +		gpage->page = NULL;
> +		gpage->mapping = 0;
> +		__clear_bit(slot, geth->freeq_page_bitmap);
> +		put_page(page);
> +	}

[ ... ]

> @@ -940,47 +971,71 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
>  	/* Mask for page */
>  	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
>  
> -	spin_lock_irqsave(&geth->freeq_lock, flags);
> -
> -	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> -	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
> -	epn = (rw.bits.rptr >> fpp_order) - 1;
> -	epn &= m_pn;
> -
>  	/* Loop over the freeq ring buffer entries */
> -	while (pn != epn) {
> -		struct gmac_queue_page *gpage;
> +	for (;;) {
> +		dma_addr_t page_mapping;
>  		struct page *page;
> +		int ret;
>  
> -		gpage = &geth->freeq_pages[pn];
> -		page = gpage->page;
> +		ret = geth_freeq_map_page(geth, &page, &page_mapping);
> +		if (ret)
> +			break;
>  
> -		dev_dbg(geth->dev, "fill entry %d page ref count %d add %d refs\n",
> -			pn, page_ref_count(page), 1 << fpp_order);
> +		spin_lock_irqsave(&geth->freeq_lock, flags);
>  
> -		if (page_ref_count(page) > 1) {
> -			unsigned int fl = (pn - epn) & m_pn;
> +		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +		pn = rw.bits.wptr >> fpp_order;
> +		epn = (rw.bits.rptr >> fpp_order) - 1;
> +		epn &= m_pn;

[Severity: High]
This isn't a bug introduced by this patch, but pn comes straight from the
hardware write pointer. It is only masked with m_pn after the first
geth_freeq_add_page() call. When the free queue shrinks, can the first
page be written past the end of geth->freeq_ring?

geth_cleanup_freeq() leaves wptr equal to the old rptr and clears the base
register, but it does not reset the pointers:

geth_cleanup_freeq()
    writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
           geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
    writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);

geth_setup_freeq() then allocates a smaller coherent ring and calls
geth_fill_freeq() before it programs the new size.

Take an old order of 11, rptr at 1000 and a new order of 8. Then pn is
500, and geth_freeq_add_page() does:

    freeq_entry = geth->freeq_ring + (pn << fpp_order);
    ...
    freeq_entry->word2.buf_adr = mapping;

This writes about 16KB into a 4KB buffer. The loop then wraps back into
range and fills exactly the expected count, so setup reports success.

One way to reach this: run traffic, bring both interfaces down, then run
ethtool -G rx 64 on eth0 (fast path) and then on eth1. The eth1 change goes
through gmac_set_ringparam()->geth_resize_freeq(). This assumes the
hardware rptr survives the BASE_SIZE write, which the new error path in
geth_setup_freeq() also relies on.

The parent code used the same unmasked index. Since this calculation is
being rewritten, should pn also be masked with m_pn, as epn is?

[Severity: Low]
What happens here if the hardware rptr is odd when the ring is rebuilt,
for example after an odd number of 2K entries were consumed?

geth_cleanup_freeq() sets wptr to rptr. With fpp_order = 1 and rptr = 37,
pn is 18 and epn is 17. The first page goes into entries 36 and 37, and
entry 36 is behind the hardware read pointer, so it is never consumed.

The final wptr is 34, so a later refill writes page 18 again and overwrites
entry 36. Fragment 0 of the original page is never claimed. Its bitmap
slot, XArray entry, page and DMA mapping stay held until the next
geth_freeq_release_pages().

The old position-indexed code reclaimed that position on refill.

> +		if (pn == epn) {
> +			ret = -ENOSPC;
> +		} else {
> +			ret = geth_freeq_add_page(geth, pn, page,
> +						  page_mapping);
> +			if (!ret) {
> +				count += 1 << fpp_order;
> +				pn++;
> +				pn &= m_pn;
> +				writew(pn << fpp_order,
> +				       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
> +			}
> +		}

[Severity: Medium]
Each loop iteration calls geth_freeq_map_page() before checking whether
the ring has room. If the ring is already full, the pn == epn branch
unmaps and frees the page that was just mapped. Does every call to
geth_fill_freeq() now allocate, map, unmap and free one extra page?

There is also a second change. The parent code reused a page in place once
its refcount dropped back to 1, calling only page_ref_add() with no
alloc_page() or dma_map_single(). Now every refilled page costs
alloc_page(GFP_ATOMIC) plus a full-page dma_map_single(), and a full unmap
and free once both fragments are claimed.

This runs at line rate from gmac_napi_poll() and gemini_port_irq_thread().

The commit message describes the change as a latency improvement and does
not mention that page recycling is gone. Was that intended? Could the ring
space be checked before a page is mapped?

[ ... ]

> @@ -988,10 +1043,16 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
>  	unsigned int len = 1 << geth->freeq_order;
>  	unsigned int pages = len >> fpp_order;
> +	unsigned int page_slots = pages;
> +	unsigned int expected;
>  	union queue_threshold qt;
>  	union dma_skb_size skbsz;
>  	unsigned int filled;
> -	unsigned int pn;
> +
> +	if (geth->port0)
> +		page_slots += 1 << geth->port0->rxq_order;
> +	if (geth->port1)
> +		page_slots += 1 << geth->port1->rxq_order;

[Severity: Medium]
The slot pool is sized from the rxq_order values at setup time. Can
gmac_set_ringparam() later increase port->rxq_order without the pool being
rebuilt?

gmac_set_ringparam() updates port->rxq_order before it calls
geth_resize_freeq(). The rebuild is then skipped in two cases. The first
is the fast path:

geth_resize_freeq()
    if (geth->freeq_ring && geth->freeq_order == new_order)
        return 0;

The second is the -EBUSY return when the other port is running, which
gmac_open() accepts:

gmac_open()
    if (err && (err != -EBUSY)) {

In both cases gmac_setup_rxq() then programs the larger RX ring.

For example, a rebuild with RX orders 9 and 7 gives a freeq order of 11
and 1664 slots. Raising the second port to order 8 keeps order 11, so the
fast path is taken. The worst-case number of outstanding pages is then
about 1023 + 511 + 255 = 1789.

Would geth_freeq_alloc_slot() then return -ENOSPC, leaving the free queue
empty under load until NAPI claims free some slots?

[Severity: High]
This is a pre-existing issue, but geth->port1 can be NULL or dangling at
this point. Is it safe to read geth->port1->rxq_order?

gemini_ethernet_port_probe() assigns geth->port1 = port before
gmac_setup_phy() and register_netdev(), and its error path does not clear
the pointer.

gemini.dtsi always defines ethernet-port@1. Several boards (dlink-dns-313,
nas4210b, nas4220b, rut1xx, wbd111, dir-685) give it no phy-mode or
phy-handle. On those boards gmac_setup_phy() returns -ENODEV, devres frees
the netdev, and geth->port1 is left pointing at freed memory.

Opening eth0 then does:

gmac_open()
  geth_resize_freeq()
    other_netdev = geth->port1->netdev;
    ...
    synchronize_irq(geth->port1->irq);
  geth_setup_freeq()
    page_slots += 1 << geth->port1->rxq_order;

If the partner port's probe fails before the assignment, the pointer is
NULL and geth_resize_freeq() dereferences it.

The dereferences in geth_resize_freeq() predate this patch. The new
page_slots calculation reads the same pointer again and can produce a
garbage shift and a wrong pool size. Should the probe error path clear
geth->port0/port1?

[ ... ]

> @@ -1576,7 +1626,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		page = geth_freeq_lookup(geth, mapping, &page_offs);
> +		page = geth_freeq_claim(geth, mapping, &page_offs);

[Severity: Medium]
This isn't a bug introduced by this patch, but what releases a partially
assembled frame if the port is stopped in the middle of one? The claimed
fragment references end up in that skb.

gmac_stop() does:

    port->rx_skb = NULL;

It does not call napi_free_frags(), so napi->skb and its fragment page
references survive into the next open.

This looks fixed later in the series by "net: ethernet: cortina: Release
partial RX frames on stop", where gmac_stop() calls napi_free_frags() when
port->rx_skb is set.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
