Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794191462;
	b=bFwymBV7v1i/46juWRGrd3Tj6UEvp69O65olMMVhN0VnD08AX1KQGZNexUtrvKfvAWhQ
	 yuQyqCeaDGMdMhhUdG3QlpZTDZk8j3JdG2NtcRWi1RuGdEkzMGnqEcDYfA6JjWBCnSEsr
	 WSm9R3HShABZhbLTA35PUMJCjXs4cs9xG85O1i49y5IWS/BpAE18S9BDCrhJpC6OEbPfS
	 X9O15jVmYFQVVIJw54agTGJHmVPdm7O6L9LbGQjAeosA/ZKpKX+obcqbx9QZX/uJmMBOD
	 HNK/JH4L3edsSjm4yPMrdy8szQI4b2ZIB6zOMt2jge475AEFdSWO95fSCTQxDmxr+Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794191462;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=d9mVzpuIYkqtFDIstHV1Jsc94J37U0ytmz+SznYbb2g=;
	b=f1TT6+TOGUPyUA5/aAdqO+PKSs9fY5DSqIDixgrWU18TbXeGN4Ren9xsQyjR1zMOgvC+
	 Sb7ZgEgM0yRjr0dIxiMVVYUfcF0qys5wMJgOiSiV9RMQATyIykg9RJEsbQODlllKczhC3
	 wqdBunGvf1XgsfmxkwSwpidAtW7mCDJODM1uugXFQ3GGjrC5BcgTaEskO7FnKCF+n6FAR
	 eisKqdGDJRwu7D3ChtbxRr5gx6WBsgjMLdUwVP1ZwaozYiAPgIB8CTD9Y3HMTwfyiEQWK
	 cwwjYyzD3jxKyGJQfeCBLbuSQfyZgd95ae7m0wSXNrtlc3JNWa+jYc2YjAs3sdG2X4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realsil.com.cn;
	spf=pass smtp.mailfrom=realsil.com.cn;
	dkim=pass header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=GOg8P9HV;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE6606A321;
	Mon,  9 Nov 2026 02:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81CE6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.a=rsa-sha256 header.s=dkim header.b=GOg8P9HV
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6A92UQdY43939940, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1794191426;
	bh=d9mVzpuIYkqtFDIstHV1Jsc94J37U0ytmz+SznYbb2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=GOg8P9HVH8kzA1DOl3NZ6OOsC7HWovNkzqtmGaS1av1qqhE/Urbeyyjv64panFJfu
	 cfbcM34ydg9bu3mzWBluZ4SSXxu8b46yN2dvs9lzVCY4lK4AoEivvIBJtPklup5Yvi
	 iwtGWq78vDBX8bD3CIHIl297FVzMjKjL5Q1l8hyreNOw6ZGvdYxiQAW/v5kurJrvgO
	 JvJfQY8SwfaM5i2Doo2diNva8GAZNpwrz4S2UKa3SEl9qEWx4dZ3KFy7aVa4RxahP9
	 3J/iwjdYO0VnND17iTvwLA18UkYgEgPoddFTwsWZ8krymi24CnH+ot2jdX2mBsOz1X
	 NqR28yiLjAz6A==
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6A92UQdY43939940
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
Subject: [PATCH net-next v1 2/3] r8169: add PTP hardware clock support for RTL8127a
Date: Mon, 9 Nov 2026 10:30:21 +0800
Message-ID: <20261109023022.770-3-javen_xu@realsil.com.cn>
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

RTL8127a has a PTP clock in its PHY, accessed through the PHY OCP
interface. Register it as a PTP hardware clock supporting adjfine,
adjtime, gettimex64 and settime64.

The clock is registered when the interface is opened and unregistered
when it is closed. It is initialized from the system time every time
the chip is brought up.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/Kconfig      |   1 +
 drivers/net/ethernet/realtek/Makefile     |   2 +-
 drivers/net/ethernet/realtek/r8169.h      |   2 +
 drivers/net/ethernet/realtek/r8169_main.c |  20 +-
 drivers/net/ethernet/realtek/r8169_ptp.c  | 291 ++++++++++++++++++++++
 drivers/net/ethernet/realtek/r8169_ptp.h  |  32 +++
 6 files changed, 345 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/realtek/r8169_ptp.c
 create mode 100644 drivers/net/ethernet/realtek/r8169_ptp.h

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 5818a9a500a8..985594a72fce 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -84,6 +84,7 @@ config 8139_OLD_RX_RESET
 config R8169
 	tristate "Realtek 8169/8168/8101/8125 ethernet support"
 	depends on PCI
+	depends on PTP_1588_CLOCK_OPTIONAL
 	select FW_LOADER
 	select CRC32
 	select REALTEK_PHY
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 12a9c399f40c..6434804775dc 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
-r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
+r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o r8169_ptp.o
 r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
 obj-$(CONFIG_R8169) += r8169.o
 obj-$(CONFIG_RTASE) += rtase/
diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
index fb772cc04310..f9d9d048c5c4 100644
--- a/drivers/net/ethernet/realtek/r8169.h
+++ b/drivers/net/ethernet/realtek/r8169.h
@@ -95,3 +95,5 @@ int rtl8125_get_led_mode(struct rtl8169_private *tp, int index);
 int rtl8125_set_led_mode(struct rtl8169_private *tp, int index, u16 mode);
 struct r8169_led_classdev *rtl8125_init_leds(struct net_device *ndev);
 void r8169_remove_leds(struct r8169_led_classdev *leds);
+int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg);
+void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data);
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 96d3a2bd7094..fc3cfa09a57e 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -37,6 +37,7 @@
 
 #include "r8169.h"
 #include "r8169_firmware.h"
+#include "r8169_ptp.h"
 
 #define FIRMWARE_8168D_1	"rtl_nic/rtl8168d-1.fw"
 #define FIRMWARE_8168D_2	"rtl_nic/rtl8168d-2.fw"
@@ -888,6 +889,7 @@ struct rtl8169_private {
 	unsigned supports_gmii:1;
 	unsigned aspm_manageable:1;
 	unsigned dash_enabled:1;
+	unsigned ptp_support:1;
 	dma_addr_t counters_phys_addr;
 	struct rtl8169_counters *counters;
 	struct rtl8169_tc_offsets tc_offset;
@@ -902,6 +904,8 @@ struct rtl8169_private {
 	struct phylink *phylink;
 	struct phylink_config phylink_config;
 	struct phylink_pcs pcs;
+
+	struct rtl8169_ptp ptp;
 };
 
 typedef void (*rtl_generic_fct)(struct rtl8169_private *tp);
@@ -1252,7 +1256,7 @@ static int rtl_phy_ocp_wait(struct rtl8169_private *tp, bool high)
 	return ret;
 }
 
-static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
+void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
 	unsigned long flags;
 
@@ -1265,7 +1269,7 @@ static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 	spin_unlock_irqrestore(&tp->phy_ocp_lock, flags);
 }
 
-static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
+int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
 {
 	unsigned long flags;
 	int val;
@@ -5780,6 +5784,9 @@ static void rtl8169_up(struct rtl8169_private *tp)
 	rtl8169_napi_enable(tp);
 	enable_work(&tp->wk.work);
 	rtl_reset_work(tp);
+
+	if (tp->ptp_support)
+		rtl8169_ptp_set_local_time(&tp->ptp);
 }
 
 static int rtl8169_close(struct net_device *dev)
@@ -5791,6 +5798,8 @@ static int rtl8169_close(struct net_device *dev)
 
 	phylink_stop(tp->phylink);
 	netif_stop_queue(dev);
+	if (tp->ptp_support)
+		rtl8169_ptp_stop(&tp->ptp);
 	rtl8169_down(tp);
 	for (int i = 0; i < tp->num_rx_rings; i++)
 		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
@@ -5861,6 +5870,8 @@ static int rtl_open(struct net_device *dev)
 	}
 	rtl8169_up(tp);
 	phylink_start(tp->phylink);
+	if (tp->ptp_support)
+		rtl8169_ptp_init(&tp->ptp);
 	rtl8169_init_counter_offsets(tp);
 	netif_start_queue(dev);
 out:
@@ -6904,6 +6915,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	tp->dash_type = rtl_get_dash_type(tp);
 	tp->dash_enabled = rtl_dash_is_enabled(tp);
 
+	tp->ptp_support = IS_ENABLED(CONFIG_PTP_1588_CLOCK) &&
+			  tp->mac_version == RTL_GIGA_MAC_VER_80;
+	if (tp->ptp_support)
+		rtl8169_ptp_setup(&tp->ptp, tp, dev, &pdev->dev);
+
 	if (rtl_hw_support_rss(tp)) {
 		tp->rss_data = devm_kzalloc(&pdev->dev, sizeof(*tp->rss_data),
 					    GFP_KERNEL);
diff --git a/drivers/net/ethernet/realtek/r8169_ptp.c b/drivers/net/ethernet/realtek/r8169_ptp.c
new file mode 100644
index 000000000000..6201170e0c83
--- /dev/null
+++ b/drivers/net/ethernet/realtek/r8169_ptp.c
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* r8169_ptp.c: RealTek 8169/8168/8101/8125 ethernet driver.
+ *
+ * PTP hardware clock support for RTL8127A.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/iopoll.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/timekeeping.h>
+
+#include "r8169.h"
+#include "r8169_ptp.h"
+
+/* PTP registers, accessed through the PHY OCP interface */
+#define PTP_CTL				0xe400
+#define PTP_CTL_EN			BIT(0)
+#define PTP_CTL_TYPE_3			0x003f
+#define PTP_INER			0xe402
+#define PTP_INSR			0xe404
+#define PTP_INT_RX_TS			BIT(2)
+#define PTP_INT_TX_TS			BIT(3)
+#define PTP_SYNCE_CTL			0xe406
+#define PTP_SYNCE_EN			BIT(0)
+#define PTP_GEN_CFG			0xe408
+#define PTP_GEN_CFG_INT_CLR_MODE	BIT(0)
+#define PTP_CLK_CFG			0xe410
+#define PTP_CLK_CFG_EXEC		BIT(0)
+#define PTP_CLK_CFG_MODE		GENMASK(3, 1)
+/* Time registers, PTP_CFG_TIME for the clock, PTP_TRX_TS_TIME for packets */
+#define PTP_CFG_TIME			0xe412
+#define PTP_TRX_TS_TIME			0xe446
+#define PTP_TIME_NS_LO			0x0
+#define PTP_TIME_NS_HI			0x2
+#define PTP_TIME_S_LO			0x4
+#define PTP_TIME_S_MI			0x6
+#define PTP_TIME_S_HI			0x8
+#define PTP_TIME_NS_HI_MASK		GENMASK(13, 0)
+#define PTP_TIME_NSEC_MASK		GENMASK(29, 0)
+#define PTP_TIME_SEC_MASK		GENMASK_ULL(47, 0)
+#define PTP_RATE_HI_MASK		GENMASK(21, 16)
+
+#define PTP_MAX_ADJ			488281
+
+/* PTP_CLK_CFG clock adjust modes */
+enum rtl8169_ptp_clkadj_mode {
+	PTP_CLKADJ_DIRECT_READ		= 4,
+	PTP_CLKADJ_DIRECT_WRITE		= 6,
+	PTP_CLKADJ_INC_STEP		= 8,
+	PTP_CLKADJ_DEC_STEP		= 10,
+	PTP_CLKADJ_RATE_WRITE		= 14,
+};
+
+static u16 rtl8169_ptp_read(struct rtl8169_ptp *ptp, u32 reg)
+{
+	return r8168_phy_ocp_read(ptp->tp, reg);
+}
+
+static void rtl8169_ptp_write(struct rtl8169_ptp *ptp, u32 reg, u16 val)
+{
+	r8168_phy_ocp_write(ptp->tp, reg, val);
+}
+
+static void rtl8169_ptp_modify(struct rtl8169_ptp *ptp, u32 reg, u16 mask,
+			       u16 set)
+{
+	u16 val = rtl8169_ptp_read(ptp, reg);
+
+	rtl8169_ptp_write(ptp, reg, (val & ~mask) | set);
+}
+
+/* Poll until (reg & mask) is non-zero (set == true) or zero (set == false).
+ * Returns the last register value read, or -ETIMEDOUT.
+ */
+static int rtl8169_ptp_poll(struct rtl8169_ptp *ptp, u32 reg, u16 mask,
+			    bool set)
+{
+	u16 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtl8169_ptp_read, val,
+				       !!(val & mask) == set, 1, 1000, false,
+				       ptp, reg);
+	if (ret) {
+		if (net_ratelimit())
+			netdev_err(ptp->dev, "PTP reg 0x%04x poll timeout\n",
+				   reg);
+		return ret;
+	}
+
+	return val;
+}
+
+static void rtl8169_ptp_clkadj(struct rtl8169_ptp *ptp,
+			       enum rtl8169_ptp_clkadj_mode mode)
+{
+	rtl8169_ptp_modify(ptp, PTP_CLK_CFG, PTP_CLK_CFG_MODE,
+			   PTP_CLK_CFG_EXEC | mode);
+	rtl8169_ptp_poll(ptp, PTP_CLK_CFG, PTP_CLK_CFG_EXEC, false);
+}
+
+static void rtl8169_ptp_read_time(struct rtl8169_ptp *ptp, u32 base,
+				  struct timespec64 *ts)
+{
+	u64 sec;
+	u32 nsec;
+
+	nsec = rtl8169_ptp_read(ptp, base + PTP_TIME_NS_HI) &
+	       PTP_TIME_NS_HI_MASK;
+	nsec <<= 16;
+	nsec |= rtl8169_ptp_read(ptp, base + PTP_TIME_NS_LO);
+
+	sec = rtl8169_ptp_read(ptp, base + PTP_TIME_S_HI);
+	sec <<= 16;
+	sec |= rtl8169_ptp_read(ptp, base + PTP_TIME_S_MI);
+	sec <<= 16;
+	sec |= rtl8169_ptp_read(ptp, base + PTP_TIME_S_LO);
+
+	ts->tv_sec = sec;
+	ts->tv_nsec = nsec;
+}
+
+static void rtl8169_ptp_write_time(struct rtl8169_ptp *ptp,
+				   const struct timespec64 *ts)
+{
+	u64 sec = ts->tv_sec & PTP_TIME_SEC_MASK;
+	u32 nsec = ts->tv_nsec & PTP_TIME_NSEC_MASK;
+
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_NS_LO, nsec);
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_NS_HI, nsec >> 16);
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_S_LO, sec);
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_S_MI, sec >> 16);
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_S_HI, sec >> 32);
+}
+
+static void rtl8169_ptp_hwtstamp_enable(struct rtl8169_ptp *ptp, bool enable)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ptp->lock, flags);
+
+	rtl8169_ptp_modify(ptp, PTP_SYNCE_CTL, PTP_SYNCE_EN, 0);
+	if (enable) {
+		rtl8169_ptp_modify(ptp, PTP_INER, 0,
+				   PTP_INT_RX_TS | PTP_INT_TX_TS);
+		rtl8169_ptp_modify(ptp, PTP_GEN_CFG, 0,
+				   PTP_GEN_CFG_INT_CLR_MODE);
+		rtl8169_ptp_write(ptp, PTP_INSR, 0xffff);
+		rtl8169_ptp_write(ptp, PTP_CTL, PTP_CTL_TYPE_3 | BIT(12));
+	} else {
+		rtl8169_ptp_modify(ptp, PTP_INER,
+				   PTP_INT_RX_TS | PTP_INT_TX_TS, 0);
+		rtl8169_ptp_modify(ptp, PTP_CTL, PTP_CTL_EN, 0);
+	}
+	rtl8169_ptp_modify(ptp, 0xa640, 0, BIT(15));
+
+	spin_unlock_irqrestore(&ptp->lock, flags);
+}
+
+static void rtl8169_ptp_settime(struct rtl8169_ptp *ptp,
+				const struct timespec64 *ts)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ptp->lock, flags);
+	rtl8169_ptp_write_time(ptp, ts);
+	rtl8169_ptp_clkadj(ptp, PTP_CLKADJ_DIRECT_WRITE);
+	spin_unlock_irqrestore(&ptp->lock, flags);
+}
+
+static int rtl8169_ptp_adjfine(struct ptp_clock_info *info, long scaled_ppm)
+{
+	struct rtl8169_ptp *ptp = container_of(info, struct rtl8169_ptp, info);
+	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
+	unsigned long flags;
+	u32 rate;
+
+	rate = div_u64((u64)abs(ppb) << 32, NSEC_PER_SEC);
+	if (ppb < 0)
+		rate = -rate;
+
+	spin_lock_irqsave(&ptp->lock, flags);
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_NS_LO, rate);
+	rtl8169_ptp_write(ptp, PTP_CFG_TIME + PTP_TIME_NS_HI,
+			  FIELD_GET(PTP_RATE_HI_MASK, rate));
+	rtl8169_ptp_clkadj(ptp, PTP_CLKADJ_RATE_WRITE);
+	spin_unlock_irqrestore(&ptp->lock, flags);
+
+	return 0;
+}
+
+static int rtl8169_ptp_adjtime(struct ptp_clock_info *info, s64 delta)
+{
+	struct rtl8169_ptp *ptp = container_of(info, struct rtl8169_ptp, info);
+	struct timespec64 d = ns_to_timespec64(abs(delta));
+	unsigned long flags;
+
+	spin_lock_irqsave(&ptp->lock, flags);
+	rtl8169_ptp_write_time(ptp, &d);
+	rtl8169_ptp_clkadj(ptp, delta < 0 ? PTP_CLKADJ_DEC_STEP :
+					    PTP_CLKADJ_INC_STEP);
+	spin_unlock_irqrestore(&ptp->lock, flags);
+
+	return 0;
+}
+
+static int rtl8169_ptp_gettimex64(struct ptp_clock_info *info,
+				  struct timespec64 *ts,
+				  struct ptp_system_timestamp *sts)
+{
+	struct rtl8169_ptp *ptp = container_of(info, struct rtl8169_ptp, info);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ptp->lock, flags);
+	ptp_read_system_prets(sts);
+	rtl8169_ptp_clkadj(ptp, PTP_CLKADJ_DIRECT_READ);
+	ptp_read_system_postts(sts);
+	rtl8169_ptp_read_time(ptp, PTP_CFG_TIME, ts);
+	spin_unlock_irqrestore(&ptp->lock, flags);
+
+	return 0;
+}
+
+static int rtl8169_ptp_settime64(struct ptp_clock_info *info,
+				 const struct timespec64 *ts)
+{
+	struct rtl8169_ptp *ptp = container_of(info, struct rtl8169_ptp, info);
+
+	rtl8169_ptp_settime(ptp, ts);
+
+	return 0;
+}
+
+static const struct ptp_clock_info rtl8169_ptp_info = {
+	.owner		= THIS_MODULE,
+	.max_adj	= PTP_MAX_ADJ,
+	.adjfine	= rtl8169_ptp_adjfine,
+	.adjtime	= rtl8169_ptp_adjtime,
+	.gettimex64	= rtl8169_ptp_gettimex64,
+	.settime64	= rtl8169_ptp_settime64,
+};
+
+void rtl8169_ptp_set_local_time(struct rtl8169_ptp *ptp)
+{
+	struct timespec64 ts;
+
+	ktime_get_real_ts64(&ts);
+	rtl8169_ptp_settime(ptp, &ts);
+}
+
+void rtl8169_ptp_init(struct rtl8169_ptp *ptp)
+{
+	struct ptp_clock *clock;
+
+	ptp->info = rtl8169_ptp_info;
+	snprintf(ptp->info.name, sizeof(ptp->info.name), "%pm",
+		 ptp->dev->dev_addr);
+
+	clock = ptp_clock_register(&ptp->info, ptp->parent);
+	if (IS_ERR(clock)) {
+		netdev_err(ptp->dev, "failed to register PTP clock: %pe\n",
+			   clock);
+		return;
+	}
+	ptp->clock = clock;
+
+	rtl8169_ptp_hwtstamp_enable(ptp, false);
+}
+
+void rtl8169_ptp_stop(struct rtl8169_ptp *ptp)
+{
+	if (!ptp->clock)
+		return;
+
+	rtl8169_ptp_hwtstamp_enable(ptp, false);
+
+	ptp_clock_unregister(ptp->clock);
+	ptp->clock = NULL;
+}
+
+void rtl8169_ptp_setup(struct rtl8169_ptp *ptp, struct rtl8169_private *tp,
+		       struct net_device *dev, struct device *parent)
+{
+	ptp->tp = tp;
+	ptp->dev = dev;
+	ptp->parent = parent;
+	spin_lock_init(&ptp->lock);
+}
diff --git a/drivers/net/ethernet/realtek/r8169_ptp.h b/drivers/net/ethernet/realtek/r8169_ptp.h
new file mode 100644
index 000000000000..e0b342b82283
--- /dev/null
+++ b/drivers/net/ethernet/realtek/r8169_ptp.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* r8169_ptp.h: RealTek 8169/8168/8101/8125 ethernet driver.
+ *
+ * PTP hardware clock support.
+ */
+
+#ifndef _R8169_PTP_H
+#define _R8169_PTP_H
+
+#include <linux/ptp_clock_kernel.h>
+#include <linux/spinlock.h>
+
+struct device;
+struct net_device;
+struct rtl8169_private;
+
+struct rtl8169_ptp {
+	struct rtl8169_private *tp;
+	struct net_device *dev;
+	struct device *parent;
+	struct ptp_clock_info info;
+	struct ptp_clock *clock;
+	spinlock_t lock;	/* serialize PTP register access sequences */
+};
+
+void rtl8169_ptp_setup(struct rtl8169_ptp *ptp, struct rtl8169_private *tp,
+		       struct net_device *dev, struct device *parent);
+void rtl8169_ptp_init(struct rtl8169_ptp *ptp);
+void rtl8169_ptp_stop(struct rtl8169_ptp *ptp);
+void rtl8169_ptp_set_local_time(struct rtl8169_ptp *ptp);
+
+#endif /* _R8169_PTP_H */
-- 
2.43.0

