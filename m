Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB451DAE0;
	Tue, 29 Sep 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686785; cv=none; b=vGsaH+rKRtOaGF98QZsblKAgqZZLo2+3aNcAJZZtsaNIU7S5q048oOP/uNtjEMR7mrHFwrAgeH5XnbZbgSPJGIfbtxVyXvFpMk1AV8mRdS20TIk0cpBQOQZDWCEvFCPO5GcgQXTii3P0MSl+e92BlggLHydYbJD4UmWUElCPsXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686785; c=relaxed/simple;
	bh=y9Mpo6EndMUJcLkH5Pg/OZGcLdNlAIztTGIYCaggfoA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kcrjjuu/ITdf6rkGttX8qVjpSaFzQ4O++XTKCTzMUgFDqDs6QfFEjLwA0E98Bv6G9gKOlfkNoU77HvG8aIo57ikFpnesA3EzMUagRKHbBRJ4dg5OD5Kjgfd2p0XRHU0od1h/5Ed9bozCCW4qIQx7HSagIQNVCCzza+MvrGC2v9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AMg/9RE0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AMg/9RE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790686783; x=1822222783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y9Mpo6EndMUJcLkH5Pg/OZGcLdNlAIztTGIYCaggfoA=;
  b=AMg/9RE0maykNgUk7juTbYC64OL+GV6hVR4f7e1YMa035FAlBgla3huq
   LOa6n77722cW3yPq0/Wks4fT/xdGSiplrXYSk+Lnpah7N96QdrwZx8mMB
   mjEArq1PUJq7pLkqfV564CWDn41s51xO+bCWTPMXhVVPg+2De6z22/pIC
   YMLspXDi2jAVjdKjt1xYgT4wyxRAsR1zoSJpKdnEn8GQdN4BPUrDsRERf
   C/6UEHYFeOIHvtAVQkVaaRz4qmzvKgD5mqOUoBQO3dPO48qbfh6hb2JIE
   edpyI50c45uUO7oBzi9wQj7KAlMgC+8kNYpt3sN2+gYbRDRtGml+CV9Ws
   A==;
X-CSE-ConnectionGUID: 2i+0xySVSpii5iUDpPv8LA==
X-CSE-MsgGUID: kjxAg6FzS7uN0ElUqZdUqw==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="64611205"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2026 05:59:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 29 Sep 2026 05:59:42 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 05:59:38 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 1/4] net: phy: microchip_t1s: fix collision detection on PLCA status change
Date: Tue, 29 Sep 2026 18:29:25 +0530
Message-ID: <20260929125928.611784-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
References: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Collision detection was only updated on explicit ethtool PLCA changes,
missing autonomous PLCA-status transitions driven by BEACON presence.
When PLCA went offline, CDEN stayed disabled, leaving CSMA/CD running
unprotected.

Add lan86xx_config_intr()/lan86xx_handle_interrupt() to track PSTC and
update CDEN in COL_DET_CTRL0 accordingly, resyncing before unmasking to
avoid racing a genuine interrupt. CDEN also depends on PRSCTL1's
autonomous CSMA/CD fallback bit: a missing BEACON only means CSMA/CD is
active if fallback is enabled. read_status() also resynchronizes CDEN,
providing a polling-based fallback when the PHY interrupt is
unavailable. A per-PHY lock serializes COL_DET_CTRL0 access, since
config_intr() isn't guaranteed to run under phydev->lock while
handle_interrupt() is.

Also fix plca_cfg->enabled being treated as boolean instead of tri-state
(-1 = "don't change"), which could disable CDEN on an unrelated ethtool
write.

Wired to LAN867X Rev.C1, C2 and LAN865X Rev.B0/B1. Rev.B1 is
unsupported/undocumented silicon and stays out of scope. Rev.D0 is
handled separately (follow-on patch).

Fixes: 78341049fbcd ("net: phy: microchip_t1s: configure collision detection based on PLCA mode")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 238 ++++++++++++++++++++++++++++++--
 1 file changed, 227 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 73c23d311d72..5ce0304bf095 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -18,8 +18,8 @@
 /* Both Rev.B0 and B1 clause 22 PHYID's are same due to B1 chip limitation */
 #define PHY_ID_LAN865X_REVB 0x0007C1B3
 
+/* PHY interrupt status 2 register */
 #define LAN867X_REG_STS2 0x0019
-
 #define LAN867x_RESET_COMPLETE_STS BIT(11)
 
 #define LAN865X_REG_CFGPARAM_ADDR 0x00D8
@@ -27,6 +27,21 @@
 #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
 #define LAN865X_REG_STS2 0x0019
 
+/* PHY interrupt status 1 register */
+#define LAN86XX_REG_STS1		0x0018
+#define LAN86XX_STS1_PLCA_STS_CHANGED	BIT(11)
+
+/* PHY interrupt mask 1 register */
+#define LAN86XX_REG_IMSK1		0x001C
+
+/* PLCA Reconciliation Sublayer Control 1 Register (PRSCTL1). Bit 10 controls
+ * whether the PHY autonomously falls back to CSMA/CD mode when no BEACON is
+ * observed while PLCA is enabled, versus staying pinned to PLCA mode regardless
+ * of BEACON presence.
+ */
+#define LAN86XX_REG_PRSCTL1               0x0035
+#define PRSCTL1_PLCA_FALLB_TO_CSMACD_EN   BIT(10)
+
 /* Collision Detector Control 0 Register */
 #define LAN86XX_REG_COL_DET_CTRL0	0x0087
 #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
@@ -136,6 +151,30 @@ static const u16 lan867x_revd0_fixup_values[8] = {
 	0x001C, 0x0C0B, 0x8C07, 0x9660,
 };
 
+struct lan86xx_priv {
+	/* Serializes CDEN state synchronization. */
+	struct mutex cden_lock;
+	int plca_enabled;
+};
+
+static int lan86xx_probe(struct phy_device *phydev)
+{
+	struct lan86xx_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = devm_mutex_init(&phydev->mdio.dev, &priv->cden_lock);
+	if (ret)
+		return ret;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
 /* Pulled from AN1760 describing 'indirect read'
  *
  * write_register(0x4, 0x00D8, addr)
@@ -430,6 +469,57 @@ static int lan867x_revd0_link_active_selection(struct phy_device *phydev,
 			     LAN867X_REG_LINK_STATUS_CTRL, value);
 }
 
+static int lan86xx_fallback_to_csmacd(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_PRSCTL1);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & PRSCTL1_PLCA_FALLB_TO_CSMACD_EN);
+}
+
+/* Collision detection must stay disabled while the device is actually operating
+ * in PLCA mode, and enabled while it is actually operating in CSMA/CD.
+ * A missing BEACON (pst == 0) only means the device is running CSMA/CD if
+ * autonomous fallback is enabled (PRSCTL1 bit 10); if fallback is disabled,
+ * the device stays pinned to PLCA mode regardless of BEACON presence,
+ * so collision detection must remain disabled.
+ */
+static int lan86xx_update_cden(struct phy_device *phydev)
+{
+	struct lan86xx_priv *priv = phydev->priv;
+	struct phy_plca_status plca_st;
+	int fallback, ret;
+	u16 cden;
+
+	fallback = lan86xx_fallback_to_csmacd(phydev);
+	if (fallback < 0)
+		return fallback;
+
+	ret = genphy_c45_plca_get_status(phydev, &plca_st);
+	if (ret < 0)
+		return ret;
+
+	/* PLCA disabled                          -> CDEN enabled
+	 * PLCA enabled + BEACON                  -> CDEN disabled
+	 * PLCA enabled + no BEACON + fallback    -> CDEN enabled
+	 * PLCA enabled + no BEACON + no fallback -> CDEN disabled
+	 */
+	if (!priv->plca_enabled)
+		cden = COL_DET_ENABLE;
+	else if (plca_st.pst)
+		cden = COL_DET_DISABLE;
+	else if (fallback)
+		cden = COL_DET_ENABLE;
+	else
+		cden = COL_DET_DISABLE;
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
+			      COL_DET_CTRL0_ENABLE_BIT_MASK, cden);
+}
+
 /* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
  * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
  * normal operation, the device should be operated in PLCA mode. Disabling
@@ -444,10 +534,14 @@ static int lan867x_revd0_link_active_selection(struct phy_device *phydev,
 static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 				const struct phy_plca_cfg *plca_cfg)
 {
+	struct lan86xx_priv *priv = phydev->priv;
 	int ret;
 
-	/* Link status selection must be configured for LAN8670/1/2 Rev.D0 */
-	if (phydev->phy_id == PHY_ID_LAN867X_REVD0) {
+	/* Link status selection must be configured for LAN8670/1/2 Rev.D0.
+	 * Only update link status selection if enabled is explicitly specified
+	 * (not -1, which means "don't change").
+	 */
+	if (phydev->phy_id == PHY_ID_LAN867X_REVD0 && plca_cfg->enabled != -1) {
 		ret = lan867x_revd0_link_active_selection(phydev,
 							  plca_cfg->enabled);
 		if (ret)
@@ -458,14 +552,18 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 	if (ret)
 		return ret;
 
-	if (plca_cfg->enabled)
-		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
-				      LAN86XX_REG_COL_DET_CTRL0,
-				      COL_DET_CTRL0_ENABLE_BIT_MASK,
-				      COL_DET_DISABLE);
+	if (plca_cfg->enabled != -1)
+		priv->plca_enabled = plca_cfg->enabled;
 
-	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
-			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
+	if (plca_cfg->enabled != -1) {
+		mutex_lock(&priv->cden_lock);
+		ret = lan86xx_update_cden(phydev);
+		mutex_unlock(&priv->cden_lock);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int lan867x_revd0_config_init(struct phy_device *phydev)
@@ -493,6 +591,9 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 
 static int lan86xx_read_status(struct phy_device *phydev)
 {
+	struct lan86xx_priv *priv = phydev->priv;
+	int ret;
+
 	/* The phy has some limitations, namely:
 	 *  - always reports link up
 	 *  - only supports 10MBit half duplex
@@ -503,7 +604,112 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	phydev->speed = SPEED_10;
 	phydev->autoneg = AUTONEG_DISABLE;
 
-	return 0;
+	/* LAN867X Rev.B1 is unsupported/undocumented silicon (absent from the
+	 * current AN1699 and datasheet) and is kept out of scope for the CDEN
+	 * tracking below.
+	 */
+	if (phydev->phy_id == PHY_ID_LAN867X_REVB1)
+		return 0;
+
+	/* When no PHY interrupt is available, phylib polls read_status().
+	 * Use the PLCA status from that poll to resync CDEN.
+	 */
+	mutex_lock(&priv->cden_lock);
+	ret = lan86xx_update_cden(phydev);
+	mutex_unlock(&priv->cden_lock);
+	return ret;
+}
+
+/* Read LAN86XX_REG_STS1, which clears the latched status bits on read. */
+static int lan86xx_read_clear_sts1(struct phy_device *phydev)
+{
+	return phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
+}
+
+/* Mask (mask bit = 1) or unmask (mask bit = 0) the given STS1 bits in
+ * IMSK1.
+ */
+static int lan86xx_set_intr_mask(struct phy_device *phydev, u16 mask,
+				 bool enable)
+{
+	if (enable)
+		/* A mask bit of 0 enables the corresponding interrupt. */
+		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
+					  LAN86XX_REG_IMSK1, mask);
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_IMSK1,
+				mask);
+}
+
+static int lan86xx_config_intr(struct phy_device *phydev)
+{
+	struct lan86xx_priv *priv = phydev->priv;
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Read to clear any pending status before enabling. */
+		ret = lan86xx_read_clear_sts1(phydev);
+		if (ret < 0)
+			return ret;
+
+		/* STS1 may have cleared a PSTC event that occurred while the
+		 * interrupt was masked, so synchronize CDEN with the current
+		 * PLCA state before enabling PSTC.
+		 */
+		mutex_lock(&priv->cden_lock);
+		ret = lan86xx_update_cden(phydev);
+		mutex_unlock(&priv->cden_lock);
+		if (ret)
+			return ret;
+
+		return lan86xx_set_intr_mask(phydev,
+					     LAN86XX_STS1_PLCA_STS_CHANGED,
+					     true);
+	}
+
+	ret = lan86xx_set_intr_mask(phydev, LAN86XX_STS1_PLCA_STS_CHANGED,
+				    false);
+	if (ret)
+		return ret;
+
+	/* Read to clear any pending status after disabling. */
+	ret = lan86xx_read_clear_sts1(phydev);
+	return ret < 0 ? ret : 0;
+}
+
+static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
+{
+	struct lan86xx_priv *priv = phydev->priv;
+	irqreturn_t ret_irq = IRQ_NONE;
+	int sts1, ret;
+
+	/* Reading the status register clears the latched event bits. */
+	sts1 = lan86xx_read_clear_sts1(phydev);
+	if (sts1 < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
+		/* AN1760/AN1699: disable collision detection while actually
+		 * operating in PLCA mode; re-enable it only once actually
+		 * operating in CSMA/CD (see lan86xx_update_cden()).
+		 *
+		 * https://www.microchip.com/en-us/application-notes/an1760
+		 * https://www.microchip.com/en-us/application-notes/an1699
+		 */
+		mutex_lock(&priv->cden_lock);
+		ret = lan86xx_update_cden(phydev);
+		mutex_unlock(&priv->cden_lock);
+		if (ret < 0) {
+			phy_error(phydev);
+			return IRQ_NONE;
+		}
+
+		ret_irq = IRQ_HANDLED;
+	}
+
+	return ret_irq;
 }
 
 static struct phy_driver microchip_t1s_driver[] = {
@@ -521,8 +727,11 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC1),
 		.name               = "LAN867X Rev.C1",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.probe              = lan86xx_probe,
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -531,8 +740,11 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVC2),
 		.name               = "LAN867X Rev.C2",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.probe              = lan86xx_probe,
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -541,6 +753,7 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVD0),
 		.name               = "LAN867X Rev.D0",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.probe              = lan86xx_probe,
 		.config_init        = lan867x_revd0_config_init,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
@@ -554,8 +767,11 @@ static struct phy_driver microchip_t1s_driver[] = {
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN865X_REVB),
 		.name               = "LAN865X Rev.B0/B1 Internal Phy",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
+		.probe              = lan86xx_probe,
 		.config_init        = lan865x_revb_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.read_mmd           = genphy_read_mmd_c45,
 		.write_mmd          = genphy_write_mmd_c45,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-- 
2.43.0

