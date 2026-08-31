Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51EB549374;
	Mon, 31 Aug 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191113; cv=none; b=k5Z5P1HulN4UDuU4R+17pkxwEce59uXwCuSyamCZ5OQV88VFYcdKtSw1mC/vuZwdiZn2hkJxbZEqyF+MWswwox+u6+XeEvUgFJ6o3Yg4CYbS//+1kfnaunu7Y0jmVRgJ53zO21Q3NDjLpq8V8ISXr4FNJaJHGWGCiC3B8sZN7zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191113; c=relaxed/simple;
	bh=rDZZcqZL5E67ZBakP1saii5Q94Xyu91HaPA390TmtOM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRaD+avHzH7ZaONf696Iep31WroXQDa5CIRyJeujk9rtuMhTxE3bipoOvu463mR2MKtRv5aD1P7XcCP0lVf8FE6hEb+CCiWrNj/83O07mNzE3beXVMSK6BOjOZJguBTq/awmoYmZVz7U7qE5LkEUASoAx1et0q+pMyxDUiiULrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1x1458-0000000078x-0tea;
	Mon, 31 Aug 2026 15:37:58 +0000
Date: Mon, 31 Aug 2026 16:37:55 +0100
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
Subject: [PATCH net-next v5 1/9] net: dsa: mt7530: move MDIO bus locking into
 regmap
Message-ID: <6927a774b87238800de5d6c0c717b0afd02d320b.1788190568.git.daniel@makrotopia.org>
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

The switch register regmap was created with .disable_locking = true,
relying on callers to manually lock the MDIO bus. Move the locking
into the regmap using .lock/.unlock callbacks, matching the PCS
regmaps that already do this. This allows any code path reaching the
regmap to be automatically protected.

With regmap handling bus locking, the manual mt7530_mutex_lock/unlock
calls in mt7530_write(), _mt7530_read(), mt7530_rmw() and
mt7530_port_change_mtu() become redundant and are removed, as is the
bus lock held across the ATC/VTCR command poll sequences.

The handle_mask_sync callback added by commit dd52b3df25ed ("net: dsa:
mt7530: serialize the regmap IRQ chip like every other user") to hold
mt7530_mutex_lock() around the regmap-irq mask register write is
likewise removed. With the regmap now self-locking, regmap-irq's
default unmask_base sync is serialized on its own, and so are the
status read, ack write and init_ack_masked write that had no hook,
closing the gaps that commit left open. The per-device copy of the irq
chip it needed goes away too.

The MT7531 indirect PHY access functions need serialization of their
multi-step register sequences, but no longer need to hold bus->mdio_lock
across the whole operation. Switch them to reg_mutex.

core_write()/core_rmw() are the only remaining callers of
mt7530_mutex_lock(). They access TRGMII core PHY registers via the
clause 22 MMD indirect protocol -- a separate register space that
bypasses regmap and needs manual bus->mdio_lock protection.

The lock removals are generated using the following semantic patch:

// Collapse mt7530_write() now that regmap serialises bus access.
@@
expression priv, reg, val;
identifier ret;
@@
 {
-	int ret;
-
-	mt7530_mutex_lock(priv);
-
-	ret = mt7530_mii_write(priv, reg, val);
-
-	mt7530_mutex_unlock(priv);
-
-	return ret;
+	return mt7530_mii_write(priv, reg, val);
 }

// Remove mt7530_mutex_lock/unlock around single regmap-based calls.
@@
expression priv, reg, mask, set;
@@
 {
-	mt7530_mutex_lock(priv);
-
 	regmap_update_bits(priv->regmap, reg, mask, set);
-
-	mt7530_mutex_unlock(priv);
 }

@@
expression p;
identifier val;
@@
 {
-	u32 val;
-	mt7530_mutex_lock(p->priv);
-	val = mt7530_mii_read(p->priv, p->reg);
-	mt7530_mutex_unlock(p->priv);
-	return val;
+	return mt7530_mii_read(p->priv, p->reg);
 }

@@
expression priv;
identifier val;
@@
-	mt7530_mutex_lock(priv);
 	val = mt7530_mii_read(priv, MT7530_GMACCR);
 	...
 	mt7530_mii_write(priv, MT7530_GMACCR, val);
-	mt7530_mutex_unlock(priv);

// The ATC/VTCR command polls no longer need the bus lock held across
// the poll and the status read-back.
@@
expression priv, reg, cond;
identifier ret, val;
@@
-	mt7530_mutex_lock(priv);
-
 	ret = regmap_read_poll_timeout(priv->regmap, reg, val, cond, 20, 20000);
 	if (!ret)
 		ret = regmap_read(priv->regmap, reg, &val);
-
-	mt7530_mutex_unlock(priv);

// The MT7531 indirect PHY sequences keep serialising themselves, but
// against reg_mutex rather than the MDIO bus lock.
@@
expression priv;
identifier ret, val;
@@
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val, ...);

@@
expression priv;
@@
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v5: reworked on top of net-next's accessor error handling: mt7530_write()
    now returns int, so removing its lock collapses it to a direct
    return, the bus lock around the ATC/VTCR command polls goes too, and
    _mt7530_unlocked_read() is already gone. Also revert the
    handle_mask_sync workaround of commit dd52b3df25ed, which regmap's
    own locking makes redundant and which would otherwise recurse on
    bus->mdio_lock.
v4: no changes
v3: no changes
v2: no changes
---
 drivers/net/dsa/mt7530-mdio.c |  9 ++--
 drivers/net/dsa/mt7530.c      | 78 +++++------------------------------
 2 files changed, 17 insertions(+), 70 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mdio.c b/drivers/net/dsa/mt7530-mdio.c
index 784dd58a7158..422f785d2143 100644
--- a/drivers/net/dsa/mt7530-mdio.c
+++ b/drivers/net/dsa/mt7530-mdio.c
@@ -148,12 +148,14 @@ static const struct regmap_config regmap_config = {
 	.val_bits = 32,
 	.reg_stride = 4,
 	.max_register = MT7530_CREV,
-	.disable_locking = true,
+	.lock = mt7530_mdio_regmap_lock,
+	.unlock = mt7530_mdio_regmap_unlock,
 };
 
 static int
 mt7530_probe(struct mdio_device *mdiodev)
 {
+	struct regmap_config rc = regmap_config;
 	struct mt7530_priv *priv;
 	struct device_node *dn;
 	int ret;
@@ -207,8 +209,9 @@ mt7530_probe(struct mdio_device *mdiodev)
 			return PTR_ERR(priv->io_pwr);
 	}
 
-	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus, priv,
-					&regmap_config);
+	rc.lock_arg = &priv->bus->mdio_lock;
+	priv->regmap = devm_regmap_init(priv->dev, &mt7530_regmap_bus,
+					priv, &rc);
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2b7be091c056..dbf70e5dd55f 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -188,29 +188,13 @@ mt7530_mii_read(struct mt7530_priv *priv, u32 reg)
 static int
 mt7530_write(struct mt7530_priv *priv, u32 reg, u32 val)
 {
-	int ret;
-
-	mt7530_mutex_lock(priv);
-
-	ret = mt7530_mii_write(priv, reg, val);
-
-	mt7530_mutex_unlock(priv);
-
-	return ret;
+	return mt7530_mii_write(priv, reg, val);
 }
 
 static u32
 _mt7530_read(struct mt7530_dummy_poll *p)
 {
-	u32 val;
-
-	mt7530_mutex_lock(p->priv);
-
-	val = mt7530_mii_read(p->priv, p->reg);
-
-	mt7530_mutex_unlock(p->priv);
-
-	return val;
+	return mt7530_mii_read(p->priv, p->reg);
 }
 
 static u32
@@ -226,11 +210,7 @@ static void
 mt7530_rmw(struct mt7530_priv *priv, u32 reg,
 	   u32 mask, u32 set)
 {
-	mt7530_mutex_lock(priv);
-
 	regmap_update_bits(priv->regmap, reg, mask, set);
-
-	mt7530_mutex_unlock(priv);
 }
 
 static void
@@ -257,15 +237,11 @@ mt7530_fdb_cmd(struct mt7530_priv *priv, enum mt7530_fdb_cmd cmd, u32 *rsp)
 	if (ret)
 		return ret;
 
-	mt7530_mutex_lock(priv);
-
 	ret = regmap_read_poll_timeout(priv->regmap, MT7530_ATC, val,
 				       !(val & ATC_BUSY), 20, 20000);
 	if (!ret)
 		ret = regmap_read(priv->regmap, MT7530_ATC, &val);
 
-	mt7530_mutex_unlock(priv);
-
 	if (ret < 0) {
 		dev_err(priv->dev, "reset timeout\n");
 		return ret;
@@ -560,7 +536,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 	u32 reg, val;
 	int ret;
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -597,7 +573,7 @@ mt7531_ind_c45_phy_read(struct mt7530_priv *priv, int port, int devad,
 
 	ret = val & MT7531_MDIO_RW_DATA_MASK;
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -609,7 +585,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 	u32 val, reg;
 	int ret;
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -645,7 +621,7 @@ mt7531_ind_c45_phy_write(struct mt7530_priv *priv, int port, int devad,
 	}
 
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -656,7 +632,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 	int ret;
 	u32 val;
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, val,
 				       !(val & MT7531_PHY_ACS_ST), 20, 100000);
@@ -681,7 +657,7 @@ mt7531_ind_c22_phy_read(struct mt7530_priv *priv, int port, int regnum)
 
 	ret = val & MT7531_MDIO_RW_DATA_MASK;
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -693,7 +669,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	int ret;
 	u32 reg;
 
-	mt7530_mutex_lock(priv);
+	mutex_lock(&priv->reg_mutex);
 
 	ret = regmap_read_poll_timeout(priv->regmap, MT7531_PHY_IAC, reg,
 				       !(reg & MT7531_PHY_ACS_ST), 20, 100000);
@@ -717,7 +693,7 @@ mt7531_ind_c22_phy_write(struct mt7530_priv *priv, int port, int regnum,
 	}
 
 out:
-	mt7530_mutex_unlock(priv);
+	mutex_unlock(&priv->reg_mutex);
 
 	return ret;
 }
@@ -1452,8 +1428,6 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 	if (!dsa_is_cpu_port(ds, port))
 		return 0;
 
-	mt7530_mutex_lock(priv);
-
 	val = mt7530_mii_read(priv, MT7530_GMACCR);
 	val &= ~MAX_RX_PKT_LEN_MASK;
 
@@ -1473,8 +1447,6 @@ mt7530_port_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
 
 	mt7530_mii_write(priv, MT7530_GMACCR, val);
 
-	mt7530_mutex_unlock(priv);
-
 	return 0;
 }
 
@@ -1642,15 +1614,11 @@ mt7530_vlan_cmd(struct mt7530_priv *priv, enum mt7530_vlan_cmd cmd, u16 vid)
 	if (ret)
 		return ret;
 
-	mt7530_mutex_lock(priv);
-
 	ret = regmap_read_poll_timeout(priv->regmap, MT7530_VTCR, val,
 				       !(val & VTCR_BUSY), 20, 20000);
 	if (!ret)
 		ret = regmap_read(priv->regmap, MT7530_VTCR, &val);
 
-	mt7530_mutex_unlock(priv);
-
 	if (ret < 0) {
 		dev_err(priv->dev, "poll timeout\n");
 		return ret;
@@ -2319,21 +2287,6 @@ static const struct regmap_irq mt7530_irqs[] = {
 	REGMAP_IRQ_REG_LINE(31, 32), /* ACL */
 };
 
-/* Serialize regmap-irq's mask sync like every other regmap user */
-static int mt7530_irq_mask_sync(int index, unsigned int mask_buf_def,
-				unsigned int mask_buf, void *irq_drv_data)
-{
-	struct mt7530_priv *priv = irq_drv_data;
-	int ret;
-
-	mt7530_mutex_lock(priv);
-	ret = regmap_update_bits(priv->regmap, MT7530_SYS_INT_EN,
-				 mask_buf_def, ~mask_buf);
-	mt7530_mutex_unlock(priv);
-
-	return ret;
-}
-
 static const struct regmap_irq_chip mt7530_regmap_irq_chip = {
 	.name = KBUILD_MODNAME,
 	.status_base = MT7530_SYS_INT_STS,
@@ -2343,14 +2296,12 @@ static const struct regmap_irq_chip mt7530_regmap_irq_chip = {
 	.irqs = mt7530_irqs,
 	.num_irqs = ARRAY_SIZE(mt7530_irqs),
 	.num_regs = 1,
-	.handle_mask_sync = mt7530_irq_mask_sync,
 };
 
 static int
 mt7530_setup_irq(struct mt7530_priv *priv)
 {
 	struct regmap_irq_chip_data *irq_data;
-	struct regmap_irq_chip *chip;
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
 	int irq, ret;
@@ -2370,17 +2321,10 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
 
-	chip = devm_kmemdup(dev, &mt7530_regmap_irq_chip, sizeof(*chip),
-			    GFP_KERNEL);
-	if (!chip)
-		return -ENOMEM;
-
-	chip->irq_drv_data = priv;
-
 	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
 					      priv->regmap, irq,
 					      IRQF_ONESHOT,
-					      0, chip,
+					      0, &mt7530_regmap_irq_chip,
 					      &irq_data);
 	if (ret)
 		return ret;
-- 
2.55.0
