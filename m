Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF943BDCB;
	Tue, 15 Sep 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494445; cv=none; b=gPCW5pvyg7EETLvmOW8ahrvJHggOxoDReb0ab2y37+NByx5v8FcVcCN/IgtBHw/xbxSM0MYa4QR6eGjORxhzgSds7UWFeRvFSe0nG4ORciRoJhKllqe2KChRhJPn9QD3Tb2YiSd2IpnvTTIiDBZvXgCSdp26KHxr5ONa2dZvuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494445; c=relaxed/simple;
	bh=3xg1Gx4jh/PkxxndNHqZa3eS1s+bCmUMu9ni0hwYEXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B4B/FIbmw1zMbh3XYlKPmeS98SoGaMC00hEUami3Ec6thbPmG7lHCJW9cm1pqKiorkOfE6jfIori2uc1IIWjaOxsdRgyioAuyInkmRLAZRmFVexVpywct2q90kMJ4eoXyhttZogZeujOalkxsK62hecTwUehJPLNlWoox4EVCx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=none smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=T7BpDmpw; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="T7BpDmpw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 06C5448F929;
	Tue, 15 Sep 2026 19:47:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1789494440; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qvPGDHjj/h5quxN39A7MZhJ00DBT2v1OT7d6avspqus=;
	b=T7BpDmpwLEP+Bkyld9jY/iUx5Ty4pF5OEIRoEAtgr6xYR1Yxfj7k1bmweQSxHb54TwTr2C
	VERsSNv7fqQfm4MKmkUC2/A275/GLVbCG5kQ4qWzOKqueRCxX86x2SsrkfzgH04IEJoeZA
	NTyHGVQz39Msmj70NOgZqxutto/enidYXVn3lAa9aZgZZNyeXv6sRTjttU5voOTWpZvEdt
	xasLhx65zmx88u1spcrKsEaVcKCx6ZPqBxO9jFwoJtSg9L5mS4Tslxw29JIMmRra4TWi89
	rl+CIKpDSRWKEiGiLJGl1b4BEl4Csuz0IKjBNaFHM7p7AY28y2sFPb6M+176rw==
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
Subject: [PATCH v2 net-next 4/7] net: dsa: mediatek: support PLL setup on MMIO MT7530
Date: Tue, 15 Sep 2026 17:46:40 +0000
Message-Id: <20260915174643.253660-5-cjd@cjdns.fr>
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

On MT7530 and MT7531, PHYs are an integral part of the switch. However,
on MT7530, certain configuration such as PLL setup is done via special
registers on one of the PHYs.

In an MMIO implementation, the MDIO bus is part of the switch itself.
This bus is already setup for PHY calibration so begin using it for
core switch PLL setup.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530.c | 15 +++++++++++++++
 drivers/net/dsa/mt7530.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index b2344808457c..b152b73315d5 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -77,6 +77,12 @@ core_write(struct mt7530_priv *priv, u32 reg, u32 val)
 	struct mii_bus *bus = priv->bus;
 	int ret;
 
+	if (!bus)
+		bus = priv->child_bus;
+
+	if (WARN_ON_ONCE(!bus))
+		return;
+
 	mt7530_mutex_lock(priv);
 
 	/* Write the desired MMD Devad */
@@ -112,6 +118,12 @@ core_rmw(struct mt7530_priv *priv, u32 reg, u32 mask, u32 set)
 	u32 val;
 	int ret;
 
+	if (!bus)
+		bus = priv->child_bus;
+
+	if (WARN_ON_ONCE(!bus))
+		return;
+
 	mt7530_mutex_lock(priv);
 
 	/* Write the desired MMD Devad */
@@ -2429,8 +2441,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	if (priv->irq_domain && !mnp)
 		mt7530_setup_mdio_irq(priv);
 
+	priv->child_bus = bus;
+
 	ret = devm_of_mdiobus_register(dev, bus, mnp);
 	if (ret) {
+		priv->child_bus = NULL;
 		dev_err(dev, "failed to register MDIO bus: %d\n", ret);
 		if (priv->irq_domain && !mnp)
 			mt7530_free_mdio_irq(priv);
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 108c831dd012..5b7394f6383c 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -886,6 +886,9 @@ struct mt753x_info {
  * @dev:		The device pointer
  * @ds:			The pointer to the dsa core structure
  * @bus:		The bus used for the device and built-in PHY
+ * @child_bus:		The bus created by the device, on MDIO implementations
+ *			this is bus indirectly accesses `bus`, on MMIO
+ *			implementations this bus is part of the switch.
  * @regmap:		The regmap instance representing all switch registers
  * @rstc:		The pointer to reset control used by MCM
  * @core_pwr:		The power supplied into the core
@@ -914,6 +917,7 @@ struct mt7530_priv {
 	struct device		*dev;
 	struct dsa_switch	*ds;
 	struct mii_bus		*bus;
+	struct mii_bus		*child_bus;
 	struct regmap		*regmap;
 	struct reset_control	*rstc;
 	struct regulator	*core_pwr;
-- 
2.39.5

