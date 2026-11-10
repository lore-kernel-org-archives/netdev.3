Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348818;
	b=D7Ltb0bCPvTEuG3AP5iAvE05Y0xurKVRLLalw1yFXFOlQtAbGutAZ6J09fzcwvVBjI8o
	 grSRNUAERVx9SYRKp14GD8si/MlzIjCQ7kbFFAIHc3tQe07vzrv+6+nO/dRKRKk0ZV69h
	 byfNQqBg7fkv2c3HYTokMlVAbs99rRFfokbh1ra+hZS/gUeNW3I3wEN64NjcTK3ravll+
	 ovZ6uZkx14GaTsRvq29KtbCW2rBk7RosN7J6xAkeSUggnlbDAEJu98m2m/e7gIKK6Bwfr
	 XWKcOYExrAtLf1KcEtdBhI4PAYTOwT7pBBx42x4GAc3U8NgpgblEmQ50kpkD1Zp/6JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348818;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=EeuTrcOgnA3eYVY4NOBjIpOp6l1qZvXqyCTVUyLyX/c=;
	b=gvf0rkymaRS8nMx4ARl28uelplKzBnZciCrwJPMYZDX4r+1rR/gMA8jA0xlQeo8f6L3a
	 YAT0wCvbelhhKLW1z2MhfyXlnDFym2w2tCvwSbQb6TfoI2zXvuM/rf2Jkq/5+eNRgTkXI
	 apOai8XMrDv1jQdFp/Nxrl/7kVOSyb5Fmp/4ToI20sIgf6Sd92+2cOOlhoyVu6Dd/HxQm
	 VYupYvsSTuPMHALGKp5dyx5WXgCB+hTiKywvQRPuGgM9/DrGkFbjb+IOWVMCtBXWFNgu2
	 gtN7RubpZ71KHzM2PWTvcPRYWQU9tSKZipFtNRm2EYAD4wweOaYDJK8zbGKEztaVzHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnYB76Yg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11142606A330
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnYB76Yg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760A61F008A1;
	Tue, 10 Nov 2026 22:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348817;
	bh=EeuTrcOgnA3eYVY4NOBjIpOp6l1qZvXqyCTVUyLyX/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KnYB76YgSCk58bUYRbJMvP4NMHUzoic7HgJwACxXoF65CAAjUCFl48FYTCN1GzdX5
	 opwIjRp7D6oh5JDWyVCG8nBQmjKNCy9zbZUzTCj5s+xc54n2bnnp9F/tRFJbEyqNZP
	 1jlaP55Dd0W8ZX0VCDtUsCYbpWT0eB2An4uR6m2B+cq7BRbs9w2hlDK1PFHODowH86
	 9J8V31kWSoYG5cC3j9XScp3sEEfBNEJA6B1YhPbCGSvkxk601XFIDaG0MpkSR13MvJ
	 Kcv2BudJlRoB9wThtEbA/FHJKjhUJsAKiuZT9nVjbwMh+lmpnCMTnknfWc9dcYTCkx
	 PqH1EMVDpcIeA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:20 +0100
Subject: [PATCH net-next v7 05/18] net: ethernet: cortina: Correct free
 queue DMA mappings
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-5-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The free queue maps complete pages and splits each mapping between its
fragment descriptors. The mapping variable is advanced while filling the
descriptors and that advanced address is then saved as the page mapping.

Replacement also reads the old address after overwriting the descriptor
with the new mapping, so it unmaps the new buffer while leaving the old
mapping live.

The same reassignment leaves replacement metadata holding the new page
base while gmac_rx() still adds PAGE_SIZE before lookup. Once a page is
replaced under RX load, lookup therefore normally fails with "could not
find mapping" and drops the frame. If the resulting key matches another
page, RX can instead attach that page to the skb and drop the wrong page
reference.

Keep the page DMA base separate from the fragment iterator and remove the
invalid replacement unmap. The replaced mapping cannot be released until
its in-flight fragments have been claimed, which is handled with their
lifetime later in the series. Use the saved DMA base and PAGE_SIZE when
unwinding setup and tearing down the current queue.

Reject mappings that cannot fit in the 32-bit hardware descriptors and
derive fragment offsets from the saved DMA base instead of assuming
page-aligned DMA addresses. Snapshot the page, DMA base and offset under
the free queue lock so refill cannot replace them between lookup and use.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 112 ++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 54 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index fa51f2b54073..71d7e6189531 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -726,32 +726,43 @@ static int gmac_setup_rxq(struct net_device *netdev)
 	return 0;
 }
 
-static struct gmac_queue_page *
-gmac_get_queue_page(struct gemini_ethernet *geth,
-		    struct gemini_ethernet_port *port,
-		    dma_addr_t addr)
+static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
+				      dma_addr_t mapping,
+				      unsigned int *page_offs)
 {
+	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	struct gmac_queue_page *gpage;
-	dma_addr_t mapping;
+	unsigned long flags;
+	dma_addr_t page_mapping;
+	struct page *page = NULL;
 	int i;
 
-	/* Only look for even pages */
-	mapping = addr & PAGE_MASK;
-
+	spin_lock_irqsave(&geth->freeq_lock, flags);
 	if (!geth->freeq_pages) {
 		dev_err_ratelimited(geth->dev,
 				    "try to get page with no page list\n");
-		return NULL;
+		goto unlock;
 	}
 
 	/* Look up a ring buffer page from virtual mapping */
 	for (i = 0; i < geth->num_freeq_pages; i++) {
 		gpage = &geth->freeq_pages[i];
-		if (gpage->mapping == mapping)
-			return gpage;
+		if (!gpage->page || mapping < gpage->mapping)
+			continue;
+
+		page_mapping = gpage->mapping;
+		if (mapping - page_mapping > PAGE_SIZE - frag_len ||
+		    ((mapping - page_mapping) & (frag_len - 1)))
+			continue;
+
+		page = gpage->page;
+		*page_offs = mapping - page_mapping;
+		break;
 	}
 
-	return NULL;
+unlock:
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+	return page;
 }
 
 static void gmac_cleanup_rxq(struct net_device *netdev)
@@ -759,11 +770,12 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
 	struct gmac_rxdesc *rxd = port->rxq_ring;
-	static struct gmac_queue_page *gpage;
 	struct nontoe_qhdr __iomem *qhdr;
 	void __iomem *dma_reg;
 	void __iomem *ptr_reg;
+	unsigned int page_offs;
 	dma_addr_t mapping;
+	struct page *page;
 	union dma_rwptr rw;
 	unsigned int r, w;
 
@@ -790,14 +802,13 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 		if (!mapping)
 			continue;
 
-		/* Freeq pointers are one page off */
-		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
-		if (!gpage) {
+		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		if (!page) {
 			dev_err(geth->dev, "could not find page\n");
 			continue;
 		}
 		/* Release the RX queue reference to the page */
-		put_page(gpage->page);
+		put_page(page);
 	}
 
 	dma_free_coherent(geth->dev, sizeof(*port->rxq_ring) << port->rxq_order,
@@ -811,6 +822,7 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	struct gmac_queue_page *gpage;
 	unsigned int fpp_order;
 	unsigned int frag_len;
+	dma_addr_t page_mapping;
 	dma_addr_t mapping;
 	struct page *page;
 	int i;
@@ -820,9 +832,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	if (!page)
 		return NULL;
 
-	mapping = dma_map_single(geth->dev, page_address(page),
-				 PAGE_SIZE, DMA_FROM_DEVICE);
-	if (dma_mapping_error(geth->dev, mapping)) {
+	page_mapping = dma_map_single(geth->dev, page_address(page),
+				      PAGE_SIZE, DMA_FROM_DEVICE);
+	if (dma_mapping_error(geth->dev, page_mapping)) {
+		put_page(page);
+		return NULL;
+	}
+	if (page_mapping > U32_MAX - (PAGE_SIZE - 1)) {
+		dev_err_ratelimited(geth->dev,
+				    "freeq DMA mapping exceeds 32 bits\n");
+		dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
 		put_page(page);
 		return NULL;
 	}
@@ -835,31 +855,25 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	 */
 	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	gpage = &geth->freeq_pages[pn];
+	if (gpage->page)
+		put_page(gpage->page);
+
+	/* Then put our new mapping into the page table */
+	gpage->mapping = page_mapping;
+	gpage->page = page;
+
 	freeq_entry = geth->freeq_ring + (pn << fpp_order);
 	dev_dbg(geth->dev, "allocate page %d fragment length %d fragments per page %d, freeq entry %p\n",
-		 pn, frag_len, (1 << fpp_order), freeq_entry);
+		pn, frag_len, (1 << fpp_order), freeq_entry);
+	mapping = page_mapping;
 	for (i = (1 << fpp_order); i > 0; i--) {
 		freeq_entry->word2.buf_adr = mapping;
 		freeq_entry++;
 		mapping += frag_len;
 	}
-
-	/* If the freeq entry already has a page mapped, then unmap it. */
-	gpage = &geth->freeq_pages[pn];
-	if (gpage->page) {
-		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
-		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
-		/* This should be the last reference to the page so it gets
-		 * released
-		 */
-		put_page(gpage->page);
-	}
-
-	/* Then put our new mapping into the page table */
-	dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
-		pn, (unsigned int)mapping, page);
-	gpage->mapping = mapping;
-	gpage->page = page;
+	dev_dbg(geth->dev, "page %d, DMA addr: %pad, page %p\n",
+		pn, &page_mapping, page);
 
 	return page;
 }
@@ -930,7 +944,6 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 static int geth_setup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
 	union queue_threshold qt;
@@ -982,12 +995,11 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 err_freeq_alloc:
 	while (pn > 0) {
 		struct gmac_queue_page *gpage;
-		dma_addr_t mapping;
 
 		--pn;
-		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
-		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
 		gpage = &geth->freeq_pages[pn];
+		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
 		put_page(gpage->page);
 	}
 
@@ -1009,7 +1021,6 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
 	unsigned int pn;
@@ -1023,12 +1034,10 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 	for (pn = 0; pn < pages; pn++) {
 		struct gmac_queue_page *gpage;
-		dma_addr_t mapping;
-
-		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
-		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
 
 		gpage = &geth->freeq_pages[pn];
+		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
 		while (page_ref_count(gpage->page) > 0)
 			put_page(gpage->page);
 	}
@@ -1486,7 +1495,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
-	struct gmac_queue_page *gpage;
 	unsigned int received = 0;
 	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
@@ -1523,8 +1531,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
-		page_offs = mapping & ~PAGE_MASK;
-
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
@@ -1543,14 +1549,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		/* Freeq pointers are one page off */
-		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
-		if (!gpage) {
+		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		if (!page) {
 			dev_err_ratelimited(geth->dev,
 					    "could not find mapping\n");
 			goto err_drop;
 		}
-		page = gpage->page;
 
 		if (word3.bits32 & SOF_BIT) {
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);

-- 
2.56.0

