Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5423B42FB
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521859; cv=none; b=dVJvlUOlBMdgRv9b089K3oLrWJcz8/8iVNFnr2RVUOCPWKaca4gLMNieXPn3aOLPy8PR1t+3XsA5dKeSMrgjARk7FkF1dDqQFSU8Tl6s9gPfFLPttRVN4tYpMd7pfNUQMLjOztsp5UOGfxpWo97mNiiBKnQuQxOmfVrYbt0DLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521859; c=relaxed/simple;
	bh=7AsXl8lJbBWdWWyo4O+DB9JFzUUrFqzhUNJAuLWiaKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=guD7PpmeUsrKnhN7a1rXU25it0XICLDihVNjhlcLX5QD2J+yNfiEN/qkzcZZABTzwpxc0YSq28IenpJFUykeLOmTG231ZhE9K6/trWmKLiLD9O5BlLs9iW1e2rEHbT2PDc8W0AQPEv5klkkLMXHFMPC+roiLXNFX1dpnmEGwKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=zjkd8wt6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="zjkd8wt6"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E11251A15A2;
	Wed, 12 Aug 2026 08:04:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B5F786045E;
	Wed, 12 Aug 2026 08:04:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A035A11C4C93D;
	Wed, 12 Aug 2026 10:04:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521854; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pnN0FpzhAapp0YqcypTgIGSwzpgSufOPcxH2pWEkLuQ=;
	b=zjkd8wt6/Se2J+AcXhYHv1E3ZR2Rm+6aoPO4TGzwh4x8ne/ZqMQe7bAJ1pcebdUnWa0X95
	jXE/U3iYSA+eMckrlcIbdQOdAIgFfHP6h26NNVab6xFpMrXbD8Otk6bDud5zuALqyG+Byf
	TD/kMIVD+RKO9Im+38qNE3jBVmywnANyGTA2ue0g10xk7b2i2EVI6c2NGdvo9NBgJ701hG
	4QcBZMxR+UK6RoVyOclGex0CeTsoN16se/R3puz6RLHtqj05frNAdtHe+gFeJB6IVC9RFC
	KMNyg/SEaGIL4HH34bV33IjIVaHg9VN4Dbmxh/VPHp2DWAFYQ2nc7AUQ+3ggCQ==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 12 Aug 2026 10:03:27 +0200
Subject: [PATCH net-next v9 13/17] net: macb: introduce
 macb_context_alloc() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-macb-context-v9-13-7ddbf5f715e0@bootlin.com>
References: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
In-Reply-To: <20260812-macb-context-v9-0-7ddbf5f715e0@bootlin.com>
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
index f0a4a9dcc460..5a4eb87f5a97 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2868,6 +2868,36 @@ static int macb_alloc(struct macb_context *ctx)
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
@@ -3236,27 +3266,15 @@ static int macb_open(struct net_device *netdev)
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
@@ -3295,7 +3313,6 @@ static int macb_open(struct net_device *netdev)
 		napi_disable(&queue->napi_tx);
 	}
 	macb_free(bp->ctx);
-free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 pm_exit:

-- 
2.55.0

