Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD63D6CCD
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786307351; cv=none; b=r1dKJhwjTo/V6uu6zsp/cVsE7w8gFn119V6ZsHpcqOKaWU90KAm/w3CkIEDhAqx2bmEo0LZWFJPCDoHaA5psxR9K/3/6Z5U7vtVIiC2J1D2FureDwOIhCSWWBpqGJ1iljvmfFLgmqHZaCurXNgzLy5KlmpgnXr7wh8UR8Lg+Fis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786307351; c=relaxed/simple;
	bh=e7IVkymbIpH+Sa1WHsWTqsuCYzgVYNscw67zX24MH/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyYZkR4dPvC0MkuKnqJmvJ57iEF871hki5XaJdiLqbo9Y/8SC4bgh5oNwRJZR8l8+Z8u+rytmuci7Bj6Ze2q0SovuxAilOEl2bFqvPCQyf+emag2her9l8L0id1jEthchnp5imGuui+DXCLuvTUtCXjb/G/CeqaU/mU8/xwtSMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMriMKbV; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMriMKbV"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-44cedfaab6bso292549fac.3
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786307345; x=1786912145; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bWLjA8G7rk/7KcbJhEyGGcd17Ru6SvxjZkT6BTMdTnk=;
        b=UMriMKbVGUZdz5MnislYJ8i8Du4cgXosoMGdERLiNUW96IWik01eUmiAAWi1sAiH+2
         92SYz2lWseKQXKTUznOQnUQXYl2LYysXsOA9ptXT4cG2V3xxVtqGC71qzD636P26Wn7J
         Q1czfkp5bgEcxGVj/EQN14wBUqD/vUKLAT4vBUh4dU3P8y8VJdl+URdPywBmE53qOFKA
         BY9kwS5EOBGjwxoQS4sMK4gIGBbJS/R+iiUPYOuFRfrQz3iu8WyFHk9mjUrY7pf0IxkQ
         XG3bvcnrzvSWDSMcLe9EJvhqXp6N8aG0hWM+KW28DFhREbLThXEnpDjJBuKvkk/j3FZs
         7UBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786307345; x=1786912145;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bWLjA8G7rk/7KcbJhEyGGcd17Ru6SvxjZkT6BTMdTnk=;
        b=rrcQaGX8W6hdD5+6nsPOs2gGBV4cBZqPU3lXLBHCI7hhMFzRT5LBn4PC6n2mX0woyy
         TFgmJGy1JKUyjZE1mmPPE/8Vf/Fo2Pz3UFuyUElFePlsqTYDOhjb0bwrEjOpz9nOJcRm
         CE6lXg4PM8ZcFtTEMIrUbjbeiwH3y+f/u5F02QZtKpb196ce++2hQGfAPYVzY3mI+DLO
         19XyTVLbVeCVqw9j/8XrVC4PDJq2r1K5HaAmtholwABE6A7g46zWDoL/tAx/lf0NBN5S
         LY1E6ytV5a6h0oUDjKpBAbqJas6iggVv/LiY5lo70AAnt+Y2AXxMoBInqb5NRQOHnL3X
         SbfQ==
X-Forwarded-Encrypted: i=1; AHgh+RpXIj2J8p6y+VJ5sU4PvymlWhlOrAXF7ukj6CktUr1vWC5uHH7bhzZua7usNqJO4U/oB0AzpJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AXRfkPDDgEdI7a6cDF6F9aLC4NX4Xz2LJ0hLCBFXNIFLgLpC
	DaeLB28nYnvwJ4mZJviBrR2bGA8ORsf4FYB9yXq+ucRwSylTb8rL5ndO
X-Gm-Gg: AR+sD12rplyoykGBWzAUH4SGKzf+9bRo50f272juyE0v42JhriLWB2WnxZBD4ENReE9
	qwysGk9DOGYvCM5EOBQbGRLJyIpQCY4J7Wzi7d9a/ptE1Jit280LEsUHGs48vJufiBo4b5nPDKO
	ccl17tN+UNliuyGMkA0k1z67ZArAziOjPjjsYb10DGWZzVpSzpvc3BEoB+Y2ORfzZlBKsHZgbOZ
	0t/UBmelNwUFsurdi4WfV369VunvLJe2LewIqgQxj8NMslJQKfX2OtjOzBgoB/YPHXn2phZ/tBD
	pCaqIPW20B/JvkE29htMArisVyC2NYmzJ8A5wg3jXgrdiXzybNrjgj6alh/QxYux8pq1jAEljDW
	kcAs35xG6bgk45TcLwEHBtqK4RflN7ub2CbTaf4tEeeQJHkPS2yeMuNxifK5sx3aZq+k51DoX5Y
	cubp/dVNtaeFVTyJS3OsdSHDNgKpmaVZgFnUb/e7PfsMH+1cPCmrc//cqBuOZnm7lq31QJ556QQ
	FWHoD/3RNGjy+6HiY4mMLB7WeKxLhfdCP69lhGrUZINVKwdbz4QRv/TwSprwkapz/YdzdHyDKoZ
	JGgD/czXmXng156WOxlft1dd1j9Ilfo0AznJ3Bxks3O8BUgwOtgvOW0vwY69R3MkcfHhO6Rp0K3
	K6I4mLkVMR4jzh35MEYCo3GHgLgE=
X-Received: by 2002:a05:6870:a40c:b0:456:3973:5a89 with SMTP id 586e51a60fabf-4599eda5c51mr18998830fac.8.1786307344630;
        Sun, 09 Aug 2026 13:29:04 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f19fd31csm6975362fac.1.2026.08.09.13.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 13:29:04 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 09 Aug 2026 14:28:33 -0600
Subject: [PATCH net-next v5 3/5] mfd: ac200: Add X-Powers AC200 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-submit-acx00-of-dynamic-v1-v5-3-bfa1f8518b28@gmail.com>
References: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
In-Reply-To: <20260809-submit-acx00-of-dynamic-v1-v5-0-bfa1f8518b28@gmail.com>
To: Lee Jones <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mfd@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2

The X-Powers AC200 is a mixed-signal companion IC with a paged register
map accessed over I2C.

Enable the shared input clock and prevent its rate from changing. Match
the vendor driver's 40 ms wait before the first register access,
initialize the paged regmap, report the chip and package revision, and
apply common reset.

The Ethernet PHY link endpoint is independently enumerated on its MDIO
bus, so publish the regmap through managed syscon registration for lookup
through its AC200 firmware reference rather than creating an artificial
MFD platform child. The managed entry is withdrawn before the regmap is
released, while the function driver separately manages the PHY analog
supply.

Cache only the common page selector. Individual functions can reset
independently and invalidate their other registers without regmap's
knowledge, so leave all functional registers volatile.

Reset the chip during managed teardown and system shutdown. Consumers
can use device links to ensure that they unbind before the shared AC200
resources are released.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mfd/Kconfig  |  12 ++++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/ac200.c  | 170 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 763ce6a34782..95e3c62742bb 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -205,6 +205,18 @@ config MFD_AC100
 	  This driver include only the core APIs. You have to select individual
 	  components like codecs or RTC under the corresponding menus.
 
+config MFD_AC200
+	tristate "X-Powers AC200"
+	depends on I2C
+	depends on OF
+	select MFD_SYSCON
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
index 000000000000..25066bb36ac7
--- /dev/null
+++ b/drivers/mfd/ac200.c
@@ -0,0 +1,170 @@
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
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
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
+static void ac200_disable(void *data)
+{
+	struct ac200 *ddata = data;
+
+	regmap_write(ddata->regmap, AC200_SYS_CONTROL_REG, 0);
+}
+
+static int ac200_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	unsigned int version;
+	struct ac200 *ddata;
+	struct clk *clk;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
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
+	ddata->regmap = devm_regmap_init_i2c(client, &ac200_regmap_config);
+	if (IS_ERR(ddata->regmap))
+		return dev_err_probe(dev, PTR_ERR(ddata->regmap),
+				     "failed to initialize regmap\n");
+
+	i2c_set_clientdata(client, ddata);
+
+	/*
+	 * No minimum delay is documented. Match the vendor driver's 40 ms delay
+	 * before its first AC200 register access after enabling the input clock.
+	 */
+	msleep(40);
+
+	ret = regmap_read(ddata->regmap, AC200_SYS_VERSION_REG, &version);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read chip version\n");
+
+	dev_info(dev, "AC200 revision %#lx in package %lu\n",
+		 FIELD_GET(AC200_SYS_VERSION_CHIP_MASK, version),
+		 FIELD_GET(AC200_SYS_VERSION_PACKAGE_MASK, version));
+
+	/* Reset the chip after dependent function drivers have unbound. */
+	ret = devm_add_action_or_reset(dev, ac200_disable, ddata);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ddata->regmap, AC200_SYS_CONTROL_REG, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ddata->regmap, AC200_SYS_CONTROL_REG,
+			   AC200_SYS_CONTROL_CHIP_RESET_DEASSERT);
+	if (ret)
+		return ret;
+
+	ret = devm_of_syscon_register_regmap(dev, dev->of_node,
+					     ddata->regmap);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register regmap\n");
+
+	return 0;
+}
+
+static void ac200_shutdown(struct i2c_client *client)
+{
+	ac200_disable(i2c_get_clientdata(client));
+}
+
+static const struct of_device_id ac200_of_match[] = {
+	{ .compatible = "x-powers,ac200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ac200_of_match);
+
+static const struct i2c_device_id ac200_i2c_ids[] = {
+	{ .name = "ac200" },
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

