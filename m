Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B263FF8BA;
	Wed, 13 May 2026 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673367; cv=none; b=ieji4wL9Fsutz8Utpt+/BglvPHroUEu+TkDjY87suOLApfLuo6R3EH1Q2TW2gGDpkYtpBy/ehBxFmO0/NlM90cq7P2i0qTYb1MZU0qyirTcolapaU6MDTJLQwyLqyX33n8/SIir9j263pJYUYsdL3it+UAklj2SOA7ORaVFU2bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673367; c=relaxed/simple;
	bh=QNLEtU2gAXwisrjGI1KUKbwZUbIDW5O/zH8qE4dtVuM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JiRjXMPEBeWl5VbN5qTqKXaN1iYaHR+1wmzszCOZmwECyiniGefTRjfz5Snq3EeH2vWE1aG8mzheVdPohCeq3MsZSCff/4sxEvELKNqcF9gXv4sgOBAXK2WcHrp2vyBGUt03UpQN7zi3daNG/tC0MVIfOwq9bTjeezgP9i4QAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=eNTmaXtC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="eNTmaXtC"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64DBtlaE7894736, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1778673347;
	bh=aFgmtCM3d5U6EHfwFqCVy+UTgjK8q/rV1K2HXWfQ7ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eNTmaXtCGdT6QL3mpJDtkFDOX5RltTW0+wqOGQ/lzLPVCK0JkSXvFdssiYmKLUBc5
	 XOI6K6/OZk0zCA0h2+vr3vHxjpAIbPgt9x76l6AmsdGEk+QjxgiGSyO/c39GVlBYpi
	 7U+BKTXwJXmPTe0OZfPnh3zvtBdIBUErVDTx/RTZ0K27h3rDe9BEDVTY/nD5fVFO62
	 ZRnakLbp14IjigjVE2FDlUs77mvYUl/hj1hCXl/xCHkdm0exHQJMRaIfLtOyLvHg/D
	 ZUYgquPE8dqm9wadmi9Gx5KtRkB8ufo/Xm2rWfUPguN8dw5bd6yFRx3NEZbCg3eyrv
	 rbCXEXggNEFpQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64DBtlaE7894736
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 13 May 2026 19:55:47 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 13 May 2026 19:55:46 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 13 May 2026 19:55:46 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [Patch net-next v3 3/7] r8169: add support for new interrupt mapping
Date: Wed, 13 May 2026 19:55:39 +0800
Message-ID: <20260513115543.1730-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260513115543.1730-1-javen_xu@realsil.com.cn>
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
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
ISR_VER_MAP_REG is the hardware register to indicate interrupt status.
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
---
 drivers/net/ethernet/realtek/r8169_main.c | 165 ++++++++++++++++++++--
 1 file changed, 151 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9dab0fbcca61..f259cc0cee37 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -78,6 +78,7 @@
 #define R8169_TX_STOP_THRS	(MAX_SKB_FRAGS + 1)
 #define R8169_TX_START_THRS	(2 * R8169_TX_STOP_THRS)
 #define R8169_MAX_RX_QUEUES	8
+#define R8127_MAX_TX_QUEUES	8
 #define R8169_MAX_MSIX_VEC	32
 #define R8127_MAX_RX_QUEUES	8
 #define R8169_DEFAULT_RX_QUEUES	1
@@ -451,8 +452,13 @@ enum rtl8125_registers {
 	RSS_CTRL_8125		= 0x4500,
 	Q_NUM_CTRL_8125		= 0x4800,
 	EEE_TXIDLE_TIMER_8125	= 0x6048,
+	IMR_CLEAR_VEC_MAP_REG	= 0x0d00,
+	ISR_VEC_MAP_REG		= 0x0d04,
+	IMR_SET_VEC_MAP_REG	= 0x0d0c,
 };
 
+#define MSIX_ID_VEC_MAP_LINKCHG	29
+#define RTL_VEC_MAP_ENABLE	BIT(0)
 #define LEDSEL_MASK_8125	0x23f
 
 #define RX_VLAN_INNER_8125	BIT(22)
@@ -583,6 +589,9 @@ enum rtl_register_content {
 
 	/* magic enable v2 */
 	MagicPacket_v2	= (1 << 16),	/* Wake up when receives a Magic Packet */
+#define	ISRIMR_LINKCHG	BIT(29)
+#define	ISRIMR_TOK_Q0	BIT(8)
+#define	ISRIMR_ROK_Q0	BIT(0)
 };
 
 enum rtl_isr_version {
@@ -778,6 +787,7 @@ struct rtl8169_private {
 	enum rtl_isr_version hw_curr_isr_ver;
 	u8 irq_nvecs;
 	bool recheck_desc_ownbit;
+	unsigned int features;
 	int irq;
 	struct clk *clk;
 
@@ -1676,26 +1686,36 @@ static u32 rtl_get_events(struct rtl8169_private *tp)
 
 static void rtl_ack_events(struct rtl8169_private *tp, u32 bits)
 {
-	if (rtl_is_8125(tp))
+	if (rtl_is_8125(tp)) {
 		RTL_W32(tp, IntrStatus_8125, bits);
-	else
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			RTL_W32(tp, ISR_VEC_MAP_REG, 0xffffffff);
+	} else {
 		RTL_W16(tp, IntrStatus, bits);
+	}
 }
 
 static void rtl_irq_disable(struct rtl8169_private *tp)
 {
-	if (rtl_is_8125(tp))
+	if (rtl_is_8125(tp)) {
 		RTL_W32(tp, IntrMask_8125, 0);
-	else
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			RTL_W32(tp, IMR_CLEAR_VEC_MAP_REG, 0xffffffff);
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
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			RTL_W32(tp, IMR_SET_VEC_MAP_REG, tp->irq_mask);
+		else
+			RTL_W32(tp, IntrMask_8125, tp->irq_mask);
+	} else {
 		RTL_W16(tp, IntrMask, tp->irq_mask);
+	}
 }
 
 static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
@@ -5070,6 +5090,42 @@ static void rtl8169_free_irq(struct rtl8169_private *tp)
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
+	struct rtl8169_private *tp = netdev_priv(dev);
+	int message_id = napi->index;
+
+	rtl8169_clear_hw_isr(tp, message_id);
+
+	if (message_id == MSIX_ID_VEC_MAP_LINKCHG) {
+		phy_mac_interrupt(tp->phydev);
+		return IRQ_HANDLED;
+	}
+
+	tp->recheck_desc_ownbit = true;
+	rtl8169_disable_hw_interrupt_msix(tp, message_id);
+	napi_schedule(napi);
+
+	return IRQ_HANDLED;
+}
+
 static int rtl8169_request_irq(struct rtl8169_private *tp)
 {
 	struct net_device *dev = tp->dev;
@@ -5078,8 +5134,12 @@ static int rtl8169_request_irq(struct rtl8169_private *tp)
 
 	for (int i = 0; i < tp->irq_nvecs; i++) {
 		napi = &tp->rtl8169_napi[i];
-		rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
-				     NULL, napi, "%s-%d", dev->name, i);
+		if (tp->features & RTL_VEC_MAP_ENABLE)
+			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt_msix,
+					     NULL, napi, "%s-%d", dev->name, i);
+		else
+			rc = pci_request_irq(tp->pci_dev, i, rtl8169_interrupt,
+					     NULL, napi, "%s-%d", dev->name, i);
 		if (rc)
 			break;
 	}
@@ -5523,10 +5583,16 @@ static const struct net_device_ops rtl_netdev_ops = {
 
 static void rtl_set_irq_mask(struct rtl8169_private *tp)
 {
-	tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
+	if (tp->features & RTL_VEC_MAP_ENABLE) {
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
@@ -5555,6 +5621,8 @@ static int rtl_alloc_irq(struct rtl8169_private *tp)
 		return nvecs;
 
 	tp->irq_nvecs = nvecs;
+	if (nvecs > 1)
+		tp->features |= RTL_VEC_MAP_ENABLE;
 
 	return 0;
 }
@@ -5822,10 +5890,79 @@ static bool rtl_aspm_is_safe(struct rtl8169_private *tp)
 	return false;
 }
 
+static int rtl8169_poll_msix_rx(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp = netdev_priv(dev);
+	const int message_id = napi->index;
+	int work_done = 0;
+
+	if (message_id < tp->num_rx_rings)
+		work_done += rtl_rx(dev, tp, &tp->rx_ring[message_id], budget);
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
+	struct rtl8169_private *tp = netdev_priv(dev);
+	const int message_id = napi->index;
+	int tx_ring_idx = message_id - 8;
+	unsigned int work_done = 0;
+
+	if (tx_ring_idx >= 0)
+		rtl_tx(dev, tp, budget);
+
+	if (work_done < budget && napi_complete_done(napi, work_done))
+		rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return work_done;
+}
+
+static int rtl8169_poll_msix_other(struct napi_struct *napi, int budget)
+{
+	struct net_device *dev = napi->dev;
+	struct rtl8169_private *tp = netdev_priv(dev);
+	const int message_id = napi - tp->rtl8169_napi;
+
+	napi_complete_done(napi, budget);
+	rtl8169_enable_hw_interrupt_msix(tp, message_id);
+
+	return 1;
+}
+
 static void r8169_init_napi(struct rtl8169_private *tp)
 {
-	for (int i = 0; i < tp->irq_nvecs; i++)
-		netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+	for (int i = 0; i < tp->irq_nvecs; i++) {
+		if (tp->features & RTL_VEC_MAP_ENABLE) {
+			switch (tp->hw_curr_isr_ver) {
+			case RTL_ISR_VER_8127:
+				if (i < R8127_MAX_RX_QUEUES)
+					netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
+						       rtl8169_poll_msix_rx);
+				else if (i >= R8127_MAX_RX_QUEUES &&
+					 i < (R8127_MAX_RX_QUEUES +
+					 R8127_MAX_TX_QUEUES))
+					netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
+						       rtl8169_poll_msix_tx);
+				else
+					netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
+						       rtl8169_poll_msix_other);
+				break;
+			default:
+				netif_napi_add(tp->dev, &tp->rtl8169_napi[i],
+					       rtl8169_poll);
+				break;
+			}
+		} else {
+			netif_napi_add(tp->dev, &tp->rtl8169_napi[i], rtl8169_poll);
+		}
+		tp->rtl8169_napi[i].index = i;
+	}
 }
 
 static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-- 
2.43.0

