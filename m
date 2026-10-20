Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792494690;
	b=HBtfTz9vRPLHbQvySNf4pYUPskOiYJncZPf02N2q8X2ukP6ZsHRjIY1h4MtgbUtHfaGo
	 3WicwaAQjFC1x0aRSOtSBm5uUazMsRSINOWOdUVI5f0zzsqrvUoPuQJipDQv2wfWa8gbY
	 hh1CGbFcz7vJQv1O8Pf262poyPfj94rMK6qgnsXqrqeAkHylGbSynp6jO70RcvJ6XiqFG
	 +hxpWyt6ANOIuYaqegPkOM9DK0HJobbe1dhnP/cXk8X8u3fTECT3Gf/G0xfUMl4pmMEMM
	 kb8eXuGbeajHg1jd2Z9C/rMBnU4OqJd2or6z/Y6ET6Vz2HqEuVHuPmGe8V37avtwaRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792494690;
	h=DMARC-Filter:X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Oktj1Ouz0xBpIFBfP8VscuNoDzaPv5AKd9+oFWkKxSc=;
	b=zkt/w7sUA2kNqrKJ+2qaPHLJY4ldnefmbWfi2Ae8ZmtIzOiplswNOfSeB90QP1jikMnO
	 LhcTnWSkRHZwrrcJgd3/Ao+OOiISSWK9FCSrapCB3FgUqCHeSozgsSocAYVWcu0uur1BH
	 KoKyJXYy11wVT9m+bXpPejobKKnUudgA35NkqhIXCpLz4xmzaIC3gy/BIgmyPrOkQR7US
	 QHUHjVmtSj3Vgz8hpSZMgcjUwUdH4kNBZ3XgutTBbaG2cGEbcamCZIkonvyiI+15LMhz/
	 5iOovl936fqjs7g990zqH3VW0kmTrUpIZCx5Y5xm0tBhKOMXzjXT0wZcN+jI1V4bjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=motor-comm.com;
	spf=pass smtp.mailfrom=motor-comm.com;
	arc=none smtp.remote-ip=115.124.28.193
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8B606A320;
	Tue, 20 Oct 2026 11:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D8B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00959794-0.00190441-0.988498;FP=15166857288830501556|14|2|17|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.jlqQH6t_1792494684;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.jlqQH6t_1792494684 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 20 Oct 2026 19:11:25 +0800
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
Subject: [PATCH net-next v16 5/5] net: dsa: motorcomm: Add support for Motorcomm YT922x
Date: Tue, 20 Oct 2026 19:11:15 +0800
Message-Id: <20261020111115.3072180-6-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
References: <20261020111115.3072180-1-kyle.switch@motor-comm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/Kconfig    |   7 +-
 drivers/net/dsa/motorcomm/Makefile   |   1 +
 drivers/net/dsa/motorcomm/chip.c     | 508 ++++++++++++++++++++++++++-
 drivers/net/dsa/motorcomm/chip.h     |  82 +++++
 drivers/net/dsa/motorcomm/mdio_bus.c |  40 +++
 drivers/net/dsa/motorcomm/mdio_bus.h |   4 +
 drivers/net/dsa/motorcomm/pcs-922x.c | 282 +++++++++++++++
 drivers/net/dsa/motorcomm/pcs.h      |   1 +
 8 files changed, 916 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/dsa/motorcomm/pcs-922x.c

diff --git a/drivers/net/dsa/motorcomm/Kconfig b/drivers/net/dsa/motorcomm/Kconfig
index 79cdd79a1fd2..648c49d6c527 100644
--- a/drivers/net/dsa/motorcomm/Kconfig
+++ b/drivers/net/dsa/motorcomm/Kconfig
@@ -1,11 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_DSA_YT921X
-	tristate "Motorcomm YT9215 ethernet switch chip support"
+	tristate "Motorcomm YT9215 and YT9224 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_DSA_TAG_YT922X
 	select NET_IEEE8021Q_HELPERS if DCB
 	help
-	  This enables support for the Motorcomm YT9215 ethernet switch
-	  chip.
+	  This enables support for the Motorcomm YT9215 and YT9224
+	  ethernet switch chip.
 
 config NET_DSA_YT921X_LEDS
 	bool "LED support for Motorcomm YT9215"
diff --git a/drivers/net/dsa/motorcomm/Makefile b/drivers/net/dsa/motorcomm/Makefile
index 9eaa59f699e8..3ca151358d19 100644
--- a/drivers/net/dsa/motorcomm/Makefile
+++ b/drivers/net/dsa/motorcomm/Makefile
@@ -4,6 +4,7 @@ yt921x-objs := chip.o
 yt921x-$(CONFIG_NET_DSA_YT921X_LEDS) += leds.o
 yt921x-objs += mdio_bus.o
 yt921x-objs += mib.o
+yt921x-objs += pcs-922x.o
 yt921x-objs += pcs-921x.o
 yt921x-objs += smi.o
 yt921x-objs += tc.o
diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index bbb598e19a8d..74b5e341213d 100644
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
@@ -76,6 +76,12 @@ static const struct yt921x_info yt921x_infos[] = {
 		BIT(8) | BIT(9),
 		BIT(8) | BIT(9),
 	},
+	{
+		"YT9224", YT9224_MAJOR, 0, 0,
+		GENMASK(7, 4),
+		0,
+		BIT(8) | BIT(0),
+	},
 	{}
 };
 
@@ -2150,6 +2156,11 @@ static void yt921x_dsa_teardown(struct dsa_switch *ds)
 #endif
 }
 
+static bool yt921x_needs_extmode_check(u32 major)
+{
+	return (major == YT9224_MAJOR) ? false : true;
+}
+
 static int yt921x_chip_detect(struct yt921x_priv *priv)
 {
 	struct device *dev = yt921x_priv_to_device(priv);
@@ -2175,6 +2186,14 @@ static int yt921x_chip_detect(struct yt921x_priv *priv)
 		return -ENODEV;
 	}
 
+	if (!yt921x_needs_extmode_check(major)) {
+		dev_info(dev,
+			 "Motorcomm %s ethernet switch, chipid: 0x%x\n",
+			 info->name, chipid);
+		priv->info = info;
+		return 0;
+	}
+
 	res = yt921x_reg_read(priv, YT921X_CHIP_MODE, &mode);
 	if (res)
 		return res;
@@ -2580,6 +2599,470 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.setup			= yt921x_dsa_setup,
 };
 
+static int yt922x_port_down(struct yt921x_priv *priv, int port)
+{
+	u32 mask;
+	int res;
+
+	/* mac force down */
+	mask = YT922X_PORT_LINK | YT922X_PORT_RX_MAC_EN |
+	YT922X_PORT_TX_MAC_EN | YT922X_PORT_LINK_AN;
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
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
+	struct yt921x_port *pp = &priv->ports[port];
+	int ps = ethtool_speed_to_yt921x(speed);
+	u32 ctrl = 0;
+	u32 mask;
+	int res;
+
+	if (ps == YT921X_SPEED_INVALID)
+		return -EINVAL;
+
+	mask = YT922X_PORT_SPEED_M | YT922X_PORT_TX_MAC_EN |
+	       YT922X_PORT_RX_MAC_EN | YT922X_PORT_TX_PAUSE |
+	       YT922X_PORT_RX_PAUSE | YT922X_PORT_DUPLEX_FULL |
+	       YT922X_PORT_LINK_AN | YT922X_PORT_CFG_RX_EN |
+	       YT922X_PORT_CFG_TX_EN | YT922X_PORT_FC_AN |
+	       YT922X_PORT_LINK;
+
+	ctrl |= ps;
+
+	if (duplex == DUPLEX_FULL)
+		ctrl |= YT922X_PORT_DUPLEX_FULL;
+	if (tx_pause)
+		ctrl |= YT922X_PORT_TX_PAUSE;
+	if (rx_pause)
+		ctrl |= YT922X_PORT_RX_PAUSE;
+	ctrl |= YT922X_PORT_RX_MAC_EN | YT922X_PORT_TX_MAC_EN |
+			YT922X_PORT_CFG_TX_EN | YT922X_PORT_CFG_RX_EN;
+
+	/*
+	 * Self-negotiation: the LINK/AN bits in ctrl are set based to inband.
+	 * Forced mode: set LINK, keep the AN bit at 0 and clear it via the mask
+	 */
+	if (pp->inband)
+		ctrl |= (YT922X_PORT_FC_AN | YT922X_PORT_LINK_AN);
+	else
+		ctrl |= YT922X_PORT_LINK;
+
+	res = yt921x_reg_update_bits(priv, YT922X_PORTn_CTRL(port), mask, ctrl);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
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
+yt922x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
+		   phy_interface_t interface)
+{
+	struct device *dev = yt921x_priv_to_device(priv);
+	const struct yt921x_info *info = priv->info;
+	struct yt921x_port *pp = &priv->ports[port];
+
+	if (BIT(port) & info->internal_mask) {
+		if (interface != PHY_INTERFACE_MODE_INTERNAL)
+			goto err;
+		return 0;
+	}
+
+	switch (interface) {
+	/* SERDES */
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_100BASEX:
+	case PHY_INTERFACE_MODE_1000BASEX:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_USXGMII:
+		if (!(BIT(port) & info->serdes_mask))
+			goto err;
+		pp->serdes = true;
+		break;
+	default:
+		goto err;
+	}
+
+	return 0;
+
+err:
+	dev_err(dev, "Wrong mode %d on port %d\n", interface, port);
+	return -EINVAL;
+}
+
+static void
+yt922x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
+	int port = dp->index;
+	int res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_port_config(priv, port, mode, state->interface);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dp->ds->dev, "Failed to %s port %d: %i\n", "config",
+			port, res);
+}
+
+static struct phylink_pcs *
+yt922x_phylink_mac_select_pcs(struct phylink_config *config,
+			      phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(dp->ds);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	if (info->serdes_mask & BIT(port)) {
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
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
+	ctrl = GENMASK_U32(8, 0);
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	const struct yt921x_info *info = priv->info;
+	unsigned long mask;
+	int port;
+
+	mask = info->serdes_mask;
+	for_each_set_bit(port, &mask, priv->series->max_ports) {
+		struct yt921x_port *pp = &priv->ports[port];
+
+		pp->pcs.ops = &yt922x_phylink_pcs_ops;
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
+	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
+	struct device *dev = yt921x_priv_to_device(priv);
+	struct device_node *np = dev->of_node;
+	struct device_node *child;
+	int res;
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
 		.name = "YT921x",
@@ -2592,12 +3075,25 @@ static const struct yt92xx_series yt92xx_series_table[] = {
 		.switch_ops = &yt921x_dsa_switch_ops,
 		.mac_ops = &yt921x_phylink_mac_ops
 	},
+	[YT92XX_MODE_YT922X] = {
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
@@ -2614,15 +3110,13 @@ static int yt92xx_register_switch(struct dsa_switch *ds)
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_reg_read(priv, YT921X_CHIP_ID, &chipid);
 	mutex_unlock(&priv->reg_lock);
-	if (res) {
-		dev_err(dev, "Unexpected chipid 0x%x\n", chipid);
+	if (res)
 		return res;
-	}
 
 	major = FIELD_GET(YT921X_CHIP_ID_MAJOR, chipid);
 	series = yt92xx_series_lookup(major);
 	if (!series) {
-		dev_err(dev, "Undefined series info for the corresponding major\n");
+		dev_err(dev, "Chip ID: 0x%x, and Unknown major.\n", chipid);
 		return -ENODEV;
 	}
 	priv->series = series;
@@ -2722,6 +3216,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 static const struct of_device_id yt921x_of_match[] = {
 	{ .compatible = "motorcomm,yt9215" },
+	{ .compatible = "motorcomm,yt9224" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, yt921x_of_match);
@@ -2739,5 +3234,6 @@ static struct mdio_driver yt921x_mdio_driver = {
 mdio_module_driver(yt921x_mdio_driver);
 
 MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-MODULE_DESCRIPTION("Driver for Motorcomm YT921x Switch");
+MODULE_AUTHOR("Kyle Switch <kyle.switch@motor-comm.com>");
+MODULE_DESCRIPTION("Driver for Motorcomm YT921x and YT922x Switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 8e0b00281c56..cc35dec2e52f 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -119,6 +119,7 @@ enum yt921x_speed {
 	YT921X_SPEED_1000,
 	YT921X_SPEED_10000,
 	YT921X_SPEED_2500,
+	YT921X_SPEED_5000,
 	YT921X_SPEED_INVALID
 };
 
@@ -431,6 +432,7 @@ enum yt921x_fdb_entry_status {
 
 #define YT9215_MAJOR	0x9002
 #define YT9218_MAJOR	0x9001
+#define YT9224_MAJOR	0x9004
 
 /* required for a hard reset */
 #define YT921X_RST_DELAY_US	10000
@@ -450,6 +452,84 @@ enum yt921x_fdb_entry_status {
 
 #define YT921X_NAME	"yt921x"
 
+/* yt922x register lists */
+#define YT92XX_PAGE_SELECT	0x1e
+#define YT92XX_PAGE		0x1f
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
+#define YT922X_PORT_SDSn		0x400
+#define  YT922X_SERDES_MODE_M			GENMASK(6, 4)
+#define   YT922X_SERDES_MODE(x)				FIELD_PREP(YT922X_SERDES_MODE_M, (x))
+#define YT922X_SERDES_MODE_SGMII	YT922X_SERDES_MODE(0)
+#define YT922X_SERDES_MODE_REVSGMII	YT922X_SERDES_MODE(1)
+#define YT922X_SERDES_MODE_1000BASEX	YT922X_SERDES_MODE(2)
+#define YT922X_SERDES_MODE_100BASEX	YT922X_SERDES_MODE(3)
+#define YT922X_SERDES_MODE_2500BASEX	YT922X_SERDES_MODE(4)
+#define YT922X_SERDES_MODE_USXGMII	YT922X_SERDES_MODE(6)
+#define YT922X_PORT_NUM			9
+#define YT922X_PCS_LINK_CTRL		0x11
+#define YT922X_PCS_LINK_STATUS		BIT(10)
+#define YT922X_PCS_AN_COMPLETE		BIT(11)
+#define YT922X_PCS_WRITE_PROTECT    0x4be
+
+#define YT922X_LAG_NUM			4
+
+#define YT922X_PORTn_ISOLATION(port)	(0x180d80 + 0x4 * (port))
+
+#define YT922X_PORTn_LEARN(port)	(0x180300 + 4 * (port))
+#define  YT922X_PORT_LEARN_DIS			BIT(18)
+
+#define  YT922X_FUNC_ACL			BIT(5)
+#define  YT922X_FUNC_MIB			BIT(4)
+
+#define YT922X_FILTER_UNK_UCAST		0x180ec8
+#define YT922X_ACT_UNK_UCAST		0x180ed8
+#define YT922X_ACT_UNK_MCAST		0x180ee0
+#define  YT922X_ACT_UNK_MCAST_BYPASS_DROP_PIM	BIT(22)
+#define  YT922X_ACT_UNK_MCAST_BYPASS_DROP_MLD	BIT(21)
+#define  YT922X_ACT_UNK_MCAST_BYPASS_DROP_IGMP	BIT(20)
+#define  YT922X_ACT_UNK_ACTn_M(port)			GENMASK(2 * (port) + 1, 2 * (port))
+#define  YT922X_ACT_UNK_ACTn(port, x)			((x) << (2 * (port)))
+#define  YT922X_ACT_UNK_ACTn_FORWARD(port)		YT922X_ACT_UNK_ACTn(port, 0)  /* flood */
+#define  YT922X_ACT_UNK_ACTn_DROP(port)			YT922X_ACT_UNK_ACTn(port, 1)  /* discard */
+#define  YT922X_ACT_UNK_ACTn_TRAP(port)			YT922X_ACT_UNK_ACTn(port, 3)  /* steer to CPU */
+
+#define YT922X_CPU_COPY			0x181100
+#define  YT922X_CPU_COPY_TO_INT_CPU		BIT(1)
+#define  YT922X_CPU_COPY_TO_EXT_CPU		BIT(0)
+#define YT922X_CPU_TAG_RX_CTRL		0x80504
+#define  YT922X_CPU_TAG_RX_MODE			BIT(0)
+#define YT922X_CPU_TAG_TX_CTRL		0x100710
+#define  YT922X_CPU_TAG_TX_TYPE		BIT(0)
+#define  YT922X_CPU_TAG_TX_MODE		BIT(1)
+#define  YT922X_CPU_TAG_TX_CTAG_OP	BIT(2)
+#define  YT922X_CPU_TAG_TX_STAG_OP	BIT(3)
+/* Define top ext addr for yt922x */
+#define YT922X_COMMON_EXT_PHYADDR 9
+
+enum yt922x_phy_reg_type {
+	YT922X_PHY_REG_TYPE_COMMON_EXT,
+	YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
+	YT922X_PHY_REG_TYPE_MII,
+	YT922X_PHY_REG_TYPE_EXT,
+	YT922X_PHY_REG_TYPE_MAX
+};
+
 struct yt921x_port {
 	unsigned char index;
 
@@ -569,6 +649,8 @@ static inline int ethtool_speed_to_yt921x(int speed)
 		return YT921X_SPEED_2500;
 	case SPEED_10000:
 		return YT921X_SPEED_10000;
+	case SPEED_5000:
+		return YT921X_SPEED_5000;
 	default:
 		return YT921X_SPEED_INVALID;
 	}
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.c b/drivers/net/dsa/motorcomm/mdio_bus.c
index 3aa1111efaa4..d545f338bd9d 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.c
+++ b/drivers/net/dsa/motorcomm/mdio_bus.c
@@ -107,6 +107,45 @@ yt921x_intif_modify_changed(struct yt921x_priv *priv, int port, int reg,
 	return 1;
 }
 
+/* intif extend register read/write api */
+int
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
+int
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
 static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
 {
 	struct yt921x_priv *priv = mbus->priv;
@@ -299,3 +338,4 @@ int yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 
 	return 0;
 }
+
diff --git a/drivers/net/dsa/motorcomm/mdio_bus.h b/drivers/net/dsa/motorcomm/mdio_bus.h
index e79b725d435b..238a35891cb1 100644
--- a/drivers/net/dsa/motorcomm/mdio_bus.h
+++ b/drivers/net/dsa/motorcomm/mdio_bus.h
@@ -35,6 +35,10 @@ struct yt921x_priv;
 
 int yt921x_intif_read(struct yt921x_priv *priv, int port, int reg, u16 *valp);
 int yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val);
+int yt921x_intif_ext_write(struct yt921x_priv *priv, int port, int reg,
+			   u16 val);
+int yt921x_intif_ext_read(struct yt921x_priv *priv, int port, int reg,
+			  u16 *valp);
 int yt921x_intif_modify_changed(struct yt921x_priv *priv, int port, int reg,
 				u16 mask, u16 val);
 
diff --git a/drivers/net/dsa/motorcomm/pcs-922x.c b/drivers/net/dsa/motorcomm/pcs-922x.c
new file mode 100644
index 000000000000..5ad7873e0df7
--- /dev/null
+++ b/drivers/net/dsa/motorcomm/pcs-922x.c
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Kyle Switch
+ */
+
+#include "chip.h"
+#include "mdio_bus.h"
+#include "pcs.h"
+#include "smi.h"
+
+#define to_device(priv) ((priv)->ds.dev)
+
+static int yt922x_sds_phyaddr_get(int port,
+				  enum yt922x_phy_reg_type reg_type)
+{
+	if (reg_type == YT922X_PHY_REG_TYPE_COMMON_EXT)
+		return YT922X_COMMON_EXT_PHYADDR;
+
+	return port;
+}
+
+static void yt922x_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
+				 struct phylink_link_state *state)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	int port = pp->index;
+	u16 link_ctrl;
+	int res;
+	u16 bmsr;
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
+		res = yt921x_intif_read(priv, addr, MII_BMSR, &bmsr);
+		if (res)
+			goto err;
+		res = yt921x_intif_read(priv, addr, MII_LPA, &lp);
+		if (res)
+			goto err;
+		phylink_mii_c22_pcs_decode_state(state, neg_mode, bmsr, lp);
+		break;
+	case PHY_INTERFACE_MODE_100BASEX:
+		res = yt921x_intif_read(priv, addr, MII_BMSR, &bmsr);
+		if (res)
+			goto err;
+		state->speed = SPEED_100;
+		state->duplex = DUPLEX_FULL;
+		state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
+		state->link = !!(bmsr & BMSR_LSTATUS);
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+		res = yt921x_intif_read(priv, addr, YT922X_PCS_LINK_CTRL,
+					&link_ctrl);
+		if (res)
+			goto err;
+		state->link = FIELD_GET(YT922X_PCS_LINK_STATUS, link_ctrl);
+		state->an_complete = FIELD_GET(YT922X_PCS_AN_COMPLETE,
+					       link_ctrl);
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
+
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
+	u16 bmcr;
+	int addr;
+	int res;
+
+	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
+	if (addr < 0) {
+		dev_err(dev, "Invalid SDS PHY addr for port %d\n", port);
+		return;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_intif_read(priv, addr, MII_BMCR, &bmcr);
+	if (res)
+		goto err;
+	bmcr |= BMCR_ANRESTART;
+	bmcr |= BMCR_RESET;
+	res = yt921x_intif_write(priv, addr, MII_BMCR, bmcr);
+	if (res)
+		goto err;
+	mutex_unlock(&priv->reg_lock);
+	return;
+
+err:
+	mutex_unlock(&priv->reg_lock);
+	dev_err(dev, "Failed to an restart PCS port %d: %i\n", port, res);
+}
+
+static int yt922x_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,
+			     phy_interface_t interface,
+			     const unsigned long *advertising,
+			     bool permit_pause_to_mac)
+{
+	bool inband = neg_mode & PHYLINK_PCS_NEG_INBAND;
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	bool changed = false;
+	int res, port;
+	u16 bmcr_old;
+	u16 bmcr_new;
+	u16 data;
+	u16 ctrl;
+	int addr;
+	int adv;
+
+	port = pp->index;
+	addr = yt922x_sds_phyaddr_get
+		(port, YT922X_PHY_REG_TYPE_SDS_COMMON_EXT);
+	if (addr < 0)
+		return addr;
+
+	mutex_lock(&priv->reg_lock);
+
+	/* write protect */
+	res = yt921x_intif_ext_write(priv, addr, YT922X_PCS_WRITE_PROTECT, 0xd);
+	if (res)
+		goto err;
+	switch (interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		ctrl = YT922X_SERDES_MODE_SGMII;
+		break;
+	case PHY_INTERFACE_MODE_100BASEX:
+		ctrl = YT922X_SERDES_MODE_100BASEX;
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
+
+	if (inband) {
+		adv = phylink_mii_c22_pcs_encode_advertisement(interface,
+							       advertising);
+		if (adv >= 0) {
+			res = yt921x_intif_modify_changed(priv, port,
+							  MII_ADVERTISE,
+							  U16_MAX, adv);
+			if (res < 0)
+				goto err;
+
+			changed = !!res;
+		}
+	}
+
+	res = yt921x_intif_read(priv, port, MII_BMCR, &bmcr_old);
+	if (res)
+		goto err;
+
+	bmcr_new = bmcr_old;
+	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
+		bmcr_new |= BMCR_ANENABLE;
+	else
+		bmcr_new &= ~BMCR_ANENABLE;
+
+	changed |= (bmcr_new != bmcr_old);
+
+	res = yt921x_intif_write(priv, port, MII_BMCR, bmcr_new);
+	if (res)
+		goto err;
+	pp->inband = inband;
+	mutex_unlock(&priv->reg_lock);
+
+	return changed;
+
+err:
+	mutex_unlock(&priv->reg_lock);
+
+	return res;
+}
+
+static int yt922x_pcs_enable(struct phylink_pcs *pcs)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	struct device *dev = yt921x_priv_to_device(priv);
+	int port = pp->index;
+	int addr;
+	u16 bmcr;
+	int res;
+
+	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
+	if (addr < 0)
+		return addr;
+
+	mutex_lock(&priv->reg_lock);
+
+	res = yt921x_intif_read(priv, addr, MII_BMCR, &bmcr);
+	if (res)
+		goto end;
+
+	bmcr &= ~BMCR_PDOWN;
+	bmcr |= BMCR_ANRESTART;
+	res = yt921x_intif_write(priv, addr, MII_BMCR, bmcr);
+
+end:
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to enable PCS port %d: %i\n", port, res);
+
+	return res;
+}
+
+static void yt922x_pcs_disable(struct phylink_pcs *pcs)
+{
+	struct yt921x_port *pp = pcs_to_yt921x_port(pcs);
+	struct yt921x_priv *priv = yt921x_port_to_priv(pp);
+	struct device *dev = yt921x_priv_to_device(priv);
+	int port = pp->index;
+	int addr;
+	int res;
+
+	addr = yt922x_sds_phyaddr_get(port, YT922X_PHY_REG_TYPE_MII);
+	if (addr < 0) {
+		dev_err(dev, "Invalid SDS PHY addr for port %d\n", port);
+		return;
+	}
+
+	mutex_lock(&priv->reg_lock);
+	res = yt921x_intif_modify(priv, addr, MII_BMCR, BMCR_PDOWN, BMCR_PDOWN);
+	mutex_unlock(&priv->reg_lock);
+
+	if (res)
+		dev_err(dev, "Failed to power down PCS port %d: %i\n", port,
+			res);
+}
+
+const struct phylink_pcs_ops yt922x_phylink_pcs_ops = {
+	.pcs_get_state = yt922x_pcs_get_state,
+	.pcs_config = yt922x_pcs_config,
+	.pcs_an_restart = yt922x_pcs_an_restart,
+	.pcs_enable = yt922x_pcs_enable,
+	.pcs_disable = yt922x_pcs_disable,
+};
diff --git a/drivers/net/dsa/motorcomm/pcs.h b/drivers/net/dsa/motorcomm/pcs.h
index 42426558086a..c85caa7bf212 100644
--- a/drivers/net/dsa/motorcomm/pcs.h
+++ b/drivers/net/dsa/motorcomm/pcs.h
@@ -9,5 +9,6 @@
 #include <linux/phylink.h>
 
 extern const struct phylink_pcs_ops yt921x_phylink_pcs_ops;
+extern const struct phylink_pcs_ops yt922x_phylink_pcs_ops;
 
 #endif
-- 
2.25.1

