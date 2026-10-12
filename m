Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55181474245;
	Mon, 12 Oct 2026 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795665; cv=none; b=Zh4f7Xtzin4k804VytScZX9YMQLrpleaqaq7h2R2+b3dWiybv702SXldMJk0MlWXqPWnQjvcW4D2pdXbwlVGMyUg38QER/5O31CkaAbPRiVsKG1LfIEZcP4oubMgAn+zfCn2lGQBdEdIxRp4TmhN61tcIf3OS8IImjcLpuIYtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795665; c=relaxed/simple;
	bh=o9sa/cFYD1NRv8ZMaDOCvzx1TS6BMDdfSeOwr4e92Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3pJ/OlD859nDhICujGXd+/6BUtBA9ov6cFyy2zMJTF7UfnMV3BaEvp3I758UAywhWjFLgBzVNlkU6VBzsRoC21e9wyLgfRMkvMn9kEOsfH/tA1ItldZ1ZLlYVWIGvOGysQxoBOgGi1uS0/SwoJ/QqrUHVxvg/4XzAkMJ9/ic3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4BKjhOH8; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4BKjhOH8"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF79DA1588;
	Mon, 12 Oct 2026 11:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791795657; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YTz8GmVluprXANzTquyGzE0K0aZBQa7dbBWwpxsjhUk=;
	b=4BKjhOH8ou4NKXaRkK5+nfmF0LS7x0BjMvH1hlKUCTmo8Krdv0kNJhuu39b+XnCq9TdzME
	gHo2NhuVdoZRTifk6tYw4053OQ/8IrS8WysQPeKFzqT4v+wQxrC3rCaqFWOAYIVWhkivvC
	AQY0rMXEGI6AcIwRLPhT3war6rW8qAiaHL30sD7Yu4KnL1FM9tVJoKx/FZj6ii5YjKgD8x
	1fPIX4ZpzfbsaCl/96jFKxcVOQK+xjZoaxTZV/ovb5Kd9ZecDZVh/Tgz9IEX+0k58sSA1Z
	SqUTkM3sjuaQ14c9Hwy0AUctNAz6Bn6cgw/pxqWfUvBkA0eKObvKxwgXSZlWrg==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 12 Oct 2026 11:00:43 +0200
Subject: [PATCH net-next v4 7/8] net: bcmgenet: allow the MTU to be changed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nb-genet-mtu-nn-v2-v4-7-2e2e3bfaf8cc@tipi-net.de>
References: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
In-Reply-To: <20261012-nb-genet-mtu-nn-v2-v4-0-2e2e3bfaf8cc@tipi-net.de>
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
 Nicolai Buchwitz <nb@tipi-net.de>, Florian Fainelli <f.fainelli@gmail.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The driver never sets dev->max_mtu, so the MTU is stuck at ETH_DATA_LEN.

One descriptor reaches as far as the packet ready threshold, so derive the
maximum from it. The threshold registers are 8 bit in units of 16 bytes and
want a multiple of the 256 byte burst size. A descriptor is one page and
also holds skb_shared_info behind the frame. On 4K pages the page is the
tighter limit and leaves 3564 bytes. That includes room for a VLAN tag so a
VLAN interface can run at the parent MTU. The MAC accepts a little more
than one descriptor holds, so a double tagged frame at that maximum is
dropped as fragmented until a later patch reassembles those.

Resize the buffers and rewrite the registers in place. The PHY keeps
running and the link stays up. Two MTUs at or below ETH_DATA_LEN derive the
same values, so a change between them skips the restart.

A failed allocation retries at the previous size. If that fails too, take
the interface down. Running on rings that were never allocated is worse.

Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Link: https://github.com/raspberrypi/linux/issues/5561
Tested-by: Pierre-Marin Leclercq <pierremarinleclercq88@gmail.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 97 +++++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  1 +
 2 files changed, 96 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index e00661b2414b..f158d6bc314b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -84,6 +84,12 @@
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
@@ -3179,8 +3185,12 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
 	/* Initialize Rx priority queues */
 	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
 		ret = bcmgenet_init_rx_ring(priv, i, end - start, start, end);
-		if (ret)
+		if (ret) {
+			/* Only the rings before this one hold a NAPI */
+			while (i--)
+				netif_napi_del(&priv->rx_rings[i].napi);
 			return ret;
+		}
 
 		start = end;
 		end += priv->hw_params->rx_bds_per_q;
@@ -3564,6 +3574,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_netif_start(dev, true);
 
+	priv->datapath_up = true;
 	netif_tx_start_all_queues(dev);
 
 	return 0;
@@ -3622,7 +3633,11 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev, false);
+	/* A failed MTU change can have torn the datapath down already */
+	if (priv->datapath_up) {
+		bcmgenet_netif_stop(dev, false);
+		priv->datapath_up = false;
+	}
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -3870,6 +3885,76 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
 	return 0;
 }
 
+static int bcmgenet_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct bcmgenet_priv *priv = netdev_priv(dev);
+	unsigned int old_mtu = dev->mtu;
+	int ret;
+
+	/* Every MTU dependent value is floored at ETH_DATA_LEN, so a change
+	 * below it reprograms nothing and must not cost queued frames.
+	 */
+	if (!netif_running(dev) ||
+	    max_t(unsigned int, old_mtu, ETH_DATA_LEN) ==
+	    max_t(unsigned int, new_mtu, ETH_DATA_LEN)) {
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
+	/* A link event latched while the interrupts were off is gone. Internal
+	 * PHYs on GENET v1-v4 are not polled, so resync the state machine.
+	 */
+	phy_mac_interrupt(dev->phydev);
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
@@ -3881,6 +3966,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4234,7 +4320,11 @@ static int bcmgenet_probe(struct platform_device *pdev)
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
@@ -4418,6 +4508,7 @@ static int bcmgenet_resume(struct device *d)
 		bcmgenet_rdma_disable(priv);
 		bcmgenet_intr_disable(priv);
 		bcmgenet_fini_dma(priv);
+		priv->datapath_up = false;
 		enable_irq(priv->irq1);
 	}
 
@@ -4449,6 +4540,7 @@ static int bcmgenet_resume(struct device *d)
 
 	bcmgenet_netif_start(dev, true);
 
+	priv->datapath_up = true;
 	netif_device_attach(dev);
 
 	return 0;
@@ -4510,6 +4602,7 @@ static int bcmgenet_suspend(struct device *d)
 	} else {
 		/* Teardown the interface */
 		bcmgenet_netif_stop(dev, true);
+		priv->datapath_up = false;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 7703e1fb73b6..13c3eb97d84b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -636,6 +636,7 @@ struct bcmgenet_priv {
 	unsigned autoneg_pause:1;
 	unsigned tx_pause:1;
 	unsigned rx_pause:1;
+	unsigned datapath_up:1;
 
 	/* MDIO bus variables */
 	wait_queue_head_t wq;

-- 
2.53.0

