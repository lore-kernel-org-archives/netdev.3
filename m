Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0824B0497;
	Thu,  1 Oct 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845945; cv=none; b=ZXA73qM/5h36EeRWbpDtppVUo9cWVPTcVeKTVLDmkjNtuxLwF97PpJKwSn9iQfxxyB0JZz6mTgUH1fWjurlU6rI3pDXwfjISz2Wto90VA6HiHuqQHsHO6h2FamBhj4lK1ni9bWLWFVZm3SbbfHvCc5Bv+FK8QXrqyoj+cQkLvQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845945; c=relaxed/simple;
	bh=JqyH+NwlK6HLJp5WIDQAdZnLFFfTxO+gIjqm2QSqgcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2WgtLs31F3qwIxaZBtpS0DrvjuFS3s/8MMastGkCdEIXU3+zZ9H8oAm4b59rEfDGeeR9PCe53IyqVjvi1WF3acwsO+w2HR3BXKaf5hYrqzke20A+8G7VDbWacOPmX6QMvxsBDCSbItHlTmqP+A4Z2u0A9gO23kmQevIXEMEbf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F6c4sKi1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F6c4sKi1"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6919BnFT22836516, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790845909; bh=ZaLfFN2NJVNYmaT9DyhU1HAp7JQ2dWe8EiGCMwqjUk0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=F6c4sKi181TPfSxcZazYeffnTLrisoGPOJ3HfQ0mttHbc+fniok100rls1mkJu1bl
	 eJY4DD5IKHWz9SqFS0PIKQobynMxgDRHFjTs+ZcFz1HYRDxL1+FG/jAbr24ydeuw91
	 Da2py/mQo6ntGVZAG4RC1ZC3mjLwH0dxaVz0PM4EnjvP1t2BpzLz/O/Idkxof2Ck0W
	 VuDX+nFWPTWemimFuIkpXfrMeTnzcQUMYP0z6HoW0DAn/q86raiHOXb4KJjgGciM/y
	 dYRDhABpv+C2zPE3vntoew6gPK8cdP1e4ykk0CZZXhKD8bsfsmJmVt99xTL5FxJh46
	 CyYVNw+76XTrw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6919BnFT22836516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Oct 2026 17:11:49 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:47 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 17:11:47 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v5 9/9] r8152: enable UPS for RTL8157 and RTL8159 QFN68
Date: Thu, 1 Oct 2026 17:11:44 +0800
Message-ID: <20261001091144.28191-10-nic_swsd@realtek.com>
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

RTL8157 and RTL8159 QFN68 support UPS, but rtl8157_runtime_enable()
never toggled it on runtime suspend/resume, and r8156_ups_flags()
used the older per-chip EEE/lite_mode encoding instead of the
per-speed EEE flags their UPS firmware expects. RTL8159 QFN100 does
not support UPS.

Add r8157_ups_en(), mirroring r8156_ups_en(), and call it from
rtl8157_runtime_enable() for VER_16/QFN68 only; QFN100 keeps its
existing no-UPS behaviour there. Use r8157_ups_en(tp, false) in
r8157_init()/r8159_init() in place of r8156_ups_en(tp, false).

Extend r8156_ups_flags() with per-speed EEE flags
(UPS_FLAGS_EN_100M_EEE/1000M_EEE/2500M_EEE/5000M_EEE/10G_EEE) and
skip the lite_mode bits[6:5] encoding for VER_16/QFN68. Add
ups_flags_speed() entries 10 and 11 for NWAY_5000M_FULL and
NWAY_10000M_FULL, previously unmapped.

Add the USB_FW_USB_VER register (0xcfd7), used by the new
r8157_ups_en() disable path.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 124 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 12 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index b2e4b071d84f0..baac964fea80f 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -132,6 +132,7 @@
 #define USB_BURST_SIZE		0xcfc0
 #define USB_FW_FIX_EN0		0xcfca
 #define USB_FW_FIX_EN1		0xcfcc
+#define USB_FW_USB_VER          0xcfd7
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
@@ -4246,8 +4252,27 @@ static void r8156_ups_flags(struct r8152 *tp)
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
@@ -4298,20 +4323,33 @@ static void r8156_ups_flags(struct r8152 *tp)
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
 
@@ -4486,6 +4524,49 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
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
+			u32 ocp_data;
+			int ret;
+
+			ret = read_poll_timeout(ocp_read_word, ocp_data,
+						ocp_data & BACKUP_RESTRORE, 200,
+						20000, false, tp, MCU_TYPE_USB,
+						USB_GPHY_CTRL);
+			if (ret) {
+				rtl_set_inaccessible(tp);
+				dev_err(&tp->intf->dev,
+					"backup-restore timed out\n");
+				return;
+			}
+
+			/* clear USB fw_ver_reg */
+			ocp_write_byte(tp, MCU_TYPE_USB, USB_FW_USB_VER, 0);
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
@@ -4644,9 +4725,28 @@ static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
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
@@ -9142,7 +9242,7 @@ static void r8157_init(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
 	r8157_power_cut_en(tp, false);
-	r8156_ups_en(tp, false);
+	r8157_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
@@ -9252,7 +9352,7 @@ static void r8159_init(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
 	r8157_power_cut_en(tp, false);
-	r8156_ups_en(tp, false);
+	r8157_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
-- 
2.34.1

