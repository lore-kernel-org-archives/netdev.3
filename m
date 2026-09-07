Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE7374A15;
	Mon,  7 Sep 2026 01:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746277; cv=none; b=o+pUuq5nOSOsFVd+oTYOCWqGf8UlKh2qadE3yyAP++3n36bbTIL4X/yBvzgdBx5RAX4S9kvI/RnjzvUt+fMcf7iqh+84pVWNLPJfxSKFY77ZLoP+5mGcCkyT1RAFlPD2iYlTp3ynhXRYiSrDdsCfKqChsxcMZi90PIIFSc36Gqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746277; c=relaxed/simple;
	bh=xoToF5L/SxeWYUUpNKV8Zl0RIe8YD79/QEVN3oVf/Ns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFvrX6fO66xT7QDz9dAJLQBoEDyf/hG7oE8ZsCuNJ90djie9BK/PUwcaefwVD9xoOEbUtaRSXMxAxxKKZ9rsm/tyx4IVae35QOvbJq/QDyecnfDOCEH39MvaEQpqwqmTaLrQzAoDkvIQT2kOtjKt8GMYQFLTzT/yJGVyYsunypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EKF8rv9P; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EKF8rv9P"
X-UUID: 83a1e2dcaa5f11f1b1788b6acf885367-20260907
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Jb+32ecVAjBk5IFAhuAWAoGFpM2KQO7BagDHUAVEUcA=;
	b=EKF8rv9PN2RnqUWmlY25sjNCkkZbrdOM8mZKq386uFbSeiyFUo8B0dCkH8iPq4DTtd9yYPEpjLaDGYtOm6fPz3u1XElLniazir2Md9ueLpgDXnsj2hadhCwfefn9AFlMvw/Jpzu7/mSWBkDAg5XgYXPwYAkupraGNfSwMsQD+i4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d00086a0-893d-4be6-bc25-0f2f860be09f,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:7db8b62,CLOUDID:db288ff2-6b5d-4016-ba8d-9f799a78b7e4,B
	ulkID:nil,BulkQuantity:0,SF:81|82|102|836|865|888|898,TC:-5,Content:0|15|5
	0|99,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83a1e2dcaa5f11f1b1788b6acf885367-20260907
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ar702101@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 865314276; Mon, 07 Sep 2026 09:57:43 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 7 Sep 2026 09:57:42 +0800
Received: from mediatek.com (172.18.153.125) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.2562.29 via Frontend
 Transport; Mon, 7 Sep 2026 09:57:42 +0800
Received: by arhtenbupstream01.localdomain (Postfix, from userid 1007)
	id 1303214ED40; Mon,  7 Sep 2026 09:57:42 +0800 (CST)
From: Weiting Lee <weiting.lee@airoha.com>
To: <netdev@vger.kernel.org>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, <bjorn@mork.no>,
	<ericwouds@gmail.com>, <frank-w@public-files.de>, <joseph.lin@airoha.com>,
	<wenshin.chung@airoha.com>, <lucien.jheng@airoha.com>,
	<albert-al.lee@airoha.com>, Weiting Lee <weiting.lee@airoha.com>
Subject: [PATCH v3 net-next] net: phy: air_en8811h: select LED GPIO pins based on AN8811HB package variant
Date: Mon, 7 Sep 2026 09:56:37 +0800
Message-ID: <20260907015638.2875763-1-weiting.lee@airoha.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828050537.2728253-1-weiting.lee@airoha.com>
References: <20260828050537.2728253-1-weiting.lee@airoha.com>
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
v2 -> v3:
- Rebase on top of net-next commit 3498acda6b68
  ("net: phy: air_en8811h: restore AN8811HB LED GPIO after MCU restart")
- an8811hb_led_gpio_setup() now covers the AN8811HBN (345) case that
  commit restored, replacing its direct GPIO_OUTPUT_345 restore call

v1 -> v2:
- Rename pkg_sel to is_an8811hbcn (bool) for clarity
- Remove phydev_info log to avoid spamming the kernel log
- Fix commit message: HWTRAP2 bits are read-only silicon
  identification, not a hardware strap pin

v1: https://lore.kernel.org/netdev/20260827054156.2681908-1-weiting.lee@airoha.com/
v2: https://lore.kernel.org/netdev/20260828050537.2728253-1-weiting.lee@airoha.com/
 drivers/net/phy/air_en8811h.c | 67 ++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 38eb18f0e9bb..ae24c41f538a 100644
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
@@ -1263,10 +1321,11 @@ static int an8811hb_config_init(struct phy_device *phydev)
 		return ret;
 	}
 
-	/* Restore LED GPIO output enables after MCU initialization. */
-	ret = air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
-					  AN8811HB_GPIO_OUTPUT_345,
-					  AN8811HB_GPIO_OUTPUT_345);
+	ret = an8811hb_led_gpio_setup(phydev);
+	if (ret < 0) {
+		phydev_err(phydev, "Failed to set up LED GPIO: %d\n", ret);
+		return ret;
+	}
 	return ret;
 }
 
-- 
2.43.0

