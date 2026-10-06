Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDB49DBB6
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307153; cv=none; b=X9LaI7dMXcLW1sZ/A8EyHoqdb0rbdFuTshTzSFtTM04kY80mOqxZz3YzPFr7eVCowaa52KT882zuLCOkhXR5oaCkDTWMq3kXbyXD1eKzpxwdC6bzOKl/3TTaTwzKe4EDpFOqP3KQPTTam6pAXXNC6dAq+SST/42SWRkrGbpiK4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307153; c=relaxed/simple;
	bh=WXz+D3ciSYk8gAfXXih1JEcyajOhApwWoMoHO/hPtxM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NocTn20TRQ3TLZR5AZQnIRsAZ8W6twcXRGuL6mrsiDLyYOLZ1A06ntPaB+FMwZ0L9d8WLQNygxA0fKRuGDulu1QEyNVqifsc3Fo7UidB1WBKry0/UHbuZ23gbTDkBvu+R41+yDQlvRAwsoq1p7jurcWkXUDnDZ7Oz2xYLQObJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYqsLRsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYqsLRsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CBC1F0089F;
	Tue,  6 Oct 2026 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307149;
	bh=nPg8a0DTcCnv9VN41eB2UOMGTyvdF+8Gxmh5zCnN6LA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cYqsLRsDtfUM9HImcM+NAWGXvX4b74nN+F8Zo6E+UWXP9/bIBMQXIA/8cwd/+U7S/
	 kyjRyteLeDehmsVrFYhyNFD/kO601YHcdQnB3xfxUuzGappHrggXn2vimpICRLRGfr
	 lHbPkj34/tu4TmrFnfZULLpQr4AmkWiZvA09+yCVecE1uO+J7Q/DkI0ekLsh3+5pwW
	 RhjKh4TY+8T0bmdb0/EXR+qHSMBhDz9uzUeA++Bb9N7uSMaDe4P2+kZ23C2XCX8uec
	 s6OJr+Uml6h1nTaejNtHMOjmTz9sQiUZ0lh/7obk/VqwBqOAFVk8tmJUDr3AAyjzXZ
	 ymZTYGu1tgGZg==
Subject: Re: [PATCH net-next v3 06/12] net: ethernet: cortina: Preserve
 in-flight free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:08 +0000
Message-ID: <179130714819.434549.13922507452263293264@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-6-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-6-3e1f25890ae8@kernel.org>
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

Critical: 0 · High: 0 (1) · Medium: 1 (2) · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, page_slots in geth_setup_freeq() depends on
  port0/port1 rxq_order.
- [Low] Two problems with the commit message of this patch.
- [Low] geth_setup_freeq() now accepts a free queue with zero usable
  entries.

Pre-existing issues:
- [High] Out-of-bounds write into DMA ring memory when the free queue
  shrinks.
- [Medium] gmac_stop() clears port->rx_skb, rx_frag_nr and rx_dropping
  without calling napi_free_frags().
- [Medium] At this commit, gmac_rx() passes lengths taken from the
  hardware descriptor to skb_fill_page_desc() without bounding them to…

--

net: ethernet: cortina: Preserve in-flight free queue pages

This patch stops tying free queue page metadata to free queue ring
positions. Metadata slots now come from a bitmap, so a refill no longer
overwrites pages that unprocessed RX descriptors still point to. Each
posted fragment gets its own page reference and per-fragment DMA sync,
pages are allocated and mapped outside the free queue lock, and the
initial fill must populate every usable entry.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index ee604bc04fc37..660e51634017b 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -760,6 +781,21 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
>  	if (!valid)
>  		goto err_unlock;
>  
> +	dma_sync_single_range_for_cpu(geth->dev, page_mapping,
> +				      mapping - page_mapping, frag_len,
> +				      DMA_FROM_DEVICE);

[Severity: Medium]

This isn't a bug introduced by this patch. Now that only the claimed
fragment is synced for the CPU, can gmac_rx() still produce a fragment
length that goes past it?

gmac_rx() takes the lengths directly from the hardware descriptor:

	if (word3.bits32 & SOF_BIT) {
		...
		page_offs += NET_IP_ALIGN;
		frag_len -= NET_IP_ALIGN;
		...
	}

	if (word3.bits32 & EOF_BIT)
		frag_len = frame_len - skb->len;
	...
	skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

frag_len wraps around if buffer_size is less than NET_IP_ALIGN, or if
frame_len is less than skb->len.

Could an oversized frag then cover the sibling fragment, which is not
synced or is still owned by the device, or run past the end of the page?

A later commit in this series, "net: ethernet: cortina: Validate RX
fragment lengths", looks like it handles this by dropping such
descriptors.

> +	xa_erase(&geth->freeq_mappings, index);

[ ... ]

> @@ -933,47 +975,95 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)

[ ... ]

> -		if (page_ref_count(page) > 1) {
> -			unsigned int fl = (pn - epn) & m_pn;
> +		ret = geth_freeq_map_page(geth, &page, &page_mapping);
> +		if (ret)
> +			break;
>  
> -			if (fl > 64 >> fpp_order)
> -				break;
> +		spin_lock_irqsave(&geth->freeq_lock, flags);
>  
> -			page = geth_freeq_alloc_map_page(geth, pn);
> -			if (!page)
> -				break;

[Severity: Low]

The commit message says:

  Allocate and DMA-map candidate pages before taking the free queue lock.
  Re-read the hardware pointers under the lock and publish one complete page
  at a time, so refilling no longer performs a potentially multi-megabyte
  allocation batch with interrupts disabled.

Does this describe the old refill accurately?

The removed code re-posted any page whose page_ref_count() had dropped
back to 1, without allocating. It called geth_freeq_alloc_map_page() only
while the fill level was at or below 64 >> fpp_order (32 pages, about
128 KiB).

The old geth_setup_freeq() also took and dropped the lock once per page.
The setup-time geth_fill_freeq(geth, false) did not allocate anything.

The commit message also does not say that page recycling and the fill
cap are removed here. With this patch, every refill iteration calls
geth_freeq_map_page(), which means alloc_page(GFP_ATOMIC) plus
dma_map_single(). geth_freeq_claim() unmaps and puts the page once its
last fragment is claimed, and the loop keeps going until the ring is
full.

Could the commit message mention this change in behaviour?

A later commit in this series, "net: ethernet: cortina: Recycle claimed
free queue pages", brings back recycling and notes that the regression
came from this patch. The uncapped refill and this description of the
old code are still there at the end of the series.

> +		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +		pn = rw.bits.wptr >> fpp_order;
> +		epn = (rw.bits.rptr >> fpp_order) - 1;
> +		epn &= m_pn;
> +		if (pn == epn) {
> +			ret = -ENOSPC;
> +		} else {
> +			ret = geth_freeq_add_page(geth, pn, page,
> +						  page_mapping);

[Severity: High]

This is a pre-existing issue, not one introduced by this patch. Can pn
point outside the ring here right after the free queue has been shrunk?

pn comes from the hardware wptr and is never masked with m_pn. Only epn
is masked. geth_cleanup_freeq() leaves wptr at the old ring's rptr:

	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);

geth_freeq_add_page() then writes the descriptor at:

	freeq_entry = geth->freeq_ring + (pn << fpp_order);

For example, with both ports down at the default rxq_order 9, the free
queue has order 11 (2048 entries). Suppose traffic has left rptr at
1500. "ethtool -G eth0 rx 128" keeps order 11. "ethtool -G eth1 rx 128"
then picks order 9, which is 512 entries in an 8 KiB ring:

  gmac_set_ringparam()
    geth_resize_freeq()
      geth_cleanup_freeq()      /* wptr = rptr = 1500 */
      geth_setup_freeq()
        geth_fill_freeq()       /* pn = 750, epn = 749 & 255 = 237 */
          geth_freeq_add_page(geth, 750, ...)

Would this write buf_adr into entries 1500 and 1501, about 16 KiB past
the end of the dma_alloc_coherent() buffer?

This assumes that writing GLOBAL_SW_FREEQ_BASE_SIZE_REG does not reset
wptr.

pn then wraps to 239, and the fill still returns count == expected
(510), so setup reports success. Page position 238 (entries 476 and
477) is never written, so the device and the driver no longer agree on
the ring contents.

The old code had the same unmasked pn and indexed freeq_pages[pn] the
same way. At the end of the series, geth_fill_freeq() still passes the
unmasked pn to both geth_freeq_recycle_page() and geth_freeq_add_page().
At that point the shrink can also happen when a failed growth setup is
followed by a request for a smaller ring.

Would masking pn with m_pn, or resetting the hardware pointers before
filling a new ring, avoid this?

[ ... ]

> @@ -981,12 +1071,16 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
>  	unsigned int len = 1 << geth->freeq_order;
>  	unsigned int pages = len >> fpp_order;
> +	unsigned int page_slots = pages;
> +	unsigned int expected;
>  	union queue_threshold qt;
>  	union dma_skb_size skbsz;
> -	unsigned long flags;
> -	struct page *page;
>  	unsigned int filled;
> -	unsigned int pn;
> +
> +	if (geth->port0)
> +		page_slots += 1 << geth->port0->rxq_order;
> +	if (geth->port1)
> +		page_slots += 1 << geth->port1->rxq_order;

[Severity: Medium]

page_slots is now fixed by both ports' rxq_order at setup time. Can a
port later run a bigger RX ring than this slot pool was sized for?

geth_resize_freeq() still skips the rebuild whenever freeq_order is
unchanged:

	if (geth->freeq_ring && geth->freeq_order == new_order)
		return 0;

It also returns -EBUSY when the other port is running, and gmac_open()
accepts that:

	if (err && (err != -EBUSY)) {

gmac_set_ringparam() keeps the new rxq_order whatever the resize
returns:

	port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
	err = geth_resize_freeq(port);

For example, with port0 at order 8 and port1 at order 9, "ethtool -G
eth0 rx 512" keeps freeq_order 11. The pool stays at 1792 slots, but
2048 can be in flight.

geth_freeq_alloc_slot() would then return -ENOSPC, and refill would
stall until NAPI frees slots.

A later commit in this series, "net: ethernet: cortina: Rebuild free
queue metadata for RX ring changes", looks like it fixes this. It adds
geth_freeq_page_slots() and makes the fast path also require
num_freeq_pages >= page_slots. It returns -EBUSY only when the existing
queue is too small, makes gmac_open() propagate every resize error, and
restores the old rxq_order in gmac_set_ringparam() on failure.

[ ... ]

> @@ -999,23 +1093,18 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)

[ ... ]

> -	filled = geth_fill_freeq(geth, false);
> -	if (!filled)
> -		goto err_freeq_alloc;
> +	expected = len - (1 << fpp_order);
> +	filled = geth_fill_freeq(geth);
> +	if (filled != expected)
> +		goto err_freeq_bitmap;

[Severity: Low]

Does this check now accept a free queue with no usable entries?

Take a board where the other port has no netdev (the PHY-less probe
path). "ethtool -G ethX rx 1" sets rxq_order = min(15, ilog2(0) + 1),
which is 0. geth_resize_freeq() then computes new_size = 2 and
freeq_order = 1. That gives len = 2, and with two fragments per page,
expected = 0.

With m_pn = 0, geth_fill_freeq() sees pn == epn on its first check and
returns 0. filled == expected, so setup succeeds with no RX buffers
posted, and later refills cannot post any either.

The old "if (!filled)" check rejected this case with -ENOMEM.

[ ... ]

> @@ -1586,7 +1656,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		page = geth_freeq_lookup(geth, mapping, &page_offs);
> +		page = geth_freeq_claim(geth, mapping, &page_offs);
>  		if (!page) {

[Severity: Medium]

This is a pre-existing issue, but what happens to the fragments claimed
here if the interface is stopped partway through a frame?

gmac_stop() clears the partial frame state without freeing the skb:

	napi_disable(&port->napi);
	port->rx_skb = NULL;
	port->rx_frag_nr = 0;
	port->rx_dropping = false;

The partly built napi->skb still holds its claimed fragment page
references. On the next open, napi_get_frags() returns that stale skb
and gmac_rx() fills it again starting at frag 0.

Does this leak the page references held by the old frags?

A later commit in this series, "net: ethernet: cortina: Release partial
RX frames on stop", adds a napi_free_frags() call in gmac_stop() before
the state is cleared.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
