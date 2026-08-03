Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AF3955F5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734145; cv=none; b=I7uYN0ry57Via2ek1haavmWFU7Ez0fcyJTanNV4cyTrRtPmPVHskdoTVXCleH6mE1tMGmhNiU9r6NMU0o1OWE8xWmelA2OVlOF9HroLFLtmtDYuAIsuGmTpuSD4n3I2ZhPUGMH8f9s3hRU3iruko/nDbsaH3hAhFZpFBR9OnRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734145; c=relaxed/simple;
	bh=FJxa6pnlwH8NOKl4g0tgsIa3AWI3yPSDz31JZnSznJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWz5SpsuMvPmvRfXAIEpmiBDEYqkQXheXsc5c3xaKKKwUcSi2uvib5o+hsbkouXnA8ehLEbGmqNpBjXYnvy78LMs6xEOOSiwZdEWlYOl2Atl30crLYvCv6yNjxPgrLVLVtkopVQZ4diTynYWWa5msFJmjRMPiSDWy+YJM3tjXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leYzX+SU; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leYzX+SU"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f18c0e03e3so1152333a34.2
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734141; x=1786338941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DdvS6JgS1wsN4XXB/DPlHPE/KXR5tqJa5L67sBE8VSE=;
        b=leYzX+SU8N98LMFn8P9ItG9GggJW/+jm6NJa2j3s+Yj8ihGqjEERjOTgcXuh57e+TM
         ADY7vT0968f/bh194a8E7p4OsbuZ2aoEaivI6yNBo7AOkYnFuxqGAe253NnpHar6wtCB
         2cDdqUQnb35+CyUjoCFRbcH4XuyZUL6LOeGJJVloGdEPuoCH3S/08z/lCXcdkZO3w61B
         NsdZ5lz8GZ0QXL4ssrUUS/UFDvTOS9+tFQt/norS6/Wbh/IOujtosFOOl0vYYUuRZOOk
         /I0ETLhrfscGyqcnES2/Viqo+4oNDqk5TQaxZX5Ex0hj3rvkcBwpLDu4e+J9NU6W1yYu
         xJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734141; x=1786338941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DdvS6JgS1wsN4XXB/DPlHPE/KXR5tqJa5L67sBE8VSE=;
        b=SHszkYnRQnVbvdCjaYnL5kAXeTX6FTo2zkS5PiYDEd4UWuyu8IpdM3OVlDYy+SPcqQ
         OmAAmk1CkJDO2O8ntw8OKdJ6UQtwdIvCBCc6pXN4/VJaYoQeu+iTUaio73A8OxAjeuZm
         ni4ZY+2RdTqCp/atrnOVc68KBRyIy3rnoQBxEsQolwginjQIJ2lOAMcqW3Pjk0ty4Qbx
         s5E9vTFfzm9lYZ5IFXu5Oav23JOQO4fdkzutIWqwje2TBQxxBQuDX1WfIdH8p9UUQYhG
         i6UU5BCuxjemXtyYaSuG1Vh1DlYaA8d2HBJC4UOgHxLVT599ntGFvTrlcDvSAXUXmRFo
         KBDA==
X-Gm-Message-State: AOJu0YwHmXTdSOb9fefF48lnR0ascTmEAm4SKNi8y0ABCnQDSgocYnZS
	ifeF3ZhteqXDu2rCEPAL0rehr12e8didrbwl5QrcuJyWyGL9nbQOpqxE
X-Gm-Gg: AR+sD12SQNj/BD3Qxv++OknxalgmFZSFpFWhFJMXBv0iZ2fHjD2jIumzZTLAu+40M8B
	2Buwq6sIPxU1ghd/N/OFbDjc+ODGg3br4okSH4bJMtPNcb2Z6Scn0ceOkir7PG0z3jA585rEoFJ
	FuVHoZ/z5zWTSPJd4jzjd5J+kxg5toi9zhedpFDsOWkF1iVqXlfDeBkONR5qczdQmq0ke0fymQ7
	179tylnzH/ruU9hksFLCGPiGyfLUK99lFN/giviQ5A79a3QmCAom32Na9Sdvb06KWJynKHPWQbf
	QsimprYKq7mYSXLek6L22DTSy583Qw9j/i1lSOybZ0wkm7+Y035YaYxqIkJi6D2MLLXNvEwc5q/
	C8rVORNlSPxIBrC3nqG5fPeKl1jZhJ0mj/pXyuHodUatYI4RDEpt7sVx3rj+1t+FCHME1ZYSfwA
	U2E8IMU5VYoaNrp8qKiWDkRgn95dF6eV1iI1Avhd/NeurpX4a2kj75kcsyF2WhbZPZBsNP6Q+8G
	bn8mj2VeUz4phlomJbnZYs6MV3xyfZEa+8auSPGfUvceNf1FxLU0hu+q+LmsBNCloh4AY/zELLx
	2yTEuP4/wQ7Qy+p6TpVgO+PRiAVrtYcTjcwRHkLWo2F5WsGYEMi4fbfFtMujqzUdrkNlnoH81NH
	8omyF9WwDgMKXcq/+
X-Received: by 2002:a05:6830:3814:b0:7e6:ca29:9609 with SMTP id 46e09a7af769-7f196d82b85mr13995078a34.13.1785734136211;
        Sun, 02 Aug 2026 22:15:36 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:20 -0600
Subject: [PATCH 10/21] net: phy: add X-Powers AC200 EPHY control driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-10-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The AC200 Fast Ethernet PHY is powered and configured through registers
in the parent I2C regmap before its Clause 22 link registers become usable.

Add a control driver that prepares the calibration value and vendor
offset, interface mode and input-clock selection. Use an optional SoC SID
cell when supplied, otherwise read the AC200's internal calibration eFuse.
Derive the documented 24 or 27 MHz selector from the actual locked clock
rate. Although the feature summary also mentions 25 MHz, EPHY_CTL provides
no encoding for it, so reject that rate rather than silently selecting
27 MHz.

Program the link PHY MDIO address into EPHY_CTL.PHY_ADDR before bringing
the PHY out of its disabled state using the vendor initialization sequence.

Expose serialized, idempotent power-on and power-off operations so the
link-PHY driver can sequence the control block across resets and system
sleep. Also expose operations for the global LED polarity and package pad
enables. Initialize all three outputs active-low as in the vendor kernel,
while allowing an explicit link-PHY LED topology to replace that fallback.
Quiesce the block during probe failures, driver removal and system
shutdown.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/phy/Kconfig             |   9 +
 drivers/net/phy/Makefile            |   1 +
 drivers/net/phy/xpowers-ac200-ctl.c | 330 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/xpowers-acx00.h     |  25 +++
 4 files changed, 365 insertions(+)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 099f25dceabb..e059bd6c5eda 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -469,6 +469,15 @@ config VITESSE_PHY
 	help
 	  Currently supports the vsc8244
 
+config XPOWERS_AC200_PHY_CTL
+	tristate "X-Powers AC200 Ethernet PHY control"
+	depends on MFD_AC200
+	help
+	  Enable the control driver for the Fast Ethernet PHY function in
+	  the X-Powers AC200 mixed-signal companion IC. It programs the PHY
+	  address, interface mode, calibration and I/O controls through the
+	  parent AC200 I2C regmap.
+
 config XILINX_GMII2RGMII
 	tristate "Xilinx GMII2RGMII converter driver"
 	help
diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index de660ae94945..e53ca319f9c4 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -99,4 +99,5 @@ obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_STE10XP)		+= ste10Xp.o
 obj-$(CONFIG_TERANETICS_PHY)	+= teranetics.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
+obj-$(CONFIG_XPOWERS_AC200_PHY_CTL) += xpowers-ac200-ctl.o
 obj-$(CONFIG_XILINX_GMII2RGMII) += xilinx_gmii2rgmii.o
diff --git a/drivers/net/phy/xpowers-ac200-ctl.c b/drivers/net/phy/xpowers-ac200-ctl.c
new file mode 100644
index 000000000000..c2a37f958565
--- /dev/null
+++ b/drivers/net/phy/xpowers-ac200-ctl.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * X-Powers AC200 Ethernet PHY control driver
+ *
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#include "xpowers-acx00.h"
+
+#define AC200_EPHY_BPS_EFFUSE_OFFSET	3
+
+#define AC200_SYS_EPHY_CTL0_REG			0x0014
+#define AC200_EPHY_RESET_DEASSERT		BIT(0)
+#define AC200_EPHY_SYSCLK_ENABLE			BIT(1)
+
+#define AC200_SYS_EPHY_CTL1_REG			0x0016
+#define AC200_EPHY_MII_IO_ENABLE			BIT(0)
+#define AC200_EPHY_LINK_LED_IO_ENABLE		BIT(1)
+#define AC200_EPHY_SPEED_LED_IO_ENABLE		BIT(2)
+#define AC200_EPHY_DUPLEX_LED_IO_ENABLE		BIT(3)
+#define AC200_EPHY_LED_IO_ENABLE_MASK \
+	(AC200_EPHY_LINK_LED_IO_ENABLE | AC200_EPHY_SPEED_LED_IO_ENABLE | \
+	 AC200_EPHY_DUPLEX_LED_IO_ENABLE)
+
+/* AC200-internal copy of the Ethernet PHY calibration eFuse. */
+#define AC200_EFUSE_EPHY_REG			0x8004
+
+#define AC200_EPHY_CTL_REG			0x6000
+#define AC200_EPHY_SHUTDOWN			BIT(0)
+#define AC200_EPHY_LED_ACTIVE_LOW		BIT(1)
+#define AC200_EPHY_CLK_SEL_24_MHZ		BIT(2)
+#define AC200_EPHY_PHY_ADDR_MASK			GENMASK(8, 4)
+#define AC200_EPHY_RMII_SEL			BIT(11)
+#define AC200_EPHY_BPS_EFFUSE_MASK		GENMASK(15, 12)
+
+struct ac200_ephy_ctl {
+	struct acx00_ephy_control control;
+	struct regmap *regmap;
+	struct mutex lock; /* Serializes power sequencing and state. */
+	u16 ephy_ctl;
+	u16 led_io_enable;
+	unsigned int phy_addr;
+	bool powered;
+};
+
+static int
+ac200_ephy_ctl_set_led_outputs(struct acx00_ephy_control *control,
+			       unsigned long outputs)
+{
+	struct ac200_ephy_ctl *priv =
+		container_of(control, struct ac200_ephy_ctl, control);
+	u16 led_io_enable;
+	int ret = 0;
+
+	if (outputs & ~GENMASK(ACX00_EPHY_LED_COUNT - 1, 0))
+		return -EINVAL;
+
+	led_io_enable = (outputs << 1) & AC200_EPHY_LED_IO_ENABLE_MASK;
+
+	mutex_lock(&priv->lock);
+	if (priv->powered)
+		ret = regmap_update_bits(priv->regmap, AC200_SYS_EPHY_CTL1_REG,
+					 AC200_EPHY_LED_IO_ENABLE_MASK,
+					 led_io_enable);
+	if (!ret)
+		priv->led_io_enable = led_io_enable;
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int
+ac200_ephy_ctl_set_led_polarity(struct acx00_ephy_control *control,
+				bool active_low)
+{
+	struct ac200_ephy_ctl *priv =
+		container_of(control, struct ac200_ephy_ctl, control);
+	u16 value = active_low ? AC200_EPHY_LED_ACTIVE_LOW : 0;
+	int ret = 0;
+
+	mutex_lock(&priv->lock);
+	if (priv->powered)
+		ret = regmap_update_bits(priv->regmap, AC200_EPHY_CTL_REG,
+					 AC200_EPHY_LED_ACTIVE_LOW, value);
+	if (!ret) {
+		priv->ephy_ctl &= ~AC200_EPHY_LED_ACTIVE_LOW;
+		priv->ephy_ctl |= value;
+	}
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int ac200_ephy_ctl_power_off_locked(struct ac200_ephy_ctl *priv)
+{
+	int err;
+	int ret;
+
+	if (!priv->powered)
+		return 0;
+
+	ret = regmap_write(priv->regmap, AC200_EPHY_CTL_REG,
+			   priv->ephy_ctl |
+			   FIELD_PREP(AC200_EPHY_PHY_ADDR_MASK,
+				      priv->phy_addr) |
+			   AC200_EPHY_SHUTDOWN);
+	err = regmap_write(priv->regmap, AC200_SYS_EPHY_CTL1_REG, 0);
+	if (!ret)
+		ret = err;
+	err = regmap_write(priv->regmap, AC200_SYS_EPHY_CTL0_REG, 0);
+	if (!ret)
+		ret = err;
+
+	priv->powered = false;
+
+	return ret;
+}
+
+static int ac200_ephy_ctl_power_off(struct acx00_ephy_control *control)
+{
+	struct ac200_ephy_ctl *priv =
+		container_of(control, struct ac200_ephy_ctl, control);
+	int ret;
+
+	mutex_lock(&priv->lock);
+	ret = ac200_ephy_ctl_power_off_locked(priv);
+	mutex_unlock(&priv->lock);
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
+	mutex_lock(&priv->lock);
+	if (priv->powered && priv->phy_addr == phy_addr) {
+		ret = 0;
+		goto out_unlock;
+	}
+	if (priv->powered) {
+		ret = ac200_ephy_ctl_power_off_locked(priv);
+		if (ret)
+			goto out_unlock;
+	}
+
+	ephy_ctl = priv->ephy_ctl |
+		FIELD_PREP(AC200_EPHY_PHY_ADDR_MASK, phy_addr);
+
+	/* Start from a disabled state before applying the configuration. */
+	ret = regmap_write(priv->regmap, AC200_SYS_EPHY_CTL0_REG, 0);
+	if (ret)
+		goto err_disable;
+
+	ret = regmap_write(priv->regmap, AC200_SYS_EPHY_CTL1_REG,
+			   AC200_EPHY_MII_IO_ENABLE |
+			   priv->led_io_enable);
+	if (ret)
+		goto err_disable;
+
+	ret = regmap_write(priv->regmap, AC200_EPHY_CTL_REG,
+			   ephy_ctl | AC200_EPHY_SHUTDOWN);
+	if (ret)
+		goto err_disable;
+
+	ret = regmap_write(priv->regmap, AC200_SYS_EPHY_CTL0_REG,
+			   AC200_EPHY_RESET_DEASSERT |
+			   AC200_EPHY_SYSCLK_ENABLE);
+	if (ret)
+		goto err_disable;
+
+	fsleep(10000);
+
+	ret = regmap_write(priv->regmap, AC200_EPHY_CTL_REG, ephy_ctl);
+	if (ret)
+		goto err_disable;
+
+	priv->phy_addr = phy_addr;
+	priv->powered = true;
+	goto out_unlock;
+
+err_disable:
+	/* Mark it active so the cleanup sequence is always attempted. */
+	priv->phy_addr = phy_addr;
+	priv->powered = true;
+	ac200_ephy_ctl_power_off_locked(priv);
+out_unlock:
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int ac200_ephy_ctl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ac200_ephy_ctl *priv;
+	phy_interface_t interface;
+	struct clk *clk;
+	unsigned long clk_rate;
+	unsigned int calibration;
+	u8 nvmem_calibration;
+	u8 bps_effuse_code;
+	u16 ephy_ctl;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	mutex_init(&priv->lock);
+
+	priv->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!priv->regmap)
+		return dev_err_probe(dev, -EPROBE_DEFER,
+				     "parent regmap is not ready\n");
+
+	if (device_property_present(dev, "nvmem-cells")) {
+		ret = nvmem_cell_read_u8(dev, "calibration",
+					 &nvmem_calibration);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read calibration data\n");
+		calibration = nvmem_calibration;
+	} else {
+		ret = regmap_read(priv->regmap, AC200_EFUSE_EPHY_REG,
+				  &calibration);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read on-chip calibration data\n");
+	}
+
+	ret = device_get_phy_mode(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read PHY mode\n");
+	interface = ret;
+
+	/* The vendor driver supplies no transfer function beyond this offset. */
+	bps_effuse_code = (calibration + AC200_EPHY_BPS_EFFUSE_OFFSET) &
+			   FIELD_MAX(AC200_EPHY_BPS_EFFUSE_MASK);
+	ephy_ctl = FIELD_PREP(AC200_EPHY_BPS_EFFUSE_MASK, bps_effuse_code) |
+		   AC200_EPHY_LED_ACTIVE_LOW;
+	/* EPHY_MODE and BIST_CLK_EN stay clear for normal operation. */
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		ephy_ctl |= AC200_EPHY_RMII_SEL;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported PHY mode %s\n",
+				     phy_modes(interface));
+	}
+
+	clk = clk_get(dev->parent, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get input clock\n");
+
+	clk_rate = clk_get_rate(clk);
+	clk_put(clk);
+
+	switch (clk_rate) {
+	case 24000000:
+		ephy_ctl |= AC200_EPHY_CLK_SEL_24_MHZ;
+		break;
+	case 27000000:
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "unsupported input clock rate %lu Hz\n",
+				     clk_rate);
+	}
+
+	priv->control.power_on = ac200_ephy_ctl_power_on;
+	priv->control.power_off = ac200_ephy_ctl_power_off;
+	priv->control.set_led_outputs = ac200_ephy_ctl_set_led_outputs;
+	priv->control.set_led_polarity = ac200_ephy_ctl_set_led_polarity;
+	priv->control.interface = interface;
+	priv->ephy_ctl = ephy_ctl;
+	priv->led_io_enable = AC200_EPHY_LED_IO_ENABLE_MASK;
+	platform_set_drvdata(pdev, &priv->control);
+	return 0;
+}
+
+static void ac200_ephy_ctl_remove(struct platform_device *pdev)
+{
+	struct acx00_ephy_control *control = platform_get_drvdata(pdev);
+
+	control->power_off(control);
+}
+
+static const struct of_device_id ac200_ephy_ctl_of_match[] = {
+	{ .compatible = "x-powers,ac200-ephy-ctl" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ac200_ephy_ctl_of_match);
+
+static struct platform_driver ac200_ephy_ctl_driver = {
+	.probe = ac200_ephy_ctl_probe,
+	.remove = ac200_ephy_ctl_remove,
+	.shutdown = ac200_ephy_ctl_remove,
+	.driver = {
+		.name = "ac200-ephy-ctl",
+		.of_match_table = ac200_ephy_ctl_of_match,
+	},
+};
+module_platform_driver(ac200_ephy_ctl_driver);
+
+MODULE_AUTHOR("James Hilliard <james.hilliard1@gmail.com>");
+MODULE_DESCRIPTION("X-Powers AC200 Ethernet PHY control driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/phy/xpowers-acx00.h b/drivers/net/phy/xpowers-acx00.h
new file mode 100644
index 000000000000..8cf6fe616137
--- /dev/null
+++ b/drivers/net/phy/xpowers-acx00.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __DRIVERS_NET_PHY_XPOWERS_ACX00_H
+#define __DRIVERS_NET_PHY_XPOWERS_ACX00_H
+
+#include <linux/phy.h>
+
+enum acx00_ephy_led {
+	ACX00_EPHY_LED_LINK_ACTIVITY,
+	ACX00_EPHY_LED_SPEED,
+	ACX00_EPHY_LED_DUPLEX,
+	ACX00_EPHY_LED_COUNT,
+};
+
+struct acx00_ephy_control {
+	phy_interface_t interface;
+	int (*power_on)(struct acx00_ephy_control *control,
+			unsigned int phy_addr);
+	int (*power_off)(struct acx00_ephy_control *control);
+	int (*set_led_outputs)(struct acx00_ephy_control *control,
+			       unsigned long outputs);
+	int (*set_led_polarity)(struct acx00_ephy_control *control,
+				bool active_low);
+};
+
+#endif

-- 
2.53.0

