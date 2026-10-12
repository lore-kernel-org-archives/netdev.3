Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CC837187B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830738; cv=none; b=JnWS6UjYPBdiJE/SdTfQnhG30mWHLnLwl7SaueEGfTw8pWM95VUmef7Hqt+0FXdnoaNZ/MSR4fS4ZvxKjc5jhAVdRDKH/cb/4ZGaBDnM4oSaZlXMLZXnLjp6Ifrza4vibKzuWKS7naywsD63XmxBaR8TZ8b1eq7kqdWH9K/JRXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830738; c=relaxed/simple;
	bh=1bbkFkLP7pnSHkQQP4ZwXWJRhL3vdpPNajoy92+KDz4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ndP40/vQitpHRFcJy3FDUPVDz0gViitMhrswKxwEBbJymo3cA5VvRNGYUOsNPH8dcQLU4WY20iPirtccXnNb14vEZxnPi6P+OQ2YwiNsJkyX0xKHUb+mqpAIB/toooTyuMQkJbk/R4dQVqFdOX/WLsh5sXRegjExQPtM5RoXCVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msVxycHQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msVxycHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4C31F008A2;
	Mon, 12 Oct 2026 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830733;
	bh=HEGVPqALgHlzITUAmP7DMNBSFKGurHrhdsTe/eosx/0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=msVxycHQf9GzEmeJSPeBVsNLPwAL3FtUqri77s4QrU8m/LNcPQADoB/tU6q90qFA3
	 lJ7fTfQFV0jU0drzgaAgFYCNQWPmKOX/FEHsoS38SeN1Lc/2whzpnGiEtaAFlmdEUL
	 zKTY9YsKPT/DknSAj2nlDnQoTooiqd2p8FOCTGGCxDqMYtYauseS9BJk8ZgFIwbfbr
	 efyjCdc2WThxwShbPwAJRbIWUpvs7mo4MLRfGfbhNdXuRsixBSjs+gB34FT9CjOTpz
	 rfyvJr3eruanvQiTKfPe0iNc0YCCL2sWVxYe9s6qFn7mKoD0zlKVLfJqsXuLDQHn3E
	 bnPkGIvCjmfHw==
Subject: Re: [PATCH net-next v4 05/15] net: ethernet: cortina: Correct free
 queue DMA mappings
From: netdev-bot+sashiko@kernel.org
To: linusw@kernel.org
Cc: ulli.kroll@googlemail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, mirq-linux@rere.qmqm.pl,
 mhun512@gmail.com, edumazet@kernel.org, netdev@vger.kernel.org
Date: Mon, 12 Oct 2026 18:45:32 +0000
Message-ID: <179183073213.434549.2828275647437130509@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-5-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-5-4b1631b08f5d@kernel.org>
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

Critical: 0 · High: 0 (2) · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In geth_cleanup_freeq()
  (drivers/net/ethernet/cortina/gemini.c:1038-1039), teardown still…
- [Medium] When geth_fill_freeq() replaces a slot whose page still has
  outstanding references (page_ref_count(page) > 1, lines 919-927),…

Pre-existing issues:
- [High] geth_fill_freeq() (lines 919-927) replaces freeq_pages[pn]
  whenever page_ref_count(page) > 1.
- [High] geth_cleanup_freeq() (lines 1041-1042) runs 'while
  (page_ref_count(gpage->page) > 0) put_page(gpage->page);'.
- [Medium] geth_freeq_lookup() checks the fragment start offset, but
  gmac_rx() never bounds the length it passes to skb_fill_page_desc()…

--

net: ethernet: cortina: Correct free queue DMA mappings

This patch keeps the free queue page DMA base separate from the fragment
iterator and removes the replacement unmap, which was unmapping the new
buffer. It also uses PAGE_SIZE in the setup unwind path and rejects
mappings above 32 bits. It replaces gmac_get_queue_page() with
geth_freeq_lookup(), which derives fragment offsets from the saved DMA
base under freeq_lock.

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index c3d1abdbebf61..3b915a4c89009 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

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
> +
>  	freeq_entry = geth->freeq_ring + (pn << fpp_order);

[ ... ]

> -
> -	/* If the freeq entry already has a page mapped, then unmap it. */
> -	gpage = &geth->freeq_pages[pn];
> -	if (gpage->page) {
> -		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
> -		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
> -		/* This should be the last reference to the page so it gets
> -		 * released
> -		 */
> -		put_page(gpage->page);
> -	}

[Severity: Medium]
With the replacement unmap removed, what releases the old page's DMA
mapping here?

When geth_fill_freeq() sees page_ref_count(page) > 1 and calls
geth_freeq_alloc_map_page(), the old page is put and gpage->mapping is
overwritten with the new page_mapping. The old PAGE_SIZE DMA_FROM_DEVICE
mapping is never unmapped. Its handle is not recorded anywhere else, so
geth_cleanup_freeq() can't release it either.

The old code unmapped the wrong buffer, but every mapping was at least
partly released. After this change, each refill replacement under RX
load leaves one more streaming mapping live.

The commit message says "Releasing mappings with in-flight fragments is
handled together with their lifetime later in the series". The later
commits "net: ethernet: cortina: Preserve in-flight free queue pages" and
"net: ethernet: cortina: Recycle claimed free queue pages" do unmap
gpage->mapping with PAGE_SIZE.

This patch has a Fixes: tag. Would a standalone stable backport pick up
this leaking intermediate state?

[ ... ]

> @@ -1025,7 +1037,6 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
>  
>  		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
>  		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
> -
>  		gpage = &geth->freeq_pages[pn];

[Severity: Medium]
Should this unmap also use gpage->mapping and PAGE_SIZE?

The page is mapped in geth_freeq_alloc_map_page() with:

    page_mapping = dma_map_single(geth->dev, page_address(page),
                                  PAGE_SIZE, DMA_FROM_DEVICE);

This patch changes the geth_setup_freeq() error unwind to:

    dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
                     DMA_FROM_DEVICE);

However, geth_cleanup_freeq() still unmaps only frag_len bytes, at the
address read back from the descriptor. This path runs from
geth_resize_freeq() on open and on ethtool set_ringparam, and from the
remove path. CONFIG_DMA_API_DEBUG would flag the size mismatch.

The later commit "net: ethernet: cortina: Preserve in-flight free queue
pages" replaces this loop with geth_freeq_release_pages(), which unmaps
gpage->mapping with PAGE_SIZE. The end state of the series looks
correct.

>  		while (page_ref_count(gpage->page) > 0)
>  			put_page(gpage->page);

[Severity: High]
This isn't a bug introduced by this patch, but can this loop free pages
that skbs still reference?

gmac_rx() passes fragments of these pages to the stack through
skb_fill_page_desc() and napi_gro_frags(). Suppose one of those skbs is
still queued (on an unread socket, for example) when this runs:

    geth_resize_freeq()
      geth_cleanup_freeq()
        while (page_ref_count(gpage->page) > 0)
            put_page(gpage->page);

The page goes back to the allocator while the skb still points to it.
The later kfree_skb() would then put a page that is already free.

This can be reached by bringing the ports down and up with a different
ring order, by ethtool set_ringparam, or by removing the device.

The later commit "net: ethernet: cortina: Preserve in-flight free queue
pages" replaces this loop with geth_freeq_release_pages(). That function
drops only the gpage->fragments references plus the base reference.

[ ... ]

> @@ -1516,8 +1526,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
>  
>  		frag_len = word0.bits.buffer_size;
>  		frame_len = word1.bits.byte_count;
> -		page_offs = mapping & ~PAGE_MASK;
> -
>  		if (word3.bits32 & SOF_BIT) {

[Severity: Medium]
This isn't a bug introduced by this patch, but is frag_len checked
anywhere before it reaches skb_fill_page_desc()?

geth_freeq_lookup() now checks the fragment start offset. The length,
though, still comes straight from the descriptor in gmac_rx():

    frag_len = word0.bits.buffer_size;
    ...
        page_offs += NET_IP_ALIGN;
        frag_len -= NET_IP_ALIGN;
    ...
    if (word3.bits32 & EOF_BIT)
        frag_len = frame_len - skb->len;
    ...
    skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);

The NET_IP_ALIGN subtraction has no lower bound, and frame_len - skb->len
can wrap. If the MAC reports inconsistent lengths, could the page frag
cover memory past the 2 KiB fragment or past the end of the page?

The later commit "net: ethernet: cortina: Validate RX fragment lengths"
appears to add these checks.

[ ... ]

> @@ -1536,14 +1544,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
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

[Severity: High]
This is a pre-existing issue, but what happens here if a refill has
already replaced the fragment's page?

geth_fill_freeq() decides to replace freeq_pages[pn] from the refcount
alone:

    if (page_ref_count(page) > 1) {
        ...
        page = geth_freeq_alloc_map_page(geth, pn);

That count also includes fragments the hardware has already written into
RX descriptors that gmac_rx() hasn't processed yet. Once gpage->page and
gpage->mapping are overwritten, geth_freeq_lookup() finds no match for
the old buf_adr and returns NULL. The frame is then dropped with "could
not find mapping", and err_drop skips the put:

    if (page)
        put_page(page);

Doesn't that leak the reference page_ref_add() took for this fragment,
and so the old page itself? gmac_cleanup_rxq() hits the same lookup
failure and also skips put_page().

The new locking in geth_freeq_lookup() only covers the window between
lookup and use. The later commit "net: ethernet: cortina: Preserve
in-flight free queue pages" tracks each fragment address in an XArray
until geth_freeq_claim(). That looks like it resolves this.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d%40kernel.org
