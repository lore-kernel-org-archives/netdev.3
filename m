Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7854582EA
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 19:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920115; cv=none; b=P/ZdALoaoTunIUb8IE06piX6VvPZvLxV3Am6NlYzfWgXj4eVDwedYwhFGKxA8y1V+7YTFiTl4f487cTusUB8xSoPLM6b3IHrUIN8p3ot4pjGjt4zlWs+gA2vBinp2fCsuUqN+e2CRc4mWexV6uniW6YhWCTN36vkwt9u/B3aEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920115; c=relaxed/simple;
	bh=L1m/ODL7nyP7b2+NTOTtTZuuOMb5c+YbPPbQQTQBkVk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/NCmIcOAFlY040KGauAh8t+X5EcagR4WaeaNw/QbRHaMHVBQqd30XtCnt+11hEg36VOb4l/W3rvMR69FwECNXB2wdpsFsOv8xtjrC4Y3h9KmSSLDQ55M8orHGUdpqTkQWfR0QdEPqpg0wjfcmU/C3Loggs81uIfiPUffXAMxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2tF9wNA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2tF9wNA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49553515a8bso9142595e9.1
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920111; x=1785524911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=igSz6iCeiuwZKfKF3vJdtKOC1mOJI4Yqt72Du91TXQ8=;
        b=f2tF9wNAuhNw2zc85TzCRfERZ88LRm8GLfQ+lDq6SwkVeZdedwZ1dVT5YoGvWl4Xf+
         ccDXubk30+YvabsX1G2pAT3JoOMfn+wjuS8FcGe8rVBeW2SsUMU2MRbb2nBVrRjLotty
         KMWTyZUrVFBa7S0PBk/iC76DWKxDK7FnHvwGdPEUg1IL5Ru4t3KHElcjtw6Ojw2YscvO
         vhz2dwZdj6JPZlmzyjWI/WG9ySW9ls0Gmt2BQN3rTtCq0Qrl4w52icNmQgjq3vAuGEtS
         2GvGj0Uyj+hsvoqwYTqAXe0QePBzJEhLB7B/LVSdeudOzstxoM1fStAh3/f6480ucMnD
         IHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920111; x=1785524911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=igSz6iCeiuwZKfKF3vJdtKOC1mOJI4Yqt72Du91TXQ8=;
        b=syRk/6zWDuYhKxWbHDl9SEVbr7erTf0G0icSqLola19Wzse3Cl9Cd8lSGr18VEc7XT
         wiBmOSpJS2vChG+NjkWs6jbEKp5TFLTuibup9vRUQDeYejMQzvLIf+nq800oU/laiIv/
         UfRp7HG/FParmzCdEwxfgg4AWhEz2QcE8fWhBCSh37Gtkg+XvpLyOh9mPKjWI3gk7Bmz
         fW61jkYWwKuNq2eAixzLj3y5xC7fzujdfZ05msllTXKiPuk3cb1pzgQXt7zRLqsZvdcU
         g9Z+3eJFu2p1U3T78u2735WTobKAPRjZrY+Cbzjx/lOvSTO9iRcDsZFSxx1nuEtp0fih
         lu1w==
X-Forwarded-Encrypted: i=1; AHgh+Ro3Y9lnKP/HfmT6msnE2/4nuBvRUkOHOSbT2/EGNrhorrP/7LJAStPBMZHPv00hC703ZTfvDC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoRm8vqgJgnk9FGCKxmCHyJZpyhZphP9FvpvG+3ukkeI7hMnvS
	52TJum8oDNQc4+OykMlGQ7+fAge56VTjotij+0h+veffqgv14s/K4X+p
X-Gm-Gg: AR+sD10E0WqLQRuYzhutOqcZCM3d+yfTH0XCLNepG8eN0f1phC3jrm9Gu+6elAJ/nFN
	7UG15dGpxJQgAuITrtt9Tf12HxMEE22i5USK3GR2N9FKcF4Ld8oKPVXKYlquCqgGFA3U061bf5E
	1HZxn3TtLhF6AG7QoUXiBYz0mhTC565PWdcOlAeLe0F/wlOzmFBU2RioS8H9BGhaOIXEPsDTB0w
	0I7qi6SMnS9BXm66n/IxYpvFOn5p2r2vsaCxzVBO7b0SjZb89z6TGyFMNGIXUa54T9cZvCzUzgQ
	o2QguhNwPB/Q8tn3Wlx71yyRc2gshVoy18ylDfxSRKzZhmDsGkx5m/2fYDiyKfflvqGT+8gd2Mv
	EL8HcOlOdm9zm7Gs52c1MOVH++uMHzouPE4cbeXrxJwd4v9ye2TBGhvC5y6ggmbhc38lgzTqjsM
	WYoluizeqd7CEGixfCuusK3bRbk+uIxpWY+BtKh+e3Oawyznzwp3epJtt/xaZcez3l
X-Received: by 2002:a05:600c:4708:b0:495:5172:6620 with SMTP id 5b1f17b1804b1-49573d13256mr96934265e9.31.1784920110737;
        Fri, 24 Jul 2026 12:08:30 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-3-249-180.retail.telecomitalia.it. [87.3.249.180])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496b4c8d6b5sm5893755e9.2.2026.07.24.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:30 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 4/6] net: phy: mediatek: split Airoha code to dedicated source
Date: Fri, 24 Jul 2026 21:08:07 +0200
Message-ID: <20260724190811.198339-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724190811.198339-1-ansuelsmth@gmail.com>
References: <20260724190811.198339-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for Airoha PHYs software calibration support, split the
Airoha code to dedicated source following Mediatek naming pattern of
"ge-soc".

This is to tidy things up and not overload the mediatek driver of specific
Airoha code and ship a bigger PHY kernel module with dead code.

Move the shared LEDs function to mtk-phy-lib to permit the split instead of
duplicating the code.

Also add myself as MAINTAINER of the now new airoha-ge-soc driver.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS                              |   8 ++
 drivers/net/phy/mediatek/Kconfig         |  16 ++-
 drivers/net/phy/mediatek/Makefile        |   1 +
 drivers/net/phy/mediatek/airoha-ge-soc.c | 102 ++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c    | 146 -----------------------
 drivers/net/phy/mediatek/mtk-ge-soc.h    |   4 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c   |  72 +++++++++++
 drivers/net/phy/mediatek/mtk.h           |  12 ++
 8 files changed, 211 insertions(+), 150 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/airoha-ge-soc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 16e47aea84c3..e914bccf5cbb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -760,6 +760,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA ETHERNET PHY DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	drivers/net/phy/mediatek/airoha-ge-soc.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/net/phy/mediatek/Kconfig b/drivers/net/phy/mediatek/Kconfig
index bb7dc876271e..fe51f4616c54 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,4 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config AIROHA_GE_SOC_PHY
+	tristate "Airoha SoC Ethernet PHYs"
+	depends on ARM64 || COMPILE_TEST
+	depends on ARCH_AIROHA || COMPILE_TEST
+	select MTK_NET_PHYLIB
+	select PHY_PACKAGE
+	help
+	  Supports Airoha SoC built-in Gigabit Ethernet PHYs.
+
+	  Include support for built-in Ethernet PHYs which are present in
+	  the AN7581 and AN7583 SoCs. These PHYs d will dynamically
+	  calibrate during startup.
+
 config MEDIATEK_2P5GE_PHY
 	tristate "MediaTek 2.5Gb Ethernet PHYs"
 	depends on (ARM64 && ARCH_MEDIATEK) || COMPILE_TEST
@@ -24,8 +37,7 @@ config MEDIATEK_GE_PHY
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Ethernet PHYs"
 	depends on ARM64 || COMPILE_TEST
-	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
-		   COMPILE_TEST
+	depends on (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	select PHY_PACKAGE
 	help
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index ac57ecc799fc..eb430f008169 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_AIROHA_GE_SOC_PHY)		+= airoha-ge-soc.o
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
 obj-$(CONFIG_MEDIATEK_GE_SOC_PHY)	+= mtk-ge-soc.o
diff --git a/drivers/net/phy/mediatek/airoha-ge-soc.c b/drivers/net/phy/mediatek/airoha-ge-soc.c
new file mode 100644
index 000000000000..429594f27792
--- /dev/null
+++ b/drivers/net/phy/mediatek/airoha-ge-soc.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/pinctrl/consumer.h>
+#include <linux/phy.h>
+
+#include "mtk.h"
+#include "mtk-ge-soc.h"
+
+#define AIROHA_PHY_MAX_LEDS			2
+
+static int an7581_phy_probe(struct phy_device *phydev)
+{
+	struct mtk_socphy_priv *priv;
+	struct pinctrl *pinctrl;
+
+	/* Toggle pinctrl to enable PHY LED */
+	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
+	if (IS_ERR(pinctrl))
+		dev_err(&phydev->mdio.bus->dev,
+			"Failed to setup PHY LED pinctrl\n");
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
+				       unsigned long modes)
+{
+	u16 val = 0;
+	u32 mode;
+
+	if (index >= AIROHA_PHY_MAX_LEDS)
+		return -EINVAL;
+
+	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
+		switch (mode) {
+		case PHY_LED_ACTIVE_LOW:
+			val = MTK_PHY_LED_ON_POLARITY;
+			break;
+		case PHY_LED_ACTIVE_HIGH:
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
+			      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
+			      MTK_PHY_LED_ON_POLARITY, val);
+}
+
+static int an7583_phy_config_init(struct phy_device *phydev)
+{
+	/* BMCR_PDOWN is enabled by default */
+	return phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
+}
+
+static struct phy_driver mtk_socphy_driver[] = {
+	{
+		PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7581),
+		.name		= "Airoha AN7581 PHY",
+		.config_intr	= genphy_no_config_intr,
+		.handle_interrupt = genphy_handle_interrupt_no_ack,
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+	},
+	{
+		PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7583),
+		.name		= "Airoha AN7583 PHY",
+		.config_init	= an7583_phy_config_init,
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+	},
+};
+
+module_phy_driver(mtk_socphy_driver);
+
+static const struct mdio_device_id __maybe_unused airoha_socphy_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7581) },
+	{ PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_AN7583) },
+	{ }
+};
+
+MODULE_DESCRIPTION("Airoha SoC Gigabit Ethernet PHY driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
+
+MODULE_DEVICE_TABLE(mdio, airoha_socphy_tbl);
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index b4d73954072e..4132ac403583 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -887,73 +887,6 @@ static int mt798x_phy_config_init(struct phy_device *phydev)
 	return mt798x_phy_calibration(phydev);
 }
 
-static int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
-				    unsigned long *delay_on,
-				    unsigned long *delay_off)
-{
-	bool blinking = false;
-	int err;
-
-	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
-	if (err < 0)
-		return err;
-
-	err = mtk_phy_hw_led_blink_set(phydev, index, blinking);
-	if (err)
-		return err;
-
-	return mtk_phy_hw_led_on_set(phydev, index, MTK_GPHY_LED_ON_MASK,
-				     false);
-}
-
-static int mt798x_phy_led_brightness_set(struct phy_device *phydev,
-					 u8 index, enum led_brightness value)
-{
-	int err;
-
-	err = mtk_phy_hw_led_blink_set(phydev, index, false);
-	if (err)
-		return err;
-
-	return mtk_phy_hw_led_on_set(phydev, index, MTK_GPHY_LED_ON_MASK,
-				     (value != LED_OFF));
-}
-
-static const unsigned long supported_triggers =
-	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
-	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
-	BIT(TRIGGER_NETDEV_LINK)        |
-	BIT(TRIGGER_NETDEV_LINK_10)     |
-	BIT(TRIGGER_NETDEV_LINK_100)    |
-	BIT(TRIGGER_NETDEV_LINK_1000)   |
-	BIT(TRIGGER_NETDEV_RX)          |
-	BIT(TRIGGER_NETDEV_TX);
-
-static int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
-					  unsigned long rules)
-{
-	return mtk_phy_led_hw_is_supported(phydev, index, rules,
-					   supported_triggers);
-}
-
-static int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
-					 unsigned long *rules)
-{
-	return mtk_phy_led_hw_ctrl_get(phydev, index, rules,
-				       MTK_GPHY_LED_ON_SET,
-				       MTK_GPHY_LED_RX_BLINK_SET,
-				       MTK_GPHY_LED_TX_BLINK_SET);
-};
-
-static int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
-					 unsigned long rules)
-{
-	return mtk_phy_led_hw_ctrl_set(phydev, index, rules,
-				       MTK_GPHY_LED_ON_SET,
-				       MTK_GPHY_LED_RX_BLINK_SET,
-				       MTK_GPHY_LED_TX_BLINK_SET);
-};
-
 static bool mt7988_phy_led_get_polarity(struct phy_device *phydev, int led_num)
 {
 	struct mtk_socphy_shared *priv = phy_package_get_priv(phydev);
@@ -1090,58 +1023,6 @@ static int mt7981_phy_probe(struct phy_device *phydev)
 	return mt798x_phy_calibration(phydev);
 }
 
-static int an7581_phy_probe(struct phy_device *phydev)
-{
-	struct mtk_socphy_priv *priv;
-	struct pinctrl *pinctrl;
-
-	/* Toggle pinctrl to enable PHY LED */
-	pinctrl = devm_pinctrl_get_select(&phydev->mdio.dev, "gbe-led");
-	if (IS_ERR(pinctrl))
-		dev_err(&phydev->mdio.bus->dev,
-			"Failed to setup PHY LED pinctrl\n");
-
-	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	phydev->priv = priv;
-
-	return 0;
-}
-
-static int an7581_phy_led_polarity_set(struct phy_device *phydev, int index,
-				       unsigned long modes)
-{
-	u16 val = 0;
-	u32 mode;
-
-	if (index >= MTK_PHY_MAX_LEDS)
-		return -EINVAL;
-
-	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
-		switch (mode) {
-		case PHY_LED_ACTIVE_LOW:
-			val = MTK_PHY_LED_ON_POLARITY;
-			break;
-		case PHY_LED_ACTIVE_HIGH:
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-	return phy_modify_mmd(phydev, MDIO_MMD_VEND2, index ?
-			      MTK_PHY_LED1_ON_CTRL : MTK_PHY_LED0_ON_CTRL,
-			      MTK_PHY_LED_ON_POLARITY, val);
-}
-
-static int an7583_phy_config_init(struct phy_device *phydev)
-{
-	/* BMCR_PDOWN is enabled by default */
-	return phy_clear_bits(phydev, MII_BMCR, BMCR_PDOWN);
-}
-
 static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
@@ -1177,31 +1058,6 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
 	},
-	{
-		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581),
-		.name		= "Airoha AN7581 PHY",
-		.config_intr	= genphy_no_config_intr,
-		.handle_interrupt = genphy_handle_interrupt_no_ack,
-		.probe		= an7581_phy_probe,
-		.led_blink_set	= mt798x_phy_led_blink_set,
-		.led_brightness_set = mt798x_phy_led_brightness_set,
-		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
-		.led_hw_control_set = mt798x_phy_led_hw_control_set,
-		.led_hw_control_get = mt798x_phy_led_hw_control_get,
-		.led_polarity_set = an7581_phy_led_polarity_set,
-	},
-	{
-		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7583),
-		.name		= "Airoha AN7583 PHY",
-		.config_init	= an7583_phy_config_init,
-		.probe		= an7581_phy_probe,
-		.led_blink_set	= mt798x_phy_led_blink_set,
-		.led_brightness_set = mt798x_phy_led_brightness_set,
-		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
-		.led_hw_control_set = mt798x_phy_led_hw_control_set,
-		.led_hw_control_get = mt798x_phy_led_hw_control_get,
-		.led_polarity_set = an7581_phy_led_polarity_set,
-	},
 };
 
 module_phy_driver(mtk_socphy_driver);
@@ -1209,8 +1065,6 @@ module_phy_driver(mtk_socphy_driver);
 static const struct mdio_device_id __maybe_unused mtk_socphy_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988) },
-	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581) },
-	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7583) },
 	{ }
 };
 
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
index 9aaa7e3caa41..507e68343576 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -7,8 +7,8 @@
 
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
-#define MTK_GPHY_ID_AN7581			0x03a294c1
-#define MTK_GPHY_ID_AN7583			0xc0ff0420
+#define AIROHA_GPHY_ID_AN7581			0x03a294c1
+#define AIROHA_GPHY_ID_AN7583			0xc0ff0420
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 78b998af5238..8c2b26f9b840 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -342,6 +342,78 @@ void mtk_phy_leds_state_init(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(mtk_phy_leds_state_init);
 
+int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
+			     unsigned long *delay_on,
+			     unsigned long *delay_off)
+{
+	bool blinking = false;
+	int err;
+
+	err = mtk_phy_led_num_dly_cfg(index, delay_on, delay_off, &blinking);
+	if (err < 0)
+		return err;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, blinking);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, MTK_GPHY_LED_ON_MASK,
+				     false);
+}
+EXPORT_SYMBOL_GPL(mt798x_phy_led_blink_set);
+
+int mt798x_phy_led_brightness_set(struct phy_device *phydev,
+				  u8 index, enum led_brightness value)
+{
+	int err;
+
+	err = mtk_phy_hw_led_blink_set(phydev, index, false);
+	if (err)
+		return err;
+
+	return mtk_phy_hw_led_on_set(phydev, index, MTK_GPHY_LED_ON_MASK,
+				     (value != LED_OFF));
+}
+EXPORT_SYMBOL_GPL(mt798x_phy_led_brightness_set);
+
+static const unsigned long supported_triggers =
+	BIT(TRIGGER_NETDEV_FULL_DUPLEX) |
+	BIT(TRIGGER_NETDEV_HALF_DUPLEX) |
+	BIT(TRIGGER_NETDEV_LINK)        |
+	BIT(TRIGGER_NETDEV_LINK_10)     |
+	BIT(TRIGGER_NETDEV_LINK_100)    |
+	BIT(TRIGGER_NETDEV_LINK_1000)   |
+	BIT(TRIGGER_NETDEV_RX)          |
+	BIT(TRIGGER_NETDEV_TX);
+
+int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				   unsigned long rules)
+{
+	return mtk_phy_led_hw_is_supported(phydev, index, rules,
+					   supported_triggers);
+}
+EXPORT_SYMBOL_GPL(mt798x_phy_led_hw_is_supported);
+
+int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+				  unsigned long *rules)
+{
+	return mtk_phy_led_hw_ctrl_get(phydev, index, rules,
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
+};
+EXPORT_SYMBOL_GPL(mt798x_phy_led_hw_control_get);
+
+int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+				  unsigned long rules)
+{
+	return mtk_phy_led_hw_ctrl_set(phydev, index, rules,
+				       MTK_GPHY_LED_ON_SET,
+				       MTK_GPHY_LED_RX_BLINK_SET,
+				       MTK_GPHY_LED_TX_BLINK_SET);
+};
+EXPORT_SYMBOL_GPL(mt798x_phy_led_hw_control_set);
+
 MODULE_DESCRIPTION("MediaTek Ethernet PHY driver common");
 MODULE_AUTHOR("Sky Huang <SkyLake.Huang@mediatek.com>");
 MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
diff --git a/drivers/net/phy/mediatek/mtk.h b/drivers/net/phy/mediatek/mtk.h
index f172f7d671c9..c690aaf38124 100644
--- a/drivers/net/phy/mediatek/mtk.h
+++ b/drivers/net/phy/mediatek/mtk.h
@@ -103,4 +103,16 @@ int mtk_phy_hw_led_blink_set(struct phy_device *phydev, u8 index,
 			     bool blinking);
 void mtk_phy_leds_state_init(struct phy_device *phydev);
 
+int mt798x_phy_led_blink_set(struct phy_device *phydev, u8 index,
+			     unsigned long *delay_on,
+			     unsigned long *delay_off);
+int mt798x_phy_led_brightness_set(struct phy_device *phydev,
+				  u8 index, enum led_brightness value);
+int mt798x_phy_led_hw_is_supported(struct phy_device *phydev, u8 index,
+				   unsigned long rules);
+int mt798x_phy_led_hw_control_get(struct phy_device *phydev, u8 index,
+				  unsigned long *rules);
+int mt798x_phy_led_hw_control_set(struct phy_device *phydev, u8 index,
+				  unsigned long rules);
+
 #endif /* _MTK_EPHY_H_ */
-- 
2.53.0

