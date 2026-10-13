Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EAE51C062;
	Tue, 13 Oct 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897437; cv=none; b=N66WiWNMMmnUWnx42IxU1SZRMOPCCOU2Kjn2ZZxbNU0pxN7nljYtB1NvFb27vvSnLqueReEhoet98L4/sgEIozM7mhmppK9jMqMk6Gd5SFlWI0zPdROcBTEMYfFAM9FPsQ6R+Df7/eGxwllbXPw8icLHrEKeApEFPDztQEDGcAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897437; c=relaxed/simple;
	bh=QWIwnxNsduM8vt+TX4ubsKINSqbfXusJyTQN9vDy7qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UtHE4Qznp2pBeLB71YmIlfWn3c0BW6zWDYDjFhfPhD/Z2TvrgEigN4mui/mcBK/CYbKUWcjucJmWagWVnElcYExVmY/pIDr9w6mxZ6KSw721bT83aFM2Gqg5dlbZt6qxJas+5FCX8HD3oWEi8tw4Ot5TFGmK3BtyxgfvZB1n+TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NUy1xHwI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NUy1xHwI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 37F121A120A;
	Tue, 13 Oct 2026 13:17:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B12760362;
	Tue, 13 Oct 2026 13:17:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C3DE811D713EB;
	Tue, 13 Oct 2026 15:17:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897431; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FeOKMqg2M4L/eYQuwfDlsN4DrKy/vosWTfmcFWfTb8g=;
	b=NUy1xHwI5B962DtBQHrNq8LyNxgZnOuzPv9AGr14ptL/L66TpCjsUDCRYg4oE/vMdIaNOV
	+4Nn0IZlm+vI/scbrd96P93wxltu1GWO9WgZDr14CDIsKmwRL14FxEUWhu6MeivyAI+Qv+
	Et8oBL0SIiC8dYseE/I9+dPDR54R74cCQl0nOizqYFj4EttejAoK1Px8bnAnReI6Dypv4i
	5bLinVAK+Q8osZvzN1dBnglLyHrHaYnFJ0s/XrznmWFCpF5HRkPvSSPX3geE5tu8grr5ij
	lyx7gt3+yxNnxzKY7nksSe19hOiEbqbzAqCHHuaos2itepSEKR3Fm3VJGk2uOQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 13 Oct 2026 15:16:44 +0200
Subject: [PATCH net-next v11 6/9] net: macb: change function signatures to
 take contexts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-macb-context-v11-6-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

For parallel MACB context to start become a reality, many functions need
to stop operating on bp->ctx (the currently active context) and instead
work on a context they get passed. That context might be
(1) the new one that is getting allocated and initialised, or,
(2) the old one to be freed.

To reduce bug surface area, taint those functions to *only* take a
context `struct macb_context *ctx` and no `struct macb *bp`. That way,
no bug of using `bp->ctx` instead of `ctx` will ever occur.

We also convert functions that take a `struct macb_queue *queue` to
instead take `struct macb_context *ctx, unsigned int q`, with q
indexing ctx->txq[] and ctx->rxq[].

Full list:

   macb_adj_dma_desc_idx()
   macb_tx_ring_wrap()
   macb_tx_desc()
   macb_rx_ring_wrap()
   macb_rx_desc()
   macb_get_addr()
   gem_rx_refill()
   macb_init_rx_ring()
   gem_free_rx_buffers()
   macb_free_rx_buffers()
   macb_tx_ring_size_per_queue()
   macb_rx_ring_size_per_queue()
   macb_free()
   gem_alloc_rx_buffers()
   macb_alloc_rx_buffers()
   macb_alloc()
   gem_init_rx_ring()
   gem_init_rings()
   macb_init_rings()

Note about gem_rx_refill(): it ends with a netdev_vdbg() that prints the
queue pointer. Change to print the queue index because we do not have
access to the queue anymore.

Note: functions that operate on the interface during its normal lifetime
do not need to be converted and have no risk of using the wrong
context. We do not allow concurrent swaps. When interface is alive,
there can only be one context alive.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   7 +-
 drivers/net/ethernet/cadence/macb_main.c | 391 ++++++++++++++++---------------
 2 files changed, 210 insertions(+), 188 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ddbab4c78bf4..ec2e2fbc1146 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1193,11 +1193,12 @@ static const struct gem_statistic queue_statistics[] = {
 
 struct macb;
 struct macb_queue;
+struct macb_context;
 
 struct macb_or_gem_ops {
-	int	(*mog_alloc_rx_buffers)(struct macb *bp);
-	void	(*mog_free_rx_buffers)(struct macb *bp);
-	int	(*mog_init_rings)(struct macb *bp);
+	int	(*mog_alloc_rx_buffers)(struct macb_context *ctx);
+	void	(*mog_free_rx_buffers)(struct macb_context *ctx);
+	int	(*mog_init_rings)(struct macb_context *ctx);
 	int	(*mog_rx)(struct macb_queue *queue, struct napi_struct *napi,
 			  int budget);
 };
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index ac5660480840..05169bbe2efc 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -138,9 +138,11 @@ static unsigned int macb_dma_desc_get_size(const struct macb_info *info)
 	return desc_size;
 }
 
-static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
+static unsigned int macb_adj_dma_desc_idx(struct macb_context *ctx,
+					  unsigned int desc_idx)
 {
-	return desc_idx * (1 + macb_dma64(&bp->info) + macb_dma_ptp(&bp->info));
+	return desc_idx * (1 + macb_dma64(ctx->info) +
+			       macb_dma_ptp(ctx->info));
 }
 
 static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
@@ -150,9 +152,10 @@ static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
 }
 
 /* Ring buffer accessors */
-static unsigned int macb_tx_ring_wrap(struct macb *bp, unsigned int index)
+static unsigned int macb_tx_ring_wrap(struct macb_context *ctx,
+				      unsigned int index)
 {
-	return index & (bp->ctx->tx_ring_size - 1);
+	return index & (ctx->tx_ring_size - 1);
 }
 
 static struct macb_txq *macb_txq(struct macb_queue *queue)
@@ -171,14 +174,13 @@ static struct macb_rxq *macb_rxq(struct macb_queue *queue)
 	return &bp->ctx->rxq[q];
 }
 
-static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
+static struct macb_dma_desc *macb_tx_desc(struct macb_context *ctx,
+					  unsigned int q,
 					  unsigned int index)
 {
-	struct macb_txq *txq = macb_txq(queue);
-
-	index = macb_tx_ring_wrap(queue->bp, index);
-	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &txq->ring[index];
+	index = macb_tx_ring_wrap(ctx, index);
+	index = macb_adj_dma_desc_idx(ctx, index);
+	return &ctx->txq[q].ring[index];
 }
 
 static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
@@ -186,40 +188,42 @@ static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
 {
 	struct macb_txq *txq = macb_txq(queue);
 
-	return &txq->skb[macb_tx_ring_wrap(queue->bp, index)];
+	return &txq->skb[macb_tx_ring_wrap(queue->bp->ctx, index)];
 }
 
 static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	dma_addr_t offset;
 
-	offset = macb_tx_ring_wrap(queue->bp, index) *
+	offset = macb_tx_ring_wrap(ctx, index) *
 			macb_dma_desc_get_size(&queue->bp->info);
 
 	return txq->ring_dma + offset;
 }
 
-static unsigned int macb_rx_ring_wrap(struct macb *bp, unsigned int index)
+static unsigned int macb_rx_ring_wrap(struct macb_context *ctx,
+				      unsigned int index)
 {
-	return index & (bp->ctx->rx_ring_size - 1);
+	return index & (ctx->rx_ring_size - 1);
 }
 
-static struct macb_dma_desc *macb_rx_desc(struct macb_queue *queue, unsigned int index)
+static struct macb_dma_desc *macb_rx_desc(struct macb_context *ctx,
+					  unsigned int q, unsigned int index)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
-
-	index = macb_rx_ring_wrap(queue->bp, index);
-	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &rxq->ring[index];
+	index = macb_rx_ring_wrap(ctx, index);
+	index = macb_adj_dma_desc_idx(ctx, index);
+	return &ctx->rxq[q].ring[index];
 }
 
 static void *macb_rx_buffer(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 
-	return rxq->buffers + queue->bp->ctx->rx_buffer_size *
-	       macb_rx_ring_wrap(queue->bp, index);
+	return rxq->buffers + ctx->rx_buffer_size *
+	       macb_rx_ring_wrap(ctx, index);
 }
 
 /* I/O accessors */
@@ -841,13 +845,14 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	unsigned int head, tail, count, ring_size, desc_size;
 	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
 	struct macb_dma_desc *desc_curr, *desc_next;
+	unsigned int q = queue - queue->bp->queues;
 	unsigned int i, cycles, shift, curr, next;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
-	struct macb *bp = queue->bp;
 	unsigned char desc[24];
 	unsigned long flags;
 
-	desc_size = macb_dma_desc_get_size(&bp->info);
+	desc_size = macb_dma_desc_get_size(&queue->bp->info);
 
 	if (WARN_ON_ONCE(desc_size > ARRAY_SIZE(desc)))
 		return;
@@ -855,7 +860,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 	head = txq->head;
 	tail = txq->tail;
-	ring_size = bp->ctx->tx_ring_size;
+	ring_size = ctx->tx_ring_size;
 	count = CIRC_CNT(head, tail, ring_size);
 
 	if (!(tail % ring_size))
@@ -871,7 +876,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	cycles = gcd(ring_size, shift);
 
 	for (i = 0; i < cycles; i++) {
-		memcpy(&desc, macb_tx_desc(queue, i), desc_size);
+		memcpy(&desc, macb_tx_desc(ctx, q, i), desc_size);
 		memcpy(&tx_skb, macb_tx_skb(queue, i),
 		       sizeof(struct macb_tx_skb));
 
@@ -879,8 +884,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		next = (curr + shift) % ring_size;
 
 		while (next != i) {
-			desc_curr = macb_tx_desc(queue, curr);
-			desc_next = macb_tx_desc(queue, next);
+			desc_curr = macb_tx_desc(ctx, q, curr);
+			desc_next = macb_tx_desc(ctx, q, next);
 
 			memcpy(desc_curr, desc_next, desc_size);
 
@@ -897,7 +902,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 			next = (curr + shift) % ring_size;
 		}
 
-		desc_curr = macb_tx_desc(queue, curr);
+		desc_curr = macb_tx_desc(ctx, q, curr);
 		memcpy(desc_curr, &desc, desc_size);
 		if (i == ring_size - 1)
 			desc_curr->ctrl &= ~MACB_BIT(TX_WRAP);
@@ -1291,19 +1296,19 @@ static void macb_set_addr(const struct macb_info *info,
 	desc->addr = lower_32_bits(addr);
 }
 
-static dma_addr_t macb_get_addr(const struct macb_info *info,
+static dma_addr_t macb_get_addr(struct macb_context *ctx,
 				struct macb_dma_desc *desc)
 {
 	dma_addr_t addr = 0;
 
-	if (macb_dma64(info)) {
+	if (macb_dma64(ctx->info)) {
 		struct macb_dma_desc_64 *desc_64;
 
 		desc_64 = macb_64b_desc(desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-	if (macb_dma_ptp(info))
+	if (macb_dma_ptp(ctx->info))
 		addr &= ~GEM_BIT(DMA_RXVALID);
 	return addr;
 }
@@ -1313,6 +1318,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_queue *queue = container_of(work, struct macb_queue,
 						tx_error_task);
 	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_tx_skb *tx_skb;
@@ -1355,7 +1361,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	for (tail = txq->tail; tail != txq->head; tail++) {
 		u32	ctrl;
 
-		desc = macb_tx_desc(queue, tail);
+		desc = macb_tx_desc(ctx, q, tail);
 		ctrl = desc->ctrl;
 		tx_skb = macb_tx_skb(queue, tail);
 		skb = tx_skb->skb;
@@ -1374,7 +1380,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			 */
 			if (!(ctrl & MACB_BIT(TX_BUF_EXHAUSTED))) {
 				netdev_vdbg(bp->netdev, "txerr skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
+					    macb_tx_ring_wrap(ctx, tail),
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
@@ -1401,7 +1407,7 @@ static void macb_tx_error_task(struct work_struct *work)
 				  packets, bytes);
 
 	/* Set end of TX queue */
-	desc = macb_tx_desc(queue, 0);
+	desc = macb_tx_desc(ctx, q, 0);
 	macb_set_addr(&bp->info, desc, 0);
 	desc->ctrl = MACB_BIT(TX_USED);
 
@@ -1471,6 +1477,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	struct macb *bp = queue->bp;
 	struct macb_txq *txq = macb_txq(queue);
 	unsigned int q = queue - bp->queues;
+	struct macb_context *ctx = bp->ctx;
 	unsigned long flags;
 	unsigned int tail;
 	unsigned int head;
@@ -1485,7 +1492,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 		struct macb_dma_desc	*desc;
 		u32			ctrl;
 
-		desc = macb_tx_desc(queue, tail);
+		desc = macb_tx_desc(ctx, q, tail);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
@@ -1510,7 +1517,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 					gem_ptp_do_txstamp(bp, skb, desc);
 
 				netdev_vdbg(bp->netdev, "skb %u (data %p) TX complete\n",
-					    macb_tx_ring_wrap(bp, tail),
+					    macb_tx_ring_wrap(ctx, tail),
 					    skb->data);
 				bp->netdev->stats.tx_packets++;
 				queue->stats.tx_packets++;
@@ -1548,53 +1555,53 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	return packets;
 }
 
-static int gem_rx_refill(struct macb_queue *queue)
+static int gem_rx_refill(struct macb_context *ctx, unsigned int q)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
-	struct macb *bp = queue->bp;
+	struct device *dev = &ctx->info->pdev->dev;
+	struct macb_rxq *rxq = &ctx->rxq[q];
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
 	unsigned int entry;
 	dma_addr_t paddr;
 
 	while (CIRC_SPACE(rxq->prepared_head, rxq->tail,
-			  bp->ctx->rx_ring_size) > 0) {
-		entry = macb_rx_ring_wrap(bp, rxq->prepared_head);
+			  ctx->rx_ring_size) > 0) {
+		entry = macb_rx_ring_wrap(ctx, rxq->prepared_head);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		desc = macb_rx_desc(queue, entry);
+		desc = macb_rx_desc(ctx, q, entry);
 
 		if (!rxq->skbuff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->netdev,
-					       bp->ctx->rx_buffer_size);
+			skb = netdev_alloc_skb(ctx->info->netdev,
+					       ctx->rx_buffer_size);
 			if (unlikely(!skb)) {
-				netdev_err(bp->netdev,
+				netdev_err(ctx->info->netdev,
 					   "Unable to allocate sk_buff\n");
 				break;
 			}
 
 			/* now fill corresponding descriptor entry */
-			paddr = dma_map_single(&bp->pdev->dev, skb->data,
-					       bp->ctx->rx_buffer_size,
+			paddr = dma_map_single(dev, skb->data,
+					       ctx->rx_buffer_size,
 					       DMA_FROM_DEVICE);
-			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
+			if (dma_mapping_error(dev, paddr)) {
 				dev_kfree_skb(skb);
 				break;
 			}
 
 			rxq->skbuff[entry] = skb;
 
-			if (entry == bp->ctx->rx_ring_size - 1)
+			if (entry == ctx->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
 			desc->ctrl = 0;
 			/* Setting addr clears RX_USED and allows reception,
 			 * make sure ctrl is cleared first to avoid a race.
 			 */
 			dma_wmb();
-			macb_set_addr(&bp->info, desc, paddr);
+			macb_set_addr(ctx->info, desc, paddr);
 
 			/* Properly align Ethernet header.
 			 *
@@ -1607,7 +1614,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 			 * setting the low 2/3 bits.
 			 * It is 3 bits if HW_DMA_CAP_PTP, else 2 bits.
 			 */
-			if (!(bp->caps & MACB_CAPS_RSC))
+			if (!(ctx->info->caps & MACB_CAPS_RSC))
 				skb_reserve(skb, NET_IP_ALIGN);
 		} else {
 			desc->ctrl = 0;
@@ -1620,8 +1627,9 @@ static int gem_rx_refill(struct macb_queue *queue)
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
-	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
-		    queue, rxq->prepared_head, rxq->tail);
+	netdev_vdbg(ctx->info->netdev,
+		    "rx ring: queue: %u, prepared head %d, tail %d\n",
+		    q, rxq->prepared_head, rxq->tail);
 
 	/* Fail if queue has zero prepared descriptors. This is critical because
 	 * nothing will ever trigger a refill again.
@@ -1636,10 +1644,12 @@ static int gem_rx_refill(struct macb_queue *queue)
 static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 				  unsigned int end)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	unsigned int frag;
 
 	for (frag = begin; frag != end; frag++) {
-		struct macb_dma_desc *desc = macb_rx_desc(queue, frag);
+		struct macb_dma_desc *desc = macb_rx_desc(ctx, q, frag);
 
 		desc->addr &= ~MACB_BIT(RX_USED);
 	}
@@ -1656,6 +1666,8 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
@@ -1676,14 +1688,14 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		if (rxq->tail == rxq->prepared_head)
 			break;
 
-		entry = macb_rx_ring_wrap(bp, rxq->tail);
-		desc = macb_rx_desc(queue, entry);
+		entry = macb_rx_ring_wrap(ctx, rxq->tail);
+		desc = macb_rx_desc(ctx, q, entry);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
-		addr = macb_get_addr(&bp->info, desc);
+		addr = macb_get_addr(ctx, desc);
 
 		if (!rxused)
 			break;
@@ -1748,7 +1760,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		napi_gro_receive(napi, skb);
 	}
 
-	gem_rx_refill(queue);
+	gem_rx_refill(ctx, q);
 
 	return count;
 }
@@ -1756,6 +1768,8 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 			 unsigned int first_frag, unsigned int last_frag)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int offset;
@@ -1763,13 +1777,13 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	unsigned int frag;
 	unsigned int len;
 
-	desc = macb_rx_desc(queue, last_frag);
+	desc = macb_rx_desc(ctx, q, last_frag);
 	len = desc->ctrl & bp->rx_frm_len_mask;
 
 	netdev_vdbg(bp->netdev, "%s frags %u - %u (len %u)\n",
 		    __func__,
-		    macb_rx_ring_wrap(bp, first_frag),
-		    macb_rx_ring_wrap(bp, last_frag), len);
+		    macb_rx_ring_wrap(ctx, first_frag),
+		    macb_rx_ring_wrap(ctx, last_frag), len);
 
 	/* The ethernet header starts NET_IP_ALIGN bytes into the
 	 * first buffer. Since the header is 14 bytes, this makes the
@@ -1783,7 +1797,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	if (!skb) {
 		bp->netdev->stats.rx_dropped++;
 		for (frag = first_frag; ; frag++) {
-			desc = macb_rx_desc(queue, frag);
+			desc = macb_rx_desc(ctx, q, frag);
 			desc->addr &= ~MACB_BIT(RX_USED);
 			if (frag == last_frag)
 				break;
@@ -1814,7 +1828,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 					       macb_rx_buffer(queue, frag),
 					       frag_len);
 		offset += bp->ctx->rx_buffer_size;
-		desc = macb_rx_desc(queue, frag);
+		desc = macb_rx_desc(ctx, q, frag);
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		if (frag == last_frag)
@@ -1836,20 +1850,19 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	return 0;
 }
 
-static inline void macb_init_rx_ring(struct macb_queue *queue)
+static inline void macb_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
-	struct macb_rxq *rxq = macb_rxq(queue);
+	struct macb_rxq *rxq = &ctx->rxq[q];
 	struct macb_dma_desc *desc = NULL;
-	struct macb *bp = queue->bp;
 	dma_addr_t addr;
 	int i;
 
 	addr = rxq->buffers_dma;
-	for (i = 0; i < bp->ctx->rx_ring_size; i++) {
-		desc = macb_rx_desc(queue, i);
-		macb_set_addr(&bp->info, desc, addr);
+	for (i = 0; i < ctx->rx_ring_size; i++) {
+		desc = macb_rx_desc(ctx, q, i);
+		macb_set_addr(ctx->info, desc, addr);
 		desc->ctrl = 0;
-		addr += bp->ctx->rx_buffer_size;
+		addr += ctx->rx_buffer_size;
 	}
 	desc->addr |= MACB_BIT(RX_WRAP);
 	rxq->tail = 0;
@@ -1858,6 +1871,8 @@ static inline void macb_init_rx_ring(struct macb_queue *queue)
 static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		   int budget)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
@@ -1866,7 +1881,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 	int received = 0;
 
 	for (tail = rxq->tail; budget > 0; tail++) {
-		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
+		struct macb_dma_desc *desc = macb_rx_desc(ctx, q, tail);
 		u32 ctrl;
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1918,7 +1933,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		ctrl = macb_readl(bp, NCR);
 		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 
-		macb_init_rx_ring(queue);
+		macb_init_rx_ring(ctx, q);
 		queue_writel(queue, RBQP, rxq->ring_dma);
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
@@ -1937,17 +1952,18 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 static bool macb_rx_pending(struct macb_queue *queue)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_rxq *rxq = macb_rxq(queue);
-	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int entry;
 
 	/* No armed descriptor left: nothing can be pending. */
-	if (macb_is_gem(&bp->info) && rxq->tail == rxq->prepared_head)
+	if (macb_is_gem(&queue->bp->info) && rxq->tail == rxq->prepared_head)
 		return false;
 
-	entry = macb_rx_ring_wrap(bp, rxq->tail);
-	desc = macb_rx_desc(queue, entry);
+	entry = macb_rx_ring_wrap(ctx, rxq->tail);
+	desc = macb_rx_desc(ctx, q, entry);
 
 	/* Make hw descriptor updates visible to CPU */
 	rmb();
@@ -1994,6 +2010,7 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 static void macb_tx_restart(struct macb_queue *queue)
 {
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
@@ -2004,9 +2021,9 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
-	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(&bp->info);
-	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
-	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
+	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(ctx->info);
+	tbqp = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, tbqp));
+	head_idx = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, txq->head));
 
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
@@ -2021,6 +2038,8 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
+	unsigned int q = queue - queue->bp->queues;
+	struct macb_context *ctx = queue->bp->ctx;
 	struct macb_txq *txq = macb_txq(queue);
 	bool retval = false;
 	unsigned long flags;
@@ -2030,7 +2049,7 @@ static bool macb_tx_complete_pending(struct macb_queue *queue)
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		if (macb_tx_desc(queue, txq->tail)->ctrl & MACB_BIT(TX_USED))
+		if (macb_tx_desc(ctx, q, txq->tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
@@ -2136,6 +2155,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 {
 	struct macb *bp = from_work(bp, work, hresp_err_bh_work);
 	struct net_device *netdev = bp->netdev;
+	struct macb_context *ctx = bp->ctx;
 	struct macb_queue *queue;
 	unsigned int q;
 	u32 ctrl;
@@ -2152,7 +2172,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	netif_tx_stop_all_queues(netdev);
 	netif_carrier_off(netdev);
 
-	bp->macbgem_ops.mog_init_rings(bp);
+	bp->macbgem_ops.mog_init_rings(ctx);
 
 	/* Initialize TX and RX buffers */
 	macb_init_buffers(bp);
@@ -2354,6 +2374,8 @@ static unsigned int macb_tx_map(struct macb *bp,
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
 	unsigned int len, i, tx_head = txq->head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
+	unsigned int q = queue - bp->queues;
+	struct macb_context *ctx = bp->ctx;
 	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
 	struct macb_dma_desc *desc;
@@ -2445,7 +2467,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	 */
 	i = tx_head;
 	ctrl = MACB_BIT(TX_USED);
-	desc = macb_tx_desc(queue, i);
+	desc = macb_tx_desc(ctx, q, i);
 	desc->ctrl = ctrl;
 
 	if (lso_ctrl) {
@@ -2466,14 +2488,14 @@ static unsigned int macb_tx_map(struct macb *bp,
 	do {
 		i--;
 		tx_skb = macb_tx_skb(queue, i);
-		desc = macb_tx_desc(queue, i);
+		desc = macb_tx_desc(ctx, q, i);
 
 		ctrl = (u32)tx_skb->size;
 		if (eof) {
 			ctrl |= MACB_BIT(TX_LAST);
 			eof = 0;
 		}
-		if (unlikely(macb_tx_ring_wrap(bp, i) ==
+		if (unlikely(macb_tx_ring_wrap(ctx, i) ==
 				bp->ctx->tx_ring_size - 1))
 			ctrl |= MACB_BIT(TX_WRAP);
 
@@ -2769,33 +2791,32 @@ static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 	return size;
 }
 
-static void gem_free_rx_buffers(struct macb *bp)
+static void gem_free_rx_buffers(struct macb_context *ctx)
 {
+	struct device *dev = &ctx->info->pdev->dev;
 	struct macb_dma_desc *desc;
-	struct macb_queue *queue;
 	struct macb_rxq *rxq;
 	struct sk_buff *skb;
 	dma_addr_t addr;
 	unsigned int q;
 	int i;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		rxq = &bp->ctx->rxq[q];
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		rxq = &ctx->rxq[q];
 
 		if (!rxq->skbuff)
 			continue;
 
-		for (i = 0; i < bp->ctx->rx_ring_size; i++) {
+		for (i = 0; i < ctx->rx_ring_size; i++) {
 			skb = rxq->skbuff[i];
 
 			if (!skb)
 				continue;
 
-			desc = macb_rx_desc(queue, i);
-			addr = macb_get_addr(&bp->info, desc);
+			desc = macb_rx_desc(ctx, q, i);
+			addr = macb_get_addr(ctx, desc);
 
-			dma_unmap_single(&bp->pdev->dev, addr,
-					 bp->ctx->rx_buffer_size,
+			dma_unmap_single(dev, addr, ctx->rx_buffer_size,
 					 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			skb = NULL;
@@ -2806,67 +2827,66 @@ static void gem_free_rx_buffers(struct macb *bp)
 	}
 }
 
-static void macb_free_rx_buffers(struct macb *bp)
+static void macb_free_rx_buffers(struct macb_context *ctx)
 {
-	struct macb_rxq *rxq = &bp->ctx->rxq[0];
+	struct device *dev = &ctx->info->pdev->dev;
+	struct macb_rxq *rxq = &ctx->rxq[0];
 
 	if (rxq->buffers) {
-		dma_free_coherent(&bp->pdev->dev,
-				  bp->ctx->rx_ring_size *
-					bp->ctx->rx_buffer_size,
+		dma_free_coherent(dev,
+				  ctx->rx_ring_size * ctx->rx_buffer_size,
 				  rxq->buffers, rxq->buffers_dma);
 		rxq->buffers = NULL;
 	}
 }
 
-static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
+static unsigned int macb_tx_ring_size_per_queue(struct macb_context *ctx)
 {
-	return macb_dma_desc_get_size(&bp->info) * bp->ctx->tx_ring_size +
-		bp->tx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(ctx->info) * ctx->tx_ring_size +
+			ctx->info->tx_bd_rd_prefetch;
 }
 
-static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
+static unsigned int macb_rx_ring_size_per_queue(struct macb_context *ctx)
 {
-	return macb_dma_desc_get_size(&bp->info) * bp->ctx->rx_ring_size +
-		bp->rx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(ctx->info) * ctx->rx_ring_size +
+			ctx->info->rx_bd_rd_prefetch;
 }
 
-static void macb_free(struct macb *bp)
+static void macb_free(struct macb_context *ctx)
 {
-	struct device *dev = &bp->pdev->dev;
-	struct macb_queue *queue;
+	struct device *dev = &ctx->info->pdev->dev;
 	struct macb_txq *txq;
 	struct macb_rxq *rxq;
 	unsigned int q;
 	size_t size;
 
-	bp->macbgem_ops.mog_free_rx_buffers(bp);
+	ctx->info->macbgem_ops.mog_free_rx_buffers(ctx);
 
-	txq = &bp->ctx->txq[0];
-	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	txq = &ctx->txq[0];
+	size = ctx->info->num_queues * macb_tx_ring_size_per_queue(ctx);
 	dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
 
-	rxq = &bp->ctx->rxq[0];
-	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	rxq = &ctx->rxq[0];
+	size = ctx->info->num_queues * macb_rx_ring_size_per_queue(ctx);
 	dma_free_coherent(dev, size, rxq->ring, rxq->ring_dma);
 
-	for (q = 0; q < bp->num_queues; ++q) {
-		txq = &bp->ctx->txq[q];
-		rxq = &bp->ctx->rxq[q];
-		queue = &bp->queues[q];
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		txq = &ctx->txq[q];
+		rxq = &ctx->rxq[q];
 
 		if (txq->skb) {
 			unsigned int dropped = 0, tail;
 
 			for (tail = txq->tail; tail != txq->head; tail++) {
-				if (macb_tx_skb(queue, tail)->skb)
+				if (txq->skb[macb_tx_ring_wrap(ctx, tail)].skb)
 					dropped++;
-				macb_tx_unmap(&bp->info,
-					      macb_tx_skb(queue, tail), 0);
+				macb_tx_unmap(ctx->info,
+					      &txq->skb[macb_tx_ring_wrap(ctx, tail)],
+					      0);
 			}
 
-			queue->stats.tx_dropped += dropped;
-			bp->netdev->stats.tx_dropped += dropped;
+			ctx->info->queue_stats[q]->tx_dropped += dropped;
+			ctx->info->netdev->stats.tx_dropped += dropped;
 
 			kfree(txq->skb);
 			txq->skb = NULL;
@@ -2877,46 +2897,48 @@ static void macb_free(struct macb *bp)
 	}
 }
 
-static int gem_alloc_rx_buffers(struct macb *bp)
+static int gem_alloc_rx_buffers(struct macb_context *ctx)
 {
 	struct macb_rxq *rxq;
 	unsigned int q;
 	int size;
 
-	for (q = 0; q < bp->num_queues; ++q) {
-		rxq = &bp->ctx->rxq[q];
-		size = bp->ctx->rx_ring_size * sizeof(struct sk_buff *);
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		rxq = &ctx->rxq[q];
+		size = ctx->rx_ring_size * sizeof(struct sk_buff *);
 		rxq->skbuff = kzalloc(size, GFP_KERNEL);
 		if (!rxq->skbuff)
 			return -ENOMEM;
 		else
-			netdev_dbg(bp->netdev,
+			netdev_dbg(ctx->info->netdev,
 				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->ctx->rx_ring_size, rxq->skbuff);
+				   ctx->rx_ring_size, rxq->skbuff);
 	}
 	return 0;
 }
 
-static int macb_alloc_rx_buffers(struct macb *bp)
+static int macb_alloc_rx_buffers(struct macb_context *ctx)
 {
-	struct macb_rxq *rxq = &bp->ctx->rxq[0];
+	struct device *dev = &ctx->info->pdev->dev;
+	struct macb_rxq *rxq = &ctx->rxq[0];
 	int size;
 
-	size = bp->ctx->rx_ring_size * bp->ctx->rx_buffer_size;
-	rxq->buffers = dma_alloc_coherent(&bp->pdev->dev, size,
+	size = ctx->rx_ring_size * ctx->rx_buffer_size;
+	rxq->buffers = dma_alloc_coherent(dev, size,
 					  &rxq->buffers_dma, GFP_KERNEL);
 	if (!rxq->buffers)
 		return -ENOMEM;
 
-	netdev_dbg(bp->netdev,
+	netdev_dbg(ctx->info->netdev,
 		   "Allocated RX buffers of %d bytes at %08lx (mapped %p)\n",
 		   size, (unsigned long)rxq->buffers_dma, rxq->buffers);
 	return 0;
 }
 
-static int macb_alloc(struct macb *bp)
+static int macb_alloc(struct macb_context *ctx)
 {
-	struct device *dev = &bp->pdev->dev;
+	unsigned int num_queues = ctx->info->num_queues;
+	struct device *dev = &ctx->info->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
 	struct macb_txq *txq;
 	struct macb_rxq *rxq;
@@ -2931,75 +2953,75 @@ static int macb_alloc(struct macb *bp)
 	 * natural alignment of physical addresses.
 	 */
 
-	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
+	size = num_queues * macb_tx_ring_size_per_queue(ctx);
 	tx = dma_alloc_coherent(dev, size, &tx_dma, GFP_KERNEL);
 	if (!tx)
 		goto out_err;
 	/* Record the buffer so that the error path frees it. */
-	txq = &bp->ctx->txq[0];
+	txq = &ctx->txq[0];
 	txq->ring = tx;
 	txq->ring_dma = tx_dma;
 	if (upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
-	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
-		   size, bp->num_queues, (unsigned long)tx_dma, tx);
+	netdev_dbg(ctx->info->netdev,
+		   "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
+		   size, num_queues, (unsigned long)tx_dma, tx);
 
-	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
+	size = num_queues * macb_rx_ring_size_per_queue(ctx);
 	rx = dma_alloc_coherent(dev, size, &rx_dma, GFP_KERNEL);
 	if (!rx)
 		goto out_err;
 	/* Record the buffer so that the error path frees it. */
-	rxq = &bp->ctx->rxq[0];
+	rxq = &ctx->rxq[0];
 	rxq->ring = rx;
 	rxq->ring_dma = rx_dma;
 	if (upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
-	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
-		   size, bp->num_queues, (unsigned long)rx_dma, rx);
+	netdev_dbg(ctx->info->netdev,
+		   "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
+		   size, num_queues, (unsigned long)rx_dma, rx);
 
-	for (q = 0; q < bp->num_queues; ++q) {
-		txq = &bp->ctx->txq[q];
-		rxq = &bp->ctx->rxq[q];
+	for (q = 0; q < num_queues; ++q) {
+		txq = &ctx->txq[q];
+		rxq = &ctx->rxq[q];
 
-		txq->ring = tx + macb_tx_ring_size_per_queue(bp) * q;
-		txq->ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
+		txq->ring = tx + macb_tx_ring_size_per_queue(ctx) * q;
+		txq->ring_dma = tx_dma + macb_tx_ring_size_per_queue(ctx) * q;
 
-		rxq->ring = rx + macb_rx_ring_size_per_queue(bp) * q;
-		rxq->ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
+		rxq->ring = rx + macb_rx_ring_size_per_queue(ctx) * q;
+		rxq->ring_dma = rx_dma + macb_rx_ring_size_per_queue(ctx) * q;
 
-		size = bp->ctx->tx_ring_size * sizeof(struct macb_tx_skb);
+		size = ctx->tx_ring_size * sizeof(struct macb_tx_skb);
 		txq->skb = kmalloc(size, GFP_KERNEL);
 		if (!txq->skb)
 			goto out_err;
 	}
-	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
+	if (ctx->info->macbgem_ops.mog_alloc_rx_buffers(ctx))
 		goto out_err;
 
 	return 0;
 
 out_err:
-	macb_free(bp);
+	macb_free(ctx);
 	return -ENOMEM;
 }
 
-static int gem_init_rx_ring(struct macb_queue *queue)
+static int gem_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
-	struct macb_context *ctx = queue->bp->ctx;
-	struct macb_rxq *rxq = macb_rxq(queue);
+	struct macb_rxq *rxq = &ctx->rxq[q];
 	unsigned int i;
 
 	rxq->tail = 0;
 	rxq->prepared_head = 0;
 
 	for (i = 0; i < ctx->rx_ring_size; i++)
-		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
+		macb_rx_desc(ctx, q, i)->addr |= MACB_BIT(RX_USED);
 
-	return gem_rx_refill(queue);
+	return gem_rx_refill(ctx, q);
 }
 
-static int gem_init_rings(struct macb *bp)
+static int gem_init_rings(struct macb_context *ctx)
 {
-	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
 	struct macb_txq *txq;
 	int last_err = 0;
@@ -3007,18 +3029,18 @@ static int gem_init_rings(struct macb *bp)
 	int err;
 	int i;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		txq = &bp->ctx->txq[q];
-		for (i = 0; i < bp->ctx->tx_ring_size; i++) {
-			desc = macb_tx_desc(queue, i);
-			macb_set_addr(&bp->info, desc, 0);
+	for (q = 0; q < ctx->info->num_queues; ++q) {
+		txq = &ctx->txq[q];
+		for (i = 0; i < ctx->tx_ring_size; i++) {
+			desc = macb_tx_desc(ctx, q, i);
+			macb_set_addr(ctx->info, desc, 0);
 			desc->ctrl = MACB_BIT(TX_USED);
 		}
 		desc->ctrl |= MACB_BIT(TX_WRAP);
 		txq->head = 0;
 		txq->tail = 0;
 
-		err = gem_init_rx_ring(queue);
+		err = gem_init_rx_ring(ctx, q);
 		if (err)
 			last_err = err;
 	}
@@ -3026,17 +3048,17 @@ static int gem_init_rings(struct macb *bp)
 	return last_err;
 }
 
-static int macb_init_rings(struct macb *bp)
+static int macb_init_rings(struct macb_context *ctx)
 {
-	struct macb_txq *txq = &bp->ctx->txq[0];
+	struct macb_txq *txq = &ctx->txq[0];
 	struct macb_dma_desc *desc = NULL;
 	int i;
 
-	macb_init_rx_ring(&bp->queues[0]);
+	macb_init_rx_ring(ctx, 0);
 
-	for (i = 0; i < bp->ctx->tx_ring_size; i++) {
-		desc = macb_tx_desc(&bp->queues[0], i);
-		macb_set_addr(&bp->info, desc, 0);
+	for (i = 0; i < ctx->tx_ring_size; i++) {
+		desc = macb_tx_desc(ctx, 0, i);
+		macb_set_addr(ctx->info, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
 	txq->head = 0;
@@ -3376,14 +3398,14 @@ static int macb_open(struct net_device *netdev)
 	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
 	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 
-	err = macb_alloc(bp);
+	err = macb_alloc(bp->ctx);
 	if (err) {
 		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
 		goto free_ctx;
 	}
 
-	err = bp->macbgem_ops.mog_init_rings(bp);
+	err = bp->macbgem_ops.mog_init_rings(bp->ctx);
 	if (err)
 		goto free_rings;
 	macb_init_buffers(bp);
@@ -3420,7 +3442,7 @@ static int macb_open(struct net_device *netdev)
 
 	macb_reset_hw(bp);
 free_rings:
-	macb_free(bp);
+	macb_free(bp->ctx);
 free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
@@ -3454,7 +3476,7 @@ static int macb_close(struct net_device *netdev)
 	netif_carrier_off(netdev);
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	macb_free(bp);
+	macb_free(bp->ctx);
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 
@@ -3833,8 +3855,8 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 
 	if (bp->ctx) {
 		txq = &bp->ctx->txq[0];
-		tail = macb_tx_ring_wrap(bp, txq->tail);
-		head = macb_tx_ring_wrap(bp, txq->head);
+		tail = macb_tx_ring_wrap(bp->ctx, txq->tail);
+		head = macb_tx_ring_wrap(bp->ctx, txq->head);
 		tx_dma_tail = macb_tx_dma(&bp->queues[0], tail);
 		tx_dma_head = macb_tx_dma(&bp->queues[0], head);
 	}
@@ -5229,7 +5251,6 @@ static void at91ether_free_coherent(struct macb *bp)
 /* Initialize and start the Receiver and Transmit subsystems */
 static int at91ether_start(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
 	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
@@ -5242,7 +5263,7 @@ static int at91ether_start(struct macb *bp)
 
 	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
-		desc = macb_rx_desc(queue, i);
+		desc = macb_rx_desc(bp->ctx, 0, i);
 		macb_set_addr(&bp->info, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
@@ -5408,14 +5429,13 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 static void at91ether_rx(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
-	struct macb_queue *queue = &bp->queues[0];
 	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
 	struct sk_buff *skb;
 	unsigned int pktlen;
 
-	desc = macb_rx_desc(queue, rxq->tail);
+	desc = macb_rx_desc(bp->ctx, 0, rxq->tail);
 	while (desc->addr & MACB_BIT(RX_USED)) {
 		p_recv = rxq->buffers + rxq->tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
@@ -5444,7 +5464,7 @@ static void at91ether_rx(struct net_device *netdev)
 		else
 			rxq->tail++;
 
-		desc = macb_rx_desc(queue, rxq->tail);
+		desc = macb_rx_desc(bp->ctx, 0, rxq->tail);
 	}
 }
 
@@ -6414,6 +6434,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_context *ctx = bp->ctx;
 	struct macb_queue *queue;
 	unsigned long flags;
 	unsigned int q;
@@ -6459,9 +6480,9 @@ static int __maybe_unused macb_resume(struct device *dev)
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 			if (macb_is_gem(&bp->info))
-				gem_init_rx_ring(queue);
+				gem_init_rx_ring(ctx, q);
 			else
-				macb_init_rx_ring(queue);
+				macb_init_rx_ring(ctx, q);
 		}
 
 		napi_enable(&queue->napi_rx);

-- 
2.56.0

