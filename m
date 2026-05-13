Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35B841B37B
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677551; cv=none; b=XFUMjRsBuaAEBJmsppKr+gvNrLHGxD392vGFi3Y2Q788boNnj0g8c3rzMdlo7IYL9bO75cnDpMrXYOkWwyQdtK+ns8H25s7HrfrU3q688mCgvSsCb0jnSlckWdLCW/Vukn6zjL/iRhD1j/+wJAluLPaDd577l04UUWMbPJx7vlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677551; c=relaxed/simple;
	bh=tN1MnssRwnMDO75ZM5lqvMSmoSNBrLljpIj9pY+pXg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDwH5An9MPzXIZjhA9WtRWPRe59cctHCPr+9/lcSTIcnZTIddr25zeBBgZxpL6JsqtFcGJJAjzsgxE/x3N2eIL89jvQAXjCV/S/hutHB1jNicgMiMqz1zkJ/gJOWgjU8wvDUohEJ6CdziPN7JT8/7wY6T3tAQR+7AoOeudwTFeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1O8qF52a; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1O8qF52a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 914351A3599;
	Wed, 13 May 2026 13:05:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 65D405FE21;
	Wed, 13 May 2026 13:05:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 248DD11AF9021;
	Wed, 13 May 2026 15:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778677546; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gZbA4Vh5fsyCzflVwiEH+mXLMjLJYNfaoOR/c8pTKAc=;
	b=1O8qF52aZqihVb2XcYGYlay8QDxiu6+IJ9v/UVS/MXtvjg8M98Obw3wOQarseEjNEAKE3w
	uovLyqR8E+/kUqJ57Vohdyh8PyX9usWnTJHjc92u65fxEWqIaUWGQBgAiY7bF+KLOu9pd+
	FlBVlQ1hv4DQUCUldoOAjOsAkaJDpTtQh+e7IwhXwLccOYMTbeJ6qjmsS+qZIGNmPa+2Ii
	5DeaTSNPrFT8MnkLkxH7KZsS6QatVG4APZD+1gTdHna4WiOupV3nzdbfJlUXxlUoVsb1XG
	PSTcLdZrf5Xf+u8bIU5TIA73btWMhVnh1m0UjGcRM+2AGvjtUZWgxjKqIhtG2Q==
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
Subject: [PATCH net-next v10 6/9] net: phy: phy_port: Store information about a MII port's vacant state
Date: Wed, 13 May 2026 15:05:17 +0200
Message-ID: <20260513130521.1064094-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
References: <20260513130521.1064094-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MII phy_ports are not meant to be connected directly to a link partner.
They are meant to feed into some media converter devices, so far we only
support SFP modules for that.

We have information about what MII they can handle, however we don't
store anything about whether they are currently connected to an SFP
module or not. As phy_port aims at listing the front-facing ports, let's
store an "vacant" bit to know whether or not a MII port is currently
vacant (i.e. there's no module in the SFP cage), or not (i.e.
there's an SFP module).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 17 +++++++++++++----
 drivers/net/phy/phylink.c    | 14 +++++++++++++-
 include/linux/phy_port.h     |  4 ++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 03bcaf5e5fe3..d931c5c7ddbb 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1566,6 +1566,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 	struct phy_device *phydev = upstream;
 	const struct sfp_module_caps *caps;
 	struct phy_port *port;
+	int ret = 0;
 
 	phy_interface_t iface;
 
@@ -1594,9 +1595,12 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 		phydev->port = caps->port;
 
 	if (port->ops && port->ops->configure_mii)
-		return port->ops->configure_mii(port, true, iface);
+		ret = port->ops->configure_mii(port, true, iface);
 
-	return 0;
+	if (!ret)
+		port->vacant = false;
+
+	return ret;
 }
 
 static void phy_sfp_module_remove(void *upstream)
@@ -1604,8 +1608,12 @@ static void phy_sfp_module_remove(void *upstream)
 	struct phy_device *phydev = upstream;
 	struct phy_port *port = phy_get_sfp_port(phydev);
 
-	if (port && port->ops && port->ops->configure_mii)
-		port->ops->configure_mii(port, false, PHY_INTERFACE_MODE_NA);
+	if (port) {
+		if (port->ops && port->ops->configure_mii)
+			port->ops->configure_mii(port, false,
+						 PHY_INTERFACE_MODE_NA);
+		port->vacant = true;
+	}
 
 	if (phydev->n_ports == 1)
 		phydev->port = PORT_NONE;
@@ -1772,6 +1780,7 @@ static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 	 */
 	port->is_mii = true;
 	port->is_sfp = true;
+	port->vacant = true;
 
 	/* The port->supported and port->interfaces list will be populated
 	 * when attaching the port to the phydev.
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 59ea3a2e5da4..175a63ac8829 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1784,6 +1784,7 @@ static int phylink_create_sfp_cage_port(struct phylink *pl)
 	port->is_sfp = true;
 	port->is_mii = true;
 	port->active = true;
+	port->vacant = true;
 
 	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
 			  phylink_sfp_interfaces);
@@ -3907,6 +3908,7 @@ static int phylink_sfp_module_insert(void *upstream,
 {
 	const struct sfp_module_caps *caps;
 	struct phylink *pl = upstream;
+	int ret;
 
 	ASSERT_RTNL();
 
@@ -3916,17 +3918,27 @@ static int phylink_sfp_module_insert(void *upstream,
 	pl->sfp_may_have_phy = caps->may_have_phy;
 	pl->sfp_port = caps->port;
 
+	if (pl->sfp_cage_port)
+		pl->sfp_cage_port->vacant = false;
+
 	/* If this module may have a PHY connecting later, defer until later */
 	if (pl->sfp_may_have_phy)
 		return 0;
 
-	return phylink_sfp_config_optical(pl);
+	ret = phylink_sfp_config_optical(pl);
+	if (ret && pl->sfp_cage_port)
+		pl->sfp_cage_port->vacant = true;
+
+	return ret;
 }
 
 static void phylink_sfp_module_remove(void *upstream)
 {
 	struct phylink *pl = upstream;
 
+	if (pl->sfp_cage_port)
+		pl->sfp_cage_port->vacant = true;
+
 	phy_interface_zero(pl->sfp_interfaces);
 }
 
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 4e2a3fdd2f2e..b0b1fa6a67a9 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -51,6 +51,9 @@ struct phy_port_ops {
  * @is_mii: Indicates if this port is MII (Media Independent Interface),
  *          or MDI (Media Dependent Interface).
  * @is_sfp: Indicates if this port drives an SFP cage.
+ * @vacant: For MII ports, indicates whether or not the port has a connection to
+ *	    another device (e.g. for SFP ports, indicates the absence or presence
+ *	    of an SFP module)
  */
 struct phy_port {
 	u32 id;
@@ -71,6 +74,7 @@ struct phy_port {
 	unsigned int active:1;
 	unsigned int is_mii:1;
 	unsigned int is_sfp:1;
+	unsigned int vacant:1;
 };
 
 struct phy_port *phy_port_alloc(void);
-- 
2.54.0

