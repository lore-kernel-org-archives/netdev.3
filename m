Received: from mail-m121146.qiye.163.com (mail-m121146.qiye.163.com [115.236.121.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E83F1ABD;
	Thu,  3 Sep 2026 08:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.121.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425098; cv=none; b=rnKNDg9NTQiIhHYKBxV7buvxtkCkW+SrbXGLSeAOLLRoh+6/S/wPpCaZCkkEiUNbO5OjPFmB6UqLaCpz5RFX5XNIuJbkPbuLbXDMJEb/Wuge+d6vGGqnMy8yo0Wb0agO5+lkIljQNtKK+kpYSL5aGDsU/f3Z2XRvwhD6723Oit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425098; c=relaxed/simple;
	bh=WzO0/5VgtoQy9YHoIUq4rYaLurn+/lVYQDSoAk8b6AI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qjg6Hbzo2TAshIOnR7ZAjO3C70FMeuCY1U+DbKxesExQE2yOjpiA7jSYgKdGHAk1wlpqPAbeUp8fACOqAT+I0yKDdHncg//qq8pucbvkNMlDfvfg2N6ahp2XtZbdURmOiqcScTu6NYm5/sWYE9hC0/w+W1EHntqnJndlcTKtwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=115.236.121.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5aa6;
	Thu, 3 Sep 2026 16:44:50 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Jian Shen <shenjian15@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>
Subject: [PATCH net-next 06/14] net: hns3: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:31 +0800
Message-Id: <20260903084339.870562-7-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa0667134ea03ackunm85c9d55b5cc33
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTE4fVklOQkJPSR4YShpIQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a 64-bit request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure is still reported and aborts initialization.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index e6af939c1c19..e43bd2035edb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9156,13 +9156,8 @@ static int hclge_pci_init(struct hclge_dev *hdev)
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (ret) {
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (ret) {
-			dev_err(&pdev->dev,
-				"can't set consistent PCI DMA\n");
-			goto err_disable_device;
-		}
-		dev_warn(&pdev->dev, "set DMA mask to 32 bits\n");
+		dev_err(&pdev->dev, "can't set consistent PCI DMA\n");
+		goto err_disable_device;
 	}
 
 	ret = pci_request_regions(pdev, HCLGE_DRIVER_NAME);
-- 
2.27.0

