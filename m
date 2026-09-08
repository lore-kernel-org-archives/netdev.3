Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D538655E;
	Tue,  8 Sep 2026 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856608; cv=none; b=e9NrvSUIFojX6LZ5AgqYhq8Hfk7uS+zCnBYrrqbX7PvLuI6+KFsGRZmpk/srU6cGn+93oGtzksH2GhSeB/YhnQWPuBlffAzeX//TqPtBmb4BNpCg5wHOvvS+QfK78SpcWCHk3tQDN7XaAulNw6WG9MBOvXMz2scF5gblgtN2veA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856608; c=relaxed/simple;
	bh=AJJ2urcFQgFox1bABr44KJnEA3bplt0FxYSD9IfuChU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X3XVjaP6gWmR0XB9xDd466UvsCt1iFdVUs8dfkUo4ACb8WABvT2nauGehj/BLlLdnCiljVWziKriNWJ9Bju5LkPqj1oNA3m4tih9M/DzdxiLE99QxGPuvP3IjecbMawPieUw9BewEwhnOj40emSkDJ6hEFfBG15s7YS6hLKe3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0110083-5.85252e-05-0.988933;FP=15184871686268471958|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j8Z17zg_1788856592;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j8Z17zg_1788856592 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Sep 2026 16:36:33 +0800
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
Subject: [PATCH net-next v6 6/6] net: dsa: motorcomm: Add support for Motorcomm YT922x
Date: Tue,  8 Sep 2026 16:36:14 +0800
Message-Id: <20260908083614.2210505-7-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
References: <20260908083614.2210505-1-kyle.switch@motor-comm.com>
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

This patch adds basic support for a working DSA switch.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/Kconfig |   1 +
 drivers/net/dsa/motorcomm/chip.c  | 853 +++++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/chip.h  | 103 ++++
 3 files changed, 955 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
index 79cdd79a1fd2..f690de4c7a7c 100644
--- a/drivers/net/dsa/motorcomm/Kconfig
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -2,6 +2,7 @@
 config NET_DSA_YT921X
 	tristate "Motorcomm YT9215 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_DSA_TAG_YT922X
 	select NET_IEEE8021Q_HELPERS if DCB
 	help
 	  This enables support for the Motorcomm YT9215 ethernet switch
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index f960edabde2b..4a052b1886b5 100644
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
@@ -112,6 +112,7 @@ struct yt921x_info {
 #define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
 #define YT921X_PORT_MASK_EXT0		BIT(8)
 #define YT921X_PORT_MASK_EXT1		BIT(9)
+#define YT922X_PORT_MASK_INTm_n(m, n)	GENMASK((n), (m))
 
 static const struct yt921x_info yt921x_infos[] = {
 	{
@@ -149,9 +150,17 @@ static const struct yt921x_info yt921x_infos[] = {
 		YT921X_PORT_MASK_INT0_n(8),
 		YT921X_PORT_MASK_EXT0 | YT921X_PORT_MASK_EXT1,
 	},
+	{
+		"YT9224", YT9224_MAJOR, 0, 0,
+		YT922X_PORT_MASK_INTm_n(4, 7) | YT921X_PORT_MASK_INTn(0) | YT921X_PORT_MASK_INTn(8),
+		0x0,
+	},
 	{}
 };
 
+/* Define top ext addr */
+#define YT922X_COMMON_EXT_PHYADDR	9
+
 #define YT921X_VID_UNWARE	4095
 
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
@@ -4694,6 +4703,826 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
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
+	if (port >= priv->series->max_ports)
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
+	if (port >= priv->series->max_ports)
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
+				  enum yt922x_phy_reg_type reg_type,
+				  enum yt922x_phy_reg_space reg_space)
+{
+	int res = port;
+
+	/*
+	 * sds phyaddr mapping depend on reg_type and reg_space
+	 */
+	if (!yt922x_port_is_internal_sds(port))
+		return -EOPNOTSUPP;
+	if (reg_type == YT922X_PHY_REG_TYPE_COMMON_EXT) {
+		res = YT922X_COMMON_EXT_PHYADDR;
+		return res;
+	}
+
+	return res;
+}
+
+/**
+ * Initialize serdes configuration based on interface mode.
+ */
+static int yt922x_sds_init(struct yt921x_priv *priv, int port,
+			   phy_interface_t interface)
+{
+	int addr;
+	u16 data;
+	int res;
+
+	addr = yt922x_sds_phyaddr_get
+		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
+		 YT922X_PHY_REG_SPACE_SGMII);
+	if (addr < 0)
+		return -EINVAL;
+	/* write protect */
+	res = yt921x_intif_ext_write(priv, addr, 0x4be, 0xd);
+	if (res)
+		return res;
+	/* CDR */
+	if (interface == PHY_INTERFACE_MODE_100BASEX) {
+		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x0);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x3458);
+		if (res)
+			return res;
+	} else {
+		res = yt921x_intif_ext_write(priv, addr, 0x406, 0x800);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x416, 0x4558);
+		if (res)
+			return res;
+	}
+	/* PLL */
+	if (interface == PHY_INTERFACE_MODE_USXGMII) {
+		res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x1006);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3029);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070);
+		if (res)
+			return res;
+	} else {
+		res = yt921x_intif_ext_write(priv, addr, 0x43d, 0x207d);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x43c, 0x207d);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x43f, 0x3032);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x43a, 0x6);
+		if (res)
+			return res;
+		res = yt921x_intif_ext_write(priv, addr, 0x42a, 0xf070);
+		if (res)
+			return res;
+	}
+	/* VCO */
+	res = yt921x_intif_ext_write(priv, addr, 0x439, 0xC0);
+	if (res)
+		return res;
+	/* Vdac */
+	res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x491, 0x7f);
+	if (res)
+		return res;
+	/* Eye */
+	res = yt921x_intif_ext_write(priv, addr, 0x454, 0xf14);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x497, 0xa44);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x4cd, 0x0);
+	if (res)
+		return res;
+
+	res = yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e3);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x48a, 0xfff);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x408, 0x7c00);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x4d6, 0x7f);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x44f, 0xff08);
+	if (res)
+		return res;
+	/* FFE */
+	res = yt921x_intif_ext_write(priv, addr, 0x48e, 0x7d00);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0xd, 0x60f);
+	if (res)
+		return res;
+	/* CTLE */
+	res = yt921x_intif_ext_write(priv, addr, 0x4b0, 0x804);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x4b1, 0x7774);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x4af, 0x45e7);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x3, 0x5603);
+	if (res)
+		return res;
+
+	msleep(20);
+	res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7fff);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x492, 0x7f7f);
+	if (res)
+		return res;
+	/* CTLE */
+	res = yt921x_intif_ext_write(priv, addr, 0x2000, 0x40);
+	if (res)
+		return res;
+	res = yt921x_intif_ext_write(priv, addr, 0x2000, 0x0);
+	if (res)
+		return res;
+
+	if (interface == PHY_INTERFACE_MODE_SGMII) {
+		res = yt921x_intif_ext_write(priv, addr, 0x1042, 0x48c);
+		if (res)
+			return res;
+	}
+	/* soft reset */
+	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
+				      YT922X_PHY_REG_SPACE_SGMII);
+	if (addr < 0)
+		return res;
+	res = yt921x_intif_read(priv, addr, 0x0, &data);
+	if (res)
+		return res;
+	data &= ~(1 << 15);
+	res = yt921x_intif_write(priv, addr, 0x0, data);
+	if (res)
+		return res;
+	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII,
+				      YT922X_PHY_REG_SPACE_USXGMII);
+	if (addr < 0)
+		return res;
+	res = yt921x_intif_read(priv, addr, 0x0, &data);
+	if (res)
+		return res;
+	data |= 1 << 15;
+	res = yt921x_intif_write(priv, addr, 0x0, data);
+	if (res)
+		return res;
+
+	return 0;
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
+	struct yt921x_priv *priv = dp->ds->priv;
+	struct phylink_pcs *pcs = NULL;
+	int port = dp->index;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_100BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_USXGMII:
+		switch (port) {
+		case 0:
+			pcs = &priv->pcs_port_0.pcs;
+			break;
+
+		case 8:
+			pcs = &priv->pcs_port_8.pcs;
+			break;
+		}
+		break;
+
+	default:
+		break;
+	}
+
+	return pcs;
+}
+
+static const struct phylink_mac_ops yt922x_phylink_mac_ops = {
+	.mac_select_pcs = yt922x_phylink_mac_select_pcs,
+	.mac_link_down = yt922x_phylink_mac_link_down,
+	.mac_link_up = yt922x_phylink_mac_link_up,
+	.mac_config = yt922x_phylink_mac_config,
+};
+
+static struct yt922x_pcs *pcs_to_yt922x_pcs(struct phylink_pcs *pcs)
+{
+	return container_of(pcs, struct yt922x_pcs, pcs);
+}
+
+static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 struct phylink_link_state *state)
+{
+	struct yt921x_priv *priv = pcs_to_yt922x_pcs(pcs)->priv;
+	int port = pcs_to_yt922x_pcs(pcs)->port;
+	u32 reg;
+	int res;
+
+	res = yt921x_reg_read(priv, YT922X_PORTn_STATUS(port), &reg);
+	if (res < 0) {
+		state->link = false;
+		return;
+	}
+
+	state->link = !!(reg & YT922X_PORT_LINK_STATE);
+	state->an_complete = state->link;
+	state->duplex = (reg & YT922X_PORT_LINK_DUPLEX) ? DUPLEX_FULL :
+							  DUPLEX_HALF;
+
+	switch (reg & YT922X_PORT_SPEED_M) {
+	case YT922X_PORT_SPEED_10:
+		state->speed = SPEED_10;
+		break;
+	case YT922X_PORT_SPEED_100:
+		state->speed = SPEED_100;
+		break;
+	case YT922X_PORT_SPEED_1000:
+		state->speed = SPEED_1000;
+		break;
+	case YT922X_PORT_SPEED_10000:
+		state->speed = SPEED_10000;
+		break;
+	case YT922X_PORT_SPEED_2500:
+		state->speed = SPEED_2500;
+		break;
+	case YT922X_PORT_SPEED_5000:
+		state->speed = SPEED_5000;
+		break;
+	default:
+		state->speed = SPEED_UNKNOWN;
+		break;
+	}
+}
+
+static void yt922x_pcs_an_restart(struct phylink_pcs *pcs)
+{
+}
+
+static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	struct yt921x_priv *priv = pcs_to_yt922x_pcs(pcs)->priv;
+	int res, port;
+	u16 data;
+	u16 ctrl;
+	int addr;
+
+	port = pcs_to_yt922x_pcs(pcs)->port;
+	if (port != 0 && port != 8)
+		return -EINVAL;
+
+	/* SERDES init and interface configuration */
+	res = yt922x_sds_init(priv, port, interface);
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		ctrl = YT92XX_SERDES_MODE_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_100BASEX:
+		ctrl = YT92XX_SERDES_MODE_100BASEX;
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		ctrl = YT92XX_SERDES_MODE_1000BASEX;
+		break;
+	case PHY_INTERFACE_MODE_2500BASEX:
+		ctrl = YT92XX_SERDES_MODE_2500BASEX;
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		ctrl = YT92XX_SERDES_MODE_USXGMII;
+		break;
+	default:
+		return -EINVAL;
+	}
+	addr = yt922x_sds_phyaddr_get
+		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
+		 YT922X_PHY_REG_SPACE_SGMII);
+	if (addr < 0)
+		return -EINVAL;
+
+	res = yt921x_intif_ext_read(priv, addr, YT922X_PORT_SDSn, &data);
+	if (res)
+		return res;
+	data &= ~YT922X_SERDES_MODE_M;
+	data |= ctrl;
+	res = yt921x_intif_ext_write(priv, addr, YT922X_PORT_SDSn, data);
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
+		if (port >= 4 && port <= 7) {
+			/* port 4 to port 7, internal utp */
+			__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+				  config->supported_interfaces);
+			config->mac_capabilities |= MAC_2500FD;
+		} else {
+			__set_bit(PHY_INTERFACE_MODE_SGMII,
+				  config->supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_100BASEX,
+				  config->supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+				  config->supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+				  config->supported_interfaces);
+			config->mac_capabilities |= MAC_2500FD;
+			__set_bit(PHY_INTERFACE_MODE_USXGMII,
+				  config->supported_interfaces);
+			config->mac_capabilities |= MAC_2500FD;
+			config->mac_capabilities |= MAC_5000FD;
+			config->mac_capabilities |= MAC_10000FD;
+		}
+	} else {
+		/* external port will added later */
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
+static int yt922x_chip_detect(struct yt921x_priv *priv)
+{
+	struct device *dev = to_device(priv);
+	const struct yt921x_info *info;
+	u32 chipid;
+	u32 major;
+	int res;
+
+	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
+	if (res)
+		return res;
+	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
+	for (info = yt921x_infos; info->name; info++)
+		if (info->major == major)
+			break;
+	if (!info->name) {
+		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
+		return -ENODEV;
+	}
+	priv->info = info;
+
+	return 0;
+}
+
+static int yt922x_chip_reset(struct yt921x_priv *priv)
+{
+	struct device *dev = to_device(priv);
+	u16 eth_p_tag;
+	u32 val;
+	int res;
+
+	res = yt922x_chip_detect(priv);
+	if (res)
+		return res;
+
+	/* Reset */
+	res = yt921x_reg_write(priv, YT921X_RST, YT921X_RST_HW);
+	if (res)
+		return res;
+
+	fsleep(YT921X_RST_DELAY_US);
+
+	val = 0;
+	res = yt921x_reg_wait(priv, YT921X_RST, ~0, &val);
+	if (res)
+		return res;
+
+	/* TPID check */
+	res = yt921x_reg_read(priv, YT921X_CPU_TAG_TPID, &val);
+	if (res)
+		return res;
+	eth_p_tag = FIELD_GET(YT921X_CPU_TAG_TPID_TPID_M, val);
+	if (eth_p_tag != ETH_P_YT921X) {
+		dev_err(dev, "Tag type 0x%x != 0x%x\n", eth_p_tag,
+			ETH_P_YT921X);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int yt922x_chip_setup_dsa(struct yt921x_priv *priv)
+{
+	unsigned long cpu_ports_mask;
+	u32 ctrl;
+	int port;
+	int res;
+
+	ctrl = GENMASK(9, 0);
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
+static int yt922x_cpu_tag_mode_set_8b(struct yt921x_priv *priv)
+{
+	u32 val;
+	u32 val1;
+	int res;
+
+	/* cpu tag mode set to 8b*/
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
+static void yt922x_setup_pcs(struct yt921x_priv *priv, struct yt922x_pcs *pcs,
+			     int port)
+{
+	pcs->pcs.ops = &yt922x_pcs_ops;
+
+	pcs->priv = priv;
+	pcs->port = port;
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
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_chip_reset(priv);
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
+	/* cpu port set */
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_cpu_port_set(priv);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_chip_setup(priv);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	/* switch sds pcs setup */
+	yt922x_setup_pcs(priv, &priv->pcs_port_0, 0);
+	yt922x_setup_pcs(priv, &priv->pcs_port_8, 8);
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
@@ -4707,6 +5536,18 @@ static const struct yt92xx_series yt92xx_series_table[] = {
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
@@ -4716,6 +5557,10 @@ static const struct yt92xx_series *yt92xx_series_lookup(u32 major)
 
 	if (major == YT9215_MAJOR || major == YT9218_MAJOR)
 		mode = YT92XX_MODE_YT921X;
+	else if (major == YT9224_MAJOR)
+		mode = YT92XX_MODE_YT922X;
+	else
+		mode = YT92XX_MODE_MAX;
 
 	for (i = 0; i < ARRAY_SIZE(yt92xx_series_table); ++i)
 		if (yt92xx_series_table[i].mode == mode)
@@ -4832,6 +5677,9 @@ static const struct of_device_id yt921x_of_match[] = {
 	{
 		.compatible = "motorcomm,yt9215",
 	},
+	{
+		.compatible = "motorcomm,yt9224",
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, yt921x_of_match);
@@ -4849,5 +5697,6 @@ static struct mdio_driver yt921x_mdio_driver = {
 mdio_module_driver(yt921x_mdio_driver);
 
 MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-MODULE_DESCRIPTION("Driver for Motorcomm YT921x Switch");
+MODULE_AUTHOR("Kyle Switch <kyle.switch@motor-comm.com>");
+MODULE_DESCRIPTION("Driver for Motorcomm YT921x and YT922x Switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index c446aea449ed..3b7ea3cbf522 100644
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
@@ -861,6 +863,99 @@ enum yt921x_fdb_entry_status {
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
+#define YT92XX_SERDES_MODE_SGMII	YT922X_SERDES_MODE(0)
+#define YT92XX_SERDES_MODE_REVSGMII	YT921X_SERDES_MODE(1)
+#define YT92XX_SERDES_MODE_1000BASEX	YT921X_SERDES_MODE(2)
+#define YT92XX_SERDES_MODE_100BASEX	YT921X_SERDES_MODE(3)
+#define YT92XX_SERDES_MODE_2500BASEX	YT921X_SERDES_MODE(4)
+#define YT92XX_SERDES_MODE_USXGMII	YT922X_SERDES_MODE(6)
+#define YT922X_PORT_NUM		9
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
+enum yt922x_phy_reg_space {
+	YT922X_PHY_REG_SPACE_SGMII,
+	YT922X_PHY_REG_SPACE_USXGMII,
+	YT922X_PHY_REG_SPACE_MAX
+};
+
 struct yt921x_mib {
 	u64 rx_broadcast;
 	u64 rx_pause;
@@ -979,6 +1074,12 @@ struct yt92xx_series {
 	const struct phylink_mac_ops *mac_ops;
 };
 
+struct yt922x_pcs {
+	struct phylink_pcs pcs;
+	struct yt921x_priv *priv;
+	int port;
+};
+
 struct yt921x_priv {
 	struct dsa_switch ds;
 
@@ -1007,6 +1108,8 @@ struct yt921x_priv {
 
 	u8 acl_masks[YT921X_ACL_BLK_NUM];
 	struct yt921x_acl_blk *acl_blks[YT921X_ACL_BLK_NUM];
+	struct yt922x_pcs pcs_port_0;
+	struct yt922x_pcs pcs_port_8;
 };
 
 #endif
-- 
2.25.1

