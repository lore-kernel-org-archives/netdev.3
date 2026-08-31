Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99C53CB57F;
	Mon, 31 Aug 2026 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161859; cv=none; b=aRcnRoosxNpI7ASQ+TVCEb5L+ur9jpqtPhtqeyEujINa6k9BHEjDOrxkxY3eIjMsRQnN4q/lCkP/JDLwGh591TCh2z04uhg9v+M//rFP+vdWbNlaSnRJJFo9+0lJsas+Yl8w0BJEoic8hxErvWV6ye5VlClG0D5gxkK4cwyrnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161859; c=relaxed/simple;
	bh=MC1ZWb7cyA5pu58nLni6vuNOYfZVh6IPYgG7X4GxkMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjWDbec0V/tHyzECSHDojinEXlo/jYGImvnwrG2uZ67UksFWbsfXMNEczKZmf5lfXRj23xA+kfpVRE+Jg8Fc0DsxlZrsBNMfKjNxFcAC48y+KEE8BXqs1uLzf1l+++tw5nHBQER2SUfbSeTnCKiz8T22DNVlwUyIrfuDfYT/5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1788161787t90a5b3a7
X-QQ-Originating-IP: OZwdAtL+eITm3Y0Fz0osm7yjnpYkFGe2J86bZyF9PGM=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 31 Aug 2026 15:36:25 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13623030882522807489
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
Subject: [PATCH net-next v10 4/5] net: rnpgbe: Add receive mode support
Date: Mon, 31 Aug 2026 15:36:07 +0800
Message-ID: <462BE38B6E2AFC58+20260831073608.401988-5-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260831073608.401988-1-dong100@mucse.com>
References: <20260831073608.401988-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OD6Tra/O3eY7rWCyHkhHfB1WK1zdZIz6BKaJN8aE3R3Rxv3LdtkReZrE
	nrbmyRiQ1cppHFp0T9akol0pszbYmpbmez/BNgdxA7JyngNvUaVn8jYtqqItXrts6wdPK3w
	tocOJQFDcJOIUG576x8FlsyzFODcZtQ0koQEwgtI0DEoyX3exnslfXOReUKu2+S/BC8VxNS
	Yexd8QgykxTLsUW0sv9p+A7kNCXEVA0lQgHVNb+dQCys4zXfGFKKogzRVYey1Oz+fAG2YRX
	q1tjIn/zG2h/0BsOntkVXJtnYhZAV8bjp7vEC6f0ijXPeYWtQjn43fWxk6PmCFHCvjB43x9
	f8S4I/PRx4f5D1r+mgXoI72jUzteMISSHnLJOVPjKhkEJ5Zv+o1ytW7wN5QWADUHc9rIfrF
	5Sun3KyvsXWQs7p6ybuvL+JYKz1Y29SbdZroIAHwtfyl/Vj0CZPjjulF9au2UllVEUNM7Zv
	6iA23z8fStiWCgAaJA3YCRNy9HkNn4csx+nIl0YNrFfLR9Y+43+Jg5rZa5ubHULmT3KAhO7
	foidLoEL7izaRs096lyOE3Awp9UqeFIQ/8FdY7/s6cbHI8OrfMqxLHGB3rf2EFY7BiilCpP
	8L/EomPEKtnZT8pd4659Kf/LLPo24PVbhphj4c3tO1PGa8tr+zoSifMrskX8DH6x9Z0tbPE
	TOehSKLkVxc7gZBHhETelN83tiGAkHYfqI/YUZu62cX3Dp57nY+A1Bp+H2AgDyqrk13iRq5
	ezDVVo6OdWet4Y+NZoY87OTcx9ElpM2KEWwBP/4ZG1dGIvK8iL0xk5how9eMyFz0ilKr31W
	niH7HchGwh6xLKqJrIxJ5B/5wI4Dc/X0hNMxSCiQj4IRlVc/RhUhvK30L6E0i0uHdcqft36
	r+jBQPLTDLksQRgugi+mSPcNnW0jyE/G7rLXTsjFAYzpSV0jxRXrU2X3iZ0KZFKY5cUuJ2p
	yx4vnl5slKa8B0pqGMivtVTv//G+nF/K/uSg1Yco0EjBV8U3RFuEF+0/hS6cfnucc96rDg1
	QFR5QSkVnAguhfsiLI0CMaMc0MOsAoQA6c77CDWi8fmzpRnIF7SL5fqXumYFf0gKnZM28fn
	ij5ls/DHv0s
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

Add chip-level receive filtering and the ndo_set_rx_mode callback.

Program the primary and additional unicast addresses into the available
RAR entries, and use the 4096-bit multicast hash table for multicast
addresses. Fall back to accepting all unicast addresses when the RAR
table is exhausted, and handle IFF_PROMISC and IFF_ALLMULTI through the
chip-level filter control register.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 73 +++++++++++++++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h | 15 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 14 +++-
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 8c3d8bbfcc1a..8d7c6f8301cd 100644
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
index 291e77d573fe..c7d5b53f6209 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -149,3 +149,76 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type)
 
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
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), rar_low);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), rar_high);
+}
+
+static void rnpgbe_clear_rar(struct mucse_hw *hw, u32 index)
+{
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), 0);
+	mucse_hw_wr32(hw, RNPGBE_RX_RAR_HIGH(index), 0);
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
+		/* The MTA index is the 12 address bits from 36 through 47. */
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
index e62366291b2a..817081e24bb5 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -43,7 +43,12 @@ static int rnpgbe_configure(struct mucse *mucse)
 	if (err)
 		return err;
 
-	return rnpgbe_configure_rx(mucse);
+	err = rnpgbe_configure_rx(mucse);
+	if (err)
+		return err;
+
+	rnpgbe_set_rx_mode(mucse->netdev);
+	return 0;
 }
 
 /**
@@ -142,9 +147,10 @@ static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
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
 
-- 
2.50.1


