Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53361E9919;
	Sun, 18 Oct 2026 04:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792296454; cv=none; b=PS9W3kBo36cueYPSZ+edULNrdZzNRDng0v69Nnl84WIXf+J5q3sNWV3cyI4ApAPy2hFFtGlD4N8l5LvN1qxO3/2z5ywNVrfTNEZ6d7MwDFBTYTgVJFM3d16ucWLPTM4L7s6VlPOdhSQNFvilgsYj6f+hbrGbHcfXbhKHLOOnvrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792296454; c=relaxed/simple;
	bh=wZlx5MJONKTUFgsNo5CDSgSqQTh95YMTQ8TLOEUI/V0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W7ZVoNf3RgZwtp3cIX2P+hhDCG9jHcEV8QUgKdQ3rY+jVRjp9UoHvIFk5ITd7AF7APPoz8E4rXLeHHcuMDV95XfTG7sik9mybi6LLp4fEsFKIqAW9xfXkixZveFT2uZXrLlS9qMV+U9prVEjia/vqFkTysjDNvBFJ7gQHvGoORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GhsH+GYe; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GhsH+GYe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=z0
	PGUK16GCy4F9K3jHBuozWKl9+jrqvzut+dg8bfz3E=; b=GhsH+GYetX2QaUz8e+
	FqTi0wvkhOXx0D5mD8g6C3Gs2YKJwkh5sH2XAHOphdUKhBCDCosKh7RhBgu9T98g
	t2KU83Xd0j79E7EIOZIgC3WzOUhW3esO5Ee+gqqjgLMlq40xPufsV0KNAKehiurQ
	B81+/fcVLWoo8QVHJhjY6iE90=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3PyjuRdRqZzyGAw--.56687S2;
	Sun, 18 Oct 2026 12:07:11 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] net: ns83820: drain RX tasklet when stopping the device
Date: Sun, 18 Oct 2026 12:07:07 +0800
Message-Id: <20261018040708.534335-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3PyjuRdRqZzyGAw--.56687S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWfKFW8Zw4furWkAFyrZwb_yoWkZFg_uw
	1v9a45Ww45Grs3Kw15KrsxXrZ0ya4q9rn5uayqgrZYqwnrJrs3GFZ7uF1UKr1DWa1ayFWD
	Xr13KFWfA340gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRZR6wUUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8A9clmrURe-JbQAA3F

The receive interrupt handler schedules rx_tasklet after masking RX
completion interrupts. synchronize_irq() waits for the hard IRQ, but it
does not drain a tasklet that was already queued.

The stop path then cleans the RX descriptors, and device removal later
frees the rings and netdev. Kill the tasklet after resetting the device
and synchronizing the IRQ, before cleaning the descriptor state.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/ethernet/natsemi/ns83820.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/natsemi/ns83820.c b/drivers/net/ethernet/natsemi/ns83820.c
index cdbf82affa7b..f31c15cb2f51 100644
--- a/drivers/net/ethernet/natsemi/ns83820.c
+++ b/drivers/net/ethernet/natsemi/ns83820.c
@@ -1536,6 +1536,7 @@ static int ns83820_stop(struct net_device *ndev)
 	ns83820_do_reset(dev, CR_RST);
 
 	synchronize_irq(dev->pci_dev->irq);
+	tasklet_kill(&dev->rx_tasklet);
 
 	spin_lock_irq(&dev->misc_lock);
 	dev->IMR_cache &= ~(ISR_TXURN | ISR_TXIDLE | ISR_TXERR | ISR_TXDESC | ISR_TXOK);
-- 
2.34.1

