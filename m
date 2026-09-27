Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59743F12D8
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790516230; cv=none; b=IveUqlmWjsfwsK3paaTqCXycyRotFaPFLfCqzLBFTxqw5nSS1fDwNw49bVcgS8kMhwcNiwdSRog8Ly6Gl1y+RrUp0TprDSUtY1rlNzaMfVsnZdNgqG92yyKlIrrsQoITmn5FCUEN2MRTVO0AIBmeP9fHcoHQZCUrJhh54frfFfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790516230; c=relaxed/simple;
	bh=EBW9JDcIIUnZNsgR8ZYwAVVS23O5RWhwgNyBXsRw/oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASzbMGDdCTnie09QMyTtFF8R6BNdoNkULfwdY1WZ5EfNAgO3S8DueYQfNpGrauFXlBO/C/RYL/FSNko/4c5OiMVzFq9aY268I5ROqReK1o9CUlykdsQNVpBM0hN9Kjskx5nzm5smjH6Z7BtJG69DQTr2we9N/W64aXhuxdsOB1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fZpEoAt4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fZpEoAt4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4CE8B4E40ECD;
	Sun, 27 Sep 2026 13:37:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1EA6F604FF;
	Sun, 27 Sep 2026 13:37:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 851CC102F1E7D;
	Sun, 27 Sep 2026 15:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790516225; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=DRWG5dVl16McE/UB+GcT6u4bht/KXV2eLnoJ83MZf1I=;
	b=fZpEoAt4ORkOltXk1qs6XVCT3le9ciGYM107SLxi+fzoaeealnBjqKgTSF86m4WR5WiCDK
	WaJIq0PJR7d5tN+s6+085TlXpmVQCP2m9PCNfF6ssSo4On9MRmS4Q44B5ILMTvFSEtVkxT
	agLaxtCyPqfUzUTltpz2wTPXfGLgNbLhTaa5ENJI8fFgZaDp5+YbumJZFB3mm/Hb3SyfCj
	uYaN+cyZQ9prBVEQ6NjTg3y67TG6fig4BmQeYMNoUAN26YB6RGmojkAd/mHgHwqcRQZWfi
	FjJIDbnFuoWrQNOayGtOlEPR960++NR/je9jKFJdGdZ4Mw1LrcT2tbR0x8QT+Q==
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
Subject: [PATCH net-next v18 07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Sun, 27 Sep 2026 15:36:16 +0200
Message-ID: <20260927133619.955236-8-maxime.chevallier@bootlin.com>
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

In order to allow netlink access to phy_ports, let's add a helper to
retrieve them. When handling a port coming from phy_link_topology, the
caller must hold rtnl until it's done with it.

We don't really support PHY and phy_port operation on ops-locked devices
yet, warn when we try to do so on such an interface.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Aleksei Sviridkin <f@lex.la>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c |  8 ++++++++
 include/linux/phy_link_topology.h   | 25 +++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 28c5bf3a8849..214ccce23cf6 100644
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
+	if (WARN_ON_ONCE(dev->netdev_ops && netdev_need_ops_lock(dev)))
+		return -EOPNOTSUPP;
+
 	topo = phy_link_topo_get_or_alloc(dev);
 	if (IS_ERR(topo))
 		return PTR_ERR(topo);
diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 296ee514ba46..f2e493c433ff 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -13,6 +13,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 struct xarray;
 struct phy_device;
@@ -71,6 +72,24 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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
+	return xa_load(&topo->ports, port_id);
+}
+
 #else
 static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
@@ -100,6 +119,12 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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

