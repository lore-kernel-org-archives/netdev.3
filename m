Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A354EBAC3
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791562286; cv=none; b=cQe3r8sAoh/kAKNcILimR5oVIfjse70/+B2cyoEi0l1yCLpA3rUeYqMp1OcQhjKMQOOY9BYjnKfKSKfqoM1zxqLgY/4cTajKrfEFPBTN/L6Ifeg/MLvdx6Es0Ju1UM8BHA4TNM8N89lOhPHYPZGPgwLy2pauGOVKV+wrflFzwU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791562286; c=relaxed/simple;
	bh=Tk1bCAYhLsmyvPuL10obACPflxis9NCVo3pI361whto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZGN1kZ2x0WGszx9WkyZYNWwN/qk2e284Zq8LYvYacnSrF2FarcdFZ55hM9sym9ghVvSuUhLLx/lboHZ8pyshF2uRwYJ8pqxOSQPHRiQqvVuO2Cg4U9SmTV1XIf9oGdePj5o2UIb/jh/hh7cLGAtv5QtHrT653aLi2MsAfVQ6FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcuOUDsl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcuOUDsl"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48b001cd92bso3469344f8f.2
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 09:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791562281; x=1792167081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1AlJviyEsn0JwTEbIVJIrAaLLKDRuGfTWO+8DDkJVk=;
        b=CcuOUDsl8cnRW/ONAOgBLJRbP71rURSroiMi03XsShkyKVmO1p0muQhWmpeznbyvfS
         eD24bruISyYm7VqPSRsngyEe9wCFr6KSjvI7cSdWRj+aleKiJKXiYsHfR1qbs+RRnhBY
         xzP6T3p/AD0qRPUFJciXK0zoDi4/jjKhJLxehG5kttouA2qvd8ByQARNub0iYFLZDCCj
         SNfmQC1mYvK+F9YD0CS5C4vQsR95gx4t2p5LKX9dgziP0e4OQGJZ6/Iy9KVdpAC9fBo3
         mMu1AhvQu7mr1O2mgRr/K8G2kph15UJJjbvLF39/glF6tekDqUYQOxiaPJe59h2/fY8r
         UAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791562281; x=1792167081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U1AlJviyEsn0JwTEbIVJIrAaLLKDRuGfTWO+8DDkJVk=;
        b=QX+KS8uOCr7HTBEqCSiahW0u3EztPN3xe3dAz6DA4s6EuL7kY5zV6Rx9a5lWWYh2Ik
         rgqJC5miNJuVCS4lpFy9/tGOf4jyUEWJ0ekeXdDlrB7csHUC0OGMBzKGZoQjJTV67MZb
         6gcLfjUxA0uEWy9g0McIrZ/gU+4hvyPEFzspKPvcMrqtOhvnkuvPdCbg6kWFY5TPz0SR
         Lua7VyiUI2s7hoJ4OW2HYnzkmMTczpm3Dai3NJErpQUeiPhyLV3rpfDlbjwT/A6Dxqb4
         760cBQtU0Nxw4GgXPjw8Mx2AoBE0OnL4BdEk/c2FUCEhd857ydewNhIOecr9wVOMgeBD
         FYGw==
X-Forwarded-Encrypted: i=1; AKwUvBy9WV89utr5onaqg8+3oOeu2qM+ZkE4eIKlW+qi4DtR9sGEHgH6iJCn9YB4QmRasA3oZRxOqm0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcGDx3MSnYZHSOgI/UWcP8LmFTe7tQYEGRBEhtcx5qnQUfNS2x
	uu4gEHhSEwpF1EAKUfVaTmYjm0zf0kCxpxDb0Bi+fUR18BXRps2PSEmg
X-Gm-Gg: AYBFou2wiQ12tjvAxQy6c4rE0gBlb1TzRXeJRyl5Qd+TL7Wrxw1mY4xiooKn7Ld2V9q
	pqweK4Pw+l9eMpigfSmhwCnrEYfs3Xn8hx2eRpJPDwXmrmRRruIN86nruHtsWYCIIt1SzUj+3iz
	xFGlLZY/uO6ZL6ITg7kGm9El5k73JPOhz6oMcgSWBknSkIWgjC2foRgNN9eh1mYa056fqV11d3S
	4Y6kJBjnaTVt3Z89/CgFy1i1D24w3WoXyr7nyQ7F1Gvp9+x3G+qC/aCRqwdAmIwuEs11wO5+s/n
	a6lmfVVJUXdxACSLdNzNOt95VEPjBwb6YWiRu9WCOwBpGes0LdewDXFqeGtxXkNiG/jcPqesb+y
	RYsEi7ytwbcQ4rCfwNj86JAVbu7EYmzN1jajiFOscsJxfWEUOoMbSwtnWBy8fa9akT5JO2APNxO
	2JQKqi4Ci78DQTeY4kWsvbTbDAxKE91xm1fggytJE+rsyoBFB6y2Kujf6duw1QJqnrfIBZCS8SC
	pQYtXb9N+ly4muDpY/hEEfkYyHXVyGl0YmQ68U2hZmnTNBF5DD3cwn0zWScNMOJKbd+bgnt4/x3
	QxfDZM0OQf1nXjlbOA==
X-Received: by 2002:a05:6000:4811:b0:488:7da0:fedb with SMTP id ffacd0b85a97d-48dbace3b1fmr4014645f8f.40.1791562281084;
        Fri, 09 Oct 2026 09:11:21 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-213-45-9-252.retail.telecomitalia.it. [213.45.9.252])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48db94e2f08sm4744701f8f.15.2026.10.09.09.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:11:20 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
	Joris Vaisvila <joey@tinyisr.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v25 05/10] net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
Date: Fri,  9 Oct 2026 18:10:50 +0200
Message-ID: <20261009161102.38961-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009161102.38961-1-ansuelsmth@gmail.com>
References: <20261009161102.38961-1-ansuelsmth@gmail.com>
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
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/Kconfig      |   6 +
 drivers/net/phy/Makefile     |   1 +
 drivers/net/phy/air_an8855.c | 275 +++++++++++++++++++++++++++++++++++
 3 files changed, 282 insertions(+)
 create mode 100644 drivers/net/phy/air_an8855.c

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d3835597e379..eca2ce135c86 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -96,6 +96,12 @@ config AIR_AN8801_PHY
 	help
 	  Currently supports the Airoha AN8801R PHY.
 
+config AIR_AN8855_PHY
+	tristate "Airoha AN8855 Internal Gigabit PHY"
+	depends on NVMEM || !NVMEM
+	help
+	  Currently supports the internal Airoha AN8855 Switch PHY.
+
 config AIR_EN8811H_PHY
 	tristate "Airoha EN8811H 2.5 Gigabit PHY"
 	select AIR_NET_PHYLIB
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 579066a638f0..d5c633db0742 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_ADIN_PHY)		+= adin.o
 obj-$(CONFIG_ADIN1100_PHY)	+= adin1100.o
 obj-$(CONFIG_ADIN1140_PHY)	+= adin1140-phy.o
 obj-$(CONFIG_AIR_AN8801_PHY)	+= air_an8801.o
+obj-$(CONFIG_AIR_AN8855_PHY)	+= air_an8855.o
 obj-$(CONFIG_AIR_EN8811H_PHY)   += air_en8811h.o
 obj-$(CONFIG_AIR_NET_PHYLIB)	+= air_phy_lib.o
 obj-$(CONFIG_AMD_PHY)		+= amd.o
diff --git a/drivers/net/phy/air_an8855.c b/drivers/net/phy/air_an8855.c
new file mode 100644
index 000000000000..bc22256fd5f9
--- /dev/null
+++ b/drivers/net/phy/air_an8855.c
@@ -0,0 +1,275 @@
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
+#define AN8855_PHY_R50OHM_RSEL_TX_AB		0x174
+#define AN8855_PHY_R50OHM_RSEL_TX_A_EN		BIT(15)
+#define AN8855_PHY_R50OHM_RSEL_TX_A		GENMASK(14, 8)
+#define AN8855_PHY_R50OHM_RSEL_TX_B_EN		BIT(7)
+#define AN8855_PHY_R50OHM_RSEL_TX_B		GENMASK(6, 0)
+#define AN8855_PHY_R50OHM_RSEL_TX_CD		0x175
+#define AN8855_PHY_R50OHM_RSEL_TX_C_EN		BIT(15)
+#define AN8855_PHY_R50OHM_RSEL_TX_C		GENMASK(14, 8)
+#define AN8855_PHY_R50OHM_RSEL_TX_D_EN		BIT(7)
+#define AN8855_PHY_R50OHM_RSEL_TX_D		GENMASK(6, 0)
+
+#define AN8855_SWITCH_EFUSE_R50O		GENMASK(30, 24)
+
+/* PHY TX PAIR DELAY SELECT Register */
+#define AN8855_PHY_TX_PAIR_DLY_SEL_GBE		0x013
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_A_GBE GENMASK(14, 12)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_B_GBE GENMASK(10, 8)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_C_GBE GENMASK(6, 4)
+#define   AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_D_GBE GENMASK(2, 0)
+/* PHY ADC Register */
+#define AN8855_PHY_RXADC_CTRL			0x0d8
+#define   AN8855_PHY_RG_AD_SAMPLE_PHSEL_A	BIT(12)
+#define   AN8855_PHY_RG_AD_SAMPLE_PHSEL_B	BIT(8)
+#define   AN8855_PHY_RG_AD_SAMPLE_PHSEL_C	BIT(4)
+#define   AN8855_PHY_RG_AD_SAMPLE_PHSEL_D	BIT(0)
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
+	u8 calibration_data[4];
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
+	if (priv->needs_calibration) {
+		int ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_a", &priv->calibration_data[0]);
+		if (ret)
+			return ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_b", &priv->calibration_data[1]);
+		if (ret)
+			return ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_c", &priv->calibration_data[2]);
+		if (ret)
+			return ret;
+
+		ret = an8855_get_r50ohm_val(dev, "tx_d", &priv->calibration_data[3]);
+		if (ret)
+			return ret;
+	}
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
+	int ret;
+
+	/* Enable HW auto downshift */
+	ret = an8855_set_downshift(phydev, DOWNSHIFT_DEV_DEFAULT_COUNT);
+	if (ret)
+		return ret;
+
+	if (priv->needs_calibration) {
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R50OHM_RSEL_TX_AB,
+				     AN8855_PHY_R50OHM_RSEL_TX_A_EN | AN8855_PHY_R50OHM_RSEL_TX_A |
+				     AN8855_PHY_R50OHM_RSEL_TX_B_EN | AN8855_PHY_R50OHM_RSEL_TX_B,
+				     AN8855_PHY_R50OHM_RSEL_TX_A_EN |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_A,
+						priv->calibration_data[0]) |
+				     AN8855_PHY_R50OHM_RSEL_TX_B_EN |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_B,
+						priv->calibration_data[1]));
+		if (ret)
+			return ret;
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_R50OHM_RSEL_TX_CD,
+				     AN8855_PHY_R50OHM_RSEL_TX_C_EN | AN8855_PHY_R50OHM_RSEL_TX_C |
+				     AN8855_PHY_R50OHM_RSEL_TX_D_EN | AN8855_PHY_R50OHM_RSEL_TX_D,
+				     AN8855_PHY_R50OHM_RSEL_TX_C_EN |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_C,
+						priv->calibration_data[2]) |
+				     AN8855_PHY_R50OHM_RSEL_TX_D_EN |
+				     FIELD_PREP(AN8855_PHY_R50OHM_RSEL_TX_D,
+						priv->calibration_data[3]));
+		if (ret)
+			return ret;
+	}
+
+	/* Apply values to reduce signal noise */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_TX_PAIR_DLY_SEL_GBE,
+			     AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_A_GBE |
+			     AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_C_GBE,
+			     FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_A_GBE, 0x4) |
+			     FIELD_PREP(AN8855_PHY_CR_DA_TX_PAIR_DELAY_SEL_C_GBE, 0x4));
+	if (ret)
+		return ret;
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, AN8855_PHY_RXADC_CTRL,
+			       AN8855_PHY_RG_AD_SAMPLE_PHSEL_A |
+			       AN8855_PHY_RG_AD_SAMPLE_PHSEL_C);
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
2.55.0

