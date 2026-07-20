Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBB3E173B;
	Mon, 20 Jul 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541920; cv=none; b=dOdK71Is2ZOzwTKVOUxrZla/RgMCzihDW6C6+K2KCff60di281SGEiVerqo6dmd9HShz5wQ1bXqUx9cp9x7oQMOA+tKuI5JrtaFUieUyP8kN/KZ1lyzJz2ZD5JGqe2IrL6EjYArkcEynIOI6+YukvtYh3igqlUgQGVWrGChFJss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541920; c=relaxed/simple;
	bh=JjK8pa9skMKrbL9WvATZeCl7TfsvD3UbnhThFaSduHw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBonysgYSA3FdCHkYVobhgLR+GWAoqBAWVKTsGivtq4vF0hBwPdUvQJ5vZjXseCpqGYuP2lqzG0GImF6kFx9GGFHuyJ/OmHPNKBFrVD6Eqcil0x5b7y9lfovatCH56xuM4JrjTSBCgF2s5R53j0qnlpVN434ArtvlpO7UxQlk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ELbpPYsY; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ELbpPYsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784541915;
	bh=JjK8pa9skMKrbL9WvATZeCl7TfsvD3UbnhThFaSduHw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ELbpPYsYwbEgYOg14lR5UHALfdwFtfj7AMr1tvB7VqyOl4J7gr9eNzOh8nZ7HGoVS
	 5BuGrG7EfpXBujGsCn5vyJ759tOsoVUgWFS5NqqdE4rexn95hogIpqa8fkZ1n5R+aK
	 a7msW0v3L48r1osxeC7l59i7LelY83lshkrmsr+s9y9jSwpxEgoMhi4nTEDz3x5vbA
	 sgIyVHSwbXouhG5umzdpuzl2Nr+HDtKSv2VQA8v1Y2TKPOd+gwMuKw/UrTyGtQ8YvD
	 Rx6xlnntVPLADf6dHB3iYPqdb+iwWtxu/InCi4yzNaeCsSNHCmruCvSHQymvZPFp3q
	 ldR9qnFeHrmag==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CDBA717E0DFF;
	Mon, 20 Jul 2026 12:05:14 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Mon, 20 Jul 2026 12:04:26 +0200
Subject: [PATCH v3 16/18] clk: mediatek: Add MT8189 i2c clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-mt8189-clocks-system-base-v3-16-8e6d99ab3ad2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784541894; l=6586;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=JjK8pa9skMKrbL9WvATZeCl7TfsvD3UbnhThFaSduHw=;
 b=3BfE8npwcwAUc8R0SySG1YERm0OxKSbtIB0HMIuh+iPoIdGPktKnb11WOv1ARPJujrzjdsILP
 whbYoeNhtcXAacsyxI3NTgh+EtvMamzsdGCsAhfP1/q1jwLTDdjH1PT
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for the MT8189 i2c clock controller,
which provides clock gate control for i2c.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |  13 ++++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8189-iic.c | 122 ++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 245d3b83b5d3..bba631138b07 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -859,6 +859,19 @@ config COMMON_CLK_MT8189_DVFSRC
 	  vcore dvfs clocks. If you want to control its clocks, say Y or M
 	  to include this driver in your kernel build.
 
+config COMMON_CLK_MT8189_IIC
+	tristate "Clock driver for MediaTek MT8189 iic"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this option to support the clock framework for MediaTek MT8189
+	  integrated circuits (iic). This driver is responsible for managing
+	  clock sources, dividers, and gates specifically designed for MT8189
+	  SoCs. Enabling this driver ensures that the system can correctly
+	  manage clock frequencies and power for various components within
+	  the MT8189 chipset, improving the overall performance and power
+	  efficiency of the device.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 4dbfc9ac83ba..bfc075023d9b 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -128,6 +128,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
+obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-iic.c b/drivers/clk/mediatek/clk-mt8189-iic.c
new file mode 100644
index 000000000000..80a01706791a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-iic.c
@@ -0,0 +1,122 @@
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
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mediatek,mt8189-clk.h>
+
+static const struct mtk_gate_regs impe_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMPE(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &impe_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate impe_clks[] = {
+	GATE_IMPE(CLK_IMPE_I2C0, "impe_i2c0", "i2c_sel", 0),
+	GATE_IMPE(CLK_IMPE_I2C1, "impe_i2c1", "i2c_sel", 1),
+};
+
+static const struct mtk_clk_desc impe_mcd = {
+	.clks = impe_clks,
+	.num_clks = ARRAY_SIZE(impe_clks),
+};
+
+static const struct mtk_gate_regs impen_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMPEN(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &impen_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate impen_clks[] = {
+	GATE_IMPEN(CLK_IMPEN_I2C7, "impen_i2c7", "i2c_sel", 0),
+	GATE_IMPEN(CLK_IMPEN_I2C8, "impen_i2c8", "i2c_sel", 1),
+};
+
+static const struct mtk_clk_desc impen_mcd = {
+	.clks = impen_clks,
+	.num_clks = ARRAY_SIZE(impen_clks),
+};
+
+static const struct mtk_gate_regs imps_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMPS(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &imps_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate imps_clks[] = {
+	GATE_IMPS(CLK_IMPS_I2C3, "imps_i2c3", "i2c_sel", 0),
+	GATE_IMPS(CLK_IMPS_I2C4, "imps_i2c4", "i2c_sel", 1),
+	GATE_IMPS(CLK_IMPS_I2C5, "imps_i2c5", "i2c_sel", 2),
+	GATE_IMPS(CLK_IMPS_I2C6, "imps_i2c6", "i2c_sel", 3),
+};
+
+static const struct mtk_clk_desc imps_mcd = {
+	.clks = imps_clks,
+	.num_clks = ARRAY_SIZE(imps_clks),
+};
+
+static const struct mtk_gate_regs impws_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IMPWS(_id, _name, _parent, _shift)				\
+	GATE_MTK_FLAGS(_id, _name, _parent, &impws_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+
+static const struct mtk_gate impws_clks[] = {
+	GATE_IMPWS(CLK_IMPWS_I2C2, "impws_i2c2", "i2c_sel", 0),
+};
+
+static const struct mtk_clk_desc impws_mcd = {
+	.clks = impws_clks,
+	.num_clks = ARRAY_SIZE(impws_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_iic[] = {
+	{ .compatible = "mediatek,mt8189-iic-wrap-e", .data = &impe_mcd },
+	{ .compatible = "mediatek,mt8189-iic-wrap-en", .data = &impen_mcd },
+	{ .compatible = "mediatek,mt8189-iic-wrap-s", .data = &imps_mcd },
+	{ .compatible = "mediatek,mt8189-iic-wrap-ws", .data = &impws_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_iic);
+
+static struct platform_driver clk_mt8189_iic_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-iic",
+		.of_match_table = of_match_clk_mt8189_iic,
+	},
+};
+module_platform_driver(clk_mt8189_iic_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 iic clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

