Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1628C5B1;
	Thu, 30 Jul 2026 00:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785370516; cv=none; b=FHNexgESGGQh3LurftxkVtuBHNkQmgOhBTVJoXByYVINriTB6w7u6Icv+YGYa4jA/5pSeatxorYBa27PzbpdSE3mb7KU13Lrchc2JLI04XPy2lPo0LOrl+MRUkl+DjNYiqR1UwOuGznacLIW18vL3olzhzLnOKfy5rFg8GhxIIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785370516; c=relaxed/simple;
	bh=meF5CJHFc2gqkZs9+4TkcEH8rUX4WpdmvBo/oyEKuqw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONDxsJnUFWoBs1JwxGBg04ZM342LV8HjkWzm8Tmr6EsczafDVn318nRupbMpLO7GRx/HRuPDdMRabDXTlzU+p4boLAxx28RLoaRD0bSYVReumPnU+3NupdyaMF27P4qV+N62DzgOM+o35ZT7qOhlb+qesYAw2y/Hqvd2RtFJkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpEQX-000000002gm-14zt;
	Thu, 30 Jul 2026 00:15:09 +0000
Date: Thu, 30 Jul 2026 01:15:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Landen Chao <Landen.Chao@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 5/5] net: dsa: mt7530: serialize the regmap IRQ chip
 like every other user
Message-ID: <b28df01d04c0e50c3d44ca2f29b12260bc32072d.1785368701.git.daniel@makrotopia.org>
References: <cover.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785368701.git.daniel@makrotopia.org>

The switch register regmap is created with .disable_locking = true;
every other user in this driver calls mt7530_mutex_lock()/unlock()
around it, which takes priv->bus->mdio_lock, since the underlying
mt7530_regmap_read()/write() issue raw, unserialized bus->read()/
write() MDIO transactions.

mt7530_setup_irq() hands this same unlocked regmap straight to
devm_regmap_add_irq_chip_fwnode(), whose threaded IRQ handler then
calls regmap_read()/regmap_update_bits() on it without ever calling
mt7530_mutex_lock(). An interrupt firing while another thread is
mid-transaction on the same regmap (e.g. a paged register access, or
an indirect PHY access) can interleave with the IRQ handler's own
paged access and corrupt page selection on either side.

Use struct regmap_irq_chip's handle_mask_sync hook to call
mt7530_mutex_lock()/unlock() around the mask register write regmap-irq
issues whenever a consumer of one of the mapped sub-IRQs enables,
disables, requests or frees its line. This needs a per-device copy of
mt7530_regmap_irq_chip, since devm_regmap_add_irq_chip_fwnode() keeps
a pointer to it rather than copying it.

handle_pre_irq/handle_post_irq, which would additionally cover the
status read and ack write the threaded handler does directly, bracket
the whole handler including its handle_nested_irq() calls. Lockdep
caught this on hardware: those calls reach phy_interrupt() for the
per-port PHY IRQ lines mapped through this chip, which takes
phydev->lock, while phy_attach_direct() and this driver's own indirect
PHY access already establish the opposite order (phydev->lock, then
priv->bus->mdio_lock) elsewhere. Using them here would close that
cycle, so they are not used.

regmap_irq_sync_unlock() also has its own init_ack_masked path, used
by this chip, which unconditionally does its own regmap_write() to ack
currently-masked IRQs; that path has no per-driver hook. Together with
the threaded handler's own status read and ack write, these stay
unprotected -- a narrower, harder-to-hit gap than the recurring mask
sync above -- and will be closed once the switch regmap moves to
regmap's own locking in the driver-wide register access cleanup.

Fixes: 254f6b272e3b ("dsa: mt7530: Utilize REGMAP_IRQ for interrupt handling")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: new patch

 drivers/net/dsa/mt7530.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 29b8b28e8d2c..575eb90ce3f0 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2303,6 +2303,21 @@ static const struct regmap_irq mt7530_irqs[] = {
 	REGMAP_IRQ_REG_LINE(31, 32), /* ACL */
 };
 
+/* Serialize regmap-irq's mask sync like every other regmap user */
+static int mt7530_irq_mask_sync(int index, unsigned int mask_buf_def,
+				unsigned int mask_buf, void *irq_drv_data)
+{
+	struct mt7530_priv *priv = irq_drv_data;
+	int ret;
+
+	mt7530_mutex_lock(priv);
+	ret = regmap_update_bits(priv->regmap, MT7530_SYS_INT_EN,
+				 mask_buf_def, ~mask_buf);
+	mt7530_mutex_unlock(priv);
+
+	return ret;
+}
+
 static const struct regmap_irq_chip mt7530_regmap_irq_chip = {
 	.name = KBUILD_MODNAME,
 	.status_base = MT7530_SYS_INT_STS,
@@ -2312,12 +2327,14 @@ static const struct regmap_irq_chip mt7530_regmap_irq_chip = {
 	.irqs = mt7530_irqs,
 	.num_irqs = ARRAY_SIZE(mt7530_irqs),
 	.num_regs = 1,
+	.handle_mask_sync = mt7530_irq_mask_sync,
 };
 
 static int
 mt7530_setup_irq(struct mt7530_priv *priv)
 {
 	struct regmap_irq_chip_data *irq_data;
+	struct regmap_irq_chip *chip;
 	struct device *dev = priv->dev;
 	struct device_node *np = dev->of_node;
 	int irq, ret;
@@ -2337,10 +2354,17 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
 
+	chip = devm_kmemdup(dev, &mt7530_regmap_irq_chip, sizeof(*chip),
+			    GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->irq_drv_data = priv;
+
 	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
 					      priv->regmap, irq,
 					      IRQF_ONESHOT,
-					      0, &mt7530_regmap_irq_chip,
+					      0, chip,
 					      &irq_data);
 	if (ret)
 		return ret;
-- 
2.55.0
