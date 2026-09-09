Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFF47C11E
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946786; cv=none; b=VQc0z27OGo+JQxzYfiW3ARmReNxPbtcgOftQ2wz5goLl9HtvAW54U78cQ7D1CJfIZnSdI3VDYjTYgGOqUn9yL9gawJL0w7swwG+/9SNYY683DoOZ1fbY2ZJBVWyCdYvqH6kMOtjtjFFrNnUAqcXIsIkkpebL62S8kcvEMMhO2Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946786; c=relaxed/simple;
	bh=gz2ND9nV3pfn36N1qUg7Za2PGMJAzWc3C0YHo0yjqoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhbAuuRVvxN2CA+GyWJ9i3oW6lQedWKyPXRMW/UNiLNi8lcf/9zgg/9KRLEMYOmOk46iT8E6qqsiBU1XCz6YDoagqX62kdSADLZw6qzTp+Cl+BGWgvFZiBaCPV5hBe9554KfjPac7tfiFqwXso3DCypV4Lpfq42gOcitE5YC/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BfYPlr/O; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BfYPlr/O"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BA3264E415AD;
	Wed,  9 Sep 2026 09:39:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8737260448;
	Wed,  9 Sep 2026 09:39:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89F4E11C7AF7A;
	Wed,  9 Sep 2026 11:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788946776; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZPk2GW0s5m/uNcivTKURMNDKcrEm1Hk/juC4Lz1N3q0=;
	b=BfYPlr/OAg3Bx9uDE95Xy2fH3gUGdGGEhU0riFs4ojNOK+ugUb8/pjixldSnBANCE3GMUm
	YdyrOjEZN9FAbySnPCwE4d/mUz4lT3zBqo3BSbrAzv+mtbz7xPBAIFHdgSwNicHCOqIiVL
	Yrw+EFUrX1CSm78Wq702cnHO7qVy7R0dG4SO6MgbQLH7wrgsatfPZHRDLE9RDpWF37jfFd
	+UuikFp+NcBmrDpfxJ5hSTL3c5OptbW1/0mCk/VEDKKl622mEcw2euy7CxOI2krZhFs49b
	P9wQya+m9jKZzlmL8Z/0tVBa1pE98pS1hbWmDfE5N6YHx3xM6jN/9P57GiE9Vw==
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
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	Pietro Ameruoso <p.ameruoso@live.it>
Subject: [PATCH net-next v17 04/10] net: phy: Create SFP phy_port before registering upstream
Date: Wed,  9 Sep 2026 11:39:05 +0200
Message-ID: <20260909093912.1290810-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
References: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

When dealing with PHY-driven SFP, we create a phy_port representing the
SFP bus when we know we have such a bus.

We can move the port creation before registering the sfp upstream ops,
as long as we know the SFP bus is there. This will allow passing the
phy_port along with the upstream information to the SFP bus.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 58 +++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 2d0fa3c7f18e..f15c0fc339b4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1676,13 +1676,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
 	phydev->n_ports--;
 }
 
-static int phy_setup_sfp_port(struct phy_device *phydev)
+static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 {
 	struct phy_port *port = phy_port_alloc();
 	int ret;
 
 	if (!port)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	port->parent_type = PHY_PORT_PHY;
 	port->phy = phydev;
@@ -1697,10 +1697,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
 	 * when attaching the port to the phydev.
 	 */
 	ret = phy_add_port(phydev, port);
-	if (ret)
+	if (ret) {
 		phy_port_destroy(port);
+		return ERR_PTR(ret);
+	}
 
-	return ret;
+	return port;
 }
 
 /**
@@ -1709,30 +1711,46 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
  */
 static int phy_sfp_probe(struct phy_device *phydev)
 {
+	struct phy_port *port = NULL;
 	struct sfp_bus *bus;
-	int ret = 0;
+	int ret;
 
-	if (phydev->mdio.dev.fwnode) {
-		bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
-		if (IS_ERR(bus))
-			return PTR_ERR(bus);
+	if (!phydev->mdio.dev.fwnode)
+		return 0;
 
-		phydev->sfp_bus = bus;
+	bus = sfp_bus_find_fwnode(phydev->mdio.dev.fwnode);
+	if (IS_ERR(bus))
+		return PTR_ERR(bus);
 
-		ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
-		sfp_bus_put(bus);
+	phydev->sfp_bus = bus;
 
-		if (ret)
-			phydev->sfp_bus = NULL;
+	if (bus) {
+		port = phy_setup_sfp_port(phydev);
+		if (IS_ERR(port)) {
+			ret = PTR_ERR(port);
+			goto out_sfp;
+		}
 	}
 
-	if (!ret && phydev->sfp_bus) {
-		ret = phy_setup_sfp_port(phydev);
-		if (ret) {
-			sfp_bus_del_upstream(phydev->sfp_bus);
-			phydev->sfp_bus = NULL;
-		}
+	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
+	if (ret)
+		goto out_port;
+
+	/* sfp_bus_add_upstream() grabs a ref to the sfp bus on success, it's
+	 * safe to release it now.
+	 */
+	sfp_bus_put(bus);
+
+	return ret;
+
+out_port:
+	if (port) {
+		phy_del_port(phydev, port);
+		phy_port_destroy(port);
 	}
+out_sfp:
+	sfp_bus_put(bus);
+	phydev->sfp_bus = NULL;
 
 	return ret;
 }
-- 
2.55.0

