Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B263CB562;
	Tue, 25 Aug 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686539; cv=none; b=R3r9gD5AZOBn1qbDvg4/L5muc0aIrv3EwGyCsctMIu41hYhzDPj2d2Cltj6+8L8nOrJbt4y2OD97j2/hY9hc41jXOEBSKadacLQ3Gs6TYzXHPhUfmoG5UN6N2VBPOkwI6oVKoj+hJg4OMMjaCOLciNChC0jaWgTbUXgpa4HXhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686539; c=relaxed/simple;
	bh=kzQnSzf5R4sWYoFDUywmSsc4wy9lStSxb/o4b/mJUXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IZ8zLkHuou5nlkP8Rn7ibIedmwLmiy/nMPPTcilIUX7Ma+KEXU/BoSROOBbpQHCSe6n0CG+GKuwm3Om0cnzRaVmXtiR8Vvzc3CHV8kD7Ty39eYNi/S1wDcLEipV3wX302SgvSwG97lA39E5cYclTLY/w2nyDDwAhzuUAQQRkTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=g3au13gW; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="g3au13gW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6A971C022E;
	Tue, 25 Aug 2026 21:35:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787686534; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=16bXrOyf/YzIX5SObOilbyVpV7dx/JS9C49+HaxWzcg=;
	b=g3au13gWlihwdO1EVHobJOSkNyHUwCCTklDbfmk5G4kwTLWjiPUFsL7AoZz3JQ7SVXmNeg
	Mdxh9iXDjXavmJLNponBk95WyOsXgbTwz0X1HWIhABJr1gx059/VF3AJNNdszDeYrwtziL
	ah8Si1A2QSmETedhN4cQS14uUTFYsfVNtXaOvHz4/+5H6wFsZ6aYxKnANlkoFzHWh99WcN
	LD4/1QlI1N7HQRNMF1NYy2wlReQ+WQzRxaoK7Yvc1hGCya7cXESULiGiPyWjcFxVnEQ7iU
	tQGw6HGOjRx+r42TRjpWePkcTaCbaPZhNsX7rHAleNg5fbUlXsjPu8luOA9VZA==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org,
	ansuelsmth@gmail.com
Cc: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	dqfext@gmail.com,
	SkyLake.Huang@mediatek.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	cjd@cjdns.fr,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next 3/3] net: phy: mediatek: support EcoNet EN751221 gbit SoC PHY
Date: Tue, 25 Aug 2026 19:34:56 +0000
Message-Id: <20260825193456.1823985-4-cjd@cjdns.fr>
In-Reply-To: <20260825193456.1823985-1-cjd@cjdns.fr>
References: <20260825193456.1823985-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The EcoNet EN751221 gigabit SoC PHY is identified by product IDs 9451
and 9471. These devices have one such PHY which occupies MMIO index
12. This PHY is present in 3FE+1GE chips such as EN7526C, and also
the "G" chips which have an MCM gigabit switch. In the "G" chips,
this provides a 5th ethernet port.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/Kconfig         |   9 +-
 drivers/net/phy/mediatek/airoha-ge-soc.c | 214 ++++++++++++++++++++++-
 drivers/net/phy/mediatek/mtk-ge-soc.h    |   2 +
 3 files changed, 217 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index b8df1a8016c6..2d73ea6d8398 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,15 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config AIROHA_GE_SOC_PHY
-	tristate "Airoha SoC Ethernet PHYs"
-	depends on ARM64 || COMPILE_TEST
-	depends on ARCH_AIROHA || COMPILE_TEST
+	tristate "Airoha/EcoNet SoC Ethernet PHYs"
+	depends on ARCH_AIROHA || ECONET || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	select PHY_PACKAGE
 	help
-	  Supports Airoha SoC built-in Gigabit Ethernet PHYs.
+	  Supports Airoha and EcoNet SoC built-in Gigabit Ethernet PHYs.
 
 	  Include support for built-in Ethernet PHYs which are present in
-	  the AN7581 and AN7583 SoCs. These PHYs will dynamically
+	  the AN7581, AN7583, and EN751221 SoCs. These PHYs will dynamically
 	  calibrate during startup.
 
 config MEDIATEK_2P5GE_PHY
diff --git a/drivers/net/phy/mediatek/airoha-ge-soc.c b/drivers/net/phy/mediatek/airoha-ge-soc.c
index ab183779ee84..19c98d53a0fd 100644
--- a/drivers/net/phy/mediatek/airoha-ge-soc.c
+++ b/drivers/net/phy/mediatek/airoha-ge-soc.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <linux/bitfield.h>
+#include <linux/mfd/syscon.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/phy.h>
+#include <linux/regmap.h>
 
 #include "../phylib.h"
 #include "mtk.h"
@@ -9,6 +11,8 @@
 
 #define AIROHA_DEFAULT_PORT0_ADDR		0x9
 #define AIROHA_PHY_MAX_LEDS			2
+#define ECONET_GPHY_CHIPSCU_RASEL_MASK		GENMASK(15, 13)
+#define ECONET_GPHY_PORT0_ADDR			12
 
 enum airoha_mdi_resister_type {
 	MDI_0R,
@@ -259,6 +263,69 @@ static u8 an7583_zcal_to_r50ohm_5R[64] = {
 	 56,  54,  52,  50,  48,  46,  44,  42,  40,  39,  37,  36,  33,  32,  31,  29,
 };
 
+/*
+ * 2 chip revisions
+ * TXMR (no evidence that these chips were ever discrete)
+ * MDI 0R (5R not known to exist)
+ * TX AMP test/TX AMP 1G/TX AMP 100M/TX AMP 10M/R50
+ * 1 PHY
+ */
+static int en751221_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
+	{
+		/* EN751221 */
+		[TXMR] = {
+			[MDI_0R] = {
+				[TX_AMP_TEST_A] = { 14 },
+				[TX_AMP_TEST_B] = { 14 },
+				[TX_AMP_TEST_C] = { 14 },
+				[TX_AMP_TEST_D] = { 14 },
+				[TX_AMP_1G_A] = { 2 },
+				[TX_AMP_1G_B] = { 2 },
+				[TX_AMP_1G_C] = { 2 },
+				[TX_AMP_1G_D] = { 2 },
+				[TX_AMP_100M_A] = { 4 },
+				[TX_AMP_100M_B] = { 4 },
+				[TX_AMP_10M_A] = { 0 },
+				[TX_AMP_10M_B] = { 0 },
+				[R50_A] = { 0 },
+				[R50_B] = { 0 },
+				[R50_C] = { 0 },
+				[R50_D] = { 0 },
+			},
+		},
+	},
+	{
+		/* EN7526C */
+		[TXMR] = {
+			[MDI_0R] = {
+				[TX_AMP_TEST_A] = { 14 },
+				[TX_AMP_TEST_B] = { 14 },
+				[TX_AMP_TEST_C] = { 14 },
+				[TX_AMP_TEST_D] = { 14 },
+				[TX_AMP_1G_A] = { 12 },
+				[TX_AMP_1G_B] = { 13 },
+				[TX_AMP_1G_C] = { 9 },
+				[TX_AMP_1G_D] = { 9 },
+				[TX_AMP_100M_A] = { 4 },
+				[TX_AMP_100M_B] = { 4 },
+				[TX_AMP_10M_A] = { 0 },
+				[TX_AMP_10M_B] = { 0 },
+				[R50_A] = { 0 },
+				[R50_B] = { 0 },
+				[R50_C] = { -4 },
+				[R50_D] = { -4 },
+			},
+		},
+	}
+};
+
+static u8 en751221_zcal_to_r50ohm[64] = {
+	125, 125, 125, 125, 125, 125, 124, 121, 118, 115, 112, 110, 108, 105, 103, 101,
+	 99,  97,  95,  77,  75,  73,  72,  70,  68,  67,  65,  64,  63,  45,  44,  43,
+	 41,  40,  39,  38,  37,  36,  35,  34,  32,  32,  31,  30,  13,  12,  11,  10,
+	  9,   8,   8,   7,   6,   5,   5,   4,   3,   2,   2,   1,   0,   0,   0,   0
+};
+
 static int airoha_cal_cycle(struct phy_device *phydev, int devad,
 			    u32 regnum, u16 mask, u16 cal_val)
 {
@@ -276,6 +343,21 @@ static int airoha_cal_cycle(struct phy_device *phydev, int devad,
 	return ret;
 }
 
+/* EN751221 also mirrors RG_BG_RASEL into CHIP SCU register 0x16c. */
+static void en751221_gphy_mirror_rext(struct phy_device *phydev, u8 zcal)
+{
+	struct regmap *chip_scu;
+
+	chip_scu = syscon_regmap_lookup_by_compatible("econet,en751221-chip-scu");
+	if (IS_ERR(chip_scu)) {
+		phydev_err(phydev, "CHIP SCU unavailable for REXT mirror: %ld\n",
+			   PTR_ERR(chip_scu));
+		return;
+	}
+	regmap_update_bits(chip_scu, 0x16c, ECONET_GPHY_CHIPSCU_RASEL_MASK,
+			   FIELD_PREP(ECONET_GPHY_CHIPSCU_RASEL_MASK, zcal >> 3));
+}
+
 static int airoha_rext_cal_sw(struct phy_device *phydev)
 {
 	int calibration_polarity;
@@ -349,6 +431,10 @@ static int airoha_rext_cal_sw(struct phy_device *phydev)
 		       MTK_PHY_RG_BG_RASEL_MASK,
 		       FIELD_PREP(MTK_PHY_RG_BG_RASEL_MASK, zcal_ctrl >> 3));
 
+	if (phydev->phy_id == ECONET_GPHY_ID_EN7526C ||
+	    phydev->phy_id == ECONET_GPHY_ID_EN751221)
+		en751221_gphy_mirror_rext(phydev, zcal_ctrl);
+
 	phy_write_mmd(phydev, MDIO_MMD_VEND1, MTK_PHY_RG_ANA_CAL_RG0, 0);
 
 	return 0;
@@ -1369,6 +1455,106 @@ static int airoha_phy_tx_amp_compensation(struct phy_device *phydev)
 	return 0;
 }
 
+static int en751221_gphy_config_init(struct phy_device *phydev)
+{
+	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
+	int ret;
+
+	shared->mdi_resister_type = MDI_0R;
+
+	if (phydev->phy_id == ECONET_GPHY_ID_EN751221)
+		shared->tx_amp_compensation_tbl = &en751221_tx_amp_compensation_tbl[0];
+	else
+		shared->tx_amp_compensation_tbl = &en751221_tx_amp_compensation_tbl[1];
+
+	shared->r50_cal_tbl = en751221_zcal_to_r50ohm;
+
+	phy_set_bits(phydev, MII_BMCR, BMCR_RESET);
+
+	/* Global MMD (devad 0x1f) settings. */
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x273, 0x1000);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x272, 0x3cff);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x269, 0x4344);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x044, 0x0030);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x27c, 0x0808);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x27b, 0x1177);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x268, 0x0728);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x269, 0x244f);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x271, 0x4e13);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x417, 0x7775);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x024, 0xc007);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x025, 0x003f);
+	phy_write_mmd(phydev, MDIO_MMD_VEND2, 0x021, 0x800a);
+
+	/* Local MMD (devad 0x1e) settings. */
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x000, 0x01b0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x001, 0x01be);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x002, 0x01be);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x003, 0x0090);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x004, 0x0205);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x005, 0x0204);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x006, 0x039c);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x007, 0x03c0);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x008, 0x03bc);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x009, 0x0297);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00a, 0x0005);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x00b, 0x0006);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x014, 0x0040);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x044, 0x0060);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x176, 0x5500);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x177, 0x0055);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x041, 0x3333);
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x0a6, 0x0350);
+
+	phy_write_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
+
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_52B5);
+	__mtk_tr_write(phydev, 0x1, 0xf, 0x00, 0x00002b);
+	__mtk_tr_write(phydev, 0x1, 0xf, 0x03, 0x082422);
+	phy_restore_page(phydev, MTK_PHY_PAGE_STANDARD, 0);
+
+	ret = phy_write(phydev, MII_CTRL1000,
+			ADVERTISE_1000FULL | CTL1000_PREFER_MASTER |
+			CTL1000_AS_MASTER | CTL1000_ENABLE_MASTER);
+	if (ret)
+		return ret;
+
+	phy_select_page(phydev, MTK_PHY_PAGE_EXTENDED_1);
+	__phy_write(phydev, 0x14, 0x3a14);
+	phy_restore_page(phydev, ret, 0);
+
+	if (phydev->phy_id == ECONET_GPHY_ID_EN7526C) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x201, 0x4002);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x03d, 0x0c00);
+	} else {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x012, 0x2c10);
+		phy_write_mmd(phydev, MDIO_MMD_VEND1, 0x017, 0x0410);
+	}
+
+	phy_set_bits(phydev, MII_BMCR, BMCR_ANRESTART | BMCR_ANENABLE);
+
+	ret = airoha_phy_calib(phydev);
+	if (ret)
+		return ret;
+
+	ret = airoha_phy_auto_select_transformer(phydev);
+	if (ret)
+		return ret;
+
+	ret = airoha_phy_tx_amp_compensation(phydev);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int en751221_gphy_match(struct phy_device *phydev,
+			       const struct phy_driver *phydrv)
+{
+	return phydev->phy_id == ECONET_GPHY_ID_EN751221 ||
+	       phydev->phy_id == ECONET_GPHY_ID_EN7526C;
+}
+
 static int an7581_phy_config_init(struct phy_device *phydev)
 {
 	struct airoha_socphy_shared *shared = phy_package_get_priv(phydev);
@@ -1585,6 +1771,7 @@ static int an7581_phy_config_init(struct phy_device *phydev)
 
 static int an7581_phy_probe(struct phy_device *phydev)
 {
+	int port0 = AIROHA_DEFAULT_PORT0_ADDR;
 	struct airoha_socphy_shared *shared;
 	struct mtk_socphy_priv *priv;
 	struct pinctrl *pinctrl;
@@ -1596,8 +1783,11 @@ static int an7581_phy_probe(struct phy_device *phydev)
 		dev_err(&phydev->mdio.bus->dev,
 			"Failed to setup PHY LED pinctrl\n");
 
-	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
-				    AIROHA_DEFAULT_PORT0_ADDR,
+	if (phydev->phy_id == ECONET_GPHY_ID_EN7526C ||
+	    phydev->phy_id == ECONET_GPHY_ID_EN751221)
+		port0 = ECONET_GPHY_PORT0_ADDR;
+
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, port0,
 				    sizeof(struct airoha_socphy_shared));
 	if (ret)
 		return ret;
@@ -1608,7 +1798,7 @@ static int an7581_phy_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
-	if (phydev->mdio.addr == AIROHA_DEFAULT_PORT0_ADDR)
+	if (phydev->mdio.addr == port0)
 		shared->phydev_p0 = phydev;
 
 	phydev->priv = priv;
@@ -1797,6 +1987,22 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.read_page	= mtk_phy_read_page,
 		.write_page	= mtk_phy_write_page,
 	},
+	{
+		.name		= "EcoNet EN751221 GPHY",
+		.config_init	= en751221_gphy_config_init,
+		.config_intr	= genphy_no_config_intr,
+		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.match_phy_device = en751221_gphy_match,
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+		.read_page	= mtk_phy_read_page,
+		.write_page	= mtk_phy_write_page,
+	}
 };
 
 module_phy_driver(mtk_socphy_driver);
@@ -1804,6 +2010,8 @@ module_phy_driver(mtk_socphy_driver);
 static const struct mdio_device_id __maybe_unused airoha_socphy_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7581) },
 	{ PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7583) },
+	{ PHY_ID_MATCH_EXACT(ECONET_GPHY_ID_EN751221) },
+	{ PHY_ID_MATCH_EXACT(ECONET_GPHY_ID_EN7526C) },
 	{ }
 };
 
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
index 834b61dbc690..1f38b4c81860 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -9,6 +9,8 @@
 #define MTK_GPHY_ID_MT7988			0x03a29481
 #define AIROHA_GPHY_ID_AN7581			0x03a294c1
 #define AIROHA_GPHY_ID_AN7583			0xc0ff0420
+#define ECONET_GPHY_ID_EN751221			0x03a29451
+#define ECONET_GPHY_ID_EN7526C			0x03a29471
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
-- 
2.39.5

