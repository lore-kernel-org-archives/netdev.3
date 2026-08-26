Received: from out198-29.us.a.mail.aliyun.com (out198-29.us.a.mail.aliyun.com [47.90.198.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7B523C503;
	Wed, 26 Aug 2026 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787735306; cv=none; b=JMy5wcqQDl+MZz6pSDJkEmUKUxT+O9JknP3F042kJrTDL67AaWjAuXLAQNg6LK93tTyEyJ+p6hNPKIFXH0s78zPfKTQNScsVWwlBRUFbxSfj5Af9lrgctMyB72todAAeybPC05mgGQDFjYn58/b7Zy1L+CQaReS+HbctKd1Oy6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787735306; c=relaxed/simple;
	bh=mkrKZI5rxX9FrkV7GQsGvVXT4W6guB2yfVycySKaOBM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGNyvavAuZUYBupwbHYm7lOH2bqpWQS6befOh9RyyFaOQEL2vE3y1t9JkLdZs3Ubw7rmC1UdR3jQmRLDjeOmG5dfjLEXph40kKaUHI0plL5giwfG2mQdbV6lIYCGnm5McTSJPxASqcagdFmxBiWumUF8DX15hLqAQ5PGagMXUlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0663624-0.000685942-0.932952;FP=15184170008871324336|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.iwcg9El_1787638588;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.iwcg9El_1787638588 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 25 Aug 2026 14:16:29 +0800
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
	jianmin.wang@motor-comm.com
Subject: [PATCH v3 net-next 2/2] net: dsa: Add support for Motorcomm YT922x
Date: Wed, 26 Aug 2026 17:08:02 +0800
Message-Id: <20260825061610.3116673-3-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
References: <20260825061610.3116673-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Motorcomm YT922x is a series of ethernet switches including:

 - YT9224: 4 * 2.5G UTPs and 2 serdes interface

This patch just add basic func for a working DSA switch.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/Kconfig  |   7 +-
 drivers/net/dsa/Makefile |   2 +-
 drivers/net/dsa/yt921x.c | 821 ++++++++++++++++++++++++++++++++++++++-
 drivers/net/dsa/yt921x.h | 104 +++++
 4 files changed, 915 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 676fb7dffe14..d95897c35ade 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -169,11 +169,12 @@ config NET_DSA_VITESSE_VSC73XX_PLATFORM
 	  and VSC7398 SparX integrated ethernet switches, connected over
 	  a CPU-attached address bus and work in memory-mapped I/O mode.
 
-config NET_DSA_YT921X
-	tristate "Motorcomm YT9215 ethernet switch chip support"
+config NET_DSA_YT92XX
+	tristate "Motorcomm YT9215 and YT9224 ethernet switch chip support"
 	select NET_DSA_TAG_YT921X
+	select NET_DSA_TAG_YT922X
 	select NET_IEEE8021Q_HELPERS if DCB
 	help
-	  This enables support for the Motorcomm YT9215 ethernet switch
+	  This enables support for the Motorcomm YT9215 and YT9224 ethernet switch
 	  chip.
 endmenu
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 6ceb78a755d7..77cc82e00650 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_NET_DSA_SMSC_LAN9303_MDIO) += lan9303_mdio.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX) += vitesse-vsc73xx-core.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM) += vitesse-vsc73xx-platform.o
 obj-$(CONFIG_NET_DSA_VITESSE_VSC73XX_SPI) += vitesse-vsc73xx-spi.o
-obj-$(CONFIG_NET_DSA_YT921X) += yt921x.o
+obj-$(CONFIG_NET_DSA_YT92XX) += yt921x.o
 obj-y				+= b53/
 obj-y				+= hirschmann/
 obj-y				+= lantiq/
diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 159b16606f6c..c5c271f54d19 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -111,6 +111,7 @@ struct yt921x_info {
 #define YT921X_PORT_MASK_INT0_n(n)	GENMASK((n) - 1, 0)
 #define YT921X_PORT_MASK_EXT0		BIT(8)
 #define YT921X_PORT_MASK_EXT1		BIT(9)
+#define YT922X_PORT_MASK_INTm_n(m, n)	GENMASK((n), (m))
 
 static const struct yt921x_info yt921x_infos[] = {
 	{
@@ -148,6 +149,11 @@ static const struct yt921x_info yt921x_infos[] = {
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
 
@@ -158,6 +164,7 @@ static const struct yt921x_info yt921x_infos[] = {
 #define YT921X_POLL_SLEEP_US	10000
 #define YT921X_POLL_TIMEOUT_US	100000
 
+#define YT922X_COMMON_EXT_PHYADDR 9
 /* The interval should be small enough to avoid overflow of 32bit MIBs.
  *
  * Until we can read MIBs from stats64 call directly (i.e. sleep
@@ -560,10 +567,12 @@ yt921x_intif_write(struct yt921x_priv *priv, int port, int reg, u16 val)
 static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
 {
 	struct yt921x_priv *priv = mbus->priv;
+	int max_ports;
 	u16 val;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	max_ports = priv->series_info->ports;
+	if (port >= max_ports)
 		return U16_MAX;
 
 	mutex_lock(&priv->reg_lock);
@@ -579,9 +588,11 @@ static int
 yt921x_mbus_int_write(struct mii_bus *mbus, int port, int reg, u16 data)
 {
 	struct yt921x_priv *priv = mbus->priv;
+	int max_ports;
 	int res;
 
-	if (port >= YT921X_PORT_NUM)
+	max_ports = priv->series_info->ports;
+	if (port >= max_ports)
 		return -ENODEV;
 
 	mutex_lock(&priv->reg_lock);
@@ -596,19 +607,21 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
 {
 	struct device *dev = to_device(priv);
 	struct mii_bus *mbus;
+	int max_ports;
 	int res;
 
 	mbus = devm_mdiobus_alloc(dev);
 	if (!mbus)
 		return -ENOMEM;
 
+	max_ports = priv->series_info->ports;
 	mbus->name = "YT921x internal MDIO bus";
 	snprintf(mbus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 	mbus->priv = priv;
 	mbus->read = yt921x_mbus_int_read;
 	mbus->write = yt921x_mbus_int_write;
 	mbus->parent = dev;
-	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
+	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);
 
 	res = devm_of_mdiobus_register(dev, mbus, mnp);
 	if (res)
@@ -4748,6 +4761,14 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 	struct device_node *child;
 	int res;
 
+	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
+		struct yt921x_port *pp = &priv->ports[i];
+
+		pp->index = i;
+		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		pp->mib_working = 1;
+	}
+
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_chip_reset(priv);
 	mutex_unlock(&priv->reg_lock);
@@ -4869,6 +4890,756 @@ static const struct dsa_switch_ops yt921x_dsa_switch_ops = {
 	.setup			= yt921x_dsa_setup,
 };
 
+static int yt922x_port_down(struct yt921x_priv *priv, int port)
+{
+	u32 mask;
+	int res;
+
+	/* mac force down */
+	mask = YT922X_PORT_LINK | YT922X_PORT_RX_MAC_EN |
+	       YT922X_PORT_TX_MAC_EN | YT922X_PORT_LINK_AN;
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
+	if (port >= YT921X_PORT_NUM)
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
+	if (port >= YT921X_PORT_NUM)
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
+	addr = yt922x_sds_phyaddr_get(port,
+				      YT922X_PHY_REG_TYPE_SDS_COMMON_EXT,
+				      YT922X_PHY_REG_SPACE_SGMII);
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
+static int
+yt922x_port_config(struct yt921x_priv *priv, int port, unsigned int mode,
+		   phy_interface_t interface)
+{
+	struct device *dev = to_device(priv);
+	int addr;
+	u32 ctrl;
+	u16 data;
+	int res;
+
+	/* internal UTPs no config needed */
+	if (yt922x_port_is_internal_utp(port)) {
+		if (interface != PHY_INTERFACE_MODE_INTERNAL) {
+			dev_err(dev, "Wrong mode %d on port %d\n",
+				interface, port);
+			return -EINVAL;
+		}
+		return 0;
+	}
+	/* SERDES init and interface configuration */
+	res = yt922x_sds_init(priv, port, interface);
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
+static void
+yt922x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
+			  const struct phylink_link_state *state)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct yt921x_priv *priv = to_yt921x_priv(dp->ds);
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
+static const struct phylink_mac_ops yt922x_phylink_mac_ops = {
+	.mac_link_down	= yt922x_phylink_mac_link_down,
+	.mac_link_up	= yt922x_phylink_mac_link_up,
+	.mac_config	= yt922x_phylink_mac_config,
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
+	for (int i = 0; i < priv->series_info->ports; i++)
+		ctrl |= YT922X_ACT_UNK_ACTn_TRAP(i);
+	cpu_ports_mask = priv->cpu_ports_mask;
+	for_each_set_bit(port, &cpu_ports_mask, priv->series_info->ports) {
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
+	 /* cpu port set */
+	 mutex_lock(&priv->reg_lock);
+	 res = yt922x_cpu_port_set(priv);
+	 mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	mutex_lock(&priv->reg_lock);
+	res = yt922x_chip_setup(priv);
+	mutex_unlock(&priv->reg_lock);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static const struct dsa_switch_ops yt922x_dsa_switch_ops = {
+	/* port */
+	.get_tag_protocol	= yt922x_dsa_get_tag_protocol,
+	.phylink_get_caps	= yt922x_dsa_phylink_get_caps,
+	.port_setup		= yt922x_dsa_port_setup,
+	/* chip */
+	.setup			= yt922x_dsa_setup,
+};
+
+static const struct yt92xx_series yt92xx_series_table[] = {
+	[YT9215] = {
+		.mode = YT9215,
+		.name = "motorcomm yt9215",
+		.ports = YT921X_PORT_NUM,
+		.num_lag_ids = YT921X_LAG_NUM,
+		.ageing_time_min = 1 * 5000,
+		.ageing_time_max = U16_MAX * 5000,
+		.switch_ops = &yt921x_dsa_switch_ops,
+		.mac_ops = &yt921x_phylink_mac_ops,
+	},
+	[YT9224] = {
+		.mode = YT9224,
+		.name = "motorcomm yt9224",
+		.ports = YT922X_PORT_NUM,
+		.num_lag_ids = YT922X_LAG_NUM,
+		.ageing_time_min = 1 * 6000,
+		.ageing_time_max = U16_MAX * 6000,
+		.switch_ops = &yt922x_dsa_switch_ops,
+		.mac_ops = &yt922x_phylink_mac_ops,
+	},
+};
+
 static void yt921x_mdio_shutdown(struct mdio_device *mdiodev)
 {
 	struct yt921x_priv *priv = mdiodev_get_drvdata(mdiodev);
@@ -4889,6 +5660,7 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
 		struct yt921x_port *pp = &priv->ports[i];
 
+		if (pp->mib_working)
 			disable_delayed_work_sync(&pp->mib_read);
 	}
 
@@ -4913,11 +5685,16 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 
 static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 {
+	const struct yt92xx_series *compat_info = NULL;
 	struct device *dev = &mdiodev->dev;
 	struct yt921x_reg_mdio *mdio;
 	struct yt921x_priv *priv;
 	struct dsa_switch *ds;
 
+	compat_info = of_device_get_match_data(dev);
+	if (!compat_info)
+		return -EINVAL;
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -4932,14 +5709,20 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 	mutex_init(&priv->reg_lock);
 
+	priv->series_info = compat_info;
 	priv->reg_ops = &yt921x_reg_ops_mdio;
 	priv->reg_ctx = mdio;
 
+	/*
+	 * This is used to identity which series has been initialized
+	 * during subsequent disable operations,thereby preventing
+	 * unexpected errors. After the MIB has been added to the
+	 * YT922x series,this should be fixed/removed afterward.
+	 */
 	for (size_t i = 0; i < ARRAY_SIZE(priv->ports); i++) {
 		struct yt921x_port *pp = &priv->ports[i];
 
-		pp->index = i;
-		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		pp->mib_working = 0;
 	}
 
 	ds = &priv->ds;
@@ -4947,12 +5730,12 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	ds->assisted_learning_on_cpu_port = true;
 	ds->dscp_prio_mapping_is_global = true;
 	ds->priv = priv;
-	ds->ops = &yt921x_dsa_switch_ops;
-	ds->ageing_time_min = 1 * 5000;
-	ds->ageing_time_max = U16_MAX * 5000;
-	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
-	ds->num_lag_ids = YT921X_LAG_NUM;
-	ds->num_ports = YT921X_PORT_NUM;
+	ds->ops = compat_info->switch_ops;
+	ds->ageing_time_min = compat_info->ageing_time_min;
+	ds->ageing_time_max = compat_info->ageing_time_max;
+	ds->phylink_mac_ops = compat_info->mac_ops;
+	ds->num_lag_ids = compat_info->num_lag_ids;
+	ds->num_ports = compat_info->ports;
 
 	mdiodev_set_drvdata(mdiodev, priv);
 
@@ -4960,12 +5743,19 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 }
 
 static const struct of_device_id yt921x_of_match[] = {
-	{ .compatible = "motorcomm,yt9215" },
+	{
+		.compatible = "motorcomm,yt9215",
+		.data = &yt92xx_series_table[YT9215],
+	},
+	{
+		.compatible = "motorcomm,yt9224",
+		.data = &yt92xx_series_table[YT9224],
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, yt921x_of_match);
 
-static struct mdio_driver yt921x_mdio_driver = {
+static struct mdio_driver yt92xx_mdio_driver = {
 	.probe = yt921x_mdio_probe,
 	.remove = yt921x_mdio_remove,
 	.shutdown = yt921x_mdio_shutdown,
@@ -4975,8 +5765,9 @@ static struct mdio_driver yt921x_mdio_driver = {
 	},
 };
 
-mdio_module_driver(yt921x_mdio_driver);
+mdio_module_driver(yt92xx_mdio_driver);
 
 MODULE_AUTHOR("David Yang <mmyangfl@gmail.com>");
-MODULE_DESCRIPTION("Driver for Motorcomm YT921x Switch");
+MODULE_AUTHOR("Kyle Switch <kyle.switch@motor-comm.com>");
+MODULE_DESCRIPTION("Driver for Motorcomm YT921x and YT922x Switch");
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 5f3b99e189c4..7d644ca671ad 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
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
@@ -853,6 +855,90 @@ enum yt921x_fdb_entry_status {
 /* 8 internal + 2 external + 1 mcu */
 #define YT921X_PORT_NUM			11
 
+/* yt922x register lists */
+#define YT92XX_PAGE_SELECT		0x1e
+#define YT92XX_PAGE			0x1f
+#define YT922X_PORTn_STATUS(port)	(0x80200 + 4 * (port))
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
+#define YT92XX_SERDES_MODE_SGMII		YT922X_SERDES_MODE(0)
+#define YT92XX_SERDES_MODE_REVSGMII		YT921X_SERDES_MODE(1)
+#define YT92XX_SERDES_MODE_1000BASEX		YT921X_SERDES_MODE(2)
+#define YT92XX_SERDES_MODE_100BASEX		YT921X_SERDES_MODE(3)
+#define YT92XX_SERDES_MODE_2500BASEX		YT921X_SERDES_MODE(4)
+#define YT92XX_SERDES_MODE_USXGMII		YT922X_SERDES_MODE(6)
+#define YT922X_PORT_NUM			9
+
+/* LAG */
+#define YT922X_LAG_NUM			4
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
+#define yt922x_port_is_internal_utp(port) ((port) < 8 && (port) > 3)
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
 #define yt921x_port_is_internal(port) ((port) < 8)
 #define yt921x_port_is_external(port) ((port) == 8 || (port) == 9)
 
@@ -938,6 +1024,7 @@ struct yt921x_port {
 	struct yt921x_mib mib;
 	u64 rx_frames;
 	u64 tx_frames;
+	bool mib_working;
 };
 
 struct yt921x_reg_ops {
@@ -945,9 +1032,26 @@ struct yt921x_reg_ops {
 	int (*write)(void *context, u32 reg, u32 val);
 };
 
+enum yt92xx_mode {
+	YT9215,
+	YT9224,
+};
+
+struct yt92xx_series {
+	enum yt92xx_mode mode;
+	const char *name;
+	unsigned int ports;
+	unsigned int num_lag_ids;
+	unsigned int ageing_time_min;
+	unsigned int ageing_time_max;
+	const struct dsa_switch_ops *switch_ops;
+	const struct phylink_mac_ops *mac_ops;
+};
+
 struct yt921x_priv {
 	struct dsa_switch ds;
 
+	const struct yt92xx_series *series_info;
 	const struct yt921x_info *info;
 	unsigned int meter_slot_ns;
 	unsigned int port_shape_slot_ns;
-- 
2.25.1

