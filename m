Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299351;
	b=vnHA70zeuZxy6JTntzZN2NFpjmQjplDJJWZwjllO26bEohweHBnn30J8NBpk0TAf3g+n
	 AuSMBN7eQdQlYqBNLN7FtY0zvlU+DlcM1MtpaQazX9HhsSCcr0in1ScBxVkppKX+11Ea3
	 mfYbN8qZoc4mQeTM//fe6p9nkmbkyxGpTH0fRo92Bbrmk//fHRuPbzB99X7ISCTMH1UJS
	 +zN8B5d7gzzbwovC5I8pChrM5TjTNz2zFqoiZsQm5cNUNyFbMErfwgRN1mRwm59oQgmv0
	 LqGmII5Bcln5u3DSq93QmBZDO3BKb52o+F5ZgWX/jwx4Yw6CaOf6EsDfK9cXQMDNvxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299351;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=/KykytcM07Skm+ihkDrxrg/f5tB6TWyVn08H6DL8rrM=;
	b=Rlli8tvkSvR1QkgrgpX2GNFjwyENP6BvvaEvHY/ZCJvL9/RuO8QaULvf8zPYQ4xrdb83
	 XWlP9UVYrUAn1WYOC7x+zYkj6GVMbU4QVbUpK9+wgVt/NYrZy2+lQbgmze0mMVveJVzE9
	 GBmwCVS/y5gxVLpH5j8nCQd6PlamyytZIPA4KwKp5uratx5zj0TKY/Ifaz1X0dQrffhes
	 DyeLll78hNPWOCBb49Z3UdO+dWbm7OiS9qSQg7RMCAhp91ymk1ar/I1FItSpDmCP+iJTK
	 GS0sQ2CSoqfuPgzieZiWYwynFwf5/Z0hI7kF9npYkTzrlMGojNN8UX35NTvUv4L1d5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=Gdp7GuKe;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2660606A320;
	Thu, 29 Oct 2026 18:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2660606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=Gdp7GuKe
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EB37E1AA7D1;
	Thu, 29 Oct 2026 19:42:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793299348; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/KykytcM07Skm+ihkDrxrg/f5tB6TWyVn08H6DL8rrM=;
	b=Gdp7GuKelxBQfY7s3jniQGE1Z+fraHFQVXs2oQExCHibJB4ZdbhWacz3vCh47PlJZagA3F
	lOvTYVj3SjnZ2a0a1cesqiFufR9prl6D1gI9u4zDskCJXycQURRrEgvbV9Z+OpC9EhdijJ
	FQ+ozEXnTixS/hEakm5wiHgovsw1xHZIyduDhzihV8pOuAtCORfHU0++UpXghHrq+apdC5
	vHnFltOcsxQRiVXyEq0NGX85nnviRfyNayC/vqKGHMyouH9KztGoP7QdsrH2pKe/y1rTZU
	sNebZzqdphcUTpwGC9AxmLhD5Bl+iows1eXKvVgfTnxoxc4yEd1bRpI3dDgWYA==
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
Subject: [PATCH v4 3/7] net: dsa: mediatek: add support for passthrough mode
Date: Thu, 29 Oct 2026 18:41:58 +0000
Message-Id: <20261029184202.1859843-4-cjd@cjdns.fr>
In-Reply-To: <20261029184202.1859843-1-cjd@cjdns.fr>
References: <20261029184202.1859843-1-cjd@cjdns.fr>
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
X-Last-TLS-Session-Version: TLSv1.3

For reasons outlined below, full switch hierarchies are not supported
by the MT7530, however in some cases, hardware integrators add a
second MT7530 switch to a port of the CPU-connected MT7530 and
configure the upstream switch to pass all traffic to and from the
downstream switch. Particularly, without altering the MediaTek DSA tag.
The typical reason for this is because the downstream switch is more
capable, but the upstream switch is an irremovable part of the SoC.

To enable passthrough, the main switch has its CPU port, and the port
to the second switch, both configured as MT7530_VLAN_EG_DISABLED and
MT7530_VLAN_TRANSPARENT and it uses the port matrix to control
forwarding.

Support this restricted form of switch hierarchy which is detected by
reading the DT. More complex switch hierarchies are still unsupported
but now provide a more useful error log.

As a point of information:

There exist features in the hardware which appear to enable full
two-switch hierarchies (i.e. ports on the upstream switch are also
available for use). The way that this is supposed to work is though a
PASSTHROUGH flag in the DSA tag on BIT(7). The downstream switch sets
a flag called "PT_OPTION" on the PVC register of its "CPU" port (the
port linking to the upstream switch). This causes the downstream switch
to set the PASSTHROUGH flag on all traffic exiting toward the upstream
switch. The CPU then sets the PASSTHROUGH flag on egress traffic meant
for the downstream switch.

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

Reference code defaults to making the upstream switch a
blind-passthrough as is done in the present patch. There is however
support in the reference implementation for hierarchies where ports on
both switches are used, providing no two ports with the same number are
both active. This allows the tag protocol to guess which switch a
packet comes from. This implementation does not implement that mode
because EcoNet EN751221 hardware does not require it.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530.c | 381 +++++++++++++++++++++++++++++++++------
 drivers/net/dsa/mt7530.h |   6 +
 2 files changed, 336 insertions(+), 51 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d10194488bde..c5b3b00acb95 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -193,6 +193,11 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 	return 0;
 }
 
+static void mt7530_passthrough_port_fast_age(struct dsa_switch *ds,
+					     int port)
+{
+}
+
 static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
 {
 	struct mt7530_priv *priv = ds->priv;
@@ -960,6 +965,12 @@ static void mt7530_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 			       &ctrl_stats->MACControlFramesReceived);
 }
 
+static int
+mt7530_passthrough_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
+{
+	return 0;
+}
+
 static int
 mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 {
@@ -1286,13 +1297,81 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 				   TO_CPU_FW_CPU_ONLY);
 }
 
+static int
+mt7530_passthrough_port_change_mtu(struct dsa_switch *ds, int port,
+				   int new_mtu)
+{
+	return 0;
+}
+
+static int
+mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+{
+	struct mt7530_priv *priv = ds->priv;
+	int length;
+	u32 val;
+
+	/* When a new MTU is set, DSA always set the CPU port's MTU to the
+	 * largest MTU of the user ports. Because the switch only has a global
+	 * RX length register, only allowing CPU port here is enough.
+	 */
+	if (!dsa_is_upstream_port(ds, port))
+		return 0;
+
+	regmap_read(priv->regmap, MT7530_GMACCR, &val);
+	val &= ~MAX_RX_PKT_LEN_MASK;
+
+	/* RX length also includes Ethernet header, MTK tag, and FCS length */
+	length = new_mtu + ETH_HLEN + MTK_HDR_LEN + ETH_FCS_LEN;
+	if (length <= 1522) {
+		val |= MAX_RX_PKT_LEN_1522;
+	} else if (length <= 1536) {
+		val |= MAX_RX_PKT_LEN_1536;
+	} else if (length <= 1552) {
+		val |= MAX_RX_PKT_LEN_1552;
+	} else {
+		val &= ~MAX_RX_JUMBO_MASK;
+		val |= MAX_RX_JUMBO(DIV_ROUND_UP(length, 1024));
+		val |= MAX_RX_PKT_LEN_JUMBO;
+	}
+
+	regmap_write(priv->regmap, MT7530_GMACCR, val);
+
+	return 0;
+}
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
@@ -1322,6 +1401,7 @@ static int
 mt7530_port_enable(struct dsa_switch *ds, int port,
 		   struct phy_device *phy)
 {
+	int upstream_pt = dsa_switch_upstream_port(ds);
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mt7530_priv *priv = ds->priv;
 
@@ -1332,13 +1412,38 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 	 * bridge.
 	 */
 	if (dsa_port_is_user(dp)) {
-		struct dsa_port *cpu_dp = dp->cpu_dp;
+		priv->ports[port].pm |= PCR_MATRIX(BIT(upstream_pt));
 
-		priv->ports[port].pm |= PCR_MATRIX(BIT(cpu_dp->index));
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
+
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
 
@@ -1380,45 +1485,14 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 }
 
 static int
-mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
+mt7530_port_max_mtu(struct dsa_switch *ds, int port)
 {
-	struct mt7530_priv *priv = ds->priv;
-	int length;
-	u32 val;
-
-	/* When a new MTU is set, DSA always set the CPU port's MTU to the
-	 * largest MTU of the user ports. Because the switch only has a global
-	 * RX length register, only allowing CPU port here is enough.
-	 */
-	if (!dsa_is_cpu_port(ds, port))
-		return 0;
-
-	regmap_read(priv->regmap, MT7530_GMACCR, &val);
-	val &= ~MAX_RX_PKT_LEN_MASK;
-
-	/* RX length also includes Ethernet header, MTK tag, and FCS length */
-	length = new_mtu + ETH_HLEN + MTK_HDR_LEN + ETH_FCS_LEN;
-	if (length <= 1522) {
-		val |= MAX_RX_PKT_LEN_1522;
-	} else if (length <= 1536) {
-		val |= MAX_RX_PKT_LEN_1536;
-	} else if (length <= 1552) {
-		val |= MAX_RX_PKT_LEN_1552;
-	} else {
-		val &= ~MAX_RX_JUMBO_MASK;
-		val |= MAX_RX_JUMBO(DIV_ROUND_UP(length, 1024));
-		val |= MAX_RX_PKT_LEN_JUMBO;
-	}
-
-	regmap_write(priv->regmap, MT7530_GMACCR, val);
-
-	return 0;
+	return MT7530_MAX_MTU;
 }
 
-static int
-mt7530_port_max_mtu(struct dsa_switch *ds, int port)
+static void
+mt7530_passthrough_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 {
-	return MT7530_MAX_MTU;
 }
 
 static void
@@ -1514,6 +1588,14 @@ mt7530_port_pre_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt7530_passthrough_port_bridge_flags(struct dsa_switch *ds, int port,
+				     struct switchdev_brport_flags flags,
+				     struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
 static int
 mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 			 struct switchdev_brport_flags flags,
@@ -1554,6 +1636,15 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt7530_passthrough_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
 static int
 mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 			struct dsa_bridge bridge, bool *tx_fwd_offload,
@@ -1708,6 +1799,12 @@ mt7530_port_set_vlan_aware(struct dsa_switch *ds, int port)
 	}
 }
 
+static void
+mt7530_passthrough_port_bridge_leave(struct dsa_switch *ds, int port,
+				     struct dsa_bridge bridge)
+{
+}
+
 static void
 mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 			 struct dsa_bridge bridge)
@@ -1728,6 +1825,14 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 	mutex_unlock(&priv->reg_mutex);
 }
 
+static int
+mt7530_passthrough_port_fdb_add(struct dsa_switch *ds, int port,
+				const unsigned char *addr, u16 vid,
+				struct dsa_db db)
+{
+	return 0;
+}
+
 static int
 mt7530_port_fdb_add(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid,
@@ -1745,6 +1850,14 @@ mt7530_port_fdb_add(struct dsa_switch *ds, int port,
 	return ret;
 }
 
+static int
+mt7530_passthrough_port_fdb_del(struct dsa_switch *ds, int port,
+				const unsigned char *addr, u16 vid,
+				struct dsa_db db)
+{
+	return 0;
+}
+
 static int
 mt7530_port_fdb_del(struct dsa_switch *ds, int port,
 		    const unsigned char *addr, u16 vid,
@@ -1797,6 +1910,14 @@ mt7530_port_fdb_dump(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt7530_passthrough_port_mdb_add(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_mdb *mdb,
+				struct dsa_db db)
+{
+	return 0;
+}
+
 static int
 mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb,
@@ -1826,6 +1947,14 @@ mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 	return ret;
 }
 
+static int
+mt7530_passthrough_port_mdb_del(struct dsa_switch *ds, int port,
+				const struct switchdev_obj_port_mdb *mdb,
+				struct dsa_db db)
+{
+	return 0;
+}
+
 static int
 mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 		    const struct switchdev_obj_port_mdb *mdb,
@@ -1856,6 +1985,14 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 	return ret;
 }
 
+static int
+mt7530_passthrough_port_vlan_filtering(struct dsa_switch *ds, int port,
+				       bool vlan_filtering,
+				       struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
 static int
 mt7530_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 			   struct netlink_ext_ack *extack)
@@ -1960,6 +2097,14 @@ mt7530_hw_vlan_update(struct mt7530_priv *priv, u16 vid,
 	mt7530_vlan_cmd(priv, MT7530_VTCR_WR_VID, vid);
 }
 
+static int
+mt7530_passthrough_port_vlan_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
 static int
 mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan,
@@ -2015,6 +2160,13 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt7530_passthrough_port_vlan_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	return 0;
+}
+
 static int
 mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 		     const struct switchdev_obj_port_vlan *vlan)
@@ -2055,6 +2207,14 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt753x_passthrough_port_mirror_add(struct dsa_switch *ds, int port,
+				   struct dsa_mall_mirror_tc_entry *mirror,
+				   bool ingress, struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
 static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 				  struct dsa_mall_mirror_tc_entry *mirror,
 				  bool ingress, struct netlink_ext_ack *extack)
@@ -2093,6 +2253,11 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static void mt753x_passthrough_port_mirror_del(struct dsa_switch *ds, int port,
+					       struct dsa_mall_mirror_tc_entry *mirror)
+{
+}
+
 static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 				   struct dsa_mall_mirror_tc_entry *mirror)
 {
@@ -2405,11 +2570,6 @@ mt7530_setup(struct dsa_switch *ds)
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
@@ -2511,7 +2671,7 @@ mt7530_setup(struct dsa_switch *ds)
 		/* Disable learning by default on all ports */
 		regmap_set_bits(priv->regmap, MT7530_PSC_P(i), SA_DIS);
 
-		if (dsa_is_cpu_port(ds, i)) {
+		if (dsa_is_upstream_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
@@ -2535,7 +2695,7 @@ mt7530_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Check for PHY muxing on port 5 */
-	if (dsa_is_unused_port(ds, 5)) {
+	if (dn && dsa_is_unused_port(ds, 5)) {
 		/* Scan the ethernet nodes. Look for GMAC1, lookup the used PHY.
 		 * Set priv->p5_mode to the appropriate value if PHY muxing is
 		 * detected.
@@ -2635,7 +2795,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 		regmap_set_bits(priv->regmap, MT7531_DBG_CNT(i),
 				MT7531_DIS_CLR);
 
-		if (dsa_is_cpu_port(ds, i)) {
+		if (dsa_is_upstream_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
@@ -3255,6 +3415,14 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int
+mt753x_passthrough_port_change_conduit(struct dsa_switch *ds, int port,
+				       struct net_device *conduit,
+				       struct netlink_ext_ack *extack)
+{
+	return 0;
+}
+
 static int
 mt753x_port_change_conduit(struct dsa_switch *ds, int port,
 			   struct net_device *conduit,
@@ -3304,7 +3472,7 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 
 	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
 	 * forwarded to the numerically smallest CPU port whose conduit
-	 * interface is up.
+	 * interface is up. NOTE: "CPU port" can also mean an upstream DSA link.
 	 */
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
 	    priv->id != ID_EN7528)
@@ -3362,6 +3530,13 @@ static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static int mt753x_passthrough_setup_tc(struct dsa_switch *ds, int port,
+				       enum tc_setup_type type,
+				       void *type_data)
+{
+	return 0;
+}
+
 static int mt753x_setup_tc(struct dsa_switch *ds, int port,
 			   enum tc_setup_type type, void *type_data)
 {
@@ -3399,6 +3574,99 @@ static int mt7988_setup(struct dsa_switch *ds)
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
+	.get_tag_protocol       = mtk_get_tag_protocol,
+	.setup                  = mt753x_setup,
+	.teardown               = mt753x_teardown,
+	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
+	.port_change_conduit	= mt753x_passthrough_port_change_conduit,
+	.get_strings            = mt7530_get_strings,
+	.get_ethtool_stats      = mt7530_get_ethtool_stats,
+	.get_sset_count         = mt7530_get_sset_count,
+	.get_eth_mac_stats      = mt7530_get_eth_mac_stats,
+	.get_rmon_stats         = mt7530_get_rmon_stats,
+	.get_eth_ctrl_stats     = mt7530_get_eth_ctrl_stats,
+	.get_stats64            = mt7530_get_stats64,
+	.set_ageing_time	= mt7530_passthrough_set_ageing_time,
+	.port_enable            = mt7530_port_enable,
+	.port_disable           = mt7530_port_disable,
+	.port_change_mtu	= mt7530_passthrough_port_change_mtu,
+	.port_max_mtu		= mt7530_port_max_mtu,
+	.port_stp_state_set	= mt7530_passthrough_stp_state_set,
+	.port_pre_bridge_flags	= mt7530_port_pre_bridge_flags,
+	.port_bridge_flags	= mt7530_passthrough_port_bridge_flags,
+	.port_bridge_join	= mt7530_passthrough_port_bridge_join,
+	.port_bridge_leave	= mt7530_passthrough_port_bridge_leave,
+	.port_fast_age		= mt7530_passthrough_port_fast_age,
+	.port_fdb_add		= mt7530_passthrough_port_fdb_add,
+	.port_fdb_del		= mt7530_passthrough_port_fdb_del,
+	.port_fdb_dump		= mt7530_port_fdb_dump,
+	.port_mdb_add		= mt7530_passthrough_port_mdb_add,
+	.port_mdb_del		= mt7530_passthrough_port_mdb_del,
+	.port_vlan_filtering	= mt7530_passthrough_port_vlan_filtering,
+	.port_vlan_add		= mt7530_passthrough_port_vlan_add,
+	.port_vlan_del		= mt7530_passthrough_port_vlan_del,
+	.port_mirror_add	= mt753x_passthrough_port_mirror_add,
+	.port_mirror_del	= mt753x_passthrough_port_mirror_del,
+	.phylink_get_caps       = mt753x_phylink_get_caps,
+	.support_eee            = dsa_supports_eee,
+	.set_mac_eee            = mt753x_set_mac_eee,
+	.conduit_state_change   = mt753x_conduit_state_change,
+	.port_setup_tc		= mt753x_passthrough_setup_tc,
+	.port_hsr_join		= dsa_port_simple_hsr_join,
+	.port_hsr_leave		= dsa_port_simple_hsr_leave,
+};
+
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
@@ -3531,8 +3799,12 @@ EXPORT_SYMBOL_GPL(mt753x_table);
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
@@ -3550,7 +3822,14 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	priv->id = priv->info->id;
 	priv->dev = dev;
 	priv->ds->priv = priv;
-	priv->ds->ops = &mt7530_switch_ops;
+
+	priv->is_passthrough = passthrough;
+
+	if (passthrough)
+		priv->ds->ops = &mt7530_passthrough_switch_ops;
+	else
+		priv->ds->ops = &mt7530_switch_ops;
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

