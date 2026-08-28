Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308F348898;
	Fri, 28 Aug 2026 05:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893735; cv=none; b=HHYCESTDpglmt+pOmKFm1kUTfnzUab1msXB6TAevhASQG6HlUwmcanexd+KE4D/KjB480lHHWR7qbwbmljjn56hTKtqcfZXxCZ4cbii2iKmWuN2FHO0D0LQhYdzA/othJfDYl5UyDzZ2TvG5Whfb3DXmYsiJdqYRSPC16De8Soc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893735; c=relaxed/simple;
	bh=8wrwRZmXV7c1kit9DHdHncVIapI+5wgRg6JtVOj1gmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8cM1GlLOTuH/XwJyiQ2B0PH7o0eURA+L8VAT0cQiglo5slcHCOGGWeRqzJhD+yVnbvF+pWB1fopQG+A/NAEKDaLmJ2lTZFsBhXZW7eJFuKJg+cK0L4fRfFN8V9W7AbscmNk06Sta3rfa03frwkJJPOTskcg7YFwCYQLN+lyuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=DcjvGGbF; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DcjvGGbF"
X-UUID: 8c75fcfea29e11f1b1788b6acf885367-20260828
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uQ1iJTPql4QJ/5QzAf6I6rFP6Ucg6tGTRI9VOFDo99k=;
	b=DcjvGGbFI/yfQgMbLwAQunsEJzbCxBQFQ01cmPHDVbc+1w7n5yTtRIPxFUvng1nXF50J9xoWRCKWvHNX38F48cEQuch9KZIAqj7uwp3CGHrnKkB/0vKfYSRgAmOcuzQrp8V/K825rdwSvV6xdthpqlltGIu046XxCSAg9kNJrDI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:cd853161-e651-46d3-a48c-27537f4f7245,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:2b7e2ef2-6b5d-4016-ba8d-9f799a78b7e4,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8c75fcfea29e11f1b1788b6acf885367-20260828
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <ar702101@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 760232335; Fri, 28 Aug 2026 13:08:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 28 Aug 2026 13:08:45 +0800
Received: from mediatek.com (172.18.153.125) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Fri, 28 Aug 2026 13:08:45 +0800
Received: by arhtenbupstream01.localdomain (Postfix, from userid 1007)
	id A602A141B88; Fri, 28 Aug 2026 13:08:45 +0800 (CST)
From: Weiting Lee <weiting.lee@airoha.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, <bjorn@mork.no>,
	<ericwouds@gmail.com>, <frank-w@public-files.de>, <joseph.lin@airoha.com>,
	<wenshin.chung@airoha.com>, <lucien.jheng@airoha.com>,
	<albert-al.lee@airoha.com>, Weiting Lee <weiting.lee@airoha.com>
Subject: [PATCH v2 net-next] net: phy: air_en8811h: select LED GPIO pins based on AN8811HB package variant
Date: Fri, 28 Aug 2026 13:05:36 +0800
Message-ID: <20260828050537.2728253-1-weiting.lee@airoha.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8530a501-705b-45b2-b876-68855955bccd@lunn.ch>
References: <8530a501-705b-45b2-b876-68855955bccd@lunn.ch>
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

Read the package variant from the read-only silicon identification bits
in AN8811HB_HWTRAP2 at probe time and store it in priv->is_an8811hbcn.
Add an8811hb_led_gpio_setup() to configure the correct GPIO output pins
and select lines based on the detected variant, and call it from
config_init.

Signed-off-by: Weiting Lee <weiting.lee@airoha.com>
---
v1 -> v2:
- Rename pkg_sel to is_an8811hbcn (bool) for clarity
- Remove phydev_info log to avoid spamming the kernel log
- Fix commit message: HWTRAP2 bits are read-only silicon
  identification, not a hardware strap pin

v1: https://lore.kernel.org/netdev/20260827054156.2681908-1-weiting.lee@airoha.com/
 drivers/net/phy/air_en8811h.c | 69 +++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 0eeb7b9a4e26..7b69bb79b77f 100644
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
+	bool			is_an8811hbcn;
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
+	if (priv->is_an8811hbcn) {
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
@@ -1115,6 +1167,12 @@ static int an8811hb_probe(struct phy_device *phydev)
 	/* MDIO_DEVS1/2 empty, so set mmds_present bits here */
 	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
 
+	/* Detect package variant */
+	ret = air_phy_buckpbus_reg_read(phydev, AN8811HB_HWTRAP2, &reg_val);
+	if (ret < 0)
+		goto err_dev_create;
+	priv->is_an8811hbcn = FIELD_GET(AN8811HB_HWTRAP2_PKG, reg_val);
+
 	ret = en8811h_leds_setup(phydev);
 	if (ret < 0)
 		goto err_dev_create;
@@ -1125,13 +1183,6 @@ static int an8811hb_probe(struct phy_device *phydev)
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
@@ -1263,6 +1314,10 @@ static int an8811hb_config_init(struct phy_device *phydev)
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

