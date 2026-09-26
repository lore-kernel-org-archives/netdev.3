Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647B6345CC9;
	Sat, 26 Sep 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790463687; cv=none; b=FtEnEKtXv1OLipbDi9K4XvD6MAeyRlU3GMKs7GQW+t9m53kRiVd+1fABJBPCT7GwS4rDm9hv0Xs6YTrU7paj12jJXQpirDhXrHym8/l9c+IOD6NzM90j7ZI9v9VcmIwWRt9ami5LfSc+UN2IOYNC4Oc5IBX2ayc7ZX7lRzNFjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790463687; c=relaxed/simple;
	bh=V+NlQ62e1hL6pBozcpXJGbv/L9B5tzZSktG+8MBWvS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StvkzVQDBFnMRoiMK7lY76ZlfNmz5uYOkodMRLEI02dvcIF+WW60GLyACo1JIlZOm+wjVDbYrHiUdRtcQDavLHItix/AsYUpVRNBR6JLOgBt6MXa/8SpJhdpvwr3M00cf3gCnmFZwpyGduuyECu61zcQHQgJLcyAg9AbjKfokNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=usvp71dF; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="usvp71dF"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C6DA169C;
	Sat, 26 Sep 2026 16:01:21 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ADBD3F632;
	Sat, 26 Sep 2026 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790463684; bh=V+NlQ62e1hL6pBozcpXJGbv/L9B5tzZSktG+8MBWvS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usvp71dFji1badj4+lzF9eKMHd+p23J99ilmkzZEeAj0UGrSGkqHGLMdz6Luy4SGz
	 0girI1+sMEzbxbjwglZFTL1n7E26adjFvY2cpglHgCm4i5xJ9+9/XLURa80h012kdS
	 zgiHo6Y4lEq5Rg8anVNluJDDfSr8i6QvX5D+qIXM=
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
Subject: [PATCH net-next v3 2/5] net: phy: Add support for the Maxio MAE0621A
Date: Sun, 27 Sep 2026 00:56:22 +0200
Message-ID: <20260926225625.25969-3-andre.przywara@arm.com>
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

From: Liu Changjie <liucj1228@outlook.com>

Add exact PHY ID matching and optional 125 MHz CLKOUT configuration
for the Maxio MAE0621A Gigabit Ethernet PHY. Preserve the existing
hardware configuration when the firmware property is absent.

Signed-off-by: Liu Changjie <liucj1228@outlook.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig  |   8 +++
 drivers/net/phy/Makefile |   1 +
 drivers/net/phy/maxio.c  | 103 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 drivers/net/phy/maxio.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b4ef927fd4a67..eb40276113a57 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -298,6 +298,14 @@ config MARVELL_88X2222_PHY
 	  Support for the Marvell 88X2222 Dual-port Multi-speed Ethernet
 	  Transceiver.
 
+config MAXIO_PHY
+	tristate "Maxio Ethernet PHYs"
+	help
+	  Support for Maxio Ethernet PHYs. Currently this driver supports the
+	  MAE0621A Gigabit Ethernet PHY. The driver optionally selects a 125 MHz
+	  clock on the CLKOUT pin while preserving the hardware configuration on
+	  boards which do not request it.
+
 config MAXLINEAR_GPHY
 	tristate "Maxlinear Ethernet PHYs"
 	select POLYNOMIAL if HWMON
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 25c4a3c2429f7..9730b8a6fa5b0 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_MARVELL_10G_PHY)	+= marvell10g.o
 obj-$(CONFIG_MARVELL_PHY)	+= marvell.o
 obj-$(CONFIG_MARVELL_88Q2XXX_PHY)	+= marvell-88q2xxx.o
 obj-$(CONFIG_MARVELL_88X2222_PHY)	+= marvell-88x2222.o
+obj-$(CONFIG_MAXIO_PHY)		+= maxio.o
 obj-$(CONFIG_MAXLINEAR_GPHY)	+= mxl-gpy.o
 obj-$(CONFIG_MAXLINEAR_86110_PHY)	+= mxl-86110.o
 obj-y				+= mediatek/
diff --git a/drivers/net/phy/maxio.c b/drivers/net/phy/maxio.c
new file mode 100644
index 0000000000000..d2cb238956460
--- /dev/null
+++ b/drivers/net/phy/maxio.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Driver for Maxio Ethernet PHYs. */
+
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/property.h>
+
+#define MAXIO_MAE0621A_PHY_ID		0x7b744412
+
+#define MAXIO_PAGE_SELECT		0x1f
+#define MAXIO_MAE0621A_PHYCR2_PAGE	0xa43
+#define MAXIO_MAE0621A_PHYCR2		0x19
+#define MAXIO_MAE0621A_CLKOUT_125M	BIT(11)
+#define MAXIO_MAE0621A_CLKOUT_ENABLE	BIT(0)
+
+struct maxio_priv {
+	bool clk_out_125m;
+};
+
+static int maxio_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, MAXIO_PAGE_SELECT);
+}
+
+static int maxio_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, MAXIO_PAGE_SELECT, page);
+}
+
+static int maxio_mae0621a_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct maxio_priv *priv;
+	u32 frequency;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	ret = device_property_read_u32(dev, "maxio,clk-out-frequency-hz",
+				       &frequency);
+	if (ret == -EINVAL)
+		return 0;
+	if (ret)
+		return ret;
+
+	if (frequency != 125000000) {
+		phydev_err(phydev, "invalid CLKOUT frequency %u\n", frequency);
+		return -EINVAL;
+	}
+
+	priv->clk_out_125m = true;
+
+	return 0;
+}
+
+static int maxio_mae0621a_config_init(struct phy_device *phydev)
+{
+	struct maxio_priv *priv = phydev->priv;
+	int ret;
+
+	if (!priv->clk_out_125m)
+		return 0;
+
+	ret = phy_modify_paged_changed(phydev, MAXIO_MAE0621A_PHYCR2_PAGE,
+				       MAXIO_MAE0621A_PHYCR2,
+				       MAXIO_MAE0621A_CLKOUT_ENABLE |
+				       MAXIO_MAE0621A_CLKOUT_125M,
+				       MAXIO_MAE0621A_CLKOUT_ENABLE |
+				       MAXIO_MAE0621A_CLKOUT_125M);
+	if (ret <= 0)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
+static struct phy_driver maxio_drivers[] = {
+	{
+		PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID),
+		.name		= "Maxio MAE0621A",
+		.probe		= maxio_mae0621a_probe,
+		.config_init	= maxio_mae0621a_config_init,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_page	= maxio_read_page,
+		.write_page	= maxio_write_page,
+	},
+};
+module_phy_driver(maxio_drivers);
+
+static const struct mdio_device_id __maybe_unused maxio_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(MAXIO_MAE0621A_PHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, maxio_tbl);
+
+MODULE_AUTHOR("Liu Changjie <liucj1228@outlook.com>");
+MODULE_DESCRIPTION("Maxio Ethernet PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.46.4

