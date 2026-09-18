Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB2370ADB;
	Fri, 18 Sep 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789712400; cv=none; b=eMuab1F2EnitGNgGwGJKLYN0y346Vsj8WX6AJrkQLXpo6DBwfVg5P9LaD+puxGgduNosdJ7DUqr1llib3k0W1mYP0DWfzZHYGqBssFVJSepLTrZkKgqz3S1HYjJr2fFmxtEBQzrgXoU+cpPOM/ieHKb/fTuU+hOP9t+tlTLhCrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789712400; c=relaxed/simple;
	bh=kktPIgDG96rMmbTUssvp1EbOnsCMhRUYqi+oA4ti+2c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXGiTFqoJo8niKd23wtPDXuFVfjuH/uSC/E7qT5x8cIvcqBwkkwHB9IhMJ5s8uOaTENzx7l4o6MaguqWg0SagDPjU0UfcxtEqkuLAcB406puVSaEwWElo6VgVZOfzUh/IQPkJ9git7S2LvnuW2iUP5PTWs9pSBoonvHqe9OIICk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=UGMYawhp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="UGMYawhp"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68I6JQAB03939110, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1789712366;
	bh=Pts0QiOEZ8qMR4TV7a+IMFmGRu80dkxW7/w7Oy+M6aI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UGMYawhpDHYIbTWon01W3OMXucov5+SjSR8fI2Clgtd9OhzvnOjfUX0u8xrde9SW1
	 aGClfZLgH/yK/DC5Bb3FHAcMH1QqV2p/uAghjfDJaCfKNmvnN+SrLHskMfVCH7NhWR
	 K/SyVz2Ci8xost6ki6t/aqIBAZq1k+zErsQ9gDIbU2pkyIud8pyITqd7BaJ3z1OOfr
	 /+ZqiANsw0/DKOHkXwPWBZMk/VZoqFSV+XuaenEceJWXQXUi/+yuE76sTBZDZr01Ou
	 4MWNvR2uxQOaeF+dBolKEC3UnomCSsvNEAyX1kA9GPx0aE5reuJsgZh0ub2ItCT9DR
	 HGS989TXELGCg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68I6JQAB03939110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Sep 2026 14:19:26 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 18 Sep 2026 14:19:26 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 18 Sep 2026 14:19:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v14 3/7] r8169: add support for new interrupt mapping
Date: Fri, 18 Sep 2026 14:19:19 +0800
Message-ID: <20260918061923.313-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260918061923.313-1-javen_xu@realsil.com.cn>
References: <20260918061923.313-1-javen_xu@realsil.com.cn>
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

Changes in v11:
 - add comment on rtl8169_poll_msix_tx, only use 1 tx
 - remove napi for other. Separate napi only for datapath, control path
   like linkchg is handled in interrupt function, which will not call
   napi any more.

Changes in v12:
 - no changes

Changes in v13:
 - only request IRQs and napi for active vectors(0~7 rx, 8 tx)

Changes in v14:
 - fix tp->phydev null pointer issue when the nic is fiber mode
---
 drivers/net/ethernet/realtek/r8169_main.c | 223 +++++++++++++++++++---
 1 file changed, 193 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 7a2e7ce56e48..c647b4327ff7 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -471,8 +471,12 @@ enum rtl8125_registers {
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
@@ -603,6 +607,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+#define	ISRIMR_LINKCHG	BIT(29)
+#define	ISRIMR_TOK_Q0	BIT(8)
+#define	ISRIMR_ROK_Q0	BIT(0)
 };
 
 enum rtl_desc_bit {
@@ -1770,26 +1777,38 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
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
@@ -4539,13 +4558,17 @@ static void rtl8169_tx_clear(struct rtl8169_private *tp)
 
 static void rtl8169_napi_disable(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++)
+	int napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
+
+	for (int i = 0; i < napi_num; i++)
 		napi_disable(&tp->rtl8169_napi[i]);
 }
 
 static void rtl8169_napi_enable(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++)
+	int napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
+
+	for (int i = 0; i < napi_num; i++)
 		napi_enable(&tp->rtl8169_napi[i]);
 }
 
@@ -5192,19 +5215,81 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-static void rtl8169_free_irq(struct rtl8169_private *tp)
+static void rtl8169_free_one_irq(struct rtl8169_private *tp, int i)
 {
 	struct pci_dev *pdev = tp->pci_dev;
-	int i, irq;
+	struct napi_struct *napi;
+	int irq;
 
-	for (i = 0; i < tp->irq_nvecs; i++) {
-		struct napi_struct *napi = &tp->rtl8169_napi[i];
+	irq = pci_irq_vector(pdev, i);
+	napi = &tp->rtl8169_napi[i];
 
-		irq = pci_irq_vector(pdev, i);
+	if (tp->irq_nvecs > 1) {
+		if (i <= R8169_MAX_RX_QUEUES)
+			free_irq(irq, napi);
+		else if (i == MSIX_ID_VEC_MAP_LINKCHG)
+			free_irq(irq, tp);
+	} else {
 		free_irq(irq, napi);
 	}
 }
 
+static void rtl8169_free_irq(struct rtl8169_private *tp)
+{
+	int i;
+
+	for (i = 0; i < tp->irq_nvecs; i++)
+		rtl8169_free_one_irq(tp, i);
+}
+
+static void rtl8169_disable_hw_interrupt_msix(struct rtl8169_private *tp,
+					      int message_id)
+{
+	RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, BIT(message_id));
+}
+
+static void rtl8169_clear_hw_isr(struct rtl8169_private *tp, int message_id)
+{
+	RTL_W32(tp, ISR_VEC_MAP_REG, BIT(message_id));
+}
+
+static void rtl8169_enable_hw_interrupt_msix(struct rtl8169_private *tp,
+					     int message_id)
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
+	rtl8169_disable_hw_interrupt_msix(tp, message_id);
+	rtl8169_clear_hw_isr(tp, message_id);
+
+	napi_schedule(napi);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t rtl8169_interrupt_other(int irq, void *dev_instance)
+{
+	struct rtl8169_private *tp = dev_instance;
+
+	rtl8169_clear_hw_isr(tp, MSIX_ID_VEC_MAP_LINKCHG);
+	if (tp->phydev)
+		phy_mac_interrupt(tp->phydev);
+	else if (tp->sfp_mode)
+		phylink_mac_change(tp->phylink,
+				   !!(RTL_R8(tp, PHYstatus) & LinkStatus));
+	return IRQ_HANDLED;
+}
+
 static int rtl8169_request_irq(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
@@ -5219,18 +5304,28 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 		napi = &tp->rtl8169_napi[i];
 		irq = pci_irq_vector(pdev, i);
 
-		rc = request_irq(irq, rtl8169_interrupt, irqflags,
-				 dev->name, napi);
+		if (tp->irq_nvecs > 1) {
+			/* RX: 0~7, TX: 8*/
+			if (i <= R8169_MAX_RX_QUEUES)
+				rc = request_irq(irq, rtl8169_interrupt_msix,
+						 irqflags, dev->name, napi);
+			else if (i == MSIX_ID_VEC_MAP_LINKCHG)
+				rc = request_irq(irq, rtl8169_interrupt_other,
+						 irqflags, dev->name, tp);
+			else
+				continue;
+		} else {
+			rc = request_irq(irq, rtl8169_interrupt,
+					 irqflags, dev->name, napi);
+		}
 		if (rc)
 			goto free_irq;
 	}
 	return 0;
 
 free_irq:
-	while (--i >= 0) {
-		irq = pci_irq_vector(pdev, i);
-		free_irq(irq, &tp->rtl8169_napi[i]);
-	}
+	while (--i >= 0)
+		rtl8169_free_one_irq(tp, i);
 	return rc;
 }
 
@@ -5396,9 +5491,16 @@ static int rtl8169_close(struct net_device *dev)
 static void rtl8169_netpoll(struct net_device *dev)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
+	int napi_num;
+
+	napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
 
-	for (int i = 0; i < tp->irq_nvecs; i++)
-		rtl8169_interrupt(0, &tp->rtl8169_napi[i]);
+	for (int i = 0; i < napi_num; i++) {
+		if (tp->irq_nvecs > 1)
+			rtl8169_interrupt_msix(0, &tp->rtl8169_napi[i]);
+		else
+			rtl8169_interrupt(0, &tp->rtl8169_napi[i]);
+	}
 }
 #endif
 
@@ -5600,7 +5702,9 @@ static void rtl_shutdown(struct pci_dev *pdev)
 
 static void r8169_free_napi(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++)
+	int napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
+
+	for (int i = 0; i < napi_num; i++)
 		netif_napi_del(&tp->rtl8169_napi[i]);
 
 	kfree(tp->rtl8169_napi);
@@ -5654,10 +5758,16 @@ static const struct net_device_ops rtl_netdev_ops = {
 
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
@@ -6203,10 +6313,63 @@ static int rtl_init_phylink(struct rtl8169_private *tp)
 	return 0;
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
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id],
+				    budget, napi);
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
+	/* Currently r8169 only supports a single Tx ring.
+	 * Therefore, we don't need a per-ring Tx processing loop here.
+	 */
+	rtl_tx(dev, tp, budget);
+
+	if (napi_complete_done(napi, 0))
+		rtl8169_enable_hw_interrupt_msix(tp, (int)(napi - tp->rtl8169_napi));
+
+	return 0;
+}
+
+/* RTL8127 MSI-X vector layout:
+ * Vectors 0 .. (MAX_RXQ - 1)			: Rx Queues
+ * Vectors MAX_RXQ .. (MAX_RXQ + MAX_TXQ - 1)	: Tx Queues
+ * NAPI is only allocated for data path
+ */
 static void r8169_init_napi(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++) {
-		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+	int napi_num = min(tp->irq_nvecs, R8169_MAX_RX_QUEUES + 1);
+
+	for (int i = 0; i < napi_num; i++) {
+		int (*poll_fn)(struct napi_struct *, int) = rtl8169_poll;
+
+		if (tp->irq_nvecs > 1) {
+			if (i < R8169_MAX_RX_QUEUES)
+				poll_fn = rtl8169_poll_msix_rx;
+			else
+				poll_fn = rtl8169_poll_msix_tx;
+		}
+		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], poll_fn);
 		netif_napi_set_irq(&tp->rtl8169_napi[i],
 				   pci_irq_vector(tp->pci_dev, i));
 	}
-- 
2.43.0

