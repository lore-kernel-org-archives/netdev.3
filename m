Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C23845B0;
	Mon,  8 Jun 2026 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913094; cv=none; b=jCdPFSNSi3X/v7P5JMqHaypvU5bs8jYI2DXOCx1iOCLtqWrQMG3Dl4FL5l/exZr9+a0jGluIkjD7TCh7DZP7ZVRnsZfWBg9Y+xUZ251BC14Nd5Glh0arJGNA2EtreKJI/MwiKx4RqI9xcCATQlb6kR9knq8zv4j7biDVCeowWR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913094; c=relaxed/simple;
	bh=9+58yqiTSd418xSitDakQTfFSHoTRjmFppCMknHSLbI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+OmDnP7HaxheXcG2uudrBihd8L5QWuZhFfbvbHa3oHVxH6/UE4MsPoTF3vqRwNS4BSylTY1cnNmFJ9BeMIZ54Y59jxHhYE99cRnLXNuFpTBpO+6UJDqU8H674Xley+oz7f2Ok4LljbClr8OPArQP3isiwAbMMw7d1OPXTUJPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=shgfuiQK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="shgfuiQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780913092; x=1812449092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9+58yqiTSd418xSitDakQTfFSHoTRjmFppCMknHSLbI=;
  b=shgfuiQK+GIdkfYkArwc2xuTXvJlpqcLAMbAK0iyac8mfYG2Gw4wgsbj
   D/xUqOz/Cg1xb9wf3OFUT57MjgS/z+giLtX1sq99thwBSMTXtDBc0BrA4
   6JpMkZCcsXo6KpfhwjCAOpknebPEoJ3ES4EwUxTtwkZq90Jz8zokdGv8F
   Y/PLkIzl5gw2lyZnc3/Tls7/9QVRiIxGk4slI8hc1///NrcipnQ0Ejptz
   0WhtUBiw6diFD3O2fiftvkAQoZlHHKpz4WiNMDttrT6kFM1EWBVJH+F6z
   wYouneFmhbFdAbrc6/ZJq34FijcxSByw1pCwx8DRupitAZA+4Okr2JiDb
   A==;
X-CSE-ConnectionGUID: VJXF0K4yQn6+NY9KzbJ/8Q==
X-CSE-MsgGUID: 04IFOyfdT1eGg47NznAVrw==
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="57930075"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 03:04:52 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 8 Jun 2026 03:04:51 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Jun 2026 03:04:48 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Mon, 8 Jun 2026 15:34:33 +0530
Message-ID: <20260608100435.11214-1-thangaraj.s@microchip.com>
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

 drivers/net/ethernet/microchip/lan743x_main.c | 29 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  6 ++++
 2 files changed, 33 insertions(+), 2 deletions(-)

-- 
2.34.1

