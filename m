Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2DE48986D
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585449; cv=none; b=MlosMFDVoglZCYf4dofff9/2xN3R93tWaB+sg4S/ctVuDNh8YWbTsBp28NtJIXGLAWpMFa7KE/tCw9J9YFA52VhoWpxMZoOZAsQGcg/IKZlVJ7blw2ODt5C+j3Fkc6o5Q5vBxuo3briJBCi8PMBBkGTDKRSIdA7qntyllul9eeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585449; c=relaxed/simple;
	bh=D4zHqmevqr4beigltO8m6ATwWwUaqoyXQ1xlFgHxnLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfNbMuTgNAQyPx/x8I9FbMKJhPHlu8q6LfZAkl+c2lashIbRbr2KvE/pEjycizBazxetfCrQaFv1sWcy7lp+6yEgkXr2vakSiyF24KQyx014MmjudCBDbenX9m4jGktQMORYG/6aZrZRA9bU27CZ2R0tBQMYmCf5LBpkNDaOOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsbf8tb6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsbf8tb6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFA71F00893;
	Mon, 28 Sep 2026 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585447;
	bh=BPtPIdl6LWQP5z9wlVK0TDbv9I242tqkpXZcCkZp8hE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bsbf8tb6nD+jtoU9CQjfDT3Bu3+CjIlnnk3baGH+A7VjGAhMB6NEVz8KZh1hPNQb+
	 Qe9igZ5ceL8X6Mkj35Ss464w++iZiXbX2HRg7Ee4Lm3zuMF9Qz1ChhCridfW0GIYuw
	 HfFDhGSJg7DkK3Wd1qLfhvxSnyZePAgufz2PMUb0ilQusfCCee485e+sCyNKq/zuD1
	 EwpjW5Z9Ll6TK1J4ET2umikcAFZt37dNsptBUV5lto6J7wElPPd8eJ097mj8159wki
	 RRyBTrHB9tW4FR9rbXCsiASWXaU/6Lalp3TXukQdiCR4Dwm9Y9DhmcrbrWn8o+y/PX
	 I/p9TcxBbcFkg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:29 +0200
Subject: [PATCH net-next v2 03/11] net: ethernet: cortina: Correct free
 queue DMA mappings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-3-758a795d7a78@kernel.org>
References: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
In-Reply-To: <20260928-gemini-ethernet-fixes-3-v2-0-758a795d7a78@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The free queue maps complete pages and splits each mapping between its
fragment descriptors. The mapping variable is advanced while filling the
descriptors and that advanced address is then saved as the page mapping.

Replacement also reads the old address after overwriting the descriptor
with the new mapping.

Keep the page DMA base separate from the fragment iterator. Unmap the old
page through its saved metadata before replacing it, and use PAGE_SIZE for
every map and unmap operation.

Reject mappings that cannot fit in the 32-bit hardware descriptors and
derive fragment offsets from the saved DMA base rather than assuming
DMA addresses are page aligned.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 85 ++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index e5531e41ae9a..fa5513b53ea8 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -725,17 +725,13 @@ static int gmac_setup_rxq(struct net_device *netdev)
 }
 
 static struct gmac_queue_page *
-gmac_get_queue_page(struct gemini_ethernet *geth,
-		    struct gemini_ethernet_port *port,
-		    dma_addr_t addr)
+gmac_get_queue_page(struct gemini_ethernet *geth, dma_addr_t addr)
 {
+	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	struct gmac_queue_page *gpage;
-	dma_addr_t mapping;
+	unsigned int offset;
 	int i;
 
-	/* Only look for even pages */
-	mapping = addr & PAGE_MASK;
-
 	if (!geth->freeq_pages) {
 		dev_err_ratelimited(geth->dev,
 				    "try to get page with no page list\n");
@@ -745,7 +741,12 @@ gmac_get_queue_page(struct gemini_ethernet *geth,
 	/* Look up a ring buffer page from virtual mapping */
 	for (i = 0; i < geth->num_freeq_pages; i++) {
 		gpage = &geth->freeq_pages[i];
-		if (gpage->mapping == mapping)
+		if (!gpage->page || addr < gpage->mapping)
+			continue;
+
+		offset = addr - gpage->mapping;
+		if (offset <= PAGE_SIZE - frag_len &&
+		    !(offset & (frag_len - 1)))
 			return gpage;
 	}
 
@@ -757,7 +758,7 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
 	struct gmac_rxdesc *rxd = port->rxq_ring;
-	static struct gmac_queue_page *gpage;
+	struct gmac_queue_page *gpage;
 	struct nontoe_qhdr __iomem *qhdr;
 	void __iomem *dma_reg;
 	void __iomem *ptr_reg;
@@ -788,8 +789,7 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 		if (!mapping)
 			continue;
 
-		/* Freeq pointers are one page off */
-		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
+		gpage = gmac_get_queue_page(geth, mapping);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find page\n");
 			continue;
@@ -809,6 +809,7 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	struct gmac_queue_page *gpage;
 	unsigned int fpp_order;
 	unsigned int frag_len;
+	dma_addr_t page_mapping;
 	dma_addr_t mapping;
 	struct page *page;
 	int i;
@@ -818,9 +819,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -833,20 +842,11 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	 */
 	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	freeq_entry = geth->freeq_ring + (pn << fpp_order);
-	dev_dbg(geth->dev, "allocate page %d fragment length %d fragments per page %d, freeq entry %p\n",
-		 pn, frag_len, (1 << fpp_order), freeq_entry);
-	for (i = (1 << fpp_order); i > 0; i--) {
-		freeq_entry->word2.buf_adr = mapping;
-		freeq_entry++;
-		mapping += frag_len;
-	}
-
 	/* If the freeq entry already has a page mapped, then unmap it. */
 	gpage = &geth->freeq_pages[pn];
 	if (gpage->page) {
-		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
-		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
+		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
 		/* This should be the last reference to the page so it gets
 		 * released
 		 */
@@ -854,11 +854,21 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	}
 
 	/* Then put our new mapping into the page table */
-	dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
-		pn, (unsigned int)mapping, page);
-	gpage->mapping = mapping;
+	gpage->mapping = page_mapping;
 	gpage->page = page;
 
+	freeq_entry = geth->freeq_ring + (pn << fpp_order);
+	dev_dbg(geth->dev, "allocate page %d fragment length %d fragments per page %d, freeq entry %p\n",
+		pn, frag_len, (1 << fpp_order), freeq_entry);
+	mapping = page_mapping;
+	for (i = (1 << fpp_order); i > 0; i--) {
+		freeq_entry->word2.buf_adr = mapping;
+		freeq_entry++;
+		mapping += frag_len;
+	}
+	dev_dbg(geth->dev, "page %d, DMA addr: %pad, page %p\n",
+		pn, &page_mapping, page);
+
 	return page;
 }
 
@@ -927,7 +937,6 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 static int geth_setup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
 	union queue_threshold qt;
@@ -974,12 +983,11 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
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
 
@@ -999,7 +1007,6 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
 	unsigned int pn;
@@ -1013,12 +1020,10 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
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
@@ -1503,8 +1508,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
-		page_offs = mapping & ~PAGE_MASK;
-
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
@@ -1523,14 +1526,14 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		/* Freeq pointers are one page off */
-		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
+		gpage = gmac_get_queue_page(geth, mapping);
 		if (!gpage) {
 			dev_err_ratelimited(geth->dev,
 					    "could not find mapping\n");
 			goto err_drop;
 		}
 		page = gpage->page;
+		page_offs = mapping - gpage->mapping;
 
 		if (word3.bits32 & SOF_BIT) {
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);

-- 
2.55.0

