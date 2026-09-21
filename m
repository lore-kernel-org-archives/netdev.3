Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED804DAF8C;
	Mon, 21 Sep 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005237; cv=pass; b=o8kKD1tK6FAVg00iDdVM7vO3IpcXEoEgRs6qddl7so6ocPV4ow32piIG4hYkx6kVNK5na5WIXGPiknjCDZEU6w7BCA2DnYFKGsGsVhdI4TZVXti0sgtjTYOlMWn61VI6eDrKuztHOD8ByQ7G3EJ7ev4g+D2x1jBJ+s7JANOEkgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005237; c=relaxed/simple;
	bh=i/sLUp+BXLSQ5z2zM2s1zGZ5ud2IbBLH+NO/2YNlhmY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1fg96gXCcG7tlRphNrABND+NOl1aFcfKE20SvFiSOQyWPYJbcs735xCB8pNVpfWJC7kmLNhEwN/yCPccchGrx4La70P28r9I1xbsu6HaeT80e1GfnOjrxUiucUeziSfuY3n0mpPhL7s+0Qe2owb0ka2uDuzUNOfn2UsJHpyu3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=qUDMGHSE; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="qUDMGHSE"
ARC-Seal: i=1; a=rsa-sha256; t=1790005201; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=D0x8n/gK5negvqIgBKulihGAPkusyzGPGuMF0Lfjx/lXLjZgYiIlDAaeTY1npGuvV1j5FuSfWdSJniu+fL4SrWid5iQv7ESNo/TfnYbWId6O7ZTKUt8XemhMfG28TnmLdYz/YoLSReTTFoM3tLIztOImcqL2i7wq27V190+w3so=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790005201; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kAd8So9uG1KzjWksLOc/92mft6x3GIkCSmOffT9ICuo=; 
	b=n222uJjcsOlA04HTKsvrVJZQrLvtOA9MS9opOhi5z30nWMZW/y9sYmuf9k/MDDmL438shTrQBpiTVC3AKyPjCn8/MQz4aMTugWOyYpfpychmJ/67BdCry81cuthsdUv83Xk7l5fa9Z/AQy3omSIQTO3qb5LhcLUYHlf1YNwGuyQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005201;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=kAd8So9uG1KzjWksLOc/92mft6x3GIkCSmOffT9ICuo=;
	b=qUDMGHSEfxUtw7UyQf6zE45LUbJx4kwhL3HpXH7f/NRc75PfGKyiCjilGnLCfu1m
	kOQOmVMtIW7v0V0Iyqa41zHSQfthp52/NovYxYenZTF9H22pQSmb9lESa+M0CxD5SS7
	2K/iMwfVagQtgj8SxwW9WEloWHefnab7nZHFHFsQ=
Received: by smtp.zohomail.com with SMTPS id 1790005198999184.54476885946656;
	Mon, 21 Sep 2026 08:39:58 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Sep 2026 23:38:04 +0800
Subject: [PATCH v4 6/8] clk: sunxi-ng: a733: Add mod clocks support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-a733-clk-v4-6-9c184ebe9ac1@pigmoral.tech>
References: <20260921-a733-clk-v4-0-9c184ebe9ac1@pigmoral.tech>
In-Reply-To: <20260921-a733-clk-v4-0-9c184ebe9ac1@pigmoral.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=38829;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=i/sLUp+BXLSQ5z2zM2s1zGZ5ud2IbBLH+NO/2YNlhmY=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2+tcu9ys/L9KxrOH1tkNVwWy8H2fpn+O9vorp+B61C
 49KsluzO0pZGMS4GGTFFFm4/MX/WevwfDsi0HofZg4rE8gQBi5OAZhI2ANGhqlNNeKzc04JyIU/
 vD/5sdcvs7spijwX7Mv42TxP73L7vJXhn0ZdxvzLWVMMntwxZd07Kbd02uwUv9pq37rn10TTsvb
 PYgMA
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add the module clocks found in the Allwinner A733 SoC, including video,
storage, interfaces and others. While most of these clocks are similar
to those in the A523 SoC, this implementation accounts for changes in
register offsets and introduces support for new modules.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 1103 ++++++++++++++++++++++++++++++++
 1 file changed, 1103 insertions(+)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 00c61806c29b..37e5fe1b327c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -20,6 +20,7 @@
 #include "ccu_gate.h"
 #include "ccu_mp.h"
 #include "ccu_mult.h"
+#include "ccu_mux.h"
 #include "ccu_nkmp.h"
 #include "ccu_nm.h"
 
@@ -78,6 +79,9 @@ static const struct clk_hw *pll_ref_hws[] = {
  * - sys-24M serves as reference clock for downstream functional modules
  */
 static CLK_FIXED_FACTOR_HWS(sys_24M_clk, "sys-24M", pll_ref_hws, 1, 1, 0);
+static const struct clk_hw *sys_24M_hws[] = {
+	&sys_24M_clk.hw
+};
 
 #define SUN60I_A733_PLL_DDR_REG		0x020
 static struct ccu_nkmp pll_ddr_clk = {
@@ -154,6 +158,9 @@ static CLK_FIXED_FACTOR_HWS(pll_periph0_200M_clk, "pll-periph0-200M",
 			    pll_periph0_400M_hws, 2, 1, 0);
 static CLK_FIXED_FACTOR_HWS(pll_periph0_150M_clk, "pll-periph0-150M",
 			    pll_periph0_300M_hws, 2, 1, 0);
+static const struct clk_hw *pll_periph0_150M_hws[] = {
+	&pll_periph0_150M_clk.hw
+};
 static CLK_FIXED_FACTOR_HWS(pll_periph0_160M_clk, "pll-periph0-160M",
 			    pll_periph0_480M_hws, 3, 1, 0);
 
@@ -491,6 +498,912 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588
 					   CLK_IS_CRITICAL,
 					   CCU_FEATURE_UPDATE_BIT);
 
+/**************************************************************************
+ *                          mod clocks                                    *
+ **************************************************************************/
+
+static const struct clk_parent_data timer_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "iosc" },
+	{ .fw_name = "losc" },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer0_clk, "timer0", timer_parents, 0x800,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer1_clk, "timer1", timer_parents, 0x804,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer2_clk, "timer2", timer_parents, 0x808,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer3_clk, "timer3", timer_parents, 0x80c,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer4_clk, "timer4", timer_parents, 0x810,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer5_clk, "timer5", timer_parents, 0x814,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer6_clk, "timer6", timer_parents, 0x818,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer7_clk, "timer7", timer_parents, 0x81c,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer8_clk, "timer8", timer_parents, 0x820,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer9_clk, "timer9", timer_parents, 0x824,
+				      0, 3,		/* P */
+				      24, 3,		/* mux */
+				      BIT(31),		/* gate */
+				      0);
+
+/* Undocumented, taken from the vendor kernel. */
+static const struct clk_parent_data avs_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(avs_clk, "avs-clk", avs_parents, 0x880,
+				    24, 3,		/* mux */
+				    BIT(31),		/* gate */
+				    0);
+
+static const struct clk_hw *de_parents[] = {
+	&pll_de_3x_clk.common.hw,
+	&pll_de_4x_clk.common.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_300M_clk.hw,
+	&pll_video0_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(de0_clk, "de0", de_parents, 0xa00,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *di_parents[] = {
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_video0_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0xa20,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *g2d_parents[] = {
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_300M_clk.hw,
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0xa40,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *eink_parents[] = {
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(eink_clk, "eink", eink_parents, 0xa60,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *eink_panel_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video0_3x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video1_3x_clk.common.hw,
+	&pll_periph0_300M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(eink_panel_clk, "eink-panel", eink_panel_parents, 0xa64,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *ve_enc_parents[] = {
+	&pll_ve0_clk.common.hw,
+	&pll_ve1_clk.common.hw,
+	&pll_periph0_800M_clk.common.hw,
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_de_3x_clk.common.hw,
+	&pll_npu_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_enc0_clk, "ve-enc0", ve_enc_parents, 0xa80,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *ve_dec_parents[] = {
+	&pll_ve1_clk.common.hw,
+	&pll_ve0_clk.common.hw,
+	&pll_periph0_800M_clk.common.hw,
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_de_3x_clk.common.hw,
+	&pll_npu_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_dec0_clk, "ve-dec0", ve_dec_parents, 0xa88,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    CLK_SET_RATE_PARENT);
+
+static const struct clk_hw *ce_parents[] = {
+	&sys_24M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_600M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0xac0,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *npu_parents[] = {
+	&pll_npu_clk.common.hw,
+	&pll_periph0_800M_clk.common.hw,
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_ve0_clk.common.hw,
+	&pll_ve1_clk.common.hw,
+	&pll_de_3x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0xb00,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+/*
+ * GPU_CLK = ClockSource * ((16 - M) / 16)
+ * Here we use a div_table to select M values that result in integer divisors.
+ */
+static struct clk_div_table gpu_div_table[] = {
+	{ .val = 0, .div = 1 },
+	{ .val = 8, .div = 2 },
+	{ .val = 12, .div = 4 },
+	{ .val = 14, .div = 8 },
+	{ .val = 15, .div = 16 },
+	{ /* sentinel */ },
+};
+static const struct clk_parent_data gpu_parents[] = {
+	{ .hw = &pll_gpu0_clk.common.hw, },
+	{ .hw = &pll_periph0_800M_clk.common.hw, },
+	{ .hw = &pll_periph0_600M_clk.hw, },
+	{ .hw = &pll_periph0_400M_clk.hw, },
+	{ .hw = &pll_periph0_300M_clk.hw, },
+	{ .hw = &pll_periph0_200M_clk.hw, },
+};
+static struct ccu_div gpu0_clk = {
+	.enable		= BIT(31),
+	.div		= _SUNXI_CCU_DIV_TABLE(0, 4, gpu_div_table),
+	.mux		= _SUNXI_CCU_MUX(24, 3),
+	.common		= {
+		.reg		= 0xb20,
+		.features	= CCU_FEATURE_UPDATE_BIT,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("gpu0", gpu_parents,
+							   &ccu_div_ops, 0),
+	}
+};
+
+static const struct clk_parent_data dram_parents[] = {
+	{ .hw = &pll_ddr_clk.common.hw, },
+	{ .hw = &pll_periph0_800M_clk.common.hw, },
+	{ .hw = &pll_periph0_600M_clk.hw, },
+	{ .hw = &pll_de_clk.common.hw, },
+	{ .hw = &pll_npu_clk.common.hw, },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(dram0_clk, "dram0", dram_parents, 0xc00,
+					   0, 4,	/* M */
+					   24, 3,	/* mux */
+					   BIT(31),	/* gate */
+					   CLK_IS_CRITICAL,
+					   CCU_FEATURE_UPDATE_BIT);
+
+static const struct clk_parent_data nand_mmc_parents[] = {
+	{ .hw = &sys_24M_clk.hw, },
+	{ .hw = &pll_periph0_400M_clk.hw, },
+	{ .hw = &pll_periph0_300M_clk.hw, },
+	{ .hw = &pll_periph1_400M_clk.hw, },
+	{ .hw = &pll_periph1_300M_clk.hw, },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk0_clk, "nand0-clk0", nand_mmc_parents, 0xc80,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk1_clk, "nand0-clk1", nand_mmc_parents, 0xc84,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc0_clk, "mmc0", nand_mmc_parents, 0xd00,
+					     0, 5,	/* M */
+					     8, 5,	/* P */
+					     24, 3,	/* mux */
+					     BIT(31),	/* gate */
+					     2,		/* post div */
+					     0);
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc1_clk, "mmc1", nand_mmc_parents, 0xd10,
+					     0, 5,	/* M */
+					     8, 5,	/* P */
+					     24, 3,	/* mux */
+					     BIT(31),	/* gate */
+					     2,		/* post div */
+					     0);
+
+static const struct clk_parent_data mmc2_mmc3_parents[] = {
+	{ .hw = &sys_24M_clk.hw, },
+	{ .hw = &pll_periph0_800M_clk.common.hw },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .hw = &pll_periph1_800M_clk.common.hw },
+	{ .hw = &pll_periph1_600M_clk.hw },
+};
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc2_clk, "mmc2", mmc2_mmc3_parents, 0xd20,
+					     0, 5,	/* M */
+					     8, 5,	/* P */
+					     24, 3,	/* mux */
+					     BIT(31),	/* gate */
+					     2,		/* post div */
+					     0);
+static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc3_clk, "mmc3", mmc2_mmc3_parents, 0xd30,
+					     0, 5,	/* M */
+					     8, 5,	/* P */
+					     24, 3,	/* mux */
+					     BIT(31),	/* gate */
+					     2,		/* post div */
+					     0);
+
+static const struct clk_hw *ufs_axi_parents[] = {
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_200M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(ufs_axi_clk, "ufs-axi", ufs_axi_parents, 0xd80,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_parent_data ufs_cfg_parents[] = {
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ufs_cfg_clk, "ufs-cfg", ufs_cfg_parents, 0xd84,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data spi_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .hw = &pll_periph1_300M_clk.hw },
+	{ .hw = &pll_periph1_200M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph1_480M_clk.common.hw },
+	{ .fw_name = "hosc"},
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(spi0_clk, "spi0", spi_parents, 0xf00,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_DUALDIV_MUX_GATE(spi1_clk, "spi1", spi_parents, 0xf08,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_DUALDIV_MUX_GATE(spi2_clk, "spi2", spi_parents, 0xf10,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data spif_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_400M_clk.hw },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .hw = &pll_periph1_400M_clk.hw },
+	{ .hw = &pll_periph1_300M_clk.hw },
+	{ .hw = &pll_periph0_160M_clk.hw },
+	{ .hw = &pll_periph1_160M_clk.hw },
+	{ .fw_name = "hosc"},
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(spif_clk, "spif", spif_parents, 0xf18,
+				  0, 5,		/* M */
+				  8, 5,		/* P */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_DUALDIV_MUX_GATE(spi3_clk, "spi3", spi_parents, 0xf20,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+/* Undocumented, taken from the vendor kernel. */
+static SUNXI_CCU_DUALDIV_MUX_GATE(spi4_clk, "spi4", spi_parents, 0xf28,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data gpadc0_24m_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "hosc"},
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gpadc0_24m_clk, "gpadc0-24m", gpadc0_24m_parents, 0xfc0,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data irrx_parents[] = {
+	{ .fw_name = "losc"},
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "hosc"},
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irrx_clk, "irrx", irrx_parents, 0x1000,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data irtx_parents[] = {
+	{ .fw_name = "losc"},
+	{ .hw = &pll_periph1_600M_clk.hw },
+	{ .fw_name = "hosc"},
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irtx_clk, "irtx", irtx_parents, 0x1008,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+/* Undocumented, taken from the vendor kernel. */
+static const struct clk_parent_data sgpio_parents[] = {
+	{ .fw_name = "losc"},
+	{ .hw = &sys_24M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(sgpio_clk, "sgpio", sgpio_parents, 0x1060,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+/* Undocumented, taken from the vendor kernel. */
+static const struct clk_hw *lpc_parents[] = {
+	&pll_video0_3x_clk.common.hw,
+	&pll_video1_3x_clk.common.hw,
+	&pll_video2_3x_clk.common.hw,
+	&pll_periph0_300M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(lpc_clk, "lpc", lpc_parents, 0x1080,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *i2spcm_parents[] = {
+	&pll_audio0_4x_clk.common.hw,
+	&pll_audio1_div2_clk.hw,
+	&pll_audio1_div5_clk.hw,
+	&pll_periph0_200M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm0_clk, "i2spcm0", i2spcm_parents, 0x1200,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm1_clk, "i2spcm1", i2spcm_parents, 0x1210,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_clk, "i2spcm2", i2spcm_parents, 0x1220,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *i2spcm2_asrc_parents[] = {
+	&pll_audio0_4x_clk.common.hw,
+	&pll_audio1_div2_clk.hw,
+	&pll_audio1_div5_clk.hw,
+	&pll_periph0_300M_clk.hw,
+	&pll_periph1_300M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_asrc_clk, "i2spcm2_asrc", i2spcm2_asrc_parents, 0x1224,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm3_clk, "i2spcm3", i2spcm_parents, 0x1230,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm4_clk, "i2spcm4", i2spcm_parents, 0x1240,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *spdif_tx_parents[] = {
+	&pll_audio0_4x_clk.common.hw,
+	&pll_audio1_div2_clk.hw,
+	&pll_audio1_div5_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(spdif_tx_clk, "spdif-tx", spdif_tx_parents, 0x1280,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *spdif_rx_parents[] = {
+	&pll_periph0_200M_clk.hw,
+	&pll_periph0_300M_clk.hw,
+	&pll_periph0_400M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(spdif_rx_clk, "spdif-rx", spdif_rx_parents, 0x1284,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *dmic_parents[] = {
+	&pll_audio0_4x_clk.common.hw,
+	&pll_audio1_div2_clk.hw,
+	&pll_audio1_div5_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(dmic_clk, "dmic", dmic_parents, 0x12c0,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+/*
+ * The first parent is a 48 MHz input clock divided by 4. That 48 MHz clock is
+ * a 2x multiplier from pll-ref synchronized by pll-periph0, and is also used by
+ * the OHCI module.
+ */
+static const struct clk_parent_data usb_ohci_parents[] = {
+	{ .hw = &pll_periph0_4x_clk.common.hw },
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+};
+static const struct ccu_mux_fixed_prediv usb_ohci_predivs[] = {
+	{ .index = 0, .div = 200 },
+	{ .index = 1, .div = 2 },
+};
+
+static struct ccu_mux usb_ohci0_clk = {
+	.enable		= BIT(31),
+	.mux		= {
+		.shift		= 24,
+		.width		= 2,
+		.fixed_predivs	= usb_ohci_predivs,
+		.n_predivs	= ARRAY_SIZE(usb_ohci_predivs),
+	},
+	.common		= {
+		.reg		= 0x1300,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("usb-ohci0", usb_ohci_parents,
+							   &ccu_mux_ops, 0),
+	},
+};
+
+static struct ccu_mux usb_ohci1_clk = {
+	.enable		= BIT(31),
+	.mux		= {
+		.shift		= 24,
+		.width		= 2,
+		.fixed_predivs	= usb_ohci_predivs,
+		.n_predivs	= ARRAY_SIZE(usb_ohci_predivs),
+	},
+	.common		= {
+		.reg		= 0x1308,
+		.features	= CCU_FEATURE_FIXED_PREDIV,
+		.hw.init	= CLK_HW_INIT_PARENTS_DATA("usb-ohci1", usb_ohci_parents,
+							   &ccu_mux_ops, 0),
+	},
+};
+
+static const struct clk_parent_data usb01_ref_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_MUX_DATA(usb01_ref_clk, "usb01-ref", usb01_ref_parents, 0x1340, 24, 3, 0);
+
+static SUNXI_CCU_MUX_DATA(usb2_u2_ref_clk, "usb2-u2-ref", usb01_ref_parents, 0x1348, 24, 3, 0);
+
+static const struct clk_parent_data usb2_suspend_parents[] = {
+	{ .fw_name = "losc" },
+	{ .hw = &sys_24M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_suspend_clk, "usb2-suspend", usb2_suspend_parents,
+				      0x1350,
+				      0, 5,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data usb2_mf_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_mf_clk, "usb2-mf", usb2_mf_parents,
+				      0x1354,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data usb2_u3_utmi_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_300M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_u3_utmi_clk, "usb2-u3-utmi", usb2_u3_utmi_parents,
+				      0x1360,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data usb2_u2_pipe_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(usb2_u2_pipe_clk, "usb2-u2-pipe", usb2_u2_pipe_parents,
+				      0x1364,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data pcie_aux_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(pcie_aux_clk, "pcie-aux", pcie_aux_parents, 0x1380,
+				      0, 5,	/* M */
+				      24, 1,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_hw *pcie_axi_slv_parents[] = {
+	&pll_periph0_600M_clk.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(pcie_axi_slv_clk, "pcie-axi-slv", pcie_axi_slv_parents, 0x1384,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *serdes_phy_parents[] = {
+	&sys_24M_clk.hw,
+	&pll_periph0_600M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(serdes_phy_clk, "serdes-phy", serdes_phy_parents, 0x13c0,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_parent_data gmac_ptp_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gmac_ptp_clk, "gmac-ptp", gmac_ptp_parents, 0x1400,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static SUNXI_CCU_M_HWS_WITH_GATE(gmac0_phy_clk, "gmac0-phy", pll_periph0_150M_hws, 0x1410,
+				 0, 5,		/* M */
+				 BIT(31),	/* gate */
+				 0);
+/* Undocumented, taken from the vendor kernel. */
+static SUNXI_CCU_M_HWS_WITH_GATE(gmac1_phy_clk, "gmac1-phy", pll_periph0_150M_hws, 0x1420,
+				 0, 5,		/* M */
+				 BIT(31),	/* gate */
+				 0);
+
+static const struct clk_hw *tcon_lcd_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_periph0_2x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_lcd_parents, 0x1500,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_lcd_parents, 0x1508,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+/* Undocumented, taken from the vendor kernel. */
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd2_clk, "tcon-lcd2", tcon_lcd_parents, 0x1510,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *dsi_parents[] = {
+	&sys_24M_clk.hw,
+	&pll_periph0_200M_clk.hw,
+	&pll_periph0_150M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi0_clk, "dsi0", dsi_parents, 0x1580,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi1_clk, "dsi1", dsi_parents, 0x1588,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *combphy_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_periph0_2x_clk.common.hw,
+	&pll_video0_3x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(combphy0_clk, "combphy0", combphy_parents, 0x15c0,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(combphy1_clk, "combphy1", combphy_parents, 0x15c4,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *edp_tv_parents[] = {
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+	&pll_video2_4x_clk.common.hw,
+	&pll_periph0_2x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_tv_clk, "edp-tv", edp_tv_parents, 0x1640,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k", pll_periph0_2x_hws, 0x1680,
+				      BIT(30),	/* gate */
+				      36621,	/* pre div */
+				      0);
+
+static const struct clk_parent_data hdmi_cec_parents[] = {
+	{ .fw_name = "losc" },
+	{ .hw = &hdmi_cec_32k_clk.common.hw },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_cec_clk, "hdmi-cec", hdmi_cec_parents, 0x1680,
+				    24, 1,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_parent_data hdmi_tv_parents[] = {
+	{ .hw = &pll_video0_4x_clk.common.hw },
+	{ .hw = &pll_video1_4x_clk.common.hw },
+	{ .hw = &pll_video2_4x_clk.common.hw },
+	{ .hw = &pll_periph0_2x_clk.common.hw },
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(hdmi_tv_clk, "hdmi-tv", hdmi_tv_parents, 0x1684,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data hdmi_sfr_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_sfr_clk, "hdmi-sfr", hdmi_sfr_parents, 0x1690,
+				    24, 1,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static SUNXI_CCU_GATE_HWS(hdcp_esm_clk, "hdcp-esm", pll_periph0_300M_hws, 0x1694, BIT(31), 0);
+
+static const struct clk_parent_data ledc_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_periph0_600M_clk.hw },
+	{ .fw_name = "hosc" },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ledc_parents, 0x1700,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static const struct clk_parent_data csi_master_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .hw = &pll_video0_4x_clk.common.hw },
+	{ .hw = &pll_video0_3x_clk.common.hw },
+	{ .hw = &pll_video1_4x_clk.common.hw },
+	{ .hw = &pll_video1_3x_clk.common.hw },
+	{ .hw = &pll_video2_4x_clk.common.hw },
+	{ .hw = &pll_video2_3x_clk.common.hw },
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master0_clk, "csi_master0", csi_master_parents, 0x1800,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master1_clk, "csi_master1", csi_master_parents, 0x1804,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+static SUNXI_CCU_DUALDIV_MUX_GATE(csi_master2_clk, "csi_master2", csi_master_parents, 0x1808,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 3,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_hw *csi_parents[] = {
+	&pll_video2_4x_clk.common.hw,
+	&pll_de_4x_clk.common.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_600M_clk.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_clk, "csi", csi_parents, 0x1840,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static const struct clk_hw *isp_parents[] = {
+	&pll_video2_4x_clk.common.hw,
+	&pll_periph0_480M_clk.common.hw,
+	&pll_periph0_400M_clk.hw,
+	&pll_periph0_600M_clk.hw,
+	&pll_video0_4x_clk.common.hw,
+	&pll_video1_4x_clk.common.hw,
+};
+static SUNXI_CCU_M_HW_WITH_MUX_GATE(isp_clk, "isp", isp_parents, 0x1860,
+				    0, 5,	/* M */
+				    24, 3,	/* mux */
+				    BIT(31),	/* gate */
+				    0);
+
+static SUNXI_CCU_GATE_DATA(res_dcap_24m_clk, "res-dcap-24m", hosc, 0x1a00, BIT(3), 0);
+
+static const struct clk_parent_data apb2jtag_parents[] = {
+	{ .hw = &sys_24M_clk.hw },
+	{ .fw_name = "losc" },
+	{ .fw_name = "iosc" },
+	{ .hw = &pll_periph0_480M_clk.common.hw },
+	{ .hw = &pll_periph1_480M_clk.common.hw },
+	{ .hw = &pll_periph0_200M_clk.hw },
+	{ .hw = &pll_periph1_200M_clk.hw },
+};
+static SUNXI_CCU_M_DATA_WITH_MUX_GATE(apb2jtag_clk, "apb2jtag", apb2jtag_parents, 0x1c00,
+				      0, 5,	/* M */
+				      24, 3,	/* mux */
+				      BIT(31),	/* gate */
+				      0);
+
+static SUNXI_CCU_GATE_HWS(fanout_24M_clk, "fanout-24M", sys_24M_hws, 0x1f30, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_12M_clk, "fanout-12M", sys_24M_hws, 0x1f30,
+				      BIT(1), 2, 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_16M_clk, "fanout-16M", pll_periph0_480M_hws, 0x1f30,
+				      BIT(2), 30, 0);
+static SUNXI_CCU_GATE_HWS_WITH_PREDIV(fanout_25M_clk, "fanout-25M", pll_periph0_2x_hws, 0x1f30,
+				      BIT(3), 48, 0);
+
+static const struct clk_parent_data fanout_27M_parents[] = {
+	{ .hw = &pll_video0_4x_clk.common.hw },
+	{ .hw = &pll_video1_4x_clk.common.hw },
+	{ .hw = &pll_video2_4x_clk.common.hw },
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(fanout_27M_clk, "fanout-27M", fanout_27M_parents, 0x1f34,
+				  0, 5,		/* M */
+				  8, 5,		/* N */
+				  24, 2,	/* mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data fanout_pclk_parents[] = {
+	{ .hw = &apb0_clk.common.hw }
+};
+static SUNXI_CCU_DUALDIV_MUX_GATE(fanout_pclk_clk, "fanout-pclk", fanout_pclk_parents, 0x1f38,
+				  0, 5,		/* M */
+				  5, 5,		/* N */
+				  0, 0,		/* no mux */
+				  BIT(31),	/* gate */
+				  0);
+
+static const struct clk_parent_data fanout_parents[] = {
+	{ .fw_name = "losc-fanout" },
+	{ .hw = &fanout_12M_clk.common.hw, },
+	{ .hw = &fanout_16M_clk.common.hw, },
+	{ .hw = &fanout_24M_clk.common.hw, },
+	{ .hw = &fanout_25M_clk.common.hw, },
+	{ .hw = &fanout_27M_clk.common.hw, },
+	{ .hw = &fanout_pclk_clk.common.hw, },
+};
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout0_clk, "fanout0", fanout_parents, 0x1f3c,
+				    0, 3,	/* mux */
+				    BIT(21),	/* gate */
+				    0);
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout1_clk, "fanout1", fanout_parents, 0x1f3c,
+				    3, 3,	/* mux */
+				    BIT(22),	/* gate */
+				    0);
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout2_clk, "fanout2", fanout_parents, 0x1f3c,
+				    6, 3,	/* mux */
+				    BIT(23),	/* gate */
+				    0);
+static SUNXI_CCU_MUX_DATA_WITH_GATE(fanout3_clk, "fanout3", fanout_parents, 0x1f3c,
+				    9, 3,	/* mux */
+				    BIT(24),	/* gate */
+				    0);
+
 /*
  * Contains all clocks that are controlled by a hardware register. They
  * have a (sunxi) .common member, which needs to be initialised by the common
@@ -531,6 +1444,101 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&apb_uart_clk.common,
 	&trace_clk.common,
 	&mbus_clk.common,
+	&timer0_clk.common,
+	&timer1_clk.common,
+	&timer2_clk.common,
+	&timer3_clk.common,
+	&timer4_clk.common,
+	&timer5_clk.common,
+	&timer6_clk.common,
+	&timer7_clk.common,
+	&timer8_clk.common,
+	&timer9_clk.common,
+	&avs_clk.common,
+	&de0_clk.common,
+	&di_clk.common,
+	&g2d_clk.common,
+	&eink_clk.common,
+	&eink_panel_clk.common,
+	&ve_enc0_clk.common,
+	&ve_dec0_clk.common,
+	&ce_clk.common,
+	&npu_clk.common,
+	&gpu0_clk.common,
+	&dram0_clk.common,
+	&nand0_clk0_clk.common,
+	&nand0_clk1_clk.common,
+	&mmc0_clk.common,
+	&mmc1_clk.common,
+	&mmc2_clk.common,
+	&mmc3_clk.common,
+	&ufs_axi_clk.common,
+	&ufs_cfg_clk.common,
+	&spi0_clk.common,
+	&spi1_clk.common,
+	&spi2_clk.common,
+	&spif_clk.common,
+	&spi3_clk.common,
+	&spi4_clk.common,
+	&gpadc0_24m_clk.common,
+	&irrx_clk.common,
+	&irtx_clk.common,
+	&sgpio_clk.common,
+	&lpc_clk.common,
+	&i2spcm0_clk.common,
+	&i2spcm1_clk.common,
+	&i2spcm2_clk.common,
+	&i2spcm2_asrc_clk.common,
+	&i2spcm3_clk.common,
+	&i2spcm4_clk.common,
+	&spdif_tx_clk.common,
+	&spdif_rx_clk.common,
+	&dmic_clk.common,
+	&usb_ohci0_clk.common,
+	&usb_ohci1_clk.common,
+	&usb01_ref_clk.common,
+	&usb2_u2_ref_clk.common,
+	&usb2_suspend_clk.common,
+	&usb2_mf_clk.common,
+	&usb2_u3_utmi_clk.common,
+	&usb2_u2_pipe_clk.common,
+	&pcie_aux_clk.common,
+	&pcie_axi_slv_clk.common,
+	&serdes_phy_clk.common,
+	&gmac_ptp_clk.common,
+	&gmac0_phy_clk.common,
+	&gmac1_phy_clk.common,
+	&tcon_lcd0_clk.common,
+	&tcon_lcd1_clk.common,
+	&tcon_lcd2_clk.common,
+	&dsi0_clk.common,
+	&dsi1_clk.common,
+	&combphy0_clk.common,
+	&combphy1_clk.common,
+	&edp_tv_clk.common,
+	&hdmi_cec_32k_clk.common,
+	&hdmi_cec_clk.common,
+	&hdmi_tv_clk.common,
+	&hdmi_sfr_clk.common,
+	&hdcp_esm_clk.common,
+	&ledc_clk.common,
+	&csi_master0_clk.common,
+	&csi_master1_clk.common,
+	&csi_master2_clk.common,
+	&csi_clk.common,
+	&isp_clk.common,
+	&res_dcap_24m_clk.common,
+	&apb2jtag_clk.common,
+	&fanout_24M_clk.common,
+	&fanout_12M_clk.common,
+	&fanout_16M_clk.common,
+	&fanout_25M_clk.common,
+	&fanout_27M_clk.common,
+	&fanout_pclk_clk.common,
+	&fanout0_clk.common,
+	&fanout1_clk.common,
+	&fanout2_clk.common,
+	&fanout3_clk.common,
 };
 
 static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
@@ -584,6 +1592,101 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_APB_UART]		= &apb_uart_clk.common.hw,
 		[CLK_TRACE]		= &trace_clk.common.hw,
 		[CLK_MBUS]		= &mbus_clk.common.hw,
+		[CLK_TIMER0]		= &timer0_clk.common.hw,
+		[CLK_TIMER1]		= &timer1_clk.common.hw,
+		[CLK_TIMER2]		= &timer2_clk.common.hw,
+		[CLK_TIMER3]		= &timer3_clk.common.hw,
+		[CLK_TIMER4]		= &timer4_clk.common.hw,
+		[CLK_TIMER5]		= &timer5_clk.common.hw,
+		[CLK_TIMER6]		= &timer6_clk.common.hw,
+		[CLK_TIMER7]		= &timer7_clk.common.hw,
+		[CLK_TIMER8]		= &timer8_clk.common.hw,
+		[CLK_TIMER9]		= &timer9_clk.common.hw,
+		[CLK_AVS]		= &avs_clk.common.hw,
+		[CLK_DE0]		= &de0_clk.common.hw,
+		[CLK_DI]		= &di_clk.common.hw,
+		[CLK_G2D]		= &g2d_clk.common.hw,
+		[CLK_EINK]		= &eink_clk.common.hw,
+		[CLK_EINK_PANEL]	= &eink_panel_clk.common.hw,
+		[CLK_VE_ENC0]		= &ve_enc0_clk.common.hw,
+		[CLK_VE_DEC0]		= &ve_dec0_clk.common.hw,
+		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_NPU]		= &npu_clk.common.hw,
+		[CLK_GPU0]		= &gpu0_clk.common.hw,
+		[CLK_DRAM0]		= &dram0_clk.common.hw,
+		[CLK_NAND0_CLK0]	= &nand0_clk0_clk.common.hw,
+		[CLK_NAND0_CLK1]	= &nand0_clk1_clk.common.hw,
+		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_MMC3]		= &mmc3_clk.common.hw,
+		[CLK_UFS_AXI]		= &ufs_axi_clk.common.hw,
+		[CLK_UFS_CFG]		= &ufs_cfg_clk.common.hw,
+		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_SPI2]		= &spi2_clk.common.hw,
+		[CLK_SPIF]		= &spif_clk.common.hw,
+		[CLK_SPI3]		= &spi3_clk.common.hw,
+		[CLK_SPI4]		= &spi4_clk.common.hw,
+		[CLK_GPADC0_24M]	= &gpadc0_24m_clk.common.hw,
+		[CLK_IRRX]		= &irrx_clk.common.hw,
+		[CLK_IRTX]		= &irtx_clk.common.hw,
+		[CLK_SGPIO]		= &sgpio_clk.common.hw,
+		[CLK_LPC]		= &lpc_clk.common.hw,
+		[CLK_I2SPCM0]		= &i2spcm0_clk.common.hw,
+		[CLK_I2SPCM1]		= &i2spcm1_clk.common.hw,
+		[CLK_I2SPCM2]		= &i2spcm2_clk.common.hw,
+		[CLK_I2SPCM2_ASRC]	= &i2spcm2_asrc_clk.common.hw,
+		[CLK_I2SPCM3]		= &i2spcm3_clk.common.hw,
+		[CLK_I2SPCM4]		= &i2spcm4_clk.common.hw,
+		[CLK_SPDIF_TX]		= &spdif_tx_clk.common.hw,
+		[CLK_SPDIF_RX]		= &spdif_rx_clk.common.hw,
+		[CLK_DMIC]		= &dmic_clk.common.hw,
+		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_USB01_REF]		= &usb01_ref_clk.common.hw,
+		[CLK_USB2_U2_REF]	= &usb2_u2_ref_clk.common.hw,
+		[CLK_USB2_SUSPEND]	= &usb2_suspend_clk.common.hw,
+		[CLK_USB2_MF]		= &usb2_mf_clk.common.hw,
+		[CLK_USB2_U3_UTMI]	= &usb2_u3_utmi_clk.common.hw,
+		[CLK_USB2_U2_PIPE]	= &usb2_u2_pipe_clk.common.hw,
+		[CLK_PCIE_AUX]		= &pcie_aux_clk.common.hw,
+		[CLK_PCIE_AXI_SLV]	= &pcie_axi_slv_clk.common.hw,
+		[CLK_SERDES_PHY]	= &serdes_phy_clk.common.hw,
+		[CLK_GMAC_PTP]		= &gmac_ptp_clk.common.hw,
+		[CLK_GMAC0_PHY]		= &gmac0_phy_clk.common.hw,
+		[CLK_GMAC1_PHY]		= &gmac1_phy_clk.common.hw,
+		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
+		[CLK_TCON_LCD1]		= &tcon_lcd1_clk.common.hw,
+		[CLK_TCON_LCD2]		= &tcon_lcd2_clk.common.hw,
+		[CLK_DSI0]		= &dsi0_clk.common.hw,
+		[CLK_DSI1]		= &dsi1_clk.common.hw,
+		[CLK_COMBPHY0]		= &combphy0_clk.common.hw,
+		[CLK_COMBPHY1]		= &combphy1_clk.common.hw,
+		[CLK_EDP_TV]		= &edp_tv_clk.common.hw,
+		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
+		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
+		[CLK_HDMI_TV]		= &hdmi_tv_clk.common.hw,
+		[CLK_HDMI_SFR]		= &hdmi_sfr_clk.common.hw,
+		[CLK_HDCP_ESM]		= &hdcp_esm_clk.common.hw,
+		[CLK_LEDC]		= &ledc_clk.common.hw,
+		[CLK_CSI_MASTER0]	= &csi_master0_clk.common.hw,
+		[CLK_CSI_MASTER1]	= &csi_master1_clk.common.hw,
+		[CLK_CSI_MASTER2]	= &csi_master2_clk.common.hw,
+		[CLK_CSI]		= &csi_clk.common.hw,
+		[CLK_ISP]		= &isp_clk.common.hw,
+		[CLK_RES_DCAP_24M]	= &res_dcap_24m_clk.common.hw,
+		[CLK_APB2JTAG]		= &apb2jtag_clk.common.hw,
+		[CLK_FANOUT_24M]	= &fanout_24M_clk.common.hw,
+		[CLK_FANOUT_12M]	= &fanout_12M_clk.common.hw,
+		[CLK_FANOUT_16M]	= &fanout_16M_clk.common.hw,
+		[CLK_FANOUT_25M]	= &fanout_25M_clk.common.hw,
+		[CLK_FANOUT_27M]	= &fanout_27M_clk.common.hw,
+		[CLK_FANOUT_PCLK]	= &fanout_pclk_clk.common.hw,
+		[CLK_FANOUT0]		= &fanout0_clk.common.hw,
+		[CLK_FANOUT1]		= &fanout1_clk.common.hw,
+		[CLK_FANOUT2]		= &fanout2_clk.common.hw,
+		[CLK_FANOUT3]		= &fanout3_clk.common.hw,
 	},
 	.num	= CLK_FANOUT3 + 1,
 };

-- 
2.55.0

