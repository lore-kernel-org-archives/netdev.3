Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBE4C6EEE
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157500; cv=none; b=CJtZnPf5f1RHoWsKrHVFEscFIjFRPC4EARql3d7Qtfqd8CZSLRNsQRYUpHQ8A/JLbjh4tQjuHoRHaTbCe4GlvExMn48nKu2UwKrhAa5UzwJZAlwSvEM3wEGw+c6Wp08kZMq6+X7AfFLCWLaEYNN1l3JMkNVk27Oalyo6l3MfnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157500; c=relaxed/simple;
	bh=rdROO1dqm8j1nfcfWbKyNrDvXDIZDHklOgACo/ovQrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyL3zd5UWXSIlONnr7H5eoTslBijh6Gbq0UJNiRd/d096LlWi+yMCEAaEfytf1WLBJFojtFn2hclQ2i/+HOlgyeVRGUXNdbr25AL1ePOZaGeDp64sL5VQzjZXfDL2C/AvCxj6etCzEf0jojHqHlETy1ddD5Fj9Dfjuy7VVzSnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=en+K+48N; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="en+K+48N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7A3CE1A1257;
	Fri, 16 Oct 2026 13:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 491DD6075D;
	Fri, 16 Oct 2026 13:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD77D103281F4;
	Fri, 16 Oct 2026 15:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792157490; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=L/StY2jJU6zhIUVmsY2Dw3dGn7/Bzbj5X05uHdealzg=;
	b=en+K+48Npqv12pQa1a7yqK+l6DEiF6iH7rLJV+YCH0YAUwEMg60Wo7YrhFb1XPUqPxYd45
	JASiX+UTuBsv/LTU6VgrVKKuQ+Cknh10l5qKJbBSq8Ws3+q275By3bA23Nr+nVuA3GFW+s
	7g8gsyddcJgvXCia+R8Xhwqg5ICGS+bh+aaBahCTAvNZr2vZxSz5gCHYTtBJKRDUuMVsBo
	RUyu/dMjcuydetllDYVYPjkO/2oJEBC7NfYNvdh3TRPS9TQBbnwxouLEZraMCy2EPG1vV7
	kcBBfElzZi5+5bWls15ssfxkbd7/hCu8HImvv/qNCFcKeoNrG5HUczkamvCpmg==
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
	Aleksei Sviridkin <f@lex.la>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: [PATCH net-next v19 01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Fri, 16 Oct 2026 15:30:56 +0200
Message-ID: <20261016133107.54054-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
References: <20261016133107.54054-1-maxime.chevallier@bootlin.com>
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
Tested-by: Aleksei Sviridkin <f@lex.la>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
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
2.56.0

