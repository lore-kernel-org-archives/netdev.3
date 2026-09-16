Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742823ACF10;
	Wed, 16 Sep 2026 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.15.109.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789533728; cv=none; b=h8SfVq/6p9lFTU/wDxFOG/jXctPaY03B2cQFN0RfP66YGU4LOBqADIV70ZpS0fvhOfBQMNUWIJ+oOI8vLjY4HiTlDp0CpraKbUaLORdX8BKMSeCCOdNe2MIKvuOpcEW2wZ+72NXcj1JFus32MlfC5cylSIVfGMqDWm8XCjy235Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789533728; c=relaxed/simple;
	bh=XB2VFwMX8lLgGoB9hByOvLGI1Lo6AfMSPcEBL9X0adY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdxbhHiR/ZGv+s9X2+1UCnnlVIjzvjIZWIJEwSED/14Aja589pxYBdDlpybLk0akmjQTErm0RBgqmAXHTlIjn0J1nQ8eshHEeQUFblvp8Ox993WFp8Hr02QDDarzZW/r1eR1TCtS4mbOv8UkPL1R+wcMjCtXgibQFAGz3aJJNXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org; spf=pass smtp.mailfrom=d-silva.org; dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b=k8nOuG05; arc=none smtp.client-ip=119.15.109.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=d-silva.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=d-silva.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="k8nOuG05"
Received: from Hawking.lan (hawking.lan [10.0.1.4])
	by www.nmnhosting.com (Postfix) with ESMTP id 6A10443BD0;
	Wed, 16 Sep 2026 14:41:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a;
	t=1789533715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YF/1pjayfOlwmv8drW2kZBXUotBXt7gAJUwr6YSztco=;
	b=k8nOuG05Z+CeUrqH2ZSIqdlJmph3gWW3orj/DZdoNJlTJMAYQjT5UEPAK/1+Ij7LxVqni/
	SkfcGj58RTHYg4SMGaaRf5Xl1nd6OFiWu3qr9Ttnf0w06sZ1ZZLLpDA87RFfvYHAw4TzPX
	ehIpEtU1cYyZ6LzqEBxn+JmEXKNQs+5B+16TSyGTN4sgHRxDXdc4/X2XGzhIaQAUNJBMI4
	qSip0kFU7tXOPPPBZoa+N5dOAyK9bXGZmhKoEH9jUwTvWj9gl4IGuA77duHIo88tslJEdV
	oDXjmNmW6TDuNZzOg+QpwQWDOMrlK4smcMpxmjbejxZHs/txuQgWqCQC/2bcZQ==
X-GPT-Reason: legitimate_transactional_technical_patch_submission_The
	email is a technical kernel patch submission for the Linux kernel
	(net-next), which perfectly aligns with the personal/professional
	context of the alastair@d-silva.org mailbox. The From domain matches
	the signature and content, and the body consists of a standard
	git diff and technical notes regarding the Allwinner H616 EMAC
	clock index. There are no phishing indicators, no external links,
	and no urgency/scare tactics.
From: Alastair D'Silva <alastair@d-silva.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH net-next 4/4] net: stmmac: dwmac-sun8i: Add Allwinner H616 EMAC clock index and internal PHY support
Date: Wed, 16 Sep 2026 14:41:19 +1000
Message-ID: <20260916044119.475666-5-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916044119.475666-1-alastair@d-silva.org>
References: <20260916044119.475666-1-alastair@d-silva.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support EMAC1 and the internal Fast Ethernet PHY (AC300) on Allwinner
H616 and H618 SoCs:
- Allow reading a register index from the syscon property to offset the
  regmap field for EMAC1's dedicated clock control register.
- Add emac_variant_h616_internal with support for internal PHY, MII,
  RMII, and RGMII modes.
- Delay the MAC software reset until sun8i_dwmac_init() when using the
  internal PHY, ensuring the PHY has powered on and begun generating
  the receive clock before the MAC attempts to reset.
- Skip setting H3_EPHY_SELECT for H616 internal EMAC, which does not
  use the H3-style EPHY select bit.
- Handle -EPROBE_DEFER cleanly during clock and reset control acquisition
  in get_ephy_nodes().

Assisted-by: LLM
Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---

Notes:
    Tested on Mellow Fly-C5 (Allwinner H618) under Armbian, verifying stable
    EMAC1 probe, deferred soft reset with the internal AC300 EPHY, and 100M full
    duplex operation under load.

 .../net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 65 ++++++++++++++++---
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb96233..1728893589a6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -130,6 +130,16 @@ static const struct emac_variant emac_variant_a64 = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_h616_internal = {
+	.syscon_field = &sun8i_syscon_reg_field,
+	.soc_has_internal_phy = true,
+	.support_mii = true,
+	.support_rmii = true,
+	.support_rgmii = true,
+	.rx_delay_max = 31,
+	.tx_delay_max = 7,
+};
+
 static const struct emac_variant emac_variant_h6 = {
 	.syscon_field = &sun8i_syscon_reg_field,
 	/* The "Internal PHY" of H6 is not on the die. It's on the
@@ -570,6 +580,7 @@ static const struct stmmac_dma_ops sun8i_dwmac_dma_ops = {
 };
 
 static int sun8i_dwmac_power_internal_phy(struct stmmac_priv *priv);
+static int sun8i_dwmac_reset(struct stmmac_priv *priv);
 
 static int sun8i_dwmac_init(struct device *dev, void *priv)
 {
@@ -589,6 +600,10 @@ static int sun8i_dwmac_init(struct device *dev, void *priv)
 		ret = sun8i_dwmac_power_internal_phy(netdev_priv(ndev));
 		if (ret)
 			goto err_disable_regulator;
+
+		ret = sun8i_dwmac_reset(netdev_priv(ndev));
+		if (ret)
+			goto err_disable_regulator;
 	}
 
 	return 0;
@@ -784,16 +799,23 @@ static int get_ephy_nodes(struct stmmac_priv *priv)
 	/* Seek for internal PHY */
 	for_each_child_of_node_scoped(mdio_internal, iphynode) {
 		gmac->ephy_clk = of_clk_get(iphynode, 0);
-		if (IS_ERR(gmac->ephy_clk))
-			continue;
+		if (IS_ERR(gmac->ephy_clk)) {
+			ret = PTR_ERR(gmac->ephy_clk);
+			if (ret == -EPROBE_DEFER) {
+				of_node_put(mdio_internal);
+				return ret;
+			}
+			gmac->ephy_clk = NULL;
+		}
 		gmac->rst_ephy = of_reset_control_get_exclusive(iphynode, NULL);
 		if (IS_ERR(gmac->rst_ephy)) {
 			ret = PTR_ERR(gmac->rst_ephy);
 			if (ret == -EPROBE_DEFER) {
+				clk_put(gmac->ephy_clk);
 				of_node_put(mdio_internal);
 				return ret;
 			}
-			continue;
+			gmac->rst_ephy = NULL;
 		}
 		dev_info(priv->device, "Found internal PHY node\n");
 		of_node_put(mdio_internal);
@@ -871,7 +893,9 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
 		switch (desired_child) {
 		case DWMAC_SUN8I_MDIO_MUX_INTERNAL_ID:
 			dev_info(priv->device, "Switch mux to internal PHY");
-			val = (reg & ~H3_EPHY_MUX_MASK) | H3_EPHY_SELECT;
+			val = (reg & ~H3_EPHY_MUX_MASK);
+			if (gmac->variant != &emac_variant_h616_internal)
+				val |= H3_EPHY_SELECT;
 			gmac->use_internal_phy = true;
 			break;
 		case DWMAC_SUN8I_MDIO_MUX_EXTERNAL_ID:
@@ -892,10 +916,13 @@ static int mdio_mux_syscon_switch_fn(int current_child, int desired_child,
 		} else {
 			sun8i_dwmac_unpower_internal_phy(gmac);
 		}
-		/* After changing syscon value, the MAC need reset or it will
+		/* After changing syscon value, the MAC needs reset or it will
 		 * use the last value (and so the last PHY set).
+		 * For internal PHY, the MAC reset will timeout because the PHY
+		 * is not yet enabled/clocked. Delay the reset to dwmac_init.
 		 */
-		ret = sun8i_dwmac_reset(priv);
+		if (!gmac->use_internal_phy)
+			ret = sun8i_dwmac_reset(priv);
 	}
 	return ret;
 }
@@ -1000,9 +1027,13 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 
 static void sun8i_dwmac_unset_syscon(struct sunxi_priv_data *gmac)
 {
-	if (gmac->variant->soc_has_internal_phy)
-		regmap_field_write(gmac->regmap_field,
-				   (H3_EPHY_SHUTDOWN | H3_EPHY_SELECT));
+	if (gmac->variant->soc_has_internal_phy) {
+		u32 val = H3_EPHY_SHUTDOWN;
+
+		if (gmac->variant != &emac_variant_h616_internal)
+			val |= H3_EPHY_SELECT;
+		regmap_field_write(gmac->regmap_field, val);
+	}
 }
 
 static void sun8i_dwmac_exit(struct device *dev, void *priv)
@@ -1111,6 +1142,7 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 	struct stmmac_priv *priv;
 	struct net_device *ndev;
 	struct regmap *regmap;
+	u32 syscon_idx = 0;
 	int ret;
 
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
@@ -1163,8 +1195,15 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = of_property_read_u32_index(pdev->dev.of_node, "syscon", 1,
+					 &syscon_idx);
 	gmac->regmap_field = devm_regmap_field_alloc(dev, regmap,
-						     *gmac->variant->syscon_field);
+						     (const struct reg_field) {
+							.reg = gmac->variant->syscon_field->reg +
+							       syscon_idx * sizeof(u32),
+							.lsb = gmac->variant->syscon_field->lsb,
+							.msb = gmac->variant->syscon_field->msb,
+						     });
 	if (IS_ERR(gmac->regmap_field)) {
 		ret = PTR_ERR(gmac->regmap_field);
 		dev_err(dev, "Unable to map syscon register: %d\n", ret);
@@ -1278,6 +1317,12 @@ static const struct of_device_id sun8i_dwmac_match[] = {
 		.data = &emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
 		.data = &emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-emac",
+		.data = &emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-emac1",
+		.data = &emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-internal-emac",
+		.data = &emac_variant_h616_internal },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);
-- 
2.53.0

