Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1F40912B;
	Wed,  2 Sep 2026 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340038; cv=none; b=jawx8Iud1F5hEdPJq8gTl0qGad5PfI3e/YEUU+mVNCrLCf8gndZgdMqNr7AZAzuQp0//8LHJgGyIFhDb0/Vw9mPgNg5F3zF4YQkIZK/8nRBWlx+kmCRktiXD46XYqwtheJRfppnUGIVsGU2cwOeTfjd+AKZPIoulHVbKQuNhKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340038; c=relaxed/simple;
	bh=E8307jUOlbjUHcDbmjG9L5Sn2qWGpGWkOLtdiqIytno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jYvyatymei6H2w7rQr6wOKObMm68VhkhG6/Wi/HHcLdoDNWhukDMm0UxxzmQYionIR2m4LvFLAPnxdAYf2/bVjjek8QKoH+qinL5dhelwovD8Od0eCU+nRZE98KmxOXX0DzM4r0iLXdONs+uIvLM7D4aINez+U3hetLR2rtABoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YpdeVNVl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YpdeVNVl"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68296luoE2527062, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788340007; bh=a+E9l+zwo/RzEHxfvPfK5Hg3nJfsmtSRtSE48sLrFwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YpdeVNVlfKlRU7QbJzHScr/6j2S4A+4Th3GPE1oFYX9M6JYH/Gzn4eN2AMO2cdkjv
	 UfaBMqnpSCXHw0QZvE8Swc8CdN4Fzc6b8hZtrGMZDrfIRN1Kp+DZx8vEuU8QTlq3+x
	 LGVq3KQq2jfxBCFn+jIcrCukUcjc/ZB6X8brur53FMOtJrl/xrkqPFJWS2S8Xn78+r
	 A0J+JM5AIk7yV8RTXBbj/GHq5lDfAzRF1MqIqSszm9uzvxT9fRTqdv1fs3wBhmjfYH
	 WyIu3b+0QR6xestpV3o/+4Ywk+wigU0gHt9uEGGGnr+VLE1sr8p7SAEvMWrd+kPcTR
	 k8S2OJDhJnlhQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68296luoE2527062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 17:06:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 2 Sep 2026 17:06:42 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.43 via Frontend Transport; Wed, 2 Sep 2026 17:06:42 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 2/8] r8152: support RTL8159 for different packages
Date: Wed, 2 Sep 2026 17:06:26 +0800
Message-ID: <20260902090632.41844-3-nic_swsd@realtek.com>
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

RTL8159 has two different packages, QFN68 and QFN100. Therefore, split
RTL_VER_17 into RTL_VER_17_QFN68 and RTL_VER_17_QFN100.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 93 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 15 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0a06c947e381a..38e78b0f20b30 100644
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
@@ -1254,7 +1258,8 @@ enum rtl_version {
 	RTL_VER_14,
 	RTL_VER_15,
 	RTL_VER_16,
-	RTL_VER_17,
+	RTL_VER_17_QFN68,
+	RTL_VER_17_QFN100,
 
 	RTL_VER_MAX
 };
@@ -3446,7 +3451,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
 		break;
 
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, PLA_CR, CR_RE | CR_TE);
 		break;
 
@@ -3486,7 +3492,7 @@ static void rtl_eee_plus_en(struct r8152 *tp, bool enable)
 
 static void rtl_set_eee_plus(struct r8152 *tp)
 {
-	if (tp->version == RTL_VER_17)
+	if (tp->version == RTL_VER_17_QFN68 || tp->version == RTL_VER_17_QFN100)
 		return rtl_eee_plus_en(tp, false);
 
 	if (rtl8152_get_speed(tp) & _10bps)
@@ -3674,7 +3680,8 @@ static void r8153_set_rx_early_timeout(struct r8152 *tp)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_TIMEOUT,
 			       640 / 8);
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EXTRA_AGGR_TMR,
@@ -3719,7 +3726,8 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 			       ocp_data / 8);
 		break;
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		ocp_write_word(tp, MCU_TYPE_USB, USB_RX_EARLY_SIZE,
 			       ocp_data / 16);
 		break;
@@ -3835,6 +3843,8 @@ static void rtl_rx_vlan_en(struct r8152 *tp, bool enable)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		if (enable)
 			ocp_word_set_bits(tp, MCU_TYPE_PLA, PLA_RCR1,
@@ -4514,6 +4524,8 @@ static void r8153_teredo_off(struct r8152 *tp)
 	case RTL_VER_14:
 	case RTL_VER_15:
 	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		/* The bit 0 ~ 7 are relative with teredo settings. They are
 		 * W1C (write 1 to clear), so set all 1 to disable it.
@@ -4568,7 +4580,8 @@ static void rtl_clear_bp(struct r8152 *tp, u16 type)
 		break;
 	case RTL_VER_14:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		ocp_write_word(tp, type, USB_BP2_EN, 0);
 		bp_num = 16;
@@ -4680,7 +4693,8 @@ static bool rtl8152_is_fw_phy_speed_up_ok(struct r8152 *tp, struct fw_phy_speed_
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 	default:
 		break;
 	}
@@ -5840,7 +5854,8 @@ static void rtl_eee_enable(struct r8152 *tp, bool enable)
 	case RTL_VER_13:
 	case RTL_VER_15:
 	case RTL_VER_16:
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		if (enable) {
 			r8156_eee_en(tp, true);
 			ocp_reg_write(tp, OCP_EEE_ADV, tp->eee_adv);
@@ -6431,8 +6446,15 @@ static int rtl8156_enable(struct r8152 *tp)
 	set_tx_qlen(tp);
 	rtl_set_eee_plus(tp);
 
-	if (tp->version >= RTL_VER_12 && tp->version <= RTL_VER_17)
-		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM, RX_AGGR_NUM_MASK);
+	switch (tp->version) {
+	case RTL_VER_10:
+	case RTL_VER_11:
+		break;
+	default:
+		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_RX_AGGR_NUM,
+				  RX_AGGR_NUM_MASK);
+		break;
+	}
 
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
@@ -8146,7 +8168,8 @@ static void r8157_hw_phy_cfg(struct r8152 *tp)
 		sram2_write_w0w1(tp, 0x809d, 0xff00, 0x5000);
 		break;
 
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		/* Disable bypass turn off clk in ALDPS */
 		ocp_byte_clr_bits(tp, MCU_TYPE_PLA, 0xd3c8, BIT(0));
 
@@ -8781,6 +8804,10 @@ static void r8159_init(struct r8152 *tp)
 	/* TX descriptor Signature */
 	ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xd4ae, BIT(1));
 
+	/* Enable u2phy backup restore patch */
+	if (tp->version == RTL_VER_17_QFN68)
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xb99c, BIT(0));
+
 	/* Enable u3phy patch backup */
 	ocp_write_word(tp, MCU_TYPE_USB, 0xb9a2, 0x0448);
 
@@ -10171,7 +10198,8 @@ static int rtl_ops_init(struct r8152 *tp)
 		r8157_desc_init(tp);
 		break;
 
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		tp->eee_en		= true;
 		tp->eee_adv		= MDIO_EEE_100TX | MDIO_EEE_1000T | MDIO_EEE_10GT;
 		tp->eee_adv2		= MDIO_EEE_2_5GT | MDIO_EEE_5GT;
@@ -10263,7 +10291,8 @@ static int rtl_fw_init(struct r8152 *tp)
 	case RTL_VER_16:
 		rtl_fw->fw_name		= FIRMWARE_8157_1;
 		break;
-	case RTL_VER_17:
+	case RTL_VER_17_QFN68:
+	case RTL_VER_17_QFN100:
 		rtl_fw->fw_name		= FIRMWARE_8159_1;
 		break;
 	default:
@@ -10273,9 +10302,33 @@ static int rtl_fw_init(struct r8152 *tp)
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
+	if (ret > 0)
+		pkg_det = __le32_to_cpu(*tmp) & PKG_MASK;
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
@@ -10358,7 +10411,16 @@ static u8 __rtl_get_hw_ver(struct usb_device *udev)
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
+			dev_info(&udev->dev, "Unknown package %#02x\n",
+				 pkg_det);
+		}
 		break;
 	default:
 		version = RTL_VER_UNKNOWN;
@@ -10517,7 +10579,8 @@ static int rtl8152_probe_once(struct usb_interface *intf,
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

