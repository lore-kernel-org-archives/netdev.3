Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C62857268D;
	Wed,  9 Sep 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.135.140.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962667; cv=none; b=k8mmf85V0haHV0UT8cjmp6DhkbIYL23d8DpJkrgd5z9N3J1fu/C8sDlOX7u/wYouS88GOT8lz5K1/ZGFkDVrOmFayTNuDnqVx5c07h1N9/nM46t8iMdfAT+2ojw2Rbhvf2xdSGWoUPLk+BBF5Mddbc4KYE+4YsQFdZd6uyc5AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962667; c=relaxed/simple;
	bh=xf1l35mobZ8DrnpJFcgs8wOzQ3IA5/7pdWloLECVICA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iYJ5lbdI7ne7C1lqSndIw/AADG13JAbGfckM9ZLix0xArhU2gwjoTexz88uTUUygHO/TlXiDLnfGWkITFPl+X3lkfyjq7XTLOHkuLnl9g2p+UaqL1v7CQ12ljsjASw7wuCY7A7jSr3DuH+yKJ30R6jHzlBq+7ghSVDwiTdPGi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr; spf=pass smtp.mailfrom=cjdns.fr; dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b=mEngIkic; arc=none smtp.client-ip=5.135.140.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cjdns.fr header.i=@cjdns.fr header.b="mEngIkic"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C07953F5BB3;
	Wed,  9 Sep 2026 16:04:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1788962662; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Otkn7qrD0QQsF9M2J+eNQoCf9Wvi4mx3LaCwu7r60wI=;
	b=mEngIkic16H62AjxFy6YMg7Re2h5vGQWsoEzDYVvXAhAlrtdA+hR3Wxr3jhuwMoGl/MSAz
	8zuzFGJLzc5rfBAq3L1eAyYqDiO8DQVPx4pff7TRGdNojeJo5jXtW3Ff6zNCHUcR44wsEp
	I3lQ9gViH/Dbi1IRig/lW6XeywOD5qjenYxG8Ql56a9HG5RXsReELYrclbrmoG+skL7AXx
	s0L1FOTPykuCmUzmbpHtxv7GNHbiTelSNS9Pg9JqkuRz6g61iKh08I2/NKLkCZc1z1p/VZ
	s2WbpSgl9Gw1VBMTs1ClTzP7ZG32cEt0WGJW7EhOwi4vl5PPcaib7wY2y2FQLA==
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
Subject: [PATCH net-next 5/7] net: dsa: mediatek: support MDIO switch downstream of MMIO switch
Date: Wed,  9 Sep 2026 14:03:44 +0000
Message-Id: <20260909140346.2861572-6-cjd@cjdns.fr>
In-Reply-To: <20260909140346.2861572-1-cjd@cjdns.fr>
References: <20260909140346.2861572-1-cjd@cjdns.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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

Update mt7530_setup_mdio() so that it can be called multiple times,
export the symbol, and call it again after dsa_register_switch()
from mt7988_probe().

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 drivers/net/dsa/mt7530-mmio.c |  7 ++++++-
 drivers/net/dsa/mt7530.c      |  7 ++++++-
 drivers/net/dsa/mt7530.h      | 10 ++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mt7530-mmio.c b/drivers/net/dsa/mt7530-mmio.c
index cf3bdb23a2d5..29fbd0fc50d1 100644
--- a/drivers/net/dsa/mt7530-mmio.c
+++ b/drivers/net/dsa/mt7530-mmio.c
@@ -61,7 +61,12 @@ mt7988_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap))
 		return PTR_ERR(priv->regmap);
 
-	return dsa_register_switch(priv->ds);
+	ret = dsa_register_switch(priv->ds);
+
+	if (ret)
+		return ret;
+
+	return mt7530_setup_mdio(priv);
 }
 
 static void mt7988_remove(struct platform_device *pdev)
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index a165b4c8ed8d..0c0c5358b8b8 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2404,7 +2404,7 @@ mt7530_free_mdio_irq(struct mt7530_priv *priv)
 	}
 }
 
-static int
+int
 mt7530_setup_mdio(struct mt7530_priv *priv)
 {
 	struct device_node *mnp, *np = priv->dev->of_node;
@@ -2414,6 +2414,10 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	static int idx;
 	int ret = 0;
 
+	/* Already done */
+	if (priv->child_bus)
+		return 0;
+
 	mnp = of_get_child_by_name(np, "mdio");
 
 	if (mnp && !of_device_is_available(mnp))
@@ -2455,6 +2459,7 @@ mt7530_setup_mdio(struct mt7530_priv *priv)
 	of_node_put(mnp);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7530_setup_mdio);
 
 static int
 mt7530_setup(struct dsa_switch *ds)
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

