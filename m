Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900844CA776;
	Fri, 16 Oct 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157508; cv=none; b=PWHDHVg24wKXF/9Aupsnk1QwGWDO5VqmLZM3dN0JLtbmyuSugf/G43fym8jaK2okhU5tGNh5apACl1dcGjK1JpU12LKS1rMa9yLiw2Qwmi2TA5ODSSvQAU5g/W3FOD7hAiaNTVsQBx4e7AUi2s6wKEXYCtauaNIJf329rOkuJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157508; c=relaxed/simple;
	bh=RFKoY0GHkaz+q6FORW6FDpDsXIvrRbkA5I5DKBoyxi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3GtZX5BBRxCe0+SxYslqk/XX/uoVoqL2c4HdA7cl6TlNru0KFoCfPRBaFGnuqgB1NhwRnIL1ohEWCU30zel5HRZFcf/+WbruGRYrFVAw9suaEMtd/JqlmI10UZ6l5R6sxLbvsWT9tuFCMCQOWJQWp7pX9WrqBc68HWVHXCQyKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JCMof6T7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JCMof6T7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 085B81A1255;
	Fri, 16 Oct 2026 13:31:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D061A6075D;
	Fri, 16 Oct 2026 13:31:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBA4310328719;
	Fri, 16 Oct 2026 15:31:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792157498; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HrjEOO5rfClXaxaKLa3WLZD6Iz9++rpCTI/hmnIhsZk=;
	b=JCMof6T7YfC+0d4193ahdA8/JTCP/WOIFbaZuGxD282G/J6DyHQoEnbgWsHVuUemaMyb9G
	FbC4gzIVxdOzbw+24w17clL7B1aWtXDD0RJqTrG4EgTEgtIZ5tPSyY8N0YrLJILZKipvJ8
	lNaUF68YckdJ/6Aefb1+VWd8FpIVo17fiSRS1ynP2cinO3vuEQjTccPU3wW0Y7KYs5PXiz
	++PsizMW6ZOaB3TnImjMHp9RF1+8St0JJulOZl5JZeRQ8Xkc96zsGoIgjVM/VMT/fLq/mM
	MVlrHUMByp9rN4QLrz+8LhyIF/H1z6Nc2dvi1cocdkogq87UdATB5qf2OCHD6Q==
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
Subject: [PATCH net-next v19 02/10] net: phy: phy_link_topology: Track ports in phy_link_topology
Date: Fri, 16 Oct 2026 15:30:57 +0200
Message-ID: <20261016133107.54054-3-maxime.chevallier@bootlin.com>
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

phy_port is aimed at representing the various physical interfaces of a
net_device. They can be controlled by various components in the link,
such as the Ethernet PHY, the Ethernet MAC, and SFP module, etc.

Let's therefore make so we keep track of all the ports connected to a
netdev in phy_link_topology. The only ports added for now are phy-driven
ports.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Aleksei Sviridkin <f@lex.la>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_device.c        |  3 ++
 drivers/net/phy/phy_link_topology.c | 53 +++++++++++++++++++++++++++++
 include/linux/phy_link_topology.h   | 18 ++++++++++
 include/linux/phy_port.h            |  2 ++
 net/core/dev.c                      |  1 +
 5 files changed, 77 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bfce8b893644..ab1aa8981c00 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1580,6 +1580,9 @@ static void phy_del_port(struct phy_device *phydev, struct phy_port *port)
 
 	list_del(&port->head);
 
+	if (phydev->attached_dev)
+		phy_link_topo_del_port(phydev->attached_dev, port);
+
 	phydev->n_ports--;
 }
 
diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 0462283c8020..28c5bf3a8849 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/phy_link_topology.h>
+#include <linux/phy_port.h>
 #include <linux/phy.h>
 #include <linux/rtnetlink.h>
 #include <linux/xarray.h>
@@ -23,6 +24,9 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	xa_init_flags(&topo->phys, XA_FLAGS_ALLOC1);
 	topo->next_phy_index = 1;
 
+	xa_init_flags(&topo->ports, XA_FLAGS_ALLOC1);
+	topo->next_port_index = 1;
+
 	dev->link_topo = topo;
 
 	return 0;
@@ -56,12 +60,45 @@ static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *d
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
+	return ret < 0 ? ret : 0;
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
 
 	/* ethtool ops may run without rtnl_lock, and rtnl_lock is what
@@ -110,8 +147,20 @@ int phy_link_topo_add_phy(struct net_device *dev,
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
@@ -123,10 +172,14 @@ void phy_link_topo_del_phy(struct net_device *dev,
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
index 95575f68d5bc..296ee514ba46 100644
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
@@ -48,6 +52,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 
 void phy_link_topo_del_phy(struct net_device *dev, struct phy_device *phy);
 
+int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port);
+void phy_link_topo_del_port(struct net_device *dev, struct phy_port *port);
+
 static inline struct phy_device *
 phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
@@ -77,6 +84,17 @@ static inline void phy_link_topo_del_phy(struct net_device *dev,
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
index 8eb9bf1ff9eb..1a09e7869118 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11521,6 +11521,7 @@ static void netdev_free_phy_link_topology(struct net_device *dev)
 
 	if (IS_ENABLED(CONFIG_PHYLIB) && topo) {
 		xa_destroy(&topo->phys);
+		xa_destroy(&topo->ports);
 		kfree(topo);
 		dev->link_topo = NULL;
 	}
-- 
2.56.0

