Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0F41F378;
	Mon,  5 Oct 2026 22:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239110; cv=none; b=k7c2PbKd7u6uQjUcvHEn2A4PyQQY14SxUBXkVDMesWRL94h2cmeB52mvPakI0bHHDz5W8NwnP4Aiz8fGQSIeE4pXxuOSYAeNkwA1GoF2OnUEgdnKBZdSIkOJRDYKZrJ0niI/TnCerYsnufJZFBluo0ARn+x577Kz8VHaiayJ1oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239110; c=relaxed/simple;
	bh=tb4yxm3sqGZDVgkT6HONVZNyPVuQS0/GRUYSrCIKKYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8R0YCw8W6BgOh7+xMsnsuakyuAiY6u6YUAq3OS+d3o0T94bY7YOzeo50iHz5Qnu5ld3S7MQWHI1BHIrqpkFu/wrR+HU9eQ+UK8UtsWgb2a6HYtx7nMZXxfV/0CkqRneSJPewogpX4/ULFn1SqLjkNMxRR4nCuvQqRh7Qe/u3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=f1c40MqF; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="f1c40MqF"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1CBB4A0E2B;
	Tue,  6 Oct 2026 00:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791239104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EXRR7Ip0yBdlPOTEP9/WOCHPTOncGb7iQijWvHSfEOs=;
	b=f1c40MqFU5tn+lSNFuWodnt3EHaH291jYrE6kjMNFWnErqKWUUueLWRfU93Imy48q34Kk2
	eN4Ieo8APiOPi+Nkor5RJAlL9zrQjCMwqJ2KTkgjE/tPg7on1RRfLdVvykfSLUmw7+I2fO
	4f+lYT4BwDRt6VLxDLGtdjtdSc1BCxvRxWWNze0Zaep4BuM9iGTORBy08KRDgSzQq3vHO2
	ni0p4ZFMMvlOrvXr1z8MRktcBIcZ9dv/IbHo1DcQjNJNup9yWIrsBsA6v8yyR7tR4pAUDT
	iS3nVdx1y0Cbu1K2EakK/aWi8p2NGSRWZE7wJBsnpvDrQ5jzK46STTiJ1AsJSQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 06 Oct 2026 00:24:43 +0200
Subject: [PATCH net-next v2 4/7] net: bcmgenet: derive the receive buffer
 length from the MTU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nb-genet-mtu-nn-v2-v2-4-c4be21151912@tipi-net.de>
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

The receive buffer length is a fixed 2048 bytes. The packet ready
thresholds keep whatever value the reset left. Neither follows the MTU.

Compute the receive threshold from the MTU and program it into RBUF. The
buffer length follows from it, with the status block on top. The MTU is
still fixed at ETH_DATA_LEN, so the threshold comes out at the reset
default and the buffer only grows by the status block the hardware already
wrote.

Program the transmit threshold at its maximum as well. It sets how much of
a frame the MAC holds before it starts sending, and holding less buys
nothing. A later patch lowers it for the few MTUs that need the room.

Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 86 +++++++++++++++++++++-----
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |  4 ++
 2 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 641d918577d4..75d1006a35c5 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -48,18 +48,36 @@
 #define GENET_Q0_TX_BD_CNT	\
 	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
 
-#define RX_BUF_LENGTH		2048
 #define SKB_ALIGNMENT		32
 
+/* RBUF and TBUF hand a frame to the DMA once the threshold is reached. Both
+ * registers are 8 bit in units of 16 bytes and want a multiple of the 256
+ * byte burst size, so 0xf0 is the largest usable value.
+ */
+#define ENET_THLD_UNIT		16
+#define ENET_THLD_BURST		256
+#define ENET_THLD_DEFAULT	0x80
+#define ENET_THLD_MAX		0xf0
+
 /* Page pool RX buffer layout:
  * RSB(64) + pad(2) | frame data | skb_shared_info
  * The HW writes the 64B RSB before every descriptor of a frame. Only the
  * first one also gets the 2B alignment padding.
  */
-#define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
+#define GENET_RBUF_ALIGN	2
+#define GENET_RSB_PAD		(sizeof(struct status_64) + GENET_RBUF_ALIGN)
 
-/* RX buffer plus the skb_shared_info napi_build_skb() places behind it */
-#define GENET_RX_BUF_SIZE	SKB_HEAD_ALIGN(RX_BUF_LENGTH)
+/* A descriptor never spans more than one page, which also holds
+ * skb_shared_info behind the frame, so on 4K pages the page bounds the
+ * threshold before the register does. Larger pages fit several descriptors.
+ */
+#define ENET_SHINFO_LEN		SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
+#define ENET_THLD_PAGE_LEN	round_down(PAGE_SIZE - ENET_SHINFO_LEN - \
+					   sizeof(struct status_64), \
+					   ENET_THLD_BURST)
+#define ENET_THLD_MAX_LEN	min_t(unsigned int, \
+				      ENET_THLD_MAX * ENET_THLD_UNIT, \
+				      ENET_THLD_PAGE_LEN)
 
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
@@ -2253,7 +2271,7 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 			      struct enet_cb *cb)
 {
 	struct bcmgenet_priv *priv = ring->priv;
-	unsigned int size = GENET_RX_BUF_SIZE;
+	unsigned int size = SKB_HEAD_ALIGN(priv->rx_buf_len);
 	unsigned int offset;
 	dma_addr_t mapping;
 	struct page *page;
@@ -2268,7 +2286,7 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 
 	/* page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
 	mapping = page_pool_get_dma_addr(page) + offset;
-	dma_sync_single_for_device(&priv->pdev->dev, mapping, RX_BUF_LENGTH,
+	dma_sync_single_for_device(&priv->pdev->dev, mapping, priv->rx_buf_len,
 				   DMA_FROM_DEVICE);
 
 	cb->rx_page = page;
@@ -2347,10 +2365,10 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		}
 
 		/* Sync the full buffer; the HW may have written anywhere
-		 * up to RX_BUF_LENGTH.
+		 * up to priv->rx_buf_len.
 		 */
 		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, rx_offset,
-					   RX_BUF_LENGTH);
+					   priv->rx_buf_len);
 
 		hard_start = page_address(rx_page) + rx_offset;
 		status = (struct status_64 *)hard_start;
@@ -2372,7 +2390,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 					     : sizeof(struct status_64);
 
 		/* Reject lengths that would underflow the SKB build path. */
-		if (unlikely(len > RX_BUF_LENGTH || len < min_len)) {
+		if (unlikely(len > priv->rx_buf_len || len < min_len)) {
 			netif_err(priv, rx_status, dev,
 				  "invalid packet length %d\n", len);
 			BCMGENET_STATS64_INC(stats, length_errors);
@@ -2623,6 +2641,44 @@ static void bcmgenet_link_intr_enable(struct bcmgenet_priv *priv)
 	bcmgenet_intrl2_0_writel(priv, int0_enable, INTRL2_CPU_MASK_CLEAR);
 }
 
+/* Receive threshold in register units. Covers the alignment bytes and the
+ * frame, but not the status block, which the hardware adds on top.
+ */
+static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
+{
+	unsigned int len = GENET_RBUF_ALIGN + mtu + ETH_HLEN + VLAN_HLEN;
+
+	len = round_up(len, ENET_THLD_BURST) / ENET_THLD_UNIT;
+
+	/* Keep the reset default for the common MTUs */
+	return clamp_t(unsigned int, len, ENET_THLD_DEFAULT,
+		       ENET_THLD_MAX_LEN / ENET_THLD_UNIT);
+}
+
+/* A buffer has to hold everything the threshold lets the hardware deliver */
+static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
+{
+	return sizeof(struct status_64) +
+	       bcmgenet_pkt_rdy_thld(mtu) * ENET_THLD_UNIT;
+}
+
+/* Program the MTU dependent registers. Call with the MAC disabled. */
+static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
+{
+	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
+
+	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
+
+	/* GENET v1 maps other registers at these offsets */
+	if (GENET_IS_V1(priv))
+		return;
+
+	bcmgenet_rbuf_writel(priv, thld, RBUF_PKT_RDY_THLD);
+	bcmgenet_writel(ENET_THLD_MAX,
+			priv->base + priv->hw_params->tbuf_offset +
+			TBUF_PKT_RDY_THLD);
+}
+
 static void init_umac(struct bcmgenet_priv *priv)
 {
 	struct device *kdev = &priv->pdev->dev;
@@ -2639,7 +2695,7 @@ static void init_umac(struct bcmgenet_priv *priv)
 			     UMAC_MIB_CTRL);
 	bcmgenet_umac_writel(priv, 0, UMAC_MIB_CTRL);
 
-	bcmgenet_umac_writel(priv, ENET_MAX_FRAME_LEN, UMAC_MAX_FRAME_LEN);
+	bcmgenet_set_mtu_regs(priv, priv->dev->mtu);
 
 	/* init tx registers, enable TSB */
 	reg = bcmgenet_tbuf_ctrl_get(priv);
@@ -2755,7 +2811,7 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 				  TDMA_FLOW_PERIOD);
 	bcmgenet_tdma_ring_writel(priv, index,
 				  ((size << DMA_RING_SIZE_SHIFT) |
-				   RX_BUF_LENGTH), DMA_RING_BUF_SIZE);
+				   priv->rx_buf_len), DMA_RING_BUF_SIZE);
 
 	/* Set start and end address, read and write pointers */
 	bcmgenet_tdma_ring_writel(priv, index, start_ptr * words_per_bd,
@@ -2774,8 +2830,9 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 					struct bcmgenet_rx_ring *ring)
 {
-	/* Buffers share a page. bcmgenet_rx_refill() syncs each one for the
-	 * device, PP_FLAG_DMA_SYNC_DEV would sync the whole page.
+	/* Buffers may share a page, depending on PAGE_SIZE and the MTU.
+	 * bcmgenet_rx_refill() syncs each one for the device,
+	 * PP_FLAG_DMA_SYNC_DEV would sync the whole page.
 	 */
 	struct page_pool_params pp_params = {
 		.order = 0,
@@ -2838,7 +2895,7 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 	bcmgenet_rdma_ring_writel(priv, index, 0, RDMA_CONS_INDEX);
 	bcmgenet_rdma_ring_writel(priv, index,
 				  ((size << DMA_RING_SIZE_SHIFT) |
-				   RX_BUF_LENGTH), DMA_RING_BUF_SIZE);
+				   priv->rx_buf_len), DMA_RING_BUF_SIZE);
 	bcmgenet_rdma_ring_writel(priv, index,
 				  (DMA_FC_THRESH_LO <<
 				   DMA_XOFF_THRESHOLD_SHIFT) |
@@ -4107,6 +4164,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	/* Mii wait queue */
 	init_waitqueue_head(&priv->wq);
 	bcmgenet_hfb_init(priv);
+	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 501dd1256693..6444bac168c3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -218,6 +218,8 @@ struct bcmgenet_rx_stats64 {
 #define  RBUF_ALIGN_2B			(1 << 1)
 #define  RBUF_BAD_DIS			(1 << 2)
 
+#define RBUF_PKT_RDY_THLD		0x08
+
 #define RBUF_STATUS			0x0C
 #define  RBUF_STATUS_WOL		(1 << 0)
 #define  RBUF_STATUS_MPD_INTR_ACTIVE	(1 << 1)
@@ -248,6 +250,7 @@ struct bcmgenet_rx_stats64 {
 #define TBUF_CTRL			0x00
 #define  TBUF_64B_EN			(1 << 0)
 #define TBUF_BP_MC			0x0C
+#define TBUF_PKT_RDY_THLD		0x10
 #define TBUF_ENERGY_CTRL		0x14
 #define  TBUF_EEE_EN			(1 << 0)
 #define  TBUF_PM_EN			(1 << 1)
@@ -612,6 +615,7 @@ struct bcmgenet_priv {
 	void __iomem *rx_bds;
 	struct enet_cb *rx_cbs;
 	unsigned int num_rx_bds;
+	unsigned int rx_buf_len;
 	struct bcmgenet_rxnfc_rule rxnfc_rules[MAX_NUM_OF_FS_RULES];
 	struct list_head rxnfc_list;
 

-- 
2.53.0

