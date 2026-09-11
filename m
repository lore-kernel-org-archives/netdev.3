Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6F9381E97;
	Fri, 11 Sep 2026 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789128444; cv=none; b=g++144c7u9VVoKfrvVb4dHwLuBoh6OCrZFO+ZbF+Sn+touIuR2dE0w1Ht+lpIxS7U2H+3rx9fUQcBT1E9tuvuOKbDKSGVcA20NtmNJTPWsFfGokI2XyMNt7TdRKFZyrB5NQc+yBdLiSasXS0rkRQo4OZlng/8ZmEmhY2FCXBQYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789128444; c=relaxed/simple;
	bh=8UAU1R/Rkig82G/2Kdo7qoIMFng0sVg4Ig/9uaxQXK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQQXT1nNHV7SfiAMdRLahxBtCncbZN17iHBS2hqmyYXuVvkaV/V89VkE1l/s7ewzI5yCYNuI7X/xh723Qa+kR+BhUDUDt1O73ysPubB3lZU/O0kzpR/kGVrVgPqG1vNXe9uG7yalDjrybaaRcNYNWufjru7D+iGyNHAtCT8Pz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=FmXk65KL; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="FmXk65KL"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2DA54226B1;
	Fri, 11 Sep 2026 14:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789128429; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=p8SY5RIKlDVTHUzXb43/DvNCM+PcOoc/HUdXfnhxDpY=;
	b=FmXk65KLUWgBN+mEea6wz3cYRAMHR/2G9tqJPKyylhRWgC+yZ5ga8mv8DTRTs2SeaxDkhU
	elTaQPTyH1+OL96K3i4xXpCYj0QuvIOe1iC8H+RLOR/x6Qv1rbyxsvmM8qekch8axawJjn
	412R+EVWIc6eY5sfzE0b8Qph8JKh7jyM5tiFxplx/lxTh0RrMcawRsVv3sAcQ+SmDiDAOd
	0SsU6Xxp40uHYxqOuEk4OYXKJ1HmZ7+nitnNPlTAQK/Sko6zHhE1lTUyQ9vvL3vUoNbMmR
	z9W90oUvnd8MUlICMUoUK2GEVa33jqsQoZjfsNJ6tlanYH/sKb/D2hcOJz3v2g==
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
Subject: [PATCH v3 net-next] net: phy: mediatek: support MT7530 PHYs on EN71221 MCM
Date: Fri, 11 Sep 2026 12:06:46 +0000
Message-Id: <20260911120646.4123877-1-cjd@cjdns.fr>
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

Of note: MDIO_AN_EEE_ADV must be zero at startup or else link will
fail to connect. Setting MDIO_AN_EEE_ADV to 6 after link is brought
up will make EEE work when cable is next plugged in, but link fails
to downgrade to 100mb if gigabit is not possible, leaving a
"connected" (nonfunctional) gigabit link.

Co-developed-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Signed-off-by: Matheus Sampaio Queiroga <srherobrine20@gmail.com>
Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/mtk-ge.c | 92 +++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/phy/mediatek/mtk-ge.c b/drivers/net/phy/mediatek/mtk-ge.c
index 73d9b72f9d9e..587227d0f05c 100644
--- a/drivers/net/phy/mediatek/mtk-ge.c
+++ b/drivers/net/phy/mediatek/mtk-ge.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0+
+#include <linux/of.h>
 #include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/phy.h>
@@ -73,6 +74,81 @@ static int mt7530_phy_config_init(struct phy_device *phydev)
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
+	/* Master/Slave negotiation does not work reliably */
+	ret = phy_write(phydev, MII_CTRL1000, ADVERTISE_1000FULL |
+			CTL1000_ENABLE_MASTER | CTL1000_PREFER_MASTER |
+			CTL1000_AS_MASTER);
+	if (ret < 0)
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
+	/*
+	 * MDIO_AN_EEE_ADV must be explicitly zeroed at initialization time or
+	 * the link will fail to establish - even if EEE is disabled later.
+	 */
+	phy_disable_eee(phydev);
+	ret = phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
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
+static int mt7530_phy_match(struct phy_device *phydev,
+			    const struct phy_driver *phydrv)
+{
+	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0 &&
+		!en751221_is_mcm_phy(phydev);
+}
+
+static int en751221_phy_match(struct phy_device *phydev,
+			      const struct phy_driver *phydrv)
+{
+	return (phy_read(phydev, MII_ESTATUS) & ESTATUS_1000_TFULL) != 0 &&
+		en751221_is_mcm_phy(phydev);
+}
+
 static int mt7531_phy_config_init(struct phy_device *phydev)
 {
 	mtk_gephy_config_init(phydev);
@@ -106,6 +182,22 @@ static struct phy_driver mtk_gephy_driver[] = {
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

