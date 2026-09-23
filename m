Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6154357EDBD
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196474; cv=none; b=Q5OilIAPveCh8xxbcu0KI1TXsye0kzKqPVx3TnEGmhexsQJoJOjONqkLlFA/o5GJuOgrMHx+AE//MOaHTdd+te7uUrhxdIGeyOBXVKSYAxK72a71NqjeFFvh09YBP6mvcoN5Wpy5xjtCRdEFpd+40EpRQFxRgD/1HNudW/DY2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196474; c=relaxed/simple;
	bh=sjLoecwDQJXaWVmzvGOQ+F7IRuyAd48CcawjSycmYoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNbnHKFzvPkmH4FVTY7tGcpFtMXSiklKqEW9u4+TYh55gl9WypAv5zeKIO4VaEhkuklXPZPU+lZx89O3GdV7Xfk+hNWEJRV84zij9rd4cvq4KngKHqXDHqW+1BILBer681bLVtJYu/20Ek/nigXvt1WDSTM0psaOAUklZAN6sl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GdXWg9yK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GdXWg9yK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912df756so9977145e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790196469; x=1790801269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHpHp+F5tI4LZnE8xFoLfG2BiWUFVvoyvHapbJH+e74=;
        b=GdXWg9yKY3WsQbWY+qukXrmughfq/vMpqLEGv80D9insKkvIJOoM1G+DNShWVo7s8D
         5F6DeV55aqJguZEEJvm06neTVEf30HFQD0uL/OSSKJ3OPJE9BhJ2D6+j+Q7aozT1NEMg
         o/5/n5I3ZKmwNdKxBC6alBBdg9eAQrHu0GhWZEZXQPccKcsIYEtzxRFgTPHz/iNCxcC7
         dH0ajzmA/s6XNrxFr8qzfpdVM/f5g3e2pVV+kO3ytp1IB7NzeBk5+XZwD1Zpt5j6Dgqn
         hFkNByafO6sKI8pEt01UBD0fFFPU5clXR51r7RfUUT0tcZsO+0L2xDJ6BI/tkxitg4hl
         12jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790196469; x=1790801269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHpHp+F5tI4LZnE8xFoLfG2BiWUFVvoyvHapbJH+e74=;
        b=vq2s44ZLZKz0ABGtCXyixkbSrwbQqIkjryBN5tG4OV8Uk513DV84r1QjD4UizFIjGy
         mNu0t5dq6B0Inm+aH+U/vepNgH4C2fmFe4Shwy2A3jVEdqQnzIVbedcoYNpkYfUJKpR7
         9DEbQsdb4ei5/xMUsvQ3IFuXRHNAIVNbKqz+dlHBIEUpsjaVlXV8S0Xu6yxH5QK/Vkz6
         TDGcVMs3X6vOjscCf/jU1ZYvy1LBCThAoJuu+bNqzRt+bayT1xT+ZpY69Nki/e+mTM8R
         EWp/kymwU5EjLBx8Ubg1u7g6OnEF4tRiydyNaAwRNGSKhWVGCoNdGueX/vqPvOa+2B0w
         WFrA==
X-Gm-Message-State: AFuF++lPeo+a24N2WTLhZb5mQOhkAUWNJuoKUWKgxBb3FXRnx9rT6HTp
	0Ei4Qf6NL9VC6Axs4B1kghG52X6xct720TmnUFoYkIJAO5QhvIxtXfpsXdcrK4hJqHU=
X-Gm-Gg: AYBFou3HN1QC5qSgrTnCjtLZPjYQ1nzlapnhVWBxG/CtxmyPf2VtN4YWbPXjkswkwZa
	dlQLbxGTahzKmyYG5QuW4gZ604MGBLPTUX+cCCcsSoptgNCYe/flwuiwC2PR7yWlCcJoyj4b+Up
	z833nmmGv8GZU1yLlAxxaUe6QcfebaF/Eco05fXoFC2QZB6lXgI1JBaV/mBcG+xS4r/37wELuAH
	yNVBli+FjkFTcseLzs1Ifpv8DnDHMhwL5+sd2khWNktptE/YQGQ+zji8vLhuPFP1WZnQbvxEGvb
	dWOby2ry7NV81YdyDePGJvTTsR75rwJVsAyxz4LaFuzCj+xowkiH2+6cWd/wuU1LEn63t70SW5+
	Wdegi8B7D5nYMF3PfL4WEapzPvoRCOuGs1HQQtoYJB4oSLwtRs+x2Uy6eMSOPXqMaIdOMNOkyGN
	er3H7Lzz6zF1LLcJpJ7JFb8pfWGIEzkv3Ac4ejuj9ufnVoGcWihimWqvX0FBEsQvJE2t5e7NV5W
	iXlHEEaNS6ruwxibw==
X-Received: by 2002:a05:600c:1989:b0:49d:16df:8521 with SMTP id 5b1f17b1804b1-49fe66ab9d1mr6607445e9.4.1790196469631;
        Wed, 23 Sep 2026 13:47:49 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b44db6sm14839105e9.0.2026.09.23.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 13:47:49 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 23 Sep 2026 22:47:35 +0200
Subject: [PATCH net-next v3 5/5] net: stmmac: sun55i: Add support for
 Allwinner A733 GMAC210
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-allwinner-a733-gmac-support-v3-5-15735155a789@baylibre.com>
References: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
In-Reply-To: <20260923-allwinner-a733-gmac-support-v3-0-15735155a789@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4132; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=sjLoecwDQJXaWVmzvGOQ+F7IRuyAd48CcawjSycmYoQ=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFlbrN669B39qPeAbW7OgdsplxQT71j87Zx16uqMiimtn
 Lp1lh6lHaUsDGJcDLJiiiw13NXi7yS1vsyarnMbZg4rE8gQBi5OAZiIihkjwyb31d8uyoQbH75s
 9sfsjf4n69Uei5jkzL5psmk98r3+tIrhv7f6q8R7G+4cYbbpqebm5Ntqsd2bf3uH2dmQ2SHdm9s
 c+AA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The A733 GMAC210 is a DesignWare MAC 5.20 using an Allwinner glue close to
the A523 GMAC200 already supported by this driver, with the following
differences to handle:

* The glue configuration registers are a dedicated MMIO region of the
  controller instead of a syscon register. This region is in the AHB
  reset domain, so the glue driver releases the shared AHB reset before
  writing the configuration.
* The TX clock delay value is 5 bits wide, split over 2 register fields.
  Both TX and RX delays use a 180ps step.
* The DMA channels have their own interrupt lines, so the per-DMA-channel
  interrupt mode is enabled, as the vendor SDK does.
* TX LPI clock gating is supported, as the vendor SDK indicates. Follow
  the PHY capability with STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP rather than
  forcing it on with the deprecated 'snps,en-tx-lpi-clockgating' DT
  property.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c | 53 +++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
index 49abbb248b61..675b83cd52c8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun55i.c
@@ -19,6 +19,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/stmmac.h>
 
 #include "stmmac.h"
@@ -65,6 +66,41 @@ static int sun55i_gmac200_init_resources(struct platform_device *pdev,
 	return 0;
 }
 
+static const struct regmap_config sun60i_a733_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+static int sun60i_gmac210_init_resources(struct platform_device *pdev,
+					 struct sun55i_gmac *gmac)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *ahb_reset;
+	void __iomem *base;
+
+	/*
+	 * Get the configuration region out of reset before changing it.
+	 * stmmac core holds the same shared reset but only deasserts it later.
+	 */
+	ahb_reset = devm_reset_control_get_shared_deasserted(dev, "ahb");
+	if (IS_ERR(ahb_reset))
+		return dev_err_probe(dev, PTR_ERR(ahb_reset),
+				     "Failed to get ahb reset\n");
+
+	base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "Unable to get config memory region\n");
+
+	gmac->regmap = devm_regmap_init_mmio(dev, base, &sun60i_a733_regmap_cfg);
+	if (IS_ERR(gmac->regmap))
+		return dev_err_probe(dev, PTR_ERR(gmac->regmap),
+				     "Unable to get regmap for config memory region\n");
+
+	return 0;
+}
+
 static int sun55i_gmac200_validate_delay(struct device *dev, const char *dir,
 					 u32 *val, u32 step, u32 max)
 {
@@ -132,9 +168,11 @@ static int sun55i_gmac200_setup(struct device *dev,
 				     phy_modes(plat->phy_interface));
 	}
 
+	/* The dwmac will sample this when stmmaceth reset is deasserted */
 	ret = regmap_write(gmac->regmap, gmac->data->offset, reg);
 	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to write to syscon\n");
+		return dev_err_probe(dev, ret,
+				     "Failed to write glue configuration\n");
 
 	return 0;
 }
@@ -202,9 +240,22 @@ static const struct sun55i_gmac_data sun55i_a523_gmac200_data = {
 	.rxdly_step_ps = 100,
 };
 
+static const struct sun55i_gmac_data sun60i_a733_gmac210_data = {
+	.init_resources = sun60i_gmac210_init_resources,
+	.flags = (STMMAC_FLAG_SPH_DISABLE |
+		  STMMAC_FLAG_MULTI_MSI_EN |
+		  STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP),
+	.offset = 0x0,
+	.etxdc_ext_mask = GENMASK(17, 16),
+	.txdly_step_ps = 180,
+	.rxdly_step_ps = 180,
+};
+
 static const struct of_device_id sun55i_gmac200_match[] = {
 	{ .compatible = "allwinner,sun55i-a523-gmac200",
 	  .data = &sun55i_a523_gmac200_data },
+	{ .compatible = "allwinner,sun60i-a733-gmac210",
+	  .data = &sun60i_a733_gmac210_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun55i_gmac200_match);

-- 
2.53.0

