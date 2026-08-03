Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18C417BCA
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766776; cv=none; b=bq6T5D/ROy/AUwrnESLIu4BDlRj7fJsHOYFcbxWPNKB6YtSTPrsC8ZVWf24bPMMGyHbEuD641/988rlBV/YWwGds+JEnzFgUsWJHI9mv2rgf4yanqmKRcXsAooBju5t+EYA85pmOwUHFYFGYYOyKP5OOLRPPSGBIrwv7hzPR3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766776; c=relaxed/simple;
	bh=NtVxcaGT3mUFAjsPDRIqpZDl9swMqfFiGNB20NADrKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaLjzs9N5X6PJ+KPy0vP6QGEZTwAMr6UpXuQa3QDpP5zdHt4hKMx+Cnbi0H3ZEDbRfMyKy2oC2SsEHnDvFbME2Bw6jkiZqqRuq9+7FlSmrOUiY//LSni7an7Uqx6uN272zMzw+mZNWvDCW5pOGDjvKlTpg1KwXbD8I2gGaVwX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIGqse64; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIGqse64"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so2982278a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766775; x=1786371575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LxMtUsp4NwM/aEkSRpWjNm7OpZObqtf98j/rMMWK14=;
        b=aIGqse64Qju3m3bzuMskh3sWDCGQjGSGkHbi9EIP6bQMcUaYZc8Las5Tnk7IzX1YB4
         a0+f1ouc4PX0dEij6J9IZqQicP4m9RfakIrrWbXhpEgWFDhvXLz+Cf/Hor3VoXanIrSo
         gBRpp2SttqvD0DQykutoDyeqDAG698cL0HegxMXJYO8O5F89MeAWrV4ITeUWfyix33Vp
         1H95mFXryqQkgjhk+BPzCUxEubkNFgfCFvAcXNCG4557azkgHQG/f6TjV64yebgJ93mk
         y35hAZnr6uJU+4n433rknHqZ8dr78auBdams6pafJVf8wJFEwaGIVW78FshqFnPOP9L+
         GSTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766775; x=1786371575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LxMtUsp4NwM/aEkSRpWjNm7OpZObqtf98j/rMMWK14=;
        b=meZPR6lTjVoo/r4TIiWomTPRfRCs0yBIQNaOfcwG2U6esu+4dvF1tJ+I8YLa47vch6
         0aCpd0Urrsv1eA9oIYScn4qhWUI/+WO0Z8ZVrhrbXMfxVYUcirTMw66AjRNt9sYSjbpw
         CrDKOGzUfwsItp1Tqb+s/4QEO8lw5fsE3tiSRZgxqiYnjwsXFL0Qr4bM7DmzzkHoeTGg
         UH91fsT93XkaupWKHXXIZoefPYW47bVNLVcSAcpR9AJ8xl/Na1F0nYeZraKxJdoFdLfD
         cTmuqBSq1QQg8jzraLydZ5Jh/AWOFXLZ8YD3hNEKuhIyhgYevMrfiRQPk7aWQQbjaEio
         N8VQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsxpmoDW13L6SHYhaERwcudqW6dHnPeOA8yZDC9OH8APrVSuDcSmw9eGcYNgkBqW3saxpOpeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFLiMF57zZ18zh6FWyjlZ0AoexVpf5kxjKMIYiGdG4VbsXZItU
	7iEzc1UQLF2yfvIgBQCaJJM0ao83AnfTkDhwGerzWD0I/z1TEw8B3NJn
X-Gm-Gg: AR+sD10ivWLQgANIs1DO5i4ZmEDRaPJYg1jjnNSLLYY3cHxFtWOWl2x1jGP+sx6tqMS
	0fAhyTly3lDHidnZJBoDF9GfwA0r7L1bLEJfh8yS5TtecnXjOi0BThex5/7e7CqFEdjMGVtBmEN
	sKLzUVm70AZD2ScKoQeBYBAGip5lsofg/YIiFVchkok4h48RHhFukdrnGBmSELEaTIjFUv/aMoK
	QLr6n4kApjTtLnU0uTHs0eA0oUHelzIWW/tdNbK0Y1p0+b+cGVoDlZLk/1grVVX8G2CsmIm9ofn
	rWN+Pdh7lKSlIHmRhZ/PrZmxSUIym9gL3lYOGui91T7lCO8NxRc+IAU/CZMhxq2tZv5DLr8y/oi
	yA0M4TVpCAxocmRZsVgSo7q0hK8hHCelrX6QBTFMDagIuEWElT7WC05X1HdAZ01WDDn2NHF921S
	uYng96VATgAtQKt0V/Vzf4zLJEFcQ5YTNgaCmTE1OvKFR9CoctWE94okkscNagoJq+bfgEXbvBK
	NlCJxIVgLnF4zoZKTk3
X-Received: by 2002:a17:90b:1650:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-38fbc9f3ce3mr7228127a91.2.1785766774810;
        Mon, 03 Aug 2026 07:19:34 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:34 -0700 (PDT)
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
Subject: [PATCH 28/32] clk: mediatek: mt8188-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:55 +0900
Message-ID: <20260803141659.559129-29-akkun11.open@gmail.com>
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

The MT8188 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8188-apmixedsys.c | 60 ++++----------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
index 48a2f61d4b77..3937d93cac34 100644
--- a/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8188-apmixedsys.c
@@ -89,62 +89,22 @@ static const struct mtk_pll_data plls[] = {
 	    0, 0, 22, 0x0344, 24, 0, 0, 0, 0x0344, 0, 0, 0, 9),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.clks = apmixed_clks,
+	.num_clks = ARRAY_SIZE(apmixed_clks),
+};
+
 static const struct of_device_id of_match_clk_mt8188_apmixed[] = {
-	{ .compatible = "mediatek,mt8188-apmixedsys" },
+	{ .compatible = "mediatek,mt8188-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8188_apmixed);
 
-static int clk_mt8188_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-	if (r)
-		goto free_apmixed_data;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, apmixed_clks,
-				   ARRAY_SIZE(apmixed_clks), clk_data);
-	if (r)
-		goto unregister_plls;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_gates:
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static void clk_mt8188_apmixed_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt8188_apmixed_drv = {
-	.probe = clk_mt8188_apmixed_probe,
-	.remove = clk_mt8188_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8188-apmixed",
 		.of_match_table = of_match_clk_mt8188_apmixed,
-- 
2.55.0

