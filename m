Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51E385D97;
	Fri, 18 Sep 2026 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741993; cv=none; b=i0OAL5UnUdTLI50GRXFOF9VhSWO6z/Gr59lK2vzNCLOyNzXA1b888W/+Spn9gZCXD25tThFih4GC/onIXH4jvGumm+C0BsPctUXSGbM8IKFzoTudKMXslSlusmZ54LrovANPLVOzgqwQlimAfewb4K/vSlZamcAJ4s/1jdeCIug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741993; c=relaxed/simple;
	bh=Exv/yeEofEFRA2/+sHId8lKouBXG84ImNPAWx0i4UnI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tAmiorfEaBOSM8lZsOKxOrNfbQBcwpwLLxxEDORBXY6Wt7Zp9hSmr/epMEtER1VxY27/RRZtVixbOq/pzSxJ7FPdG9PVsq44MTHRp8AZAUEPjCoJAfNlS7M67F2SKqL9co6Qe7MokgAQSsQPlPYpaTl/o4dpq3LGZe/RKcVlpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ShAprVe+; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ShAprVe+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789741992; x=1821277992;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Exv/yeEofEFRA2/+sHId8lKouBXG84ImNPAWx0i4UnI=;
  b=ShAprVe+803nGWg5Oxv5SGZPw50+dMdDBJH5yogHb9CMVZFnU8c0Yl+W
   OzWuDntg4fR9IjdysRZi7G8cT8V3HLOwCjH1PfnO3PqQMQ/IQ3qpa0UkY
   4ZdVa/CEv3W8Zc2FwfGy+grnARcSPE7OsiFwwBWksj6WM4ISd7mWfe/WA
   2uFkeZLG3t46diWq6TTFW8E6+Hm8eVe2CuV1eoODiOqpk5hSeLdWX3UXI
   d7ptPmIHM51dUWIwZO7qwpvVV9I0kAylPcFpJUp63/JjqT9MJ60MlV8wu
   jM10KknLy9FVAVp7AfHzgQf0i3Oi1eYYwf9uZYVRLb5HPmw3LL/VJ1dFq
   g==;
X-CSE-ConnectionGUID: +WvFQnlfSruB6SEpUOv/mw==
X-CSE-MsgGUID: 5DQToxvdTiWgTePzFzPMoQ==
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; 
   d="scan'208";a="63811288"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 07:33:11 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Fri, 18 Sep 2026 07:33:10 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 18 Sep 2026 07:33:06 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v3 0/4] net: microchip_t1s: fix collision detection on PLCA status change
Date: Fri, 18 Sep 2026 20:02:58 +0530
Message-ID: <20260918143302.76909-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain


In a 10BASE-T1S multidrop network, the PHY autonomously transitions
between PLCA mode and CSMA/CD mode based on BEACON availability. The
existing collision detection logic only adjusted on explicit ethtool
PLCA changes, leaving it in the wrong state across these autonomous
transitions.

This series fixes that gap, wires up the full interrupt path, and
improves collision detection for LAN867X Rev.D0.

Patch 1 adds a PLCA Status Changed (PSTC) interrupt handler for LAN86XX
PHYs that dynamically enables/disables collision detection based on live
PLCA status. The static CDEN write in lan86xx_plca_set_cfg() is kept as
a baseline for PHYs without a routed interrupt.

Patch 2 delivers the in-band PHY interrupt from the OA TC6 MAC-PHY SPI
driver to phylib as a nested virtual IRQ, gated by a new OA_TC6_PHY_INT
quirk flag. This lets phylib drive the PHY driver's
config_intr/handle_interrupt callbacks for PHYs with no dedicated
interrupt line.

Patch 3 enables this virtual IRQ path for LAN865X, whose internal PHY
has no dedicated interrupt line and relies entirely on the MAC-PHY SPI
interface for interrupt delivery.

Patch 4 fixes collision detection for LAN867X Rev.D0 using its hardware
CCMFC field, which gates collision forwarding to the MAC based on live
PLCA_Status directly, removing the software CDEN toggling delay present
on older revisions. It also accounts for Rev.D0's autonomous PLCA-to-
CSMA/CD fallback (PRSCTL1), so the link status selection stays correct
whether or not that fallback is configured.

Note: Patches 1 and 3 both carry Fixes: 78341049fbcd. Patch 3 is
required for the fix to take effect on LAN865X - without it,
phydev->irq stays PHY_POLL and patch 1's interrupt handler never runs
for that device. Patch 2 is a required prerequisite for patch 3 but
fixes no bug on its own, so it carries no Fixes: tag. Please apply all
three together.

Changes in v3:
Addresses Sashiko AI review feedback on v2.
- Patch 1: Synchronize CDEN with live PLCA status before unmasking
  PSTCM, closing a window where a status change could be silently
  dropped. Use phy_interrupt_is_valid() instead of testing PHY_POLL
  alone. Treat plca_cfg->enabled as tri-state so an ethtool call that
  omits the enable attribute no longer disables collision detection.
  Factor shared STS1/IMSK1 sequences into helpers reused by patch 4.
- Patch 2: Replace dummy_irq_chip with a proper irq_chip implementing
  mask/unmask via bus_lock/bus_sync_unlock, closing an interrupt-storm
  risk. Select IRQ_DOMAIN in Kconfig. Defer PHY interrupt dispatch to a
  workqueue so the chunk-processing thread stays independent of
  phydev->lock.
- Patch 3: Add Fixes: 78341049fbcd, since this patch is required for
  the fix to take effect on LAN865X. Document that CDEN correctness
  relies on the hardware reset default.
- Patch 4: Give Rev.D0 its own config_intr() instead of branching
  inside the shared one, so CCMFC-owned CDEN can never be touched by
  the shared resync. Skip link-status updates when enabled == -1.
  Correct the AN1760 -> AN1699 reference. Resync Rev.D0 link status on
  interrupt (re-)enable, closing the same dropped-edge window as patch
  1. Account for Rev.D0's autonomous PLCA-to-CSMA/CD fallback
  (PRSCTL1): force semaphore mode when that fallback is enabled, since
  PLCA_Status is meaningless once the PHY has already fallen back.

Changes in v2:
- Patch 2: Introduce OA_TC6_PHY_INT quirk flag to guard the virtual IRQ
  infrastructure; PHYINT is optional per the OA TC6 standard. Move
  oa_tc6_phy_irq_setup()/oa_tc6_phy_irq_teardown() into
  oa_tc6_mdiobus_register()/oa_tc6_mdiobus_unregister(). Populate all
  mii_bus->irq[] entries with the virtual IRQ before mdiobus_register()
  so phy_device_create() picks it up regardless of the PHY's MDIO
  address, keeping mii_bus->irq[] and phydev->irq consistent.
- Patch 3 (new): Pass OA_TC6_PHY_INT quirk flag from the LAN865X driver
  to enable the virtual IRQ infrastructure for LAN865X.


Parthiban Veerasooran (4):
  net: phy: microchip_t1s: fix collision detection on PLCA status change
  net: ethernet: oa_tc6: deliver the PHY interrupt to phylib
  microchip: lan865x: enable PHY interrupt via virtual IRQ
  net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0

 drivers/net/ethernet/Kconfig                  |   1 +
 .../net/ethernet/microchip/lan865x/lan865x.c  |   4 +-
 drivers/net/ethernet/oa_tc6.c                 | 145 ++++++++
 drivers/net/phy/microchip_t1s.c               | 309 +++++++++++++++++-
 include/linux/oa_tc6.h                        |   3 +
 5 files changed, 454 insertions(+), 8 deletions(-)


base-commit: 4bb9710c6a68d35207f123aef55dcd50e7195ec5
-- 
2.43.0

