Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F764071C0
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 15:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537962; cv=none; b=dGNzQo3u+eaac3l1DY12o2ry9YEmMUPQrwZOlpKtmQO5w/XtzyZHaOJCMBlxAcZet0LJ95NDdMDxIp20yvV5ItLrQqnMIlA+Ja4V6N4UokqwKP+oPdmDKjLG1XPijj0WXg5KiXRPfljYeyj8wxjvzB6j4zFvo156BIrPNpr3Yzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537962; c=relaxed/simple;
	bh=xKIJHq8ejqOxbfibzqJN5M463TN844802sdnQ77oeLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSCJwRS083pzsO9jOIpc8AwrMI9/H/X6YETh2ab9oACArUBFoJ+3EoUIgqOEb0AEKec+HI9Dj4VAjfES4j6DycN1f2XbXvJA8LnyfP+bd/PCaqSIjtNOVE1524giq6GyH1WiaAwXSKf0B6jkabH2nZozBOnxMS0/u7XR9IZTu3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p0dN5ZlX; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p0dN5ZlX"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 05F4FC51474;
	Mon, 15 Jun 2026 15:39:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D170460015;
	Mon, 15 Jun 2026 15:39:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 55006106C972E;
	Mon, 15 Jun 2026 17:39:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781537958; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aBVMFEq9E51//oOVWPwZ+C/7bd7DeVhNxjeNdpSWCdo=;
	b=p0dN5ZlXNytun5Ys5uCp09BgqLilwjUlFKBHQDswWr9T8dt6CUluQX0LnXDAVY+vf1I1r8
	lYJGZiHUGqJ7ObQgr+fDzw/O0pRERvnxAYeB+OzMN5hDfaJ2x0JUwi6SwMKmXjyvqnpSZu
	5pO3tfD4RA50wgqTsOYY73ULq621Xh6iVQvesfC8LxJMBArDCGZiASnKKqQSTeRWxN5azN
	CZc4q8XDaymretKT+0Ebb1AHAfrft2sKhEPRMAb1ySQ4EQCNwcpUJ20XzkgCYzVqQC3UKI
	RpRlAHAoHjPgk+6YudrRTfL7clpvbxjT2OXK9IwTEPj+EG6AHx1lIikjp5a+Rw==
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
Subject: [PATCH net-next v12 01/10] net: phy: phy_link_topology: Add a helper for opportunistic alloc
Date: Mon, 15 Jun 2026 17:38:57 +0200
Message-ID: <20260615153907.862987-2-maxime.chevallier@bootlin.com>
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

The phy_link_topology structure stores information about the PHY-related
components connected to a net_device. It is opportunistically allocated,
when we add the first item to the topology, as this is not relevant for
all kinds of net_devices.

In preparation for the addition of phy_port tracking in the topology,
let's make a dedicated helper for that allocation sequence.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy_link_topology.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
index 4134de7ae313..99f1842afcbd 100644
--- a/drivers/net/phy/phy_link_topology.c
+++ b/drivers/net/phy/phy_link_topology.c
@@ -28,11 +28,28 @@ static int netdev_alloc_phy_link_topology(struct net_device *dev)
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
+	 * It is freed alongside the netdev.
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
 
@@ -45,13 +62,9 @@ int phy_link_topo_add_phy(struct net_device *dev,
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
2.54.0

