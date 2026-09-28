Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905934503ED
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585460; cv=none; b=fp8NRq+C5Yt8qHlJMKrUeL/tck0xXogV63MRLLEY99rmSG2d/Rgs4a8fNWa4ZM15B4ol3lkQeESQBRAXt/oGkU1MCE6sx0pIkIuoplIdbi8npKkLXGZ/fBu3zFfQGYNrlyKRq9J5XUKUmFs4CXMZa9gnfWaBL0hACZd7N7Tz4u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585460; c=relaxed/simple;
	bh=x4m3IFNcdf/cGDYbNkKTXrFfeT/cAEdrTpQWrjEjSiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpyWazFK6zc6t3xUtW1zTLkRyyUun3YZz/7moAPYwH99w/XvQciRLYsrld+C0yzvWyerApWMjc3sPSlJQa6ilexp103Vs1vXc7Lybg2Q4ZcLm6NmXESPL4OeTXnnuG/ds9Vg62vR9fXoVkqXvpJJKP0v8Cjh3Ah4GhztrvwuDuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgPon4XF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgPon4XF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455331F00893;
	Mon, 28 Sep 2026 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585459;
	bh=JGCoiyEQPgrt56gjIfjjwE6tIYvHy1NQoFaNsRvGMso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PgPon4XF3fTmAKmseVF4mOtW4Bh16nG221OK+MaMW0XrhQGIKLrCxTjCo1GniRipN
	 SuT8GYIvy+MbJfvnVhE1xFN43gMPDZybewfvY93ynt0n/EsSSj3/UrFHALC3QP9toJ
	 19PM06XzC3vnX2HVVWir4RAJ/czTQMGkELmd39ADhH8yJYkpTFvtaiDLMayZsCOK36
	 Yde1O6EG2Bgz2wDugOkWVm+/R08/sRRMCwZiiEOUrdgTasGZetphYNKe8q3poW0c7+
	 R3vFrJvgTTIxCL0DHIvAhak5Vab7vOv3442nvuVbWonCSnleoBEh/7J86z7FJkcHzP
	 PYYU8mvausbhQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:33 +0200
Subject: [PATCH net-next v2 07/11] net: ethernet: cortina: Synchronize RX
 fragments for the CPU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-7-758a795d7a78@kernel.org>
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

Free queue pages use streaming DMA mappings with DMA_FROM_DEVICE. The RX
path reads packet data after the device has filled a fragment without
first transferring ownership of that range to the CPU.

Synchronize each complete free queue fragment when its RX descriptor is
claimed.

Once all fragments have been claimed, tear down the full-page mapping with
DMA_ATTR_SKIP_CPU_SYNC. Each range has already moved to the CPU domain, and
another full-page synchronization could invalidate a sibling fragment
already being consumed by the network stack.

During queue teardown, synchronize only XArray entries still owned by the
hardware before the skip-sync unmap. Claimed fragments may remain attached
to skbs and must not be synchronized again.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 385b78fd6653..d677d7431ab2 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -790,11 +790,15 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	if (!valid)
 		goto err_unlock;
 
+	dma_sync_single_range_for_cpu(geth->dev, page_mapping,
+				      mapping - page_mapping, frag_len,
+				      DMA_FROM_DEVICE);
 	xa_erase(&geth->freeq_mappings, index);
 	if (!--gpage->fragments) {
 		slot = gpage - geth->freeq_pages;
-		dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
-				 DMA_FROM_DEVICE);
+		dma_unmap_single_attrs(geth->dev, page_mapping, PAGE_SIZE,
+				       DMA_FROM_DEVICE,
+				       DMA_ATTR_SKIP_CPU_SYNC);
 		gpage->page = NULL;
 		gpage->mapping = 0;
 		__clear_bit(slot, geth->freeq_page_bitmap);
@@ -1025,19 +1029,34 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 
 static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 {
+	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
+	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	unsigned int pn;
 
 	for (pn = 0; pn < geth->num_freeq_pages; pn++) {
 		struct gmac_queue_page *gpage;
+		dma_addr_t mapping;
 		struct page *page;
+		unsigned int i;
 
 		gpage = &geth->freeq_pages[pn];
 		if (!gpage->page)
 			continue;
 
 		page = gpage->page;
-		dma_unmap_single(geth->dev, gpage->mapping, PAGE_SIZE,
-				 DMA_FROM_DEVICE);
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
 		while (gpage->fragments) {
 			put_page(page);
 			gpage->fragments--;

-- 
2.55.0

