Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438651;
	b=uysHCwCXdS3hjpca1SxRi3YiMGqRLBGWzZzAopKpvNcVslkRgoWzAk4Ndx5okzZeaw4K
	 HHb9fwkFVFEDqCxISu5/Uld+WV5IWRfg+YI9AN+9GfhznzaC9JZl3kadb27+GcgrxGlDj
	 8q1/6ferTeMZCcjR3NqY0SIBCqDDK5HjVUQ7IYfY8FlNnzoqpy62zSkeZpwoKzdbUl0Ln
	 XYDer4tFNHgoh5Kcv2ZVd1qiN1ZnNU+DuZFBjf8TSDiZ8BFXk5MnZAZ8dzksVds7jlTvU
	 fS4ByRitsUYMLOUHuUx077B9makcRt2xLlPO693X5Ak/Hky8pdK+s6qFnsU+Ir5GgVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438651;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tedSJNMhboDpX5BhYovW6i9/A5e4PA5SgBHzsdfRiww=;
	b=zILfIitgWQ2hB22wnFi0smWOLT3nn+WQL/srsnzSWgAC8KUZmIQyHyYL0qbHLLL58cXN
	 xxQxH6hQRm9i5fvOelRRxRHH6SOmiXf1xQ5aEQUdyytX0KQS4UIjfc4ieUcUuE3uOvDhF
	 Y0hDkxIT7tTG48fVFQAFoWYXpEVRVnl7lzDY3zCDa2co76M6+Rq84b2uUWQZsf0/REIrn
	 WTEf6gXf97qOwkuctpfuT/fqS+qHk1sVuuRZOfpLdc7UwJDjPlJ8ruU3dRdU38Unj6u9v
	 mqF2J5QbRfCgd0rqCYDCf+bh7jSblg+hM3T6NjHl01q0UfBsy1g4A0euLPzloWVJxtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z4aVq/qx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48532606A886
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z4aVq/qx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7071F00A0B;
	Wed, 11 Nov 2026 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438650;
	bh=tedSJNMhboDpX5BhYovW6i9/A5e4PA5SgBHzsdfRiww=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z4aVq/qxF386zqiW8JBdPF42kBwGCk8lBstihXlOTTBEATtEXxcaIH5X3XSpyTAEM
	 eZG0Z/lWY0RAbsH7I79dWfG3VLQWqcUxOx2JYbRHATessbb56dzbq73Pq7+ALuhmax
	 CLeVVqiIGDiZotsRHTuQ/YhGqfJZ+GDA282WNysAcVqqYD5368uG0yvWeK2OJF8X6N
	 TPwZTqoGEqq/8iXLlssLHuPKssJhl8rYnNCwRDupoNUytmKlHk+U0VdzkDy3F7KUAZ
	 zyT6b5EjZW9SykPcgCDFkMnicr52uy7404ZgwnmmA45kG4mKHvMDXjpsL3Bc+xHbnH
	 fB+eeT/0xCtWQ==
Subject: Re: [PATCH net-next v7 07/18] net: ethernet: cortina: Preserve
 in-flight free queue pages
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 23:10:49 +0000
Message-ID: <179443864989.2199510.5071007686286136865@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-7-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-7-9c32a1a46aec@kernel.org>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The page metadata pool is now a fixed set of slots tracked by
  freeq_page_bitmap, and nothing reclaims a slot while the queue is…

--

net: ethernet: cortina: Preserve in-flight free queue pages

This patch stops tying Gemini free queue page metadata to free queue
ring positions. Metadata slots come from a fixed pool tracked by a
bitmap, each posted fragment holds its own page reference, and a slot
is released only once all of its fragments have been claimed from RX
descriptors.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index add1d3e563b62..bdbbc6d7844b9 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -735,15 +740,32 @@ geth_freeq_mapping_index(const struct gemini_ethernet *geth,
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
> +	if (slot == geth->num_freeq_pages)
> +		return -ENOSPC;
> +
> +	__set_bit(slot, geth->freeq_page_bitmap);
> +
> +	return slot;
> +}
> +
> +static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
> +				     dma_addr_t mapping,
> +				     unsigned int *page_offs)
>  {

[ ... ]

> @@ -762,6 +784,21 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
>  	if (!valid)
>  		goto err_unlock;
>  
> +	dma_sync_single_range_for_cpu(geth->dev, page_mapping,
> +				      mapping - page_mapping, frag_len,
> +				      DMA_FROM_DEVICE);
> +	xa_erase(&geth->freeq_mappings, index);
> +	if (!--gpage->fragments) {
> +		slot = gpage - geth->freeq_pages;
> +		dma_unmap_single_attrs(geth->dev, page_mapping, PAGE_SIZE,
> +				       DMA_FROM_DEVICE,
> +				       DMA_ATTR_SKIP_CPU_SYNC);
> +		gpage->page = NULL;
> +		gpage->mapping = 0;
> +		__clear_bit(slot, geth->freeq_page_bitmap);
> +		put_page(page);
> +	}

[Severity: Medium]
Can the fixed slot pool run out while the queue is running?

At runtime, geth_freeq_claim() is the only place that clears a bit in
freeq_page_bitmap and drops the page reference and DMA mapping for that
slot. The only other place is teardown in geth_freeq_release_pages().
So every fragment of a posted page has to come back from hardware as an
RX descriptor address that resolves.

gmac_rx() has two paths that drop a descriptor without claiming it:

	if (!mapping) {
		if (net_ratelimit())
			netdev_err(netdev,
				   "rxq[%u]: HW BUG: zero DMA desc\n",
				   r);
		goto err_drop;
	}

	page = geth_freeq_claim(geth, mapping, &page_offs);
	if (!page) {
		dev_err_ratelimited(geth->dev,
				    "could not find mapping\n");
		goto err_drop;
	}

The "could not find page" path in gmac_cleanup_rxq() behaves the same
way. Buffers that RX DMA has already pulled for a frame when
gmac_stop()->gmac_stop_dma() stops it mid-frame are also never claimed,
because gmac_cleanup_rxq() only walks the descriptors between r and w.

If the hardware has consumed a free queue fragment in any of these
cases, its slot stays set in freeq_page_bitmap permanently. The page
reference and streaming DMA mapping stay pinned with it.

geth_freeq_page_slots() sizes the pool at roughly the worst-case number
of live pages, with little slack:

	unsigned int slots = 1 << (order - fpp_order);

	if (geth->port0 && geth->port0->netdev)
		slots += 1 << geth->port0->rxq_order;
	if (geth->port1 && geth->port1->netdev)
		slots += 1 << geth->port1->rxq_order;

An ifdown/ifup cycle does not recover leaked slots either. If the peer
port is running, the existing queue is kept. If both ports are idle and
the geometry has not changed, geth_resize_freeq() returns early:

	if (geth->freeq_order == new_order &&
	    geth->num_freeq_pages == page_slots)
		return 0;

Once enough slots have leaked, geth_freeq_alloc_slot() returns -ENOSPC
on every call. geth_fill_freeq() then maps a candidate page, unmaps and
frees it, and breaks without posting anything.

Would the shared SWFQ then drain and stop RX on both GMAC ports? It
looks like the only recovery is an ethtool geometry change with both
ports down, or a driver unbind.

Before this patch, metadata was indexed by queue position. A lost
fragment leaked page memory, but a later refill reused that position,
so refill never stalled.

The follow-up "Recycle claimed free queue pages" patch only recycles
slots whose fragments have all been claimed. The zero-descriptor and
lookup-failure paths still claim nothing, so this looks like it remains
at the end of the series.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec%40kernel.org
