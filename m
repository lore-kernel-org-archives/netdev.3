Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C96430794
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766767; cv=none; b=QFqKoAXHaQMShg87dOnf7jp6jYsBihrwWwgFqOHQXsM20rOac/q+yN94Qybn9uxkfk/aZ9mDlKTGcxMR2ZvjKs/m/D4mO6avvPV6DSz+UhdhO4zFNZYKQpUAlfjBp43SPq6n0DEXX0IDJCcm61+TbMrVbzRsrGLTfh6Zx4Mfd+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766767; c=relaxed/simple;
	bh=k6KGHPhrKgWQTOgCPA4OhlNLLrZr4kds9Mkp+3KdwCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUaeDJ30nM2+NjnvwziF6hqwImrI4D6lvbaKY1wRE5WAQ3jeIHePkysmBAnMqrduXrOzYcQ9X9tby8HL4vMoaDGwMqBXdU4iYQGjJHtdjNaBT8sDI1UOosZGR4Dky4fWfXF3Ta5Wc/HZa5ugwyglMfaU/lqxuZazw/4MWSdCjYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds1mlvVP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds1mlvVP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so3190153a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766766; x=1786371566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hy3U0555sDJ6VNyHLjuVcEq+rtXFfUz3f5cVCQf0hWs=;
        b=Ds1mlvVP0DuD3JdA/TbovHxX1RpmrNYYMbAczdwCmTttByfnc+0Yto5U2m+g1k/p/J
         iZiI5L396RMv9ETE5tadgz8vLdPsuZKQOJje8bZ9lhjjz2l2fP3dYjkrp4NmtT4unXPf
         p7I4zsNarmy1uryCrZfnTT1nisJg1ueVzSu42uMlcanEdlueHceCEcQR6SMBFL5w0i1U
         YXRienZOlEkXCibRTRiZP9ujRYN4PJsa1kvGm+yFh4kSqKWNQMpVnRdtOl6ERzIbzlqp
         kQNZPiHBLJcQGs+ZLUuaEV/mOqMIeyXbqW8uWm59InfUjubYMJfv/iEGQwYKIi1wvx6S
         LL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766766; x=1786371566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hy3U0555sDJ6VNyHLjuVcEq+rtXFfUz3f5cVCQf0hWs=;
        b=dXdP1Dk6xsECgeNBuRcK2hnJjFZHtWvIJF3r6y7uv+dbqA8pAsg6UOFZD5aQjKkrDr
         lhFljyMjKXSD3CYE6AJw3NxWsBvWxI3+jN7pnzLNqdPSU1fxv68mKsPL2znfikKPpYQx
         gZMmoNRogmQjOyeyl5wuoQvReumMlfnqw4/N7IN6/7dLo0V5rqcYio/VoiohYurNoQWG
         306VFGOtTXl3RnjGR3x6LTPt/1t/uGI3XSAExm7Bfr76RLwo0UYN7m7l4qWHcDprmUyE
         05HbrkQH50UF7qTOQIo3PZ7RfAxMZLpj/vTZlcyKD19TtcPuVhZSImYiF4S6+0v7hlDS
         yEoA==
X-Forwarded-Encrypted: i=1; AHgh+Rp4n4tf8yQ1MOlzM3HL2KlOV9woRhQ/3RTuXZ1KssTBstMaGeHRPe8GOqdwucjk0tVLDFrcnM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHo3eQP0xWWpzu30dUGNzLTdmcSLLQhfjletmoSHuP/N34TQDs
	ulrxZrBSlBije4p55rzcpzRzPuCJyzD1YAqqSIhCCEmYUulIPoqQMjNH
X-Gm-Gg: AR+sD11ljkH+pdnoOvAY6x9u7kZAUQUyWJUQMAcKyb3BQ0slIE6Pi4u8s5yPCMTKMtf
	OaILEdqcLm9/UfrO7PJ1WfD9Cu6PfyygPb9IntpQlH8T1aPFW04BBx0BAhhPuEgveWw7os720u/
	YScpkswCgsSjeV6Ynhvz3nv1qf0jsGCVcgYXCIlBmSGbKD+CQUh2TokTlY2LiqUq1toVER+XLUS
	4W/PSJBwIqTHK34/pTJQbqzBpTnHkHT1wP+aY/4RjFCLMK/eCBwSo0JQhxlU72Acgnpf5ypa5e8
	Y/6nmazmuGW/hHxBTKG+U5UiAJztDFzMlch7EGw+ATHXUK+4ewz42zq8CqkYQc/vITjcNTjeYyW
	qTgk4ruvhFrLLT5pZXBOHTGPpnKcfSkhLZJILwK88jHhaKXjG16DQMYljgOcu9o2G4xTmTpAzXP
	/QDSKV2ENdtGqKkpnA32j+Y+PjXJjk+uNwGXx36RKiYgnZgT9ZFaH9V/uXpwR1pkLabILrIZ/zD
	39+SiuSteUFAPVk1J9Vgw==
X-Received: by 2002:a17:90b:4b41:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38fbc409a24mr9807228a91.2.1785766765595;
        Mon, 03 Aug 2026 07:19:25 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:25 -0700 (PDT)
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
Subject: [PATCH 26/32] clk: mediatek: mt8183: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:53 +0900
Message-ID: <20260803141659.559129-27-akkun11.open@gmail.com>
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

The MT8183 clock drivers can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
For the apmixedsys driver, add a remove callback to properly support
module unloading.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c | 51 ++++----------------
 drivers/clk/mediatek/clk-mt8183-audio.c      | 26 ++--------
 2 files changed, 13 insertions(+), 64 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
index 6242d4f5376e..deb96537a3ab 100644
--- a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
@@ -139,59 +139,28 @@ static const struct mtk_pll_data plls[] = {
 	    0, 0, 32, 8, 0x02B4, 1, 0x02BC, 0x0014, 1, 0x02B8, 0, 0x02B4),
 };
 
-static int clk_mt8183_apmixed_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_devm_alloc_clk_data(dev, CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_plls(dev, plls, ARRAY_SIZE(plls), clk_data);
-	if (ret)
-		return ret;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
-				     ARRAY_SIZE(apmixed_clks), clk_data);
-	if (ret)
-		goto unregister_plls;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_gates;
-
-	return 0;
-
-unregister_gates:
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-
-	return ret;
-}
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.clks = apmixed_clks,
+	.num_clks = ARRAY_SIZE(apmixed_clks),
+};
 
 static const struct of_device_id of_match_clk_mt8183_apmixed[] = {
-	{ .compatible = "mediatek,mt8183-apmixedsys" },
+	{ .compatible = "mediatek,mt8183-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_apmixed);
 
 static struct platform_driver clk_mt8183_apmixed_drv = {
-	.probe = clk_mt8183_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-apmixed",
 		.of_match_table = of_match_clk_mt8183_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt8183_apmixed_drv)
+module_platform_driver(clk_mt8183_apmixed_drv)
 
 MODULE_DESCRIPTION("MediaTek MT8183 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index 011d329ad30e..0a53b0408dcc 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -70,29 +70,9 @@ static const struct mtk_gate audio_clks[] = {
 static const struct mtk_clk_desc audio_desc = {
 	.clks = audio_clks,
 	.num_clks = ARRAY_SIZE(audio_clks),
+	.populate_children = true,
 };
 
-static int clk_mt8183_audio_probe(struct platform_device *pdev)
-{
-	int r;
-
-	r = mtk_clk_simple_probe(pdev);
-	if (r)
-		return r;
-
-	r = devm_of_platform_populate(&pdev->dev);
-	if (r)
-		mtk_clk_simple_remove(pdev);
-
-	return r;
-}
-
-static void clk_mt8183_audio_remove(struct platform_device *pdev)
-{
-	of_platform_depopulate(&pdev->dev);
-	mtk_clk_simple_remove(pdev);
-}
-
 static const struct of_device_id of_match_clk_mt8183_audio[] = {
 	{ .compatible = "mediatek,mt8183-audiosys", .data = &audio_desc },
 	{ /* sentinel */ }
@@ -100,8 +80,8 @@ static const struct of_device_id of_match_clk_mt8183_audio[] = {
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8183_audio);
 
 static struct platform_driver clk_mt8183_audio_drv = {
-	.probe = clk_mt8183_audio_probe,
-	.remove = clk_mt8183_audio_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-audio",
 		.of_match_table = of_match_clk_mt8183_audio,
-- 
2.55.0

