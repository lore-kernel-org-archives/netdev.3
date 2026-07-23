Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02043341068
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 02:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784773095; cv=none; b=euBICKxOYdgiSD+3JTmmJB8Y5sQgt7LY5ib/wBpa2IctlzHSvArWcEmlfNNVrzb88C/Xjsqv9/FzlHbUpzGrvR+oJq2FAR4+RT8ot6QQPRkT8aKpIve50+IDav8BghA5zMWa+/BD2Wu7hlaehtowLMJ7QBMJ/d13Pyyg4t79lmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784773095; c=relaxed/simple;
	bh=MD2nh7IZSExdpxhw+L2cORVRXJpNbFRJjuy6q/iOzCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sRM0RSviYwW+LGCfZNbHD6wzq/zCWtzxXEHCozo1RqE/rOwpDJdTjrZR3PpAyn+cY0v9uAr6H4DvlSKGHz6M3EaMHEqnVzjfBmHdA4dz6aipeQw7I/Cu4zcmmo21dYmIKvE414qugkLSe/Q+Kmsko6JWp6oFc0elGLlpFKWqBKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mt5SFCoz; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mt5SFCoz"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784773091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBdtFq+AD/8L3U4H4luzn2t/bCMn+PUZQ92DnDTG9JI=;
	b=Mt5SFCozOYVEr0bu/QQR8dapxzA5oEeqYChZ2z5jWUqxN3xuvWkM166ljwaNX1PwcOLukD
	TjE+wDECdX+juMgHIKSYVLLNw/5XByUjJtYpJm9Nco2lD5fCgBXV1qwkpJEXOF4aqTHd62
	mN7uUKanCiHtbYq/RBlFR5HDXM2/lI8=
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
Subject: [PATCH net v3 2/2] net: sxgbe: check descriptor ring allocation failures
Date: Thu, 23 Jul 2026 10:18:20 +0800
Message-Id: <20260723021820.203960-3-chenguang.zhao@linux.dev>
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

sxgbe_open() ignores the return value of init_dma_desc_rings() and
continues to program DMA with invalid ring addresses when allocation
fails. Check the return value and disconnect the PHY on failure.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index 9b48a587d5c2..70cf3619555f 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -1078,7 +1078,9 @@ static int sxgbe_open(struct net_device *dev)
 	priv->dma_buf_sz = SXGBE_ALIGN(DMA_BUFFER_SIZE);
 	priv->tx_tc = TC_DEFAULT;
 	priv->rx_tc = TC_DEFAULT;
-	init_dma_desc_rings(dev);
+	ret = init_dma_desc_rings(dev);
+	if (ret)
+		goto init_phy_error;
 
 	/* DMA initialization and SW reset */
 	ret = sxgbe_init_dma_engine(priv);
@@ -1187,6 +1189,7 @@ static int sxgbe_open(struct net_device *dev)
 
 init_error:
 	free_dma_desc_resources(priv);
+init_phy_error:
 	if (dev->phydev)
 		phy_disconnect(dev->phydev);
 phy_error:
-- 
2.25.1

