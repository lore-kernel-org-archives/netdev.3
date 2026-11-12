Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794467709;
	b=FPuG9i46VgZ839NM6OrFXXsncWgesChEiFguPawOteaAlsiQMCTU8OxrgyU/lhImPOTt
	 B8WU5PQkjlO4f5yRM9uqBpD/aKxZXXoEm+bPE/4otLgvAGHW4pJaYvzW9sU4nCCcfpdU1
	 +SutY/nJcMyOfvVr2rUZwRfFrAW3O1ZB3KdSkGH4mtbP5xOtpGQirv0TQ7mu+DWAf+/la
	 LDQ3VhTr5YKG7/clNMaL/Kt2shBxiBuehXFxXkkcHVmK2dlntf1LMIrVDHKwWhN4uqFat
	 WfGdMeRmMSk+kUluYqhd+a+fk258DAwtZpaEVOHEWidcjD9e+jGSCLWwjT/r+JmT/aA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794467709;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ZohoMailClient;
	bh=7DGylC5Tal8PNvLdSR03us4KpkScMb1/NgOJKcmXHUs=;
	b=SCAy4WU6QcplwJh0bWgAWNwbaijB274H5v2GgESltNlyavC9jgvk7+I6POg2NJ3u8gJe
	 Rmc8T3k9V0IVcHcyx0OlSzaPCUIQoqDYbF0QCPuqmK/8ZJ3p4mtH0s1NBJPDLj4UuUnJ8
	 +HoQiKaCuLHnj0FfZ4edU7fiqh9vUnUH7GIVnxB/l62z7GFEatkjI8Hx8w/RzJwd4MPrm
	 ee0FILg1lOuVsyL1PTHHfsD4fAoDmxxUERtWAVdsc65hnWuzZJycTrcjNafqY+DjQdunN
	 wGfsSX7eqyppdEU1Op0C0WxwArNTK8FKeGrUSH8ZOyTi9zNb3iTZGwG/kQrcfzFUnZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pigmoral.tech;
	spf=pass smtp.mailfrom=pigmoral.tech;
	dkim=pass header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=AlQvHT4Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.15
Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E97606A330;
	Thu, 12 Nov 2026 07:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1E97606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=AlQvHT4Q
ARC-Seal: i=1; a=rsa-sha256; t=1794467672; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UuhJha33UlX61fo2GxfRv5Ec4eWtGKD2jXyeWCzIgxK1UYRMCRL9YmWRg05UB6RoVp42uWvG/UwgwCzbVUjh8/zuAPMiufcE1yIlcbtRf7PVfmwKeC8GqMAPxmcfINzjhbqXEtsxmCFej2ttc5GNeiv1R4oqPFaFTLAajHyGN7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794467672; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7DGylC5Tal8PNvLdSR03us4KpkScMb1/NgOJKcmXHUs=; 
	b=NPh4FI+cYOoBuU5NERQmJDE3ESsbrryqfNzhVOx0C/p/z9SbRjbFT9gbqK4XqLzdwdiRyT8uRSnNCeNghjxIEpUdl6bPX+k0yOSoanCU1/85wlpnReYkW1um1o+C42fkd7quzgQo/eXrgJYWn6sL3IiGqhrTeBYnh4i8n+q0hbg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: a=rsa-sha256; b=AlQvHT4QngxIJNxunRRZfl7UIKHeNNsKhoeA6FavGI8BtEGFmvn+jfTm486iMy4yORcbVLUKV+rFaQpLO2HIcaxfzaMLuIZMISlp3gEwI1YsDboSfSLXO6yCNMqIVFkRz5vYc4dYyNZRLe50CO1cpq3hZfJw66C5ZewyYPmvpNA=; c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1; bh=7DGylC5Tal8PNvLdSR03us4KpkScMb1/NgOJKcmXHUs=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794467671389832.7592581645164;
	Wed, 11 Nov 2026 23:14:31 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Thu, 12 Nov 2026 15:11:54 +0800
Subject: [PATCH v7 5/8] clk: sunxi-ng: a733: Add bus clocks support
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
Message-Id: <20261112-a733-clk-v7-5-db7c5451ffa2@pigmoral.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6709;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=Jd6k06kpMFlcKxqvb7mUrY0T6ZzhptZeB1JjU0hKTI8=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLK+pn3818kbwyZ41eis4A+91Ud5eg9P+JHkdjPsbcs70
 TuHS9SudJSyMIhxMciKKbJw+Yv/s9bh+XZEoPU+zBxWJpAhDFycAjCR4p2MDB9Vv8z+I53ZuDC9
 Yety7qqIF3vjtFYaXcnxsZhgsS+oaQYjw1z/S4JNn5MvaSUZX3oYd2HWpfmWL1/uz0hPuz+1T0x
 gCQMA
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
Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Tested-by: Vinicius Pedrosa <vinicius.eduardo.pedrosa@gmail.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 108 +++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 2bc048db8408..8bc603393f5a 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -8,6 +8,9 @@
  * When secure boot is enabled, firmware must configure CCMU_SEC_SWITCH_REG
  * to make the PLL, bus and MBUS clock registers accessible to the
  * non-secure world.
+ *
+ * CPU_PERI_CLK_REG has no documented consumer, while NSI_CLK_REG has no
+ * known kernel consumer, so they are not modelled here.
  */
 
 #include <linux/clk-provider.h>
@@ -22,6 +25,7 @@
 
 #include "ccu_div.h"
 #include "ccu_gate.h"
+#include "ccu_mp.h"
 #include "ccu_mult.h"
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
@@ -72,6 +76,16 @@ static const struct clk_hw *pll_ref_hws[] = {
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
@@ -418,6 +432,85 @@ static SUNXI_CCU_M_HWS_WITH_GATE(pll_de_3x_clk, "pll-de-3x", pll_de_hws,
 				 SUN60I_A733_PLL_DE_REG,
 				 16, 3, BIT(26), CLK_SET_RATE_PARENT);
 
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
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_ddr_clk.common.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
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
@@ -452,11 +545,19 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
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
@@ -498,6 +599,13 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
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
2.56.0

