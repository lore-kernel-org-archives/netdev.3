Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B957035DCF2;
	Tue, 27 Jan 2026 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521364; cv=none; b=qSQdSpiPfO7BnozVJOy9VYzl9DNX+DF3WX2lQKKBBO6/kdRI71RA6HtVnQM6TKPw2W0e2UasHwV9Eos946eR4ROvUeKCk/rYEuzqjjX6PyrwWCd9FQT5llpY5K8rVjUdQTu72IH00n7Fi8BJlBsDziXD0alaraxGTsmAcle0oBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521364; c=relaxed/simple;
	bh=1C2dhFrK8v121Gqqc49xuuHTTbn/EOQWNDC6jq6YQnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NidcBCahRpxUYssHkZr3M8c+VKBy+QQdPzRkPKQKZnGDaEQijzk9Pn53DpP9So4wPaOd3xGKqM2dU3qfb0/LM2ooWeB/otefTv7TRS7DuHnf+vbKCidaqWXekhz/PwEUZH3Ib+ZwK13EnKIqKcJODwBXiMj4gW5/Dw8umBd90Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oZb9ASBB; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oZb9ASBB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 76C7F4E422D5;
	Tue, 27 Jan 2026 13:42:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D56D606F5;
	Tue, 27 Jan 2026 13:42:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4AC3F119A8692;
	Tue, 27 Jan 2026 14:42:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521360; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=KQcmnl8gxMjsz0wTL/rmjX7tdjhBz25xY9Z+8rYR0kY=;
	b=oZb9ASBBBlMpAVO8NGNMZF2weCqVwXBV0Mf+m9ExFB9gDheajxH4uWMjQwHHcNgQGYvpQf
	DDnRSeu5cQQ7rvZPTy5izjxfrUXQ3XN0l8fJsdahzij85GHnXkqKZOXnBruKpyjtyrGHcp
	AU+4tABsZEklM5a6f7oRa3gVtowFVxmQvDUYpMtTgBmOAVIP1j1bsamwzp1pYc1QIwkQmc
	C+uNDV/AInW0/BI/WrHS3XKzkvJ6CIxeXubgTwpsC9SsYX18aFA1H+C9G0GCEnfPhRIvQ6
	yepIZhrjORFACdyjRLQfYVCA4WfMk6ninLNT5Ru6+wU5P6ugtc488PYhutbvlQ==
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
Subject: [PATCH net-next 09/13] net: phy: phy_port: Store information about a MII port's occupancy
Date: Tue, 27 Jan 2026 14:41:57 +0100
Message-ID: <20260127134202.8208-10-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
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
store an "occupied" bit to know whether or not a MII port is currently
front-facing (i.e. there's no module in the SFP cage), or occupied (i.e.
there's an SFP module).

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 4 ++++
 drivers/net/phy/phylink.c    | 4 ++++
 include/linux/phy_port.h     | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 12c8c2ff2c06..1dba5f06124f 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1636,6 +1636,8 @@ static int phy_sfp_connect_nophy(void *upstream)
 		}
 	}
 
+	phydev->sfp_bus_port->occupied = true;
+
 	/* we don't use phy_add_port() here as the module port isn't a direct
 	 * interface from the PHY, but rather an extension to the sfp-bus, that
 	 * is already represented by its own phy_port
@@ -1649,6 +1651,8 @@ static void phy_sfp_disconnect_nophy(void *upstream)
 {
 	struct phy_device *phydev = upstream;
 
+	phydev->sfp_bus_port->occupied = false;
+
 	if (phydev->attached_dev)
 		phy_link_topo_del_port(phydev->attached_dev, phydev->mod_port);
 
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 6c62604b00a6..3f76b1bbb627 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -4044,6 +4044,8 @@ static int phylink_sfp_connect_nophy(void *upstream)
 		}
 	}
 
+	pl->sfp_bus_port->occupied = true;
+
 	pl->mod_port = port;
 
 	return 0;
@@ -4053,6 +4055,8 @@ static void phylink_sfp_disconnect_nophy(void *upstream)
 {
 	struct phylink *pl = upstream;
 
+	pl->sfp_bus_port->occupied = false;
+
 	if (pl->netdev)
 		phy_link_topo_del_port(pl->netdev, pl->mod_port);
 
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 4e2a3fdd2f2e..8d4f20bfd9dd 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -51,6 +51,8 @@ struct phy_port_ops {
  * @is_mii: Indicates if this port is MII (Media Independent Interface),
  *          or MDI (Media Dependent Interface).
  * @is_sfp: Indicates if this port drives an SFP cage.
+ * @occupied: Indicates if this port feeds into an another component that has
+ *	      a front-facing interface.
  */
 struct phy_port {
 	u32 id;
@@ -71,6 +73,7 @@ struct phy_port {
 	unsigned int active:1;
 	unsigned int is_mii:1;
 	unsigned int is_sfp:1;
+	unsigned int occupied:1;
 };
 
 struct phy_port *phy_port_alloc(void);
-- 
2.49.0

