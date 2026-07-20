Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FB23DB317;
	Mon, 20 Jul 2026 10:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541915; cv=none; b=o6I00Q69Wt8sOHqvb+AuJYxabejf75txfG2LcPq8enC/866/3TUsi0GU9KovzA9I2kWQ90m+lLimyjQyaSxVlQIsxR/106WtBluLY8tADAUphp8Sxn9MvRjofBxCzus5kiBAQQarp2DCwXp7eVINjaOxJecXrzEuHX/RLR+m1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541915; c=relaxed/simple;
	bh=0iPztvmI78QkGurYVCSEGCjiopYD7pP6BiUyKFDjSaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vw+XOJcEfGpLKN5fz+BjoDNgDaG05BwAkCwurbJbyevkrnDfWwnahnoULSROaW6LgNhEV5hAGZiZ2zvQgWp3gq2U4WZ28vE4AhfCrAkCi73NTRyr3LDDAl5d1PsCaIWc+LqsADJ1O6YroS+tK4YSiK3GHu/T+walbPGKTI+BjRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U6xBukE1; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U6xBukE1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784541906;
	bh=0iPztvmI78QkGurYVCSEGCjiopYD7pP6BiUyKFDjSaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U6xBukE11HVfr2laIqZ6hwvt6dFanca+yius3vL1Nd/SU2FCfmi6XKI1BDsWuDi68
	 89tCNUosRLWNeSd27gSAIJ5x2gPAFyT5Zo4I4f7ZoVw7fzEFioiwwNcJGwm+/rnOBv
	 6jtZ5Lqn+26R4Z9dIaA4+CvPlYJDuojc4aVQjMGs2eiumxrseuutHdfV+gkgdtSNm9
	 FFWDuHG2kfDZ6QHGw3xnXH1gARNX3oZTgXNWfDPrlzP2/nR+GITBBXckQ8zVGC2kgh
	 0BxRbhSZ10GVRR+WRIBkXtEWvS7eWO5RMMpT2Wkesi6OYRhCxKLGBiKN0cWWc8dHbh
	 1XwWBUh3qhXWA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B1A9417E0D7E;
	Mon, 20 Jul 2026 12:05:05 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Mon, 20 Jul 2026 12:04:19 +0200
Subject: [PATCH v3 09/18] clk: mediatek: Add MT8189 apmixedsys clock
 support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-mt8189-clocks-system-base-v3-9-8e6d99ab3ad2@collabora.com>
References: <20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com>
In-Reply-To: <20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Irving-CH Lin <irving-ch.lin@mediatek.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784541894; l=9564;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=0iPztvmI78QkGurYVCSEGCjiopYD7pP6BiUyKFDjSaY=;
 b=5ftsikyAhWM91GqpUlWzCGTzgmIgPrb/Fq818mi+EvToMrNCHUCPCW0BMvnABzn60Or/dy+oA
 Psw+zCWYFifA8jxK0gNLLQtJTdrkZlh7iGTv6tX6TCSHibrAbckYAvs
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for the MT8189 apmixedsys clock controller, which provides
PLLs generated from SoC 26m.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig                 |  13 ++
 drivers/clk/mediatek/Makefile                |   1 +
 drivers/clk/mediatek/clk-mt8189-apmixedsys.c | 196 +++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2c09fd729bab..f67dfb6cd019 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -815,6 +815,19 @@ config COMMON_CLK_MT8188_WPESYS
 	help
 	  This driver supports MediaTek MT8188 Warp Engine clocks.
 
+config COMMON_CLK_MT8189
+	tristate "Clock driver for MediaTek MT8189"
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	select COMMON_CLK_MEDIATEK_FHCTL
+	default ARCH_MEDIATEK
+	help
+	  Enable this option to support the clock management for MediaTek MT8189 SoC. This
+	  includes handling of all primary clock functions and features specific to the MT8189
+	  platform. Enabling this driver ensures that the system's clock functionality aligns
+	  with the MediaTek MT8189 hardware capabilities, providing efficient management of
+	  clock speeds and power consumption.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d8736a060dbd..66577ccb9b93 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VDOSYS) += clk-mt8188-vdo0.o clk-mt8188-vdo1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
+obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-apmixedsys.c b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
new file mode 100644
index 000000000000..0657a50c30d9
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-apmixedsys.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025-2026 MediaTek Inc.
+ *                    Qiqi Wang <qiqi.wang@mediatek.com>
+ *                    Irving-CH Lin <irving-ch.lin@mediatek.com>
+ * Copyright (C) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ *                    Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-fhctl.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+#define MT8189_PLL_FMAX		(3800UL * MHZ)
+#define MT8189_PLL_FMIN		(1500UL * MHZ)
+#define MT8189_PLLEN_OFS	0x70
+#define MT8189_INTEGER_BITS	8
+
+#define PLL_SETCLR(_id, _name, _reg, _en_setclr_bit,		\
+			_rstb_setclr_bit, _flags, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,	\
+			_pcwbits) {				\
+		.id = _id,					\
+		.name = _name,					\
+		.en_reg = MT8189_PLLEN_OFS,			\
+		.reg = _reg,					\
+		.pll_en_bit = _en_setclr_bit,			\
+		.rst_bar_mask = BIT(_rstb_setclr_bit),		\
+		.flags = _flags,				\
+		.fmax = MT8189_PLL_FMAX,			\
+		.fmin = MT8189_PLL_FMIN,			\
+		.pd_reg = _pd_reg,				\
+		.pd_shift = _pd_shift,				\
+		.tuner_reg = _tuner_reg,			\
+		.tuner_en_reg = _tuner_en_reg,			\
+		.tuner_en_bit = _tuner_en_bit,			\
+		.pcw_reg = _pcw_reg,				\
+		.pcw_shift = _pcw_shift,			\
+		.pcwbits = _pcwbits,				\
+		.pcwibits = MT8189_INTEGER_BITS,		\
+	}
+
+static const struct mtk_pll_data apmixed_plls[] = {
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_LL, "armpll-ll", 0x204, 18,
+		   0, PLL_AO, 0x208, 24, 0, 0, 0, 0x208, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ARMPLL_BL, "armpll-bl", 0x214, 17,
+		   0, PLL_AO, 0x218, 24, 0, 0, 0, 0x218, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_CCIPLL, "ccipll", 0x224, 16,
+		   0, PLL_AO, 0x228, 24, 0, 0, 0, 0x228, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MAINPLL, "mainpll", 0x304, 15,
+		   23, HAVE_RST_BAR | PLL_AO,
+		   0x308, 24, 0, 0, 0, 0x308, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UNIVPLL, "univpll", 0x314, 14,
+		   23, HAVE_RST_BAR, 0x318, 24, 0, 0, 0, 0x318, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MMPLL, "mmpll", 0x324, 13,
+		   23, HAVE_RST_BAR, 0x328, 24, 0, 0, 0, 0x328, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MFGPLL, "mfgpll", 0x504, 7,
+		   0, 0, 0x508, 24, 0, 0, 0, 0x508, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APLL1, "apll1", 0x404, 11,
+		   0, 0, 0x408, 24, 0x040, 0x00c, 0, 0x40c, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_APLL2, "apll2", 0x418, 10,
+		   0, 0, 0x41c, 24, 0x044, 0x00c, 1, 0x420, 0, 32),
+	PLL_SETCLR(CLK_APMIXED_EMIPLL, "emipll", 0x334, 12,
+		   0, PLL_AO, 0x338, 24, 0, 0, 0, 0x338, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL2, "apupll2", 0x614, 2,
+		   0, 0, 0x618, 24, 0, 0, 0, 0x618, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_APUPLL, "apupll", 0x604, 3,
+		   0, 0, 0x608, 24, 0, 0, 0, 0x608, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL1, "tvdpll1", 0x42c, 9,
+		   0, 0, 0x430, 24, 0, 0, 0, 0x430, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_TVDPLL2, "tvdpll2", 0x43c, 8,
+		   0, 0, 0x440, 24, 0, 0, 0, 0x440, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_ETHPLL, "ethpll", 0x514, 6,
+		   0, 0, 0x518, 24, 0, 0, 0, 0x518, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_MSDCPLL, "msdcpll", 0x524, 5,
+		   0, 0, 0x528, 24, 0, 0, 0, 0x528, 0, 22),
+	PLL_SETCLR(CLK_APMIXED_UFSPLL, "ufspll", 0x534, 4,
+		   0, 0, 0x538, 24, 0, 0, 0, 0x538, 0, 22),
+};
+
+#define FH(_pllid, _fhid, _offset) {				\
+		.data = {					\
+			.pll_id = _pllid,			\
+			.fh_id = _fhid,				\
+			.fh_ver = FHCTL_PLLFH_V2,		\
+			.fhx_offset = _offset,			\
+			.dds_mask = GENMASK(21, 0),		\
+			.slope0_value = 0x6003c97,		\
+			.slope1_value = 0x6003c97,		\
+			.sfstrx_en = BIT(2),			\
+			.frddsx_en = BIT(1),			\
+			.fhctlx_en = BIT(0),			\
+			.tgl_org = BIT(31),			\
+			.dvfs_tri = BIT(31),			\
+			.pcwchg = BIT(31),			\
+			.dt_val = 0x0,				\
+			.df_val = 0x9,				\
+			.updnlmt_shft = 16,			\
+			.msk_frddsx_dys = GENMASK(23, 20),	\
+			.msk_frddsx_dts = GENMASK(19, 16),	\
+		},						\
+	}
+
+static struct mtk_pllfh_data pllfhs[] = {
+	FH(CLK_APMIXED_ARMPLL_LL, 0, 0x003C),
+	FH(CLK_APMIXED_ARMPLL_BL, 1, 0x0050),
+	FH(CLK_APMIXED_CCIPLL, 2, 0x0064),
+	FH(CLK_APMIXED_MAINPLL, 3, 0x0078),
+	FH(CLK_APMIXED_MMPLL, 4, 0x008C),
+	FH(CLK_APMIXED_MFGPLL, 5, 0x00A0),
+	FH(CLK_APMIXED_EMIPLL, 6, 0x00B4),
+	FH(CLK_APMIXED_TVDPLL1, 7, 0x00C8),
+	FH(CLK_APMIXED_TVDPLL2, 8, 0x00DC),
+	FH(CLK_APMIXED_MSDCPLL, 9, 0x00F0),
+	FH(CLK_APMIXED_UFSPLL, 10, 0x0104),
+	FH(CLK_APMIXED_APUPLL, 11, 0x0118),
+	FH(CLK_APMIXED_APUPLL2, 12, 0x012c),
+};
+
+static const struct of_device_id of_match_clk_mt8189_apmixed[] = {
+	{ .compatible = "mediatek,mt8189-apmixedsys" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_apmixed);
+
+static int clk_mt8189_apmixed_probe(struct platform_device *pdev)
+{
+	int r;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	const u8 *fhctl_node = "mediatek,mt8189-fhctl";
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(apmixed_plls));
+	if (!clk_data)
+		return -ENOMEM;
+
+	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
+
+	r = mtk_clk_register_pllfhs(&pdev->dev, apmixed_plls, ARRAY_SIZE(apmixed_plls),
+				    pllfhs, ARRAY_SIZE(pllfhs), clk_data);
+	if (r)
+		goto free_apmixed_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_plls;
+
+	platform_set_drvdata(pdev, clk_data);
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_pllfhs(apmixed_plls, ARRAY_SIZE(apmixed_plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
+free_apmixed_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static void clk_mt8189_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_pllfhs(apmixed_plls, ARRAY_SIZE(apmixed_plls), pllfhs,
+				  ARRAY_SIZE(pllfhs), clk_data);
+	mtk_free_clk_data(clk_data);
+}
+
+static struct platform_driver clk_mt8189_apmixed_drv = {
+	.probe = clk_mt8189_apmixed_probe,
+	.remove = clk_mt8189_apmixed_remove,
+	.driver = {
+		.name = "clk-mt8189-apmixed",
+		.of_match_table = of_match_clk_mt8189_apmixed,
+	},
+};
+module_platform_driver(clk_mt8189_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 apmixed clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

