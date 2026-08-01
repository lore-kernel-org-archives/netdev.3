Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7B367F5E
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785594252; cv=none; b=nr5jfSskZ5UqNaDoAXkD8tP1H5LE03WlWNtkVdtlDjBvVF2mOdX4brZEaT4SB8Q3sqrKl7RgaLgKEGN0llXfnCKOMk+iGFKajTYGKG1AI6TlMKtx4IkhiorlPbwVviab4/X88iJ3K0QhZ36yPbaeg79IToLvx8opF+9g+T/BezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785594252; c=relaxed/simple;
	bh=tkQRbBQ/mU9vTatTgnLxBOyhRF8eVCc3keyF2sUn5vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ad3GrrGsnZlPZGzOJiVvE8YgrLCdUj5qzGjaA8BSltdFmvaZHwjbqwp/uuz6wDiLHHsrcIaDFFTGY2+/YjdxAeU+iUbR8wN4TPjAkCPG6MkolptrGp46J11Vt/9oF3V9oGyk8FHGvy0pRgOl0FHHGJYtIFwTnZBn7EVjFnWBYXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjHh6m0g; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjHh6m0g"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ce98cb8165so20490505ad.1
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 07:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785594247; x=1786199047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dWUPidv7BgL0nZPbTuClJD4vkQYV9rJlaf7Xm4RdOPo=;
        b=EjHh6m0gur97+VHfZHwKCbt9WyWE1ZPmZhWyK6VV9mMs6tpJBanIpn0kvLm6b2oG1R
         co4bwu+6Iu0PbIzbyl0niuyFkE7Q0fJN/tolRoRz7ok4xx/TmxBFhXURkPynmNgPLmvk
         EmQ+kGKSku0KsYwCGQUxrwREmru5Y9d0Tb7Dk2vUXtfvNG4jtimYIrOo+RReTHrDTJ7e
         4zZlfC/Zk8eub9n8AkLxIRmqZPZVBJycGJRusug1wpXUJmMQAcD2wvcNljJGCM1EYyQn
         CFFykGa6YT9TPDYqlzQI49JcsyXIsVvQEW2rNdZ4l+C1n2/9wji+ZD5mf8wWBL81oicq
         IKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785594247; x=1786199047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dWUPidv7BgL0nZPbTuClJD4vkQYV9rJlaf7Xm4RdOPo=;
        b=CttYPy0qV4n7dJqf3RzF0sCPqC4lepyHPXY/C42323MjA2Biy0tOcFp047JZcwlUSZ
         QUILP0xeVAyn5qg8TwtR2sf+ALl1uHT4XTlSm6Y0jJQvfHj8Z1DoQKD/SsYvni8Mpg1N
         shwm1uxxyBCrhj4onNvWXTsN3ggCtsZ42XpmQb9a7qyPz+DtLljLbYhQEuX7ZXLifzv4
         26yU5bVsSgseJLAZsuIewld8Ky4PJtBfGhVo9dCmM0pwbR21v3R+OzDBERHJj04REk03
         mUff9skOtjj2iGtG1+7d7A9ghg0uLG3JRVw0eAM2M5xsDe7QZaDYazVGacR9e1GvrjFN
         1j0g==
X-Forwarded-Encrypted: i=1; AHgh+RqdW/kgs7uhCgCdOTjuHf4S7sCxF8fW0tIy8XV/VU0bdzUXgfgpx1MAlOjiepg6beZe5Msi7QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfApnVvIwfIaCSofgATuUlBKijo6/ZMF7JgI9BAAz4niea6V7
	hA1pt0BBtjUeGtWK9hVj1/yqaswxWVZjnBrSYSlZ9E3D44Ikh4RNiwS1
X-Gm-Gg: AR+sD12xaO9gt1EbsnrKBL9rIG9WaR5ghAA5UJH4nwISxNawLz359u2hCNb2YxG+uUK
	s6bBVgPWAi16YJP8R6y+4otN3Ze++I8JLVUlEYEON2fZt5SujwVazoo9yL2xlVcAP75ZbioumYB
	On9wteJAydUBfzR6lUl6HTLZj2YnssLXvDrOu2Rz6PJH3H19eKNhoIq4wNA/EPOIDoTZAIy9/0j
	4ZjeRKAG3Z7TPkRfL/RDf3Gr6rFU+dZH0IUu//eNsNSTawTc8DZWT5m+dlWg0bl2evMBiSBLBoN
	1Bu1/DWXKb1NUN8eQ+aIObEft8d6BxXKKXuugFxv6xBCddW1t0O+4s7w0rOhEnAPOKHz3Ldc3xb
	766nRE6feTnxawvazd6u/chsacz/Jrp+/65LtTIM29GN9bQ15VytGpX59fgNjdefRczQlCrgu/i
	gKZbZfZW+jBlC4n5ZdtR2h+8lLfS2wc6hGn0s3uDrRNAS/EPMQTkY9l1SMHBgrGLDhCw==
X-Received: by 2002:a17:903:4b03:b0:2cf:7ea3:7cf1 with SMTP id d9443c01a7336-2d047d1e554mr54254035ad.5.1785594247397;
        Sat, 01 Aug 2026 07:24:07 -0700 (PDT)
Received: from server.lan ([103.213.4.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5ac3dsm18043845ad.23.2026.08.01.07.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 07:24:06 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 08/10] net: stmmac: dwmac-rk: add SGMII support for RK3568
Date: Sat,  1 Aug 2026 22:22:32 +0800
Message-ID: <20260801142244.679437-10-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260801142244.679437-2-coiaprant@gmail.com>
References: <20260801142244.679437-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3568 SoC integrates a Synopsys DesignWare XPCS that can be
connected to GMAC0 or GMAC1 in SGMII mode.  Add the necessary glue
logic to support this configuration.

The current dwmac-rk driver does not support SGMII mode.  SGMII
requires a PCS to handle auto-negotiation and link state reporting,
but the existing driver only supports RGMII and RMII.

Add a set_to_sgmii() callback to configure the GMAC GRF register for
SGMII mode (bit 7 set, interface selection bits 4:6 cleared).  Also
add a supports_sgmii flag to indicate SGMII capability.

Provide pcs_init/pcs_exit callbacks to create/destroy the XPCS via
xpcs_rk_create() from the Rockchip XPCS platform driver, and a
select_pcs callback to return the XPCS to phylink.

While at it, fix the clock enable ordering in rk_gmac_powerup():
gmac_clk_enable() is now called before any register access, including
the SGMII mode setup path.  Previously SGMII mode would bypass the
clock enable via a goto, which could cause synchronous external abort
when accessing MAC registers with the clock domain disabled.

Also clean up the error handling in rk_gmac_powerup() by using a
unified clk_disable label, and add error handling for the default
(unhandled interface) case.

SGMII In-band vs Out-of-band
============================
On RK3568, the MAC clock is fixed at 125 MHz and cannot be dynamically
changed by the stmmac core's set_clk_tx_rate callback.  In-band mode
works because the PCS handles rate adaptation internally.  Out-of-band
mode does not work because the MAC would need to change the clock rate
to 125/12.5/1.25 MHz for 1000/100/10 Mbps respectively, and the clock
is fixed.

Enable default_an_inband for SGMII and disable the generic stmmac
set_clk_tx_rate callback.  This forces phylink to use in-band mode,
where the PCS is responsible for speed/duplex negotiation.  Without
this, the stmmac core would attempt to change the clock rate on speed
changes, causing TX to work but RX to fail.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 121 +++++++++++++++---
 2 files changed, 104 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
index e3dd5adda5aca..5088acc06982e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
+++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
@@ -170,6 +170,7 @@ config DWMAC_ROCKCHIP
 	default ARCH_ROCKCHIP
 	depends on OF && (ARCH_ROCKCHIP || COMPILE_TEST)
 	select MFD_SYSCON
+	select PCS_XPCS_ROCKCHIP
 	help
 	  Support for Ethernet controller on Rockchip RK3288 SoC.
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 8d7042e689261..e47ca1bec5b8b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
+#include <linux/pcs/pcs-xpcs-rk.h>
 #include <linux/pm_runtime.h>
 
 #include "stmmac_platform.h"
@@ -47,6 +48,7 @@ struct rk_gmac_ops {
 	void (*set_to_rgmii)(struct rk_priv_data *bsp_priv,
 			     int tx_delay, int rx_delay);
 	void (*set_to_rmii)(struct rk_priv_data *bsp_priv);
+	void (*set_to_sgmii)(struct rk_priv_data *bsp_priv);
 	int (*set_speed)(struct rk_priv_data *bsp_priv,
 			 phy_interface_t interface, int speed);
 	void (*integrated_phy_powerup)(struct rk_priv_data *bsp_priv);
@@ -63,6 +65,7 @@ struct rk_gmac_ops {
 	bool clock_grf_reg_in_php;
 	bool supports_rgmii;
 	bool supports_rmii;
+	bool supports_sgmii;
 	bool php_grf_required;
 	bool regs_valid;
 	u32 regs[];
@@ -98,6 +101,7 @@ struct rk_priv_data {
 	bool integrated_phy;
 	bool supports_rgmii;
 	bool supports_rmii;
+	bool supports_sgmii;
 
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -809,6 +813,8 @@ static const struct rk_gmac_ops rk3528_ops = {
 #define RK3568_GRF_GMAC1_CON1		0x038c
 
 /* RK3568_GRF_GMAC0_CON1 && RK3568_GRF_GMAC1_CON1 */
+#define RK3568_GMAC_MODE_RMII_RGMII		GRF_CLR_BIT(7)
+#define RK3568_GMAC_MODE_SGMII_QSGMII		GRF_BIT(7)
 #define RK3568_GMAC_FLOW_CTRL			GRF_BIT(3)
 #define RK3568_GMAC_FLOW_CTRL_CLR		GRF_CLR_BIT(3)
 #define RK3568_GMAC_RXCLK_DLY_ENABLE		GRF_BIT(1)
@@ -851,18 +857,32 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
 
 	regmap_write(bsp_priv->grf, con1,
+		     RK3568_GMAC_MODE_RMII_RGMII |
 		     RK3568_GMAC_RXCLK_DLY_ENABLE |
 		     RK3568_GMAC_TXCLK_DLY_ENABLE);
 }
 
+static void rk3568_set_to_sgmii(struct rk_priv_data *bsp_priv)
+{
+	u32 con1;
+
+	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
+				     RK3568_GRF_GMAC0_CON1;
+
+	regmap_write(bsp_priv->grf, con1, RK3568_GMAC_MODE_SGMII_QSGMII);
+}
+
 static const struct rk_gmac_ops rk3568_ops = {
 	.init = rk3568_init,
 	.set_to_rgmii = rk3568_set_to_rgmii,
+	.set_to_sgmii = rk3568_set_to_sgmii,
+
 	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 
 	.supports_rmii = true,
+	.supports_sgmii = true,
 
 	.regs_valid = true,
 	.regs = {
@@ -1208,6 +1228,43 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
 		dev_err(bsp_priv->dev, "fail to disable phy-supply\n");
 }
 
+static int rk_pcs_init(struct stmmac_priv *priv)
+{
+	struct device_node *np = priv->device->of_node;
+	struct device_node *pcs_node;
+	struct dw_xpcs *xpcs;
+
+	pcs_node = of_parse_phandle(np, "pcs-handle", 0);
+	if (!pcs_node)
+		return -ENODEV;
+
+	xpcs = xpcs_rk_create(priv->device, pcs_node);
+	of_node_put(pcs_node);
+	if (IS_ERR(xpcs))
+		return PTR_ERR(xpcs);
+
+	priv->hw->xpcs = xpcs;
+	return 0;
+}
+
+static void rk_pcs_exit(struct stmmac_priv *priv)
+{
+	if (!priv->hw->xpcs)
+		return;
+
+	xpcs_destroy(priv->hw->xpcs);
+	priv->hw->xpcs = NULL;
+}
+
+static struct phylink_pcs *rk_select_pcs(struct stmmac_priv *priv,
+					 phy_interface_t interface)
+{
+	if (!priv->hw->xpcs)
+		return NULL;
+
+	return xpcs_to_phylink_pcs(priv->hw->xpcs);
+}
+
 static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 					  struct plat_stmmacenet_data *plat,
 					  const struct rk_gmac_ops *ops)
@@ -1330,6 +1387,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->supports_rgmii = ops->supports_rgmii || !!ops->set_to_rgmii;
 	bsp_priv->supports_rmii = ops->supports_rmii || !!ops->set_to_rmii;
+	bsp_priv->supports_sgmii = ops->supports_sgmii || !!ops->set_to_sgmii;
 
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
@@ -1361,6 +1419,10 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
 		if (!bsp_priv->supports_rmii)
 			return -EINVAL;
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		if (!bsp_priv->supports_sgmii)
+			return -EINVAL;
+		break;
 	default:
 		dev_err(bsp_priv->dev,
 			"unsupported interface %d", bsp_priv->phy_iface);
@@ -1379,16 +1441,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 	if (ret)
 		return ret;
 
+	ret = gmac_clk_enable(bsp_priv, true);
+	if (ret)
+		return ret;
+
+	if (bsp_priv->phy_iface == PHY_INTERFACE_MODE_SGMII)
+		goto set_mode;
+
 	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
 	if (ret < 0)
-		return ret;
+		goto clk_disable;
 
 	intf = ret;
 
-	ret = gmac_clk_enable(bsp_priv, true);
-	if (ret)
-		return ret;
-
 	if (bsp_priv->gmac_phy_intf_sel_mask ||
 	    bsp_priv->gmac_rmii_mode_mask) {
 		/* If defined, encode the phy_intf_sel value */
@@ -1399,10 +1464,8 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 				      bsp_priv->gmac_rmii_mode_mask);
 
 		ret = rk_write_gmac_grf_reg(bsp_priv, val);
-		if (ret < 0) {
-			gmac_clk_enable(bsp_priv, false);
-			return ret;
-		}
+		if (ret < 0)
+			goto clk_disable;
 	}
 
 	if (bsp_priv->clock.rmii_mode_mask) {
@@ -1410,13 +1473,12 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 				     bsp_priv->clock.rmii_mode_mask);
 
 		ret = rk_write_clock_grf_reg(bsp_priv, val);
-		if (ret < 0) {
-			gmac_clk_enable(bsp_priv, false);
-			return ret;
-		}
+		if (ret < 0)
+			goto clk_disable;
 	}
 
-	/*rmii or rgmii*/
+set_mode:
+	/* rmii, rgmii, sgmii */
 	switch (bsp_priv->phy_iface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		dev_info(dev, "init for RGMII\n");
@@ -1447,15 +1509,20 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		if (bsp_priv->ops->set_to_rmii)
 			bsp_priv->ops->set_to_rmii(bsp_priv);
 		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		dev_info(dev, "init for SGMII\n");
+		if (bsp_priv->ops->set_to_sgmii)
+			bsp_priv->ops->set_to_sgmii(bsp_priv);
+		break;
 	default:
 		dev_err(dev, "NO interface defined!\n");
+		ret = -EINVAL;
+		goto clk_disable;
 	}
 
 	ret = rk_phy_powerup(bsp_priv);
-	if (ret) {
-		gmac_clk_enable(bsp_priv, false);
-		return ret;
-	}
+	if (ret)
+		goto clk_disable;
 
 	pm_runtime_get_sync(dev);
 
@@ -1463,6 +1530,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
 
 	return 0;
+
+clk_disable:
+	gmac_clk_enable(bsp_priv, false);
+	return ret;
 }
 
 static void rk_gmac_powerdown(struct rk_priv_data *gmac)
@@ -1486,6 +1557,9 @@ static void rk_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
 
 	if (rk->supports_rmii)
 		__set_bit(PHY_INTERFACE_MODE_RMII, interfaces);
+
+	if (rk->supports_sgmii)
+		__set_bit(PHY_INTERFACE_MODE_SGMII, interfaces);
 }
 
 static int rk_set_clk_tx_rate(void *bsp_priv_, struct clk *clk_tx_i,
@@ -1602,6 +1676,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
 	plat_dat->suspend = rk_gmac_suspend;
 	plat_dat->resume = rk_gmac_resume;
 
+	if (plat_dat->phy_interface == PHY_INTERFACE_MODE_SGMII) {
+		/* SGMII clock always runs at 125 MHz */
+		plat_dat->set_clk_tx_rate = NULL;
+
+		/* SGMII requires a PCS */
+		plat_dat->default_an_inband = true;
+		plat_dat->pcs_init = rk_pcs_init;
+		plat_dat->pcs_exit = rk_pcs_exit;
+		plat_dat->select_pcs = rk_select_pcs;
+	}
+
 	plat_dat->bsp_priv = rk_gmac_setup(pdev, plat_dat, data);
 	if (IS_ERR(plat_dat->bsp_priv))
 		return PTR_ERR(plat_dat->bsp_priv);
-- 
2.47.3

