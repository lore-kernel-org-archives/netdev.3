Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33644F4024
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842961; cv=none; b=KwMluCD2/b5KsPeN//maYEL70EEEwUKJuafvN82xjHxwW7xU+4zzwu676lb105loGwIDC46ozBZexfqmjR08daN8+MakR0p2LLTuv0Cm+EZAU6x5VVP+VUI6uQ9ak5DQy/FqA959pukveqHhNXofLGK5e9VzshLJEjx4lPfRxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842961; c=relaxed/simple;
	bh=Bmrg7/mUDODlm738twaPySKJLWFokdmaysF6E27VH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxXQv4rhf1j3HJuxIgfdtN6yExvB3WfcQFI61/2lqsOKYXKlEojI72/OV5tBvay/QgtZdpeMXBACKEM2KL0Jo7TTpysLmZ4topoQXL5sD1OWkP6RXfsWxjNOwnVdvdWiP8nRSgWwMuGg/aHk99j3CPj0jQgFHsfFYTvoEq9g55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GapLTD9y; arc=none smtp.client-ip=209.85.215.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GapLTD9y"
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cc4ca696de6so1202400a12.2
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842959; x=1792447759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l1k7SuWBXiEifsFWLKnVqGRtSzJCfCOW7iac83Km+o4=;
        b=kDEARuWeP+fwzRhECQq8VzxSf2PsVTRT+J41GJKcUO38lRMMHOavglONE/Xmrzw2nq
         JRszpTvemg7pxalMtUnZIcpyOxrzIvDbWyS6ehzzHb4uixdxzfsaVlfU6LqKgRgoJun9
         O4tZlbU1DQrrvbcwobkHgExgpPqw26Tj43wT8xkd4kVz90AiCR3pRoV3WZWUFgQZjX1k
         TJq+UHgrH2DBH6wIv+Mf4jEWmqjYoCAHfPo/BYYNVjHYspFoqeb58+SfAxFP8YvB+HHL
         mw9tuI88awzgs+6ETT9jozYXomf9BY+1YlJDm4wpuX5wwzvDOuSgv6HwcP0qagNNAMZU
         UQdw==
X-Gm-Message-State: AFq9FYL3OZImGwfgaAC3Po4KRNOgaMrKGerhKIaZ0DAV5EFwIRWUHHyK
	djA6mllVJ6brEs5I9v2HMKGKWc4niqx9Bmm0PvPasdYzHHxKMQyeysNM1I98lI0QA1Zsk67qdj4
	fALrpSgD2e0FN4B3eVG2TIzHB7GHVEDsKjqX/sjknt4l5kj2+w0LLFKxOYUlptcwk16tYTUisio
	p5bZZvHjh7cKBobJsFrQ5bvsGH5tCLyyXlfIdj1AM50Yybz0HoEZFo1T3NlVmefrvf23eXWnxoN
	cPs0LfOILQ=
X-Gm-Gg: AYBFou0f0aMxW3T3PQh8lyQNinl6cFgT/zVgbgPVB5A12KUi08W+LuoryRrma0+az2+
	1MFcndtn9oc+2Wla+9yNvO5LQ4v1VMYhMcYrCKF6zBOkOKWDmkNNEEPHyKn+b+IulWHV3/e5Bnx
	ga8+0CF7v5gDBaVBIafLLvlvfAIz8U6w04usEcuyQdJKEEvdtR6rO/Kk48JFoSxIx+rdr/Lf57G
	1y22JE4eOUrF3AwdJw4x7mShv13uhpWGePrumXK0wD7PjJpuAEsPZ8GwmpMk4AK+Z7y5ONgL35R
	HT/VBOXTeyXCnrhBGm9oX5YImLNnqIXonodVDxjg9j+7ls57tP6JEdSg/hfq8GXqlRGe7zIs3yC
	0MHRh8QQSXIWew0npuzOQ7CAGD59tPnsI7B7AVTjt8WmToGsxI35/eUhuWYncD3fdm1WHzMHgoO
	i9WiEHXJk4xd9TD+gxpqUg8IMXkDuJrSgwRV0gow==
X-Received: by 2002:a17:903:22d2:b0:2e2:c283:354f with SMTP id d9443c01a7336-2e842abfe53mr94822895ad.28.1791842958181;
        Mon, 12 Oct 2026 15:09:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e841f8ce8fsm4487405ad.30.2026.10.12.15.09.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-33c35f5ca6cso5656373eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842955; x=1792447755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l1k7SuWBXiEifsFWLKnVqGRtSzJCfCOW7iac83Km+o4=;
        b=GapLTD9yc5BPGaE0LQvVWP8DBV0+hia2ZJ2RqwBeqlCIkELyyccgXHgH6xwGOBAtJf
         Ty2dUl4bCcfJIrJK3eliHVfz+ZD2c0XWSAEoC1HGFcsFmCx8x5YQF8bCvsSU8908qroK
         N7GSfCT5MkSpmrPpnUAHkvYstmyUrH+plwKa4=
X-Received: by 2002:a05:7023:90b:b0:143:26f5:c618 with SMTP id a92af1059eb24-16a60625da6mr18110229c88.33.1791842954930;
        Mon, 12 Oct 2026 15:09:14 -0700 (PDT)
X-Received: by 2002:a05:7023:90b:b0:143:26f5:c618 with SMTP id a92af1059eb24-16a60625da6mr18110200c88.33.1791842954216;
        Mon, 12 Oct 2026 15:09:14 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:13 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 6/7] bnxt_en: Remove support for the old NITRO A0 chip
Date: Mon, 12 Oct 2026 15:08:26 -0700
Message-ID: <20261012220827.340998-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012220827.340998-1-michael.chan@broadcom.com>
References: <20261012220827.340998-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Nitro A0 was a very old pre-production chip that requires significant
workarounds.  For example, it requires an extra (hidden) RX ring and CP
ring to work, adding a lot of complexity.  The workaround code is very
buggy and breaks in many cases, including ethtool ring changes
initiated by the user.

Remove all Nitro A0 workaround code completely.  Print an error and
abort if the chip is detected.  This will simplify the next patch that
fixes ring accounting bugs.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 185 ++----------------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  11 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  12 +-
 3 files changed, 19 insertions(+), 189 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2ada2bb8fd57..ed3f67dea030 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3209,82 +3209,6 @@ static int bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return rx_pkts;
 }
 
-static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
-{
-	struct bnxt_napi *bnapi = container_of(napi, struct bnxt_napi, napi);
-	struct bnxt *bp = bnapi->bp;
-	struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
-	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
-	struct tx_cmp *txcmp;
-	struct rx_cmp_ext *rxcmp1;
-	u32 cp_cons, tmp_raw_cons;
-	u32 raw_cons = cpr->cp_raw_cons;
-	bool flush_xdp = false;
-	u32 rx_pkts = 0;
-	u8 event = 0;
-
-	while (1) {
-		int rc;
-
-		cp_cons = RING_CMP(raw_cons);
-		txcmp = &cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
-
-		if (!TX_CMP_VALID(txcmp, raw_cons))
-			break;
-
-		/* The valid test of the entry must be done first before
-		 * reading any further.
-		 */
-		dma_rmb();
-		if ((TX_CMP_TYPE(txcmp) & 0x30) == 0x10) {
-			tmp_raw_cons = NEXT_RAW_CMP(raw_cons);
-			cp_cons = RING_CMP(tmp_raw_cons);
-			rxcmp1 = (struct rx_cmp_ext *)
-			  &cpr->cp_desc_ring[CP_RING(cp_cons)][CP_IDX(cp_cons)];
-
-			if (!RX_CMP_VALID(rxcmp1, tmp_raw_cons))
-				break;
-
-			/* force an error to recycle the buffer */
-			rxcmp1->rx_cmp_cfa_code_errors_v2 |=
-				cpu_to_le32(RX_CMPL_ERRORS_CRC_ERROR);
-
-			rc = bnxt_rx_pkt(bp, cpr, &raw_cons, &event);
-			if (likely(rc == -EIO) && budget)
-				rx_pkts++;
-			else if (rc == -EBUSY)	/* partial completion */
-				break;
-			if (event & BNXT_REDIRECT_EVENT)
-				flush_xdp = true;
-		} else if (unlikely(TX_CMP_TYPE(txcmp) ==
-				    CMPL_BASE_TYPE_HWRM_DONE)) {
-			bnxt_hwrm_handler(bp, txcmp);
-		} else {
-			netdev_err(bp->dev,
-				   "Invalid completion received on special ring\n");
-		}
-		raw_cons = NEXT_RAW_CMP(raw_cons);
-
-		if (rx_pkts == budget)
-			break;
-	}
-
-	cpr->cp_raw_cons = raw_cons;
-	BNXT_DB_CQ(&cpr->cp_db, cpr->cp_raw_cons);
-	bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
-
-	if (event & BNXT_AGG_EVENT)
-		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
-	if (flush_xdp)
-		xdp_do_flush();
-
-	if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
-		napi_complete_done(napi, rx_pkts);
-		BNXT_DB_CQ_ARM(&cpr->cp_db, cpr->cp_raw_cons);
-	}
-	return rx_pkts;
-}
-
 static int bnxt_poll(struct napi_struct *napi, int budget)
 {
 	struct bnxt_napi *bnapi = container_of(napi, struct bnxt_napi, napi);
@@ -4791,9 +4715,6 @@ static int bnxt_alloc_vnics(struct bnxt *bp)
 	}
 #endif
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		num_vnics++;
-
 	bp->vnic_info = kzalloc_objs(struct bnxt_vnic_info, num_vnics);
 	if (!bp->vnic_info)
 		return -ENOMEM;
@@ -6327,11 +6248,8 @@ int bnxt_hwrm_l2_filter_alloc(struct bnxt *bp, struct bnxt_l2_filter *fltr)
 		return rc;
 
 	req->target_id = cpu_to_le16(target_id);
-	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX);
-
-	if (!BNXT_CHIP_TYPE_NITRO_A0(bp))
-		req->flags |=
-			cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
+	req->flags = cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_FLAGS_PATH_RX |
+				 CFA_L2_FILTER_ALLOC_REQ_FLAGS_OUTERMOST);
 	req->dst_id = cpu_to_le16(fltr->base.fw_vnic_id);
 	req->enables =
 		cpu_to_le32(CFA_L2_FILTER_ALLOC_REQ_ENABLES_L2_ADDR |
@@ -6688,10 +6606,7 @@ void bnxt_set_dflt_rss_indir_tbl(struct bnxt *bp,
 	if (!bp->rx_nr_rings)
 		return;
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		max_rings = bp->rx_nr_rings - 1;
-	else
-		max_rings = bp->rx_nr_rings;
+	max_rings = bp->rx_nr_rings;
 
 	max_entries = bnxt_get_rxfh_indir_size(bp->dev);
 	if (rss_ctx)
@@ -6731,8 +6646,6 @@ int bnxt_get_nr_rss_ctxs(struct bnxt *bp, int rx_rings)
 		return bnxt_calc_nr_ring_pages(rx_rings - 1,
 					       BNXT_RSS_TABLE_ENTRIES_P5);
 	}
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		return 2;
 	return 1;
 }
 
@@ -6757,8 +6670,6 @@ static void bnxt_fill_hw_rss_tbl(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 		vnic->default_rx_ring = min_j;
 	else if (vnic->flags & BNXT_VNIC_RFS_FLAG)
 		vnic->default_rx_ring = vnic->vnic_id - 1;
-	else if ((vnic->vnic_id == 1) && BNXT_CHIP_TYPE_NITRO_A0(bp))
-		vnic->default_rx_ring = bp->rx_nr_rings - 1;
 	else
 		vnic->default_rx_ring = 0;
 }
@@ -7013,13 +6924,7 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 		req->rss_rule = cpu_to_le16(0xffff);
 	}
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp) &&
-	    (vnic->fw_rss_cos_lb_ctx[0] != INVALID_HW_RING_ID)) {
-		req->cos_rule = cpu_to_le16(vnic->fw_rss_cos_lb_ctx[1]);
-		req->enables |= cpu_to_le32(VNIC_CFG_REQ_ENABLES_COS_RULE);
-	} else {
-		req->cos_rule = cpu_to_le16(0xffff);
-	}
+	req->cos_rule = cpu_to_le16(0xffff);
 
 	ring = vnic->default_rx_ring;
 	grp_idx = bp->rx_ring[ring].bnapi->index;
@@ -8617,9 +8522,6 @@ static void bnxt_hwrm_stat_ctx_free(struct bnxt *bp)
 	if (!bp->bnapi)
 		return;
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		return;
-
 	if (hwrm_req_init(bp, req, HWRM_STAT_CTX_FREE))
 		return;
 	if (BNXT_FW_MAJ(bp) <= 20) {
@@ -8656,9 +8558,6 @@ static int bnxt_hwrm_stat_ctx_alloc(struct bnxt *bp)
 	struct hwrm_stat_ctx_alloc_input *req;
 	int rc, i;
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		return 0;
-
 	rc = hwrm_req_init(bp, req, HWRM_STAT_CTX_ALLOC);
 	if (rc)
 		return rc;
@@ -10489,9 +10388,6 @@ static int bnxt_hwrm_ver_get(struct bnxt *bp)
 
 	bp->chip_num = le16_to_cpu(resp->chip_num);
 	bp->chip_rev = resp->chip_rev;
-	if (bp->chip_num == CHIP_NUM_58700 && !resp->chip_rev &&
-	    !resp->chip_metal)
-		bp->flags |= BNXT_FLAG_CHIP_NITRO_A0;
 
 	dev_caps_cfg = le32_to_cpu(resp->dev_caps_cfg);
 	if ((dev_caps_cfg & VER_GET_RESP_DEV_CAPS_CFG_SHORT_CMD_SUPPORTED) &&
@@ -10906,16 +10802,6 @@ static int __bnxt_setup_vnic(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 	}
 	bp->rsscos_nr_ctxs++;
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-		rc = bnxt_hwrm_vnic_ctx_alloc(bp, vnic, 1);
-		if (rc) {
-			netdev_err(bp->dev, "hwrm vnic %d cos ctx alloc failure rc: %x\n",
-				   vnic->vnic_id, rc);
-			goto vnic_setup_err;
-		}
-		bp->rsscos_nr_ctxs++;
-	}
-
 skip_rss_ctx:
 	bnxt_fill_hw_rss_tbl(bp, vnic);
 	/* configure default vnic, ring grp */
@@ -11216,30 +11102,6 @@ static bool bnxt_promisc_ok(struct bnxt *bp)
 	return true;
 }
 
-static int bnxt_setup_nitroa0_vnic(struct bnxt *bp)
-{
-	struct bnxt_vnic_info *vnic = &bp->vnic_info[1];
-	unsigned int rc = 0;
-
-	rc = bnxt_hwrm_vnic_alloc(bp, vnic, bp->rx_nr_rings - 1, 1);
-	if (rc) {
-		netdev_err(bp->dev, "Cannot allocate special vnic for NS2 A0: %x\n",
-			   rc);
-		return rc;
-	}
-
-	/* Setup the proper default RX ring */
-	bnxt_fill_hw_rss_tbl(bp, vnic);
-
-	rc = bnxt_hwrm_vnic_cfg(bp, vnic);
-	if (rc) {
-		netdev_err(bp->dev, "Cannot allocate special vnic for NS2 A0: %x\n",
-			   rc);
-		return rc;
-	}
-	return rc;
-}
-
 static int bnxt_cfg_rx_mode(struct bnxt *, struct netdev_hw_addr_list *, bool);
 static bool bnxt_mc_list_updated(struct bnxt *, u32 *,
 				 const struct netdev_hw_addr_list *);
@@ -11248,7 +11110,6 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 {
 	struct bnxt_vnic_info *vnic = &bp->vnic_info[BNXT_VNIC_DEFAULT];
 	int rc = 0;
-	unsigned int rx_nr_rings = bp->rx_nr_rings;
 
 	if (irq_re_init) {
 		rc = bnxt_hwrm_stat_ctx_alloc(bp);
@@ -11271,11 +11132,8 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		goto err_out;
 	}
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		rx_nr_rings--;
-
 	/* default vnic 0 */
-	rc = bnxt_hwrm_vnic_alloc(bp, vnic, 0, rx_nr_rings);
+	rc = bnxt_hwrm_vnic_alloc(bp, vnic, 0, bp->rx_nr_rings);
 	if (rc) {
 		netdev_err(bp->dev, "hwrm vnic alloc failure rc: %x\n", rc);
 		goto err_out;
@@ -11350,13 +11208,6 @@ static int bnxt_init_chip(struct bnxt *bp, bool irq_re_init)
 		netdev_warn(bp->dev, "HWRM set coalescing failure rc: %x\n",
 				rc);
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-		rc = bnxt_setup_nitroa0_vnic(bp);
-		if (rc)
-			netdev_err(bp->dev, "Special vnic setup failure for NS2 A0 rc: %x\n",
-				   rc);
-	}
-
 	if (BNXT_VF(bp)) {
 		bnxt_hwrm_func_qcfg(bp);
 		netdev_update_features(bp->dev);
@@ -12108,26 +11959,19 @@ static void bnxt_del_napi(struct bnxt *bp)
 static void bnxt_init_napi(struct bnxt *bp)
 {
 	int (*poll_fn)(struct napi_struct *, int) = bnxt_poll;
-	unsigned int cp_nr_rings = bp->cp_nr_rings;
 	struct bnxt_napi *bnapi;
 	int i;
 
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS)
 		poll_fn = bnxt_poll_p5;
-	else if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-		cp_nr_rings--;
 
 	set_bit(BNXT_STATE_NAPI_DISABLED, &bp->state);
 
-	for (i = 0; i < cp_nr_rings; i++) {
+	for (i = 0; i < bp->cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
 		netif_napi_add_config_locked(bp->dev, &bnapi->napi, poll_fn,
 					     bnapi->index);
 	}
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-		bnapi = bp->bnapi[cp_nr_rings];
-		netif_napi_add_locked(bp->dev, &bnapi->napi, bnxt_poll_nitroa0);
-	}
 }
 
 static void bnxt_disable_napi(struct bnxt *bp)
@@ -14001,7 +13845,7 @@ static bool bnxt_rfs_supported(struct bnxt *bp)
 	/* 212 firmware is broken for aRFS */
 	if (BNXT_FW_MAJ(bp) == 212)
 		return false;
-	if (BNXT_PF(bp) && !BNXT_CHIP_TYPE_NITRO_A0(bp))
+	if (BNXT_PF(bp))
 		return true;
 	if (bp->rss_cap & BNXT_RSS_CAP_NEW_RSS_CAP)
 		return true;
@@ -16824,10 +16668,6 @@ static void _bnxt_get_max_rings(struct bnxt *bp, int *max_rx, int *max_tx,
 	if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS))
 		*max_cp = min_t(int, *max_cp, max_irq);
 	max_ring_grps = hw_resc->max_hw_ring_grps;
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && BNXT_PF(bp)) {
-		*max_cp -= 1;
-		*max_rx -= 2;
-	}
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		*max_rx >>= 1;
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
@@ -16977,10 +16817,6 @@ static int bnxt_set_dflt_rings(struct bnxt *bp, bool sh)
 			netdev_warn(bp->dev, "2nd rings reservation failed.\n");
 		bnxt_adj_tx_rings(bp);
 	}
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-		bp->rx_nr_rings++;
-		bp->cp_nr_rings++;
-	}
 	if (rc) {
 		bp->tx_nr_rings = 0;
 		bp->rx_nr_rings = 0;
@@ -17251,6 +17087,13 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (rc)
 		goto init_err_pci_clean;
 
+	if (bp->chip_num == CHIP_NUM_58700 && !bp->chip_rev &&
+	    !bp->ver_resp.chip_metal) {
+		dev_err(&pdev->dev, "58700 A0 unsupported, aborting\n");
+		rc = -ENODEV;
+		goto init_err_pci_clean;
+	}
+
 	if (BNXT_PF(bp))
 		bnxt_vpd_read_info(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 75428a585577..51a269d06c49 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2295,7 +2295,6 @@ struct bnxt {
 	#define BNXT_FLAG_DSN_VALID	0x200000
 	#define BNXT_FLAG_DOUBLE_DB	0x400000
 	#define BNXT_FLAG_UDP_GSO_CAP	0x800000
-	#define BNXT_FLAG_CHIP_NITRO_A0	0x1000000
 	#define BNXT_FLAG_DIM		0x2000000
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
@@ -2323,10 +2322,8 @@ struct bnxt {
 #define BNXT_PHY_CFG_ABLE(bp)	((BNXT_SINGLE_PF(bp) ||			\
 				  BNXT_SH_PORT_CFG_OK(bp)) &&		\
 				 (bp)->link_info.phy_state == BNXT_PHY_STATE_ENABLED)
-#define BNXT_CHIP_TYPE_NITRO_A0(bp) ((bp)->flags & BNXT_FLAG_CHIP_NITRO_A0)
 #define BNXT_RX_PAGE_MODE(bp)	((bp)->flags & BNXT_FLAG_RX_PAGE_MODE)
-#define BNXT_SUPPORTS_TPA(bp)	(!BNXT_CHIP_TYPE_NITRO_A0(bp) &&	\
-				 (!((bp)->flags & BNXT_FLAG_CHIP_P5_PLUS) ||\
+#define BNXT_SUPPORTS_TPA(bp)	((!((bp)->flags & BNXT_FLAG_CHIP_P5_PLUS) ||\
 				  (bp)->max_tpa_v2) && !is_kdump_kernel())
 #define BNXT_RX_JUMBO_MODE(bp)	((bp)->flags & BNXT_FLAG_JUMBO)
 
@@ -2347,13 +2344,11 @@ struct bnxt {
 	(BNXT_CHIP_NUM_57X1X((bp)->chip_num) ||	\
 	 BNXT_CHIP_NUM_5745X((bp)->chip_num) ||	\
 	 BNXT_CHIP_NUM_588XX((bp)->chip_num) ||	\
-	 (BNXT_CHIP_NUM_58700((bp)->chip_num) &&	\
-	  !BNXT_CHIP_TYPE_NITRO_A0(bp)))
+	 BNXT_CHIP_NUM_58700((bp)->chip_num))
 
 /* Chip class phase 3.x */
 #define BNXT_CHIP_P3(bp)			\
-	(BNXT_CHIP_NUM_57X0X((bp)->chip_num) ||	\
-	 BNXT_CHIP_TYPE_NITRO_A0(bp))
+	(BNXT_CHIP_NUM_57X0X((bp)->chip_num))
 
 #define BNXT_CHIP_P4_PLUS(bp)			\
 	(BNXT_CHIP_P4(bp) || BNXT_CHIP_P5_PLUS(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 5c9e770960e6..62f894021fd1 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -949,13 +949,9 @@ static void bnxt_get_channels(struct net_device *dev,
 	channel->max_other = 0;
 	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
 		channel->combined_count = bp->rx_nr_rings;
-		if (BNXT_CHIP_TYPE_NITRO_A0(bp))
-			channel->combined_count--;
 	} else {
-		if (!BNXT_CHIP_TYPE_NITRO_A0(bp)) {
-			channel->rx_count = bp->rx_nr_rings;
-			channel->tx_count = bp->tx_nr_rings_per_tc;
-		}
+		channel->rx_count = bp->rx_nr_rings;
+		channel->tx_count = bp->tx_nr_rings_per_tc;
 	}
 }
 
@@ -980,10 +976,6 @@ static int bnxt_set_channels(struct net_device *dev,
 	    (channel->rx_count || channel->tx_count))
 		return -EINVAL;
 
-	if (BNXT_CHIP_TYPE_NITRO_A0(bp) && (channel->rx_count ||
-					    channel->tx_count))
-		return -EINVAL;
-
 	if (channel->combined_count)
 		sh = true;
 
-- 
2.51.0

