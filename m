Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348821;
	b=NTPjj86GL3dMtcUwjZPyGStqv6LdjvFTQXDBcQ02gxfiMOYmoXZSKdgUqpcT/14wNChe
	 jO/SlAwjXBRrDrHNQ6Xq+x8PsOUL4CkRM4IyYG8fQI5+Kz7MHMvwsCaTWvCuZiHqpE/a/
	 aS0k38LRI/ZE/8yFQmT+aEQrctRol95W5/8noACkBlueJJI3tDXb3WRilT35WsJlaWvKl
	 fh1H1SThC+ZkjeBvKFqkenB/yARKaSEBHfQbJJ/hR8sHAL/08FTZN8Z5LftMqT3lQ66d7
	 1YQ6M3PW6vhRUoW1andA5vI4q+2xJSHrfcYXkYlykVRQgPlXF6tz4bT5zcjXILUReyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348821;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Q3MP1S1hTnGkxlEecOYc/53zVUIg3iBPBl5WB8vL/Sg=;
	b=eD/6+2Xz7UzPCr+yUe9xEArFgLsfa81ZVF1Lx3xkXAK0qSvLlLciFLDczDVFz6tTvBhX
	 fYm5YJs6v0AemJAuzDmK5H4bgGHgQMuwZrTnrZeqtmTTVs+sZIg9Y5cbNyEpVBPID642D
	 w091DPeB0D+11l48NwDuAVdieEiBJNhroR4C4E6w/qqDCQfdCHGY8GS0rCLpvLO3CUFbE
	 DmoJl4YaDbnGWZ8RN2ZadsC8VhDwMXi66PekQTxSC+NJV8JdmXP2xN6l7R7/Ot/q3Kn7a
	 vFUrpbcGbVGO8TFTnvB7i5sWQajM6rfqfzWYgJu7UHoqH08T0PfgfD5XKV2LJutFE0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIXvqUOx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD012606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIXvqUOx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3AB1F0089F;
	Tue, 10 Nov 2026 22:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348820;
	bh=Q3MP1S1hTnGkxlEecOYc/53zVUIg3iBPBl5WB8vL/Sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mIXvqUOxLUfoVJh57gSi46b/lWeAI4RG9NuR5j8hoczZr0R7B+2rfr29FliEAiheY
	 iXv36LUtBFRtOlAV3ycMKlRUObmouD7YkxxBlJfdY3KJuFaGOpPdOmf/G0T0XBqieB
	 Yka8MrhDPgBrzqzy282f9g8fELpwKy7abycMG0lJLHryw3TCYXc3Sv8YQzd03arGqh
	 yPTNJWquHsZCwV9biYdkzhqXi2XTSLkAImfsL/KYgrcTn35+nVzH4muHTGnDnNObn5
	 NHQIW2C94jvljktnwIrKU2+sKa52wo3dNn/R74Klkz82NzVIGJU6vR24jtPh0isTeb
	 yRjfj4LZCSgRw==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 10 Nov 2026 23:13:21 +0100
Subject: [PATCH net-next v7 06/18] net: ethernet: cortina: Index free queue
 fragments with XArray
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
Message-Id: <20261110-gemini-ethernet-fixes-3-v7-6-9c32a1a46aec@kernel.org>
References: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
In-Reply-To: <20261110-gemini-ethernet-fixes-3-v7-0-9c32a1a46aec@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

RX descriptors return the DMA address of the free queue fragment used by
the hardware. The driver currently recovers its page by scanning every
free queue page and comparing address ranges.

This isn't very efficient...

Instead index each fragment in an XArray using its DMA address in
fragment units.

Populate and erase the fragment index under the free queue lock. The
lookup remains serialized with refill and validates the exact fragment
address before returning the page and offset snapshot.

The per-fragment index is a prerequisite for the following
"Preserve in-flight free queue pages" fix, which keeps each mapping until
its RX descriptor is claimed. Include this patch when backporting that
fix and its subsequent recycling changes.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 105 ++++++++++++++++++++++++----------
 1 file changed, 76 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 71d7e6189531..add1d3e563b6 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -38,6 +38,7 @@
 #include <linux/ethtool.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/xarray.h>
 
 #include <linux/in.h>
 #include <linux/ip.h>
@@ -167,6 +168,7 @@ struct gemini_ethernet {
 	struct gmac_rxdesc *freeq_ring;
 	dma_addr_t	freeq_dma_base;
 	struct gmac_queue_page	*freeq_pages;
+	struct xarray	freeq_mappings;
 	unsigned int	num_freeq_pages;
 	spinlock_t	freeq_lock; /* Locks queue from reentrance */
 };
@@ -726,43 +728,47 @@ static int gmac_setup_rxq(struct net_device *netdev)
 	return 0;
 }
 
+static unsigned long
+geth_freeq_mapping_index(const struct gemini_ethernet *geth,
+			 dma_addr_t mapping)
+{
+	return (unsigned long)(mapping >> geth->freeq_frag_order);
+}
+
 static struct page *geth_freeq_lookup(struct gemini_ethernet *geth,
 				      dma_addr_t mapping,
 				      unsigned int *page_offs)
 {
 	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	struct gmac_queue_page *gpage;
+	unsigned long index;
 	unsigned long flags;
 	dma_addr_t page_mapping;
-	struct page *page = NULL;
-	int i;
-
-	spin_lock_irqsave(&geth->freeq_lock, flags);
-	if (!geth->freeq_pages) {
-		dev_err_ratelimited(geth->dev,
-				    "try to get page with no page list\n");
-		goto unlock;
-	}
-
-	/* Look up a ring buffer page from virtual mapping */
-	for (i = 0; i < geth->num_freeq_pages; i++) {
-		gpage = &geth->freeq_pages[i];
-		if (!gpage->page || mapping < gpage->mapping)
-			continue;
-
-		page_mapping = gpage->mapping;
-		if (mapping - page_mapping > PAGE_SIZE - frag_len ||
-		    ((mapping - page_mapping) & (frag_len - 1)))
-			continue;
+	struct page *page;
+	bool valid;
 
-		page = gpage->page;
-		*page_offs = mapping - page_mapping;
-		break;
-	}
+	index = geth_freeq_mapping_index(geth, mapping);
 
-unlock:
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
 	spin_unlock_irqrestore(&geth->freeq_lock, flags);
 	return page;
+
+err_unlock:
+	spin_unlock_irqrestore(&geth->freeq_lock, flags);
+	return NULL;
 }
 
 static void gmac_cleanup_rxq(struct net_device *netdev)
@@ -821,12 +827,16 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
 
+	lockdep_assert_held(&geth->freeq_lock);
+
 	/* First allocate and DMA map a single page */
 	page = alloc_page(GFP_ATOMIC);
 	if (!page)
@@ -855,9 +865,26 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
 	 */
 	frag_len = 1 << geth->freeq_frag_order; /* Usually 2048 */
 	fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	fragments = 1 << fpp_order;
+
 	gpage = &geth->freeq_pages[pn];
-	if (gpage->page)
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
 		put_page(gpage->page);
+	}
 
 	/* Then put our new mapping into the page table */
 	gpage->mapping = page_mapping;
@@ -876,6 +903,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -948,6 +986,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	unsigned int pages = len >> fpp_order;
 	union queue_threshold qt;
 	union dma_skb_size skbsz;
+	unsigned long flags;
+	struct page *page;
 	unsigned int filled;
 	unsigned int pn;
 	u16 rptr;
@@ -962,16 +1002,20 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 		goto err_freeq;
 	}
 
-	/* Allocate a mapping to page look-up index */
+	/* Allocate page metadata referenced by the mapping index */
 	geth->freeq_pages = kzalloc_objs(*geth->freeq_pages, pages);
 	if (!geth->freeq_pages)
 		goto err_freeq;
 	geth->num_freeq_pages = pages;
 
 	dev_info(geth->dev, "allocate %d pages for queue\n", pages);
-	for (pn = 0; pn < pages; pn++)
-		if (!geth_freeq_alloc_map_page(geth, pn))
+	for (pn = 0; pn < pages; pn++) {
+		spin_lock_irqsave(&geth->freeq_lock, flags);
+		page = geth_freeq_alloc_map_page(geth, pn);
+		spin_unlock_irqrestore(&geth->freeq_lock, flags);
+		if (!page)
 			goto err_freeq_alloc;
+	}
 
 	/* Match the software pointer to the retained hardware pointer. */
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
@@ -1002,6 +1046,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 				 DMA_FROM_DEVICE);
 		put_page(gpage->page);
 	}
+	xa_destroy(&geth->freeq_mappings);
 
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
@@ -1041,6 +1086,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 		while (page_ref_count(gpage->page) > 0)
 			put_page(gpage->page);
 	}
+	xa_destroy(&geth->freeq_mappings);
 
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
@@ -2787,6 +2833,7 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
+	xa_init(&geth->freeq_mappings);
 
 	/* Quiesce firmware state before child IRQ handlers are registered. */
 	gemini_ethernet_disable_irqs(geth);

-- 
2.56.0

