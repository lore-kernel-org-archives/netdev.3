Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AEA14F70;
	Sat, 26 Sep 2026 23:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463698; cv=none; b=Xj+FsvDX7uT9eAnN3Tcje9uwTjSDH8cG96MjNcK5F5NpZHiSbOqslV5i7YVgjjxPJBnVy4XdNVPPzf1v7+7P+TS2k63DVj+OB13qIzthQduLgzF6QK4+bLq6qCyfe6K90uF4SGHehobED4eidjF7kk0VY9kbnODtVfTF3MhmJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463698; c=relaxed/simple;
	bh=8VPJKxA1h0I6ZQ84vbcbxPyKkIiVETvj5Q5vm55qJRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsmqU0KyHZsgQrty4ehI6x5nvE5Nr8kANIrNKN/J2RN4BDNmhJDaxivDbuNXq8b+MP+/DVwJtT0QiLDNOZqlqv52/niM+WpVPuh3+xYbfJ5GDly0zJLN7DGGIDYhtk/HC9dm9Rmflo2o37LK2mK96wyp0cA7DAJ6RhVYNiiknaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m8924jxP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m8924jxP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C868E169C;
	Sat, 26 Sep 2026 16:01:30 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 851063F632;
	Sat, 26 Sep 2026 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790463694; bh=8VPJKxA1h0I6ZQ84vbcbxPyKkIiVETvj5Q5vm55qJRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8924jxPDvdmgPSc/sF7a6J90ZQizMYYSii5hQHby60nETVkn0UIV4j2zS5exHlSj
	 PB3idRgZM1OvcnYKfw5A3IPMIFLR87ye1OZvDBhgYoMFP5MXY3TgL6IOqbpDgFzHvQ
	 4WoYUel/dcNJfg0d8/h880cd28SZHW02gD1He9nU=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>,
	Liu Changjie <liucj1228@outlook.com>,
	Per Larsson <per@palvencia.se>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 5/5] net: phy: maxio: add support for -Q2C variant
Date: Sun, 27 Sep 2026 00:56:25 +0200
Message-ID: <20260926225625.25969-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260926225625.25969-1-andre.przywara@arm.com>
References: <20260926225625.25969-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the maxio Ethernet PHY driver expects a Maxio MAE0621A-Q3C PHY
matching exactly the one ID provided: 0x7b744412. There exist an earlier
variant of the PHY, still used on some devices, its label differs by using
the -Q2C suffix, and its PHY ID is 0x7b744411.

Some vendor drivers floating around in the web suggest they are somewhat
different, although for now this driver does not deal with any of those
registers, and the 125M clock switch is identical between the two.
Nevertheless prepare for future driver divergence by describing two
drivers, although using the same functions for now.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/net/phy/maxio.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
index 266be95b949a8..8c33c8433b127 100644
--- a/drivers/net/phy/maxio.c
+++ b/drivers/net/phy/maxio.c
@@ -7,7 +7,8 @@
 #include <linux/phy.h>
 #include <linux/property.h>
 
-#define MAXIO_MAE0621A_PHY_ID		0x7b744412
+#define MAXIO_MAE0621A_Q2C_PHY_ID	0x7b744411
+#define MAXIO_MAE0621A_Q3C_PHY_ID	0x7b744412
 
 #define MAXIO_PAGE_SELECT		0x1f
 #define MAXIO_MAE0621A_PHYCR2_PAGE	0xa43
@@ -89,8 +90,18 @@ static int maxio_mae0621a_config_init(struct phy_device *phydev)
 
 static struct phy_driver maxio_drivers[] = {
 	{
-		PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID),
-		.name		= "Maxio MAE0621A",
+		PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_Q2C_PHY_ID),
+		.name		= "Maxio MAE0621A-Q2C",
+		.probe		= maxio_mae0621a_probe,
+		.config_init	= maxio_mae0621a_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= maxio_read_page,
+		.write_page	= maxio_write_page,
+	},
+	{
+		PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_Q3C_PHY_ID),
+		.name		= "Maxio MAE0621A-Q3C",
 		.probe		= maxio_mae0621a_probe,
 		.config_init	= maxio_mae0621a_config_init,
 		.suspend	= genphy_suspend,
@@ -102,7 +113,8 @@ static struct phy_driver maxio_drivers[] = {
 module_phy_driver(maxio_drivers);
 
 static const struct mdio_device_id __maybe_unused maxio_tbl[] = {
-	{ PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID) },
+	{ PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_Q2C_PHY_ID) },
+	{ PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_Q3C_PHY_ID) },
 	{ }
 };
 MODULE_DEVICE_TABLE(mdio, maxio_tbl);
-- 
2.46.4

