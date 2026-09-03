Received: from mail-m1973175.qiye.163.com (mail-m1973175.qiye.163.com [220.197.31.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9CF463B74;
	Thu,  3 Sep 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425105; cv=none; b=bt8UN70+jUJkAY7v6VBjbcvkfci2YhO7tRj7P2yltEZFuQxzYCZc/Oj5rget3JPMTRTfIZ6Jw1y9usi3kjRn9hnEMCfNyKwQ2tkLqbFJMuNEq4LhaXY8JH47ReVFs8x0bAWhwWnUbU+a14zIqdYVtr32zwe3ENsq2FWjt7fmiic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425105; c=relaxed/simple;
	bh=3EAUHti9+2oPFLc2dvtf/qK6I2WSVDtJTrsblkpGdeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iOOi1fkUn6v+ZGP1suGOlpgv6IXzOTVe1fZEjFofel6LBn4XZengUmM8mPszzzvsoKcMjeFDZIC+NsExKRAk9cvSyF9HMbH/9640Ti2d+QOynu2BYeO8+O7DWwxn5/3Yy6eTBxSLZOHg/n2o/BL5wlKbClQbo8QnzNoDaT/O5yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=220.197.31.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5ad1;
	Thu, 3 Sep 2026 16:44:56 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>,
	kernel-team@meta.com
Subject: [PATCH net-next 11/14] eth: fbnic: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:36 +0800
Message-Id: <20260903084339.870562-12-zhouruizhe@resnics.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260903084339.870562-1-zhouruizhe@resnics.com>
References: <20260903084339.870562-1-zhouruizhe@resnics.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa066714c5f03ackunm85c9d55b5cc67
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH09LVhgYHU1NGUIdQklDQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a wider request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure is still reported and aborts initialization.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
index 8b9bc9e8ea56..47d5dfbf3368 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
@@ -276,8 +276,6 @@ static int fbnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(46));
-	if (err)
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&pdev->dev, "DMA configuration failed: %d\n", err);
 		return err;
-- 
2.27.0

