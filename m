Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB472EA75E;
	Mon,  3 Aug 2026 02:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723226; cv=none; b=B3STMon9jXT/GLZ8SDXS+4aWXK0+TaBUDKHjPPpsUEfjf5vtoet/wtMmvgJ55DLEcyidMcex6Mu36THMeEmYpU9zbhvgGIR5E+gkx+jdsBSaPDIPCTRwOtYnvboo0h9iqUUVK1s9ezwvVhbbygiF7I3mDvOIg6U3xdqpsEM5eis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723226; c=relaxed/simple;
	bh=IZRbSgu281bXGM3ZY1WgZIDXfjLw0a/lTiQwv/p86rs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPLMsWjhW0dvdfEXWkFEmSZUk7q4ZO1bxOM88mmI5NI6N95OCwe/cNJRzcPU6AyW3d6xiPRWomm8TDCNmPpFmkmTzVPgHPjnqMjnWYlhuh9eXI4TFs7DiGIwS9HMebIgdYBkzmR17la1j6SuVIRkdznWL2uK2i/hw+a42YQbhR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=eK6jFE+M; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="eK6jFE+M"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6732D9Kt83810915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785723189;
	bh=BBKilrycTFaRGc6D0h0Q2TZUsBIsdjoyQSxI5VNrKF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eK6jFE+MZOiMjXGGIRIqjivV5tTa3oXxb53YKtuMommnKy4aR9sQzV0mtwxyy1JVa
	 AVmH7mhxJOpF1gJO3ziYrNToBDyLP30MO4fJz5mPgYpsX4PJN8efhzRfweoTVwGxQN
	 TUTwDxbkKnHqsAc5UE9681YHjHbTkw51/kAoc1ySgmjOogHHIc/EEo90hXBj6eEvmA
	 OwYGpHMeiI2/tA4vH0L4CQkMXqAFviJdRhf/+/id8mf3ZFEUh8kIBtjY2E/bUwmQE+
	 99DHMO4z/xM4ScP8Xl/d544YVGLaWhv6KWlEOPussZpaq8y/mz4kkmiqHFaE/6mbgh
	 d3NqAmE4Gh/JA==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6732D9Kt83810915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Aug 2026 10:13:09 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Aug 2026 10:13:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 3 Aug 2026 10:13:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 5/7] r8169: add support and enable rss
Date: Mon, 3 Aug 2026 10:13:03 +0800
Message-ID: <20260803021305.488-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260803021305.488-1-javen_xu@realsil.com.cn>
References: <20260803021305.488-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds support and enable rss for RTL8127.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - some changes moved from Patch 2/7

Changes in v3:
 - add struct rtl8169_rss_data. Allocate it dynamically when needed.
 - define rss_key as an u32 array
 - replace some magic bit numbers in rtl8169_set_rss_hash_opt() and
   rtl8125_set_rx_q_num()
 - use union to combine different rx descriptor, refactor struct RxDesc
 - remove dead code from rtl8169_double_check_rss_support()

Changes in v4:
 - rename macro definition, e.g R8127_MAX_IRQ to R8127_MAX_NUM_IRQVEC
 - change hw_supp_indir_tbl_entries type to unsigned int
 - change init_rx_desc_type type to enum
 - remove rtl_check_rss_support(), add helper function
   rtl_hw_support_rss()
 - remove hw_curr_isr_ver, use irq_nvecs to judge whether we should
   enable vector interrupt mapping, use tp->num_rx_ring to judge whether
   we should enable rss
 - remove function rtl8169_double_check_rss_support(), use
   rtl8169_set_rx_ring_num() to set num_rx_ring according to tp->irq_nvecs

Changes in v5:
 - no changes

Changes in v6:
 - change rss_queue_num type from u8 to unsigned int
 - fix rx desc clear in rtl8169_rx_clear() for different desc type
 - clamping num_rx_ring with rounddown_pow_of_two()

Changes in v7:
 - remove unused macro
 - change unfixed type in rtl8169_store_reta

Changes in v8:
 - refill desc->addr when rx_desc reset
 - rtl8169_set_channels fixed in patch 7/7

Changes in v9:
 - remove rtl8169_set_desc_dma_addr, only set desc dma addr for
   RX_DESC_TYPE_RSS desc

Changes in v10:
- Change rss_key to u8 array and write rss_key_reg as u32 values.
   Use get_unaligned_le32() to keep behavior consistent on big-endian
   and little-endian
---
 drivers/net/ethernet/realtek/r8169_main.c | 379 ++++++++++++++++++++--
 1 file changed, 346 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 31f6d0c2e3d1..4e571fcea092 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -88,6 +88,19 @@
 #define R8127_MAX_TX_QUEUES	8
 #define R8169_DEFAULT_RX_QUEUES	1
 #define R8169_MAX_TX_QUEUES	1
+#define R8127_MAX_NUM_IRQVEC	32
+#define R8127_MIN_NUM_IRQVEC	30
+#define R8169_IRQ_DEFAULT	1
+#define RTL_RSS_KEY_SIZE	40
+#define RSS_CPU_NUM_MASK	GENMASK(18, 16)
+#define RSS_HASH_MASK		GENMASK(10, 8)
+#define RTL_MAX_INDIRECTION_TABLE_ENTRIES 128
+#define RXS_RSS_UDP		BIT(27)
+#define RXS_RSS_IPV4		BIT(28)
+#define RXS_RSS_IPV6		BIT(29)
+#define RXS_RSS_TCP		BIT(30)
+#define RXS_RSS_L3_TYPE_MASK	(RXS_RSS_IPV4 | RXS_RSS_IPV6)
+#define RXS_RSS_L4_TYPE_MASK	(RXS_RSS_TCP | RXS_RSS_UDP)
 
 #define OCP_STD_PHY_BASE	0xa400
 
@@ -595,6 +608,20 @@ enum rtl_register_content {
 #define	ISRIMR_LINKCHG	BIT(29)
 #define	ISRIMR_TOK_Q0	BIT(8)
 #define	ISRIMR_ROK_Q0	BIT(0)
+#define RTL_DESC_TYPE_CTRL		0xd8
+#define RSS_KEY_REG			0x4600
+#define RSS_INDIRECTION_TBL_REG		0x4700
+#define RSS_CTRL_TCP_IPV4_SUPP		BIT(0)
+#define RTL_DESC_TYPE_RSS		BIT(1)
+#define RSS_CTRL_IPV4_SUPP		BIT(1)
+#define RSS_CTRL_TCP_IPV6_SUPP		BIT(2)
+#define RSS_CTRL_IPV6_SUPP		BIT(3)
+#define RSS_CTRL_IPV6_EXT_SUPP		BIT(4)
+#define RSS_CTRL_TCP_IPV6_EXT_SUPP	BIT(5)
+#define	RX_RES_RSS			BIT(22)
+#define	RX_RUNT_RSS			BIT(21)
+#define	RX_CRC_RSS			BIT(20)
+#define RTL_RX_Q_NUM_MASK		GENMASK(4, 2)
 };
 
 enum rtl_desc_bit {
@@ -652,6 +679,11 @@ enum rtl_rx_desc_bit {
 #define RxProtoIP	(PID1 | PID0)
 #define RxProtoMask	RxProtoIP
 
+#define	RX_UDPT_DESC_RSS	BIT(19)
+#define	RX_TCPT_DESC_RSS	BIT(18)
+#define	RX_UDPF_DESC_RSS	BIT(16) /* UDP/IP checksum failed */
+#define	RX_TCPF_DESC_RSS	BIT(15) /* TCP/IP checksum failed */
+
 	IPFail		= (1 << 16), /* IP checksum failed */
 	UDPFail		= (1 << 15), /* UDP/IP checksum failed */
 	TCPFail		= (1 << 14), /* TCP/IP checksum failed */
@@ -673,9 +705,27 @@ struct TxDesc {
 };
 
 struct RxDesc {
-	__le32 opts1;
-	__le32 opts2;
-	__le64 addr;
+	union {
+		/* RX_DESC_TYPE_DEFAULT */
+		struct {
+			__le32 opts1;
+			__le32 opts2;
+			__le64 addr;
+		};
+
+		/* RX_DESC_TYPE_RSS */
+		struct {
+			union {
+				__le64 rss_addr;
+				struct {
+					__le32 rss_info;
+					__le32 rss_result;
+				} rss_dword;
+			};
+			__le32 rss_opts2;
+			__le32 rss_opts1;
+		};
+	};
 };
 
 struct ring_info {
@@ -747,6 +797,11 @@ enum rtl_dash_type {
 	RTL_DASH_25_BP,
 };
 
+enum rx_desc_type {
+	RX_DESC_TYPE_DEFAULT,
+	RX_DESC_TYPE_RSS,
+};
+
 struct rtl8169_rx_ring {
 	u32 cur_rx;					/* Index of next Rx pkt. */
 	u32 dirty_rx;					/* Index for recycling. */
@@ -756,6 +811,12 @@ struct rtl8169_rx_ring {
 	struct page *rx_databuff[NUM_RX_DESC];		/* Rx data buffers */
 };
 
+struct rtl8169_rss_data {
+	u8 rss_key[RTL_RSS_KEY_SIZE];
+	u8 rss_indir_tbl[RTL_MAX_INDIRECTION_TABLE_ENTRIES];
+	unsigned int hw_supp_indir_tbl_entries;
+};
+
 struct rtl8169_private {
 	void __iomem *mmio_addr;	/* memory map physical address */
 	struct pci_dev *pci_dev;
@@ -775,7 +836,9 @@ struct rtl8169_private {
 	u16 tx_lpi_timer;
 	u32 irq_mask;
 	unsigned int hw_supp_num_rx_queues;
+	struct rtl8169_rss_data *rss_data;
 	unsigned int irq_nvecs;
+	enum rx_desc_type init_rx_desc_type;
 	struct clk *clk;
 
 	struct {
@@ -1605,6 +1668,11 @@ static bool rtl_dash_is_enabled(struct rtl8169_private *tp)
 	}
 }
 
+static bool rtl_hw_support_rss(struct rtl8169_private *tp)
+{
+	return tp->mac_version == RTL_GIGA_MAC_VER_80;
+}
+
 static enum rtl_dash_type rtl_get_dash_type(struct rtl8169_private *tp)
 {
 	switch (tp->mac_version) {
@@ -1906,9 +1974,20 @@ static inline u32 rtl8169_tx_vlan_tag(struct sk_buff *skb)
 		TxVlanTag | swab16(skb_vlan_tag_get(skb)) : 0x00;
 }
 
-static void rtl8169_rx_vlan_tag(struct RxDesc *desc, struct sk_buff *skb)
+static void rtl8169_rx_vlan_tag(struct rtl8169_private *tp,
+				struct RxDesc *desc,
+				struct sk_buff *skb)
 {
-	u32 opts2 = le32_to_cpu(desc->opts2);
+	u32 opts2;
+
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_RSS:
+		opts2 = le32_to_cpu(desc->rss_opts2);
+		break;
+	default:
+		opts2 = le32_to_cpu(desc->opts2);
+		break;
+	}
 
 	if (opts2 & RxVlanTag)
 		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), swab16(opts2 & 0xffff));
@@ -2736,17 +2815,27 @@ static void rtl_hw_reset(struct rtl8169_private *tp)
 	rtl_loop_wait_low(tp, &rtl_chipcmd_cond, 100, 100);
 }
 
+static void rtl8169_init_rss(struct rtl8169_private *tp)
+{
+	for (int i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++)
+		tp->rss_data->rss_indir_tbl[i] = ethtool_rxfh_indir_default(i, tp->num_rx_rings);
+
+	netdev_rss_key_fill(tp->rss_data->rss_key, RTL_RSS_KEY_SIZE);
+}
+
 static void rtl_setup_rx_params(struct rtl8169_private *tp)
 {
 	tp->num_rx_rings = 1;
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_80:
 		tp->hw_supp_num_rx_queues = R8169_MAX_RX_QUEUES;
+		tp->rss_data->hw_supp_indir_tbl_entries = RTL_MAX_INDIRECTION_TABLE_ENTRIES;
 		break;
 	default:
 		tp->hw_supp_num_rx_queues = R8169_DEFAULT_RX_QUEUES;
 		break;
 	}
+	tp->init_rx_desc_type = RX_DESC_TYPE_DEFAULT;
 }
 
 static void rtl_request_firmware(struct rtl8169_private *tp)
@@ -2871,6 +2960,58 @@ static void rtl_set_rx_max_size(struct rtl8169_private *tp)
 	RTL_W16(tp, RxMaxSize, R8169_RX_BUF_SIZE + 1);
 }
 
+static void rtl8169_store_rss_key(struct rtl8169_private *tp)
+{
+	u8 *rss_key = tp->rss_data->rss_key;
+	const u16 rss_key_reg = RSS_KEY_REG;
+
+	/* Write redirection table to HW */
+	for (int i = 0; i < RTL_RSS_KEY_SIZE; i += sizeof(u32))
+		RTL_W32(tp, rss_key_reg + i, get_unaligned_le32(rss_key + i));
+}
+
+static void rtl8169_store_reta(struct rtl8169_private *tp)
+{
+	u8 *indir_tbl = tp->rss_data->rss_indir_tbl;
+	unsigned int i;
+
+	/* Write redirection table to HW */
+	for (i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i += 4) {
+		u32 reta = (u32)indir_tbl[i] |
+			   (u32)indir_tbl[i + 1] << 8 |
+			   (u32)indir_tbl[i + 2] << 16 |
+			   (u32)indir_tbl[i + 3] << 24;
+		RTL_W32(tp, RSS_INDIRECTION_TBL_REG + i, reta);
+	}
+}
+
+static void rtl8169_set_rss_hash_opt(struct rtl8169_private *tp)
+{
+	u32 rss_ctrl;
+
+	rss_ctrl = FIELD_PREP(RSS_CPU_NUM_MASK, ilog2(tp->num_rx_rings));
+
+	/* Perform hash on these packet types */
+	rss_ctrl |= RSS_CTRL_TCP_IPV4_SUPP
+		 | RSS_CTRL_IPV4_SUPP
+		 | RSS_CTRL_IPV6_SUPP
+		 | RSS_CTRL_IPV6_EXT_SUPP
+		 | RSS_CTRL_TCP_IPV6_SUPP
+		 | RSS_CTRL_TCP_IPV6_EXT_SUPP;
+
+	rss_ctrl |= FIELD_PREP(RSS_HASH_MASK,
+			       ilog2(tp->rss_data->hw_supp_indir_tbl_entries));
+
+	RTL_W32(tp, RSS_CTRL_8125, rss_ctrl);
+}
+
+static void rtl_set_rss_config(struct rtl8169_private *tp)
+{
+	rtl8169_set_rss_hash_opt(tp);
+	rtl8169_store_reta(tp);
+	rtl8169_store_rss_key(tp);
+}
+
 static void rtl_set_rx_tx_desc_registers(struct rtl8169_private *tp)
 {
 	struct rtl8169_rx_ring *ring = &tp->rx_ring[0];
@@ -3937,6 +4078,18 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8125_set_rx_q_num(struct rtl8169_private *tp)
+{
+	u16 rx_q_num;
+	u16 q_ctrl;
+
+	rx_q_num = ilog2(tp->num_rx_rings);
+	q_ctrl = RTL_R16(tp, Q_NUM_CTRL_8125);
+	q_ctrl &= ~RTL_RX_Q_NUM_MASK;
+	q_ctrl |= FIELD_PREP(RTL_RX_Q_NUM_MASK, rx_q_num);
+	RTL_W16(tp, Q_NUM_CTRL_8125, q_ctrl);
+}
+
 static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
 {
 	u8 tmp;
@@ -3976,6 +4129,13 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	    tp->mac_version == RTL_GIGA_MAC_VER_80)
 		RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
 
+	/* enable rx descriptor type v4 and set queue num for rss*/
+	if (tp->num_rx_rings > 1) {
+		rtl8125_set_rx_q_num(tp);
+		RTL_W8(tp, RTL_DESC_TYPE_CTRL,
+		       RTL_R8(tp, RTL_DESC_TYPE_CTRL) | RTL_DESC_TYPE_RSS);
+	}
+
 	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
 		r8168_mac_ocp_modify(tp, 0xe614, 0x0f00, 0x0f00);
 	else if (tp->mac_version == RTL_GIGA_MAC_VER_70)
@@ -4212,6 +4372,12 @@ static void rtl_hw_start(struct  rtl8169_private *tp)
 	rtl_hw_aspm_clkreq_enable(tp, true);
 	rtl_set_rx_max_size(tp);
 	rtl_set_rx_tx_desc_registers(tp);
+	if (rtl_is_8125(tp)) {
+		if (tp->num_rx_rings > 1)
+			rtl_set_rss_config(tp);
+		else
+			RTL_W32(tp, RSS_CTRL_8125, 0x00);
+	}
 	rtl_lock_config_regs(tp);
 
 	rtl_jumbo_config(tp);
@@ -4239,14 +4405,26 @@ static int rtl8169_change_mtu(struct net_device *dev, int new_mtu)
 	return 0;
 }
 
-static void rtl8169_mark_to_asic(struct RxDesc *desc)
+static void rtl8169_mark_to_asic(struct rtl8169_private *tp, struct RxDesc *desc)
 {
-	u32 eor = le32_to_cpu(desc->opts1) & RingEnd;
+	u32 eor;
 
-	desc->opts2 = 0;
-	/* Force memory writes to complete before releasing descriptor */
-	dma_wmb();
-	WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_RSS:
+		eor = le32_to_cpu(desc->rss_opts1) & RingEnd;
+		desc->rss_opts2 = cpu_to_le32(0);
+		/* Force memory writes to complete before releasing descriptor */
+		dma_wmb();
+		WRITE_ONCE(desc->rss_opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+		break;
+	default:
+		eor = le32_to_cpu(desc->opts1) & RingEnd;
+		desc->opts2 = cpu_to_le32(0);
+		/* Force memory writes to complete before releasing descriptor */
+		dma_wmb();
+		WRITE_ONCE(desc->opts1, cpu_to_le32(DescOwn | eor | R8169_RX_BUF_SIZE));
+		break;
+	}
 }
 
 static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
@@ -4269,9 +4447,12 @@ static struct page *rtl8169_alloc_rx_data(struct rtl8169_private *tp,
 		return NULL;
 	}
 
-	desc->addr = cpu_to_le64(mapping);
 	ring->rx_desc_phy_addr[index] = mapping;
-	rtl8169_mark_to_asic(desc);
+	if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
+		desc->rss_addr = cpu_to_le64(mapping);
+	else
+		desc->addr = cpu_to_le64(mapping);
+	rtl8169_mark_to_asic(tp, desc);
 
 	return data;
 }
@@ -4287,8 +4468,25 @@ static void rtl8169_rx_clear(struct rtl8169_private *tp, struct rtl8169_rx_ring
 		__free_pages(ring->rx_databuff[i], get_order(R8169_RX_BUF_SIZE));
 		ring->rx_databuff[i] = NULL;
 		ring->rx_desc_phy_addr[i] = 0;
-		ring->rx_desc_array[i].addr = 0;
-		ring->rx_desc_array[i].opts1 = 0;
+		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS) {
+			ring->rx_desc_array[i].rss_addr = 0;
+			ring->rx_desc_array[i].rss_opts1 = 0;
+		} else {
+			ring->rx_desc_array[i].addr = 0;
+			ring->rx_desc_array[i].opts1 = 0;
+		}
+	}
+}
+
+static void rtl8169_mark_as_last_descriptor(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_RSS:
+		desc->rss_opts1 |= cpu_to_le32(RingEnd);
+		break;
+	default:
+		desc->opts1 |= cpu_to_le32(RingEnd);
+		break;
 	}
 }
 
@@ -4308,7 +4506,7 @@ static int rtl8169_rx_fill(struct rtl8169_private *tp, struct rtl8169_rx_ring *r
 	}
 
 	/* mark as last descriptor in the ring */
-	ring->rx_desc_array[NUM_RX_DESC - 1].opts1 |= cpu_to_le32(RingEnd);
+	rtl8169_mark_as_last_descriptor(tp, &ring->rx_desc_array[NUM_RX_DESC - 1]);
 
 	return 0;
 }
@@ -4463,8 +4661,13 @@ static void rtl8169_rx_desc_reset(struct rtl8169_private *tp)
 	for (int i = 0; i < tp->num_rx_rings; i++) {
 		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
 
-		for (int j = 0; j < NUM_RX_DESC; j++)
-			rtl8169_mark_to_asic(ring->rx_desc_array + j);
+		for (int j = 0; j < NUM_RX_DESC; j++) {
+			dma_addr_t phy_addr = ring->rx_desc_phy_addr[j];
+
+			if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
+				ring->rx_desc_array[j].rss_addr = cpu_to_le64(phy_addr);
+			rtl8169_mark_to_asic(tp, ring->rx_desc_array + j);
+		}
 	}
 }
 
@@ -4920,27 +5123,87 @@ static inline int rtl8169_fragmented_frame(u32 status)
 	return (status & (FirstFrag | LastFrag)) != (FirstFrag | LastFrag);
 }
 
-static inline void rtl8169_rx_csum(struct sk_buff *skb,
+static inline void rtl8169_rx_hash(struct rtl8169_private *tp,
+				   struct RxDesc *desc,
+				   struct sk_buff *skb)
+{
+	u32 rss_header_info;
+	u32 hash_val;
+
+	if (!(tp->dev->features & NETIF_F_RXHASH))
+		return;
+
+	rss_header_info = le32_to_cpu(desc->rss_dword.rss_info);
+
+	if (!(rss_header_info & RXS_RSS_L3_TYPE_MASK))
+		return;
+
+	hash_val = le32_to_cpu(desc->rss_dword.rss_result);
+
+	skb_set_hash(skb, hash_val,
+		     (RXS_RSS_L4_TYPE_MASK & rss_header_info) ?
+		     PKT_HASH_TYPE_L4 : PKT_HASH_TYPE_L3);
+}
+
+static inline void rtl8169_rx_csum(struct rtl8169_private *tp,
+				   struct sk_buff *skb,
 				   u32 opts1)
 {
-	u32 status = opts1 & (RxProtoMask | RxCSFailMask);
+	bool csum_ok = false;
+
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_RSS:
+		if (((opts1 & RX_TCPT_DESC_RSS) && !(opts1 & RX_TCPF_DESC_RSS)) ||
+		    ((opts1 & RX_UDPT_DESC_RSS) && !(opts1 & RX_UDPF_DESC_RSS)))
+			csum_ok = true;
+		break;
+	default:
+		u32 status = opts1 & (RxProtoMask | RxCSFailMask);
 
-	if (status == RxProtoTCP || status == RxProtoUDP)
+		if (status == RxProtoTCP || status == RxProtoUDP)
+			csum_ok = true;
+		break;
+	}
+
+	if (csum_ok)
 		skb->ip_summed = CHECKSUM_UNNECESSARY;
 	else
 		skb_checksum_none_assert(skb);
 }
 
+static __le32 rtl8169_rx_desc_opts1(struct rtl8169_private *tp, struct RxDesc *desc)
+{
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_RSS:
+		return READ_ONCE(desc->rss_opts1);
+	default:
+		return READ_ONCE(desc->opts1);
+	}
+}
+
 static bool rtl8169_check_rx_desc_error(struct net_device *dev,
 					struct rtl8169_private *tp,
 					u32 status)
 {
-	if (unlikely(status & RxRES)) {
-		if (status & (RxRWT | RxRUNT))
-			dev->stats.rx_length_errors++;
-		if (status & RxCRC)
-			dev->stats.rx_crc_errors++;
-		return true;
+	switch (tp->init_rx_desc_type) {
+	case RX_DESC_TYPE_RSS:
+		if (unlikely(status & RX_RES_RSS)) {
+			if (status & RX_RUNT_RSS)
+				dev->stats.rx_length_errors++;
+			if (status & RX_CRC_RSS)
+				dev->stats.rx_crc_errors++;
+			return true;
+		}
+		break;
+	default:
+		if (unlikely(status & RxRES)) {
+			if (status & (RxRWT | RxRUNT))
+				dev->stats.rx_length_errors++;
+			if (status & RxCRC)
+				dev->stats.rx_crc_errors++;
+			return true;
+		}
+		break;
 	}
 	return false;
 }
@@ -4959,7 +5222,7 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		dma_addr_t addr;
 		u32 status;
 
-		status = le32_to_cpu(READ_ONCE(desc->opts1));
+		status = le32_to_cpu(rtl8169_rx_desc_opts1(tp, desc));
 		if (status & DescOwn)
 			break;
 
@@ -4977,7 +5240,8 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 
 			if (!(dev->features & NETIF_F_RXALL))
 				goto release_descriptor;
-			else if (status & RxRWT || !(status & (RxRUNT | RxCRC)))
+			if ((status & RxRWT || !(status & (RxRUNT | RxCRC))) &&
+			    tp->init_rx_desc_type == RX_DESC_TYPE_DEFAULT)
 				goto release_descriptor;
 		}
 
@@ -5010,10 +5274,12 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		skb->len = pkt_size;
 		dma_sync_single_for_device(d, addr, pkt_size, DMA_FROM_DEVICE);
 
-		rtl8169_rx_csum(skb, status);
+		if (tp->num_rx_rings > 1)
+			rtl8169_rx_hash(tp, desc, skb);
+		rtl8169_rx_csum(tp, skb, status);
 		skb->protocol = eth_type_trans(skb, dev);
 
-		rtl8169_rx_vlan_tag(desc, skb);
+		rtl8169_rx_vlan_tag(tp, desc, skb);
 
 		if (skb->pkt_type == PACKET_MULTICAST)
 			dev->stats.multicast++;
@@ -5022,7 +5288,9 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 
 		dev_sw_netstats_rx_add(dev, pkt_size);
 release_descriptor:
-		rtl8169_mark_to_asic(desc);
+		if (tp->init_rx_desc_type == RX_DESC_TYPE_RSS)
+			desc->rss_addr = cpu_to_le64(ring->rx_desc_phy_addr[entry]);
+		rtl8169_mark_to_asic(tp, desc);
 	}
 
 	return count;
@@ -5594,6 +5862,32 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
 	}
 }
 
+static int get_max_irq_nvecs(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		return R8127_MAX_NUM_IRQVEC;
+	return R8169_IRQ_DEFAULT;
+}
+
+static int get_min_irq_nvecs(struct rtl8169_private *tp)
+{
+	if (tp->mac_version == RTL_GIGA_MAC_VER_80)
+		return R8127_MIN_NUM_IRQVEC;
+	return R8169_IRQ_DEFAULT;
+}
+
+static void rtl8169_set_rx_ring_num(struct rtl8169_private *tp)
+{
+	if (tp->irq_nvecs >= get_min_irq_nvecs(tp)) {
+		unsigned int rss_queue_num = netif_get_num_default_rss_queues();
+
+		tp->num_rx_rings = rounddown_pow_of_two(min(rss_queue_num,
+							    tp->hw_supp_num_rx_queues));
+		if (tp->num_rx_rings >= 2)
+			tp->init_rx_desc_type = RX_DESC_TYPE_RSS;
+	}
+}
+
 static int rtl_alloc_irq(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -5614,7 +5908,10 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		break;
 	}
 
-	nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
+	nvecs = pci_alloc_irq_vectors(pdev, get_min_irq_nvecs(tp), get_max_irq_nvecs(tp), flags);
+
+	if (nvecs < 0)
+		nvecs = pci_alloc_irq_vectors(pdev, 1, 1, flags);
 
 	if (nvecs < 0)
 		return nvecs;
@@ -6038,6 +6335,12 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
+	if (rtl_hw_support_rss(tp)) {
+		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data), GFP_KERNEL);
+		if (!tp->rss_data)
+			return -ENOMEM;
+	}
+
 	tp->cp_cmd = RTL_R16(tp, CPlusCmd) & CPCMD_MASK;
 
 	if (sizeof(dma_addr_t) > 4 && tp->mac_version >= RTL_GIGA_MAC_VER_18 &&
@@ -6058,6 +6361,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc < 0)
 		return dev_err_probe(&pdev->dev, rc, "Can't allocate interrupt\n");
 
+	rtl8169_set_rx_ring_num(tp);
+
+	if (rtl_hw_support_rss(tp))
+		rtl8169_init_rss(tp);
+
 	INIT_WORK(&tp->wk.work, rtl_task);
 	disable_work(&tp->wk.work);
 
@@ -6070,6 +6378,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	dev->vlan_features = NETIF_F_SG | NETIF_F_IP_CSUM | NETIF_F_TSO;
 	dev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
+	if (rtl_hw_support_rss(tp) && tp->num_rx_rings > 1) {
+		dev->hw_features |= NETIF_F_RXHASH;
+		dev->features |= NETIF_F_RXHASH;
+	}
+
 	/*
 	 * Pretend we are using VLANs; This bypasses a nasty bug where
 	 * Interrupts stop flowing on high load on 8110SCd controllers.
-- 
2.43.0

