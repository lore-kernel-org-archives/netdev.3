Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD2542810
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077880; cv=none; b=oK+5O6Fp86HUU412+IBLDzrlLgEDSzfk6jXLaQ6ruC5kQAHgAjnTkpVshKKKCpBaso9qH1ZOMaidkjK8mlwyX84YnXi07OJ4uxrDiXNSv5nbId9ucudJQKbPJDy22iZU9+qr22NHPuVyYkAHFDOFbvJq8FMXJSjAEG20A7Up/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077880; c=relaxed/simple;
	bh=Tz2QNAJVKX5n8PS0IDh6E11ORBctKavV/PcujvvutIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L0ADemCbUUUjERCcXAu5H4mqhmR+xkNqgUXE6lnYAuEtyNHwQZzqJWD+2Pmic8aLaTIT+gRI27MXphc14keGATV+/bQxipCyaLBxdjb5wg/hTIljdB42OL/Wc8VNDBeyA75XDRKfMAo5F0VqgOtiFbrJ/WO0x3gNliHw3aiuPyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWqbfMvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWqbfMvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915311F000C5;
	Thu, 15 Oct 2026 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792077872;
	bh=ZcmLbQlHSgSLfIOABIcG0/BJPI2XUYHCiixJeOBn9hU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=iWqbfMvHUUlKphvy7fWhslKKhAObUDJ8WnKW7S9XPjaYZ/K2D/4eq8wZp9d192P6C
	 yEfPNdfl8Qnb9Gn1ANqA61f1RseRfG3og33FNZUCokLEXhMF9LjuWIA1WEUbsuG2yz
	 QEj5ON3QPKMWU4aSZ/c7N+rp9ViYOHQ+Unsskm/NDr/jF/uGX+hZcMzR5ToGRdBOVn
	 IK4UkTeCTrPOlx50e5kcKO4iktLYWU4ddvGUzm3Tm02U3Y4I8IuGTSGLYTfywLLCH9
	 Wz2+XYRoupQAZayYpybv5B6uppuQUUd/CMqiPTrVhvq9VSvec92Dxm5r+tQEx6Ysje
	 dlyIpBBsBh7AQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 15 Oct 2026 17:24:09 +0200
Subject: [PATCH net-next v5 09/14] net: ethernet: cortina: Recycle claimed
 free queue pages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-gemini-ethernet-fixes-3-v5-9-b5c9e2f7b8a3@kernel.org>
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

Recheck the recycle bitmap on each refill iteration and again after mapping
a candidate page. If another RX path retires a page concurrently, release
the candidate and return to the recycler before consuming another metadata
slot. Retry recycling immediately when a retained page is discarded so
other pending entries are examined before allocating a replacement. This
avoids stopping refill while recyclable slots are pending.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 154 +++++++++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 1d71c5066457..e42eeefd4d19 100644
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
 
@@ -997,9 +1077,24 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		pn = (rw.bits.wptr >> fpp_order) & m_pn;
 		epn = (rw.bits.rptr >> fpp_order) - 1;
 		epn &= m_pn;
+		ret = -ENOSPC;
+		if (pn != epn && geth->freeq_recycle_pending) {
+			ret = geth_freeq_recycle_page(geth, pn);
+			if (!ret) {
+				count += 1 << fpp_order;
+				pn++;
+				pn &= m_pn;
+				writew(pn << fpp_order,
+				       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+			}
+		}
 		spin_unlock_irqrestore(&geth->freeq_lock, flags);
 		if (pn == epn)
 			break;
+		if (!ret || ret == -EAGAIN)
+			continue;
+		if (ret != -ENOSPC)
+			break;
 
 		ret = geth_freeq_map_page(geth, &page, &page_mapping);
 		if (ret)
@@ -1013,6 +1108,8 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		epn &= m_pn;
 		if (pn == epn) {
 			ret = -ENOSPC;
+		} else if (geth->freeq_recycle_pending) {
+			ret = -EAGAIN;
 		} else {
 			ret = geth_freeq_add_page(geth, pn, page,
 						  page_mapping);
@@ -1031,6 +1128,8 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 			dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
 					 DMA_FROM_DEVICE);
 			put_page(page);
+			if (ret == -EAGAIN)
+				continue;
 			break;
 		}
 	}
@@ -1075,6 +1174,7 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 		put_page(page);
 	}
 	xa_destroy(&geth->freeq_mappings);
+	geth->freeq_recycle_pending = 0;
 }
 
 static unsigned int
@@ -1121,6 +1221,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
+	geth->freeq_recycle_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
+	if (!geth->freeq_recycle_bitmap)
+		goto err_freeq_page_bitmap;
 	geth->num_freeq_pages = page_slots;
 	geth->freeq_page_cursor = 0;
 
@@ -1148,6 +1251,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	geth_freeq_release_pages(geth);
+	bitmap_free(geth->freeq_recycle_bitmap);
+	geth->freeq_recycle_bitmap = NULL;
+err_freeq_page_bitmap:
 	bitmap_free(geth->freeq_page_bitmap);
 	geth->freeq_page_bitmap = NULL;
 err_freeq_pages:
@@ -1178,6 +1284,8 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 	geth_freeq_release_pages(geth);
 
+	bitmap_free(geth->freeq_recycle_bitmap);
+	geth->freeq_recycle_bitmap = NULL;
 	bitmap_free(geth->freeq_page_bitmap);
 	geth->freeq_page_bitmap = NULL;
 	kfree(geth->freeq_pages);

-- 
2.56.0

