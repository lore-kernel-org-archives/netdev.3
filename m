Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B146D1DDC38;
	Wed, 14 Oct 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966000; cv=none; b=cjzKid++GNMoEMkEV4OeYTkHFDtvGrhVg2cEsc3fq4tDPCW5++YHdV3ILfJHCbex0HREmCLLk1EL+nox2XWdm/MmCX6sZ0WJuIprH2CCVnJoi7sY7+5FSuxkfQ8f+P2L3kGFeWkKYDB1k7+1yem+k58FNRXw2sFtA2VtaVbDw2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966000; c=relaxed/simple;
	bh=w+8UO17f7zxoFSaGyIjFegepd+gmgcFacc4IqLKZ0ww=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8fpt093+Rnx+Alq4ZIbAySe8EEdVkjTypwxMc6MTqlJ4sHb02P2D1IkwtrqOnTWS+DWzqHcMzZgj4oRSnL9RoqeMVIBk12Yzii1gboXtQXlYY4BuARbQuQ29I6Z0afZ1Oiqqfm+W2egs21Q8sd4JS99vgVjMZvYxxgPhA/0Crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=jH5vzRfD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="jH5vzRfD"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8J8aK41418223, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965949; bh=/kTltZnASTZm4eXE6l9UlZUSA9eS6IDJWCwTghRLcDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jH5vzRfDprRtQ3VluonaH+cHRfcg8FSGiK/5U5LN1/clboaxgraOtdipDHDmgQAQ/
	 okewGluB56aNdpM8XmIFXL/a/OxFJT+j9FnmMaH27bOOTKpC1pNgoP3jM+5jRz3F1L
	 yonawRWWrElIb5Dr8Ob/Mty/F6vjqLUoj3oQM4RzN/e92sD2b+377Ffn/MoE/OqF+n
	 CU6hpNq4luKnK+EZPIExUOX7I/Gh6MUb6WfbG/ynLQKf0q9hxznliO3MZe3BvYg+qH
	 bpYoViYm8pDY1KhdKWsIEmDO+TUBG6JKn7E9eLi1W6zekrGs88RHB93Az/3z2ZKloy
	 1pFzHMQwI/Gcw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8J8aK41418223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 16:19:09 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 16:19:07 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 16:19:07 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 02/10] r8152: add new init writes for RTL8156/8156B/8157/8159
Date: Wed, 14 Oct 2026 16:18:56 +0800
Message-ID: <20261014081904.6491-3-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261014081904.6491-1-nic_swsd@realtek.com>
References: <20261014081904.6491-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Bring the per-generation init functions in line with the vendor init
sequence by adding writes the shared r8156_init() never performed.

- Clear PREBOOT_OPTION and RMT_WAKE_EN in r8156_init() and
  r8157_init().

- Add r8156b_u2phy_backup() for RTL8156B (VER_12/13/15).

- Clear AUTO_SPEEDUP in r8157_init().

- Disable interrupt mitigation (0xcf04) in r8157_init().

- Clear the Warm RST / Bus RST event flag (0xcd06 BIT(11)) in
  r8157_init().

- Clear the FW u1u2 patch option (0xb9a6 BIT(0)) and enable the u3phy
  patch backup (0xb9a2) for RTL8159 (VER_17) only.

- Clear RX_END_TRANSFER_EN (0xd406 BIT(11)) for RTL8157 (VER_16), too.
  While it is set, incoming packets are buffered in the RX FIFO and
  Bulk-in transfers are suspended. The bit is zero by default and
  isn't used now. Clear it unconditionally for safety.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 77 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 64 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 518a2b42c2200..43a3f09b7c29b 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -78,6 +78,7 @@
 #define PLA_EEE_TXTWSYS_2P5G	0xe058
 #define PLA_EEEP_CR		0xe080
 #define PLA_MAC_PWR_CTRL	0xe0c0
+#define PLA_RMT_WAKE		0xe0c8
 #define PLA_MAC_PWR_CTRL2	0xe0ca
 #define PLA_MAC_PWR_CTRL3	0xe0cc
 #define PLA_MAC_PWR_CTRL4	0xe0ce
@@ -371,6 +372,9 @@
 #define MCU_CLK_RATIO_MASK	0x0f0f0f0f
 #define ALDPS_SPDWN_RATIO	0x0f87
 
+/* PLA_RMT_WAKE */
+#define RMT_WAKE_EN		BIT(0)
+
 /* PLA_MAC_PWR_CTRL2 */
 #define EEE_SPDWN_RATIO		0x8007
 #define MAC_CLK_SPDWN_EN	BIT(15)
@@ -417,6 +421,7 @@
 
 /* PLA_INDICATE_FALG */
 #define UPCOMING_RUNTIME_D3	BIT(0)
+#define PREBOOT_OPTION		BIT(1)
 
 /* PLA_MACDBG_PRE and PLA_MACDBG_POST */
 #define DEBUG_OE		BIT(0)
@@ -542,6 +547,7 @@
 #define RX_AGG_DISABLE		0x0010
 #define RX_ZERO_EN		0x0080
 #define RX_DESC_16B		0x0400
+#define RX_END_TRANSFER_EN	BIT(11)
 
 /* USB_U2P3_CTRL */
 #define U2P3_ENABLE		0x0001
@@ -8305,6 +8311,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 	set_bit(PHY_RESET, &tp->flags);
 }
 
+static void r8156b_u2phy_backup(struct r8152 *tp)
+{
+	ocp_write_word(tp, MCU_TYPE_USB, 0xd3ce, 0x181b);
+	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d0, 0x616ccd99);
+	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d4, 0x08fc8101);
+	ocp_write_dword(tp, MCU_TYPE_USB, 0xd3d8, 0x159b1100);
+	ocp_write_word(tp, MCU_TYPE_USB, 0xd3dc, 0x0a00);
+}
+
 static void r8156_init(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -8370,11 +8385,25 @@ static void r8156_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
+	switch (tp->version) {
+	case RTL_VER_12:
+	case RTL_VER_13:
+	case RTL_VER_15:
+		r8156b_u2phy_backup(tp);
+		break;
+	default:
+		break;
+	}
+
 	r8153b_power_cut_en(tp, false);
 	r8156_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 
@@ -8494,6 +8523,10 @@ static void r8157_init(struct r8152 *tp)
 
 	r8157_u2p3en(tp, false);
 
+	/* Disable Interrupt Mitigation */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
 
@@ -8505,11 +8538,30 @@ static void r8157_init(struct r8152 *tp)
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
+	/* Clear Warm RST / Bus RST event flag */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(11));
+
+	switch (tp->version) {
+	case RTL_VER_17:
+		/* Disable FW u1u2 patch option */
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xb9a6, BIT(0));
+		break;
+	default:
+		break;
+	}
+
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 
 	usb_enable_lpm(tp->udev);
 
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
+
 	r8156_mac_clk_spd(tp, true);
 
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
@@ -8521,19 +8573,9 @@ static void r8157_init(struct r8152 *tp)
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
-	/* RX aggregation / 16 bytes RX descriptor
-	 * BIT(11) is specific to RTL8159, with unknown meaning
-	 */
-	switch (tp->version) {
-	case RTL_VER_17:
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
-				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
-		break;
-	default:
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
-				  RX_AGG_DISABLE | RX_DESC_16B);
-		break;
-	}
+	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
+			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);
 
 	/* Disable Rx Zero Len */
 	rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
@@ -8541,6 +8583,15 @@ static void r8157_init(struct r8152 *tp)
 	/* TX descriptor Signature */
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
 
+	switch (tp->version) {
+	case RTL_VER_17:
+		/* Enable u3phy patch backup */
+		ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
+		break;
+	default:
+		break;
+	}
+
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
 
-- 
2.34.1

