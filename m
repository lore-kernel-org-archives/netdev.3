Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B501D3B0585
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786649571; cv=none; b=SgERgZz6HGHBopG3NgPv/R09KWtOiFF72ixgpcdeKjJfmZoWAEE1yFZk8L9cJ80N4X5R6ORoj1dZruJHnNCSy0ScX4aYC21AaXB9L3E/a+iAInKmLPI6Isl3qGlX8HBrn4iWSdVq85uE5RMfURvuui1xCmrN/rw+NiILzcs35Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786649571; c=relaxed/simple;
	bh=xQaYHLFeqc1DCM++stFirzGYQuzETG1PtDFRtURS1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y8esX2+ck9MWGZIgTxxzQU3+crZg4YZ36w1+IrxJYQ/ZMJBGWD45BoTJQHPnUfcOEXdxGZzoMs71v05CcubntfO/u9qMzNqcj/nBDi/WRpM6jBlP4oM9g/W3fTIgc5Vmu8RziKXtdvoo5srsQW6dOXQqyRNbirCaEyhgLV32EuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j45SC0iY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j45SC0iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F1A1F00A3D;
	Thu, 13 Aug 2026 19:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786649570;
	bh=WCC1wSKwKdnkxU6fdOR4O1TNbGcu/XiJcVC0o0s0Km0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j45SC0iY+5D6bAr5FoO6ygrKSD1X3aJLx/Gt0jPrVGDjkO/sAsYGQK3ksNPRbO0ee
	 MP+oGniDq6ncZy2jbKgA3CgUDFKXq2aajLaTqhRQaloBjZVx5WJNIlLbMgLYMV9CQO
	 zZ3XRCphGSdCFK4n2y7bPwOkX3htejG7zeyj9ztrIMwPfRYy0j8+KVEXYe33ecUqHx
	 4m7J9VkdbF8I0kXGEkpiWdA5GapxZEYzgbiAuuQnoITfM6BV7YkvxelMKlf95LYjeR
	 uygaHnIjd3eGXsAF6ReYXDkozD72R5TlqR8Dn87uv4fpjNAnQWdUVcGLdsXcL2Zzyp
	 IsyxV07LtBmyA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/2] eth: bnxt: decrease indent in bnxt_init_int_mode()
Date: Thu, 13 Aug 2026 12:32:47 -0700
Message-ID: <20260813193248.2578626-2-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813193248.2578626-1-kuba@kernel.org>
References: <20260813193248.2578626-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the IRQ table allocation failure right away instead of
wrapping the rest of the function in an if. Purely to make
upcoming changes more readable.

While refactoring, drop the init of rc which is not necessary.

No functional changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 36 +++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1e4944f3e606..d3531cd283a5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11592,7 +11592,7 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
-	int i, total_vecs, max, rc = 0, min = 1, ulp_msix, tx_cp, tbl_size;
+	int i, total_vecs, max, rc, min = 1, ulp_msix, tx_cp, tbl_size;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -11617,26 +11617,26 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 	if (pci_msix_can_alloc_dyn(bp->pdev))
 		tbl_size = max;
 	bp->irq_tbl = kzalloc_objs(*bp->irq_tbl, tbl_size);
-	if (bp->irq_tbl) {
-		for (i = 0; i < total_vecs; i++)
-			bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
-
-		bp->total_irqs = total_vecs;
-		/* Trim rings based upon num of vectors allocated */
-		rc = bnxt_trim_rings(bp, &bp->rx_nr_rings, &bp->tx_nr_rings,
-				     total_vecs - ulp_msix, min == 1);
-		if (rc)
-			goto msix_setup_exit;
-
-		tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
-		bp->cp_nr_rings = (min == 1) ?
-				  max_t(int, tx_cp, bp->rx_nr_rings) :
-				  tx_cp + bp->rx_nr_rings;
-
-	} else {
+	if (!bp->irq_tbl) {
 		rc = -ENOMEM;
 		goto msix_setup_exit;
 	}
+
+	for (i = 0; i < total_vecs; i++)
+		bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
+
+	bp->total_irqs = total_vecs;
+	/* Trim rings based upon num of vectors allocated */
+	rc = bnxt_trim_rings(bp, &bp->rx_nr_rings, &bp->tx_nr_rings,
+			     total_vecs - ulp_msix, min == 1);
+	if (rc)
+		goto msix_setup_exit;
+
+	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
+	bp->cp_nr_rings = (min == 1) ?
+			  max_t(int, tx_cp, bp->rx_nr_rings) :
+			  tx_cp + bp->rx_nr_rings;
+
 	return 0;
 
 msix_setup_exit:
-- 
2.55.0

