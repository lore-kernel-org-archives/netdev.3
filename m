Received: from mail-m121161.qiye.163.com (mail-m121161.qiye.163.com [115.236.121.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE468463B91;
	Thu,  3 Sep 2026 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.121.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788425105; cv=none; b=jSBq/RPrTaI+8vjSmxe9SszjfkYpv1mlgmgOxqrQQhhtuM3EavEXo/XjF7kjEcZXHap5DjztGotoY3WoOQ87QYTeNQ5OQ9/XEoQwGMLiZ/OOemspdoV85JZzgb+LJquG0xR8uEyERa5jg+u8U+VMt/rSf4XHF1YyvOOU3nNTfY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788425105; c=relaxed/simple;
	bh=f0F5ZFqdWiVI7YLlgXJkSNCjoFIv22dtQ14ta0bGKhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiMIV3o7uPBySdK53BP4IBXJO/a/F8Hxm6m6ryJZfm2fwuFEVKt5qAIlLFuVL1BMcDodfkJYEq5xoJ+uHrxlVnjbxxM7qifoket8V31QO5oLNMPjsQhOTj6XMgARNjawxMfSZNOy1jYBFdwTZ+zVY+3AE7UEFTZ3SMecjuLm+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com; spf=pass smtp.mailfrom=resnics.com; arc=none smtp.client-ip=115.236.121.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=resnics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=resnics.com
Received: from localhost.localdomain (unknown [115.220.204.6])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4c65c5aeb;
	Thu, 3 Sep 2026 16:44:58 +0800 (GMT+08:00)
From: Ruizhe Zhou <zhouruizhe@resnics.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruizhe Zhou <zhouruizhe@resnics.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next 13/14] net: renesas: rswitch: Remove obsolete 32-bit DMA mask fallback
Date: Thu,  3 Sep 2026 16:43:38 +0800
Message-Id: <20260903084339.870562-14-zhouruizhe@resnics.com>
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
X-HM-Tid: 0aa06671551603ackunm85c9d55b5cc87
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUofVkpIHkxIQkNCGElOTVYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlKSk5VSUlLVUlLT1VNWVdZFhoPEhUdFFlBWU9LSFVKS0
	lPT09IVUpLS1VKQktLWQY+

The DMA API guarantees support for masks of 32 bits or wider and
explicitly identifies retrying a 32-bit mask after a wider request as
incorrect:
https://docs.kernel.org/core-api/dma-api-howto.html#dma-addressing-capabilities

Remove the obsolete fallback while retaining the error check so that a
genuine DMA setup failure still aborts initialization.

Signed-off-by: Ruizhe Zhou <zhouruizhe@resnics.com>
---
 drivers/net/ethernet/renesas/rswitch_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch_main.c b/drivers/net/ethernet/renesas/rswitch_main.c
index 755232994fcc..64b821ca02f8 100644
--- a/drivers/net/ethernet/renesas/rswitch_main.c
+++ b/drivers/net/ethernet/renesas/rswitch_main.c
@@ -2162,11 +2162,8 @@ static int renesas_eth_sw_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
-	if (ret < 0) {
-		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
-		if (ret < 0)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	priv->gwca.index = AGENT_INDEX_GWCA;
 	priv->gwca.num_queues = min(RSWITCH_NUM_PORTS * NUM_QUEUES_PER_NDEV,
-- 
2.27.0

