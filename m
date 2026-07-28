Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE9355F5F
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253762; cv=none; b=EzWekvYZEScZ00BZA6GzA9bFit9q7YXQxk2VbBKDpNlvdgecu0EAcZTX24gnRMKgXROpRMgMG7XdGlXnmJfZvSH1vP5cgC3voTW0g7hTXFDWev593EiBrxvC+C0bls6i5Qds7f4viVhocxsY7FA7QXXwN0KlDKm9VjhTS2UVCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253762; c=relaxed/simple;
	bh=uAmYukq+RwcKxXEJMl8G5eQ8vP3eL0Jfz4Q1jIhIrM8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YK30HS+davFRGLj2iNlypPVRYGi47apdHtsBsIOC+mycZdPiGzNlIJ7gSnNgSIK9nJY8PQVWu+ey9zNYaBE6Py+JI/tYodT5yhXUMNhePvmJ3bLa5ZNQNXOBOWwJ99LX6BgWIZWFeJdlrjA4sDIu+Uybro62zm+kHhspQHtgpDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hts6idtF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hts6idtF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954aff6088so36010385e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 08:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785253759; x=1785858559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2dadPoGcDVYcRSbj24tq7sECeLdmmZg3bmLdkkgDRUk=;
        b=Hts6idtFFm2QqYM/kHPgGPN+UtHz4Ou6avrc0mn7hdBJnqEj16omPqhuHx6fkIHWB4
         SWvnqEYZBrKp/embxzGxc0eTk3tzEpH6SHZTubqH08uYn5EQM/l9Jkf3iKAI3AmXIuZR
         mLMvLX4f5ksKzLrCdCwy4tDsmhNv9Lvpqi8FggW18Q2+p9zezgVyed7Kxj0z9aPaq3hK
         AH5GmiQQOFyPpU3pGuF+WOOx2vZ6FGbCSg1ZEKOdLKaxaGjPNNxMqh9AN587FQWDBeDs
         /FziIxnY6UTLAUlhNSmHbmzfp/ctXiOJpoQlEEAEyDKEHiaN7gbfPTzy4ZFjaWnNvyN8
         +bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785253759; x=1785858559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2dadPoGcDVYcRSbj24tq7sECeLdmmZg3bmLdkkgDRUk=;
        b=W40VKcfx+YD7alcIaZDs/X2iqaLp6dajHdzHV+eW7mU2mS4iDZYKBJjZY46KEnRzIg
         1mZrvovDAzCR0vI8pXGuekQG6MuPJc6/AQUnQF50580rr/DNVt8U+S0Ds/Pl9a4RyaYH
         82QZzlmOniy2xqadxwHdLH1Bhm1p0gTmECXiWuU30jaTkgyioblgGsiAjp0Ep4Qf6I8V
         vSaV70qrFLNZqokbbSmUuUsm/wrH2eC2W7/naKDZLXEe/wGtkKmLSdCleuvm7oQQcMAw
         DXXs1N3aZs4RCvDxAYTdNsgjccOsU3kvFZ0294nBK8NlWe9AKBqHZVLnfcRj5ioFLfjT
         zZ7Q==
X-Forwarded-Encrypted: i=1; AHgh+RoLceaYfI7OHgPbfC5ziyISfKrk7+NRg3xx9/Vg6l+71iTDjZ4wU4BoVivEaRMznQKeHLlunEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7b2K8EtVdudwPmTRA2lok7AXXbZ0GEGXnhTccRVLdTpvfkAyO
	ak7gurBgLzi/7iw5nTvixZAb7MWOpmp03O0mGgRqdG1ZhZHdMoxZnZqsCFEC/Q==
X-Gm-Gg: AR+sD11F1aHe2y5cxXE6ZI8PAK3O4diBPO1SH8rk4+bd2TFDeJ7akBPrMMZ1LZ+QA0Y
	vv7owj5uiTD6CRgvZNDJKz7JleR2FgHutY30w3jSmYHC++OV8huSbfHURF5RpRbc4RsroEVd9Kx
	l2Frh6Fvo+5Job1+/Au9t55U44EgA6WqgwcGU0jd7gonmiz7BkHxBINS2w8GM9kXxj6Yiicr+j4
	U8L2LFoa0ZbOhmuxKm8apy/SvUqisQv5NjLYvSouXlHuA6WgmsfTmrRbOq1ufdOjPDH56lvWp0w
	qh+be8NzV7enGCOMtluzMHwsLRCMhQ748UYpwMcRXVFp7gB9sGFmjmKsYhc9+qY+TX/cz12I5Fc
	+hebVYO3s6ySRgdJPXKO2cO3ejrUZzaayg1yqFK5P1Bt/W+AkYeRtvMQHYGreMMMjP5/RIKikug
	cWFlX/bVe8wmidJhizyg==
X-Received: by 2002:a05:600c:c8d:b0:493:c8f7:3631 with SMTP id 5b1f17b1804b1-496c6575e33mr30117985e9.22.1785253758858;
        Tue, 28 Jul 2026 08:49:18 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([37.161.95.51])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-496c4632263sm94912035e9.15.2026.07.28.08.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 08:49:17 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v19 05/10] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
Date: Tue, 28 Jul 2026 17:48:32 +0200
Message-ID: <20260728154846.1828945-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728154846.1828945-1-ansuelsmth@gmail.com>
References: <20260728154846.1828945-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN8855 Internal Switch Gigabit PHY.

This is a simple PHY driver to configure and calibrate the PHY for the
AN8855 Switch with the use of NVMEM cells.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/Kconfig      |   5 +
 drivers/net/phy/Makefile     |   1 +
 drivers/net/phy/air_an8855.c | 261 +++++++++++++++++++++++++++++++++++
 3 files changed, 267 insertions(+)
 create mode 100644 drivers/net/phy/air_an8855.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..e2a0dfad5a2a 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -96,6 +96,11 @@ config AIR_AN8801_PHY
 	help
 	  Currently supports the Airoha AN8801R PHY.
 
+config AIR_AN8855_PHY
+	tristate "Airoha AN8855 Internal Gigabit PHY"
+	help
+	  Currently supports the internal Airoha AN8855 Switch PHY.
+
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
 	select AIR_NET_PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..3915444ad883 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -30,6 +30,7 @@ obj-y				+= $(sfp-obj-y) $(sfp-obj-m)
 obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_AIR_AN8801_PHY)	+= air_an8801.o
+obj-$(CONFIG_AIR_AN8855_PHY)	+= air_an8855.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AIR_NET_PHYLIB)	+= air_phy_lib.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
diff --git a/drivers/net/phy/air_an8855.c b/drivers/net/phy/air_an8855.c
new file mode 100644
index 000000000000..e6de1e47f0e7
--- /dev/null
+++ b/drivers/net/phy/air_an8855.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Christian Marangi <ansuelsmth@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+
+#define AN8855_PHY_SELECT_PAGE			0x1f
+#define   AN8855_PHY_PAGE			GENMASK(2, 0)
+#define   AN8855_PHY_PAGE_STANDARD		FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x0)
+#define   AN8855_PHY_PAGE_EXTENDED_1		FIELD_PREP_CONST(AN8855_PHY_PAGE, 0x1)
+
+/* MII Registers Page 1 */
+#define AN8855_PHY_EXT_REG_14			0x14
+#define   AN8855_PHY_EN_DOWN_SHIFT		BIT(4)
+
+/* R50 Calibration regs in MDIO_MMD_VEND1 */
+#define AN8855_PHY_R500HM_RSEL_TX_AB		0x174
+#define AN8855_PHY_R50OHM_RSEL_TX_A_EN		BIT(15)
+#define AN8855_PHY_R50OHM_RSEL_TX_A		GENMASK(14, 8)
+#define AN8855_PHY_R50OHM_RSEL_TX_B_EN		BIT(7)
+#define AN8855_PHY_R50OHM_RSEL_TX_B		GENMASK(6, 0)
+#define AN8855_PHY_R500HM_RSEL_TX_CD		0x175
+#define AN8855_PHY_R50OHM_RSEL_TX_C_EN		BIT(15)
+#define AN8855_PHY_R50OHM_RSEL_TX_C		GENMASK(14, 8)
+#define AN8855_PHY_R50OHM_RSEL_TX_D_EN		BIT(7)
+#define AN8855_PHY_R50OHM_RSEL_TX_D		GENMASK(6, 0)
+
+#define AN8855_SWITCH_EFUSE_R50O		GENMASK(30, 24)
+
+/* PHY TX PAIR DELAY SELECT Register */
+#define AN8855_PHY_TX_PAIR_DLY_SEL_GBE		0x013
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_A_GBE GENMASK(14, 12)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_B_GBE GENMASK(10, 8)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_C_GBE GENMASK(6, 4)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_D_GBE GENMASK(2, 0)
+/* PHY ADC Register */
+#define AN8855_PHY_RXADC_CTRL			0x0d8
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_A	BIT(12)
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_B	BIT(8)
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_C	BIT(4)
+#define   AN8855_PHY_RG_AD_SAMNPLE_PHSEL_D	BIT(0)
+#define AN8855_PHY_RXADC_REV_0			0x0d9
+#define   AN8855_PHY_RG_AD_RESERVE0_A		GENMASK(15, 8)
+#define   AN8855_PHY_RG_AD_RESERVE0_B		GENMASK(7, 0)
+#define AN8855_PHY_RXADC_REV_1			0x0da
+#define   AN8855_PHY_RG_AD_RESERVE0_C		GENMASK(15, 8)
+#define   AN8855_PHY_RG_AD_RESERVE0_D		GENMASK(7, 0)
+
+#define AN8855_PHY_ID				0xc0ff0410
+
+struct air_an8855_priv {
+	bool needs_calibration;
+};
+
+static const u8 dsa_r50ohm_table[] = {
+	127, 127, 127, 127, 127, 127, 127, 127, 127, 127,
+	127, 127, 127, 127, 127, 127, 127, 126, 122, 117,
+	112, 109, 104, 101,  97,  94,  90,  88,  84,  80,
+	78,  74,  72,  68,  66,  64,  61,  58,  56,  53,
+	51,  48,  47,  44,  42,  40,  38,  36,  34,  32,
+	31,  28,  27,  24,  24,  22,  20,  18,  16,  16,
+	14,  12,  11,   9
+};
+
+static int an8855_get_r50ohm_val(struct device *dev, const char *calib_name,
+				 u8 *dest)
+{
+	u32 shift_sel, val;
+	int ret;
+	int i;
+
+	ret = nvmem_cell_read_u32(dev, calib_name, &val);
+	if (ret)
+		return ret;
+
+	shift_sel = FIELD_GET(AN8855_SWITCH_EFUSE_R50O, val);
+	for (i = 0; i < ARRAY_SIZE(dsa_r50ohm_table); i++)
+		if (dsa_r50ohm_table[i] == shift_sel)
+			break;
+
+	if (i < 8 || i >= ARRAY_SIZE(dsa_r50ohm_table))
+		*dest = dsa_r50ohm_table[25];
+	else
+		*dest = dsa_r50ohm_table[i - 8];
+
+	return 0;
+}
+
+static int an8855_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct air_an8855_priv *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->needs_calibration = of_property_present(dev->of_node,
+						      "nvmem-cells");
+
+	phydev->priv = priv;
+
+	return 0;
+}
+
+static int an8855_get_downshift(struct phy_device *phydev, u8 *data)
+{
+	int val;
+
+	val = phy_read_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1, AN8855_PHY_EXT_REG_14);
+	if (val < 0)
+		return val;
+
+	*data = val & AN8855_PHY_EN_DOWN_SHIFT ? DOWNSHIFT_DEV_DEFAULT_COUNT :
+						 DOWNSHIFT_DEV_DISABLE;
+
+	return 0;
+}
+
+static int an8855_set_downshift(struct phy_device *phydev, u8 cnt)
+{
+	u16 ds = cnt != DOWNSHIFT_DEV_DISABLE ? AN8855_PHY_EN_DOWN_SHIFT : 0;
+
+	return phy_modify_paged(phydev, AN8855_PHY_PAGE_EXTENDED_1,
+				AN8855_PHY_EXT_REG_14, AN8855_PHY_EN_DOWN_SHIFT,
+				ds);
+}
+
+static int an8855_config_init(struct phy_device *phydev)
+{
+	struct air_an8855_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	/* Enable HW auto downshift */
+	ret = an8855_set_downshift(phydev, DOWNSHIFT_DEV_DEFAULT_COUNT);
+	if (ret)
+		return ret;
+
+	if (priv->needs_calibration) {
+		u8 calibration_data[4];
+
+		ret = an8855_get_r50ohm_val(dev, "tx_a", &calibration_data[0]);
+		if (ret)
+			return ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_b", &calibration_data[1]);
+		if (ret)
+			return ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_c", &calibration_data[2]);
+		if (ret)
+			return ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_d", &calibration_data[3]);
+		if (ret)
+			return ret;
+
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R500HM_RSEL_TX_AB,
+				     AN8855_PHY_R50OHM_RSEL_TX_A | AN8855_PHY_R50OHM_RSEL_TX_B,
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_A, calibration_data[0]) |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_B, calibration_data[1]));
+		if (ret)
+			return ret;
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R500HM_RSEL_TX_CD,
+				     AN8855_PHY_R50OHM_RSEL_TX_C | AN8855_PHY_R50OHM_RSEL_TX_D,
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_C, calibration_data[2]) |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_D, calibration_data[3]));
+		if (ret)
+			return ret;
+	}
+
+	/* Apply values to reduce signal noise */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_TX_PAIR_DLY_SEL_GBE,
+			    FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_A_GBE, 0x4) |
+			    FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELKAY_SEL_C_GBE, 0x4));
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_CTRL,
+			    AN8855_PHY_RG_AD_SAMNPLE_PHSEL_A |
+			    AN8855_PHY_RG_AD_SAMNPLE_PHSEL_C);
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_REV_0,
+			    FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_A, 0x1));
+	if (ret)
+		return ret;
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_REV_1,
+			    FIELD_PREP(AN8855_PHY_RG_AD_RESERVE0_C, 0x1));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int an8855_get_tunable(struct phy_device *phydev,
+			      struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return an8855_get_downshift(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int an8855_set_tunable(struct phy_device *phydev,
+			      struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_DOWNSHIFT:
+		return an8855_set_downshift(phydev, *(const u8 *)data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int an8855_read_page(struct phy_device *phydev)
+{
+	return __phy_read(phydev, AN8855_PHY_SELECT_PAGE);
+}
+
+static int an8855_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, AN8855_PHY_SELECT_PAGE, page);
+}
+
+static struct phy_driver an8855_driver[] = {
+{
+	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
+	.name			= "Airoha AN8855 internal PHY",
+	/* PHY_GBIT_FEATURES */
+	.flags			= PHY_IS_INTERNAL,
+	.probe			= an8855_probe,
+	.config_init		= an8855_config_init,
+	.soft_reset		= genphy_soft_reset,
+	.get_tunable		= an8855_get_tunable,
+	.set_tunable		= an8855_set_tunable,
+	.suspend		= genphy_suspend,
+	.resume			= genphy_resume,
+	.read_page		= an8855_read_page,
+	.write_page		= an8855_write_page,
+}, };
+
+module_phy_driver(an8855_driver);
+
+static struct mdio_device_id __maybe_unused an8855_tbl[] = {
+	{ PHY_ID_MATCH_EXACT(AN8855_PHY_ID) },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(mdio, an8855_tbl);
+
+MODULE_DESCRIPTION("Airoha AN8855 PHY driver");
+MODULE_AUTHOR("Christian Marangi <ansuelsmth@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.53.0

