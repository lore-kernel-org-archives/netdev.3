Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2D331EA8
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791741995; cv=none; b=s3rHsQItXf1aiGIM4xb+EZnrhTgvU4ogXTQ/lZhykC2/sEX5jNk6F9TJ/JQ4NfnI1wSwAOFV5tAQAwrupCdidErElRS6UkUtbwVJkZd+e3SBkL5rXcCTKrktYKCY1Lh9n8hutoBNk8tnUK5R9tPf3ysOuto21D2g9HxmlKnL2HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791741995; c=relaxed/simple;
	bh=QjnhRF7bEahTSPxOQVKkLJwTox7fwx+cPdyYZS8/WQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DEu18apTGgjekk+oXAq2AG903RX2HWuH2vYl6RV4zteN0B56E9HXl2RMbtnOmF2FmQP87Xcuriik6km55jgyBUXqiLA9Y4EkqMy4icf7JZd4aJrXklNR1qYZO6UrmtbLgV+Aht4Pxa1yrn45dqhYFu1moAWUCjKo8yoVsz+DDgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgu7CGFw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgu7CGFw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD6C1F0089C;
	Sun, 11 Oct 2026 18:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791741993;
	bh=psKq4YK4mMa9nGZtynxeJkP9Rh8ZIkSdEcs/GoRJpg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Rgu7CGFw9aNijlqueV5X/g4QZilTS591NJ6dCMxbLiNf1XaYcQk/jfeHpL2NDgsmc
	 elnPJ2frMKGMxU1lyIZMMPsdkEhE4cKGJz5f7AzYUGZNjyDIMpIa+uI84x6APZA4Ry
	 oUwOg5L1PpauAVDwB3NSoMb0TU3U8kz1VtgZtY4fHGy7OAzOo60++oo7iBS01NZ9PD
	 zov+rk7TvQkbyIUhLUEyF8bki+DiwHvFbcQU04+GoB9vCjI9Y5G9qK5wPrLFN8+92x
	 rbtbL0Qdne7CZrVyBhCQHaWU7dIbID9rbPhEuXYBhfyq/Kc006MFpXIJnBq1X0vOOT
	 P/nVYhYAdpeRA==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:18 +0200
Subject: [PATCH net-next v4 05/15] net: ethernet: cortina: Correct free
 queue DMA mappings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-5-4b1631b08f5d@kernel.org>
References: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
In-Reply-To: <20261011-gemini-ethernet-fixes-3-v4-0-4b1631b08f5d@kernel.org>
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
index c3d1abdbebf6..3b915a4c8900 100644
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
@@ -980,12 +993,11 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
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
 
@@ -1025,7 +1037,6 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
 		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
-
 		gpage = &geth->freeq_pages[pn];
 		while (page_ref_count(gpage->page) > 0)
 			put_page(gpage->page);
@@ -1479,7 +1490,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
-	struct gmac_queue_page *gpage;
 	unsigned int received = 0;
 	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
@@ -1516,8 +1526,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
-		page_offs = mapping & ~PAGE_MASK;
-
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
@@ -1536,14 +1544,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
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

