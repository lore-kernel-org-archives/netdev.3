Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3B387348
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766718; cv=none; b=e+9XsaL3D9/b0cUeZsKApjVWK3cex5tIEsM+uEvPIzTvj5l+BvLJ8oGwgA/45R5RldeZfFpFio5cd1Wk9Bba3Qe/Clouj9ZVGsHh0uzwcefuFLRODyfVX91UuEI4EY0g8kOzByNLOWs9J6fWwBjpqgi+DwJxtaMC8O7XtfeV4qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766718; c=relaxed/simple;
	bh=iS56/w5zwgTuZe6g4za285IBHTIuTkz5F54AoTpLuP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNh7h+9NCY7zbOmrzt8uE+NiHJbkdqP67hgTMBlewttu3vX+8QkdONy5aH0qB9EzSX6p+bKD3TslA60VJPO+NCoZ75/oLrQmAoywES77NvOk+ohVpC098Y4zkgr3tiBqGuUgOn28kJvmIAhYb0EscZFHz3L9TXEd2MxjsZj6eC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3xaqMm/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3xaqMm/"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-383cb94f742so3408080a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766715; x=1786371515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3K3Yx6VzHM8GIbCrqX9zZGoEb/ITQ0QyQysBjSMYncA=;
        b=q3xaqMm/r8PYl7lEUcTMjjSZp9kCMSMfYiXOUplLVhVFmr4ZAtPSboLZnqoAJBPMCc
         4PIDfpRYXHywQdYq+hIhCTtnGt8p8DAG+5jnRSmENaaV+we8k2UGLANq65+lTZtgBXV0
         vdwwBnmE3z03+exDMEofi1TwC0ZcR/1tQEzWrkN9slrlv20UNwKjwFlJRagd7xEQaRgm
         ZYfa6SBM4csEceuGHB5ov4pq0UxQmd9iIUlInyek0EdBf791BxmAKfjXzjnKwzEd5LGT
         64sfhVgfgdLhhwCmT78cNRJAfQNwZfcPFD9xNLc4rJy7WRCtsiCl/dg3SThkMV6pYcqx
         1nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766715; x=1786371515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3K3Yx6VzHM8GIbCrqX9zZGoEb/ITQ0QyQysBjSMYncA=;
        b=QDBUr+7UOqdMLAdRHMqeXpI0pIuSNekLcUdrSJ2R1ZmaOxWL9QUCgAFMtDUTeD7yxv
         NAVjqtpCZXRVxges14fQO/xeI5Nh4Xy0SUFeo9j+wQcxaZsqybG4qEyIvLvDGMSY0MC3
         WdoYpmrVxSoDVTLSD9S+7gkmG3ueFfS6S21p+OqG/AR6LKKyFiXIOnEdOM51Yi9bGDoc
         IBjc0vLZoKO641wtUL0lirjl7m5WtluAGUTBrFBPRH6mJjOlXwHDtBFz22QU3Yol7s7T
         WIWynIjDP6PGFcorW/1C0/Gfk08ZiRCqNYb/ItPsppkJGBlOU0T/fH3QFxv0Lely3RX7
         U4VA==
X-Forwarded-Encrypted: i=1; AHgh+RrZiVD8RuPOzWQwAOYdZo4VrkB5sSAAybZFLQPKC6U9p8kmQqfyv3/XK9uC1UT8Vo0vlfQU4a8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+v42tsS+KTCBVdwZTeftH2VcVzJEEpdCIdOeoqBeB2I2mrWAk
	yBk6oK1Mqnlg7akxt3GKMgntkB7cvk8QXFbuzzx+5GeMjoWUXRG3EdJA
X-Gm-Gg: AR+sD10p4VfjCIFoheoXpndPgW/MwqtnMZtpvjdXiPtYBQnRqQAOJrKvcX++nIQDa2o
	SIu6rR7Q4O3zw+7K/a+u1OmBTAT6TkcbafnT2hXqBuxespsCp3DoZAA7dkKxAiLfSJ3Pfh0PTEr
	9DxC927j6tl3WR+LEL7SZiDOXBQrcvYi9ylGiFtyNoeXXxRad/mpTQ+ceuryo0LeyUOyA9mFBIo
	HSdh2IGFIdknq5C726IGUDUXiYF8QxVW/37BWq+r5hQzlqaN1OO0h4J7oQMA4O6qEtP/h931PYz
	E/lHNSw0GZZHytMXsecEYwY85434HVzs24AVfJzpUL1yIbFUvnK3Qlce8BNxuhs8O3v6MWszyOa
	tGJ+HxA2CIsZQlEWahwycq9WiruAp6doouxV3TowMJto0IB4I7clDyM1Oghjz9Q3fe8AsghgLup
	fporh84cZMcHbmvaOh4O+KX5EdozSUMzYP6sLv/mKcQ+snX2ALImgoX+lXXmhojayAn4ucaVJs/
	dzmI791xqKGK2MI4z60
X-Received: by 2002:a17:90b:280a:b0:38e:97f0:aa4b with SMTP id 98e67ed59e1d1-38fbc4542edmr8751782a91.13.1785766715117;
        Mon, 03 Aug 2026 07:18:35 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:34 -0700 (PDT)
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
Subject: [PATCH 15/32] clk: mediatek: mt6735-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:42 +0900
Message-ID: <20260803141659.559129-16-akkun11.open@gmail.com>
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

The MT6735 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt6735-apmixedsys.c | 48 +++-----------------
 1 file changed, 7 insertions(+), 41 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
index 9e30c089a209..94cb0bee8bb4 100644
--- a/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6735-apmixedsys.c
@@ -77,54 +77,20 @@ static const struct mtk_pll_data apmixedsys_plls[] = {
 	PLL(CLK_APMIXED_APLL2, "apll2", APLL2_CON0, APLL2_PWR_CON0, 0x00000001, 0, APLL2_CON0, 4, APLL2_CON2, AP_PLL_CON_5, 1, APLL2_CON1, 31, 0)
 };
 
-static int clk_mt6735_apmixed_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct clk_hw_onecell_data *clk_data;
-	int ret;
-
-	base = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_devm_alloc_clk_data(&pdev->dev, ARRAY_SIZE(apmixedsys_plls));
-	if (!clk_data)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, clk_data);
-
-	ret = mtk_clk_register_plls(&pdev->dev, apmixedsys_plls,
-				    ARRAY_SIZE(apmixedsys_plls), clk_data);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to register PLLs: %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_onecell_get,
-					  clk_data);
-	if (ret)
-		dev_err(&pdev->dev,
-			"Failed to register clock provider: %d\n", ret);
-
-	return ret;
-}
-
-static void clk_mt6735_apmixed_remove(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	mtk_clk_unregister_plls(apmixedsys_plls, ARRAY_SIZE(apmixedsys_plls), clk_data);
-}
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = apmixedsys_plls,
+	.num_plls = ARRAY_SIZE(apmixedsys_plls),
+};
 
 static const struct of_device_id of_match_mt6735_apmixedsys[] = {
-	{ .compatible = "mediatek,mt6735-apmixedsys" },
+	{ .compatible = "mediatek,mt6735-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_mt6735_apmixedsys);
 
 static struct platform_driver clk_mt6735_apmixedsys = {
-	.probe = clk_mt6735_apmixed_probe,
-	.remove = clk_mt6735_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt6735-apmixedsys",
 		.of_match_table = of_match_mt6735_apmixedsys,
-- 
2.55.0

