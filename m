Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45735E958
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 01:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784684452; cv=none; b=N9Cll/OFN0NJlyxO7IquHS7zQZzfeKi2XOnaO5zHliWhouPz0s3whYBxK/OcKzgSFic12/B7OCbB+Z33l/6weT+IjmK8f5wQR5nDP4+q3zvmisqWpyl62y+00VNtXryguJQq4N48Pkc+crh1VU24n92+JLCVmup6HUFk19cK5FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784684452; c=relaxed/simple;
	bh=gFoK/nzwgghmsONMahqBdkDK1Xo5FhOcAg0pKU4LdM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ecSBBXCnWkWWT0xbUdyoVTJFLrjL5JJLhQexHh7wGGLcJyoGY/sW5lWcD733Oh70vZ7XuFwWTlIWx+t5eRk/pwhK8iA76uQi3tIDRHvOfvtM0KVsGRxQB31DohquIlHaEEY5bbNhll3HLygHXOhczBAh1YrXWXGkxY8ji7+v6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VPcaGMvK; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VPcaGMvK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784684449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHh/wUzcvqHFQCazyTwrAXO9GPlF39CI3EZhZkyJa30=;
	b=VPcaGMvKFkF19GOMF2vo/imWPb5dsWASiYH6vOibI1a0iLV3sx/C7KFYnEXw1eN9rWkxA6
	rT0dP8ifKWa901fwPnPvmE8nfyByJ+GXAM18FbmVkjfTpPns58mRjiPeczP57SzlwsOKNj
	dkAQ2o1N5tsKMBu0XHuV6oJl6pBeQAw=
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
Subject: [PATCH net v2 2/2] net: sxgbe: check descriptor ring allocation failures
Date: Wed, 22 Jul 2026 09:40:55 +0800
Message-Id: <20260722014055.157269-3-chenguang.zhao@linux.dev>
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

sxgbe_open() ignores the return value of init_dma_desc_rings() and
continues to program DMA with invalid ring addresses when allocation
fails. Check the return value and disconnect the PHY on failure.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
index fc7b72627f2a..8d9f27065346 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_main.c
@@ -1082,7 +1082,9 @@ static int sxgbe_open(struct net_device *dev)
 	priv->dma_buf_sz = SXGBE_ALIGN(DMA_BUFFER_SIZE);
 	priv->tx_tc = TC_DEFAULT;
 	priv->rx_tc = TC_DEFAULT;
-	init_dma_desc_rings(dev);
+	ret = init_dma_desc_rings(dev);
+	if (ret)
+		goto init_phy_error;
 
 	/* DMA initialization and SW reset */
 	ret = sxgbe_init_dma_engine(priv);
@@ -1191,6 +1193,7 @@ static int sxgbe_open(struct net_device *dev)
 
 init_error:
 	free_dma_desc_resources(priv);
+init_phy_error:
 	if (dev->phydev)
 		phy_disconnect(dev->phydev);
 phy_error:
-- 
2.25.1

