Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112D73C061C;
	Mon,  8 Jun 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913099; cv=none; b=Grdg1LqmtI1waYW01dH0r/ZmlNkf+SnshjACJc8gMpVhlTGnorwoASGVda6+ISPcW1RyQ0T88QPyNEJQEIz+GHfGAIMFQoxlrC/yJbuqmofJ7u3Fkk4CzwuYwZRAqIsk/kODK1YCWouuQsT91TBanEsx/T0bmfCEPphQQZ9UtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913099; c=relaxed/simple;
	bh=9ns8VLbe6TQKPJoz6QFdSHv+pjT2/iJw8Ty9xd/RvLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGCxxu72IrKscfLw7tRQ2+QuxneYZHINNR3B9FXroYUz5N0GgDj7Be/hUlT51DvQrs/ksGM9peEAa2gHJeDYy/gdy6TFXJ2O2QP62r798s4tv7NKhmUzaD6K5xz4iwPkmmqMbPQ9z8g5ojcwZnHNfGoxhYoEJ04i2+/qKdkudvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=M8Bxt72e; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M8Bxt72e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1780913098; x=1812449098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ns8VLbe6TQKPJoz6QFdSHv+pjT2/iJw8Ty9xd/RvLg=;
  b=M8Bxt72ewdUj/zzQwcHUq91XiPEXDNZQgVbCf5oY9vhzTQeONXmvpnIv
   5LyXBJAjMkZSmCE9Qle+eAJ5g7JOCgtQeqjOjGgkgdPlbw7UVRzTRgA93
   z8MjRUkaU/9Dkg6O47hKjKTvBkfM+kcJkIntHp335ueiiXYmOf5hTW3+e
   XPrDFh7xRCel4WNvT8HOsKBokfRqYKTvQqdUyj/jtNetxSRdHA5d/4RsM
   vaHL4OIhV7D0KBtCNguFAMbYDbirV5djuBn0HiL6Hi7Ji8e2bd2QXNxta
   mTJnwKF0N3cJaHIQLMdACwnhQ/n/d1kHIrurYJ3mL1fwzPNv2y29TMQyF
   w==;
X-CSE-ConnectionGUID: oPDOvqoGSruI+lcOEBB0Sw==
X-CSE-MsgGUID: ddclArniQdCPSGi2YuqPVg==
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="59147072"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jun 2026 03:04:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 8 Jun 2026 03:04:57 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 8 Jun 2026 03:04:53 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 1/2] net: lan743x: add RMII strap status detection for PCI11x1x
Date: Mon, 8 Jun 2026 15:34:34 +0530
Message-ID: <20260608100435.11214-2-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608100435.11214-1-thangaraj.s@microchip.com>
References: <20260608100435.11214-1-thangaraj.s@microchip.com>
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

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
Changes in v3:
  - Update debug log to report selected interface (SGMII/RMII/RGMII)
    instead of only SGMII enable/disable state

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

