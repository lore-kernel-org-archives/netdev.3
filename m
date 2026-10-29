Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299354;
	b=sap7//quK2BgptXex8l/okMNqH3FVNY1TD44g7LsGuSz6YOdhQIYgfD+1tXFQIqGWe3j
	 JN0Galoz5NDZO8GQvNOuMbhrTe5DG4ysw19Sp1LvNJ9h7ABcyKW7Iq9uLUNUckddA1y05
	 X2Ij5HMIMJ1t99uyPW/kjUbFuCB5GsLJtonPQU8rJeHZqtv98oAaS3yETI5LvEZPEs7Ir
	 N7lqUUcfhvxtueOOnfrQL+FUJLvud101YmfZTQbElelDGVfW3S0YRE12BI/GyqL4ox2h2
	 KZHLmcccO+xQtU8xD/SGpoN1rQlTDeRLcVwNAYGTTrzE/raGPtPYLFDFwTloFypkULw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299354;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=AgybJpxOfMLvjOr4vA9iNTA134E7lJeRScneIqIN0/o=;
	b=xMoPnkZMCJfGMKE6sJZwMaO1iZY0hZSOkljhiwPdhft748fVRBwuW6mi1IuCOmheR14A
	 dlcwIUkxr+kxiDU9xX05IHaPMhwmjFJRGMP++7bg1Sg9vrOvfWJkdtkAWUG8gt2rGihPb
	 DEKqdylEuY5xIrHgvpr/9hsNybDaFO+lndmnKrI67dIRqhAZsj9ADQKaadh+xMCWzx/r6
	 0tQ5EZunm/NLzcIa44gDtYUaLfEAZ3wELdN3EG+PechPPGxa8bvcfTQFzRMJEgwiUu6Ir
	 Z7fxsd4lm2VX8O6RGFaAlKkbl9xkyUtwYMXgqtOlrXwVcM/mms1HhnasdlTsb8+dfCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=vxeOA49F;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C103606A31D;
	Thu, 29 Oct 2026 18:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C103606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=vxeOA49F
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 920D11AAD99;
	Thu, 29 Oct 2026 19:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793299351; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AgybJpxOfMLvjOr4vA9iNTA134E7lJeRScneIqIN0/o=;
	b=vxeOA49FKEyaosAYD5FV4VSKTUtRJ0mMQ3/Btmjr8YV4hhe5Cf71IIb9jUzteyCNNgWQ+H
	RdJzpLXmPfipSAyegDx9qS2Ua5ixFSF5xGg4RF9YqNOcuKDkAIMGd75FBVPlAdRra4ixEH
	VCqdI1wpK/wYNXp1hSFscO1x8QLRCzDOw9Un0adUa8CnDnPNK2jE/sXRagQPtYdfGlEgov
	+faznw1Xt0LXvvnNJcMVz9Yinqcnj0DXXkHHwyz5ESrDFstBrysEdZ6zwrkW8hjHKkuPja
	G8tRpRYsLSPHRe9bYknp2YRtyaoilMPO3ZwxWzSBiVJrD/BN7EC3bP2lBJSF1A==
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
Subject: [PATCH v4 4/7] net: dsa: mediatek: support PLL setup on MMIO MT7530
Date: Thu, 29 Oct 2026 18:41:59 +0000
Message-Id: <20261029184202.1859843-5-cjd@cjdns.fr>
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
index c5b3b00acb95..d45388e2efc8 100644
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
@@ -2534,8 +2546,11 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
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

