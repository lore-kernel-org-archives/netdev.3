Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5C43D6494
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215921; cv=none; b=krNdKkla8VOepGkMzqs5u1YXBAO9Gf2lhdD1AK+5zKzLUQ5BZSYNxrFq79jcJ8weX07HxZJkthN5CQu7fOxFS6kbw6n9ubnS1QxidZuJpx0uMHCPnn3X3BfrM4M4VgXRry8l+A+EIYLYLb7qDY7nK2IXiqeFSRy1AAQ5d1jWKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215921; c=relaxed/simple;
	bh=+EenhDD7y+Jt47SyV2lR01r99xv2X/HA5P9X4ekmVy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NOyrs1L56S38lFtgiX/RFiyrXQCFcbXEW39UvvVTLhc5+ujhwESy1alPhfAbc1db2yPk/vo2VC7JFqgCAGj3dF82yL3fZPoUBJyb5qtHxJ3SfEJeeMDFwqsapU+opFG1yRHyqz5ZzIQ8/jho4yNz6+gxGxi42dsmdJFROjSL/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhF0+dDC; arc=none smtp.client-ip=74.125.228.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhF0+dDC"
Received: by mail-pz2-f8.google.com with SMTP id 41be03b00d2f7-cd1da63bff6so24059a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215918; x=1792820718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ufvOefWhgYH0/UBXiQmCrndB2RGKCn2LAdl5KbhcjzI=;
        b=dhF0+dDCK/U1x7ch4tzdLeaqeKhMfzQo7OE69MnsbjFpjtqrKvoyigcZjhhBdkRBQq
         qEZU1blDW5dBXsFqoELLVJ5AhG3HDTn8d1JIEo3OLQgapzdGmVvZQuMRZ16A6crpuK4S
         ZqOWqJpRypT3bInC9Er1yO9YewG7UHR6xUTd3ecWL3oEjP2ijMEDjQCZrFIxRFukoP/f
         tcNpoy5fB5PAq3flhKItYaZ0ViJinfOmvWzeeeY2/gHXC0vYeWS7gcH1bn0clP3qEdXm
         zrH0KJGe8DiS/phh8tNRLMpJIra5fE0JuxTPWTkO0Ne9vancoP0GxDPCCyvwLQKrbI4F
         Ta+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215918; x=1792820718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ufvOefWhgYH0/UBXiQmCrndB2RGKCn2LAdl5KbhcjzI=;
        b=cXw1SUZ+1CK7b/suUwUhSMG40afkUJJyoZMDfY8umdyPHA7KbhyVQZoCSU2EaOHiYk
         t7cnxrvi2he245nZLNE295h7JsCbUQjpbWflHFXkx0UV5jgEpctVps1hOndb1SCVt3QM
         o5KVGm7uVZXBA1dWSrQ2WivCzTumKtSZKEppyWcGACNwddPHnM+TevxKTdhrZCnvpyn5
         PxaKI8AW4ohneqL674HZPO888U5bjUZBPY6dbcUbISz61Izk0VIODEWROxobC8/KR5h/
         MkEjOJW7K1VRefbNhCdPiaIWyjTbqUp3AOe9pMQBCuu8CJN+4qDo+ioRUwAIt32suHaV
         hDhQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1Dat7l6fDGv8QoMS/fD1iDh6BnNSyiU1dZX4A+Q5KLbUYzdE7uzLdbi2+An90dJv202763QM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBPsQqswDgtMD9C+s0KoVm1uhAmZoezmJyW+mlH8MF9RacJk1g
	pGJVp/xAXQ18dlyiWQ8Tv4cXfu1sPsUhd0xvK+GhjYAU2pWWsDfy9/q1
X-Gm-Gg: AYBFou1Gt2hFULlxmwsr70qu/CBJtyWtNlwhUVI2jc3hHNd9TWQC5T8mI6wKacv0Rnd
	3xNI8SnpdmVZZVFbTSxUuJvFclz6tPdJvG1++obrgT28WU50j5AAvOAUw8BowDukp1lHQdhxPqh
	SEUcROvuTgHccBoxwBBEML04FpHVlNF/7h1+AkfB2Wo3m2CN6HvN+mrDF+u1zLnNL30rU58rcBE
	wPA39L0mtEMpXKft3TOskO8jMnvuyH3J/OtWHzwZf3fypyuBgSRFD6WRWiBHKR1u/+n7WlW7K4V
	DTJKqc4syl3fgXyGlTGW1JC9zvdPHnMsmlbV5kWYlzWuCIRR/qJn+rhe+Im6FAdIpmHtmvdJxs6
	45yWBSIffSQxRQVAoOOfdY+pkc7B+wxr4Ewl5fhlbxn3rOin01dNEi/e1JriKzcJ7Bk65++SiPr
	lq+j8Ln8Ge8dHmW1JNDmMeAC1SmtsqzYX7MLRfJfO/STskG0PWVUb1k/aadArlKPHDN8g8o6Bt4
	JSOcCo=
X-Received: by 2002:a05:6a20:c5aa:b0:3e0:c346:734a with SMTP id adf61e73a8af0-3e225f6c9b6mr1019029637.11.1792215918388;
        Fri, 16 Oct 2026 22:45:18 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm1958225b3a.23.2026.10.16.22.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:45:17 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v12 5/6] net: stmmac: dwmac-rk: add SGMII support for RK3568
Date: Sat, 17 Oct 2026 13:44:03 +0800
Message-ID: <20261017054406.1828061-6-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017054406.1828061-1-coiaprant@gmail.com>
References: <20261017054406.1828061-1-coiaprant@gmail.com>
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
SGMII mode (bit 7 set, interface selection bits 4:6 ignored when set).
Also add a set_to_rmii() callback for rk3568 to explicitly clear bit 7,
since the new SGMII path leaves it set and the RMII branch previously
relied on the SoC reset value.

Provide pcs_init/pcs_exit callbacks to create/destroy the XPCS via
xpcs_rk_create() from the Rockchip XPCS platform driver, and a
select_pcs callback to return the XPCS to phylink.  The MII port passed
to xpcs_rk_create() is the GMAC id (bsp_priv->id): GMAC0 maps to port 0,
GMAC1 maps to port 1, matching the hardware routing.

SGMII is not added to rk_get_interfaces(): it comes from the XPCS's own
supported_interfaces, merged by stmmac_phylink_setup().

The SerDes PHY and the PD_PIPE power domain are owned by the XPCS
driver rather than managed through the stmmac
serdes_poweron/serdes_poweroff callbacks, which are legacy and meant
for single-MAC platforms. On RK3568 the XPCS is the natural owner of
the shared SerDes.

DWMAC_ROCKCHIP selects PCS_XPCS_ROCKCHIP. PCS_XPCS itself is already
selected by STMMAC_ETH, and PM is selected by ARCH_ROCKCHIP, so no
further selects are needed.

Reorder rk_gmac_powerup() so that gmac_clk_enable() is called before
the SGMII check.  The SGMII path skips rk_get_phy_intf_sel(), so the
clock must be enabled earlier to cover all register accesses in that
path.  While at it, unify the error unwinding into a single
clk_disable label and add error handling for the default (unhandled
interface) case.

SGMII In-band vs Out-of-band
============================
On RK3568, the MAC clock is fixed at 125 MHz and cannot be changed per
speed.  Out-of-band mode requires the MAC to change its clock to
125/25/2.5 MHz for 1000/100/10 Mbps respectively, which the hardware
does not support here.  The driver therefore clears rk_set_clk_tx_rate()
and the clock stays at 125 MHz.

The PCS is still told the speed in out-of-band mode (through a BMCR
write in xpcs_link_up_sgmii_1000basex()), but the MAC clock does not
follow.  At 10/100 Mbps this gives working TX and failing RX.

Enable default_an_inband for SGMII and clear rk_set_clk_tx_rate(), so
phylink uses in-band mode, where the PCS is responsible for
speed/duplex negotiation.

Note that default_an_inband can be overridden by a fixed-link node, and
phylink may also fall back to out-of-band if the PHY does not support
in-band signalling.  Out-of-band SGMII is not supported by this driver.
The only out-of-band configuration that would work is 1000BASE-X with a
fixed-link, where the MAC clock stays at 125 MHz; 10/100 Mbps gives
working TX and failing RX.  Boards must use in-band mode
(managed = "in-band-status" or an in-band capable PHY).

1000BASE-X is not enabled by this series; it may be added later if
there is a user for it.

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 131 +++++++++++++++---
 2 files changed, 112 insertions(+), 20 deletions(-)

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
index 72bdbcb5e863a..c4db919ec1640 100644
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
@@ -836,6 +842,16 @@ static int rk3568_init(struct rk_priv_data *bsp_priv)
 	}
 }
 
+static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
+{
+	u32 con1;
+
+	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
+				     RK3568_GRF_GMAC0_CON1;
+
+	regmap_write(bsp_priv->grf, con1, RK3568_GMAC_MODE_RMII_RGMII);
+}
+
 static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
 				int tx_delay, int rx_delay)
 {
@@ -851,19 +867,31 @@ static void rk3568_set_to_rgmii(struct rk_priv_data *bsp_priv,
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
+	.set_to_rmii = rk3568_set_to_rmii,
 	.set_to_rgmii = rk3568_set_to_rgmii,
+	.set_to_sgmii = rk3568_set_to_sgmii,
+
 	.set_speed = rk_set_clk_mac_speed,
 
 	.gmac_phy_intf_sel_mask = GENMASK_U16(6, 4),
 
-	.supports_rmii = true,
-
 	.regs_valid = true,
 	.regs = {
 		0xfe2a0000, /* gmac0 */
@@ -1211,6 +1239,44 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
 		dev_err(bsp_priv->dev, "fail to disable phy-supply\n");
 }
 
+static int rk_pcs_init(struct stmmac_priv *priv)
+{
+	struct rk_priv_data *bsp_priv = priv->plat->bsp_priv;
+	struct device_node *node = priv->device->of_node;
+	struct device_node *pcs_node;
+	struct dw_xpcs *xpcs;
+
+	pcs_node = of_parse_phandle(node, "pcs-handle", 0);
+	if (!pcs_node)
+		return -ENODEV;
+
+	xpcs = xpcs_rk_create(priv->device, pcs_node, bsp_priv->id);
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
@@ -1333,6 +1399,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->supports_rgmii = ops->supports_rgmii || !!ops->set_to_rgmii;
 	bsp_priv->supports_rmii = ops->supports_rmii || !!ops->set_to_rmii;
+	bsp_priv->supports_sgmii = ops->supports_sgmii || !!ops->set_to_sgmii;
 
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
@@ -1364,6 +1431,10 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
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
@@ -1382,16 +1453,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
@@ -1402,10 +1476,8 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
@@ -1413,13 +1485,12 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
@@ -1450,15 +1521,20 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
 
@@ -1466,6 +1542,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
 
 	return 0;
+
+clk_disable:
+	gmac_clk_enable(bsp_priv, false);
+	return ret;
 }
 
 static void rk_gmac_powerdown(struct rk_priv_data *gmac)
@@ -1605,6 +1685,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
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

