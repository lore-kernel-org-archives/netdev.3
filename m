Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=211.75.126.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281115;
	b=MV+Np84ncOVPknPdBGd8a8mdTbcucPnR3yFYfU3fncNti7I4pYszeXdZCF+qiM3BFsaM
	 8t5/DSl/gByzR2jyxzheQLwhcX5ugEoAkwa9oEwIWEovgrCDqxCny9xoljaDFDRzlo2li
	 PJD/CiPjRiVWjSG1sibWPQn4Pr9KvGPHUP40/6H8t8aSGJjQzKPYz9VoLLEvtcO0i6QyX
	 Y8MfvdnmjiZeJpz3m6BZL2hWWuwCb5t805hhl9jMz7u6DUPdHFHUj7pS+pBJ1YjKnhJG9
	 xGrftC5osMSZIAVU9/P0UOt6/C3Y8ib81laqBW+gUG4k6lzGnH2cUylPZYFtdv3Y6ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281115;
	h=DMARC-Filter:X-SpamFilter-By:DKIM-Signature:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type;
	bh=KxNz16v6fBPYQdauV++0n3a4d4VPr01b+nPZgJaXAVY=;
	b=P02v0WI+BVgZXv56LkAHSlRK9i0aPX1eGvIPSOPp/fKGkDITj5GaCTh1dlURQXWB3BK1
	 PsWO1Z40pCwdOC9OVVseGRuXubniPANIoeGdLSE+o/IEtoxpiRB4A4qBMJQa/H1dmisQG
	 Mp8fP6DrvmHMyCsnWVINupP4w4TGAfIcMDk8Ul0lI6U5PhHV9komMsfHNhfcFF3ZtkHJ5
	 yxyAP1rsAObbHKcrbCFsoaq7zQlsFmItlAJQPMbvs7ZHOI9V4lf8vv8qiSDGpRY5IxeC/
	 qt5CecabbMRDiIJNpb13csaM3/w0IWRL9C4P2fFVeppkTon/jOKVoL7DsM93FMvMsEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=realtek.com;
	spf=pass smtp.mailfrom=realtek.com;
	dkim=pass header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=Bbznc4Gz;
	arc=none smtp.remote-ip=211.75.126.72
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281B360A6F56;
	Tue, 10 Nov 2026 03:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 281B360A6F56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256 header.s=dkim header.b=Bbznc4Gz
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6AA3OOQy8884638, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1794281064; bh=KxNz16v6fBPYQdauV++0n3a4d4VPr01b+nPZgJaXAVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Bbznc4GzQ34cuOVuZumlq2pg2fGP8bR7EHObv0vfY7F2Rzu+sdHibVly5XBWv3csW
	 BN79IKdMIvq980zyjXbfEKs+9tE7bpX2OuISG6QEygUIBcLuTwF8p4dn0yVTrLrl1G
	 Ldlr98qs1pUGPMe1YXX/0LvXV9ObaPVAbiIbw+JSHMjbF0cNStN72+ZAjtGjCcG0pt
	 tMHujEvqqxZmbAxDOLc553vCvXE+lS1lxjA4cPk2S2QqIcKSolDjyrZSZ8ITu87TLP
	 aczCjwG9lhc+Ast+lkcTy99F3a3W6v+LEih500/XYAccR+Fv1G1R++WkeJeJr4krFn
	 31bebkFCXZlhQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6AA3OOQy8884638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Nov 2026 11:24:24 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:25 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 10 Nov 2026 11:24:21 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server id
 15.2.2562.56 via Frontend Transport; Tue, 10 Nov 2026 11:24:21 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v8 11/11] r8152: enable UPS for RTL8157 and RTL8159 QFN68
Date: Tue, 10 Nov 2026 11:24:16 +0800
Message-ID: <20261110032416.16968-12-nic_swsd@realtek.com>
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

RTL8157 and RTL8159 QFN68 support UPS, but rtl8157_runtime_enable()
never toggled it on runtime suspend/resume, and r8156_ups_flags()
used the older per-chip EEE/lite_mode encoding instead of the
per-speed EEE flags their UPS firmware expects. RTL8159 QFN100 does
not support UPS.

Add r8157_ups_en(), mirroring r8156_ups_en(), and call it from
rtl8157_runtime_enable() for VER_16/QFN68 only; QFN100 keeps its
existing no-UPS behaviour there. Use r8157_ups_en(tp, false) in
r8157_init() in place of r8156_ups_en(tp, false).

Extend r8156_ups_flags() with per-speed EEE flags
(UPS_FLAGS_EN_100M_EEE/1000M_EEE/2500M_EEE/5000M_EEE/10G_EEE) and
skip the lite_mode bits[6:5] encoding for VER_16/QFN68. Add
ups_flags_speed() entries 10 and 11 for NWAY_5000M_FULL and
NWAY_10000M_FULL, previously unmapped.

Add the USB_FW_USB_VER register (0xcfd7), used by the new
r8157_ups_en() disable path.

If the backup-restore wait in r8157_ups_en() times out, it marks the
device inaccessible and logs, without queuing a reset, as
r8157_init() does for the same wait. During runtime resume the
interface then stays unusable until a replug or an unrelated reset,
since r8157_ups_en() returns void and the error is not passed back.
Recovery for these timeouts is left to a follow-up series.

Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
---
 drivers/net/usb/r8152.c | 131 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 120 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 703ec5483778b..9c7031f938bc2 100644
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
@@ -4256,8 +4262,27 @@ static void r8156_ups_flags(struct r8152 *tp)
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
@@ -4308,20 +4333,33 @@ static void r8156_ups_flags(struct r8152 *tp)
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
 
@@ -4496,6 +4534,58 @@ static void r8156_ups_en(struct r8152 *tp, bool enable)
 	}
 }
 
+static void r8157_ups_en(struct r8152 *tp, bool enable)
+{
+	u32 ocp_data;
+	int ret;
+
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
+		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
+		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+			return;
+
+		if (ocp_data & PCUT_STATUS) {
+			ret = read_poll_timeout(ocp_read_word, ocp_data,
+						test_bit(RTL8152_INACCESSIBLE,
+							 &tp->flags) ||
+						(ocp_data & BACKUP_RESTRORE),
+						200, 20000, false, tp,
+						MCU_TYPE_USB, USB_GPHY_CTRL);
+			if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
+				return;
+
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
@@ -4654,9 +4744,28 @@ static void rtl8157_runtime_enable(struct r8152 *tp, bool enable)
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
@@ -9120,7 +9229,7 @@ static void r8157_init(struct r8152 *tp)
 	ocp_write_word(tp, MCU_TYPE_USB, USB_U1U2_TIMER, 500);
 
 	r8157_power_cut_en(tp, false);
-	r8156_ups_en(tp, false);
+	r8157_ups_en(tp, false);
 	r8153_queue_wake(tp, false);
 	rtl_runtime_suspend_enable(tp, false);
 
-- 
2.34.1

