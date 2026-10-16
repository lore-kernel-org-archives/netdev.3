Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9AE466B08;
	Fri, 16 Oct 2026 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146725; cv=none; b=l8xNanknxqBvIM0o6OajmbTKoLQ0TM5KDTdaDXGrRRf5Lqn3lJIV9u8rFxAiJsrNG3qgaNflPR0uKk2dmxHpoQ364tk2+M8CJP7tmvgtUzI+sWQnv24nhzE42CvvqA5Nmz0Id/BeBI7ZC1Lu4/5AX6qexjSqbAdxlb8GfYnpFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146725; c=relaxed/simple;
	bh=a0AS66wd95Jj0Kyrt89QUpczsVf6smrzrXD5/0CRXCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ICkaUnmdOFlOgBFKtlq5jz7BsDxu3nvYw8FqiOPkfSOlQMQi7+qwqkUjdV7ZnP9F22rk0BvYvMfOxT/1tN+XUg69YPgmiP8v01riPbv8y7OWBUDzYiLhawwNeNV2nyMR5OQritGM8QBQ9T+zr9t7eVac2oYCP94HF5Eq+ACG22o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aGEliin8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aGEliin8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792146721;
	bh=a0AS66wd95Jj0Kyrt89QUpczsVf6smrzrXD5/0CRXCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aGEliin8PQqTBWFXjDCBPjQrZxm/8+eZouNdhxfahvmzJn8CmUL8JdNWdkkkmgDKz
	 uCUoFutL7gH0SucEj/ZZTqfmPej9rJw9jwG4qy9guWgUMuz4sUgbSCve4oCnF41eux
	 zI58o6o0kRor/zS4xXLzIIpLpMepLF+v5aWovuhftbAJSzo75y8izeNUnV4SRCblAv
	 9VptYyWw3NJg7YyR3RyWDyNWwrn5/gWrmVVNBvOf9+cZnFzvF+tFQsd9f7BR3fqqyC
	 G5Py5X+wk1jQiKTufRZ3zWR2ldj0LIn812ByhTs2kSyIvMptx9tAjSvq3KQFYD53mA
	 I/m8UmJX/QG/g==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CDCF017E09A2;
	Fri, 16 Oct 2026 12:32:00 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 16 Oct 2026 12:31:08 +0200
Subject: [PATCH net-next v3 4/9] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt2712_set_delay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-dwmac-mediatek-mt8189-v3-4-25daf2bbcf35@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146716; l=9409;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=a0AS66wd95Jj0Kyrt89QUpczsVf6smrzrXD5/0CRXCI=;
 b=cKNUOqj4rl6AP4hULR/iul/gFFfG20yRPE7sJ1xV7wH6egXHq7kZX9SLbUTbIjGLAkgHA/1ix
 8ptOLWZNLbiBp+s7x3aKWqQXVROqZlr0aRXXB8FLhpIvZAMkUozCbXk
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The mt2712_set_delay function modifies at its beginning the TX and RX
internal delay variables, located in the driver data, by dividing
them by a constant (550 for RGMII, 170 for MII/RMII) and restores their
original values by multiplying them again at the function end. It is
done in order to convert them into a step value, used by the hardware
registers for setting these delays.

But this is rather pointless to modify the driver data for that, while
it could be done locally in the function. The original delay values
cannot be used anymore (if needed) during mt2712_set_delay processing.
Finally, they are altered after the function call if they are not a
multiple of the delay stage divider.

So, simplify these delay variable handling by using local variables to
convert them into the register value and use those in the write calls.
Also, remove the two private conversion functions, that are not useful
anymore and add definitions for MT2712 RX/TX delay maximum and divider
values.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 137 +++++++++------------
 1 file changed, 60 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index f7eb85110df0..596411d4a5b2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -36,6 +36,14 @@
 #define ETH_FINE_DLY_GTXC	BIT(1)
 #define ETH_FINE_DLY_RXC	BIT(0)
 
+#define MT2712_RMII_DLY_RXC_STAGE_DIV	170 /* 170ps per stage */
+#define MT2712_RMII_DLY_TXC_STAGE_DIV	170 /* 170ps per stage */
+
+#define MT2712_RGMII_DLY_RXC_STAGE_DIV	550 /* 550ps per stage */
+#define MT2712_RGMII_DLY_RXC_MAX	17600 /* 32 x 550ps */
+#define MT2712_RGMII_DLY_TXC_STAGE_DIV	550 /* 550ps per stage */
+#define MT2712_RGMII_DLY_TXC_MAX	17600 /* 32 x 550ps */
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL0		0xFD0
 #define MT8195_RMII_CLK_SRC_INTERNAL	BIT(28)
@@ -129,71 +137,36 @@ static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat,
 	return 0;
 }
 
-static void mt2712_delay_ps2stage(struct mediatek_dwmac_plat_data *plat)
-{
-	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-
-	switch (plat->phy_mode) {
-	case PHY_INTERFACE_MODE_MII:
-	case PHY_INTERFACE_MODE_RMII:
-		/* 550ps per stage for MII/RMII */
-		mac_delay->tx_delay /= 550;
-		mac_delay->rx_delay /= 550;
-		break;
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		/* 170ps per stage for RGMII */
-		mac_delay->tx_delay /= 170;
-		mac_delay->rx_delay /= 170;
-		break;
-	default:
-		dev_err(plat->dev, "phy interface not supported\n");
-		break;
-	}
-}
-
-static void mt2712_delay_stage2ps(struct mediatek_dwmac_plat_data *plat)
-{
-	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-
-	switch (plat->phy_mode) {
-	case PHY_INTERFACE_MODE_MII:
-	case PHY_INTERFACE_MODE_RMII:
-		/* 550ps per stage for MII/RMII */
-		mac_delay->tx_delay *= 550;
-		mac_delay->rx_delay *= 550;
-		break;
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-		/* 170ps per stage for RGMII */
-		mac_delay->tx_delay *= 170;
-		mac_delay->rx_delay *= 170;
-		break;
-	default:
-		dev_err(plat->dev, "phy interface not supported\n");
-		break;
-	}
-}
-
 static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 {
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-	u32 delay_val = 0, fine_val = 0;
+	u32 rx_delay_stage_val, tx_delay_stage_val;
+	u16 rx_delay_stage_div, tx_delay_stage_div;
+	u32 delay_val = 0;
+	u32 fine_val = 0;
 
-	mt2712_delay_ps2stage(plat);
+	if (phy_interface_mode_is_rgmii(plat->phy_mode)) {
+		rx_delay_stage_div = MT2712_RGMII_DLY_RXC_STAGE_DIV;
+		tx_delay_stage_div = MT2712_RGMII_DLY_TXC_STAGE_DIV;
+	} else {
+		rx_delay_stage_div = MT2712_RMII_DLY_RXC_STAGE_DIV;
+		tx_delay_stage_div = MT2712_RMII_DLY_TXC_STAGE_DIV;
+	}
+	rx_delay_stage_val = mac_delay->rx_delay / rx_delay_stage_div;
+	tx_delay_stage_val = mac_delay->tx_delay / tx_delay_stage_div;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
-		delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE, !!mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES, mac_delay->tx_delay);
+		delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE,
+					!!tx_delay_stage_val);
+		delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES,
+					tx_delay_stage_val);
 		delay_val |= FIELD_PREP(ETH_DLY_TXC_INV, mac_delay->tx_inv);
 
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
+		delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE,
+					!!rx_delay_stage_val);
+		delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES,
+					rx_delay_stage_val);
 		delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
@@ -203,12 +176,16 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 			 * The egress timing can be adjusted by GTXC delay macro circuit.
 			 * The ingress timing can be adjusted by TXC delay macro circuit.
 			 */
-			delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE, !!mac_delay->rx_delay);
-			delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES, mac_delay->rx_delay);
+			delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE,
+						!!rx_delay_stage_val);
+			delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES,
+						rx_delay_stage_val);
 			delay_val |= FIELD_PREP(ETH_DLY_TXC_INV, mac_delay->rx_inv);
 
-			delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
-			delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
+			delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE,
+						!!tx_delay_stage_val);
+			delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES,
+						tx_delay_stage_val);
 			delay_val |= FIELD_PREP(ETH_DLY_GTXC_INV, mac_delay->tx_inv);
 		} else {
 			/* case 2: the rmii reference clock is from external phy,
@@ -222,16 +199,20 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 				 * to RXC pin, the reference clock will be adjusted
 				 * by RXC delay macro circuit.
 				 */
-				delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
-				delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
+				delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE,
+							!!rx_delay_stage_val);
+				delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES,
+							rx_delay_stage_val);
 				delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
 			} else {
 				/* the rmii reference clock from outside is connected
 				 * to TXC pin, the reference clock will be adjusted
 				 * by TXC delay macro circuit.
 				 */
-				delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE, !!mac_delay->rx_delay);
-				delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES, mac_delay->rx_delay);
+				delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE,
+							!!rx_delay_stage_val);
+				delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES,
+							rx_delay_stage_val);
 				delay_val |= FIELD_PREP(ETH_DLY_TXC_INV, mac_delay->rx_inv);
 			}
 			/* tx_inv will inverse the tx clock inside mac relateive to
@@ -248,12 +229,16 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 		fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
 
-		delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES, mac_delay->tx_delay);
+		delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE,
+					!!tx_delay_stage_val);
+		delay_val |= FIELD_PREP(ETH_DLY_GTXC_STAGES,
+					tx_delay_stage_val);
 		delay_val |= FIELD_PREP(ETH_DLY_GTXC_INV, mac_delay->tx_inv);
 
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES, mac_delay->rx_delay);
+		delay_val |= FIELD_PREP(ETH_DLY_RXC_ENABLE,
+					!!rx_delay_stage_val);
+		delay_val |= FIELD_PREP(ETH_DLY_RXC_STAGES,
+					rx_delay_stage_val);
 		delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
 		break;
 	default:
@@ -263,19 +248,17 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	regmap_write(plat->peri_regmap, PERI_ETH_DLY, delay_val);
 	regmap_write(plat->peri_regmap, PERI_ETH_DLY_FINE, fine_val);
 
-	mt2712_delay_stage2ps(plat);
-
 	return 0;
 }
 
 static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
-		.dwmac_set_phy_interface = mt2712_set_interface,
-		.dwmac_set_delay = mt2712_set_delay,
-		.clk_list = mt2712_dwmac_clk_l,
-		.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
-		.rx_delay_max = 17600,
-		.tx_delay_max = 17600,
-		.dma_bit_mask = 33,
+	.dwmac_set_phy_interface = mt2712_set_interface,
+	.dwmac_set_delay = mt2712_set_delay,
+	.clk_list = mt2712_dwmac_clk_l,
+	.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
+	.rx_delay_max = MT2712_RGMII_DLY_RXC_MAX,
+	.tx_delay_max = MT2712_RGMII_DLY_TXC_MAX,
+	.dma_bit_mask = 33,
 };
 
 static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,

-- 
2.56.0

