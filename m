Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.121.32.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714962;
	b=P7CIJ+b1uaEi0uvCKmn17Rb5Z3Rx0qQIyaQ1F5Rw78GhV5ySgi4NXtzPMAURhOSkCsDs
	 Q96tyJ4B1aXj9Le1/+PJWtDsRCB5xLq99R5A1c++HC0nTf5T+kpubcwly46/UyfKSiGBs
	 8sand5vmhDIEHoXeKLa5Bt3+rId5rcjn5Ky26NljPLdep6PeM1t9QwwPZilt40e7LXUyN
	 CHL8oMQGbDHy6KaLA6C+9FO1rEwEVk/RdNffDTfyfzTpw8v+XF8Kyjhes6REsuGn9+I5t
	 179dGsBqvQ8wz8ZMtIu15xD9wKcGYGpNnAhusPGN5mmV/5Ptm0cJz6VDRwjjEPt+ZVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714962;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Tjci9FahsWXbvTAjNSulqZBWW3Q1JTvC7kQWPLK/tWs=;
	b=PmzbreTmfC3695PX4DUxewy68T9EDgSZw0HfpfmndUDRng/FK8NHAokepczd5HFWP23p
	 e7bfS9/q0qeE8a1nCif4tfKQB0kOSYf9tRN+5CDbZVjaL9/rY4xZKDkCUd1juN3s5NPiw
	 IPmfz5hZsc4ubCnBZlxyWkK4HfTp8E9adnx+9IFkV8Jqq+FZKCxs6HKgXMh15Ty/LcmEk
	 nZvYDdIR3xWMS6xqG1Ax1Weyw1t/vV67iUOrifs68OTdNVQNOavj9PBffsJpdVhRQDLV2
	 H4xm2wjG71s7KYcUDy1wyVMf09QrvDYwUnwDw6UvdiEBpAyR1PfZCw34bwAhl6LE5xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=GiV3bdZb;
	arc=none smtp.remote-ip=92.121.32.55
Received: from inva130.nxp.com (inva130.nxp.com [92.121.32.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9A606A333;
	Tue,  3 Nov 2026 14:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA9A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=nselector2 header.b=GiV3bdZb
Received: from localhost (localhost [127.0.0.1])
	by inva130.nxp.com (Postfix) with ESMTP id AF2966000791;
	Tue,  3 Nov 2026 15:09:15 +0100 (CET)
X-Virus-Scanned: amavis at nxp.com
Received: from inva130.nxp.com ([127.0.0.1])
 by localhost (inva130.nxp.com [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GunDit03yl-B; Tue,  3 Nov 2026 15:09:15 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva130.nxp.com (Postfix) with ESMTP id E4C0B6000789;
	Tue,  3 Nov 2026 15:09:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva130.nxp.com E4C0B6000789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
	s=nselector2; t=1793714954;
	bh=Tjci9FahsWXbvTAjNSulqZBWW3Q1JTvC7kQWPLK/tWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GiV3bdZbWQ6szSJIM7wqBdiGsK2OoJ+IcmxP3BFVgS2+HG6Yead80qN0LqFBZy49y
	 NNhDpDVHAN81Ee+0vI2UCXsZcNi02NqlzL8L1DLr3ozU9C/xL0fUfGJrH0Ua50gKSk
	 ymCl+oqnc9y8OCPaemPQiuFLJFFCQum2T/mKtdE61rmTJfuSu/hsEhtA57PnWfRAH7
	 oJdcBfi7cGF5FqHcT8fUmi76RI/NmDfINXwwYQq+voX5UQKG1tTRCFQHRVZfdl8tUk
	 vldPLvwh/gC++ttsJyFmU/KxwTzcIALRROG8cyAoY9Ju+lb/E6PAkpIjzeX8zC0w8J
	 8sF1RdgVIkrpg==
Received: from lsv15141.swis.ro-buh01.nxp.com (lsv15141.swis.ro-buh01.nxp.com [10.162.246.138])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0376A202AF;
	Tue,  3 Nov 2026 15:09:13 +0100 (CET)
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
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 1/5] net: enetc: Add pseudo-MAC support for ENETCv4 Ports via a fixed-link node
Date: Tue,  3 Nov 2026 16:09:07 +0200
Message-Id: <5a135fdb2f4de0ee90f4c7e691fff34ccab29354.1793712309.git.claudiu.manoil@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1793712309.git.claudiu.manoil@nxp.com>
References: <cover.1793712309.git.claudiu.manoil@nxp.com>
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
reflects the actual boot-time configuration, as long as it's a phylink
supported value. Otherwise, PCR[PSPEED] will be updated to the closest
rounded down supported value.

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
v3:
 - Fixed the CONFIG_OF_DYNAMIC dependency.
 - Refactored enetc4_add_ppm_fixed_link(), as per Wei's feedback.
 - Improved the commit message.

v2:
 - Switched from a DT overlay blob (of_overlay_fdt_apply() + a .dtso
   compiled to .dtbo) to of_changeset_create_node(), per review
   feedback. Drops the embedded overlay externs, the Makefile .dtbo
   wrapping, and the OF_OVERLAY Kconfig dependency.
 - Baked the operating speed directly into the changeset-created
   fixed-link node (read once from PCR[PSPEED] at probe time); the
   phylink get_fixed_state callback is no longer needed and was removed.

 drivers/net/ethernet/freescale/enetc/Kconfig  |   1 +
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 109 +++++++++++++++++-
 .../net/ethernet/freescale/enetc/enetc_pf.h   |   2 +
 .../freescale/enetc/enetc_pf_common.c         |  41 ++++++-
 .../freescale/enetc/enetc_pf_common.h         |   1 +
 5 files changed, 145 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index f425f82a6213a..c51d07db2c869 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -55,6 +55,7 @@ config NXP_ENETC4
 	select NXP_NTMP
 	select PHYLINK
 	select DIMLIB
+	select OF_DYNAMIC
 	help
 	  This driver supports NXP ENETC devices with major revision 4. ENETC is
 	  as the NIC functionality in NETC, it supports virtualization/isolation
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 71c971618388b..b7e7201e6a71a 100644
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
@@ -946,23 +955,108 @@ static void enetc4_pci_remove(void *data)
 	enetc_pci_remove(pdev);
 }
 
+static void enetc4_put_ppm_fixed_link(struct enetc_pf *pf)
+{
+	if (!pf->ppm_ocs)
+		return;
+
+	of_changeset_revert(pf->ppm_ocs);
+	of_changeset_destroy(pf->ppm_ocs);
+	kfree(pf->ppm_ocs);
+	pf->ppm_ocs = NULL;
+}
+
+/* Pseudo-MAC ports have no real PHY; the link is fixed, with the operating
+ * speed set at probe time from PCR[PSPEED]. Describe this with a fixed-link
+ * subnode synthesized at runtime onto the port's own OF node, so phylink
+ * picks it up through dev_fwnode() exactly as if it came from static DT.
+ */
+static int enetc4_add_ppm_fixed_link(struct enetc_pf *pf,
+				     struct device_node *np)
+{
+	struct device_node *fixed_link;
+	struct of_changeset *ocs;
+	int speed, err;
+
+	enetc4_get_pcr_speed(&pf->si->hw, &speed);
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
+	pf->ppm_ocs = ocs;
+
+	return 0;
+
+err_put_node:
+	of_node_put(fixed_link);
+err_destroy:
+	of_changeset_destroy(ocs);
+	kfree(ocs);
+
+	return err;
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
+		if (!node) {
+			dev_err(dev, "Missing of_node for Pseudo-MAC port\n");
+			return -ENODEV;
+		}
+
+		err = enetc4_add_ppm_fixed_link(pf, node);
+		if (err) {
+			dev_err(dev, "Failed to add fixed-link node\n");
+			return err;
+		}
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
@@ -975,6 +1069,8 @@ static int enetc4_link_init(struct enetc_ndev_priv *priv,
 
 err_phylink_create:
 	enetc_mdiobus_destroy(pf);
+err_mdiobus_create:
+	enetc4_put_ppm_fixed_link(pf);
 
 	return err;
 }
@@ -985,6 +1081,7 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 
 	enetc_phylink_destroy(priv);
 	enetc_mdiobus_destroy(pf);
+	enetc4_put_ppm_fixed_link(pf);
 }
 
 static void enetc4_pf_link_status_task(struct work_struct *work)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index 1f92d16d8ca81..ab11e40cfdbbb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -67,6 +67,8 @@ struct enetc_pf {
 	bool sriov_enabled;
 	bool link_up;
 	u16 link_status_ms_mask;
+
+	struct of_changeset *ppm_ocs; /* pseudo-MAC fixed-link changeset */
 };
 
 #define phylink_to_enetc_pf(config) \
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 8206884294a47..3ba46c3a7670b 100644
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
index c9eed879d5a3f..aede1aad63621 100644
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

