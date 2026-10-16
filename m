Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B753CA97
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792169924; cv=none; b=SRDH2e9IlG5lzF2ZsFM0D5KLQtNpk6/VQK6QMOpwFbsQGBt2vDRyo9XfyodfhO2f+eepuTxcICres1QTsVGF3oFZov1XJKN6kvsobKyscKovEpJp2cDcZJXzZbvmLXc75nPZwjVE947Mw2G6CB/NiRHkEbs2C1DHq3FKzQjRoNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792169924; c=relaxed/simple;
	bh=lhT9zcb5ZuoIML+dnjxEzCFNE99rGmMMPDTjLnAlfcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iBRt9+qO4ueLX/cLSiqYaP9KEYMSwN6E2WMkl4WAQHR1WuUG53h3kcijAX1WHtQA1J1fmZwkC18L3P6RSkrOluGiu8ZgyfTCm9e3lMY5CCd1wY0mjWK7Rk8zgy/mjHLp5PjlHO/TKpHltATm5faNQKBgU1B53vpc8E5sbYhejZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X45cEYca; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X45cEYca"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 279D8C62202;
	Fri, 16 Oct 2026 16:59:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 44B126075D;
	Fri, 16 Oct 2026 16:58:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5789510328719;
	Fri, 16 Oct 2026 18:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792169914; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hOXTMQwc8ZeogwgIiBTgzXuzkTS6f4RgDNwjCaRjofw=;
	b=X45cEYca82IXBFYHqkMocsNjOMp9y6GTH//c7espEjZYQYLp86GAZFl57vTKMtYjyuisUr
	iiFMsA2bD/6cjv9bxoQeu0Ckyy1ZaL1P/Y5InAUq8imkR2qK2+cTOrWBdfAKjn9BlZAw8c
	vd9pvOu3EdL2qK7Pg4YZhAz3Ha3mUslmbmG6yTDcv8QlhmNRXuDQ9RW6L2PHAw5lrozbsT
	AW/ms2Z4VbR7e31qty640TfBfjpb/D0sskfM+sI1D5JNJU5kCEvuJwo6F89SQHhaX7jydQ
	GE/RpKF+NgSFQL6OziYpPG42EAOvbJRXDBBc3fZKOx4/wcacY65dTJxlC1dC5g==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 16 Oct 2026 18:58:16 +0200
Subject: [PATCH net-next v5 2/3] net: macb: implement
 ethtool_ops.get|set_channels()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261016-macb-set-channels-v5-2-90ce0c0b8e75@bootlin.com>
References: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
In-Reply-To: <20261016-macb-set-channels-v5-0-90ce0c0b8e75@bootlin.com>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>, Paolo Valerio <pvalerio@redhat.com>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.15-dev
X-Last-TLS-Session-Version: TLSv1.3

bp->num_queues is the total number of queues and is constant from probe.
Introduce bp->max_num_queues which takes the current role of
bp->num_queues and allow `0 < bp->num_queues <= bp->max_num_queues`.
MACB/GEM does not know about Rx/Tx specific queues; it only has
combined queues.

set_channels is reserved to devices with MACB_CAPS_QUEUE_DISABLE.
The tieoff workaround would not work as packets would still be routed
into queues with a tieoff descriptor.

Implement .set_channels() operation by refusing if netif_running(). We
need context-swapping support upstream for proper on-the-fly channel
count change.

Note we refuse the operation if any TAPRIO rules are in place on queues
that would get disabled. If we allow the operation to take place, then
a transmission window would be reserved but unusable.

Nit: fix an alignment issue inside gem_ethtool_ops which does not
deserve its own patch.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   3 +
 drivers/net/ethernet/cadence/macb_main.c | 109 ++++++++++++++++++++++++++-----
 2 files changed, 95 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 82499ec6a9f0..51835de0f2a1 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1314,6 +1314,9 @@ struct macb {
 	unsigned int		tx_ring_size;
 
 	unsigned int		num_queues;
+	unsigned int		max_num_queues;
+	/* Queue mask gated by the current TAPRIO schedule (RTNL-protected). */
+	u32			taprio_gated_queues;
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 625171fd3f9b..2d069454795b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -473,9 +473,26 @@ static void macb_init_buffers(struct macb *bp)
 			    upper_32_bits(bp->queues[0].tx_ring_dma));
 	}
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
-		queue_writel(queue, RBQP, lower_32_bits(queue->rx_ring_dma));
-		queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue) {
+		if (q < bp->num_queues) {
+			queue_writel(queue, RBQP,
+				     lower_32_bits(queue->rx_ring_dma));
+			queue_writel(queue, TBQP,
+				     lower_32_bits(queue->tx_ring_dma));
+		} else {
+			/*
+			 * macb_set_channels(), which is the only way of writing
+			 * to bp->num_queues, is only allowed if
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
 
@@ -2044,7 +2061,7 @@ static void macb_quiesce_start(struct macb *bp)
 	bp->irq_quiesced = true;
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
+	for (q = 0, queue = bp->queues; q < bp->max_num_queues; ++q, ++queue)
 		synchronize_irq(queue->irq);
 
 	cancel_work_sync(&bp->hresp_err_bh_work);
@@ -2209,6 +2226,7 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	struct macb_queue *queue = dev_id;
 	struct macb *bp = queue->bp;
 	struct net_device *netdev = bp->netdev;
+	unsigned int q = queue - bp->queues;
 	bool hresp_err = false;
 	u32 status;
 
@@ -2220,16 +2238,18 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	spin_lock(&bp->lock);
 
 	while (status) {
-		/* self-disarm while the netdev is closed */
-		if (unlikely(bp->irq_quiesced)) {
+		/* Self-disarm while the netdev is closed or
+		 * the current queue is disabled.
+		 */
+		if (unlikely(bp->irq_quiesced ||
+			     q >= READ_ONCE(bp->num_queues))) {
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
@@ -4247,6 +4267,51 @@ static int gem_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 	return ret;
 }
 
+static void macb_get_channels(struct net_device *netdev,
+			      struct ethtool_channels *ch)
+{
+	struct macb *bp = netdev_priv(netdev);
+
+	ch->max_combined = bp->max_num_queues;
+	ch->combined_count = bp->num_queues;
+}
+
+static int macb_set_channels(struct net_device *netdev,
+			     struct ethtool_channels *ch)
+{
+	struct macb *bp = netdev_priv(netdev);
+	unsigned int count = ch->combined_count;
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
+	/* TODO: reuse context swapping once it is merged. */
+	if (netif_running(bp->netdev))
+		return -EBUSY;
+
+	/* If we allow disable a queue which has TAPRIO active, we'll keep a
+	 * transmission window which will be unusable.
+	 */
+	if (bp->taprio_gated_queues >> count) {
+		netdev_err(bp->netdev, "TAPRIO schedule gates queues >= %u; destroy the qdisc before reducing channels\n",
+			   count);
+		return -EBUSY;
+	}
+
+	ret = netif_set_real_num_queues(bp->netdev, count, count);
+	if (ret)
+		return ret;
+
+	bp->num_queues = count;
+	return 0;
+}
+
 static const struct ethtool_ops macb_ethtool_ops = {
 	.get_regs_len		= macb_get_regs_len,
 	.get_regs		= macb_get_regs,
@@ -4262,6 +4327,8 @@ static const struct ethtool_ops macb_ethtool_ops = {
 	.set_link_ksettings     = macb_set_link_ksettings,
 	.get_ringparam		= macb_get_ringparam,
 	.set_ringparam		= macb_set_ringparam,
+	.get_channels		= macb_get_channels,
+	.set_channels		= macb_set_channels,
 };
 
 static int macb_get_eee(struct net_device *netdev, struct ethtool_keee *eee)
@@ -4296,12 +4363,14 @@ static const struct ethtool_ops gem_ethtool_ops = {
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
@@ -4443,7 +4512,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	int err;
 
 	if (conf->num_entries > bp->num_queues) {
-		netdev_err(netdev, "Too many TAPRIO entries: %zu > %d queues\n",
+		netdev_err(netdev, "Too many TAPRIO entries: %zu > %u active queues\n",
 			   conf->num_entries, bp->num_queues);
 		return -EINVAL;
 	}
@@ -4493,7 +4562,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 		/* gate_mask must not select queues outside the valid queues */
 		queue_id = order_base_2(entry->gate_mask);
 		if (queue_id >= bp->num_queues) {
-			netdev_err(netdev, "Entry %zu: gate_mask 0x%x exceeds queue range (max_queues=%d)\n",
+			netdev_err(netdev, "Entry %zu: gate_mask 0x%x exceeds active queue range (num_queues=%u)\n",
 				   i, entry->gate_mask, bp->num_queues);
 			err = -EINVAL;
 			goto cleanup;
@@ -4553,7 +4622,7 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 	/* All validations passed - proceed with hardware configuration */
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Disable ENST queues if running before configuring */
-		queue_mask = BIT_U32(bp->num_queues) - 1;
+		queue_mask = BIT_U32(bp->max_num_queues) - 1;
 		gem_writel(bp, ENST_CONTROL,
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
@@ -4571,6 +4640,9 @@ static int macb_taprio_setup_replace(struct net_device *netdev,
 		gem_writel(bp, ENST_CONTROL, configured_queues);
 	}
 
+	/* Remember which queues are gated, to validate .set_channels(). */
+	bp->taprio_gated_queues = configured_queues;
+
 	netdev_info(netdev, "TAPRIO configuration completed successfully: %zu entries, %d queues configured\n",
 		    conf->num_entries, hweight32(configured_queues));
 
@@ -4587,7 +4659,7 @@ static void macb_taprio_destroy(struct net_device *netdev)
 	unsigned int q;
 
 	netdev_reset_tc(netdev);
-	queue_mask = BIT_U32(bp->num_queues) - 1;
+	queue_mask = BIT_U32(bp->max_num_queues) - 1;
 
 	scoped_guard(spinlock_irqsave, &bp->lock) {
 		/* Single disable command for all queues */
@@ -4595,12 +4667,14 @@ static void macb_taprio_destroy(struct net_device *netdev)
 			   queue_mask << GEM_ENST_DISABLE_QUEUE_OFFSET);
 
 		/* Clear all queue ENST registers in batch */
-		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		for (q = 0, queue = bp->queues; q < bp->max_num_queues;
+		     ++q, ++queue) {
 			queue_writel(queue, ENST_START_TIME, 0);
 			queue_writel(queue, ENST_ON_TIME, 0);
 			queue_writel(queue, ENST_OFF_TIME, 0);
 		}
 	}
+	bp->taprio_gated_queues = 0;
 	netdev_info(netdev, "TAPRIO destroy: All gates disabled\n");
 }
 
@@ -5972,6 +6046,7 @@ static int macb_probe(struct platform_device *pdev)
 		bp->macb_reg_writel = hw_writel;
 	}
 	bp->num_queues = num_queues;
+	bp->max_num_queues = num_queues;
 	bp->dma_burst_length = macb_config->dma_burst_length;
 	bp->pclk = pclk;
 	bp->hclk = hclk;

-- 
2.56.0

