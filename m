Received: from mail-m49226.qiye.163.com (mail-m49226.qiye.163.com [45.254.49.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39746982C;
	Thu,  3 Sep 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426028; cv=none; b=IUrHK5BVP9OW8XbGfnAHy6N5OebBRRIvFMUBW7foBDoaXCxNcu/SBiBkfAfombkPKe9p++5bIPNTTI1/26g4V5veZA6t1aCPi5/+h9f+/aujdfxmLQt12YDlW50xouMxxXtomGzm/xUhbh8N5SCXvxs/RkoQK2VghdY25nKql60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426028; c=relaxed/simple;
	bh=76/uEg7CCgtsRv05Q8ttbQver7Gydb2GL1UuImeu6r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8PYCImmfLj7MwPSxvXZvQEiCSTdzJHs12H46Nc3aVNzZAvOBaRl6EVOZe6rHlT5KvdZ3kQgDUiZ83tn8DJgvQFI+Q5Te8g7toTLTfE4UggNoKCiUv38KParCLCm/47uNpxSf7raxXhf4UEJUNKVBXkPLBhvlIW6Dri3IqiqwEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=45.254.49.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5af6;
	Thu, 3 Sep 2026 16:44:59 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>
Subject: [PATCH net-next 14/14] net: niu: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:39 +0800
Message-Id: <20260903084339.870562-15-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa06671596103ackunm85c9d55b5cc96
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTR1KVk0fTRpKTExKHUgaSFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a wider request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure is still reported and aborts initialization.
A successful setup now necessarily uses the 44-bit mask, so advertise
NETIF_F_HIGHDMA directly after checking the result.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/sun/niu.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 54dd7281191d..c74a97fe5464 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -9835,15 +9835,11 @@ static int niu_pci_init_one(struct pci_dev *pdev,
 		PCI_EXP_DEVCTL_RELAX_EN);
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
-	if (!err)
-		dev->features |= NETIF_F_HIGHDMA;
 	if (err) {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev, "No usable DMA configuration, aborting\n");
-			goto err_out_release_parent;
-		}
+		dev_err(&pdev->dev, "No usable DMA configuration, aborting\n");
+		goto err_out_release_parent;
 	}
+	dev->features |= NETIF_F_HIGHDMA;
 
 	niu_set_basic_features(dev);
 
-- 
2.27.0

