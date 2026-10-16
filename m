Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE747535D;
	Fri, 16 Oct 2026 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146724; cv=none; b=iE7nzXkjDyk3YIO8ge0N2LA4baEi4VrwqzIzRwt8fHue/5sw8O/siy/L9uIuBT11Ij/dt/GGfKOTtfa+yxXnfVpFN5ciIwm4WI9qjbwASil08Rm/f/DL48KVFFcKcrzTjvrJNjtygYa4nmZuyOG6r2WVxTpJDfE0TQ/dELV+GF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146724; c=relaxed/simple;
	bh=0P4k5TlwqJxpf+Lfw6QkBv7++Sn0qdgE8r+4nSQtVbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dfHjjCK+rr0Zsi95PV0sOtLCbYxUw1GJ+gB+4ymXwDrLS3LJH0x5/9YsBLFHG6gr4kb8UA+rtrYy5Z6cxbF/0oArkb4FdoR69iqJbCbFXgve+YhvrwXfSy3vb6q62sAlySGxjTOasajwtuusggZt/F8ty+xqQ18lvERoIbLVobA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XcFHUCJE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XcFHUCJE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792146720;
	bh=0P4k5TlwqJxpf+Lfw6QkBv7++Sn0qdgE8r+4nSQtVbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XcFHUCJE834Qq0M85QviNRTQ9ATEwCBkgNRrBzgSLEoJkE8ApxHGoUTNVxo6ph55R
	 SJIGad0eaGs1oO4zQXwiryTXcKTgTWo4NzUAfQEq5obF92RAjkicNrV1tEUETx4I+6
	 NbzTVhx1X3Y9GMVW9GyQpzFDqYkIt2BoiSeRxECDLNxKi1bZBJRBP2m2UPH2ZSDO+R
	 hWkmG9FYbP4SGhxElr0m8GLxVgjGKpfWDzRqCskY1YXK/StpXy61GIn5cg3JZNBZqP
	 loCqx76CuRk3KFBVanjPS1/WjnUHWm80Ee5rlgbHg1krTXT2HJ18DZ1H9w3kitL9FR
	 eORVOLjdRAnYQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B565E17E0960;
	Fri, 16 Oct 2026 12:31:59 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 16 Oct 2026 12:31:07 +0200
Subject: [PATCH net-next v3 3/9] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt8195_set_delay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-dwmac-mediatek-mt8189-v3-3-25daf2bbcf35@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146716; l=7341;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=0P4k5TlwqJxpf+Lfw6QkBv7++Sn0qdgE8r+4nSQtVbU=;
 b=ByPVkiRaEAvy52sGLvFWD9hFrl2UetalR9mv++VHzM/3w71I0cPUespBmv4co4p5Ich2LItzt
 6NlopUT5DYnB7+lVhfRfVnUkMcT99k2TogoZA+50puyJLWvsZNe5ej5
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

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
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
2.56.0

