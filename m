Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF32264D9;
	Mon, 31 Aug 2026 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154832; cv=none; b=dyP8kORRzZKLEbYT8mFtOxjx4+6pCsTi0lFaFwz9XGYeSbxPwu/HdMruSEC2SnDT9odSGRH/UpemMdKlBZLo5TiV9ntzS17bULhXr4ZqKq4TWTO++0UK4jRn2viPkeZ6Xz7BQd0lv0YYJGG+BDrN9tdZexv8g1uZgfUWK4fijPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154832; c=relaxed/simple;
	bh=U9TH/p64s9hxhTROKf1YT1iYX6Oq/GRqldV9XsPHqCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=has4sOk1SsuzspJChpXsQWnUwE/K5DYmD9RG28bs8tRN9VSi3gNjycSONNccHf4oA6mNx/D0pPhHBcZcnUt7WmSoDtdbVaFgY8RZ/2nmj12WGCgw2h3LHFvQL7cBY2AB3u9/Aur5n+6JPdIGkgu41aXSvr68fVmQTZEMRlNpMF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=pMK4vIWw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="pMK4vIWw"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 67V5djCfB479611, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1788154785;
	bh=Bw3kjEKz3sBZxS8NHrSNZTFDwMwib3xSxSrKrVnmYtg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pMK4vIWw/5lF1rkrbcDsMqpDFsUHTYsKEt3fYywPSsWECrzYoQs51T6Vr7mgs5GEd
	 WtQ5LEHff5zVc/SMmW7B5no5g0H12owS1omhKJLSpwttV+UZsiXh5BeBCkILNWeA8Y
	 7B/aK530nKbeI1M5EEjYaXP4gf/4UpBUPvMDuv+sIQVRB1CaQora34kjKcczI21IJc
	 7O8w4mcVVshUPu+kq+oHkC9ksVzAby9V10nTO87xXXFchNX7Ndbpl/ZYjfugqsV+kP
	 EjWt5yYcEI5kTqIoUFN4rEZsgDOklJ/hyy57C89IsJzOp3baY34lLi2jOF3Y/utSf9
	 CJCRGXL7J8yBg==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 67V5djCfB479611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 31 Aug 2026 13:39:45 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 31 Aug 2026 13:39:44 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 31 Aug 2026 13:39:44 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v12 4/7] r8169: enable new interrupt mapping
Date: Mon, 31 Aug 2026 13:39:37 +0800
Message-ID: <20260831053940.620-5-javen_xu@realsil.com.cn>
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

This patch enables new interrupt mapping for RTL8127 and add error pkts
counter per ring.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - no changes

Changes in v7:
 - no changes

Changes in v8:
 - no changes

Changes in v9:
 - no changes

Changes in v10:
 - no changes

Changes in v11:
 - add error pkts counter per ring

Changes in v12:
 - drop unrelated change in rtl8169_init_ring()
---
 drivers/net/ethernet/realtek/r8169_main.c | 78 +++++++++++++++++++----
 1 file changed, 67 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ca6be1e38408..1798a98b860b 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -29,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/ipv6.h>
 #include <linux/unaligned.h>
+#include <linux/u64_stats_sync.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
 #include <net/phy/realtek_phy.h>
@@ -754,6 +755,15 @@ struct rtl8169_rx_ring {
 	dma_addr_t rx_desc_phy_addr[NUM_RX_DESC];
 	dma_addr_t rx_phy_addr;
 	struct page *rx_databuff[NUM_RX_DESC];
+
+	struct {
+		u64 rx_errors;
+		u64 rx_dropped;
+		u64 rx_length_errors;
+		u64 rx_crc_errors;
+		u64 multicast;
+		struct u64_stats_sync syncp;
+	} stats;
 };
 
 struct rtl8169_private {
@@ -3939,6 +3949,15 @@ DECLARE_RTL_COND(rtl_mac_ocp_e00e_cond)
 	return r8168_mac_ocp_read(tp, 0xe00e) & BIT(13);
 }
 
+static void rtl8169_hw_enable_vec_mapping(struct rtl8169_private *tp)
+{
+	u8 tmp;
+
+	tmp = RTL_R8(tp, INT_CFG0_8125);
+	tmp |= INT_CFG0_ENABLE_8125;
+	RTL_W8(tp, INT_CFG0_8125, tmp);
+}
+
 static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 {
 	rtl_pcie_state_l2l3_disable(tp);
@@ -3947,6 +3966,9 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
 	RTL_W32(tp, RSS_CTRL_8125, 0);
 	RTL_W16(tp, Q_NUM_CTRL_8125, 0);
 
+	if (tp->irq_nvecs > 1)
+		rtl8169_hw_enable_vec_mapping(tp);
+
 	/* disable UPS */
 	r8168_mac_ocp_modify(tp, 0xd40a, 0x0010, 0x0000);
 
@@ -4926,15 +4948,16 @@ static inline void rtl8169_rx_csum(struct sk_buff *skb,
 		skb_checksum_none_assert(skb);
 }
 
-static bool rtl8169_check_rx_desc_error(struct net_device *dev,
-					struct rtl8169_private *tp,
+static bool rtl8169_check_rx_desc_error(struct rtl8169_rx_ring *ring,
 					u32 status)
 {
 	if (unlikely(status & RxRES)) {
+		u64_stats_update_begin(&ring->stats.syncp);
 		if (status & (RxRWT | RxRUNT))
-			dev->stats.rx_length_errors++;
+			ring->stats.rx_length_errors++;
 		if (status & RxCRC)
-			dev->stats.rx_crc_errors++;
+			ring->stats.rx_crc_errors++;
+		u64_stats_update_end(&ring->stats.syncp);
 		return true;
 	}
 	return false;
@@ -4965,11 +4988,13 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		 */
 		dma_rmb();
 
-		if (rtl8169_check_rx_desc_error(dev, tp, status)) {
+		if (rtl8169_check_rx_desc_error(ring, status)) {
 			if (net_ratelimit())
 				netdev_warn(dev, "Rx ERROR. status = %08x\n",
 					    status);
-			dev->stats.rx_errors++;
+			u64_stats_update_begin(&ring->stats.syncp);
+			ring->stats.rx_errors++;
+			u64_stats_update_end(&ring->stats.syncp);
 
 			if (!(dev->features & NETIF_F_RXALL))
 				goto release_descriptor;
@@ -4985,14 +5010,18 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 		 * They are seen as a symptom of over-mtu sized frames.
 		 */
 		if (unlikely(rtl8169_fragmented_frame(status))) {
-			dev->stats.rx_dropped++;
-			dev->stats.rx_length_errors++;
+			u64_stats_update_begin(&ring->stats.syncp);
+			ring->stats.rx_dropped++;
+			ring->stats.rx_length_errors++;
+			u64_stats_update_end(&ring->stats.syncp);
 			goto release_descriptor;
 		}
 
 		skb = napi_alloc_skb(napi, pkt_size);
 		if (unlikely(!skb)) {
-			dev->stats.rx_dropped++;
+			u64_stats_update_begin(&ring->stats.syncp);
+			ring->stats.rx_dropped++;
+			u64_stats_update_end(&ring->stats.syncp);
 			goto release_descriptor;
 		}
 
@@ -5011,8 +5040,11 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 
 		rtl8169_rx_vlan_tag(desc, skb);
 
-		if (skb->pkt_type == PACKET_MULTICAST)
-			dev->stats.multicast++;
+		if (skb->pkt_type == PACKET_MULTICAST) {
+			u64_stats_update_begin(&ring->stats.syncp);
+			ring->stats.multicast++;
+			u64_stats_update_end(&ring->stats.syncp);
+		}
 
 		napi_gro_receive(napi, skb);
 
@@ -5431,6 +5463,27 @@ rtl8169_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	netdev_stats_to_stats64(stats, &dev->stats);
 	dev_fetch_sw_netstats(stats, dev->tstats);
 
+	for (int i = 0; i < tp->num_rx_rings; i++) {
+		u64 errors, dropped, length_errors, crc_errors, multicast;
+		struct rtl8169_rx_ring *ring = &tp->rx_ring[i];
+		unsigned int start;
+
+		do {
+			start = u64_stats_fetch_begin(&ring->stats.syncp);
+			errors = ring->stats.rx_errors;
+			dropped = ring->stats.rx_dropped;
+			length_errors = ring->stats.rx_length_errors;
+			crc_errors = ring->stats.rx_crc_errors;
+			multicast = ring->stats.multicast;
+		} while (u64_stats_fetch_retry(&ring->stats.syncp, start));
+
+		stats->rx_errors += errors;
+		stats->rx_dropped += dropped;
+		stats->rx_length_errors += length_errors;
+		stats->rx_crc_errors += crc_errors;
+		stats->multicast += multicast;
+	}
+
 	/*
 	 * Fetch additional counter values missing in stats collected by driver
 	 * from tally counters.
@@ -6169,6 +6222,9 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!tp->rx_ring)
 		return -ENOMEM;
 
+	for (int i = 0; i < tp->num_rx_rings; i++)
+		u64_stats_init(&tp->rx_ring[i].stats.syncp);
+
 	tp->rtl8169_napi = kcalloc(tp->irq_nvecs, sizeof(struct napi_struct),
 				   GFP_KERNEL);
 	if (!tp->rtl8169_napi) {
-- 
2.43.0

