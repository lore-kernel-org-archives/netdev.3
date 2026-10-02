Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA634F6480
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958312; cv=none; b=CcZs8ZunOr5dwSU5bZrAg1hbevkXkCJBsZPRlqktDIy3PLrWj7n3I6KxjQqNB5e+0/gAITMPppPNdtI09Sis6RFNL8GE45dtUwsWn0+7exdRC1Uvrcf2EbNNbtcQuKY0h5v7t8Tmc4cvJkrE3z7ED0H4xA6whHEsrQuSfUYPgFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958312; c=relaxed/simple;
	bh=xkwhwE1mNyO8+qj0B1XEkI9oXvzf044VXkChfhiLMdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kF+XKkGUE4FSy9EGDr1KxJngtoBHlwdnAtBJkh60LLPQnqH3Hb/yR7rlk8CUINi28keJh6FObY2eLj9lp5ZB8PBsYfodDLmVeVe0ozn+N7dbw0N8zYCYHXmJgSpySTsMfrAXg0kpEzws7PrWeN79liRNraouKN8gKm2lGbdR+jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KerNJvva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KerNJvva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C181F00893;
	Fri,  2 Oct 2026 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958311;
	bh=xV/b7p4+Kyjyin7rAuVosZOniLn4/6N2JyjKfh824O0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KerNJvva/R4kY1PRE43oRxIQXHiz58p1B0KfHMq8KlXzSHees2u3GDFX4Cp2hYSeq
	 gE+Jw3RQMANVWq9a7YOZ/F1UqBpYbRrhIzBgqULJyhiNaUMUmRFRdbtm//0ir4264h
	 3hbqHJWgJB8h3cuyKlKHW+B1NAbfxCUh6NRCHkEJcJND+dpHjModmmNg93OS6J1CzC
	 n8oVMGjx7M/JIuc0tdZQCN9AAh4T/Kxe3yo/xE30giYBRbsrB8pZxJnoDARUalmeli
	 bhGROEfxtf+5QsBSbQby6uKpySflRnHaDo1Kpao4x1cc4ClmuayA/xiJ/2Fihah642
	 uMmX8DVpyO60A==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:48 +0200
Subject: [PATCH net-next v3 09/12] net: ethernet: cortina: Recycle claimed
 free queue pages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-9-3e1f25890ae8@kernel.org>
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

The lifetime fix releases each mapping after its last descriptor is
claimed. Refilling therefore allocates and maps a fresh page at line
rate even after the network stack has released all references to an old
page.

Keep the free queue base reference and streaming mapping after the
fragments are claimed. Once the page reference count returns to one,
synchronize the complete page for the device, restore its fragment
mappings and post it again. Fall back to allocating a new page while old
fragments remain in the stack.

This retains the existing free queue allocator without introducing a
page pool.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 130 +++++++++++++++++++++++++++-------
 1 file changed, 104 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 87c537ae83e7..a0186cc4b943 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -173,6 +173,7 @@ struct gemini_ethernet {
 	unsigned int	num_freeq_pages;
 	unsigned long	*freeq_page_bitmap;
 	unsigned int	freeq_page_cursor;
+	unsigned int	freeq_recycle_pending;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
 
@@ -762,6 +763,35 @@ static int geth_freeq_alloc_slot(struct gemini_ethernet *geth)
 	return slot;
 }
 
+static int geth_freeq_recycle_slot(struct gemini_ethernet *geth)
+{
+	unsigned int slot = geth->freeq_page_cursor;
+	unsigned int scanned;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	if (!geth->freeq_recycle_pending)
+		return -ENOSPC;
+
+	for (scanned = 0; scanned < geth->num_freeq_pages; scanned++) {
+		struct gmac_queue_page *gpage = &geth->freeq_pages[slot];
+
+		if (gpage->page && !gpage->fragments &&
+		    page_ref_count(gpage->page) == 1) {
+			geth->freeq_page_cursor = slot + 1;
+			if (geth->freeq_page_cursor == geth->num_freeq_pages)
+				geth->freeq_page_cursor = 0;
+			geth->freeq_recycle_pending--;
+			return slot;
+		}
+
+		if (++slot == geth->num_freeq_pages)
+			slot = 0;
+	}
+
+	return -ENOSPC;
+}
+
 static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 				     dma_addr_t mapping,
 				     unsigned int *page_offs)
@@ -771,7 +801,6 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	unsigned long index;
 	unsigned long flags;
 	dma_addr_t page_mapping;
-	unsigned int slot;
 	struct page *page;
 	bool valid;
 
@@ -794,16 +823,8 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 				      mapping - page_mapping, frag_len,
 				      DMA_FROM_DEVICE);
 	xa_erase(&geth->freeq_mappings, index);
-	if (!--gpage->fragments) {
-		slot = gpage - geth->freeq_pages;
-		dma_unmap_single_attrs(geth->dev, page_mapping, PAGE_SIZE,
-				       DMA_FROM_DEVICE,
-				       DMA_ATTR_SKIP_CPU_SYNC);
-		gpage->page = NULL;
-		gpage->mapping = 0;
-		__clear_bit(slot, geth->freeq_page_bitmap);
-		put_page(page);
-	}
+	if (!--gpage->fragments)
+		geth->freeq_recycle_pending++;
 
 	*page_offs = mapping - page_mapping;
 	spin_unlock_irqrestore(&geth->freeq_lock, flags);
@@ -896,25 +917,21 @@ static int geth_freeq_map_page(struct gemini_ethernet *geth,
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
@@ -925,9 +942,6 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	fragments = 1 << fpp_order;
 
-	gpage = &geth->freeq_pages[slot];
-	gpage->page = page;
-	gpage->mapping = page_mapping;
 	for (i = 0; i < fragments; i++) {
 		mapping = page_mapping + i * frag_len;
 		ret = xa_insert(&geth->freeq_mappings,
@@ -936,11 +950,14 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
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
@@ -959,9 +976,51 @@ static int geth_freeq_add_page(struct gemini_ethernet *geth, unsigned int pn,
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
+	int ret;
+	int slot;
+
+	lockdep_assert_held(&geth->freeq_lock);
+
+	slot = geth_freeq_recycle_slot(geth);
+	if (slot < 0)
+		return slot;
+
+	ret = geth_freeq_post_page(geth, pn, &geth->freeq_pages[slot], true);
+	if (ret)
+		geth->freeq_recycle_pending++;
+
 	return ret;
 }
 
@@ -980,6 +1039,7 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 	unsigned long flags;
 	union dma_rwptr rw;
 	unsigned int m_pn;
+	bool recycle = true;
 
 	/* Mask for page */
 	m_pn = (1 << (geth->freeq_order - fpp_order)) - 1;
@@ -995,9 +1055,26 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		pn = rw.bits.wptr >> fpp_order;
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
+		if (ret != -ENOSPC)
+			break;
 
 		ret = geth_freeq_map_page(geth, &page, &page_mapping);
 		if (ret)
@@ -1073,6 +1150,7 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 		put_page(page);
 	}
 	xa_destroy(&geth->freeq_mappings);
+	geth->freeq_recycle_pending = 0;
 }
 
 static unsigned int

-- 
2.55.0

