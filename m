Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2541FBEA8;
	Tue, 11 Aug 2026 02:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416721; cv=none; b=NLPNrfePnsdfqEwcBhCwk9ckWna7o+Yq9ex+0THEdpuis3yraaTzwEFQvlAl+LWl6rH2IV7k+Aqpm/t4WMn+nCANmLzgBoQDqN0bj3bnKbf5bkQq8ds2UT/pbf1vOz/NO9EAEDxUw6qsRG+LIZwWSU0WshhHQrr3x6gxMSfzJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416721; c=relaxed/simple;
	bh=LWumosX73+MBe0CgjKR4abF8cabskG1XaskoMjnR7hQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=umcuXRAFZRxdk4ym7HrNcDXJILdKaf+1V9ZKhXlToUZ7ytZkLjKpAO/E80lU/Cqi+8Tm/+3TW7o+fMTXjcoG9CBJSXuGP5WDStLWITrRcMe5VU7Yc+J/acYgx2dJuJKTyvGJ0hh2a9A14vT8pDM2gZU1DiRE4U6X2J62QoGN18Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9a3abfc2952f11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a9f36aeb-c272-431e-b501-200ee12ec1c5,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:7ea2375bd48d97e8c3010c70e6fdb943,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9a3abfc2952f11f1aa26b74ffac11d73-20260811
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1775294627; Tue, 11 Aug 2026 10:51:50 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH v2] net: natsemi: ns83820: Fix use-after-free in ns83820_remove_one due to race condition
Date: Tue, 11 Aug 2026 10:51:47 +0800
Message-Id: <da666a865879cf17574fb724242c742d081c4a3b.1786416553.git.xiaopei01@kylinos.cn>
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

free_irq() only prevents the IRQ handler from running again. An rx
tasklet that was already scheduled by a previous interrupt can still
run afterwards, and rx_action calls ns83820_rx_kick, which can
re-schedule tq_refill on system_wq. This leaves a window where
queue_refill can still run after free_netdev() has freed dev.

Fix it by stopping the sources that can schedule the work, in order:
unregister_netdev() and free_irq() stop the IRQ handler, tasklet_kill()
waits for the rx tasklet to finish, and cancel_work_sync() then drains
any work that was queued before proceeding with the remaining cleanup
in ns83820_remove_one.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changes in v2: add tasklet_kill 
---
 drivers/net/ethernet/natsemi/ns83820.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index cdbf82affa7b..022fe0d29cb8 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -2209,6 +2209,10 @@ static void ns83820_remove_one(struct pci_dev *pci_dev)
 
 	unregister_netdev(ndev);
 	free_irq(dev->pci_dev->irq, ndev);
+
+	tasklet_kill(&dev->rx_tasklet);
+	cancel_work_sync(&dev->tq_refill);
+
 	iounmap(dev->base);
 	dma_free_coherent(&dev->pci_dev->dev, 4 * DESC_SIZE * NR_TX_DESC,
 			  dev->tx_descs, dev->tx_phy_descs);
-- 
2.25.1

