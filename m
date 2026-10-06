Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE5249C4CD
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791307150; cv=none; b=Pv9Q/TA1ioAfoSFg944v5MdVS4xqKcKn1gcJwTeHmaw1WUAgFjAHS7x+CtSyVyb8m7qAXdv8Mjn2VUWriS2Ak1faZ5dq7XFNpRInX4Cudf7lx5lfzhJQc+LAJTDG10HrY1YgCiS4WeWueRq4AO3xctEuOTDdmcTfsWnBrDHCi+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791307150; c=relaxed/simple;
	bh=xjB47aqGVA58vSups5Kc/1HoPh1jWqS19H4+NO3B9BY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ow+p5GesB8sZ92v27mZDCf7719w6ygmfCBzOT5mf/R+e6mHSySNmLGmNh2zH+snmGZmsOTGtUksmqL6e4+tQefBsZXDWpXEmET9JJwSGmt4or2STn8Hf68JKHfo2HLDIqJDOjGiRa2Pp7BqTWR3NN96+BE1NFua8wN7YkMnM0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEDNB5J6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEDNB5J6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652C21F0089B;
	Tue,  6 Oct 2026 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791307146;
	bh=HbRF31ah0o2Zjw4LL8Wf/vjjdoH81JabfQU9wNTBa70=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BEDNB5J6ttG/qZjvW8sYR668px6spaCYWBPCQ8akWqWdC1jbN+3bOjBQm0EiLRf90
	 hnADdUxQONJaxGrQgqIPs1XsTcnBjgamTgFXVVKLdeCKwNEXwXYzGHqzOUKlzi3ma+
	 Jmdwgu9XiEdzUNeCYuF6tKzXE4acyckzneT+Q5IxKFP09btjZ46cmoYdC4sNuYOep5
	 FWEiauYjNVhyMgAGf4lvdbowekwWz/Uoq6Yg7UH61RtD8i/Wv4MauKKWj52PUtbeIh
	 WGJ0ZPBtTt2iNJYuwxljqWjleeCDMnY2q4DyM/1hsZxZNZS49rd7V57oxwjUA5eMdV
	 WGX0pYaJZZ/FQ==
Subject: Re: [PATCH net-next v3 04/12] net: ethernet: cortina: Correct free
 queue DMA mappings
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Tue, 06 Oct 2026 17:19:05 +0000
Message-ID: <179130714596.434549.14839505903872006863@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-4-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-4-3e1f25890ae8@kernel.org>
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

Critical: 0 · High: 0 (2) · Medium: 3 (2) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In geth_freeq_alloc_map_page()
  (drivers/net/ethernet/cortina/gemini.c:856-862), replacing a page…
- [Medium] geth_freeq_alloc_map_page() maps PAGE_SIZE (line 833).
- [Medium] geth_freeq_lookup() takes freeq_lock with spin_lock_irqsave()
  (line 738) and then linearly scans all num_freeq_pages entries (line…

Pre-existing issues:
- [High] geth_cleanup_freeq() (lines 1034-1036) runs 'while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);'.
- [High] gmac_rx() takes frag_len from the 16-bit hardware buffer_size
  (line 1523).
- [Medium] This problem wasn't introduced by this patch, but
  gmac_napi_poll() (line 1629-1635) wraps the whole gmac_rx() call in…
- [Medium] Freeq pages are mapped DMA_FROM_DEVICE once.

--

net: ethernet: cortina: Correct free queue DMA mappings

This commit keeps the free queue page DMA base separate from the fragment
iterator, drops the incorrect unmap on page replacement, and unwinds setup
mappings with PAGE_SIZE. It also replaces gmac_get_queue_page() with
geth_freeq_lookup(), which works out the fragment offset from the saved DMA
base under freeq_lock and rejects mappings that don't fit in 32 bits.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index a2daf22e76989..809274aff8e56 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
> @@ -724,32 +724,43 @@ static int gmac_setup_rxq(struct net_device *netdev)

[ ... ]

> +static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
> +				      dma_addr_t mapping,
> +				      unsigned int *page_offs)
>  {
> +	unsigned int frag_len = 1 << geth->freeq_frag_order;
>  	struct gmac_queue_page *gpage;
> -	dma_addr_t mapping;
> +	unsigned long flags;
> +	dma_addr_t page_mapping;
> +	struct page *page = NULL;
>  	int i;
>  
> -	/* Only look for even pages */
> -	mapping = addr & PAGE_MASK;
> -
> +	spin_lock_irqsave(&geth->freeq_lock, flags);

[Severity: Medium]
This isn't a bug introduced by this patch, but on 32-bit PREEMPT_RT
kernels gmac_napi_poll() wraps the whole gmac_rx() call in the
rx_stats_syncp writer section:

gmac_napi_poll()
    u64_stats_update_begin(&port->rx_stats_syncp);
    received = gmac_rx(napi->dev, budget, &freeq_consumed, &reschedule);
    ...
    u64_stats_update_end(&port->rx_stats_syncp);

On 32-bit, u64_stats_update_begin() disables preemption, and on
PREEMPT_RT a spinlock_t can sleep.

Can the freeq_lock taken here for each descriptor trigger a "sleeping
function called from invalid context" splat with
CONFIG_DEBUG_ATOMIC_SLEEP?

The baseline gmac_rx() already took irq_lock and called napi_gro_frags()
inside the same section. The pattern is still there at the end of the
series, where geth_freeq_claim() runs inside it.

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

[Severity: Medium]
gmac_rx() calls geth_freeq_lookup() once per RX descriptor in NAPI
context. Doesn't this put a linear scan over all num_freeq_pages entries,
with interrupts disabled, on the RX hot path?

The next patch in the series, "Index free queue fragments with XArray",
replaces this scan with an xa_load() in geth_freeq_claim().

[ ... ]

> @@ -833,31 +853,25 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
>  	 */
>  	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
>  	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
> +	gpage = &geth->freeq_pages[pn];
> +	if (gpage->page)
> +		put_page(gpage->page);
> +
> +	/* Then put our new mapping into the page table */
> +	gpage->mapping = page_mapping;
> +	gpage->page = page;

[Severity: Medium]
With the replacement unmap gone, what releases the old page's PAGE_SIZE
streaming mapping here?

geth_fill_freeq() takes this path whenever page_ref_count(page) > 1:

		if (page_ref_count(page) > 1) {
			...
			page = geth_freeq_alloc_map_page(geth, pn);

The old gpage->mapping is overwritten right after the put_page(), and
geth_cleanup_freeq() only unmaps the address currently posted in the ring.

At this commit, does every replacement leak one DMA mapping when an IOMMU,
swiotlb or dma-debug is in use?

The commit message says these mappings are released later in the series.
After "Preserve in-flight free queue pages" and "Recycle claimed free queue
pages", geth_freeq_release_pages() unmaps every live slot with PAGE_SIZE.
The old code also left the old mapping live.

>  
>  	freeq_entry = geth->freeq_ring + (pn << fpp_order);

[ ... ]

> @@ -1019,7 +1031,6 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  
>  		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
>  		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);

[Severity: Medium]
geth_freeq_alloc_map_page() maps PAGE_SIZE, and this patch changes the
geth_setup_freeq() error path to unmap with gpage->mapping and PAGE_SIZE.

Should geth_cleanup_freeq() do the same, rather than using frag_len and
the address read back from the descriptor? As it stands, the two release
sites for the same mapping disagree, and dma-debug would warn about a
size mismatch on ifdown or remove.

At the end of the series, geth_cleanup_freeq() goes through
geth_freeq_release_pages(), which calls
dma_unmap_single_attrs(geth->dev, gpage->mapping, PAGE_SIZE,
DMA_FROM_DEVICE, DMA_ATTR_SKIP_CPU_SYNC).

> -
>  		gpage = &geth->freeq_pages[pn];
>  		while (page_ref_count(gpage->page) > 0)
>  			put_page(gpage->page);

[Severity: High]
This isn't a bug introduced by this patch, but can this loop drop
references held by skbs that gmac_rx() already passed to the stack through
napi_gro_frags()?

It keeps calling put_page() until the refcount reaches zero. That can free
pages the stack is still using, and page_ref_count() is read again after
the final put_page().

Later in the series, geth_freeq_release_pages() drops only the
gpage->fragments references plus one base reference, and leaves
skb-owned references alone.

[ ... ]

> @@ -1532,14 +1540,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
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

[Severity: High]
This isn't a bug introduced by this patch, but the length passed to
skb_fill_page_desc() further down in gmac_rx() comes straight from the
hardware descriptor:

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

Can frag_len underflow here? That would happen if buffer_size is smaller
than NET_IP_ALIGN, or if frame_len is smaller than skb->len.

Nothing checks the result against the 2 KiB fragment size or against
PAGE_SIZE - page_offs. Could a malformed descriptor expose adjacent memory
to the stack?

The "Validate RX fragment lengths" patch later in the series adds these
checks.

[Severity: Medium]
This is a pre-existing issue, but the freeq pages are mapped
DMA_FROM_DEVICE once, and gemini.c has no dma_sync_* calls at this commit.

geth_fill_freeq() reposts reused pages with only page_ref_add(). gmac_rx()
then hands fragments written by the hardware to skb_fill_page_desc()
without syncing them for the CPU.

Could this give the stack stale cache contents on non-coherent DMA setups?

Later in the series, geth_freeq_claim() calls
dma_sync_single_range_for_cpu() for each claimed fragment.
geth_freeq_post_page() syncs for the device when recycling, and
geth_freeq_release_pages() syncs fragments still owned by the hardware
before unmapping. A later commit also notes that the CPU sync is a no-op
on Gemini's FA526.

>  
>  		if (word3.bits32 & SOF_BIT) {
>  			skb = gmac_skb_if_good_frame(port, word0, frame_len);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8%40kernel.org
