Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9D02EEE62;
	Wed, 22 Jul 2026 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784687729; cv=none; b=dfDrv4rvko4XAPXvSgoBHdckV92P9MXnxu9A5fZV4HTgaOmWoU8oZTqNPr1F6yLNPfdj2zsOY2Bm+eU3WxUFNyO5g5zbV5U2BearfL3/2o+hcH2YBcU7frKnyzWoQxwnzKuXbgFX49gywlvwFt5wi/50D4T2HkmEx5xoXoTUauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784687729; c=relaxed/simple;
	bh=aLVJ65lHO1HLVS5zuPPKCLMQNKCWuDDrTCE/7TgBgns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvmHhNjbmuF87XtH+gmDEkpjCUUrHWX59XNiGgNAiNIk893Q6nZzUKXaqBPMjeoVLC2DGSKtDUL0JZ862rmDF6ZuO1hzhCqIy0Py+Br5H8rWhQ+h8wXu5YBFAi8MhB0ztfLwbZVnrAYY7qf+05FkwJj+sEeyMOFCRr9y+v+/Pc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=U27f1qLh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="U27f1qLh"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66M2T9S803599459, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1784687349;
	bh=zrTu82WAenAcirI3SMhiBMdq9KesCAU/lLNMpK8hMHU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=U27f1qLhzQcHQXBfb0C9LK2Y0eo+MXTy1xJ+53CnK5WAimByOHW8vdOTvA5dfqEmG
	 gIfXSZzrER8oclSLCbO24wBuegafRCIhq8BZg4UG9J+QIx1EkAnP0LoeTWcBEqldam
	 1/jSOvnZKxCEASReVYt3CLgK7WwGlQV2t49f5WhBTtg+W2St4wrVXp27fNSJeJFJH7
	 0ZuL0d+sp2fokXE7i43lk96f4qUWxDCh8kEpqB6urdxHPnEqSfItIj5lbl4PJZHoeL
	 di9c/TFxUVpT2YpoZkE92qaU3ICcZ7X1A3veq5u38IjGSL1BNkGNAZaQ9gRfNenEUB
	 HJwuJ7etl7lEQ==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66M2T9S803599459
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Jul 2026 10:29:09 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Jul 2026 10:29:08 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Jul 2026 10:29:08 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <maxime.chevallier@bootlin.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<daniel@makrotopia.org>, <linux@armlinux.org.uk>, <enelsonmoore@gmail.com>,
	<daniel@thingy.jp>, Javen Xu <javen_xu@realsil.com.cn>, Andrew Lunn
	<andrew@lunn.ch>
Subject: [PATCH net-next v7 1/7] r8169: add speed in private struct
Date: Wed, 22 Jul 2026 10:29:00 +0800
Message-ID: <20260722022906.271-2-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260722022906.271-1-javen_xu@realsil.com.cn>
References: <20260722022906.271-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

This patch adds speed in private struct in order to decouple
from phydev in the following patch supporting for phylink.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
Changes in v2:
 - repalce current_speed with speed

Changes in v3:
 - update tp->speed in rtl8169_set_link_ksettings()

Changes in v4:
 - no changes

Changes in v5:
 - no changes

Changes in v6:
 - no changes
---
 drivers/net/ethernet/realtek/r8169_main.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..c60710f9bd21 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -750,6 +750,7 @@ struct rtl8169_private {
 	u32 irq_mask;
 	int irq;
 	struct clk *clk;
+	int speed;
 
 	struct {
 		DECLARE_BITMAP(flags, RTL_FLAG_MAX);
@@ -1673,16 +1674,14 @@ static void rtl8169_irq_mask_and_ack(struct rtl8169_private *tp)
 	rtl_pci_commit(tp);
 }
 
-static void rtl_link_chg_patch(struct rtl8169_private *tp)
+static void rtl_link_chg_patch(struct rtl8169_private *tp, int speed)
 {
-	struct phy_device *phydev = tp->phydev;
-
 	if (tp->mac_version == RTL_GIGA_MAC_VER_34 ||
 	    tp->mac_version == RTL_GIGA_MAC_VER_38) {
-		if (phydev->speed == SPEED_1000) {
+		if (speed == SPEED_1000) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
-		} else if (phydev->speed == SPEED_100) {
+		} else if (speed == SPEED_100) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x0000001f);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
 		} else {
@@ -1692,7 +1691,7 @@ static void rtl_link_chg_patch(struct rtl8169_private *tp)
 		rtl_reset_packet_filter(tp);
 	} else if (tp->mac_version == RTL_GIGA_MAC_VER_35 ||
 		   tp->mac_version == RTL_GIGA_MAC_VER_36) {
-		if (phydev->speed == SPEED_1000) {
+		if (speed == SPEED_1000) {
 			rtl_eri_write(tp, 0x1bc, ERIAR_MASK_1111, 0x00000011);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x00000005);
 		} else {
@@ -1700,7 +1699,7 @@ static void rtl_link_chg_patch(struct rtl8169_private *tp)
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_1111, 0x0000003f);
 		}
 	} else if (tp->mac_version == RTL_GIGA_MAC_VER_37) {
-		if (phydev->speed == SPEED_10) {
+		if (speed == SPEED_10) {
 			rtl_eri_write(tp, 0x1d0, ERIAR_MASK_0011, 0x4d02);
 			rtl_eri_write(tp, 0x1dc, ERIAR_MASK_0011, 0x0060a);
 		} else {
@@ -2074,11 +2073,11 @@ rtl_coalesce_info(struct rtl8169_private *tp)
 		ci = rtl_coalesce_info_8168_8136;
 
 	/* if speed is unknown assume highest one */
-	if (tp->phydev->speed == SPEED_UNKNOWN)
+	if (tp->speed == SPEED_UNKNOWN)
 		return ci;
 
 	for (; ci->speed; ci++) {
-		if (tp->phydev->speed == ci->speed)
+		if (tp->speed == ci->speed)
 			return ci;
 	}
 
@@ -2236,7 +2235,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
 
 static unsigned int r8169_get_tx_lpi_timer_us(struct rtl8169_private *tp)
 {
-	unsigned int speed = tp->phydev->speed;
+	unsigned int speed = tp->speed;
 	unsigned int timer = tp->tx_lpi_timer;
 
 	if (!timer || speed == SPEED_UNKNOWN)
@@ -4968,8 +4967,9 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	struct rtl8169_private *tp = netdev_priv(ndev);
 	struct device *d = tp_to_dev(tp);
 
+	tp->speed = tp->phydev->speed;
 	if (netif_carrier_ok(ndev)) {
-		rtl_link_chg_patch(tp);
+		rtl_link_chg_patch(tp, tp->speed);
 		rtl_enable_tx_lpi(tp, tp->phydev->enable_tx_lpi);
 		pm_request_resume(d);
 	} else {
@@ -5667,6 +5667,7 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 				     ext_xid_str, xid);
 	tp->mac_version = chip->mac_version;
 	tp->fw_name = chip->fw_name;
+	tp->speed = SPEED_UNKNOWN;
 
 	/* Disable ASPM L1 as that cause random device stop working
 	 * problems as well as full system hangs for some PCIe devices users.
-- 
2.43.0

