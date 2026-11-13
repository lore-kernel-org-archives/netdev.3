Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591159;
	b=2PdBLllbk6CHa+xDKep717un74sRYTC2VHRA7EgVSmhtWZGrw4N6kgQpHiafo5vlng7a
	 Ze4tbpaVIdNIZY2PC4XlPFpN2j6V1B+ED2BX1BW/BZ/AEa+PafOQNYtQoFpSFlO1aXAYb
	 Ha+IMcTwW0zWbeaBxqdlxtv0sad3w5ksyocqhgN9HqITtcCwC+p8PsMhAIucCgbCgoY0i
	 nVWEQjM0V08EuLoBdjVEBLVmPmpXU6/u57biuAj+f7O6g5Xj66evUQpOGjslE+vWp9Zh8
	 sq4Cl8Ri3gbALLklrXEF3QGbriXBac3+cpeKtkylUEFnsn8VK5o9rgF9O4n1CE6BrKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591159;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=WROKLRVbQIRuz4wZlWvEQqL3Dl3/LueCox15b8HANmE=;
	b=cMjpgupnK5cZBWaV/2J4VGyMPxTHy21LPM0Hdm+dfuZfQGhC039yFFVC1tnUDouMtUAn
	 /ehH7xucVT2qb7ev2tM1axdpqj7yI/96tcCxzSm3uBqtbUnk+FxYnKy/wPcuYfCf2FLMY
	 jrFNsyNIkL3HghJXXf9GvtKrxoAxrCaT3KK8lZk6wImPd09xZBeoR4eIpv0maWyMGELKv
	 vtjWXqu6kCX4XfAkJdPxpAPMGAzv+pXZ/RKcaCS8nvRHWyRNlei/bdRRaXLKDbmct7nV8
	 I8e061KThy0LWxHM+dbXhh0uZyTKSdJxpmCE5a1K+NGDXeekE+oji+l2as/yfYOYvVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TYev09Ql;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CE606BD27
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:32:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9CE606BD27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=TYev09Ql
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 2E3464E415A9;
	Fri, 13 Nov 2026 17:32:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0146B60015;
	Fri, 13 Nov 2026 17:32:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DAF1011BC0467;
	Fri, 13 Nov 2026 18:32:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794591151; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WROKLRVbQIRuz4wZlWvEQqL3Dl3/LueCox15b8HANmE=;
	b=TYev09QlLWxxHUjJGJkFPE7XRfJcLX6cnWwbnhXRga+J0c4ezPB83wDTu8D8RYql6ODc3f
	Gb8pnOarpnlexTJ0vRPHxjMaJANPV9IgAUhO0xurZJQKGHYIOF622RWL+R0k/yAZlYXqr1
	31tap1LGA94+98UaHWhE+m2he7/p+7aJNfDF52io724VjlhmcBIUWnL2oK97CRQ8ytcRi8
	kaH0ea/f+84JPXNbJVKOHZoWn2DvGmIt43BIvbSR70RqdGq6wtKl97nPC/arudiCu75Z7n
	qYjTLTKGBd/sYPjMJjhXup5DgEgNEIw28vG/5OR00nW137QCsVAmL0aoTyNy4w==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 13 Nov 2026 18:32:02 +0100
Subject: [PATCH net-next v6 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-macb-set-channels-v6-1-5de59d9e7f02@bootlin.com>
References: <20261113-macb-set-channels-v6-0-5de59d9e7f02@bootlin.com>
In-Reply-To: <20261113-macb-set-channels-v6-0-5de59d9e7f02@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

bp->num_queues is the total number of queues and is constant from probe.
MACB/GEM does not know about Rx/Tx specific queues; it only has
combined queues. Move bp->num_queues to ctx->num_queues as it now
belongs to the currently active context (bp->ctx).

Also introduce bp->max_num_queues which takes the current role of
bp->num_queues and allow `0 < ctx->num_queues <= bp->max_num_queues`.

Lastly introduce bp->configured_num_queues to remember queue count
across interface down+up cycles.

With all that, implement the .set_channels() operation. It ends up only
being an assignment to bp->configured_num_queues plus a call into
netif_set_real_num_queues(). However if the interface is running, we
use a context swap window to safely realloc on the fly.

Note we refuse the operation if any TAPRIO rules are in place on queues
that would get disabled. If we allow the operation to take place, then
a transmission window would be reserved but unusable.

Nit: fix an alignment issue inside gem_ethtool_ops which does not
deserve its own patch.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   7 +-
 drivers/net/ethernet/cadence/macb_main.c | 279 ++++++++++++++++++++++---------
 2 files changed, 206 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index b7b4b6a38298..0879fb2b198b 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1292,7 +1292,6 @@ struct macb_info {
 	struct platform_device	*pdev;
 	struct net_device	*netdev;
 	struct macb_or_gem_ops	macbgem_ops;
-	unsigned int		num_queues;
 	u32			caps;
 	int			rx_bd_rd_prefetch;
 	int			tx_bd_rd_prefetch;
@@ -1323,6 +1322,7 @@ struct macb_context {
 	unsigned int		rx_buffer_size;
 	unsigned int		rx_ring_size;
 	unsigned int		tx_ring_size;
+	unsigned int		num_queues;
 	struct macb_rxq		rxq[MACB_MAX_QUEUES];
 	struct macb_txq		txq[MACB_MAX_QUEUES];
 };
@@ -1352,6 +1352,11 @@ struct macb {
 	unsigned int		configured_tx_ring_size;
 	struct macb_context	*ctx;
 
+	unsigned int		configured_num_queues;
+	unsigned int		max_num_queues;
+	/* Queue mask gated by the current TAPRIO schedule (RTNL-protected). */
+	u32			taprio_gated_queues;
+
 	struct macb_dma_desc	*rx_ring_tieoff;
 	dma_addr_t		rx_ring_tieoff_dma;
 
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5bd299fc85a9..e7325af4b399 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -504,11 +504,25 @@ static void macb_init_buffers(struct macb *bp)
 		macb_writel(bp, TBQPH, upper_32_bits(txq->ring_dma));
 	}
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		rxq = &bp->ctx->rxq[q];
-		txq = &bp->ctx->txq[q];
-		queue_writel(queue, RBQP, lower_32_bits(rxq->ring_dma));
-		queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue) {
+		if (q < bp->ctx->num_queues) {
+			rxq = &bp->ctx->rxq[q];
+			txq = &bp->ctx->txq[q];
+			queue_writel(queue, RBQP, lower_32_bits(rxq->ring_dma));
+			queue_writel(queue, TBQP, lower_32_bits(txq->ring_dma));
+		} else {
+			/* macb_set_channels(), which is the only way of writing
+			 * to bp->configured_num_queues, is only allowed if
+			 * MACB_CAPS_QUEUE_DISABLE.
+			 */
+			queue_writel(queue, RBQP, MACB_BIT(QUEUE_DISABLE));
+			queue_writel(queue, TBQP, MACB_BIT(QUEUE_DISABLE));
+
+			/* Disable all interrupts */
+			queue_writel(queue, IDR, -1);
+			queue_readl(queue, ISR);
+			macb_queue_isr_clear(bp, queue, -1);
+		}
 	}
 }
 
@@ -695,7 +709,7 @@ static bool macb_tx_all_queues_idle(struct macb *bp)
 	struct macb_txq *txq;
 	unsigned int q;
 
-	for (q = 0; q < bp->num_queues; ++q) {
+	for (q = 0; q < bp->ctx->num_queues; ++q) {
 		txq = &bp->ctx->txq[q];
 		if (READ_ONCE(txq->head) != READ_ONCE(txq->tail))
 			return false;
@@ -849,7 +863,8 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	bp->link_up = false;
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+		for (q = 0, queue = bp->queues; q < bp->ctx->num_queues;
+		     ++q, ++queue)
 			queue_writel(queue, IDR,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
 
@@ -951,7 +966,7 @@ static void gem_shuffle_tx_rings(struct macb *bp)
 	struct macb_queue *queue;
 	unsigned int q;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; q++, queue++)
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; q++, queue++)
 		gem_shuffle_tx_one_ring(queue);
 }
 
@@ -995,10 +1010,10 @@ static void macb_mac_link_up(struct phylink_config *config,
 		if (rx_pause)
 			ctrl |= MACB_BIT(PAE);
 
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->ctx->num_queues;
+		     ++q, ++queue)
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask | MACB_TX_INT_FLAGS | MACB_BIT(HRESP));
-		}
 	}
 
 	macb_or_gem_writel(bp, NCFGR, ctrl);
@@ -2150,12 +2165,12 @@ static void macb_quiesce_start(struct macb *bp)
 	bp->irq_quiesced = true;
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue)
 		synchronize_irq(queue->irq);
 
 	cancel_work_sync(&bp->hresp_err_bh_work);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; ++q, ++queue) {
 		/* Must be done before NAPI is disabled: the task ends with a
 		 * napi_enable() call.
 		 */
@@ -2183,7 +2198,7 @@ static void macb_quiesce_end(struct macb *bp)
 	unsigned long flags;
 	unsigned int q;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}
@@ -2202,7 +2217,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	unsigned int q;
 	u32 ctrl;
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+	for (q = 0, queue = bp->queues; q < ctx->num_queues; ++q, ++queue) {
 		queue_writel(queue, IDR, bp->rx_intr_mask |
 					 MACB_TX_INT_FLAGS |
 					 MACB_BIT(HRESP));
@@ -2220,7 +2235,7 @@ static void macb_hresp_error_task(struct work_struct *work)
 	macb_init_buffers(bp);
 
 	/* Enable interrupts */
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+	for (q = 0, queue = bp->queues; q < ctx->num_queues; ++q, ++queue)
 		queue_writel(queue, IER,
 			     bp->rx_intr_mask |
 			     MACB_TX_INT_FLAGS |
@@ -2321,7 +2336,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 {
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
+	unsigned int num_queues = 0;
 	struct net_device *netdev = bp->netdev;
+	unsigned int q = queue - bp->queues;
 	bool hresp_err = false;
 	u32 status;
 
@@ -2332,19 +2349,22 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 
 	spin_lock(&bp->lock);
 
+	if (bp->ctx)
+		num_queues = READ_ONCE(bp->ctx->num_queues);
+
 	while (status) {
-		/* self-disarm while the netdev is closed
-		 * or during context swap
+		/* self-disarm while the netdev is closed,
+		 * during context swap, or when the current queue is disabled
 		 */
-		if (unlikely(bp->irq_quiesced)) {
+		if (unlikely(bp->irq_quiesced ||
+			     q >= num_queues)) {
 			queue_writel(queue, IDR, -1);
 			macb_queue_isr_clear(bp, queue, -1);
 			break;
 		}
 
 		netdev_vdbg(netdev, "queue = %u, isr = 0x%08lx\n",
-			    (unsigned int)(queue - bp->queues),
-			    (unsigned long)status);
+			    q, (unsigned long)status);
 
 		if (status & bp->rx_intr_mask) {
 			/* There's no point taking any more interrupts
@@ -2402,7 +2422,7 @@ static void macb_poll_controller(struct net_device *netdev)
 	unsigned int q;
 
 	local_irq_save(flags);
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; ++q, ++queue)
 		macb_interrupt(netdev->irq, queue);
 	local_irq_restore(flags);
 }
@@ -2845,7 +2865,7 @@ static void gem_free_rx_buffers(struct macb_context *ctx)
 	unsigned int q;
 	int i;
 
-	for (q = 0; q < ctx->info->num_queues; ++q) {
+	for (q = 0; q < ctx->num_queues; ++q) {
 		rxq = &ctx->rxq[q];
 
 		if (!rxq->skbuff)
@@ -2907,14 +2927,14 @@ static void macb_free(struct macb_context *ctx)
 	ctx->info->macbgem_ops.mog_free_rx_buffers(ctx);
 
 	txq = &ctx->txq[0];
-	size = ctx->info->num_queues * macb_tx_ring_size_per_queue(ctx);
+	size = ctx->num_queues * macb_tx_ring_size_per_queue(ctx);
 	dma_free_coherent(dev, size, txq->ring, txq->ring_dma);
 
 	rxq = &ctx->rxq[0];
-	size = ctx->info->num_queues * macb_rx_ring_size_per_queue(ctx);
+	size = ctx->num_queues * macb_rx_ring_size_per_queue(ctx);
 	dma_free_coherent(dev, size, rxq->ring, rxq->ring_dma);
 
-	for (q = 0; q < ctx->info->num_queues; ++q) {
+	for (q = 0; q < ctx->num_queues; ++q) {
 		txq = &ctx->txq[q];
 		rxq = &ctx->rxq[q];
 
@@ -2947,7 +2967,7 @@ static int gem_alloc_rx_buffers(struct macb_context *ctx)
 	unsigned int q;
 	int size;
 
-	for (q = 0; q < ctx->info->num_queues; ++q) {
+	for (q = 0; q < ctx->num_queues; ++q) {
 		rxq = &ctx->rxq[q];
 		size = ctx->rx_ring_size * sizeof(struct sk_buff *);
 		rxq->skbuff = kzalloc(size, GFP_KERNEL);
@@ -2981,8 +3001,8 @@ static int macb_alloc_rx_buffers(struct macb_context *ctx)
 
 static int macb_alloc(struct macb_context *ctx)
 {
-	unsigned int num_queues = ctx->info->num_queues;
 	struct device *dev = &ctx->info->pdev->dev;
+	unsigned int num_queues = ctx->num_queues;
 	dma_addr_t tx_dma, rx_dma;
 	struct macb_txq *txq;
 	struct macb_rxq *rxq;
@@ -3051,6 +3071,7 @@ static int macb_alloc(struct macb_context *ctx)
 }
 
 static struct macb_context *macb_context_alloc(struct macb *bp,
+					       unsigned int num_queues,
 					       unsigned int mtu,
 					       unsigned int rx_ring_size,
 					       unsigned int tx_ring_size)
@@ -3063,6 +3084,7 @@ static struct macb_context *macb_context_alloc(struct macb *bp,
 		return ERR_PTR(-ENOMEM);
 
 	ctx->info = &bp->info;
+	ctx->num_queues = num_queues;
 	ctx->rx_buffer_size = macb_rx_buffer_size(bp, mtu);
 	ctx->rx_ring_size = rx_ring_size;
 	ctx->tx_ring_size = tx_ring_size;
@@ -3110,7 +3132,7 @@ static int gem_init_rings(struct macb_context *ctx)
 	int err;
 	int i;
 
-	for (q = 0; q < ctx->info->num_queues; ++q) {
+	for (q = 0; q < ctx->num_queues; ++q) {
 		txq = &ctx->txq[q];
 		for (i = 0; i < ctx->tx_ring_size; i++) {
 			desc = macb_tx_desc(ctx, q, i);
@@ -3173,7 +3195,7 @@ static void macb_reset_hw(struct macb *bp)
 	gem_writel(bp, PBUFRXCUT, 0);
 
 	/* Disable all interrupts */
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; ++q, ++queue) {
 		queue_writel(queue, IDR, -1);
 		queue_readl(queue, ISR);
 		macb_queue_isr_clear(bp, queue, -1);
@@ -3263,7 +3285,8 @@ static void macb_configure_dma(struct macb *bp)
 	buffer_size = bp->ctx->rx_buffer_size / RX_BUFFER_MULTIPLE;
 	if (macb_is_gem(&bp->info)) {
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->ctx->num_queues;
+		     ++q, ++queue) {
 			if (q)
 				queue_writel(queue, RBQS, buffer_size);
 			else
@@ -3312,7 +3335,7 @@ static void macb_context_swap_start(struct macb *bp)
 	netif_tx_disable(bp->netdev);
 
 	/* Now that everything is stopped, clear DQL. */
-	for (q = 0; q < bp->num_queues; ++q)
+	for (q = 0; q < bp->ctx->num_queues; ++q)
 		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
 
 	/* Safe to call outside bp->lock because bp->irq_quiesced ensures the IRQ
@@ -3328,7 +3351,7 @@ static void macb_context_swap_start(struct macb *bp)
 	ctrl = macb_readl(bp, NCR);
 	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; ++q, ++queue) {
 		queue_writel(queue, IDR, -1);
 		queue_readl(queue, ISR);
 		macb_queue_isr_clear(bp, queue, -1);
@@ -3351,16 +3374,21 @@ static void macb_context_swap_end(struct macb *bp,
 
 	lockdep_assert_held(&bp->mac_cfg_lock);
 
-	/* Swap contexts & give buffer pointers to HW. */
+	/* Swap contexts & give buffer pointers to HW.
+	 * !new_ctx means that the swap failed and we keep the old context.
+	 */
+
+	if (new_ctx) {
+		old_ctx = bp->ctx;
+		WRITE_ONCE(bp->ctx, new_ctx);
+		wmb(); /* ensure IRQ enabled below read the new context */
+	}
 
-	old_ctx = bp->ctx;
-	WRITE_ONCE(bp->ctx, new_ctx);
-	wmb(); /* ensure IRQ enabled below read the new context */
 	macb_init_buffers(bp);
 
 	/* Start NAPI, HW Tx/Rx and software Tx. */
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+	for (q = 0, queue = bp->queues; q < bp->ctx->num_queues; ++q, ++queue) {
 		napi_enable(&queue->napi_rx);
 		napi_enable(&queue->napi_tx);
 	}
@@ -3373,7 +3401,8 @@ static void macb_context_swap_end(struct macb *bp,
 	macb_configure_dma(bp);
 
 	if (bp->link_up) {
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->ctx->num_queues;
+		     ++q, ++queue) {
 			queue_writel(queue, IER,
 				     bp->rx_intr_mask |
 				     MACB_TX_INT_FLAGS |
@@ -3397,8 +3426,10 @@ static void macb_context_swap_end(struct macb *bp,
 
 	/* Free old context. */
 
-	macb_free(old_ctx);
-	kfree(old_ctx);
+	if (new_ctx) {
+		macb_free(old_ctx);
+		kfree(old_ctx);
+	}
 }
 
 static void macb_init_hw(struct macb *bp)
@@ -3572,7 +3603,7 @@ static int macb_open(struct net_device *netdev)
 	if (err < 0)
 		return err;
 
-	ctx = macb_context_alloc(bp, netdev->mtu,
+	ctx = macb_context_alloc(bp, bp->configured_num_queues, netdev->mtu,
 				 bp->configured_rx_ring_size,
 				 bp->configured_tx_ring_size);
 	if (IS_ERR(ctx)) {
@@ -3637,7 +3668,7 @@ static int macb_close(struct net_device *netdev)
 	 * and tx_error_task wake them up.
 	 */
 	netif_tx_stop_all_queues(netdev);
-	for (q = 0; q < bp->num_queues; ++q)
+	for (q = 0; q < bp->ctx->num_queues; ++q)
 		netdev_tx_reset_queue(netdev_get_tx_queue(netdev, q));
 
 	phylink_stop(bp->phylink);
@@ -3673,7 +3704,8 @@ static int macb_change_mtu(struct net_device *netdev, int new_mtu)
 		if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
 			return -EBUSY;
 
-		new_ctx = macb_context_alloc(bp, new_mtu,
+		new_ctx = macb_context_alloc(bp, bp->configured_num_queues,
+					     new_mtu,
 					     bp->configured_rx_ring_size,
 					     bp->configured_tx_ring_size);
 		if (IS_ERR(new_ctx))
@@ -3726,7 +3758,7 @@ static void gem_update_stats(struct macb *bp)
 	}
 
 	idx = GEM_STATS_LEN;
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue)
 		for (i = 0, stat = &queue->stats.first; i < QUEUE_STATS_LEN; ++i, ++stat)
 			bp->ethtool_stats[idx++] = *stat;
 }
@@ -3777,7 +3809,8 @@ static void gem_get_ethtool_stats(struct net_device *netdev,
 	spin_lock_irq(&bp->stats_lock);
 	gem_update_stats(bp);
 	memcpy(data, &bp->ethtool_stats, sizeof(u64)
-			* (GEM_STATS_LEN + QUEUE_STATS_LEN * bp->num_queues));
+			* (GEM_STATS_LEN + QUEUE_STATS_LEN *
+					   bp->max_num_queues));
 	spin_unlock_irq(&bp->stats_lock);
 }
 
@@ -3787,7 +3820,7 @@ static int gem_get_sset_count(struct net_device *netdev, int sset)
 
 	switch (sset) {
 	case ETH_SS_STATS:
-		return GEM_STATS_LEN + bp->num_queues * QUEUE_STATS_LEN;
+		return GEM_STATS_LEN + bp->max_num_queues * QUEUE_STATS_LEN;
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -3806,7 +3839,8 @@ static void gem_get_ethtool_strings(struct net_device *netdev, u32 sset, u8 *p)
 			memcpy(p, gem_statistics[i].stat_string,
 			       ETH_GSTRING_LEN);
 
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->max_num_queues;
+		     ++q, ++queue) {
 			for (i = 0; i < QUEUE_STATS_LEN; i++)
 				ethtool_sprintf(&p, "q%u_%s", q, queue_statistics[i].stat_string);
 		}
@@ -4165,8 +4199,9 @@ static int macb_set_ringparam(struct net_device *netdev,
 	}
 
 	if (running) {
-		new_ctx = macb_context_alloc(bp, netdev->mtu,
-					     new_rx_size, new_tx_size);
+		new_ctx = macb_context_alloc(bp, bp->configured_num_queues,
+					     netdev->mtu, new_rx_size,
+					     new_tx_size);
 		if (IS_ERR(new_ctx))
 			return PTR_ERR(new_ctx);
 
@@ -4513,7 +4548,7 @@ static u32 gem_get_rx_ring_count(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	return bp->num_queues;
+	return bp->max_num_queues;
 }
 
 static int gem_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
@@ -4544,6 +4579,7 @@ static int gem_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd,
 static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 {
 	struct macb *bp = netdev_priv(netdev);
+	unsigned int num_queues = bp->configured_num_queues;
 	int ret;
 
 	if (!(netdev->hw_features & NETIF_F_NTUPLE))
@@ -4551,8 +4587,8 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		if ((cmd->fs.location >= bp->max_tuples)
-				|| (cmd->fs.ring_cookie >= bp->num_queues)) {
+		if (cmd->fs.location >= bp->max_tuples ||
+		    cmd->fs.ring_cookie >= num_queues) {
 			ret = -EINVAL;
 			break;
 		}
@@ -4570,6 +4606,75 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static void macb_get_channels(struct net_device *netdev,
+			      struct ethtool_channels *ch)
+{
+	struct macb *bp = netdev_priv(netdev);
+
+	ch->max_combined = bp->max_num_queues;
+	ch->combined_count = bp->configured_num_queues;
+}
+
+static int macb_set_channels(struct net_device *netdev,
+			     struct ethtool_channels *ch)
+{
+	struct macb *bp = netdev_priv(netdev);
+	unsigned int num_queues = ch->combined_count;
+	bool running = netif_running(bp->netdev);
+	struct macb_context *new_ctx;
+	int ret;
+
+	/* MACB_CAPS_QUEUE_DISABLE means that the field QUEUE_DISABLE/BIT0 in
+	 * the per-queue RBQP/TBQP registers disable Tx/Rx queues. If we don't
+	 * have that capability we can have multiple queues but we must always
+	 * run with all enabled.
+	 */
+	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE))
+		return -EOPNOTSUPP;
+
+	if (num_queues > bp->max_num_queues)
+		return -EINVAL;
+
+	if (num_queues == bp->configured_num_queues)
+		return 0;
+
+	/* If we allow disable a queue which has TAPRIO active, we'll keep a
+	 * transmission window which will be unusable.
+	 */
+	if (bp->taprio_gated_queues >> num_queues) {
+		netdev_err(bp->netdev, "TAPRIO schedule gates queues >= %u; destroy the qdisc before reducing channels\n",
+			   num_queues);
+		return -EBUSY;
+	}
+
+	if (running) {
+		new_ctx = macb_context_alloc(bp, num_queues, netdev->mtu,
+					     bp->configured_rx_ring_size,
+					     bp->configured_tx_ring_size);
+		if (IS_ERR(new_ctx))
+			return PTR_ERR(new_ctx);
+
+		macb_context_swap_start(bp);
+	}
+
+	ret = netif_set_real_num_queues(bp->netdev, num_queues, num_queues);
+	if (ret) {
+		if (running) {
+			macb_free(new_ctx);
+			kfree(new_ctx);
+			macb_context_swap_end(bp, NULL);
+		}
+		return ret;
+	}
+
+	bp->configured_num_queues = num_queues;
+
+	if (running)
+		macb_context_swap_end(bp, new_ctx);
+
+	return 0;
+}
+
 static const struct ethtool_ops macb_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -4585,6 +4690,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_get_eee(struct net_device *netdev, struct ethtool_keee *eee)
@@ -4619,12 +4726,14 @@ static const struct ethtool_ops gem_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
-	.get_rxnfc			= gem_get_rxnfc,
-	.set_rxnfc			= gem_set_rxnfc,
-	.get_rx_ring_count		= gem_get_rx_ring_count,
-	.nway_reset			= phy_ethtool_nway_reset,
+	.get_rxnfc		= gem_get_rxnfc,
+	.set_rxnfc		= gem_set_rxnfc,
+	.get_rx_ring_count	= gem_get_rx_ring_count,
+	.nway_reset		= phy_ethtool_nway_reset,
 	.get_eee		= macb_get_eee,
 	.set_eee		= macb_set_eee,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
@@ -4765,9 +4874,9 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	size_t i, q;
 	int err;
 
-	if (conf->num_entries > bp->num_queues) {
-		netdev_err(netdev, "Too many TAPRIO entries: %zu > %d queues\n",
-			   conf->num_entries, bp->num_queues);
+	if (conf->num_entries > bp->configured_num_queues) {
+		netdev_err(netdev, "Too many TAPRIO entries: %zu > %u active queues\n",
+			   conf->num_entries, bp->configured_num_queues);
 		return -EINVAL;
 	}
 
@@ -4790,7 +4899,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 		return -EINVAL;
 	}
 
-	enst_queue = kzalloc_objs(*enst_queue, bp->num_queues);
+	enst_queue = kzalloc_objs(*enst_queue, bp->configured_num_queues);
 	if (unlikely(!enst_queue))
 		return -ENOMEM;
 
@@ -4815,9 +4924,10 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 
 		/* gate_mask must not select queues outside the valid queues */
 		queue_id = order_base_2(entry->gate_mask);
-		if (queue_id >= bp->num_queues) {
-			netdev_err(netdev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
-				   i, entry->gate_mask, bp->num_queues);
+		if (queue_id >= bp->configured_num_queues) {
+			netdev_err(netdev, "Entry %zu: gate_mask 0x%x exceeds active queue range (num_queues=%u)\n",
+				   i, entry->gate_mask,
+				   bp->configured_num_queues);
 			err = -EINVAL;
 			goto cleanup;
 		}
@@ -4876,11 +4986,12 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	/* All validations passed - proceed with hardware configuration */
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Disable ENST queues if running before configuring */
-		queue_mask = BIT_U32(bp->num_queues) - 1;
+		queue_mask = BIT_U32(bp->max_num_queues) - 1;
 		gem_writel(bp, ENST_CONTROL,
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->configured_num_queues;
+		     ++q, ++queue) {
 			/* Configure queue timing registers */
 			queue_writel(queue, ENST_START_TIME,
 				     enst_queue[q].start_time_mask);
@@ -4894,6 +5005,9 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 		gem_writel(bp, ENST_CONTROL, configured_queues);
 	}
 
+	/* Remember which queues are gated, to validate .set_channels(). */
+	bp->taprio_gated_queues = configured_queues;
+
 	netdev_info(netdev, "TAPRIO configuration completed successfully: %zu entries, %d queues configured\n",
 		    conf->num_entries, hweight32(configured_queues));
 
@@ -4910,7 +5024,12 @@ static void macb_taprio_destroy(struct net_device *netdev)
 	unsigned int q;
 
 	netdev_reset_tc(netdev);
-	queue_mask = BIT_U32(bp->num_queues) - 1;
+	bp->taprio_gated_queues = 0;
+
+	if (unlikely(pm_runtime_suspended(&bp->pdev->dev)))
+		return;
+
+	queue_mask = BIT_U32(bp->max_num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Single disable command for all queues */
@@ -4918,7 +5037,8 @@ static void macb_taprio_destroy(struct net_device *netdev)
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		/* Clear all queue ENST registers in batch */
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->max_num_queues;
+		     ++q, ++queue) {
 			queue_writel(queue, ENST_START_TIME, 0);
 			queue_writel(queue, ENST_ON_TIME, 0);
 			queue_writel(queue, ENST_OFF_TIME, 0);
@@ -4936,15 +5056,14 @@ static int macb_setup_taprio(struct net_device *netdev,
 	if (unlikely(!(netdev->hw_features & NETIF_F_HW_TC)))
 		return -EOPNOTSUPP;
 
-	/* Check if Device is in runtime suspend */
-	if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
-		netdev_err(netdev, "Device is in runtime suspend\n");
-		return -EOPNOTSUPP;
-	}
-
 	switch (taprio->cmd) {
 	case TAPRIO_CMD_REPLACE:
-		err = macb_taprio_setup_replace(netdev, taprio);
+		if (unlikely(pm_runtime_suspended(&bp->pdev->dev))) {
+			netdev_err(netdev, "Device is in runtime suspend\n");
+			err = -EOPNOTSUPP;
+		} else {
+			err = macb_taprio_setup_replace(netdev, taprio);
+		}
 		break;
 	case TAPRIO_CMD_DESTROY:
 		macb_taprio_destroy(netdev);
@@ -5196,7 +5315,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 	 * register mapping but we don't want to test the queue index then
 	 * compute the corresponding register offset at run time.
 	 */
-	for (hw_q = 0, q = 0; hw_q < bp->num_queues; ++hw_q) {
+	for (hw_q = 0, q = 0; hw_q < bp->max_num_queues; ++hw_q) {
 		queue = &bp->queues[q];
 		queue->bp = bp;
 		spin_lock_init(&queue->tx_ptr_lock);
@@ -6308,7 +6427,8 @@ static int macb_probe(struct platform_device *pdev)
 		bp->macb_reg_readl = hw_readl;
 		bp->macb_reg_writel = hw_writel;
 	}
-	bp->num_queues = num_queues;
+	bp->max_num_queues = num_queues;
+	bp->configured_num_queues = num_queues;
 	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;
@@ -6517,6 +6637,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 {
 	struct net_device *netdev = dev_get_drvdata(dev);
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_context *ctx = bp->ctx;
 	struct in_ifaddr *ifa = NULL;
 	struct macb_queue *queue;
 	struct in_device *idev;
@@ -6558,7 +6679,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			macb_writel(bp, RBQPH,
 				    upper_32_bits(bp->rx_ring_tieoff_dma));
 #endif
-		for (q = 0, queue = bp->queues; q < bp->num_queues;
+		for (q = 0, queue = bp->queues; q < ctx->num_queues;
 		     ++q, ++queue) {
 			/* Disable RX queues */
 			if (bp->caps & MACB_CAPS_QUEUE_DISABLE) {
@@ -6599,7 +6720,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 	}
 
 	netif_device_detach(netdev);
-	for (q = 0, queue = bp->queues; q < bp->num_queues;
+	for (q = 0, queue = bp->queues; q < ctx->num_queues;
 	     ++q, ++queue) {
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
@@ -6674,7 +6795,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
 		macb_init_buffers(bp);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues;
+	for (q = 0, queue = bp->queues; q < ctx->num_queues;
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 			if (macb_is_gem(&bp->info))

-- 
2.56.0

