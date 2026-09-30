Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8136D9F5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790736643; cv=none; b=G3OxlZY3PWcZ2UuNFxaL0lVUizXwcAr10JX7EGxzcQSzNzRXgDd+zMQi9eLoONDMtTSR3Em5sCV5QlEOqTrDZxP/I6JblfPXMPg6i0vnNKmIRvTt3eLSBwWsOr5Tz/SX0x+vw0rdekTe3WceEV8AKGlv5yEyL0IkEvAqFQkjTPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790736643; c=relaxed/simple;
	bh=CLUpO3zfOE9iO+s1J1p2nOBuBlGEb5QTrdApXydjsNg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfocbT8vWEbR0/hh0Ef+7W1ZgGgfaaU6dG3sX4GxiTORLiPpvsHuEZDkoHKO7bQn6wgFtrTCOhMsSeaSu8ZnhTiiKx+Bl8hsliMnZDtBNf3AseVs4WhNxLjeap8H4OQHo36u4PGLAruVLWWupk94dixmRlAqr/sTO03rOPRW9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c33ysWWK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c33ysWWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 659E51F00898;
	Wed, 30 Sep 2026 02:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790736641;
	bh=XoTsSbFNE3SxPNC6WlsUcS83neNlZGZOj4/751yqA8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c33ysWWKRGL8pYVbJsV2+l3Ixf4KxHpsOMsmrHGG/Fg/AO+IE0ejg2ZUnBrJfyCm8
	 55o0m5YaUJQFyW1+c7uaqScmOZr2jil7AW5T+miyfr1XzKNX9WUb4jNGj1IbOzfMv2
	 WPVMwTQ/aszs1unLlBoktlrBeBEZJ9Bbh3uvxktFp4LYPzk6v9KagQb8ETUJLsqUdA
	 6FuX2hW7+i6Q9eh2k2ZxF0dbCEFnTiGRONEpbSt39uyV0lBj/AwNOzrkr1s1qALEWk
	 mdNwbi6Hn0rgwDcO+ZYcBsP0pvsGzOLr/kLh2JA/ujFGPtLhZ+L0LcbHIwv+gBTBGq
	 n9Ct1VnY/5WrQ==
Subject: Re: [PATCH net-next v2 03/11] net: ethernet: cortina: Correct free
 queue DMA mappings
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mirq-linux@rere.qmqm.pl, mhun512@gmail.com, netdev@vger.kernel.org
Date: Wed, 30 Sep 2026 02:50:39 +0000
Message-ID: <179073663994.434549.9254382030787870764@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-3-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-3-758a795d7a78@kernel.org>
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

Critical: 0 · High: 0 (3) · Medium: 2 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the replacement path in
  geth_freeq_alloc_map_page() calls a full…
- [Medium] At this commit, gmac_rx() and gmac_cleanup_rxq() read
  gpage->page and gpage->mapping without holding geth->freeq_lock.
- [Low] This patch fixes a user-visible bug that dates back to the
  driver's introduction, but its commit message has no Fixes: tag and…

Pre-existing issues:
- [High] At this commit, geth_fill_freeq() calls
  geth_freeq_alloc_map_page(geth, pn) whenever page_ref_count(page) > 1.
- [High] At this commit, free-queue pages are mapped DMA_FROM_DEVICE once
  and never synced.
- [High] At this commit, geth_cleanup_freeq() runs 'while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);'.
- [Medium] At this commit, gmac_rx() uses lengths from the hardware
  descriptor without bounds checks.

--

net: ethernet: cortina: Correct free queue DMA mappings

geth_freeq_alloc_map_page() now keeps the page DMA base separate from the
fragment iterator. When replacing a page, it unmaps the old page through
gpage->mapping using PAGE_SIZE, and it rejects mappings that don't fit the
32-bit descriptors. gmac_get_queue_page() now matches addresses by their
offset from the saved base, and the "one page off" lookup adjustment in
gmac_rx() and gmac_cleanup_rxq() is removed.

> Replacement also reads the old address after overwriting the descriptor
> with the new mapping.

[Severity: Low]
This patch looks like it fixes a user-visible bug that dates back to the
original driver, but there is no Fixes: tag. Should it carry:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Before this patch, the first population stored gpage->mapping as base +
PAGE_SIZE. The "Freeq pointers are one page off" lookup in gmac_rx() and
gmac_cleanup_rxq() compensated for that.

On replacement, the old code re-read the descriptor after it already held
the new base. It then unmapped the new buffer with frag_len even though
that buffer was handed to hardware. The old mapping was never unmapped,
and gpage->mapping was stored as the new base without the extra PAGE_SIZE.

After any replacement, gmac_rx() would either fail the lookup ("could not
find mapping", frame dropped, page reference never put) or match a
neighbouring slot and attach the fragment to the wrong struct page.

Could the commit message describe these effects as well as the mechanics?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index e5531e41ae9a3..fa5513b53ea8f 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -818,9 +819,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
>  	if (!page)
>  		return NULL;
>  
> -	mapping = dma_map_single(geth->dev, page_address(page),
> -				 PAGE_SIZE, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(geth->dev, mapping)) {
> +	page_mapping = dma_map_single(geth->dev, page_address(page),
> +				      PAGE_SIZE, DMA_FROM_DEVICE);

[Severity: High]
This is a pre-existing issue, but free queue pages are mapped once here
with DMA_FROM_DEVICE and never synced after that.

gmac_rx() passes page + page_offs to skb_fill_page_desc() and
napi_gro_frags() without calling dma_sync_single_range_for_cpu().

geth_fill_freeq() re-posts pages whose refcount has dropped back to 1 with
only a reference bump, and never calls dma_sync_single_for_device():

geth_fill_freeq() {
    ...
		/* Add one reference per fragment in the page */
		page_ref_add(page, 1 << fpp_order);
    ...
}

On non-coherent Gemini, can cache lines the CPU filled while reading the
previous packet hide data the device writes into the reused page?

This seems to be fixed later in the series. "net: ethernet: cortina:
Synchronize RX fragments for the CPU" adds dma_sync_single_range_for_cpu()
in geth_freeq_claim(). "net: ethernet: cortina: Preserve in-flight free
queue pages" makes geth_fill_freeq() map a fresh page every time.

> +	if (dma_mapping_error(geth->dev, page_mapping)) {

[ ... ]

> @@ -833,20 +842,11 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,

[ ... ]

>  	/* If the freeq entry already has a page mapped, then unmap it. */
>  	gpage = &geth->freeq_pages[pn];
>  	if (gpage->page) {
> -		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
> -		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
> +		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
> +				 DMA_FROM_DEVICE);

[Severity: Medium]
This new unmap covers the whole PAGE_SIZE and does not pass
DMA_ATTR_SKIP_CPU_SYNC. It only runs when page_ref_count(page) > 1 in
geth_fill_freeq(), so other fragments of the page are still owned by the
stack or waiting in an RX ring.

Where the implicit device-to-CPU sync is a cache invalidate or a swiotlb
copy-back, can this throw away CPU writes to fragments the stack already
owns?

The old code was also wrong here, since it unmapped the new mapping. This
looks to be fixed later in the series by "net: ethernet: cortina:
Synchronize RX fragments for the CPU". That commit syncs each fragment
when it is claimed. It only tears the page down, with
dma_unmap_single_attrs(..., DMA_ATTR_SKIP_CPU_SYNC), after every fragment
has been claimed.

>  		/* This should be the last reference to the page so it gets
>  		 * released
>  		 */

[Severity: High]
This isn't a bug introduced by this patch, but geth_fill_freeq() only
replaces a page while it still has fragment references outstanding:

geth_fill_freeq() {
    ...
		if (page_ref_count(page) > 1) {
    ...
			page = geth_freeq_alloc_map_page(geth, pn);
    ...
}

Some of those references can belong to fragments whose completion
descriptors are still in either port's RX ring. That doesn't match this
comment's claim that the put_page() drops the last reference.

After gpage->mapping and gpage->page are overwritten, gmac_get_queue_page()
only knows the new mapping. A pending descriptor that carries the old
buf_adr would then fail the lookup. gmac_rx() would go to err_drop with
page == NULL, and gmac_cleanup_rxq() would print "could not find page".

Is the fragment reference on the old page leaked in both cases?

This seems to be fixed later in the series by "net: ethernet: cortina:
Preserve in-flight free queue pages". It keeps every fragment DMA address
in an XArray until geth_freeq_claim() consumes it, and it only unmaps the
page once all fragments are claimed.

[ ... ]

> @@ -1013,12 +1020,10 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
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

[Severity: High]
This is a pre-existing issue, but this loop drops references the queue
doesn't own. gmac_rx() hands fragment references to skbs through
skb_fill_page_desc(), and those skbs can outlive the queue.
geth_cleanup_freeq() runs from geth_resize_freeq() on an ethtool ring
resize, and on removal.

Can this underflow the refcount of pages still attached to skbs? Once the
last put_page() frees the page, the loop also keeps reading
page_ref_count() on memory that may already be reallocated.

This looks to be fixed later in the series by "net: ethernet: cortina:
Preserve in-flight free queue pages". There, geth_freeq_release_pages()
only puts the per-fragment references still owned by hardware plus the
base reference.

>  	}

[ ... ]

> @@ -1503,8 +1508,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  
>  		frag_len = word0.bits.buffer_size;
>  		frame_len = word1.bits.byte_count;
> -		page_offs = mapping & ~PAGE_MASK;
> -
>  		if (word3.bits32 & SOF_BIT) {
>  			if (skb) {
>  				napi_free_frags(&port->napi);
> @@ -1523,14 +1526,14 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  			goto err_drop;
>  		}
>  
> -		/* Freeq pointers are one page off */
> -		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
> +		gpage = gmac_get_queue_page(geth, mapping);
>  		if (!gpage) {
>  			dev_err_ratelimited(geth->dev,
>  					    "could not find mapping\n");
>  			goto err_drop;
>  		}
>  		page = gpage->page;
> +		page_offs = mapping - gpage->mapping;

[Severity: Medium]
gmac_get_queue_page() and these two lines read gpage->mapping and
gpage->page without holding geth->freeq_lock. Meanwhile geth_fill_freeq()
can replace both fields under that lock, from the other port's NAPI poll
or from the SWFQ IRQ thread:

geth_freeq_alloc_map_page() {
    ...
	gpage->mapping = page_mapping;
	gpage->page = page;
    ...
}

What happens if the slot is replaced between the lookup and this read?
Could page_offs become a wrapped value that is then passed with the new
page to skb_fill_page_desc()?

Before this patch, page_offs came from the descriptor (mapping &
~PAGE_MASK) and always stayed within one page.

This seems to be fixed later in the series by "net: ethernet: cortina:
Index free queue fragments with XArray". It does the lookup, the
validation and the page/offset snapshot in geth_freeq_claim() while
holding freeq_lock.

[Severity: Medium]
This isn't a bug introduced by this patch, but the descriptor lengths used
further down in gmac_rx() are not bounds checked:

			page_offs += NET_IP_ALIGN;
			frag_len -= NET_IP_ALIGN;
    ...
		if (word3.bits32 & EOF_BIT)
			frag_len = frame_len - skb->len;
    ...
		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

frag_len underflows if buffer_size is smaller than NET_IP_ALIGN, or if
byte_count is smaller than the bytes already collected.
gmac_get_queue_page() only checks where the fragment starts.

Can a malformed descriptor then produce an skb fragment that runs past the
end of the page?

This looks to be fixed later in the series by "net: ethernet: cortina:
Validate RX fragment lengths", which rejects these cases in gmac_rx().

>  
>  		if (word3.bits32 & SOF_BIT) {
>  			skb = gmac_skb_if_good_frame(port, word0, frame_len);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78%40kernel.org
