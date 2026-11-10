Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312549;
	b=Pa83/ZaPhU/P+uWVPZyfGopP3LFkeHoYDbSFqcEVOWGLah6gCarJ/GAPy/G/7hZctEdt
	 OO/TSZz6yxOqRhmR27dkFbON9tVKkPNNJGaauh4KVHEXkUrQ4DLvYtl6cbSTnhaDkiaYA
	 cQX3m+0a4rZdvzXwHksw+iRLFLXS3nPq3qajWG3ctlybvnn4y5fwtBmdp/D1IX4MrSzKl
	 xc9hPKeFUhpWiDPW7O2hgIsz/T//ATwt4YDch88Ez2ujYIglQRRCr4l2Sw/eHiNhHf9rz
	 SGj+pE+k6tzmh/eNL6iNj1YpZB5OByszTFfVsJ9e8XXmyVKR397XkgllUiEAS6ZuSUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312549;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5Wp13Kx4ys2DJ+gjN3mADhnA4GnIuOyjiR/GFaUAo0E=;
	b=doo+brak0devNtz1f+f7L5lZyVaIVfdW5EbLJRuyp1+z5ga5zuVA5pGTY2y57IrYazDT
	 nQlhCLPV51xit8NSs5H0Sk99Wg2+OWNsgiVKahrpul382EWrF3unkaF7zP2BWf6/6TVql
	 twZfRfQABP+Eq2Hj0TGbf9xTl+K6wX5uyOxGhKov3arydAy0ruONGCrVww7DwLMXqwp+p
	 Yfs4EpV59ZeaX7CWNFgYo2L/bBsZAXqCHsYeQxFRdHQAA6etsOnB1LPAIrJzwArl0syv4
	 MDW/e4CuDsIs0YjXP9hUw3Jr0B358o5GT9nhd6umeQDUewsYhii6nTu9rAvRZJvEmTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=H1dqken8;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BC606D50D;
	Tue, 10 Nov 2026 12:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 108BC606D50D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=H1dqken8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312547;
	bh=f+ASPiMrzJyLPJEuk2lYXThaX/2+d8PJzjNk/hF3Gbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=H1dqken8pPy4LwfhtFdfEBk6q2pwPldZC4xXXwP/MTJjspo6MbKvO+AjVnBHxQmBr
	 shPePYV34cqaNH6S1V4SsrKeEdliZAHPeIygUDkCDKMejwk1oUYeuYWlmFQTI2xVUF
	 yLP0/JEIcvn/KnOvilEYK/GkidfCxBmRh6HV6AR0PGOxYoO+ox/E+8UF7ZmuIlXsjx
	 ulndUhgL6zVPyX2y7LREzYtJlYuPltwNLDGMpjrfg4P38ByinIDh1ry9QIroFhGAj2
	 YZBTxSKy/AtqgNr19xDet22iaJvs5YiZtMBU1c4aAuQfWwgEOvrB0DVr51J6owmpVf
	 JgExM93ouQAmQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8818B17E093E;
	Tue, 10 Nov 2026 13:09:06 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:55 +0100
Subject: [PATCH net-next v5 08/10] net: stmmac: mediatek: add
 PERI_ETH_CTRLx register offset in platform data
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-8-7d99d6292962@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=4252;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=f+ASPiMrzJyLPJEuk2lYXThaX/2+d8PJzjNk/hF3Gbs=;
 b=v6UiNk3YIBJyXQmCwBLYeoqQDjjIXVvV73SckASas1m/bGdltQnrcbn5WhPp+cPJ72tqTNWEP
 rqCzCoycYiLCk8uULI5mtyG2/DGDXrP2BhkE0HUeNn+OoOSmralQa6I
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In preparation of newer SoC support, that use like MT8195 the Ethernet
control registers from the peripheral configuration syscon but at a
different base offset, add a new base offset in the variant platform
data to access the PERI_ETH_CTRLx registers and use it in implemented
methods.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 26 ++++++++++++++++------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index e39ca83c2a6f..3f024d455cbd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -42,7 +42,9 @@
 #define MT2712_RGMII_DELAY_MAX		5440 /* 32 x 170ps */
 
 /* Peri Configuration register for mt8195 */
-#define MT8195_PERI_ETH_CTRL0		0xFD0
+#define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
+
+#define MT8195_PERI_ETH_CTRL0		0x0
 #define MT8195_RMII_CLK_SRC_INTERNAL	BIT(28)
 #define MT8195_RMII_CLK_SRC_RXC		BIT(27)
 #define MT8195_ETH_INTF_SEL		GENMASK(26, 24)
@@ -52,7 +54,7 @@
 #define MT8195_DLY_GTXC_ENABLE		BIT(5)
 #define MT8195_DLY_GTXC_STAGES		GENMASK(4, 0)
 
-#define MT8195_PERI_ETH_CTRL1		0xFD4
+#define MT8195_PERI_ETH_CTRL1		0x4
 #define MT8195_DLY_RXC_INV		BIT(25)
 #define MT8195_DLY_RXC_ENABLE		BIT(18)
 #define MT8195_DLY_RXC_STAGES		GENMASK(17, 13)
@@ -60,7 +62,7 @@
 #define MT8195_DLY_TXC_ENABLE		BIT(5)
 #define MT8195_DLY_TXC_STAGES		GENMASK(4, 0)
 
-#define MT8195_PERI_ETH_CTRL2		0xFD8
+#define MT8195_PERI_ETH_CTRL2		0x8
 #define MT8195_DLY_RMII_RXC_INV		BIT(25)
 #define MT8195_DLY_RMII_RXC_ENABLE	BIT(18)
 #define MT8195_DLY_RMII_RXC_STAGES	GENMASK(17, 13)
@@ -109,6 +111,7 @@ struct mediatek_dwmac_variant {
 	u32 rgmii_delay_max;
 	u16 mii_delay_stage_div;
 	u16 rgmii_delay_stage_div;
+	u32 peri_eth_ctrl_offset;
 	u8 dma_bit_mask;
 };
 
@@ -292,6 +295,7 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 				u8 phy_intf_sel)
 {
 	u32 intf_val = FIELD_PREP(MT8195_ETH_INTF_SEL, phy_intf_sel);
+	u32 reg_offset = plat->variant->peri_eth_ctrl_offset;
 
 	if (phy_intf_sel == PHY_INTF_SEL_RMII) {
 		if (plat->rmii_clk_from_mac)
@@ -303,7 +307,9 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 	/* MT8195 only support external PHY */
 	intf_val |= MT8195_EXT_PHY_MODE;
 
-	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL0, intf_val);
+	regmap_write(plat->peri_regmap,
+		     reg_offset + MT8195_PERI_ETH_CTRL0,
+		     intf_val);
 
 	return 0;
 }
@@ -311,6 +317,7 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 {
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
+	u32 reg_offset = plat->variant->peri_eth_ctrl_offset;
 	u32 rx_delay_stage_val, tx_delay_stage_val;
 	u32 gtxc_delay_val = 0;
 	u32 rmii_delay_val = 0;
@@ -410,14 +417,18 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	}
 
 	regmap_update_bits(plat->peri_regmap,
-			   MT8195_PERI_ETH_CTRL0,
+			   reg_offset + MT8195_PERI_ETH_CTRL0,
 			   MT8195_RGMII_TXC_PHASE_CTRL |
 			   MT8195_DLY_GTXC_INV |
 			   MT8195_DLY_GTXC_ENABLE |
 			   MT8195_DLY_GTXC_STAGES,
 			   gtxc_delay_val);
-	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL1, delay_val);
-	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL2, rmii_delay_val);
+	regmap_write(plat->peri_regmap,
+		     reg_offset + MT8195_PERI_ETH_CTRL1,
+		     delay_val);
+	regmap_write(plat->peri_regmap,
+		     reg_offset + MT8195_PERI_ETH_CTRL2,
+		     rmii_delay_val);
 
 	return 0;
 }
@@ -432,6 +443,7 @@ static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.mii_delay_stage_div = MT8195_MII_DLY_STAGE_DIV,
 	.rgmii_delay_stage_div = MT8195_RGMII_DLY_STAGE_DIV,
 	.dma_bit_mask = 35,
+	.peri_eth_ctrl_offset = MT8195_PERI_ETH_CTRL_OFFSET,
 };
 
 static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)

-- 
2.56.0

