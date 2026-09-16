Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131243BD25E;
	Wed, 16 Sep 2026 03:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529134; cv=none; b=uIgwysSGo+tgbIpXCO5Ms3r47nxSeD9zPC59VYxd79SMDdXXjT49oKjvtqFWq2nifq3VOS2tBsZ74NO/AIYmaB0mEfVmR6rUZPR7GqLvf9akRom5M4gQtxePb9fzNYmjMNzrwnaFRzvLGlcrRS53TxEdDuDQPAHya773FTpmyFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529134; c=relaxed/simple;
	bh=th9j8IMz7cxt9OCRiUZdYPhFqg5LPYWjI6IEu1Zq3NM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rYhS5l1atHKijfy4uMcgAsuXHT6GS2yR9kiU22J7hXn6M/O/+8fWJt6NVdH609BlLd5EvHGG7CW5fvOkkJKdhGNmTPytwWROOogoN9+ca/jlqLgp3V5dIs02591ukoLu5izkN63OU6DpiSugiWymVJ+1/FfRmuXidyFvPkq6Ye0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=AaejxEiS; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Sb+soTQx; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="AaejxEiS";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Sb+soTQx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529131;
	bh=th9j8IMz7cxt9OCRiUZdYPhFqg5LPYWjI6IEu1Zq3NM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AaejxEiSEHQPM4dW2+t7dGZkaV46sL10kD3xNKIGBepFpnPcGvtWP8r3LYx62wS1I
	 wlz6B4wcl4pjzXkcYXm4dzeT6U4zqT6ht0EN/IiA/59331MwlqkfwD0fYcPAtW7zIi
	 5FC4oJm7J27VXlDYkTm8YgS0awJhtsKJAn1kCA6tPjtU/qKPB/6g1/R3MLMAgHpZ6U
	 SvVAI80gmbwNoFmXJTfHRUMjDbtu6Xz6u/XdQEzN6QpYi0ws+bbbxVwLFsoO8//RuC
	 i/9avk3E/PM06kORne4xJ+MvkWsvVYdbYQzZ/U+3ISluyJ7YBoQhDHSqn6JXpbA67D
	 ggz+QGgpt0mhQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 3C56A3FA72; Wed, 16 Sep 2026 03:25:31 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1789529128;
	bh=th9j8IMz7cxt9OCRiUZdYPhFqg5LPYWjI6IEu1Zq3NM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Sb+soTQxZybCoFQW/agNm3FA5AZCBK3CXKoLJjhowdM5rKOgbyqglYxspubAaoJ5m
	 hC9h8aXENkmtf4WiwVpReRQrGJpp9KjllMFgO4ztsUvwWn0c24leFdRfrmi0SZTyA7
	 N5pxOlXM8kIkJIkwMT4+AvM/EaoSB4LFrI/hTw+YjM8gZbg9x/BL2aoLVttbpy3tPQ
	 +Fsb8S682TWqZKKxxgiH1ILHfffPRb2W1jnsUaQVB/IqWQDq942QLqJNk/sK9LLfMx
	 D2lSKUJCABC9ApxHcTBvEi01wFKzXekkupqZAR+pVhLs3s/PB6FXBSwr39SvXrMTCx
	 itpKQrp5b5ldw==
Received: from DELLLaptop.net (unknown [223.86.26.228])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8EA363FA6C;
	Wed, 16 Sep 2026 03:25:24 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Wed, 16 Sep 2026 05:24:14 +0200
Subject: [PATCH net-next v12 15/15] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ax88179a-v12-15-60c04c9924a2@birger-koblitz.de>
References: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
In-Reply-To: <20260916-ax88179a-v12-0-60c04c9924a2@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Birger Koblitz <mail@birger-koblitz.de>, 
 Jianhui Xu <neuromoments@gmail.com>
X-Mailer: b4 0.14.2

The AX88772D, AX88179A and AX88279 are 100MBit, 1GBit and respectively
2.5 GBit PHYs that are found in ASIX USB-Ethernet controllers of the
same name.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/ax88796b.c | 161 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
index f20ddf64914993f7097070d1f56c1103ec1e40e8..62f6beb25f41e703dc02add7358917d59ac8f2ac 100644
--- a/drivers/net/phy/ax88796b.c
+++ b/drivers/net/phy/ax88796b.c
@@ -13,6 +13,19 @@
 #define PHY_ID_ASIX_AX88772A		0x003b1861
 #define PHY_ID_ASIX_AX88772C		0x003b1881
 #define PHY_ID_ASIX_AX88796B		0x003b1841
+#define PHY_ID_ASIX_AX88772D		0x003b772d
+#define PHY_ID_ASIX_AX88179A		0x003b179a
+#define PHY_ID_ASIX_AX88279		0x003b2790
+
+#define AX_ADVERTISE_2500		0x1000
+
+/* MII Vendor registers */
+#define AX_CTRL_STATUS			0x1d
+#define AX_CTRL_STATUS_SPEED_MASK	0x0c
+#define   AX_CTRL_STATUS_SPEED_10	0x0
+#define   AX_CTRL_STATUS_SPEED_100	0x4
+#define   AX_CTRL_STATUS_SPEED_1000	0x8
+#define   AX_CTRL_STATUS_SPEED_2500	0xc
 
 MODULE_DESCRIPTION("Asix PHY driver");
 MODULE_AUTHOR("Michael Schmitz <schmitzmic@gmail.com>");
@@ -83,6 +96,103 @@ static int asix_ax88772a_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int asix_ax88279_read_status(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = genphy_read_status(phydev);
+	if (ret)
+		return ret;
+
+	/* Read actual speed from vendor register */
+	val = phy_read(phydev, AX_CTRL_STATUS);
+	switch (val & AX_CTRL_STATUS_SPEED_MASK) {
+	case AX_CTRL_STATUS_SPEED_2500:
+		phydev->speed = SPEED_2500;
+		break;
+	case AX_CTRL_STATUS_SPEED_1000:
+		phydev->speed = SPEED_1000;
+		break;
+	case AX_CTRL_STATUS_SPEED_100:
+		phydev->speed = SPEED_100;
+		break;
+	case AX_CTRL_STATUS_SPEED_10:
+		phydev->speed = SPEED_10;
+	}
+
+	/* MDIO_AN_10GBT_STAT_LP2_5G is broken, but we can deduce that
+	 * the link-partner advertised 2500M if remotely AN succceded
+	 * for link speed > 1000M and we locally have a link speed of
+	 * 2500M
+	 */
+	val = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_STAT);
+	if (val >= 0 && val & MDIO_AN_10GBT_STAT_REMOK) {
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+				 phydev->lp_advertising,
+				 phydev->speed == SPEED_2500);
+	}
+	/* Only supports full duplex */
+	phydev->duplex = DUPLEX_FULL;
+
+	/* PHY switches interface between 2.5GBit and slower modes */
+	if (phydev->speed == SPEED_2500)
+		phydev->interface = PHY_INTERFACE_MODE_2500BASEX;
+	else
+		phydev->interface = PHY_INTERFACE_MODE_SGMII;
+
+	return 0;
+}
+
+static int asix_ax88279_config_aneg(struct phy_device *phydev)
+{
+	bool adv_2500;
+	int ret;
+
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		phydev_warn(phydev, "Disabling autoneg is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
+	ret = genphy_config_aneg(phydev);
+
+	if (ret < 0)
+		return ret;
+
+	adv_2500 = linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising);
+	ret = phy_modify(phydev, MII_ADVERTISE, AX_ADVERTISE_2500,
+			 adv_2500 ? AX_ADVERTISE_2500 : 0);
+
+	return ret;
+}
+
+static int asix_ax88279_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
+	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+
+	linkmode_set_bit_array(phy_basic_ports_array, ARRAY_SIZE(phy_basic_ports_array),
+			       phydev->supported);
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* AX88279 does not support reported 100baseT-half duplex mode */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, phydev->supported);
+
+	return 0;
+}
+
+static int asix_ax88279_config_init(struct phy_device *phydev)
+{
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces);
+
+	return 0;
+}
+
 static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
 {
 	/* Reset PHY, otherwise MII_LPA will provide outdated information.
@@ -94,6 +204,25 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
 	}
 }
 
+static int asix_ax88772D_get_features(struct phy_device *phydev)
+{
+	int ret;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(mask) = {};
+
+	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
+	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* AX88772D does not support reported 1000baseT mode */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, mask);
+	linkmode_andnot(phydev->supported, phydev->supported, mask);
+
+	return 0;
+}
+
 static struct phy_driver asix_driver[] = {
 {
 	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772A),
@@ -111,6 +240,35 @@ static struct phy_driver asix_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 	.soft_reset	= asix_soft_reset,
+}, {
+	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772D),
+	.name		= "Asix Electronics AX88772D",
+	.flags		= PHY_IS_INTERNAL,
+	.get_features	= asix_ax88772D_get_features,
+	.read_mmd	= genphy_read_mmd_c45,
+	.write_mmd	= genphy_write_mmd_c45,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+}, {
+	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88179A),
+	.name		= "Asix Electronics AX88179A",
+	.flags		= PHY_IS_INTERNAL,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+	.read_mmd	= genphy_read_mmd_c45,
+	.write_mmd	= genphy_write_mmd_c45,
+}, {
+	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88279),
+	.name		= "Asix Electronics AX88279",
+	.flags		= PHY_IS_INTERNAL | PHY_BROKEN_FORCED,
+	.get_features	= asix_ax88279_get_features,
+	.read_status	= asix_ax88279_read_status,
+	.config_aneg	= asix_ax88279_config_aneg,
+	.config_init	= asix_ax88279_config_init,
+	.read_mmd	= genphy_read_mmd_c45,
+	.write_mmd	= genphy_write_mmd_c45,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_ASIX_AX88796B),
 	.name		= "Asix Electronics AX88796B",
@@ -124,6 +282,9 @@ static const struct mdio_device_id __maybe_unused asix_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772A) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772C) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_ASIX_AX88796B) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772D) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88179A) },
+	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88279) },
 	{ }
 };
 

-- 
2.47.3

