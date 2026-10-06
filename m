Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D806F3ABD8D;
	Tue,  6 Oct 2026 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791271266; cv=none; b=Y3CX0DF/Gjmq+ukZVvIlQYYdekFkmOMxCsn/pbSvsIu5tn4vse8fRSSFNDfYO5Xluc4ZioV5psI8Ks71zmcv0RUa3aVPMD2w7nmqchwV/zUUZhNs5Ff84Wyj/9a1ajFmi+XdsUMU3wu6bBLTcf6rlWZUgwI8hS3cESOfE1X7ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791271266; c=relaxed/simple;
	bh=/6Hd2RtGgeVDz9DFyiyDO6bpiwvQhO7uDxNS6agrWGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ef/X/DoitcF5GpQhm6CiJy9y4M4UQ6lbSleC+CNQNfiVYP2o34YGCPk2O9uJIavf35VNwytX3AcawCgjyvK33+pMwMCE3r0tiTIR7LAWX086TN/q3dmcIh2LqlexjejXLDb5xTN5qGQy91/nbRbv7IQtyAxgJv8OIkJO+Ga5MKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 6 Oct
 2026 15:20:44 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Oct 2026 15:20:44 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Tue, 6 Oct 2026 15:20:43 +0800
Subject: [PATCH net-next v2 5/6] net: ftgmac100: Add AST2700 upper DMA
 address support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261006-support_ast2700-v2-5-36de51fb8066@aspeedtech.com>
References: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
In-Reply-To: <20261006-support_ast2700-v2-0-36de51fb8066@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791271243; l=8044;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=/6Hd2RtGgeVDz9DFyiyDO6bpiwvQhO7uDxNS6agrWGI=;
 b=pI97n8DbLeaV1g6O3SbYpgXSt2uTfMocccuLzCBSwQ5byP9ovna9avfITDU7pM46elhGWQQgI
 TOXxlJcmnb5Aw+VlLlLwukQI3bZPXKayvF5gmeZIXJAyB0Kx7R05JXs
X-Developer-Key: i=jacky_chou@aspeedtech.com; a=ed25519;
 pk=8XBx7KFM1drEsfCXTH9QC2lbMlGU4XwJTA6Jt9Mabdo=

Program the high RX and TX descriptor ring base registers and carry the
upper DMA address bits in RX and TX descriptors. Rebuild full buffer DMA
addresses in a 64-bit type before unmapping them so bits 34:32 are not
lost to 32-bit arithmetic.

The descriptor format provides three upper buffer address bits, so
request a 35-bit DMA mask instead of advertising an address range that
the hardware cannot encode. Gate all extended address handling with a
match-data quirk so older register layouts remain untouched and later
compatible controllers can opt into the same capability.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 62 +++++++++++++++++++++++++++-----
 drivers/net/ethernet/faraday/ftgmac100.h |  6 ++++
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 2d029d1262e6..af2e272f32f2 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/dma-mapping.h>
@@ -42,6 +43,7 @@ enum ftgmac100_mac_id {
 };
 
 #define FTGMAC100_QUIRK_RMII_ENABLE	BIT(0)
+#define FTGMAC100_QUIRK_DMA_35BIT	BIT(1)
 
 struct ftgmac100_match_data {
 	enum ftgmac100_mac_id mac_id;
@@ -303,10 +305,16 @@ static void ftgmac100_init_hw(struct ftgmac100 *priv)
 	iowrite32(reg, priv->base + FTGMAC100_OFFSET_ISR);
 
 	/* Setup RX ring buffer base */
-	iowrite32(priv->rxdes_dma, priv->base + FTGMAC100_OFFSET_RXR_BADR);
+	iowrite32(lower_32_bits(priv->rxdes_dma), priv->base + FTGMAC100_OFFSET_RXR_BADR);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		iowrite32(upper_32_bits(priv->rxdes_dma),
+			  priv->base + FTGMAC100_OFFSET_RXR_BADDR_HIGH);
 
 	/* Setup TX ring buffer base */
-	iowrite32(priv->txdes_dma, priv->base + FTGMAC100_OFFSET_NPTXR_BADR);
+	iowrite32(lower_32_bits(priv->txdes_dma), priv->base + FTGMAC100_OFFSET_NPTXR_BADR);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		iowrite32(upper_32_bits(priv->txdes_dma),
+			  priv->base + FTGMAC100_OFFSET_TXR_BADDR_HIGH);
 
 	/* Configure RX buffer size */
 	iowrite32(FTGMAC100_RBSR_SIZE(RX_BUF_SIZE),
@@ -469,7 +477,10 @@ static int ftgmac100_alloc_rx_buf(struct ftgmac100 *priv, unsigned int entry,
 	priv->rx_skbs[entry] = skb;
 
 	/* Store DMA address into RX desc */
-	rxdes->rxdes3 = cpu_to_le32(map);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		rxdes->rxdes2 = cpu_to_le32(FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI,
+						       upper_32_bits(map)));
+	rxdes->rxdes3 = cpu_to_le32(lower_32_bits(map));
 
 	/* Ensure the above is ordered vs clearing the OWN bit */
 	dma_wmb();
@@ -596,6 +607,9 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 
 	/* Tear down DMA mapping, do necessary cache management */
 	map = le32_to_cpu(rxdes->rxdes3);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		map |= (u64)FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI,
+				     le32_to_cpu(rxdes->rxdes2)) << 32;
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_ARM_DMA_USE_IOMMU)
 	/* When we don't have an iommu, we can save cycles by not
@@ -672,9 +686,14 @@ static void ftgmac100_free_tx_packet(struct ftgmac100 *priv,
 				     struct ftgmac100_txdes *txdes,
 				     u32 ctl_stat)
 {
-	dma_addr_t map = le32_to_cpu(txdes->txdes3);
+	dma_addr_t map;
 	size_t len;
 
+	map = le32_to_cpu(txdes->txdes3);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		map |= (u64)FIELD_GET(FTGMAC100_TXDES2_TXBUF_BADR_HI,
+				     le32_to_cpu(txdes->txdes2)) << 32;
+
 	if (ctl_stat & FTGMAC100_TXDES0_FTS) {
 		len = skb_headlen(skb);
 		dma_unmap_single(priv->dev, map, len, DMA_TO_DEVICE);
@@ -828,7 +847,10 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 	f_ctl_stat |= FTGMAC100_TXDES0_FTS;
 	if (nfrags == 0)
 		f_ctl_stat |= FTGMAC100_TXDES0_LTS;
-	txdes->txdes3 = cpu_to_le32(map);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		txdes->txdes2 = cpu_to_le32(FIELD_PREP(FTGMAC100_TXDES2_TXBUF_BADR_HI,
+						       upper_32_bits(map)));
+	txdes->txdes3 = cpu_to_le32(lower_32_bits(map));
 	txdes->txdes1 = cpu_to_le32(csum_vlan);
 
 	/* Next descriptor */
@@ -856,7 +878,10 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
 			ctl_stat |= FTGMAC100_TXDES0_LTS;
 		txdes->txdes0 = cpu_to_le32(ctl_stat);
 		txdes->txdes1 = 0;
-		txdes->txdes3 = cpu_to_le32(map);
+		if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+			txdes->txdes2 = cpu_to_le32(FIELD_PREP(FTGMAC100_TXDES2_TXBUF_BADR_HI,
+							       upper_32_bits(map)));
+		txdes->txdes3 = cpu_to_le32(lower_32_bits(map));
 
 		/* Next one */
 		pointer = ftgmac100_next_tx_pointer(priv, pointer);
@@ -931,7 +956,12 @@ static void ftgmac100_free_buffers(struct ftgmac100 *priv)
 	for (i = 0; i < priv->rx_q_entries; i++) {
 		struct ftgmac100_rxdes *rxdes = &priv->rxdes[i];
 		struct sk_buff *skb = priv->rx_skbs[i];
-		dma_addr_t map = le32_to_cpu(rxdes->rxdes3);
+		dma_addr_t map;
+
+		map = le32_to_cpu(rxdes->rxdes3);
+		if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+			map |= (u64)FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI,
+					     le32_to_cpu(rxdes->rxdes2)) << 32;
 
 		if (!skb)
 			continue;
@@ -1050,7 +1080,12 @@ static void ftgmac100_init_rings(struct ftgmac100 *priv)
 	for (i = 0; i < priv->rx_q_entries; i++) {
 		rxdes = &priv->rxdes[i];
 		rxdes->rxdes0 = 0;
-		rxdes->rxdes3 = cpu_to_le32(priv->rx_scratch_dma);
+		if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT) {
+			u32 hi = upper_32_bits(priv->rx_scratch_dma);
+
+			rxdes->rxdes2 = cpu_to_le32(FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI, hi));
+		}
+		rxdes->rxdes3 = cpu_to_le32(lower_32_bits(priv->rx_scratch_dma));
 	}
 	/* Mark the end of the ring */
 	rxdes->rxdes0 |= cpu_to_le32(priv->rxdes0_edorr_mask);
@@ -2099,6 +2134,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
 		netdev->hw_features &= ~(NETIF_F_HW_CSUM | NETIF_F_RXCSUM);
 	netdev->features |= netdev->hw_features;
 
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT) {
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(35));
+		if (err) {
+			dev_err(&pdev->dev, "35-bit DMA enable failed\n");
+			goto err;
+		}
+	}
+
 	/* register network device */
 	err = register_netdev(netdev);
 	if (err) {
@@ -2151,7 +2194,8 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
 
 static const struct ftgmac100_match_data ftgmac100_match_data_ast2700 = {
 	.mac_id = FTGMAC100_AST2700,
-	.quirks = FTGMAC100_QUIRK_RMII_ENABLE,
+	.quirks = FTGMAC100_QUIRK_RMII_ENABLE |
+		  FTGMAC100_QUIRK_DMA_35BIT,
 };
 
 static const struct ftgmac100_match_data ftgmac100_match_data_faraday = {
diff --git a/drivers/net/ethernet/faraday/ftgmac100.h b/drivers/net/ethernet/faraday/ftgmac100.h
index 8c35c895b146..0c244b1c0a35 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.h
+++ b/drivers/net/ethernet/faraday/ftgmac100.h
@@ -57,6 +57,9 @@
 #define FTGMAC100_OFFSET_RX_RUNT	0xc0
 #define FTGMAC100_OFFSET_RX_CRCER_FTL	0xc4
 #define FTGMAC100_OFFSET_RX_COL_LOST	0xc8
+/* reserved 0xcc - 0x178 */
+#define FTGMAC100_OFFSET_TXR_BADDR_HIGH	0x17c
+#define FTGMAC100_OFFSET_RXR_BADDR_HIGH	0x18c
 
 /*
  * Interrupt status register & interrupt enable register
@@ -226,6 +229,7 @@ struct ftgmac100_txdes {
 #define FTGMAC100_TXDES1_TX2FIC		(1 << 30)
 #define FTGMAC100_TXDES1_TXIC		(1 << 31)
 
+#define FTGMAC100_TXDES2_TXBUF_BADR_HI	GENMASK(18, 16)
 /*
  * Receive descriptor, aligned to 16 bytes
  */
@@ -272,4 +276,6 @@ struct ftgmac100_rxdes {
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR	(1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR	(1 << 27)
 
+#define FTGMAC100_RXDES2_RXBUF_BADR_HI	GENMASK(18, 16)
+
 #endif /* __FTGMAC100_H */

-- 
2.34.1

