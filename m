Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE137C11E
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783446105; cv=none; b=IlHYqiI2OqqoFUjU33TR9NSieP10x+K8ELbDdX+23bCWNhRfy7wf+mV4VkZuaQ0fQGyNVZKzYmwPUKMNvisVTjkZUoSYQ4jNmsVBrNWTN4VY0whuPIXwZL7xZCPIk83An17AK2UIt5OEG+B1+THvNSYImEPkTw655HuyJfI09QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783446105; c=relaxed/simple;
	bh=zi0+6p9EkVtgvF/4D27V7QCKmfVIwHiknD8A4D1wBM8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=J/Iu0qP+HSUPVlsM1mINR59Pl8nn/h5vlx3Skajsm+fDWAf6T3aFZBYD+TwmqI5rbK5raZvX20gOmEYJHDPwv6Z/rCSaVoPBf6ZUQcU2mLMSl8OoNiQQAy+ZRM1KgGe5ozxxk6KwPu7SHeMuC5dNto8k5ifeL/817jefN93W3vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A1ckOZHH; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A1ckOZHH"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260707174136euoutp01a704e616cd153d2a9cc28d9e2361e575~AEsahi-An0163701637euoutp01Y
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 17:41:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260707174136euoutp01a704e616cd153d2a9cc28d9e2361e575~AEsahi-An0163701637euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783446096;
	bh=AmE2NCWEGqRcLM+LMVgE5fFK2Ck+Oh+zbVbQcB5UN8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1ckOZHHAaOQlEwizaRUBWQZ826ol2vwIi84r6ZunIlV4aRe/cMpMQ0vow1S+e0iw
	 ZTM21HTC6blwxIbR/2+4lkkB5N50yOzQt9VJNtSG9j/6Pn8PTCDcTHxrTw7K0rgutG
	 TcWlf9j9wWHFad7Ycjl72JVo6ar4bds5fLlg6FZ0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276~AEsaLXv5H2373123731eucas1p2o;
	Tue,  7 Jul 2026 17:41:36 +0000 (GMT)
Received: from AMDC4843.eu.corp.samsungelectronics.net (unknown
	[106.120.77.61]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260707174135eusmtip1b520284028cd3af631ae6a0f945dd8d2~AEsZeKA-V1541815418eusmtip1M;
	Tue,  7 Jul 2026 17:41:35 +0000 (GMT)
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Jakub
	Raczynski <j.raczynski@samsung.com>, Sashiko AI <sashiko-bot@kernel.org>
Subject: [PATCH net 2/2] net/stmmac: Prevent dma queue NULL free on
 allocation failure
Date: Tue,  7 Jul 2026 19:41:15 +0200
Message-Id: <20260707174115.1264466-3-j.raczynski@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707174115.1264466-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
X-EPHeader: CA
X-CMS-RootMailID: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
References: <20260707174115.1264466-1-j.raczynski@samsung.com>
	<CGME20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276@eucas1p2.samsung.com>

During allocation of RX/TX descriptor resources and its DMA,
there is verification of failed dma_alloc_coherent() due to lack of memory.
In case of that failure, all allocated resources are freed instantly after,
but there are no checks for dma_free_coherent() whether previous step has
failed.
This will generally result in panic due to freeing NULL address.

Fix it by adding NULL verification of memory that is to be freed.

Theoretically code should also set address of pointed memory to zero when
freeing, but currently the only path of invalid address is non intialized zero,
and there is no case possible of double-free of same memory.

Fixes: e73b19baa3b1c ("net: stmmac: simplify DMA descriptor allocation/init/freeing")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 3098971e0b66..187d9bbc61d9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2146,7 +2146,6 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 					 u32 queue)
 {
 	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
-	size_t size;
 	void *addr;
 
 	/* Release the DMA RX socket buffers */
@@ -2164,9 +2163,12 @@ static void __free_dma_rx_desc_resources(struct stmmac_priv *priv,
 	else
 		addr = rx_q->dma_rx;
 
-	size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
+	if (!IS_ERR_OR_NULL(addr)) {
+		size_t size;
+		size = stmmac_get_rx_desc_size(priv) * dma_conf->dma_rx_size;
 
-	dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+		dma_free_coherent(priv->device, size, addr, rx_q->dma_rx_phy);
+	}
 
 	if (xdp_rxq_info_is_reg(&rx_q->xdp_rxq))
 		xdp_rxq_info_unreg(&rx_q->xdp_rxq);
@@ -2198,7 +2200,6 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 					 u32 queue)
 {
 	struct stmmac_tx_queue *tx_q = &dma_conf->tx_queue[queue];
-	size_t size;
 	void *addr;
 
 	/* Release the DMA TX socket buffers */
@@ -2212,9 +2213,12 @@ static void __free_dma_tx_desc_resources(struct stmmac_priv *priv,
 		addr = tx_q->dma_tx;
 	}
 
-	size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
+	if (!IS_ERR_OR_NULL(addr)) {
+		size_t size;
+		size = stmmac_get_tx_desc_size(priv, tx_q) * dma_conf->dma_tx_size;
 
-	dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+		dma_free_coherent(priv->device, size, addr, tx_q->dma_tx_phy);
+	}
 
 	kfree(tx_q->tx_skbuff_dma);
 	kfree(tx_q->tx_skbuff);
-- 
2.34.1

