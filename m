Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150033;
	b=DpbUvJOfcbdwMeksWih5lcR6YXW0R+mjT75aYuR6p57UlZ5crogFFrhbLueMR9oFhTZh
	 lfhoLNI4hKR2qzRQWjb6QFA5LiQl3N7LdzNNe4XWr3g7b+db9v7PfbFyCJViRGt94xMTV
	 3VASh4Doo9qMlZfbFG6iLbKqGvIoSW6wzPGVfnFI5DuHg9GH8i/1wUzI1aqrlswACRj+R
	 zl/qd5JUJfx0609raOMDDoib390hM6Sqw3l5citq05FBM3Lju5CW6WVCEW4Iz1s7Snlo3
	 51dH89fZvMSKMCsfv0wU6U6p5T6lecVaGPndR0HSO2bKCIHXhzv331md+UHEmE08Daw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150033;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=TrxS2FBM3swZea7TlEAOFgnaKwDzhKOfR26uS7Hz2zY=;
	b=4LQDivRWebvz7gjvQKTXRpp4tyq5sTLJDvqpNOlbLzxARo5f/AXOjjOxD3OjDbDqWdXb
	 hb7ZH2rw7Z8szpSI/8KYa/gM5WFC7JYuYbLcMOx7nPoTKP0h99VxI4m4as7ywaSQKfv8F
	 OjoNwVb13rTcN8/CLP7dnUyMrQfKT3aMhSkvbyqcL4YLkllZF3z3NCC5BVqAVqqNGAs90
	 t3Fb0k86Dzko3s3i17TByoiktnSgY++m9HtDefWNzODRXQrX8Qp+1TAEiy/103AzthpSa
	 3vhSa9saOLE6KeZimw7Ye6IKsFNzeXW3CAXLqy5lNelLUz2c3x6L3EKD8Sj2zCbqTXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=YDCzxVxn;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8C606A323;
	Wed, 28 Oct 2026 01:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6E8C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=YDCzxVxn
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B696A14978A;
	Wed, 28 Oct 2026 02:13:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793150030; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=TrxS2FBM3swZea7TlEAOFgnaKwDzhKOfR26uS7Hz2zY=;
	b=YDCzxVxnMvnDxIlFd7BMuq4wx9s7oBvZaZA7LDJrGHfaem4Pa7hyrfYhobQsX73jrlC32z
	XnPocVuwmKLvoxIKA1VrKvOGBHSSlFsq6LwDum3b6DOEBX+RX40yvxV6tALoGHFNNCC38D
	DS0B9O8UNXIq70Qk3xigHb8TLdUG+JUlMOPu4m+mWHeR4fWMiiuQF+BXmvylUftehd8121
	c7zKTo+fU/4lYkWOSz3fArGI9Dh89NOwBDXmATb80qxgAIWpmiATKLUhmyEtDau7UUqlqz
	jsm2f7yAdvhQdMyd47Lc5F/XPkDom44N4EuIrGnkv4eI4Jw2cRXP+OyX+FlLIg==
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
Subject: [PATCH v3 3/7] net: dsa: mediatek: add support for passthrough mode
Date: Wed, 28 Oct 2026 01:13:13 +0000
Message-Id: <20261028011317.1557238-4-cjd@cjdns.fr>
In-Reply-To: <20261028011317.1557238-1-cjd@cjdns.fr>
References: <20261028011317.1557238-1-cjd@cjdns.fr>
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
 drivers/net/dsa/mt7530.c | 194 +++++++++++++++++++++++++++++++++++----
 drivers/net/dsa/mt7530.h |   6 ++
 2 files changed, 184 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d10194488bde..3eb2e11d6985 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -199,6 +199,9 @@ static void mt7530_port_fast_age(struct dsa_switch *ds, int port)
 	u32 val;
 	int ret;
 
+	if (priv->is_passthrough)
+		return;
+
 	mutex_lock(&priv->reg_mutex);
 
 	/* Flush all non-static MAC address entries */
@@ -970,6 +973,9 @@ mt7530_set_ageing_time(struct dsa_switch *ds, unsigned int msecs)
 	unsigned int age_count;
 	unsigned int age_unit;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	/* Applied timer is (AGE_CNT + 1) * (AGE_UNIT + 1) seconds.
 	 * The DSA core has already validated the range using
 	 * ds->ageing_time_min and ds->ageing_time_max.
@@ -1286,13 +1292,41 @@ mt753x_trap_frames(struct mt7530_priv *priv)
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
@@ -1322,6 +1356,7 @@ static int
 mt7530_port_enable(struct dsa_switch *ds, int port,
 		   struct phy_device *phy)
 {
+	int upstream_pt = dsa_switch_upstream_port(ds);
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mt7530_priv *priv = ds->priv;
 
@@ -1332,13 +1367,38 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
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
 
@@ -1386,11 +1446,14 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	int length;
 	u32 val;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	/* When a new MTU is set, DSA always set the CPU port's MTU to the
 	 * largest MTU of the user ports. Because the switch only has a global
 	 * RX length register, only allowing CPU port here is enough.
 	 */
-	if (!dsa_is_cpu_port(ds, port))
+	if (!dsa_is_upstream_port(ds, port))
 		return 0;
 
 	regmap_read(priv->regmap, MT7530_GMACCR, &val);
@@ -1427,6 +1490,9 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 	struct mt7530_priv *priv = ds->priv;
 	u32 stp_state;
 
+	if (priv->is_passthrough)
+		return;
+
 	switch (state) {
 	case BR_STATE_DISABLED:
 		stp_state = MT7530_STP_DISABLED;
@@ -1521,6 +1587,9 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	if (flags.mask & BR_LEARNING)
 		regmap_update_bits(priv->regmap, MT7530_PSC_P(port), SA_DIS,
 				   flags.val & BR_LEARNING ? 0 : SA_DIS);
@@ -1561,6 +1630,9 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_update_port_member(priv, port, bridge.dev, true);
@@ -1714,6 +1786,9 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 {
 	struct mt7530_priv *priv = ds->priv;
 
+	if (priv->is_passthrough)
+		return;
+
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_update_port_member(priv, port, bridge.dev, false);
@@ -1737,6 +1812,9 @@ mt7530_port_fdb_add(struct dsa_switch *ds, int port,
 	int ret;
 	u8 port_mask = BIT(port);
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
@@ -1754,6 +1832,9 @@ mt7530_port_fdb_del(struct dsa_switch *ds, int port,
 	int ret;
 	u8 port_mask = BIT(port);
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_EMP);
 	ret = mt7530_fdb_cmd(priv, MT7530_FDB_WRITE, NULL);
@@ -1809,6 +1890,9 @@ mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 	u32 val;
 	int ret;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
@@ -1838,6 +1922,9 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 	u32 val;
 	int ret;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
@@ -1862,6 +1949,10 @@ mt7530_port_vlan_filtering(struct dsa_switch *ds, int port, bool vlan_filtering,
 {
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct dsa_port *cpu_dp = dp->cpu_dp;
+	struct mt7530_priv *priv = ds->priv;
+
+	if (priv->is_passthrough)
+		return 0;
 
 	if (vlan_filtering) {
 		/* The port is being kept as VLAN-unaware port when bridge is
@@ -1970,6 +2061,9 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 	struct mt7530_hw_vlan_entry new_entry;
 	struct mt7530_priv *priv = ds->priv;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 
 	/* VID 0 is managed exclusively by mt7530_setup_vlan0() for
@@ -2022,6 +2116,9 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 	struct mt7530_hw_vlan_entry target_entry;
 	struct mt7530_priv *priv = ds->priv;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	mutex_lock(&priv->reg_mutex);
 
 	/* VID 0 is managed exclusively by mt7530_setup_vlan0(). */
@@ -2063,6 +2160,9 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	int monitor_port;
 	u32 val;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	/* Check for existent entry */
 	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
 		return -EEXIST;
@@ -2099,6 +2199,9 @@ static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 	struct mt7530_priv *priv = ds->priv;
 	u32 val;
 
+	if (priv->is_passthrough)
+		return;
+
 	regmap_read(priv->regmap, MT7530_PCR_P(port), &val);
 	if (mirror->ingress) {
 		val &= ~PORT_RX_MIR;
@@ -2405,11 +2508,6 @@ mt7530_setup(struct dsa_switch *ds)
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
@@ -2511,7 +2609,7 @@ mt7530_setup(struct dsa_switch *ds)
 		/* Disable learning by default on all ports */
 		regmap_set_bits(priv->regmap, MT7530_PSC_P(i), SA_DIS);
 
-		if (dsa_is_cpu_port(ds, i)) {
+		if (dsa_is_upstream_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
@@ -2535,7 +2633,7 @@ mt7530_setup(struct dsa_switch *ds)
 		return ret;
 
 	/* Check for PHY muxing on port 5 */
-	if (dsa_is_unused_port(ds, 5)) {
+	if (dn && dsa_is_unused_port(ds, 5)) {
 		/* Scan the ethernet nodes. Look for GMAC1, lookup the used PHY.
 		 * Set priv->p5_mode to the appropriate value if PHY muxing is
 		 * detected.
@@ -2635,7 +2733,7 @@ mt7531_setup_common(struct dsa_switch *ds)
 		regmap_set_bits(priv->regmap, MT7531_DBG_CNT(i),
 				MT7531_DIS_CLR);
 
-		if (dsa_is_cpu_port(ds, i)) {
+		if (dsa_is_upstream_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
 		} else {
 			mt7530_port_disable(ds, i);
@@ -3264,6 +3362,9 @@ mt753x_port_change_conduit(struct dsa_switch *ds, int port,
 	struct dsa_port *dp = dsa_to_port(ds, port);
 	struct mt7530_priv *priv = ds->priv;
 
+	if (priv->is_passthrough)
+		return 0;
+
 	if (priv->id != ID_MT7531) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Changing DSA conduit is only supported on MT7531");
@@ -3304,7 +3405,7 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 
 	/* Set the CPU port to trap frames to for MT7530. Trapped frames will be
 	 * forwarded to the numerically smallest CPU port whose conduit
-	 * interface is up.
+	 * interface is up. NOTE: "CPU port" can also mean an upstream DSA link.
 	 */
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
 	    priv->id != ID_EN7528)
@@ -3365,6 +3466,11 @@ static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
 static int mt753x_setup_tc(struct dsa_switch *ds, int port,
 			   enum tc_setup_type type, void *type_data)
 {
+	struct mt7530_priv *priv = ds->priv;
+
+	if (priv->is_passthrough)
+		return 0;
+
 	switch (type) {
 	case TC_SETUP_QDISC_TBF:
 		return mt753x_tc_setup_qdisc_tbf(ds, port, type_data);
@@ -3399,6 +3505,55 @@ static int mt7988_setup(struct dsa_switch *ds)
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
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
@@ -3531,8 +3686,12 @@ EXPORT_SYMBOL_GPL(mt753x_table);
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
@@ -3550,7 +3709,10 @@ mt7530_probe_common(struct mt7530_priv *priv)
 	priv->id = priv->info->id;
 	priv->dev = dev;
 	priv->ds->priv = priv;
+
+	priv->is_passthrough = passthrough;
 	priv->ds->ops = &mt7530_switch_ops;
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

