Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144679DA;
	Thu,  5 Mar 2026 09:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701475; cv=none; b=pE+CE6WD0Ods9ruvwx4wCZV4Z4WLocJfpDra9IW0Bmcj+NZq3NFbv41rACmKb1pFXcOJeQv2ySF+tK8tDrP9B7oCBx2wLdKLotGEdGXWOaUYFuYwvSOAnYrKq1OUIrOsvr/R86ldyaFc4TPcXVahUy1I+nniyJKDb1YCcNpMp90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701475; c=relaxed/simple;
	bh=7L05pmouAdsIHTPLUff5zr8N11GEkqPxdNtol80JoeU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nm44TCQI3apD5gpEViKwRHIZaNYBH5MdPZosy2Z51VNTxqx40i4wSQr89xNpnNG58tlOk1ssrUXqj2fx2BE4R5PEXV8K3uwD9yR89IkfQfr2OEA0QTfd46JpkrUnNlsJ9Rg2y4EuwUxjU14eO9VknZeIDMqM3H6qKJ6kLRd0d48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=p5KLTeKx; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="p5KLTeKx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772701473; x=1804237473;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7L05pmouAdsIHTPLUff5zr8N11GEkqPxdNtol80JoeU=;
  b=p5KLTeKxAl2+ElyTb2cxgyPkZMfGP9Z5jDCOl0CnxXmX6v6yXVLLmUTO
   Q9eZ6Wqc7G9ldCoHMINE9v0h4k8CYU1sRVZsUjlBD13Djxk0QihQPnHso
   tGHQiESEPzrt9/Uug+nB8TWUOWCw6h9T9Rq3GSmMG6eqh/wLTc7WfSllO
   n17BulV49YR7znSe8zwt0As8+YEZpm+2vtXjptRAMYTEOXNZvW7pxC/Uf
   HLMQh21XlL3qCo705UQ38YHknsvpvvQSx1YbQ68H/aBwyUJsWXAjdeer4
   QiEywA3IBGhqbBBVW1qZbKPFQiDWTIz4oZMOy0lH8HNOCbVVPq9tnHMpl
   A==;
X-CSE-ConnectionGUID: bPfqscjNRrKHYC/Fbqf2CA==
X-CSE-MsgGUID: 52xUsO9hSieLzThzvp1Vkg==
X-IronPort-AV: E=Sophos;i="6.23,325,1770620400"; 
   d="scan'208";a="61752234"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 02:04:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Mar 2026 02:04:02 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 5 Mar 2026 02:03:59 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: lan743x: fix SGMII detection on PCI1xxxx B0+ during warm reset
Date: Thu, 5 Mar 2026 14:33:55 +0530
Message-ID: <20260305090355.4946-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

A warm reset on boards using an EEPROM-only strap configuration (where
no MAC address is set in the image) can cause the driver to incorrectly
revert to RGMII mode. This occurs because the ENET_CONFIG_LOAD_STARTED
bit may not persist or behave as expected.

Update pci11x1x_strap_get_status() to use revision-specific validation:

- For PCI11x1x A0: Continue using the legacy check (config load started
  or reset protection) to validate the SGMII strap.
- For PCI11x1x B0 and later: Use the newly available
  STRAP_READ_USE_SGMII_EN_ bit in the upper strap register to validate
  the lower SGMII_EN bit.

This ensures the SGMII interface is correctly identified even after a
warm reboot.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 11 +++++++----
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index a3845edf0e48..866f6a3da0d9 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -32,10 +32,12 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 {
 	u32 chip_rev;
 	u32 cfg_load;
+	u32 dev_rev;
 	u32 hw_cfg;
 	u32 strap;
 	int ret;
 
+	dev_rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
 	/* Timeout = 100 (i.e. 1 sec (10 msce * 100)) */
 	ret = lan743x_hs_syslock_acquire(adapter, 100);
 	if (ret < 0) {
@@ -47,10 +49,11 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
 	cfg_load = lan743x_csr_read(adapter, ETH_SYS_CONFIG_LOAD_STARTED_REG);
 	lan743x_hs_syslock_release(adapter);
 	hw_cfg = lan743x_csr_read(adapter, HW_CFG);
-
-	if (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
-	    hw_cfg & HW_CFG_RST_PROTECT_) {
-		strap = lan743x_csr_read(adapter, STRAP_READ);
+	strap = lan743x_csr_read(adapter, STRAP_READ);
+	if ((dev_rev == ID_REV_CHIP_REV_PCI11X1X_A0_  &&
+	     (cfg_load & GEN_SYS_LOAD_STARTED_REG_ETH_ ||
+	     hw_cfg & HW_CFG_RST_PROTECT_)) ||
+	     (strap & STRAP_READ_USE_SGMII_EN_)) {
 		if (strap & STRAP_READ_SGMII_EN_)
 			adapter->is_sgmii_en = true;
 		else
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 02a28b709163..160d94a7cee6 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -27,6 +27,7 @@
 #define ID_REV_CHIP_REV_MASK_		(0x0000FFFF)
 #define ID_REV_CHIP_REV_A0_		(0x00000000)
 #define ID_REV_CHIP_REV_B0_		(0x00000010)
+#define ID_REV_CHIP_REV_PCI11X1X_A0_	(0x000000A0)
 #define ID_REV_CHIP_REV_PCI11X1X_B0_	(0x000000B0)
 
 #define FPGA_REV			(0x04)
-- 
2.34.1

