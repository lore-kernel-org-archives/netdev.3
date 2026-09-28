Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59552494806
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790585473; cv=none; b=nvcqEp8ShHpfA7ReExUifeUf8u8OGkwcwpWV6PfM9aZf3V0hDLsA285f9ISidFjvs03wsEhdI+LG5xf9UgsfoWa5X9CZYJBwhx6XKF/Il9kUa8rd/lSf2LF+QTHE7fI8exibiMt7V9c3R4+eMcBo7DzdPmQpGuneYh1l8gzqXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790585473; c=relaxed/simple;
	bh=7S0ErTvBE+Nu9MmbX8ByoTZWQVYJD51ForgW16I7OQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kwzy987TXLzgzqBfyEbDRHmTfks+5/xdq/07GDZLbthAJEouEc/N/qp7ebgD5jh3uPkkQcb2CK++mKAIPakGsvL3RqIwmAk9o3cdqjPOGPTN1w4okyL6if0eA9Rr3lc4T1MreerJIhqPhitSg63BwGbssQQ8E+1Uuj4yzuhsaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jC4+d6x3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jC4+d6x3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8457A1F000FF;
	Mon, 28 Sep 2026 08:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790585471;
	bh=EI/OizyyfCiFhHDd0gKeoOD0qPvECqvUe4JFU1AEBdM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jC4+d6x3rV4Az05LZhxfRnQ65sjPLpFINvP80n15vioUNpSwWrIumSSSWOGVrzBhL
	 7t7QR5eunqojz8TvOeQuo7H+i35nsPJWFdgCP9/gpczSh0SpathlTUIFwkwl8hKkam
	 G4eED+jf1eQ+KBvH2IYwBLECoIV5uCa/A7rHue9IUySsyqbkyfNBHhiKHa5Czy4uYH
	 TQFArJ4BWEqy4Qz4xeyTkZYKrV8P+60ku65vX+N6EUpzoz5mKnaZoptOXvIUMKZHsm
	 irCiTOK3GwR5uGG/SQN+KMHgRKsrJkTLRy8r3jCDop6FAXprGrEbo9FoJi28WKgsaf
	 Bzks80Xz1LmWw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 28 Sep 2026 10:50:37 +0200
Subject: [PATCH net-next v2 11/11] net: ethernet: cortina: Use guard
 helpers for locking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-gemini-ethernet-fixes-3-v2-11-758a795d7a78@kernel.org>
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

Use cleanup guard helpers to scope the driver's spinlocks
automatically.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 144 +++++++++++++---------------------
 1 file changed, 53 insertions(+), 91 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 910de9925949..4fdd7478601f 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/cache.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/reset.h>
 #include <linux/clk.h>
@@ -240,46 +241,37 @@ static void gmac_update_config0_reg(struct net_device *netdev,
 				    u32 val, u32 vmask)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&port->config_lock, flags);
+	guard(spinlock_irqsave)(&port->config_lock);
 
 	reg = readl(port->gmac_base + GMAC_CONFIG0);
 	reg = (reg & ~vmask) | val;
 	writel(reg, port->gmac_base + GMAC_CONFIG0);
-
-	spin_unlock_irqrestore(&port->config_lock, flags);
 }
 
 static void gmac_enable_tx_rx(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&port->config_lock, flags);
+	guard(spinlock_irqsave)(&port->config_lock);
 
 	reg = readl(port->gmac_base + GMAC_CONFIG0);
 	reg &= ~CONFIG0_TX_RX_DISABLE;
 	writel(reg, port->gmac_base + GMAC_CONFIG0);
-
-	spin_unlock_irqrestore(&port->config_lock, flags);
 }
 
 static void gmac_disable_tx_rx(struct net_device *netdev)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
-	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->config_lock, flags);
-
-	val = readl(port->gmac_base + GMAC_CONFIG0);
-	val |= CONFIG0_TX_RX_DISABLE;
-	writel(val, port->gmac_base + GMAC_CONFIG0);
-
-	spin_unlock_irqrestore(&port->config_lock, flags);
+	scoped_guard(spinlock_irqsave, &port->config_lock) {
+		val = readl(port->gmac_base + GMAC_CONFIG0);
+		val |= CONFIG0_TX_RX_DISABLE;
+		writel(val, port->gmac_base + GMAC_CONFIG0);
+	}
 
 	mdelay(10);	/* let GMAC consume packet */
 }
@@ -287,10 +279,9 @@ static void gmac_disable_tx_rx(struct net_device *netdev)
 static void gmac_set_flow_control(struct net_device *netdev, bool tx, bool rx)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
-	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->config_lock, flags);
+	guard(spinlock_irqsave)(&port->config_lock);
 
 	val = readl(port->gmac_base + GMAC_CONFIG0);
 	val &= ~CONFIG0_FLOW_CTL;
@@ -299,8 +290,6 @@ static void gmac_set_flow_control(struct net_device *netdev, bool tx, bool rx)
 	if (rx)
 		val |= CONFIG0_FLOW_RX;
 	writel(val, port->gmac_base + GMAC_CONFIG0);
-
-	spin_unlock_irqrestore(&port->config_lock, flags);
 }
 
 static void gmac_adjust_link(struct net_device *netdev)
@@ -782,7 +771,6 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	unsigned int frag_len = 1 << geth->freeq_frag_order;
 	struct gmac_queue_page *gpage;
 	unsigned long index;
-	unsigned long flags;
 	dma_addr_t page_mapping;
 	unsigned int slot;
 	struct page *page;
@@ -790,10 +778,11 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 
 	index = geth_freeq_mapping_index(geth, mapping);
 
-	spin_lock_irqsave(&geth->freeq_lock, flags);
+	guard(spinlock_irqsave)(&geth->freeq_lock);
+
 	gpage = xa_load(&geth->freeq_mappings, index);
 	if (!gpage || !gpage->page || !gpage->fragments)
-		goto err_unlock;
+		return NULL;
 
 	page = gpage->page;
 	page_mapping = gpage->mapping;
@@ -801,7 +790,7 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 		mapping - page_mapping <= PAGE_SIZE - frag_len &&
 		!((mapping - page_mapping) & (frag_len - 1));
 	if (!valid)
-		goto err_unlock;
+		return NULL;
 
 	dma_sync_single_range_for_cpu(geth->dev, page_mapping,
 				      mapping - page_mapping, frag_len,
@@ -819,12 +808,7 @@ static struct page *geth_freeq_claim(struct gemini_ethernet *geth,
 	}
 
 	*page_offs = mapping - page_mapping;
-	spin_unlock_irqrestore(&geth->freeq_lock, flags);
 	return page;
-
-err_unlock:
-	spin_unlock_irqrestore(&geth->freeq_lock, flags);
-	return NULL;
 }
 
 static void gmac_cleanup_rxq(struct net_device *netdev)
@@ -990,7 +974,6 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 	unsigned int fpp_order = PAGE_SHIFT - geth->freeq_frag_order;
 	unsigned int count = 0;
 	unsigned int pn, epn;
-	unsigned long flags;
 	union dma_rwptr rw;
 	unsigned int m_pn;
 
@@ -1007,28 +990,26 @@ static unsigned int geth_fill_freeq(struct gemini_ethernet *geth)
 		if (ret)
 			break;
 
-		spin_lock_irqsave(&geth->freeq_lock, flags);
-
-		rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
-		pn = rw.bits.wptr >> fpp_order;
-		epn = (rw.bits.rptr >> fpp_order) - 1;
-		epn &= m_pn;
-		if (pn == epn) {
-			ret = -ENOSPC;
-		} else {
-			ret = geth_freeq_add_page(geth, pn, page,
-						  page_mapping);
-			if (!ret) {
-				count += 1 << fpp_order;
-				pn++;
-				pn &= m_pn;
-				writew(pn << fpp_order,
-				       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+		scoped_guard(spinlock_irqsave, &geth->freeq_lock) {
+			rw.bits32 = readl(geth->base + GLOBAL_SWFQ_RWPTR_REG);
+			pn = rw.bits.wptr >> fpp_order;
+			epn = (rw.bits.rptr >> fpp_order) - 1;
+			epn &= m_pn;
+			if (pn == epn) {
+				ret = -ENOSPC;
+			} else {
+				ret = geth_freeq_add_page(geth, pn, page,
+							  page_mapping);
+				if (!ret) {
+					count += 1 << fpp_order;
+					pn++;
+					pn &= m_pn;
+					writew(pn << fpp_order,
+					       geth->base + GLOBAL_SWFQ_RWPTR_REG + 2);
+				}
 			}
 		}
 
-		spin_unlock_irqrestore(&geth->freeq_lock, flags);
-
 		if (ret) {
 			dma_unmap_single(geth->dev, page_mapping, PAGE_SIZE,
 					 DMA_FROM_DEVICE);
@@ -1178,17 +1159,16 @@ static void geth_cleanup_freeq(struct gemini_ethernet *geth)
 
 static void geth_set_freeq_irq(struct gemini_ethernet *geth, bool enable)
 {
-	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
+	guard(spinlock_irqsave)(&geth->irq_lock);
+
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	if (enable)
 		val |= SWFQ_EMPTY_INT_BIT;
 	else
 		val &= ~SWFQ_EMPTY_INT_BIT;
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 /**
@@ -1267,12 +1247,11 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
-	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d\n", __func__, netdev->dev_id);
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
+	guard(spinlock_irqsave)(&geth->irq_lock);
 
 	mask = GMAC0_IRQ0_TXQ0_INTS << (6 * netdev->dev_id + txq);
 
@@ -1282,8 +1261,6 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
 	val = en ? val | mask : val & ~mask;
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
-
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static void gmac_tx_irq(struct net_device *netdev, unsigned int txq_num)
@@ -1516,12 +1493,11 @@ static void gmac_enable_irq(struct net_device *netdev, int enable)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
-	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d %s\n", __func__,
 		   netdev->dev_id, enable ? "enable" : "disable");
-	spin_lock_irqsave(&geth->irq_lock, flags);
+	guard(spinlock_irqsave)(&geth->irq_lock);
 
 	mask = GMAC0_IRQ0_2 << (netdev->dev_id * 2);
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
@@ -1537,27 +1513,22 @@ static void gmac_enable_irq(struct net_device *netdev, int enable)
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	val = enable ? (val | mask) : (val & ~mask);
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static void gmac_enable_rx_irq(struct net_device *netdev, int enable)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
-	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d %s\n", __func__, netdev->dev_id,
 		   enable ? "enable" : "disable");
-	spin_lock_irqsave(&geth->irq_lock, flags);
+	guard(spinlock_irqsave)(&geth->irq_lock);
 	mask = DEFAULT_Q0_INT_BIT << netdev->dev_id;
 
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_1_REG);
 	val = enable ? (val | mask) : (val & ~mask);
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_1_REG);
-
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
@@ -1622,17 +1593,16 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 	union gmac_rxdesc_3 word3;
 	struct page *page = NULL;
 	unsigned int page_offs;
-	unsigned long flags;
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
-	rw.bits32 = readl(ptr_reg);
-	/* Reset interrupt as all packages until here are taken into account */
-	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
-	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
+	scoped_guard(spinlock_irqsave, &geth->irq_lock) {
+		rw.bits32 = readl(ptr_reg);
+		/* Reset interrupt as all packages until here are taken into account */
+		writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
+		       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
+	}
 
 	r = rw.bits.rptr;
 	w = rw.bits.wptr;
@@ -1871,9 +1841,8 @@ static void gmac_update_hw_stats(struct net_device *netdev)
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned int rx_discards, rx_mcast, rx_bcast;
 	struct gemini_ethernet *geth = port->geth;
-	unsigned long flags;
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
+	guard(spinlock_irqsave)(&geth->irq_lock);
 	u64_stats_update_begin(&port->ir_stats_syncp);
 
 	rx_discards = readl(port->gmac_base + GMAC_IN_DISCARDS);
@@ -1894,7 +1863,6 @@ static void gmac_update_hw_stats(struct net_device *netdev)
 	       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
 
 	u64_stats_update_end(&port->ir_stats_syncp);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 /**
@@ -1980,13 +1948,14 @@ static irqreturn_t gmac_irq(int irq, void *data)
 		gmac_update_hw_stats(netdev);
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
-		spin_lock(&geth->irq_lock);
-		writel(GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8),
-		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
-		u64_stats_update_begin(&port->ir_stats_syncp);
-		++port->stats.rx_fifo_errors;
-		u64_stats_update_end(&port->ir_stats_syncp);
-		spin_unlock(&geth->irq_lock);
+		scoped_guard(spinlock, &geth->irq_lock) {
+			writel(GMAC0_RX_OVERRUN_INT_BIT <<
+			       (netdev->dev_id * 8),
+			       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
+			u64_stats_update_begin(&port->ir_stats_syncp);
+			++port->stats.rx_fifo_errors;
+			u64_stats_update_end(&port->ir_stats_syncp);
+		}
 	}
 
 	return orr ? IRQ_HANDLED : IRQ_NONE;
@@ -2251,16 +2220,14 @@ static int gmac_set_features(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	int enable = features & NETIF_F_RXCSUM;
-	unsigned long flags;
 	u32 reg;
 
-	spin_lock_irqsave(&port->config_lock, flags);
+	guard(spinlock_irqsave)(&port->config_lock);
 
 	reg = readl(port->gmac_base + GMAC_CONFIG0);
 	reg = enable ? reg | CONFIG0_RX_CHKSUM : reg & ~CONFIG0_RX_CHKSUM;
 	writel(reg, port->gmac_base + GMAC_CONFIG0);
 
-	spin_unlock_irqrestore(&port->config_lock, flags);
 	return 0;
 }
 
@@ -2513,20 +2480,17 @@ static irqreturn_t gemini_port_irq_thread(int irq, void *data)
 	unsigned long irqmask = SWFQ_EMPTY_INT_BIT;
 	struct gemini_ethernet_port *port = data;
 	struct gemini_ethernet *geth;
-	unsigned long flags;
 
 	geth = port->geth;
 	/* The queue is half empty so refill it */
 	geth_fill_freeq(geth);
 
-	spin_lock_irqsave(&geth->irq_lock, flags);
+	guard(spinlock_irqsave)(&geth->irq_lock);
 	/* ACK queue interrupt */
 	writel(irqmask, geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
 	/* Enable queue interrupt again */
 	irqmask |= readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
 	writel(irqmask, geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
-	spin_unlock_irqrestore(&geth->irq_lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -2538,7 +2502,7 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 	u32 val, en;
 
 	geth = port->geth;
-	spin_lock(&geth->irq_lock);
+	guard(spinlock)(&geth->irq_lock);
 
 	val = readl(geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
 	en = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_4_REG);
@@ -2554,8 +2518,6 @@ static irqreturn_t gemini_port_irq(int irq, void *data)
 		ret = IRQ_WAKE_THREAD;
 	}
 
-	spin_unlock(&geth->irq_lock);
-
 	return ret;
 }
 

-- 
2.55.0

