Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D237F330
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570278; cv=none; b=janrIHJqzCjHPI7g4sSo7/u40GcDjpwZa6TKWB0M7AHSdROLYjM7OaDWfs9tid5AVUPX0vtZSvOahoyOQHne1Po5NDAS0QkG2TidQ1ePXJbjM2JUoeQF35BWII7mRGDnskFZwwM7zsU+yd6xDrgQ8c9TIZsYSyfBeV3s6b38wlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570278; c=relaxed/simple;
	bh=FEsddywsvb58vGFRd3SXFOOFhOwp9wAN2Q5exWaHVkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wx5mTiKMe13w/qXpwmYRCvoBXvT+g2qfeARVXCgoqCmGxr005JSu5+9dUrNIAAf/kH79mRwb3XW3Iy0Fld6hteCR1UUme+/++OOC0At6Cup9P+Pxxd4oIMs7xAkX0dVBDZ2LqCvC5Bq6MBvC+touOohBpkpm49qOPvkxJ7Ajh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aGH8Qi6a; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aGH8Qi6a"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 212C11A1389;
	Sat,  1 Aug 2026 07:44:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E1E17603C2;
	Sat,  1 Aug 2026 07:44:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69D8E11C17000;
	Sat,  1 Aug 2026 09:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785570269; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=rfcXDYJJ5XbM/3qrxeaAUq5mUn8DqyIbgx9MpgD3GKg=;
	b=aGH8Qi6amTLNuDQfnE6w2MqAVQDqQbLa+lpL0UhDtmRn4Fs73e4g3WYqmt4iO82Vl9bX1R
	NKQ/Pwc9mgX1uAMWzruEtHKz/BKUjhWZG0yo9Xkgc0cEWsbzoq/PZA8MjIRpCwvplst5dv
	0apDskVd21ch4mT3oj0L1I30mo9OnSiU0/e2jqAocK+8L7foVEc+bAcLyPuPaFq6hDjuFk
	ERdIJYQeD1MNfKjVxZzVTjTx2LZUey32fa939YKMq60eW5BTIsp6u+saeyP1PNWXhuI/dF
	eFYkrZlhgMp8jC0hDGaLe1oNzm11jCAgJma5tCjeWY+LmDI3MT6BdXQOTumlrA==
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
Subject: [PATCH net-next v15 07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Sat,  1 Aug 2026 09:43:28 +0200
Message-ID: <20260801074332.98755-8-maxime.chevallier@bootlin.com>
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

In order to allow netlink access to phy_ports, let's add a helper to
retrieve them. When handling a port coming from phy_link_topology, the
caller must hold rtnl until it's done with it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c |  8 ++++++++
 include/linux/phy_link_topology.h   | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 5e135ab636c0..6710a199967a 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -65,6 +65,14 @@ int phy_link_topo_add_port(struct net_device *dev, struct phy_port *port)
 	struct phy_link_topology *topo;
 	int ret;
 
+	/* Ports can now be queried without rtnl for ops-locked devices, which
+	 * we don't support now as port retrieval is done under rtnl.
+	 * We don't have phy_port enabled devices yet, let's make sure
+	 * we are loudly warned about that when it happens.
+	 */
+	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
+		return -EOPNOTSUPP;
+
 	topo = phy_link_topo_get_or_alloc(dev);
 	if (IS_ERR(topo))
 		return PTR_ERR(topo);
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 296ee514ba46..9585282cae3f 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -13,6 +13,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 struct xarray;
 struct phy_device;
@@ -71,6 +72,25 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 	return NULL;
 }
 
+static inline struct phy_port *
+phy_link_topo_get_port(struct net_device *dev, u32 port_id)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	if (!topo)
+		return NULL;
+
+	/* ports in the topo are RTNL protected, but may be accessed under
+	 * netdev_lock for ops-locked devices. For now keep them under rtnl
+	 * protection, as no ops-locked devices have phy_port capabilities
+	 * yet.
+	 */
+	ASSERT_RTNL();
+
+	/* Caller must hold RTNL while handling the phy_port */
+	return xa_load(&topo->ports, port_id);
+}
+
 #else
 static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
@@ -100,6 +120,12 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
 	return NULL;
 }
+
+static inline struct phy_port *
+phy_link_topo_get_port(struct net_device *dev, u32 port_id)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __PHY_LINK_TOPOLOGY_H */
-- 
2.55.0

