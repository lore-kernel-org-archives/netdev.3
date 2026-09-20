Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D393CC32E;
	Sun, 20 Sep 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789925672; cv=none; b=jPZnTGOVZfaoTSssmlfZevbGR5CBiXk+ohtolKhaOxA8iMJJXGjLIHqFn1vCJQBA6w7uznDUVTqtU3w7R+TlKgifKXzvOQnCQHOBi+m7mxVQS6znqL8cN6h/zm93UCeJUQK/1FAOgL5OSJ3GbKu99g6Sp02YztTDeTYLW4dpZ6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789925672; c=relaxed/simple;
	bh=5HFqtoGeqEFzAN0Xt6cBYRixpGFmFQcGVMvp4LZ6mik=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyoiqg96ih4gory1owmwspVCxoDBrGHmDoYGVx8VqOMPApaMGHipVd/4z7Tr23lYhe8y8smnS7g/PeQrEj10AM3yNoM8d7LLe+wvgr/XxLEHUqVcBorZQLzrwSaOkg/mkzn9UJlU2kHrzekyaa/TjahXwcCYZXxCI14/nUN7Zz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TxbGVqvX; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TxbGVqvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Pq
	s01ndKj6y1lD+L1Yf4ulzg1U6wRZaJ7n4bKVekpvI=; b=TxbGVqvXN5KisiEFDQ
	3aQ3puzp2ferm/fkU1bIsfR+7LeGLjPAQL5W8NANCaLHr6SFKd++06T3RkSWNS9p
	rO+XvrG/UbgjpEcBfD1gEWJhz7A5C2zTXELcAyC2hGL+DsLoa+7erowY+7ijbEvU
	lLymsmgLOn7syO/UfD9UT8vis=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDnD4gHGbBqoErcAQ--.25297S2;
	Mon, 21 Sep 2026 01:34:00 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Chas Williams <3chas3@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	=?UTF-8?q?fran=C3=A7ois=20romieu?= <romieu@fr.zoreil.com>,
	linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] atm: eni: stop IRQ tasklet during device removal
Date: Mon, 21 Sep 2026 01:33:58 +0800
Message-Id: <20260920173358.2125807-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDnD4gHGbBqoErcAQ--.25297S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWruFyruF47Gr13WF4xXrb_yoW8ArWDpa
	yFga95KrW8trWUJwnrtw1UXa4rWrZ2q3yFkrWUCw12g34FyFyvqr1SkFyjkws7ZFZ7uF47
	JF1DXw4rWF4q9w7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_miiUUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wkPSWqwGQmINQAA3X

eni_int() schedules eni_dev->task, but eni_remove_one() frees the
device state without unregistering the IRQ or draining the tasklet. An
interrupt during device unbind or hot unplug can therefore leave work
that runs after eni_dev has been freed.

Mask device interrupts, free the IRQ, and kill the tasklet before
releasing its resources. Apply the same ordering to the initialization
error path after the tasklet has been initialized.

Fixes: 126a3fd251b2 ("eni: fix driver remove function and driver probe error path.")

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/atm/eni.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index 3011cf1a84a9..44e6b3ceaf11 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -1881,7 +1881,11 @@ static int eni_start(struct atm_dev *dev)
 	return 0;
 
 free_list:
+	eni_out(0, MID_IE);
+	free_irq(eni_dev->irq, dev);
+	tasklet_kill(&eni_dev->task);
 	kfree(eni_dev->free_list);
+	goto out;
 
 free_irq:
 	free_irq(eni_dev->irq, dev);
@@ -2287,13 +2291,16 @@ MODULE_DEVICE_TABLE(pci,eni_pci_tbl);
 static void eni_remove_one(struct pci_dev *pdev)
 {
 	struct atm_dev *dev = pci_get_drvdata(pdev);
-	struct eni_dev *ed = ENI_DEV(dev);
-	struct eni_zero *zero = &ed->zero;
+	struct eni_dev *eni_dev = ENI_DEV(dev);
+	struct eni_zero *zero = &eni_dev->zero;
 
+	eni_out(0, MID_IE);
+	free_irq(eni_dev->irq, dev);
+	tasklet_kill(&eni_dev->task);
 	eni_do_release(dev);
 	atm_dev_deregister(dev);
 	dma_free_coherent(&pdev->dev, ENI_ZEROES_SIZE, zero->addr, zero->dma);
-	kfree(ed);
+	kfree(eni_dev);
 	pci_disable_device(pdev);
 }
 
-- 
2.34.1

