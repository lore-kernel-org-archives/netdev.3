Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.97.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793949707;
	b=Uv7f2BZfDjSoAo9mjTvrBkOhqslW40M6r9RbdX12vqs+ftTpaFHpLqHOO+jRaMhzhDaQ
	 gyJ7jBeDK0uZZEyDhmKUBJFvkV0AsB40+WckjaEnEUzGZzl9GpRgas3J6Ir3SJ4D4TK/k
	 D0T4Uk5eGAm3X71HKCeS80F1Ns9Rt4jbQwVmszxtCFuEW8y5QO1c9oGp5GR5Z7Gb0dY6h
	 Z03lUxZMOa7uOZHDLqGDyCVjBr+F1f3kpk6YRCPzptThr/Xx5Hxi/rNVHKco7GLbj02nd
	 VaYbGK50SzWn/x31YQL+Qar7Nt5m60qZmh7MtXfwwMOzIY46laqGDkj6M3XzPJggWMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793949707;
	h=DMARC-Filter:DKIM-Signature:Received:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=OQDRsImA156rX7VIn/voOldvBWRA4DJ8pwkA/7Q/W/E=;
	b=TH3ASw8XbwS53KaJWsYvqmP8Uj27IwNscGJ/gJphOK8gciLtjua2y5fPnokiNU13EIEO
	 phsbaGCcT4G3IyFm/Dl0F2obGxH4d0dqdeD/flYBif+uONqni+5tvN4nzV9KvNeiVSfjU
	 Gu5G9DAOtUnvGzI3BDSEVxNKzwfrkacbvC2I0vglOROgtV/dJ6Ldzd+Hscsdb4bXGaZbW
	 aHMiJNq6+lZ0hlzw0n+hLc2VZ4driE8Ee6i6OZ/4QyLzg1BwFbYxmmFIpYNSXaB+cUMTI
	 5PFnWlGPJVTFAVB+xaWfrCih2eoQOJEqciP3fePKDt7WAY366IkdE+YJ5CN/fCw6Q7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=birger-koblitz.de;
	spf=pass smtp.mailfrom=birger-koblitz.de;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=LgyABdUz;
	dkim=pass header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b="ksidgz/u";
	arc=none smtp.remote-ip=23.88.97.239
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4309B606EE82;
	Fri,  6 Nov 2026 07:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4309B606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=LgyABdUz;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.a=rsa-sha256 header.s=default header.b=ksidgz/u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949704;
	bh=s0cpwYkeVCb0kcjXGWJo938EgCbLt1S9id6R/cNC1e4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LgyABdUzZIUqNChzMop9eGcZ9g2fVFyT8msl6UYRyfcBslqMsbva5B2j11TRyyFMp
	 FD8sq/k7xfy8kS9CtyL2UHGTHKy921RNnAvmAphAiDIqHbFvEgHfZxs0C7oDUQbYVO
	 jQ8PbMGfzMIwBapNpp84ErVqtu6HIpbWzii4uufNBs1Kv4qIqBEjBPrHPmTsnQsgDS
	 b3v9Vt6nWUrEeA3eygsTIJKzkos+jKcSW5hrTJc+msbC4UPr1Ye5+wiGdikq7Cy98A
	 rV2MS8uuwfs/ASQsGd4qdhb63saEdqX+8PBPT8ih2oS39hD9YahyhdzV1f4A2SyeqN
	 yARBINoyfygTg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id CC20B48BAB; Fri,  6 Nov 2026 07:21:44 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1793949689;
	bh=s0cpwYkeVCb0kcjXGWJo938EgCbLt1S9id6R/cNC1e4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ksidgz/u28p9HV803UPTVgrfb1ZM+2TviIEYSJJAyUi+QZR0QeCSUbrrj6+5h38QB
	 CI6x0fXOB/9MqaPHRsFMYTafS5uOdlk9XDc4ZEtwMfY2cs4JlCspF/IeEexTgcytGw
	 1ClL6AV04w4kuS/tWQI4Q6ywEQ2l2c30baHeWfWuXI6EQ6689GASdmQLW10pgnX/NK
	 oYV6qsSoqrZMOImstkDxdLW+SPo517GKvnrzbv3Wwb8c7nFg/h19qQ2QVuzBCODMVr
	 MwHnTseBiHTHCLnYlKk7obsOpbgN7B5+QdV9ePfh2lpAwjM4M52Pe+uPjOevCxWGbG
	 MvYvr8SXVHMew==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 84B4E48B8B;
	Fri,  6 Nov 2026 07:21:29 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Fri, 06 Nov 2026 08:21:28 +0100
Subject: [PATCH net-next v20 13/13] ax88796b: Add support for AX88772D,
 AX88179A and AX88279
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ax88179a-v20-13-37b5a1189983@birger-koblitz.de>
References: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
In-Reply-To: <20261106-ax88179a-v20-0-37b5a1189983@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Emir Beganovic <beganovic.emir@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>
X-Mailer: b4 0.14.2

The AX88772D, AX88179A and AX88279 are 100MBit, 1GBit and respectively
2.5 GBit PHYs that are found in ASIX USB-Ethernet controllers of the
same name.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/ax88796b.c | 165 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
index f20ddf64914993f7097070d1f56c1103ec1e40e8..0df44e0e236abb02e16cb7885d0c743f0a2c501d 100644
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
@@ -83,6 +96,107 @@ static int asix_ax88772a_read_status(struct phy_device *phydev)
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
+	if (!phydev->link)
+		return 0;
+
+	/* Read actual speed from vendor register */
+	val = phy_read(phydev, AX_CTRL_STATUS);
+	if (val < 0)
+		return val;
+
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
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->lp_advertising);
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
+	adv_2500 = linkmode_test_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, phydev->advertising);
+	ret = phy_modify_changed(phydev, MII_ADVERTISE, AX_ADVERTISE_2500,
+				 adv_2500 ? AX_ADVERTISE_2500 : 0);
+	if (ret < 0)
+		return ret;
+
+	return __genphy_config_aneg(phydev, (ret == 1));
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
@@ -94,6 +208,25 @@ static void asix_ax88772a_link_change_notify(struct phy_device *phydev)
 	}
 }
 
+static int asix_ax88772D_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	/* MDIO_DEVS1/2 empty, so set mmds_present bits to allow reading abilities */
+	phydev->c45_ids.mmds_present |= MDIO_DEVS_PMAPMD | MDIO_DEVS_AN;
+
+	ret = genphy_read_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* AX88772D does not support (possibly) reported 1000baseT modes */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, phydev->supported);
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, phydev->supported);
+
+	return 0;
+}
+
 static struct phy_driver asix_driver[] = {
 {
 	PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772A),
@@ -111,6 +244,35 @@ static struct phy_driver asix_driver[] = {
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
@@ -124,6 +286,9 @@ static const struct mdio_device_id __maybe_unused asix_tbl[] = {
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

