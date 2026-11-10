Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281107;
	b=qdg45dCPL7f4eaHbhGud9vlEx9CzHZ46jq7vr3mhGx5q4MBcCP0fgV0KJJsI4w43fUG9
	 /q8MQPRMM8Wahfp0qTtF9t/h+3GEgklJiZeKYwbqHgG6MReCD0eAfrxQjnuGBdNmHza4e
	 vhPaCuaiunESNo+tr139VqUKL/F4h7tRTBhI6omDoISCZrdwr10hADS+CeQvIMVUYOh/s
	 pODn9giYbojE1H9Lmyg88O2zdIvZlt7VlaNAb64wANpI1KbeZ8GhDhfGR7D95AYQ2ymMz
	 Kb+4KxLC4y5hU5QiAQ0wFfoBPs6fNS2WU/MRdbOkfmSQ/7iJ8YWmtJXHzAYcVJHzk0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281107;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=3MxUjTGRNL8odrYuaFu41PA9ugDlMbGaJle6D/D4/B0=;
	b=MHl8iJRWnR/eBHh0fWxsFsyj1jOx3jYBT6+DeyCbk80r9xvuA4LZUI4wN4y5vyeKxjYa
	 ySdYGjZ22XPqpOahKNAahpGgR0obInq96jMi8fpZx+K7ZJhcMcFRmCc3Sj4fnwKo/mpJz
	 zaWikOa5orqubiVAfjrw5BKtF+TfvdEhRXV5RK7b35kAhTIdDkYZ8xasZhv845kYQfMrg
	 4zctXYvRb7ZCYCxxHgQCnh+PtgmCWIUUFuWLqFvt4gj35vDJwAQfp6n1DewRSKj7DArPA
	 XoGu+F+0aCupu1XMAUE05JLSfelEbZ9DcuBUtSgfGg+bJmBo1FNseA2n8BRepHXnFfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b="eUR/hZWJ";
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91E0606A33B;
	Tue, 10 Nov 2026 03:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C91E0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=eUR/hZWJ
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3OLZQ0884583, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281061; bh=3MxUjTGRNL8odrYuaFu41PA9ugDlMbGaJle6D/D4/B0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=eUR/hZWJCFoCJdsy2QyrVjjl38h8tuYxWkGYsbySy9ZorG0svEOzdvGEnNPrw4tiA
	 LIrXXUc56yY+B5sa5i+eGdooSbLNrIkjpXGqJlRhMtSSy9aXt1T/f7mZflTVvHG03l
	 PCXGH6r8e2de9ml6NRJY/okksAojGZr7BYlGs1IwYGajr0myAfK1M21765YUnF0mBC
	 0XLzi2/hNpvuzkv8GejYZtOmlwma3KBLazHd+ENBJXih2bKViDwLpAzD982z/m+kVT
	 elsy6jJvCoz9SyMRIBc1++N6xxlm3O10p4qIuCkaWdJ2amVLOghBMUpfTFoEU97aA9
	 /+vJZszFm78mw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3OLZQ0884583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
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
Subject: [PATCH net-next v8 06/11] r8152: add new init writes for RTL8156/8156B/8157/8159
Date: Tue, 10 Nov 2026 11:24:11 +0800
Message-ID: <20261110032416.16968-7-nic_swsd@realtek.com>
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

Bring the per-generation init functions in line with the vendor init
sequence by adding writes the shared r8156_init() never performed.

- Clear PREBOOT_OPTION and RMT_WAKE_EN in r8156_init() and
  r8157_init().

- Add r8156b_u2phy_backup() for RTL8156B (VER_13/15).

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
 drivers/net/usb/r8152.c | 76 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 13 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 364a0573f6cd1..a1c2e1e08b161 100644
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
@@ -376,6 +377,9 @@
 #define MCU_CLK_RATIO_MASK	0x0f0f0f0f
 #define ALDPS_SPDWN_RATIO	0x0f87
 
+/* PLA_RMT_WAKE */
+#define RMT_WAKE_EN		BIT(0)
+
 /* PLA_MAC_PWR_CTRL2 */
 #define EEE_SPDWN_RATIO		0x8007
 #define MAC_CLK_SPDWN_EN	BIT(15)
@@ -422,6 +426,7 @@
 
 /* PLA_INDICATE_FALG */
 #define UPCOMING_RUNTIME_D3	BIT(0)
+#define PREBOOT_OPTION		BIT(1)
 
 /* PLA_MACDBG_PRE and PLA_MACDBG_POST */
 #define DEBUG_OE		BIT(0)
@@ -547,6 +552,7 @@
 #define RX_AGG_DISABLE		0x0010
 #define RX_ZERO_EN		0x0080
 #define RX_DESC_16B		0x0400
+#define RX_END_TRANSFER_EN	BIT(11)
 
 /* USB_U2P3_CTRL */
 #define U2P3_ENABLE		0x0001
@@ -8464,6 +8470,15 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
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
 	u16 data;
@@ -8528,11 +8543,24 @@ static void r8156_init(struct r8152 *tp)
 	/* U1/U2/L1 idle timer. 500 us */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
+	switch (tp->version) {
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
 
@@ -8642,6 +8670,10 @@ static void r8157_init(struct r8152 *tp)
 
 	r8157_u2p3en(tp, false);
 
+	/* Disable Interrupt Mitigation */
+	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
+			  BIT(0) | BIT(1) | BIT(2) | BIT(7));
+
 	/* MSC timer = 0xfff * 8ms = 32760 ms */
 	ocp_write_word(tp, MCU_TYPE_USB, USB_MSC_TIMER, 0x0fff);
 
@@ -8653,11 +8685,30 @@ static void r8157_init(struct r8152 *tp)
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
@@ -8669,19 +8720,9 @@ static void r8157_init(struct r8152 *tp)
 
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
@@ -8689,6 +8730,15 @@ static void r8157_init(struct r8152 *tp)
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

