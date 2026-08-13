Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ABF33FE0A
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607410; cv=none; b=lI6H9d0BRkToqerdEsUd4sOpD/ro2n3ORSYYkp9uvN7lr8CClteV/LDcWhNgUWDjH+JBKUufzu5aenNQUlWq4D5XkRPCA3p2JagtbTj9Bz1CvZ5e0GJ/I51NyDNBEVsLO7gOytH3z4PtOZosBrOyBpmSH4yoaC6ZA9ghOr67pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607410; c=relaxed/simple;
	bh=ESYZxOpjwQJFQGrvK/0fmHBJZ2ApGs1FgMq+WLSbmd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eacE5vZXJaFjtE0fToygRsheLMaSFbcXqhx4/0zVHkLl6k7TM7UIIPR1nAEZaFybWf2JPEz69QccE+XLlcEjqlP3JH4BtERihRRW1lWA306DkeQrOC5x5z0uPQyXZdIFuLnjhpKYMlgpPgnxiZwLFuaSYtHbTXtrm9toFrwvWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3YNhOiP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3YNhOiP"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4994c49f588so6211855e9.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786607404; x=1787212204; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YyaXUhTvhHU7Joz+YfrB+Nc3RvMRMX63RZ0iNVi1yIM=;
        b=D3YNhOiPYh+S3rih0o8hM4O5CZl5WahCh6LmUMZnS8QZhMApH1iwMvCd7AGoAIWiDh
         4MNdUbUrZN1f4AEBbi6eQPmLGpk8PCcb4ayPomCHSRRiek+dNYMXEgk3N5f5dhew7Vnf
         fI8JmzumU8tinlBWmlhn5RhHFbUvLvXrwWCOZTuedPsofB6eUyuScX0JcU50yNryYolb
         CfvSdMX+F67jz5GqxX1Zu4OqBk50tzbiVeN/zZugg7RvNuvCiRZ7M9cIQVDkon1CzvNv
         PhffshvkTxWIPQY7YERVteWATnYT3TuAbBIqD2eCqa6kdtyXZzHLMC+hZ1bKC+S7btyO
         g7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786607404; x=1787212204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YyaXUhTvhHU7Joz+YfrB+Nc3RvMRMX63RZ0iNVi1yIM=;
        b=WUORqS2ToeL4IYnBj6zQSV80EcmXieeWVrLlkDg8XvFd4PG7Qv2400dbdY/kd+OsOo
         HOuF4ySqIgfumkaPN4UAopn+uQOgPxamMgd7alnaUBah3azUQs9I17BzP6cK3oXFht0k
         /phDhTP2eRcsBQK136saPrtup9uW10StRp5m2SI+IK9Dt8lEVlP/vW10QmbAjCcV3QRn
         GSwNR1M9OELDyM1fsdXQ7/9/jXM0zm63R2ivyjKYudDhYEcznKpZteNKsKM2CHM0S0sT
         uQSAUODgHBNZ0qZAx6/4gap0nQd3gKJNICk3Pnw3i6KswCzbgpMASHZX8bBPHNcViiAz
         eOYw==
X-Gm-Message-State: AOJu0YyUqRG7hkKR66K8OfXd35GGLXzFmNq64NbXP3uPaH/3Wr7E23eM
	H4UYjWBX8JS5IxcIhMfltA1YgcdKDj3s61/rM/5hrMen5gYa5VECgSYf
X-Gm-Gg: AR+sD10l5Uo4sSMm7/+dD/VZHQk7wo13ccKPNKtLrlyjZ1IvOe/w8k4qNXDES8OfwRW
	o30G7bqLcu1Fi9C7vrOg8ITrezBuJoBwzqLHJrT/fLu2TCUeSgSMadZ7NXaLgi/VMvf5O5q268m
	cACNdE8VrDKtQMbblJN9oW2wJF9GSWUPipAOfc2hC/B/tKkQKdZD50elEh8LouTQnQeniqE9wLt
	fsuElUDeeISUAwbKAs2hDe0JjMUV1ss+CBpU4vWO4BiMbPFk5+A8blEmf8F8Vwb72xeqb/UdGQ4
	oQ1onsIdQJeQhOx05izy6WDVokEbPO8V1sJRBn4flWv3pxSRXFvHM/b66QMF59ZWL+9uJ3R7pKe
	LPtpE3LtJUhSc3DUGvuopF6vICzgYdZb2Gg+P2481Mb+PL8zpQv5Xo8OoBffML04O+C6em3xs8I
	NEPvd5iZJ1BHn8AmrNuNDZKu0SuehPzTCBNaLMEYdDEqha9acflEoDNmtrBLR5q5knlcwYdNc/r
	Gemats1cqBl7e0zumYENqA7r+F504S3bzso1SXvTtbUCEfVNFQ=
X-Received: by 2002:a05:600c:630a:b0:499:77ba:4b6 with SMTP id 5b1f17b1804b1-4998222a8famr36829225e9.9.1786607403673;
        Thu, 13 Aug 2026 00:50:03 -0700 (PDT)
Received: from INBSWN167928.ad.harman.com (bba-86-96-6-50.alshamil.net.ae. [86.96.6.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b62894sm41936365e9.13.2026.08.13.00.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 00:50:03 -0700 (PDT)
From: Abid Ali <dev.taqnialabs@gmail.com>
Date: Thu, 13 Aug 2026 07:49:28 +0000
Subject: [PATCH v3 2/3] net: stmmac: xgmac: tear the datapath down in the
 documented order
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-stmmac-rx-fifo-block-v3-2-738acbee55d9@gmail.com>
References: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
In-Reply-To: <20260813-stmmac-rx-fifo-block-v3-0-738acbee55d9@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Qingfang Deng <qingfang.deng@linux.dev>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Abid Ali <dev.taqnialabs@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786607395; l=12201;
 i=dev.taqnialabs@gmail.com; s=20260425; h=from:subject:message-id;
 bh=ESYZxOpjwQJFQGrvK/0fmHBJZ2ApGs1FgMq+WLSbmd0=;
 b=tYbzLeG7G/0yhXYb4VLzTrgDosPst99sgrGbG0SCj1jk3diHOZTIEGg+1zaCREpzhritq7zyu
 KjdcUq0eTq6AtNre+gBqvZoBZZAn3/TSI4upF6Nc4yHhHozyitZmNoc
X-Developer-Key: i=dev.taqnialabs@gmail.com; a=ed25519;
 pk=4Syx51HH/MOySSUpi79M2ToLOdwt1yiNb338eKZBJNk=

The driver stops all DMA channels at once and only some paths disable
the MAC afterwards. The databook requires the reverse order with a wait
at each stage, otherwise a frame can be left stranded in the MTL FIFOs
and reappear as corruption on the next bring-up.

Add four optional DMA callbacks and drive them from a new
stmmac_datapath_teardown():

  1) stop the Tx DMA channels, wait for stopped
  2) wait for the MTL Tx queues to drain into the MAC
  3) disable the MAC Tx and Rx
  4) wait for the MTL Rx queues to drain into the Rx DMA
  5) stop the Rx DMA channels, wait for stopped

These are implemented for the XGMAC variant.

TPS and RPS are latched, so clear them in the matching start op.
__stmmac_release() calls phylink_stop() after the teardown rather than
before it, as mac_link_down() clears TE and RE and stages 2 and 4
cannot progress once the MAC is disabled.

The Wake-on-LAN path in stmmac_suspend() keeps the old sequence, as it
has to leave the receiver enabled.

Signed-off-by: Abid Ali <dev.taqnialabs@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  8 +++
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 82 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h         | 17 +++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  | 73 ++++++++++++++-----
 4 files changed, 164 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 51943705a..2e3f26000 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -291,6 +291,10 @@
 #define XGMAC_TTC			GENMASK(6, 4)
 #define XGMAC_TXQEN			GENMASK(3, 2)
 #define XGMAC_TSF			BIT(1)
+#define XGMAC_MTL_TXQ_DEBUG(x)		(0x00001108 + (0x80 * (x)))
+#define XGMAC_TXQSTS			BIT(4)
+#define XGMAC_TRCSTS			GENMASK(2, 1)
+#define XGMAC_TRCSTS_READ		0x1
 #define XGMAC_MTL_TCx_ETS_CONTROL(x)	(0x00001110 + (0x80 * (x)))
 #define XGMAC_MTL_TCx_QUANTUM_WEIGHT(x)	(0x00001118 + (0x80 * (x)))
 #define XGMAC_MTL_TCx_SENDSLOPE(x)	(0x0000111c + (0x80 * (x)))
@@ -306,6 +310,9 @@
 #define XGMAC_EHFC			BIT(7)
 #define XGMAC_RSF			BIT(5)
 #define XGMAC_RTC			GENMASK(1, 0)
+#define XGMAC_MTL_RXQ_DEBUG(x)		(0x00001148 + (0x80 * (x)))
+#define XGMAC_PRXQ			GENMASK(29, 16)
+#define XGMAC_RXQSTS			GENMASK(5, 4)
 #define XGMAC_MTL_RXQ_FLOW_CONTROL(x)	(0x00001150 + (0x80 * (x)))
 #define XGMAC_RFD			GENMASK(31, 17)
 #define XGMAC_RFA			GENMASK(15, 1)
@@ -389,6 +396,7 @@
 #define XGMAC_NIS			BIT(15)
 #define XGMAC_AIS			BIT(14)
 #define XGMAC_FBE			BIT(12)
+#define XGMAC_RPS			BIT(8)
 #define XGMAC_RBU			BIT(7)
 #define XGMAC_RI			BIT(6)
 #define XGMAC_TBU			BIT(2)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 03437f1cf..df3700a0d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -4,6 +4,7 @@
  * stmmac XGMAC support.
  */
 
+#include <linux/bitfield.h>
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "dwxgmac2.h"
@@ -251,6 +252,9 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 {
 	u32 value;
 
+	/* TPS is latched once set, so clear it on every Tx DMA start. */
+	writel(XGMAC_TPS, ioaddr + XGMAC_DMA_CH_STATUS(chan));
+
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value |= XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
@@ -279,6 +283,9 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 {
 	u32 value;
 
+	/* RPS is latched once set, so clear it on every Rx DMA start. */
+	writel(XGMAC_RPS, ioaddr + XGMAC_DMA_CH_STATUS(chan));
+
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 	value |= XGMAC_RXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
@@ -582,6 +589,77 @@ static int dwxgmac2_enable_tbs(struct stmmac_priv *priv, void __iomem *ioaddr,
 	return 0;
 }
 
+static int dwxgmac2_tx_dma_stopped(struct stmmac_priv *priv,
+				   void __iomem *ioaddr, u32 chan)
+{
+	u32 value;
+	int ret;
+
+	ret = readl_poll_timeout(ioaddr + XGMAC_DMA_CH_STATUS(chan), value,
+				 value & XGMAC_TPS, 100, 10000);
+	if (ret)
+		netdev_warn(priv->dev, "Tx DMA channel %u stop timeout\n",
+			    chan);
+
+	return ret;
+}
+
+static int dwxgmac2_tx_mtl_drain(struct stmmac_priv *priv,
+				 void __iomem *ioaddr, u32 queue)
+{
+	u32 value;
+	int ret;
+
+	/* Wait until the queue is empty and its read controller is no longer
+	 * pulling a frame out towards the MAC.
+	 */
+	ret = readl_poll_timeout(ioaddr + XGMAC_MTL_TXQ_DEBUG(queue), value,
+				 !(value & XGMAC_TXQSTS) &&
+				 FIELD_GET(XGMAC_TRCSTS, value) !=
+				 XGMAC_TRCSTS_READ,
+				 100, 10000);
+	if (ret)
+		netdev_warn(priv->dev, "MTL Tx queue %u drain timeout\n",
+			    queue);
+
+	return ret;
+}
+
+static int dwxgmac2_rx_mtl_drain(struct stmmac_priv *priv,
+				 void __iomem *ioaddr, u32 queue)
+{
+	u32 value;
+	int ret;
+
+	/* Wait until no packet is left in the queue and the queue reports
+	 * itself empty.
+	 */
+	ret = readl_poll_timeout(ioaddr + XGMAC_MTL_RXQ_DEBUG(queue), value,
+				 !FIELD_GET(XGMAC_PRXQ, value) &&
+				 !FIELD_GET(XGMAC_RXQSTS, value),
+				 100, 10000);
+	if (ret)
+		netdev_warn(priv->dev, "MTL Rx queue %u drain timeout\n",
+			    queue);
+
+	return ret;
+}
+
+static int dwxgmac2_rx_dma_stopped(struct stmmac_priv *priv,
+				   void __iomem *ioaddr, u32 chan)
+{
+	u32 value;
+	int ret;
+
+	ret = readl_poll_timeout(ioaddr + XGMAC_DMA_CH_STATUS(chan), value,
+				 value & XGMAC_RPS, 100, 10000);
+	if (ret)
+		netdev_warn(priv->dev, "Rx DMA channel %u stop timeout\n",
+			    chan);
+
+	return ret;
+}
+
 const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.reset = dwxgmac2_dma_reset,
 	.init = dwxgmac2_dma_init,
@@ -610,4 +688,8 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
 	.set_bfsize = dwxgmac2_set_bfsize,
 	.enable_sph = dwxgmac2_enable_sph,
 	.enable_tbs = dwxgmac2_enable_tbs,
+	.tx_dma_stopped = dwxgmac2_tx_dma_stopped,
+	.tx_mtl_drain = dwxgmac2_tx_mtl_drain,
+	.rx_mtl_drain = dwxgmac2_rx_mtl_drain,
+	.rx_dma_stopped = dwxgmac2_rx_dma_stopped,
 };
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index e6317b94f..23a6915ac 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -229,6 +229,15 @@ struct stmmac_dma_ops {
 			   bool en, u32 chan);
 	int (*enable_tbs)(struct stmmac_priv *priv, void __iomem *ioaddr,
 			  bool en, u32 chan);
+	/* Ordered datapath teardown */
+	int (*tx_dma_stopped)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			      u32 chan);
+	int (*tx_mtl_drain)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    u32 queue);
+	int (*rx_mtl_drain)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			    u32 queue);
+	int (*rx_dma_stopped)(struct stmmac_priv *priv, void __iomem *ioaddr,
+			      u32 chan);
 };
 
 #define stmmac_dma_init(__priv, __args...) \
@@ -289,6 +298,14 @@ struct stmmac_dma_ops {
 	stmmac_do_void_callback(__priv, dma, enable_sph, __priv, __args)
 #define stmmac_enable_tbs(__priv, __args...) \
 	stmmac_do_callback(__priv, dma, enable_tbs, __priv, __args)
+#define stmmac_tx_dma_stopped(__priv, __args...) \
+	stmmac_do_callback(__priv, dma, tx_dma_stopped, __priv, __args)
+#define stmmac_tx_mtl_drain(__priv, __args...) \
+	stmmac_do_callback(__priv, dma, tx_mtl_drain, __priv, __args)
+#define stmmac_rx_mtl_drain(__priv, __args...) \
+	stmmac_do_callback(__priv, dma, rx_mtl_drain, __priv, __args)
+#define stmmac_rx_dma_stopped(__priv, __args...) \
+	stmmac_do_callback(__priv, dma, rx_dma_stopped, __priv, __args)
 
 struct mac_device_info;
 struct net_device;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1213cb216..cc3a0ae0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2569,6 +2569,52 @@ static void stmmac_stop_all_dma(struct stmmac_priv *priv)
 		stmmac_stop_tx_dma(priv, chan);
 }
 
+/**
+ * stmmac_datapath_teardown - ordered datapath teardown as per IP specification
+ * @priv: driver private structure
+ * Description:
+ * When teardown ops are available, follow the databook ordered teardown
+ * sequence.
+ * Follows the legacy stop + MAC disable for variants without the feature.
+ */
+static void stmmac_datapath_teardown(struct stmmac_priv *priv)
+{
+	u32 rx_channels_count = priv->plat->rx_queues_to_use;
+	u32 tx_channels_count = priv->plat->tx_queues_to_use;
+	u32 chan;
+
+	/* Stop all TX DMA channels */
+	for (chan = 0; chan < tx_channels_count; chan++)
+		stmmac_stop_tx_dma(priv, chan);
+
+	/* Wait for every TX DMA channel to report itself stopped */
+	if (priv->hw->dma->tx_dma_stopped)
+		for (chan = 0; chan < tx_channels_count; chan++)
+			stmmac_tx_dma_stopped(priv, priv->ioaddr, chan);
+
+	/* Wait for the MTL TX queues to finish pushing into the MAC */
+	if (priv->hw->dma->tx_mtl_drain)
+		for (chan = 0; chan < tx_channels_count; chan++)
+			stmmac_tx_mtl_drain(priv, priv->ioaddr, chan);
+
+	/* Disable the MAC TX and RX */
+	stmmac_mac_set(priv, priv->ioaddr, false);
+
+	/* Wait for the MTL RX queues to drain into the RX DMA */
+	if (priv->hw->dma->rx_mtl_drain)
+		for (chan = 0; chan < rx_channels_count; chan++)
+			stmmac_rx_mtl_drain(priv, priv->ioaddr, chan);
+
+	/* Stop all RX DMA channels */
+	for (chan = 0; chan < rx_channels_count; chan++)
+		stmmac_stop_rx_dma(priv, chan);
+
+	/* Wait for every RX DMA channel to report itself stopped */
+	if (priv->hw->dma->rx_dma_stopped)
+		for (chan = 0; chan < rx_channels_count; chan++)
+			stmmac_rx_dma_stopped(priv, priv->ioaddr, chan);
+}
+
 /**
  *  stmmac_dma_operation_mode - HW DMA operation mode
  *  @priv: driver private structure
@@ -4238,9 +4284,6 @@ static void __stmmac_release(struct net_device *dev)
 	struct stmmac_priv *priv = netdev_priv(dev);
 	u8 chan;
 
-	/* Stop and disconnect the PHY */
-	phylink_stop(priv->phylink);
-
 	stmmac_disable_all_queues(priv);
 
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
@@ -4251,8 +4294,11 @@ static void __stmmac_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	/* Stop TX/RX DMA and clear the descriptors */
-	stmmac_stop_all_dma(priv);
+	/* Has to run before mac_link_down() disables the MAC. */
+	stmmac_datapath_teardown(priv);
+
+	/* Stop and disconnect the PHY */
+	phylink_stop(priv->phylink);
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
@@ -7109,15 +7155,12 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Free the IRQ lines */
 	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
 
-	/* Stop TX/RX DMA channels */
-	stmmac_stop_all_dma(priv);
+	/* Stop the MAC and the TX/RX DMA channels */
+	stmmac_datapath_teardown(priv);
 
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* set trans_start so we don't get spurious
 	 * watchdogs during reset
 	 */
@@ -8195,17 +8238,15 @@ int stmmac_suspend(struct device *dev)
 		timer_delete_sync(&priv->eee_ctrl_timer);
 	}
 
-	/* Stop TX/RX DMA */
-	stmmac_stop_all_dma(priv);
-
-	stmmac_legacy_serdes_power_down(priv);
-
 	/* Enable Power down mode by programming the PMT regs */
 	if (priv->wolopts) {
+		stmmac_stop_all_dma(priv);
+		stmmac_legacy_serdes_power_down(priv);
 		stmmac_pmt(priv, priv->hw, priv->wolopts);
 		priv->irq_wake = 1;
 	} else {
-		stmmac_mac_set(priv, priv->ioaddr, false);
+		stmmac_datapath_teardown(priv);
+		stmmac_legacy_serdes_power_down(priv);
 		pinctrl_pm_select_sleep_state(priv->device);
 	}
 

-- 
2.43.0

