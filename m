Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2539B972
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774426817; cv=none; b=XP6SWxtrHPmgPLE62fSRJSodu1+t3OEta72qr/J4naEKIbFjgqNGekZznErwCITIygZ8BSxQ65xFY8u3BxtSwAw/71D7kYzxR6qH5VJvq4k9CJDuGEZkFrljnDNi2Y3Eu32dUEWt4dxlERMHBoZFexGe8U8FXYk/+Ey3PHsdimw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774426817; c=relaxed/simple;
	bh=n+/eeFZ1KaBKkTVwQyOhrNeVZTsPVlh2kmn3CKOJrF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEbgH0IcFCYWlQo5QA2vpRRVuYsmHE1JPV5fgGnRTiKCShpcBDg3207IAcTQqkgIKHJ50DXgJC/2zB9ixoSqYZ6t9JXqMZcayspV+EJvddDC0h/Ys+fhx08oHrsyp9IK+3Jks7BB77RETfRKhSQj5mwo0BlCgw9TDsgH8uez5LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AdbUrSim; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AdbUrSim"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 671961A2FDF;
	Wed, 25 Mar 2026 08:20:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 320A3601A1;
	Wed, 25 Mar 2026 08:20:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F37B410451369;
	Wed, 25 Mar 2026 09:20:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774426812; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ly+cldkPfJWshEyvYF+QzhXSu8lWYMwFRWFMwAjqCiU=;
	b=AdbUrSimY5T7N1ufrxf/X5u50iHAT+iZF8rRhIyN5aDJbuGLe3kSFRKB4laJSXrrKYSj+V
	QyRgx+VZWNX5cHNohI2/Z+N/NjieQpbu4W7uiUEmyds9LlKmVsylXgsnAAUOzBJZ1ioWtz
	DsQd/yIELZiKSw0FFXFIAhU6feUYUNMuWE5gWxR9SK4y+Z/GvYvqoVowQl9gN4M8wEVSRt
	gXynv3rfUKkXYcTh5BkFVKoCBgmhsTDtsWKR388tb023kxmesQlIHFl/fxTdcF3RFRhqP+
	rXvFJgsH757f1L/0kjC7Cq+nyFz+7R1jw8bSzL5ueLHGD6PMdhywXp3UwDEoXA==
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
Subject: [PATCH net-next v8 06/10] net: phylink: Represent PHY-less SFP modules with phy_port
Date: Wed, 25 Mar 2026 09:19:31 +0100
Message-ID: <20260325081937.571115-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
References: <20260325081937.571115-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Let phylink handle the phy_port for PHY-less modules, and register it to
the topology.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 71 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 7535fb117bf5..73d838b918d1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -96,6 +96,7 @@ struct phylink {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
 	struct phy_port *sfp_bus_port;
+	struct phy_port *mod_port;
 
 	struct eee_config eee_cfg;
 
@@ -1790,10 +1791,21 @@ static int phylink_create_sfp_port(struct phylink *pl)
 
 	ret = phy_link_topo_add_port(pl->netdev, port);
 	if (ret)
-		phy_port_destroy(port);
-	else
-		pl->sfp_bus_port = port;
+		goto out_destroy_port;
+
+	pl->sfp_bus_port = port;
+
+	if (pl->mod_port) {
+		ret = phy_link_topo_add_port(pl->netdev, pl->mod_port);
+		if (ret)
+			goto out_del_bus_port;
+	}
 
+	return 0;
+out_del_bus_port:
+	phy_link_topo_del_port(pl->netdev, port);
+out_destroy_port:
+	phy_port_destroy(port);
 	return ret;
 }
 
@@ -3926,14 +3938,65 @@ static void phylink_sfp_module_remove(void *upstream)
 	phy_interface_zero(pl->sfp_interfaces);
 }
 
+static int phylink_add_sfp_mod_port(struct phylink *pl)
+{
+	const struct sfp_module_caps *caps;
+	struct phy_port *port;
+	int ret = 0;
+
+	if (!pl->sfp_bus_port)
+		return 0;
+
+	/* Create mod port */
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->active = true;
+
+	caps = sfp_get_module_caps(pl->sfp_bus);
+
+	phy_caps_linkmode_filter_ifaces(port->supported, caps->link_modes,
+					pl->sfp_bus_port->interfaces);
+
+	if (pl->netdev) {
+		ret = phy_link_topo_add_port(pl->netdev, port);
+		if (ret) {
+			phy_port_destroy(port);
+			return ret;
+		}
+	}
+
+	pl->mod_port = port;
+
+	return 0;
+}
+
+static void phylink_del_sfp_mod_port(struct phylink *pl)
+{
+	if (!pl->mod_port)
+		return;
+
+	if (pl->netdev)
+		phy_link_topo_del_port(pl->netdev, pl->mod_port);
+
+	phy_port_destroy(pl->mod_port);
+	pl->mod_port = NULL;
+}
+
 static int phylink_sfp_module_start(void *upstream)
 {
 	struct phylink *pl = upstream;
+	int ret;
 
 	/* If this SFP module has a PHY, start the PHY now. */
 	if (pl->phydev) {
 		phy_start(pl->phydev);
 		return 0;
+	} else {
+		ret = phylink_add_sfp_mod_port(pl);
+		if (ret)
+			return ret;
 	}
 
 	/* If the module may have a PHY but we didn't detect one we
@@ -3952,6 +4015,8 @@ static void phylink_sfp_module_stop(void *upstream)
 	/* If this SFP module has a PHY, stop it. */
 	if (pl->phydev)
 		phy_stop(pl->phydev);
+	else
+		phylink_del_sfp_mod_port(pl);
 }
 
 static void phylink_sfp_link_down(void *upstream)
-- 
2.49.0

