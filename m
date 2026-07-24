Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392A443E52
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907007; cv=none; b=BMFXF+XEFLwC/6Tm2wJrEkY8EcR/hNhYMODSGY0Stzn/i9qyQ3/z4uYcPwq7Oubs+Yar0qxkYrQuXHOKULuJTC5mkbo5niUgYB9nPCrtQ0ADYfx/2o0p826FjYGGxECM6aIcdHBYyJN2uLgzhcAyMbMN5wW+4YTHBJCfRVRQeZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907007; c=relaxed/simple;
	bh=oFdBdgQeIKvuaMIKj6Q1aVc2bluNgfsKNQ+4TWz3qTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGuxByaWE2QRE9lTASBSYNU9ww4V03RVw5pn/UFE/vheNiVcIrj18BPC7jP+y68pWOdcaoEEcEq1xeYN9QuHJk0v1db3TAh7XLEp7b5nTJS9mKy72cLZEBJ1Q9x8dXuvX3mBWTFvtpWmLFAoFc3ZoIuasSmnYX7tAeAQZXda84A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PiEw+2X3; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PiEw+2X3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CDAE44E40F33;
	Fri, 24 Jul 2026 15:30:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7B76660395;
	Fri, 24 Jul 2026 15:30:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5512E11C12780;
	Fri, 24 Jul 2026 17:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784907001; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vq7WyuAy+5crbPgwX9fjl5LbzAwbrmzbx3JqQG+GDo0=;
	b=PiEw+2X3Ket6/1jYmEIwjIctN+zxOOK3e0jCNnEjh576siT6gSF3ykydwS4xKy/lcXRsBn
	9/XEA9cDeDd5XSFLzqzvFOgiKFjvkIr/PgB0mOBOKj2JbbqRNpewe0xR4e5h+UFTSgFpRI
	k7/FNsnkv75n9Tx6/TgmlNaZLRr7r2Agz6xQLlRl3LTfg9M8ukITbRWm+h3N0n5QnbMf3B
	TaY7DzL1sPZqVNnkiyKthUzhP32NR3RwLNc3lkwX4okzAAMrFcAPOVH8BAqT3jjor1KCEK
	eLlFZiBBf5TR6P1Uvg59SNGRXaDnTr47A9BZqM7Nt3USDsQWZTlsHsK6sDeXPQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 24 Jul 2026 17:29:35 +0200
Subject: [PATCH net-next v5 12/15] net: macb: introduce
 macb_context_alloc() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-macb-context-v5-12-569b1852bc7f@bootlin.com>
References: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
In-Reply-To: <20260724-macb-context-v5-0-569b1852bc7f@bootlin.com>
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

Move the context allocation sequence from inline macb_open() to its own
helper function called macb_context_alloc(). All ops doing context
swapping (set_ringparam, change_mtu, etc) will use this helper.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 55 +++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index fb8348050467..4c94c23d925a 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2866,6 +2866,36 @@ static int macb_alloc(struct macb_context *ctx)
 	return -ENOMEM;
 }
 
+static struct macb_context *macb_context_alloc(struct macb *bp,
+					       unsigned int mtu,
+					       unsigned int rx_ring_size,
+					       unsigned int tx_ring_size)
+{
+	struct macb_context *ctx;
+	int err;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+
+	ctx->info = &bp->info;
+	ctx->rx_buffer_size = macb_rx_buffer_size(bp, mtu);
+	ctx->rx_ring_size = rx_ring_size;
+	ctx->tx_ring_size = tx_ring_size;
+
+	err = macb_alloc(ctx);
+	if (err) {
+		netdev_err(bp->netdev,
+			   "Unable to allocate DMA memory (error %d)\n", err);
+		kfree(ctx);
+		return ERR_PTR(err);
+	}
+
+	bp->macbgem_ops.mog_init_rings(ctx);
+
+	return ctx;
+}
+
 static void gem_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
 	struct macb_rxq *rxq = &ctx->rxq[q];
@@ -3233,27 +3263,15 @@ static int macb_open(struct net_device *netdev)
 	if (err < 0)
 		return err;
 
-	bp->ctx = kzalloc_obj(*bp->ctx);
-	if (!bp->ctx) {
-		err = -ENOMEM;
+	bp->ctx = macb_context_alloc(bp, netdev->mtu,
+				     bp->configured_rx_ring_size,
+				     bp->configured_tx_ring_size);
+	if (IS_ERR(bp->ctx)) {
+		err = PTR_ERR(bp->ctx);
+		bp->ctx = NULL;
 		goto pm_exit;
 	}
 
-	bp->ctx->info = &bp->info;
-
-	/* RX buffers initialization */
-	bp->ctx->rx_buffer_size = macb_rx_buffer_size(bp, netdev->mtu);
-	bp->ctx->rx_ring_size = bp->configured_rx_ring_size;
-	bp->ctx->tx_ring_size = bp->configured_tx_ring_size;
-
-	err = macb_alloc(bp->ctx);
-	if (err) {
-		netdev_err(netdev, "Unable to allocate DMA memory (error %d)\n",
-			   err);
-		goto free_ctx;
-	}
-
-	bp->macbgem_ops.mog_init_rings(bp->ctx);
 	macb_init_buffers(bp);
 
 	for (q = 0, queue = bp->queues; q < bp->num_queues; ++q, ++queue) {
@@ -3292,7 +3310,6 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_tx);
 	}
 	macb_free(bp->ctx);
-free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 pm_exit:

-- 
2.55.0

