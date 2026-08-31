Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9418053D0BA;
	Mon, 31 Aug 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190727; cv=none; b=uZ+M89xgVyFwMnEGKwFeQfbbyCCukxoA2q1VQ/bFdZMlISZC5Rq9WUkGfHL80/FME8otYoZAxt6nzbvfGy5BsHyrlgF1wxa/SksDVQXVZ9NSiqWeZOU3CYeKfJN1EaJNG19bwC15ynHYkRsxR7lyyCDmY1v0obmBiDduK40cR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190727; c=relaxed/simple;
	bh=KdmBbD+M/4Riy07OmlGWkHvfvQFkTg865/xZpiLwYnc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIreumiZAvSK20Q2NhHOZuY3GFbz4YTc+weFYRzgKHudYQQY3zzHUqmY8MOoiOmKJRDCNmEfpwQHEUO1SXyDQarAVoBRSWawIQCginmdsJQaH2zEj+F++5t/grRXykCp0iJ0A3Cp10nH5Ei0uv/9PS7pf5Felhy7CcH4OiJ12JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x145m-000000007BZ-3Rzw;
	Mon, 31 Aug 2026 15:38:38 +0000
Date: Mon, 31 Aug 2026 16:38:35 +0100
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
Subject: [PATCH net-next v5 5/9] net: dsa: mt7530: replace mt7530_read with
 regmap_read
Message-ID: <a1dc338ae368554ec6faa974df7ba6f3660ae12b.1788190568.git.daniel@makrotopia.org>
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

Replace all mt7530_read() calls with direct regmap_read() calls and
remove the wrapper function. The wrapper returned 0 on failed reads;
preserve that behaviour by zeroing the read-back buffer at the start of
mt7530_regmap_read(), so callers that do not check the return code keep
seeing a deterministic value. The WARN_ON_ONCE error logging is dropped.

Most callsites follow the val = mt7530_read(priv, reg) pattern and are
converted mechanically using the following semantic patch:

@@
expression priv, reg;
identifier val;
@@
-val = mt7530_read(priv, reg);
+regmap_read(priv->regmap, reg, &val);

Remaining inline uses are converted by hand.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5:
 * resolve merge conflict after commit cf23fcc9437e ("net: dsa: mt7530:
   add EN7528 support")
 * the ATC/VTCR status reads are already regmap_read() via the polling
   fixes now in net-next, which also address the read-failure paths
   Sashiko flagged on v4
v4:
 * zero the read-back buffer in mt7530_regmap_read() instead of
   initializing the result variables at every call site
v3:
 * init read-back variables to 0 to preserve the old read-failure
   behaviour
 * use u32 for val in mt7530_setup_port5
v2: drop fix for stray 'static void' leftover now correctly squashed
    into 4/8
---
 drivers/net/dsa/mt7530-mdio.c |   3 +
 drivers/net/dsa/mt7530.c      | 113 +++++++++++++++++-----------------
 2 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 422f785d2143..81c5c6f7066d 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -48,6 +48,9 @@ mt7530_regmap_read(void *context, unsigned int reg, unsigned int *val)
 	u16 page, r, lo, hi;
 	int ret;
 
+	/* Callers do not check for errors, keep the value deterministic */
+	*val = 0;
+
 	page = (reg >> 6) & 0x3ff;
 	r = (reg >> 2) & 0xf;
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 0ff8a9eda3e4..57f38d39058a 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -155,28 +155,15 @@ core_clear(struct mt7530_priv *priv, u32 reg, u32 val)
 }
 
 static u32
-mt7530_read(struct mt7530_priv *priv, u32 reg)
+mt7530_mii_poll(struct mt7530_dummy_poll *p)
 {
-	int ret;
 	u32 val;
 
-	ret = regmap_read(priv->regmap, reg, &val);
-	if (ret) {
-		WARN_ON_ONCE(1);
-		dev_err(priv->dev,
-			"failed to read mt7530 register\n");
-		return 0;
-	}
+	regmap_read(p->priv->regmap, p->reg, &val);
 
 	return val;
 }
 
-static u32
-mt7530_mii_poll(struct mt7530_dummy_poll *p)
-{
-	return mt7530_read(p->priv, p->reg);
-}
-
 static int
 mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 {
@@ -219,7 +206,8 @@ mt7530_fdb_read(struct mt7530_priv *priv, struct mt7530_fdb *fdb)
 
 	/* Read from ARL table into an array */
 	for (i = 0; i < 3; i++) {
-		reg[i] = mt7530_read(priv, MT7530_TSRA1 + (i * 4));
+		regmap_read(priv->regmap, MT7530_TSRA1 + (i * 4),
+			    &reg[i]);
 
 		dev_dbg(priv->dev, "%s(%d) reg[%d]=0x%x\n",
 			__func__, __LINE__, i, reg[i]);
@@ -326,7 +314,8 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 	regmap_update_bits(priv->regmap, MT7530_P6ECR, P6_INTF_MODE_MASK,
 			   P6_INTF_MODE(1));
 
-	xtal = mt7530_read(priv, MT753X_MTRAP) & MT7530_XTAL_MASK;
+	regmap_read(priv->regmap, MT753X_MTRAP, &xtal);
+	xtal &= MT7530_XTAL_MASK;
 
 	if (xtal == MT7530_XTAL_25MHZ)
 		ssc_delta = 0x57;
@@ -370,9 +359,9 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	u32 hwstrap;
 	u32 val;
 
-	val = mt7530_read(priv, MT7531_CREV);
-	top_sig = mt7530_read(priv, MT7531_TOP_SIG_SR);
-	hwstrap = mt7530_read(priv, MT753X_TRAP);
+	regmap_read(priv->regmap, MT7531_CREV, &val);
+	regmap_read(priv->regmap, MT7531_TOP_SIG_SR, &top_sig);
+	regmap_read(priv->regmap, MT753X_TRAP, &hwstrap);
 	if ((val & CHIP_REV_M) > 0)
 		xtal = (top_sig & PAD_MCM_SMI_EN) ? MT7531_XTAL_FSEL_40MHZ :
 						    MT7531_XTAL_FSEL_25MHZ;
@@ -381,26 +370,26 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 						   MT7531_XTAL_FSEL_40MHZ;
 
 	/* Step 1 : Disable MT7531 COREPLL */
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val &= ~EN_COREPLL;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	/* Step 2: switch to XTAL output */
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val |= SW_CLKSW;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val &= ~RG_COREPLL_EN;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
 	/* Step 3: disable PLLGP and enable program PLLGP */
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val |= SW_PLLGP;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 
 	/* Step 4: program COREPLL output frequency to 500MHz */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val &= ~RG_COREPLL_POSDIV_M;
 	val |= 2 << RG_COREPLL_POSDIV_S;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
@@ -408,13 +397,13 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 
 	switch (xtal) {
 	case MT7531_XTAL_FSEL_25MHZ:
-		val = mt7530_read(priv, MT7531_PLLGP_CR0);
+		regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x140000 << RG_COREPLL_SDM_PCW_S;
 		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 		break;
 	case MT7531_XTAL_FSEL_40MHZ:
-		val = mt7530_read(priv, MT7531_PLLGP_CR0);
+		regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 		val &= ~RG_COREPLL_SDM_PCW_M;
 		val |= 0x190000 << RG_COREPLL_SDM_PCW_S;
 		regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
@@ -422,14 +411,14 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	}
 
 	/* Set feedback divide ratio update signal to high */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val |= RG_COREPLL_SDM_PCW_CHG;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 	/* Wait for at least 16 XTAL clocks */
 	usleep_range(10, 20);
 
 	/* Step 5: set feedback divide ratio update signal to low */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val &= ~RG_COREPLL_SDM_PCW_CHG;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
@@ -440,11 +429,11 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	regmap_write(priv->regmap, MT7531_ANA_PLLGP_CR2, 0x4f40000);
 
 	/* Step 6: Enable MT7531 PLL */
-	val = mt7530_read(priv, MT7531_PLLGP_CR0);
+	regmap_read(priv->regmap, MT7531_PLLGP_CR0, &val);
 	val |= RG_COREPLL_EN;
 	regmap_write(priv->regmap, MT7531_PLLGP_CR0, val);
 
-	val = mt7530_read(priv, MT7531_PLLGP_EN);
+	regmap_read(priv->regmap, MT7531_PLLGP_EN, &val);
 	val |= EN_COREPLL;
 	regmap_write(priv->regmap, MT7531_PLLGP_EN, val);
 	usleep_range(25, 35);
@@ -709,11 +698,11 @@ mt7530_read_port_stats(struct mt7530_priv *priv, int port,
 {
 	u32 val, reg = MT7530_PORT_MIB_COUNTER(port) + offset;
 
-	val = mt7530_read(priv, reg);
+	regmap_read(priv->regmap, reg, &val);
 	*data = val;
 
 	if (size == 2) {
-		val = mt7530_read(priv, reg + 4);
+		regmap_read(priv->regmap, reg + 4, &val);
 		*data |= (u64)val << 32;
 	}
 }
@@ -1017,11 +1006,11 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u8 tx_delay = 0;
-	int val;
+	u32 val;
 
 	mutex_lock(&priv->reg_mutex);
 
-	val = mt7530_read(priv, MT753X_MTRAP);
+	regmap_read(priv->regmap, MT753X_MTRAP, &val);
 
 	val &= ~MT7530_P5_PHY0_SEL & ~MT7530_P5_MAC_SEL & ~MT7530_P5_RGMII_MODE;
 
@@ -1389,7 +1378,7 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	val = mt7530_read(priv, MT7530_GMACCR);
+	regmap_read(priv->regmap, MT7530_GMACCR, &val);
 	val &= ~MAX_RX_PKT_LEN_MASK;
 
 	/* RX length also includes Ethernet header, MTK tag, and FCS length */
@@ -1802,14 +1791,16 @@ mt7530_port_mdb_add(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 	u8 port_mask = 0;
+	u32 val;
 	int ret;
 
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
-	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL))
-		port_mask = (mt7530_read(priv, MT7530_ATRD) >> PORT_MAP)
-			    & PORT_MAP_MASK;
+	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL)) {
+		regmap_read(priv->regmap, MT7530_ATRD, &val);
+		port_mask = (val >> PORT_MAP) & PORT_MAP_MASK;
+	}
 
 	port_mask |= BIT(port);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1, STATIC_ENT);
@@ -1829,14 +1820,16 @@ mt7530_port_mdb_del(struct dsa_switch *ds, int port,
 	const u8 *addr = mdb->addr;
 	u16 vid = mdb->vid;
 	u8 port_mask = 0;
+	u32 val;
 	int ret;
 
 	mutex_lock(&priv->reg_mutex);
 
 	mt7530_fdb_write(priv, vid, 0, addr, 0, STATIC_EMP);
-	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL))
-		port_mask = (mt7530_read(priv, MT7530_ATRD) >> PORT_MAP)
-			    & PORT_MAP_MASK;
+	if (!mt7530_fdb_cmd(priv, MT7530_FDB_READ, NULL)) {
+		regmap_read(priv->regmap, MT7530_ATRD, &val);
+		port_mask = (val >> PORT_MAP) & PORT_MAP_MASK;
+	}
 
 	port_mask &= ~BIT(port);
 	mt7530_fdb_write(priv, vid, port_mask, addr, -1,
@@ -1914,7 +1907,7 @@ mt7530_hw_vlan_del(struct mt7530_priv *priv,
 
 	new_members = entry->old_members & ~BIT(entry->port);
 
-	val = mt7530_read(priv, MT7530_VAWD1);
+	regmap_read(priv->regmap, MT7530_VAWD1, &val);
 	if (!(val & VLAN_VALID)) {
 		dev_err(priv->dev,
 			"Cannot be deleted due to invalid entry\n");
@@ -1941,7 +1934,7 @@ mt7530_hw_vlan_update(struct mt7530_priv *priv, u16 vid,
 	/* Fetch entry */
 	mt7530_vlan_cmd(priv, MT7530_VTCR_RD_VID, vid);
 
-	val = mt7530_read(priv, MT7530_VAWD1);
+	regmap_read(priv->regmap, MT7530_VAWD1, &val);
 
 	entry->old_members = (val >> PORT_MEM_SHFT) & PORT_MEM_MASK;
 
@@ -2059,7 +2052,7 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	if ((ingress ? priv->mirror_rx : priv->mirror_tx) & BIT(port))
 		return -EEXIST;
 
-	val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
+	regmap_read(priv->regmap, MT753X_MIRROR_REG(priv->id), &val);
 
 	/* MT7530 only supports one monitor port */
 	monitor_port = MT753X_MIRROR_PORT_GET(priv->id, val);
@@ -2072,7 +2065,7 @@ static int mt753x_port_mirror_add(struct dsa_switch *ds, int port,
 	val |= MT753X_MIRROR_PORT_SET(priv->id, mirror->to_local_port);
 	regmap_write(priv->regmap, MT753X_MIRROR_REG(priv->id), val);
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
+	regmap_read(priv->regmap, MT7530_PCR_P(port), &val);
 	if (ingress) {
 		val |= PORT_RX_MIR;
 		priv->mirror_rx |= BIT(port);
@@ -2091,7 +2084,7 @@ static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 	struct mt7530_priv *priv = ds->priv;
 	u32 val;
 
-	val = mt7530_read(priv, MT7530_PCR_P(port));
+	regmap_read(priv->regmap, MT7530_PCR_P(port), &val);
 	if (mirror->ingress) {
 		val &= ~PORT_RX_MIR;
 		priv->mirror_rx &= ~BIT(port);
@@ -2102,7 +2095,7 @@ static void mt753x_port_mirror_del(struct dsa_switch *ds, int port,
 	regmap_write(priv->regmap, MT7530_PCR_P(port), val);
 
 	if (!priv->mirror_rx && !priv->mirror_tx) {
-		val = mt7530_read(priv, MT753X_MIRROR_REG(priv->id));
+		regmap_read(priv->regmap, MT753X_MIRROR_REG(priv->id), &val);
 		val &= ~MT753X_MIRROR_EN(priv->id);
 		regmap_write(priv->regmap, MT753X_MIRROR_REG(priv->id), val);
 	}
@@ -2134,8 +2127,11 @@ mt7530_gpio_get(struct gpio_chip *gc, unsigned int offset)
 {
 	struct mt7530_priv *priv = gpiochip_get_data(gc);
 	u32 bit = mt7530_gpio_to_bit(offset);
+	u32 val;
+
+	regmap_read(priv->regmap, MT7530_LED_GPIO_DATA, &val);
 
-	return !!(mt7530_read(priv, MT7530_LED_GPIO_DATA) & bit);
+	return !!(val & bit);
 }
 
 static int
@@ -2157,8 +2153,11 @@ mt7530_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
 {
 	struct mt7530_priv *priv = gpiochip_get_data(gc);
 	u32 bit = mt7530_gpio_to_bit(offset);
+	u32 val;
 
-	return (mt7530_read(priv, MT7530_LED_GPIO_DIR) & bit) ?
+	regmap_read(priv->regmap, MT7530_LED_GPIO_DIR, &val);
+
+	return (val & bit) ?
 		GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
 }
 
@@ -2449,7 +2448,7 @@ mt7530_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
-	id = mt7530_read(priv, MT7530_CREV);
+	regmap_read(priv->regmap, MT7530_CREV, &id);
 	id >>= CHIP_NAME_SHIFT;
 	if (id != MT7530_ID) {
 		dev_err(priv->dev, "chip %x can't be supported\n", id);
@@ -2692,7 +2691,7 @@ mt7531_setup(struct dsa_switch *ds)
 		return ret;
 	}
 
-	id = mt7530_read(priv, MT7531_CREV);
+	regmap_read(priv->regmap, MT7531_CREV, &id);
 	id >>= CHIP_NAME_SHIFT;
 
 	if (id != MT7531_ID) {
@@ -2703,7 +2702,7 @@ mt7531_setup(struct dsa_switch *ds)
 	/* MT7531AE has got two SGMII units. One for port 5, one for port 6.
 	 * MT7531BE has got only one SGMII unit which is for port 6.
 	 */
-	val = mt7530_read(priv, MT7531_TOP_SIG_SR);
+	regmap_read(priv->regmap, MT7531_TOP_SIG_SR, &val);
 	priv->p5_sgmii = !!(val & PAD_DUAL_SGMII_EN);
 
 	/* Force link down on all ports before internal reset */
@@ -2923,7 +2922,7 @@ static void mt7531_rgmii_setup(struct mt7530_priv *priv,
 {
 	u32 val;
 
-	val = mt7530_read(priv, MT7531_CLKGEN_CTRL);
+	regmap_read(priv->regmap, MT7531_CLKGEN_CTRL, &val);
 	val |= GP_CLK_EN;
 	val &= ~GP_MODE_MASK;
 	val |= GP_MODE(MT7531_GP_MODE_RGMII);
@@ -3106,7 +3105,9 @@ static void mt753x_phylink_get_caps(struct dsa_switch *ds, int port,
 	 * userspace.
 	 */
 	if (priv->id != ID_EN7528) {
-		u32 eeecr = mt7530_read(priv, MT753X_PMEEECR_P(port));
+		u32 eeecr;
+
+		regmap_read(priv->regmap, MT753X_PMEEECR_P(port), &eeecr);
 
 		config->lpi_capabilities = MAC_100FD | MAC_1000FD | MAC_2500FD;
 		/* tx_lpi_timer should be in microseconds. The time units for
@@ -3137,7 +3138,7 @@ static void mt7530_pcs_get_state(struct phylink_pcs *pcs, unsigned int neg_mode,
 	int port = pcs_to_mt753x_pcs(pcs)->port;
 	u32 pmsr;
 
-	pmsr = mt7530_read(priv, MT7530_PMSR_P(port));
+	regmap_read(priv->regmap, MT7530_PMSR_P(port), &pmsr);
 
 	state->link = (pmsr & PMSR_LINK);
 	state->an_complete = state->link;
-- 
2.55.0
