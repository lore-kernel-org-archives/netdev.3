Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1923BF67A;
	Fri, 18 Sep 2026 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742012; cv=none; b=oC6RbGoBhQQGpOhzmk2D9RCcoxzrGXKgYHCZ5Ire5Y7RaQ6H6oF+TzYsHJF92/Q+Kgm7jtfLwww0R6aPABhtOqF1GzLkU29GkMObnbpVMCR3yilu7ksB/ePpgznUXpHMsHAO1m/pAfkCUnfkAoadzXpcNB7/QxIHkQXAQ3amGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742012; c=relaxed/simple;
	bh=CEtPt1OIVJcWvrM0vYC4+5MnARffVyTm+wgu61bIFE4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuiX5YgylO6rHJac7zdXA1QM+h1d6ydcmTuw4WrmafS8EeIaNrc4w0ffUEcVx0LxtpQCpuaFRegHcHE5SRnrTHnwiII9frd1MWtlo+FF2iZB5CLveTrEkonQF1t44qwlDh9N/R7l9GkaJYRmdqz/tIMudX8w0hUAXVjwtUEUx3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=b6lbPAYz; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="b6lbPAYz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789742010; x=1821278010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CEtPt1OIVJcWvrM0vYC4+5MnARffVyTm+wgu61bIFE4=;
  b=b6lbPAYzKvOz5cNCYeivfLiw3vy7na6BWQkdLnUkhTqefoddZORftqgb
   4sRrKo5ttpeQhJgrECThCU3ELRIdrz63/U5IhmqrhR+FnPbzJjx3/DiEw
   YxxzUBx2/FvkSt1Cb3fuSYIpwTU/cC4/61A/SII6758q0OPK8/b3yz4tg
   aVCTNgco1KZUzhKbaYbbjdHzrFyGB15OfvHhhbuF+3tm97FSH2J3NfMOW
   yzbnW5uRndESNzAC0JVgmUR3snAPlOPA9xRWA0YW1hFgkI+bwGvJ3zueC
   ivMM2ysEpHteElBcUo4s8OMYyNREASJhZmIKTlWhyD+fQCVsb0gteboj8
   w==;
X-CSE-ConnectionGUID: 1HRGPZFjQ6mjKILVpT+Pbw==
X-CSE-MsgGUID: EhJJPUtZRmC8+L+b5RRXRw==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="62883842"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 07:33:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 07:33:28 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 07:33:24 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 4/4] net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0
Date: Fri, 18 Sep 2026 20:03:02 +0530
Message-ID: <20260918143302.76909-5-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
References: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
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
triggers the phylib state machine; PLCA Status Change re-reads the PLCA
config and updates the link status selection.

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

Fixes: e7e756779afa ("net: phy: microchip_t1s: add support for Microchip LAN867X Rev.D0 PHY")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 169 +++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 3333e4801aae..a69ad6ce1d8a 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -20,7 +20,8 @@
 
 #define LAN867X_REG_STS2 0x0019
 
-#define LAN867x_RESET_COMPLETE_STS BIT(11)
+#define LAN86XX_STS1_LINK_STS_CHANGED	BIT(13)
+#define LAN867x_RESET_COMPLETE_STS	BIT(11)
 
 #define LAN865X_REG_CFGPARAM_ADDR 0x00D8
 #define LAN865X_REG_CFGPARAM_DATA 0x00D9
@@ -40,6 +41,17 @@
 #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
 #define COL_DET_ENABLE			BIT(15)
 #define COL_DET_DISABLE			0x0000
+#define COL_DET_CTRL0_CCMFC_MASK	GENMASK(10, 9)
+/* OA default: collisions gated by PLCA_Status in hardware */
+#define COL_DET_CTRL0_CCMFC_OA_DEFAULT	BIT(9)
+
+/* PLCA Reconciliation Sublayer Control 1 Register (PRSCTL1). Bit 10
+ * controls whether the PHY autonomously falls back to CSMA/CD mode when
+ * no BEACON is observed while PLCA is enabled, versus staying pinned to
+ * PLCA mode regardless of BEACON presence.
+ */
+#define LAN867X_REG_PRSCTL1               0x0035
+#define PRSCTL1_PLCA_FALLB_TO_CSMACD_EN   BIT(10)
 
 /* LAN8670/1/2 Rev.D0 Link Status Selection Register */
 #define LAN867X_REG_LINK_STATUS_CTRL	0x0012
@@ -438,6 +450,40 @@ static int lan867x_revd0_link_active_selection(struct phy_device *phydev,
 			     LAN867X_REG_LINK_STATUS_CTRL, value);
 }
 
+static int lan867x_revd0_fallback_to_csmacd(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN867X_REG_PRSCTL1);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & PRSCTL1_PLCA_FALLB_TO_CSMACD_EN);
+}
+
+/* When the PHY autonomously falls back to CSMA/CD once BEACONs stop (PRSCTL1
+ * bit 10 set), the hardware fallback already provides correct CSMA/CD
+ * operation; selecting link status from PLCA_STATUS in that case reports
+ * nothing meaningful, since the PHY may already be running CSMA/CD regardless
+ * of the stale PLCA_STATUS value. Force the semaphore (forced-active) source
+ * in that case instead. Only when fallback is disabled - the PHY is pinned
+ * to PLCA mode - does tracking PLCA_STATUS serve its intended purpose.
+ */
+static int lan867x_revd0_update_link_selection(struct phy_device *phydev,
+					       bool plca_operational)
+{
+	int fallback;
+
+	fallback = lan867x_revd0_fallback_to_csmacd(phydev);
+	if (fallback < 0)
+		return fallback;
+
+	if (fallback)
+		return lan867x_revd0_link_active_selection(phydev, false);
+
+	return lan867x_revd0_link_active_selection(phydev, plca_operational);
+}
+
 /* As per LAN8650/1 Rev.B0/B1 AN1760 (Revision F (DS60001760G - June 2024)) and
  * LAN8670/1/2 Rev.C1/C2 AN1699 (Revision E (DS60001699F - June 2024)), under
  * normal operation, the device should be operated in PLCA mode. Disabling
@@ -446,6 +492,11 @@ static int lan867x_revd0_link_active_selection(struct phy_device *phydev,
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
@@ -454,9 +505,12 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 {
 	int ret;
 
-	/* Link status selection must be configured for LAN8670/1/2 Rev.D0 */
-	if (phydev->phy_id == PHY_ID_LAN867X_REVD0) {
-		ret = lan867x_revd0_link_active_selection(phydev,
+	/* Link status selection must be configured for LAN8670/1/2 Rev.D0.
+	 * Only update link status selection if enabled is explicitly specified
+	 * (not -1, which means "don't change").
+	 */
+	if (phydev->phy_id == PHY_ID_LAN867X_REVD0 && plca_cfg->enabled != -1) {
+		ret = lan867x_revd0_update_link_selection(phydev,
 							  plca_cfg->enabled);
 		if (ret)
 			return ret;
@@ -472,8 +526,12 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 	 * here as a baseline on every ethtool PLCA reconfiguration. The
 	 * limitation is that autonomous PLCA mode transitions between ethtool
 	 * reconfigurations are not tracked on such boards.
+	 *
+	 * LAN867X Rev.D0 has autonomous collision detection via CCMFC, so skip
+	 * the software CDEN toggling for that revision.
 	 */
-	if (phy_interrupt_is_valid(phydev))
+	if (phy_interrupt_is_valid(phydev) ||
+	    phydev->phy_id == PHY_ID_LAN867X_REVD0)
 		return 0;
 
 	if (plca_cfg->enabled > 0)
@@ -507,6 +565,20 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* AN1699: Configure CCMFC (Collision Counting and MAC Forwarding
+	 * Control) to OA default (0x1) so that the hardware autonomously gates
+	 * collision forwarding to the MAC based on the live PLCA_Status:
+	 * collisions are neither counted nor forwarded when PLCA_Status is OK,
+	 * and are counted/forwarded when not OK. This eliminates the need for
+	 * software-driven CDEN toggling. CDEN is enabled by default and remains
+	 * permanently enabled for Rev.D0.
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
@@ -634,6 +706,91 @@ static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
 	return ret_irq;
 }
 
+static int lan867x_revd0_config_intr(struct phy_device *phydev)
+{
+	u16 mask = LAN86XX_STS1_PLCA_STS_CHANGED |
+		   LAN86XX_STS1_LINK_STS_CHANGED;
+	struct phy_plca_cfg plca_cfg;
+	int sts1, ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Read to clear any pending status before enabling. */
+		sts1 = lan86xx_read_clear_sts1(phydev);
+		if (sts1 < 0)
+			return sts1;
+
+		if (sts1 & LAN86XX_STS1_LINK_STS_CHANGED)
+			phy_trigger_machine(phydev);
+
+		/* STS1 may have cleared a pending PSTC while masked, and a
+		 * missed PSTC leaves no trace to key off, so unconditionally
+		 * resync the link-status-selection source from the current
+		 * PLCA enable state and fallback configuration. CDEN is
+		 * never touched here - see lan867x_revd0_config_init().
+		 */
+		ret = genphy_c45_plca_get_cfg(phydev, &plca_cfg);
+		if (ret < 0)
+			return ret;
+
+		ret = lan867x_revd0_update_link_selection(phydev,
+							  plca_cfg.enabled);
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
+	irqreturn_t ret_irq = IRQ_NONE;
+	struct phy_plca_cfg plca_cfg;
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
+		ret = genphy_c45_plca_get_cfg(phydev, &plca_cfg);
+		if (ret < 0) {
+			phy_error(phydev);
+			return IRQ_NONE;
+		}
+
+		/* lan867x_revd0_update_link_selection() drives the selection
+		 * source from the configured PLCA enable state, forcing
+		 * semaphore mode instead whenever autonomous fallback to
+		 * CSMA/CD is configured (see PRSCTL1 above).
+		 */
+		ret = lan867x_revd0_update_link_selection(phydev,
+							  plca_cfg.enabled);
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
@@ -676,6 +833,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.name               = "LAN867X Rev.D0",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revd0_config_init,
+		.config_intr        = lan867x_revd0_config_intr,
+		.handle_interrupt   = lan867x_revd0_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
-- 
2.43.0

