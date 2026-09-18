Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979903DEFE2;
	Fri, 18 Sep 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741998; cv=none; b=XI1EngxVxNEaXq+75+s88ZAM3Z1nRXcIvozTI1VVn6eHJoujZDQ5mIGg80I2l3lc6UTXti44fZiJPRi4mo/rEJ/+fmjV5braTVvk9GgGZm2z9F28S+stZsxe1ZuAmtmQ2iEVcV89wrvFZVVtcqBxfSDB3fEPrVTZqUMFk1Qy3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741998; c=relaxed/simple;
	bh=nowrGPImW60NJh5SJPfOQT+NuCyRWOuREJ5ST3tON+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1VRNZqlFArd33YHB+el+XkUuh4FadlwMiU+nvE4VJGl2DGCM+wlaAE3dqJ0tTlXdqMmR1Q8oLuhwkENRA7Mg/4FnBr9sVrFYlAN1Nwg7vRxRr88ecTw39em9sPyNMMafEyoeB+/WIRyToEvWdIamfQNOFJGOKKBpXt3VnB7vtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BTrcFSTW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BTrcFSTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789741996; x=1821277996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nowrGPImW60NJh5SJPfOQT+NuCyRWOuREJ5ST3tON+I=;
  b=BTrcFSTWWzXKdIDDhWVfGGwp86+S3pA8cviPQa0llmD+TzicBNMGiPFO
   L1zHCYEQGuav074SJcJjkebpMiVLQ8MCKZKi42lUxjPb3r3AaUVWzj+6Z
   zBuOJOKrRjyiEt1RVWKOlzZvb+irgENivnq6hB71OB04TsbF/tyT8e/BW
   FYeDJmAIh7cZgUZ4UVvCHYeK7lVdoU5mxnJP/cj22Dk4hbPbhc5CrqCht
   mIfoyhKjp6HnE3+QFUdB3/JC7CXLsUokYIT9bBigoO+5t+Mr8K4ZcxbCc
   V6AwbA/rfu/oWdW/6c/zWJ1wWWb52S3ZsNFhxmgzWbp9ZgMRsXGUtNhCc
   w==;
X-CSE-ConnectionGUID: U6LChHbFQWizlUL0pkJVpg==
X-CSE-MsgGUID: oClejNADSTuClErrztdE3g==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="230930419"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2026 07:33:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 18 Sep 2026 07:33:15 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 07:33:10 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 1/4] net: phy: microchip_t1s: fix collision detection on PLCA status change
Date: Fri, 18 Sep 2026 20:02:59 +0530
Message-ID: <20260918143302.76909-2-parthiban.veerasooran@microchip.com>
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

lan86xx_plca_set_cfg() only adjusted collision detection on explicit
ethtool PLCA changes, missing the autonomous online/offline transitions
the PHY performs based on BEACON availability. When PLCA went offline,
collision detection stayed disabled, leaving CSMA/CD running unprotected.

Fix this by monitoring the PLCA Status Changed (PSTC) interrupt.
lan86xx_config_intr() enables/disables PSTCM in IMSK1;
lan86xx_handle_interrupt() reads live PLCA status on each interrupt and
toggles CDEN in COL_DET_CTRL0 accordingly. CDEN is re-synced against
current PLCA status right after unmasking PSTCM, since a transition
during the masked window is otherwise silently dropped by the STS1
read-to-clear.

lan86xx_read_clear_sts1() and lan86xx_set_intr_mask() factor out the
shared STS1/IMSK1 sequences; both are reused by the Rev.D0 handling
added later in this series.

Wired to LAN867X Rev.B1, C1, C2 and LAN865X Rev.B0/B1. Rev.D0 needs
separate handling (follow-on patch). Boards without a routed interrupt
(phydev->irq == PHY_POLL, including LAN865X until later patches) keep
the static CDEN write in lan86xx_plca_set_cfg() as a baseline, with the
known limitation that autonomous transitions between ethtool calls
aren't tracked there.

Fixes: 78341049fbcd ("net: phy: microchip_t1s: configure collision detection based on PLCA mode")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 142 +++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 73c23d311d72..3333e4801aae 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -27,6 +27,14 @@
 #define LAN865X_REG_CFGPARAM_CTRL 0x00DA
 #define LAN865X_REG_STS2 0x0019
 
+/* PHY interrupt status and mask registers (MDIO_MMD_VEND2). The status bits
+ * are read-to-clear; a mask bit is enabled by writing 0.
+ */
+#define LAN86XX_REG_STS1		0x0018
+#define LAN86XX_REG_IMSK1		0x001C
+
+#define LAN86XX_STS1_PLCA_STS_CHANGED	BIT(11)
+
 /* Collision Detector Control 0 Register */
 #define LAN86XX_REG_COL_DET_CTRL0	0x0087
 #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
@@ -458,14 +466,29 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 	if (ret)
 		return ret;
 
-	if (plca_cfg->enabled)
+	/* phylib dispatches handle_interrupt() only for PHYs with a real IRQ
+	 * number (phy_interrupt_is_valid()). For PHY_POLL and PHY_MAC_INTERRUPT
+	 * handle_interrupt() is never called, so apply the static CDEN write
+	 * here as a baseline on every ethtool PLCA reconfiguration. The
+	 * limitation is that autonomous PLCA mode transitions between ethtool
+	 * reconfigurations are not tracked on such boards.
+	 */
+	if (phy_interrupt_is_valid(phydev))
+		return 0;
+
+	if (plca_cfg->enabled > 0)
 		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
 				      LAN86XX_REG_COL_DET_CTRL0,
 				      COL_DET_CTRL0_ENABLE_BIT_MASK,
 				      COL_DET_DISABLE);
 
-	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_COL_DET_CTRL0,
-			      COL_DET_CTRL0_ENABLE_BIT_MASK, COL_DET_ENABLE);
+	if (plca_cfg->enabled == 0)
+		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				      LAN86XX_REG_COL_DET_CTRL0,
+				      COL_DET_CTRL0_ENABLE_BIT_MASK,
+				      COL_DET_ENABLE);
+
+	return 0;
 }
 
 static int lan867x_revd0_config_init(struct phy_device *phydev)
@@ -506,6 +529,111 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
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
+	struct phy_plca_status plca_st;
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
+		ret = genphy_c45_plca_get_status(phydev, &plca_st);
+		if (ret < 0)
+			return ret;
+
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				     LAN86XX_REG_COL_DET_CTRL0,
+				     COL_DET_CTRL0_ENABLE_BIT_MASK,
+				     plca_st.pst ? COL_DET_DISABLE :
+				     COL_DET_ENABLE);
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
+	struct phy_plca_status plca_st;
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
+		ret = genphy_c45_plca_get_status(phydev, &plca_st);
+		if (ret < 0) {
+			phy_error(phydev);
+			return IRQ_NONE;
+		}
+
+		/* AN1760/AN1699: disable collision detection in PLCA mode to
+		 * improve signal quality; re-enable it in CSMA/CD mode.
+		 *
+		 * https://www.microchip.com/en-us/application-notes/an1760
+		 * https://www.microchip.com/en-us/application-notes/an1699
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND2,
+				     LAN86XX_REG_COL_DET_CTRL0,
+				     COL_DET_CTRL0_ENABLE_BIT_MASK,
+				     plca_st.pst ? COL_DET_DISABLE :
+				     COL_DET_ENABLE);
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
@@ -513,6 +641,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revb1_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -523,6 +653,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -533,6 +665,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -556,6 +690,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan865x_revb_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.read_mmd           = genphy_read_mmd_c45,
 		.write_mmd          = genphy_write_mmd_c45,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
-- 
2.43.0

