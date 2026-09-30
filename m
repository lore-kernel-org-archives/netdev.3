Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C9480DD6;
	Wed, 30 Sep 2026 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808866; cv=none; b=acav6g56xFGrsDV9wpC5KoOiJWRNbs6zJmIHkG5O8d4u1tt2byAU/cSll0zMwl9Ncc6ks+1lTdRCjrBNm7sf6Acl9tsuRqzYzkgItoTS3OG28ef/KsgopoG0Am+nCyGrHt1t312xyxMadQMGebILgTE3YprwjzyJzL7aU9JFl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808866; c=relaxed/simple;
	bh=28Tf3c2gUmQojYPFTJtVPu0eYAaSgyE6shREYoooPuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=geJnY3jT52wNBMyEyqwU/6wEJT8NMKilp2SIU7Hz+w1hhXgzuNXWgG0V2+iJqWzubfTpY1iq0rBbdzp/eLDvzpD52QtPWehyhuxM4/GQQNd0mFF3esm0czdNidVKCg6vmYKEGXl/uw2ZVV1LMErchT+msVDGFQ6kh7mAz8GM48s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SBtUyZgs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SBtUyZgs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DD07F1A108E;
	Wed, 30 Sep 2026 22:54:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B217E60749;
	Wed, 30 Sep 2026 22:54:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 72F5C1032A657;
	Thu,  1 Oct 2026 00:54:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790808854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=txRBp7TmPvz3eexXMlImYokiuWMEz8ZWi31mWWFII3Q=;
	b=SBtUyZgsS6qmP6Z+l6IrT15wybyGnVZF7dASXOUiSsGD9Ro8QyNXgte+fZyQJ89qd79o7Q
	M9IdA8Km5H+kP6qrSPStci3/z4ELeFGASUYy2RxtqvA3TrD/78QdDrPZ6zaVNi5xZZUtb8
	tct3JZ9hCcBncsoR9+knZojvqpQ+M2cuJg0tiEVEfNHVpgQaV0ye7fKO4r7ko4O7QD1OVC
	pUY1MOM+GXMce+fY6S2lo298pbgTdoOMRs9pPNmmm4uQGgL+z7fF//1Pr5gc05YeCpdOWO
	FAdwyFgUILlVWkItUI0rHJz0KBOmiKQFMpVLfcre09o5jaXvgUuq8gELXk0lYw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 01 Oct 2026 00:53:51 +0200
Subject: [PATCH net-next v10 7/8] net: macb: use context swapping in
 .set_ringparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-macb-context-v10-7-beb541bbb7df@bootlin.com>
References: <20261001-macb-context-v10-0-beb541bbb7df@bootlin.com>
In-Reply-To: <20261001-macb-context-v10-0-beb541bbb7df@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
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

ethtool_ops.set_ringparam() is implemented using the primitive close /
update ring size / reopen sequence. Under memory pressure this does not
fly: we free our buffers at close and cannot reallocate new ones at
open. Also, it triggers a slow PHY reinit.

Instead, exploit the new context mechanism and improve our sequence to:
 - allocate a new context (including buffers) first
 - if it fails, early return without any impact to the interface
 - stop interface
 - update global state (bp, netdev, etc)
 - pass buffer pointers to the hardware
 - start interface
 - free old context.

The HW disable sequence is inspired by macb_reset_hw() but avoids
(1) setting NCR bit CLRSTAT and (2) clearing register PBUFRXCUT.

The HW re-enable sequence is inspired by macb_mac_link_up(), skipping
over register writes which would be redundant (because values have not
changed).

The generic context swapping parts are isolated into helper functions
macb_context_swap_start|end(), reusable by other operations (change_mtu,
set_channels, etc).

Introduce a new locking primitive (mac_cfg_lock mutex) to serialise swap
with phylink MAC callbacks. Avoid stopping phylink to avoid a slow PHY
retrain. We cannot sync to phylink ops using phydev->lock because it is
not available in the SFP case. We cannot check link state using
netif_carrier_ok() because we could race with its changes; so we use a
redundant bp->link_up boolean that is mac_cfg_lock protected.

AT91 EMAC is handled differently as their buffer management is separate
and they don't do NAPI. They must never call swap_start/end(). Anyway
they do not implement set_ringparam (-EOPNOTSUPP) so we are safe.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   7 +-
 drivers/net/ethernet/cadence/macb_main.c | 188 +++++++++++++++++++++++++++----
 2 files changed, 175 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index 5b7133476b31..0cdef672dc70 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1358,6 +1358,8 @@ struct macb {
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
+	/* Serializes context swap against phylink MAC callbacks. */
+	struct mutex		mac_cfg_lock;
 	struct clk		*pclk;
 	struct clk		*hclk;
 	struct clk		*tx_clk;
@@ -1419,10 +1421,13 @@ struct macb {
 	u32			tx_lpi_timer;
 
 	/* ISR must not drive NAPI & BH mechanisms. True when the interface
-	 * is closed. Protected by bp->lock.
+	 * is closed or during context-swap. Protected by bp->lock.
 	 */
 	bool			irq_quiesced;
 
+	/* Redundant to netif_carrier_ok(), but set under bp->mac_cfg_lock. */
+	bool			link_up;
+
 	u32	rx_intr_mask;
 
 	struct macb_pm_data pm_data;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 69873966a989..93049b399d78 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -746,12 +746,26 @@ static void macb_mac_disable_tx_lpi(struct phylink_config *config)
 	struct macb *bp = netdev_priv(netdev);
 	unsigned long flags;
 
+	mutex_lock(&bp->mac_cfg_lock);
+
 	cancel_delayed_work_sync(&bp->tx_lpi_work);
 
 	spin_lock_irqsave(&bp->lock, flags);
 	bp->eee_active = false;
 	macb_tx_lpi_set(bp, false);
 	spin_unlock_irqrestore(&bp->lock, flags);
+
+	mutex_unlock(&bp->mac_cfg_lock);
+}
+
+static void macb_txp_lpi_initial_defer(struct macb *bp)
+{
+	lockdep_assert_held(&bp->mac_cfg_lock);
+
+	/* Defer initial LPI entry by 1 second after link-up per
+	 * IEEE 802.3az section 22.7a.
+	 */
+	mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));
 }
 
 static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
@@ -761,15 +775,16 @@ static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	struct macb *bp = netdev_priv(netdev);
 	unsigned long flags;
 
+	mutex_lock(&bp->mac_cfg_lock);
+
 	spin_lock_irqsave(&bp->lock, flags);
 	bp->tx_lpi_timer = timer;
 	bp->eee_active = true;
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	/* Defer initial LPI entry by 1 second after link-up per
-	 * IEEE 802.3az section 22.7a.
-	 */
-	mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));
+	macb_txp_lpi_initial_defer(bp);
+
+	mutex_unlock(&bp->mac_cfg_lock);
 
 	return 0;
 }
@@ -783,6 +798,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	u32 old_ctrl, ctrl;
 	u32 old_ncr, ncr;
 
+	mutex_lock(&bp->mac_cfg_lock);
 	spin_lock_irqsave(&bp->lock, flags);
 
 	old_ctrl = ctrl = macb_or_gem_readl(bp, NCFGR);
@@ -816,6 +832,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		macb_or_gem_writel(bp, NCR, ncr);
 
 	spin_unlock_irqrestore(&bp->lock, flags);
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
@@ -827,6 +844,10 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	unsigned int q;
 	u32 ctrl;
 
+	mutex_lock(&bp->mac_cfg_lock);
+
+	bp->link_up = false;
+
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
 			queue_writel(queue, IDR,
@@ -837,6 +858,8 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	macb_writel(bp, NCR, ctrl);
 
 	netif_tx_stop_all_queues(netdev);
+
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 /* Use juggling algorithm to left rotate tx ring and tx skb array */
@@ -945,8 +968,11 @@ static void macb_mac_link_up(struct phylink_config *config,
 	unsigned int q;
 	u32 ctrl;
 
+	mutex_lock(&bp->mac_cfg_lock);
 	spin_lock_irqsave(&bp->lock, flags);
 
+	bp->link_up = true;
+
 	ctrl = macb_or_gem_readl(bp, NCFGR);
 
 	ctrl &= ~(MACB_BIT(SPD) | MACB_BIT(FD));
@@ -996,6 +1022,8 @@ static void macb_mac_link_up(struct phylink_config *config,
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	netif_tx_wake_all_queues(netdev);
+
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
@@ -2004,29 +2032,37 @@ static int macb_rx_poll(struct napi_struct *napi, int budget)
 
 static void macb_tx_restart(struct macb_queue *queue)
 {
-	struct macb_context *ctx = queue->bp->ctx;
-	struct macb_txq *txq = macb_txq(queue);
 	struct macb *bp = queue->bp;
 	unsigned int head_idx, tbqp;
+	struct macb_context *ctx;
+	struct macb_txq *txq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->tx_ptr_lock, flags);
 
+	spin_lock(&bp->lock);
+
+	/* context swap ongoing? */
+	if (bp->irq_quiesced)
+		goto out_unlock;
+
+	ctx = queue->bp->ctx;
+	txq = macb_txq(queue);
+
 	if (txq->head == txq->tail)
-		goto out_tx_ptr_unlock;
+		goto out_unlock;
 
 	tbqp = queue_readl(queue, TBQP) / macb_dma_desc_get_size(ctx->info);
 	tbqp = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, tbqp));
 	head_idx = macb_adj_dma_desc_idx(ctx, macb_tx_ring_wrap(ctx, txq->head));
 
 	if (tbqp == head_idx)
-		goto out_tx_ptr_unlock;
+		goto out_unlock;
 
-	spin_lock(&bp->lock);
 	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(TSTART));
-	spin_unlock(&bp->lock);
 
-out_tx_ptr_unlock:
+out_unlock:
+	spin_unlock(&bp->lock);
 	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
 }
 
@@ -2282,7 +2318,9 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	spin_lock(&bp->lock);
 
 	while (status) {
-		/* self-disarm while the netdev is closed */
+		/* self-disarm while the netdev is closed
+		 * or during context swap
+		 */
 		if (unlikely(bp->irq_quiesced)) {
 			queue_writel(queue, IDR, -1);
 			macb_queue_isr_clear(bp, queue, -1);
@@ -3217,6 +3255,112 @@ static void macb_configure_dma(struct macb *bp)
 	}
 }
 
+static void macb_context_swap_start(struct macb *bp)
+{
+	struct macb_queue *queue;
+	unsigned long flags;
+	unsigned int q;
+	u32 ctrl;
+
+	mutex_lock(&bp->mac_cfg_lock);
+
+	macb_quiesce_start(bp);
+
+	/* Can finally disable software Tx; need to wait until napi_tx and
+	 * tx_error_task cannot be scheduled as either might wakeup Tx.
+	 */
+	netif_tx_disable(bp->netdev);
+
+	/* Now that everything is stopped, clear DQL. */
+	for (q = 0; q < bp->num_queues; ++q)
+		netdev_tx_reset_queue(netdev_get_tx_queue(bp->netdev, q));
+
+	/* Safe to call outside bp->lock because bp->irq_quiesced ensures the IRQ
+	 * handling is a no-op and all BH features are disabled.
+	 *
+	 * Whether it fails or not we'll disable TE/RE next.
+	 * We were just trying to be nice.
+	 */
+	macb_halt_tx(bp);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	ctrl = macb_readl(bp, NCR);
+	macb_writel(bp, NCR, ctrl & ~(MACB_BIT(RE) | MACB_BIT(TE)));
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		queue_writel(queue, IDR, -1);
+		queue_readl(queue, ISR);
+		macb_queue_isr_clear(bp, queue, -1);
+	}
+
+	macb_writel(bp, TSR, -1);
+	macb_writel(bp, RSR, -1);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+}
+
+static void macb_context_swap_end(struct macb *bp,
+				  struct macb_context *new_ctx)
+{
+	struct macb_context *old_ctx;
+	struct macb_queue *queue;
+	unsigned long flags;
+	unsigned int q;
+	u32 ctrl;
+
+	lockdep_assert_held(&bp->mac_cfg_lock);
+
+	/* Swap contexts & give buffer pointers to HW. */
+
+	old_ctx = bp->ctx;
+	WRITE_ONCE(bp->ctx, new_ctx);
+	wmb(); /* ensure IRQ enabled below read the new context */
+	macb_init_buffers(bp);
+
+	/* Start NAPI, HW Tx/Rx and software Tx. */
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		napi_enable(&queue->napi_rx);
+		napi_enable(&queue->napi_tx);
+	}
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	/* Re-arm normal interrupt processing before enabling IRQs. */
+	bp->irq_quiesced = false;
+
+	macb_configure_dma(bp);
+
+	if (bp->link_up) {
+		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+			queue_writel(queue, IER,
+				     bp->rx_intr_mask |
+				     MACB_TX_INT_FLAGS |
+				     MACB_BIT(HRESP));
+		}
+
+		ctrl = macb_readl(bp, NCR);
+		macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
+	}
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	if (bp->link_up) {
+		netif_tx_wake_all_queues(bp->netdev);
+
+		if (bp->eee_active)
+			macb_txp_lpi_initial_defer(bp);
+	}
+
+	mutex_unlock(&bp->mac_cfg_lock);
+
+	/* Free old context. */
+
+	macb_free(old_ctx);
+	kfree(old_ctx);
+}
+
 static void macb_init_hw(struct macb *bp)
 {
 	u32 config;
@@ -3937,9 +4081,10 @@ static int macb_set_ringparam(struct net_device *netdev,
 			      struct kernel_ethtool_ringparam *kernel_ring,
 			      struct netlink_ext_ack *extack)
 {
+	unsigned int new_rx_size, new_tx_size;
 	struct macb *bp = netdev_priv(netdev);
-	u32 new_rx_size, new_tx_size;
-	unsigned int reset = 0;
+	bool running = netif_running(netdev);
+	struct macb_context *new_ctx;
 
 	if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
 		return -EOPNOTSUPP;
@@ -3961,16 +4106,20 @@ static int macb_set_ringparam(struct net_device *netdev,
 		return 0;
 	}
 
-	if (netif_running(bp->netdev)) {
-		reset = 1;
-		macb_close(bp->netdev);
+	if (running) {
+		new_ctx = macb_context_alloc(bp, netdev->mtu,
+					     new_rx_size, new_tx_size);
+		if (IS_ERR(new_ctx))
+			return PTR_ERR(new_ctx);
+
+		macb_context_swap_start(bp);
 	}
 
 	bp->configured_rx_ring_size = new_rx_size;
 	bp->configured_tx_ring_size = new_tx_size;
 
-	if (reset)
-		macb_open(bp->netdev);
+	if (running)
+		macb_context_swap_end(bp, new_ctx);
 
 	return 0;
 }
@@ -6153,6 +6302,7 @@ static int macb_probe(struct platform_device *pdev)
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
 	spin_lock_init(&bp->tsu_clk_lock);
+	mutex_init(&bp->mac_cfg_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);

-- 
2.55.0

