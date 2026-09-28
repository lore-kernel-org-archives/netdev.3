Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35175038F5;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790634324; cv=none; b=MU3WTMb6rlXhHypaWJwOw8dy+XwtHFrLzGqq/7DBYBuCXL3iIM9liV8XE4YV5XMSU15CpbbleuUcHy8j5ZLvQyVbYsUK0TaTAaPA3P3M3SgbZ6kbdJQr5+m8F/d76wP2vaH/oKmR+RNZFYizNvkpUXx6UazkrDVmywcGr98N6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790634324; c=relaxed/simple;
	bh=h5iA8P3qa9weAZJhsrdysy41HmWpIYcYcpnBTyDrLho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhJs14Q6WvGN1Upq7j+1VmtTNJgz32ekQAhTKGNbChyz3erEiOVz+Afy+9NqplDpzfV0qO5Uc2kgohS9/8A2LSMGYNGnnFiGMnB+gLTTiCyuPyRWbPQqZmyK4NsffS7J8uDtfB/MWVB72Eo6nKEIZGedVGRP3lAg950AN8OrEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWHw+lx0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWHw+lx0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A705C4AF66;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790634324;
	bh=h5iA8P3qa9weAZJhsrdysy41HmWpIYcYcpnBTyDrLho=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nWHw+lx0yhjBq5IKsPkiq4ret7mUe9PemLvgkqj6vpIFMeMJgZ9Wz7ZGR/ij5btVi
	 3dCuLwILKGlBxid2cB/q5BTMF2cj86Ksxmk7TBusw7QXYQ0M3acQ2+deleGJAVcRuh
	 vZhNd+vBKRIsQQwCRYuwFiEIawI3f761yw/2NhadHANhidTlHIy6yK9HHF3sg0r9mq
	 txSGl72xbaNS7W5KPI3luVT+QZdg2yJieP7R20r6TexVfXvMo4HaBn8V4z05jqq+fL
	 deq9ud8+4WobwyIf6DDLeRITiS9Z6Ef3hDAQSPKpQMtdWCRffyiDkywOKYDaqE2xkt
	 YCnxtuFhdjlcA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B0ACA5FA5;
	Mon, 28 Sep 2026 22:25:24 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 28 Sep 2026 15:25:14 -0700
Subject: [PATCH net-next v8 07/11] net: phy: ncn26000: Support for onsemi's
 S2500 internal phy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-s2500-mac-phy-support-v8-7-7e011aacc309@onsemi.com>
References: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
In-Reply-To: <20260928-s2500-mac-phy-support-v8-0-7e011aacc309@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790634319; l=4713;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=IXeNj9L5tED2ppARUkMpR6OGj/kbD0b7dGa4+Nn7cLc=;
 b=H27rcqb9eypqF9210JLMdaddkjRHKHyV/ZNsTYYchOEwRJsPpOZpG2f9y+f8RO01h7zYKkUtf
 97aVJfr8qvwDgZK8jK5KH3gfB+TufhIj1bBHe5ua98ac2z9XJT9NxCs
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding support for internal PHY of the integrated
media access controller S2500. PLCA tx opportunity timer's
default value is correct in this device, compared to
the currently supported PHY NCN26000.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v8
  - changes to use newer API for read/write_mmd callback
changes in v7
  - No change
changes in v6
  - No change
changes in v5
  - No change
changes in v4
  - no change
changes in v3
   added new PHY support separate patch
   changed model comparison to use phy_id_compare_model
changes in v2
   Removed bug fixes. Retained only S2500 specific changes
changes in v1
   Added support for an internal PHY of onsemi's MAC-PHY S2500
---
 MAINTAINERS                |  3 ++-
 drivers/net/phy/ncn26000.c | 38 +++++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c7028c94f56..5934fdd78753 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20420,7 +20420,8 @@ S:	Maintained
 F:	arch/mips/boot/dts/ralink/omega2p.dts
 
 ONSEMI ETHERNET PHY DRIVERS
-M:	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
+M:	Piergiorgio Beruto <pier.beruto@onsemi.com>
+M:	Selva Rajagopal <selvamani.rajagopal@onsemi.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.onsemi.com
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index cabdd83c614f..374684e11fac 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -2,7 +2,7 @@
 /*
  *  Driver for the onsemi 10BASE-T1S NCN26000 PHYs family.
  *
- * Copyright 2022 onsemi
+ * Copyright 2026 onsemi
  */
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
@@ -14,6 +14,7 @@
 
 #include "mdio-open-alliance.h"
 
+#define PHY_ID_S2500			0x180FF411
 #define PHY_ID_NCN26000			0x180FF5A1
 
 #define NCN26000_REG_IRQ_CTL            16
@@ -37,13 +38,18 @@
 
 static int ncn26000_config_init(struct phy_device *phydev)
 {
+	int ret = 0;
+
 	/* HW bug workaround: the default value of the PLCA TO_TIMER should be
 	 * 32, where the current version of NCN26000 reports 24. This will be
 	 * fixed in future PHY versions. For the time being, we force the
 	 * correct default here.
 	 */
-	return phy_write_mmd(phydev, MDIO_MMD_VEND2, MDIO_OATC14_PLCA_TOTMR,
-			     TO_TMR_DEFAULT);
+	if (phy_id_compare_model(phydev->drv->phy_id, PHY_ID_NCN26000))
+		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
+				    MDIO_OATC14_PLCA_TOTMR,
+				    TO_TMR_DEFAULT);
+	return ret;
 }
 
 static int ncn26000_config_aneg(struct phy_device *phydev)
@@ -117,8 +123,8 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 
 static int ncn26000_config_intr(struct phy_device *phydev)
 {
-	int ret;
 	u16 irqe;
+	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		// acknowledge IRQs
@@ -141,6 +147,26 @@ static int ncn26000_config_intr(struct phy_device *phydev)
 }
 
 static struct phy_driver ncn26000_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_S2500),
+		.name                  = "S2500",
+		.features              = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init           = ncn26000_config_init,
+		.config_intr           = ncn26000_config_intr,
+		.config_aneg           = ncn26000_config_aneg,
+		.read_status           = ncn26000_read_status,
+		.handle_interrupt      = ncn26000_handle_interrupt,
+		.set_plca_cfg          = genphy_c45_plca_set_cfg,
+		.get_plca_cfg          = genphy_c45_plca_get_cfg,
+		.get_plca_status       = genphy_c45_plca_get_status,
+		.soft_reset            = genphy_soft_reset,
+		.get_sqi               = genphy_c45_oatc14_get_sqi,
+		.get_sqi_max           = genphy_c45_oatc14_get_sqi_max,
+		.read_mmd              = genphy_read_mmd_c45,
+		.write_mmd             = genphy_write_mmd_c45,
+		.cable_test_get_status = genphy_c45_oatc14_cable_test_get_status,
+		.cable_test_start      = genphy_c45_oatc14_cable_test_start,
+	},
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_NCN26000),
 		.name			= "NCN26000",
@@ -161,11 +187,13 @@ module_phy_driver(ncn26000_driver);
 
 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);
 
-MODULE_AUTHOR("Piergiorgio Beruto");
+MODULE_AUTHOR("Piergiorgio Beruto <pier.beruto@onsemi.com>");
+MODULE_AUTHOR("Selva Rajagopal <selvamani.rajagopal@onsemi.com>");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");

-- 
2.43.0


