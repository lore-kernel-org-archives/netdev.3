Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE8B360ECD
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784786267; cv=none; b=tfqsgOW2itk+aJUR7Ewwo7EQMuDVEu2vilW/FStcLEzoLnweOkE40O7VrTQoBv4vQ9Lxbip+EBXGkvsiYl5Tz2ruqofkHwRoG8WgFRlU8AzuzLwQJeQYwVu6AUbYtBQK3NYB30PhCywF7vRvEYNBcDutCJYvfqjLegq5gk1+87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784786267; c=relaxed/simple;
	bh=9xJ6adY5FH0aABtkaAscnfXyO33wvOPe81NOMR5y5zI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q3UDpJM0y4WL2WAy3dk431A3RJ5cSsp+QGEfCxtDGp7HOKbeytLyjoYXAP16ZMeYbZdPgnAhknKIX1W+wQgv+vwumJlUWs98MSCA7xvPcnKf08/1M0OZeEiPrUZQzt904SzvqA62+y5YNdoCa7bFeRe3G0ljq6qC5miCuo/84jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ijq8RnNv; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ijq8RnNv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784786262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KGWaV3dBS1OYfyiBm+OHVmrMntuT7QMC6qkZgu/DlKE=;
	b=Ijq8RnNvwAKCSaJzfobED/7AlZAT1eEUQCDBDgr6TYebg5Llioy5bWqfOz5GuZV94yihdQ
	0vGURIWVn64ini6ikFARXy162dFFrqks37HUhP1j0wX9df8kQ46mjRT8vp0E5WUx1cHDMb
	FV42d1m6i8ivOOuLWOVew+hAsiOu+Rw=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: nbd@nbd.name,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	chenguang.zhao@linux.dev,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net v2] net: ethernet: mtk_eth_soc: pass eth to mtk_handle_irq_rx in poll_controller
Date: Thu, 23 Jul 2026 13:57:35 +0800
Message-Id: <20260723055735.885112-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

mtk_handle_irq_rx expects a struct mtk_eth * (matching the request_irq
cookie), but mtk_poll_controller incorrectly passed the net_device *.
Calling ndo_poll_controller with CONFIG_NET_POLL_CONTROLLER enabled
would then crash.

Fixes: 8186f6e382d8 ("net-next: mediatek: fix compile error inside mtk_poll_controller()")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
v2:
 - Add SOB and Fixes tag.

v1:
 https://lore.kernel.org/all/20260717022339.301914-1-chenguang.zhao@linux.dev/

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 5d291e50a47b..351444fb4871 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3467,7 +3467,7 @@ static void mtk_poll_controller(struct net_device *dev)
 
 	mtk_tx_irq_disable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_disable(eth, eth->soc->rx.irq_done_mask);
-	mtk_handle_irq_rx(eth->irq[MTK_FE_IRQ_RX], dev);
+	mtk_handle_irq_rx(eth->irq[MTK_FE_IRQ_RX], eth);
 	mtk_tx_irq_enable(eth, MTK_TX_DONE_INT);
 	mtk_rx_irq_enable(eth, eth->soc->rx.irq_done_mask);
 }
-- 
2.25.1

