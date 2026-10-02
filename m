Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441224E2F09;
	Fri,  2 Oct 2026 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953415; cv=none; b=fH9XB4+4ZhOZATxdxTqNEBoBw88fdZCgPjwWx0OsxhbgJlTqFhHsCBlMsjh8KDTKnGj/nc3RY27R5tERSlq90FKQ3egLGE9zXQV8swExFSYq/Pd1OhCfwGr6S8ON4wxkJj+xBoV0x7kN/nwboM1oBcevolFw8/V9MLsMepJtC3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953415; c=relaxed/simple;
	bh=xviz4MzmukKAq9SOXG8gI5q12as1RjdbiiBxoMPv/Ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkaYpgdeEJrmcMAbVnIZLPaOaiwlUtp/VUwS4sX1RJMwaaiPfoLpxCjJn1tt8mfU4qHiNbURXvq4RAtaWYjHc7Ib+JU1fF4o8TxPjGLu01ST8t+z25QykEBDJKXBnDcHQa8UQM4qhpdwgAu/orF0u9GczB6OO836AZgt62LfAYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xy+oeXZq; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xy+oeXZq"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E5854A4B5A;
	Fri,  2 Oct 2026 17:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953411; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=rZhg4NlJRp3qiYzJMFaD7Oo8ikgmw8uxMBdSSVEt9Fo=;
	b=xy+oeXZq97PiaXGVcezfQL0oRh82fux8dCLU6i5WgG3xIpZNmzY4SgLnq8UVEqc7X4PLYZ
	yo1SMKowUs7XJg7dYgeLuvA1i6Gk0MXV5xD0O8TzTUy2Isv4v3X7gDy18+6ROGHwUpw1bI
	/m7Om/2hg+M3cY0S3/vc5aOUwxZDpQ1hy3hQP+uGjGItqBXPZu4qlHvJJ21OOWR8u66DZd
	GSlV/0yvUz9ksKei2cg0jFkTuHD1xsaWQ07lk+eYAy387jjRjL0rB2OIOn3kvTMdIMQ6C1
	tNRefuhvsKN0L/wFwt+p1eSeUjEqcNB/IO5cd6B0qd4dr40AsrQ1pKBTtIpGPw==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Fri, 02 Oct 2026 17:03:23 +0200
Subject: [PATCH net-next 5/7] net: bcmgenet: allow the MTU to be changed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-nb-genet-mtu-nn-v2-v1-5-96dc6d54cbee@tipi-net.de>
References: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
In-Reply-To: <20261002-nb-genet-mtu-nn-v2-v1-0-96dc6d54cbee@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Justin Chen <justin.chen@broadcom.com>, 
 Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The driver never sets dev->max_mtu, so the MTU is stuck at ETH_DATA_LEN.

One descriptor reaches as far as the packet ready threshold, so derive the
maximum from it. The threshold registers are 8 bit in units of 16 bytes and
want a multiple of the 256 byte burst size. A descriptor is one page and
also holds skb_shared_info behind the frame. On 4K pages the page is the
tighter limit and leaves 3564 bytes. That includes room for a VLAN tag so a
VLAN interface can run at the parent MTU.

Resize the buffers and rewrite the registers in place. The PHY keeps
running and the link stays up.

A failed allocation retries at the previous size. If that fails too, take
the interface down. Running on rings that were never allocated is worse.

Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Link: https://github.com/raspberrypi/linux/issues/5561
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 82 +++++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  9 ++-
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index bf889558f6ad..4634b6521ab8 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -77,6 +77,12 @@
 				      ENET_THLD_MAX * ENET_THLD_UNIT, \
 				      ENET_THLD_PAGE_LEN)
 
+/* Largest MTU that fits one descriptor, with room for a VLAN tag so a VLAN
+ * interface can use the parent MTU.
+ */
+#define ENET_MAX_MTU		(ENET_THLD_MAX_LEN - GENET_RBUF_ALIGN - \
+				 ETH_HLEN - VLAN_HLEN)
+
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
 #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))
@@ -2665,7 +2671,7 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 {
 	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);
 
 	/* GENET v1 maps other registers at these offsets */
 	if (GENET_IS_V1(priv))
@@ -2799,7 +2805,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	/* Set flow period for ring != 0 */
 	if (index)
-		flow_period_val = ENET_MAX_FRAME_LEN << 16;
+		flow_period_val = ENET_MAX_FRAME_LEN(priv->dev->mtu) << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
@@ -3491,6 +3497,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_netif_start(dev, true);
 
+	priv->datapath_up = true;
 	netif_tx_start_all_queues(dev);
 
 	return 0;
@@ -3549,7 +3556,11 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev, false);
+	/* A failed MTU change can have torn the datapath down already */
+	if (priv->datapath_up) {
+		bcmgenet_netif_stop(dev, false);
+		priv->datapath_up = false;
+	}
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -3797,6 +3808,66 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
 	return 0;
 }
 
+static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	unsigned int old_mtu = dev->mtu;
+	int ret;
+
+	if (!netif_running(dev)) {
+		WRITE_ONCE(dev->mtu, new_mtu);
+		priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
+		return 0;
+	}
+
+	/* The watchdog trips on an idle queue once the rings are gone */
+	netif_device_detach(dev);
+
+	/* Only the buffers and the MTU registers change, leave the PHY up */
+	bcmgenet_netif_stop(dev, false);
+	priv->datapath_up = false;
+
+	WRITE_ONCE(dev->mtu, new_mtu);
+	priv->rx_buf_len = bcmgenet_rx_buf_len(new_mtu);
+	bcmgenet_set_mtu_regs(priv, new_mtu);
+
+	ret = bcmgenet_init_dma(priv, true);
+	if (ret) {
+		/* Retry the size that was allocated a moment ago */
+		WRITE_ONCE(dev->mtu, old_mtu);
+		priv->rx_buf_len = bcmgenet_rx_buf_len(old_mtu);
+		bcmgenet_set_mtu_regs(priv, old_mtu);
+		if (bcmgenet_init_dma(priv, true)) {
+			/* Nothing left to run on. Take the interface down so
+			 * that close and suspend do not tear it down twice.
+			 */
+			netdev_err(dev, "failed to restore MTU %u, closing\n",
+				   old_mtu);
+			netif_close(dev);
+
+			/* Mark the device present again, __dev_open()
+			 * refuses a detached one. The queues stay stopped
+			 * because the interface is down by now.
+			 */
+			netif_device_attach(dev);
+			return ret;
+		}
+	}
+
+	bcmgenet_hfb_restore(priv);
+	bcmgenet_netif_start(dev, false);
+
+	/* bcmgenet_netif_start() only restores the link interrupt */
+	if (bcmgenet_has_mdio_intr(priv))
+		bcmgenet_intrl2_0_writel(priv, UMAC_IRQ_MDIO_EVENT,
+					 INTRL2_CPU_MASK_CLEAR);
+
+	priv->datapath_up = true;
+	netif_device_attach(dev);
+
+	return ret;
+}
+
 static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_open		= bcmgenet_open,
 	.ndo_stop		= bcmgenet_close,
@@ -3808,6 +3879,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4161,7 +4233,11 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	/* Mii wait queue */
 	init_waitqueue_head(&priv->wq);
 	bcmgenet_hfb_init(priv);
+
+	/* v1 cannot program the thresholds, so it stays at the default MTU */
 	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
+	if (!GENET_IS_V1(priv))
+		dev->max_mtu = ENET_MAX_MTU;
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 6444bac168c3..f535490547cf 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -31,9 +31,11 @@
 #define ENET_BRCM_TAG_LEN	6
 #define ENET_PAD		8
 
-/* Longest frame the MAC must accept for the default MTU */
-#define ENET_MAX_FRAME_LEN	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
-				 ENET_BRCM_TAG_LEN + ETH_FCS_LEN + ENET_PAD)
+/* Longest frame the MAC must accept for a given MTU */
+#define ENET_FRAME_OVERHEAD	(ETH_HLEN + VLAN_HLEN + ENET_BRCM_TAG_LEN + \
+				 ETH_FCS_LEN + ENET_PAD)
+#define ENET_MAX_FRAME_LEN(mtu)	((mtu) + ENET_FRAME_OVERHEAD)
+
 #define DMA_MAX_BURST_LENGTH    0x10
 
 /* misc. configuration */
@@ -627,6 +629,7 @@ struct bcmgenet_priv {
 	unsigned autoneg_pause:1;
 	unsigned tx_pause:1;
 	unsigned rx_pause:1;
+	unsigned datapath_up:1;
 
 	/* MDIO bus variables */
 	wait_queue_head_t wq;

-- 
2.53.0

