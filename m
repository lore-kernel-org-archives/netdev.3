Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E036D353A9E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784906980; cv=none; b=DSCwJCclH+GqBofx+/HEV6TvWNZKQRVwWmml2U4I0qnMrCTBswXbzC7NWk/27ESQ67nAZrHLRpsTBfFBGh0Ci+R1xC1S7GMvb/QfBSH1YqiY4XFQI4mgC5gmdOruSz45CbWeWo34xiPol4qHgZ/2oOtCNZqel12i4Eiv7yWFkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784906980; c=relaxed/simple;
	bh=Wi36SgcEF4jXZY5zwy4bZL6IaCbc/oQ68Ak4tr51lzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Amwt/sfsl5+WlH5r4ltEqqBliv46bO097LXl/M0K7m2UlvdN+i5aRo7UHgdfdM0zBi7Wfoqs3GfQ6b57UWy2ws+vonr0CrP8Qxcwl7Fv5vzOJ06YP8K4+xfBKRI30b9oYBy1kjii35LfgCcBbrp+VRSY0VhZVpUS5PGTuSGkOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N0eRfqqM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N0eRfqqM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 309E61A11EF;
	Fri, 24 Jul 2026 15:29:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 043EC60395;
	Fri, 24 Jul 2026 15:29:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A855511C1276C;
	Fri, 24 Jul 2026 17:29:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784906974; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8uzWzN7zqZDpVjQrk89Z/GfipZT+FPIRSZOhy6RR3yI=;
	b=N0eRfqqMSkCrcQJAQSHY4zdwiVJpV+ig6Sy3qDm/GA3owCnCGHbDKYlpZJYOVN5jvq1ACy
	JzzUdEx2DFDLInLiHnyhBP3o5wV7Qfhc/Zxj+Icl3dCyo2uDb+YWMddVsaQTW6pN+UN3KY
	0P+3K15IWYuRcZN5bJ8N4pnf/LEAutKjuhYgWHNsribdAc+8XJsijn/0NrfOfC5JnB6FPe
	2/yPT+PmscQ+Au4aM15QkJyoLBkDVtGfaVWXDQ8yBSCS9cZn+q30WzK8vc7wkXqTAWRobf
	XLsDFdfcVZHPf+xOemruaKi2AABxCiWTqB8U/kK5m4lFBEusD/nouINWyoSSfA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 24 Jul 2026 17:29:24 +0200
Subject: [PATCH net-next v5 01/15] net: macb: drop "consistent" from
 alloc/free function names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260724-macb-context-v5-1-569b1852bc7f@bootlin.com>
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

