Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86E36074F;
	Sun,  6 Sep 2026 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709184; cv=none; b=fSSQAoWwxt7ILz0oLkbT6Xk3ESB/drcHHLEcmiMtPqPw3ChPf7r1Bv6Wc3WOUWZANS8fFNScAeYHm2DH6H/9YJ5y696kAH/v1yO2Vb8NDOpT0J32QHS7BLFLlcItVqKD90w2l6L7e6SCBgtCqI3n/mFLIVXc0rYOrpJr0fFoM9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709184; c=relaxed/simple;
	bh=aGl8UbgF4M7weS+MGtc7GvL03A1J8QPok4slR8wkwek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aJ14rm0KcbWAoPex/6LFZSCsHnZYwS5KhDFCaQZrPe6LEE9tIf3pVaw911l7RrsdZe13857XSYyp/geMe5jD+kRc3aph98EImYEDktnKwo34jSwgTp3T+eJix6TSY4E2qYX7nhBSMPkyyllPR/ossyquXAn0Uwx0O6IwpA9L+Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=Vs7mORV3; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="Vs7mORV3"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 9F01EE8342C;
	Sun, 06 Sep 2026 17:31:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1788708697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Oq8H6Q1jKRnsexezCiaWS5vBv8CVT3geM4KV6vAmhBg=;
	b=Vs7mORV3JSvWU2NUTgu0t3CU3WJ2Yb/1VLnX3ydOdTYTw3qU7EJvTF3ThUnIh/CBomIW6y
	wemf7u9T1Ctlq75l8OlzrZZEJ04v2V7U7JjCdeLoN4OA44h67cd3knb40Diip7Rw5YaxF6
	vKE3Esh8SCgVgMr0qBOA5IYkiSc/7oJ4m65HyBgt5rVMQdkH8QJMpDYoHyudCwHZWSVRjh
	rC+R3s9kCGa9ZuX/SkeHcH2TtZGge5h2BPfJ/SWYyQD9j9aQcxnlbpaEVu7wnu4w/VvPj2
	vfrKgC0pRRf2EfykHN5WFMHIQDYuYQYazKynA0UYT9BpI4du+2ESK8a1NIR7nA==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id pjYNYdaOXwH2; Sun,  6 Sep 2026 17:31:37 +0200 (CEST)
Received: from p14sgen5.lan (p578611d6.dip0.t-ipconnect.de [87.134.17.214])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun, 06 Sep 2026 17:31:36 +0200 (CEST)
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
Subject: [PATCH net-next v6 0/5] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sun,  6 Sep 2026 17:30:57 +0200
Message-ID: <20260906153102.959217-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v6 of Corey's series [1]. It takes the PSE controller lookup out
of the MDIO probe path, so a modular PSE driver no longer makes the
PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.

Patches 1-3 are the same three notifier patches as v4 [4], unchanged,
with Jonas's Tested-by. Patches 4 and 5 fix two problems the v4 review
surfaced; v6 additionally fixes a build regression in v5 [7]'s patch 4.

Patch 4: Aleksander reported [5] that v4 deadlocks on probe for an MDIO
bus registered from ndo_init (lantiq_etop, sni_ave, netsec): those
already hold rtnl via register_netdevice(), and v4's phy attach took rtnl
again underneath. Patch 4 swaps that rtnl for a dedicated mutex, so the
register path no longer recurses. The ethtool PSE paths take the same
mutex, so the use-after-free that rtnl used to close stays closed. The
mutex lives in pse_core rather than phylib: net/ethtool is always built
into vmlinux but PHYLIB is tristate, so with CONFIG_PHYLIB=m or =n a
phylib export is unresolved (v5 failed to link there [8]); PSE_CONTROLLER
is bool, so pse_core is always reachable.

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
confirmed the lantiq_etop probe deadlock is gone at boot.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

Changes in v6:
 - Fix a build regression in v5: net/ethtool/pse-pd.c called the phylib
   export phy_pse_control_lock(), but net/ethtool is always in vmlinux
   while PHYLIB is tristate, so CONFIG_PHYLIB=m or =n failed to link. Move
   the mutex into pse_core (PSE_CONTROLLER is bool) and reach it through
   pse_phy_lock() / pse_phy_unlock(), with no-op stubs for
   !PSE_CONTROLLER. Folded into patch 4; no functional change. Reported by
   the kernel test robot [8] and by OpenWrt CI.
 - Fold phy_device_register_locked() back into phy_device_register(): with
   the attach no longer taking rtnl the two are identical.
 - Patches 1-3 unchanged.

Changes in v5:
 - Add patch 4: replace rtnl with a dedicated mutex in the PSE attach
   path, fixing the ndo_init probe deadlock Aleksander reported [5].
 - Add patch 5: put phydev->psec back in phy_device_remove(), closing the
   off-klist use-after-free Paolo raised [6].
 - Patches 1-3 unchanged.

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
[7] https://lore.kernel.org/netdev/20260826220344.121865-1-github@szelinsky.de/
[8] https://lore.kernel.org/oe-kbuild-all/202608302204.fr1FGYBF-lkp@intel.com/

Carlo Szelinsky (2):
  net: phy: use a dedicated mutex instead of rtnl for PSE control attach
  net: phy: release phydev->psec from phy_device_remove() again

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 ----------
 drivers/net/phy/phy_device.c   | 119 ++++++++++++++++++++++++++++++++-
 drivers/net/pse-pd/pse_core.c  | 100 +++++++++++++++++++++++++++
 include/linux/pse-pd/pse.h     |  64 ++++++++++++++++++
 net/ethtool/pse-pd.c           |  16 +++--
 5 files changed, 293 insertions(+), 40 deletions(-)


base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
--
2.43.0

