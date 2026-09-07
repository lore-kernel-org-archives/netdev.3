Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85BD3612E0;
	Mon,  7 Sep 2026 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758435; cv=none; b=eGbXLnA/HwXOVQcX6XMN70Td5eD63nRTuc0tOk6zYfqZVVF7PWNqkKwzTrgbFiUc58XIgbCeoJcnjLkXB5V76OveprhglWRH/Acv1PMhD12HWXNksNznjoH/WmmkRVs/tXITqXNteKHWpI9qY81F9oQTZWEIF1X+OdJPK8UuxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758435; c=relaxed/simple;
	bh=VwLGan1+3YGhVfuzesPn4v2bxGRsWy+Aj5ZjsYag92s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPl3pLddBw3N5vplU9558V2MyEs+IUlOQXGFlwCDvd8tXeQw94zDI1sYkiKGsAvsR+YbEFo04RV8oDP9wTlj3A7I/B83mN0z4Qs2OeYXmCE+GQqFFTX03qXIZt4tGpgJjs53VUBPRCaxz2rVeY4tHPAWiZouMuFfnS6EN8hHjPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=COdk1lFf; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="COdk1lFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788758437; x=1820294437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VwLGan1+3YGhVfuzesPn4v2bxGRsWy+Aj5ZjsYag92s=;
  b=COdk1lFfDWJ1MgncBy2ABF19wQc/41vv1zZpBnR52b/7thgvBL4dDmO3
   Zmf1LGL22a8U9S/xDntrjDNTurJU7d6ppMawRRocYi3GZfh496hGHrZiQ
   Ow9inXJzDvT/PgJHW9MxyL5G/MHtUSi/Xm7AJZvm0CTiI7LQ9kKUUAl2j
   HUqQ+88j60NS8Kq9hJf8NoiVangaB1uxTN2wWy+TJZnMF/kkS0KMLGPoT
   g0Aml8G3LdRLgjVbxOCFF8abUT+yVwepZarwbncd1NUd5b6XOBIjOSjzb
   BrHAdgdOrMhxBoo1gDH64AhRi6giH5ACuXORd3sb+7vP99wVF35GN6832
   Q==;
X-CSE-ConnectionGUID: Ob4BUn1rS3yTrrsWSXfa+g==
X-CSE-MsgGUID: BLVKhjU+RdGj5GCAMeYC9w==
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="62323103"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2026 22:20:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 6 Sep 2026 22:20:32 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 6 Sep 2026 22:20:28 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 4/4] net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0
Date: Mon, 7 Sep 2026 10:50:06 +0530
Message-ID: <20260907052007.391972-5-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
References: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

LAN867X Rev.D0 introduces a Collision Counting and MAC Forwarding Control
field (CCMFC, bits 10:9) in the Collision Detector Control 0 register
(CDCTL0, 0x0087). When configured to the OA default value (0x1), the
hardware automatically gates collision forwarding to the MAC based on the
live PLCA_Status: collisions are neither counted nor forwarded when
PLCA_Status is OK, and are counted and forwarded when PLCA_Status is not
OK.

This eliminates the inherent delay between a PLCA status change and the
software interrupt handler toggling CDEN, which was a limitation on older
revisions that had no hardware alternative. Since CCMFC handles collision
gating autonomously, the PSTC interrupt handler for Rev.D0 only needs to
update the link status selection on each PLCA status transition.

Configure CCMFC to the OA default in lan867x_revd0_config_init(). Add
lan867x_revd0_handle_interrupt() to handle two separate events:

1. Link Status Change (LNKSTSC): Triggers the phylib state machine via
   phy_trigger_machine() to re-evaluate link status and perform necessary
   state transitions.

2. PLCA Status Change (PSTC): Reads the current PLCA operational status
   via genphy_c45_plca_get_status() and calls
   lan867x_revd0_link_active_selection() to update the link status
   selection accordingly.

Unmask both link status change and PLCA status change interrupt masks for
Rev.D0 in lan86xx_config_intr(). Wire up .config_intr and .handle_interrupt
for Rev.D0 using the shared lan86xx_config_intr() and the new handler.

Fixes: e7e756779afa ("net: phy: microchip_t1s: add support for Microchip LAN867X Rev.D0 PHY")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 68 +++++++++++++++++++++++++++++++--
 1 file changed, 65 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index afb7e52594e7..c3a738c7425b 100644
--- a/drivers/net/phy/microchip_t1s.c
+++ b/drivers/net/phy/microchip_t1s.c
@@ -33,6 +33,7 @@
 #define LAN86XX_REG_STS1		0x0018
 #define LAN86XX_REG_IMSK1		0x001C
 
+#define LAN86XX_STS1_LINK_STS_CHANGED	BIT(13)
 #define LAN86XX_STS1_PLCA_STS_CHANGED	BIT(11)
 
 /* Collision Detector Control 0 Register */
@@ -40,6 +41,9 @@
 #define COL_DET_CTRL0_ENABLE_BIT_MASK	BIT(15)
 #define COL_DET_ENABLE			BIT(15)
 #define COL_DET_DISABLE			0x0000
+#define COL_DET_CTRL0_CCMFC_MASK	GENMASK(10, 9)
+/* OA default: collisions gated by PLCA_Status in hardware */
+#define COL_DET_CTRL0_CCMFC_OA_DEFAULT	BIT(9)
 
 /* LAN8670/1/2 Rev.D0 Link Status Selection Register */
 #define LAN867X_REG_LINK_STATUS_CTRL	0x0012
@@ -502,6 +506,18 @@ static int lan867x_revd0_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* AN1760: configure CCMFC to OA default so that the hardware
+	 * automatically gates collision forwarding to the MAC based on
+	 * PLCA_Status. Collisions are neither counted nor forwarded when
+	 * PLCA_Status = OK, eliminating the need for software-driven CDEN
+	 * toggling in the interrupt handler. CDEN remains enabled.
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
@@ -526,8 +542,12 @@ static int lan86xx_read_status(struct phy_device *phydev)
 
 static int lan86xx_config_intr(struct phy_device *phydev)
 {
+	u16 mask = LAN86XX_STS1_PLCA_STS_CHANGED;
 	int ret;
 
+	if (phydev->phy_id == PHY_ID_LAN867X_REVD0)
+		mask |= LAN86XX_STS1_LINK_STS_CHANGED;
+
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		/* Read to clear any pending status before enabling. */
 		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
@@ -536,12 +556,11 @@ static int lan86xx_config_intr(struct phy_device *phydev)
 
 		/* A mask bit of 0 enables the corresponding interrupt. */
 		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
-					  LAN86XX_REG_IMSK1,
-					  LAN86XX_STS1_PLCA_STS_CHANGED);
+					  LAN86XX_REG_IMSK1, mask);
 	}
 
 	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_IMSK1,
-			       LAN86XX_STS1_PLCA_STS_CHANGED);
+			       mask);
 	if (ret)
 		return ret;
 
@@ -595,6 +614,47 @@ static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
 	return ret_irq;
 }
 
+static irqreturn_t lan867x_revd0_handle_interrupt(struct phy_device *phydev)
+{
+	struct phy_plca_status plca_st;
+	irqreturn_t ret_irq = IRQ_NONE;
+	int sts1, ret;
+
+	/* Reading the status register clears the latched event bits. */
+	sts1 = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
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
+		ret = genphy_c45_plca_get_status(phydev, &plca_st);
+		if (ret < 0) {
+			phy_error(phydev);
+			return IRQ_NONE;
+		}
+
+		/* Collision detection is handled autonomously by the hardware
+		 * via CCMFC. Only the link status selection needs to be updated
+		 * on each PLCA status transition.
+		 */
+		ret = lan867x_revd0_link_active_selection(phydev, plca_st.pst);
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
@@ -637,6 +697,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.name               = "LAN867X Rev.D0",
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revd0_config_init,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan867x_revd0_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
-- 
2.43.0

