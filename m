Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AF93C2B8F
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896915; cv=none; b=HMutNdmUSTZ4kU0BDQjgjvbcf+xwFwU4SBR4zeKUx8XeTzhr2j6N9QeEI0HRU6vpCYdupfQo7Cyi9Hwz+Xn/ZfeYOAZqrliuWYda2CTZPXLKn+aXOitc9wqd27jHLQ7kp4ZX24ECG5fsLo46aTCncfjKvHwEqefRJe/AiuISnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896915; c=relaxed/simple;
	bh=+Kl7/o2g51rZtXOjQPCwpj9s8N21QOoMJZkvyli0wKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUsXhJ6bXzD8DwlN2ijTSqUV1RaHiCohqnP9SG1rPOrrn5ZbrzhTyXk+vRAqQ8WCPIpWgzPPr/nlHm2K6xMHHXH/AtF+fsTsQ4lx3B6OHgvFWUa5E4YXdndd3ko05XB0utrwsQeZ5Vh+AGS5vL/xe0LX6c41TyLimGY7jfuRxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbNvqBzg; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbNvqBzg"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9ecd7216cso337939a34.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896911; x=1786501711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DteK7ahJcWyyf0jNlGCUan3gdCG+7fB8ZCtaU7OCkNA=;
        b=dbNvqBzgKN1FKhhlir7f44xKTnBZKykt+FwLQ4P9f3TCdCFjP0IcRdVkFf5wiwMr3S
         UtMNHUg5Z8boGvLyEXwDPD81G6qQLIsKdB+Mr7M1bn2SEZl1xplyczZFAKby+WwDSvWL
         ET9BlnGnT9fk5AldPiZ0BZBayXdHH1RNdEo9YczuWYJn/feyq0i/7yGZrDHIsPG4aZHK
         PMc3t78oQTQ5duxedNyTqxVo35Jyw2MRYzW586BRCys6pGBSlemn7YxkD4qKuYpTTEa5
         mifHl2jcfpAT2fgc0OLII/hYRWZmsijvDjLzffyaBwulfSuA817VY7C1sK4rOIRZQctk
         uIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896911; x=1786501711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DteK7ahJcWyyf0jNlGCUan3gdCG+7fB8ZCtaU7OCkNA=;
        b=Bn9/a4jbjUdmu/BBuBG/+lASKPkI+PxpkMe4rPJMgtn1XagbG3RjPDrojw0lJ1nXfA
         237GlTbCmh9Ra/AXCdrQmAdqipHoqTpqTs8iJ3G4aPs7KrVGitMX4bqj0PXmA4t11WqG
         TXeFnYRQ+WQeiSNEn0Qv6Kis7FnwFx8S0HWzJ33lgR2L43E3+s6KM2nSQLmK5fzd/LbI
         q6ugpAWUG3BcUJZknTt0XAe3S5E8zWyhuXBMB+fNx8DPjxPt4vUmjxwbmFLYvNUHGv14
         cArsX0UfuvdVG3SAGDuBsn4PXQddsYIUyCtkYnaAptqw3MUfH5DhoSqIR6G5o5ZNGlgu
         j51w==
X-Gm-Message-State: AOJu0Yxac6ezqlxu/L8UAKWCm+cE82iBAy1qINiSlkT2MJm4GGGmHkoP
	oZUdUoz0Id2WLxkA62K26Ci+uyFj7/TIYQRWrnFOuta/5z/hWKZUTb/X
X-Gm-Gg: AR+sD12YX3TvoPpi2mwNOQo+ekHWImLG46/46T0MUXVwoDQpUcoS5ARJ+Q9LUGlG2rQ
	EqVSk0mBOM8IFXc6vkbNnXbTUZxK7fRz0LPwRAa1YcrTUDEbNU2D7eRXoAKy1lBHrLNwKwWvZDV
	VnFm/ZNscXajyoFuQM8HvHNF1uuMSz4I3axsujw2R15jCZ6X0jb63nZl8a9KhCVlY2V7EHE1u9d
	Ve5I9mZlLCAitCafGkW+N2K8qemJgXMVZEaTI6CVDbOQqrjLKJZa/Qa0uCDLcX9t50ZPMTKuI3L
	PMxNy+weL/jUEeO1dk1siY6KZWfDAlB146cVdboQ8141+Aidd4RR4kTWPf1vRa0CzA8SDOemXAZ
	UN23jFEAyhADUK+ArqLY+uNnl8uEOxzHRq+MLjm6s/95YNVdfGjOS+gyU+5nVQlr7fgkP5LAx+u
	+eNwiAJ6wFw3LHvaL0iyW1F2364EK9maRVGRVV8rVFplEga6bjKeeLJLmzcWuouy4pS0xS+8doZ
	MrKJXZymjnwtXYxsvYyiwOdFO+1IyIXfoyof5Gn7XTiGPIvyNVcY9jFyk9P1ud290H6lXi3S3OC
	wAseXwqmojq1LA/dXw2chpk/iDXiRsJn8GiXfr87oLqYyi8jEn6T7FWrQCGa60Y/aD8ZETmAbq2
	oNXdiCL1WAv3FFTEI
X-Received: by 2002:a05:6830:290a:b0:7f1:ddf1:c731 with SMTP id 46e09a7af769-7f1e5f6ca2dmr2589356a34.13.1785896911128;
        Tue, 04 Aug 2026 19:28:31 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:30 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:27:01 -0600
Subject: [PATCH net-next v2 3/8] mfd: add X-Powers AC200 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-3-3eef49ff1d8c@gmail.com>
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

The X-Powers AC200 is a mixed-signal companion IC with a paged register
map accessed over I2C.

Enable the package supplies and input clock, prevent the clock rate from
changing, and apply the vendor settling delays around common reset.
Initialize the paged regmap, report the chip and package revision, and
instantiate the Ethernet PHY control child when firmware describes it.

Cache only the common page selector. Individual function resets can
invalidate other registers without regmap's knowledge, so all functional
registers remain volatile.

The AC200 and its children cannot initiate DMA. Mark the parent as
DMA-incapable before adding the child. Register the common-reset action
before the MFD child so managed teardown removes the child before
resetting its parent, and also reset the chip during system shutdown.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mfd/Kconfig  |  12 +++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/ac200.c  | 207 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 763ce6a34782..3360c9b86be8 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -205,6 +205,18 @@ config MFD_AC100
 	  This driver include only the core APIs. You have to select individual
 	  components like codecs or RTC under the corresponding menus.
 
+config MFD_AC200
+	tristate "X-Powers AC200"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Support for the X-Powers AC200 mixed-signal companion IC. The AC200
+	  contains audio, video, RTC and Fast Ethernet PHY functions and is
+	  co-packaged with some Allwinner H6 and H616 SoCs. This driver provides
+	  the shared register access used by the individual function drivers.
+
 config MFD_AXP20X
 	tristate
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index dd4bb7e77c33..890e76a9ad00 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -150,6 +150,7 @@ obj-$(CONFIG_MFD_DA9052_SPI)	+= da9052-spi.o
 obj-$(CONFIG_MFD_DA9052_I2C)	+= da9052-i2c.o
 
 obj-$(CONFIG_MFD_AC100)		+= ac100.o
+obj-$(CONFIG_MFD_AC200)		+= ac200.o
 obj-$(CONFIG_MFD_AXP20X)	+= axp20x.o
 obj-$(CONFIG_MFD_AXP20X_I2C)	+= axp20x-i2c.o
 obj-$(CONFIG_MFD_AXP20X_RSB)	+= axp20x-rsb.o
diff --git a/drivers/mfd/ac200.c b/drivers/mfd/ac200.c
new file mode 100644
index 000000000000..dd31205fe698
--- /dev/null
+++ b/drivers/mfd/ac200.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MFD core driver for the X-Powers AC200
+ *
+ * Copyright (C) 2019 Jernej Skrabec <jernej.skrabec@gmail.com>
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ *
+ * Based on the AC100 driver:
+ * Copyright (C) 2016 Chen-Yu Tsai
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define AC200_SYS_VERSION_REG			0x0000
+#define AC200_SYS_VERSION_PACKAGE_MASK		GENMASK(15, 14)
+#define AC200_SYS_VERSION_CHIP_MASK		GENMASK(11, 0)
+
+#define AC200_SYS_CONTROL_REG			0x0002
+#define AC200_SYS_CONTROL_CHIP_RESET_DEASSERT	BIT(0)
+
+/* Interface register accessible from every register page. */
+#define AC200_TWI_REG_ADDR_H	0x00fe
+#define AC200_MAX_REG		0xa1f2
+
+struct ac200 {
+	struct regmap *regmap;
+};
+
+static const char * const ac200_supplies[] = {
+	"ac-ldoin",
+	"ephy-vcc",
+	"rtc-vcc",
+	"tv-vcc",
+};
+
+static const struct regmap_range_cfg ac200_range_cfg[] = {
+	{
+		.range_max = AC200_MAX_REG,
+		.selector_reg = AC200_TWI_REG_ADDR_H,
+		.selector_mask = 0xff,
+		.window_len = 256,
+	},
+};
+
+/*
+ * Each AC200 sub-block can reset independently, invalidating its register
+ * contents without regmap's knowledge. Cache only the common page selector;
+ * this avoids a selector read-modify-write for every access on the same page
+ * without ever returning stale functional-register values.
+ */
+static bool ac200_volatile_reg(struct device *dev, unsigned int reg)
+{
+	return reg != AC200_TWI_REG_ADDR_H;
+}
+
+static const struct regmap_config ac200_regmap_config = {
+	.name = "ac200",
+	.reg_bits = 8,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.ranges = ac200_range_cfg,
+	.num_ranges = ARRAY_SIZE(ac200_range_cfg),
+	.max_register = AC200_MAX_REG,
+	.volatile_reg = ac200_volatile_reg,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static const struct mfd_cell ac200_cells[] = {
+	{
+		.name = "ac200-ephy-ctl",
+		.of_compatible = "x-powers,ac200-ephy-ctl",
+	},
+};
+
+static int ac200_disable(struct ac200 *ac200)
+{
+	return regmap_write(ac200->regmap, AC200_SYS_CONTROL_REG, 0);
+}
+
+static void ac200_disable_action(void *data)
+{
+	ac200_disable(data);
+}
+
+static int ac200_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device_node *ephy_node __free(device_node) = NULL;
+	struct ac200 *ac200;
+	struct clk *clk;
+	unsigned int version;
+	int ret;
+
+	ac200 = devm_kzalloc(dev, sizeof(*ac200), GFP_KERNEL);
+	if (!ac200)
+		return -ENOMEM;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ac200_supplies),
+					     ac200_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable supplies\n");
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "failed to enable input clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to lock clock rate\n");
+
+	ac200->regmap = devm_regmap_init_i2c(client, &ac200_regmap_config);
+	if (IS_ERR(ac200->regmap))
+		return dev_err_probe(dev, PTR_ERR(ac200->regmap),
+				     "failed to initialize regmap\n");
+
+	i2c_set_clientdata(client, ac200);
+
+	/*
+	 * No minimum delay is documented. Match the vendor driver's 40 ms delay
+	 * before its first AC200 register access after enabling the input clock.
+	 */
+	msleep(40);
+
+	ret = regmap_read(ac200->regmap, AC200_SYS_VERSION_REG, &version);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read chip version\n");
+
+	dev_info(dev, "AC200 revision %#lx in package %lu\n",
+		 FIELD_GET(AC200_SYS_VERSION_CHIP_MASK, version),
+		 FIELD_GET(AC200_SYS_VERSION_PACKAGE_MASK, version));
+
+	/* Run after the MFD children have been removed. */
+	ret = devm_add_action_or_reset(dev, ac200_disable_action, ac200);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ac200->regmap, AC200_SYS_CONTROL_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ac200->regmap, AC200_SYS_CONTROL_REG,
+			   AC200_SYS_CONTROL_CHIP_RESET_DEASSERT);
+	if (ret)
+		return ret;
+
+	/* Match the settling interval used by the vendor initialization. */
+	usleep_range(1000, 2000);
+
+	/* Neither the AC200 nor its child devices can perform DMA. */
+	dev->coherent_dma_mask = 0;
+	dev->dma_mask = &dev->coherent_dma_mask;
+	ephy_node = of_get_compatible_child(dev->of_node,
+					    "x-powers,ac200-ephy-ctl");
+	if (!ephy_node)
+		return 0;
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, ac200_cells,
+				   ARRAY_SIZE(ac200_cells), NULL, 0, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add MFD devices\n");
+
+	return 0;
+}
+
+static void ac200_shutdown(struct i2c_client *client)
+{
+	struct ac200 *ac200 = i2c_get_clientdata(client);
+
+	ac200_disable(ac200);
+}
+
+static const struct of_device_id ac200_of_match[] = {
+	{ .compatible = "x-powers,ac200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ac200_of_match);
+
+static const struct i2c_device_id ac200_i2c_ids[] = {
+	{ "ac200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ac200_i2c_ids);
+
+static struct i2c_driver ac200_driver = {
+	.driver = {
+		.name = "ac200",
+		.of_match_table = ac200_of_match,
+	},
+	.probe = ac200_probe,
+	.shutdown = ac200_shutdown,
+	.id_table = ac200_i2c_ids,
+};
+module_i2c_driver(ac200_driver);
+
+MODULE_AUTHOR("James Hilliard <james.hilliard1@gmail.com>");
+MODULE_DESCRIPTION("X-Powers AC200 MFD core driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0

