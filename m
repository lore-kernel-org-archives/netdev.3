Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.38.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793574835;
	b=HH5ktYU4zrQWsrSyHdDb8rVfGTqAdN0MupSOIwohgvMrW3toIeD0dZNHkCNiXKtCkaTg
	 YdBrhoSIei3CE9UoBJ5MwSc1tVUCaOtDS2jEJRlM4/g+KugT7/uxvqDlou/608yDstn2w
	 thS1ydSVeZMF0ZZB9poo6L8L6Rhkuk8RZWFs/U5p5lmfH2Aysf5h9KgAnTTkXe5bU9mWm
	 EXb91NFZ+I3WR52CsnqoBxjjtZsE3lIN4TzEzd/8WXAJJyub0qo0BzxT8gxOn7bkLOTkO
	 KtW9P0GYZNDt88OPB3qCeE262nKEzHZZqSSUOgywLM2TxhzhjlPrGSdPSNiaEg41nQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574835;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iJcp/DCUBxBPtn0GXnpzjKcyl4m9v/YMGxh95xYGMw0=;
	b=OP5yfGk/ZCYo70FnIkU6OikzXHrPJ7d3FAXYGcFJJHZqG7ba2o9Z4Oh27iDkj8NJhLJ7
	 I71OW/0+hW7zIF2jk8hJi7Xxi5uUS/pFndEQjNRsF4sbNS8TXuXIfHIwzwOrDfBy3AEzP
	 SG/9ck8OgzYhCqARQquLlrIwzlDLaPyhjEB1WQjREAQpgokj2Cl6wJQJFuCFwXjAkXTSP
	 c6NoGaR45xKQqe9o5vj01BWNaDqIXAwiNG3P5du37gZ1IaACKHbj7HL85lUa83I9Jhf2l
	 z3igUtVGYW27eI/dB+QFJXMmsYmZpN7iyPwdtygi4ZxZY3wdpnY1DKP6C4cznn0b8ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=loljews.com;
	spf=pass smtp.mailfrom=loljews.com;
	dkim=pass header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=RIRyeqff;
	arc=none smtp.remote-ip=54.38.221.178
Received: from mnc015mcc432.ss7-reroute.local (unknown [54.38.221.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013D6606A326;
	Sun,  1 Nov 2026 23:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 013D6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=loljews.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loljews.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=loljews.com header.i=@loljews.com header.a=rsa-sha256 header.s=mail header.b=RIRyeqff
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loljews.com; s=mail;
	t=1793574824; bh=iJcp/DCUBxBPtn0GXnpzjKcyl4m9v/YMGxh95xYGMw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIRyeqffFsSwsrZt1AhHOSfFBjzqWLDR9aXqAt1an/6JGD+9sR0EtDfmcTztdsCh0
	 /imuX3tTdQcESo+yK0huCFLAi9jcida3HvpBco+NDiaCIsut5/6yrLJ7Uo9fRcHW4a
	 Yca7xFpmifHK/3Ij+zqtVlP6vdWmXIHxzJ3GX9MI2HlaNUBPL7xBIEQPAiGYlgf+KO
	 UEBfHnzq/Je8qQw7B4v5qPzYTzE1PriihF31DMZG+rCDwGtGcpSAF1/4IDQw4lWqdx
	 Y5kIMPxJZADvjKbDiEwdByWeNybuEzf/IKmPom58qNw1YK9nMhNXkI14Fb//0lyE56
	 Q9+1MLlP9WdsQ==
Received: from loljews.com (localhost [127.0.0.1])
	by postfix (Postfix) with ESMTP id 444C427A3907;
	Mon, 02 Nov 2026 01:13:44 +0200 (EET)
From: Sandeep Haemoon <sandeeph@loljews.com>
To: netdev@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: ethernet: mtk_eth_soc: add 9K jumbo frame
Date: Mon, 2 Nov 2026 00:48:45 +0200
Message-Id: <patch-f1b04513b0fe3fb0a35ac744799fb0f3@loljews.com>
In-Reply-To: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com>
References: <patch-4f863a941889f0bceca1c082f2d79624@loljews.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

The driver caps max_mtu at 2030 bytes and programs the MAC max-rx field
for at most 2048-byte frames, so MTU > 2K is rejected and 9K jumbo
frames are not usable on the 10G XGMII MACs.

Add a MTK_NETSYS_RX_9K capability for MT7988 and:
- advertise 9K max_mtu on XGMII MACs, derived from the DT phy_mode at
  probe time so DSA can raise the conduit MTU before the netdev is
  opened;
- program XMAC_RX_CFG2 on the XGMII MACs;
- derive the shared RX buffer length from the largest MTU and size the
  RX rings from it;
- program the PDMA RX SDL max frame so the DMA engine accepts jumbo
  frames;
- reject a runtime MTU change that would need a different ring buffer
  size while DMA is running; the rings are sized at the next open.

This is a forward-port of the MediaTek downstream jumbo series:
Mason Chang's "change default rx buffer length", "add 9k jumbo frame
support" and "add dynamic rx buffer adjustment support" (MediaTek
OpenWrt feed 999-eth-30/31/33, carried in
frank-w/BPI-Router-Linux 92bfdbdd4de1/b4c6cb1d5532/ca4c976dce22),
plus Frank Wunderlich's "try to fix crash the right way"
(a3207a383794).

Link: https://github.com/frank-w/BPI-Router-Linux/commit/b4c6cb1d5532
Link: https://github.com/mediatek/mtk-openwrt-feeds
Signed-off-by: Sandeep Haemoon <sandeeph@loljews.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 137 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |   9 +-
 2 files changed, 118 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index ad0fdc413..b5f7b2a78 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -171,6 +171,7 @@ static const struct mtk_reg_map mt7988_reg_map = {
 		.glo_cfg	= 0x6a04,
 		.rst_idx	= 0x6a08,
 		.delay_irq	= 0x6a0c,
+		.rx_cfg		= 0x6a10,
 		.irq_status	= 0x6a20,
 		.irq_mask	= 0x6a28,
 		.adma_rx_dbg0	= 0x6a38,
@@ -554,6 +555,8 @@ static int mtk_mac_prepare(struct phylink_config *config, unsigned int mode,
 	return 0;
 }
 
+static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val);
+
 static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 			   const struct phylink_link_state *state)
 {
@@ -647,6 +650,7 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		regmap_write(eth->ethsys, ETHSYS_SYSCFG0, val);
 
 		mac->interface = state->interface;
+		mtk_set_mcr_max_rx(mac, eth->rx_buf_len);
 	}
 
 	/* SGMII */
@@ -1242,22 +1246,22 @@ static void mtk_get_stats64(struct net_device *dev,
 	storage->tx_dropped = dev->stats.tx_dropped;
 }
 
-static inline int mtk_max_frag_size(int mtu)
+static inline int mtk_max_frag_size(struct mtk_eth *eth, int mtu)
 {
-	/* make sure buf_size will be at least MTK_MAX_RX_LENGTH */
-	if (mtu + MTK_RX_ETH_HLEN < MTK_MAX_RX_LENGTH_2K)
-		mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;
+	/* make sure buf_size will be at least max rx buffer length */
+	if (mtu + MTK_RX_ETH_HLEN < eth->rx_buf_len)
+		mtu = eth->rx_buf_len - MTK_RX_ETH_HLEN;
 
 	return SKB_DATA_ALIGN(MTK_RX_HLEN + mtu) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 }
 
-static inline int mtk_max_buf_size(int frag_size)
+static inline int mtk_max_buf_size(struct mtk_eth *eth, int frag_size)
 {
 	int buf_size = frag_size - NET_SKB_PAD - NET_IP_ALIGN -
 		       SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	WARN_ON(buf_size < MTK_MAX_RX_LENGTH_2K);
+	WARN_ON(buf_size < eth->rx_buf_len);
 
 	return buf_size;
 }
@@ -1280,9 +1284,8 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	return true;
 }
 
-static void *mtk_max_lro_buf_alloc(gfp_t gfp_mask)
+static void *mtk_max_buf_alloc(unsigned int size, gfp_t gfp_mask)
 {
-	unsigned int size = mtk_max_frag_size(MTK_MAX_LRO_RX_LENGTH);
 	unsigned long data;
 
 	data = __get_free_pages(gfp_mask | __GFP_COMP | __GFP_NOWARN,
@@ -2310,7 +2313,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			if (ring->frag_size <= PAGE_SIZE)
 				new_data = napi_alloc_frag(ring->frag_size);
 			else
-				new_data = mtk_max_lro_buf_alloc(GFP_ATOMIC);
+				new_data = mtk_max_buf_alloc(ring->frag_size, GFP_ATOMIC);
 
 			if (unlikely(!new_data)) {
 				netdev->stats.rx_dropped++;
@@ -2788,6 +2791,9 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 	}
 }
 
+static int mtk_max_gmac_mtu(struct mtk_eth *eth);
+static u32 mtk_rx_buf_len(struct mtk_eth *eth);
+
 static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 {
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
@@ -2812,8 +2818,8 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		rx_dma_size = soc->rx.dma_size;
 	}
 
-	ring->frag_size = mtk_max_frag_size(rx_data_len);
-	ring->buf_size = mtk_max_buf_size(ring->frag_size);
+	ring->frag_size = mtk_max_frag_size(eth, rx_data_len);
+	ring->buf_size = mtk_max_buf_size(eth, ring->frag_size);
 	ring->data = kcalloc(rx_dma_size, sizeof(*ring->data),
 			     GFP_KERNEL);
 	if (!ring->data)
@@ -2852,7 +2858,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 			if (ring->frag_size <= PAGE_SIZE)
 				data = netdev_alloc_frag(ring->frag_size);
 			else
-				data = mtk_max_lro_buf_alloc(GFP_KERNEL);
+				data = mtk_max_buf_alloc(ring->frag_size, GFP_KERNEL);
 
 			if (!data)
 				return -ENOMEM;
@@ -3256,6 +3262,12 @@ static int mtk_dma_init(struct mtk_eth *eth)
 	if (mtk_dma_busy_wait(eth))
 		return -EBUSY;
 
+	/* Derived here, at ring allocation, so eth->rx_buf_len always describes
+	 * the buffers the rings actually hold and mtk_mac_config() never lets
+	 * a MAC accept a frame the rings cannot take.
+	 */
+	eth->rx_buf_len = mtk_rx_buf_len(eth);
+
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA)) {
 		/* QDMA needs scratch memory for internal reordering of the
 		 * descriptors
@@ -3299,6 +3311,17 @@ static int mtk_dma_init(struct mtk_eth *eth)
 		mtk_w32(eth, 0x0, eth->soc->reg_map->qdma.hred);
 	}
 
+	/* Program the PDMA max RX frame (SDL) from rx_buf_len so jumbo
+	 * frames up to it are accepted by the DMA engine.
+	 */
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		u32 val = mtk_r32(eth, eth->soc->reg_map->pdma.rx_cfg);
+
+		mtk_w32(eth, val | ((MTK_PDMA_LRO_SDL + eth->rx_buf_len) <<
+			MTK_RX_CFG_SDL_OFFSET),
+			eth->soc->reg_map->pdma.rx_cfg);
+	}
+
 	return 0;
 }
 
@@ -3600,6 +3623,24 @@ static int mtk_max_gmac_mtu(struct mtk_eth *eth)
 	return max_mtu;
 }
 
+static u32 mtk_rx_buf_len_from_mtu(int max_mtu)
+{
+	int length = max_mtu + MTK_RX_ETH_HLEN;
+
+	if (length <= MTK_MAX_RX_LENGTH)
+		return MTK_MAX_RX_LENGTH;
+
+	return DIV_ROUND_UP(length, 1024) * 1024;
+}
+
+/* The rx rings are shared by every MAC, so their buffers are sized for the
+ * largest MTU configured on any of them.
+ */
+static u32 mtk_rx_buf_len(struct mtk_eth *eth)
+{
+	return mtk_rx_buf_len_from_mtu(mtk_max_gmac_mtu(eth));
+}
+
 static int mtk_open(struct net_device *dev)
 {
 	struct mtk_mac *mac = netdev_priv(dev);
@@ -3924,20 +3965,33 @@ static void mtk_set_mcr_max_rx(struct mtk_mac *mac, u32 val)
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		return;
 
-	mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
-	mcr_new = mcr_cur & ~MAC_MCR_MAX_RX_MASK;
-
-	if (val <= 1518)
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1518);
-	else if (val <= 1536)
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1536);
-	else if (val <= 1552)
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1552);
-	else
-		mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_2048);
+	if (!mtk_interface_mode_is_xgmii(eth, mac->interface)) {
+		mcr_cur = mtk_r32(mac->hw, MTK_MAC_MCR(mac->id));
+		mcr_new = mcr_cur & ~MAC_MCR_MAX_RX_MASK;
 
-	if (mcr_new != mcr_cur)
-		mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
+		if (val <= 1518)
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1518);
+		else if (val <= 1536)
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1536);
+		else if (val <= 1552)
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_1552);
+		else
+			mcr_new |= MAC_MCR_MAX_RX(MAC_MCR_MAX_RX_2048);
+
+		if (mcr_new != mcr_cur)
+			mtk_w32(mac->hw, mcr_new, MTK_MAC_MCR(mac->id));
+	} else if (mtk_is_netsys_v3_or_greater(mac->hw) &&
+		   mac->id != MTK_GMAC1_ID) {
+		mcr_cur = mtk_r32(mac->hw, MTK_XMAC_RX_CFG2(mac->id));
+
+		if (val < MTK_MAX_RX_LENGTH_9K)
+			mcr_new = FIELD_PREP(MTK_XMAC_MAX_RX_MASK, val);
+		else
+			mcr_new = MTK_MAX_RX_LENGTH_9K;
+
+		if (mcr_new != mcr_cur)
+			mtk_w32(mac->hw, mcr_new, MTK_XMAC_RX_CFG2(mac->id));
+	}
 }
 
 static void mtk_hw_reset(struct mtk_eth *eth)
@@ -4349,6 +4403,7 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 	int length = new_mtu + MTK_RX_ETH_HLEN;
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
+	u32 rx_buf_len;
 	int max_mtu, i;
 
 	if (rcu_access_pointer(eth->prog) &&
@@ -4357,6 +4412,17 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 		return -EINVAL;
 	}
 
+	/* The RX rings are shared and cannot be resized in place while DMA is
+	 * running.  Until the reallocation worker lands, reject a runtime MTU
+	 * change that would need a different ring buffer size.
+	 */
+	max_mtu = mtk_max_gmac_mtu(eth);
+	if (new_mtu > max_mtu)
+		max_mtu = new_mtu;
+	rx_buf_len = mtk_rx_buf_len_from_mtu(max_mtu);
+	if (refcount_read(&eth->dma_refcnt) && rx_buf_len != eth->rx_buf_len)
+		return -EBUSY;
+
 	mtk_set_mcr_max_rx(mac, length);
 	WRITE_ONCE(dev->mtu, new_mtu);
 
@@ -4364,6 +4430,15 @@ static int mtk_change_mtu(struct net_device *dev, int new_mtu)
 	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
 		mtk_ppe_update_mtu(eth->ppe[i], max_mtu);
 
+	eth->rx_buf_len = rx_buf_len;
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		u32 val = mtk_r32(eth, eth->soc->reg_map->pdma.rx_cfg);
+
+		mtk_w32(eth, val | ((MTK_PDMA_LRO_SDL + eth->rx_buf_len) <<
+			MTK_RX_CFG_SDL_OFFSET),
+			eth->soc->reg_map->pdma.rx_cfg);
+	}
+
 	return 0;
 }
 
@@ -5009,8 +5084,14 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	eth->netdev[id]->irq = eth->irq[MTK_FE_IRQ_SHARED];
 	eth->netdev[id]->dev.of_node = np;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
-		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH - MTK_RX_ETH_HLEN;
+	/* DSA sets the conduit MTU (user MTU + tag) before the netdev is
+	 * opened, so max_mtu must already be final here.  Deriving it only
+	 * in mtk_open() leaves the conduit at its 1504 default and blocks
+	 * 9K frames on the DSA user ports.
+	 */
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_RX_9K) &&
+	    mtk_interface_mode_is_xgmii(eth, phy_mode))
+		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH_9K - MTK_RX_ETH_HLEN;
 	else
 		eth->netdev[id]->max_mtu = MTK_MAX_RX_LENGTH_2K - MTK_RX_ETH_HLEN;
 
@@ -5151,6 +5232,8 @@ static int mtk_probe(struct platform_device *pdev)
 	spin_lock_init(&eth->rx_irq_lock);
 	spin_lock_init(&eth->dim_lock);
 
+	eth->rx_buf_len = MTK_MAX_RX_LENGTH;
+
 	eth->rx_dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
 	INIT_WORK(&eth->rx_dim.work, mtk_dim_rx);
 	INIT_DELAYED_WORK(&eth->reset.monitor_work, mtk_hw_reset_monitor_work);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 88a9b3b23..9aad21ea3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -29,6 +29,7 @@
 #define MTK_QDMA_PAGE_SIZE	2048
 #define MTK_MAX_RX_LENGTH	1536
 #define MTK_MAX_RX_LENGTH_2K	2048
+#define MTK_MAX_RX_LENGTH_9K	9216
 #define MTK_TX_DMA_BUF_LEN	0x3fff
 #define MTK_TX_DMA_BUF_LEN_V2	0xffff
 #define MTK_QDMA_RING_SIZE	2048
@@ -530,6 +531,8 @@
 /* XFI Mac control registers */
 #define MTK_XMAC_BASE(x)	(0x12000 + (((x) - 1) * 0x1000))
 #define MTK_XMAC_MCR(x)		(MTK_XMAC_BASE(x))
+#define MTK_XMAC_RX_CFG2(x)	(MTK_XMAC_MCR(x) + 0xd0)
+#define MTK_XMAC_MAX_RX_MASK	GENMASK(13, 0)
 #define XMAC_MCR_TRX_DISABLE	0xf
 #define XMAC_MCR_FORCE_TX_FC	BIT(5)
 #define XMAC_MCR_FORCE_RX_FC	BIT(4)
@@ -985,6 +988,7 @@ enum mkt_eth_capabilities {
 	MTK_INFRA_BIT,
 	MTK_SHARED_SGMII_BIT,
 	MTK_HWLRO_BIT,
+	MTK_NETSYS_RX_9K_BIT,
 	MTK_SHARED_INT_BIT,
 	MTK_TRGMII_MT7621_CLK_BIT,
 	MTK_QDMA_BIT,
@@ -1026,6 +1030,7 @@ enum mkt_eth_capabilities {
 #define MTK_INFRA		BIT_ULL(MTK_INFRA_BIT)
 #define MTK_SHARED_SGMII	BIT_ULL(MTK_SHARED_SGMII_BIT)
 #define MTK_HWLRO		BIT_ULL(MTK_HWLRO_BIT)
+#define MTK_NETSYS_RX_9K	BIT_ULL(MTK_NETSYS_RX_9K_BIT)
 #define MTK_SHARED_INT		BIT_ULL(MTK_SHARED_INT_BIT)
 #define MTK_TRGMII_MT7621_CLK	BIT_ULL(MTK_TRGMII_MT7621_CLK_BIT)
 #define MTK_QDMA		BIT_ULL(MTK_QDMA_BIT)
@@ -1127,7 +1132,7 @@ enum mkt_eth_capabilities {
 
 #define MT7988_CAPS  (MTK_36BIT_DMA | MTK_GDM1_ESW | MTK_GMAC2_2P5GPHY | \
 		      MTK_MUX_GMAC2_TO_2P5GPHY | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
-		      MTK_RSTCTRL_PPE2 | MTK_SRAM)
+		      MTK_RSTCTRL_PPE2 | MTK_SRAM | MTK_NETSYS_RX_9K)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1151,6 +1156,7 @@ struct mtk_reg_map {
 		u32	glo_cfg;	/* global configuration */
 		u32	rst_idx;	/* reset index */
 		u32	delay_irq;	/* delay interrupt */
+		u32	rx_cfg;		/* rx dma configuration */
 		u32	irq_status;	/* interrupt status */
 		u32	irq_mask;	/* interrupt mask */
 		u32	adma_rx_dbg0;
@@ -1314,6 +1320,7 @@ struct mtk_eth {
 	struct mtk_tx_ring		tx_ring;
 	struct mtk_rx_ring		rx_ring[MTK_MAX_RX_RING_NUM];
 	struct mtk_rx_ring		rx_ring_qdma;
+	u32				rx_buf_len;
 	struct napi_struct		tx_napi;
 	struct napi_struct		rx_napi;
 	void				*scratch_ring;
-- 
2.53.0

