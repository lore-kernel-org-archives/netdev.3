Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0D3B7B7B
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636118; cv=none; b=jZNxS1vSFUPmwU3X/JbAthcODvrnKDUtlXoLZ1V8as5SPDCLPrKkhvngRgchXepqx1kb1iNfkT7ppkGTLICt+CfyYwL1HAPLdqA8NdaWy4/3KE1IWMtVEDLeTCMTDo/7RHacWofq+0yBbIA8MFqu1Mx9p58mLG6lAokWltaVRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636118; c=relaxed/simple;
	bh=/kJPSQkkdj8NlYpm/pDA4rwzUYszth0jj6KIdYl2+eo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnbIs8eHTlnMNis1wwM7qQN2XeHYUuwy1GAM/3Q8PgJrAZ9hQV2b1/VvDYKsPZduAQTyZ5z8xdjizrwt4ZFl/CUu+YMgo+Z5GO+exM6/DpsoSGIH21nKeLaJwXqWnEMKX70oOe0pbVv5HYDvlSyxmjh0eAKGQL6wkrTN3q2Cxqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ufHsBhqN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ufHsBhqN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 975344E42541;
	Wed,  4 Mar 2026 14:55:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CAA95FF5C;
	Wed,  4 Mar 2026 14:55:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A804D10368FE0;
	Wed,  4 Mar 2026 15:55:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772636114; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=udq/wOfK+wePprCbrxk5enSF5924MQO7g80D3S6WydU=;
	b=ufHsBhqNgtKxQKIC9jWZjplsnBP054/auMfy/C/iwtgbgK5PsWoDGRwFlZPRVPrYi3C7H2
	7rw8VCm5a/AVubmOGDj5+YWyoGaMW1FLpf5SrrflD9/thJfx1/jX2k0jFz902lbfwuX+w2
	Oo/Jy5rbGg0pmIDYhT6M22GyIvl3RICixtJ2EnjI+UOlUaQcvwKEJjX9LVFOWWkDP6T+DH
	ojMen483HSi48G8jMwTyw4KJXKVMUABihRjlvM+6SgKnyImOk23zHTUrIEG8DW0OJ+7vVz
	ncW+f+KquAa9UDH3aw29w4TSPqcyCSb3kwypXHgVNC/A5r2J+jo+eqYnQUnlEw==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v6 07/10] net: phy: phy_port: Store information about a MII port's vacant state
Date: Wed,  4 Mar 2026 15:54:38 +0100
Message-ID: <20260304145444.442334-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260304145444.442334-1-maxime.chevallier@bootlin.com>
References: <20260304145444.442334-1-maxime.chevallier@bootlin.com>
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
 drivers/net/phy/phylink.c    |  7 +++++++
 include/linux/phy_port.h     |  4 ++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 8bff64040540..5d26d75b5f6b 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1550,6 +1550,7 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
 	struct phy_device *phydev = upstream;
 	const struct sfp_module_caps *caps;
 	struct phy_port *port;
+	int ret = 0;
 
 	phy_interface_t iface;
 
@@ -1578,9 +1579,12 @@ static int phy_sfp_module_insert(void *upstream, const struct sfp_eeprom_id *id)
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
@@ -1588,8 +1592,12 @@ static void phy_sfp_module_remove(void *upstream)
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
@@ -1756,6 +1764,7 @@ static struct phy_port *phy_setup_sfp_port(struct phy_device *phydev)
 	 */
 	port->is_mii = true;
 	port->is_sfp = true;
+	port->vacant = true;
 
 	/* The port->supported and port->interfaces list will be populated
 	 * when attaching the port to the phydev.
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 79f7811dec22..b575f5db9ed6 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1777,6 +1777,7 @@ static int phylink_create_sfp_port(struct phylink *pl)
 	port->is_sfp = true;
 	port->is_mii = true;
 	port->active = true;
+	port->vacant = true;
 
 	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
 			  phylink_sfp_interfaces);
@@ -3917,6 +3918,9 @@ static int phylink_sfp_module_insert(void *upstream,
 	pl->sfp_may_have_phy = caps->may_have_phy;
 	pl->sfp_port = caps->port;
 
+	if (pl->sfp_bus_port)
+		pl->sfp_bus_port->vacant = false;
+
 	/* If this module may have a PHY connecting later, defer until later */
 	if (pl->sfp_may_have_phy)
 		return 0;
@@ -3928,6 +3932,9 @@ static void phylink_sfp_module_remove(void *upstream)
 {
 	struct phylink *pl = upstream;
 
+	if (pl->sfp_bus_port)
+		pl->sfp_bus_port->vacant = true;
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
2.49.0

