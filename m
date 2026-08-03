Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472D7399CF5
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734144; cv=none; b=HOMgyQIRzJBy8Ofo2xf3+i3WSnvM3J/KS6RzzcCn89Db9ddvcKnzeEYxyel+JI40yBXo5SfkjQYd2GYkS9ZIWb4XCh81fa3KPRvZx1bXE0VjSjXFSIHCm4HDatkWVunAAdB0jg2Ut1YygTW1iiGnXw1u3LQ+N7m8/jm2P98RHNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734144; c=relaxed/simple;
	bh=MqlazHFPg7A93Yw8yIBqrOlNXVcT4LqcT4gU0kTc88M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJmWKiTCk/JWcLiM1Eqv1IQgDrSZk/hMWsNlZ1j1HO5rvI6uN4xbbd1QisEykRc8Ml3yFeH9zspAgXjpZdapmVcOM1r3r5DbNF8pMwu5R8wIuxGg2i+kHBScQ7dWL1S8ms1Ls1qJQBW+LvYpTF6pBQ3jUh+N2AgsyNrcsPRYxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZWEOw6i; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZWEOw6i"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7ee4399c423so1835958a34.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734139; x=1786338939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o3n69SozBgBa42qBZUQe+SN94PjOayvFQRwUM8nAj08=;
        b=lZWEOw6idthX6KR2cpceFPr1UDPF2qWwDtasz01aUOWbDAifta62+FRn/atwpOND9V
         NaF2XhqbdUVozP/7a0n86yuQ6HrGXgRzrn1W79rZdketF5gd0A3GuuV7fPa0w4LDHznH
         h9ou0rupz3GuVXT6bwTbuKx86qco7Uhy/taT/F7AZdG8tw1Mh+okgHKHaRzt5GSjDy+j
         32z5Bf3IyE8T6hfXumfBxbJ8PzrLK+knfsSiDYS+uoleMfEs34FFqd8NN5Y3y+Im118m
         7f0xR9z5uEAgBpceCPYvONIYQ77g+KTleQBX+s1e3SaZF2ytZbbbKbAT+dKr8OMbUhXY
         85fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734139; x=1786338939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o3n69SozBgBa42qBZUQe+SN94PjOayvFQRwUM8nAj08=;
        b=MnVxKwfG4TWtGTIMEwqgeNqW5wARVnSmoeQXZmba+tqZg3xVavusZTMiGmPV19N2qL
         mtZZzxku8P9NTOp+odijYpHYQAZ5KVsCYuAtfLvfbPadsMJbKyboZnGMSyFJfYskizYr
         KzWcQz6ne9QYBsMmRNrHYv/N6veluxx9QFNMXlyR+9QzZShuodBGXkGyfkcPuFvxs1J4
         cbUY1ZLaTd/VmfF6mtAwybsIOQoKLUrPqIV54D0vey0AB8ttLnG3HFEu28OE3C7evEvL
         ldC1EMHspHI+1c+HO9AKO3w4H+9t0W1n/KZZBj31FaMlmqLJQVFOM6oTbeSE72Q1UzN9
         t1kg==
X-Gm-Message-State: AOJu0YxjVDg3Rm2EjpektcH900P5Znoh9PHnKq0cS/mMnZmBlg1qGSS6
	yVPZg2UE+MPtShT4IAoJ99H+1CY2Tad5f245q2NFB7QROutN8XhbzqFr
X-Gm-Gg: AR+sD1035CATbFTBPVWybTjCEaLtzW8P6uqt0eOyLfASl9WIKubvgk0j0OTiMnJIbzI
	T4HT6uBCAf3PIfIChkzbhPVP6HVSYypd3b+PGn7TXN4DwyfjaqavMr2ichiEzbeLJI55z/z94D5
	Pj0521qA85f/pglzwc12IjWv7HQDT87S58Atc41QPn30sJ8e+dHa4XSwYq9fBroznphWfUkyFSJ
	ZV3n3TTc26nTVWejsn1+buyUTu4OK3UsV32ZnhBr6oui2plm5WClw3w5/zaIkqsNPcAfnCDIb6a
	mrqiKtQ7+eVeV6AGrUsH/KjXG8v/5OCD0IcD6a0qra1kvaRM5qrMS5GK5aU/LLzinnjyrVdzZZE
	jRNZmYhY1a3PEhpObwOMVuVMvYbNXxEqebvJWV3PyfoDsPeKpIV4ksyzDgixPpG+L6JTMCUaJh9
	/1zlB114mmyhW2Y9r3wdW8AfD+b7baRKqd3aUmutlWO8sQKgSByOWnOlryhQmzL1NTx06hzfnzt
	YxSj55QHyVdeHsfN55NuN5MHJtTZ1S7cmMnpQCkO+DpNQNQdfjKhrKAAwxtpwU7bg2SN5V3Z4VH
	uX8agyTZtMf0OyvFerFxwwgY66FJCPOiY7Kpfi0xtcd9lw/QECIo80rUNVptXTlmi1jsGmTlj0f
	MON5xUmiNf79dUKD0
X-Received: by 2002:a05:6830:7003:b0:7e9:e288:2b60 with SMTP id 46e09a7af769-7f196b465fcmr14384631a34.1.1785734134150;
        Sun, 02 Aug 2026 22:15:34 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:19 -0600
Subject: [PATCH 09/21] mfd: add X-Powers AC200 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-9-0a53cd9e21cc@gmail.com>
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

The X-Powers AC200 is a mixed-signal companion IC with a paged register
map accessed over I2C. Enable its required supplies and board-configured
input clock, lock the clock rate, and wait for the settling interval used
by the vendor initialization sequence before accessing the device.

Initialize the common control interface, report the chip and package
revision, and populate the Ethernet PHY control child when firmware
describes it. Cache only the common page selector because individual
function resets can invalidate functional registers without regmap's
knowledge.

Optionally apply the SoC SID bandgap calibration using the opaque fixed
bits from the vendor sequence. The public manual marks that register as
reserved. Boards which do not use the affected TV encoder path may omit
the calibration cell.

When firmware describes INTB, register a regmap IRQ domain for the TV
encoder, Ethernet PHY and RTC sources. Program the shared output enable
and requested level polarity while preserving the independently managed
source enables. Systems without a routed interrupt remain unchanged.

The AC200 and its children cannot initiate DMA. Mark the parent as
DMA-incapable before adding the MFD cells so OF DMA setup does not
synthesize a mask for the child.

Register a managed action that disables the AC200 control block before
adding the MFD children. Managed resources unwind in reverse order, so
the children are removed before their parent control block is disabled
on driver removal or a later probe failure. Disable the block during
system shutdown as well.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mfd/Kconfig  |  13 +++
 drivers/mfd/Makefile |   1 +
 drivers/mfd/ac200.c  | 302 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 316 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 763ce6a34782..a71870bcf868 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -205,6 +205,19 @@ config MFD_AC100
 	  This driver include only the core APIs. You have to select individual
 	  components like codecs or RTC under the corresponding menus.
 
+config MFD_AC200
+	tristate "X-Powers AC200"
+	depends on I2C
+	depends on OF
+	select MFD_CORE
+	select REGMAP_I2C
+	select REGMAP_IRQ
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
index 000000000000..bd9930a02cb2
--- /dev/null
+++ b/drivers/mfd/ac200.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MFD core driver for the X-Powers AC200
+ *
+ * Copyright (C) 2026 James Hilliard <james.hilliard1@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include <dt-bindings/mfd/x-powers,ac200.h>
+
+#define AC200_SYS_VERSION_REG			0x0000
+#define AC200_SYS_VERSION_PACKAGE_MASK		GENMASK(15, 14)
+#define AC200_SYS_VERSION_CHIP_MASK		GENMASK(11, 0)
+
+#define AC200_SYS_CONTROL_REG			0x0002
+#define AC200_SYS_CONTROL_CHIP_RESET_DEASSERT	BIT(0)
+
+#define AC200_SYS_IRQ_ENABLE_REG			0x0004
+#define AC200_SYS_IRQ_INTB_ENABLE		BIT(15)
+#define AC200_SYS_IRQ_INTB_ACTIVE_HIGH		BIT(14)
+#define AC200_SYS_IRQ_RTC_ENABLE			BIT(12)
+#define AC200_SYS_IRQ_EPHY_ENABLE		BIT(8)
+#define AC200_SYS_IRQ_TVE_ENABLE			BIT(4)
+
+#define AC200_SYS_IRQ_STATUS_REG			0x0006
+
+#define AC200_SYS_BG_CTL_REG			0x0050
+/*
+ * The vendor initialization sequence composes this as SID data | BIT(15) |
+ * (0xa << 6). The public datasheet marks the whole register reserved and
+ * does not name the fixed fields.
+ */
+#define AC200_SYS_BG_CTL_FIXED_BITS		(BIT(15) | (0xa << 6))
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
+static const struct regmap_irq ac200_irqs[] = {
+	REGMAP_IRQ_REG(AC200_IRQ_TVE, 0, AC200_SYS_IRQ_TVE_ENABLE),
+	REGMAP_IRQ_REG(AC200_IRQ_EPHY, 0, AC200_SYS_IRQ_EPHY_ENABLE),
+	REGMAP_IRQ_REG(AC200_IRQ_RTC, 0, AC200_SYS_IRQ_RTC_ENABLE),
+};
+
+/*
+ * SYS_IRQ_ENABLE is an enable register rather than a mask register, hence
+ * unmask_base. The INTB output enable and polarity bits share the register,
+ * but regmap-irq only updates the bits described by ac200_irqs.
+ *
+ * SYS_IRQ_STATUS follows the state of each source block and is read-only.
+ * Interrupts must therefore be acknowledged in the source block itself.
+ */
+static const struct regmap_irq_chip ac200_irq_chip = {
+	.name = "ac200",
+	.status_base = AC200_SYS_IRQ_STATUS_REG,
+	.unmask_base = AC200_SYS_IRQ_ENABLE_REG,
+	.num_regs = 1,
+	.irqs = ac200_irqs,
+	.num_irqs = ARRAY_SIZE(ac200_irqs),
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
+static int ac200_init_irq(struct ac200 *ac200, int irq)
+{
+	struct device *dev = regmap_get_device(ac200->regmap);
+	struct regmap_irq_chip_data *irq_data;
+	u16 value = AC200_SYS_IRQ_INTB_ENABLE;
+	u32 trigger;
+	int ret;
+
+	trigger = irq_get_trigger_type(irq);
+	switch (trigger) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		value |= AC200_SYS_IRQ_INTB_ACTIVE_HIGH;
+		break;
+	case IRQ_TYPE_NONE:
+	case IRQ_TYPE_LEVEL_LOW:
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "INTB requires a level interrupt, not type %u\n",
+				     trigger);
+	}
+
+	ret = regmap_update_bits(ac200->regmap, AC200_SYS_IRQ_ENABLE_REG,
+				 AC200_SYS_IRQ_INTB_ENABLE |
+				 AC200_SYS_IRQ_INTB_ACTIVE_HIGH, value);
+	if (ret)
+		return ret;
+
+	ret = devm_regmap_add_irq_chip(dev, ac200->regmap, irq, IRQF_ONESHOT,
+				       0, &ac200_irq_chip, &irq_data);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add interrupt controller\n");
+
+	return 0;
+}
+
+static int ac200_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct device_node *ephy_node __free(device_node) = NULL;
+	struct ac200 *ac200;
+	struct clk *clk;
+	unsigned int version;
+	u16 bandgap_calibration = 0;
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
+	if (device_property_present(dev, "nvmem-cells")) {
+		ret = nvmem_cell_read_u16(dev, "bandgap",
+					  &bandgap_calibration);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read bandgap data\n");
+	}
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
+	if (bandgap_calibration) {
+		ret = regmap_write(ac200->regmap, AC200_SYS_BG_CTL_REG,
+				   AC200_SYS_BG_CTL_FIXED_BITS |
+				   bandgap_calibration);
+		if (ret)
+			return ret;
+	}
+
+	if (client->irq > 0) {
+		ret = ac200_init_irq(ac200, client->irq);
+		if (ret)
+			return ret;
+	}
+
+	/* Neither the AC200 nor its child devices can perform DMA. */
+	dev->coherent_dma_mask = 0;
+	dev->dma_mask = &dev->coherent_dma_mask;
+	ephy_node = of_get_compatible_child(dev->of_node,
+					    "x-powers,ac200-ephy-ctl");
+	if (!ephy_node)
+		return 0;
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, ac200_cells,
+				    ARRAY_SIZE(ac200_cells), NULL, 0, NULL);
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

