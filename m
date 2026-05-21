Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC33CF049
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365487; cv=none; b=E0qvrvVD76FiGpxvZm4gS/5Kig1xuFt+X5pa6tdWw32cL1/+A+4Iia3V8b7litZXRqpAhAaMJqTkPeULMAMEgh5eouJPLePyPNoAf/hnPYnXMIzv8LAi7VKKLyG0QB+CVdxerW0cnYBQj5zTHqkVGRbKB435Rb5Slx+k0PhH7z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365487; c=relaxed/simple;
	bh=gLFCN9Kq3IPLvjz/zLiPs2vJXCmEj8pJG9QTU/Cc2DA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKYuCD8XPjgILHUAgbe5Fea2BSboL5qeKjHSji3QEoAxBtfqSYzdClk2alL13e1ygC65FeluIqkrApvKTWGbY2mtOT802gi61/5dEOJh5RghSfii5I/dgIHFUriNl6lIN9lKBI9WxFyZQtKrEQ3ycQLA501zxF5xB1nZ5D6pYIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WFJ6gUca; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WFJ6gUca"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B4A914E42D0D;
	Thu, 21 May 2026 12:11:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 88DED60495;
	Thu, 21 May 2026 12:11:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DB3FC107E8B4A;
	Thu, 21 May 2026 14:11:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779365482; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=9fuOdLWcCVdn3c2ZJ20B3FaFb6ErwysOEXjn2J0AbPQ=;
	b=WFJ6gUcablM3Auufnw4UDHyZ3PxQ9HzIPCSUIreg9cFoVNQSyNbozVa6WU3b2tAoHk9HgQ
	hARKf0Zy+fdDWKu0vNqxjQ+j+LLBQhe6y7x4gvGxhaPQ2TK7U9XpmnhgMrlNKBpmYBIAvv
	spAUiT8klZ1XN8K4bAAxDUSyDYUeETx4LF/q/h9IylOv8KdpyABCJeyp0yfeMJXNyXaKaK
	PLGNRo+Ygey3K+j53H+mDDKzIZMC4K+Waq+cqAKTOJj5JMcR1MCvLj8EcND3X50ebtTBYu
	eGKakSWNvUy6nYIYgdFR+/QU/A6GYe2+fpQh+C5i3z1vN/AucYba6FVtN5sxEw==
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
Subject: [PATCH net-next v11 07/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Thu, 21 May 2026 14:10:35 +0200
Message-ID: <20260521121040.1199622-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
References: <20260521121040.1199622-1-maxime.chevallier@bootlin.com>
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
index 66bceff72b19..ac2f5c80f1a6 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -13,6 +13,7 @@
 
 #include <linux/ethtool.h>
 #include <linux/netdevice.h>
+#include <linux/rtnetlink.h>
 
 struct xarray;
 struct phy_device;
@@ -66,6 +67,20 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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
@@ -95,6 +110,12 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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

