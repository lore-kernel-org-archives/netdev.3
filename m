Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD84D0A13
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157524; cv=none; b=uo5O2BwUtv20ILc1TTX2B4Quty/KPu7GnzjF1FnBK8tE88OV4m9ruRQZrqSI6gODROlw0ohssg4WfOaqZUsXhEKmL0onLWem/b300GKcBgcYfX2qkKesT92jwnhIczpCn2lr1g07in6LLTyYpSm26YTW2ug19J1j8Ic1UmMq7cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157524; c=relaxed/simple;
	bh=ImNBmBv9Qzo5ewHQ0hzD3nSQK+kMq+xiQM0cKAYHouc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6uADjaSFSeZyg9moNKWgAuO+MIJjZ5fmZiF/WXAES/JFi4EYHTsaTCIyTkRQCgdRCIxb+EjpP4VD8zjSBAhJikH7I+dza9zeJallBxkA6soLCNYClhPH0NSCs83HJ1F/LgfgMKSE1ES73tG3CL5VFaomNZmFd2COhE90fRkRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rmoRQlF6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rmoRQlF6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E485C4E41262;
	Fri, 16 Oct 2026 13:32:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B71A76075D;
	Fri, 16 Oct 2026 13:32:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBF01103284D3;
	Fri, 16 Oct 2026 15:31:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792157515; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gOyXLO9fgw3x6ke9Nezr9bMUudXIzulhyLRY7LNl0AA=;
	b=rmoRQlF6bfPN1k4pQD6r00lv4bK6tfr2uOl5MsiXNDmLn8f8bfmGzsMeZSENeKRy7lCmYm
	dSYnrz1almDokonUvxyZMn/36HK3fp3VznfytcTPTS/Uu60TTPwfuSLv0uwk4rX5rOGUqP
	jNJLIaZLrn9MlYpGvSqcaGxeQgfZNlf22o1wNiZPgxdp44XOZgoIxd8W7dMgoFd1PoerYT
	9E0vWazXv1QT1zWaZLAQN9KJTu7PRK/zRcG6Ax3lpRU7GBP93DVZoRljGQ3tdS8XQNnXEZ
	y8/A79bNeQwuh/TYkyHhrIgIPJhluS7eE7quMxe5hDFsC3N26GjIh5n6ifs+cg==
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
	Pietro Ameruoso <p.ameruoso@live.it>,
	Aleksei Sviridkin <f@lex.la>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH net-next v19 04/10] net: phy: Create SFP phy_port before registering upstream
Date: Fri, 16 Oct 2026 15:30:59 +0200
Message-ID: <20261016133107.54054-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
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
Tested-by: Aleksei Sviridkin <f@lex.la>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 62 ++++++++++++++++++++++++------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index ab1aa8981c00..7713418a6734 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1586,13 +1586,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
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
@@ -1607,10 +1607,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
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
@@ -1619,32 +1621,48 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
  */
 static int phy_sfp_probe(struct phy_device *phydev)
 {
+	struct phy_port *port;
 	struct sfp_bus *bus;
-	int ret = 0;
 
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
+	if (bus) {
+		port = phy_setup_sfp_port(phydev);
+		if (IS_ERR(port)) {
+			sfp_bus_put(bus);
 			phydev->sfp_bus = NULL;
+			return PTR_ERR(port);
+		}
 	}
 
-	if (!ret && phydev->sfp_bus) {
-		ret = phy_setup_sfp_port(phydev);
-		if (ret) {
-			sfp_bus_del_upstream(phydev->sfp_bus);
-			phydev->sfp_bus = NULL;
-		}
+	return 0;
+}
+
+static int phy_sfp_add_upstream(struct phy_device *phydev)
+{
+	struct sfp_bus *bus = phydev->sfp_bus;
+	int ret;
+
+	ret = sfp_bus_add_upstream(bus, phydev, &sfp_phydev_ops);
+	if (ret) {
+		sfp_bus_put(bus);
+		phydev->sfp_bus = NULL;
+		return ret;
 	}
 
-	return ret;
+	/* sfp_bus_add_upstream() grabs a ref to the sfp bus on success, it's
+	 * safe to release it now.
+	 */
+	sfp_bus_put(bus);
+
+	return 0;
 }
 
 /**
@@ -3551,6 +3569,10 @@ static int phy_setup_ports(struct phy_device *phydev)
 			break;
 		}
 
+	ret = phy_sfp_add_upstream(phydev);
+	if (ret)
+		goto err_sfp;
+
 	return 0;
 
 err_sfp:
-- 
2.56.0

