Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE83F4DCA;
	Tue, 15 Sep 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494442; cv=none; b=HY7YGqAKn9FHs8QGZIfwo4cVTavh9z9F65h1y+29Ip8FY+yl3cRdD08bLLZFEpOgzB7Hlc0c8D53yVz2C2BQKD/gWcyCBMbWjCvzO+BkYAPbnTbv3+Ielqj/SGsQahs0/+1j2M/zMNbvl0AyfmyIT252ZksuMpqvV62dARCfE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494442; c=relaxed/simple;
	bh=Fy0WYN5sPf3gkRqvwmUIdNan3vD2NMePpp8PKTBpfDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkRbi5cAo5DIcm1+MKcjADC89YMyMLZf9v5OWbYfSO+G0LrmeO02x1LaXL9wLLEP/SQq8NJ5b3g+mFlXOOjB3P8E5zAaeSAoNELdnHqZ2ndsQdRebPcqXOikCTdjfe3DN+v/GjRqQ8FUi1pyE1DuJsUPEltgVVCMiYxT7JZ1SJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=Hkpj54R+; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="Hkpj54R+"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E357648F9A8;
	Tue, 15 Sep 2026 19:47:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789494434; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=56ZZFGKTZe46l0WN09lZLfibMWBczbgzk6VvR1nnJkA=;
	b=Hkpj54R+GRYljhd/KpRlGSkheDiLhNPFaKF+8mkBGXbsHcn7Ip3J7jEuCowDDnvBcqGrle
	dt8GGIjTdwDCU6VjlVkXIUrH9Vl25dODXfGMs82dDfoW3d11bZWJyAqod6hbrKeklZ19LF
	NhpK0qIgZbd1iZGdszRqhXT0no2FS66YLTC+kwCQg/mdc4uvJRyPyGFNCix1sBHbapRCcS
	ID4jetS/pgBQXkhEIxeW4mTIavbCpUZ92OkhrPOs+z6khnS/UmzXafmVV6SDOqAvl3txQ3
	GKmjGok3CXe/qWhTzQWgTberle0s9s1dPl47Hg5iE9Rq8kpU6zh9MNT3lJSzEQ==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v2 net-next 3/7] net: dsa: mediatek: add support for passthrough mode
Date: Tue, 15 Sep 2026 17:46:39 +0000
Message-Id: <20260915174643.253660-4-cjd@cjdns.fr>
In-Reply-To: <20260915174643.253660-1-cjd@cjdns.fr>
References: <20260915174643.253660-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

In some cases, hardware integrators add a second MT7530 switch to a
port of the CPU-connected MT7530 and configure the upstream switch to
pass all traffic to and from the downstream switch. Particularly,
without altering the MediaTek DSA tag. The typical reason for this is
because the downstream switch is more capable, but the upstream switch
is an irremovable part of the SoC.

To enable passthrough, the main switch has its CPU port, and the port
to the second switch, both configured as MT7530_VLAN_EG_DISABLED and
MT7530_VLAN_TRANSPARENT and it uses the port matrix to control
forwarding.

Support passing through to a downstream switch, and also support being
the downstream switch - meaning the upstream link is not a CPU port but
rather a DSA port.

As a point of information:

There exist features in the hardware which appear to enable full
two-switch hierarchies (i.e. ports on the upstream switch are also
available for use). The way that this is supposed to work is though a
PASSTHROUGH flag in the DSA tag on BIT(7). The downstream switch sets
a flag called "PT_OPTION" on the PVC register of its "CPU" port (the
port linking to the upstream switch). This causes the downstream switch
to set the PASSTHROUGH flag on all ingress traffic. The CPU then sets
the PASSTHROUGH flag on egress traffic meant for the downstream switch.

In this configuration, the upstream switch sets MT7530_VLAN_USER, and
PORT_SPEC_TAG on the (real) CPU port (as usual), but also sets it on
the port leading to the downstream switch. The PORT_SPEC_TAG flag on
the downstream link port causes incoming DSA tags to be copied over
rather than being replaced by tags identifying the traffic as having
come from the link port. Finally, an ACL is installed which causes the
upstream switch to forward all egress traffic with the PASSTHROUGH bit
to the link port.

However for reasons unknown, the PASSTHROUGH bit is cleared by the
upstream switch as it receives ingress traffic from the downstream
switch. So by the time the traffic reaches the CPU, it no longer bears
the PASSTHROUGH bit and its origin cannot be known.

Reference code defaults to passthrough mode as is implemented here, but
supports a limited hierarchical implementation for hardware that needs
it. In this mode it is not permitted to use the same port number on
both switches. This implementation does not implement that mode because
there is no known hardware using ports on both switches.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530.c | 164 +++++++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h |   6 ++
 2 files changed, 153 insertions(+), 17 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 54d931002bc1..b2344808457c 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1286,13 +1286,41 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 				   TO_CPU_FW_CPU_ONLY);
 }
 
+static int
+mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu);
+
+/* If this switch is downstream of another switch that is in passthrough mode,
+ * the "CPU" port is actually a DSA port.
+ */
 static void
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
 	struct mt7530_priv *priv = ds->priv;
 
-	/* Enable Mediatek header mode on the cpu port */
-	regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
+	if (priv->is_passthrough) {
+		/* Disable parsing of the DSA tag, it will be forwarded blindly
+		 * to the downstream switch.
+		 */
+		regmap_write(priv->regmap, MT7530_PVC_P(port),
+			     VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
+			     PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));
+
+		/* The port is not configured to parse DSA tags, so they are
+		 * liable to be confused for length fields, so length check is
+		 * disabled.
+		 */
+		regmap_clear_bits(priv->regmap, MT753X_AGC, AGC_L2LEN_CHK);
+
+		/* In passthrough mode, MTU is only enforced downstream */
+		mt7530_port_change_mtu(ds, port, MT7530_MAX_MTU);
+
+		/* Loop detection has no value in passthrough mode */
+		regmap_set_bits(priv->regmap, MT753X_MTRAP,
+				MT7530_LOOP_DET_DISABLE);
+	} else {
+		/* Not passthrough, enable DSA tag handling on CPU port. */
+		regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
+	}
 
 	/* Enable flooding on the CPU port */
 	regmap_set_bits(priv->regmap, MT753X_MFC,
@@ -1322,6 +1350,7 @@ static int
 mt7530_port_enable(struct dsa_switch *ds, int port,
 		   struct phy_device *phy)
 {
+	int upstream_pt = dsa_switch_upstream_port(ds);
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mt7530_priv *priv = ds->priv;
 
@@ -1332,13 +1361,38 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 	 * bridge.
 	 */
 	if (dsa_port_is_user(dp)) {
-		struct dsa_port *cpu_dp = dp->cpu_dp;
+		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
+
+	} else if (dsa_port_is_dsa(dp) && dp->index != upstream_pt) {
+		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
+
+		/* Should not happen */
+		WARN_ON_ONCE(!priv->is_passthrough);
+
+		/* We are passing through to a downstream switch so we set both
+		 * CPU and downstream link to pass traffic untouched so that
+		 * the STAG from the downstream switch will pass to the upstream.
+		 */
+		regmap_write(priv->regmap, MT7530_PVC_P(port),
+			     VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
+			     PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));
+
+		/* We let the downstream switch flood */
+		regmap_set_bits(priv->regmap, MT753X_MFC, BC_FFP(BIT(port)) |
+				UNM_FFP(BIT(port)) | UNU_FFP(BIT(port)));
 
-		priv->ports[port].pm |= PCR_MATRIX(BIT(cpu_dp->index));
+		/* Make the upstream port able to connect to the DSA port.
+		 * This must be explicit because PORT_SPEC_TAG is unset.
+		 */
+		regmap_write(priv->regmap, MT7530_PCR_P(upstream_pt),
+			     PCR_MATRIX(BIT(port)));
 	}
 	priv->ports[port].enable = true;
-	regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
-			   priv->ports[port].pm);
+
+	/* In passthrough mode, CPU port mask is set above. */
+	if (!(priv->is_passthrough && dp->index == upstream_pt))
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+				   PCR_MATRIX_MASK, priv->ports[port].pm);
 
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1390,7 +1444,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	 * largest MTU of the user ports. Because the switch only has a global
 	 * RX length register, only allowing CPU port here is enough.
 	 */
-	if (!dsa_is_cpu_port(ds, port))
+	if (!dsa_is_upstream_port(ds, port))
 		return 0;
 
 	regmap_read(priv->regmap, MT7530_GMACCR, &val);
@@ -2411,11 +2465,6 @@ mt7530_setup(struct dsa_switch *ds)
 		break;
 	}
 
-	if (!dn) {
-		dev_err(ds->dev, "parent OF node of DSA conduit not found");
-		return -EINVAL;
-	}
-
 	ds->assisted_learning_on_cpu_port = true;
 	ds->untag_vlan_aware_bridge_pvid = true;
 	ds->mtu_enforcement_ingress = true;
@@ -2517,7 +2566,7 @@ mt7530_setup(struct dsa_switch *ds)
 		/* Disable learning by default on all ports */
 		regmap_set_bits(priv->regmap, MT7530_PSC_P(i), SA_DIS);
 
-		if (dsa_is_cpu_port(ds, i)) {
+		if (dsa_is_upstream_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
@@ -2541,7 +2590,7 @@ mt7530_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Check for PHY muxing on port 5 */
-	if (dsa_is_unused_port(ds, 5)) {
+	if (dn && dsa_is_unused_port(ds, 5)) {
 		/* Scan the ethernet nodes. Look for GMAC1, lookup the used PHY.
 		 * Set priv->p5_mode to the appropriate value if PHY muxing is
 		 * detected.
@@ -2641,7 +2690,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 		regmap_set_bits(priv->regmap, MT7531_DBG_CNT(i),
 				MT7531_DIS_CLR);
 
-		if (dsa_is_cpu_port(ds, i)) {
+		if (dsa_is_upstream_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
@@ -3310,7 +3359,7 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 
 	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
 	 * forwarded to the numerically smallest CPU port whose conduit
-	 * interface is up.
+	 * interface is up. NOTE: "CPU port" can also mean an upstream DSA link.
 	 */
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
 	    priv->id != ID_EN7528)
@@ -3405,6 +3454,76 @@ static int mt7988_setup(struct dsa_switch *ds)
 	return mt7531_setup_common(ds);
 }
 
+/* 1 if passthrough, negative if error. */
+static int mt753x_check_passthrough(struct device *dev)
+{
+	struct device_node *ports, *port;
+	int passthrough_ports = 0;
+	int enabled_ports = 0;
+
+	ports = of_get_child_by_name(dev->of_node, "ports");
+	if (!ports)
+		ports = of_get_child_by_name(dev->of_node, "ethernet-ports");
+
+	if (!ports) {
+		dev_err(dev, "no ports child node found\n");
+		return -EINVAL;
+	}
+
+	for_each_available_child_of_node(ports, port) {
+		struct device_node *link;
+
+		enabled_ports++;
+
+		link = of_parse_phandle(port, "ethernet", 0);
+		if (!link)
+			link = of_parse_phandle(port, "link", 0);
+
+		if (!link)
+			continue;
+
+		of_node_put(link);
+
+		passthrough_ports++;
+	}
+
+	of_node_put(ports);
+
+	/*
+	 * A switch is considered passthrough if exactly two available
+	 * ports have an "ethernet" or "link" phandle.
+	 */
+	if (passthrough_ports > 2 ||
+	    (passthrough_ports == 2 && enabled_ports != 2)
+	) {
+		dev_err(dev, "Only two ports allowed in passthrough mode\n");
+		return -EINVAL;
+	}
+
+	return passthrough_ports == 2;
+}
+
+/* No manipulation of forwarding rules allowed in passthrough mode */
+static const struct dsa_switch_ops mt7530_passthrough_switch_ops = {
+	.get_tag_protocol	= mtk_get_tag_protocol,
+	.setup			= mt753x_setup,
+	.teardown		= mt753x_teardown,
+	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
+	.get_strings		= mt7530_get_strings,
+	.get_ethtool_stats	= mt7530_get_ethtool_stats,
+	.get_sset_count		= mt7530_get_sset_count,
+	.get_eth_mac_stats	= mt7530_get_eth_mac_stats,
+	.get_rmon_stats		= mt7530_get_rmon_stats,
+	.get_eth_ctrl_stats	= mt7530_get_eth_ctrl_stats,
+	.get_stats64		= mt7530_get_stats64,
+	.port_enable		= mt7530_port_enable,
+	.port_disable		= mt7530_port_disable,
+	.phylink_get_caps	= mt753x_phylink_get_caps,
+	.support_eee		= dsa_supports_eee,
+	.set_mac_eee		= mt753x_set_mac_eee,
+	.conduit_state_change	= mt753x_conduit_state_change,
+};
+
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
@@ -3537,8 +3656,12 @@ EXPORT_SYMBOL_GPL(mt753x_table);
 int
 mt7530_probe_common(struct mt7530_priv *priv)
 {
+	int passthrough = mt753x_check_passthrough(priv->dev);
 	struct device *dev = priv->dev;
 
+	if (passthrough < 0)
+		return passthrough;
+
 	priv->ds = devm_kzalloc(dev, sizeof(*priv->ds), GFP_KERNEL);
 	if (!priv->ds)
 		return -ENOMEM;
@@ -3556,7 +3679,14 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	priv->id = priv->info->id;
 	priv->dev = dev;
 	priv->ds->priv = priv;
-	priv->ds->ops = &mt7530_switch_ops;
+
+	if (passthrough) {
+		priv->ds->ops = &mt7530_passthrough_switch_ops;
+		priv->is_passthrough = true;
+	} else {
+		priv->ds->ops = &mt7530_switch_ops;
+	}
+
 	priv->ds->phylink_mac_ops = &mt753x_phylink_mac_ops;
 	mutex_init(&priv->reg_mutex);
 	spin_lock_init(&priv->stats_lock);
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 3dabbc99fbbc..108c831dd012 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -40,6 +40,7 @@ enum mt753x_id {
 /* Register for ARL global control */
 #define MT753X_AGC			0xc
 #define  LOCAL_EN			BIT(7)
+#define  AGC_L2LEN_CHK			BIT(4)
 
 /* Register for MAC forward control */
 #define MT753X_MFC			0x10
@@ -583,6 +584,7 @@ enum mt7531_clk_skew {
 #define MT753X_MTRAP			0x7804
 #define  MT7530_P5_PHY0_SEL		BIT(20)
 #define  MT7530_CHG_TRAP		BIT(16)
+#define  MT7530_LOOP_DET_DISABLE	BIT(14)
 #define  MT7530_P5_MAC_SEL		BIT(13)
 #define  MT7530_P6_DIS			BIT(8)
 #define  MT7530_P5_RGMII_MODE		BIT(7)
@@ -897,6 +899,9 @@ struct mt753x_info {
  * @p5_mode:		Holding the current mode of port 5 of the MT7530 switch
  * @p5_sgmii:		Flag for distinguishing if port 5 of the MT7531 switch
  *			has got SGMII
+ * @is_passthrough:	If this switch is to pass traffic between the upstream
+ *			(CPU) port and a second downstream switch, without
+ *			altering the DSA tag.
  * @irq_domain:		IRQ domain of the switch irq_chip
  * @create_sgmii:	Pointer to function creating SGMII PCS instance(s)
  * @active_cpu_ports:	Holding the active CPU ports
@@ -921,6 +926,7 @@ struct mt7530_priv {
 	bool			p5_sgmii;
 	u8			mirror_rx;
 	u8			mirror_tx;
+	bool			is_passthrough;
 	struct mt7530_port	ports[MT7530_NUM_PORTS];
 	struct mt753x_pcs	pcs[MT7530_NUM_PORTS];
 	/* protect among processes for registers access*/
-- 
2.39.5

