Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B544C4854F8
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962295; cv=none; b=by8lawPu7zrdZjGTRz6lGGmNDcXbNJvLXPwtre+a9Q3iDc63WNmDYA/OlWPcvVqX9JyDByzUwKkmEXPY8/JAA1434PDMOuNP/Z2YAC4NjAO+wimrVTNxv/tRk9KhG3OJAufakE3kANfdUOgXQsRA4HCaXxoXKc+29KegWC8jg8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962295; c=relaxed/simple;
	bh=zXbOD/NuuPuL0ZUqFLau0fW98aHIN6lyM2qGXVp/wGM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPjtArH0Ns6dgUcRUJGCEuan/S0eZ6QJ4DvFsxsUQ7d3u7KUyQVH0wrP09z80x+3Bw3Ne1YA2cHpws4o2NZfyKd0QD5GdA7SIK9VpivknjhQnpzYKjqqe9S39QKqcayxMrv7KqX0I85E30BZD6P1qT+XfaNZIKmX1SgMiKO5cls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsHRUOxg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsHRUOxg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a17baef589so5256185e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962291; x=1792567091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=45cGEGEQHTHh9ijxdWI1Kpx2xtUu6bWZW4U6DTcr4DU=;
        b=PsHRUOxgfIxr18QzRUkjHbx8mHPJjd9O9JXd5t8t30F3O5eHlprGnG/rHIcx637zP7
         G5RR4Zxn3l+dnhSmqRDkLo/LTJKX5Efl8nkWnJdB9a+Z1lOdS5LaAHMnyCHBjK7Y6KM/
         ifsZiICSv2REWazIwfUmCUNB66qlJqtrjrMfKOsA2LpkCfQ2s58Xdc1/vJtD7jYptm0g
         hpcpqiHnfzGz6fjzB/LqwjA45FUlsh8N7GM8/2Z6G9n0hsHhe8I2tcJMO+klLLC3GjxG
         UIUqYR7DoUqHwNQsVLXGXfU82Vez4Q9zmoM/6aZAkyLXN7Kr1lVoDs/C+Hp7RSyKM+Km
         lomw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962291; x=1792567091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=45cGEGEQHTHh9ijxdWI1Kpx2xtUu6bWZW4U6DTcr4DU=;
        b=cUYbNHpHdS5a4VPLKJNrAiUisDxvbczNpspAw1E3sL9ceHuoqhCR2MXlNNCL34VZon
         BGEAMXIADuuoLxKyJbFLCVTrjaUsB6DD4YZoNicEjcn5LuIxQzb6mm8C8w7ERHRW00Qo
         6I8nHlWms1VsyiEbkEnznuLIlOfXUBSVatbsA4O9/JOd2FnYcbIwjPGtfxslj0pey1Nl
         UfisXu4ih1sCY9oWTRlGzNSYun2SND1q3l2AtGjK0arF38LcCzSvFiUX5Fk9YCszZVsD
         l0kmRrNtIsqSzTp2YzlQVehURTJM0n0AJpQYDUR/EYHPW/8Q/cbrX5Mtxq3wq1PAwTG/
         OKPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzI/Ghua3RsnVUONb+eUTCOt4gWoLTYk32UgCO+6tXB9JDjH2zhyqQ6CGHNW5gppZYSqTTqJIY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKS2jr6oXt6MgNc3LbCJ2wG26qXHa5GYdR8TLzKkqDtexqSrBft
	e5pAmNhmDHO0YO7nk39Xw30OPmwKKtbRfbHJwUrhP5YEdEncz65nVoFs
X-Gm-Gg: AYBFou3Wqmo1UqFEZazhwVmmxJgtgMjR/Tqj+1snZcGhlq3fS61eyb0FHkhMMVkjHFa
	8gaG90be5ana3wweooJDmJXqhq2TLGg3BYJoiMB4oe/oqHZxT5sb+kGYQ6hI23oTY7MwRUgkLrU
	H5gGELgdbcr3vlDrMM2ppyuJk1zLjLMX4TJm3/vh4U7ojjBN7ff3YImrMAI2WTynrmOhRjxgI0a
	0WxYg8z6zdNZdbv7Ii33RXuP70Nxr3j+1GtYcyWWGcklrvv4LxpXotZhRoYXPUSKvcZ4IAMk/KQ
	9sFxyv41wwLpmxi2eIMl7/dw/wwYTe7/h5T0QbpGkkdUssajJuJvX8+mq5bVUzZRVRFWw3cnFx7
	F99T3pDp96s2oKTsd5ukUZdxx7woTWUWJ1anICVOWjwX1G0xoarLGisDD2aZyfzXyIffeR/B8tT
	61yoG7f3Oh2rL7lpqR0Dgs/sI9Zs23IesOHJDchmhmfNBRLRqtVgHSXHKQHoYRzOifikft+8HSf
	obEjbNL9DYmjCzPX9BT3CfwhuUbZUYzjyf6N2CIDRqDRT/mkSDxe0vDDB+KtY/ScRRcvqGipfJe
	/G6IXsLc3v/dV+zaK4BYXA==
X-Received: by 2002:a05:600c:8208:b0:4a0:1b14:d00c with SMTP id 5b1f17b1804b1-4a18e446f55mr290626105e9.3.1791962290800;
        Wed, 14 Oct 2026 00:18:10 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-235-252-189.retail.telecomitalia.it. [95.235.252.189])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1b35d64e4sm18756285e9.0.2026.10.14.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:18:10 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ahmed Naseef <naseefkm@gmail.com>,
	Joris Vaisvila <joey@tinyisr.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 4/6] net: phy: mediatek: split Airoha code to dedicated source
Date: Wed, 14 Oct 2026 09:17:35 +0200
Message-ID: <20261014071739.216345-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014071739.216345-1-ansuelsmth@gmail.com>
References: <20261014071739.216345-1-ansuelsmth@gmail.com>
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
 drivers/net/phy/mediatek/Kconfig         |  18 ++-
 drivers/net/phy/mediatek/Makefile        |   1 +
 drivers/net/phy/mediatek/airoha-ge-soc.c | 128 +++++++++++++++++
 drivers/net/phy/mediatek/mtk-ge-soc.c    | 172 -----------------------
 drivers/net/phy/mediatek/mtk-ge-soc.h    |   6 +-
 drivers/net/phy/mediatek/mtk-phy-lib.c   |  72 ++++++++++
 drivers/net/phy/mediatek/mtk.h           |  12 ++
 8 files changed, 239 insertions(+), 178 deletions(-)
 create mode 100644 drivers/net/phy/mediatek/airoha-ge-soc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 78d4489eeb6d..7ad81a83d670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,6 +759,14 @@ S:	Maintained
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
index 3b9cf82c0cb2..15f4481b9dc1 100644
--- a/drivers/net/phy/mediatek/Kconfig
+++ b/drivers/net/phy/mediatek/Kconfig
@@ -1,4 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
+config AIROHA_GE_SOC_PHY
+	tristate "Airoha SoC Gigabit Ethernet PHYs"
+	depends on ARM64 || ECONET || COMPILE_TEST
+	depends on ARCH_AIROHA || ECONET || COMPILE_TEST
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
@@ -32,9 +45,8 @@ config MEDIATEK_FE_SOC_PHY
 
 config MEDIATEK_GE_SOC_PHY
 	tristate "MediaTek SoC Gigabit Ethernet PHYs"
-	depends on ARM64 || ECONET || COMPILE_TEST
-	depends on ARCH_AIROHA || (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || \
-		   ECONET || COMPILE_TEST
+	depends on ARM64 || COMPILE_TEST
+	depends on (ARCH_MEDIATEK && NVMEM_MTK_EFUSE) || COMPILE_TEST
 	select MTK_NET_PHYLIB
 	select PHY_PACKAGE
 	help
diff --git a/drivers/net/phy/mediatek/Makefile b/drivers/net/phy/mediatek/Makefile
index 6f9cacf7f906..5594057f51d0 100644
--- a/drivers/net/phy/mediatek/Makefile
+++ b/drivers/net/phy/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_AIROHA_GE_SOC_PHY)		+= airoha-ge-soc.o
 obj-$(CONFIG_MEDIATEK_2P5GE_PHY)	+= mtk-2p5ge.o
 obj-$(CONFIG_MEDIATEK_FE_SOC_PHY)	+= mtk-fe-soc.o
 obj-$(CONFIG_MEDIATEK_GE_PHY)		+= mtk-ge.o
diff --git a/drivers/net/phy/mediatek/airoha-ge-soc.c b/drivers/net/phy/mediatek/airoha-ge-soc.c
new file mode 100644
index 000000000000..e40e4597cd94
--- /dev/null
+++ b/drivers/net/phy/mediatek/airoha-ge-soc.c
@@ -0,0 +1,128 @@
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
+static int en7528_phy_config_init(struct phy_device *phydev)
+{
+	/* The LED controller of the EN7528 powers up with its external
+	 * control disabled, leaving the LED pins dark regardless of what is
+	 * programmed into the LED control registers. Hand the pins over to
+	 * the LED control registers the same way the air_en8811h driver
+	 * does; the mode field of this register is already set out of reset.
+	 */
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED_BCR,
+				MTK_PHY_LED_BCR_CLK_EN |
+				MTK_PHY_LED_BCR_EXT_CTRL);
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
+		PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_EN7528),
+		.name		= "EcoNet EN7528 PHY",
+		.config_init	= en7528_phy_config_init,
+		.probe		= an7581_phy_probe,
+		.led_blink_set	= mt798x_phy_led_blink_set,
+		.led_brightness_set = mt798x_phy_led_brightness_set,
+		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
+		.led_hw_control_set = mt798x_phy_led_hw_control_set,
+		.led_hw_control_get = mt798x_phy_led_hw_control_get,
+		.led_polarity_set = an7581_phy_led_polarity_set,
+	},
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
+	{ PHY_ID_MATCH_EXACT(AIROHA_GPHY_ID_EN7528) },
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
index f3ce6e67eb38..4132ac403583 100644
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
@@ -1090,71 +1023,6 @@ static int mt7981_phy_probe(struct phy_device *phydev)
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
-static int en7528_phy_config_init(struct phy_device *phydev)
-{
-	/* The LED controller of the EN7528 powers up with its external
-	 * control disabled, leaving the LED pins dark regardless of what is
-	 * programmed into the LED control registers. Hand the pins over to
-	 * the LED control registers the same way the air_en8811h driver
-	 * does; the mode field of this register is already set out of reset.
-	 */
-	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND2, MTK_PHY_LED_BCR,
-				MTK_PHY_LED_BCR_CLK_EN |
-				MTK_PHY_LED_BCR_EXT_CTRL);
-}
-
 static struct phy_driver mtk_socphy_driver[] = {
 	{
 		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981),
@@ -1190,43 +1058,6 @@ static struct phy_driver mtk_socphy_driver[] = {
 		.led_hw_control_set = mt798x_phy_led_hw_control_set,
 		.led_hw_control_get = mt798x_phy_led_hw_control_get,
 	},
-	{
-		PHY_ID_MATCH_EXACT(MTK_GPHY_ID_EN7528),
-		.name		= "EcoNet EN7528 PHY",
-		.config_init	= en7528_phy_config_init,
-		.probe		= an7581_phy_probe,
-		.led_blink_set	= mt798x_phy_led_blink_set,
-		.led_brightness_set = mt798x_phy_led_brightness_set,
-		.led_hw_is_supported = mt798x_phy_led_hw_is_supported,
-		.led_hw_control_set = mt798x_phy_led_hw_control_set,
-		.led_hw_control_get = mt798x_phy_led_hw_control_get,
-		.led_polarity_set = an7581_phy_led_polarity_set,
-	},
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
@@ -1234,9 +1065,6 @@ module_phy_driver(mtk_socphy_driver);
 static const struct mdio_device_id __maybe_unused mtk_socphy_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7981) },
 	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_MT7988) },
-	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_EN7528) },
-	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7581) },
-	{ PHY_ID_MATCH_EXACT(MTK_GPHY_ID_AN7583) },
 	{ }
 };
 
diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.h b/drivers/net/phy/mediatek/mtk-ge-soc.h
index 14370b5ce482..419d87a341a0 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.h
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.h
@@ -7,9 +7,9 @@
 
 #define MTK_GPHY_ID_MT7981			0x03a29461
 #define MTK_GPHY_ID_MT7988			0x03a29481
-#define MTK_GPHY_ID_EN7528			0x03a29491
-#define MTK_GPHY_ID_AN7581			0x03a294c1
-#define MTK_GPHY_ID_AN7583			0xc0ff0420
+#define AIROHA_GPHY_ID_EN7528			0x03a29491
+#define AIROHA_GPHY_ID_AN7581			0x03a294c1
+#define AIROHA_GPHY_ID_AN7583			0xc0ff0420
 
 #define MTK_EXT_PAGE_ACCESS			0x1f
 #define MTK_PHY_PAGE_STANDARD			0x0000
diff --git a/drivers/net/phy/mediatek/mtk-phy-lib.c b/drivers/net/phy/mediatek/mtk-phy-lib.c
index 3e4fb899a85b..dc4abd95d73f 100644
--- a/drivers/net/phy/mediatek/mtk-phy-lib.c
+++ b/drivers/net/phy/mediatek/mtk-phy-lib.c
@@ -339,6 +339,78 @@ void mtk_phy_leds_state_init(struct phy_device *phydev)
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
index 3565e39b96a8..bc46646a95fd 100644
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
2.55.0

