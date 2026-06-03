Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE3405859;
	Wed,  3 Jun 2026 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780469985; cv=none; b=gqD5USeWkkLD9zGTeNtBXDP16hCOGWtvXAZ4bb+I4cwxXD3Kwls4aeaJTWqkWqDr+QRMb85HxYrrre4SUSmfnrKsacIMKlvzj1nQ3qJtVbZ5OkYT773zIK5n4jBPZDuWfyx5i0eWCAQqztSHxSpcIrjSS+QBH59u7/sqBAc6Tqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780469985; c=relaxed/simple;
	bh=pPNUiYrjMIEBwZstBviOnw4phku5qQl0xxmvyGH0UPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsK0cb4yuM7j8wEZWtuhYFQ6Gz/MqmBN1lg91mSpVMM7yhY1U4FTexoctQ+AgBMdw+GLFhoHRSoQkTohu3REUc4f8zRgyBR8+K75Bzod8ANIss0NnKwzNEa0UnGPQ3WGwNQPoeAqYKJRfq1iyrcwcb63VIxOYKgmrpbayOgQapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=qQT3wKbt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="qQT3wKbt"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6536xJ0313643786, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780469959;
	bh=t0GvNxBMhKyRWxDJ2RCTEFxWje9u4/Uta+PytWPsayg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qQT3wKbtCimH9lF/Aj96LOMrGFjdeocG7QjQf4of5JIdEqUGsE1HR1EgJqDJ0iN1Y
	 WSVs0+7tzRoHfyukiBLtWzbr6M0bHDS+pFBiHQoVynR6vNWVcTb/+O6XNUNOiQMxXF
	 PSVIVY1hIqVIgcMchkLzw61DZ7LoUReJbOqhCWID3bQEWsQpJcZjPZRNUlU0/JbyuB
	 PQO3uq6yExBMXI/CEiicv7Gq23FzZb9iykLlw3/Q6mpfQBnMYdHw8H3zIS+uAruOoN
	 zx6Ft5HPQ2PRssQOaCnXB/3ZQ7+5xMbiIMmXQUkIy0jIxTZ2bt1NHSCMNYQeCoI9EW
	 QUqjRZyi2xUSg==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6536xJ0313643786
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Jun 2026 14:59:19 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 14:59:19 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 14:59:19 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Javen Xu
	<javen_xu@realsil.com.cn>
Subject: [PATCH net-next v1 2/5] r8169: move funcitons forward
Date: Wed, 3 Jun 2026 14:59:13 +0800
Message-ID: <20260603065916.334-3-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20260603065916.334-1-javen_xu@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Javen Xu <javen_xu@realsil.com.cn>

Move some functions forward to avoid adding a forward declaration.

Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
---
 drivers/net/ethernet/realtek/r8169_main.c | 84 +++++++++++------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..1e2e4074d343 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -1113,6 +1113,23 @@ DECLARE_RTL_COND(rtl_ocp_gphy_cond)
 	return RTL_R32(tp, GPHY_OCP) & OCPAR_FLAG;
 }
 
+/* Work around a hw issue with RTL8168g PHY, the quirk disables
+ * PHY MCU interrupts before PHY power-down.
+ */
+static void rtl8168g_phy_suspend_quirk(struct rtl8169_private *tp, int value)
+{
+	switch (tp->mac_version) {
+	case RTL_GIGA_MAC_VER_40:
+		if (value & BMCR_RESET || !(value & BMCR_PDOWN))
+			rtl_eri_set_bits(tp, 0x1a8, 0xfc000000);
+		else
+			rtl_eri_clear_bits(tp, 0x1a8, 0xfc000000);
+		break;
+	default:
+		break;
+	}
+};
+
 static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 {
 	if (rtl_ocp_reg_failure(reg))
@@ -1123,19 +1140,20 @@ static void r8168_phy_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
 	rtl_loop_wait_low(tp, &rtl_ocp_gphy_cond, 25, 10);
 }
 
-static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
+static void r8168g_mdio_write(struct rtl8169_private *tp, int reg, int value)
 {
-	if (rtl_ocp_reg_failure(reg))
-		return 0;
+	if (reg == 0x1f) {
+		tp->ocp_base = value ? value << 4 : OCP_STD_PHY_BASE;
+		return;
+	}
 
-	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
-	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
-		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
+	if (tp->ocp_base != OCP_STD_PHY_BASE)
+		reg -= 0x10;
 
-	RTL_W32(tp, GPHY_OCP, reg << 15);
+	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMCR)
+		rtl8168g_phy_suspend_quirk(tp, value);
 
-	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
-		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
+	r8168_phy_ocp_write(tp, tp->ocp_base + reg * 2, value);
 }
 
 static void __r8168_mac_ocp_write(struct rtl8169_private *tp, u32 reg, u32 data)
@@ -1177,6 +1195,21 @@ static u16 r8168_mac_ocp_read(struct rtl8169_private *tp, u32 reg)
 	return val;
 }
 
+static int r8168_phy_ocp_read(struct rtl8169_private *tp, u32 reg)
+{
+	if (rtl_ocp_reg_failure(reg))
+		return 0;
+
+	/* Return dummy MII_PHYSID2 in SFP mode to match SFP PHY driver */
+	if (tp->sfp_mode && reg == (OCP_STD_PHY_BASE + 2 * MII_PHYSID2))
+		return PHY_ID_RTL_DUMMY_SFP & 0xffff;
+
+	RTL_W32(tp, GPHY_OCP, reg << 15);
+
+	return rtl_loop_wait_high(tp, &rtl_ocp_gphy_cond, 25, 10) ?
+		(RTL_R32(tp, GPHY_OCP) & 0xffff) : -ETIMEDOUT;
+}
+
 static void r8168_mac_ocp_modify(struct rtl8169_private *tp, u32 reg, u16 mask,
 				 u16 set)
 {
@@ -1229,39 +1262,6 @@ static void rtl_sfp_reset(struct rtl8169_private *tp)
 		r8127_sfp_sds_phy_reset(tp);
 }
 
-/* Work around a hw issue with RTL8168g PHY, the quirk disables
- * PHY MCU interrupts before PHY power-down.
- */
-static void rtl8168g_phy_suspend_quirk(struct rtl8169_private *tp, int value)
-{
-	switch (tp->mac_version) {
-	case RTL_GIGA_MAC_VER_40:
-		if (value & BMCR_RESET || !(value & BMCR_PDOWN))
-			rtl_eri_set_bits(tp, 0x1a8, 0xfc000000);
-		else
-			rtl_eri_clear_bits(tp, 0x1a8, 0xfc000000);
-		break;
-	default:
-		break;
-	}
-};
-
-static void r8168g_mdio_write(struct rtl8169_private *tp, int reg, int value)
-{
-	if (reg == 0x1f) {
-		tp->ocp_base = value ? value << 4 : OCP_STD_PHY_BASE;
-		return;
-	}
-
-	if (tp->ocp_base != OCP_STD_PHY_BASE)
-		reg -= 0x10;
-
-	if (tp->ocp_base == OCP_STD_PHY_BASE && reg == MII_BMCR)
-		rtl8168g_phy_suspend_quirk(tp, value);
-
-	r8168_phy_ocp_write(tp, tp->ocp_base + reg * 2, value);
-}
-
 static int r8168g_mdio_read(struct rtl8169_private *tp, int reg)
 {
 	if (reg == 0x1f)
-- 
2.43.0

