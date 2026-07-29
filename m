Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF664470423;
	Wed, 29 Jul 2026 10:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319409; cv=none; b=C9EcRdnvJh6AF3Eh7BB1QFktkZyX1VVDcn/8JVjRG0PcOLzAD+SyPKcI0f8yvjhB6I5kB0cls4tGPN+AkUDXQRk4VcRVFMk/mcuGRTVTzx/uEEh/u+WDas/4ToHWHuSBUmCidtMypDlRml+o1QOJWm2OHaE68GczFnMh9a7oWqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319409; c=relaxed/simple;
	bh=6JjNXnp9P8vjSKosRd1pFLpBMxNq9yqudZ2+UxmGb7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dXUOquClkOKWawwr3qG41V1290H0iETISWdlQTp3lo7jYEXP3zrVfMnfcycG/P8Evx2nJqikIE+9CngpgtqESlJMdpw8NEQW1sQ42dIpIVESUcW9PydGH2N5IT2mEiES9fv4yUY8UoMwcsd0oSMDfB6y+vKcS41D+tmkQltpxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CHMOtOA/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CHMOtOA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319406;
	bh=6JjNXnp9P8vjSKosRd1pFLpBMxNq9yqudZ2+UxmGb7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CHMOtOA/iii+LAW/dEIX0gG5swDqIyNGGZ9AFdc3+LWX/O4zpm9zUQnwORRBpzuFQ
	 wMG+nMaZ+qH4bnx9Y/rZNmwo5hJb31qo7SchinDMcoXmxXsPjTIt9ulSwQCfcVxFuH
	 2/YBzczmHLg5R0Nw2DvgL5LFj8QrU6cLi87QyRjg6hUj36/MfR57G6GAL+G8DktkxU
	 4Nx+nt94BALhPUHHHDlA0GOOOqXqznHks9C/LhqKFImXy0BzSQIsSRx509QZflRhjF
	 o3YtyrGvP5vF+N3l1JQYP/FjfTHtOFMEhoiFt+/ANBM/ZSi7YpyYQ1uzORbg0kPbWq
	 QINvraovYq/RQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 57C4D17E08A1;
	Wed, 29 Jul 2026 12:03:25 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:02:58 +0200
Subject: [PATCH v4 14/24] clk: mediatek: pllfh: Add ops for PLLs using
 set/clr regs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-14-e356b813a64c@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785319388; l=1661;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=6JjNXnp9P8vjSKosRd1pFLpBMxNq9yqudZ2+UxmGb7o=;
 b=4DqLxtAo6pXflnLcoQ981MRSP2HNo+P5bRxvr/ZbyGejZ85clvWSFRGn9jQNqgJwnMY8ztdlg
 cLNI+5iTez2CLAFgv6HloFTUFvdiR/DKFIYyuXZG3/tH4d/0wk8XGI2
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

