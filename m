Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C514AB1DD
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958298; cv=none; b=aWZwURTfSkvel66SytjuziRJUZkrvO8zJf6pLA4QGrSN5ckPO8ABTewQhsQBDxcEuJt3QEK+SC8WYXDJBDda2KHHk2RA06g8efi5gvoi/BYAHNsitZUqONrft7n5CBcJkDdzHXaW49+4G6O0np/EA+qlT2UqFwQRIKuUVG7+7PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958298; c=relaxed/simple;
	bh=uyrygh2o+oEIIb2cVRtBclbQbRhY3iEfc1RiYihXnF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4bII1D1ZFMN9wxjnqV2A1ASH+K8mSviuBI6mOn/Div47aq/KCSAwcwEY2Ene/zssWkeAhYzvrkl71wJs7vYu5FPNgqmxZ6VqUBLS7WKlw7LFz8ESJbC1S1CW6mgbno9HQI4qdbfhv2kzd9BkyuJtvlVo+b3C3kq57hkgdF7DoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYcyFxSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYcyFxSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAED1F000FF;
	Fri,  2 Oct 2026 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958297;
	bh=zgJVoQl43QsPDuynAdFWVAZUg2+mjb1SIEtuQHhXJNI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aYcyFxSQQER4kYYXv8WP7Xuz8LbqOPzzwvzsPp4lXM+DNB5FCdKjH1aXczwIa7VdI
	 QTwH8jHv4g2nLm1eB6yLi2q4PU138bUdhj1xaPtg7rWcvqB3zID1nacuRPG8btlpYg
	 IYvUk4MGk+fSV++WP4C3cKk64uVkEsyN3LGRgA/Vc7CqH3yEnT0JwSvyNxBRYcXzdG
	 pV5UoH5q82NLU+eFXDlKtnl3VMDweiHAwBbA5z/IQqsalMKhIypddqcZfiIjA+qJLr
	 MzYDFxpVC6B6ym8N/xk3VXvAPb3xzc1rYdCBD5RCfAxQVBsSVITiM/NCFmVGATa6T2
	 oJYX+iaarfi3A==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:43 +0200
Subject: [PATCH net-next v3 04/12] net: ethernet: cortina: Correct free
 queue DMA mappings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-4-3e1f25890ae8@kernel.org>
References: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
In-Reply-To: <20261002-gemini-ethernet-fixes-3-v3-0-3e1f25890ae8@kernel.org>
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

Keep the page DMA base separate from the fragment iterator and remove the
invalid replacement unmap. Releasing mappings with in-flight fragments is
handled together with their lifetime later in the series. Use PAGE_SIZE
when unwinding mappings which have not reached the hardware.

Reject mappings that cannot fit in the 32-bit hardware descriptors and
derive fragment offsets from the saved DMA base instead of assuming
page-aligned DMA addresses. Snapshot the page, DMA base and offset under
the free queue lock so refill cannot replace them between lookup and use.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 106 ++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index a2daf22e7698..809274aff8e5 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -724,32 +724,43 @@ static int gmac_setup_rxq(struct net_device *netdev)
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
@@ -757,11 +768,12 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
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
 
@@ -788,14 +800,13 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
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
@@ -809,6 +820,7 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	struct gmac_queue_page *gpage;
 	unsigned int fpp_order;
 	unsigned int frag_len;
+	dma_addr_t page_mapping;
 	dma_addr_t mapping;
 	struct page *page;
 	int i;
@@ -818,9 +830,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -833,31 +853,25 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -927,7 +941,6 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 static int geth_setup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
 	union queue_threshold qt;
@@ -974,12 +987,11 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
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
 
@@ -1019,7 +1031,6 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
 		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
-
 		gpage = &geth->freeq_pages[pn];
 		while (page_ref_count(gpage->page) > 0)
 			put_page(gpage->page);
@@ -1475,7 +1486,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
-	struct gmac_queue_page *gpage;
 	unsigned int received = 0;
 	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
@@ -1512,8 +1522,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
-		page_offs = mapping & ~PAGE_MASK;
-
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
@@ -1532,14 +1540,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
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
2.55.0

