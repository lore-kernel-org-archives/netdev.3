Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046AE3E4C64;
	Mon, 20 Jul 2026 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541922; cv=none; b=QH5iPTzDXqdZrl5mTXtYsCzIhIAqqkEKzcksK32AJzRWiiSIgUQEsX0JF7mnyQ+byxtDtwEjpZdfnlePFzeccDErF7l91jELH65OP47I5neeyJGZnXt25Bd8KM4rXGTPGknRMWzsuEoruSrR5K9qKdAQKsCtKBZWrkOtP6djAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541922; c=relaxed/simple;
	bh=7nxjFDvM8+mIB8eYa2kyDbOfy5LmVW0Q4CN2nrB4Rb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gYalyJgqIhEm5G02HHbPNCKrPdoJWOwVirD75p42HKQeV/FYG3mgy1+oBj3hDOL2cBKb/bnCWNRNpHM/oddDgv/3jYeUQLj5Zw8cmT6GJg3/KLVWPbnapWVVv3Hb5nlu7lY8KrfvkpDI56Hr6XPVu3dnM/QVv126BWAcnK7ETlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qO9aPBQM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qO9aPBQM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784541917;
	bh=7nxjFDvM8+mIB8eYa2kyDbOfy5LmVW0Q4CN2nrB4Rb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qO9aPBQMinKQxtwle542YU23fwUW2MOtk81z80tdm806uuBwGuhaGNBi6yKPcVhJT
	 PnqGkpdRtwK8YbVkclxApB5Pj0sbOrdhJiv86s75BHxPX7Gh4+3c4yiUztCRQIYqOJ
	 WIbw9s0a7IKT9s4DUgJOP12vJbVNfV/GO/YTTv58e1r20jKpk/LyVUNx680N3oGQmW
	 8CGMpBkPDgqOCPqkWOJvLjl88ggDIz9vwx8XYRk51T7huzOOK5Uc/1POrkwXna+rX0
	 ZRyEwjgii3SbRYe+61/KP5jhspsS5TLHSXRsd2Vm6m0YnTXrtcaVt53BSjDmIU1C6P
	 4lP+RvSaNPQ8Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 12F7517E07A2;
	Mon, 20 Jul 2026 12:05:16 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Mon, 20 Jul 2026 12:04:27 +0200
Subject: [PATCH v3 17/18] clk: mediatek: Add MT8189 scp clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-mt8189-clocks-system-base-v3-17-8e6d99ab3ad2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784541894; l=5001;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=7nxjFDvM8+mIB8eYa2kyDbOfy5LmVW0Q4CN2nrB4Rb4=;
 b=NT9nfLI6zWosmROnV673Q1qKtO+j3MN2sFLPAvv9VTYJcHN/qCMK+16zGpxRYtsSKOkMa4AXT
 PyYXey6OTzeDbdUOFt3q+HDBWWwunWUU8Kr3KJQjfPRJf3w1yCTrdTQ
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for the MT8189 scp clock controller,
which provides clock gate control for System Control Processor.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig          | 10 +++++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8189-scp.c | 77 +++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index bba631138b07..919a916f1f4f 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -872,6 +872,16 @@ config COMMON_CLK_MT8189_IIC
 	  the MT8189 chipset, improving the overall performance and power
 	  efficiency of the device.
 
+config COMMON_CLK_MT8189_SCP
+	tristate "Clock driver for MediaTek MT8189 scp"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock framework for the System Control
+	  Processor (SCP) in the MediaTek MT8189 SoC. This includes clock
+	  management for SCP-related features, ensuring proper clock
+	  distribution and gating for power efficiency and functionality.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index bfc075023d9b..a3a93a16b369 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -129,6 +129,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_BUS) += clk-mt8189-bus.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
+obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-scp.c b/drivers/clk/mediatek/clk-mt8189-scp.c
new file mode 100644
index 000000000000..75197cd98b52
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-scp.c
@@ -0,0 +1,77 @@
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
+static const struct mtk_gate_regs scp_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_SCP(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &scp_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate scp_clks[] = {
+	GATE_SCP(CLK_SCP_SET_SPI0, "scp_set_spi0", "clk26m", 0),
+	GATE_SCP(CLK_SCP_SET_SPI1, "scp_set_spi1", "clk26m", 1),
+};
+
+static const struct mtk_clk_desc scp_mcd = {
+	.clks = scp_clks,
+	.num_clks = ARRAY_SIZE(scp_clks),
+};
+
+static const struct mtk_gate_regs scp_iic_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_SCP_IIC(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &scp_iic_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate scp_iic_clks[] = {
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C0_W1S, "scp_iic_i2c0_w1s", "vlp_scp_iic_sel", 0),
+	GATE_SCP_IIC(CLK_SCP_IIC_I2C1_W1S, "scp_iic_i2c1_w1s", "vlp_scp_iic_sel", 1),
+};
+
+static const struct mtk_clk_desc scp_iic_mcd = {
+	.clks = scp_iic_clks,
+	.num_clks = ARRAY_SIZE(scp_iic_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_scp[] = {
+	{ .compatible = "mediatek,mt8189-scp-clk", .data = &scp_mcd },
+	{ .compatible = "mediatek,mt8189-scp-i2c-clk", .data = &scp_iic_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_scp);
+
+static struct platform_driver clk_mt8189_scp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-scp",
+		.of_match_table = of_match_clk_mt8189_scp,
+	},
+};
+module_platform_driver(clk_mt8189_scp_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 scp clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

