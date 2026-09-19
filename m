Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5803F5BE3;
	Sat, 19 Sep 2026 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789820194; cv=none; b=a4gzuq5vL26vus/4/O2LDlvI8Ne4CRpWjTwiO+p5IQyQEo7e14jPWycXmtYW/ZDoFqzFos/yfYNZs+z+5EJ8+91NqqKayujf6mM7paY3fgwN97VnVmS8/30IS8R5wcCI0CQRiXXB4FpZPmzE85WUv1l4uLO3XvjcngPB6SOiM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789820194; c=relaxed/simple;
	bh=CsKEjlBetE1uMW+UDjpICB8UE+b7SYbWBQLeZUMMuuo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=atfpVAHdYdoXn/5CxN76rOvT07koBwbPR8v1SNXLhzGbVlcXet8tsct/nE7yfbl1dOmauepAn/pPVaavYyvQ2uji1Cmm3gnXwyJQYKg8EtdACzRPaOY9uIt5Ar9q24ftDksLc8TplnkKCYfOHaZdX75dosHtItrS02ftF2sm3us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iJhTDciw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iJhTDciw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=bx
	RkQkqpUhXtCKJ3gaZoY3yOukdG8nl6RZB5cRhPHes=; b=iJhTDciwF4/an5bgh3
	KrRsjtNxA50Gg/BAjlaWoa2zm9bJugpoLaKWuWS4PND+8xJNKMfr7wrX78a8QK5E
	BB6cDSfhM7+CAl0t34ON9r6jER1s7AUYCQAgB2K/DZwdllx/Fx98a4+O6jzHPnl/
	1n419ZEP7fD62jahPopg27v7I=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3MAqvfK5qJ4ONBg--.60098S2;
	Sat, 19 Sep 2026 20:14:54 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: lorenzo.bianconi@oss.qualcomm.com,
	netdev-bot+sashiko@kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org (open list:STMMAC ETHERNET DRIVER),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Cc: dinghui@lixiang.com,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: [PATCH net-next v3] net: stmmac: fix error path cleanup in DMA descriptor ring allocation
Date: Sat, 19 Sep 2026 20:14:22 +0800
Message-Id: <20260919121436.1642724-1-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3MAqvfK5qJ4ONBg--.60098S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1rWFWUWr1fJryfGFy3urg_yoW3Aw43pF
	4xCw4vk3yjqrnxGa1DJw48X3W5AayFyr4YgFW7WwsruFnIkryFgF15Aryj9rWkArykuF1S
	k398C3ZxAF1UJrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jiiSdUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC8x+UwGqufL+fXgAA3+

From: Ding Hui <dinghui@lixiang.com>

__alloc_dma_rx_desc_resources() and __alloc_dma_tx_desc_resources()
allocate resources in multiple steps but return early on failure
without cleaning up what they have already allocated. The outer
error paths then call the free helpers on partially-initialized
queues, which dereference pointers that were never allocated:

  - dma_free_rx_skbufs() and dma_free_rx_xskbufs() dereference
    rx_q->buf_pool[i] via stmmac_free_rx_buffer(), but buf_pool
    may be NULL if its kzalloc_objs() failed.

  - dma_free_tx_skbufs() dereferences tx_q->tx_skbuff_dma[i] via
    stmmac_free_tx_buffer(), but tx_skbuff_dma may be NULL if its
    kzalloc_objs() failed.

  - stmmac_free_tx_buffer() dereferences tx_q->xdpf[i] and
    tx_q->tx_skbuff[i] (aliased through a union), but tx_skbuff
    may be NULL if its allocation failed while tx_skbuff_dma
    succeeded.

Fix this by making each allocation function responsible for undoing
its own allocations on error, following the standard kernel error
handling pattern of cleaning up in reverse order. Also add NULL
checks in the free helpers as a defensive measure, since they may
be called on partially-initialized queues.
Additionally, make __free_dma_rx_desc_resources() and
__free_dma_tx_desc_resources() clear the pointers they free, so that
the NULL guards in the free helpers hold reliably when the long-lived
priv->dma_conf is reused across XDP open/release cycles.

Signed-off-by: Ding Hui <dinghui@lixiang.com>

---
Changes in v3:
  - Use addr directly in __alloc_dma_rx_desc_resources() error path
    instead of the if/else block on rx_q->dma_erx/dma_rx.
  - Clear the freed pointers in __free_dma_rx_desc_resources() and
    __free_dma_tx_desc_resources().
  - Link to v2:
    https://lore.kernel.org/netdev/20260905154654.1725313-1-dinghui1111@163.com/
Changes in v2:
  - Instead of only adding NULL checks in the free helpers, also fix
    __alloc_dma_rx_desc_resources() and __alloc_dma_tx_desc_resources()
    to clean up their own allocations on error, as suggested by Andrew.
  - Update commit message.
  - Link to v1:
    https://lore.kernel.org/netdev/20260830040610.1156008-1-dinghui1111@163.com/
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 70 ++++++++++++++++---
 1 file changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f2fc89176654..4be1f5d51d69 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1728,7 +1728,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 					 DMA_TO_DEVICE);
 	}
 
-	if (tx_q->xdpf[i] &&
+	if (tx_q->xdpf && tx_q->xdpf[i] &&
 	    (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_TX ||
 	     tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XDP_NDO)) {
 		xdp_return_frame(tx_q->xdpf[i]);
@@ -1738,7 +1738,7 @@ static void stmmac_free_tx_buffer(struct stmmac_priv *priv,
 	if (tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_XSK_TX)
 		tx_q->xsk_frames_done++;
 
-	if (tx_q->tx_skbuff[i] &&
+	if (tx_q->tx_skbuff && tx_q->tx_skbuff[i] &&
 	    tx_q->tx_skbuff_dma[i].buf_type == STMMAC_TXBUF_T_SKB) {
 		dev_kfree_skb_any(tx_q->tx_skbuff[i]);
 		tx_q->tx_skbuff[i] = NULL;
@@ -1761,6 +1761,10 @@ static void dma_free_rx_skbufs(struct stmmac_priv *priv,
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	int i;
 
+	/* buf_pool may not be allocated if alloc failed early */
+	if (!rx_q->buf_pool)
+		return;
+
 	for (i = 0; i < dma_conf->dma_rx_size; i++)
 		stmmac_free_rx_buffer(priv, rx_q, i);
 }
@@ -1802,6 +1806,10 @@ static void dma_free_rx_xskbufs(struct stmmac_priv *priv,
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	int i;
 
+	/* buf_pool may not be allocated if alloc failed early */
+	if (!rx_q->buf_pool)
+		return;
+
 	for (i = 0; i < dma_conf->dma_rx_size; i++) {
 		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
 
@@ -2097,6 +2105,10 @@ static void dma_free_tx_skbufs(struct stmmac_priv *priv,
 	struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[queue];
 	int i;
 
+	/* tx_skbuff_dma may not be allocated if alloc failed early */
+	if (!tx_q->tx_skbuff_dma)
+		return;
+
 	tx_q->xsk_frames_done = 0;
 
 	for (i = 0; i < dma_conf->dma_tx_size; i++)
@@ -2154,13 +2166,20 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
 	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	rx_q->dma_erx = NULL;
+	rx_q->dma_rx = NULL;
+	rx_q->dma_rx_phy = 0;
 
 	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
 
 	kfree(rx_q->buf_pool);
-	if (rx_q->page_pool)
+	rx_q->buf_pool = NULL;
+
+	if (rx_q->page_pool) {
 		page_pool_destroy(rx_q->page_pool);
+		rx_q->page_pool = NULL;
+	}
 }
 
 static void free_dma_rx_desc_resources(struct stmmac_priv *priv,
@@ -2202,9 +2221,16 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
 	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+	tx_q->dma_etx = NULL;
+	tx_q->dma_entx = NULL;
+	tx_q->dma_tx = NULL;
+	tx_q->dma_tx_phy = 0;
 
 	kfree(tx_q->tx_skbuff_dma);
+	tx_q->tx_skbuff_dma = NULL;
+
 	kfree(tx_q->tx_skbuff);
+	tx_q->tx_skbuff = NULL;
 }
 
 static void free_dma_tx_desc_resources(struct stmmac_priv *priv,
@@ -2272,15 +2298,19 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	}
 
 	rx_q->buf_pool = kzalloc_objs(*rx_q->buf_pool, dma_conf->dma_rx_size);
-	if (!rx_q->buf_pool)
-		return -ENOMEM;
+	if (!rx_q->buf_pool) {
+		ret = -ENOMEM;
+		goto err_destroy_pool;
+	}
 
 	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
 	addr = dma_alloc_coherent(priv->device, size, &rx_q->dma_rx_phy,
 				  GFP_KERNEL);
-	if (!addr)
-		return -ENOMEM;
+	if (!addr) {
+		ret = -ENOMEM;
+		goto err_free_buf_pool;
+	}
 
 	if (priv->extend_desc)
 		rx_q->dma_erx = addr;
@@ -2296,10 +2326,22 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	ret = xdp_rxq_info_reg(&rx_q->xdp_rxq, priv->dev, queue, napi_id);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to register xdp rxq info\n");
-		return -EINVAL;
+		goto err_free_dma;
 	}
 
 	return 0;
+
+err_free_dma:
+	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	rx_q->dma_erx = NULL;
+	rx_q->dma_rx = NULL;
+err_free_buf_pool:
+	kfree(rx_q->buf_pool);
+	rx_q->buf_pool = NULL;
+err_destroy_pool:
+	page_pool_destroy(rx_q->page_pool);
+	rx_q->page_pool = NULL;
+	return ret;
 }
 
 static int alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
@@ -2352,14 +2394,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
 
 	tx_q->tx_skbuff = kzalloc_objs(struct sk_buff *, dma_conf->dma_tx_size);
 	if (!tx_q->tx_skbuff)
-		return -ENOMEM;
+		goto err_free_skbuff_dma;
 
 	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
 	addr = dma_alloc_coherent(priv->device, size,
 				  &tx_q->dma_tx_phy, GFP_KERNEL);
 	if (!addr)
-		return -ENOMEM;
+		goto err_free_skbuff;
 
 	if (priv->extend_desc)
 		tx_q->dma_etx = addr;
@@ -2369,6 +2411,14 @@ static int __alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
 		tx_q->dma_tx = addr;
 
 	return 0;
+
+err_free_skbuff:
+	kfree(tx_q->tx_skbuff);
+	tx_q->tx_skbuff = NULL;
+err_free_skbuff_dma:
+	kfree(tx_q->tx_skbuff_dma);
+	tx_q->tx_skbuff_dma = NULL;
+	return -ENOMEM;
 }
 
 static int alloc_dma_tx_desc_resources(struct stmmac_priv *priv,
-- 
2.34.1

