Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB3439321;
	Sat,  1 Aug 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583293; cv=none; b=OFixX2krsa9ED7VLzpFc77Yk8H2/lV2MSxWGlLTcemL5TYvUYmMuUA0uQMwijuyQtXYbUSWiFt0ZSb8fIVxXTQe/esp/u5wHdppWuM75h3X8F0LnD27SwxZOMixLyp5t1LUJgdOUYom1S4aWGgcZbb4t62slUUWUAtZAvKNN+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583293; c=relaxed/simple;
	bh=MisHMv5fgckNp1NohR+Xiai0OsetPGYyxZCSHa9udKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4GBc4TyZBbbEPlhJJe2/cBuiW+BIAga3fpa0RVo/IOZNHlQdgfQ/pmqGld/mWtD19nvgMY5HzIZApEcB/lfG+XW2TR16g9VaRdzsCcbL4QBC1LlF6OXvSy7vxI7Z1vbI5PV8nO9eTmvGKIf+g+LqojLpn2pR9umtTrxWNQFtk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bo/Qm1rb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bo/Qm1rb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583277;
	bh=MisHMv5fgckNp1NohR+Xiai0OsetPGYyxZCSHa9udKg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bo/Qm1rbZURHHAid8EHnKLGufB6LLou14Gt9Fzr95oOQwI4QFxtKRFYzGzGaSsra8
	 nBRIpyIRXGLKcDbqHB0HFcju8iIB7ZJNtYC/MDborkP/kpDZbOegAPiCnwbajMR8BL
	 9W5/vY1XqOPM+RGderm6MhV8M1C2YTbZ11IS9C3H5AqulGTPHdbRrB9Sbe/D6UlgaZ
	 SIx2djmcQkqEulxwBKNFXw0U1Bn3lt/lJX99BuJLMBaCR1BCusE5eqqI5FL0150RN1
	 vFwJ9PzaP0vUSah32GTZI0NcMv3qRC20++0JGGDTKXX1YcnvUvQCNHuxon3ZLhR7ky
	 ztHkpbdiEK+YQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C25817E093D;
	Sat, 01 Aug 2026 13:21:16 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:58 +0200
Subject: [PATCH v5 12/25] clk: mediatek: pll: Add PLL stabilization delay
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-12-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=1493;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=MisHMv5fgckNp1NohR+Xiai0OsetPGYyxZCSHa9udKg=;
 b=pkokoq3YMOOM1Wx8cLRS0iDASrK/zqO2RnLz20bQ21heFrb4heq9/Kk8L07Ukn2/5m2Nwkcsr
 HmKaNTtcaMgDQHi4TiFM0Ixlt7olFrFW4+krBSCVDBU3W3Anpyho8lj
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Several functions uses a hardcoded value (20), to represent the
needed delay to stabilize a PLL.
Add a common define for this value.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 2aaf2871ecf6..9a197a657dce 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -31,6 +31,8 @@
 /* default 7 bits integer, can be overridden with pcwibits. */
 #define INTEGER_BITS		7
 
+#define PLL_STABILIZATION_DELAY	20 /* in us */
+
 int mtk_pll_is_prepared(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
@@ -131,7 +133,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 	/* restore tuner_en */
 	__mtk_pll_tuner_enable(pll);
 
-	udelay(20);
+	udelay(PLL_STABILIZATION_DELAY);
 }
 
 /*
@@ -264,7 +266,7 @@ int mtk_pll_prepare(struct clk_hw *hw)
 
 	__mtk_pll_tuner_enable(pll);
 
-	udelay(20);
+	udelay(PLL_STABILIZATION_DELAY);
 
 	if (pll->data->flags & HAVE_RST_BAR) {
 		r = readl(pll->rst_bar_addr);
@@ -306,7 +308,7 @@ static int mtk_pll_prepare_fenc_setclr(struct clk_hw *hw)
 	writel(BIT(pll->data->pll_en_bit), pll->en_set_addr);
 
 	/* Wait 20us after enable for the PLL to stabilize */
-	udelay(20);
+	udelay(PLL_STABILIZATION_DELAY);
 
 	return 0;
 }

-- 
2.55.0

