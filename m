Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CEE1FA859;
	Sun,  4 Oct 2026 07:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791097249; cv=none; b=IEgwm6E5XRxiC4gnGIjpazL79ZIv/rvyLuXuVOjJ5gsYqqqj9P3GNHNHDcOfZaw7Wrnp82isgfevo39tHD4WgTKIu2VjeMlE4BYSxSz+LAw4kYbO0/U15umBfVO2/J0askfpbL8p2O1dWO17VUc5gmo08aB51kcdEWD9PRLbmag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791097249; c=relaxed/simple;
	bh=ZYv/plxhTOQaShrwFtFlOgke7m9tkEq3QsaVIglx9hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9OXoSzPJS1egMUXXx3GXscE3al90rDGCwE6Y3UOPL4prA++AsM/YmoUjZ+3R7uFK0l1+L7UzOK0hALOo0eVnIuzdNRux/n6a9pMEJQHgvDlM/+j6Jb2yEe8OHBSj5aZrjOSQIj5EhwFVTLf5SyzJeGKW6iDW5Fjy7jgkbQJKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz3t1791097178tf26763c0
X-QQ-Originating-IP: mNuHsg5HjMwOIch1A53OHdRqPO0/l6BcoetPDTO82OA=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 04 Oct 2026 14:59:35 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11545595183112629195
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
Subject: [PATCH net-next v15 4/5] net: rnpgbe: Add receive mode support
Date: Sun,  4 Oct 2026 14:59:33 +0800
Message-ID: <FDF3BC16CC1A2D7D+20261004065933.225110-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <B438B0A83ACCA2DE+20261004065604.224873-1-dong100@mucse.com>
References: <B438B0A83ACCA2DE+20261004065604.224873-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: M9JRF+kgSaxgeqkVnxFDQla1+sVgby+n14W1cl+1NgDr5udnVfbq4Imi
	f9pKBEZSu3fyaYqNqRndtJGfZI7Ap0PT9bTXeQvZxO90GACpwZ5O4vWKq9jcBD1Bryyd+iL
	eVBpBIUP25Ws2jcBz2Sq2gsjFAQZPZ3yt1dzEtjqjQNHPtXHAqzXoPDMhpupncUt9kwUtqZ
	7qHplMQ4uK5DAA9q8sYUzNyi6cDsiFY/C/jVlf2YZiI6HJzHAUMDnF3APYkNb61aKoKn8sK
	Xax6y3p8eI6P5RWRhKi++TNJRKr04beynn1MvIOBJvBDp4kBaIdFPD64lTxCFwc8G6LjUp/
	S4nhMVaR54jNCHeCL4FnRGOoz39ImDB1FRAuSDl+B1cNHnSMeUbu+KWJdjGgWAGuDQJVRaE
	72p0ShijDfzDtTpAWLrZYugQDQo6e+QBPb7fbZkWFploOU4HAvERN2CQGYaaMp6kqGqj+mz
	d7AgDBM/3lrQjNN4bjgM3VhZrinnQVB+X2+ySp1o6TC5u4wkKMQQ4E9xFlBIy+g8dNnVkwa
	DPzi1Di2zlzWxBd7IyEdGFTw3acgTAZid0xjkoIkL9IEw6uS4zxsqM6MAtW5QJLWTxoKLu4
	CuqaNyg1FGrazv/ysheoWg/lWO1rZauSphWE+L9twhzyU5+h6UgQ+MNshLY4ga8gN1cTdhS
	i+cg+EUKBYM5T5Suz3x3x8UOwejQetp7mGvM5xKDdCwf9z0okZH+P9rHB8dSQQj341hnKrB
	W48VJDR6+6Sk6vpXhCYfAgCgcZegiJv2RD0cQnNSKxSwaPAVkI1ZtFYUKzn6VlEpFmqqkQL
	LcR1dr+Q5j2Wl4zX9h5v/ijiulP21PlboPN72k2dJelb9Tc1CwCdky1Gw+oxprFdOMo3kFG
	QGD6byV5eaCVj0uMddJdCZWEjbUS6Tya1h/C3vXU6lD8Cy/7qjY/TrQtbFBpl35bGmUnf8r
	9CvO6qCot6khfsyYbBWk43nXy0q34aHRoMNZ9+vAMEu81zcO8+tEwGOma/yKH2SzeR8IJBH
	gFTwlHwnfG4ca16ZdIJcziT7FUOUttM2LYDbGXkmPPvh7jYlSkMnAx+MCzNhTao8L2JxBOx
	YYV1UCaoCEJ
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

Add chip-level receive filtering and the ndo_set_rx_mode_async callback.

Program the primary and additional unicast addresses into the available
RAR entries, and use the 4096-bit multicast hash table for multicast
addresses. Advertise RAR-based secondary unicast filtering to the
networking core, so it does not force promiscuous mode for a non-empty
secondary unicast list. Fall back to accepting all unicast addresses if
the RAR table is exhausted, and handle IFF_PROMISC and IFF_ALLMULTI
through the chip-level filter control register.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  3 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 96 +++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 15 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 17 +++-
 4 files changed, 127 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 8032fa261df6..561048f0564e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -234,6 +234,9 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
 		       bool enable,
 		       int mode);
 int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
+int rnpgbe_set_rx_mode(struct net_device *netdev,
+		       struct netdev_hw_addr_list *uc,
+		       struct netdev_hw_addr_list *mc);
 
 /* Device IDs */
 #define PCI_VENDOR_ID_MUCSE               0x8848
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index 291e77d573fe..79d66187d044 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -149,3 +149,99 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 
 	return 0;
 }
+
+static void rnpgbe_set_rar(struct mucse_hw *hw, u32 index, const u8 *addr)
+{
+	u32 old_low, old_high;
+	u32 rar_low, rar_high;
+
+	/* The RAR stores the Ethernet address in reverse byte order. */
+	rar_low = (u32)addr[5] | ((u32)addr[4] << 8) |
+		  ((u32)addr[3] << 16) | ((u32)addr[2] << 24);
+	rar_high = (u32)addr[1] | ((u32)addr[0] << 8) |
+		   RNPGBE_RX_RAR_VALID;
+	old_low = mucse_hw_rd32(hw, RNPGBE_RX_RAR_LOW(index));
+	old_high = mucse_hw_rd32(hw, RNPGBE_RX_RAR_HIGH(index));
+	if (old_low == rar_low && old_high == rar_high)
+		return;
+
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index),
+		      rar_high & ~RNPGBE_RX_RAR_VALID);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), rar_low);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), rar_high);
+}
+
+static void rnpgbe_clear_rar(struct mucse_hw *hw, u32 index)
+{
+	u32 rar_high;
+
+	rar_high = mucse_hw_rd32(hw, RNPGBE_RX_RAR_HIGH(index));
+	if (!(rar_high & RNPGBE_RX_RAR_VALID))
+		return;
+
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), 0);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), 0);
+}
+
+int rnpgbe_set_rx_mode(struct net_device *netdev,
+		       struct netdev_hw_addr_list *uc,
+		       struct netdev_hw_addr_list *mc)
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
+	netdev_hw_addr_list_for_each(ha, uc) {
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
+		netdev_hw_addr_list_for_each(ha, mc) {
+			hash = ((ha->addr[4] & 0xf) << 8) | ha->addr[5];
+			mcast_hash[hash >> 5] |= BIT(hash & 0x1f);
+		}
+
+		if (!netdev_hw_addr_list_empty(mc))
+			mcast_ctrl |= RNPGBE_RX_MCAST_HASH_EN;
+	}
+
+	/* Widen multicast filtering before invalidating hash entries. */
+	if (filter_ctrl & RNPGBE_RX_FILTER_MCAST_ALL)
+		mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
+
+	for (i = 0; i < RNPGBE_RX_MCAST_HASH_ENTRIES; i++)
+		mucse_hw_wr32(hw, RNPGBE_RX_MCAST_HASH(i), mcast_hash[i]);
+
+	mucse_hw_wr32(hw, RNPGBE_RX_MCAST_CTRL, mcast_ctrl);
+	if (!(filter_ctrl & RNPGBE_RX_FILTER_MCAST_ALL))
+		mucse_hw_wr32(hw, RNPGBE_RX_FILTER_CTRL, filter_ctrl);
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
index dc869051c8fa..3f103f93ac30 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
@@ -26,5 +26,20 @@
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
index 21fa78c59e5b..8e1eebf32723 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -43,6 +43,13 @@ static int rnpgbe_configure(struct mucse *mucse)
 	if (err)
 		return err;
 
+	netif_addr_lock_bh(mucse->netdev);
+	err = rnpgbe_set_rx_mode(mucse->netdev, &mucse->netdev->uc,
+				 &mucse->netdev->mc);
+	netif_addr_unlock_bh(mucse->netdev);
+	if (err)
+		return err;
+
 	return rnpgbe_configure_rx(mucse);
 }
 
@@ -140,10 +147,11 @@ static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
 }
 
 static const struct net_device_ops rnpgbe_netdev_ops = {
-	.ndo_open       = rnpgbe_open,
-	.ndo_stop       = rnpgbe_close,
-	.ndo_start_xmit = rnpgbe_xmit_frame,
-	.ndo_get_stats64 = rnpgbe_get_stats64,
+	.ndo_open		 = rnpgbe_open,
+	.ndo_stop		 = rnpgbe_close,
+	.ndo_start_xmit		 = rnpgbe_xmit_frame,
+	.ndo_set_rx_mode_async = rnpgbe_set_rx_mode,
+	.ndo_get_stats64	 = rnpgbe_get_stats64,
 };
 
 static void rnpgbe_sw_init(struct mucse *mucse)
@@ -234,6 +242,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
-- 
2.50.1

