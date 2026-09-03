Received: from mail-m15594.qiye.163.com (mail-m15594.qiye.163.com [101.71.155.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A30443E3F;
	Thu,  3 Sep 2026 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425100; cv=none; b=V/1c2cv6b/QpSrebU03/cXrh4t99SrihKrIPKDLqKtyOWFBJ3npi5pErzkb/2zuHQ8POhsrVP0KBN/0Yw9uKqAFGNW9MjhCY359LgESfmgUu7FCaqUaLx37QL6MsgU7Cw+psbuqlG5l0SBG9AqJI9PHdcFEBLyz0l6vulk8P098=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425100; c=relaxed/simple;
	bh=OK+xl65sbnTrx+Xo06xjRtmxQFFRMlFv2LiruiVyY1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HDxSdOOM8eW9l2H9cDiqpQiZNe48HxZ7YMyJOtxOW72T4YmvZgdmcBvNE/zTjUHtBOzbtAb+UCEH1BuzwqKsLVOkJzdTyfCSS6fjMmh4q9Wwgj1A6F4XWCKW2cpKqa+Yi2nqeEfPzOjqx1oZ/HnM1yumjknJm5kKCX5gTG8PvO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=101.71.155.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5a8e;
	Thu, 3 Sep 2026 16:44:46 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH net-next 03/14] net: systemport: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:28 +0800
Message-Id: <20260903084339.870562-4-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa0667127ce03ackunm85c9d55b5cc19
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUlIVh5CGk5DTEIaQx5MHlYVFA
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
 drivers/net/ethernet/broadcom/bcmsysport.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 4d06c6ba6641..4f0ec136b606 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2453,8 +2453,6 @@ static int bcm_sysport_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
-	if (ret)
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (ret) {
 		dev_err(&pdev->dev, "unable to set DMA mask: %d\n", ret);
 		return ret;
-- 
2.27.0

