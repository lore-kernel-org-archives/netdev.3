Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF7D264612
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773092; cv=none; b=IJz2ZiFCxII2fIyNq+CTM1QefbyPStT/lb8PUIXT68UHj/J2sD2oaZqJP17b/rwVEieZyABoHvABYscre6I/FNFy4HjO0qhZnq3C255CZMjqbpdYF5zJ56zCslTu3E6JbxNIBkQ8D8rMRotO2OnRv6D/nYKNnfhsrADx8aaEBew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773092; c=relaxed/simple;
	bh=4Yw2cqzZO6RnvhqpVaxklQt9Yi2rclLeSX7XtUfsVU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tqwxR85DSJqwDHsFvpVMQcUt9wEOIc7m76ewiOI+oXFMouK2YN9kVhBDSmq/xIpkZviTfQrrZgSUuauNiqzd1qLsB4VmiYrDcQ+gyiuRxA8FY5m70UUIi42vn5OXuv45QPA37jxjwHhpgiJluIbur5qSpPR6dRp6yLF0iGLGSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ry2gWl5R; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ry2gWl5R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784773088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mPvhhgAl0xkE+QXzD3u8/oXqB9vT82f2kET8spGbJjM=;
	b=Ry2gWl5RI1Z7DjIGHREv1eW//tY4q0yPnFbqZ+w/j1r96GuBVUmjAU3+nRfxKn3Vg7p/io
	BID6fM+anx8mk7wMDDbbxzA10JlU+r4z5vvEiQDEXNqyFhgG1SJEllAwYFapO+nHvV64Ml
	QskDetKluRKGDk5x0puGMTo6IiY+VQU=
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
Subject: [PATCH net v3 1/2] net: sxgbe: free TX rings on RX allocation failure
Date: Thu, 23 Jul 2026 10:18:19 +0800
Message-Id: <20260723021820.203960-2-chenguang.zhao@linux.dev>
In-Reply-To: <20260723021820.203960-1-chenguang.zhao@linux.dev>
References: <20260723021820.203960-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

When RX descriptor ring allocation fails, init_dma_desc_rings() only
frees the partially allocated RX rings and returns. The TX rings that
were allocated earlier in the same function are leaked.

Rearrange error labels to clean up TX rings upon RX failures.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 5051ada43d2f..9b48a587d5c2 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -597,14 +597,13 @@ static int init_dma_desc_rings(struct net_device *netd)
 
 	return 0;
 
-txalloc_err:
-	while (queue_num--)
-		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
-	return ret;
-
 rxalloc_err:
 	while (queue_num--)
 		free_rx_ring(priv->device, priv->rxq[queue_num], rx_rsize);
+	queue_num = SXGBE_TX_QUEUES;
+txalloc_err:
+	while (queue_num--)
+		free_tx_ring(priv->device, priv->txq[queue_num], tx_rsize);
 	return ret;
 }
 
-- 
2.25.1

