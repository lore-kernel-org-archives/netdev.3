Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3CA40A920
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678109; cv=none; b=hbfkm2O48qlq+x0bN1iTPDsorA2jOYrVkmQgKqEaTFIrieWTyNpgPWLWWEqcb6xl9TB4CuQZLfu7exw2yseiSVL9rKmr/bQOOBfqsRpy6l+qdkCoFmahvu6t2bx0okscZMubaE9B11f2Az5xVqg6VezjlHJ1ICX9yC9WQA/SqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678109; c=relaxed/simple;
	bh=MXFdS/dUvSiAcRqIm0RyA3KPYXkr++PgYrKK8uH6q7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXD2gGXXTohB/clobrKLJLfayLMVyEwMaxyHKq5r9I9KkKA4qyDQ6wtp09vdpV9Jh5V+bcLEW1huMLFKw87pt3IuVkUrWVNoqMa+pVy8AnMMMYy3Yss1BCINS8WFsSw5vUl4Nwgcp79OIzBxgqo/8cWg9agCUVTQp4985lIMTrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3Ga8sL3; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3Ga8sL3"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-398da2bdcb9so30207a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678104; x=1790282904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iC03NBdaNc6vhu1NpYTcJvmpgqe0vchbrXQWmVX8P1s=;
        b=i3Ga8sL3DLNGo5RKfT+OqQ9lyYTE54s+qweC44P62h10nQZOG3pUtQ+LMakYnoScmQ
         DyqNyW3Cp4geqMFFBAYwOliqsVs9oSR2UozCyGZwu6zf+eXrme+1qU5OftGWfHxKZXj6
         5hEUbYV8ugK0TjROqjg62k2p/7kCZGZ7894X8wyP5cby9lAmW/Cj3BujhPdAORNFprVY
         Fw94JuOYobZgu0SciHOgBVThP2/7S3HDsOffGYYv898ISvbELz5LU5H9GANfcehv+c6t
         i3PqZo3I+xX9xs2sikNToJ0is7HTwhf/gMAwNXemCs662OvOhdKoChXr+cNHRnYG82Bn
         IyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678104; x=1790282904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iC03NBdaNc6vhu1NpYTcJvmpgqe0vchbrXQWmVX8P1s=;
        b=eR4+wPED8JbuWkM84P/U+H2D35NIuFmI6m36236+OHiG6at5SwR9Eb5b59+LOPYrhc
         RpKkh0YH5R4zx0CITvmasatoqoiNYMhBrF4rTEFfYqPDfd/c0ifh3+Oi5ET177C5VS18
         R14VKzy9ZHkyznxOkbX4MKwRjosanfxy3vLyHopex9ZO2+PTtMEU2Pzok8xIwd/5v5w/
         mk2U6rZzyBE45h203IwBydCl0VpXrpit2dHoop+SaV09morG5w+24iQcoCIHO0xNh/TJ
         laOS9HJrlrriYCgJJF/i2H0T6a/6LoIfYBQiz6u++DOx9UzX2/Wf9v+ZwAtzePkIo0K7
         60Ig==
X-Forwarded-Encrypted: i=1; AKwUvBxFLyLZbVVzEUDFlakSz0dEi3I/ktTWXn5yKnHseDjgS+Y5sJiVRDwW+IL8Kyo9Cs9r3cy3u8g=@vger.kernel.org
X-Gm-Message-State: AFuF++nmJDvUDrmhii21ETN0sUkPeCQHD4/SyaxyyPBw9UPYS5ihB47w
	6NqOW1WLicFixgl0CVB2k4wlUyzCru2aKrxCtNbQ4WiPZG6FHtAJbwXg
X-Gm-Gg: AYBFou14SX0ehY9qNuk2+LE4SAKdm043thXlpu0kA7a7AZIdO/RM3oyiGokKFf1isZ5
	3GoWgnqghI2eywkP4AGVXR7WLHPWJI2NYkfW0i0KU1BlTCfrRwo6Iu9OBwD/MzpUL0pLhJUfEph
	IQ5I+YzJ5bpEtWHCcy/PWmqO85sv28hyUPz0kbF517+BzYZ1zXk028YsOfJEPLOUXpiPtE0cUDj
	SHY/8VjZsbtTjGCBOaKHTX6U3F4h4fGsH/A4bTW/TKcRzCLur72LQ1oAW9VjmjFXTb1TiOnBi4w
	2pMCH1zEY0II9uWFkrHBrvFKFnXfuDVXvqKk2YiBAJ8urhzFu0W6RtyH1c1wH9sMs9HMLPcxpNq
	au3cX3AbnvDUHqz+YqN6EESJ0R6h+nr+FqPLnIIXpK75rnTiWDWbvFQ8ebuRZIV5+BSU6ZYvlhk
	H7D9UYBq+IPE7bp/hrX1RpIOU/iGyREXHeQTqkZh4y/WC5OUDq5rRYP9y+aUmM5/dvQ5EU+Q==
X-Received: by 2002:a17:90b:3b4b:b0:39d:f66e:1720 with SMTP id 98e67ed59e1d1-39e54eaf13cmr874575a91.13.1789678104435;
        Thu, 17 Sep 2026 13:48:24 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1232196a91.17.2026.09.17.13.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:48:23 -0700 (PDT)
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
Subject: [PATCH net-next v7 09/11] net: stmmac: dwmac-rk: add SGMII support for RK3568
Date: Fri, 18 Sep 2026 04:46:20 +0800
Message-ID: <20260917204624.2427486-10-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917204624.2427486-1-coiaprant@gmail.com>
References: <20260917204624.2427486-1-coiaprant@gmail.com>
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
select_pcs callback to return the XPCS to phylink. SGMII is not added
to rk_get_interfaces(): it comes from the XPCS's own
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
On RK3568, the MAC clock is fixed at 125 MHz and cannot be dynamically
changed by the stmmac core's set_clk_tx_rate callback.  In-band mode
works because the PCS handles rate adaptation internally.  Out-of-band
mode does not work because the MAC would need to change the clock rate
to 125/12.5/1.25 MHz for 1000/100/10 Mbps respectively, and the clock
is fixed.

Enable default_an_inband for SGMII and disable the generic stmmac
set_clk_tx_rate callback.  This forces phylink to use in-band mode,
where the PCS is responsible for speed/duplex negotiation.

Note that default_an_inband can be overridden by a fixed-link node,
and phylink may also fall back to out-of-band if the PHY does not
support in-band signalling.  Out-of-band SGMII is not supported by
this driver: the MAC clock would stay at 125 MHz for 10/100 Mbps,
giving working TX but failing RX.  Boards must use in-band mode
(managed = "in-band-status" or an in-band capable PHY).

Link: https://dl.radxa.com/rock3/docs/hw/datasheet/Rockchip%20RK3568%20TRM%20Part1%20V1.1-20210301.pdf (Page 386)
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/Kconfig   |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 130 +++++++++++++++---
 2 files changed, 111 insertions(+), 20 deletions(-)

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
index 8d7042e689261..88f09014e3a69 100644
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
@@ -1208,6 +1236,43 @@ static void rk_phy_powerdown(struct rk_priv_data *bsp_priv)
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
@@ -1330,6 +1395,7 @@ static struct rk_priv_data *rk_gmac_setup(struct platform_device *pdev,
 
 	bsp_priv->supports_rgmii = ops->supports_rgmii || !!ops->set_to_rgmii;
 	bsp_priv->supports_rmii = ops->supports_rmii || !!ops->set_to_rmii;
+	bsp_priv->supports_sgmii = ops->supports_sgmii || !!ops->set_to_sgmii;
 
 	if (ops->init) {
 		ret = ops->init(bsp_priv);
@@ -1361,6 +1427,10 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
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
@@ -1379,16 +1449,19 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
@@ -1399,10 +1472,8 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
@@ -1410,13 +1481,12 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
@@ -1447,15 +1517,20 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
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
 
@@ -1463,6 +1538,10 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		bsp_priv->ops->integrated_phy_powerup(bsp_priv);
 
 	return 0;
+
+clk_disable:
+	gmac_clk_enable(bsp_priv, false);
+	return ret;
 }
 
 static void rk_gmac_powerdown(struct rk_priv_data *gmac)
@@ -1602,6 +1681,17 @@ static int rk_gmac_probe(struct platform_device *pdev)
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

