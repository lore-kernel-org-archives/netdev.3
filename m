Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490246;
	b=CGOw/vFk+FxNVW09haFD61Fe8bsXEYlTWKcPcRBWYyqDBITrTAxVbGsRkeLnhHAblxsN
	 0pjYjVCRTS7x6wsBOnbfasTPvDAerGEcLtDzcs9FmPFwllZocWfWISDZu0C967dppfXFD
	 slIfjtEMWn5wNf5t0BVW3IQukwBj/dP5Yzf8tmN+hBvAqpBZATBgVGA15EV/Jehnv4s1x
	 MmxYBPTWRtt3nmYpTmxel+HapDw8Zbm7u3qpuNtCiUsc+6PrXnrLHRsDfudhskQb9Mh+a
	 kF6FgbJuyvMDS/bWF49O7cDv8+7tteq0tFlo6Uo5lylM7QVTn28Pdka76iG1+PJwK2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490246;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=GqqavUUD2Vphq/ZvbrsGMznx8HXH6ABoMIahMRjeCQE=;
	b=Wt6U+HVIpN7OQRDzZv9gSYYZOjWwOe1zWb3ORuLEnxqUATMQ7Z7m5suh9DlUqrZMvh/q
	 9UysV/DVqh2gr3HrxodZfeT2xmCWunLIgYj1GZiNHwtsESyw8RU1YOwmUNWG1jPHpR7dG
	 PAQ0F5XgbBvcgaJD/FaB+cnlR4IkivWu9umd4OC88YaxafgVidDeza2N4njsvDGzihyix
	 IFulkqHskb8Bv2JSL2s/I2vq/+q2RNm9sb244PeyZRoGVEwaYI2ZvK4uh/yjikjER1wSz
	 5DbOl+fLAVMaowsEW5UIjwACOApnMX9dPhs2t0X+rl58oRva0pu1HJuTxSTAPVTqi7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="T/ASeU9K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF06606A899
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T/ASeU9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E7D1F00A08;
	Thu, 12 Nov 2026 13:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490245;
	bh=GqqavUUD2Vphq/ZvbrsGMznx8HXH6ABoMIahMRjeCQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T/ASeU9KzCP3BFPpBo4ppXLExWRkq8G+9mHL94WDHRMZeazdlq/CjoB6/IABAflTh
	 yAgbhAi0+iUIXK9iSi7Gp6UDrT5m7s5qZ57SjIcAj1ePYzvl/Y86g9ZT8fm3XYVSXk
	 TmAqv6t9MhyqLEOfEla8U4f0RWVT1QiFteh3c4r3GSiku2u1LoZXfoz7cl/zZyg41m
	 Cmih2IafAdI7aDskHAp6ABNEAnh9T53I3/mw9HQ6370XPwUrNPVrYRUJWk2miDETQe
	 L4Luq7bYfazjWNshm1BNBB60YdySLpAXy+oZNoPlrpxLiJiW6iC/y6qVYo/3xxOORD
	 L/X/LfFmaAaVw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:24 +0100
Subject: [PATCH net-next v8 09/19] net: ethernet: cortina: Recycle claimed
 free queue pages
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-9-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
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

Reject pfmemalloc pages when recycling so emergency-reserve pages return
to the allocator instead of remaining pinned in the free queue.

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

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 153 +++++++++++++++++++++++++++++-----
 1 file changed, 131 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 64c8c7e463f2..aedd8eca3f15 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -175,7 +175,9 @@ struct gemini_ethernet {
 	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
+	unsigned long	*freeq_recycle_bitmap;
 	unsigned int	freeq_page_cursor;
+	unsigned int	freeq_recycle_pending;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -798,6 +800,34 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
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
@@ -807,8 +837,8 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	unsigned long index;
 	unsigned long flags;
 	dma_addr_t page_mapping;
-	unsigned int slot;
 	struct page *page;
+	unsigned int slot;
 	bool valid;
 
 	index = geth_freeq_mapping_index(geth, mapping);
@@ -832,13 +862,8 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
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
@@ -932,26 +957,23 @@ static int geth_freeq_map_page(struct gemini_ethernet *geth,
 	return 0;
 }
 
-static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int wptr,
-			       struct page *page, dma_addr_t page_mapping)
+static int geth_freeq_post_page(struct gemini_ethernet *geth,
+				unsigned int wptr,
+				struct gmac_queue_page *gpage, bool recycle)
 {
 	struct gmac_rxdesc *freeq_entry;
-	struct gmac_queue_page *gpage;
 	unsigned int ring_mask;
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
@@ -963,9 +985,6 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int wptr,
 	fragments = 1 << fpp_order;
 	ring_mask = (1 << geth->freeq_order) - 1;
 
-	gpage = &geth->freeq_pages[slot];
-	gpage->page = page;
-	gpage->mapping = page_mapping;
 	for (i = 0; i < fragments; i++) {
 		mapping = page_mapping + i * frag_len;
 		ret = xa_insert(&geth->freeq_mappings,
@@ -974,6 +993,9 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int wptr,
 		if (ret)
 			goto err_mappings;
 	}
+	if (recycle)
+		dma_sync_single_for_device(geth->dev, page_mapping, PAGE_SIZE,
+					   DMA_FROM_DEVICE);
 	gpage->fragments = fragments;
 	page_ref_add(page, fragments);
 
@@ -997,9 +1019,70 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int wptr,
 		xa_erase(&geth->freeq_mappings,
 			 geth_freeq_mapping_index(geth, mapping));
 	}
-	gpage->page = NULL;
-	gpage->mapping = 0;
-	__clear_bit(slot, geth->freeq_page_bitmap);
+	return ret;
+}
+
+static int geth_freeq_add_page(struct gemini_ethernet *geth,
+			       unsigned int wptr,
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
+	ret = geth_freeq_post_page(geth, wptr, gpage, false);
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
+				   unsigned int wptr)
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
+	if (page_ref_count(gpage->page) > 1 ||
+	    !dev_page_is_reusable(gpage->page)) {
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
+	ret = geth_freeq_post_page(geth, wptr, gpage, true);
+	if (ret) {
+		__set_bit(slot, geth->freeq_recycle_bitmap);
+		geth->freeq_recycle_pending++;
+	}
+
 	return ret;
 }
 
@@ -1034,9 +1117,22 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		rptr = rw.bits.rptr & ring_mask;
 		wptr = rw.bits.wptr & ring_mask;
 		space = CIRC_SPACE(wptr, rptr, len) >= fragments;
+		ret = -ENOSPC;
+		if (space && geth->freeq_recycle_pending) {
+			ret = geth_freeq_recycle_page(geth, wptr);
+			if (!ret) {
+				count += fragments;
+				wptr = (wptr + fragments) & ring_mask;
+				SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, wptr);
+			}
+		}
 		spin_unlock_irqrestore(&geth->freeq_lock, flags);
 		if (!space)
 			break;
+		if (!ret || ret == -EAGAIN)
+			continue;
+		if (ret != -ENOSPC)
+			break;
 
 		ret = geth_freeq_map_page(geth, &page, &page_mapping);
 		if (ret)
@@ -1049,6 +1145,8 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		wptr = rw.bits.wptr & ring_mask;
 		if (CIRC_SPACE(wptr, rptr, len) < fragments) {
 			ret = -ENOSPC;
+		} else if (geth->freeq_recycle_pending) {
+			ret = -EAGAIN;
 		} else {
 			ret = geth_freeq_add_page(geth, wptr, page,
 						  page_mapping);
@@ -1065,6 +1163,8 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 			dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
 					 DMA_FROM_DEVICE);
 			put_page(page);
+			if (ret == -EAGAIN)
+				continue;
 			break;
 		}
 	}
@@ -1109,6 +1209,7 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 		put_page(page);
 	}
 	xa_destroy(&geth->freeq_mappings);
+	geth->freeq_recycle_pending = 0;
 }
 
 static unsigned int
@@ -1155,6 +1256,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	geth->freeq_page_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
 	if (!geth->freeq_page_bitmap)
 		goto err_freeq_pages;
+	geth->freeq_recycle_bitmap = bitmap_zalloc(page_slots, GFP_KERNEL);
+	if (!geth->freeq_recycle_bitmap)
+		goto err_freeq_page_bitmap;
 	geth->num_freeq_pages = page_slots;
 	geth->freeq_page_cursor = 0;
 
@@ -1182,6 +1286,9 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	writew(readw(geth->base + GLOBAL_SWFQ_RWPTR_REG),
 	       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
 	geth_freeq_release_pages(geth);
+	bitmap_free(geth->freeq_recycle_bitmap);
+	geth->freeq_recycle_bitmap = NULL;
+err_freeq_page_bitmap:
 	bitmap_free(geth->freeq_page_bitmap);
 	geth->freeq_page_bitmap = NULL;
 err_freeq_pages:
@@ -1212,6 +1319,8 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 	geth_freeq_release_pages(geth);
 
+	bitmap_free(geth->freeq_recycle_bitmap);
+	geth->freeq_recycle_bitmap = NULL;
 	bitmap_free(geth->freeq_page_bitmap);
 	geth->freeq_page_bitmap = NULL;
 	kfree(geth->freeq_pages);

-- 
2.56.0

