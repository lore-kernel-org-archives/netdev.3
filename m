Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F2438011;
	Sat,  1 Aug 2026 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583291; cv=none; b=i2b3IAKQDpRWEpK8bon9glzncBgyunUbAOUxsW+JOTj+3AWF0+yTMNmUQ4dMDToOOd7UjVU3iscXR2PyNkJpAqXjY6dt9YiA6irKf69h5YDC3hY81HM5TEoGluZ+Nd6jFfrRe0NVEOwzZOfO+Af35qlOfVRx7GP6PoKmG6vPmMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583291; c=relaxed/simple;
	bh=NoFwu2xld36Y84LtysJW9LuSu41fCdVWpVU4but4BcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mxX/b2xQbvMEEA+SOZKiW8NsjxVPRsIIB0XRbuCDkelmL25nQXQZ94pSv7pIrp90N58+4IJKgccFEzPWLhlnUzgFbkvCeIcZl9Lm4t8XnaJtUKd9yZQclIXJJm0RbGsQImS7HUwEAnmZV6dd0dpoVTkEqy8uXus4cwnSRDqlIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aptucHBg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aptucHBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583276;
	bh=NoFwu2xld36Y84LtysJW9LuSu41fCdVWpVU4but4BcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aptucHBgegXh7JMJkh4TQuFwq6PoM4iZfl8PiDs7ht/EXN6kyGJnARpp+1qY+095b
	 q7EJTeiBJntVEU6kS5lARE3S1JH8W2qeT3IxVdlN6wfp4RRlwjtS34SrtkIeFTHVFe
	 IZMD+XGDixH5mN+BsUiXcnqLnNa5hTPq0RjqUgjJ7F09fxfAHZhdwIc/5ZtXuZOCnq
	 37qgRfPCE87jNN6rSurW8K0qeFvcYsbL/wYOkGcz2O0RZj4f6z+QjZ7T3y54EI86/f
	 QtF+72Qh6EvpTBt9Si3xDR7SoGFt2SB5Ohl+jFg+ICJ3+7lJLvCDm1HCU13bmwmrEk
	 oh+nGq5mNI/4Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id F06AA17E015B;
	Sat, 01 Aug 2026 13:21:14 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:57 +0200
Subject: [PATCH v5 11/25] clk: mediatek: pll: Factorise pll power on/off
 sequences
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-11-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=2013;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=NoFwu2xld36Y84LtysJW9LuSu41fCdVWpVU4but4BcM=;
 b=cgHTWWvxRccS6fe8+EUY7eNiO1kYUcF5l9jWikSXBtIAvfoOyfdRlhq/lVqwgOoJiky2P2zby
 fiiiSsLknqmDYjBqJzSXDFuGmnJhmhinRlMSwSHvoSPKLMni/p3EEx5
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In order to prepare the MT8189 SoC support, that requires different
registers to control PLL status and perform reset BAR, and so a
different sets of clock operations, split the pll power on and off
sequences from mtk_pll_prepare/unprepare functions into private
subfunctions.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 4b0f7e2bfc5a..2aaf2871ecf6 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -223,9 +223,8 @@ int mtk_pll_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 	return 0;
 }
 
-int mtk_pll_prepare(struct clk_hw *hw)
+static void mtk_pll_power_on(struct mtk_clk_pll *pll)
 {
-	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
 	u32 r;
 
 	r = readl(pll->pwr_addr) | CON0_PWR_ON;
@@ -235,6 +234,25 @@ int mtk_pll_prepare(struct clk_hw *hw)
 	r = readl(pll->pwr_addr) & ~CON0_ISO_EN;
 	writel(r, pll->pwr_addr);
 	udelay(1);
+}
+
+static void mtk_pll_power_off(struct mtk_clk_pll *pll)
+{
+	u32 r;
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
+	mtk_pll_power_on(pll);
 
 	r = readl(pll->en_addr) | BIT(pll->data->pll_en_bit);
 	writel(r, pll->en_addr);
@@ -278,11 +296,7 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 	r = readl(pll->en_addr) & ~BIT(pll->data->pll_en_bit);
 	writel(r, pll->en_addr);
 
-	r = readl(pll->pwr_addr) | CON0_ISO_EN;
-	writel(r, pll->pwr_addr);
-
-	r = readl(pll->pwr_addr) & ~CON0_PWR_ON;
-	writel(r, pll->pwr_addr);
+	mtk_pll_power_off(pll);
 }
 
 static int mtk_pll_prepare_fenc_setclr(struct clk_hw *hw)

-- 
2.55.0

