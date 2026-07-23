Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC417344D9D;
	Thu, 23 Jul 2026 05:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783322; cv=none; b=XAUkVbwbPUeezkKaznFUH2Emj1d1cuzS19yvNnkajuZF+OhfM3b0xJ/ncHIu49i+LvUAQrJibZrM5LEvNAl2hCt7/ieC5MXftmFbhe3zAlvQx0M6EChjmhghLi78yDcv1KTc1EFu/akQPdKj+GwPrrnhBh7V5uEcDogNi+s/fTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783322; c=relaxed/simple;
	bh=685cKvKIaaJawmbnJ/7KQ9c2DK+5CR0l6HLwNXL1SSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzWKGFxXJq+qm9FDBHp5t+CHJRAMEOZCTl4RxXh9rZ7ub47Z0Dqc2+ko2fj0+XSaMb1u6LBXdYp1BToYTmK86zHIYs/a0S6hhFHbmhJIMtCsCguPEDfu+qbcf5TvYy9GsPNm5LT0fDbm8Bovx2edQtUpCqJV/ny90JecnKEoHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=dewSoMQP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dewSoMQP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1784783320; x=1816319320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=685cKvKIaaJawmbnJ/7KQ9c2DK+5CR0l6HLwNXL1SSQ=;
  b=dewSoMQPg7Nb8ixumQOHrwZl/cOvzEceSC9rqxBTmn1YYJJED0BqF7fC
   yvhkNLZGEB78qe/tVvU+asClIpQPwhdTWbX5MONWFVZsRiQ0pgbFcVWrm
   +ltpob5lAau2yMdVkRmMjhJeNZEpA16l4LnYpigHjMf9RdweaX5YSQNTY
   LWojWa2B3iswT6Z6V7Srrzxhkzdm3YHB32kHKttGBr7eLrPAHjitqC3Hr
   MiUYcR0/2tCy94vZstNtZ+4Tmyjpzdu4bkPKVLsfCwCFUWGnLe6tRUtIS
   f08TKZtSnSIuyplMHODrsgNobsN1r2rs+k3jkajaAb0KUPT+dbgUw2lJ7
   A==;
X-CSE-ConnectionGUID: wxzQMndyRxOZljPjBOMKfA==
X-CSE-MsgGUID: spDzIDAxSUSbnHX31cq35A==
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="60182062"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jul 2026 22:08:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 22 Jul 2026 22:08:40 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 22 Jul 2026 22:08:37 -0700
From: Thangaraj Samynathan <Thangaraj.S@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH net-next v5 1/2] net: lan743x: add RMII strap status detection for PCI11x1x
Date: Thu, 23 Jul 2026 10:38:26 +0530
Message-ID: <20260723050827.694832-2-Thangaraj.S@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723050827.694832-1-Thangaraj.S@microchip.com>
References: <20260723050827.694832-1-Thangaraj.S@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Thangaraj Samynathan <thangaraj.s@microchip.com>

Extend pci11x1x_strap_get_status() to read the RMII strap bits from
the STRAP_READ register. The is_rmii_en flag is initialized to
false and updated based on the hardware strap only if SGMII is not
already enabled. This ensures correct interface identification during
adapter initialization.

Update the netif_dbg() to report the selected interface as SGMII,
RMII, or RGMII.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 12 ++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index e759171bfd76..3a418105cd11 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -42,6 +42,7 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	u32 strap;
 	int ret;
 
+	adapter->is_rmii_en = false;
 	/* Timeout = 100 (i.e. 1 sec (10 msce * 100)) */
 	ret = lan743x_hs_syslock_acquire(adapter, 100);
 	if (ret < 0) {
@@ -73,8 +74,15 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 			adapter->is_sgmii_en = false;
 		}
 	}
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
+
+	if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
+		if (strap & STRAP_READ_RMII_EN_)
+			adapter->is_rmii_en = true;
+	}
+
+	netif_dbg(adapter, drv, adapter->netdev, "Selected I/F: %s\n",
+		  adapter->is_sgmii_en ? "SGMII" :
+		  adapter->is_rmii_en  ? "RMII"  : "RGMII");
 }
 
 static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 1573c8f9c993..1f8d9294a6ef 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -36,7 +36,9 @@
 #define FPGA_SGMII_OP			BIT(24)
 
 #define STRAP_READ			(0x0C)
+#define STRAP_READ_USE_RMII_EN_		BIT(23)
 #define STRAP_READ_USE_SGMII_EN_	BIT(22)
+#define STRAP_READ_RMII_EN_		BIT(7)
 #define STRAP_READ_SGMII_EN_		BIT(6)
 #define STRAP_READ_SGMII_REFCLK_	BIT(5)
 #define STRAP_READ_SGMII_2_5G_		BIT(4)
@@ -1072,6 +1074,7 @@ struct lan743x_adapter {
 	struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
 	bool			is_pci11x1x;
 	bool			is_sgmii_en;
+	bool			is_rmii_en;
 	/* protect ethernet syslock */
 	spinlock_t		eth_syslock_spinlock;
 	bool			eth_syslock_en;
-- 
2.34.1

