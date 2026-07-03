Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1427137A83B;
	Fri,  3 Jul 2026 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783070732; cv=none; b=RV8nnsXyhogL8AjNVboACMBj1REXR+pP3eS/+T6gAxSjeYRTAFhWsS5sQYHYFDt5/4/BMBUAJ2EfkJkHdwaOoCkT+p2tuD4x4DFJgp8eG8+VwR3apyITEdo4ODzxOUIfTly8EEH+aIuTzI7yKysfZ+8L/57HjdXmwg7itb7smas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783070732; c=relaxed/simple;
	bh=BC0NJh5lQQ122hVtH8AzIUNzP0EX/iN4SjiFUPvgk5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZcbcIouQaW/F7DzU+bRP9A0OVAeRC804lzo4RkU4nSn9EczimbgKYjeRbUp9DXPr4FLSCmcb6/C2X6wYLRoLKk4Ep1sQOyPcB/LjLN9eLejhG6DT3CSOOKUoZqFGt72dlrvGmYL7cDIIRM8vl5PMY066ltMtsUJSemSQ1Rr1ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=dwGcIKtE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="dwGcIKtE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6639P3SP02572104, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1783070703;
	bh=+kT5yU6Ef5iU/4OhNJLHePO4rERZ5bK7dWHx9aP4GeY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dwGcIKtEKsxCXwQMryQ3aHGofcOz+obvh3a+bSCzXkQd8li+CSaxs/jFo13koxk3M
	 kgNQESjEaD87QdA94RtOED4OU+lJkzh9Jqr8oeWGIOYfv++PoHFiq/DtSfKW+TnqC+
	 d/8pDTG5SyO+PutvzJOuOMZjTA+WRkGODOsfMob0E32uIT8/IfRmoXttP/MZwMiQku
	 UVNU/JI9Q46AK6dXKuHhnxI9URcUJBcSo9kxKO/I3ohiNy3BzUTh/1MSCbywjE2Ckh
	 92ywt7asgTrqCB048FpryuGrQEZLii4NrGJXbh8tlCk3q+InISBDkpfdTrP/HsEP2U
	 c43ex0GMd0O2w==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6639P3SP02572104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 Jul 2026 17:25:03 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 3 Jul 2026 17:25:02 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 3 Jul 2026 17:25:02 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v4 4/6] r8169: add ltr support for RTL8117 series
Date: Fri, 3 Jul 2026 17:24:57 +0800
Message-ID: <20260703092459.1124-5-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260703092459.1124-1-javen_xu@realsil.com.cn>
References: <20260703092459.1124-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds ltr support for RTL8117 series, enables RTL8117 series
enter l1.2 state. This makes sense for the system to enter c10 state.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes
 
Changes in v4:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index b5816550a4a6..635131c51db9 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -347,11 +347,13 @@ enum rtl_registers {
 	ALDPS_LTR	= 0xe0a2,
 	LTR_OBFF_LOCK	= 0xe032,
 	LTR_SNOOP	= 0xe034,
+	SEND_LTR_MSG	= 0xe038,
 
 #define ALDPS_LTR_EN			BIT(0)
 #define LTR_OBFF_LOCK_EN		BIT(0)
 #define LINK_SPEED_CHANGE_EN		BIT(14)
 #define LTR_SNOOP_EN			GENMASK(15, 14)
+#define LTR_MSG_EN			BIT(0)
 };
 
 enum rtl8168_8101_registers {
@@ -3201,8 +3203,22 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
 		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
 		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
 		break;
-	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 	case RTL_GIGA_MAC_VER_52:
+		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
+		r8168_mac_ocp_modify(tp, LTR_SNOOP, 0x0000, LTR_SNOOP_EN);
+		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
+		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
+		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
+		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
+		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
+		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
+		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xe0a6, 0x9003);
+		r8168_mac_ocp_write(tp, 0xe0a8, 0x9003);
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
 		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
 		fallthrough;
@@ -3222,6 +3238,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
 	}
 	/* chip can trigger LTR */
 	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
+	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);
 }
 
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
@@ -3255,6 +3272,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
@@ -3267,6 +3285,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
-- 
2.43.0

