Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B6547DD4A;
	Wed, 23 Sep 2026 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160003; cv=none; b=FTT3EFLgRU802lEqi3XAhYQ93DgcCtt9XX4W6Lz1HLp1wEWuQbmcFjN5X/Vtbi2qCXTFZ7N3QBVPX1NQHP+8cMd8xpbZxzyKrXm+d2C0FAmGXVmHfc5kZVDCCx6BnGXoUdsKOopKC0H6qBxfM+d2r3fZf47PloQA20tZQqjoJbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160003; c=relaxed/simple;
	bh=DWT9MbCHPQn6zdPwdCWFrIndrpMFdiYIVnm2hh8er24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B6uHF3jMW3idpdJNs1EphyGLsQvjlYDqiQ0e+ZbMMmSSBOu1w8uc4QCs6JYtuRNiX5KiApYl/EbN6yefp3n1vPtWfAw3LG+xY+2rWEsGb5SBSKobBBdSXOGZZiRzZJ6ZugdyD9jCOUzmOXukE9PNQh+4yTgWBM9q0frcK5c3gV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hIx5KBKd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ArdMpQsd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hIx5KBKd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ArdMpQsd"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790159986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGV5gJ1K+1hayQcpyLjku4E+AA+xGbM2+h3g9lK5ihY=;
	b=hIx5KBKdMG59v/ZU5oECKrofkucueS2RzppScDbaX3J4wFffJgpwwNQQ9SlxMRrxuMy43g
	mNxp/w7VvnBO3p5JAJsuO0edjnW+/MrqsIap1l22qTDtz+fgzNzKUYSICfznoiZjR6ycfp
	h2Epq/Ur1Go0IYCShVLgrkvzidE34Di3KyYwEnGbXNacPmkxLkIFtVX9sKsaHWowe/Zo3m
	Mak4TM5wj+OgMR9MjorI59dnq/m19mvsJDlswUKxqLHjKXu6EHnGwFd3XHr6s2Gp+Tpz9O
	OPPYtEVCBGxic0Pwa+GaCGQsBydlZW3SOT0KorixRqzP3pgjp+o9TeYSUXBZiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790159986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGV5gJ1K+1hayQcpyLjku4E+AA+xGbM2+h3g9lK5ihY=;
	b=ArdMpQsdVr4JRqhdVWRmhoc+niKMFhDwWSCtfTisGQa0lXJJfiIM9le7cjB1p7gm++/16/
	d88ASMVZWhk327BQ==
Date: Wed, 23 Sep 2026 12:39:33 +0200
Subject: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add a DSA driver for SoC-e FPGA-based Ethernet switch IP cores.

Read the core version and synthesis-time feature registers during probe.
Require DSA support and between 3 and 31 implemented ports, without
exceeding the licensed port count. Derive each port's phylink
capabilities from its phy-mode.

Enable "DSA custom rules" tagging for all frames during setup. This
directs ingress traffic from user ports to the CPU port while standalone
ports remain isolated. Enable and disable port ingress and egress
through the DSA port callbacks, and disable tagging again during
teardown so that unbinding the driver does not leave its managed
configuration active.

Populate the integrated MDIO controller and mux child devices used for
external PHY access.

Tested with a SoC-e MRS 25.01 IP core on a Xilinx ZynqMP platform.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 drivers/net/dsa/Kconfig              |   2 +
 drivers/net/dsa/Makefile             |   1 +
 drivers/net/dsa/soce/Kconfig         |  14 ++
 drivers/net/dsa/soce/Makefile        |   4 +
 drivers/net/dsa/soce/soce_dsa.h      |  26 +++
 drivers/net/dsa/soce/soce_dsa_core.c | 343 +++++++++++++++++++++++++++++++++++
 6 files changed, 390 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index fe8cd5338fda..879fbede83f0 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -94,6 +94,8 @@ source "drivers/net/dsa/ocelot/Kconfig"
 
 source "drivers/net/dsa/qca/Kconfig"
 
+source "drivers/net/dsa/soce/Kconfig"
+
 source "drivers/net/dsa/sja1105/Kconfig"
 
 source "drivers/net/dsa/xrs700x/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index 7e637d56b35c..97de3d181440 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -26,4 +26,5 @@ obj-y				+= ocelot/
 obj-y				+= qca/
 obj-y				+= realtek/
 obj-y				+= sja1105/
+obj-y				+= soce/
 obj-y				+= xrs700x/
diff --git a/drivers/net/dsa/soce/Kconfig b/drivers/net/dsa/soce/Kconfig
new file mode 100644
index 000000000000..c31b7c5af695
--- /dev/null
+++ b/drivers/net/dsa/soce/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+config NET_DSA_SOCE
+	tristate "SoC-e switches"
+	depends on NET_DSA
+	depends on OF
+	depends on HAS_IOMEM
+	select MDIO_BUS_MUX_MMIOREG
+	select MDIO_SOCE
+	select NET_DSA_TAG_SDSA
+	help
+	  This enables support for switches based on SoC-e IP cores.
+	  Frames are exchanged with the CPU port using the SDSA DSA tag protocol.
+	  The driver supports switch variants whose features and number of ports
+	  are selected at synthesis time and detected at runtime.
diff --git a/drivers/net/dsa/soce/Makefile b/drivers/net/dsa/soce/Makefile
new file mode 100644
index 000000000000..2a6d95ef663f
--- /dev/null
+++ b/drivers/net/dsa/soce/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NET_DSA_SOCE) += soce_dsa.o
+soce_dsa-objs := soce_dsa_core.o
diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soce_dsa.h
new file mode 100644
index 000000000000..2acd4dbaf958
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_dsa.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#ifndef __SOCE_DSA_H
+#define __SOCE_DSA_H
+
+#include <linux/types.h>
+
+#include <net/dsa.h>
+
+#define SOCE_MAX_NUM_PORTS 31
+
+struct soce_dsa_local {
+	void __iomem *base_addr;
+};
+
+struct soce_priv {
+	struct soce_dsa_local local;
+	struct dsa_switch ds;
+};
+
+#endif /* __SOCE_DSA_H */
diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
new file mode 100644
index 000000000000..d391b11b94ad
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_dsa_core.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
+
+#include <net/dsa.h>
+
+#include "soce_dsa.h"
+
+#define SOCE_MIN_NUM_PORTS			3
+
+#define SOCE_CORE_VERSION_OFFSET		0x0000
+#define SOCE_CORE_VERSION_VERSION_SHIFT		24
+#define SOCE_CORE_VERSION_SUBVERSION_SHIFT	16
+#define SOCE_MIN_CORE_VERSION			0x24
+#define SOCE_MIN_CORE_SUBVERSION		0x01
+
+#define SOCE_LIC_FEATURES_OFFSET		0x0004
+#define SOCE_LIC_FEATURES_NUM_PORTS_MASK	GENMASK(31, 27)
+
+#define SOCE_IMPL_FEATURES0_OFFSET		0x000c
+#define SOCE_IMPL_FEATURES0_NUM_PORTS_MASK	GENMASK(31, 27)
+#define SOCE_IMPL_FEATURES0_PORT_VLAN		BIT(9)
+#define SOCE_IMPL_FEATURES0_DSA			BIT(23)
+
+#define SOCE_DSA_REGS_BASE			0x1200
+#define SOCE_TAG_ALL_FRAMES_CTRL_OFFSET		(SOCE_DSA_REGS_BASE + 0x001c)
+#define SOCE_TAG_ALL_FRAMES_CTRL_ENABLE		BIT(0)
+#define SOCE_CUSTOM_RULES_TAGGING_OFFSET	(SOCE_DSA_REGS_BASE + 0x0020)
+#define SOCE_CUSTOM_RULES_TAGGING_ENABLE	BIT(0)
+
+#define SOCE_PORTS_REGS_BASE			0x3000
+#define SOCE_PORTS_SELECTOR_OFFSET		SOCE_PORTS_REGS_BASE
+#define SOCE_PORTS_SELECTOR_PORT_MASK		GENMASK(7, 0)
+#define SOCE_PORTS_CTRL_OFFSET			(SOCE_PORTS_REGS_BASE + 0x0004)
+#define SOCE_PORTS_CTRL_INGR_EN			BIT(0)
+#define SOCE_PORTS_CTRL_EGR_EN			BIT(1)
+
+static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
+{
+	struct dsa_port *dp = dsa_to_port(ds, port);
+	phy_interface_t mode;
+	int ret;
+
+	ret = of_get_phy_mode(dp->dn, &mode);
+	if (ret)
+		return;
+
+	if (phy_interface_mode_is_rgmii(mode))
+		phy_interface_set_rgmii(config->supported_interfaces);
+	else
+		__set_bit(mode, config->supported_interfaces);
+
+	config->mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+
+	switch (mode) {
+	case PHY_INTERFACE_MODE_MII:
+		config->mac_capabilities |= MAC_10 | MAC_100;
+		break;
+	case PHY_INTERFACE_MODE_GMII:
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000;
+		break;
+	case PHY_INTERFACE_MODE_RMII:
+		config->mac_capabilities |= MAC_10FD | MAC_100FD;
+		break;
+	default:
+		if (phy_interface_mode_is_rgmii(mode))
+			config->mac_capabilities |= MAC_10FD | MAC_100FD |
+						    MAC_1000FD;
+		break;
+	}
+}
+
+static int soce_sw_validate_core_version(u8 version, u8 subversion)
+{
+	if (version < SOCE_MIN_CORE_VERSION ||
+	    (version == SOCE_MIN_CORE_VERSION &&
+	     subversion < SOCE_MIN_CORE_SUBVERSION))
+		return -ENODEV;
+
+	return 0;
+}
+
+static void soce_sw_read_core_version(struct soce_dsa_local *local,
+				      u8 *version, u8 *subversion,
+				      u16 *revision)
+{
+	u32 regval;
+
+	regval = readl(local->base_addr + SOCE_CORE_VERSION_OFFSET);
+	*version = (u8)(regval >> SOCE_CORE_VERSION_VERSION_SHIFT);
+	*subversion = (u8)(regval >> SOCE_CORE_VERSION_SUBVERSION_SHIFT);
+	*revision = (u16)regval;
+}
+
+static int soce_sw_detect_features(struct soce_dsa_local *local,
+				   u32 *numports)
+{
+	void __iomem *base = local->base_addr;
+	u32 implemented_numports;
+	u32 licensed_numports;
+	u32 regval;
+
+	regval = readl(base + SOCE_LIC_FEATURES_OFFSET);
+	licensed_numports = FIELD_GET(SOCE_LIC_FEATURES_NUM_PORTS_MASK, regval);
+	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
+		return -EINVAL;
+
+	regval = readl(base + SOCE_IMPL_FEATURES0_OFFSET);
+	if (!(regval & SOCE_IMPL_FEATURES0_DSA))
+		return -ENODEV;
+
+	implemented_numports =
+		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
+	if (implemented_numports < SOCE_MIN_NUM_PORTS ||
+	    implemented_numports > licensed_numports)
+		return -EINVAL;
+
+	*numports = implemented_numports;
+
+	return 0;
+}
+
+static void soce_sw_enable_tagging(struct soce_dsa_local *local)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	regval = readl(base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
+	regval |= SOCE_TAG_ALL_FRAMES_CTRL_ENABLE;
+	writel(regval, base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
+
+	regval = readl(base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
+	regval |= SOCE_CUSTOM_RULES_TAGGING_ENABLE;
+	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
+}
+
+static void soce_sw_disable_tagging(struct soce_dsa_local *local)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	regval = readl(base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
+	regval &= ~SOCE_TAG_ALL_FRAMES_CTRL_ENABLE;
+	writel(regval, base + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
+
+	regval = readl(base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
+	regval &= ~SOCE_CUSTOM_RULES_TAGGING_ENABLE;
+	writel(regval, base + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
+}
+
+static void soce_port_select(struct soce_dsa_local *local, int port)
+{
+	writel(FIELD_PREP(SOCE_PORTS_SELECTOR_PORT_MASK, port),
+	       local->base_addr + SOCE_PORTS_SELECTOR_OFFSET);
+}
+
+static void soce_port_set_enabled(struct soce_dsa_local *local, int port,
+				  bool enabled)
+{
+	void __iomem *base = local->base_addr;
+	u32 regval;
+
+	soce_port_select(local, port);
+
+	regval = readl(base + SOCE_PORTS_CTRL_OFFSET);
+	if (enabled)
+		regval |= SOCE_PORTS_CTRL_INGR_EN | SOCE_PORTS_CTRL_EGR_EN;
+	else
+		regval &= ~(SOCE_PORTS_CTRL_INGR_EN | SOCE_PORTS_CTRL_EGR_EN);
+	writel(regval, base + SOCE_PORTS_CTRL_OFFSET);
+}
+
+static int soce_port_enable(struct dsa_switch *ds, int port,
+			    struct phy_device *phy)
+{
+	struct soce_priv *priv = ds->priv;
+
+	soce_port_set_enabled(&priv->local, port, true);
+
+	return 0;
+}
+
+static void soce_port_disable(struct dsa_switch *ds, int port)
+{
+	struct soce_priv *priv = ds->priv;
+
+	soce_port_set_enabled(&priv->local, port, false);
+}
+
+static int soce_setup(struct dsa_switch *ds)
+{
+	struct soce_priv *priv = ds->priv;
+
+	soce_sw_enable_tagging(&priv->local);
+
+	return 0;
+}
+
+static void soce_teardown(struct dsa_switch *ds)
+{
+	struct soce_priv *priv = ds->priv;
+
+	soce_sw_disable_tagging(&priv->local);
+}
+
+static enum dsa_tag_protocol soce_get_tag_protocol(struct dsa_switch *ds,
+						   int port,
+						   enum dsa_tag_protocol mprop)
+{
+	return DSA_TAG_PROTO_SDSA;
+}
+
+static const struct dsa_switch_ops soce_switch_ops = {
+	.get_tag_protocol	= soce_get_tag_protocol,
+	.setup			= soce_setup,
+	.teardown		= soce_teardown,
+	.phylink_get_caps	= soce_phylink_get_caps,
+	.port_enable		= soce_port_enable,
+	.port_disable		= soce_port_disable,
+};
+
+static int soce_sw_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct soce_dsa_local *local;
+	struct soce_priv *priv;
+	struct dsa_switch *ds;
+	u8 hw_subversion;
+	u16 hw_revision;
+	u32 hw_numports;
+	u8 hw_version;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ds = &priv->ds;
+	ds->dev = dev;
+	ds->priv = priv;
+
+	local = &priv->local;
+	local->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(local->base_addr))
+		return PTR_ERR(local->base_addr);
+
+	soce_sw_read_core_version(local, &hw_version, &hw_subversion,
+				  &hw_revision);
+
+	ret = soce_sw_detect_features(local, &hw_numports);
+	if (ret) {
+		if (ret == -ENODEV)
+			dev_err(dev, "switch core does not implement DSA\n");
+		else
+			dev_err(dev,
+				"invalid licensed or implemented features register\n");
+		return ret;
+	}
+
+	ret = soce_sw_validate_core_version(hw_version, hw_subversion);
+	if (ret) {
+		dev_err(dev, "unsupported switch core version %.2X.%.2X.%.4X\n",
+			hw_version, hw_subversion, hw_revision);
+		return ret;
+	}
+
+	ds->ops = &soce_switch_ops;
+	ds->num_ports = hw_numports;
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to populate child devices\n");
+
+	dev_set_drvdata(dev, priv);
+
+	ret = dsa_register_switch(ds);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register DSA switch\n");
+
+	dev_info(dev,
+		 "probed soce switch core version %02x.%02x.%04x with %u ports\n",
+		 hw_version, hw_subversion, hw_revision, hw_numports);
+	return 0;
+}
+
+static void soce_sw_remove(struct platform_device *pdev)
+{
+	struct soce_priv *priv = platform_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	dsa_unregister_switch(&priv->ds);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static void soce_sw_shutdown(struct platform_device *pdev)
+{
+	struct soce_priv *priv = platform_get_drvdata(pdev);
+
+	if (!priv)
+		return;
+
+	dsa_switch_shutdown(&priv->ds);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static const struct of_device_id soce_of_match[] = {
+	{ .compatible = "soce,swip-00-04-0c-10" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver soce_driver = {
+	.probe = soce_sw_probe,
+	.remove = soce_sw_remove,
+	.shutdown = soce_sw_shutdown,
+	.driver = {
+		.name = "soce-swip",
+		.of_match_table = soce_of_match,
+	},
+};
+
+module_platform_driver(soce_driver);
+MODULE_DEVICE_TABLE(of, soce_of_match);
+MODULE_AUTHOR("Vasilij Strassheim <v.strassheim@linutronix.de>");
+MODULE_DESCRIPTION("Driver for SoC-e ethernet switch family");
+MODULE_LICENSE("GPL");
+MODULE_SOFTDEP("pre: mdio-soce mdio-mux-mmioreg");

-- 
2.39.5

