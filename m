Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4013401A0B;
	Mon,  3 Aug 2026 12:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761340; cv=none; b=TOeXi0z1eOCnZy4qlP/Uxr2ljoj3HyIozDg8L5W0B7BA1T7qYVvIcNQrD//Q+kJn0ekgUL0M6bFuwdxy9YxPAosR7VS32BDGuw5TWiRUEe/XRTLwh0A+7vxulA8niG8YJnf84txuwQaaJY9ZzgbEtfl3ZU55PDI+6bS/Y2uVAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761340; c=relaxed/simple;
	bh=AmwEAelGUoTN+TQLR3+BzxncS+xmUHGi0VRFQWu3B4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cisbSj38tCga818pV/hTzlEv+l4m11rhtW03Q8/JJdCVxPa8UZotEVJxfOK4VL0jpsdITP3dcRr/oDDYISrlK73Ud4AbPHRcMLhxPpJmCBEZLSFrZP07lYkpSgiLEuDGW0YD7x2Wj29WojBhwue5Tu9l+/jricZ/8cGpvzAXAGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ULFewdz4; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ULFewdz4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785761338; x=1817297338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AmwEAelGUoTN+TQLR3+BzxncS+xmUHGi0VRFQWu3B4c=;
  b=ULFewdz4IhExdC7wmyGK5Znzy8R4Q7E3BcRxKyNWJV94oDW4EsNretSc
   esxEVOH0P6tkkmVj9F/587CFB8W6jW9ey/5Mot133Aybi7X6Sy7v9rWaQ
   y6Z9FacNNkRtmW85LQiq+B0grhlfViUZhFbOupu50xqGNAESNHbNJJml7
   uBcUK8Mx5J/fKkvPGqgkCZXUVKQqFamBIEytOrT8JfrvFIYBqfILLtxvr
   QS5fNquKdV+stF2aSNorWN+g9LC4hSnmvHWoz/TpRiWmD7VvO6mUxjWrt
   x2HbzaohZAKIv7V7T0q+in6MAkL1Hw0LdL+Ws6fXk35NqDU0T3/N3kcGm
   Q==;
X-CSE-ConnectionGUID: WVSBuHpmQQqNW+LDa5n7VQ==
X-CSE-MsgGUID: C1ZoRjAGS1S2AVa4fVUp/Q==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="228701955"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 05:48:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 3 Aug 2026 05:48:57 -0700
Received: from che-ld-ungapp03.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 3 Aug 2026 05:48:53 -0700
From: Dhanushkalyan G <Dhanushkalyan.G@microchip.com>
To: <netdev@vger.kernel.org>
CC: Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Thangaraj
 Samynathan" <Thangaraj.S@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/2] net: lan743x: set interrupt moderation timer based on link speed
Date: Mon, 3 Aug 2026 18:18:46 +0530
Message-ID: <20260803124847.17315-2-Dhanushkalyan.G@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260803124847.17315-1-Dhanushkalyan.G@microchip.com>
References: <20260803124847.17315-1-Dhanushkalyan.G@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Thangaraj Samynathan <Thangaraj.S@microchip.com>

The driver programs a single fixed interrupt moderation timer into every
INT_MOD_CFG register at interrupt open, regardless of the negotiated link
speed. A fixed value is a poor trade-off across the supported speed
range: it is too coarse at low speeds and not aggressive enough at 2.5G.

Set the moderation timer as a function of the negotiated link speed in
the MAC link-up path: 64 us at 2.5G, 150 us at 1G, and 330 us at
100M/10M. The interrupt-vector-to-timer mapping (INT_MOD_MAP) is static,
so it stays programmed once at interrupt open; only the timer value
(INT_MOD_CFG) is updated, from the new lan743x_config_int_mod() helper,
when the link comes up.

Signed-off-by: Thangaraj Samynathan <Thangaraj.S@microchip.com>
Signed-off-by: Dhanushkalyan G <Dhanushkalyan.G@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 51 ++++++++++++++-----
 drivers/net/ethernet/microchip/lan743x_main.h |  5 +-
 2 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index f3332417162e..20d6a48ca0bb 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -627,18 +627,12 @@ static int lan743x_intr_open(struct lan743x_adapter *adapter)
 		lan743x_csr_write(adapter, INT_VEC_EN_SET,
 				  INT_VEC_EN_(0));
 
+	/* The interrupt-vector-to-moderation-timer mapping is static, so
+	 * program it once here. The timer values themselves are set later
+	 * (per link speed) via lan743x_config_int_mod().
+	 */
 	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0)) {
-		lan743x_csr_write(adapter, INT_MOD_CFG0, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG1, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG2, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG3, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG4, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG5, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG6, LAN743X_INT_MOD);
-		lan743x_csr_write(adapter, INT_MOD_CFG7, LAN743X_INT_MOD);
 		if (adapter->is_pci11x1x) {
-			lan743x_csr_write(adapter, INT_MOD_CFG8, LAN743X_INT_MOD);
-			lan743x_csr_write(adapter, INT_MOD_CFG9, LAN743X_INT_MOD);
 			lan743x_csr_write(adapter, INT_MOD_MAP0, 0x00007654);
 			lan743x_csr_write(adapter, INT_MOD_MAP1, 0x00003210);
 		} else {
@@ -3036,6 +3030,28 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 	netif_tx_stop_all_queues(netdev);
 }
 
+/* Program the interrupt moderation timer value into the per-vector
+ * INT_MOD_CFG registers. Only the timer value is written here; the vector
+ * mapping (INT_MOD_MAP) is static and is set once at interrupt open.
+ */
+static void lan743x_config_int_mod(struct lan743x_adapter *adapter, u32 int_mod)
+{
+	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0)) {
+		lan743x_csr_write(adapter, INT_MOD_CFG0, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG1, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG2, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG3, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG4, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG5, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG6, int_mod);
+		lan743x_csr_write(adapter, INT_MOD_CFG7, int_mod);
+		if (adapter->is_pci11x1x) {
+			lan743x_csr_write(adapter, INT_MOD_CFG8, int_mod);
+			lan743x_csr_write(adapter, INT_MOD_CFG9, int_mod);
+		}
+	}
+}
+
 static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 					struct phy_device *phydev,
 					unsigned int link_an_mode,
@@ -3045,6 +3061,7 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	u32 int_mod;
 	int mac_cr;
 	u8 cap;
 
@@ -3053,12 +3070,18 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 	 * Resulting value corresponds to SPEED_10
 	 */
 	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
-	if (speed == SPEED_2500)
+	if (speed == SPEED_2500) {
 		mac_cr |= MAC_CR_CFG_H_ | MAC_CR_CFG_L_;
-	else if (speed == SPEED_1000)
+		int_mod = LAN743X_INT_MOD_2_5G;
+	} else if (speed == SPEED_1000) {
 		mac_cr |= MAC_CR_CFG_H_;
-	else if (speed == SPEED_100)
+		int_mod = LAN743X_INT_MOD_1G;
+	} else if (speed == SPEED_100) {
 		mac_cr |= MAC_CR_CFG_L_;
+		int_mod = LAN743X_INT_MOD_100M;
+	} else {
+		int_mod = LAN743X_INT_MOD_10M;
+	}
 
 	if (duplex == DUPLEX_FULL)
 		mac_cr |= MAC_CR_DPX_;
@@ -3067,6 +3090,8 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 
 	lan743x_csr_write(adapter, MAC_CR, mac_cr);
 
+	lan743x_config_int_mod(adapter, int_mod);
+
 	lan743x_ptp_update_latency(adapter, speed);
 
 	/* Flow Control operation */
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 160d94a7cee6..c4a3de7fe107 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -861,7 +861,10 @@ struct lan743x_adapter;
 #define LAN743X_USED_RX_CHANNELS	(4)
 #define LAN743X_USED_TX_CHANNELS	(1)
 #define PCI11X1X_USED_TX_CHANNELS	(4)
-#define LAN743X_INT_MOD	(400)
+#define LAN743X_INT_MOD_2_5G		(64)
+#define LAN743X_INT_MOD_1G		(150)
+#define LAN743X_INT_MOD_100M		(330)
+#define LAN743X_INT_MOD_10M		(330)
 
 #if (LAN743X_USED_RX_CHANNELS > LAN743X_MAX_RX_CHANNELS)
 #error Invalid LAN743X_USED_RX_CHANNELS
-- 
2.34.1

