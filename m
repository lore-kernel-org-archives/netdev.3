Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96D3435A8F;
	Sat,  1 Aug 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583293; cv=none; b=TqzVnK+aqZwE9FdyqqRrqLh+tppZI+LWfOayYLqepj13GPX5ozrwB8MLlG1/DD1Mz7VAGeyhio6Lhi9bhTDkllIfHKpz9MwllQC9CHwB8Lf1KzXi2JGCpx5vW5MzVURBjS/dDx+oHP2C57OUzET3LvNGhwyYobX4jha99DMFYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583293; c=relaxed/simple;
	bh=5G0c40uJbd/eR7jfuidEYqyEqimv15mwHokxJEwhMks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6+B/55H73O2BIqZLVoMHDZAbvxi2bKEVxuJlQJKlc6Rx601/leiLaOSMa05J6MNpRko94ByqxSQ7TgDQk3QDVB77UBjRsIPfE/+vprfy4iiS7+QV4EswExRkBy7P5Uczh0BbO9TDTV3Z1MlE/Su6yevYyjxTHDTdNECKi+U9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JFsPhepI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JFsPhepI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583285;
	bh=5G0c40uJbd/eR7jfuidEYqyEqimv15mwHokxJEwhMks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JFsPhepIcnoYzg7olXzEuWy4Kiu0zDR1gdQ/MPRiyQSqYbc1z6ForPiDDXm60hn/M
	 XRe+CzBZnqQu/gP6m6jdYwZKbjJrzE91YkEfcZ7v5AN3+jelH2c3uBYPyyPtx0CmVM
	 z8LikKgucKsi4BReJbGCEPxSeLunLfnRaTPC5/nktmCQMVfPFSUzaNxdGr1BELQhWx
	 83jcsQ+/nNYILUS102/S/OTdiEgQqUU7Or6PnRbblX6tfaDjNw5fq2ttyXSNiH1ULx
	 cRHyurjVMZ4zd81a0Tzk9vq3+7kVYMZOfcbVnIDedE4oNIiEr2xo520csMUusaEsYZ
	 wl0nDyMfw+DQg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C3CE217E063E;
	Sat, 01 Aug 2026 13:21:24 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:21:05 +0200
Subject: [PATCH v5 19/25] clk: mediatek: Add MT8189 vlpcfg clock support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-19-ac4410697cc2@collabora.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583261; l=6536;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=5G0c40uJbd/eR7jfuidEYqyEqimv15mwHokxJEwhMks=;
 b=eAFGjQ1ExxE3pwIVd4D9Q4mmB8DMZDokQW9l/QwhB6b8ELE/htkg03TIv+AxHrnY8FN/klm0K
 XsdsSNEVKR7CpPYXshh3aglWb8zutyz3snhJDZaNh0C/98eQKK0xDo7
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add support for the MT8189 vlpcfg clock controller,
which provides clock gate control for vlp domain IPs.

Co-developed-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Signed-off-by: Irving-CH Lin <irving-ch.lin@mediatek.com>
Co-developed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/Makefile            |   2 +-
 drivers/clk/mediatek/clk-mt8189-vlpcfg.c | 116 +++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 3b25df9e7b50..d9279b237b7b 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -124,7 +124,7 @@ obj-$(CONFIG_COMMON_CLK_MT8188_VENCSYS) += clk-mt8188-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8188_VPPSYS) += clk-mt8188-vpp0.o clk-mt8188-vpp1.o
 obj-$(CONFIG_COMMON_CLK_MT8188_WPESYS) += clk-mt8188-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8189) += clk-mt8189-apmixedsys.o clk-mt8189-topckgen.o \
-				   clk-mt8189-vlpckgen.o
+				   clk-mt8189-vlpckgen.o clk-mt8189-vlpcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192-apmixedsys.o clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8189-vlpcfg.c b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
new file mode 100644
index 000000000000..cc4ebfd46a6f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8189-vlpcfg.c
@@ -0,0 +1,116 @@
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
+static const struct mtk_gate_regs vlpcfg_ao_reg_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VLPCFG_AO_REG(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &vlpcfg_ao_reg_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate vlpcfg_ao_reg_clks[] = {
+	GATE_VLPCFG_AO_REG(CLK_VLPCFG_AO_APEINT_RX, "vlpcfg_ao_apeint_rx", "clk26m", 8),
+};
+
+static const struct mtk_clk_desc vlpcfg_ao_reg_mcd = {
+	.clks = vlpcfg_ao_reg_clks,
+	.num_clks = ARRAY_SIZE(vlpcfg_ao_reg_clks),
+};
+
+static const struct mtk_gate_regs vlpcfg_reg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, _flags)		\
+	GATE_MTK_FLAGS(_id, _name, _parent, &vlpcfg_reg_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_no_setclr_inv, _flags)
+
+#define GATE_VLPCFG_REG(_id, _name, _parent, _shift)		\
+	GATE_VLPCFG_REG_FLAGS(_id, _name, _parent, _shift, 0)
+
+static const struct mtk_gate vlpcfg_reg_clks[] = {
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SCP, "vlpcfg_scp",
+			      "vlp_scp_sel", 28, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_R_APXGPT_26M, "vlpcfg_r_apxgpt_26m",
+			      "clk26m", 24, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRCK_TEST, "vlpcfg_dpmsrck_test",
+			      "clk26m", 23, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_RG_DPMSRRTC_TEST, "vlpcfg_dpmsrrtc_test",
+			      "clk32k", 22, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DPMSRULP_TEST, "vlpcfg_dpmsrulp_test",
+			      "osc_d10", 21, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST, "vlpcfg_spmi_p",
+			      "vlp_spmi_p_sel", 20, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SPMI_P_MST_32K, "vlpcfg_spmi_p_32k",
+			      "clk32k", 18, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_SYS, "vlpcfg_pmif_spmi_p_sys",
+			      "vlp_pwrap_ulposc_sel", 13, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PMIF_SPMI_P_TMR, "vlpcfg_pmif_spmi_p_tmr",
+			      "vlp_pwrap_ulposc_sel", 12, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_SYS, "vlpcfg_pmif_spmi_m_sys",
+			"vlp_pwrap_ulposc_sel", 11),
+	GATE_VLPCFG_REG(CLK_VLPCFG_REG_PMIF_SPMI_M_TMR, "vlpcfg_pmif_spmi_m_tmr",
+			"vlp_pwrap_ulposc_sel", 10),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_DVFSRC, "vlpcfg_dvfsrc",
+			      "vlp_dvfsrc_sel", 9, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_PWM_VLP, "vlpcfg_pwm_vlp",
+			      "vlp_pwm_vlp_sel", 8, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SRCK, "vlpcfg_srck",
+			      "vlp_srck_sel", 7, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F26M, "vlpcfg_sspm_f26m",
+			      "vlp_sspm_f26m_sel", 4, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_F32K, "vlpcfg_sspm_f32k",
+			      "clk32k", 3, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_SSPM_ULPOSC, "vlpcfg_sspm_ulposc",
+			      "vlp_sspm_ulposc_sel", 2, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_32K_COM, "vlpcfg_vlp_32k_com",
+			      "clk32k", 1, CLK_IS_CRITICAL),
+	GATE_VLPCFG_REG_FLAGS(CLK_VLPCFG_REG_VLP_26M_COM, "vlpcfg_vlp_26m_com",
+			      "clk26m", 0, CLK_IS_CRITICAL),
+};
+
+static const struct mtk_clk_desc vlpcfg_reg_mcd = {
+	.clks = vlpcfg_reg_clks,
+	.num_clks = ARRAY_SIZE(vlpcfg_reg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8189_vlpcfg[] = {
+	{ .compatible = "mediatek,mt8189-vlpcfg", .data = &vlpcfg_reg_mcd },
+	{ .compatible = "mediatek,mt8189-vlpcfg-ao", .data = &vlpcfg_ao_reg_mcd },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, of_match_clk_mt8189_vlpcfg);
+
+static struct platform_driver clk_mt8189_vlpcfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8189-vlpcfg",
+		.of_match_table = of_match_clk_mt8189_vlpcfg,
+	},
+};
+module_platform_driver(clk_mt8189_vlpcfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8189 vlpcfg clocks driver");
+MODULE_LICENSE("GPL");

-- 
2.55.0

