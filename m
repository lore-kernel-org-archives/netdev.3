Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0EE43D51D
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518475; cv=none; b=U2ZA8FozPkDuLTycZcGThJx41p0JDy65HX80JQ6cPrNDkl6uLIzoGpvYEoB7ofm5lM1Ucv5+Pa2shb5CujMKFMp7+whHh3Qe8LZZNCcgGsmyLCPgQ1mX4oGlw+VV4ThF+ivKDBLeHvPEgwFmJLy0IMTZnXrGbK82IcTNNY0j1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518475; c=relaxed/simple;
	bh=SVY+XzL0WRDAJjMhItC3YD50ZcERn+q0TE8v6fBNfM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=rD2PPyOPUNnZknitgbNnzoKF+mXlpswy4cEa1g9/BTvixkajSgTZcIqazxbiKojWJClQMZ5VOKZn6AWk/8bQzbj6GNX6GA8BNO2VnVuo0cDgloSbS1g2sS2C1t09k317wI3J91CZYChTo40HQE/VE0K7aA6ou/nSv9DwVXXQfxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Fctkq09b; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Fctkq09b"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260511165431euoutp026aa3f4647012cea30f48afeb2f0551ab~ukSCI9acc2270322703euoutp02c
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 16:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260511165431euoutp026aa3f4647012cea30f48afeb2f0551ab~ukSCI9acc2270322703euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778518471;
	bh=j+KDbBeZiTJB3Xxk2nJkbFoxlnLlfncScFtlZ8JdPyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fctkq09btKitXriRb326UeAM2FTF3CjyKS/1GuPOMY40gfPfvO8i7anx9rPr9MB/y
	 hIvrkTffePqUSjSyKsNprYgYVh3OMocXG1P47FPZXBm9k7JRznZVuVt5VMfLIN9q9A
	 qVCOCbvuEIkjoiXH5gzIffeG1hT8iMJB3UXMEj8A=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50~ukSBtk2iA0891108911eucas1p1s;
	Mon, 11 May 2026 16:54:31 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260511165430eusmtip1621855ac988d4d7a980dd00603ecea3b~ukSAxOhfX2739027390eusmtip1D;
	Mon, 11 May 2026 16:54:30 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Jakub Raczynski
	<j.raczynski@samsung.com>
Subject: [PATCH net-next 1/3] net/stmmac/dwxgmac: Modify DMA functions for
 future hardware
Date: Mon, 11 May 2026 18:54:14 +0200
Message-Id: <20260511165416.3093015-2-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260511165416.3093015-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
X-EPHeader: CA
X-CMS-RootMailID: 20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50
References: <20260511165416.3093015-1-j.raczynski@samsung.com>
	<CGME20260511165431eucas1p1450bdea6486a72257f6463d5f40abc50@eucas1p1.samsung.com>

Datasheet for newer hardware of XGMAC (3.20a and 3.40a) list support for
up to 16 DMA/MTL queues. Currently maximum amount of queues in 8 set by
STMMAC_CH_MAX, MTL_MAX_TX_QUEUES, MTL_MAX_RX_QUEUES macros.
But before we set these to higher value there are changes to be made.

While newer hardware supports up to 16 MTL/DMA queues, there is support only
for 8 TC's (traffic control) entries. Current source assumes these are equal,
which might not be true. While in some cases it would be just incorrect value,
there are possible wrong memory accesses.

Fix this by saving number of TC supported by hardware in mac_device_info and
verify it in related functions. Also use TC count rather than MTL_MAX values
where it applies.

Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h    |  1 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 17 ++++++++++++++++-
 .../net/ethernet/stmicro/stmmac/dwxgmac2_dma.c  | 14 ++++++++++++--
 .../net/ethernet/stmicro/stmmac/stmmac_main.c   |  5 ++++-
 4 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index 927ea6230073..c25ff649a847 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -630,6 +630,7 @@ struct mac_device_info {
 	unsigned int mcast_bits_log2;
 	unsigned int rx_csum;
 	unsigned int num_vlan;
+	u8 num_tc;
 	u32 vlan_filter[32];
 	bool vlan_fail_q_en;
 	u8 vlan_fail_q;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f02b434bbd50..98b3e0cc84fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -102,6 +102,9 @@ static void dwxgmac2_rx_queue_prio(struct mac_device_info *hw, u32 prio,
 	u32 ctrl2, ctrl3;
 	int i;
 
+	if (WARN_ONCE(queue >= hw->num_tc, "invalid RX prio queue"))
+		return;
+
 	ctrl2 = readl(ioaddr + XGMAC_RXQ_CTRL2);
 	ctrl3 = readl(ioaddr + XGMAC_RXQ_CTRL3);
 
@@ -141,6 +144,9 @@ static void dwxgmac2_tx_queue_prio(struct mac_device_info *hw, u32 prio,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value, reg;
 
+	if (WARN_ONCE(queue >= hw->num_tc, "invalid TX prio queue"))
+		return;
+
 	reg = (queue < 4) ? XGMAC_TC_PRTY_MAP0 : XGMAC_TC_PRTY_MAP1;
 	if (queue >= 4)
 		queue -= 4;
@@ -233,7 +239,7 @@ static void dwxgmac2_prog_mtl_tx_algorithms(struct mac_device_info *hw,
 	writel(value, ioaddr + XGMAC_MTL_OPMODE);
 
 	/* Set ETS if desired */
-	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
+	for (i = 0; i < hw->num_tc; i++) {
 		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
 		value &= ~XGMAC_TSA;
 		if (ets)
@@ -248,6 +254,9 @@ static void dwxgmac2_set_mtl_tx_queue_weight(struct stmmac_priv *priv,
 {
 	void __iomem *ioaddr = hw->pcsr;
 
+	if (WARN_ONCE(queue >= hw->num_tc, "invalid MTL TC queue"))
+		return;
+
 	writel(weight, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
 }
 
@@ -276,6 +285,9 @@ static void dwxgmac2_config_cbs(struct stmmac_priv *priv,
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
 
+	if (WARN_ONCE(queue >= hw->num_tc, "invalid TC queue"))
+		return;
+
 	writel(send_slope, ioaddr + XGMAC_MTL_TCx_SENDSLOPE(queue));
 	writel(idle_slope, ioaddr + XGMAC_MTL_TCx_QUANTUM_WEIGHT(queue));
 	writel(high_credit, ioaddr + XGMAC_MTL_TCx_HICREDIT(queue));
@@ -366,6 +378,9 @@ static void dwxgmac2_flow_ctrl(struct mac_device_info *hw, unsigned int duplex,
 		for (i = 0; i < tx_cnt; i++) {
 			u32 value = XGMAC_TFE;
 
+			if (WARN_ONCE(i >= hw->num_tc, "invalid TC queue"))
+				break;
+
 			if (duplex)
 				value |= FIELD_PREP(XGMAC_PT, pause_time);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf3df..6ac9e86f5faa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -204,8 +204,18 @@ static void dwxgmac2_dma_tx_mode(struct stmmac_priv *priv, void __iomem *ioaddr,
 		value = u32_replace_bits(value, ttc, XGMAC_TTC);
 	}
 
-	/* Use static TC to Queue mapping */
-	value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);
+	/* Newer XGMAC hardware does support up to 16 MTL/DMA queues but
+	 * only 8 traffic class queues. Redirect these, but this is error in
+	 * configuration.
+	 */
+	if (channel >= priv->hw->num_tc) {
+		dev_err(priv->device,
+			"Wrong channel set for TX mode, redirecting to TC 0\n");
+		value |= FIELD_PREP(XGMAC_Q2TCMAP, 0);
+	} else {
+		/* Use static TC to Queue mapping */
+		value |= FIELD_PREP(XGMAC_Q2TCMAP, channel);
+	}
 
 	if (qmode != MTL_QUEUE_AVB)
 		txqen = 0x2;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3591755ea30b..a1ec3864009e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4140,7 +4140,7 @@ static int __stmmac_open(struct net_device *dev,
 	u8 chan;
 	int ret;
 
-	for (int i = 0; i < MTL_MAX_TX_QUEUES; i++)
+	for (int i = 0; i < priv->plat->tx_queues_to_use; i++)
 		if (priv->dma_conf.tx_queue[i].tbs & STMMAC_TBS_EN)
 			dma_conf->tx_queue[i].tbs = priv->dma_conf.tx_queue[i].tbs;
 	memcpy(&priv->dma_conf, dma_conf, sizeof(*dma_conf));
@@ -7443,6 +7443,9 @@ static int stmmac_hw_init(struct stmmac_priv *priv)
 		else
 			priv->plat->tx_coe = priv->dma_cap.tx_coe;
 
+		/* set number of traffic class queues */
+		priv->hw->num_tc = priv->dma_cap.numtc;
+
 		/* In case of GMAC4 rx_coe is from HW cap register. */
 		priv->plat->rx_coe = priv->dma_cap.rx_coe;
 
-- 
2.34.1

