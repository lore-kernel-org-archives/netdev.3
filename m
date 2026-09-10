Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6A23C3F7F
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035962; cv=none; b=ojIFzbJ0J+F/tx9ZBvubAjbgpa7HHTCj3YmcBN3zGvj2PNTDoWFYSlFLb463KdPsD8WJ5ruiyiTaIL/HJrdZvuTL5FK17cUNM/AaJ/8qiKRfjfWvWadUog/3eGMjLHvOKKHTWuollPKr8xD/EW/nZZNbR/tdaYL67AC4Ydlt6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035962; c=relaxed/simple;
	bh=iiviwEqL5gcgoRgKHDKcynyJRZSYhYM7KijUYtaKBco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HclhBp5xAI5iKoi9fpjXjEGeSautgmLdP693Yty4AaKspI6XV+PO8L56LbOVuMUKGartwtYIA2q2gSGsVMufxrRAAUx3b+/36N8Bm2fK2lSxHkIMpr6pVQVbE3TbLv1IuSz1vKy3Kxzoe1nRNnvfBJTbty5ROSq6w09zKzf81sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=OKMfMqYM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="OKMfMqYM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b8e527d63so87673725e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 03:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789035942; x=1789640742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yhS/iPoMN1yZRTKWNj0A3kjmWq9kDJx/qF0c8CAbTAw=;
        b=OKMfMqYMNWL2p1Filyvbkw64DoUvkcIff3HsWr7JXgoLZhXSslk8DcTY3aVANHtILe
         bbJIvSAdRwEqu0PJdzN462KrF/ZQvPHLdR7F/ytLHqqhLjDF1Y3CwWqUqG/FH0DEVKeA
         ZCO6f7LYTnxfvP4m9cO+WBV3ZPI1bzp5gT7UM5oGZpCBl81pwAmWGJufyrGgXvJR1Vvu
         v/nndugDdpMWuPsM0eIgEfCjzWeQ1i/cwoT6X+35RMZmFJ5U9cAzwNb6CguqU9RJ6n16
         d4T/5SG+TWh0Fyq4YuQsvBYE0AudiqyOa8UeDJAR1LUSi50odsf1KWJwVSBntny8Ng25
         jc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789035942; x=1789640742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yhS/iPoMN1yZRTKWNj0A3kjmWq9kDJx/qF0c8CAbTAw=;
        b=sPccKI/nr84oVZNYUibCNQJ3n8JJVcPu3XAM/eta9dddkDkJ5pWqaR+dHWUGYA6kAA
         1ZnKaftTBmHVsBD9W2M49H4uWpdIa4JRnh5gX+Jnajujg9sAopcMF6UmGbSvfEFkEQ62
         vQDHHBjZYPiXNUn1BMEoGBUM7x/U61uNKKYnToiWVRMC04lzf8+RzGxk9wmXZIigJjud
         edddOiAWGqYl7jAU53mCFUK9sEWYWs7EZPIWbTb+b6W7JH2z5RCLTD/oYugwa/5Yvcym
         Fd8pprzygbuefNuzE25+KDXYwucqA/rk3vKIiK7DxVi8ETmpeEnyWx9mZfw5BsJ8RxA8
         SF5w==
X-Gm-Message-State: AFuF++n15cYrc5iQQuXs1UT9casP6IY8Lb3V+e0xp5ZcjPSXl583z/Lj
	XfsWg6RiPrR80vODdD6Iy18z/WeyBDDoCo8S16c8jzB3Ud5JeiDHlIJfq1QiZYEjMNA=
X-Gm-Gg: AYBFou1Fbc9u8SkrsEK8U/wCONrt8pFUaDlX7DSCtNc28l4RusoSmfYfHXDayXEMXqT
	rdtquQqJR44HIBhu7SkMPwI5E46+x36h1sQp39YaESThNItV61Qp7rCnOqAnClvZLF1Ye3V41kQ
	bSKdgSAaP4f0wqfwDVpqMBLlN9pVyV9R8FRG9uKHzzGRORQO+BvFzIThsn2Zg5cVmFOOhPeYfaF
	p1p2Elunp00WxVJaD4/czp+uE1SexKxoBUzXX2L5F4w650ifWJ0GeWAvA0pfpgPH8lWe3s3ZVOd
	BnpVpFKQrTBBsl89sYpMdzM3IivDt5uXwDjoL0wpi6UYebPyFINGBesBRI7D8vTZ8Ope5G4i0oQ
	dIl0+Td8fuSxt9+npmnbD3fk+O+BEcU+27pipYQjlAT+3vNKWukxFOyNjnwm6Ox9rJZgquHEDSE
	tARdXehtx+F1nHhZfMfsLvnZ69NpSWN8BYGzXno4MERLaMtxjVzqxDz8MjY6XMKVHmCmn3CzhNT
	XZA/Q2EowxSV5Jipg==
X-Received: by 2002:a05:600c:3f0a:b0:49c:e27c:6b10 with SMTP id 5b1f17b1804b1-49cf81e4a10mr395443005e9.3.1789035942111;
        Thu, 10 Sep 2026 03:25:42 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26bdb789sm73960825e9.1.2026.09.10.03.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 03:25:41 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 10 Sep 2026 12:25:27 +0200
Subject: [PATCH net-next v2 2/2] net: stmmac: Add support for Allwinner
 A733 GMAC210
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-allwinner-a733-gmac-support-v2-2-4f4a1e520c23@baylibre.com>
References: <20260910-allwinner-a733-gmac-support-v2-0-4f4a1e520c23@baylibre.com>
In-Reply-To: <20260910-allwinner-a733-gmac-support-v2-0-4f4a1e520c23@baylibre.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Andre Przywara <andre.przywara@arm.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8196; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=iiviwEqL5gcgoRgKHDKcynyJRZSYhYM7KijUYtaKBco=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqooWfZVqP4h/FmhnIkFcpRFeUK9vhz7B5BXAfH
 GVm2YN9pAqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaqKFnwAKCRDm/A8cN/La
 hXUXD/9O9GcDsf6tEVteDWeDc13oqB3BEWwUiSNY8QkNQ/MlOz1JVGD1oJDrUYGAP7c/bT18jFM
 e+Zw8PmFy1XGty3EQPeh4vYiTiMyQoul16KwvltYnhl/1p4RaVg6RhZZJvRqss/qQOfVwgh5mK0
 X/kbiq0l/7jcZ6ruy6sHPn/6o72QxBlVcIsb1YmsNCiRAvGiOQKnjEXaTKQ7k97kHrBNshJK3q6
 dQG5nqbvdEd/jJoF9n2jBGWfrdF1fd11YAhSOkGszVCmMFoICkwKRn1Rz6m4eaJS3glbenr7hZ3
 SMZ4004904VmgGCiQK/ZVr3BvOXSI9p3TKqtj9T0c2kEjH2NtXzWwWLfEOed39FnEZfm7d2ev46
 TR3lv3liuy8kbKS7AOcIBkC8+6Yz/uohIC4/wbz/L7jGFNEWLzS2R1COwRaniFk4QBNU2di5/Ad
 SgW1a9PQDeapI/rfaUUDN9v9BMY0VzqAs50EDxl77FHE5iy8t2YhjQppsKA3pIW6y/dyu5w68T3
 Om39+TGBVZGN844LxmxBPYdLvFNmxoeXysO0fVorTfoSmEVmlubOBk3tK1AirGbysrePoAjGwxB
 aV2ix5mQPwJZIZujAe3waLNn9jwZMIk48YoRv9h9YPds/P63JVXPy5jr92RSZeiGQzbbpW+DLvG
 JA+jaF8VZnTruFQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 GMAC210 is a DesignWare MAC 5.20 using an Allwinner glue close to
the A523 GMAC200 already supported by this driver, with the following
differences to handle:

* The glue configuration registers are a dedicated MMIO region of the
  controller instead of a syscon register. This new register region
  appears to be in the reset domain of stmmac's main reset. This requires
  the glue driver to handle the reset rather than letting stmmac deal with
  it.
* The TX clock delay value is 5 bits wide, split over 2 register fields,
  allowing delays up to 3100ps.
* The DMA channels have their own interrupt lines, so the per-DMA-channel
  interrupt mode is enabled, as the vendor SDK does.
* TX LPI clock gating is supported, as the vendor SDK indicates. Follow
  the PHY capability with STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP rather than
  forcing it on with the deprecated 'snps,en-tx-lpi-clockgating' DT
  property.

Unlike the A523, both GMAC instances are supported by the same driver.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c | 145 ++++++++++++++++++---
 1 file changed, 127 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
index 862df173d963..3d434a52fb02 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
@@ -10,21 +10,22 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/bits.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/stmmac.h>
 
 #include "stmmac.h"
 #include "stmmac_platform.h"
 
-#define SYSCON_REG		0x34
-
 /* RMII specific bits */
 #define SYSCON_RMII_EN		BIT(13) /* 1: enable RMII (overrides EPIT) */
 /* Generic system control EMAC_CLK bits */
@@ -37,17 +38,99 @@
 #define SYSCON_ETCS_EXT_GMII	0x1
 #define SYSCON_ETCS_INT_GMII	0x2
 
-static int sun55i_gmac200_set_syscon(struct device *dev,
-				     struct plat_stmmacenet_data *plat)
+struct sun55i_gmac_data {
+	struct regmap *(*get_regmap)(struct platform_device *pdev,
+				     struct plat_stmmacenet_data *plat);
+	unsigned int flags;
+	u32 etxdc_ext_mask;
+	u32 offset;
+};
+
+static struct regmap *sun55i_gmac200_get_regmap(struct platform_device *pdev,
+						struct plat_stmmacenet_data *plat)
+{
+	struct regmap *map =
+		syscon_regmap_lookup_by_phandle(pdev->dev.of_node, "syscon");
+
+	if (IS_ERR(map))
+		dev_err_probe(&pdev->dev, PTR_ERR(map), "Unable to map syscon\n");
+
+	return map;
+}
+
+static const struct regmap_config sun60i_a733_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static void sun60i_gmac210_reset_assert(void *data)
 {
-	struct device_node *node = dev->of_node;
+	struct reset_control *rst = data;
+
+	reset_control_assert(rst);
+}
+
+static struct regmap *sun60i_gmac210_get_regmap(struct platform_device *pdev,
+						struct plat_stmmacenet_data *plat)
+{
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(base)) {
+		dev_err_probe(dev, PTR_ERR(base), "unable to get glue memory region\n");
+		return ERR_CAST(base);
+	}
+
+	if (!plat->stmmac_rst || !plat->stmmac_ahb_rst) {
+		dev_err(dev, "missing required reset controls\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	/*
+	 * The configuration registers are inside the controller
+	 * reset domain, so the reset must happen before any write to them
+	 * and should not be done again by stmmac or the configuration will
+	 * be lost.
+	 */
+	ret = reset_control_assert(plat->stmmac_rst);
+	if (!ret)
+		ret = reset_control_deassert(plat->stmmac_rst);
+
+	if (ret) {
+		dev_err_probe(dev, ret, "device reset failed\n");
+		return ERR_PTR(ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, sun60i_gmac210_reset_assert,
+				       plat->stmmac_rst);
+	if (ret)
+		return ERR_PTR(ret);
+
+	plat->stmmac_rst = NULL;
+
+	return devm_regmap_init_mmio(&pdev->dev, base, &sun60i_a733_regmap_cfg);
+}
+
+static int sun55i_gmac200_setup(struct platform_device *pdev,
+				struct plat_stmmacenet_data *plat,
+				const struct sun55i_gmac_data *data)
+{
+	unsigned int lo_bits = hweight32(SYSCON_ETXDC_MASK);
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
 	struct regmap *regmap;
 	u32 val, reg = 0;
+	u32 max_delay;
 	int ret;
 
-	regmap = syscon_regmap_lookup_by_phandle(node, "syscon");
+	max_delay = (1U << (lo_bits + hweight32(data->etxdc_ext_mask))) - 1;
+
+	regmap = data->get_regmap(pdev, plat);
 	if (IS_ERR(regmap))
-		return dev_err_probe(dev, PTR_ERR(regmap), "Unable to map syscon\n");
+		return PTR_ERR(regmap);
 
 	if (!of_property_read_u32(node, "tx-internal-delay-ps", &val)) {
 		if (val % 100)
@@ -55,12 +138,15 @@ static int sun55i_gmac200_set_syscon(struct device *dev,
 					     "tx-delay must be a multiple of 100ps\n");
 		val /= 100;
 		dev_dbg(dev, "set tx-delay to %x\n", val);
-		if (!FIELD_FIT(SYSCON_ETXDC_MASK, val))
+		if (val > max_delay)
 			return dev_err_probe(dev, -EINVAL,
-					     "TX clock delay exceeds maximum (%u00ps > %lu00ps)\n",
-					     val, FIELD_MAX(SYSCON_ETXDC_MASK));
+					     "TX clock delay exceeds maximum (%u00ps > %u00ps)\n",
+					     val, max_delay);
 
-		reg |= FIELD_PREP(SYSCON_ETXDC_MASK, val);
+		reg |= field_prep(SYSCON_ETXDC_MASK, val);
+		if (data->etxdc_ext_mask)
+			reg |= field_prep(data->etxdc_ext_mask,
+					  val >> lo_bits);
 	}
 
 	if (!of_property_read_u32(node, "rx-internal-delay-ps", &val)) {
@@ -95,21 +181,29 @@ static int sun55i_gmac200_set_syscon(struct device *dev,
 				     phy_modes(plat->phy_interface));
 	}
 
-	ret = regmap_write(regmap, SYSCON_REG, reg);
+	ret = regmap_write(regmap, data->offset, reg);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to write to syscon\n");
 
+	plat->flags |= data->flags;
+	plat->host_dma_width = 32;
+
 	return 0;
 }
 
 static int sun55i_gmac200_probe(struct platform_device *pdev)
 {
 	struct plat_stmmacenet_data *plat_dat;
+	const struct sun55i_gmac_data *data;
 	struct stmmac_resources stmmac_res;
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	int ret;
 
+	data = device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
 	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
 	if (ret)
 		return ret;
@@ -118,11 +212,7 @@ static int sun55i_gmac200_probe(struct platform_device *pdev)
 	if (IS_ERR(plat_dat))
 		return PTR_ERR(plat_dat);
 
-	/* BSP disables it */
-	plat_dat->flags |= STMMAC_FLAG_SPH_DISABLE;
-	plat_dat->host_dma_width = 32;
-
-	ret = sun55i_gmac200_set_syscon(dev, plat_dat);
+	ret = sun55i_gmac200_setup(pdev, plat_dat, data);
 	if (ret)
 		return ret;
 
@@ -138,8 +228,27 @@ static int sun55i_gmac200_probe(struct platform_device *pdev)
 	return devm_stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
 }
 
+static const struct sun55i_gmac_data sun55i_a523_gmac200_data = {
+	.get_regmap = sun55i_gmac200_get_regmap,
+	.flags = STMMAC_FLAG_SPH_DISABLE,
+	.offset = 0x34,
+	.etxdc_ext_mask = 0,
+};
+
+static const struct sun55i_gmac_data sun60i_a733_gmac210_data = {
+	.get_regmap = sun60i_gmac210_get_regmap,
+	.flags = (STMMAC_FLAG_SPH_DISABLE |
+		  STMMAC_FLAG_MULTI_MSI_EN |
+		  STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP),
+	.offset = 0x0,
+	.etxdc_ext_mask = GENMASK(17, 16),
+};
+
 static const struct of_device_id sun55i_gmac200_match[] = {
-	{ .compatible = "allwinner,sun55i-a523-gmac200" },
+	{ .compatible = "allwinner,sun55i-a523-gmac200",
+	  .data = &sun55i_a523_gmac200_data },
+	{ .compatible = "allwinner,sun60i-a733-gmac210",
+	  .data = &sun60i_a733_gmac210_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun55i_gmac200_match);

-- 
2.53.0

