Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCF477994
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569728; cv=none; b=qbaGMQn5IqWepuaj1xC0GcBBCa+zgGhP/YYv/rk6UUjlIUEdQMqJgty5D8I3eLG/lS+FO7g+Im2zHey6S0hMtJMjjCBzb5C+SPgd4TrwgWaFfSqcNqoUtw8OKp3P/n1MqqJ40DQKdtLtBlSQ9uTGKoWfiAqoDy7nB/6cUQdxKeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569728; c=relaxed/simple;
	bh=VKsd0LP4Loxv7Mr3+Vf4C0YIYrmSx/bzBK8HGl1uV6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wd1zXwG6PHdnZiFVH16tApEAw/vofsiwuxTRmWTT/Yfxytv9v/5lOy/20w6UWg9mwPGcNZ9QcOas7SYrvMM2ewtlt3yHB4L/21e0ugHipB62nLuEq169CVgH1gg4F1h/ckfBWkpKVKwU0R+lba6DeGjZiRsiU4l25IR0kleHXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D9h9Xrzs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D9h9Xrzs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5D2D11A110A;
	Mon, 20 Jul 2026 17:48:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A3D860360;
	Mon, 20 Jul 2026 17:48:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6FC811BD3A1B;
	Mon, 20 Jul 2026 19:48:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784569718; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=JsuEooygyN2OGHcyFokupB+St2N9AmC/SgaMooe4BJ0=;
	b=D9h9XrzsEkP6a8EwbaCfqQ1J4oWaws4iA5Kx4gPO3Um+65/Y8+dQ/OBXb5uJBBLycUoqZG
	iVBZtFWIhNT1XbuaWsCdLcAuElKg01xcnG5a14k6Dsz4yA6pGkzdsmYfSh22VP1bm50wI1
	RquGfCJVEsbBhn4IdIWXD3lva7CIR7C/iLphW/WxAJevrluoR4Nx+y93dNk8hBEAlzitDl
	fIXQZYA11m+HbffXMRoHPaWejG3UbHiLN2Y2HhjVi9sfs8x8LMRsjTBxIWmPdSir6/a+st
	I3pF60NYOtAe8VPX5EKVXlQzlsRoFaSy6OAFbrUaVFfWf5D3PGY2nHDhCJFcfg==
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
Subject: [PATCH net-next v14 06/10] net: phy: phy_port: Store information about a port's upstream
Date: Mon, 20 Jul 2026 19:48:03 +0200
Message-ID: <20260720174808.139573-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720174808.139573-1-maxime.chevallier@bootlin.com>
References: <20260720174808.139573-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

MII phy_ports are not meant to be connected directly to a link partner.
They are meant to feed into some media converter devices that will
expose an MDI phy_port, so far we only support SFP modules for that.

In the case an MDI phy_port is backed by an MII port (e.g. a SFP
module's port, backed by the SFP cage port), let's keep track of the
port id of the MII port backing it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c | 27 +++++++++++++++++++++++++++
 drivers/net/phy/phylink.c    |  5 +++++
 include/linux/phy.h          |  4 ++++
 include/linux/phy_port.h     |  3 +++
 4 files changed, 39 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index f50db7405443..d52515e7e303 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1493,6 +1493,7 @@ static int phy_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	int ret;
 
 	phydev->has_sfp_mod_phy = true;
+	phy_set_upstream_port(phy, phydev->sfp_cage_port);
 
 	/* If we aren't attached to a netdev, we can't add the SFP PHY to its
 	 * topology.
@@ -1526,6 +1527,8 @@ static void phy_sfp_disconnect_phy(void *upstream, struct phy_device *phy)
 
 	if (dev)
 		phy_link_topo_del_phy(dev, phy);
+
+	phy_set_upstream_port(phy, NULL);
 }
 
 /**
@@ -1661,6 +1664,8 @@ static int phy_add_sfp_mod_port(struct phy_device *phydev)
 	 */
 	phydev->mod_port = port;
 
+	port->upstream_port = phydev->sfp_cage_port->id;
+
 	return 0;
 }
 
@@ -3696,6 +3701,28 @@ struct phy_port *phy_get_sfp_port(struct phy_device *phydev)
 }
 EXPORT_SYMBOL_GPL(phy_get_sfp_port);
 
+/**
+ * phy_set_upstream_port() - Sets the phy_port controlling the MII this PHY is
+ *			     attached to.
+ * @phydev: pointer to the PHY device we set the upstream of.
+ * @port: The phy_port upstream of this PHY, can be NULL.
+ */
+void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port)
+{
+	struct phy_port *local_port;
+
+	ASSERT_RTNL();
+
+	phydev->upstream_port = port;
+
+	phy_for_each_port(phydev, local_port)
+		if (port)
+			local_port->upstream_port = port->id;
+		else
+			local_port->upstream_port = 0;
+}
+EXPORT_SYMBOL_GPL(phy_set_upstream_port);
+
 /**
  * fwnode_mdio_find_device - Given a fwnode, find the mdio_device
  * @fwnode: pointer to the mdio_device's fwnode
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index bdb4670c25f8..5cfbfcc1079a 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -3958,6 +3958,8 @@ static int phylink_add_sfp_mod_port(struct phylink *pl)
 		}
 	}
 
+	port->upstream_port = pl->sfp_cage_port->id;
+
 	pl->mod_port = port;
 
 	return 0;
@@ -4061,6 +4063,8 @@ static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
 	phy_interface_and(phy->host_interfaces, phylink_sfp_interfaces,
 			  pl->config->supported_interfaces);
 
+	phy_set_upstream_port(phy, pl->sfp_cage_port);
+
 	/* Do the initial configuration */
 	return phylink_sfp_config_phy(pl, phy);
 }
@@ -4069,6 +4073,7 @@ static void phylink_sfp_disconnect_phy(void *upstream,
 				       struct phy_device *phydev)
 {
 	phylink_disconnect_phy(upstream);
+	phy_set_upstream_port(phydev, NULL);
 }
 
 static const struct sfp_upstream_ops sfp_phylink_ops = {
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 59903257e978..33ed10d4502a 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -597,6 +597,7 @@ struct phy_oatc14_sqi_capability {
  * @sfp_bus: SFP bus attached to this PHY's fiber port
  * @sfp_cage_port: The phy_port connected to the downstream SFP cage
  * @mod_port: phy_port representing the SFP module, if it is phy-less
+ * @upstream_port: phy_port this PHY's MII attaches to, if any
  * @attached_dev: The attached enet driver's device instance ptr
  * @adjust_link: Callback for the enet controller to respond to changes: in the
  *               link state.
@@ -791,6 +792,7 @@ struct phy_device {
 	struct sfp_bus *sfp_bus;
 	struct phy_port *sfp_cage_port;
 	struct phy_port *mod_port;
+	struct phy_port *upstream_port;
 	struct phylink *phylink;
 	struct net_device *attached_dev;
 	struct mii_timestamper *mii_ts;
@@ -2466,6 +2468,8 @@ int __phy_hwtstamp_set(struct phy_device *phydev,
 
 struct phy_port *phy_get_sfp_port(struct phy_device *phydev);
 
+void phy_set_upstream_port(struct phy_device *phydev, struct phy_port *port);
+
 /**
  * phy_module_driver() - Helper macro for registering PHY drivers
  * @__phy_drivers: array of PHY drivers to register
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 4e2a3fdd2f2e..e3a41cedebdc 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -40,6 +40,8 @@ struct phy_port_ops {
  * @head: Used by the port's parent to list ports
  * @parent_type: The type of device this port is directly connected to
  * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
+ * @upstream_port: For non-MII ports, indicates the MII port that feeds this
+ *		   port, e.g. the SFP cage port for a SFP module port.
  * @ops: Callback ops implemented by the port controller
  * @pairs: The number of  pairs this port has, 0 if not applicable
  * @mediums: Bitmask of the physical mediums this port provides access to
@@ -59,6 +61,7 @@ struct phy_port {
 	union {
 		struct phy_device *phy;
 	};
+	u32 upstream_port;
 
 	const struct phy_port_ops *ops;
 
-- 
2.55.0

