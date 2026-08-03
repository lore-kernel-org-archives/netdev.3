Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC44334B8
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766795; cv=none; b=JPa+OtTeqaclK72pVO0x2UJnMgHWS1hHHQ9Nv4xTx182sXeKLE8bOqs5pONgRGcVlohD3UNZ7YcRoEOwjRxiNibDVCo5nGV7xlMid8HhEBDU+8a8G15w4O4Sr2OLP3xnCuxUjdH4LKv4jgJQI5Ve6KrazLnig/fS4AbOI2ABEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766795; c=relaxed/simple;
	bh=jNCP65aQieqvycH3ATo5spW3g3agp/rYSpfMsnveiwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATqphdUsjmJUgGXHT68IvickrEUe2IyQHyGRkhJGCT0Gzwucw9CHPnliEW828q1qS3pbepfsl0j5wDlyqykSRTOtryH5WDsbT4jLJ5JtZPbpdZOk8lGIPnqNz6jTI5SzjYrO2zA/7NfCbYsMcMgWIHwIRxP2Gf4pGK3mnsco6LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l074SK8A; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l074SK8A"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38deea72eebso3261781a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766793; x=1786371593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfu6eLISeoWLoVNrhpCX0FpFSHnnXu01Kfc6jWC5OK8=;
        b=l074SK8AzHnmZ86OdKCIGJwPHvklOmV2IxdKHB/DbNJAXjWDIXEQNbiSCCykVowYeD
         wz9ssHgJiD6MbyfY5nngR33cQ/q3ZsWjHpw8CkNpU1Ym1Gbmx1wbW22TC14iYXEu5lYP
         FY1Hcu3CGf5HKYsE8Rmbict6EYvv0JtMYuaMK8EfEmS47mbXb2PZ//7QItsO6OvtYuWo
         k7xizyK8RUuRw5SK4Rp9DWbwDm7jSBDaeulO28z1EB2VgBiqmmbBm1LXzZE2xbaB4X1L
         +YlP01W14xdbbapZX8a6kgRRhhX70Y4sAbqk9WsFIBX28ziJqsws5Z0ypuzdnfGMuz48
         2tLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766793; x=1786371593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfu6eLISeoWLoVNrhpCX0FpFSHnnXu01Kfc6jWC5OK8=;
        b=DNbClZIjcRM+7/C3k4v0rC80ZmzyiBJzXdKaJ/JNnublUxp/xBvfWb+oCimPlcJcZo
         CZxCfJngMBE5fzrPFIaheDe/I2GVJcbevRzX868XRgxPLTZelMzLKaDJc6iY7uG+DvOw
         +h5/f3wtMrNX3/ydnZKXK8MSow9y7bJbnKOsF6/97tUgRF7S4vqsUMTYrA481FZypn8h
         6UDal4cGVVatpAmhHh0LT4TZNSCn+rU8WECkT4lInGlv8FzUqR1yZ6GTF6EwT3eBKWaf
         Yq/TzsOojr+GfIQfAejFRCI21ySsqNCKgkMNUy6tDvPdeGE+YuABQ7nfYFyy5K/cC3j4
         pGnw==
X-Forwarded-Encrypted: i=1; AHgh+Rre7Q9nbw52yOzypF2pJdfWU0/+cn3xiu5wBRIe845d06ZXr4g/FQkzXZwDSZiaoor++Jin968=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRukHtS0YvsIAhF+VQ49aW2ignpVy2JJS7DFiCivEgolq/IYX
	UrGIZPcTI3vs8Jc1jnsUhsSUXnhg6j2Yic6mRbie1x6lfsMR+dtx8Gcl
X-Gm-Gg: AR+sD13FDP3N0YKMIlo8BTcW9+YZNUvPxwcT8XEN3rOgfMTxPaKAheVIS7LKFESlUaa
	CRkXykR0H/wchV4xD+oGLwkrvixxfQKX2Dq6M4Lrcnrj9j4Xv9sTpEK1qyOxiuhd+JjDnQCdyy7
	QDFT46p36HLuZ6Xfm8TCm3XJfEl6pSZTpeAkMwNViMUVAoEbzrREQdY7oWowyKLrvmoK/PEdDs6
	wg/aR5Sv/e377rUJfcy4CbLs4rtdIsbpAOy8N7j/q52KRX+kxo+icwy9iX1qVW4EsIWRS5laW7+
	erX8wBbdLvGxWdEU8m+M2z40+XFxuH3useqrmzYw3cjiUK/0Xvcpnb9xdRSk+4lnHBY+S4hlksp
	/k7kpfdLRhWqXYRhXeQQihQ00TCA9eelaMbCo8pTj/T9PQ6KKWMtQmn82oS+etya8qIHPWRzaDf
	EvifA5o/w0YKntou0QFuiGu2yqZY177N4xC0aOODDUboOFevEVAowwP6VRbh2fPkXpgXOcx4N0d
	Q47sXyzrReklHQ6qrxdHfltrpxvpi8=
X-Received: by 2002:a17:90b:562b:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-38fbc4053e3mr8607547a91.6.1785766793277;
        Mon, 03 Aug 2026 07:19:53 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:52 -0700 (PDT)
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
Subject: [PATCH 32/32] clk: mediatek: mt8516-apmixedsys: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:59 +0900
Message-ID: <20260803141659.559129-33-akkun11.open@gmail.com>
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

The MT8516 apmixedsys driver can use the MediaTek clock framework
common initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
Also, add a remove callback to properly support module unloading.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c | 42 ++++----------------
 1 file changed, 8 insertions(+), 34 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8516-apmixedsys.c b/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
index 2a6206cae2f0..2fb09e7acde7 100644
--- a/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
@@ -71,52 +71,26 @@ static const struct mtk_pll_data plls[] = {
 	    31, 0x01A0, 1, 0x01B4, 0x01A4, 0),
 };
 
-static int clk_mt8516_apmixed_probe(struct platform_device *pdev)
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
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_plls;
-
-	return 0;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-
-	return ret;
-}
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
 
 static const struct of_device_id of_match_clk_mt8516_apmixed[] = {
-	{ .compatible = "mediatek,mt8516-apmixedsys" },
+	{ .compatible = "mediatek,mt8516-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt8516_apmixed);
 
 static struct platform_driver clk_mt8516_apmixed_drv = {
-	.probe = clk_mt8516_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8516-apmixed",
 		.of_match_table = of_match_clk_mt8516_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt8516_apmixed_drv)
+module_platform_driver(clk_mt8516_apmixed_drv)
 
 MODULE_DESCRIPTION("MediaTek MT8516 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

