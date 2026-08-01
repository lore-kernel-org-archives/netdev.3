Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A2437470;
	Sat,  1 Aug 2026 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583289; cv=none; b=MinVKH2yT3PUWQK78UJzKTnPIE0AlzqeYj6b7wwVbFc6IhFqzfbG7IlOpSGXPBBngQGA2L7E3pD/N0xwvYjVHAeoVwApTiuilvfZ8sY3MQILIHl2dMT30ptloGB19SKU5U9acHQ9/uAF09OwENzVSD9s7r3L/fJr0mqwAz7stC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583289; c=relaxed/simple;
	bh=nmMkXcxJLcyi5jJSE7u+jNN//+j9QNGYv6dVLzwOIgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSFsGRef7XUTWUqKQwx6yXZlOkeEOLH8Z7b8+63CJIvOcFmx4+jgXPRFmZgS2OdphfeLXWaSjOqLRhON97LTszjINWSoPtzIe7QwYcrViURSbvukZJNtVM5XVEz587r423tHV/kV0YiZJZlDpf+MUcY478zPAlfee1yZl1wEPzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lIzoLssP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lIzoLssP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583274;
	bh=nmMkXcxJLcyi5jJSE7u+jNN//+j9QNGYv6dVLzwOIgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lIzoLssPzikXPYX7Pw79c3HSS1Ens8+EbboKqnHP4441dLsG0TJubv6AjwV9yDFRN
	 MX28jEIPcg3uCQlx0zTl1vXKwB6ysyQHtotDr+bH9qsDOTzRsj4LIwA3XEicr8mtVN
	 Z/D/C+Fd+ZoXFWBTPuUATfVC9mgwA92LwKpWxXgzqY6crvCJHF+LqRAKslqZVfeZZh
	 K/Ckw8IGuHzyEJjSndBZr6aEOZYLUnfGdKZKPV4TsaSExlchnLn6K3SCHIRzyw0ovm
	 xPgctN2Unkky6wkX6sJ7xLyd8+2BxFPtxGFARMLJw/eYl9UQ/nyW1MKs+rVrGDLMiL
	 3bN2nNTI/r74Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BDE2117E093B;
	Sat, 01 Aug 2026 13:21:13 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:56 +0200
Subject: [PATCH v5 10/25] clk: mediatek: pll: Add BAR reset register
 offsets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-10-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=2982;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=nmMkXcxJLcyi5jJSE7u+jNN//+j9QNGYv6dVLzwOIgI=;
 b=HS7aAl9QeMIS8moCH+Y7XZshTdkQRtomMkyYQ8dsCKD2DdzR7g7UyDfE58i8lQgl4wwPpfQSo
 x4e3FC1lMCmCdBU+hMpeYb0bz03oq4xPs7KrOmux2donrNJvrIspe/R
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Currently, the register offset to handle BAR reset, for PLLs that
support it, is hardcoded to CON0.
On MT8189 SoC, there are separate status, set and clr registers to
handle this, so differents offsets are needed.

Add the new fields for offsets and addresses to the MTK PLL data
structure and modify mtk_clk_register_pll_ops function to compute the
new register addresses so they are available for clock operation usage.

Also, replace reset BAR address computing by its computed address
from MTK PLL data structure in prepare/unprepare callbacks.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 18 ++++++++++++++----
 drivers/clk/mediatek/clk-pll.h |  6 ++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index ee478bc64085..4b0f7e2bfc5a 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -249,9 +249,9 @@ int mtk_pll_prepare(struct clk_hw *hw)
 	udelay(20);
 
 	if (pll->data->flags & HAVE_RST_BAR) {
-		r = readl(pll->base_addr + REG_CON0);
+		r = readl(pll->rst_bar_addr);
 		r |= pll->data->rst_bar_mask;
-		writel(r, pll->base_addr + REG_CON0);
+		writel(r, pll->rst_bar_addr);
 	}
 
 	return 0;
@@ -263,9 +263,9 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 	u32 r;
 
 	if (pll->data->flags & HAVE_RST_BAR) {
-		r = readl(pll->base_addr + REG_CON0);
+		r = readl(pll->rst_bar_addr);
 		r &= ~pll->data->rst_bar_mask;
-		writel(r, pll->base_addr + REG_CON0);
+		writel(r, pll->rst_bar_addr);
 	}
 
 	__mtk_pll_tuner_disable(pll);
@@ -352,6 +352,16 @@ struct clk_hw *mtk_clk_register_pll_ops(struct mtk_clk_pll *pll,
 		pll->en_set_addr = base + data->en_set_reg;
 	if (data->en_clr_reg)
 		pll->en_clr_addr = base + data->en_clr_reg;
+
+	if (data->rst_bar_reg)
+		pll->rst_bar_addr = base + data->rst_bar_reg;
+	else
+		pll->rst_bar_addr = pll->base_addr + REG_CON0;
+	if (data->rst_bar_set_reg)
+		pll->rst_bar_set_addr = base + data->rst_bar_set_reg;
+	if (data->rst_bar_clr_reg)
+		pll->rst_bar_clr_addr = base + data->rst_bar_clr_reg;
+
 	pll->hw.init = &init;
 	pll->data = data;
 
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index d6d34840c09d..3aaf3a7654b5 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -49,6 +49,9 @@ struct mtk_pll_data {
 	u32 en_reg;
 	u32 en_set_reg;
 	u32 en_clr_reg;
+	u32 rst_bar_reg;
+	u32 rst_bar_set_reg;
+	u32 rst_bar_clr_reg;
 	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
 	u8 pcw_chg_bit;
 	u8 fenc_sta_bit;
@@ -75,6 +78,9 @@ struct mtk_clk_pll {
 	void __iomem	*en_set_addr;
 	void __iomem	*en_clr_addr;
 	void __iomem	*fenc_addr;
+	void __iomem	*rst_bar_addr;
+	void __iomem	*rst_bar_set_addr;
+	void __iomem	*rst_bar_clr_addr;
 	const struct mtk_pll_data *data;
 };
 

-- 
2.55.0

