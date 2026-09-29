Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F83C1D48;
	Tue, 29 Sep 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686781; cv=none; b=CILyapv6yr5xYuS5mvC1D6zRVhTB4OE94pcgW4C/DZ3HRPo7mTLytjFW8huu7C/cINBLtRZWYeVSCbBYGjR2Cv7zIi+xRVMv1e6SPkom6Lm2m7CWMLhJ4jWcaIq1mAcqZsmusoHu0jFZOSCJh4alfgMh5kHEtkchuRbR+o01yoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686781; c=relaxed/simple;
	bh=uoNHIDxXmy04/NmkSnzkRIlCasd9BAyZ+rJgLus+txQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ol0ANX7cwyazYxZi0d2gz4meJvpcJhtfk+nI36kyGGkheJr0A0uCIKAYkG5XYLRvf9TmYOHOf7yo+r8toRAFmRmHNJOwYuhNSr99kKLut+PZ5juTz1eB+mp/xGAOsK/X+ymDoVfFfJYfWJSo5w18T8zG6O6nLlPocrExSTtZ+1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zHXxClmc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zHXxClmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1790686779; x=1822222779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uoNHIDxXmy04/NmkSnzkRIlCasd9BAyZ+rJgLus+txQ=;
  b=zHXxClmcIu6XByJ+jl/5PndtDT9QbpS/7jJdSZOJLSUx/WtrbX1HGHtG
   QsfNuKQt7ECC/PVsdEw/nv6yiAAw1gS4a3beolF//nlUTW4m/+7EZ5NBX
   o6sWedSXgMtdkFAhVRPGsXsgoh6JOyCPoZry4Ofa91RsMh+WxvuRN1Ps+
   58ohCi4eG2ZEOqiaGGOeHMUIGhFiPF/NayUZhOvylaYBdh4rPokRWC3lz
   GbAH4S8ADTEc9CF7+oNmnGsZQejnA4PzUlFJgjvG6dwOk8Zc7wIQkhxio
   lZGqo/CQV7XA3fP+Z+JarO0xzIF5b5iURlWMvYrMlsrEdwZ4Cy4Kb7bM6
   w==;
X-CSE-ConnectionGUID: EgqXQM4oSLq2EVB1srT/dQ==
X-CSE-MsgGUID: 7fBzXk5CQBuAhXWc3idclw==
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="64611201"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 05:59:38 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 29 Sep 2026 05:59:38 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 29 Sep 2026 05:59:34 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v4 0/4] net: microchip_t1s: fix collision detection on PLCA status change
Date: Tue, 29 Sep 2026 18:29:24 +0530
Message-ID: <20260929125928.611784-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain


In a 10BASE-T1S multidrop network, the PHY can autonomously change its PLCA
state based on BEACON availability. The existing collision detection logic
only synchronized CDEN on explicit PLCA configuration changes, leaving it
stale across autonomous PLCA status transitions.

This series fixes that gap by tracking PLCA status changes through the PHY
interrupt path, providing a polling fallback for PHYs without a routed
interrupt, and improving collision detection and link-status handling for
LAN867X Rev.D0.

The OA TC6 MAC-PHY SPI driver delivers the in-band PHY interrupt to phylib
through a nested virtual IRQ. LAN865X enables this path for its internal
PHY, which has no dedicated interrupt line. This allows the PHY driver to
receive PLCA status change interrupts through the MAC-PHY SPI interface.

For LAN86XX PHYs, collision detection state is synchronized across explicit
PLCA configuration changes, PHY interrupt handling, and the polling status
path. A per-PHY mutex serializes collision-detection control updates
between PHY configuration and interrupt handling.

LAN867X Rev.D0 uses its hardware CCMFC mechanism to autonomously gate
collision forwarding based on live PLCA_Status, avoiding the software CDEN
toggling used on older revisions. Its link-status handling also accounts
for the optional PRSCTL1 CSMA/CD fallback, selecting the semaphore source
when the PHY can autonomously fall back to CSMA/CD.

Changes in v4:
Addresses Sashiko AI review feedback on v3.
- Add a polling fallback to synchronize CDEN from the live PLCA status for
  PHYs without a routed PHY interrupt.
- Serialize accesses to the collision-detection control register across
  PLCA configuration, interrupt configuration, interrupt handling, and
  status polling to avoid races.
- Preserve the tri-state semantics of plca_cfg->enabled, so an ethtool
  request with the attribute set to -1 does not unintentionally modify CDEN
  or Rev.D0 link-status configuration.
- Fix the OA TC6 virtual IRQ masking path so disabling the nested PHY IRQ
  also masks the in-band PHY interrupt source, and retain deferred dispatch
  to phylib.
- Enable the OA TC6 virtual PHY interrupt for LAN865X and clarify that this
  completes the collision-detection fix for LAN865X. Add the corresponding
  Fixes tag.
- Update LAN867X Rev.D0 interrupt handling to use the cached PLCA enable
  state and current CSMA/CD fallback configuration instead of re-reading
  the complete PLCA configuration on every PLCA status change.
- Preserve cable-test polling when the Rev.D0 PHY interrupt path is
  enabled.
- Clarify the Rev.D0 CDEN/CCMFC behavior and document that CDEN remains
  enabled by default while CCMFC autonomously gates collision forwarding
  from PLCA_Status.
- Correct commit-message and register-comment details identified during
  review.

The LAN865X fix depends on the OA TC6 virtual IRQ support, so the series
should be applied together.

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
 drivers/net/ethernet/oa_tc6.c                 | 227 +++++++++++
 drivers/net/phy/microchip_t1s.c               | 365 +++++++++++++++++-
 include/linux/oa_tc6.h                        |   3 +
 5 files changed, 587 insertions(+), 13 deletions(-)


base-commit: c66d93e68728cfb5f40b40d0f24129d7768faf43
-- 
2.43.0

