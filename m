Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F14279FC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766735; cv=none; b=hB3sGLS8zizSIB4d6KeVdm4rnql3xzhV+KIvGLeBQW/swyglP0fk9ecA3oY+Jm5K89txnCc6oHNGzfIuBZvipgDbOy8oyv1+MDn2W24+udQh9zwSsCIXGIRkLwm8vLyEdSAyV4+ylSP+2F/EPOTyDhTuyCBAt0G0cR95GSNyRkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766735; c=relaxed/simple;
	bh=S0dLfeua7VDe8xoo/2jE9K/Ua2DjC3jXDY11zMBoG7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXvhje6miYc85cP6oJKuqLfRB33ypZl9v5Obd/FfrJw12Lv8vkaI7L11Kovy8naAxKCPRAcj3kJdnWHv2Js8omZEtJOjONQEh4n7TjCoxIdNkdS4OJJ79OfahbLjxucJe0tiULd8qIwMnG53itf2JyssDiERhAkz971mZNNvhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMAw1CPk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMAw1CPk"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2873982a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766733; x=1786371533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HeejemYXNeCI+G618X39Md1/hOA1PJGV3DxHUDmwxX4=;
        b=SMAw1CPkO3nu948CZzkm+dTryjiKjRs9OzkGJdlGlgxh6ia77v9pP2Tq8ac+Is6Cau
         /yMKpZ0022XqiBGjvMVgSuAk8lL8JX+EziI2Rft8VoelMZsXatIRBkSDT90rYHZoxroc
         iKfWEZ8jpea1tuSaIvkPFpxwIns7LoTX5GDiNkC3yOqjunDX41X74B2d2Tey5eOmP/B7
         KaVnJtvjYqAUlcVECOfdUVm9LhfgsX28wbFPcE+g+FZsG/+wGsh0ezd9ePyBWykysnac
         C/Eo8rykY/QuOC9o8MIzW4NYK4W4dZuXWTTZPK73iPvGGFaytJs5QDhDF/a6v3IaHTPB
         0NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766733; x=1786371533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HeejemYXNeCI+G618X39Md1/hOA1PJGV3DxHUDmwxX4=;
        b=r8oOQVdUP5+iwBsjMBIMraVgXS+e0gIokOtrdT2eqEJpXPDzn7dCuBYmKfsoMKImvv
         KUF529xDhtPNmIx5Hq0qmVNu90vs7R+Pmr22k6ZBQeZaM3wo26eY+z6DbLaLW5NKgfi7
         eVhqeZCEiPTCWBZyYCmbH/T+U8bJ5JAMhSCpdtCPK/d6NJpr/x/UBCCJlFeI8wzxd8P8
         ZMZjuadzp8kFeIoaASAQ0tf1KLP0P5ePRC1QnS8zHBwrGD/W147G5hgMvTaQq+R3fybM
         vdx48Vupjfj/hMkIB0YeCbF6VvmFxPmvgLxzqPE955zxIZOogNsno4S7o4Rlvih3aECj
         4CyA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8lhm7Rc3ctAr0KXePPh5185A603cd+CUEXFjBsthMhxurtxPWQae6BmabAo58kTw8ykHkmJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybCRDiJUGrrp49NqxBh1/43+oSdI28Rp7dlxgB/wFXd6cARmJK
	ajpbhhfaG75H66Y8uIxDhLcnNLv1dSt7OPND0TNjRx5fsMgKcFfD5V0u
X-Gm-Gg: AR+sD10s7v+HmhxorIv+89bbWnFGpI2tEVQuZEs8GzUMo7DclEAW4f7lK7V4uCKkale
	1d/vSCqLNKu4/E4SOIS342Ps39DUfJBDqexQQ4+H+u8SBYDYpBSI1kapNB3zfL5Zod1+zWcm1Hk
	ZYo211kZou2FV32rt0RYod8+W9+ABaEYtSJOt6TnS3P77TiEDp8cAYE+bRhXkklAp/Zw+SGA+p9
	P1ZnLdNmmsnAoVa/Hzm4rMu7d2AhvZsQ7aUYct1znq2l3NyQEl6Y3D2aEM+DLLBQmlgXt2GzADK
	/fnukyouuxI0+4CJNx53TbRYTIBg6jZVW3FmyvkpboCn+LU09UFKAP6wGmIff0urZwF+gUnNlUF
	tSRv4ey4RBsDahtKEtsd2UJUy7JgrnpxyK4ZW1kMp4Xyv1n+GrFTv1BeQpEsvFxlOhT/1OTI8Bb
	EFjFPMu38ZrDJb6yKDosl1TUTIjZJpePZVvlI0M9OAfU7nSiy4IZggbt0j5u3NfJSgHU+QZYehU
	o2w1NsAJNIt7Ff+hfvh
X-Received: by 2002:a17:90b:2251:b0:384:5dbc:cba5 with SMTP id 98e67ed59e1d1-38fbc4cdedamr9398208a91.26.1785766733423;
        Mon, 03 Aug 2026 07:18:53 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:18:53 -0700 (PDT)
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
Subject: [PATCH 19/32] clk: mediatek: mt7622: Switch to common probe/remove helpers
Date: Mon,  3 Aug 2026 23:16:46 +0900
Message-ID: <20260803141659.559129-20-akkun11.open@gmail.com>
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

The MT7622 clock drivers can use the MediaTek clock framework common
initialization sequence. Reduce boilerplate code by creating
struct mtk_clk_desc and using the mtk_clk_simple_probe/remove helpers.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 62 +++--------------
 drivers/clk/mediatek/clk-mt7622-aud.c        | 35 +---------
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 72 +++-----------------
 3 files changed, 23 insertions(+), 146 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index fae8abda14b3..e9f731eadace 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -80,66 +80,22 @@ static const struct mtk_gate apmixed_clks[] = {
 	GATE_APMIXED_AO(CLK_APMIXED_MAIN_CORE_EN, "main_core_en", "mainpll", 5),
 };
 
-static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
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
-	platform_set_drvdata(pdev, clk_data);
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
-
-static void clk_mt7622_apmixed_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(apmixed_clks, ARRAY_SIZE(apmixed_clks), clk_data);
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-}
+static const struct mtk_clk_desc apmixed_desc = {
+	.plls = plls,
+	.num_plls = ARRAY_SIZE(plls),
+	.clks = apmixed_clks,
+	.num_clks = ARRAY_SIZE(apmixed_clks),
+};
 
 static const struct of_device_id of_match_clk_mt7622_apmixed[] = {
-	{ .compatible = "mediatek,mt7622-apmixedsys" },
+	{ .compatible = "mediatek,mt7622-apmixedsys", .data = &apmixed_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_apmixed);
 
 static struct platform_driver clk_mt7622_apmixed_drv = {
-	.probe = clk_mt7622_apmixed_probe,
-	.remove = clk_mt7622_apmixed_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-apmixed",
 		.of_match_table = of_match_clk_mt7622_apmixed,
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index a4ea5e20efa2..6004c58be1b5 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -110,38 +110,9 @@ static const struct mtk_gate audio_clks[] = {
 static const struct mtk_clk_desc audio_desc = {
 	.clks = audio_clks,
 	.num_clks = ARRAY_SIZE(audio_clks),
+	.populate_children = true,
 };
 
-static int clk_mt7622_aud_probe(struct platform_device *pdev)
-{
-	int r;
-
-	r = mtk_clk_simple_probe(pdev);
-	if (r) {
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-		return r;
-	}
-
-	r = devm_of_platform_populate(&pdev->dev);
-	if (r)
-		goto err_plat_populate;
-
-	return 0;
-
-err_plat_populate:
-	mtk_clk_simple_remove(pdev);
-	return r;
-}
-
-static void clk_mt7622_aud_remove(struct platform_device *pdev)
-{
-	of_platform_depopulate(&pdev->dev);
-	mtk_clk_simple_remove(pdev);
-}
-
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
 	{ .compatible = "mediatek,mt7622-audsys", .data = &audio_desc },
 	{ /* sentinel */ }
@@ -149,8 +120,8 @@ static const struct of_device_id of_match_clk_mt7622_aud[] = {
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_aud);
 
 static struct platform_driver clk_mt7622_aud_drv = {
-	.probe = clk_mt7622_aud_probe,
-	.remove = clk_mt7622_aud_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-aud",
 		.of_match_table = of_match_clk_mt7622_aud,
diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
index cec19447d637..2e463d1481d0 100644
--- a/drivers/clk/mediatek/clk-mt7622-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
-#include "clk-cpumux.h"
 #include "clk-gate.h"
 #include "clk-mtk.h"
 #include "reset.h"
@@ -51,76 +50,27 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
 };
 
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.cpumuxes = cpu_muxes,
+	.num_cpumuxes = ARRAY_SIZE(cpu_muxes),
+	.rst_desc = &clk_rst_desc,
+};
+
 static const struct of_device_id of_match_clk_mt7622_infracfg[] = {
-	{ .compatible = "mediatek,mt7622-infracfg" },
+	{ .compatible = "mediatek,mt7622-infracfg", .data = &infra_desc },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_match_clk_mt7622_infracfg);
 
-static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	void __iomem *base;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, infra_clks,
-				     ARRAY_SIZE(infra_clks), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = mtk_clk_register_cpumuxes(&pdev->dev, node, cpu_muxes,
-					ARRAY_SIZE(cpu_muxes), clk_data);
-	if (ret)
-		goto unregister_gates;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_cpumuxes;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_cpumuxes:
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return ret;
-}
-
-static void clk_mt7622_infracfg_remove(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
-	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
-	mtk_free_clk_data(clk_data);
-}
-
 static struct platform_driver clk_mt7622_infracfg_drv = {
 	.driver = {
 		.name = "clk-mt7622-infracfg",
 		.of_match_table = of_match_clk_mt7622_infracfg,
 	},
-	.probe = clk_mt7622_infracfg_probe,
-	.remove = clk_mt7622_infracfg_remove,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
 module_platform_driver(clk_mt7622_infracfg_drv);
 
-- 
2.55.0

