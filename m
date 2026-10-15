Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048F854281E
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077876; cv=none; b=OypztXhalO4nBBA2438j0MS6mpClYZziiPEVi6wGqEA0n08acf3w0kxGvnH0KPsOLsNUmmbgadSR2SVFl0dixBF38kQUKkOJAegwgJLDPFUEDkHIC02yrPSxKQGgFzaqPkw6j2a3oSV51rtWq+5x5376kmXzns5OG9A9D8NPcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077876; c=relaxed/simple;
	bh=6yGXvV2HUB+DkwJpsSCQI0BA34Z/d0U5iB5QfXmVWpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BOjjwoS1OWwvmDvMVA00jw3EWBJb/ycqScKLxjzHUVHypdmRShCp8wO+RIgGNKuBaROXo5nHhZsx1sxYoZIpGHLvwrUPdOY/e9tFizqTlLnnhCmBqBFo7rzNGFWRJTFR2TdkRnr3PQfsDoXnS9CNA6ESHVbmm2uqP2ZgO6YpCaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaPwcsx6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaPwcsx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A741F000C6;
	Thu, 15 Oct 2026 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077867;
	bh=/pvCgzi4aysS9l5LAzvnxJorbJN5QtmapfJiA41ur6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gaPwcsx6zVt6hskyXw0rJQg83F+bka3g/6YdUnxa1cb5ZloVjye2ip1k9nK/faWgd
	 +QABEu+wu3ttHpynJonssqN752Dy+4h+oJXFGp1mMzI3O/vgZ3OiwaLf6plx3QInLT
	 koU2VjmfQoXJJSo/su83KvF8QsBPJcJ2hvOS2QNEXZvMsXrCgd3m2EODNVxGLIC9IA
	 XYk6trXm7v3q9YnQU0shPzdrayZU1dKgDqqpPiDZNB5fUtmBLHUp6Bc8hLzO5+UCUG
	 /9ELlsfga8MO3ngvyisalgF8aZdlpvg2k4ZIXEe31vwD1SEwiI/uM3kir/6cZxPfnT
	 lRhrcd49rvAdA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:07 +0200
Subject: [PATCH net-next v5 07/14] net: ethernet: cortina: Preserve
 in-flight free queue pages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-7-b5c9e2f7b8a3@kernel.org>
References: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
In-Reply-To: <20261015-gemini-ethernet-fixes-3-v5-0-b5c9e2f7b8a3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
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
fragments: the metadata would also have to outlive its free queue
position with one full-page buffer per entry, but the 2K split makes
the lifetime more involved because the two halves of one page are
independently consumed and may be waiting in different port RX queues.
The page cannot be unmapped until both fragment references have been
claimed.

Allocate page metadata slots independently of free queue positions and
track occupied slots with a bitmap. Keep each exact fragment DMA address in
the XArray until software claims its descriptor.

The pages use streaming DMA_FROM_DEVICE mappings. Synchronize each
fragment when claimed and unmap the page with DMA_ATTR_SKIP_CPU_SYNC after
both are claimed. This has no known visible effect on Gemini's FA526,
where CPU sync is currently a no-op, but follows the DMA API and avoids
resynchronizing a sibling on other implementations. During teardown,
synchronize only fragments still owned by hardware.

Give each posted fragment its own page reference. Queue and error cleanup
can then release precisely the outstanding hardware references without
dropping references held by delivered skbs.

Allocate and DMA-map each candidate page before taking the free queue
lock, then re-read the hardware pointers and publish one complete page at
a time. The old refill path reused pages by queue position and only
allocated replacements once the queued fill fell to 64 descriptors or
fewer. This change instead allocates replacements until the ring is full.
A later patch restores recycling independently of queue position.

Size the metadata pool for the shared free queue and both registered RX
rings. Include that capacity in resize decisions, reuse an oversized queue
only while the peer is running, and roll back rejected RX ring changes.
This prevents same-order ring growth from exhausting page slots and lets
downsizing release surplus pages when both ports are idle.

Reject queue geometries that cannot post one complete page before tearing
down the existing queue. Require the initial fill to populate every usable
queue entry. If mapping or metadata allocation stops the fill early,
rewind the hardware write pointer, release the partial population and fail
setup.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 357 +++++++++++++++++++++-------------
 1 file changed, 226 insertions(+), 131 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index c1c42e1f93f4..faab1bb865ab 100644
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
@@ -89,11 +90,13 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
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
@@ -170,6 +173,7 @@ struct gemini_ethernet {
 	struct gmac_queue_page	*freeq_pages;
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
+	unsigned long	*freeq_page_bitmap;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -735,15 +739,32 @@ geth_freeq_mapping_index(const struct gemini_ethernet *geth,
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
 
@@ -751,7 +772,7 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
 
 	spin_lock_irqsave(&geth->freeq_lock, flags);
 	gpage = xa_load(&geth->freeq_mappings, index);
-	if (!gpage || !gpage->page)
+	if (!gpage || !gpage->page || !gpage->fragments)
 		goto err_unlock;
 
 	page = gpage->page;
@@ -762,6 +783,21 @@ static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
 	if (!valid)
 		goto err_unlock;
 
+	dma_sync_single_range_for_cpu(geth->dev, page_mapping,
+				      mapping - page_mapping, frag_len,
+				      DMA_FROM_DEVICE);
+	xa_erase(&geth->freeq_mappings, index);
+	if (!--gpage->fragments) {
+		slot = gpage - geth->freeq_pages;
+		dma_unmap_single_attrs(geth->dev, page_mapping, PAGE_SIZE,
+				       DMA_FROM_DEVICE,
+				       DMA_ATTR_SKIP_CPU_SYNC);
+		gpage->page = NULL;
+		gpage->mapping = 0;
+		__clear_bit(slot, geth->freeq_page_bitmap);
+		put_page(page);
+	}
+
 	*page_offs = mapping - page_mapping;
 	spin_unlock_irqrestore(&geth->freeq_lock, flags);
 	return page;
@@ -808,7 +844,7 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 		if (!mapping)
 			continue;
 
-		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		page = geth_freeq_claim(geth, mapping, &page_offs);
 		if (!page) {
 			dev_err(geth->dev, "could not find page\n");
 			continue;
@@ -821,32 +857,22 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
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
 
-	lockdep_assert_held(&geth->freeq_lock);
-
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
@@ -854,9 +880,34 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -867,7 +918,9 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	fragments = 1 << fpp_order;
 
-	gpage = &geth->freeq_pages[pn];
+	gpage = &geth->freeq_pages[slot];
+	gpage->page = page;
+	gpage->mapping = page_mapping;
 	for (i = 0; i < fragments; i++) {
 		mapping = page_mapping + i * frag_len;
 		ret = xa_insert(&geth->freeq_mappings,
@@ -876,19 +929,8 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -902,7 +944,7 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	dev_dbg(geth->dev, "page %d, DMA addr: %pad, page %p\n",
 		pn, &page_mapping, page);
 
-	return page;
+	return 0;
 
 err_mappings:
 	while (i--) {
@@ -910,20 +952,20 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -935,63 +977,124 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 	/* Mask for page */
 	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
 
-	spin_lock_irqsave(&geth->freeq_lock, flags);
-
-	rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
-	pn = (refill ? rw.bits.wptr : rw.bits.rptr) >> fpp_order;
-	pn &= m_pn;
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
+		spin_lock_irqsave(&geth->freeq_lock, flags);
+		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+		pn = (rw.bits.wptr >> fpp_order) & m_pn;
+		epn = (rw.bits.rptr >> fpp_order) - 1;
+		epn &= m_pn;
+		spin_unlock_irqrestore(&geth->freeq_lock, flags);
+		if (pn == epn)
+			break;
 
-		dev_dbg(geth->dev, "fill entry %d page ref count %d add %d refs\n",
-			pn, page_ref_count(page), 1 << fpp_order);
+		ret = geth_freeq_map_page(geth, &page, &page_mapping);
+		if (ret)
+			break;
+
+		spin_lock_irqsave(&geth->freeq_lock, flags);
 
-		if (page_ref_count(page) > 1) {
-			unsigned int fl = (pn - epn) & m_pn;
+		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+		pn = (rw.bits.wptr >> fpp_order) & m_pn;
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
+	}
+
+	return count;
+}
+
+static void geth_freeq_release_pages(struct gemini_ethernet *geth)
+{
+	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	unsigned int frag_len = 1 << geth->freeq_frag_order;
+	unsigned int pn;
 
-		/* Add one reference per fragment in the page */
-		page_ref_add(page, 1 << fpp_order);
-		count += 1 << fpp_order;
-		pn++;
-		pn &= m_pn;
+	for (pn = 0; pn < geth->num_freeq_pages; pn++) {
+		struct gmac_queue_page *gpage;
+		dma_addr_t mapping;
+		struct page *page;
+		unsigned int i;
+
+		gpage = &geth->freeq_pages[pn];
+		if (!gpage->page)
+			continue;
+
+		page = gpage->page;
+		for (i = 0; i < (1 << fpp_order); i++) {
+			mapping = gpage->mapping + i * frag_len;
+			if (xa_load(&geth->freeq_mappings,
+				    geth_freeq_mapping_index(geth, mapping)) != gpage)
+				continue;
+
+			dma_sync_single_range_for_cpu(geth->dev, gpage->mapping,
+						      i * frag_len, frag_len,
+						      DMA_FROM_DEVICE);
+		}
+		dma_unmap_single_attrs(geth->dev, gpage->mapping, PAGE_SIZE,
+				       DMA_FROM_DEVICE,
+				       DMA_ATTR_SKIP_CPU_SYNC);
+		while (gpage->fragments) {
+			put_page(page);
+			gpage->fragments--;
+		}
+		put_page(page);
 	}
+	xa_destroy(&geth->freeq_mappings);
+}
 
-	writew(pn << fpp_order, geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+static unsigned int
+geth_freeq_page_slots(struct gemini_ethernet *geth, unsigned int order)
+{
+	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	unsigned int slots = 1 << (order - fpp_order);
 
-	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+	if (geth->port0 && geth->port0->netdev)
+		slots += 1 << geth->port0->rxq_order;
+	if (geth->port1 && geth->port1->netdev)
+		slots += 1 << geth->port1->rxq_order;
 
-	return count;
+	return slots;
 }
 
 static int geth_setup_freeq(struct gemini_ethernet *geth)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
-	unsigned int pages = len >> fpp_order;
+	unsigned int page_slots;
+	unsigned int expected;
 	union queue_threshold qt;
 	union dma_skb_size skbsz;
-	unsigned long flags;
-	struct page *page;
 	unsigned int filled;
-	unsigned int pn;
 	u16 rptr;
 
+	page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
+
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
 		&geth->freeq_dma_base, GFP_KERNEL);
@@ -1003,27 +1106,22 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	}
 
 	/* Allocate page metadata referenced by the mapping index */
-	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);
+	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, page_slots);
 	if (!geth->freeq_pages)
 		goto err_freeq;
-	geth->num_freeq_pages = pages;
-
-	dev_info(geth->dev, "allocate %d pages for queue\n", pages);
-	for (pn = 0; pn < pages; pn++) {
-		spin_lock_irqsave(&geth->freeq_lock, flags);
-		page = geth_freeq_alloc_map_page(geth, pn);
-		spin_unlock_irqrestore(&geth->freeq_lock, flags);
-		if (!page)
-			goto err_freeq_alloc;
-	}
+	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
+	if (!geth->freeq_page_bitmap)
+		goto err_freeq_pages;
+	geth->num_freeq_pages = page_slots;
 
 	/* Match the software pointer to the retained hardware pointer. */
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
 
-	filled = geth_fill_freeq(geth, false);
-	if (!filled)
-		goto err_freeq_alloc;
+	expected = len - (1 << fpp_order);
+	filled = geth_fill_freeq(geth);
+	if (filled != expected)
+		goto err_freeq_bitmap;
 
 	qt.bits32 = readl(geth->base + GLOBAL_QUEUE_THRESHOLD_REG);
 	qt.bits.swfq_empty = 32;
@@ -1036,18 +1134,13 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 
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
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
@@ -1065,11 +1158,6 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
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
 
@@ -1077,17 +1165,10 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
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
 	geth->freeq_pages = NULL;
 	geth->num_freeq_pages = 0;
@@ -1127,7 +1208,9 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	struct net_device *netdev = port->netdev;
 	struct gemini_ethernet_port *other_port;
 	struct net_device *other_netdev;
+	bool other_running;
 	unsigned int new_size = 0;
+	unsigned int page_slots;
 	unsigned int new_order;
 	u16 rptr;
 	int ret;
@@ -1143,9 +1226,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	else
 		other_port = geth->port0;
 	other_netdev = other_port ? other_port->netdev : NULL;
-
-	if (other_netdev && netif_running(other_netdev))
-		return -EBUSY;
+	other_running = other_netdev && netif_running(other_netdev);
 
 	new_size = 1 << (port->rxq_order + 1);
 	netdev_dbg(netdev, "port %d size: %d order %d\n",
@@ -1167,8 +1248,19 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	new_order = max_t(unsigned int, new_order, fls(rptr));
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (geth->freeq_ring && geth->freeq_order == new_order)
-		return 0;
+	if (new_order <= PAGE_SHIFT - geth->freeq_frag_order)
+		return -EINVAL;
+
+	if (geth->freeq_ring) {
+		page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
+		if (geth->num_freeq_pages >= page_slots &&
+		    (geth->freeq_order == new_order ||
+		     (other_running && geth->freeq_order > new_order)))
+			return 0;
+	}
+
+	if (other_running)
+		return -EBUSY;
 
 	disable_irq(geth->port1->irq);
 	geth_set_freeq_irq(geth, false);
@@ -1595,7 +1687,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		page = geth_freeq_lookup(geth, mapping, &page_offs);
+		page = geth_freeq_claim(geth, mapping, &page_offs);
 		if (!page) {
 			dev_err_ratelimited(geth->dev,
 					    "could not find mapping\n");
@@ -1692,7 +1784,7 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
-		geth_fill_freeq(geth, true);
+		geth_fill_freeq(geth);
 	}
 
 	if (!reschedule && received < budget &&
@@ -1947,10 +2039,7 @@ static int gmac_open(struct net_device *netdev)
 	phy_start(netdev->phydev);
 
 	err = geth_resize_freeq(port);
-	/* It's fine if it's just busy, the other port has set up
-	 * the freeq in that case.
-	 */
-	if (err && (err != -EBUSY)) {
+	if (err) {
 		netdev_err(netdev, "could not resize freeq\n");
 		goto err_stop_phy;
 	}
@@ -2309,14 +2398,20 @@ static int gmac_set_ringparam(struct net_device *netdev,
 			      struct netlink_ext_ack *extack)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
+	unsigned int old_rxq_order;
 	int err = 0;
 
 	if (netif_running(netdev))
 		return -EBUSY;
 
 	if (rp->rx_pending) {
+		old_rxq_order = port->rxq_order;
 		port->rxq_order = min(15, ilog2(rp->rx_pending - 1) + 1);
 		err = geth_resize_freeq(port);
+		if (err) {
+			port->rxq_order = old_rxq_order;
+			return err;
+		}
 	}
 	if (rp->tx_pending) {
 		port->txq_order = min(15, ilog2(rp->tx_pending - 1) + 1);
@@ -2422,7 +2517,7 @@ static irqreturn_t gemini_port_irq_thread(int irq, void *data)
 
 	geth = port->geth;
 	/* The queue is half empty so refill it */
-	geth_fill_freeq(geth, true);
+	geth_fill_freeq(geth);
 
 	spin_lock_irqsave(&geth->irq_lock, flags);
 	/* ACK queue interrupt */

-- 
2.56.0

