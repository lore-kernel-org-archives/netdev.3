Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150031;
	b=1CKXkO9hxg/gTebbC2Ock4hYF66/0DWR1QPfP2g4QlC3Q/BxkYkpDRPuu5qcRgD4/V8J
	 VN2gjKLReq+k3FGBopgV8BlMfSwGkUmVLZAfvJko8kL4yRzl21jALcJSiAh/ZYBDdjs34
	 vs/JYG34fTNhTdNJdhxtkGrnDFC8fWTEzWiAtyqQtQQYi8847bIZXiZrjeemmLDXRlKsr
	 Zt5797q+fYhpNiNg+r7VeeHx+hYPQsHAsB2KNPOtvYkDcNFgWuGsTOqV9ADFdQzkY8dLp
	 PUI+oXcmBA0p7QwTI0tLYVIbBLnezZbNo7d+I+U3z44zz3nEF4gK3VyHgFHQHrr6/zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150031;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=qJKVlLd/OcgZk2RoyMDgtiW2rfsi11YQ8snNobdXGYo=;
	b=PWIQJ8Q87Stct3lNUt1O2C6iEc1ZWtJS/R0gUqCMLUP2dsM1ZSJKfNBp69RN078v1ckx
	 FCiqeDcNkt66jwYEdxaipQHcfSzX5UrrC1esu91dITmvVAqxQ3GKZaf8tF5JcdRfIaRLr
	 9DjuuCItdG6hmGaNa8POzUQ6Ez5GwkXvX6LQ9W/UFg0HHnVgKMWdtvHW/BRnTMN5U4Pp7
	 uzJzwtxb0eIhZVnVQiTMP3eew28UayFgbOaFHZgohUooJXcLxDmrTC/c8BvJxi5gDiV0A
	 kuFnIIePlgoMPkMsX/8Al6OP/eAwSHYGznf135+QcmRufhtXk3chy0sR4T3blvJdJ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=sitUNFJm;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDA606A322;
	Wed, 28 Oct 2026 01:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FDDA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=sitUNFJm
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 84269148FAA;
	Wed, 28 Oct 2026 02:13:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793150022; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qJKVlLd/OcgZk2RoyMDgtiW2rfsi11YQ8snNobdXGYo=;
	b=sitUNFJmOlDK6AVGTJuRYgFOj6IDlay8qo63HPvV3G7w5ARCfLYVUPY6Ee3RnGHXnQqGUt
	Gch562XLHHuD+UFdlB07PCVtmyz8/L98uwqmnmhVjDFv+JezKi25TLgyhm0gjIXGxDvigN
	nffo3g4dVHsrGIYpb1W4IaUC7r+qwnpMUVLODjkZIGyZWLSCxoPut6Y+FXD8spKKyC3Qpp
	jJ98CCg0lgFpzB+6jMlS5LpbXUu9wITl5bxN3kNK7k4bdu9q+WOmlVQHtM+HWQ4B3zDWCG
	DOjiL5kzNz+obEfKmEepZ4spYi6h4OUV38WRxSDE0XKtfNcUAQND4GysE8Q0Ig==
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
Subject: [PATCH v3 1/7] net: dsa: mt7530: get ctrl phy addr using a function
Date: Wed, 28 Oct 2026 01:13:11 +0000
Message-Id: <20261028011317.1557238-2-cjd@cjdns.fr>
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

The MDIO MT7530 has 5 integrated PHYs, of these, the first PHY has
the additional registers that are used for such things as configuring
the clock configuration for the switch. The switch is typically on
MDIO address 31 and the PHYs are 0, 1, 2, 3, and 4 with 0 being the
special one. So taking the address of mdiodev (the switch) add 1 and
modulo 31 finds the first PHY.

However there are a number of MMIO based implementations of MT7530
and on these, mdiodev is NULL though they often still have a control
PHY for the purpose. Move MT753X_CTRL_PHY_ADDR to a function which
handles the NULL condition somewhat more gracefully and allows a
place for MMIO implementations to add special case handling to
provide their control PHY address.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530.c | 54 +++++++++++++++++++++-------------------
 drivers/net/dsa/mt7530.h |  2 --
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 7781a63b4e6f..d10194488bde 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -46,6 +46,16 @@ static const struct mt7530_mib_desc mt7530_mib[] = {
 	MIB_DESC(1, MT7530_PORT_MIB_RX_ARL_DROP, "RxArlDrop"),
 };
 
+static int
+mt753x_ctrl_phy_addr(struct mt7530_priv *priv)
+{
+	if (WARN_ON_ONCE(!priv->mdiodev))
+		return 0;
+
+	/* Default is 1st PHY */
+	return (priv->mdiodev->addr + 1) & (PHY_MAX_ADDR - 1);
+}
+
 static void
 mt7530_mutex_lock(struct mt7530_priv *priv)
 {
@@ -63,32 +73,30 @@ mt7530_mutex_unlock(struct mt7530_priv *priv)
 static void
 core_write(struct mt7530_priv *priv, u32 reg, u32 val)
 {
+	int ctl_phy = mt753x_ctrl_phy_addr(priv);
 	struct mii_bus *bus = priv->bus;
 	int ret;
 
 	mt7530_mutex_lock(priv);
 
 	/* Write the desired MMD Devad */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			 MII_MMD_CTRL, MDIO_MMD_VEND2);
+	ret = bus->write(bus, ctl_phy, MII_MMD_CTRL, MDIO_MMD_VEND2);
 	if (ret < 0)
 		goto err;
 
 	/* Write the desired MMD register address */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			 MII_MMD_DATA, reg);
+	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, reg);
 	if (ret < 0)
 		goto err;
 
 	/* Select the Function : DATA with no post increment */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
+	ret = bus->write(bus, ctl_phy,
 			 MII_MMD_CTRL, MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
 	if (ret < 0)
 		goto err;
 
 	/* Write the data into MMD's selected register */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			 MII_MMD_DATA, val);
+	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, val);
 err:
 	if (ret < 0)
 		dev_err(&bus->dev, "failed to write mmd register\n");
@@ -99,6 +107,7 @@ core_write(struct mt7530_priv *priv, u32 reg, u32 val)
 static void
 core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
 {
+	int ctl_phy = mt753x_ctrl_phy_addr(priv);
 	struct mii_bus *bus = priv->bus;
 	u32 val;
 	int ret;
@@ -106,26 +115,23 @@ core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
 	mt7530_mutex_lock(priv);
 
 	/* Write the desired MMD Devad */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			 MII_MMD_CTRL, MDIO_MMD_VEND2);
+	ret = bus->write(bus, ctl_phy, MII_MMD_CTRL, MDIO_MMD_VEND2);
 	if (ret < 0)
 		goto err;
 
 	/* Write the desired MMD register address */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			 MII_MMD_DATA, reg);
+	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, reg);
 	if (ret < 0)
 		goto err;
 
 	/* Select the Function : DATA with no post increment */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
+	ret = bus->write(bus, ctl_phy,
 			 MII_MMD_CTRL, MDIO_MMD_VEND2 | MII_MMD_CTRL_NOINCR);
 	if (ret < 0)
 		goto err;
 
 	/* Read the content of the MMD's selected register */
-	ret = bus->read(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			MII_MMD_DATA);
+	ret = bus->read(bus, ctl_phy, MII_MMD_DATA);
 	if (ret < 0)
 		goto err;
 	val = ret;
@@ -133,8 +139,7 @@ core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
 	val &= ~mask;
 	val |= set;
 	/* Write the data into MMD's selected register */
-	ret = bus->write(bus, MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-			 MII_MMD_DATA, val);
+	ret = bus->write(bus, ctl_phy, MII_MMD_DATA, val);
 err:
 	if (ret < 0)
 		dev_err(&bus->dev, "failed to write mmd register\n");
@@ -2668,8 +2673,11 @@ mt7531_setup(struct dsa_switch *ds)
 {
 	struct mt7530_priv *priv = ds->priv;
 	u32 val, id;
+	int ctl_phy;
 	int ret, i;
 
+	ctl_phy = mt753x_ctrl_phy_addr(priv);
+
 	/* Reset whole chip through gpio pin or memory-mapped registers for
 	 * different type of hardware
 	 */
@@ -2737,25 +2745,21 @@ mt7531_setup(struct dsa_switch *ds)
 	 * phy_[read,write]_mmd_indirect is called, we provide our own
 	 * mt7531_ind_mmd_phy_[read,write] to complete this function.
 	 */
-	ret = mt7531_ind_c45_phy_read(priv,
-				      MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-				      MDIO_MMD_VEND2, CORE_PLL_GROUP4);
+	ret = mt7531_ind_c45_phy_read(priv, ctl_phy, MDIO_MMD_VEND2,
+				      CORE_PLL_GROUP4);
 	if (ret < 0)
 		return ret;
 
 	val = ret;
 	val |= MT7531_RG_SYSPLL_DMY2 | MT7531_PHY_PLL_BYPASS_MODE;
 	val &= ~MT7531_PHY_PLL_OFF;
-	ret = mt7531_ind_c45_phy_write(priv,
-				       MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr),
-				       MDIO_MMD_VEND2, CORE_PLL_GROUP4, val);
+	ret = mt7531_ind_c45_phy_write(priv, ctl_phy, MDIO_MMD_VEND2,
+				       CORE_PLL_GROUP4, val);
 	if (ret < 0)
 		return ret;
 
 	/* Disable EEE advertisement on the switch PHYs. */
-	for (i = MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr);
-	     i < MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr) + MT7530_NUM_PHYS;
-	     i++) {
+	for (i = ctl_phy; i < ctl_phy + MT7530_NUM_PHYS; i++) {
 		mt7531_ind_c45_phy_write(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV,
 					 0);
 	}
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 2bbbe617b52e..3dabbc99fbbc 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -747,8 +747,6 @@ enum mt7531_xtal_fsel {
 #define  MT7531_PHY_PLL_OFF		BIT(5)
 #define  MT7531_PHY_PLL_BYPASS_MODE	BIT(4)
 
-#define MT753X_CTRL_PHY_ADDR(addr)	(((addr) + 1) & (PHY_MAX_ADDR - 1))
-
 #define CORE_PLL_GROUP5			0x404
 #define  RG_LCDDS_PCW_NCPO1_MASK	GENMASK(15, 0)
 #define  RG_LCDDS_PCW_NCPO1(x)		FIELD_PREP(RG_LCDDS_PCW_NCPO1_MASK, x)
-- 
2.39.5

