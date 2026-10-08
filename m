Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9C245FFA8;
	Thu,  8 Oct 2026 08:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447431; cv=none; b=f/JmbxvoMhDQd0dJfuC6PsgRr8zOsfa1UCocsQbTrsyY8iL1k6mrwn9/J03kaidvOWyVbZ13/jAYfj+wlgpPtWmtFfyqsTOoPFwOi4RqaS7I81d1H8tcv18JKdmheg0F8CKtapLZDYgc0yy0Pty9XvMo/eVE9t2KYg2M2kUSi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447431; c=relaxed/simple;
	bh=5f3lWOP3beZG9dMltOwNOV21AayviomL6Q/MiVS7NWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C4C0tWMdr8EeWaj0iyaWSPare5KhJ7hIJhXgnd4419PNb2i6OPhDaa0KSZNGukVHNlUoQM0sm8xBvbX3zBixHP/29EcSx303Bvz5r4bqzL8d1+wJUbK6dhv0o2yXJZWNcUXUwBEq/kQn+fDu73fd4uG2oEOQY2dBBEIa77HuYQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uqFM1QBU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uqFM1QBU"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6988Gh5hA315416, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791447403; bh=5arkXX1zJdRE4RpSsoltqLkrVqzSGmvClBJfRUNXusw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uqFM1QBUyY+jYO6whdws5A9Qomm1qDwptGtUUhGTF3xw2EK3tpbEp5yqDu+PrK6qa
	 I4qmN78skR5tROL3UEJ84+IdH7Qfh35V/d11Xpjt6tg3uNeesXt8IFtB3N0gnJI71V
	 k891Oa0GGPZDWATT5lrfhRtiIaXZsC09oWa3P7bSQFrjL2saBRYL4Gqq+achp+tweQ
	 jIcOS7vhmTVGBzTvF69U2BY9kTWsBFhTJ1V4+Am4FVw533qz2pm+IGQU/MF3Sut6Vp
	 wvmTUxdbsz7hvFUw7A1t/iMrtZSyoHlEgmkVZiO/tpiW0QtINI4GYM0wTSszooaWS0
	 k+Aqo1G8y3FsQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6988Gh5hA315416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 16:16:43 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:16:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 16:15:59 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 16:15:59 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v6 02/10] r8152: add new init writes for RTL8156B/8157/8159
Date: Thu, 8 Oct 2026 16:15:48 +0800
Message-ID: <20261008081556.47901-3-nic_swsd@realtek.com>
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

Bring the per-chip init functions in line with the vendor init
sequence by adding writes the shared r8156_init() never performed.

- Clear PREBOOT_OPTION and RMT_WAKE_EN in all four init functions.

- Add r8156b_u2phy_backup() for RTL8156B.

- Clear AUTO_SPEEDUP in r8157_init() and r8159_init().

- Disable interrupt mitigation (0xcf04) in r8157_init() and
  r8159_init().

- Clear the Warm RST / Bus RST event flag (0xcd06 BIT(11)) in
  r8157_init() and r8159_init().

- Clear the FW u1u2 patch option (0xb9a6 BIT(0)) and enable the u3phy
  patch backup (0xb9a2) in r8159_init() only.

- Clear RX_END_TRANSFER_EN (0xd406 BIT(11)) in r8157_init().
  While it is set, incoming packets are buffered in the RX FIFO and
  Bulk-in transfers are suspended. The bit is zero by default and
  isn't used now. Clear it unconditionally for safety.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 69 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 30543c5799232..f62bfa659a985 100644
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
@@ -8344,6 +8350,10 @@ static void r8156_init(struct r8152 *tp)
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 
@@ -8374,6 +8384,15 @@ static void r8156_init(struct r8152 *tp)
 	tp->coalesce = 15000; /* 15 us */
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
 static void r8156b_init(struct r8152 *tp)
 {
 	u32 ocp_data;
@@ -8422,11 +8441,17 @@ static void r8156b_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
+	r8156b_u2phy_backup(tp);
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
 
@@ -8505,6 +8530,10 @@ static void r8157_init(struct r8152 *tp)
 
 	r8157_u2p3en(tp, false);
 
+	/* Disable Interrupt Mitigation */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
 
@@ -8516,11 +8545,21 @@ static void r8157_init(struct r8152 *tp)
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
+	/* Clear Warm RST / Bus RST event flag */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(11));
+
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 
 	usb_enable_lpm(tp->udev);
 
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
+
 	r8156_mac_clk_spd(tp, true);
 
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
@@ -8532,9 +8571,9 @@ static void r8157_init(struct r8152 *tp)
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
-	/* RX aggregation / 16 bytes RX descriptor */
+	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
 	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
-			  RX_AGG_DISABLE | RX_DESC_16B);
+			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);
 
 	/* Disable Rx Zero Len */
 	rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
@@ -8601,6 +8640,10 @@ static void r8159_init(struct r8152 *tp)
 
 	r8157_u2p3en(tp, false);
 
+	/* Disable Interrupt Mitigation */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
 
@@ -8612,11 +8655,24 @@ static void r8159_init(struct r8152 *tp)
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_INDICATE_FALG, PREBOOT_OPTION);
+
+	ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_RMT_WAKE, RMT_WAKE_EN);
+
+	/* Clear Warm RST / Bus RST event flag */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(11));
+
+	/* Disable FW u1u2 patch option */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xb9a6, BIT(0));
+
 	if (tp->udev->speed >= USB_SPEED_SUPER)
 		r8153b_u1u2en(tp, true);
 
 	usb_enable_lpm(tp->udev);
 
+	/* Disable Auto Speed up */
+	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_FW_CTRL, AUTO_SPEEDUP);
+
 	r8156_mac_clk_spd(tp, true);
 
 	if (rtl8152_get_speed(tp) & LINK_STATUS)
@@ -8628,11 +8684,9 @@ static void r8159_init(struct r8152 *tp)
 
 	set_bit(GREEN_ETHERNET, &tp->flags);
 
-	/* RX aggregation / 16 bytes RX descriptor
-	 * BIT(11) is specific to RTL8159, with unknown meaning
-	 */
+	/* RX aggregation / 16 bytes RX descriptor / Bulk In End transfer */
 	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
-			  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
+			  RX_AGG_DISABLE | RX_DESC_16B | RX_END_TRANSFER_EN);
 
 	/* Disable Rx Zero Len */
 	rtl_bmu_clr_bits(tp, 0x2300, BIT(3));
@@ -8640,6 +8694,9 @@ static void r8159_init(struct r8152 *tp)
 	/* TX descriptor Signature */
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
 
+	/* Enable u3phy patch backup */
+	ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
+
 	r8156_mdio_force_mode(tp);
 	rtl_tally_reset(tp);
 
-- 
2.34.1

