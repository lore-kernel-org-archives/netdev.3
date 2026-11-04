Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793769272;
	b=Wxhw22NJ/1oiLD8//E96JOkm7N3mjCXoyhDRX0yY5w/wKVLFi7hjv2yhz+ODuw3bMgS2
	 eUpIinWrLmtK64uNrX4GlfWQKxE8beaFibS6efyUa8so/CKA8uOHu596MO8vg29F8inTg
	 Nb9HcCaZ4g3TRxoRKKpjxW4qeLDd5AaW8RYRou9yKbpp5++wIwYo2hM5lMq9bNlRhY965
	 67dhgs2CYK/WMZbv8VfJIcAr2KbhRkUWKfCEl8kivHEk18hqv5jok8m3V4i6beYoKJLIq
	 9j0Fsevf93KZx68m/KtqvN8eMPi0fTdk0j0NhQveVENPnKkLLoVtTmZrWEXF7wL20Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793769272;
	h=DMARC-Filter:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:CC:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KyzM4XUQJeBYylQNLUR8mC6wxDEbAaY+m3hGjXjLxcY=;
	b=si5WUq7K/NYCM64e2KlB96qp9yIWejaTtfZdIkiA1l0uhnLgorxJOGXSlMGurqQKVEZV
	 epC6DcpGgD40ns9WghJZvbZ+DtVP8/ScjLeWrHPAM2SDI/Q2ofXErfSqfE2dLBIHPdz/X
	 LjDrxoi9z2evecq6GPjwuCBqKBaVTIOAXwuS2Gyb8Ru1ka9ybYtsxtPlaiWvP+GQ3dnaw
	 6ZWwnCtY+OKHq1Xw7ER3yBw+ioTg5WQECFY3iBYAROOl/OinCGJkWacgyehgx2szJpkX5
	 LAsRGtrDUuY5K7Pv4Q2K+1pJNjPUq35vYu05Hpb6hGKG+oj5z9jEgENvudrHd6739GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=aspeedtech.com;
	spf=pass smtp.mailfrom=aspeedtech.com;
	arc=none smtp.remote-ip=211.20.114.72
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5C606D802;
	Wed,  4 Nov 2026 05:14:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E5C606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 4 Nov
 2026 13:14:10 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 4 Nov 2026 13:14:10 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
Date: Wed, 4 Nov 2026 13:13:59 +0800
Subject: [PATCH net-next v5 6/7] net: ftgmac100: Add AST2700 upper DMA
 address support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261104-support_ast2700-v5-6-44057f4dde75@aspeedtech.com>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
In-Reply-To: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Po-Yu Chuang
	<ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jacky Chou <jacky_chou@aspeedtech.com>,
	Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793769249; l=8087;
 i=jacky_chou@aspeedtech.com; s=20251031; h=from:subject:message-id;
 bh=mWEkbWgALAdm/Z5h80hIIBEDWLiQsEg+634OST3FOWY=;
 b=v6mpJjA7PYLacPLlSF3m1hhTeNHwdAqn2ZfjPwpiW2Lk3JAGrntA1viUWvk4cwfvRLgBa7faX
 x+hDXxpHbY/Bf4yW4Uj9dCljpxb4rQJEfjTwOPIsY7fjM+g9CUKnjAA
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 62 +++++++++++++++++++++++++++-----
 drivers/net/ethernet/faraday/ftgmac100.h |  6 ++++
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 5a578a62df67..263594de0e07 100644
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
@@ -474,7 +482,10 @@ static int ftgmac100_alloc_rx_buf(struct ftgmac100 *priv, unsigned int entry,
 	priv->rx_skbs[entry] = skb;
 
 	/* Store DMA address into RX desc */
-	rxdes->rxdes3 = cpu_to_le32(map);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		rxdes->rxdes2 = cpu_to_le32(FIELD_PREP(FTGMAC100_RXDES2_RXBUF_BADR_HI,
+						       upper_32_bits(map)));
+	rxdes->rxdes3 = cpu_to_le32(lower_32_bits(map));
 
 	/* Ensure the above is ordered vs clearing the OWN bit */
 	dma_wmb();
@@ -601,6 +612,9 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 
 	/* Tear down DMA mapping, do necessary cache management */
 	map = le32_to_cpu(rxdes->rxdes3);
+	if (priv->quirks & FTGMAC100_QUIRK_DMA_35BIT)
+		map |= (u64)FIELD_GET(FTGMAC100_RXDES2_RXBUF_BADR_HI,
+				     le32_to_cpu(rxdes->rxdes2)) << 32;
 
 #if defined(CONFIG_ARM) && !defined(CONFIG_ARM_DMA_USE_IOMMU)
 	/* When we don't have an iommu, we can save cycles by not
@@ -677,9 +691,14 @@ static void ftgmac100_free_tx_packet(struct ftgmac100 *priv,
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
@@ -833,7 +852,10 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
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
@@ -861,7 +883,10 @@ static netdev_tx_t ftgmac100_hard_start_xmit(struct sk_buff *skb,
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
@@ -936,7 +961,12 @@ static void ftgmac100_free_buffers(struct ftgmac100 *priv)
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
@@ -1055,7 +1085,12 @@ static void ftgmac100_init_rings(struct ftgmac100 *priv)
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
@@ -2104,6 +2139,14 @@ static int ftgmac100_probe(struct platform_device *pdev)
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
@@ -2156,7 +2199,8 @@ static const struct ftgmac100_match_data ftgmac100_match_data_ast2600 = {
 
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

