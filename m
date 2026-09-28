Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6371335838E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790569204; cv=none; b=jkk0aLmIiD/puP+WKtrsDf6kqeoWeLEwlmnAa03GJ1CHG4IBhtRSyKM4qto0L3N/CMnLfLu6LbPYiD5Q2ZVEeiHJobu5Ex7PRZG6815/aqw6mqx5hMPudUe4ez+B0FnyQCKnjwAVquMeyasqPKzHBK7wTRaj+UVNwVSypSPgp4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790569204; c=relaxed/simple;
	bh=srM1IN3DahiRHJ52ABuFuK92+01dWlOVy1M7VRB72t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgsOoZkfZxyoc6F5+BeiEwJ011MwkgrMpqDUyhuxsBpRVP+D6P0cjHlLZHHZgk2uIaQaAIdejVXkycH49kQkOqlF9cDMG7PTpagUfum6BF4zt2v+U5uLpicMZui/WPSBzfF2Twlakx13g/Cnsvq1FzHzypkpYU/O3Sx8pg4VKRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PZOKQmjT; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PZOKQmjT"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-8a8712949afso6133867b3.3
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790569201; x=1791174001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zUQe7A0ocqTGKeNHt9Rqym4g+5XMSeSlzWnDHOGt1PY=;
        b=UXab0EvvQlW/OQPL3lXGhFcwzbtCb/IGbdjdmvCJibIMXlq3g2hu3a6p5YEznKgjV0
         CYP7dj3JUBeidNL7De37g1AnFedBVQ0Fvdq0ouiI9NRP97AuWhjyq+8cS9EG0LciTG+P
         Hzbdj/dq9kmSnsehg2uJ1J0r/4oOuirsZNqFktS3UYXSFrcYzFnVJlZYE3StZ3ZCoPX4
         G5p/piFMmP9jOh/S1KlcHLwjFrLkmEV2DnuC67JJUf7HF2g7yPv5xJNnKGoHA0tWnqIY
         bQgLKnW8bDfNBgC7+mYjWIQfMe0spFtWswEone37C59SD11XVXWEpEPvYwBDa97csmyv
         1SDw==
X-Gm-Message-State: AFq9FYKxYOh9De+3lCSQCgLzkllScwmVJc6w3phbt/uZiYmHAfH/Z2iL
	8i466m/DH/ouA+XQ1HCTVZoQinmfCTFxNtQIzTjILiClZI7RTBgwT1qTuTs++2LAZbsbfAWC10Z
	9SQhhZhiVqUwtNj+qOGOL4+tGbBab5evMqusqiWVW2vkxIJf5Rve/As1V2VEFoSj1CyzGDWMuDU
	io+YPoIXP1A3nCZ02TYx54omNIpt9vVO8nMMPQBK4eR2C/Tw6FZ7Ne+Op//pCKVVQvOwUQg7fWe
	WxWPEF1su0=
X-Gm-Gg: AYBFou1z0do1IKU5VFYdRRdLAU57IZlUmXhK0J9jGBJITZhEGN6RbeuLXZ+gFrMhYKV
	2yE6S7SgYJeN7RIvvJsrizr/SVLrDRjL2Fs2AqU2xV9HHs9ZBDSmPEqhCxHFNbbLV33HlySYdSz
	fZyzL9M2vuck9pUmPcK6LRniWSK2yPDbcVo1ZJIoYbszsNOtMx/I4z9MnvRpCmJDo8iHnnuky3i
	ojK4VqafdKXrmJ2/J4DMnATSAtZP1lPf2e884q834uZhpw4oAcohDuPgH3Io2DN0DIZlrJ+iH1u
	e6CEseb5ZBFvSBt6lejxn7bNYUl5q3yAg8sCjWA8jzAU0Ezm1+bX9rCqLgMFZ9sqC3Fc+ozgnMG
	nJ94XB3fOTbEkHewcSqcWtX2ZOaTMLpMBeU52cR0tcZSxzr7H7VANWx4a2L1OCDQgOOkRptmkgj
	rI8aUR2VOlYC225co89Y7IhTnRxin3fA/2KYiq7A==
X-Received: by 2002:a53:ac8d:0:b0:672:99e1:11d6 with SMTP id 956f58d0204a3-672ed4ae2f8mr4536657d50.115.1790569201180;
        Sun, 27 Sep 2026 21:20:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-8a860f5d2d2sm615977b3.15.2026.09.27.21.20.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 21:20:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-14318be7d79so2789549c88.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 21:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790569200; x=1791174000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zUQe7A0ocqTGKeNHt9Rqym4g+5XMSeSlzWnDHOGt1PY=;
        b=PZOKQmjTlGvYhF+QMi4RCNTxPbkvlZE00cIftvD7QKWI/RFWyPE+MdD+tsahQnSMrt
         S/KhlcuVbU1HzfzfU6ol0SexUdcmM8E2Wi5BYfBT52YYUF86TPmJIzg0XqFyEi1ZAr55
         bNbqmknpFItNZRWcUKEljprpzSQki9/+oxWwo=
X-Received: by 2002:a05:701b:2506:b0:141:4c37:a20a with SMTP id a92af1059eb24-146cdeb8d0fmr7824902c88.9.1790569199644;
        Sun, 27 Sep 2026 21:19:59 -0700 (PDT)
X-Received: by 2002:a05:701b:2506:b0:141:4c37:a20a with SMTP id a92af1059eb24-146cdeb8d0fmr7824864c88.9.1790569198878;
        Sun, 27 Sep 2026 21:19:58 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm14393222c88.9.2026.09.27.21.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:19:58 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	joe@dama.to
Subject: [PATCH net v2 6/9] bnxt_en: Fix ring accounting and validation when rings are constrained
Date: Sun, 27 Sep 2026 21:17:09 -0700
Message-ID: <20260928041712.3467803-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928041712.3467803-1-michael.chan@broadcom.com>
References: <20260928041712.3467803-1-michael.chan@broadcom.com>
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

This patch mainly fixes the existing bnxt_adj_tx_rings() and
bnxt_rings_ok():

1. bnxt_adj_tx_rings() is now renamed bnxt_adj_rings() to reflect that
all rings (tx, rx, cp) may adjust if needed.  It will now correctly
scale down TX rings for XDP and TCs evenly.  Because XDP requires
a 1:1 TX/RX ring mapping in combined channel mode, it will now clamp
the RX rings to match.  CP rings will also be reduced if necessary.
Any leftover rings after integer division are intentionally left unused.

2. bnxt_rings_ok() is now updated to robustly check for the absolute
minimum viable ring configuration.  We now call bnxt_rings_ok() to
make sure we have the bare minimum before calling the new
bnxt_adj_rings().  This now guarantees that bnxt_adj_rings() will
never underflow or truncate any rings to 0.

The special NITRO_A0 minimum requirement is handled by a new helper
in bnxt_init_int_mode() only.  This old chip does not require ring
reservations (bnxt_need_reserve_rings() returns false on this chip).

With these 2 main changes, we can now centralize bnxt_adj_rings() in
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
v2:
Reduce RX and CP rings if needed when TX rings are reduced to keep it
consistent.
Handle NITRO_A0 special RX requirements to keep it consistent.
Fix all unwind issues in these code paths.

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-2-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 177 +++++++++++++++-------
 1 file changed, 126 insertions(+), 51 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bf902da945cb..8e4bde720ef5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8163,10 +8163,30 @@ static void bnxt_copy_reserved_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	}
 }
 
+static bool bnxt_nitro_a0_rings_ok(struct bnxt *bp, int rx)
+{
+	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && rx < 2)
+		return false;
+	return true;
+}
+
 static bool bnxt_rings_ok(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
-	return hwr->tx && hwr->rx && hwr->cp && hwr->grp && hwr->vnic &&
-	       hwr->stat && (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
+	int min_tx = bp->num_tc ? bp->num_tc : 1;
+	int min_rx = 1;
+	int min_cp = 1;
+	int tx_cp;
+
+	if (bp->tx_nr_rings_xdp)
+		min_tx++;
+
+	if (!(bp->flags & BNXT_FLAG_SHARED_RINGS)) {
+		tx_cp = bnxt_num_tx_to_cp(bp, min_tx);
+		min_cp = tx_cp + min_rx;
+	}
+	return hwr->tx >= min_tx && hwr->rx >= min_rx && hwr->cp >= min_cp &&
+	       hwr->grp && hwr->vnic && hwr->stat &&
+	       (hwr->cp_p5 || !(bp->flags & BNXT_FLAG_CHIP_P5_PLUS));
 }
 
 /* Check to see if we need to reset the user configured RSS table
@@ -8184,10 +8204,12 @@ static void bnxt_check_rss_tbl_lost(struct bnxt *bp, int old_rx, int new_rx)
 }
 
 static int bnxt_get_avail_msix(struct bnxt *bp, int num);
+static void bnxt_adj_rings(struct bnxt *bp);
 
 static int __bnxt_reserve_rings(struct bnxt *bp)
 {
 	struct bnxt_en_dev *edev = bp->edev[BNXT_AUXDEV_RDMA];
+	int req_rx_rings = bp->rx_nr_rings;
 	struct bnxt_hw_rings hwr = {0};
 	int rx_rings, old_rx_rings, rc;
 	int cp = bp->cp_nr_rings;
@@ -8255,49 +8277,68 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
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
 	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
 	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
+
+	if (!bnxt_rings_ok(bp, &hwr)) {
+		rc = -ENOMEM;
+		goto reserve_rings_exit;
+	}
+
 	if (hwr.tx != bp->tx_nr_rings) {
 		netdev_warn(bp->dev,
 			    "Able to reserve only %d out of %d requested TX rings\n",
 			    hwr.tx, bp->tx_nr_rings);
 	}
 	bp->tx_nr_rings = hwr.tx;
+	bp->rx_nr_rings = rx_rings;
+	bp->cp_nr_rings = hwr.cp;
+
+	if (!bp->bnapi)
+		bnxt_adj_rings(bp);
 
 	/* If we cannot reserve all the RX rings, reset the RSS map only
 	 * if absolutely necessary
 	 */
-	if (rx_rings != bp->rx_nr_rings) {
-		netdev_warn(bp->dev, "Able to reserve only %d out of %d requested RX rings\n",
-			    rx_rings, bp->rx_nr_rings);
-		bnxt_check_rss_tbl_lost(bp, bp->rx_nr_rings, rx_rings);
+	if (req_rx_rings != bp->rx_nr_rings) {
+		netdev_warn(bp->dev, "RX rings reduced from %d to %d\n",
+			    req_rx_rings, bp->rx_nr_rings);
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
@@ -11645,7 +11686,9 @@ static int bnxt_get_num_msix(struct bnxt *bp)
 
 static int bnxt_init_int_mode(struct bnxt *bp)
 {
-	int i, total_vecs, max, rc, min = 1, ulp_msix, tx_cp, tbl_size;
+	int i, total_vecs, max, rc, min = 1, ulp_msix, tbl_size, req_rx_rings;
+	int min_tx, req_tx_rings, req_cp_rings, req_tx_per_tc, req_tx_xdp;
+	int tcs = bp->num_tc ? bp->num_tc : 1;
 
 	total_vecs = bnxt_get_num_msix(bp);
 	max = bnxt_get_max_func_irqs(bp);
@@ -11680,19 +11723,56 @@ static int bnxt_init_int_mode(struct bnxt *bp)
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
 
-	tx_cp = bnxt_num_tx_to_cp(bp, bp->tx_nr_rings);
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
 
+	if (!bnxt_nitro_a0_rings_ok(bp, bp->rx_nr_rings)) {
+		netdev_err(bp->dev, "Not enough MSI-X to satisfy min. RX rings\n");
+		rc = -ENOMEM;
+		goto msix_setup_exit_restore;
+	}
+
+	if (bp->bnapi && (req_tx_rings != bp->tx_nr_rings ||
+			  req_rx_rings != bp->rx_nr_rings)) {
+		netdev_err(bp->dev, "Cannot shrink rings once NAPI is allocated\n");
+		rc = -ENOSPC;
+		goto msix_setup_exit_restore;
+	}
+
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
@@ -11729,8 +11809,6 @@ static int bnxt_irqs_required(struct bnxt *bp)
 int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 {
 	bool irq_cleared = false;
-	bool irq_change = false;
-	int tcs = bp->num_tc;
 	int irqs_required;
 	int rc;
 
@@ -11740,7 +11818,6 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 	irqs_required = bnxt_irqs_required(bp);
 
 	if (irq_re_init && BNXT_NEW_RM(bp) && irqs_required != bp->total_irqs) {
-		irq_change = true;
 		if (!pci_msix_can_alloc_dyn(bp->pdev) || !bp->irq_tbl) {
 			bnxt_ulp_irq_stop(bp);
 			bnxt_clear_int_mode(bp);
@@ -11752,25 +11829,17 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
 		if (!rc)
 			rc = bnxt_init_int_mode(bp);
 		bnxt_ulp_irq_restart(bp, rc);
-	} else if (irq_change && !rc) {
-		if (bnxt_change_msix(bp, irqs_required) != irqs_required)
+	} else if (irq_re_init && BNXT_NEW_RM(bp) && !rc) {
+		/* __bnxt_reserve_rings() may have shrunk the rings */
+		irqs_required = bnxt_irqs_required(bp);
+		if (irqs_required != bp->total_irqs &&
+		    bnxt_change_msix(bp, irqs_required) != irqs_required)
 			rc = -ENOSPC;
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
 
@@ -13275,13 +13344,29 @@ static void bnxt_set_xdp_tx_rings(struct bnxt *bp)
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
@@ -13301,7 +13386,6 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
-	bnxt_adj_tx_rings(bp);
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
@@ -16967,7 +17051,6 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 	if (rc && rc != -ENODEV)
 		netdev_warn(bp->dev, "Unable to reserve tx rings\n");
 
-	bnxt_adj_tx_rings(bp);
 	if (sh)
 		bnxt_adj_dflt_rings(bp, true);
 
@@ -16976,7 +17059,6 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 		rc = __bnxt_reserve_rings(bp);
 		if (rc && rc != -ENODEV)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
-		bnxt_adj_tx_rings(bp);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bp->rx_nr_rings++;
@@ -17010,8 +17092,6 @@ static int bnxt_init_dflt_ring_mode(struct bnxt *bp)
 	if (rc)
 		goto init_dflt_ring_err;
 
-	bnxt_adj_tx_rings(bp);
-
 	bnxt_set_dflt_rfs(bp);
 
 init_dflt_ring_err:
@@ -17355,11 +17435,6 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
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

