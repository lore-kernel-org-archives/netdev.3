Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9433B8948;
	Sun, 20 Sep 2026 09:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896493; cv=none; b=clYis+H9CGdrzoUiSi1LBflK7cZITH3M+rngpHw3FgIcqrbaGZ/Mw/Fb1u3hnsVMbIDqr941r3z4FevRt2qyDlRuKI7tsgZokj58rSU342GjwT5/EtPxBuS0GZNLjYyBdDrzmfEsNoNDE75K6kmd0Tb2DxkuPmamB8QekYjkXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896493; c=relaxed/simple;
	bh=5TUnrPmqwGV1Gsud7gNOYe1pyIJxfgNKUiEOMupFByY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dw4YKUafj2L3vFe65ICuWTHDPLrieGAReXSW/YhWfwkJhvQusUSppyMR9LzfsyELNiMoJoany0RSqXBYeZntT1oT8WG9CountsJjdV3yABGic7R+PugErEqWJYHnqYb1eLuZm+1IRut+czFGjHby8ov8PUJcURVSZRa1XjfuN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1789896413t3c276fd0
X-QQ-Originating-IP: S3RiTUx+dK8uextlYLQz6TdtJVUe9ATjfZly5O6k10k=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 20 Sep 2026 17:26:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2193611732860423393
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
Subject: [PATCH net-next v13 4/5] net: rnpgbe: Add receive mode support
Date: Sun, 20 Sep 2026 17:26:49 +0800
Message-ID: <057BAFCF77CDC8BE+20260920092649.345634-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com>
References: <B8AF0FDE24FAFB51+20260920092424.345309-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MyIXMys/8kCtF8eXvJzNiGCC1xCQbvbQ/Ef5/qgautOdAy2AiAhxqCVM
	0SdCCzkw181+LYg5nsrsbirtl4jfeuUIZpDRs8mu5cMrCbOuH6W+9KzraU2DgH2kbE1iJ+P
	yTmKh1JpZAIUqrKxb9LRD8iw8TPt8UdxuvHFfhVWUf4/EtdkEmQWPwJt7w+eXqGK/K1bUo+
	TIUUFWvsW3iNrU3LfOiIrVjjjg2rODsoOe3MX6RoVYyjd8viT/McLCGtQKMT9c62s5VVij5
	Dobu0QTAXReUdsKCKig+c+nixd191Q018cBSmr6RCQQKaYUPFGNIouVZQj91uq6O9W9d5en
	3k2CcmUpn/fMRlAEJkCoP52Q5gogz3bLj1RQh1coqPshMo3WBqtWbioYIBwyeSXEGLWB8p2
	s099juV0zkqSYrDqJLiO/C5HrVBUTyVbDKNz90nejDrlyj5C4AqhI7FvVGRWxDywi60R5Kg
	MShurd+Q1/EJ5ARyq3rvr2LBp4DZ2jDl8rLhkTNHTPOzBVR4oirbP7cF94YkhIgFXJzp7pT
	4r4o5oupHvMoJY4FnaqNku8KuhIEPbzpj1qmBYjEi6f4jsjylUHuJ6Rxbphlt4SUSigHSwA
	CrcrvRKzinNFrazkqUxZEUeeUol7Wbmzpc3PUR2bZg/GPEUvSTA8W5IlYQqfsNHUB30c9IP
	ZXIyi2XcSA23Fl6EwG3t4whPKho+P2KLZMWUWCVizMfJkpm05xRSxe41dhzbPE8SwH3s58X
	5uhI87AJYI3/ZAgidwXamkZBuPI6o80vNUSUsFBFk8s67+gj+egBg8C9L9PzoEoXYunFgxO
	fnaxwrIzq3vL0earPaeadruKBgtrmRNovp1bCZLCw8ilsFJpgPkZkKwfBwWKDDEltXAe3KU
	fYj4v+xIe+AEf02fL4zhyKWXRftnqRWgmfnydcJqv20ZvnLhtj7Td2J75vouktnGsAuS4F9
	7rOTkU+u9sXyiU8Y01yZjm1Axj/M0FcvZUuj0fwjMJBm5P1fxQLI10FE2dIDQCbkOPCgFHB
	EmIls66KxK8/HU534mFnB5ADVsjc2pARmqjESMLhp727c5WAn1BNLKEwnanUYL+xgzZEOuT
	A==
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
index c1a72e8e2770..bd7491671e1e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -231,6 +231,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
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
index b0363509a3c5..35eb858eb2c1 100644
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
 
@@ -140,9 +144,10 @@ static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
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
 
@@ -225,6 +230,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
-- 
2.50.1

