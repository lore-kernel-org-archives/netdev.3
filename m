Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462CB40862C;
	Wed,  2 Sep 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340038; cv=none; b=WNH8205Fn9SZabvG8h/st4v9aH3GhQO8Tsf+ATvgp17tH8VZHKVS1jk9NfABVTA8y3J0G6YASjLaSnZQ/XUn2gAxVKKtSV5POgG0NGliUrncItu+WNGT3aj243f6ui3y4oGzsA1XwNhzFddmZofwU8YfQrptvQS9ydRi/v20RGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340038; c=relaxed/simple;
	bh=ZgwMiCRMiQRoUedHJi1pBIY7n65L2/cMrQkdHgYvU2A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1e2Ca3auvaCzblu/YU9FPvdeEymBXAk1R4RKcwnobQRdZPHk8cwVNgSYNlbJuaxc1ZO774V/QnOscgJnAOgIaNkbImLDw3nbPsr2uGFRHj0ClcnXnOjYWZTNlEXzUWfTbTL0O/8dqV2XAwt/IEi+0zdC1eS+o3tR6ElWTTW5U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HjLhwMwF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HjLhwMwF"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68296ludE2527063, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788340007; bh=G5xsiccBkEHfnRpkRmHfVI11EGDnUIqijPdpM/xlsuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HjLhwMwFjJQuq0X+LfBs3P7o7nMpotaM92kFzv3FN2c/MaEJCK6W503An2dXDTxzN
	 TizQYk48vgB9hkCmLtdn0TEYBMIEBm0cE9MzeUBGDBaifipTrG8ZVkYGd2G3A/9SQ4
	 C9g2q4g4BftVBEZTliGmMsvse0u9XXBWPPRmqXfNbT/5A75PVkItNaphXRs74Jh89R
	 6xb2mQbXEusbJMaNhtMkD8Fiep5SRZQKXdaIirgmpD6k+MP/dktMGAgvqwk8yrdK4v
	 neWnW7u8fmgwqULwrqJMZ03ritjiqBJj81eukN5R0CHqIYyMGKbVZUjRnY15/2hINJ
	 SHGQcf0XZvKFg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68296ludE2527063
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 17:06:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 17:06:47 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Wed, 2 Sep 2026 17:06:47 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 7/8] r8152: support rtl_fc_pause_pkt_en()
Date: Wed, 2 Sep 2026 17:06:31 +0800
Message-ID: <20260902090632.41844-8-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260902090632.41844-1-nic_swsd@realtek.com>
References: <20260902090632.41844-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Refactor the flow control patch as the function rtl_fc_pause_pkt_en().
Moreover, support flow control patch for RTL8156, RTL8157 and RTL8159.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 112 ++++++++++++++++++++++++++++++++++------
 1 file changed, 97 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index b4c2cef0b9092..b809317de74f7 100644
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
@@ -8792,6 +8886,8 @@ static void r8156_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
+	rtl_fc_pause_pkt_en(tp, 0);
+
 	r8156_mac_clk_spd(tp, true);
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
@@ -8828,7 +8924,6 @@ static void r8156b_u2phy_backup(struct r8152 *tp)
 
 static void r8156b_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 	int i;
 
@@ -8901,20 +8996,7 @@ static void r8156b_init(struct r8152 *tp)
 
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

