Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0853ACA7C;
	Wed, 12 Aug 2026 08:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521807; cv=none; b=hZ+CPg1kupnhoq70drDpDEA7Iy0UxRWo4/5DXXGqFmNak6x7laRpv3GEYTWnDSk1R12xvMnC5IdsjowkotkNzJ0K3n/kJsYKu2rFyISVZclilKODyJBFWIdc7d9TWgXax20KfdeLMFoUrc5h5PMG2wwd4jhtZXNi03Gc90Oz1Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521807; c=relaxed/simple;
	bh=Wi36SgcEF4jXZY5zwy4bZL6IaCbc/oQ68Ak4tr51lzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXBaOZBj+nPX9ymXpIzE7cRgxGhqC0CQz4UNdcxwOfcvVV323qXQ+ANbHYQybv+83nwMwh663eh/7DkaAe1IY8Kd/MlspXMEzbu3nC/BxwA6bpBHa5pn4vXU7TRWBi4C/IXiXWit4j4kdnEcgtBkrJthAuhaNZmOBjeBcaRo+bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=V0LrjI+d; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="V0LrjI+d"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4225B1A15AF;
	Wed, 12 Aug 2026 08:03:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 152306045E;
	Wed, 12 Aug 2026 08:03:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54A7A11C4C92B;
	Wed, 12 Aug 2026 10:03:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786521803; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=8uzWzN7zqZDpVjQrk89Z/GfipZT+FPIRSZOhy6RR3yI=;
	b=V0LrjI+dIY/aQJVS7lDwNnzJHIQqzErOBg4MCt2q6E9r4ux/TrjZKt4wkR5LcdjztKWMU6
	o5SmICvBrrDggDFoi2+Jj1jBav86VWbRKMJ9YRdCrPVAHkf5jWgjU1C2ZNVo1TCIImJQ8C
	Z60BIP3Oi9UJl7N+XWA4yB8maYIGbUETiauXrGv8TPygLX4wmiI1zzObIVYGd0ZsT4+qL7
	9smqMLoOW4cu3C6f/WyEjBnjxAgTWTRTC/4zMDCehZ2gB7GGNxaL/JSyW36SBU5TbItxp7
	VJnv+Xw8gu/1BPjO1sjwcD6atx9dSh4geZOQUCkVtU0pqKfNIH6SD3BwT5/Gxg==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Wed, 12 Aug 2026 10:03:15 +0200
Subject: [PATCH net-next v9 01/17] net: macb: drop "consistent" from
 alloc/free function names
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260812-macb-context-v9-1-7ddbf5f715e0@bootlin.com>
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

