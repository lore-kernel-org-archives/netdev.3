Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6548123E;
	Fri, 16 Oct 2026 10:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146729; cv=none; b=QNB2SR+I24nAtfFDoY+kau167ZAI/F5aWwMK4HO/X7nO8kztEY20ZrcZdyvIaHqIcS8Y7ny0iq5vYKUIbiSHaE6o5bOaT9CSJHcr4zzcscvMMB84ROaNNeXUdpCyUJY7MPCQ9mOH4iS0AP5wcYV+7D7g8fBprDuLTh+4NzxG0IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146729; c=relaxed/simple;
	bh=CFQwDm8eQ75u4g96g4zYZYElLaE9tj7lH3fV9uMhw9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NeBiSClQbggO98Hz7r+KSjotkPohTJf1WGCn8fCvXI2lHzFBwaRAbJ2CZEXy2SQ5ZkbBt3UedQAondStQwETyfHudM1rd9VOsXHBmcR8hWSOPDn9B528owZpLxG30JvEYaz4D46yfLSk276JEKmeZuxdYXf7KW0lAYZf17E8fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CBTSvX63; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CBTSvX63"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792146726;
	bh=CFQwDm8eQ75u4g96g4zYZYElLaE9tj7lH3fV9uMhw9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CBTSvX63e21VSH5L735f9dNFD6B1vLPFXfBBzLLsAAvnPhtj5fAAkUoNPZkb4FDFT
	 mY8YNlscuffkXZRpWyJLyPEa4Qde1Vy/6Se7uXcW+kpu3JOacC7IrhRF1bXwGvPNFO
	 pg8mG22xEj4ihw2FUfFVe0GZhS7Mpdcbj9tcXH9ETMvqIXBalrCIEphOuw2C7ZO64m
	 UCthVt9acQ9dkTA0BBjhpZBHBCAGFG0F0X9DPzoBvi38Gshe7KHWuuatBWLcu87KZA
	 XjRZVh72E/Fh1StScqBLi6nA//4XEz5omi2PFiLWBx88BPqeBZCM6NYYkQqjAGoYii
	 qElpskD0nbiPA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 399DC17E0C39;
	Fri, 16 Oct 2026 12:32:05 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 16 Oct 2026 12:31:12 +0200
Subject: [PATCH net-next v3 8/9] net: stmmac: mediatek: add support for TX
 clock output enable feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-dwmac-mediatek-mt8189-v3-8-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146716; l=1691;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=CFQwDm8eQ75u4g96g4zYZYElLaE9tj7lH3fV9uMhw9g=;
 b=pZi/hzqMDk8iLVaUaF3gyMVd4sWEV0Xsr628AyZJ1lynke2jMs0tOMpInXyf3qicIFRcwy5yn
 nZR/WTEq7CgD7+2I9fsiZCgeFF15QOIpJ83LP454VqvMZTMNYUhCM/L
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
index 4b2d5280f703..147e217b8662 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -44,6 +44,9 @@
 #define MT2712_RGMII_DLY_TXC_STAGE_DIV	550 /* 550ps per stage */
 #define MT2712_RGMII_DLY_TXC_MAX	17600 /* 32 x 550ps */
 
+/* Peri Configuration register for mt8189 */
+#define MT8189_CTRL0_TXC_OUT_OP_EN	BIT(20)
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
 
@@ -119,6 +122,7 @@ struct mediatek_dwmac_variant {
 	u16 rx_rgmii_delay_stage_div;
 	u16 tx_rgmii_delay_stage_div;
 	u8 dma_bit_mask;
+	bool mac_txclk_out_en;
 };
 
 /* list of clocks required for mac */
@@ -299,6 +303,9 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
 	/* MT8195 only support external PHY */
 	intf_val |= MT8195_EXT_PHY_MODE;
 
+	if (plat->variant->mac_txclk_out_en)
+		intf_val |= MT8189_CTRL0_TXC_OUT_OP_EN;
+
 	regmap_write(plat->peri_regmap,
 		     reg_offset + MT8195_PERI_ETH_CTRL0,
 		     intf_val);

-- 
2.56.0

