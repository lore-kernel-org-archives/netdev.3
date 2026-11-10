Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312548;
	b=ILqB8JPMwMOdIBtt7Gu4lPuIv63GhdBhBoWxph5gfzNQ5ZCNNes31zzjEvYini0aubJn
	 xggkoNnIzWo2INQacwRFVLM0Sspzk9YiTwqY0XOn2n3IA988iauHjpH9kYe4ogivKkhFw
	 Ls1w/IO9aZUuLsL3nRnX1wicpUeZR098/05srAVCS5qrjm4iYwEA4/A+7yqgIJcSuuzj3
	 Wu5ZgcbFfrMtaNChOlvVtlQm/Gn1FZzvPSbzyRSMCbGbUxpQwTxMuHEM2dj1JDD0LFFBc
	 zduVIfAT5uw5vjahcqNKzZg8RMqgsS/NJ84JJMj/FglucUHOsoQ+5uiAhnT/LbG/RPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312548;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2VxWQxSi7d+SWQbpixOxWhdXjeNO9EnLhMCZBZw6Mgc=;
	b=KOxmkRmeJCm//TxixE3IjCeZOPSVlV6e/RGa97w9bXrpEZhEL7vGGkg9ehxLKTkKZCBn
	 eDBX6RxNz+SiMNd4n7q5L7IWlIE9rfNU8v7IIF5L5OrzHRrwEdigSIRf0p6/Kf37GbTN8
	 UW55q4s3OPI+UFIOTBEYMmW2UBjDHo5IXXoh9fjVcTtAHVG3DvdOolz60ehXa9QsXLOMR
	 QzP3Ej8kYFN0iDxWI88KxIkiH5kSyApGJ+jjUjLBXdciFUXBbvpZuPHY3041yUyCPXzlo
	 uJ5ZJGq+Jwe8nSMJHiVOwM5GhPTGTQMaUSNqzobQIVm5cWs+Nde9F7K+LdbUqBd6/Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KE1lmbsT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E060A6F60;
	Tue, 10 Nov 2026 12:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E13E060A6F60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KE1lmbsT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312546;
	bh=Ps6gSsR2rjozRkHI3jucfzvVXaBDctDUcKntymg4Ky8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KE1lmbsTZAYlix7MYvzVLKXV+AF129/GMG7OXGVhZWRHm4umyH2INaxf5LoxP7+Us
	 TjvpLIoHb82NcelP4yLzcQ3E9GJivWKqgD6V5H1gMXHJDfypg5U/SgtUPrM/ySLiaQ
	 myBK/cO7TUC6AdfYD2H/oSGjPkCYLvPhsbLx0fexbem7AopEdI+gamHpjL39TJ5rS7
	 lUNmgushyStVPC1dDQYTGB3eToxQtpalL7rXbH1OLtIrtYNqO8971aZ0q5A3DTrgkD
	 6Ep0LjJngm8nHrtIGJ8FMaajDiALGP4+dNUfZYuY30ulw7nLTZkBfg1YYeMW0+1Vyf
	 6glxVc1zcs15Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7455817E02F2;
	Tue, 10 Nov 2026 13:09:05 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:54 +0100
Subject: [PATCH net-next v5 07/10] net: stmmac: mediatek: add RX/TX delay
 stage divider in platform data
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-7-7d99d6292962@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=6197;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Ps6gSsR2rjozRkHI3jucfzvVXaBDctDUcKntymg4Ky8=;
 b=mJI8CexdfhQh/ZxxzxHyJ5YItX+FipK4ZsRzkE9mKgGehbPK7We7K/qbflf9x27v+96veOuS0
 eI5CVl+dywhAp9sPzt5m74hr1+KF55x/5p2Bs8huxTmHFOBYAFq7LW+
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In preparation of newer SoC support, that have like MT8189 SoC
different RX and TX internal delay stage steps than MT8188/MT8195, add
the RX and TX delay stage divider values in the variant platform data
and replace the hardcoded value uses in mt2712_set_delay and
mt8195_set_delay.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 76 +++++++++++++---------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index ee43d694099b..e39ca83c2a6f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -107,6 +107,8 @@ struct mediatek_dwmac_variant {
 
 	u32 mii_delay_max;
 	u32 rgmii_delay_max;
+	u16 mii_delay_stage_div;
+	u16 rgmii_delay_stage_div;
 	u8 dma_bit_mask;
 };
 
@@ -119,6 +121,36 @@ static const char * const mt8195_dwmac_clk_l[] = {
 	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
 };
 
+static int get_delay_stage(struct mediatek_dwmac_plat_data *plat,
+			   u32 *rx_val, u32 *tx_val)
+{
+	struct mac_delay_struct *mac_delay = &plat->mac_delay;
+	u32 rx_delay_conf_val, tx_delay_conf_val;
+	u16 delay_stage_div;
+
+	if (phy_interface_mode_is_rgmii(plat->phy_mode)) {
+		/* RGMII case */
+		delay_stage_div = plat->variant->rgmii_delay_stage_div;
+		rx_delay_conf_val = mac_delay->rgmii_rx_delay;
+		tx_delay_conf_val = mac_delay->rgmii_tx_delay;
+	} else {
+		/* MII/RMII case */
+		delay_stage_div = plat->variant->mii_delay_stage_div;
+		rx_delay_conf_val = mac_delay->rx_delay;
+		tx_delay_conf_val = mac_delay->tx_delay;
+	}
+
+	if (!delay_stage_div) {
+		dev_err(plat->dev, "Invalid internal delay stage divider\n");
+		return -EINVAL;
+	}
+
+	*rx_val = rx_delay_conf_val / delay_stage_div;
+	*tx_val = tx_delay_conf_val / delay_stage_div;
+
+	return 0;
+}
+
 static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat,
 				u8 phy_intf_sel)
 {
@@ -142,14 +174,14 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	u32 rx_delay_stage_val, tx_delay_stage_val;
 	u32 delay_val = 0;
 	u32 fine_val = 0;
+	int ret;
+
+	ret = get_delay_stage(plat, &rx_delay_stage_val, &tx_delay_stage_val);
+	if (ret)
+		return ret;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
-		rx_delay_stage_val = mac_delay->rx_delay
-				     / MT2712_MII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->tx_delay
-				     / MT2712_MII_DLY_STAGE_DIV;
-
 		delay_val |= FIELD_PREP(ETH_DLY_TXC_ENABLE,
 					!!tx_delay_stage_val);
 		delay_val |= FIELD_PREP(ETH_DLY_TXC_STAGES,
@@ -163,11 +195,6 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 		delay_val |= FIELD_PREP(ETH_DLY_RXC_INV, mac_delay->rx_inv);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		rx_delay_stage_val = mac_delay->rx_delay
-				     / MT2712_MII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->tx_delay
-				     / MT2712_MII_DLY_STAGE_DIV;
-
 		if (plat->rmii_clk_from_mac) {
 			/* case 1: mac provides the rmii reference clock,
 			 * and the clock output to TXC pin.
@@ -225,11 +252,6 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		rx_delay_stage_val = mac_delay->rgmii_rx_delay
-				     / MT2712_RGMII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->rgmii_tx_delay
-				     / MT2712_RGMII_DLY_STAGE_DIV;
-
 		fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
 
 		delay_val |= FIELD_PREP(ETH_DLY_GTXC_ENABLE,
@@ -261,6 +283,8 @@ static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
 	.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
 	.mii_delay_max = MT2712_MII_DELAY_MAX,
 	.rgmii_delay_max = MT2712_RGMII_DELAY_MAX,
+	.mii_delay_stage_div = MT2712_MII_DLY_STAGE_DIV,
+	.rgmii_delay_stage_div = MT2712_RGMII_DLY_STAGE_DIV,
 	.dma_bit_mask = 33,
 };
 
@@ -291,14 +315,14 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	u32 gtxc_delay_val = 0;
 	u32 rmii_delay_val = 0;
 	u32 delay_val = 0;
+	int ret;
+
+	ret = get_delay_stage(plat, &rx_delay_stage_val, &tx_delay_stage_val);
+	if (ret)
+		return ret;
 
 	switch (plat->phy_mode) {
 	case PHY_INTERFACE_MODE_MII:
-		rx_delay_stage_val = mac_delay->rx_delay
-				     / MT8195_MII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->tx_delay
-				     / MT8195_MII_DLY_STAGE_DIV;
-
 		delay_val |= FIELD_PREP(MT8195_DLY_TXC_ENABLE,
 					!!tx_delay_stage_val);
 		delay_val |= FIELD_PREP(MT8195_DLY_TXC_STAGES,
@@ -312,11 +336,6 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		rx_delay_stage_val = mac_delay->rx_delay
-				     / MT8195_MII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->tx_delay
-				     / MT8195_MII_DLY_STAGE_DIV;
-
 		if (plat->rmii_clk_from_mac) {
 			/* case 1: mac provides the rmii reference clock,
 			 * and the clock output to TXC pin.
@@ -372,11 +391,6 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		rx_delay_stage_val = mac_delay->rgmii_rx_delay
-				     / MT8195_RGMII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->rgmii_tx_delay
-				     / MT8195_RGMII_DLY_STAGE_DIV;
-
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
 					     !!tx_delay_stage_val);
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES,
@@ -415,6 +429,8 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
 	.mii_delay_max = MT8195_MII_DELAY_MAX,
 	.rgmii_delay_max = MT8195_RGMII_DELAY_MAX,
+	.mii_delay_stage_div = MT8195_MII_DLY_STAGE_DIV,
+	.rgmii_delay_stage_div = MT8195_RGMII_DLY_STAGE_DIV,
 	.dma_bit_mask = 35,
 };
 

-- 
2.56.0

