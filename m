Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450AF489861
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585456; cv=none; b=WO+CaFVq6qJCIR/90ckuUzMHotRlp68ZFwnNGQBWafLUf9RwZf0rK/p/njloO59c6e/h5M09+1RPZqsQmE6XCE64R2odrK9BPAmijNTYTvN/vlheOIJHdrtLXuwrHHVOqQWh3EkXCLUW7hhAzo1mIhNCOJT9UGv6RoXRMIEK22Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585456; c=relaxed/simple;
	bh=NWrfdNZsG0f03XIwxxNXGGsNUWVPeIHSHUKGTGrIYCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oju7JWCYAnLqOTTuk+1vCYmI3Ve3JmJ/O9OiR0STH4/189ZOCNlEI3ofv+MG5wY8TpY1C8FdyPxsSyGtPMi0aKpeAH5R3SMwkFeviyON2m2kVvgRheFQmTjsdn5eV5SjAfmEcpxaeuVJWsIKJY5Jje3P3+bTwLzXTcoeBEncohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F79LlkF3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F79LlkF3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B0A1F00893;
	Mon, 28 Sep 2026 08:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585453;
	bh=vA61/DVSVbwe8HPbazkghtng8FT9Slq0c9vCR/yD7Lg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=F79LlkF3G924w21UCccZBhEo/1qIt06bMxVcPMw4e/L1stLp+dYbi8UqNSxhGeVMm
	 l90WblvjHVbtG8L0bRBXOgpWhTj9FQqMphEQnljZDkpC81aG7MDUHc8STdASdLFxgG
	 IftCLpqHh9kRwSiE2zYZWZrm6/YwzZ/8QQuKGv1FLRyNjfns99mY+MzwNXhgDa9+Sf
	 nniUhy1ahBRmzzi4lGgO+G3hpDC0hzTy1ZxX/SBqFsMmCgv2XT+5imfwAcYUu6hEB3
	 I78dV3EEs2DhWb5/2PvDbuNfw0ixl+16gYrFj0CGTDf1XjN0tLe+qShAbRh9TJR2+Z
	 r0Ji12Wqp3PpQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:31 +0200
Subject: [PATCH net-next v2 05/11] net: ethernet: cortina: Preserve
 in-flight free queue pages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-5-758a795d7a78@kernel.org>
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

The software free queue and the two per-port RX queues have independent
lifetimes. A free queue ring position becomes reusable once hardware has
taken its buffer address, but the resulting RX descriptor can remain
unprocessed for longer.

With the default 2K fragments, the sequence is:

1. Free queue entries 2n and 2n + 1 contain the first and second halves
   of page A.
2. Hardware consumes those entries and copies their DMA addresses into RX
   descriptors, potentially in the RX queues of different ports.
3. The free queue read pointer advances, making entries 2n and 2n + 1
   available for refill.
4. NAPI may not yet have processed the RX descriptors referring to page A,
   so their DMA-to-page association must remain valid.
5. Refilling the same free queue positions with page B must therefore not
   replace the metadata describing page A.

The driver currently indexes page metadata by free queue position. Step 5
therefore overwrites page A's association with page B. When NAPI later
processes an old descriptor containing page A's DMA address, the driver can
no longer find the mapping. This may explain long-standing reports of the
driver failing to find RX mappings.

This is not just caused by splitting a 4K page into two 2K
fragments: the metadata would also have to outlive its free queue position
with one full-page buffer per entry, but the 2K split makes the lifetime more
involved because the two halves of one page are independently consumed and
may be waiting in different port RX queues. The page cannot be unmapped
until both fragment references have been claimed.

Allocate page metadata slots independently of free queue positions and
track occupied slots with a bitmap. Keep each exact fragment DMA address in
the XArray until software claims its descriptor. Once both fragments have
been claimed, unmap the complete page and release the base reference owned
by the free queue.

Give each posted fragment its own page reference. Queue and error cleanup
can then release precisely the outstanding hardware references without
dropping references held by delivered skbs.

Allocate and DMA-map candidate pages before taking the free queue lock.
Re-read the hardware pointers under the lock and publish one complete page
at a time, so refilling no longer performs a potentially multi-megabyte
allocation batch with interrupts disabled.

Require the initial fill to populate every usable queue entry. If mapping
or metadata allocation stops the fill early, rewind the hardware write
pointer, release the partial population and fail setup. Leave the refill
interrupt masked and require a live ring for the resize fast path so a
later open retries queue setup.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 296 ++++++++++++++++++++--------------
 1 file changed, 173 insertions(+), 123 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 3d729f4c34ef..8d216fa45287 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -14,6 +14,7 @@
  * Gary Chen & Ch Hsu Storlink Semiconductor
  */
 #include <linux/kernel.h>
+#include <linux/bitmap.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/net.h>
@@ -88,11 +89,13 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
 /**
  * struct gmac_queue_page - page buffer per-page info
  * @page: the page struct
- * @mapping: the dma address handle
+ * @mapping: DMA address of the first fragment
+ * @fragments: number of fragments not yet claimed from the hardware
  */
 struct gmac_queue_page {
 	struct page *page;
 	dma_addr_t mapping;
+	unsigned int fragments;
 };
 
 struct gmac_txq {
@@ -168,6 +171,7 @@ struct gemini_ethernet {
 	struct gmac_queue_page	*freeq_pages;
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
+	unsigned long	*freeq_page_bitmap;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -733,15 +737,32 @@ geth_freeq_mapping_index(const struct gemini_ethernet *geth,
 	return (unsigned long)(mapping >> geth->freeq_frag_order);
 }
 
-static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
-				      dma_addr_t mapping,
-				      unsigned int *page_offs)
+static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
+{
+	unsigned int slot;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	slot = find_first_zero_bit(geth->freeq_page_bitmap,
+				   geth->num_freeq_pages);
+	if (slot == geth->num_freeq_pages)
+		return -ENOSPC;
+
+	__set_bit(slot, geth->freeq_page_bitmap);
+
+	return slot;
+}
+
+static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
+				     dma_addr_t mapping,
+				     unsigned int *page_offs)
 {
 	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	struct gmac_queue_page *gpage;
 	unsigned long index;
 	unsigned long flags;
 	dma_addr_t page_mapping;
+	unsigned int slot;
 	struct page *page;
 	bool valid;
 
@@ -749,7 +770,7 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
 
 	spin_lock_irqsave(&geth->freeq_lock, flags);
 	gpage = xa_load(&geth->freeq_mappings, index);
-	if (!gpage || !gpage->page)
+	if (!gpage || !gpage->page || !gpage->fragments)
 		goto err_unlock;
 
 	page = gpage->page;
@@ -760,6 +781,17 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
 	if (!valid)
 		goto err_unlock;
 
+	xa_erase(&geth->freeq_mappings, index);
+	if (!--gpage->fragments) {
+		slot = gpage - geth->freeq_pages;
+		dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
+		gpage->page = NULL;
+		gpage->mapping = 0;
+		__clear_bit(slot, geth->freeq_page_bitmap);
+		put_page(page);
+	}
+
 	*page_offs = mapping - page_mapping;
 	spin_unlock_irqrestore(&geth->freeq_lock, flags);
 	return page;
@@ -806,7 +838,7 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 		if (!mapping)
 			continue;
 
-		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		page = geth_freeq_claim(geth, mapping, &page_offs);
 		if (!page) {
 			dev_err(geth->dev, "could not find page\n");
 			continue;
@@ -819,30 +851,22 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 			  port->rxq_ring, port->rxq_dma_base);
 }
 
-static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
-					      int pn)
+static int geth_freeq_map_page(struct gemini_ethernet *geth,
+			       struct page **pagep,
+			       dma_addr_t *page_mappingp)
 {
-	struct gmac_rxdesc *freeq_entry;
-	struct gmac_queue_page *gpage;
-	unsigned int fpp_order;
-	unsigned int fragments;
-	unsigned int frag_len;
 	dma_addr_t page_mapping;
-	dma_addr_t mapping;
 	struct page *page;
-	int ret;
-	int i;
 
-	/* First allocate and DMA map a single page */
 	page = alloc_page(GFP_ATOMIC);
 	if (!page)
-		return NULL;
+		return -ENOMEM;
 
 	page_mapping = dma_map_single(geth->dev, page_address(page),
 				      PAGE_SIZE, DMA_FROM_DEVICE);
 	if (dma_mapping_error(geth->dev, page_mapping)) {
 		put_page(page);
-		return NULL;
+		return -ENOMEM;
 	}
 	if (page_mapping > U32_MAX - (PAGE_SIZE - 1)) {
 		dev_err_ratelimited(geth->dev,
@@ -850,9 +874,34 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 		dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
 				 DMA_FROM_DEVICE);
 		put_page(page);
-		return NULL;
+		return -EOVERFLOW;
 	}
 
+	*pagep = page;
+	*page_mappingp = page_mapping;
+
+	return 0;
+}
+
+static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
+			       struct page *page, dma_addr_t page_mapping)
+{
+	struct gmac_rxdesc *freeq_entry;
+	struct gmac_queue_page *gpage;
+	unsigned int fpp_order;
+	unsigned int fragments;
+	unsigned int frag_len;
+	dma_addr_t mapping;
+	int ret;
+	int slot;
+	int i;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	slot = geth_freeq_alloc_slot(geth);
+	if (slot < 0)
+		return slot;
+
 	/* The assign the page mapping (physical address) to the buffer address
 	 * in the hardware queue. PAGE_SHIFT on ARM is 12 (1 page is 4096 bytes,
 	 * 4k), and the default RX frag order is 11 (fragments are up 20 2048
@@ -863,7 +912,9 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	fragments = 1 << fpp_order;
 
-	gpage = &geth->freeq_pages[pn];
+	gpage = &geth->freeq_pages[slot];
+	gpage->page = page;
+	gpage->mapping = page_mapping;
 	for (i = 0; i < fragments; i++) {
 		mapping = page_mapping + i * frag_len;
 		ret = xa_insert(&geth->freeq_mappings,
@@ -872,28 +923,8 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 		if (ret)
 			goto err_mappings;
 	}
-
-	if (gpage->page) {
-		for (i = 0; i < fragments; i++) {
-			mapping = gpage->mapping + i * frag_len;
-			xa_erase(&geth->freeq_mappings,
-				 geth_freeq_mapping_index(geth, mapping));
-		}
-	}
-
-	/* If the freeq entry already has a page mapped, then unmap it. */
-	if (gpage->page) {
-		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
-				 DMA_FROM_DEVICE);
-		/* This should be the last reference to the page so it gets
-		 * released
-		 */
-		put_page(gpage->page);
-	}
-
-	/* Then put our new mapping into the page table */
-	gpage->mapping = page_mapping;
-	gpage->page = page;
+	gpage->fragments = fragments;
+	page_ref_add(page, fragments);
 
 	freeq_entry = geth->freeq_ring + (pn << fpp_order);
 	dev_dbg(geth->dev, "allocate page %d fragment length %d fragments per page %d, freeq entry %p\n",
@@ -907,7 +938,7 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	dev_dbg(geth->dev, "page %d, DMA addr: %pad, page %p\n",
 		pn, &page_mapping, page);
 
-	return page;
+	return 0;
 
 err_mappings:
 	while (i--) {
@@ -915,20 +946,20 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 		xa_erase(&geth->freeq_mappings,
 			 geth_freeq_mapping_index(geth, mapping));
 	}
-	dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
-			 DMA_FROM_DEVICE);
-	put_page(page);
-	return NULL;
+	gpage->page = NULL;
+	gpage->mapping = 0;
+	__clear_bit(slot, geth->freeq_page_bitmap);
+	return ret;
 }
 
 /**
  * geth_fill_freeq() - Fill the freeq with empty fragments to use
  * @geth: the ethernet adapter
- * @refill: whether to reset the queue by filling in all freeq entries or
- * just refill it, usually the interrupt to refill the queue happens when
- * the queue is half empty.
+ *
+ * Usually the interrupt to refill the queue happens when the queue is half
+ * empty.
  */
-static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
+static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	unsigned int count = 0;
@@ -940,47 +971,71 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 	/* Mask for page */
 	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
 
-	spin_lock_irqsave(&geth->freeq_lock, flags);
-
-	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
-	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
-	epn = (rw.bits.rptr >> fpp_order) - 1;
-	epn &= m_pn;
-
 	/* Loop over the freeq ring buffer entries */
-	while (pn != epn) {
-		struct gmac_queue_page *gpage;
+	for (;;) {
+		dma_addr_t page_mapping;
 		struct page *page;
+		int ret;
 
-		gpage = &geth->freeq_pages[pn];
-		page = gpage->page;
+		ret = geth_freeq_map_page(geth, &page, &page_mapping);
+		if (ret)
+			break;
 
-		dev_dbg(geth->dev, "fill entry %d page ref count %d add %d refs\n",
-			pn, page_ref_count(page), 1 << fpp_order);
+		spin_lock_irqsave(&geth->freeq_lock, flags);
 
-		if (page_ref_count(page) > 1) {
-			unsigned int fl = (pn - epn) & m_pn;
+		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+		pn = rw.bits.wptr >> fpp_order;
+		epn = (rw.bits.rptr >> fpp_order) - 1;
+		epn &= m_pn;
+		if (pn == epn) {
+			ret = -ENOSPC;
+		} else {
+			ret = geth_freeq_add_page(geth, pn, page,
+						  page_mapping);
+			if (!ret) {
+				count += 1 << fpp_order;
+				pn++;
+				pn &= m_pn;
+				writew(pn << fpp_order,
+				       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+			}
+		}
 
-			if (fl > 64 >> fpp_order)
-				break;
+		spin_unlock_irqrestore(&geth->freeq_lock, flags);
 
-			page = geth_freeq_alloc_map_page(geth, pn);
-			if (!page)
-				break;
+		if (ret) {
+			dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
+					 DMA_FROM_DEVICE);
+			put_page(page);
+			break;
 		}
-
-		/* Add one reference per fragment in the page */
-		page_ref_add(page, 1 << fpp_order);
-		count += 1 << fpp_order;
-		pn++;
-		pn &= m_pn;
 	}
 
-	writew(pn << fpp_order, geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+	return count;
+}
 
-	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+static void geth_freeq_release_pages(struct gemini_ethernet *geth)
+{
+	unsigned int pn;
 
-	return count;
+	for (pn = 0; pn < geth->num_freeq_pages; pn++) {
+		struct gmac_queue_page *gpage;
+		struct page *page;
+
+		gpage = &geth->freeq_pages[pn];
+		if (!gpage->page)
+			continue;
+
+		page = gpage->page;
+		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
+				 DMA_FROM_DEVICE);
+		while (gpage->fragments) {
+			put_page(page);
+			gpage->fragments--;
+		}
+		put_page(page);
+	}
+	xa_destroy(&geth->freeq_mappings);
 }
 
 static int geth_setup_freeq(struct gemini_ethernet *geth)
@@ -988,10 +1043,16 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
+	unsigned int page_slots = pages;
+	unsigned int expected;
 	union queue_threshold qt;
 	union dma_skb_size skbsz;
 	unsigned int filled;
-	unsigned int pn;
+
+	if (geth->port0)
+		page_slots += 1 << geth->port0->rxq_order;
+	if (geth->port1)
+		page_slots += 1 << geth->port1->rxq_order;
 
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1004,19 +1065,18 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	}
 
 	/* Allocate a mapping to page look-up index */
-	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);
+	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, page_slots);
 	if (!geth->freeq_pages)
 		goto err_freeq;
-	geth->num_freeq_pages = pages;
+	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
+	if (!geth->freeq_page_bitmap)
+		goto err_freeq_pages;
+	geth->num_freeq_pages = page_slots;
 
-	dev_info(geth->dev, "allocate %d pages for queue\n", pages);
-	for (pn = 0; pn < pages; pn++)
-		if (!geth_freeq_alloc_map_page(geth, pn))
-			goto err_freeq_alloc;
-
-	filled = geth_fill_freeq(geth, false);
-	if (!filled)
-		goto err_freeq_alloc;
+	expected = len - (1 << fpp_order);
+	filled = geth_fill_freeq(geth);
+	if (filled != expected)
+		goto err_freeq_bitmap;
 
 	qt.bits32 = readl(geth->base + GLOBAL_QUEUE_THRESHOLD_REG);
 	qt.bits.swfq_empty = 32;
@@ -1029,19 +1089,16 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 
 	return 0;
 
-err_freeq_alloc:
-	while (pn > 0) {
-		struct gmac_queue_page *gpage;
-
-		--pn;
-		gpage = &geth->freeq_pages[pn];
-		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
-				 DMA_FROM_DEVICE);
-		put_page(gpage->page);
-	}
-	xa_destroy(&geth->freeq_mappings);
-
+err_freeq_bitmap:
+	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
+	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+	geth_freeq_release_pages(geth);
+	bitmap_free(geth->freeq_page_bitmap);
+	geth->freeq_page_bitmap = NULL;
+err_freeq_pages:
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1056,11 +1113,6 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
  */
 static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 {
-	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int len = 1 << geth->freeq_order;
-	unsigned int pages = len >> fpp_order;
-	unsigned int pn;
-
 	if (!geth->freeq_ring)
 		return;
 
@@ -1068,22 +1120,18 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
 
-	for (pn = 0; pn < pages; pn++) {
-		struct gmac_queue_page *gpage;
-
-		gpage = &geth->freeq_pages[pn];
-		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
-				 DMA_FROM_DEVICE);
-		while (page_ref_count(gpage->page) > 0)
-			put_page(gpage->page);
-	}
-	xa_destroy(&geth->freeq_mappings);
+	geth_freeq_release_pages(geth);
 
+	bitmap_free(geth->freeq_page_bitmap);
+	geth->freeq_page_bitmap = NULL;
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
 			  geth->freeq_ring, geth->freeq_dma_base);
+	geth->freeq_ring = NULL;
 }
 
 static void geth_set_freeq_irq(struct gemini_ethernet *geth, bool enable)
@@ -1145,7 +1193,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	new_order = min(15, ilog2(new_size - 1) + 1);
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (geth->freeq_order == new_order)
+	if (geth->freeq_ring && geth->freeq_order == new_order)
 		return 0;
 
 	/* The threaded handler can already be running and re-enable the IRQ. */
@@ -1160,6 +1208,8 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	/* Allocate a new queue with the desired order */
 	geth->freeq_order = new_order;
 	ret = geth_setup_freeq(geth);
+	if (ret)
+		return ret;
 
 	/* Restart the interrupts - NOTE if this is the first resize
 	 * after probe(), this is where the interrupts get turned on
@@ -1576,7 +1626,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		page = geth_freeq_claim(geth, mapping, &page_offs);
 		if (!page) {
 			dev_err_ratelimited(geth->dev,
 					    "could not find mapping\n");
@@ -1673,7 +1723,7 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
-		geth_fill_freeq(geth, true);
+		geth_fill_freeq(geth);
 	}
 
 	if (!reschedule && received < budget &&
@@ -2403,7 +2453,7 @@ static irqreturn_t gemini_port_irq_thread(int irq, void *data)
 
 	geth = port->geth;
 	/* The queue is half empty so refill it */
-	geth_fill_freeq(geth, true);
+	geth_fill_freeq(geth);
 
 	spin_lock_irqsave(&geth->irq_lock, flags);
 	/* ACK queue interrupt */

-- 
2.55.0

