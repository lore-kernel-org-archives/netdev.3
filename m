Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC14779B2;
	Wed, 29 Jul 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319424; cv=none; b=R8pYhIv6V/Hc4Jme4wBn5Rtijrs8Qww6s//Xs1hJ1RbFCXmeacbRk5QQqWEj+80suzFg7RHf7OWDnIpOiDGvnQNtG5L5R8WSm9L5PR5Xw1v61ApK3olsxDL2edO2Kr5dx0Wkxvdz8Ub26HuOLSbyswjcpn2gi4gF1isjYnsfwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319424; c=relaxed/simple;
	bh=Zh06wlUmAIC1iukSKooFVWp0hF17e98otRnRFvdgrT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TI8MNg0InhdZv22PcbIo5LL026ZZTpz+f7X8QB7YpcYN0Q06LT4FbgK+IBs7+uYHCQv8k8ggKyQNsBrXk3HwyBKCXEPct9wXNs+8D9vBmiP9VlyFLMItnO3RUVrYDdIunUdE2ezcASS7/lsm58LMipu+PG2jdBRQgOyWP4v6VLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lv0WUgTW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lv0WUgTW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319418;
	bh=Zh06wlUmAIC1iukSKooFVWp0hF17e98otRnRFvdgrT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lv0WUgTW5IqFnPZGFoE3kIMBhu9IzP12WRWxlguIg/BL8fRuN1ClKKsjReCkfYKOu
	 0Dk7d63MjMirKShBOKAe4G0aICIEwtoMAuPsiJIvu9adnHWlBLrqRxV55qrf3p543G
	 85geM0IIfr+NzqIdsrA4wj+OFTp0qYEZ4Li5z5SwTjZumPJ6a0NleLh4YuJkiODkkF
	 sdmozSe22nmMv9OMrkcIKwx4BDU5LB3VsWKh/SoE2u7Hxb/quHNiVDhwnWZyCoHCva
	 Y5sC4SUav5FUKy9bNJij6lpT6P815edN8ZYW4gilbxnDoQ0148pgs5g49JGc2Z1rOr
	 FNDrHLA42dNdg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C521517E0682;
	Wed, 29 Jul 2026 12:03:37 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:03:08 +0200
Subject: [PATCH v4 24/24] clk: mediatek: Add MT8189 ufs clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-24-e356b813a64c@collabora.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
In-Reply-To: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785319388; l=7242;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Zh06wlUmAIC1iukSKooFVWp0hF17e98otRnRFvdgrT0=;
 b=gO61SdH2zYrjFtvn38J7fZcr/ebMsLx0JzWTkuecPzuLLCGhmKPn9krA2cZnhJIuUsRaWnoNd
 3HZvE6XsVYVDOnLROYHbl8SMdqcQg9muzpTvW0ttd65Bi2Z768jc/3L
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for the MT8189 ufs clock controller,
which provides clock gate control for Universal Flash Storage.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Kconfig          |  12 +++
 drivers/clk/mediatek/Makefile         |   1 +
 drivers/clk/mediatek/clk-mt8189-ufs.c | 133 ++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 919a916f1f4f..34a270a377cc 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -882,6 +882,18 @@ config COMMON_CLK_MT8189_SCP
 	  management for SCP-related features, ensuring proper clock
 	  distribution and gating for power efficiency and functionality.
 
+config COMMON_CLK_MT8189_UFS
+	tristate "Clock driver for MediaTek MT8189 ufs"
+	depends on COMMON_CLK_MT8189
+	default COMMON_CLK_MT8189
+	help
+	  Enable this to support the clock management for the Universal Flash
+	  Storage (UFS) interface on MediaTek MT8189 SoCs. This includes
+	  clock sources, dividers, and gates that are specific to the UFS
+	  feature of the MT8189 platform. It is recommended to enable this
+	  option if the system includes a UFS device that relies on the MT8189
+	  SoC for clock management.
+
 config COMMON_CLK_MT8192
 	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index a3a93a16b369..1aa9f4265225 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_COMMON_CLK_MT8189_DBGAO) += clk-mt8189-dbgao.o
 obj-$(CONFIG_COMMON_CLK_MT8189_DVFSRC) += clk-mt8189-dvfsrc.o
 obj-$(CONFIG_COMMON_CLK_MT8189_IIC) += clk-mt8189-iic.o
 obj-$(CONFIG_COMMON_CLK_MT8189_SCP) += clk-mt8189-scp.o
+obj-$(CONFIG_COMMON_CLK_MT8189_UFS) += clk-mt8189-ufs.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-ufs.c b/drivers/clk/mediatek/clk-mt8189-ufs.c
new file mode 100644
index 000000000000..85afab04420f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-ufs.c
@@ -0,0 +1,133 @@
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
+#include <dt-bindings/reset/mediatek,mt8189-resets.h>
+
+#define MT8189_UFSCFG_AO_RST0_SET_OFFSET	0x48
+#define MT8189_UFSCFG_PDN_RST0_SET_OFFSET	0x48
+
+static const struct mtk_gate_regs ufscfg_ao_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_AO_REG(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &ufscfg_ao_reg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ufscfg_ao_reg_clks[] = {
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_TX_SYM,
+			   "ufscfg_ao_unipro_tx_sym", "clk26m", 1),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM0,
+			   "ufscfg_ao_unipro_rx_sym0", "clk26m", 2),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_RX_SYM1,
+			   "ufscfg_ao_unipro_rx_sym1", "clk26m", 3),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_UNIPRO_SYS,
+			   "ufscfg_ao_unipro_sys", "ufs_sel", 4),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_SAP_CFG,
+			   "ufscfg_ao_u_sap_cfg", "clk26m", 5),
+	GATE_UFSCFG_AO_REG(CLK_UFSCFG_AO_REG_U_PHY_TOP_AHB_S_BUS,
+			   "ufscfg_ao_u_phy_ahb_s_bus", "axi_u_sel", 6),
+};
+
+static u16 ufscfg_ao_rst_ofs[] = {
+	MT8189_UFSCFG_AO_RST0_SET_OFFSET,
+};
+
+static u16 ufscfg_ao_rst_idx_map[] = {
+	[MT8189_UFSAO_RST_UFS_MPHY] = 8,
+};
+
+static const struct mtk_clk_rst_desc ufscfg_ao_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = ufscfg_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(ufscfg_ao_rst_ofs),
+	.rst_idx_map = ufscfg_ao_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(ufscfg_ao_rst_idx_map),
+};
+
+static const struct mtk_clk_desc ufscfg_ao_reg_mcd = {
+	.clks = ufscfg_ao_reg_clks,
+	.num_clks = ARRAY_SIZE(ufscfg_ao_reg_clks),
+	.rst_desc = &ufscfg_ao_rst_desc,
+};
+
+static const struct mtk_gate_regs ufscfg_pdn_reg_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_UFSCFG_PDN_REG(_id, _name, _parent, _shift)	\
+	GATE_MTK(_id, _name, _parent, &ufscfg_pdn_reg_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ufscfg_pdn_reg_clks[] = {
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_UFS,
+			    "ufscfg_ufshci_ufs", "ufs_sel", 0),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_AES,
+			    "ufscfg_ufshci_aes", "aes_ufsfde_sel", 1),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AHB,
+			    "ufscfg_ufshci_u_ahb", "axi_u_sel", 3),
+	GATE_UFSCFG_PDN_REG(CLK_UFSCFG_REG_UFSHCI_U_AXI,
+			    "ufscfg_ufshci_u_axi", "mem_sub_u_sel", 5),
+};
+
+static u16 ufscfg_pdn_rst_ofs[] = {
+	MT8189_UFSCFG_PDN_RST0_SET_OFFSET,
+};
+
+static u16 ufscfg_pdn_rst_idx_map[] = {
+	[MT8189_UFSPDN_RST_UFS_UNIPRO] = 0,
+	[MT8189_UFSPDN_RST_UFS_CRYPTO] = 1,
+	[MT8189_UFSPDN_RST_UFS_HCI] = 2,
+};
+
+static const struct mtk_clk_rst_desc ufscfg_pdn_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = ufscfg_pdn_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(ufscfg_pdn_rst_ofs),
+	.rst_idx_map = ufscfg_pdn_rst_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(ufscfg_pdn_rst_idx_map),
+};
+
+static const struct mtk_clk_desc ufscfg_pdn_reg_mcd = {
+	.clks = ufscfg_pdn_reg_clks,
+	.num_clks = ARRAY_SIZE(ufscfg_pdn_reg_clks),
+	.rst_desc = &ufscfg_pdn_rst_desc,
+};
+
+static const struct of_device_id of_match_clk_mt8189_ufs[] = {
+	{ .compatible = "mediatek,mt8189-ufscfg-ao", .data = &ufscfg_ao_reg_mcd },
+	{ .compatible = "mediatek,mt8189-ufscfg-pdn", .data = &ufscfg_pdn_reg_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_ufs);
+
+static struct platform_driver clk_mt8189_ufs_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-ufs",
+		.of_match_table = of_match_clk_mt8189_ufs,
+	},
+};
+module_platform_driver(clk_mt8189_ufs_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 ufs clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

