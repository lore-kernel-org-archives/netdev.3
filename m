Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312545;
	b=mD8Te0at7JHdY6RH83mYGDIrIq/JSZWMS0txw0lP8VbyctHnI2ahHrbxNpCN6icxKnB7
	 /opXbK42B0jreQmM85yJZFK8aOTfYZTAmWS8OtgXnIAD6VjDUTQe6+xdXnCaqDaBwH6/7
	 z29oJ0ZC6JnBdN9mrmxQvRpS3OHxuA6wlmCZPUG4huzhrzGHlesUxzrYfMVKnbiBVOd+W
	 fm8rH2XSnJqr17SpHOGWwDB3M7TY0kEeLghEphagjfg1ov8rL23sq/qnFC8/IKUdvuqMi
	 q+cRuiFUtSiViERZRZAJ4uXhvvfkP9Ygrla+Te7whRMycXB9LQ+gmoSO6fMm9koyxkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312545;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=In3mbPH+PeqpuZ21OoiKQ/lny0B5PiDRBDgVSuWiNFo=;
	b=lyAFWs8bp2rknuVDs/3Qy4woQUHeQEErHu2ALAxFX0b+Ol0WHCf/0CgV3Rn1IqpPYTnh
	 Bos9QtF9+py1QtRnMU7C7tIcPVY7A2XDumDoAmkjDjVb5K1XNof7n9Pb67lP0U449iUCa
	 aUUcZFJN0tjBPmk1ob+tND4DRw2j2PzUyHvGH+mUJTtAtYj4+R6AX5JYo58e9dV5Ka/EA
	 w5vnRKStWvwJL1wEGxCukhwAG7rUTF5gxgm77IkvLXLYTfsLjJ0y0dplwzyA37bnf9wh1
	 /n/9ayYq8gWoA6pGYIMu/miH5l0aSQFQJq8cAkGgFzSjVT+dRQkEAaLUp81M+feMnSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qYijceWV;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B085760A5BDC;
	Tue, 10 Nov 2026 12:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B085760A5BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=qYijceWV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312543;
	bh=VR1xLM9crmsR0B4dFSSC/PCirYYuO9+Cgyxo5eh1Zh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qYijceWV1lxuLppyHmsxwNL3o0V6zV2JsxGybjLS/DUm3d6Pl2eXyskgHck5D7rLf
	 xgcMcwPho538yZ5cUXtrMqbH+0yMJnXLI9PA7H/5k7+B8X64CcYJH0+Ne4XHoX4CwP
	 II+6Lw9NMu8+P4P816q/+7opGdCRBopcZ/uDOV+ArgYbXxT0UCCXnblSs5/qBFReIb
	 5iGEvrqGgshoeIPMxjri/sstHZ1rvx5rVzA0nGlvgq2x3wmII7wu2V0VcYvlErWXFX
	 6B2+kJvYCMAbdr0V7n+KGXR99SdCnEbelGc/Bv2FD230meOab2LybmHPbtyDVe3Eun
	 GpbPv1qnFv5LA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4677417E0F7F;
	Tue, 10 Nov 2026 13:09:02 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:51 +0100
Subject: [PATCH net-next v5 04/10] net: stmmac: mediatek: simplify TX/RX
 delay handling in mt8195_set_delay
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-4-7d99d6292962@collabora.com>
References: <20261110-dwmac-mediatek-mt8189-v5-0-7d99d6292962@collabora.com>
In-Reply-To: <20261110-dwmac-mediatek-mt8189-v5-0-7d99d6292962@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=7832;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=VR1xLM9crmsR0B4dFSSC/PCirYYuO9+Cgyxo5eh1Zh8=;
 b=xv9Klmfir4THlINKi7SEf0fD95t5j2kIeikhTmCMJsOsOVCwgzacVLFB0PQMdN3G6gv7XxErJ
 7KjgiYQc1dOCyXe7kvjpXwTIUdeynM4VlK9z/rSop673IKPbGLYhiGn
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
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 91 ++++++++++++----------
 1 file changed, 50 insertions(+), 41 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 30ae0dba7fff..ac473222213f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -63,6 +63,11 @@
 #define MT8195_DLY_RMII_TXC_ENABLE	BIT(5)
 #define MT8195_DLY_RMII_TXC_STAGES	GENMASK(4, 0)
 
+#define MT8195_MII_DLY_STAGE_DIV	290 /* 290ps per stage */
+#define MT8195_MII_DELAY_MAX		9280 /* 32 x 290ps */
+#define MT8195_RGMII_DLY_STAGE_DIV	290 /* 290ps per stage */
+#define MT8195_RGMII_DELAY_MAX		9280 /* 32 x 290ps */
+
 struct mac_delay_struct {
 	u32 tx_delay;
 	u32 rx_delay;
@@ -293,42 +298,39 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
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
+	u32 rx_delay_stage_val, tx_delay_stage_val;
+	u32 gtxc_delay_val = 0;
+	u32 rmii_delay_val = 0;
+	u32 delay_val = 0;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
-		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE, !!mac_delay->tx_delay);
-		delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES, mac_delay->tx_delay);
+		rx_delay_stage_val = mac_delay->rx_delay
+				     / MT8195_MII_DLY_STAGE_DIV;
+		tx_delay_stage_val = mac_delay->tx_delay
+				     / MT8195_MII_DLY_STAGE_DIV;
+
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
+		rx_delay_stage_val = mac_delay->rx_delay
+				     / MT8195_MII_DLY_STAGE_DIV;
+		tx_delay_stage_val = mac_delay->tx_delay
+				     / MT8195_MII_DLY_STAGE_DIV;
+
 		if (plat->rmii_clk_from_mac) {
 			/* case 1: mac provides the rmii reference clock,
 			 * and the clock output to TXC pin.
@@ -336,16 +338,16 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
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
@@ -361,9 +363,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
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
@@ -372,9 +374,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
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
@@ -384,12 +386,21 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE, !!mac_delay->tx_delay);
-		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES, mac_delay->tx_delay);
+		rx_delay_stage_val = mac_delay->rx_delay
+				     / MT8195_RGMII_DLY_STAGE_DIV;
+		tx_delay_stage_val = mac_delay->tx_delay
+				     / MT8195_RGMII_DLY_STAGE_DIV;
+
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
@@ -408,8 +419,6 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL1, delay_val);
 	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL2, rmii_delay_val);
 
-	mt8195_delay_stage2ps(plat);
-
 	return 0;
 }
 
@@ -418,8 +427,8 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_delay = mt8195_set_delay,
 	.clk_list = mt8195_dwmac_clk_l,
 	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
-	.rx_delay_max = 9280,
-	.tx_delay_max = 9280,
+	.rx_delay_max = MT8195_MII_DELAY_MAX,
+	.tx_delay_max = MT8195_MII_DELAY_MAX,
 	.dma_bit_mask = 35,
 };
 

-- 
2.56.0

