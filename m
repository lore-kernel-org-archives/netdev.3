Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A153B7779
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133127; cv=none; b=AxHeUySwXV0k0noZA36WHQsQWGq6B3DPvtrHmbbFE5AWa58hGUrU0ajF6MDzfb1xXF/mVo6F6l9m+mBsX7yqD8311gifeY0yLU+iqGUVLKLb9v1N3yjKxLLCaIgh8vwQ4ah5PX3fjdV2RpVTz0lQvQAu2rUHJMIBh+aXa+bJCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133127; c=relaxed/simple;
	bh=qbm8j6YCU9twWmVFDfnzepkuO3CWKjx0G+qEJ+Zzz3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkHsXeLkHNhfVD/GCvwZoytHxGhaceV7MFTo06GGCgaLJtZaZcFrNbrlFQSaJNNMrjqWPlSajbihOoYRhGQkchWwChmLrtHYdai8c1Drhtk1lC58jjp6CqUaMJT4FsUHd93Egn61vok92Oz3HJy11zV8xgZRigkOmB6vx/FAr9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QG2U/ko0; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QG2U/ko0"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso1497028a12.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792133123; x=1792737923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RmS0dSNKWV9MlZwHy4Q7DGhYpQRfUP80fsBfvbZpXSc=;
        b=XeQaINMyW+Q3ClshYR03dq4qfoJq+Y4zFsw4LT4b/jKSc7egm+9Ra6Zh0nwRsfykeK
         uYDC58J6PABaoFeo4mV5ILK4Sqmi1BeCepdnZSCDpDAOsAoGEvljTMXz15B7aoMB/DaA
         RxtyrMI3SyNHC3dkzp+szR9CTfzwsUZaZsTwxnZbRd/+WZoHHKLkDTiorXWc6DmU2mo2
         P3zrbxu/1c78Im4p8qjH/w4DCBAu4J3sczbVR2ZQQ/y1wDTBi34U76myL8Vom55erMLe
         FZg0d1yyxVHUwJRSAfy+lrcfhFmM/Je+/goyesUz91dXezPwyqesXXIeDJ7TJcol1ucs
         DS8A==
X-Gm-Message-State: AFq9FYKLxRlcz1DK3NaIGi2lh2Xhr3lxSH/dIA1wDRADdx7aEDrR2KXf
	KeNvw08K1exU8H8tAjX38txwo5CYVbB7Cb3o5BzGGsdKd0vGRfbVrRuD8RWrJbXpB1Nmtu4Nfl/
	P4weoFhQrDR+zF6R+xIuBFKKBmzkdrkxcsMVpXE3OZbj8MUK9eFq4WONyZWAOT/zR4b4gdc8NjR
	ujFxa6VH9tB3s45ez9RXqmW/L19wZy4Z4BmZ7yMmcNWwgLTb5frXY05X5dRHg89YBSGK1r6EdhA
	cvyoCoGzC4=
X-Gm-Gg: AYBFou2n5ZLoOdLcmwiAegtZUK0K2Qumui9uFOuJVLLcYjIMbZsvE4DEZ82DWcw81y3
	PK8ORCsS2Hs9lSOq1EKUuF1A8UpmmlxoUUU40UbgmMQh9UEkJTNFVdPrG1PZTHqDlJaVp57TEtR
	hjn3Dm4URWwCRApzKy9SDxKDFE5Uhlw1Ody/8PThH4JhT7I9O+vgRaj0S9UqA9zN7k2D3stiqwb
	l59Z2wsjKtuR1YCdluypnYZbcJwgIgw1B35btVdgSIGnd022uwZQggMhKIFHSEDusCk+vUKxlOt
	eF2ip7fwT8g3Ku7O9kCuXJvTz3ZOUTQsqvEm+T6UxsDEDzEFQCPgdPKYkI0jbJVh6wDYpqGJnJ8
	LTrBsTB+gF4+IZZDTavyHw2RR990lAkKYYFnop2moBlJfG8cNJc0oAQGTq8RaJHDFZJ06Wa79wP
	TxwE1yHfcXnVwhEExWI/QgO6ngYvth2f6OS2h6XQ==
X-Received: by 2002:a17:90b:3c0d:b0:3ab:b39f:41c8 with SMTP id 98e67ed59e1d1-3abb39f448fmr16028714a91.46.1792133123136;
        Thu, 15 Oct 2026 23:45:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3acbee7ae31sm1267217a91.7.2026.10.15.23.45.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2026 23:45:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1383723dfddso5475504c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792133121; x=1792737921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RmS0dSNKWV9MlZwHy4Q7DGhYpQRfUP80fsBfvbZpXSc=;
        b=QG2U/ko049uzOJSwCBZXTIcLP0Q10T8tqUfcuMz1fXY9z1YDU6RdgqYes+sTN8TD4Q
         w4KxntGc4dj39DTGHYqw/ygsKAryxhX82QDxw3W4MkwPSPBxvrfzsdWCXUzlRrkMge1Z
         MkYjedG/tmhYEj9FYguxo7inKBTa4+CzRKQNk=
X-Received: by 2002:a05:701b:230c:b0:136:c443:80e5 with SMTP id a92af1059eb24-16a586a31b5mr26684658c88.6.1792133120873;
        Thu, 15 Oct 2026 23:45:20 -0700 (PDT)
X-Received: by 2002:a05:701b:230c:b0:136:c443:80e5 with SMTP id a92af1059eb24-16a586a31b5mr26684617c88.6.1792133120100;
        Thu, 15 Oct 2026 23:45:20 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1830f213ba7sm3791401c88.0.2026.10.15.23.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:45:19 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v4 8/8] bnxt_en: Fix ring accounting and validation when rings are constrained
Date: Thu, 15 Oct 2026 23:44:27 -0700
Message-ID: <20261016064427.496944-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261016064427.496944-1-michael.chan@broadcom.com>
References: <20261016064427.496944-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When __bnxt_reserve_rings() reserves fewer TX rings than requested,
and an XDP program is attached, the driver used to blindly subtract
bp->tx_nr_rings_xdp from bp->tx_nr_rings, potentially causing an integer
underflow.

This patch mainly fixes the existing bnxt_adj_tx_rings(),
bnxt_rings_ok(), and some ring helpers:

1. bnxt_adj_tx_rings() is now renamed bnxt_adj_rings() to reflect that
all rings (tx, rx, cp) may adjust if needed.  It will now correctly
scale down TX rings for XDP and TCs evenly.  Because XDP requires
a 1:1 TX/RX ring mapping in combined channel mode, it will now clamp
the RX rings to match.  CP rings will also be reduced if necessary.
Any leftover rings after integer division are intentionally left unused.

2. bnxt_rings_ok() is now updated to robustly check for the absolute
minimum viable ring configuration to support the TC and XDP settings.
We now call bnxt_rings_ok() first before calling bnxt_adj_rings() to
guarantee no math underflow or ring truncation to 0.

3. bnxt_num_cp_to_tx()/bnxt_num_tx_to_cp() helpers are used while
trimming the rings with possible ring shortages.  These helpers now
use the passed in tx_xdp (now as boolean) and rx parameters to
accurately scale and clamp the XDP rings.

With these 3 main changes, we can now centralize bnxt_adj_rings() in
__bnxt_reserve_rings() and bnxt_init_int_mode() and delete other
adjustments and checks in other functions.  Note that in
__bnxt_reserve_rings(), we only need to call bnxt_adj_rings() if
irq_re_init is true which means that bp->bnapi has not been allocated.
In this context, we may be asking for more rings than FW can grant
and we need to call bnxt_adj_rings() for possible adjustments.  We
need to be careful when aborting __bnxt_reserve_rings() and
bnxt_init_int_mode() to restore the possibly truncated rings if
necessary so that the driver state is consistent.

We now remove the error path at the end of bnxt_reserve_rings() to abort
and reset the TCs if the rings cannot satisfy the TC requirements.  The
user will have to reduce the TCs and retry.

There are other related changes to reset the RSS table if needed and
to recalculate the IRQs required if the rings have shrunk.  Note that
the latter can only be done if the NAPIs have not been allocated yet.

As noted in the cover letter, we have similar existing issues regarding
RSS tables for non-default RSS contexts and user defined n-tuple
filters when RX rings shrink due to FW or MSI-X constraints.  The fixes
for these are deferred to a separate patchset.

These existing issues were detected by Sashiko when reviewing the
new kTLS patchset (patch #3 of 15):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com

Fixes: 1ee581c24dfd ("bnxt_en: Adjust TX rings if reservation is less than requested")
Fixes: 674f50a5b026 ("bnxt_en: Implement new method to reserve rings.")
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v4:
Fix bnxt_num_cp_to_tx()/bnxt_num_tx_to_cp() helpers to fix the
ring trimming issue reported by Sashiko.

v3:
No longer have to deal with dropped NITRO A0
Fix the dynamic IRQ code path in bnxt_reserve_rings().
Use the proper __bnxt_num_tx_to_cp() in bnxt_rings_ok().

https://lore.kernel.org/netdev/20261012220827.340998-8-michael.chan@broadcom.com/

v2:
Reduce RX and CP rings if needed when TX rings are reduced to keep it
consistent.
Handle NITRO_A0 special RX requirements to keep it consistent.
Fix all unwind issues in these code paths.

https://lore.kernel.org/netdev/20260928041712.3467803-7-michael.chan@broadcom.com/

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-2-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 196 +++++++++++++++-------
 1 file changed, 139 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5949fc72aaa5..e43cf29386a3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8069,8 +8069,25 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 
 static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
-	return hwr->tx && hwr->rx && hwr->cp && hwr->grp && hwr->vnic &&
-	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
+	int min_tx = bp->num_tc ? bp->num_tc : 1;
+	int min_tx_xdp = 0;
+	int min_rx = 1;
+	int min_cp;
+	int tx_cp;
+
+	if (bp->tx_nr_rings_xdp) {
+		min_tx++;
+		min_tx_xdp = 1;
+	}
+
+	tx_cp = bnxt_num_tx_to_cp(bp, min_tx, min_tx_xdp, min_rx);
+	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
+		min_cp = max(tx_cp, min_rx);
+	else
+		min_cp = tx_cp + min_rx;
+	return hwr->tx >= min_tx && hwr->rx >= min_rx && hwr->cp >= min_cp &&
+	       hwr->grp && hwr->vnic && hwr->stat &&
+	       (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
 /* Check to see if we need to reset the user configured RSS table
@@ -8088,10 +8105,13 @@ static void bnxt_check_rss_tbl_lost(struct bnxt *bp, int old_rx, int new_rx)
 }
 
 static int bnxt_get_avail_msix(struct bnxt *bp, int num);
+static void bnxt_adj_rings(struct bnxt *bp);
 
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+	int req_rx_rings = bp->rx_nr_rings;
+	int req_tx_rings = bp->tx_nr_rings;
 	struct bnxt_hw_rings hwr = {0};
 	int rx_rings, old_rx_rings, rc;
 	int cp = bp->cp_nr_rings;
@@ -8159,49 +8179,68 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
+	if (rc)
+		goto reserve_rings_exit;
+
+	if (bp->bnapi && (rx_rings < bp->rx_nr_rings ||
+			  hwr.tx < bp->tx_nr_rings)) {
+		netdev_err(bp->dev, "Unexpected ring shrinkage %d/%d RX/TX to %d/%d\n",
+			   bp->rx_nr_rings, bp->tx_nr_rings, rx_rings, hwr.tx);
+		rc = -ENOSPC;
+		goto reserve_rings_exit;
+	}
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
 	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx, bp->tx_nr_rings_xdp, rx_rings);
 	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
-	if (hwr.tx != bp->tx_nr_rings) {
-		netdev_warn(bp->dev,
-			    "Able to reserve only %d out of %d requested TX rings\n",
-			    hwr.tx, bp->tx_nr_rings);
+
+	if (!bnxt_rings_ok(bp, &hwr)) {
+		rc = -ENOMEM;
+		goto reserve_rings_exit;
 	}
+
 	bp->tx_nr_rings = hwr.tx;
+	bp->rx_nr_rings = rx_rings;
+	bp->cp_nr_rings = hwr.cp;
 
+	if (!bp->bnapi)
+		bnxt_adj_rings(bp);
+
+	if (req_tx_rings != bp->tx_nr_rings) {
+		netdev_warn(bp->dev,
+			    "Able to reserve only %d out of %d requested TX rings\n",
+			    bp->tx_nr_rings, req_tx_rings);
+	}
 	/* If we cannot reserve all the RX rings, reset the RSS map only
 	 * if absolutely necessary
 	 */
-	if (rx_rings != bp->rx_nr_rings) {
+	if (req_rx_rings != bp->rx_nr_rings) {
 		netdev_warn(bp->dev, "Able to reserve only %d out of %d requested RX rings\n",
-			    rx_rings, bp->rx_nr_rings);
-		bnxt_check_rss_tbl_lost(bp, bp->rx_nr_rings, rx_rings);
+			    bp->rx_nr_rings, req_rx_rings);
+		bnxt_check_rss_tbl_lost(bp, req_rx_rings, bp->rx_nr_rings);
 	}
-	bp->rx_nr_rings = rx_rings;
-	bp->cp_nr_rings = hwr.cp;
 
 	/* Fall back if we cannot reserve enough HW RSS contexts */
 	if ((bp->rss_cap & BNXT_RSS_CAP_LARGE_RSS_CTX) &&
 	    hwr.rss_ctx < bnxt_get_total_rss_ctxs(bp, &hwr))
 		bp->rss_cap &= ~BNXT_RSS_CAP_LARGE_RSS_CTX;
 
-	if (!bnxt_rings_ok(bp, &hwr))
-		return -ENOMEM;
-
-	if (old_rx_rings != bp->hw_resc.resv_rx_rings &&
+	if ((old_rx_rings != bp->hw_resc.resv_rx_rings ||
+	     req_rx_rings != bp->rx_nr_rings) &&
 	    !netif_is_rxfh_configured(bp->dev))
 		bnxt_set_dflt_rss_indir_tbl(bp, NULL);
 
+reserve_rings_exit:
 	if (!bnxt_ulp_registered(edev) && BNXT_NEW_RM(bp)) {
 		int resv_msix, resv_ctx, ulp_ctxs;
 		struct bnxt_hw_resc *hw_resc;
 
 		hw_resc = &bp->hw_resc;
-		resv_msix = hw_resc->resv_irqs - bp->cp_nr_rings;
+		resv_msix = max_t(int, hw_resc->resv_irqs - bp->cp_nr_rings, 0);
 		ulp_msix = min_t(int, resv_msix, ulp_msix);
 		bnxt_set_ulp_msix_num(bp, ulp_msix);
-		resv_ctx = hw_resc->resv_stat_ctxs  - bp->cp_nr_rings;
+		resv_ctx = max_t(int, hw_resc->resv_stat_ctxs - bp->cp_nr_rings,
+				 0);
 		ulp_ctxs = min(resv_ctx, bnxt_get_ulp_stat_ctxs(bp));
 		bnxt_set_ulp_stat_ctxs(bp, ulp_ctxs);
 	}
@@ -11298,6 +11337,10 @@ int bnxt_num_tx_to_cp(struct bnxt *bp, int tx, int tx_xdp, int rx)
 {
 	int tcs = bp->num_tc ? bp->num_tc : 1;
 
+	if (tx_xdp) {
+		tx_xdp = tx / (tcs + 1);
+		tx_xdp = min(tx_xdp, rx);
+	}
 	return __bnxt_num_tx_to_cp(bp, tx, tcs, tx_xdp);
 }
 
@@ -11305,7 +11348,13 @@ static int bnxt_num_cp_to_tx(struct bnxt *bp, int tx_cp, int tx_xdp, int rx)
 {
 	int tcs = bp->num_tc ? bp->num_tc : 1;
 
-	return (tx_cp - tx_xdp) * tcs + tx_xdp;
+	if (tx_xdp) {
+		int cp_per_tc = tx_cp / 2;
+
+		cp_per_tc = min(cp_per_tc, rx);
+		return cp_per_tc * (tcs + 1);
+	}
+	return tx_cp * tcs;
 }
 
 static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
@@ -11493,7 +11542,9 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
-	int i, total_vecs, max, rc, min = 1, ulp_msix, tx_cp, tbl_size;
+	int i, total_vecs, max, rc, min = 1, ulp_msix, tbl_size, req_rx_rings;
+	int min_tx, req_tx_rings, req_cp_rings, req_tx_per_tc, req_tx_xdp;
+	int tcs = bp->num_tc ? bp->num_tc : 1;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -11528,20 +11579,50 @@ static int bnxt_init_int_mode(struct bnxt *bp)
 		bp->irq_tbl[i].vector = pci_irq_vector(bp->pdev, i);
 
 	bp->total_irqs = total_vecs;
+	req_tx_rings = bp->tx_nr_rings;
+	req_tx_per_tc = bp->tx_nr_rings_per_tc;
+	req_tx_xdp = bp->tx_nr_rings_xdp;
+	req_rx_rings = bp->rx_nr_rings;
+	req_cp_rings = bp->cp_nr_rings;
+
 	/* Trim rings based upon num of vectors allocated */
 	rc = bnxt_trim_rings(bp, &bp->rx_nr_rings, &bp->tx_nr_rings,
 			     total_vecs - ulp_msix, min == 1);
 	if (rc)
 		goto msix_setup_exit;
 
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings, bp->tx_nr_rings_xdp,
-				  bp->rx_nr_rings);
-	bp->cp_nr_rings = (min == 1) ?
-			  max_t(int, tx_cp, bp->rx_nr_rings) :
-			  tx_cp + bp->rx_nr_rings;
+	min_tx = bp->tx_nr_rings_xdp ? tcs + 1 : tcs;
+	if (bp->tx_nr_rings < min_tx) {
+		netdev_err(bp->dev, "Not enough MSI-X to satisfy min. TX rings\n");
+		rc = -ENOMEM;
+		goto msix_setup_exit_restore;
+	}
+
+	bnxt_adj_rings(bp);
+
+	if (bp->bnapi && (req_tx_rings != bp->tx_nr_rings ||
+			  req_rx_rings != bp->rx_nr_rings)) {
+		netdev_err(bp->dev, "Cannot shrink rings once NAPI is allocated\n");
+		rc = -ENOSPC;
+		goto msix_setup_exit_restore;
+	}
 
+	if (req_rx_rings != bp->rx_nr_rings) {
+		netdev_warn(bp->dev, "RX rings reduced from %d to %d\n",
+			    req_rx_rings, bp->rx_nr_rings);
+		bnxt_check_rss_tbl_lost(bp, req_rx_rings, bp->rx_nr_rings);
+		if (!netif_is_rxfh_configured(bp->dev))
+			bnxt_set_dflt_rss_indir_tbl(bp, NULL);
+	}
 	return 0;
 
+msix_setup_exit_restore:
+	bp->tx_nr_rings = req_tx_rings;
+	bp->tx_nr_rings_per_tc = req_tx_per_tc;
+	bp->tx_nr_rings_xdp = req_tx_xdp;
+	bp->rx_nr_rings = req_rx_rings;
+	bp->cp_nr_rings = req_cp_rings;
+
 msix_setup_exit:
 	netdev_err(bp->dev, "bnxt_init_int_mode err: %x\n", rc);
 	kfree(bp->irq_tbl);
@@ -11579,8 +11660,6 @@ static int bnxt_irqs_required(struct bnxt *bp)
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
 	bool irq_cleared = false;
-	bool irq_change = false;
-	int tcs = bp->num_tc;
 	int irqs_required;
 	int rc;
 
@@ -11590,7 +11669,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	irqs_required = bnxt_irqs_required(bp);
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
-		irq_change = true;
 		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
 			bnxt_ulp_irq_stop(bp);
 			bnxt_clear_int_mode(bp);
@@ -11602,25 +11680,23 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 		if (!rc)
 			rc = bnxt_init_int_mode(bp);
 		bnxt_ulp_irq_restart(bp, rc);
-	} else if (irq_change && !rc) {
-		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
-			rc = -ENOSPC;
+	} else if (irq_re_init && BNXT_NEW_RM(bp) && !rc) {
+		/* __bnxt_reserve_rings() may have shrunk the rings */
+		irqs_required = bnxt_irqs_required(bp);
+		if (irqs_required != bp->total_irqs) {
+			/* Don't bother reducing static IRQs to avoid disrupting
+			 * RoCE.
+			 */
+			if (pci_msix_can_alloc_dyn(bp->pdev) &&
+			    bnxt_change_msix(bp, irqs_required) !=
+			    irqs_required)
+				rc = -ENOSPC;
+		}
 	}
 	if (rc) {
 		netdev_err(bp->dev, "ring reservation/IRQ init failure rc: %d\n", rc);
 		return rc;
 	}
-	if (tcs && (bp->tx_nr_rings_per_tc * tcs !=
-		    bp->tx_nr_rings - bp->tx_nr_rings_xdp)) {
-		netdev_err(bp->dev, "tx ring reservation failure\n");
-		netdev_reset_tc(bp->dev);
-		bp->num_tc = 0;
-		if (bp->tx_nr_rings_xdp)
-			bp->tx_nr_rings_per_tc = bp->tx_nr_rings_xdp;
-		else
-			bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
-		return -ENOMEM;
-	}
 	return 0;
 }
 
@@ -13118,13 +13194,29 @@ static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
 	bp->tx_nr_rings += bp->tx_nr_rings_xdp;
 }
 
-static void bnxt_adj_tx_rings(struct bnxt *bp)
+static void bnxt_adj_rings(struct bnxt *bp)
 {
-	/* Make adjustments if reserved TX rings are less than requested */
-	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
-	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
-	if (bp->tx_nr_rings_xdp)
-		bnxt_set_xdp_tx_rings(bp);
+	int tcs = bp->num_tc ? bp->num_tc : 1;
+	int rx = bp->rx_nr_rings;
+
+	/* Make adjustments to rings based on TC/XDP/shared rings policies */
+	if (bp->tx_nr_rings_xdp) {
+		tcs++;
+		bp->tx_nr_rings_per_tc = bp->tx_nr_rings / tcs;
+		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+	} else {
+		bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	}
+
+	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
+		bp->tx_nr_rings_per_tc = min(bp->tx_nr_rings_per_tc, rx);
+		bp->rx_nr_rings = bp->tx_nr_rings_per_tc;
+		if (bp->tx_nr_rings_xdp)
+			bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+	}
+
+	bp->tx_nr_rings = bp->tx_nr_rings_per_tc * tcs;
+	bnxt_set_cp_rings(bp, bp->flags & BNXT_FLAG_SHARED_RINGS);
 }
 
 static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
@@ -13144,7 +13236,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
-	bnxt_adj_tx_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16807,7 +16898,6 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
 
-	bnxt_adj_tx_rings(bp);
 	if (sh)
 		bnxt_adj_dflt_rings(bp, true);
 
@@ -16816,7 +16906,6 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		rc = __bnxt_reserve_rings(bp);
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
-		bnxt_adj_tx_rings(bp);
 	}
 	if (rc) {
 		bp->tx_nr_rings = 0;
@@ -16846,8 +16935,6 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	if (rc)
 		goto init_dflt_ring_err;
 
-	bnxt_adj_tx_rings(bp);
-
 	bnxt_set_dflt_rfs(bp);
 
 init_dflt_ring_err:
@@ -17241,11 +17328,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto init_err_pci_clean;
 
-	/* No TC has been set yet and rings may have been trimmed due to
-	 * limited MSIX, so we re-initialize the TX rings per TC.
-	 */
-	bp->tx_nr_rings_per_tc = bp->tx_nr_rings;
-
 	if (BNXT_PF(bp)) {
 		if (!bnxt_pf_wq) {
 			bnxt_pf_wq =
-- 
2.51.0

