Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24AF42EEB8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766763; cv=none; b=TkrwHSW8Imf78JlyCbY/Yj8cqgogJQcJ++LmU6//Dfs0adg+b4zkBEvv3wyJzn30gAeD+QZP4fre+uH33Te/cW8VSIfIztRk1+pJFESOWLTobbK7LrpL0NGMcUvGZJEt4zpd9qZPhgo+44w49Pl2vaGJCV+SPOxxGyHiN6+9oMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766763; c=relaxed/simple;
	bh=1cuX+DmeUMtWv+bRECuG1HTUf1itG58Bm2fCmtHKVzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMczXtpn9EjAQ09qcR7HbgCUIQI5oNalA6IQeGcxNqBzUzFq5/0FWvZ3RcqUnW+18Yh7FrgaNSisc7CUofBvNpveqoCnQYMYyd0zAmmOzlwuPWVVbbvLLzXLWMG7EmjJVO37M+1XQ4arOlQIdaLSyq5QKC2apHsJuRbo+t21ldU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cc6FdBZH; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cc6FdBZH"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso2378273a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766761; x=1786371561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNLXS2ez3G7NtIzmW+K0Ec5UFQW3DCf7KsBaQsnVv6s=;
        b=Cc6FdBZHTgBbmDURZhtGxTLPIyOdqNAErBmctTOGKWM3e1ChaaE9klrUfE3dKpNlQ1
         Dvz6AOFqAbmdTYxKKRz1e+yGtl1dAotYNkSgptckltfWb/PaqmAlr5HLhFvJ3h5whxc3
         W/zzIliMSjRK+kI53OguwJG5yDPW9zc08pHVTKH//FO9FuZVQMWKfYNwiK7rZtsIZq5N
         K8bGM54/s90INE1WZvwq11+mXDPkbG2MMa5zTae/TEfkVeX2HZjXx8DvSDEedJG2Qw4b
         4gMIe0LY4Hle9vfITRvf9PkzBA15GSlWuzQi4lBotkz6y9322HO9T2vMNYCX39KSYga0
         mzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766761; x=1786371561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNLXS2ez3G7NtIzmW+K0Ec5UFQW3DCf7KsBaQsnVv6s=;
        b=iSNxFkYVp177w7trjB3U2U7csyWdF41qBcLkdLlImCA+J+VhHPQ8qeJip37JhhLxw4
         jtTG8KpEbRj0LprnB/fnKF6Rx6bOeJcye0nm/XeaC1qnaqVen96Z24xOTP7DCS1oMiaG
         IVYbfc/hq4eQINtgEKJdLdf1fu76tdcJk++ynXIV4xJKApl3VBzsFRdP0ls1aF/KAXA2
         CHlaW7Yj+AKyg2oWNWYwoUgDj7CQFJpDgzjlhCxQP4gnhuy5UYPuip4jBnCfvdfxen0H
         f7J0tnCwb0Gw3KhOw56bIXmYMUcFR5PZ36x7k7Uy2HeCtDF3nekDtGUFhbd8A0mod+6Q
         AnNw==
X-Forwarded-Encrypted: i=1; AHgh+RpHu9aWI1axtVnytFESSL7dkYbv9NlKTjHnDBrA8d1V5W4Y+ppBqKOitM3crxKNvq4jxxEuuhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXJFF6NLK9+N8/AtrPk9yuo6xsWiICjAt36hL3bfUms+UjIpfz
	AkJXfkSU4lX06V8RtSMcF3OLA6tOCOYEtcasvpdwgQZd863VvGdgP8+0
X-Gm-Gg: AR+sD10pzySemZ9RnuNzcT4dPQP9T9i84uWMR9hnxLtNOMbQ+QqZq1qwBWohgKY/2DL
	kMGj3srcGVLfQCQyjy3ZsqNKAIxDk2XvN8H8Ei6GauEPR536DtwxAf7HVgvC0hBRgRIsbtukk8v
	MXnoa/erVn+M/d0gOQ3bIFbHB4WG/SNqa4rqWLy8hyR0msXSXEHVUFxfywWv1S5Wp5Ng7N824rJ
	MMqx6nP/cBI7I8gBvglNJRzH34t+APzglzopg15/94lvFyXCmbop+2oSyh/jWxY9MS5MOHdeHFv
	PX7WOdmQuZCO67YJvYypz+sDK+vOnOYH/AIyTACbFlVyv2tCGMfHBxOBc5xO2WdvAY2tRtOV1vn
	WzeAhntmOihonRul6KszGdY3Bf27mQFvv1u6vdUte1curY157Clc/4OG9KkuUfauvmgDDLSloUx
	qZbjtt21Xo6CgKPa86YBB7yh1G4AZslWamh8qBIlGsuvtvckTZgCxNqMl0dBrW5l+JxA09rKbN5
	39PzFu58C7Z135DsDsw
X-Received: by 2002:a17:90b:4c51:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-38fbc3f9ab6mr9427013a91.7.1785766760964;
        Mon, 03 Aug 2026 07:19:20 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:20 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 25/32] clk: mediatek: mt8173-infracfg: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:52 +0900
Message-ID: <20260803141659.559129-26-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MT8173 infracfg driver can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Drop the CLK_OF_DECLARE_DRIVER early init for infracfg; the kernel's
deferred probe mechanism ensures dependent drivers like cpufreq are
initialized correctly.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8173-infracfg.c | 100 ++++-----------------
 1 file changed, 16 insertions(+), 84 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index 9b8c35897789..fdd994736e83 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -17,22 +17,20 @@
 		GATE_MTK(_id, _name, _parent, &infra_cg_regs,	\
 			 _shift, &mtk_clk_gate_ops_setclr)
 
-static struct clk_hw_onecell_data *infra_clk_data;
-
 static const struct mtk_gate_regs infra_cg_regs = {
 	.set_ofs = 0x0040,
 	.clr_ofs = 0x0044,
 	.sta_ofs = 0x0048,
 };
 
-static const char * const ca53_parents[] __initconst = {
+static const char * const ca53_parents[] = {
 	"clk26m",
 	"armca7pll",
 	"mainpll",
 	"univpll"
 };
 
-static const char * const ca72_parents[] __initconst = {
+static const char * const ca72_parents[] = {
 	"clk26m",
 	"armca15pll",
 	"mainpll",
@@ -44,7 +42,7 @@ static const struct mtk_composite cpu_muxes[] = {
 	MUX(CLK_INFRA_CA72SEL, "infra_ca72_sel", ca72_parents, 0x0000, 2, 2),
 };
 
-static const struct mtk_fixed_factor infra_early_divs[] = {
+static const struct mtk_fixed_factor infra_divs[] = {
 	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
 };
 
@@ -70,95 +68,29 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 };
 
+static const struct mtk_clk_desc infracfg_desc = {
+	.clks = infra_gates,
+	.num_clks = ARRAY_SIZE(infra_gates),
+	.factor_clks = infra_divs,
+	.num_factor_clks = ARRAY_SIZE(infra_divs),
+	.cpumuxes = cpu_muxes,
+	.num_cpumuxes = ARRAY_SIZE(cpu_muxes),
+	.rst_desc = &clk_rst_desc,
+};
+
 static const struct of_device_id of_match_clk_mt8173_infracfg[] = {
-	{ .compatible = "mediatek,mt8173-infracfg" },
+	{ .compatible = "mediatek,mt8173-infracfg", .data = &infracfg_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8173_infracfg);
 
-static void clk_mt8173_infra_init_early(struct device_node *node)
-{
-	int i;
-
-	infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-	if (!infra_clk_data)
-		return;
-
-	for (i = 0; i < CLK_INFRA_NR_CLK; i++)
-		infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-
-	mtk_clk_register_factors(infra_early_divs,
-				 ARRAY_SIZE(infra_early_divs), infra_clk_data);
-
-	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
-}
-CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
-		      clk_mt8173_infra_init_early);
-
-static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	int r, i;
-
-	if (!infra_clk_data) {
-		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-		if (!infra_clk_data)
-			return -ENOMEM;
-	} else {
-		for (i = 0; i < CLK_INFRA_NR_CLK; i++)
-			if (infra_clk_data->hws[i] == ERR_PTR(-EPROBE_DEFER))
-				infra_clk_data->hws[i] = ERR_PTR(-ENOENT);
-	}
-
-	r = mtk_clk_register_gates(&pdev->dev, node, infra_gates,
-				   ARRAY_SIZE(infra_gates), infra_clk_data);
-	if (r)
-		return r;
-
-	r = mtk_clk_register_cpumuxes(&pdev->dev, node, cpu_muxes,
-				      ARRAY_SIZE(cpu_muxes), infra_clk_data);
-	if (r)
-		goto unregister_gates;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
-	if (r)
-		goto unregister_cpumuxes;
-
-	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-	if (r)
-		goto unregister_clk_hw;
-
-	platform_set_drvdata(pdev, infra_clk_data);
-
-	return 0;
-
-unregister_clk_hw:
-	of_clk_del_provider(node);
-unregister_cpumuxes:
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), infra_clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), infra_clk_data);
-	return r;
-}
-
-static void clk_mt8173_infracfg_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
-	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8173_infracfg_drv = {
 	.driver = {
 		.name = "clk-mt8173-infracfg",
 		.of_match_table = of_match_clk_mt8173_infracfg,
 	},
-	.probe = clk_mt8173_infracfg_probe,
-	.remove = clk_mt8173_infracfg_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt8173_infracfg_drv);
 
-- 
2.55.0

