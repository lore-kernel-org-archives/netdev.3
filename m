Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700762;
	b=f/9Ak7ggrhHjMv9vRGyZ+A4cpLbEABadSywcGFTbYS7MDeuPGyt1bW3nc3Yyj6n9q885
	 e1KyJlZ9qno488EXyCHKUh309FAEyMAXNHRXx2irOt2Ke3ypFJhRp0YYBw5G7lPK+rxlr
	 si4ZqP6pTFkXWTs+m8SxgxecRQKh71VOLyX/PXotB76/BE9I3X2YrBKh5syWlp5RHWKhh
	 NRnk6r94v5mDpcXU5yKjZJXcVB7DxAG7rQ7vsxaZl39rm0e2hopm5LBYua0dR02C/xXkF
	 wAWylyqJJw/VZjtO+klZDkpdg5sCcleejLGWNpUEdMdeLuPKzH1VDYI+FiVZj2+XVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700762;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=In3mbPH+PeqpuZ21OoiKQ/lny0B5PiDRBDgVSuWiNFo=;
	b=J2O+HORiOLoQ5/Dm7IQTEukfxJuQnbVVK0DK+c+4UVyqyhw0afIxUooAmpYGqELOAvp3
	 HnJEO21pyEmzdOpiPH6W2JKj7QtXfRmBa9HiFcNztoeg3ogokii5Z3A8PsFS7uPoqEwp4
	 YBsiRg3bnhJzOmPii45O3b8CpCZa/bTCzDTJo6fkE5H0898v8ZmsIdA+iv59AIAiIOiWa
	 Hq/GKzA11WsDM84jnH8XMebCDCtRaDw+fHBBcfOYQGQaUi4+DEPhB/rcSeFQJn/AI79YF
	 0Lks9EcBZt0SIxxlUMdBC6iI+MQyAkaVixC9Hax0myRUyGGblBGvCTzQp0QkyDwxuMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cHCgbr+X;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A1606C54D;
	Tue,  3 Nov 2026 10:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 182A1606C54D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cHCgbr+X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700760;
	bh=VR1xLM9crmsR0B4dFSSC/PCirYYuO9+Cgyxo5eh1Zh8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cHCgbr+XBLmTkgab+PKGBTjX5HNWTbJIxcmWq/1kSy9+xQbh3hcZNtTxWqJumtGbq
	 NJfPlGTK9WVO2DHAVeUldgI/rsKP0VYduBXg/kYqZiV9+jhbsRnyrSgmOb4df+2m9Z
	 Aobkt1PdKd74P38DQ4j3IyG95B9P4BENjMBY8SYvTbomCRKhcdiUD2LyhR7RBPD3qS
	 Opk9T7VA/U8brLQ06zd4cN5uWJwr1wZnjwMXikHzWymuB9tgwjDpC1kjQ3j58YY4KY
	 qlatE7v+m/Hv3f40pWd3cUtfEBFXm2ab/92y43DrIdUxEtykwpi3Azyq9R7mrDdjHd
	 0UeL/WyqH+pPg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A74B017E0CD0;
	Tue, 03 Nov 2026 11:12:39 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:09 +0100
Subject: [PATCH net-next v4 04/10] net: stmmac: mediatek: simplify TX/RX
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
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-4-c86c14fc50f4@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=7832;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=VR1xLM9crmsR0B4dFSSC/PCirYYuO9+Cgyxo5eh1Zh8=;
 b=HIDHyOzqljt/ofgHDnJVuAdtmD9cJxRp0/uAlYD6tH79og6NX2jr2axD47G/W8mqajJNLr8DY
 nY9GVebdn0ZCRrG6vwmftjCYsdbHmY/pxfYapBr3SANMsBGxUbyEnRY
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

