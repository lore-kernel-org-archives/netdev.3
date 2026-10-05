Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678137F315;
	Mon,  5 Oct 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231825; cv=none; b=Eaki83n+AcTEJWEm3AFbHTG30kQOeQV3mZrfotJcBHE3+mJCWuKtd2QqQERRlegrqH1jIwH4WM0kG0DNvEndWXGMlaifBRuQ1KiZhZgQBX8s5qPxMTH8ue04VINOgu+nW4MbuXFPTJhywfy78nvbyzvSX/9pg8FjSJrikjQAJQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231825; c=relaxed/simple;
	bh=89sofIcNTgVT385DSHgi0C6SE9AGj2Zgb5fRhg3LUQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZrZ+Od2wh4kfCIgaz8E+KyTJ+emly/51xPogGsb+o/2mA7otIy/4fdnKF+Ud4XqDccmI+7rGCgXowDZYN1Cl1Pdkb4K40OeQzuPnFmHjKSvMqqyVIKrF0gKchdjFdc5HiDlHP/XlsiWU5YCxEZtKORr/0QwNVVdm3E10n/fWbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id AB4A920F0A;
	Mon,  5 Oct 2026 20:17:26 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id sJ1HkoharcWx; Mon,  5 Oct 2026 20:17:26 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id 36C281FD40;
	Mon,  5 Oct 2026 20:17:25 +0000 (UTC)
From: Oskari Lemmela <oskari@lemmela.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Javen Xu <javen_xu@realsil.com.cn>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Issam Hamdi <ih@simonwunderlich.de>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Jan Hoffmann <jan@3e8.eu>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manuel Stocker <mensi@mensi.ch>,
	Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH net-next v2 2/2] net: phy: realtek: support unaligned RTL8224 PHY packages
Date: Mon,  5 Oct 2026 23:15:40 +0300
Message-ID: <20261005201540.913977-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005201540.913977-1-oskari@lemmela.net>
References: <20261005201540.913977-1-oskari@lemmela.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Stocker <mensi@mensi.ch>

The RTL8224 driver groups its four ports by rounding each PHY address
down to a multiple of four and uses the low two address bits as the
port index. This assumes that the first port's MDIO address is aligned
to a multiple of four.

The Hasivo S1100WP-8GT-2S+ uses two RTL8224 packages at MDIO addresses
1-4 and 5-8. Extend the driver to support such configurations by using
the base address from an ethernet-phy-package node when present and
calculating each port's offset relative to that address.

Use the package-relative port index to select the MDI pair order and
polarity fields. Reject PHY addresses outside the four-port package
and propagate explicit package errors rather than falling back to
another base address.

Keep the existing aligned-address assumption when no package node
is present.

Signed-off-by: Manuel Stocker <mensi@mensi.ch>
[Oskari: rebased on net-next/main, reworded commit message]
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/net/phy/realtek/realtek_main.c | 49 +++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index e14960192e79..91cf34d13420 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -355,6 +355,10 @@ struct rtl821x_priv {
 	u16 iner;
 };
 
+struct rtl8224_priv {
+	u8 port_offset;
+};
+
 struct rtl8261x_priv {
 	const char *fw_name;
 	u32 fw_sub_magic;
@@ -2723,7 +2727,8 @@ static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
 static int rtl8224_mdi_config_order(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	u8 port_offset = phydev->mdio.addr & 3;
+	struct rtl8224_priv *priv = phydev->priv;
+	u8 port_offset = priv->port_offset;
 	u32 order = 0;
 	int ret;
 
@@ -2748,7 +2753,8 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	u8 offset = (phydev->mdio.addr & 3) * 4;
+	struct rtl8224_priv *priv = phydev->priv;
+	u8 offset = priv->port_offset * 4;
 	u32 polarity = 0;
 	int ret;
 
@@ -2783,9 +2789,42 @@ static int rtl8224_config_init(struct phy_device *phydev)
 
 static int rtl8224_probe(struct phy_device *phydev)
 {
-	/* Chip exposes 4 ports, join all of them in the same package */
-	return devm_phy_package_join(&phydev->mdio.dev, phydev,
-				     phydev->mdio.addr & ~3, 0);
+	struct device *dev = &phydev->mdio.dev;
+	u32 base_addr = phydev->mdio.addr & ~3;
+	struct rtl8224_priv *priv;
+	struct device_node *np;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	np = of_get_parent(dev->of_node);
+	if (of_node_name_eq(np, "ethernet-phy-package")) {
+		ret = of_property_read_u32(np, "reg", &base_addr);
+		of_node_put(np);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing or invalid PHY package reg\n");
+
+		if (phydev->mdio.addr < base_addr ||
+		    phydev->mdio.addr - base_addr >= 4)
+			return dev_err_probe(dev, -EINVAL,
+					     "PHY address outside RTL8224 package\n");
+
+		ret = devm_of_phy_package_join(dev, phydev, 0);
+	} else {
+		of_node_put(np);
+		/* Without a package node, assume four aligned PHY addresses. */
+		ret = devm_phy_package_join(dev, phydev, base_addr, 0);
+	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to join PHY package\n");
+
+	priv->port_offset = phydev->mdio.addr - base_addr;
+	phydev->priv = priv;
+
+	return 0;
 }
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
-- 
2.55.0

