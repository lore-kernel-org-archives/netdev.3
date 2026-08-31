Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76A3C1D48;
	Mon, 31 Aug 2026 07:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159711; cv=none; b=Cb9eOT0qMAN0pvu8Sy6v1ZgB6A+WSYesyzde9vFwJTsi7W1yP5e9Qhf95wVZiqxETXYD/1/AlVzqm+A2e7mrfcEvsy8jgg6yTexu8b0FVT6k2QvfzjTkBiaA9ZthBFUSFYGCB9d/BGhqlfTwJPsOv2GvV+eXuAbgsMEbrSOKUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159711; c=relaxed/simple;
	bh=vr16G4wN7hEj/Zto23NchPROMzUplCl5PfKrXcV1gd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFkuVxkiyA9mWUYqctUKDBYL08KLtIEC7ux86oGA3uXz6xo/b3jytrtPcR8OJINUtvyEnHz24FQL8gr3c4tPzOusaWy9PgWr7YTRrOaY2VfpXOnlpW8XpOdn4CsCT+BN+omPDLQMy1HZ0h/NneCfiG7AuTFzigEqO66c4fxArTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QmAmucBe; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QmAmucBe"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9AF954E41466;
	Mon, 31 Aug 2026 07:01:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6DA51601E1;
	Mon, 31 Aug 2026 07:01:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F138611C78A06;
	Mon, 31 Aug 2026 09:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788159706; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=juuyW3Kt/fpD/0ZCK+TZEpPZ+AIKb80yrzD5yjL1arI=;
	b=QmAmucBeoad7CAsIQV1owfz7t1X9M7w0/cFKZwaq1BWL6Hdp+z7ZgHNRfb958CD4Hwh88m
	O+gfR+1hGmHA0Um2cxJ2CoBKrhwYzvULC+3lN9NObaKaegXDcGg7tAei7f5ldV4wx8zbCI
	Fi/Lq5Ft4voh03MRr/orqu7z61Z9aMpQglk6+zEiIwp5GokAcqN5W5C1+OOkDlQIQGX9W0
	+8enFWGRMAI75thOjv1h7A746SUZo/K2Wt3wIvXq4Ivv23R1Bwg+rYfOPGOuDygzty8hKc
	jfRyl5F29YAn2TuxpT76YRShohUmEVWbZfZimE38iZxIt7sKGa0OvMKhG1c6bw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 2/2] net: stmmac: dwmac4: Use the full perfect filter ability for UC filter
Date: Mon, 31 Aug 2026 09:01:20 +0200
Message-ID: <20260831070121.349778-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Contrary to dwmac1000 that gets its number of perfect filter entries
through the 'snps,perfect-filter-entries' property, dwmac4 allows
reading the filter size from the HW features registers.

Perfect filter is used for Unicast filtering, and can contain up to 128
entries, each having its own set of registers to access it.

The registers are always at the same location in the map, regardless
whether or not the entry is implemented in hardware. Accessing a register
for an un-implemented entry just doesn't do anything.

The filter is made of one always-available entry, and 3 configurable
banks :

 Entry 0 : Always implemented, stores the primary MAC address

 Entry 1  \
  ...     + -- Can contain between 0 and 31 entries. Number of available
 Entry 31 /    entries in HW_Features0[18:22].

 Entry 32 \
  ...     + -- Additional 32 entries, all or nothing. Availability is
 Entry 63 /    specified by HW_Features0[23]

 Entry 64  \
  ...      + - Additional 64 entries, all or nothing. Availability is
 Entry 127 /   specified by HW_Features0[24].

Each of the 3 configurable banks are independently selectable, meaning
we can have gaps in the register banks.

For instance, a setup with 50 addresses enabled will have 17 entries in
the first bank and the additional 32 bank enabled (50 = 32 + 17 + 1).

Another example with 70 addresses : 64 addr bank on, 5 addresses in the
first bank (70 = 64 + 5 + 1).

While I haven't seen HW with gaps in the banks, Synopsys confirmed this
is a real possibility.

Let's therefore introduce a dwmac4 helper to get the physical slot
number of a given entry, allowing to configure the correct bank when
populating the filter. As we need the HW feature-set to compute the
index, store the bank info in the mac_device_info struct.

The total number of available entries is computed based on the
discovered parameters, instead of using the default value of 1.

Results on HW that uses dwmac4 :

 - imx8mp   : goes from 1 entry to 64 (1 + 31 + 32)
 - stm32mp1 : goes from 1 entry to 4 (1 + 3)
 - jh7110   : goes from 1 entry to 9 (1 + 8)
 - yt6801   : goes from 1 entry to hum, 1 entry (no extra addresses)

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  3 +
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h  |  2 -
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 60 +++++++++++++++----
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 27 +++++++++
 4 files changed, 80 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 77bd47a83357..1729fb29ece3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -629,6 +629,7 @@ struct mac_device_info {
 	void __iomem *pcsr;     /* vpointer to device CSRs */
 	unsigned int multicast_filter_bins;
 	unsigned int unicast_filter_entries;
+	unsigned int multi_addr;
 	unsigned int mcast_bits_log2;
 	unsigned int rx_csum;
 	unsigned int num_vlan;
@@ -637,6 +638,8 @@ struct mac_device_info {
 	u8 vlan_fail_q;
 	bool hw_vlan_en;
 	bool reverse_sgmii_enable;
+	bool additional_32_addr;
+	bool additional_64_addr;
 
 	/* This spinlock protects read-modify-write of the interrupt
 	 * mask/enable registers.
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index 89368e34a388..696846531229 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -75,8 +75,6 @@
 #define GMAC_PACKET_FILTER_IPFE		BIT(20)
 #define GMAC_PACKET_FILTER_RA		BIT(31)
 
-#define GMAC_MAX_PERFECT_ADDRESSES	128
-
 /* MAC RX Queue Enable */
 #define GMAC_RX_QUEUE_CLEAR(queue)	~(GENMASK(1, 0) << ((queue) * 2))
 #define GMAC_RX_AV_QUEUE_ENABLE(queue)	BIT((queue) * 2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index 18b357b257cc..fb5b96a43505 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -365,22 +365,63 @@ static void dwmac4_pmt(struct mac_device_info *hw, unsigned long mode)
 	writel(pmt, ioaddr + GMAC_PMT);
 }
 
+/**
+ * dwmac4_umac_addr_slot - Get the UC filter slot for the Nth MAC address
+ * @hw: The MAC device info
+ * @reg_n: The MAC address's index in the UC list
+ *
+ * On dwmac4 the slots available for Unicast MAC filtering are configured when
+ * integrating the IP.
+ *
+ *  - Slot 0 is always available, used to store the primary MAC address
+ *  - From 1 to 31, the number of implemented slots is set in hw->multi_addr
+ *  - From 32 to 63, the range is available if hw->additional_32_addr
+ *    is set
+ *  - From 64 to 127, the range is available if hw->additional_64_addr is set
+ *
+ * All the ranges can be configured independently (e.g. 64 -> 127 can be
+ * available, but not 32 -> 63)
+ *
+ * Returns: The physical slot index in the UC filter
+ */
+static unsigned int dwmac4_umac_addr_slot(struct mac_device_info *hw,
+					  unsigned int reg_n)
+{
+	unsigned int empty_slots = 0;
+
+	/* reg_n is in the 1-31 bank : 1 to 1 mapping */
+	if (reg_n < (hw->multi_addr + 1))
+		return reg_n;
+
+	/* Gap between the last address in the 1->31 range and the next slot */
+	if (hw->additional_32_addr)
+		empty_slots = 32 - (hw->multi_addr + 1);
+	else if (hw->additional_64_addr)
+		empty_slots = 64 - (hw->multi_addr + 1);
+
+	return reg_n + empty_slots;
+}
+
 static void dwmac4_set_umac_addr(struct mac_device_info *hw,
 				 const unsigned char *addr, unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
+	unsigned int slot;
 
-	stmmac_dwmac4_set_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n),
-				   GMAC_ADDR_LOW(reg_n));
+	slot = dwmac4_umac_addr_slot(hw, reg_n);
+	stmmac_dwmac4_set_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(slot),
+				   GMAC_ADDR_LOW(slot));
 }
 
 static void dwmac4_get_umac_addr(struct mac_device_info *hw,
 				 unsigned char *addr, unsigned int reg_n)
 {
 	void __iomem *ioaddr = hw->pcsr;
+	unsigned int slot;
 
-	stmmac_get_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(reg_n),
-			    GMAC_ADDR_LOW(reg_n));
+	slot = dwmac4_umac_addr_slot(hw, reg_n);
+	stmmac_get_mac_addr(ioaddr, addr, GMAC_ADDR_HIGH(slot),
+			    GMAC_ADDR_LOW(slot));
 }
 
 static int dwmac4_set_lpi_mode(struct mac_device_info *hw,
@@ -522,9 +563,6 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 
 	/* Handle multiple unicast addresses */
 	if (netdev_uc_count(dev) + 1 > hw->unicast_filter_entries) {
-		/* Switch to promiscuous mode if more than 128 addrs
-		 * are required
-		 */
 		value |= GMAC_PACKET_FILTER_PR;
 	} else {
 		struct netdev_hw_addr *ha;
@@ -535,9 +573,11 @@ static void dwmac4_set_filter(struct mac_device_info *hw,
 			reg++;
 		}
 
-		while (reg < GMAC_MAX_PERFECT_ADDRESSES) {
-			writel(0, ioaddr + GMAC_ADDR_HIGH(reg));
-			writel(0, ioaddr + GMAC_ADDR_LOW(reg));
+		while (reg < hw->unicast_filter_entries) {
+			unsigned int slot = dwmac4_umac_addr_slot(hw, reg);
+
+			writel(0, ioaddr + GMAC_ADDR_HIGH(slot));
+			writel(0, ioaddr + GMAC_ADDR_LOW(slot));
 			reg++;
 		}
 	}
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a885f8cfef21..80413ba8df55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7492,6 +7492,33 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		priv->plat->tx_fifo_size = priv->dma_cap.tx_fifo_size;
 	}
 
+	/* On DWMAC4 we can get the exact number of perfect filter entries from
+	 * the HW_Features.
+	 */
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4) {
+		priv->hw->multi_addr = priv->dma_cap.multi_addr;
+		priv->hw->additional_32_addr =
+			!!priv->dma_cap.additional_32_addr;
+		priv->hw->additional_64_addr =
+			!!priv->dma_cap.additional_64_addr;
+
+		/* We always have one slot for the primary MAC */
+		priv->hw->unicast_filter_entries = 1;
+
+		/* How many slots in the 1 -> 31 range */
+		priv->hw->unicast_filter_entries += priv->hw->multi_addr;
+
+		/* Additional 32 entries in the 32 -> 63 range */
+		if (priv->hw->additional_32_addr)
+			priv->hw->unicast_filter_entries += 32;
+
+		/* Additional 64 entries in the 64 -> 127 range, can be enabled
+		 * independently of the 32 -> 63 range
+		 */
+		if (priv->hw->additional_64_addr)
+			priv->hw->unicast_filter_entries += 64;
+	}
+
 	priv->hw->vlan_fail_q_en =
 		(priv->plat->flags & STMMAC_FLAG_VLAN_FAIL_Q_EN);
 	priv->hw->vlan_fail_q = priv->plat->vlan_fail_q;
-- 
2.55.0

