Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D919648C3E3
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585452; cv=none; b=BoNmBmEfvkkS5q2gYQEHCrQ/hnLSOYr7Z5Tih1CeajRcsTfYty54fkIhmzpNLPLk9Pg3wK2ue6Dvj+C2Pa0iNg/n4cRqGqi+OfTYmmHdXVUi2g2JtwS651MaSacylWOSqN6l0FBrqhHWSnhuqhMHHZDqrn3cF1iCe/43rsbmgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585452; c=relaxed/simple;
	bh=0eYNNXwMvVBCjvfa92+LHrpHN/Vt+1i/Hx4jE+kMNTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfbdtbg0xFO1TtGzRvcvpbdjk28SGMTHGP1DbrRXJDv4DW0gXm4q184mTLbUSQMiVSG5wxBOlELKxC3kjPmWeUEBeLshUCkjKc5A307k4xDL/QxSD/aUUdL0QAEpiQe7poC6dPO+cmD6g32xkZbJk65WAr5fd2aMFW8XcyOd4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJR5AK/r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJR5AK/r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732DD1F000FF;
	Mon, 28 Sep 2026 08:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585450;
	bh=zIjqRVo0A288No3YfNpwyfvbhhiBP5MH2C1wrtqdLnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fJR5AK/rciTVjijsN1dwB6gu/h/c8XIDl49HQPAAnxPhoemWkOn7z2YPwspGg2fF9
	 D2Z/hRIe1eEUfY4l+b4jlbibq/Ne3OSH4agiXnQ7BlDi2Ak8RByLLJaIGVCPiCXuPP
	 vdrAL+M8YKBP6Mmq3+UzDFYQRSQZ/luipv++Fh3PWT73Ws0Tedghh4pqiuqp5dae1E
	 Z+TSn3c3YQXrh//Hn4x5VW0Wf7GquGis3PSZBx226sGYjj99365cE1EhdnbANio2WM
	 h0OCmEF8zlKrrRRT+jDIUxExbvBlNQVXwV0IAL1c9+gucNJpGv1HMfoy8/WFfA2pSf
	 pSQOWk/PLbqZw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:30 +0200
Subject: [PATCH net-next v2 04/11] net: ethernet: cortina: Index free queue
 fragments with XArray
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-4-758a795d7a78@kernel.org>
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

RX descriptors return the DMA address of the free queue fragment used by
the hardware. The driver currently recovers its page by scanning every
free queue page and comparing address ranges.

This isn't very efficient...

Instead index each fragment in an XArray using its DMA address in
fragment units.

Retain the complete DMA base in the page metadata and validate the exact
fragment address after lookup. Serialize metadata replacement with RX
lookup so the caller obtains the page belonging to the descriptor even
when the queue is being refilled.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 109 ++++++++++++++++++++++++----------
 1 file changed, 79 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index fa5513b53ea8..3d729f4c34ef 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -37,6 +37,7 @@
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/xarray.h>
 
 #include <linux/in.h>
 #include <linux/ip.h>
@@ -165,6 +166,7 @@ struct gemini_ethernet {
 	struct gmac_rxdesc *freeq_ring;
 	dma_addr_t	freeq_dma_base;
 	struct gmac_queue_page	*freeq_pages;
+	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
@@ -724,32 +726,46 @@ static int gmac_setup_rxq(struct net_device *netdev)
 	return 0;
 }
 
-static struct gmac_queue_page *
-gmac_get_queue_page(struct gemini_ethernet *geth, dma_addr_t addr)
+static unsigned long
+geth_freeq_mapping_index(const struct gemini_ethernet *geth,
+			 dma_addr_t mapping)
+{
+	return (unsigned long)(mapping >> geth->freeq_frag_order);
+}
+
+static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
+				      dma_addr_t mapping,
+				      unsigned int *page_offs)
 {
 	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	struct gmac_queue_page *gpage;
-	unsigned int offset;
-	int i;
-
-	if (!geth->freeq_pages) {
-		dev_err_ratelimited(geth->dev,
-				    "try to get page with no page list\n");
-		return NULL;
-	}
+	unsigned long index;
+	unsigned long flags;
+	dma_addr_t page_mapping;
+	struct page *page;
+	bool valid;
 
-	/* Look up a ring buffer page from virtual mapping */
-	for (i = 0; i < geth->num_freeq_pages; i++) {
-		gpage = &geth->freeq_pages[i];
-		if (!gpage->page || addr < gpage->mapping)
-			continue;
+	index = geth_freeq_mapping_index(geth, mapping);
 
-		offset = addr - gpage->mapping;
-		if (offset <= PAGE_SIZE - frag_len &&
-		    !(offset & (frag_len - 1)))
-			return gpage;
-	}
+	spin_lock_irqsave(&geth->freeq_lock, flags);
+	gpage = xa_load(&geth->freeq_mappings, index);
+	if (!gpage || !gpage->page)
+		goto err_unlock;
+
+	page = gpage->page;
+	page_mapping = gpage->mapping;
+	valid = mapping >= page_mapping &&
+		mapping - page_mapping <= PAGE_SIZE - frag_len &&
+		!((mapping - page_mapping) & (frag_len - 1));
+	if (!valid)
+		goto err_unlock;
+
+	*page_offs = mapping - page_mapping;
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+	return page;
 
+err_unlock:
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
 	return NULL;
 }
 
@@ -758,11 +774,12 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
 	struct gmac_rxdesc *rxd = port->rxq_ring;
-	struct gmac_queue_page *gpage;
 	struct nontoe_qhdr __iomem *qhdr;
 	void __iomem *dma_reg;
 	void __iomem *ptr_reg;
+	unsigned int page_offs;
 	dma_addr_t mapping;
+	struct page *page;
 	union dma_rwptr rw;
 	unsigned int r, w;
 
@@ -789,13 +806,13 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 		if (!mapping)
 			continue;
 
-		gpage = gmac_get_queue_page(geth, mapping);
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
@@ -808,10 +825,12 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	struct gmac_rxdesc *freeq_entry;
 	struct gmac_queue_page *gpage;
 	unsigned int fpp_order;
+	unsigned int fragments;
 	unsigned int frag_len;
 	dma_addr_t page_mapping;
 	dma_addr_t mapping;
 	struct page *page;
+	int ret;
 	int i;
 
 	/* First allocate and DMA map a single page */
@@ -842,8 +861,27 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	 */
 	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	/* If the freeq entry already has a page mapped, then unmap it. */
+	fragments = 1 << fpp_order;
+
 	gpage = &geth->freeq_pages[pn];
+	for (i = 0; i < fragments; i++) {
+		mapping = page_mapping + i * frag_len;
+		ret = xa_insert(&geth->freeq_mappings,
+				geth_freeq_mapping_index(geth, mapping),
+				gpage, GFP_ATOMIC);
+		if (ret)
+			goto err_mappings;
+	}
+
+	if (gpage->page) {
+		for (i = 0; i < fragments; i++) {
+			mapping = gpage->mapping + i * frag_len;
+			xa_erase(&geth->freeq_mappings,
+				 geth_freeq_mapping_index(geth, mapping));
+		}
+	}
+
+	/* If the freeq entry already has a page mapped, then unmap it. */
 	if (gpage->page) {
 		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
 				 DMA_FROM_DEVICE);
@@ -870,6 +908,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 		pn, &page_mapping, page);
 
 	return page;
+
+err_mappings:
+	while (i--) {
+		mapping = page_mapping + i * frag_len;
+		xa_erase(&geth->freeq_mappings,
+			 geth_freeq_mapping_index(geth, mapping));
+	}
+	dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
+			 DMA_FROM_DEVICE);
+	put_page(page);
+	return NULL;
 }
 
 /**
@@ -990,6 +1039,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 				 DMA_FROM_DEVICE);
 		put_page(gpage->page);
 	}
+	xa_destroy(&geth->freeq_mappings);
 
 	kfree(geth->freeq_pages);
 err_freeq:
@@ -1027,6 +1077,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 		while (page_ref_count(gpage->page) > 0)
 			put_page(gpage->page);
 	}
+	xa_destroy(&geth->freeq_mappings);
 
 	kfree(geth->freeq_pages);
 
@@ -1471,7 +1522,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
-	struct gmac_queue_page *gpage;
 	unsigned int received = 0;
 	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
@@ -1526,14 +1576,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		gpage = gmac_get_queue_page(geth, mapping);
-		if (!gpage) {
+		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		if (!page) {
 			dev_err_ratelimited(geth->dev,
 					    "could not find mapping\n");
 			goto err_drop;
 		}
-		page = gpage->page;
-		page_offs = mapping - gpage->mapping;
 
 		if (word3.bits32 & SOF_BIT) {
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
@@ -2683,6 +2731,7 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
+	xa_init(&geth->freeq_mappings);
 
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);

-- 
2.55.0

