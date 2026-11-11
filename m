Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438649;
	b=fWGYOezU6Wlg6ydT0xaSV7wV17iGaiyHpbukmKt2nqt4mjexN5b5qpkZ/f3RHNiHb72N
	 cn8zXaJehufE6yTBHHMONMidWRAqQrREUXFGMYZQw4aKlqUdIvPIrdjnAvaBb94YpZnaF
	 sbRZ5HzLaDDR+BH8lIPJzMs8qMS3seFip2KG/uobbFDlAyjjacs7UESEyEaS3UfcNWf8l
	 eFgHnBsQNB24jNhNpRQnhrBPEfBcE9c+WWO3q1zSI9nXl0ckxKkd0mcgW/qRo3meqeixN
	 5T9NMMQYcQM0TIlzJC0zvoMPNmRXtYx1accCcwHqpbbJfafUtbi9QOwM8k9P7gRYkPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438649;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kuDBYRl3aB4xoBZOf6nDh2Ic4s2Y0+tpkrbs1hrn0CM=;
	b=vaySp2e7BBoqHT+GxEQOjQ+i6SQyUm8xvFMbjMwIVlnST1/fM5fjpIWh9uJq5V12UJLm
	 YMaicDdZGyXKBGBgdqrg1LmrJrJvv5lKg0BQdg7gQrzhyPZ5mqaosBZxG9Z0Obao67f8w
	 e2bjhGAvKvu0tlxrEtZDxOGipX5RVvseG/UB3OUo7KnslnH6fLOP3Q7mUKEDOC8q5IuXM
	 siQ3gt2XosPoXuSTpAsKB637+a89AjS3AQx5nWTiE2iWUrVrLtAS955mTfJp773qo/wm9
	 ylz89WtXm5TMU5VFXvO3lmt76CloBbb4FM7K8SpX4/NVBIsNvNOvi6WjrMvHAMldvUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gaq5L8cs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3425606A33D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gaq5L8cs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230131F00A05;
	Wed, 11 Nov 2026 23:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438649;
	bh=kuDBYRl3aB4xoBZOf6nDh2Ic4s2Y0+tpkrbs1hrn0CM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gaq5L8csogeRvsIQvbjOrN0fuGztbbiN8IvFLYO0/6S2An/OfajJb76/qSPpwVjZW
	 mfjPNzxiixtPmgKPKr4P7J8GLUn10Ogl6sqe3uPdbIxHSUyZKLq8IUtFUFGT0yacCk
	 LvzXl+PZXNWH/K7RspjdhlGb1ccLvj9PiR//vjRNUqq44kDvEq+qqSvIiduOGxGtbs
	 zXPOasGD8Oh5PCpHK7HPRi62/9B4rO/B8QoApIixARQn5Rb6gIg7WNMIIN8bRYMw2m
	 RnwyD1SBVbpx3VwvAO4eTZ20wUmPNfK8snC8l2RZJw/wB9aE7oKx3T/aUxkWCdrq2u
	 z9nTqapuRba4w==
Subject: Re: [PATCH net-next v7 05/18] net: ethernet: cortina: Correct free
 queue DMA mappings
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Wed, 11 Nov 2026 23:10:48 +0000
Message-ID: <179443864866.2199510.1669168151889532769@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-5-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-5-9c32a1a46aec@kernel.org>
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

Critical: 0 · High: 0 · Medium: 1 (5) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] geth_freeq_lookup() now holds the global geth->freeq_lock with
  spin_lock_irqsave() while it scans all num_freeq_pages entries…

Pre-existing issues:
- [Medium] After this patch, geth_freeq_alloc_map_page() still overwrites
  geth->freeq_pages[pn].page and .mapping (gpage->mapping =…
- [Medium] When a free-queue page is replaced,
  geth_freeq_alloc_map_page() overwrites the old page's PAGE_SIZE…
- [Medium] In this patch, gmac_rx() takes frag_len from the 16-bit
  hardware fields word0.bits.buffer_size and word1.bits.byte_count.
- [Medium] geth_cleanup_freeq() drains references with 'while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);'.
- [Medium] Free-queue pages use long-lived DMA_FROM_DEVICE streaming
  mappings.

--

net: ethernet: cortina: Correct free queue DMA mappings

This patch keeps the free queue page DMA base separate from the fragment
iterator, drops the replacement path's unmap of the wrong buffer, and uses
the saved base and PAGE_SIZE for setup unwind and teardown. It replaces
gmac_get_queue_page() with geth_freeq_lookup(), which derives the fragment
offset from the saved base and snapshots page, base and offset under
freeq_lock. It also rejects mappings that cannot fit in the 32-bit
hardware descriptors.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index fa51f2b54073f..71d7e61895312 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -726,32 +726,43 @@ static int gmac_setup_rxq(struct net_device *netdev)

[ ... ]

> +	spin_lock_irqsave(&geth->freeq_lock, flags);
>  	if (!geth->freeq_pages) {
>  		dev_err_ratelimited(geth->dev,
>  				    "try to get page with no page list\n");
> -		return NULL;
> +		goto unlock;
>  	}
>  
>  	/* Look up a ring buffer page from virtual mapping */
>  	for (i = 0; i < geth->num_freeq_pages; i++) {
>  		gpage = &geth->freeq_pages[i];
> -		if (gpage->mapping == mapping)
> -			return gpage;
> +		if (!gpage->page || mapping < gpage->mapping)
> +			continue;
> +
> +		page_mapping = gpage->mapping;
> +		if (mapping - page_mapping > PAGE_SIZE - frag_len ||
> +		    ((mapping - page_mapping) & (frag_len - 1)))
> +			continue;
> +
> +		page = gpage->page;
> +		*page_offs = mapping - page_mapping;
> +		break;
>  	}
>  
> -	return NULL;
> +unlock:
> +	spin_unlock_irqrestore(&geth->freeq_lock, flags);
> +	return page;
>  }

[Severity: Medium]
geth_freeq_lookup() now takes the shared geth->freeq_lock with
spin_lock_irqsave() and holds it while it scans all num_freeq_pages
entries one by one. gmac_rx() calls it once per RX descriptor. With
default sizing that is about 1024 iterations per descriptor with IRQs
off, and it contends with refill and with the other port.

Is this extra IRQ-off latency on the RX hot path acceptable for this
intermediate state?

The next patch in the series, "net: ethernet: cortina: Index free queue
fragments with XArray", replaces the scan with a single xa_load() under
the lock. The cost only exists between these two patches.

[ ... ]

> @@ -835,31 +855,25 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
>  	 */
>  	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
>  	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	gpage = &geth->freeq_pages[pn];
> +	if (gpage->page)
> +		put_page(gpage->page);

[Severity: Medium]
This isn't a bug introduced by this patch, but when a slot is replaced
here, the old page's PAGE_SIZE streaming mapping in gpage->mapping is
overwritten without being unmapped. geth_cleanup_freeq() and the
geth_setup_freeq() unwind path only unmap the slot's current
gpage->mapping.

Does the replaced DMA mapping leak? Can the page also go back to the
allocator while it is still mapped?

The old code never unmapped the old mapping either. It unmapped the first
fragment of the new buffer instead. The commit message also defers this
to later in the series.

At the end of the series this is handled: geth_freeq_recycle_page() calls
dma_unmap_single_attrs() before it drops a page that is still referenced,
geth_freeq_release_pages() unmaps every live slot, and slots are no longer
overwritten while their fragments are in flight. These changes come from
"net: ethernet: cortina: Preserve in-flight free queue pages" and
"Recycle claimed free queue pages".

> +
> +	/* Then put our new mapping into the page table */
> +	gpage->mapping = page_mapping;
> +	gpage->page = page;

[Severity: Medium]
This is a pre-existing issue, but the slot metadata is still overwritten
here when geth_fill_freeq() replaces a page whose page_ref_count() > 1.
RX descriptors can still hold fragment addresses from the replaced page,
and geth_freeq_lookup() only matches each slot's current base:

geth_fill_freeq()
  geth_freeq_alloc_map_page()
    gpage->mapping = page_mapping;  <- old base is forgotten
gmac_rx()
  geth_freeq_lookup()               <- NULL for an old-page fragment
  goto err_drop;                    <- page == NULL, no put_page()

Could this drop the frame and leak that fragment's page reference?

gmac_cleanup_rxq() would hit the same NULL return and skip put_page().

The baseline behaved the same way, and the commit message defers the
lifetime of in-flight fragments to later in the series.

At the end of the series, "net: ethernet: cortina: Preserve in-flight
free queue pages" fixes this. Metadata slots are allocated independently
of the free queue position through geth_freeq_alloc_slot(), and each
fragment address stays in geth->freeq_mappings until geth_freeq_claim()
claims it.

[ ... ]

> @@ -1023,12 +1034,10 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  
>  	for (pn = 0; pn < pages; pn++) {
>  		struct gmac_queue_page *gpage;
> -		dma_addr_t mapping;
> -
> -		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
> -		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
>  
>  		gpage = &geth->freeq_pages[pn];
> +		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
> +				 DMA_FROM_DEVICE);
>  		while (page_ref_count(gpage->page) > 0)
>  			put_page(gpage->page);

[Severity: Medium]
This isn't a bug introduced by this patch, but this while loop drops
references the driver doesn't own, including references held by skbs
that were already handed to the stack. It also re-reads the refcount
after the page may already have been freed.

Can this over-put a page, or read a freed one, at queue teardown (ndo_stop
or a ring resize)?

At the end of the series, geth_cleanup_freeq() calls
geth_freeq_release_pages() instead. That function puts exactly
gpage->fragments outstanding hardware references plus the single base
reference ("net: ethernet: cortina: Preserve in-flight free queue pages").

[ ... ]

> @@ -1523,8 +1531,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  
>  		frag_len = word0.bits.buffer_size;
>  		frame_len = word1.bits.byte_count;
> -		page_offs = mapping & ~PAGE_MASK;
> -

[Severity: Medium]
This isn't a bug introduced by this patch, but frag_len and frame_len come
straight from the 16-bit hardware fields word0.bits.buffer_size and
word1.bits.byte_count. Later, frag_len gets unchecked unsigned
adjustments (frag_len -= NET_IP_ALIGN; frag_len = frame_len - skb->len)
and is then passed to skb_fill_page_desc(). geth_freeq_lookup() only
validates the offset.

Could a malformed descriptor attach a page fragment that runs past the
free queue fragment or past the end of the page?

This is fixed later in the series by "net: ethernet: cortina: Validate RX
fragment lengths". That patch rejects frag_len < NET_IP_ALIGN, frame_len
< ETH_ZLEN or frame_len < skb->len, zero-length descriptors, and frag_len
values larger than the space left in the fragment or the page.

>  		if (word3.bits32 & SOF_BIT) {
>  			if (skb) {
>  				napi_free_frags(&port->napi);
> @@ -1543,14 +1549,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		/* Freeq pointers are one page off */
> -		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
> -		if (!gpage) {
> +		page = geth_freeq_lookup(geth, mapping, &page_offs);
> +		if (!page) {
>  			dev_err_ratelimited(geth->dev,
>  					    "could not find mapping\n");
>  			goto err_drop;
>  		}
> -		page = gpage->page;

[Severity: Medium]
This is a pre-existing issue, but the free queue pages use long-lived
DMA_FROM_DEVICE streaming mappings. gmac_rx() hands fragments written by
the device to the stack without any dma_sync_single_*_for_cpu() call.
geth_fill_freeq() also re-posts pages to the device without
dma_sync_single_for_device().

Doesn't this break the DMA API ownership rules for these buffers?

The CPU sync is a no-op on the Gemini FA526, so there should be no
visible effect on the target hardware. Other implementations could see
stale data.

At the end of the series this is handled:

  - geth_freeq_claim() calls dma_sync_single_range_for_cpu() for each
    claimed fragment.
  - geth_freeq_post_page() calls dma_sync_single_for_device() when it
    recycles a page.
  - geth_freeq_release_pages() syncs fragments still owned by the
    hardware before unmapping with DMA_ATTR_SKIP_CPU_SYNC.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec%40kernel.org
