Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4447FAF9;
	Wed, 30 Sep 2026 22:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808862; cv=none; b=czJk4V84QFCdI/mt/FpvQlRD1Rcnt8WZi9hZEa+AAhAdTc/sTtq5nTnQ1P06sbC1DaHasofRABkqNIhK2dJfmyuFn4d/SnIa5/RnMvugccjxMub4dcL1IfoMidv+65f9H2hh0l0W0UN+Zgu1uJI4NfHfWp1+bqQOQluC94x03k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808862; c=relaxed/simple;
	bh=KkCjNAl6/UZQ13IvsOAmExmn/7RqcqoA7HaWRPd5yI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9JTHCMVmP/GXooqnz/7H5CuTOwh29737EDbzBAKY9naBF74xTq8SMWdaR8jbU0+NRxC0S+JRmPJkpZhR5yrX0Cs+i+wigLIklpvQfSyJ2sc7GuyHlpX46bv9VV2sOPCbHaeaBzoZSNuKpzX+Ksbx+ZytNrmMzcpqmcsIV0l6r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3M/OSZP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3M/OSZP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 699D74E410DE;
	Wed, 30 Sep 2026 22:54:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3ED6360749;
	Wed, 30 Sep 2026 22:54:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 43CE91032A658;
	Thu,  1 Oct 2026 00:54:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790808852; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=BE9lFZUkrGV3xUStoz4RrJ68F/0HzQMu1YrM1A7zPoo=;
	b=N3M/OSZP1v59Rl0SczQ2r2N12G9n1/Ded3IMOSze3/gOxOf3AOC8QcJ58foaWCgbqEvpT/
	ORt+F4hxue1IryCmigPyaZ7VK2pw6vzdcpqqD2PuoIuKyJO6Ej/DPZyUhBtfebF+Xzy36r
	LTSriYlccSeHTvi7aBMGY6rdKIfMLGIdsiK+njwdXwEVfw8C+84Bk0ffxEoAGYHG5udiN9
	Qg21faD2PvvuAisqp+ojcBWscw2i9S5f7JtsUpflTIDr9FWJ6iufHGpQcAZ/NtF41wAtZz
	0NLLQG3ox8Sys+4OAMZ6jN0OsAqgd5FwZwJwYv+BYIEGI9nDqZf58ua6TC8ebw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Thu, 01 Oct 2026 00:53:50 +0200
Subject: [PATCH net-next v10 6/8] net: macb: introduce macb_context_alloc()
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261001-macb-context-v10-6-beb541bbb7df@bootlin.com>
References: <20261001-macb-context-v10-0-beb541bbb7df@bootlin.com>
In-Reply-To: <20261001-macb-context-v10-0-beb541bbb7df@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Move the context allocation sequence from inline macb_open() to its own
helper function called macb_context_alloc(). All ops doing context
swapping (set_ringparam, change_mtu, etc) will use this helper.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 68 +++++++++++++++++++++-----------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index f91856483d20..69873966a989 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2972,6 +2972,43 @@ static int macb_alloc(struct macb_context *ctx)
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
+		goto free_ctx;
+	}
+
+	err = bp->macbgem_ops.mog_init_rings(ctx);
+	if (err)
+		goto free_rings;
+
+	return ctx;
+
+free_rings:
+	macb_free(ctx);
+free_ctx:
+	kfree(ctx);
+	return ERR_PTR(err);
+}
+
 static int gem_init_rx_ring(struct macb_context *ctx, unsigned int q)
 {
 	struct macb_rxq *rxq = &ctx->rxq[q];
@@ -3342,6 +3379,7 @@ static void macb_set_rx_mode(struct net_device *netdev)
 static int macb_open(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_context *ctx;
 	int err;
 
 	netdev_dbg(bp->netdev, "open\n");
@@ -3350,30 +3388,18 @@ static int macb_open(struct net_device *netdev)
 	if (err < 0)
 		return err;
 
-	WRITE_ONCE(bp->ctx, kzalloc_obj(*bp->ctx));
-	wmb(); /* ensure IRQ enabled at quiesce end read the new context */
-	if (!bp->ctx) {
-		err = -ENOMEM;
+	ctx = macb_context_alloc(bp, netdev->mtu,
+				 bp->configured_rx_ring_size,
+				 bp->configured_tx_ring_size);
+	if (IS_ERR(ctx)) {
+		err = PTR_ERR(ctx);
+		bp->ctx = NULL;
 		goto pm_exit;
 	}
 
-	bp->ctx->info = &bp->info;
+	WRITE_ONCE(bp->ctx, ctx);
+	wmb(); /* ensure IRQ enabled at quiesce end read the new context */
 
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
-	err = bp->macbgem_ops.mog_init_rings(bp->ctx);
-	if (err)
-		goto free_rings;
 	macb_init_buffers(bp);
 
 	macb_quiesce_end(bp);
@@ -3407,9 +3433,7 @@ static int macb_open(struct net_device *netdev)
 	macb_quiesce_start(bp);
 
 	macb_reset_hw(bp);
-free_rings:
 	macb_free(bp->ctx);
-free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 pm_exit:

-- 
2.55.0

