Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792922935;
	b=wWRmne6C924a0vRE6yAtVNjjtedPJDYJxWWA9aMVF7XAOeoA3CQJGz/DFFqH9T/pT0TY
	 p3zD+4Y+BgBc6JrU+IpYJ/1THJTo0wQPPwSB17tNSHvsYeG+JFXMitMUEQwpRbhnzejLW
	 +/fINtIMUFGNbwkHvikiQfP+ykQaMvw3T4dcr0Blpab7RqTQXeaLVa9VZSHdnk3ICm5IS
	 XdEl75khybUHoOCWGlRfeCftMAtnHyPQdFCKLFvmKaXfdIlLRorr75wWpuflzoTxQWRh7
	 04poQjb0s8nhO5PWBgGLfyxkNg3NwWkHgt3QbOibtPUQBhrRPYHJk4/4bWFvMMFSJ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792922935;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TSv0+yZLYYcP5njQ5f+/DYiv7trYAEQiae7vUcOdvq8=;
	b=4sbUy9WsUbdvE098gKnfKMi9Sgo2cIcOsWKk3j9ik/ykeLlMuluTONf2DAT6+9hMn2On
	 /gjPY7AicGtDV57qUF9BTPc579TOC57Fg5w9eoaW3m2G9grDICCEVexJUAPEdQfxLxoH3
	 gwkBEdyszB7faO6MAdIpu3+tC4ZhHHa3KQmE2cmOiikUOENUcPZCne8/DQXmDDejJIHOw
	 Z2pLEph4ZJcjYC7VdLLGfsestwP7uhXpoNveUQipGGGheO2/arEZhQDLoH2JvcakPiN6/
	 Ycd7JC12+SNzvNPox5FtcICyEHHArpGt5NwB1zoVG1Jf631iB65yjhHoG4YnEieCZIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F1QJw7Q2;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6C4606A31E;
	Sun, 25 Oct 2026 10:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B6C4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=F1QJw7Q2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=TS
	v0+yZLYYcP5njQ5f+/DYiv7trYAEQiae7vUcOdvq8=; b=F1QJw7Q2NRhuB6V6fi
	/O0b11uaOVs3PLJ2d8MO1FfjWl/+15WntD5JcTjXuyOqTyhQfxzdbfu4iJm3x1EO
	yimynlaJmPw5UpestznrwogkOJSruyt05u7H7l2gD/QfrzDeEjuKkO7M2L1JnUBj
	M4KZuh3C4XzqBeMZ3fYrQ7XYw=
Received: from 4CV529F122.company.local (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3_26u1N1q7fwbCQ--.3918S4;
	Sun, 25 Oct 2026 18:07:04 +0800 (CST)
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
	liuxuanjun@lixiang.com,
	zhoujing3@lixiang.com,
	fujiahui@lixiang.com
Subject: [PATCH net v5 2/2] net: stmmac: restore RX descriptor buffer addresses on resume
Date: Sun, 25 Oct 2026 18:06:36 +0800
Message-Id: <20261025100636.613670-3-dinghui1111@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261025100636.613670-1-dinghui1111@163.com>
References: <20261025100636.613670-1-dinghui1111@163.com>
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
X-CM-TRANSID:_____wD3_26u1N1q7fwbCQ--.3918S4
X-Coremail-Antispam: 1Uf129KBjvJXoWfJw1Uur4rtFWDXr15Zr1rCrg_yoWDAF4Dpa
	1akw4jk3ykJr13Gw4DJr4kZa4aya45tFW8Wa1xWw4a9F4akryS9F1fXFy5ZFy7Jryqvr4S
	yF4UA3Z5CF4DXrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bjpBfUUUUU=
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC8wh5pWrd1Mg0sgAA3K

From: Ding Hui <dinghui@lixiang.com>

stmmac_suspend() disables NAPI before stopping RX DMA. Frames received
in that interval can leave completed descriptors that have not been
refilled. On GMAC4 and XGMAC, hardware writeback overwrites the descriptor
buffer addresses with status and timestamp data.

stmmac_resume() calls stmmac_clear_descriptors(), which returns those
descriptors to DMA without restoring their buffer addresses. Restarting
RX DMA can therefore cause a fatal bus error.

Restore the addresses from the attached buffers before restarting DMA.
Factor buffer allocation and address programming into helpers shared
with the normal and zero-copy refill paths. Allocate missing primary
and secondary pages with GFP_KERNEL, including a missing secondary page
when the primary page was allocated before a refill failure. Abort
resume if a required page cannot be allocated.

For XSK queues, try to allocate missing buffers but leave unavailable
slots CPU-owned so an empty fill ring does not prevent TX-only use.
DMA may stop at such a slot with an RBU event; it must not receive an
invalid buffer address.

Rebuild chain pointers that timestamp writeback may have overwritten.
Publish OWN only after all address fields have been restored, since
programming the secondary address overwrites OWN on GMAC4 and XGMAC.
Keep existing buffers and their DMA mappings rather than recycling them
as the earlier, reverted resume fix did.

Fixes: f748be531d70 ("stmmac: support new GMAC4")
Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
Changes in v5:
- Target net and add a Fixes tag for GMAC4 support.
- Share buffer preparation helpers with both RX refill paths.
- Allocate missing secondary pages independently of primary pages.
- Condense the kernel-doc and clarify CPU-owned XSK slots/RBU handling.
- Rebase onto net/main and retain SerDes cleanup on resume failure.

The allocation-flags fix is now patch 1/2 of this series.

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 190 +++++++++++++-----
 1 file changed, 138 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f5ae12208e85..e56f5d044fc8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1670,6 +1670,40 @@ static bool stmmac_rx_check_buf2_cap(struct stmmac_priv *priv)
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
@@ -1688,32 +1722,98 @@ static int stmmac_init_rx_buffers(struct stmmac_priv *priv,
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
+ * Restore buffer addresses overwritten by hardware writeback after
+ * stmmac_clear_descriptors(). Reuse attached buffers and allocate missing
+ * primary and secondary pages with GFP_KERNEL before restarting DMA.
+ *
+ * For XSK queues, try to allocate missing buffers and leave unavailable
+ * descriptors CPU-owned. Rebuild chain pointers when needed, then return
+ * valid descriptors to DMA after restoring all address fields.
+ *
+ * Return: 0 on success, or -ENOMEM if a required page cannot be allocated.
+ */
+static int stmmac_reinit_rx_descriptors(struct stmmac_priv *priv,
+					struct stmmac_dma_conf *dma_conf,
+					u32 queue)
+{
+	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
+	struct stmmac_rx_buffer *buf;
+	struct dma_desc *p;
+	int i, ret;
+
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
+		buf = &rx_q->buf_pool[i];
+		p = stmmac_get_rx_desc(priv, rx_q, i);
+
+		if (rx_q->xsk_pool) {
+			ret = stmmac_prepare_rx_buffer_zc(priv, rx_q, buf, p);
+			if (ret) {
+				/* An empty fill ring must not prevent TX-only use. */
+				stmmac_clear_desc(priv, p);
+				continue;
+			}
+		} else {
+			ret = stmmac_init_rx_buffers(priv, dma_conf, p, i,
+						     GFP_KERNEL, queue);
+			if (ret)
+				return ret;
+		}
 	}
 
-	buf->addr = page_pool_get_dma_addr(buf->page) + buf->page_offset;
+	/* Hardware timestamp writeback may have overwritten chain pointers. */
+	if (priv->descriptor_mode == STMMAC_CHAIN_MODE) {
+		void *des = priv->extend_desc ? (void *)rx_q->dma_erx :
+					      (void *)rx_q->dma_rx;
 
-	stmmac_set_desc_addr(priv, p, buf->addr);
-	if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
-		stmmac_init_desc3(priv, p);
+		stmmac_mode_init(priv, des, rx_q->dma_rx_phy,
+				 dma_conf->dma_rx_size, priv->extend_desc);
+	}
+
+	/* GMAC4/XGMAC secondary address writes overwrite the OWN bit. */
+	dma_wmb();
+	for (i = 0; i < dma_conf->dma_rx_size; i++) {
+		buf = &rx_q->buf_pool[i];
+		if (rx_q->xsk_pool && !buf->xdp)
+			continue;
+
+		p = stmmac_get_rx_desc(priv, rx_q, i);
+		stmmac_set_rx_owner(priv, p, false);
+	}
 
 	return 0;
 }
@@ -5145,10 +5245,6 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int entry = rx_q->dirty_rx;
-	gfp_t gfp = (GFP_ATOMIC | __GFP_NOWARN);
-
-	if (priv->dma_cap.host_dma_width <= 32)
-		gfp |= GFP_DMA32;
 
 	while (dirty-- > 0) {
 		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[entry];
@@ -5157,25 +5253,9 @@ static inline void stmmac_rx_refill(struct stmmac_priv *priv, u32 queue)
 
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
@@ -5578,22 +5658,15 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	while (budget-- > 0 && entry != rx_q->cur_rx) {
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
@@ -8454,6 +8527,7 @@ int stmmac_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
+	u32 queue;
 	int ret;
 
 	if (priv->plat->resume) {
@@ -8503,6 +8577,18 @@ int stmmac_resume(struct device *dev)
 	stmmac_free_tx_skbufs(priv);
 	stmmac_clear_descriptors(priv, &priv->dma_conf);
 
+	for (queue = 0; queue < priv->plat->rx_queues_to_use; queue++) {
+		ret = stmmac_reinit_rx_descriptors(priv, &priv->dma_conf, queue);
+		if (ret) {
+			netdev_err(ndev, "Failed to restore RX queue %u: %d\n",
+				   queue, ret);
+			stmmac_legacy_serdes_power_down(priv);
+			mutex_unlock(&priv->lock);
+			rtnl_unlock();
+			return ret;
+		}
+	}
+
 	ret = stmmac_hw_setup(ndev);
 	if (ret < 0) {
 		netdev_err(priv->dev, "%s: Hw setup failed\n", __func__);
-- 
2.34.1

