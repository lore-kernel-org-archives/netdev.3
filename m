Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150048;
	b=yLXAgD1Bi5QSHneqOkSsetul0S49j/I42UgEYe2CQiaF1H/TLruJTmX/k+wqF/ZKQvdA
	 AJRZukh8Wfwfohye/km2FChYbYE7pYLlcvyby0OINiyUbmCGzExuxbEVnbvJz3CW1S1Za
	 XRDpYpVY0o3mI0JphPlHnOxCf+PRNwOWJsVs9HS+KyEyQyKTYtXU31aJRTXYPF006Fg98
	 KZkOFjOKLbsZNrd/K5zRMdapVKnAjhezSS0g1PFuM96hNVH+sTgzl7AkdFOA9pezWB421
	 YwDLjkk2RWahjL1nQgcTAKEGn4+lltBJRSsv2NzCQlpaHEQhVcBm/YIm3bMNmndYX1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150048;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=p32JFdEkwYi11vLGDuFXo7zrPpSF1lLJlcp8f3iYAgA=;
	b=YNQ2yJEjYgrawUXs8jTiSLQ/wWsCFo1AtwB3CQxXz3LxBgzWK+Qy5BkX571wHUnKBtDZ
	 5bCmETUenDv0ZwcY5Lzor4mkygDL+WEjs0WGMJ7GHftfzE5Hg9+e3toD7aoRJBfVOp1tm
	 AETqGqDpjPcfrbONsHTfFFKRHEvZWlxWyyg0/YIIZCEsrwa92AjVt0ABSSKfNqxSFndtY
	 qPu8d0tTujqt+B6T0nrhkTfupYCXpK9WXIqbKH6Z7sXGwVqYV4cSXlUbwYJZTg2Df7o0u
	 0u24QbKNMxJkdDYAnfKMnyvXMV3FbJE6vUcTLQuZTY3Bm6OFgDgDQgQZ0rY1En6VbvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=syZsKbj+;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AFE60A2609;
	Wed, 28 Oct 2026 01:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6AFE60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=syZsKbj+
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 019EC1482F9;
	Wed, 28 Oct 2026 02:14:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793150045; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=p32JFdEkwYi11vLGDuFXo7zrPpSF1lLJlcp8f3iYAgA=;
	b=syZsKbj+9FuLCbZEBzLd8n2pUrvXN/phrDflnEbdoJXHUMb2oEEt6GUJB3fGLX/72gkayA
	MIBJkcDMJI8ezRcBGE0V39vfftgv0AxJ7eDTVATeVfTkpJ3khSviSyCrcZ4e8+i+uAKU9d
	gZq+hZCEXiIrRcg7LH+FcaW9ra06ZxE1lM4ZEKGaPm7wX632S8Cnl+/Dz+57YP2vNaVu8x
	4Kl9e/09JXJytsgG4rSBIKKYijTCdHkAvef7L/cjwhqo+kpNrqkmwj2uUPpe+Z5zbOXk5r
	8o0zLA/z9YwttimqaZgrPY+dwdkvdkxWh9lw7QxRLctUJCSBl+XK7I2V/fkzFA==
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
Subject: [PATCH v3 7/7] net: dsa: mediatek: support EN751221 switch
Date: Wed, 28 Oct 2026 01:13:17 +0000
Message-Id: <20261028011317.1557238-8-cjd@cjdns.fr>
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

The EcoNet EN751221 has either one, or two, onboard MT7530 switches.
Every implementation of this SoC has one switch on die with the CPU,
but some chips - notably those with a "G" in the name, have a second
MT7530 as an MCM module.

The on-die MT7530 has 4 FE ports and 1 GE port. The MCM switch has all
gigabit ports.

The MCM switch connects to the SoC switch via a TRGMII link from port
5 on the SoC switch to port 6 on the MCM switch. This link undergoes
calibration on startup.

All known devices with the MCM present do not make any use of the ports
on the on-die switch, it is put into "passthrough" mode in which all
traffic is shuttled between port 6 and port 5 without alteration of the
DSA tags.

Add support for both the on-die and the MCM switch, and calibration of
the TRGMII link between them.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530-mdio.c |   1 +
 drivers/net/dsa/mt7530-mmio.c |   1 +
 drivers/net/dsa/mt7530.c      | 335 +++++++++++++++++++++++++++++++++-
 drivers/net/dsa/mt7530.h      |  24 +++
 4 files changed, 357 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 0be107dc6759..03ef6a9f2084 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -139,6 +139,7 @@ mt7531_create_sgmii(struct mt7530_priv *priv)
 }
 
 static const struct of_device_id mt7530_of_match[] = {
+	{ .compatible = "econet,en751221", .data = &mt753x_table[ID_EN751221_EXT], },
 	{ .compatible = "mediatek,mt7621", .data = &mt753x_table[ID_MT7621], },
 	{ .compatible = "mediatek,mt7530", .data = &mt753x_table[ID_MT7530], },
 	{ .compatible = "mediatek,mt7531", .data = &mt753x_table[ID_MT7531], },
diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index f387190a9539..b77e3cb655aa 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -12,6 +12,7 @@
 static const struct of_device_id mt7988_of_match[] = {
 	{ .compatible = "airoha,an7583-switch", .data = &mt753x_table[ID_AN7583], },
 	{ .compatible = "airoha,en7581-switch", .data = &mt753x_table[ID_EN7581], },
+	{ .compatible = "econet,en751221-switch", .data = &mt753x_table[ID_EN751221], },
 	{ .compatible = "econet,en7528-switch", .data = &mt753x_table[ID_EN7528], },
 	{ .compatible = "mediatek,mt7988-switch", .data = &mt753x_table[ID_MT7988], },
 	{ /* sentinel */ }
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index dbe3887097db..c44f2084b173 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -49,6 +49,9 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
 static int
 mt753x_ctrl_phy_addr(struct mt7530_priv *priv)
 {
+	if (priv->id == ID_EN751221)
+		return 12;
+
 	if (WARN_ON_ONCE(!priv->mdiodev))
 		return 0;
 
@@ -347,12 +350,19 @@ mt7530_setup_port6(struct dsa_switch *ds, phy_interface_t interface)
 	regmap_read(priv->regmap, MT753X_MTRAP, &xtal);
 	xtal &= MT7530_XTAL_MASK;
 
+	/* EN751221 on-die does not report clock speed in MTRAP */
+	if (priv->id == ID_EN751221)
+		xtal = MT7530_XTAL_25MHZ;
+
 	if (xtal == MT7530_XTAL_25MHZ)
 		ssc_delta = 0x57;
 	else
 		ssc_delta = 0x87;
 
-	if (priv->id == ID_MT7621) {
+	if (priv->id == ID_EN751221_EXT || priv->id == ID_EN751221) {
+		/* PLL frequency: 362.5Mhz */
+		ncpo1 = 0x1d00;
+	} else if (priv->id == ID_MT7621) {
 		/* PLL frequency: 125MHz: 1.0GBit */
 		if (xtal == MT7530_XTAL_40MHZ)
 			ncpo1 = 0x0640;
@@ -469,6 +479,251 @@ mt7531_pll_setup(struct mt7530_priv *priv)
 	usleep_range(25, 35);
 }
 
+static bool
+en751221_trgmii_cal_ok(struct mt7530_priv *rx, u32 reg)
+{
+	u32 val = 0;
+
+	regmap_read(rx->regmap, reg, &val);
+	regmap_write(rx->regmap, reg, val | EDGE_CHK);
+	regmap_write(rx->regmap, reg, val & ~EDGE_CHK);
+	regmap_read(rx->regmap, reg, &val);
+
+	return FIELD_GET(RD_VALUE_MASK, val) == TGMII_TD_PAT &&
+	       !FIELD_GET(RD_ERR_MASK, val);
+}
+
+static void
+en751221_trgmii_calibrate_direction(struct mt7530_priv *tx,
+				    struct mt7530_priv *rx,
+				    u8 *default_taps)
+{
+	int channel;
+
+	regmap_set_bits(tx->regmap, MT7530_TRGMII_TXCTRL, TRAIN_TXEN);
+
+	/* Put fail pattern on every channel */
+	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++)
+		regmap_update_bits(tx->regmap, EN7530_TRGMII_TD_CTRL(channel),
+				   TGMII_TD_PAT_MASK,
+				   FIELD_PREP(TGMII_TD_PAT_MASK,
+					      TGMII_TD_FAIL_PAT));
+
+	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++) {
+		u32 rx_reg = MT7530_TRGMII_RD(channel);
+		int best_tap = -1, best_range = -1;
+		int first = -1;
+		u8 dac;
+		char log[TD_TAP_MAX + 1];
+
+		/* Put test pattern on correct channel */
+		regmap_update_bits(tx->regmap, EN7530_TRGMII_TD_CTRL(channel),
+				   TGMII_TD_PAT_MASK,
+				   FIELD_PREP(TGMII_TD_PAT_MASK, TGMII_TD_PAT));
+
+		for (dac = 0; dac < TD_TAP_MAX; dac++) {
+			/* Set TAP */
+			regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
+					   RD_TAP(dac));
+
+			/* Check if we can get a good read */
+			if (en751221_trgmii_cal_ok(rx, rx_reg)) {
+				log[dac] = '+';
+
+				if (first < 0)
+					first = dac;
+
+				if ((dac - first) > best_range) {
+					best_tap = (first + dac) / 2;
+					best_range = dac - first;
+				}
+			} else {
+				log[dac] = '.';
+				first = -1;
+			}
+		}
+
+		log[TD_TAP_MAX] = '\0';
+
+		if (best_tap > -1) {
+			regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
+					   RD_TAP(best_tap));
+
+			log[best_tap] = 'X';
+
+			dev_info(rx->dev,
+				 "TRGMII lane %d: %s tap %d old %d\n",
+				 channel, log, best_tap, default_taps[channel]);
+		} else {
+			regmap_update_bits(rx->regmap, rx_reg, RD_TAP_MASK,
+					   RD_TAP(default_taps[channel]));
+
+			dev_warn(rx->dev,
+				 "TRGMII lane %d: %s calibration failed, preserving tap %u\n",
+				 channel, log, default_taps[channel]);
+		}
+
+		/* Return channel to failure pattern */
+		regmap_update_bits(tx->regmap, EN7530_TRGMII_TD_CTRL(channel),
+				   TGMII_TD_PAT_MASK,
+				   FIELD_PREP(TGMII_TD_PAT_MASK,
+					      TGMII_TD_FAIL_PAT));
+	}
+
+	regmap_clear_bits(tx->regmap, MT7530_TRGMII_TXCTRL, TRAIN_TXEN);
+}
+
+static void
+en751221_set_tx_drive(struct mt7530_priv *priv, u8 drvp, u8 drvn, u8 clk_drvp,
+		      u8 clk_drvn)
+{
+	int channel;
+
+	/* Tx driving for TRGMII path on SoC */
+	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++)
+		regmap_write(priv->regmap, MT7530_TRGMII_TD_ODT(channel),
+			     TD_DM_DRVP(drvp) | TD_DM_DRVN(drvn));
+
+	/* Undocumented 6th channel, probably drive strength for clock line. */
+	regmap_write(priv->regmap, MT7530_TRGMII_TD_ODT(5), TD_DM_DRVP(clk_drvp) |
+		     TD_DM_DRVN(clk_drvn));
+}
+
+static void
+en751221_trgmii_pair_setup(struct mt7530_priv *ext, int ext_port,
+			   struct mt7530_priv *ondie, int ondie_port)
+{
+	u8 default_taps_ondie[NUM_TRGMII_CTRL];
+	u8 default_taps_ext[NUM_TRGMII_CTRL];
+	u32 mcr_down, mcr_up;
+	int channel;
+	int reg_val;
+
+	/* BOTH: Put interfaces in a downed state */
+	mcr_down = PMCR_IFG_XMIT(PMCR_IFG_XMIT_64) | PMCR_MAC_MODE |
+		   MT7530_FORCE_MODE | PMCR_MAC_RX_EN | PMCR_BACKOFF_EN |
+		   PMCR_BACKPR_EN | PMCR_FORCE_SPEED_1000 | PMCR_FORCE_FDX;
+	regmap_write(ondie->regmap,  MT753X_PMCR_P(ondie_port), mcr_down);
+	regmap_write(ext->regmap, MT753X_PMCR_P(ext_port), mcr_down);
+	usleep_range(5000, 6000);
+
+	/* BOTH: Reset TX */
+	regmap_set_bits(ext->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
+	regmap_set_bits(ondie->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
+	usleep_range(5000, 6000);
+	regmap_clear_bits(ext->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
+	regmap_clear_bits(ondie->regmap, MT7530_TRGMII_TXCTRL, TX_RST);
+
+	/* BOTH: Reset RX controllers down */
+	regmap_set_bits(ext->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
+	regmap_set_bits(ondie->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
+
+	/* BOTH: Set TX drive strength, MCM uses more */
+	en751221_set_tx_drive(ondie, 8, 8, 7, 7);
+	en751221_set_tx_drive(ext, 11, 11, 15, 15);
+
+	/* BOTH: Reset RX controllers up */
+	regmap_clear_bits(ext->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
+	regmap_clear_bits(ondie->regmap, MT7530_TRGMII_RCK_CTRL, RX_RST);
+
+	/* BOTH: Ports up */
+	mcr_up = mcr_down | PMCR_MAC_TX_EN | PMCR_FORCE_LNK;
+	regmap_write(ondie->regmap, MT753X_PMCR_P(ondie_port), mcr_up);
+	regmap_write(ext->regmap, MT753X_PMCR_P(ext_port), mcr_up);
+
+	/* MCM: Set Ext->SoC TX delay to 0 */
+	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++)
+		regmap_clear_bits(ext->regmap, EN7530_TRGMII_TD_CTRL(channel),
+				  TGMII_TD_TAP_MASK);
+
+	/* SOC: ODT */
+	regmap_set_bits(ondie->regmap, MT7530_TRGMII_RCK_RTT,
+			DQS1_GATE | DQS0_GATE | EN751221_B17);
+
+	/* SOC: Undocumented */
+	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++)
+		regmap_write(ondie->regmap,  (0x7a14 + channel * 8),
+			     0x3227700);
+
+	/* MCM: Spread spectrum clock*/
+	core_clear(ext, CORE_PLL_GROUP8, RG_LCDDS_SSC_EN);
+
+	/* BOTH: Zero clock delay */
+	regmap_clear_bits(ext->regmap, MT7530_TRGMII_RCK_CTRL,
+			  DQSI0_TAP_MASK);
+	regmap_clear_bits(ondie->regmap, MT7530_TRGMII_RCK_CTRL,
+			  DQSI0_TAP_MASK);
+
+	/* BOTH: Collect and then zero every RX TAP */
+	for (channel = 0; channel < NUM_TRGMII_CTRL; channel++) {
+		reg_val = 0;
+		regmap_read(ext->regmap, MT7530_TRGMII_RD(channel), &reg_val);
+		default_taps_ext[channel] = FIELD_GET(RD_TAP_MASK, reg_val);
+		regmap_clear_bits(ext->regmap, MT7530_TRGMII_RD(channel),
+				  RD_TAP_MASK);
+
+		reg_val = 0;
+		regmap_read(ondie->regmap, MT7530_TRGMII_RD(channel), &reg_val);
+		default_taps_ondie[channel] = FIELD_GET(RD_TAP_MASK, reg_val);
+		regmap_clear_bits(ondie->regmap, MT7530_TRGMII_RD(channel),
+				  RD_TAP_MASK);
+	}
+
+	en751221_trgmii_calibrate_direction(ondie, ext, default_taps_ondie);
+	en751221_trgmii_calibrate_direction(ext, ondie, default_taps_ext);
+
+	dev_info(ondie->dev, "TRGMII inter-switch link initialized\n");
+}
+
+static void
+mt7530_cal_interswitch_trgmii(struct dsa_port *dp)
+{
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_switch *peer_ds;
+	struct dsa_port *peer_dp;
+	struct mt7530_priv *peer;
+	struct mt7530_priv *priv;
+	struct dsa_link *dl;
+	u32 pmsr = 0;
+
+	priv = ds->priv;
+
+	if (priv->id != ID_EN751221_EXT)
+		return;
+
+	if (dp->type != DSA_PORT_TYPE_DSA)
+		return;
+
+	regmap_read(priv->regmap, MT7530_PMSR_P(dp->index), &pmsr);
+
+	if (!(pmsr & PMSR_LINK))
+		return;
+
+	list_for_each_entry(dl, &ds->dst->rtable, list) {
+		if (dl->dp != dp)
+			continue;
+
+		peer_dp = dl->link_dp;
+
+		if (peer_dp->type != DSA_PORT_TYPE_DSA)
+			continue;
+
+		peer_ds = dl->link_dp->ds;
+
+		if (!of_device_is_compatible(peer_ds->dev->of_node,
+					     "econet,en751221-switch"))
+			continue;
+
+		peer = peer_ds->priv;
+
+		if (peer->id != ID_EN751221)
+			continue;
+
+		en751221_trgmii_pair_setup(priv, dp->index, peer,
+					   peer_dp->index);
+	}
+}
+
 static void
 mt7530_mib_reset(struct dsa_switch *ds)
 {
@@ -1414,7 +1669,8 @@ mt7530_port_enable(struct dsa_switch *ds, int port,
 
 	mutex_unlock(&priv->reg_mutex);
 
-	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
+	    priv->id != ID_EN751221 && priv->id != ID_EN751221_EXT)
 		return 0;
 
 	if (port == 5)
@@ -1441,7 +1697,8 @@ mt7530_port_disable(struct dsa_switch *ds, int port)
 
 	mutex_unlock(&priv->reg_mutex);
 
-	if (priv->id != ID_MT7530 && priv->id != ID_MT7621)
+	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
+	    priv->id != ID_EN751221 && priv->id != ID_EN751221_EXT)
 		return;
 
 	/* Do not set MT7530_P5_DIS when port 5 is being used for PHY muxing. */
@@ -2603,6 +2860,12 @@ mt7530_setup(struct dsa_switch *ds)
 			   MT7530_CHG_TRAP | MT7530_PHY_INDIRECT_ACCESS,
 			   MT7530_CHG_TRAP);
 
+	/* EN751221 MCM starts on the wrong frequency */
+	if (priv->id == ID_EN751221_EXT)
+		regmap_update_bits(priv->regmap, MT753X_MTRAP,
+				   MT7530_CHG_TRAP | MT7530_CK_SEL,
+				   MT7530_CHG_TRAP);
+
 	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
 		mt7530_pll_setup(priv);
 
@@ -3023,6 +3286,44 @@ static void en7528_mac_port_get_caps(struct dsa_switch *ds, int port,
 	}
 }
 
+static void en751221_mac_port_get_caps(struct dsa_switch *ds, int port,
+				       struct phylink_config *config)
+{
+	switch (port) {
+	/* EN751221 ports 0..3 are connected to the integrated FE PHYs. */
+	case 0 ... 3:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100;
+		break;
+
+	/* Port 4 is connected to the standalone EN7512/EN7521 GPHY. */
+	case 4:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_10 | MAC_100 | MAC_1000FD;
+		break;
+
+	/* Port 5 is the 1 Gbit/s TRGMII cascade to the external MT7530. */
+	case 5:
+		__set_bit(PHY_INTERFACE_MODE_TRGMII,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_1000FD;
+		break;
+
+	/* Port 6 is the 1 Gbit/s CPU link to GDM1. */
+	case 6:
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+
+		config->mac_capabilities |= MAC_1000FD;
+		break;
+	}
+}
+
 static void
 mt7530_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
 		  phy_interface_t interface)
@@ -3172,6 +3473,9 @@ static void mt753x_phylink_mac_link_up(struct phylink_config *config,
 	}
 
 	regmap_set_bits(priv->regmap, MT753X_PMCR_P(dp->index), mcr);
+
+	if (interface == PHY_INTERFACE_MODE_TRGMII)
+		mt7530_cal_interswitch_trgmii(dp);
 }
 
 static void mt753x_phylink_mac_disable_tx_lpi(struct phylink_config *config)
@@ -3428,7 +3732,8 @@ mt753x_conduit_state_change(struct dsa_switch *ds,
 	 * interface is up. NOTE: "CPU port" can also mean an upstream DSA link.
 	 */
 	if (priv->id != ID_MT7530 && priv->id != ID_MT7621 &&
-	    priv->id != ID_EN7528)
+	    priv->id != ID_EN7528 && priv->id != ID_EN751221 &&
+	    priv->id != ID_EN751221_EXT)
 		return;
 
 	mask = BIT(cpu_dp->index);
@@ -3700,6 +4005,28 @@ const struct mt753x_info mt753x_table[] = {
 		.phy_write_c45 = mt7531_ind_c45_phy_write,
 		.mac_port_get_caps = en7528_mac_port_get_caps,
 	},
+	[ID_EN751221] = {
+		.id = ID_EN751221,
+		.pcs_ops = &mt7530_pcs_ops,
+		.sw_setup = mt7988_setup,
+		.phy_read_c22 = mt7531_ind_c22_phy_read,
+		.phy_write_c22 = mt7531_ind_c22_phy_write,
+		.phy_read_c45 = mt7531_ind_c45_phy_read,
+		.phy_write_c45 = mt7531_ind_c45_phy_write,
+		.mac_port_get_caps = en751221_mac_port_get_caps,
+		.mac_port_config = mt7530_mac_config,
+	},
+	[ID_EN751221_EXT] = {
+		.id = ID_EN751221_EXT,
+		.pcs_ops = &mt7530_pcs_ops,
+		.sw_setup = mt7530_setup,
+		.phy_read_c22 = mt7530_phy_read_c22,
+		.phy_write_c22 = mt7530_phy_write_c22,
+		.phy_read_c45 = mt7530_phy_read_c45,
+		.phy_write_c45 = mt7530_phy_write_c45,
+		.mac_port_get_caps = mt7530_mac_port_get_caps,
+		.mac_port_config = mt7530_mac_config,
+	},
 };
 EXPORT_SYMBOL_GPL(mt753x_table);
 
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index c86bc4bca29b..1a4329749c0f 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -24,6 +24,8 @@ enum mt753x_id {
 	ID_EN7581 = 4,
 	ID_AN7583 = 5,
 	ID_EN7528 = 6,
+	ID_EN751221 = 7,
+	ID_EN751221_EXT = 8,
 };
 
 #define	NUM_TRGMII_CTRL			5
@@ -356,6 +358,9 @@ enum mt7530_vlan_port_acc_frm {
 #define MT753X_PMCR_P(x)		(0x3000 + ((x) * 0x100))
 #define  PMCR_IFG_XMIT_MASK		GENMASK(19, 18)
 #define  PMCR_IFG_XMIT(x)		FIELD_PREP(PMCR_IFG_XMIT_MASK, x)
+#define    PMCR_IFG_XMIT_96		0
+#define    PMCR_IFG_XMIT_RAND		1
+#define    PMCR_IFG_XMIT_64		2
 #define  PMCR_EXT_PHY			BIT(17)
 #define  PMCR_MAC_MODE			BIT(16)
 #define  MT7530_FORCE_MODE		BIT(15)
@@ -584,6 +589,7 @@ enum mt7531_clk_skew {
 #define MT753X_MTRAP			0x7804
 #define  MT7530_P5_PHY0_SEL		BIT(20)
 #define  MT7530_CHG_TRAP		BIT(16)
+#define  MT7530_CK_SEL			BIT(15)
 #define  MT7530_LOOP_DET_DISABLE	BIT(14)
 #define  MT7530_P5_MAC_SEL		BIT(13)
 #define  MT7530_P6_DIS			BIT(8)
@@ -601,6 +607,8 @@ enum mt7531_xtal_fsel {
 /* Register for TOP signal control */
 #define MT7530_TOP_SIG_CTRL		0x7808
 #define  TOP_SIG_CTRL_NORMAL		(BIT(17) | BIT(16))
+/* Undocumented */
+#define  TOP_SIG_CTRL_B0		BIT(0)
 
 #define MT7531_TOP_SIG_SR		0x780c
 #define  PAD_DUAL_SGMII_EN		BIT(1)
@@ -647,18 +655,31 @@ enum mt7531_xtal_fsel {
 #define MT7530_TRGMII_RCK_RTT		0x7a04
 #define  DQS1_GATE			BIT(31)
 #define  DQS0_GATE			BIT(30)
+/* Undocumented */
+#define  EN751221_B17			BIT(17)
 
 #define MT7530_TRGMII_RD(x)		(0x7a10 + (x) * 8)
 #define  BSLIP_EN			BIT(31)
 #define  EDGE_CHK			BIT(30)
+#define  RD_VALUE_MASK			GENMASK(23, 16)
+#define  RD_ERR_MASK			GENMASK(11, 8)
 #define  RD_TAP_MASK			GENMASK(6, 0)
 #define  RD_TAP(x)			FIELD_PREP(RD_TAP_MASK, x)
+/* Training does not try anything beyond this */
+#define  TD_TAP_MAX			64
 
 #define MT7530_TRGMII_TXCTRL		0x7a40
 #define  TRAIN_TXEN			BIT(31)
 #define  TXC_INV			BIT(30)
 #define  TX_RST				BIT(28)
 
+#define EN7530_TRGMII_TD_CTRL(x)	(0x7a50 + (x) * 8)
+#define   TGMII_TD_TAP_MASK		GENMASK(11, 8)
+#define   TGMII_TD_PAT_MASK		GENMASK(7, 0)
+/* Use a 01010101 bit pattern */
+#define   TGMII_TD_PAT			0x55
+#define   TGMII_TD_FAIL_PAT		0xaa
+
 #define MT7530_TRGMII_TD_ODT(i)		(0x7a54 + 8 * (i))
 #define  TD_DM_DRVP_MASK		GENMASK(3, 0)
 #define  TD_DM_DRVP(x)			FIELD_PREP(TD_DM_DRVP_MASK, x)
@@ -764,6 +785,9 @@ enum mt7531_xtal_fsel {
 #define  RG_LCCDS_C(x)			FIELD_PREP(RG_LCCDS_C_MASK, x)
 #define  RG_LCDDS_PCW_NCPO_CHG		BIT(3)
 
+#define CORE_PLL_GROUP8			0x407
+#define  RG_LCDDS_SSC_EN		BIT(10)
+
 #define CORE_PLL_GROUP10		0x409
 #define  RG_LCDDS_SSC_DELTA_MASK	GENMASK(11, 0)
 #define  RG_LCDDS_SSC_DELTA(x)		FIELD_PREP(RG_LCDDS_SSC_DELTA_MASK, x)
-- 
2.39.5

