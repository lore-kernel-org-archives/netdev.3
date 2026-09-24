Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F61427FA0;
	Thu, 24 Sep 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234666; cv=none; b=p1CGjbSxQBJOwGoNng7XWbLykCX5x2mu2g9XXS0tlt3Gv4kF9+MkHBEnd9M+25nhnx+++9Ylkh2y2tth0AorztFPqBw0GU4oBnoZBlHru42RUyNxLr6YVxYAfkWtCfrkd7SycPfHaZS1q7JSmr6v1JYiSl0ujhsqDwaOnOo004c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234666; c=relaxed/simple;
	bh=2ORlhhYALrGSA1AgsN6rxpeVUyxOrdA8goKrV/84zAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvnD6vHkp0s8+SXPE4DXYuDQUKpUIFDvtoDJj4gcFi/JwLo8hUEsVVrOj9O9ijDoX4lxb2De9zQT0tUYZkK3iWSS6e+3hUQl0dkdTFvMicv26jfVx+i6EpIl29VjzIOipO15q/RAcYSkLe2VnxH+WeMIKMwAs8UY5VXwayXJd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GAi8HAJZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GAi8HAJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234655;
	bh=2ORlhhYALrGSA1AgsN6rxpeVUyxOrdA8goKrV/84zAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GAi8HAJZW4dJ/eZxh57pVtXWNrsjtYgpHN5lzKoAGrZoiLFr3aO3L3zAhhpjvh6sp
	 rRgqg4H3i4/aVWRIAo0UrTtGu3wt39XCrjakyrXMzZH9mLhX6ByX48DcH0dYo2Ki8C
	 RG++g7CDJDwD7qUvfS6Ap4YzcYic8XzcEkZnzJoII2x62jpAv4qRskvpLBqQpIMUp3
	 bZkr7f1P1KpyrtiECyhxFYu1fMeDQwEkD4ZrbS3a6WEmzl6jn35OwaeYiJJm/6RFMM
	 ZI9e+FmZA19rf0K/fHwu1W1iEQSJ/yxkAcc/Ng7GFtKH0NweDKYVUv2nU7tstVbCsv
	 o9W5wTMPrGbQA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D908A17E03B6;
	Thu, 24 Sep 2026 09:24:14 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 09:23:25 +0200
Subject: [PATCH net-next v2 2/7] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt8195_set_delay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-2-430bd74d5ef9@collabora.com>
References: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
In-Reply-To: <20260924-dwmac-mediatek-mt8189-v2-0-430bd74d5ef9@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=7277;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=2ORlhhYALrGSA1AgsN6rxpeVUyxOrdA8goKrV/84zAA=;
 b=BQNaGTp3qQDCSYKNHiXxwqfm/ctdsOLb2DUL/e4ZibGkq/NNtl6QP6f28JGgZtmSQZgzVu0WO
 1/JPK7yHK34B+ZEb6euCs5aQaoTVHoZl7zDuwtgq7ZhtN+3OOepogV7
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The mt8195_set_delay function modifies at its beginning the TX and RX
internal delay variables, located in the driver data, by dividing
them by a constant (290) and restores their original values by
multiplying them again at the function end. It is done in order to
convert them into a step value, used by the hardware registers for
setting these delays.

But this is rather pointless to modify the driver data for that, while
it could be done locally in the function. The original delay values
cannot be used anymore (if needed) during mt8195_set_delay processing.
Finally, they are altered after the function call if they are not a
multiple of 290.

So, simplify these delay variable handling by using local variables to
convert them into the register value and use those in the write calls.
Also, remove the two private conversion functions, that are not useful
anymore and add definitions for MT8195 RX/TX delay maximum and divider
values.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 77 ++++++++++------------
 1 file changed, 36 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 30ae0dba7fff..f7eb85110df0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -63,6 +63,11 @@
 #define MT8195_DLY_RMII_TXC_ENABLE	BIT(5)
 #define MT8195_DLY_RMII_TXC_STAGES	GENMASK(4, 0)
 
+#define MT8195_DLY_RXC_STAGE_DIV	290 /* 290ps per stage */
+#define MT8195_DLY_RXC_MAX		9280 /* 32 x 290ps */
+#define MT8195_DLY_TXC_STAGE_DIV	290 /* 290ps per stage */
+#define MT8195_DLY_TXC_MAX		9280 /* 32 x 290ps */
+
 struct mac_delay_struct {
 	u32 tx_delay;
 	u32 rx_delay;
@@ -293,39 +298,27 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 	return 0;
 }
 
-static void mt8195_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
-{
-	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-
-	/* 290ps per stage */
-	mac_delay->tx_delay /= 290;
-	mac_delay->rx_delay /= 290;
-}
-
-static void mt8195_delay_stage2ps(struct mediatek_dwmac_plat_data *plat)
-{
-	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-
-	/* 290ps per stage */
-	mac_delay->tx_delay *= 290;
-	mac_delay->rx_delay *= 290;
-}
-
 static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 {
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-	u32 gtxc_delay_val = 0, delay_val = 0, rmii_delay_val = 0;
-
-	mt8195_delay_ps2stage(plat);
+	u32 rx_delay_stage_val = mac_delay->rx_delay / MT8195_DLY_RXC_STAGE_DIV;
+	u32 tx_delay_stage_val = mac_delay->tx_delay / MT8195_DLY_TXC_STAGE_DIV;
+	u32 gtxc_delay_val = 0;
+	u32 rmii_delay_val = 0;
+	u32 delay_val = 0;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
-		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE, !!mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES, mac_delay->tx_delay);
+		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
+					!!tx_delay_stage_val);
+		delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES,
+					tx_delay_stage_val);
 		delay_val |= FIELD_PREP(MT8195_DLY_TXC_INV, mac_delay->tx_inv);
 
-		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
-		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES, mac_delay->rx_delay);
+		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE,
+					!!rx_delay_stage_val);
+		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES,
+					rx_delay_stage_val);
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
@@ -336,16 +329,16 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 			 * The ingress timing can be adjusted by RMII_RXC delay macro circuit.
 			 */
 			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_TXC_ENABLE,
-						     !!mac_delay->tx_delay);
+						     !!tx_delay_stage_val);
 			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_TXC_STAGES,
-						     mac_delay->tx_delay);
+						     tx_delay_stage_val);
 			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_TXC_INV,
 						     mac_delay->tx_inv);
 
 			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_RXC_ENABLE,
-						     !!mac_delay->rx_delay);
+						     !!rx_delay_stage_val);
 			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_RXC_STAGES,
-						     mac_delay->rx_delay);
+						     rx_delay_stage_val);
 			rmii_delay_val |= FIELD_PREP(MT8195_DLY_RMII_RXC_INV,
 						     mac_delay->rx_inv);
 		} else {
@@ -361,9 +354,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 				 * by RXC delay macro circuit.
 				 */
 				delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE,
-							!!mac_delay->rx_delay);
+							!!rx_delay_stage_val);
 				delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES,
-							mac_delay->rx_delay);
+							rx_delay_stage_val);
 				delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV,
 							mac_delay->rx_inv);
 			} else {
@@ -372,9 +365,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 				 * by TXC delay macro circuit.
 				 */
 				delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
-							!!mac_delay->rx_delay);
+							!!rx_delay_stage_val);
 				delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES,
-							mac_delay->rx_delay);
+							rx_delay_stage_val);
 				delay_val |= FIELD_PREP(MT8195_DLY_TXC_INV,
 							mac_delay->rx_inv);
 			}
@@ -384,12 +377,16 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
-		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES, mac_delay->tx_delay);
+		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
+					     !!tx_delay_stage_val);
+		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES,
+					     tx_delay_stage_val);
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv);
 
-		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
-		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES, mac_delay->rx_delay);
+		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE,
+					!!rx_delay_stage_val);
+		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES,
+					rx_delay_stage_val);
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
 
 		break;
@@ -408,8 +405,6 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL1, delay_val);
 	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL2, rmii_delay_val);
 
-	mt8195_delay_stage2ps(plat);
-
 	return 0;
 }
 
@@ -418,8 +413,8 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_delay = mt8195_set_delay,
 	.clk_list = mt8195_dwmac_clk_l,
 	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
-	.rx_delay_max = 9280,
-	.tx_delay_max = 9280,
+	.rx_delay_max = MT8195_DLY_RXC_MAX,
+	.tx_delay_max = MT8195_DLY_TXC_MAX,
 	.dma_bit_mask = 35,
 };
 

-- 
2.55.0

