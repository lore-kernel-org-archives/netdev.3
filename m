Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700332;
	b=Lmk9lPHBXGiF2yU4NAeSUh+yTbYzaKa0C7pIq3Yi2Npii/i5ljEoF/WKHYPy3dvqYaoy
	 YZYK3dWT1zv1Y7xmIRjvoBdbSa2+lAK3PwTCjNppWK0vDJYTL9Ttemw7GIny5FdVx/ZYH
	 nPIBPGog7RW3mV7oeeCC/m2Ke+5w/kihcxxUjRdEr2zYSzO2HzllIw0N2mhkeeVi+2MZC
	 bgBGvW4N9x7ZvQSMK2mN8KD/WvYBUpK1sQAAn7ycCl0LHtkg1HKCIKHcYLV+0h5Qp0Qg8
	 IGtTQ96kIbbkANke5/1qqbExZHEvMf9gbbWLx1ndMiHJmTuhtWejvFv+NDuhxMnoIbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700332;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=t1AzGJxh4L3mNVDifirHPxxV2YDxOwUtgjqwYYf78oI=;
	b=KDSlpSQzrY40TzGekYvcO8vdqoDdVeQB9skZYu+4tMAsM7+bPWIT9gGR3+tiR4Xgdlai
	 4Nj8coxSZWNMgQCEcfLQwJB4OeuL4KNz5qje8J6ItQHwMalFLHEZrgpTOhnz/ABx25mqL
	 SeocAjaprGUPFxyGr/yrST2c5O58u8TFk6dOPneOjTxV58q9tjVPDiLb8eMn3ZEmPOBP6
	 ortBoMJbBUO9wpRdH3Gdgz452WAP1TUuHzFfO6poRpuXiR7oWfeodjB5Q3Z5rOAD+oTO+
	 KctDX6hl5hSPepQ++aQisNDJfEewUm6C2a4dzvfNaoP7Iytu0qMJx2gk2TCbypxMCLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=idYpYZdH;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AC606FAEF;
	Tue,  3 Nov 2026 10:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 616AC606FAEF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=idYpYZdH
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DEA9FA164F;
	Tue, 03 Nov 2026 11:05:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=t1AzGJxh4L3mNVDifirHPxxV2YDxOwUtgjqwYYf78oI=;
	b=idYpYZdHm8i4frYOaS1V69d9u6dZgDoEU8Z7vF3hYuALZgpirFNTotcKF6HS0RRFsi6N0f
	iN/RbLbqZwAupFSW0YaODKPqj45drH6ahhOn2rH5XaOorJs5lb4qzal4K3hJz+wosPip7N
	kP1Z5OsOF3BXBv2vpQiZk9h4mSD9C/LLwBA/OCp0gU/L6KRWzd/ZuO1wvxgNQ4MXZIxKlP
	wMQ8GZDVVYRFPHiiO20z5BHHnBfNG2G3T+r2ATbS+0cGr6LUpqzUlUSmMeZHDiM9uhp6WY
	2nIlOv9C+bvoBEEwFgAveq126pdla+zt7+uxLUpvxe4QFMLXeK0ppcpatuW9dA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:05:00 +0100
Subject: [PATCH net-next v6 6/9] net: bcmgenet: split frames that end just
 past the transmit threshold
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-6-61d5631676e5@tipi-net.de>
References: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
In-Reply-To: <20261103-nb-genet-mtu-nn-v2-v6-0-61d5631676e5@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

A frame that ends a few bytes past the transmit packet ready threshold
stops the transmitter as soon as a shorter frame follows. Tx DMA then
refuses to halt, so every later bcmgenet_init_dma() fails and the
interface cannot be opened again. IP fragmentation generates that pattern
on every datagram, full frames and a short tail.

The window starts one byte past the threshold and never reaches 64 bytes.
On a v5 it ends 28, 32 and 46 bytes past thresholds of 2560, 3584 and
3840, and link speed makes no difference. That is one DMA transfer wide,
which wtschueller measured and proposed to split around.

Splitting such a frame over two descriptors keeps its end out of that
transfer. Both share the one mapping, so the wire bytes do not change.

The threshold kept its reset value until now. Raising it only once the MTU
asks for more than ETH_DATA_LEN leaves the common MTUs as they were.

The MAC inserts a checksum only into a frame it holds in full, so a longer
one has to fall back to software.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 157 +++++++++++++++++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |   2 +
 2 files changed, 125 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 645112f95f8ce..f5d7379e90400 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -59,6 +59,11 @@
 #define ENET_THLD_DEFAULT	0x80
 #define ENET_THLD_MAX		0xf0
 
+/* A frame ending this far past the transmit threshold stops the transmitter
+ * once a shorter frame follows. Widest window measured is 46 bytes.
+ */
+#define ENET_TX_THLD_WINDOW	64
+
 /* Page pool RX buffer layout:
  * RSB(64) + pad(2) | frame data | skb_shared_info
  * The HW writes the 64B RSB before every descriptor of a frame. Only the
@@ -1910,15 +1915,19 @@ static struct sk_buff *bcmgenet_free_tx_cb(struct device *dev,
 
 	if (skb) {
 		cb->skb = NULL;
-		if (cb == GENET_CB(skb)->first_cb)
-			dma_unmap_single(dev, dma_unmap_addr(cb, dma_addr),
-					 dma_unmap_len(cb, dma_len),
-					 DMA_TO_DEVICE);
-		else
-			dma_unmap_page(dev, dma_unmap_addr(cb, dma_addr),
-				       dma_unmap_len(cb, dma_len),
-				       DMA_TO_DEVICE);
-		dma_unmap_addr_set(cb, dma_addr, 0);
+		/* A cut descriptor left its mapping to the one after it */
+		if (cb != GENET_CB(skb)->split_cb) {
+			if (cb == GENET_CB(skb)->first_cb)
+				dma_unmap_single(dev,
+						 dma_unmap_addr(cb, dma_addr),
+						 dma_unmap_len(cb, dma_len),
+						 DMA_TO_DEVICE);
+			else
+				dma_unmap_page(dev, dma_unmap_addr(cb, dma_addr),
+					       dma_unmap_len(cb, dma_len),
+					       DMA_TO_DEVICE);
+			dma_unmap_addr_set(cb, dma_addr, 0);
+		}
 
 		if (cb == GENET_CB(skb)->last_cb)
 			return skb;
@@ -2154,7 +2163,10 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct device *kdev = &priv->pdev->dev;
+	unsigned int split_i = 0, split_at = 0;
 	struct bcmgenet_tx_ring *ring = NULL;
+	dma_addr_t split_mapping = 0;
+	unsigned int split_size = 0;
 	struct enet_cb *tx_cb_ptr;
 	struct netdev_queue *txq;
 	int nr_frags, index;
@@ -2162,6 +2174,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	unsigned int size;
 	skb_frag_t *frag;
 	u32 len_stat;
+	bool split;
 	int ret;
 	int i;
 
@@ -2171,8 +2184,14 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nr_frags = skb_shinfo(skb)->nr_frags;
 
+	/* Cut a frame ending in that window in two at the threshold, its end
+	 * then lands in a separate transfer.
+	 */
+	split = unlikely(skb->len > priv->tx_thld_len &&
+			 skb->len < priv->tx_thld_len + ENET_TX_THLD_WINDOW);
+
 	spin_lock(&ring->lock);
-	if (ring->free_bds <= (nr_frags + 1)) {
+	if (ring->free_bds <= (nr_frags + 1 + split)) {
 		if (!netif_tx_queue_stopped(txq))
 			netif_tx_stop_queue(txq);
 		ret = NETDEV_TX_BUSY;
@@ -2189,6 +2208,19 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
+	/* The MAC inserts a checksum only into a frame it holds in full and
+	 * silently drops a longer one, so fall back to software.
+	 */
+	if (unlikely(skb->len > priv->tx_thld_len) &&
+	    skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (skb_checksum_help(skb)) {
+			BCMGENET_STATS64_INC((&ring->stats64), dropped);
+			dev_kfree_skb_any(skb);
+			goto drop;
+		}
+		nr_frags = skb_shinfo(skb)->nr_frags;
+	}
+
 	/* Retain how many bytes will be sent on the wire, without TSB inserted
 	 * by transmit checksum offload
 	 */
@@ -2199,33 +2231,73 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (!skb)
 		goto drop;
 
-	for (i = 0; i <= nr_frags; i++) {
+	/* A threshold that already ends a buffer needs no cut */
+	if (split) {
+		unsigned int buf = skb_headlen(skb);
+		unsigned int covered = buf - sizeof(struct status_64);
+
+		while (covered < priv->tx_thld_len) {
+			frag = &skb_shinfo(skb)->frags[split_i++];
+			buf = skb_frag_size(frag);
+			covered += buf;
+		}
+
+		split_at = buf - (covered - priv->tx_thld_len);
+		split = split_at && split_at < buf;
+	}
+
+	for (i = 0; i <= nr_frags + split; i++) {
+		unsigned int f = i - (split && i > split_i);
+		bool cont = split && i == split_i + 1;
+
 		tx_cb_ptr = bcmgenet_get_txcb(priv, ring);
 
 		BUG_ON(!tx_cb_ptr);
 
-		if (!i) {
-			/* Transmit single SKB or head of fragment list */
-			GENET_CB(skb)->first_cb = tx_cb_ptr;
-			size = skb_headlen(skb);
-			mapping = dma_map_single(kdev, skb->data, size,
-						 DMA_TO_DEVICE);
+		if (cont) {
+			/* Rest of the buffer cut above. It unmaps for both,
+			 * the hardware is done with it only now.
+			 */
+			mapping = split_mapping + split_at;
+			size = split_size - split_at;
+			dma_unmap_addr_set(tx_cb_ptr, dma_addr, split_mapping);
+			dma_unmap_len_set(tx_cb_ptr, dma_len, split_size);
 		} else {
-			/* xmit fragment */
-			frag = &skb_shinfo(skb)->frags[i - 1];
-			size = skb_frag_size(frag);
-			mapping = skb_frag_dma_map(kdev, frag, 0, size,
-						   DMA_TO_DEVICE);
-		}
+			if (!f) {
+				/* Transmit single SKB or head of frag list */
+				GENET_CB(skb)->first_cb = tx_cb_ptr;
+				GENET_CB(skb)->split_cb = NULL;
+				size = skb_headlen(skb);
+				mapping = dma_map_single(kdev, skb->data,
+							 size, DMA_TO_DEVICE);
+			} else {
+				/* xmit fragment */
+				frag = &skb_shinfo(skb)->frags[f - 1];
+				size = skb_frag_size(frag);
+				mapping = skb_frag_dma_map(kdev, frag, 0, size,
+							   DMA_TO_DEVICE);
+			}
 
-		ret = dma_mapping_error(kdev, mapping);
-		if (ret) {
-			priv->mib.tx_dma_failed++;
-			netif_err(priv, tx_err, dev, "Tx DMA map failed\n");
-			goto out_unmap_frags;
+			ret = dma_mapping_error(kdev, mapping);
+			if (ret) {
+				priv->mib.tx_dma_failed++;
+				netif_err(priv, tx_err, dev,
+					  "Tx DMA map failed\n");
+				goto out_unmap_frags;
+			}
+			dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
+			dma_unmap_len_set(tx_cb_ptr, dma_len, size);
+
+			/* The cut hands buffer and mapping to the next one */
+			if (split && i == split_i) {
+				GENET_CB(skb)->split_cb = tx_cb_ptr;
+				split_mapping = mapping;
+				split_size = size;
+				size = split_at;
+				dma_unmap_addr_set(tx_cb_ptr, dma_addr, 0);
+				dma_unmap_len_set(tx_cb_ptr, dma_len, 0);
+			}
 		}
-		dma_unmap_addr_set(tx_cb_ptr, dma_addr, mapping);
-		dma_unmap_len_set(tx_cb_ptr, dma_len, size);
 
 		tx_cb_ptr->skb = skb;
 
@@ -2242,7 +2314,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
 				len_stat |= DMA_TX_DO_CSUM;
 		}
-		if (i == nr_frags)
+		if (i == nr_frags + split)
 			len_stat |= DMA_EOP;
 
 		dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
@@ -2254,13 +2326,14 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_tx_timestamp(skb);
 
 	/* Decrement total BD count and advance our write pointer */
-	ring->free_bds -= nr_frags + 1;
-	ring->prod_index += nr_frags + 1;
+	ring->free_bds -= nr_frags + 1 + split;
+	ring->prod_index += nr_frags + 1 + split;
 	ring->prod_index &= DMA_P_INDEX_MASK;
 
 	netdev_tx_sent_queue(txq, GENET_CB(skb)->bytes_sent);
 
-	if (ring->free_bds <= (MAX_SKB_FRAGS + 1))
+	/* The next frame may need a split descriptor on top of its fragments */
+	if (ring->free_bds <= (MAX_SKB_FRAGS + 2))
 		netif_tx_stop_queue(txq);
 
 	bcmgenet_tx_kick(priv, ring, txq);
@@ -2675,6 +2748,17 @@ static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
 		       ENET_THLD_MAX_LEN / ENET_THLD_UNIT);
 }
 
+/* The transmit threshold in register units. Keep the reset value while the
+ * MTU has no use for more, the hardware never reaches it below ETH_DATA_LEN.
+ */
+static unsigned int bcmgenet_tx_pkt_rdy_thld(unsigned int mtu)
+{
+	if (mtu <= ETH_DATA_LEN)
+		return ENET_THLD_DEFAULT;
+
+	return ENET_THLD_MAX;
+}
+
 /* A buffer has to hold everything the threshold lets the hardware deliver */
 static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
 {
@@ -2685,8 +2769,10 @@ static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
 /* Program the MTU dependent registers. Call with the MAC disabled. */
 static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 {
+	u32 tx_thld = bcmgenet_tx_pkt_rdy_thld(mtu);
 	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
 
+	priv->tx_thld_len = tx_thld * ENET_THLD_UNIT;
 	bcmgenet_umac_writel(priv, ENET_MAC_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);
 
 	/* GENET v1 maps other registers at these offsets */
@@ -2694,6 +2780,8 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 		return;
 
 	bcmgenet_rbuf_writel(priv, thld, RBUF_PKT_RDY_THLD);
+	bcmgenet_writel(tx_thld, priv->base + priv->hw_params->tbuf_offset +
+			TBUF_PKT_RDY_THLD);
 }
 
 static void init_umac(struct bcmgenet_priv *priv)
@@ -4193,6 +4281,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	init_waitqueue_head(&priv->wq);
 	bcmgenet_hfb_init(priv);
 	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
+	priv->tx_thld_len = bcmgenet_tx_pkt_rdy_thld(dev->mtu) * ENET_THLD_UNIT;
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index dc49518c577ec..5f462b9774fad 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -544,6 +544,7 @@ struct bcmgenet_hw_params {
 struct bcmgenet_skb_cb {
 	struct enet_cb *first_cb;	/* First control block of SKB */
 	struct enet_cb *last_cb;	/* Last control block of SKB */
+	struct enet_cb *split_cb;	/* Cut, the next one unmaps for both */
 	unsigned int bytes_sent;	/* bytes on the wire (no TSB) */
 };
 
@@ -617,6 +618,7 @@ struct bcmgenet_priv {
 	void __iomem *tx_bds;
 	struct enet_cb *tx_cbs;
 	unsigned int num_tx_bds;
+	unsigned int tx_thld_len;
 
 	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
 

-- 
2.53.0

