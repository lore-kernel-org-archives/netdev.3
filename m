Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A930C414DF6;
	Mon,  5 Oct 2026 22:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239117; cv=none; b=cexRCCXwczgnw8d71Cf/J5nh3NpNYJ309yrqBko3fBxC0GaIHUMNJbTMxBobTbnUOEGUwlbwyM2sGCGY2uO9xFmjiNAuD1g9A6vOdrBE0yXIiUE2+Pj8NcRUaq+yV85ADZu1etJDRldt30vfUB5h5NN5KpIThBungopk6ZGIpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239117; c=relaxed/simple;
	bh=pWTwg/NIqFMc5abGZwSBan8v05wPSg09Nr3efoeGDlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDZj/qUdqyz3sUhrx3cERlp2m5614jjt+SgL3eGIYuQTbGyMs+k09KF+QxTk7M2rURTxwAmkYB55ydyRaK5JuGqtfktHgHPDS08TCbm6v6V3sAZ5YO8+dsFAiTLtQ6ZBef/N/DJ9bNFpJU+PvWl0vKUZn/h06AU/05ogUBTV2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jUMCcuIP; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="jUMCcuIP"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C14E3A08BF;
	Tue,  6 Oct 2026 00:25:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791239105; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Tdpef4RHiO0OBvNFOzczeSXEiJeqSSt/EtRsP2DgY2I=;
	b=jUMCcuIPGaXmCNDaTnLCrYHPjqP/Dn4nT0i1TPVSp+SIEukWDpWdvaSIF8qqsfRDIiNa2h
	8L6CKv34zyFlTOm0CwiWW2K9y026uKZ+kOb4jk0cIDUnp1qhW7GVHTJKcfGnS+5cOPoKK2
	sEA+RlP5bcN0nwTL2BaIcYUPwCiAVRNeF9sLSZOnKFdB51UFiRzzKl0VBsqznftHNjIvLb
	uRcPCCEz+S634X/piopJd3fCqSSz4AlAznddNYDYiPB8vrjZ53CCk62jyLU+kQCYgOdwfl
	gSpm4Uj2TCB79Gmd2Cky9YS/rGn29w2i1ryX47+LkftwNMzfPUwLQbsJeoM2tA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 00:24:44 +0200
Subject: [PATCH net-next v2 5/7] net: bcmgenet: allow the MTU to be changed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-genet-mtu-nn-v2-v2-5-c4be21151912@tipi-net.de>
References: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
In-Reply-To: <20261006-nb-genet-mtu-nn-v2-v2-0-c4be21151912@tipi-net.de>
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
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 87 +++++++++++++++++++++++++-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h | 11 +++-
 2 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 75d1006a35c5..3e2ebd9a2cc5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -79,6 +79,12 @@
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
@@ -2667,7 +2673,7 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 {
 	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);
 
 	/* GENET v1 maps other registers at these offsets */
 	if (GENET_IS_V1(priv))
@@ -2801,7 +2807,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 
 	/* Set flow period for ring != 0 */
 	if (index)
-		flow_period_val = ENET_MAX_FRAME_LEN << 16;
+		flow_period_val = ENET_MAX_FRAME_LEN(priv->dev->mtu) << 16;
 
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_PROD_INDEX);
 	bcmgenet_tdma_ring_writel(priv, index, 0, TDMA_CONS_INDEX);
@@ -3494,6 +3500,7 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_netif_start(dev, true);
 
+	priv->datapath_up = true;
 	netif_tx_start_all_queues(dev);
 
 	return 0;
@@ -3552,7 +3559,11 @@ static int bcmgenet_close(struct net_device *dev)
 
 	netif_dbg(priv, ifdown, dev, "bcmgenet_close\n");
 
-	bcmgenet_netif_stop(dev, false);
+	/* A failed MTU change can have torn the datapath down already */
+	if (priv->datapath_up) {
+		bcmgenet_netif_stop(dev, false);
+		priv->datapath_up = false;
+	}
 
 	/* Really kill the PHY state machine and disconnect from it */
 	phy_disconnect(dev->phydev);
@@ -3800,6 +3811,71 @@ static int bcmgenet_change_carrier(struct net_device *dev, bool new_carrier)
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
@@ -3811,6 +3887,7 @@ static const struct net_device_ops bcmgenet_netdev_ops = {
 	.ndo_set_features	= bcmgenet_set_features,
 	.ndo_get_stats64	= bcmgenet_get_stats64,
 	.ndo_change_carrier	= bcmgenet_change_carrier,
+	.ndo_change_mtu		= bcmgenet_change_mtu,
 };
 
 /* GENET hardware parameters/characteristics */
@@ -4164,7 +4241,11 @@ static int bcmgenet_probe(struct platform_device *pdev)
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
index 6444bac168c3..75cfbccfd4ce 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -31,9 +31,13 @@
 #define ENET_BRCM_TAG_LEN	6
 #define ENET_PAD		8
 
-/* Longest frame the MAC must accept for the default MTU */
-#define ENET_MAX_FRAME_LEN	(ETH_DATA_LEN + ETH_HLEN + VLAN_HLEN + \
-				 ENET_BRCM_TAG_LEN + ETH_FCS_LEN + ENET_PAD)
+/* Longest frame the MAC must accept for a given MTU. ENET_PAD is slack the
+ * driver has always carried, it rounded the default up to 1536 from 1528.
+ */
+#define ENET_FRAME_OVERHEAD	(ETH_HLEN + VLAN_HLEN + ENET_BRCM_TAG_LEN + \
+				 ETH_FCS_LEN + ENET_PAD)
+#define ENET_MAX_FRAME_LEN(mtu)	((mtu) + ENET_FRAME_OVERHEAD)
+
 #define DMA_MAX_BURST_LENGTH    0x10
 
 /* misc. configuration */
@@ -627,6 +631,7 @@ struct bcmgenet_priv {
 	unsigned autoneg_pause:1;
 	unsigned tx_pause:1;
 	unsigned rx_pause:1;
+	unsigned datapath_up:1;
 
 	/* MDIO bus variables */
 	wait_queue_head_t wq;

-- 
2.53.0

