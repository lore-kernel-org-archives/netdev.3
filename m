Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4228CF4A
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937349; cv=none; b=onBSe73813ki8oilzGf510ZtyT0q8pxUQGp9f7ABc8omPQqrJoNu1T7lv3wq1xV0b8+z/j+PF6rOyRSZs9RcgI+BQsWEymgt4FhiwRdXn+jUmrQiIXocqcKcGlaO6ghCQOs7Yk92UwvIxMFmJA0P14p0XVgck3X/bzyYOOcGpl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937349; c=relaxed/simple;
	bh=KzJ5tLUOaRpCtteSVd/mfpSMrU/wtxNgUjejY5qw0xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyhSnlU/5S7REF4O84XzeAA0RAPq18tiY65wMn/hISEHYErnOOqR3+ZfVVnKxSlxPNXccHXdtG2kOzH6okLV9sYHx1tgIU556VvUbuZiou8DSLKPU/9EBdFL6/cWZlsDBS8KU60iTFz9q52BhZOlSJmG/7YWGdiXHXGBd4RIzRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceXT/MWn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceXT/MWn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2E11F000FF;
	Sun, 20 Sep 2026 20:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789937347;
	bh=s+zEvT9Dox5lHMOj68BOXKJL+zfBSVyuGpgjk53jX3M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ceXT/MWnM9Nlgkw5elD5zBTuDebtbGE+62v+RWH2IgCF+e2sY+OVwhmpE2un2H0Va
	 4zpf0iSo66J22pIv93JzXDob6lQu4kwxekNiTS0rq2gEmsLea2xU+3T5TtPvDQUB+c
	 VQe5yZWP5RUySbDF16KN7OKHkdrKZPputi6DDw9waQ/xisznjl1ijcPLj62gAc9FwX
	 y2QYLu22lBKLL+gt4yBWdpB7uGxt+noQZQu5oRSrbB44dD5z+stuKEWWWtLhQ/Vgk8
	 bygbLeZpOR1pjHJKMk63NXYs/Sb3X+Pk/X7XDNSnO335/FsoQkqeB8jZSWsnbQwWCh
	 iXZDVj338FO5w==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 20 Sep 2026 22:48:52 +0200
Subject: [PATCH net-next 2/3] net: ethernet: cortina: Manage RX buffers
 with page_pool
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-gemini-ethernet-fixes-3-v1-2-3a2a50a83d89@kernel.org>
References: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
In-Reply-To: <20260920-gemini-ethernet-fixes-3-v1-0-3a2a50a83d89@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

The Gemini software free queue supplies page fragments to the RX queues
of both Ethernet ports. Its current buffer lifecycle does not obey the
streaming DMA API.

Each page is mapped for PAGE_SIZE, but replacement overwrites the free
queue entry before reading its old DMA address. It consequently unmaps
the new page for only one fragment and leaks the old mapping. The RX path
also hands device-written data to the stack without a sync for the CPU,
and teardown drops page references that can still belong to skbs.

Create one page_pool owned by the parent Ethernet device. Let it map and
sync whole pages for the device, and split each page into free queue
fragments with the page_pool fragment API.

The RX descriptor software ID comes from the classification hash table,
not the free queue. Index every fragment by its DMA address in fragment
units so RX can recover the page and fragment offset from the buffer
address returned by hardware without relying on DMA address masking.
Validate the complete DMA address before removing the indexed fragment.

Sync each received fragment for the CPU before attaching it to an skb,
mark completed skbs for page_pool recycling, and return dropped or
unclaimed fragments through the pool. Free a partial skb when stopping a
port and let page_pool defer final destruction while delivered skbs still
hold fragments.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/Kconfig  |   1 +
 drivers/net/ethernet/cortina/gemini.c | 368 +++++++++++++++++++++-------------
 2 files changed, 233 insertions(+), 136 deletions(-)

diff --git a/drivers/net/ethernet/cortina/Kconfig b/drivers/net/ethernet/cortina/Kconfig
index aaf9e294b70b..e69140fe3187 100644
--- a/drivers/net/ethernet/cortina/Kconfig
+++ b/drivers/net/ethernet/cortina/Kconfig
@@ -17,6 +17,7 @@ config GEMINI_ETHERNET
 	depends on HAS_IOMEM
 	select PHYLIB
 	select CRC32
+	select PAGE_POOL
 	help
 	  This driver supports StorLink SL351x (Gemini) dual Gigabit Ethernet.
 
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 31bcd41c17fa..6d5f7dacf12a 100644
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
@@ -37,11 +38,13 @@
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/xarray.h>
 
 #include <linux/in.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <net/gro.h>
+#include <net/page_pool/helpers.h>
 
 #include "gemini.h"
 
@@ -87,11 +90,13 @@ MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
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
@@ -164,8 +169,12 @@ struct gemini_ethernet {
 	unsigned int	freeq_frag_order;
 	struct gmac_rxdesc *freeq_ring;
 	dma_addr_t	freeq_dma_base;
+	struct page_pool *freeq_pool;
 	struct gmac_queue_page	*freeq_pages;
+	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
+	unsigned long	*freeq_page_bitmap;
+	unsigned int	freeq_page_cursor;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -724,31 +733,91 @@ static int gmac_setup_rxq(struct net_device *netdev)
 	return 0;
 }
 
-static struct gmac_queue_page *
-gmac_get_queue_page(struct gemini_ethernet *geth,
-		    struct gemini_ethernet_port *port,
-		    dma_addr_t addr)
+static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 {
-	struct gmac_queue_page *gpage;
-	dma_addr_t mapping;
-	int i;
+	unsigned int slot;
 
-	/* Only look for even pages */
-	mapping = addr & PAGE_MASK;
+	lockdep_assert_held(&geth->freeq_lock);
 
-	if (!geth->freeq_pages) {
-		dev_err_ratelimited(geth->dev,
-				    "try to get page with no page list\n");
-		return NULL;
+	slot = find_next_zero_bit(geth->freeq_page_bitmap,
+				  geth->num_freeq_pages,
+				  geth->freeq_page_cursor);
+	if (slot == geth->num_freeq_pages) {
+		slot = find_first_zero_bit(geth->freeq_page_bitmap,
+					   geth->freeq_page_cursor);
+		if (slot == geth->freeq_page_cursor)
+			return -ENOSPC;
 	}
 
-	/* Look up a ring buffer page from virtual mapping */
-	for (i = 0; i < geth->num_freeq_pages; i++) {
-		gpage = &geth->freeq_pages[i];
-		if (gpage->mapping == mapping)
-			return gpage;
+	__set_bit(slot, geth->freeq_page_bitmap);
+	geth->freeq_page_cursor = slot + 1;
+	if (geth->freeq_page_cursor == geth->num_freeq_pages)
+		geth->freeq_page_cursor = 0;
+
+	return slot;
+}
+
+static unsigned long
+geth_freeq_mapping_index(const struct gemini_ethernet *geth,
+			 dma_addr_t mapping)
+{
+	return (unsigned long)(mapping >> geth->freeq_frag_order);
+}
+
+static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
+				     dma_addr_t mapping,
+				     unsigned int *page_offs)
+{
+	unsigned int frag_len = 1 << geth->freeq_frag_order;
+	struct gmac_queue_page *gpage;
+	unsigned long index;
+	unsigned long flags;
+	dma_addr_t page_mapping;
+	unsigned int slot;
+	struct page *page;
+	bool valid;
+
+	index = geth_freeq_mapping_index(geth, mapping);
+
+	spin_lock_irqsave(&geth->freeq_lock, flags);
+	gpage = xa_load(&geth->freeq_mappings, index);
+	if (!gpage)
+		goto err_unlock;
+
+	page = gpage->page;
+	if (!page || !gpage->fragments)
+		goto err_unlock;
+
+	page_mapping = page_pool_get_dma_addr(page);
+	valid = page_mapping == gpage->mapping &&
+		mapping >= page_mapping &&
+		mapping - page_mapping <= PAGE_SIZE - frag_len &&
+		!((mapping - page_mapping) & (frag_len - 1));
+	if (!valid)
+		goto err_invalid;
+
+	xa_erase(&geth->freeq_mappings, index);
+	if (!--gpage->fragments) {
+		slot = gpage - geth->freeq_pages;
+		gpage->page = NULL;
+		gpage->mapping = 0;
+		__clear_bit(slot, geth->freeq_page_bitmap);
 	}
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+
+	*page_offs = mapping - page_mapping;
+	return page;
+
+err_invalid:
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+	dev_err_ratelimited(geth->dev, "invalid freeq mapping %pad\n",
+			    &mapping);
+	return NULL;
 
+err_unlock:
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+	dev_err_ratelimited(geth->dev, "untracked freeq mapping %pad\n",
+			    &mapping);
 	return NULL;
 }
 
@@ -757,11 +826,12 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
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
 
@@ -782,84 +852,100 @@ static void gmac_cleanup_rxq(struct net_device *netdev)
 	 */
 	while (r != w) {
 		mapping = rxd[r].word2.buf_adr;
+		if (mapping) {
+			page = geth_freeq_claim(geth, mapping,
+						&page_offs);
+			if (page)
+				page_pool_put_full_page(geth->freeq_pool,
+							page, false);
+		}
+
 		r++;
 		r &= ((1 << port->rxq_order) - 1);
-
-		if (!mapping)
-			continue;
-
-		/* Freeq pointers are one page off */
-		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
-		if (!gpage) {
-			dev_err(geth->dev, "could not find page\n");
-			continue;
-		}
-		/* Release the RX queue reference to the page */
-		put_page(gpage->page);
 	}
 
 	dma_free_coherent(geth->dev, sizeof(*port->rxq_ring) << port->rxq_order,
 			  port->rxq_ring, port->rxq_dma_base);
 }
 
-static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
-					      int pn)
+static int geth_freeq_alloc_page(struct gemini_ethernet *geth, unsigned int pn)
 {
 	struct gmac_rxdesc *freeq_entry;
 	struct gmac_queue_page *gpage;
+	unsigned int fragments;
 	unsigned int fpp_order;
 	unsigned int frag_len;
+	dma_addr_t page_mapping;
 	dma_addr_t mapping;
 	struct page *page;
-	int i;
+	int ret;
+	int slot;
+	unsigned int i;
 
-	/* First allocate and DMA map a single page */
-	page = alloc_page(GFP_ATOMIC);
+	page = page_pool_dev_alloc_pages(geth->freeq_pool);
 	if (!page)
-		return NULL;
+		return -ENOMEM;
 
-	mapping = dma_map_single(geth->dev, page_address(page),
-				 PAGE_SIZE, DMA_FROM_DEVICE);
-	if (dma_mapping_error(geth->dev, mapping)) {
-		put_page(page);
-		return NULL;
+	slot = geth_freeq_alloc_slot(geth);
+	if (slot < 0) {
+		page_pool_put_full_page(geth->freeq_pool, page, false);
+		return slot;
 	}
 
-	/* The assign the page mapping (physical address) to the buffer address
-	 * in the hardware queue. PAGE_SHIFT on ARM is 12 (1 page is 4096 bytes,
-	 * 4k), and the default RX frag order is 11 (fragments are up 20 2048
-	 * bytes, 2k) so fpp_order (fragments per page order) is default 1. Thus
-	 * each page normally needs two entries in the queue.
+	/* PAGE_SHIFT is 12 on Gemini, while the default fragment order is 11,
+	 * so each page normally supplies two free queue entries.
 	 */
 	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	fragments = 1 << fpp_order;
 	freeq_entry = geth->freeq_ring + (pn << fpp_order);
+	page_mapping = page_pool_get_dma_addr(page);
+	if (page_mapping > U32_MAX - (PAGE_SIZE - 1)) {
+		dev_err_ratelimited(geth->dev,
+				    "freeq DMA mapping exceeds 32 bits\n");
+		ret = -EOVERFLOW;
+		goto err_slot;
+	}
+
+	gpage = &geth->freeq_pages[slot];
+	gpage->page = page;
+	gpage->mapping = page_mapping;
+	for (i = 0; i < fragments; i++) {
+		mapping = page_mapping + i * frag_len;
+		ret = xa_insert(&geth->freeq_mappings,
+				geth_freeq_mapping_index(geth, mapping),
+				gpage, GFP_ATOMIC);
+		if (ret)
+			goto err_mappings;
+	}
+
+	gpage->fragments = fragments;
+	page_pool_fragment_page(page, fragments);
+
 	dev_dbg(geth->dev, "allocate page %d fragment length %d fragments per page %d, freeq entry %p\n",
-		 pn, frag_len, (1 << fpp_order), freeq_entry);
-	for (i = (1 << fpp_order); i > 0; i--) {
-		freeq_entry->word2.buf_adr = mapping;
+		 pn, frag_len, fragments, freeq_entry);
+	mapping = page_mapping;
+	for (i = 0; i < fragments; i++) {
+		freeq_entry->word1.bits32 = 0;
+		freeq_entry->word2.buf_adr = lower_32_bits(mapping);
 		freeq_entry++;
 		mapping += frag_len;
 	}
 
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
+	return 0;
 
-	return page;
+err_mappings:
+	while (i--) {
+		mapping = page_mapping + i * frag_len;
+		xa_erase(&geth->freeq_mappings,
+			 geth_freeq_mapping_index(geth, mapping));
+	}
+	gpage->page = NULL;
+	gpage->mapping = 0;
+err_slot:
+	__clear_bit(slot, geth->freeq_page_bitmap);
+	page_pool_put_full_page(geth->freeq_pool, page, false);
+	return ret;
 }
 
 /**
@@ -890,28 +976,9 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 
 	/* Loop over the freeq ring buffer entries */
 	while (pn != epn) {
-		struct gmac_queue_page *gpage;
-		struct page *page;
-
-		gpage = &geth->freeq_pages[pn];
-		page = gpage->page;
+		if (geth_freeq_alloc_page(geth, pn))
+			break;
 
-		dev_dbg(geth->dev, "fill entry %d page ref count %d add %d refs\n",
-			pn, page_ref_count(page), 1 << fpp_order);
-
-		if (page_ref_count(page) > 1) {
-			unsigned int fl = (pn - epn) & m_pn;
-
-			if (fl > 64 >> fpp_order)
-				break;
-
-			page = geth_freeq_alloc_map_page(geth, pn);
-			if (!page)
-				break;
-		}
-
-		/* Add one reference per fragment in the page */
-		page_ref_add(page, 1 << fpp_order);
 		count += 1 << fpp_order;
 		pn++;
 		pn &= m_pn;
@@ -926,14 +993,28 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth, bool refill)
 
 static int geth_setup_freeq(struct gemini_ethernet *geth)
 {
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.order = 0,
+		.nid = NUMA_NO_NODE,
+		.dev = geth->dev,
+		.dma_dir = DMA_FROM_DEVICE,
+		.max_len = PAGE_SIZE,
+	};
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int pages = len >> fpp_order;
+	unsigned int page_slots = pages;
 	union queue_threshold qt;
 	union dma_skb_size skbsz;
 	unsigned int filled;
-	unsigned int pn;
+	int ret = -ENOMEM;
+
+	if (geth->port0)
+		page_slots += 1 << geth->port0->rxq_order;
+	if (geth->port1)
+		page_slots += 1 << geth->port1->rxq_order;
+	pp_params.pool_size = pages;
 
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -946,19 +1027,25 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	}
 
 	/* Allocate a mapping to page look-up index */
-	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);
+	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, page_slots);
 	if (!geth->freeq_pages)
 		goto err_freeq;
-	geth->num_freeq_pages = pages;
-
-	dev_info(geth->dev, "allocate %d pages for queue\n", pages);
-	for (pn = 0; pn < pages; pn++)
-		if (!geth_freeq_alloc_map_page(geth, pn))
-			goto err_freeq_alloc;
+	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
+	if (!geth->freeq_page_bitmap)
+		goto err_freeq_pages;
+	geth->num_freeq_pages = page_slots;
+	geth->freeq_page_cursor = 0;
+
+	geth->freeq_pool = page_pool_create(&pp_params);
+	if (IS_ERR(geth->freeq_pool)) {
+		ret = PTR_ERR(geth->freeq_pool);
+		geth->freeq_pool = NULL;
+		goto err_freeq_bitmap;
+	}
 
 	filled = geth_fill_freeq(geth, false);
 	if (!filled)
-		goto err_freeq_alloc;
+		goto err_freeq_pool;
 
 	qt.bits32 = readl(geth->base + GLOBAL_QUEUE_THRESHOLD_REG);
 	qt.bits.swfq_empty = 32;
@@ -971,25 +1058,23 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 
 	return 0;
 
-err_freeq_alloc:
-	while (pn > 0) {
-		struct gmac_queue_page *gpage;
-		dma_addr_t mapping;
-
-		--pn;
-		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
-		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
-		gpage = &geth->freeq_pages[pn];
-		put_page(gpage->page);
-	}
-
+err_freeq_pool:
+	xa_destroy(&geth->freeq_mappings);
+	page_pool_destroy(geth->freeq_pool);
+	geth->freeq_pool = NULL;
+err_freeq_bitmap:
+	bitmap_free(geth->freeq_page_bitmap);
+	geth->freeq_page_bitmap = NULL;
+err_freeq_pages:
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 err_freeq:
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
 			  geth->freeq_ring, geth->freeq_dma_base);
 	geth->freeq_ring = NULL;
-	return -ENOMEM;
+	return ret;
 }
 
 /**
@@ -998,10 +1083,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
  */
 static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 {
-	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int frag_len = 1 << geth->freeq_frag_order;
-	unsigned int len = 1 << geth->freeq_order;
-	unsigned int pages = len >> fpp_order;
+	struct page_pool *pool;
 	unsigned int pn;
 
 	if (!geth->freeq_ring)
@@ -1011,23 +1093,30 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	writel(0, geth->base + GLOBAL_SW_FREEQ_BASE_SIZE_REG);
 
-	for (pn = 0; pn < pages; pn++) {
+	pool = geth->freeq_pool;
+	for (pn = 0; pn < geth->num_freeq_pages; pn++) {
 		struct gmac_queue_page *gpage;
-		dma_addr_t mapping;
-
-		mapping = geth->freeq_ring[pn << fpp_order].word2.buf_adr;
-		dma_unmap_single(geth->dev, mapping, frag_len, DMA_FROM_DEVICE);
 
 		gpage = &geth->freeq_pages[pn];
-		while (page_ref_count(gpage->page) > 0)
-			put_page(gpage->page);
+		while (gpage->fragments) {
+			page_pool_put_full_page(pool, gpage->page, false);
+			gpage->fragments--;
+		}
 	}
+	xa_destroy(&geth->freeq_mappings);
 
+	bitmap_free(geth->freeq_page_bitmap);
+	geth->freeq_page_bitmap = NULL;
 	kfree(geth->freeq_pages);
+	geth->freeq_pages = NULL;
+	geth->num_freeq_pages = 0;
 
 	dma_free_coherent(geth->dev,
 			  sizeof(*geth->freeq_ring) << geth->freeq_order,
 			  geth->freeq_ring, geth->freeq_dma_base);
+	geth->freeq_ring = NULL;
+	geth->freeq_pool = NULL;
+	page_pool_destroy(pool);
 }
 
 /**
@@ -1435,6 +1524,7 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 	skb = napi_get_frags(&port->napi);
 	if (!skb)
 		goto update_exit;
+	skb_mark_for_recycle(skb);
 
 	if (rx_csum == RX_CHKSUM_IP_UDP_TCP_OK)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
@@ -1459,7 +1549,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
-	struct gmac_queue_page *gpage;
 	unsigned int received = 0;
 	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
@@ -1496,8 +1585,6 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
-		page_offs = mapping & ~PAGE_MASK;
-
 		if (word3.bits32 & SOF_BIT) {
 			if (skb) {
 				napi_free_frags(&port->napi);
@@ -1516,20 +1603,18 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 			goto err_drop;
 		}
 
-		/* Freeq pointers are one page off */
-		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
-		if (!gpage) {
-			dev_err_ratelimited(geth->dev,
-					    "could not find mapping\n");
+		page = geth_freeq_claim(geth, mapping, &page_offs);
+		if (!page)
 			goto err_drop;
-		}
-		page = gpage->page;
 
 		if (word3.bits32 & SOF_BIT) {
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
 			if (!skb)
 				goto err_drop;
 
+			if (frag_len < NET_IP_ALIGN)
+				goto err_drop;
+
 			page_offs += NET_IP_ALIGN;
 			frag_len -= NET_IP_ALIGN;
 			frag_nr = 0;
@@ -1544,10 +1629,18 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		/* append page frag to skb */
 		if (frag_nr == MAX_SKB_FRAGS)
 			goto err_drop;
+		if (frag_len > PAGE_SIZE - page_offs)
+			goto err_drop;
 
-		if (frag_len == 0 && net_ratelimit())
-			netdev_err(netdev, "Received fragment with len = 0\n");
+		if (!frag_len) {
+			if (net_ratelimit())
+				netdev_err(netdev,
+					   "Received fragment with len = 0\n");
+			goto err_drop;
+		}
 
+		page_pool_dma_sync_for_cpu(geth->freeq_pool, page, page_offs,
+					   frag_len);
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
 		skb->data_len += frag_len;
@@ -1569,7 +1662,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		}
 
 		if (page)
-			put_page(page);
+			page_pool_put_full_page(geth->freeq_pool, page, false);
 
 		if (!dropping) {
 			port->stats.rx_dropped++;
@@ -1920,6 +2013,8 @@ static int gmac_stop(struct net_device *netdev)
 	gmac_disable_tx_rx(netdev);
 	gmac_stop_dma(port);
 	napi_disable(&port->napi);
+	if (port->rx_skb)
+		napi_free_frags(&port->napi);
 	port->rx_skb = NULL;
 	port->rx_frag_nr = 0;
 	port->rx_dropping = false;
@@ -2673,6 +2768,7 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
+	xa_init(&geth->freeq_mappings);
 
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);

-- 
2.55.0

