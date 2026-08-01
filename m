Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273BC435525;
	Sat,  1 Aug 2026 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583293; cv=none; b=oBsCCuG9kXFGrjbyVLWtN6iHsRLd0kmVsUHVV1FzjhIXmcgUScExaR0ABkIxwb1TWqzWKwzT/4XNnynfiNdfTn7NMYc80HagwEj7cMtfQlgnuQTMmH/8eE11n+vpcoN1X2y/1zVa+iLOPjI7NqMcMCfKtsWYUlY1MZvTnkN+6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583293; c=relaxed/simple;
	bh=0Ll+/SLFb8txIVve2YQ50ZAHjghMkBWQteo5ybOHIp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ViaEByNaIbgWHHjz2uKns+5a8Ohj89qCQj6KHCV8LVBUTSPHHcl3xfCK2RtKuzXdyhd3sydGJxsaIyOEqkGHfopkmNVlhXFz37l0KSMo4gJ/HGbC76jVlFjQOou7PppQBo9l6ynh0FEFiQpFGSFibFFugZMpiohO8AhBW632biU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ap8AlX6q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ap8AlX6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583279;
	bh=0Ll+/SLFb8txIVve2YQ50ZAHjghMkBWQteo5ybOHIp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ap8AlX6q6600MtjDMtpuJ0dN0Ojo4GZFOI0cOcT/8m5QlkaHI1pZZlyyWN69/YnAQ
	 vXTRgOvT7ppUCIVJZQo/1pTFLLKGk4JOq/y1gDc0BrWldGap01sD691X4ljwKyS5Cq
	 jTgtmI2HIsW2UPkbZZD7gsCF7rveKm35jh+VYxgkq9LJLTgcI35GH+LNQFgPgKXroB
	 ePIpdpFSuAJ2HkIq/XM8bCP5W8+uSfTxXV8hadF1UEkfrIg72knanytA6C/F9yfhC/
	 IANRkC7WhCSubaqsEaWnnOCW4H8GcPyDvnV+w+EA4zynyNgXy9xY976UN0XhY4tDu+
	 1s79yJMIzoeow==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F04617E0943;
	Sat, 01 Aug 2026 13:21:18 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:21:00 +0200
Subject: [PATCH v5 14/25] clk: mediatek: pllfh: Add configurable clock ops
 to mtk_pllfh_data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-14-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=1909;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=0Ll+/SLFb8txIVve2YQ50ZAHjghMkBWQteo5ybOHIp4=;
 b=45gtUlPhiT3cTMhlYBE1TZWODMUxeCIfJzIb96HRGASIPSDU/UFLhsftexpP4hzNHHhmYyzrs
 YYf2O5udvMYD+J7D0VRahK3UenLsTA6ChngHHoCE153cKWwzyVoe0sY
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Currently, the mtk_clk_register_pllfh functions always registers the
default PLL clock operation set (mtk_pllfh_ops). This does not allow
use a custom one, for SoC such as MT8189, that needs different
set with support for set/clr enable.

Add a new field for the ops to register in mtk_pllfh_data structure
and use this new field to either register it when not null or the
default ops otherwise.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/clk/mediatek/clk-pllfh.c | 5 +++--
 drivers/clk/mediatek/clk-pllfh.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
index aa95cd9197b3..4878ac6da7da 100644
--- a/drivers/clk/mediatek/clk-pllfh.c
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -153,6 +153,8 @@ static struct clk_hw *
 mtk_clk_register_pllfh(struct device *dev, const struct mtk_pll_data *pll_data,
 		       struct mtk_pllfh_data *pllfh_data, void __iomem *base)
 {
+	const struct clk_ops *pllfh_ops = pllfh_data->data.ops ?
+					  pllfh_data->data.ops : &mtk_pllfh_ops;
 	struct clk_hw *hw;
 	struct mtk_fh *fh;
 	int ret;
@@ -169,8 +171,7 @@ mtk_clk_register_pllfh(struct device *dev, const struct mtk_pll_data *pll_data,
 
 	fh->clk_pll.dev = dev;
 
-	hw = mtk_clk_register_pll_ops(&fh->clk_pll, pll_data, base,
-				      &mtk_pllfh_ops);
+	hw = mtk_clk_register_pll_ops(&fh->clk_pll, pll_data, base, pllfh_ops);
 
 	if (IS_ERR(hw))
 		goto out;
diff --git a/drivers/clk/mediatek/clk-pllfh.h b/drivers/clk/mediatek/clk-pllfh.h
index a4f337acad71..d32bfe194ec4 100644
--- a/drivers/clk/mediatek/clk-pllfh.h
+++ b/drivers/clk/mediatek/clk-pllfh.h
@@ -34,6 +34,7 @@ struct fh_pll_data {
 	u32 updnlmt_shft;
 	u32 msk_frddsx_dys;
 	u32 msk_frddsx_dts;
+	const struct clk_ops *ops;
 };
 
 struct mtk_pllfh_data {

-- 
2.55.0

