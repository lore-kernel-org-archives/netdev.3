Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A341D22C
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766740; cv=none; b=Sydr0/AiPtOvXmOtgFipswJ6T7DlV+oHg4PImAT3IvVUQQ9ThKnnBCWxY+FQEp5WeV6FAGBzhnKnheUbbb/PO4Qqky+//BFaAxq1VzjlAnWr3+GqmxpOZeb16fnIGvaIOKX/vKlXXnkK6nXai/58HHD/9/mSFm9S6y90y4p2DLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766740; c=relaxed/simple;
	bh=TfeXiYj8llhfrsV1efKFeIRRIiNS2pbhNesZ8nprYFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdOHrpNe5EMLabGH+t0OEn0njH2fxjocoBos/fWfQfpz0+cbYDFoLZ+euR3Qn2EN8pOibGHyNSUMgBpUY0qWpXHFRP9NWY7GJrN1ik3IvgR/8E7fEUQqopp0geYLsIYrWDXpDGWsXQW5JXbzwFViL9Be8LLlRwjzeJOAsnmifpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeeRQRna; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeeRQRna"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc97653887so36799415ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766738; x=1786371538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EFy5iVZEOfPquGcw+vh6esYYUXcjeKTrkCboYc9Z/fs=;
        b=PeeRQRnahyguEvnI/QWPZ203dv9CEG6EFhSRGjI0V8697ptWuwRnclM8OZscNyUyDO
         AXHdQG6h3ctVFuKnmVeQWEL6sr050Qx2ijVXe9uqpEm5N+P2azdZ+e38cougv3MTvwf4
         yHJg0lgn13rNPQ14P939R7LlbJVZSLdgDintnJ3kB5HpUAe9KAjDxaYIR46rSlLF6awd
         8QHidZpiRBxBf7fQW5qqHlAtc6OzTpe9BWX2tzSA3nwyEosxarlagk9uHYQw1oPc0Jd3
         uMzXrIbLPK8sUqhBvQiUDhfR9Sx+lnCO0AJMog3wrGON+Py02caN8z0NZrVHhuMeVr/P
         A0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766738; x=1786371538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFy5iVZEOfPquGcw+vh6esYYUXcjeKTrkCboYc9Z/fs=;
        b=QAmdExycSaUc3ssMEHXRTw0F9RTxGz9m1KwiZ5JuNBW0FT5pO2f9hRglqP3IdbCS/b
         JanSnAI5LYnV5HOMHfrbCJrw+Yk4ueMWHQrbnnk/xyFhVNar2NyFWzQwNH5vH8qqocgg
         XJdzXuaX6+WLHF4YxeuKsJvdFVYbF86YL7v/tH1iBiSlfQVWtlv4Pp89objTumZwGqSP
         RAA0Clt8/2bkPz7w3bgswheteMoyk3DTNnvQrV+Wnv1h8bsjuoRYgPLRfmCp04XCbIR4
         XsHynPDCW160okWo0amzsscO7pNiqfZxQshJQQ13GF+g/8JowTAco6hg4hoq+6wluK1+
         biNg==
X-Forwarded-Encrypted: i=1; AHgh+RpbYyNXAuQfiG0XRzykOlapUtlZtJkjfB4TQ/+WEOwbPrlVxBj+8qZDhvtg1wTQBWFGwsRgj1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWUEY8LQe7vT8TBe0ql+yW5a64xEhyS75I5B+yOf7+sOTt/mTb
	YkxB77atPZm+O3EMyeYsw6K80WSszn64Fz9ebE1dyIpIpJ10PQ49VDPl
X-Gm-Gg: AR+sD129mwqjGlT9+q6tFTRGh+I5sb5wnFRL82Wp7czeFeJxncJVLMQPdGYHlgOJGMz
	HrdUEHI3VeIVTZBNbIzn+/ugj4plOPfTnuC9Ngc6XFU+gPaAVb1gdBAXXnCVqGFmHGenuVlw9AR
	NyskUYgkPDn4cQ/+wVA+UeoVUGDwnS9ha/4r1/mML7BLfJEtkNqp0TtybGDr22M0JUJ+6o2X306
	ie+CFLMTEZjkHPtnx4MB4PLkPBe2+B9uYPNyECBcxMEAP5OB+D4G4IRiOC4MnQa64GdBDa8+3uq
	vCFuOUFWCgfGF2iByo0C/opQGqlJUB7SkYantHH03bRnn0K5WPz9T88bbcaeq2bKjF4ZLITEKjt
	UJLLwuRwpq0/otA2un7hAXYqrUpBVkLFjeDdqvps9XrwU7famv4/4ZYfbjLe2POLcALoVUGoFx0
	nzuOsV9wj4aw4M11jsQCnsDxA89ttT/EKspZwz080uwsF8RFHGOYqMSVCAPaa5092SqJWbY2FlF
	sbKo2b+xon1IZIRTAc4
X-Received: by 2002:a17:90b:3851:b0:38e:dc4:3f64 with SMTP id 98e67ed59e1d1-38fbc52da42mr9027280a91.38.1785766738150;
        Mon, 03 Aug 2026 07:18:58 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:57 -0700 (PDT)
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
Subject: [PATCH 20/32] clk: mediatek: mt7981-apmixed: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:47 +0900
Message-ID: <20260803141659.559129-21-akkun11.open@gmail.com>
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

The MT7981 apmixed driver can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
This change also makes it possible to build the driver as a module.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/Kconfig              |  2 +-
 drivers/clk/mediatek/clk-mt7981-apmixed.c | 37 ++++++-----------------
 2 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index f5460ce3ffba..6449b77d56ed 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -427,7 +427,7 @@ config COMMON_CLK_MT7629_HIFSYS
 	  to PCI-E and USB.
 
 config COMMON_CLK_MT7981
-	bool "Clock driver for MediaTek MT7981"
+	tristate "Clock driver for MediaTek MT7981"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
index 851d0bc7840a..810395aff253 100644
--- a/drivers/clk/mediatek/clk-mt7981-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
@@ -59,45 +59,26 @@ static const struct mtk_pll_data plls[] = {
 	    0x0278, 4, 0, 0x027C, 0),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
+
 static const struct of_device_id of_match_clk_mt7981_apmixed[] = {
-	{ .compatible = "mediatek,mt7981-apmixedsys", },
+	{ .compatible = "mediatek,mt7981-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7981_apmixed);
 
-static int clk_mt7981_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(plls));
-	if (!clk_data)
-		return -ENOMEM;
-
-	mtk_clk_register_plls(&pdev->dev, plls, ARRAY_SIZE(plls), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-		goto free_apmixed_data;
-	}
-	return r;
-
-free_apmixed_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
 static struct platform_driver clk_mt7981_apmixed_drv = {
-	.probe = clk_mt7981_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7981-apmixed",
 		.of_match_table = of_match_clk_mt7981_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt7981_apmixed_drv);
+module_platform_driver(clk_mt7981_apmixed_drv);
 
 MODULE_DESCRIPTION("MediaTek MT7981 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

