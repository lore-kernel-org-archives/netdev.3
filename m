Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C583C4B8E
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896919; cv=none; b=dXLDzL9WR3dHndQyf1eKZMuldoyfRAVp9AY/jkXeV/0xjdkHT6tIRIZjtFjJB/GK2qyf1ipbJi3tySbEQvbPzYpCHdZzMnNpZ6DnisntfembPMX+aL68LBdj3DpuMObZKMGJ6h0VNmn/v10qgyWGk/iCYCsGbfJG5v8gVjX+Ah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896919; c=relaxed/simple;
	bh=Rs5Yvai1KoUa6Gkj0I714GUovC4e+WNAYLOEwIvALJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlI+lCStsy8Osas/Mq67ko8ivsBJaqx/3CNj4ihCiCfkNTzFEDncGnDBwLkOP1b6VbjejzGekYwq4rwisd0ywoThYhYKzWovPn6+hV3cUMucLQ/ru1zcH2cJjBosm0sOGPzxAgHEMF9itqQ/SB+pNytzeNnGatYKI48g2ATStfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNcw5ia5; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNcw5ia5"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso380006a34.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896914; x=1786501714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RzurtN0DXtJ4YV8O94n+1KjkgXHYGsR0+0vBXEULE1M=;
        b=BNcw5ia5/cUpAbu9happjcpe8t6Y34JhkCX0D8QcRwbosHdjHdMuC6e27XR3tc8qih
         UuVfQXeWAhLBIUmtZrPiW/k1MynPtRSlF2qdkIFKVk66OJ3UYlP/C+U/eQaLjRYNgnT0
         UarBZyJeHf/XVuXPmIeKBq86hHzI9V/P0SDGII2yL9ndKxrYQMSbJTegnCmuSH9tLka6
         tvthGIp9a+UXnoP/XiPrz45TE+EvKi2zYRgGm1Wr+hGLNfkZ1/4wnb2S0B+saNfhk42U
         T55YpaMrRDJPsWaMGtCwQJOW0VEXOaBfrBl5GJFGFWwTuaEc4yFYgt8cMMtHZplpq3Dh
         Wjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896914; x=1786501714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzurtN0DXtJ4YV8O94n+1KjkgXHYGsR0+0vBXEULE1M=;
        b=QUYt799/JjQvb+ab4GcUyB0RYlr3qQjRMuu2oUTcu+fEGh4/NsUJLtweJhlkfvALDq
         oRUxgCI0YKbhWus3M0vq2fvlNg0RA+Q7HZW/qM2eLzCqZ37gRp1t2rQ0OaAUiDCywEuJ
         Fgz7peJ/xiAncB3BKjwD5yAIAtTwa3MjHhorqUU3VQ0SeZpuIwpAKRcXRlry3xHmEYis
         qc0IWn5Z3nFy+vgx47mipWn4BTi3oLWLtDXxMEG8vdXx7Hjbr/ajPubAXzolr432iOpt
         ZlMppjU85EevQjOGRGHlcM4LmONopGiXtnYV88SOnvLikA5T+31+It43mhJ2C0RHdK9a
         LvJg==
X-Gm-Message-State: AOJu0YxWNWS+R36HRA8c1g5OM5uAQdcM/KgP6dwXuqxxLscN12tyZVqE
	klpQjYrmKdEwXG7T6YmVDvtzrQEYq1vUdL/sHhvMGRw4tJfYqBbTaz+q
X-Gm-Gg: AR+sD11e1KSMUbzX83EEODWF14IerGmNm+1GqmUkW7ezvBuE8oUiactVYaLVt7vAH4F
	goNJNHN4knWBsnUE7mjD7BxAvNHTGf9cSneYdJKGtKro7qLvObJNig9cl5nh5lzpVNaVrM64LPo
	AgPIm9JITlRpGSw+H59553JPq+GDxOVFhQkPGzdMN6lhE2Q9ore0X6sJ7pME+NIpRrmrddVPwSd
	z9obx9W6JD3o1vwbaLKxck0g8sv6UOXxNUq8jPk5ZSz4/wTzC+4fok7ENSS8M4aBN02xfHJhp7g
	TNHS7avlZgsPN/+ZSB/KGPjpAnGmWErMOIsd8i6GeLA5SLN+wht/Hi14tAQG4cq2k2NcOTXzNKa
	NQx8R4NdbYvha9HoR3gCiKCiTLFVpISDRfATqklnFTHbhuxIls11r1dxdpBV9Od6yC/cdsnMJwN
	61cNT/2dRE3Hk7c3jiEkD7uQy0tv7MGBp1vexlsVaU+O7y5y9ol9/kGpyCnYbOwPK9WNKMOH8Je
	xzTlfkAZCuLtVXWlwnjUAI/XCPwuSM8hIsA8/LWSjXVZi5sIPdrKJmuljN5a1jdcoMHns02otDh
	li0hFYMjV359jTI/ZCenLs8e7AxB/2kgHFksD+S+XBhmOgWZKjSEpypdkCBS6dTd/rk9Zu/0fdr
	foFspXwvfQjPK/C8T
X-Received: by 2002:a05:6830:67f9:b0:7e6:8955:c52d with SMTP id 46e09a7af769-7f1e5d2f816mr2651673a34.5.1785896914418;
        Tue, 04 Aug 2026 19:28:34 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:34 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:27:04 -0600
Subject: [PATCH net-next v2 6/8] net: phy: add X-Powers AC300 EPHY control
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-6-3eef49ff1d8c@gmail.com>
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

The AC300 Fast Ethernet PHY needs a separate non-PHY Clause 22 endpoint
to complete package setup before the link endpoint becomes usable.

Enable VCC1 and the input clock, select its 24, 25 or 27 MHz rate, apply
the SoC SID calibration value and vendor offset, configure the documented
I/O drive strength, and perform the reset-before-clock power-up sequence.
Validate the control and link address relationship against the package
straps, clear a latched MDIO error, and configure the internal digital
LDO only for the package variant which uses it.

Early PHY creation uses reset-default MII. A separate operation later
applies phydev->interface and, if already powered, changes only RMII_SEL
before the normal PHY soft reset.

Expose serialized, idempotent power and interface operations to the
common PHY driver. Enable only the MDIO, MII and input-clock pads in this
basic driver; dedicated LED outputs remain disabled for a later patch.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/Kconfig             |   9 +
 drivers/net/phy/Makefile            |   1 +
 drivers/net/phy/xpowers-ac300-ctl.c | 423 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/xpowers-acx00.h     |   2 +
 4 files changed, 435 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 6119f4de880d..7535db7f3471 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -484,6 +484,15 @@ config XPOWERS_AC200_PHY_CTL
 	  address, interface mode, calibration and I/O controls through the
 	  parent AC200 I2C regmap.
 
+config XPOWERS_AC300_PHY_CTL
+	tristate "X-Powers AC300 Ethernet PHY control"
+	depends on COMMON_CLK && NVMEM && OF_MDIO
+	help
+	  Enable the MDIO control driver for the Fast Ethernet PHY in the
+	  X-Powers AC300 companion IC. It programs the PHY calibration,
+	  interface mode, clock and I/O controls through the separate MDIO
+	  control address.
+
 config XILINX_GMII2RGMII
 	tristate "Xilinx GMII2RGMII converter driver"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index f81854fc9f12..0c4e40c9a28a 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -101,4 +101,5 @@ obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_XPOWERS_AC200_PHY_CTL) += xpowers-ac200-ctl.o
+obj-$(CONFIG_XPOWERS_AC300_PHY_CTL) += xpowers-ac300-ctl.o
 obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
diff --git a/drivers/net/phy/xpowers-ac300-ctl.c b/drivers/net/phy/xpowers-ac300-ctl.c
new file mode 100644
index 000000000000..d3ca4df8a9a3
--- /dev/null
+++ b/drivers/net/phy/xpowers-ac300-ctl.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC300 Ethernet PHY control driver
+ *
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mdio.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/phy.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+
+#include "xpowers-acx00.h"
+
+#define AC300_EPHY_BGS_EFFUSE_OFFSET	3
+#define AC300_SYS_CONTROL_REG			0x00
+#define AC300_CHIP_VERSION_MASK			GENMASK(15, 12)
+#define AC300_PACKAGE_STATUS_MASK		GENMASK(11, 8)
+#define AC300_EPHY_CLK_SEL_MASK			GENMASK(7, 6)
+#define AC300_EPHY_CLK_SEL_25_MHZ		FIELD_PREP(AC300_EPHY_CLK_SEL_MASK, 0)
+#define AC300_EPHY_CLK_SEL_27_MHZ		FIELD_PREP(AC300_EPHY_CLK_SEL_MASK, 1)
+#define AC300_EPHY_CLK_SEL_24_MHZ		FIELD_PREP(AC300_EPHY_CLK_SEL_MASK, 2)
+#define AC300_EFUSE_CLK_ENABLE			BIT(5)
+#define AC300_EPHY_REG_CLK_ENABLE		BIT(4)
+#define AC300_MDIO_ERROR			BIT(3)
+#define AC300_CLKIN_GATING_ENABLE		BIT(2)
+#define AC300_EPHY_RESET_DEASSERT		BIT(1)
+#define AC300_CHIP_RESET_DEASSERT		BIT(0)
+
+#define AC300_MASK_VERSION_REG			0x04
+#define AC300_MASK_VERSION_MASK			GENMASK(2, 0)
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
+	struct mdio_device *mdiodev;
+	struct clk *clk;
+	struct mutex lock; /* Serializes power sequencing and state. */
+	u16 sys_control;
+	u16 ephy_config;
+	phy_interface_t interface;
+	bool package_known;
+	bool internal_dldo;
+	bool powered;
+};
+
+static unsigned int
+ac300_ephy_ctl_link_addr(const struct ac300_ephy_ctl *priv)
+{
+	return priv->mdiodev->addr - AC300_EPHY_CONTROL_ADDR_OFFSET;
+}
+
+static u16 ac300_ephy_ctl_config(const struct ac300_ephy_ctl *priv)
+{
+	return priv->ephy_config |
+		(priv->interface == PHY_INTERFACE_MODE_RMII ?
+		 AC300_EPHY_RMII_SEL : 0);
+}
+
+static int ac300_ephy_ctl_power_off_locked(struct ac300_ephy_ctl *priv)
+{
+	int err;
+	int ret;
+
+	if (!priv->powered)
+		return 0;
+
+	ret = mdiodev_write(priv->mdiodev, AC300_EPHY_CONFIG_REG,
+			    ac300_ephy_ctl_config(priv) | AC300_EPHY_SHUTDOWN);
+	err = mdiodev_write(priv->mdiodev, AC300_SYS_IO_REG, 0);
+	if (!ret)
+		ret = err;
+	err = mdiodev_write(priv->mdiodev, AC300_SYS_CONTROL_REG,
+			    priv->package_known && !priv->internal_dldo ?
+			    AC300_CHIP_RESET_DEASSERT : 0);
+	if (!ret)
+		ret = err;
+
+	clk_disable_unprepare(priv->clk);
+	priv->powered = false;
+
+	return ret;
+}
+
+static int ac300_ephy_ctl_power_off(struct acx00_ephy_control *control)
+{
+	struct ac300_ephy_ctl *priv =
+		container_of(control, struct ac300_ephy_ctl, control);
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = ac300_ephy_ctl_power_off_locked(priv);
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int
+ac300_ephy_ctl_set_interface(struct acx00_ephy_control *control,
+			     phy_interface_t interface)
+{
+	struct ac300_ephy_ctl *priv =
+		container_of(control, struct ac300_ephy_ctl, control);
+	u16 value;
+	int ret = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		value = 0;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		value = AC300_EPHY_RMII_SEL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mutex_lock(&priv->lock);
+	if (priv->interface == interface)
+		goto out_unlock;
+
+	if (priv->powered)
+		ret = mdiodev_modify(priv->mdiodev, AC300_EPHY_CONFIG_REG,
+				     AC300_EPHY_RMII_SEL, value);
+	if (!ret)
+		priv->interface = interface;
+
+out_unlock:
+	mutex_unlock(&priv->lock);
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
+	mutex_lock(&priv->lock);
+	if (priv->powered) {
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		goto out_unlock;
+	priv->powered = true;
+
+	/* Keep the external-supply configuration across subsequent resets. */
+	reset_value = priv->package_known && !priv->internal_dldo ?
+		      AC300_CHIP_RESET_DEASSERT : 0;
+	ret = mdiodev_write(priv->mdiodev, AC300_SYS_CONTROL_REG, reset_value);
+	if (ret)
+		goto err_power_off;
+
+	/* The manual requires both resets to be released before the clocks. */
+	ret = mdiodev_write(priv->mdiodev, AC300_SYS_CONTROL_REG,
+			    AC300_EPHY_RESET_DEASSERT |
+			    AC300_CHIP_RESET_DEASSERT);
+	if (ret)
+		goto err_power_off;
+
+	/* Retain the vendor clock-enable defaults, including the eFuse clock. */
+	ret = mdiodev_write(priv->mdiodev, AC300_SYS_CONTROL_REG,
+			    priv->sys_control);
+	if (ret)
+		goto err_power_off;
+
+	sys_control = mdiodev_read(priv->mdiodev, AC300_SYS_CONTROL_REG);
+	if (sys_control < 0) {
+		ret = sys_control;
+		goto err_power_off;
+	}
+	if (sys_control & AC300_MDIO_ERROR) {
+		ret = mdiodev_write(priv->mdiodev, AC300_SYS_CONTROL_REG,
+				    priv->sys_control | AC300_MDIO_ERROR);
+		if (ret)
+			goto err_power_off;
+
+		sys_control = mdiodev_read(priv->mdiodev, AC300_SYS_CONTROL_REG);
+		if (sys_control < 0) {
+			ret = sys_control;
+			goto err_power_off;
+		}
+		if (sys_control & AC300_MDIO_ERROR) {
+			ret = -EIO;
+			goto err_power_off;
+		}
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
+	ret = mdiodev_modify(priv->mdiodev, AC300_SYS_BIAS1_REG,
+			     AC300_INTERNAL_DLDO_ENABLE,
+			     priv->internal_dldo ?
+			     AC300_INTERNAL_DLDO_ENABLE : 0);
+	if (ret)
+		goto err_power_off;
+
+	/* Keep the documented default drive level and leave the IRQ disabled. */
+	ret = mdiodev_write(priv->mdiodev, AC300_SYS_IO_REG,
+			    AC300_SYS_IO_VALUE);
+	if (ret)
+		goto err_power_off;
+
+	fsleep(10000);
+
+	ret = mdiodev_write(priv->mdiodev, AC300_EPHY_CONFIG_REG,
+			    ac300_ephy_ctl_config(priv) | AC300_EPHY_SHUTDOWN);
+	if (ret)
+		goto err_power_off;
+
+	fsleep(10000);
+
+	ret = mdiodev_write(priv->mdiodev, AC300_EPHY_CONFIG_REG,
+			    ac300_ephy_ctl_config(priv));
+	if (ret)
+		goto err_power_off;
+
+	goto out_unlock;
+
+err_power_off:
+	ac300_ephy_ctl_power_off_locked(priv);
+out_unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int ac300_ephy_ctl_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct ac300_ephy_ctl *priv;
+	unsigned long clk_rate;
+	unsigned int phy_addr;
+	u8 calibration;
+	u8 bgs_effuse_code;
+	u8 package_status;
+	int mask_version;
+	int sys_control;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	if (mdiodev->addr < AC300_EPHY_CONTROL_ADDR_OFFSET ||
+	    mdiodev->addr > AC300_EPHY_CONTROL_ADDR_OFFSET +
+			    FIELD_MAX(AC300_PACKAGE_PHY_ADDR_MASK))
+		return dev_err_probe(dev, -EINVAL,
+				     "control address is outside the package range\n");
+	priv->mdiodev = mdiodev;
+	mutex_init(&priv->lock);
+
+	ret = devm_regulator_get_enable(dev, "vcc1");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable VCC1 supply\n");
+
+	/* Wait for the power-on reset interval specified by the manual. */
+	fsleep(10000);
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "failed to get input clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to lock clock rate\n");
+
+	clk_rate = clk_get_rate(priv->clk);
+	switch (clk_rate) {
+	case 24000000:
+		priv->sys_control = AC300_EPHY_CLK_SEL_24_MHZ;
+		break;
+	case 25000000:
+		priv->sys_control = AC300_EPHY_CLK_SEL_25_MHZ;
+		break;
+	case 27000000:
+		priv->sys_control = AC300_EPHY_CLK_SEL_27_MHZ;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported input clock rate %lu Hz\n",
+				     clk_rate);
+	}
+	priv->sys_control |= AC300_SYS_CONTROL_ENABLE_BITS;
+
+	ret = nvmem_cell_read_u8(dev, "calibration", &calibration);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read calibration data\n");
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
+	mdiodev_set_drvdata(mdiodev, &priv->control);
+
+	/* Validate the package while the control endpoint is known to respond. */
+	phy_addr = ac300_ephy_ctl_link_addr(priv);
+	ret = ac300_ephy_ctl_power_on(&priv->control, phy_addr);
+	if (ret)
+		return ret;
+
+	sys_control = mdiodev_read(mdiodev, AC300_SYS_CONTROL_REG);
+	if (sys_control < 0) {
+		ret = sys_control;
+		goto err_disable;
+	}
+	package_status = FIELD_GET(AC300_PACKAGE_STATUS_MASK, sys_control);
+
+	mask_version = mdiodev_read(mdiodev, AC300_MASK_VERSION_REG);
+	if (mask_version < 0) {
+		ret = mask_version;
+		goto err_disable;
+	}
+
+	dev_info(dev, "chip version %u, mask version %u, package %#x, %s supplies, PHY %u, %lu Hz clock\n",
+		 (unsigned int)FIELD_GET(AC300_CHIP_VERSION_MASK, sys_control),
+		 (unsigned int)FIELD_GET(AC300_MASK_VERSION_MASK, mask_version),
+		 package_status,
+		 package_status & AC300_PACKAGE_POR_INTERNAL_DLDO ?
+			"POR/internal DLDO" : "reset pin/external VDD",
+		 ac300_ephy_ctl_link_addr(priv), clk_rate);
+
+	ret = ac300_ephy_ctl_power_off(&priv->control);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to quiesce control block\n");
+
+	return 0;
+
+err_disable:
+	ac300_ephy_ctl_power_off(&priv->control);
+	return ret;
+}
+
+static void ac300_ephy_ctl_remove(struct mdio_device *mdiodev)
+{
+	struct acx00_ephy_control *control = mdiodev_get_drvdata(mdiodev);
+
+	control->power_off(control);
+}
+
+static const struct of_device_id ac300_ephy_ctl_of_match[] = {
+	{ .compatible = "x-powers,ac300-ephy-ctl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ac300_ephy_ctl_of_match);
+
+static struct mdio_driver ac300_ephy_ctl_driver = {
+	.probe = ac300_ephy_ctl_probe,
+	.remove = ac300_ephy_ctl_remove,
+	.shutdown = ac300_ephy_ctl_remove,
+	.mdiodrv.driver = {
+		.name = "ac300-ephy-ctl",
+		.of_match_table = ac300_ephy_ctl_of_match,
+	},
+};
+
+mdio_module_driver(ac300_ephy_ctl_driver);
+
+MODULE_AUTHOR("James Hilliard <james.hilliard1@gmail.com>");
+MODULE_DESCRIPTION("X-Powers AC300 Ethernet PHY control driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/xpowers-acx00.h b/drivers/net/phy/xpowers-acx00.h
index 482ba6faba6e..0af8895e4cae 100644
--- a/drivers/net/phy/xpowers-acx00.h
+++ b/drivers/net/phy/xpowers-acx00.h
@@ -4,6 +4,8 @@
 
 #include <linux/phy.h>
 
+#define AC300_EPHY_CONTROL_ADDR_OFFSET	16
+
 struct acx00_ephy_control {
 	int (*power_on)(struct acx00_ephy_control *control,
 			unsigned int phy_addr);

-- 
2.53.0

