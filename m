Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6649364E
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290382; cv=none; b=HwdrfbIlLs+BhemeRca9mJZf3gBOFS5EyCx38xbU3/DNqt2m/cVFMm4forlfbC7H/7jeuX4YW0Pa4aASkovhJKs6grT3o9/QauLo9qUdMF4cdx7HVy4j4aYV2sFbxmUKBIEBgak/YADQfi1P3alWXGf8/Ek3qBK33YrvoQKH5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290382; c=relaxed/simple;
	bh=iueqeIbJYnCT9WVs/BpHtEDifuD6Tb8T9a83N/PgUVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8Jb0vDllf9xGNwfzuFPzzayeeUORYpzJ+cza1V/vvPs2hfuwHLerMnCphZv3/xFZ2V5lUYuwoSSdMYaBMCt3/gK/+/hy/pfXxwnKlbyZjCSWAPW5b/z21MtPkkPAkQG8DXSDqlrA0cnhqROf4xdxwxdY8bVgFpu+ImS4YQp/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U3lwcBy2; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U3lwcBy2"
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-5218927884fso2224991cf.3
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290379; x=1788895179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W1gNnpuofqG8j7WBbKQviqP7swsJK+cjy5dt+o+RP90=;
        b=GMK/UxLJmjNZz4+3Hl4/jLRcmT2sBokp/rPLeCc99YcPXIJRMbSVatgtDINeZTG4Mq
         X3GmMwjNH6fOaGUIbT84fUdrdb0hbP6/FoA9ppfx4K/bgOBC3KQanE0EiR8jPaip6eBk
         BIxjDs1oDhME9gPXhKI47iCWpYb0gh1qC63qyeEm2zhZ315zNM/eLHFx8PgF045uLCb6
         4xbExinkAefJgtr2CzPR/VCxGdN/BqFqlQJpYOh8L2bSeWci9bXXFC1cNfXXcXUVGQ3n
         2fWWhDjHIUbU1GpUYHv3IsrJH8HAf8V1ts5To20hQDT9glKuambmkejZwmZDT+0f3rcG
         84GA==
X-Gm-Message-State: AFuF++mL8kumTAy8GjGV1tSjSj4j9Qg9rHF2k7I16/vDusBP3qNZmTHu
	jzBXyurkMsX1VWLax8qvFqMFP7yJq9RAyci/+kZzpwfN5Th8GzKYf0yOj87FINHJXQe1LAZ1J78
	wUo1YZFK70leaPoJVu/9B0jTcCfCq0GT/SMoHddBgeBkyACQMXvivklCk9MwjxU6RjtXNcdVELC
	Rns2ESz2hondhhcsB3fmElR9U7sUhoPvA62Uz67g3ip5q36DnTx0uoMT7EM1P6OKXIBP3x/E8/M
	cetmWBniHHE/Omrhw==
X-Gm-Gg: AR+sD13/89E7odoyZWwO9JId1W0XAse+Elcfh2qId1xjsnEpRrsNarGJNHcJiUy3Ln2
	2WrkuEKscOErNuKpflo6Yz0ZjNdyfdhV+C/5ZlmrjA415EEgxnsfA+OA7SLDfRTzugKx3fSOnS0
	ZIr5/+7kcFtjr3Zt80CqaEXce6S+qeorXmYUky1CcRGReuuNvf1a/yrYYMTSCu4j7BVy6cRYvHc
	XoRdu1Oyf8Hgp+QcRA3DFlpbOC88LPVwEMujsydw6N1OV5IF2iG8N/Bjg8gM47efzy+DRk2qsxH
	L3EiPi3Ax2JOy+rjAaf2KnXnGDZRTckGT3Jb/P1XL+M8KYzcxWXcrVBJ5vIse5aD77Gzglj50TC
	P501RYyajKT/OgryrDGwWlkYQq99B1EhoaOkH2mQHiTWzNLiCUCnGg0bVfGSHw5HVxlKQRAX90+
	eQyKfo/PlpT7CMmu53Cj6xmtmY0Qfwb7MDvqr1FhpJBw==
X-Received: by 2002:ac8:690d:0:b0:52d:f001:5c4f with SMTP id d75a77b69052e-530342d34ddmr8395241cf.20.1788290319001;
        Tue, 01 Sep 2026 12:18:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-53032fdf837sm79451cf.12.2026.09.01.12.18.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d6fb956002so2294385ad.1
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290318; x=1788895118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W1gNnpuofqG8j7WBbKQviqP7swsJK+cjy5dt+o+RP90=;
        b=U3lwcBy2dBekprz5Qa31/qNuFu9LZIiNYxLH70iMDuDsmTXKHRVVD04zcHpaafeaqO
         k+4FEpPUNhb6QRLpAfIfjXApmPAE647blD6lTPXo2t9Bpfe4LieHXnDDwC8fPw3H1OfP
         f91PFjp7SdHd2W5KR6lzioPGU0aa3luvA91Tw=
X-Received: by 2002:a17:903:234b:b0:2d8:d4d3:3fc0 with SMTP id d9443c01a7336-2dae5f03d3emr5623235ad.20.1788290317371;
        Tue, 01 Sep 2026 12:18:37 -0700 (PDT)
X-Received: by 2002:a17:903:234b:b0:2d8:d4d3:3fc0 with SMTP id d9443c01a7336-2dae5f03d3emr5622285ad.20.1788290316606;
        Tue, 01 Sep 2026 12:18:36 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:35 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Dharmender Garg <dharmender.garg@broadcom.com>
Subject: [PATCH net-next 6/7] bnge: Create NQ0 during probe and keep active across open/close
Date: Wed,  2 Sep 2026 00:47:27 +0530
Message-ID: <20260901191728.643212-7-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
References: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Set up NQ0 via bnge_setup_nq0() during probe and free it via bnge_free_nq0()
at remove. Skip NQ0 in open/close ring, IRQ, and NAPI helpers once
BNGE_NAPI_FLAG_NQ0 is set.

Also guard bnge_napi_poll() against stale completions for rings freed by
bnge_free_nq_tree().

The previous patch already added the bnge_quiesce_nq0()/bnge_resume_nq0()
guard around bnge_free_core()'s teardown and bnge_alloc_core()'s rebuild,
so NQ0 is safe to leave active across close/open from the moment
BNGE_NAPI_FLAG_NQ0 is set below.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 237 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   3 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  15 ++
 4 files changed, 244 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 10d54568f2c5..d11c404acd4e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -527,6 +527,9 @@ static void bnge_free_nq_arrays(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		bnge_free_nq_desc_arr(&bnapi->nq_ring);
 	}
 }
@@ -539,6 +542,9 @@ static int bnge_alloc_nq_arrays(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
 		if (rc)
 			goto err_free_nq_arrays;
@@ -564,7 +570,8 @@ static void bnge_free_nq_tree(struct bnge_net *bn)
 		nqr = &bnapi->nq_ring;
 		ring = &nqr->ring_struct;
 
-		bnge_free_ring(bd, &ring->ring_mem);
+		if (!BNGE_NQ0_NAPI(bnapi))
+			bnge_free_ring(bd, &ring->ring_mem);
 
 		if (!nqr->cp_ring_arr)
 			continue;
@@ -592,6 +599,9 @@ static void bnge_quiesce_nq0(struct bnge_net *bn)
 	if (!BNGE_NQ0_NAPI(bnapi))
 		return;
 
+	if (test_and_set_bit(BNGE_NAPI_FLAG_NQ0_QUIESCED, &bnapi->flags))
+		return;
+
 	ring = &nqr->ring_struct;
 	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
 	synchronize_irq(bd->irq_tbl[ring->map_idx].vector);
@@ -606,6 +616,9 @@ static void bnge_resume_nq0(struct bnge_net *bn)
 	if (!BNGE_NQ0_NAPI(bnapi))
 		return;
 
+	if (!test_and_clear_bit(BNGE_NAPI_FLAG_NQ0_QUIESCED, &bnapi->flags))
+		return;
+
 	napi_enable_locked(&bnapi->napi);
 	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
 }
@@ -658,11 +671,13 @@ static int bnge_alloc_nq_tree(struct bnge_net *bn)
 		nqr->bnapi = bnapi;
 		ring = &nqr->ring_struct;
 
-		rc = bnge_alloc_ring(bd, &ring->ring_mem);
-		if (rc)
-			goto err_free_nq_tree;
+		if (!BNGE_NQ0_NAPI(bnapi)) {
+			rc = bnge_alloc_ring(bd, &ring->ring_mem);
+			if (rc)
+				goto err_free_nq_tree;
 
-		ring->map_idx = ulp_msix + i;
+			ring->map_idx = ulp_msix + i;
+		}
 
 		if (i < bd->rx_nr_rings) {
 			cp_count++;
@@ -1236,10 +1251,14 @@ static int bnge_init_ring_grps(struct bnge_net *bn, bool irq_re_init)
 		bn->grp_info[i].fw_grp_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].rx_fw_ring_id = INVALID_HW_RING_ID;
 		bn->grp_info[i].agg_fw_ring_id = INVALID_HW_RING_ID;
-		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 
 		if (irq_re_init)
 			bn->grp_info[i].fw_stats_ctx = INVALID_HW_RING_ID;
+
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
+		bn->grp_info[i].nq_fw_ring_id = INVALID_HW_RING_ID;
 	}
 
 	return 0;
@@ -1442,8 +1461,11 @@ static void bnge_init_nq_tree(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr = &bn->bnapi[i]->nq_ring;
 		struct bnge_ring_struct *ring = &nqr->ring_struct;
 
-		nqr->nq_raw_cons = 0;
-		ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+		if (!BNGE_NQ0_NAPI(bn->bnapi[i])) {
+			nqr->nq_raw_cons = 0;
+			ring->fw_ring_id = INVALID_HW_RING_ID_32BIT;
+		}
+
 		for (j = 0; j < nqr->cp_ring_count; j++) {
 			struct bnge_cp_ring_info *cpr = &nqr->cp_ring_arr[j];
 
@@ -1970,6 +1992,9 @@ static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
 	unsigned int vector;
 	int rc;
 
+	if (BNGE_NQ0_NAPI(bnapi))
+		return 0;
+
 	vector = bd->irq_tbl[map_idx].vector;
 	disable_irq_nosync(vector);
 	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
@@ -2402,6 +2427,9 @@ static void bnge_disable_int(struct bnge_net *bn)
 		struct bnge_nq_ring_info *nqr;
 		struct bnge_ring_struct *ring;
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		nqr = &bnapi->nq_ring;
 		ring = &nqr->ring_struct;
 
@@ -2417,9 +2445,10 @@ static void bnge_disable_int_sync(struct bnge_net *bn)
 
 	bnge_disable_int(bn);
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		int map_idx = bnge_cp_num_to_irq_num(bn, i);
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
 
-		synchronize_irq(bd->irq_tbl[map_idx].vector);
+		synchronize_irq(bd->irq_tbl[bnge_cp_num_to_irq_num(bn, i)].vector);
 	}
 }
 
@@ -2432,6 +2461,9 @@ static void bnge_enable_int(struct bnge_net *bn)
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_nq_ring_info *nqr;
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		nqr = &bnapi->nq_ring;
 		bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
 	}
@@ -2448,6 +2480,8 @@ static void bnge_disable_napi(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
 		napi_disable_locked(&bnapi->napi);
 	}
 }
@@ -2464,6 +2498,8 @@ static void bnge_enable_napi(struct bnge_net *bn)
 		bnapi->in_reset = false;
 		bnapi->tx_fault = 0;
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
 		napi_enable_locked(&bnapi->napi);
 	}
 }
@@ -2612,6 +2648,9 @@ static void bnge_hwrm_ring_free(struct bnge_net *bn, bool close_path)
 		for (j = 0; j < nqr->cp_ring_count && nqr->cp_ring_arr; j++)
 			bnge_hwrm_cp_ring_free(bn, &nqr->cp_ring_arr[j]);
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		ring = &nqr->ring_struct;
 		if (ring->fw_ring_id != INVALID_HW_RING_ID_32BIT) {
 			hwrm_ring_free_send_msg(bn, ring,
@@ -2673,6 +2712,9 @@ static void bnge_free_irq(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
 		irq = &bd->irq_tbl[map_idx];
 		if (irq->requested) {
 			if (irq->have_cpumask) {
@@ -2701,6 +2743,9 @@ static int bnge_request_irq(struct bnge_net *bn)
 		int map_idx = bnge_cp_num_to_irq_num(bn, i);
 		struct bnge_irq *irq = &bd->irq_tbl[map_idx];
 
+		if (BNGE_NQ0_NAPI(bn->bnapi[i]))
+			continue;
+
 		rc = request_irq(irq->vector, irq->handler, 0, irq->name,
 				 bn->bnapi[i]);
 		if (rc)
@@ -2840,6 +2885,10 @@ static void bnge_init_napi(struct bnge_net *bn)
 
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		bnapi = bn->bnapi[i];
+
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
 					     bnge_napi_poll, bnapi->index);
 	}
@@ -2858,6 +2907,9 @@ static void bnge_del_napi(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 
+		if (BNGE_NQ0_NAPI(bnapi))
+			continue;
+
 		__netif_napi_del_locked(&bnapi->napi);
 	}
 
@@ -3237,6 +3289,8 @@ static void bnge_close_core(struct bnge_net *bn)
 	clear_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
 	spin_unlock_bh(&bn->stats_lock);
 
+	bnge_quiesce_nq0(bn);
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -3467,6 +3521,159 @@ static void bnge_init_ring_params(struct bnge_net *bn)
 	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
+static void bnge_free_nq0(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	struct bnge_irq *irq;
+
+	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	nqr = &bnapi->nq_ring;
+	ring = &nqr->ring_struct;
+	irq = &bd->irq_tbl[ring->map_idx];
+
+	if (!BNGE_NQ0_NAPI(bnapi)) {
+		/* A previous bnge_setup_nq0() could have failed
+		 * leaving behind an active irq.
+		 */
+		goto free_irq;
+	}
+
+	clear_bit(BNGE_NAPI_FLAG_NQ0, &bnapi->flags);
+	clear_bit(BNGE_NAPI_FLAG_NQ0_QUIESCED, &bnapi->flags);
+
+	/* Unlike the other NQs, NQ0's NAPI is left enabled by bnge_disable_napi()
+	 * so it can keep processing async events while the interface is
+	 * administratively down. It is explicitly disabled below, or was never
+	 * enabled if netdev was never opened (netif_napi_add default).
+	 */
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	synchronize_irq(irq->vector);
+
+	hwrm_ring_free_send_msg(bn, ring,
+				RING_FREE_REQ_RING_TYPE_NQ,
+				INVALID_HW_RING_ID);
+	ring->fw_ring_id = INVALID_HW_RING_ID;
+	bn->grp_info[0].nq_fw_ring_id = INVALID_HW_RING_ID;
+
+free_irq:
+	if (irq->requested) {
+		if (irq->have_cpumask) {
+			irq_set_affinity_hint(irq->vector, NULL);
+			free_cpumask_var(irq->cpu_mask);
+			irq->have_cpumask = 0;
+		}
+		free_irq(irq->vector, bnapi);
+		irq->requested = 0;
+
+		netdev_lock(bn->netdev);
+		napi_disable_locked(&bnapi->napi);
+		__netif_napi_del_locked(&bnapi->napi);
+		netdev_unlock(bn->netdev);
+
+		/* We called __netif_napi_del_locked(), we need
+		 * grace period before freeing napi structures.
+		 */
+		synchronize_net();
+	}
+
+	bnge_free_ring(bd, &ring->ring_mem);
+	bnge_free_nq_desc_arr(nqr);
+}
+
+static int bnge_setup_nq0(struct bnge_net *bn)
+{
+	struct bnge_nq_ring_info *nqr;
+	struct bnge_ring_struct *ring;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_napi *bnapi;
+	struct bnge_irq *irq;
+	int map_idx, rc;
+
+	bnapi = bn->bnapi[BNGE_NQ0_NAPI_IDX];
+	if (BNGE_NQ0_NAPI(bnapi))
+		return 0;
+
+	nqr = &bnapi->nq_ring;
+	ring = &nqr->ring_struct;
+	rc = bnge_alloc_nq_desc_arr(&bnapi->nq_ring, bn->cp_nr_pages);
+	if (rc)
+		return -ENOMEM;
+
+	bnge_init_nq_ring_struct(bn, nqr);
+	rc = bnge_alloc_ring(bd, &ring->ring_mem);
+	if (rc)
+		goto err_free_nq_desc_arr;
+
+	map_idx = bnge_aux_get_msix(bd);
+	ring->map_idx = map_idx;
+	irq = &bd->irq_tbl[map_idx];
+	irq->handler = bnge_msix;
+
+	netdev_lock(bn->netdev);
+	netif_napi_add_config_locked(bn->netdev, &bnapi->napi,
+				     bnge_napi_poll, bnapi->index);
+	netdev_unlock(bn->netdev);
+
+	snprintf(irq->name, sizeof(bd->irq_tbl[0].name), "%s-%s-%d", "bnge",
+		 "nq", map_idx);
+	rc = request_irq(irq->vector, irq->handler, 0, irq->name, bnapi);
+	if (rc)
+		goto err_del_napi;
+
+	netdev_lock(bn->netdev);
+	netif_napi_set_irq_locked(&bnapi->napi, irq->vector);
+	netdev_unlock(bn->netdev);
+	irq->requested = 1;
+
+	if (zalloc_cpumask_var(&irq->cpu_mask, GFP_KERNEL)) {
+		int numa_node = dev_to_node(&bd->pdev->dev);
+
+		irq->have_cpumask = 1;
+		cpumask_set_cpu(cpumask_local_spread(BNGE_NQ0_NAPI_IDX, numa_node),
+				irq->cpu_mask);
+		rc = irq_set_affinity_hint(irq->vector, irq->cpu_mask);
+		if (rc) {
+			netdev_warn(bn->netdev,
+				    "Set affinity failed, IRQ = %d\n",
+				    irq->vector);
+			goto err_free_irq;
+		}
+	}
+
+	rc = bnge_hwrm_nq_ring_alloc(bn, BNGE_NQ0_NAPI_IDX);
+	if (rc)
+		goto err_free_irq;
+
+	netdev_lock(bn->netdev);
+	napi_enable_locked(&bnapi->napi);
+	netdev_unlock(bn->netdev);
+	bnge_db_nq_arm(bn, &nqr->nq_db, nqr->nq_raw_cons);
+
+	set_bit(BNGE_NAPI_FLAG_NQ0, &bnapi->flags);
+
+	return 0;
+
+err_free_irq:
+	if (irq->have_cpumask) {
+		irq_set_affinity_hint(irq->vector, NULL);
+		free_cpumask_var(irq->cpu_mask);
+		irq->have_cpumask = 0;
+	}
+	free_irq(irq->vector, bnapi);
+	irq->requested = 0;
+err_del_napi:
+	netdev_lock(bn->netdev);
+	__netif_napi_del_locked(&bnapi->napi);
+	netdev_unlock(bn->netdev);
+	bnge_free_ring(bd, &ring->ring_mem);
+err_free_nq_desc_arr:
+	bnge_free_nq_desc_arr(nqr);
+	return rc;
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -3594,14 +3801,20 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	if (rc)
 		goto err_free_bnapi_mem;
 
+	rc = bnge_setup_nq0(bn);
+	if (rc)
+		goto err_free_ring_grps;
+
 	rc = register_netdev(netdev);
 	if (rc) {
 		dev_err(bd->dev, "Register netdev failed rc: %d\n", rc);
-		goto err_free_ring_grps;
+		goto err_free_nq0;
 	}
 
 	return 0;
 
+err_free_nq0:
+	bnge_free_nq0(bn);
 err_free_ring_grps:
 	bnge_free_ring_grps(bn);
 err_free_bnapi_mem:
@@ -3624,6 +3837,8 @@ void bnge_netdev_free(struct bnge_dev *bd)
 
 	unregister_netdev(netdev);
 
+	bnge_free_nq0(bn);
+
 	timer_shutdown_sync(&bn->timer);
 	cancel_work_sync(&bn->sp_task);
 	bn->sp_event = 0;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 4d84f109ad5f..e2fb15fd62b6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -543,6 +543,7 @@ struct bnge_tx_ring_info {
 
 enum bnge_napi_flag {
 	BNGE_NAPI_FLAG_NQ0,
+	BNGE_NAPI_FLAG_NQ0_QUIESCED,
 };
 
 #define BNGE_NQ0_NAPI(bnapi)	(test_bit(BNGE_NAPI_FLAG_NQ0, &(bnapi)->flags))
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index e0ddb2800c54..22fd4eeb3213 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -450,7 +450,8 @@ void bnge_init_ring_struct(struct bnge_net *bn)
 		struct bnge_tx_ring_info *txr;
 		struct bnge_ring_struct *ring;
 
-		bnge_init_nq_ring_struct(bn, &bnapi->nq_ring);
+		if (!BNGE_NQ0_NAPI(bnapi))
+			bnge_init_nq_ring_struct(bn, &bnapi->nq_ring);
 
 		rxr = bnapi->rx_ring;
 		if (!rxr)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
index 7d45e057f2e8..dcec6fdced30 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_txrx.c
@@ -1375,6 +1375,21 @@ int bnge_napi_poll(struct napi_struct *napi, int budget)
 				break;
 
 			idx = BNGE_NQ_HDL_IDX(idx);
+
+			/* NQ0 keeps running while administratively down to
+			 * process async events, but its cp_ring_arr is torn
+			 * down (and cp_ring_count zeroed) by
+			 * bnge_free_nq_tree() while down. Guard against a
+			 * stray/late CQ notification arriving in that state
+			 * instead of dereferencing a freed or out-of-range
+			 * cp_ring_arr.
+			 */
+			if (unlikely(!nqr->cp_ring_arr ||
+				     idx >= nqr->cp_ring_count)) {
+				raw_cons = NEXT_RAW_CMP(raw_cons);
+				continue;
+			}
+
 			cpr = &nqr->cp_ring_arr[idx];
 			cpr->had_nqe_notify = 1;
 			cpr->toggle = NQE_CN_TOGGLE(type);
-- 
2.47.3

