Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8414E4570F4;
	Wed, 29 Jul 2026 10:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319406; cv=none; b=G20bKoQQEk5s9MYlH5EVHcTVqDjb3pPjOy6wwemk3dxc2wFZCkt3TZxQu4a/bb7me6h31gDfJEXwLWBdGdfK6mwmmGBa+bz9x5g4C7fPUkK1gJZzTszf6QbEi8C9FcI+wQeryK7ZLyhxakl0E1/ZHYBvA/WnDcXlka33//pzg18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319406; c=relaxed/simple;
	bh=xEeYmGMPvnAj8jbXB55YaPq0jUHYie7IR8h1C2C89Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=koWILvcabz6l0++gZaIfLhQC6CaofttrUU0i1QTovJs5jziwWNbuMIiFc515qDzvOJxNfad/4eblDlNB8C1IhD46K4EAcXZuRAfF53C19h0rIxYyu1x/fow0sUy5AI501kw8vqTfj3pVG5OFQAvLRiUyqhH3DlK8rzvMwLa92bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ECBKyxNA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ECBKyxNA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319402;
	bh=xEeYmGMPvnAj8jbXB55YaPq0jUHYie7IR8h1C2C89Wg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ECBKyxNA0hnr2k2ijrm/u+SJYYyj8Ont1lkDYTLky8vLN3GkUBwNDuYx0Vt6MvH2l
	 5V3SJBheHsrWsfJc8TOdt0VfGHbMtDbBfnLdmS7AvihXzOQrZ2p3S+hDVsuSjczgSZ
	 QsLfM4cJsRjfOiofec7Dis+XCU7Dgxh3zm13uxAaBBkvQFsLtNceoL5TdAMXchK4ph
	 dMkbfZPoyOuR7+sCVt1+mjug8FFpmHXW0SUbPfTFovgSxagTMu4q7yksFu1sAndhHp
	 BWhWiwJQ5wxCgg9gIVjPbcmglQyfwwYeifAsEZkypWfV9Ii4d5WbdEz/MeMncdFcCf
	 0n8P06pek8qww==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BF87217E0048;
	Wed, 29 Jul 2026 12:03:21 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:02:55 +0200
Subject: [PATCH v4 11/24] clk: mediatek: pll: split default
 prepare/unprepare callbacks
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-11-e356b813a64c@collabora.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
In-Reply-To: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785319387; l=3742;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=xEeYmGMPvnAj8jbXB55YaPq0jUHYie7IR8h1C2C89Wg=;
 b=fx5ybOfhoYzmOOV8eXiyBMUHfB6Q7dC0pCNvTKXAsRkrgjUiq0uLg80gjH1bKg1Y9+TZJSKsF
 QuGOPhd1d7bAR+O4u9degOGmp84nkwZ8DfpDf5lJyXfsKgZllybNub2
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In order to prepare the MT8189 SoC support, that requires different
registers to control PLL status and perform reset BAR, and so a
different sets of clock operations, split both mtk_pll_prepare and
mtk_pll_unprepare into several private subfunctions to factorize the
common code.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 61 ++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 4b0f7e2bfc5a..83a58ad23c5b 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -31,6 +31,8 @@
 /* default 7 bits integer, can be overridden with pcwibits. */
 #define INTEGER_BITS		7
 
+#define PLL_STABILIZATION_DELAY		20 /* in us */
+
 int mtk_pll_is_prepared(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
@@ -223,9 +225,9 @@ int mtk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	return 0;
 }
 
-int mtk_pll_prepare(struct clk_hw *hw)
+static void mtk_pll_prepare_common(struct mtk_clk_pll *pll,
+				   void __iomem *en_addr)
 {
-	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 r;
 
 	r = readl(pll->pwr_addr) | CON0_PWR_ON;
@@ -236,8 +238,8 @@ int mtk_pll_prepare(struct clk_hw *hw)
 	writel(r, pll->pwr_addr);
 	udelay(1);
 
-	r = readl(pll->en_addr) | BIT(pll->data->pll_en_bit);
-	writel(r, pll->en_addr);
+	r = readl(en_addr) | BIT(pll->data->pll_en_bit);
+	writel(r, en_addr);
 
 	if (pll->data->en_mask) {
 		r = readl(pll->base_addr + REG_CON0) | pll->data->en_mask;
@@ -246,7 +248,37 @@ int mtk_pll_prepare(struct clk_hw *hw)
 
 	__mtk_pll_tuner_enable(pll);
 
-	udelay(20);
+	udelay(PLL_STABILIZATION_DELAY);
+}
+
+static void mtk_pll_unprepare_common(struct mtk_clk_pll *pll,
+				     void __iomem *en_addr)
+{
+	u32 r;
+
+	__mtk_pll_tuner_disable(pll);
+
+	if (pll->data->en_mask) {
+		r = readl(pll->base_addr + REG_CON0) & ~pll->data->en_mask;
+		writel(r, pll->base_addr + REG_CON0);
+	}
+
+	r = readl(en_addr) & ~BIT(pll->data->pll_en_bit);
+	writel(r, en_addr);
+
+	r = readl(pll->pwr_addr) | CON0_ISO_EN;
+	writel(r, pll->pwr_addr);
+
+	r = readl(pll->pwr_addr) & ~CON0_PWR_ON;
+	writel(r, pll->pwr_addr);
+}
+
+int mtk_pll_prepare(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 r;
+
+	mtk_pll_prepare_common(pll, pll->en_addr);
 
 	if (pll->data->flags & HAVE_RST_BAR) {
 		r = readl(pll->rst_bar_addr);
@@ -256,6 +288,7 @@ int mtk_pll_prepare(struct clk_hw *hw)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_pll_prepare);
 
 void mtk_pll_unprepare(struct clk_hw *hw)
 {
@@ -268,22 +301,9 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 		writel(r, pll->rst_bar_addr);
 	}
 
-	__mtk_pll_tuner_disable(pll);
-
-	if (pll->data->en_mask) {
-		r = readl(pll->base_addr + REG_CON0) & ~pll->data->en_mask;
-		writel(r, pll->base_addr + REG_CON0);
-	}
-
-	r = readl(pll->en_addr) & ~BIT(pll->data->pll_en_bit);
-	writel(r, pll->en_addr);
-
-	r = readl(pll->pwr_addr) | CON0_ISO_EN;
-	writel(r, pll->pwr_addr);
-
-	r = readl(pll->pwr_addr) & ~CON0_PWR_ON;
-	writel(r, pll->pwr_addr);
+	mtk_pll_unprepare_common(pll, pll->en_addr);
 }
+EXPORT_SYMBOL_GPL(mtk_pll_unprepare);
 
 static int mtk_pll_prepare_fenc_setclr(struct clk_hw *hw)
 {
@@ -312,6 +332,7 @@ const struct clk_ops mtk_pll_ops = {
 	.determine_rate = mtk_pll_determine_rate,
 	.set_rate	= mtk_pll_set_rate,
 };
+EXPORT_SYMBOL_GPL(mtk_pll_ops);
 
 const struct clk_ops mtk_pll_fenc_setclr_ops = {
 	.is_prepared	= mtk_pll_is_prepared_fenc_setclr,

-- 
2.55.0

