Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B70140F726;
	Mon,  3 Aug 2026 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761344; cv=none; b=F6jd8Izv5tzOVpaj2zDbB6RI4ZBnhkPZSeogfDGrwY2yW3xhaNeGIPpPwOZkIKC4oegbcr9Wk62hg9Tyl8rA77wsWFzQNPDsFhUoZ59KGgodBEOQU0ij03It/PHeCzk3HWFj9KqEN/WcP1CnPPUL11gSZRBk7/G2eBMb1chF+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761344; c=relaxed/simple;
	bh=GR0ysvTVPPZbM5sCxM++GNWStnrEyKw3e6JI0PiOCLI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgYLykgPNrAaIIqylRmg04crPY7C7GzDvdTMmshgMMVibPHqnL1y+EX1NxY7kCQQP3nyycF+4ASzX0tGR3S6RjRvw1CBa9xCFO/a4KslR9bZ/tYLvupEDSvrdCxRmExchUsNYxrHy9lugngVE11KuXTe7VCx7na1sPCBsSoqDcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cQT4vguy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cQT4vguy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785761344; x=1817297344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GR0ysvTVPPZbM5sCxM++GNWStnrEyKw3e6JI0PiOCLI=;
  b=cQT4vguy+ursh/7yctg0VVyn/n2x79Q7xgrRC/61Hg3+gPi+PRPvdovI
   ylzb4W149bNJ0nllUfLkKkQU36StpaMtXmKTv8iwR04/xDSRYl/JEL0YS
   Cqm5e+I7dmH4hTHv2l7Vx1BMf68VcdWSUz7e8rxjJeF/uWquwkCIeLzGs
   hQ0Qd+rDlqcjf/dY9oycRRuYS82n13KDGWm9cqA2qCoWTttrlHCoqizv6
   dMqnUXyPKjyOVQond1nvP5U56tH1Q7nUDvuD4V7+PxNNEvB9gv7FHcxlu
   NuFAumZLpxPy2gM+uNYheX64yIQzh1TjyS+GTzDD5jUXP9iKNvCz4qXcv
   Q==;
X-CSE-ConnectionGUID: viUxfFL+RyaDmhDePGLCEQ==
X-CSE-MsgGUID: S/n7zRy3SjGsbgrGzFJ3sw==
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="292932245"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 05:49:03 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 3 Aug 2026 05:49:02 -0700
Received: from che-ld-ungapp03.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 3 Aug 2026 05:48:58 -0700
From: Dhanushkalyan G <Dhanushkalyan.G@microchip.com>
To: <netdev@vger.kernel.org>
CC: Bryan Whitehead <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Thangaraj
 Samynathan" <Thangaraj.S@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/2] net: lan743x: add ethtool interrupt coalescing support
Date: Mon, 3 Aug 2026 18:18:47 +0530
Message-ID: <20260803124847.17315-3-Dhanushkalyan.G@microchip.com>
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

Build on the speed-based interrupt moderation and let userspace inspect
and override it through ethtool's coalescing interface.

Add .get_coalesce and .set_coalesce and advertise ETHTOOL_COALESCE_USECS
together with ETHTOOL_COALESCE_USE_ADAPTIVE_RX/TX. The hardware programs
one moderation timer value across all per-vector INT_MOD_CFG registers,
so RX and TX cannot be tuned independently: get reports the same value
and adaptive state for both, and set rejects a request whose rx and tx
values (or adaptive flags) differ.

With adaptive coalescing enabled (the default) the timer keeps tracking
the link speed. Turning it off pins the timer to the user supplied value;
values are bounded by the register's maximum. Re-enabling adaptive mode
immediately restores the value for the current link speed. Writes to the
moderation registers are skipped when the value is unchanged.

Signed-off-by: Dhanushkalyan G <Dhanushkalyan.G@microchip.com>
---
 .../net/ethernet/microchip/lan743x_ethtool.c  | 70 +++++++++++++++++++
 drivers/net/ethernet/microchip/lan743x_main.c | 50 +++++++++----
 drivers/net/ethernet/microchip/lan743x_main.h |  9 +++
 3 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 9195419ecee0..76b60b3271be 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1355,7 +1355,77 @@ static int lan743x_set_pauseparam(struct net_device *dev,
 	return phylink_ethtool_set_pauseparam(adapter->phylink, pause);
 }
 
+static int lan743x_ethtool_get_coalesce(struct net_device *netdev,
+					struct ethtool_coalesce *ec,
+					struct kernel_ethtool_coalesce *kernel_coal,
+					struct netlink_ext_ack *extack)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	/* The driver programs the same value into every per-vector
+	 * INT_MOD_CFG register, so RX and TX moderation share one value;
+	 * report it for both.
+	 */
+	ec->rx_coalesce_usecs = adapter->int_mod;
+	ec->tx_coalesce_usecs = adapter->int_mod;
+	ec->use_adaptive_rx_coalesce = adapter->use_adaptive_mod;
+	ec->use_adaptive_tx_coalesce = adapter->use_adaptive_mod;
+
+	return 0;
+}
+
+static int lan743x_ethtool_set_coalesce(struct net_device *netdev,
+					struct ethtool_coalesce *ec,
+					struct kernel_ethtool_coalesce *kernel_coal,
+					struct netlink_ext_ack *extack)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	u32 int_mod;
+
+	/* RX and TX share a single moderation value, so adaptive mode must be
+	 * enabled or disabled for both together.
+	 */
+	if (ec->use_adaptive_rx_coalesce != ec->use_adaptive_tx_coalesce) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "adaptive-rx and adaptive-tx must match");
+		return -EINVAL;
+	}
+
+	if (ec->use_adaptive_rx_coalesce) {
+		/* Resume speed-adaptive moderation and apply the value for the
+		 * current link speed right away.
+		 */
+		adapter->use_adaptive_mod = true;
+		int_mod = lan743x_get_int_mod(adapter->link_speed);
+	} else {
+		/* All per-vector INT_MOD_CFG registers get the same value, so
+		 * RX and TX moderation cannot differ; reject a mismatch.
+		 */
+		if (ec->rx_coalesce_usecs != ec->tx_coalesce_usecs) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "rx-usecs and tx-usecs must be equal");
+			return -EINVAL;
+		}
+		if (ec->rx_coalesce_usecs > LAN743X_INT_MOD_MAX) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "coalesce value exceeds maximum");
+			return -EINVAL;
+		}
+		adapter->use_adaptive_mod = false;
+		int_mod = ec->rx_coalesce_usecs;
+	}
+
+	lan743x_config_int_mod(adapter, int_mod);
+
+	return 0;
+}
+
 const struct ethtool_ops lan743x_ethtool_ops = {
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
+				     ETHTOOL_COALESCE_USE_ADAPTIVE_TX,
+	.get_coalesce = lan743x_ethtool_get_coalesce,
+	.set_coalesce = lan743x_ethtool_set_coalesce,
 	.get_drvinfo = lan743x_ethtool_get_drvinfo,
 	.get_msglevel = lan743x_ethtool_get_msglevel,
 	.set_msglevel = lan743x_ethtool_set_msglevel,
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 20d6a48ca0bb..9e1fb1e02346 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3030,12 +3030,31 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 	netif_tx_stop_all_queues(netdev);
 }
 
+/* Map a link speed to the interrupt moderation timer value to use. */
+u32 lan743x_get_int_mod(int speed)
+{
+	switch (speed) {
+	case SPEED_2500:
+		return LAN743X_INT_MOD_2_5G;
+	case SPEED_1000:
+		return LAN743X_INT_MOD_1G;
+	case SPEED_100:
+		return LAN743X_INT_MOD_100M;
+	default:
+		return LAN743X_INT_MOD_10M;
+	}
+}
+
 /* Program the interrupt moderation timer value into the per-vector
  * INT_MOD_CFG registers. Only the timer value is written here; the vector
  * mapping (INT_MOD_MAP) is static and is set once at interrupt open.
  */
-static void lan743x_config_int_mod(struct lan743x_adapter *adapter, u32 int_mod)
+void lan743x_config_int_mod(struct lan743x_adapter *adapter, u32 int_mod)
 {
+	/* Nothing to do if the value is already programmed in hardware. */
+	if (int_mod == adapter->int_mod)
+		return;
+
 	if (!(adapter->csr.flags & LAN743X_CSR_FLAG_IS_A0)) {
 		lan743x_csr_write(adapter, INT_MOD_CFG0, int_mod);
 		lan743x_csr_write(adapter, INT_MOD_CFG1, int_mod);
@@ -3049,6 +3068,7 @@ static void lan743x_config_int_mod(struct lan743x_adapter *adapter, u32 int_mod)
 			lan743x_csr_write(adapter, INT_MOD_CFG8, int_mod);
 			lan743x_csr_write(adapter, INT_MOD_CFG9, int_mod);
 		}
+		adapter->int_mod = int_mod;
 	}
 }
 
@@ -3061,7 +3081,6 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 {
 	struct net_device *netdev = to_net_dev(config->dev);
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	u32 int_mod;
 	int mac_cr;
 	u8 cap;
 
@@ -3070,18 +3089,12 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 	 * Resulting value corresponds to SPEED_10
 	 */
 	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
-	if (speed == SPEED_2500) {
+	if (speed == SPEED_2500)
 		mac_cr |= MAC_CR_CFG_H_ | MAC_CR_CFG_L_;
-		int_mod = LAN743X_INT_MOD_2_5G;
-	} else if (speed == SPEED_1000) {
+	else if (speed == SPEED_1000)
 		mac_cr |= MAC_CR_CFG_H_;
-		int_mod = LAN743X_INT_MOD_1G;
-	} else if (speed == SPEED_100) {
+	else if (speed == SPEED_100)
 		mac_cr |= MAC_CR_CFG_L_;
-		int_mod = LAN743X_INT_MOD_100M;
-	} else {
-		int_mod = LAN743X_INT_MOD_10M;
-	}
 
 	if (duplex == DUPLEX_FULL)
 		mac_cr |= MAC_CR_DPX_;
@@ -3090,7 +3103,13 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 
 	lan743x_csr_write(adapter, MAC_CR, mac_cr);
 
-	lan743x_config_int_mod(adapter, int_mod);
+	/* Track the link speed so a later ethtool request to re-enable
+	 * adaptive moderation can restore the speed-based value, and refresh
+	 * the timer now when adaptive moderation is active.
+	 */
+	adapter->link_speed = speed;
+	if (adapter->use_adaptive_mod)
+		lan743x_config_int_mod(adapter, lan743x_get_int_mod(speed));
 
 	lan743x_ptp_update_latency(adapter, speed);
 
@@ -3557,6 +3576,13 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	adapter->intr.irq = adapter->pdev->irq;
 	lan743x_csr_write(adapter, INT_EN_CLR, 0xFFFFFFFF);
 
+	/* Enable speed-adaptive interrupt moderation by default and program
+	 * the timer for the default (1G) value until the link comes up.
+	 */
+	adapter->use_adaptive_mod = true;
+	adapter->link_speed = SPEED_UNKNOWN;
+	lan743x_config_int_mod(adapter, LAN743X_INT_MOD_1G);
+
 	ret = lan743x_gpio_init(adapter);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index c4a3de7fe107..9e6ac8fdbf37 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -865,6 +865,7 @@ struct lan743x_adapter;
 #define LAN743X_INT_MOD_1G		(150)
 #define LAN743X_INT_MOD_100M		(330)
 #define LAN743X_INT_MOD_10M		(330)
+#define LAN743X_INT_MOD_MAX		(8191)
 
 #if (LAN743X_USED_RX_CHANNELS > LAN743X_MAX_RX_CHANNELS)
 #error Invalid LAN743X_USED_RX_CHANNELS
@@ -1091,6 +1092,12 @@ struct lan743x_adapter {
 	phy_interface_t		phy_interface;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+	/* Interrupt moderation timer value currently programmed in hardware. */
+	u32			int_mod;
+	/* When set, the moderation timer tracks the link speed automatically. */
+	bool			use_adaptive_mod;
+	/* Last negotiated link speed, used to derive the adaptive value. */
+	int			link_speed;
 	int			rx_tstamp_filter;
 };
 
@@ -1212,5 +1219,7 @@ void lan743x_hs_syslock_release(struct lan743x_adapter *adapter);
 void lan743x_mac_flow_ctrl_set_enables(struct lan743x_adapter *adapter,
 				       bool tx_enable, bool rx_enable);
 int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr);
+void lan743x_config_int_mod(struct lan743x_adapter *adapter, u32 int_mod);
+u32 lan743x_get_int_mod(int speed);
 
 #endif /* _LAN743X_H */
-- 
2.34.1

