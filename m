Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316E4349AF;
	Thu, 24 Sep 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234669; cv=none; b=Ku6JptqGl1XGt84xU1Dlso1I+8mhw/iUmorSr8gxnbv0W8y3znh1Ms0mbC4hVt0uadXJdYNX+6IjsnolEMP6+oRJv2r7Eg+sioBV0DISu4xOGEzMB8LO0jtKZ7HQ18A4imeMM0TepweapdXu4geJG+4FX+uSDkzXNj5d6DAU6vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234669; c=relaxed/simple;
	bh=/qugFssfEeT+3qD+5/NT5i6m9cPExsSU0aakzvtTvuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R8H5e3X5DtnMmM3RR5tSNU2ZV3s/Ys+JFZLnVij4Gnrs3M9kLVvWX2OsPLnD5+wOznYyc2fmDcKjp9OLqyaFCSAyPiPCZ84iA5ZQClR4We7h3ouhwqzbMvB1x5JlviKbe+4ZKmn0WKM/q3uZS1yOEeRiUbR/rmmHCd6eh2Y4nX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f+Gg0n7i; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f+Gg0n7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234658;
	bh=/qugFssfEeT+3qD+5/NT5i6m9cPExsSU0aakzvtTvuo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f+Gg0n7iAqOojpV5PUajQMHomRqSjrBU0OqUTv1V2tXIFI6UpzcjB5ClCzM03L38P
	 qjHFS2bfkaAJsKHeq6744WI/tl2vjzg5KAolPCWfuzewX009jPD24e6MP+aBy+IgCU
	 7xlw/sT89Pm41ORX5lhKqsoWuBnCR0EwY14UYXmHHOu+v/rQ13Ys94EHbIoUsTekr/
	 A6f+jR8n+Jae0jTTBws1/zskOHfEzJdky2XrZD6902XUej5G1C1j23ONfHKdVslOR9
	 34K1BSLI973NELnVAT8tcM6BT+TWm4dAOoosRad/bz/7S2aCHhS/+DJ0XurPY0GHya
	 piA+vM2219Trg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 80E4C17E0FBB;
	Thu, 24 Sep 2026 09:24:17 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 09:23:28 +0200
Subject: [PATCH net-next v2 5/7] net: stmmac: mediatek: use TX clock phase
 shift in RGMII mode with 1Gbps speed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-5-430bd74d5ef9@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=5129;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=/qugFssfEeT+3qD+5/NT5i6m9cPExsSU0aakzvtTvuo=;
 b=5dgREcK+FGftRfBysOjtCruh4RbIuUCC2+equHJFKZt5kbB7dyd9U85+jfIgt6sRXMwXEtL9J
 87OjTY/0HcFB75S5ehg8P3vaUxitw3ugsgnJLTJBXjGkOJBjnxpOyUH
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Currently, if the devicetree of a board based on MT8195 (or compatible)
configures the use of RGMII PHY mode and insert at MAC level additional
delay on TX clock at MAC (with "mediatek,tx-delay-ps" vendor property
presence), the driver inserts this delay by setting TX coarse delay
bits (bit 0 to 5) of the Ethernet control 0 register from the
peripheral configuration (pericfg) at probe time.

The HW delay macro circuit, that these bits enable, can be affected by
external factors such as environment temperature or vcore voltage and
thus applied delay value can change. For 10/100M link speed cases the
variations are not problematic, but it can be for 1G link speed cases,
that require much precise and stable timings (around 2ns).

The Ethernet control 0 register of MT8195 SoC has another bit (bit 22:
MT8195_RGMII_TXC_PHASE_CTR) to enable the TX clock phase shift and
insert a 2ns clock delay in a more consistence way, as it is not
affected like the HW delay macro circuit under the same conditions.
This only works though for 1G speed cases so it cannot be set
unconditionally at probe time, thus needs to be set after link speed
negotiation.

In order to allow the TX clock phase shift use in the driver, add in
the variant platform data and probe sequence the support of
fix_mac_speed callback, provided by dwmac core. This callback allows
driver configuration update when the link speed has been negotiated.
Implement it for MT8195 so that, when a delay needs to be inserted
for TX clock (due to the devicetree configuration), it enables the
TX clock phase shift in Ethernet control 0 register only and only if
the PHY mode allows it and negotiated link speed is 1G, and fallback
to the HW delay macro circuit otherwise.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index dee12cfa437d..6123efbbaf02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -96,6 +96,9 @@ struct mediatek_dwmac_variant {
 				       u8 phy_intf_sel);
 	int (*dwmac_set_delay)(struct mediatek_dwmac_plat_data *plat);
 
+	void (*dwmac_fix_mac_speed)(void *priv, phy_interface_t interface,
+				    int speed, unsigned int mode);
+
 	/* clock ids to be requested */
 	const char * const *clk_list;
 	int num_clks;
@@ -433,9 +436,62 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	return 0;
 }
 
+static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
+				 int speed, unsigned int mode)
+{
+	struct mediatek_dwmac_plat_data *priv_plat = priv;
+	const struct mediatek_dwmac_variant *variant;
+	struct mac_delay_struct *mac_delay;
+	u32 tx_delay_stage_val, reg_offset;
+	u32 reg_val = 0;
+
+	if (!priv_plat)
+		return;
+
+	mac_delay = &priv_plat->mac_delay;
+	variant = priv_plat->variant;
+
+	if (!mac_delay->tx_delay ||
+	    (interface != PHY_INTERFACE_MODE_RGMII &&
+	     interface != PHY_INTERFACE_MODE_RGMII_RXID))
+		return;
+
+	/*
+	 * When link speed is 1Gbps with RGMII interface, and a TX internal
+	 * delay needs to be applied on MAC, prefer to override the delay
+	 * settings with a 2ns fixed delay which is controlled by
+	 * RGMII_TXC_PHASE_CTRL. Otherwise, fallback to HW delay macro circuit
+	 * for 10/100Mbps link speeds.
+	 */
+	if (speed == SPEED_1000) {
+		reg_val = MT8195_RGMII_TXC_PHASE_CTRL;
+	} else {
+		if (variant->tx_delay_stage_div)
+			tx_delay_stage_val = mac_delay->tx_delay /
+					     variant->tx_delay_stage_div;
+
+		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_ENABLE,
+				      !!mac_delay->tx_delay);
+		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_STAGES,
+				      tx_delay_stage_val);
+		reg_val |= FIELD_PREP(MT8195_DLY_GTXC_INV,
+				      mac_delay->tx_inv);
+	}
+
+	reg_offset = variant->peri_eth_ctrl_offset + MT8195_PERI_ETH_CTRL0;
+	regmap_update_bits(priv_plat->peri_regmap,
+			   reg_offset,
+			   MT8195_RGMII_TXC_PHASE_CTRL |
+			   MT8195_DLY_GTXC_ENABLE |
+			   MT8195_DLY_GTXC_INV |
+			   MT8195_DLY_GTXC_STAGES,
+			   reg_val);
+}
+
 static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_phy_interface = mt8195_set_interface,
 	.dwmac_set_delay = mt8195_set_delay,
+	.dwmac_fix_mac_speed = mt8195_fix_mac_speed,
 	.clk_list = mt8195_dwmac_clk_l,
 	.num_clks = ARRAY_SIZE(mt8195_dwmac_clk_l),
 	.rx_delay_max = MT8195_DLY_RXC_MAX,
@@ -594,6 +650,9 @@ static int mediatek_dwmac_common_data(struct platform_device *pdev,
 	plat->resume = mediatek_dwmac_init;
 	plat->clks_config = mediatek_dwmac_clks_config;
 
+	if (priv_plat->variant->dwmac_fix_mac_speed)
+		plat->fix_mac_speed = priv_plat->variant->dwmac_fix_mac_speed;
+
 	plat->safety_feat_cfg = devm_kzalloc(&pdev->dev,
 					     sizeof(*plat->safety_feat_cfg),
 					     GFP_KERNEL);

-- 
2.55.0

