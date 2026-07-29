Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8B54C6F18;
	Wed, 29 Jul 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343077; cv=none; b=O2knqRFNwjHBFsBhsPCSEDMjdM/XMbveBgIMgxwHRzV3/2OglDvGNrfLe3MyUlAQ/yCE8C3IAgEkfz07UKwz4d2h0+P+TvhmIOMOZJo2QiXtlFoFJzn0L/aHXuOTjgWvknMalpCrNsLXIpbLdydtoseDlO4Vs8kkZjVTGhE/VZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343077; c=relaxed/simple;
	bh=mdQ1uLa3iTCxVnGLXyfWDc8vu2hAx6oFgXPX0jupsD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WdOACPdJ5qN+iIQFwep3kt+lTOPRF9jNpFmUb/vf+ig5QrNoKu5lIJBXHAKfQlSFB9l5gr/Iu+YPMNRptxliBcYzmNsyUrrSvS+yhOZfc9c5aC8DRWNcqXK9KSHXNh3PKPDpMrbQIc5jxRTREiqL2i9kSbTrU35lOkiEXJGRxlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUHN8iXP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p8m1frkF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUHN8iXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p8m1frkF"
From: Vasilij Strassheim <v.strassheim@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785343066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/MA751o/xq0PiTQv/PSUMs+Sarj6NUufbAfEaZ6foU=;
	b=cUHN8iXPR3RhxdS4jz+I1LT4K3Si/+I7KvkiLxJW9lKGxneMoTXFocpgoe2a6pTD9CBthH
	O6GHWor7lBWk2kKJqZuZ4FDjf1+nk/3tn5FhZXd6UYA7ZxvMhz/Cf3ARiRJXunfqxI8geB
	FybW550KVqyPxilsEfK19IiP5ZxsVaT1b4mFsq0Q39MsW3Ibvu1QaG5evfV6LEVQRIAmQx
	z8gEG2W7+ut7+SsK5heRfumG+JWbfas5WBOyRxlwaN4HWsNgy2MLLcTuYKr4vmUxZvfhIm
	eKeJAfBR3786TWmAb0IOynDKyEVvVsd5UiX17yZGlE80AntZA7SbKFDNj4BKnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785343066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/MA751o/xq0PiTQv/PSUMs+Sarj6NUufbAfEaZ6foU=;
	b=p8m1frkF+aM1gLCj5BKjed2FUws/l5Go6fbHnw5HufKoVkF5x3Z0AyUFslyt90g/ZvtZkT
	lsTiPGdgLnpgukDQ==
Date: Wed, 29 Jul 2026 18:36:57 +0200
Subject: [PATCH 4/4] net: dsa: soce: Add initial driver support for MRS
 switches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-devel-vstrassheim-soce-dsa-ml-v1-4-be569dae1b20@linutronix.de>
References: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
In-Reply-To: <20260729-devel-vstrassheim-soce-dsa-ml-v1-0-be569dae1b20@linutronix.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>, 
 Vasilij Strassheim <v.strassheim@linutronix.de>

Add initial support for SoC-e switches that are based on FPGA IP cores.
This driver provides MDIO access helpers for supported IP register
layouts and common STP/FDB handling.

Managed Redundant Switch (MRS) variant is introduced first with variant
descriptors and register layout mapping. The implementation has been
designed so that additional variants can be added in the future with
minimal effort.

Tested on SoC-e MRS 25.01 hardware using the 24.01 register layout.

Signed-off-by: Vasilij Strassheim <v.strassheim@linutronix.de>
---
 drivers/net/dsa/Kconfig              |   2 +
 drivers/net/dsa/Makefile             |   1 +
 drivers/net/dsa/soce/Kconfig         |  12 ++
 drivers/net/dsa/soce/Makefile        |   6 +
 drivers/net/dsa/soce/soce_common.c   | 159 +++++++++++++++
 drivers/net/dsa/soce/soce_common.h   |  36 ++++
 drivers/net/dsa/soce/soce_dsa.h      |  41 ++++
 drivers/net/dsa/soce/soce_dsa_core.c | 354 ++++++++++++++++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.c     | 381 +++++++++++++++++++++++++++++++++++
 drivers/net/dsa/soce/soce_mdio.h     |  40 ++++
 drivers/net/dsa/soce/soce_mrs.h      |  21 ++
 11 files changed, 1053 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..6bf5fd48599b 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -82,6 +82,8 @@ source "drivers/net/dsa/ocelot/Kconfig"
 
 source "drivers/net/dsa/qca/Kconfig"
 
+source "drivers/net/dsa/soce/Kconfig"
+
 source "drivers/net/dsa/sja1105/Kconfig"
 
 source "drivers/net/dsa/xrs700x/Kconfig"
diff --git a/drivers/net/dsa/Makefile b/drivers/net/dsa/Makefile
index d2975badffc0..624b453f576a 100644
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
index 000000000000..97d4e4e838d9
--- /dev/null
+++ b/drivers/net/dsa/soce/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+config NET_DSA_SOCE
+	tristate "Soce switches"
+	depends on NET_DSA
+	depends on OF
+	depends on HAS_IOMEM
+	select NET_DSA_TAG_SDSA
+	help
+	  This enables support for switches based on IP core from SoC-E.
+	  Frames are exchanged with the CPU port using the SDSA DSA tag protocol.
+	  The driver supports different variants and versions of switches which
+	  are configurable at runtime.
diff --git a/drivers/net/dsa/soce/Makefile b/drivers/net/dsa/soce/Makefile
new file mode 100644
index 000000000000..a6e74b7d57df
--- /dev/null
+++ b/drivers/net/dsa/soce/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_NET_DSA_SOCE) += soce_dsa.o
+soce_dsa-objs := soce_dsa_core.o
+soce_dsa-objs += soce_mdio.o
+soce_dsa-objs += soce_common.o
diff --git a/drivers/net/dsa/soce/soce_common.c b/drivers/net/dsa/soce/soce_common.c
new file mode 100644
index 000000000000..f7f345a690e4
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_common.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+#include <linux/if_bridge.h>
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+
+#include "soce_dsa.h"
+#include "soce_mdio.h"
+#include "soce_common.h"
+
+#define SOCE_FAST_AGE_POLL_US		10
+#define SOCE_FAST_AGE_TIMEOUT_US	100000
+
+#define SOCE_STP_PORTS_PER_STATUS_REG	16
+#define SOCE_STP_PORT_STATE_WIDTH	2
+#define SOCE_STP_PORT_STATE_WRITE	BIT(0)
+#define SOCE_STP_MSTID_CIST		0
+
+#define SOCE_STP_PORT_STATE_MASK GENMASK(SOCE_STP_PORT_STATE_WIDTH - 1, 0)
+
+#define SOCE_FDB_CLEAR_UNDER_PROCESS	BIT(7)
+#define SOCE_FDB_CLEAR_FLUSH_MSTID	BIT(4)
+
+static u8 soce_map_stp_state(u8 state)
+{
+	switch (state) {
+	case BR_STATE_DISABLED:
+	case BR_STATE_BLOCKING:
+	case BR_STATE_LISTENING:
+		return 0;
+	case BR_STATE_LEARNING:
+		return 1;
+	case BR_STATE_FORWARDING:
+	default:
+		return 3;
+	}
+}
+
+static void soce_stp_state_set(struct dsa_switch *ds, int port, u8 state,
+			       const struct soce_layout *layout)
+{
+	void __iomem *p_mstp_mstid, *p_mstp_ps_hi, *p_mstp_ps_lo, *p_mstp_pc;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	u32 ps_hi_n, ps_lo_n;
+	u8 stp_state;
+
+	local = &priv->local;
+	if (!layout || !local->base_addr)
+		return;
+
+	stp_state = soce_map_stp_state(state);
+	p_mstp_pc = local->base_addr + layout->mstp_port_state_control;
+	p_mstp_mstid = local->base_addr + layout->mstp_mstid;
+	p_mstp_ps_lo = local->base_addr + layout->mstp_port_state_lo;
+	p_mstp_ps_hi = local->base_addr + layout->mstp_port_state_hi;
+
+	/* Keep the extra MSTP MSTID write taken from the vendor sequence. */
+	writel(SOCE_STP_MSTID_CIST, p_mstp_mstid);
+
+	ps_lo_n = readl(p_mstp_ps_lo);
+	ps_hi_n = readl(p_mstp_ps_hi);
+
+	if (port >= SOCE_STP_PORTS_PER_STATUS_REG) {
+		port -= SOCE_STP_PORTS_PER_STATUS_REG;
+		ps_hi_n =
+			((ps_hi_n & ~(SOCE_STP_PORT_STATE_MASK
+				      << (port * SOCE_STP_PORT_STATE_WIDTH))) |
+			 (stp_state << (port * SOCE_STP_PORT_STATE_WIDTH)));
+	} else {
+		ps_lo_n =
+			((ps_lo_n & ~(SOCE_STP_PORT_STATE_MASK
+				      << (port * SOCE_STP_PORT_STATE_WIDTH))) |
+			 (stp_state << (port * SOCE_STP_PORT_STATE_WIDTH)));
+	}
+
+	writel(SOCE_STP_MSTID_CIST, p_mstp_mstid);
+	writel(ps_lo_n, p_mstp_ps_lo);
+	writel(ps_hi_n, p_mstp_ps_hi);
+	writel(SOCE_STP_PORT_STATE_WRITE, p_mstp_pc);
+}
+
+static void soce_fast_age(struct dsa_switch *ds, int port,
+			  const struct soce_layout *layout)
+{
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	void __iomem *p_mes_ctrl;
+	u32 val;
+
+	local = &priv->local;
+	if (!layout || !local->base_addr)
+		return;
+
+	p_mes_ctrl = local->base_addr + layout->fdb_ctrl;
+	if (readl_poll_timeout(p_mes_ctrl, val,
+			       !(val & SOCE_FDB_CLEAR_UNDER_PROCESS),
+			       SOCE_FAST_AGE_POLL_US, SOCE_FAST_AGE_TIMEOUT_US))
+		dev_warn(ds->dev, "SoC-e fast_age timeout on port %d\n", port);
+
+	writel(SOCE_FDB_CLEAR_FLUSH_MSTID, p_mes_ctrl);
+}
+
+int soce_setup(struct dsa_switch *ds)
+{
+	return soce_user_mii_bus_register(ds);
+}
+
+void soce_teardown(struct dsa_switch *ds)
+{
+	soce_user_mii_bus_unregister(ds);
+}
+
+int soce_port_enable(struct dsa_switch *ds, int port, struct phy_device *phy)
+{
+	return 0;
+}
+
+void soce_port_disable(struct dsa_switch *ds, int port)
+{
+}
+
+enum dsa_tag_protocol soce_get_tag_protocol(struct dsa_switch *ds, int port,
+					    enum dsa_tag_protocol mprop)
+{
+	return DSA_TAG_PROTO_SDSA;
+}
+
+/* Bridge membership is handled by the switch forwarding model directly. */
+int soce_port_bridge_join(struct dsa_switch *ds, int port,
+			  struct dsa_bridge bridge, bool *tx_fwd_offload,
+			  struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
+void soce_port_bridge_leave(struct dsa_switch *ds, int port,
+			    struct dsa_bridge bridge)
+{
+}
+
+void soce_port_stp_state_set(struct dsa_switch *ds, int port, u8 state)
+{
+	struct soce_priv *priv = ds->priv;
+
+	soce_stp_state_set(ds, port, state, priv->local.layout);
+}
+
+void soce_port_fast_age(struct dsa_switch *ds, int port)
+{
+	struct soce_priv *priv = ds->priv;
+
+	soce_fast_age(ds, port, priv->local.layout);
+}
+
diff --git a/drivers/net/dsa/soce/soce_common.h b/drivers/net/dsa/soce/soce_common.h
new file mode 100644
index 000000000000..2423ba167d9f
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_common.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#ifndef __SOCE_COMMON_H
+#define __SOCE_COMMON_H
+
+#include <net/dsa.h>
+
+struct phy_device;
+struct netlink_ext_ack;
+
+struct soce_layout {
+	u32 mstp_port_state_control;
+	u32 mstp_mstid;
+	u32 mstp_port_state_lo;
+	u32 mstp_port_state_hi;
+	u32 fdb_ctrl;
+};
+
+int soce_setup(struct dsa_switch *ds);
+void soce_teardown(struct dsa_switch *ds);
+int soce_port_enable(struct dsa_switch *ds, int port, struct phy_device *phy);
+void soce_port_disable(struct dsa_switch *ds, int port);
+enum dsa_tag_protocol soce_get_tag_protocol(struct dsa_switch *ds, int port,
+					    enum dsa_tag_protocol mprop);
+int soce_port_bridge_join(struct dsa_switch *ds, int port,
+			  struct dsa_bridge bridge, bool *tx_fwd_offload,
+			  struct netlink_ext_ack *extack);
+void soce_port_bridge_leave(struct dsa_switch *ds, int port,
+			    struct dsa_bridge bridge);
+void soce_port_stp_state_set(struct dsa_switch *ds, int port, u8 state);
+void soce_port_fast_age(struct dsa_switch *ds, int port);
+
+#endif /* __SOCE_COMMON_H */
diff --git a/drivers/net/dsa/soce/soce_dsa.h b/drivers/net/dsa/soce/soce_dsa.h
new file mode 100644
index 000000000000..edc79d69891d
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_dsa.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#ifndef __SOCE_DSA_H
+#define __SOCE_DSA_H
+
+#define SOCE_MAX_NUM_PORTS 30
+
+struct soce_mdio {
+	int mdio_output;
+	int phy_addr;
+};
+
+struct dsa_switch;
+struct soce_layout;
+
+struct soce_mdio_ops {
+	int (*phy_read)(struct dsa_switch *ds, int port, int regnum);
+	int (*phy_write)(struct dsa_switch *ds, int port, int regnum, u16 val);
+	int (*phy_read_c45)(struct dsa_switch *ds, int port, int devad,
+			    int regnum);
+	int (*phy_write_c45)(struct dsa_switch *ds, int port, int devad,
+			     int regnum, u16 val);
+};
+
+struct soce_dsa_local {
+	void __iomem *base_addr;
+	void __iomem *mdio_master_addr;
+	struct soce_mdio mdio_info[SOCE_MAX_NUM_PORTS];
+	const struct soce_mdio_ops *mdio_ops;
+	const struct soce_layout *layout;
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
index 000000000000..b88d00c56d71
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_dsa_core.c
@@ -0,0 +1,354 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#include <linux/module.h>
+#include <linux/phy.h>
+#include <linux/netdevice.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <net/dsa.h>
+
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/if_bridge.h>
+#include <linux/mdio.h>
+#include <linux/of_mdio.h>
+#include <linux/etherdevice.h>
+#include <linux/phylink.h>
+
+#include "soce_dsa.h"
+#include "soce_common.h"
+#include "soce_mrs.h"
+#include "soce_mdio.h"
+
+static void soce_phylink_get_caps(struct dsa_switch *ds, int port,
+				  struct phylink_config *config)
+{
+	if (dsa_is_cpu_port(ds, port)) {
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+		config->mac_capabilities = MAC_10 | MAC_100 | MAC_1000 |
+					   MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
+		return;
+	}
+
+	phy_interface_set_rgmii(config->supported_interfaces);
+	config->mac_capabilities = MAC_10 | MAC_100 | MAC_1000 | MAC_SYM_PAUSE |
+				   MAC_ASYM_PAUSE;
+}
+
+static int soce_phy_read(struct dsa_switch *ds, int port, int regnum)
+{
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+
+	local = &priv->local;
+	if (!local->mdio_ops || !local->mdio_ops->phy_read)
+		return 0xffff;
+
+	return local->mdio_ops->phy_read(ds, port, regnum);
+}
+
+static int soce_phy_write(struct dsa_switch *ds, int port, int regnum, u16 val)
+{
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+
+	local = &priv->local;
+	if (!local->mdio_ops || !local->mdio_ops->phy_write)
+		return -EOPNOTSUPP;
+
+	return local->mdio_ops->phy_write(ds, port, regnum, val);
+}
+
+static const struct soce_mdio_ops soce_mdio_ops_20_03 = {
+	.phy_read	= soce_mdio_20_03_read,
+	.phy_write	= soce_mdio_20_03_write,
+};
+
+static const struct soce_mdio_ops soce_mdio_ops_c22_c45 = {
+	.phy_read	= soce_mdio_23_02_read,
+	.phy_write	= soce_mdio_23_02_write,
+	.phy_read_c45	= soce_mdio_23_02_read_c45,
+	.phy_write_c45	= soce_mdio_23_02_write_c45,
+};
+
+static const struct dsa_switch_ops soce_switch_ops = {
+	.get_tag_protocol	= soce_get_tag_protocol,
+	.setup			= soce_setup,
+	.teardown		= soce_teardown,
+	.phylink_get_caps	= soce_phylink_get_caps,
+	.phy_read		= soce_phy_read,
+	.phy_write		= soce_phy_write,
+	.port_enable		= soce_port_enable,
+	.port_disable		= soce_port_disable,
+	.port_bridge_join	= soce_port_bridge_join,
+	.port_bridge_leave	= soce_port_bridge_leave,
+	.port_stp_state_set	= soce_port_stp_state_set,
+	.port_fast_age		= soce_port_fast_age,
+};
+
+struct soce_variant_desc {
+	const char *compatible;
+	u32 mdio_master_offset;
+	const struct soce_layout *layout;
+	const struct soce_mdio_ops *mdio_ops;
+};
+
+static const struct soce_layout soce_mrs_21_01_layout = {
+	.mstp_port_state_control = SOCE_MRS_21_01_MSTP_PORT_STATE_CONTROL_REG,
+	.mstp_mstid		= SOCE_MRS_21_01_MSTP_MSTID_OFFSET,
+	.mstp_port_state_lo	= SOCE_MRS_21_01_MSTP_PORT_STATE_OFFSET_LO,
+	.mstp_port_state_hi	= SOCE_MRS_21_01_MSTP_PORT_STATE_OFFSET_HI,
+	.fdb_ctrl		= SOCE_MRS_21_01_FDB_CTRL_OFFSET,
+};
+
+static const struct soce_layout soce_mrs_24_01_layout = {
+	.mstp_port_state_control = SOCE_MRS_24_01_MSTP_PORT_STATE_CONTROL_REG,
+	.mstp_mstid		= SOCE_MRS_24_01_MSTP_MSTID_OFFSET,
+	.mstp_port_state_lo	= SOCE_MRS_24_01_MSTP_PORT_STATE_OFFSET_LO,
+	.mstp_port_state_hi	= SOCE_MRS_24_01_MSTP_PORT_STATE_OFFSET_HI,
+	.fdb_ctrl		= SOCE_MRS_24_01_FDB_CTRL_OFFSET,
+};
+
+static const struct soce_variant_desc soce_variants[] = {
+	{
+		.compatible		= "soce,mrs-21-01",
+		.mdio_master_offset	= SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
+		.layout			= &soce_mrs_21_01_layout,
+		.mdio_ops		= &soce_mdio_ops_20_03,
+	},
+	{
+		.compatible		= "soce,mrs-23-02",
+		.mdio_master_offset	= SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
+		.layout			= &soce_mrs_24_01_layout,
+		.mdio_ops		= &soce_mdio_ops_c22_c45,
+	},
+	{
+		.compatible		= "soce,mrs-24-01",
+		.mdio_master_offset	= SOCE_MRS_21_01_MDIO_MASTER_OFFSET,
+		.layout			= &soce_mrs_24_01_layout,
+		.mdio_ops		= &soce_mdio_ops_c22_c45,
+	},
+	{ /* sentinel */ },
+};
+
+static const struct soce_variant_desc *
+soce_match_variant(const char *compatible)
+{
+	int i;
+
+	for (i = 0; soce_variants[i].compatible; i++) {
+		if (!strcmp(compatible, soce_variants[i].compatible))
+			return &soce_variants[i];
+	}
+
+	return NULL;
+}
+
+static int soce_sw_parse_port_mdio_config(struct soce_dsa_local *local,
+					  struct device *dev,
+					  struct device_node *port_node,
+					  u32 port)
+{
+	struct device_node *phy_node;
+	u32 val;
+	int ret;
+
+	if (of_find_property(port_node, "ethernet", NULL) ||
+	    of_find_property(port_node, "link", NULL)) {
+		if (of_find_property(port_node, "phy-handle", NULL)) {
+			dev_err(dev,
+				"phy-handle not allowed on CPU/DSA port %u\n",
+				port);
+			return -EINVAL;
+		}
+
+		return 0;
+	}
+
+	phy_node = of_parse_phandle(port_node, "phy-handle", 0);
+	if (!phy_node) {
+		if (of_phy_is_fixed_link(port_node))
+			return 0;
+
+		dev_err(dev, "user port %u requires phy-handle or fixed-link\n",
+			port);
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(phy_node, "soce,mdio-output", &val);
+	if (ret) {
+		dev_err(dev,
+			"missing soce,mdio-output in %pOF referenced by port %u\n",
+			phy_node, port);
+		goto out_put_phy;
+	}
+	local->mdio_info[port].mdio_output = val;
+
+	ret = of_property_read_u32(phy_node, "soce,phy-addr", &val);
+	if (ret) {
+		dev_err(dev,
+			"missing soce,phy-addr in %pOF referenced by port %u\n",
+			phy_node, port);
+		goto out_put_phy;
+	}
+	local->mdio_info[port].phy_addr = val;
+
+out_put_phy:
+	of_node_put(phy_node);
+	return ret;
+}
+
+static int soce_sw_parse_port_mdio(struct soce_priv *priv, struct device *dev,
+				   u32 numports)
+{
+	struct soce_dsa_local *local = &priv->local;
+	struct device_node *ports_node;
+	struct device_node *port_node;
+	u32 port;
+	int ret;
+
+	ports_node = of_get_child_by_name(dev->of_node, "ports");
+	if (!ports_node) {
+		dev_err(dev, "missing ports node\n");
+		return -EINVAL;
+	}
+
+	for_each_available_child_of_node(ports_node, port_node) {
+		if (of_property_read_u32(port_node, "reg", &port))
+			continue;
+
+		if (port >= numports || port >= SOCE_MAX_NUM_PORTS) {
+			dev_warn(dev,
+				 "ignoring invalid port index %u in %pOF\n",
+				 port, port_node);
+			continue;
+		}
+
+		ret = soce_sw_parse_port_mdio_config(local, dev, port_node,
+						     port);
+		if (ret) {
+			of_node_put(port_node);
+			of_node_put(ports_node);
+			return ret;
+		}
+	}
+
+	of_node_put(ports_node);
+	return 0;
+}
+
+static int soce_sw_probe(struct mdio_device *mdiodev)
+{
+	const struct soce_variant_desc *variant;
+	struct device *dev = &mdiodev->dev;
+	struct device_node *switch_node;
+	struct soce_dsa_local *local;
+	const char *soce_compatible;
+	struct soce_priv *priv;
+	u32 numports;
+	int ret;
+
+	priv = devm_kzalloc(&mdiodev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ds = devm_kzalloc(&mdiodev->dev, sizeof(*priv->ds), GFP_KERNEL);
+	if (!priv->ds)
+		return -ENOMEM;
+
+	priv->ds->dev = dev;
+	priv->ds->priv = priv;
+	local = &priv->local;
+
+	switch_node = of_parse_phandle(dev->of_node, "soce,switch-ip", 0);
+	if (!switch_node) {
+		dev_err(dev, "missing or invalid switch IP reference\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_string(switch_node, "compatible",
+				      &soce_compatible);
+	if (ret) {
+		dev_err(dev, "missing compatible property in %pOF\n",
+			switch_node);
+		of_node_put(switch_node);
+		return -EINVAL;
+	}
+
+	variant = soce_match_variant(soce_compatible);
+	if (!variant) {
+		dev_err(dev, "unsupported compatible '%s' in %pOF\n",
+			soce_compatible, switch_node);
+		of_node_put(switch_node);
+		return -ENODEV;
+	}
+
+	ret = of_property_read_u32(switch_node, "soce,num-ports", &numports);
+	if (ret) {
+		dev_err(dev, "missing soce,num-ports in %pOF\n", switch_node);
+		of_node_put(switch_node);
+		return -EINVAL;
+	}
+	if (numports == 0 || numports > SOCE_MAX_NUM_PORTS) {
+		dev_err(dev, "invalid soce,num-ports %u (max %d)\n", numports,
+			SOCE_MAX_NUM_PORTS);
+		of_node_put(switch_node);
+		return -EINVAL;
+	}
+
+	local->base_addr = devm_of_iomap(dev, switch_node, 0, NULL);
+	if (IS_ERR(local->base_addr)) {
+		dev_err(dev, "failed to map switch register space for %pOF\n",
+			switch_node);
+		of_node_put(switch_node);
+		return PTR_ERR(local->base_addr);
+	}
+
+	priv->ds->ops = &soce_switch_ops;
+	local->mdio_ops = variant->mdio_ops;
+	local->mdio_master_addr =
+		local->base_addr + variant->mdio_master_offset;
+	local->layout = variant->layout;
+	of_node_put(switch_node);
+
+	priv->ds->num_ports = numports;
+	ret = soce_sw_parse_port_mdio(priv, dev, numports);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&mdiodev->dev, priv);
+
+	dev_info(dev, "soce %s SDSA driver probed.\n", soce_compatible);
+
+	return dsa_register_switch(priv->ds);
+}
+
+static void soce_sw_remove(struct mdio_device *mdiodev)
+{
+	struct soce_priv *priv = dev_get_drvdata(&mdiodev->dev);
+
+	dsa_unregister_switch(priv->ds);
+}
+
+static const struct of_device_id soce_of_match[] = {
+	{ .compatible = "soce,switch-dsa" },
+	{ /* sentinel */ },
+};
+
+static struct mdio_driver soce_mdio_driver = {
+	.mdiodrv.driver = {
+		.name = "soce-switch-dsa",
+		.of_match_table = soce_of_match,
+	},
+	.probe  = soce_sw_probe,
+	.remove = soce_sw_remove,
+};
+
+mdio_module_driver(soce_mdio_driver);
+MODULE_AUTHOR("Vasilij Strassheim <v.strassheim@linutronix.de>");
+MODULE_DESCRIPTION("Driver for SoC-e ethernet switch family");
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/dsa/soce/soce_mdio.c b/drivers/net/dsa/soce/soce_mdio.c
new file mode 100644
index 000000000000..241fc373de8b
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_mdio.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#include <linux/mdio.h>
+#include <linux/of_mdio.h>
+#include <linux/phy.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/bits.h>
+#include <net/dsa.h>
+#include "soce_dsa.h"
+#include "soce_mdio.h"
+
+#define SOCE_MDIO_TIMEOUT 1000
+
+/* MDIO 20.03 control word layout:
+ * [31:27] PHY address, [26:22] register address, [21] operation,
+ * [20] start/operation in progress, [7:0] MDIO bus selection.
+ */
+#define SOCE_MDIO_20_03_CTRL_PHY_ADDR_SHIFT	27
+#define SOCE_MDIO_20_03_CTRL_REG_ADDR_SHIFT	22
+#define SOCE_MDIO_20_03_CTRL_OP_SHIFT		21
+#define SOCE_MDIO_20_03_CTRL_START_SHIFT	20
+#define SOCE_MDIO_20_03_CTRL_OP_WRITE		0U
+
+#define SOCE_MDIO_20_03_CTRL_OP_READ	BIT(SOCE_MDIO_20_03_CTRL_OP_SHIFT)
+#define SOCE_MDIO_20_03_CTRL_START	BIT(SOCE_MDIO_20_03_CTRL_START_SHIFT)
+
+static int soce_user_phy_read(struct mii_bus *bus, int addr, int reg)
+{
+	struct dsa_switch *ds = bus->priv;
+
+	if (ds->phys_mii_mask & BIT(addr))
+		return ds->ops->phy_read(ds, addr, reg);
+
+	return 0xffff;
+}
+
+static int soce_user_phy_write(struct mii_bus *bus, int addr, int reg, u16 val)
+{
+	struct dsa_switch *ds = bus->priv;
+
+	if (ds->phys_mii_mask & BIT(addr))
+		return ds->ops->phy_write(ds, addr, reg, val);
+
+	return 0;
+}
+
+static int soce_user_phy_read_c45(struct mii_bus *bus, int addr, int devad,
+				  int regnum)
+{
+	struct dsa_switch *ds = bus->priv;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+
+	if (!(ds->phys_mii_mask & BIT(addr)))
+		return 0xffff;
+
+	local = &priv->local;
+	if (!local->mdio_ops || !local->mdio_ops->phy_read_c45)
+		return -EOPNOTSUPP;
+
+	return local->mdio_ops->phy_read_c45(ds, addr, devad, regnum);
+}
+
+static int soce_user_phy_write_c45(struct mii_bus *bus, int addr, int devad,
+				   int regnum, u16 val)
+{
+	struct dsa_switch *ds = bus->priv;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+
+	if (!(ds->phys_mii_mask & BIT(addr)))
+		return 0;
+
+	local = &priv->local;
+	if (!local->mdio_ops || !local->mdio_ops->phy_write_c45)
+		return -EOPNOTSUPP;
+
+	return local->mdio_ops->phy_write_c45(ds, addr, devad, regnum, val);
+}
+
+int soce_user_mii_bus_register(struct dsa_switch *ds)
+{
+	struct device_node *mdio_np;
+	int err;
+
+	if (ds->user_mii_bus)
+		return 0;
+
+	ds->user_mii_bus = mdiobus_alloc();
+	if (!ds->user_mii_bus)
+		return -ENOMEM;
+
+	ds->user_mii_bus->priv = ds;
+	ds->user_mii_bus->name = "soce user mii";
+	ds->user_mii_bus->read = soce_user_phy_read;
+	ds->user_mii_bus->write = soce_user_phy_write;
+	ds->user_mii_bus->read_c45 = soce_user_phy_read_c45;
+	ds->user_mii_bus->write_c45 = soce_user_phy_write_c45;
+	snprintf(ds->user_mii_bus->id, MII_BUS_ID_SIZE, "dsa-%d.%d",
+		 ds->dst->index, ds->index);
+	ds->user_mii_bus->parent = ds->dev;
+	ds->user_mii_bus->phy_mask = ~ds->phys_mii_mask;
+
+	mdio_np = of_get_child_by_name(ds->dev->of_node, "mdio");
+	err = of_mdiobus_register(ds->user_mii_bus, mdio_np);
+	of_node_put(mdio_np);
+
+	if (err) {
+		mdiobus_free(ds->user_mii_bus);
+		ds->user_mii_bus = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+void soce_user_mii_bus_unregister(struct dsa_switch *ds)
+{
+	if (!ds || !ds->user_mii_bus)
+		return;
+
+	mdiobus_unregister(ds->user_mii_bus);
+	mdiobus_free(ds->user_mii_bus);
+	ds->user_mii_bus = NULL;
+}
+
+static int soce_mdio_20_03_wait_for_idle(struct dsa_switch *ds)
+{
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	void __iomem *ctrl;
+	u32 val;
+
+	local = &priv->local;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	return readl_poll_timeout(ctrl, val,
+				  !(val & SOCE_MDIO_20_03_CTRL_START), 10,
+				  SOCE_MDIO_TIMEOUT * 1000);
+}
+
+int soce_mdio_20_03_read(struct dsa_switch *ds, int portnumber, int regnum)
+{
+	struct soce_priv *priv = ds->priv;
+	void __iomem *ctrl, *read_reg;
+	struct soce_dsa_local *local;
+	struct soce_mdio *mdio;
+	u32 regvalue;
+	int ret;
+
+	local = &priv->local;
+	mdio = &local->mdio_info[portnumber];
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	read_reg = local->mdio_master_addr + SOCE_MDIO_20_03_READ_OFFSET;
+
+	regvalue = (mdio->phy_addr << SOCE_MDIO_20_03_CTRL_PHY_ADDR_SHIFT) |
+		   (regnum << SOCE_MDIO_20_03_CTRL_REG_ADDR_SHIFT) |
+		   SOCE_MDIO_20_03_CTRL_OP_READ |
+		   SOCE_MDIO_20_03_CTRL_START |
+		   mdio->mdio_output;
+	writel(regvalue, ctrl);
+
+	ret = soce_mdio_20_03_wait_for_idle(ds);
+	if (ret)
+		return ret;
+
+	return readl(read_reg) & 0xffff;
+}
+
+int soce_mdio_20_03_write(struct dsa_switch *ds, int portnumber, int regnum,
+			  u16 val)
+{
+	struct soce_priv *priv = ds->priv;
+	void __iomem *ctrl, *write_reg;
+	struct soce_dsa_local *local;
+	struct soce_mdio *mdio;
+	u32 regvalue;
+
+	local = &priv->local;
+	mdio = &local->mdio_info[portnumber];
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_20_03_WRITE_OFFSET;
+
+	/* Write data first */
+	writel(val, write_reg);
+
+	/* Then write control */
+	regvalue = (mdio->phy_addr << SOCE_MDIO_20_03_CTRL_PHY_ADDR_SHIFT) |
+		   (regnum << SOCE_MDIO_20_03_CTRL_REG_ADDR_SHIFT) |
+		   SOCE_MDIO_20_03_CTRL_OP_WRITE |
+		   SOCE_MDIO_20_03_CTRL_START |
+		   mdio->mdio_output;
+	writel(regvalue, ctrl);
+
+	return soce_mdio_20_03_wait_for_idle(ds);
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
+static int soce_mdio_23_02_read_c22(struct dsa_switch *ds, int portnumber,
+				    int regnum)
+{
+	void __iomem *ctrl, *params, *read_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	struct soce_mdio *mdio;
+	u32 regvalue;
+	int ret;
+
+	local = &priv->local;
+	mdio = &local->mdio_info[portnumber];
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	read_reg = local->mdio_master_addr + SOCE_MDIO_23_02_READ_OFFSET;
+
+	regvalue = (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (mdio->phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	regvalue = ((mdio->mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
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
+int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int portnumber, int devad,
+			     int regnum)
+{
+	void __iomem *ctrl, *params, *read_reg, *write_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	struct soce_mdio *mdio;
+	u32 regvalue;
+	int ret;
+
+	local = &priv->local;
+	mdio = &local->mdio_info[portnumber];
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_23_02_WRITE_OFFSET;
+	read_reg = local->mdio_master_addr + SOCE_MDIO_23_02_READ_OFFSET;
+
+	regvalue = (devad << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (mdio->phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	writel(regnum, write_reg);
+
+	/* address cycle */
+	regvalue = ((mdio->mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
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
+	regvalue = ((mdio->mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
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
+int soce_mdio_23_02_read(struct dsa_switch *ds, int portnumber, int regnum)
+{
+	return soce_mdio_23_02_read_c22(ds, portnumber, regnum);
+}
+
+static int soce_mdio_23_02_write_c22(struct dsa_switch *ds, int portnumber,
+				     int regnum, u16 val)
+{
+	void __iomem *ctrl, *params, *write_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	struct soce_mdio *mdio;
+	u32 regvalue;
+
+	local = &priv->local;
+	mdio = &local->mdio_info[portnumber];
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_23_02_WRITE_OFFSET;
+
+	regvalue = (regnum << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (mdio->phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	writel(val, write_reg);
+
+	regvalue = ((mdio->mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x0 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	return soce_mdio_23_02_wait_for_idle(ds);
+}
+
+int soce_mdio_23_02_write_c45(struct dsa_switch *ds, int portnumber, int devad,
+			      int regnum, u16 val)
+{
+	void __iomem *ctrl, *params, *write_reg;
+	struct soce_priv *priv = ds->priv;
+	struct soce_dsa_local *local;
+	struct soce_mdio *mdio;
+	u32 regvalue;
+	int ret;
+
+	local = &priv->local;
+	mdio = &local->mdio_info[portnumber];
+	ctrl = local->mdio_master_addr + SOCE_MDIO_CTRL_OFFSET;
+	params = local->mdio_master_addr + SOCE_MDIO_23_02_PARAMS_OFFSET;
+	write_reg = local->mdio_master_addr + SOCE_MDIO_23_02_WRITE_OFFSET;
+
+	regvalue = (devad << SOCE_MDIO_23_02_CTRL_REGADDRDEVTYPE_OFFSET) +
+		   (mdio->phy_addr << SOCE_MDIO_23_02_CTRL_PHYADDR_OFFSET);
+	writel(regvalue, params);
+
+	writel(regnum, write_reg);
+
+	/* address cycle */
+	regvalue = ((mdio->mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
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
+	regvalue = ((mdio->mdio_output << SOCE_MDIO_23_02_CTRL_BUS_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_TRANSTYPE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_CLAUSE_OFFSET) +
+		    (0x1 << SOCE_MDIO_23_02_CTRL_OPSTATUS_OFFSET));
+	writel(regvalue, ctrl);
+
+	return soce_mdio_23_02_wait_for_idle(ds);
+}
+
+int soce_mdio_23_02_write(struct dsa_switch *ds, int portnumber, int regnum,
+			  u16 val)
+{
+	return soce_mdio_23_02_write_c22(ds, portnumber, regnum, val);
+}
diff --git a/drivers/net/dsa/soce/soce_mdio.h b/drivers/net/dsa/soce/soce_mdio.h
new file mode 100644
index 000000000000..a71158ed06b3
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_mdio.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#ifndef __SOCE_MDIO_H
+#define __SOCE_MDIO_H
+
+#define SOCE_MDIO_CTRL_OFFSET 0x0000
+
+/* for older versions */
+#define SOCE_MDIO_20_03_WRITE_OFFSET	0x0004
+#define SOCE_MDIO_20_03_READ_OFFSET	0x0008
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
+int soce_mdio_20_03_read(struct dsa_switch *ds, int portnumber, int regnum);
+int soce_mdio_20_03_write(struct dsa_switch *ds, int portnumber, int regnum,
+			  u16 val);
+
+int soce_mdio_23_02_read(struct dsa_switch *ds, int portnumber, int regnum);
+int soce_mdio_23_02_write(struct dsa_switch *ds, int portnumber, int regnum,
+			  u16 val);
+int soce_mdio_23_02_read_c45(struct dsa_switch *ds, int portnumber, int devad,
+			     int regnum);
+int soce_mdio_23_02_write_c45(struct dsa_switch *ds, int portnumber, int devad,
+			      int regnum, u16 val);
+int soce_user_mii_bus_register(struct dsa_switch *ds);
+void soce_user_mii_bus_unregister(struct dsa_switch *ds);
+#endif /* __SOCE_MDIO_H */
diff --git a/drivers/net/dsa/soce/soce_mrs.h b/drivers/net/dsa/soce/soce_mrs.h
new file mode 100644
index 000000000000..cf2b29f1297e
--- /dev/null
+++ b/drivers/net/dsa/soce/soce_mrs.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2020 System on Chip engineering, S.L.
+ * Copyright (c) 2026 Linutronix GmbH
+ */
+
+#ifndef __SOCE_MRS_H
+#define __SOCE_MRS_H
+
+#define SOCE_MRS_21_01_MSTP_PORT_STATE_CONTROL_REG	0x0D04
+#define SOCE_MRS_21_01_MSTP_MSTID_OFFSET		0x0D08
+#define SOCE_MRS_21_01_MSTP_PORT_STATE_OFFSET_LO	0x0D0C
+#define SOCE_MRS_21_01_MSTP_PORT_STATE_OFFSET_HI	0x0D10
+#define SOCE_MRS_24_01_MSTP_PORT_STATE_CONTROL_REG	0x0F04
+#define SOCE_MRS_24_01_MSTP_MSTID_OFFSET		0x0F08
+#define SOCE_MRS_24_01_MSTP_PORT_STATE_OFFSET_LO	0x0F0C
+#define SOCE_MRS_24_01_MSTP_PORT_STATE_OFFSET_HI	0x0F10
+#define SOCE_MRS_21_01_FDB_CTRL_OFFSET			0x0A0C
+#define SOCE_MRS_24_01_FDB_CTRL_OFFSET			0x0C0C
+#define SOCE_MRS_21_01_MDIO_MASTER_OFFSET		0x0200
+
+#endif /* __SOCE_MRS_H */

-- 
2.39.5

