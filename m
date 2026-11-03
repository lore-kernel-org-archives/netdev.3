Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793710489;
	b=L5erfiye2N0p/S1ID1LFqpXbTrYjVtQ5iDFyPLURIF2uVftTAifIiIVkLo52jkqMG3jv
	 g8J+y1iCs46/xKcdyI8BgqjcLnQYxp+X6eo9FQgCwqSuihAMKeEewa3sGL2IrZK/Lk2qL
	 EYAIraOm9PSKjTT7a4Ah/sWbEGo3/hBPaWIoTs10EAa6CIR9WGT1PZhgo+KBH+Y7gAkHj
	 Ua24tx78MdryWnMHX1YB/exXn7huU+Smk7jZFCLi3U4F5fkf5Nv8Qnvh5L84AIdYkONgk
	 uWn04xNl1TT2tT/YNIAYWf/a37vPaMw+klu2IMOdGXCUv/BPGzwMw++jwr/dzEoEM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793710489;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SdD3JViuLyebMZNfF0ybXy7U5RuZHTvrIy6Iv8uugos=;
	b=08gVLV/eOIPamNTDXLCZkrLj8cII/n/0I5gOl4gI6lp+uMViMsbt1YH83inw0VDVoe2l
	 aamegkuKvnwqYIO6OjeLxo2GsYsVYQBZy9vXdNgjeWXP1ePW77Ijs57yKWQAT/GpnyV6z
	 vKRacN+KQ2tRp5ABKz+C/qL0meV+4UOTq2IyhKFYpBmnbFPYsA+48ZPNmORcd7dFUG08U
	 WTh/OCow7Wwbn0yB/CLYUgTkL1dwTtv6Fg+z2d4dgoAwfnovf8Ms5/5MUnGT71/H3k93z
	 YH2WLHRTY1aOfhD/ShWgGQFNRz7uvB8CCVIlOY6WkCDS+6atbVNrH3l8kO94yOe5DvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x2TJVwRr;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B36F606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B36F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x2TJVwRr
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A27081A1438;
	Tue,  3 Nov 2026 12:54:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 608486046C;
	Tue,  3 Nov 2026 12:54:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2F571032919A;
	Tue,  3 Nov 2026 13:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793710480; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=SdD3JViuLyebMZNfF0ybXy7U5RuZHTvrIy6Iv8uugos=;
	b=x2TJVwRrLqBUh/xG8SzQmquVkjJvSBFEpYMJWEwUzpeWWGYBRZw8RWw7QJopMbnQsXYn6/
	1RV2VulSbNAbqLGTcaOshiHYcwaK6mJytKsVg0bOVQ/EIUawWtA78vfnzkBIX3h035VRix
	nWgMx0bY8fLUXbJwnFIrMEwn8UessDClXNwkF+JL64woNbJSjgfkqnEJW64LudWEFpul2I
	h9+8YIHBvcrNa3PJicQnIqx/L3EzlpJjvvz+DclHnsv84PgpcUMJPn9p+PtR/C/Cp/5/Te
	chdNPagkXPkqd9tzv2GZLrdlh5FSKvWJDLH7wksEru6JxaZHm4/RAtdTXcGKgw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Russell King <linux@armlinux.org.uk>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Magnus Leatti <magnusleatti@kernelriot.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v2] net: stmmac: Clear DMA errors for multi-channel interrupts
Date: Tue,  3 Nov 2026 13:54:28 +0100
Message-ID: <20261103125430.962715-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The Multi-MSI interrupt handler doesn't clear the DMA error interrupts,
and this leads to interrupt storms when one of these interrupts starts
firing :

 - The RBU (rx buff unav) which triggers under high traffic load

   This triggers easily with iperf3 and small udp packets, and shows
   when running the netpoll kselftest

 - The RPS (rx process stop) which triggers when we stop the DMA RX.

   This one shows when restarting the RX logic without doing a down/up
   cycle, like when attaching an XDP program. The XSK kselftests
   triggers it.

Let's make sure we clear these interrupts for multi-MSI cases, and call
stmmac_global_err() upon tx_hard_error to avoid possible races with
other interrupts/napi.

For that introduce an "ERR" DMA dir, as we don't want to touch the
RI/TI bits when handling these interrupts.

Both of the above storms have been found on dwmac-motorcomm (YT6801),
and are triggered by the xdp.py, xsk_reconfig.py, xdp_features.py,
ring_reconfig.py and netpoll_basic kernel selftests.

This seems to only affect dwmac4, there's no multi-msi mode on
dwmac1000, and on dwxgmac these interrupts are masked as of today.

Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for multi-MSI")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V2:
 - Dropped reviews/tested tags as the implementation has substantially
   changed, sorry :(
 - Discarded the helper, call directly stmmac_dma_interrupt_status on
   all chans and use stmmac_global_err() for TX hard errors, following
   sashiko's review.

 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  5 +++++
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  |  2 ++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index c74bc7c9750e..a972bee66504 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -382,6 +382,7 @@ enum dma_irq_dir {
 	DMA_DIR_RX = 0x1,
 	DMA_DIR_TX = 0x2,
 	DMA_DIR_RXTX = 0x3,
+	DMA_DIR_ERR = 0x4,
 };
 
 enum request_irq_err {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 43b036d4e95b..a7caac3c98e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -173,6 +173,11 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 					 DMA_CHAN_STATUS_TI | \
 					 DMA_CHAN_STATUS_MSK_COMMON)
 
+#define DMA_CHAN_STATUS_MSK_ERR		(DMA_CHAN_STATUS_AIS | \
+					 DMA_CHAN_STATUS_FBE | \
+					 DMA_CHAN_STATUS_RPS | \
+					 DMA_CHAN_STATUS_RBU)
+
 int dwmac4_dma_reset(void __iomem *ioaddr);
 void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index a0249715fafa..02aa1a3dd1e2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -150,6 +150,8 @@ int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 		intr_status &= DMA_CHAN_STATUS_MSK_RX;
 	else if (dir == DMA_DIR_TX)
 		intr_status &= DMA_CHAN_STATUS_MSK_TX;
+	else if (dir == DMA_DIR_ERR)
+		intr_status &= DMA_CHAN_STATUS_MSK_ERR;
 
 	/* ABNORMAL interrupts */
 	if (unlikely(intr_status & DMA_CHAN_STATUS_AIS)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7ffed295eb14..6360605ef5ea 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3145,6 +3145,22 @@ static int stmmac_napi_check(struct stmmac_priv *priv, u32 chan, u32 dir)
 	return status;
 }
 
+static void stmmac_dma_err_interrupt(struct stmmac_priv *priv)
+{
+	u8 channels_to_check = max(priv->plat->rx_queues_to_use,
+				   priv->plat->tx_queues_to_use);
+	int status;
+	u8 chan;
+
+	for (chan = 0; chan < channels_to_check; chan++) {
+		status = stmmac_dma_interrupt_status(priv, priv->ioaddr,
+						     &priv->xstats, chan,
+						     DMA_DIR_ERR);
+		if (unlikely(status & tx_hard_error))
+			stmmac_global_err(priv);
+	}
+}
+
 /**
  * stmmac_dma_interrupt - DMA ISR
  * @priv: driver private structure
@@ -6494,6 +6510,9 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	/* To handle Common interrupts */
 	stmmac_common_interrupt(priv);
 
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
+		stmmac_dma_err_interrupt(priv);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

