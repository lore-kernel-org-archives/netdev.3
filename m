Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF8457E6D;
	Thu, 24 Sep 2026 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245186; cv=none; b=epyKVYwPDMTRSXaO+j0wrjQMaUTpQKHyLOAeMv6fuYe1dZ/wOqD+nTL8JNpdf+b5bOeNwHurbw9vowctMnfPiHl+QRfnPOL5GivweqY+wql45JSivPz4GXTX/XDUEMuUwaR1mi7mj0bke8JTpDB+IdENEyD2Qo4jHv1qFWqu0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245186; c=relaxed/simple;
	bh=ncOl1/fMoV1D7Is/9UygBtdU7UfuEaehn1Z5r8QCkOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFtZjdk7whFpHrx8tTFM3TVqicbJoepRMFXur2X/RWq6YsIBf6XrR+wIuLOj5jJ1/6SXpm/LlNaPyfdhixg68X8o8of5raf3yuLPt3pIg42jpba9etRYgES/gyPGgx+7ca9IWSDUSpK+G0J09zWLDwOHPXdB7hKzKxF8fpK5r+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=npt4We1U; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="npt4We1U"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A0E28A4AA9;
	Thu, 24 Sep 2026 12:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790245174; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=Dd4LZLpz2ZuVbbhEX2b+hUZjwt0QvR0+hfyByE8uihs=;
	b=npt4We1UQGa8rE1Fyi4K4za6kcmtPVSIJJbVdsesZA9EySH8NQbzd0UwfFRooHTDQ9RFov
	KMtLfSRiBzKIwXhwDjNv83MsGVRtEeOXMqdfMdv2su7DAp6pCbcttN/7RxV1js0kET+lTr
	NDRuno8fT0NR21kCAziGv/UbGEwpLhtlzFzTJvTd7qkevrq8g6S6xwBhtDGlRqus18w8bo
	XHFjhaa9dljsBb+5Q/ZghCvtzC9/+bmLJ7esCMptV36iB+LujuugomnCotJTaW9KVKBpHu
	+9sYzVP770+9rVIy37F6wJtEt7Tbvwfe5bxOO37U8tGopSXIbnHMeWQeL4ildA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Justin Chen <justin.chen@broadcom.com>
Cc: kmehltretter@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: bcmgenet: allocate RX buffers as page fragments
Date: Thu, 24 Sep 2026 12:19:21 +0200
Message-ID: <20260924101922.2675127-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Since the page_pool conversion every RX buffer is a whole page and the
skb truesize is the page, although the hardware writes at most 2 KiB of
it. On 64 KiB pages a packet therefore counts 65792 bytes against the
socket buffer where it used to count 2752. As a result a UDP socket
with the default buffer starts to drop after three packets, and the RX
rings pin 16 MiB for 512 KiB of buffers.

Fix this and allocate the buffers as page fragments, so the truesize is
what a packet occupies. 4 KiB pages stay one buffer per page.

Sync each buffer in the refill path, as page_pool can only sync a whole
page on recycle. On 4 KiB pages that is twice what the hardware wrote.

Fixes: 7bc054c2d4ed ("net: bcmgenet: convert RX path to page_pool")
Reported-by: Karl Mehltretter <kmehltretter@gmail.com>
Closes: https://lore.kernel.org/all/20260924065839.56793-1-kmehltretter@gmail.com/
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 29 ++++++++++++++-----
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 ++
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 21668e41b696..f725d26e6020 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -57,6 +57,9 @@
  */
 #define GENET_RSB_PAD		(sizeof(struct status_64) + 2)
 
+/* RX buffer plus the skb_shared_info napi_build_skb() places behind it */
+#define GENET_RX_BUF_SIZE	SKB_HEAD_ALIGN(RX_BUF_LENGTH)
+
 /* Tx/Rx DMA register offset, skip 256 descriptors */
 #define WORDS_PER_BD(p)		(p->hw_params->words_per_bd)
 #define DMA_DESC_SIZE		(WORDS_PER_BD(priv) * sizeof(u32))
@@ -2254,11 +2257,12 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 			      struct enet_cb *cb)
 {
 	struct bcmgenet_priv *priv = ring->priv;
+	unsigned int size = GENET_RX_BUF_SIZE;
+	unsigned int offset;
 	dma_addr_t mapping;
 	struct page *page;
 
-	page = page_pool_alloc_pages(ring->page_pool,
-				     GFP_ATOMIC);
+	page = page_pool_dev_alloc(ring->page_pool, &offset, &size);
 	if (!page) {
 		priv->mib.alloc_rx_buff_failed++;
 		netif_err(priv, rx_err, priv->dev,
@@ -2267,9 +2271,13 @@ static int bcmgenet_rx_refill(struct bcmgenet_rx_ring *ring,
 	}
 
 	/* page_pool handles DMA mapping via PP_FLAG_DMA_MAP */
-	mapping = page_pool_get_dma_addr(page);
+	mapping = page_pool_get_dma_addr(page) + offset;
+	dma_sync_single_for_device(&priv->pdev->dev, mapping, RX_BUF_LENGTH,
+				   DMA_FROM_DEVICE);
 
 	cb->rx_page = page;
+	cb->rx_offset = offset;
+	cb->rx_size = size;
 	dmadesc_set_addr(priv, cb->bd_addr, mapping);
 
 	return 0;
@@ -2323,6 +2331,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 	while ((rxpktprocessed < rxpkttoprocess) &&
 	       (rxpktprocessed < budget)) {
+		unsigned int rx_offset, rx_size;
 		struct status_64 *status;
 		struct page *rx_page;
 		void *hard_start;
@@ -2332,6 +2341,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 
 		/* Save the received page before refilling */
 		rx_page = cb->rx_page;
+		rx_offset = cb->rx_offset;
+		rx_size = cb->rx_size;
 
 		if (bcmgenet_rx_refill(ring, cb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
@@ -2341,10 +2352,10 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		/* Sync the full buffer; the HW may have written anywhere
 		 * up to RX_BUF_LENGTH.
 		 */
-		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, 0,
+		page_pool_dma_sync_for_cpu(ring->page_pool, rx_page, rx_offset,
 					   RX_BUF_LENGTH);
 
-		hard_start = page_address(rx_page);
+		hard_start = page_address(rx_page) + rx_offset;
 		status = (struct status_64 *)hard_start;
 		dma_length_status = status->length_status;
 
@@ -2410,7 +2421,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		/* Build SKB from the page - data starts at hard_start,
 		 * frame begins after RSB(64) + pad(2) = 66 bytes.
 		 */
-		skb = napi_build_skb(hard_start, PAGE_SIZE);
+		skb = napi_build_skb(hard_start, rx_size);
 		if (unlikely(!skb)) {
 			BCMGENET_STATS64_INC(stats, dropped);
 			page_pool_put_full_page(ring->page_pool, rx_page,
@@ -2762,14 +2773,16 @@ static void bcmgenet_init_tx_ring(struct bcmgenet_priv *priv,
 static int bcmgenet_rx_ring_create_pool(struct bcmgenet_priv *priv,
 					struct bcmgenet_rx_ring *ring)
 {
+	/* Buffers share a page. bcmgenet_rx_refill() syncs each one for the
+	 * device, PP_FLAG_DMA_SYNC_DEV would sync the whole page.
+	 */
 	struct page_pool_params pp_params = {
 		.order = 0,
-		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.flags = PP_FLAG_DMA_MAP,
 		.pool_size = ring->size,
 		.nid = NUMA_NO_NODE,
 		.dev = &priv->pdev->dev,
 		.dma_dir = DMA_FROM_DEVICE,
-		.max_len = RX_BUF_LENGTH,
 	};
 	int err;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 22a958ba9902..86f2aed20dbe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -470,6 +470,8 @@ struct bcmgenet_rx_stats64 {
 struct enet_cb {
 	struct sk_buff      *skb;
 	struct page         *rx_page;
+	unsigned int        rx_offset;
+	unsigned int        rx_size;
 	void __iomem *bd_addr;
 	DEFINE_DMA_UNMAP_ADDR(dma_addr);
 	DEFINE_DMA_UNMAP_LEN(dma_len);
-- 
2.53.0

