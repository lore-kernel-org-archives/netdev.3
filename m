Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D12DC76A
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778677539; cv=none; b=ZnTTq80abwQOnvAwimpy0HG2rjTRRLR9DwhxlpIYObfbwjSuQm9CcwI3BKRlNuvMCjmz9+UignoDVZDJdg1xg++75jo1I/fkFS/qwJoMdyBM/ZSI9W1DV60dvUCoO48dmN72QvKP3x2aNOF6S7l22ub3W2prA3j/v1nZ8UDyswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778677539; c=relaxed/simple;
	bh=l8NczPa43yS/6tBefUueW9IlAZFxY5SZCzrMzwIPRe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHLOnaf1r6FU3o3wA0wIJgeACYxty0Hd/nKmZdIbRLeb87TH/h4DfOsXeovaZ5K5lc5uRXu3Qxc5h+sAwxYixgSIViMMIGY+b6Ja5wQ7DaprxY2bXuoSthy9aXD6++8rS5yZjchan2Qkb2QLjiZk7nrphmkdOEoUeqyWQ0qQGOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=F5CIj+dH; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="F5CIj+dH"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 70867C5DC59;
	Wed, 13 May 2026 13:06:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F385D5FE21;
	Wed, 13 May 2026 13:05:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 49E4211AF9020;
	Wed, 13 May 2026 15:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778677534; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=iDrFY++dpbdQdiBh3NKEHCP1w+8w0rfF1YOH7RIKWZg=;
	b=F5CIj+dHyChZeSXFG2ceVTrhdSqaqzIf33DAXeHONxu3CUww56H50N9z0A2rocT/MSuOCO
	Do2VbeRcDShWoXQAH+gthpXft8NWpzYAy8h7+Y5YndgtMkf3jZp8waijzZbVLe/lcigniW
	bBLiUzZbAdZq5CWLbMoTwclo2B1Xb7HSYCRIWjAwo6WDewrl82z+lcBVfAZLVuRGaKG2ru
	pNrS3wo8hOeeoNokHOPoIVacQNOcrCVBx01uYzAJlmY2Az721yEfPfMtBSnj61enJFrxU6
	jRWS58UvvdjgEDND/J9EyR527J9ZEazz1G2BA9TfdBtQM+RKtVLDrD+FzDy7IA==
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
Subject: [PATCH net-next v10 2/9] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Wed, 13 May 2026 15:05:13 +0200
Message-ID: <20260513130521.1064094-3-maxime.chevallier@bootlin.com>
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

phy_port is aimed at representing the various physical interfaces of a
net_device. They can be controlled by various components in the link,
such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.

Let's therefore make so we keep track of all the ports connected to a
netdev in phy_link_topology. The only ports added for now are phy-driven
ports.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 53 +++++++++++++++++++++++++++++
 include/linux/phy_link_topology.h   | 18 ++++++++++
 include/linux/phy_port.h            |  2 ++
 net/core/dev.c                      |  1 +
 4 files changed, 74 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index fdfafd951905..207128303ca2 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
@@ -22,6 +23,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
 	topo->next_phy_index = 1;
 
+	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
+	topo->next_port_index = 1;
+
 	dev->link_topo = topo;
 
 	return 0;
@@ -44,12 +48,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
 	return dev->link_topo;
 }
 
+int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
+{
+	struct phy_link_topology *topo;
+	int ret;
+
+	topo = phy_link_topo_get_or_alloc(dev);
+	if (IS_ERR(topo))
+		return PTR_ERR(topo);
+
+	/* Attempt to re-use a previously allocated port_id */
+	if (port->id)
+		ret = xa_insert(&topo->ports, port->id, port, GFP_KERNEL);
+	else
+		ret = xa_alloc_cyclic(&topo->ports, &port->id, port,
+				      xa_limit_32b, &topo->next_port_index,
+				      GFP_KERNEL);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_add_port);
+
+void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	if (!topo)
+		return;
+
+	xa_erase(&topo->ports, port->id);
+}
+EXPORT_SYMBOL_GPL(phy_link_topo_del_port);
+
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
 {
 	struct phy_link_topology *topo;
 	struct phy_device_node *pdn;
+	struct phy_port *port;
 	int ret;
 
 	topo = phy_link_topo_get_or_alloc(dev);
@@ -89,8 +126,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	if (ret < 0)
 		goto err;
 
+	/* Add all the PHY's ports to the topology */
+	list_for_each_entry(port, &phy->ports, head) {
+		ret = phy_link_topo_add_port(dev, port);
+		if (ret)
+			goto del_ports;
+	}
+
 	return 0;
 
+del_ports:
+	list_for_each_entry_continue_reverse(port, &phy->ports, head)
+		phy_link_topo_del_port(dev, port);
+
+	xa_erase(&topo->phys, phy->phyindex);
 err:
 	kfree(pdn);
 	return ret;
@@ -102,10 +151,14 @@ void phy_link_topo_del_phy(struct net_device *dev,
 {
 	struct phy_link_topology *topo = dev->link_topo;
 	struct phy_device_node *pdn;
+	struct phy_port *port;
 
 	if (!topo)
 		return;
 
+	list_for_each_entry(port, &phy->ports, head)
+		phy_link_topo_del_port(dev, port);
+
 	pdn = xa_erase(&topo->phys, phy->phyindex);
 
 	/* We delete the PHY from the topology, however we don't re-set the
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 68a59e25821c..66bceff72b19 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -16,11 +16,15 @@
 
 struct xarray;
 struct phy_device;
+struct phy_port;
 struct sfp_bus;
 
 struct phy_link_topology {
 	struct xarray phys;
 	u32 next_phy_index;
+
+	struct xarray ports;
+	u32 next_port_index;
 };
 
 struct phy_device_node {
@@ -43,6 +47,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 
 void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
 
+int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port);
+void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port);
+
 static inline struct phy_device *
 phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
@@ -72,6 +79,17 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
 {
 }
 
+static inline int phy_link_topo_add_port(struct net_device *dev,
+					 struct phy_port *port)
+{
+	return 0;
+}
+
+static inline void phy_link_topo_del_port(struct net_device *dev,
+					  struct phy_port *port)
+{
+}
+
 static inline struct phy_device *
 phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
diff --git a/include/linux/phy_port.h b/include/linux/phy_port.h
index 0ef0f5ce4709..4e2a3fdd2f2e 100644
--- a/include/linux/phy_port.h
+++ b/include/linux/phy_port.h
@@ -36,6 +36,7 @@ struct phy_port_ops {
 /**
  * struct phy_port - A representation of a network device physical interface
  *
+ * @id: Unique identifier for the port within the topology
  * @head: Used by the port's parent to list ports
  * @parent_type: The type of device this port is directly connected to
  * @phy: If the parent is PHY_PORT_PHYDEV, the PHY controlling that port
@@ -52,6 +53,7 @@ struct phy_port_ops {
  * @is_sfp: Indicates if this port drives an SFP cage.
  */
 struct phy_port {
+	u32 id;
 	struct list_head head;
 	enum phy_port_parent parent_type;
 	union {
diff --git a/net/core/dev.c b/net/core/dev.c
index b0691e03dd6b..efb29f5c0261 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11303,6 +11303,7 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 
 	if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
 		xa_destroy(&topo->phys);
+		xa_destroy(&topo->ports);
 		kfree(topo);
 		dev->link_topo = NULL;
 	}
-- 
2.54.0

