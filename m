Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E48377EDF;
	Tue, 26 May 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779810067; cv=none; b=QroiNG4gnGihOcmnusJwmAQ3sQK1R37j4yUGYntHph+HhgnmtT/3VUAgT+/3/g63mkq17RDM3gUIlbFwnu1KkxwM2hMQx6A8F+R2cKsXVvmf/ja/V/uCMCRLNlQEuBnpPT9qpAJsXAjsDvVM9zooiPgE4YjFB+r9Rdq3+BBrCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779810067; c=relaxed/simple;
	bh=b452XGMV2iv46m/cSAdipqMF2DkGqJRZuOKFUfNXL0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mZpYIxhu7rBYJhWxbenVGKp+H0Xz7fxUXHTKKhm+asGAzlvoEtdRg0d9uNMX01eGpiw6BEiuBSMYLxLjnjwgLBCTYMKBLnYo6wauXTmUGWudZ/1PtiWTn9ceaQLx2iCbUW/gTV5HdOGWvXsXohV3205sNuNWAqh8z/S3XcvL8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=j7HAOtB+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="j7HAOtB+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1779810066; x=1811346066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b452XGMV2iv46m/cSAdipqMF2DkGqJRZuOKFUfNXL0U=;
  b=j7HAOtB+vYJRreUKoE/Xf1bh2KD4CojMP54T5EOdmqZl/jo/MnkDvO8V
   EcvtqXVbbKCu0OmaYSPxU0lEoivi5ZsV5aAUsc0FT+pvpiQx4MqUtLhsZ
   7SzfC+5JzlWgU98WeEoHZrVUQ9DdTe0TqKLtLYzgAAMlFgxj3NA4y4zfD
   YB3id6XiTIi6nINhJGyITVQpXBYWGABQevGeblmeA+JLiho+hvqdS42xB
   aQAzziX78SnuAeW/BhmfiPXIEV6rPIgYumftxWmxK5dj/uhqaKDGbUGaF
   7z3tv763A4IVSYoeVq1UcWgAyX5ZmQXmTuCCGko6CNmPdEJr0oICwKhs1
   A==;
X-CSE-ConnectionGUID: oCTFGirEQBueeLvcCo6Skg==
X-CSE-MsgGUID: QowLtF//Q32kmVYOhlIMNA==
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="57282448"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 08:41:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 26 May 2026 08:40:59 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 26 May 2026 08:40:56 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] net: lan743x: add RMII support for PCI11x1x
Date: Tue, 26 May 2026 21:10:52 +0530
Message-ID: <20260526154054.19829-1-thangaraj.s@microchip.com>
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
v1 -> v2:
  - Remove redundant mac_capabilities &= ~MAC_1000FD; phylink already
    handles capability reduction for RMII via phy_caps_from_interface()
    [patch 2/2]

Thangaraj Samynathan (2):
  net: lan743x: add RMII strap status detection for PCI11x1x
  net: lan743x: add support for RMII interface

 drivers/net/ethernet/microchip/lan743x_main.c | 24 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.h |  6 +++++
 2 files changed, 30 insertions(+)

-- 
2.34.1

