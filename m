Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F5478E25;
	Fri, 31 Jul 2026 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515725; cv=none; b=moCgihie1ygDVYbSAczUfbCqYgFTkQVEBIMUbkIHxblmEhv52qTC9FJIaTwh6mqTRMRTyXm6lYM2FLsYhpg0mHssrE3KdKigBhXcO0XgD4bReZAsPg8ttxcRQPzSoYJQQoZtCyFPT95RpNec6waz49xxVosFtTDEG4G57bF5HKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515725; c=relaxed/simple;
	bh=L2xPm2XDygtHKC9ojRfzY8qrS2dDxFMXCqfzr9jfPgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoXL2N6taFCS8QgfHLTf4YVMP5QCIwq7yKw4pWyRCd66nKeUM955SUjRJ4J8WmhtjgQPtuSP4S5XFC2s9/pnuTtOAsa77xWDASpDtQkLy2l+ClSbwxwhbGgewtXaE+8Tf2T4hyhgei4gMdyNamVPa2nnL2e4/UC6yIcKDSkmJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=owLoFehF; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="owLoFehF"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D405C4E41059;
	Fri, 31 Jul 2026 16:35:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A24D9603C2;
	Fri, 31 Jul 2026 16:35:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EFC6D11C16AEE;
	Fri, 31 Jul 2026 18:35:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785515720; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7/TM1TZ14ZX4zKc5iYkksg6Z3DRKCz79L5mpBLLbGEE=;
	b=owLoFehFJ6fzyJqOqhDBIrDtCIb/7ilShUwaDV9wNfnjnwETl+2JBOSXi9QyzF2NYpSIq9
	t/MYHadZ/AudUQJ/YgCJNA5Q4hNQZjba3Jtyu9rX59h1pD46Ja/Dm4TNzCOvc7QtX6U4ZV
	1XAbNui79BwVBGs/28m0A4ZolfFNjoPEm8HWjSQOhgUalvuG7u85SoWmqYc5eVJVUHKMqa
	ynwYvQik7ZnjVhPVG7QF7Y+mBxzsZDkE2FSAdg5ThGQStUtmQzpQoVv7YjeklFyT+Xy75V
	ONA+TJ4qOp7FvfiWOYh7MLsw3xE2Pd/s7KSTTukvxMmxBeZ7bflCiKpf1Y5Njg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 31 Jul 2026 18:34:25 +0200
Subject: [PATCH net-next v6 15/16] net: macb: use context swapping in
 .set_ringparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260731-macb-context-v6-15-49d5a1439d48@bootlin.com>
References: <20260731-macb-context-v6-0-49d5a1439d48@bootlin.com>
In-Reply-To: <20260731-macb-context-v6-0-49d5a1439d48@bootlin.com>
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
retrain. Those callbacks grab phydev->lock if it exists so we could
imagine grabbing that from the swap op, but phydev->lock doesn't exist
in the SFP case.

AT91 EMAC is handled differently as their buffer management is separate
and they don't do NAPI. We refuse them (-EBUSY) to avoid implementing
context swapping for them.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb.h      |   5 +
 drivers/net/ethernet/cadence/macb_main.c | 171 +++++++++++++++++++++++++++++--
 2 files changed, 167 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
index ac2f2d8065d7..93e513cf1fbb 100644
--- a/drivers/net/ethernet/cadence/macb.h
+++ b/drivers/net/ethernet/cadence/macb.h
@@ -1361,6 +1361,8 @@ struct macb {
 	struct macb_queue	queues[MACB_MAX_QUEUES];
 
 	spinlock_t		lock;
+	/* Serializes context swap against phylink MAC callbacks. */
+	struct mutex		mac_cfg_lock;
 	struct clk		*pclk;
 	struct clk		*hclk;
 	struct clk		*tx_clk;
@@ -1421,6 +1423,9 @@ struct macb {
 	struct delayed_work	tx_lpi_work;
 	u32			tx_lpi_timer;
 
+	/* ISR must not drive NAPI & BH mechanisms. Protected by bp->lock. */
+	bool			ctx_swap;
+
 	u32	rx_intr_mask;
 
 	struct macb_pm_data pm_data;
diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 27824e468888..c4818216ab70 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -735,12 +735,16 @@ static void macb_mac_disable_tx_lpi(struct phylink_config *config)
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
 }
 
 static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
@@ -750,6 +754,8 @@ static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	struct macb *bp = netdev_priv(netdev);
 	unsigned long flags;
 
+	mutex_lock(&bp->mac_cfg_lock);
+
 	spin_lock_irqsave(&bp->lock, flags);
 	bp->tx_lpi_timer = timer;
 	bp->eee_active = true;
@@ -760,6 +766,8 @@ static int macb_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 	 */
 	mod_delayed_work(system_wq, &bp->tx_lpi_work, msecs_to_jiffies(1000));
 
+	mutex_unlock(&bp->mac_cfg_lock);
+
 	return 0;
 }
 
@@ -772,6 +780,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 	u32 old_ctrl, ctrl;
 	u32 old_ncr, ncr;
 
+	mutex_lock(&bp->mac_cfg_lock);
 	spin_lock_irqsave(&bp->lock, flags);
 
 	old_ctrl = ctrl = macb_or_gem_readl(bp, NCFGR);
@@ -803,6 +812,7 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
 		macb_or_gem_writel(bp, NCR, ncr);
 
 	spin_unlock_irqrestore(&bp->lock, flags);
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
@@ -814,6 +824,8 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	unsigned int q;
 	u32 ctrl;
 
+	mutex_lock(&bp->mac_cfg_lock);
+
 	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC))
 		for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue)
 			queue_writel(queue, IDR,
@@ -824,6 +836,8 @@ static void macb_mac_link_down(struct phylink_config *config, unsigned int mode,
 	macb_writel(bp, NCR, ctrl);
 
 	netif_tx_stop_all_queues(netdev);
+
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 /* Use juggling algorithm to left rotate tx ring and tx skb array */
@@ -932,6 +946,7 @@ static void macb_mac_link_up(struct phylink_config *config,
 	unsigned int q;
 	u32 ctrl;
 
+	mutex_lock(&bp->mac_cfg_lock);
 	spin_lock_irqsave(&bp->lock, flags);
 
 	ctrl = macb_or_gem_readl(bp, NCFGR);
@@ -983,6 +998,8 @@ static void macb_mac_link_up(struct phylink_config *config,
 	macb_writel(bp, NCR, ctrl | MACB_BIT(RE) | MACB_BIT(TE));
 
 	netif_tx_wake_all_queues(netdev);
+
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 static struct phylink_pcs *macb_mac_select_pcs(struct phylink_config *config,
@@ -2064,6 +2081,8 @@ static void macb_hresp_error_task(struct work_struct *work)
 	unsigned int q;
 	u32 ctrl;
 
+	mutex_lock(&bp->mac_cfg_lock);
+
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
 		queue_writel(queue, IDR, bp->rx_intr_mask |
 					 MACB_TX_INT_FLAGS |
@@ -2093,6 +2112,8 @@ static void macb_hresp_error_task(struct work_struct *work)
 
 	netif_carrier_on(netdev);
 	netif_tx_start_all_queues(netdev);
+
+	mutex_unlock(&bp->mac_cfg_lock);
 }
 
 static void macb_wol_interrupt(struct macb_queue *queue, u32 status)
@@ -2199,8 +2220,10 @@ static irqreturn_t macb_interrupt(int irq, void *dev_id)
 	}
 
 	while (status) {
-		/* close possible race with dev_close */
-		if (unlikely(!netif_running(netdev))) {
+		/* close possible race with dev_close, and with context-swap
+		 * teardown
+		 */
+		if (unlikely(!netif_running(netdev) || bp->ctx_swap)) {
 			queue_writel(queue, IDR, -1);
 			macb_queue_isr_clear(bp, queue, -1);
 			break;
@@ -3098,6 +3121,126 @@ static void macb_configure_dma(struct macb *bp)
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
+	/* We cannot mask IRQs because they'll get re-armed by BH. So instead we
+	 * signal to IRQ handler it shouldn't drive BH features and should
+	 * self-disarm.
+	 */
+	spin_lock_irqsave(&bp->lock, flags);
+	bp->ctx_swap = true;
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	/* Drain BH features. HW is still active and usable at this point but
+	 * IRQs are being ignored.
+	 */
+
+	cancel_work_sync(&bp->hresp_err_bh_work);
+
+	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
+		/* Must be done before NAPI is disabled. */
+		cancel_work_sync(&queue->tx_error_task);
+
+		napi_disable(&queue->napi_rx);
+		napi_disable(&queue->napi_tx);
+	}
+
+	/* Must be done after napi_tx is disabled. */
+	cancel_delayed_work_sync(&bp->tx_lpi_work);
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
+	spin_lock_irqsave(&bp->lock, flags);
+
+	/* Whether it fails or not we'll disable TE/RE next.
+	 * We were just trying to be nice.
+	 */
+	macb_halt_tx(bp);
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
+	bp->ctx = new_ctx;
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
+	bp->ctx_swap = false;
+
+	macb_configure_dma(bp);
+
+	if (netif_carrier_ok(bp->netdev)) {
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
+	netif_tx_start_all_queues(bp->netdev);
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
@@ -3821,9 +3964,10 @@ static int macb_set_ringparam(struct net_device *netdev,
 			      struct kernel_ethtool_ringparam *kernel_ring,
 			      struct netlink_ext_ack *extack)
 {
+	unsigned int new_rx_size, new_tx_size;
 	struct macb *bp = netdev_priv(netdev);
-	u32 new_rx_size, new_tx_size;
-	unsigned int reset = 0;
+	bool running = netif_running(netdev);
+	struct macb_context *new_ctx;
 
 	if ((ring->rx_mini_pending) || (ring->rx_jumbo_pending))
 		return -EINVAL;
@@ -3842,16 +3986,24 @@ static int macb_set_ringparam(struct net_device *netdev,
 		return 0;
 	}
 
-	if (netif_running(bp->netdev)) {
-		reset = 1;
-		macb_close(bp->netdev);
+	if (running) {
+		/* Context swapping is not supported for AT91. */
+		if (bp->caps & MACB_CAPS_MACB_IS_EMAC)
+			return -EBUSY;
+
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
@@ -6029,6 +6181,7 @@ static int macb_probe(struct platform_device *pdev)
 	}
 	spin_lock_init(&bp->lock);
 	spin_lock_init(&bp->stats_lock);
+	mutex_init(&bp->mac_cfg_lock);
 
 	/* setup capabilities */
 	macb_configure_caps(bp, macb_config);

-- 
2.55.0

