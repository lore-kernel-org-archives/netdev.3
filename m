Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91C47D440
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 07:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962597; cv=none; b=pMDjMO8jKxkSd6zmL2AVw30n/mu6PA0MHBC35YL4MMwJF6uJfcP/R5+MnvH9OsAZrXflc+147bsaKcYb7wbLQpU/FTA/zB44gG4E98E94CHRmJj9k2zQ1469z9HmmI79ufpoJ92R7f63idJYqIfFL4lzaRIv9o5OfVQFrJYuJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962597; c=relaxed/simple;
	bh=4TA+L1CPkCZuDbEq9Cory5nOrbbxEIllqqfFp5BOn0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK5NITH2j0PQbhxNwUoXDUHVW60KvMj7uq3LWFvZnuaViXhzVoSvneqgjXVuFkoSfA2hnKUsJ9Wb9lV3DSyudqFfy5c5BYHqkcqJeylOJd/jder2BXLMH1XCjjlVW5qyeqBJxxWJEpGn44Ys9mtL57ri5mVWaKGgFed1f91miwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJ3i3mq9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJ3i3mq9"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2667065f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791962588; x=1792567388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F1UhGspZt3n8d7AimaUoaUHhmKl1e/RrKismBjq1j3Q=;
        b=hJ3i3mq9xMJOEIshQOfF3pinETtMasu42yMcXw04owp32ZWeIqya7OYAv8trLOPtPf
         1k3DYIW1FVRN/Zi2L0RorJP9XjJIuy+Fp4UWy6jNxngtPerHRvqpswWqcSSIbZc+QFSt
         Z3CetxcDl/vWSIMA9maBB9plEkWL83+btTaiuoLmpJIn3O77uZIqWh3WfEthH9/xCj4S
         V3lKLxFV8Jh+oeAJn/BEyiVJYJD/uJknZ0B89kZLmSMznq8xET56j0nSqXMUtj1lQmBl
         Ib22usbz9Fc9VItbfJWnaAEdKbwpediDRKDX8AidU4orJ34duj82Afgu5bFga8PClSou
         Ddmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962588; x=1792567388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F1UhGspZt3n8d7AimaUoaUHhmKl1e/RrKismBjq1j3Q=;
        b=jWqHK9ncxmdiooJNaIKrvq497xRo1x08V0LJ486f7FDbtFHSxXKXN6sbZyqaEeDzQm
         qqN6+U6jwqZYwlg5nW4i/6ywbZvtd9eoG3+oPs35Kx4/p1jfkwwISkifXnIPUj2CzwYs
         1d6j9gRq7IDl2PTOKqS1B2TWTB+AR2WrqUV1SRrWkky11R2eCaLqqku4UNrgYmLXZBjo
         s81pf7BS0bOXWvlnH2GQ6KybectHbAhgkBD+/f0ZBA9M4QrKf2BmMGTTUIUr2BIuwGaD
         uup18KsnaY1f/QfEJSpgKimTWIVGtW523nrGrplZMbR3wEUFSIkXG5X7tLNdM2cYDZm7
         CBEA==
X-Forwarded-Encrypted: i=1; AKwUvBw5c1d89twKhrgOVC5lme9LFpOjT8/nWdDB51JRNnEsty2/KAfJOrXGodwTLpB5bR2IX0tCOIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbW2fDXpDTNJ3hgx/s/epfuxCkElW5BPRSfl8cCjrK8HGlUMdc
	aGMZ6013hWZZh0+Dhwo1U5z6DfREC/1qJwOzrUTV5svydtwXFlutlG1R
X-Gm-Gg: AYBFou0ZJooZFUTjQGxbvnbKkFSgq7rZYfs/ahXuhgNmXAyY+Tu2RySppMfB3PFcv5s
	GkwfKsmpTNA19pbLWqWSIlaOTBc/nruKSHL7pkFRSaOy+bHZEqEGDEv0LX9VJo9F/4fLFwAtzQg
	+xdD+4Ado6yivepn5XDPB9Z1YDnLspvpfTRUE7kcJ4vxmhfRyp2xBJijhlqAzi7EHNt9owV8deA
	ryVCFfcUls2QMYdi5QxL9+hyvoeFcsH1qxd/J8RIJEC+ds5sjti6IEW7qN/JB5cUekfkRKckgys
	N/yhvFwPnEHH25a+Nr5tMz5MDhaml6omAZJfPsclf9OaKz00h7xP6KOVV7s7hlFaKi1KintfLez
	erE1mgpPWdiU4o7L6+mSq8c9KF3x/dT4nODEc6tVg5TZfKNzCzXca5p3IlXgsOPeeqCM0u9gNfL
	6spcP2uEZ6b0/QBq2+tgvN8mQj0Tcu3eqItqEoGCN2OLBbq+OuifCcNb/jEVTpWkN+CPdriAmaU
	tMdfTQMmF9AI+B87c3hGhP1abqi+sNDtxuFcKPe8n4JEwEeXaHMLxoY473p07PWN0oPVNKxCL1i
	enWbzZiaBZUxUpgTBflSURllxxHbSZsfTtfMkyEIEZ1loYoTqpZaoz/0pWuoybdK8x2c6Pke
X-Received: by 2002:a05:6000:2c06:b0:48d:ed3c:4cdd with SMTP id ffacd0b85a97d-48ded3c5789mr1068940f8f.49.1791962588408;
        Wed, 14 Oct 2026 00:23:08 -0700 (PDT)
Received: from navid-pc ([2a01:4b00:a856:6220::a11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de3f7f8b8sm8500933f8f.35.2026.10.14.00.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:23:07 -0700 (PDT)
From: Navid Ghahremani <ghahramani.navid@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de,
	stefandoesinger@gmail.com,
	krzk@kernel.org,
	Navid Ghahremani <ghahramani.navid@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 15/24] net: mdio: Add ZTE ZX279128S MDIO controller
Date: Wed, 14 Oct 2026 08:20:55 +0100
Message-ID: <20261014072109.1759502-16-ghahramani.navid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide bounded Clause 22 transactions and managed clock and MDIO-bus
registration.

Signed-off-by: Navid Ghahremani <ghahramani.navid@gmail.com>
---
 drivers/net/mdio/Kconfig          |  11 +++
 drivers/net/mdio/Makefile         |   1 +
 drivers/net/mdio/mdio-zx279128s.c | 157 ++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 drivers/net/mdio/mdio-zx279128s.c

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index a05229838c..59812a082a 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -199,6 +199,17 @@ config MDIO_THUNDER
 	  ThunderX SoCs when the MDIO bus device appears as a PCI
 	  device.
 
+config MDIO_ZX279128S
+	tristate "ZTE zx279128s MDIO bus controller"
+	depends on ARCH_ZTE || COMPILE_TEST
+	depends on HAS_IOMEM && OF_MDIO
+	help
+	  This driver supports the MDIO controller of the ZTE zx279128s
+	  SoC. It reaches the PHYs of the integrated switch and, on boards
+	  such as the ZTE ZXHN H3600, an external PHY.
+
+	  To compile this driver as a module, choose M here.
+
 menu "MDIO Multiplexers"
 
 config MDIO_BUS_MUX
diff --git a/drivers/net/mdio/Makefile b/drivers/net/mdio/Makefile
index 0485867460..ce21e1496c 100644
--- a/drivers/net/mdio/Makefile
+++ b/drivers/net/mdio/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_MDIO_REGMAP)		+= mdio-regmap.o
 obj-$(CONFIG_MDIO_SUN4I)		+= mdio-sun4i.o
 obj-$(CONFIG_MDIO_THUNDER)		+= mdio-thunder.o
 obj-$(CONFIG_MDIO_XGENE)		+= mdio-xgene.o
+obj-$(CONFIG_MDIO_ZX279128S)		+= mdio-zx279128s.o
 
 obj-$(CONFIG_MDIO_BUS_MUX)		+= mdio-mux.o
 obj-$(CONFIG_MDIO_BUS_MUX_BCM6368)	+= mdio-mux-bcm6368.o
diff --git a/drivers/net/mdio/mdio-zx279128s.c b/drivers/net/mdio/mdio-zx279128s.c
new file mode 100644
index 0000000000..fa0aab5b28
--- /dev/null
+++ b/drivers/net/mdio/mdio-zx279128s.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ZTE zx279128s MDIO controller
+ *
+ * Copyright (C) 2026 Navid Ghahremani <ghahramani.navid@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+
+#define ZX_MDIO_DATA_WR		0x04
+#define ZX_MDIO_DATA_RD		0x08
+#define ZX_MDIO_CFG		0x0c
+#define ZX_MDIO_STATUS		0x10
+#define  ZX_MDIO_STATUS_DONE	BIT(0)
+#define ZX_MDIO_CMD		0x14
+#define  ZX_MDIO_CMD_REG	GENMASK(4, 0)
+#define  ZX_MDIO_CMD_ADDR	GENMASK(9, 5)
+#define  ZX_MDIO_CMD_WR		BIT(10)
+#define  ZX_MDIO_CMD_RD		BIT(11)
+#define  ZX_MDIO_CMD_CLK_DIV	BIT(12)
+#define  ZX_MDIO_CMD_BIT13	BIT(13)
+#define  ZX_MDIO_CMD_START	BIT(14)
+#define  ZX_MDIO_CMD_BIT15	BIT(15)
+
+#define ZX_MDIO_POLL_US		10
+#define ZX_MDIO_TIMEOUT_US	2000
+
+struct zx279128s_mdio {
+	void __iomem *base;
+};
+
+static int zx279128s_mdio_xfer(struct mii_bus *bus, u32 op, int addr,
+			       int regnum, u16 data)
+{
+	struct zx279128s_mdio *priv = bus->priv;
+	void __iomem *base = priv->base;
+	u32 cmd, val;
+	int ret;
+
+	/* Clear the previous command and its status */
+	writel(readl(base + ZX_MDIO_CMD) & ~ZX_MDIO_CMD_START,
+	       base + ZX_MDIO_CMD);
+	writel(0, base + ZX_MDIO_STATUS);
+
+	cmd = readl(base + ZX_MDIO_CMD);
+	cmd &= ~(ZX_MDIO_CMD_WR | ZX_MDIO_CMD_RD | ZX_MDIO_CMD_ADDR |
+		 ZX_MDIO_CMD_REG);
+	cmd |= op | FIELD_PREP(ZX_MDIO_CMD_ADDR, addr) |
+	       FIELD_PREP(ZX_MDIO_CMD_REG, regnum);
+
+	if (op == ZX_MDIO_CMD_WR)
+		writel(data, base + ZX_MDIO_DATA_WR);
+	writel(cmd | ZX_MDIO_CMD_START, base + ZX_MDIO_CMD);
+
+	ret = readl_poll_timeout(base + ZX_MDIO_STATUS, val,
+				 val & ZX_MDIO_STATUS_DONE, ZX_MDIO_POLL_US,
+				 ZX_MDIO_TIMEOUT_US);
+	if (ret) {
+		dev_err_ratelimited(&bus->dev, "timeout (addr %d, reg %d)\n",
+				    addr, regnum);
+		return ret;
+	}
+
+	writel(0, base + ZX_MDIO_STATUS);
+	writel(readl(base + ZX_MDIO_CMD) & ~ZX_MDIO_CMD_START,
+	       base + ZX_MDIO_CMD);
+
+	return 0;
+}
+
+static int zx279128s_mdio_read(struct mii_bus *bus, int addr, int regnum)
+{
+	struct zx279128s_mdio *priv = bus->priv;
+	int ret;
+
+	ret = zx279128s_mdio_xfer(bus, ZX_MDIO_CMD_RD, addr, regnum, 0);
+	if (ret)
+		return ret;
+
+	return readl(priv->base + ZX_MDIO_DATA_RD) & 0xffff;
+}
+
+static int zx279128s_mdio_write(struct mii_bus *bus, int addr, int regnum,
+				u16 val)
+{
+	return zx279128s_mdio_xfer(bus, ZX_MDIO_CMD_WR, addr, regnum, val);
+}
+
+static int zx279128s_mdio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zx279128s_mdio *priv;
+	struct mii_bus *bus;
+	struct clk *clk;
+	u32 val;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*priv));
+	if (!bus)
+		return -ENOMEM;
+
+	priv = bus->priv;
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	clk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get the register clock\n");
+	clk = devm_clk_get_enabled(dev, "wclk");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to get the work clock\n");
+
+	val = readl(priv->base + ZX_MDIO_CMD);
+	val &= ~(ZX_MDIO_CMD_START | ZX_MDIO_CMD_BIT15 | ZX_MDIO_CMD_BIT13);
+	val |= ZX_MDIO_CMD_CLK_DIV;
+	writel(val, priv->base + ZX_MDIO_CMD);
+	writel(0, priv->base + ZX_MDIO_STATUS);
+	writel(0, priv->base + ZX_MDIO_CFG);
+
+	bus->name = "zx279128s-mdio";
+	bus->read = zx279128s_mdio_read;
+	bus->write = zx279128s_mdio_write;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+	bus->parent = dev;
+
+	return devm_of_mdiobus_register(dev, bus, dev->of_node);
+}
+
+static const struct of_device_id zx279128s_mdio_of_match[] = {
+	{ .compatible = "zte,zx279128s-mdio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, zx279128s_mdio_of_match);
+
+static struct platform_driver zx279128s_mdio_driver = {
+	.probe = zx279128s_mdio_probe,
+	.driver = {
+		.name = "zx279128s-mdio",
+		.of_match_table = zx279128s_mdio_of_match,
+	},
+};
+module_platform_driver(zx279128s_mdio_driver);
+
+MODULE_AUTHOR("Navid Ghahremani <ghahramani.navid@gmail.com>");
+MODULE_DESCRIPTION("ZTE zx279128s MDIO controller driver");
+MODULE_LICENSE("GPL");
-- 
2.55.0

