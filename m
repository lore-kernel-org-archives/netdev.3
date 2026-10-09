Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4AF4AA3E9;
	Fri,  9 Oct 2026 12:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550188; cv=none; b=VM7hE0Io6SYFnJoWucBUDjPo0JdC6kCDRWpso2VAND67SAsph9x6unLtE7lpvkhHLagp63lKIEGFMUrnOTd5BIngi8miIt7HDRN19G+zYNVAC69Wx8O5zTS1MNWcVnRygpABukYygcHilMC8wPeTc3+EoYfDMeRUAFpgTa4CLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550188; c=relaxed/simple;
	bh=g7wYEFwPgJ/PY5fm5gwSV1HkPktx50R1P17XB3xbxPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ViiixrT+t40TM+dXCoDt55N1zYebPpKlgixV2i/UvdMSIMfnQ93NGbjWa04SlI3TNZEyz7V2CuU54C/sbaj+BiFsnJte+He5ZLt6uXtU8nph30YhDNxI/d2pV5dvQktuTXZgCnZRyfm10eGwR2q86gibJxp5/3M0QHzNqqpc5RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A6E61A02F3;
	Fri,  9 Oct 2026 14:40:39 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B8D71A0002;
	Fri,  9 Oct 2026 14:40:39 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9C6EC2037D;
	Fri,  9 Oct 2026 14:40:37 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v1 1/5] net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a DT overlay
Date: Fri,  9 Oct 2026 15:40:30 +0300
Message-Id: <5c38f45b9ff1d73c6942d42e23940ecd9ab7b71f.1791548316.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791548316.git.claudiu.manoil@nxp.com>
References: <cover.1791548316.git.claudiu.manoil@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

ENETCv4 has special internal links when connected to the on-chip NETC
switch via internal switch ports, called pseudo-MAC links. These
pseudo-MACs are proprietary, they don't implement any standard IEEE
interface (like MII), and can be modeled as fixed links with the link
speed determined at boot time by the Port PCR[PSPEED] register
configuration.

We also need to be able to probe the ENETCv4 Ports featuring pseudo-MACs
as pure PCI devices, i.e. without any "ethernet" DT node representation.
The typical use case for this consists in a board with NETC connected
via PCI to another host which probes the ENETC. Note that in this
scenario, the pseudo-MAC ENETCs are connected internally to a NETC
switch that is not owned by Linux.

Since such a port has no "ethernet" DT node, its fixed link has to be
synthesized at probe time. Rather than hand-building a named software
node, describe the fixed link with a self-contained device-tree overlay,
following the approach used by the Microchip lan966x PCI driver. The
overlay is compiled from enetc4_pseudo_mac.dtso into a .dtbo blob and
embedded in the driver via the kernel's dtbo wrapping
(__dtbo_*_begin/_end symbols).

The overlay fragment uses an empty target-path, so it is grafted onto
the base node passed to of_overlay_fdt_apply(), i.e. the PCI function's
own dynamic OF node (created by the PCI core when
CONFIG_PCI_DYNAMIC_OF_NODES is enabled). The fixed-link node is therefore
spliced directly onto the ENETC netdev's fwnode, exactly as if it had
come from static DT, and phylink picks it up through dev_fwnode().

The overlay only adds a new fixed-link node; it deliberately does not add
a phy-mode property. A device-tree overlay may only add new nodes (which
are tracked with the OF_OVERLAY flag and freed cleanly on removal), not
new properties onto an already-live node such as the PCI function's
dynamic OF node. The phy-mode is instead set programmatically by the driver
(pf->if_mode) before the overlay is applied.

The pseudo-MAC overlay path is selected when the port has no OF node, or
when it only has the empty PCI-synthesized node (OF_DYNAMIC), which
carries no fixed-link description. Ports described by static DT take the
regular of_get_phy_mode() path instead.

The overlay blob is applied unmodified, it only selects fixed-link
mode and carries the duplex setting; its 'speed' cell is a placeholder.
The real operating speed is sourced live from PCR[PSPEED] through the
phylink get_fixed_state callback, which lets the driver override the
fixed-link state at link time. The overlay is removed on teardown and on
the probe error unwind.

The driver gains a build dependency on OF_OVERLAY. In addition, the
node-less pseudo-MAC path has a runtime dependency on
CONFIG_PCI_DYNAMIC_OF_NODES: that is what makes the PCI core synthesize
the per-function OF node (of_pci_make_dev_node()) that the overlay is
applied onto. This is intentionally not a hard Kconfig dependency, since
the ENETC4 driver also serves regular ports described by static DT; when
PCI_DYNAMIC_OF_NODES is absent the PCI function has no of_node and the
pseudo-MAC probe path fails gracefully with a clear -ENODEV error.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  1 +
 drivers/net/ethernet/freescale/enetc/Makefile |  1 +
 drivers/net/ethernet/freescale/enetc/enetc.h  |  1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 98 +++++++++++++++++--
 .../freescale/enetc/enetc4_pseudo_mac.dtso    | 32 ++++++
 .../freescale/enetc/enetc_pf_common.c         | 41 +++++++-
 .../freescale/enetc/enetc_pf_common.h         |  1 +
 7 files changed, 166 insertions(+), 9 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index f425f82a6213..a323f4235802 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -49,6 +49,7 @@ config NXP_ENETC4
 	tristate "ENETC4 PF driver"
 	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on PCI_MSI
+	depends on OF_OVERLAY
 	select FSL_ENETC_CORE
 	select FSL_ENETC_MDIO
 	select NXP_ENETC_PF_COMMON
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 10ab6694c314..86aa73de3f84 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -16,6 +16,7 @@ fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
 obj-$(CONFIG_NXP_ENETC4) += nxp-enetc4.o
 nxp-enetc4-y := enetc4_pf.o
+nxp-enetc4-y += enetc4_pseudo_mac.dtbo.o
 nxp-enetc4-$(CONFIG_DEBUG_FS) += enetc4_debugfs.o
 
 obj-$(CONFIG_FSL_ENETC_VF) += fsl-enetc-vf.o
diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d9e91832a9c1..02b44ea53807 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -500,6 +500,7 @@ struct enetc_ndev_priv {
 
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	u64 sysclk_freq; /* NETC system clock frequency */
+	int ovcs_id;
 };
 
 #define ENETC_CBD(R, i)	(&(((struct enetc_cbd *)((R).bd_base))[i]))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 71c971618388..7999355b5b9f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024, 2026 NXP */
 
 #include <linux/clk.h>
 #include <linux/module.h>
@@ -12,6 +12,10 @@
 
 #define ENETC_SI_MAX_RING_NUM	8
 
+/* embedded overlay blob, created by cmd_wrap_S_dtb in scripts/Makefile.lib */
+extern char __dtbo_enetc4_pseudo_mac_begin[];
+extern char __dtbo_enetc4_pseudo_mac_end[];
+
 static void enetc4_get_port_caps(struct enetc_pf *pf)
 {
 	struct enetc_hw *hw = &pf->si->hw;
@@ -932,6 +936,32 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
 	enetc4_mac_tx_graceful_stop(pf);
 }
 
+static void enetc4_get_pcr_speed(struct enetc_hw *hw, int *speed)
+{
+	u32 val = enetc_port_rd(hw, ENETC4_PCR);
+	int pspeed = FIELD_GET(PCR_PSPEED, val);
+
+	*speed = (pspeed + 1) * 10;
+}
+
+/* Pseudo-MAC ports have no real PHY; the link is fixed. The overlay puts
+ * phylink into fixed-link mode, but the operating speed is taken live from
+ * PCR[PSPEED] here rather than from the DT 'speed' cell.
+ */
+static void enetc4_pl_get_fixed_state(struct phylink_config *config,
+				      struct phylink_link_state *state)
+{
+	struct enetc_pf *pf = phylink_to_enetc_pf(config);
+	int speed;
+
+	enetc4_get_pcr_speed(&pf->si->hw, &speed);
+
+	state->link = 1;
+	state->an_complete = 1;
+	state->duplex = DUPLEX_FULL;
+	state->speed = enetc_phylink_match_pseudo_mac_speed(speed);
+}
+
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
 	.mac_select_pcs = enetc4_pl_mac_select_pcs,
 	.mac_config = enetc4_pl_mac_config,
@@ -946,23 +976,76 @@ static void enetc4_pci_remove(void *data)
 	enetc_pci_remove(pdev);
 }
 
+static void enetc4_put_overlay(struct enetc_ndev_priv *priv)
+{
+	if (!priv->ovcs_id)
+		return;
+
+	of_overlay_remove(&priv->ovcs_id);
+	priv->ovcs_id = 0;
+}
+
+static int enetc4_apply_overlay(struct enetc_ndev_priv *priv)
+{
+	u32 size = __dtbo_enetc4_pseudo_mac_end - __dtbo_enetc4_pseudo_mac_begin;
+	struct device_node *np = dev_of_node(priv->dev);
+	int err;
+
+	if (!np)
+		return dev_err_probe(priv->dev, -ENODEV,
+				     "Missing of_node for Pseudo-MAC port\n");
+
+	err = of_overlay_fdt_apply(__dtbo_enetc4_pseudo_mac_begin, size,
+				   &priv->ovcs_id, np);
+	if (err)
+		return dev_err_probe(priv->dev, err,
+				     "Failed to apply fixed-link overlay\n");
+
+	return 0;
+}
+
 static int enetc4_link_init(struct enetc_ndev_priv *priv,
 			    struct device_node *node)
 {
+	bool dynamic = node && of_node_check_flag(node, OF_DYNAMIC);
 	struct enetc_pf *pf = enetc_si_priv(priv->si);
 	struct device *dev = priv->dev;
 	int err;
 
-	err = of_get_phy_mode(node, &pf->if_mode);
-	if (err) {
-		dev_err(dev, "Failed to get PHY mode\n");
-		return err;
+	/* Pseudo-MAC ENETCs are described by a runtime fixed-link overlay
+	 * rather than static DT. This covers both a missing OF node and a
+	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
+	 * by the PCI core and thus carries no fixed-link description.
+	 */
+	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
+		pf->if_mode = PHY_INTERFACE_MODE_INTERNAL;
+
+		err = enetc4_apply_overlay(priv);
+		if (err)
+			return err;
+
+		/* Source the fixed-link speed live from PCR[PSPEED] instead
+		 * of the overlay 'speed' cell.
+		 */
+		pf->phylink_config.get_fixed_state = enetc4_pl_get_fixed_state;
+
+		/* The overlay was grafted onto dev's own of_node, so phylink
+		 * will find the fixed-link via dev_fwnode(dev). Use that node
+		 * for the subsequent MDIO/phylink setup below.
+		 */
+		node = dev_of_node(dev);
+	} else {
+		err = of_get_phy_mode(node, &pf->if_mode);
+		if (err) {
+			dev_err(dev, "Failed to get PHY mode\n");
+			return err;
+		}
 	}
 
 	err = enetc_mdiobus_create(pf, node);
 	if (err) {
 		dev_err(dev, "Failed to create MDIO bus\n");
-		return err;
+		goto err_mdiobus_create;
 	}
 
 	err = enetc_phylink_create(priv, node, &enetc_pl_mac_ops);
@@ -975,6 +1058,8 @@ static int enetc4_link_init(struct enetc_ndev_priv *priv,
 
 err_phylink_create:
 	enetc_mdiobus_destroy(pf);
+err_mdiobus_create:
+	enetc4_put_overlay(priv);
 
 	return err;
 }
@@ -985,6 +1070,7 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 
 	enetc_phylink_destroy(priv);
 	enetc_mdiobus_destroy(pf);
+	enetc4_put_overlay(priv);
 }
 
 static void enetc4_pf_link_status_task(struct work_struct *work)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso b/drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso
new file mode 100644
index 000000000000..e3d3e4259fbd
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pseudo_mac.dtso
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * Device-tree overlay for ENETC v4 Pseudo-MAC (PPM) ports.
+ *
+ * ENETCv4 pseudo-MACs are proprietary internal links to the on-chip NETC
+ * switch; they implement no standard MII interface and are modeled as a
+ * fixed link whose speed is set at boot time from the Port PCR[PSPEED]
+ * field.
+ *
+ * This overlay is applied by the ENETC4 PF driver onto the PCI function's own
+ * dynamic OF node (created by the PCI core when CONFIG_PCI_DYNAMIC_OF_NODES
+ * is enabled). The overlay only selects fixed-link mode and carries the duplex
+ * setting; the 'speed' property is a placeholder.
+ *
+ * Copyright 2026 NXP
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path = "";
+
+		__overlay__ {
+			fixed-link {
+				speed = <2500>;
+				full-duplex;
+			};
+		};
+	};
+};
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 8206884294a4..3ba46c3a7670 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -436,6 +436,43 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf)
 }
 EXPORT_SYMBOL_GPL(enetc_mdiobus_destroy);
 
+static struct {
+	unsigned long mac_cap;
+	int speed; /* descending order sorted  */
+} enetc_phylink_pseudo_mac_caps[] = {
+	{ MAC_25000FD,  SPEED_25000 },
+	{ MAC_20000FD,  SPEED_20000 },
+	{ MAC_10000FD,  SPEED_10000 },
+	{ MAC_5000FD,   SPEED_5000  },
+	{ MAC_2500FD,   SPEED_2500  },
+	{ MAC_1000FD,   SPEED_1000  },
+	{ MAC_100FD,    SPEED_100   },
+	{ MAC_10FD,     SPEED_10    },
+};
+
+static unsigned long enetc_phylink_get_pseudo_mac_caps(void)
+{
+	unsigned long mac_caps = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_phylink_pseudo_mac_caps); i++)
+		mac_caps |= enetc_phylink_pseudo_mac_caps[i].mac_cap;
+
+	return mac_caps;
+}
+
+int enetc_phylink_match_pseudo_mac_speed(int speed)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(enetc_phylink_pseudo_mac_caps); i++)
+		if (enetc_phylink_pseudo_mac_caps[i].speed <= speed)
+			return enetc_phylink_pseudo_mac_caps[i].speed;
+
+	return SPEED_UNKNOWN;
+}
+EXPORT_SYMBOL_GPL(enetc_phylink_match_pseudo_mac_speed);
+
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops)
 {
@@ -471,9 +508,7 @@ int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 
 		phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
 	} else {
-		mac_caps |= MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD |
-			    MAC_5000FD | MAC_10000FD | MAC_20000FD |
-			    MAC_25000FD;
+		mac_caps |= enetc_phylink_get_pseudo_mac_caps();
 	}
 
 	pf->phylink_config.mac_capabilities = mac_caps;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
index c9eed879d5a3..aede1aad6362 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -13,6 +13,7 @@ void enetc_mdiobus_destroy(struct enetc_pf *pf);
 int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
 			 const struct phylink_mac_ops *ops);
 void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
+int enetc_phylink_match_pseudo_mac_speed(int speed);
 void enetc_set_default_rss_key(struct enetc_pf *pf);
 int enetc_vlan_rx_add_vid(struct net_device *ndev, __be16 prot, u16 vid);
 int enetc_vlan_rx_del_vid(struct net_device *ndev, __be16 prot, u16 vid);
-- 
2.34.1

