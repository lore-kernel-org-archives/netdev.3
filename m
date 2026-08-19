Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6723D7DC;
	Wed, 19 Aug 2026 01:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787102051; cv=none; b=JVA+d62FEW8HlP6PL2h6KyvrDbEdynWo6pkUWT8ETEdooB6hMseI+DOTIKSY+eeTGFaIAOleW1RO2alqBO62UvsVhP4A9As85Z0ZEPEQXaHqcNkNZRSR8xBl0DoX1zsvcmT9gdu/z550Bxxy9nVvhVbo6tn2VNKZjT185JW5iGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787102051; c=relaxed/simple;
	bh=jp1TKt5HkSBQDBfj+AUOlzDnbBAHe1wv1ssp2C6mwo8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z6lZzuRuU3M+3YXi1ay7yMBMQwbAws9yW3Fk0aPRvdc79YOmRmEfxOd01TyKM/AD4IX9Fre8most+jg+bQBDFlWtnv9goOpnSxS6qpeXF6Y1fhBhSid2rWDV1gj0vOkbY947df4T9T7HFbh59FDtKjqr2Jsn7tul9/Tzmva2BC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+5s0sEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+5s0sEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981331F000E9;
	Wed, 19 Aug 2026 01:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787102049;
	bh=WVbMLZtfRxlzEzbYXa6hXjH0mAgLFy4X1ymXlPLvNwo=;
	h=From:Date:Subject:To:Cc;
	b=A+5s0sEjqtCnQmvYVR98KWmDOFEYoj9oL1jcHW1l85jj0JZoQ7v6g77HRQRMaEqqr
	 ZZ+8giYfIX9yIplVdS72C2D1PAzSpdhF3CGO5P9zGjZqlhcdAytj3T/M9+WWosx09+
	 72a6f8/tmHOw1UnDW6Pz4CccvsTWaP4A2l76vQVYyH9oU3OolSuDCVBc2Uubo8f/yl
	 U2kfvGypW0KKZfh5oAWvGLi5Gm3sGiZhaHgB2ry3ra0wCDzAZeHRK/g3O3E3GaCkE0
	 VAqy5c7CctSkwaZWCJgrEhfxRL0YidS58PmWCyFOvRvf3WREBtolJ+uZU6zh2QU55A
	 MuewhXLbiGhkg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Tue, 18 Aug 2026 18:14:01 -0700
Subject: [PATCH net] net: macb: Move macb_{alloc,free}_tieoff() out of
 CONFIG_OF block
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-macb-fix-no-of-build-v1-1-f2a009616384@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0Jm7SSlCyBcxbig018doq1pgZAQ7
 m7V5fv57x1UkBWFxuagjE2LplihvTQkjyneweorkzW2M0M78GsSx0F3jolTYLfq0zOA3kovwRp
 PVX1n1Msve6WIhW7/saxuhizfIJ3nB/dynad9AAAA
X-Change-ID: 20260818-macb-fix-no-of-build-eee72c7cf20d
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3647; i=nathan@kernel.org;
 h=from:subject:message-id; bh=jp1TKt5HkSBQDBfj+AUOlzDnbBAHe1wv1ssp2C6mwo8=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFmtzDE/T6/Qbd5/dOsUFbcbG7uZflxgflT5oaDzVH1D6
 MvpM5bv7ihlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATcUtgZGjbVvnh8Jtt/oda
 NKrCrW7+OLu0sO9K+j/9pzkFi4+oTY9n+KcoFrl+1a1KfmXmmZLPS1LnNW5yqo6b5s6cdmeb4dF
 zF/kA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit 5262eab9462a ("net: macb: allocate tieoff descriptor once across
device lifetime") moved macb_alloc_tieoff() and macb_free_tieoff() into
a CONFIG_OF block, breaking the build when it is disabled:

  drivers/net/ethernet/cadence/macb_main.c: In function 'macb_probe':
  drivers/net/ethernet/cadence/macb_main.c:5951:15: error: implicit declaration of function 'macb_alloc_tieoff' [-Wimplicit-function-declaration]
   5951 |         err = macb_alloc_tieoff(bp);
        |               ^~~~~~~~~~~~~~~~~
  drivers/net/ethernet/cadence/macb_main.c:5973:9: error: implicit declaration of function 'macb_free_tieoff' [-Wimplicit-function-declaration]
   5973 |         macb_free_tieoff(bp);
        |         ^~~~~~~~~~~~~~~~

Moving macb_alloc_tieoff() from its original positive does not appear to
be necessary, so move it and macb_free_tieoff() back out of the
CONFIG_OF block to clear up the error.

Fixes: 5262eab9462a ("net: macb: allocate tieoff descriptor once across device lifetime")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This does not apply to net currently but I assume net will be fast
forwarded when net-next-7.3 is merged.
---
 drivers/net/ethernet/cadence/macb_main.c | 64 ++++++++++++++++----------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 1476bce77f34..96a7e7777e62 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -2776,6 +2776,38 @@ static int macb_alloc(struct macb *bp)
 	return -ENOMEM;
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
 static void gem_init_rx_ring(struct macb_queue *queue)
 {
 	queue->rx_tail = 0;
@@ -5507,38 +5539,6 @@ static int eyeq5_init(struct platform_device *pdev)
 	return ret;
 }
 
-static int macb_alloc_tieoff(struct macb *bp)
-{
-	/* Tieoff is a workaround in case HW cannot disable queues, for PM. */
-	if (bp->caps & MACB_CAPS_QUEUE_DISABLE)
-		return 0;
-
-	bp->rx_ring_tieoff = dma_alloc_coherent(&bp->pdev->dev,
-						macb_dma_desc_get_size(bp),
-						&bp->rx_ring_tieoff_dma,
-						GFP_KERNEL);
-	if (!bp->rx_ring_tieoff)
-		return -ENOMEM;
-
-	macb_set_addr(bp, bp->rx_ring_tieoff,
-		      MACB_BIT(RX_WRAP) | MACB_BIT(RX_USED));
-
-	bp->rx_ring_tieoff->ctrl = 0;
-
-	return 0;
-}
-
-static void macb_free_tieoff(struct macb *bp)
-{
-	if (!bp->rx_ring_tieoff)
-		return;
-
-	dma_free_coherent(&bp->pdev->dev, macb_dma_desc_get_size(bp),
-			  bp->rx_ring_tieoff,
-			  bp->rx_ring_tieoff_dma);
-	bp->rx_ring_tieoff = NULL;
-}
-
 static const struct macb_usrio_config mpfs_usrio = {
 	.tsu_source = 0,
 };

---
base-commit: 61eb236c41c2a4717015dff18016a75a5eb90052
change-id: 20260818-macb-fix-no-of-build-eee72c7cf20d

Best regards,
--  
Cheers,
Nathan

