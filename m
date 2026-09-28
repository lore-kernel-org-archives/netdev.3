Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE0133A6F2;
	Mon, 28 Sep 2026 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566797; cv=none; b=t7hk2SjryFYhxsXvJUwuxG9Q0Dnvb73JFtLI0cvRRZRZMajg94mbw+UsRJxZFLu8GssgstAOa9gEyK7NZzSId9DkK0cInpmjlWF7+h//RnBBV2R0+dPnNMclWm0eozGZjzOhGb9Le0KhXzIvV7OX65pibbwdZKyy5qbKtRQuFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566797; c=relaxed/simple;
	bh=wAMMCyp5TfDEMDYqWktmw2U7qML9DPECCl4ABlXnjWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJztI/VA7bR7z9EU4EUg4NXvuCBNu2GwO354/aXC6DaKwLnNnYBElSEQ9x5T5DtN/TW3v1XVGF/q6sbPRFRqieUnckIoAMDIbYVfnzLQYkDqM2pprcwtvVZfgUT1QAQHMpjDstf+ua6I0nRC2QPVjXsLFDfvgtFtz/MSzvRQwM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1790566743tb1bb5d6e
X-QQ-Originating-IP: KFm5g+qhLkAUu8wM7uDU3cCGy3YX6HqL9aYUIifj6/E=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 28 Sep 2026 11:39:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8139908005162700617
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
Subject: [PATCH net-next v14 4/5] net: rnpgbe: Add receive mode support
Date: Mon, 28 Sep 2026 11:38:59 +0800
Message-ID: <6E780505C6AAB4EB+20260928033859.1033428-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <0A4D45AD9F6A0F14+20260928033701.1033196-1-dong100@mucse.com>
References: <0A4D45AD9F6A0F14+20260928033701.1033196-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MNJPayNksrvk7s4X2fMrwQe1pIXd0tuCZhb9VEvvN1FESFpl+jLVG63e
	5FwcEaL3dp0syvZsHTZNW1vCkpNOMxdzepEIamrhBh1LR1unfiNY839YA5bS4GkGvYj4oW4
	TkIVMzLHu2XV0pvjMwFOQiqg6Ghxs4QDsD/k05yv1LZD1Kyy+CMhsdzwKs0MCH49DQFHL1p
	4oZG3l3wJsiCuk2gF+kuA8JZyc82scKKej5W5ul8IX/ep0yOdCpZbxQhNrcomL+3DyeeKjh
	bJtPolq6eKpBmf8BoT0bUpv9FtTqPaMl/b7rO4MswcqQvA7uKp/aSF8dcvTZcAtp07u9hgj
	aVhknk9lx7dVQAaSHBPSi+8DvU/2IYxkxcH7OAyK2BchRt7jaegtb+MtIta4bfOabJgkBbX
	KPrUQm3jApkz00g8XETuHKF2fOfQ6K6ZdR9l//MGXWPRQQWjpInV5+Il+Utf2+IhF+AelU1
	6HUP9bx4V2+sJOuSCVPzZm7rbMfOoaOfrVDFrqKTAZY1Hh8EeWk+h2KXF1pzKHj2SbKzs2u
	xTqf5imdSD7D+iHVzxhKSqdbTBm3lviVgw5sY9P71ifyeER6YQ9KyoyxXDfU24S0ogF6FB7
	vI6W1l0fXCgyrqKSuVYSowPSTo/JCGtS1ZkUM+bbU4QyFSLz18j1XOBJn4d69BU/78FNbPb
	GlfTcX+zhEevgeIf093JzT7iga9H666AI26K2D/aqMFWE4dgo7O2SJdENsMh3dUE4nwOEoz
	JV4VeLV3kMNDJ4oESBo3f68S6XgTnqmy10Pei6aJK6Vlw7u786cZMoogpG6BaIWwIDAuBGO
	zKylAip5UfpgWb/B6DFYNLPYNrCaYQKVACAVHaGvR5n1CC6byom4TLWOcBm+jKDE/4bYkFO
	6s8zbsMgb/JAf5JCrcg4tofDIJYebZKEeqROP5BVHihWN9LFiaje7Ad0a9+BR5yVlUQzTxL
	1Ir77TnIuMfCzevGHHMqKFLmmy6P3rRxeyvFCHI9oPYRZ9+DwD0xDekSER2+2cbx6tlZPh0
	9hsPiojlZIOYhRuEuvhjsv6Fos2sKpJbiAdF/IY+X+NBfsM16pBR93+VTKe477e/LZTXm8I
	LTar0OFD3KjP0zxHASu+tunjGkWO1OQv8e38gQIKqJo
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
index 84e8b058aff4..d017bd94cf88 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -233,6 +233,7 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
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
index 21fa78c59e5b..73ee81f8b516 100644
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
 
@@ -234,6 +239,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 	}
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
+	netdev->priv_flags |= IFF_UNICAST_FLT;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
-- 
2.50.1

