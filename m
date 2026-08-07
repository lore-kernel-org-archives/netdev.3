Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE53DA5B4
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 04:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786078328; cv=none; b=QPqanZgxWtgQ/fSk2yt1S1WPKl2UWkNMUWOd4t7ZTrCngmMK3I0HPAjXj02OASH/NddicGBO1kPuyOEgqu1mBSmpvQx69T+xfITe4AqbfmJtHWLRJD4nvbzXzrhj/kbiefuEucW1r8j2JUI7MScv7QhV8FIWV09U2eyBPBuep1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786078328; c=relaxed/simple;
	bh=TlpInWm9XOJkb5udZMBPKZH2dMguh+THVGbaxQuYsbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhWHbYHf94QRszLkL98WJLvUkFH0JdZaqdzeRjR4Z6fZ8oS/ZfsH1VQvRZANqMMqSaDo10Vlis/27zY4kpM2XU9R6Dbzc3i6J8yr92k7/uBT7Mhox5sPXUhKfursYzHu3tzIK3q12US1XYV9qeVKfff+0VG041wKslLlose2K1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrtD1kIp; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrtD1kIp"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-448cf99c133so1820612fac.1
        for <netdev@vger.kernel.org>; Thu, 06 Aug 2026 21:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786078300; x=1786683100; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DINgOwIeeRrbClV4fqYU1hiU8YusN/1zP2aX4+OhDw0=;
        b=XrtD1kIpWlh+oEVOUecHJv1DhDhVa6AenIItcIiubZxTGM0WOWIXK3U6RYssVTFrVA
         nMUZ5l9Ycya4Xbq9+Do/LAIVGQGljiSpe8cb2srZyEpQsFpCVCOLnVOd+CXP0A8zZyeL
         F3VGH/J5MuEryKVhdTSzIDt59VL8/z/pwWmtFa60kNSa2GO7ybZKNkeSs3SUO5KpvAOZ
         f7bZRbKYsowWVodkmnbU1Qf57xemDkLUP7FqOagBQTzTiRNJW08BIbTTPStGX6n30mY5
         /UirE/jDdkpkBqfb+XCk1HJ+QqAS0kwPZKoSHveG0SZWNIlEc7XZhws80DiSMkDjPBj/
         gX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786078300; x=1786683100;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DINgOwIeeRrbClV4fqYU1hiU8YusN/1zP2aX4+OhDw0=;
        b=kkKZwQUyDS2v12L7IaxDhgFValPrmWOuGIMXsdMFYms8Dv4xj+7BJ31nYweDGd14qM
         AimU2HjYLJunIHt6mn/3SenVrevtegVy9pzne5AMeqIyhfuM9pPIvrpJzMaZa0iDIdDN
         ShNw1DFq8hW1VQBpyL+/gcD5GNcq2CallMO4bKHhL8z0tYPqoPwFaKGwHixFm37/Tp+x
         EZvQm5ZxhlVwH3j+B32yKQkgBZzyXFi6VBAkbKl18zBt1TyXJA0KN4AUjhRsm0nrl2am
         KNh8oi1SgBbNf4Ax7lZkfovbvBXSat32FcfQxctLcvFsT4t/79ufSfjdHvF/rcyMorPZ
         WqGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrmWVXyiYKRIRF61rNd3g3udKOZUrhlZv3UWI+9CVlFknW9vrS699ahzB16YkYRocNkwBRjtfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiOfpXCLo5id/KHG9+5nZ+cacgeUTzbNb/CBXct43NfIjW/x22
	2YGFv22jGTMOIX58nGGkaPW0//72saf0HR7ZzAAytQyyike0Xjr+hbvW
X-Gm-Gg: AR+sD10A39YPZUY+rdBEpHIhg1U4Algexjp8Xofxow1tDOSR0Kb2A9nIGLG3whTArje
	64Mgm7kWl10Nq1J6MsOrm5Huf274RgJ1LPMb3QG4gce58E0cho0hMpxX/KvxMHQ49h1XbNukiZz
	4E0o1SQ1DtRI0gul8aTiI0pqxrErsKndVVPeAnwj2AoiefV0mZWghKGVNHleJ9FGC0mglsUYZHp
	dUxUQYdTIPunn5prw4kFp+jbHqOLEjyqOIu3MbVfML9ST9RpmPfYxZswGL+KpOpQl+DrIFKGMvX
	HYwgZlj9Zy7bmLM9u5mDq8kcHFn6SD9J/s+ppEAFnjSlOIOmI8wdO3uDev8nTa821vOjdfB66G0
	aBld87A6JiXm5ErW3umixxJF9Vv1+hUsuYDxP/IBV/IdHDPNPnPsuNpiB8uOKqoY0n4e16zbwUG
	8XPNUloMfPHY1Q5B4fWx3+x2NIcgEDHxSDO/HjGJoN8Rek29A7WJGbpcW1PekwP3y4toR0DBZ2R
	WeW65yJoVpeC/l719QQktUC9pllBuaMOKsEBSt0Nq1o3af+iwdf2Inj+dSeuzyNOzohvB3gWf1l
	Nc/Xvbqu8tSnaPxzmcQaXRgPAxTDDf9Hn5gyL4eTz9dEEzQQc7+IDUALF/uyaDJUFSfHd5iGQFo
	o/PvVodwbvaEQ1Ydd
X-Received: by 2002:a05:6820:1693:b0:6a1:64df:7324 with SMTP id 006d021491bc7-6b016c97a1bmr4693925eaf.7.1786078299863;
        Thu, 06 Aug 2026 21:51:39 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b02bbbf755sm1519726eaf.2.2026.08.06.21.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 21:51:39 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 06 Aug 2026 22:51:27 -0600
Subject: [PATCH net-next v4 2/4] mfd: ac200: Add X-Powers AC200 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-submit-acx00-of-dynamic-v1-v4-2-9bf2f7441632@gmail.com>
References: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
In-Reply-To: <20260806-submit-acx00-of-dynamic-v1-v4-0-9bf2f7441632@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

Enable the package supplies and input clock and prevent the clock rate
from changing. Match the vendor driver's 40 ms wait before the first
register access, initialize the paged regmap, report the chip and package
revision, and apply common reset. The regmap is available to function
drivers which reference the AC200, including the Ethernet PHY package
driver.

Cache only the common page selector. Individual functions can reset
independently and invalidate their other registers without regmap's
knowledge, so leave all functional registers volatile.

Reset the chip during managed teardown and system shutdown. Consumers
can use device links to ensure that they unbind before the shared AC200
resources are released.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mfd/Kconfig  |  11 ++++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/ac200.c  | 176 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 763ce6a34782..499269c85812 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -205,6 +205,17 @@ config MFD_AC100
 	  This driver include only the core APIs. You have to select individual
 	  components like codecs or RTC under the corresponding menus.
 
+config MFD_AC200
+	tristate "X-Powers AC200"
+	depends on I2C
+	depends on OF
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
index 000000000000..798bb4173b14
--- /dev/null
+++ b/drivers/mfd/ac200.c
@@ -0,0 +1,176 @@
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
+#include <linux/module.h>
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

