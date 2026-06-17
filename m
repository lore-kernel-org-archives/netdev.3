Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6777A1494A8;
	Wed, 17 Jun 2026 05:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674373; cv=none; b=tLAhfBgcozA130xTVJXaNm6Pz+iSjShuOSscHzot9u4ot0RmCWB/X4jiHzzrmaSCOLWqP2Y2egl2LRGE08jmFnPk91ZA6XcfNy7OSNpULx0rZPYKI7wy6wRQulh2awVEnR2W4uxugYKK4a3D4D7n9RC4t8BA7lV/0669vNyea+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674373; c=relaxed/simple;
	bh=nElNBNKAznnqaiVAP2gfcv9Ta7QLAyZqYembum2OjwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nyRCa9g5ltk0U44SEIH/fKuEUYv5/GkfHG3MoCriYAPYaE00WFWPgpmTCeaohqYzEDSduF38JyIv23Ye4yA15aeeRassOE0jUa/xQCN3qq5Vw0wHtys0CdwXzdUI8Uqhj9qv9jTJA90mLbCBrQs8bMqsZEFeK5pNO08aq3YhVPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ob4uccyB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ob4uccyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781674372; x=1813210372;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nElNBNKAznnqaiVAP2gfcv9Ta7QLAyZqYembum2OjwY=;
  b=ob4uccyBdAW3HrWiqxqDWfMulDH804m1vtd10mPN3kbVse4M0w5aY1LJ
   4L41ebqqMjdYb7NTbcO2JeK3G8s9ymtF0JJOez6laf+PKmpx8lnPS8YNN
   X38JPe7d7sC3h+EoAdeS6xjBD8lpdFJJuBDLTfX5l2mJEmqvgzXH7sijF
   AzZzbC7sX9cRuNmhE/0AAqrxD03HoY/PFeaxObbZ+VQ4jqU+aIGnIeoQU
   cv35nkirECC2Xrx1NbJMm8NzVioTaLhBf9rJwdVLNM/K/keZFjjyGdsQ3
   Z0DQtLm+QSYjIxub7dGe5nmptMA5WQQc/3LR7fZnAlnnQDI67PCKX5XIC
   A==;
X-CSE-ConnectionGUID: ZaVTlC97TeWTd3HxEn153w==
X-CSE-MsgGUID: jtRd+cioQzG6JYwFcjsyEw==
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="68341228"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 22:32:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 22:32:51 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Jun 2026 22:32:47 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Wed, 17 Jun 2026 11:02:39 +0530
Message-ID: <20260617053241.157932-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This series adds RMII interface support for the Microchip PCI11x1x
Ethernet controller.

The PCI11x1x device supports RMII as an alternative MAC-PHY interface,
selected via the STRAP_READ software strap register. Patch 1 reads the
RMII strap bits from this register and sets the is_rmii_en flag. Patch 2
uses this flag to configure the PHY interface mode, phylink supported
interfaces, and enables RMII in hardware via the RMII_CTL register.

Change Log:
===========
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

 drivers/net/ethernet/microchip/lan743x_main.c | 34 ++++++++++++++++---
 drivers/net/ethernet/microchip/lan743x_main.h |  6 ++++
 2 files changed, 36 insertions(+), 4 deletions(-)

-- 
2.34.1

