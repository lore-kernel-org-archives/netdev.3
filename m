Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525FA3B38BE;
	Thu,  1 Oct 2026 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845947; cv=none; b=mYL9ZKVm5wXNnRLrA1mNtP/aUmJVYJ6H1Gih0AL0EXSg3lvI3MVTGSLELp/h4t85kZjERXx1SaXtPoJsSvrbMlEvhJrgwkjL8I2559avvEGsbKZlMhNqAkGzugBKI2ditYRmrpP3Q6tg9s/cj+o8oY6W5EDYCTBvroFPfIVB6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845947; c=relaxed/simple;
	bh=f25Cm2sNT2NOfgfuRLfG68qHMA9tNyQ1FlTw97Xy998=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhaL9I46I1tREnh05gCaQ5eE0ScMvr3H/zxbeNM2U0myY82QZKELpg0ndZuGmyIAmKf/FX9klTZ7zhIFrO9J9whSgMN98GDpyR0V8krlAWlxAGTWP1FFELV+3OQyhislw8Wj9hSkyPjup6RybRbfKGVV7cDzFr8z/GZgv9VHqI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A3XF/AFn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A3XF/AFn"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6919BlFO22836516, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790845908; bh=vBcNfzDyU87kJXoFTKn9P/5C66ZF7/Kqk7m3IrmVJC0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=A3XF/AFnxj/YEyBIwgU0KR5elyIhvYobwN/rykqslUEQP1yuHSBvbmJj2fqu55KYd
	 X2+uQwc4g7v8evR5RWScTJgzBrkQ+MaWAu+hSahN6Bv85+i4C3941WdDHuPrALeGXI
	 6Wnb2jHNdEdnBxzGMy35D/jMe/ollBZdqK1wbFjsain0QvZD3QyfT6DvBcTkcYPGKl
	 MP2gjUsVY2M80ZP7kvZAipcErO45AAq4r0Mf/QZLGMXtXRaYkTYytTW67n2L+pCXST
	 SdAhLFHQDUDSlhJCgMcrM/GNlwtxiqBofJsG4x/eRQizpJdhmNdifiO0KYvOCJ4TeK
	 SmpVXCPCmXo7w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6919BlFO22836516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Oct 2026 17:11:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:46 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 17:11:46 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v5 2/9] r8152: split RTL_VER_17 into QFN68 and QFN100 package variants
Date: Thu, 1 Oct 2026 17:11:37 +0800
Message-ID: <20261001091144.28191-3-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001091144.28191-1-nic_swsd@realtek.com>
References: <20261001091144.28191-1-nic_swsd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8159 is sold in two packages, QFN68 and QFN100, which need
different firmware and a package-specific u2phy backup-restore
patch. There was previously no way to tell the two apart at runtime,
since both used the same RTL_VER_17.

Split RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100 and
update every switch/case on RTL_VER_17 in the driver to handle both.
Detect the package by reading the new PLA_PKG_DET register
(0xdc48, masked with PKG_MASK = 0x1e) via a new __rtl_get_pkg_det()
helper, called from __rtl_get_hw_ver() when the chip ID is 0x2020:
pkg_det value 0x1e/0x1c selects QFN68, 0x18/0x1a selects QFN100, and
any other value logs "Unknown package" and falls back to
RTL_VER_UNKNOWN.

r8159_init() gains a QFN68-only write ("Enable u2phy backup restore
patch", 0xb99c BIT(0)) that does not apply to QFN100.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 92 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 77 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 4d8f0815d79d1..30af6ed3a638f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -64,6 +64,7 @@
 #define PLA_MACDBG_POST		0xd38e	/* RTL_VER_04 only */
 #define PLA_EXTRA_STATUS	0xd398
 #define PLA_GPHY_CTRL		0xd3ae
+#define PLA_PKG_DET		0xdc48
 #define PLA_POL_GPIO_CTRL	0xdc6a
 #define PLA_EFUSE_DATA		0xdd00
 #define PLA_EFUSE_CMD		0xdd02
@@ -290,6 +291,9 @@
 #define IFG_144NS		BIT(9)
 #define IFG_96NS		(BIT(9) | BIT(8))
 
+/* PLA_PKG_DET */
+#define PKG_MASK		0x1e
+
 /* PLA_MTPS */
 #define MTPS_JUMBO		(12 * 1024 / 64)
 #define MTPS_DEFAULT		(6 * 1024 / 64)
@@ -1253,7 +1257,8 @@ enum rtl_version {
 	RTL_VER_14,
 	RTL_VER_15,
 	RTL_VER_16,
-	RTL_VER_17,
+	RTL_VER_17_QFN68,
+	RTL_VER_17_QFN100,
 
 	RTL_VER_MAX
 };
@@ -3418,7 +3423,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		break;
 
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE | CR_TE);
 		break;
 
@@ -3458,7 +3464,7 @@ static void rtl_eee_plus_en(struct r8152 *tp, bool enable)
 
 static void rtl_set_eee_plus(struct r8152 *tp)
 {
-	if (tp->version == RTL_VER_17)
+	if (tp->version == RTL_VER_17_QFN68 || tp->version == RTL_VER_17_QFN100)
 		return rtl_eee_plus_en(tp, false);
 
 	if (rtl8152_get_speed(tp) & _10bps)
@@ -3646,7 +3652,8 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_TIMEOUT,
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
@@ -3691,7 +3698,8 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 			       ocp_data / 8);
 		break;
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 16);
 		break;
@@ -3807,6 +3815,8 @@ static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		if (enable)
 			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_RCR1,
@@ -4487,6 +4497,8 @@ static void r8153_teredo_off(struct r8152 *tp)
 	case RTL_VER_14:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		/* The bit 0 ~ 7 are relative with teredo settings. They are
 		 * W1C (write 1 to clear), so set all 1 to disable it.
@@ -4541,7 +4553,8 @@ static void rtl_clear_bp(struct r8152 *tp, u16 type)
 		break;
 	case RTL_VER_14:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		ocp_write_word(tp, type, USB_BP2_EN, 0);
 		bp_num = 16;
@@ -4653,7 +4666,8 @@ static bool rtl8152_is_fw_phy_speed_up_ok(struct r8152 *tp, struct fw_phy_speed_
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		break;
 	}
@@ -5813,7 +5827,8 @@ static void rtl_eee_enable(struct r8152 *tp, bool enable)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		if (enable) {
 			r8156_eee_en(tp, true);
 			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
@@ -6404,8 +6419,9 @@ static int rtl8156_enable(struct r8152 *tp)
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
+	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17_QFN100)
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM,
+				  RX_AGGR_NUM_MASK);
 
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
@@ -8093,7 +8109,8 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
 		break;
 
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		/* Disable bypass turn off clk in ALDPS */
 		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
 
@@ -8696,6 +8713,10 @@ static void r8159_init(struct r8152 *tp)
 	/* TX descriptor Signature */
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
 
+	/* Enable u2phy backup restore patch */
+	if (tp->version == RTL_VER_17_QFN68)
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xb99c, BIT(0));
+
 	/* Enable u3phy patch backup */
 	ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
 
@@ -10080,7 +10101,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		r8157_desc_init(tp);
 		break;
 
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
@@ -10172,7 +10194,8 @@ static int rtl_fw_init(struct r8152 *tp)
 	case RTL_VER_16:
 		rtl_fw->fw_name		= FIRMWARE_8157_1;
 		break;
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		rtl_fw->fw_name		= FIRMWARE_8159_1;
 		break;
 	default:
@@ -10182,9 +10205,38 @@ static int rtl_fw_init(struct r8152 *tp)
 	return 0;
 }
 
+static u32 __rtl_get_pkg_det(struct usb_device *udev)
+{
+	u32 pkg_det = 0;
+	__le32 *tmp;
+	int ret, i;
+
+	tmp = kmalloc_obj(*tmp);
+	if (!tmp)
+		return 0;
+
+	for (i = 0, ret = 0; i < 3 && ret != 4; i++)
+		ret = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
+				      RTL8152_REQ_GET_REGS, RTL8152_REQT_READ,
+				      PLA_PKG_DET, MCU_TYPE_PLA, tmp,
+				      sizeof(*tmp), USB_CTRL_GET_TIMEOUT);
+
+	if (ret == sizeof(*tmp)) {
+		if (i != 0)
+			dev_warn(&udev->dev,
+				 "Needed %d retries to read package\n", i);
+
+		pkg_det = __le32_to_cpu(*tmp) & PKG_MASK;
+	}
+
+	kfree(tmp);
+	return pkg_det;
+}
+
 static u8 __rtl_get_hw_ver(struct usb_device *udev)
 {
 	u32 ocp_data = 0;
+	u32 pkg_det = 0;
 	__le32 *tmp;
 	u8 version;
 	int ret;
@@ -10267,7 +10319,16 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
 		version = RTL_VER_16;
 		break;
 	case 0x2020:
-		version = RTL_VER_17;
+		pkg_det = __rtl_get_pkg_det(udev);
+		if (pkg_det == 0x1e || pkg_det == 0x1c) {
+			version = RTL_VER_17_QFN68;
+		} else if (pkg_det == 0x18 || pkg_det == 0x1a) {
+			version = RTL_VER_17_QFN100;
+		} else {
+			version = RTL_VER_UNKNOWN;
+			dev_info(&udev->dev, "Unknown package 0x%04x\n",
+				 pkg_det);
+		}
 		break;
 	default:
 		version = RTL_VER_UNKNOWN;
@@ -10426,7 +10487,8 @@ static int rtl8152_probe_once(struct usb_interface *intf,
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		netdev->max_mtu = size_to_mtu(16 * 1024);
 		break;
 	case RTL_VER_01:
-- 
2.34.1

