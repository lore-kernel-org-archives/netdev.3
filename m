Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E137B02D
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830735; cv=none; b=usjkcQqcKYKopHrFa58niW+lVMTlrFay8hGGR2NYNsuIECBXKZ7Gh/gZ3nEqfLMLLK5K5pYMq6EsX2LmeE13rBe7/yX1WBbbJQSeR6yHiJ06K2Giia9D4H/K8kVM7ei8ZnsPhOv/+EXIOk9L/pfSEhHj2DwPKE7zhBRegwxiQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830735; c=relaxed/simple;
	bh=905wv1QT/4sSuSNrpG7X21wdeOiRiLbAZBDCExcOBJw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlipXN1s3tG09U6rFNugh3NnxR71b3/pDZ5WTRgUgQrJIRx98ZWqszQP+1AhCZ7dXeCWczUSVC/t72ttcpd+kFix3qxs6Zpo6rJZriVCOXq+a/lpkCFaF8j4mZ2bpsI6YTa7hanwvpk/DMUZfX3PkALjc0fnb9vb5ZMWBIXYAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyYWFkmS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyYWFkmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276F81F008A3;
	Mon, 12 Oct 2026 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830730;
	bh=cKD+Wpz3HibdnGPmaZ8FlDUBTsVm3K2pzqlHw8Uw0po=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DyYWFkmS6/CofSfWr58ZNXrpCvpd6aJU8e4Q34NBWuG7t2LDXRquWS4iLqNw/sViM
	 eMHKvt71QrNMa5pCf8ys6vgw02zNyW80RDmCRi3KacJlkZBETdTIya+icVP6Z9BRxZ
	 98voWUUTKmVJcQAXQ/+nOlmInayoHslAEZDJiri0bDGP/590nTrQ1R+iwr7gbiJyqb
	 b7/jyks30RbrHQHS6/iLWE+hHURn/bKvDY+VjgY1tZJv1A/OAokv1u8O6fYPXCauoF
	 96FZP4XAtbbCdd92Gy7mteZ1g+oPlcVD1uct0RGK5fjNwB6sDdmxUKJKPT5CuBfjZi
	 oS2yIWdHc8WAA==
Subject: Re: [PATCH net-next v4 03/15] net: ethernet: cortina: Drain free
 queue IRQ before resize
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:29 +0000
Message-ID: <179183072968.434549.12571065301446454008@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-3-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-3-4b1631b08f5d@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (2) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] If a single port device is removed and re-created while the
  parent stays bound, the shared software free queue is left…

Pre-existing issues:
- [High] At this commit, geth_cleanup_freeq() only copies rptr into wptr,
  and geth_fill_freeq(geth, false) starts at `pn = rw.bits.rptr >>…
- [High] At this commit, geth_cleanup_freeq() runs `while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);` for every…
- [Medium] At this commit, geth_freeq_alloc_map_page() maps each free
  queue page with dma_map_single(..., PAGE_SIZE, DMA_FROM_DEVICE), but…

--

net: ethernet: cortina: Drain free queue IRQ before resize

This patch disables the port 1 Linux IRQ for the whole of
geth_resize_freeq(). That drains any threaded handler that is already
running before the software free queue is torn down. SWFQ_EMPTY_INT_BIT
is now re-enabled only when setup succeeds. The patch also makes the
port 0 handler ignore the shared source, clears freed queue state, and
removes the forced freeq_order = 1 from gemini_ethernet_init().

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index ec2e476883376..c03541deed495 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -986,6 +986,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	}
>  
>  	kfree(geth->freeq_pages);
> +	geth->freeq_pages = NULL;
> +	geth->num_freeq_pages = 0;
>  err_freeq:

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Does
the err_freeq_alloc unwind just above unmap with the wrong size?

geth_freeq_alloc_map_page() maps the whole page:

	mapping = dma_map_single(geth->dev, page_address(page),
				 PAGE_SIZE, DMA_FROM_DEVICE);

But this unwind in geth_setup_freeq() and the loop in
geth_cleanup_freeq() both unmap with frag_len, which is usually 2048:

	dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);

CONFIG_DMA_API_DEBUG would report this as a size mismatch. Swiotlb or
IOMMU backends could also leave part of the mapping in place or skip
cache maintenance.

Two later patches in this series, "net: ethernet: cortina: Correct free
queue DMA mappings" and "net: ethernet: cortina: Preserve in-flight free
queue pages", appear to switch all of these unmaps to PAGE_SIZE.

[ ... ]

> @@ -1026,20 +1028,37 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  	}
>  
>  	kfree(geth->freeq_pages);
> +	geth->freeq_pages = NULL;
> +	geth->num_freeq_pages = 0;

[Severity: High]
This isn't a bug introduced by this patch. Still, can the loop that
ends here in geth_cleanup_freeq() free pages that delivered skbs still
reference?

	gpage = &geth->freeq_pages[pn];
	while (page_ref_count(gpage->page) > 0)
		put_page(gpage->page);

gmac_rx() attaches free queue pages to skbs and passes them up the
stack. A packet can still be unread in a socket queue when both ports
are brought down and geth_resize_freeq() rebuilds the queue, on open or
ethtool -G.

Dropping every reference here would then free a page that the skb
still points to. That is a use-after-free, and the contents of the
reallocated page could be exposed.

The later patch "net: ethernet: cortina: Preserve in-flight free queue
pages" in this series seems to fix this. It drops only the unclaimed
gpage->fragments references plus the driver's own reference.

[ ... ]

> @@ -1084,16 +1101,11 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	new_order = min(15, ilog2(new_size - 1) + 1);
>  	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
>  		new_size, new_order);
> -	if (geth->freeq_order == new_order)
> +	if (geth->freeq_ring && geth->freeq_order == new_order)
>  		return 0;

[Severity: Medium]
Could this early return leave the hardware free queue unprogrammed?
The case is a port that is removed and re-added while the parent device
stays bound.

gemini_port_clear() sets geth->initialized = false, but it keeps
geth->freeq_ring, geth->freeq_pages and geth->freeq_order. When the port
is published again, gemini_port_publish()->gemini_ethernet_init() clears
the queue registers and interrupt enables:

	writel(0, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
	...
	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
	...
	writel(0, geth->base + GLOBAL_SWFQ_RWPTR_REG);

Before this patch, gemini_ethernet_init() also set geth->freeq_order = 1,
which forced the next geth_resize_freeq() to rebuild the queue. That
line is now gone and freeq_ring is still non-NULL. So if the RX ring
orders have not changed, the next open returns 0 here. It never calls
geth_setup_freeq() or geth_set_freeq_irq(geth, true).

gmac_open() would succeed, but GLOBAL_SW_FREEQ_BASE_SIZE_REG stays 0 and
SWFQ_EMPTY_INT_BIT stays masked, so the interface would not receive.

One way to reach this is a CONFIG_OF_DYNAMIC change that removes and
re-creates a single ethernet-port child. of_platform_notify() handles
that change, and suppress_bind_attrs does not block it.

The rest of the series keeps the same pattern. At the end, the fast
path still checks only geth->freeq_ring, num_freeq_pages and the order.
gemini_ethernet_init() still clears the queue registers without
invalidating freeq_ring.

Should gemini_ethernet_init() or gemini_port_clear() mark the queue as
needing a rebuild?

[ ... ]

> @@ -1103,14 +1115,10 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
>  	geth->freeq_order = new_order;
>  	ret = geth_setup_freeq(geth);

[Severity: High]
This is a pre-existing issue. What happens to the hardware rptr when the
queue is rebuilt here at a smaller order?

geth_cleanup_freeq() only copies rptr into wptr:

	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);

geth_setup_freeq()->geth_fill_freeq(geth, false) then starts from that
stale rptr without masking it with m_pn:

	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
	...
	gpage = &geth->freeq_pages[pn];

Suppose the RX rings were shrunk, by ethtool -G or by a later open with
smaller rings. Could pn then point past the end of the new
freeq_pages[] array, so that page_ref_count() and page_ref_add() run on
a garbage struct page pointer?

The hardware documentation does not say whether it wraps an rptr that
is out of range for a newly programmed ring.

The later patch "net: ethernet: cortina: Normalize free queue pointers
on rebuild" in this series fixes this. It resets GLOBAL_SWFQ_RWPTR_REG
to 0 in geth_setup_freeq(), and geth_fill_freeq() masks both pn and epn
with m_pn.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
