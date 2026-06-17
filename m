Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688D11494A8;
	Wed, 17 Jun 2026 05:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781674379; cv=none; b=lnaCiWkLKE3+FPd7rmosRSV72rZoA5+zjQDJLL+CK4rQCZW90dtI8TP0FzP1l68ifTg7kfuzbgkNwUIsp64Yc6JUW4b4wU7Bpqi7aNVmNl+P4tgyaUcgHcVB2Vuhw7Uwml8ksi+izVBw96KjSIHWMfWMjI2Yzcekw/+YfrX3hZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781674379; c=relaxed/simple;
	bh=CF6tuQ5Bpv2LWIgdxKTEhbznnrZ8ooydvRqz8sALig4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IuDoYLj0UOJzbn5Nz3gYs9pmZdxlKViifQtDpDr1z2mtYJXjbBpmjFRR404olHzgAurddicJG3SMBBrcyUP42Txzf5YtRfNO46iES13gHQL3yUOxBAoDFxc06Po6ME9EvTzxDue2jlkao/3D3af+ErAxKR80paeuKfZ+Wrs4gx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FBqc6NsL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FBqc6NsL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1781674379; x=1813210379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CF6tuQ5Bpv2LWIgdxKTEhbznnrZ8ooydvRqz8sALig4=;
  b=FBqc6NsLPKzrHaylz4Z1NdKwburq3TPWWrPihMCfSkz5SOv5KJ1CQ/wv
   mun2LlhvSzMk++OdGCMSiNA2SS0Nh+N9p2bDMBxLDVENOg2kKRQ1IYkbm
   TvXLPxL0PUKBeAd+SO3PkKHi91p6c3q8kg00fq0o6GGez/APoP/j+AtqL
   abd5myn2pb/HgUu6jGS/3C9YL45fi4myUXgCPPf1Zt4oMsVXlDmSljuqN
   GxjrFCYgv7sKmk7BFWxE5Uhx2qUZMoMixEWd+l0VPzOuX0iRdo8Es5Cah
   5iv6ouA2xFP6DVxnH0LjvUsd1EK71iolr5VaHS0sA/828q6+7xE96iWn0
   A==;
X-CSE-ConnectionGUID: wKVZYtoRRFWuQd1hHak3mw==
X-CSE-MsgGUID: we2gtDhEQt+0wA9vxtP+1Q==
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="59255627"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 22:32:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Tue, 16 Jun 2026 22:32:57 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Jun 2026 22:32:54 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 1/2] net: lan743x: add RMII strap status detection for PCI11x1x
Date: Wed, 17 Jun 2026 11:02:40 +0530
Message-ID: <20260617053241.157932-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260617053241.157932-1-thangaraj.s@microchip.com>
References: <20260617053241.157932-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
index 1cdce35e1423..0798f3f1f435 100644
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

