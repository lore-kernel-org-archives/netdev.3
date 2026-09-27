Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97B3C13FB;
	Sun, 27 Sep 2026 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516212; cv=none; b=sB564Wq6wWikQ7ByPfZsXTDCL8s8NB2JYIOZzEb7kdMXiNoeF4lKUlS13A8RGWkNUZ01BZcaGiivP1+pC9ZWxxw6U2PH6uBiQq8jmwShwxVeOzOzZJDm0ZK19sR2oECT3Fb10Vw6K2zv0ywPws9YWvzQY9AlD+U5oBvY9jSRUbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516212; c=relaxed/simple;
	bh=/2kxVKGWTH+s2LZeNa1lQrqi+alHqnowGjRctArlKvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ai33dtI5XPHLQjPN29eSrnl7eoltlPpF+xzYIyYLQmuwsxB5r13zFGUqSPjPUiLRvXT+Y4o+AexP8zhYUZA2glgv7YuIB9Lyc4T7wGtA528yA6UNDiVY39joMMh3Ok1K782aJ+VkXxfN3PpEo5/P8PV8WJIqPgBS+Pnj/9sbDtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=usVGUKVI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="usVGUKVI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 838A44E40ECD;
	Sun, 27 Sep 2026 13:36:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 562F1604FF;
	Sun, 27 Sep 2026 13:36:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5E1D9102F1E7C;
	Sun, 27 Sep 2026 15:36:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790516206; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JnS+iZYWz2r8fNfsTOvx0zHQcjMEJWO5MVdrzj/bQPw=;
	b=usVGUKVIpR//oAS6snezR3DPJAnrwiNo221cEdu1epXcE5FPPJ2Esw1wWGF2hkwMT1oC/C
	eEWXFraZ3sHl0OcM734g/lV9fBs1soxTsY1vrYYqQ2ixJBYHgfPivTVymO47Ic8CqqajFX
	LAgN3QV2MW8bDpLERPc3cJSumHP+l7PoAGfgYoTJ4gwoNCca7LYxDFkrOULtgWMIRzVq+L
	4Ltg6epA7cIrkg46sARhPjE5ecEJhHWVV+9vvsf9AmacHl2p4DNfW7ThGWRIn6zcl+E5+r
	/mXAaiUcv4HzQ2kaE+TYtoTT4YBgznWo+VLc24B6EDPyGRoEfNfv+FyFdHAVWA==
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
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next v18 03/10] net: phylink: Register a phy_port for MAC-driven SFP cages
Date: Sun, 27 Sep 2026 15:36:12 +0200
Message-ID: <20260927133619.955236-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
References: <20260927133619.955236-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

phy_port tracks the interfaces that a netdevice feeds into. SFP cages are
such ports, but so far we are only tracking the ones that are driven by
PHYs acting as media-converters.

Let's populate a phy_port for MAC driven SFP cages, handled by phylink.

This phy_port represents the SFP cage itself, and not the module that
may be plugged into it. It's therefore not an MDI interface, so only the
'interfaces' field is relevant here.

The phy_port is only populated for 'NETDEV' phylink instances, as
otherwise we don't have any topology to attach the port to.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Aleksei Sviridkin <f@lex.la>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 57 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a7d086cdc9b2..19090916af75 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -14,6 +14,8 @@
 #include <linux/of_mdio.h>
 #include <linux/phy.h>
 #include <linux/phy_fixed.h>
+#include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phylink.h>
 #include <linux/rtnetlink.h>
 #include <linux/spinlock.h>
@@ -93,6 +95,7 @@ struct phylink {
 	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
+	struct phy_port *sfp_cage_port;
 
 	struct eee_config eee_cfg;
 
@@ -1767,6 +1770,50 @@ static void phylink_fixed_poll(struct timer_list *t)
 
 static const struct sfp_upstream_ops sfp_phylink_ops;
 
+static int phylink_create_sfp_cage_port(struct phylink *pl)
+{
+	struct phy_port *port;
+	int ret = 0;
+
+	if (!pl->netdev || !pl->sfp_bus)
+		return 0;
+
+	port = phy_port_alloc();
+	if (!port)
+		return -ENOMEM;
+
+	port->is_sfp = true;
+	port->is_mii = true;
+	port->active = true;
+
+	phy_interface_and(port->interfaces, pl->config->supported_interfaces,
+			  phylink_sfp_interfaces);
+	phy_port_update_supported(port);
+
+	ret = phy_link_topo_add_port(pl->netdev, port);
+	if (ret)
+		phy_port_destroy(port);
+	else
+		pl->sfp_cage_port = port;
+
+	return ret;
+}
+
+static void phylink_destroy_sfp_cage_port(struct phylink *pl)
+{
+	if (pl->netdev && pl->sfp_cage_port) {
+		/* The port may still be accessed under RTNL */
+		rtnl_lock();
+		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
+		rtnl_unlock();
+	}
+
+	if (pl->sfp_cage_port)
+		phy_port_destroy(pl->sfp_cage_port);
+
+	pl->sfp_cage_port = NULL;
+}
+
 static int phylink_register_sfp(struct phylink *pl,
 				const struct fwnode_handle *fwnode)
 {
@@ -1784,9 +1831,18 @@ static int phylink_register_sfp(struct phylink *pl,
 
 	pl->sfp_bus = bus;
 
+	ret = phylink_create_sfp_cage_port(pl);
+	if (ret) {
+		sfp_bus_put(bus);
+		return ret;
+	}
+
 	ret = sfp_bus_add_upstream(bus, pl, &sfp_phylink_ops);
 	sfp_bus_put(bus);
 
+	if (ret)
+		phylink_destroy_sfp_cage_port(pl);
+
 	return ret;
 }
 
@@ -2069,6 +2125,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
 void phylink_destroy(struct phylink *pl)
 {
 	sfp_bus_del_upstream(pl->sfp_bus);
+	phylink_destroy_sfp_cage_port(pl);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
-- 
2.55.0

