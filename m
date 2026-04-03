Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F93A5439
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 12:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775219915; cv=none; b=K/DsOljSTMwf4Qj7qm09mqVZmh6p0O2ceVo2gAIXjtOkW8+AITa1dnptnNyic50G+90uqT3pxjkHj7C3ER4ARZ+wJNjwSOSY6qoT9A9zsV2XSEfxfaxLsxhCp9aBpUK4JDr+JhSBA3i+qpR4cqWhsN15FU1F1VkCLdf39rQ2tlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775219915; c=relaxed/simple;
	bh=f0/3/mrCPrJHqIVyCbu48EYwHwbuoZwmfW42AbHjWH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkUouZ8aR8WYafTbmKPXYp4hdKHqJwTWt+SpvvAKtEyxC1TlAmn9H0zFavGbQH+qMKG12rZHr5IfwqPejj/ml9/2FY7BitO0a8qm7l1vA3Psy5j7PnEnLjzAbdMWVA/OajgIDIt3+yEvV+gnWUwYjmF99aUYWwS+tLKJTtwqoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I2UkX1nU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I2UkX1nU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 17E761A3128;
	Fri,  3 Apr 2026 12:38:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E0DD8603C1;
	Fri,  3 Apr 2026 12:38:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7FBD3104500CB;
	Fri,  3 Apr 2026 14:38:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775219911; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=oE3YHgEOb7zMldz7W5UEO4lNk/cteuFmDnyVlbi0dJs=;
	b=I2UkX1nU6KTvhTdO9ayvHpZRvFOjsdcaWvymZrlrOdan8NFmruiDX0ifSwpg/99vSMMUHv
	vCnSm2ZrYi5yUv7uDNommeScMYmdt3Zwa+mLJsA4DRm2z3bDHA85+Hfu6ie5x/RDj7SFZH
	HQCB4hCeHR/QSst6blqFLCIpGC6t/sfrgVpUaumLL8g9qn9l7MH7prULL386o37ACg9w+g
	XkhAQZQk8NKA6QWmYICRbMKRjbLmY06cBPOnMDBbHBdEqewrUDo+FSLtq7P4dJwv39qe6Y
	sA+g+fe4cff68m/zfh85tSBKy66dqH8K3xrsdelsEtWZ0URvKVn0kv/jg5+udQ==
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
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Subject: [PATCH net-next v9 08/10] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Fri,  3 Apr 2026 14:37:52 +0200
Message-ID: <20260403123755.175742-9-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
References: <20260403123755.175742-1-maxime.chevallier@bootlin.com>
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
2.49.0

