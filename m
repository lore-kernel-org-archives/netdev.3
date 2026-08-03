Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131633AD503;
	Mon,  3 Aug 2026 20:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787726; cv=none; b=AYQg/6/A5xB3rL5MFiJXTC333Z2gFVBgzk8C10BvGK2pUR6s01WwoNNzSVR75HrKJObh6JMMZWJhQdKC/GvAyPgAuHV2eQ28BZFPW8xyawdnwd0zMGz7Rbfh/DnrM7trLJCg3+tlTUUjzr/PAF1AiPop59tfPzAAlKapnj1oM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787726; c=relaxed/simple;
	bh=fRCbATMF4QutBqP3k/BxK7uT62vP4gGrX18d6uMTRBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UwMU66apq/KmYqIWzp29g/G7IGbFrGr0UWaZJvxMwQrIR2sICW5FMPZG+De7abIzS1kOz3kfTyE9MLtimSex9dnqPJgyNoUVnCtR6ZIfCq7k648xnN6dVTZwF2s0rNXkRwuu9yOLocKt7GHgYqI1xFaovqUPPXp4SPaZYg/wfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=x0+ArFQo; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="x0+ArFQo"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5273E4E410AE;
	Mon,  3 Aug 2026 20:08:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AA356029B;
	Mon,  3 Aug 2026 20:08:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D314911C31856;
	Mon,  3 Aug 2026 22:08:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785787716; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MQSDLVOHIjYSdyi9Tjt3xLH4qTHXw2GhFDcPMrJ91+Q=;
	b=x0+ArFQoD4W4egU6GO/WP1/6SippQ6sOwV/sN6A0buTGhLu1BHSVYDhOxysQzjbLYFNXxj
	KO/bKhguGXxAb8BWUGGC8fmj53lFXHIUvtJ5qL036UXd7KhSO1n2qPA2UAJrbSx1KX49zL
	IVJLZLzLznUReqRH8eovccgnrKFL6YRqP1+lfuXb6DyC0B80svIdjiv710MIj5bqkKM8p/
	I+4adIrjyt9u/kzqpqg5tL4ppoZFK0APnQ91O5diJDQq1nmrCd64EICoL4aZG55PFVgin7
	M1f2GlLm6EY6/G78+QZFnOgOQTFszFfxyLT/3RKx8XKzERhJIFWAJrUsxds3sg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Mon, 03 Aug 2026 22:08:10 +0200
Subject: [PATCH net-next v7 03/17] net: macb: unify variable naming
 convention in at91ether functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260803-macb-context-v7-3-4d7d4af04849@bootlin.com>
References: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
In-Reply-To: <20260803-macb-context-v7-0-4d7d4af04849@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Follow MACB naming convention throughout on two aspects:
 - Always name `struct macb *bp` rather than `lp`.
 - Always name `struct macb_queue *queue` rather than `q`.

The latter is to reserve `q` for queue indexes.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 176 ++++++++++++++++---------------
 1 file changed, 91 insertions(+), 85 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 3ae76d1d2a0d..e01a5e0bf481 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4965,71 +4965,72 @@ static const struct macb_usrio_config at91_default_usrio = {
 
 static struct sifive_fu540_macb_mgmt *mgmt;
 
-static int at91ether_alloc_coherent(struct macb *lp)
+static int at91ether_alloc_coherent(struct macb *bp)
 {
-	struct macb_queue *q = &lp->queues[0];
+	struct macb_queue *queue = &bp->queues[0];
 
-	q->rx_ring = dma_alloc_coherent(&lp->pdev->dev,
-					 (AT91ETHER_MAX_RX_DESCR *
-					  macb_dma_desc_get_size(lp)),
-					 &q->rx_ring_dma, GFP_KERNEL);
-	if (!q->rx_ring)
+	queue->rx_ring = dma_alloc_coherent(&bp->pdev->dev,
+					    (AT91ETHER_MAX_RX_DESCR *
+					     macb_dma_desc_get_size(bp)),
+					    &queue->rx_ring_dma, GFP_KERNEL);
+	if (!queue->rx_ring)
 		return -ENOMEM;
 
-	q->rx_buffers = dma_alloc_coherent(&lp->pdev->dev,
-					    AT91ETHER_MAX_RX_DESCR *
-					    AT91ETHER_MAX_RBUFF_SZ,
-					    &q->rx_buffers_dma, GFP_KERNEL);
-	if (!q->rx_buffers) {
-		dma_free_coherent(&lp->pdev->dev,
+	queue->rx_buffers = dma_alloc_coherent(&bp->pdev->dev,
+					       AT91ETHER_MAX_RX_DESCR *
+					       AT91ETHER_MAX_RBUFF_SZ,
+					       &queue->rx_buffers_dma,
+					       GFP_KERNEL);
+	if (!queue->rx_buffers) {
+		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(lp),
-				  q->rx_ring, q->rx_ring_dma);
-		q->rx_ring = NULL;
+				  macb_dma_desc_get_size(bp),
+				  queue->rx_ring, queue->rx_ring_dma);
+		queue->rx_ring = NULL;
 		return -ENOMEM;
 	}
 
 	return 0;
 }
 
-static void at91ether_free_coherent(struct macb *lp)
+static void at91ether_free_coherent(struct macb *bp)
 {
-	struct macb_queue *q = &lp->queues[0];
+	struct macb_queue *queue = &bp->queues[0];
 
-	if (q->rx_ring) {
-		dma_free_coherent(&lp->pdev->dev,
+	if (queue->rx_ring) {
+		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(lp),
-				  q->rx_ring, q->rx_ring_dma);
-		q->rx_ring = NULL;
+				  macb_dma_desc_get_size(bp),
+				  queue->rx_ring, queue->rx_ring_dma);
+		queue->rx_ring = NULL;
 	}
 
-	if (q->rx_buffers) {
-		dma_free_coherent(&lp->pdev->dev,
+	if (queue->rx_buffers) {
+		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
 				  AT91ETHER_MAX_RBUFF_SZ,
-				  q->rx_buffers, q->rx_buffers_dma);
-		q->rx_buffers = NULL;
+				  queue->rx_buffers, queue->rx_buffers_dma);
+		queue->rx_buffers = NULL;
 	}
 }
 
 /* Initialize and start the Receiver and Transmit subsystems */
-static int at91ether_start(struct macb *lp)
+static int at91ether_start(struct macb *bp)
 {
-	struct macb_queue *q = &lp->queues[0];
+	struct macb_queue *queue = &bp->queues[0];
 	struct macb_dma_desc *desc;
 	dma_addr_t addr;
 	u32 ctl;
 	int i, ret;
 
-	ret = at91ether_alloc_coherent(lp);
+	ret = at91ether_alloc_coherent(bp);
 	if (ret)
 		return ret;
 
-	addr = q->rx_buffers_dma;
+	addr = queue->rx_buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
-		desc = macb_rx_desc(q, i);
-		macb_set_addr(lp, desc, addr);
+		desc = macb_rx_desc(queue, i);
+		macb_set_addr(bp, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
 	}
@@ -5038,17 +5039,17 @@ static int at91ether_start(struct macb *lp)
 	desc->addr |= MACB_BIT(RX_WRAP);
 
 	/* Reset buffer index */
-	q->rx_tail = 0;
+	queue->rx_tail = 0;
 
 	/* Program address of descriptor list in Rx Buffer Queue register */
-	macb_writel(lp, RBQP, q->rx_ring_dma);
+	macb_writel(bp, RBQP, queue->rx_ring_dma);
 
 	/* Enable Receive and Transmit */
-	ctl = macb_readl(lp, NCR);
-	macb_writel(lp, NCR, ctl | MACB_BIT(RE) | MACB_BIT(TE));
+	ctl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	/* Enable MAC interrupts */
-	macb_writel(lp, IER, MACB_BIT(RCOMP)	|
+	macb_writel(bp, IER, MACB_BIT(RCOMP)	|
 			     MACB_BIT(RXUBR)	|
 			     MACB_BIT(ISR_TUND)	|
 			     MACB_BIT(ISR_RLE)	|
@@ -5059,12 +5060,12 @@ static int at91ether_start(struct macb *lp)
 	return 0;
 }
 
-static void at91ether_stop(struct macb *lp)
+static void at91ether_stop(struct macb *bp)
 {
 	u32 ctl;
 
 	/* Disable MAC interrupts */
-	macb_writel(lp, IDR, MACB_BIT(RCOMP)	|
+	macb_writel(bp, IDR, MACB_BIT(RCOMP)	|
 			     MACB_BIT(RXUBR)	|
 			     MACB_BIT(ISR_TUND)	|
 			     MACB_BIT(ISR_RLE)	|
@@ -5073,35 +5074,35 @@ static void at91ether_stop(struct macb *lp)
 			     MACB_BIT(HRESP));
 
 	/* Disable Receiver and Transmitter */
-	ctl = macb_readl(lp, NCR);
-	macb_writel(lp, NCR, ctl & ~(MACB_BIT(TE) | MACB_BIT(RE)));
+	ctl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctl & ~(MACB_BIT(TE) | MACB_BIT(RE)));
 
 	/* Free resources. */
-	at91ether_free_coherent(lp);
+	at91ether_free_coherent(bp);
 }
 
 /* Open the ethernet interface */
 static int at91ether_open(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
 	u32 ctl;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(&lp->pdev->dev);
+	ret = pm_runtime_resume_and_get(&bp->pdev->dev);
 	if (ret < 0)
 		return ret;
 
 	/* Clear internal statistics */
-	ctl = macb_readl(lp, NCR);
-	macb_writel(lp, NCR, ctl | MACB_BIT(CLRSTAT));
+	ctl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctl | MACB_BIT(CLRSTAT));
 
-	macb_set_hwaddr(lp);
+	macb_set_hwaddr(bp);
 
-	ret = at91ether_start(lp);
+	ret = at91ether_start(bp);
 	if (ret)
 		goto pm_exit;
 
-	ret = macb_phylink_connect(lp);
+	ret = macb_phylink_connect(bp);
 	if (ret)
 		goto stop;
 
@@ -5110,25 +5111,25 @@ static int at91ether_open(struct net_device *netdev)
 	return 0;
 
 stop:
-	at91ether_stop(lp);
+	at91ether_stop(bp);
 pm_exit:
-	pm_runtime_put_sync(&lp->pdev->dev);
+	pm_runtime_put_sync(&bp->pdev->dev);
 	return ret;
 }
 
 /* Close the interface */
 static int at91ether_close(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
 
 	netif_stop_queue(netdev);
 
-	phylink_stop(lp->phylink);
-	phylink_disconnect_phy(lp->phylink);
+	phylink_stop(bp->phylink);
+	phylink_disconnect_phy(bp->phylink);
 
-	at91ether_stop(lp);
+	at91ether_stop(bp);
 
-	pm_runtime_put(&lp->pdev->dev);
+	pm_runtime_put(&bp->pdev->dev);
 
 	return 0;
 }
@@ -5137,19 +5138,21 @@ static int at91ether_close(struct net_device *netdev)
 static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 					struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
+	struct device *dev = &bp->pdev->dev;
 
-	if (macb_readl(lp, TSR) & MACB_BIT(RM9200_BNQ)) {
+	if (macb_readl(bp, TSR) & MACB_BIT(RM9200_BNQ)) {
 		int desc = 0;
 
 		netif_stop_queue(netdev);
 
 		/* Store packet information (to free when Tx completed) */
-		lp->rm9200_txq[desc].skb = skb;
-		lp->rm9200_txq[desc].size = skb->len;
-		lp->rm9200_txq[desc].mapping = dma_map_single(&lp->pdev->dev, skb->data,
-							      skb->len, DMA_TO_DEVICE);
-		if (dma_mapping_error(&lp->pdev->dev, lp->rm9200_txq[desc].mapping)) {
+		bp->rm9200_txq[desc].skb = skb;
+		bp->rm9200_txq[desc].size = skb->len;
+		bp->rm9200_txq[desc].mapping = dma_map_single(dev, skb->data,
+							      skb->len,
+							      DMA_TO_DEVICE);
+		if (dma_mapping_error(dev, bp->rm9200_txq[desc].mapping)) {
 			dev_kfree_skb_any(skb);
 			netdev->stats.tx_dropped++;
 			netdev_err(netdev, "%s: DMA mapping error\n", __func__);
@@ -5157,9 +5160,9 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
 		}
 
 		/* Set address of the data in the Transmit Address register */
-		macb_writel(lp, TAR, lp->rm9200_txq[desc].mapping);
+		macb_writel(bp, TAR, bp->rm9200_txq[desc].mapping);
 		/* Set length of the packet in the Transmit Control register */
-		macb_writel(lp, TCR, skb->len);
+		macb_writel(bp, TCR, skb->len);
 
 	} else {
 		netdev_err(netdev, "%s called, but device is busy!\n",
@@ -5175,16 +5178,17 @@ static netdev_tx_t at91ether_start_xmit(struct sk_buff *skb,
  */
 static void at91ether_rx(struct net_device *netdev)
 {
-	struct macb *lp = netdev_priv(netdev);
-	struct macb_queue *q = &lp->queues[0];
+	struct macb *bp = netdev_priv(netdev);
+	struct macb_queue *queue = &bp->queues[0];
 	struct macb_dma_desc *desc;
 	unsigned char *p_recv;
 	struct sk_buff *skb;
 	unsigned int pktlen;
 
-	desc = macb_rx_desc(q, q->rx_tail);
+	desc = macb_rx_desc(queue, queue->rx_tail);
 	while (desc->addr & MACB_BIT(RX_USED)) {
-		p_recv = q->rx_buffers + q->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
+		p_recv = queue->rx_buffers +
+			 queue->rx_tail * AT91ETHER_MAX_RBUFF_SZ;
 		pktlen = MACB_BF(RX_FRMLEN, desc->ctrl);
 		skb = netdev_alloc_skb(netdev, pktlen + 2);
 		if (skb) {
@@ -5206,12 +5210,12 @@ static void at91ether_rx(struct net_device *netdev)
 		desc->addr &= ~MACB_BIT(RX_USED);
 
 		/* wrap after last buffer */
-		if (q->rx_tail == AT91ETHER_MAX_RX_DESCR - 1)
-			q->rx_tail = 0;
+		if (queue->rx_tail == AT91ETHER_MAX_RX_DESCR - 1)
+			queue->rx_tail = 0;
 		else
-			q->rx_tail++;
+			queue->rx_tail++;
 
-		desc = macb_rx_desc(q, q->rx_tail);
+		desc = macb_rx_desc(queue, queue->rx_tail);
 	}
 }
 
@@ -5219,14 +5223,14 @@ static void at91ether_rx(struct net_device *netdev)
 static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 {
 	struct net_device *netdev = dev_id;
-	struct macb *lp = netdev_priv(netdev);
+	struct macb *bp = netdev_priv(netdev);
 	u32 intstatus, ctl;
 	unsigned int desc;
 
 	/* MAC Interrupt Status register indicates what interrupts are pending.
 	 * It is automatically cleared once read.
 	 */
-	intstatus = macb_readl(lp, ISR);
+	intstatus = macb_readl(bp, ISR);
 
 	/* Receive complete */
 	if (intstatus & MACB_BIT(RCOMP))
@@ -5239,23 +5243,25 @@ static irqreturn_t at91ether_interrupt(int irq, void *dev_id)
 			netdev->stats.tx_errors++;
 
 		desc = 0;
-		if (lp->rm9200_txq[desc].skb) {
-			dev_consume_skb_irq(lp->rm9200_txq[desc].skb);
-			lp->rm9200_txq[desc].skb = NULL;
-			dma_unmap_single(&lp->pdev->dev, lp->rm9200_txq[desc].mapping,
-					 lp->rm9200_txq[desc].size, DMA_TO_DEVICE);
+		if (bp->rm9200_txq[desc].skb) {
+			dev_consume_skb_irq(bp->rm9200_txq[desc].skb);
+			bp->rm9200_txq[desc].skb = NULL;
+			dma_unmap_single(&bp->pdev->dev,
+					 bp->rm9200_txq[desc].mapping,
+					 bp->rm9200_txq[desc].size,
+					 DMA_TO_DEVICE);
 			netdev->stats.tx_packets++;
-			netdev->stats.tx_bytes += lp->rm9200_txq[desc].size;
+			netdev->stats.tx_bytes += bp->rm9200_txq[desc].size;
 		}
 		netif_wake_queue(netdev);
 	}
 
 	/* Work-around for EMAC Errata section 41.3.1 */
 	if (intstatus & MACB_BIT(RXUBR)) {
-		ctl = macb_readl(lp, NCR);
-		macb_writel(lp, NCR, ctl & ~MACB_BIT(RE));
+		ctl = macb_readl(bp, NCR);
+		macb_writel(bp, NCR, ctl & ~MACB_BIT(RE));
 		wmb();
-		macb_writel(lp, NCR, ctl | MACB_BIT(RE));
+		macb_writel(bp, NCR, ctl | MACB_BIT(RE));
 	}
 
 	if (intstatus & MACB_BIT(ISR_ROVR))

-- 
2.55.0

