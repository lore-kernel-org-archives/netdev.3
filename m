Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com [165.173.180.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E05C544D69;
	Tue, 29 Sep 2026 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790702887; cv=pass; b=ciar0bdrhsg7ZbkQtRPHLhILPTb0bL9Qp+N5MkoN/EMsY0T6dsNm2IbnNnjV75IDpZdsDc4mfFqIpKInyQKoEIxfEnYIfCBwCE0P8AdYpLKjv/TnyFAvMmvL4dGCDsIlk2blpavvvfDjldNfIVZMBPgE5sGUXUfvRE8Rg+GBzGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790702887; c=relaxed/simple;
	bh=lkc+TBcZ8rSbjnHuhgK0z3s9+F1IWJmQqs6m8lT/9aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SawJ0NtYUS4bTrpHgFDHsS8z1c59QRBILKVUbIl7ro1FaosxhZcS12L1VBW0L96FlzkAskv/956VUZ0ZxtS360vG//UpyXz/jk/5nm6XMJK5dOB9qV9Ho3m1MZ/U5KXnfB31qMYk7+OW042Wh+mQpdOyX/kQub8YcPDJxh2AVDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=Ur6Wcypg; arc=pass smtp.client-ip=165.173.180.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="Ur6Wcypg"
ARC-Seal: i=1; a=rsa-sha256; t=1790702859; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FNMvOPCIbetENtWDWE2Ptd5fAtMW4110KTzJxryZyoaexGpuKCbmPTgswwUpyLdw8XlV4YgPECDY+DGo/xEDnnlCg5GOXAn6d9aLPJNTzJclHCW22Fyjxp1VNmnLVXDTndpw5vuQmil2igLjkAKfyDTCH4vlN/jkBB8mEzwMjCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790702859; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EL9zRWnYHURCm+KCISV2HbVE+fRRAQvqELI079kIs04=; 
	b=Om8dcQkfNWhEyEABHVkjjCnh90R4Pg7hAqsnNR6Dg8KVfaTYB/ZVj+mCyzefTOgMxbWhHcTzJTnlnU14Gany/KalB/DddOPYwhxrOY5dJFvEpDUgIvVVfckkFUDrkEVmJmiwDVPjlU9Rv8rbP59FfxIZyVmBbApu6xdS1IH8f7k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790702859;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=EL9zRWnYHURCm+KCISV2HbVE+fRRAQvqELI079kIs04=;
	b=Ur6WcypgzS9ayabvDIm3XR79LKrM9EDCpMWIY71PQ1Faw3Pja+SvDYzoD0Mx05Gt
	1oUqgNZ75UGLsCzpM0rW1zlcz6e+5q2ANylsCTiWLKr371KTWprhUtKkouLjGdi8eJp
	b27PW84yZYZt612TX2V5HC8tsy3m0hm9oAda4d9U=
Received: by smtp.zohomail.com with SMTPS id 17907028578601008.2757210707019;
	Tue, 29 Sep 2026 10:27:37 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Wed, 30 Sep 2026 01:26:12 +0800
Subject: [PATCH v5 5/8] clk: sunxi-ng: a733: Add bus clocks support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-a733-clk-v5-5-11175b41cd2d@pigmoral.tech>
References: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
In-Reply-To: <20260930-a733-clk-v5-0-11175b41cd2d@pigmoral.tech>
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
 Andre Przywara <andre.przywara@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6211;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=lkc+TBcZ8rSbjnHuhgK0z3s9+F1IWJmQqs6m8lT/9aA=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLJ2fzm8fc0Gr7pb3RvUlx5U74uaWrXptMp5KZegS8xHu
 Os7z0SFd5SyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCR7ckM/8PLS379OZHPI/D0
 5YI5F95VTo51ihT4LO92ZpHGmvV5WZyMDGu4Vl3Tnh3efdz3/bTngll+U3NfCdyuaY+fyTwrZ/G
 NnVwA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add the essential bus clocks in the Allwinner A733 CCU, including AHB,
APB0, APB1, APB_UART, and MBUS. These buses are necessary for many other
functional modules. Additional clocks such as trace and gic are also
added as they fall within the register address range of the bus clocks,
even though they are not strictly bus clocks.

The MBUS clock is marked as critical to ensure the memory bus remains
operational at all times. And the hardware requires an update bit
(bit 27) to be set so that the configuration takes effect and the
updated parameters can be correctly read back for the MBUS clock.

The GIC clock is also marked as critical. The bootloader may leave the
GIC running on a PLL parent, and disabling that PLL during
clk_disable_unused would hang the interrupt controller and the system.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 105 +++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 430a535919c6..eda4b347c540 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -18,6 +18,7 @@
 
 #include "ccu_div.h"
 #include "ccu_gate.h"
+#include "ccu_mp.h"
 #include "ccu_mult.h"
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
@@ -68,6 +69,16 @@ static const struct clk_hw *pll_ref_hws[] = {
 	&pll_ref_clk.common.hw
 };
 
+/*
+ * There is a non-software-configurable mux selecting between the DCXO and the
+ * PLL_REF in hardware, whose output is fed to the sys-24M clock. Although both
+ * sys-24M and pll-ref are fixed at 24 MHz, define a 1:1 fixed factor clock to
+ * provide logical separation:
+ * - pll-ref is dedicated to feeding other PLLs
+ * - sys-24M serves as reference clock for downstream functional modules
+ */
+static CLK_FIXED_FACTOR_HWS(sys_24M_clk, "sys-24M", pll_ref_hws, 1, 1, 0);
+
 #define SUN60I_A733_PLL_DDR_REG		0x020
 static struct ccu_nkmp pll_ddr_clk = {
 	.enable		= BIT(27),
@@ -414,6 +425,85 @@ static SUNXI_CCU_M_HWS_WITH_GATE(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
 				 SUN60I_A733_PLL_DE_REG,
 				 16, 3, BIT(26), 0);
 
+/**************************************************************************
+ *                           bus clocks                                   *
+ **************************************************************************/
+
+static const struct clk_parent_data ahb_apb_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+};
+
+static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb_parents, 0x500,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb_parents, 0x510,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", ahb_apb_parents, 0x518,
+				 0, 5,		/* M */
+				 24, 2,		/* mux */
+				 0);
+
+static const struct clk_parent_data apb_uart_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX(apb_uart_clk, "apb-uart", apb_uart_parents, 0x538,
+				 0, 5,		/* M */
+				 24, 3,		/* mux */
+				 0);
+
+static const struct clk_parent_data trace_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(trace_clk, "trace", trace_parents, 0x540,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data gic_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gic_clk, "gic", gic_parents, 0x560,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      CLK_IS_CRITICAL);
+
+static const struct clk_parent_data mbus_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph1_600M_clk.hw },
+	{ .hw = &pll_ddr_clk.common.hw },
+	{ .hw = &pll_periph1_480M_clk.common.hw },
+	{ .hw = &pll_periph1_400M_clk.hw },
+	{ .hw = &pll_npu_clk.common.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588,
+					   0, 5,	/* M */
+					   24, 3,	/* mux */
+					   BIT(31),	/* gate */
+					   CLK_IS_CRITICAL,
+					   CCU_FEATURE_UPDATE_BIT);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -448,11 +538,19 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&pll_de_clk.common,
 	&pll_de_4x_clk.common,
 	&pll_de_3x_clk.common,
+	&ahb_clk.common,
+	&apb0_clk.common,
+	&apb1_clk.common,
+	&apb_uart_clk.common,
+	&trace_clk.common,
+	&gic_clk.common,
+	&mbus_clk.common,
 };
 
 static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 	.hws	= {
 		[CLK_PLL_REF]		= &pll_ref_clk.common.hw,
+		[CLK_SYS_24M]		= &sys_24M_clk.hw,
 		[CLK_PLL_DDR]		= &pll_ddr_clk.common.hw,
 		[CLK_PLL_PERIPH0_4X]	= &pll_periph0_4x_clk.common.hw,
 		[CLK_PLL_PERIPH0_2X]	= &pll_periph0_2x_clk.common.hw,
@@ -494,6 +592,13 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_PLL_DE]		= &pll_de_clk.common.hw,
 		[CLK_PLL_DE_4X]		= &pll_de_4x_clk.common.hw,
 		[CLK_PLL_DE_3X]		= &pll_de_3x_clk.common.hw,
+		[CLK_AHB]		= &ahb_clk.common.hw,
+		[CLK_APB0]		= &apb0_clk.common.hw,
+		[CLK_APB1]		= &apb1_clk.common.hw,
+		[CLK_APB_UART]		= &apb_uart_clk.common.hw,
+		[CLK_TRACE]		= &trace_clk.common.hw,
+		[CLK_GIC]		= &gic_clk.common.hw,
+		[CLK_MBUS]		= &mbus_clk.common.hw,
 	},
 	.num	= CLK_FANOUT3 + 1,
 };

-- 
2.55.0

