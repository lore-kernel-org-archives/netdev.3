Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794589174;
	b=cYJlVPMqVN1xmTeOyAHLYc8kWkfy2w7/nUqOrv58zILkskkzq+Lt8RUyiD+RnYDBndjV
	 nu35Ekzq1gFR/lUXGsMo7tRi13Lwal3U/0y0TpeDDpkwVxWkaPhg9FiGNI0Qj+l0mPiTb
	 dtk08CIH5bvwIADdNbGQg+Fb4K670wOrGtgrVL4grukE5PIsjN/O5vkj69ww9/iYHhLcS
	 hAEj++X+qWhOeG3UA6UJdbtzzeQv4NvrsEydXt5kDStCuYK0jg1GMlzmYgUHJAyRGk+dm
	 vws9/j+vYPSnSvNCkVd43XcfHtesrmziikeDq9+1TOSsLHch14HDkthslAp498vKYsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589174;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sjpyRsjmJuINV/5HQtnTmas3AUQkeXhnc/NmghOouLs=;
	b=azOt+cpwWIBQpCgawNujWvLU0jPS45MLyZJhTdcOwW4SREN54MjQP3xIcoBCN3TxcpIY
	 mwMwi9ZWvbg9Tq56cCN7XWFMXipao6uCVEZcisdJZMm9i5szDvm2uklRdgo79VItMER+d
	 mUov0ZzwmQW9YCxwG2x3JRLbsd5FfNPx0vrWLm1+n6iBkFPsQxx0+CykYXsFNhcWSsNhG
	 YL59sae0vdChRLVvafSl96IMuRLAUNZLoI8lvYdOdejJMCc73LLam1Uy0GqZre/8vRfQk
	 e2zBSfgBzG+tTku9upK9RwB+Njx8Gv60578pyU4/S4KfvJsNIIcK5Kvvuxm+KQwk6zg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnc7H6zz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B909C60A3826;
	Fri, 13 Nov 2026 16:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnc7H6zz
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794589174;
	b=ItnInTEAtBKHxsC/KZSt9sgmZ8YICJHuUL9V00LuNAbylRfBXZFHwqTPC3ZxnpDe8Luf
	 mVIyjiQuJPf6hcFrkpidak8M7ycBi3uM3BqyOYH1LKZyqmDRBAUC/I7bEazh+hzohpjDy
	 nLRamSoe9rMIOfKLirBABW89eShQtb4+5TwKyDRA4d1I7H3ElaO84YpJP54XrIZ4u8M2k
	 pk2wFUgA1GhcW+M+10nZGdnyiatrwzlavt+n+GhO+H/AFoA+VbISI3epPlqKTbbRWlB3h
	 MyM3/F88zHtZlZwuzKU2siLxj6GEsziL3ZGqa0lO886TtOV9ZcznWXc6lWsDQxuM7Wg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794589174;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sjpyRsjmJuINV/5HQtnTmas3AUQkeXhnc/NmghOouLs=;
	b=P10iZ6vK2jeMS+azUPRxDkI4UnDx9/xi0HwkGexExLFSY3A4gO7VIcudKxde7cOEVfqB
	 Bn7U4ZFSGgix1hgPnLzvWQhE4tEp1b9E99RVd1HvcCvHN3wqzw9UatmoBubHWtHMTMJKs
	 7QD1+H+D+KNsoMVhCSkqju/l4oELjlfeokwebcX2vyxQ0Il+sWg0RxVyduspBaJMfexdT
	 nB0JyUXfJzjOr7vA8LQnpEP0IhSxElfqIoYeXbmnTU02vNlevw0g8YEHpBtHE22/Nkzyf
	 5WdvIXwTOAkcuqYi23c6/U/plZRIZS34vpzxVfffm8h3ljbL+pLiuyWggKB+G4BsqaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 14BE21F00937;
	Fri, 13 Nov 2026 16:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589174;
	bh=sjpyRsjmJuINV/5HQtnTmas3AUQkeXhnc/NmghOouLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fnc7H6zz5jjOhJQ1x2C4TaTlocUvLqhxZwzz6bNAXAWYqSHatgkmQORaNnA1PbGNV
	 2cKnk01MxfVHDa8fBdKWCy+1VQ7QbmZzBAB0Cui6PhyWNtdWtpWNPSMzxy+shoOJGy
	 ABjKttmVYp9uQhzroedrskcLIowLeE3GkguV6vx6qonCt/syP89U7lCiUpJ/8NtvSi
	 YIB0xkALRkQvbpKAzNQ1L4/wbJXnzGdrzplOKV9XIt79asSnPxZBXI/RgOR5uO6ioD
	 SYUZ7ZvQD/quaXpgPsGsIqIHPT9CMOcWBDXA452d72rOizyXHN7kCBJNTFBlrjUAwq
	 1keph0W3rACUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0FEE049A3F;
	Fri, 13 Nov 2026 16:59:30 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Fri, 13 Nov 2026 08:59:32 -0800
Subject: [PATCH net-next v11 13/14] net: phy: ncn26000: Support for
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
Message-Id: <20261113-s2500-mac-phy-support-v11-13-7a186141952c@onsemi.com>
References: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
In-Reply-To: <20261113-s2500-mac-phy-support-v11-0-7a186141952c@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794589162; l=6216;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=eNZtNTzA+zfsluvB/d2CgKml8D7BQRin83kl7tYthuk=;
 b=oEYT3ON6XSGZnmeecmB5Q7tAAbKFu105Twdqaf4CNokg90wEpOKRiZSoWNxSmIJrd/omZBb1w
 78kOnM+UEUMCqecX8nDv5r/uv1EbDYKimXWLdWhIaywxc8S8wqn1sVZ
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com
Content-Transfer-Encoding: 7bit

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Add support for internal PHY of the integrated media access
controller S2500. PLCA tx opportunity timer's default value
is correct in this device, compared to the currently supported
PHY NCN26000.

The S2500 entry additionally supports SQI reporting, OATC14 cable
testing and loopback, and enables direct Clause 45 MMD access. The
S2500 entry works in polled mode only.

S2500 uses its own config_aneg that sets BMCR_ANENABLE without
affecting other bits in BMCR register. Also this keeps NCN26000
behavior unchanged.

Also add S2500 support to the Kconfig help text, add a MAINTAINERS
entry and a MODULE_AUTHOR line.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v11
  - Copyright year changed from 2022 to 2022-2026
    Previous patch had 2026 only.
  - Added more information in commit message
  - s2500 has its own config_aneg so that it won't cause any
    change in behavior to ncn26000.
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
   added new PHY support in a separate patch
   changed model comparison to use phy_id_compare_model
changes in v2
   Removed bug fixes. Retained only S2500 specific changes
changes in v1
   Added support for an internal PHY of onsemi's MAC-PHY S2500
---
 MAINTAINERS                |  1 +
 drivers/net/phy/Kconfig    |  2 +-
 drivers/net/phy/ncn26000.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5ac39026ef2..78f5de606df0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21008,6 +21008,7 @@ F:	arch/mips/boot/dts/ralink/omega2p.dts
 
 ONSEMI ETHERNET PHY DRIVERS
 M:	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
+M:	Selvamani Rajagopal <selvamani.rajagopal@onsemi.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 W:	http://www.onsemi.com
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 30e9d22c8d1a..cff58dbe391d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -396,7 +396,7 @@ config NCN26000_PHY
 	help
 	  Adds support for the onsemi 10BASE-T1S Ethernet PHY.
 	  Currently supports the NCN26000 10BASE-T1S Industrial PHY
-	  with MII interface.
+	  with MII interface and the S2500 10BASE-T1S PHY.
 
 source "drivers/net/phy/qcom/Kconfig"
 
diff --git a/drivers/net/phy/ncn26000.c b/drivers/net/phy/ncn26000.c
index 888d74b83125..0e2c978b73d4 100644
--- a/drivers/net/phy/ncn26000.c
+++ b/drivers/net/phy/ncn26000.c
@@ -2,7 +2,7 @@
 /*
  *  Driver for the onsemi 10BASE-T1S NCN26000 PHYs family.
  *
- * Copyright 2022 onsemi
+ * Copyright 2022-2026 onsemi
  */
 #include <linux/kernel.h>
 #include <linux/bitfield.h>
@@ -14,6 +14,7 @@
 
 #include "mdio-open-alliance.h"
 
+#define PHY_ID_S2500			0x180FF411
 #define PHY_ID_NCN26000			0x180FF5A1
 
 #define NCN26000_REG_IRQ_CTL            16
@@ -40,13 +41,18 @@
 
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
@@ -62,6 +68,17 @@ static int ncn26000_config_aneg(struct phy_device *phydev)
 	return phy_write(phydev, MII_BMCR, NCN26000_BCMR_LINK_CTRL_BIT);
 }
 
+/* Kept separate to leave ncn26000_config_aneg() unchanged. BMCR is
+ * modified instead of overwritten, to keep loopback enabled.
+ */
+static int s2500_config_aneg(struct phy_device *phydev)
+{
+	phydev->mdix_ctrl = ETH_TP_MDI_AUTO;
+	phydev->mdix = ETH_TP_MDI;
+
+	return phy_set_bits(phydev, MII_BMCR, NCN26000_BCMR_LINK_CTRL_BIT);
+}
+
 static int ncn26000_read_status(struct phy_device *phydev)
 {
 	/* The NCN26000 reports NCN26000_LINK_STATUS_BIT if the link status of
@@ -162,6 +179,25 @@ static int ncn26000_config_intr(struct phy_device *phydev)
 }
 
 static struct phy_driver ncn26000_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_S2500),
+		.name                  = "S2500",
+		.features              = PHY_BASIC_T1S_P2MP_FEATURES,
+		.config_init           = ncn26000_config_init,
+		.config_aneg           = s2500_config_aneg,
+		.read_status           = ncn26000_read_status,
+		.set_loopback          = genphy_loopback_no_speed,
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
@@ -182,11 +218,13 @@ module_phy_driver(ncn26000_driver);
 
 static const struct mdio_device_id __maybe_unused ncn26000_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_NCN26000) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_S2500) },
 	{ }
 };
 
 MODULE_DEVICE_TABLE(mdio, ncn26000_tbl);
 
+MODULE_AUTHOR("Selvamani Rajagopal <selvamani.rajagopal@onsemi.com>");
 MODULE_AUTHOR("Piergiorgio Beruto");
 MODULE_DESCRIPTION("onsemi 10BASE-T1S PHY driver");
 MODULE_LICENSE("Dual BSD/GPL");

-- 
2.43.0


