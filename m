Received: from mail2.kuutio.org (mail2.kuutio.org [91.107.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC845539771;
	Tue, 13 Oct 2026 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.107.195.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791917815; cv=none; b=W7EhXf37Ktu9zJ3Av6cFbL5Swd5PMkOIfV2bLvcfPBj2BQpPkk5e7UZoeCuqn9GLzTw8w45eYoxm+vz9TyCFU6Pg1jNlPoa+y0unoHvy0s6PkwCImAtYjnoCyw/zirlgKXARZ450ymoFBA6vW3+7pPyjWeK7yklmUzKk/vIlz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791917815; c=relaxed/simple;
	bh=3Z5wkhQuIMxIlRf3AAcqX8yHNgmJO0wIvtgXyDkrwKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvzwGmGkUXNSgR7x7BzBK0l6UWMd/IX7p3zwmut+N/ms2o8tbUUca7B0aqb9zszDlsjlzljo+pLTxMWRDNKyiZnrZuR4xzgkQhlE3ZQrDIjvbUmvpSV7dvopZxl0YvotkZDSuI3dvPFosQFZaRPYhMEW8Xh+CHtcCUGR3P+XKds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=91.107.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail2.kuutio.org [127.0.0.1])
	by mail2.kuutio.org (Postfix) with ESMTP id CFA581FD41;
	Tue, 13 Oct 2026 18:56:43 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail2.kuutio.org ([127.0.0.1])
 by localhost (mail2.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id eNxlaPmmxRHB; Tue, 13 Oct 2026 18:56:43 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail2.kuutio.org (Postfix) with ESMTPSA id 3EA48206A5;
	Tue, 13 Oct 2026 18:56:42 +0000 (UTC)
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
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	Javen Xu <javen_xu@realsil.com.cn>,
	Marek Vasut <marek.vasut@mailbox.org>,
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
	dam.dejean@gmail.com,
	Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH net-next v3 2/2] net: phy: realtek: support unaligned RTL8224 PHY packages
Date: Tue, 13 Oct 2026 21:56:35 +0300
Message-ID: <20261013185635.1412452-3-oskari@lemmela.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013185635.1412452-1-oskari@lemmela.net>
References: <20261013185635.1412452-1-oskari@lemmela.net>
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

Share base-address parsing between probe and MDI configuration, and
calculate the port offset when configuring MDI rather than caching it
in an additional per-PHY private allocation.

Join both DT-described and legacy packages with devm_phy_package_join(),
as only the base address is needed, not a shared package node. This
avoids mixing OF and non-OF joins, which can unbalance package-node
references when members select the same base address.

Keep the existing aligned-address assumption when no package node
is present.

Signed-off-by: Manuel Stocker <mensi@mensi.ch>
[Oskari: rebased on net-next and reworked package handling]
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/net/phy/realtek/realtek_main.c | 56 +++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index e14960192e79..cc5ebedd0e8f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -2720,10 +2720,35 @@ static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
 	return ret;
 }
 
-static int rtl8224_mdi_config_order(struct phy_device *phydev)
+static int rtl8224_get_base_addr(struct phy_device *phydev, u32 *base_addr)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct device_node *np;
+	int ret;
+
+	*base_addr = phydev->mdio.addr & ~3;
+	np = of_get_parent(dev->of_node);
+	if (of_node_name_eq(np, "ethernet-phy-package")) {
+		ret = of_property_read_u32(np, "reg", base_addr);
+		of_node_put(np);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Missing or invalid PHY package reg\n");
+
+		if (phydev->mdio.addr < *base_addr ||
+		    phydev->mdio.addr - *base_addr >= 4)
+			return dev_err_probe(dev, -EINVAL,
+					     "PHY address outside RTL8224 package\n");
+	} else {
+		of_node_put(np);
+	}
+
+	return 0;
+}
+
+static int rtl8224_mdi_config_order(struct phy_device *phydev, u8 port_offset)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	u8 port_offset = phydev->mdio.addr & 3;
 	u32 order = 0;
 	int ret;
 
@@ -2745,10 +2770,10 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 					  order ? BIT(port_offset) : 0);
 }
 
-static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
+static int rtl8224_mdi_config_polarity(struct phy_device *phydev, u8 port_offset)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	u8 offset = (phydev->mdio.addr & 3) * 4;
+	u8 offset = port_offset * 4;
 	u32 polarity = 0;
 	int ret;
 
@@ -2772,20 +2797,33 @@ static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
 
 static int rtl8224_config_init(struct phy_device *phydev)
 {
+	u32 base_addr;
+	u8 port_offset;
 	int ret;
 
-	ret = rtl8224_mdi_config_order(phydev);
+	ret = rtl8224_get_base_addr(phydev, &base_addr);
 	if (ret)
 		return ret;
 
-	return rtl8224_mdi_config_polarity(phydev);
+	port_offset = phydev->mdio.addr - base_addr;
+	ret = rtl8224_mdi_config_order(phydev, port_offset);
+	if (ret)
+		return ret;
+
+	return rtl8224_mdi_config_polarity(phydev, port_offset);
 }
 
 static int rtl8224_probe(struct phy_device *phydev)
 {
-	/* Chip exposes 4 ports, join all of them in the same package */
-	return devm_phy_package_join(&phydev->mdio.dev, phydev,
-				     phydev->mdio.addr & ~3, 0);
+	struct device *dev = &phydev->mdio.dev;
+	u32 base_addr;
+	int ret;
+
+	ret = rtl8224_get_base_addr(phydev, &base_addr);
+	if (ret)
+		return ret;
+
+	return devm_phy_package_join(dev, phydev, base_addr, 0);
 }
 
 static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
-- 
2.55.0

