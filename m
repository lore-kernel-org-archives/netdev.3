Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E426370AC7;
	Tue,  4 Aug 2026 02:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810102; cv=none; b=i4LB+TsO3cCkS6K6pSrEO8HHhr/GinXG9LpiMu2Nz70InZgqXDBAHz46GhJ+I+LxhlOhfqH2BwAaMLX2ordw9bYlLXaESl/Ox6tHJ/h/8cHHKhdYkJQfetYhGLAmTbLdEy5yxqQi9+Esbs1g7NW9IxQJTt9lgyjOPjnOUhk4fho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810102; c=relaxed/simple;
	bh=EGMyKYBa5b1JfslIxl+OWYPqHhdqsgVvGtP4SOph+kI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U1A6XAhhdC4w62rsUxt6CNedqbjzRKLz25RuJKVPwLbmGr4vG3cKXeB/PHps5t/+/a7I1mWNjmChyHQfxtWJIIxofU7ksoaKFDDd8HDlUyZLJXJE35bzKzFXULGBm3XN9MaJzCiAuo9YEKUn8B8GX8miep43bfXQmfxCChASxSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3584e24e8fab11f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d491c0d7-07f1-4bd1-8bef-0c3ede4a6ad0,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:e3c5b587e9efcdd0456a865e2ae89dc3,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3584e24e8fab11f1aa26b74ffac11d73-20260804
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 623752571; Tue, 04 Aug 2026 10:21:32 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] net: calxeda: xgmac: Fix use-after-free in xgmac_remove due to race condition
Date: Tue,  4 Aug 2026 10:21:26 +0800
Message-Id: <e556148b7a938f83f8470bb3bde5b856eb9ba271.1785809990.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In xgmac_probe, &priv->tx_timeout_work is bound with
xgmac_tx_timeout_work, and xgmac_interrupt and xgmac_tx_timeout can
both schedule this work on system_wq.

If we remove the device, xgmac_remove makes cleanup and the memory
allocated for priv with netdev_priv() is released by free_netdev(),
while the work mentioned above may still be pending or running. The
sequence of operations that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                          | xgmac_interrupt
                                          | schedule_work(&priv->tx_timeout_work)
xgmac_remove                              |
xgmac_mac_disable(priv->base)             |
free_irq(ndev->irq, ndev)                 |
free_irq(priv->pmt_irq, ndev)             |
unregister_netdev(ndev)                   |
netif_napi_del(&priv->napi)               |
iounmap(priv->base)                       |
free_netdev(ndev)                         |
// priv is freed                          |
                                          | xgmac_tx_timeout_work
                                          | // use priv (use-after-free)

Fix it by canceling the work after the sources that can schedule it
(IRQ handler and the kernel netdev watchdog dev_watchdog, which calls
ndo_tx_timeout) have been stopped, and before proceeding with the
remaining cleanup in xgmac_remove.

Fixes: 8746f671ef04 ("net: calxedaxgmac: fix race between xgmac_tx_complete and xgmac_tx_err")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/net/ethernet/calxeda/xgmac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index a2410fba6be2..a692a9ad19d3 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1830,6 +1830,9 @@ static void xgmac_remove(struct platform_device *pdev)
 	free_irq(priv->pmt_irq, ndev);
 
 	unregister_netdev(ndev);
+
+	cancel_work_sync(&priv->tx_timeout_work);
+
 	netif_napi_del(&priv->napi);
 
 	iounmap(priv->base);
-- 
2.25.1

