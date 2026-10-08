Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D245FFAA;
	Thu,  8 Oct 2026 08:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447432; cv=none; b=u/gTSuXDV+GFSo+GhRWIpLP8pSNJW1LZHCCE7yIToAoyI9yOJmzRKiNxWjyGUutK/bVnm79Hret4PoGn2XqFRHOg/BN1gbRfEpHMtPdPOVGQWVaUkQtpQbsd7JvH6l5XRPRs9ApQ6b/7UXTih5ZYdZDIJ80rKncdtYgHvc/QM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447432; c=relaxed/simple;
	bh=wcn64F5vbGwNnI+Y+23vn5Hdip9bVRwn9wO1oQDVuRY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ciA838PEjo67x3aUlBMlXIa8YTuZeOgp4munrTBTZAkd8Rki4zl8pwiAZ5k8hFU9ivgdU1qoIdtS0snyni0Y7UOQLVpbIVLrRmFWBDtaQ5q0zUwMvEEwkZDTJ4FAHaByjnyZ/dxEW2eZjE1Jha23l0anZRHlqbR/1EgrV952P14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZEpK0+mm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZEpK0+mm"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6988Gh5jA315416, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791447404; bh=2MNfy6l59zbn174LGhtbCeTppyqntsj5xGfAuOaw+jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZEpK0+mmAYrUBenKiYwJ37S/WcFU9Uva2QLqnIfG+Bg9eCt7M7gNOZ0h0d3aUfQDn
	 JXk88CzjZv/fLr7Ii/7MiIIj0u7gMGopYF2gSjkM+ienR7ieNrmKQ7K1HOfptPuZt6
	 4+hxq8Guk1JsZ84sLyXKmFlsA1FktumSPh8CiJD1ReVidtkmWChrcdmuIMihHo5bK3
	 beG5YGtDx6shLl8n1X/1prYvZnUb0xkZEEtopHjmCnlq3iyKTzRqwbaud3UnEr0M9D
	 ESAdUbm6feXQ0pSDDiC4NdAy4QbTgsN+Un1mOHwypyOBlkIwQQgEDLcev0fX3GEIll
	 nKHBsl9H5pLyw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6988Gh5jA315416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Oct 2026 16:16:44 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
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
Subject: [PATCH net-next v6 03/10] r8152: split RTL_VER_17 into QFN68 and QFN100 package variants
Date: Thu, 8 Oct 2026 16:15:49 +0800
Message-ID: <20261008081556.47901-4-nic_swsd@realtek.com>
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

RTL8159 is sold in QFN68 and QFN100 packages, and only QFN68 needs
the u2phy backup-restore patch and enables UPS (in a later patch).
There was previously no way to tell the two apart at runtime, since
both used the same RTL_VER_17.

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
 drivers/net/usb/r8152.c | 89 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 14 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index f62bfa659a985..eae76be4fad50 100644
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
@@ -6404,7 +6419,7 @@ static int rtl8156_enable(struct r8152 *tp)
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17)
+	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17_QFN100)
 		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
 
 	r8153_set_rx_early_timeout(tp);
@@ -8093,7 +8108,8 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
 		break;
 
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		/* Disable bypass turn off clk in ALDPS */
 		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
 
@@ -8694,6 +8710,10 @@ static void r8159_init(struct r8152 *tp)
 	/* TX descriptor Signature */
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
 
+	/* Enable u2phy backup restore patch */
+	if (tp->version == RTL_VER_17_QFN68)
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xb99c, BIT(0));
+
 	/* Enable u3phy patch backup */
 	ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
 
@@ -10078,7 +10098,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		r8157_desc_init(tp);
 		break;
 
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
@@ -10170,7 +10191,8 @@ static int rtl_fw_init(struct r8152 *tp)
 	case RTL_VER_16:
 		rtl_fw->fw_name		= FIRMWARE_8157_1;
 		break;
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		rtl_fw->fw_name		= FIRMWARE_8159_1;
 		break;
 	default:
@@ -10180,9 +10202,38 @@ static int rtl_fw_init(struct r8152 *tp)
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
+		if (i != 1)
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
@@ -10265,7 +10316,16 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
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
@@ -10424,7 +10484,8 @@ static int rtl8152_probe_once(struct usb_interface *intf,
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

