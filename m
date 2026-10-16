Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DC47DD44;
	Fri, 16 Oct 2026 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146726; cv=none; b=e5m+14nxsiV1P0niVFultD8bpOnvyRYVNGgHRVel5+NbHPtAik0gRgbJODz2/BhV5+TgdiSZdWj3Uiq+B1kwJoZKrkD/a5nrkWLAZk4SAXhjuTVmLDe6AnuyzCm83aRDI3q+oPbscyr42BvZN+KNexCwnc64h5VtRbh5oXvh6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146726; c=relaxed/simple;
	bh=03Ex1zCNSPyov2YYXhbUHFVZTDuwhkzfGLjwZ8Qdr3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f8s7aNKk/ECSWf6wLWX0fiQhq3kw8BkXoNYrwnRxMnHAn6dhRMxyIGKLzNw6J8bLAJmeGanZ9t0mop7R/ntdx0W9MNkZ3mDj8UbJcWpqVOk4r8y+0toShZ/sNNC+ZrIbLAA2n+7+Jc7KSAmXsX/ToEKxAASR19KNaeGfD0Iw1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=juvVg7HC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="juvVg7HC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792146722;
	bh=03Ex1zCNSPyov2YYXhbUHFVZTDuwhkzfGLjwZ8Qdr3o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=juvVg7HC3ZDGdhRbVfN+0gmvhUm2IB9lnrdRU9yWDYE6104Z3rHUcNuYuG/CBWQdH
	 gv46FGbPmeM/XG8aBdGTtN06Rc7+6NPne0VyfRjJdT89vpwQ6WdiTuav1qsNCcvdfR
	 nYUufE6lwhMVcmUdBvG+8Bur2dmL2Uedbkg/qCqK7XISIVtzXoNVmivZdTmrk6i/8H
	 xPOcnbksqY1iF6xjVE7tx5DbQcUIIuAqGhMEfNF89AAYKREMFm8K6XZ3hG30ebperu
	 7Iz04Qzm7QCM/2kIV21pilTc72iWoxTetO82Fzo/pi58qNl6m99g7rhSGaojeg5s6k
	 ESkXVboDlDrHw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E211817E0A33;
	Fri, 16 Oct 2026 12:32:01 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 16 Oct 2026 12:31:09 +0200
Subject: [PATCH net-next v3 5/9] net: stmmac: mediatek: add RX/TX delay
 stage divider in platform data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-dwmac-mediatek-mt8189-v3-5-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146716; l=4145;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=03Ex1zCNSPyov2YYXhbUHFVZTDuwhkzfGLjwZ8Qdr3o=;
 b=BkWztVCRIDSiq0wUrGYGPm/7TXIvuyUMDwWuqgrGjlX33cPWt1ioC6jTJIz7Mne+Zcq8SgHle
 jXxQvjua1beBdKY1xL4oPY1ul+8ksOnBdqeOorLbvtVJ5cEcfpcrsDb
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In preparation of newer SoC support, that have like MT8189 SoC
different RX and TX internal delay stage steps than MT8188/MT8195, add
the RX and TX delay stage divider values in the variant platform data
and replace the hardcoded value uses in mt2712_set_delay and
mt8195_set_delay.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 46 ++++++++++++++++++----
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 596411d4a5b2..cb5bda53edb9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -108,6 +108,10 @@ struct mediatek_dwmac_variant {
 
 	u32 rx_delay_max;
 	u32 tx_delay_max;
+	u16 rx_rmii_delay_stage_div;
+	u16 tx_rmii_delay_stage_div;
+	u16 rx_rgmii_delay_stage_div;
+	u16 tx_rgmii_delay_stage_div;
 	u8 dma_bit_mask;
 };
 
@@ -146,14 +150,22 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	u32 fine_val = 0;
 
 	if (phy_interface_mode_is_rgmii(plat->phy_mode)) {
-		rx_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV;
-		tx_delay_stage_div = MT2712_RGMII_DLY_TXC_STAGE_DIV;
+		rx_delay_stage_div = plat->variant->rx_rgmii_delay_stage_div;
+		tx_delay_stage_div = plat->variant->tx_rgmii_delay_stage_div;
 	} else {
-		rx_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV;
-		tx_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV;
+		rx_delay_stage_div = plat->variant->rx_rmii_delay_stage_div;
+		tx_delay_stage_div = plat->variant->tx_rmii_delay_stage_div;
 	}
-	rx_delay_stage_val = mac_delay->rx_delay / rx_delay_stage_div;
-	tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
+
+	if (rx_delay_stage_div)
+		rx_delay_stage_val = mac_delay->rx_delay / rx_delay_stage_div;
+	else
+		rx_delay_stage_val = 0;
+
+	if (tx_delay_stage_div)
+		tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
+	else
+		tx_delay_stage_val = 0;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
@@ -258,6 +270,10 @@ static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
 	.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
 	.rx_delay_max = MT2712_RGMII_DLY_RXC_MAX,
 	.tx_delay_max = MT2712_RGMII_DLY_TXC_MAX,
+	.rx_rmii_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV,
+	.tx_rmii_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV,
+	.rx_rgmii_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV,
+	.tx_rgmii_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV,
 	.dma_bit_mask = 33,
 };
 
@@ -283,13 +299,25 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 
 static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 {
+	u16 rx_delay_stage_div = plat->variant->rx_rgmii_delay_stage_div;
+	u16 tx_delay_stage_div = plat->variant->tx_rgmii_delay_stage_div;
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-	u32 rx_delay_stage_val = mac_delay->rx_delay / MT8195_DLY_RXC_STAGE_DIV;
-	u32 tx_delay_stage_val = mac_delay->tx_delay / MT8195_DLY_TXC_STAGE_DIV;
+	u32 rx_delay_stage_val;
+	u32 tx_delay_stage_val;
 	u32 gtxc_delay_val = 0;
 	u32 rmii_delay_val = 0;
 	u32 delay_val = 0;
 
+	if (rx_delay_stage_div)
+		rx_delay_stage_val = mac_delay->rx_delay / rx_delay_stage_div;
+	else
+		rx_delay_stage_val = 0;
+
+	if (tx_delay_stage_div)
+		tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
+	else
+		tx_delay_stage_val = 0;
+
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
 		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
@@ -398,6 +426,8 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
 	.rx_delay_max = MT8195_DLY_RXC_MAX,
 	.tx_delay_max = MT8195_DLY_TXC_MAX,
+	.rx_rgmii_delay_stage_div = MT8195_DLY_RXC_STAGE_DIV,
+	.tx_rgmii_delay_stage_div = MT8195_DLY_TXC_STAGE_DIV,
 	.dma_bit_mask = 35,
 };
 

-- 
2.56.0

