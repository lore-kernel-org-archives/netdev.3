Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7023152269A;
	Tue, 13 Oct 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911576; cv=none; b=NPS75uLxgatlkhsE8uKsA0vh3TU1vBVQH1HETXu4deUrEQxVtr7Gos0vjxXPoyXTBA9kKbCScQpmhwh8Fb70itT1MvMtSDiLnUc+80q2D7K2tuiCpTIc8LMEqrOP/eH9Lw4NrtgNSkdexZXDNDLL5wtiO4cvKrQSWhNvj4MrQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911576; c=relaxed/simple;
	bh=SsgvErTanvXGCa4/KtnPGEmvB3FvuajOmYl+3mqqNwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVvV/775E2pGJFEGGUPCB/qDTkNOcghUMDt3vG2HZFBlG/SBH6N34ya1ZgJcCVZKlZkkZ26mBZIdxPE4nOnyUfBCLPNQi0JAt8DehiztlnvUBUSeNxhSglBFWlXfqD7u5oQ28sqNn2lLiQBX6ak6UyyAsb0p9He1xPm2JVREMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BDA8E2000EB;
	Tue, 13 Oct 2026 19:12:52 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B07C32000E4;
	Tue, 13 Oct 2026 19:12:52 +0200 (CEST)
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BEC8202DA;
	Tue, 13 Oct 2026 19:12:51 +0200 (CEST)
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: netdev@vger.kernel.org
Cc: s32@nxp.com,
	linux-kernel@vger.kernel.org,
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
	imx@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v2 1/5] net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link node
Date: Tue, 13 Oct 2026 20:12:45 +0300
Message-Id: <d7b51cb29758538a4c68a700dd8cd41b6e7e08b6.1791908694.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1791908694.git.claudiu.manoil@nxp.com>
References: <cover.1791908694.git.claudiu.manoil@nxp.com>
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
synthesized at probe time. Build the fixed-link subnode directly in C
with an of_changeset: of_changeset_create_node() adds a "fixed-link"
node onto the port's own OF node, and of_changeset_add_prop_*() populate
its "speed" and "full-duplex" properties. The changeset is applied with
of_changeset_apply(), so the fixed-link node is spliced onto the ENETC
netdev's fwnode exactly as if it had come from static DT, and phylink
picks it up through dev_fwnode().

The operating speed written into the node is read from PCR[PSPEED] at
probe time and mapped to a phylink-supported value, so the fixed link
reflects the actual boot-time configuration.

The pseudo-MAC path is selected when the port has no OF node, or when it
only has the empty PCI-synthesized node (OF_DYNAMIC), which carries no
fixed-link description. Ports described by static DT take the regular
of_get_phy_mode() path instead.

The changeset is reverted and destroyed on teardown and on the probe
error unwind. The node-less pseudo-MAC path has a runtime dependency on
CONFIG_PCI_DYNAMIC_OF_NODES: that is what makes the PCI core synthesize
the per-function OF node (of_pci_make_dev_node()) that the fixed-link
node is attached onto. This is intentionally not a hard Kconfig
dependency, since the ENETC4 driver also serves regular ports described
by static DT; when PCI_DYNAMIC_OF_NODES is absent the PCI function has no
of_node and the pseudo-MAC probe path fails gracefully with a clear
-ENODEV error.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v2:
 - Switched from a DT overlay blob (of_overlay_fdt_apply() + a .dtso
   compiled to .dtbo) to of_changeset_create_node(), per review
   feedback. Drops the embedded overlay externs, the Makefile .dtbo
   wrapping, and the OF_OVERLAY Kconfig dependency.
 - Baked the operating speed directly into the changeset-created
   fixed-link node (read once from PCR[PSPEED] at probe time); the
   phylink get_fixed_state callback is no longer needed and was removed.

 drivers/net/ethernet/freescale/enetc/enetc.h  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 113 +++++++++++++++++-
 .../freescale/enetc/enetc_pf_common.c         |  41 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   1 +
 4 files changed, 147 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index d9e91832a9c1..ed5402f1b73c 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -500,6 +500,7 @@ struct enetc_ndev_priv {
 
 	struct clk *ref_clk; /* RGMII/RMII reference clock */
 	u64 sysclk_freq; /* NETC system clock frequency */
+	struct of_changeset *ppm_ocs; /* pseudo-MAC fixed-link changeset */
 };
 
 #define ENETC_CBD(R, i)	(&(((struct enetc_cbd *)((R).bd_base))[i]))
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 71c971618388..70e34ca6ddf8 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
-/* Copyright 2024 NXP */
+/* Copyright 2024, 2026 NXP */
 
 #include <linux/clk.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/unaligned.h>
@@ -932,6 +933,14 @@ static void enetc4_pl_mac_link_down(struct phylink_config *config,
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
 static const struct phylink_mac_ops enetc_pl_mac_ops = {
 	.mac_select_pcs = enetc4_pl_mac_select_pcs,
 	.mac_config = enetc4_pl_mac_config,
@@ -946,23 +955,112 @@ static void enetc4_pci_remove(void *data)
 	enetc_pci_remove(pdev);
 }
 
+static void enetc4_put_ppm_fixed_link(struct enetc_ndev_priv *priv)
+{
+	if (!priv->ppm_ocs)
+		return;
+
+	of_changeset_revert(priv->ppm_ocs);
+	of_changeset_destroy(priv->ppm_ocs);
+	kfree(priv->ppm_ocs);
+	priv->ppm_ocs = NULL;
+}
+
+/* Pseudo-MAC ports have no real PHY; the link is fixed, with the operating
+ * speed set at probe time from PCR[PSPEED]. Describe this with a fixed-link
+ * subnode synthesized at runtime onto the port's own OF node, so phylink
+ * picks it up through dev_fwnode() exactly as if it came from static DT.
+ */
+static int enetc4_add_ppm_fixed_link(struct enetc_ndev_priv *priv)
+{
+	struct device_node *np = dev_of_node(priv->dev);
+	struct device_node *fixed_link;
+	struct of_changeset *ocs;
+	int speed, err;
+
+	if (!np)
+		return dev_err_probe(priv->dev, -ENODEV,
+				     "Missing of_node for Pseudo-MAC port\n");
+
+	enetc4_get_pcr_speed(&priv->si->hw, &speed);
+	speed = enetc_phylink_match_pseudo_mac_speed(speed);
+
+	ocs = kzalloc_obj(*ocs);
+	if (!ocs)
+		return -ENOMEM;
+
+	of_changeset_init(ocs);
+
+	fixed_link = of_changeset_create_node(ocs, np, "fixed-link");
+	if (!fixed_link) {
+		err = -ENOMEM;
+		goto err_destroy;
+	}
+
+	err = of_changeset_add_prop_u32(ocs, fixed_link, "speed", speed);
+	if (err)
+		goto err_put_node;
+
+	err = of_changeset_add_prop_bool(ocs, fixed_link, "full-duplex");
+	if (err)
+		goto err_put_node;
+
+	err = of_changeset_apply(ocs);
+	if (err)
+		goto err_put_node;
+
+	of_node_put(fixed_link);
+	priv->ppm_ocs = ocs;
+
+	return 0;
+
+err_put_node:
+	of_node_put(fixed_link);
+err_destroy:
+	of_changeset_destroy(ocs);
+	kfree(ocs);
+
+	return dev_err_probe(priv->dev, err,
+			     "Failed to add fixed-link node\n");
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
+	/* Pseudo-MAC ENETCs are described by a runtime-synthesized fixed-link
+	 * node rather than static DT. This covers both a missing OF node and a
+	 * PCI-synthesized (OF_DYNAMIC) node, which is an empty node created
+	 * by the PCI core and thus carries no fixed-link description.
+	 */
+	if (enetc_is_pseudo_mac(priv->si) && (!node || dynamic)) {
+		pf->if_mode = PHY_INTERFACE_MODE_INTERNAL;
+
+		err = enetc4_add_ppm_fixed_link(priv);
+		if (err)
+			return err;
+
+		/* The fixed-link node was spliced onto dev's own of_node, so
+		 * phylink will find it via dev_fwnode(dev). Use that node for
+		 * the subsequent MDIO/phylink setup below.
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
@@ -975,6 +1073,8 @@ static int enetc4_link_init(struct enetc_ndev_priv *priv,
 
 err_phylink_create:
 	enetc_mdiobus_destroy(pf);
+err_mdiobus_create:
+	enetc4_put_ppm_fixed_link(priv);
 
 	return err;
 }
@@ -985,6 +1085,7 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 
 	enetc_phylink_destroy(priv);
 	enetc_mdiobus_destroy(pf);
+	enetc4_put_ppm_fixed_link(priv);
 }
 
 static void enetc4_pf_link_status_task(struct work_struct *work)
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

