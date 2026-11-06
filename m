Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794007141;
	b=vmCMilqZHLjCAGEhBc/zaC14N5QM1rBfQuENKvA5ExT+OtOoCypJXlV9X6Q8DIf7YsNr
	 o8qLSHjzOanNWoGlVt4CYiBp3qTXLsgweLw+vAYFUTBbhDm2iAvoPMTNszsD3JDFDikso
	 JLrVNEzx/1OA5gqGYpk9/pAMnsxTYgI5ROkwTtklZBMymBo6jANb+qqGtFuZovjUgttvl
	 scPYY/FVzGsOmgu6cvUPDR6f8yAkryjhCiqYsGnwMRMAWG4OIyBVHnBSu5kAuM91HaEBN
	 GoIomNvvgSFGpP2uFRkhkrIlvBd9Wqlp1BnxHD9lRKQF75V2MMtF0ejw61NOKJg2FuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794007141;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z1ONNz3Yox0M9i0uWl8SVQB1v87lOPRXC9TROiVxIKU=;
	b=JrjEEqCJCzS+KXaUovzlTo+++TTs8/WIBJzRooEM5L0p2BKBxtoAB8qjwuG0xrVLQNLa
	 YRRvkb0tlXBLbg8I/ql/oQ8E5MrAmpi/fWQF7PdVopxOYJV/lxXebeV4oPQ0B6H7DWT7x
	 o5zRPY+S721mkT+6Xl5wcJrCXrDbjIL3BNDBsYYwKMqvqNEuchqd7JzSwUQVM4ktnmxuY
	 pjqh77FGtj0toHfx943SFor8g85hbfV9FBY1IFJEFirnhk5NVBhkFZEEPa3RcCT0E5sZk
	 sVuUuQpCVzoQ4Oybv+moBEctWdiucusrrXR7cjSPt8eOVnH9wxcdJv5p9NMWwpOdwjw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc9XwYS6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF739606D823;
	Fri,  6 Nov 2026 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fc9XwYS6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794007140;
	b=DihIrlBiUGWSdzdBflubJz6cvxexI1Vk2kgxSBTeiZIX12G9OTenU/YKxCBxM+wkLD9X
	 peqNdwXhmHlaZsHuaNITTeDFCqKqie+WHua+Xi9VtJEc6uocoF/IX2NDI0fHhic4pKJHy
	 UxpV+Y6wpWP+Hl7nbiekQtEGSGgOV8tZk7fOjhfoLI/KrhHPbw1mKhOMH36w35Rja9C1v
	 cv746lmo3H+D9oYoa9MdjtIC//9JgWsEX3Vcfqu2zDaBbcmf364oPDusxhZPnbqEi9f9l
	 ACsXJMH75T6RLVlDRrfji8BuZ4nwWG6+u3T4DnTiNh7ZReGAXD9I8V7K5us2VPf/jMA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794007140;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Z1ONNz3Yox0M9i0uWl8SVQB1v87lOPRXC9TROiVxIKU=;
	b=L3AXHZ9qCgxId0JSQ91XNAnAuu0v7ySDf+z0L1Qv7b7EKv+XiJ+Ffkvko651xiAQoX+5
	 HeTQmgHke2i9YNXej5ya05qg1txLRjwipBT4I55XpDkmh06DU4lfCMh5EnS1CETQuaOc8
	 V6iYj1Nqi8uM4kmV0l0SkFs2DfQxwuEYFSblholpCxX/fURwb1a2Q23mr3vIDTZeC9b5z
	 Frdn3ltGCgsCCDr7A6QsGxDzwEkTcYBPXa/9231EZGdi37IOHzWYnzcwXdmyswpzfAjzS
	 gYIkjqMqSSBEHzbQFhdadJ/5eOpWSlGgjhUx2C9XgKwCblGOP3uSaeSI3FamhNoqWxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 803D71F008A2;
	Fri,  6 Nov 2026 23:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794007140;
	bh=Z1ONNz3Yox0M9i0uWl8SVQB1v87lOPRXC9TROiVxIKU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Fc9XwYS61bNmpCc2GdL0B6Fq8YOtZox9wDVguvy4JgzJXb2hpox4y4spI4Rn5zZrt
	 GOPzxynnkWXjLsGJBGdWkyQc2AoSQTrenQuRCwSODsXkffVz/7Fin8cjaMytojVZoz
	 creZunpxi83bKlH/mQxR/7ON2uTb3meAvn1E/sMfFizejvwHnOa23FE6LreKAoeg9K
	 19vx8r5vgXglyZS4fpd/uoNvA/cs+QXECVrnE1DkaOAFzcwBHM/Rr8OSxa5nqtojsp
	 EdQqpcrhjbgaEgeG9bYP3cMRe95Nxdia+RXdcoJUq2cxs5wOebUgc1ltiAaR++L+hM
	 qe2ra3EXNeIqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 75C1347900;
	Fri,  6 Nov 2026 23:18:55 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 06 Nov 2026 15:18:56 -0800
Subject: [PATCH net-next v10 10/11] net: phy: ncn26000: Support for
 onsemi's S2500 internal phy
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261106-s2500-mac-phy-support-v10-10-31b5a69b85b7@onsemi.com>
References: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
In-Reply-To: <20261106-s2500-mac-phy-support-v10-0-31b5a69b85b7@onsemi.com>
To: Selva Rajagopal <selvamani.rajagopal@onsemi.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Eric Dumazet <edumazet@kernel.org>, 
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Selva Rajagopal <Selvamani.Rajagopal@onsemi.com>, 
 netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jerry Ray <jerry.ray@microchip.com>, 
 Ciprian Regus <ciprian.regus@analog.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794007133; l=4594;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=a6i1DSX+QWaG4yVDRSCC7W4MiWjy4gjcKXsn35iGLEU=;
 b=vsYvrqv838y4FGG82+C4mx2zCqfwJgAIGcRzVzICvJirAq4hehCts6s6gukXPA3uglvmfzrtK
 Pp+ZCbbsX4rBXN5jwAEtLYo1Y2BmpHmJYlwpgvsJQYWkaNaH5ec+T2E
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Adding support for internal PHY of the integrated
media access controller S2500. PLCA tx opportunity timer's
default value is correct in this device, compared to
the currently supported PHY NCN26000.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v10
  - removed config_intr callback as PHY driver is in polled mode
changes in v9
  - Added Reviewed tag
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
 MAINTAINERS                |  1 +
 drivers/net/phy/ncn26000.c | 34 ++++++++++++++++++++++++++++++----
 2 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e8baabe5449..5f37a6f0fa3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20994,6 +20994,7 @@ F:	arch/mips/boot/dts/ralink/omega2p.dts
 
 ONSEMI ETHERNET PHY DRIVERS
 M:	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
+M:	Selva Rajagopal <selvamani.rajagopal@onsemi.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.onsemi.com
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index 6d433f4e2c45..0006e157917d 100644
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
@@ -41,13 +42,18 @@
 
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
@@ -139,8 +145,8 @@ static irqreturn_t ncn26000_handle_interrupt(struct phy_device *phydev)
 
 static int ncn26000_config_intr(struct phy_device *phydev)
 {
-	int ret;
 	u16 irqe;
+	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
 		// acknowledge IRQs
@@ -163,6 +169,24 @@ static int ncn26000_config_intr(struct phy_device *phydev)
 }
 
 static struct phy_driver ncn26000_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_S2500),
+		.name                  = "S2500",
+		.features              = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init           = ncn26000_config_init,
+		.config_aneg           = ncn26000_config_aneg,
+		.read_status           = ncn26000_read_status,
+		.set_plca_cfg          = ncn26000_c45_plca_set_cfg,
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
@@ -183,11 +207,13 @@ module_phy_driver(ncn26000_driver);
 
 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);
 
+MODULE_AUTHOR("Selva Rajagopal <selvamani.rajagopal@onsemi.com>");
 MODULE_AUTHOR("Piergiorgio Beruto");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");

-- 
2.43.0


