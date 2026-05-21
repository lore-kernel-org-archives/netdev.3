Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C873C9EE9;
	Thu, 21 May 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365467; cv=none; b=MsuHyECrMP/h/yB5WOmkGHaerN6Qp2DObOa072XJ4CWWzof1XMhuA4TId2mZ+rOM26dVTeAiMZ/IvQDjbw470CcjMQnZ1GdorXphbUF+qH4xwMKWN6RoU4tY7tRmQJI0v8KzJe98WKg7df9xLH0KPFHf/kg+9tcqa0ZPzd5jbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365467; c=relaxed/simple;
	bh=3MbVD5Ia11D0F7SBgBQCzYIiajWVjuB5zhEMql1BwsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCG98nc1+VYgS0BcP7Sku+cgM2fpxS4I1FjwjaTKndSytzjHFS8mdNcGgh+1T5IJ91ql++29dLUpkJ14hkUEL98IDByPpVA67rwALpxJi1QBOayHVfT7JGd8sXJxPgfWNqOEFszmP/89PNy12Z1iQyGFkOxoK5u94VBx/hT86K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=je5P2bIY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="je5P2bIY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id AC6524E42D0D;
	Thu, 21 May 2026 12:11:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7A6BE60495;
	Thu, 21 May 2026 12:11:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC1AB107E8AA0;
	Thu, 21 May 2026 14:10:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779365462; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=yjLpix2qCAfJLxFr2p4Dec8Iy4M3O0SZPaqr0YIpL5o=;
	b=je5P2bIY21XmFh5Y8FNXQs0WEuvF9dBbvGgfS0glwLe4czHeumOXKCelBBl0vKIScYd/x4
	xloFjjKkhtOE623KjBZSwvWPF94pQzfY+fd9BhirKrjp+jzt3D6JmvzM6u+wU/yVdg140f
	V0dQ4YIYGEzpTB16WmZKaKyclqJc2YqbTmOAhklpmS4uSNTsm//4Hy/lthiqwkHOFGpUCC
	81HdgedRGcyChHAi0pe3Ss3LoGQwCcpbVs9I2gai2qSXBwkBrcRPygEfVO3gtCKmHAJwwW
	fD5hnh/9xOO6QUh84ZDp0tlZ+fEPcF5TBtbzQFqeob6zAicsow+X/eI0sBqFaQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Romain Gantois <romain.gantois@bootlin.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>
Subject: [PATCH net-next v11 01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Thu, 21 May 2026 14:10:29 +0200
Message-ID: <20260521121040.1199622-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The phy_link_topology structure stores information about the PHY-related
components connected to a net_device. It is opportunistically allocated,
when we add the first item to the topology, as this is not relevant for
all kinds of net_devices.

In preparation for the addition of phy_port tracking in the topology,
let's make a dedicated helper for that allocation sequence.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 1f1eb5d59b38..fdfafd951905 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -27,21 +27,34 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	return 0;
 }
 
+static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *dev)
+{
+	int ret;
+
+	if (dev->link_topo)
+		return dev->link_topo;
+
+	/* The topology is allocated the first time we add an object to it.
+	 * It is freed alongside the netdev.
+	 */
+	ret = netdev_alloc_phy_link_topology(dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dev->link_topo;
+}
+
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
 {
-	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_link_topology *topo;
 	struct phy_device_node *pdn;
 	int ret;
 
-	if (!topo) {
-		ret = netdev_alloc_phy_link_topology(dev);
-		if (ret)
-			return ret;
-
-		topo = dev->link_topo;
-	}
+	topo = phy_link_topo_get_or_alloc(dev);
+	if (IS_ERR(topo))
+		return PTR_ERR(topo);
 
 	pdn = kzalloc_obj(*pdn);
 	if (!pdn)
-- 
2.54.0

