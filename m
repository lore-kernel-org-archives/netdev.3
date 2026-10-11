Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9635334C9A6
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742009; cv=none; b=UESG5LV5Srsa1LKo4IB3vXdw0KdbacqpTcPO9pCXrKWwK00UVY7pWsCoRcBQInh4iePeqpW1ZS8bfD9zQ4xyMwA778w39Aq62eV+FPUGzDeEIz/i9MYMcU5cLVhpFWZQj88v4egZkFBeorvc/nmT8/sUg1hgo7uZzhO+oEA9nWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742009; c=relaxed/simple;
	bh=SZqCvb2/ioyrFI5gQjHhloA2zuneliCvs1KcOOCVwYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ipgXaYk0PafRI8v32UJPGBE2F8gT7uXHT3lEII84regHky4bsGIr5lsRy0R2M0FOlXSueWxLy9CauViw0VPiEPKt6mxnb7FU9ZlExdpYlKs+Y5bm0bAOoNthLL00U4NbL7CMVgtqy/Y2zigv+PTKIRXDA9/UCApilfS51+IwJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5ZPzPKI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5ZPzPKI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCC21F0089B;
	Sun, 11 Oct 2026 18:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791742008;
	bh=9rznVZKghLi7cuMwExTIcdBYr9e3K3deXJzAjA/7duI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=K5ZPzPKIZN9q+e4z/1W4w6Rtg9S4JXeQHRKme45qdTF5Z0oyYm+wNZh/rqODCPG88
	 k/kXSwXshQISzJ1jZckyjBHnvqfO1sCk19Ta8gwfIYCnUpKLEOH8CM8yxJv9pRk7bo
	 2fSKv66G5sKLupslMR95J45OL0x5oSmKVLGeOFY47wLVPqVSLsK70eWiTToiqz4Mps
	 QluUYRQkhCsrnYfxKZiHsbCiRv7oL+pupsA0h27bBE9NsWo2TyIYZsG/SmneYaFbpc
	 9Ub82ZXytjLUHDmERPEdKMNUC80DDf+sUzBsxbbvXhjPDpeIpbgdi9IzX3gEzKJMCi
	 Rxx/hivaftb9g==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 11 Oct 2026 20:06:23 +0200
Subject: [PATCH net-next v4 10/15] net: ethernet: cortina: Recycle claimed
 free queue pages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-gemini-ethernet-fixes-3-v4-10-4b1631b08f5d@kernel.org>
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

The preceding "Preserve in-flight free queue pages" fix releases each
mapping after its last descriptor is claimed. Refilling therefore
allocates and maps a fresh page at line rate even after the network stack
has released all references to an old page.

Keep the free queue base reference and streaming mapping after the
fragments are claimed. Track fully claimed slots in a separate bitmap and
inspect one at a time during refill. Recycle a page once its reference
count returns to one. If the stack still owns fragments, unmap the page
and relinquish the base reference before allocating its replacement.

This prevents retained pages from exhausting the finite metadata table
and bounds the IRQ-disabled search to a bitmap lookup and one reference
count check. It retains the existing free queue allocator without
introducing a page pool.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 153 +++++++++++++++++++++++++++++-----
 1 file changed, 130 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 3bb96c51e0b7..943c31c02674 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -174,7 +174,9 @@ struct gemini_ethernet {
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
+	unsigned long	*freeq_recycle_bitmap;
 	unsigned int	freeq_page_cursor;
+	unsigned int	freeq_recycle_pending;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -764,6 +766,34 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 	return slot;
 }
 
+static int geth_freeq_recycle_slot(struct gemini_ethernet *geth)
+{
+	unsigned int slot = geth->freeq_page_cursor;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	if (!geth->freeq_recycle_pending)
+		return -ENOSPC;
+
+	slot = find_next_bit(geth->freeq_recycle_bitmap,
+			     geth->num_freeq_pages,
+			     geth->freeq_page_cursor);
+	if (slot == geth->num_freeq_pages) {
+		slot = find_first_bit(geth->freeq_recycle_bitmap,
+				      geth->freeq_page_cursor);
+		if (slot == geth->freeq_page_cursor)
+			return -ENOSPC;
+	}
+
+	__clear_bit(slot, geth->freeq_recycle_bitmap);
+	geth->freeq_page_cursor = slot + 1;
+	if (geth->freeq_page_cursor == geth->num_freeq_pages)
+		geth->freeq_page_cursor = 0;
+	geth->freeq_recycle_pending--;
+
+	return slot;
+}
+
 static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 				     dma_addr_t mapping,
 				     unsigned int *page_offs)
@@ -773,8 +803,8 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	unsigned long index;
 	unsigned long flags;
 	dma_addr_t page_mapping;
-	unsigned int slot;
 	struct page *page;
+	unsigned int slot;
 	bool valid;
 
 	index = geth_freeq_mapping_index(geth, mapping);
@@ -798,13 +828,8 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	xa_erase(&geth->freeq_mappings, index);
 	if (!--gpage->fragments) {
 		slot = gpage - geth->freeq_pages;
-		dma_unmap_single_attrs(geth->dev, page_mapping, PAGE_SIZE,
-				       DMA_FROM_DEVICE,
-				       DMA_ATTR_SKIP_CPU_SYNC);
-		gpage->page = NULL;
-		gpage->mapping = 0;
-		__clear_bit(slot, geth->freeq_page_bitmap);
-		put_page(page);
+		__set_bit(slot, geth->freeq_recycle_bitmap);
+		geth->freeq_recycle_pending++;
 	}
 
 	*page_offs = mapping - page_mapping;
@@ -898,25 +923,21 @@ static int geth_freeq_map_page(struct gemini_ethernet *geth,
 	return 0;
 }
 
-static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
-			       struct page *page, dma_addr_t page_mapping)
+static int geth_freeq_post_page(struct gemini_ethernet *geth, unsigned int pn,
+				struct gmac_queue_page *gpage, bool recycle)
 {
 	struct gmac_rxdesc *freeq_entry;
-	struct gmac_queue_page *gpage;
 	unsigned int fpp_order;
 	unsigned int fragments;
 	unsigned int frag_len;
+	dma_addr_t page_mapping = gpage->mapping;
 	dma_addr_t mapping;
+	struct page *page = gpage->page;
 	int ret;
-	int slot;
 	int i;
 
 	lockdep_assert_held(&geth->freeq_lock);
 
-	slot = geth_freeq_alloc_slot(geth);
-	if (slot < 0)
-		return slot;
-
 	/* The assign the page mapping (physical address) to the buffer address
 	 * in the hardware queue. PAGE_SHIFT on ARM is 12 (1 page is 4096 bytes,
 	 * 4k), and the default RX frag order is 11 (fragments are up 20 2048
@@ -927,9 +948,6 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	fragments = 1 << fpp_order;
 
-	gpage = &geth->freeq_pages[slot];
-	gpage->page = page;
-	gpage->mapping = page_mapping;
 	for (i = 0; i < fragments; i++) {
 		mapping = page_mapping + i * frag_len;
 		ret = xa_insert(&geth->freeq_mappings,
@@ -938,11 +956,14 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
 		if (ret)
 			goto err_mappings;
 	}
+	if (recycle)
+		dma_sync_single_for_device(geth->dev, page_mapping, PAGE_SIZE,
+					   DMA_FROM_DEVICE);
 	gpage->fragments = fragments;
 	page_ref_add(page, fragments);
 
 	freeq_entry = geth->freeq_ring + (pn << fpp_order);
-	dev_dbg(geth->dev, "allocate page %d fragment length %d fragments per page %d, freeq entry %p\n",
+	dev_dbg(geth->dev, "post page %d fragment length %d fragments per page %d, freeq entry %p\n",
 		pn, frag_len, (1 << fpp_order), freeq_entry);
 	mapping = page_mapping;
 	for (i = (1 << fpp_order); i > 0; i--) {
@@ -961,9 +982,68 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
 		xa_erase(&geth->freeq_mappings,
 			 geth_freeq_mapping_index(geth, mapping));
 	}
-	gpage->page = NULL;
-	gpage->mapping = 0;
-	__clear_bit(slot, geth->freeq_page_bitmap);
+	return ret;
+}
+
+static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
+			       struct page *page, dma_addr_t page_mapping)
+{
+	struct gmac_queue_page *gpage;
+	int ret;
+	int slot;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	slot = geth_freeq_alloc_slot(geth);
+	if (slot < 0)
+		return slot;
+
+	gpage = &geth->freeq_pages[slot];
+	gpage->page = page;
+	gpage->mapping = page_mapping;
+	ret = geth_freeq_post_page(geth, pn, gpage, false);
+	if (ret) {
+		gpage->page = NULL;
+		gpage->mapping = 0;
+		__clear_bit(slot, geth->freeq_page_bitmap);
+	}
+
+	return ret;
+}
+
+static int geth_freeq_recycle_page(struct gemini_ethernet *geth,
+				   unsigned int pn)
+{
+	struct gmac_queue_page *gpage;
+	struct page *page;
+	int ret;
+	int slot;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	slot = geth_freeq_recycle_slot(geth);
+	if (slot < 0)
+		return slot;
+
+	gpage = &geth->freeq_pages[slot];
+	if (page_ref_count(gpage->page) > 1) {
+		page = gpage->page;
+		dma_unmap_single_attrs(geth->dev, gpage->mapping, PAGE_SIZE,
+				       DMA_FROM_DEVICE,
+				       DMA_ATTR_SKIP_CPU_SYNC);
+		gpage->page = NULL;
+		gpage->mapping = 0;
+		__clear_bit(slot, geth->freeq_page_bitmap);
+		put_page(page);
+		return -EAGAIN;
+	}
+
+	ret = geth_freeq_post_page(geth, pn, gpage, true);
+	if (ret) {
+		__set_bit(slot, geth->freeq_recycle_bitmap);
+		geth->freeq_recycle_pending++;
+	}
+
 	return ret;
 }
 
@@ -982,6 +1062,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 	unsigned long flags;
 	union dma_rwptr rw;
 	unsigned int m_pn;
+	bool recycle = true;
 
 	/* Mask for page */
 	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
@@ -997,9 +1078,26 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		pn = (rw.bits.wptr >> fpp_order) & m_pn;
 		epn = (rw.bits.rptr >> fpp_order) - 1;
 		epn &= m_pn;
+		ret = -ENOSPC;
+		if (pn != epn && recycle) {
+			ret = geth_freeq_recycle_page(geth, pn);
+			if (!ret) {
+				count += 1 << fpp_order;
+				pn++;
+				pn &= m_pn;
+				writew(pn << fpp_order,
+				       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+			}
+			if (ret == -ENOSPC)
+				recycle = false;
+		}
 		spin_unlock_irqrestore(&geth->freeq_lock, flags);
 		if (pn == epn)
 			break;
+		if (!ret)
+			continue;
+		if (ret != -ENOSPC && ret != -EAGAIN)
+			break;
 
 		ret = geth_freeq_map_page(geth, &page, &page_mapping);
 		if (ret)
@@ -1075,6 +1173,7 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 		put_page(page);
 	}
 	xa_destroy(&geth->freeq_mappings);
+	geth->freeq_recycle_pending = 0;
 }
 
 static unsigned int
@@ -1120,6 +1219,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
+	geth->freeq_recycle_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
+	if (!geth->freeq_recycle_bitmap)
+		goto err_freeq_page_bitmap;
 	geth->num_freeq_pages = page_slots;
 	geth->freeq_page_cursor = 0;
 
@@ -1146,6 +1248,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	geth_freeq_release_pages(geth);
+	bitmap_free(geth->freeq_recycle_bitmap);
+	geth->freeq_recycle_bitmap = NULL;
+err_freeq_page_bitmap:
 	bitmap_free(geth->freeq_page_bitmap);
 	geth->freeq_page_bitmap = NULL;
 err_freeq_pages:
@@ -1176,6 +1281,8 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 	geth_freeq_release_pages(geth);
 
+	bitmap_free(geth->freeq_recycle_bitmap);
+	geth->freeq_recycle_bitmap = NULL;
 	bitmap_free(geth->freeq_page_bitmap);
 	geth->freeq_page_bitmap = NULL;
 	kfree(geth->freeq_pages);

-- 
2.56.0

