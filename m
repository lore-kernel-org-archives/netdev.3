Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C008C43744A;
	Sat,  1 Aug 2026 11:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583279; cv=none; b=rsfJk7Yd21J3cGHbGHWp3vccc9narWrGzwT6ZMM05NrRRD/WjepD3NOxElKLRAxoDL1dDmUqSs31aizfpLzCGK2qfCqv8ZtI4lCq0kbj+6fGumZOWdjO8M4n+Kct7q8eUJ0AI2mcp+Jfk1pguRHZpLcQ5fst3PbkbB/j7xYm0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583279; c=relaxed/simple;
	bh=/oJY/lp7GPxMngsUs+sgToa+ZkeBA3vDXdxfmtcPW88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hf0bWHBGbt/eZtfbkE5fzUb3/cyXUiqpTq5m4IajOb+5vD9ko/0NoS7MHQDBI8twBZFMCq2HwemPnLK0ojjetvjFocuLODxMnQ4HtxquaQrcP3Dkb1f8ZeFvHEV/P3ZjDZtfxlxNISLRhrmL2Pb/X8HZpzsEYaTdEMLoYZoc3cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AUIj07zG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AUIj07zG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583273;
	bh=/oJY/lp7GPxMngsUs+sgToa+ZkeBA3vDXdxfmtcPW88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AUIj07zG338Rl9TMAeFWwwRwphsPymGVWTaqQXuppNvNRfsRcLRQQakjfbQ/1gFPo
	 4Hpd2mCJUIqDgeAjPUnrTdGSS229nZUPAeD9zI97QPgBgPwN3q2IpVOjJ3u/kMKhho
	 5eueZkjcWP3A1qm8bkyJNenfx5GMMEl6imgQB40bEYx9ATcfXPRXyeDnV2roAVX9eH
	 NbnjDuXfivIVZflEpE1S5y6U0yHjUHTq+rx7kY2sn3+QvbXdvBjhDfT5r42ddcbvXr
	 tD4lVE3mncHsMRbyONlG8rnyBrPh6/+NW2OBxtagavrpz7lxybQ7Vd8eFpeZfEry76
	 a5vH1kmX0IuaA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8BD8C17E0937;
	Sat, 01 Aug 2026 13:21:12 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:55 +0200
Subject: [PATCH v5 09/25] clk: mediatek: Harmonize mtk_pll_fenc related
 symbol names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-9-ac4410697cc2@collabora.com>
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
 netdev@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=3997;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=/oJY/lp7GPxMngsUs+sgToa+ZkeBA3vDXdxfmtcPW88=;
 b=pjyDeVWi5Q39miN/vOSNqJGfO/UrVr/lYEGoZnYGW0Y6JzGKg1IVYaOOGMObyqVGjk6ofB9ey
 ZGhBV2FMKclBTQl0zqsPtu2GjHq+appfXqyrRYOCitQ5OYwimjd8ZTm
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

To prepare for the new clock ops set addition, with support for set/clr
enable logic only, rename mtk_pll_fenc_setclr_ops and its callback names
to harmonize the naming with the same suffix.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-mt8196-apmixedsys.c |  2 +-
 drivers/clk/mediatek/clk-mt8196-vlpckgen.c   |  2 +-
 drivers/clk/mediatek/clk-pll.c               | 16 ++++++++--------
 drivers/clk/mediatek/clk-pll.h               |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
index c4ebb0170b82..41c5117b18f8 100644
--- a/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8196-apmixedsys.c
@@ -83,7 +83,7 @@
 		.en_set_reg = PLLEN_ALL_SET,			\
 		.en_clr_reg = PLLEN_ALL_CLR,			\
 		.pll_en_bit = _pll_en_bit,			\
-		.ops = &mtk_pll_fenc_clr_set_ops,		\
+		.ops = &mtk_pll_fenc_setclr_ops,		\
 }
 
 struct mtk_pll_desc {
diff --git a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
index 7dcc164627c5..8a69f88e15a7 100644
--- a/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
+++ b/drivers/clk/mediatek/clk-mt8196-vlpckgen.c
@@ -162,7 +162,7 @@
 		.en_set_reg = VLP_PLLEN_ALL_SET,		\
 		.en_clr_reg = VLP_PLLEN_ALL_CLR,		\
 		.pll_en_bit = _pll_en_bit,			\
-		.ops = &mtk_pll_fenc_clr_set_ops,		\
+		.ops = &mtk_pll_fenc_setclr_ops,		\
 }
 
 static DEFINE_SPINLOCK(mt8196_clk_vlp_lock);
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index e97064868908..ee478bc64085 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -38,7 +38,7 @@ int mtk_pll_is_prepared(struct clk_hw *hw)
 	return (readl(pll->en_addr) & BIT(pll->data->pll_en_bit)) != 0;
 }
 
-static int mtk_pll_fenc_is_prepared(struct clk_hw *hw)
+static int mtk_pll_is_prepared_fenc_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
@@ -285,7 +285,7 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 	writel(r, pll->pwr_addr);
 }
 
-static int mtk_pll_prepare_setclr(struct clk_hw *hw)
+static int mtk_pll_prepare_fenc_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
@@ -297,7 +297,7 @@ static int mtk_pll_prepare_setclr(struct clk_hw *hw)
 	return 0;
 }
 
-static void mtk_pll_unprepare_setclr(struct clk_hw *hw)
+static void mtk_pll_unprepare_fenc_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 
@@ -313,15 +313,15 @@ const struct clk_ops mtk_pll_ops = {
 	.set_rate	= mtk_pll_set_rate,
 };
 
-const struct clk_ops mtk_pll_fenc_clr_set_ops = {
-	.is_prepared	= mtk_pll_fenc_is_prepared,
-	.prepare	= mtk_pll_prepare_setclr,
-	.unprepare	= mtk_pll_unprepare_setclr,
+const struct clk_ops mtk_pll_fenc_setclr_ops = {
+	.is_prepared	= mtk_pll_is_prepared_fenc_setclr,
+	.prepare	= mtk_pll_prepare_fenc_setclr,
+	.unprepare	= mtk_pll_unprepare_fenc_setclr,
 	.recalc_rate	= mtk_pll_recalc_rate,
 	.determine_rate	= mtk_pll_determine_rate,
 	.set_rate	= mtk_pll_set_rate,
 };
-EXPORT_SYMBOL_GPL(mtk_pll_fenc_clr_set_ops);
+EXPORT_SYMBOL_GPL(mtk_pll_fenc_setclr_ops);
 
 struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 					const struct mtk_pll_data *data,
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index f49dc2732ffe..d6d34840c09d 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -85,7 +85,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 			     struct clk_hw_onecell_data *clk_data);
 
 extern const struct clk_ops mtk_pll_ops;
-extern const struct clk_ops mtk_pll_fenc_clr_set_ops;
+extern const struct clk_ops mtk_pll_fenc_setclr_ops;
 
 static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
 {

-- 
2.55.0

