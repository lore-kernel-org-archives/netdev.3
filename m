Received: from mail-m49195.qiye.163.com (mail-m49195.qiye.163.com [45.254.49.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69000463B9B;
	Thu,  3 Sep 2026 09:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426014; cv=none; b=PmfLbiutP+GWZ7cqNHM/lxSTILNgGmL4wZvbDImDsW3Z3X8y5jitJvfYt8PZqFrPnp5EszqsVfgwn1yYyF+gg9ahXNGOULv5ZFQgV9kmoi2dm4Zu1//KZiNy0qPKkCLY/nAtijpbAhxDBec3crt0dbMeUWtS5Ktp9SqkvuFgmjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426014; c=relaxed/simple;
	bh=DP5ug96jSZhhbn5PiK1JRJeUkMOpEdyiGgmuGPV7Km4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YBM+dP4sTIBROHPEfv6+YC50/fWoYSsFYlVRsu4SnSnYJfugLpICEsFNBl5h6eD5XmcITzz9RRwHEbTuPYsvJu0G/T8r2yk6ZtYC1dP5Tf7EfMa9owtzxXogK9GkVKpCyU+9qaDJ41KgSPl6kNHE+BWQEPwyMQEcmggHlbRZm5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=45.254.49.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5a83;
	Thu, 3 Sep 2026 16:44:45 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>
Subject: [PATCH net-next 02/14] net: alx: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:27 +0800
Message-Id: <20260903084339.870562-3-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa0667122c303ackunm85c9d55b5cc0c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx1DVktOTUgYGUtPSBpMHVYVFA
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
 drivers/net/ethernet/atheros/alx/main.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index ab262e66f986..3ca69fd14a5c 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -1727,15 +1727,12 @@ static int alx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	 * shared register for the high 32 bits, so only a single, aligned,
 	 * 4 GB physical address range can be used for descriptors.
 	 */
-	if (!dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
-		dev_dbg(&pdev->dev, "DMA to 64-BIT addresses\n");
-	} else {
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev, "No usable DMA config, aborting\n");
-			goto out_pci_disable;
-		}
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_err(&pdev->dev, "No usable DMA config, aborting\n");
+		goto out_pci_disable;
 	}
+	dev_dbg(&pdev->dev, "DMA to 64-BIT addresses\n");
 
 	err = pci_request_mem_regions(pdev, alx_drv_name);
 	if (err) {
-- 
2.27.0

