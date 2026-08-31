Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998954AF9DB;
	Mon, 31 Aug 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190718; cv=none; b=tg7Uw44DnK2V+Da8IhFfyVRxMfz9LSwPpZ4yifJG3+vYUHjMCuw38CwOhh727bEJpJ/3ynrw0xsuOwJBwyyzTlESBRexVZI00EM6vwsSFf6fcx5ojmu3kuWe4me1OKsCQeOyJ4pFjApezTss3M7z+Sj3/6G5s84esG6ngF1mqqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190718; c=relaxed/simple;
	bh=uB9CyHT1DyLEKZXm1miy5ruuufsZjUBncX7IK5YWpd4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKwanKfgCGp8mT775ve41MkxsiBh2R7zS8Vf5ZsIs5UaeCtuhrel2UVbWqkcmcYM7dXhLSA/YT2OBlC4AQVMOgchssPg47ooqporQEZgqjBCQQmICfb05GI2qKYObRilNL13USgfmlfZMdmi8GPUkYroHiP34ig8xh7TXDaQrXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x145d-000000007B2-0jYY;
	Mon, 31 Aug 2026 15:38:29 +0000
Date: Mon, 31 Aug 2026 16:38:26 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 4/9] net: dsa: mt7530: replace
 mt7530_rmw/set/clear with regmap API
Message-ID: <182be19b483e77eb1d4ed835813359a27acd8e9c.1788190568.git.daniel@makrotopia.org>
References: <cover.1788190568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788190568.git.daniel@makrotopia.org>

Replace all mt7530_rmw() calls with regmap_update_bits(), mt7530_set()
with regmap_set_bits(), and mt7530_clear() with regmap_clear_bits().
Remove the wrapper function definitions.

Generated using the following semantic patch:

@@
expression priv, reg, mask, set;
@@
-mt7530_rmw(priv, reg, mask, set)
+regmap_update_bits(priv->regmap, reg, mask, set)

@@
expression priv, reg, val;
@@
-mt7530_set(priv, reg, val)
+regmap_set_bits(priv->regmap, reg, val)

@@
expression priv, reg, val;
@@
-mt7530_clear(priv, reg, val)
+regmap_clear_bits(priv->regmap, reg, val)

Six regmap_update_bits() call sites with multi-line masks are rewrapped
by hand afterwards, as spatch joins their argument lines.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: no changes
v4: no changes
v3: no changes
v2: remove stray 'static void' leftover
---
 drivers/net/dsa/mt7530.c | 359 ++++++++++++++++++++-------------------
 1 file changed, 182 insertions(+), 177 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 43c97df638cc..0ff8a9eda3e4 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -177,25 +177,6 @@ mt7530_mii_poll(struct mt7530_dummy_poll *p)
 	return mt7530_read(p->priv, p->reg);
 }
 
-static void
-mt7530_rmw(struct mt7530_priv *priv, u32 reg,
-	   u32 mask, u32 set)
-{
-	regmap_update_bits(priv->regmap, reg, mask, set);
-}
-
-static void
-mt7530_set(struct mt7530_priv *priv, u32 reg, u32 val)
-{
-	mt7530_rmw(priv, reg, val, val);
-}
-
-static void
-mt7530_clear(struct mt7530_priv *priv, u32 reg, u32 val)
-{
-	mt7530_rmw(priv, reg, val, 0);
-}
-
 static int
 mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 {
@@ -337,12 +318,13 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 	core_clear(priv, CORE_TRGMII_GSW_CLK_CG, REG_TRGMIICK_EN);
 
 	if (interface == PHY_INTERFACE_MODE_RGMII) {
-		mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK,
-			   P6_INTF_MODE(0));
+		regmap_update_bits(priv->regmap, MT7530_P6ECR,
+				   P6_INTF_MODE_MASK, P6_INTF_MODE(0));
 		return;
 	}
 
-	mt7530_rmw(priv, MT7530_P6ECR, P6_INTF_MODE_MASK, P6_INTF_MODE(1));
+	regmap_update_bits(priv->regmap, MT7530_P6ECR, P6_INTF_MODE_MASK,
+			   P6_INTF_MODE(1));
 
 	xtal = mt7530_read(priv, MT753X_MTRAP) & MT7530_XTAL_MASK;
 
@@ -1269,35 +1251,35 @@ mt753x_trap_frames(struct mt7530_priv *priv)
 	 * switch egress VLAN tag processing. This preserves VLAN tags
 	 * for reception on VLAN sub-interfaces.
 	 */
-	mt7530_rmw(priv, MT753X_BPC,
-		   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
-			   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
-		   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
-			   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   TO_CPU_FW_CPU_ONLY);
+	regmap_update_bits(priv->regmap, MT753X_BPC,
+			   PAE_BPDU_FR | PAE_EG_TAG_MASK | PAE_PORT_FW_MASK |
+				   BPDU_EG_TAG_MASK | BPDU_PORT_FW_MASK,
+			   PAE_BPDU_FR | PAE_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+				   PAE_PORT_FW(TO_CPU_FW_CPU_ONLY) |
+				   BPDU_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+				   TO_CPU_FW_CPU_ONLY);
 
 	/* Trap frames with :01 and :02 MAC DAs to the CPU port(s) and
 	 * egress them with EG_TAG disabled.
 	 */
-	mt7530_rmw(priv, MT753X_RGAC1,
-		   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
-			   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
-		   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
-			   R01_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   TO_CPU_FW_CPU_ONLY);
+	regmap_update_bits(priv->regmap, MT753X_RGAC1,
+			   R02_BPDU_FR | R02_EG_TAG_MASK | R02_PORT_FW_MASK |
+				   R01_BPDU_FR | R01_EG_TAG_MASK | R01_PORT_FW_MASK,
+			   R02_BPDU_FR | R02_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+				   R02_PORT_FW(TO_CPU_FW_CPU_ONLY) | R01_BPDU_FR |
+				   R01_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+				   TO_CPU_FW_CPU_ONLY);
 
 	/* Trap frames with :03 and :0E MAC DAs to the CPU port(s) and
 	 * egress them with EG_TAG disabled.
 	 */
-	mt7530_rmw(priv, MT753X_RGAC2,
-		   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
-			   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
-		   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
-			   R03_EG_TAG(MT7530_VLAN_EG_DISABLED) |
-			   TO_CPU_FW_CPU_ONLY);
+	regmap_update_bits(priv->regmap, MT753X_RGAC2,
+			   R0E_BPDU_FR | R0E_EG_TAG_MASK | R0E_PORT_FW_MASK |
+				   R03_BPDU_FR | R03_EG_TAG_MASK | R03_PORT_FW_MASK,
+			   R0E_BPDU_FR | R0E_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+				   R0E_PORT_FW(TO_CPU_FW_CPU_ONLY) | R03_BPDU_FR |
+				   R03_EG_TAG(MT7530_VLAN_EG_DISABLED) |
+				   TO_CPU_FW_CPU_ONLY);
 }
 
 static void
@@ -1309,8 +1291,8 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	regmap_write(priv->regmap, MT7530_PVC_P(port), PORT_SPEC_TAG);
 
 	/* Enable flooding on the CPU port */
-	mt7530_set(priv, MT753X_MFC, BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) |
-		   UNU_FFP(BIT(port)));
+	regmap_set_bits(priv->regmap, MT753X_MFC,
+			BC_FFP(BIT(port)) | UNM_FFP(BIT(port)) | UNU_FFP(BIT(port)));
 
 	/* Add the CPU port to the CPU port bitmap for MT7531 and the switch on
 	 * the MT7988 SoC. Trapped frames will be forwarded to the CPU port that
@@ -1318,7 +1300,8 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 	 */
 	if (priv->id == ID_MT7531 || priv->id == ID_MT7988 ||
 	    priv->id == ID_EN7581 || priv->id == ID_AN7583)
-		mt7530_set(priv, MT7531_CFC, MT7531_CPU_PMAP(BIT(port)));
+		regmap_set_bits(priv->regmap, MT7531_CFC,
+				MT7531_CPU_PMAP(BIT(port)));
 
 	/* CPU port gets connected to all user ports of
 	 * the switch.
@@ -1327,8 +1310,8 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 		     PCR_MATRIX(dsa_user_ports(priv->ds)));
 
 	/* Set to fallback mode for independent VLAN learning */
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-		   MT7530_PORT_FALLBACK_MODE);
+	regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+			   PCR_PORT_VLAN_MASK, MT7530_PORT_FALLBACK_MODE);
 }
 
 static int
@@ -1350,8 +1333,8 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 		priv->ports[port].pm |= PCR_MATRIX(BIT(cpu_dp->index));
 	}
 	priv->ports[port].enable = true;
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
-		   priv->ports[port].pm);
+	regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
+			   priv->ports[port].pm);
 
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1359,9 +1342,9 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 		return 0;
 
 	if (port == 5)
-		mt7530_clear(priv, MT753X_MTRAP, MT7530_P5_DIS);
+		regmap_clear_bits(priv->regmap, MT753X_MTRAP, MT7530_P5_DIS);
 	else if (port == 6)
-		mt7530_clear(priv, MT753X_MTRAP, MT7530_P6_DIS);
+		regmap_clear_bits(priv->regmap, MT753X_MTRAP, MT7530_P6_DIS);
 
 	return 0;
 }
@@ -1377,8 +1360,8 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 	 * enablement for the port.
 	 */
 	priv->ports[port].enable = false;
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK,
-		   PCR_MATRIX_CLR);
+	regmap_update_bits(priv->regmap, MT7530_PCR_P(port), PCR_MATRIX_MASK,
+			   PCR_MATRIX_CLR);
 
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1387,9 +1370,9 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 
 	/* Do not set MT7530_P5_DIS when port 5 is being used for PHY muxing. */
 	if (port == 5 && priv->p5_mode == GMAC5)
-		mt7530_set(priv, MT753X_MTRAP, MT7530_P5_DIS);
+		regmap_set_bits(priv->regmap, MT753X_MTRAP, MT7530_P5_DIS);
 	else if (port == 6)
-		mt7530_set(priv, MT753X_MTRAP, MT7530_P6_DIS);
+		regmap_set_bits(priv->regmap, MT753X_MTRAP, MT7530_P6_DIS);
 }
 
 static int
@@ -1459,8 +1442,9 @@ mt7530_stp_state_set(struct dsa_switch *ds, int port, u8 state)
 		break;
 	}
 
-	mt7530_rmw(priv, MT7530_SSP_P(port), FID_PST_MASK(FID_BRIDGED),
-		   FID_PST(FID_BRIDGED, stp_state));
+	regmap_update_bits(priv->regmap, MT7530_SSP_P(port),
+			   FID_PST_MASK(FID_BRIDGED),
+			   FID_PST(FID_BRIDGED, stp_state));
 }
 
 static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
@@ -1499,8 +1483,9 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
 		}
 
 		if (other_p->enable)
-			mt7530_rmw(priv, MT7530_PCR_P(other_port),
-				   PCR_MATRIX_MASK, other_p->pm);
+			regmap_update_bits(priv->regmap,
+					   MT7530_PCR_P(other_port),
+					   PCR_MATRIX_MASK, other_p->pm);
 	}
 
 	/* Add/remove the all other ports to this port matrix. For !join
@@ -1509,7 +1494,8 @@ static void mt7530_update_port_member(struct mt7530_priv *priv, int port,
 	 */
 	p->pm = PCR_MATRIX(port_bitmap);
 	if (priv->ports[port].enable)
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_MATRIX_MASK, p->pm);
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+				   PCR_MATRIX_MASK, p->pm);
 }
 
 static int
@@ -1532,20 +1518,23 @@ mt7530_port_bridge_flags(struct dsa_switch *ds, int port,
 	struct mt7530_priv *priv = ds->priv;
 
 	if (flags.mask & BR_LEARNING)
-		mt7530_rmw(priv, MT7530_PSC_P(port), SA_DIS,
-			   flags.val & BR_LEARNING ? 0 : SA_DIS);
+		regmap_update_bits(priv->regmap, MT7530_PSC_P(port), SA_DIS,
+				   flags.val & BR_LEARNING ? 0 : SA_DIS);
 
 	if (flags.mask & BR_FLOOD)
-		mt7530_rmw(priv, MT753X_MFC, UNU_FFP(BIT(port)),
-			   flags.val & BR_FLOOD ? UNU_FFP(BIT(port)) : 0);
+		regmap_update_bits(priv->regmap, MT753X_MFC,
+				   UNU_FFP(BIT(port)),
+				   flags.val & BR_FLOOD ? UNU_FFP(BIT(port)) : 0);
 
 	if (flags.mask & BR_MCAST_FLOOD)
-		mt7530_rmw(priv, MT753X_MFC, UNM_FFP(BIT(port)),
-			   flags.val & BR_MCAST_FLOOD ? UNM_FFP(BIT(port)) : 0);
+		regmap_update_bits(priv->regmap, MT753X_MFC,
+				   UNM_FFP(BIT(port)),
+				   flags.val & BR_MCAST_FLOOD ? UNM_FFP(BIT(port)) : 0);
 
 	if (flags.mask & BR_BCAST_FLOOD)
-		mt7530_rmw(priv, MT753X_MFC, BC_FFP(BIT(port)),
-			   flags.val & BR_BCAST_FLOOD ? BC_FFP(BIT(port)) : 0);
+		regmap_update_bits(priv->regmap, MT753X_MFC,
+				   BC_FFP(BIT(port)),
+				   flags.val & BR_BCAST_FLOOD ? BC_FFP(BIT(port)) : 0);
 
 	if (flags.mask & BR_ISOLATED) {
 		struct dsa_port *dp = dsa_to_port(ds, port);
@@ -1573,8 +1562,8 @@ mt7530_port_bridge_join(struct dsa_switch *ds, int port,
 	mt7530_update_port_member(priv, port, bridge.dev, true);
 
 	/* Set to fallback mode for independent VLAN learning */
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-		   MT7530_PORT_FALLBACK_MODE);
+	regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+			   PCR_PORT_VLAN_MASK, MT7530_PORT_FALLBACK_MODE);
 
 	mutex_unlock(&priv->reg_mutex);
 
@@ -1637,18 +1626,19 @@ mt7530_port_set_vlan_unaware(struct dsa_switch *ds, int port)
 	 * bridge. Don't set standalone ports to fallback mode.
 	 */
 	if (dsa_port_bridge_dev_get(dsa_to_port(ds, port)))
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-			   MT7530_PORT_FALLBACK_MODE);
-
-	mt7530_rmw(priv, MT7530_PVC_P(port),
-		   VLAN_ATTR_MASK | PVC_EG_TAG_MASK | ACC_FRM_MASK,
-		   VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
-		   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
-		   MT7530_VLAN_ACC_ALL);
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+				   PCR_PORT_VLAN_MASK,
+				   MT7530_PORT_FALLBACK_MODE);
+
+	regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+			   VLAN_ATTR_MASK | PVC_EG_TAG_MASK | ACC_FRM_MASK,
+			   VLAN_ATTR(MT7530_VLAN_TRANSPARENT) |
+			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT) |
+			   MT7530_VLAN_ACC_ALL);
 
 	/* Set PVID to 0 */
-	mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-		   G0_PORT_VID_DEF);
+	regmap_update_bits(priv->regmap, MT7530_PPBV1_P(port),
+			   G0_PORT_VID_MASK, G0_PORT_VID_DEF);
 
 	for (i = 0; i < priv->ds->num_ports; i++) {
 		if (i == port)
@@ -1679,24 +1669,27 @@ mt7530_port_set_vlan_aware(struct dsa_switch *ds, int port)
 	 * table lookup.
 	 */
 	if (dsa_is_user_port(ds, port)) {
-		mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-			   MT7530_PORT_SECURITY_MODE);
-		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-			   G0_PORT_VID(priv->ports[port].pvid));
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+				   PCR_PORT_VLAN_MASK,
+				   MT7530_PORT_SECURITY_MODE);
+		regmap_update_bits(priv->regmap, MT7530_PPBV1_P(port),
+				   G0_PORT_VID_MASK,
+				   G0_PORT_VID(priv->ports[port].pvid));
 
 		/* Only accept tagged frames if PVID is not set */
 		if (!priv->ports[port].pvid)
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
+			regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+					   ACC_FRM_MASK,
+					   MT7530_VLAN_ACC_TAGGED);
 
 		/* Set the port as a user port which is to be able to recognize
 		 * VID from incoming packets before fetching entry within the
 		 * VLAN table.
 		 */
-		mt7530_rmw(priv, MT7530_PVC_P(port),
-			   VLAN_ATTR_MASK | PVC_EG_TAG_MASK,
-			   VLAN_ATTR(MT7530_VLAN_USER) |
-			   PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));
+		regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+				   VLAN_ATTR_MASK | PVC_EG_TAG_MASK,
+				   VLAN_ATTR(MT7530_VLAN_USER) |
+				   PVC_EG_TAG(MT7530_VLAN_EG_DISABLED));
 	} else {
 		/* Also set CPU ports to the "user" VLAN port attribute, to
 		 * allow VLAN classification, but keep the EG_TAG attribute as
@@ -1705,8 +1698,9 @@ mt7530_port_set_vlan_aware(struct dsa_switch *ds, int port)
 		 * are forwarded to user ports as tagged, and untagged as
 		 * untagged.
 		 */
-		mt7530_rmw(priv, MT7530_PVC_P(port), VLAN_ATTR_MASK,
-			   VLAN_ATTR(MT7530_VLAN_USER));
+		regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+				   VLAN_ATTR_MASK,
+				   VLAN_ATTR(MT7530_VLAN_USER));
 	}
 }
 
@@ -1724,8 +1718,8 @@ mt7530_port_bridge_leave(struct dsa_switch *ds, int port,
 	 * back to the default as is at initial boot which is a VLAN-unaware
 	 * port.
 	 */
-	mt7530_rmw(priv, MT7530_PCR_P(port), PCR_PORT_VLAN_MASK,
-		   MT7530_PORT_MATRIX_MODE);
+	regmap_update_bits(priv->regmap, MT7530_PCR_P(port),
+			   PCR_PORT_VLAN_MASK, MT7530_PORT_MATRIX_MODE);
 
 	mutex_unlock(&priv->reg_mutex);
 }
@@ -1906,9 +1900,9 @@ mt7530_hw_vlan_add(struct mt7530_priv *priv,
 		val = MT7530_VLAN_EGRESS_UNTAG;
 	else
 		val = MT7530_VLAN_EGRESS_TAG;
-	mt7530_rmw(priv, MT7530_VAWD2,
-		   ETAG_CTRL_P_MASK(entry->port),
-		   ETAG_CTRL_P(entry->port, val));
+	regmap_update_bits(priv->regmap, MT7530_VAWD2,
+			   ETAG_CTRL_P_MASK(entry->port),
+			   ETAG_CTRL_P(entry->port, val));
 }
 
 static void
@@ -1986,25 +1980,26 @@ mt7530_port_vlan_add(struct dsa_switch *ds, int port,
 		priv->ports[port].pvid = vlan->vid;
 
 		/* Accept all frames if PVID is set */
-		mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-			   MT7530_VLAN_ACC_ALL);
+		regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+				   ACC_FRM_MASK, MT7530_VLAN_ACC_ALL);
 
 		/* Only configure PVID if VLAN filtering is enabled */
 		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PPBV1_P(port),
-				   G0_PORT_VID_MASK,
-				   G0_PORT_VID(vlan->vid));
+			regmap_update_bits(priv->regmap, MT7530_PPBV1_P(port),
+					   G0_PORT_VID_MASK,
+					   G0_PORT_VID(vlan->vid));
 	} else if (vlan->vid && priv->ports[port].pvid == vlan->vid) {
 		/* This VLAN is overwritten without PVID, so unset it */
 		priv->ports[port].pvid = G0_PORT_VID_DEF;
 
 		/* Only accept tagged frames if the port is VLAN-aware */
 		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
+			regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+					   ACC_FRM_MASK,
+					   MT7530_VLAN_ACC_TAGGED);
 
-		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-			   G0_PORT_VID_DEF);
+		regmap_update_bits(priv->regmap, MT7530_PPBV1_P(port),
+				   G0_PORT_VID_MASK, G0_PORT_VID_DEF);
 	}
 
 	mutex_unlock(&priv->reg_mutex);
@@ -2038,11 +2033,12 @@ mt7530_port_vlan_del(struct dsa_switch *ds, int port,
 
 		/* Only accept tagged frames if the port is VLAN-aware */
 		if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)))
-			mt7530_rmw(priv, MT7530_PVC_P(port), ACC_FRM_MASK,
-				   MT7530_VLAN_ACC_TAGGED);
+			regmap_update_bits(priv->regmap, MT7530_PVC_P(port),
+					   ACC_FRM_MASK,
+					   MT7530_VLAN_ACC_TAGGED);
 
-		mt7530_rmw(priv, MT7530_PPBV1_P(port), G0_PORT_VID_MASK,
-			   G0_PORT_VID_DEF);
+		regmap_update_bits(priv->regmap, MT7530_PPBV1_P(port),
+				   G0_PORT_VID_MASK, G0_PORT_VID_DEF);
 	}
 
 
@@ -2149,9 +2145,9 @@ mt7530_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
 	u32 bit = mt7530_gpio_to_bit(offset);
 
 	if (value)
-		mt7530_set(priv, MT7530_LED_GPIO_DATA, bit);
+		regmap_set_bits(priv->regmap, MT7530_LED_GPIO_DATA, bit);
 	else
-		mt7530_clear(priv, MT7530_LED_GPIO_DATA, bit);
+		regmap_clear_bits(priv->regmap, MT7530_LED_GPIO_DATA, bit);
 
 	return 0;
 }
@@ -2172,8 +2168,8 @@ mt7530_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
 	struct mt7530_priv *priv = gpiochip_get_data(gc);
 	u32 bit = mt7530_gpio_to_bit(offset);
 
-	mt7530_clear(priv, MT7530_LED_GPIO_OE, bit);
-	mt7530_clear(priv, MT7530_LED_GPIO_DIR, bit);
+	regmap_clear_bits(priv->regmap, MT7530_LED_GPIO_OE, bit);
+	regmap_clear_bits(priv->regmap, MT7530_LED_GPIO_DIR, bit);
 
 	return 0;
 }
@@ -2184,14 +2180,14 @@ mt7530_gpio_direction_output(struct gpio_chip *gc, unsigned int offset, int valu
 	struct mt7530_priv *priv = gpiochip_get_data(gc);
 	u32 bit = mt7530_gpio_to_bit(offset);
 
-	mt7530_set(priv, MT7530_LED_GPIO_DIR, bit);
+	regmap_set_bits(priv->regmap, MT7530_LED_GPIO_DIR, bit);
 
 	if (value)
-		mt7530_set(priv, MT7530_LED_GPIO_DATA, bit);
+		regmap_set_bits(priv->regmap, MT7530_LED_GPIO_DATA, bit);
 	else
-		mt7530_clear(priv, MT7530_LED_GPIO_DATA, bit);
+		regmap_clear_bits(priv->regmap, MT7530_LED_GPIO_DATA, bit);
 
-	mt7530_set(priv, MT7530_LED_GPIO_OE, bit);
+	regmap_set_bits(priv->regmap, MT7530_LED_GPIO_OE, bit);
 
 	return 0;
 }
@@ -2297,7 +2293,8 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 
 	/* This register must be set for MT7530 to properly fire interrupts */
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
-		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
+		regmap_set_bits(priv->regmap, MT7530_TOP_SIG_CTRL,
+				TOP_SIG_CTRL_NORMAL);
 
 	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
 					      priv->regmap, irq,
@@ -2475,14 +2472,15 @@ mt7530_setup(struct dsa_switch *ds)
 			     TD_DM_DRVP(8) | TD_DM_DRVN(8));
 
 	for (i = 0; i < NUM_TRGMII_CTRL; i++)
-		mt7530_rmw(priv, MT7530_TRGMII_RD(i),
-			   RD_TAP_MASK, RD_TAP(16));
+		regmap_update_bits(priv->regmap, MT7530_TRGMII_RD(i),
+				   RD_TAP_MASK, RD_TAP(16));
 
 	/* Allow modifying the trap and directly access PHY registers via the
 	 * MDIO bus the switch is on.
 	 */
-	mt7530_rmw(priv, MT753X_MTRAP, MT7530_CHG_TRAP |
-		   MT7530_PHY_INDIRECT_ACCESS, MT7530_CHG_TRAP);
+	regmap_update_bits(priv->regmap, MT753X_MTRAP,
+			   MT7530_CHG_TRAP | MT7530_PHY_INDIRECT_ACCESS,
+			   MT7530_CHG_TRAP);
 
 	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
@@ -2496,17 +2494,16 @@ mt7530_setup(struct dsa_switch *ds)
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
-		mt7530_rmw(priv, MT753X_PMCR_P(i),
-			   PMCR_LINK_SETTINGS_MASK |
-			   MT753X_FORCE_MODE(priv->id),
-			   MT753X_FORCE_MODE(priv->id));
+		regmap_update_bits(priv->regmap, MT753X_PMCR_P(i),
+				   PMCR_LINK_SETTINGS_MASK | MT753X_FORCE_MODE(priv->id),
+				   MT753X_FORCE_MODE(priv->id));
 
 		/* Disable forwarding by default on all ports */
-		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
-			   PCR_MATRIX_CLR);
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(i),
+				   PCR_MATRIX_MASK, PCR_MATRIX_CLR);
 
 		/* Disable learning by default on all ports */
-		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
+		regmap_set_bits(priv->regmap, MT7530_PSC_P(i), SA_DIS);
 
 		if (dsa_is_cpu_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
@@ -2514,16 +2511,17 @@ mt7530_setup(struct dsa_switch *ds)
 			mt7530_port_disable(ds, i);
 
 			/* Set default PVID to 0 on all user ports */
-			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
-				   G0_PORT_VID_DEF);
+			regmap_update_bits(priv->regmap, MT7530_PPBV1_P(i),
+					   G0_PORT_VID_MASK, G0_PORT_VID_DEF);
 		}
 		/* Enable consistent egress tag */
-		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
-			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
+		regmap_update_bits(priv->regmap, MT7530_PVC_P(i),
+				   PVC_EG_TAG_MASK,
+				   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
 	/* Allow mirroring frames received on the local port (monitor port). */
-	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+	regmap_set_bits(priv->regmap, MT753X_AGC, LOCAL_EN);
 
 	/* Setup VLAN ID 0 for VLAN-unaware bridges */
 	ret = mt7530_setup_vlan0(priv);
@@ -2570,7 +2568,8 @@ mt7530_setup(struct dsa_switch *ds)
 
 		if (priv->p5_mode == MUX_PHY_P0 ||
 		    priv->p5_mode == MUX_PHY_P4) {
-			mt7530_clear(priv, MT753X_MTRAP, MT7530_P5_DIS);
+			regmap_clear_bits(priv->regmap, MT753X_MTRAP,
+					  MT7530_P5_DIS);
 			mt7530_setup_port5(ds, interface);
 		}
 	}
@@ -2609,26 +2608,26 @@ mt7531_setup_common(struct dsa_switch *ds)
 	mt7530_mib_reset(ds);
 
 	/* Disable flooding on all ports */
-	mt7530_clear(priv, MT753X_MFC, BC_FFP_MASK | UNM_FFP_MASK |
-		     UNU_FFP_MASK);
+	regmap_clear_bits(priv->regmap, MT753X_MFC,
+			  BC_FFP_MASK | UNM_FFP_MASK | UNU_FFP_MASK);
 
 	for (i = 0; i < priv->ds->num_ports; i++) {
 		/* Clear link settings and enable force mode to force link down
 		 * on all ports until they're enabled later.
 		 */
-		mt7530_rmw(priv, MT753X_PMCR_P(i),
-			   PMCR_LINK_SETTINGS_MASK |
-			   MT753X_FORCE_MODE(priv->id),
-			   MT753X_FORCE_MODE(priv->id));
+		regmap_update_bits(priv->regmap, MT753X_PMCR_P(i),
+				   PMCR_LINK_SETTINGS_MASK | MT753X_FORCE_MODE(priv->id),
+				   MT753X_FORCE_MODE(priv->id));
 
 		/* Disable forwarding by default on all ports */
-		mt7530_rmw(priv, MT7530_PCR_P(i), PCR_MATRIX_MASK,
-			   PCR_MATRIX_CLR);
+		regmap_update_bits(priv->regmap, MT7530_PCR_P(i),
+				   PCR_MATRIX_MASK, PCR_MATRIX_CLR);
 
 		/* Disable learning by default on all ports */
-		mt7530_set(priv, MT7530_PSC_P(i), SA_DIS);
+		regmap_set_bits(priv->regmap, MT7530_PSC_P(i), SA_DIS);
 
-		mt7530_set(priv, MT7531_DBG_CNT(i), MT7531_DIS_CLR);
+		regmap_set_bits(priv->regmap, MT7531_DBG_CNT(i),
+				MT7531_DIS_CLR);
 
 		if (dsa_is_cpu_port(ds, i)) {
 			mt753x_cpu_port_enable(ds, i);
@@ -2636,17 +2635,18 @@ mt7531_setup_common(struct dsa_switch *ds)
 			mt7530_port_disable(ds, i);
 
 			/* Set default PVID to 0 on all user ports */
-			mt7530_rmw(priv, MT7530_PPBV1_P(i), G0_PORT_VID_MASK,
-				   G0_PORT_VID_DEF);
+			regmap_update_bits(priv->regmap, MT7530_PPBV1_P(i),
+					   G0_PORT_VID_MASK, G0_PORT_VID_DEF);
 		}
 
 		/* Enable consistent egress tag */
-		mt7530_rmw(priv, MT7530_PVC_P(i), PVC_EG_TAG_MASK,
-			   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
+		regmap_update_bits(priv->regmap, MT7530_PVC_P(i),
+				   PVC_EG_TAG_MASK,
+				   PVC_EG_TAG(MT7530_VLAN_EG_CONSISTENT));
 	}
 
 	/* Allow mirroring frames received on the local port (monitor port). */
-	mt7530_set(priv, MT753X_AGC, LOCAL_EN);
+	regmap_set_bits(priv->regmap, MT753X_AGC, LOCAL_EN);
 
 	/* Enable Special Tag for rx frames */
 	if (priv->id == ID_EN7581 || priv->id == ID_AN7583)
@@ -2722,14 +2722,16 @@ mt7531_setup(struct dsa_switch *ds)
 		 * MT7531AE. Set the GPIO 11-12 pins to function as MDC and MDIO
 		 * to expose the MDIO bus of the switch.
 		 */
-		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO11_RG_RXD2_MASK,
-			   MT7531_EXT_P_MDC_11);
-		mt7530_rmw(priv, MT7531_GPIO_MODE1, MT7531_GPIO12_RG_RXD3_MASK,
-			   MT7531_EXT_P_MDIO_12);
+		regmap_update_bits(priv->regmap, MT7531_GPIO_MODE1,
+				   MT7531_GPIO11_RG_RXD2_MASK,
+				   MT7531_EXT_P_MDC_11);
+		regmap_update_bits(priv->regmap, MT7531_GPIO_MODE1,
+				   MT7531_GPIO12_RG_RXD3_MASK,
+				   MT7531_EXT_P_MDIO_12);
 	}
 
-	mt7530_rmw(priv, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
-		   MT7531_GPIO0_INTERRUPT);
+	regmap_update_bits(priv->regmap, MT7531_GPIO_MODE0, MT7531_GPIO0_MASK,
+			   MT7531_GPIO0_INTERRUPT);
 
 	/* Enable Energy-Efficient Ethernet (EEE) and PHY core PLL, since
 	 * phy_device has not yet been created provided for
@@ -3005,7 +3007,8 @@ mt753x_phylink_mac_config(struct phylink_config *config, unsigned int mode,
 
 	/* Are we connected to external phy */
 	if (port == 5 && dsa_is_user_port(ds, 5))
-		mt7530_set(priv, MT753X_PMCR_P(port), PMCR_EXT_PHY);
+		regmap_set_bits(priv->regmap, MT753X_PMCR_P(port),
+				PMCR_EXT_PHY);
 }
 
 static void mt753x_phylink_mac_link_down(struct phylink_config *config,
@@ -3015,7 +3018,8 @@ static void mt753x_phylink_mac_link_down(struct phylink_config *config,
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct mt7530_priv *priv = dp->ds->priv;
 
-	mt7530_clear(priv, MT753X_PMCR_P(dp->index), PMCR_LINK_SETTINGS_MASK);
+	regmap_clear_bits(priv->regmap, MT753X_PMCR_P(dp->index),
+			  PMCR_LINK_SETTINGS_MASK);
 }
 
 static void mt753x_phylink_mac_link_up(struct phylink_config *config,
@@ -3049,7 +3053,7 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
 			mcr |= PMCR_FORCE_RX_FC_EN;
 	}
 
-	mt7530_set(priv, MT753X_PMCR_P(dp->index), mcr);
+	regmap_set_bits(priv->regmap, MT753X_PMCR_P(dp->index), mcr);
 }
 
 static void mt753x_phylink_mac_disable_tx_lpi(struct phylink_config *config)
@@ -3057,8 +3061,8 @@ static void mt753x_phylink_mac_disable_tx_lpi(struct phylink_config *config)
 	struct dsa_port *dp = dsa_phylink_to_port(config);
 	struct mt7530_priv *priv = dp->ds->priv;
 
-	mt7530_clear(priv, MT753X_PMCR_P(dp->index),
-		     PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100);
+	regmap_clear_bits(priv->regmap, MT753X_PMCR_P(dp->index),
+			  PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100);
 }
 
 static int mt753x_phylink_mac_enable_tx_lpi(struct phylink_config *config,
@@ -3079,11 +3083,11 @@ static int mt753x_phylink_mac_enable_tx_lpi(struct phylink_config *config,
 	else
 		val = LPI_THRESH_MASK;
 
-	mt7530_rmw(priv, MT753X_PMEEECR_P(dp->index),
-		   LPI_THRESH_MASK | LPI_MODE_EN, val);
+	regmap_update_bits(priv->regmap, MT753X_PMEEECR_P(dp->index),
+			   LPI_THRESH_MASK | LPI_MODE_EN, val);
 
-	mt7530_set(priv, MT753X_PMCR_P(dp->index),
-		   PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100);
+	regmap_set_bits(priv->regmap, MT753X_PMCR_P(dp->index),
+			PMCR_FORCE_EEE1G | PMCR_FORCE_EEE100);
 
 	return 0;
 }
@@ -3268,7 +3272,8 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 		      MT7530_CPU_PORT(__ffs(priv->active_cpu_ports));
 	}
 
-	mt7530_rmw(priv, MT753X_MFC, MT7530_CPU_EN | MT7530_CPU_PORT_MASK, val);
+	regmap_update_bits(priv->regmap, MT753X_MFC,
+			   MT7530_CPU_EN | MT7530_CPU_PORT_MASK, val);
 }
 
 static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
@@ -3285,8 +3290,8 @@ static int mt753x_tc_setup_qdisc_tbf(struct dsa_switch *ds, int port,
 	case TC_TBF_DESTROY: {
 		u32 val, tick;
 
-		mt7530_rmw(priv, MT753X_GERLCR, EGR_BC_MASK,
-			   EGR_BC_CRC_IPG_PREAMBLE);
+		regmap_update_bits(priv->regmap, MT753X_GERLCR, EGR_BC_MASK,
+				   EGR_BC_CRC_IPG_PREAMBLE);
 
 		/* if rate is greater than 10Mbps tick is 1/32 ms,
 		 * 1ms otherwise
@@ -3330,13 +3335,13 @@ static int mt7988_setup(struct dsa_switch *ds)
 
 	/* AN7583 require additional tweak to CONN_CFG */
 	if (priv->id == ID_AN7583)
-		mt7530_rmw(priv, AN7583_GEPHY_CONN_CFG,
-			   AN7583_CSR_DPHY_CKIN_SEL |
-			   AN7583_CSR_PHY_CORE_REG_CLK_SEL |
-			   AN7583_CSR_ETHER_AFE_PWD,
-			   AN7583_CSR_DPHY_CKIN_SEL |
-			   AN7583_CSR_PHY_CORE_REG_CLK_SEL |
-			   FIELD_PREP(AN7583_CSR_ETHER_AFE_PWD, 0));
+		regmap_update_bits(priv->regmap, AN7583_GEPHY_CONN_CFG,
+				   AN7583_CSR_DPHY_CKIN_SEL |
+				   AN7583_CSR_PHY_CORE_REG_CLK_SEL |
+				   AN7583_CSR_ETHER_AFE_PWD,
+				   AN7583_CSR_DPHY_CKIN_SEL |
+				   AN7583_CSR_PHY_CORE_REG_CLK_SEL |
+				   FIELD_PREP(AN7583_CSR_ETHER_AFE_PWD, 0));
 
 	/* Reset the switch PHYs */
 	regmap_write(priv->regmap, MT7530_SYS_CTRL, SYS_CTRL_PHY_RST);
-- 
2.55.0
