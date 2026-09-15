Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967B4A4EF4;
	Tue, 15 Sep 2026 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472081; cv=none; b=GTu+5Ztk0l9sngC45DrcjIssnzNC9WIBArm7lHGmQ8TMyjHeM1o/u4aMbiyBfN9AOpf5fmiZUhPzlOmh206psr9gdcsV8mRlFxQmhV3hWowZwCMlFok42ePzCodXcuzoaR8vEP1768UceUBwQyM/3btMCAf9rRmXkbmF15zsT5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472081; c=relaxed/simple;
	bh=KEFJLqrtBvHSM2ilsL45KGdw1zstaQc9a0kjLjgKlMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FQRFPcBcv6qW70hXElWK75KvEXaz/f3U7fOeo56jB27KnJO+qafqM8IzJE8JSL9GHCeDHoLClyv5H9EejdExLHN4Q2r4y49wmqvLf+JcGfPklNrJuTcjY4nctPECuP8arPJLIkNnwjWAs3jr5dypRaT72vCWto+oZtSk8R90Iv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=NzA30gmc; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="NzA30gmc"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28A1E47C4C0;
	Tue, 15 Sep 2026 13:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789472076; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=l7PQHSfZ7VfYkxwlucQsKGORvPo8DgZN+X++W5AjwOw=;
	b=NzA30gmcfn9DyIMEofrPStZ4vQAnQ6ekfv+r2Zp0ikLEAaf7vm0dJhvhzmZWVGWULBKKQI
	s4oFOp19b+Rw0RFYYJ9uAtRTriZSPLPyyHjV3EMCcu7XWiY7B1fAjey3PrxmhcF6/bRV2E
	0e33RYWg8ICuVpOYge1XWGSpa0e0XNpkvU5ST2K+iskzt24ysFFLVio+f+WHmPS76V941e
	DZK+Fp/aDaKd2Li2LUdaZEJCPXrjESTpRnlDXCfYs4YkchjcMy6ejx+cyvJSeYDr+ekAxq
	kKIc5xXbIb6zSx8WG/RORW9v/omD0SbDXWWINpMvll5eV9kfsDpWIKD6sSmcGA==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Subject: [PATCH v5 net-next] net: phy: mediatek: support MT7530 PHYs on EN71221 MCM
Date: Tue, 15 Sep 2026 11:34:27 +0000
Message-Id: <20260915113427.113296-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 multi-chip module implementation of the MT7530
requires some additional configuration of the PHYs on startup.
The reason for this is not known, but it is possible that it has
to do with the fact that the EN751221 MCM implementation of the
MT7530 runs at an abnormal PLL frequency (362.5Mhz).

Detect whether the MT7530 PHY is attached to the MDIO bus of an
EcoNet EN751221 switch and if so, apply the necessary register
updates. Additionally, never attempt to configure an MT7530
identified PHY which does not have gigabit support because the same
ID is used for another (FE) PHY.

Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/mtk-ge.c | 81 +++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 96d8ac5154e5..eddb66218d7c 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <linux/of.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -101,6 +102,69 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
 	return 0;
 }
 
+/*
+ * The EcoNet EN751221 "G" multi-chip module MT7530 requires additional PHY
+ * configuration.
+ */
+static int en751221_mcm_phy_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_soft_reset(phydev);
+	if (ret)
+		return ret;
+
+	ret = phy_write_paged(phydev, MTK_PHY_PAGE_EXTENDED_1,
+			      MTK_PHY_AUX_CTRL_AND_STATUS, 0x3a04);
+	if (ret < 0)
+		return ret;
+
+	/* Clause 45 global/local data from mt7530GePhyCfgLoad(E3.0). */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x0417, 0x7775);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00a6, 0x0350);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0012, 0xd210);
+	if (ret < 0)
+		return ret;
+
+	return mt7530_phy_config_init(phydev);
+}
+
+static bool en751221_is_mcm_phy(struct phy_device *phydev)
+{
+	struct device *parent = phydev->mdio.bus->parent;
+
+	return parent && parent->of_node &&
+	       of_device_is_compatible(parent->of_node, "econet,en751221");
+}
+
+/*
+ * MTK_GPHY_ID_MT7530 ID is also used for an EcoNet SoC FE phy, but that PHY
+ * does not advertise ESTATUS_1000_TFULL.
+ */
+static bool mt7530_is_gphy(struct phy_device *phydev)
+{
+	return phydev->phy_id == MTK_GPHY_ID_MT7530 &&
+	       (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0;
+}
+
+static int mt7530_phy_match(struct phy_device *phydev,
+			    const struct phy_driver *phydrv)
+{
+	return mt7530_is_gphy(phydev) && !en751221_is_mcm_phy(phydev);
+}
+
+static int en751221_phy_match(struct phy_device *phydev,
+			      const struct phy_driver *phydrv)
+{
+	return mt7530_is_gphy(phydev) && en751221_is_mcm_phy(phydev);
+}
+
 static int mt7531_phy_config_init(struct phy_device *phydev)
 {
 	mtk_gephy_config_init(phydev);
@@ -135,6 +199,23 @@ static struct phy_driver mtk_gephy_driver[] = {
 		 */
 		.config_intr	= genphy_no_config_intr,
 		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.match_phy_device = mt7530_phy_match,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+	},
+	{
+		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7530),
+		.name		= "EcoNet EN751221 MCM PHY",
+		.probe		= mt7530_phy_probe,
+		.config_init	= en751221_mcm_phy_config_init,
+		/* Interrupts are handled by the switch, not the PHY
+		 * itself.
+		 */
+		.config_intr	= genphy_no_config_intr,
+		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.match_phy_device = en751221_phy_match,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
 		.read_page	= mtk_phy_read_page,
-- 
2.39.5

