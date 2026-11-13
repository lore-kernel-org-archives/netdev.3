Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565980;
	b=yiw4iHzNzY+xC6MPz+2FMgjThc0FQ9RV4ExiMLZXhrwdA7cZPgG3VQt3myShA1guZUoA
	 gliHrc2YNeWnkY8VW6lZURdYZzcFMIT3zfKAR0h0nLqvCZA0swxJ70eMNvLNSeFiFBQCX
	 s6QyLN7nq1S8ODflpArcSv6ZIM5V7l0r5qjznYyNLxEppRFy2/25alXTXmkmmIWpNGikV
	 yrKGeoO290ZPEVe1o4ofkyO8ZXTfGijeVWic3i2CskrlaKDrHJIHHg53ADM7cqgBFaTNo
	 r5ZYzfNpfT/6Y7PupeJxv8ETR/zTDvLdtheabjxAjvnF3HW6Z0yLajgUahh632q/k7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565980;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=5imrvEs41cVSH3fvVbJToFqYBiDffRwl0SlTmuWzR10=;
	b=Vf2NHPaJ+QpLypfX4iz2ElDX0i6S+5Xsk3n+MYPyAntJAQEU65iCZ6+9fFQ3PDJlo0KH
	 4Uuz95/wxRDCW4LRjUEnLKRzM+EqDJKjywqwQFr1csEE28CcQMciJvZaTZhk5i+UXMq0N
	 Pi4ZjMXoDTAJQSpgHnrzmmCeNRGsg2sPC6pkmG4WkXZehgiwNyAVxVzrkmNAEKDoFdxqs
	 1HzZYgnlrYS4pSUeB/sG1XD0DpCWxXHcJ2ri8xtuqku902wK24Jq+k0arVe2ZBX4m3NPX
	 mn+rmKsfii5x9CVwhCu8u++mCGtSIXFgLY9cz8T3bJHJfe87z4DvgehN5mXIEn8ZtJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JIhQsvIN;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1696606A31C;
	Fri, 13 Nov 2026 10:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1696606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=JIhQsvIN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 7FAC4C4EFC8;
	Fri, 13 Nov 2026 10:32:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D94DF601D5;
	Fri, 13 Nov 2026 10:32:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26F9511BC16C6;
	Fri, 13 Nov 2026 11:32:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794565974; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=5imrvEs41cVSH3fvVbJToFqYBiDffRwl0SlTmuWzR10=;
	b=JIhQsvINzwYBKMMipCjNfp/a1rINNSI/ia3cMaVMmIxVcOCxmxFQIgNXMl/7QwMKfFE9LZ
	2qyLvMX0dKisrxMRbfeGpK6L5QRDH0s+QtA6naNobXrUHwtr0Fu1Vm3nvXI0GjNbWzASq5
	/fdHBoJ3c7QRlYUxBUP+dzMm2+J+IbnqbqeOUNhdhTzSXh0mYxvI0z3230DDs9lXdIrw2H
	neTresrg4mN2iwcEpNqh2hhJJUU4fOcwoexiAaMn3QllNvrspaOPJYBbADoFyCYW8r4ztk
	D7FFVAx8r1wivFlq0UeQYgz8SRGHM88J1aJwcV5z9iPvxbsRhE3eUZso9SI/qA==
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
Subject: [PATCH net v3] net: stmmac: Clear DMA errors for multi-channel interrupts
Date: Fri, 13 Nov 2026 11:32:35 +0100
Message-ID: <20261113103236.2184751-1-maxime.chevallier@bootlin.com>
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
stmmac_global_err() upon fatal bus errors.

For that introduce an "ERR" DMA dir, as we don't want to touch the
RI/TI bits when handling these interrupts.

Both of the above storms have been found on dwmac-motorcomm (YT6801),
and are triggered by the xdp.py, xsk_reconfig.py, xdp_features.py,
ring_reconfig.py and netpoll_basic kernel selftests.

This seems to only affect dwmac4, there's no multi-msi mode on
dwmac1000 (except on loongson which I couldn't test), and on
dwxgmac these interrupts are masked as of today.

Fixes: 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for multi-MSI")
Fixes: 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU interrupts")
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Tested-by: Magnus Leatti <magnusleatti@kernelriot.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3:
 - No code changes, just rebase
 - Add all review/test tags (thanks !)
 - Add missing Fixes tag to show the commit that makes the error visible
 - Reword the commit log a bit, this may happen on loongson
V2:
https://lore.kernel.org/netdev/20261103125430.962715-1-maxime.chevallier@bootlin.com/
 - Discarded the helper, call directly stmmac_dma_interrupt_status on
   all chans and use stmmac_global_err() for TX hard errors, following
   sashiko's review.

V1: https://lore.kernel.org/netdev/20261030102251.208929-1-maxime.chevallier@bootlin.com/

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
index 25894771e9e9..0bcbf837d9cc 100644
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
@@ -6498,6 +6514,9 @@ static irqreturn_t stmmac_mac_interrupt(int irq, void *dev_id)
 	/* To handle Common interrupts */
 	stmmac_common_interrupt(priv);
 
+	if (priv->plat->core_type == DWMAC_CORE_GMAC4)
+		stmmac_dma_err_interrupt(priv);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.56.0

