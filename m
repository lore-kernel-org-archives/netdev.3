Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700768;
	b=Y8hUqVPUXrKS38AEKocGhz0fH1/xtlS3+RrX6T7JTR9kZkHJ56TyC2njOVpxwYgk5K3v
	 2aJWpx0l5fHPGO4T7aZBO2YBg5qqv8OswlEnbJRwOoLTDP/L74ZU8l68G6WDbWoYTZDdE
	 p6rJKbV268jZDtNiQ+46yobXoGlk4WgUVil2+zwFYuLnN2gq31W6Tt18GcdxIMt+13Hk0
	 U3eQJq3NfNDS5o0ekaQBMEwohb9camtX3CdaamJTo3QLO1yV2yabhZcPrOKm2sr70VYR+
	 eY/Vkn8rYZ4QLfEOWmZoYgFYrsvw+jKLez4zy0e6Xx+FTX43xbhKI6nOCrq4qsNXQqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700768;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=yrBWsZjjtiF/haYFVEVoImmgknlm38Pea8AhTlGVyQc=;
	b=OyPdsZlU0FY5STaJHsdwBH54UQKpAn2o/MMadi4wyxKNRcsylULYRyTOuKb5KJ1ggm8u
	 LKNBQx8DPWdHb5WuVXEXVSa5Y028LyM69/CtY33Cx8wBjlzhyS/lqPWt0C+1bIAtm70BZ
	 xpXN34nsLwZUixvqda91FyUQW8cmUNaVfdBp5e9wZv06YNpdKjacvnAQje59CkcXE09xE
	 fhBRTzDIH4zcUgseZG41JPt9w3rc/88/QuXDZyBDOh3yR+ZtkFufNo5ZKrmAlkBTuZhRQ
	 8HRuzt8S6L6A87ajD4rajfeT3wf5XoAhIPgh9ach1Tm8pY5mPtuBa1R03QSU7zMqTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BomsHkpn;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E8606EEAE;
	Tue,  3 Nov 2026 10:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E7E8606EEAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=BomsHkpn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700767;
	bh=k7BZVTEhl5+fKOqiVRSm79Wa3lEDitEyKq/JHBxPr40=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BomsHkpnscoGEDMEuqWrQCtA/NXOXdeWeEfgWQfaZ7ZGzLrGKKKhMIfQKUkfmtH1S
	 TuWGyJzCGI8dHR5NtVNsBmUkSEGAA8Z/Chd0xP7tyiBxIv4xmao20r2KVSCgvArV++
	 /C3OhZaEDA3Ic/4tMzOQrm+ERDdleoHgpKutAEpoywEW/dm9KvQHMkpDqGbUJifCxK
	 9NlVDEg6A/Fu0kK+5LvRscgOf0hfpMd+EfmamUzKMLPNd4nEQfxY6mwGFDidUptmoR
	 fI1OaEQhFNoagZFpasT8XrWlYgu7msWPtVkPxT6rXrFgHrTkafgDjyFVgZZ+Y4r7Tx
	 xSjD8QszPgBag==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18B7417E0D4A;
	Tue, 03 Nov 2026 11:12:46 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:15 +0100
Subject: [PATCH net-next v4 10/10] net: stmmac: mediatek: add support for
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
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-10-c86c14fc50f4@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=3068;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=k7BZVTEhl5+fKOqiVRSm79Wa3lEDitEyKq/JHBxPr40=;
 b=NXZ3cYbw9gUeF00vWjN84Y97ZzmgU/JNsRs8keF+MYefD6nDwe+WRQAiz5oZmafZzDQYXUQ6W
 dBqVy7L3cZyBDZKeN9871nAsFrUrSKH8I3q0xdqFH9b+ap5/6qaUfot
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
index 8ee850791270..07d0c186ab65 100644
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
@@ -727,6 +752,8 @@ static void mediatek_dwmac_remove(struct platform_device *pdev)
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

