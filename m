Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387545FFA8;
	Thu,  8 Oct 2026 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447412; cv=none; b=eQiNRrdU/d74sG9aw1dW7vFw3elAW6z8oTSHWqAQ6Ku5hPNVpwnAiL/6o+/wDNhC4QRFgzVKBOHC/84lsF1Vtjh9FxH8xdRgyeJyc38tWwMffWa9A34DUCOMvleJZRgIz1YSKGsQFdXYxoQHxJ465tJoXPHjMctCGXQHpXoQzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447412; c=relaxed/simple;
	bh=CY/WgCWznP9981NlOAIlsUkBQwo9PtICdW24b/XMLYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEB9bD2vEtO/W4ylrqA5TT659LVSuEKIbsLm7GkLu8THWQbYrBZj5+Dlur8cdSiK41GGaFk0NU0KJkiYS2X73b7lYBxHbuqGThUQ2t14sfisYhiVgWC10NgjWTG5luiVgEiijkCyfCw0H1h51cZAnkwSxbEm8+G1wVSbPNY1Ejw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=k5FkAdai; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="k5FkAdai"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6988G50R0315557, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791447365; bh=LP0OBh8ofTl3QPiKJADtWvc4V/nXsZmRuZvUb6VWvNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=k5FkAdaiAtU4yFgqzxsiACNcmWHWScAcYhVH8dX4Qv0AX7WZuu49s2iYdd4DqYVkf
	 Wp6Vy0fyxv2Ew/LcC+goJbazz255IcOw/XXOl6/MFFfiExM+A7mwnMpd09AR+hWfyO
	 ZqFWMLCBlhCvlY6dqVtTKYgzXnKEKwk/yMalEIG+TCSbtV+KWN0eU6EI3zLK5k/3y0
	 3bGjgrdkc+pYAiVz/N+5j3+7OwUxMFz3EsTRAhPyJBN2t8df0Y5kBisr8r8pb/eHvH
	 Lt4e4V0SfEuzpPl4IxDsNB4FZ7vbf/dLiN0REsa58Cqnbv5Qi4uOrWL9nTGmzPIQSD
	 NpyRjStJpcL1g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6988G50R0315557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 16:16:05 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:02 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:01 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:16:01 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v6 09/10] r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159
Date: Thu, 8 Oct 2026 16:15:55 +0800
Message-ID: <20261008081556.47901-10-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261008081556.47901-1-nic_swsd@realtek.com>
References: <20261008081556.47901-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The flow-control configuration keeps the device from sending pause
frames without limit. Only RTL8156B (VER_12/13/15) got the full
sequence from r8156b_init(). RTL8156A (VER_10/11) toggled
FC_PATCH_TASK in rtl8156_enable() without the FC timer and
FLOW_CTRL_PATCH_OPT setup that has to precede it, and RTL8157/RTL8159
(VER_16/17) got no flow-control configuration at all, so they could
keep sending pause frames indefinitely.

Collect the per-family sequence into rtl_fc_pause_pkt_en() and call
it for all of them.

- VER_10/11: the FC timer + FLOW_CTRL_PATCH_OPT sequence that
  RTL8153B (VER_09) already runs from its pre_fw/post_fw hooks,
  applied directly instead.

- VER_16/17: RTL8157/RTL8159 limit pause frames with the new
  PLA_PAUSE_LIMIT register instead of the FW patch. The datasheet
  gives a fixed pause-packet count per link speed, reproduced here
  by a log2-ratio computation. Because the count follows the
  negotiated speed, this family is called from rtl8157_enable()
  rather than from init.

  The speed decode covers every rate the driver advertises. The
  hardware can also report 500 and 1250 Mbit/s, which the kernel has
  no EEE link-mode encoding for and so never negotiates; if the PHY
  still reports such a rate, pause limiting is disarmed rather than
  programmed from a guessed speed.

In r8156b_init(), split AUTO_SPEEDUP clearing from flow-control FW
patch.

Fixes: 195aae321c82 ("r8152: support new chips")
Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 125 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 110 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 023e7af4c5fa6..b5092fdaa12c7 100644
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
 
@@ -6172,6 +6177,104 @@ static void r8152b_enter_oob(struct r8152 *tp)
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
+		if (speed & _10bps) {
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
+			/* No rate bit is set, e.g. a 500 or 1250 Mbit/s
+			 * sub-rate, which the driver does not advertise.
+			 * Disarm the limit.
+			 */
+			dev_err(&tp->intf->dev, "Unknown link speed\n");
+			ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_PAUSE_LIMIT,
+					  PAUSE_LIMIT_EN);
+			break;
+		}
+
+		log2_ratio = ilog2(ratio);
+		num_pause_pkts -= log2_ratio;
+
+		/* Round ratio up to the next power of two if it is
+		 * more than halfway there. Floating-point is avoided
+		 * by rewriting ratio > 1.5 * 2^log2_ratio as
+		 * 2 * ratio > 3 * 2^log2_ratio.
+		 */
+		if (2 * ratio > 3 * (1 << log2_ratio))
+			num_pause_pkts--;
+
+		/* At most 2^num_pause_pkts pause packets would be sent.
+		 *
+		 *  10 Mbit/s -> 2^0
+		 * 100 Mbit/s -> 2^3
+		 *   1 Gbit/s -> 2^7
+		 * 2.5 Gbit/s -> 2^8
+		 *   5 Gbit/s -> 2^9
+		 *  10 Gbit/s -> 2^10
+		 */
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
@@ -6703,6 +6806,8 @@ static int rtl8157_enable(struct r8152 *tp)
 	r8153_set_rx_early_size(tp);
 
 	speed = rtl8152_get_speed(tp);
+	rtl_fc_pause_pkt_en(tp, speed);
+
 	rtl_set_ifg(tp, speed);
 
 	return rtl_enable(tp);
@@ -8853,6 +8958,8 @@ static void r8156_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
+	rtl_fc_pause_pkt_en(tp, 0);
+
 	r8156_mac_clk_spd(tp, true);
 
 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
@@ -8889,7 +8996,6 @@ static void r8156b_u2phy_backup(struct r8152 *tp)
 
 static void r8156b_init(struct r8152 *tp)
 {
-	u32 ocp_data;
 	u16 data;
 
 	if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
@@ -8951,21 +9057,10 @@ static void r8156b_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
-	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
-
-	ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
+	rtl_fc_pause_pkt_en(tp, 0);
 
-	/* enable fc timer and set timer to 600 ms. */
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER,
-		       CTRL_TIMER_EN | (600 / 8));
-
-	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
-	if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
-		ocp_data |= FLOW_CTRL_PATCH_2;
-	ocp_data &= ~AUTO_SPEEDUP;
-	ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
-
-	ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
 
 	r8156_mac_clk_spd(tp, true);
 
-- 
2.34.1

