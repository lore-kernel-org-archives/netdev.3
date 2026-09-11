Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E893F9F26;
	Fri, 11 Sep 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126040; cv=none; b=gIrcil46YVcP6PgcHorw5KNhXz07+A3lat2kAOctA/vPLZhPbTNNjn9WRMydNy4KUHGLa3AlHTe4wltyLhF+3THVnCy5MpoML3OE6C787dEEXPuci+HP0tuicJLzI6o8mwt+Rs4hss7ngvvRZRM0KjgF3vTQrsVQ2h4UmYgeyW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126040; c=relaxed/simple;
	bh=hlN6gB5OiSzq7ZHX7cFipewaLNQQf7xUH9riAswTNyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSb7T0SRTEOOF20SRlYvYaPMPZjO18szOmOW9Vbdh4AiEfQ6CkZBPYHVbqhl5FtVC5s6Z19AFq/lj3ybTDd4AUysKbCyWzDVTfjNA0cR//DektwAWevTjUV4eXqXYHIT+S1wZQDPpeMp9+y9YYVpFS5e5KexqENe2gY/YDGs24o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1789125973t19c7836c
X-QQ-Originating-IP: SdMNPw2sZHF0Cr53d+N7ugE5A4RzV9LFWzHy0dXLi1I=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 11 Sep 2026 19:26:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12056429484353093713
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
Subject: [PATCH net-next v11 4/5] net: rnpgbe: Add receive mode support
Date: Fri, 11 Sep 2026 19:25:59 +0800
Message-ID: <23DCBC529BE64D77+20260911112600.2142627-4-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260911112600.2142627-1-dong100@mucse.com>
References: <745DADAC2A5786BD+20260911112416.2142101-1-dong100@mucse.com>
 <20260911112600.2142627-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MHkr+ogDCXMtx1O6fnb4eWYaPvZ4NpVLvdWyw/HSkymE8cxPxpsJ8FQB
	IMJ4kjwjWLnQQ2+pPATzJ7keI1KuG/zX8JB9gNTufzZNf65u11/QMQN1eZj4Wsk75iRizxu
	+/bgj2BxzJdFjXHYyP8XmQBmIPD2NL43oVgEq7w3AxNaIgSq5XnlXSc1R1D05jWTa7HBAdF
	B4fuuVn5M/ALUYl0Gqsvkrk+YShYBJfq6UTHeTtukIwI40BckjZZVI6XvQxwnQz6VFJCnr8
	oO+IIdxXMY7xhMvNJ1WngEFyyHeIgLsUuAlTWSj/B1kk73UrPDBXgENpXmATtj6Cf9NiqDZ
	ZrgsM0p2U9cH8ix+D39SccYxVlgTQQTcJQtVL4dz6WosdjylrlEGOHze8MR8wt6k7lpRxFC
	N6HsC37ohMwnqdyn5iM2/NU/D54QnJ8vnuzAESyXdPWt/DqjxOBE4+blPrcohUCl9LDqn8k
	Shd6OHJAksepEsUw5+EeyP4ZK4uz42iUVbvk8aXvMkXr+svXEJOKrIh2/uSPgT8FuVeGUVT
	Xet39NEHfxtzoyxzJXKeTD4NMtzkYEir/F2j1oR+L8f4Z7/fYO6tzv7RLPKv0e+rvAtQ3Qh
	8Om9nBqxU2fhWqlgD/ZkaHdbzK1kbkVNhbeMARycrbZlsG1r1oNOQOBd80YEANXsrYL2wKi
	G6IDXbZCM2b0ZmDP6JK+w5XChogcwct/DXSgeK4fopN1oDNWCSc3jdcU5AqMlbokuEUykD2
	e90ul89ZG02U/M6b3CIVCp8bveHIDhdTWLAvv8IgIdT9u/Rri2u27KCrMzX0tcdRkH9ZSlj
	zJQATwUnRDNWF/IHofr60C50LGPhxR3QeQDn8z0bHtXowwixxv1eNbT7lfiXBhfP6L6Q1nl
	0IY+KPmFcZurZnQABR6M34p8HojYYdUyrGKiKqeWzYJqK81twFl0jHfLMrtU/wuL2R9J5fG
	Wo4wZpbduac4bKRxhi2tmk3nYtWtMO3c18uYXcJ76+68VIQ2zNdq4XnwwAAA6GOGlcIpmam
	36qnPsS7s3jfMyze3I4mVC3w7DKkRPBzkxfjHT4Ga13QoeDiRrW/o1V9+n3CcIWtuY0jpng
	A==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
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

