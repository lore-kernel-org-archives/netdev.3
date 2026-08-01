Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18D36197C
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 07:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570258; cv=none; b=ttkBXqGE47AaAT3LWUpIi8apLZvKGLU6EBYFWTnmMt9s1QYuz6ZYrtP9n6iaFHEjiVf+hFyHxgKqLYTd7fyGXkX923VXxGeowntTmEhdUjq8YcAMIspuTTb0Pu2r3+SVdX+2D4GDyBH11IVdpOlIA9HZwI+xBHvqDyGEqIONfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570258; c=relaxed/simple;
	bh=94qaXWQXh0mq52nGm5gvvf5Tz1C8NXPElzPMjHiDmS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZzczcoP4nOduoZNbx9jUbZPxYtVjuhca3Cp4NoI8lE3klle37/RfpwgjxHexlx6K/umwx4XOsWrWinVg0qgA6FSqy+Iul6Tw0rrkRlPEJDUdBylEwIwQyl80Q0HaA1ov+arPQpFeTgnOmokLMpX9xZjeMKrLdeSqdYEUyvkFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Rtq2wJCb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Rtq2wJCb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DD8804E4107B;
	Sat,  1 Aug 2026 07:44:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B21BE603C2;
	Sat,  1 Aug 2026 07:44:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7270E11C16FFC;
	Sat,  1 Aug 2026 09:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785570249; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=epe8Fh6eCqko5NmYOBT+opvFxuCB1HhR4Sav6cqD8ck=;
	b=Rtq2wJCb7gFFyA/8D3/aHNu2pBOEdH3+HyFx4UaFguPcNMt3RR9HASGhqTgzHaF5ldj+YW
	a/UNav+ql7OPWUdj1hauJosQgE2tKc7TUfgfWn+yn96s4wcLhoD8ktu2NEPFF4SE+uyPxe
	1wY4K3N+mHGMynpBnogIkASpaC/l+vP6XjewkX2AZAjzCOm+6DNJAuAMRKdkyQyQlstyF0
	isUzaD9Is1HS0Hg90QSfOc2PSvvDMyUH/2P7wdjb4yHhMnqZhT5swseBBANY5+6IE1XJFh
	9o32fPAXHVHYxGtldePmKI5TChNbG1n6etddKvY2KVnsdC9yBNylhG+qmXOz6w==
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
Subject: [PATCH net-next v15 04/10] net: phy: Create SFP phy_port before registering upstream
Date: Sat,  1 Aug 2026 09:43:25 +0200
Message-ID: <20260801074332.98755-5-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801074332.98755-1-maxime.chevallier@bootlin.com>
References: <20260801074332.98755-1-maxime.chevallier@bootlin.com>
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
 drivers/net/phy/phy_device.c | 55 +++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..28974dc76abe 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1673,13 +1673,13 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
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
@@ -1694,10 +1694,12 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
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
@@ -1706,25 +1708,46 @@ static int phy_setup_sfp_port(struct phy_device *phydev)
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
 
-	if (!ret && phydev->sfp_bus)
-		ret = phy_setup_sfp_port(phydev);
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
+	}
+out_sfp:
+	sfp_bus_put(bus);
+	phydev->sfp_bus = NULL;
 
 	return ret;
 }
-- 
2.55.0

