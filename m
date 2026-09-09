Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0E471429;
	Wed,  9 Sep 2026 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946777; cv=none; b=CXGoZ3QksaZgX7xekvtYIyhYW2o6GHZkkPg8buA0VL09jPtjGSifbEXVXkWuczyhJF5tCrOXpWQJzRvMU30BNKqVbW/w3EGKa3YbDlHq1FBg4xHiTt2ev275k2bxv2gozp8ItJjt599MfXTTA2cYi0zPqCuJ9gCGICo1Y+aoO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946777; c=relaxed/simple;
	bh=aR88yGXb8m+RDNegNl2bSjWZuWI9VXP9qKakepuXmC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SmBvxLQ8wGo9Vwvj76iR+Pzxg13HiXTJLTmcVcTV9/ecKmCaHUuQxKr++au82e6IXZevxfu5L9XLSbK5+7FQbGeNSdsSfBERnoAd6oQJGny2dxELEIl134909jWmFxPjCZoBFWIOfwMb/WTS6ndGZRi5mdbnItYguZJNf1O1neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pGazbO1g; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pGazbO1g"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 3FA244E415AE;
	Wed,  9 Sep 2026 09:39:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0B1A760448;
	Wed,  9 Sep 2026 09:39:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FA4611C7AF2B;
	Wed,  9 Sep 2026 11:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788946766; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=i7u5vnfAW2ylLe2wo9gGWBV8lXP+ErKzRVEoEc2JJpM=;
	b=pGazbO1gViwJ1Eii3S+Y/heW/lPiWbIxCLiVZGXWZbFnEmxQNr6/M6RiU5qB7aAfOxDoRj
	njRkv9Q9EJEWhVyiAoyA7UzLSHd7hhvFTPCudsF6XOmDGQbqrC1VU6qAJosMos4cpX2Reo
	l/vizLvbjB9svhDMcZgwGdyKnVTH1yKhI0AN3rT8jAfUT1Ilg/FY1IKGtRJRRAtGRXcxBe
	E/oT4TwfXf28iT2n++NMmspypXzbbBcQl5eaWptswhZURSDPWy432ngLEPJ8+Ho7KgQWCl
	SXNDHLYc5jDdDX/2V0H2O1cO3KTCPriMzXb8hxOFscFdRbE7EfxpnC8+K1T3Vg==
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
Subject: [PATCH net-next v17 01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Wed,  9 Sep 2026 11:39:02 +0200
Message-ID: <20260909093912.1290810-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
References: <20260909093912.1290810-1-maxime.chevallier@bootlin.com>
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

