Received: from mail-m12773.qiye.163.com (mail-m12773.qiye.163.com [115.236.127.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFD63B8BA1;
	Thu,  3 Sep 2026 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425109; cv=none; b=CaEeXE1n9r98M7ysCQz3CysErwPY00xPQeFM36B450BTPyQGSo6NlVdVe3zwQmHtA7904wJLg+Gu8NiSdzzU/RXp5GaOpdf7FDignRbX6e/vPCP0FVgPHd4AvyXABUiJqdMLpZKzcX8XXO4DqH8sBzGuL2lqI+ZsQRqsCv1V8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425109; c=relaxed/simple;
	bh=UCYdr2Y/rBqwcbA6YV9eJ1aj61aKPnsVFXZbqV5ilnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Re0Ncp9DrETtoxrarM/55luJV6UwdhT2U1XL4fKHY65c3XwvBdxU6/3crnzWePuk8DQa1qZzFr8C8NWpXSno0Q4Pc69Jxu3VEWpvNd8xF1UbQ54NRTrGGw4pSbaV3NGoYAkD2tqaa/MBTYfcNyQ8PoAdPzvJiZ5mPvdxy2qmcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=115.236.127.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5ac7;
	Thu, 3 Sep 2026 16:44:55 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>
Subject: [PATCH net-next 10/14] mlxsw: pci: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:35 +0800
Message-Id: <20260903084339.870562-11-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa0667147ee03ackunm85c9d55b5cc5d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTRgaVk1OQ0oZTE9JS0xJHVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a 64-bit request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure is still reported and aborts initialization.
Update the error message to identify the combined streaming and coherent
DMA mask operation.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index bfe3268dfdc1..dceb69945d26 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -2429,11 +2429,8 @@ static int mlxsw_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
 	if (err) {
-		err = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (err) {
-			dev_err(&pdev->dev, "dma_set_mask failed\n");
-			goto err_pci_set_dma_mask;
-		}
+		dev_err(&pdev->dev, "dma_set_mask_and_coherent failed\n");
+		goto err_pci_set_dma_mask;
 	}
 
 	if (pci_resource_len(pdev, 0) < MLXSW_PCI_BAR0_SIZE) {
-- 
2.27.0

