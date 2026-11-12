Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467696;
	b=rQy2U1LwfCj9NlOwFOiyrSEMVC5d5k0fYB5B61D6jYkIH0oUrRCqWb7Hgka+Zp5axTS+
	 JVq42u41mPULor8G1DhpJqUuxfUYpiu/KvhVpO5XNbjDC/vfFIUzh5H1GIybMuDnUEGhy
	 6s4QN6XJJ9oPP8A5rH+dZ+vxEwittrx5LGcXLRuu9WTL2mQ6AFy//teYRg1foSiE5iUwO
	 3KWoWgE4jImNGzkerrKbJwalA+JO1GDxpsLd3DBn6x/+ZbeagTcS6oKq2wSoKoS+eUmp4
	 FQwGUh3AOc0Oy5hAFx48j68HPLF61HeqWiwltvu6tV5FSfPNVgoccd6ov8pYE93jWUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467696;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ZohoMailClient;
	bh=RQyH3ZGfbkF4xrHAmH66aXwwTTX8ROWMKVq1o0kzI5Q=;
	b=330I+f8SFXN63/4RlQNQ+OmZTUa3X05VCEBJxIyxEab1T5MYvKKAg84jZ2AwBEnygfwJ
	 T4AeG7BRpwO4ivCaXGRVHtcq7KnJLavhdq2AolvDcaFgS8B8LvpFu9JILzhWZ1T//l9mv
	 lOgb9RbMaWfVF8ryH/n1CyDXNOShvc88Td346ttuGctNBSOfKRgqflp0lRjFMA3SvmLv+
	 pIHI/YW/OEK1B9NOufIrDP+oHRH48kpXpNsCWXAJPffbcTvc1MLaiEJcIg7c1ynMsPULk
	 Y3P7UcwVior3VIXOVeNtVvvYmTm5fa/CCrvFVdKphfcYz+WzmIlYeyLietWL7yUAUIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pigmoral.tech;
	spf=pass smtp.mailfrom=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=TnC88xAf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161A606A32A;
	Thu, 12 Nov 2026 07:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C161A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=TnC88xAf
ARC-Seal: i=1; a=rsa-sha256; t=1794467660; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cwqhj4rl8HKdO6jIK6DnIHICeplyUT1xW1vmWzyfGfA1H2ns2vos5QiMUQCYJzakz4zBumIe6VN80dNlya0WM2dqBjhlz07VfhvBr4AWVi8xg/Y3u0aaXjlcVkXm1MU62NGsAxz02qoTckQIKUwmMfOW1rcBfMf76U2R0CNsqWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794467660; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=RQyH3ZGfbkF4xrHAmH66aXwwTTX8ROWMKVq1o0kzI5Q=; 
	b=cspipXNusw34NBsbBPGoDqsyyXtwtyQPcDXKyP1rRKq1u8j5JNa4KjsESuDE5HnGyHPzK3QOB6iIs0aABoBqP+hRUJxCFfqoDKlPaNVcydwZD3UJQ7BliC3zFecaubj8/WNUB51K5LgjZYjWQ9juLw8pbHKIOJuoX+sfFfSXbm0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: a=rsa-sha256; b=TnC88xAfnPlBBxwXE5LCcb9cRRkTxVnvyKxib04HeIiUwJr/R+9xxr/tMBueEPXre3DesmXshhkqdgSI/FtROHl/fBo1J4ku19BT4nxzqzfHPI8eg9lcxuuk8PbiL59vjhykIyWSXO/WXxzsUVr86496XkHHOKgo8wWAb6f/hnw=; c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1; bh=RQyH3ZGfbkF4xrHAmH66aXwwTTX8ROWMKVq1o0kzI5Q=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794467659508683.5039059988334;
	Wed, 11 Nov 2026 23:14:19 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Thu, 12 Nov 2026 15:11:53 +0800
Subject: [PATCH v7 4/8] clk: sunxi-ng: a733: Add PLL clocks support
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-a733-clk-v7-4-db7c5451ffa2@pigmoral.tech>
References: <20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech>
In-Reply-To: <20261112-a733-clk-v7-0-db7c5451ffa2@pigmoral.tech>
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
 Enzo Adriano <enzo.adriano.code@gmail.com>, 
 Andre Przywara <andre.przywara@arm.com>, Norman Herms <dockseed@proton.me>, 
 Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23351;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=xxbZnhBA1GWi+xPhR2Xc6M6b9eCFuwxOTX7FYM4oWFM=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLK+pr0VSZ/+/k2GZ2FZUbPnks38xbFOT+IM0mp1mYyXf
 pvS9GNaRykLgxgXg6yYIguXv/g/ax2eb0cEWu/DzGFlAhnCwMUpABMpTmFkaLR+3KYuttau0+e1
 h2ZFs1nv8nk+1x4vWyv08GHIJDlOR0aGTVNX7phoY8muOTHCwdGoUsL6VJpfKhf3Ega2E3PW7vJ
 hAAA=
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add PLL clock support for the main CCU of the Allwinner A733 SoC. The
structure is mostly similar to the sun55i, with the addition of a
PLL_REF clock that normalizes the hardware-detected DCXO/hosc frequency
(19.2MHz, 24MHz, or 26MHz) into a consistent 24MHz reference for all
subsequent PLLs.

Model the independently gated outputs of the peripheral, video, and DE
PLLs as programmable-divider child clocks, with each output gate modeled
separately. Follow the documented hierarchy for the derived peripheral
PLL outputs.

PLL_AUDIO0 uses SDM parameters from the vendor driver to provide a
22.5792MHz * 4 output. PLL_AUDIO1 provides fixed /2 and /5 outputs and
does not expose fractional rates, but its SDM controls are modeled so
that stale firmware settings can be disabled when an integer rate is
programmed.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/Kconfig           |   5 +
 drivers/clk/sunxi-ng/Makefile          |   2 +
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 586 +++++++++++++++++++++++++++++++++
 3 files changed, 593 insertions(+)

diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
index 202e793dc754..cffa83056934 100644
--- a/drivers/clk/sunxi-ng/Kconfig
+++ b/drivers/clk/sunxi-ng/Kconfig
@@ -67,6 +67,11 @@ config SUN55I_A523_R_CCU
 	default ARCH_SUNXI
 	depends on ARM64 || COMPILE_TEST
 
+config SUN60I_A733_CCU
+	tristate "Support for the Allwinner A733 CCU"
+	default ARCH_SUNXI
+	depends on ARM64 || COMPILE_TEST
+
 config SUN60I_A733_R_CCU
 	tristate "Support for the Allwinner A733 PRCM CCU"
 	default ARCH_SUNXI
diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
index d3702bdb7a23..3a39eb9287da 100644
--- a/drivers/clk/sunxi-ng/Makefile
+++ b/drivers/clk/sunxi-ng/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_SUN50I_H616_CCU)	+= sun50i-h616-ccu.o
 obj-$(CONFIG_SUN55I_A523_CCU)	+= sun55i-a523-ccu.o
 obj-$(CONFIG_SUN55I_A523_MCU_CCU)	+= sun55i-a523-mcu-ccu.o
 obj-$(CONFIG_SUN55I_A523_R_CCU)	+= sun55i-a523-r-ccu.o
+obj-$(CONFIG_SUN60I_A733_CCU)	+= sun60i-a733-ccu.o
 obj-$(CONFIG_SUN60I_A733_R_CCU)	+= sun60i-a733-r-ccu.o
 obj-$(CONFIG_SUN4I_A10_CCU)	+= sun4i-a10-ccu.o
 obj-$(CONFIG_SUN5I_CCU)		+= sun5i-ccu.o
@@ -65,6 +66,7 @@ sun50i-h616-ccu-y		+= ccu-sun50i-h616.o
 sun55i-a523-ccu-y		+= ccu-sun55i-a523.o
 sun55i-a523-mcu-ccu-y		+= ccu-sun55i-a523-mcu.o
 sun55i-a523-r-ccu-y		+= ccu-sun55i-a523-r.o
+sun60i-a733-ccu-y		+= ccu-sun60i-a733.o
 sun60i-a733-r-ccu-y		+= ccu-sun60i-a733-r.o
 sun4i-a10-ccu-y			+= ccu-sun4i-a10.o
 sun5i-ccu-y			+= ccu-sun5i.o
diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
new file mode 100644
index 000000000000..2bc048db8408
--- /dev/null
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 rengaomin@allwinnertech.com
+ * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
+ * Based on the A523 CCU driver:
+ *   Copyright (C) 2023-2024 Arm Ltd.
+ *
+ * When secure boot is enabled, firmware must configure CCMU_SEC_SWITCH_REG
+ * to make the PLL, bus and MBUS clock registers accessible to the
+ * non-secure world.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <dt-bindings/clock/allwinner,sun60i-a733-ccu.h>
+#include <dt-bindings/reset/allwinner,sun60i-a733-ccu.h>
+
+#include "ccu_common.h"
+
+#include "ccu_div.h"
+#include "ccu_gate.h"
+#include "ccu_mult.h"
+#include "ccu_nkmp.h"
+#include "ccu_nm.h"
+
+/*
+ * The DCXO oscillator, the root of most of the clock tree, which may be
+ * 19.2MHz, 24MHz, or 26MHz.
+ */
+static const struct clk_parent_data hosc[] = {
+	{ .fw_name = "hosc" }
+};
+
+/**************************************************************************
+ *                              PLLs                                      *
+ **************************************************************************/
+
+/*
+ * Undocumented, taken from the vendor kernel.
+ * PLL_REF normalizes the DCXO frequency to a 24MHz reference for downstream
+ * PLLs.
+ */
+#define SUN60I_A733_PLL_REF_REG		0x000
+static struct ccu_nkmp pll_ref_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT(8, 8),
+	.m		= _SUNXI_CCU_DIV(16, 7), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_REF_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("pll-ref", hosc,
+							   &ccu_nkmp_ops,
+							   CLK_SET_RATE_GATE),
+	},
+};
+
+/*
+ * Most clock-defining macros expect an *array* of parent clocks, even if
+ * they do not contain a muxer to select between different parents.
+ * The macros ending in just _HW take a simple clock pointer, but then create
+ * a single-entry array out of that. The macros using _HWS take such an
+ * array (even when it is a single entry one), this avoids having those
+ * helper arrays created inside *every* clock definition.
+ * This means for every clock that is referenced more than once it is
+ * useful to create such a dummy array and use _HWS.
+ */
+static const struct clk_hw *pll_ref_hws[] = {
+	&pll_ref_clk.common.hw
+};
+
+#define SUN60I_A733_PLL_DDR_REG		0x020
+static struct ccu_nkmp pll_ddr_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_DDR_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-ddr", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE |
+							 CLK_IS_CRITICAL),
+	},
+};
+
+/*
+ * There is no actual clock output with that frequency (2.4 GHz), instead it
+ * has multiple outputs with adjustable dividers from that base frequency.
+ * Model them separately as divider clocks based on that parent here.
+ */
+#define SUN60I_A733_PLL_PERIPH0_REG	0x0a0
+static struct ccu_nm pll_periph0_4x_clk = {
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_PERIPH0_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-periph0-4x",
+							 pll_ref_hws, &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_periph0_4x_hws[] = {
+	&pll_periph0_4x_clk.common.hw
+};
+
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_periph0_2x_clk, "pll-periph0-2x",
+				 pll_periph0_4x_hws,
+				 SUN60I_A733_PLL_PERIPH0_REG,
+				 20, 3, BIT(27), 0);
+static const struct clk_hw *pll_periph0_2x_hws[] = {
+	&pll_periph0_2x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_periph0_800M_clk, "pll-periph0-800M",
+				 pll_periph0_4x_hws,
+				 SUN60I_A733_PLL_PERIPH0_REG,
+				 16, 3, BIT(26), 0);
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_periph0_480M_clk, "pll-periph0-480M",
+				 pll_periph0_4x_hws,
+				 SUN60I_A733_PLL_PERIPH0_REG,
+				 2, 3, BIT(25), 0);
+static const struct clk_hw *pll_periph0_480M_hws[] = {
+	&pll_periph0_480M_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_600M_clk, "pll-periph0-600M",
+			    pll_periph0_2x_hws, 2, 1, 0);
+static const struct clk_hw *pll_periph0_600M_hws[] = {
+	&pll_periph0_600M_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_400M_clk, "pll-periph0-400M",
+			    pll_periph0_2x_hws, 3, 1, 0);
+static const struct clk_hw *pll_periph0_400M_hws[] = {
+	&pll_periph0_400M_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_300M_clk, "pll-periph0-300M",
+			    pll_periph0_600M_hws, 2, 1, 0);
+static const struct clk_hw *pll_periph0_300M_hws[] = {
+	&pll_periph0_300M_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph0_200M_clk, "pll-periph0-200M",
+			    pll_periph0_400M_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
+			    pll_periph0_300M_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
+			    pll_periph0_480M_hws, 3, 1, 0);
+
+#define SUN60I_A733_PLL_PERIPH1_REG	0x0c0
+static struct ccu_nm pll_periph1_4x_clk = {
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_PERIPH1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-periph1-4x",
+							 pll_ref_hws, &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_periph1_4x_hws[] = {
+	&pll_periph1_4x_clk.common.hw
+};
+
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_periph1_2x_clk, "pll-periph1-2x",
+				 pll_periph1_4x_hws,
+				 SUN60I_A733_PLL_PERIPH1_REG,
+				 20, 3, BIT(27), 0);
+static const struct clk_hw *pll_periph1_2x_hws[] = {
+	&pll_periph1_2x_clk.common.hw
+};
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_periph1_800M_clk, "pll-periph1-800M",
+				 pll_periph1_4x_hws,
+				 SUN60I_A733_PLL_PERIPH1_REG,
+				 16, 3, BIT(26), 0);
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_periph1_480M_clk, "pll-periph1-480M",
+				 pll_periph1_4x_hws,
+				 SUN60I_A733_PLL_PERIPH1_REG,
+				 2, 3, BIT(25), 0);
+static const struct clk_hw *pll_periph1_480M_hws[] = {
+	&pll_periph1_480M_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_600M_clk, "pll-periph1-600M",
+			    pll_periph1_2x_hws, 2, 1, 0);
+static const struct clk_hw *pll_periph1_600M_hws[] = {
+	&pll_periph1_600M_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_400M_clk, "pll-periph1-400M",
+			    pll_periph1_2x_hws, 3, 1, 0);
+static const struct clk_hw *pll_periph1_400M_hws[] = {
+	&pll_periph1_400M_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_300M_clk, "pll-periph1-300M",
+			    pll_periph1_600M_hws, 2, 1, 0);
+static const struct clk_hw *pll_periph1_300M_hws[] = {
+	&pll_periph1_300M_clk.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_periph1_200M_clk, "pll-periph1-200M",
+			    pll_periph1_400M_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_150M_clk, "pll-periph1-150M",
+			    pll_periph1_300M_hws, 2, 1, 0);
+static CLK_FIXED_FACTOR_HWS(pll_periph1_160M_clk, "pll-periph1-160M",
+			    pll_periph1_480M_hws, 3, 1, 0);
+
+#define SUN60I_A733_PLL_GPU_REG		0x0e0
+static struct ccu_nkmp pll_gpu0_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_GPU_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-gpu0", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_VIDEO0_REG	0x120
+static struct ccu_nm pll_video0_clk = {
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VIDEO0_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-video0", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video0_hws[] = {
+	&pll_video0_clk.common.hw
+};
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_video0_4x_clk, "pll-video0-4x",
+				 pll_video0_hws, SUN60I_A733_PLL_VIDEO0_REG,
+				 20, 3, BIT(27), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_video0_3x_clk, "pll-video0-3x",
+				 pll_video0_hws, SUN60I_A733_PLL_VIDEO0_REG,
+				 16, 3, BIT(26), CLK_SET_RATE_PARENT);
+
+#define SUN60I_A733_PLL_VIDEO1_REG	0x140
+static struct ccu_nm pll_video1_clk = {
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VIDEO1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-video1", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video1_hws[] = {
+	&pll_video1_clk.common.hw
+};
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_video1_4x_clk, "pll-video1-4x",
+				 pll_video1_hws, SUN60I_A733_PLL_VIDEO1_REG,
+				 20, 3, BIT(27), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_video1_3x_clk, "pll-video1-3x",
+				 pll_video1_hws, SUN60I_A733_PLL_VIDEO1_REG,
+				 16, 3, BIT(26), CLK_SET_RATE_PARENT);
+
+#define SUN60I_A733_PLL_VIDEO2_REG	0x160
+static struct ccu_nm pll_video2_clk = {
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VIDEO2_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-video2", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_video2_hws[] = {
+	&pll_video2_clk.common.hw
+};
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_video2_4x_clk, "pll-video2-4x",
+				 pll_video2_hws, SUN60I_A733_PLL_VIDEO2_REG,
+				 20, 3, BIT(27), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_video2_3x_clk, "pll-video2-3x",
+				 pll_video2_hws, SUN60I_A733_PLL_VIDEO2_REG,
+				 16, 3, BIT(26), CLK_SET_RATE_PARENT);
+
+#define SUN60I_A733_PLL_VE0_REG		0x220
+static struct ccu_nkmp pll_ve0_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VE0_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-ve0", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_VE1_REG		0x240
+static struct ccu_nkmp pll_ve1_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_VE1_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-ve1", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+/*
+ * PLL_AUDIO0 has a m1 divider in addition to the usual N, M factors.
+ * Since we only need some fixed frequency from this PLL (22.5792MHz x 4),
+ * ignore the divider and force it to 1 (encoded as 0), in the probe function
+ * below.
+ * The M factor must be an even number to produce a 50% duty cycle output.
+ */
+#define SUN60I_A733_PLL_AUDIO0_REG	0x260
+static struct ccu_sdm_setting pll_audio0_sdm_table[] = {
+	{ .rate = 90316800, .pattern = 0xa002872b, .m = 20, .n = 75 }, /* 22.5792 * 4 */
+};
+
+static struct ccu_nm pll_audio0_4x_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(16, 7),
+	.sdm		= _SUNXI_CCU_SDM_DUAL_PAT(pll_audio0_sdm_table, 0,
+						  0x268, BIT(31),
+						  0x26c, BIT(27) | BIT(31)),
+	.common		= {
+		.reg		= SUN60I_A733_PLL_AUDIO0_REG,
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-audio0-4x", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_AUDIO1_REG	0x280
+static struct ccu_nm pll_audio1_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1),	/* input divider */
+	.sdm		= {
+		/* PLL_AUDIO1 does not use fractional rates. */
+		.pat0_enable	= BIT(31),
+		.pat0_reg	= 0x288,
+		.pat1_enable	= BIT(27) | BIT(31),
+		.pat1_reg	= 0x28c,
+	},
+	.common		= {
+		.reg		= SUN60I_A733_PLL_AUDIO1_REG,
+		.features	= CCU_FEATURE_SIGMA_DELTA_MOD,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-audio1", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_audio1_hws[] = {
+	&pll_audio1_clk.common.hw
+};
+static CLK_FIXED_FACTOR_HWS(pll_audio1_div2_clk, "pll-audio1-div2",
+			    pll_audio1_hws, 2, 1, CLK_SET_RATE_PARENT);
+static CLK_FIXED_FACTOR_HWS(pll_audio1_div5_clk, "pll-audio1-div5",
+			    pll_audio1_hws, 5, 1, CLK_SET_RATE_PARENT);
+
+#define SUN60I_A733_PLL_NPU_REG		0x2a0
+static struct ccu_nkmp pll_npu_clk = {
+	.enable		= BIT(27),
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(20, 3), /* output divider */
+	.p		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_NPU_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-npu", pll_ref_hws,
+							 &ccu_nkmp_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+#define SUN60I_A733_PLL_DE_REG		0x2e0
+static struct ccu_nm pll_de_clk = {
+	.lock		= BIT(28),
+	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 11),
+	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
+	.common		= {
+		.reg		= SUN60I_A733_PLL_DE_REG,
+		.hw.init	= CLK_HW_INIT_PARENTS_HW("pll-de", pll_ref_hws,
+							 &ccu_nm_ops,
+							 CLK_SET_RATE_GATE),
+	},
+};
+
+static const struct clk_hw *pll_de_hws[] = {
+	&pll_de_clk.common.hw
+};
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_de_4x_clk, "pll-de-4x", pll_de_hws,
+				 SUN60I_A733_PLL_DE_REG,
+				 20, 3, BIT(27), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_HWS_WITH_GATE(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
+				 SUN60I_A733_PLL_DE_REG,
+				 16, 3, BIT(26), CLK_SET_RATE_PARENT);
+
+/*
+ * Contains all clocks that are controlled by a hardware register. They
+ * have a (sunxi) .common member, which needs to be initialised by the common
+ * sunxi CCU code, to be filled with the MMIO base address and the shared lock.
+ */
+static struct ccu_common *sun60i_a733_ccu_clks[] = {
+	&pll_ref_clk.common,
+	&pll_ddr_clk.common,
+	&pll_periph0_4x_clk.common,
+	&pll_periph0_2x_clk.common,
+	&pll_periph0_800M_clk.common,
+	&pll_periph0_480M_clk.common,
+	&pll_periph1_4x_clk.common,
+	&pll_periph1_2x_clk.common,
+	&pll_periph1_800M_clk.common,
+	&pll_periph1_480M_clk.common,
+	&pll_gpu0_clk.common,
+	&pll_video0_clk.common,
+	&pll_video0_4x_clk.common,
+	&pll_video0_3x_clk.common,
+	&pll_video1_clk.common,
+	&pll_video1_4x_clk.common,
+	&pll_video1_3x_clk.common,
+	&pll_video2_clk.common,
+	&pll_video2_4x_clk.common,
+	&pll_video2_3x_clk.common,
+	&pll_ve0_clk.common,
+	&pll_ve1_clk.common,
+	&pll_audio0_4x_clk.common,
+	&pll_audio1_clk.common,
+	&pll_npu_clk.common,
+	&pll_de_clk.common,
+	&pll_de_4x_clk.common,
+	&pll_de_3x_clk.common,
+};
+
+static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
+	.hws	= {
+		[CLK_PLL_REF]		= &pll_ref_clk.common.hw,
+		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
+		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
+		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
+		[CLK_PLL_PERIPH0_800M]	= &pll_periph0_800M_clk.common.hw,
+		[CLK_PLL_PERIPH0_480M]	= &pll_periph0_480M_clk.common.hw,
+		[CLK_PLL_PERIPH0_600M]	= &pll_periph0_600M_clk.hw,
+		[CLK_PLL_PERIPH0_400M]	= &pll_periph0_400M_clk.hw,
+		[CLK_PLL_PERIPH0_300M]	= &pll_periph0_300M_clk.hw,
+		[CLK_PLL_PERIPH0_200M]	= &pll_periph0_200M_clk.hw,
+		[CLK_PLL_PERIPH0_160M]	= &pll_periph0_160M_clk.hw,
+		[CLK_PLL_PERIPH0_150M]	= &pll_periph0_150M_clk.hw,
+		[CLK_PLL_PERIPH1_4X]	= &pll_periph1_4x_clk.common.hw,
+		[CLK_PLL_PERIPH1_2X]	= &pll_periph1_2x_clk.common.hw,
+		[CLK_PLL_PERIPH1_800M]	= &pll_periph1_800M_clk.common.hw,
+		[CLK_PLL_PERIPH1_480M]	= &pll_periph1_480M_clk.common.hw,
+		[CLK_PLL_PERIPH1_600M]	= &pll_periph1_600M_clk.hw,
+		[CLK_PLL_PERIPH1_400M]	= &pll_periph1_400M_clk.hw,
+		[CLK_PLL_PERIPH1_300M]	= &pll_periph1_300M_clk.hw,
+		[CLK_PLL_PERIPH1_200M]	= &pll_periph1_200M_clk.hw,
+		[CLK_PLL_PERIPH1_160M]	= &pll_periph1_160M_clk.hw,
+		[CLK_PLL_PERIPH1_150M]	= &pll_periph1_150M_clk.hw,
+		[CLK_PLL_GPU0]		= &pll_gpu0_clk.common.hw,
+		[CLK_PLL_VIDEO0]		= &pll_video0_clk.common.hw,
+		[CLK_PLL_VIDEO0_4X]	= &pll_video0_4x_clk.common.hw,
+		[CLK_PLL_VIDEO0_3X]	= &pll_video0_3x_clk.common.hw,
+		[CLK_PLL_VIDEO1]		= &pll_video1_clk.common.hw,
+		[CLK_PLL_VIDEO1_4X]	= &pll_video1_4x_clk.common.hw,
+		[CLK_PLL_VIDEO1_3X]	= &pll_video1_3x_clk.common.hw,
+		[CLK_PLL_VIDEO2]		= &pll_video2_clk.common.hw,
+		[CLK_PLL_VIDEO2_4X]	= &pll_video2_4x_clk.common.hw,
+		[CLK_PLL_VIDEO2_3X]	= &pll_video2_3x_clk.common.hw,
+		[CLK_PLL_VE0]		= &pll_ve0_clk.common.hw,
+		[CLK_PLL_VE1]		= &pll_ve1_clk.common.hw,
+		[CLK_PLL_AUDIO0_4X]	= &pll_audio0_4x_clk.common.hw,
+		[CLK_PLL_AUDIO1]	= &pll_audio1_clk.common.hw,
+		[CLK_PLL_AUDIO1_DIV2]	= &pll_audio1_div2_clk.hw,
+		[CLK_PLL_AUDIO1_DIV5]	= &pll_audio1_div5_clk.hw,
+		[CLK_PLL_NPU]		= &pll_npu_clk.common.hw,
+		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
+		[CLK_PLL_DE_4X]		= &pll_de_4x_clk.common.hw,
+		[CLK_PLL_DE_3X]		= &pll_de_3x_clk.common.hw,
+	},
+	.num	= CLK_FANOUT3 + 1,
+};
+
+static const struct sunxi_ccu_desc sun60i_a733_ccu_desc = {
+	.ccu_clks	= sun60i_a733_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun60i_a733_ccu_clks),
+
+	.hw_clks	= &sun60i_a733_hw_clks,
+};
+
+static const u32 pll_regs[] = {
+	SUN60I_A733_PLL_REF_REG,
+	SUN60I_A733_PLL_DDR_REG,
+	SUN60I_A733_PLL_PERIPH0_REG,
+	SUN60I_A733_PLL_PERIPH1_REG,
+	SUN60I_A733_PLL_GPU_REG,
+	SUN60I_A733_PLL_VIDEO0_REG,
+	SUN60I_A733_PLL_VIDEO1_REG,
+	SUN60I_A733_PLL_VIDEO2_REG,
+	SUN60I_A733_PLL_VE0_REG,
+	SUN60I_A733_PLL_VE1_REG,
+	SUN60I_A733_PLL_AUDIO0_REG,
+	SUN60I_A733_PLL_AUDIO1_REG,
+	SUN60I_A733_PLL_NPU_REG,
+	SUN60I_A733_PLL_DE_REG,
+};
+
+static int sun60i_a733_ccu_probe(struct platform_device *pdev)
+{
+	void __iomem *reg;
+	int i, ret;
+	u32 val;
+
+	reg = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg))
+		return PTR_ERR(reg);
+
+	/*
+	 * The CCU framework only models one enable bit per PLL, while the
+	 * hardware has separate PLL, LDO, lock, and output gate controls.
+	 * Enable the common PLL, LDO, and lock controls here.
+	 */
+	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
+		val = readl(reg + pll_regs[i]);
+		val |= BIT(31) | BIT(30) | BIT(29);
+		writel(val, reg + pll_regs[i]);
+	}
+
+	/* Enforce m1 = 0 for PLL_AUDIO0. */
+	val = readl(reg + SUN60I_A733_PLL_AUDIO0_REG);
+	val &= ~BIT(1);
+	writel(val, reg + SUN60I_A733_PLL_AUDIO0_REG);
+
+	/* Enforce the named /2 and /5 outputs for PLL_AUDIO1. */
+	val = readl(reg + SUN60I_A733_PLL_AUDIO1_REG);
+	val &= ~(GENMASK(22, 20) | GENMASK(18, 16));
+	val |= (1 << 20) | (4 << 16);
+	writel(val, reg + SUN60I_A733_PLL_AUDIO1_REG);
+
+	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun60i_a733_ccu_desc);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct of_device_id sun60i_a733_ccu_ids[] = {
+	{ .compatible = "allwinner,sun60i-a733-ccu" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, sun60i_a733_ccu_ids);
+
+static struct platform_driver sun60i_a733_ccu_driver = {
+	.probe	= sun60i_a733_ccu_probe,
+	.driver	= {
+		.name			= "sun60i-a733-ccu",
+		.suppress_bind_attrs	= true,
+		.of_match_table		= sun60i_a733_ccu_ids,
+	},
+};
+module_platform_driver(sun60i_a733_ccu_driver);
+
+MODULE_IMPORT_NS("SUNXI_CCU");
+MODULE_DESCRIPTION("Support for the Allwinner A733 CCU");
+MODULE_LICENSE("GPL");

-- 
2.56.0

