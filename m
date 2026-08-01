Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332144334C9;
	Sat,  1 Aug 2026 11:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583292; cv=none; b=uxTCeG6IWWr+JYI0WsGGjw0AJsuVbnURguz8p3axelzp4NqL1s1sxQoZHZclqxNiHtoT0CSE8+3n3A/FPHZ1D5K9dohzIdp7sJ2YOcEfevnUSvFaruCMQWo/3d6eYLsTbN3NSCgYeZLsw45VygTHfnZl2oanzsq04q9lkie86pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583292; c=relaxed/simple;
	bh=XKeq/6ISKM8NoKoqOqLoyc4RJZBTukW0CYKFoenadVc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RkTieM4bjw+MIe+snzeXFrluMlfGSVb3qXUmR17LodyV4irnlgk67zmytKHQuOc3ox2PKbSk1WY5VnVvlm1D5NUriY4o5w9/jVUi7VTF2xKe+NwJELq0wGa2fQMZF7sD+Mh7yDFb0e7ewCzrvj+UzzZSm8iNXrIubLTnpT1blQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aTp5phbz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aTp5phbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583278;
	bh=XKeq/6ISKM8NoKoqOqLoyc4RJZBTukW0CYKFoenadVc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aTp5phbz4UOPFnWajXnEg8a7AoxdcfO91VMBIPF5xP96e7nmY+HHyZ6uZ46a/Rru2
	 DLOdH4nI1b7fhND7nCGu0OD3WffHY3DDDU/nakqCelO9bEniDXnEvfn5lRqg8BAp6E
	 JS61XE0KufwutjqjxoBRgx0c4G++QL+brsDf0OMS9CA/oiHCQvFIMPkPHbAw9l0sld
	 B8pyMBSTwBvijAW1d6CBzWNlJc3Q04Nl4HH0/gMCfLsciXqMWmcJRIqXEEPzEUBAEn
	 uCF8gchBxgmThJbI4Xxp8VUPl+0JHj6Mca6MA1zzWSZd/Qbu9x0PLcT9HHPxq5uNkE
	 uy1UOSbTG5j/w==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E2F117E093E;
	Sat, 01 Aug 2026 13:21:17 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:59 +0200
Subject: [PATCH v5 13/25] clk: mediatek: pll: Add ops for PLLs using
 set/clr regs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-13-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=4503;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=XKeq/6ISKM8NoKoqOqLoyc4RJZBTukW0CYKFoenadVc=;
 b=1VKTXYq91OO1t1DFcdXbMR51at6/df+zNWhcaCbtXjEgv4Zw3i4M4Qq0Eb0EBJCvuHKILzZWn
 KF4gSz5zmpuCaWxKuJassoOPtCbRq6yjJgOlG1BwsPhyRHyD67a5VXc
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

MT8189 SoC uses a new combination of status and set/clr registers to
control its PLL enable state and perform BAR reset, that are different
than the current default clock prepare/unprepare operations are using.

Add new set of PLL clock operations to support this logic that relies
on the following registers for prepare/unprepare operations:
  - en/en_set/en_clr, rather than en register, for PLL enable
    control
  - rst_bar/rst_bar_set/rst_bar_clr, rather than default rst_bar
    register for BAR reset control

Also, handle rst_bar register setting/clearing with a timeout, to
verify the operation was correctly performed.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-pll.h |  5 ++++
 2 files changed, 71 insertions(+)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 9a197a657dce..3118f68aa9ac 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -32,6 +33,7 @@
 #define INTEGER_BITS		7
 
 #define PLL_STABILIZATION_DELAY	20 /* in us */
+#define RST_BAR_TIMEOUT		20 /* in us */
 
 int mtk_pll_is_prepared(struct clk_hw *hw)
 {
@@ -301,6 +303,60 @@ void mtk_pll_unprepare(struct clk_hw *hw)
 	mtk_pll_power_off(pll);
 }
 
+int mtk_pll_prepare_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 val = 0;
+	int ret;
+
+	mtk_pll_power_on(pll);
+
+	writel(BIT(pll->data->pll_en_bit), pll->en_set_addr);
+
+	__mtk_pll_tuner_enable(pll);
+
+	udelay(PLL_STABILIZATION_DELAY);
+
+	if (pll->data->flags & HAVE_RST_BAR) {
+		writel(pll->data->rst_bar_mask, pll->rst_bar_set_addr);
+
+		ret = readl_poll_timeout(pll->rst_bar_addr, val,
+					(val & pll->data->rst_bar_mask), 1,
+					RST_BAR_TIMEOUT);
+		if (ret) {
+			mtk_pll_unprepare_setclr(hw);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_pll_prepare_setclr);
+
+void mtk_pll_unprepare_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	u32 val = 0;
+
+	if (pll->data->flags & HAVE_RST_BAR) {
+		writel(pll->data->rst_bar_mask, pll->rst_bar_clr_addr);
+
+		/* ignore return code to continue unpreparing the PLL if
+		 * a error occurs on register read poll.
+		 */
+		readl_poll_timeout(pll->rst_bar_addr, val,
+				   !(val & pll->data->rst_bar_mask), 1,
+				   RST_BAR_TIMEOUT);
+	}
+
+	__mtk_pll_tuner_disable(pll);
+
+	writel(BIT(pll->data->pll_en_bit), pll->en_clr_addr);
+
+	mtk_pll_power_off(pll);
+}
+EXPORT_SYMBOL_GPL(mtk_pll_unprepare_setclr);
+
 static int mtk_pll_prepare_fenc_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
@@ -329,6 +385,16 @@ const struct clk_ops mtk_pll_ops = {
 	.set_rate	= mtk_pll_set_rate,
 };
 
+const struct clk_ops mtk_pll_setclr_ops = {
+	.is_prepared	= mtk_pll_is_prepared,
+	.prepare	= mtk_pll_prepare_setclr,
+	.unprepare	= mtk_pll_unprepare_setclr,
+	.recalc_rate	= mtk_pll_recalc_rate,
+	.determine_rate = mtk_pll_determine_rate,
+	.set_rate	= mtk_pll_set_rate,
+};
+EXPORT_SYMBOL_GPL(mtk_pll_setclr_ops);
+
 const struct clk_ops mtk_pll_fenc_setclr_ops = {
 	.is_prepared	= mtk_pll_is_prepared_fenc_setclr,
 	.prepare	= mtk_pll_prepare_fenc_setclr,
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index 3aaf3a7654b5..296bed073290 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -92,6 +92,7 @@ void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 
 extern const struct clk_ops mtk_pll_ops;
 extern const struct clk_ops mtk_pll_fenc_setclr_ops;
+extern const struct clk_ops mtk_pll_setclr_ops;
 
 static inline struct mtk_clk_pll *to_mtk_clk_pll(struct clk_hw *hw)
 {
@@ -104,6 +105,10 @@ int mtk_pll_prepare(struct clk_hw *hw);
 
 void mtk_pll_unprepare(struct clk_hw *hw);
 
+int mtk_pll_prepare_setclr(struct clk_hw *hw);
+
+void mtk_pll_unprepare_setclr(struct clk_hw *hw);
+
 unsigned long mtk_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate);
 
 void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,

-- 
2.55.0

