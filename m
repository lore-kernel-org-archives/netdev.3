Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78913321B1;
	Thu, 30 Jul 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427438; cv=none; b=DSOoYQRDB6asbqhQ8lJ621YYdObuxXQoncD/lt0Ne9OyZ1OHgddBou4c4EsaRcOaKHpxyr/OThUDq8Iso4b5CUZq1PhDFYlrnJcn3Ql696qMFoRtNdV6TXfj2EXzNviD7t3g5AlZb6n1EspUZdUgXvkKpi/dfHG8+PMZlM9MY4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427438; c=relaxed/simple;
	bh=/fH8mwZwO8b5PgJuyPDTbfaUUOZ/gqo8Q8aDnUssbfc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnJ6m4OKGAey7Ky5oIcD8eDZqyQEdxI3ZHFjQdokZuZkjYHZwq2ThwxQMA+svpRFK6dbUmPzavVSFQba9Pwan25PXhxrTXF8Z6a82zW4A3NmM7iRSbQD7euo+CVchdiaMDzlUzHwzaBB23pis2VUPw8CeeZVFs9U+OP9hz3T0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wpTEc-000000007YI-3FOH;
	Thu, 30 Jul 2026 16:03:50 +0000
Date: Thu, 30 Jul 2026 17:03:47 +0100
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
	Landen Chao <Landen.Chao@mediatek.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net 4/4] net: dsa: mt7530: serialize the regmap IRQ chip like
 every other user
Message-ID: <f2a52e4ada145fe6aa3fcbe5f923b125364b1a87.1785427248.git.daniel@makrotopia.org>
References: <cover.1785427248.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1785427248.git.daniel@makrotopia.org>

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
 drivers/net/dsa/mt7530.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 2a17696e6a45..f8f0799ede63 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2311,6 +2311,21 @@ static const struct regmap_irq mt7530_irqs[] = {
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
@@ -2320,12 +2335,14 @@ static const struct regmap_irq_chip mt7530_regmap_irq_chip = {
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
@@ -2345,10 +2362,17 @@ mt7530_setup_irq(struct mt7530_priv *priv)
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
