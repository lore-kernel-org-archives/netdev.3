Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BA37F72C;
	Fri, 17 Jul 2026 19:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784317719; cv=none; b=lD4lFfbQwmnzIkLGTENsusyn7+e3HHf2+suSXRK8/h9XQSJXBE3SMwogXlLXzzC6pzpp/C3YfdlZKebdv2JHUrCxYEUxSZr3ElXxJyrBI1sEyu+1rAewVi00ZhyrZQuMGTu5FEqRT4hTY9YJj24OjC0wwKniAgoWo68CE1ixZFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784317719; c=relaxed/simple;
	bh=s3T1fIvc9DiqfMxc/n0FGp/KsRZwsLlfXMM+MmDaTpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I54rMssMy9G9I2eD529QzzehvbKSslwpyGnqZhS1u5zjoq7yUtSWKIAaty3atUq0esVCVN3hdRhPFRI4EtAAgYzxktdta9RWTPs0COFc26suCNsAQt9mkgWu/A4Co1wndpWqidJw21yNz3j9Bq5zOzjoVYoG/8JBO4fAorPKOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pazjP1DT; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pazjP1DT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 582041A1076;
	Fri, 17 Jul 2026 19:48:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C33B60361;
	Fri, 17 Jul 2026 19:48:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0C5611BD04D0;
	Fri, 17 Jul 2026 21:48:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784317714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=brhBr0slKnPLTVFWEU05KoEHw8i65rCNqbMW9BR5Iww=;
	b=pazjP1DTw0KNyYniF2Bwcs6SaZqFtgnF1ALH2GWYkn+FTQKVFe6MxJq2+Waz5aaX3R6aJR
	OH5EXGEKsR92rFMETUxTkWLxURxOaS3WhSsFF4vQ+nhrgMk7FS8MXN8goCcSbc0zDhYAzc
	QVfj56zGiwjHclRC1OGSpY7cxFP0slNRFfsFCsZtbu8TeG1UkNB48T/tgm+LKYhrCHXxmB
	1tFJFjFzNYvq4WXBNb0ppu+1UW4jnYmoEFaeUzplVwk5eAfTA5696VYfeT5rjE+dK9FHGG
	ov7pE/fQGeREXgPiPUDf0QUENJ9ht+Mz1rZw0JCa1r1lWVR42vrLunHepSWNZw==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 17 Jul 2026 21:48:09 +0200
Subject: [PATCH net-next v4 06/15] net: macb: allocate tieoff descriptor
 once across device lifetime
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260717-macb-context-v4-6-0acbe7f10cdb@bootlin.com>
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

The tieoff descriptor is a RX DMA descriptor ring of size one. It gets
configured onto queues for Wake-on-LAN during system-wide suspend when
hardware does not support disabling individual queues
(MACB_CAPS_QUEUE_DISABLE).

MACB/GEM driver allocates it alongside the main RX ring
inside macb_alloc() at open. Free is done by macb_free() at close.

Change to allocate once at probe and free on probe failure or device
removal. This makes the tieoff descriptor lifetime much longer,
avoiding repeating coherent buffer allocation on each open/close cycle.

Main benefit: we dissociate its lifetime from the main ring's lifetime.
That way there is less work to be doing on resources (re)alloc. This
currently happens on close/open, but will soon also happen on context
swap operations (set_ringparam, change_mtu, set_channels, etc).

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 75 +++++++++++++++++---------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 5dca1d0404a7..92022c144fa5 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2653,12 +2653,6 @@ static void macb_free(struct macb *bp)
 	unsigned int q;
 	size_t size;
 
-	if (bp->rx_ring_tieoff) {
-		dma_free_coherent(dev, macb_dma_desc_get_size(bp),
-				  bp->rx_ring_tieoff, bp->rx_ring_tieoff_dma);
-		bp->rx_ring_tieoff = NULL;
-	}
-
 	bp->macbgem_ops.mog_free_rx_buffers(bp);
 
 	size = bp->num_queues * macb_tx_ring_size_per_queue(bp);
@@ -2773,16 +2767,6 @@ static int macb_alloc(struct macb *bp)
 	if (bp->macbgem_ops.mog_alloc_rx_buffers(bp))
 		goto out_err;
 
-	/* Required for tie off descriptor for PM cases */
-	if (!(bp->caps & MACB_CAPS_QUEUE_DISABLE)) {
-		bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-							macb_dma_desc_get_size(bp),
-							&bp->rx_ring_tieoff_dma,
-							GFP_KERNEL);
-		if (!bp->rx_ring_tieoff)
-			goto out_err;
-	}
-
 	return 0;
 
 out_err:
@@ -2790,19 +2774,6 @@ static int macb_alloc(struct macb *bp)
 	return -ENOMEM;
 }
 
-static void macb_init_tieoff(struct macb *bp)
-{
-	struct macb_dma_desc *desc = bp->rx_ring_tieoff;
-
-	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
-		return;
-	/* Setup a wrapping descriptor with no free slots
-	 * (WRAP and USED) to tie off/disable unused RX queues.
-	 */
-	macb_set_addr(bp, desc, MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
-	desc->ctrl = 0;
-}
-
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
 	queue->rx_tail = 0;
@@ -2830,8 +2801,6 @@ static void gem_init_rings(struct macb *bp)
 
 		gem_init_rx_ring(queue);
 	}
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_init_rings(struct macb *bp)
@@ -2849,8 +2818,6 @@ static void macb_init_rings(struct macb *bp)
 	bp->queues[0].tx_head = 0;
 	bp->queues[0].tx_tail = 0;
 	desc->ctrl |= MACB_BIT(TX_WRAP);
-
-	macb_init_tieoff(bp);
 }
 
 static void macb_reset_hw(struct macb *bp)
@@ -5535,6 +5502,38 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
+static int macb_alloc_tieoff(struct macb *bp)
+{
+	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
+	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
+		return 0;
+
+	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
+						macb_dma_desc_get_size(bp),
+						&bp->rx_ring_tieoff_dma,
+						GFP_KERNEL);
+	if (!bp->rx_ring_tieoff)
+		return -ENOMEM;
+
+	macb_set_addr(bp, bp->rx_ring_tieoff,
+		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
+
+	bp->rx_ring_tieoff->ctrl = 0;
+
+	return 0;
+}
+
+static void macb_free_tieoff(struct macb *bp)
+{
+	if (!bp->rx_ring_tieoff)
+		return;
+
+	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
+			  bp->rx_ring_tieoff,
+			  bp->rx_ring_tieoff_dma);
+	bp->rx_ring_tieoff = NULL;
+}
+
 static const struct macb_usrio_config mpfs_usrio = {
 	.tsu_source = 0,
 };
@@ -5944,10 +5943,14 @@ static int macb_probe(struct platform_device *pdev)
 
 	netif_carrier_off(netdev);
 
+	err = macb_alloc_tieoff(bp);
+	if (err)
+		goto err_out_unregister_mdio;
+
 	err = register_netdev(netdev);
 	if (err) {
 		dev_err(&pdev->dev, "Cannot register net device, aborting.\n");
-		goto err_out_unregister_mdio;
+		goto err_out_free_tieoff;
 	}
 
 	INIT_WORK(&bp->hresp_err_bh_work, macb_hresp_error_task);
@@ -5961,6 +5964,9 @@ static int macb_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_out_free_tieoff:
+	macb_free_tieoff(bp);
+
 err_out_unregister_mdio:
 	mdiobus_unregister(bp->mii_bus);
 	mdiobus_free(bp->mii_bus);
@@ -5990,6 +5996,7 @@ static void macb_remove(struct platform_device *pdev)
 	if (netdev) {
 		bp = netdev_priv(netdev);
 		unregister_netdev(netdev);
+		macb_free_tieoff(bp);
 		phy_exit(bp->phy);
 		mdiobus_unregister(bp->mii_bus);
 		mdiobus_free(bp->mii_bus);

-- 
2.55.0

