Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7146EC67
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515461; cv=none; b=B8i7aMlVQr2swfHQH9ueiIFJOSKMq7zioTZfxqhTmqXJFc9vxSjrx9dj2l7x+hXOUmjkFX4Qbu/6Tkph3zmtgdNi0A8WQhZpkCpIfDOurRwxJfrM8kE/anTNUsyRqMi2q+Hhx7xO2IwY1Fg0YG4zLRcg7gQk50nplDLJrYxByqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515461; c=relaxed/simple;
	bh=R6z60t6FDjDvLZiOQXYefYIG0bNfh9SKw55q0G81SGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogun/70H7Db7LFF26OQcKyd6QtSSQjqF++CyNyTWlNaMA7oAEPBGY8V81bTAuteK72vqUccSWA5etCgqdEWu+8ik34hXu7OfkVCrj5wKwvJ/NKfd+6TqS1/7tMnTZk0QJFX7r2aFUkQcBvkKlBFRHu5DBu0OQ23uaqoMcacumuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=jIRxpunw; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="jIRxpunw"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47de008b020so849092f8f.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785515455; x=1786120255; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djWGAgZFPMEwkPACC0SH0yA3REA4ghQKhBwTkhJwSTQ=;
        b=jIRxpunwGF/JlJq7POWfYun28f8D1tN4c2NGItPbrcgkWL5hF3le0bzcZiG5tevgWi
         LFnsMzXDkS46/QEKxSCgnHG1a50kzSWPHpOn1hWVpdVu6jBeUXyNZMMGj38tcKG409W+
         fyXjXzXV/k1t0+Ggb3j11EmfwfRlJW2lYD6fQbcym+wM2qWOyfO3PR54olFRdTFUl0dR
         BxrZ/+qjF1yMDDmRcxFdGTVhIme+/6dpF2RP9eyhk2HKNPfo0QhypgWj1DRpSm/xfUtC
         zGOOApY7eCoADVBNIEMt1fio0pVPLz72H4H4pnuivCooqM1/uaAYCo+gXvelIVw9lknh
         8xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515455; x=1786120255;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djWGAgZFPMEwkPACC0SH0yA3REA4ghQKhBwTkhJwSTQ=;
        b=noGC8tLC5Ql48p0YuwHAckqxRFm9YV2lzAcBPn+srHgYF60mvOrn00/1CpgsQyofpk
         ek9pgAMD2KbVzmo9Wj0IXmAvjoIrovveqc+RF0uT7HDyI2eMYvv4r/xeMkybquO6X96t
         JHb4O7sEzCe04kX7CIbgoSLY1TzusB2jRHLrRpF61o8k9t27EU6iVoyq/ywVk8N01R/e
         arbViotSsQtuaDhwz12gOkdvaVJ72eoVPch2t+UhXxC9Dbwl3RSRWeOM+Fcm0rvwMn3g
         ymx7oDO0z/5sDcTKYbetvtpX56A9TSxzwVOrjQEMN4awE0sAaLvjKINti9XOyXvBL1Z4
         XspA==
X-Gm-Message-State: AOJu0YyKIu/UPWbh9FCQruu+AJiwKE8BnTAorEiD7tMkRY+zvJtS6vad
	t7eZlleUGkAHkwaVx4BmNqVsXS42fBmQrh4BUUUEpk2+MBiQZ531TrJxP7szzsI2zclvfe6iuQE
	G2XRQ
X-Gm-Gg: AR+sD11MaIqHgW94SkxchEKRszB4nmNL2zdrelaw9ei2hxKllwPZVH+5+59+tAj8xVm
	BBKuN2iT21Gsrv1o71+7PvFe+w30pE49Q+dgN0Dqe9TspsCx2C/MrDu34P5D6Pjf+W6qc9TLo4d
	F33gzQ8uIqVd1qipYimB38OTuMMqhCJuFpIdw7LZ/bRAcQGOqL35CEr7eXsk4fs09E7lFKrS2ly
	Gl4QGXe563htPg9NWylUNDG1UB8ZCNgnfFo15RejrEX8k7mem/6WjuauHt13aCAYshn4HZUtEo/
	x5YuU5wYCJ72gI/6gKuBr2VIECmmGcoNEv/jFs/Rc/o3vw/zUEd7FGLtkxSDFemfJjYYN6gk9tG
	L3IIRCN3LOGt0mESmsNObMsIlXWSx/SWElR+67+9JOGtKL8bS/BvB6jKBvj/tlqTWBlGoFvtVAK
	tZ3x/1W+a++00RjQ48tVBI9wP9kXj91q/9JrEuw9o7LcHrERotrE6BMEay+g==
X-Received: by 2002:a05:6000:1846:b0:47f:6e8b:699c with SMTP id ffacd0b85a97d-47fd729208fmr726837f8f.14.1785515455179;
        Fri, 31 Jul 2026 09:30:55 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d00b:bc94:65a:a73d])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47fd4562667sm6935966f8f.24.2026.07.31.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 09:30:54 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 31 Jul 2026 18:30:27 +0200
Subject: [PATCH RFC/RFT 2/2] net: stmmac: Add support for Allwinner A733
 GMAC210
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-allwinner-a733-gmac-support-v1-2-d0a8732bfa82@baylibre.com>
References: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
In-Reply-To: <20260731-allwinner-a733-gmac-support-v1-0-d0a8732bfa82@baylibre.com>
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
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8196; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=R6z60t6FDjDvLZiOQXYefYIG0bNfh9SKw55q0G81SGM=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBqbM2yrm2AuGpFLVpemVLX90B3DnBbzHrGoGWqT
 xiLTieBOeuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCamzNsgAKCRDm/A8cN/La
 hegtD/wPspDO73Xa87akPckAschP4dgHAyp7127Gd1baf5ZpC5mHrFkJXQpW9DiH5scwiM465l+
 /kS8Z8F/V8xxYrn6InOmmg/dw3Im+JiNr+W1C1xOiEAwzmTNPdfFLIOAv0V8tsjCj9bpgFecs+P
 QOPV3JtzpAvELG9QPOWIxEnOYwEdvP7uKtEK5GdqccTQd4ICtdKau1GlPaXRKjaPxhv960YnUWl
 jJrW3w/jXAcgMkwJLB/y0OVjiziU5HKrnCmrAHcvvMDjeYRs+q6rO5kmTcaBBNPdfWrmCAKjfAx
 t+JIUu1mHbWuFIG4S78NQNN6J4X9I89doMc8xQ6/2LW68RfiEJQJzKVp2Q5E4XxUwYs8XSxBSZC
 vTzp79KWSngh19GFNZy8KDFx2Bp1kPSDKFxY2xuTFMGhyTj+JNeJ1hlPV9m1rTkesoKvhBiUSVx
 N4x+SYbDcm497L01W8ONCfXmClBY+JNsPFNjefBlt6MfBGSPl3z26CioYv8WRKxavAamQWnaXt8
 AIKw2rFOKWxIf0i8jV6PHQgag5tkp+byybxhFHvdnTU9YQCshdOpxxtcZyFC9qMNxgDlq2qdx44
 X/NwUNm2POmlNsmBFMBLdKzYyjYJOlByszNC50hS74Bz0CHcBhBoU0gNs649jNUCrhb/KUjN7h7
 Zma6cXT7h4ab0HQ==
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
2.47.3

