Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B228506C;
	Mon, 14 Sep 2026 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789349632; cv=none; b=goclOXJPEsubLWhQMrcTP0EuPkif1J/41IHfYoBxTxW9aGU+HlSNYrd1Q9uAOwfr2E65BH59R/qC5zbZuczx1y4GCUzXcQUmXo0LxX2BhrSqJUuKnfp20CsspRDTJgPuKIqJ2IlV++VjhnKukX3USxOwjX1LnVKl5kTH/1NRjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789349632; c=relaxed/simple;
	bh=hlN6gB5OiSzq7ZHX7cFipewaLNQQf7xUH9riAswTNyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tuV7aL4th8ybmPqE/IZ5gT0RtfDlNXA9xHweLEAxOa5QLYC/VLXn84Gamcu2oYCAuYmRuqBbdvXOaRtQPBy57B0oxR214YsXU//awv6rtU7bgwvlRCv1woVAgcxbAwgp8u9sk6u/r1zu4x+z33N7q0FHdSLudqmw2S2Yu1nsfQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1789349565tef095d9e
X-QQ-Originating-IP: OOt3Mii0JZCU067Qr/obAu72NR10w4nNbXkI9z34o9w=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 14 Sep 2026 09:32:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9239538883031016649
EX-QQ-RecipientCnt: 11
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next v12 4/5] net: rnpgbe: Add receive mode support
Date: Mon, 14 Sep 2026 09:32:40 +0800
Message-ID: <F84A9FD95CFA6075+20260914013240.2262671-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com>
References: <64BE41C2D2C0836A+20260914013019.2262317-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OJo/U4CJ+9g1ZpuSaYUNKdh9Br8UhPMwUrh/NfPTyacdWCwmshY8pISH
	jEJsVLzmGsA6ytk2n92O5jBq2GtW/RqOoK93dSglEcZ9f4FyWVRd3MbkT1myYW/rINvg2UW
	TgoorGgjmneDmv8gS5M8nvou+ZktIYjuVZPV1wtyNaJs8AQFmrTXqWtxwGqYUJch01YvUQZ
	RZb1t+ln412hl/D6+t7vFlBzj5zdksqzr8rD3L5k6syzaUWQRS1TYdncIhpTJDgrdSsT3sh
	qDYIeJQOmVXPgi2hueWtiNRcBd92J3r/EKnQiTzuLH81HmsAcXJvJNrEz8nyKuRlHwyOi0M
	OJCdQ+1YdmRhIV8mlmyqUG9X0nBh1jr2cATFb5AbSPhG7Vz9fcOmKqXtcWWhx3HT05CvsUr
	TXKK+L1MAK7z3IMNZUZPatx1jkhcC6iEnTkXSs6VXESt6UzXSud7niuLwVSVtYYK/96O+sa
	QVymrqXrsD0WcnTWBFNJwXo86Ql1HZumo5YfbB9xHu7eOL/0TaV5COQKW1lJgu4waQ5Igt2
	daD2Zvi37zC3HLCX7r2FsVjFbg9vHxixtHImRTmJX+KpoKUI7XQcq9NdJrkdx76kK5NeRf+
	MsZ36720S7pWh2/vFAINjxynqhGFt+TUARjDq0J56zrJS/TQQaTtHQ4y3OQSpKpp8hMQUWk
	edUd54ZpMSRzP2XClt6XADZ/AiEyWUUDBhZR/R0oZ3L1RL9Jjdi1ptfuUFGsSklyYN+4Anq
	PmH+X4R2h5cqB3EkXeu8sKPzJua+7yZpUAjmCmXE8qFiNdg6fxguZffs7sGeXNA7MRvYA/m
	LP11xDJh8O7iZmBOyWIAd1eULwAWZ7Un9UdaHGS590HnQCcUyKNUU/TeAYPgQDtKKerjHsh
	ck6MWGrDmEfWPKcVTb04fZDUr0jH0BEvLnN6MqybtHiimK9LrVgB3p3PZYbLgZr/zhMIrju
	ysx5iDFa1pFhltU6OWLluBIAZjFYPajLdG+CCStfGFNuq2uxC3gE+rdoAp6VmAq7tvg4SBv
	7cy+O7ROqhEdMeP27+NjAXQm8+CCmbB2qMumO+hwiuFkQ7aoE79Ae++E+Int5LgUB9Vtir8
	w+hZWKJpozK7iNn0tVvIyvP8j+6eM1O+lRrwzfPGoZP
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Add chip-level receive filtering and the ndo_set_rx_mode callback.

Program the primary and additional unicast addresses into the available
RAR entries, and use the 4096-bit multicast hash table for multicast
addresses. Advertise RAR-based secondary unicast filtering to the
networking core, so it does not force promiscuous mode for a non-empty
secondary unicast list. Fall back to accepting all unicast addresses if
the RAR table is exhausted, and handle IFF_PROMISC and IFF_ALLMULTI
through the chip-level filter control register.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 75 +++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 15 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 12 ++-
 4 files changed, 100 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index f402585e60a5..e85e26319a4d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -232,6 +232,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+void rnpgbe_set_rx_mode(struct net_device *netdev);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 291e77d573fe..4e2835b71f32 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -149,3 +149,78 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 
 	return 0;
 }
+
+static void rnpgbe_set_rar(struct mucse_hw *hw, u32 index, const u8 *addr)
+{
+	u32 rar_low, rar_high;
+
+	/* The RAR stores the Ethernet address in reverse byte order. */
+	rar_low = (u32)addr[5] | ((u32)addr[4] << 8) |
+		  ((u32)addr[3] << 16) | ((u32)addr[2] << 24);
+	rar_high = (u32)addr[1] | ((u32)addr[0] << 8) |
+		   RNPGBE_RX_RAR_VALID;
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index),
+		      rar_high & ~RNPGBE_RX_RAR_VALID);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), rar_low);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), rar_high);
+}
+
+static void rnpgbe_clear_rar(struct mucse_hw *hw, u32 index)
+{
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), 0);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), 0);
+}
+
+void rnpgbe_set_rx_mode(struct net_device *netdev)
+{
+	u32 mcast_hash[RNPGBE_RX_MCAST_HASH_ENTRIES] = {};
+	u32 mcast_ctrl = RNPGBE_RX_UCAST_TABLE_EN;
+	u32 filter_ctrl = RNPGBE_RX_FILTER_BCAST;
+	struct netdev_hw_addr *ha;
+	struct mucse_hw *hw;
+	struct mucse *mucse;
+	int rar = 1;
+	u16 hash;
+	int i;
+
+	mucse = netdev_priv(netdev);
+	hw = &mucse->hw;
+
+	/* RAR 0 always holds the interface's primary unicast address. */
+	rnpgbe_set_rar(hw, 0, netdev->dev_addr);
+
+	netdev_for_each_uc_addr(ha, netdev) {
+		if (rar == RNPGBE_RX_RAR_ENTRIES) {
+			filter_ctrl |= RNPGBE_RX_FILTER_UCAST_ALL;
+			break;
+		}
+
+		rnpgbe_set_rar(hw, rar, ha->addr);
+		rar++;
+	}
+
+	for (; rar < RNPGBE_RX_RAR_ENTRIES; rar++)
+		rnpgbe_clear_rar(hw, rar);
+
+	if (netdev->flags & IFF_PROMISC) {
+		filter_ctrl |= RNPGBE_RX_FILTER_UCAST_ALL |
+			       RNPGBE_RX_FILTER_MCAST_ALL;
+	} else if (netdev->flags & IFF_ALLMULTI) {
+		filter_ctrl |= RNPGBE_RX_FILTER_MCAST_ALL;
+	} else {
+		/* MTA type 0 uses ((addr[4] << 8) | addr[5]) & 0xfff. */
+		netdev_for_each_mc_addr(ha, netdev) {
+			hash = ((ha->addr[4] & 0xf) << 8) | ha->addr[5];
+			mcast_hash[hash >> 5] |= BIT(hash & 0x1f);
+		}
+
+		if (!netdev_mc_empty(netdev))
+			mcast_ctrl |= RNPGBE_RX_MCAST_HASH_EN;
+	}
+
+	for (i = 0; i < RNPGBE_RX_MCAST_HASH_ENTRIES; i++)
+		mucse_hw_wr32(hw, RNPGBE_RX_MCAST_HASH(i), mcast_hash[i]);
+
+	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
+	mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index 1d87edfba3d7..feb84704d602 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -24,5 +24,20 @@
 #define RNPGBE_DMA_AXI_EN              0x0010
 #define RNPGBE_TX_MIN_PKT_LEN          33
 
+#define MUCSE_ETH_OFF(_n)              (0x10000 + (_n))
+#define RNPGBE_RX_RAR_LOW(_n)          MUCSE_ETH_OFF(0xa000 + 4 * (_n))
+#define RNPGBE_RX_RAR_HIGH(_n)         MUCSE_ETH_OFF(0xa400 + 4 * (_n))
+#define RNPGBE_RX_MCAST_HASH(_n)       MUCSE_ETH_OFF(0xac00 + 4 * (_n))
+#define RNPGBE_RX_FILTER_CTRL          MUCSE_ETH_OFF(0x9110)
+#define RNPGBE_RX_MCAST_CTRL           MUCSE_ETH_OFF(0x9114)
+#define RNPGBE_RX_RAR_VALID            BIT(31)
+#define RNPGBE_RX_FILTER_BCAST         BIT(10)
+#define RNPGBE_RX_FILTER_UCAST_ALL     BIT(9)
+#define RNPGBE_RX_FILTER_MCAST_ALL     BIT(8)
+#define RNPGBE_RX_MCAST_HASH_EN        BIT(4)
+#define RNPGBE_RX_UCAST_TABLE_EN       BIT(3)
+/* The final two of the 32 hardware RAR entries are reserved for NCSI. */
+#define RNPGBE_RX_RAR_ENTRIES          30
+#define RNPGBE_RX_MCAST_HASH_ENTRIES   128
 #define RNPGBE_MAX_QUEUES 8
 #endif /* _RNPGBE_HW_H */
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 6e006fbd17ad..ab46d9b8aaca 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -43,6 +43,10 @@ static int rnpgbe_configure(struct mucse *mucse)
 	if (err)
 		return err;
 
+	netif_addr_lock_bh(mucse->netdev);
+	rnpgbe_set_rx_mode(mucse->netdev);
+	netif_addr_unlock_bh(mucse->netdev);
+
 	return rnpgbe_configure_rx(mucse);
 }
 
@@ -142,9 +146,10 @@ static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
 }
 
 static const struct net_device_ops rnpgbe_netdev_ops = {
-	.ndo_open       = rnpgbe_open,
-	.ndo_stop       = rnpgbe_close,
-	.ndo_start_xmit = rnpgbe_xmit_frame,
+	.ndo_open        = rnpgbe_open,
+	.ndo_stop        = rnpgbe_close,
+	.ndo_start_xmit  = rnpgbe_xmit_frame,
+	.ndo_set_rx_mode = rnpgbe_set_rx_mode,
 	.ndo_get_stats64 = rnpgbe_get_stats64,
 };
 
@@ -228,6 +233,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
-- 
2.50.1

