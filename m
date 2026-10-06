Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A44A2623
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307151; cv=none; b=VKQvxjFPB1xIutGqM4IqHsnNFK4nLTT7JkFfSIdwjBuZpTyiHXDWlKNDGoIaFdtwOk4lLjAqUQJi6gsLNnI6DpUOZGmUe/yf/0DbKFcVxHsc3urUH6m6sZ0+7J1T7C6sBvhjftnU37BOvHYnhEujS4b15jsfgyKqJIvtBWew5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307151; c=relaxed/simple;
	bh=9N6lPNkUe4mj4o+KiY+gIzlfaS/s+ZSAJ8gUX1hpH4Q=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ooaE8bxtXLNU17Ih3Uer0cJI5Yn803ZACMyxPGMtca/0yu8awKg9yIDjqz6u+WuadHM70h4e7eKdmeZEIJuk1u19Fe4/2G79z1hWLB0uFXNX3A3hX15I67z+zmIrUGZabfTWMtDDtyTe8NmsBWv7C8Mmg6V+ECRxFz0V2QXPMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGQqK5OV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGQqK5OV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B291F0089E;
	Tue,  6 Oct 2026 17:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307148;
	bh=I7WD/00xDmJOr90BcEs5n85C2f47rtsNI2gdtBdtXAo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aGQqK5OV3/BfLjWG7iEciakDmFTqZyUj1LGtJP3mf7uYubad/CUrHxvY372TwsiZJ
	 igfHh9Jz8Wj/5AuVSySFQqI6l0BrwuheblZxvVju4y670kCZA0FDf9w9j3KYF2gaCY
	 C4lmgH+27zZ28n51W1RdZVxkpwji28Nof+8/G8KuiGicui69PNo8OGqLhLQTgsknEK
	 CEMwwe24fw1jdhYkUGtVO0U6BHhSNh+vi6qk76larvM6Cb9nFSYZbfgQveDzNqMYYN
	 eSINw31jVqMG2T6ogcpig3+vch6+ycHcy6++0cON9Gddsc0mmedPVDt6+XIMvuimk3
	 AZA3O4Inz3tiQ==
Subject: Re: [PATCH net-next v3 05/12] net: ethernet: cortina: Index free
 queue fragments with XArray
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:07 +0000
Message-ID: <179130714711.434549.17858355489179341111@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-5-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-5-3e1f25890ae8@kernel.org>
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

Critical: 0 · High: 0 (2) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message frames this patch as an efficiency change
  but tags it as a bug fix.
- [Low] In `geth_setup_freeq()`, the comment above the `freeq_pages`
  allocation still reads `/* Allocate a mapping to page look-up index…

Pre-existing issues:
- [High] `geth_fill_freeq()` replaces a free queue page whose
  `page_ref_count() > 1` by calling `geth_freeq_alloc_map_page()`.
- [High] `geth_cleanup_freeq()` runs `while (page_ref_count(gpage->page)
  > 0) put_page(gpage->page);`.
- [Medium] Free queue pages are mapped once with
  `dma_map_single(DMA_FROM_DEVICE)` and then reused.

--

net: ethernet: cortina: Index free queue fragments with XArray

geth_freeq_lookup() used to scan every free queue page linearly. This
commit replaces that scan with an XArray keyed by each fragment's DMA
address in fragment units. Entries are inserted and erased in
geth_freeq_alloc_map_page(), which now asserts that freeq_lock is held,
and geth_setup_freeq() now takes the lock around page allocation.

> This isn't very efficient...
>
> Instead index each fragment in an XArray using its DMA address in
> fragment units.

[ ... ]

> Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

[Severity: Medium]
Is this meant to be a bug fix? The only reason given is efficiency, but
the Fixes: tag marks the patch for stable backport.

Before this patch, the linear scan in geth_freeq_lookup() returned the
same page and offset as the XArray lookup in every case, and failed in
the same cases. The only thing that changes is the lookup cost. No
user-visible failure or latency numbers are mentioned.

Documentation/process/maintainer-netdev.rst asks every bug fix to say
how the issue was found and validated, and how the fix was tested. For
hardware drivers it also asks for the hardware it was tested on.

The later patch "net: ethernet: cortina: Preserve in-flight free queue
pages" relies on this XArray to keep exact fragment DMA addresses until
they are claimed. If the Fixes: tag is there to mark this as a stable
prerequisite, could the commit message say so? Otherwise, should the tag
be dropped and the patch sent to net-next as an optimisation?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 809274aff8e56..ee604bc04fc37 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -724,43 +726,47 @@ static int gmac_setup_rxq(struct net_device *netdev)

[ ... ]

> +	index = geth_freeq_mapping_index(geth, mapping);
>
> -unlock:
> +	spin_lock_irqsave(&geth->freeq_lock, flags);
> +	gpage = xa_load(&geth->freeq_mappings, index);
> +	if (!gpage || !gpage->page)
> +		goto err_unlock;
> +
> +	page = gpage->page;
> +	page_mapping = gpage->mapping;
> +	valid = mapping >= page_mapping &&
> +		mapping - page_mapping <= PAGE_SIZE - frag_len &&
> +		!((mapping - page_mapping) & (frag_len - 1));
> +	if (!valid)
> +		goto err_unlock;
> +
> +	*page_offs = mapping - page_mapping;
>  	spin_unlock_irqrestore(&geth->freeq_lock, flags);
>  	return page;

[Severity: Medium]
This is a pre-existing issue, but is a CPU-direction DMA sync missing
before the fragment goes back to the stack?

The free queue pages are mapped once in geth_freeq_alloc_map_page() with
dma_map_single(..., DMA_FROM_DEVICE) and then reused. geth_fill_freeq()
reposts a page whose refcount is 1 with only:

	page_ref_add(page, 1 << fpp_order);

There is no dma_sync_single_for_device() call. After this lookup
succeeds, gmac_rx() passes the fragment to skb_fill_page_desc() without
calling dma_sync_single_range_for_cpu().

On a non-coherent system, could the CPU read stale cache lines instead
of the new DMA data?

A later commit message in the series says the CPU sync is currently a
no-op on Gemini's FA526, so the impact on the target SoC may be limited.

This is addressed later in the series. "net: ethernet: cortina: Preserve
in-flight free queue pages" adds dma_sync_single_range_for_cpu() to
geth_freeq_claim(). "net: ethernet: cortina: Recycle claimed free queue
pages" adds dma_sync_single_for_device() on recycle in
geth_freeq_post_page().

[ ... ]

> @@ -853,9 +863,26 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
>  	 */
>  	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
>  	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	fragments = 1 << fpp_order;
> +
>  	gpage = &geth->freeq_pages[pn];
> -	if (gpage->page)
> +	for (i = 0; i < fragments; i++) {
> +		mapping = page_mapping + i * frag_len;
> +		ret = xa_insert(&geth->freeq_mappings,
> +				geth_freeq_mapping_index(geth, mapping),
> +				gpage, GFP_ATOMIC);
> +		if (ret)
> +			goto err_mappings;
> +	}
> +
> +	if (gpage->page) {
> +		for (i = 0; i < fragments; i++) {
> +			mapping = gpage->mapping + i * frag_len;
> +			xa_erase(&geth->freeq_mappings,
> +				 geth_freeq_mapping_index(geth, mapping));
> +		}
>  		put_page(gpage->page);
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but what happens to fragments
of the old page that are still waiting in an RX queue?

geth_fill_freeq() replaces the page when its refcount is above 1:

	if (page_ref_count(page) > 1) {
		...
		page = geth_freeq_alloc_map_page(geth, pn);

A refcount above 1 can mean that some of the old page's fragments are
still unprocessed in either port's RX queue. This block erases all of
the old page's XArray entries and drops the base reference. For those
descriptors, geth_freeq_lookup() then returns NULL.

gmac_rx() logs "could not find mapping" and jumps to err_drop with page
still NULL. gmac_cleanup_rxq() logs "could not find page" and skips
put_page().

Does this leak the per-fragment reference added by page_ref_add(), and
with it the old page?

The old linear scan failed the same way, because gpage->page had already
been overwritten. This seems to be fixed later in the series by "net:
ethernet: cortina: Preserve in-flight free queue pages". There,
geth_freeq_claim() erases only the claimed fragment's index, and a page
is reposted only when gpage->fragments is zero and its refcount is 1.

[ ... ]

> @@ -965,9 +1005,13 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
>  	geth->num_freeq_pages = pages;
>
>  	dev_info(geth->dev, "allocate %d pages for queue\n", pages);

[Severity: Low]
This isn't a bug, but the comment just above this hunk in
geth_setup_freeq() still reads:

	/* Allocate a mapping to page look-up index */
	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);

After this patch the lookup goes through
xa_load(&geth->freeq_mappings, index), and freeq_pages is only the
metadata table that the XArray entries point into. Could the comment be
updated?

> -	for (pn = 0; pn < pages; pn++)
> -		if (!geth_freeq_alloc_map_page(geth, pn))
> +	for (pn = 0; pn < pages; pn++) {
> +		spin_lock_irqsave(&geth->freeq_lock, flags);
> +		page = geth_freeq_alloc_map_page(geth, pn);
> +		spin_unlock_irqrestore(&geth->freeq_lock, flags);
> +		if (!page)
>  			goto err_freeq_alloc;
> +	}

[ ... ]

> @@ -1035,6 +1080,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  		while (page_ref_count(gpage->page) > 0)
>  			put_page(gpage->page);
>  	}
> +	xa_destroy(&geth->freeq_mappings);

[Severity: High]
This is a pre-existing issue, but can this loop free pages that SKBs
still reference?

gmac_rx() gives fragment references to the stack through
skb_fill_page_desc(). Those SKBs can still be queued in the stack when
the free queue is torn down, for example on a resize that calls
geth_cleanup_freeq() before geth_setup_freeq().

Dropping the refcount all the way to zero would free pages the stack is
still using. The loop also reads page_ref_count() again after the final
put_page().

This changes later in the series with "net: ethernet: cortina: Preserve
in-flight free queue pages". There, geth_freeq_release_pages() drops only
the gpage->fragments references owned by the hardware plus the single
base reference.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
