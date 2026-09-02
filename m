Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652347FAF7;
	Wed,  2 Sep 2026 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384126; cv=none; b=pJF4XKb3fyixKVHd9L46ePyPJHpK+ztHO2Sb0WAEwI09bGw29VN7Ge6+oCriFarsNWHBrGOw/2wMbcPhbltLMKlE+QQ113RCrtwbmwNBUQ0/K1OSU7mII55BvpLou6a/boKVJUPQt3LgUzFxPFHyiNwI7st3XSOxxquhUdiCHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384126; c=relaxed/simple;
	bh=aR88yGXb8m+RDNegNl2bSjWZuWI9VXP9qKakepuXmC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unvu18EaviJqtP5k+MtEjENUGkRVGMetwvR/dOVHT4QOkijfWERNOWCJvVjNxtUkKiAGh+bSeoIQHpC7Dhb5Gvubboe0BA0jOXGlHM0KWeGQVoXtPH7DHQvK5Neux40CUdQmqtNKlRl5H1g4ksZbfZc3TvvC0R5FCORv2w8o4Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cN+Sjd1c; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cN+Sjd1c"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E14E64E414D3;
	Wed,  2 Sep 2026 21:21:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B41BC6053C;
	Wed,  2 Sep 2026 21:21:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 748D611C795A7;
	Wed,  2 Sep 2026 23:21:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788384114; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=i7u5vnfAW2ylLe2wo9gGWBV8lXP+ErKzRVEoEc2JJpM=;
	b=cN+Sjd1cUHLAeKGGf7NLWpdoAPs3WG6wbnznyZADbb0W8pP2i568fWlbNuNiAus4mWASdE
	3BdFv6WeHXJzRkvln4aExpLQl3OdpENALSjvPYPigMlR+2op5CBiVIVUfEzDT40CwPkeVV
	P1Yj6ekvsCydVxGGYlQJAgVF0qgrAfjMM8h1AIyCnmmSrCqSzCGKIm7aa1CalsRDTnjpYR
	iI5d5APE4A5y7tgedeInkXVACuaSe9ivd6HMP5uvGWHqK/N2f/BzXeFA72+RzN6lyX+PES
	o/6hsVpm3l3fSMi39neFRnH1mXcgCnSqcoGygRWrw6tVc/1o2mUn3mZLTucwiQ==
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
Subject: [PATCH net-next v16 01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Wed,  2 Sep 2026 23:21:25 +0200
Message-ID: <20260902212135.1805948-2-maxime.chevallier@bootlin.com>
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
index 4134de7ae313..0462283c8020 100644
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
+	 *    phylib or sfp.
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

