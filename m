Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57232A3FD;
	Tue,  7 Jul 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412506; cv=none; b=sq/jt1qFKLvq0CBJEDLS9TDVw4p+oJzQTEvr7ClLQEA2rBpWyMvlaOHM9WTqcKXcoLk2f/Le1LbiYHzz0LrYRKytQNY08pOv87cd+25Q2BsH70FgOLDQrSmiTOcMn2Nvdd4Iu2NunO/vGcC4g+KjVV3s3YS3lNpIonIoTW2jy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412506; c=relaxed/simple;
	bh=1S2PC2ZLIuvA/r0um/lhvN+IUZnMiBgFQzkUSbVwxN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEEcLWarI3j4CWc5yrResUR33n9iaVKYiGddpNYaZVAM2hHfFIRQ8WO24bv9XSGtxKYYijgUHwgYGLiHyjyyxxYCNxxkrJsDI58300YjaJkV3OSk8aSKVlCmuAHh2pHi8o0mr7wGQGcc+S2pEH7MqKnXN5FbDritZ1WYpa2m3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=agtY5X5x; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="agtY5X5x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783412500;
	bh=1S2PC2ZLIuvA/r0um/lhvN+IUZnMiBgFQzkUSbVwxN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=agtY5X5xEQtF78WRfmp7bHe2o9awgJ25DwnYgD3FwnlYtdNdV4FD0pwmhF9NKSNZC
	 2CQX6kEHh22UmpBDTEE3ImjcUgzAoCDadSsNrKM1YSZn2HlKby8HXG25Dv+x5zZMrb
	 /Zq9HMe16h1Q0AGwC/3/UyhLQ9f6DDV+9WEU06f6aRPluTKgfw2MrRf7yv9mQMMYGH
	 8R+eBhhSfoxdIyasDmRAKXAOQYKIk2mFqtFmx5MOis0UD2HGfTf3vIQjU2mE768aUT
	 Ge36P4VI/Q7Mip2/vP4YYrYsIN/HzFfEW+NnxmLnYOkVvdfbgV4h4G8U2e4dtva8Y0
	 A78h2nR06dkJg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0593A17E0EF3;
	Tue, 07 Jul 2026 10:21:38 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 07 Jul 2026 10:21:22 +0200
Subject: [PATCH net-next 4/6] net: stmmac: mediatek: add support for TX
 clock output enable feature
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dwmac-mediatek-mt8189-v1-4-17f345eaaca3@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783412493; l=1599;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=1S2PC2ZLIuvA/r0um/lhvN+IUZnMiBgFQzkUSbVwxN0=;
 b=i1maYnpQSwrf17oYxI252hcugYFWQR+uo8DbLe8uGn7ivo43UnoIg5RSf6Vo73m/8j/p8vFNw
 ZoI41pGL4K/BPeMB3PqozJ/2xnKNtTnCqc9oRsiYtURUQ+pioy3KkDa
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The MT8189 SoC has in the Ethernet control 0 register from the
peripheral configuration (pericfg) an additional bit to enable the TX
clock signal output.

In preparation of MT8189 SoC support, add its definition, use in the
set_phy_interface_v2 callback, and a support flag in the platform
data.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 28e87990b0a1..bcc0baef3f71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -36,6 +36,9 @@
 #define ETH_FINE_DLY_GTXC	BIT(1)
 #define ETH_FINE_DLY_RXC	BIT(0)
 
+/* Peri Configuration register for mt8189 */
+#define MT8189_CTRL0_TXC_OUT_OP		BIT(20)
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_BASE	0xFD0
 
@@ -99,6 +102,7 @@ struct mediatek_dwmac_variant {
 	u32 tx_delay_max;
 	u32 peri_eth_ctrl_offset;
 	u8 dma_bit_mask;
+	bool use_out_op;
 };
 
 /* list of clocks required for mac */
@@ -292,6 +296,9 @@ static int set_phy_interface_v2(struct mediatek_dwmac_plat_data *plat,
 	/* MT8195 only support external PHY */
 	intf_val |= MT8195_EXT_PHY_MODE;
 
+	if (plat->variant->use_out_op)
+		intf_val |= MT8189_CTRL0_TXC_OUT_OP;
+
 	regmap_write(plat->peri_regmap,
 		     reg_offset + MT8195_PERI_ETH_CTRL0,
 		     intf_val);

-- 
2.55.0

