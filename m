Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992B03603D8;
	Mon,  6 Jul 2026 09:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330438; cv=none; b=NUjClKgDmJJm5pgedBTzzZiDXcvDN6HA/fHvuQy2ZrtWRk9533NakezbHWozVnc9Gt00+a2D6rIZfhnpDhuqa+9QhQeoE+Dmry2SqM3IUS5twi/ckwOkFIz/bpm6jNj71rGyBlMUSrhU0Pl3ziekwIq1e+Ar8f/QBiHs7+JRdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330438; c=relaxed/simple;
	bh=KxyF5frxH9WQi1QI+idjw2fyDOTyOYh91UBZzBZhksk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aNbeObBJJbBYTEQXSAr4xS80iZu5/HEl3LQE89/hx/yjU9vwdOkPJ051e+BGAgYBCLCVrhtJVfpxIm/6Y2VWGzGuum9cTbHmHw65nM/rpeQlFDK+klyiD3bKRW8lu17HJWcoVVJK2PpeVtg1uZAYHE1RusBJfZw/vYVHcpT7urE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xDx1Zjok; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xDx1Zjok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1783330435; x=1814866435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KxyF5frxH9WQi1QI+idjw2fyDOTyOYh91UBZzBZhksk=;
  b=xDx1ZjokNSe8ElFvDm1x5/AwuUs/MnM12cT6Vp0kQOKpHbYmrEd/Txjn
   p0YJCTQcDfRtuU4r278kn7phrVLDF01VaBYlpqjEQhCkfWwnfUMdiqmu7
   ngORz57LfrNw/mv/SXIRIKOu6Xiaq0QdRoVSP7GSLxYVgmTVrvFd0YnrQ
   6eCM92y/TZiCsxFFuLqcI8Sw2RbI9wQNDN/ZCxmrT3vnBB4bhEW8wDkrz
   fN4UCeRVsFE49jJEwpeVCsIULItxuFgrOhjY9slQiAegkUtXHFr4h9Pdh
   70MJy+YUBy1RiZOXyN5+zeYunsWItGjixpiUDuBTbLeVDsNuM9bX2UGXb
   Q==;
X-CSE-ConnectionGUID: 3zJ16/MfRWOLHO30WjSukA==
X-CSE-MsgGUID: JWrv1Y7iTXyw9+yG2J54Dw==
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="60494875"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 02:32:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Mon, 6 Jul 2026 02:32:46 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 6 Jul 2026 02:32:43 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Mon, 6 Jul 2026 15:01:48 +0530
Message-ID: <20260706093150.9033-1-thangaraj.s@microchip.com>
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

