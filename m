Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954C9344D9D;
	Thu, 23 Jul 2026 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783318; cv=none; b=arf6z+H+lSTOagWCRnUVxntMB2Jee3FJAf3VZnaUhKkqgL92Am/nOInM4YkDz9PXbyCDPea9NxXGyfAL/MX6hBkVl9WQL5iDOnukgnJuR4TKJN1hqvE/a+WNhKz11ysjqXlAgoCo3CDN2SZQ5opkEbWoC8u89JrZYQAdsL++fQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783318; c=relaxed/simple;
	bh=Y52W230NabIvXfaDAfx+81fvLCNOiGea2DMwdp9LEJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvI9kcNG0PsxnhDxXNmEqOaPyqi4zdUYwd8Pf+QbVUKhpXRzi8v8jSTCgyMSXRd0sIjvVArX71qAz94zeyJ0xnu384ei39MtJ6GeoREgPOgBfu/XTfNhgDvJftpdUsQkmkQZWeZBtyGtHhAyRvGY3bT1J4kTdMKswhiaiYyjRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OeQR+ngS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OeQR+ngS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784783316; x=1816319316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y52W230NabIvXfaDAfx+81fvLCNOiGea2DMwdp9LEJ4=;
  b=OeQR+ngS5FTbDAQ9g+0Jp5XuMnPN/jMKPokVFp4e3rA1tMQZ+PBpFlKY
   5hxE1BVfe2mppKO4OsrCjEZL3xpiZ9sZC+2XX80UzG1z6Qhbg0v5VkpDR
   gcSwHQgj4zjlNTtKeeydg5SU1uRqlv25cNgRSxUBI+XwPPEk+SuficTtM
   T2fgTbV6w7tmJqt5v7hT8ecZK3NReNnTPDQe1Xxi6XRcDp+A761xUa7vm
   aXHVhh3wz3sYMF8y3faNDJMmDJZJ0kbnS3PF3E48Pgk4OatV/1CbQEFBp
   6tx2Ia4W7Fn8Of9DfvUQtbI3azipZxlX9levVolvPwgj6dIcugA1KjmX/
   Q==;
X-CSE-ConnectionGUID: nOJdhugvS5+ErNDc/LyWFg==
X-CSE-MsgGUID: RX3zZY4fShO0ItgwB4O5Yg==
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="60182060"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 22:08:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Wed, 22 Jul 2026 22:08:35 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 22:08:32 -0700
From: Thangaraj Samynathan <Thangaraj.S@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH net-next v5 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Thu, 23 Jul 2026 10:38:25 +0530
Message-ID: <20260723050827.694832-1-Thangaraj.S@microchip.com>
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

