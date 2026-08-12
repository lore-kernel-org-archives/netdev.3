Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E501542123A;
	Wed, 12 Aug 2026 11:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786535610; cv=none; b=bw8XC3c4BR9eFIwkWKN4pbxu0CpVSadJWZBFijDVCArRdD+rfWU2aP5/ndWlCMaJ7QYsypwM/+MgOUoest1TbvCA08KI483SEQwAWJGE113orG6I5hbpIMp23MkAqk9BnpkdmYynceCLhywsIVD1Qw1bAcg5RjRi9ut3f76sJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786535610; c=relaxed/simple;
	bh=PRQMO7dNzrWFOhZqnD7Dq1YcsFGZT63j9O2F+ASzqdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uk9ep8dehRZbw7UID74OnyKCoq+6Iy2R5kU6/qqq9/32VQHDhQHUWNDRlICeKykRDOyhROM4h+lm/knYQNVrtZz+eqNkfNP6qgBNjp5gw0zJfUy4ZcEARsoRf0EhiCWVXHhynRp0sj5z5IB2bBEEwGaHoxgGs4f0KiumIuvlUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Oxv7oW7y; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Oxv7oW7y"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CB16N42370584;
	Wed, 12 Aug 2026 04:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=D
	oLIQJjdWkX0vDd+k15KNARhqWxqIrSgw6SbfTfyHHQ=; b=Oxv7oW7yYhcsugD7T
	hDeTUdauhOEi4GigUn1FcNNQ2b7QBNY0rhb5LBt5z0Ydp8JuK7cIIcqwmaNjwfS0
	H4E8wuZqilQSESu+N60xoDrPqbVMJH42RiAc7HBXPR+BaGJqTaZWldFobhRSz63/
	G83758Z/JKJhbdtquMxHomQjoJNpUS+cPa7a2Ie4BOYbn+wYRudx4Kmonr+kC/jz
	Gvyqyvp0vhPsDqxiF14BOSnYPsAB8A5rWcTchUNklXBwLncT9TvNQ6+gqCFaOVvT
	/zIjyg0iDKwOIRl0/f5UpYYzAcgH6hpiwaPeeP6nGOm4sgCqjtUBYBLMNKwnzJSV
	yWvuw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fyk1hqm10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 04:53:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 12 Aug 2026 04:53:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 12 Aug 2026 04:53:07 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id C3D713F7044;
	Wed, 12 Aug 2026 04:53:03 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v3 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Wed, 12 Aug 2026 17:22:57 +0530
Message-ID: <20260812115258.773319-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812115258.773319-1-subratp@marvell.com>
References: <20260812115258.773319-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfX7U0wKkMBy30p
 8b4/rgL2+jFMYZE5L0IBNu2tGZRMfDMsFQDKrqHCZpInVsVyK2LkfgnGnvwnh8gYHtu15gOXcv9
 KFz9pkkBPzhBYRbFJ6eMEhwoggFXPp0=
X-Proofpoint-ORIG-GUID: sTkw4pfDlYkvYavEolN9Nr1xnHAORZwJ
X-Proofpoint-GUID: sTkw4pfDlYkvYavEolN9Nr1xnHAORZwJ
X-Authority-Analysis: v=2.4 cv=EIQ2FVZC c=1 sm=1 tr=0 ts=6a7c5ea4 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=JC75Ts7hcnNMBKXiZ1QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA5NiBTYWx0ZWRfXwmjuuoNRcJ0n
 OXwMBiu1wNVrEqqS/v31n97iCXd5wDiUsZq8Y/qhvyd+vMgZzYx/XIaJ8+UYObe/Kz0Xt0PQJQJ
 ZTIRe+ZG3tQgpFSl63o6YaFxRqKlFMn4M9bN9sP9TRLfUPsKryCEq4l/UtASwHkKPmUTQ5mFUT0
 b/9FCoTQH38a+cOj74wgIA8uJSXIHnyEWXFruGdjCk796n1cgJqM+tfA9XPM7thqaf9WuDdO+lQ
 3/mDHq2TgPfFoDtLOklMgb69g8yFVyTy+aEHDlLZlZBlfZL3MnrESgP+/IIOrL3zLGFRKznXNqp
 /9djnwzVRJiaTDAC5MC1KLYGGZVRob3Ei/skurc6eBXQ1LdV6jZQR7w+HES9U11hPNJw4n4NUiO
 g8ThJqESi30f4BF72b8RMtBSqMn66AlQEO7bldvbiw9zH+GdSq0bRb0QfWytF14N1bQ+ssLs684
 dPhduGzbqDi6bcaIUgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01

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
v3:
 - Unify BPID index logic into a shared otx2_get_bpid_idx() helper,
   dropping the per-file #ifdef CONFIG_DCB and cn20k_aura_bpid_idx().
 - Drop trailing period from the Fixes: tag.

 .../net/ethernet/marvell/octeontx2/nic/cn20k.c   | 11 +----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.c | 16 ++++++----------
 .../ethernet/marvell/octeontx2/nic/otx2_common.h |  8 ++++++++
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn20k.c
index dbf173196608..65248bb0b61d 100644
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
index 3d253132a17f..142e331cff9e 100644
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
index eecee612b7b2..e6918252cca4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
 	return pfvf->flow_cfg->nr_flows;
 }
 
+static u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
+{
+	if (IS_ENABLED(CONFIG_DCB))
+		return pfvf->queue_to_pfc_map[qidx];
+
+	return 0;
+}
+
 /* MSI-X APIs */
 void otx2_free_cints(struct otx2_nic *pfvf, int n);
 void otx2_set_cints_affinity(struct otx2_nic *pfvf);
-- 
2.43.0

