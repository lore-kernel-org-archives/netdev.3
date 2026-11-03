Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700768;
	b=Wvr73Y5eUgw9bqZ2XoHiHtAOxrhihy2rRsbDZX4LoinrAvgOI8O4cPieGPGUxsbr9Xeq
	 l9crl98fm8tj7RlKNkX95HeLdw/iLd1+RF4xOVR9Ys2ng3VWG5InYTcztVvblPpMawOAi
	 Ttc6s3lCNRSJ7hYYHYdcaip8Vrpxqrv95JKHI4pAgl1jeozQuL7whqIMFSVUR7SineyCA
	 VMXagsztqo0iWyeXawuOxmLiYZqxvZVmQhCfqwzyJRNRoyyWEcmg9yxfJm4NQFIOw6q/o
	 7Y9beNKGLk64ezaT9xEcr/EcWDfMuA3MQdSvJScQNeGMzQTk8NCdBrk6tT0ZeqIigVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700768;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nrAEy6smt0Z5TrLK8FgcSUT3fhNNePtrdQvnsA7pdqU=;
	b=SEDZELavcoyMxcVMhewFpzyKsa7K5q8vePdgNoYZsUoo9mxmspEnStLkTs959RZQ5EWg
	 C8uU02kzWwnLwXoE9v5jx2sf1dgUivhgoydg/qWh4O9RPG400DlAptyjpcMRCdK0Yn1rb
	 9n95XLv+JXVsCGgw1PoK6Os5tfxHCCluMaZPK50ncuMbKDV16RlEEMR/KxzWEzvUA84U5
	 P72ZgRlAzOjvJeW2G9lw4pFIlJKvvH6LmrCC1t64vUoWPLQVXZ0rxZm8V4660/iRQwCJQ
	 CUtowMhd9unKbT4Cn7VljYasu/pmNid5kTEl/q+2i+c0VCCDO6DpZhTDgfzoNHcTKMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cPxHSwTP;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B1606EE98;
	Tue,  3 Nov 2026 10:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E4B1606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cPxHSwTP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700765;
	bh=8wtpOkK6yYbR8j5kqB7IPtqb6ARPGLkh+YqZsa4f1Q0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cPxHSwTPnC60z7cbwOt8Kn1YxuCp2Wt245KdwoprQdtB+1rY34FSgDVHVM5zz5rmj
	 hVZQupqCZTt4uLaCT68RiN548cRqJoHH/ajB6y2UFtkLKsLHio86ni2utixkXTOEfH
	 axCf+U4e7OytAtLrzJWMhOJZMonKRpLxnYJ50/tOMgalYv0PwcREqG+s+cChfy5AW3
	 A1gu6+9qRGmVM8R/J/TGaEl+SrRS3Bbj9JinImUWKYTQKQC0f/yz/YY2PljP6rtUDd
	 OnNopJP7xRLGGagRcDHX6aX9RhIzJdGYrKTcNojJxAq9vKnA6NDcnBfs10ljWw+qsd
	 MDkGCa6M3hEGQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 04F1917E0D49;
	Tue, 03 Nov 2026 11:12:44 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:14 +0100
Subject: [PATCH net-next v4 09/10] net: stmmac: mediatek: add support for
 TX clock output enable feature
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
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-9-c86c14fc50f4@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=1678;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=8wtpOkK6yYbR8j5kqB7IPtqb6ARPGLkh+YqZsa4f1Q0=;
 b=iIu/1xFgNyNCxuocXtHLWFvZ4Qweo0V3ap3h+j0y/+lfC1k9A0iWc4inLct1xpDbM5UIVI5kd
 znlPPHj6uszCXEl3PhlGQzh6XfxrbgnUp7FmZQnRlDVZpEiFfA+HGim
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
index 0426a0876956..8ee850791270 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -41,6 +41,9 @@
 #define MT2712_RGMII_DLY_STAGE_DIV	170 /* 170ps per stage */
 #define MT2712_RGMII_DELAY_MAX		5440 /* 32 x 170ps */
 
+/* Peri Configuration register for mt8189 */
+#define MT8189_CTRL0_TXC_OUT_OP_EN	BIT(20)
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
 
@@ -113,6 +116,7 @@ struct mediatek_dwmac_variant {
 	u16 rgmii_delay_stage_div;
 	u32 peri_eth_ctrl_offset;
 	u8 dma_bit_mask;
+	bool mac_txclk_out_en;
 };
 
 /* list of clocks required for mac */
@@ -307,6 +311,9 @@ static int mt8195_set_interface(struct mediatek_dwmac_plat_data *plat,
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

