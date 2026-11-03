Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700763;
	b=xego8eBvXhjEgfeQcRDwdqdoYDnyrj+PxF/8qtH1ubHmEH+t9DFCWwv2OpGq/kg9aVnM
	 xQicofWfCIbKrpNBVK+h8rwY+6AvE89kJrFmWNG1cIlZgz/2f4g/zX9gLkXlxOrD1TNVw
	 b6VoBkoqY4+PhtQmhQNmRD0z5PewTXW0YfdxbxKD90/l1eQ5xXsq2+Gs/xXWBrPHP2pON
	 1aOekTsJass4gDsXXpXRHwr4XQssllM8lNJwZzOkJuHupim/9eNoC6plqWz5H0dM2mejU
	 jfnpZxLlJLI/RW4G2pEwv1PACWpWWWwOZWb6buM7aGE0Rw4A6tV8UpeM3ixiyT6leLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700763;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=VoYBz3+hGfG67bP/+FnXcevyFCV31ZwmysGraNJTs/Q=;
	b=ScKWAbvle3sAecKGai9FiDyn4AJI8N59CFHJ2AgyvgT4JKCLvkE5O3NrwXvPl2hRa98j
	 A8w9al+0jkJWLPu/QYX9sjw0YiG+qY6uEXdX7QIEpwTuTjUvlztBV87EgJsekK7E60q/M
	 VYtrNcsDWHK/PuM8tno+eKFprMRovOjuflcxSyA9mooW/Xdh5pAi1rRvKwWc6BfgDOYvI
	 YcK+wyvsomOPFDuEjgnFx0RtGu47FHxl2TfJw+Bq+wAYEW+jgZH+fifqXPUVqVDVfem/+
	 vkeLYvfWZmNsUQ/TfwffIVPbRJDFcclpVVQjbXqxrufC08EUttTxnW226QV75TYuceQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="VuX/+AGh";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E85C606C560;
	Tue,  3 Nov 2026 10:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E85C606C560
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VuX/+AGh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700761;
	bh=2hgcJ4xTqBUI6oXDj7NMFqlwMw/T6ZiJJcVbLNeW9k8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VuX/+AGhuHyi/8VmMztfUmhBmdRA09k9rwpG01+jma22lWtmAmAltyXhIXp1PSfby
	 RqJOUpFnKfQ+z1DPlUpeg4eb3Hdg1J6t6YfinWg4SarV0rKrmlAFw00oHAwz9CYix+
	 82CLMeuIzC5itIFdJ0KA83Be9H2mbMmQjk3+wiFvi8hdLYGzjIdkm5OqVfO5Oq6JVU
	 pCxDI7/UOK1z36UaD+avqW29stU1gHn2PMEaH7AmmGXA8Nec1+5mdG/jixrcO9ov2z
	 OUMGmFf97HiGtd0EP6kAdqKI8XV34W9LvzNnsAWDLkuwJ6wpZEGvk8SOkNEqL0ftbc
	 UkApBWp2wsmSg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B729917E0CFC;
	Tue, 03 Nov 2026 11:12:40 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:10 +0100
Subject: [PATCH net-next v4 05/10] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt2712_set_delay
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-5-c86c14fc50f4@collabora.com>
References: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
In-Reply-To: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=9411;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=2hgcJ4xTqBUI6oXDj7NMFqlwMw/T6ZiJJcVbLNeW9k8=;
 b=9U5uNovEKYqz4JSlmfAm7+ywkIhq6rJraQdTQgzNbXx8IVJ/MaC0jT9KzTRVMFpcGqgPpi0Gi
 cYuCpI/qbiHDxKTjEAStblpdY+NGu+si0IYwrLys/fnCRlZvD8A/Ezl
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The mt2712_set_delay function modifies at its beginning the TX and RX
internal delay variables, located in the driver data, by dividing
them by a constant (170 for RGMII, 550 for MII/RMII) and restores their
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
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 140 +++++++++------------
 1 file changed, 62 insertions(+), 78 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index ac473222213f..cda3f3edde39 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -36,6 +36,11 @@
 #define ETH_FINE_DLY_GTXC	BIT(1)
 #define ETH_FINE_DLY_RXC	BIT(0)
 
+#define MT2712_MII_DLY_STAGE_DIV	550 /* 550ps per stage */
+#define MT2712_MII_DELAY_MAX		17600 /* 32 x 550ps */
+#define MT2712_RGMII_DLY_STAGE_DIV	170 /* 170ps per stage */
+#define MT2712_RGMII_DELAY_MAX		5440 /* 32 x 170ps */
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL0		0xFD0
 #define MT8195_RMII_CLK_SRC_INTERNAL	BIT(28)
@@ -129,86 +134,54 @@ static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat,
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
-
-	mt2712_delay_ps2stage(plat);
+	u32 rx_delay_stage_val, tx_delay_stage_val;
+	u32 delay_val = 0;
+	u32 fine_val = 0;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
-		delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE, !!mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES, mac_delay->tx_delay);
+		rx_delay_stage_val = mac_delay->rx_delay
+				     / MT2712_MII_DLY_STAGE_DIV;
+		tx_delay_stage_val = mac_delay->tx_delay
+				     / MT2712_MII_DLY_STAGE_DIV;
+
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
+		rx_delay_stage_val = mac_delay->rx_delay
+				     / MT2712_MII_DLY_STAGE_DIV;
+		tx_delay_stage_val = mac_delay->tx_delay
+				     / MT2712_MII_DLY_STAGE_DIV;
+
 		if (plat->rmii_clk_from_mac) {
 			/* case 1: mac provides the rmii reference clock,
 			 * and the clock output to TXC pin.
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
@@ -222,16 +195,20 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
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
@@ -246,14 +223,23 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
+		rx_delay_stage_val = mac_delay->rx_delay
+				     / MT2712_RGMII_DLY_STAGE_DIV;
+		tx_delay_stage_val = mac_delay->tx_delay
+				     / MT2712_RGMII_DLY_STAGE_DIV;
+
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
@@ -263,19 +249,17 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
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
+	.rx_delay_max = MT2712_MII_DELAY_MAX,
+	.tx_delay_max = MT2712_MII_DELAY_MAX,
+	.dma_bit_mask = 33,
 };
 
 static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,

-- 
2.56.0

