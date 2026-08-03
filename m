Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8593328FD;
	Mon,  3 Aug 2026 02:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785723231; cv=none; b=Q2AK4WQQWUV9kRpIt6qT8HtrhhaHvWJY7nGGgynIzSQiGTc5kbadZrxNM7vFl2gy2flEt0aQhf96kIbSeL//yWipsZW2VyMB8NiyxxNQlG2LeahFC+ZKUd53VSlAwvcV1HSLNPJfDfE8IeDkWfHQWwd2orEP96E5xY2WPdxGRTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785723231; c=relaxed/simple;
	bh=iqZNfFUaKKwLo3XqfKUl77Fh5IZWEfoL4zJqgwlgZ64=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fo9B+xGCHbw4rPkXfJ8ONRsMnlhe2b4dYxuYnHTrV5UKtvx2gHN+UVh48Jefl6PhGlKTt7pVtEkWkCipnkGYDXHZD0NN8EFfDDDvty2i3ndew5wcuTuGVxLzTYyVkhIa8JLAFxIK0AM+zqc/Y75JnMc8xOTGsm6V6PPOkfofX60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=YLx5RkXu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="YLx5RkXu"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6732D8Kt83810915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785723188;
	bh=eIHcfnf08NWCS+fbAv4AY6ZoSYuLBgsGXY8onpqI8xs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YLx5RkXuX5fFounBhCBWXk8hWshmDEr9dDyA+dtOIa/2QEhUw6c+9NlzpwqUpqpr/
	 1mPq/AbLrcMcHPW005RWnH+e2TKWFzNB0JGgeXh8XNGWF0zbt5eLGxYShbUI5CtCNW
	 0yxwU9rfkogesWAc3RMqg00Qcx0v8pAeMWDmx3XOJOP/gRPdpFjIjB9QO88fM/opwx
	 9B1hotAMzPYt2ACHj3/m5iapoEOoRfm4fG7tOeza/wrKFbAYbCo26tP/gZuuojCOFY
	 oCDv4WuPYN/DQ7W4pfAxBdl6Wh/74aFj3WlVDN9jTE/noCU6ngHDCDVSCoP0hcqOTT
	 LX4QLKehZFQNQ==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6732D8Kt83810915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Aug 2026 10:13:08 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 3 Aug 2026 10:13:07 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Mon, 3 Aug 2026 10:13:07 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v10 3/7] r8169: add support for new interrupt mapping
Date: Mon, 3 Aug 2026 10:13:01 +0800
Message-ID: <20260803021305.488-4-javen_xu@realsil.com.cn>
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

To support RSS, the number of hardware interrupt bits should match the
interrupt of software. So we add support for new interrupt mapping here.
ISR_VEC_MAP_REG is the hardware register to indicate interrupt status.
IMR_SET_VEC_MAP_REG is interrupt mask which is set to enable irq.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - init index in napi_struct and get message_id from index
 - move rtl8169_disable_hw_interrupt_msix directly before the call to
   napi_schedule()
 - change the condition in rtl8169_request_irq when RTL_VEC_MAP_ENABLE
   enabled, use rtl8169_interrupt_msix

Changes in v4:
 - remove flag tp->feature, replace tp->features & RTL_VEC_MAP_ENABLE
   with tp->irq_nvecs > 1, they are equivalent.
 - follow reverse xmas tree, in rtl8169_interrupt_msix(),
   rtl8169_poll_msix_rx(), rtl8169_poll_msix_tx(),
   rtl8169_poll_msix_other()
 - use napi->index in rtl8169_poll_msix_other()
 - add a comment to describe RTL8127 MSI-X vector layout
 - simplify r8169_init_napi()

Changes in v5:
 - replace magic number in rtl8169_poll_msix_tx()

Changes in v6:
 - when irq_nvecs <= 1, use register IntrMask_8125, else using vec map
 - fix irq sequence in rtl8169_interrupt_msix(), disable interrupts
   before clean it
 - remove dead code in rtl8169_poll_msix_tx()

Changes in v7:
 - remove recheck_desc_ownbit
 - change return value of rtl_tx
 - remove message_id which only used once

Changes in v8:
 - fix rtl8169_netpoll()
 - remove tx_done

Changes in v9:
 - change the way of getting message_id of napi

Changes in v10:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 172 +++++++++++++++++++---
 1 file changed, 154 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 924df0639828..6a7e9d875cf0 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -85,6 +85,7 @@
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
+#define R8127_MAX_TX_QUEUES	8
 #define R8169_DEFAULT_RX_QUEUES	1
 #define R8169_MAX_TX_QUEUES	1
 
@@ -455,8 +456,12 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
+	ISR_VEC_MAP_REG		= 0x0d04,
+	IMR_SET_VEC_MAP_REG	= 0x0d0c,
 };
 
+#define MSIX_ID_VEC_MAP_LINKCHG	29
 #define LEDSEL_MASK_8125	0x23f
 
 #define RX_VLAN_INNER_8125	BIT(22)
@@ -587,6 +592,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+#define	ISRIMR_LINKCHG	BIT(29)
+#define	ISRIMR_TOK_Q0	BIT(8)
+#define	ISRIMR_ROK_Q0	BIT(0)
 };
 
 enum rtl_desc_bit {
@@ -1663,26 +1671,38 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
 static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
 {
-	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrStatus_8125, bits);
-	else
+	if (rtl_is_8125(tp)) {
+		if (tp->irq_nvecs > 1)
+			RTL_W32(tp, ISR_VEC_MAP_REG, bits);
+		else
+			RTL_W32(tp, IntrStatus_8125, bits);
+	} else {
 		RTL_W16(tp, IntrStatus, bits);
+	}
 }
 
 static void rtl_irq_disable(struct rtl8169_private *tp)
 {
-	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrMask_8125, 0);
-	else
+	if (rtl_is_8125(tp)) {
+		if (tp->irq_nvecs > 1)
+			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
+		else
+			RTL_W32(tp, IntrMask_8125, 0);
+	} else {
 		RTL_W16(tp, IntrMask, 0);
+	}
 }
 
 static void rtl_irq_enable(struct rtl8169_private *tp)
 {
-	if (rtl_is_8125(tp))
-		RTL_W32(tp, IntrMask_8125, tp->irq_mask);
-	else
+	if (rtl_is_8125(tp)) {
+		if (tp->irq_nvecs > 1)
+			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
+		else
+			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
+	} else {
 		RTL_W16(tp, IntrMask, tp->irq_mask);
+	}
 }
 
 static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
@@ -5035,6 +5055,45 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
 	}
 }
 
+static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
+}
+
+static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
+}
+
+static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, IMR_SET_VEC_MAP_REG, BIT(message_id));
+}
+
+static irqreturn_t rtl8169_interrupt_msix(int irq, void *dev_instance)
+{
+	struct napi_struct *napi = dev_instance;
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp;
+	int message_id;
+
+	tp = netdev_priv(dev);
+	message_id = napi - tp->rtl8169_napi;
+
+	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
+		rtl8169_clear_hw_isr(tp, message_id);
+		phy_mac_interrupt(tp->phydev);
+		return IRQ_HANDLED;
+	}
+
+	rtl8169_disable_hw_interrupt_msix(tp, message_id);
+	rtl8169_clear_hw_isr(tp, message_id);
+
+	napi_schedule(napi);
+
+	return IRQ_HANDLED;
+}
+
 static int rtl8169_request_irq(struct rtl8169_private *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -5043,8 +5102,12 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 	for (i = 0; i < tp->irq_nvecs; i++) {
 		napi = &tp->rtl8169_napi[i];
-		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
-				     NULL, napi, "%s-%d", dev->name, i);
+		if (tp->irq_nvecs > 1)
+			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt_msix,
+					     NULL, napi, "%s-%d", dev->name, i);
+		else
+			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
+					     NULL, napi, "%s-%d", dev->name, i);
 		if (rc)
 			goto free_irq;
 	}
@@ -5251,8 +5314,12 @@ static void rtl8169_netpoll(struct net_device *dev)
 	struct rtl8169_private *tp = netdev_priv(dev);
 
 	for (int i = 0; i < tp->irq_nvecs; i++) {
-		rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
-				  &tp->rtl8169_napi[i]);
+		if (tp->irq_nvecs > 1)
+			rtl8169_interrupt_msix(pci_irq_vector(tp->pci_dev, i),
+					       &tp->rtl8169_napi[i]);
+		else
+			rtl8169_interrupt(pci_irq_vector(tp->pci_dev, i),
+					  &tp->rtl8169_napi[i]);
 	}
 }
 #endif
@@ -5503,10 +5570,16 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	if (tp->irq_nvecs > 1) {
+		tp->irq_mask = ISRIMR_LINKCHG | ISRIMR_TOK_Q0;
+		for (int i = 0; i < tp->num_rx_rings; i++)
+			tp->irq_mask |= ISRIMR_ROK_Q0 << i;
+	} else {
+		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
 
-	if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
-		tp->irq_mask |= SYSErr | RxFIFOOver;
+		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
+			tp->irq_mask |= SYSErr | RxFIFOOver;
+	}
 }
 
 static int rtl_alloc_irq(struct rtl8169_private *tp)
@@ -5791,10 +5864,73 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp;
+	int work_done = 0;
+	int message_id;
+
+	tp = netdev_priv(dev);
+	message_id = napi - tp->rtl8169_napi;
+
+	if (message_id < tp->num_rx_rings)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget, napi);
+
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return work_done;
+}
+
+static int rtl8169_poll_msix_tx(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp;
+
+	tp = netdev_priv(dev);
+
+	rtl_tx(dev, tp, budget);
+
+	if (napi_complete_done(napi, 0))
+		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));
+
+	return 0;
+}
+
+static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp;
+
+	tp = netdev_priv(dev);
+
+	if (napi_complete_done(napi, 0))
+		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));
+
+	return 0;
+}
+
+/* RTL8127 MSI-X vector layout:
+ * Vectors 0 .. (RxQs - 1)		: Rx Queues
+ * Vectors RxQs .. (RxQs + TxQs - 1)	: Tx Queues
+ * Vector (RxQs + TxQs) and up		: Other events (Link status(29), etc.)
+ */
 static void r8169_init_napi(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++)
-		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
+
+		if (tp->irq_nvecs > 1) {
+			if (i < R8169_MAX_RX_QUEUES)
+				poll_fn = rtl8169_poll_msix_rx;
+			else if (i < R8169_MAX_RX_QUEUES + R8127_MAX_TX_QUEUES)
+				poll_fn = rtl8169_poll_msix_tx;
+			else
+				poll_fn = rtl8169_poll_msix_other;
+		}
+		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
+	}
 }
 
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.43.0

