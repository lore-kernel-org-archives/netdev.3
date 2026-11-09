Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191462;
	b=SoFKxp8tWkqSt4pNr3kzxwhrjfq8iSGUicEwbwpIxA54DWTVHMlgYzgMntIMDK9jnrYO
	 A+my3rpfWIno6m7bfENSd2KaZhRlRRuZ3R88+aBLpn5h6sKh/sLXhw9WQW7Ip8HbX1PHN
	 AqpQxWzoMiY1DlDgFV9Tok9oQygqtZ0OQtz06Ex1h28Mu9m/qZbgohkcwakIjhZOZREfY
	 tH2AgTqrW4fzsvjHhsuHF1yQTsbDJc4ttpdYygkvQt+7D5RUmHyzS5cdy9XrC6Li+0AGx
	 C6WUyiFbCwpgQLfnL3U26hB1QE0y+q43jF1jeCA32QB+NrttXnVxxFZiTXo/XQtQbjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191462;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=wnuuUZbzKdRf+M9AWppx6a8iTpAdFyn+sgK4PA/6bIc=;
	b=Om57Uba6xEZ7q5dNv8QQZ8Js04vf9PPqF4TjEe7BuGfi/xRiIfKDUZOJWaq/QO2GDV7g
	 TwMMF+YZk6y/zWnDnEdAO+u+Y60TRZz8afNUgPSrDZ0ums5rpPE9PPu0NUJmZ7Gxhjzbu
	 V7zWkzHVPeqfFkN2R63cinnjCZ+Kp+D3GVFYXYt4HOqCDU83npiEXZB0mZoazMT/uiOkV
	 pwcOOG2qUwIlXAh5V+11TfNaF4qep+1uuPdCsUdnLx7opcvvMfXO9O7L3tVtwCpOQ1rz/
	 kNaetqTQdt30widYOt00EqFfluE7BWYKOwI88D+5P+VeFs9pDP3HX/+tbqQf9ZmAOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=vXBNIx4I;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56213606A326;
	Mon,  9 Nov 2026 02:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56213606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=vXBNIx4I
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A92UQdZ43939940, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794191427;
	bh=wnuuUZbzKdRf+M9AWppx6a8iTpAdFyn+sgK4PA/6bIc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=vXBNIx4IEaNFkXIvdJJKR+GcZYvciuh6wEYX4zC4Ug5em9i3+lrBdY4H2YsapKP+Y
	 1laGd45s2d78tImT6cJgCtLN1YJUBNDCYIIjxoTDmjGPriZ53+4tcSaJPSKqxKRBq3
	 RnnMYxwS3plS+q1MunMqceRedd7/r9IP9t0doS1uomN2i0uw8b16A4iY1Ub9du/UlK
	 WzeK2pKohc2L5JsWvZ/6K854tIlXnUQN+2dJ3kTm0dZQ+OBWlI8moLTH3BHcoOTihc
	 Mey8Vlph08g0CSmGnc7CsiP7z/DGgMu618cK1qwg0XLm8mhwcnjbOh7Yp7IMspXKLh
	 LG440HIyZeRwQ==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A92UQdZ43939940
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Nov 2026 10:30:26 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS3.realsil.com.cn (172.29.17.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 10:30:25 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 9 Nov 2026 10:30:25 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 3/3] r8169: add hardware timestamping support for RTL8127a
Date: Mon, 9 Nov 2026 10:30:22 +0800
Message-ID: <20261109023022.770-4-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261109023022.770-1-javen_xu@realsil.com.cn>
References: <20261109023022.770-1-javen_xu@realsil.com.cn>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Add support for hardware timestamping of PTPv2 event messages on
RTL8127a:

- RX: the PHY latches the timestamp of the last received event message
  per message type. Read it back for PTP event messages and attach it
  to the skb.
- TX: one packet at a time can be timestamped. The hardware signals the
  availability of the TX timestamp in PTP_INSR, which is polled from a
  work item. Requests are dropped if no timestamp shows up within 15s.

The hardware does not filter by message type, so all PTPv2 RX filters
are reported as HWTSTAMP_FILTER_PTP_V2_EVENT.

TX timestamp statistics are exposed via ethtool get_ts_stats.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c |  56 ++++-
 drivers/net/ethernet/realtek/r8169_ptp.c  | 267 +++++++++++++++++++++-
 drivers/net/ethernet/realtek/r8169_ptp.h  |  28 ++-
 3 files changed, 348 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index fc3cfa09a57e..2ffb877ac2b4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5146,6 +5146,10 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
 
 	skb_tx_timestamp(skb);
 
+	if (tp->ptp_support &&
+	    unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
+		rtl8169_ptp_tx_tstamp(&tp->ptp, skb);
+
 	/* Force memory writes to complete before releasing descriptor */
 	dma_wmb();
 
@@ -5483,6 +5487,10 @@ static int rtl_rx(struct net_device *dev, struct rtl8169_private *tp,
 			rtl8169_rx_hash(tp, desc, skb);
 			skb_record_rx_queue(skb, ring - tp->rx_ring);
 		}
+
+		if (tp->ptp_support)
+			rtl8169_ptp_rx_tstamp(&tp->ptp, skb);
+
 		rtl8169_rx_csum(tp, skb, status);
 		skb->protocol = eth_type_trans(skb, dev);
 
@@ -6091,6 +6099,29 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	rtl_rar_set(tp, tp->dev->perm_addr);
 }
 
+static int rtl8169_hwtstamp_get(struct net_device *dev,
+				struct kernel_hwtstamp_config *config)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!tp->ptp_support)
+		return -EOPNOTSUPP;
+
+	return rtl8169_ptp_hwtstamp_get(&tp->ptp, config);
+}
+
+static int rtl8169_hwtstamp_set(struct net_device *dev,
+				struct kernel_hwtstamp_config *config,
+				struct netlink_ext_ack *extack)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!tp->ptp_support)
+		return -EOPNOTSUPP;
+
+	return rtl8169_ptp_hwtstamp_set(&tp->ptp, config, extack);
+}
+
 static const struct net_device_ops rtl_netdev_ops = {
 	.ndo_open		= rtl_open,
 	.ndo_stop		= rtl8169_close,
@@ -6105,6 +6136,8 @@ static const struct net_device_ops rtl_netdev_ops = {
 	.ndo_set_mac_address	= rtl_set_mac_address,
 	.ndo_eth_ioctl		= rtl8169_ioctl,
 	.ndo_set_rx_mode	= rtl_set_rx_mode,
+	.ndo_hwtstamp_get	= rtl8169_hwtstamp_get,
+	.ndo_hwtstamp_set	= rtl8169_hwtstamp_set,
 #ifdef CONFIG_NET_POLL_CONTROLLER
 	.ndo_poll_controller	= rtl8169_netpoll,
 #endif
@@ -6796,6 +6829,26 @@ static void rtl8169_get_channels(struct net_device *dev,
 	}
 }
 
+static int rtl8169_get_ts_info(struct net_device *dev,
+			       struct kernel_ethtool_ts_info *info)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (!tp->ptp_support)
+		return ethtool_op_get_ts_info(dev, info);
+
+	return rtl8169_ptp_get_ts_info(&tp->ptp, info);
+}
+
+static void rtl8169_get_ts_stats(struct net_device *dev,
+				 struct ethtool_ts_stats *ts_stats)
+{
+	struct rtl8169_private *tp = netdev_priv(dev);
+
+	if (tp->ptp_support)
+		rtl8169_ptp_get_ts_stats(&tp->ptp, ts_stats);
+}
+
 static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
@@ -6810,7 +6863,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
 	.get_strings		= rtl8169_get_strings,
 	.get_sset_count		= rtl8169_get_sset_count,
 	.get_ethtool_stats	= rtl8169_get_ethtool_stats,
-	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_ts_info		= rtl8169_get_ts_info,
+	.get_ts_stats		= rtl8169_get_ts_stats,
 	.nway_reset		= rtl8169_nway_reset,
 	.get_eee		= rtl8169_get_eee,
 	.set_eee		= rtl8169_set_eee,
diff --git a/drivers/net/ethernet/realtek/r8169_ptp.c b/drivers/net/ethernet/realtek/r8169_ptp.c
index 6201170e0c83..d31802583761 100644
--- a/drivers/net/ethernet/realtek/r8169_ptp.c
+++ b/drivers/net/ethernet/realtek/r8169_ptp.c
@@ -1,15 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* r8169_ptp.c: RealTek 8169/8168/8101/8125 ethernet driver.
  *
- * PTP hardware clock support for RTL8127A.
+ * PTP hardware clock and timestamping support for RTL8127A.
  */
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/ethtool.h>
 #include <linux/iopoll.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/ptp_classify.h>
+#include <linux/skbuff.h>
 #include <linux/timekeeping.h>
 
 #include "r8169.h"
@@ -30,6 +33,16 @@
 #define PTP_CLK_CFG			0xe410
 #define PTP_CLK_CFG_EXEC		BIT(0)
 #define PTP_CLK_CFG_MODE		GENMASK(3, 1)
+#define PTP_TRX_TS_STA			0xe430
+#define PTP_TRX_TS_RD			BIT(0)
+#define PTP_TRX_TS_SEL_RX		BIT(1)
+#define PTP_TRX_TS_MSGTYPE		GENMASK(3, 2)
+#define PTP_TRX_TS_EXEC			BIT(4)
+#define PTP_TRX_TS_TX_PDLYRSP_RDY	BIT(12)
+#define PTP_TRX_TS_TX_PDLYREQ_RDY	BIT(13)
+#define PTP_TRX_TS_TX_DLYREQ_RDY	BIT(14)
+#define PTP_TRX_TS_TX_SYNC_RDY		BIT(15)
+#define PTP_TRX_TS_TX_RDY		GENMASK(15, 12)
 /* Time registers, PTP_CFG_TIME for the clock, PTP_TRX_TS_TIME for packets */
 #define PTP_CFG_TIME			0xe412
 #define PTP_TRX_TS_TIME			0xe446
@@ -44,6 +57,12 @@
 #define PTP_RATE_HI_MASK		GENMASK(21, 16)
 
 #define PTP_MAX_ADJ			488281
+#define RTL8169_PTP_TX_TIMEOUT		(15 * HZ)
+
+/* ptp->state bits */
+enum rtl8169_ptp_state {
+	RTL8169_PTP_TX_IN_PROGRESS,
+};
 
 /* PTP_CLK_CFG clock adjust modes */
 enum rtl8169_ptp_clkadj_mode {
@@ -136,6 +155,48 @@ static void rtl8169_ptp_write_time(struct rtl8169_ptp *ptp,
 	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_S_HI, sec >> 32);
 }
 
+/* Latch the RX or TX timestamp of the given message type into the
+ * PTP_TRX_TS_TIME registers.
+ */
+static void rtl8169_ptp_trx_ts_cmd(struct rtl8169_ptp *ptp, u16 cmd)
+{
+	rtl8169_ptp_modify(ptp, PTP_TRX_TS_STA,
+			   PTP_TRX_TS_SEL_RX | PTP_TRX_TS_MSGTYPE,
+			   PTP_TRX_TS_RD | cmd);
+	rtl8169_ptp_poll(ptp, PTP_TRX_TS_STA, PTP_TRX_TS_RD, false);
+}
+
+static void rtl8169_ptp_egress_time(struct rtl8169_ptp *ptp,
+				    struct timespec64 *ts)
+{
+	u8 msgtype;
+	int val;
+
+	val = rtl8169_ptp_poll(ptp, PTP_TRX_TS_STA, PTP_TRX_TS_TX_RDY, true);
+	if (val < 0)
+		val = 0;
+
+	switch (val & PTP_TRX_TS_TX_RDY) {
+	case PTP_TRX_TS_TX_PDLYRSP_RDY:
+		msgtype = PTP_MSGTYPE_PDELAY_RESP;
+		break;
+	case PTP_TRX_TS_TX_PDLYREQ_RDY:
+		msgtype = PTP_MSGTYPE_PDELAY_REQ;
+		break;
+	case PTP_TRX_TS_TX_DLYREQ_RDY:
+		msgtype = PTP_MSGTYPE_DELAY_REQ;
+		break;
+	case PTP_TRX_TS_TX_SYNC_RDY:
+	default:
+		msgtype = PTP_MSGTYPE_SYNC;
+		break;
+	}
+
+	rtl8169_ptp_trx_ts_cmd(ptp, FIELD_PREP(PTP_TRX_TS_MSGTYPE, msgtype) |
+				    PTP_TRX_TS_EXEC);
+	rtl8169_ptp_read_time(ptp, PTP_TRX_TS_TIME, ts);
+}
+
 static void rtl8169_ptp_hwtstamp_enable(struct rtl8169_ptp *ptp, bool enable)
 {
 	unsigned long flags;
@@ -243,6 +304,201 @@ static const struct ptp_clock_info rtl8169_ptp_info = {
 	.settime64	= rtl8169_ptp_settime64,
 };
 
+static void rtl8169_ptp_tx_complete(struct rtl8169_ptp *ptp,
+				    struct skb_shared_hwtstamps *hwts)
+{
+	struct sk_buff *skb = ptp->tx_skb;
+
+	ptp->tx_skb = NULL;
+	clear_bit_unlock(RTL8169_PTP_TX_IN_PROGRESS, &ptp->state);
+
+	if (hwts)
+		skb_tstamp_tx(skb, hwts);
+	dev_kfree_skb_any(skb);
+}
+
+static void rtl8169_ptp_tx_work(struct work_struct *work)
+{
+	struct rtl8169_ptp *ptp = container_of(work, struct rtl8169_ptp,
+					       tx_work);
+	struct skb_shared_hwtstamps hwts = {};
+	struct timespec64 ts;
+	unsigned long flags;
+	bool ready;
+
+	if (!ptp->tx_skb)
+		return;
+
+	if (time_is_before_jiffies(ptp->tx_start + RTL8169_PTP_TX_TIMEOUT)) {
+		spin_lock_irqsave(&ptp->lock, flags);
+		rtl8169_ptp_write(ptp, PTP_INSR, PTP_INT_TX_TS);
+		spin_unlock_irqrestore(&ptp->lock, flags);
+
+		ptp->tx_timeouts++;
+		rtl8169_ptp_tx_complete(ptp, NULL);
+		return;
+	}
+
+	spin_lock_irqsave(&ptp->lock, flags);
+	ready = rtl8169_ptp_read(ptp, PTP_INSR) & PTP_INT_TX_TS;
+	if (ready) {
+		rtl8169_ptp_write(ptp, PTP_INSR, PTP_INT_TX_TS);
+		rtl8169_ptp_egress_time(ptp, &ts);
+	}
+	spin_unlock_irqrestore(&ptp->lock, flags);
+
+	if (!ready) {
+		schedule_work(&ptp->tx_work);
+		return;
+	}
+
+	hwts.hwtstamp = timespec64_to_ktime(ts);
+	ptp->tx_pkts++;
+	rtl8169_ptp_tx_complete(ptp, &hwts);
+}
+
+void rtl8169_ptp_tx_tstamp(struct rtl8169_ptp *ptp, struct sk_buff *skb)
+{
+	if (ptp->config.tx_type != HWTSTAMP_TX_ON ||
+	    test_and_set_bit_lock(RTL8169_PTP_TX_IN_PROGRESS, &ptp->state)) {
+		ptp->tx_skipped++;
+		return;
+	}
+
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	ptp->tx_skb = skb_get(skb);
+	ptp->tx_start = jiffies;
+	schedule_work(&ptp->tx_work);
+}
+
+void rtl8169_ptp_rx_tstamp(struct rtl8169_ptp *ptp, struct sk_buff *skb)
+{
+	unsigned int ptp_class;
+	struct ptp_header *hdr;
+	struct timespec64 ts;
+	unsigned long flags;
+	u8 msgtype;
+
+	if (!READ_ONCE(ptp->rx_enabled))
+		return;
+
+	ptp_class = ptp_classify_raw(skb);
+	if (ptp_class == PTP_CLASS_NONE)
+		return;
+
+	skb_reset_mac_header(skb);
+	hdr = ptp_parse_header(skb, ptp_class);
+	if (unlikely(!hdr))
+		return;
+
+	/* Only event messages are timestamped by the hardware */
+	msgtype = ptp_get_msgtype(hdr, ptp_class);
+	if (msgtype > PTP_MSGTYPE_PDELAY_RESP)
+		return;
+
+	spin_lock_irqsave(&ptp->lock, flags);
+	rtl8169_ptp_trx_ts_cmd(ptp, PTP_TRX_TS_SEL_RX |
+				    FIELD_PREP(PTP_TRX_TS_MSGTYPE, msgtype) |
+				    PTP_TRX_TS_EXEC);
+	rtl8169_ptp_read_time(ptp, PTP_TRX_TS_TIME, &ts);
+	spin_unlock_irqrestore(&ptp->lock, flags);
+
+	skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(ts);
+}
+
+int rtl8169_ptp_hwtstamp_get(struct rtl8169_ptp *ptp,
+			     struct kernel_hwtstamp_config *config)
+{
+	hwtstamp_config_to_kernel(config, &ptp->config);
+
+	return 0;
+}
+
+int rtl8169_ptp_hwtstamp_set(struct rtl8169_ptp *ptp,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
+{
+	bool enable = false;
+	bool rx_enabled;
+
+	if (!ptp->clock)
+		return -ENETDOWN;
+
+	if (config->flags)
+		return -EINVAL;
+
+	switch (config->tx_type) {
+	case HWTSTAMP_TX_ON:
+		enable = true;
+		break;
+	case HWTSTAMP_TX_OFF:
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	switch (config->rx_filter) {
+	case HWTSTAMP_FILTER_NONE:
+		rx_enabled = false;
+		break;
+	case HWTSTAMP_FILTER_PTP_V2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
+	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
+		config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		rx_enabled = true;
+		enable = true;
+		break;
+	default:
+		return -ERANGE;
+	}
+
+	if (ptp->config.tx_type != config->tx_type ||
+	    ptp->config.rx_filter != config->rx_filter) {
+		hwtstamp_config_from_kernel(&ptp->config, config);
+		rtl8169_ptp_hwtstamp_enable(ptp, enable);
+	}
+	WRITE_ONCE(ptp->rx_enabled, rx_enabled);
+
+	return 0;
+}
+
+int rtl8169_ptp_get_ts_info(struct rtl8169_ptp *ptp,
+			    struct kernel_ethtool_ts_info *info)
+{
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+
+	if (ptp->clock)
+		info->phc_index = ptp_clock_index(ptp->clock);
+
+	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_SYNC) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ) |
+			   BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ);
+
+	return 0;
+}
+
+void rtl8169_ptp_get_ts_stats(struct rtl8169_ptp *ptp,
+			      struct ethtool_ts_stats *stats)
+{
+	stats->pkts = ptp->tx_pkts;
+	stats->lost = ptp->tx_timeouts;
+	stats->err = ptp->tx_skipped;
+}
+
 void rtl8169_ptp_set_local_time(struct rtl8169_ptp *ptp)
 {
 	struct timespec64 ts;
@@ -267,6 +523,8 @@ void rtl8169_ptp_init(struct rtl8169_ptp *ptp)
 	}
 	ptp->clock = clock;
 
+	ptp->config.tx_type = HWTSTAMP_TX_OFF;
+	ptp->config.rx_filter = HWTSTAMP_FILTER_NONE;
 	rtl8169_ptp_hwtstamp_enable(ptp, false);
 }
 
@@ -275,7 +533,13 @@ void rtl8169_ptp_stop(struct rtl8169_ptp *ptp)
 	if (!ptp->clock)
 		return;
 
+	ptp->config.tx_type = HWTSTAMP_TX_OFF;
+	ptp->config.rx_filter = HWTSTAMP_FILTER_NONE;
+	WRITE_ONCE(ptp->rx_enabled, false);
 	rtl8169_ptp_hwtstamp_enable(ptp, false);
+	cancel_work_sync(&ptp->tx_work);
+	if (ptp->tx_skb)
+		rtl8169_ptp_tx_complete(ptp, NULL);
 
 	ptp_clock_unregister(ptp->clock);
 	ptp->clock = NULL;
@@ -288,4 +552,5 @@ void rtl8169_ptp_setup(struct rtl8169_ptp *ptp, struct rtl8169_private *tp,
 	ptp->dev = dev;
 	ptp->parent = parent;
 	spin_lock_init(&ptp->lock);
+	INIT_WORK(&ptp->tx_work, rtl8169_ptp_tx_work);
 }
diff --git a/drivers/net/ethernet/realtek/r8169_ptp.h b/drivers/net/ethernet/realtek/r8169_ptp.h
index e0b342b82283..cb3d6a04096b 100644
--- a/drivers/net/ethernet/realtek/r8169_ptp.h
+++ b/drivers/net/ethernet/realtek/r8169_ptp.h
@@ -1,18 +1,24 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /* r8169_ptp.h: RealTek 8169/8168/8101/8125 ethernet driver.
  *
- * PTP hardware clock support.
+ * PTP hardware clock and timestamping support.
  */
 
 #ifndef _R8169_PTP_H
 #define _R8169_PTP_H
 
+#include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 struct device;
+struct ethtool_ts_stats;
+struct kernel_ethtool_ts_info;
 struct net_device;
+struct netlink_ext_ack;
 struct rtl8169_private;
+struct sk_buff;
 
 struct rtl8169_ptp {
 	struct rtl8169_private *tp;
@@ -21,6 +27,15 @@ struct rtl8169_ptp {
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	spinlock_t lock;	/* serialize PTP register access sequences */
+	struct hwtstamp_config config;
+	bool rx_enabled;
+	struct work_struct tx_work;
+	struct sk_buff *tx_skb;
+	unsigned long tx_start;
+	unsigned long state;
+	u64 tx_pkts;
+	u64 tx_timeouts;
+	u64 tx_skipped;
 };
 
 void rtl8169_ptp_setup(struct rtl8169_ptp *ptp, struct rtl8169_private *tp,
@@ -28,5 +43,16 @@ void rtl8169_ptp_setup(struct rtl8169_ptp *ptp, struct rtl8169_private *tp,
 void rtl8169_ptp_init(struct rtl8169_ptp *ptp);
 void rtl8169_ptp_stop(struct rtl8169_ptp *ptp);
 void rtl8169_ptp_set_local_time(struct rtl8169_ptp *ptp);
+void rtl8169_ptp_tx_tstamp(struct rtl8169_ptp *ptp, struct sk_buff *skb);
+void rtl8169_ptp_rx_tstamp(struct rtl8169_ptp *ptp, struct sk_buff *skb);
+int rtl8169_ptp_hwtstamp_get(struct rtl8169_ptp *ptp,
+			     struct kernel_hwtstamp_config *config);
+int rtl8169_ptp_hwtstamp_set(struct rtl8169_ptp *ptp,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack);
+int rtl8169_ptp_get_ts_info(struct rtl8169_ptp *ptp,
+			    struct kernel_ethtool_ts_info *info);
+void rtl8169_ptp_get_ts_stats(struct rtl8169_ptp *ptp,
+			      struct ethtool_ts_stats *stats);
 
 #endif /* _R8169_PTP_H */
-- 
2.43.0

