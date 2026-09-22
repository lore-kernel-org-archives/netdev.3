Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC55349AF;
	Tue, 22 Sep 2026 10:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072584; cv=none; b=HSlvRMwDIT3vTDoxaCfysPjgXMwCyAxfL+78bRpDq2ic5TxZqk2/QHJJFL3iJkVRnpGTKbhoiXdj/+UJb4coRByfzNJQosJ5hlCITrhkYnWFzQhAiaJ2O3PNoPKtmnsBGkTIfMDt+ibauz6t6Y9RESOh4xZpo8cF4LSQfq6kb4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072584; c=relaxed/simple;
	bh=U5A5vVqChUKC2CT0AXy82Zz4amiq11m5Io/qPrM6Qrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrCxd0nAvrprJdmH8ZUFrjjHW0Dvp08K+cmL+MDwbS32mouXLar0VbUYOnIUAtMl/FRyunwzz+an27ww+8sNLRDyPn3aEGF2MsQNQklzPrG1TMA0VyFglAPOi53Wl6u1Ysv1+vBgm2opu8vUQrYNXPpM1bLSCkeg2GIbV/vCn1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=BtnbI1qn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="BtnbI1qn"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M9pfrI2144082;
	Tue, 22 Sep 2026 03:22:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	Pd1xcn+LIZJ2ylHnlOiGl6lO9jAvZDJ2YsA3z3Iwfw=; b=BtnbI1qnEk27DXjEf
	ALBz5Cpn6MRuFy4jjlvUTKcK8tPfDjdY/8+2PR1IPZuowXL1INTHGZcpIDt142w/
	21PuLBbB2JyxDBecLgnPjFur/h09juzkwAR62Mb6GN3zmD8NXxSmRpPTnccRIb+H
	tyI2JfIFn6LztPJlbTx7B2gfgE7w6q8wBLtX6k09Xz3XqaHSjpNUvEVrNiF6hCiF
	F3J86fdepjge+0tJQNggHonDCHUzEdATo5csX3YAIY9x2MDZv8yLPJDj5t28Vbp8
	iy2mXDWNXDwmLrJ3NW3U1KnFRirNEpBaH0YSZ1NAakimHignJW6rmQuTqfruDIFF
	UWq3A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gudhbaf6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 03:22:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 03:21:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 03:21:58 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id A659D3F7080;
	Tue, 22 Sep 2026 03:21:54 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v7 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Tue, 22 Sep 2026 15:51:48 +0530
Message-ID: <20260922102149.2078168-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922102149.2078168-1-subratp@marvell.com>
References: <20260922102149.2078168-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE0OCBTYWx0ZWRfX5gJw/Zry/+Me
 tZMllsUPqEREBlMxLkp8hC1rM/JClSf/17uSOoYa11qYcMFJUl8saaCICjNt6MZV+JWLvq8CiA+
 Cucx/Z5vn7ViYOuWb/KiLUxwtzMQ5ek=
X-Proofpoint-GUID: 1BqYsIPqTjjdtIlNIYRT-IAvUNfT2HbU
X-Proofpoint-ORIG-GUID: 1BqYsIPqTjjdtIlNIYRT-IAvUNfT2HbU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE0OCBTYWx0ZWRfX3gRlq4VX/H3H
 JYfqmCieFv+gyNrbcCcq5D1uOuFtXjq+jGCfLgWL/Z6UNv+HC8Gs++18Fer1zlMH4PlMGDNk83Y
 vo0/PRHbkYJD7b0Nro99gRaTnk3Y/e+MTNPgdckBaMvnt8EK2d82Cb96UJ1av7NRD3q7wZd82UY
 9C2787ydVpNufXiTU2rbN3L91B9pReOU/MLek+QVtGj5yrygJGg/JxD9ZVSpGUNkxM/TNHUY80W
 3e00DyC9mhgxlSootZHD5y10yQ6VyDPNLc/I1cyPhi0gP9j91HhlsgGrrNuSisTq2sZMG3x8oTU
 VXTJI3lZGyUTv+0uv5p4n+ex5dU7vYFUwSe1yuLEhmibpSD6zh9uWDXzD335QLZoBFndplH+3/h
 bsDbYFuLJXfayV3JCinTNtF/xzRmpR+MiYLD4mTPsWoi+Vt+kp9KfiJo7FCoULTTnRdUoq+o9tl
 kLTFFq4kgVpWLqTi32g==
X-Authority-Analysis: v=2.4 cv=EpRHPicA c=1 sm=1 tr=0 ts=6ab256ed cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=JC75Ts7hcnNMBKXiZ1QA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Previously, BPID assignment under CONFIG_DCB assumed
`queue_to_pfc_map` was always initialized. For SDP VFs this leads to
invalid memory access as it was not initialized.

This patch adds a NULL check for `queue_to_pfc_map` before
dereferencing it. Also, simplifies the logic by always assigning a
default BPID first, then conditionally overriding it if CONFIG_DCB is
enabled and the map exists.

Fixes: 184fb40f731b ("octeontx2-pf: Avoid adding dcbnl_ops for LBK and SDP vf")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Signed-off-by: Subrat Pandey <subratp@marvell.com>
---
v7:
 - v6: https://lore.kernel.org/all/20260910062657.3712256-2-subratp@marvell.com/
 - Add NULL check for queue_to_pfc_map in otx2_get_bpid_idx().
v5:
 - Fixing the compilation issue when CONFIG_DCB is
   disabled.
v4:
 - Fix otx2_get_bpid_idx() to be static inline.
v3:
 - Unify BPID index logic into a shared otx2_get_bpid_idx() helper,
   dropping the per-file #ifdef CONFIG_DCB and cn20k_aura_bpid_idx().
 - Drop trailing period from the Fixes: tag.

 .../net/ethernet/marvell/octeontx2/nic/cn20k.c   | 11 +----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.c | 16 ++++++----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h |  9 +++++++++
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index 8e41431c7f9c..e92b77789f08 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
@@ -242,15 +242,6 @@ int cn20k_register_pfvf_mbox_intr(struct otx2_nic *pf, int numvfs)
 
 #define RQ_BP_LVL_AURA   (255 - ((85 * 256) / 100)) /* BP when 85% is full */
 
-static u8 cn20k_aura_bpid_idx(struct otx2_nic *pfvf, int aura_id)
-{
-#ifdef CONFIG_DCB
-	return pfvf->queue_to_pfc_map[aura_id];
-#else
-	return 0;
-#endif
-}
-
 static int cn20k_tc_get_entry_index(struct otx2_flow_config *flow_cfg,
 				    struct otx2_tc_flow *node)
 {
@@ -580,7 +571,7 @@ static int cn20k_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
 			aq->aura.bp_ena = 1;
 
-		bpid_idx = cn20k_aura_bpid_idx(pfvf, aura_id);
+		bpid_idx = otx2_get_bpid_idx(pfvf, aura_id);
 		aq->aura.bpid = pfvf->bpid[bpid_idx];
 
 		/* Set backpressure level for RQ's Aura */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 175992188c18..0f3f405d9f1b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1055,6 +1055,7 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 	struct nix_aq_enq_req *aq;
 	struct otx2_cq_queue *cq;
 	struct otx2_pool *pool;
+	u8 bpid_idx;
 
 	cq = &qset->cq[qidx];
 	cq->cq_idx = qidx;
@@ -1132,11 +1133,8 @@ int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		if (!is_otx2_lbkvf(pfvf->pdev)) {
 			/* Enable receive CQ backpressure */
 			aq->cq.bp_ena = 1;
-#ifdef CONFIG_DCB
-			aq->cq.bpid = pfvf->bpid[pfvf->queue_to_pfc_map[qidx]];
-#else
-			aq->cq.bpid = pfvf->bpid[0];
-#endif
+			bpid_idx = otx2_get_bpid_idx(pfvf, qidx);
+			aq->cq.bpid = pfvf->bpid[bpid_idx];
 
 			/* Set backpressure level is same as cq pass level */
 			aq->cq.bp = RQ_PASS_LVL_CQ(pfvf->hw.rq_skid, qset->rqe_cnt);
@@ -1378,6 +1376,7 @@ int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 {
 	struct npa_aq_enq_req *aq;
 	struct otx2_pool *pool;
+	u8 bpid_idx;
 	int err;
 
 	pool = &pfvf->qset.pool[pool_id];
@@ -1433,11 +1432,8 @@ int otx2_aura_aq_init(struct otx2_nic *pfvf, int aura_id,
 		 */
 		if (pfvf->nix_blkaddr == BLKADDR_NIX1)
 			aq->aura.bp_ena = 1;
-#ifdef CONFIG_DCB
-		aq->aura.nix0_bpid = pfvf->bpid[pfvf->queue_to_pfc_map[aura_id]];
-#else
-		aq->aura.nix0_bpid = pfvf->bpid[0];
-#endif
+		bpid_idx = otx2_get_bpid_idx(pfvf, aura_id);
+		aq->aura.nix0_bpid = pfvf->bpid[bpid_idx];
 
 		/* Set backpressure level for RQ's Aura */
 		aq->aura.bp = RQ_BP_LVL_AURA;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index eecee612b7b2..44cd56a0c2c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1029,6 +1029,15 @@ static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
 	return pfvf->flow_cfg->nr_flows;
 }
 
+static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
+{
+#ifdef CONFIG_DCB
+	if (pfvf->queue_to_pfc_map)
+		return pfvf->queue_to_pfc_map[qidx];
+#endif
+	return 0;
+}
+
 /* MSI-X APIs */
 void otx2_free_cints(struct otx2_nic *pfvf, int n);
 void otx2_set_cints_affinity(struct otx2_nic *pfvf);
-- 
2.43.0

