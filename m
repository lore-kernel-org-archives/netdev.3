Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE5730D3E8;
	Thu,  8 Oct 2026 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442993; cv=none; b=OYdDrY2pOJEL2TI3H5HpDQPYdWSsCrCl3axRCrfmD/njdhxusjU2UjIHWeSA8x2sfOypG0wXe8sMHcLu73OTERVwBMm5shFJio2uuptrH/TZ/nmvQhpCJrIN3d67y+r/SL7A1xYfqfNGRIOxG5IA2LA7dfeAk5WP5cAmUBvLE1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442993; c=relaxed/simple;
	bh=I1w1aSojoILAI0+0Js+KK/ifdllcJeAkr8Yw3btrHlA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqSt9qKYOvyKD0YYA4FF3H6+Gtlhyf6AZzjvKtLlFbg3f8KZGFvG2thioXsmP8DlVSt6sfn/CzAWJTMg43pS4BfnpQ7ml+SRkjr6mQv1NSi9GtC2pMuRJ1qluXJDeOqlNm2IwqXox/Owk37wIMuYo5UbPD2IwEMSBTf18s0CxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=SaLnSBdN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="SaLnSBdN"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6986vQqrD281931, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1791442646;
	bh=y5oTRhB51Yt1LUIQsLvK+TTDNw3JnTL4YylonWs6lmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SaLnSBdNskPr4OhJEsi3fR3HvzNnYRic8/fgBWr5XiQjdf9NBC13rFoIOJvp5SVPG
	 cfnR9U9FPzsZvhqv9CJWbov/MMeQ8WivIhmX8ISrVNLqUwZan8M6SmwqR/OINcyf0A
	 SZmwNe8wBQeamA6svhO8TtB25zsMasgk5wtSwfZe0Xm/WK9yUXZGtpGzDuEbvMN5vu
	 dCnWcDvpA69Jpg1Xl1+hNoLB0oMBGKxIGPQq9zgBqwLjnBz5KRs74oW1tHmUiSxrdA
	 O5894sIZjB+BA9pF6KlFAegh868ZeDesZnnhEM8lf2uEng7E287tCyYY3LzddkPvgd
	 ckJSZq7BTwk0Q==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6986vQqrD281931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 14:57:26 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 14:57:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 14:57:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux@armlinux.org.uk>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v16 2/7] r8169: refactor RX path to prepare for multi-queue
Date: Thu, 8 Oct 2026 14:57:17 +0800
Message-ID: <20261008065722.1026-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261008065722.1026-1-javen_xu@realsil.com.cn>
References: <20261008065722.1026-1-javen_xu@realsil.com.cn>
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
The original DMA address of rx buffer is read back directly from
desc->addr. But when we enable rss, desc->addr will be overwritten. So
this patch introduces a array to cache the DMA address of rx buffers
which we name it as rx_buf_dma_addr.
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

Changes in v12:
 - no changes

Changes in v13:
 - remove unused dirty_rx

Changes in v14:
 - REvert R8169_RX_RING_BYTES padding changes. It will be split into a
   bugfix patch.
 - Fix phylink memory in rtl_init_one() by implementing a proper goto
   unwind laber (err_destory_phylink) for memory allocation failures.

Changes in v15:
 - no changes

Changes in v16:
 - modify commit message
 - delete blank line
 - correct misspelled label err_destory_phylink
 - rename rx_desc_phy_addr to rx_buf_dma_addr
---
 drivers/net/ethernet/realtek/r8169_main.c | 240 +++++++++++++++++-----
 1 file changed, 183 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3afb9a4b1aff..e88d512cc3a5 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -77,6 +77,9 @@
 #define R8169_RX_RING_BYTES	(NUM_RX_DESC * sizeof(struct RxDesc))
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
+#define R8169_MAX_RX_QUEUES	8
+#define R8169_DEFAULT_RX_QUEUES	1
+#define R8169_MAX_TX_QUEUES	1
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -463,6 +466,7 @@ enum rtl8125_registers {
 	TxPoll_8125		= 0x90,
 	LEDSEL3			= 0x96,
 	MAC0_BKP		= 0x19e0,
+	RDSAR_Q1_LOW		= 0x4000,
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
@@ -750,6 +754,14 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+struct rtl8169_rx_ring {
+	u32 cur_rx;
+	struct RxDesc *rx_desc_array;
+	dma_addr_t rx_buf_dma_addr[NUM_RX_DESC];
+	dma_addr_t rx_phy_addr;
+	struct page *rx_databuff[NUM_RX_DESC];
+};
+
 enum rtl_sfp_mode {
 	RTL_SFP_NONE,
 	RTL_SFP_8168_AF,
@@ -764,20 +776,18 @@ struct rtl8169_private {
 	enum mac_version mac_version;
 	enum rtl_dash_type dash_type;
 	enum rtl_sfp_mode sfp_mode;
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
 	int speed;
@@ -2718,9 +2728,25 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
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
+		ring->cur_rx = 0;
+	}
 }
 
 static void rtl_jumbo_config(struct rtl8169_private *tp)
@@ -2773,6 +2799,14 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
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
@@ -2899,6 +2933,8 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 
 static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 {
+	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
+
 	/*
 	 * Magic spell: some iop3xx ARM board needs the TxDescAddrHigh
 	 * register to be written before TxDescAddrLow to work.
@@ -2906,8 +2942,18 @@ static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
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
@@ -4330,8 +4376,9 @@ static void rtl8169_mark_to_asic(struct RxDesc *desc)
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
-					  struct RxDesc *desc)
+					  struct rtl8169_rx_ring *ring, unsigned int index)
 {
+	struct RxDesc *desc = ring->rx_desc_array + index;
 	struct device *d = tp_to_dev(tp);
 	int node = dev_to_node(d);
 	dma_addr_t mapping;
@@ -4349,55 +4396,107 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 	}
 
 	desc->addr = cpu_to_le64(mapping);
+	ring->rx_buf_dma_addr[index] = mapping;
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
+			       ring->rx_buf_dma_addr[i],
 			       R8169_RX_BUF_SIZE, DMA_FROM_DEVICE);
-		__free_pages(tp->Rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
-		tp->Rx_databuff[i] = NULL;
-		tp->RxDescArray[i].addr = 0;
-		tp->RxDescArray[i].opts1 = 0;
+		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
+		ring->rx_databuff[i] = NULL;
+		ring->rx_buf_dma_addr[i] = 0;
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
@@ -4486,16 +4585,23 @@ static void rtl8169_cleanup(struct rtl8169_private *tp)
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
@@ -4951,15 +5057,30 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb, u32 opts1)
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
@@ -4975,15 +5096,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
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
@@ -5010,8 +5127,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 			goto release_descriptor;
 		}
 
-		addr = le64_to_cpu(desc->addr);
-		rx_buf = page_address(tp->Rx_databuff[entry]);
+		addr = ring->rx_buf_dma_addr[entry];
+		rx_buf = page_address(ring->rx_databuff[entry]);
 
 		dma_sync_single_for_cpu(d, addr, pkt_size, DMA_FROM_DEVICE);
 		prefetch(rx_buf);
@@ -5155,7 +5272,8 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 
 	rtl_tx(dev, tp, budget);
 
-	work_done = rtl_rx(dev, tp, budget, napi);
+	/* rtl8169_poll() is used only when there is a single RX ring. */
+	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
 
 	if (work_done < budget && napi_complete_done(napi, work_done))
 		rtl_irq_enable(tp);
@@ -5255,18 +5373,17 @@ static int rtl8169_close(struct net_device *dev)
 	phylink_stop(tp->phylink);
 	netif_stop_queue(dev);
 	rtl8169_down(tp);
-	rtl8169_rx_clear(tp);
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
 
 	rtl8169_free_irq(tp);
 
 	phylink_disconnect_phy(tp->phylink);
 
-	dma_free_coherent(&pdev->dev, R8169_RX_RING_BYTES, tp->RxDescArray,
-			  tp->RxPhyAddr);
 	dma_free_coherent(&pdev->dev, R8169_TX_RING_BYTES, tp->TxDescArray,
 			  tp->TxPhyAddr);
 	tp->TxDescArray = NULL;
-	tp->RxDescArray = NULL;
+	rtl8169_free_rx_desc(tp);
 
 	pm_runtime_put_sync(&pdev->dev);
 
@@ -5300,10 +5417,8 @@ static int rtl_open(struct net_device *dev)
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
@@ -5333,12 +5448,10 @@ static int rtl_open(struct net_device *dev)
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
@@ -5505,6 +5618,7 @@ static void rtl_remove_one(struct pci_dev *pdev)
 
 	unregister_netdev(tp->dev);
 	r8169_free_napi(tp);
+	kfree(tp->rx_ring);
 	phylink_destroy(tp->phylink);
 
 	if (tp->dash_type != RTL_DASH_NONE)
@@ -6113,7 +6227,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	u32 txconfig;
 	u32 xid;
 
-	dev = devm_alloc_etherdev(&pdev->dev, sizeof (*tp));
+	dev = devm_alloc_etherdev_mqs(&pdev->dev, sizeof(*tp),
+				      R8169_MAX_TX_QUEUES,
+				      R8169_MAX_RX_QUEUES);
+
 	if (!dev)
 		return -ENOMEM;
 
@@ -6302,20 +6419,25 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		}
 	}
 
+	tp->rx_ring = kcalloc(tp->num_rx_rings, sizeof(struct rtl8169_rx_ring),
+			      GFP_KERNEL);
+	if (!tp->rx_ring) {
+		rc = -ENOMEM;
+		goto err_destroy_phylink;
+	}
+
 	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
 				   GFP_KERNEL);
 	if (!tp->rtl8169_napi) {
-		phylink_destroy(tp->phylink);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto err_free_rx_ring;
 	}
 
 	r8169_init_napi(tp);
 
 	rc = register_netdev(dev);
-	if (rc) {
-		phylink_destroy(tp->phylink);
+	if (rc)
 		goto err_free_napi;
-	}
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
 		if (rtl_is_8125(tp))
@@ -6349,6 +6471,10 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_free_napi:
 	r8169_free_napi(tp);
+err_free_rx_ring:
+	kfree(tp->rx_ring);
+err_destroy_phylink:
+	phylink_destroy(tp->phylink);
 	return rc;
 }
 
-- 
2.43.0

