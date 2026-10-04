Received: from mail1.kuutio.org (mail1.kuutio.org [65.108.50.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730146D547;
	Sun,  4 Oct 2026 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.50.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791147214; cv=none; b=X+M7r9xrUtTVTp9pWkJidjVqwPSpGZcLiYWOyO9QQuXtAFtQ3OLHiTq77SB+uLCJq4kCzpFmeFWdELVD9yqp8/A3J28c6TioG9kujDDabuyeRuyVwYTmb1lTJQrjQIZ5f6fAOxkjOCZqqG5VJcpJgPnPBTa3w+cx8QtP/sH7ILE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791147214; c=relaxed/simple;
	bh=v49ZB23Kze7PHLcH2i3goNue+IyusDCjZ/u9rJ2G2lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxthC/dn8OJHPqJEK4aEdafXuo+nw3ilaPNbcEKWM4Y8Ps/TahMYmsoQbnB/b07q4ouK1j5WjplhQ8h4+iKP22LHbFWSyLxiVoG1wyR1mBr5/JYcpzX35TEKB3/pCF9ZKTPcEHeRYJNF/DmcpUjh1+POWbnf/2q2uBbeNZnkejk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net; spf=pass smtp.mailfrom=lemmela.net; arc=none smtp.client-ip=65.108.50.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lemmela.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lemmela.net
Received: from localhost (mail1.kuutio.org [127.0.0.1])
	by mail1.kuutio.org (Postfix) with ESMTP id BCC291FD9C;
	Sun,  4 Oct 2026 20:46:46 +0000 (UTC)
X-Virus-Scanned: amavis at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
 by localhost (mail1.kuutio.org [127.0.0.1]) (amavis, port 10024) with LMTP
 id vR5kU_o3mZqC; Sun,  4 Oct 2026 20:46:46 +0000 (UTC)
Received: from muovi.kuutio.org (nbqchc6j3dhrbnnpubi-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:adc:6a00::8be])
	by mail1.kuutio.org (Postfix) with ESMTPSA id E4A771FD92;
	Sun,  4 Oct 2026 20:46:45 +0000 (UTC)
From: Oskari Lemmela <oskari@lemmela.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Damien Dejean <dam.dejean@gmail.com>
Cc: Manuel Stocker <mensi@mensi.ch>,
	Oskari Lemmela <oskari@lemmela.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: realtek: fix RTL8224 package address selection
Date: Sun,  4 Oct 2026 23:46:36 +0300
Message-ID: <20261004204637.721148-1-oskari@lemmela.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manuel Stocker <mensi@mensi.ch>

The RTL8224 driver rounds each PHY address down to a multiple of four
to select the package base and uses the low two address bits as the
port index. For a package starting at an unaligned MDIO address, this
accesses shared registers at the wrong address and selects incorrect
MDI pair order and polarity fields.

The Hasivo S1100WP-8GT-2S+ uses two RTL8224 packages at MDIO
addresses 1-4 and 5-8. The aligned-address assumption splits each
physical package into incorrect software groups rather than using
the actual package bases of 1 and 5.

Use the base address from an ethernet-phy-package node when present
and calculate each port's offset relative to that address. Reject
PHY addresses outside the four-port package and propagate explicit
package errors instead of falling back to another base address.

Keep the existing aligned-address assumption when no package node
is present.

Fixes: 330296ea9e15 ("net: phy: realtek: add RTL8224 pair order support")
Signed-off-by: Manuel Stocker <mensi@mensi.ch>
[Oskari: rebased on net/main, reworded commit message]
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/net/phy/realtek/realtek_main.c | 49 +++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 177b62a7b2d1..8405a74d631f 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -340,6 +340,10 @@ struct rtl821x_priv {
 	u16 iner;
 };
 
+struct rtl8224_priv {
+	u8 port_offset;
+};
+
 struct rtl8261x_priv {
 	const char *fw_name;
 	bool fw_loaded;
@@ -2699,7 +2703,8 @@ static int rtl8224_package_modify_mmd(struct phy_device *phydev, int devad,
 static int rtl8224_mdi_config_order(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	u8 port_offset = phydev->mdio.addr & 3;
+	struct rtl8224_priv *priv = phydev->priv;
+	u8 port_offset = priv->port_offset;
 	u32 order = 0;
 	int ret;
 
@@ -2724,7 +2729,8 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
 static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	u8 offset = (phydev->mdio.addr & 3) * 4;
+	struct rtl8224_priv *priv = phydev->priv;
+	u8 offset = priv->port_offset * 4;
 	u32 polarity = 0;
 	int ret;
 
@@ -2759,9 +2765,42 @@ static int rtl8224_config_init(struct phy_device *phydev)
 
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

base-commit: 6dc989ea46b96ce170840174b4a38c4a387fb005
-- 
2.55.0

