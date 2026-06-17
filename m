Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781139D6F6
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687036; cv=none; b=FZwd61zV5XzwhxoNKze+phfOc0mPWl+4vhm5K/PfbipdjUWBNjnva0BKv/X98zQGEbZR4yMSq2HPWDWMjc3ZFzhpGX6AuG3e4atp2U6G5JlrkFNhRdIYV1fT7qT8JHOpfq45Nw2OAT6mx3j9RDFAtUx11g4ret3YXiPQOYQntjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687036; c=relaxed/simple;
	bh=NT2cYJEa7EmIjdPDmHM6lWBBVPlWeflgweo3534/Szc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C9Soykf04ZWQfzOTGJwc2EwKaAmtmVcfEauaHruAUvUzRdoR5ZIVaaqDPWKyuuYMxYTqSSGI0hz5khMOuYQVe+Q/6Jd27BN8k4Bz03lXqpphL6AIA3bJL/bK4V6+Y41+plSWJT7TVbPMTx6plffUOcuWc7kpvamowkGi3U+5MbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m4izoOpZ; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m4izoOpZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NQ
	KrrESnkyY6M0q6v/DR9YD8Jlj3CMz1yFCJPwvYJoc=; b=m4izoOpZbVIJ/P85J/
	vcdFGJOp3nORts0chrJBsQzNC7QnFzRkMsaibSt0EpZgfny8qPMEfICVpYmH2IHJ
	i2/Rx8cDcZ9oMfbeBCTWntSJXAa90LffT4uBOmuug7uwyzUELFb1SgSM6dk/RuOn
	nGRyt48t+nR34IYMzC3Mj9Gjo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHVzLGYjJqfzitCg--.64228S2;
	Wed, 17 Jun 2026 17:03:03 +0800 (CST)
From: Lei Zhu <zhulei_szu@163.com>
To: lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	zhulei_szu@163.com
Subject: [PATCH net-next] net: airoha: Make use of the helper function dev_err_probe()
Date: Wed, 17 Jun 2026 17:03:02 +0800
Message-Id: <20260617090302.210933-1-zhulei_szu@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHVzLGYjJqfzitCg--.64228S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur1kCrykKw1UuF4UurWfKrg_yoW8CFy7pa
	nxJFWYgFykGFn8J3s3Grs5ZF95Zw45t348GF4I9r4Fy34FyrsFqrs3J3yFgr40yFWkK3y5
	JFyjvr9Y93WDWFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi1xR3UUUUU=
X-CM-SenderInfo: x2kxzvxlbv63i6rwjhhfrp/xtbC7wfwPmoyYseGqwAA32

From: Lei Zhu <zhulei@kylinos.cn>

Use dev_err_probe() to reduce code size and simplify the code.

Signed-off-by: Lei Zhu <zhulei@kylinos.cn>
---
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

