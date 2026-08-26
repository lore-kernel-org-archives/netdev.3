Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7EE30C179;
	Wed, 26 Aug 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781852; cv=none; b=XKbvcsjosBsPc0SqaBE/03ET40yfUv9ppI+c5qXSfpIeBk3lvLG5LFA3rh7NNOTioD+b7H8QhbwOqcpUb18lHtVnL67QFvqRnRC4LuYtAgx1PyjQHcHVfjgsh+akjpOrafUbkNOlzoEidNoB0DK1gZ33IJ6iCK5hvytSKZbh7wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781852; c=relaxed/simple;
	bh=dsxIjd6Q0e0CrXowIGfKRUOS3LjNLrZrCADCS6IlyXo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BWRLNge5y8WE3ib07XWBdBjp7Tk9RUL7KKa36F4yq938pITuEtOjBkokHbDJCf0pkJIaMEXo2zn8BQtlIMwsx5b3clMZf6uHqsUuA4MJ5RXBh12jwHo/jGDhmNI0jDsOcc44msnB1Lg/UhvO18w3Z/r6f8xcRT7naBuER9jXmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=k2lcWPDW; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="k2lcWPDW"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 0DBBCE83952;
	Thu, 27 Aug 2026 00:04:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1787781840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uX5RhoTEIezrrd8ZBEpkoMRGepIbbrUgzYNYTULTvug=;
	b=k2lcWPDWyk8WigpU8a9h4eYhw3DA/y08iLuWdMip4GJGRXQH0E/qQCM8slrFRoQifa1UtW
	LBCijIhyO/1xjETp/voEiV8nM872Xn9nW/X4C7nQTZxIaIvneRyd46dIFkfCGs1hU2W7K6
	AzkhAM8vunAI3HWRRKYQpKydyRkuE3T7qj8QtTBS9f/oZHOwBlfK1BGJeWW91QJywU0AgJ
	4Ki7nILve4/yW2dMhuWW2tuxubvOygegvH7oQ+dwoqTWwTYJA6KM+PGxDeT4gppWMeDWu8
	oqitppXdxFtAeOipahFPG3s0n4Ljj/CaJOwQGRjS4koMZBeQSv579QuUtfHPnQ==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id VCb8XjK3MnMR; Thu, 27 Aug 2026 00:03:59 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-088-070-183-212.088.070.pools.vodafone-ip.de [88.70.183.212])
	by szelinsky.de (Postfix) with ESMTPSA;
	Thu, 27 Aug 2026 00:03:59 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Aleksander Jan Bajkowski <olek2@wp.pl>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v5 0/5] net: pse-pd: decouple controller lookup from MDIO probe
Date: Thu, 27 Aug 2026 00:03:39 +0200
Message-ID: <20260826220344.121865-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v5 of Corey's series [1]. It takes the PSE controller lookup out
of the MDIO probe path, so a modular PSE driver no longer makes the
PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.

Patches 1-3 are the same three notifier patches as v4 [4], unchanged,
with Jonas's Tested-by. Patches 4 and 5 are new and fix two problems the
v4 review surfaced.

Patch 4: Aleksander reported [5] that v4 deadlocks on probe for an MDIO
bus registered from ndo_init (lantiq_etop, sni_ave, netsec): those
already hold rtnl via register_netdevice(), and v4's phy attach took
rtnl again underneath. Patch 4 swaps that rtnl for a dedicated mutex, so
the register path no longer recurses. The ethtool PSE paths take the
same mutex, so the use-after-free that rtnl used to close stays closed.
Aleksander confirmed it fixes his deadlock.

Patch 5: Paolo's review [6] pointed out that patch 3 defers the
pse_control_put() to phy_device_release(). A phy that is device_del()'d
but still pinned (an attached netdev) is off the mdio_bus_type klist, so
the PSE_UNREGISTERED notifier walk never clears its phydev->psec, and the
deferred put later touches a pcdev->pi[] the controller has already
freed. Patch 5 puts phydev->psec back in phy_device_remove(), which the
mutex from patch 4 now makes safe (the rtnl recursion that motivated the
deferral is gone), so the detach is synchronous and cannot outlive the
controller.

How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
The phy layer subscribes, owns phydev->psec, and attaches the PSE handle
when the controller shows up instead of during probe. fwnode_mdio loses
its PSE awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop
is gone.

Tested on a Realtek rtl93xx PoE switch with two HS104 PSE controllers on
i2c:

 - clean boot, no probe-retry loop, no watchdog reset
 - 10G SFP+ port: module hotplug works, no deadlock
 - ethtool --set-pse enable/disable cuts and restores power to a PD
 - i2c unbind -> rmmod -> modprobe: PSE detaches on unbind and re-attaches
   on reload with power restored, no reboot. No lockdep splats.

Jonas confirmed the RTL8214FC deadlock he reported is gone. Aleksander
confirmed the lantiq_etop probe deadlock is gone.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

Changes in v5:
 - Add patch 4: replace rtnl with a dedicated mutex in the PSE attach
   path, fixing the ndo_init probe deadlock Aleksander reported [5].
   Tested-by Aleksander.
 - Add patch 5: put phydev->psec back in phy_device_remove(), closing the
   off-klist use-after-free Paolo raised [6].
 - Patches 1-3 are unchanged.

Changes in v4:
 - Add Tested-by from Jonas Jelonek. No code changes.
 - Repost now that net-next has reopened (v3 was deferred during the
   merge window).

Changes in v3:
 - Drop patch 1 (regulator handle fix); it goes to net separately [2].
 - Rebase on net-next. No code changes to the three patches.

v1 was an RFC by Corey [3].

[1] https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20260624204017.2752934-1-github@szelinsky.de/
[3] https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/
[4] https://lore.kernel.org/netdev/20260630091125.3162481-1-github@szelinsky.de/
[5] https://lore.kernel.org/netdev/bac5e6e9-7358-4ccb-87fc-9c40baa33682@wp.pl/
[6] https://lore.kernel.org/netdev/20260703071025.100797-1-pabeni@redhat.com/

Carlo Szelinsky (2):
  net: phy: use a dedicated mutex instead of rtnl for PSE control attach
  net: phy: release phydev->psec from phy_device_remove() again

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 ------
 drivers/net/phy/phy_device.c   | 186 ++++++++++++++++++++++++++++++++-
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  54 ++++++++++
 include/linux/phy.h            |   4 +
 include/linux/pse-pd/pse.h     |  41 ++++++++
 net/ethtool/pse-pd.c           |  15 ++-
 7 files changed, 292 insertions(+), 44 deletions(-)


base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.43.0

