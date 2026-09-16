Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF863ACA7F;
	Wed, 16 Sep 2026 04:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533712; cv=none; b=jM1dbDF8PIQg+s0E4U0eNM+keMGOmxgt8vZeBB2x1EhVWzcNowk2rUoO4cQjVsytPyipn3Tbaskwe/MktxZg6AmjqVtApklnkcNyziK7HgOginzHHv6IQpF5SGjBeoc4T4hTDSCxBp4Sy72rpWfHlITzfGDFuRer+F8h1ltvILc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533712; c=relaxed/simple;
	bh=aMWczIEqeYggtk8qBPl7Xvpeyy0secKTqQ+GfWpMaZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiGGVTgdPnpdI2Kt4F64Y/rnxwlO54smua+hT1ccbXBMB+IjclSylG+GooS71+yf9X08KXOiu4WOhXIQUjoEJlmq1m2n7Z594gOJ/aJg13YoTt6+YoSLyUKLPeqiOznhoqDdn1i1AgrTH2hq/GTlm+wMZ6hwMc02BrF1ucPH9cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=0fM+Bbd+; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="0fM+Bbd+"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 7575843BC4;
	Wed, 16 Sep 2026 14:41:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789533695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ia5UEC091vWYGaLXg2IJatFIQRrBZcpebd6XutvbknM=;
	b=0fM+Bbd+dF0CUTY5gmmWczH+Q1EPowE/U8hYc4suiDhqeo2DLCywqWk6Mxj2pQFW6zLnKS
	bNm5udLTPsPyToa4n5wp4RDk588TWRLxMsknufkCUtTLLodEewXDHuJ+nz1vwEI350VjPz
	FxRW4JaV/6F0oTYW7EbrFO0cL0QZbidIn/wtFZ/9D47WRUu/jTjiHAAEUMQfj8IwO8E8FD
	LUqFgAAnuaONhuL88NgiA4B3MJERBQdrog480nbQCpJYrThmaoieCutHARocnyimuVKzf1
	83uy8wysHoNineYtLMxhfjq4AAtHi2dxQp44D8yN8hHjPI0BV3GZwKOKlvb1NA==
X-GPT-Reason: legitimate; the message is a technical software patch
	for a Linux kernel driver (net-next), which perfectly aligns with
	the technical nature of the sender's domain (d-silva.org) and
	the provided URL (linux-sunxi.org); there are no phishing indicators,
	as the content consists of standard C source code (diffs) and
	includes a "Signed-off-by" tag; the mailbox is expected to receive
	such developer communications, and no urgency or suspicious links
	are present.
From: Alastair D'Silva <alastair@d-silva.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH net-next 2/4] net: phy: Add Allwinner AC300 EPHY driver
Date: Wed, 16 Sep 2026 14:41:17 +1000
Message-ID: <20260916044119.475666-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916044119.475666-1-alastair@d-silva.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Allwinner AC300 integrated Fast Ethernet Physical
Layer (EPHY) co-packaged on Allwinner H616 and H618 SoCs.

The driver communicates with the AC300 configuration space over MDIO
at address 16 + phy_addr, handles internal power domains, clock gating,
bandgap calibration retrieval from SID nvmem, and optimizes transceiver
signal path registers.

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---

Notes:
    Tested on Mellow Fly-C5 (Allwinner H618) under Armbian with sustained
    100Mbps traffic (DHCP, iperf3, NFS rootfs), verifying indirect MDIO
    register programming and bandgap calibration readout from SID nvmem.

 drivers/net/phy/Kconfig     |   9 +
 drivers/net/phy/Makefile    |   1 +
 drivers/net/phy/ac300-phy.c | 331 ++++++++++++++++++++++++++++++++++++
 3 files changed, 341 insertions(+)
 create mode 100644 drivers/net/phy/ac300-phy.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b4ef927fd4a6..c473f0a814b7 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -120,6 +120,15 @@ config MESON_GXL_PHY
 	help
 	  Currently has a driver for the Amlogic Meson GXL Internal PHY
 
+config AC300_PHY
+	tristate "Allwinner AC300 EPHY support"
+	depends on OF && NVMEM
+	help
+	  Support for the Allwinner AC300 integrated Fast Ethernet Physical
+	  Layer (EPHY) co-packaged on Allwinner H616 and H618 SoCs. The AC300
+	  EPHY communicates over MDIO and provides 10/100 Mbps connectivity.
+	  If compiled as a module, it will be called ac300-phy.
+
 config ADIN_PHY
 	tristate "Analog Devices Industrial Ethernet PHYs"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 25c4a3c2429f..98453e68fd9f 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_SFP)		+= sfp.o
 sfp-obj-$(CONFIG_SFP)		+= sfp-bus.o
 obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 
+obj-$(CONFIG_AC300_PHY)		+= ac300-phy.o
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_ADIN1140_PHY)	+= adin1140-phy.o
diff --git a/drivers/net/phy/ac300-phy.c b/drivers/net/phy/ac300-phy.c
new file mode 100644
index 000000000000..c70f567c3179
--- /dev/null
+++ b/drivers/net/phy/ac300-phy.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: GPL-2.0+
+/**
+ * Driver for X-Powers AC300 Ethernet PHY
+ *
+ * Datasheet: https://linux-sunxi.org/images/b/b2/AC300_User_Manual_V1.0_cleaned.pdf
+ *
+ * Copyright (c) 2026 Alastair D'Silva <alastair@d-silva.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define AC300_EPHY_ID			0x00441400
+#define AC300_EPHY_ID_MASK		0x0ffffff0
+
+/* AC300 Configuration Registers (on MDIO Address 16) */
+#define AC300_REG00_CHIP_VERSION_MASK	GENMASK(15, 12)
+#define AC300_REG00_PKG_STATUS_MASK	GENMASK(11, 8)
+#define AC300_REG00_EPHY_CLK_SEL_MASK	GENMASK(7, 6)
+#define AC300_REG00_EPHY_CLK_SEL_25M	0
+#define AC300_REG00_EPHY_CLK_SEL_27M	1
+#define AC300_REG00_EPHY_CLK_SEL_24M	2
+#define AC300_REG00_EFUSE_REG_CLK_GATING	BIT(5)
+#define AC300_REG00_EPHY_REG_CLK_GATING	BIT(4)
+#define AC300_REG00_MDIO_ERROR		BIT(3)
+#define AC300_REG00_CLKIN_GATING	BIT(2)
+#define AC300_REG00_EPHY_RESET_INVALID	BIT(1)
+#define AC300_REG00_CHIP_RESET		BIT(0)
+
+#define AC300_REG01_DEFAULT		0x1084
+#define AC300_REG01_BGTC_MASK		GENMASK(12, 8)
+#define AC300_REG01_BG_EN		BIT(7)
+#define AC300_REG01_BGV_MASK		GENMASK(5, 0)
+
+#define AC300_REG02_DEFAULT		0xC000
+#define AC300_REG02_DLDOEN		BIT(15)
+#define AC300_REG02_DLDOVOL_MASK	GENMASK(14, 12)
+
+#define AC300_REG05_DEFAULT		0xA800
+#define AC300_REG05_MDIO_DRV_MASK	GENMASK(15, 14)
+#define AC300_REG05_LED_DRV_MASK	GENMASK(13, 12)
+#define AC300_REG05_MII_DRV_MASK	GENMASK(11, 10)
+#define AC300_REG05_EPHY_IRQ_STATUS	BIT(9)
+#define AC300_REG05_EPHY_IRQ_ENABLE	BIT(8)
+#define AC300_REG05_CLKIN_PAD_EN	BIT(4)
+#define AC300_REG05_E_DPX_LED_IO_EN	BIT(3)
+#define AC300_REG05_E_SPD_LED_IO_EN	BIT(2)
+#define AC300_REG05_E_LNK_LED_IO_EN	BIT(1)
+#define AC300_REG05_EPHY_MII_IO_EN	BIT(0)
+
+#define AC300_REG06_DEFAULT		0x0001
+#define AC300_REG06_BGS_EFUSE_MASK	GENMASK(15, 12)
+#define AC300_REG06_XMII_SEL		BIT(11)
+#define AC300_REG06_EPHY_MODE_MASK	GENMASK(10, 9)
+#define AC300_REG06_BIST_CLK_EN		BIT(3)
+#define AC300_REG06_LED_POL		BIT(1)
+#define AC300_REG06_SHUTDOWN		BIT(0)
+
+struct ac300_phy_priv {
+	struct clk *ephy_clk;
+	struct clk *pwm_clk;
+	u16 caldata;
+};
+
+static int ac300_phy_disable(struct phy_device *phydev)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int cfg_addr = 16 + phydev->mdio.addr;
+	u16 val;
+	int ret;
+
+	val = 0x1f00 | FIELD_PREP(AC300_REG00_EPHY_CLK_SEL_MASK, AC300_REG00_EPHY_CLK_SEL_24M);
+	ret = mdiobus_write(bus, cfg_addr, 0x00, val);
+	if (ret)
+		return ret;
+
+	ret = mdiobus_write(bus, cfg_addr, 0x05, AC300_REG05_DEFAULT);
+	if (ret)
+		return ret;
+
+	return mdiobus_write(bus, cfg_addr, 0x06, AC300_REG06_SHUTDOWN);
+}
+
+static int ac300_phy_enable(struct phy_device *phydev)
+{
+	struct ac300_phy_priv *priv = phydev->priv;
+	struct mii_bus *bus = phydev->mdio.bus;
+	int cfg_addr = 16 + phydev->mdio.addr;
+	u16 val;
+	int ret;
+
+	/* Step 1: release reset */
+	val = 0x1f00 | FIELD_PREP(AC300_REG00_EPHY_CLK_SEL_MASK, AC300_REG00_EPHY_CLK_SEL_24M) |
+	      AC300_REG00_EPHY_RESET_INVALID | AC300_REG00_CHIP_RESET;
+	ret = mdiobus_write(bus, cfg_addr, 0x00, val);
+	if (ret)
+		return ret;
+	usleep_range(10000, 11000);
+
+	/* Step 2: clk gating */
+	val |= AC300_REG00_EPHY_REG_CLK_GATING | AC300_REG00_CLKIN_GATING |
+	       AC300_REG00_EFUSE_REG_CLK_GATING;
+	ret = mdiobus_write(bus, cfg_addr, 0x00, val);
+	if (ret)
+		return ret;
+	usleep_range(10000, 11000);
+
+	/* Step 2.5: Apply System BIAS Calibration */
+	val = AC300_REG01_DEFAULT;
+	if (priv->caldata)
+		val = (priv->caldata & (AC300_REG01_BGTC_MASK | AC300_REG01_BGV_MASK));
+	val |= AC300_REG01_BG_EN; /* Ensure Bandgap is enabled */
+	ret = mdiobus_write(bus, cfg_addr, 0x01, val);
+	if (ret)
+		return ret;
+	usleep_range(10000, 11000);
+
+	/* Step 3: SYS_IO setup */
+	val = AC300_REG05_DEFAULT | AC300_REG05_CLKIN_PAD_EN |
+	      AC300_REG05_EPHY_MII_IO_EN | AC300_REG05_E_DPX_LED_IO_EN;
+	ret = mdiobus_write(bus, cfg_addr, 0x05, val);
+	if (ret)
+		return ret;
+	usleep_range(10000, 11000);
+
+	/* Step 4: RMII Mode, SHUTDOWN=0, calibration & LED polarity */
+	val = 0;
+	if (phydev->interface == PHY_INTERFACE_MODE_RMII)
+		val |= AC300_REG06_XMII_SEL;
+	val |= AC300_REG06_LED_POL; /* LED_POL 1:Low active */
+	val &= ~(0x0F << 12);
+	val |= (0x0F & (0x03 + priv->caldata)) << 12;
+	ret = mdiobus_write(bus, cfg_addr, 0x06, val);
+	if (ret)
+		return ret;
+	msleep(100);
+
+	return 0;
+}
+
+static int ac300_phy_config_init(struct phy_device *phydev)
+{
+	struct ac300_phy_priv *priv = phydev->priv;
+	int ret;
+
+	/* Write page-based EPHY transceiver and signal path optimizations */
+	ret = phy_write(phydev, 0x1f, 0x0100); /* Switch to Page 1 */
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x12, 0x4824); /* Disable APS */
+	if (ret)
+		return ret;
+
+	ret = phy_write(phydev, 0x1f, 0x0200); /* Switch to Page 2 */
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x18, 0x0000); /* PHYAFE TRX optimization */
+	if (ret)
+		return ret;
+
+	ret = phy_write(phydev, 0x1f, 0x0600); /* Switch to Page 6 */
+	if (ret)
+		return ret;
+	if (priv->caldata & BIT(9)) {
+		ret = phy_write(phydev, 0x14, 0x7809); /* Fixed TX optimization */
+		if (ret)
+			return ret;
+		ret = phy_write(phydev, 0x13, 0xf000); /* Fixed RX optimization */
+		if (ret)
+			return ret;
+		ret = phy_write(phydev, 0x10, 0x5523);
+		if (ret)
+			return ret;
+		ret = phy_write(phydev, 0x15, 0x3533);
+		if (ret)
+			return ret;
+	} else {
+		ret = phy_write(phydev, 0x14, 0x708b); /* Default TX optimization */
+		if (ret)
+			return ret;
+		ret = phy_write(phydev, 0x13, 0xF000); /* Default RX optimization */
+		if (ret)
+			return ret;
+		ret = phy_write(phydev, 0x15, 0x1530);
+		if (ret)
+			return ret;
+	}
+
+	ret = phy_write(phydev, 0x1f, 0x0800); /* Switch to Page 8 */
+	if (ret)
+		return ret;
+	if (priv->caldata & BIT(9)) {
+		ret = phy_write(phydev, 0x1d, 0x0844); /* disable auto offset */
+		if (ret)
+			return ret;
+	}
+	ret = phy_write(phydev, 0x18, 0x00bc); /* PHYAFE TRX optimization */
+	if (ret)
+		return ret;
+
+	ret = phy_write(phydev, 0x1f, 0x0100); /* Switch to page 1 */
+	if (ret)
+		return ret;
+	ret = phy_clear_bits(phydev, 0x17, BIT(3)); /* Disable Intelligent EEE */
+	if (ret)
+		return ret;
+
+	/* Disable 802.3az EEE */
+	ret = phy_write(phydev, 0x1f, 0x0200); /* Switch to page 2 */
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x18, 0x0000);
+	if (ret)
+		return ret;
+	ret = phy_write(phydev, 0x1f, 0x0000); /* Switch to page 0 */
+	if (ret)
+		return ret;
+
+	return phy_clear_bits_mmd(phydev, 0x7, 0x3c, BIT(1));
+}
+
+static int ac300_phy_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct ac300_phy_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	priv->ephy_clk = devm_clk_get_optional_enabled(dev, "ephy");
+	if (IS_ERR(priv->ephy_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->ephy_clk),
+				     "Failed to request ephy clock\n");
+
+	priv->pwm_clk = devm_clk_get_optional_enabled(dev, "pwm");
+	if (IS_ERR(priv->pwm_clk))
+		return dev_err_probe(dev, PTR_ERR(priv->pwm_clk),
+				     "Failed to request pwm clock\n");
+
+	/* Read calibration data from NVMEM/SID */
+	ret = nvmem_cell_read_u16(dev, "calibration", &priv->caldata);
+	if (ret) {
+		if (ret == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_warn(dev, "Failed to read EPHY calibration (%pe)\n", ERR_PTR(ret));
+	} else {
+		dev_info(dev, "Read AC300 EPHY calibration: 0x%04x\n", priv->caldata);
+	}
+
+	return ac300_phy_enable(phydev);
+}
+
+static void ac300_phy_remove(struct phy_device *phydev)
+{
+	ac300_phy_disable(phydev);
+}
+
+static int ac300_phy_suspend(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = ac300_phy_disable(phydev);
+	if (ret)
+		return ret;
+	return genphy_suspend(phydev);
+}
+
+static int ac300_phy_resume(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = ac300_phy_enable(phydev);
+	if (ret)
+		return ret;
+	return genphy_resume(phydev);
+}
+
+static int ac300_phy_soft_reset(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = ac300_phy_enable(phydev);
+	if (ret)
+		return ret;
+	return genphy_soft_reset(phydev);
+}
+
+static int ac300_phy_match_phy_device(struct phy_device *phydev,
+				      const struct phy_driver *phydrv)
+{
+	return of_device_is_compatible(phydev->mdio.dev.of_node,
+				       "allwinner,sun50i-h618-ac300-ephy");
+}
+
+static struct phy_driver ac300_phy_driver[] = {
+	{
+		.phy_id		= AC300_EPHY_ID,
+		.phy_id_mask	= AC300_EPHY_ID_MASK,
+		.name		= "Allwinner AC300 EPHY",
+		.features	= PHY_BASIC_FEATURES,
+		.match_phy_device = ac300_phy_match_phy_device,
+		.soft_reset	= ac300_phy_soft_reset,
+		.config_init	= ac300_phy_config_init,
+		.probe		= ac300_phy_probe,
+		.remove		= ac300_phy_remove,
+		.suspend	= ac300_phy_suspend,
+		.resume		= ac300_phy_resume,
+	}
+};
+module_phy_driver(ac300_phy_driver);
+
+MODULE_AUTHOR("Alastair D'Silva <alastair@d-silva.org>");
+MODULE_DESCRIPTION("X-Powers AC300 Ethernet PHY driver");
+MODULE_LICENSE("GPL");
+
+static const struct mdio_device_id __maybe_unused ac300_phy_tbl[] = {
+	{ AC300_EPHY_ID, AC300_EPHY_ID_MASK },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, ac300_phy_tbl);
-- 
2.53.0

