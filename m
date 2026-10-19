Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792430927;
	b=QMzaxcwTaR9NzGpxMHTqG8gFU6n4/I0LLKx37QHd/V4rnMtxHqp3ECYnEwBjxLxJ2TZ1
	 AgsOh2jEhiwAreJw4eQqckXK3hZAaVXJFgskj/pNyGJiwNcxis0PQBIPp1aTCcOQP4aDi
	 l5CkaV4LUPMQUL8lOwWOuSLKY7fPXjn19RCTHe0Z5IlZVPiEYEkDqmrymh8eZovoosU4j
	 yAmPTQX3hyCE9rakk6FwFTALwMmhPM0dX7Ck3RerPN+UY7M84p+CG/WRqRWgaI6YUvwfC
	 fMJMIrC4e4bxbSnxXpErLgrnm9zkzQFHSDArNn0ShM/8wjYKKxHh/yNRqheIpKZj3vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792430927;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=M21oMTW6+9bcWns++r64/Mz3ZleAY5JyuObKUELM3Mo=;
	b=Q/AR/RYE0LWht167upvQ3srWR+xEHhO7NXecEUS7MVNSTjkQ81dmbkVwEw6T6/yMkrjr
	 xNaUXg4r7wMhNvTYT2nB9O6N7qWankHLMn7hpqZ/XCXu4RfTirRYoL1dmTjOEgrzWD1jZ
	 b4PCdiV/SuB2Cb8qLp4HDSHce9TyGvARyEq6Y86BacCgOwsx8wikq1Qus42RpNmCcvvNI
	 4XnKyiY0olV/COqn/NZE1GLeojtXjP0jh3QmrzKDISBpFX151QF0c0hYULY4t4J0db+J3
	 Bf3gThJ3DJPV9CjKojazXtCp9U1kTXyVUiQoz1wMbY2uIOgjYSnpK86okUZNiuLXNdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMwNz0Yq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4681B606A331
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EMwNz0Yq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF651F000C9;
	Mon, 19 Oct 2026 17:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792430926;
	bh=M21oMTW6+9bcWns++r64/Mz3ZleAY5JyuObKUELM3Mo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EMwNz0Yq8TmbF1TB/Ktbn4fkQRtjuxTE97Lu+e0g4ZFWCEG6XBtD+2z4JJyEruQWD
	 o7+SEW9WbVDg5Pk2milfh7gx82qWf4jfgqiiWMH+f/nnkX7QUhQMof07lI9Hxb58OJ
	 F8Z0fMQ39B2peYEByKcjHAIk4ZNy2edmOdNGilzlsX2Jx1RNxMqQBDfUdyZ4J2tYCx
	 vkoBpcQDj/45b9iEeSjaQoeYQgOkTE5yCnrhOrvSjoM2VxStp4xOGPYUq9oXHSJ3NF
	 Lpj1/te1O/vxhddLQYAZ6c3zz9/AHq39ug4yn2fW5NmQzYXRh+9mRE8N3ba9a+vXzT
	 g/oaIpgsFdFYA==
Subject: Re: [PATCH net-next v5 05/14] net: ethernet: cortina: Correct free
 queue DMA mappings
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 19 Oct 2026 17:28:45 +0000
Message-ID: <179243092582.3135.18056629169970889958@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-5-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-5-b5c9e2f7b8a3@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (3) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch fixes a real RX-path bug that dates back to the
  original driver, but the commit message has no Fixes: tag.
- [Low] This is a netdev hardware-driver bug fix, but the commit message
  does not say how the issue was found, how it was validated, or how the…

Pre-existing issues:
- [High] geth_cleanup_freeq() still runs 'while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);'.
- [High] gmac_rx() never checks the descriptor-supplied fragment length
  against the posted buffer.
- [High] Free-queue pages keep one DMA_FROM_DEVICE mapping for the
  queue's whole lifetime.
- [Medium] When geth_fill_freeq() replaces a slot whose
  page_ref_count(page) > 1, geth_freeq_alloc_map_page() calls put_page()…

--

net: ethernet: cortina: Correct free queue DMA mappings

This commit keeps the free queue page DMA base separate from the
per-fragment iterator. It removes the replacement-path unmap, which was
unmapping the new buffer, and unmaps the full PAGE_SIZE mapping on setup
unwind and teardown. It also replaces gmac_get_queue_page() with
geth_freeq_lookup(), which works out fragment offsets from the saved DMA
base under freeq_lock, and rejects mappings that do not fit in 32-bit
descriptors.

> Assisted-by: LLM
> Signed-off-by: Linus Walleij <linusw@kernel.org>

[Severity: Medium]
This looks like a fix for behaviour that has been there since the driver
was added, but there is no Fixes: tag. maintainer-netdev.rst says "for
fixes the Fixes: tag is required, regardless of the tree".

Should this carry something like:

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")

Other patches in the series do have Fixes: tags. That includes "net:
ethernet: cortina: Preserve in-flight free queue pages", which builds on
this one. Without a tag here, could stable tooling pick up the dependent
patches but not this one?

Could the commit message also describe the symptom users saw before the
fix?

Before this patch, gpage->mapping held base + PAGE_SIZE for pages mapped
at setup. For pages replaced from geth_fill_freeq() it held the new
page's base. The lookup always used:

    gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);

This only matches the setup case. For a replaced page at base X the key
becomes X + PAGE_SIZE, so one of two things happens in gmac_rx():

- it logs "could not find mapping" and drops the frame, or
- it matches a different page whose stored value happens to be
  X + PAGE_SIZE, attaches that page to the skb and drops that page's
  reference.

[Severity: Low]
The "Bug fixes" section of Documentation/process/maintainer-netdev.rst
says "All bug fixes must state how the issue was discovered and
validated, and how the fix was tested." The only trailers here are
Assisted-by: and Signed-off-by:, so they don't supply that information.

Later patches in the series include a statement such as "The series was
tested on a D-Link DIR-685...". Could a similar note on discovery and
testing be added here? This patch changes DMA map/unmap sizes,
descriptor programming and the RX lookup path.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index 7ebd62f8a3a46..006362a033952 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -820,9 +832,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
>  	if (!page)
>  		return NULL;
>  
> -	mapping = dma_map_single(geth->dev, page_address(page),
> -				 PAGE_SIZE, DMA_FROM_DEVICE);
> -	if (dma_mapping_error(geth->dev, mapping)) {
> +	page_mapping = dma_map_single(geth->dev, page_address(page),
> +				      PAGE_SIZE, DMA_FROM_DEVICE);

[Severity: High]
This is a pre-existing issue, but free queue pages keep this one
DMA_FROM_DEVICE mapping for the whole life of the queue. When the stack
releases a page, geth_fill_freeq() gives it back to the hardware with
only:

    /* Add one reference per fragment in the page */
    page_ref_add(page, 1 << fpp_order);

plus the SWFQ write pointer update. There is no
dma_sync_single_for_device() call.

gmac_rx() also passes fragments to the stack without calling
dma_sync_single_range_for_cpu().

The FA526 is not cache-coherent. Can cache lines filled while the stack
read an earlier frame survive the reuse? If so, the CPU would see stale
data for the next frame DMA'd into the same page.

This seems to be handled later in the series:

- "net: ethernet: cortina: Preserve in-flight free queue pages" adds
  dma_sync_single_range_for_cpu() in geth_freeq_claim().
- "net: ethernet: cortina: Recycle claimed free queue pages" adds
  dma_sync_single_for_device() in geth_freeq_post_page().

> +	if (dma_mapping_error(geth->dev, page_mapping)) {

[ ... ]

> @@ -835,31 +855,25 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
This isn't a bug introduced by this patch. When geth_fill_freeq()
replaces a slot because page_ref_count(page) > 1, the old page's
PAGE_SIZE DMA_FROM_DEVICE mapping is overwritten here and not recorded
anywhere else.

Is that mapping ever unmapped? geth_cleanup_freeq() only unmaps the
current gpage->mapping.

RX descriptors that still point into the old page also can't be found by
geth_freeq_lookup(), because it only searches the current freeq_pages[]
entries. In gmac_rx() that ends up in:

    page = geth_freeq_lookup(geth, mapping, &page_offs);
    if (!page) {
        ...
        goto err_drop;
    }

err_drop runs with page == NULL here. Does that drop the frame and leak
the fragment's reference on the old page?

The commit message defers this ("The replaced mapping cannot be released
until its in-flight fragments have been claimed, which is handled with
their lifetime later in the series"). Two later commits appear to fix
it:

- "net: ethernet: cortina: Preserve in-flight free queue pages" adds
  geth_freeq_claim() with per-fragment xarray tracking.
- "net: ethernet: cortina: Recycle claimed free queue pages" adds
  dma_unmap_single_attrs() in geth_freeq_recycle_page().

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

[Severity: High]
This is a pre-existing issue, but can this loop drop references that
belong to skbs already passed to the stack?

gmac_rx() attaches fragments with skb_fill_page_desc() and hands them
off with napi_gro_frags(). Those skbs may still be in socket queues when
the free queue is torn down.

Draining page_ref_count() to zero would free the page under them. After
the page is freed and possibly reallocated, the next page_ref_count()
read could also lead to dropping a reference that belongs to the new
owner.

Later in the series, "net: ethernet: cortina: Preserve in-flight free
queue pages" gives each posted fragment its own reference. With that
change, geth_freeq_release_pages() only puts gpage->fragments + 1
references.

>  	}

[ ... ]

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
>  
>  		if (word3.bits32 & SOF_BIT) {
>  			skb = gmac_skb_if_good_frame(port, word0, frame_len);

[Severity: High]
This is a pre-existing issue. geth_freeq_lookup() only checks the
fragment's starting offset, and gmac_rx() never checks the length from
the descriptor against the posted buffer:

    page_offs += NET_IP_ALIGN;
    frag_len -= NET_IP_ALIGN;
    ...
    if (word3.bits32 & EOF_BIT)
        frag_len = frame_len - skb->len;
    ...
    skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

If the hardware reports an inconsistent buffer_size or byte_count, can
frag_len underflow or exceed the 2 KiB fragment? The skb fragment would
then describe memory past the buffer or past the end of the page.

The later commit "net: ethernet: cortina: Validate RX fragment lengths"
adds this validation:

- it rejects frag_len < NET_IP_ALIGN and frame_len < skb->len
- it limits frag_len to what fits in the fragment and the page

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3%40kernel.org
