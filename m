Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490248;
	b=UsVMINfdO+tv9A6BUQQYkNdhKgbenR2PHtSJeHDpOl0kgLoJZUicBhge/Vt6Z2sJdR3i
	 xr+Jts+1oEsag3b4w/g6WhxQIgGKf5xv94uPe78nVjV3oofL+JDPIxTLSM1OFGX7o+tKz
	 9S3ZECVWg8AbMbolHRr/b9AV6iiGx53NB6hR4szg6Oe9pWAxLnFOcxqbseA45W5mPlrib
	 pcQn9gPj2iCUwE4asxEBTUELs6I3i4QupMaIlRR98JQxzTxJa/GoYerubi+hh1F34EXLS
	 IKJ0hasd6k7c/FEQ8GoYYGe+YJNv3ss5p49/nh6ulGE6aMDFTCP4lNxNApBJqFFjKqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490248;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=PO/7iLO3aILeNDic+y+t9fKBNph3OlrTC/fd7u4/LPA=;
	b=Gr96am2wpkYVapK2VRrwe5w7BQBOBylrgcMNCKKYs+Y1eac3MOGITfkomaYkNCYYJFWn
	 V51wuLWPsMMFMBo90fXnkPD/u/xHYcqD+FHxAFYfGmLWCP7PlAwj3/hTagtv7dFKAYmai
	 d2E5SH9fZxlpGBCzxVwCJ8T4HQ+nf/gQ+vdx0ErxmWrQWDTRItQuvj34okr8Cq6DOLzu1
	 JZyhWLK5vn7IqhQ73FNtx3SG9FpWVoDhsFYCONYcwDQQ+gaGM+MrBFZyjEahugjWOfDz8
	 DHF5/4UgAKb3umpFWWetQiotkMvm+depxl3G9V2odNwha1LWDds9aNZ85YFfyrYC+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKmkWoTk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5127606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKmkWoTk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2318C1F00A05;
	Thu, 12 Nov 2026 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490248;
	bh=PO/7iLO3aILeNDic+y+t9fKBNph3OlrTC/fd7u4/LPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hKmkWoTkwdLteyO632OSUrm0+/u5vh3TxNFk0TZ5X0wH5CeE7rWgNImEhvQomAyQm
	 rrdZAGpFabmNpFmi+OYFjSIO1M0YZ0Lv3tsdeHdIIDidyNSutbSqWSmoz9keaGBtzu
	 KafwY5883A9t7b4BTuJ+WaFW4gZzlOjT5KBsZNBroHsW8jhCMFSpJ19gCrkXMwC82A
	 cykm9XZCr8LNJafc6Gs6gxrruSL28ug72P7MPjxJNgKDCZdJ83ug86MHB1JMtE63hM
	 QmNXQ7johptUykUVrKqs+U/MlBrrDqjHD1FinBhNIAdPqWl9BJs9qUd+dIccvS9otm
	 hWnX0e2Y83O+Q==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:25 +0100
Subject: [PATCH net-next v8 10/19] net: ethernet: cortina: Separate RX
 buffer capacity from free queue size
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-10-f55bd43e02d3@kernel.org>
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

Containing a retained hardware read pointer can force an order-15 free
queue even when the configured RX rings need far fewer buffers. Filling
that descriptor ring requires nearly 64 MiB of pages on systems with
32 to 128 MiB of RAM. Allocation failure persists across retries because
the stopped DMA engine cannot advance the pointer.

Keep the descriptor geometry required by the retained pointer, but size
the RX buffer budget from the configured port rings. Bound the posted
occupancy and refill work by that budget, including after dropping the
free queue lock to allocate a page. Size page metadata and the NAPI refill
threshold from the same budget.

For a retained pointer of 16384 and a requested buffer order of 10, this
keeps the 512 KiB descriptor ring but posts 2044 KiB of RX pages instead
of 65532 KiB. No hardware pointer-reset behaviour is assumed.

Found by review and checked with a ring-geometry model covering every
supported retained pointer and buffer order.

Fixes: 0bf8c8c94af2 ("net: ethernet: cortina: Normalize free queue pointers on rebuild")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 40 ++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index aedd8eca3f15..72d2c002f8fc 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -168,6 +168,7 @@ struct gemini_ethernet {
 
 	spinlock_t	irq_lock; /* Locks IRQ-related registers */
 	unsigned int	freeq_order;
+	unsigned int	freeq_buf_order; /* RX buffer budget, independent of ring size */
 	unsigned int	freeq_frag_order;
 	struct gmac_rxdesc *freeq_ring;
 	dma_addr_t	freeq_dma_base;
@@ -1099,15 +1100,17 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 	unsigned int fragments = 1 << fpp_order;
 	unsigned int len = 1 << geth->freeq_order;
 	unsigned int ring_mask = len - 1;
-	unsigned int remaining = geth->num_freeq_pages + (len >> fpp_order);
+	unsigned int buf_len = 1 << geth->freeq_buf_order;
+	unsigned int capacity = buf_len - fragments;
+	unsigned int remaining = geth->num_freeq_pages + (buf_len >> fpp_order);
 	unsigned int count = 0;
 	unsigned int rptr, wptr;
 	unsigned long flags;
 	union dma_rwptr rw;
 	bool space;
 
-	/* Bound retries and post at most one ring's worth of fragments. */
-	while (remaining-- && count < len - fragments) {
+	/* Bound retries and post at most one buffer budget per refill. */
+	while (remaining-- && count < capacity) {
 		dma_addr_t page_mapping;
 		struct page *page;
 		int ret;
@@ -1116,7 +1119,8 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 		rptr = rw.bits.rptr & ring_mask;
 		wptr = rw.bits.wptr & ring_mask;
-		space = CIRC_SPACE(wptr, rptr, len) >= fragments;
+		space = CIRC_SPACE(wptr, rptr, len) >= fragments &&
+			CIRC_CNT(wptr, rptr, len) <= capacity - fragments;
 		ret = -ENOSPC;
 		if (space && geth->freeq_recycle_pending) {
 			ret = geth_freeq_recycle_page(geth, wptr);
@@ -1143,7 +1147,8 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 		rptr = rw.bits.rptr & ring_mask;
 		wptr = rw.bits.wptr & ring_mask;
-		if (CIRC_SPACE(wptr, rptr, len) < fragments) {
+		if (CIRC_SPACE(wptr, rptr, len) < fragments ||
+		    CIRC_CNT(wptr, rptr, len) > capacity - fragments) {
 			ret = -ENOSPC;
 		} else if (geth->freeq_recycle_pending) {
 			ret = -EAGAIN;
@@ -1213,10 +1218,10 @@ static void geth_freeq_release_pages(struct gemini_ethernet *geth)
 }
 
 static unsigned int
-geth_freeq_page_slots(struct gemini_ethernet *geth, unsigned int order)
+geth_freeq_page_slots(struct gemini_ethernet *geth, unsigned int buf_order)
 {
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
-	unsigned int slots = 1 << (order - fpp_order);
+	unsigned int slots = 1 << (buf_order - fpp_order);
 
 	if (geth->port0 && geth->port0->netdev)
 		slots += 1 << geth->port0->rxq_order;
@@ -1237,7 +1242,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	unsigned int filled;
 	u16 rptr;
 
-	page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
+	page_slots = geth_freeq_page_slots(geth, geth->freeq_buf_order);
 
 	geth->freeq_ring = dma_alloc_coherent(geth->dev,
 		sizeof(*geth->freeq_ring) << geth->freeq_order,
@@ -1266,7 +1271,7 @@ static int geth_setup_freeq(struct gemini_ethernet *geth)
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 	SET_WPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG, rptr & (len - 1));
 
-	expected = len - (1 << fpp_order);
+	expected = (1 << geth->freeq_buf_order) - (1 << fpp_order);
 	filled = geth_fill_freeq(geth);
 	if (filled != expected)
 		goto err_freeq_bitmap;
@@ -1367,6 +1372,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 	unsigned int new_size = 0;
 	unsigned int page_slots;
 	unsigned int new_order;
+	unsigned int buf_order;
 	u16 rptr;
 	int ret;
 
@@ -1396,20 +1402,23 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 			   other_port->rxq_order);
 	}
 
-	new_order = min(15, ilog2(new_size - 1) + 1);
+	buf_order = min(15, ilog2(new_size - 1) + 1);
+	if (buf_order <= PAGE_SHIFT - geth->freeq_frag_order)
+		return -EINVAL;
+
 	rptr = GET_RPTR(geth->base + GLOBAL_SWFQ_RWPTR_REG);
 	if (rptr >= BIT(15))
 		return -EIO;
-	new_order = max_t(unsigned int, new_order, fls(rptr));
+	/* Contain the retained pointer without increasing RX buffer memory. */
+	new_order = max_t(unsigned int, buf_order, fls(rptr));
 	dev_dbg(geth->dev, "set shared queue to size %d order %d\n",
 		new_size, new_order);
-	if (new_order <= PAGE_SHIFT - geth->freeq_frag_order)
-		return -EINVAL;
 
 	/* Rebuild an idle queue to reclaim fragments which were never claimed. */
 	if (geth->freeq_ring && other_running) {
-		page_slots = geth_freeq_page_slots(geth, geth->freeq_order);
+		page_slots = geth_freeq_page_slots(geth, buf_order);
 		if (geth->freeq_order >= new_order &&
+		    geth->freeq_buf_order >= buf_order &&
 		    geth->num_freeq_pages >= page_slots)
 			return 0;
 	}
@@ -1426,6 +1435,7 @@ static int geth_resize_freeq(struct gemini_ethernet_port *port)
 
 	/* Allocate a new queue with the desired order */
 	geth->freeq_order = new_order;
+	geth->freeq_buf_order = buf_order;
 	ret = geth_setup_freeq(geth);
 
 	/* Enable the queue interrupt only after successful setup. */
@@ -1927,7 +1937,7 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	unsigned int received;
 	bool reschedule;
 
-	freeq_threshold = 1 << (geth->freeq_order - 1);
+	freeq_threshold = 1 << (geth->freeq_buf_order - 1);
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
 	received = gmac_rx(napi->dev, budget, &freeq_consumed, &reschedule);

-- 
2.56.0

