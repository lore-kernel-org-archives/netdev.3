Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4025940757B
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537982; cv=none; b=F71vzvMbhe6CGZxi96/zGpfemFBzL5n+zXPhqXVvRlRkTm/rz+PB9GenA324E26P+KQAT9ISdrhxZKQ1CK4xknirFjY72MiWtmi9yvuCETN0BNe3Hf3ej1Xw9EPA6xCZsmPMmcLwRSSFp7t6WwDzLIA1bU3Za5h2dzzwI1ShQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537982; c=relaxed/simple;
	bh=MpiyDkp1X53C98IvLAeBokmGvdAtST/aNJy9XBCWoys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLEOWRavgFJF1RgBPIIrjyiWNYIf64pCignxRI8N21JkjPd48sCJFeu7jptE5qk2T4B+ViY5ToK/HyyDGfpQ/iTmLRE5qfAKCpVraSzyZS7bW6K24HAFgGo1gIG8cuoq+U01pMltNEm+VKkjU47Orm66wwa4b3tmVZMCYvWrCoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=llxmBf5o; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="llxmBf5o"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 244E9C51474;
	Mon, 15 Jun 2026 15:39:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EF88960015;
	Mon, 15 Jun 2026 15:39:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2C3A106C9731;
	Mon, 15 Jun 2026 17:39:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537978; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=HJSj0+hWeYwlZOA+WqPDczY1e7Nz+sg4LAnrwkSTI20=;
	b=llxmBf5oEBeXzwcoiXzX+OKJpmbUpcXDkvV9kQemUjNZEp/pzFwsVu8Q+KUEu6YePgSCc4
	ferR5B8TpRalYbyI6xO7NGn0Me20aw3ALPV4pW46tgVRfWFU7LPsNH/jrTmCNurM5NIIHX
	JJeaGo0fb4g3IRk1kbpQBoIk6EodmJ5CRUyv9EpQnb51w4eZTcwQF4NILTWHl59MN0eeNx
	szYmbGQJXGxMQ31R7s1EavokFLUz+/SyLGAZcI3HUh45RXnc8pZ4TN6knRGQlt1LmVblOE
	RnEirHlmWGL3DPwO95HIYUfPl4hGdW5CYxMHJvaFUQ3Y4gjHNdpE1z/ATvQLdA==
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
Subject: [PATCH net-next v12 07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Mon, 15 Jun 2026 17:39:03 +0200
Message-ID: <20260615153907.862987-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
References: <20260615153907.862987-1-maxime.chevallier@bootlin.com>
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

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 include/linux/phy_link_topology.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 296ee514ba46..95629112204e 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -13,6 +13,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 struct xarray;
 struct phy_device;
@@ -71,6 +72,20 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 	return NULL;
 }
 
+static inline struct phy_port *
+phy_link_topo_get_port(struct net_device *dev, u32 port_id)
+{
+	struct phy_link_topology *topo = dev->link_topo;
+
+	ASSERT_RTNL();
+
+	if (!topo)
+		return NULL;
+
+	/* Caller must hold RTNL while handling the phy_port */
+	return xa_load(&topo->ports, port_id);
+}
+
 #else
 static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
@@ -100,6 +115,12 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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
2.54.0

