Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF5342AF9D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766744; cv=none; b=TtpxKg20UNT4UPHgl2AdsH0KrvJZvnl4RGNE7LojzHDR/FLLA3wySANt90piR+nQq1GLuwzrcgfsveH7fnNIUS004gMO7IT7+mDtwBfP/vlVBDZ7HUoocYH89el0p5xsUPHGUl/R9ZjwmK/ECOhS2OnShOHQ3KKDW1dPKoKBKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766744; c=relaxed/simple;
	bh=V+xiIh8ybmCYAvwYMo5Mm6jhKxCUQbprWmuQ6vVtMh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ccg/HxEN1qPpIQV5lA4y9mkbV9Ob6GQMdMsqLmcpL12u9ZNhzRevR+lUUpLsOYgUdcOATXq8kVMEJNOP448iXAnIDL9LR3f0b3VZ8ReUvJVevnuFNAZNIeYi19tRWiQwhEr2rtJ4CLJHc8oi/MnR1lfrddlPB7oSP1wgyDpVdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrBg/Tyl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrBg/Tyl"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so851014a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766743; x=1786371543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m4Z5pWHAYmt7m7KtNfIU1rNnfqDpY05zeAJJ5XpoEVA=;
        b=IrBg/TylTUJZOjlcVpy+GrG3Wb8HJ3ahGe0a3qtcfVH5Z/SFOgCOMMGQuHnD/OqfCL
         PP/lvecXMhEXRvu+l2soEFy3qF0XwZvBAhS89EIiPEEjGg23KACiejaLdkPEXibStrOh
         Mt+ZyHvCN3Wg6jmi8/65upeQhiDakdiHLePLI3yd3XJ586+JIiDTPWR/HW0sMBGalqzI
         M3m30OyvtyARMCBKWosiMleIvXpauksD886fYz36K5Vj9ALZTbVmLbgVh2OgK5U5HLjc
         X/kwgys1w+l6GyNo5q4eQ0qdcDZ1gXxnkap3MkftT7tubkzW5M97PfvCv0wRGgYxkKUT
         LHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766743; x=1786371543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m4Z5pWHAYmt7m7KtNfIU1rNnfqDpY05zeAJJ5XpoEVA=;
        b=l3lw3FYaDD5FMU40Yy5vQL71jD5uDT8+JF+c68DN0ae0+MNCRX0Gl1DgZCy2UeAEss
         W0/ec3p8x9KmzKD5YAdXHYD/IJ/r0JRDbK+orhwAmVquralCUFM8OXaUHWLr/WkSrzTB
         ecPDrLFzfYNeEpjMNzXlPUr4s9cKrSSVgu71JSVXJP7BsIhFckqE3hYruQK18P1AGlJC
         oc0N5WqWKhni+PJrqK/oY1mZChV3/MZGRBRpRv4uV786Y1PRrkSZRDoZ29161DppVaac
         j/RBu7iQWXPnygVZBpGn/3q9vx37OTQ39rR1Y56H9lFdL1RvljP5B89MHyI8KZFpIVr8
         BKuA==
X-Forwarded-Encrypted: i=1; AHgh+RqbzwU2CqwKay0Wp3OAQv162eXFJ2YoqnDHC2e8dF+RuVXs8cp3yt/a482EzVru6MNcB+ljNYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjDPckhrnvzzpjnF9Yza6wtgoRWenL0PMClXNrkB+tlXqVkBlP
	Db6d1CIBuIx3ODIZ6wI385c6F6IHyVZH2LQY5IPWJ4NU/t+WFhwo5q6O
X-Gm-Gg: AR+sD12XwWafPknCkVrSqNuYtlvfugLawrn1EMeOZ0SeqU6TDMRgSPyuxlj2XbVP/aN
	t0fnP/doKz4uc0THeivgALAfh10r+8kJYFIayCbR92CaJmv+7MClKykNyQ709elcvrBDU0G0V68
	RJjEx0MsWluPvcjkx1QN8pDxwmwCE/TSY6prMygpCd1DN91yiBqOsW7UzYXUChEOFQ5/fjVJUwy
	lYJcUs2f6MFtuP0Z53iWm3B51yRoY/8lGPssdqBuCNohIUoipZLIG32w8RkLuwFb5cLOLe2LKsA
	WsYp9QVbxq03spDN6mDSAyejlRmxomYMf7QPgapAdoEpvH0PhMaS3ocvbTW6QqHmceB25kjf5dZ
	tWaHcGja6eBoEGNOSDrxPCS09D9biuDGM275UW7RM03gLARzf4Mb4zdKaj9YiOJceofrFsdzE3B
	tLIJsoRwDw00owWSQs8FnkrFUi0kTQwDolDtf3sC0bEUvrGwlufmcM+tR+iMaKofjo/RG0VzLJf
	Pg30THnb19N9XancctX
X-Received: by 2002:a17:90b:4b41:b0:38d:e658:595a with SMTP id 98e67ed59e1d1-38fbc409a24mr9805618a91.2.1785766742716;
        Mon, 03 Aug 2026 07:19:02 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:19:02 -0700 (PDT)
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
Subject: [PATCH 21/32] clk: mediatek: mt7986-apmixed: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:48 +0900
Message-ID: <20260803141659.559129-22-akkun11.open@gmail.com>
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

The MT7986 apmixed driver can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.
Also, add a remove callback to properly support module unloading.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt7986-apmixed.c | 37 ++++++-----------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index af3e002bbfb7..6df3e9555e4e 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -57,45 +57,26 @@ static const struct mtk_pll_data plls[] = {
 	    0x0278, 4, 0, 0x027c, 0),
 };
 
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+};
+
 static const struct of_device_id of_match_clk_mt7986_apmixed[] = {
-	{ .compatible = "mediatek,mt7986-apmixedsys", },
+	{ .compatible = "mediatek,mt7986-apmixedsys", .data = &apmixed_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7986_apmixed);
 
-static int clk_mt7986_apmixed_probe(struct platform_device *pdev)
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
 static struct platform_driver clk_mt7986_apmixed_drv = {
-	.probe = clk_mt7986_apmixed_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7986-apmixed",
 		.of_match_table = of_match_clk_mt7986_apmixed,
 	},
 };
-builtin_platform_driver(clk_mt7986_apmixed_drv);
+module_platform_driver(clk_mt7986_apmixed_drv);
 
 MODULE_DESCRIPTION("MediaTek MT7986 apmixedsys clocks driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

