Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00D951B196;
	Tue, 29 Sep 2026 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686800; cv=none; b=DOnC8HFw7YUroIZO2pbzgCxv4TErMhiKs42IZVvYqULAn43q3GtsgTeAOKKKhj0IPFbCpHbElJpHS5ZRyxzQIoW4S6D7OPjb4rjXrB0cQnAZziEH5dT2mY49Yl1RboJ+uW7yNwzokI6n0g/p50T2nc6BcOUVkhV2kaHy4MGHutE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686800; c=relaxed/simple;
	bh=VyB/Wyj+lodonXz0L5qlLnf5ZZJhfB9sBQUbdppHPzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEEEIsokXq3zluLopsVEt1slZQmDpTkUhIYuebmZ2Q08Twq0s39MLyYRMFVavDLR9p3wvhUonSzDK5HeYuMd7pxuIvSUim4NF7oBTHXgQ6y6p7ydNzySICQUwTajXo1eV0pLM8oJcMnVCtOf0cb5T/Sk0DeD/e39SGLoBqjyIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=L3Ycl5Jf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="L3Ycl5Jf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790686798; x=1822222798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VyB/Wyj+lodonXz0L5qlLnf5ZZJhfB9sBQUbdppHPzM=;
  b=L3Ycl5JfQcLdEYKJiet/9KEC9c8y0oZpwv94/6uvjbEWQ4ywj6vD5jFn
   8mYGROHc8dm00MzuCrjFZ+Jmz0t7Pme1qMABR66//tOBe7kqmeRnMVFcd
   pRYhMa4OMAO0Ca19wA45GJGlp7debwusEQ4tQhYafq5FuhP1X3nuWEaZI
   SqdRG08DCYcNagZghlPmr2pfHZTBWXIczGxp17aPX2G0U8wPffMWCyBfU
   ln7sf/HGL/bf0vDLiWsgSdBUR5lHqqTqSFiuIK7IbBsKu8D9ga+gAnxRO
   RRV/oa/HaTIfWbkSFuQ/koSji4pFiu8M71x0pvU9+kZ9gqtkGpHbPTiX1
   w==;
X-CSE-ConnectionGUID: nq8cEQErQBOwISx1DVSuEg==
X-CSE-MsgGUID: ly1eRJxCTKazny4FOOhdwQ==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="64611219"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Sep 2026 05:59:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 29 Sep 2026 05:59:57 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 05:59:53 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 4/4] net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0
Date: Tue, 29 Sep 2026 18:29:28 +0530
Message-ID: <20260929125928.611784-5-parthiban.veerasooran@microchip.com>
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

LAN867X Rev.D0 adds a Collision Counting and MAC Forwarding Control
field (CCMFC, bits 10:9) in COL_DET_CTRL0 (0x0087). Set to the OA
default (0x1), the hardware autonomously gates collision forwarding
based on live PLCA_Status, removing the delay a software-driven CDEN
toggle had on older revisions. The PSTC interrupt handler for Rev.D0
therefore only needs to update the link status selection on each PLCA
transition.

Configure CCMFC to the OA default in lan867x_revd0_config_init(). Add
lan867x_revd0_handle_interrupt() for two events: Link Status Change
triggers the phylib state machine; PLCA Status Change re-evaluates the
link status selection using the cached PLCA enable state and current
CSMA/CD fallback configuration.

Rev.D0 can also be configured (PRSCTL1, 0x0035, bit 10) to autonomously
fall back to CSMA/CD when no BEACON is seen. When that's active, the
PHY's own hardware transition already handles CSMA/CD correctly, so
driving link status from PLCA_Status reports nothing meaningful. Force
the semaphore (forced-active) source whenever fallback is enabled; only
when fallback is disabled - the PHY stays pinned to PLCA mode - does
tracking PLCA_Status serve its purpose.

Wire up .config_intr/.handle_interrupt for Rev.D0 via a dedicated
lan867x_revd0_config_intr(), reusing the STS1/IMSK1 helpers from the
other LAN86XX PHYs.

Preserve cable-test polling when Rev.D0 uses its PHY interrupt path.
Once interrupt handling is enabled, phydev->irq may be valid and the
normal PHY polling path is no longer used, so PHY_POLL_CABLE_TEST
ensures cable-test state continues to be polled while the test is active.

Fixes: 07f5765f26c3 ("net: phy: microchip_t1s: configure link status control for LAN867x Rev.D0")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 127 +++++++++++++++++++++++++++++++-
 1 file changed, 126 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 5ce0304bf095..d667f57aa4a8 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -29,6 +29,7 @@
 
 /* PHY interrupt status 1 register */
 #define LAN86XX_REG_STS1		0x0018
+#define LAN86XX_STS1_LINK_STS_CHANGED	BIT(13)
 #define LAN86XX_STS1_PLCA_STS_CHANGED	BIT(11)
 
 /* PHY interrupt mask 1 register */
@@ -47,6 +48,9 @@
 #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
 #define COL_DET_ENABLE			BIT(15)
 #define COL_DET_DISABLE			0x0000
+#define COL_DET_CTRL0_CCMFC_MASK	GENMASK(10, 9)
+/* OA default: collisions gated by PLCA_Status in hardware */
+#define COL_DET_CTRL0_CCMFC_OA_DEFAULT	BIT(9)
 
 /* LAN8670/1/2 Rev.D0 Link Status Selection Register */
 #define LAN867X_REG_LINK_STATUS_CTRL	0x0012
@@ -520,6 +524,29 @@ static int lan86xx_update_cden(struct phy_device *phydev)
 			      COL_DET_CTRL0_ENABLE_BIT_MASK, cden);
 }
 
+/* When the PHY autonomously falls back to CSMA/CD once BEACONs stop (PRSCTL1
+ * bit 10 set), the hardware fallback already provides correct CSMA/CD
+ * operation; selecting link status from PLCA_STATUS in that case reports
+ * nothing meaningful, since the PHY may already be running CSMA/CD regardless
+ * of the stale PLCA_STATUS value. Force the semaphore (forced-active) source
+ * in that case instead. Only when fallback is disabled - the PHY is pinned
+ * to PLCA mode - does tracking PLCA_STATUS serve its intended purpose.
+ */
+static int lan867x_revd0_update_link_selection(struct phy_device *phydev,
+					       int plca_enabled)
+{
+	int fallback;
+
+	fallback = lan86xx_fallback_to_csmacd(phydev);
+	if (fallback < 0)
+		return fallback;
+
+	if (fallback)
+		return lan867x_revd0_link_active_selection(phydev, false);
+
+	return lan867x_revd0_link_active_selection(phydev, plca_enabled);
+}
+
 /* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
  * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
  * normal operation, the device should be operated in PLCA mode. Disabling
@@ -528,6 +555,11 @@ static int lan86xx_update_cden(struct phy_device *phydev)
  * distortion cause poor signal quality. Collision detection must be re-enabled
  * if the device is configured to operate in CSMA/CD mode.
  *
+ * LAN867X Rev.D0 has autonomous collision detection gating via CCMFC and
+ * does not toggle CDEN in the interrupt handler. CDEN remains permanently
+ * enabled in config_init(), so no software-driven CDEN toggling is needed
+ * here.
+ *
  * AN1760: https://www.microchip.com/en-us/application-notes/an1760
  * AN1699: https://www.microchip.com/en-us/application-notes/an1699
  */
@@ -542,7 +574,7 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 	 * (not -1, which means "don't change").
 	 */
 	if (phydev->phy_id == PHY_ID_LAN867X_REVD0 && plca_cfg->enabled != -1) {
-		ret = lan867x_revd0_link_active_selection(phydev,
+		ret = lan867x_revd0_update_link_selection(phydev,
 							  plca_cfg->enabled);
 		if (ret)
 			return ret;
@@ -555,6 +587,12 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 	if (plca_cfg->enabled != -1)
 		priv->plca_enabled = plca_cfg->enabled;
 
+	/* LAN867X Rev.D0 uses CCMFC for autonomous collision detection
+	 * gating; CDEN remains enabled and does not require software toggling.
+	 */
+	if (phydev->phy_id == PHY_ID_LAN867X_REVD0)
+		return 0;
+
 	if (plca_cfg->enabled != -1) {
 		mutex_lock(&priv->cden_lock);
 		ret = lan86xx_update_cden(phydev);
@@ -582,6 +620,20 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* AN1699: Configure CCMFC (Collision Counting and MAC Forwarding
+	 * Control) to OA default (0x1) so that the hardware autonomously gates
+	 * collision forwarding to the MAC based on the live PLCA_Status:
+	 * collisions are neither counted nor forwarded when PLCA_Status is OK,
+	 * and are counted/forwarded when not OK. This eliminates the need for
+	 * software-driven CDEN toggling. CDEN defaults to enabled on Rev.D0
+	 * and remains enabled.
+	 */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
+			     COL_DET_CTRL0_CCMFC_MASK,
+			     COL_DET_CTRL0_CCMFC_OA_DEFAULT);
+	if (ret)
+		return ret;
+
 	/* Initially the PHY will be in CSMA/CD mode by default. So it is
 	 * required to set the link always active as it doesn't support
 	 * autoneg.
@@ -712,6 +764,76 @@ static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
 	return ret_irq;
 }
 
+static int lan867x_revd0_config_intr(struct phy_device *phydev)
+{
+	u16 mask = LAN86XX_STS1_PLCA_STS_CHANGED |
+		   LAN86XX_STS1_LINK_STS_CHANGED;
+	struct lan86xx_priv *priv = phydev->priv;
+	int sts1, ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Read to clear any pending status before enabling. */
+		sts1 = lan86xx_read_clear_sts1(phydev);
+		if (sts1 < 0)
+			return sts1;
+
+		/* STS1 may have cleared a pending PSTC while masked, and a
+		 * missed PSTC leaves no trace to key off, so unconditionally
+		 * resync the link-status-selection source from the current
+		 * PLCA enable state and fallback configuration.
+		 */
+		ret = lan867x_revd0_update_link_selection(phydev,
+							  priv->plca_enabled);
+		if (ret < 0)
+			return ret;
+
+		return lan86xx_set_intr_mask(phydev, mask, true);
+	}
+
+	ret = lan86xx_set_intr_mask(phydev, mask, false);
+	if (ret)
+		return ret;
+
+	/* Read to clear any pending status after disabling. */
+	ret = lan86xx_read_clear_sts1(phydev);
+	return ret < 0 ? ret : 0;
+}
+
+static irqreturn_t lan867x_revd0_handle_interrupt(struct phy_device *phydev)
+{
+	struct lan86xx_priv *priv = phydev->priv;
+	irqreturn_t ret_irq = IRQ_NONE;
+	int sts1, ret;
+
+	sts1 = lan86xx_read_clear_sts1(phydev);
+	if (sts1 < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (sts1 & LAN86XX_STS1_LINK_STS_CHANGED) {
+		phy_trigger_machine(phydev);
+		ret_irq = IRQ_HANDLED;
+	}
+
+	if (sts1 & LAN86XX_STS1_PLCA_STS_CHANGED) {
+		/* Re-evaluate the link-status selection when PLCA status
+		 * changes. A resulting link-status change raises
+		 * LINK_STS_CHANGED, which triggers the PHY state machine.
+		 */
+		ret = lan867x_revd0_update_link_selection(phydev,
+							  priv->plca_enabled);
+		if (ret < 0) {
+			phy_error(phydev);
+			return IRQ_NONE;
+		}
+
+		ret_irq = IRQ_HANDLED;
+	}
+
+	return ret_irq;
+}
+
 static struct phy_driver microchip_t1s_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(PHY_ID_LAN867X_REVB1),
@@ -754,7 +876,10 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.name               = "LAN867X Rev.D0",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.probe              = lan86xx_probe,
+		.flags              = PHY_POLL_CABLE_TEST,
 		.config_init        = lan867x_revd0_config_init,
+		.config_intr        = lan867x_revd0_config_intr,
+		.handle_interrupt   = lan867x_revd0_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
-- 
2.43.0

