Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B262D3A75;
	Thu,  3 Sep 2026 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420575; cv=none; b=AYFiRhndje54FSeLQdp5DRLZCFd7NiA0AIjc8eqhlK4G4kcsbPHthirRTncqSreJaRP+xOClczJ92rCC1QHCTLtSoFCxPVuC0tRXb+t2Bby9XFYV7Uh2bdLbIWlUeQt/h8PsSN4ImJYCqvf3jh/SfxW+1gY5MygiURDp+sLs4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420575; c=relaxed/simple;
	bh=Igb+iYGZbsFXlIKDs7XxvHb48lylOBFGEOkUhUkrpQA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S83U/KJYySTao+GyPHOIviFf0PSK7y95i8eHwi+1+IJlJXvS6jaYovh8oH1AK6MA3zalBrQHnF/cEYOabtdDH68WxfGG3pRGpgA7MFpsmd1Bcpz3UN+gLKwR+m09cOkz9gWZquFQzpt9wkGpMDhoE0DhZzNW5MJI6RFxCtG69lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=h0KpwKZh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="h0KpwKZh"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6837StFeA3295546, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788420535; bh=5dqnOGi9CHJAgSCF9mXu3o369dQk0ytOJZW9OZ2S7zs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=h0KpwKZhb0GbdDJ+SZlMI0KfWSz86M0e3e7ZDuczXH3va4USsE7o05ODkzvsZEHnO
	 o1tOljvnci+s1OU6fTQCzOMai6jKWwFAhRGw8//0P7FEeFIUdGVF0d4scZwCRFpQG1
	 7TrQLZh8rojasrg7Ci+emAe1/nrgTtjgvCMCtwi5CkolKVU/vQYijzGD2kAmQ3DGh/
	 WnTdPL9mFp8ZJQlIAW5+nY4COJeF1bC44vGZbAzSJ58OyCsAhn4cboFsiqOQKrRuP9
	 tnpSN3cD+otsoTwOs+qW8E1ee4yYXiZnvGb7NkGYMS3HtuFd5JsEvBv/uXnBI5lpD6
	 0Sh7/UfLCnc2Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6837StFeA3295546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 3 Sep 2026 15:28:55 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 3 Sep 2026 15:28:54 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Thu, 3 Sep 2026 15:28:54 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v2 7/8] r8152: support rtl_fc_pause_pkt_en()
Date: Thu, 3 Sep 2026 15:28:51 +0800
Message-ID: <20260903072852.58695-8-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903072852.58695-1-nic_swsd@realtek.com>
References: <20260903072852.58695-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The flow control patch was inline in r8156b_init and missing for RTL8156
and RTL8157/8159. Extract it as rtl_fc_pause_pkt_en(), call it from
r8156_init and r8156b_init during chip init, and call it from
rtl8157_enable with the current link speed for RTL8157 and RTL8159.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 112 ++++++++++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index b4253b00aa64e..2a96f3609c2b0 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -89,6 +89,7 @@
 #define PLA_MTPS		0xe615
 #define PLA_TXFIFO_CTRL		0xe618
 #define PLA_TXFIFO_FULL		0xe61a
+#define PLA_PAUSE_LIMIT         0xe61e
 #define PLA_RSTTALLY		0xe800
 #define PLA_CR			0xe813
 #define PLA_CRWECR		0xe81c
@@ -301,6 +302,10 @@
 #define MTPS_JUMBO		(12 * 1024 / 64)
 #define MTPS_DEFAULT		(6 * 1024 / 64)
 
+/* PLA_PAUSE_LIMIT */
+#define PAUSE_LIMIT_EN		BIT(3)
+#define PAUSE_LIMIT_MASK	0xf0
+
 /* PLA_RSTTALLY */
 #define TALLY_RESET		0x0001
 
@@ -6095,6 +6100,93 @@ static void r8152b_enter_oob(struct r8152 *tp)
 			   RCR_APM | RCR_AM | RCR_AB);
 }
 
+static void rtl_fc_pause_pkt_en(struct r8152 *tp, u16 speed)
+{
+	int log2_ratio, ratio;
+	u16 num_pause_pkts;
+	u32 ocp_data;
+
+	switch (tp->version) {
+	case RTL_VER_10:
+	case RTL_VER_11:
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
+			       CTRL_TIMER_EN | (1000 / 8));
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
+				  FLOW_CTRL_PATCH_OPT);
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+		break;
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
+
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
+
+		/* enable fc timer and set timer to 600 ms. */
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
+			       CTRL_TIMER_EN | (600 / 8));
+
+		ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
+		if (!(ocp_data & DACK_DET_EN))
+			ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
+					  FLOW_CTRL_PATCH_2);
+
+		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+		break;
+	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
+		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
+
+		num_pause_pkts = 0xa;
+		ratio = 10000;
+
+		if (!(speed & LINK_STATUS)) {
+			dev_dbg(&tp->intf->dev, "No link\n");
+			goto no_link;
+		} else if (speed & _10bps) {
+			ratio /= 10;
+		} else if (speed & _100bps) {
+			ratio /= 100;
+		} else if (speed & _1000bps) {
+			ratio /= 1000;
+		} else if (speed & _2500bps) {
+			ratio /= 2500;
+		} else if (speed & _5000bps) {
+			ratio /= 5000;
+		} else if (speed & _10000bps) {
+			ratio /= 10000;
+		} else {
+			dev_err(&tp->intf->dev, "Unknown link speed\n");
+			goto no_link;
+		}
+
+		log2_ratio = ilog2(ratio);
+		num_pause_pkts -= log2_ratio;
+
+		/* Round up if ratio is more than halfway to the next power of 2.
+		 * Floating-point is avoided by rewriting
+		 * ratio > 1.5 * 2^log2_ratio as
+		 * 2 * ratio > 3 * 2^log2_ratio
+		 */
+		if (2 * ratio > 3 * (1 << log2_ratio))
+			num_pause_pkts--;
+
+no_link:
+		ocp_word_w0w1(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
+			      PAUSE_LIMIT_MASK | PAUSE_LIMIT_EN,
+			      num_pause_pkts << 4);
+
+		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
+				  PAUSE_LIMIT_EN);
+		break;
+	default:
+		break;
+	}
+}
+
 static int r8153_pre_firmware_1(struct r8152 *tp)
 {
 	int i;
@@ -6626,6 +6718,8 @@ static int rtl8157_enable(struct r8152 *tp)
 	r8153_set_rx_early_size(tp);
 
 	speed = rtl8152_get_speed(tp);
+	rtl_fc_pause_pkt_en(tp, speed);
+
 	rtl_set_ifg(tp, speed);
 
 	return rtl_enable(tp);
@@ -8758,6 +8852,8 @@ static void r8156_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
+	rtl_fc_pause_pkt_en(tp, 0);
+
 	r8156_mac_clk_spd(tp, true);
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
@@ -8794,7 +8890,6 @@ static void r8156b_u2phy_backup(struct r8152 *tp)
 
 static void r8156b_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -8859,20 +8954,7 @@ static void r8156b_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
-
-	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
-
-	/* enable fc timer and set timer to 600 ms. */
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
-		       CTRL_TIMER_EN | (600 / 8));
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL);
-	if (!(ocp_data & DACK_DET_EN))
-		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_CTRL,
-				  FLOW_CTRL_PATCH_2);
-
-	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+	rtl_fc_pause_pkt_en(tp, 0);
 
 	r8156_mac_clk_spd(tp, true);
 
-- 
2.34.1

