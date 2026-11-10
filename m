Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312550;
	b=f50WpetznFGeugiHGMPbFe88CCL0Q8O0sN0assXG+4r+3knJO84VABV+XG9o/TGmcvlg
	 1xnJM8/P+2gLKoyHGOkBt/G7QGN0sFn10HMBVr7dNKcGoqd6rzeXx+2v0tNqr0xr7sAVo
	 lGqLTDXerMoQw7s3mGGVw8OQvXbNwzlaYu/iYuWUdI82msWtwbLSf6QOszqPbp91O5Kno
	 a9+WXHeqm7e0uczoFN4WxQ9dV3g4d+L7wCmhSznKoh8sFfzZTA/inGcpHtZj7PSMqigkY
	 zGtSm7bHx+gy0vCWLrP7wBYF0dlupFec68hXizenvtPrRFPw0+ReE1F99jxw1hmxRtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312550;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Qusr3lCq74aTv9fkHSvA33QF2eEA6P4XZk0qY+alf1s=;
	b=4O9ApX9upuCv15oS7QFfA0LOFq/aTcJdwwUoxYfhpiPh+O2lTQKiqQ7NqCGRhGgbjMEk
	 u8OKbnUI6scfJUHPgUgBOzIlSitogXeTuFtCoPQ5+BAda7b3vM+oZR5NFbkF+95Lom3Qy
	 e5m1S0FzODppsN2GPglzz3Q15xH0dWdjqNTsVwGsgGnTGpyjuN8jC/tb9rjK5FzsrCDDr
	 p76JHPuMR/RY0bjFvTpVabFb2jsVmSuI/76YmdGfS5YMozpTaYha4ThEP8eTHYSQmi6dW
	 Gk4U7ivC2xumTCXBckQG+L8v8sPNGlXLR2az5F3SKVUHBYhbIFarPuQrtCS36vOusKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="MnT4/Myk";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED984606D524;
	Tue, 10 Nov 2026 12:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED984606D524
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=MnT4/Myk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312548;
	bh=Wgr934lTDZL3+btac3ix2+Vp/TQVH/Zcp0CLN2iCsl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MnT4/Myke0bKMfzkVUBm6ZRxJhjaQ1q6ZuKZrPBLYFGjd6NUmlsmYFmMHxkSRrLYo
	 nx/f3t78Ruk64+BkJyy1xsGzkvrhz1kNrMOdMuqaWXkyIUh+wVgM/ZLaWosTPNfI2F
	 w6qVczdrroXhUt3lNyoYP6+YKk5gedBzClhPL5OIKGogkiXKpS1QF6jWiqe8Xu6x3a
	 DQwA8NAUfdW9suFzeRx3mvvZ6fnlnlPyoEOZy+2qzv8v9bUm/sYaL35CghJLcf2Eu0
	 7BWayed10xaFyoDiuBLSSq34kcVIRPJDyctxsypxlJv7rPbzM1tQA4lTFgqVa0i/nI
	 8bUq1vbpYT9OA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9971A17E0971;
	Tue, 10 Nov 2026 13:09:07 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:56 +0100
Subject: [PATCH net-next v5 09/10] net: stmmac: mediatek: add support for
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-9-7d99d6292962@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=1678;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=Wgr934lTDZL3+btac3ix2+Vp/TQVH/Zcp0CLN2iCsl0=;
 b=ajU6M3jMlhfUZtAkb+NKjwdPepxB2Qx11KQkD4w9nys4CZSqKDjj/5Ox1O2VIfMfjzT6ekftg
 P8lFewc5fmSBSxuddUChh3UFi4wZjKfOvMJy0Gf7ybgJqqHL0FSTf9g
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
index 3f024d455cbd..1a0ab95dfbf0 100644
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

