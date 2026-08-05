Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45863C8194
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896921; cv=none; b=EPh6IvCtQITeqVqM0O3hNmaftW/nlT/zjWA7OVmi+o3ssXJOd0dGuTeNtOFC6sH6qdD8ELK4vUbUaFy6/h5o4POmfk1ygnyo1yYlv0MuTGKA6yPD2K3DEgZYfxerlk72uJa1LUVzTUvGs7DXTEgd8VM+tKcECMO1ixCHHPIq7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896921; c=relaxed/simple;
	bh=tHO5yBuqCrRzthf4FCgHKrDW7oQG+8YTZFwaAVI9jHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+Y2hgC4kk5DDyE+6+05rnLXE8ukLG3j2bCHuibNPz8G/ErVURKtbFpjN+l/z/EwtYZLaB+Aj8cCZd5QnZBmlOfKzESOR7DjcRKNmbiqA1Za54aAM+ZjE+LoLBwfqPRmfw9zAsoXUPygn7AhCM/toFf8mRixV8swM04W3Eeg7XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1peeJIO; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1peeJIO"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7eb4d532e65so271720a34.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896916; x=1786501716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7n627btFdgAMk+nFRlo8bZ30B6WMW9WO37DeKOzDqM=;
        b=X1peeJIOQmn/neHhiGftMdb1Rf0rms7qJpI4Kq0/uAzYnbP+4aD5jznPNJGLzz20ho
         hVkeL4iB286gg8jiDsAv8FJLjUphLQzdmNLjZZ2Dwym6dUQtA+wcOd5EyN3sVp7NuhdC
         EmPdaiDgTU24iG/hkKzb04IMol2bRKHg/UptICeH5bG8AHQa+BeloSNbImPoFsacHF/s
         Fh8V/L+bptEFV3bfK9fD+oum1kbdnCj8xqdDLfnANUVCRh5wOq32+lq9TTCe2iplCh/Z
         AIVJENn5XLUPkz0T2z+076Tv/SjiNFVEUGMGrotpCmcz/gPqE9ClyQRugBR7xDQqyBka
         1gZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896916; x=1786501716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7n627btFdgAMk+nFRlo8bZ30B6WMW9WO37DeKOzDqM=;
        b=HD3I5gyo9PjSz1TeBNUfs3oicHIunoFKO8DCT/L8Ne1fOSnqoM5M/mKzXwXiPkm9OZ
         3CNv4M5TQOTfTQQzZtbCIzmPH50E1pM8mzFbsFj13qJWGFy6dnGrZ+JeZJL1vtjRUAQ9
         Sovn6eRpjSwDzGJxJ94b/VB0YncDotHXQ9GYnTk1TLrlIw8zrOUFi5l1WvBx9pJooM9y
         NtnEHE6ajLJMuB/n1drpZgUkYBbY9nXaZHs4FuCA03ucKCFHun7QyMJyKYg95gyT0h3F
         7EaRQI+qD/fKixXYBzad6XRilZIpaZ6EgPC9WsvqpH8sZSFtRYk5EIiURVYpa0hC7kS4
         mepw==
X-Gm-Message-State: AOJu0YxbS7rJZZ34fXxnMEVlorXgGVQ8wJqjRlxwD0jvAH0i3dmp32YE
	NEA58oJU9St4vsKgNCM9w6OxMGT53OK74IQtrHKKIbIWYlNTALikjgJk
X-Gm-Gg: AR+sD13MyX/KiOP8lrRD6VQIJtGZ1XgZiocawpvcUfm9GwIa2kxL4wpWnsOJKZqxHGg
	ey1exPyssquYEW3WDTVNSzIduHB9kNN32OyVQK98/FguiIzHbDgK2nLiCHeDMGftIVazy90uCQt
	i0cQ4GaVfQLBerhrMJy1qnGITe9ag+6I1iJaeA6+i6kYg8K0j+/4e8odLOMHPVdX8UPQnq54uo3
	wkFx8YDtzZZwAW5f30zS/C4dUkRoYvh1WxoCElNUYGvkMj1ZVkav6jmpseGKzf/nSCHoJH7Mo0M
	A2xXPo/3exqMf3y0TwneLa3f/rGb/BWFoZjzYWK8oLiv1MoolkDnXhwd1CU21DEEzkBdkrNcQP5
	MK6kcfJlOOCChGoW0nDI59+/McFxmPo49pbZTX1lWA2xkTsy5MrLkjqAoAJKJ9hl4fsWN6RZBai
	hMawGV0Bl9HduDKOHIngwVGg9BEUWvs8yHocMjo/QnabatlLB3mYTjZosZbxrvHvCaAPxAx22mm
	XKx199Sar+5hdKG5zE8cWTCHXuOgsi1TSqCyQzZB2IW9VxlusZUdnNnUYnnIFbwvg51ohBHZ9u5
	VIpYMJcmeZcZNfs+kTdQD0F7ufVS7NR9avqej3lXMgvTDJKjUoPTgT49X9jZ9ztHjuYYzTDXpIB
	O2eelDxX0iOcyhwTc
X-Received: by 2002:a05:6830:3489:b0:7e9:bf64:b70b with SMTP id 46e09a7af769-7f1e5c2af15mr2626135a34.1.1785896916416;
        Tue, 04 Aug 2026 19:28:36 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:36 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:27:06 -0600
Subject: [PATCH net-next v2 8/8] net: phy: add X-Powers AC200/AC300 EPHY
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-8-3eef49ff1d8c@gmail.com>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The AC200 and AC300 MDIO link endpoints report the same Clause 22
identifier and use a compatible link-side paged register layout. Their
identification registers are inaccessible until a package-specific
control path powers and configures the block.

Add a common PHY driver which matches the firmware-provided identifier
only when the node also references one X-Powers control device. Validate
that reference and the AC300 address relationship, defer until the
provider is bound, and create a managed device link to protect its
lifetime and order teardown and power management.

When the optional two-bit SID configuration field is present, verify that
its package-selector bit agrees with the fixed control reference. Use its
second bit to select the AC300 low-calibration tuning sequence. Omitting
the field skips package validation and selects the normal sequence.

Power the control block in reset-default MII mode during PHY probe. Once
the MAC supplies phydev->interface, pass MII or RMII to the provider
before the normal PHY soft reset. Program the AC200 link address through
its provider and let the AC300 provider validate its strapped address.

Apply the common vendor analog initialization, with the package-specific
normal value and the optional AC300 low-calibration sequence. Support the
board-selected xMII receive-clock inversion and leave MDI/MDI-X in its
vendor automatic mode. Disable standard and Intelligent EEE initially,
then restore phylib's standard EEE policy after later resets.

Power the package control block down with the PHY and restore the vendor
configuration on resume. If power-off fails, attempt to restore the PHY
before returning the original suspend error.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/Kconfig         |   9 +
 drivers/net/phy/Makefile        |   1 +
 drivers/net/phy/xpowers-acx00.c | 544 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 554 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 7535db7f3471..c505ade5955c 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -493,6 +493,15 @@ config XPOWERS_AC300_PHY_CTL
 	  interface mode, clock and I/O controls through the separate MDIO
 	  control address.
 
+config XPOWERS_ACX00_PHY
+	tristate "X-Powers AC200/AC300 Ethernet PHY"
+	depends on OF_MDIO
+	help
+	  Enable the Fast Ethernet PHY driver shared by the X-Powers AC200
+	  and AC300 companion ICs. This driver configures their common MDIO PHY
+	  registers and uses one statically selected package-control provider for
+	  power, calibration and interface setup.
+
 config XILINX_GMII2RGMII
 	tristate "Xilinx GMII2RGMII converter driver"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 0c4e40c9a28a..db71f1c2b756 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -102,4 +102,5 @@ obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_XPOWERS_AC200_PHY_CTL) += xpowers-ac200-ctl.o
 obj-$(CONFIG_XPOWERS_AC300_PHY_CTL) += xpowers-ac300-ctl.o
+obj-$(CONFIG_XPOWERS_ACX00_PHY)	+= xpowers-acx00.o
 obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
diff --git a/drivers/net/phy/xpowers-acx00.c b/drivers/net/phy/xpowers-acx00.c
new file mode 100644
index 000000000000..f9e6be751252
--- /dev/null
+++ b/drivers/net/phy/xpowers-acx00.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC200/AC300 Ethernet PHY driver
+ *
+ * Copyright (C) 2019 Jernej Skrabec <jernej.skrabec@gmail.com>
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+
+#include "xpowers-acx00.h"
+
+#define ACX00_EPHY_ID				0x00441400
+
+#define ACX00_EPHY_CONFIG_VARIANT_AC300		BIT(0)
+#define ACX00_EPHY_CONFIG_CALIBRATION_LOW	BIT(1)
+
+#define ACX00_PAGE_SELECT_REG			0x1f
+#define ACX00_PAGE_SELECT_MASK			GENMASK(12, 8)
+#define ACX00_PAGE_0				0
+#define ACX00_PAGE_1				1
+#define ACX00_PAGE_2				2
+#define ACX00_PAGE_6				6
+#define ACX00_PAGE_8				8
+
+#define ACX00_PAGE0_GLOBAL_CONFIG_REG		0x13
+#define ACX00_PAGE0_XMII_RX_CLOCK_INVERT	BIT(12)
+#define ACX00_PAGE0_MDI_MODE_MASK		GENMASK(1, 0)
+#define ACX00_PAGE0_MDI_MODE_AUTO		2
+
+#define ACX00_PAGE1_APS_CONTROL_REG		0x12
+#define ACX00_PAGE1_APS_DISABLED_4S_VALUE	0x4824
+#define ACX00_PAGE1_UAPS_CONTROL_REG		0x13
+#define ACX00_PAGE1_UAPS_ENABLE			BIT(15)
+#define ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG	0x17
+#define ACX00_PAGE1_INTELLIGENT_EEE_ENABLE	BIT(3)
+
+#define ACX00_PAGE2_TX_DATA_CONTROL_REG		0x18
+#define ACX00_PAGE2_10BT_FIR_SELECT_MASK		GENMASK(14, 12)
+#define ACX00_PAGE2_10BT_FIR_SELECT_DEFAULT	0
+
+#define ACX00_PAGE6_ADC_CONTROL_REG		0x10
+#define ACX00_PAGE6_ADC_CONTROL_LOW_CAL_VALUE	0x5523
+#define ACX00_PAGE6_AFE_RX_CONTROL_REG		0x13
+#define ACX00_PAGE6_AFE_RX_CONTROL_VALUE		0xf000
+#define ACX00_PAGE6_AFE_EQ_RX_DETECT_CONTROL_REG	0x14
+#define AC200_PAGE6_AFE_EQ_RX_DETECT_VALUE	0x708f
+#define AC300_PAGE6_AFE_EQ_RX_DETECT_VALUE	0x708b
+#define ACX00_PAGE6_AFE_EQ_RX_DETECT_LOW_CAL_VALUE 0x7809
+#define ACX00_PAGE6_TX_LEVEL_REG			0x15
+#define ACX00_PAGE6_TX_LEVEL_100M_MASK		GENMASK(15, 8)
+#define ACX00_PAGE6_TX_LEVEL_10M_MASK		GENMASK(7, 0)
+#define ACX00_PAGE6_TX_LEVEL_VALUE(_100m, _10m) \
+	(FIELD_PREP(ACX00_PAGE6_TX_LEVEL_100M_MASK, (_100m)) | \
+	 FIELD_PREP(ACX00_PAGE6_TX_LEVEL_10M_MASK, (_10m)))
+#define ACX00_PAGE6_TX_LEVEL_DEFAULT_VALUE \
+	ACX00_PAGE6_TX_LEVEL_VALUE(0x15, 0x30)
+#define ACX00_PAGE6_TX_LEVEL_LOW_CAL_VALUE \
+	ACX00_PAGE6_TX_LEVEL_VALUE(0x35, 0x33)
+
+#define ACX00_PAGE8_AFE_CONTROL_REG		0x18
+#define ACX00_PAGE8_AFE_CONTROL_VALUE		0x00bc
+#define ACX00_PAGE8_AUTO_CAL_CONTROL_REG		0x1d
+#define ACX00_PAGE8_AUTO_CAL_TX_LEVEL_ADJUST_BYPASS BIT(11)
+#define ACX00_PAGE8_AUTO_CAL_LOW_CAL_OPAQUE_BITS	0x0044
+#define ACX00_PAGE8_AUTO_CAL_LOW_VALUE \
+	(ACX00_PAGE8_AUTO_CAL_TX_LEVEL_ADJUST_BYPASS | \
+	 ACX00_PAGE8_AUTO_CAL_LOW_CAL_OPAQUE_BITS)
+
+/*
+ * Another integration of this exact-ID PHY documents its digital vendor
+ * register map, which also matches the observed ACx00 reset values. The ACx00
+ * analog-page field encodings remain unpublished, so keep those as opaque
+ * vendor initialization values instead of inventing bit definitions.
+ */
+
+struct acx00_ephy_priv {
+	struct phy_device *phydev;
+	struct acx00_ephy_control *control;
+	bool is_ac300;
+	bool use_low_calibration_tuning;
+	bool xmii_rx_clock_inverted;
+};
+
+static int acx00_ephy_read_page(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = __phy_read(phydev, ACX00_PAGE_SELECT_REG);
+	if (ret < 0)
+		return ret;
+
+	return FIELD_GET(ACX00_PAGE_SELECT_MASK, ret);
+}
+
+static int acx00_ephy_write_page(struct phy_device *phydev, int page)
+{
+	return __phy_write(phydev, ACX00_PAGE_SELECT_REG,
+			   FIELD_PREP(ACX00_PAGE_SELECT_MASK, page));
+}
+
+static int acx00_ephy_control_power_on(struct acx00_ephy_priv *priv)
+{
+	return priv->control->power_on(priv->control,
+				       priv->phydev->mdio.addr);
+}
+
+static int acx00_ephy_control_power_off(struct acx00_ephy_priv *priv)
+{
+	return priv->control->power_off(priv->control);
+}
+
+static int acx00_ephy_set_interface(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+
+	if (phydev->interface == PHY_INTERFACE_MODE_NA)
+		return 0;
+	if (phydev->interface != PHY_INTERFACE_MODE_MII &&
+	    phydev->interface != PHY_INTERFACE_MODE_RMII)
+		return -EINVAL;
+
+	return priv->control->set_interface(priv->control,
+					    phydev->interface);
+}
+
+static void acx00_ephy_control_release(void *data)
+{
+	struct acx00_ephy_priv *priv = data;
+	int ret;
+
+	ret = acx00_ephy_control_power_off(priv);
+	if (ret)
+		phydev_warn(priv->phydev,
+			    "failed to power off control block: %pe\n",
+			    ERR_PTR(ret));
+}
+
+static struct device *
+acx00_ephy_find_supplier(struct device_node *control, bool is_ac300)
+{
+	struct platform_device *pdev;
+	struct mdio_device *mdiodev;
+
+	if (is_ac300) {
+		mdiodev = of_mdio_find_device(control);
+		return mdiodev ? &mdiodev->dev : NULL;
+	}
+
+	pdev = of_find_device_by_node(control);
+	return pdev ? &pdev->dev : NULL;
+}
+
+static int acx00_ephy_get_control(struct phy_device *phydev,
+				  struct acx00_ephy_priv *priv)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct acx00_ephy_control *control;
+	struct device_node *control_node;
+	struct device *supplier;
+	struct device_link *link;
+	const char *compatible;
+	const char *property;
+	bool has_ac200;
+	bool has_ac300;
+	u32 control_addr;
+	u32 configuration = 0;
+	int ret;
+
+	has_ac200 = of_property_present(dev->of_node,
+					"x-powers,ac200-control");
+	has_ac300 = of_property_present(dev->of_node,
+					"x-powers,ac300-control");
+	if (has_ac200 == has_ac300)
+		return dev_err_probe(dev, -EINVAL,
+				     "exactly one ACx00 control is required\n");
+
+	priv->is_ac300 = has_ac300;
+	property = has_ac300 ? "x-powers,ac300-control" :
+			       "x-powers,ac200-control";
+	compatible = has_ac300 ? "x-powers,ac300-ephy-ctl" :
+				 "x-powers,ac200-ephy-ctl";
+	control_node = of_parse_phandle(dev->of_node, property, 0);
+	if (!control_node)
+		return dev_err_probe(dev, -EINVAL, "missing %s\n", property);
+	if (!of_device_is_compatible(control_node, compatible)) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "%s does not reference a %s device\n",
+				    property, compatible);
+		goto out_put_node;
+	}
+	if (!of_device_is_available(control_node)) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "%s references a disabled device\n",
+				    property);
+		goto out_put_node;
+	}
+
+	if (has_ac300) {
+		ret = of_property_read_u32(control_node, "reg", &control_addr);
+		if (ret || control_addr != phydev->mdio.addr +
+					       AC300_EPHY_CONTROL_ADDR_OFFSET) {
+			ret = dev_err_probe(dev, -EINVAL,
+					    "AC300 control address does not match reg\n");
+			goto out_put_node;
+		}
+	}
+
+	if (device_property_present(dev, "nvmem-cells")) {
+		ret = nvmem_cell_read_variable_le_u32(dev,
+						      "configuration",
+						      &configuration);
+		if (ret) {
+			dev_err_probe(dev, ret,
+				      "failed to read PHY configuration\n");
+			goto out_put_node;
+		}
+
+		if (!!(configuration & ACX00_EPHY_CONFIG_VARIANT_AC300) !=
+		    priv->is_ac300) {
+			ret = dev_err_probe(dev, -EINVAL,
+					    "configuration does not match control device\n");
+			goto out_put_node;
+		}
+	}
+
+	priv->use_low_calibration_tuning =
+		priv->is_ac300 &&
+		!!(configuration & ACX00_EPHY_CONFIG_CALIBRATION_LOW);
+	ret = 0;
+
+	supplier = acx00_ephy_find_supplier(control_node, priv->is_ac300);
+	if (!supplier) {
+		ret = dev_err_probe(dev, -EPROBE_DEFER,
+				    "%s device is not registered\n", property);
+		goto out_put_node;
+	}
+
+	link = device_link_add(dev, supplier, DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "failed to link %s device\n", property);
+		goto out_put_supplier;
+	}
+
+	/* The managed link keeps the provider and its operations bound. */
+	device_lock(supplier);
+	if (!device_is_bound(supplier)) {
+		ret = -EPROBE_DEFER;
+	} else {
+		control = dev_get_drvdata(supplier);
+		if (!control || !control->power_on || !control->power_off ||
+		    !control->set_interface)
+			ret = -EINVAL;
+		else
+			priv->control = control;
+	}
+	device_unlock(supplier);
+	if (ret == -EPROBE_DEFER)
+		ret = dev_err_probe(dev, ret, "%s driver is not ready\n",
+				    property);
+	else if (ret)
+		ret = dev_err_probe(dev, ret,
+				    "%s driver has invalid control operations\n",
+				    property);
+
+out_put_supplier:
+	put_device(supplier);
+out_put_node:
+	of_node_put(control_node);
+	return ret;
+}
+
+static int acx00_ephy_disable_eee(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = phy_modify_paged(phydev, ACX00_PAGE_1,
+			       ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG,
+			       ACX00_PAGE1_INTELLIGENT_EEE_ENABLE, 0);
+	if (ret)
+		return ret;
+
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
+				  MDIO_EEE_100TX);
+}
+
+static int acx00_ephy_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct acx00_ephy_priv *priv;
+	int ret;
+
+	if (!dev->of_node)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->phydev = phydev;
+	ret = acx00_ephy_get_control(phydev, priv);
+	if (ret)
+		return ret;
+
+	priv->xmii_rx_clock_inverted =
+		device_property_read_bool(dev,
+					  "x-powers,xmii-rx-clock-inverted");
+	phydev->priv = priv;
+	ret = devm_add_action_or_reset(dev, acx00_ephy_control_release, priv);
+	if (ret)
+		return ret;
+
+	ret = acx00_ephy_control_power_on(priv);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to power on control block\n");
+
+	/* Set the hardware default before phylib reads its EEE advertisement. */
+	ret = acx00_ephy_disable_eee(phydev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to disable EEE\n");
+
+	return 0;
+}
+
+static int acx00_ephy_soft_reset(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	int ret;
+
+	ret = acx00_ephy_set_interface(phydev);
+	if (ret)
+		return ret;
+
+	ret = acx00_ephy_control_power_on(priv);
+	if (ret)
+		return ret;
+
+	/* ACx00 can acknowledge reset in power-down without restarting. */
+	ret = genphy_resume(phydev);
+	if (ret)
+		return ret;
+
+	return genphy_soft_reset(phydev);
+}
+
+static int acx00_ephy_config_init(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	u16 afe_eq_rx_detect = priv->is_ac300 ?
+		AC300_PAGE6_AFE_EQ_RX_DETECT_VALUE :
+		AC200_PAGE6_AFE_EQ_RX_DETECT_VALUE;
+	u16 tx_level_value = ACX00_PAGE6_TX_LEVEL_DEFAULT_VALUE;
+	u16 global_config;
+	int oldpage;
+	int ret;
+
+	global_config = FIELD_PREP(ACX00_PAGE0_MDI_MODE_MASK,
+				   ACX00_PAGE0_MDI_MODE_AUTO);
+	if (priv->xmii_rx_clock_inverted)
+		global_config |= ACX00_PAGE0_XMII_RX_CLOCK_INVERT;
+
+	ret = phy_modify_paged(phydev, ACX00_PAGE_0,
+			       ACX00_PAGE0_GLOBAL_CONFIG_REG,
+			       ACX00_PAGE0_XMII_RX_CLOCK_INVERT |
+			       ACX00_PAGE0_MDI_MODE_MASK, global_config);
+	if (ret)
+		return ret;
+
+	if (priv->is_ac300 && priv->use_low_calibration_tuning) {
+		afe_eq_rx_detect =
+			ACX00_PAGE6_AFE_EQ_RX_DETECT_LOW_CAL_VALUE;
+		tx_level_value = ACX00_PAGE6_TX_LEVEL_LOW_CAL_VALUE;
+	}
+
+	oldpage = phy_select_page(phydev, ACX00_PAGE_1);
+	if (oldpage < 0)
+		return oldpage;
+
+	ret = __phy_write(phydev, ACX00_PAGE1_APS_CONTROL_REG,
+			  ACX00_PAGE1_APS_DISABLED_4S_VALUE);
+	if (ret)
+		goto out_restore_page;
+	ret = __phy_modify(phydev, ACX00_PAGE1_UAPS_CONTROL_REG,
+			   ACX00_PAGE1_UAPS_ENABLE, 0);
+	if (ret)
+		goto out_restore_page;
+	ret = __phy_modify(phydev, ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG,
+			   ACX00_PAGE1_INTELLIGENT_EEE_ENABLE, 0);
+	if (ret)
+		goto out_restore_page;
+
+	ret = acx00_ephy_write_page(phydev, ACX00_PAGE_2);
+	if (ret)
+		goto out_restore_page;
+	ret = __phy_modify(phydev, ACX00_PAGE2_TX_DATA_CONTROL_REG,
+			   ACX00_PAGE2_10BT_FIR_SELECT_MASK,
+			   FIELD_PREP(ACX00_PAGE2_10BT_FIR_SELECT_MASK,
+				      ACX00_PAGE2_10BT_FIR_SELECT_DEFAULT));
+	if (ret)
+		goto out_restore_page;
+
+	ret = acx00_ephy_write_page(phydev, ACX00_PAGE_6);
+	if (ret)
+		goto out_restore_page;
+	ret = __phy_write(phydev, ACX00_PAGE6_AFE_EQ_RX_DETECT_CONTROL_REG,
+			  afe_eq_rx_detect);
+	if (ret)
+		goto out_restore_page;
+	ret = __phy_write(phydev, ACX00_PAGE6_AFE_RX_CONTROL_REG,
+			  ACX00_PAGE6_AFE_RX_CONTROL_VALUE);
+	if (ret)
+		goto out_restore_page;
+	if (priv->is_ac300 && priv->use_low_calibration_tuning) {
+		ret = __phy_write(phydev, ACX00_PAGE6_ADC_CONTROL_REG,
+				  ACX00_PAGE6_ADC_CONTROL_LOW_CAL_VALUE);
+		if (ret)
+			goto out_restore_page;
+	}
+	ret = __phy_write(phydev, ACX00_PAGE6_TX_LEVEL_REG, tx_level_value);
+	if (ret)
+		goto out_restore_page;
+
+	ret = acx00_ephy_write_page(phydev, ACX00_PAGE_8);
+	if (ret)
+		goto out_restore_page;
+	if (priv->is_ac300 && priv->use_low_calibration_tuning) {
+		ret = __phy_write(phydev, ACX00_PAGE8_AUTO_CAL_CONTROL_REG,
+				  ACX00_PAGE8_AUTO_CAL_LOW_VALUE);
+		if (ret)
+			goto out_restore_page;
+	}
+	ret = __phy_write(phydev, ACX00_PAGE8_AFE_CONTROL_REG,
+			  ACX00_PAGE8_AFE_CONTROL_VALUE);
+
+out_restore_page:
+	ret = phy_restore_page(phydev, oldpage, ret);
+	if (ret)
+		return ret;
+
+	/* Restore the standard EEE policy retained by phylib across resets. */
+	return genphy_c45_an_config_eee_aneg(phydev);
+}
+
+static int acx00_ephy_power_on_and_resume(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	int ret;
+
+	ret = acx00_ephy_set_interface(phydev);
+	if (ret)
+		return ret;
+
+	ret = acx00_ephy_control_power_on(priv);
+	if (ret)
+		return ret;
+
+	ret = genphy_resume(phydev);
+	if (ret) {
+		acx00_ephy_control_power_off(priv);
+		return ret;
+	}
+
+	/* Powering off the control block loses the vendor-page state. */
+	return acx00_ephy_config_init(phydev);
+}
+
+static int acx00_ephy_resume(struct phy_device *phydev)
+{
+	return acx00_ephy_power_on_and_resume(phydev);
+}
+
+static int acx00_ephy_suspend(struct phy_device *phydev)
+{
+	struct acx00_ephy_priv *priv = phydev->priv;
+	int resume_ret;
+	int ret;
+
+	ret = genphy_suspend(phydev);
+	if (ret)
+		return ret;
+
+	ret = acx00_ephy_control_power_off(priv);
+	if (ret) {
+		resume_ret = acx00_ephy_power_on_and_resume(phydev);
+		if (resume_ret)
+			phydev_warn(phydev,
+				    "failed to recover from suspend error: %pe\n",
+				    ERR_PTR(resume_ret));
+	}
+
+	return ret;
+}
+
+static int acx00_ephy_match_phy_device(struct phy_device *phydev,
+				       const struct phy_driver *phydrv)
+{
+	struct device_node *node = phydev->mdio.dev.of_node;
+
+	if (!genphy_match_phy_device(phydev, phydrv) || !node)
+		return 0;
+
+	/* RK630 reports the same PHY ID, so require an X-Powers control link. */
+	return of_property_present(node, "x-powers,ac200-control") ||
+	       of_property_present(node, "x-powers,ac300-control");
+}
+
+static struct phy_driver acx00_ephy_driver[] = {
+	{
+		PHY_ID_MATCH_MODEL(ACX00_EPHY_ID),
+		.name = "X-Powers AC200/AC300 EPHY",
+		.match_phy_device = acx00_ephy_match_phy_device,
+		.probe = acx00_ephy_probe,
+		.read_page = acx00_ephy_read_page,
+		.write_page = acx00_ephy_write_page,
+		.soft_reset = acx00_ephy_soft_reset,
+		.config_init = acx00_ephy_config_init,
+		.suspend = acx00_ephy_suspend,
+		.resume = acx00_ephy_resume,
+	},
+};
+module_phy_driver(acx00_ephy_driver);
+
+static const struct mdio_device_id __maybe_unused acx00_ephy_tbl[] = {
+	{ PHY_ID_MATCH_MODEL(ACX00_EPHY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(mdio, acx00_ephy_tbl);
+
+MODULE_AUTHOR("James Hilliard <james.hilliard1@gmail.com>");
+MODULE_DESCRIPTION("X-Powers AC200/AC300 Ethernet PHY driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0

