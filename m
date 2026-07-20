Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2402C86D
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515668; cv=none; b=bADEseckJ510rtkJ6RtrTDxpZZmjrgkiVZ6R0r0T4grIGpOsdZZ3HdY/moMUH+Xpbmy6G3HB3vkCWQD71t+n4n6U3kfv+QvV4yuY08aqA/yvvOg6hqG/ADMXyVNnFWxFfS59Yy9nEsMoiYBs4EHBqzXjqNZpfQpfl40F2lc5n7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515668; c=relaxed/simple;
	bh=xMa5SKuXUY8PQQh1YRfpMt53cHCJ12AxNDWdofqqoRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S5+qRu6Hn/JvfWxC48yjYeUNKrVi6oc7Lc4kUJiV56PDSuvSVWih7f/4ictGRlF+ZOX34S8VutfjdOqf0J3uNqYyL37vjVfslmJpIgaoHOD1KDd9ZCTEtsLibYnlolXKtSI/xz1EyUTAXw0SUoSl4euHI5H1sqdezSA02nfVIJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UKvagTWf; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UKvagTWf"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784515665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5su6VsCL+otp9Bqeh1hbmJu4tK9yiFIs1ODn8DYMgAk=;
	b=UKvagTWfDmXDr5MPLjg0yhwfn7NzFdBfV0Scq7V8O7E6FlfJY2xPPhA/fW0Sa2pAQpqBH9
	bP8ArVYScOtv+kprKuPgprxMxUj781CP+/T/FJS7Cnrdigg0iMxB3d06Wc83tfZ1l+72yf
	BnbCLdmx9XxuwuQA036JJP+qkP7VrL8=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: bh74.an@samsung.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH 3/7] net: sxgbe: handle descriptor ring allocation failures
Date: Mon, 20 Jul 2026 10:47:47 +0800
Message-Id: <20260720024747.504493-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

sxgbe_open() ignores allocation failures and proceeds to program DMA with
invalid ring addresses. In addition, an RX allocation failure leaks all
TX descriptor rings allocated earlier. Check the return value and unwind
both ring types before disconnecting the PHY.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 5051ada43d2f..8d9f27065346 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -605,6 +605,9 @@ static int init_dma_desc_rings(struct net_device *netd)
 rxalloc_err:
 	while (queue_num--)
 		free_rx_ring(priv->device, priv->rxq[queue_num], rx_rsize);
+	queue_num = SXGBE_TX_QUEUES;
+	while (queue_num--)
+		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
 	return ret;
 }
 
@@ -1079,7 +1082,9 @@ static int sxgbe_open(struct net_device *dev)
 	priv->dma_buf_sz = SXGBE_ALIGN(DMA_BUFFER_SIZE);
 	priv->tx_tc = TC_DEFAULT;
 	priv->rx_tc = TC_DEFAULT;
-	init_dma_desc_rings(dev);
+	ret = init_dma_desc_rings(dev);
+	if (ret)
+		goto init_phy_error;
 
 	/* DMA initialization and SW reset */
 	ret = sxgbe_init_dma_engine(priv);
@@ -1188,6 +1193,7 @@ static int sxgbe_open(struct net_device *dev)
 
 init_error:
 	free_dma_desc_resources(priv);
+init_phy_error:
 	if (dev->phydev)
 		phy_disconnect(dev->phydev);
 phy_error:
-- 
2.25.1

