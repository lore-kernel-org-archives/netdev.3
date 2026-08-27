Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C2143D4E9;
	Thu, 27 Aug 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787824039; cv=none; b=Tg5aNJ6ofBxMq3087ZNGobkF763LeXsbyuWUE0Qdfz8PVYiL+0kQ4Bgfc8ATjoWow2aU3SX+HuRtxFxP72hQBCVv9mu+DuV9nmXmEyEF6s6iuRv1wWxOX9HS3ZdMpfEXbEpe8WEgtq88qqvN33NI7q9xTKM4jD/ZQ3x2cZhx6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787824039; c=relaxed/simple;
	bh=Tgqbh+Ldz/a9FM/78Q8woUXEHCC7Rz/NP3IalInBWvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3lSRG2zDHCO8foYgHbsa1Xj40Lb2cBg6JbecT6PQNF3wtR/qcfiBssB2TlPFgI8x6byVFFbVBUAn90I9e45RVhOnpAndqEkEkdFOA8CZkI7YmuDwnOjic8shbzB2CqHzFp7/5k3e4IAilO0hq4b/OHyaRgMh6hPwx7hP2up0r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TpDUoGxK; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TpDUoGxK"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9GmSk2837941;
	Thu, 27 Aug 2026 02:47:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=o
	lvOJoSt9SkIaECTQ7rKn/Phq8C6ztfv8Vfr5PUHE/o=; b=TpDUoGxK/wTqqlPvY
	0nnASEisR976X7Y4l7tzg1T6QSABeDM6Ung3ZW96f6QK++4iC3oy/53jJaBKe2lT
	TwviLTpt1QOUVvT3LAfXeduaoGvfA3MrK44Kcqo0GeLM2Xml2b9NjNSGlr/OVxB7
	F8A2tnTHlh9iQJx4v01zAMO32tzBXU32hEJTOYE0rkxlEctFqUOd0+rkgXtFfjc0
	QYxgiZLCP4d6TqrMNDRnps/tZ2yxqdQZh3F/7pAQZXN49rEmg7Ad8Vh0ZTzVKTrG
	HOl4dBSW9Xvfa4CFlNJoBaNfl/hhDPM/mMMmMfzZqa2T3XS3kz03RvAO2hpxrU1A
	1UsRg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ga5dt2hvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 02:47:04 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 27 Aug 2026 02:47:03 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 27 Aug 2026 02:47:03 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id F31413F70C4;
	Thu, 27 Aug 2026 02:46:59 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v5 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Thu, 27 Aug 2026 15:16:53 +0530
Message-ID: <20260827094654.1391105-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827094654.1391105-1-subratp@marvell.com>
References: <20260827094654.1391105-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9xHeuI0FGSahmDOCei2M3kJlRJnARGXz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4MCBTYWx0ZWRfX0rlILNG0EZKq
 BPbB6CZnPCaf9HQ60hYA9j24OUHMzLIs4nsGtUboAoCV3QVooWvFk2qLG+VgUatczbBWuTbuPO0
 aKd2ndIAK9qixMX5/9uFLZuesBh7/K8=
X-Authority-Analysis: v=2.4 cv=W6sIkxWk c=1 sm=1 tr=0 ts=6a900798 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=JC75Ts7hcnNMBKXiZ1QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 9xHeuI0FGSahmDOCei2M3kJlRJnARGXz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4MCBTYWx0ZWRfX3DvwARq2TGuN
 Fou3yt6ZXD0o8BWpap5EA9fm86T2adIFcCXlrgzB5n9WxogYPTNwMt9dxS95ODvTJkohKdAWEJT
 NyorLvHPx3m1XrtY3aLr/66Gy4YagKRBGA6BV+csI7BwLQRg60ZjtGBNpLi5DjBtiBiu/RyTdOZ
 BssmDstJ9NkKyCjNsNSM7TkTELgWQsjDw2luolwmO1Zl9rxkV/ZyAWYvICFRFTiQSx61c9dUrv3
 YC13s9krmluN4Dt1KdLeW/y80P0b2zUsNrT+DmwPZzmJy6IEz6/zj7YiYfSN6V3AzQyIdLFkUjb
 EGLCia6fhY1qCcDvKRETNzTu6vS242PH6JT0YcIBfwn9LmV/byW+UClS2DFM203aq4rLqMaCXZa
 gk2YUcewc/J8XFwbVtJDsBGm5hqvYuJgwfMX4gfjpsoQnXdVSbhIAySaElG8AzdjDX5hobghgv8
 1LtTi1o9u6xDf5KZ4Ew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01

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

