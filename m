Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9BD3D9DB9;
	Tue,  1 Sep 2026 13:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788268200; cv=none; b=E2pg0AgoYFMg6aS4ZvfFQWUrVSemMFZLW8LHyNc9vy8rO/U0D45vhvsxJW9cCedX7RNWMP6xqD20zbZklKKgC7bzS6O6prasW9c8Q3GtqdrO1VDGZYCDmPnI5QDHhNN/e9lwP1u4mVzn2twOBCVMxmgkpGqfBTNO727M75PcRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788268200; c=relaxed/simple;
	bh=kWWO27Pns60GObQqlh2jat7QxMdSKA4vb7oS3HvmB4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRXQkWMCpZNi/ezcmhsvQD1aWYyX+dR+x3WS8Xa1DVuIWXJcuUefwtxqsI/XrZucnkYntf+DZRvpAbe6R3TMCW56EQ5fR8PSQJkQm2onYlYf+AxHzO32D7ge3mfp0r8cd3v0lvuy/HYxv73hgQCl2GAOWpcpOqfcet0sa7qpIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=e5LWIhsD; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="e5LWIhsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1788268198; x=1819804198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kWWO27Pns60GObQqlh2jat7QxMdSKA4vb7oS3HvmB4g=;
  b=e5LWIhsD9nYCZN8VlQyH6kaD8ny3dn3dGpbHx3WqXJgK7TJtQ/hhwdkE
   b2nwdsfKDHyr1sVznd5ckr0HD68MeLt1YC4lbvproLCaQQ0q38rKcdK+7
   XkBsXsrs9PQ0vJTjwb7g0rbXRbRIf/ajPgO5EjYLsGVINXkzMT4+o1/DV
   qRK6jnfy2T9wlZzBEUIL+KgINdiWrP2DmlWR9YXV2RnlJBzYNfu3hi1FT
   6GHf+x9yhyN9Jjm/VU3OTBHU+g3jNNvheXKN7VmeEYl91k9hBIpUkQxVp
   R+o3CPMbHE8VPAYM50dN2khXAZsGIFTxxtWfhNEO7PM4MH4SKFosXakVI
   g==;
X-CSE-ConnectionGUID: FwMyWhUIRZOmo6UMPAMrig==
X-CSE-MsgGUID: pW86tuHgRhCySdwiZ0sZKQ==
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="230109327"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 06:09:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 1 Sep 2026 06:09:56 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 1 Sep 2026 06:09:52 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>, Parthiban Veerasooran
	<parthiban.veerasooran@microchip.com>
Subject: [PATCH net-next 0/3] net: microchip_t1s: fix collision detection on PLCA status change
Date: Tue, 1 Sep 2026 18:39:45 +0530
Message-ID: <20260901130948.212914-1-parthiban.veerasooran@microchip.com>
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
MAC-PHY SPI driver. The integrated PHY has no dedicated interrupt line;
its interrupt arrives as the PHYINT bit in the MAC-PHY STATUS0 register.
A nested virtual IRQ is created and assigned to phydev->irq so phylib
enters interrupt mode and drives the PHY driver's
config_intr/handle_interrupt callbacks.

Patch 3 fixes collision detection for LAN867X Rev.D0 by configuring the
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

Note: Patch 1 carries a Fixes: tag but requires patch 2 to be applied
together -- the interrupt handler in patch 1 cannot fire without the
virtual IRQ wiring in patch 2. This dependency applies to 10BASE-T1S
MAC-PHYs (e.g. LAN8650/1) where the PHY has no dedicated interrupt line
and relies on the MAC-PHY SPI driver to deliver the interrupt.

Parthiban Veerasooran (3):
  net: phy: microchip_t1s: fix collision detection on PLCA status change
  net: ethernet: oa_tc6: deliver the PHY interrupt to phylib
  net: phy: microchip_t1s: fix collision detection for LAN867X Rev.D0

 drivers/net/ethernet/oa_tc6.c   |  69 +++++++++++++-
 drivers/net/phy/microchip_t1s.c | 159 ++++++++++++++++++++++++++++++++
 include/linux/oa_tc6.h          |   2 +
 3 files changed, 227 insertions(+), 3 deletions(-)


base-commit: 25c1f6111034aef7fc06cfbdcf1e4f0d6e5ee74b
-- 
2.43.0

