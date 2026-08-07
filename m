Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC4448035B
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108433; cv=none; b=LFdjfvUYXIVTPrHmv86HPl/tD1KfCNQAaxtLPTDewkZRkTSLtx5aKSy5bEEVwvryA4leJcXt1U+sgKCt7Kg1R6DPwhTqiAntDAIf7S+isVhnM5AKGMWG1v+GExXn9Ms/iHuHT7Px6dJ26xLhMQ4ifYPLG2LV0DHLRhXqTQNV8XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108433; c=relaxed/simple;
	bh=puEqI3cbxABKVloOL+gOvTNSiDIrwKgaD0WRKtsyaq0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hr0i4C2TnxvG7ttRBk9WYQvFJV5dQ2T7MkkZSEwBioMn6IXQoGxDkp8x1MrEnUUxYNt3D8tshmDbEBjWI6Ob0lQ4kKEdaERLr2/S5fGENrBryL9qAUouWVnxsTrTlJtfkyheNhu8+FeXyQPcmQ63jHW8KmhTtXttlKBSjMHVy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzrROBWH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzrROBWH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so39157215e9.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786108417; x=1786713217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=94lQlIC2bYbitZXez6xVpq3PxYuRMlGhHfYdCk7VWOI=;
        b=gzrROBWHNTdjDZSyf8+fN7/q0gi69z8PqQf/yFvP2fQ5JP4rSlXHm7JULWClrFLxRy
         61D5w8jbkEEfBkMhJU5gEilEDYn3OWCOPWwXEa7Lp5wwA7hgvxg6WfLei3ORVvwLXDvX
         +gtQILGZzDyTmvOFpJYdwPCroJvvqIRKLo0TdaJjj2n8eywlAFhABNQzzZzvT6y69KhT
         NK4R9L/8MiwO36CtOdMqoZG+MTfsFI6U9SzDRuCNWJ+qR4AZec6htVz/0faJPOSlIapM
         +86K/7EW4vF7DrDgy1ANweSw9baez5o5Q2FFk0a5yoP6ZztCaZOThOnBctMA2As9fbOF
         gU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786108417; x=1786713217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=94lQlIC2bYbitZXez6xVpq3PxYuRMlGhHfYdCk7VWOI=;
        b=jxWEL5VBLk5/rWlV5B/XNMieMd1f4EXCDY3RYErnig3fN3FC99W+B9SbEqF9JKUU8F
         0mRSsBNRyh1mBd1ZzFZiEJgXSAQxo1xG9XeMTNvQ1+ekSEFiZtQqU8z10f63oY9Z8cw7
         JXuYcK3yv0b8BMmRaJIW/id58nJ4EKJwl5Sub4sRgPB6l+3S+Y2KdCqsVZMxKbDF2Hza
         5jjvvgPnn/7lkJqxQ8q7m4kil3U0KFPG3WJEUG8Cwo9bzomS7oSsyhKnYZxj3LgqOYYx
         UkNwSAseobXNf7NH3MYy3d+3QV6ioQQoBjE2RzqAaCWuvAbafUn5YH0w74girPBfJ5c/
         1cBw==
X-Forwarded-Encrypted: i=1; AHgh+Rr6B6XzBam8ZyJmQdemqoY1/3+QfuF45LgI6aqb3d27OqsMAv48o8Lo0741IjDJlkwG/DOQkeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIIebRbKy8aqKrVm9NMNkJzMk3ppyX0m/FmO/LhXUwFvhEemh
	4ur13D3Fh47xo/tGWpzqrCLTBF9Om9lOCvdu9MSyWmBB6yd6Tqwacb9h
X-Gm-Gg: AR+sD11Zi4N5/pSc3KQVgfsi8VdDfs5FsWCwLGG5v9NOIMiaBM48duRSAZwy2CCt+fo
	xfpECzKKsXQ+3GB3DLqOTomNLFjXi3pA25ni+lxt/XSAEWaAViUu6wru8Hf69Y8Ij+RdjE0CsDs
	Xr2Ap4SRo1HAbRs0Ds0LyeAGXnexcuNwpWTOqBozip/WnOD+1H2OukPj61iU6m2o9Rio+1tho2p
	Ry1YROBXlhHcwrgb3P/2Y7w6akRrY8+Allt/X+K1RNmwksiMZdl4dgYVUZUvCKG8ZLO+dUa5VEA
	hfGoI2biPRFnFtUefiV4uwJK00m9tmGRxdU0V7bLQ6h+BQ3Xn1LkRvjTZb/cQ80JAhxaXfqEVSL
	dIh4TC69a1Dj++f/kcJviFBlKWTH9lUgIVAwAr4mZNcwuaT+LIEVwpxz1TGr3ZiIhXFIX0lumBE
	VzkMm+NgOYWMYNKNyaX2mT0i/u8tUf9aLTaht6BLfzte7BC5gFtc8YdBK2dvMHi4Ta+OXpD1y9F
	v/G4jkOI8fHYhmKinZLHKN8IrSANBstGcZ/suFyXyflqZCmokhWpw==
X-Received: by 2002:a05:600c:3b20:b0:499:4893:97d3 with SMTP id 5b1f17b1804b1-4994e7cb8ebmr273444225e9.13.1786108416601;
        Fri, 07 Aug 2026 06:13:36 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-19-255-168.retail.telecomitalia.it. [87.19.255.168])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995c7b2b68sm58827665e9.4.2026.08.07.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:13:36 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v11 12/12] net: airoha: add phylink support
Date: Fri,  7 Aug 2026 15:12:54 +0200
Message-ID: <20260807131301.192060-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807131301.192060-1-ansuelsmth@gmail.com>
References: <20260807131301.192060-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add phylink support for each GDM port. For GDM1 add the internal interface
mode as the only supported mode. For GDM2/3/4 add the required
configuration of the PCS to make the external PHY or attached SFP cage
work.

These needs to be defined in the GDM port node using the pcs-handle
property.

Update and provide a .get/set_link_ksettings function that use phylink
for ethtool OPs now that we fully support phylink.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/ethernet/airoha/Kconfig       |   2 +
 drivers/net/ethernet/airoha/airoha_eth.c  | 190 +++++++++++++++++++++-
 drivers/net/ethernet/airoha/airoha_eth.h  |   5 +
 drivers/net/ethernet/airoha/airoha_regs.h |  12 ++
 4 files changed, 207 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/Kconfig b/drivers/net/ethernet/airoha/Kconfig
index 1f6640a15fc9..5c54a07d2a76 100644
--- a/drivers/net/ethernet/airoha/Kconfig
+++ b/drivers/net/ethernet/airoha/Kconfig
@@ -20,6 +20,8 @@ config NET_AIROHA
 	depends on NET_DSA || !NET_DSA
 	select NET_AIROHA_NPU
 	select PAGE_POOL
+	select PCS_AIROHA
+	select PHYLINK
 	help
 	  This driver supports the gigabit ethernet MACs in the
 	  Airoha SoC family.
diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 64619e9a704d..9fe8376aca0f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -6,6 +6,7 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/pcs/pcs.h>
 #include <linux/platform_device.h>
 #include <linux/tcp.h>
 #include <linux/u64_stats_sync.h>
@@ -1915,6 +1916,14 @@ static int airoha_dev_open(struct net_device *netdev)
 	struct airoha_qdma *qdma;
 	int err;
 
+	err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
+	if (err) {
+		netdev_err(netdev, "could not attach PHY: %d\n", err);
+		return err;
+	}
+
+	phylink_start(dev->phylink);
+
 	netif_tx_start_all_queues(netdev);
 	err = airoha_set_vip_for_gdm_port(dev, true);
 	if (err)
@@ -1945,6 +1954,8 @@ static int airoha_dev_stop(struct net_device *netdev)
 	struct airoha_gdm_dev *dev = netdev_priv(netdev);
 	struct airoha_gdm_port *port = dev->port;
 
+	phylink_stop(dev->phylink);
+
 	netif_tx_disable(netdev);
 	airoha_set_vip_for_gdm_port(dev, false);
 
@@ -1954,6 +1965,9 @@ static int airoha_dev_stop(struct net_device *netdev)
 		airoha_set_gdm_port_fwd_cfg(dev->eth,
 					    REG_GDM_FWD_CFG(port->id),
 					    FE_PSE_PORT_DROP);
+
+	phylink_disconnect_phy(dev->phylink);
+
 	return 0;
 }
 
@@ -2509,6 +2523,24 @@ airoha_ethtool_get_rmon_stats(struct net_device *netdev,
 	} while (u64_stats_fetch_retry(&dev->stats.syncp, start));
 }
 
+static int
+airoha_ethtool_get_link_ksettings(struct net_device *netdev,
+				  struct ethtool_link_ksettings *cmd)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_get(dev->phylink, cmd);
+}
+
+static int
+airoha_ethtool_set_link_ksettings(struct net_device *netdev,
+				  const struct ethtool_link_ksettings *cmd)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_set(dev->phylink, cmd);
+}
+
 static int airoha_qdma_set_chan_tx_sched(struct net_device *netdev,
 					 int channel, enum tx_sched_mode mode,
 					 const u16 *weights, u8 n_weights)
@@ -3353,7 +3385,8 @@ static const struct ethtool_ops airoha_ethtool_ops = {
 	.get_drvinfo		= airoha_ethtool_get_drvinfo,
 	.get_eth_mac_stats      = airoha_ethtool_get_mac_stats,
 	.get_rmon_stats		= airoha_ethtool_get_rmon_stats,
-	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
+	.get_link_ksettings	= airoha_ethtool_get_link_ksettings,
+	.set_link_ksettings	= airoha_ethtool_set_link_ksettings,
 	.get_link		= ethtool_op_get_link,
 };
 
@@ -3409,6 +3442,155 @@ bool airoha_is_valid_gdm_dev(struct airoha_eth *eth,
 	return false;
 }
 
+/* Nothing to do in MAC, everything is handled in PCS */
+static void airoha_mac_config(struct phylink_config *config, unsigned int mode,
+			      const struct phylink_link_state *state)
+{
+}
+
+static void airoha_mac_link_up(struct phylink_config *config, struct phy_device *phy,
+			       unsigned int mode, phy_interface_t interface,
+			       int speed, int duplex, bool tx_pause, bool rx_pause)
+{
+	struct airoha_gdm_dev *dev = container_of(config, struct airoha_gdm_dev,
+						  phylink_config);
+	struct airoha_gdm_port *port = dev->port;
+	struct airoha_eth *eth = dev->eth;
+	u32 frag_size_tx, frag_size_rx;
+
+	/* TX/RX frag is configured only for GDM4 */
+	if (port->id != AIROHA_GDM4_IDX)
+		return;
+
+	switch (speed) {
+	case SPEED_10000:
+	case SPEED_5000:
+		frag_size_tx = 8;
+		frag_size_rx = 8;
+		break;
+	case SPEED_2500:
+		frag_size_tx = 2;
+		frag_size_rx = 1;
+		break;
+	default:
+		frag_size_tx = 1;
+		frag_size_rx = 0;
+		break;
+	}
+
+	mutex_lock(&port->link_lock);
+
+	/* Configure TX/RX frag based on speed */
+	if (dev->nbq == 1) {
+		airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG,
+			      GDM4_SGMII1_TX_FRAG_SIZE_MASK,
+			      FIELD_PREP(GDM4_SGMII1_TX_FRAG_SIZE_MASK,
+					 frag_size_tx));
+
+		airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG,
+			      GDM4_SGMII1_RX_FRAG_SIZE_MASK,
+			      FIELD_PREP(GDM4_SGMII1_RX_FRAG_SIZE_MASK,
+					 frag_size_rx));
+	} else {
+		airoha_fe_rmw(eth, REG_FE_GDM4_TMBI_FRAG,
+			      GDM4_SGMII0_TX_FRAG_SIZE_MASK,
+			      FIELD_PREP(GDM4_SGMII0_TX_FRAG_SIZE_MASK,
+					 frag_size_tx));
+
+		airoha_fe_rmw(eth, REG_FE_GDM4_RMBI_FRAG,
+			      GDM4_SGMII0_RX_FRAG_SIZE_MASK,
+			      FIELD_PREP(GDM4_SGMII0_RX_FRAG_SIZE_MASK,
+					 frag_size_rx));
+	}
+
+	mutex_unlock(&port->link_lock);
+}
+
+/* Nothing to do in MAC, everything is handled in PCS */
+static void airoha_mac_link_down(struct phylink_config *config, unsigned int mode,
+				 phy_interface_t interface)
+{
+}
+
+static const struct phylink_mac_ops airoha_phylink_ops = {
+	.mac_config = airoha_mac_config,
+	.mac_link_up = airoha_mac_link_up,
+	.mac_link_down = airoha_mac_link_down,
+};
+
+static int airoha_fill_available_pcs(struct phylink_config *config,
+				     struct phylink_pcs **available_pcs,
+				     unsigned int num_possible_pcs)
+{
+	struct device *dev = config->dev;
+
+	return fwnode_phylink_pcs_parse(dev_fwnode(dev), available_pcs,
+					num_possible_pcs);
+}
+
+static int airoha_setup_phylink(struct net_device *netdev)
+{
+	struct airoha_gdm_dev *dev = netdev_priv(netdev);
+	struct device_node *np = netdev->dev.of_node;
+	struct airoha_gdm_port *port = dev->port;
+	struct phylink_config *config;
+	phy_interface_t phy_mode;
+	struct phylink *phylink;
+	int err;
+
+	err = of_get_phy_mode(np, &phy_mode);
+	if (err) {
+		dev_err(&netdev->dev, "incorrect phy-mode\n");
+		return err;
+	}
+
+	config = &dev->phylink_config;
+	config->dev = &netdev->dev;
+	config->type = PHYLINK_NETDEV;
+
+	/*
+	 * GDM1 only supports internal for Embedded Switch
+	 * and doesn't require a PCS.
+	 */
+	if (port->id == AIROHA_GDM1_IDX) {
+		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					   MAC_10000FD;
+
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+	} else {
+		config->mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+					   MAC_10 | MAC_100 | MAC_1000 |
+					   MAC_2500FD | MAC_5000FD | MAC_10000FD;
+
+		config->num_possible_pcs = fwnode_phylink_pcs_count(dev_fwnode(config->dev));
+		config->fill_available_pcs = airoha_fill_available_pcs;
+
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_10GBASER,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_USXGMII,
+			  config->supported_interfaces);
+
+		phy_interface_copy(config->pcs_interfaces,
+				   config->supported_interfaces);
+	}
+
+	phylink = phylink_create(config, of_fwnode_handle(np),
+				 phy_mode, &airoha_phylink_ops);
+	if (IS_ERR(phylink))
+		return PTR_ERR(phylink);
+
+	dev->phylink = phylink;
+
+	return 0;
+}
+
 static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 				   struct airoha_gdm_port *port,
 				   int nbq, struct device_node *np)
@@ -3474,7 +3656,7 @@ static int airoha_alloc_gdm_device(struct airoha_eth *eth,
 	dev->nbq = nbq;
 	port->devs[index] = dev;
 
-	return 0;
+	return airoha_setup_phylink(netdev);
 }
 
 static int airoha_alloc_gdm_port(struct airoha_eth *eth,
@@ -3510,6 +3692,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 
 	port->id = id;
 	spin_lock_init(&port->stats_lock);
+	mutex_init(&port->link_lock);
 	eth->ports[p] = port;
 
 	err = airoha_metadata_dst_alloc(port);
@@ -3706,6 +3889,8 @@ static int airoha_probe(struct platform_device *pdev)
 			netdev = netdev_from_priv(dev);
 			if (netdev->reg_state == NETREG_REGISTERED)
 				unregister_netdev(netdev);
+			if (dev->phylink)
+				phylink_destroy(dev->phylink);
 			of_node_put(netdev->dev.of_node);
 		}
 		airoha_metadata_dst_free(port);
@@ -3744,6 +3929,7 @@ static void airoha_remove(struct platform_device *pdev)
 
 			netdev = netdev_from_priv(dev);
 			unregister_netdev(netdev);
+			phylink_destroy(dev->phylink);
 			of_node_put(netdev->dev.of_node);
 		}
 		airoha_metadata_dst_free(port);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index fa9a8edce22f..83daec003257 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -595,6 +595,9 @@ struct airoha_gdm_dev {
 	 * QDMA migration.
 	 */
 	spinlock_t txq_lock[AIROHA_NUM_NETDEV_TX_RINGS];
+
+	struct phylink *phylink;
+	struct phylink_config phylink_config;
 };
 
 struct airoha_gdm_port {
@@ -604,6 +607,8 @@ struct airoha_gdm_port {
 
 	/* protect concurrent hw_stats accesses */
 	spinlock_t stats_lock;
+	/* protect concurrent GDM4 register access */
+	struct mutex link_lock;
 
 	struct metadata_dst *dsa_meta[AIROHA_MAX_DSA_PORTS];
 };
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index 442b48c9b991..4ea89057b560 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -357,6 +357,18 @@
 #define IP_FRAGMENT_PORT_MASK		GENMASK(8, 5)
 #define IP_FRAGMENT_NBQ_MASK		GENMASK(4, 0)
 
+#define REG_FE_GDM4_TMBI_FRAG		0x2028
+#define GDM4_SGMII1_TX_WEIGHT_MASK	GENMASK(31, 26)
+#define GDM4_SGMII1_TX_FRAG_SIZE_MASK	GENMASK(25, 16)
+#define GDM4_SGMII0_TX_WEIGHT_MASK	GENMASK(15, 10)
+#define GDM4_SGMII0_TX_FRAG_SIZE_MASK	GENMASK(9, 0)
+
+#define REG_FE_GDM4_RMBI_FRAG		0x202c
+#define GDM4_SGMII1_RX_WEIGHT_MASK	GENMASK(31, 26)
+#define GDM4_SGMII1_RX_FRAG_SIZE_MASK	GENMASK(25, 16)
+#define GDM4_SGMII0_RX_WEIGHT_MASK	GENMASK(15, 10)
+#define GDM4_SGMII0_RX_FRAG_SIZE_MASK	GENMASK(9, 0)
+
 #define REG_MC_VLAN_EN			0x2100
 #define MC_VLAN_EN_MASK			BIT(0)
 
-- 
2.53.0

