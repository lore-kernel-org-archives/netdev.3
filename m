Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456053B5DEE;
	Thu, 30 Jul 2026 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394591; cv=none; b=duY3AwzsZEvQbcUHR8rsGCTXnrmU2ZV620k/iZsReAVeVjSI6R8lKKApxdaeUV2SI7cIURzQElgYDnk4b5jk0J2FyqaDuSRSdMyhcDhpJW+b14y6tXEc6WWAYdEOg2JttTVTKC3OnFuT4nhFp6rakFIlDGVNRrh8gFPR3py2krg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394591; c=relaxed/simple;
	bh=ZeS0KQ4z5uSjOIlrknT2knDxgm4+TRgfq+4ofrwp2GI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgId3a2A4mkfUVGiRNjcDXY1bGE6mTKGv3rzVxJQ005bSX9pMK33yWHtVX4K8/qHJfW0y3c3/h+ubmhS7Yj90x2A7FxHpmncPQ7edT74K7TiqN436W87gh4Ue5bXHcZflIWxJP3Wa6GBOXDDJln4QTqmuiiopAhBuREOqBxn9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=cKAx9okT; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="cKAx9okT"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66U6oIdX51003586, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1785394219;
	bh=DMOo6aYyoKBceRP5IInOz/OtXptI/CHZnDy+L/eD7yc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=cKAx9okThHbQvwsdj/PWcn1co6sErUz9EJ+lsBuIOue0JjYRdh0j2Li+NBNvVbQgx
	 P8ab+6oCcGWJ5BhwVtMb7GZJDBH09z/1iQI96dL5ws9l5SAmKNZKQLW53YwNp6bWSq
	 BLxFYjPnlyxXPN+9Ecnc1b+IFFAPp5EhuJHn7dwfpjwCL4/iWPsGhEn9YeQ+ijsYR3
	 oWHQe/moce9iA59hnhjsdzqpNxfeZsY79RFzeuV+IuoqiMGUQAA0YkSmcZlk0Zugb2
	 PA3htLioKE5PQEQ9a92KGjzWkYmbbHpvkV/754cRkdXOQFyXZApWvgFCr6Lx3DbBRh
	 hNpoN23dkhgKg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66U6oIdX51003586
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 14:50:18 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 30 Jul 2026 14:50:18 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Thu, 30 Jul 2026 14:50:17 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>
Subject: [PATCH net-next v8 6/7] r8169: add ltr support for RTL8117 series
Date: Thu, 30 Jul 2026 14:50:13 +0800
Message-ID: <20260730065014.883-7-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260730065014.883-1-javen_xu@realsil.com.cn>
References: <20260730065014.883-1-javen_xu@realsil.com.cn>
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

This patch drops the COMBO_LTR_EXTEND_EN write for VER_52. This is
intentional, as this bit is not required for RTL8116af.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - no changes

Changes in v3:
 - no changes

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - no changes

Changes in v7:
 - no changes

Changes in v8:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 3258628a989c..c2873b436362 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -353,11 +353,13 @@ enum rtl_registers {
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
@@ -3192,8 +3194,23 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
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
+		r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0000, LINK_SPEED_CHANGE_EN);
+		break;
+	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
 		r8168_mac_ocp_modify(tp, ALDPS_LTR, 0x0000, ALDPS_LTR_EN);
 		RTL_W8(tp, COMBO_LTR_EXTEND, RTL_R8(tp, COMBO_LTR_EXTEND) | COMBO_LTR_EXTEND_EN);
 		fallthrough;
@@ -3213,6 +3230,7 @@ static void rtl_enable_ltr(struct rtl8169_private *tp)
 	}
 	/* chip can trigger LTR */
 	r8168_mac_ocp_modify(tp, LTR_OBFF_LOCK, 0x0003, LTR_OBFF_LOCK_EN);
+	r8168_mac_ocp_modify(tp, SEND_LTR_MSG, 0x0000, LTR_MSG_EN);
 }
 
 static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
@@ -3246,6 +3264,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		rtl_enable_ltr(tp);
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			/* reset ephy tx/rx disable timer */
 			r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
@@ -3258,6 +3277,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 	} else {
 		switch (tp->mac_version) {
 		case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
+		case RTL_GIGA_MAC_VER_52:
 		case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:
 			r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
 			break;
-- 
2.43.0

