Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79374425892;
	Thu, 24 Sep 2026 07:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234666; cv=none; b=eI3KyRwlaaJ+pUsfDGYUr5mP94DdW4f/xoIr6xufaIPO5/iUte84FONtlW4svHVH3hzEBf0rydPqrctVkgUqbwCWbaTGGrQJQylgrBktwFh0Qq/bLA25gL1JuqxVfxLzjMp/4cmPF1Ge8UjMzfP7j075PryUAwOTrb+O5irJu+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234666; c=relaxed/simple;
	bh=DC2WPwwkSxFustL2AbY2SiFK+Z5ORnQdoEps56Vo9Cc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pLJKysxAKtHKH5B77kcykHTEEKfcFlJ7ekASfnvBuRyTxCY4QqHgtCkp3a/uCua1YMNmFY6T81JtdUgJLxZs6+KADK46yUZRbN+YHNPIAKvElAjokKn7ZPpsBPylJljAYWheyAK1oRxJpGMQsvOQZLP9kF55yKLQUY6H/JzL+j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i92at4JQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i92at4JQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234657;
	bh=DC2WPwwkSxFustL2AbY2SiFK+Z5ORnQdoEps56Vo9Cc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i92at4JQCMUTo+fo8sPRk3H59D25++MD114jyQ2yILG1pFBbetvYW2oQSgxsgVbSf
	 B+764In581JPDIPAsowyfRiFTzSb8SPM3TwpHwFgLKjKRc35FL5KtKhU+DKqh01mYD
	 y1bbXxe7b6VtfnahnclLDOVyzrY4pluZazbiCCaOnWKJUb0UJS97k6w0Ebf7th38hp
	 xgRL2hv8mAoBhRAsxH4jLsxMmkBNgxf5QwFVUzLm9khwsAryJlNRDYs7bE0RDvGfQ3
	 Kc1Bijjo4lelEp4K5pMCIrRBdsz2bhaBx5BEcmSoUwkn5ibLSFK03xllwZ3/oTm6R/
	 91dSNMCLvdC1Q==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9EEA117E0B0F;
	Thu, 24 Sep 2026 09:24:16 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 09:23:27 +0200
Subject: [PATCH net-next v2 4/7] net: stmmac: mediatek: add PERI_ETH_CTRLx
 register offset in platform data
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-4-430bd74d5ef9@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=4264;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=DC2WPwwkSxFustL2AbY2SiFK+Z5ORnQdoEps56Vo9Cc=;
 b=uPDzdeapfq0daB0ImCHaKn26bU/bjTDUreJt1AlvlI/8INj/0jNdftzQ2JQK8LRqUc8RQhPJR
 AZSx2jkQyRXBbmilPgvazpF42swCx3pC8vN9CLq+jPH8jZ8f5DW8dBH
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
index 1c532cc3a975..dee12cfa437d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -37,7 +37,9 @@
 #define ETH_FINE_DLY_RXC	BIT(0)
 
 /* Peri Configuration register for mt8195 */
-#define MT8195_PERI_ETH_CTRL0		0xFD0
+#define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
+
+#define MT8195_PERI_ETH_CTRL0		0x0
 #define MT8195_RMII_CLK_SRC_INTERNAL	BIT(28)
 #define MT8195_RMII_CLK_SRC_RXC		BIT(27)
 #define MT8195_ETH_INTF_SEL		GENMASK(26, 24)
@@ -47,7 +49,7 @@
 #define MT8195_DLY_GTXC_ENABLE		BIT(5)
 #define MT8195_DLY_GTXC_STAGES		GENMASK(4, 0)
 
-#define MT8195_PERI_ETH_CTRL1		0xFD4
+#define MT8195_PERI_ETH_CTRL1		0x4
 #define MT8195_DLY_RXC_INV		BIT(25)
 #define MT8195_DLY_RXC_ENABLE		BIT(18)
 #define MT8195_DLY_RXC_STAGES		GENMASK(17, 13)
@@ -55,7 +57,7 @@
 #define MT8195_DLY_TXC_ENABLE		BIT(5)
 #define MT8195_DLY_TXC_STAGES		GENMASK(4, 0)
 
-#define MT8195_PERI_ETH_CTRL2		0xFD8
+#define MT8195_PERI_ETH_CTRL2		0x8
 #define MT8195_DLY_RMII_RXC_INV		BIT(25)
 #define MT8195_DLY_RMII_RXC_ENABLE	BIT(18)
 #define MT8195_DLY_RMII_RXC_STAGES	GENMASK(17, 13)
@@ -98,6 +100,7 @@ struct mediatek_dwmac_variant {
 	const char * const *clk_list;
 	int num_clks;
 
+	u32 peri_eth_ctrl_offset;
 	u32 rx_delay_max;
 	u32 tx_delay_max;
 	u16 rx_delay_stage_div;
@@ -284,6 +287,7 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 				u8 phy_intf_sel)
 {
 	u32 intf_val = FIELD_PREP(MT8195_ETH_INTF_SEL, phy_intf_sel);
+	u32 reg_offset = plat->variant->peri_eth_ctrl_offset;
 
 	if (phy_intf_sel == PHY_INTF_SEL_RMII) {
 		if (plat->rmii_clk_from_mac)
@@ -295,7 +299,9 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 	/* MT8195 only support external PHY */
 	intf_val |= MT8195_EXT_PHY_MODE;
 
-	regmap_write(plat->peri_regmap, MT8195_PERI_ETH_CTRL0, intf_val);
+	regmap_write(plat->peri_regmap,
+		     reg_offset + MT8195_PERI_ETH_CTRL0,
+		     intf_val);
 
 	return 0;
 }
@@ -305,6 +311,7 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	u16 rx_delay_stage_div = plat->variant->rx_delay_stage_div;
 	u16 tx_delay_stage_div = plat->variant->tx_delay_stage_div;
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
+	u32 reg_offset = plat->variant->peri_eth_ctrl_offset;
 	u32 rx_delay_stage_val;
 	u32 tx_delay_stage_val;
 	u32 gtxc_delay_val = 0;
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
 	.rx_delay_stage_div = MT8195_DLY_RXC_STAGE_DIV,
 	.tx_delay_stage_div = MT8195_DLY_TXC_STAGE_DIV,
 	.dma_bit_mask = 35,
+	.peri_eth_ctrl_offset = MT8195_PERI_ETH_CTRL_OFFSET,
 };
 
 static int mediatek_dwmac_config_dt(struct mediatek_dwmac_plat_data *plat)

-- 
2.55.0

