Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281108;
	b=t87RFk7vBX7/vQpHbkMcR0n3J4wpetuc1TUz7Qy2bSs9stPjrXgql3hC+E3pjHKYBfSp
	 GGw/hhKTPZEha0Lr6KHW+V46mEIa9Bs9DHygWyVPBdAY8qujVXYlvdNhDKSv7ETghs0kp
	 9oAVSHOdTWzq/byFbtR7yOG+ge27tbBXtJHkEfvqUV/7xJzEgCD/yV30QAE/tx4nLL+tZ
	 8L1sIkXS/ftKjbcgt+qfVsUr3ooPXO2qphVYYQ8QvM+851vfNA8I2ZHNET7Hyl26i0oxR
	 35gRxwfaPwQny/r0MOzTqbyJ+7J4R2wfRY6slP5kwUn1eA0ZawpGb9hFtS8BJAsiQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281108;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=XJ+QrFQYas4sSerx/B2Hc+bn1S69asfQ5t5UDHPgNl4=;
	b=gRie72I1tIQnmoTSJpPWsWcvGhNNV0CrAzPDKvKJLFXHNplP/Q67HrSgJ8e0FHCKyaB0
	 reug+1J5BW+hH76V9rKdfY9meAqfzmBayQTt2xXTqqCBH+sIJMmrfj/nVdy+M1NvsqTPl
	 NHd9fzKaFXXOQKZVGRiFteAxgsSQUbx7z5bofj0HBo/uuWlpgFcFE/9VdSQKIFVC6fehN
	 WipLjlBhL32ZLU/BBeSwicUBL4zwdMJifvbdOcRDciprLmmJQ+27g+6NDLuwmOVsMSNtl
	 o+2cxQwQztA2M7d18V1taNIgyMcLYCfWRgIA2DA6uKRjvm6/D7r3Qm+5mNXToxrnfHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=WnjmgG8P;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BB606A33A;
	Tue, 10 Nov 2026 03:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91BB606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=WnjmgG8P
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3ONO40884407, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281063; bh=XJ+QrFQYas4sSerx/B2Hc+bn1S69asfQ5t5UDHPgNl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=WnjmgG8PHoqZ5AYP97Mqw7eiHzTn2xuzYP8piWsBzCQVjbU6JWezq19QiUUJh61tj
	 O0zJ5yBhSzU1X6/VPuShls1kXC7phQzL6JUmJH9p3WIRGVveyg6FOrTVe+T/C6rgMd
	 2rNHwfeAnJOhaHFLk6UiEBBJwOw95JI3oy+e24BDPS6/1txKDyGYkwGPE/DhhIieRi
	 A6WQR0zyM2IBHIGUngcHomffui3PRpgP5/ZpBMw6mN/tc16JDJa3wTCr/HrIGzahM8
	 3rxpVvwLqfihcdIbIQIvTG63iRUaPWjBzGHoOsXCIf76p0Mx5zK43JAQbjMVLcmXC8
	 udFsA+mtsoSwg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3ONO40884407
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:23 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:19 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:24:19 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 04/11] r8152: fix flow control for RTL8156/RTL8156B/RTL8157/RTL8159
Date: Tue, 10 Nov 2026 11:24:09 +0800
Message-ID: <20261110032416.16968-5-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261110032416.16968-1-nic_swsd@realtek.com>
References: <20261110032416.16968-1-nic_swsd@realtek.com>
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

The flow-control setup that limits pause frames was incomplete or
missing on several chips:

- RTL8156A (VER_10/11): r8156_init() skipped them, so the FC timer and
  FLOW_CTRL_PATCH_OPT setup that the FC_PATCH_TASK toggle in
  rtl8156_enable() depends on was never done.
- RTL8157/RTL8159 (VER_16/17): no limit on the number of pause packets
  was programmed, so they could keep sending pause frames
  indefinitely.

Collect the per-family sequence into rtl_fc_pause_pkt_en() and call it
for all of them.

- VER_10/11: the FC timer + FLOW_CTRL_PATCH_OPT sequence that
  RTL8153B (VER_09) already runs from its pre_fw/post_fw hooks,
  applied directly instead.

- VER_12/13/15: the sequence r8156_init() already ran, moved here
  unchanged.

- VER_16/17: limit pause packets with the new PLA_PAUSE_LIMIT register
  instead of the FW patch. The datasheet gives a fixed count per link
  speed, reproduced here by a log2-ratio computation. Because the
  count follows the negotiated speed, this family is called from
  rtl8156_enable() rather than from init.

  The speed decode covers every rate the driver advertises. The
  hardware can also report 500 and 1250 Mbit/s, which the driver does
  not advertise; if the PHY still reports such a rate, pause limiting
  is disarmed rather than programmed from a guessed speed.

In r8156_init(), split AUTO_SPEEDUP clearing from the flow-control FW
patch; it still applies to RTL8156B only.

Fixes: 195aae321c82 ("r8152: support new chips")
Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")
Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 126 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 1517753f843ef..6f55aed4709e1 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -87,6 +87,7 @@
 #define PLA_MTPS		0xe615
 #define PLA_TXFIFO_CTRL		0xe618
 #define PLA_TXFIFO_FULL		0xe61a
+#define PLA_PAUSE_LIMIT		0xe61e
 #define PLA_RSTTALLY		0xe800
 #define PLA_CR			0xe813
 #define PLA_CRWECR		0xe81c
@@ -293,6 +294,10 @@
 #define MTPS_JUMBO		(12 * 1024 / 64)
 #define MTPS_DEFAULT		(6 * 1024 / 64)
 
+/* PLA_PAUSE_LIMIT */
+#define PAUSE_LIMIT_EN		BIT(3)
+#define PAUSE_LIMIT_MASK	0xf0
+
 /* PLA_RSTTALLY */
 #define TALLY_RESET		0x0001
 
@@ -5961,6 +5966,103 @@ static void r8152b_enter_oob(struct r8152 *tp)
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
+	case RTL_VER_17:
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
@@ -6404,6 +6506,10 @@ static int rtl8156_enable(struct r8152 *tp)
 	r8153_set_rx_early_size(tp);
 
 	speed = rtl8152_get_speed(tp);
+
+	if (tp->version >= RTL_VER_16)
+		rtl_fc_pause_pkt_en(tp, speed);
+
 	rtl_set_ifg(tp, speed);
 
 	if (tp->version >= RTL_VER_16)
@@ -8490,22 +8596,12 @@ static void r8156_init(struct r8152 *tp)
 
 	usb_enable_lpm(tp->udev);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15) {
-		ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_RCR, SLOT_EN);
-
-		ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_CPCR, FLOW_CTRL_EN);
-
-		/* enable fc timer and set timer to 600 ms. */
-		ocp_write_word(tp, MCU_TYPE_USB, USB_FC_TIMER, CTRL_TIMER_EN | (600 / 8));
-
-		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_CTRL);
-		if (!(ocp_read_word(tp, MCU_TYPE_PLA, PLA_POL_GPIO_CTRL) & DACK_DET_EN))
-			ocp_data |= FLOW_CTRL_PATCH_2;
-		ocp_data &= ~AUTO_SPEEDUP;
-		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_CTRL, ocp_data);
+	if (tp->version < RTL_VER_16)
+		rtl_fc_pause_pkt_en(tp, 0);
 
-		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_FW_TASK, FC_PATCH_TASK);
-	}
+	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_15)
+		/* Disable Auto Speed up */
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
 
 	r8156_mac_clk_spd(tp, true);
 
-- 
2.34.1

