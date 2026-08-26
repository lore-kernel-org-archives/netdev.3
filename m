Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5B448422E;
	Wed, 26 Aug 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787775697; cv=none; b=WmUHObRpbucqbyspL9QuLS+vyDBDpDGsv/sF4OUyrU2W83UAC+BgZ5MlTR356rn7wzP4NFdFRU/lR5ddzb3xAcFgJB8DiIwbhoLtpwyDR90zmK7CUfsPvo9KN9+Gf5Bkm0V16RRxNXT+IZzI7pyunkQv5NCmMrsAbXTUCgkxErc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787775697; c=relaxed/simple;
	bh=hgkwBrcNAmukIJp1g3nP4FWF3r1RkmnhKRnGSTtRkIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAQakgjs5Btm7+lePLvMe1EzAixk2+b9vHOZ/rBYLgYgetKrFoKQPFXMg4FDOkT4WfmjNmIzLFqFC2GNKmzUJ8VD5fOhmOQ4bfjqUD66ubjH4bkKqHOtUu9s8HlbJsjgnr6L7L9jn3nu1AvDbNzM3TxdbiwtbvUnB+eeI3fq5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=KZxUu3jW; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="KZxUu3jW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B10561E5FE7;
	Wed, 26 Aug 2026 22:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1787775691; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=L+noM1/lXpgZGKBt7eeuTmKa1QPtazBxdbF1xRLnPiQ=;
	b=KZxUu3jWcB8Wj04YuIEiD0AAWCmahX7viJ71lqem/xNvtW0AiTWYNlQ//LtOv8JsALeHnD
	jtlKwDSIrZAtVBdibarlqmSJLDy+6cYad3oFGkNs3MZBx1g/+JNkMfb5ULrVPT6txpqXy+
	DyNlQs8QHfxQ6WVBfCqOflhUZDHcjwFEFMz4jGeReJ9lffFMrt7z4OQGfNLXExGBXpGG3l
	48yeuRcCGEZnBS1wN2eGcV1DYCIM/uIpWlSzxuHFgEERgyfB5l8mNswtqJ8+OsPDIflNuz
	tAVufbo6DcscQzrqVJK4WX26QN+PcaLDe02PTTZ66r7wjwi87S2rIodkoCr8vw==
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
Subject: [PATCH v2 net-next 2/3] net: phy: mediatek: bug fixes to airoha-ge-soc.c
Date: Wed, 26 Aug 2026 20:21:02 +0000
Message-Id: <20260826202103.2280645-3-cjd@cjdns.fr>
In-Reply-To: <20260826202103.2280645-1-cjd@cjdns.fr>
References: <20260826202103.2280645-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Fix crash bug from unconfigured shared, potential namespace collision
in devm_phy_package_join() and typo in Kconfig.
Also make calibration tables const.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/phy/mediatek/Kconfig         |  2 +-
 drivers/net/phy/mediatek/airoha-ge-soc.c | 21 ++++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index fe51f4616c54..b8df1a8016c6 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -9,7 +9,7 @@ config AIROHA_GE_SOC_PHY
 	  Supports Airoha SoC built-in Gigabit Ethernet PHYs.
 
 	  Include support for built-in Ethernet PHYs which are present in
-	  the AN7581 and AN7583 SoCs. These PHYs d will dynamically
+	  the AN7581 and AN7583 SoCs. These PHYs will dynamically
 	  calibrate during startup.
 
 config MEDIATEK_2P5GE_PHY
diff --git a/drivers/net/phy/mediatek/airoha-ge-soc.c b/drivers/net/phy/mediatek/airoha-ge-soc.c
index 601a64d83365..5a8838a47184 100644
--- a/drivers/net/phy/mediatek/airoha-ge-soc.c
+++ b/drivers/net/phy/mediatek/airoha-ge-soc.c
@@ -50,8 +50,8 @@ struct airoha_socphy_shared {
 	enum airoha_transformer_type transformer_type[4];
 	enum airoha_mdi_resister_type mdi_resister_type;
 	bool rext_sw_calib_done;
-	int (*tx_amp_compensation_tbl)[TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4];
-	u8 *r50_cal_tbl;
+	const int (*tx_amp_compensation_tbl)[TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4];
+	const u8 *r50_cal_tbl;
 };
 
 /*
@@ -61,7 +61,7 @@ struct airoha_socphy_shared {
  * TX AMP test/TX AMP 1G/TX AMP 100M/TX AMP 10M/R50
  * 4 PHY
  */
-static int an7581_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
+static const int an7581_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
 	{ /* IC version 1 */
 		[TXMR] = {
 			{ },
@@ -152,7 +152,7 @@ static int an7581_tx_amp_compensation_tbl[2][TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX]
 	},
 };
 
-static u8 an7581_zcal_to_r45ohm[64] = {
+static const u8 an7581_zcal_to_r45ohm[64] = {
 	127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
 	127, 127, 127, 127, 127, 127, 127, 127, 123, 119, 115, 112, 108, 104, 100,  96,
 	 94,  92,  88,  85,  82,  80,  76,  74,  72,  68,  66,  64,  62,  60,  56,  55,
@@ -166,7 +166,7 @@ static u8 an7581_zcal_to_r45ohm[64] = {
  * TX AMP test/TX AMP 1G/TX AMP 100M/TX AMP 10M/R50
  * 4 PHY
  */
-static int an7583_tx_amp_compensation_tbl[TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
+static const int an7583_tx_amp_compensation_tbl[TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CALIB_CONST_TYPE_MAX][4] = {
 	[TXMR] = {
 		[MDI_0R] = {
 			[TX_AMP_TEST_A] = { -3, -3, -3, -3 },
@@ -245,14 +245,14 @@ static int an7583_tx_amp_compensation_tbl[TRANSFORMER_TYPE_MAX][MDI_TYPE_MAX][CA
 	},
 };
 
-static u8 an7583_zcal_to_r50ohm_0R[64] = {
+static const u8 an7583_zcal_to_r50ohm_0R[64] = {
 	127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
 	127, 127, 127, 122, 118, 114, 110, 106, 102,  98,  96,  92,  88,  85,  82,  80,
 	 76,  72,  70,  68,  64,  62,  60,  57,  55,  52,  50,  48,  46,  44,  41,  40,
 	 38,  36,  33,  32,  30,  28,  26,  24,  24,  22,  20,  18,  16,  16,  14,  12,
 };
 
-static u8 an7583_zcal_to_r50ohm_5R[64] = {
+static const u8 an7583_zcal_to_r50ohm_5R[64] = {
 	127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
 	127, 127, 127, 127, 127, 127, 127, 127, 127, 124, 120, 116, 112, 110, 106, 102,
 	 99,  96,  93,  90,  88,  84,  81,  79,  76,  73,  71,  68,  66,  64,  61,  59,
@@ -1142,7 +1142,7 @@ static int airoha_phy_tx_amp_compensation(struct phy_device *phydev)
 	int r50_high_limit = 0x88;
 
 	bool overflow;
-	int (*tx_amp_table)[CALIB_CONST_TYPE_MAX][4];
+	const int (*tx_amp_table)[CALIB_CONST_TYPE_MAX][4];
 	int transformer_type, mdi_resister_type;
 
 	phydev_p0 = shared->phydev_p0;
@@ -1596,11 +1596,14 @@ static int an7581_phy_probe(struct phy_device *phydev)
 		dev_err(&phydev->mdio.bus->dev,
 			"Failed to setup PHY LED pinctrl\n");
 
-	ret = devm_phy_package_join(&phydev->mdio.dev, phydev, 0,
+	ret = devm_phy_package_join(&phydev->mdio.dev, phydev,
+				    AIROHA_DEFAULT_PORT0_ADDR,
 				    sizeof(struct airoha_socphy_shared));
 	if (ret)
 		return ret;
 
+	shared = phy_package_get_priv(phydev);
+
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
-- 
2.39.5

