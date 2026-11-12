Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480331;
	b=19WxeyL1LMbp3O0e7LlPBA4ETwDpayBoOf250Iq00hLqJwr3RFdM3UsbBTy9Qlp8kuXI
	 sP/EXfxSQI5mq3ngduzbmlWaJqSvUOrr5D6t3aZ1cKas/IEd9JyV6BrRR8CSxZfCnL7Jl
	 +6hR6+mQ7TdB/7GHzx48miGuJvrQoHboYFXVUso4osPNJgg/DNL8DGKVwjoRZyZezZ4oz
	 RPCbGBbwYB+6AzPVy38mtCI+gGT2G75pbF9dxZToSkgkRnaB56y8ANcIsVcOXBvj6vYc7
	 PN295O9QMFurLC3pgBGRFANrE6qZF8uQB1mID2GO9QuIJdg2iaT8T8e03/sxmz/q7ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480331;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=AES0Fsh5VEka/ritEoJxuRK83Cn9r94xxTcj61XSDJ0=;
	b=oFd08MYqab/Cf7CL3AN10ASdh2FF1Za1N6rQa0Z3ZBC0EFn+J3IpgPpD4NVD54fpVDEy
	 0+ULC2ZhCsWp9W3kL6SlDVj904PbkdzxGeid4wYR2ct80fZO1MDDyVEi6SowkJ5OpC+Qy
	 FTa3WK9sx4O6VMAjaBBn5RefRkeboqx6pVaxhlu2l4REpKbs33GsOT6HNizs+xwW9Z9a5
	 mcTO0CmNLrW+EDn2ESGB2iyuOXedTEJtFu++Q6oEzH9x5QVOxCoXmattH/U3P7MbDslmg
	 H3PV8XbJfU1DLbxz2iSiRMNWycySva/3FoMD8clacVd5MjwdH05idcIs0H22pD4M0fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=zlOEoMYj;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2E60A260A;
	Thu, 12 Nov 2026 10:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DA2E60A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=zlOEoMYj
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67D6DA50CB;
	Thu, 12 Nov 2026 11:45:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1794480328; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=AES0Fsh5VEka/ritEoJxuRK83Cn9r94xxTcj61XSDJ0=;
	b=zlOEoMYjQY+1hi1MfOyT7jdu/axs60u/GiKVARuH3ZCuAQVsE8gykAlb8brDBgOExRF9+b
	fsckZR3qMc0nUKN151RYHbKCWQBP7YOg3IEWQTa4KgY/h48FwIaI+3dVDZK1c6Kk3aeJfc
	CkcToLaNpFx5tY9LTpVlOd9iY8EVFEwPFuH0phCu5PMOBlpiaT2bwO8ZMWvEu4qhgerHNQ
	psw6V5NN7KTGtBgJvet0ORNtop2wO+0BUJmqKtiZkNmyL4KuPLTtxi7mF/3AlLygyxpXCN
	W3mSC0c0h+buF3zeAdzWXz+22PE42lXsnDe303Lj9gtYkV4OT4B3VjACq9tTmQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Thu, 12 Nov 2026 11:45:20 +0100
Subject: [PATCH net-next v7 6/9] net: bcmgenet: split frames that end just
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
Message-Id: <20261112-nb-genet-mtu-nn-v2-v7-6-43a5d90b3256@tipi-net.de>
References: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
In-Reply-To: <20261112-nb-genet-mtu-nn-v2-v7-0-43a5d90b3256@tipi-net.de>
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
transfer. Both share the one mapping, so the wire bytes do not change. The
split costs one descriptor, so the queue stops and wakes one earlier, and
a frame is flattened one fragment sooner.

The threshold kept its reset value until now. Raising it only once the MTU
asks for more than ETH_DATA_LEN leaves the common MTUs as they were.

The MAC inserts a checksum only into a frame it holds in full, so a longer
one has to fall back to software.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 162 +++++++++++++++++++------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |   2 +
 2 files changed, 128 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 1bb5fed4a8b4d..d70079832dd24 100644
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
 	/* The check below would always refuse this frame */
-	if (unlikely(nr_frags + 1 >= ring->size)) {
+	if (unlikely(nr_frags + 1 + split >= ring->size)) {
 		skb = skb_share_check(skb, GFP_ATOMIC);
 		if (skb && skb_linearize(skb)) {
 			dev_kfree_skb_any(skb);
@@ -2187,7 +2206,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	}
 
 	spin_lock(&ring->lock);
-	if (ring->free_bds <= (nr_frags + 1)) {
+	if (ring->free_bds <= (nr_frags + 1 + split)) {
 		if (!netif_tx_queue_stopped(txq))
 			netif_tx_stop_queue(txq);
 		ret = NETDEV_TX_BUSY;
@@ -2203,6 +2222,19 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
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
@@ -2213,33 +2245,73 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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
 
@@ -2256,7 +2328,7 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 			if (skb->ip_summed == CHECKSUM_PARTIAL)
 				len_stat |= DMA_TX_DO_CSUM;
 		}
-		if (i == nr_frags)
+		if (i == nr_frags + split)
 			len_stat |= DMA_EOP;
 
 		dmadesc_set(priv, tx_cb_ptr->bd_addr, mapping, len_stat);
@@ -2268,8 +2340,8 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	skb_tx_timestamp(skb);
 
 	/* Decrement total BD count and advance our write pointer */
-	ring->free_bds -= nr_frags + 1;
-	ring->prod_index += nr_frags + 1;
+	ring->free_bds -= nr_frags + 1 + split;
+	ring->prod_index += nr_frags + 1 + split;
 	ring->prod_index &= DMA_P_INDEX_MASK;
 
 	netdev_tx_sent_queue(txq, GENET_CB(skb)->bytes_sent);
@@ -2689,6 +2761,17 @@ static unsigned int bcmgenet_pkt_rdy_thld(unsigned int mtu)
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
@@ -2699,8 +2782,10 @@ static unsigned int bcmgenet_rx_buf_len(unsigned int mtu)
 /* Program the MTU dependent registers. Call with the MAC disabled. */
 static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 {
+	u32 tx_thld = bcmgenet_tx_pkt_rdy_thld(mtu);
 	u32 thld = bcmgenet_pkt_rdy_thld(mtu);
 
+	priv->tx_thld_len = tx_thld * ENET_THLD_UNIT;
 	bcmgenet_umac_writel(priv, ENET_MAC_FRAME_LEN(mtu), UMAC_MAX_FRAME_LEN);
 
 	/* GENET v1 maps other registers at these offsets */
@@ -2708,6 +2793,8 @@ static void bcmgenet_set_mtu_regs(struct bcmgenet_priv *priv, unsigned int mtu)
 		return;
 
 	bcmgenet_rbuf_writel(priv, thld, RBUF_PKT_RDY_THLD);
+	bcmgenet_writel(tx_thld, priv->base + priv->hw_params->tbuf_offset +
+			TBUF_PKT_RDY_THLD);
 }
 
 static void init_umac(struct bcmgenet_priv *priv)
@@ -2822,8 +2909,10 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	ring->index = index;
 	ring->cbs = priv->tx_cbs + start_ptr;
 	ring->size = size;
-	/* An empty ring must be able to wake the queue */
-	ring->stop_thld = min_t(unsigned int, MAX_SKB_FRAGS + 1, size - 1);
+	/* An empty ring must be able to wake the queue, a split frame takes
+	 * one descriptor more.
+	 */
+	ring->stop_thld = min_t(unsigned int, MAX_SKB_FRAGS + 2, size - 1);
 	ring->clean_ptr = start_ptr;
 	ring->c_index = 0;
 	ring->free_bds = size;
@@ -4209,6 +4298,7 @@ static int bcmgenet_probe(struct platform_device *pdev)
 	init_waitqueue_head(&priv->wq);
 	bcmgenet_hfb_init(priv);
 	priv->rx_buf_len = bcmgenet_rx_buf_len(dev->mtu);
+	priv->tx_thld_len = bcmgenet_tx_pkt_rdy_thld(dev->mtu) * ENET_THLD_UNIT;
 	INIT_WORK(&priv->bcmgenet_irq_work, bcmgenet_irq_task);
 
 	priv->clk_wol = devm_clk_get_optional(&priv->pdev->dev, "enet-wol");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index b40e56872132c..12a3dfa807393 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -544,6 +544,7 @@ struct bcmgenet_hw_params {
 struct bcmgenet_skb_cb {
 	struct enet_cb *first_cb;	/* First control block of SKB */
 	struct enet_cb *last_cb;	/* Last control block of SKB */
+	struct enet_cb *split_cb;	/* Cut, the next one unmaps for both */
 	unsigned int bytes_sent;	/* bytes on the wire (no TSB) */
 };
 
@@ -618,6 +619,7 @@ struct bcmgenet_priv {
 	void __iomem *tx_bds;
 	struct enet_cb *tx_cbs;
 	unsigned int num_tx_bds;
+	unsigned int tx_thld_len;
 
 	struct bcmgenet_tx_ring tx_rings[GENET_MAX_MQ_CNT + 1];
 

-- 
2.53.0

