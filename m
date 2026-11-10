Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314416;
	b=pWI3mS+sM/Zwj61cIvXVGUn4sRphJiwjHTnSlrn8hgpo7GWBnDDXk+LTMvQkN4pbkOu7
	 M3hZzyK4krIA46BhjeL+pEYkZsYlFLQlun7s2LlQaccWyZZ96gDERxup3aYx+8vZD3SHu
	 HwQ+HZehTVqZBK3uXvcHFBiMLlh037KTgOgHkNIuL5OHtPuhyw4olpZ3QZI4oVD7SGFms
	 schtCbgeMR9X98PEWd2Cap5S0Fw6aSmgsaYMgcRCz0bD98z5j8Fknq5Q6Lm/McpsmZEXV
	 sFU4+MKLiyNQIXP9aMV4VkeDhjHoW0J8BSdoxpeuO/zXX3I+YJWK17cYwFMRAmgRZWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314416;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=524HyDUmf+sLpwoquAsPdLAkGtwSAahgCc0qpglZH/A=;
	b=LTB9Jx1cRQRk58KRxKJTEVmPaJFIv7WlYzBS+BRiHVupKV2qIgxXAThTxt+nIUoX/uoj
	 oRSvfp4ZWGzh05dpbBfMXeBahKicEproxYHmNw4k5ek+36xgMp5sR8APH19cJ0VcX2d4h
	 /+ZYVO+B+FIT1b6MwJQfLj3xA5IbS59YTpjXBBq6TJDpSkRXCeQI308aIOl0BQW/GSxqp
	 GpbSFzZpejD40VPaf+ZIY8JmB8FMU7ggE9Q6cGE3t0hEhg0R7uKTlzRT9nm2SBY48uQPm
	 E61Hlf/gTONCP2mY71ySJjaL/5Wi+mUP5REeKehHyeyrhyWCgnsAd5JB/Z6Hw23upRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hk1JlxiM;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0142606A321;
	Tue, 10 Nov 2026 12:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0142606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hk1JlxiM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=52
	4HyDUmf+sLpwoquAsPdLAkGtwSAahgCc0qpglZH/A=; b=hk1JlxiM+AzjYd2zhO
	JtJMC0siLhN0qgyVGfqrhb9kGFV3nC35uvnKaigUwHuVf6xuToS6xX4Kax9wmC/W
	B6E2aeJSY/4mCxse7JjXbKhYy3Dr8hQMDsz7ssIECK5YceFTbl8jwvP9554CQZ48
	pdR/wznsYZL9RiX75Do4hYdp0=
Received: from 4CV529F122.company.local (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgD3X4hjEPNqevk+Eg--.59821S4;
	Tue, 10 Nov 2026 20:39:15 +0800 (CST)
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
Subject: [PATCH net v6 2/4] net: stmmac: track unfilled XSK RX descriptors explicitly
Date: Tue, 10 Nov 2026 20:38:53 +0800
Message-Id: <21bdb74b652f08bb8e9fa1027381b499b9e18514.1794311618.git.dinghui@lixiang.com>
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
X-CM-TRANSID:PCgvCgD3X4hjEPNqevk+Eg--.59821S4
X-Coremail-Antispam: 1Uf129KBjvAXoW3Kr1DGryrKryfXrW5Cr4kZwb_yoW8Gr1UAo
	Z2yFn8ta13Kr18Ar1kJr18Gry3Xanxuw1fJrWkCrZ5uayIka1aq343u3y5Jr13Ar15Kay7
	Z3W8JFsFvFZrtry5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVWE_DUUUU
X-CM-SenderInfo: pglqwx1xlriiqr6rljoofrz/xtbC9BO342rzEHN6YgAA3R

From: Ding Hui <dinghui@lixiang.com>

An XSK fill ring may supply fewer buffers than the RX ring needs. Those
unfilled descriptors must remain CPU-owned, including on legacy cores
whose clear callback only clears the buffer address. Add an ownership
operation that preserves descriptor size and ring/chain control fields.

Track the number of descriptors awaiting refill independently of the
ring indices, so an entirely empty ring can be distinguished from one
with no pending refills. Initialize the pending region after the allocated
prefix and stop consumption before entering it. Retry pending refills
on each poll, including userspace wakeups with fewer than a batch of
buffers, and retain batching during packet processing.

Update the tail after successful refills and kick legacy RX DMA. Use the
end-of-ring tail address for a refill ending at index zero, including a
completely empty ring populated before DMA has advanced from the base.
Select the receive buffer size from the XSK pool even if no buffers were
available at initialization.

Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")
Signed-off-by: Ding Hui <dinghui@lixiang.com>
---
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    |  6 +++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  |  6 +++
 .../net/ethernet/stmicro/stmmac/enh_desc.c    |  6 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    |  3 ++
 .../net/ethernet/stmicro/stmmac/norm_desc.c   |  6 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 49 +++++++++++++------
 7 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index c6a8f8d73501..307bbd63dbcb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -176,6 +176,11 @@ static void dwmac4_set_tx_owner(struct dma_desc *p)
 	p->des3 |= cpu_to_le32(TDES3_OWN);
 }
 
+static void dwmac4_clear_rx_owner(struct dma_desc *p)
+{
+	p->des3 &= cpu_to_le32(~RDES3_OWN);
+}
+
 static void dwmac4_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
 	u32 flags = (RDES3_OWN | RDES3_BUFFER1_VALID_ADDR);
@@ -539,6 +544,7 @@ const struct stmmac_desc_ops dwmac4_desc_ops = {
 	.rx_status = dwmac4_wrback_get_rx_status,
 	.set_tx_owner = dwmac4_set_tx_owner,
 	.set_rx_owner = dwmac4_set_rx_owner,
+	.clear_rx_owner = dwmac4_clear_rx_owner,
 	.get_rx_vlan_tci = dwmac4_wrback_get_rx_vlan_tci,
 	.get_rx_vlan_valid = dwmac4_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwmac4_wrback_get_rx_frame_len,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index 6719ac6e395b..ad377c76ed4e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -51,6 +51,11 @@ static void dwxgmac2_set_tx_owner(struct dma_desc *p)
 	p->des3 |= cpu_to_le32(XGMAC_TDES3_OWN);
 }
 
+static void dwxgmac2_clear_rx_owner(struct dma_desc *p)
+{
+	p->des3 &= cpu_to_le32(~XGMAC_RDES3_OWN);
+}
+
 static void dwxgmac2_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
 	u32 flags = XGMAC_RDES3_OWN;
@@ -350,6 +355,7 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.rx_status = dwxgmac2_get_rx_status,
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
+	.clear_rx_owner = dwxgmac2_clear_rx_owner,
 	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
 	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 051253601225..7c5eb4493875 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -278,6 +278,11 @@ static void enh_desc_set_tx_owner(struct dma_desc *p)
 	p->des0 |= cpu_to_le32(ETDES0_OWN);
 }
 
+static void enh_desc_clear_rx_owner(struct dma_desc *p)
+{
+	p->des0 &= cpu_to_le32(~RDES0_OWN);
+}
+
 static void enh_desc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
 	p->des0 |= cpu_to_le32(RDES0_OWN);
@@ -439,6 +444,7 @@ const struct stmmac_desc_ops enh_desc_ops = {
 	.set_tx_ic = enh_desc_set_tx_ic,
 	.set_tx_owner = enh_desc_set_tx_owner,
 	.set_rx_owner = enh_desc_set_rx_owner,
+	.clear_rx_owner = enh_desc_clear_rx_owner,
 	.get_rx_frame_len = enh_desc_get_rx_frame_len,
 	.rx_extended_status = enh_desc_get_ext_status,
 	.enable_tx_timestamp = enh_desc_enable_tx_timestamp,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 50b590d67d87..81328d5cd85d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -65,6 +65,7 @@ struct stmmac_desc_ops {
 			 struct dma_desc *p, void __iomem *ioaddr);
 	/* Handle extra events on specific interrupts hw dependent */
 	void (*set_rx_owner)(struct dma_desc *p, int disable_rx_ic);
+	void (*clear_rx_owner)(struct dma_desc *p);
 	/* Get the receive frame size */
 	int (*get_rx_frame_len)(struct dma_desc *p, int rx_coe_type);
 	/* Return the reception status looking at the RDES1 */
@@ -121,6 +122,8 @@ struct stmmac_desc_ops {
 	stmmac_do_callback(__priv, desc, get_rx_vlan_valid, __args)
 #define stmmac_tx_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, tx_status, __args)
+#define stmmac_clear_rx_owner(__priv, __args...) \
+	stmmac_do_void_callback(__priv, desc, clear_rx_owner, __args)
 #define stmmac_set_rx_owner(__priv, __args...) \
 	stmmac_do_void_callback(__priv, desc, set_rx_owner, __args)
 #define stmmac_get_rx_frame_len(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index c4b613564f87..c7dd710580a2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -141,6 +141,11 @@ static void ndesc_set_tx_owner(struct dma_desc *p)
 	p->des0 |= cpu_to_le32(TDES0_OWN);
 }
 
+static void ndesc_clear_rx_owner(struct dma_desc *p)
+{
+	p->des0 &= cpu_to_le32(~RDES0_OWN);
+}
+
 static void ndesc_set_rx_owner(struct dma_desc *p, int disable_rx_ic)
 {
 	p->des0 |= cpu_to_le32(RDES0_OWN);
@@ -284,6 +289,7 @@ const struct stmmac_desc_ops ndesc_ops = {
 	.set_tx_ic = ndesc_set_tx_ic,
 	.set_tx_owner = ndesc_set_tx_owner,
 	.set_rx_owner = ndesc_set_rx_owner,
+	.clear_rx_owner = ndesc_clear_rx_owner,
 	.get_rx_frame_len = ndesc_get_rx_frame_len,
 	.enable_tx_timestamp = ndesc_enable_tx_timestamp,
 	.get_tx_timestamp_status = ndesc_get_tx_timestamp_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 93292014c393..dc2cd46592fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -128,6 +128,8 @@ struct stmmac_rx_queue {
 	unsigned int cur_rx;
 	unsigned int dirty_rx;
 	unsigned int buf_alloc_num;
+	/* XSK descriptors waiting for refill, including a completely empty ring. */
+	unsigned int xsk_rx_pending;
 	unsigned int napi_skb_frag_size;
 	dma_addr_t dma_rx_phy;
 	unsigned int state_saved;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f5ae12208e85..80789530e2ad 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -435,7 +435,7 @@ static void stmmac_set_queue_rx_buf_size(struct stmmac_priv *priv,
 {
 	u32 buf_size;
 
-	if (rx_q->xsk_pool && rx_q->buf_alloc_num)
+	if (rx_q->xsk_pool)
 		buf_size = xsk_pool_get_rx_frame_size(rx_q->xsk_pool);
 	else
 		buf_size = priv->dma_conf.dma_buf_sz;
@@ -452,6 +452,9 @@ static inline u32 stmmac_rx_dirty(struct stmmac_priv *priv, u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 
+	if (rx_q->xsk_pool)
+		return rx_q->xsk_rx_pending;
+
 	return CIRC_CNT(rx_q->cur_rx, rx_q->dirty_rx,
 			priv->dma_conf.dma_rx_size);
 }
@@ -1609,6 +1612,9 @@ static void stmmac_clear_rx_descriptors(struct stmmac_priv *priv,
 				    priv->descriptor_mode,
 				    (i == dma_conf->dma_rx_size - 1),
 				    dma_conf->dma_buf_sz);
+		/* Only the allocated prefix may be handed to RX DMA. */
+		if (rx_q->xsk_pool && i >= rx_q->buf_alloc_num)
+			stmmac_clear_rx_owner(priv, desc);
 	}
 }
 
@@ -5576,7 +5582,7 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 
 	budget = min(budget, stmmac_rx_dirty(priv, queue));
 
-	while (budget-- > 0 && entry != rx_q->cur_rx) {
+	while (budget-- > 0) {
 		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[entry];
 		dma_addr_t dma_addr;
 		bool use_rx_wd;
@@ -5601,12 +5607,18 @@ static bool stmmac_rx_refill_zc(struct stmmac_priv *priv, u32 queue, u32 budget)
 		dma_wmb();
 		stmmac_set_rx_owner(priv, rx_desc, use_rx_wd);
 
+		rx_q->xsk_rx_pending--;
 		entry = STMMAC_NEXT_ENTRY(entry, priv->dma_conf.dma_rx_size);
 	}
 
 	if (rx_desc) {
 		rx_q->dirty_rx = entry;
-		stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue, rx_q->dirty_rx);
+		/* Use the end-of-ring address when filling an initially empty
+		 * ring completely, so the tail differs from its initial base.
+		 */
+		stmmac_set_queue_rx_tail_ptr(priv, rx_q, queue,
+					     entry ?: priv->dma_conf.dma_rx_size);
+		stmmac_enable_dma_reception(priv, priv->ioaddr, queue);
 	}
 
 	return ret;
@@ -5627,7 +5639,6 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	struct stmmac_rxq_stats *rxq_stats = &priv->xstats.rxq_stats[queue];
 	struct stmmac_rx_queue *rx_q = &priv->dma_conf.rx_queue[queue];
 	unsigned int count = 0, error = 0, len = 0;
-	int dirty = stmmac_rx_dirty(priv, queue);
 	unsigned int next_entry = rx_q->cur_rx;
 	u32 rx_errors = 0, rx_dropped = 0;
 	unsigned int desc_size;
@@ -5636,6 +5647,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 	int xdp_status = 0;
 	int status = 0;
 
+	if (rx_q->xsk_rx_pending)
+		failure = !stmmac_rx_refill_zc(priv, queue, rx_q->xsk_rx_pending);
+
 	if (netif_msg_rx_status(priv)) {
 		void *rx_head = stmmac_get_rx_desc(priv, rx_q, 0);
 
@@ -5670,11 +5684,13 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		entry = next_entry;
 		buf = &rx_q->buf_pool[entry];
 
-		if (dirty >= STMMAC_RX_FILL_BATCH) {
-			failure = failure ||
-				  !stmmac_rx_refill_zc(priv, queue, dirty);
-			dirty = 0;
-		}
+		if (!failure && rx_q->xsk_rx_pending >= STMMAC_RX_FILL_BATCH)
+			failure = !stmmac_rx_refill_zc(priv, queue,
+						     rx_q->xsk_rx_pending);
+
+		/* A CPU-owned slot in the refill region is not a packet. */
+		if (rx_q->xsk_rx_pending == priv->dma_conf.dma_rx_size)
+			break;
 
 		p = stmmac_get_rx_desc(priv, rx_q, entry);
 
@@ -5687,10 +5703,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Prefetch the next RX descriptor */
 		next_entry = STMMAC_NEXT_ENTRY(rx_q->cur_rx,
 					       priv->dma_conf.dma_rx_size);
-		if (unlikely(next_entry == rx_q->dirty_rx))
-			break;
-
 		rx_q->cur_rx = next_entry;
+		rx_q->xsk_rx_pending++;
 
 		np = stmmac_get_rx_desc(priv, rx_q, next_entry);
 
@@ -5706,7 +5720,6 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (unlikely(status == discard_frame)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
-			dirty++;
 			error = 1;
 			if (!priv->hwts_rx_en)
 				rx_errors++;
@@ -5723,7 +5736,6 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		if (likely(status & rx_not_ls)) {
 			xsk_buff_free(buf->xdp);
 			buf->xdp = NULL;
-			dirty++;
 			count++;
 			goto read_again;
 		}
@@ -5768,7 +5780,6 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		}
 
 		buf->xdp = NULL;
-		dirty++;
 		count++;
 	}
 
@@ -5780,6 +5791,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 
 	stmmac_finalize_xdp_rx(priv, xdp_status);
 
+	if (!failure && rx_q->xsk_rx_pending)
+		failure = !stmmac_rx_refill_zc(priv, queue, rx_q->xsk_rx_pending);
+
 	u64_stats_update_begin(&rxq_stats->napi_syncp);
 	u64_stats_add(&rxq_stats->napi.rx_pkt_n, count);
 	u64_stats_update_end(&rxq_stats->napi_syncp);
@@ -8414,6 +8428,11 @@ static void stmmac_reset_rx_queue(struct stmmac_priv *priv, u32 queue)
 
 	rx_q->cur_rx = 0;
 	rx_q->dirty_rx = 0;
+	if (rx_q->xsk_pool) {
+		rx_q->dirty_rx = rx_q->buf_alloc_num % priv->dma_conf.dma_rx_size;
+		rx_q->xsk_rx_pending = priv->dma_conf.dma_rx_size -
+				       rx_q->buf_alloc_num;
+	}
 }
 
 static void stmmac_reset_tx_queue(struct stmmac_priv *priv, u32 queue)
-- 
2.34.1

