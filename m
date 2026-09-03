Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D593FB07E;
	Thu,  3 Sep 2026 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788420574; cv=none; b=WWrWr/k1NtaT+ijVgD/qv7k9h0EgVmXLzlpFBmulaIYdfvLGIQANY9ubMq3D13yg5utzi+DbKuubPiDDRvXPogUPslpp+gaN37uT8t0MSIFvWGu435gv1ADU/LIfWYJc84NFE/6R7GYRmWHGDejtPYu3i/5K8iVP/AGAlR+1jl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788420574; c=relaxed/simple;
	bh=u1AEGd4v8vg+H9oKGs7YnfpOC2CfkuqfXBVIKdp7dSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWDg/20RRuy+COENgrpYGwMLfMisTOkYkoEZjRdDhPc+YQB5DRvrqIea5EnvziSWyZhFX+kkJFfuZrPixQ8mMa29wKbYU3lB4p1bNmnIM175+0+dUVJPUh+gLQoHLSxhfrnT8+QVrT1/sPbXbcS52lM9FRjuScAMXSjtY/CItqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ilU7vbWs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ilU7vbWs"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6837StFfA3295546, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788420535; bh=5Y4hBGY+aGo4VojakQGtbSySHwNLtKo5TcqlmyPJyGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ilU7vbWs62GTUdKWj6hQEFqPjLxttYU/ZJMgz258hei+1ZhHVvuPycux7zUtU5Oz8
	 3CZQ8NwZu0fwhsg+TjdmYYsqbTQrDdn0yMUkc1OrHMRg+w8Yq6VJDcDAaZLuLDlWvB
	 WuRSLEjnxLh3JP4jsiBx1R1O7tZHMRaDod19f82+cqigr1mXthwG8nyUyQZ6/I7Sny
	 kNBoQxsRUnEAScEagq8oN4CXFxgh64bq1ZxAD+8bGvTnxBe8+Ra65Q8AaVdZ67eGOs
	 s9YVpBjDwocqBgPZS5oopPhUZblJ0pdn15GbYCWdVK5eSwnn2lbKD+eWftM2ZSxdCW
	 bVNnyY1qKnsaQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6837StFfA3295546
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
Subject: [PATCH net-next v2 8/8] r8152: support UPS for RTL8157 and RTL8159
Date: Thu, 3 Sep 2026 15:28:52 +0800
Message-ID: <20260903072852.58695-9-nic_swsd@realtek.com>
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

RTL8157 and RTL8159 support UPS but need different enable logic and EEE
flag handling than RTL8156. Add r8157_ups_en() and extend
r8156_ups_flags() with per-speed EEE flags (100M through 10G) and
5G/10G speed entries for VER_16/17.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 110 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 12 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 2a96f3609c2b0..d219b242e1b2d 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -132,6 +132,7 @@
 #define USB_BURST_SIZE		0xcfc0
 #define USB_FW_FIX_EN0		0xcfca
 #define USB_FW_FIX_EN1		0xcfcc
+#define USB_FW_USE_VER          0xcfd7
 #define USB_LPM_CONFIG		0xcfd8
 #define USB_ECM_OPTION		0xcfee
 #define USB_CSTMR		0xcfef	/* RTL8153A */
@@ -619,6 +620,11 @@
 #define UPS_FLAGS_250M_CKDIV		BIT(2)
 #define UPS_FLAGS_EN_ALDPS		BIT(3)
 #define UPS_FLAGS_CTAP_SHORT_DIS	BIT(4)
+#define UPS_FLAGS_EN_100M_EEE		BIT(9)
+#define UPS_FLAGS_EN_1000M_EEE		BIT(10)
+#define UPS_FLAGS_EN_2500M_EEE		BIT(11)
+#define UPS_FLAGS_EN_5000M_EEE		BIT(12)
+#define UPS_FLAGS_EN_10G_EEE		BIT(13)
 #define UPS_FLAGS_SPEED_MASK		(0xf << 16)
 #define ups_flags_speed(x)		((x) << 16)
 #define UPS_FLAGS_EN_EEE		BIT(20)
@@ -4185,8 +4191,27 @@ static void r8156_ups_flags(struct r8152 *tp)
 	if (tp->ups_info.aldps)
 		ups_flags |= UPS_FLAGS_EN_ALDPS;
 
-	if (tp->ups_info.eee)
-		ups_flags |= UPS_FLAGS_EN_EEE;
+	if (tp->ups_info.eee) {
+		switch (tp->version) {
+		case RTL_VER_17_QFN68:
+			if (tp->eee_adv & MDIO_EEE_10GT)
+				ups_flags |= UPS_FLAGS_EN_10G_EEE;
+			fallthrough;
+		case RTL_VER_16:
+			if (tp->eee_adv & MDIO_EEE_100TX)
+				ups_flags |= UPS_FLAGS_EN_100M_EEE;
+			if (tp->eee_adv & MDIO_EEE_1000T)
+				ups_flags |= UPS_FLAGS_EN_1000M_EEE;
+			if (tp->eee_adv2 & MDIO_EEE_2_5GT)
+				ups_flags |= UPS_FLAGS_EN_2500M_EEE;
+			if (tp->eee_adv2 & MDIO_EEE_5GT)
+				ups_flags |= UPS_FLAGS_EN_5000M_EEE;
+			break;
+		default:
+			ups_flags |= UPS_FLAGS_EN_EEE;
+			break;
+		}
+	}
 
 	if (tp->ups_info.flow_control)
 		ups_flags |= UPS_FLAGS_EN_FLOW_CTR;
@@ -4237,20 +4262,33 @@ static void r8156_ups_flags(struct r8152 *tp)
 	case NWAY_2500M_FULL:
 		ups_flags |= ups_flags_speed(9);
 		break;
+	case NWAY_5000M_FULL:
+		ups_flags |= ups_flags_speed(10);
+		break;
+	case NWAY_10000M_FULL:
+		ups_flags |= ups_flags_speed(11);
+		break;
 	default:
 		break;
 	}
 
-	switch (tp->ups_info.lite_mode) {
-	case 1:
-		ups_flags |= 0 << 5;
-		break;
-	case 2:
-		ups_flags |= 2 << 5;
+	switch (tp->version) {
+	case RTL_VER_16:
+	case RTL_VER_17_QFN68:
 		break;
-	case 0:
 	default:
-		ups_flags |= 1 << 5;
+		switch (tp->ups_info.lite_mode) {
+		case 1:
+			ups_flags |= 0 << 5;
+			break;
+		case 2:
+			ups_flags |= 2 << 5;
+			break;
+		case 0:
+		default:
+			ups_flags |= 1 << 5;
+			break;
+		}
 		break;
 	}
 
@@ -4422,6 +4460,35 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
 	}
 }
 
+static void r8157_ups_en(struct r8152 *tp, bool enable)
+{
+	if (enable) {
+		r8156_ups_flags(tp);
+
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE | PHASE2_EN);
+
+		ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
+	} else {
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
+				  UPS_EN | USP_PREWAKE);
+
+		ocp_byte_clr_bits(tp, MCU_TYPE_USB, USB_MISC_2,
+				  UPS_FORCE_PWR_DOWN);
+
+		if (ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0) & PCUT_STATUS) {
+			/* clear USB fw_ver_reg */
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USE_VER, 0);
+
+			tp->rtl_ops.hw_phy_cfg(tp);
+
+			rtl8152_set_speed(tp, tp->autoneg, tp->speed,
+					  tp->duplex, tp->advertising);
+		}
+	}
+}
+
 static void r8153_power_cut_en(struct r8152 *tp, bool enable)
 {
 	if (enable)
@@ -4580,9 +4647,28 @@ static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
 		r8153b_u1u2en(tp, false);
 		r8157_u2p3en(tp, false);
 		rtl_runtime_suspend_enable(tp, true);
+
+		switch (tp->version) {
+		case RTL_VER_16:
+		case RTL_VER_17_QFN68:
+			r8157_ups_en(tp, true);
+			break;
+		default:
+			break;
+		}
 	} else {
 		r8153_queue_wake(tp, false);
 		rtl_runtime_suspend_enable(tp, false);
+
+		switch (tp->version) {
+		case RTL_VER_16:
+		case RTL_VER_17_QFN68:
+			r8157_ups_en(tp, false);
+			break;
+		default:
+			break;
+		}
+
 		r8157_u2p3en(tp, true);
 		if (tp->udev->speed >= USB_SPEED_SUPER)
 			r8153b_u1u2en(tp, true);
@@ -9027,7 +9113,7 @@ static void r8157_init(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
 	r8157_power_cut_en(tp, false);
-	r8156_ups_en(tp, false);
+	r8157_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
@@ -9137,7 +9223,7 @@ static void r8159_init(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
 	r8157_power_cut_en(tp, false);
-	r8156_ups_en(tp, false);
+	r8157_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
-- 
2.34.1

