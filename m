Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A52D322E
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 19:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317705; cv=none; b=XruD7vZrIX6h8tanBrEwnc9m7q3piHN7KiyDuFDxoTHss4b+iPnfwng7PwTDQRrCdxw5CLhWURj4082d+1fm58J+WJ4lce0sklI3tlEMKvRjpuJDbhwIb9UU9IoUMZR4tln3uGxIQ2PHOYcbfkLp4FBdG72lrG9kobLnzJPwD3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317705; c=relaxed/simple;
	bh=Wi36SgcEF4jXZY5zwy4bZL6IaCbc/oQ68Ak4tr51lzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KFebAk6MvdiT8eSsEwCy6Vy4DspFK+HgEzFEOBVqf111VDBwZj0Qx59ADp3D/HWa/naw4Q1OnPimJWSiLRxDLhL9Cm1GprGS2hYdd9/I1o91+umPcv645rwld9LQF4GbwNFvGExIThl5qq3UNsCmmzaLDr8UisKO8t3qo8aOadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ypuc0Vw3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ypuc0Vw3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1BD7D4E40E25;
	Fri, 17 Jul 2026 19:48:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3E3C60361;
	Fri, 17 Jul 2026 19:48:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 094D611BD03DD;
	Fri, 17 Jul 2026 21:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784317698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8uzWzN7zqZDpVjQrk89Z/GfipZT+FPIRSZOhy6RR3yI=;
	b=Ypuc0Vw3U2qguEOS7xG98Pyuo/KXyWDmlwFk0os+zbAMhZ6VN3EjiBmJrPJ1JwbEX2vOrY
	j3Jc6CSLrzNXK4bUfwSnD7bP//4MZdWONmFFunZLwM4Gil9ulNYr2tlJrGy30/ZRhwcqsU
	gtj5Mjkamkijf+WGCcLxJSuDlXKPVBgr3hBLJ6e9yBzKrJyXPa/jqJ8xi7bG2yxGD0wkh3
	H1bRLZ7eottTwEfSLa0wKOMkX2nVqe71E7StX6blJPWJ/2QdK3e8gHU1lLNdJQG4Z/VYIB
	Gyj4UOj4yrQBX11LoioMHtGyvndBjPE31H1PlyJfhQ58oKsgaAS2u63t+qHgcg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 17 Jul 2026 21:48:04 +0200
Subject: [PATCH net-next v4 01/15] net: macb: drop "consistent" from
 alloc/free function names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-macb-context-v4-1-0acbe7f10cdb@bootlin.com>
References: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
In-Reply-To: <20260717-macb-context-v4-0-0acbe7f10cdb@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Since commit 4df95131ea80 ("net/macb: change RX path for GEM") those
functions have not been only allocating or freeing consistent memory
mappings.

Rename from macb_alloc_consistent() to macb_alloc() and
       from macb_free_consistent()  to macb_free().

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index d394f1f43b68..ae7d4bb2706b 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2646,7 +2646,7 @@ static unsigned int macb_rx_ring_size_per_queue(struct macb *bp)
 	return macb_dma_desc_get_size(bp) * bp->rx_ring_size + bp->rx_bd_rd_prefetch;
 }
 
-static void macb_free_consistent(struct macb *bp)
+static void macb_free(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	struct macb_queue *queue;
@@ -2728,7 +2728,7 @@ static int macb_alloc_rx_buffers(struct macb *bp)
 	return 0;
 }
 
-static int macb_alloc_consistent(struct macb *bp)
+static int macb_alloc(struct macb *bp)
 {
 	struct device *dev = &bp->pdev->dev;
 	dma_addr_t tx_dma, rx_dma;
@@ -2786,7 +2786,7 @@ static int macb_alloc_consistent(struct macb *bp)
 	return 0;
 
 out_err:
-	macb_free_consistent(bp);
+	macb_free(bp);
 	return -ENOMEM;
 }
 
@@ -3174,7 +3174,7 @@ static int macb_open(struct net_device *dev)
 	/* RX buffers initialization */
 	macb_init_rx_buffer_size(bp, bufsz);
 
-	err = macb_alloc_consistent(bp);
+	err = macb_alloc(bp);
 	if (err) {
 		netdev_err(dev, "Unable to allocate DMA memory (error %d)\n",
 			   err);
@@ -3219,7 +3219,7 @@ static int macb_open(struct net_device *dev)
 		napi_disable(&queue->napi_rx);
 		napi_disable(&queue->napi_tx);
 	}
-	macb_free_consistent(bp);
+	macb_free(bp);
 pm_exit:
 	pm_runtime_put_sync(&bp->pdev->dev);
 	return err;
@@ -3252,7 +3252,7 @@ static int macb_close(struct net_device *dev)
 	netif_carrier_off(dev);
 	spin_unlock_irqrestore(&bp->lock, flags);
 
-	macb_free_consistent(bp);
+	macb_free(bp);
 
 	if (bp->ptp_info)
 		bp->ptp_info->ptp_remove(dev);

-- 
2.55.0

