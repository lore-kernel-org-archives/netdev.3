Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB551475A;
	Tue, 13 Oct 2026 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897424; cv=none; b=n1NXDcBVO/hERengNEbRRwJv1x7jSiwl3NzlAJM9VaqlxkDVJ1qTK8G9LKDgx6/pdewJrysh1l0wtYzOYgG+RCQTGm8GVr4jnzn0X57f0IM/zrkBIqnyjutCn7/7ka9uI1sTdyN7XHq/98NELQNg53aLZbGKPk83cSnUrYYt0+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897424; c=relaxed/simple;
	bh=YWK4+To5rFKWwGvodnk3DuRZYAogC8j7L//Rs7lij3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9T1tXQlMZ1dfpoe+M2s0Y2rqLfyY31mEqUhsZZvYrhgg1ySjYsjHJpwq1VRZSLFbnSd138PGyL61j26AEXkCS6GqJUZjWlY1D+pi+fzEZgSkTJHc8WN0i9/T+fOJNpEZoUCiIf75RZ66p/f+QeqgBh1llSMk3B2VUXdkl73vyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PHc8JUXZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PHc8JUXZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1EADB4E411FB;
	Tue, 13 Oct 2026 13:17:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE1D360362;
	Tue, 13 Oct 2026 13:16:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5C56311D713E3;
	Tue, 13 Oct 2026 15:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897418; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CApBnQ/3EMP6NYPB61tS6yHxzTwgAAfLaV/9nNRT8as=;
	b=PHc8JUXZdcNy3L4AyeAX4uWQqKLxyjRjOtcmtGV4/MJkKxfw7cB2IJKHLTZX9T33aHm3Vm
	fv1gAOYb8BuGvgeQmXjzxpiHSlT71EOrKeGhlXX+wOAf8qShqstn1wOPGom3WitYuunbcL
	04ytcykojJjUNCgiJZPBqpxdXzCFkFFCmAIOnO3EJWmK5PETyQsHDdC/yxEEMzoJ/0QCQd
	4XZgRBQg7LbFqlG89Kq4XaonDuMzXqu7Tw3XWgbz5wVIeD1efWv1E2NhavC4qDD/n1VI/H
	dJFYK/CAtFJa2ygQOoW5bGV5XbfzGbZ9D/7u20kXPbmlyaqMaELG76UjoTPukA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 13 Oct 2026 15:16:40 +0200
Subject: [PATCH net-next v11 2/9] net: macb: introduce macb_context struct
 for buffer management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-macb-context-v11-2-b27785167566@bootlin.com>
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

Whenever an operation requires buffer realloc, we close the interface,
update parameters and reopen. To improve reliability under memory
pressure, we should rather alloc new buffers, reconfigure HW and free
old buffers. This requires MACB to support having multiple "contexts"
in parallel.

Introduce this concept by adding the macb_context struct, which owns all
queue buffers and the parameters associated. We do not yet support
multiple contexts in parallel, because all functions access bp->ctx
(the currently active context) directly.

Steps:

 - Introduce `struct macb_context` and its children `struct macb_rxq`
   and `struct macb_txq`. Context fields are stolen from `struct macb`
   and rxq/txq fields are from `struct macb_queue`.

   Making it two separate structs per queue simplifies accesses: we grab
   a txq/rxq local variable and access fields like txq->head instead of
   queue->tx_head. It also anecdotally improves data locality.

 - macb_init_dflt() / macb_get_ringparam() do not access
   bp->ctx->{rx,tx}_ring_size as they will/might run while interface is
   offline and ctx is NULL. Instead, introduce
   bp->configured_{rx,tx}_ring_size which get updated on user requests.

 - macb_open() starts by allocating bp->ctx. It gets freed in the
   open error codepath or by macb_close().

 - Guided by compile errors, update all codepaths. Most diff is changing
   `queue->tx_*` to `txq->*` and `queue->rx_*` to `rxq->*`, with a new
   local variable. Also rx_buffer_size / rx_ring_size / tx_ring_size
   move from bp to bp->ctx.

   Introduce two helpers macb_txq|rxq() functions to convert macb_queue
   pointers.

 - macb_get_regs() is tweaked to support being ran while interface is
   offline (and context is NULL). Use default values at zero and
   override them only if context is present.

 - Protect our ctx freeing in at91ether code with a synchronize_irq()
   call.

Note: bp->configured_{rx,tx}_ring_size contain proper values for EMAC,
meaning 9/1 on ethtool -G on RM9200 whereas it reported 0/0 before.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  51 +++-
 drivers/net/ethernet/cadence/macb_main.c | 506 +++++++++++++++++++------------
 2 files changed, 344 insertions(+), 213 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 82499ec6a9f0..4f5aede1dec4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1267,23 +1267,12 @@ struct macb_queue {
 	unsigned int		ENST_ON_TIME;
 	unsigned int		ENST_OFF_TIME;
 
-	/* Lock to protect tx_head and tx_tail */
+	/* Lock to protect ctx->txq[q].head and ctx->txq[q].tail */
 	spinlock_t		tx_ptr_lock;
-	unsigned int		tx_head, tx_tail;
-	struct macb_dma_desc	*tx_ring;
-	struct macb_tx_skb	*tx_skb;
-	dma_addr_t		tx_ring_dma;
 	struct work_struct	tx_error_task;
 	bool			txubr_pending;
 	struct napi_struct	napi_tx;
 
-	dma_addr_t		rx_ring_dma;
-	dma_addr_t		rx_buffers_dma;
-	unsigned int		rx_tail;
-	unsigned int		rx_prepared_head;
-	struct macb_dma_desc	*rx_ring;
-	struct sk_buff		**rx_skbuff;
-	void			*rx_buffers;
 	struct napi_struct	napi_rx;
 	struct queue_stats stats;
 };
@@ -1298,6 +1287,32 @@ struct ethtool_rx_fs_list {
 	unsigned int count;
 };
 
+struct macb_rxq {
+	struct macb_dma_desc	*ring;		/* MACB & GEM */
+	dma_addr_t		ring_dma;	/* MACB & GEM */
+	unsigned int		tail;		/* MACB & GEM */
+	unsigned int		prepared_head;	/* GEM */
+	struct sk_buff		**skbuff;	/* GEM */
+	dma_addr_t		buffers_dma;	/* MACB */
+	void			*buffers;	/* MACB */
+};
+
+struct macb_txq {
+	unsigned int		head;
+	unsigned int		tail;
+	struct macb_dma_desc	*ring;
+	dma_addr_t		ring_dma;
+	struct macb_tx_skb	*skb;
+};
+
+struct macb_context {
+	unsigned int		rx_buffer_size;
+	unsigned int		rx_ring_size;
+	unsigned int		tx_ring_size;
+	struct macb_rxq		rxq[MACB_MAX_QUEUES];
+	struct macb_txq		txq[MACB_MAX_QUEUES];
+};
+
 struct macb {
 	void __iomem		*regs;
 	bool			native_io;
@@ -1306,12 +1321,16 @@ struct macb {
 	u32	(*macb_reg_readl)(struct macb *bp, int offset);
 	void	(*macb_reg_writel)(struct macb *bp, int offset, u32 value);
 
+	/*
+	 * Context stores all its parameters.
+	 * But we must remember them across closure.
+	 */
+	unsigned int		configured_rx_ring_size;
+	unsigned int		configured_tx_ring_size;
+	struct macb_context	*ctx;
+
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
-	size_t			rx_buffer_size;
-
-	unsigned int		rx_ring_size;
-	unsigned int		tx_ring_size;
 
 	unsigned int		num_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d414d00d93ce..9db03b0f082e 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -61,7 +61,7 @@ struct sifive_fu540_macb_mgmt {
 #define MAX_TX_RING_SIZE	4096
 
 /* level of occupied TX descriptors under which we wake up TX process */
-#define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->tx_ring_size / 4)
+#define MACB_TX_WAKEUP_THRESH(bp)	(3 * (bp)->ctx->tx_ring_size / 4)
 
 #define MACB_RX_INT_FLAGS	(MACB_BIT(RCOMP) | MACB_BIT(ISR_ROVR))
 #define MACB_TX_ERR_FLAGS	(MACB_BIT(ISR_TUND)			\
@@ -152,48 +152,73 @@ static struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp, struct macb_dma_d
 /* Ring buffer accessors */
 static unsigned int macb_tx_ring_wrap(struct macb *bp, unsigned int index)
 {
-	return index & (bp->tx_ring_size - 1);
+	return index & (bp->ctx->tx_ring_size - 1);
+}
+
+static struct macb_txq *macb_txq(struct macb_queue *queue)
+{
+	struct macb *bp = queue->bp;
+	unsigned int q = queue - bp->queues;
+
+	return &bp->ctx->txq[q];
+}
+
+static struct macb_rxq *macb_rxq(struct macb_queue *queue)
+{
+	struct macb *bp = queue->bp;
+	unsigned int q = queue - bp->queues;
+
+	return &bp->ctx->rxq[q];
 }
 
 static struct macb_dma_desc *macb_tx_desc(struct macb_queue *queue,
 					  unsigned int index)
 {
+	struct macb_txq *txq = macb_txq(queue);
+
 	index = macb_tx_ring_wrap(queue->bp, index);
 	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &queue->tx_ring[index];
+	return &txq->ring[index];
 }
 
 static struct macb_tx_skb *macb_tx_skb(struct macb_queue *queue,
 				       unsigned int index)
 {
-	return &queue->tx_skb[macb_tx_ring_wrap(queue->bp, index)];
+	struct macb_txq *txq = macb_txq(queue);
+
+	return &txq->skb[macb_tx_ring_wrap(queue->bp, index)];
 }
 
 static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	dma_addr_t offset;
 
 	offset = macb_tx_ring_wrap(queue->bp, index) *
 			macb_dma_desc_get_size(queue->bp);
 
-	return queue->tx_ring_dma + offset;
+	return txq->ring_dma + offset;
 }
 
 static unsigned int macb_rx_ring_wrap(struct macb *bp, unsigned int index)
 {
-	return index & (bp->rx_ring_size - 1);
+	return index & (bp->ctx->rx_ring_size - 1);
 }
 
 static struct macb_dma_desc *macb_rx_desc(struct macb_queue *queue, unsigned int index)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
+
 	index = macb_rx_ring_wrap(queue->bp, index);
 	index = macb_adj_dma_desc_idx(queue->bp, index);
-	return &queue->rx_ring[index];
+	return &rxq->ring[index];
 }
 
 static void *macb_rx_buffer(struct macb_queue *queue, unsigned int index)
 {
-	return queue->rx_buffers + queue->bp->rx_buffer_size *
+	struct macb_rxq *rxq = macb_rxq(queue);
+
+	return rxq->buffers + queue->bp->ctx->rx_buffer_size *
 	       macb_rx_ring_wrap(queue->bp, index);
 }
 
@@ -463,19 +488,23 @@ static int macb_mdio_write_c45(struct mii_bus *bus, int mii_id,
 static void macb_init_buffers(struct macb *bp)
 {
 	struct macb_queue *queue;
+	struct macb_rxq *rxq;
+	struct macb_txq *txq;
 	unsigned int q;
 
 	/* Single register for all queues' high 32 bits. */
 	if (macb_dma64(bp)) {
-		macb_writel(bp, RBQPH,
-			    upper_32_bits(bp->queues[0].rx_ring_dma));
-		macb_writel(bp, TBQPH,
-			    upper_32_bits(bp->queues[0].tx_ring_dma));
+		rxq = &bp->ctx->rxq[0];
+		txq = &bp->ctx->txq[0];
+		macb_writel(bp, RBQPH, upper_32_bits(rxq->ring_dma));
+		macb_writel(bp, TBQPH, upper_32_bits(txq->ring_dma));
 	}
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
-		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+		rxq = &bp->ctx->rxq[q];
+		txq = &bp->ctx->txq[q];
+		queue_writel(queue, RBQP, lower_32_bits(rxq->ring_dma));
+		queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
 	}
 }
 
@@ -659,11 +688,12 @@ static bool macb_tx_lpi_set(struct macb *bp, bool enable)
 
 static bool macb_tx_all_queues_idle(struct macb *bp)
 {
-	struct macb_queue *queue;
+	struct macb_txq *txq;
 	unsigned int q;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (READ_ONCE(queue->tx_head) != READ_ONCE(queue->tx_tail))
+	for (q = 0; q < bp->num_queues; ++q) {
+		txq = &bp->ctx->txq[q];
+		if (READ_ONCE(txq->head) != READ_ONCE(txq->tail))
 			return false;
 	}
 	return true;
@@ -812,6 +842,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	struct macb_tx_skb tx_skb, *skb_curr, *skb_next;
 	struct macb_dma_desc *desc_curr, *desc_next;
 	unsigned int i, cycles, shift, curr, next;
+	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned char desc[24];
 	unsigned long flags;
@@ -822,17 +853,17 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		return;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-	head = queue->tx_head;
-	tail = queue->tx_tail;
-	ring_size = bp->tx_ring_size;
+	head = txq->head;
+	tail = txq->tail;
+	ring_size = bp->ctx->tx_ring_size;
 	count = CIRC_CNT(head, tail, ring_size);
 
 	if (!(tail % ring_size))
 		goto unlock;
 
 	if (!count) {
-		queue->tx_head = 0;
-		queue->tx_tail = 0;
+		txq->head = 0;
+		txq->tail = 0;
 		goto unlock;
 	}
 
@@ -876,8 +907,8 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 		       sizeof(struct macb_tx_skb));
 	}
 
-	queue->tx_head = count;
-	queue->tx_tail = 0;
+	txq->head = count;
+	txq->tail = 0;
 
 	/* Make descriptor updates visible to hardware */
 	wmb();
@@ -1278,6 +1309,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	struct macb_queue *queue = container_of(work, struct macb_queue,
 						tx_error_task);
 	unsigned int q = queue - queue->bp->queues;
+	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_tx_skb *tx_skb;
 	struct macb_dma_desc *desc;
@@ -1290,7 +1322,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	u32 bytes = 0;
 
 	netdev_vdbg(bp->netdev, "%s: q = %u, t = %u, h = %u\n",
-		    __func__, q, queue->tx_tail, queue->tx_head);
+		    __func__, q, txq->tail, txq->head);
 
 	/* Prevent the queue NAPI TX poll from running, as it calls
 	 * macb_tx_complete(), which in turn may call netif_wake_subqueue().
@@ -1316,7 +1348,7 @@ static void macb_tx_error_task(struct work_struct *work)
 	/* Treat frames in TX queue including the ones that caused the error.
 	 * Free transmit buffers in upper layer.
 	 */
-	for (tail = queue->tx_tail; tail != queue->tx_head; tail++) {
+	for (tail = txq->tail; tail != txq->head; tail++) {
 		u32	ctrl;
 
 		desc = macb_tx_desc(queue, tail);
@@ -1373,10 +1405,10 @@ static void macb_tx_error_task(struct work_struct *work)
 	wmb();
 
 	/* Reinitialize the TX desc queue */
-	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+	queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
 	/* Make TX ring reflect state of hardware */
-	queue->tx_head = 0;
-	queue->tx_tail = 0;
+	txq->head = 0;
+	txq->tail = 0;
 
 	/* Housework before enabling TX IRQ */
 	macb_writel(bp, TSR, macb_readl(bp, TSR));
@@ -1433,6 +1465,7 @@ static bool ptp_one_step_sync(struct sk_buff *skb)
 static int macb_tx_complete(struct macb_queue *queue, int budget)
 {
 	struct macb *bp = queue->bp;
+	struct macb_txq *txq = macb_txq(queue);
 	unsigned int q = queue - bp->queues;
 	unsigned long flags;
 	unsigned int tail;
@@ -1441,8 +1474,8 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	u32 bytes = 0;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-	head = queue->tx_head;
-	for (tail = queue->tx_tail; tail != head && packets < budget; tail++) {
+	head = txq->head;
+	for (tail = txq->tail; tail != head && packets < budget; tail++) {
 		struct macb_tx_skb	*tx_skb;
 		struct sk_buff		*skb;
 		struct macb_dma_desc	*desc;
@@ -1498,10 +1531,10 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
 				  packets, bytes);
 
-	queue->tx_tail = tail;
+	txq->tail = tail;
 	if (__netif_subqueue_stopped(bp->netdev, q) &&
-	    CIRC_CNT(queue->tx_head, queue->tx_tail,
-		     bp->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
+	    CIRC_CNT(txq->head, txq->tail,
+		     bp->ctx->tx_ring_size) <= MACB_TX_WAKEUP_THRESH(bp))
 		netif_wake_subqueue(bp->netdev, q);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 
@@ -1513,24 +1546,26 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 
 static int gem_rx_refill(struct macb_queue *queue)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
 	unsigned int entry;
 	dma_addr_t paddr;
 
-	while (CIRC_SPACE(queue->rx_prepared_head, queue->rx_tail,
-			bp->rx_ring_size) > 0) {
-		entry = macb_rx_ring_wrap(bp, queue->rx_prepared_head);
+	while (CIRC_SPACE(rxq->prepared_head, rxq->tail,
+			  bp->ctx->rx_ring_size) > 0) {
+		entry = macb_rx_ring_wrap(bp, rxq->prepared_head);
 
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
 		desc = macb_rx_desc(queue, entry);
 
-		if (!queue->rx_skbuff[entry]) {
+		if (!rxq->skbuff[entry]) {
 			/* allocate sk_buff for this free entry in ring */
-			skb = netdev_alloc_skb(bp->netdev, bp->rx_buffer_size);
+			skb = netdev_alloc_skb(bp->netdev,
+					       bp->ctx->rx_buffer_size);
 			if (unlikely(!skb)) {
 				netdev_err(bp->netdev,
 					   "Unable to allocate sk_buff\n");
@@ -1539,16 +1574,16 @@ static int gem_rx_refill(struct macb_queue *queue)
 
 			/* now fill corresponding descriptor entry */
 			paddr = dma_map_single(&bp->pdev->dev, skb->data,
-					       bp->rx_buffer_size,
+					       bp->ctx->rx_buffer_size,
 					       DMA_FROM_DEVICE);
 			if (dma_mapping_error(&bp->pdev->dev, paddr)) {
 				dev_kfree_skb(skb);
 				break;
 			}
 
-			queue->rx_skbuff[entry] = skb;
+			rxq->skbuff[entry] = skb;
 
-			if (entry == bp->rx_ring_size - 1)
+			if (entry == bp->ctx->rx_ring_size - 1)
 				paddr |= MACB_BIT(RX_WRAP);
 			desc->ctrl = 0;
 			/* Setting addr clears RX_USED and allows reception,
@@ -1575,19 +1610,19 @@ static int gem_rx_refill(struct macb_queue *queue)
 			dma_wmb();
 			desc->addr &= ~MACB_BIT(RX_USED);
 		}
-		queue->rx_prepared_head++;
+		rxq->prepared_head++;
 	}
 
 	/* Make descriptor updates visible to hardware */
 	wmb();
 
 	netdev_vdbg(bp->netdev, "rx ring: queue: %p, prepared head %d, tail %d\n",
-		    queue, queue->rx_prepared_head, queue->rx_tail);
+		    queue, rxq->prepared_head, rxq->tail);
 
 	/* Fail if queue has zero prepared descriptors. This is critical because
 	 * nothing will ever trigger a refill again.
 	 */
-	if (queue->rx_prepared_head == queue->rx_tail)
+	if (rxq->prepared_head == rxq->tail)
 		return -ENOMEM;
 
 	return 0;
@@ -1617,6 +1652,7 @@ static void discard_partial_frame(struct macb_queue *queue, unsigned int begin,
 static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		  int budget)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	struct sk_buff *skb;
@@ -1633,10 +1669,10 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		 * for hardware. Outside, we might have RX_USED descriptors for
 		 * alloc failures.
 		 */
-		if (queue->rx_tail == queue->rx_prepared_head)
+		if (rxq->tail == rxq->prepared_head)
 			break;
 
-		entry = macb_rx_ring_wrap(bp, queue->rx_tail);
+		entry = macb_rx_ring_wrap(bp, rxq->tail);
 		desc = macb_rx_desc(queue, entry);
 
 		/* Make hw descriptor updates visible to CPU */
@@ -1653,7 +1689,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		ctrl = desc->ctrl;
 
-		queue->rx_tail++;
+		rxq->tail++;
 		count++;
 
 		if (!(ctrl & MACB_BIT(RX_SOF) && ctrl & MACB_BIT(RX_EOF))) {
@@ -1663,7 +1699,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			queue->stats.rx_dropped++;
 			break;
 		}
-		skb = queue->rx_skbuff[entry];
+		skb = rxq->skbuff[entry];
 		if (unlikely(!skb)) {
 			netdev_err(bp->netdev,
 				   "inconsistent Rx descriptor chain\n");
@@ -1672,7 +1708,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 			break;
 		}
 		/* now everything is ready for receiving packet */
-		queue->rx_skbuff[entry] = NULL;
+		rxq->skbuff[entry] = NULL;
 		len = ctrl & bp->rx_frm_len_mask;
 
 		netdev_vdbg(bp->netdev, "%s %u (len %u)\n",
@@ -1680,7 +1716,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 
 		skb_put(skb, len);
 		dma_unmap_single(&bp->pdev->dev, addr,
-				 bp->rx_buffer_size, DMA_FROM_DEVICE);
+				 bp->ctx->rx_buffer_size, DMA_FROM_DEVICE);
 
 		skb->protocol = eth_type_trans(skb, bp->netdev);
 		skb_checksum_none_assert(skb);
@@ -1761,7 +1797,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 	skb_put(skb, len);
 
 	for (frag = first_frag; ; frag++) {
-		unsigned int frag_len = bp->rx_buffer_size;
+		unsigned int frag_len = bp->ctx->rx_buffer_size;
 
 		if (offset + frag_len > len) {
 			if (unlikely(frag != last_frag)) {
@@ -1773,7 +1809,7 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 		skb_copy_to_linear_data_offset(skb, offset,
 					       macb_rx_buffer(queue, frag),
 					       frag_len);
-		offset += bp->rx_buffer_size;
+		offset += bp->ctx->rx_buffer_size;
 		desc = macb_rx_desc(queue, frag);
 		desc->addr &= ~MACB_BIT(RX_USED);
 
@@ -1798,32 +1834,34 @@ static int macb_rx_frame(struct macb_queue *queue, struct napi_struct *napi,
 
 static inline void macb_init_rx_ring(struct macb_queue *queue)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb_dma_desc *desc = NULL;
 	struct macb *bp = queue->bp;
 	dma_addr_t addr;
 	int i;
 
-	addr = queue->rx_buffers_dma;
-	for (i = 0; i < bp->rx_ring_size; i++) {
+	addr = rxq->buffers_dma;
+	for (i = 0; i < bp->ctx->rx_ring_size; i++) {
 		desc = macb_rx_desc(queue, i);
 		macb_set_addr(bp, desc, addr);
 		desc->ctrl = 0;
-		addr += bp->rx_buffer_size;
+		addr += bp->ctx->rx_buffer_size;
 	}
 	desc->addr |= MACB_BIT(RX_WRAP);
-	queue->rx_tail = 0;
+	rxq->tail = 0;
 }
 
 static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		   int budget)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	bool reset_rx_queue = false;
 	int first_frag = -1;
 	unsigned int tail;
 	int received = 0;
 
-	for (tail = queue->rx_tail; budget > 0; tail++) {
+	for (tail = rxq->tail; budget > 0; tail++) {
 		struct macb_dma_desc *desc = macb_rx_desc(queue, tail);
 		u32 ctrl;
 
@@ -1877,7 +1915,7 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 		macb_writel(bp, NCR, ctrl & ~MACB_BIT(RE));
 
 		macb_init_rx_ring(queue);
-		queue_writel(queue, RBQP, queue->rx_ring_dma);
+		queue_writel(queue, RBQP, rxq->ring_dma);
 
 		macb_writel(bp, NCR, ctrl | MACB_BIT(RE));
 
@@ -1886,24 +1924,25 @@ static int macb_rx(struct macb_queue *queue, struct napi_struct *napi,
 	}
 
 	if (first_frag != -1)
-		queue->rx_tail = first_frag;
+		rxq->tail = first_frag;
 	else
-		queue->rx_tail = tail;
+		rxq->tail = tail;
 
 	return received;
 }
 
 static bool macb_rx_pending(struct macb_queue *queue)
 {
+	struct macb_rxq *rxq = macb_rxq(queue);
 	struct macb *bp = queue->bp;
 	struct macb_dma_desc *desc;
 	unsigned int entry;
 
 	/* No armed descriptor left: nothing can be pending. */
-	if (macb_is_gem(bp) && queue->rx_tail == queue->rx_prepared_head)
+	if (macb_is_gem(bp) && rxq->tail == rxq->prepared_head)
 		return false;
 
-	entry = macb_rx_ring_wrap(bp, queue->rx_tail);
+	entry = macb_rx_ring_wrap(bp, rxq->tail);
 	desc = macb_rx_desc(queue, entry);
 
 	/* Make hw descriptor updates visible to CPU */
@@ -1951,18 +1990,19 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 static void macb_tx_restart(struct macb_queue *queue)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
-	if (queue->tx_head == queue->tx_tail)
+	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
 	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp);
 	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
-	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, queue->tx_head));
+	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
 
 	if (tbqp == head_idx)
 		goto out_tx_ptr_unlock;
@@ -1977,15 +2017,16 @@ static void macb_tx_restart(struct macb_queue *queue)
 
 static bool macb_tx_complete_pending(struct macb_queue *queue)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	bool retval = false;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
-	if (queue->tx_head != queue->tx_tail) {
+	if (txq->head != txq->tail) {
 		/* Make hw descriptor updates visible to CPU */
 		rmb();
 
-		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
+		if (macb_tx_desc(queue, txq->tail)->ctrl & MACB_BIT(TX_USED))
 			retval = true;
 	}
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
@@ -2305,8 +2346,9 @@ static unsigned int macb_tx_map(struct macb *bp,
 				unsigned int hdrlen,
 				u8 fcs_len)
 {
+	struct macb_txq *txq = macb_txq(queue);
 	unsigned int f, nr_frags = skb_shinfo(skb)->nr_frags;
-	unsigned int len, i, tx_head = queue->tx_head;
+	unsigned int len, i, tx_head = txq->head;
 	u32 ctrl, lso_ctrl = 0, seq_ctrl = 0;
 	unsigned int eof = 1, mss_mfs = 0;
 	struct macb_tx_skb *tx_skb = NULL;
@@ -2427,11 +2469,12 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BIT(TX_LAST);
 			eof = 0;
 		}
-		if (unlikely(macb_tx_ring_wrap(bp, i) == bp->tx_ring_size - 1))
+		if (unlikely(macb_tx_ring_wrap(bp, i) ==
+				bp->ctx->tx_ring_size - 1))
 			ctrl |= MACB_BIT(TX_WRAP);
 
 		/* First descriptor is header descriptor */
-		if (i == queue->tx_head) {
+		if (i == txq->head) {
 			ctrl |= MACB_BF(TX_LSO, lso_ctrl);
 			ctrl |= MACB_BF(TX_TCP_SEQ_SRC, seq_ctrl);
 			if ((bp->netdev->features & NETIF_F_HW_CSUM) &&
@@ -2451,16 +2494,16 @@ static unsigned int macb_tx_map(struct macb *bp,
 		 */
 		wmb();
 		desc->ctrl = ctrl;
-	} while (i != queue->tx_head);
+	} while (i != txq->head);
 
-	queue->tx_head = tx_head;
+	txq->head = tx_head;
 
 	return 0;
 
 dma_error:
 	netdev_err(bp->netdev, "TX DMA map failed\n");
 
-	for (i = queue->tx_head; i != tx_head; i++) {
+	for (i = txq->head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
 
 		macb_tx_unmap(bp, tx_skb, 0);
@@ -2587,6 +2630,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	unsigned int q = skb_get_queue_mapping(skb);
 	unsigned int desc_cnt, nr_frags, frag_size, f;
 	struct macb_queue *queue = &bp->queues[q];
+	struct macb_txq *txq = macb_txq(queue);
 	netdev_tx_t ret = NETDEV_TX_OK;
 	unsigned int hdrlen, tx_len;
 	bool add_fcs, is_lso;
@@ -2649,11 +2693,11 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
 	/* This is a hard error, log it. */
-	if (CIRC_SPACE(queue->tx_head, queue->tx_tail,
-		       bp->tx_ring_size) < desc_cnt) {
+	if (CIRC_SPACE(txq->head, txq->tail,
+		       bp->ctx->tx_ring_size) < desc_cnt) {
 		netif_stop_subqueue(netdev, q);
-		netdev_dbg(netdev, "tx_head = %u, tx_tail = %u\n",
-			   queue->tx_head, queue->tx_tail);
+		netdev_dbg(netdev, "txq head = %u, txq tail = %u\n",
+			   txq->head, txq->tail);
 		ret = NETDEV_TX_BUSY;
 		goto unlock;
 	}
@@ -2690,7 +2734,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
 	spin_unlock(&bp->lock);
 
-	if (CIRC_SPACE(queue->tx_head, queue->tx_tail, bp->tx_ring_size) < 1)
+	if (CIRC_SPACE(txq->head, txq->tail, bp->ctx->tx_ring_size) < 1)
 		netif_stop_subqueue(netdev, q);
 
 unlock:
@@ -2702,38 +2746,42 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
 {
 	if (!macb_is_gem(bp)) {
-		bp->rx_buffer_size = MACB_RX_BUFFER_SIZE;
+		bp->ctx->rx_buffer_size = MACB_RX_BUFFER_SIZE;
 	} else {
-		bp->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
+		bp->ctx->rx_buffer_size = MIN(size, RX_BUFFER_MAX);
 
-		if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE) {
+		if (bp->ctx->rx_buffer_size % RX_BUFFER_MULTIPLE) {
 			netdev_dbg(bp->netdev,
 				   "RX buffer must be multiple of %d bytes, expanding\n",
 				   RX_BUFFER_MULTIPLE);
-			bp->rx_buffer_size =
-				roundup(bp->rx_buffer_size, RX_BUFFER_MULTIPLE);
+			bp->ctx->rx_buffer_size =
+				roundup(bp->ctx->rx_buffer_size,
+					RX_BUFFER_MULTIPLE);
 		}
 	}
 
-	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%zu]\n",
-		   bp->netdev->mtu, bp->rx_buffer_size);
+	netdev_dbg(bp->netdev, "mtu [%u] rx_buffer_size [%u]\n",
+		   bp->netdev->mtu, bp->ctx->rx_buffer_size);
 }
 
 static void gem_free_rx_buffers(struct macb *bp)
 {
-	struct sk_buff		*skb;
-	struct macb_dma_desc	*desc;
+	struct macb_dma_desc *desc;
 	struct macb_queue *queue;
-	dma_addr_t		addr;
+	struct macb_rxq *rxq;
+	struct sk_buff *skb;
+	dma_addr_t addr;
 	unsigned int q;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (!queue->rx_skbuff)
+		rxq = &bp->ctx->rxq[q];
+
+		if (!rxq->skbuff)
 			continue;
 
-		for (i = 0; i < bp->rx_ring_size; i++) {
-			skb = queue->rx_skbuff[i];
+		for (i = 0; i < bp->ctx->rx_ring_size; i++) {
+			skb = rxq->skbuff[i];
 
 			if (!skb)
 				continue;
@@ -2741,60 +2789,71 @@ static void gem_free_rx_buffers(struct macb *bp)
 			desc = macb_rx_desc(queue, i);
 			addr = macb_get_addr(bp, desc);
 
-			dma_unmap_single(&bp->pdev->dev, addr, bp->rx_buffer_size,
-					DMA_FROM_DEVICE);
+			dma_unmap_single(&bp->pdev->dev, addr,
+					 bp->ctx->rx_buffer_size,
+					 DMA_FROM_DEVICE);
 			dev_kfree_skb_any(skb);
 			skb = NULL;
 		}
 
-		kfree(queue->rx_skbuff);
-		queue->rx_skbuff = NULL;
+		kfree(rxq->skbuff);
+		rxq->skbuff = NULL;
 	}
 }
 
 static void macb_free_rx_buffers(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 
-	if (queue->rx_buffers) {
+	if (rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
-				  bp->rx_ring_size * bp->rx_buffer_size,
-				  queue->rx_buffers, queue->rx_buffers_dma);
-		queue->rx_buffers = NULL;
+				  bp->ctx->rx_ring_size *
+					bp->ctx->rx_buffer_size,
+				  rxq->buffers, rxq->buffers_dma);
+		rxq->buffers = NULL;
 	}
 }
 
 static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->tx_ring_size + bp->tx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(bp) * bp->ctx->tx_ring_size +
+		bp->tx_bd_rd_prefetch;
 }
 
 static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
+	return macb_dma_desc_get_size(bp) * bp->ctx->rx_ring_size +
+		bp->rx_bd_rd_prefetch;
 }
 
 static void macb_free(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	struct macb_queue *queue;
+	struct macb_txq *txq;
+	struct macb_rxq *rxq;
 	unsigned int q;
 	size_t size;
 
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
+	txq = &bp->ctx->txq[0];
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
-	dma_free_coherent(dev, size, bp->queues[0].tx_ring, bp->queues[0].tx_ring_dma);
+	dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
 
+	rxq = &bp->ctx->rxq[0];
 	size = bp->num_queues * macb_rx_ring_size_per_queue(bp);
-	dma_free_coherent(dev, size, bp->queues[0].rx_ring, bp->queues[0].rx_ring_dma);
+	dma_free_coherent(dev, size, rxq->ring, rxq->ring_dma);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		if (queue->tx_skb) {
+	for (q = 0; q < bp->num_queues; ++q) {
+		txq = &bp->ctx->txq[q];
+		rxq = &bp->ctx->rxq[q];
+		queue = &bp->queues[q];
+
+		if (txq->skb) {
 			unsigned int dropped = 0, tail;
 
-			for (tail = queue->tx_tail; tail != queue->tx_head;
-			     tail++) {
+			for (tail = txq->tail; tail != txq->head; tail++) {
 				if (macb_tx_skb(queue, tail)->skb)
 					dropped++;
 				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
@@ -2803,50 +2862,49 @@ static void macb_free(struct macb *bp)
 			queue->stats.tx_dropped += dropped;
 			bp->netdev->stats.tx_dropped += dropped;
 
-			kfree(queue->tx_skb);
-			queue->tx_skb = NULL;
+			kfree(txq->skb);
+			txq->skb = NULL;
 		}
 
-		queue->tx_head = 0;
-		queue->tx_tail = 0;
-		queue->tx_ring = NULL;
-		queue->rx_ring = NULL;
+		txq->ring = NULL;
+		rxq->ring = NULL;
 	}
 }
 
 static int gem_alloc_rx_buffers(struct macb *bp)
 {
-	struct macb_queue *queue;
+	struct macb_rxq *rxq;
 	unsigned int q;
 	int size;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		size = bp->rx_ring_size * sizeof(struct sk_buff *);
-		queue->rx_skbuff = kzalloc(size, GFP_KERNEL);
-		if (!queue->rx_skbuff)
+	for (q = 0; q < bp->num_queues; ++q) {
+		rxq = &bp->ctx->rxq[q];
+		size = bp->ctx->rx_ring_size * sizeof(struct sk_buff *);
+		rxq->skbuff = kzalloc(size, GFP_KERNEL);
+		if (!rxq->skbuff)
 			return -ENOMEM;
 		else
 			netdev_dbg(bp->netdev,
 				   "Allocated %d RX struct sk_buff entries at %p\n",
-				   bp->rx_ring_size, queue->rx_skbuff);
+				   bp->ctx->rx_ring_size, rxq->skbuff);
 	}
 	return 0;
 }
 
 static int macb_alloc_rx_buffers(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	int size;
 
-	size = bp->rx_ring_size * bp->rx_buffer_size;
-	queue->rx_buffers = dma_alloc_coherent(&bp->pdev->dev, size,
-					    &queue->rx_buffers_dma, GFP_KERNEL);
-	if (!queue->rx_buffers)
+	size = bp->ctx->rx_ring_size * bp->ctx->rx_buffer_size;
+	rxq->buffers = dma_alloc_coherent(&bp->pdev->dev, size,
+					  &rxq->buffers_dma, GFP_KERNEL);
+	if (!rxq->buffers)
 		return -ENOMEM;
 
 	netdev_dbg(bp->netdev,
 		   "Allocated RX buffers of %d bytes at %08lx (mapped %p)\n",
-		   size, (unsigned long)queue->rx_buffers_dma, queue->rx_buffers);
+		   size, (unsigned long)rxq->buffers_dma, rxq->buffers);
 	return 0;
 }
 
@@ -2854,7 +2912,8 @@ static int macb_alloc(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
-	struct macb_queue *queue;
+	struct macb_txq *txq;
+	struct macb_rxq *rxq;
 	unsigned int q;
 	void *tx, *rx;
 	size_t size;
@@ -2871,8 +2930,9 @@ static int macb_alloc(struct macb *bp)
 	if (!tx)
 		goto out_err;
 	/* Record the buffer so that the error path frees it. */
-	bp->queues[0].tx_ring = tx;
-	bp->queues[0].tx_ring_dma = tx_dma;
+	txq = &bp->ctx->txq[0];
+	txq->ring = tx;
+	txq->ring_dma = tx_dma;
 	if (upper_32_bits(tx_dma) != upper_32_bits(tx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u TX rings at %08lx (mapped %p)\n",
@@ -2883,23 +2943,27 @@ static int macb_alloc(struct macb *bp)
 	if (!rx)
 		goto out_err;
 	/* Record the buffer so that the error path frees it. */
-	bp->queues[0].rx_ring = rx;
-	bp->queues[0].rx_ring_dma = rx_dma;
+	rxq = &bp->ctx->rxq[0];
+	rxq->ring = rx;
+	rxq->ring_dma = rx_dma;
 	if (upper_32_bits(rx_dma) != upper_32_bits(rx_dma + size - 1))
 		goto out_err;
 	netdev_dbg(bp->netdev, "Allocated %zu bytes for %u RX rings at %08lx (mapped %p)\n",
 		   size, bp->num_queues, (unsigned long)rx_dma, rx);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue->tx_ring = tx + macb_tx_ring_size_per_queue(bp) * q;
-		queue->tx_ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
+	for (q = 0; q < bp->num_queues; ++q) {
+		txq = &bp->ctx->txq[q];
+		rxq = &bp->ctx->rxq[q];
 
-		queue->rx_ring = rx + macb_rx_ring_size_per_queue(bp) * q;
-		queue->rx_ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
+		txq->ring = tx + macb_tx_ring_size_per_queue(bp) * q;
+		txq->ring_dma = tx_dma + macb_tx_ring_size_per_queue(bp) * q;
 
-		size = bp->tx_ring_size * sizeof(struct macb_tx_skb);
-		queue->tx_skb = kmalloc(size, GFP_KERNEL);
-		if (!queue->tx_skb)
+		rxq->ring = rx + macb_rx_ring_size_per_queue(bp) * q;
+		rxq->ring_dma = rx_dma + macb_rx_ring_size_per_queue(bp) * q;
+
+		size = bp->ctx->tx_ring_size * sizeof(struct macb_tx_skb);
+		txq->skb = kmalloc(size, GFP_KERNEL);
+		if (!txq->skb)
 			goto out_err;
 	}
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
@@ -2914,12 +2978,14 @@ static int macb_alloc(struct macb *bp)
 
 static int gem_init_rx_ring(struct macb_queue *queue)
 {
+	struct macb_context *ctx = queue->bp->ctx;
+	struct macb_rxq *rxq = macb_rxq(queue);
 	unsigned int i;
 
-	queue->rx_tail = 0;
-	queue->rx_prepared_head = 0;
+	rxq->tail = 0;
+	rxq->prepared_head = 0;
 
-	for (i = 0; i < queue->bp->rx_ring_size; i++)
+	for (i = 0; i < ctx->rx_ring_size; i++)
 		macb_rx_desc(queue, i)->addr |= MACB_BIT(RX_USED);
 
 	return gem_rx_refill(queue);
@@ -2929,20 +2995,22 @@ static int gem_init_rings(struct macb *bp)
 {
 	struct macb_queue *queue;
 	struct macb_dma_desc *desc = NULL;
+	struct macb_txq *txq;
 	int last_err = 0;
 	unsigned int q;
 	int err;
 	int i;
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		for (i = 0; i < bp->tx_ring_size; i++) {
+		txq = &bp->ctx->txq[q];
+		for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 			desc = macb_tx_desc(queue, i);
 			macb_set_addr(bp, desc, 0);
 			desc->ctrl = MACB_BIT(TX_USED);
 		}
 		desc->ctrl |= MACB_BIT(TX_WRAP);
-		queue->tx_head = 0;
-		queue->tx_tail = 0;
+		txq->head = 0;
+		txq->tail = 0;
 
 		err = gem_init_rx_ring(queue);
 		if (err)
@@ -2954,18 +3022,19 @@ static int gem_init_rings(struct macb *bp)
 
 static int macb_init_rings(struct macb *bp)
 {
-	int i;
+	struct macb_txq *txq = &bp->ctx->txq[0];
 	struct macb_dma_desc *desc = NULL;
+	int i;
 
 	macb_init_rx_ring(&bp->queues[0]);
 
-	for (i = 0; i < bp->tx_ring_size; i++) {
+	for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 		desc = macb_tx_desc(&bp->queues[0], i);
 		macb_set_addr(bp, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
-	bp->queues[0].tx_head = 0;
-	bp->queues[0].tx_tail = 0;
+	txq->head = 0;
+	txq->tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
 
 	return 0;
@@ -3082,7 +3151,7 @@ static void macb_configure_dma(struct macb *bp)
 	unsigned int q;
 	u32 dmacfg;
 
-	buffer_size = bp->rx_buffer_size / RX_BUFFER_MULTIPLE;
+	buffer_size = bp->ctx->rx_buffer_size / RX_BUFFER_MULTIPLE;
 	if (macb_is_gem(bp)) {
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3287,14 +3356,23 @@ static int macb_open(struct net_device *netdev)
 	if (err < 0)
 		return err;
 
+	WRITE_ONCE(bp->ctx, kzalloc_obj(*bp->ctx));
+	wmb(); /* ensure IRQ enabled at quiesce end read the new context */
+	if (!bp->ctx) {
+		err = -ENOMEM;
+		goto pm_exit;
+	}
+
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
+	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
+	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
 
 	err = macb_alloc(bp);
 	if (err) {
 		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
-		goto pm_exit;
+		goto free_ctx;
 	}
 
 	err = bp->macbgem_ops.mog_init_rings(bp);
@@ -3335,6 +3413,9 @@ static int macb_open(struct net_device *netdev)
 	macb_reset_hw(bp);
 free_rings:
 	macb_free(bp);
+free_ctx:
+	kfree(bp->ctx);
+	bp->ctx = NULL;
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);
 	return err;
@@ -3366,6 +3447,8 @@ static int macb_close(struct net_device *netdev)
 	spin_unlock_irqrestore(&bp->lock, flags);
 
 	macb_free(bp);
+	kfree(bp->ctx);
+	bp->ctx = NULL;
 
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(netdev);
@@ -3731,15 +3814,22 @@ static int macb_get_regs_len(struct net_device *netdev)
 static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 			  void *p)
 {
+	dma_addr_t tx_dma_tail = 0, tx_dma_head = 0;
 	struct macb *bp = netdev_priv(netdev);
-	unsigned int tail, head;
+	unsigned int tail = 0, head = 0;
+	struct macb_txq *txq;
 	u32 *regs_buff = p;
 
 	regs->version = (macb_readl(bp, MID) & ((1 << MACB_REV_SIZE) - 1))
 			| MACB_GREGS_VERSION;
 
-	tail = macb_tx_ring_wrap(bp, bp->queues[0].tx_tail);
-	head = macb_tx_ring_wrap(bp, bp->queues[0].tx_head);
+	if (bp->ctx) {
+		txq = &bp->ctx->txq[0];
+		tail = macb_tx_ring_wrap(bp, txq->tail);
+		head = macb_tx_ring_wrap(bp, txq->head);
+		tx_dma_tail = macb_tx_dma(&bp->queues[0], tail);
+		tx_dma_head = macb_tx_dma(&bp->queues[0], head);
+	}
 
 	regs_buff[0]  = macb_readl(bp, NCR);
 	regs_buff[1]  = macb_or_gem_readl(bp, NCFGR);
@@ -3752,8 +3842,8 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 
 	regs_buff[8]  = tail;
 	regs_buff[9]  = head;
-	regs_buff[10] = macb_tx_dma(&bp->queues[0], tail);
-	regs_buff[11] = macb_tx_dma(&bp->queues[0], head);
+	regs_buff[10] = tx_dma_tail;
+	regs_buff[11] = tx_dma_head;
 
 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED))
 		regs_buff[12] = macb_or_gem_readl(bp, USRIO);
@@ -3818,8 +3908,8 @@ static void macb_get_ringparam(struct net_device *netdev,
 	ring->rx_max_pending = MAX_RX_RING_SIZE;
 	ring->tx_max_pending = MAX_TX_RING_SIZE;
 
-	ring->rx_pending = bp->rx_ring_size;
-	ring->tx_pending = bp->tx_ring_size;
+	ring->rx_pending = bp->configured_rx_ring_size;
+	ring->tx_pending = bp->configured_tx_ring_size;
 }
 
 static int macb_set_ringparam(struct net_device *netdev,
@@ -3845,8 +3935,8 @@ static int macb_set_ringparam(struct net_device *netdev,
 			      MIN_TX_RING_SIZE, MAX_TX_RING_SIZE);
 	new_tx_size = roundup_pow_of_two(new_tx_size);
 
-	if ((new_tx_size == bp->tx_ring_size) &&
-	    (new_rx_size == bp->rx_ring_size)) {
+	if (new_tx_size == bp->configured_tx_ring_size &&
+	    new_rx_size == bp->configured_rx_ring_size) {
 		/* nothing to do */
 		return 0;
 	}
@@ -3856,8 +3946,8 @@ static int macb_set_ringparam(struct net_device *netdev,
 		macb_close(bp->netdev);
 	}
 
-	bp->rx_ring_size = new_rx_size;
-	bp->tx_ring_size = new_tx_size;
+	bp->configured_rx_ring_size = new_rx_size;
+	bp->configured_tx_ring_size = new_tx_size;
 
 	if (reset)
 		macb_open(bp->netdev);
@@ -4870,9 +4960,6 @@ static int macb_init_dflt(struct platform_device *pdev)
 	int err;
 	u32 val, reg;
 
-	bp->tx_ring_size = DEFAULT_TX_RING_SIZE;
-	bp->rx_ring_size = DEFAULT_RX_RING_SIZE;
-
 	/* No locking needed because the IRQs are not requested yet. The
 	 * flag is cleared by macb_open() and re-armed by macb_close().
 	 */
@@ -5084,26 +5171,26 @@ static struct sifive_fu540_macb_mgmt *mgmt;
 
 static int at91ether_alloc_coherent(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 
-	queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev,
-					    (AT91ETHER_MAX_RX_DESCR *
-					     macb_dma_desc_get_size(bp)),
-					    &queue->rx_ring_dma, GFP_KERNEL);
-	if (!queue->rx_ring)
+	rxq->ring = dma_alloc_coherent(&bp->pdev->dev,
+				       (AT91ETHER_MAX_RX_DESCR *
+					macb_dma_desc_get_size(bp)),
+				       &rxq->ring_dma, GFP_KERNEL);
+	if (!rxq->ring)
 		return -ENOMEM;
 
-	queue->rx_buffers = dma_alloc_coherent(&bp->pdev->dev,
-					       AT91ETHER_MAX_RX_DESCR *
-					       AT91ETHER_MAX_RBUFF_SZ,
-					       &queue->rx_buffers_dma,
-					       GFP_KERNEL);
-	if (!queue->rx_buffers) {
+	rxq->buffers = dma_alloc_coherent(&bp->pdev->dev,
+					  AT91ETHER_MAX_RX_DESCR *
+					  AT91ETHER_MAX_RBUFF_SZ,
+					  &rxq->buffers_dma,
+					  GFP_KERNEL);
+	if (!rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  macb_dma_desc_get_size(bp),
-				  queue->rx_ring, queue->rx_ring_dma);
-		queue->rx_ring = NULL;
+				  rxq->ring, rxq->ring_dma);
+		rxq->ring = NULL;
 		return -ENOMEM;
 	}
 
@@ -5112,22 +5199,22 @@ static int at91ether_alloc_coherent(struct macb *bp)
 
 static void at91ether_free_coherent(struct macb *bp)
 {
-	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 
-	if (queue->rx_ring) {
+	if (rxq->ring) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  macb_dma_desc_get_size(bp),
-				  queue->rx_ring, queue->rx_ring_dma);
-		queue->rx_ring = NULL;
+				  rxq->ring, rxq->ring_dma);
+		rxq->ring = NULL;
 	}
 
-	if (queue->rx_buffers) {
+	if (rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  AT91ETHER_MAX_RBUFF_SZ,
-				  queue->rx_buffers, queue->rx_buffers_dma);
-		queue->rx_buffers = NULL;
+				  rxq->buffers, rxq->buffers_dma);
+		rxq->buffers = NULL;
 	}
 }
 
@@ -5135,6 +5222,7 @@ static void at91ether_free_coherent(struct macb *bp)
 static int at91ether_start(struct macb *bp)
 {
 	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
 	u32 ctl;
@@ -5144,7 +5232,7 @@ static int at91ether_start(struct macb *bp)
 	if (ret)
 		return ret;
 
-	addr = queue->rx_buffers_dma;
+	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
 		desc = macb_rx_desc(queue, i);
 		macb_set_addr(bp, desc, addr);
@@ -5156,10 +5244,10 @@ static int at91ether_start(struct macb *bp)
 	desc->addr |= MACB_BIT(RX_WRAP);
 
 	/* Reset buffer index */
-	queue->rx_tail = 0;
+	rxq->tail = 0;
 
 	/* Program address of descriptor list in Rx Buffer Queue register */
-	macb_writel(bp, RBQP, queue->rx_ring_dma);
+	macb_writel(bp, RBQP, rxq->ring_dma);
 
 	/* Enable Receive and Transmit */
 	ctl = macb_readl(bp, NCR);
@@ -5194,6 +5282,8 @@ static void at91ether_stop(struct macb *bp)
 	ctl = macb_readl(bp, NCR);
 	macb_writel(bp, NCR, ctl & ~(MACB_BIT(TE) | MACB_BIT(RE)));
 
+	synchronize_irq(bp->netdev->irq);
+
 	/* Free resources. */
 	at91ether_free_coherent(bp);
 }
@@ -5209,6 +5299,13 @@ static int at91ether_open(struct net_device *netdev)
 	if (ret < 0)
 		return ret;
 
+	WRITE_ONCE(bp->ctx, kzalloc_obj(*bp->ctx));
+	wmb(); /* ensure IRQ enabled below read the new context */
+	if (!bp->ctx) {
+		ret = -ENOMEM;
+		goto pm_exit;
+	}
+
 	/* Clear internal statistics */
 	ctl = macb_readl(bp, NCR);
 	macb_writel(bp, NCR, ctl | MACB_BIT(CLRSTAT));
@@ -5217,7 +5314,7 @@ static int at91ether_open(struct net_device *netdev)
 
 	ret = at91ether_start(bp);
 	if (ret)
-		goto pm_exit;
+		goto free_ctx;
 
 	ret = macb_phylink_connect(bp);
 	if (ret)
@@ -5229,6 +5326,9 @@ static int at91ether_open(struct net_device *netdev)
 
 stop:
 	at91ether_stop(bp);
+free_ctx:
+	kfree(bp->ctx);
+	bp->ctx = NULL;
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);
 	return ret;
@@ -5246,6 +5346,9 @@ static int at91ether_close(struct net_device *netdev)
 
 	at91ether_stop(bp);
 
+	kfree(bp->ctx);
+	bp->ctx = NULL;
+
 	pm_runtime_put(&bp->pdev->dev);
 
 	return 0;
@@ -5297,15 +5400,15 @@ static void at91ether_rx(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
 	struct macb_queue *queue = &bp->queues[0];
+	struct macb_rxq *rxq = &bp->ctx->rxq[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
 	struct sk_buff *skb;
 	unsigned int pktlen;
 
-	desc = macb_rx_desc(queue, queue->rx_tail);
+	desc = macb_rx_desc(queue, rxq->tail);
 	while (desc->addr & MACB_BIT(RX_USED)) {
-		p_recv = queue->rx_buffers +
-			 queue->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
+		p_recv = rxq->buffers + rxq->tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
 		skb = netdev_alloc_skb(netdev, pktlen + 2);
 		if (skb) {
@@ -5327,12 +5430,12 @@ static void at91ether_rx(struct net_device *netdev)
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		/* wrap after last buffer */
-		if (queue->rx_tail == AT91ETHER_MAX_RX_DESCR - 1)
-			queue->rx_tail = 0;
+		if (rxq->tail == AT91ETHER_MAX_RX_DESCR - 1)
+			rxq->tail = 0;
 		else
-			queue->rx_tail++;
+			rxq->tail++;
 
-		desc = macb_rx_desc(queue, queue->rx_tail);
+		desc = macb_rx_desc(queue, rxq->tail);
 	}
 }
 
@@ -6030,6 +6133,15 @@ static int macb_probe(struct platform_device *pdev)
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);
 
+	if (bp->caps & MACB_CAPS_MACB_IS_EMAC) {
+		/* The name is lying on EMAC: sizes aren't configurable. */
+		bp->configured_rx_ring_size = AT91ETHER_MAX_RX_DESCR;
+		bp->configured_tx_ring_size = 1; /* tiny ring buffer */
+	} else {
+		bp->configured_rx_ring_size = DEFAULT_RX_RING_SIZE;
+		bp->configured_tx_ring_size = DEFAULT_TX_RING_SIZE;
+	}
+
 #ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	if (GEM_BFEXT(DAW64, gem_readl(bp, DCFG6))) {
 		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));

-- 
2.56.0

