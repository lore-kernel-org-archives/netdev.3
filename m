Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6688F43745F;
	Sat,  1 Aug 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583292; cv=none; b=kZVeogwg0R83jHCNGXfJjY4ZEm0FujF2K/Q1OICz/9QyzYFLWQGcsL/PQOKnDlIT19aBxWGxuTpHAYIvPmBBQNMefHU+q0EX9KIcS5+aPPYUJF70olY7oEWXBAWZbPyku1P0x2fMnqf4LbX4UpLlLMoBwThxFLUEI0CC/6P5YsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583292; c=relaxed/simple;
	bh=6JjNXnp9P8vjSKosRd1pFLpBMxNq9yqudZ2+UxmGb7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Al5Vid91DO8tP9IWb6NmePQ32gbI1jzvFvdGv7oiNcIb3zxPaTGd2RtupRcvp7J7Y720EwS5WDmRrKyVk6WAPjnGwHD4JrtiMMp6P4EYl98csVZE29OST3mzVRfsqCnvq7QNAf3OljIwfXIjfhnu0d1ZU9lDRtL3hQuQTmmi7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XHN2z/Og; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XHN2z/Og"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583280;
	bh=6JjNXnp9P8vjSKosRd1pFLpBMxNq9yqudZ2+UxmGb7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XHN2z/OgsW5t6b6d0W+0OvzIVJasbiJQcnEiZhw4PVvTyR5tijpfb87M4ibs8k6mg
	 CQnKI9kqdkA/qiiEAXlqRwQvphRfq/KBfz8ktLwNghVFbIypqP3z1shdmTC1uHa9Wx
	 PBV1qxVSXMxzYm6rQdZvgGwD5vrGi4JxCO7u4iCFbQmJL2lQiT/GOFYudDRsS7MHpC
	 4o6n8sOjPT8Fv1RdMynTI47+hpzvsewoMEG4Z2zc3e+QmDGVlhalxvkWpUDWlS2FJE
	 7Gj9N7RNp79qie8pBtPvrIw6b1L05Oq3UfEDwO1dUZbGkiSKrvX5t0Yfyz6+HkWPl3
	 ULWnya80aLj3Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C095717E0945;
	Sat, 01 Aug 2026 13:21:19 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:21:01 +0200
Subject: [PATCH v5 15/25] clk: mediatek: pllfh: Add ops for PLLs using
 set/clr regs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-15-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=1661;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=6JjNXnp9P8vjSKosRd1pFLpBMxNq9yqudZ2+UxmGb7o=;
 b=/BvKw1ZopRtn2m7mIlYzv0VssfOP2pg5dU4bvfs3MPYezztKeA24P67mrdRnGYW6gB+M/v/Oz
 CYrNzQP11x0CDW7VhOWoFGGTEu5y10v7GSWbjQeFJ2afCm3cSTPT6cu
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Add new set of PLL FHCTL clock operations, that uses the new prepare
and unprepare methods, added in PLL for MT8189 SoC to support this
logic.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pllfh.c | 10 ++++++++++
 drivers/clk/mediatek/clk-pllfh.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index 4878ac6da7da..8dc50461c485 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -47,6 +47,16 @@ static const struct clk_ops mtk_pllfh_ops = {
 	.set_rate	= mtk_fhctl_set_rate,
 };
 
+const struct clk_ops mtk_pllfh_setclr_ops = {
+	.is_prepared	= mtk_pll_is_prepared,
+	.prepare	= mtk_pll_prepare_setclr,
+	.unprepare	= mtk_pll_unprepare_setclr,
+	.recalc_rate	= mtk_pll_recalc_rate,
+	.determine_rate = mtk_pll_determine_rate,
+	.set_rate	= mtk_fhctl_set_rate,
+};
+EXPORT_SYMBOL_GPL(mtk_pllfh_setclr_ops);
+
 static struct mtk_pllfh_data *get_pllfh_by_id(struct mtk_pllfh_data *pllfhs,
 					      int num_fhs, int pll_id)
 {
diff --git a/drivers/clk/mediatek/clk-pllfh.h b/drivers/clk/mediatek/clk-pllfh.h
index d32bfe194ec4..a9eb7558de1c 100644
--- a/drivers/clk/mediatek/clk-pllfh.h
+++ b/drivers/clk/mediatek/clk-pllfh.h
@@ -69,6 +69,8 @@ struct fh_operation {
 	int (*ssc_enable)(struct mtk_fh *fh, u32 rate);
 };
 
+extern const struct clk_ops mtk_pllfh_setclr_ops;
+
 int mtk_clk_register_pllfhs(struct device *dev,
 			    const struct mtk_pll_data *plls, int num_plls,
 			    struct mtk_pllfh_data *pllfhs, int num_pllfhs,

-- 
2.55.0

