Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386394;
	b=K5pPUc+Vom+0fUClqqnIzP3SwgK/Tpgi9RBlg696cX75IOmTgRlSr2c49aqEP+Iog2UW
	 a83nMUVO+iGU83vVupVBIuHc12CZ2vjxb5JS8avx+a43FGwd/lHdOTWUKpAfl4hoR5Vcz
	 QpwZhlzwOD3DfDuO3+Pb5Rx2zqy0PXr2M/YkP/apcFWUsHft1/AtkAH4L11yp3t4cPR67
	 kewxCAgfDVHUh+/+JG/5OiSDPiAYKhx0igGt3j0FXjWBizNJYI6mmTE/ixBPGU52hVqeO
	 Rl67Z2YcdDkSAJ4R5F5ctUYVSZK8/I6dtLMkS3zUdcWqA59zL/zYwmsoW98/G+M07gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386394;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=osEyBRk5MaMNj69bSjaspConj/pRuJ9LTvsPhMwPdhw=;
	b=a91EB1I3tvIt543REcTXe1ycYvla8jc4z/fmNdnBgPfusSl9NDD6//IjM4nebIdBGSJz
	 AtDhYJmzSiGCptTWaHbRwQPSB96Cz2j8nv+tumwiYWF9W58UN9UQGUbbHsN1pHQvIV3Fv
	 PLbYFb/hy35sC3gm3GfxOSbgBnT5idYmWymDt/L0QNqyOhoA1R/teSHbDqcgUT7i+kgkl
	 pR2W2r1AK6BPLUFW1OBvTZs7CssxPXavNO9i3Tm90dPSsrkj9gBY/42xBYCR0ekL/mBQx
	 4LRdaWzWo18DpARhCTDSPBaxIxioa5PDlL7cC+xsFAWWpfI48ohnelbBItstPU8Ks2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b="wnaBMI/I";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C287C606A321;
	Wed, 11 Nov 2026 08:39:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C287C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=wnaBMI/I
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AB8cHn852277996, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794386297;
	bh=osEyBRk5MaMNj69bSjaspConj/pRuJ9LTvsPhMwPdhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wnaBMI/I3CKJwZoiNTsKz4xRTpp1tj7idlc5aPy012oCOHYCGDf7G8O3MztGiHkkf
	 0WK3q3CqxqR8byPK8VLgtaEkBAOOJXQmgVpvpNva/sPNShapt87v4y777RYHbTno7v
	 TOjoUu4UcuZyqrGDjiB86juA6VD0hFM5XzSDmEw3mXxu5HOUwA46tdLx1WxuvOAtY+
	 8IFxpyWJd09Y8c/yE9aYS6SeYRuAnPpgcRwu5FkZqsE8qJt2j3xCupxWKLaCETV8wm
	 mNSzxItaF3pG+3md0wEL2as4TC0ZeT6kOl0W+nIcDWROAtqX0nTyPNSo0QqlkycpYn
	 sjWbVaAA7Hj0w==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AB8cHn852277996
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 11 Nov 2026 16:38:17 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 11 Nov 2026 16:38:17 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Wed, 11 Nov 2026 16:38:17 +0800
From: javen <javen_xu@realsil.com.cn>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <freddy_gu@realsil.com.cn>, <nb@tipi-net.de>,
	<maxime.chevallier@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <vladimir.oltean@nxp.com>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 2/2] net: phy: realtek: add hardware timestamping for RTL8127a
Date: Wed, 11 Nov 2026 16:38:07 +0800
Message-ID: <20261111083807.1529-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261111083807.1529-1-javen_xu@realsil.com.cn>
References: <20261111083807.1529-1-javen_xu@realsil.com.cn>
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

Add mii_timestamper support so that PTPv2 event messages are
timestamped by the RTL8127a internal PHY. The networking core
hands the packets and the hwtstamp configuration over to the PHY.

Only one TX timestamp can be pending at a time. Since the timestamps
are read via MDIO, which may sleep, both TX and RX timestamps are
retrieved from the PTP aux worker. A pending TX timestamp is dropped
after 15 seconds.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/phy/realtek/Kconfig       |  10 +-
 drivers/net/phy/realtek/realtek_ptp.c | 349 +++++++++++++++++++++++++-
 2 files changed, 352 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/realtek/Kconfig b/drivers/net/phy/realtek/Kconfig
index 93a8fb552834..ab375c42a7f2 100644
--- a/drivers/net/phy/realtek/Kconfig
+++ b/drivers/net/phy/realtek/Kconfig
@@ -16,12 +16,12 @@ config REALTEK_PHY_HWMON
 config REALTEK_PHY_PTP
 	bool "PTP support for Realtek PHYs"
 	default y
-	depends on PTP_1588_CLOCK
+	depends on PTP_1588_CLOCK && NETWORK_PHY_TIMESTAMPING
 	depends on !(REALTEK_PHY=y && PTP_1588_CLOCK=m)
 	help
-	  Optional PTP hardware clock support for the internal PHY of
-	  RTL8127A. The clock is provided by the PHY itself and can be
-	  read and adjusted through the PTP clock device, no support from
-	  the MAC driver is needed.
+	  Optional PTP hardware clock and hardware timestamping support
+	  for the internal PHY of RTL8127A. The PHY registers a PTP clock
+	  and timestamps PTPv2 event messages on behalf of the MAC, so no
+	  support from the MAC driver is needed.
 
 endif # REALTEK_PHY
diff --git a/drivers/net/phy/realtek/realtek_ptp.c b/drivers/net/phy/realtek/realtek_ptp.c
index bd5c0d6988da..5e0270762006 100644
--- a/drivers/net/phy/realtek/realtek_ptp.c
+++ b/drivers/net/phy/realtek/realtek_ptp.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * PTP hardware clock support for the internal PHY of RTL8127A
+ * PTP hardware clock and timestamping support for the internal PHY of
+ * RTL8127A
  */
 
 #include <linux/bitfield.h>
@@ -9,7 +10,9 @@
 #include <linux/math64.h>
 #include <linux/netdevice.h>
 #include <linux/phy.h>
+#include <linux/ptp_classify.h>
 #include <linux/ptp_clock_kernel.h>
+#include <linux/skbuff.h>
 #include <linux/timekeeping.h>
 
 #include "realtek.h"
@@ -28,8 +31,19 @@
 #define RTL8127A_PTP_CLK_CFG		0xe410
 #define  RTL8127A_PTP_CLK_CFG_EXEC	BIT(0)
 #define  RTL8127A_PTP_CLK_CFG_MODE	GENMASK(3, 1)
-/* Time registers */
+#define RTL8127A_PTP_TRX_TS_STA		0xe430
+#define  RTL8127A_PTP_TRX_TS_RD		BIT(0)
+#define  RTL8127A_PTP_TRX_TS_SEL_RX	BIT(1)
+#define  RTL8127A_PTP_TRX_TS_MSGTYPE	GENMASK(3, 2)
+#define  RTL8127A_PTP_TRX_TS_EXEC	BIT(4)
+#define  RTL8127A_PTP_TX_PDLYRSP_RDY	BIT(12)
+#define  RTL8127A_PTP_TX_PDLYREQ_RDY	BIT(13)
+#define  RTL8127A_PTP_TX_DLYREQ_RDY	BIT(14)
+#define  RTL8127A_PTP_TX_SYNC_RDY	BIT(15)
+#define  RTL8127A_PTP_TX_RDY		GENMASK(15, 12)
+/* Time registers, CFG_TIME for the clock, TRX_TS_TIME for packets */
 #define RTL8127A_PTP_CFG_TIME		0xe412
+#define RTL8127A_PTP_TRX_TS_TIME	0xe446
 #define  RTL8127A_PTP_NS_LO		0x0
 #define  RTL8127A_PTP_NS_HI		0x2
 #define  RTL8127A_PTP_S_LO		0x4
@@ -41,6 +55,7 @@
 #define  RTL8127A_PTP_RATE_HI_MASK	GENMASK(21, 16)
 
 #define RTL8127A_PTP_MAX_ADJ		488281
+#define RTL8127A_PTP_TX_TIMEOUT		(15 * HZ)
 
 /* RTL8127A_PTP_CLK_CFG clock adjust modes */
 enum rtl8127a_ptp_clkadj_mode {
@@ -51,11 +66,31 @@ enum rtl8127a_ptp_clkadj_mode {
 	RTL8127A_PTP_RATE_WRITE		= 14,
 };
 
+/* ptp->state bits */
+enum rtl8127a_ptp_state {
+	RTL8127A_PTP_TX_IN_PROGRESS,
+};
+
+struct rtl8127a_ptp_skb_cb {
+	u8 msgtype;
+};
+
+#define RTL8127A_PTP_SKB_CB(skb) \
+	((struct rtl8127a_ptp_skb_cb *)(skb)->cb)
+
 struct rtl8127a_ptp {
 	struct phy_device *phydev;
+	struct mii_timestamper mii_ts;
 	struct ptp_clock_info info;
 	struct ptp_clock *clock;
 	struct mutex lock;	/* serializes PTP register access sequences */
+	enum hwtstamp_tx_types tx_type;
+	enum hwtstamp_rx_filters rx_filter;
+	bool rx_enabled;
+	struct sk_buff_head rx_queue;
+	struct sk_buff *tx_skb;
+	unsigned long tx_start;
+	unsigned long state;
 };
 
 static int rtl8127a_ptp_read(struct rtl8127a_ptp *ptp, u16 reg)
@@ -171,6 +206,64 @@ static int rtl8127a_ptp_write_time(struct rtl8127a_ptp *ptp,
 	return 0;
 }
 
+/* Latch the RX or TX timestamp of the given message type into the
+ * RTL8127A_PTP_TRX_TS_TIME registers.
+ */
+static int rtl8127a_ptp_trx_ts_cmd(struct rtl8127a_ptp *ptp, u16 cmd)
+{
+	int ret;
+
+	ret = rtl8127a_ptp_modify(ptp, RTL8127A_PTP_TRX_TS_STA,
+				  RTL8127A_PTP_TRX_TS_SEL_RX |
+				  RTL8127A_PTP_TRX_TS_MSGTYPE,
+				  RTL8127A_PTP_TRX_TS_RD | cmd);
+	if (ret)
+		return ret;
+
+	ret = rtl8127a_ptp_poll(ptp, RTL8127A_PTP_TRX_TS_STA,
+				RTL8127A_PTP_TRX_TS_RD, false);
+
+	return ret < 0 ? ret : 0;
+}
+
+static int rtl8127a_ptp_egress_time(struct rtl8127a_ptp *ptp,
+				    struct timespec64 *ts)
+{
+	u8 msgtype;
+	int val;
+	int ret;
+
+	val = rtl8127a_ptp_poll(ptp, RTL8127A_PTP_TRX_TS_STA,
+				RTL8127A_PTP_TX_RDY, true);
+	if (val < 0)
+		val = 0;
+
+	switch (val & RTL8127A_PTP_TX_RDY) {
+	case RTL8127A_PTP_TX_PDLYRSP_RDY:
+		msgtype = PTP_MSGTYPE_PDELAY_RESP;
+		break;
+	case RTL8127A_PTP_TX_PDLYREQ_RDY:
+		msgtype = PTP_MSGTYPE_PDELAY_REQ;
+		break;
+	case RTL8127A_PTP_TX_DLYREQ_RDY:
+		msgtype = PTP_MSGTYPE_DELAY_REQ;
+		break;
+	case RTL8127A_PTP_TX_SYNC_RDY:
+	default:
+		msgtype = PTP_MSGTYPE_SYNC;
+		break;
+	}
+
+	ret = rtl8127a_ptp_trx_ts_cmd(ptp,
+				      FIELD_PREP(RTL8127A_PTP_TRX_TS_MSGTYPE,
+						 msgtype) |
+				      RTL8127A_PTP_TRX_TS_EXEC);
+	if (ret)
+		return ret;
+
+	return rtl8127a_ptp_read_time(ptp, RTL8127A_PTP_TRX_TS_TIME, ts);
+}
+
 static int rtl8127a_ptp_hwtstamp_enable(struct rtl8127a_ptp *ptp, bool enable)
 {
 	int ret;
@@ -306,6 +399,101 @@ static int rtl8127a_ptp_settime64(struct ptp_clock_info *info,
 	return rtl8127a_ptp_settime(ptp, ts);
 }
 
+static void rtl8127a_ptp_tx_complete(struct rtl8127a_ptp *ptp,
+				     struct skb_shared_hwtstamps *hwts)
+{
+	struct sk_buff *skb = ptp->tx_skb;
+
+	ptp->tx_skb = NULL;
+	clear_bit_unlock(RTL8127A_PTP_TX_IN_PROGRESS, &ptp->state);
+
+	if (hwts)
+		skb_complete_tx_timestamp(skb, hwts);
+	else
+		kfree_skb(skb);
+}
+
+/* Returns true if no TX timestamp is pending anymore */
+static bool rtl8127a_ptp_tx_tstamp(struct rtl8127a_ptp *ptp)
+{
+	struct skb_shared_hwtstamps hwts = {};
+	struct timespec64 ts;
+	int ret;
+
+	/* Pairs with smp_store_release() in rtl8127a_ptp_txtstamp() */
+	if (!smp_load_acquire(&ptp->tx_skb))
+		return true;
+
+	mutex_lock(&ptp->lock);
+
+	if (time_is_before_jiffies(ptp->tx_start + RTL8127A_PTP_TX_TIMEOUT)) {
+		rtl8127a_ptp_write(ptp, RTL8127A_PTP_INSR,
+				   RTL8127A_PTP_INT_TX_TS);
+		mutex_unlock(&ptp->lock);
+
+		rtl8127a_ptp_tx_complete(ptp, NULL);
+		return true;
+	}
+
+	ret = rtl8127a_ptp_read(ptp, RTL8127A_PTP_INSR);
+	if (ret < 0 || !(ret & RTL8127A_PTP_INT_TX_TS)) {
+		mutex_unlock(&ptp->lock);
+		return false;
+	}
+
+	ret = rtl8127a_ptp_write(ptp, RTL8127A_PTP_INSR,
+				 RTL8127A_PTP_INT_TX_TS);
+	if (!ret)
+		ret = rtl8127a_ptp_egress_time(ptp, &ts);
+
+	mutex_unlock(&ptp->lock);
+
+	if (ret) {
+		rtl8127a_ptp_tx_complete(ptp, NULL);
+		return true;
+	}
+
+	hwts.hwtstamp = timespec64_to_ktime(ts);
+	rtl8127a_ptp_tx_complete(ptp, &hwts);
+
+	return true;
+}
+
+static void rtl8127a_ptp_rx_tstamp(struct rtl8127a_ptp *ptp,
+				   struct sk_buff *skb)
+{
+	u8 msgtype = RTL8127A_PTP_SKB_CB(skb)->msgtype;
+	struct timespec64 ts;
+	int ret;
+
+	mutex_lock(&ptp->lock);
+	ret = rtl8127a_ptp_trx_ts_cmd(ptp, RTL8127A_PTP_TRX_TS_SEL_RX |
+					   FIELD_PREP(RTL8127A_PTP_TRX_TS_MSGTYPE,
+						      msgtype) |
+					   RTL8127A_PTP_TRX_TS_EXEC);
+	if (!ret)
+		ret = rtl8127a_ptp_read_time(ptp, RTL8127A_PTP_TRX_TS_TIME,
+					     &ts);
+	mutex_unlock(&ptp->lock);
+
+	if (!ret)
+		skb_hwtstamps(skb)->hwtstamp = timespec64_to_ktime(ts);
+
+	netif_rx(skb);
+}
+
+static long rtl8127a_ptp_do_aux_work(struct ptp_clock_info *info)
+{
+	struct rtl8127a_ptp *ptp = container_of(info, struct rtl8127a_ptp, info);
+	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&ptp->rx_queue)))
+		rtl8127a_ptp_rx_tstamp(ptp, skb);
+
+	/* Keep polling until the pending TX timestamp is available */
+	return rtl8127a_ptp_tx_tstamp(ptp) ? -1 : 0;
+}
+
 static const struct ptp_clock_info rtl8127a_ptp_info = {
 	.owner		= THIS_MODULE,
 	.name		= "RTL8127A PHC",
@@ -314,8 +502,146 @@ static const struct ptp_clock_info rtl8127a_ptp_info = {
 	.adjtime	= rtl8127a_ptp_adjtime,
 	.gettimex64	= rtl8127a_ptp_gettimex64,
 	.settime64	= rtl8127a_ptp_settime64,
+	.do_aux_work	= rtl8127a_ptp_do_aux_work,
 };
 
+static void rtl8127a_ptp_txtstamp(struct mii_timestamper *mii_ts,
+				  struct sk_buff *skb, int type)
+{
+	struct rtl8127a_ptp *ptp = container_of(mii_ts, struct rtl8127a_ptp,
+						mii_ts);
+
+	/* Only one TX timestamp can be pending at a time */
+	if (READ_ONCE(ptp->tx_type) != HWTSTAMP_TX_ON ||
+	    test_and_set_bit_lock(RTL8127A_PTP_TX_IN_PROGRESS, &ptp->state)) {
+		kfree_skb(skb);
+		return;
+	}
+
+	skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
+	ptp->tx_start = jiffies;
+	/* Publish tx_start before tx_skb to the aux worker */
+	smp_store_release(&ptp->tx_skb, skb);
+	ptp_schedule_worker(ptp->clock, 0);
+}
+
+static bool rtl8127a_ptp_rxtstamp(struct mii_timestamper *mii_ts,
+				  struct sk_buff *skb, int type)
+{
+	struct rtl8127a_ptp *ptp = container_of(mii_ts, struct rtl8127a_ptp,
+						mii_ts);
+	struct ptp_header *hdr;
+	u8 msgtype;
+
+	if (!READ_ONCE(ptp->rx_enabled))
+		return false;
+
+	hdr = ptp_parse_header(skb, type);
+	if (!hdr)
+		return false;
+
+	/* Only event messages are timestamped by the hardware */
+	msgtype = ptp_get_msgtype(hdr, type);
+	if (msgtype > PTP_MSGTYPE_PDELAY_RESP)
+		return false;
+
+	RTL8127A_PTP_SKB_CB(skb)->msgtype = msgtype;
+	skb_queue_tail(&ptp->rx_queue, skb);
+	ptp_schedule_worker(ptp->clock, 0);
+
+	return true;
+}
+
+static int rtl8127a_ptp_hwtstamp_get(struct mii_timestamper *mii_ts,
+				     struct kernel_hwtstamp_config *config)
+{
+	struct rtl8127a_ptp *ptp = container_of(mii_ts, struct rtl8127a_ptp,
+						mii_ts);
+
+	config->tx_type = ptp->tx_type;
+	config->rx_filter = ptp->rx_filter;
+
+	return 0;
+}
+
+static int rtl8127a_ptp_hwtstamp_set(struct mii_timestamper *mii_ts,
+				     struct kernel_hwtstamp_config *config,
+				     struct netlink_ext_ack *extack)
+{
+	struct rtl8127a_ptp *ptp = container_of(mii_ts, struct rtl8127a_ptp,
+						mii_ts);
+	bool enable = false;
+	bool rx_enabled;
+	int ret = 0;
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
+	if (ptp->tx_type != config->tx_type ||
+	    ptp->rx_filter != config->rx_filter) {
+		WRITE_ONCE(ptp->tx_type, config->tx_type);
+		ptp->rx_filter = config->rx_filter;
+		ret = rtl8127a_ptp_hwtstamp_enable(ptp, enable);
+	}
+	WRITE_ONCE(ptp->rx_enabled, rx_enabled);
+
+	return ret;
+}
+
+static int rtl8127a_ptp_ts_info(struct mii_timestamper *mii_ts,
+				struct kernel_ethtool_ts_info *info)
+{
+	struct rtl8127a_ptp *ptp = container_of(mii_ts, struct rtl8127a_ptp,
+						mii_ts);
+
+	info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
+				SOF_TIMESTAMPING_TX_HARDWARE |
+				SOF_TIMESTAMPING_RX_HARDWARE |
+				SOF_TIMESTAMPING_RAW_HARDWARE;
+	info->phc_index = ptp_clock_index(ptp->clock);
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
 int rtl8127a_ptp_config_init(struct phy_device *phydev)
 {
 	struct rtl8127a_ptp *ptp = phydev->priv;
@@ -348,6 +674,9 @@ int rtl8127a_ptp_probe(struct phy_device *phydev)
 
 	ptp->phydev = phydev;
 	ptp->info = rtl8127a_ptp_info;
+	ptp->tx_type = HWTSTAMP_TX_OFF;
+	ptp->rx_filter = HWTSTAMP_FILTER_NONE;
+	skb_queue_head_init(&ptp->rx_queue);
 
 	ret = rtl8127a_ptp_hwtstamp_enable(ptp, false);
 	if (ret)
@@ -357,7 +686,15 @@ int rtl8127a_ptp_probe(struct phy_device *phydev)
 	if (IS_ERR(ptp->clock))
 		return PTR_ERR(ptp->clock);
 
+	ptp->mii_ts.rxtstamp = rtl8127a_ptp_rxtstamp;
+	ptp->mii_ts.txtstamp = rtl8127a_ptp_txtstamp;
+	ptp->mii_ts.hwtstamp_set = rtl8127a_ptp_hwtstamp_set;
+	ptp->mii_ts.hwtstamp_get = rtl8127a_ptp_hwtstamp_get;
+	ptp->mii_ts.ts_info = rtl8127a_ptp_ts_info;
+
 	phydev->priv = ptp;
+	phydev->mii_ts = &ptp->mii_ts;
+	phydev->default_timestamp = true;
 
 	return 0;
 }
@@ -369,6 +706,14 @@ void rtl8127a_ptp_remove(struct phy_device *phydev)
 	if (!ptp)
 		return;
 
+	phydev->mii_ts = NULL;
+	phydev->default_timestamp = false;
+
 	rtl8127a_ptp_hwtstamp_enable(ptp, false);
+	/* Also stops the aux worker */
 	ptp_clock_unregister(ptp->clock);
+
+	if (ptp->tx_skb)
+		rtl8127a_ptp_tx_complete(ptp, NULL);
+	skb_queue_purge(&ptp->rx_queue);
 }
-- 
2.43.0

