Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD382331A6E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785507; cv=none; b=QA1dT/wbgjqRJptCLblS5SbHVO4Lga0S92G/HzoaiOVUqRpyZmCJvNmMVj9T8cl+TabjVLwc0qYwm3dRY2zyS4NQ++3RpMCtw1wC8Y87RJ3IsFLAPO1wIhMC245KAsH5TIOkaF/Rvu2dvYt7gyEGxmxi3ut+XakGMCuSNyP8CRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785507; c=relaxed/simple;
	bh=N0TBYqKIw0RCV4ttZ19GggvPF6grKS5Jagdr4njC7ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=svRdO5pCIsgCNe4dhaicv7xk5wssbQJW1naQ7s7v3SYZgnc9jRMsTwOLhhrKeA1K50HUImQ5IN88spLdGnXSVKJiSQ9+WTEEO/xLIIf1gyFThme0mKJCOk6nAoWfyDyXPmmVFY/Oh7uQjBhBH+Z3PPg2KqgvL2ExY9V4voKNcTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejxvO6re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejxvO6re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED50D1F00A3F;
	Mon,  3 Aug 2026 19:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785506;
	bh=GzyXsLpFyAdS6UuT1Ae6Ln4FRa0pGPd+azy2HigZlCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ejxvO6rehPytb35QHLnw1330P97RYzKEDNnCedcxjtfLWCy0rHfdVNSXaI55kt+t5
	 brUijVAlWlMKdirrHiSdojbz2/RLVHu/2PDLyWHjR3hVvOYQ8yST10lfutzVv7tUO4
	 y3mhO0VqJBQaei8t/GCVNEoG73+hjdDClC3HS/79EqiX4KPUw8ewvgyJV0RgcuRR/G
	 i+kuHDUcjb3TVe1E90dRLK8Lx7/41tavJRK9MFRa5wwgCWGsQgAVb+TaD9sSh7e+oO
	 WfasOHpEy/1fHIWm5ufOfZPQmCuQsMMrT4YzUs5CA2FTrjaGuZlY9WFK9ryIFj0HKh
	 7+dVBIPawZq4A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	manoj.panicker2@amd.com,
	somnath.kotur@broadcom.com,
	andrew.gospodarek@broadcom.com,
	wei.huang2@amd.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 3/4] eth: bnxt: decrease indent in bnxt_request_irq()
Date: Mon,  3 Aug 2026 12:31:34 -0700
Message-ID: <20260803193135.2030368-4-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803193135.2030368-1-kuba@kernel.org>
References: <20260803193135.2030368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_request_irq() has unnecessary level of indentation.
Use continue instead. No need to re-fetch NUMA node for
each IRQ, move to the function level.

No functional changes.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 50 +++++++++++------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 47bea6d8ee3e..202a16170141 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11891,6 +11891,7 @@ static void bnxt_free_irq(struct bnxt *bp)
 
 static int bnxt_request_irq(struct bnxt *bp)
 {
+	const int numa_node = dev_to_node(&bp->pdev->dev);
 	struct cpu_rmap *rmap = NULL;
 	int i, j, rc = 0;
 	unsigned long flags = 0;
@@ -11913,6 +11914,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
+		u16 tag;
 
 		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
 		    rmap && bp->bnapi[i]->rx_ring) {
@@ -11931,33 +11933,31 @@ static int bnxt_request_irq(struct bnxt *bp)
 		netif_napi_set_irq_locked(&bp->bnapi[i]->napi, irq->vector);
 		irq->requested = 1;
 
-		if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
-			int numa_node = dev_to_node(&bp->pdev->dev);
-			u16 tag;
+		if (!zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL))
+			continue;
 
-			irq->have_cpumask = 1;
-			irq->msix_nr = map_idx;
-			irq->ring_nr = i;
-			cpumask_set_cpu(cpumask_local_spread(i, numa_node),
-					irq->cpu_mask);
-			rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
-			if (rc) {
-				netdev_warn(bp->dev,
-					    "Update affinity hint failed, IRQ = %d\n",
-					    irq->vector);
-				break;
-			}
-
-			bnxt_register_irq_notifier(bp, irq);
-
-			/* Init ST table entry */
-			if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
-						cpumask_first(irq->cpu_mask),
-						&tag))
-				continue;
-
-			pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
+		irq->have_cpumask = 1;
+		irq->msix_nr = map_idx;
+		irq->ring_nr = i;
+		cpumask_set_cpu(cpumask_local_spread(i, numa_node),
+				irq->cpu_mask);
+		rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
+		if (rc) {
+			netdev_warn(bp->dev,
+				    "Update affinity hint failed, IRQ = %d\n",
+				    irq->vector);
+			break;
 		}
+
+		bnxt_register_irq_notifier(bp, irq);
+
+		/* Init ST table entry */
+		if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
+					cpumask_first(irq->cpu_mask),
+					&tag))
+			continue;
+
+		pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
 	}
 	return rc;
 }
-- 
2.55.0

