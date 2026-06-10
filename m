Received: from mail.eswincomputing.com (mail.eswincomputing.com [123.124.195.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283D25333F;
	Wed, 10 Jun 2026 01:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.124.195.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055132; cv=none; b=sATFEvMuv5R4RVQ3dUucfJDMxk8N1Ny+FPSTgx4gJzD24cI/HVAdzdXFyvPpvpv/jTnyvFumRipuI38arWdg47bYD5IoE1YANG8+tnZ66FlgzqtH+rxQHtTL0E43FiNRlUeTgx01FbLpltksi7oGGYDJKQ6GLqy0wVzbFIDz60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055132; c=relaxed/simple;
	bh=G/iV1gy8avPsG6/qxdZ43w3Z/0VhPzFa/z1S52J5CG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIpSDb+fEhwc7122cmBA8FCRKqZnty47IK6pQtzsGKoHcioZEa7/zbxuMVlRdniMFCwjDB5jfSZo9yLXReuP7K46EVCcLogoGWsDIS2BNzy++n1MZvCmgwfse41191Nndq684X+UErfozaFjBZbAPBU5URWjvrfNXm8MFoo+p20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=123.124.195.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0004057DT.eswin.cn (unknown [10.11.96.26])
	by app1 (Coremail) with SMTP id TAJkCgDHXHGFvihqMZQlAA--.370S2;
	Wed, 10 Jun 2026 09:31:51 +0800 (CST)
From: lizhi2@eswincomputing.com
To: devicetree@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	maxime.chevallier@bootlin.com
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	pritesh.patel@einfochips.com,
	weishangjuan@eswincomputing.com,
	horms@kernel.org,
	lee@kernel.org,
	Zhi Li <lizhi2@eswincomputing.com>
Subject: [PATCH net-next v8 4/6] net: stmmac: eic7700: add support for eth1 clock inversion variant
Date: Wed, 10 Jun 2026 09:31:48 +0800
Message-ID: <20260610013149.938-1-lizhi2@eswincomputing.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260610012727.848-1-lizhi2@eswincomputing.com>
References: <20260610012727.848-1-lizhi2@eswincomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgDHXHGFvihqMZQlAA--.370S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw48CFy8tr1kXr43CrW5Awb_yoW3Ww48pF
	W8CrW5KF4qqr1fK397JF4vva4YyF4xKr4SyrWrKFsayas8tr98Xa40ya48JFy8GrW3Zr13
	Xw4jyFWxZa9F9rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE-syl42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWx
	Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRNBMKDUUUU
X-CM-SenderInfo: xol2xx2s6h245lqf0zpsxwx03jof0z/

From: Zhi Li <lizhi2@eswincomputing.com>

The eth1 MAC exhibits silicon-inherent RX and TX timing behavior that
differs from the eth0 implementation.

At 1000Mbps, RX sampling requires clock inversion due to a fixed MAC
input skew that cannot be compensated by standard RGMII delay settings.

The TX path includes a fixed ~2ns internal delay introduced by the MAC
silicon. This delay is always present and is already accounted for in
the device tree tx-internal-delay-ps property as part of the effective
output timing.

The tx-internal-delay-ps property describes the effective delay seen at
the MAC output. Since the hardware register controls only the
programmable portion of the delay, the driver subtracts the fixed
silicon-inherent component before programming the delay register.

Use compatible-specific match data to identify the eth1 variant and
apply RX clock inversion only at 1000Mbps.

The PHY interface mode is adjusted via phy_fix_phy_mode_for_mac_delays()
to avoid double-application of RGMII delays when MAC-side delays are
already present.

Link speed dependency means RX sampling configuration is applied in the
fix_mac_speed callback after negotiation.

No behavior changes for the existing eth0 controller.

Signed-off-by: Zhi Li <lizhi2@eswincomputing.com>
---
 .../ethernet/stmicro/stmmac/dwmac-eic7700.c   | 107 +++++++++++++++++-
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
index ec99b597aeaf..34a394a20570 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-eic7700.c
@@ -29,10 +29,14 @@
 /*
  * TX/RX Clock Delay Bit Masks:
  * - TX Delay: bits [14:8] — TX_CLK delay (unit: 0.02ns per bit)
+ * - TX Invert : bit  [15]
  * - RX Delay: bits [30:24] — RX_CLK delay (unit: 0.02ns per bit)
+ * - RX Invert : bit  [31]
  */
 #define EIC7700_ETH_TX_ADJ_DELAY	GENMASK(14, 8)
 #define EIC7700_ETH_RX_ADJ_DELAY	GENMASK(30, 24)
+#define EIC7700_ETH_TX_INV_DELAY	BIT(15)
+#define EIC7700_ETH_RX_INV_DELAY	BIT(31)
 
 #define EIC7700_MAX_DELAY_STEPS		0x7F
 #define EIC7700_DELAY_STEP_PS		20
@@ -43,7 +47,14 @@ static const char * const eic7700_clk_names[] = {
 	"tx", "axi", "cfg",
 };
 
+struct eic7700_dwmac_data {
+	bool rgmii_rx_clk_invert;
+	bool has_internal_tx_delay;
+	u32 tx_clk_inherent_skew_ps;
+};
+
 struct eic7700_qos_priv {
+	struct device *dev;
 	struct plat_stmmacenet_data *plat_dat;
 	struct regmap *eic7700_hsp_regmap;
 	u32 eth_axi_lp_ctrl_offset;
@@ -54,6 +65,7 @@ struct eic7700_qos_priv {
 	u32 eth_clk_dly_param;
 	bool has_txd_offset;
 	bool has_rxd_offset;
+	bool eth_rx_clk_inv;
 };
 
 static int eic7700_clks_config(void *priv, bool enabled)
@@ -97,9 +109,6 @@ static int eic7700_dwmac_init(struct device *dev, void *priv)
 	if (dwc->has_rxd_offset)
 		regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_rxd_offset, 0);
 
-	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset,
-		     dwc->eth_clk_dly_param);
-
 	return 0;
 }
 
@@ -126,8 +135,38 @@ static int eic7700_dwmac_resume(struct device *dev, void *priv)
 	return ret;
 }
 
+/*
+ * eth1 requires RX clock inversion at 1000Mbps due to silicon-inherent
+ * RX sampling skew at MAC input.
+ *
+ * The configuration is updated in fix_mac_speed() because the required
+ * sampling behavior depends on the negotiated link speed.
+ */
+static void eic7700_dwmac_fix_speed(void *priv, phy_interface_t interface,
+				    int speed, unsigned int mode)
+{
+	struct eic7700_qos_priv *dwc = (struct eic7700_qos_priv *)priv;
+	u32 dly_param = dwc->eth_clk_dly_param;
+
+	switch (speed) {
+	case SPEED_1000:
+		if (dwc->eth_rx_clk_inv)
+			dly_param |= EIC7700_ETH_RX_INV_DELAY;
+		break;
+	case SPEED_100:
+	case SPEED_10:
+		break;
+	default:
+		dev_warn(dwc->dev, "unsupported speed %u\n", speed);
+		return;
+	}
+
+	regmap_write(dwc->eic7700_hsp_regmap, dwc->eth_clk_offset, dly_param);
+}
+
 static int eic7700_dwmac_probe(struct platform_device *pdev)
 {
+	const struct eic7700_dwmac_data *data;
 	struct plat_stmmacenet_data *plat_dat;
 	struct stmmac_resources stmmac_res;
 	struct eic7700_qos_priv *dwc_priv;
@@ -148,6 +187,30 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	if (!dwc_priv)
 		return -ENOMEM;
 
+	dwc_priv->dev = &pdev->dev;
+
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
+		return dev_err_probe(&pdev->dev,
+				     -EINVAL, "no match data found\n");
+
+	dwc_priv->eth_rx_clk_inv = data->rgmii_rx_clk_invert;
+	/*
+	 * The MAC silicon unconditionally adds ~2 ns TX delay; prevent
+	 * the PHY from also adding TX delay to avoid doubling it.
+	 *
+	 * DT specifies rgmii-id (TX from MAC silicon, RX from PHY);
+	 * override to rgmii-rxid so the PHY only adds its RX delay.
+	 */
+	if (data->has_internal_tx_delay) {
+		plat_dat->phy_interface =
+				 phy_fix_phy_mode_for_mac_delays(plat_dat->phy_interface,
+								 true, false);
+		if (plat_dat->phy_interface == PHY_INTERFACE_MODE_NA)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"phy interface mode is NA\n");
+	}
+
 	/* Read rx-internal-delay-ps and update rx_clk delay */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "rx-internal-delay-ps", &delay_ps)) {
@@ -167,7 +230,13 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 				 FIELD_PREP(EIC7700_ETH_RX_ADJ_DELAY, val);
 	}
 
-	/* Read tx-internal-delay-ps and update tx_clk delay */
+	/* Read tx-internal-delay-ps and update tx_clk delay.
+	 *
+	 * For eswin,eic7700-qos-eth-clk-inversion, the DT property describes
+	 * the effective TX delay at the MAC output, including the inherent
+	 * silicon delay. Subtract the fixed component to obtain the
+	 * programmable delay value.
+	 */
 	if (!of_property_read_u32(pdev->dev.of_node,
 				  "tx-internal-delay-ps", &delay_ps)) {
 		if (delay_ps % EIC7700_DELAY_STEP_PS)
@@ -175,9 +244,16 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 				"tx delay must be multiple of %dps\n",
 				EIC7700_DELAY_STEP_PS);
 
+		if (delay_ps < data->tx_clk_inherent_skew_ps)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+				"tx delay %ups below inherent skew %ups\n",
+				delay_ps, data->tx_clk_inherent_skew_ps);
+
+		delay_ps -= data->tx_clk_inherent_skew_ps;
+
 		if (delay_ps > EIC7700_MAX_DELAY_PS)
 			return dev_err_probe(&pdev->dev, -EINVAL,
-				"tx delay out of range\n");
+				"tx delay out of programmable range\n");
 
 		val = delay_ps / EIC7700_DELAY_STEP_PS;
 
@@ -254,12 +330,31 @@ static int eic7700_dwmac_probe(struct platform_device *pdev)
 	plat_dat->exit = eic7700_dwmac_exit;
 	plat_dat->suspend = eic7700_dwmac_suspend;
 	plat_dat->resume = eic7700_dwmac_resume;
+	plat_dat->fix_mac_speed = eic7700_dwmac_fix_speed;
 
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
+static const struct eic7700_dwmac_data eic7700_dwmac_data = {
+	.rgmii_rx_clk_invert = false,
+	.has_internal_tx_delay = false,
+	.tx_clk_inherent_skew_ps = 0,
+};
+
+static const struct eic7700_dwmac_data eic7700_dwmac_data_clk_inversion = {
+	.rgmii_rx_clk_invert = true,
+	.has_internal_tx_delay = true,
+	.tx_clk_inherent_skew_ps = 2000,
+};
+
 static const struct of_device_id eic7700_dwmac_match[] = {
-	{ .compatible = "eswin,eic7700-qos-eth" },
+	{	.compatible = "eswin,eic7700-qos-eth",
+		.data = &eic7700_dwmac_data,
+	},
+	{
+		.compatible = "eswin,eic7700-qos-eth-clk-inversion",
+		.data = &eic7700_dwmac_data_clk_inversion,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eic7700_dwmac_match);
-- 
2.25.1

