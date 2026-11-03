Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700332;
	b=VYlxThcBdvn0xiQCzIsXgtTRBHKbG95IzWtrAoSXzZMGXb4FL3CL9m1d2jHGycvyjlD1
	 d3FsYRDAI1eF+0fPvdXCwICFuWmBCYTwuM5ay+6+h7VS+zxObbCJaa9yyOmstVJtJLAjT
	 d2cv5A04oVjabePaSXM5UFMRkakKrP6X4cMVaw79hAWT92MxAjnHx3jUaCO55VlxdKBfa
	 3KtSdFKS8aFrYhDVqzz8chVLXLQs+E8+pzm4EcJzr/STzGLKdAwCDp7ls87F0L+K53j3M
	 o0f3Vdc5DZ0ppfataVMhldNBzIDeRC+qL3DXdHhWfRzKEeYkAVpdE2ceSjzi0+fnrpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700332;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=WgE86j3AAWX7uJEoJLB+d4TCOnQyIyF6OQzp80EJzdU=;
	b=qkbujH6HAqK0Hg21DOJ/dSuMRJG2b/8xW4Qk1EwQQ0VU5jzLpwoBrL7bba4n+Y+4yAxl
	 iSrgMcIUQXYYOjxQAmYq3AgH31vHGMrewkQTAzfRSJUKXbDwL+uiiUuzAZa9rpiyJ26lZ
	 CzZbSHYuGZzF81m+qluR/5sjkoM5F9Xzsp52/l9e+imrzOnJVtVIYNZRYvsW2cbZqjhSZ
	 jiGfjO0YFuQxMj00mGNh5Y0xqN5TpoyAjhI8QemRPGivmsIcCkP6nIMINwsaUNUUd9qqJ
	 6vIon0segftUiTxZED/qNtW44t20WCvz1tTbAvYYdhP+VIQc9zlXB3YIylh7Qw/Trbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=nXnD+3Np;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC3606FAF0;
	Tue,  3 Nov 2026 10:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62AC3606FAF0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=nXnD+3Np
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 74AC1A1650;
	Tue, 03 Nov 2026 11:05:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1793700329; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WgE86j3AAWX7uJEoJLB+d4TCOnQyIyF6OQzp80EJzdU=;
	b=nXnD+3NpRW0+G2L8JIOul6Vggs1KhiCyt6lg23C60vhqDGeDudtKCmrkecOtiyrQ/kjvVD
	JL5Zg5UIbUJnavSgmCnrbdvBH5a4IIEnjs+gq/tv52VQ/9/ig2CgtKWvHiib0yFXfOKnS6
	2PRyYiyx+pErpEryOMo5Zv/rmrZFcVqMid6HO5HOqZF964xE0Y6PM8tbH/ZX63sy8XLsFS
	HvnKwlBYUT7YulkL2ACICv6RxGPGxFtxge2OlwQq1yEDE8oeGg+wNqJyQr+ITnksDfHXGC
	1hSDWEPotgpHmgd8B9b3/VfIvWNijwr4qTde89i4zy2X4HcgyYHZsLi0Ig3liA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Tue, 03 Nov 2026 11:05:01 +0100
Subject: [PATCH net-next v6 7/9] net: bcmgenet: build the DMA rings before
 giving up the running ones
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
Message-Id: <20261103-nb-genet-mtu-nn-v2-v6-7-61d5631676e5@tipi-net.de>
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

bcmgenet_init_dma() frees the rings it is about to replace before it
allocates anything, so a failure under memory pressure leaves the
interface with no datapath at all. The MTU change in the next patch runs
the same path on a live interface, where that takes a working link down.

Allocate into a set of its own first and install it only once it is
complete, so a failed allocation costs the running datapath nothing.

The receive buffers can only reach the hardware at install time, the
descriptors of a running ring must not be rewritten.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 248 +++++++++++++++----------
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |   9 +
 2 files changed, 159 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index f5d7379e90400..f6ed15bb1a91c 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2360,16 +2360,15 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 	goto out;
 }
 
-static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
-			      struct enet_cb *cb)
+static int bcmgenet_rx_alloc_cb(struct bcmgenet_priv *priv,
+				struct page_pool *pool, unsigned int buf_len,
+				struct enet_cb *cb)
 {
-	struct bcmgenet_priv *priv = ring->priv;
-	unsigned int size = SKB_HEAD_ALIGN(priv->rx_buf_len);
+	unsigned int size = SKB_HEAD_ALIGN(buf_len);
 	unsigned int offset;
-	dma_addr_t mapping;
 	struct page *page;
 
-	page = page_pool_dev_alloc(ring->page_pool, &offset, &size);
+	page = page_pool_dev_alloc(pool, &offset, &size);
 	if (!page) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, priv->dev,
@@ -2377,15 +2376,37 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 		return -ENOMEM;
 	}
 
+	cb->rx_page = page;
+	cb->rx_offset = offset;
+	cb->rx_size = size;
+
+	return 0;
+}
+
+/* Hand the buffer of a control block to the hardware */
+static void bcmgenet_rx_arm_cb(struct bcmgenet_priv *priv, struct enet_cb *cb)
+{
+	dma_addr_t mapping;
+
 	/* page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
-	mapping = page_pool_get_dma_addr(page) + offset;
+	mapping = page_pool_get_dma_addr(cb->rx_page) + cb->rx_offset;
 	dma_sync_single_for_device(&priv->pdev->dev, mapping, priv->rx_buf_len,
 				   DMA_FROM_DEVICE);
 
-	cb->rx_page = page;
-	cb->rx_offset = offset;
-	cb->rx_size = size;
 	dmadesc_set_addr(priv, cb->bd_addr, mapping);
+}
+
+static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
+			      struct enet_cb *cb)
+{
+	struct bcmgenet_priv *priv = ring->priv;
+	int ret;
+
+	ret = bcmgenet_rx_alloc_cb(priv, ring->page_pool, priv->rx_buf_len, cb);
+	if (ret)
+		return ret;
+
+	bcmgenet_rx_arm_cb(priv, cb);
 
 	return 0;
 }
@@ -2633,22 +2654,15 @@ static void bcmgenet_dim_work(struct work_struct *work)
 }
 
 /* Assign page_pool pages to RX DMA descriptors. */
-static int bcmgenet_alloc_rx_buffers(struct bcmgenet_priv *priv,
-				     struct bcmgenet_rx_ring *ring)
+static void bcmgenet_arm_rx_buffers(struct bcmgenet_priv *priv,
+				    struct bcmgenet_rx_ring *ring)
 {
-	struct enet_cb *cb;
 	int i;
 
 	netif_dbg(priv, hw, priv->dev, "%s\n", __func__);
 
-	/* loop here for each buffer needing assign */
-	for (i = 0; i < ring->size; i++) {
-		cb = ring->cbs + i;
-		if (bcmgenet_rx_refill(ring, cb))
-			return -ENOMEM;
-	}
-
-	return 0;
+	for (i = 0; i < ring->size; i++)
+		bcmgenet_rx_arm_cb(priv, ring->cbs + i);
 }
 
 static void bcmgenet_free_rx_buffers(struct bcmgenet_priv *priv)
@@ -2933,41 +2947,33 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 	netif_napi_add_tx(priv->dev, &ring->napi, bcmgenet_tx_poll);
 }
 
-static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
-					struct bcmgenet_rx_ring *ring)
+static struct page_pool *bcmgenet_create_rx_pool(struct bcmgenet_priv *priv,
+						 unsigned int size)
 {
 	/* Buffers may share a page, depending on PAGE_SIZE and the MTU.
-	 * bcmgenet_rx_refill() syncs each one for the device,
+	 * bcmgenet_rx_arm_cb() syncs each one for the device,
 	 * PP_FLAG_DMA_SYNC_DEV would sync the whole page.
 	 */
 	struct page_pool_params pp_params = {
 		.order = 0,
 		.flags = PP_FLAG_DMA_MAP,
-		.pool_size = ring->size,
+		.pool_size = size,
 		.nid = NUMA_NO_NODE,
 		.dev = &priv->pdev->dev,
 		.dma_dir = DMA_FROM_DEVICE,
 	};
-	int err;
-
-	ring->page_pool = page_pool_create(&pp_params);
-	if (IS_ERR(ring->page_pool)) {
-		err = PTR_ERR(ring->page_pool);
-		ring->page_pool = NULL;
-		return err;
-	}
 
-	return 0;
+	return page_pool_create(&pp_params);
 }
 
 /* Initialize a RDMA ring */
-static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
-				 unsigned int index, unsigned int size,
-				 unsigned int start_ptr, unsigned int end_ptr)
+static void bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
+				  unsigned int index, unsigned int size,
+				  unsigned int start_ptr, unsigned int end_ptr,
+				  struct page_pool *pool)
 {
 	struct bcmgenet_rx_ring *ring = &priv->rx_rings[index];
 	u32 words_per_bd = WORDS_PER_BD(priv);
-	int ret, i;
 
 	ring->priv = priv;
 	ring->index = index;
@@ -2977,19 +2983,9 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 	ring->read_ptr = start_ptr;
 	ring->cb_ptr = start_ptr;
 	ring->end_ptr = end_ptr - 1;
+	ring->page_pool = pool;
 
-	ret = bcmgenet_rx_ring_create_pool(priv, ring);
-	if (ret)
-		return ret;
-
-	ret = bcmgenet_alloc_rx_buffers(priv, ring);
-	if (ret) {
-		for (i = 0; i < ring->size; i++)
-			bcmgenet_free_rx_cb(ring->cbs + i, ring->page_pool);
-		page_pool_destroy(ring->page_pool);
-		ring->page_pool = NULL;
-		return ret;
-	}
+	bcmgenet_arm_rx_buffers(priv, ring);
 
 	bcmgenet_init_dim(ring, bcmgenet_dim_work);
 	bcmgenet_init_rx_coalesce(ring);
@@ -3016,8 +3012,6 @@ static int bcmgenet_init_rx_ring(struct bcmgenet_priv *priv,
 				  RDMA_WRITE_PTR);
 	bcmgenet_rdma_ring_writel(priv, index, end_ptr * words_per_bd - 1,
 				  DMA_END_ADDR);
-
-	return ret;
 }
 
 static void bcmgenet_enable_tx_napi(struct bcmgenet_priv *priv)
@@ -3205,18 +3199,17 @@ static void bcmgenet_destroy_rx_page_pools(struct bcmgenet_priv *priv)
  *
  * Queue 0 is also the default Rx queue with GENET_Q0_RX_BD_CNT descriptors.
  */
-static int bcmgenet_init_rx_queues(struct net_device *dev)
+static void bcmgenet_init_rx_queues(struct net_device *dev,
+				    struct bcmgenet_dma_set *set)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	unsigned int start = 0, end = GENET_Q0_RX_BD_CNT;
 	u32 i, ring_mask;
-	int ret;
 
 	/* Initialize Rx priority queues */
 	for (i = 0; i <= priv->hw_params->rx_queues; i++) {
-		ret = bcmgenet_init_rx_ring(priv, i, end - start, start, end);
-		if (ret)
-			return ret;
+		bcmgenet_init_rx_ring(priv, i, end - start, start, end,
+				      set->page_pool[i]);
 
 		start = end;
 		end += priv->hw_params->rx_bds_per_q;
@@ -3229,8 +3222,6 @@ static int bcmgenet_init_rx_queues(struct net_device *dev)
 	/* Enable Rx rings */
 	ring_mask <<= DMA_RING_BUF_EN_SHIFT;
 	bcmgenet_rdma_writel(priv, ring_mask, DMA_CTRL);
-
-	return 0;
 }
 
 static int bcmgenet_dma_teardown(struct bcmgenet_priv *priv)
@@ -3277,10 +3268,86 @@ static void bcmgenet_fini_dma(struct bcmgenet_priv *priv)
 }
 
 /* init_edma: Initialize DMA control register */
-static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
+/* Hand back a set that was never installed */
+static void bcmgenet_free_dma_set(struct bcmgenet_priv *priv,
+				  struct bcmgenet_dma_set *set)
+{
+	unsigned int start = 0, end = GENET_Q0_RX_BD_CNT;
+	unsigned int i, q;
+
+	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
+		if (set->page_pool[q]) {
+			for (i = start; i < end; i++)
+				bcmgenet_free_rx_cb(set->rx_cbs + i,
+						    set->page_pool[q]);
+			page_pool_destroy(set->page_pool[q]);
+		}
+
+		start = end;
+		end += priv->hw_params->rx_bds_per_q;
+	}
+
+	kfree(set->rx_cbs);
+	kfree(set->tx_cbs);
+	memset(set, 0, sizeof(*set));
+}
+
+/* Build everything a datapath of this buffer length needs. The running one
+ * keeps its own until the caller installs this set, so a failure here costs
+ * nothing.
+ */
+static int bcmgenet_alloc_dma(struct bcmgenet_priv *priv, unsigned int buf_len,
+			      struct bcmgenet_dma_set *set)
+{
+	unsigned int start = 0, end = GENET_Q0_RX_BD_CNT;
+	unsigned int i, q;
+
+	memset(set, 0, sizeof(*set));
+
+	set->rx_cbs = kzalloc_objs(struct enet_cb, TOTAL_DESC);
+	set->tx_cbs = kzalloc_objs(struct enet_cb, TOTAL_DESC);
+	if (!set->rx_cbs || !set->tx_cbs)
+		goto err;
+
+	for (i = 0; i < TOTAL_DESC; i++) {
+		set->rx_cbs[i].bd_addr = priv->base +
+					 priv->hw_params->rdma_offset +
+					 i * DMA_DESC_SIZE;
+		set->tx_cbs[i].bd_addr = priv->base +
+					 priv->hw_params->tdma_offset +
+					 i * DMA_DESC_SIZE;
+	}
+
+	for (q = 0; q <= priv->hw_params->rx_queues; q++) {
+		set->page_pool[q] = bcmgenet_create_rx_pool(priv, end - start);
+		if (IS_ERR(set->page_pool[q])) {
+			set->page_pool[q] = NULL;
+			goto err;
+		}
+
+		for (i = start; i < end; i++)
+			if (bcmgenet_rx_alloc_cb(priv, set->page_pool[q],
+						 buf_len, set->rx_cbs + i))
+				goto err;
+
+		start = end;
+		end += priv->hw_params->rx_bds_per_q;
+	}
+
+	return 0;
+
+err:
+	bcmgenet_free_dma_set(priv, set);
+
+	return -ENOMEM;
+}
+
+/* Install a set built by bcmgenet_alloc_dma() and start the engines. The set
+ * is consumed either way, a failure frees it and leaves no datapath behind.
+ */
+static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx,
+			     struct bcmgenet_dma_set *set)
 {
-	struct enet_cb *cb;
-	unsigned int i;
 	int ret;
 	u32 reg;
 
@@ -3290,14 +3357,14 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	ret = bcmgenet_tdma_disable(priv);
 	if (ret) {
 		netdev_err(priv->dev, "failed to halt Tx DMA\n");
-		return ret;
+		goto err;
 	}
 
 	/* Disable RX DMA */
 	ret = bcmgenet_rdma_disable(priv);
 	if (ret) {
 		netdev_err(priv->dev, "failed to halt Rx DMA\n");
-		return ret;
+		goto err;
 	}
 
 	/* Flush TX queues */
@@ -3313,49 +3380,21 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 		udelay(10);
 	}
 
-	/* Initialize common Rx ring structures */
+	/* The set belongs to the datapath from here on */
 	priv->rx_bds = priv->base + priv->hw_params->rdma_offset;
 	priv->num_rx_bds = TOTAL_DESC;
-	priv->rx_cbs = kzalloc_objs(struct enet_cb, priv->num_rx_bds);
-	if (!priv->rx_cbs)
-		return -ENOMEM;
+	priv->rx_cbs = set->rx_cbs;
 
-	for (i = 0; i < priv->num_rx_bds; i++) {
-		cb = priv->rx_cbs + i;
-		cb->bd_addr = priv->rx_bds + i * DMA_DESC_SIZE;
-	}
-
-	/* Initialize common TX ring structures */
 	priv->tx_bds = priv->base + priv->hw_params->tdma_offset;
 	priv->num_tx_bds = TOTAL_DESC;
-	priv->tx_cbs = kzalloc_objs(struct enet_cb, priv->num_tx_bds);
-	if (!priv->tx_cbs) {
-		kfree(priv->rx_cbs);
-		priv->rx_cbs = NULL;
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < priv->num_tx_bds; i++) {
-		cb = priv->tx_cbs + i;
-		cb->bd_addr = priv->tx_bds + i * DMA_DESC_SIZE;
-	}
+	priv->tx_cbs = set->tx_cbs;
 
 	/* Init rDma */
 	bcmgenet_rdma_writel(priv, priv->dma_max_burst_length,
 			     DMA_SCB_BURST_SIZE);
 
 	/* Initialize Rx queues */
-	ret = bcmgenet_init_rx_queues(priv->dev);
-	if (ret) {
-		netdev_err(priv->dev, "failed to initialize Rx queues\n");
-		bcmgenet_free_rx_buffers(priv);
-		bcmgenet_destroy_rx_page_pools(priv);
-		kfree(priv->rx_cbs);
-		priv->rx_cbs = NULL;
-		kfree(priv->tx_cbs);
-		priv->tx_cbs = NULL;
-		return ret;
-	}
+	bcmgenet_init_rx_queues(priv->dev, set);
 
 	/* Init tDma */
 	bcmgenet_tdma_writel(priv, priv->dma_max_burst_length,
@@ -3374,6 +3413,11 @@ static int bcmgenet_init_dma(struct bcmgenet_priv *priv, bool flush_rx)
 	bcmgenet_tdma_writel(priv, reg, DMA_CTRL);
 
 	return 0;
+
+err:
+	bcmgenet_free_dma_set(priv, set);
+
+	return ret;
 }
 
 /* Interrupt bottom half */
@@ -3546,6 +3590,7 @@ static void bcmgenet_netif_start(struct net_device *dev, bool start_phy)
 static int bcmgenet_open(struct net_device *dev)
 {
 	struct bcmgenet_priv *priv = netdev_priv(dev);
+	struct bcmgenet_dma_set set;
 	int ret;
 
 	netif_dbg(priv, ifup, dev, "bcmgenet_open\n");
@@ -3575,7 +3620,11 @@ static int bcmgenet_open(struct net_device *dev)
 	bcmgenet_hfb_restore(priv);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
-	ret = bcmgenet_init_dma(priv, true);
+	ret = bcmgenet_alloc_dma(priv, priv->rx_buf_len, &set);
+	if (ret)
+		goto err_clk_disable;
+
+	ret = bcmgenet_init_dma(priv, true, &set);
 	if (ret) {
 		netdev_err(dev, "failed to initialize DMA\n");
 		goto err_clk_disable;
@@ -4429,6 +4478,7 @@ static int bcmgenet_resume(struct device *d)
 	struct net_device *dev = dev_get_drvdata(d);
 	struct bcmgenet_priv *priv = netdev_priv(dev);
 	struct bcmgenet_rxnfc_rule *rule;
+	struct bcmgenet_dma_set set;
 	int ret;
 	u32 reg;
 
@@ -4494,7 +4544,9 @@ static int bcmgenet_resume(struct device *d)
 	bcmgenet_hfb_restore(priv);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
-	ret = bcmgenet_init_dma(priv, false);
+	ret = bcmgenet_alloc_dma(priv, priv->rx_buf_len, &set);
+	if (!ret)
+		ret = bcmgenet_init_dma(priv, false, &set);
 	if (ret) {
 		/* Leave the block clocked, close and suspend tear it down */
 		netdev_err(dev, "failed to initialize DMA\n");
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 5f462b9774fad..d6600028c4591 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -541,6 +541,15 @@ struct bcmgenet_hw_params {
 	u32		words_per_bd;
 };
 
+/* Everything an open datapath needs that can fail to be allocated. Built
+ * before the running one is given up, so a failure changes nothing.
+ */
+struct bcmgenet_dma_set {
+	struct enet_cb *rx_cbs;
+	struct enet_cb *tx_cbs;
+	struct page_pool *page_pool[GENET_MAX_MQ_CNT + 1];
+};
+
 struct bcmgenet_skb_cb {
 	struct enet_cb *first_cb;	/* First control block of SKB */
 	struct enet_cb *last_cb;	/* Last control block of SKB */

-- 
2.53.0

