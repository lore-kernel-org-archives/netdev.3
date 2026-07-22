Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E673A3655E7
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684450; cv=none; b=jvJ7wuTHRlnRxUVXDi/vrnzp3TeJyV4yfuS0SxoEzFRfnNVbkX9tJenbi/jzPo3nnXATh2QTYeoaXtQ9Ou2dSOIX7c1M2MORaQF+B8M11spyn+9HAdQDaapESu94HFpPnH1VFs5tp35GVYBVcL3k9Hf5l0i24WAKka7yPOP8C38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684450; c=relaxed/simple;
	bh=Ha2MA3gC5dznKbVZIfP0q9AOvjcj+M8f92ILbZrciKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vC4o6FLpk2BZszb+6MfM/L3fgRA8oqxDPAzh5EUrJyjbo2ey4h8xwiTv2+YXmHSTArDMWrCG3mccVrXN7n1n371HtwL5a5N9qvQ2cb4N4rz0vrT1VSRVp3oJB4K0AqO0M60hgD3gV/eLAaNVovXyejIFvAYvQPtfqE3uI14SzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vniGeBvc; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vniGeBvc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784684446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w331fHTtRFcJWRGZnvnjkuucVLLarOPa+54xz+ZQtRs=;
	b=vniGeBvcgjIn3C5QCjrWaZxMAVYwocXA1LgFS0RPOqVXHvGtinMcZnQ59wbUGCspeiH8Z0
	sAQpEjb6GzDv4R53e/PaS4gKQ8iNVaxUb6HJumB29f9R4wI/83IUnNEtFOdB3Xj5PpniXy
	pCtIdF7lwPykOf2EAGP2PuNUFmlaMOQ=
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
Subject: [PATCH net v2 1/2] net: sxgbe: free TX rings on RX allocation failure
Date: Wed, 22 Jul 2026 09:40:54 +0800
Message-Id: <20260722014055.157269-2-chenguang.zhao@linux.dev>
In-Reply-To: <20260722014055.157269-1-chenguang.zhao@linux.dev>
References: <20260722014055.157269-1-chenguang.zhao@linux.dev>
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

Mirror the TX allocation error path and release all TX rings before
returning the error.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 5051ada43d2f..fc7b72627f2a 100644
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
 
-- 
2.25.1

