Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057A7390C85
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 05:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786338888; cv=none; b=sirkFWkExlbkbbZ7Ni4oGuI1p9wXDBvMVt6UmIpqGM3tDWi+fZv43qlGHYvX5lM71YYI8sh3CFV8LPYrFpuRqxsl62vWlhLVoRiFeVYifAl6HfZiK7imv6a5jDVTrsQB713Q6COBdBg/IhePvY4lyCPyhatlRC8R4Lx8s2/gAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786338888; c=relaxed/simple;
	bh=jJaMJNzMhDKkt0JswZCaIaXR/rbdKw8r9GxP7YmHBiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tf5+qGuGnPqszKfKE+IsgeardZsvs+NURfqbSUszyDUm/5bRBV6DtIzVaEdOiJaiJc4F3HrYccLM1j4wyOe7SVGdjHdoLu+a13TbA7D1p1UApQly25t4ywgMRJ2osN10Vc6gZNYmC3O2ckb2tDzvrVCi/4sqxMJw7wZPzIw6V00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y61HytJ5; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y61HytJ5"
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-5bfa99f8ef8so2769750e0c.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786338886; x=1786943686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGGwtOpBFQz4UGYQNtNpa64SPL5ZnliS6IWLB+wzeH4=;
        b=BOjvfihxgqFiEQxq7ASEjyttei8h6cCzpybad3VerCRWKsDFv3CqsJX0ZAoj3SkDuV
         aitTfvidT5QoZSVGRtCkXVrmHNM8z369xI0CM0huW+XsbncQQe0aIFqLIUTxs5/2Ciu+
         iVGEtoF3w+KZGZjD/VRQi5F16vdIXTUV6o+xKIWKWQIHVIgPh5k+avEcTZxdrfT4yXz8
         J0JYco3PJPm3SFYs+ZhXEjAV9CqeDyuoTeFjvlqfzh4oln90MDvINGc/TgyjCK8OHq6I
         mJBKKjCuSURyu6EmrPGqgtE56nv80jCXU9kGIAmTGLGuSCC9uG5EsStaV9X+/90Cw9Wq
         BpMQ==
X-Gm-Message-State: AOJu0YwzP7HaJwUbKV9mI5IuSwYpaxc/jxGVVr/2GXvK5D/IWWfJ/bTh
	85afAyY9xrWqzSMDsIOH/YMSm3Z8LLboxd/fu7YDBPpW7U5hap3+S0Yf9elLi+vc9Mh5PsjW8if
	xrWF+VroaQ7I6IMskOCLP4hYQKd9jeZOtiUJQ36kH0rxsdNRg8WVIychOEHP4SzcXb9e5vAnawa
	Cj7v+EGu0/404/Fyapu33vs2hsh5ThJxzT1jksIZKmypT5y8uKh6TR4zrsn8+GeOJ+5mDnnUS8U
	o/NLaA9oMs=
X-Gm-Gg: AR+sD11nEiN5krlHvg8fHGnG1SylEj+RrJeXWlshGlAQrUBdwMJUyG6KILO2YEXdTcf
	ffIkLjZqx/SJY9Nb3ZwXvdUCbgIoglphD9AKVOHOm4lta25qT4aBaSspIT97uPLlj50oMs4AdjU
	/LsGrZEx5xRAtnN1yIbIUaS5XSLuIeKfcLPDT9Yf3uB28Pc/AA/jouw9gVXuLlF0vpybBEtDi9d
	nlO6sZ+u7ZZul1xilV30D3lvpq8X7vqIKraIvIVe6h5GRX/TogsCx2zTMBmtn+iHvareWu5Rvjk
	5LzA3+7NE8TpB+NCY6Kiy7N6Ur7wFbblWVY2/E9QGsXnGYzK/05K8Z5miwLGNy+5QAy+WnSi26K
	7YvZ4gk8Z+mJPSfRIISXgBAL6qElxUWnZE7ZS6i2YYNJE63XRRdrxkfohj9oYwhJXzYxF1GuQVG
	5ngX2zSPmmw/OqzWm+Yp8FJw2zUvZrumnP23U=
X-Received: by 2002:a05:6122:5102:b0:5c4:1e3:5eb2 with SMTP id 71dfb90a1353d-5c41543034emr1346806e0c.10.1786338885783;
        Sun, 09 Aug 2026 22:14:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5c40ae639d4sm1897982e0c.1.2026.08.09.22.14.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Aug 2026 22:14:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0408254aso42577381cf.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786338884; x=1786943684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGGwtOpBFQz4UGYQNtNpa64SPL5ZnliS6IWLB+wzeH4=;
        b=Y61HytJ5EceSoIRXbDJE7BArgSsZlVlw6HPAzeYy1xSfdVsSX7OUgup1sApWbVSJCh
         YpAJy/+N0UXzGyRRdEgYQIhb6dz9YBGazzJG5ZP3DAl31TsKFuTkSnPHr1TR43ivNYiL
         mrsVTZQNzZ1pLxPsni2WYH0isErLxOEg0KAVA=
X-Received: by 2002:a05:622a:44e:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52d237a7086mr154484411cf.13.1786338884039;
        Sun, 09 Aug 2026 22:14:44 -0700 (PDT)
X-Received: by 2002:a05:622a:44e:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52d237a7086mr154484131cf.13.1786338883492;
        Sun, 09 Aug 2026 22:14:43 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d165f2c76sm64862701cf.24.2026.08.09.22.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 22:14:42 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v6 02/15] bnxt_en: Account for the MPC TX and CP rings
Date: Sun,  9 Aug 2026 22:13:45 -0700
Message-ID: <20260810051358.1244418-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810051358.1244418-1-michael.chan@broadcom.com>
References: <20260810051358.1244418-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Modify bnxt_cp_rings_in_use(), bnxt_get_max_func_cp_rings_for_en(),
and _bnxt_get_max_rings() to account for any TX rings and CP rings
used by MPCs.  Add a new helper bnxt_total_tx_rings() to include
MPC TX rings.  Ring reservations will now include the MPC rings.

Note that for bnxt_check_rings() that is called before we commit
the new rings requested by the user running ethtool -L, the next
patch will calculate the proposed MPC rings to be checked.

Note that only the newer FW APIs and the newer P5-plus chips
support MPC rings.  The MPC values will always be zero in the
non-P5 plus code paths.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
https://lore.kernel.org/netdev/20260710042400.3996847-3-michael.chan@broadcom.com/

Clarify in the commit log that kTLS, MPC rings are only supported on
P5_PLUS chips in response to some Sashiko comments.
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 65 +++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 21 ++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 12 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 +-
 7 files changed, 90 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index ae3b8b1b8228..6debe20aec51 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7762,6 +7762,11 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	}
 }
 
+int bnxt_total_tx_rings(struct bnxt *bp)
+{
+	return bp->tx_nr_rings + bnxt_mpc_tx_rings_in_use(bp);
+}
+
 static int __bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 			     bool shared);
 static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
@@ -7802,19 +7807,28 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		stats = le16_to_cpu(resp->alloc_stat_ctx);
 		hw_resc->resv_irqs = cp;
 		if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+			int mpc_tx = bnxt_mpc_tx_rings_in_use(bp);
+			int mpc_cp = bnxt_mpc_cp_rings_in_use(bp);
 			int rx = hw_resc->resv_rx_rings;
 			int tx = hw_resc->resv_tx_rings;
+			int cp_p5;
 
+			if (tx <= mpc_tx || cp <= mpc_cp) {
+				rc = -ENOMEM;
+				goto get_rings_exit;
+			}
+			tx -= mpc_tx;
+			cp_p5 = cp - mpc_cp;
 			if (bp->flags & BNXT_FLAG_AGG_RINGS)
 				rx >>= 1;
-			if (cp < (rx + tx)) {
-				rc = __bnxt_trim_rings(bp, &rx, &tx, cp, false);
+			if (cp_p5 < (rx + tx)) {
+				rc = __bnxt_trim_rings(bp, &rx, &tx, cp_p5, false);
 				if (rc)
 					goto get_rings_exit;
 				if (bp->flags & BNXT_FLAG_AGG_RINGS)
 					rx <<= 1;
 				hw_resc->resv_rx_rings = rx;
-				hw_resc->resv_tx_rings = tx;
+				hw_resc->resv_tx_rings = tx + mpc_tx;
 			}
 			hw_resc->resv_irqs = le16_to_cpu(resp->alloc_msix);
 			hw_resc->resv_hw_ring_grps = rx;
@@ -8006,7 +8020,7 @@ static int bnxt_cp_rings_in_use(struct bnxt *bp)
 		return bnxt_nq_rings_in_use(bp);
 
 	cp = bp->tx_nr_rings + bp->rx_nr_rings;
-	return cp;
+	return cp + bnxt_mpc_cp_rings_in_use(bp);
 }
 
 static int bnxt_get_func_stat_ctxs(struct bnxt *bp)
@@ -8064,7 +8078,7 @@ static void bnxt_get_total_resources(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 	hwr->cp_p5 = 0;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		hwr->cp_p5 = bnxt_cp_rings_in_use(bp);
-	hwr->tx = bp->tx_nr_rings;
+	hwr->tx = bnxt_total_tx_rings(bp);
 	hwr->rx = bp->rx_nr_rings;
 	hwr->grp = hwr->rx;
 	hwr->vnic = bnxt_get_total_vnics(bp, hwr->rx);
@@ -8170,8 +8184,10 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	hwr.rx = bp->rx_nr_rings;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 		sh = true;
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.rx + hwr.tx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.rx + hwr.tx + bnxt_mpc_cp_rings_in_use(bp);
+		hwr.tx += bnxt_mpc_tx_rings_in_use(bp);
+	}
 
 	hwr.vnic = bnxt_get_total_vnics(bp, hwr.rx);
 
@@ -8208,6 +8224,9 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 	if (bnxt_ulp_registered(edev) && hwr.stat > bnxt_get_ulp_stat_ctxs(bp))
 		hwr.stat -= bnxt_get_ulp_stat_ctxs(bp);
 	hwr.cp = min_t(int, hwr.cp, hwr.stat);
+	hwr.tx -= bnxt_mpc_tx_rings_in_use(bp);
+	if (hwr.tx < 0)
+		return -ENOMEM;
 	rc = bnxt_trim_rings(bp, &rx_rings, &hwr.tx, hwr.cp, sh);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		hwr.rx = rx_rings << 1;
@@ -11538,14 +11557,15 @@ unsigned int bnxt_get_max_func_cp_rings(struct bnxt *bp)
 	return bp->hw_resc.max_cp_rings;
 }
 
-static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp)
+static unsigned int bnxt_get_max_func_cp_rings_for_en(struct bnxt *bp,
+						      unsigned int mpc_cp)
 {
 	unsigned int cp = bp->hw_resc.max_cp_rings;
 
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		cp -= bnxt_get_ulp_msix_num(bp);
 
-	return cp;
+	return mpc_cp >= cp ? 0 : cp - mpc_cp;
 }
 
 static unsigned int bnxt_get_max_func_irqs(struct bnxt *bp)
@@ -11567,7 +11587,7 @@ unsigned int bnxt_get_avail_cp_rings_for_en(struct bnxt *bp)
 {
 	unsigned int cp;
 
-	cp = bnxt_get_max_func_cp_rings_for_en(bp);
+	cp = bnxt_get_max_func_cp_rings_for_en(bp, bnxt_mpc_cp_rings_in_use(bp));
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		return cp - bp->rx_nr_rings - bp->tx_nr_rings;
 	else
@@ -14907,11 +14927,11 @@ static void bnxt_sp_task(struct work_struct *work)
 }
 
 static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
-				int *max_cp);
+				int *max_cp, int mpc_tx, int mpc_cp);
 
 /* Under netdev instance lock */
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
-		     int tx_xdp)
+		     int tx_xdp, int mpc_tx, int mpc_cp)
 {
 	int max_rx, max_tx, max_cp, tx_sets = 1, tx_cp;
 	struct bnxt_hw_rings hwr = {0};
@@ -14921,7 +14941,7 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 	if (tcs)
 		tx_sets = tcs;
 
-	_bnxt_get_max_rings(bp, &max_rx, &max_tx, &max_cp);
+	_bnxt_get_max_rings(bp, &max_rx, &max_tx, &max_cp, mpc_tx, mpc_cp);
 
 	if (max_rx < rx_rings)
 		return -ENOMEM;
@@ -14947,8 +14967,10 @@ int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
 		hwr.grp = rx;
 		hwr.rss_ctx = bnxt_get_total_rss_ctxs(bp, &hwr);
 	}
-	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
-		hwr.cp_p5 = hwr.tx + rx;
+	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
+		hwr.cp_p5 = hwr.tx + rx + mpc_cp;
+		hwr.tx += mpc_tx;
+	}
 	rc = bnxt_hwrm_check_rings(bp, &hwr);
 	if (!rc && pci_msix_can_alloc_dyn(bp->pdev)) {
 		if (!bnxt_ulp_registered(bp->edev[BNXT_AUXDEV_RDMA])) {
@@ -15669,7 +15691,9 @@ int bnxt_setup_mq_tc(struct net_device *dev, u8 tc)
 		sh = true;
 
 	rc = bnxt_check_rings(bp, bp->tx_nr_rings_per_tc, bp->rx_nr_rings,
-			      sh, tc, bp->tx_nr_rings_xdp);
+			      sh, tc, bp->tx_nr_rings_xdp,
+			      bnxt_mpc_tx_rings_in_use(bp),
+			      bnxt_mpc_cp_rings_in_use(bp));
 	if (rc)
 		return rc;
 
@@ -16644,14 +16668,14 @@ static int bnxt_get_max_irq(struct pci_dev *pdev)
 }
 
 static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
-				int *max_cp)
+				int *max_cp, int mpc_tx, int mpc_cp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
 	int max_ring_grps = 0, max_irq;
 
-	*max_tx = hw_resc->max_tx_rings;
+	*max_tx = max(0, (int)hw_resc->max_tx_rings - mpc_tx);
 	*max_rx = hw_resc->max_rx_rings;
-	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp);
+	*max_cp = bnxt_get_max_func_cp_rings_for_en(bp, mpc_cp);
 	max_irq = min_t(int, bnxt_get_max_func_irqs(bp) -
 			bnxt_get_ulp_msix_num_in_use(bp),
 			hw_resc->max_stat_ctxs -
@@ -16683,7 +16707,8 @@ int bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx, bool shared)
 {
 	int rx, tx, cp;
 
-	_bnxt_get_max_rings(bp, &rx, &tx, &cp);
+	_bnxt_get_max_rings(bp, &rx, &tx, &cp, bnxt_mpc_tx_rings_in_use(bp),
+			    bnxt_mpc_cp_rings_in_use(bp));
 	*max_rx = rx;
 	*max_tx = tx;
 	if (!rx || !tx || !cp)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f204e2a6b769..779162f6893c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2993,6 +2993,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			 unsigned int start_rx_ring_idx,
 			 unsigned int nr_rings);
+int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
@@ -3041,7 +3042,7 @@ int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 void bnxt_fw_exception(struct bnxt *bp);
 void bnxt_fw_reset(struct bnxt *bp);
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
-		     int tx_xdp);
+		     int tx_xdp, int mpc_tx, int mpc_cp);
 int bnxt_fw_init_one(struct bnxt *bp);
 bool bnxt_hwrm_reset_permitted(struct bnxt *bp);
 void bnxt_set_cp_rings(struct bnxt *bp, bool sh);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 62bc9cae613c..88d879a27820 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -37,6 +37,7 @@
 #include "bnxt_nvm_defs.h"	/* NVRAM content constant and structure defs */
 #include "bnxt_fw_hdr.h"	/* Firmware hdr constant and structure defs */
 #include "bnxt_coredump.h"
+#include "bnxt_mpc.h"
 
 #define BNXT_NVM_ERR_MSG(dev, extack, msg)			\
 	do {							\
@@ -959,6 +960,7 @@ static int bnxt_set_channels(struct net_device *dev,
 	struct bnxt *bp = netdev_priv(dev);
 	int req_tx_rings, req_rx_rings, tcs;
 	u32 new_tbl_size = 0, old_tbl_size;
+	int mpc_per_type = 0, mpc_cp = 0;
 	bool sh = false;
 	int tx_xdp = 0;
 	int rc = 0;
@@ -993,7 +995,8 @@ static int bnxt_set_channels(struct net_device *dev,
 		tx_xdp = req_rx_rings;
 	}
 
-	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp);
+	rc = bnxt_check_rings(bp, req_tx_rings, req_rx_rings, sh, tcs, tx_xdp,
+			      mpc_per_type * BNXT_MPC_TYPE_MAX, mpc_cp);
 	if (rc) {
 		netdev_warn(dev, "Unable to allocate the requested rings\n");
 		return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 86087e538550..9859a5f86268 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -24,3 +24,24 @@ void bnxt_free_mpc_info(struct bnxt *bp)
 	kfree(bp->mpc_info);
 	bp->mpc_info = NULL;
 }
+
+int bnxt_mpc_tx_rings_in_use(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, mpc_tx = 0;
+
+	if (!mpc)
+		return 0;
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
+		mpc_tx += mpc->mpc_ring_count[i];
+	return mpc_tx;
+}
+
+int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+
+	if (!mpc)
+		return 0;
+	return mpc->mpc_cp_rings;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index cd3f268a3a29..7a7d81197ea6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -35,6 +35,8 @@ struct bnxt_mpc_info {
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
+int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
+int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -43,5 +45,15 @@ static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 static inline void bnxt_free_mpc_info(struct bnxt *bp)
 {
 }
+
+static inline int bnxt_mpc_tx_rings_in_use(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index edcc002e4ca3..d57059722f5b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -640,7 +640,7 @@ static int bnxt_hwrm_func_vf_resc_cfg(struct bnxt *bp, int num_vfs, bool reset)
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings * 2;
 	else
 		vf_rx_rings = hw_resc->max_rx_rings - bp->rx_nr_rings;
-	vf_tx_rings = hw_resc->max_tx_rings - bp->tx_nr_rings;
+	vf_tx_rings = hw_resc->max_tx_rings - bnxt_total_tx_rings(bp);
 	vf_vnics = hw_resc->max_vnics - bp->nr_vnics;
 	vf_rss = hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs;
 
@@ -903,8 +903,8 @@ static int bnxt_sriov_enable(struct bnxt *bp, int *num_vfs)
 		    avail_cp < min_rx_rings)
 			rx_ok = 0;
 
-		if (hw_resc->max_tx_rings - bp->tx_nr_rings >= min_tx_rings &&
-		    avail_cp >= min_tx_rings)
+		if (hw_resc->max_tx_rings - bnxt_total_tx_rings(bp) >=
+		    min_tx_rings && avail_cp >= min_tx_rings)
 			tx_ok = 1;
 
 		if (hw_resc->max_rsscos_ctxs - bp->rsscos_nr_ctxs >=
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 9e5009be8e98..b485e4d9b26f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -19,6 +19,7 @@
 #include <net/page_pool/helpers.h>
 #include <linux/bnxt/hsi.h>
 #include "bnxt.h"
+#include "bnxt_mpc.h"
 #include "bnxt_xdp.h"
 
 DEFINE_STATIC_KEY_FALSE(bnxt_xdp_locking_key);
@@ -410,7 +411,8 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 	if (!tc)
 		tc = 1;
 	rc = bnxt_check_rings(bp, bp->tx_nr_rings_per_tc, bp->rx_nr_rings,
-			      true, tc, tx_xdp);
+			      true, tc, tx_xdp, bnxt_mpc_tx_rings_in_use(bp),
+			      bnxt_mpc_cp_rings_in_use(bp));
 	if (rc) {
 		netdev_warn(dev, "Unable to reserve enough TX rings to support XDP.\n");
 		return rc;
-- 
2.51.0

