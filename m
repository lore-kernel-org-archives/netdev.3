Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E447D51C342
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897439; cv=none; b=e3M2fWW6T5yD3wgbgmrqkcmrMCumXHki7HwoPH66uPtS7/uczF63fu3ZXkdVHmfhFQSSAP7g/swn8U8k5y+xzscOrojGfi89jPYixlLj2KlHVu+nznQvxuilbBPQXAW3Ajpk8/niE8sEOLbD2gdeVyCTxErEVOCyZwmzeL2xvAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897439; c=relaxed/simple;
	bh=+YZEIk0EbtyHlICXf7JLMUVu7SPBbckvnXzRUtr0TE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEtqnb5cdoiaIJLUxs5F1oKB++LlR/M1zfPly77CJoZktfabQOZRaGZUB+nrrp24wQ441JmjyESkdpYHPqjW72JoSkZ/7J/FbsJYNUZNMMdEOsJbweqEnigeV72kNFAedD0AdY81QbrcGD9oO4x18S4z+iZjIIoLPsU8llbsY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2BOzd28W; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2BOzd28W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 839ED1A120C;
	Tue, 13 Oct 2026 13:17:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4D9BA60362;
	Tue, 13 Oct 2026 13:17:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 11D9411D713F0;
	Tue, 13 Oct 2026 15:17:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791897434; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ES0lyYnAh1pTn/DSjdwSwb9kDIHum/0NIRuRqz04+pU=;
	b=2BOzd28WI9e6NHqwz5yzTAX7BtJ6otM4Y9AtH9VXD0ISbnts1T47XbQ36E0Fk9AcSacJiY
	DnV3wUJO8/lI26gBw7DmZrjd1cOxIMZZvfNXZI3fT/QJC/wGA8qb+Cj5xu8tj+5ppnntBr
	DlmCtbTqF9zvb78UhsyhI9J/nL2pSQWdAmnXuiSXn5Mxq9CmRp06RjZWhV/ciwPSamqdkQ
	j4G/hRG9/kINirYpYze5u7Vl4obTaA3yZCbip4MQtTYIc4vsICFkHfXDneu8CBuyDwNSJS
	AkmH8wY5bok2UBoQgcAFVfQeqYNJY61hDD2xxNT9nVX6D4cBnNXg74epj80XJg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Tue, 13 Oct 2026 15:16:45 +0200
Subject: [PATCH net-next v11 7/9] net: macb: introduce macb_context_alloc()
 helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-macb-context-v11-7-b27785167566@bootlin.com>
References: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
In-Reply-To: <20261013-macb-context-v11-0-b27785167566@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
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
index 05169bbe2efc..32a24c91c045 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -3006,6 +3006,43 @@ static int macb_alloc(struct macb_context *ctx)
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
@@ -3376,6 +3413,7 @@ static void macb_set_rx_mode(struct net_device *netdev)
 static int macb_open(struct net_device *netdev)
 {
 	struct macb *bp = netdev_priv(netdev);
+	struct macb_context *ctx;
 	int err;
 
 	netdev_dbg(bp->netdev, "open\n");
@@ -3384,30 +3422,18 @@ static int macb_open(struct net_device *netdev)
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
@@ -3441,9 +3467,7 @@ static int macb_open(struct net_device *netdev)
 	macb_quiesce_start(bp);
 
 	macb_reset_hw(bp);
-free_rings:
 	macb_free(bp->ctx);
-free_ctx:
 	kfree(bp->ctx);
 	bp->ctx = NULL;
 pm_exit:

-- 
2.56.0

