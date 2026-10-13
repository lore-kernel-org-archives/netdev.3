Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D2D51B195;
	Tue, 13 Oct 2026 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897434; cv=none; b=eBcs4BuiasK+dSPTxIW7HDcaaomR32RwKhGwLraq5ANnM5JiQe6X3HWEPaCPkArVNCp4cjhFNp69cbuYvuEvyEZSmQLmBvs7YnyLitW8VDqO9v6WFIyL+e7RlybkTqC21PTPWemRazjbOBb6lI4nl5yIUxyZMcuCPaVToQ8wzsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897434; c=relaxed/simple;
	bh=auKV+oFk/fTabYOXZEZGfA15/qAFZy3CLScS/YR5BS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btFoGBUpUzwkFS1P4RmLCtAM3OLWf7cHV2O03tv1pojr2RGMswxNxQrLjcQPbiQo/Ks75JvaHwGtKG2Z+501Y1cYhfX09iteenyi3YiWMiCtJSyn7p34M7zZnaLT9X0xoTU46ROON06PGspM2no7QfspK6LXYeiltrRtNLfVXw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xlyEZxya; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xlyEZxya"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4E1AE4E41209;
	Tue, 13 Oct 2026 13:17:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1BB1560362;
	Tue, 13 Oct 2026 13:17:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B93711D713E9;
	Tue, 13 Oct 2026 15:17:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AE11OkoPBjDqVX3YOMdVrv/qaw/9Rp25tufIOtItOcY=;
	b=xlyEZxyaMlOeHM4EaWiFRRtJ/GaCPfFGllf1hKZh+uIw5aAco5eA7PZYht1PuUMjtsHaoQ
	ACE6/bg9iUt8Pfbaq0tU69uR1MOILolyWhS3MdSPnDGpbuXJXVX1kYZjvDJwh3lucg3Jv+
	cazVCkhXAUH46gzEXMAwjjb8uZ+a0tCSt8AkkTn4kEkTGxbN9XqgA9Zu6qpA/PJiMt2b76
	C71Nqe13QoKLYOqV2hMCC4RgCfanWrSbOCJPmVaIysehGHF4BlD1T6Xdh1TZ6oKUQEHxnz
	EKH+PFg2HNGRkbP/LN6lvyC3LXqI3Gq+WGrCyJOvtix44VeJzxXA2lIFFQZC5g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 13 Oct 2026 15:16:43 +0200
Subject: [PATCH net-next v11 5/9] net: macb: change caps helpers signatures
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-macb-context-v11-5-b27785167566@bootlin.com>
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

For parallel MACB context to start becoming a reality, many functions
will soon not have access to `struct macb *bp`. Those will still have
access to caps through ctx->info->caps.

Change all caps helpers signatures, from taking `struct macb *bp` to
taking `struct macb_info *info`. Info is accessible in both bp and ctx
and it ensures type safety (versus passing raw `u32 caps`).

Function list:

   macb_is_gem()
   gem_has_ptp()
   macb_dma64()
   macb_dma_ptp()
   macb_dma_desc_get_size()
   macb_set_addr()
   macb_get_addr()
   macb_64b_desc()
   macb_tx_unmap()

Note: drop macb_64b_desc(bp, ...) parameter; it is unused and it must
be dropped as macb_{set,get}_addr() call macb_64b_desc().

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |  21 ++--
 drivers/net/ethernet/cadence/macb_main.c | 159 ++++++++++++++++---------------
 drivers/net/ethernet/cadence/macb_ptp.c  |   8 +-
 3 files changed, 98 insertions(+), 90 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 075a328c4495..ddbab4c78bf4 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -834,7 +834,7 @@
  */
 #define macb_or_gem_writel(__bp, __reg, __value) \
 	({ \
-		if (macb_is_gem((__bp))) \
+		if (macb_is_gem(&(__bp)->info)) \
 			gem_writel((__bp), __reg, __value); \
 		else \
 			macb_writel((__bp), __reg, __value); \
@@ -843,7 +843,7 @@
 #define macb_or_gem_readl(__bp, __reg) \
 	({ \
 		u32 __v; \
-		if (macb_is_gem((__bp))) \
+		if (macb_is_gem(&(__bp)->info)) \
 			__v = gem_readl((__bp), __reg); \
 		else \
 			__v = macb_readl((__bp), __reg); \
@@ -1473,14 +1473,15 @@ static inline void gem_ptp_do_txstamp(struct macb *bp, struct sk_buff *skb, stru
 static inline void gem_ptp_do_rxstamp(struct macb *bp, struct sk_buff *skb, struct macb_dma_desc *desc) { }
 #endif
 
-static inline bool macb_is_gem(struct macb *bp)
+static inline bool macb_is_gem(const struct macb_info *info)
 {
-	return !!(bp->caps & MACB_CAPS_MACB_IS_GEM);
+	return !!(info->caps & MACB_CAPS_MACB_IS_GEM);
 }
 
-static inline bool gem_has_ptp(struct macb *bp)
+static inline bool gem_has_ptp(const struct macb_info *info)
 {
-	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) && (bp->caps & MACB_CAPS_GEM_HAS_PTP);
+	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
+	       (info->caps & MACB_CAPS_GEM_HAS_PTP);
 }
 
 /* ENST Helper functions */
@@ -1496,16 +1497,16 @@ static inline u64 enst_max_hw_interval(u32 speed_mbps)
 			    ENST_TIME_GRANULARITY_NS * 1000, (speed_mbps));
 }
 
-static inline bool macb_dma64(struct macb *bp)
+static inline bool macb_dma64(const struct macb_info *info)
 {
 	return IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
-	       bp->caps & MACB_CAPS_DMA_64B;
+	       info->caps & MACB_CAPS_DMA_64B;
 }
 
-static inline bool macb_dma_ptp(struct macb *bp)
+static inline bool macb_dma_ptp(const struct macb_info *info)
 {
 	return IS_ENABLED(CONFIG_MACB_USE_HWSTAMP) &&
-	       bp->caps & MACB_CAPS_DMA_PTP;
+	       info->caps & MACB_CAPS_DMA_PTP;
 }
 
 static inline void macb_queue_isr_clear(struct macb *bp,
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index dbc8168a0ba9..ac5660480840 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -126,13 +126,13 @@ struct sifive_fu540_macb_mgmt {
  *    word 5: timestamp word 1
  *    word 6: timestamp word 2
  */
-static unsigned int macb_dma_desc_get_size(struct macb *bp)
+static unsigned int macb_dma_desc_get_size(const struct macb_info *info)
 {
 	unsigned int desc_size = sizeof(struct macb_dma_desc);
 
-	if (macb_dma64(bp))
+	if (macb_dma64(info))
 		desc_size += sizeof(struct macb_dma_desc_64);
-	if (macb_dma_ptp(bp))
+	if (macb_dma_ptp(info))
 		desc_size += sizeof(struct macb_dma_desc_ptp);
 
 	return desc_size;
@@ -140,10 +140,10 @@ static unsigned int macb_dma_desc_get_size(struct macb *bp)
 
 static unsigned int macb_adj_dma_desc_idx(struct macb *bp, unsigned int desc_idx)
 {
-	return desc_idx * (1 + macb_dma64(bp) + macb_dma_ptp(bp));
+	return desc_idx * (1 + macb_dma64(&bp->info) + macb_dma_ptp(&bp->info));
 }
 
-static struct macb_dma_desc_64 *macb_64b_desc(struct macb *bp, struct macb_dma_desc *desc)
+static struct macb_dma_desc_64 *macb_64b_desc(struct macb_dma_desc *desc)
 {
 	return (struct macb_dma_desc_64 *)((void *)desc
 		+ sizeof(struct macb_dma_desc));
@@ -195,7 +195,7 @@ static dma_addr_t macb_tx_dma(struct macb_queue *queue, unsigned int index)
 	dma_addr_t offset;
 
 	offset = macb_tx_ring_wrap(queue->bp, index) *
-			macb_dma_desc_get_size(queue->bp);
+			macb_dma_desc_get_size(&queue->bp->info);
 
 	return txq->ring_dma + offset;
 }
@@ -282,7 +282,7 @@ static void macb_set_hwaddr(struct macb *bp)
 	top = get_unaligned_le16(bp->netdev->dev_addr + 4);
 	macb_or_gem_writel(bp, SA1T, top);
 
-	if (gem_has_ptp(bp)) {
+	if (gem_has_ptp(&bp->info)) {
 		gem_writel(bp, RXPTPUNI, bottom);
 		gem_writel(bp, TXPTPUNI, bottom);
 	}
@@ -493,7 +493,7 @@ static void macb_init_buffers(struct macb *bp)
 	unsigned int q;
 
 	/* Single register for all queues' high 32 bits. */
-	if (macb_dma64(bp)) {
+	if (macb_dma64(&bp->info)) {
 		rxq = &bp->ctx->rxq[0];
 		txq = &bp->ctx->txq[0];
 		macb_writel(bp, RBQPH, upper_32_bits(rxq->ring_dma));
@@ -787,7 +787,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	if (bp->caps & MACB_CAPS_MACB_IS_EMAC) {
 		if (state->interface == PHY_INTERFACE_MODE_RMII)
 			ctrl |= MACB_BIT(RM9200_RMII);
-	} else if (macb_is_gem(bp)) {
+	} else if (macb_is_gem(&bp->info)) {
 		ctrl &= ~(GEM_BIT(SGMIIEN) | GEM_BIT(PCSSEL));
 		ncr &= ~GEM_BIT(ENABLE_HS_MAC);
 
@@ -847,7 +847,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue *queue)
 	unsigned char desc[24];
 	unsigned long flags;
 
-	desc_size = macb_dma_desc_get_size(bp);
+	desc_size = macb_dma_desc_get_size(&bp->info);
 
 	if (WARN_ON_ONCE(desc_size > ARRAY_SIZE(desc)))
 		return;
@@ -954,7 +954,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
 		ctrl &= ~MACB_BIT(PAE);
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(&bp->info)) {
 			ctrl &= ~GEM_BIT(GBE);
 
 			if (speed == SPEED_1000)
@@ -985,7 +985,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 
 	/* Enable Rx and Tx; Enable PTP unicast */
 	ctrl = macb_readl(bp, NCR);
-	if (gem_has_ptp(bp))
+	if (gem_has_ptp(&bp->info))
 		ctrl |= MACB_BIT(PTPUNI);
 
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
@@ -1098,7 +1098,8 @@ static int macb_mii_probe(struct net_device *netdev)
 		  bp->phylink_config.supported_interfaces);
 
 	/* Determine what modes are supported */
-	if (macb_is_gem(bp) && (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
+	if (macb_is_gem(&bp->info) &&
+	    (bp->caps & MACB_CAPS_GIGABIT_MODE_AVAILABLE)) {
 		bp->phylink_config.mac_capabilities |= MAC_1000FD;
 		if (!(bp->caps & MACB_CAPS_NO_GIGABIT_HALF))
 			bp->phylink_config.mac_capabilities |= MAC_1000HD;
@@ -1253,14 +1254,15 @@ static int macb_halt_tx(struct macb *bp)
 					bp, TSR);
 }
 
-static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budget)
+static void macb_tx_unmap(const struct macb_info *info,
+			  struct macb_tx_skb *tx_skb, int budget)
 {
 	if (tx_skb->mapping) {
 		if (tx_skb->mapped_as_page)
-			dma_unmap_page(&bp->pdev->dev, tx_skb->mapping,
+			dma_unmap_page(&info->pdev->dev, tx_skb->mapping,
 				       tx_skb->size, DMA_TO_DEVICE);
 		else
-			dma_unmap_single(&bp->pdev->dev, tx_skb->mapping,
+			dma_unmap_single(&info->pdev->dev, tx_skb->mapping,
 					 tx_skb->size, DMA_TO_DEVICE);
 		tx_skb->mapping = 0;
 	}
@@ -1271,12 +1273,13 @@ static void macb_tx_unmap(struct macb *bp, struct macb_tx_skb *tx_skb, int budge
 	}
 }
 
-static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_t addr)
+static void macb_set_addr(const struct macb_info *info,
+			  struct macb_dma_desc *desc, dma_addr_t addr)
 {
-	if (macb_dma64(bp)) {
+	if (macb_dma64(info)) {
 		struct macb_dma_desc_64 *desc_64;
 
-		desc_64 = macb_64b_desc(bp, desc);
+		desc_64 = macb_64b_desc(desc);
 		desc_64->addrh = upper_32_bits(addr);
 		/* The low bits of RX address contain the RX_USED bit, clearing
 		 * of which allows packet RX. Make sure the high bits are also
@@ -1288,18 +1291,19 @@ static void macb_set_addr(struct macb *bp, struct macb_dma_desc *desc, dma_addr_
 	desc->addr = lower_32_bits(addr);
 }
 
-static dma_addr_t macb_get_addr(struct macb *bp, struct macb_dma_desc *desc)
+static dma_addr_t macb_get_addr(const struct macb_info *info,
+				struct macb_dma_desc *desc)
 {
 	dma_addr_t addr = 0;
 
-	if (macb_dma64(bp)) {
+	if (macb_dma64(info)) {
 		struct macb_dma_desc_64 *desc_64;
 
-		desc_64 = macb_64b_desc(bp, desc);
+		desc_64 = macb_64b_desc(desc);
 		addr = ((u64)(desc_64->addrh) << 32);
 	}
 	addr |= MACB_BF(RX_WADDR, MACB_BFEXT(RX_WADDR, desc->addr));
-	if (macb_dma_ptp(bp))
+	if (macb_dma_ptp(info))
 		addr &= ~GEM_BIT(DMA_RXVALID);
 	return addr;
 }
@@ -1359,7 +1363,7 @@ static void macb_tx_error_task(struct work_struct *work)
 		if (ctrl & MACB_BIT(TX_USED)) {
 			/* skb is set for the last buffer of the frame */
 			while (!skb) {
-				macb_tx_unmap(bp, tx_skb, 0);
+				macb_tx_unmap(&bp->info, tx_skb, 0);
 				tail++;
 				tx_skb = macb_tx_skb(queue, tail);
 				skb = tx_skb->skb;
@@ -1390,7 +1394,7 @@ static void macb_tx_error_task(struct work_struct *work)
 			desc->ctrl = ctrl | MACB_BIT(TX_USED);
 		}
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(&bp->info, tx_skb, 0);
 	}
 
 	netdev_tx_completed_queue(netdev_get_tx_queue(bp->netdev, q),
@@ -1398,7 +1402,7 @@ static void macb_tx_error_task(struct work_struct *work)
 
 	/* Set end of TX queue */
 	desc = macb_tx_desc(queue, 0);
-	macb_set_addr(bp, desc, 0);
+	macb_set_addr(&bp->info, desc, 0);
 	desc->ctrl = MACB_BIT(TX_USED);
 
 	/* Make descriptor updates visible to hardware */
@@ -1517,7 +1521,7 @@ static int macb_tx_complete(struct macb_queue *queue, int budget)
 			}
 
 			/* Now we can safely release resources */
-			macb_tx_unmap(bp, tx_skb, budget);
+			macb_tx_unmap(&bp->info, tx_skb, budget);
 
 			/* skb is set only for the last buffer of the frame.
 			 * WARNING: at this point skb has been freed by
@@ -1590,7 +1594,7 @@ static int gem_rx_refill(struct macb_queue *queue)
 			 * make sure ctrl is cleared first to avoid a race.
 			 */
 			dma_wmb();
-			macb_set_addr(bp, desc, paddr);
+			macb_set_addr(&bp->info, desc, paddr);
 
 			/* Properly align Ethernet header.
 			 *
@@ -1679,7 +1683,7 @@ static int gem_rx(struct macb_queue *queue, struct napi_struct *napi,
 		rmb();
 
 		rxused = (desc->addr & MACB_BIT(RX_USED)) ? true : false;
-		addr = macb_get_addr(bp, desc);
+		addr = macb_get_addr(&bp->info, desc);
 
 		if (!rxused)
 			break;
@@ -1843,7 +1847,7 @@ static inline void macb_init_rx_ring(struct macb_queue *queue)
 	addr = rxq->buffers_dma;
 	for (i = 0; i < bp->ctx->rx_ring_size; i++) {
 		desc = macb_rx_desc(queue, i);
-		macb_set_addr(bp, desc, addr);
+		macb_set_addr(&bp->info, desc, addr);
 		desc->ctrl = 0;
 		addr += bp->ctx->rx_buffer_size;
 	}
@@ -1939,7 +1943,7 @@ static bool macb_rx_pending(struct macb_queue *queue)
 	unsigned int entry;
 
 	/* No armed descriptor left: nothing can be pending. */
-	if (macb_is_gem(bp) && rxq->tail == rxq->prepared_head)
+	if (macb_is_gem(&bp->info) && rxq->tail == rxq->prepared_head)
 		return false;
 
 	entry = macb_rx_ring_wrap(bp, rxq->tail);
@@ -2000,7 +2004,7 @@ static void macb_tx_restart(struct macb_queue *queue)
 	if (txq->head == txq->tail)
 		goto out_tx_ptr_unlock;
 
-	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp);
+	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(&bp->info);
 	tbqp = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
 	head_idx = macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, txq->head));
 
@@ -2227,7 +2231,7 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 	if (status & MACB_BIT(ISR_ROVR)) {
 		/* We missed at least one packet */
 		spin_lock(&bp->stats_lock);
-		if (macb_is_gem(bp))
+		if (macb_is_gem(&bp->info))
 			bp->hw_stats.gem.rx_overruns++;
 		else
 			bp->hw_stats.macb.rx_overruns++;
@@ -2240,7 +2244,7 @@ static int macb_interrupt_misc(struct macb_queue *queue, u32 status)
 		macb_queue_isr_clear(bp, queue, MACB_BIT(HRESP));
 	}
 
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(&bp->info)) {
 		if (status & GEM_BIT(WOL))
 			gem_wol_interrupt(queue, status);
 	} else {
@@ -2488,7 +2492,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 			ctrl |= MACB_BF(MSS_MFS, mss_mfs);
 
 		/* Set TX buffer descriptor */
-		macb_set_addr(bp, desc, tx_skb->mapping);
+		macb_set_addr(&bp->info, desc, tx_skb->mapping);
 		/* desc->addr must be visible to hardware before clearing
 		 * 'TX_USED' bit in desc->ctrl.
 		 */
@@ -2506,7 +2510,7 @@ static unsigned int macb_tx_map(struct macb *bp,
 	for (i = txq->head; i != tx_head; i++) {
 		tx_skb = macb_tx_skb(queue, i);
 
-		macb_tx_unmap(bp, tx_skb, 0);
+		macb_tx_unmap(&bp->info, tx_skb, 0);
 	}
 
 	return -ENOMEM;
@@ -2713,7 +2717,7 @@ static netdev_tx_t macb_start_xmit(struct sk_buff *skb,
 		goto unlock;
 	}
 
-	if (macb_dma_ptp(bp) &&
+	if (macb_dma_ptp(&bp->info) &&
 	    (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
 
@@ -2747,7 +2751,7 @@ static unsigned int macb_rx_buffer_size(struct macb *bp, unsigned int mtu)
 {
 	unsigned int size;
 
-	if (!macb_is_gem(bp)) {
+	if (!macb_is_gem(&bp->info)) {
 		size = MACB_RX_BUFFER_SIZE;
 	} else {
 		size = mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
@@ -2788,7 +2792,7 @@ static void gem_free_rx_buffers(struct macb *bp)
 				continue;
 
 			desc = macb_rx_desc(queue, i);
-			addr = macb_get_addr(bp, desc);
+			addr = macb_get_addr(&bp->info, desc);
 
 			dma_unmap_single(&bp->pdev->dev, addr,
 					 bp->ctx->rx_buffer_size,
@@ -2817,13 +2821,13 @@ static void macb_free_rx_buffers(struct macb *bp)
 
 static unsigned int macb_tx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->ctx->tx_ring_size +
+	return macb_dma_desc_get_size(&bp->info) * bp->ctx->tx_ring_size +
 		bp->tx_bd_rd_prefetch;
 }
 
 static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 {
-	return macb_dma_desc_get_size(bp) * bp->ctx->rx_ring_size +
+	return macb_dma_desc_get_size(&bp->info) * bp->ctx->rx_ring_size +
 		bp->rx_bd_rd_prefetch;
 }
 
@@ -2857,7 +2861,8 @@ static void macb_free(struct macb *bp)
 			for (tail = txq->tail; tail != txq->head; tail++) {
 				if (macb_tx_skb(queue, tail)->skb)
 					dropped++;
-				macb_tx_unmap(bp, macb_tx_skb(queue, tail), 0);
+				macb_tx_unmap(&bp->info,
+					      macb_tx_skb(queue, tail), 0);
 			}
 
 			queue->stats.tx_dropped += dropped;
@@ -3006,7 +3011,7 @@ static int gem_init_rings(struct macb *bp)
 		txq = &bp->ctx->txq[q];
 		for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 			desc = macb_tx_desc(queue, i);
-			macb_set_addr(bp, desc, 0);
+			macb_set_addr(&bp->info, desc, 0);
 			desc->ctrl = MACB_BIT(TX_USED);
 		}
 		desc->ctrl |= MACB_BIT(TX_WRAP);
@@ -3031,7 +3036,7 @@ static int macb_init_rings(struct macb *bp)
 
 	for (i = 0; i < bp->ctx->tx_ring_size; i++) {
 		desc = macb_tx_desc(&bp->queues[0], i);
-		macb_set_addr(bp, desc, 0);
+		macb_set_addr(&bp->info, desc, 0);
 		desc->ctrl = MACB_BIT(TX_USED);
 	}
 	txq->head = 0;
@@ -3102,7 +3107,7 @@ static u32 macb_mdc_clk_div(struct macb *bp)
 	u32 config;
 	unsigned long pclk_hz;
 
-	if (macb_is_gem(bp))
+	if (macb_is_gem(&bp->info))
 		return gem_mdc_clk_div(bp);
 
 	pclk_hz = clk_get_rate(bp->pclk);
@@ -3124,7 +3129,7 @@ static u32 macb_mdc_clk_div(struct macb *bp)
  */
 static u32 macb_dbw(struct macb *bp)
 {
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(&bp->info))
 		return 0;
 
 	switch (GEM_BFEXT(DBWDEF, gem_readl(bp, DCFG1))) {
@@ -3153,7 +3158,7 @@ static void macb_configure_dma(struct macb *bp)
 	u32 dmacfg;
 
 	buffer_size = bp->ctx->rx_buffer_size / RX_BUFFER_MULTIPLE;
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(&bp->info)) {
 		dmacfg = gem_readl(bp, DMACFG) & ~GEM_BF(RXBS, -1L);
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 			if (q)
@@ -3177,9 +3182,9 @@ static void macb_configure_dma(struct macb *bp)
 			dmacfg &= ~GEM_BIT(TXCOEN);
 
 		dmacfg &= ~GEM_BIT(ADDR64);
-		if (macb_dma64(bp))
+		if (macb_dma64(&bp->info))
 			dmacfg |= GEM_BIT(ADDR64);
-		if (macb_dma_ptp(bp))
+		if (macb_dma_ptp(&bp->info))
 			dmacfg |= GEM_BIT(RXEXT) | GEM_BIT(TXEXT);
 		netdev_dbg(bp->netdev, "Cadence configure DMA with 0x%08x\n",
 			   dmacfg);
@@ -3207,7 +3212,8 @@ static void macb_init_hw(struct macb *bp)
 		config |= MACB_BIT(BIG);	/* Receive oversized frames */
 	if (bp->netdev->flags & IFF_PROMISC)
 		config |= MACB_BIT(CAF);	/* Copy All Frames */
-	else if (macb_is_gem(bp) && bp->netdev->features & NETIF_F_RXCSUM)
+	else if (macb_is_gem(&bp->info) &&
+		 bp->netdev->features & NETIF_F_RXCSUM)
 		config |= GEM_BIT(RXCOEN);
 	if (!(bp->netdev->flags & IFF_BROADCAST))
 		config |= MACB_BIT(NBC);	/* No BroadCast */
@@ -3315,14 +3321,14 @@ static void macb_set_rx_mode(struct net_device *netdev)
 		cfg |= MACB_BIT(CAF);
 
 		/* Disable RX checksum offload */
-		if (macb_is_gem(bp))
+		if (macb_is_gem(&bp->info))
 			cfg &= ~GEM_BIT(RXCOEN);
 	} else {
 		/* Disable promiscuous mode */
 		cfg &= ~MACB_BIT(CAF);
 
 		/* Enable RX checksum offload only if requested */
-		if (macb_is_gem(bp) && netdev->features & NETIF_F_RXCSUM)
+		if (macb_is_gem(&bp->info) && netdev->features & NETIF_F_RXCSUM)
 			cfg |= GEM_BIT(RXCOEN);
 	}
 
@@ -3601,7 +3607,7 @@ static void macb_get_stats(struct net_device *netdev,
 	struct macb_stats *hwstat = &bp->hw_stats.macb;
 
 	netdev_stats_to_stats64(nstat, &bp->netdev->stats);
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(&bp->info)) {
 		gem_get_stats(bp, nstat);
 		return;
 	}
@@ -3849,7 +3855,7 @@ static void macb_get_regs(struct net_device *netdev, struct ethtool_regs *regs,
 
 	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED))
 		regs_buff[12] = macb_or_gem_readl(bp, USRIO);
-	if (macb_is_gem(bp))
+	if (macb_is_gem(&bp->info))
 		regs_buff[13] = gem_readl(bp, DMACFG);
 }
 
@@ -3984,7 +3990,7 @@ static int gem_get_ts_info(struct net_device *netdev,
 {
 	struct macb *bp = netdev_priv(netdev);
 
-	if (!macb_dma_ptp(bp)) {
+	if (!macb_dma_ptp(&bp->info)) {
 		ethtool_op_get_ts_info(netdev, info);
 		return 0;
 	}
@@ -4085,7 +4091,7 @@ static void gem_prog_cmp_regs(struct macb *bp, struct ethtool_rx_flow_spec *fs)
 	bool cmp_b = false;
 	bool cmp_c = false;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(&bp->info))
 		return;
 
 	tp4sp_v = &(fs->h_u.tcp_ip4_spec);
@@ -4446,7 +4452,7 @@ static inline void macb_set_txcsum_feature(struct macb *bp,
 {
 	u32 val;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(&bp->info))
 		return;
 
 	val = gem_readl(bp, DMACFG);
@@ -4464,7 +4470,7 @@ static inline void macb_set_rxcsum_feature(struct macb *bp,
 	struct net_device *netdev = bp->netdev;
 	u32 val;
 
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(&bp->info))
 		return;
 
 	val = gem_readl(bp, NCFGR);
@@ -4479,7 +4485,7 @@ static inline void macb_set_rxcsum_feature(struct macb *bp,
 static inline void macb_set_rxflow_feature(struct macb *bp,
 					   netdev_features_t features)
 {
-	if (!macb_is_gem(bp))
+	if (!macb_is_gem(&bp->info))
 		return;
 
 	gem_enable_flow_filters(bp, !!(features & NETIF_F_NTUPLE));
@@ -4804,7 +4810,7 @@ static void macb_configure_caps(struct macb *bp,
 			bp->caps |= MACB_CAPS_FIFO_MODE;
 		if (GEM_BFEXT(PBUF_RSC, gem_readl(bp, DCFG6)))
 			bp->caps |= MACB_CAPS_RSC;
-		if (gem_has_ptp(bp)) {
+		if (gem_has_ptp(&bp->info)) {
 			if (!GEM_BFEXT(TSU, gem_readl(bp, DCFG5)))
 				dev_err(&bp->pdev->dev,
 					"GEM doesn't support hardware ptp.\n");
@@ -5021,7 +5027,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 	netdev->netdev_ops = &macb_netdev_ops;
 
 	/* setup appropriated routines according to adapter type */
-	if (macb_is_gem(bp)) {
+	if (macb_is_gem(&bp->info)) {
 		bp->macbgem_ops.mog_alloc_rx_buffers = gem_alloc_rx_buffers;
 		bp->macbgem_ops.mog_free_rx_buffers = gem_free_rx_buffers;
 		bp->macbgem_ops.mog_init_rings = gem_init_rings;
@@ -5050,7 +5056,7 @@ static int macb_init_dflt(struct platform_device *pdev)
 		netdev->hw_features |= MACB_NETIF_LSO;
 
 	/* Checksum offload is only available on gem with packet buffer */
-	if (macb_is_gem(bp) && !(bp->caps & MACB_CAPS_FIFO_MODE))
+	if (macb_is_gem(&bp->info) && !(bp->caps & MACB_CAPS_FIFO_MODE))
 		netdev->hw_features |= NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	if (bp->caps & MACB_CAPS_SG_DISABLED)
 		netdev->hw_features &= ~NETIF_F_SG;
@@ -5177,7 +5183,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 
 	rxq->ring = dma_alloc_coherent(&bp->pdev->dev,
 				       (AT91ETHER_MAX_RX_DESCR *
-					macb_dma_desc_get_size(bp)),
+					macb_dma_desc_get_size(&bp->info)),
 				       &rxq->ring_dma, GFP_KERNEL);
 	if (!rxq->ring)
 		return -ENOMEM;
@@ -5190,7 +5196,7 @@ static int at91ether_alloc_coherent(struct macb *bp)
 	if (!rxq->buffers) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(bp),
+				  macb_dma_desc_get_size(&bp->info),
 				  rxq->ring, rxq->ring_dma);
 		rxq->ring = NULL;
 		return -ENOMEM;
@@ -5206,7 +5212,7 @@ static void at91ether_free_coherent(struct macb *bp)
 	if (rxq->ring) {
 		dma_free_coherent(&bp->pdev->dev,
 				  AT91ETHER_MAX_RX_DESCR *
-				  macb_dma_desc_get_size(bp),
+				  macb_dma_desc_get_size(&bp->info),
 				  rxq->ring, rxq->ring_dma);
 		rxq->ring = NULL;
 	}
@@ -5237,7 +5243,7 @@ static int at91ether_start(struct macb *bp)
 	addr = rxq->buffers_dma;
 	for (i = 0; i < AT91ETHER_MAX_RX_DESCR; i++) {
 		desc = macb_rx_desc(queue, i);
-		macb_set_addr(bp, desc, addr);
+		macb_set_addr(&bp->info, desc, addr);
 		desc->ctrl = 0;
 		addr += AT91ETHER_MAX_RBUFF_SZ;
 	}
@@ -5768,13 +5774,13 @@ static int macb_alloc_tieoff(struct macb *bp)
 		return 0;
 
 	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-						macb_dma_desc_get_size(bp),
+						macb_dma_desc_get_size(&bp->info),
 						&bp->rx_ring_tieoff_dma,
 						GFP_KERNEL);
 	if (!bp->rx_ring_tieoff)
 		return -ENOMEM;
 
-	macb_set_addr(bp, bp->rx_ring_tieoff,
+	macb_set_addr(&bp->info, bp->rx_ring_tieoff,
 		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
 
 	bp->rx_ring_tieoff->ctrl = 0;
@@ -5787,7 +5793,7 @@ static void macb_free_tieoff(struct macb *bp)
 	if (!bp->rx_ring_tieoff)
 		return;
 
-	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(&bp->info),
 			  bp->rx_ring_tieoff,
 			  bp->rx_ring_tieoff_dma);
 	bp->rx_ring_tieoff = NULL;
@@ -6178,12 +6184,12 @@ static int macb_probe(struct platform_device *pdev)
 		val = GEM_BFEXT(RXBD_RDBUFF, gem_readl(bp, DCFG10));
 		if (val)
 			bp->rx_bd_rd_prefetch = (2 << (val - 1)) *
-						macb_dma_desc_get_size(bp);
+						macb_dma_desc_get_size(&bp->info);
 
 		val = GEM_BFEXT(TXBD_RDBUFF, gem_readl(bp, DCFG10));
 		if (val)
 			bp->tx_bd_rd_prefetch = (2 << (val - 1)) *
-						macb_dma_desc_get_size(bp);
+						macb_dma_desc_get_size(&bp->info);
 	}
 
 	bp->rx_intr_mask = MACB_RX_INT_FLAGS;
@@ -6228,8 +6234,9 @@ static int macb_probe(struct platform_device *pdev)
 	}
 
 	netdev_info(netdev, "Cadence %s rev 0x%08x at 0x%08lx irq %d (%pM)\n",
-		    macb_is_gem(bp) ? "GEM" : "MACB", macb_readl(bp, MID),
-		    netdev->base_addr, netdev->irq, netdev->dev_addr);
+		    macb_is_gem(&bp->info) ? "GEM" : "MACB",
+		    macb_readl(bp, MID), netdev->base_addr, netdev->irq,
+		    netdev->dev_addr);
 
 	pm_runtime_put_autosuspend(&bp->pdev->dev);
 
@@ -6361,7 +6368,7 @@ static int __maybe_unused macb_suspend(struct device *dev)
 			tmp |= MACB_BFEXT(IP, ifa_local);
 		}
 
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(&bp->info)) {
 			queue_writel(bp->queues, IER, GEM_BIT(WOL));
 			gem_writel(bp, WOL, tmp);
 		} else {
@@ -6423,7 +6430,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	if (bp->wol & MACB_WOL_ENABLED) {
 		spin_lock_irqsave(&bp->lock, flags);
 		/* Disable WoL */
-		if (macb_is_gem(bp)) {
+		if (macb_is_gem(&bp->info)) {
 			queue_writel(bp->queues, IDR, GEM_BIT(WOL));
 			gem_writel(bp, WOL, 0);
 		} else {
@@ -6451,7 +6458,7 @@ static int __maybe_unused macb_resume(struct device *dev)
 	for (q = 0, queue = bp->queues; q < bp->num_queues;
 	     ++q, ++queue) {
 		if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
-			if (macb_is_gem(bp))
+			if (macb_is_gem(&bp->info))
 				gem_init_rx_ring(queue);
 			else
 				macb_init_rx_ring(queue);
diff --git a/drivers/net/ethernet/cadence/macb_ptp.c b/drivers/net/ethernet/cadence/macb_ptp.c
index 2fd063394698..28e0e48b42d8 100644
--- a/drivers/net/ethernet/cadence/macb_ptp.c
+++ b/drivers/net/ethernet/cadence/macb_ptp.c
@@ -28,10 +28,10 @@
 static struct macb_dma_desc_ptp *macb_ptp_desc(struct macb *bp,
 					       struct macb_dma_desc *desc)
 {
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(&bp->info))
 		return NULL;
 
-	if (macb_dma64(bp))
+	if (macb_dma64(&bp->info))
 		return (struct macb_dma_desc_ptp *)
 				((u8 *)desc + sizeof(struct macb_dma_desc)
 				+ sizeof(struct macb_dma_desc_64));
@@ -380,7 +380,7 @@ int gem_get_hwtst(struct net_device *netdev,
 	struct macb *bp = netdev_priv(netdev);
 
 	*tstamp_config = bp->tstamp_config;
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(&bp->info))
 		return -EOPNOTSUPP;
 
 	return 0;
@@ -399,7 +399,7 @@ int gem_set_hwtst(struct net_device *netdev,
 	u32 ncr_bits = 0;
 	u32 regval;
 
-	if (!macb_dma_ptp(bp))
+	if (!macb_dma_ptp(&bp->info))
 		return -EOPNOTSUPP;
 
 	switch (tstamp_config->tx_type) {

-- 
2.56.0

