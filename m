Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A464C44D015;
	Fri, 31 Jul 2026 16:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785514777; cv=none; b=V3f/1suskXizGo8/YH3A2EydNgdqJm4PE0dTQInVz/5lqXKPRAAlcWL2W1FNRSpjhnvJ+guNM7nys6NP1k2yEibIE9KxWuHo3m0UNnVOctstlrdxHpMVy07eAKWRtR7mwLdC1mlDlwTJLUlvZV00WReLiTqbgmojVrMy2vSYRXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785514777; c=relaxed/simple;
	bh=LYDpLwNooFFmU/VU5Ml5Zld0cdi5efNeuMTFMCkLcqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=St1wPD94Q+zhPhlUfh3ikYHHz/fCNMKySjuU+p6ihZe4RRZR3EN6BYOkKg5s6+ZtUFPl672sDHtxwAJPDGWf3Uo8tyKsXQllkui3Sof8oAPynHlAuRQYVCp+zxk81MHYknECfo9xZlrXX7ul1Xcrr8i4jHC9Hsk/Iwu9iWe9VrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=MbSK/E5K; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vUhYrVa7; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="MbSK/E5K";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vUhYrVa7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514760;
	bh=LYDpLwNooFFmU/VU5Ml5Zld0cdi5efNeuMTFMCkLcqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MbSK/E5Ky0oepOccmtl3GghLoLALDUWEkJ1Tp+l+VFddhocgjZiJeNE/s4L0Y57Mw
	 Z4liUJ1E+BQRjsLDWBeGciIKiwd67DZlRcKk4Qi1k9ggcPIACsUnggKLhpC1QfxOPm
	 /vsWVRIrsSkBk0uSq2nyHGaoSTpbd1VG2e3tAVb183SRL0JwGxfw/n8QyXzJaa9O1U
	 gBrXNqDs9Twb1Yc99C3xSlBsI9KkGmrUF9h3uQ8JY38Wul7hZIkId1WLPK6p318mIs
	 DUPaFY/12uzTHZERSIyeTcZcmVrLg6XlM0I6FVDsOsS9MXlp3K0cYDRy+Kutpe5uc7
	 6zVLgU/MYslOQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5C40E494FE; Fri, 31 Jul 2026 16:19:20 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785514747;
	bh=LYDpLwNooFFmU/VU5Ml5Zld0cdi5efNeuMTFMCkLcqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vUhYrVa7RcBo78akfeO8QsQOrk5IFayUsil5chiOZJ3jyzNOGY4x3xeBxutfFjqVm
	 mBKsg7303KXZrgZzzyKbeng2RxpqdSjhGLRukp+knuaAJ5oT5HWfKlAiswelIBiSDI
	 KHLDY/FZevve8p8lMFf+6EqK/t8dcAUhTXDhnZk0jEyDscCAM79l/kEnakaphynx5z
	 zejm8cpiHerCKulEusPskWyfx6Tfy2IxhUO/6jLJx+mHajfoC7y4t9FJUpHZwaxKnL
	 HXjKbRVrN24rV5NU3j+4BmjHKCkSaedo9AYVufcOnXkQmvj0lEKvsyb2Wkwg2kltrK
	 VUnIaF7Gul/NA==
Received: from ThinkPadAMD.lan (unknown [82.99.30.195])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0AC9A494F7;
	Fri, 31 Jul 2026 16:19:07 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 31 Jul 2026 18:19:12 +0200
Subject: [PATCH net-next v4 12/12] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ax88179a-v4-12-2cf1f71b1dd2@birger-koblitz.de>
References: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
In-Reply-To: <20260731-ax88179a-v4-0-2cf1f71b1dd2@birger-koblitz.de>
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
---
 drivers/net/phy/ax88796b.c | 192 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
index f20ddf64914993f7097070d1f56c1103ec1e40e8..686f4e8d08f74da98e453ea50a5347cf3673e869 100644
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
@@ -83,6 +96,135 @@ static int asix_ax88772a_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int asix_ax88279_read_status(struct phy_device *phydev)
+{
+	int ret, val;
+
+	ret = genphy_update_link(phydev);
+	if (ret)
+		return ret;
+
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNSUPPORTED;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNSUPPORTED;
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+	phydev->rate_matching = RATE_MATCH_PAUSE;
+
+	if (!phydev->link)
+		return 0;
+
+	ret = genphy_read_master_slave(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = genphy_read_lpa(phydev);
+	if (ret < 0)
+		return ret;
+
+	val = phy_read(phydev, MII_ADVERTISE);
+	if (val < 0)
+		return val;
+
+	linkmode_mod_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
+			 phydev->advertising, val & AX_ADVERTISE_2500);
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
+	return 0;
+}
+
+static int asix_ax88279_config_aneg(struct phy_device *phydev)
+{
+	bool changed = false;
+	int ret;
+	u32 adv;
+
+	if (phydev->autoneg == AUTONEG_DISABLE) {
+		phydev_warn(phydev, "Disabling autoneg is not supported\n");
+		return -EINVAL;
+	}
+
+	adv = linkmode_adv_to_mii_10gbt_adv_t(phydev->advertising);
+
+	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_AN, MDIO_AN_10GBT_CTRL,
+				     MDIO_AN_10GBT_CTRL_ADV2_5G, adv);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		changed = true;
+
+	return __genphy_config_aneg(phydev, changed);
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
+/* AX88179A-based PHYs cannot access MMD registers via MII_MMD_CTRL/MII_MMD_DATA
+ * Make sure to use c45 access instead.
+ */
+static int asix_read_mmd(struct phy_device *phydev, int devnum, u16 reg)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_read(bus, addr, devnum, reg);
+}
+
+static int asix_write_mmd(struct phy_device *phydev, int devnum, u16 reg, u16 val)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int addr = phydev->mdio.addr;
+
+	return __mdiobus_c45_write(bus, addr, devnum, reg, val);
+}
+
 static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
 {
 	/* Reset PHY, otherwise MII_LPA will provide outdated information.
@@ -94,6 +236,25 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
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
@@ -111,6 +272,34 @@ static struct phy_driver asix_driver[] = {
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
 	.soft_reset	= asix_soft_reset,
+}, {
+	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772D),
+	.name		= "Asix Electronics AX88772D",
+	.flags		= PHY_IS_INTERNAL,
+	.get_features	= asix_ax88772D_get_features,
+	.read_mmd	= asix_read_mmd,
+	.write_mmd	= asix_write_mmd,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+}, {
+	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88179A),
+	.name		= "Asix Electronics AX88179A",
+	.flags		= PHY_IS_INTERNAL,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+	.read_mmd	= asix_read_mmd,
+	.write_mmd	= asix_write_mmd,
+}, {
+	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88279),
+	.name		= "Asix Electronics AX88279",
+	.flags		= PHY_IS_INTERNAL,
+	.get_features	= asix_ax88279_get_features,
+	.read_status	= asix_ax88279_read_status,
+	.config_aneg	= asix_ax88279_config_aneg,
+	.read_mmd	= asix_read_mmd,
+	.write_mmd	= asix_write_mmd,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_ASIX_AX88796B),
 	.name		= "Asix Electronics AX88796B",
@@ -124,6 +313,9 @@ static const struct mdio_device_id __maybe_unused asix_tbl[] = {
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

