Received: from sender5-op-o15.zoho.com (sender5-op-o15.zoho.com [165.173.182.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB614BF95A;
	Mon, 21 Sep 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005256; cv=pass; b=mxXqYBPOiznYG1VYMBwtUpbOERkGFlWY9t4+lcndMSx4B7ii5Eq6WkH4ehHxCMoHiiinD5lXqzMCwkpmGPHQq11xG85jsZohSngg4E/76uy41mcA8vyn4d4Z0uW5VvXrW6z6BNzZM0Qojt/RsDcYsScUCoYRrH7i3UmBo+dKbsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005256; c=relaxed/simple;
	bh=1B26cvPj3ghj8ZS0iUrdMPGL0YKkOM62MGMMTrXCAhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSeixuyPeXZOf4uuFc7lowYypQTXpmRlCshDkA0/hNBXEPdK56yyUGihzd1jm+Tc+3ZO0uc/lLNEZvXGJBR/Ney0Qzd7hwywystn2l4ie0v9ewpwdJQiA3YcF9WD8GrJBm1cbHLsIkeOEWMrjMXbTHboSua8/DYZ1vKc7nRzud0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=RZhsLrzE; arc=pass smtp.client-ip=165.173.182.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="RZhsLrzE"
ARC-Seal: i=1; a=rsa-sha256; t=1790005211; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U4QMPSmr9KBF9D18GlrwqGZz5Ixf0515RWFIx2eR1kRbA1l4JllKhM8IW45ciOeAsgGKR1yCJ2eslTX3qIlafxC5Ey3sGokhwjrB66sp6ehh5ajj+DRfR5gQhruqNlRabTLWVs8SUr2/Yonx7mgJOIZGB3eOrkhdrnCvfs1Dqfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790005211; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rnG7DH2z04pXtf0d6lSdVIAwqeOLDji7ieglm8Enang=; 
	b=REj62swNpa/4cjN1uirCw2Pi/RgfDtwIwKhTVZenAmY6BWLuxRWc3DrhQlpM9udPRLHlG0pGk5vzvTCoTthaYMleUF8swqqhb0oNFGogQ7lj8MOFyF8KdWc3UTWTJiYaHK7+2gMdQsk16kQx/dmJnOWmxhTQFwDllMHmccKzMyE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005211;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=rnG7DH2z04pXtf0d6lSdVIAwqeOLDji7ieglm8Enang=;
	b=RZhsLrzEYxGWosqEqTeEalaVzgJSHmcKPwSG6YN8gHR8Q+nYyFnv4kblBhMdH8Vo
	4EMoZ7mW7iI6zSeE5dYDWG6aSYVjvLlurRqUYy0f+Z4XqeLoDg0c8+FAEOgYmvgOufT
	9FeoAiQVo21ThV48wT/Y0svtfHA6O1yBY0KsF4Tg=
Received: by smtp.zohomail.com with SMTPS id 1790005208556421.55463950010824;
	Mon, 21 Sep 2026 08:40:08 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Date: Mon, 21 Sep 2026 23:38:05 +0800
Subject: [PATCH v4 7/8] clk: sunxi-ng: a733: Add bus clock gates
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-a733-clk-v4-7-9c184ebe9ac1@pigmoral.tech>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=43739;
 i=junhui.liu@pigmoral.tech; h=from:subject:message-id;
 bh=1B26cvPj3ghj8ZS0iUrdMPGL0YKkOM62MGMMTrXCAhI=;
 b=owGbwMvMwCWWvDb1VEXc8j+Mp9WSGLI2+jeE9y9ut5t2jfUqH7eUfXqk582lejXfzrcpenft2
 bbx75qZHaUsDGJcDLJiiixc/uL/rHV4vh0RaL0PM4eVCWQIAxenAExk3juG/+nXetSsf3xMat+a
 v0bRdXkAu9WPhI1/b5m+vf/20ctn+6IZ/koayi3p26yzZ0fI4yPHZn6YajTV8fW/aZ5zl/KecXf
 co8sNAA==
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=openpgp;
 fpr=15B30CC69C4BF0CC3C08F85A2A90CDC122DF37BF
X-ZohoMailClient: External

Add the bus clock gates that control access to the devices' register
interface on the Allwinner A733 SoC. These clocks are typically
single-bit controls in the BGR registers, covering UARTs, SPI, I2C, and
various multimedia engines. It also includes bus gates for system
components like the IOMMU and MSI-lite interfaces.

Also mark ahb-store and mbus-store clocks as critical, since disabling
either gate breaks access to boot/storage devices such as MMC and SPI
NOR when unused clocks are disabled.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
---
 drivers/clk/sunxi-ng/ccu-sun60i-a733.c | 492 ++++++++++++++++++++++++++++++++-
 1 file changed, 491 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
index 37e5fe1b327c..1543c2d3f305 100644
--- a/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
+++ b/drivers/clk/sunxi-ng/ccu-sun60i-a733.c
@@ -4,6 +4,10 @@
  * Copyright (C) 2026 Junhui Liu <junhui.liu@pigmoral.tech>
  * Based on the A523 CCU driver:
  *   Copyright (C) 2023-2024 Arm Ltd.
+ *
+ * TODO: The real parents of some bus gates, including its-pcie0-aclk,
+ * msi-lite, npu, ufs, sgpio, lpc and i2spcm, are not documented in the
+ * manual. For now, follow the vendor BSP, which keeps them on hosc.
  */
 
 #include <linux/clk-provider.h>
@@ -447,16 +451,19 @@ static SUNXI_CCU_M_DATA_WITH_MUX(ahb_clk, "ahb", ahb_apb_parents, 0x500,
 				 0, 5,		/* M */
 				 24, 2,		/* mux */
 				 0);
+static const struct clk_hw *ahb_hws[] = { &ahb_clk.common.hw };
 
 static SUNXI_CCU_M_DATA_WITH_MUX(apb0_clk, "apb0", ahb_apb_parents, 0x510,
 				 0, 5,		/* M */
 				 24, 2,		/* mux */
 				 0);
+static const struct clk_hw *apb0_hws[] = { &apb0_clk.common.hw };
 
 static SUNXI_CCU_M_DATA_WITH_MUX(apb1_clk, "apb1", ahb_apb_parents, 0x518,
 				 0, 5,		/* M */
 				 24, 2,		/* mux */
 				 0);
+static const struct clk_hw *apb1_hws[] = { &apb1_clk.common.hw };
 
 static const struct clk_parent_data apb_uart_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -469,6 +476,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX(apb_uart_clk, "apb-uart", apb_uart_parents, 0x5
 				 0, 5,		/* M */
 				 24, 3,		/* mux */
 				 0);
+static const struct clk_hw *apb_uart_hws[] = {
+	&apb_uart_clk.common.hw
+};
 
 static const struct clk_parent_data trace_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -483,6 +493,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(trace_clk, "trace", trace_parents, 0x540,
 				 BIT(31),	/* gate */
 				 0);
 
+static SUNXI_CCU_GATE_DATA(bus_its_pcie0_aclk_clk, "bus-its-pcie0-aclk", hosc, 0x574, BIT(1), 0);
+
 static const struct clk_parent_data mbus_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
 	{ .hw = &pll_periph1_600M_clk.hw },
@@ -497,9 +509,118 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(mbus_clk, "mbus", mbus_parents, 0x588
 					   BIT(31),	/* gate */
 					   CLK_IS_CRITICAL,
 					   CCU_FEATURE_UPDATE_BIT);
+static const struct clk_hw *mbus_hws[] = { &mbus_clk.common.hw };
+
+static SUNXI_CCU_GATE_HWS(mbus_iommu0_sys_clk, "mbus-iommu0-sys", mbus_hws, 0x58c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(apb_iommu0_sys_clk, "apb-iommu0-sys", apb0_hws, 0x58c, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(ahb_iommu0_sys_clk, "ahb-iommu0-sys", ahb_hws, 0x58c, BIT(2), 0);
+
+static SUNXI_CCU_GATE_DATA(bus_msi_lite0_clk, "bus-msi-lite0", hosc, 0x594, BIT(0), 0);
+static SUNXI_CCU_GATE_DATA(bus_msi_lite1_clk, "bus-msi-lite1", hosc, 0x59c, BIT(0), 0);
+static SUNXI_CCU_GATE_DATA(bus_msi_lite2_clk, "bus-msi-lite2", hosc, 0x5a4, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(mbus_iommu1_sys_clk, "mbus-iommu1-sys", mbus_hws, 0x5b4, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(apb_iommu1_sys_clk, "apb-iommu1-sys", apb0_hws, 0x5b4, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(ahb_iommu1_sys_clk, "ahb-iommu1-sys", ahb_hws, 0x5b4, BIT(2), 0);
+
+static SUNXI_CCU_GATE_HWS(ahb_ve_dec_clk, "ahb-ve-dec", ahb_hws,
+			  0x5c0, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(ahb_ve_enc_clk, "ahb-ve-enc", ahb_hws,
+			  0x5c0, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(ahb_vid_in_clk, "ahb-vid-in", ahb_hws,
+			  0x5c0, BIT(2), 0);
+static SUNXI_CCU_GATE_HWS(ahb_vid_cout0_clk, "ahb-vid-cout0", ahb_hws,
+			  0x5c0, BIT(3), 0);
+static SUNXI_CCU_GATE_HWS(ahb_vid_cout1_clk, "ahb-vid-cout1", ahb_hws,
+			  0x5c0, BIT(4), 0);
+static SUNXI_CCU_GATE_HWS(ahb_de_clk, "ahb-de", ahb_hws,
+			  0x5c0, BIT(5), 0);
+static SUNXI_CCU_GATE_HWS(ahb_npu_clk, "ahb-npu", ahb_hws,
+			  0x5c0, BIT(6), 0);
+static SUNXI_CCU_GATE_HWS(ahb_gpu0_clk, "ahb-gpu0", ahb_hws,
+			  0x5c0, BIT(7), 0);
+static SUNXI_CCU_GATE_HWS(ahb_serdes_clk, "ahb-serdes", ahb_hws,
+			  0x5c0, BIT(8), 0);
+static SUNXI_CCU_GATE_HWS(ahb_usb_sys_clk, "ahb-usb-sys", ahb_hws,
+			  0x5c0, BIT(9), 0);
+static SUNXI_CCU_GATE_HWS(ahb_msi_lite0_clk, "ahb-msi-lite0", ahb_hws,
+			  0x5c0, BIT(16), 0);
+static SUNXI_CCU_GATE_HWS(ahb_store_clk, "ahb-store", ahb_hws,
+			  0x5c0, BIT(24), CLK_IS_CRITICAL);
+static SUNXI_CCU_GATE_HWS(ahb_cpus_clk, "ahb-cpus", ahb_hws,
+			  0x5c0, BIT(28), 0);
+
+static SUNXI_CCU_GATE_HWS(mbus_iommu0_clk, "mbus-iommu0", mbus_hws,
+			  0x5e0, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(mbus_iommu1_clk, "mbus-iommu1", mbus_hws,
+			  0x5e0, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(mbus_desys_clk, "mbus-desys", mbus_hws,
+			  0x5e0, BIT(11), 0);
+static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_gate_clk, "mbus-ve-enc0-gate", mbus_hws,
+			  0x5e0, BIT(12), 0);
+static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_gate_clk, "mbus-ve-dec0-gate", mbus_hws,
+			  0x5e0, BIT(14), 0);
+static SUNXI_CCU_GATE_HWS(mbus_gpu0_clk, "mbus-gpu0", mbus_hws,
+			  0x5e0, BIT(16), 0);
+static SUNXI_CCU_GATE_HWS(mbus_npu_clk, "mbus-npu", mbus_hws,
+			  0x5e0, BIT(18), 0);
+static SUNXI_CCU_GATE_HWS(mbus_vid_in_clk, "mbus-vid-in", mbus_hws,
+			  0x5e0, BIT(24), 0);
+static SUNXI_CCU_GATE_HWS(mbus_serdes_clk, "mbus-serdes", mbus_hws,
+			  0x5e0, BIT(28), 0);
+static SUNXI_CCU_GATE_HWS(mbus_msi_lite0_clk, "mbus-msi-lite0", mbus_hws,
+			  0x5e0, BIT(29), 0);
+static SUNXI_CCU_GATE_HWS(mbus_store_clk, "mbus-store", mbus_hws,
+			  0x5e0, BIT(30), CLK_IS_CRITICAL);
+static SUNXI_CCU_GATE_HWS(mbus_msi_lite2_clk, "mbus-msi-lite2", mbus_hws,
+			  0x5e0, BIT(31), 0);
+
+static SUNXI_CCU_GATE_HWS(mbus_dma0_clk, "mbus-dma0", mbus_hws,
+			  0x5e4, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(mbus_ve_enc0_clk, "mbus-ve-enc0", mbus_hws,
+			  0x5e4, BIT(1), 0);
+static SUNXI_CCU_GATE_HWS(mbus_ce_clk, "mbus-ce", mbus_hws,
+			  0x5e4, BIT(2), 0);
+static SUNXI_CCU_GATE_HWS(mbus_dma1_clk, "mbus-dma1", mbus_hws,
+			  0x5e4, BIT(3), 0);
+static SUNXI_CCU_GATE_HWS(mbus_nand_clk, "mbus-nand", mbus_hws,
+			  0x5e4, BIT(5), 0);
+static SUNXI_CCU_GATE_HWS(mbus_csi_clk, "mbus-csi", mbus_hws,
+			  0x5e4, BIT(8), 0);
+static SUNXI_CCU_GATE_HWS(mbus_isp_clk, "mbus-isp", mbus_hws,
+			  0x5e4, BIT(9), 0);
+static SUNXI_CCU_GATE_HWS(mbus_gmac0_clk, "mbus-gmac0", mbus_hws,
+			  0x5e4, BIT(11), 0);
+/* Undocumented, taken from the vendor kernel. */
+static SUNXI_CCU_GATE_HWS(mbus_gmac1_clk, "mbus-gmac1", mbus_hws,
+			  0x5e4, BIT(12), 0);
+static SUNXI_CCU_GATE_HWS(mbus_ve_dec0_clk, "mbus-ve-dec0", mbus_hws,
+			  0x5e4, BIT(18), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_dma0_clk, "bus-dma0", ahb_hws,
+			  0x704, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_dma1_clk, "bus-dma1", ahb_hws,
+			  0x70c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_spinlock_clk, "bus-spinlock", ahb_hws,
+			  0x724, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_msgbox0_clk, "bus-msgbox0", ahb_hws,
+			  0x744, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_pwm0_clk, "bus-pwm0", apb0_hws,
+			  0x784, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_pwm1_clk, "bus-pwm1", apb0_hws,
+			  0x78c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_dbg_clk, "bus-dbg", sys_24M_hws,
+			  0x7a4, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_sysdap_clk, "bus-sysdap", apb1_hws,
+			  0x7ac, BIT(0), 0);
 
 /**************************************************************************
- *                          mod clocks                                    *
+ *                          mod clocks with gates                         *
  **************************************************************************/
 
 static const struct clk_parent_data timer_parents[] = {
@@ -559,6 +680,7 @@ static SUNXI_CCU_P_DATA_WITH_MUX_GATE(timer9_clk, "timer9", timer_parents, 0x824
 				      24, 3,		/* mux */
 				      BIT(31),		/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_timer_clk, "bus-timer", ahb_hws, 0x850, BIT(0), 0);
 
 /* Undocumented, taken from the vendor kernel. */
 static const struct clk_parent_data avs_parents[] = {
@@ -584,6 +706,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(de0_clk, "de0", de_parents, 0xa00,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE_HWS(bus_de0_clk, "bus-de0", ahb_hws, 0xa04, BIT(0), 0);
 
 static const struct clk_hw *di_parents[] = {
 	&pll_periph0_600M_clk.hw,
@@ -597,6 +720,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(di_clk, "di", di_parents, 0xa20,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE_HWS(bus_di_clk, "bus-di", ahb_hws, 0xa24, BIT(0), 0);
 
 static const struct clk_hw *g2d_parents[] = {
 	&pll_periph0_400M_clk.hw,
@@ -609,6 +733,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(g2d_clk, "g2d", g2d_parents, 0xa40,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE_HWS(bus_g2d_clk, "bus-g2d", ahb_hws, 0xa44, BIT(0), 0);
 
 static const struct clk_hw *eink_parents[] = {
 	&pll_periph0_480M_clk.common.hw,
@@ -632,6 +757,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(eink_panel_clk, "eink-panel", eink_panel_par
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
+static SUNXI_CCU_GATE_HWS(bus_eink_clk, "bus-eink", ahb_hws, 0xa6c, BIT(0), 0);
 
 static const struct clk_hw *ve_enc_parents[] = {
 	&pll_ve0_clk.common.hw,
@@ -663,6 +789,9 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ve_dec0_clk, "ve-dec0", ve_dec_parents, 0xa8
 				    BIT(31),	/* gate */
 				    CLK_SET_RATE_PARENT);
 
+static SUNXI_CCU_GATE_HWS(bus_ve_enc0_clk, "bus-ve-enc0", ahb_hws, 0xa8c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_ve_dec0_clk, "bus-ve-dec0", ahb_hws, 0xa8c, BIT(2), 0);
+
 static const struct clk_hw *ce_parents[] = {
 	&sys_24M_clk.hw,
 	&pll_periph0_400M_clk.hw,
@@ -673,6 +802,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(ce_clk, "ce", ce_parents, 0xac0,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_ce_clk, "bus-ce", ahb_hws, 0xac4, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_ce_sys_clk, "bus-ce-sys", ahb_hws, 0xac4, BIT(1), 0);
 
 static const struct clk_hw *npu_parents[] = {
 	&pll_npu_clk.common.hw,
@@ -688,6 +819,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(npu_clk, "npu", npu_parents, 0xb00,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_DATA(bus_npu_clk, "bus-npu", hosc, 0xb04, BIT(0), 0);
 
 /*
  * GPU_CLK = ClockSource * ((16 - M) / 16)
@@ -720,6 +852,7 @@ static struct ccu_div gpu0_clk = {
 							   &ccu_div_ops, 0),
 	}
 };
+static SUNXI_CCU_GATE_HWS(bus_gpu0_clk, "bus-gpu0", ahb_hws, 0xb24, BIT(0), 0);
 
 static const struct clk_parent_data dram_parents[] = {
 	{ .hw = &pll_ddr_clk.common.hw, },
@@ -734,6 +867,8 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE_FEAT(dram0_clk, "dram0", dram_parents, 0xc
 					   BIT(31),	/* gate */
 					   CLK_IS_CRITICAL,
 					   CCU_FEATURE_UPDATE_BIT);
+static SUNXI_CCU_GATE_HWS(bus_dram0_clk, "bus-dram0", ahb_hws, 0xc0c,
+			  BIT(0), CLK_IS_CRITICAL);
 
 static const struct clk_parent_data nand_mmc_parents[] = {
 	{ .hw = &sys_24M_clk.hw, },
@@ -752,6 +887,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(nand0_clk1_clk, "nand0-clk1", nand_mmc_par
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_nand0_clk, "bus-nand0", ahb_hws, 0xc8c, BIT(0), 0);
 
 static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc0_clk, "mmc0", nand_mmc_parents, 0xd00,
 					     0, 5,	/* M */
@@ -760,6 +896,8 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc0_clk, "mmc0", nand_mmc_parents,
 					     BIT(31),	/* gate */
 					     2,		/* post div */
 					     0);
+static SUNXI_CCU_GATE_HWS(bus_mmc0_clk, "bus-mmc0", ahb_hws, 0xd0c, BIT(0), 0);
+
 static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc1_clk, "mmc1", nand_mmc_parents, 0xd10,
 					     0, 5,	/* M */
 					     8, 5,	/* P */
@@ -767,6 +905,7 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc1_clk, "mmc1", nand_mmc_parents,
 					     BIT(31),	/* gate */
 					     2,		/* post div */
 					     0);
+static SUNXI_CCU_GATE_HWS(bus_mmc1_clk, "bus-mmc1", ahb_hws, 0xd1c, BIT(0), 0);
 
 static const struct clk_parent_data mmc2_mmc3_parents[] = {
 	{ .hw = &sys_24M_clk.hw, },
@@ -782,6 +921,8 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc2_clk, "mmc2", mmc2_mmc3_parents
 					     BIT(31),	/* gate */
 					     2,		/* post div */
 					     0);
+static SUNXI_CCU_GATE_HWS(bus_mmc2_clk, "bus-mmc2", ahb_hws, 0xd2c, BIT(0), 0);
+
 static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc3_clk, "mmc3", mmc2_mmc3_parents, 0xd30,
 					     0, 5,	/* M */
 					     8, 5,	/* P */
@@ -789,6 +930,7 @@ static SUNXI_CCU_MP_MUX_GATE_POSTDIV_DUALDIV(mmc3_clk, "mmc3", mmc2_mmc3_parents
 					     BIT(31),	/* gate */
 					     2,		/* post div */
 					     0);
+static SUNXI_CCU_GATE_HWS(bus_mmc3_clk, "bus-mmc3", ahb_hws, 0xd3c, BIT(0), 0);
 
 static const struct clk_hw *ufs_axi_parents[] = {
 	&pll_periph0_300M_clk.hw,
@@ -809,6 +951,29 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ufs_cfg_clk, "ufs-cfg", ufs_cfg_parents, 0
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_DATA(bus_ufs_clk, "bus-ufs", hosc, 0xd8c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_uart0_clk, "bus-uart0", apb_uart_hws, 0xe00, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart1_clk, "bus-uart1", apb_uart_hws, 0xe04, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart2_clk, "bus-uart2", apb_uart_hws, 0xe08, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart3_clk, "bus-uart3", apb_uart_hws, 0xe0c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart4_clk, "bus-uart4", apb_uart_hws, 0xe10, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart5_clk, "bus-uart5", apb_uart_hws, 0xe14, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_uart6_clk, "bus-uart6", apb_uart_hws, 0xe18, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_i2c0_clk, "bus-i2c0", apb1_hws, 0xe80, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c1_clk, "bus-i2c1", apb1_hws, 0xe84, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c2_clk, "bus-i2c2", apb1_hws, 0xe88, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c3_clk, "bus-i2c3", apb1_hws, 0xe8c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c4_clk, "bus-i2c4", apb1_hws, 0xe90, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c5_clk, "bus-i2c5", apb1_hws, 0xe94, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c6_clk, "bus-i2c6", apb1_hws, 0xe98, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c7_clk, "bus-i2c7", apb1_hws, 0xe9c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c8_clk, "bus-i2c8", apb1_hws, 0xea0, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c9_clk, "bus-i2c9", apb1_hws, 0xea4, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c10_clk, "bus-i2c10", apb1_hws, 0xea8, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c11_clk, "bus-i2c11", apb1_hws, 0xeac, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_i2c12_clk, "bus-i2c12", apb1_hws, 0xeb0, BIT(0), 0);
 
 static const struct clk_parent_data spi_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -826,18 +991,23 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(spi0_clk, "spi0", spi_parents, 0xf00,
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_spi0_clk, "bus-spi0", ahb_hws, 0xf04, BIT(0), 0);
+
 static SUNXI_CCU_DUALDIV_MUX_GATE(spi1_clk, "spi1", spi_parents, 0xf08,
 				  0, 5,		/* M */
 				  8, 5,		/* N */
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_spi1_clk, "bus-spi1", ahb_hws, 0xf0c, BIT(0), 0);
+
 static SUNXI_CCU_DUALDIV_MUX_GATE(spi2_clk, "spi2", spi_parents, 0xf10,
 				  0, 5,		/* M */
 				  8, 5,		/* N */
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_spi2_clk, "bus-spi2", ahb_hws, 0xf14, BIT(0), 0);
 
 static const struct clk_parent_data spif_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -855,12 +1025,16 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(spif_clk, "spif", spif_parents, 0xf18,
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_spif_clk, "bus-spif", ahb_hws, 0xf1c, BIT(0), 0);
+
 static SUNXI_CCU_DUALDIV_MUX_GATE(spi3_clk, "spi3", spi_parents, 0xf20,
 				  0, 5,		/* M */
 				  8, 5,		/* N */
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_spi3_clk, "bus-spi3", ahb_hws, 0xf24, BIT(0), 0);
+
 /* Undocumented, taken from the vendor kernel. */
 static SUNXI_CCU_DUALDIV_MUX_GATE(spi4_clk, "spi4", spi_parents, 0xf28,
 				  0, 5,		/* M */
@@ -868,6 +1042,7 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(spi4_clk, "spi4", spi_parents, 0xf28,
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_spi4_clk, "bus-spi4", ahb_hws, 0xf2c, BIT(0), 0);
 
 static const struct clk_parent_data gpadc0_24m_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -878,6 +1053,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(gpadc0_24m_clk, "gpadc0-24m", gpadc0_24m_p
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_gpadc0_clk, "bus-gpadc0", ahb_hws, 0xfc4, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_ths0_clk, "bus-ths0", apb0_hws, 0xfe4, BIT(0), 0);
 
 static const struct clk_parent_data irrx_parents[] = {
 	{ .fw_name = "losc"},
@@ -889,6 +1067,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irrx_clk, "irrx", irrx_parents, 0x1000,
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_irrx_clk, "bus-irrx", apb0_hws, 0x1004, BIT(0), 0);
 
 static const struct clk_parent_data irtx_parents[] = {
 	{ .fw_name = "losc"},
@@ -900,6 +1079,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(irtx_clk, "irtx", irtx_parents, 0x1008,
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_irtx_clk, "bus-irtx", apb0_hws, 0x100c, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_lradc_clk, "bus-lradc", apb0_hws, 0x1024, BIT(0), 0);
 
 /* Undocumented, taken from the vendor kernel. */
 static const struct clk_parent_data sgpio_parents[] = {
@@ -911,6 +1093,7 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(sgpio_clk, "sgpio", sgpio_parents, 0x1060,
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_DATA(bus_sgpio_clk, "bus-sgpio", hosc, 0x1064, BIT(0), 0);
 
 /* Undocumented, taken from the vendor kernel. */
 static const struct clk_hw *lpc_parents[] = {
@@ -924,6 +1107,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(lpc_clk, "lpc", lpc_parents, 0x1080,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_DATA(bus_lpc_clk, "bus-lpc", hosc, 0x1084, BIT(0), 0);
 
 static const struct clk_hw *i2spcm_parents[] = {
 	&pll_audio0_4x_clk.common.hw,
@@ -936,11 +1120,15 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm0_clk, "i2spcm0", i2spcm_parents, 0x12
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_DATA(bus_i2spcm0_clk, "bus-i2spcm0", hosc, 0x120c, BIT(0), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm1_clk, "i2spcm1", i2spcm_parents, 0x1210,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_DATA(bus_i2spcm1_clk, "bus-i2spcm1", hosc, 0x121c, BIT(0), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_clk, "i2spcm2", i2spcm_parents, 0x1220,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
@@ -959,16 +1147,22 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm2_asrc_clk, "i2spcm2_asrc", i2spcm2_as
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+
+static SUNXI_CCU_GATE_DATA(bus_i2spcm2_clk, "bus-i2spcm2", hosc, 0x122c, BIT(0), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm3_clk, "i2spcm3", i2spcm_parents, 0x1230,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_DATA(bus_i2spcm3_clk, "bus-i2spcm3", hosc, 0x123c, BIT(0), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(i2spcm4_clk, "i2spcm4", i2spcm_parents, 0x1240,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_DATA(bus_i2spcm4_clk, "bus-i2spcm4", hosc, 0x124c, BIT(0), 0);
 
 static const struct clk_hw *spdif_tx_parents[] = {
 	&pll_audio0_4x_clk.common.hw,
@@ -992,6 +1186,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(spdif_rx_clk, "spdif-rx", spdif_rx_parents,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_spdif_clk, "bus-spdif", apb1_hws, 0x128c, BIT(0), 0);
+
 static const struct clk_hw *dmic_parents[] = {
 	&pll_audio0_4x_clk.common.hw,
 	&pll_audio1_div2_clk.hw,
@@ -1003,6 +1199,8 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dmic_clk, "dmic", dmic_parents, 0x12c0,
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_dmic_clk, "bus-dmic", apb1_hws, 0x12cc, BIT(0), 0);
+
 /*
  * The first parent is a 48 MHz input clock divided by 4. That 48 MHz clock is
  * a 2x multiplier from pll-ref synchronized by pll-periph0, and is also used by
@@ -1034,6 +1232,9 @@ static struct ccu_mux usb_ohci0_clk = {
 							   &ccu_mux_ops, 0),
 	},
 };
+static SUNXI_CCU_GATE_HWS(bus_ohci0_clk, "bus-ohci0", ahb_hws, 0x1304, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_ehci0_clk, "bus-ehci0", ahb_hws, 0x1304, BIT(4), 0);
+static SUNXI_CCU_GATE_HWS(bus_otg_clk, "bus-otg", ahb_hws, 0x1304, BIT(8), 0);
 
 static struct ccu_mux usb_ohci1_clk = {
 	.enable		= BIT(31),
@@ -1050,6 +1251,8 @@ static struct ccu_mux usb_ohci1_clk = {
 							   &ccu_mux_ops, 0),
 	},
 };
+static SUNXI_CCU_GATE_HWS(bus_ohci1_clk, "bus-ohci1", ahb_hws, 0x130c, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_ehci1_clk, "bus-ehci1", ahb_hws, 0x130c, BIT(4), 0);
 
 static const struct clk_parent_data usb01_ref_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -1152,11 +1355,14 @@ static SUNXI_CCU_M_HWS_WITH_GATE(gmac0_phy_clk, "gmac0-phy", pll_periph0_150M_hw
 				 0, 5,		/* M */
 				 BIT(31),	/* gate */
 				 0);
+static SUNXI_CCU_GATE_HWS(bus_gmac0_clk, "bus-gmac0", ahb_hws, 0x141c, BIT(0), 0);
+
 /* Undocumented, taken from the vendor kernel. */
 static SUNXI_CCU_M_HWS_WITH_GATE(gmac1_phy_clk, "gmac1-phy", pll_periph0_150M_hws, 0x1420,
 				 0, 5,		/* M */
 				 BIT(31),	/* gate */
 				 0);
+static SUNXI_CCU_GATE_HWS(bus_gmac1_clk, "bus-gmac1", ahb_hws, 0x142c, BIT(0), 0);
 
 static const struct clk_hw *tcon_lcd_parents[] = {
 	&pll_video0_4x_clk.common.hw,
@@ -1169,17 +1375,22 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd0_clk, "tcon-lcd0", tcon_lcd_parents
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_tcon_lcd0_clk, "bus-tcon-lcd0", ahb_hws, 0x1504, BIT(0), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd1_clk, "tcon-lcd1", tcon_lcd_parents, 0x1508,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_tcon_lcd1_clk, "bus-tcon-lcd1", ahb_hws, 0x150c, BIT(0), 0);
+
 /* Undocumented, taken from the vendor kernel. */
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(tcon_lcd2_clk, "tcon-lcd2", tcon_lcd_parents, 0x1510,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_tcon_lcd2_clk, "bus-tcon-lcd2", ahb_hws, 0x1514, BIT(0), 0);
 
 static const struct clk_hw *dsi_parents[] = {
 	&sys_24M_clk.hw,
@@ -1191,11 +1402,14 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi0_clk, "dsi0", dsi_parents, 0x1580,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_dsi0_clk, "bus-dsi0", ahb_hws, 0x1584, BIT(0), 0);
+
 static SUNXI_CCU_M_HW_WITH_MUX_GATE(dsi1_clk, "dsi1", dsi_parents, 0x1588,
 				    0, 5,	/* M */
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_dsi1_clk, "bus-dsi1", ahb_hws, 0x158c, BIT(0), 0);
 
 static const struct clk_hw *combphy_parents[] = {
 	&pll_video0_4x_clk.common.hw,
@@ -1215,6 +1429,9 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(combphy1_clk, "combphy1", combphy_parents, 0
 				    BIT(31),	/* gate */
 				    0);
 
+static SUNXI_CCU_GATE_HWS(bus_tcon_tv0_clk, "bus-tcon-tv0", ahb_hws, 0x1604, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_tcon_tv1_clk, "bus-tcon-tv1", ahb_hws, 0x160c, BIT(0), 0);
+
 static const struct clk_hw *edp_tv_parents[] = {
 	&pll_video0_4x_clk.common.hw,
 	&pll_video1_4x_clk.common.hw,
@@ -1226,6 +1443,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(edp_tv_clk, "edp-tv", edp_tv_parents, 0x1640
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_edp_tv_clk, "bus-edp-tv", ahb_hws, 0x164c, BIT(0), 0);
 
 static SUNXI_CCU_GATE_HWS_WITH_PREDIV(hdmi_cec_32k_clk, "hdmi-cec-32k", pll_periph0_2x_hws, 0x1680,
 				      BIT(30),	/* gate */
@@ -1253,6 +1471,7 @@ static SUNXI_CCU_DUALDIV_MUX_GATE(hdmi_tv_clk, "hdmi-tv", hdmi_tv_parents, 0x168
 				  24, 3,	/* mux */
 				  BIT(31),	/* gate */
 				  0);
+static SUNXI_CCU_GATE_HWS(bus_hdmi_tv_clk, "bus-hdmi-tv", ahb_hws, 0x168c, BIT(0), 0);
 
 static const struct clk_parent_data hdmi_sfr_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -1265,6 +1484,9 @@ static SUNXI_CCU_MUX_DATA_WITH_GATE(hdmi_sfr_clk, "hdmi-sfr", hdmi_sfr_parents,
 
 static SUNXI_CCU_GATE_HWS(hdcp_esm_clk, "hdcp-esm", pll_periph0_300M_hws, 0x1694, BIT(31), 0);
 
+static SUNXI_CCU_GATE_HWS(bus_dpss_top0_clk, "bus-dpss-top0", ahb_hws, 0x16c4, BIT(0), 0);
+static SUNXI_CCU_GATE_HWS(bus_dpss_top1_clk, "bus-dpss-top1", ahb_hws, 0x16cc, BIT(0), 0);
+
 static const struct clk_parent_data ledc_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
 	{ .hw = &pll_periph0_600M_clk.hw },
@@ -1275,6 +1497,9 @@ static SUNXI_CCU_M_DATA_WITH_MUX_GATE(ledc_clk, "ledc", ledc_parents, 0x1700,
 				      24, 3,	/* mux */
 				      BIT(31),	/* gate */
 				      0);
+static SUNXI_CCU_GATE_HWS(bus_ledc_clk, "bus-ledc", apb0_hws, 0x1704, BIT(0), 0);
+
+static SUNXI_CCU_GATE_HWS(bus_dsc_clk, "bus-dsc", ahb_hws, 0x1744, BIT(0), 0);
 
 static const struct clk_parent_data csi_master_parents[] = {
 	{ .hw = &sys_24M_clk.hw },
@@ -1316,6 +1541,7 @@ static SUNXI_CCU_M_HW_WITH_MUX_GATE(csi_clk, "csi", csi_parents, 0x1840,
 				    24, 3,	/* mux */
 				    BIT(31),	/* gate */
 				    0);
+static SUNXI_CCU_GATE_HWS(bus_csi_clk, "bus-csi", ahb_hws, 0x1844, BIT(0), 0);
 
 static const struct clk_hw *isp_parents[] = {
 	&pll_video2_4x_clk.common.hw,
@@ -1443,7 +1669,60 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&apb1_clk.common,
 	&apb_uart_clk.common,
 	&trace_clk.common,
+	&bus_its_pcie0_aclk_clk.common,
 	&mbus_clk.common,
+	&mbus_iommu0_sys_clk.common,
+	&apb_iommu0_sys_clk.common,
+	&ahb_iommu0_sys_clk.common,
+	&bus_msi_lite0_clk.common,
+	&bus_msi_lite1_clk.common,
+	&bus_msi_lite2_clk.common,
+	&mbus_iommu1_sys_clk.common,
+	&apb_iommu1_sys_clk.common,
+	&ahb_iommu1_sys_clk.common,
+	&ahb_ve_dec_clk.common,
+	&ahb_ve_enc_clk.common,
+	&ahb_vid_in_clk.common,
+	&ahb_vid_cout0_clk.common,
+	&ahb_vid_cout1_clk.common,
+	&ahb_de_clk.common,
+	&ahb_npu_clk.common,
+	&ahb_gpu0_clk.common,
+	&ahb_serdes_clk.common,
+	&ahb_usb_sys_clk.common,
+	&ahb_msi_lite0_clk.common,
+	&ahb_store_clk.common,
+	&ahb_cpus_clk.common,
+	&mbus_iommu0_clk.common,
+	&mbus_iommu1_clk.common,
+	&mbus_desys_clk.common,
+	&mbus_ve_enc0_gate_clk.common,
+	&mbus_ve_dec0_gate_clk.common,
+	&mbus_gpu0_clk.common,
+	&mbus_npu_clk.common,
+	&mbus_vid_in_clk.common,
+	&mbus_serdes_clk.common,
+	&mbus_msi_lite0_clk.common,
+	&mbus_store_clk.common,
+	&mbus_msi_lite2_clk.common,
+	&mbus_dma0_clk.common,
+	&mbus_ve_enc0_clk.common,
+	&mbus_ce_clk.common,
+	&mbus_dma1_clk.common,
+	&mbus_nand_clk.common,
+	&mbus_csi_clk.common,
+	&mbus_isp_clk.common,
+	&mbus_gmac0_clk.common,
+	&mbus_gmac1_clk.common,
+	&mbus_ve_dec0_clk.common,
+	&bus_dma0_clk.common,
+	&bus_dma1_clk.common,
+	&bus_spinlock_clk.common,
+	&bus_msgbox0_clk.common,
+	&bus_pwm0_clk.common,
+	&bus_pwm1_clk.common,
+	&bus_dbg_clk.common,
+	&bus_sysdap_clk.common,
 	&timer0_clk.common,
 	&timer1_clk.common,
 	&timer2_clk.common,
@@ -1454,48 +1733,111 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&timer7_clk.common,
 	&timer8_clk.common,
 	&timer9_clk.common,
+	&bus_timer_clk.common,
 	&avs_clk.common,
 	&de0_clk.common,
+	&bus_de0_clk.common,
 	&di_clk.common,
+	&bus_di_clk.common,
 	&g2d_clk.common,
+	&bus_g2d_clk.common,
 	&eink_clk.common,
 	&eink_panel_clk.common,
+	&bus_eink_clk.common,
 	&ve_enc0_clk.common,
 	&ve_dec0_clk.common,
+	&bus_ve_enc0_clk.common,
+	&bus_ve_dec0_clk.common,
 	&ce_clk.common,
+	&bus_ce_clk.common,
+	&bus_ce_sys_clk.common,
 	&npu_clk.common,
+	&bus_npu_clk.common,
 	&gpu0_clk.common,
+	&bus_gpu0_clk.common,
 	&dram0_clk.common,
+	&bus_dram0_clk.common,
 	&nand0_clk0_clk.common,
 	&nand0_clk1_clk.common,
+	&bus_nand0_clk.common,
 	&mmc0_clk.common,
+	&bus_mmc0_clk.common,
 	&mmc1_clk.common,
+	&bus_mmc1_clk.common,
 	&mmc2_clk.common,
+	&bus_mmc2_clk.common,
 	&mmc3_clk.common,
+	&bus_mmc3_clk.common,
 	&ufs_axi_clk.common,
 	&ufs_cfg_clk.common,
+	&bus_ufs_clk.common,
+	&bus_uart0_clk.common,
+	&bus_uart1_clk.common,
+	&bus_uart2_clk.common,
+	&bus_uart3_clk.common,
+	&bus_uart4_clk.common,
+	&bus_uart5_clk.common,
+	&bus_uart6_clk.common,
+	&bus_i2c0_clk.common,
+	&bus_i2c1_clk.common,
+	&bus_i2c2_clk.common,
+	&bus_i2c3_clk.common,
+	&bus_i2c4_clk.common,
+	&bus_i2c5_clk.common,
+	&bus_i2c6_clk.common,
+	&bus_i2c7_clk.common,
+	&bus_i2c8_clk.common,
+	&bus_i2c9_clk.common,
+	&bus_i2c10_clk.common,
+	&bus_i2c11_clk.common,
+	&bus_i2c12_clk.common,
 	&spi0_clk.common,
+	&bus_spi0_clk.common,
 	&spi1_clk.common,
+	&bus_spi1_clk.common,
 	&spi2_clk.common,
+	&bus_spi2_clk.common,
 	&spif_clk.common,
+	&bus_spif_clk.common,
 	&spi3_clk.common,
+	&bus_spi3_clk.common,
 	&spi4_clk.common,
+	&bus_spi4_clk.common,
 	&gpadc0_24m_clk.common,
+	&bus_gpadc0_clk.common,
+	&bus_ths0_clk.common,
 	&irrx_clk.common,
+	&bus_irrx_clk.common,
 	&irtx_clk.common,
+	&bus_irtx_clk.common,
+	&bus_lradc_clk.common,
 	&sgpio_clk.common,
+	&bus_sgpio_clk.common,
 	&lpc_clk.common,
+	&bus_lpc_clk.common,
 	&i2spcm0_clk.common,
+	&bus_i2spcm0_clk.common,
 	&i2spcm1_clk.common,
+	&bus_i2spcm1_clk.common,
 	&i2spcm2_clk.common,
 	&i2spcm2_asrc_clk.common,
+	&bus_i2spcm2_clk.common,
 	&i2spcm3_clk.common,
+	&bus_i2spcm3_clk.common,
 	&i2spcm4_clk.common,
+	&bus_i2spcm4_clk.common,
 	&spdif_tx_clk.common,
 	&spdif_rx_clk.common,
+	&bus_spdif_clk.common,
 	&dmic_clk.common,
+	&bus_dmic_clk.common,
 	&usb_ohci0_clk.common,
+	&bus_ohci0_clk.common,
+	&bus_ehci0_clk.common,
+	&bus_otg_clk.common,
 	&usb_ohci1_clk.common,
+	&bus_ohci1_clk.common,
+	&bus_ehci1_clk.common,
 	&usb01_ref_clk.common,
 	&usb2_u2_ref_clk.common,
 	&usb2_suspend_clk.common,
@@ -1507,25 +1849,41 @@ static struct ccu_common *sun60i_a733_ccu_clks[] = {
 	&serdes_phy_clk.common,
 	&gmac_ptp_clk.common,
 	&gmac0_phy_clk.common,
+	&bus_gmac0_clk.common,
 	&gmac1_phy_clk.common,
+	&bus_gmac1_clk.common,
 	&tcon_lcd0_clk.common,
+	&bus_tcon_lcd0_clk.common,
 	&tcon_lcd1_clk.common,
+	&bus_tcon_lcd1_clk.common,
 	&tcon_lcd2_clk.common,
+	&bus_tcon_lcd2_clk.common,
 	&dsi0_clk.common,
+	&bus_dsi0_clk.common,
 	&dsi1_clk.common,
+	&bus_dsi1_clk.common,
 	&combphy0_clk.common,
 	&combphy1_clk.common,
+	&bus_tcon_tv0_clk.common,
+	&bus_tcon_tv1_clk.common,
 	&edp_tv_clk.common,
+	&bus_edp_tv_clk.common,
 	&hdmi_cec_32k_clk.common,
 	&hdmi_cec_clk.common,
 	&hdmi_tv_clk.common,
+	&bus_hdmi_tv_clk.common,
 	&hdmi_sfr_clk.common,
 	&hdcp_esm_clk.common,
+	&bus_dpss_top0_clk.common,
+	&bus_dpss_top1_clk.common,
 	&ledc_clk.common,
+	&bus_ledc_clk.common,
+	&bus_dsc_clk.common,
 	&csi_master0_clk.common,
 	&csi_master1_clk.common,
 	&csi_master2_clk.common,
 	&csi_clk.common,
+	&bus_csi_clk.common,
 	&isp_clk.common,
 	&res_dcap_24m_clk.common,
 	&apb2jtag_clk.common,
@@ -1591,7 +1949,60 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_APB1]		= &apb1_clk.common.hw,
 		[CLK_APB_UART]		= &apb_uart_clk.common.hw,
 		[CLK_TRACE]		= &trace_clk.common.hw,
+		[CLK_BUS_ITS_PCIE0_ACLK] = &bus_its_pcie0_aclk_clk.common.hw,
 		[CLK_MBUS]		= &mbus_clk.common.hw,
+		[CLK_MBUS_IOMMU0_SYS]	= &mbus_iommu0_sys_clk.common.hw,
+		[CLK_APB_IOMMU0_SYS]	= &apb_iommu0_sys_clk.common.hw,
+		[CLK_AHB_IOMMU0_SYS]	= &ahb_iommu0_sys_clk.common.hw,
+		[CLK_BUS_MSI_LITE0]	= &bus_msi_lite0_clk.common.hw,
+		[CLK_BUS_MSI_LITE1]	= &bus_msi_lite1_clk.common.hw,
+		[CLK_BUS_MSI_LITE2]	= &bus_msi_lite2_clk.common.hw,
+		[CLK_MBUS_IOMMU1_SYS]	= &mbus_iommu1_sys_clk.common.hw,
+		[CLK_APB_IOMMU1_SYS]	= &apb_iommu1_sys_clk.common.hw,
+		[CLK_AHB_IOMMU1_SYS]	= &ahb_iommu1_sys_clk.common.hw,
+		[CLK_AHB_VE_DEC]	= &ahb_ve_dec_clk.common.hw,
+		[CLK_AHB_VE_ENC]	= &ahb_ve_enc_clk.common.hw,
+		[CLK_AHB_VID_IN]	= &ahb_vid_in_clk.common.hw,
+		[CLK_AHB_VID_COUT0]	= &ahb_vid_cout0_clk.common.hw,
+		[CLK_AHB_VID_COUT1]	= &ahb_vid_cout1_clk.common.hw,
+		[CLK_AHB_DE]		= &ahb_de_clk.common.hw,
+		[CLK_AHB_NPU]		= &ahb_npu_clk.common.hw,
+		[CLK_AHB_GPU0]		= &ahb_gpu0_clk.common.hw,
+		[CLK_AHB_SERDES]	= &ahb_serdes_clk.common.hw,
+		[CLK_AHB_USB_SYS]	= &ahb_usb_sys_clk.common.hw,
+		[CLK_AHB_MSI_LITE0]	= &ahb_msi_lite0_clk.common.hw,
+		[CLK_AHB_STORE]		= &ahb_store_clk.common.hw,
+		[CLK_AHB_CPUS]		= &ahb_cpus_clk.common.hw,
+		[CLK_MBUS_IOMMU0]	= &mbus_iommu0_clk.common.hw,
+		[CLK_MBUS_IOMMU1]	= &mbus_iommu1_clk.common.hw,
+		[CLK_MBUS_DESYS]	= &mbus_desys_clk.common.hw,
+		[CLK_MBUS_VE_ENC0_GATE]	= &mbus_ve_enc0_gate_clk.common.hw,
+		[CLK_MBUS_VE_DEC0_GATE]	= &mbus_ve_dec0_gate_clk.common.hw,
+		[CLK_MBUS_GPU0]		= &mbus_gpu0_clk.common.hw,
+		[CLK_MBUS_NPU]		= &mbus_npu_clk.common.hw,
+		[CLK_MBUS_VID_IN]	= &mbus_vid_in_clk.common.hw,
+		[CLK_MBUS_SERDES]	= &mbus_serdes_clk.common.hw,
+		[CLK_MBUS_MSI_LITE0]	= &mbus_msi_lite0_clk.common.hw,
+		[CLK_MBUS_STORE]	= &mbus_store_clk.common.hw,
+		[CLK_MBUS_MSI_LITE2]	= &mbus_msi_lite2_clk.common.hw,
+		[CLK_MBUS_DMA0]		= &mbus_dma0_clk.common.hw,
+		[CLK_MBUS_VE_ENC0]	= &mbus_ve_enc0_clk.common.hw,
+		[CLK_MBUS_CE]		= &mbus_ce_clk.common.hw,
+		[CLK_MBUS_DMA1]		= &mbus_dma1_clk.common.hw,
+		[CLK_MBUS_NAND]		= &mbus_nand_clk.common.hw,
+		[CLK_MBUS_CSI]		= &mbus_csi_clk.common.hw,
+		[CLK_MBUS_ISP]		= &mbus_isp_clk.common.hw,
+		[CLK_MBUS_GMAC0]	= &mbus_gmac0_clk.common.hw,
+		[CLK_MBUS_GMAC1]	= &mbus_gmac1_clk.common.hw,
+		[CLK_MBUS_VE_DEC0]	= &mbus_ve_dec0_clk.common.hw,
+		[CLK_BUS_DMA0]		= &bus_dma0_clk.common.hw,
+		[CLK_BUS_DMA1]		= &bus_dma1_clk.common.hw,
+		[CLK_BUS_SPINLOCK]	= &bus_spinlock_clk.common.hw,
+		[CLK_BUS_MSGBOX0]	= &bus_msgbox0_clk.common.hw,
+		[CLK_BUS_PWM0]		= &bus_pwm0_clk.common.hw,
+		[CLK_BUS_PWM1]		= &bus_pwm1_clk.common.hw,
+		[CLK_BUS_DBG]		= &bus_dbg_clk.common.hw,
+		[CLK_BUS_SYSDAP]	= &bus_sysdap_clk.common.hw,
 		[CLK_TIMER0]		= &timer0_clk.common.hw,
 		[CLK_TIMER1]		= &timer1_clk.common.hw,
 		[CLK_TIMER2]		= &timer2_clk.common.hw,
@@ -1602,48 +2013,111 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_TIMER7]		= &timer7_clk.common.hw,
 		[CLK_TIMER8]		= &timer8_clk.common.hw,
 		[CLK_TIMER9]		= &timer9_clk.common.hw,
+		[CLK_BUS_TIMER]		= &bus_timer_clk.common.hw,
 		[CLK_AVS]		= &avs_clk.common.hw,
 		[CLK_DE0]		= &de0_clk.common.hw,
+		[CLK_BUS_DE0]		= &bus_de0_clk.common.hw,
 		[CLK_DI]		= &di_clk.common.hw,
+		[CLK_BUS_DI]		= &bus_di_clk.common.hw,
 		[CLK_G2D]		= &g2d_clk.common.hw,
+		[CLK_BUS_G2D]		= &bus_g2d_clk.common.hw,
 		[CLK_EINK]		= &eink_clk.common.hw,
 		[CLK_EINK_PANEL]	= &eink_panel_clk.common.hw,
+		[CLK_BUS_EINK]		= &bus_eink_clk.common.hw,
 		[CLK_VE_ENC0]		= &ve_enc0_clk.common.hw,
 		[CLK_VE_DEC0]		= &ve_dec0_clk.common.hw,
+		[CLK_BUS_VE_ENC0]	= &bus_ve_enc0_clk.common.hw,
+		[CLK_BUS_VE_DEC0]	= &bus_ve_dec0_clk.common.hw,
 		[CLK_CE]		= &ce_clk.common.hw,
+		[CLK_BUS_CE]		= &bus_ce_clk.common.hw,
+		[CLK_BUS_CE_SYS]	= &bus_ce_sys_clk.common.hw,
 		[CLK_NPU]		= &npu_clk.common.hw,
+		[CLK_BUS_NPU]		= &bus_npu_clk.common.hw,
 		[CLK_GPU0]		= &gpu0_clk.common.hw,
+		[CLK_BUS_GPU0]		= &bus_gpu0_clk.common.hw,
 		[CLK_DRAM0]		= &dram0_clk.common.hw,
+		[CLK_BUS_DRAM0]		= &bus_dram0_clk.common.hw,
 		[CLK_NAND0_CLK0]	= &nand0_clk0_clk.common.hw,
 		[CLK_NAND0_CLK1]	= &nand0_clk1_clk.common.hw,
+		[CLK_BUS_NAND0]		= &bus_nand0_clk.common.hw,
 		[CLK_MMC0]		= &mmc0_clk.common.hw,
+		[CLK_BUS_MMC0]		= &bus_mmc0_clk.common.hw,
 		[CLK_MMC1]		= &mmc1_clk.common.hw,
+		[CLK_BUS_MMC1]		= &bus_mmc1_clk.common.hw,
 		[CLK_MMC2]		= &mmc2_clk.common.hw,
+		[CLK_BUS_MMC2]		= &bus_mmc2_clk.common.hw,
 		[CLK_MMC3]		= &mmc3_clk.common.hw,
+		[CLK_BUS_MMC3]		= &bus_mmc3_clk.common.hw,
 		[CLK_UFS_AXI]		= &ufs_axi_clk.common.hw,
 		[CLK_UFS_CFG]		= &ufs_cfg_clk.common.hw,
+		[CLK_BUS_UFS]		= &bus_ufs_clk.common.hw,
+		[CLK_BUS_UART0]		= &bus_uart0_clk.common.hw,
+		[CLK_BUS_UART1]		= &bus_uart1_clk.common.hw,
+		[CLK_BUS_UART2]		= &bus_uart2_clk.common.hw,
+		[CLK_BUS_UART3]		= &bus_uart3_clk.common.hw,
+		[CLK_BUS_UART4]		= &bus_uart4_clk.common.hw,
+		[CLK_BUS_UART5]		= &bus_uart5_clk.common.hw,
+		[CLK_BUS_UART6]		= &bus_uart6_clk.common.hw,
+		[CLK_BUS_I2C0]		= &bus_i2c0_clk.common.hw,
+		[CLK_BUS_I2C1]		= &bus_i2c1_clk.common.hw,
+		[CLK_BUS_I2C2]		= &bus_i2c2_clk.common.hw,
+		[CLK_BUS_I2C3]		= &bus_i2c3_clk.common.hw,
+		[CLK_BUS_I2C4]		= &bus_i2c4_clk.common.hw,
+		[CLK_BUS_I2C5]		= &bus_i2c5_clk.common.hw,
+		[CLK_BUS_I2C6]		= &bus_i2c6_clk.common.hw,
+		[CLK_BUS_I2C7]		= &bus_i2c7_clk.common.hw,
+		[CLK_BUS_I2C8]		= &bus_i2c8_clk.common.hw,
+		[CLK_BUS_I2C9]		= &bus_i2c9_clk.common.hw,
+		[CLK_BUS_I2C10]		= &bus_i2c10_clk.common.hw,
+		[CLK_BUS_I2C11]		= &bus_i2c11_clk.common.hw,
+		[CLK_BUS_I2C12]		= &bus_i2c12_clk.common.hw,
 		[CLK_SPI0]		= &spi0_clk.common.hw,
+		[CLK_BUS_SPI0]		= &bus_spi0_clk.common.hw,
 		[CLK_SPI1]		= &spi1_clk.common.hw,
+		[CLK_BUS_SPI1]		= &bus_spi1_clk.common.hw,
 		[CLK_SPI2]		= &spi2_clk.common.hw,
+		[CLK_BUS_SPI2]		= &bus_spi2_clk.common.hw,
 		[CLK_SPIF]		= &spif_clk.common.hw,
+		[CLK_BUS_SPIF]		= &bus_spif_clk.common.hw,
 		[CLK_SPI3]		= &spi3_clk.common.hw,
+		[CLK_BUS_SPI3]		= &bus_spi3_clk.common.hw,
 		[CLK_SPI4]		= &spi4_clk.common.hw,
+		[CLK_BUS_SPI4]		= &bus_spi4_clk.common.hw,
 		[CLK_GPADC0_24M]	= &gpadc0_24m_clk.common.hw,
+		[CLK_BUS_GPADC0]	= &bus_gpadc0_clk.common.hw,
+		[CLK_BUS_THS0]		= &bus_ths0_clk.common.hw,
 		[CLK_IRRX]		= &irrx_clk.common.hw,
+		[CLK_BUS_IRRX]		= &bus_irrx_clk.common.hw,
 		[CLK_IRTX]		= &irtx_clk.common.hw,
+		[CLK_BUS_IRTX]		= &bus_irtx_clk.common.hw,
+		[CLK_BUS_LRADC]		= &bus_lradc_clk.common.hw,
 		[CLK_SGPIO]		= &sgpio_clk.common.hw,
+		[CLK_BUS_SGPIO]		= &bus_sgpio_clk.common.hw,
 		[CLK_LPC]		= &lpc_clk.common.hw,
+		[CLK_BUS_LPC]		= &bus_lpc_clk.common.hw,
 		[CLK_I2SPCM0]		= &i2spcm0_clk.common.hw,
+		[CLK_BUS_I2SPCM0]	= &bus_i2spcm0_clk.common.hw,
 		[CLK_I2SPCM1]		= &i2spcm1_clk.common.hw,
+		[CLK_BUS_I2SPCM1]	= &bus_i2spcm1_clk.common.hw,
 		[CLK_I2SPCM2]		= &i2spcm2_clk.common.hw,
 		[CLK_I2SPCM2_ASRC]	= &i2spcm2_asrc_clk.common.hw,
+		[CLK_BUS_I2SPCM2]	= &bus_i2spcm2_clk.common.hw,
 		[CLK_I2SPCM3]		= &i2spcm3_clk.common.hw,
+		[CLK_BUS_I2SPCM3]	= &bus_i2spcm3_clk.common.hw,
 		[CLK_I2SPCM4]		= &i2spcm4_clk.common.hw,
+		[CLK_BUS_I2SPCM4]	= &bus_i2spcm4_clk.common.hw,
 		[CLK_SPDIF_TX]		= &spdif_tx_clk.common.hw,
 		[CLK_SPDIF_RX]		= &spdif_rx_clk.common.hw,
+		[CLK_BUS_SPDIF]		= &bus_spdif_clk.common.hw,
 		[CLK_DMIC]		= &dmic_clk.common.hw,
+		[CLK_BUS_DMIC]		= &bus_dmic_clk.common.hw,
 		[CLK_USB_OHCI0]		= &usb_ohci0_clk.common.hw,
+		[CLK_BUS_OHCI0]		= &bus_ohci0_clk.common.hw,
+		[CLK_BUS_EHCI0]		= &bus_ehci0_clk.common.hw,
+		[CLK_BUS_OTG]		= &bus_otg_clk.common.hw,
 		[CLK_USB_OHCI1]		= &usb_ohci1_clk.common.hw,
+		[CLK_BUS_OHCI1]		= &bus_ohci1_clk.common.hw,
+		[CLK_BUS_EHCI1]		= &bus_ehci1_clk.common.hw,
 		[CLK_USB01_REF]		= &usb01_ref_clk.common.hw,
 		[CLK_USB2_U2_REF]	= &usb2_u2_ref_clk.common.hw,
 		[CLK_USB2_SUSPEND]	= &usb2_suspend_clk.common.hw,
@@ -1655,25 +2129,41 @@ static struct clk_hw_onecell_data sun60i_a733_hw_clks = {
 		[CLK_SERDES_PHY]	= &serdes_phy_clk.common.hw,
 		[CLK_GMAC_PTP]		= &gmac_ptp_clk.common.hw,
 		[CLK_GMAC0_PHY]		= &gmac0_phy_clk.common.hw,
+		[CLK_BUS_GMAC0]		= &bus_gmac0_clk.common.hw,
 		[CLK_GMAC1_PHY]		= &gmac1_phy_clk.common.hw,
+		[CLK_BUS_GMAC1]		= &bus_gmac1_clk.common.hw,
 		[CLK_TCON_LCD0]		= &tcon_lcd0_clk.common.hw,
+		[CLK_BUS_TCON_LCD0]	= &bus_tcon_lcd0_clk.common.hw,
 		[CLK_TCON_LCD1]		= &tcon_lcd1_clk.common.hw,
+		[CLK_BUS_TCON_LCD1]	= &bus_tcon_lcd1_clk.common.hw,
 		[CLK_TCON_LCD2]		= &tcon_lcd2_clk.common.hw,
+		[CLK_BUS_TCON_LCD2]	= &bus_tcon_lcd2_clk.common.hw,
 		[CLK_DSI0]		= &dsi0_clk.common.hw,
+		[CLK_BUS_DSI0]		= &bus_dsi0_clk.common.hw,
 		[CLK_DSI1]		= &dsi1_clk.common.hw,
+		[CLK_BUS_DSI1]		= &bus_dsi1_clk.common.hw,
 		[CLK_COMBPHY0]		= &combphy0_clk.common.hw,
 		[CLK_COMBPHY1]		= &combphy1_clk.common.hw,
+		[CLK_BUS_TCON_TV0]	= &bus_tcon_tv0_clk.common.hw,
+		[CLK_BUS_TCON_TV1]	= &bus_tcon_tv1_clk.common.hw,
 		[CLK_EDP_TV]		= &edp_tv_clk.common.hw,
+		[CLK_BUS_EDP_TV]	= &bus_edp_tv_clk.common.hw,
 		[CLK_HDMI_CEC_32K]	= &hdmi_cec_32k_clk.common.hw,
 		[CLK_HDMI_CEC]		= &hdmi_cec_clk.common.hw,
 		[CLK_HDMI_TV]		= &hdmi_tv_clk.common.hw,
+		[CLK_BUS_HDMI_TV]	= &bus_hdmi_tv_clk.common.hw,
 		[CLK_HDMI_SFR]		= &hdmi_sfr_clk.common.hw,
 		[CLK_HDCP_ESM]		= &hdcp_esm_clk.common.hw,
+		[CLK_BUS_DPSS_TOP0]	= &bus_dpss_top0_clk.common.hw,
+		[CLK_BUS_DPSS_TOP1]	= &bus_dpss_top1_clk.common.hw,
 		[CLK_LEDC]		= &ledc_clk.common.hw,
+		[CLK_BUS_LEDC]		= &bus_ledc_clk.common.hw,
+		[CLK_BUS_DSC]		= &bus_dsc_clk.common.hw,
 		[CLK_CSI_MASTER0]	= &csi_master0_clk.common.hw,
 		[CLK_CSI_MASTER1]	= &csi_master1_clk.common.hw,
 		[CLK_CSI_MASTER2]	= &csi_master2_clk.common.hw,
 		[CLK_CSI]		= &csi_clk.common.hw,
+		[CLK_BUS_CSI]		= &bus_csi_clk.common.hw,
 		[CLK_ISP]		= &isp_clk.common.hw,
 		[CLK_RES_DCAP_24M]	= &res_dcap_24m_clk.common.hw,
 		[CLK_APB2JTAG]		= &apb2jtag_clk.common.hw,

-- 
2.55.0

