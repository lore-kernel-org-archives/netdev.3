Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312547;
	b=5d3UwgRjt5aPQIHTrLyDyXiiHQHU2ctnuNrBYoxiE4wIhZjTA11GYypxKYlN2/Ot6njM
	 MAEP2rxCacRa7ib0oGQlIA7l0ohRipCr4iWQ/bkH1T9SZjytET2vV/i4bjCasiY0nF0Js
	 7QE7mgzB31KzOAyGv72fGieI8zD0y/6jWoqhIcsNLbYp0ZAOJen/IxRks/PSoPzFqv/11
	 WlEI0ypVL8UJ6fJH3wkM0QGeNwxDj9tdd/WJ9g1lPs6CIl+7+vi3EHqgzqzTS65EBuKQG
	 qD1hweQa4zn7eigSLAgcLCKXlddmZFqOVzxQr7eIBSMrkgflsTQNaktZB/VGv7zeKCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312547;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ljb2ROakm/7yv3tvrmiWdL9P5YB+0wWTcdNkA0NOh5I=;
	b=zp2a+crIWYXYgJf+dih3pPA0sU9UN0CMyKVHUle7Lhq1XdToXty2sHtw1Qr2prhFE8m8
	 Y5gYOmy2JqGzVOKY8vc9lupi/W8io69uLHEtSDKI4qhHiIeeKhIXfZeYy/c3R6ERZaEG+
	 0UE1uLx45fiqv8bQYROvgVSSBRGbTff7JO2LNfrLv5PPFwvo9N8Bl9Pko+vxD1YqpJ478
	 gGyuu2Xd5Si+NB7c2hZMOZdqR5YvUbJdJt35JFcIXwH2m65olybYJKYnlEK3zbMhoVobl
	 iwH1pNXsT5VTpqQUrgOAFbr0WCHkOBq/0p7TklKIbwk3sku6Qj9iDT6QsUoHqi6sfqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hUWOIrie;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61A60A6F41;
	Tue, 10 Nov 2026 12:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF61A60A6F41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=hUWOIrie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312545;
	bh=9zTfpFSOfSR7K4KelXmqsZfnPzJ3QJQHwaaNyOyw9oU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hUWOIrie0jZ8WzOerZkSwJOL+9GmmvTPA9WgduRFQOF23VX22i5UG4m5Ds2fuWRnJ
	 qHrUDuCF4AKEPZRUFuapMldSxLMHBfETaZOFJc0xjkwHdbPhrtHfMVjZskwCYEh7B4
	 oYfjv4WyDddOwlEG6YhwHA95TKlAcd/vhB1U7Vd2/fPwwN+3GOH2lxbBOlTV4RX/vm
	 598PceswMn3XuMkUGYhLmCYZCotuOWJToXqYGnk6NpACCIazOqNbesBOsGbdCZOmQa
	 G37QZKT9CaUwwZ6jEjubewmVaMFsnaowHN10Kz1rRM6uf0VZflExMobgTysvcxRnul
	 7PwufC7rzSdkA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6439017E1054;
	Tue, 10 Nov 2026 13:09:04 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:53 +0100
Subject: [PATCH net-next v5 06/10] net: stmmac: mediatek: use standard
 internal delay properties
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-6-7d99d6292962@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=6869;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=9zTfpFSOfSR7K4KelXmqsZfnPzJ3QJQHwaaNyOyw9oU=;
 b=UjW5NzVt6aJGoFdhsBj3HAsHvhnfvWevTvJnmRLUfueCdauVQYkQQLcCUgLqoNHNLQQZzy9LL
 mMsK0SMRSQrBikN2co2I0WcT5c71GgL7fxLlcNZFAEIPMB4jpO8hOnC
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Currently, the mediatek-dwmac driver uses the 'mediatek,rx-delay-ps'
and 'mediatek,tx-delay-ps' vendor properties for configuring the RX and
TX internal clock delays for all its supported PHY modes (MII, RMII,
and RGMII).

The generic Ethernet controller bindings provide 'rx-internal-delay-ps'
and 'tx-internal-delay-ps' standard properties to describe the RGMII RX
and TX internal clock delays. Their use is now recommended, rather than
existing vendor properties.
There is no equivalent standard properties for RMII and MII case at the
moment.

So, add in driver data separate config values for MII/RMII and RGMII
delays and modify mediatek_dwmac_config_dt, used to parse devicetree
to populate and check these configs with the following logic:
 - read vendor properties for MII and RMII delay timings
 - read standard properties for RGMII delay timings
 - if not available, fallback to vendor values

Also, modify mt2712/mt8195_set_delay to use these new separate config
values.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 81 ++++++++++++++++------
 1 file changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index cda3f3edde39..ee43d694099b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -76,6 +76,8 @@
 struct mac_delay_struct {
 	u32 tx_delay;
 	u32 rx_delay;
+	u32 rgmii_tx_delay;
+	u32 rgmii_rx_delay;
 	bool tx_inv;
 	bool rx_inv;
 };
@@ -103,8 +105,8 @@ struct mediatek_dwmac_variant {
 	const char * const *clk_list;
 	int num_clks;
 
-	u32 rx_delay_max;
-	u32 tx_delay_max;
+	u32 mii_delay_max;
+	u32 rgmii_delay_max;
 	u8 dma_bit_mask;
 };
 
@@ -223,9 +225,9 @@ static int mt2712_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		rx_delay_stage_val = mac_delay->rx_delay
+		rx_delay_stage_val = mac_delay->rgmii_rx_delay
 				     / MT2712_RGMII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->tx_delay
+		tx_delay_stage_val = mac_delay->rgmii_tx_delay
 				     / MT2712_RGMII_DLY_STAGE_DIV;
 
 		fine_val = ETH_FINE_DLY_GTXC | ETH_FINE_DLY_RXC;
@@ -257,8 +259,8 @@ static const struct mediatek_dwmac_variant mt2712_gmac_variant = {
 	.dwmac_set_delay = mt2712_set_delay,
 	.clk_list = mt2712_dwmac_clk_l,
 	.num_clks = ARRAY_SIZE(mt2712_dwmac_clk_l),
-	.rx_delay_max = MT2712_MII_DELAY_MAX,
-	.tx_delay_max = MT2712_MII_DELAY_MAX,
+	.mii_delay_max = MT2712_MII_DELAY_MAX,
+	.rgmii_delay_max = MT2712_RGMII_DELAY_MAX,
 	.dma_bit_mask = 33,
 };
 
@@ -370,9 +372,9 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_ID:
-		rx_delay_stage_val = mac_delay->rx_delay
+		rx_delay_stage_val = mac_delay->rgmii_rx_delay
 				     / MT8195_RGMII_DLY_STAGE_DIV;
-		tx_delay_stage_val = mac_delay->tx_delay
+		tx_delay_stage_val = mac_delay->rgmii_tx_delay
 				     / MT8195_RGMII_DLY_STAGE_DIV;
 
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
@@ -411,15 +413,18 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_delay = mt8195_set_delay,
 	.clk_list = mt8195_dwmac_clk_l,
 	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
-	.rx_delay_max = MT8195_MII_DELAY_MAX,
-	.tx_delay_max = MT8195_MII_DELAY_MAX,
+	.mii_delay_max = MT8195_MII_DELAY_MAX,
+	.rgmii_delay_max = MT8195_RGMII_DELAY_MAX,
 	.dma_bit_mask = 35,
 };
 
 static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
 {
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
-	u32 tx_delay_ps, rx_delay_ps;
+	u32 rgmii_tx_delay_ps = 0;
+	u32 rgmii_rx_delay_ps = 0;
+	u32 tx_delay_ps = 0;
+	u32 rx_delay_ps = 0;
 
 	plat->peri_regmap = syscon_regmap_lookup_by_phandle(plat->np, "mediatek,pericfg");
 	if (IS_ERR(plat->peri_regmap)) {
@@ -427,24 +432,58 @@ static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)
 		return PTR_ERR(plat->peri_regmap);
 	}
 
-	if (!of_property_read_u32(plat->np, "mediatek,tx-delay-ps", &tx_delay_ps)) {
-		if (tx_delay_ps < plat->variant->tx_delay_max) {
-			mac_delay->tx_delay = tx_delay_ps;
-		} else {
-			dev_err(plat->dev, "Invalid TX clock delay: %dps\n", tx_delay_ps);
+	of_property_read_u32(plat->np, "mediatek,tx-delay-ps", &tx_delay_ps);
+	if (tx_delay_ps >= plat->variant->mii_delay_max) {
+		dev_err(plat->dev, "Invalid TX clock delay: %dps\n",
+			tx_delay_ps);
+		return -EINVAL;
+	}
+
+	/* Read RGMII TX internal delay standard property */
+	if (!of_property_read_u32(plat->np, "tx-internal-delay-ps",
+				  &rgmii_tx_delay_ps)) {
+		if (rgmii_tx_delay_ps >= plat->variant->rgmii_delay_max) {
+			dev_err(plat->dev, "Invalid RGMII TX clock delay: %dps\n",
+				rgmii_tx_delay_ps);
 			return -EINVAL;
 		}
+	} else {
+		/*
+		 * standard property value not available, fallback on vendor
+		 * value instead and cap it to max RGMII delay value
+		 */
+		rgmii_tx_delay_ps = min(tx_delay_ps,
+					plat->variant->rgmii_delay_max);
 	}
 
-	if (!of_property_read_u32(plat->np, "mediatek,rx-delay-ps", &rx_delay_ps)) {
-		if (rx_delay_ps < plat->variant->rx_delay_max) {
-			mac_delay->rx_delay = rx_delay_ps;
-		} else {
-			dev_err(plat->dev, "Invalid RX clock delay: %dps\n", rx_delay_ps);
+	of_property_read_u32(plat->np, "mediatek,rx-delay-ps", &rx_delay_ps);
+	if (rx_delay_ps >= plat->variant->mii_delay_max) {
+		dev_err(plat->dev, "Invalid RX clock delay: %dps\n",
+			rx_delay_ps);
+		return -EINVAL;
+	}
+
+	/* Read RGMII RX internal delay standard property */
+	if (!of_property_read_u32(plat->np, "rx-internal-delay-ps",
+				  &rgmii_rx_delay_ps)) {
+		if (rgmii_rx_delay_ps >= plat->variant->rgmii_delay_max) {
+			dev_err(plat->dev, "Invalid RGMII RX clock delay: %dps\n",
+				rgmii_rx_delay_ps);
 			return -EINVAL;
 		}
+	} else {
+		/*
+		 * standard property value not available, fallback on vendor
+		 * value instead and cap it to max RGMII delay value
+		 */
+		rgmii_rx_delay_ps = min(rx_delay_ps,
+					plat->variant->rgmii_delay_max);
 	}
 
+	mac_delay->rx_delay = rx_delay_ps;
+	mac_delay->tx_delay = tx_delay_ps;
+	mac_delay->rgmii_rx_delay = rgmii_rx_delay_ps;
+	mac_delay->rgmii_tx_delay = rgmii_tx_delay_ps;
 	mac_delay->tx_inv = of_property_read_bool(plat->np, "mediatek,txc-inverse");
 	mac_delay->rx_inv = of_property_read_bool(plat->np, "mediatek,rxc-inverse");
 	plat->rmii_rxc = of_property_read_bool(plat->np, "mediatek,rmii-rxc");

-- 
2.56.0

