Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFD413A86C;
	Tue,  7 Jul 2026 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783412508; cv=none; b=LpEwk2nRycyx/MvZHzu6VR02xdfkBwu8kyGQtD6ck+4DVT65Zi22lK083WIQQVZuaQTmaVq/V0n/tQhpxlibc0GGSeKcRebQ5pXDMxCNEMKBPeWZ/5+XcTJEl67aLYw/z0Ty1n/aZ8U3oxUGgHUcPW8nTeYdpJLcUoy3VQ3MkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783412508; c=relaxed/simple;
	bh=yRFtRc/8CY6QhoblVADW6T5FZ96+tHK2oCTcPJgNl7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7EcFMWpncCL49xr5ziytKxcbLRX+zQVYsDWCTZ4WuTrGFiAYAWgWJH9RFtqmMWkPym5N/qZQqNNAMvRqYa0Nsw9lKD4Ope6ayyx2wSrucsMN4KJ5QVZMXPbdVUfOHqx/6xbJSXMfKVVAD5e9uLyPrz4dTWlXIdH7MM58hWLZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=l8E70hUK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="l8E70hUK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783412502;
	bh=yRFtRc/8CY6QhoblVADW6T5FZ96+tHK2oCTcPJgNl7s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l8E70hUK27HaAhWyDDUGq83eZrgrzShx19lG+2vENSxAYCqCzqalr5R50+rhvrUnT
	 8sEOutSuePjJdK3n2QAgmawSYWY/kSrAt0gLBgMbwdZLs7jU+t3sWz6ol45KuC6mHr
	 3YfFNO+mNUI95qPth6mISBRA8nt6spOOhqGp12ekoBFVHM2ii6At1qc02EmessXJxu
	 lJKvVqcX9c0/oKSxsB9m1ZXww5cWQME8H8JISMNTpE4q85p04VT1uq6E9bUyFAo7c7
	 XsAIqEYDRwI5ZmCSKShhAtF05HOLWCZ5ldHfKr2wJBiUhFYhLI6zseL4x09SIrmooS
	 XXcsLgPdubBoQ==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AD8D217E1078;
	Tue, 07 Jul 2026 10:21:41 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 07 Jul 2026 10:21:24 +0200
Subject: [PATCH net-next 6/6] net: stmmac: mediatek: add support for MT8189
 SoC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dwmac-mediatek-mt8189-v1-6-17f345eaaca3@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783412493; l=2415;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=yRFtRc/8CY6QhoblVADW6T5FZ96+tHK2oCTcPJgNl7s=;
 b=rjmFjCSXIVFAAiwlRsbFDumpnHH5IheY8Gf75lMU0wWH1m9chQHK5CCQ/0CP5zbOLJj/U4I7k
 Vvhz8WTFGu+CtMHY+W5Pz6L89CX8GNvO/mhR0/hOwZiXpIg9gfTve7B
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Like MT8195 SoC, MT8189 SoC uses the Ethernet control registers from
the peripheral configuration (pericfg) but at a different
offset. It also needs additional features.

Thus, add compatible, clock definitions and specific platform data to
support the MT8189 SoC.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c    | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
index 6b0a42b5839f..e7e336b1f114 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-mediatek.c
@@ -37,6 +37,8 @@
 #define ETH_FINE_DLY_RXC	BIT(0)
 
 /* Peri Configuration register for mt8189 */
+#define MT8189_PERI_ETH_CTRL_BASE		0x270
+
 #define MT8189_CTRL0_TXC_OUT_OP			BIT(20)
 #define MT8189_CTRL0_DLY_GTXC_STAGE_FINE	GENMASK(11, 6)
 
@@ -116,6 +118,10 @@ static const char * const mt8195_dwmac_clk_l[] = {
 	"axi", "apb", "mac_cg", "mac_main", "ptp_ref"
 };
 
+static const char * const mt8189_dwmac_clk_l[] = {
+	"mac_main", "ptp_ref"
+};
+
 static int set_phy_interface_v1(struct mediatek_dwmac_plat_data *plat,
 				u8 phy_intf_sel)
 {
@@ -444,6 +450,19 @@ static int set_delay_v2(struct mediatek_dwmac_plat_data *plat)
 	return 0;
 }
 
+static const struct mediatek_dwmac_variant mt8189_gmac_variant = {
+	.dwmac_set_phy_interface = set_phy_interface_v2,
+	.dwmac_set_delay = set_delay_v2,
+	.clk_list = mt8189_dwmac_clk_l,
+	.num_clks = ARRAY_SIZE(mt8189_dwmac_clk_l),
+	.dma_bit_mask = 35,
+	.rx_delay_max = 9280,
+	.tx_delay_max = 9280,
+	.peri_eth_ctrl_offset = MT8189_PERI_ETH_CTRL_BASE,
+	.use_out_op = true,
+	.use_stage_fine = true,
+};
+
 static const struct mediatek_dwmac_variant mt8195_gmac_variant = {
 	.dwmac_set_phy_interface = set_phy_interface_v2,
 	.dwmac_set_delay = set_delay_v2,
@@ -694,6 +713,8 @@ static void mediatek_dwmac_remove(struct platform_device *pdev)
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

