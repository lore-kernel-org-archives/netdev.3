Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299358;
	b=1/wdVBDG9BKR5LzTLpL9463RxLKFQrffLbuDrEcG8P1RDTTY4WktQbFehZy3LEB0st7D
	 FAqlrkpkq9kl7Ex1SD6CVFCvz/Bj2/PjuLIbHXSx/lgVTDWuq+BEg4mTIvXIgrdYQckMH
	 kPQ0tADkcNnMfTCi6MPrPVxLcWXXqWiSl/AxdNeNi7Op3Me6gaNO/Pu7BHqShrI980vVI
	 EO4dQFZxsZpAUgqP4LqcAWGys0Ym0VVM0kVpV5bgt71DE78yfgA/Gu/WvzTcFOhYMt801
	 h9Zeu/JdfiCbpXtZUJFiDe3ZdhYrgXNhfGhSU+TRrmIxfxt7voGdAO1V6psuTkozsFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299358;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=U5unU0X1n9bid1C2890zmY/BApufD/eYc5dn8BANoSU=;
	b=usog7FE9+Qj0et6RKaXLEtyFpnqGsFC+TCdKtBTdkuHJ1ueQzljU3RYeEfxY/UBKCb1E
	 Audl9unsuSLxtwkE52DjWeq8ZI28KkDmm/Efp9bkCr3K+IXmmFMj9ToMdNqWVYqoqoG3d
	 dDJylIpnSwKfLV5qRPQ34JHY7NwmnnZhX1Cc2p0GQ/lpK1VXXJv22UF3jenT3JBHubqIF
	 eJAQRl5Nd0V08armAwYZ2xrquIttms7WnlBeMQ/P64ynV9snkzKkj4CMrLzeoFm8C51Iu
	 Gr3ojdLUg4DsMefO+N5OSoev9knRtbJP1/kT/kiEzFgrznPfRkwe3nZfEVrOVzoWbzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=JZZoRQTl;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82B60A2602;
	Thu, 29 Oct 2026 18:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E82B60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=JZZoRQTl
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 52E171A4F51;
	Thu, 29 Oct 2026 19:42:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793299355; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=U5unU0X1n9bid1C2890zmY/BApufD/eYc5dn8BANoSU=;
	b=JZZoRQTlpz3mt8cUbqU62HUR2jC1wICUnQpryubXgZqTUZK5p0Qwi3u6ZwUN77v/7Minjl
	AwmyeVuJ631qkxpk9RTG1qjW/C/Tc+qItKtqdoYLAYeBrYYGpcu/FSGCs4UEiAlDGX6MKJ
	bviggmfQEHE74MZq+8aHv0X0uLRAD8PubApsDclJyV9hUSnTtIuDxM/QJDltALC8i//93U
	s9CO+qB5uIGXNH0cevmB27fLLd1/y97p/A1KBm+lwfg0mJE86OgkQTnKHlKW8l0gK/RSJP
	OoOx+ED36lBMsQRGieLX2/ks6M6rZMwX+nxkQ0ovXVRGmXwCr06KFBpk/v22LA==
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
Subject: [PATCH v4 5/7] net: dsa: mediatek: support MDIO switch downstream of MMIO switch
Date: Thu, 29 Oct 2026 18:42:00 +0000
Message-Id: <20261029184202.1859843-6-cjd@cjdns.fr>
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

The MT7530 / MT7531 can connect via either MDIO or MMIO. In MMIO mode
the switch provides its own MDIO bus which connects to its integrated
PHYs, but also can be connected to other things, such as another
switch.

If the MDIO bus contains another switch, then the upstream switch
will register but it will not setup the DSA tree because the
downstream switch is missing. Without the complete DSA tree,
mt753x_setup() will not be called on the switch and therefore
mt7530_setup_mdio() is never called so the downstream switch never
registers.

However, the call to mt7530_setup_mdio() from mt753x_setup() must
also be kept because all PHYs are expected to be operational after
mt753x_setup() returns.

Update mt7530_setup_mdio() so that it can be called multiple times,
export the symbol, and call it again after dsa_register_switch()
from mt7988_probe().

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530-mmio.c | 16 +++++++++++++++-
 drivers/net/dsa/mt7530.c      | 17 +++++++++++++----
 drivers/net/dsa/mt7530.h      | 10 ++++++++++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index cf3bdb23a2d5..746a0a462249 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -61,7 +61,21 @@ mt7988_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	return dsa_register_switch(priv->ds);
+	ret = dsa_register_switch(priv->ds);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * If not all switches in the hierarchy have been probed,
+	 * dsa_register_switch() returns 0 without calling mt753x_setup().
+	 * Call mt7530_setup_mdio() because there's a chance that the missing
+	 * switch is on the MDIO bus. Do not call this before
+	 * dsa_register_switch() as it  may exit with an error.
+	 */
+	mt7530_setup_mdio(priv);
+
+	return 0;
 }
 
 static void mt7988_remove(struct platform_device *pdev)
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index d45388e2efc8..24e4485624d3 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2509,7 +2509,7 @@ mt7530_free_mdio_irq(struct mt7530_priv *priv)
 	}
 }
 
-static int
+int
 mt7530_setup_mdio(struct mt7530_priv *priv)
 {
 	struct device_node *mnp, *np = priv->dev->of_node;
@@ -2519,6 +2519,10 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	static int idx;
 	int ret = 0;
 
+	/* Already done */
+	if (priv->child_bus)
+		return 0;
+
 	mnp = of_get_child_by_name(np, "mdio");
 
 	if (mnp && !of_device_is_available(mnp))
@@ -2543,9 +2547,6 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	bus->parent = dev;
 	bus->phy_mask = ~ds->phys_mii_mask;
 
-	if (priv->irq_domain && !mnp)
-		mt7530_setup_mdio_irq(priv);
-
 	priv->child_bus = bus;
 
 	ret = devm_of_mdiobus_register(dev, bus, mnp);
@@ -2560,6 +2561,7 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	of_node_put(mnp);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7530_setup_mdio);
 
 static int
 mt7530_setup(struct dsa_switch *ds)
@@ -3386,10 +3388,17 @@ mt753x_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	/*
+	 * This must be called before mt753x_setup() returns because the DSA
+	 * core synchronously sets up ports and expects PHYs to be operational.
+	 */
 	ret = mt7530_setup_mdio(priv);
 	if (ret)
 		return ret;
 
+	if (priv->irq_domain && ds->user_mii_bus)
+		mt7530_setup_mdio_irq(priv);
+
 	/* Initialise the PCS devices */
 	for (i = 0; i < priv->ds->num_ports; i++) {
 		priv->pcs[i].pcs.ops = priv->info->pcs_ops;
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 5b7394f6383c..c86bc4bca29b 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -969,6 +969,16 @@ struct mt7530_hw_stats {
 int mt7530_probe_common(struct mt7530_priv *priv);
 void mt7530_remove_common(struct mt7530_priv *priv);
 
+/*
+ * When an MMIO based switch has an MDIO bus which contains a downstream MDIO
+ * switch, the MDIO bus is not normally setup until mt753x_setup() has been
+ * called. But mt753x_setup() is not called until DSA sees that every switch in
+ * the tree has been probed. Calling mt7530_setup_mdio() after at the end of
+ * the MMIO probe function allows the downstream switch to register, completing
+ * the tree.
+ */
+int mt7530_setup_mdio(struct mt7530_priv *priv);
+
 extern const struct mt753x_info mt753x_table[];
 
 #endif /* __MT7530_H */
-- 
2.39.5

