Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F382837E5ED;
	Thu, 27 Aug 2026 05:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787809448; cv=none; b=i4biCthmzTgoQzfevRmVkLweqgdOaupMKAKPeZnOMBbc3xF/+t0XFdLeLBK27rd5crVW8mvJUbHx0I5FKdPPcaa680/h/kW9gqHs0k5t/7dlYBifv8e8LXQ0labHFlwqtGdLHjEdDQM1s7UErhJjbP4QMmHKi/tpTRCXloyXc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787809448; c=relaxed/simple;
	bh=ehdLI9XJe4MGQJlDJMsddxBK2pboyUZY6JWkkTBmxik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eSS3KsugxI8OAYel1X9szUJrt8zUBzq/DRY4c7I/CpS7MshOUsf0X5DvAp4xSdBhTp+AzsfQH5ixcnhu87TJGQ4342cuwlFCWpdlt3BqfgmZeJfX605w1z9/EkYVOBbuc0q5jyOXox45oySS/lsZU9WC+wHoU9iVx8iZJ4LwuOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Bcja6Lsh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bcja6Lsh"
X-UUID: 4c7a8152a1da11f1b1788b6acf885367-20260827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=zAl5+xJIILLLgyzuujhGEZ1ZpTeiTKvAQJo4I14Xvwc=;
	b=Bcja6LshaOLAqqpWqsXnDpkUgCnvLSetsMr7qWpaMSj00ZCeHM47WZgyo3m0KIuBEHtmWWUwuBvRumS+Ds3d7G8XMhk+uDBzYEGI2LqmZqZFHM5u8wtgBTHwSgC0ESttjDj/UcA9T9ViJEMn8OZfzRZ0LaVZwNZNy/maxnzytU0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:7d9acf94-ae40-412b-9d6a-b470ea8b0db8,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:e5bf0386-60c2-4fed-ac12-33120eceef49,B
	ulkID:nil,BulkQuantity:0,SF:102|836|865|888|898,TC:-5,Content:0|15|50|99,E
	DM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4c7a8152a1da11f1b1788b6acf885367-20260827
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ar702101@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2104094483; Thu, 27 Aug 2026 13:43:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Aug 2026 13:43:57 +0800
Received: from mediatek.com (172.18.153.125) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Thu, 27 Aug 2026 13:43:57 +0800
Received: by arhtenbupstream01.localdomain (Postfix, from userid 1007)
	id 21FB214E326; Thu, 27 Aug 2026 13:43:57 +0800 (CST)
From: Weiting Lee <weiting.lee@airoha.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Weiting Lee
	<weiting.lee@airoha.com>
Subject: [PATCH] net: phy: air_en8811h: select LED GPIO pins based on AN8811HB package variant
Date: Thu, 27 Aug 2026 13:41:55 +0800
Message-ID: <20260827054156.2681908-1-weiting.lee@airoha.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AN8811HB comes in two package variants, AN8811HBCN and AN8811HBN,
which use different GPIO pins to drive LED outputs. AN8811HBCN uses
GPIOs 0, 1, and 15, while AN8811HBN uses GPIOs 3, 4, and 5. Using a
fixed GPIO assignment causes incorrect LED behavior on one of the
variants.

Read the package variant from hardware strap register AN8811HB_HWTRAP2
at probe time and store it in priv->pkg_sel. Add an8811hb_led_gpio_setup()
to configure the correct GPIO output pins and select lines based on the
detected variant, and call it from config_init.

Signed-off-by: Weiting Lee <weiting.lee@airoha.com>
---
 drivers/net/phy/air_en8811h.c | 72 +++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index edd49c193e47..299163501140 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -145,10 +145,22 @@
 
 #define AN8811HB_GPIO_OUTPUT		0x5cf8b8
 #define   AN8811HB_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
+#define   AN8811HB_GPIO_OUTPUT_0115		(BIT(0) | BIT(1) | BIT(15))
+
+#define AN8811HB_GPIO_SEL1		0x5cf8bc
+#define   AN8811HB_GPIO_SEL1_0_MASK		GENMASK(3, 0)
+#define   AN8811HB_GPIO_SEL1_1_MASK		GENMASK(7, 4)
+#define   AN8811HB_GPIO_SEL1_0			BIT(0)
+#define   AN8811HB_GPIO_SEL1_1			0
+
+#define AN8811HB_GPIO_SEL2		0x5cf8c0
+#define   AN8811HB_GPIO_SEL2_15_MASK		GENMASK(31, 28)
+#define   AN8811HB_GPIO_SEL2_15			BIT(29)
 
 #define AN8811HB_HWTRAP1		0x5cf910
 #define AN8811HB_HWTRAP2		0x5cf914
 #define   AN8811HB_HWTRAP2_CKO			BIT(28)
+#define   AN8811HB_HWTRAP2_PKG			GENMASK(14, 12)
 
 #define AN8811HB_CLK_DRV		0x5cf9e4
 #define AN8811HB_CLK_DRV_CKO_MASK		GENMASK(14, 12)
@@ -202,6 +214,7 @@ struct en8811h_priv {
 	struct phy_device	*phydev;
 	unsigned int		cko_is_enabled;
 	struct mdio_device	*pbusdev;
+	unsigned int		pkg_sel;
 };
 
 enum {
@@ -1071,10 +1084,49 @@ static int en8811h_leds_setup(struct phy_device *phydev)
 	return ret;
 }
 
+static int an8811hb_led_gpio_setup(struct phy_device *phydev)
+{
+	struct en8811h_priv *priv = phydev->priv;
+	int ret;
+
+	if (priv->pkg_sel) {
+		/* AN8811HBCN: LED GPIOs are 0, 1, 15 */
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+						  AN8811HB_GPIO_OUTPUT_0115,
+						  AN8811HB_GPIO_OUTPUT_0115);
+		if (ret < 0)
+			return ret;
+
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL1,
+						  AN8811HB_GPIO_SEL1_0_MASK |
+						  AN8811HB_GPIO_SEL1_1_MASK,
+						  AN8811HB_GPIO_SEL1_0 |
+						  AN8811HB_GPIO_SEL1_1);
+		if (ret < 0)
+			return ret;
+
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_SEL2,
+						  AN8811HB_GPIO_SEL2_15_MASK,
+						  AN8811HB_GPIO_SEL2_15);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* AN8811HBN: LED GPIOs are 3, 4, 5 */
+		ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
+						  AN8811HB_GPIO_OUTPUT_345,
+						  AN8811HB_GPIO_OUTPUT_345);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int an8811hb_probe(struct phy_device *phydev)
 {
 	struct mdio_device *mdiodev;
 	struct en8811h_priv *priv;
+	u32 reg_val;
 	int ret;
 
 	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(struct en8811h_priv),
@@ -1115,6 +1167,15 @@ static int an8811hb_probe(struct phy_device *phydev)
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 
+	/* Detect package variant */
+	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &reg_val);
+	if (ret < 0)
+		goto err_dev_create;
+	priv->pkg_sel = FIELD_GET(AN8811HB_HWTRAP2_PKG, reg_val);
+
+	phydev_info(phydev, "%s detected\n",
+		    priv->pkg_sel ? "AN8811HBCN" : "AN8811HBN");
+
 	ret = en8811h_leds_setup(phydev);
 	if (ret < 0)
 		goto err_dev_create;
@@ -1125,13 +1186,6 @@ static int an8811hb_probe(struct phy_device *phydev)
 	if (ret)
 		goto err_dev_create;
 
-	/* Configure led gpio pins as output */
-	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-					  AN8811HB_GPIO_OUTPUT_345,
-					  AN8811HB_GPIO_OUTPUT_345);
-	if (ret < 0)
-		goto err_dev_create;
-
 	return 0;
 
 err_dev_create:
@@ -1270,6 +1324,10 @@ static int an8811hb_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	ret = an8811hb_led_gpio_setup(phydev);
+	if (ret < 0)
+		return ret;
+
 	ret = air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
 			    AIR_LED_MODE_USER_DEFINE);
 	if (ret < 0)
-- 
2.43.0

