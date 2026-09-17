Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9C4399E5;
	Thu, 17 Sep 2026 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633712; cv=none; b=m76yCKs2DznTH9/GbLcMZgqo8ZttxlKLyInj5FJtCdaKwdruKvq3IuCxFgujiOCv5Ytl6C5VTk/2pMqaAL+oYaP4j8Nv7IuPSMw0do0jOrEW/SUejaV73kOTkv9pXumnfVl7K4uJuhLFSdthjMcLEy+CQgYLQ/wpQ4hWTcejpec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633712; c=relaxed/simple;
	bh=7A4sl3+qjb5z44K+7Tq5iYe74l00G6c3FnwbAXMtjRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4CMuLtWhkMLFgWdFUD/PyQp0zpPLpcOFpdKQP22WF0Yu+wFzkI7G5c3xtl1g7p03hbwDBCj0m1FrC2yb4ej9BxyJuTq4WNoWmlhTGvaMU9JBGEScSko5+hHVJFCbZBGHaihACu52o7d1CinOt/5Br1K8BazngwqwZ86ynTI4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0882142-0.000734061-0.911052;FP=15184871686268471988|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jFhn60v_1789633367;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jFhn60v_1789633367 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:22:47 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v8 6/6] net: dsa: motorcomm: Add support for Motorcomm YT922x
Date: Thu, 17 Sep 2026 16:22:36 +0800
Message-Id: <20260917082236.3427168-7-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
References: <20260917082236.3427168-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Motorcomm YT922X, which is series of
ethernet switches developed by Motorcomm Electronic
Technology, includes YT9224 and YT9228.

This patch only adds support for the YT9224 variant.
YT9228 is not supported yet.

This patch adds basic support for a working DSA switch,
includes .port_setup, .setup, .phylink_get_caps,
.get_tag_protocol.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/Kconfig |   3 +-
 drivers/net/dsa/motorcomm/chip.c  | 686 +++++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/chip.h  |  93 ++++
 3 files changed, 777 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
index 79cdd79a1fd2..ab2b548c216f 100644
--- a/drivers/net/dsa/motorcomm/Kconfig
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_DSA_YT921X
-	tristate "Motorcomm YT9215 ethernet switch chip support"
+	tristate "Motorcomm YT9215 and YT9224 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_DSA_TAG_YT922X
 	select NET_IEEE8021Q_HELPERS if DCB
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 2412fe2f696f..1cf5e859d8af 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Driver for Motorcomm YT921x Switch
+ * Driver for Motorcomm YT921x and YT922x Switch
  *
  * Should work on YT9213/YT9214/YT9215/YT9218, but only tested on YT9215+SGMII,
  * be sure to do your own checks before porting to another chip.
@@ -38,6 +38,9 @@ struct yt921x_mib_desc {
 #define MIB_DESC(_size, _offset, _name) \
 	{_size, _offset, _name}
 
+#define pcs_to_yt921x_port(_pcs) container_of((_pcs), struct yt921x_port, pcs)
+#define yt921x_port_to_priv(pp) \
+	container_of_const((pp), struct yt921x_priv, ports[(pp)->index])
 /* Must agree with yt921x_mib
  *
  * Unstructured fields (name != NULL) will appear in get_ethtool_stats(),
@@ -112,6 +115,9 @@ struct yt921x_info {
 #define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
 #define YT921X_PORT_MASK_EXT0		BIT(8)
 #define YT921X_PORT_MASK_EXT1		BIT(9)
+#define YT922X_PORT_MASK_INTm_n(m, n)	GENMASK((n), (m))
+#define YT922X_PORT_MASK_EXT0		BIT(0)
+#define YT922X_PORT_MASK_EXT1		BIT(8)
 
 static const struct yt921x_info yt921x_infos[] = {
 	{
@@ -149,9 +155,17 @@ static const struct yt921x_info yt921x_infos[] = {
 		YT921X_PORT_MASK_INT0_n(8),
 		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
 	},
+	{
+		"YT9224", YT9224_MAJOR, 0, 0,
+		YT922X_PORT_MASK_INTm_n(4, 7),
+		YT922X_PORT_MASK_EXT0 | YT922X_PORT_MASK_EXT1,
+	},
 	{}
 };
 
+/* Define top ext addr */
+#define YT922X_COMMON_EXT_PHYADDR	9
+
 #define YT921X_VID_UNWARE	4095
 
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
@@ -4240,6 +4254,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 	}
 }
 
+static bool yt921x_needs_extmode_check(u32 major)
+{
+	return (major == YT9224_MAJOR) ? false : true;
+}
+
 static int yt921x_chip_detect(struct yt921x_priv *priv)
 {
 	struct device *dev = to_device(priv);
@@ -4265,6 +4284,9 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 		return -ENODEV;
 	}
 
+	if (!yt921x_needs_extmode_check(major))
+		goto skip_extmode_check;
+
 	res = yt921x_reg_read(priv, YT921X_CHIP_MODE, &mode);
 	if (res)
 		return res;
@@ -4304,6 +4326,15 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 
 	priv->info = info;
 
+	return 0;
+
+skip_extmode_check:
+	dev_info(dev,
+		 "Motorcomm %s ethernet switch, chipid: 0x%x\n",
+		 info->name, chipid);
+
+	priv->info = info;
+
 	return 0;
 }
 
@@ -4694,6 +4725,637 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.setup			= yt921x_dsa_setup,
 };
 
+static int yt922x_port_down(struct yt921x_priv *priv, int port)
+{
+	u32 mask;
+	int res;
+
+	/* mac force down */
+	mask = YT922X_PORT_LINK | YT922X_PORT_RX_MAC_EN |
+		YT922X_PORT_TX_MAC_EN | YT922X_PORT_LINK_AN;
+	res = yt921x_reg_clear_bits(priv, YT922X_PORTn_CTRL(port), mask);
+	if (res)
+		return res;
+	/* Need force op to make soft configuration effective */
+	mask = YT922X_PORT_FORCE_OP;
+	res = yt921x_reg_set_bits(priv, YT922X_PORTn_CTRL(port), mask);
+	if (res)
+		return res;
+
+	/* disable en_phy */
+	res = yt921x_reg_clear_bits(priv, YT922X_EN_PHY_VALUE, BIT(port));
+	if (res)
+		return res;
+	res = yt921x_reg_set_bits(priv, YT922X_EN_PHY_OVERWRITE, BIT(port));
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static void
+yt922x_phylink_mac_link_down(struct phylink_config *config, unsigned int mode,
+			     phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	int port = dp->index;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_port_down(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring down",
+			port, res);
+}
+
+static int
+yt922x_port_up(struct yt921x_priv *priv, int port, unsigned int mode,
+	       phy_interface_t interface, int speed, int duplex,
+	       bool tx_pause, bool rx_pause)
+{
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	switch (speed) {
+	case SPEED_10:
+		ctrl = YT921X_PORT_SPEED_10;
+		break;
+	case SPEED_100:
+		ctrl = YT921X_PORT_SPEED_100;
+		break;
+	case SPEED_1000:
+		ctrl = YT921X_PORT_SPEED_1000;
+		break;
+	case SPEED_2500:
+		ctrl = YT921X_PORT_SPEED_2500;
+		break;
+	case SPEED_5000:
+		ctrl = YT921X_PORT_SPEED_5000;
+		break;
+	case SPEED_10000:
+		ctrl = YT921X_PORT_SPEED_10000;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (duplex == DUPLEX_FULL)
+		ctrl |= YT922X_PORT_DUPLEX_FULL;
+	if (tx_pause)
+		ctrl |= YT922X_PORT_TX_PAUSE;
+	if (rx_pause)
+		ctrl |= YT922X_PORT_RX_PAUSE;
+	ctrl |= YT922X_PORT_RX_MAC_EN | YT922X_PORT_TX_MAC_EN |
+		YT922X_PORT_CFG_TX_EN | YT922X_PORT_LINK |
+		YT922X_PORT_CFG_RX_EN;
+	ctrl &= ~(YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN);
+	res = yt921x_reg_write(priv, YT922X_PORTn_CTRL(port), ctrl);
+	if (res)
+		return res;
+
+	/* force op */
+	mask = YT922X_PORT_FORCE_OP;
+	res = yt921x_reg_set_bits(priv, YT922X_PORTn_CTRL(port), mask);
+	if (res)
+		return res;
+
+	/* enable en_phy */
+	res = yt921x_reg_set_bits(priv, YT922X_EN_PHY_VALUE, BIT(port));
+	if (res)
+		return res;
+	res = yt921x_reg_set_bits(priv, YT922X_EN_PHY_OVERWRITE, BIT(port));
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static void
+yt922x_phylink_mac_link_up(struct phylink_config *config,
+			   struct phy_device *phydev, unsigned int mode,
+			   phy_interface_t interface, int speed, int duplex,
+			   bool tx_pause, bool rx_pause)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+	int port = dp->index;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_port_up(priv, port, mode, interface, speed, duplex,
+			     tx_pause, rx_pause);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "bring up",
+			port, res);
+}
+
+static int
+yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg, u16 val)
+{
+	int res;
+
+	if (port > priv->series->max_ports)
+		return -ENODEV;
+
+	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
+	if (res)
+		return res;
+
+	res = yt921x_intif_write(priv, port, YT92XX_PAGE, val);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int
+yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg, u16 *valp)
+{
+	int res;
+
+	if (port > priv->series->max_ports)
+		return -ENODEV;
+
+	res = yt921x_intif_write(priv, port, YT92XX_PAGE_SELECT, reg);
+	if (res)
+		return res;
+
+	res = yt921x_intif_read(priv, port, YT92XX_PAGE, valp);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int yt922x_sds_phyaddr_get(int port,
+				  enum yt922x_phy_reg_type reg_type)
+{
+	/*
+	 * sds phyaddr mapping depend on reg_type
+	 */
+	if (!yt922x_port_is_internal_sds(port))
+		return -EOPNOTSUPP;
+	if (reg_type == YT922X_PHY_REG_TYPE_COMMON_EXT)
+		return YT922X_COMMON_EXT_PHYADDR;
+
+	return port;
+}
+
+static void
+yt922x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+}
+
+static struct phylink_pcs *
+yt922x_phylink_mac_select_pcs(struct phylink_config *config,
+			      phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return &priv->ports[dp->index].pcs;
+
+	default:
+		return NULL;
+	}
+}
+
+static const struct phylink_mac_ops yt922x_phylink_mac_ops = {
+	.mac_select_pcs = yt922x_phylink_mac_select_pcs,
+	.mac_link_down = yt922x_phylink_mac_link_down,
+	.mac_link_up = yt922x_phylink_mac_link_up,
+	.mac_config = yt922x_phylink_mac_config,
+};
+
+static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 struct phylink_link_state *state)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	int port = pp->index;
+	int res = 0;
+	u16 data;
+	int addr;
+	u16 lp;
+
+	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
+	if (addr < 0) {
+		state->link = false;
+		return;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+		res = yt921x_intif_read(priv, addr, MII_BMSR, &data);
+		if (res)
+			goto err;
+		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
+		if (res)
+			goto err;
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, data, lp);
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		res = yt921x_intif_read(priv, addr, YT922X_PCS_LINK_CTRL,
+					&data);
+		if (res)
+			goto err;
+		state->link =  FIELD_GET(YT922X_PCS_LINK_STATUS, data);
+		state->an_complete = FIELD_GET(YT922X_PCS_AN_COMPLETE, data);
+		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
+		if (res)
+			goto err;
+		if (state->link)
+			phylink_decode_usxgmii_word(state, lp);
+		break;
+	default:
+		state->link = false;
+		break;
+	}
+	mutex_unlock(&priv->reg_lock);
+	return;
+err:
+	mutex_unlock(&priv->reg_lock);
+	state->link = false;
+}
+
+static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	struct device *dev = to_device(priv);
+	int port = pp->index;
+	u16 data;
+	int addr;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	addr = yt922x_sds_phyaddr_get
+		(port, YT922X_PHY_REG_TYPE_MII);
+	if (addr < 0) {
+		res = addr;
+		goto err;
+	}
+	res = yt921x_intif_read(priv, addr, MII_BMCR, &data);
+	if (res)
+		goto err;
+	data |= BMCR_ANRESTART;
+	res = yt921x_intif_write(priv, addr, MII_BMCR, data);
+	if (res)
+		goto err;
+	mutex_unlock(&priv->reg_lock);
+	return;
+
+err:
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		dev_err(dev, "Failed to %s PCS port %d: %i\n", "an restart",
+			port, res);
+}
+
+static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	int res, port;
+	u16 data;
+	u16 ctrl;
+	int addr;
+
+	port = pp->index;
+	if (!yt922x_port_is_internal_sds(port))
+		return -EINVAL;
+
+	mutex_lock(&priv->reg_lock);
+	addr = yt922x_sds_phyaddr_get
+		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT);
+	if (addr < 0) {
+		res = addr;
+		goto err;
+	}
+	/* write protect */
+	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
+	if (res)
+		goto err;
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		ctrl = YT922X_SERDES_MODE_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		ctrl = YT922X_SERDES_MODE_1000BASEX;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		ctrl = YT922X_SERDES_MODE_2500BASEX;
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		ctrl = YT922X_SERDES_MODE_USXGMII;
+		break;
+	default:
+		res = -EINVAL;
+		goto err;
+	}
+	res = yt921x_intif_ext_read(priv, addr, YT922X_PORT_SDSn, &data);
+	if (res)
+		goto err;
+	data &= ~YT922X_SERDES_MODE_M;
+	data |= ctrl;
+	res = yt921x_intif_ext_write(priv, addr, YT922X_PORT_SDSn, data);
+	if (res)
+		goto err;
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+
+err:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static const struct phylink_pcs_ops yt922x_pcs_ops = {
+	.pcs_get_state = yt922x_pcs_get_state,
+	.pcs_config = yt922x_pcs_config,
+	.pcs_an_restart = yt922x_pcs_an_restart,
+};
+
+static enum dsa_tag_protocol
+yt922x_dsa_get_tag_protocol(struct dsa_switch *ds, int port,
+			    enum dsa_tag_protocol m)
+{
+	return DSA_TAG_PROTO_YT922X;
+}
+
+static void
+yt922x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
+			    struct phylink_config *config)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	const struct yt921x_info *info = priv->info;
+
+	config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+				   MAC_10 | MAC_100 | MAC_1000;
+
+	if (info->internal_mask & BIT(port)) {
+		/* port 4 to port 7, internal utp */
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+	}
+	if (info->external_mask & BIT(port)) {
+		/* serdes */
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_2500FD;
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  config->supported_interfaces);
+		config->mac_capabilities |= MAC_5000FD;
+		config->mac_capabilities |= MAC_10000FD;
+	}
+}
+
+static int yt922x_port_setup(struct yt921x_priv *priv, int port)
+{
+	struct dsa_switch *ds = &priv->ds;
+	u32 mask;
+	u32 ctrl;
+	int res;
+
+	/* enable user port isolation and disable fdb learning */
+	ctrl = ~priv->cpu_ports_mask;
+	res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port), ctrl);
+	if (res)
+		return res;
+
+	mask = YT922X_PORT_LEARN_DIS;
+	res = yt921x_reg_set_bits(priv, YT922X_PORTn_LEARN(port), mask);
+	if (res)
+		return res;
+
+	if (dsa_is_cpu_port(ds, port)) {
+		ctrl = ~(u32)0;
+		res = yt921x_reg_write(priv, YT922X_PORTn_ISOLATION(port),
+				       ctrl);
+		if (res)
+			return res;
+	}
+
+	return 0;
+}
+
+static int yt922x_dsa_port_setup(struct dsa_switch *ds, int port)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_port_setup(priv, port);
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int yt922x_cpu_tag_mode_set_8b(struct yt921x_priv *priv)
+{
+	u32 val;
+	u32 val1;
+	int res;
+
+	/* cpu tag mode set to 8b */
+	res = yt921x_reg_read(priv, YT922X_CPU_TAG_RX_CTRL, &val);
+	if (res)
+		return res;
+	res = yt921x_reg_read(priv, YT922X_CPU_TAG_TX_CTRL, &val1);
+	if (res)
+		return res;
+	val &= ~YT922X_CPU_TAG_RX_MODE;
+	val1 &= ~YT922X_CPU_TAG_TX_MODE;
+	val1 &= ~YT922X_CPU_TAG_TX_TYPE;
+	res = yt921x_reg_write(priv, YT922X_CPU_TAG_RX_CTRL, val);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT922X_CPU_TAG_TX_CTRL, val1);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int yt922x_cpu_port_set(struct yt921x_priv *priv)
+{
+	struct dsa_switch *ds = &priv->ds;
+	u32 ctrl;
+	int res;
+
+	/* cpu tag mode */
+	res = yt922x_cpu_tag_mode_set_8b(priv);
+	if (res)
+		return res;
+
+	/* Enable DSA */
+	priv->cpu_ports_mask = dsa_cpu_ports(ds);
+	ctrl = YT921X_EXT_CPU_PORT_TAG_EN | YT921X_EXT_CPU_PORT_PORT_EN |
+	       YT921X_EXT_CPU_PORT_PORT(__ffs(priv->cpu_ports_mask));
+	res = yt921x_reg_write(priv, YT921X_EXT_CPU_PORT, ctrl);
+	if (res)
+		return res;
+
+	/* Setup software switch */
+	ctrl = YT922X_CPU_COPY_TO_EXT_CPU;
+	res = yt921x_reg_write(priv, YT922X_CPU_COPY, ctrl);
+	if (res)
+		return res;
+
+	return res;
+}
+
+static int yt922x_chip_setup_dsa(struct yt921x_priv *priv)
+{
+	unsigned long cpu_ports_mask;
+	u32 ctrl;
+	int port;
+	int res;
+
+	/* cpu port set */
+	res = yt922x_cpu_port_set(priv);
+	if (res)
+		return res;
+
+	ctrl = GENMASK(8, 0);
+	res = yt921x_reg_write(priv, YT922X_FILTER_UNK_UCAST, ctrl);
+	if (res)
+		return res;
+
+	ctrl = 0;
+	for (int i = 0; i < priv->series->max_ports; i++)
+		ctrl |= YT922X_ACT_UNK_ACTn_TRAP(i);
+	cpu_ports_mask = priv->cpu_ports_mask;
+	for_each_set_bit(port, &cpu_ports_mask, priv->series->max_ports) {
+		ctrl &= ~YT922X_ACT_UNK_ACTn_M(port);
+		ctrl |= YT922X_ACT_UNK_ACTn_DROP(port);
+	}
+	res = yt921x_reg_write(priv, YT922X_ACT_UNK_UCAST, ctrl);
+	if (res)
+		return res;
+	res = yt921x_reg_write(priv, YT922X_ACT_UNK_MCAST, ctrl);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static int yt922x_chip_setup(struct yt921x_priv *priv)
+{
+	u32 ctrl;
+	int res;
+
+	ctrl = YT922X_FUNC_MIB | YT922X_FUNC_ACL;
+	res = yt921x_reg_set_bits(priv, YT921X_FUNC, ctrl);
+	if (res)
+		return res;
+
+	res = yt922x_chip_setup_dsa(priv);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static void yt922x_pcs_setup(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	const struct yt921x_info *info = priv->info;
+	unsigned long mask;
+	int port;
+
+	mask = info->external_mask;
+	for_each_set_bit(port, &mask, priv->series->max_ports) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		pp->pcs.ops = &yt922x_pcs_ops;
+		pp->pcs.poll = true;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  pp->pcs.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  pp->pcs.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  pp->pcs.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  pp->pcs.supported_interfaces);
+	}
+}
+
+static int yt922x_dsa_setup(struct dsa_switch *ds)
+{
+	struct yt921x_priv *priv = to_yt921x_priv(ds);
+	struct device *dev = to_device(priv);
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int res;
+
+	/* pp index init */
+	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		pp->index = i;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_chip_reset(priv);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	/* Register the internal mdio bus. */
+	child = of_get_child_by_name(np, "mdio");
+	if (child) {
+		res = yt921x_mbus_int_init(priv, child);
+		of_node_put(child);
+		if (res)
+			return res;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_chip_setup(priv);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	/* switch sds pcs setup */
+	yt922x_pcs_setup(ds);
+
+	return 0;
+}
+
+static const struct dsa_switch_ops yt922x_dsa_switch_ops = {
+	/* port */
+	.get_tag_protocol = yt922x_dsa_get_tag_protocol,
+	.phylink_get_caps = yt922x_dsa_phylink_get_caps,
+	.port_setup  = yt922x_dsa_port_setup,
+	/* chip */
+	.setup   = yt922x_dsa_setup,
+};
+
 static const struct yt92xx_series yt92xx_series_table[] = {
 	[YT92XX_MODE_YT921X] = {
 		.mode = YT92XX_MODE_YT921X,
@@ -4707,12 +5369,26 @@ static const struct yt92xx_series yt92xx_series_table[] = {
 		.switch_ops = &yt921x_dsa_switch_ops,
 		.mac_ops = &yt921x_phylink_mac_ops
 	},
+	[YT92XX_MODE_YT922X] = {
+		.mode = YT92XX_MODE_YT922X,
+		.name = "YT922x",
+		.max_ports = YT922X_PORT_NUM,
+		.num_lag_ids = YT922X_LAG_NUM,
+		.ageing_time_min = 1 * 6000,
+		.ageing_time_max = U16_MAX * 6000,
+		.dscp_prio_mapping_is_global = true,
+		.assisted_learning_on_cpu_port = true,
+		.switch_ops = &yt922x_dsa_switch_ops,
+		.mac_ops = &yt922x_phylink_mac_ops,
+	},
 };
 
 static const struct yt92xx_series *yt92xx_series_lookup(u32 major)
 {
 	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
 		return &yt92xx_series_table[YT92XX_MODE_YT921X];
+	else if (major == YT9224_MAJOR)
+		return &yt92xx_series_table[YT92XX_MODE_YT922X];
 	else
 		return NULL;
 }
@@ -4825,8 +5501,9 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 }
 
 static const struct of_device_id yt921x_of_match[] = {
-	{ .compatible = "motorcomm,yt9215" },
-	{}
+	{ .compatible = "motorcomm,yt9215", },
+	{ .compatible = "motorcomm,yt9224", },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, yt921x_of_match);
 
@@ -4843,5 +5520,6 @@ static struct mdio_driver yt921x_mdio_driver = {
 mdio_module_driver(yt921x_mdio_driver);
 
 MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-MODULE_DESCRIPTION("Driver for Motorcomm YT921x Switch");
+MODULE_AUTHOR("Kyle Switch <kyle.switch@motor-comm.com>");
+MODULE_DESCRIPTION("Driver for Motorcomm YT921x and YT922x Switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index c446aea449ed..dc8ef6dd4bd5 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -111,6 +111,7 @@
 #define   YT921X_PORT_SPEED_1000			YT921X_PORT_SPEED(2)
 #define   YT921X_PORT_SPEED_10000			YT921X_PORT_SPEED(3)
 #define   YT921X_PORT_SPEED_2500			YT921X_PORT_SPEED(4)
+#define   YT921X_PORT_SPEED_5000			YT921X_PORT_SPEED(5)
 #define YT921X_PON_STRAP_FUNC		0x80320
 #define YT921X_PON_STRAP_VAL		0x80324
 #define YT921X_PON_STRAP_CAP		0x80328
@@ -837,6 +838,7 @@ enum yt921x_fdb_entry_status {
 
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
+#define YT9224_MAJOR	0x9004
 
 /* required for a hard reset */
 #define YT921X_RST_DELAY_US	10000
@@ -861,6 +863,96 @@ enum yt921x_fdb_entry_status {
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
+/* yt922x register lists */
+#define YT92XX_PAGE_SELECT	0x1e
+#define YT92XX_PAGE		0x1f
+#define YT922X_PORTn_STATUS(port)	(0x80200 + 4 * (port))
+#define  YT922X_PORT_LINK_STATE			BIT(8)
+#define  YT922X_PORT_LINK_DUPLEX		BIT(7)
+#define  YT922X_PORT_RX_FC_EN			BIT(6)
+#define  YT922X_PORT_TX_FC_EN			BIT(5)
+#define YT922X_PORT_SPEED_10		0
+#define YT922X_PORT_SPEED_100		1
+#define YT922X_PORT_SPEED_1000		2
+#define YT922X_PORT_SPEED_10000		3
+#define YT922X_PORT_SPEED_2500		4
+#define YT922X_PORT_SPEED_5000		5
+#define YT922X_EN_PHY_OVERWRITE		(0x80040)
+#define YT922X_EN_PHY_VALUE		(0x8003c)
+/* CTRL: force op to make soft configuration effective */
+#define YT922X_PORTn_CTRL(port)		(0x80080 + 4 * (port))
+#define  YT922X_PORT_FORCE_OP			BIT(14)
+#define  YT922X_PORT_CFG_TX_EN			BIT(13)
+#define  YT922X_PORT_CFG_RX_EN			BIT(12)
+#define  YT922X_PORT_FC_AN			BIT(11)
+#define  YT922X_PORT_LINK_AN			BIT(10)  /* CTRL: auto negotiation */
+#define  YT922X_PORT_LINK			BIT(9)  /* CTRL: link status */
+#define  YT922X_PORT_HALF_PAUSE			BIT(8)  /* Half-duplex back pressure mode */
+#define  YT922X_PORT_DUPLEX_FULL		BIT(7)
+#define  YT922X_PORT_RX_PAUSE			BIT(6)
+#define  YT922X_PORT_TX_PAUSE			BIT(5)
+#define  YT922X_PORT_RX_MAC_EN			BIT(4)
+#define  YT922X_PORT_TX_MAC_EN			BIT(3)
+#define  YT922X_PORT_SPEED_M			GENMASK(2, 0)
+#define YT922X_PORT_SDSn	0x400
+#define  YT922X_SERDES_MODE_M		GENMASK(6, 4)
+#define   YT922X_SERDES_MODE(x)			FIELD_PREP(YT922X_SERDES_MODE_M, (x))
+#define YT922X_SERDES_MODE_SGMII	YT922X_SERDES_MODE(0)
+#define YT922X_SERDES_MODE_REVSGMII	YT922X_SERDES_MODE(1)
+#define YT922X_SERDES_MODE_1000BASEX	YT922X_SERDES_MODE(2)
+#define YT922X_SERDES_MODE_100BASEX	YT922X_SERDES_MODE(3)
+#define YT922X_SERDES_MODE_2500BASEX	YT922X_SERDES_MODE(4)
+#define YT922X_SERDES_MODE_USXGMII	YT922X_SERDES_MODE(6)
+#define YT922X_PORT_NUM		9
+#define YT922X_PCS_LINK_CTRL   0x11
+#define YT922X_PCS_LINK_STATUS  BIT(10)
+#define YT922X_PCS_AN_COMPLETE  BIT(11)
+
+/* LAG */
+#define YT922X_LAG_NUM		4
+/* ISO */
+#define YT922X_PORTn_ISOLATION(port)	(0x4 * (port) + 0x180d80)
+/* FDB */
+#define YT922X_PORTn_LEARN(port)	(0x180300 + 4 * (port))
+#define  YT922X_PORT_LEARN_DIS			BIT(18)
+/* GLOBAL CTRL */
+#define  YT922X_FUNC_ACL               BIT(5)
+#define  YT922X_FUNC_MIB               BIT(4)
+/* CTRL PKT */
+#define YT922X_FILTER_UNK_UCAST		0x180ec8
+#define YT922X_ACT_UNK_UCAST		0x180ed8
+#define YT922X_ACT_UNK_MCAST		0x180ee0
+#define  YT922X_ACT_UNK_MCAST_BYPASS_DROP_PIM	BIT(22)
+#define  YT922X_ACT_UNK_MCAST_BYPASS_DROP_MLD	BIT(21)
+#define  YT922X_ACT_UNK_MCAST_BYPASS_DROP_IGMP	BIT(20)
+#define  YT922X_ACT_UNK_ACTn_M(port)		GENMASK(2 * (port) + 1, 2 * (port))
+#define  YT922X_ACT_UNK_ACTn(port, x)		((x) << (2 * (port)))
+#define  YT922X_ACT_UNK_ACTn_FORWARD(port)	YT922X_ACT_UNK_ACTn(port, 0)  /* flood */
+#define  YT922X_ACT_UNK_ACTn_DROP(port)		YT922X_ACT_UNK_ACTn(port, 1)  /* discard */
+#define  YT922X_ACT_UNK_ACTn_TRAP(port)		YT922X_ACT_UNK_ACTn(port, 3)  /* steer to CPU */
+
+/* CPU PORT */
+#define YT922X_CPU_COPY			0x181100
+#define  YT922X_CPU_COPY_TO_INT_CPU		BIT(1)
+#define  YT922X_CPU_COPY_TO_EXT_CPU		BIT(0)
+#define YT922X_CPU_TAG_RX_CTRL		0x80504
+#define  YT922X_CPU_TAG_RX_MODE			BIT(0)
+#define YT922X_CPU_TAG_TX_CTRL		0x100710
+#define  YT922X_CPU_TAG_TX_TYPE			BIT(0)
+#define  YT922X_CPU_TAG_TX_MODE			BIT(1)
+#define  YT922X_CPU_TAG_TX_CTAG_OP		BIT(2)
+#define  YT922X_CPU_TAG_TX_STAG_OP		BIT(3)
+
+#define yt922x_port_is_internal_sds(port) ((port) == 0 || (port) == 8)
+
+enum yt922x_phy_reg_type {
+	YT922X_PHY_REG_TYPE_COMMON_EXT,
+	YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
+	YT922X_PHY_REG_TYPE_MII,
+	YT922X_PHY_REG_TYPE_EXT,
+	YT922X_PHY_REG_TYPE_MAX
+};
+
 struct yt921x_mib {
 	u64 rx_broadcast;
 	u64 rx_pause;
@@ -953,6 +1045,7 @@ struct yt921x_port {
 
 	struct yt921x_led *leds[YT921X_LED_GROUP_NUM];
 #endif
+	struct phylink_pcs pcs;
 };
 
 struct yt921x_reg_ops {
-- 
2.25.1

