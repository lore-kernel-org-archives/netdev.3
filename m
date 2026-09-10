Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309F93C3F6B;
	Thu, 10 Sep 2026 06:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021636; cv=none; b=Jy6cgFS2LAaBRN22rrhK+xELfW0bzE8X2QCyq6YHxn/e2Kw/XrCXRKd7LyxEtLhItTDvHqF1a7CgipJOm2inSrh5Vx14PyNHanERDCZVUDh2IIVAlHstcER/PqIbl1zLm2/Fw8VcuZl/6V6k+sXdA7KqREUGjL4d54QjqK1ugWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021636; c=relaxed/simple;
	bh=Tgqbh+Ldz/a9FM/78Q8woUXEHCC7Rz/NP3IalInBWvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V51v3POqIQ9Rn18rU23GJEqFs43pZXYsALLSlvQN1v9VRMzS3ttJym95ppFbU4XF4wOjR/PNw0ynOvgEFa3bbIXiacWF+K2mmnfdlNNdGNWQ5KAvOIrSWKne3Iyio8Urzqhl1huhSlUlbjkn6fSjVpm8+dadMkbognvgJTo0aNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e4odI8jM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e4odI8jM"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Gpo5266800;
	Wed, 9 Sep 2026 23:27:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	lvOJoSt9SkIaECTQ7rKn/Phq8C6ztfv8Vfr5PUHE/o=; b=e4odI8jMXYTITf3r8
	a6tsQQJFt4n2t9tnuriQb/vzy8brqSTtBPZrMWvT5ysoC/Q7fptAX+j97RcpuJeD
	j4senTF5v7+kMEy/4Oq6RpgfSDB4r0u/tF9s9zUnuxTTh05M+wkODvVrklhb16wy
	4tY6QrC3gp7ZrvEkglFkVMQ2AtvFHtLO/4/aURR19eYZop51LRo+cIzu9dFo2COb
	ujsmsjDuscYXw5PIDrj3LwuKJ//AknGUEyHLp4tFzU8W+6uCljCf1xJHtre/giv3
	xdrZUg1ZZCsKyx+GNq/UxNvNSoTNt/8szqo6UTvD0vYeBncOF+jgZxKl2BmFc5m5
	wX3+A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4gkcxntcaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 23:27:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 9 Sep 2026 23:27:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 9 Sep 2026 23:27:06 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 79D6C3F7063;
	Wed,  9 Sep 2026 23:27:02 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v6 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Thu, 10 Sep 2026 11:56:56 +0530
Message-ID: <20260910062657.3712256-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910062657.3712256-1-subratp@marvell.com>
References: <20260910062657.3712256-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=K923jCWI c=1 sm=1 tr=0 ts=6aa24dba cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=JC75Ts7hcnNMBKXiZ1QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: G9OA4TyOauVouSJ21a7sW4Q77fYgSqd_
X-Proofpoint-GUID: G9OA4TyOauVouSJ21a7sW4Q77fYgSqd_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA2NiBTYWx0ZWRfX3qeihwa9DiK8
 ITFNAhq9tHM3bE9Cd4dIi3KPqjRszlDmyoQPrhD7CDuaqPElO7jUyd414T1YXCludKtwXRmzCge
 5qOUXyfNeshWmc1hVLHMwHpI5y6CmCo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA2NiBTYWx0ZWRfXxBXE97k7/Y69
 ASxJLjoXMQsdDfZhjvN9ku9TbbCaAKdM+DPF5X83VOc3DcWnOeCxE0qUxbDRHwFtSVseDHYynt1
 VJBFGTFYdarGbW+WeRmi9y/D8OUOy7ikIhxXgN0VSdioVXNjdBT+KMi8QJ0+T3AIdAj4n3tWxRX
 Qh+mjEGoj2t5JaNdSmzDNtQOFa+9Jjf7yMWRS2HxiO3mIlrUrk2WL5XHTGRevjk/EOJoze7qBjn
 Fior+HWA3nvD8GX7RvwD79YmTf+bcVtmURMI0mDkXvY0N3Tk2OWSgP0z6W4vcfmOX8v3I0SuZCf
 NK99WwAGpAy3RAepSU9VsynYkYoHsN5yp3vlihgtcsLn18yD88V+HGRqkqlZG2zV8qNMwkQ459a
 /bzzAuegbfNga51kOTjWpodOzMvN5gfYZmgFpmRuKvmioAMh1olmF5n+wyV9O4T3uU7YmleGVpp
 onRMose9vXuXwoX16tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01

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
 .../ethernet/marvell/octeontx2/nic/otx2_common.h |  8 ++++++++
 3 files changed, 15 insertions(+), 20 deletions(-)

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
index eecee612b7b2..2a63d22cbd8d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
 	return pfvf->flow_cfg->nr_flows;
 }
 
+static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
+{
+#ifdef CONFIG_DCB
+	return pfvf->queue_to_pfc_map[qidx];
+#endif
+	return 0;
+}
+
 /* MSI-X APIs */
 void otx2_free_cints(struct otx2_nic *pfvf, int n);
 void otx2_set_cints_affinity(struct otx2_nic *pfvf);
-- 
2.43.0

