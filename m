Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA8423160
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766721; cv=none; b=T8jmqX10xdRX9/vbjFG8YofwJKYbdnByL5lbwNmA2Ae44fJa3PC7y6I9HMgHtuxuX3qyFanYW7C6fF7HhIPKPxLe2UPMkxanSwl1jkibIjmKY0EgiL8FajncS61Q4bkpl42G5iw1BdPR+7BHDd7vJr35ebTxE3mJwWsyI1Lbd7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766721; c=relaxed/simple;
	bh=OrNFe5k+TZyNKskP8BGx59d/NeQDkWbBITWbkj+NMkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYvBTbL3DoU/6M4kr538Y9rOWTcnJ6gQiYTo//iiLIsIwaEhoJFYs5Ip8OtShTa4SJvLFvDIgZAqEu9AcGJlHObbSYF4sY16TEx7igv3HGY8upl73YxN8JxpvZAJOYx1Zn4nGm54SJlY/AC+FaO9ezXTBnX7pprv1LdYtt0Pxjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAsvkb68; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAsvkb68"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2301694a91.2
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766720; x=1786371520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sBoJSR+t4o6rLEYzXc6evi5ADYig1EhmcESvsg7Klw8=;
        b=DAsvkb68325eS2K45ENvXF8oVI2o+3kg0oyIo5a/CdnWTbMRSnucPyHocAwEBiN3XX
         u7luPGHb4NJyU/EkZlfVcmeIckXJa+k4rjsGFopdXfaupkvllES5y9CuRptD0r9VejJk
         o0GMLRm18c4FzmIR9SSlvVDBArNqaoz3QJiVuwoTlbNMtWuwL50zxqCCVKadqz6nGgvX
         eDGrfoAJfmvZmaoDqODHhFUiTdGQ86uXZ7PalQ2xCEOK1rdkh8/fzqbhq78eyf5qdpd4
         8rfry17YHJy51nJjkRShvesydeJ1XfQcrpDo3Uha/O+r8iitF0/aR3gHMnyXpk4NHHYb
         LlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766720; x=1786371520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sBoJSR+t4o6rLEYzXc6evi5ADYig1EhmcESvsg7Klw8=;
        b=jCZWeXhkR4W2TipY3EOzVdnVuBsRcnW2a5BdFz8tv2mS3ZPM8WdazpZ4Hf3dbQvwVi
         prCRPltXKXpGps5A2zdSqel57sHAA4V+jiSdq0kF0bC2KtSRqQBfwebmdoMwsU6uTx8f
         cAPguoNprsBY5dPuHnMVJ4Xau+m8DOFR2fJ8Nz4kLYv2QKUV1W5ejmpKMD9i4eTFzXK5
         yq7Nf5EEcOfL/rtmteSx4UHPuWfED1gaZsxlAPWrGFU7Z3lN43uVM/shp04dP9ufHrAk
         saNMemp7HGrb0EvTEUof73TjGhvzZ3+dyPtAdQDZ0ZkvuLhu++OJ3nyDXjb2o7syO0T2
         +chQ==
X-Forwarded-Encrypted: i=1; AHgh+RpV7qoynTq1dhNL8++fPru2bA2VadYNKcQu7wFd30BxJPr0N3FoufXhH8A7OhORNo9FuXcYWT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAftA4/I3dhsBdVi+ciBDZSx6L5F3kBqo+fhOtWQ3/ltpQKjmp
	eN0fvJf6sJ3aCwe+5/VJFJeTRzuQ4d+s0UhznCoaRBRoMwDifeb9YZH8
X-Gm-Gg: AR+sD11lPixRza81zhY30EzrpVVerxpuWGinzvaZq5oMlrAFMW/m3bVCHtUZGuJj+t1
	4sFANtghms0k+R7a0y1X9PxWreOHWtAnNblFn8LRr9JNTWVmVceg/Ima0WjJ4uG29r14SpNfGFs
	XjScyCpBoSWb4ldh2b9aJ/iTsvep2MWnsdrc4USMPOxgSvy3sKoGqzvB5kGXnqn7ASWiyWy6Pc2
	oxxvzQOfPVl5DC6JXmQ4eLr6wLh5010aVr5zl8eBxtVuZEax71EPnXMHdStUOIgwhbRlwHEqVId
	cHm9EpfE2WfSKWPokotn2kZlXJkrIvhNP4ABXgDuERuazGy0sa79o7n1DaP7Wnc5/CLmPXoC+Uy
	lHB1qYXR5QoRmJxvvfWnpgIl9cb1jcSJiu+GVR7SKujBT5yAwCL7w0JH8/nZYCKAnomRH9EuAN3
	4qhwsTeYDYJmFQ1D6IrFiWSYpbSQO3WUjm65uCgu5afGh0nHD65LHVPndfyQr0hOuwDiSDGeFbp
	IU9tvdy1ukqnx1Iiqi7XbnlqBQiZBk=
X-Received: by 2002:a17:90b:57cd:b0:38f:1a80:d1e7 with SMTP id 98e67ed59e1d1-38fbc437c4cmr9229318a91.13.1785766719653;
        Mon, 03 Aug 2026 07:18:39 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:39 -0700 (PDT)
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
Subject: [PATCH 16/32] clk: mediatek: mt6779: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:43 +0900
Message-ID: <20260803141659.559129-17-akkun11.open@gmail.com>
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

The MT6779 main clock driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Additionally, merge the separate infracfg and other drivers into
a single platform driver, and add support for the apmixed and
topckgen clock controllers using the consolidated of_match_table.
Finally, replace the custom arch_initcall() initialization loop with
the module_platform_driver() macro.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt6779.c | 124 ++++++------------------------
 1 file changed, 22 insertions(+), 102 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 4b9dcb910b03..a806789ae27c 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -808,7 +808,7 @@ static const char * const i2s5_m_ck_parents[] = {
 	"aud_2_sel"
 };
 
-static const struct mtk_composite top_aud_muxes[] = {
+static const struct mtk_composite top_aud_muxes_divs[] = {
 	MUX(CLK_TOP_I2S0_M_SEL, "i2s0_m_ck_sel", i2s0_m_ck_parents,
 	    0x320, 8, 1),
 	MUX(CLK_TOP_I2S1_M_SEL, "i2s1_m_ck_sel", i2s1_m_ck_parents,
@@ -821,9 +821,7 @@ static const struct mtk_composite top_aud_muxes[] = {
 	    0x320, 12, 1),
 	MUX(CLK_TOP_I2S5_M_SEL, "i2s5_m_ck_sel", i2s5_m_ck_parents,
 	    0x328, 20, 1),
-};
 
-static struct mtk_composite top_aud_divs[] = {
 	DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0", "i2s0_m_ck_sel",
 		 0x320, 2, 0x324, 8, 0),
 	DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1", "i2s1_m_ck_sel",
@@ -1211,125 +1209,47 @@ static const struct mtk_pll_data plls[] = {
 	    0, 0, 32, 8, 0x02D4, 1, 0, 0x14, 1, 0x02D8, 0, 0x02D4),
 };
 
-static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-
-	mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
-			       ARRAY_SIZE(apmixed_clks), clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
-
-static int clk_mt6779_top_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
-				    clk_data);
-
-	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
-
-	mtk_clk_register_muxes(&pdev->dev, top_muxes,
-			       ARRAY_SIZE(top_muxes), node,
-			       &mt6779_clk_lock, clk_data);
-
-	mtk_clk_register_composites(&pdev->dev, top_aud_muxes,
-				    ARRAY_SIZE(top_aud_muxes), base,
-				    &mt6779_clk_lock, clk_data);
-
-	mtk_clk_register_composites(&pdev->dev, top_aud_divs,
-				    ARRAY_SIZE(top_aud_divs), base,
-				    &mt6779_clk_lock, clk_data);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
-
-static const struct of_device_id of_match_clk_mt6779[] = {
-	{
-		.compatible = "mediatek,mt6779-apmixed",
-		.data = clk_mt6779_apmixed_probe,
-	}, {
-		.compatible = "mediatek,mt6779-topckgen",
-		.data = clk_mt6779_top_probe,
-	}, {
-		/* sentinel */
-	}
+static const struct mtk_clk_desc apmixed_desc = {
+	.clks = apmixed_clks,
+	.num_clks = ARRAY_SIZE(apmixed_clks),
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
 };
 
-static int clk_mt6779_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *pdev);
-	int r;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	r = clk_probe(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
+static const struct mtk_clk_desc topck_desc = {
+	.fixed_clks = top_fixed_clks,
+	.num_fixed_clks = ARRAY_SIZE(top_fixed_clks),
+	.factor_clks = top_divs,
+	.num_factor_clks = ARRAY_SIZE(top_divs),
+	.mux_clks = top_muxes,
+	.num_mux_clks = ARRAY_SIZE(top_muxes),
+	.composite_clks = top_aud_muxes_divs,
+	.num_composite_clks = ARRAY_SIZE(top_aud_muxes_divs),
+	.clk_lock = &mt6779_clk_lock,
+};
 
 static const struct mtk_clk_desc infra_desc = {
 	.clks = infra_clks,
 	.num_clks = ARRAY_SIZE(infra_clks),
 };
 
-static const struct of_device_id of_match_clk_mt6779_infra[] = {
+static const struct of_device_id of_match_clk_mt6779[] = {
+	{ .compatible = "mediatek,mt6779-apmixed", .data = &apmixed_desc },
+	{ .compatible = "mediatek,mt6779-topckgen", .data = &topck_desc },
 	{ .compatible = "mediatek,mt6779-infracfg_ao", .data = &infra_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt6779);
 
-static struct platform_driver clk_mt6779_infra_drv  = {
+static struct platform_driver clk_mt6779_drv  = {
 	.probe = mtk_clk_simple_probe,
 	.remove = mtk_clk_simple_remove,
-	.driver = {
-		.name = "clk-mt6779-infra",
-		.of_match_table = of_match_clk_mt6779_infra,
-	},
-};
-
-static struct platform_driver clk_mt6779_drv = {
-	.probe = clk_mt6779_probe,
 	.driver = {
 		.name = "clk-mt6779",
 		.of_match_table = of_match_clk_mt6779,
 	},
 };
-
-static int __init clk_mt6779_init(void)
-{
-	int ret = platform_driver_register(&clk_mt6779_drv);
-
-	if (ret)
-		return ret;
-	return platform_driver_register(&clk_mt6779_infra_drv);
-}
-
-arch_initcall(clk_mt6779_init);
+module_platform_driver(clk_mt6779_drv);
 
 MODULE_DESCRIPTION("MediaTek MT6779 main clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

