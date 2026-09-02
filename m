Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2FD4AD7FA;
	Wed,  2 Sep 2026 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384174; cv=none; b=JwmcZ+vlWYhx6hf3HVyC0FXsB2wkpQID8sDSs7rsJyziZ5s3+lyFLRh8/G0/01D6xEQT3fDxuOLG4Yrrm4NMKXfvYn3QT2P3Iz5uUVfhtLJ06y/mI6ZjUwIp/YnHAmOspqy1mef4BRAZxgNtFrQMVZXZFKtiaQQrfXzbzX6KLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384174; c=relaxed/simple;
	bh=NJ5m18CxljZRh3SWxoKlqcAc5mDci3B2P01E7VE+SI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkfC2xOCITv9KCwmxbDsUHjEOj3qN5MYNQ95iBtbMQ0n6RCHfeTJ3N8W0dma7yYCsqg6vTHWAo554qzCeI8jtuWmdg+fpHauzNUiFXVZ5dn/+miY/Kk51cyomdx4Vk1QGrr1iKytOkICDiIaAYvvniK+qm5p6T/INpYjAmvM24E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=drp2QtP3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="drp2QtP3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7BD3C1A1968;
	Wed,  2 Sep 2026 21:22:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4ED286053C;
	Wed,  2 Sep 2026 21:22:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63B7C11C79A58;
	Wed,  2 Sep 2026 23:22:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788384159; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Adet2ZDQHwOYlmDFrolkeO1eG5L0ercG+7z6zSSzxfk=;
	b=drp2QtP33ntPn0qAO8mbHn4uFkRgfen6y01HsMmwl2ZzrDRzM6hq9zd1q1SqPMiqnEzBDW
	rSKBf6mqQ7/ajHT+rCNMhGeRY3Db0gHAm6uQCA1RGXBml+mxn/vN1+LqS8Y+2lElOg4j1f
	KILRd5aMqrJ5mnPF2p9ql8yeHSQmnkfNo9hBYiDGN7fmBzUb8+m+P1srcPtYgmlIzLeLpz
	9ccAX6yiod/sMPPuGwmEAxiusWGW8wKN7d7iCnUOhuoBAhoVSZLMzExBbBP5CZTwPqDUco
	Dree1bjmqBypmTAwDrt5JZcERY6T1FtWShWUhq+g3XnaCgTjmHQmo13G7FmbWw==
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
Subject: [PATCH net-next v16 07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Wed,  2 Sep 2026 23:21:31 +0200
Message-ID: <20260902212135.1805948-8-maxime.chevallier@bootlin.com>
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

In order to allow netlink access to phy_ports, let's add a helper to
retrieve them. When handling a port coming from phy_link_topology, the
caller must hold rtnl until it's done with it.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c |  8 ++++++++
 include/linux/phy_link_topology.h   | 26 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 91cf9c62c511..046c4c4bf815 100644
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

