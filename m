Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898035DD1E;
	Tue, 27 Jan 2026 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521366; cv=none; b=CEWZnV9FqIlKjrdNx3Pbf/+PtFIK5bN2822U4Rp+k7bU8llcxHFmhvBzfYcnhRo0pBCmn8dlnFQlMxx5JCUrFEPmOobhlhtH/LpnIFKnGxuwTaEKQGh9GHMba/S2m0cfhEWuB/jky0SveuZzjlGLZBOs3+/rN0OQ7hPBIsmulsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521366; c=relaxed/simple;
	bh=1JTSbK0lXDa0qB/bu/313wVupHvb21M0el6GgWLuhnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxTkEJk3DJF3Ji/i4M6IdEvd63zB2K/M5WMZXqye+kj4uslc1jaV4wvpGjpJJEoa6nkwTw5xhhGmzb+P7juuw4vxIqiak3dDnPypR3f5lr2hYchZX6r3S68RkWjZ9zZrph1Fl3ZcoUlbFiEZe0U6ekwhk+oMkV1+4idBlJBRYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ArI5rSTL; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ArI5rSTL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E4614C211C0;
	Tue, 27 Jan 2026 13:42:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D2332606F5;
	Tue, 27 Jan 2026 13:42:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A262E119A8693;
	Tue, 27 Jan 2026 14:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769521362; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=LQ1Qarsz5LhrrgmIa0E4ThARGgHfTWIRhhaAwOPHPVc=;
	b=ArI5rSTL8u1CXuhSFn1Vc+bblrnAn5ZdQ81oJKOWrg2FkBxjQOH5n6VDS1vcU7EtecscE6
	sb1jfafFofxPyTSb4fPV010sLE17XmrXyymfIrIvwrCJM+5Q2yyif9DJGZBOQK0cNTvOoa
	316Rv7FCIJVyFZp349jUXT7KyexRzSWVBMWRoloj5mst96Eun/zgCNhyOmBXpHHwXNFrnP
	op4nMmdjMFoe72jumafSTAFGhcyCgDa+59kbzA5si8g6g20FzowEZovMykOeMdxvSGHSOd
	PE2J6O8ceyiszelx55QiAgNj7E9yRyXhpoBqWCqKPkBCJ7yJcBoHnDnS3uNgyw==
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
Subject: [PATCH net-next 10/13] net: phy: phy_link_topology: Add a helper to retrieve ports
Date: Tue, 27 Jan 2026 14:41:58 +0100
Message-ID: <20260127134202.8208-11-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
References: <20260127134202.8208-1-maxime.chevallier@bootlin.com>
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
 include/linux/phy_link_topology.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/phy_link_topology.h b/include/linux/phy_link_topology.h
index 66bceff72b19..d5f8f20c5d32 100644
--- a/include/linux/phy_link_topology.h
+++ b/include/linux/phy_link_topology.h
@@ -66,6 +66,17 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
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
+	return xa_load(&topo->ports, port_id);
+}
+
 #else
 static inline int phy_link_topo_add_phy(struct net_device *dev,
 					struct phy_device *phy,
@@ -95,6 +106,11 @@ phy_link_topo_get_phy(struct net_device *dev, u32 phyindex)
 {
 	return NULL;
 }
+
+phy_link_topo_get_port(struct net_device *dev, u32 port_id)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __PHY_LINK_TOPOLOGY_H */
-- 
2.49.0

