Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F336A364
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830743; cv=none; b=KRVkytybZKlfGeFpgMczrQi2sSN25TvsUU9epcTC7YZXFm/SU9C6URsIrobXCPfy1CuAJlF7Lhm/8LbPq8CDKWQSPs9A354KDTSDHSvdyJIXrSMgdwAAn4fnHtLuYSEIu739PSCBULw5ihh+qonU5bfrWSusMrlBzIbNAaP5TSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830743; c=relaxed/simple;
	bh=0HIXKCP6NDvf3fGRudKPbFYa/QXoXZm/6JutkdIRJpk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGzQt8L6bkhEsDy5/JFuTQIqplR+Y/mLteyCchTpiv1sDZ6y/YywASSsyvRJ7JUvIJxkRwWeh0DH2cxyhTA4EV2iceSSWfjqC2wA6EtYHqyD0sP13qIaHjoJcvxElHkmigxFJQtAihx9mIgJ8UcGBkmuiMt207G3RR73H4+kNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJf+X9VS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJf+X9VS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73641F008A4;
	Mon, 12 Oct 2026 18:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830734;
	bh=WF/Q2oyoLjhel+kAPrVW2G6kt2hgAyK36Key0Pj6efM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BJf+X9VSezCMe6UKOOI/gAXZQ9hL2fqE8tKyJq1hDjiQXhqzoF+o52l9nzjUNVbYf
	 NyokLFcGKG6VTbEA2odIFKbUbWoQ+YukLzw7zVOVZLXuouiRqsLGx3SK4IXBgW5KTa
	 fX+mjP7PEkGEyPcIe3D9iwzwqhn9hu1JMQEuMpEoiWSQ8DtByF0q3FFGRdXTcKtwgv
	 WexFjbQxPn7n1K9kQtNlnD8KPDFlV+15nX091XH9RV/z111fjf+3/fHFAvbIDrP0Uj
	 OHclJqFKCl4GfpGUXFLY6lHgv8w1gyvMH3TBXGLaqH8GczRHOhT/QZRsg/tJ+X+B+6
	 y0cmp95ZO9cyA==
Subject: Re: [PATCH net-next v4 07/15] net: ethernet: cortina: Preserve
 in-flight free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:33 +0000
Message-ID: <179183073329.434549.15877043941158348068@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-7-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-7-4b1631b08f5d@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this patch, geth_setup_freeq() sizes the slot pool as (len
  >> fpp_order) + 2^port0->rxq_order + 2^port1->rxq_order.
- [Medium] This patch changes where the initial free-queue fill starts.

Pre-existing issues:
- [Medium] gmac_stop() (line 2067 at this commit) sets `port->rx_skb =
  NULL` after napi_disable() without calling napi_free_frags().

--

net: ethernet: cortina: Preserve in-flight free queue pages

This commit stops indexing gemini free queue page metadata by free queue
ring position. Metadata now lives in slots tracked by a bitmap, each
fragment DMA address stays in the XArray until it is claimed, and each
posted fragment holds its own page reference. The refill path maps pages
outside the lock and publishes one page at a time. Setup now requires a
full initial fill.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index dc82c896fa007..284823bdfd50c 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -935,48 +977,95 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
>  	/* Mask for page */
>  	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
>  
> -	spin_lock_irqsave(&geth->freeq_lock, flags);
> -
> -	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> -	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
> -	pn &= m_pn;
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
> -
> -		dev_dbg(geth->dev, "fill entry %d page ref count %d add %d refs\n",
> -			pn, page_ref_count(page), 1 << fpp_order);
> +		spin_lock_irqsave(&geth->freeq_lock, flags);
> +		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
> +		pn = (rw.bits.wptr >> fpp_order) & m_pn;
> +		epn = (rw.bits.rptr >> fpp_order) - 1;
> +		epn &= m_pn;
> +		spin_unlock_irqrestore(&geth->freeq_lock, flags);
> +		if (pn == epn)
> +			break;

[Severity: Medium]
Before this patch, the initial fill from geth_setup_freeq() started at the
hardware read pointer:

    pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;

Now geth_fill_freeq() always starts at wptr and stops one page before
rptr. What happens if the hardware read pointer is not reset by the
writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG) in geth_setup_freeq()?

gemini.h documents the field as read-only:

    unsigned int rptr	: 16;	/* Read Ptr, RO */

The earlier commit "net: ethernet: cortina: Normalize free queue pointers
on rebuild" also allows for hardware that keeps its read pointer while the
queue is disabled. geth_cleanup_freeq() only copies rptr into wptr and
clears GLOBAL_SW_FREEQ_BASE_SIZE_REG.

Suppose rptr keeps a nonzero value R across a rebuild. This loop would
then post only ((R >> fpp_order) - 1) pages starting at entry 0, and
geth_setup_freeq() would fail here:

    expected = len - (1 << fpp_order);
    filled = geth_fill_freeq(geth);
    if (filled != expected)
        goto err_freeq_bitmap;

Would every ethtool -G resize, or every reopen that rebuilds the queue
after traffic, then fail with -ENOMEM? The old queue has already been torn
down by that point. The old code handled a retained rptr because it filled
relative to rptr.

This seems to still be present at the end of the series.
geth_fill_freeq() still derives pn from wptr, and gmac_open() propagates
the error, so the interface would not come up.

[ ... ]

> @@ -984,12 +1073,16 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
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
>  
>  	geth->freeq_ring = dma_alloc_coherent(geth->dev,
>  		sizeof(*geth->freeq_ring) << geth->freeq_order,

[ ... ]

> @@ -1162,6 +1231,9 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	new_order = min(15, ilog2(new_size - 1) + 1);
>  	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
>  		new_size, new_order);
> +	if (new_order <= PAGE_SHIFT - geth->freeq_frag_order)
> +		return -EINVAL;
> +
>  	if (geth->freeq_ring && geth->freeq_order == new_order)
>  		return 0;

[Severity: Medium]
geth_setup_freeq() now sizes the slot pool using both rxq_order values.
This shortcut, however, only compares freeq_order. Can the pool end up
too small if an rxq_order grows while freeq_order stays the same?

Take rxq orders 9 and 8: new_size is 1536, new_order is 11 and
page_slots is 1024 + 512 + 256 = 1792. If ethtool -G moves port1 to
order 9, new_size becomes 2048, which is still order 11. This path then
returns 0, and the pool stays at 1792 slots while worst-case demand is
about 2048.

There is a related path in gmac_set_ringparam(). It updates
port->rxq_order before calling geth_resize_freeq(), and keeps the new
order even when the resize returns -EBUSY because the other port is
running:

    port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
    err = geth_resize_freeq(port);

When the slots run out, geth_fill_freeq() maps a page and gets -ENOSPC
from geth_freeq_add_page(). It then unmaps and frees the page and stops
refilling. Could this leave the shared free queue underfilled and starve
RX under load?

This looks to be resolved later in the series by "net: ethernet: cortina:
Rebuild free queue metadata for RX ring changes". That commit makes
geth_resize_freeq() compare num_freeq_pages against
geth_freeq_page_slots(), makes gmac_set_ringparam() restore old_rxq_order
on failure, and makes gmac_open() propagate resize errors.

[ ... ]

> @@ -1590,7 +1662,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		page = geth_freeq_lookup(geth, mapping, &page_offs);
> +		page = geth_freeq_claim(geth, mapping, &page_offs);
>  		if (!page) {
>  			dev_err_ratelimited(geth->dev,
>  					    "could not find mapping\n");

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. Still,
what happens to fragments already claimed here for a partly assembled
frame when the port is stopped? gmac_stop() drops the pointer without
freeing the skb:

    napi_disable(&port->napi);
    port->rx_skb = NULL;
    port->rx_frag_nr = 0;

napi->skb still holds references to the claimed fragment pages. On the
next open, napi_get_frags() returns that same skb. gmac_rx() then
overwrites frag 0 through skb_fill_page_desc(), and the old len, data_len
and truesize carry over into the new frame.

Does this leak the fragment pages each time the port is stopped mid-frame?

This is fixed later in the series by "net: ethernet: cortina: Release
partial RX frames on stop", which makes gmac_stop() call
napi_free_frags(&port->napi) when port->rx_skb is set.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
