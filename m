Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D739768F;
	Mon, 31 Aug 2026 05:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154830; cv=none; b=g2ATmvnix0l53zNvM/5++JLmpdsI1Fid1KxTgY8H5nO1w4gyS61ubtclkbDGLEg5WQafKPKdIpzIh6WN3Jl+cBzD6qj4WjBSBtA5Olyi6q8KR2BKt7GZFGm2/sL+Ifx1DAiDC3LNIfVrQTGOVLT2l1tbdt1uKThD3WTaMZm72Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154830; c=relaxed/simple;
	bh=Xx+a4qDdrpByypwSFdhXPKkpTkDPfSBM1a2Vh88GXLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LkzkLteap2Eo204/dAgIrmdqul86tACABssgWZFFbktAr9nNPBsvtbg/sxdR6C/IKxYF1O9DechFuIsxhLytJ3jZ/shhXl36w4nucTlAURF+t5mrrTMAGDs6vbQl1oe7dov8ai0b5r1So8UOxa2289YUp4p+hmAmXk8S46W3704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=r0VhZ8U7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="r0VhZ8U7"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5diCgB479611, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154784;
	bh=olSTQmD9SfxebtVC73vU1lOY4VozvSEgs3CAYdx3o9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=r0VhZ8U78iOR9Fg4wed7cw33skz2irfTarShla+3cXG1/IB1v5kTOD3puuauaznXD
	 4heJx+5EnapjySSVbFB30lPmlNcT/BNtjccR8l41FECDuCDQMTwjPU/HMsckuzYcwr
	 dOUALM+YDho7u+zFdcL9CpDuv++BtAf8YnDno9BaQ5otn4TYb/TQFXhktBqDyAnn6G
	 YyOI/1cuy9UbXNR5bzK3KRiR4JDXW6hX4yglNvYLdzDmd+PqdFC9HoleuZsJYrGKxw
	 dx2Yrn8ZnfsdMHW2U3A9vlFgKDAWsVA7kuEQuSjESvJFj00BQGdQh4DAPb8uFvUUBZ
	 kB43m9Pq/IvvQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5diCgB479611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:39:44 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:39:43 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:39:43 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v12 2/7] r8169: refactor RX path to prepare for multi-queue
Date: Mon, 31 Aug 2026 13:39:35 +0800
Message-ID: <20260831053940.620-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260831053940.620-1-javen_xu@realsil.com.cn>
References: <20260831053940.620-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch is a preparatory refactoring of the RX path. It introduces
struct rtl8169_rx_ring and turns the previously embedded RX state in
rtl8169_private into a per-queue array.
While the netdev allocation is changed to devm_alloc_etherdev_mqs()
with up to 8 RX queues, the actual number of active RX rings
(num_rx_rings) is currently kept at 1. The actual multi-queue operation
and RSS enablement will be introduced in subsequent patches.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - sort some registers by its number
 - remove some unused definitions, like RX_DESC_RING_TYPE_MAX
 - change recheck_desc_ownbit type
 - remove rdsar_reg in rx_ring struct
 - opts1 are different in rx_desc and rx_desc_rss, move the judgement
   to Patch 5/7

Changes in v3:
 - remove ring->rx_desc_alloc_size, use constant instead

Changes in v4:
 - change rdsar_reg type to unsigned int
 - follow reverse xmas tree, in rtl_set_rx_tx_desc_registers(),
   rtl8169_alloc_rx_data(), rtl8169_alloc_rx_desc(),
   rtl8169_free_rx_desc()
 - add comments on LED_CTRL, remove helper function

Changes in v5:
 - modify rtl8169_init_ring(), do rx clear when failed
 - add definition R8169_MAX_TX_QUEUES 1

Changes in v6:
 - Restore the secondary Rx error filter when NETIF_F_RXFALL is enabled
   in rtl_rx()

Changes in v7:
 - remove code associated with recheck_desc_ownbit

Changes in v8:
 - remove le64_to_cpu() for addr, rx get addr from rx_desc_phy_addr

Changes in v9:
 - remove R8127_MAX_RX_QUEUES
 - remvoe rx_desc_ring_type to the following patch
 - Fix loop bound in init_ring_indexes
 - Restore checksum API

Changes in v10:
 - alloc rtl8169_rx_ring struct according to the num_rx_ring dynamically

Changes in v11:
 - leak rx_ring array on driver removal
---
 drivers/net/ethernet/realtek/r8169_main.c | 245 +++++++++++++++++-----
 1 file changed, 190 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 87eb10616a0c..9311a0cab4eb 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -74,9 +74,19 @@
 #define NUM_TX_DESC	256	/* Number of Tx descriptor registers */
 #define NUM_RX_DESC	256	/* Number of Rx descriptor registers */
 #define R8169_TX_RING_BYTES	(NUM_TX_DESC * sizeof(struct TxDesc))
-#define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
+
+/*
+ * Workaround for the hardware DMA prefetcher. The H/W might aggressively
+ * fetch one more descriptor even after hitting the RingEnd mark. We
+ * allocate this extra dummy space as padding to prevent out-of-bounds
+ * access and potential IOMMU faults.
+ */
+#define R8169_RX_RING_BYTES	((NUM_RX_DESC + 1) * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
+#define R8169_MAX_RX_QUEUES	8
+#define R8169_DEFAULT_RX_QUEUES	1
+#define R8169_MAX_TX_QUEUES	1
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -441,6 +451,7 @@ enum rtl8125_registers {
 	TxPoll_8125		= 0x90,
 	LEDSEL3			= 0x96,
 	MAC0_BKP		= 0x19e0,
+	RDSAR_Q1_LOW		= 0x4000,
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
@@ -728,6 +739,15 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_rx_ring {
+	u32 cur_rx;
+	u32 dirty_rx;
+	struct RxDesc *rx_desc_array;
+	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
+	dma_addr_t rx_phy_addr;
+	struct page *rx_databuff[NUM_RX_DESC];
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -735,20 +755,18 @@ struct rtl8169_private {
 	struct phy_device *phydev;
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
-	u32 cur_rx; /* Index into the Rx descriptor buffer of next Rx pkt. */
 	u32 cur_tx; /* Index into the Tx descriptor buffer of next Rx pkt. */
 	u32 dirty_tx;
 	struct TxDesc *TxDescArray;	/* 256-aligned Tx descriptor ring */
-	struct RxDesc *RxDescArray;	/* 256-aligned Rx descriptor ring */
 	dma_addr_t TxPhyAddr;
-	dma_addr_t RxPhyAddr;
-	struct page *Rx_databuff[NUM_RX_DESC];	/* Rx data buffers */
 	struct ring_info tx_skb[NUM_TX_DESC];	/* Tx data buffers */
 	struct napi_struct *rtl8169_napi;
+	struct rtl8169_rx_ring *rx_ring;
 	unsigned int num_rx_rings;
 	u16 cp_cmd;
 	u16 tx_lpi_timer;
 	u32 irq_mask;
+	unsigned int hw_supp_num_rx_queues;
 	unsigned int irq_nvecs;
 	struct clk *clk;
 
@@ -2620,9 +2638,26 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_rx_desc_init(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_desc_array, 0x0, R8169_RX_RING_BYTES);
+	}
+}
+
 static void rtl8169_init_ring_indexes(struct rtl8169_private *tp)
 {
-	tp->dirty_tx = tp->cur_tx = tp->cur_rx = 0;
+	tp->dirty_tx = 0;
+	tp->cur_tx = 0;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		ring->dirty_rx = 0;
+		ring->cur_rx = 0;
+	}
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -2684,6 +2719,14 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 static void rtl_setup_rx_params(struct rtl8169_private *tp)
 {
 	tp->num_rx_rings = 1;
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_80:
+		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
+		break;
+	default:
+		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
+		break;
+	}
 }
 
 static void rtl_request_firmware(struct rtl8169_private *tp)
@@ -2810,6 +2853,8 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 
 static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 {
+	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
+
 	/*
 	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
 	 * register to be written before TxDescAddrLow to work.
@@ -2817,8 +2862,18 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 	 */
 	RTL_W32(tp, TxDescStartAddrHigh, ((u64) tp->TxPhyAddr) >> 32);
 	RTL_W32(tp, TxDescStartAddrLow, ((u64) tp->TxPhyAddr) & DMA_BIT_MASK(32));
-	RTL_W32(tp, RxDescAddrHigh, ((u64) tp->RxPhyAddr) >> 32);
-	RTL_W32(tp, RxDescAddrLow, ((u64) tp->RxPhyAddr) & DMA_BIT_MASK(32));
+	RTL_W32(tp, RxDescAddrHigh, ((u64)ring->rx_phy_addr) >> 32);
+	RTL_W32(tp, RxDescAddrLow,
+		((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
+
+	for (int i = 1; i < tp->num_rx_rings; i++) {
+		unsigned int rdsar_reg = RDSAR_Q1_LOW + (i - 1) * 8;
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		RTL_W32(tp, rdsar_reg + 4, ((u64)ring->rx_phy_addr >> 32));
+		RTL_W32(tp, rdsar_reg,
+			((u64)ring->rx_phy_addr) & DMA_BIT_MASK(32));
+	}
 }
 
 static void rtl8169_set_magic_reg(struct rtl8169_private *tp)
@@ -4165,8 +4220,9 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
-					  struct RxDesc *desc)
+					  struct rtl8169_rx_ring *ring, unsigned int index)
 {
+	struct RxDesc *desc = ring->rx_desc_array + index;
 	struct device *d = tp_to_dev(tp);
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
@@ -4184,55 +4240,107 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	desc->addr = cpu_to_le64(mapping);
+	ring->rx_desc_phy_addr[index] = mapping;
 	rtl8169_mark_to_asic(desc);
 
 	return data;
 }
 
-static void rtl8169_rx_clear(struct rtl8169_private *tp)
+static void rtl8169_rx_clear(struct rtl8169_private *tp,
+			     struct rtl8169_rx_ring *ring)
 {
 	int i;
 
-	for (i = 0; i < NUM_RX_DESC && tp->Rx_databuff[i]; i++) {
+	for (i = 0; i < NUM_RX_DESC && ring->rx_databuff[i]; i++) {
 		dma_unmap_page(tp_to_dev(tp),
-			       le64_to_cpu(tp->RxDescArray[i].addr),
+			       ring->rx_desc_phy_addr[i],
 			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
-		tp->Rx_databuff[i] = NULL;
-		tp->RxDescArray[i].addr = 0;
-		tp->RxDescArray[i].opts1 = 0;
+		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
+		ring->rx_databuff[i] = NULL;
+		ring->rx_desc_phy_addr[i] = 0;
+		ring->rx_desc_array[i].addr = 0;
+		ring->rx_desc_array[i].opts1 = 0;
 	}
 }
 
-static int rtl8169_rx_fill(struct rtl8169_private *tp)
+static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *ring)
 {
 	int i;
 
 	for (i = 0; i < NUM_RX_DESC; i++) {
 		struct page *data;
 
-		data = rtl8169_alloc_rx_data(tp, tp->RxDescArray + i);
+		data = rtl8169_alloc_rx_data(tp, ring, i);
 		if (!data) {
-			rtl8169_rx_clear(tp);
+			rtl8169_rx_clear(tp, ring);
 			return -ENOMEM;
 		}
-		tp->Rx_databuff[i] = data;
+		ring->rx_databuff[i] = data;
 	}
 
 	/* mark as last descriptor in the ring */
-	tp->RxDescArray[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
+	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
 
 	return 0;
 }
 
+static int rtl8169_alloc_rx_desc(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct rtl8169_rx_ring *ring;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		ring->rx_desc_array = dma_alloc_coherent(&pdev->dev,
+							 R8169_RX_RING_BYTES,
+							 &ring->rx_phy_addr,
+							 GFP_KERNEL);
+		if (!ring->rx_desc_array)
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+static void rtl8169_free_rx_desc(struct rtl8169_private *tp)
+{
+	struct pci_dev *pdev = tp->pci_dev;
+	struct rtl8169_rx_ring *ring;
+
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		ring = &tp->rx_ring[i];
+		if (ring->rx_desc_array) {
+			dma_free_coherent(&pdev->dev,
+					  R8169_RX_RING_BYTES,
+					  ring->rx_desc_array,
+					  ring->rx_phy_addr);
+			ring->rx_desc_array = NULL;
+		}
+	}
+}
+
 static int rtl8169_init_ring(struct rtl8169_private *tp)
 {
+	int i, ret;
+
 	rtl8169_init_ring_indexes(tp);
+	rtl8169_rx_desc_init(tp);
 
 	memset(tp->tx_skb, 0, sizeof(tp->tx_skb));
-	memset(tp->Rx_databuff, 0, sizeof(tp->Rx_databuff));
 
-	return rtl8169_rx_fill(tp);
+	for (i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+
+		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
+		ret = rtl8169_rx_fill(tp, ring);
+		if (ret < 0)
+			goto err_clear;
+	}
+	return 0;
+
+err_clear:
+	while (--i >= 0)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
+	return ret;
 }
 
 static void rtl8169_unmap_tx_skb(struct rtl8169_private *tp, unsigned int entry)
@@ -4321,16 +4429,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
 	rtl8169_init_ring_indexes(tp);
 }
 
-static void rtl_reset_work(struct rtl8169_private *tp)
+static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 {
-	int i;
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
+		for (int j = 0; j < NUM_RX_DESC; j++)
+			rtl8169_mark_to_asic(ring->rx_desc_array + j);
+	}
+}
+
+static void rtl_reset_work(struct rtl8169_private *tp)
+{
 	netif_stop_queue(tp->dev);
 
 	rtl8169_cleanup(tp);
 
-	for (i = 0; i < NUM_RX_DESC; i++)
-		rtl8169_mark_to_asic(tp->RxDescArray + i);
+	rtl8169_rx_desc_reset(tp);
 
 	rtl8169_napi_enable(tp);
 	rtl_hw_start(tp);
@@ -4776,7 +4891,8 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
-static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
+static inline void rtl8169_rx_csum(struct sk_buff *skb,
+				   u32 opts1)
 {
 	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
 
@@ -4786,15 +4902,30 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
 		skb_checksum_none_assert(skb);
 }
 
+static bool rtl8169_check_rx_desc_error(struct net_device *dev,
+					struct rtl8169_private *tp,
+					u32 status)
+{
+	if (unlikely(status & RxRES)) {
+		if (status & (RxRWT | RxRUNT))
+			dev->stats.rx_length_errors++;
+		if (status & RxCRC)
+			dev->stats.rx_crc_errors++;
+		return true;
+	}
+	return false;
+}
+
 static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
-		  int budget, struct napi_struct *napi)
+		  struct rtl8169_rx_ring *ring, int budget,
+		  struct napi_struct *napi)
 {
 	struct device *d = tp_to_dev(tp);
 	int count;
 
-	for (count = 0; count < budget; count++, tp->cur_rx++) {
-		unsigned int pkt_size, entry = tp->cur_rx % NUM_RX_DESC;
-		struct RxDesc *desc = tp->RxDescArray + entry;
+	for (count = 0; count < budget; count++, ring->cur_rx++) {
+		unsigned int pkt_size, entry = ring->cur_rx % NUM_RX_DESC;
+		struct RxDesc *desc = ring->rx_desc_array + entry;
 		struct sk_buff *skb;
 		const void *rx_buf;
 		dma_addr_t addr;
@@ -4810,15 +4941,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		 */
 		dma_rmb();
 
-		if (unlikely(status & RxRES)) {
+		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
 			if (net_ratelimit())
 				netdev_warn(dev, "Rx ERROR. status = %08x\n",
 					    status);
 			dev->stats.rx_errors++;
-			if (status & (RxRWT | RxRUNT))
-				dev->stats.rx_length_errors++;
-			if (status & RxCRC)
-				dev->stats.rx_crc_errors++;
 
 			if (!(dev->features & NETIF_F_RXALL))
 				goto release_descriptor;
@@ -4845,8 +4972,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 			goto release_descriptor;
 		}
 
-		addr = le64_to_cpu(desc->addr);
-		rx_buf = page_address(tp->Rx_databuff[entry]);
+		addr = ring->rx_desc_phy_addr[entry];
+		rx_buf = page_address(ring->rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
 		prefetch(rx_buf);
@@ -4973,7 +5100,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	rtl_tx(dev, tp, budget);
 
-	work_done = rtl_rx(dev, tp, budget, napi);
+	/* rtl8169_poll() is used only when there is a single RX ring. */
+	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5104,18 +5232,17 @@ static int rtl8169_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 	rtl8169_down(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 
 	rtl8169_free_irq(tp);
 
 	phy_disconnect(tp->phydev);
 
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
 	tp->TxDescArray = NULL;
-	tp->RxDescArray = NULL;
+	rtl8169_free_rx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
 
@@ -5151,10 +5278,8 @@ static int rtl_open(struct net_device *dev)
 	if (!tp->TxDescArray)
 		goto out;
 
-	tp->RxDescArray = dma_alloc_coherent(&pdev->dev, R8169_RX_RING_BYTES,
-					     &tp->RxPhyAddr, GFP_KERNEL);
-	if (!tp->RxDescArray)
-		goto err_free_tx_0;
+	if (rtl8169_alloc_rx_desc(tp) < 0)
+		goto err_free_rx_1;
 
 	retval = rtl8169_init_ring(tp);
 	if (retval < 0)
@@ -5182,12 +5307,10 @@ static int rtl_open(struct net_device *dev)
 	rtl8169_free_irq(tp);
 err_release_fw_2:
 	rtl_release_firmware(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 err_free_rx_1:
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
-	tp->RxDescArray = NULL;
-err_free_tx_0:
+	rtl8169_free_rx_desc(tp);
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
 	tp->TxDescArray = NULL;
@@ -5352,6 +5475,7 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	unregister_netdev(tp->dev);
 
 	r8169_free_napi(tp);
+	kfree(tp->rx_ring);
 
 	if (tp->dash_type != RTL_DASH_NONE)
 		rtl8168_driver_stop(tp);
@@ -5688,7 +5812,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 txconfig;
 	u32 xid;
 
-	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
+				      R8169_MAX_TX_QUEUES,
+				      R8169_MAX_RX_QUEUES);
+
 	if (!dev)
 		return -ENOMEM;
 
@@ -5873,10 +6000,17 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		return rc;
 
+	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
+			      GFP_KERNEL);
+	if (!tp->rx_ring)
+		return -ENOMEM;
+
 	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
 				   GFP_KERNEL);
-	if (!tp->rtl8169_napi)
+	if (!tp->rtl8169_napi) {
+		kfree(tp->rx_ring);
 		return -ENOMEM;
+	}
 
 	r8169_init_napi(tp);
 
@@ -5913,6 +6047,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_free_napi:
 	r8169_free_napi(tp);
+	kfree(tp->rx_ring);
 	return rc;
 }
 
-- 
2.43.0

