Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFF136998C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736644; cv=none; b=UH/JIBM9MH0tETkRLTkG3p5j6BQf/mVO1a9/nVKK6nazcO6Gv5qffd+jWuygR62pWJpiX1wgvhoqDlM9h49RhkF9WFM5W373/VHWCZ2fAutPrp3lc1qdoDzvb/2GQ1u6JFUidm5skGsnsxIH3GhTlU6R8cafZ0JaJDMPTO6BVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736644; c=relaxed/simple;
	bh=QwrUpERo0wgo3VjRQqq6FEfMqGIOp9KG1jdTvLv48Os=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IwGG9juhub34z88qbO9d2XRikDFZv6C34tzWI6AE8Qm+QSnaF/YtdSCy2EAOE8eJszgotmmw3hTTPRSbDeeFrDniXmU3YQ414qINpqXCbmwmlejnIOQcjEVXUrKoJsC9+kyjG4PndCVqY2CbSG8EZrocU9tULEARPvAxXNHoe+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8vcQH1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8vcQH1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8764E1F000FF;
	Wed, 30 Sep 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736642;
	bh=nTtXW7RdlsoBJhQyKbY3SizC7tj6i/LLat6F3ohmnqY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F8vcQH1g2aP4MivzrsYK8DomGI1FkFVqPxd1k9OudjF82l4ev1b96bTttMBGwtou8
	 kjMsFuRFb5GqetXNkgK+QS4xXW6TVCvn3MuELqCSESa7aD3k8mZAPwZumslK86i4t9
	 t36fADc4b5zW72ji/dgi9S0YK6eo6y3vStFPhftZCsMVTAehRzkRLjkBxx898zwu6P
	 yaWuDBCrcI9qc4RWlbM87BVCBGPRK68EDpCMkopuWcQVhnaoSGMnhm7mA1fvyJVcCp
	 XVyvzv94Zjw2t5pcGnRs9XufBeBu8AmVEBhxLgMd1H/sIVn1xxAXBc1eR3YAMGKaH1
	 6+9C7eBjxNPhQ==
Subject: Re: [PATCH net-next v2 04/11] net: ethernet: cortina: Index free
 queue fragments with XArray
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:41 +0000
Message-ID: <179073664112.434549.7343550699505950642@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-4-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-4-758a795d7a78@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] At this commit, geth_fill_freeq() calls
  geth_freeq_alloc_map_page() for any consumed free-queue slot whose…
- [Medium] The new freeq_mappings XArray is created with a plain
  xa_init(), so xa_insert()/xa_erase() take xa_lock with plain…

Pre-existing issues:
- [High] Free-queue pages are mapped once with dma_map_single(...,
  DMA_FROM_DEVICE) in geth_freeq_alloc_map_page().
- [Medium] gmac_rx() uses hardware-reported lengths without bounds
  checks.

--

net: ethernet: cortina: Index free queue fragments with XArray

This commit replaces the linear scan in gmac_get_queue_page() with an
XArray indexed by DMA address in fragment units. The new
geth_freeq_lookup() validates the exact fragment address under
freeq_lock. When a page is replaced, geth_freeq_alloc_map_page() inserts
the fragment indices of the new page and erases those of the old one.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index fa5513b53ea8f..3d729f4c34ef1 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -724,32 +726,46 @@ static int gmac_setup_rxq(struct net_device *netdev)

[ ... ]

> +static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
> +				      dma_addr_t mapping,
> +				      unsigned int *page_offs)
>  {

[ ... ]

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
> +	spin_unlock_irqrestore(&geth->freeq_lock, flags);
> +	return page;

[Severity: High]
This isn't a bug introduced by this patch, but is a DMA sync missing
here?

geth_freeq_alloc_map_page() maps the free queue pages once with
dma_map_single(..., DMA_FROM_DEVICE). There are no dma_sync_* calls
anywhere in gemini.c.

geth_freeq_lookup() returns the fragment to gmac_rx() without calling
dma_sync_single_range_for_cpu(). gmac_rx() then passes it to GRO via
skb_fill_page_desc().

When page_ref_count(page) == 1, geth_fill_freeq() also gives a
still-mapped page back to the hardware without a
dma_sync_single_range_for_device():

	/* Add one reference per fragment in the page */
	page_ref_add(page, 1 << fpp_order);

On the non-coherent Gemini (FA526), could the CPU read stale cache lines
from an earlier frame after the device has DMAed a new frame into a
recycled page?

This seems to be fixed later in the series. "net: ethernet: cortina:
Synchronize RX fragments for the CPU" adds
dma_sync_single_range_for_cpu() in geth_freeq_claim(), and the in-flight
page rework stops recycling mapped pages.

[ ... ]

> @@ -842,8 +861,27 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
>  	 */
>  	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
>  	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> -	/* If the freeq entry already has a page mapped, then unmap it. */
> +	fragments = 1 << fpp_order;
> +
>  	gpage = &geth->freeq_pages[pn];
> +	for (i = 0; i < fragments; i++) {
> +		mapping = page_mapping + i * frag_len;
> +		ret = xa_insert(&geth->freeq_mappings,
> +				geth_freeq_mapping_index(geth, mapping),
> +				gpage, GFP_ATOMIC);

[Severity: Medium]
Will lockdep report inconsistent xa_lock usage here?

gemini_ethernet_probe() sets up freeq_mappings with a plain xa_init().
That means xa_insert() and xa_erase() take xa_lock with a plain
spin_lock().

geth_setup_freeq() calls this helper without holding freeq_lock. It runs
in process context with softirqs enabled:

	for (pn = 0; pn < pages; pn++)
		if (!geth_freeq_alloc_map_page(geth, pn))
			goto err_freeq_alloc;

The same lock is also taken from NAPI softirq context each time a page
with refcount > 1 is replaced:

gmac_napi_poll()
  geth_fill_freeq(geth, true)
    geth_freeq_alloc_map_page()
      xa_insert() / xa_erase()

Lockdep would record SOFTIRQ-ON-W and then IN-SOFTIRQ-W for the same
lock. Under CONFIG_PROVE_LOCKING that produces an inconsistent lock state
report, and lockdep then disables itself.

A real same-CPU deadlock does not look reachable.
geth_resize_freeq() returns -EBUSY if the other netdev is running, and
the opening port's NAPI is not enabled yet during setup.

"net: ethernet: cortina: Preserve in-flight free queue pages" later in
the series moves every xa_insert() and xa_erase() under freeq_lock with
irqsave. That seems to resolve this.

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
> +	}

[Severity: High]
Can this erase lookup entries that RX descriptors still refer to?

geth_fill_freeq() calls geth_freeq_alloc_map_page() for any consumed slot
whose page still holds extra references:

		if (page_ref_count(page) > 1) {
			...
			page = geth_freeq_alloc_map_page(geth, pn);

A refcount above 1 also covers pages whose fragments the hardware has
already placed in a port RX queue that gmac_rx() has not processed yet.
For example, gmac_rx() may have run out of budget, or the descriptor may
be in the other port's RX ring.

This loop then removes every fragment index of the old gpage->mapping.
The old page is unmapped and only its base reference is dropped:

		/* This should be the last reference to the page so it gets
		 * released
		 */
		put_page(gpage->page);

Later, when gmac_rx() reaches one of those pending descriptors, xa_load()
in geth_freeq_lookup() returns NULL and gmac_rx() takes this path:

		page = geth_freeq_lookup(geth, mapping, &page_offs);
		if (!page) {
			dev_err_ratelimited(geth->dev,
					    "could not find mapping\n");
			goto err_drop;
		}

Here page == NULL, so the "if (page) put_page(page)" under err_drop is
skipped. Does that drop a valid frame and leak the fragment reference
that page_ref_add() took? The old page is no longer in freeq_pages, so
geth_cleanup_freeq() cannot reclaim it either.

gmac_cleanup_rxq() has the same leak on its "could not find page"
continue path.

The old linear scan failed the same way, but the commit message says:

    Serialize metadata replacement with RX lookup so the caller obtains
    the page belonging to the descriptor even when the queue is being
    refilled.

The freeq_lock in geth_freeq_lookup() only makes each individual lookup
atomic. It does not help a descriptor whose page was replaced by a refill
that has already finished. Is that sentence accurate?

This looks fixed later in the series by "net: ethernet: cortina: Preserve
in-flight free queue pages". That patch erases each XArray entry only
when its fragment is claimed, keeps a per-page fragment count, and does
not reuse slots while fragments are still outstanding.

[ ... ]

> @@ -1526,14 +1576,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		gpage = gmac_get_queue_page(geth, mapping);
> -		if (!gpage) {
> +		page = geth_freeq_lookup(geth, mapping, &page_offs);
> +		if (!page) {
>  			dev_err_ratelimited(geth->dev,
>  					    "could not find mapping\n");
>  			goto err_drop;
>  		}
> -		page = gpage->page;
> -		page_offs = mapping - gpage->mapping;
>  
>  		if (word3.bits32 & SOF_BIT) {
>  			skb = gmac_skb_if_good_frame(port, word0, frame_len);

[Severity: Medium]
This is a pre-existing issue, but geth_freeq_lookup() only checks the
start of the fragment (page_offs). It does not check the extent that
gmac_rx() attaches next. Can the lengths reported by the hardware
underflow or overrun the fragment?

		if (word3.bits32 & SOF_BIT) {
			...
			page_offs += NET_IP_ALIGN;
			frag_len -= NET_IP_ALIGN;
			...
		if (word3.bits32 & EOF_BIT)
			frag_len = frame_len - skb->len;
		...
		if (frag_len == 0 && net_ratelimit())
			netdev_err(netdev, "Received fragment with len = 0\n");

		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

frag_len wraps if word0.bits.buffer_size < NET_IP_ALIGN, or if
byte_count < skb->len. Nothing compares frag_len with the 2 KiB fragment
boundary or with PAGE_SIZE - page_offs. A zero length fragment is logged
but still appended.

It isn't clear whether the hardware can actually report such values.
If it does, could a malformed descriptor attach a fragment that runs
into the sibling fragment (possibly still owned by the device) or past
the end of the page?

This looks addressed later in the series by "net: ethernet: cortina:
Validate RX fragment lengths".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
