Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1933448D1C;
	Mon, 20 Jul 2026 17:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569719; cv=none; b=UQ9d1jTFyhuU5yPNF6z9GViuiDTD0y9PlKjW14NiyplW/hPEPmpy3nG41bkJbJo5qOmthXH/oIuukXlMOf79ifWqnka7OoZ4FNnNed+6FMUteG3qbbn0UCvjPHcYGFXp3EXlVzhsnc3oAboFBVDKgLh6j9cLTsDKaz117NMlVH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569719; c=relaxed/simple;
	bh=ciiuwFmi2IhqAusW6jRNSMGmELJIVl8SDj0EkrVYJJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHLk6OMVR+AMbjNOOlJdvhNoyd5sQTsmf8M95AKjL4qx2nD/AlxumzN5XP+3qy3fhSa/H2bnelNvIK6G9f8O9gQAIwB6CIlt7mIOQAB4NQr8311stGuqP4oUJvu+MnLsN9zFbPpzgUVxsFNS4Q/dtPIfpzKJEnmc4kAsc0bxEK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k3xirIHc; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k3xirIHc"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F2F724E40E82;
	Mon, 20 Jul 2026 17:48:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C0A9660360;
	Mon, 20 Jul 2026 17:48:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D81C411BD2234;
	Mon, 20 Jul 2026 19:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784569704; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=XSR4AXfcggq59Amttf4xMYQ/vlxyk3YLKhyoCNzbXMs=;
	b=k3xirIHcu2MPtHpctqjA1grejaOH+krbONP3RNSc5mK/KYMeWOR4MDC7CyQULc50rx2zXR
	9nKvEkyzUp+f0y9pfrPlW+9ypvCfGkz5S+fhCZ8dC8A0pp6SphXfdUHGRhyinize+DLVNT
	PYQwxyOiZuVYI7QAqZU097WQUjyg74bwP6PH1/VRcpv9ZkOYoi7zBw5Da99LE0qhspVWZp
	DBwSQC1KcfHeC/dhZeZ85deB8eq9NZ1OLQtthG0MckjydKecihD2n5Q4IbJ1qfV+hZm5FH
	eXlPFPsqeRISfye9Hz901z0Vx8ACrO7e1vBPtKwZhOFaQEizI7YGsQeRVnc8FA==
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
Subject: [PATCH net-next v14 01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Mon, 20 Jul 2026 19:47:58 +0200
Message-ID: <20260720174808.139573-2-maxime.chevallier@bootlin.com>
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

The phy_link_topology structure stores information about the PHY-related
components connected to a net_device. It is opportunistically allocated,
when we add the first item to the topology, as this is not relevant for
all kinds of net_devices.

In preparation for the addition of phy_port tracking in the topology,
let's make a dedicated helper for that allocation sequence.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 40 +++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 4134de7ae313..dadeb8def7ea 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -28,11 +28,39 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
 	return 0;
 }
 
+static struct phy_link_topology *phy_link_topo_get_or_alloc(struct net_device *dev)
+{
+	int ret;
+
+	if (dev->link_topo)
+		return dev->link_topo;
+
+	/* The topology is allocated the first time we add an object to it.
+	 * It is freed alongside the netdev. It can be called on multiple
+	 * contexts:
+	 *  - It can be called from .probe() : No rtnl, no netdev_lock
+	 *  - .ndo_open() : rtnl and possibly netdev_lock
+	 *  - SFP state machine : rtnl held or not
+	 *
+	 *  However, we can't really have races :
+	 *  - If we have a PHY, phy_link_topo_add_phy() will always run first
+	 *    and trigger the alloc. Only then the ports can be added through
+	 *    phylib of sfp.
+	 *  - If we don't, the SFP port for the cage is registered first, and
+	 *    only then other ports/PHYs can be registered.
+	 */
+	ret = netdev_alloc_phy_link_topology(dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dev->link_topo;
+}
+
 int phy_link_topo_add_phy(struct net_device *dev,
 			  struct phy_device *phy,
 			  enum phy_upstream upt, void *upstream)
 {
-	struct phy_link_topology *topo = dev->link_topo;
+	struct phy_link_topology *topo;
 	struct phy_device_node *pdn;
 	int ret;
 
@@ -45,13 +73,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
 	if (WARN_ON_ONCE(netdev_need_ops_lock(dev)))
 		return -EOPNOTSUPP;
 
-	if (!topo) {
-		ret = netdev_alloc_phy_link_topology(dev);
-		if (ret)
-			return ret;
-
-		topo = dev->link_topo;
-	}
+	topo = phy_link_topo_get_or_alloc(dev);
+	if (IS_ERR(topo))
+		return PTR_ERR(topo);
 
 	pdn = kzalloc_obj(*pdn);
 	if (!pdn)
-- 
2.55.0

