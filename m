Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C14F4CE6
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 16:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790958301; cv=none; b=cpZnAK2XW3116U+COPjb4LVsk7uM16vXAM6/s1j4PVfEnb3RgMbys5JFCSgd9yFfZpG+Cbir5slP0gKaPxXZ0fYMt509mt4CUMVXOVeX0rey4FUsFq6+DFJgbS290/V0BPzP/BzPQNe9uE8/slwYwldM5NEqrnwwZNvxK/cPkGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790958301; c=relaxed/simple;
	bh=ShyUyRK0oc2gtw05ehRlWctoGnUlgGAMtGDeGRF5SN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bDeBXmJnIlbZAcErYzMkU2b9w/bdsCIiaEyXvky0d+zrMLhIXb7KSHRRXopbV5Mt+pfXNZ7YatUE5SwvToWND/0WKfLA3RimF1z8iGgjnyd33mVUdYUKiXAJEJ3s2g32JFlEZtzCvQCsw/fVhJwQ0Scchdm9wcjoKu4eXtoQi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBJDvQUR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBJDvQUR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B8D1F00893;
	Fri,  2 Oct 2026 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790958299;
	bh=qNBIEi6nlMtIWQAcpXGOCb7ivSlPks1grzZLwBGiqXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MBJDvQURbxz9oaaYm3onkuFby5evFrpZ6nhuNFWYGFfii32A3Y5lwtEI9dcg+Ax40
	 u1RAtgqFK+fTN/kHFAUxTpvXToagFlQj0OEJ/OQI3tDbZBB+HLv0RpzIMoE7K6Il8J
	 zArzo0S9VhE4QHzbt1tta+kntE1V5Cnkcefhj1yxTaiy+8CJ0F+zgEFJQQO7WiNOBE
	 sOQniUD6RF2vcORSGlIqKdV+H19AbG/ZknEkIGuDgXbKG/xUQ2vXBoSlVGEgHWBkgy
	 FyboMIuzMxSSnXusN/Ytyvs7kv4yKDhDtlsZV6WQ2n2CmlLnRdrOcy0gi7q3M0SouF
	 kU55Va8jf7fzQ==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 02 Oct 2026 18:24:44 +0200
Subject: [PATCH net-next v3 05/12] net: ethernet: cortina: Index free queue
 fragments with XArray
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-gemini-ethernet-fixes-3-v3-5-3e1f25890ae8@kernel.org>
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

RX descriptors return the DMA address of the free queue fragment used by
the hardware. The driver currently recovers its page by scanning every
free queue page and comparing address ranges.

This isn't very efficient...

Instead index each fragment in an XArray using its DMA address in
fragment units.

Populate and erase the fragment index under the free queue lock. The
lookup remains serialized with refill and validates the exact fragment
address before returning the page and offset snapshot.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 103 +++++++++++++++++++++++++---------
 1 file changed, 75 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 809274aff8e5..ee604bc04fc3 100644
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
@@ -724,43 +726,47 @@ static int gmac_setup_rxq(struct net_device *netdev)
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
@@ -819,12 +825,16 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -853,9 +863,26 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -874,6 +901,17 @@ static struct page *geth_freeq_alloc_map_page(struct gemini_ethernet *geth,
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
@@ -945,6 +983,8 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	unsigned int pages = len >> fpp_order;
 	union queue_threshold qt;
 	union dma_skb_size skbsz;
+	unsigned long flags;
+	struct page *page;
 	unsigned int filled;
 	unsigned int pn;
 
@@ -965,9 +1005,13 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
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
 
 	filled = geth_fill_freeq(geth, false);
 	if (!filled)
@@ -994,6 +1038,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 				 DMA_FROM_DEVICE);
 		put_page(gpage->page);
 	}
+	xa_destroy(&geth->freeq_mappings);
 
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
@@ -1035,6 +1080,7 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 		while (page_ref_count(gpage->page) > 0)
 			put_page(gpage->page);
 	}
+	xa_destroy(&geth->freeq_mappings);
 
 	kfree(geth->freeq_pages);
 	geth->freeq_pages = NULL;
@@ -2714,6 +2760,7 @@ static int gemini_ethernet_probe(struct platform_device *pdev)
 
 	spin_lock_init(&geth->irq_lock);
 	spin_lock_init(&geth->freeq_lock);
+	xa_init(&geth->freeq_mappings);
 
 	/* The children will use this */
 	platform_set_drvdata(pdev, geth);

-- 
2.55.0

