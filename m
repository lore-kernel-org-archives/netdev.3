Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B82472A2;
	Tue,  4 Aug 2026 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811112; cv=none; b=o+wueLB9CymVUv0JoqjP3oOt/D7U2GD/STbd9V0INLJUpN10lvE/yYyAqx8pWlxC4QWamcGH2Z9VWSD1WvNSKZpca37ooHGnFyKdUfv9fv/7SiwNjhvOGCOo3UvpBf2eeNSJAK2xJNphpeHDneszKNOnHjfPbNQpRRyijLPyVkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811112; c=relaxed/simple;
	bh=E5g6+9Xahy1QTczGFUkDvuFk0o39H7kjD184Eteb1O8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grG2pXeviVBydH571vabRGkKKlRC+pZJqKldjv4B+OseThQ9xSrmEyzG3ccc+QDHCcd7Euck4Hln39dj/GqOejX71iitrKb8fdLl0i6HOVx8ZB+TvQ7/3r7F1VJpTxWPkeI8e4CBh2pghY4vbbbXng6iIq9IkJ1Y+Iq5KdB/xPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8f4316328fad11f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c495e173-7856-4d6e-a47b-59c74296082d,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:6b1ca1d3305b42c69aef1c2b94fe5a46,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 8f4316328fad11f1aa26b74ffac11d73-20260804
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 872859629; Tue, 04 Aug 2026 10:38:22 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] net: natsemi: ns83820: Fix use-after-free in ns83820_remove_one due to race condition
Date: Tue,  4 Aug 2026 10:38:12 +0800
Message-Id: <fb169d89c2e4589b1994b3526102b8b1367c2261.1785810962.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ns83820_init_one, &dev->tq_refill is bound with queue_refill, and
ns83820_rx_kick can schedule this work on system_wq when it is called
from the IRQ handler ns83820_irq (via ns83820_do_isr) or from the rx
tasklet rx_action.

If we remove the device, ns83820_remove_one makes cleanup and the
memory allocated for dev with netdev_priv() is released by
free_netdev(), while the work mentioned above may still be pending or
running. The sequence of operations that may lead to a UAF bug is as
follows:

CPU0                                      CPU1

                                          | ns83820_irq
                                          | ns83820_do_isr
                                          | ns83820_rx_kick
                                          | schedule_work(&dev->tq_refill)
ns83820_remove_one                        |
ns83820_disable_interrupts(dev)           |
unregister_netdev(ndev)                   |
free_irq(dev->pci_dev->irq, ndev)         |
iounmap(dev->base)                        |
dma_free_coherent(...)                    |
free_netdev(ndev)                         |
// dev is freed                           |
                                          | queue_refill
                                          | // use dev (use-after-free)

Fix it by canceling the work after the sources that can schedule it
(IRQ handler and rx tasklet, both via ns83820_rx_kick) have been
stopped, and before proceeding with the remaining cleanup in
ns83820_remove_one.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/net/ethernet/natsemi/ns83820.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index cdbf82affa7b..0e862e7770a9 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -2209,6 +2209,9 @@ static void ns83820_remove_one(struct pci_dev *pci_dev)
 
 	unregister_netdev(ndev);
 	free_irq(dev->pci_dev->irq, ndev);
+
+	cancel_work_sync(&dev->tq_refill);
+
 	iounmap(dev->base);
 	dma_free_coherent(&dev->pci_dev->dev, 4 * DESC_SIZE * NR_TX_DESC,
 			  dev->tx_descs, dev->tx_phy_descs);
-- 
2.25.1

