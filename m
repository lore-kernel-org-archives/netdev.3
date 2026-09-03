Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9524FECEF;
	Thu,  3 Sep 2026 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459113; cv=none; b=QuiR5rKdKvyHZS0OmJs8RTH7FqtggJvwIYi3sqiDDIaa8K9KyfFWONVagDJWRuNRYTh71HUN/AQAV4JkD6AW383aSso8U6MHVGGEoyndovhrLD1/+rvlajEE0YaCKRvX8eQb8RFOeRG3e30wXCj2gBCy1HUD/DW0434Jp3HCg5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459113; c=relaxed/simple;
	bh=LhxHs9DqooqXpENPvL+fc0rTJiNzxeLqkNetZa9UpUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+YG1moinN/Z1fbeuZTfpa4TLEv+iKl0cEGpx0Hq0IsA4jeYYHTnTOaZuhAO1yP1x/VYm0+fx0Ya+2Tx2xHwY609VZm87XFj+L7ridEAN5vwAPNkhCuzvJMYl0Sta5GJbjNSN0T190fbeQlBmDcC0EZd0y9CTYoSjRzROf0seB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wespURYI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZqJKiW/k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wespURYI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZqJKiW/k"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788459106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plFndZhQx/b/89NM0Q4ZzhYixbux0MsQFRYcLkRRl9s=;
	b=wespURYIvZXe1cNXKdFLrw4EKbXwtnROrEFpwpLJBpfFiRZ/rXrZQGHHs9c0lBGuUEsKed
	FO0hQBe/GnYVSAKDDI1/1BLleZUcQnvVeLoXnBGf51pZystLR6wB7qCS1802ZGM+mZJoyV
	id9WXg+jVktBiPpqZz7G4Iq8fCadAThJQNDftxz52wEPWRWPge5iv3WsU2rXE4khOVXCLY
	cLv0jS4pOQa1CmbzBvqrSWUtFAJ5KnNq+juekQy/P6fe3Or5S3pq1p2mbL1zi0e7jGsvCp
	5hcnOXBTCt4b5dvPxwDphaqm5A4TMQMhQcTbaO6hHDb+X8nAg9yfPkbiwsq14A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788459106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=plFndZhQx/b/89NM0Q4ZzhYixbux0MsQFRYcLkRRl9s=;
	b=ZqJKiW/kLyiBaBeIsHHRlGPeU0NrdILF28TEiGuscNkGeOetX7EP1JjuqQ7VWkApFXf83V
	azNMX2q6P/jaGrAQ==
Date: Thu, 03 Sep 2026 20:11:01 +0200
Subject: [PATCH net-next v2 4/4] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-devel-vstrassheim-soce-dsa-ml-v2-4-fb0587cb466b@linutronix.de>
References: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
In-Reply-To: <20260903-devel-vstrassheim-soce-dsa-ml-v2-0-fb0587cb466b@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Benedikt Spranger <b.spranger@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add an initial DSA driver for SoC-e FPGA-based Ethernet switch IP cores.

The driver accesses the switch through a memory-mapped register
interface. During probe, it detects the core version and the licensed
and implemented port counts, and verifies that the synthesized core
provides DSA support. Port counts from 1 through 31 are supported.

Enable "DSA custom rules" feature for all frames and derive the phylink
capabilities from each port's phy-mode. Enabling this tagging feature of
the switch, places all user ports into CPU-directed operation: frames
received on user ports are forwarded exclusively to the CPU port and
tagged with their source port. Consequently, standalone ports remain
isolated.

This switch IP core also has an integrated MDIO controller (called MDIO
Bridge). Expose each configured hardware MDIO output as a separate
logical MDIO bus. The buses support Clause 22 and Clause 45 transactions
and serialize access to the shared MDIO controller.

Tested with a SoC-e MRS 25.01 IP core on a Xilinx ZynqMP platform.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 drivers/net/dsa/Kconfig              |   2 +
 drivers/net/dsa/Makefile             |   1 +
 drivers/net/dsa/soce/Kconfig         |  12 +
 drivers/net/dsa/soce/Makefile        |   4 +
 drivers/net/dsa/soce/soce_dsa.h      |  44 ++++
 drivers/net/dsa/soce/soce_dsa_core.c | 297 +++++++++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.c     | 411 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.h     |  38 ++++
 8 files changed, 809 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 8d8edcf89f10..1422b9c5bf85 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -94,6 +94,8 @@ source "drivers/net/dsa/ocelot/Kconfig"
 
 source "drivers/net/dsa/qca/Kconfig"
 
+source "drivers/net/dsa/soce/Kconfig"
+
 source "drivers/net/dsa/sja1105/Kconfig"
 
 source "drivers/net/dsa/xrs700x/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index df849cd0e640..b1336d5b3989 100644
--- a/drivers/net/dsa/Makefile
+++ b/drivers/net/dsa/Makefile
@@ -27,4 +27,5 @@ obj-y				+= ocelot/
 obj-y				+= qca/
 obj-y				+= realtek/
 obj-y				+= sja1105/
+obj-y				+= soce/
 obj-y				+= xrs700x/
diff --git a/drivers/net/dsa/soce/Kconfig b/drivers/net/dsa/soce/Kconfig
new file mode 100644
index 000000000000..321da9835402
--- /dev/null
+++ b/drivers/net/dsa/soce/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+config NET_DSA_SOCE
+	tristate "SoC-e switches"
+	depends on NET_DSA
+	depends on OF
+	depends on HAS_IOMEM
+	select NET_DSA_TAG_SDSA
+	help
+	  This enables support for switches based on SoC-e IP cores.
+	  Frames are exchanged with the CPU port using the SDSA DSA tag protocol.
+	  The driver supports switch variants whose features and number of ports
+	  are selected at synthesis time and detected at runtime.
diff --git a/drivers/net/dsa/soce/Makefile b/drivers/net/dsa/soce/Makefile
new file mode 100644
index 000000000000..c2635fe19643
--- /dev/null
+++ b/drivers/net/dsa/soce/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NET_DSA_SOCE) += soce_dsa.o
+soce_dsa-objs := soce_dsa_core.o soce_mdio.o
diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soce_dsa.h
new file mode 100644
index 000000000000..ef01304209e6
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_dsa.h
@@ -0,0 +1,44 @@
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
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define SOCE_MAX_NUM_PORTS 31
+#define SOCE_MAX_MDIO_ADDR 32
+#define SOCE_MAX_MDIO_OUTPUTS SOCE_MAX_NUM_PORTS
+
+struct dsa_switch;
+
+struct soce_mdio_ops {
+	int (*phy_read)(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			int regnum);
+	int (*phy_write)(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			 int regnum, u16 val);
+	int (*phy_read_c45)(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			    int devad, int regnum);
+	int (*phy_write_c45)(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			     int devad, int regnum, u16 val);
+};
+
+struct soce_dsa_local {
+	void __iomem *base_addr;
+	void __iomem *mdio_master_addr;
+	/* Serializes all logical buses sharing the MDIO master. */
+	struct mutex mdio_lock;
+	const struct soce_mdio_ops *mdio_ops;
+};
+
+struct soce_priv {
+	struct soce_dsa_local local;
+	struct dsa_switch *ds;
+};
+
+#endif /* __SOCE_DSA_H */
diff --git a/drivers/net/dsa/soce/soce_dsa_core.c b/drivers/net/dsa/soce/soce_dsa_core.c
new file mode 100644
index 000000000000..60f9f8c030e8
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_dsa_core.c
@@ -0,0 +1,297 @@
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
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+#include <linux/platform_device.h>
+
+#include <net/dsa.h>
+
+#include "soce_dsa.h"
+#include "soce_mdio.h"
+
+#define SOCE_CORE_VERSION_SHIFT			24
+#define SOCE_CORE_SUBVERSION_SHIFT		16
+#define SOCE_LICENSED_NUM_PORTS_MASK		GENMASK(31, 27)
+#define SOCE_IMPLEMENTED_NUM_PORTS_MASK		GENMASK(31, 27)
+#define SOCE_IMPLEMENTED_DSA			BIT(23)
+#define SOCE_DSA_REGS_BASE			0x1200
+#define SOCE_TAG_ALL_FRAMES_CTRL_OFFSET		(SOCE_DSA_REGS_BASE + 0x001c)
+#define SOCE_TAG_ALL_FRAMES_ENABLE		BIT(0)
+#define SOCE_CUSTOM_RULES_TAGGING_OFFSET	(SOCE_DSA_REGS_BASE + 0x0020)
+#define SOCE_CUSTOM_RULES_TAGGING_ENABLE	BIT(0)
+#define SOCE_MIN_CORE_VERSION			0x24
+#define SOCE_MIN_CORE_SUBVERSION		0x01
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
+static const struct soce_mdio_ops soce_mdio_ops_c22_c45 = {
+	.phy_read	= soce_mdio_23_02_read,
+	.phy_write	= soce_mdio_23_02_write,
+	.phy_read_c45	= soce_mdio_23_02_read_c45,
+	.phy_write_c45	= soce_mdio_23_02_write_c45,
+};
+
+struct soce_probe_desc {
+	u32 core_version_offset;
+	u32 licensed_features_offset;
+	u32 implemented_features0_offset;
+	u32 mdio_master_offset;
+};
+
+static const struct soce_probe_desc soce_probe_desc_swip_00_04_0c_10 = {
+	.core_version_offset		= 0x0000,
+	.licensed_features_offset	= 0x0004,
+	.implemented_features0_offset	= 0x000c,
+	.mdio_master_offset		= 0x0200,
+};
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
+				      const struct soce_probe_desc *probe_desc,
+				      u8 *version, u8 *subversion, u16 *revision)
+{
+	u32 regval;
+
+	regval = readl(local->base_addr + probe_desc->core_version_offset);
+	*version = (u8)(regval >> SOCE_CORE_VERSION_SHIFT);
+	*subversion = (u8)(regval >> SOCE_CORE_SUBVERSION_SHIFT);
+	*revision = (u16)regval;
+}
+
+static int soce_sw_detect_features(struct soce_dsa_local *local,
+				   const struct soce_probe_desc *probe_desc,
+				   u32 *numports)
+{
+	u32 implemented_numports;
+	u32 licensed_numports;
+	u32 regval;
+
+	regval = readl(local->base_addr + probe_desc->licensed_features_offset);
+	licensed_numports = FIELD_GET(SOCE_LICENSED_NUM_PORTS_MASK, regval);
+	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
+		return -EINVAL;
+
+	regval = readl(local->base_addr +
+		       probe_desc->implemented_features0_offset);
+	if (!(regval & SOCE_IMPLEMENTED_DSA))
+		return -ENODEV;
+
+	implemented_numports = FIELD_GET(SOCE_IMPLEMENTED_NUM_PORTS_MASK,
+					 regval);
+	if (!implemented_numports ||
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
+	u32 regval;
+
+	regval = readl(local->base_addr + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
+	regval |= SOCE_TAG_ALL_FRAMES_ENABLE;
+	writel(regval, local->base_addr + SOCE_TAG_ALL_FRAMES_CTRL_OFFSET);
+
+	regval = readl(local->base_addr + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
+	regval |= SOCE_CUSTOM_RULES_TAGGING_ENABLE;
+	writel(regval, local->base_addr + SOCE_CUSTOM_RULES_TAGGING_OFFSET);
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
+	.phylink_get_caps	= soce_phylink_get_caps,
+};
+
+static int soce_sw_probe(struct platform_device *pdev)
+{
+	const struct soce_probe_desc *probe_desc;
+	struct device *dev = &pdev->dev;
+	struct soce_dsa_local *local;
+	struct soce_priv *priv;
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
+	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->dev = dev;
+	priv->ds->priv = priv;
+	probe_desc = of_device_get_match_data(dev);
+	if (!probe_desc)
+		return -EINVAL;
+
+	local = &priv->local;
+	mutex_init(&local->mdio_lock);
+
+	local->base_addr = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(local->base_addr))
+		return PTR_ERR(local->base_addr);
+
+	soce_sw_read_core_version(local, probe_desc, &hw_version,
+				  &hw_subversion, &hw_revision);
+
+	ret = soce_sw_detect_features(local, probe_desc, &hw_numports);
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
+	priv->ds->ops = &soce_switch_ops;
+	local->mdio_ops = &soce_mdio_ops_c22_c45;
+	local->mdio_master_addr =
+		local->base_addr + probe_desc->mdio_master_offset;
+
+	priv->ds->num_ports = hw_numports;
+	ret = soce_sw_register_mdio_buses(priv, dev, hw_numports);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(dev, priv);
+
+	ret = dsa_register_switch(priv->ds);
+	if (ret)
+		return ret;
+
+	dev_info(dev,
+		 "probed soce switch core version %02x.%02x.%04x with %u ports\n",
+		 hw_version, hw_subversion, hw_revision, hw_numports);
+
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
+	dsa_unregister_switch(priv->ds);
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
+	dsa_switch_shutdown(priv->ds);
+	platform_set_drvdata(pdev, NULL);
+}
+
+static const struct of_device_id soce_of_match[] = {
+	{ .compatible = "soce,swip-00-04-0c-10",
+	  .data = &soce_probe_desc_swip_00_04_0c_10 },
+	{ /* sentinel */ },
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
diff --git a/drivers/net/dsa/soce/soce_mdio.c b/drivers/net/dsa/soce/soce_mdio.c
new file mode 100644
index 000000000000..692dcbe57d1a
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_mdio.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mdio.h>
+#include <linux/of.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+
+#include <net/dsa.h>
+
+#include "soce_dsa.h"
+#include "soce_mdio.h"
+
+#define SOCE_MDIO_TIMEOUT 1000
+#define SOCE_MDIO_C22_REG_MAX 0x1f
+#define SOCE_MDIO_C45_DEVAD_MAX 0x1f
+#define SOCE_MDIO_C45_REG_MAX 0xffff
+
+static inline bool soce_mdio_output_valid(int mdio_output)
+{
+	return mdio_output >= 0 && mdio_output < SOCE_MAX_MDIO_OUTPUTS;
+}
+
+static inline bool soce_mdio_addr_valid(int phy_addr)
+{
+	return phy_addr >= 0 && phy_addr < SOCE_MAX_MDIO_ADDR;
+}
+
+static inline bool soce_mdio_c22_reg_valid(int regnum)
+{
+	return regnum >= 0 && regnum <= SOCE_MDIO_C22_REG_MAX;
+}
+
+static inline bool soce_mdio_c45_params_valid(int devad, int regnum)
+{
+	return devad >= 0 && devad <= SOCE_MDIO_C45_DEVAD_MAX &&
+	       regnum >= 0 && regnum <= SOCE_MDIO_C45_REG_MAX;
+}
+
+struct soce_mdio_bus {
+	struct dsa_switch *ds;
+	u32 mdio_output;
+};
+
+static int soce_mdio_read(struct mii_bus *bus, int addr, int reg)
+{
+	struct soce_mdio_bus *state = bus->priv;
+	struct soce_dsa_local *local;
+	struct soce_priv *priv;
+	int ret;
+
+	priv = state->ds->priv;
+	local = &priv->local;
+
+	if (!local->mdio_ops || !local->mdio_ops->phy_read)
+		return -EOPNOTSUPP;
+
+	if (!soce_mdio_addr_valid(addr))
+		return -EINVAL;
+
+	mutex_lock(&local->mdio_lock);
+	ret = local->mdio_ops->phy_read(state->ds, state->mdio_output, addr,
+					reg);
+	mutex_unlock(&local->mdio_lock);
+
+	return ret;
+}
+
+static int soce_mdio_write(struct mii_bus *bus, int addr, int reg, u16 val)
+{
+	struct soce_mdio_bus *state = bus->priv;
+	struct soce_dsa_local *local;
+	struct soce_priv *priv;
+	int ret;
+
+	priv = state->ds->priv;
+	local = &priv->local;
+
+	if (!local->mdio_ops || !local->mdio_ops->phy_write)
+		return -EOPNOTSUPP;
+
+	if (!soce_mdio_addr_valid(addr))
+		return -EINVAL;
+
+	mutex_lock(&local->mdio_lock);
+	ret = local->mdio_ops->phy_write(state->ds, state->mdio_output, addr,
+					 reg, val);
+	mutex_unlock(&local->mdio_lock);
+
+	return ret;
+}
+
+static int soce_mdio_read_c45(struct mii_bus *bus, int addr, int devad,
+			      int regnum)
+{
+	struct soce_mdio_bus *state = bus->priv;
+	struct soce_dsa_local *local;
+	struct soce_priv *priv;
+	int ret;
+
+	priv = state->ds->priv;
+	local = &priv->local;
+
+	if (!local->mdio_ops || !local->mdio_ops->phy_read_c45)
+		return -EOPNOTSUPP;
+
+	if (!soce_mdio_addr_valid(addr))
+		return -EINVAL;
+
+	mutex_lock(&local->mdio_lock);
+	ret = local->mdio_ops->phy_read_c45(state->ds, state->mdio_output,
+					    addr, devad, regnum);
+	mutex_unlock(&local->mdio_lock);
+
+	return ret;
+}
+
+static int soce_mdio_write_c45(struct mii_bus *bus, int addr, int devad,
+			       int regnum, u16 val)
+{
+	struct soce_mdio_bus *state = bus->priv;
+	struct soce_dsa_local *local;
+	struct soce_priv *priv;
+	int ret;
+
+	priv = state->ds->priv;
+	local = &priv->local;
+
+	if (!local->mdio_ops || !local->mdio_ops->phy_write_c45)
+		return -EOPNOTSUPP;
+
+	if (!soce_mdio_addr_valid(addr))
+		return -EINVAL;
+
+	mutex_lock(&local->mdio_lock);
+	ret = local->mdio_ops->phy_write_c45(state->ds, state->mdio_output,
+					     addr, devad, regnum, val);
+	mutex_unlock(&local->mdio_lock);
+
+	return ret;
+}
+
+static int soce_register_mdio_bus(struct soce_priv *priv, struct device *dev,
+				  struct device_node *mdio_np,
+				  u32 mdio_output)
+{
+	struct soce_mdio_bus *state;
+	struct mii_bus *bus;
+
+	bus = devm_mdiobus_alloc(dev);
+	if (!bus)
+		return -ENOMEM;
+
+	state = devm_kzalloc(dev, sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	state->ds = priv->ds;
+	state->mdio_output = mdio_output;
+
+	bus->priv = state;
+	bus->name = "soce mdio";
+	bus->read = soce_mdio_read;
+	bus->write = soce_mdio_write;
+	bus->read_c45 = soce_mdio_read_c45;
+	bus->write_c45 = soce_mdio_write_c45;
+	/* ds->dst can be NULL during probe, before dsa_register_switch() */
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-mdio-%u", dev_name(dev),
+		 mdio_output);
+	bus->parent = dev;
+
+	return devm_of_mdiobus_register(dev, bus, mdio_np);
+}
+
+int soce_sw_register_mdio_buses(struct soce_priv *priv, struct device *dev,
+				u32 numports)
+{
+	struct device_node *mdios_node;
+	u32 mdio_output;
+	int ret = 0;
+
+	mdios_node = of_get_child_by_name(dev->of_node, "mdios");
+	if (!mdios_node)
+		return 0;
+
+	for_each_available_child_of_node_scoped(mdios_node, mdio_node) {
+		ret = of_property_read_u32(mdio_node, "reg", &mdio_output);
+		if (ret) {
+			dev_err(dev, "missing reg in %pOF\n", mdio_node);
+			goto out_put_mdio;
+		}
+
+		if (mdio_output >= numports) {
+			dev_err(dev,
+				"MDIO output %u in %pOF exceeds hardware limit %u\n",
+				mdio_output, mdio_node, numports - 1);
+			ret = -EINVAL;
+			goto out_put_mdio;
+		}
+
+		ret = soce_register_mdio_bus(priv, dev, mdio_node, mdio_output);
+		if (ret)
+			goto out_put_mdio;
+	}
+
+out_put_mdio:
+	of_node_put(mdios_node);
+	return ret;
+}
+
+static int soce_mdio_23_02_wait_for_idle(struct dsa_switch *ds)
+{
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	void __iomem *ctrl;
+	u32 val;
+
+	local = &priv->local;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+
+	return readl_poll_timeout(ctrl, val,
+		!(val & (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET)), 10,
+		SOCE_MDIO_TIMEOUT * 1000);
+}
+
+static int soce_mdio_23_02_read_c22(struct dsa_switch *ds, int mdio_output,
+				    int phy_addr, int regnum)
+{
+	void __iomem *ctrl, *params, *read_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	u32 regvalue;
+	int ret;
+
+	local = &priv->local;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	read_reg = local->mdio_master_addr + SOCE_MDIO_23_02_READ_OFFSET;
+
+	regvalue = (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x3 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x0 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	ret = soce_mdio_23_02_wait_for_idle(ds);
+	if (ret)
+		return ret;
+
+	return readl(read_reg) & 0xffff;
+}
+
+int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int mdio_output,
+			     int phy_addr, int devad, int regnum)
+{
+	void __iomem *ctrl, *params, *read_reg, *write_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	u32 regvalue;
+	int ret;
+
+	if (!soce_mdio_output_valid(mdio_output) ||
+	    !soce_mdio_addr_valid(phy_addr) ||
+	    !soce_mdio_c45_params_valid(devad, regnum))
+		return -EINVAL;
+
+	local = &priv->local;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_23_02_WRITE_OFFSET;
+	read_reg = local->mdio_master_addr + SOCE_MDIO_23_02_READ_OFFSET;
+
+	regvalue = (devad << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	writel(regnum, write_reg);
+
+	/* address cycle */
+	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x0 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	ret = soce_mdio_23_02_wait_for_idle(ds);
+	if (ret)
+		return ret;
+
+	/* read cycle */
+	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x3 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	ret = soce_mdio_23_02_wait_for_idle(ds);
+	if (ret)
+		return ret;
+
+	return readl(read_reg) & 0xffff;
+}
+
+int soce_mdio_23_02_read(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			 int regnum)
+{
+	if (!soce_mdio_output_valid(mdio_output) ||
+	    !soce_mdio_addr_valid(phy_addr) ||
+	    !soce_mdio_c22_reg_valid(regnum))
+		return -EINVAL;
+
+	return soce_mdio_23_02_read_c22(ds, mdio_output, phy_addr, regnum);
+}
+
+static int soce_mdio_23_02_write_c22(struct dsa_switch *ds, int mdio_output,
+				     int phy_addr, int regnum, u16 val)
+{
+	void __iomem *ctrl, *params, *write_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	u32 regvalue;
+
+	local = &priv->local;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_23_02_WRITE_OFFSET;
+
+	regvalue = (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	writel(val, write_reg);
+
+	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x0 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	return soce_mdio_23_02_wait_for_idle(ds);
+}
+
+int soce_mdio_23_02_write_c45(struct dsa_switch *ds, int mdio_output,
+			      int phy_addr, int devad, int regnum, u16 val)
+{
+	void __iomem *ctrl, *params, *write_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	u32 regvalue;
+	int ret;
+
+	if (!soce_mdio_output_valid(mdio_output) ||
+	    !soce_mdio_addr_valid(phy_addr) ||
+	    !soce_mdio_c45_params_valid(devad, regnum))
+		return -EINVAL;
+
+	local = &priv->local;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_23_02_WRITE_OFFSET;
+
+	regvalue = (devad << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	writel(regnum, write_reg);
+
+	/* address cycle */
+	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x0 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	ret = soce_mdio_23_02_wait_for_idle(ds);
+	if (ret)
+		return ret;
+
+	writel(val, write_reg);
+
+	/* write cycle */
+	regvalue = ((mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	return soce_mdio_23_02_wait_for_idle(ds);
+}
+
+int soce_mdio_23_02_write(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			  int regnum, u16 val)
+{
+	if (!soce_mdio_output_valid(mdio_output) ||
+	    !soce_mdio_addr_valid(phy_addr) ||
+	    !soce_mdio_c22_reg_valid(regnum))
+		return -EINVAL;
+
+	return soce_mdio_23_02_write_c22(ds, mdio_output, phy_addr, regnum, val);
+}
diff --git a/drivers/net/dsa/soce/soce_mdio.h b/drivers/net/dsa/soce/soce_mdio.h
new file mode 100644
index 000000000000..f2b21fe50d79
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_mdio.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020-2026 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ * Author: Vasilij Strassheim <v.strassheim@linutronix.de>
+ */
+
+#ifndef __SOCE_MDIO_H
+#define __SOCE_MDIO_H
+
+#define SOCE_MDIO_CTRL_OFFSET 0x0000
+
+/* for newer versions */
+#define SOCE_MDIO_23_02_PARAMS_OFFSET		0x0004
+#define SOCE_MDIO_23_02_WRITE_OFFSET		0x0008
+#define SOCE_MDIO_23_02_READ_OFFSET		0x000c
+#define SOCE_MDIO_23_02_CTRL_BUS_OFFSET		16
+#define SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET	3
+#define SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET	1
+#define SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET	0
+
+#define SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET	8
+#define SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET		0
+
+struct device;
+struct soce_priv;
+
+int soce_mdio_23_02_read(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			 int regnum);
+int soce_mdio_23_02_write(struct dsa_switch *ds, int mdio_output, int phy_addr,
+			  int regnum, u16 val);
+int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int mdio_output,
+			     int phy_addr, int devad, int regnum);
+int soce_mdio_23_02_write_c45(struct dsa_switch *ds, int mdio_output,
+			      int phy_addr, int devad, int regnum, u16 val);
+int soce_sw_register_mdio_buses(struct soce_priv *priv, struct device *dev,
+				u32 numports);
+#endif /* __SOCE_MDIO_H */

-- 
2.39.5

