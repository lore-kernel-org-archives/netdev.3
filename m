Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADDF4CE663;
	Mon, 28 Sep 2026 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602894; cv=none; b=dqYEe75qVmfYA4G/M8httiu6aXCbb5Kav1jJ2i7WpZj/Lqimux0LDRqM9knv0FUkFhiErYFe89qRE4Bu279QpmR1+vc8UaXUSbk/xblPHaQXFtZw0YCNkk5l/HaPuNmEsip/6vXemAXAsZVx+mdYSryBtpXXSLWuZv5lI+XIAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602894; c=relaxed/simple;
	bh=IlCGkOTdUhUtGrQYAC1wZOGeAkFa73VSvAMBYBpWgzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyLJCmGnJlXqBPWmDpRSsvHVwMf3J0mJAwFE/ogK72b6CQkowrbxfK2B4FZGCRt4cZkq7QHDs9HbFVBExO3ZE3ytsDwK+ZEC4baIz3QKShFpDx7Hxh5ML3N0jLGobpGqaE8jtg82VANKBXhDO9oNo/92yy/egGcRygGfe2BFAB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=M7N/OIdu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="M7N/OIdu"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f42e;
	Mon, 28 Sep 2026 21:41:26 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net
Cc: edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	kory.maincent@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net] net: octeon_mgmt: kill TX tasklet before freeing rings
Date: Mon, 28 Sep 2026 21:41:25 +0800
Message-ID: <20260928134125.2003-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e83fbce503a1kunmdc92326a2001c1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTxkeVkhLH0xMSkgaSx1KHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=M7N/OIducy9rWSeGTOJfNBHnJ984ddtw64QHujQYxW6p7N4r1PzS4btYgC+lQAewy9UGuhgT9u+zrntiBoRLPVB13+vE36p57SYGXHChelLC3jrs+OdlfiCK7W8v3tgixvKmX0QEdga7QZ/UPpx0p08gTf46WGr22wClU9JeS4c=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=lG3COPlx6QXzoud86SlYC0ZjkUYxePIdYDshF0BJHLo=;
	h=date:mime-version:subject:message-id:from;

The interrupt handler schedules tx_clean_tasklet, which dereferences the
private state and TX ring. free_irq() prevents new scheduling but does
not wait for a tasklet that was already queued.

Kill the tasklet after freeing the interrupt and before purging and
freeing the DMA rings.

Fixes: d6aa60a10b2f ("NET: Add Ethernet driver for Octeon MGMT devices.")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/net/ethernet/cavium/octeon/octeon_mgmt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
index c190fc6538d4..2cf3365b9636 100644
--- a/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
+++ b/drivers/net/ethernet/cavium/octeon/octeon_mgmt.c
@@ -1254,6 +1254,7 @@ static int octeon_mgmt_stop(struct net_device *netdev)
 	octeon_mgmt_reset_hw(p);
 
 	free_irq(p->irq, netdev);
+	tasklet_kill(&p->tx_clean_tasklet);
 
 	/* dma_unmap is a nop on Octeon, so just free everything.  */
 	skb_queue_purge(&p->tx_list);
-- 
2.50.1.windows.1

