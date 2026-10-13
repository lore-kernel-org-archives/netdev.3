Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79741837E;
	Tue, 13 Oct 2026 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858732; cv=none; b=eTgsu75tRq0cqVtPC3FQEOKnvjANtUnhhVqTa0DuJ+A9J9bEXxN06wFjO6w0VcZkq+uwjFA+Nz9qpfbw2QBCBZhxLp8O9gDnavJfGHu8pJKbg6oDaEr1nfq7VCSn0R8On8y21SoqYS136och5xZ9wsJtAvsaHYkjyhkJSIuoFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858732; c=relaxed/simple;
	bh=+zIADAl4MX0Rf/oXaCyi4RR9lHcctj+uXZLA8P8wXm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APDUFGjOxfSQ2ERZukxAXxqODxTcdt2/MxctzvsFO9mTSFRWX0k88/1xJg35vEMwpsRLyS+GJjSJmYlgO3VKAuk6Th81zMn+L/BADwjCqLO4HvliXz3JpPGcScKB2To82dJdXLQHnCYMYkFXuX4fi3Yf0KPGdMLYHXZ81UTPt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz3t1791858662td05d279c
X-QQ-Originating-IP: V0cM8IJs47l9XTchkyBQDFScXbdigX2G8ODKtJphbhI=
Received: from nic-Precision-5820-Tower ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 Oct 2026 10:31:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8425811636131256778
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
Subject: [PATCH net-next v16 4/5] net: rnpgbe: Add receive mode support
Date: Tue, 13 Oct 2026 10:30:58 +0800
Message-ID: <2E0F918C876CD84D+20261013023058.63715-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
References: <3B42BE25B3696EAE+20261013022920.63529-1-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MIXpHopat2IaoN+N9rcNvBnka8Xti9Gnq5Zuygcp8+VsHOVY0Q2zmkYu
	7H0rSz4LCcWiTPJ5GezkCUvN554fG7u8Qgb9S3dBCP5OpMM/ycuyLj1znUiKxt7Fem2ADwU
	BYSDDIp5OBraYqwHTV9BITgtKuHTzUs9Rm2hzpi0mQANu2ZDnqFudQSm7PFsEJRkZ9PfgRo
	QN+dxgglpftZ4KyeT1uBF31nRllaaKWaUvWtJKKczTONRugicjxMNUfPkhSXKKRswStAhVJ
	MOIwfIS7AcOiBscimO4jk4wrR7tCqCA1cYWDs7gJVtDN2RcABv5EdtWL5DKaqnHfGvRAHDh
	3p5o6NujCw05DUzckhzBtACnAop1wrJ6k8+nMHZv2yVBZCJpCcNYwGM1B55Agfi11k4WNK4
	QOmumiw59IctODEDqeewC9q0gtLmTiFzsIslyHfn8lHdfdZUy5LH8Ry8yS5UoES+lkg6elB
	7Vurq3skrDEVLUI+ZQ2WCiZ2xaDvUs+ajCnXYJj66JhVI+LwyHXp8HZTL3XZns7tNiNlOdw
	GLACK65XrwnbdoImJxHSx8mzcGnWbZivDJP3D9ekfIRCG2R7oKKB1wHCISAGwwPfIVsJ/lv
	e+a5PKkUnsFF5z13B7FrhxvRAR85AD3Kq3rOrmr6WQxtzTyTJYGBNbhCNHrxByn2fuGWUMy
	rzaYhpqX2R1UV9mZVKOSkFhVWM2CaRN8QNyhymYybSQzTywAVsUP3g5sXrfNUX0wpWnfuu5
	U8Mnp2zanXj+DCIDK6fZ0cjNUSk6JO7IPSKEvPr1Zi5DapPNV7Mz+rPanf+iOzWyhLgkHLT
	FF7v5bVfu1EuXPGh8RJCT8VvrKXXQvPB5SZPID4o0GHLgIU5bCR6Q9KjWUIjfKG7Y/kqjcx
	YcEq7Vx+hG+nCjgegBB/5fq2oiFJ4kslTjjz/tjuAsx3a7piQ6kp7wb+2MulPxTwRRJkhcB
	uoQGR8SPMQqYZLXeSPhTmesYksjVeqd/KMXF5QKedT7ndVfPxkaktDp9zgHZhs0yO1/hNlM
	qgHaZpyiJuXgzpXgj192PMnzKh6H3A+cnW1aW7TzzZWHHEGpyooToHyKasGu3C9JfR1byul
	w==
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
index f839a402ad34..6f71055f180e 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -240,6 +240,9 @@ int rnpgbe_send_notify(struct mucse_hw *hw,
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

