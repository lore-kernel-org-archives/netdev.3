Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9252C15BE
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 01:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784413; cv=none; b=OoXJHf0y0Z8Wwr8CSlfU5xqU6rY30Qu+ZCbnM0kMif4H/vwPQ0XDE5d7tVBaeK53eMhk1Ge3aYmS+QhmT7veCuGi4Qq5hJJHv46M91pUFZ3S8Gnwo/jINkvSLgegYYbgz96dAEiug/4i4S0VPxEPJK7gOX8ETgLhP5TTey3ZiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784413; c=relaxed/simple;
	bh=hur7v+iSRA7uTVVQWVvj5R5aISkYo5aT2h/livx+GLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H/iYN2obK9j7xdEYsTJzEUfpva3X8pEpR08n0mK9Lu7PyAq3vkSUsSj/QnLhE2R1l/3NiJMJehDjUn3ByIMlAwh+zOc6ICr4nXow3elgBelofkMkjoII+B4mvJQAOHd6if2QUmBNnrZ6Vn4X54TLMTkm+0sPb//7YDr39Z8xLyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CtUGg3G9; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CtUGg3G9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZG
	02hvF1WrUDvX1gACNDjW9+lfyeQ+2VpmkYf2vymio=; b=CtUGg3G9Ii69z8ofpA
	QxEEbggzq61uZlRtQRCBkYG60jb/Gsq4Gbz5buSDExoqtXJYwZjLVM/xgEsDGNsF
	zZrN/bc7hSr6bMldi/OvhNRXJ4GNMRBfqxIH2vJ4HNmDkeePINO0WyGEpuSwBoRW
	d9qCkubJzE1PBcdBc9ncosBSU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDXVNlvIUNq79ZuGw--.43448S2;
	Tue, 30 Jun 2026 09:52:48 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	zhulei_szu@163.com
Subject: [PATCH RESEND net-next] net: airoha: Make use of the helper function dev_err_probe()
Date: Tue, 30 Jun 2026 09:52:47 +0800
Message-Id: <20260630015247.43322-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXVNlvIUNq79ZuGw--.43448S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur48tr17Kry8GFyUuFWrGrg_yoW8Zr4fpa
	9xJFWYqFykJFn8J3s3Grn5ZF95Zw45t348GF4I9r4FyryYyrsFqrs3J3yFgr4FyFWkK3y5
	JFy2vr9Y93WDXFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEL0e9UUUUU=
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC8BDPHWpDIXD3BwAA36

From: Lei Zhu <zhulei@kylinos.cn>

Use dev_err_probe() to reduce code size and simplify the code.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
The last submission was when net-next is closed.Resending it.

 drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 31cdb11cd78d..189f64e83a46 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -3071,10 +3071,9 @@ static int airoha_probe(struct platform_device *pdev)
 	eth->dev = &pdev->dev;
 
 	err = dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
-	if (err) {
-		dev_err(eth->dev, "failed configuring DMA mask\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(eth->dev, err,
+				     "failed configuring DMA mask\n");
 
 	eth->fe_regs = devm_platform_ioremap_resource_byname(pdev, "fe");
 	if (IS_ERR(eth->fe_regs))
@@ -3087,10 +3086,9 @@ static int airoha_probe(struct platform_device *pdev)
 	err = devm_reset_control_bulk_get_exclusive(eth->dev,
 						    ARRAY_SIZE(eth->rsts),
 						    eth->rsts);
-	if (err) {
-		dev_err(eth->dev, "failed to get bulk reset lines\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(eth->dev, err,
+				     "failed to get bulk reset lines\n");
 
 	xsi_rsts = devm_kcalloc(eth->dev,
 				eth->soc->num_xsi_rsts, sizeof(*xsi_rsts),
@@ -3105,10 +3103,9 @@ static int airoha_probe(struct platform_device *pdev)
 	err = devm_reset_control_bulk_get_exclusive(eth->dev,
 						    eth->soc->num_xsi_rsts,
 						    eth->xsi_rsts);
-	if (err) {
-		dev_err(eth->dev, "failed to get bulk xsi reset lines\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(eth->dev, err,
+				     "failed to get bulk xsi reset lines\n");
 
 	eth->napi_dev = alloc_netdev_dummy(0);
 	if (!eth->napi_dev)
-- 
2.25.1

