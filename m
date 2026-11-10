Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312552;
	b=zRAilBpeBWYZiegJFzfscUk5JQ/zWSiHcOnmVZKgBXjIiNAZ7hZTdWz6lGSi658cIhBA
	 khzuI3Kl4zE3Lo8wZkkXQd0pR653EDeQtqBgK/msg/oYSJw/f6mHP0//04pvtPyF3X02i
	 WdWBgFRxAtY2JXPAVX13k5zWXn9lPacZgbsCs8Jy1wq3ffV1pzu09qWoGVl82hhcQ7bOR
	 mfFlUIIGE8RZplIKHJZtQ4RjphRYp1xDGo01Ki1+rHEpn47r+Bg4cAJZIFDIg02Zglu23
	 fzAcuqtKLkvriro3eBs3JnoOQYU+WNfD5sTbjuheY9geSi0kng5GluRNr/D2ZyK8cLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312552;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Hyn6yw9zH4JaEWeeBt3E84RddFmv8NGvbZl0QTfTCp0=;
	b=EOIPkFe2ibXlZ96gaOq4Qq1bSUlVGc6zwLls86lumhrQHVrLtIl9+FZbdx4v3SPYzWxC
	 IsVVpNFlIOMLlkrEAa0p+IWxy7cz5KgzjoTItP2LvnEML7WUPec1MKV8MwMfn/iD8CAd0
	 P1yhpqySVaVVKj/OjxFIPNR7sx2xMF/4J6OBMzM7gk7dr3/QVDo63YMtVshtZILYWrOnK
	 IfVMkXQeZpQuc0sDAQecY3j3a43qK6CygMALeJi5LRQ0wFAcpAjxgE+I7pUTd5q0SmWf+
	 Q3iPvw0APoCPlZSA4wE2FRNqVJv5Rq+35/Wq5D86moArAEN2UtyG1vtVSfdwL7BKTgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fiBcD4RE;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70860A2633;
	Tue, 10 Nov 2026 12:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E70860A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fiBcD4RE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312549;
	bh=EpwACAMOccIeV+3AajABeF3S4pStQqfYZy2MXRRy7zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fiBcD4REDR2aqkHpd/AtYR2Cn/abEoQl9FMTdQBLVSMT9y0EsSxc5wLUNSW3+irmi
	 MeavSWV4VTe95Dp+GUHb4pwo7ManapuBN4FWd4gClbGtB80o6d3R+9xk76LnSB+E2w
	 bKoJ89ko2uXBpwWIQwwsneAS1T4LcQXriwlBFlmOUqINV3Tg0QGVCmQUfAfoWrfj9F
	 OqoANYS0vFkhX2hT0A8pgU3Lbg0G7SpUP1oMiCJlp6MlDC68NZ7qUfMj2eflLU/hJS
	 +rCR9E1dDWqUkiiNZe74QODAhI8YF7tu/G9kslQ4WWw+/rwbAdBi9BTITtsdCaNUbS
	 roR/xNBabq5XQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AB0B517E0A6C;
	Tue, 10 Nov 2026 13:09:08 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:57 +0100
Subject: [PATCH net-next v5 10/10] net: stmmac: mediatek: add support for
 MT8189 SoC
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-10-7d99d6292962@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=3068;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=EpwACAMOccIeV+3AajABeF3S4pStQqfYZy2MXRRy7zw=;
 b=9M/vPqjjzuqT4acDAxHr/YQw+fxbDqX6SFYhC5AmFqroFAf+8d45FtEpI5RFSa1kUNCxk9sZQ
 6FHLuqvWszUAwApu/T4Go0WAojJinW5zZjDMm/Hwu0hJ6y3HX3qtdAs
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Like MT8195 SoC, MT8189 SoC uses the Ethernet control registers from
the peripheral configuration (pericfg) but at a different offset.
It also has different RX and TX internal delay stage dividers (290ps
for MT8195, 180ps for MT8189), and by consequence a reduced value range
for these delays. It finally needs additional feature such as the
TX clock output enable one.

Thus, add compatible, clock definitions and specific platform data to
support the MT8189 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 1a0ab95dfbf0..ce232313014d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -42,8 +42,15 @@
 #define MT2712_RGMII_DELAY_MAX		5440 /* 32 x 170ps */
 
 /* Peri Configuration register for mt8189 */
+#define MT8189_PERI_ETH_CTRL_OFFSET	0x270
+
 #define MT8189_CTRL0_TXC_OUT_OP_EN	BIT(20)
 
+#define MT8189_MII_DLY_STAGE_DIV	180  /* 180ps per stage */
+#define MT8189_MII_DELAY_MAX		5760 /* 32 x 180ps */
+#define MT8189_RGMII_DLY_STAGE_DIV	180  /* 180ps per stage */
+#define MT8189_RGMII_DELAY_MAX		5760 /* 32 x 180ps */
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
 
@@ -124,6 +131,10 @@ static const char * const mt2712_dwmac_clk_l[] = {
 	"axi", "apb", "mac_main", "ptp_ref"
 };
 
+static const char * const mt8189_dwmac_clk_l[] = {
+	"axi", "apb", "mac_main", "ptp_ref"
+};
+
 static const char * const mt8195_dwmac_clk_l[] = {
 	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
 };
@@ -440,6 +451,20 @@ static int mt8195_set_delay(struct mediatek_dwmac_plat_data *plat)
 	return 0;
 }
 
+static const struct mediatek_dwmac_variant mt8189_gmac_variant = {
+	.dwmac_set_phy_interface = mt8195_set_interface,
+	.dwmac_set_delay = mt8195_set_delay,
+	.clk_list = mt8189_dwmac_clk_l,
+	.num_clks = ARRAY_SIZE(mt8189_dwmac_clk_l),
+	.dma_bit_mask = 35,
+	.mii_delay_max = MT8189_MII_DELAY_MAX,
+	.rgmii_delay_max = MT8189_RGMII_DELAY_MAX,
+	.mii_delay_stage_div = MT8189_MII_DLY_STAGE_DIV,
+	.rgmii_delay_stage_div = MT8189_RGMII_DLY_STAGE_DIV,
+	.peri_eth_ctrl_offset = MT8189_PERI_ETH_CTRL_OFFSET,
+	.mac_txclk_out_en = true,
+};
+
 static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_phy_interface = mt8195_set_interface,
 	.dwmac_set_delay = mt8195_set_delay,
@@ -729,6 +754,8 @@ static void mediatek_dwmac_remove(struct platform_device *pdev)
 static const struct of_device_id mediatek_dwmac_match[] = {
 	{ .compatible = "mediatek,mt2712-gmac",
 	  .data = &mt2712_gmac_variant },
+	{ .compatible = "mediatek,mt8189-gmac",
+	  .data = &mt8189_gmac_variant },
 	{ .compatible = "mediatek,mt8195-gmac",
 	  .data = &mt8195_gmac_variant },
 	{ }

-- 
2.56.0

