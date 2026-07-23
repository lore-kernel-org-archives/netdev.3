Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEDC397323;
	Thu, 23 Jul 2026 05:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782984; cv=none; b=BHTwPNJH4fqWV7L7jQNrBgS7nQFOJXF7+hoPgzT99lTidZlQb9fnPnn/RFFVf+czl5/SeZi9zOF2vyk17Lkr2eD7LGdJo6BPX08RKOBmIyf+fmr5CAoJOvr7sla4jje9wJ4e+0RDdNPdf73ssYVVqPEf5WvX2escSMah1h475KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782984; c=relaxed/simple;
	bh=Y52W230NabIvXfaDAfx+81fvLCNOiGea2DMwdp9LEJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SVhRRRJAadxzVtkg0GL2EG32nDZPPjeGzCtmU0246U5mgXhdla4guv+IY6nR6u1TdGHp+wBRE2ya9/mNGNKAYz1LqIG+gFIMFX22zz8e8EYo31sogwSNRYI4I/9tVeqWOgDrbNhga+EyIhuyAbaZZUxNbPFEljy4VUpdo9Zrq8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=local.com; spf=fail smtp.mailfrom=local.com; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=local.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=local.com
X-CSE-ConnectionGUID: YewB2HndQfGw/7aOOK2swA==
X-CSE-MsgGUID: U89oaORVRpSPisAWPNHAxA==
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="60181905"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:03:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 22 Jul 2026 22:03:02 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 22:02:58 -0700
From: Build User <build@local.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH net-next v5 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Thu, 23 Jul 2026 10:32:53 +0530
Message-ID: <20260723050255.692919-1-build@local.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Thangaraj Samynathan <thangaraj.s@microchip.com>

This series adds RMII interface support for the Microchip PCI11x1x
Ethernet controller.

The PCI11x1x device supports RMII as an alternative MAC-PHY interface,
selected via the STRAP_READ software strap register. Patch 1 reads the
RMII strap bits from this register and sets the is_rmii_en flag. Patch 2
uses this flag to configure the PHY interface mode, phylink supported
interfaces, and enables RMII in hardware via the RMII_CTL register.

Change Log:
===========
v4 -> v5:
  - Always write RMII_CTL with explicit set/clear of RMII_ENABLE_,
    mirroring the SGMII_CTL pattern for a known register state on every
    probe [Simon Horman, Paolo Abeni]

v3 -> v4:
  - Fix dev_dbg() in lan743x_mdiobus_init() to print "RMII operation"
    instead of "RGMII operation" when RMII is selected [Simon Horman]

v2 -> v3:
  - Update debug log to report selected interface (SGMII/RMII/RGMII)
    instead of only SGMII enable/disable state [patch 1/2]
  - Update commit message to document that EEE is disabled by setting
    lpi_capabilities = 0 [patch 2/2]

v1 -> v2:
  - Remove redundant mac_capabilities &= ~MAC_1000FD; phylink already
    handles capability reduction for RMII via phy_caps_from_interface()
    [patch 2/2]

Thangaraj Samynathan (2):
  net: lan743x: add RMII strap status detection for PCI11x1x
  net: lan743x: add support for RMII interface

 drivers/net/ethernet/microchip/lan743x_main.c | 35 ++++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h |  6 ++++
 2 files changed, 37 insertions(+), 4 deletions(-)

-- 
2.34.1

