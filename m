Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD64BF946;
	Mon, 28 Sep 2026 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602887; cv=none; b=k+W5uMI32+C4SgHfsT9yp5u82DzeKq7QBAQ42nfrto8MA1INV0ptBvNRWnzV5Izu+Je/HoEC1Z9UXq7LxMZBqIBApaQulDhkyBERWBCAWgjIPo2PDdcmLy+iI5MO+eLYt3CS/bUogBlTIPf9iFbJCih2FpHzWQj2J8SGEAKITmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602887; c=relaxed/simple;
	bh=OvPesYhUz0abtatRiPDF0DqCezg+bPtnVd+8UCJjitE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqyIdRZYXEQpFLSwkIJfiKjx473oQW9u7ejSb5iKJX3t71ZdxAAHsYoenb/fcmxQeg8MMBVRiO7g6zzJm1tgwvnQTALPX+WQv32HjqGExKBeuuNqxH/dJ6+fLNZH6I4DSqoI6VD4iGgeRFsw2sNCH3mGtp+s1wvSfNk1CdUWm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=B7h1P9/H; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="B7h1P9/H"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.109])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f5d6f42b;
	Mon, 28 Sep 2026 21:41:17 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net
Cc: edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	o-takashi@sakamocchi.jp,
	kees@kernel.org,
	u.kleine-koenig@baylibre.com,
	bhelgaas@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH net] net: calxeda: cancel timeout work before freeing rings
Date: Mon, 28 Sep 2026 21:41:15 +0800
Message-ID: <20260928134115.1957-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0e83f982d03a1kunmb71640c3200197
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDHklNVhlKTRhJSkMdHRgfSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VSktCWVdZFhoPEhUdFFlBWU9LSFVKS0hKT0
	hMVUpLS1VKQktLWQY+
DKIM-Signature: a=rsa-sha256;
	b=B7h1P9/HjY4sYg1kdne5dpMbDktJTIGz2J5q0QNTCxqRTjPDZzFDHb0jvmxg7+vCFLmYWJ5PkV+9u0HOWHTVdks7ZHnPsgt9NrCW1qfuonM2J4xgSdRbI+t6iyzXsQHYH4YcPA3OxirG/YvHGrzLHaQzQ64Qk5hq/jUigXOYRak=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=JPpesLbpqTXhTChazicZMw0rRv0UVvEk9s0aeAKcx4s=;
	h=date:mime-version:subject:message-id:from;

The transmit timeout paths queue tx_timeout_work, which accesses the DMA
rings and NAPI state. xgmac_stop() can free the rings without waiting
for a queued timeout worker, so the worker may subsequently use freed
storage.

Stop transmit and interrupt publication, cancel the timeout work, and
only then disable NAPI and release the rings.

Fixes: 85c10f282861 ("net: add calxeda xgmac ethernet driver")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/net/ethernet/calxeda/xgmac.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/calxeda/xgmac.c b/drivers/net/ethernet/calxeda/xgmac.c
index a2410fba6be2..63296469bd85 100644
--- a/drivers/net/ethernet/calxeda/xgmac.c
+++ b/drivers/net/ethernet/calxeda/xgmac.c
@@ -1046,12 +1046,10 @@ static int xgmac_stop(struct net_device *dev)
 {
 	struct xgmac_priv *priv = netdev_priv(dev);
 
-	if (readl(priv->base + XGMAC_DMA_INTR_ENA))
-		napi_disable(&priv->napi);
-
-	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
-
 	netif_tx_disable(dev);
+	writel(0, priv->base + XGMAC_DMA_INTR_ENA);
+	cancel_work_sync(&priv->tx_timeout_work);
+	napi_disable(&priv->napi);
 
 	/* Disable the MAC core */
 	xgmac_mac_disable(priv->base);
-- 
2.50.1.windows.1

