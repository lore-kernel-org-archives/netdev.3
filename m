Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7553EC82D;
	Mon, 17 Aug 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974494; cv=none; b=py9cf5DGMUazn65EmhN1u16AkSqlITwYoKqt8TW/OBKw752dodN9KHamKNeGs+Is1xIahwQ0oDsPsgC3BDYNP0u8teDZCnqe+x7ewesOOVcBRrhD6fN7IJdih1HtZK/wSo4qHXLWkeowIHv+1oeaDdgChdk0s0sYiO4t1KOTRiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974494; c=relaxed/simple;
	bh=koAxUZc6064oY8Qj9KTxo8M/QTLJ8sPVcEGL8PJ7jXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I78GrfTnICW3zdMBTgb/9+NwrepuBLFyzA+oRZHIQmrhcCSsMMaXjpJLQYcdQ0yvltegJ0g9kIs8VFGQgun+/R2yBBBQ33RdS6yUxPDDyurTpNv97L1FGLRgOqRe6Fgr4u97zAncUQxyc8ATLEZgcCdyepPq6fSbaNyNWWT03IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 43D922021FF;
	Mon, 17 Aug 2026 15:47:59 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wvxh1-001xpY-0V;
	Mon, 17 Aug 2026 15:47:59 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wvxh1-0000000HYA5-0JkU;
	Mon, 17 Aug 2026 15:47:59 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v1 2/2] net: dsa: realtek: rtl8365mb: add EEE support
Date: Mon, 17 Aug 2026 15:47:58 +0200
Message-ID: <20260817134758.4182833-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260817134758.4182833-1-o.rempel@pengutronix.de>
References: <20260817134758.4182833-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add EEE support on the integrated-PHY ports, controllable per port via
ethtool.

The integrated PHYs have no MMD registers; their EEE registers live in the
switch's OCP space. phylib accesses EEE as MMD registers, so add
phy_{read,write}_c45 realtek_ops that map those MMD accesses onto their OCP
addresses, wired as the user MII bus C45 handlers when the chip provides
them (rtl8366rb etc. unaffected).

The hardware manages LPI on its own, so advertise EEE to phylink with
no-op mac_{en,dis}able_tx_lpi callbacks. The LPI timer is a single global
per-speed register, so .set_mac_eee rejects the per-port TX LPI knobs
rather than silently ignoring them.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/realtek/realtek.h        |   4 +
 drivers/net/dsa/realtek/rtl8365mb_main.c | 123 +++++++++++++++++++++++
 drivers/net/dsa/realtek/rtl83xx.c        |  20 ++++
 3 files changed, 147 insertions(+)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 75a127545e5d..1c0ca6daf545 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -156,6 +156,10 @@ struct realtek_ops {
 	int	(*phy_read)(struct realtek_priv *priv, int phy, int regnum);
 	int	(*phy_write)(struct realtek_priv *priv, int phy, int regnum,
 			     u16 val);
+	int	(*phy_read_c45)(struct realtek_priv *priv, int phy, int devad,
+				int regnum);
+	int	(*phy_write_c45)(struct realtek_priv *priv, int phy, int devad,
+				 int regnum, u16 val);
 };
 
 struct realtek_variant {
diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 4c305756116c..f1bb883a5585 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -101,6 +101,7 @@
 #include <linux/regmap.h>
 #include <linux/if_bridge.h>
 #include <linux/if_vlan.h>
+#include <linux/mdio.h>
 #include <linux/phylink.h>
 
 #include "realtek.h"
@@ -202,6 +203,10 @@
 /* The PHY OCP addresses of PHY registers 0~31 start here */
 #define RTL8365MB_PHY_OCP_ADDR_PHYREG_BASE		0xA400
 
+#define RTL8365MB_PHY_OCP_ADDR_EEE_ABLE			0xA5C4
+#define RTL8365MB_PHY_OCP_ADDR_EEE_ADV			0xA5D0
+#define RTL8365MB_PHY_OCP_ADDR_EEE_LPABLE		0xA5D2
+
 /* External interface port mode values - used in DIGITAL_INTERFACE_SELECT */
 #define RTL8365MB_EXT_PORT_MODE_DISABLE		0
 #define RTL8365MB_EXT_PORT_MODE_RGMII		1
@@ -1040,6 +1045,66 @@ static int rtl8365mb_phy_write(struct realtek_priv *priv, int phy, int regnum,
 	return 0;
 }
 
+static int rtl8365mb_phy_read_c45(struct realtek_priv *priv, int phy, int devad,
+				  int regnum)
+{
+	u32 ocp_addr;
+	u16 val;
+	int ret;
+
+	if (phy > RTL8365MB_PHYADDRMAX)
+		return -EINVAL;
+
+	if (devad == MDIO_MMD_PCS && regnum == MDIO_PCS_EEE_ABLE)
+		ocp_addr = RTL8365MB_PHY_OCP_ADDR_EEE_ABLE;
+	else if (devad == MDIO_MMD_AN && regnum == MDIO_AN_EEE_ADV)
+		ocp_addr = RTL8365MB_PHY_OCP_ADDR_EEE_ADV;
+	else if (devad == MDIO_MMD_AN && regnum == MDIO_AN_EEE_LPABLE)
+		ocp_addr = RTL8365MB_PHY_OCP_ADDR_EEE_LPABLE;
+	else
+		/* Only the EEE registers are mapped; others read as 0, as the
+		 * hardware does, so the generic MMD code is not tripped up by
+		 * an error.
+		 */
+		return 0;
+
+	ret = rtl8365mb_phy_ocp_read(priv, phy, ocp_addr, &val);
+	if (ret) {
+		dev_err(priv->dev,
+			"failed to read PHY%d OCP %04x, ret %d\n", phy, ocp_addr,
+			ret);
+		return ret;
+	}
+
+	return val;
+}
+
+static int rtl8365mb_phy_write_c45(struct realtek_priv *priv, int phy,
+				   int devad, int regnum, u16 val)
+{
+	int ret;
+
+	if (phy > RTL8365MB_PHYADDRMAX)
+		return -EINVAL;
+
+	/* Only the EEE advertisement register is writable; writes to other
+	 * registers are ignored, as the hardware does.
+	 */
+	if (devad != MDIO_MMD_AN || regnum != MDIO_AN_EEE_ADV)
+		return 0;
+
+	ret = rtl8365mb_phy_ocp_write(priv, phy, RTL8365MB_PHY_OCP_ADDR_EEE_ADV,
+				      val);
+	if (ret) {
+		dev_err(priv->dev,
+			"failed to write PHY%d OCP %04x, ret %d\n", phy,
+			RTL8365MB_PHY_OCP_ADDR_EEE_ADV, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct rtl8365mb_extint *
 rtl8365mb_get_port_extint(struct realtek_priv *priv, int port)
 {
@@ -1639,6 +1704,14 @@ static void rtl8365mb_phylink_get_caps(struct dsa_switch *ds, int port,
 		 */
 		__set_bit(PHY_INTERFACE_MODE_GMII,
 			  config->supported_interfaces);
+
+		/* Integrated PHYs support EEE at 100M/1G; the hardware manages
+		 * LPI on its own, so just advertise LPI awareness to phylink.
+		 */
+		memcpy(config->lpi_interfaces, config->supported_interfaces,
+		       sizeof(config->lpi_interfaces));
+		config->lpi_capabilities = MAC_100FD | MAC_1000FD;
+		config->eee_enabled_default = true;
 		return;
 	}
 
@@ -3275,18 +3348,66 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 	return 0;
 }
 
+static int rtl8365mb_phylink_mac_enable_tx_lpi(struct phylink_config *config,
+					       u32 timer, bool tx_clock_stop)
+{
+	/* The hardware manages LPI itself; there is no MAC-level LPI control.
+	 * This callback only signals LPI awareness to phylink.
+	 */
+	return 0;
+}
+
+static void rtl8365mb_phylink_mac_disable_tx_lpi(struct phylink_config *config)
+{
+}
+
 static const struct phylink_mac_ops rtl8365mb_phylink_mac_ops = {
 	.mac_select_pcs = rtl8365mb_phylink_mac_select_pcs,
 	.mac_config = rtl8365mb_phylink_mac_config,
 	.mac_link_down = rtl8365mb_phylink_mac_link_down,
 	.mac_link_up = rtl8365mb_phylink_mac_link_up,
+	.mac_enable_tx_lpi = rtl8365mb_phylink_mac_enable_tx_lpi,
+	.mac_disable_tx_lpi = rtl8365mb_phylink_mac_disable_tx_lpi,
 };
 
+static bool rtl8365mb_support_eee(struct dsa_switch *ds, int port)
+{
+	/* Only integrated-PHY ports support EEE, not the external RGMII ports. */
+	return !rtl8365mb_get_port_extint(ds->priv, port);
+}
+
+static int rtl8365mb_set_mac_eee(struct dsa_switch *ds, int port,
+				 struct ethtool_keee *e)
+{
+	struct realtek_priv *priv = ds->priv;
+
+	/* The only LPI timing control (tx_lpi_timer) is a single global
+	 * per-speed register shared by all ports, so it cannot be set from this
+	 * per-port callback; leave it at its reset default. Per-port EEE is
+	 * driven through the PHY advertisement. Reject the per-port TX LPI knobs
+	 * rather than silently ignoring them.
+	 */
+	if (!e->tx_lpi_enabled) {
+		dev_err(priv->dev, "disabling EEE TX LPI is not supported\n");
+		return -EINVAL;
+	}
+
+	if (e->tx_lpi_timer) {
+		dev_err(priv->dev,
+			"setting the EEE TX LPI timer is not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct dsa_switch_ops rtl8365mb_switch_ops = {
 	.get_tag_protocol = rtl8365mb_get_tag_protocol,
 	.change_tag_protocol = rtl8365mb_change_tag_protocol,
 	.setup = rtl8365mb_setup,
 	.teardown = rtl8365mb_teardown,
+	.support_eee = rtl8365mb_support_eee,
+	.set_mac_eee = rtl8365mb_set_mac_eee,
 	.phylink_get_caps = rtl8365mb_phylink_get_caps,
 	.port_bridge_join = rtl83xx_port_bridge_join,
 	.port_bridge_leave = rtl83xx_port_bridge_leave,
@@ -3332,6 +3453,8 @@ static const struct realtek_ops rtl8365mb_ops = {
 	.l2_flush = rtl8365mb_l2_flush,
 	.phy_read = rtl8365mb_phy_read,
 	.phy_write = rtl8365mb_phy_write,
+	.phy_read_c45 = rtl8365mb_phy_read_c45,
+	.phy_write_c45 = rtl8365mb_phy_write_c45,
 };
 
 static const char *const rtl8365mb_supplies[] = {
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 8121ec12fd8b..ad42c05d0a88 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -62,6 +62,22 @@ static int rtl83xx_user_mdio_write(struct mii_bus *bus, int addr, int regnum,
 	return priv->ops->phy_write(priv, addr, regnum, val);
 }
 
+static int rtl83xx_user_mdio_read_c45(struct mii_bus *bus, int addr, int devad,
+				      int regnum)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_read_c45(priv, addr, devad, regnum);
+}
+
+static int rtl83xx_user_mdio_write_c45(struct mii_bus *bus, int addr, int devad,
+				       int regnum, u16 val)
+{
+	struct realtek_priv *priv = bus->priv;
+
+	return priv->ops->phy_write_c45(priv, addr, devad, regnum, val);
+}
+
 /**
  * rtl83xx_setup_user_mdio() - register the user mii bus driver
  * @ds: DSA switch associated with this user_mii_bus
@@ -95,6 +111,10 @@ int rtl83xx_setup_user_mdio(struct dsa_switch *ds)
 	bus->name = "Realtek user MII";
 	bus->read = rtl83xx_user_mdio_read;
 	bus->write = rtl83xx_user_mdio_write;
+	if (priv->ops->phy_read_c45)
+		bus->read_c45 = rtl83xx_user_mdio_read_c45;
+	if (priv->ops->phy_write_c45)
+		bus->write_c45 = rtl83xx_user_mdio_write_c45;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s:user_mii", dev_name(priv->dev));
 	bus->parent = priv->dev;
 
-- 
2.47.3

