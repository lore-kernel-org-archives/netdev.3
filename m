Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB68432E76;
	Thu, 24 Sep 2026 07:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234669; cv=none; b=QhUtSC1WXATvwv1ux/XHJPU4wZbky72ZvVQGx05OmIEu0+UNoO7HfMsH4kufcAqxmF5coRCCf4iY0z5agvO14JRLsBSJrHUfw7AMXinfXwqG9+xy6msOsdH7fPb0vx+W4x4yBevtHkUoTaeL4aQaPJQUXFzVZd9an0Ulg6d2bVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234669; c=relaxed/simple;
	bh=Y/liZ6Nd49xG0Z70hXow1cO9D1/xUcVpQPjdNHMxRGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pun5HK2IV6SeLPn1GhrXKz0T1MxFKTGWYcCfS7ookNPO7EW9YAnxnBSL2nLI0YNoT8nWDd7h57a4NQKdcstSB64XJBaK79MU1usdnThpjgP23lGcqc+3OfiSuWwh6MAWWk+GN5wiRyAT9DwMX/HuDzWRb5PNpZeSI+luSXpogVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KZMzaAr3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KZMzaAr3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234659;
	bh=Y/liZ6Nd49xG0Z70hXow1cO9D1/xUcVpQPjdNHMxRGI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KZMzaAr3OM/u9AaOR+Owqsi4v+jNGeH9WhXUqhADMJ0YbS4zNFxM1MI2SP/WQsEg4
	 cmZwYxMsRyDsQ/KZVzcNG3BqTCnM7bBhH2g8mbg/u9/3TEo0oXKpI9fgQ0vO6CQO0Q
	 8FIUCbJYIDiUQW/KkHNQkn+QFAkWfWy6OxMmXFH2yX5qUuKzz5SxLwJXCZjG7lV2fn
	 GgMcdyk7v5C4u83Jtqn+b0s5E51sMlzdYjXnFUmvj2DncXVnOayinni6CGEsB/nTW6
	 hD0LWDApDiv+DrbwqXpRcSdAoz2oTt9uO2bdjAZ9wm3xIz/FVSyK6l+3WD7BI6tRUx
	 B47jm0OcsbBuQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 60E9817E12B9;
	Thu, 24 Sep 2026 09:24:18 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 09:23:29 +0200
Subject: [PATCH net-next v2 6/7] net: stmmac: mediatek: add support for TX
 clock output enable feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-6-430bd74d5ef9@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=1623;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Y/liZ6Nd49xG0Z70hXow1cO9D1/xUcVpQPjdNHMxRGI=;
 b=i7c2i/75Fv9QVQvvay9feNu2kMA1up3QEFsBKmL9t3UVWxV10uQRa9y95XntFEaUvvym/H3gK
 e+8au2p88VuA2betdGitOBTrbc7EJ9TRoSvmCQgbQHPUheRP1JJ6EeF
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The MT8189 SoC has in the Ethernet control 0 register from the
peripheral configuration (pericfg) an additional bit to enable the TX
clock signal output.

In preparation of MT8189 SoC support, add its definition, use in the
mt8195_set_interface callback, and a support flag in the platform
data.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 6123efbbaf02..36599dc33b14 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -36,6 +36,9 @@
 #define ETH_FINE_DLY_GTXC	BIT(1)
 #define ETH_FINE_DLY_RXC	BIT(0)
 
+/* Peri Configuration register for mt8189 */
+#define MT8189_CTRL0_TXC_OUT_OP_EN	BIT(20)
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
 
@@ -109,6 +112,7 @@ struct mediatek_dwmac_variant {
 	u16 rx_delay_stage_div;
 	u16 tx_delay_stage_div;
 	u8 dma_bit_mask;
+	bool mac_txclk_out_en;
 };
 
 /* list of clocks required for mac */
@@ -302,6 +306,9 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 	/* MT8195 only support external PHY */
 	intf_val |= MT8195_EXT_PHY_MODE;
 
+	if (plat->variant->mac_txclk_out_en)
+		intf_val |= MT8189_CTRL0_TXC_OUT_OP_EN;
+
 	regmap_write(plat->peri_regmap,
 		     reg_offset + MT8195_PERI_ETH_CTRL0,
 		     intf_val);

-- 
2.55.0

