Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81E3E8C65;
	Tue,  4 Aug 2026 03:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812550; cv=none; b=JDgd4HLj6El2DVo2XV7ARP2/2WDt0w37yEZ4NWWz0ki3rCJ+8h+bfoGCwDdgoek/emf5GnvDdsZb5GUmXqx9IIydVcdGirj+SyL/x7be7n6WlaU7UhiWUGzauF5RbkJGHrNr+8Yc9226vb6lEdBGJ6VfORJX2pyEj+WZ+OtIbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812550; c=relaxed/simple;
	bh=me5wyfjswFIEqCGmzAvJepmrNvZTkNK9twvFm8HYSdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zg1XD60/Go1YNkAy6+21CtgRr8aVcdJLxQQ1i14Q1GA66OM7aIqIrhl7Y5dRXS+LI2NSQIBGv7t7CmffCy54QXV00J08xXZy9nQe45CVhOK1UQuJIUKxjzS0hHMPYU5Vvox6oIN2YtKgd4lW/iH3omD1iEwFusQOqeg+RBRzH8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ead1a1788fb011f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f83d0404-c3d6-468f-9146-9ee9b7338999,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:724c9f28bdd94e15d5f523c39f4884e6,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ead1a1788fb011f1aa26b74ffac11d73-20260804
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1135688325; Tue, 04 Aug 2026 11:02:24 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: chris.snook@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>
Subject: [PATCH] net: atheros: atl1: Fix use-after-free in atl1_remove due to race condition
Date: Tue,  4 Aug 2026 11:02:20 +0800
Message-Id: <59fa855b60e30eb37bb073b41fbde94b4c68901a.1785812450.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In atl1_probe, &adapter->reset_dev_task is bound with
atl1_reset_dev_task, and &adapter->link_chg_task is bound with
atlx_link_chg_task. atl1_intr (on PHY link down, DMA errors or link
events) and atlx_tx_timeout can schedule these works on system_wq.

If we remove the device, atl1_remove makes cleanup and the memory
allocated for adapter with netdev_priv() is released by free_netdev(),
while the works mentioned above may still be pending or running. The
sequence of operations that may lead to a UAF bug is as follows:

CPU0                                      CPU1

                                          | atl1_intr
                                          | schedule_work(&adapter->reset_dev_task)
atl1_remove                               |
iowrite16(0, adapter->hw.hw_addr +        |
            REG_PHY_ENABLE)               |
unregister_netdev(netdev)                 |
// ndo_stop -> atl1_close -> atl1_down    |
// -> free_irq (IRQ handler stopped)      |
pci_iounmap(pdev, adapter->hw.hw_addr)    |
pci_release_regions(pdev)                 |
free_netdev(netdev)                       |
// adapter is freed                       |
                                          | atl1_reset_dev_task
                                          | // use adapter (use-after-free)

Fix it by canceling the works after the sources that can schedule
them (IRQ handler atl1_intr and the kernel netdev watchdog, which
calls atlx_tx_timeout) have been stopped, and before proceeding with
the remaining cleanup in atl1_remove.

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 98a4d089270e..bb5a1d61c52c 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3142,6 +3142,10 @@ static void atl1_remove(struct pci_dev *pdev)
 
 	iowrite16(0, adapter->hw.hw_addr + REG_PHY_ENABLE);
 	unregister_netdev(netdev);
+
+	cancel_work_sync(&adapter->reset_dev_task);
+	cancel_work_sync(&adapter->link_chg_task);
+
 	pci_iounmap(pdev, adapter->hw.hw_addr);
 	pci_release_regions(pdev);
 	free_netdev(netdev);
-- 
2.25.1

