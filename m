Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304A434999;
	Thu, 24 Sep 2026 07:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790234669; cv=none; b=hq3IUq7ULUDxBVhu3McKiT+52xADFafKpAECDLw0f9GD9db+RLpJKuiG9fw5Wtvps04KFiWFHszynmkTaKfIY/Hj39aASv5LDtixBx80OdGO/t0HHP3majKhSK/jq9MqnlggZEEhl/Qg9Tu0AtouC6H3KPxplexcumJZ/AuyQqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790234669; c=relaxed/simple;
	bh=sSezKiaqxq23TTfadrJLUrsY2IKOxpyQqg9BJ2ukj9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dDRn+hLqjl+47BkXww82CVjYlvzb3vblaiQWBfNRmEfl4w+woDSDq/lrGoG4AsGmtaK7qA6GBNrYnYEfTrCrda7fQl6y+W/N4iOL75fBOIrdbMu/Ji3ozlfYaYGxL/vGLuCAwqLNMjyRrAq4uS2nLgmHrje+lKIoT7RwfXXSSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZOC4rL3Z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZOC4rL3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790234659;
	bh=sSezKiaqxq23TTfadrJLUrsY2IKOxpyQqg9BJ2ukj9I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZOC4rL3ZoeWu6ToY0V+sCwumqxwq2HszvCZfNc1v5BA9T4fSNkO0ggRnttjFDKCv9
	 D/0J4EzNg+jctAEOftWxzGM94OeYU7DQFwhlJqvd/v8jzDyastOsmjXUCextWXCo6B
	 s1dTshsx8E/NcHAiBSIzm/IRW+QSIv9o7HaLmX/2oAsbkeuKz6g0ngHBwhDGS9371G
	 Sw9c6CqgoPXjVvjBaXYbrTZmqeR6bLjb+HCEMqlk8KRc8CIaBHCWYz/G9ZVJpJQSjv
	 cXjGT0+qhAeBvdWiERGduz2qOchcNwVSDKoHE1wLg52uAVzc+i4QAXPB4a8UFyFV3y
	 S1VkdIkOvnC7g==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 38EB317E13A8;
	Thu, 24 Sep 2026 09:24:19 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 24 Sep 2026 09:23:30 +0200
Subject: [PATCH net-next v2 7/7] net: stmmac: mediatek: add support for
 MT8189 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-dwmac-mediatek-mt8189-v2-7-430bd74d5ef9@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234653; l=3069;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=sSezKiaqxq23TTfadrJLUrsY2IKOxpyQqg9BJ2ukj9I=;
 b=U11+BrDazUrWJMfChDYD11gT4cWzBGFKBe+D/h/Jnl0oEGPUv5EvB2DOfYHxLRJSilPGQLcf0
 xty/mOQfMpTDNdpmZRoPAcnMls6X/sDd4+7gx/zkdMVQbZiOyuPZ3zG
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
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 36599dc33b14..f07c331b029f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -37,8 +37,15 @@
 #define ETH_FINE_DLY_RXC	BIT(0)
 
 /* Peri Configuration register for mt8189 */
+#define MT8189_PERI_ETH_CTRL_OFFSET	0x270
+
 #define MT8189_CTRL0_TXC_OUT_OP_EN	BIT(20)
 
+#define MT8189_DLY_RXC_STAGE_DIV	180  /* 180ps per stage */
+#define MT8189_DLY_RXC_MAX		5760 /* 32 * 180ps */
+#define MT8189_DLY_TXC_STAGE_DIV	180  /* 180ps per stage */
+#define MT8189_DLY_TXC_MAX		5760 /* 32 * 180ps */
+
 /* Peri Configuration register for mt8195 */
 #define MT8195_PERI_ETH_CTRL_OFFSET	0xFD0
 
@@ -124,6 +131,10 @@ static const char * const mt8195_dwmac_clk_l[] = {
 	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
 };
 
+static const char * const mt8189_dwmac_clk_l[] = {
+	"mac_main", "ptp_ref"
+};
+
 static int mt2712_set_interface(struct mediatek_dwmac_plat_data *plat,
 				u8 phy_intf_sel)
 {
@@ -495,6 +506,21 @@ static void mt8195_fix_mac_speed(void *priv, phy_interface_t interface,
 			   reg_val);
 }
 
+static const struct mediatek_dwmac_variant mt8189_gmac_variant = {
+	.dwmac_set_phy_interface = mt8195_set_interface,
+	.dwmac_set_delay = mt8195_set_delay,
+	.dwmac_fix_mac_speed = mt8195_fix_mac_speed,
+	.clk_list = mt8189_dwmac_clk_l,
+	.num_clks = ARRAY_SIZE(mt8189_dwmac_clk_l),
+	.dma_bit_mask = 35,
+	.rx_delay_max = MT8189_DLY_RXC_MAX,
+	.tx_delay_max = MT8189_DLY_TXC_MAX,
+	.rx_delay_stage_div = MT8189_DLY_RXC_STAGE_DIV,
+	.tx_delay_stage_div = MT8189_DLY_TXC_STAGE_DIV,
+	.peri_eth_ctrl_offset = MT8189_PERI_ETH_CTRL_OFFSET,
+	.mac_txclk_out_en = true,
+};
+
 static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_phy_interface = mt8195_set_interface,
 	.dwmac_set_delay = mt8195_set_delay,
@@ -751,6 +777,8 @@ static void mediatek_dwmac_remove(struct platform_device *pdev)
 static const struct of_device_id mediatek_dwmac_match[] = {
 	{ .compatible = "mediatek,mt2712-gmac",
 	  .data = &mt2712_gmac_variant },
+	{ .compatible = "mediatek,mt8189-gmac",
+	  .data = &mt8189_gmac_variant },
 	{ .compatible = "mediatek,mt8195-gmac",
 	  .data = &mt8195_gmac_variant },
 	{ }

-- 
2.55.0

