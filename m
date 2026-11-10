Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314428;
	b=GA4MmX3rn370pbH894pDF9BM2qzVv7nS+7mz74DQhlzhMlQeuihgOrqJkYYCNu7smRuc
	 GO01+/s4wtg0g/IZ311Rf3O+Mb/AWHDiyO6icXoJCCroomLov89T/LkFleAZWTFZf0YGi
	 Ui3SDR68a3fOtx179EXuhpZ5Gddsfh0bSdChHHKybRoySEJNWTgu3PZ0BroZAc9dl0g34
	 a5VUbDy5CaKl4uwVZMzxqwzlot7rV19CqFqyalnt7qhDfTnyX76KvYggd5jRBM42G7eNE
	 UmySSBAM9iaQMov/PiVn8uI+Wxzue0qONnodM3Cf5eRoU8cKD1MY39aCmMPZqRsUJSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314428;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=sfw9ySFiRtRrQrIjxeMKH5gIrC4F6GkQ/HwQnbO+004=;
	b=hif55wY4PWvspqsOWmbQ/JNrpxwuoYMDUPDQ9Etx/CN+fpISO7LFB1VEJKXfssWLQ0MM
	 j/49DmU6DhK++4IUUzagJVyWa+jpDrTqVUilofOz3JnCoDoquysk4oSB2ENkEG2AXaGbF
	 D7rPFZ4lZW4rGcUcKyHWyn4SB5dtW96rIPMlx1hESi3tEThfIT3eDrd4RznuygRYCjQti
	 43O655ooDUlXZKRCZ8pp6GudHoZtFphv80aM5MtPKu7HYs6OBVOxu4I/hZzB3S1NRCGk6
	 6+pdbwcOIvZExVnSfZgTwiMBZGvs6RLtBTX8v9sqN4dzAxoGtJIgTB/jmtrOi3JFEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cg5XvqY9;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E020160A263D;
	Tue, 10 Nov 2026 12:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E020160A263D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cg5XvqY9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sf
	w9ySFiRtRrQrIjxeMKH5gIrC4F6GkQ/HwQnbO+004=; b=cg5XvqY9EfblyR+xDP
	37D4+ogQQaPREQy+Awi8EGVoyed0CFsY2b530n/96Xvecf3hbJr4wR4yc+PoWgSh
	R5V+iCZHsev8lHpGKhedjRH0VZO4A6EdJGPnw68qMEUd2Rp/98gXBGxVVvfqUW4Y
	imbxtX+eERVyJZRcyjk9XGN9Q=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X4hjEPNqevk+Eg--.59821S5;
	Tue, 10 Nov 2026 20:39:17 +0800 (CST)
From: Ding Hui <dinghui1111@163.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
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
Subject: [PATCH net v6 3/4] net: stmmac: restore RX descriptor buffer addresses on resume
Date: Tue, 10 Nov 2026 20:38:54 +0800
Message-Id: <09f7f5b11c1cfafcb0d84eaf81dae27b2bce76de.1794311618.git.dinghui@lixiang.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794311618.git.dinghui@lixiang.com>
References: <cover.1794311618.git.dinghui@lixiang.com>
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
X-CM-TRANSID:PCgvCgD3X4hjEPNqevk+Eg--.59821S5
X-Coremail-Antispam: 1Uf129KBjvJXoW3ur17JFyfKrWDGryUAw1rtFb_yoWkAryUpa
	13Cw4DK3ykJr13Gw4DJr48Za4aya43tFWUWayfWw4a9r4akr9a9F1FqFy5ZFyxJryv9r4S
	yF4DC3Z8CF4DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjuciUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC9BW45GrzEHV6iwAA3w

From: Ding Hui <dinghui@lixiang.com>

Suspend disables NAPI before stopping RX DMA. Hardware can complete RX
descriptors in between, overwriting GMAC4/XGMAC buffer addresses with
writeback status. Resume currently rearms those descriptors without
restoring their addresses, leading to a fatal bus error.

Share buffer preparation with the refill paths and restore addresses
from attached buffers. Allocate missing primary and secondary pages
independently with GFP_KERNEL. If allocation fails, return the error
without restarting DMA and leave the device detached.

For XSK queues, restore a contiguous populated prefix and leave the rest
CPU-owned in the pending refill region. Preserve attached buffers beyond
the prefix for later refill. Recompute the initial tail and pending count
rather than retaining the allocation count from open.

Rebuild chain pointers and discard partial receive state from before the
DMA reset. Initialize RX descriptors after restoring their addresses,
using the existing per-queue initializer to preserve the watchdog policy
and legacy control fields. Keep the unpopulated XSK suffix CPU-owned when
DMA restarts. This replaces the separate final ownership-setting loop.

Collect the resume work in stmmac_resume_descriptors(), with one loop over
TX queues and one over RX queues. Free outstanding TX buffers before
initializing each TX ring, and remove the now-unused all-queue TX wrapper.
The RX rings no longer undergo initialization before address restoration.

Unlike the reverted commit 9c63faaa931e ("net: stmmac: re-init rx buffers
when mac resume back"), retain attached buffers and their DMA mappings.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 225 +++++++++++++-----
 1 file changed, 162 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 80789530e2ad..99e46174741e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1676,6 +1676,40 @@ static bool stmmac_rx_check_buf2_cap(struct stmmac_priv *priv)
 	return priv->hw->desc && priv->hw->desc->set_sec_addr;
 }
 
+static int stmmac_prepare_rx_buffer(struct stmmac_priv *priv,
+				    struct stmmac_rx_queue *rx_q,
+				    struct stmmac_rx_buffer *buf,
+				    struct dma_desc *p, gfp_t flags)
+{
+	gfp_t gfp = flags;
+
+	if (priv->dma_cap.host_dma_width <= 32)
+		gfp |= GFP_DMA32;
+
+	if (!buf->page) {
+		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+		if (!buf->page)
+			return -ENOMEM;
+		buf->page_offset = stmmac_rx_offset(priv);
+	}
+
+	if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
+		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
+		if (!buf->sec_page)
+			return -ENOMEM;
+
+		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
+	}
+
+	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
+
+	stmmac_set_desc_addr(priv, p, buf->addr);
+	stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
+				 stmmac_rx_check_buf2_cap(priv));
+
+	return 0;
+}
+
 /**
  * stmmac_init_rx_buffers - init the RX descriptor buffer.
  * @priv: driver private structure
@@ -1694,32 +1728,104 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
 	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
-	gfp_t gfp = flags;
+	int ret;
 
-	if (priv->dma_cap.host_dma_width <= 32)
-		gfp |= GFP_DMA32;
+	ret = stmmac_prepare_rx_buffer(priv, rx_q, buf, p, flags);
+	if (ret)
+		return ret;
 
-	if (!buf->page) {
-		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
-		if (!buf->page)
+	if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
+		stmmac_init_desc3(priv, p);
+
+	return 0;
+}
+
+static int stmmac_prepare_rx_buffer_zc(struct stmmac_priv *priv,
+				       struct stmmac_rx_queue *rx_q,
+				       struct stmmac_rx_buffer *buf,
+				       struct dma_desc *p)
+{
+	if (!buf->xdp) {
+		buf->xdp = xsk_buff_alloc(rx_q->xsk_pool);
+		if (!buf->xdp)
 			return -ENOMEM;
-		buf->page_offset = stmmac_rx_offset(priv);
 	}
 
-	if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
-		buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
-		if (!buf->sec_page)
-			return -ENOMEM;
+	stmmac_set_desc_addr(priv, p, xsk_buff_xdp_get_dma(buf->xdp));
+	stmmac_set_desc_sec_addr(priv, p, 0, false);
 
-		buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr, true);
+	return 0;
+}
+
+/**
+ * stmmac_reinit_rx_descriptors - restore RX descriptors before restarting DMA
+ * @priv: driver private structure
+ * @dma_conf: DMA configuration
+ * @queue: RX queue index
+ *
+ * Restore addresses overwritten by hardware writeback, retaining attached
+ * buffers and allocating missing page_pool buffers with GFP_KERNEL. Keep
+ * descriptors CPU-owned until addresses and chain pointers are restored.
+ *
+ * For XSK, publish only the contiguous populated prefix. The remainder is
+ * left in the refill region, including any buffers already attached there,
+ * and can be populated by NAPI when userspace supplies more fill buffers.
+ *
+ * Return: 0 on success, or -ENOMEM if a required page cannot be allocated.
+ */
+static int stmmac_reinit_rx_descriptors(struct stmmac_priv *priv,
+					struct stmmac_dma_conf *dma_conf,
+					u32 queue)
+{
+	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	struct dma_desc *p;
+	int i, ret;
+
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
+		p = stmmac_get_rx_desc(priv, rx_q, i);
+		stmmac_clear_rx_owner(priv, p);
 	}
 
-	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
+	rx_q->buf_alloc_num = 0;
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
+		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
 
-	stmmac_set_desc_addr(priv, p, buf->addr);
-	if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
-		stmmac_init_desc3(priv, p);
+		p = stmmac_get_rx_desc(priv, rx_q, i);
+		if (rx_q->xsk_pool) {
+			ret = stmmac_prepare_rx_buffer_zc(priv, rx_q, buf, p);
+			if (ret)
+				break;
+		} else {
+			ret = stmmac_init_rx_buffers(priv, dma_conf, p, i,
+						     GFP_KERNEL, queue);
+			if (ret)
+				return ret;
+		}
+		rx_q->buf_alloc_num++;
+	}
+
+	/* Hardware timestamp writeback may have overwritten chain pointers. */
+	if (priv->descriptor_mode == STMMAC_CHAIN_MODE) {
+		void *des = priv->extend_desc ? (void *)rx_q->dma_erx :
+					      (void *)rx_q->dma_rx;
+
+		stmmac_mode_init(priv, des, rx_q->dma_rx_phy,
+				 dma_conf->dma_rx_size, priv->extend_desc);
+	}
+
+	/* Discard a partially assembled frame from before the DMA reset. */
+	if (rx_q->state_saved && !rx_q->xsk_pool)
+		dev_kfree_skb_any(rx_q->state.skb);
+	rx_q->state_saved = false;
+	rx_q->rx_count_frames = 0;
+	stmmac_reset_rx_queue(priv, queue);
+
+	/* Initialize control fields and publish ownership only after restoring
+	 * addresses and chain pointers. DMA is stopped; initialization also
+	 * clears OWN again for the unpopulated XSK suffix before DMA restarts.
+	 */
+	dma_wmb();
+	stmmac_clear_rx_descriptors(priv, dma_conf, queue);
 
 	return 0;
 }
@@ -2156,16 +2262,37 @@ static void dma_free_tx_skbufs(struct stmmac_priv *priv,
 }
 
 /**
- * stmmac_free_tx_skbufs - free TX skb buffers
- * @priv: private structure
+ * stmmac_resume_descriptors - prepare TX and RX rings before restarting DMA
+ * @priv: driver private structure
+ *
+ * Release outstanding TX buffers before initializing each TX ring. Restore
+ * RX buffer addresses before initializing RX descriptors and their ownership.
+ * All DMA channels must be stopped throughout this operation.
+ *
+ * Return: 0 on success, or a negative errno if RX restoration fails.
  */
-static void stmmac_free_tx_skbufs(struct stmmac_priv *priv)
+static int stmmac_resume_descriptors(struct stmmac_priv *priv)
 {
-	u8 tx_queue_cnt = priv->plat->tx_queues_to_use;
-	u8 queue;
+	struct stmmac_dma_conf *dma_conf = &priv->dma_conf;
+	u32 queue;
+	int ret;
 
-	for (queue = 0; queue < tx_queue_cnt; queue++)
-		dma_free_tx_skbufs(priv, &priv->dma_conf, queue);
+	for (queue = 0; queue < priv->plat->tx_queues_to_use; queue++) {
+		stmmac_reset_tx_queue(priv, queue);
+		dma_free_tx_skbufs(priv, dma_conf, queue);
+		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
+	}
+
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
+		ret = stmmac_reinit_rx_descriptors(priv, dma_conf, queue);
+		if (ret) {
+			netdev_err(priv->dev, "Failed to restore RX queue %u: %d\n",
+				   queue, ret);
+			return ret;
+		}
+	}
+
+	return 0;
 }
 
 /**
@@ -5151,10 +5278,6 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int entry = rx_q->dirty_rx;
-	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
-
-	if (priv->dma_cap.host_dma_width <= 32)
-		gfp |= GFP_DMA32;
 
 	while (dirty-- > 0) {
 		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[entry];
@@ -5163,25 +5286,9 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 
 		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
-		if (!buf->page) {
-			buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
-			if (!buf->page)
-				break;
-		}
-
-		if (stmmac_rx_check_buf2_cap(priv) && !buf->sec_page) {
-			buf->sec_page = page_pool_alloc_pages(rx_q->page_pool, gfp);
-			if (!buf->sec_page)
-				break;
-
-			buf->sec_addr = page_pool_get_dma_addr(buf->sec_page);
-		}
-
-		buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
-
-		stmmac_set_desc_addr(priv, p, buf->addr);
-		stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
-					 stmmac_rx_check_buf2_cap(priv));
+		if (stmmac_prepare_rx_buffer(priv, rx_q, buf, p,
+					     GFP_ATOMIC | __GFP_NOWARN))
+			break;
 		stmmac_refill_desc3(priv, rx_q, p);
 
 		use_rx_wd = !stmmac_rx_need_ic(priv, rx_q, queue);
@@ -5584,22 +5691,15 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	while (budget-- > 0) {
 		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[entry];
-		dma_addr_t dma_addr;
+		struct dma_desc *p = stmmac_get_rx_desc(priv, rx_q, entry);
 		bool use_rx_wd;
 
-		if (!buf->xdp) {
-			buf->xdp = xsk_buff_alloc(rx_q->xsk_pool);
-			if (!buf->xdp) {
-				ret = false;
-				break;
-			}
+		if (stmmac_prepare_rx_buffer_zc(priv, rx_q, buf, p)) {
+			ret = false;
+			break;
 		}
 
-		rx_desc = stmmac_get_rx_desc(priv, rx_q, entry);
-
-		dma_addr = xsk_buff_xdp_get_dma(buf->xdp);
-		stmmac_set_desc_addr(priv, rx_desc, dma_addr);
-		stmmac_set_desc_sec_addr(priv, rx_desc, 0, false);
+		rx_desc = p;
 		stmmac_refill_desc3(priv, rx_q, rx_desc);
 
 		use_rx_wd = !stmmac_rx_need_ic(priv, rx_q, queue);
@@ -8517,10 +8617,9 @@ int stmmac_resume(struct device *dev)
 
 	mutex_lock(&priv->lock);
 
-	stmmac_reset_queues_param(priv);
-
-	stmmac_free_tx_skbufs(priv);
-	stmmac_clear_descriptors(priv, &priv->dma_conf);
+	ret = stmmac_resume_descriptors(priv);
+	if (ret)
+		goto error_unlock;
 
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
-- 
2.34.1

