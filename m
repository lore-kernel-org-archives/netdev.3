Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3A3403F7;
	Tue, 30 Jun 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810706; cv=none; b=A4FmvpkfQKgssYLR7E9xXFZR3udSganybs2TmaEadHQs2TpFyjY9mK85weAaTMbxBFiIcxZtRJBiw6FWcAOu/7415kdzOISx2GMYUzNSzGuPvpPqol8Zdlx1063BBM6H14hOhNm+JNyr5UlvUXg4zZ+QCEPTqNrdPJ+FF3FC8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810706; c=relaxed/simple;
	bh=m2I3ui9jl+h7T+ME2SuFRMWmxKXznnAzoSXKovEI4mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mq8LGOiw/zUoIJth+b5GPY3qVXYSiEbEGh3+nSoBsmPmebRPcFgcNYTNBJzXHG+k8mvy7eHyRFWnKLFXBAvZuReJpbZ7Ohwx/EHP+ZGpdIKtJWmzru/vFTpVcgxrJxfI51rIZT+c9Ci+qmNfpqY7PJCXR77wO+oOPmNN8wENK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=SlFE1YsX; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="SlFE1YsX"
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 392A2E838DD;
	Tue, 30 Jun 2026 11:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782810696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYj3pWWnYbewokT99bSe2eqc2JhkrYcI7d3TPbYWIAE=;
	b=SlFE1YsXgntIBJu8j106o2Zig9FL1ns67KXHoSqX20fNqYdtAtpBzmE0f64mLEIaf5pwrp
	Zp3Sj9tF4lNuZQPg1Em/JZjWVLVcQoMgl8yUtwyo+DwrFRxtKCFcMVI1LGYWkwYZ0moSW/
	HazeBHddJdYIPGsUW7Xjz/vhD7KJh6LWVlylshBIdJ3xvjD914b5jWbQKGcrG/fw4WFDOl
	93KKY1QAXSzeY/bFZDc5GkAb4FaFFDeGES3G+IBNWG1UNtQNl0tqxHw9jU+TQklNHT/8MG
	T35IMfAE8fgKZokmlFwsl0XEDpXh6kftgJsIw4XRZbUEHHMp/MVH52A1P/ZBAw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id QaUZ56U31s8T; Tue, 30 Jun 2026 11:11:36 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 30 Jun 2026 11:11:35 +0200 (CEST)
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v4 0/3] net: pse-pd: decouple controller lookup from MDIO probe
Date: Tue, 30 Jun 2026 11:11:22 +0200
Message-ID: <20260630091125.3162481-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of Corey's series [1]. It takes the PSE controller lookup out
of the MDIO probe path, so a modular PSE driver no longer makes the
PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.

The old patch 1 (a regulator handle fix) went to net on its own [2], so
this series is just the three notifier patches for net-next.

v3 [4] was posted during the merge window and deferred; net-next has
reopened, so here it is again, now with Jonas's Tested-by.

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

Jonas confirmed the RTL8214FC deadlock he reported is gone.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

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
[4] https://lore.kernel.org/netdev/20260626165929.2908782-1-github@szelinsky.de/

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 -------
 drivers/net/phy/phy_device.c   | 168 +++++++++++++++++++++++++++++++--
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  54 +++++++++++
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |  41 ++++++++
 6 files changed, 258 insertions(+), 43 deletions(-)


base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.43.0

