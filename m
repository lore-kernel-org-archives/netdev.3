Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1259631716E;
	Tue,  7 Jul 2026 08:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412507; cv=none; b=ZzMovGUbrsMOPRUkL7KINPn4M3tacsIBS8gkwfkDR6b9bM7UxKyKunmMiaQL8QtXBa/zH3X+hlRauRsUIYhkUkHWQuCXVtMjAqq2kVE5yRm4Gh9/2jPNETyy+/sSTNyR5iW//vqy51LRANugkiS+G7btIoaeQLtjiyl6oMOMIsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412507; c=relaxed/simple;
	bh=KLoyhladejZwag7Oc8NASnTdTZWyep443gM8lpfjMck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XPCsv7xkkbpoOKamrwX9irQeKB4GbpEFlX0tezhwq4br2Z1b3ihQpRk3rdvHe4oUgsj4T+Lx8AZJEyuzBk1VfQ+9w+0eX/qHm/QOEECDidhq+5hC/lH9btDU6c4uwvkOcbhY6zMhIpGo+g6De+j4CORqoAZFsEJk7P67LU7kMj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZihbO5xu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZihbO5xu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783412501;
	bh=KLoyhladejZwag7Oc8NASnTdTZWyep443gM8lpfjMck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZihbO5xuWnROe/iFMijiFg5AjBA6+EHIH98vWSA/uGkwwcBxz+ewy2BZDHac9uAMs
	 9LT0BUKmMU+2554CstLQnCo9B7g9VPk/JN6YSwA5BVC8D9wLWEPvZruLGOmsRRorxH
	 DlMunPqiuHl7OdWU9s/I9NiSV0CNRYTQRqRp4QQ+SHNY2VF9Y/cnTJRY3XfGTsa2FD
	 8FhZNg0mjmQ0etpb9A8uAz/IsJV96Fu9kY+baUo2wT8GCO6isDOSOe9KT6Rpg8L7io
	 x3ivOZ67/M2ErE0ot3s73aIX5Lc3rPdNJxmj4NgZqGWBR/Jjte7PRItjXpKgVEAhJz
	 gBOMV97e0lafw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5A4B317E0FD0;
	Tue, 07 Jul 2026 10:21:40 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 07 Jul 2026 10:21:23 +0200
Subject: [PATCH net-next 5/6] net: stmmac: mediatek: add support for TX
 deallocation adjustment feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dwmac-mediatek-mt8189-v1-5-17f345eaaca3@collabora.com>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk, 
 kernel@collabora.com, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783412493; l=3068;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=KLoyhladejZwag7Oc8NASnTdTZWyep443gM8lpfjMck=;
 b=rYDH1k4qqZavWOEuPdvowUc/+WZvhIhsF7JkDbjG/He606di+QhEkFX8U4MRI7ZTScJ3JTE1m
 TvJs9RvLmHUBfzahx6b4AyEUmD4/uTI3RRcUyL6RNmbW1pWOovvYZiq
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The MT8189 SoC has in the Ethernet control 0 register from the
peripheral configuration (pericfg) additional bits to adjust the TX
deallocation.

In preparation of MT8189 SoC support, add its definition, use in the
set_delay_v2 callback, and a support flag in the platform data.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 25 ++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index bcc0baef3f71..6b0a42b5839f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -37,7 +37,8 @@
 #define ETH_FINE_DLY_RXC	BIT(0)
 
 /* Peri Configuration register for mt8189 */
-#define MT8189_CTRL0_TXC_OUT_OP		BIT(20)
+#define MT8189_CTRL0_TXC_OUT_OP			BIT(20)
+#define MT8189_CTRL0_DLY_GTXC_STAGE_FINE	GENMASK(11, 6)
 
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_BASE	0xFD0
@@ -103,6 +104,7 @@ struct mediatek_dwmac_variant {
 	u32 peri_eth_ctrl_offset;
 	u8 dma_bit_mask;
 	bool use_out_op;
+	bool use_stage_fine;
 };
 
 /* list of clocks required for mac */
@@ -326,9 +328,12 @@ static void delay_stage2ps_v2(struct mediatek_dwmac_plat_data *plat)
 
 static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 {
-	u32 gtxc_delay_val = 0, delay_val = 0, rmii_delay_val = 0;
 	struct mac_delay_struct *mac_delay = &plat->mac_delay;
 	u32 reg_offset = plat->variant->peri_eth_ctrl_offset;
+	u32 gtxc_delay_mask = 0;
+	u32 gtxc_delay_val = 0;
+	u32 rmii_delay_val = 0;
+	u32 delay_val = 0;
 
 	delay_ps2stage_v2(plat);
 
@@ -402,6 +407,9 @@ static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES, mac_delay->tx_delay);
 		gtxc_delay_val |= FIELD_PREP(MT8195_DLY_GTXC_INV, mac_delay->tx_inv);
 
+		if (plat->variant->use_stage_fine)
+			gtxc_delay_val |= MT8189_CTRL0_DLY_GTXC_STAGE_FINE;
+
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_ENABLE, !!mac_delay->rx_delay);
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_STAGES, mac_delay->rx_delay);
 		delay_val |= FIELD_PREP(MT8195_DLY_RXC_INV, mac_delay->rx_inv);
@@ -412,12 +420,17 @@ static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 		return -EINVAL;
 	}
 
+	gtxc_delay_mask = MT8195_RGMII_TXC_PHASE_CTRL |
+			  MT8195_DLY_GTXC_INV |
+			  MT8195_DLY_GTXC_ENABLE |
+			  MT8195_DLY_GTXC_STAGES;
+
+	if (plat->variant->use_stage_fine)
+		gtxc_delay_mask |= MT8189_CTRL0_DLY_GTXC_STAGE_FINE;
+
 	regmap_update_bits(plat->peri_regmap,
 			   reg_offset + MT8195_PERI_ETH_CTRL0,
-			   MT8195_RGMII_TXC_PHASE_CTRL |
-			   MT8195_DLY_GTXC_INV |
-			   MT8195_DLY_GTXC_ENABLE |
-			   MT8195_DLY_GTXC_STAGES,
+			   gtxc_delay_mask,
 			   gtxc_delay_val);
 	regmap_write(plat->peri_regmap,
 		     reg_offset + MT8195_PERI_ETH_CTRL1,

-- 
2.55.0

