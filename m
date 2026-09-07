Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212D380FF7;
	Mon,  7 Sep 2026 05:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758484; cv=none; b=lENHMNdBql0Sj6XFPRBxq35OMI+yIyjU7RePFLu5WlqsWQCAaJa8kcxNuqtyawmGJhnqTky7Hmwgnq4qwHZybK0/E/yh+YH8fKvhNh06KKNbuPwZf09RrtmJR3gU/WVVsvLacv8wg7AbvuZ0MaaX06wDODlyaJ1JW7VwlE6vPGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758484; c=relaxed/simple;
	bh=b2TCn9rlAsmkly0EHt6O3ksK+OsH2/828LwoizpnH7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sEt8kYkNSx8u5tImn92Lvl4PlC5kNL79IfWnP0vwUauf+ghVqioWrV5l7QG0kjhxmnM/g01PPLug+ctlGjrB0YUxQgPO0HDCLekKwWmkazuM07HhHatiqX3ad/v1qTClNP0Hzym2TZqVDqadgksGyFBj2fdpqCsOtxDB2BAcAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JUgTEi1e; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JUgTEi1e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788758483; x=1820294483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b2TCn9rlAsmkly0EHt6O3ksK+OsH2/828LwoizpnH7s=;
  b=JUgTEi1ec0tgMzx194oObYO6jy/gn3JvTWdqDUQaJsG4DAo2sCtBpZkx
   mHrYXNSxEk/v/ExbdqqP07jwy3jmVLef0MMjxIafnPKMXe4/pn0PDvGTQ
   k3aXwSs/KMOH9JS+9NibG3EAazz/l4Zwoq015SBIdoFJAR0qnwSIOlsmc
   N/Ipo0VNh9ayqgWCd3uNKYJy+JpYd2HcNbWeuQpN3aPSpiwME/a5UzhBB
   e/oppQ66jGyUAVsSg+3cLS8ymU9DD/lJJgDQkFPXpK2YuclXynd8NZvha
   gv5h4mDR6ZUQcbW3b6RpPrYh738wZJS58XgEdF8O1VQWXyJCoSBSdg7PQ
   A==;
X-CSE-ConnectionGUID: ynNG5RA4SXC1LMqIiB7wqA==
X-CSE-MsgGUID: mzles+cmQuOYuBF8VHPPyQ==
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="63542719"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 22:20:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Sun, 6 Sep 2026 22:20:14 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 6 Sep 2026 22:20:10 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>, <Parthiban.Veerasooran@microchip.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next v2 0/4] net: microchip_t1s: fix collision detection on PLCA status change
Date: Mon, 7 Sep 2026 10:50:02 +0530
Message-ID: <20260907052007.391972-1-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

In a 10BASE-T1S multidrop network, when PLCA mode is configured, the PHY
autonomously transitions between PLCA mode and CSMA/CD mode based on
BEACON availability, without any further user action. The existing
collision detection logic only adjusted on explicit ethtool PLCA
configuration changes, leaving it in the wrong state across these
autonomous mode transitions.

This series fixes that gap, wires up the complete interrupt path, and
improves collision detection handling for LAN867X Rev.D0.

Patch 1 fixes the collision detection handling in the PHY driver. It adds
the PLCA Status Changed (PSTC) interrupt handler for LAN86XX PHYs. On
each PSTC interrupt, the PLCA operational status is checked and collision
detection is adjusted accordingly: disabled when PLCA is online,
re-enabled when PLCA goes offline to restore correct CSMA/CD operation.
The interrupt handler uses a conditional assignment pattern without early
returns for better extensibility. The existing static CDEN write in
lan86xx_plca_set_cfg() is retained as a baseline for PHYs running with
phydev->irq == PHY_POLL on boards where the PHY interrupt is not routed
to the host. PHYs with routed interrupts (including LAN865X and LAN867X
with interrupt support) skip the static write since the interrupt handler
handles CDEN dynamically.

Patch 2 delivers the in-band PHY interrupt to phylib from the 10BASE-T1S
MAC-PHY SPI driver. The OA TC6 standard defines PHY interrupt delivery
via the SPI status register as optional; the OA_TC6_PHY_INT quirk flag is
introduced so drivers can opt in when the PHY interrupt is routed in-band.
When set, a nested virtual IRQ is created inside oa_tc6_mdiobus_register()
before mdiobus_register() is called. All mii_bus->irq[] entries are
populated with the virtual IRQ so phy_device_create() picks it up
regardless of the PHY's MDIO address, keeping mii_bus->irq[] and
phydev->irq consistent. The teardown is integrated into
oa_tc6_mdiobus_unregister(). When the PHYINT bit is seen in the extended
status, handle_nested_irq() is dispatched synchronously from the sleepable
threaded IRQ so phylib enters interrupt mode and drives the PHY driver's
config_intr/handle_interrupt callbacks.

Patch 3 enables the PHY interrupt via virtual IRQ for LAN865X by passing
the OA_TC6_PHY_INT quirk flag to oa_tc6_init(). The LAN865X integrates
the PHY directly into the MAC-PHY SPI device. The PHY has no dedicated
interrupt line; its interrupt is always delivered as the PHYINT bit in
STATUS0.

Patch 4 fixes collision detection for LAN867X Rev.D0 by configuring the
hardware Collision Counting and MAC Forwarding Control field (CCMFC) in
the Collision Detector Control 0 register to the OA default value. The
hardware automatically gates collision forwarding to the MAC based on the
live PLCA_Status: collisions are neither counted nor forwarded when
PLCA_Status is OK, and are counted and forwarded when PLCA_Status is not
OK. This eliminates the inherent delay between a PLCA status change and
the software interrupt handler toggling CDEN, which was a limitation on
older revisions that had no hardware alternative. A dedicated
lan867x_revd0_handle_interrupt() is added to handle two separate interrupt
events: link status change events trigger the phylib state machine for
link re-evaluation; PLCA status change events update the link status
selection. The handler uses the same conditional assignment pattern for
extensibility. Collision detection gating is handled autonomously by
CCMFC in hardware. The .config_intr/.handle_interrupt handlers are wired
up for Rev.D0 using the shared lan86xx_config_intr() and the new handler
to unmask both link status change and PLCA status change interrupts.

Note: Patch 1 carries a Fixes: tag but requires patches 2 and 3 to be
applied together -- the interrupt handler in patch 1 cannot fire without
the virtual IRQ wiring in patch 2, and the virtual IRQ infrastructure is
activated for LAN865X by patch 3. This dependency applies to 10BASE-T1S
MAC-PHYs (e.g. LAN8650/1) where the PHY has no dedicated interrupt line
and relies on the MAC-PHY SPI driver to deliver the interrupt.

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

 .../net/ethernet/microchip/lan865x/lan865x.c  |   4 +-
 drivers/net/ethernet/oa_tc6.c                 |  76 ++++++++-
 drivers/net/phy/microchip_t1s.c               | 159 ++++++++++++++++++
 include/linux/oa_tc6.h                        |   3 +
 4 files changed, 238 insertions(+), 4 deletions(-)


base-commit: 31f961de2f90fbf52eb2d4e15b3eeaa09f9b4fc2
-- 
2.43.0

