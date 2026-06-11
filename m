Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDBB3BF66C;
	Thu, 11 Jun 2026 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171073; cv=none; b=f3oXlSTr4oPSjqczTKiTQWCYGm2YmvDVN+dxhTw2R9IOG8bJ9pUrQvtA2t3QVoEW+CdEfeF5ZGgYVgNzGWIIWuwRTvEfLhXcBMwMRfUX9D9ZwoCgN0enz6TQxM5Elg1qN14PZJTgxflrkeo2HEI5U8ucgF1Yw6iBs7fH8iCxvoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171073; c=relaxed/simple;
	bh=DRec+STtuzz0Cp+qKwtuhwoM5dZKh7m7ZQ+ezOy/TOY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea8Eh0A/sOsDJEFaAtOG5J9+zFrLiwjgBbglp38aGdgxJQWQI19vvpncGfijTAmCGvpVbLQiOJZvNZNKryYBWoyYElZjj4WBbTzM8Q1LM7FjPqzEbe4jdjv23BmLI58+yoPD8ZrPogXwm4MF1ynUs+Sdoy36Oc9yQiZMDAyO5oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=fPgvs2rG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="fPgvs2rG"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65B9hmUvB1836014, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1781171028;
	bh=/DKCNiejNWOX7n8MegdIbSiH6PILq+EtTRyzc6cFM5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fPgvs2rGV2naM1AyUw5UfxsNbiRYUYQ+vCoqVDQqnrqJm4mQIac4ITO8wMdMilQx3
	 78J9e/IZo4yZX+8SVQasuz8mBl1tiHQK2hOay14rPb5YSGOV/6241DSW4U7+BycfTx
	 JP7jjsu0LgDHRuqeD4DkYoR7fsgjmkuJi+O41BjXHZdH5AvO9xWi04tp/2yBkGfaWv
	 3tNxquvj99t61QiP1jGVUEuX6uEHYyp8TSxfkaHMDgU9unrS1xDbmoReRW2hZn7RWU
	 vuwnyohaw4Zpb6NM/uyeYmkCwaX16o5YsiY1rNQi4yJIaKTXdpPN4x9AUyeYl7lAga
	 SN+xX4aJRWyoQ==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65B9hmUvB1836014
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jun 2026 17:43:48 +0800
Received: from RS-EX-MBS1.realsil.com.cn (172.29.17.101) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 11 Jun 2026 17:43:48 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS1.realsil.com.cn
 (172.29.17.101) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 11 Jun 2026 17:43:48 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v2 5/6] r8169: add ltr support for RTL8116af
Date: Thu, 11 Jun 2026 17:43:44 +0800
Message-ID: <20260611094345.880-6-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260611094345.880-1-javen_xu@realsil.com.cn>
References: <20260611094345.880-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds ltr support for RTL8116af, enables RTL8116af enter l1.2
state. This makes sense for the system to enter c10 state.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 31 +++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index a73c0215b240..a49e7a8d8f4d 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -349,11 +349,13 @@ enum rtl_registers {
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
@@ -3153,8 +3155,22 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
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
@@ -3174,6 +3190,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
 	}
 	/* chip can trigger LTR */
 	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
+	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);
 }
 
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
@@ -3207,6 +3224,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
@@ -3219,6 +3237,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
@@ -3732,7 +3751,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 
 	rtl_eri_set_bits(tp, 0xd4, 0x0010);
 
-	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4f87);
+	rtl_eri_write(tp, 0x5f0, ERIAR_MASK_0011, 0x4000);
+
+	r8168_mac_ocp_write(tp, 0xe098, 0xc302);
 
 	rtl_disable_rxdvgate(tp);
 
@@ -3759,9 +3780,9 @@ static void rtl_hw_start_8117(struct rtl8169_private *tp)
 	}
 
 	r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0000);
-	r8168_mac_ocp_write(tp, 0xea80, 0x0003);
-	r8168_mac_ocp_modify(tp, 0xe052, 0x0000, 0x0009);
-	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x047f);
+	r8168_mac_ocp_write(tp, 0xea80, 0x0000);
+	r8168_mac_ocp_modify(tp, 0xe052, 0x0009, 0x0000);
+	r8168_mac_ocp_modify(tp, 0xd420, 0x0fff, 0x045f);
 
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0001);
 	r8168_mac_ocp_write(tp, 0xe63e, 0x0000);
-- 
2.43.0

