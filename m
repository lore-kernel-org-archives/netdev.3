Received: from mail-m1973188.qiye.163.com (mail-m1973188.qiye.163.com [220.197.31.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DE468C2A;
	Thu,  3 Sep 2026 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426019; cv=none; b=pDEqG12SixEMZgeh7POQgM9Q4AvZ3tDGFrDKEUN/nVrA5+nBSSvCNhMFhxxTfHR1l5Q3PVTjYsRoB6C4k7fAFpL1XYWVgdFBTaiMRCv+s/eX4mGWsKk0YkuQXHgIKKXmyQNHt7v9MtW2luq/lCIEpCArldy1/RQ3r2DA8k+W06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426019; c=relaxed/simple;
	bh=PTRJfemoe3i9ze7JJ09GzPD00fOSPDt8dJ99Gq6OhIY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kA70KOS+Ry4dhmq6OgL0sVPnl4YgT/09ewBbMHJWZ7BVXrRPUEOaL5LfDcs9TBLR0bbeRYMhK1oUJBLPbc+uQ9bLQDz0u+D2qZ2suFGuwiJNnYkzlfsWslqCFVqa7M9ejyGBcPK/gz4RW6MNLlrruBli2tGz8hRrFZFyUPQncnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=220.197.31.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5aac;
	Thu, 3 Sep 2026 16:44:51 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>,
	intel-wired-lan@lists.osuosl.org
Subject: [PATCH net-next 07/14] fm10k: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:32 +0800
Message-Id: <20260903084339.870562-8-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa0667139c003ackunm85c9d55b5cc3c
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGR5OVh8eGEgfQkNJTUwZGlYVFA
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
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index f5b4d062709a..afe939f8f4ef 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2111,8 +2111,6 @@ static int fm10k_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48));
-	if (err)
-		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (err) {
 		dev_err(&pdev->dev,
 			"DMA configuration failed: %d\n", err);
-- 
2.27.0

