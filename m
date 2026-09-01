Received: from mail-ua1-f97.google.com (mail-ua1-f97.google.com [209.85.222.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71C4A205D
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290300; cv=none; b=QCsRTcjvzdF/Kth5qJJyqNyyd1NCjx3O0er54ylb+5EtW9OxIwlul7gUTblYO3gePv4zPfuM8+QKJzCULrAEOS2nANEnMg/Afa9gNIzGOY2ozw9lxJZz1Pf29SyWjXR/+3MfXAbZCebYAZKcFcyTC0PWd755FE/7SG0aVATnu7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290300; c=relaxed/simple;
	bh=oFPz7pp/mMILcTgKcPtfBr0KKYhYwd5s3DTyKq5yXs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghFhMpU2g9dyuvPPZmy1WMzlWpFGlXhj8BlaO7I0TPTiEDNazqIE6v6txFYe83HfbruSUy8IOiK1RBDODVkzJm13rJ9wy+z+rRuBPXprM+PCGJjMjhVTECaYyAcoQvMtUs+vCvT0ryh4EJKI4V0xKCUaVHSrc6kl9bsSQCK+HVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=au4ctlrj; arc=none smtp.client-ip=209.85.222.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="au4ctlrj"
Received: by mail-ua1-f97.google.com with SMTP id a1e0cc1a2514c-97cc20c05d3so58597241.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290298; x=1788895098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pGqPXgPgllirzMXMpaUakGPcJZSVGhd46PFeQ76evwg=;
        b=Q3sujtkymdxKjqH0sfTxomHiO/qHxzQPCJJP/rnWRrayERx05fjWmeJll+2MPt32Vk
         tRBmU6RMwTjr1l399qw7RtGK34a4y1bpaZCRFWZHSN8tIIZf3lLU0b8ktIFuM7uWxdn7
         a0PIhBObLBB6Llyeg/UTD4/kSwJ/4mQ1TRWZyz/7tU7C+LM1Ib5ESw1B22oRBeg0Z37V
         Y0eFU59aKsbzaEwZqJOdD0RpwSZLhqrxmWeyBnSUEFdegmstMRv1a4/tbU9qd+WQPoLR
         t1w3UGWvQIunZmejXha3BBUqSioUEDbrAHeZGpwa2DZwRbfq+PTcnAmwJKt1u5IFqE9V
         9R4g==
X-Gm-Message-State: AFuF++n65T8gCVivi93T5yInN9mjHpx+xDeiemnXWL6VbUKsBL868XUD
	s7JGvlyuueBvA0XBh+hCvoUEDAHeUaK8dRK0LuUbFHoucZ81V4myQjXk/PQtmz1tEAplrIYBU7/
	k57GoysrkgbyDu/FACjVptaFmLqqOwdW29b+A21jeXjIJilSNPP06X0ecIgx+J8S9CXf2ptcPa1
	kZBGFsLFFb8Zy40fa9jy+xjPZGamwnLUHjA1USbxjgYcSupdA48d2pmfmhl0gYaTbj4jpT6QCEc
	bwoD46WX7THw53Ecw==
X-Gm-Gg: AYBFou2BX86462A5qQYReYxoAEHfCKjmVrg5G2Fukv12GfYxC5CmffCViphQO6hOT+O
	E9o7VFadXa/45YuB/MMsN5FwDnmI3hsTqMGhC4aR3v8K8Eql/mlQgRl9qpBhjBeLRNy+R2r1pmu
	TBFBI6oQRYT3TolOhKgJjJPS+QL4ujNbcd8XbLv8cbJEQ0X17MZxOeSE2MY9RJTJuwS8amjeXzY
	rFHi/wkp61nTIdRtk+h3Qj47NpCGQ6kfGxKXoQaOTK454eUyJMtu/CdFfzwM6cSg8ipnbZhHkdN
	9WJfRNqbwbH77PmJ6yXZWWv55oIpMMrqGLAu+h6vfnR8YVK1Ebq+2kmHaGfVdqtVae92+Qvmktu
	YwnQ8ZGv5rUe2TReoECtajApkXpw4OccDtKnam2ZlUsQLexeTTl2AIgNgNaW3B2OoHCBgg69HSE
	vdua6TxWPz/J91pTESG9CjtYj4dfc5OqznLBiRlNImsQ==
X-Received: by 2002:a05:6102:3c9f:b0:784:b9ec:913f with SMTP id ada2fe7eead31-78a1c5c50a2mr119538137.5.1788290297369;
        Tue, 01 Sep 2026 12:18:17 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-78a1a1feacdsm13363137.10.2026.09.01.12.18.17
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:17 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cfe48ca1efso1917015ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290296; x=1788895096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pGqPXgPgllirzMXMpaUakGPcJZSVGhd46PFeQ76evwg=;
        b=au4ctlrjYdSkorJD0eu0RYZFRvCqt5b4dgrxFAra4bLBEEHmcs+VIGOieAcg35NuQx
         odSCoHsrJJohycNPa5uGEajuPA5/TdkO/DgjDZhVY8qNWv+yCzoB8AvtjDEaoTN/2dZc
         Q5ZgamViCUhzYv2eUKifPoMWElrUIXiG6WgNg=
X-Received: by 2002:a17:903:22ca:b0:2d9:51db:7eaa with SMTP id d9443c01a7336-2dae5efaa55mr7201625ad.20.1788290296171;
        Tue, 01 Sep 2026 12:18:16 -0700 (PDT)
X-Received: by 2002:a17:903:22ca:b0:2d9:51db:7eaa with SMTP id d9443c01a7336-2dae5efaa55mr7200775ad.20.1788290295674;
        Tue, 01 Sep 2026 12:18:15 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:15 -0700 (PDT)
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
	Dharmender Garg <dharmender.garg@broadcom.com>,
	Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Subject: [PATCH net-next 2/7] bnge: Extract per-NQ ring allocation and init helpers
Date: Wed,  2 Sep 2026 00:47:23 +0530
Message-ID: <20260901191728.643212-3-bhargava.marreddy@broadcom.com>
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

Factor the per-NQ loop body in bnge_hwrm_ring_alloc() and
bnge_init_ring_struct() into standalone bnge_hwrm_nq_ring_alloc() and
bnge_init_nq_ring_struct() helpers.

This is a pure refactor with no functional changes, preparing NQ0 setup
to run independently during probe rather than through the open path loop.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Dharmender Garg <dharmender.garg@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 56 +++++++++++--------
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 25 ++++++---
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |  4 +-
 3 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index dbadbf76a3a9..6c1cb3aab5a8 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -1909,6 +1909,37 @@ static int bnge_hwrm_rx_ring_alloc(struct bnge_net *bn,
 	return 0;
 }
 
+static int bnge_hwrm_nq_ring_alloc(struct bnge_net *bn, int index)
+{
+	struct bnge_napi *bnapi = bn->bnapi[index];
+	struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+	struct bnge_ring_struct *ring = &nqr->ring_struct;
+	u32 type = HWRM_RING_ALLOC_NQ;
+	struct bnge_dev *bd = bn->bd;
+	u32 map_idx = ring->map_idx;
+	unsigned int vector;
+	int rc;
+
+	vector = bd->irq_tbl[map_idx].vector;
+	disable_irq_nosync(vector);
+	rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
+	if (rc) {
+		enable_irq(vector);
+		return rc;
+	}
+	bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
+	bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
+	enable_irq(vector);
+	bn->grp_info[index].nq_fw_ring_id = (u16)ring->fw_ring_id;
+	if (!index) {
+		rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
+		if (rc)
+			netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
+	}
+
+	return 0;
+}
+
 static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -1917,30 +1948,9 @@ static int bnge_hwrm_ring_alloc(struct bnge_net *bn)
 
 	agg_rings = !!(bnge_is_agg_reqd(bd));
 	for (i = 0; i < bd->nq_nr_rings; i++) {
-		struct bnge_napi *bnapi = bn->bnapi[i];
-		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
-		struct bnge_ring_struct *ring = &nqr->ring_struct;
-		u32 type = HWRM_RING_ALLOC_NQ;
-		u32 map_idx = ring->map_idx;
-		unsigned int vector;
-
-		vector = bd->irq_tbl[map_idx].vector;
-		disable_irq_nosync(vector);
-		rc = hwrm_ring_alloc_send_msg(bn, ring, type, map_idx);
-		if (rc) {
-			enable_irq(vector);
+		rc = bnge_hwrm_nq_ring_alloc(bn, i);
+		if (rc)
 			goto err_out;
-		}
-		bnge_set_db(bn, &nqr->nq_db, type, map_idx, ring->fw_ring_id);
-		bnge_db_nq(bn, &nqr->nq_db, nqr->nq_raw_cons);
-		enable_irq(vector);
-		bn->grp_info[i].nq_fw_ring_id = (u16)ring->fw_ring_id;
-
-		if (!i) {
-			rc = bnge_hwrm_set_async_event_cr(bd, ring->fw_ring_id);
-			if (rc)
-				netdev_warn(bn->netdev, "Failed to set async event completion ring.\n");
-		}
 	}
 
 	for (i = 0; i < bd->tx_nr_rings; i++) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index b066ee887a09..e0ddb2800c54 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -423,6 +423,21 @@ int bnge_alloc_ctx_mem(struct bnge_dev *bd)
 	return 0;
 }
 
+void bnge_init_nq_ring_struct(struct bnge_net *bn,
+			      struct bnge_nq_ring_info *nqr)
+{
+	struct bnge_ring_mem_info *rmem;
+	struct bnge_ring_struct *ring;
+
+	ring = &nqr->ring_struct;
+	rmem = &ring->ring_mem;
+	rmem->nr_pages = bn->cp_nr_pages;
+	rmem->page_size = HW_CMPD_RING_SIZE;
+	rmem->pg_arr = (void **)nqr->desc_ring;
+	rmem->dma_arr = nqr->desc_mapping;
+	rmem->vmem_size = 0;
+}
+
 void bnge_init_ring_struct(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -431,19 +446,11 @@ void bnge_init_ring_struct(struct bnge_net *bn)
 	for (i = 0; i < bd->nq_nr_rings; i++) {
 		struct bnge_napi *bnapi = bn->bnapi[i];
 		struct bnge_ring_mem_info *rmem;
-		struct bnge_nq_ring_info *nqr;
 		struct bnge_rx_ring_info *rxr;
 		struct bnge_tx_ring_info *txr;
 		struct bnge_ring_struct *ring;
 
-		nqr = &bnapi->nq_ring;
-		ring = &nqr->ring_struct;
-		rmem = &ring->ring_mem;
-		rmem->nr_pages = bn->cp_nr_pages;
-		rmem->page_size = HW_CMPD_RING_SIZE;
-		rmem->pg_arr = (void **)nqr->desc_ring;
-		rmem->dma_arr = nqr->desc_mapping;
-		rmem->vmem_size = 0;
+		bnge_init_nq_ring_struct(bn, &bnapi->nq_ring);
 
 		rxr = bnapi->rx_ring;
 		if (!rxr)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
index bb0c79a1ee60..a5a1d346ac93 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -7,6 +7,7 @@
 struct bnge_ctx_mem_type;
 struct bnge_dev;
 struct bnge_net;
+struct bnge_nq_ring_info;
 
 #define PTU_PTE_VALID             0x1UL
 #define PTU_PTE_LAST              0x2UL
@@ -198,5 +199,6 @@ void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
 int bnge_alloc_ctx_mem(struct bnge_dev *bd);
 void bnge_free_ctx_mem(struct bnge_dev *bd);
 void bnge_init_ring_struct(struct bnge_net *bn);
-
+void bnge_init_nq_ring_struct(struct bnge_net *bn,
+			      struct bnge_nq_ring_info *nqr);
 #endif /* _BNGE_RMEM_H_ */
-- 
2.47.3

