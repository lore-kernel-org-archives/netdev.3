Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D88A4AD4B3;
	Wed,  2 Sep 2026 21:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384141; cv=none; b=YxUI8Gp56RpCdbjDjC/7HTH/IBczOc+IGaUnEFw+eFbiQZYE8L6lQMWyyVRb0Iq0pVOTs7TRgo/iQ2uHRFWCAFVXFcUhSvd/1ZsZ2w8bfoLBWY07eM/Jo8cJvX/P+FQCimr9hPC4yB7tGbBRikqUKa0wJw0foCWZiDsIuLUjP1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384141; c=relaxed/simple;
	bh=8CptqrnqSslLrSyN6cgzJHEQDPJTCrBQXI8kBcEqZ1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cz1tOTiMsxwxQHZ2p9pXM1O7TogCW0ojDQj9DNKqJWMEoZ9qGOgaouITfgBBc+Q0o9A+LLE1PcDMMs7hVp0gBrdt0FBTSxAI9GIKLXnAeh8aXhlF5O/XoG3k2NXe5mX2WyBLZsU8UXr+5FeemwLLQWAzsZvQUdLem8otC1SILoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gTBQ2dG2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gTBQ2dG2"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 42FEC4E414C9;
	Wed,  2 Sep 2026 21:22:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0F06F6053C;
	Wed,  2 Sep 2026 21:22:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0E0B11C79A58;
	Wed,  2 Sep 2026 23:22:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788384128; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=BA2r0VAbVq1lUfxOdx04z9egF3RBorsTYvBWdD8nJ9E=;
	b=gTBQ2dG2cQyq7LxOhlGz3bKEflYG1V5KeN2/f6rKyYCIE7sDQUZXFjmpHcMKH+IfTlarEV
	RXkp00IFZ7HSCoVmZfPkHmnijgMFdhJkk0yFInjN56cgSZtPH9+wzVWJdDoYwtMe/qoZrq
	Y2IZmh9FwjJ39oxTCmo/gNHASq2pektb0UKQ1nmu1xhRzqrmDrIpN3yfkgh4bN9fLV3F5X
	OcfVurRb9MlHbMNw1OMNARhSXmiRbo/PiK9+PYglXbifbFT0Er5HFdXIPcPZbuOrTuFX1Q
	oSOTqEZHMnrXG2p+kFzyC3YehXR4eLMgy0NFnAel/8UFTzHFIuzjHdIsf5oPmw==
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
Subject: [PATCH net-next v16 03/10] net: phylink: Register a phy_port for MAC-driven SFP cages
Date: Wed,  2 Sep 2026 23:21:27 +0200
Message-ID: <20260902212135.1805948-4-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902212135.1805948-1-maxime.chevallier@bootlin.com>
References: <20260902212135.1805948-1-maxime.chevallier@bootlin.com>
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
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 3ec3bb439109..e99cf873d6b0 100644
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
 
@@ -1765,6 +1768,46 @@ static void phylink_fixed_poll(struct timer_list *t)
 
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
+	if (pl->netdev && pl->sfp_cage_port)
+		phy_link_topo_del_port(pl->netdev, pl->sfp_cage_port);
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
@@ -1782,9 +1825,18 @@ static int phylink_register_sfp(struct phylink *pl,
 
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
 
@@ -1947,6 +1999,7 @@ EXPORT_SYMBOL_GPL(phylink_create);
 void phylink_destroy(struct phylink *pl)
 {
 	sfp_bus_del_upstream(pl->sfp_bus);
+	phylink_destroy_sfp_cage_port(pl);
 	if (pl->link_gpio)
 		gpiod_put(pl->link_gpio);
 
-- 
2.55.0

