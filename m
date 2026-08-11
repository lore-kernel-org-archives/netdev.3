Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B1C41B8CD
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 08:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437452; cv=none; b=S5xSdNvjy0/Gkh3bL4uQsKwY7AzIkq5h3DFmJoMGNlnB3BBuM2BkK3ALDJllUe3Hr0kJ2MhopMzmy0Eo9RbOUT93Gun3W7QZ8NsZ0lMtSsV9WqmK4YL8nrUk7p4hoB4043WOgqle2EWGad6wqyoVinpI8WuB8rZhDA0rgyDI598=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437452; c=relaxed/simple;
	bh=muZwWVdNcx2iE7/bF0puIJF4hKcLgX0BmSef+b48yIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d0zU9T2KlffcmeDnYPWHIVlQ1KOsDqMYV1tbkH4U5d44hcXxOfXr88xW1YFIX/053DBLImOtE/2ra7mQu4pRX7N5xFtIUql3/y+4HpO3dxhvcABll7oS6EjbdvtXCLq97BMXce60+ixKuTfkOj/E1QheB+kRh+7D00lOTwkd+hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+mk2HZr; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+mk2HZr"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6ac83a09781so449059eaf.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786437443; x=1787042243; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JWZ/M3ILhJMsFiGOeSXD8l56hceCa3H+GQhVFbM4Jw0=;
        b=Y+mk2HZr5hcy9k/EhBbO/bWLRehfgM2+h5v1BxIxuAY9L5Ok8PZa0LhSG3nYQHWm4G
         tFzSes6Q9JEdzXY/jq/TWE9VcYEiVUHk9Zpg4tXzmkUVO3Xvd7DktjMcnQp2Kmi74ngC
         tbOzQhxKpgfdLkZwcZlhPTrscra7pj0+Ly6Tpo3MDRfjgoo+gehc6sn6WE6+bjOLvfXT
         RwaGaV9eMCSrflgWFZ/waIvDkN1QGajgXHp6X31rOE3AY6Yru05tBRUUG2ibrtaYJnTm
         VygSryJdaUKBTuQsWiweKRfhvh1Kz9GcY4nR+Dyjq89XGxHjjxcyiQ/jM1llqFhAg+29
         rzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786437443; x=1787042243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JWZ/M3ILhJMsFiGOeSXD8l56hceCa3H+GQhVFbM4Jw0=;
        b=SMI2uqcgi41gmu0LVMEJ7oAdcdAetUKVGxsu0a4oArkCwXwpwHxT/KrSILpwWQGxAz
         njdehkFdfGQwdp/vVYapwgrNlOdxSER6Y5KxzivfNvKgKrjQUZMApxasYN5vm/4N5DQ8
         YmaxdxueZP2dxUxmVEBu5n4vKDtiN5QbFod7RPulWbu0yckiI0TVbri4iuBBn3qZ+dAq
         3GdZifxf9kkL8I8muUtrQvV6Y+eTFh2SswJ6tXFH23iqcb4SxYJ30zB/bL7GpJ5l4S1g
         HJr4Akto0TrdYU+Egm1ebZmqLyxbNThSN1yavxi7Ua1tMVF6u0yH28fxPImp3k1SUcJW
         bvKA==
X-Gm-Message-State: AOJu0YymOq1E6jXYI9my3WesZc5XRy223JdlL2GD/3/d2UbmggAZw0PC
	MtdUOpVZqmk8KyQP0QcnytUGpG5FiJc/gQg7WA5pXrLU1VEtfYKV9msW
X-Gm-Gg: AR+sD116lEgWxOhAeGUtB9yyaZAb2rIfNjtpFEeg5v+kGkLpUv+xLKY1Mx7A+rq2X50
	vzgtgxnbrcUzKsw5Sk4e7grpY0zDiJrV7T61U1ldzzHh3+jICaS2H9d7L+tbAniqKWuKJhrBm1o
	xfmkRmReNBIbOQqo3ExZ/Ve99ukSSKep5lUs1jJaUQ2+v3NpwqG+oMjc+inKSIX9eyPmfHbyU5a
	Cqv7ftDdtOdnXPhlCCWFnV25FFxSAuGj2qbhqYYhlSAS+H8C8GOeGlCSQWco27RRFlUzPAs5nHl
	XjV9A1dAizhf7nZrK17bm8DA8Q1hPEy8i6XBbnJulalarAAX3ifv8/sLp56QzKtFpTNBWpMcfOh
	wGaNH8MeVQ5eBpWKAtLUCZcMn4DlPf6ZxMxosnlQZEG6ubtFJ7evjVl/Qm0UJVgcVZEegYYm2FW
	poBvdNyd2PhUdAsZ4xqDEGqSHZ4yUOyDbBpD2nqnd6k/DG59i82FK0qSFE4uM4kthchVkBRWIf+
	zyBZdPpl84T7nP7nxz9l7HRj+bEFxVOgmdT2wo69ut4Qh6i+mp8yi+YVBxiUgi4QPrGgI1acigZ
	x+8nGUKJgpzoXG1tWRDcsAMeTnOmEl4YsSIf6kKqbBbgZex0Qo/q/uG8X9mnNQmavloVKvFOrpE
	l9ivmQ0iqyXv0KXAllw==
X-Received: by 2002:a05:6820:188f:b0:6a3:6f5d:4d6c with SMTP id 006d021491bc7-6b0a30eab82mr733527eaf.6.1786437443457;
        Tue, 11 Aug 2026 01:37:23 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e1d8393e0sm738613fac.12.2026.08.11.01.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 01:37:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 11 Aug 2026 02:37:07 -0600
Subject: [PATCH net-next v6 2/2] net: phy: add X-Powers AC200/AC300 EPHY
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-submit-acx00-of-dynamic-v1-v6-2-0229b99a32f6@gmail.com>
References: <20260811-submit-acx00-of-dynamic-v1-v6-0-0229b99a32f6@gmail.com>
In-Reply-To: <20260811-submit-acx00-of-dynamic-v1-v6-0-0229b99a32f6@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

The AC200 and AC300 contain compatible Fast Ethernet link PHYs, but the
link endpoint is inaccessible until package-specific control registers
have powered and configured it.

Add one PHY driver which binds the link child and joins its parent
Ethernet PHY package. Fixed package compatibles select the corresponding
backend. The generic ACx00 compatible reads one packed configuration field
and selects the backend before touching backend-specific resources. The
AC300 path therefore does not resolve or access the candidate AC200 I2C
device.

AC200 locates the I2C device referenced by the package and establishes a
managed device link before obtaining its regmap through syscon. The link
keeps the supplier bound until the PHY consumer has unbound, while the
syscon lookup defers probing until the AC200 driver has published its
managed regmap. Firmware must make the selected AC200 provider path
available before the PHY probes.

AC300 uses the PHY package helpers to access the control range at base
address plus 16. Keeping both backends in the same module lets the common
link implementation own the complete PHY without registering artificial
control devices.

Obtain and manage the selected package supply, calibration and input
clock, validate or program the link address, and apply the required reset,
clock, I/O and shutdown sequences. Start in the hardware-default MII mode
so the forced PHY device can probe before a MAC attaches, then apply the
MAC-provided MII or RMII mode before the normal PHY soft reset.

Apply the common vendor analog initialization, optional AC300
low-calibration tuning and board-selected receive-clock inversion. Keep
MDI/MDI-X in automatic mode. Preserve standard MAC-managed EEE support
while disabling the vendor PHY-autonomous Intelligent EEE mode.

Power down the package control block and its supply during PHY suspend,
then restore them and the vendor configuration during resume. If
shutdown fails, attempt to recover the running PHY before returning the
original error.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/Kconfig          |  11 +
 drivers/net/phy/Makefile         |   1 +
 drivers/net/phy/xpowers/Makefile |   3 +
 drivers/net/phy/xpowers/ac200.c  | 315 +++++++++++++++++++++++
 drivers/net/phy/xpowers/ac300.c  | 387 ++++++++++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.c  | 536 +++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/xpowers/acx00.h  |  28 ++
 7 files changed, 1281 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index b4ef927fd4a6..d3835597e379 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -484,6 +484,17 @@ config VITESSE_PHY
 	help
 	  Currently supports the vsc8244
 
+config XPOWERS_ACX00_PHY
+	tristate "X-Powers AC200/AC300 Ethernet PHY"
+	depends on COMMON_CLK && NVMEM && OF_MDIO && REGULATOR
+	depends on I2C || !I2C
+	select PHY_PACKAGE
+	help
+	  Enable the Fast Ethernet PHY driver shared by the X-Powers AC200
+	  and AC300 companion ICs. The driver configures their common MDIO PHY
+	  registers and the package-specific AC200 I2C or AC300 MDIO control
+	  registers.
+
 config XILINX_GMII2RGMII
 	tristate "Xilinx GMII2RGMII converter driver"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index 25c4a3c2429f..49575fa18522 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -101,4 +101,5 @@ obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
+obj-$(CONFIG_XPOWERS_ACX00_PHY)	+= xpowers/
 obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
diff --git a/drivers/net/phy/xpowers/Makefile b/drivers/net/phy/xpowers/Makefile
new file mode 100644
index 000000000000..ae977a795832
--- /dev/null
+++ b/drivers/net/phy/xpowers/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+xpowers-acx00-y := acx00.o ac200.o ac300.o
+obj-$(CONFIG_XPOWERS_ACX00_PHY) += xpowers-acx00.o
diff --git a/drivers/net/phy/xpowers/ac200.c b/drivers/net/phy/xpowers/ac200.c
new file mode 100644
index 000000000000..681e013be401
--- /dev/null
+++ b/drivers/net/phy/xpowers/ac200.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC200 Ethernet PHY package backend
+ *
+ * Copyright (c) 2022 Arm Ltd. (Andre Przywara <andre.przywara@arm.com>)
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/i2c.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include "acx00.h"
+
+#define AC200_EPHY_BPS_EFFUSE_OFFSET	3
+#define AC200_EPHY_CLK_RATE_24_MHZ	24000000
+#define AC200_EPHY_CLK_RATE_27_MHZ	27000000
+
+#define AC200_SYS_EPHY_CTL0_REG			0x0014
+#define AC200_EPHY_RESET_DEASSERT		BIT(0)
+#define AC200_EPHY_SYSCLK_ENABLE			BIT(1)
+
+#define AC200_SYS_EPHY_CTL1_REG			0x0016
+#define AC200_EPHY_MII_IO_ENABLE			BIT(0)
+
+/* AC200-internal copy of the Ethernet PHY calibration eFuse. */
+#define AC200_EFUSE_EPHY_REG			0x8004
+
+#define AC200_EPHY_CTL_REG			0x6000
+#define AC200_EPHY_SHUTDOWN			BIT(0)
+#define AC200_EPHY_CLK_SEL_24_MHZ		BIT(2)
+#define AC200_EPHY_PHY_ADDR_MASK			GENMASK(8, 4)
+#define AC200_EPHY_RMII_SEL			BIT(11)
+#define AC200_EPHY_BPS_EFFUSE_MASK		GENMASK(15, 12)
+
+struct ac200_ephy_ctl {
+	struct acx00_ephy_control control;
+	struct regmap *regmap;
+	struct regulator *vcc;
+	struct device *dev;
+	u16 ephy_ctl;
+	unsigned int phy_addr;
+	phy_interface_t interface;
+	bool supply_enabled;
+	bool powered;
+};
+
+static u16 ac200_ephy_ctl_config(const struct ac200_ephy_ctl *priv)
+{
+	return priv->ephy_ctl |
+		(priv->interface == PHY_INTERFACE_MODE_RMII ?
+		 AC200_EPHY_RMII_SEL : 0) |
+		FIELD_PREP(AC200_EPHY_PHY_ADDR_MASK, priv->phy_addr);
+}
+
+static int ac200_ephy_ctl_write(struct ac200_ephy_ctl *priv,
+				unsigned int reg, u16 value)
+{
+	int ret;
+
+	ret = regmap_write(priv->regmap, reg, value);
+	if (ret)
+		dev_err(priv->dev, "failed to write register %#x: %pe\n",
+			reg, ERR_PTR(ret));
+
+	return ret;
+}
+
+static int ac200_ephy_ctl_disable(struct ac200_ephy_ctl *priv)
+{
+	int err;
+	int ret = 0;
+
+	if (priv->powered) {
+		ret = ac200_ephy_ctl_write(priv, AC200_EPHY_CTL_REG,
+					   ac200_ephy_ctl_config(priv) |
+					   AC200_EPHY_SHUTDOWN);
+		err = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL1_REG, 0);
+		if (!ret)
+			ret = err;
+		err = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL0_REG, 0);
+		if (!ret)
+			ret = err;
+
+		priv->powered = false;
+	}
+
+	if (priv->supply_enabled) {
+		err = regulator_disable(priv->vcc);
+		if (!err)
+			priv->supply_enabled = false;
+		else if (!ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int ac200_ephy_ctl_power_off(struct acx00_ephy_control *control)
+{
+	struct ac200_ephy_ctl *priv =
+		container_of(control, struct ac200_ephy_ctl, control);
+
+	return ac200_ephy_ctl_disable(priv);
+}
+
+static int
+ac200_ephy_ctl_set_interface(struct acx00_ephy_control *control,
+			     phy_interface_t interface)
+{
+	struct ac200_ephy_ctl *priv =
+		container_of(control, struct ac200_ephy_ctl, control);
+	int ret = 0;
+
+	if (interface != PHY_INTERFACE_MODE_MII &&
+	    interface != PHY_INTERFACE_MODE_RMII)
+		return -EINVAL;
+
+	if (priv->interface == interface)
+		return 0;
+
+	if (priv->powered)
+		ret = regmap_update_bits(priv->regmap, AC200_EPHY_CTL_REG,
+					 AC200_EPHY_RMII_SEL,
+					 interface == PHY_INTERFACE_MODE_RMII ?
+					 AC200_EPHY_RMII_SEL : 0);
+	if (!ret)
+		priv->interface = interface;
+
+	return ret;
+}
+
+static int ac200_ephy_ctl_power_on(struct acx00_ephy_control *control,
+				   unsigned int phy_addr)
+{
+	struct ac200_ephy_ctl *priv =
+		container_of(control, struct ac200_ephy_ctl, control);
+	u16 ephy_ctl;
+	int ret;
+
+	if (phy_addr > FIELD_MAX(AC200_EPHY_PHY_ADDR_MASK))
+		return -EINVAL;
+
+	if (priv->powered && priv->phy_addr == phy_addr)
+		return 0;
+
+	if (priv->powered) {
+		ret = ac200_ephy_ctl_disable(priv);
+		if (ret)
+			return ret;
+	}
+	priv->phy_addr = phy_addr;
+
+	if (!priv->supply_enabled) {
+		ret = regulator_enable(priv->vcc);
+		if (ret)
+			return ret;
+		priv->supply_enabled = true;
+	}
+
+	ephy_ctl = ac200_ephy_ctl_config(priv);
+
+	/* Start from a disabled state before applying the configuration. */
+	ret = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL0_REG, 0);
+	if (ret)
+		goto err_disable;
+
+	ret = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL1_REG,
+				   AC200_EPHY_MII_IO_ENABLE);
+	if (ret)
+		goto err_disable;
+
+	ret = ac200_ephy_ctl_write(priv, AC200_EPHY_CTL_REG,
+				   ephy_ctl | AC200_EPHY_SHUTDOWN);
+	if (ret)
+		goto err_disable;
+
+	ret = ac200_ephy_ctl_write(priv, AC200_SYS_EPHY_CTL0_REG,
+				   AC200_EPHY_RESET_DEASSERT |
+				   AC200_EPHY_SYSCLK_ENABLE);
+	if (ret)
+		goto err_disable;
+
+	ret = ac200_ephy_ctl_write(priv, AC200_EPHY_CTL_REG, ephy_ctl);
+	if (ret)
+		goto err_disable;
+
+	priv->powered = true;
+	return 0;
+
+err_disable:
+	/* Attempt every step of the shutdown sequence after a partial start. */
+	priv->powered = true;
+	ac200_ephy_ctl_disable(priv);
+
+	return ret;
+}
+
+struct acx00_ephy_control *
+ac200_ephy_ctl_create(struct phy_device *phydev,
+		      struct device_node *package_node,
+		      bool has_calibration, u8 calibration)
+{
+	struct device *dev = &phydev->mdio.dev;
+	unsigned int internal_calibration;
+	struct device_node *ac200_node;
+	struct ac200_ephy_ctl *priv;
+	struct i2c_client *client;
+	struct device_link *link;
+	unsigned long clk_rate;
+	u8 bps_effuse_code;
+	struct clk *clk;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+	priv->dev = dev;
+	priv->vcc = devm_of_regulator_get(dev, package_node, "vcc");
+	if (IS_ERR(priv->vcc))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(priv->vcc),
+					     "failed to get package supply\n"));
+
+	ac200_node = of_parse_phandle(package_node, "x-powers,ac200", 0);
+	if (!ac200_node)
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "missing x-powers,ac200 reference\n"));
+	client = of_find_i2c_device_by_node(ac200_node);
+	of_node_put(ac200_node);
+	if (!client) {
+		ret = IS_ENABLED(CONFIG_I2C) ? -EPROBE_DEFER : -ENODEV;
+		return ERR_PTR(dev_err_probe(dev, ret,
+					     "AC200 device is not registered\n"));
+	}
+
+	link = device_link_add(dev, &client->dev,
+			       DL_FLAG_AUTOREMOVE_CONSUMER);
+	if (!link) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "failed to link AC200 device\n");
+		goto out_put_client;
+	}
+
+	if (READ_ONCE(link->status) != DL_STATE_CONSUMER_PROBE) {
+		ret = dev_err_probe(dev, -EPROBE_DEFER,
+				    "AC200 driver is not ready\n");
+		goto out_put_client;
+	}
+
+	priv->regmap = syscon_regmap_lookup_by_phandle(package_node,
+						       "x-powers,ac200");
+	if (IS_ERR(priv->regmap)) {
+		ret = dev_err_probe(dev, PTR_ERR(priv->regmap),
+				    "failed to get AC200 regmap\n");
+		goto out_error;
+	}
+
+	if (!has_calibration) {
+		ret = regmap_read(priv->regmap, AC200_EFUSE_EPHY_REG,
+				  &internal_calibration);
+		if (ret)
+			goto out_error;
+		calibration = internal_calibration;
+	}
+
+	/* The vendor driver supplies no transfer function beyond this offset. */
+	bps_effuse_code = (calibration + AC200_EPHY_BPS_EFFUSE_OFFSET) &
+			   FIELD_MAX(AC200_EPHY_BPS_EFFUSE_MASK);
+	priv->ephy_ctl =
+		FIELD_PREP(AC200_EPHY_BPS_EFFUSE_MASK, bps_effuse_code);
+	/* EPHY_MODE and BIST_CLK_EN stay clear for normal operation. */
+
+	clk = clk_get(&client->dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto out_error;
+	}
+
+	clk_rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	switch (clk_rate) {
+	case AC200_EPHY_CLK_RATE_24_MHZ:
+		priv->ephy_ctl |= AC200_EPHY_CLK_SEL_24_MHZ;
+		break;
+	case AC200_EPHY_CLK_RATE_27_MHZ:
+		break;
+	default:
+		ret = dev_err_probe(dev, -EINVAL,
+				    "unsupported AC200 clock rate %lu Hz\n",
+				    clk_rate);
+		goto out_put_client;
+	}
+
+	priv->control.power_on = ac200_ephy_ctl_power_on;
+	priv->control.power_off = ac200_ephy_ctl_power_off;
+	priv->control.set_interface = ac200_ephy_ctl_set_interface;
+	/* MII is the reset default used until the MAC supplies its interface. */
+	priv->interface = PHY_INTERFACE_MODE_MII;
+	put_device(&client->dev);
+
+	return &priv->control;
+
+out_error:
+	ret = dev_err_probe(dev, ret, "failed to initialize AC200 control\n");
+out_put_client:
+	put_device(&client->dev);
+	return ERR_PTR(ret);
+}
diff --git a/drivers/net/phy/xpowers/ac300.c b/drivers/net/phy/xpowers/ac300.c
new file mode 100644
index 000000000000..aa560432a14c
--- /dev/null
+++ b/drivers/net/phy/xpowers/ac300.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC300 Ethernet PHY package backend
+ *
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/regulator/consumer.h>
+
+#include "../phylib.h"
+#include "acx00.h"
+
+#define AC300_EPHY_BGS_EFFUSE_OFFSET	3
+#define AC300_EPHY_CLK_RATE_24_MHZ	24000000
+#define AC300_EPHY_CLK_RATE_25_MHZ	25000000
+#define AC300_EPHY_CLK_RATE_27_MHZ	27000000
+#define AC300_SYS_CONTROL_REG			0x00
+#define AC300_PACKAGE_STATUS_MASK		GENMASK(11, 8)
+#define AC300_EPHY_CLK_SEL_MASK			GENMASK(7, 6)
+#define AC300_EPHY_CLK_SEL_25_MHZ		FIELD_PREP(AC300_EPHY_CLK_SEL_MASK, 0)
+#define AC300_EPHY_CLK_SEL_27_MHZ		FIELD_PREP(AC300_EPHY_CLK_SEL_MASK, 1)
+#define AC300_EPHY_CLK_SEL_24_MHZ		FIELD_PREP(AC300_EPHY_CLK_SEL_MASK, 2)
+#define AC300_EFUSE_CLK_ENABLE			BIT(5)
+#define AC300_EPHY_REG_CLK_ENABLE		BIT(4)
+#define AC300_CLKIN_GATING_ENABLE		BIT(2)
+#define AC300_EPHY_RESET_DEASSERT		BIT(1)
+#define AC300_CHIP_RESET_DEASSERT		BIT(0)
+
+#define AC300_PACKAGE_POR_INTERNAL_DLDO		BIT(3)
+#define AC300_PACKAGE_PHY_ADDR_MASK		GENMASK(2, 0)
+
+#define AC300_SYS_BIAS1_REG			0x02
+#define AC300_INTERNAL_DLDO_ENABLE		BIT(15)
+
+#define AC300_SYS_IO_REG			0x05
+#define AC300_MDIO_DRV_MASK			GENMASK(15, 14)
+#define AC300_MII_DRV_MASK			GENMASK(11, 10)
+#define AC300_IO_DRV_LEVEL_2			2
+#define AC300_CLKIN_PAD_ENABLE			BIT(4)
+#define AC300_EPHY_MII_IO_ENABLE			BIT(0)
+
+#define AC300_EPHY_CONFIG_REG			0x06
+#define AC300_EPHY_BGS_EFFUSE_MASK		GENMASK(15, 12)
+#define AC300_EPHY_RMII_SEL			BIT(11)
+#define AC300_EPHY_SHUTDOWN			BIT(0)
+
+#define AC300_SYS_CONTROL_ENABLE_BITS \
+	(AC300_EFUSE_CLK_ENABLE | AC300_EPHY_REG_CLK_ENABLE | \
+	 AC300_CLKIN_GATING_ENABLE | AC300_EPHY_RESET_DEASSERT | \
+	 AC300_CHIP_RESET_DEASSERT)
+
+#define AC300_SYS_IO_VALUE \
+	(FIELD_PREP(AC300_MDIO_DRV_MASK, AC300_IO_DRV_LEVEL_2) | \
+	 FIELD_PREP(AC300_MII_DRV_MASK, AC300_IO_DRV_LEVEL_2) | \
+	 AC300_CLKIN_PAD_ENABLE | AC300_EPHY_MII_IO_ENABLE)
+
+struct ac300_ephy_ctl {
+	struct acx00_ephy_control control;
+	struct phy_device *phydev;
+	struct regulator *vcc;
+	struct clk *clk;
+	u16 sys_control;
+	u16 ephy_config;
+	phy_interface_t interface;
+	bool package_known;
+	bool internal_dldo;
+	bool supply_enabled;
+	bool powered;
+};
+
+static unsigned int
+ac300_ephy_ctl_link_addr(const struct ac300_ephy_ctl *priv)
+{
+	return priv->phydev->mdio.addr;
+}
+
+static int ac300_ephy_ctl_read(struct ac300_ephy_ctl *priv, u32 regnum)
+{
+	int ret;
+
+	phy_lock_mdio_bus(priv->phydev);
+	ret = __phy_package_read(priv->phydev,
+				 AC300_EPHY_CONTROL_ADDR_OFFSET, regnum);
+	phy_unlock_mdio_bus(priv->phydev);
+
+	return ret;
+}
+
+static int ac300_ephy_ctl_write(struct ac300_ephy_ctl *priv, u32 regnum,
+				u16 val)
+{
+	int ret;
+
+	phy_lock_mdio_bus(priv->phydev);
+	ret = __phy_package_write(priv->phydev,
+				  AC300_EPHY_CONTROL_ADDR_OFFSET, regnum, val);
+	phy_unlock_mdio_bus(priv->phydev);
+
+	return ret;
+}
+
+static int ac300_ephy_ctl_modify(struct ac300_ephy_ctl *priv, u32 regnum,
+				 u16 mask, u16 set)
+{
+	int ret;
+
+	phy_lock_mdio_bus(priv->phydev);
+	ret = __phy_package_read(priv->phydev,
+				 AC300_EPHY_CONTROL_ADDR_OFFSET, regnum);
+	if (ret >= 0) {
+		u16 val = (ret & ~mask) | (set & mask);
+
+		ret = val == ret ? 0 :
+			__phy_package_write(priv->phydev,
+					    AC300_EPHY_CONTROL_ADDR_OFFSET,
+					    regnum, val);
+	}
+	phy_unlock_mdio_bus(priv->phydev);
+
+	return ret;
+}
+
+static u16 ac300_ephy_ctl_config(const struct ac300_ephy_ctl *priv)
+{
+	return priv->ephy_config |
+		(priv->interface == PHY_INTERFACE_MODE_RMII ?
+		 AC300_EPHY_RMII_SEL : 0);
+}
+
+static u16 ac300_ephy_ctl_reset_value(const struct ac300_ephy_ctl *priv)
+{
+	/*
+	 * A chip reset restores DLDOEN to one. Until PKG_STATUS has identified
+	 * the supply arrangement, preserve any external-VDD setup left by the
+	 * bootloader by asserting only the EPHY reset.
+	 */
+	return !priv->package_known || !priv->internal_dldo ?
+		AC300_CHIP_RESET_DEASSERT : 0;
+}
+
+static int ac300_ephy_ctl_disable(struct ac300_ephy_ctl *priv)
+{
+	int err;
+	int ret = 0;
+
+	if (priv->powered) {
+		ret = ac300_ephy_ctl_write(priv, AC300_EPHY_CONFIG_REG,
+					   ac300_ephy_ctl_config(priv) |
+					   AC300_EPHY_SHUTDOWN);
+		err = ac300_ephy_ctl_write(priv, AC300_SYS_IO_REG, 0);
+		if (!ret)
+			ret = err;
+		err = ac300_ephy_ctl_write(priv, AC300_SYS_CONTROL_REG,
+					   ac300_ephy_ctl_reset_value(priv));
+		if (!ret)
+			ret = err;
+
+		clk_disable_unprepare(priv->clk);
+		priv->powered = false;
+	}
+
+	if (priv->supply_enabled) {
+		err = regulator_disable(priv->vcc);
+		if (!err)
+			priv->supply_enabled = false;
+		else if (!ret)
+			ret = err;
+	}
+
+	return ret;
+}
+
+static int ac300_ephy_ctl_power_off(struct acx00_ephy_control *control)
+{
+	struct ac300_ephy_ctl *priv =
+		container_of(control, struct ac300_ephy_ctl, control);
+
+	return ac300_ephy_ctl_disable(priv);
+}
+
+static int
+ac300_ephy_ctl_set_interface(struct acx00_ephy_control *control,
+			     phy_interface_t interface)
+{
+	struct ac300_ephy_ctl *priv =
+		container_of(control, struct ac300_ephy_ctl, control);
+	int ret = 0;
+
+	if (interface != PHY_INTERFACE_MODE_MII &&
+	    interface != PHY_INTERFACE_MODE_RMII)
+		return -EINVAL;
+
+	if (priv->interface == interface)
+		return 0;
+
+	if (priv->powered)
+		ret = ac300_ephy_ctl_modify(priv, AC300_EPHY_CONFIG_REG,
+					    AC300_EPHY_RMII_SEL,
+					    interface == PHY_INTERFACE_MODE_RMII ?
+					    AC300_EPHY_RMII_SEL : 0);
+	if (!ret)
+		priv->interface = interface;
+
+	return ret;
+}
+
+static int ac300_ephy_ctl_power_on(struct acx00_ephy_control *control,
+				   unsigned int phy_addr)
+{
+	struct ac300_ephy_ctl *priv =
+		container_of(control, struct ac300_ephy_ctl, control);
+	u8 package_status;
+	u16 reset_value;
+	int sys_control;
+	int ret;
+
+	if (phy_addr != ac300_ephy_ctl_link_addr(priv))
+		return -EINVAL;
+
+	if (priv->powered)
+		return 0;
+
+	if (!priv->supply_enabled) {
+		ret = regulator_enable(priv->vcc);
+		if (ret)
+			return ret;
+		priv->supply_enabled = true;
+
+		/* Wait for the power-on reset interval specified by the manual. */
+		fsleep(10000);
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		goto err_power_off;
+	priv->powered = true;
+
+	/* Keep the external-supply configuration across chip resets. */
+	reset_value = ac300_ephy_ctl_reset_value(priv);
+	ret = ac300_ephy_ctl_write(priv, AC300_SYS_CONTROL_REG, reset_value);
+	if (ret)
+		goto err_power_off;
+
+	/* The manual requires both resets to be released before the clocks. */
+	ret = ac300_ephy_ctl_write(priv, AC300_SYS_CONTROL_REG,
+				   AC300_EPHY_RESET_DEASSERT |
+				  AC300_CHIP_RESET_DEASSERT);
+	if (ret)
+		goto err_power_off;
+
+	/* Retain the vendor clock-enable defaults, including the eFuse clock. */
+	ret = ac300_ephy_ctl_write(priv, AC300_SYS_CONTROL_REG,
+				   priv->sys_control);
+	if (ret)
+		goto err_power_off;
+
+	sys_control = ac300_ephy_ctl_read(priv, AC300_SYS_CONTROL_REG);
+	if (sys_control < 0) {
+		ret = sys_control;
+		goto err_power_off;
+	}
+
+	package_status = FIELD_GET(AC300_PACKAGE_STATUS_MASK, sys_control);
+	if ((~package_status & AC300_PACKAGE_PHY_ADDR_MASK) !=
+	    ac300_ephy_ctl_link_addr(priv)) {
+		ret = -EINVAL;
+		goto err_power_off;
+	}
+
+	priv->internal_dldo = package_status & AC300_PACKAGE_POR_INTERNAL_DLDO;
+	priv->package_known = true;
+	ret = ac300_ephy_ctl_modify(priv, AC300_SYS_BIAS1_REG,
+				    AC300_INTERNAL_DLDO_ENABLE,
+				   priv->internal_dldo ?
+				   AC300_INTERNAL_DLDO_ENABLE : 0);
+	if (ret)
+		goto err_power_off;
+
+	/* Keep the documented default drive level and leave the IRQ disabled. */
+	ret = ac300_ephy_ctl_write(priv, AC300_SYS_IO_REG,
+				   AC300_SYS_IO_VALUE);
+	if (ret)
+		goto err_power_off;
+
+	fsleep(10000);
+
+	ret = ac300_ephy_ctl_write(priv, AC300_EPHY_CONFIG_REG,
+				   ac300_ephy_ctl_config(priv) |
+				  AC300_EPHY_SHUTDOWN);
+	if (ret)
+		goto err_power_off;
+
+	fsleep(10000);
+
+	ret = ac300_ephy_ctl_write(priv, AC300_EPHY_CONFIG_REG,
+				   ac300_ephy_ctl_config(priv));
+	if (ret)
+		goto err_power_off;
+
+	return 0;
+
+err_power_off:
+	ac300_ephy_ctl_disable(priv);
+
+	return ret;
+}
+
+static void ac300_ephy_clk_put(void *data)
+{
+	clk_put(data);
+}
+
+struct acx00_ephy_control *
+ac300_ephy_ctl_create(struct phy_device *phydev,
+		      struct device_node *package_node, u8 calibration)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct ac300_ephy_ctl *priv;
+	unsigned long clk_rate;
+	u8 bgs_effuse_code;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+	if (phydev->mdio.addr > FIELD_MAX(AC300_PACKAGE_PHY_ADDR_MASK))
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "link address is outside the package range\n"));
+	priv->phydev = phydev;
+
+	priv->vcc = devm_of_regulator_get(dev, package_node, "vcc");
+	if (IS_ERR(priv->vcc))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(priv->vcc),
+					     "failed to get package supply\n"));
+
+	priv->clk = of_clk_get(package_node, 0);
+	if (IS_ERR(priv->clk))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(priv->clk),
+					     "failed to get input clock\n"));
+
+	ret = devm_add_action_or_reset(dev, ac300_ephy_clk_put, priv->clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
+	if (ret)
+		return ERR_PTR(dev_err_probe(dev, ret,
+					     "failed to lock clock rate\n"));
+
+	clk_rate = clk_get_rate(priv->clk);
+	switch (clk_rate) {
+	case AC300_EPHY_CLK_RATE_24_MHZ:
+		priv->sys_control = AC300_EPHY_CLK_SEL_24_MHZ;
+		break;
+	case AC300_EPHY_CLK_RATE_25_MHZ:
+		priv->sys_control = AC300_EPHY_CLK_SEL_25_MHZ;
+		break;
+	case AC300_EPHY_CLK_RATE_27_MHZ:
+		priv->sys_control = AC300_EPHY_CLK_SEL_27_MHZ;
+		break;
+	default:
+		return ERR_PTR(dev_err_probe(dev, -EINVAL,
+					     "unsupported input clock rate %lu Hz\n",
+					     clk_rate));
+	}
+	priv->sys_control |= AC300_SYS_CONTROL_ENABLE_BITS;
+
+	/* The vendor driver supplies no transfer function beyond this offset. */
+	bgs_effuse_code = (calibration + AC300_EPHY_BGS_EFFUSE_OFFSET) &
+			   FIELD_MAX(AC300_EPHY_BGS_EFFUSE_MASK);
+	priv->ephy_config =
+		FIELD_PREP(AC300_EPHY_BGS_EFFUSE_MASK, bgs_effuse_code);
+	/* EPHY_MODE and BIST_CLK_EN stay clear for normal operation. */
+
+	priv->control.power_on = ac300_ephy_ctl_power_on;
+	priv->control.power_off = ac300_ephy_ctl_power_off;
+	priv->control.set_interface = ac300_ephy_ctl_set_interface;
+	/* MII is the reset default used until the MAC supplies its interface. */
+	priv->interface = PHY_INTERFACE_MODE_MII;
+
+	return &priv->control;
+}
diff --git a/drivers/net/phy/xpowers/acx00.c b/drivers/net/phy/xpowers/acx00.c
new file mode 100644
index 000000000000..98f2b0b63909
--- /dev/null
+++ b/drivers/net/phy/xpowers/acx00.c
@@ -0,0 +1,536 @@
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
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/phy.h>
+#include <linux/slab.h>
+
+#include "../phylib.h"
+#include "acx00.h"
+
+#define ACX00_EPHY_ID				0x00441400
+
+#define ACX00_EPHY_CONFIG_CALIBRATION_MASK	GENMASK(3, 0)
+#define ACX00_EPHY_CONFIG_VARIANT_AC300		BIT(8)
+#define ACX00_EPHY_CONFIG_CALIBRATION_LOW	BIT(9)
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
+static int acx00_ephy_read_nvmem_u16(struct device_node *node,
+				     const char *name, u16 *value)
+{
+	struct nvmem_cell *cell;
+	size_t i;
+	size_t len;
+	u8 *buf;
+	u16 val = 0;
+
+	cell = of_nvmem_cell_get(node, name);
+	if (IS_ERR(cell))
+		return PTR_ERR(cell);
+
+	buf = nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
+	if (!len || len > sizeof(*value)) {
+		kfree(buf);
+		return len ? -ERANGE : -EINVAL;
+	}
+
+	for (i = 0; i < len; i++)
+		val |= (u16)buf[i] << (8 * i);
+	kfree(buf);
+	*value = val;
+
+	return 0;
+}
+
+static int acx00_ephy_init_package(struct phy_device *phydev,
+				   struct acx00_ephy_priv *priv)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct device_node *package_node;
+	bool selectable;
+	bool fixed_ac300;
+	bool has_configuration;
+	u8 calibration;
+	u32 base_addr;
+	u16 configuration = 0;
+	int ret;
+
+	package_node = of_get_parent(dev->of_node);
+	if (!package_node)
+		return -EINVAL;
+	if (!of_node_name_eq(package_node, "ethernet-phy-package")) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "PHY is not in an Ethernet PHY package\n");
+		goto out_put_node;
+	}
+
+	ret = of_property_read_u32(package_node, "reg", &base_addr);
+	if (ret || base_addr != phydev->mdio.addr) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "package and link PHY addresses differ\n");
+		goto out_put_node;
+	}
+
+	selectable = of_device_is_compatible(package_node,
+					     "x-powers,acx00-ephy-package");
+	fixed_ac300 = of_device_is_compatible(package_node,
+					      "x-powers,ac300-ephy-package");
+	if (!selectable && !fixed_ac300 &&
+	    !of_device_is_compatible(package_node,
+				     "x-powers,ac200-ephy-package")) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "unsupported Ethernet PHY package\n");
+		goto out_put_node;
+	}
+
+	ret = devm_of_phy_package_join(dev, phydev, 0);
+	if (ret)
+		goto out_put_node;
+
+	has_configuration =
+		of_property_match_string(package_node, "nvmem-cell-names",
+					 "configuration") >= 0;
+	if (has_configuration) {
+		ret = acx00_ephy_read_nvmem_u16(package_node, "configuration",
+						&configuration);
+		if (ret) {
+			ret = dev_err_probe(dev, ret,
+					    "failed to read package configuration\n");
+			goto out_put_node;
+		}
+	} else if (selectable || fixed_ac300) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "package configuration is required\n");
+		goto out_put_node;
+	}
+
+	if (selectable) {
+		priv->is_ac300 =
+			configuration & ACX00_EPHY_CONFIG_VARIANT_AC300;
+	} else {
+		priv->is_ac300 = fixed_ac300;
+		if (has_configuration &&
+		    !!(configuration & ACX00_EPHY_CONFIG_VARIANT_AC300) !=
+		    priv->is_ac300) {
+			ret = dev_err_probe(dev, -EINVAL,
+					    "configuration does not match package\n");
+			goto out_put_node;
+		}
+	}
+
+	calibration = FIELD_GET(ACX00_EPHY_CONFIG_CALIBRATION_MASK,
+				configuration);
+
+	priv->use_low_calibration_tuning =
+		priv->is_ac300 &&
+		!!(configuration & ACX00_EPHY_CONFIG_CALIBRATION_LOW);
+	priv->xmii_rx_clock_inverted =
+		of_property_read_bool(package_node,
+				      "x-powers,xmii-rx-clock-inverted");
+
+	if (priv->is_ac300)
+		priv->control =
+			ac300_ephy_ctl_create(phydev, package_node,
+					      calibration);
+	else
+		priv->control =
+			ac200_ephy_ctl_create(phydev, package_node,
+					      has_configuration,
+					      calibration);
+	ret = PTR_ERR_OR_ZERO(priv->control);
+
+out_put_node:
+	of_node_put(package_node);
+	return ret;
+}
+
+static int acx00_ephy_disable_autonomous_eee(struct phy_device *phydev)
+{
+	return phy_modify_paged(phydev, ACX00_PAGE_1,
+				ACX00_PAGE1_INTELLIGENT_EEE_CONTROL_REG,
+				ACX00_PAGE1_INTELLIGENT_EEE_ENABLE, 0);
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
+	ret = acx00_ephy_init_package(phydev, priv);
+	if (ret)
+		return ret;
+
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
+		goto out_restore_page;
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
+	struct device_node *package_node;
+	bool match;
+
+	if (!genphy_match_phy_device(phydev, phydrv) || !node)
+		return 0;
+
+	/* RK630 reports the same PHY ID, so also match the package identity. */
+	package_node = of_get_parent(node);
+	if (!package_node)
+		return 0;
+	match = of_device_is_compatible(package_node,
+					"x-powers,ac200-ephy-package") ||
+		of_device_is_compatible(package_node,
+					"x-powers,ac300-ephy-package") ||
+		of_device_is_compatible(package_node,
+					"x-powers,acx00-ephy-package");
+	of_node_put(package_node);
+
+	return match;
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
+		.disable_autonomous_eee = acx00_ephy_disable_autonomous_eee,
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
diff --git a/drivers/net/phy/xpowers/acx00.h b/drivers/net/phy/xpowers/acx00.h
new file mode 100644
index 000000000000..7df6084c7a77
--- /dev/null
+++ b/drivers/net/phy/xpowers/acx00.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __DRIVERS_NET_PHY_XPOWERS_ACX00_H
+#define __DRIVERS_NET_PHY_XPOWERS_ACX00_H
+
+#include <linux/err.h>
+#include <linux/phy.h>
+
+#define AC300_EPHY_CONTROL_ADDR_OFFSET	16
+
+struct device_node;
+
+struct acx00_ephy_control {
+	int (*power_on)(struct acx00_ephy_control *control,
+			unsigned int phy_addr);
+	int (*power_off)(struct acx00_ephy_control *control);
+	int (*set_interface)(struct acx00_ephy_control *control,
+			     phy_interface_t interface);
+};
+
+struct acx00_ephy_control *
+ac200_ephy_ctl_create(struct phy_device *phydev,
+		      struct device_node *package_node,
+		      bool has_calibration, u8 calibration);
+struct acx00_ephy_control *
+ac300_ephy_ctl_create(struct phy_device *phydev,
+		      struct device_node *package_node, u8 calibration);
+
+#endif

-- 
2.53.0

