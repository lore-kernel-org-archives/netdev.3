Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34B739CCE2
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 09:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784279671; cv=none; b=F9eEtH8ayr7gH37Fzovu1BTVcVRVqXeX6COCp/gwy4B52mXCvUxSTLR1G7nn2s5Hj7vw7MARhZc2XLFICchJm7GJS5c9j8qHuxa2Fk28JBZ2F+hkDO+qeyj6jOONV95VW52CnYMuu730Ia14kwEONle1uYiYDspWWztxC9RugoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784279671; c=relaxed/simple;
	bh=tyDstTg1qxyaTrd1b2BA47+3Lels344RwtEMX4FKevs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hdi/3MT5jV43Yd5eVfN2EB8htq3xLokna3G3rvgV5p7yFvqU3PAcEGqZ1WehbcxfQnc0rRhIuTUvLbaWSNO+0I4s/Ke3yBEbA35bgDLsdEmqCxt5c1bzPUg6XVexWMAOiQXg7/6wi0cXdDUkd0VVuFi0WrNF6PXBOtzmM2xIZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/4GmoYG; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/4GmoYG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784279659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZNeFeHyccrXpDPgEUX29xQGtGofgWCrB8fCftJC+xOU=;
	b=N/4GmoYG3tBx57kg6C51ZPt1pzx5rG7TH53p5qwp5Ba3CP0qTKm3IkBbJfHGX/2lqP8tgb
	8aGBa2GIkXygRVPzberrTqUyE8m3CcTFZ/DpOaiQT4wz0+m72DCBWLU1h0hE5i6AZgaQiU
	5D2iU0kOJ6kRepBNE8pyOadVSh+OxyU=
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
Subject: [PATCH net] net: sxgbe: fix null pointer dereference in probe error path
Date: Fri, 17 Jul 2026 17:14:23 +0800
Message-Id: <20260717091423.1557737-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

The platform drvdata is not set until all IRQs have been mapped, so the
local net_device pointer is NULL when IRQ mapping fails. Remove the device
allocated by sxgbe_drv_probe() through priv instead.

Fixes: 1edb9ca69e8a ("net: sxgbe: add basic framework for Samsung 10Gb ethernet driver")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
 drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
index 2eccc7617507..e4701b29e1a0 100644
--- a/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
+++ b/drivers/net/ethernet/samsung/sxgbe/sxgbe_platform.c
@@ -82,7 +82,6 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 	void __iomem *addr;
 	struct sxgbe_priv_data *priv = NULL;
 	struct sxgbe_plat_data *plat_dat = NULL;
-	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct device_node *node = dev->of_node;
 
 	/* Get memory resource */
@@ -158,7 +157,7 @@ static int sxgbe_platform_probe(struct platform_device *pdev)
 		irq_dispose_mapping(priv->txq[i]->irq_no);
 	irq_dispose_mapping(priv->irq);
 err_drv_remove:
-	sxgbe_drv_remove(ndev);
+	sxgbe_drv_remove(priv->dev);
 err_out:
 	return -ENODEV;
 }
-- 
2.25.1

