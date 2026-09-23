Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A56488202;
	Wed, 23 Sep 2026 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160002; cv=none; b=I6FQXv7gquDeYoiDmjr8HTU5952RCqg5MPVX00qKAF5Iqp31AmhTC4r+O0um7GQU2SETgL79qskVUWiqP9xzL+ck1uZA5VPou1RJ5oySwqj89QyRYHinZl8r2lP0sZQh3M4FK+fSXvyF68kYNce6OydAeH0vjqSv4nXWS3M2Y5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160002; c=relaxed/simple;
	bh=Nb3dIFnlfeNKfwiCnrBRyNz6aWD2QFhVC4bW3EFJa24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIRniH9Tk3lgKZd+NoRPORHPDBIysafmu84dA0b+TDKwFvGGLxl4GGv77jZWya9VnUVi/QhkND53CLbDlC/3vU+Gh3yjo0tQj0PZ7uJ2IUtkjypu0j0NVAwGqjJKdqHRDfA9nuQhEwZ79hdpYWxlYC/TC1mhz4hGedPrTRCZxxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PUWh5s8f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3p5ZESl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PUWh5s8f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3p5ZESl"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t3altdyPi6nOwcJldWqfunYafM8u8lfq04M8hrYN7M=;
	b=PUWh5s8feiAEt5ogangjDTpoCluEStI70CzV2oAc3aXPmE48UqJwjiGxZ5Vj6ZL0UCOH+r
	QkBVwqYuOUr7OfKNFSGHhs21fBxUa3RJg696zvucPUyGNZerqjatDVe1x6ORXQ5V+wPbME
	4x1qaw6bbgguNIRzsX9cD09GRXdit0lprsAuHmCWStq+S/DOgQLQg6v/jt49jR3IpWe4Dt
	L8DVJIlsZTAhWIjyBM8jfUtBbizH/FjhJRWPB8RYWOP05GIBecGgoazytBYZe5N2scCqiX
	GL+Dxfy0LzpnuCVOrMO+EMDHirg0CSIHXW+k8mNHkINaYwldUVpzP8kCX/vToA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/t3altdyPi6nOwcJldWqfunYafM8u8lfq04M8hrYN7M=;
	b=v3p5ZESlLf3lqRVSgoHwpgXqLJIe/9l4upD4lSsVJ7r2PYNWb4czkjMr6umdaizJfG5Fmc
	31OTXYGgjENB0jDA==
Date: Wed, 23 Sep 2026 12:39:32 +0200
Subject: [PATCH net-next v3 5/8] net: mdio: Add SoC-e SWIP MDIO controller
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-5-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add a driver for the MDIO controller integrated into SoC-e Ethernet
switch IP cores. Support Clause 22 transactions and the separate address
and data cycles required for Clause 45 accesses.

The transaction control register is shared with the external MDIO bus
selector. The selector occupies bits 26:16 and is managed by a generic
MMIO MDIO mux through the upper 16-bit halfword. Preserve those bits
when starting a transaction.

Check that the controller is idle before programming transaction
registers and poll for completion after each transaction cycle. Return a
timeout instead of waiting indefinitely, and allow a later access to
retry if the hardware becomes idle again.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 drivers/net/mdio/Kconfig     |   7 ++
 drivers/net/mdio/Makefile    |   1 +
 drivers/net/mdio/mdio-soce.c | 239 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 247 insertions(+)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index d44278f26fab..21f2b516880b 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -189,6 +189,13 @@ config MDIO_REGMAP
 	  regmap. Users willing to use this driver must explicitly select
 	  REGMAP.
 
+config MDIO_SOCE
+	tristate "SoC-e MDIO controller"
+	depends on OF_MDIO && HAS_IOMEM
+	help
+	  This module provides a driver for the MDIO controller integrated
+	  into SoC-e Ethernet switch IP cores.
+
 config MDIO_THUNDER
 	tristate "ThunderX SOCs MDIO buses"
 	depends on 64BIT
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 048586746026..079b46dea25f 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_MDIO_OCTEON)		+= mdio-octeon.o
 obj-$(CONFIG_MDIO_PIC64HPSC)		+= mdio-pic64hpsc.o
 obj-$(CONFIG_MDIO_REALTEK_RTL9300)	+= mdio-realtek-rtl9300.o
 obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
+obj-$(CONFIG_MDIO_SOCE)			+= mdio-soce.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
 obj-$(CONFIG_MDIO_XGENE)		+= mdio-xgene.o
diff --git a/drivers/net/mdio/mdio-soce.c b/drivers/net/mdio/mdio-soce.c
new file mode 100644
index 000000000000..59c0b3da483e
--- /dev/null
+++ b/drivers/net/mdio/mdio-soce.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_mdio.h>
+#include <linux/platform_device.h>
+
+#define SOCE_MDIO_TIMEOUT_US		1000
+
+#define SOCE_MDIO_PARAMS_OFFSET		0x0000
+#define SOCE_MDIO_WRITE_OFFSET		0x0004
+#define SOCE_MDIO_READ_OFFSET		0x0008
+#define SOCE_MDIO_DATA_IOMAP_IDX	0
+#define SOCE_MDIO_CTRL_IOMAP_IDX	1
+
+#define SOCE_MDIO_CTRL_BUS_MASK		GENMASK(26, 16)
+#define SOCE_MDIO_CTRL_TRANSTYPE_MASK	GENMASK(4, 3)
+#define SOCE_MDIO_CTRL_TRANSTYPE_WRITE	0x1
+#define SOCE_MDIO_CTRL_TRANSTYPE_READ	0x3
+#define SOCE_MDIO_CTRL_CLAUSE		BIT(1)
+#define SOCE_MDIO_CTRL_OPSTATUS		BIT(0)
+#define SOCE_MDIO_PARAMS_REGDEV_MASK	GENMASK(12, 8)
+#define SOCE_MDIO_PARAMS_PHYADDR_MASK	GENMASK(4, 0)
+#define SOCE_MDIO_READ_DATA_MASK	GENMASK(15, 0)
+
+struct soce_mdio {
+	void __iomem *ctrl;
+	void __iomem *data;
+};
+
+static void __iomem *soce_mdio_iomap(struct device *dev, int index)
+{
+	struct resource res;
+	int ret;
+
+	ret = of_address_to_resource(dev->of_node, index, &res);
+	if (ret)
+		return IOMEM_ERR_PTR(ret);
+
+	return devm_ioremap(dev, res.start, resource_size(&res));
+}
+
+static int soce_mdio_wait_for_idle(struct soce_mdio *priv)
+{
+	void __iomem *ctrl = priv->ctrl;
+	u32 val;
+
+	return readl_poll_timeout(ctrl, val,
+		!(val & SOCE_MDIO_CTRL_OPSTATUS), 10,
+		SOCE_MDIO_TIMEOUT_US);
+}
+
+static void soce_mdio_start(struct soce_mdio *priv, u32 command)
+{
+	void __iomem *ctrl = priv->ctrl;
+
+	/* Keep the currently selected MDIO bus while updating op bits. */
+	command |= readl(ctrl) & SOCE_MDIO_CTRL_BUS_MASK;
+	writel(command, ctrl);
+}
+
+static int soce_mdio_read(struct mii_bus *bus, int phy_addr, int regnum)
+{
+	struct soce_mdio *priv = bus->priv;
+	void __iomem *data = priv->data;
+	u32 command;
+	int ret;
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	writel(FIELD_PREP(SOCE_MDIO_PARAMS_REGDEV_MASK, regnum) |
+	       FIELD_PREP(SOCE_MDIO_PARAMS_PHYADDR_MASK, phy_addr),
+	       data + SOCE_MDIO_PARAMS_OFFSET);
+
+	command = FIELD_PREP(SOCE_MDIO_CTRL_TRANSTYPE_MASK,
+			     SOCE_MDIO_CTRL_TRANSTYPE_READ) |
+		  SOCE_MDIO_CTRL_OPSTATUS;
+	soce_mdio_start(priv, command);
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	return readl(data + SOCE_MDIO_READ_OFFSET) & SOCE_MDIO_READ_DATA_MASK;
+}
+
+static int soce_mdio_read_c45(struct mii_bus *bus, int phy_addr, int devad,
+			      int regnum)
+{
+	struct soce_mdio *priv = bus->priv;
+	void __iomem *data = priv->data;
+	u32 command;
+	int ret;
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	writel(FIELD_PREP(SOCE_MDIO_PARAMS_REGDEV_MASK, devad) |
+	       FIELD_PREP(SOCE_MDIO_PARAMS_PHYADDR_MASK, phy_addr),
+	       data + SOCE_MDIO_PARAMS_OFFSET);
+	writel(regnum, data + SOCE_MDIO_WRITE_OFFSET);
+
+	command = SOCE_MDIO_CTRL_CLAUSE | SOCE_MDIO_CTRL_OPSTATUS;
+	soce_mdio_start(priv, command);
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	command = FIELD_PREP(SOCE_MDIO_CTRL_TRANSTYPE_MASK,
+			     SOCE_MDIO_CTRL_TRANSTYPE_READ) |
+		  SOCE_MDIO_CTRL_CLAUSE | SOCE_MDIO_CTRL_OPSTATUS;
+	soce_mdio_start(priv, command);
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	return readl(data + SOCE_MDIO_READ_OFFSET) & SOCE_MDIO_READ_DATA_MASK;
+}
+
+static int soce_mdio_write(struct mii_bus *bus, int phy_addr, int regnum,
+			   u16 val)
+{
+	struct soce_mdio *priv = bus->priv;
+	void __iomem *data = priv->data;
+	u32 command;
+	int ret;
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	writel(FIELD_PREP(SOCE_MDIO_PARAMS_REGDEV_MASK, regnum) |
+	       FIELD_PREP(SOCE_MDIO_PARAMS_PHYADDR_MASK, phy_addr),
+	       data + SOCE_MDIO_PARAMS_OFFSET);
+	writel(val, data + SOCE_MDIO_WRITE_OFFSET);
+
+	command = FIELD_PREP(SOCE_MDIO_CTRL_TRANSTYPE_MASK,
+			     SOCE_MDIO_CTRL_TRANSTYPE_WRITE) |
+		  SOCE_MDIO_CTRL_OPSTATUS;
+	soce_mdio_start(priv, command);
+
+	return soce_mdio_wait_for_idle(priv);
+}
+
+static int soce_mdio_write_c45(struct mii_bus *bus, int phy_addr, int devad,
+			       int regnum, u16 val)
+{
+	struct soce_mdio *priv = bus->priv;
+	void __iomem *data = priv->data;
+	u32 command;
+	int ret;
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	writel(FIELD_PREP(SOCE_MDIO_PARAMS_REGDEV_MASK, devad) |
+	       FIELD_PREP(SOCE_MDIO_PARAMS_PHYADDR_MASK, phy_addr),
+	       data + SOCE_MDIO_PARAMS_OFFSET);
+	writel(regnum, data + SOCE_MDIO_WRITE_OFFSET);
+
+	command = SOCE_MDIO_CTRL_CLAUSE | SOCE_MDIO_CTRL_OPSTATUS;
+	soce_mdio_start(priv, command);
+
+	ret = soce_mdio_wait_for_idle(priv);
+	if (ret)
+		return ret;
+
+	writel(val, data + SOCE_MDIO_WRITE_OFFSET);
+
+	command = FIELD_PREP(SOCE_MDIO_CTRL_TRANSTYPE_MASK,
+			     SOCE_MDIO_CTRL_TRANSTYPE_WRITE) |
+		  SOCE_MDIO_CTRL_CLAUSE | SOCE_MDIO_CTRL_OPSTATUS;
+	soce_mdio_start(priv, command);
+
+	return soce_mdio_wait_for_idle(priv);
+}
+
+static int soce_mdio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct soce_mdio *priv;
+	struct mii_bus *bus;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	priv = bus->priv;
+	priv->data = soce_mdio_iomap(dev, SOCE_MDIO_DATA_IOMAP_IDX);
+	if (IS_ERR(priv->data))
+		return PTR_ERR(priv->data);
+
+	priv->ctrl = soce_mdio_iomap(dev, SOCE_MDIO_CTRL_IOMAP_IDX);
+	if (IS_ERR(priv->ctrl))
+		return PTR_ERR(priv->ctrl);
+
+	bus->name = "soce mdio";
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->parent = dev;
+	bus->read = soce_mdio_read;
+	bus->write = soce_mdio_write;
+	bus->read_c45 = soce_mdio_read_c45;
+	bus->write_c45 = soce_mdio_write_c45;
+
+	return devm_of_mdiobus_register(dev, bus, dev->of_node);
+}
+
+static const struct of_device_id soce_mdio_of_match[] = {
+	{ .compatible = "soce,swip-mdio-23-02" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, soce_mdio_of_match);
+
+static struct platform_driver soce_mdio_driver = {
+	.probe = soce_mdio_probe,
+	.driver = {
+		.name = "soce-mdio",
+		.of_match_table = soce_mdio_of_match,
+	},
+};
+module_platform_driver(soce_mdio_driver);
+
+MODULE_AUTHOR("Vasilij Strassheim <v.strassheim@linutronix.de>");
+MODULE_DESCRIPTION("SoC-e MDIO controller driver");
+MODULE_LICENSE("GPL");

-- 
2.39.5

