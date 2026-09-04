Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB4050AC2D;
	Fri,  4 Sep 2026 16:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540475; cv=pass; b=JSMgUR8zsiZeXPDfITqcSWWE9jORQ67zPD/w4LUkn3Q1ATo1fxyRRgkLfWc3tVKuF/SGQq4GUYVFovZfwTseTjCduBNHhvEWfAvv1/HeLmobP3w5nVZkqvM+wV6Nfi+d+AArdRbKjOwter7+DbQA2yrS6PGMzKP88Kp3OLBSi9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540475; c=relaxed/simple;
	bh=lNfKeLHVaTiCr2yw6E6OpzcrcZtQ2FEMWt2f/J+Zb5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkqLtbyx0U2vpEGU9Rfvk4NQDIJ/sEPhREOfH6YfAoNKfJUjTBVybkgbADr3jyt44qZspyoK99cuiS4JaUotoYJg5SIJZ+nHxnblYxX/3kxr/7Xbiz+jqj82M56UHxIHH41z5OFHsn1fzxf+fv6qZ4ofeDSTepVS3cD8z79Suw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=epS8dnog; arc=pass smtp.client-ip=165.173.180.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="epS8dnog"
ARC-Seal: i=1; a=rsa-sha256; t=1788540444; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=d2ndTNliP8IKD2sQH1iwuLo1Gh5OiDuluRiY0KQxnGozH8hzJ9JrN9vZXrUGfE9eG2N9ccxlZH1lqkzgaZ6rtiDUy3cfcjlvhZAL/ZYYek6PzHI0y1cP6JA4WoUjkcrwZuw3TGpsGiEt/JXxKK0Ql0ppUq25UyF5ypNwAmeaaNU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1788540444; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=43urlMOjrVzd7D3WvKMHhQ2bo87DbBPWtjoI5NUqH5k=; 
	b=JqLMXMLpN6WwpkGjX7/u2kEHdx30MYXsbKm/inER+qU5I5NNmLtQjkVGd3hFOPRZQML7A0GLnWpFa1q6cqiQF550833ccg5uiePrcJqhJ1QMpfhIt0JL27mZRDmLhwluIbPrBOAURF9CDQxbCyqi6Gk003eZdXVCFlfr8MzzaQM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1788540444;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=43urlMOjrVzd7D3WvKMHhQ2bo87DbBPWtjoI5NUqH5k=;
	b=epS8dnogRgCF0dI+sInwkz4dC6hr+n2zIDxQRDaiLWKsMTJBG+QVemW4g8CPVjPo
	l7xdZ4dRfTFwl2l8gi+bw/VsApYMUXISos9JNLhuZom2w+Mr9naZMJj8P9VwdkkWqDP
	VEGlLVLHUOfB6ObZlOrJEkk/V0ohbnNepUxISzhI=
Received: by mx.zohomail.com with SMTPS id 178854044243025.31273123153403;
	Fri, 4 Sep 2026 09:47:22 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Sat, 05 Sep 2026 00:45:32 +0800
Subject: [PATCH v3 3/8] clk: sunxi-ng: a733: Add PRCM CCU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-a733-clk-v3-3-50f238f39c78@pigmoral.tech>
References: <20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech>
In-Reply-To: <20260905-a733-clk-v3-0-50f238f39c78@pigmoral.tech>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 netdev@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Enzo Adriano <enzo.adriano.code@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12273;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=lNfKeLHVaTiCr2yw6E6OpzcrcZtQ2FEMWt2f/J+Zb5I=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJmfT3JLtl48czMR5LGAS0ro9Wja5WWumzLvNkpdcHMT
 tzDpW5SRykLgxgXg6yYIguXv/g/ax2eb0cEWu/DzGFlAhnCwMUpABPxv8nIMH3lao7KR2KTF5lF
 GiXdSOPuPvw1WNzux3vLhNVVc1h1ihj+Wek4Hre25Jnzq+Oo2KyKrUze78osw/1X98923e32tbi
 DFwA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add support for the Power Reset Clock Management (PRCM) module found in
the Allwinner A733 SoC. This clock controller manages the clock control
and reset functions for device modules within the CPUS domain.

The PRCM module includes the management of three primary buses: r-ahb,
r-apb0, and r-apb1. It also provides clocking for several key
peripherals, such as R-UART, R-I2C, R-SPI, and the R-RISCV subsystem.
Additionally, the reset lines for these modules are integrated.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Enzo Adriano <enzo.adriano.code@gmail.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/Kconfig             |   5 +
 drivers/clk/sunxi-ng/Makefile            |   2 +
 drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c | 273 +++++++++++++++++++++++++++++++
 3 files changed, 280 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 6af2d020e03e..202e793dc754 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -67,6 +67,11 @@ config SUN55I_A523_R_CCU
 	default ARCH_SUNXI
 	depends on ARM64 || COMPILE_TEST
 
+config SUN60I_A733_R_CCU
+	tristate "Support for the Allwinner A733 PRCM CCU"
+	default ARCH_SUNXI
+	depends on ARM64 || COMPILE_TEST
+
 config SUN4I_A10_CCU
 	tristate "Support for the Allwinner A10/A20 CCU"
 	default ARCH_SUNXI
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index a1c4087d7241..d3702bdb7a23 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
 obj-$(CONFIG_SUN55I_A523_CCU)	+= sun55i-a523-ccu.o
 obj-$(CONFIG_SUN55I_A523_MCU_CCU)	+= sun55i-a523-mcu-ccu.o
 obj-$(CONFIG_SUN55I_A523_R_CCU)	+= sun55i-a523-r-ccu.o
+obj-$(CONFIG_SUN60I_A733_R_CCU)	+= sun60i-a733-r-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
 obj-$(CONFIG_SUN6I_A31_CCU)	+= sun6i-a31-ccu.o
@@ -64,6 +65,7 @@ sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
 sun55i-a523-ccu-y		+= ccu-sun55i-a523.o
 sun55i-a523-mcu-ccu-y		+= ccu-sun55i-a523-mcu.o
 sun55i-a523-r-ccu-y		+= ccu-sun55i-a523-r.o
+sun60i-a733-r-ccu-y		+= ccu-sun60i-a733-r.o
 sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
 sun5i-ccu-y			+= ccu-sun5i.o
 sun6i-a31-ccu-y			+= ccu-sun6i-a31.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c
new file mode 100644
index 000000000000..f320b52526ea
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 rengaomin@allwinnertech.com
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Based on the A523 CCU driver:
+ *   Copyright (C) 2024 Arm Ltd.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h>
+#include <dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h>
+
+#include "ccu_common.h"
+#include "ccu_reset.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mp.h"
+
+static const struct clk_parent_data r_ahb_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "pll-periph0-200m" },
+	{ .fw_name = "pll-periph0-300m" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX(r_ahb_clk, "r-ahb", r_ahb_parents, 0x000,
+				 0, 5,	/* M */
+				 24, 3,	/* mux */
+				 0);
+
+static const struct clk_parent_data r_apb_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "pll-periph0-200m" },
+	{ .fw_name = "sys-24m" },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX(r_apb0_clk, "r-apb0", r_apb_parents, 0x00c,
+				 0, 5,	/* M */
+				 24, 3,	/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(r_apb1_clk, "r-apb1", r_apb_parents, 0x010,
+				 0, 5,	/* M */
+				 24, 3,	/* mux */
+				 0);
+
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer0, "r-timer0", r_apb_parents, 0x100,
+				      1, 3,	/* P */
+				      4, 3,	/* mux */
+				      BIT(0),	/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer1, "r-timer1", r_apb_parents, 0x104,
+				      1, 3,	/* P */
+				      4, 3,	/* mux */
+				      BIT(0),	/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer2, "r-timer2", r_apb_parents, 0x108,
+				      1, 3,	/* P */
+				      4, 3,	/* mux */
+				      BIT(0),	/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(r_cpu_timer3, "r-timer3", r_apb_parents, 0x10c,
+				      1, 3,	/* P */
+				      4, 3,	/* mux */
+				      BIT(0),	/* gate */
+				      0);
+
+static SUNXI_CCU_GATE_HW(bus_r_timer_clk, "bus-r-timer", &r_ahb_clk.common.hw, 0x11c, BIT(0), 0);
+static SUNXI_CCU_GATE_HW(bus_r_twd_clk, "bus-r-twd", &r_apb0_clk.common.hw, 0x12c, BIT(0), 0);
+
+static const struct clk_parent_data r_pwm_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "sys-24m" },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(r_pwm_clk, "r-pwm", r_pwm_parents, 0x130,
+				    24, 2,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_GATE_HW(bus_r_pwm_clk, "bus-r-pwm",
+			 &r_apb0_clk.common.hw, 0x13c, BIT(0), 0);
+
+static const struct clk_parent_data r_spi_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "pll-periph0-200m" },
+	{ .fw_name = "pll-periph0-300m" },
+	{ .fw_name = "pll-periph1-300m" },
+	{ .fw_name = "sys-24m" },
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(r_spi_clk, "r-spi", r_spi_parents, 0x150,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_GATE_HW(bus_r_spi_clk, "bus-r-spi", &r_ahb_clk.common.hw, 0x15c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_msgbox_clk, "bus-r-msgbox", &r_ahb_clk.common.hw, 0x17c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_uart0_clk, "bus-r-uart0", &r_apb1_clk.common.hw, 0x18c, BIT(0), 0);
+static SUNXI_CCU_GATE_HW(bus_r_uart1_clk, "bus-r-uart1", &r_apb1_clk.common.hw, 0x18c, BIT(1), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_i2c0_clk, "bus-r-i2c0", &r_apb1_clk.common.hw, 0x19c, BIT(0), 0);
+static SUNXI_CCU_GATE_HW(bus_r_i2c1_clk, "bus-r-i2c1", &r_apb1_clk.common.hw, 0x19c, BIT(1), 0);
+static SUNXI_CCU_GATE_HW(bus_r_i2c2_clk, "bus-r-i2c2", &r_apb1_clk.common.hw, 0x19c, BIT(2), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_ppu_clk, "bus-r-ppu", &r_apb0_clk.common.hw, 0x1ac, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_tzma_clk, "bus-r-tzma", &r_apb0_clk.common.hw, 0x1b0, BIT(0), 0);
+static SUNXI_CCU_GATE_HW(bus_r_cpu_bist_clk, "bus-r-cpu-bist", &r_apb0_clk.common.hw,
+			 0x1bc, BIT(0), 0);
+
+static const struct clk_parent_data r_ir_rx_parents[] = {
+	{ .fw_name = "losc" },
+	{ .fw_name = "hosc" },
+	{ .fw_name = "sys-24m" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(r_ir_rx_clk, "r-ir-rx", r_ir_rx_parents, 0x1c0,
+				      0, 5,	/* M */
+				      24, 2,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+static SUNXI_CCU_GATE_HW(bus_r_ir_rx_clk, "bus-r-ir-rx", &r_apb0_clk.common.hw, 0x1cc, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_rtc_clk, "bus-r-rtc", &r_ahb_clk.common.hw, 0x20c, BIT(0), 0);
+
+static const struct clk_parent_data r_riscv_parents[] = {
+	{ .fw_name = "hosc" },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(r_riscv_clk, "r-riscv", r_riscv_parents, 0x210,
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_GATE_HW(bus_r_riscv_clk, "bus-r-riscv", &r_apb0_clk.common.hw,
+			 0x21c, BIT(0), 0);
+static SUNXI_CCU_GATE_HW(bus_r_riscv_cfg_clk, "bus-r-riscv-cfg", &r_apb0_clk.common.hw,
+			 0x21c, BIT(1), 0);
+
+static SUNXI_CCU_GATE_HW(bus_r_cpucfg_clk, "bus-r-cpucfg", &r_apb0_clk.common.hw,
+			 0x22c, BIT(0), CLK_IS_CRITICAL);
+
+static struct ccu_common *sun60i_a733_r_ccu_clks[] = {
+	&r_ahb_clk.common,
+	&r_apb0_clk.common,
+	&r_apb1_clk.common,
+	&r_cpu_timer0.common,
+	&r_cpu_timer1.common,
+	&r_cpu_timer2.common,
+	&r_cpu_timer3.common,
+	&bus_r_timer_clk.common,
+	&bus_r_twd_clk.common,
+	&r_pwm_clk.common,
+	&bus_r_pwm_clk.common,
+	&r_spi_clk.common,
+	&bus_r_spi_clk.common,
+	&bus_r_msgbox_clk.common,
+	&bus_r_uart0_clk.common,
+	&bus_r_uart1_clk.common,
+	&bus_r_i2c0_clk.common,
+	&bus_r_i2c1_clk.common,
+	&bus_r_i2c2_clk.common,
+	&bus_r_ppu_clk.common,
+	&bus_r_tzma_clk.common,
+	&bus_r_cpu_bist_clk.common,
+	&r_ir_rx_clk.common,
+	&bus_r_ir_rx_clk.common,
+	&bus_r_rtc_clk.common,
+	&r_riscv_clk.common,
+	&bus_r_riscv_clk.common,
+	&bus_r_riscv_cfg_clk.common,
+	&bus_r_cpucfg_clk.common,
+};
+
+static struct clk_hw_onecell_data sun60i_a733_r_hw_clks = {
+	.hws = {
+		[CLK_R_AHB]		= &r_ahb_clk.common.hw,
+		[CLK_R_APB0]		= &r_apb0_clk.common.hw,
+		[CLK_R_APB1]		= &r_apb1_clk.common.hw,
+		[CLK_R_TIMER0]		= &r_cpu_timer0.common.hw,
+		[CLK_R_TIMER1]		= &r_cpu_timer1.common.hw,
+		[CLK_R_TIMER2]		= &r_cpu_timer2.common.hw,
+		[CLK_R_TIMER3]		= &r_cpu_timer3.common.hw,
+		[CLK_BUS_R_TIMER]	= &bus_r_timer_clk.common.hw,
+		[CLK_BUS_R_TWD]		= &bus_r_twd_clk.common.hw,
+		[CLK_R_PWM]		= &r_pwm_clk.common.hw,
+		[CLK_BUS_R_PWM]		= &bus_r_pwm_clk.common.hw,
+		[CLK_R_SPI]		= &r_spi_clk.common.hw,
+		[CLK_BUS_R_SPI]		= &bus_r_spi_clk.common.hw,
+		[CLK_BUS_R_MSGBOX]	= &bus_r_msgbox_clk.common.hw,
+		[CLK_BUS_R_UART0]	= &bus_r_uart0_clk.common.hw,
+		[CLK_BUS_R_UART1]	= &bus_r_uart1_clk.common.hw,
+		[CLK_BUS_R_I2C0]	= &bus_r_i2c0_clk.common.hw,
+		[CLK_BUS_R_I2C1]	= &bus_r_i2c1_clk.common.hw,
+		[CLK_BUS_R_I2C2]	= &bus_r_i2c2_clk.common.hw,
+		[CLK_BUS_R_PPU]		= &bus_r_ppu_clk.common.hw,
+		[CLK_BUS_R_TZMA]	= &bus_r_tzma_clk.common.hw,
+		[CLK_BUS_R_CPU_BIST]	= &bus_r_cpu_bist_clk.common.hw,
+		[CLK_R_IR_RX]		= &r_ir_rx_clk.common.hw,
+		[CLK_BUS_R_IR_RX]	= &bus_r_ir_rx_clk.common.hw,
+		[CLK_BUS_R_RTC]		= &bus_r_rtc_clk.common.hw,
+		[CLK_R_RISCV]		= &r_riscv_clk.common.hw,
+		[CLK_BUS_R_RISCV]	= &bus_r_riscv_clk.common.hw,
+		[CLK_BUS_R_RISCV_CFG]	= &bus_r_riscv_cfg_clk.common.hw,
+		[CLK_BUS_R_CPUCFG]	= &bus_r_cpucfg_clk.common.hw,
+	},
+	.num = CLK_BUS_R_CPUCFG + 1,
+};
+
+static const struct ccu_reset_map sun60i_a733_r_ccu_resets[] = {
+	[RST_BUS_R_TIMER]	= { 0x11c, BIT(16) },
+	[RST_BUS_R_PWM]		= { 0x13c, BIT(16) },
+	[RST_BUS_R_SPI]		= { 0x15c, BIT(16) },
+	[RST_BUS_R_MSGBOX]	= { 0x17c, BIT(16) },
+	[RST_BUS_R_UART0]	= { 0x18c, BIT(16) },
+	[RST_BUS_R_UART1]	= { 0x18c, BIT(17) },
+	[RST_BUS_R_I2C0]	= { 0x19c, BIT(16) },
+	[RST_BUS_R_I2C1]	= { 0x19c, BIT(17) },
+	[RST_BUS_R_I2C2]	= { 0x19c, BIT(18) },
+	[RST_BUS_R_IR_RX]	= { 0x1cc, BIT(16) },
+	[RST_BUS_R_RTC]		= { 0x20c, BIT(16) },
+	[RST_BUS_R_RISCV_CFG]	= { 0x21c, BIT(16) },
+	[RST_BUS_R_CPUCFG]	= { 0x22c, BIT(16) },
+};
+
+static const struct sunxi_ccu_desc sun60i_a733_r_ccu_desc = {
+	.ccu_clks	= sun60i_a733_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun60i_a733_r_ccu_clks),
+
+	.hw_clks	= &sun60i_a733_r_hw_clks,
+
+	.resets		= sun60i_a733_r_ccu_resets,
+	.num_resets	= ARRAY_SIZE(sun60i_a733_r_ccu_resets),
+};
+
+static int sun60i_a733_r_ccu_probe(struct platform_device *pdev)
+{
+	void __iomem *reg;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	return devm_sunxi_ccu_probe(&pdev->dev, reg, &sun60i_a733_r_ccu_desc);
+}
+
+static const struct of_device_id sun60i_a733_r_ccu_ids[] = {
+	{ .compatible = "allwinner,sun60i-a733-r-ccu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun60i_a733_r_ccu_ids);
+
+static struct platform_driver sun60i_a733_r_ccu_driver = {
+	.probe	= sun60i_a733_r_ccu_probe,
+	.driver	= {
+		.name			= "sun60i-a733-r-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun60i_a733_r_ccu_ids,
+	},
+};
+module_platform_driver(sun60i_a733_r_ccu_driver);
+
+MODULE_IMPORT_NS("SUNXI_CCU");
+MODULE_DESCRIPTION("Support for the Allwinner A733 PRCM CCU");
+MODULE_LICENSE("GPL");

-- 
2.55.0

