Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B639CCFB;
	Tue,  1 Sep 2026 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268204; cv=none; b=esMT9rIAKp3T4iNSVPyR4cHm14wHqlggWQwbwWJmVCZv/ft4HYo2Thy+SYAch9p+ku9FZyWXhbCYKa3GdAKBbnY6UyCg6tjE57mkxXB0Tromr3dNkGC95FoILT4NmWYschUQEZ6hAD6kvtzGHAxluyhupaDx5ZWbolhSY6T4ArU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268204; c=relaxed/simple;
	bh=Os9AuvzRzG0f+Y2I0XOn+G0fvp35+7MOlXwgaM4MGgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rt8FYPzqVWrI08QoQnp4IkUOOyESba04C1+02fn726oUm1DhGQrfEAmLQAKnWSrLe0aTsiu9YVqR8RNZpinUK9rX87F8AhKe/EbCOz11IcPLd22dmsGdbHExQT8mm5dxdFz6FpvmIyED2h1+ujeWfVX3gfOUX5QFNcD8ufnrVzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OCh+IWUJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OCh+IWUJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788268203; x=1819804203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Os9AuvzRzG0f+Y2I0XOn+G0fvp35+7MOlXwgaM4MGgM=;
  b=OCh+IWUJFceIRz1aMHb91XaxNlXZXGXwtZAmY9/LHRTiG4mdeYMXy/pl
   G2W4FT7b+M8D+sfgbyqnfJNX0AbZl3VKK2YG6CQ8YGs+VPgXoUACngBRx
   IC0RXmkZ3hYcO3XOuLLZ4R71knCA8gJqiPNpJSaRBuzuAbr5YITovzi19
   LwBm3lAjx59ybSWuyj8+qXn0ocEkV+0DruATV/BzkyeQQOrnSsVh/Pc8Q
   uGn3Shhj8RosCWBDyFQjfHw1hj9d0nGu2n7Ojuk12JCzHo9VcseTOGGTB
   FoWI+fAM1RrVWsp9wyph5w9q0fvWGbmZr8Tl2pxvn4znZoSiwbsle+x2p
   g==;
X-CSE-ConnectionGUID: HkgnOFsiS46D6BBWKJNlFg==
X-CSE-MsgGUID: LAQgWUQIQfi4wgG5GGIeNw==
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="63297039"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2026 06:10:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 1 Sep 2026 06:10:01 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 1 Sep 2026 06:09:57 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 1/3] net: phy: microchip_t1s: fix collision detection on PLCA status change
Date: Tue, 1 Sep 2026 18:39:46 +0530
Message-ID: <20260901130948.212914-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
References: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

The existing lan86xx_plca_set_cfg() adjusted collision detection
statically at the point the user configured PLCA via ethtool: disabled
when PLCA was enabled, re-enabled when PLCA was disabled. This only
handled the explicit user-driven mode change and missed the dynamic
transitions that the PHY performs autonomously.

In a 10BASE-T1S multidrop network, the PHY tracks BEACON availability
and continuously transitions between PLCA online (actively receiving
BEACONs from the coordinator) and PLCA offline (no BEACON present).
When PLCA goes offline after having been configured online, collision
detection remained disabled, causing the bus to operate in CSMA/CD mode
without collision detection — a silent and hard-to-diagnose error.

Fix this by monitoring the PLCA Status Changed (PSTC) interrupt. PSTC
fires on every PST bit transition in the PLCA Status register. Add
lan86xx_config_intr() to enable/disable the PSTCM mask bit in IMSK1
(bit 11, active-low enable) and lan86xx_handle_interrupt() to service
it. On each interrupt, PLCA operational status is retrieved via
genphy_c45_plca_get_status(). When PLCA comes online, collision
detection is disabled via COL_DET_CTRL0 (bit 15). When PLCA goes
offline, collision detection is re-enabled to restore correct CSMA/CD
operation.

Wire these handlers to all supported PHY variants: LAN867X Rev.B1, C1,
C2 and LAN865X Rev.B0/B1.

LAN867X PHYs may run with phydev->irq == PHY_POLL on boards where the
PHY interrupt is not routed to the host. The existing static CDEN write
in lan86xx_plca_set_cfg() is retained as a baseline so that collision
detection is correct even when the interrupt handler never runs. The
limitation is that autonomous PLCA mode transitions between ethtool
reconfigurations are not tracked on such boards. LAN865X is excluded
from the static write because its interrupt is always routed via the
MAC-PHY SPI driver and the interrupt handler always runs.

Fixes: 78341049fbcd ("net: phy: microchip_t1s: configure collision detection based on PLCA mode")
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/phy/microchip_t1s.c | 97 +++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/net/phy/microchip_t1s.c b/drivers/net/phy/microchip_t1s.c
index 73c23d311d72..afb7e52594e7 100644
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
@@ -458,6 +466,16 @@ static int lan86xx_plca_set_cfg(struct phy_device *phydev,
 	if (ret)
 		return ret;
 
+	/* PHYs with routed interrupts handle CDEN dynamically via the interrupt
+	 * handler, so skip the static write. PHYs running with PHY_POLL have no
+	 * interrupt handler, so apply the static CDEN write as a baseline on
+	 * every ethtool PLCA reconfiguration. The limitation is that autonomous
+	 * PLCA mode transitions between ethtool reconfigurations are not
+	 * tracked on such boards.
+	 */
+	if (phydev->irq != PHY_POLL)
+		return 0;
+
 	if (plca_cfg->enabled)
 		return phy_modify_mmd(phydev, MDIO_MMD_VEND2,
 				      LAN86XX_REG_COL_DET_CTRL0,
@@ -506,6 +524,77 @@ static int lan86xx_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int lan86xx_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Read to clear any pending status before enabling. */
+		ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
+		if (ret < 0)
+			return ret;
+
+		/* A mask bit of 0 enables the corresponding interrupt. */
+		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND2,
+					  LAN86XX_REG_IMSK1,
+					  LAN86XX_STS1_PLCA_STS_CHANGED);
+	}
+
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_IMSK1,
+			       LAN86XX_STS1_PLCA_STS_CHANGED);
+	if (ret)
+		return ret;
+
+	/* Read to clear any pending status after disabling. */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, LAN86XX_REG_STS1);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static irqreturn_t lan86xx_handle_interrupt(struct phy_device *phydev)
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
@@ -513,6 +602,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revb1_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = genphy_c45_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -523,6 +614,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -533,6 +626,8 @@ static struct phy_driver microchip_t1s_driver[] = {
 		.features           = PHY_BASIC_T1S_P2MP_FEATURES,
 		.config_init        = lan867x_revc_config_init,
 		.read_status        = lan86xx_read_status,
+		.config_intr        = lan86xx_config_intr,
+		.handle_interrupt   = lan86xx_handle_interrupt,
 		.get_plca_cfg	    = genphy_c45_plca_get_cfg,
 		.set_plca_cfg	    = lan86xx_plca_set_cfg,
 		.get_plca_status    = genphy_c45_plca_get_status,
@@ -556,6 +651,8 @@ static struct phy_driver microchip_t1s_driver[] = {
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

