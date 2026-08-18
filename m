Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8783C1D41;
	Tue, 18 Aug 2026 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044303; cv=none; b=Lks2aYnS4CRFcyr7hl9EpxztNAVnxM7a8FKyHwGZx/yc7zOgwSiA806tee06AGJw7tUXpoJrAF8tR16YsZiGsK2lEkSXsyBe2wr3NeGpxG8KSOXtBaxSP2vxAAQhlocnVsnrs3IT6wKbHqzAKHWXmzZS7MycNjNUe0je8GwIjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044303; c=relaxed/simple;
	bh=P3R3d2TyagJr1LKTwbT+3fSq6kfhVRLZsLxtC5uffmw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKPxgkHqtE76vJaAdihIzD8VvSEBSgue9PMaDWssr0hO4oGnq3yn8aP7vLk0VAKjBbqWCn0b8Yrl4IRVPd+SVKbB2muc92Y+1aDG4x5wi7gkB1GknaOL6LxIgyA+9+uQ3QDecTCUB0+4PPwOdmOu8psSEyq+Fu+JmdgW1dUtpSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TAUqBk68; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="TAUqBk68"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HLwrr03314065;
	Tue, 18 Aug 2026 02:11:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=y
	DyclZYfQbyoMme82miagzFW7P5e+Dz8w1Lu8FZP7b8=; b=TAUqBk68VbeLeWXwN
	VyRL/2oSLZ5EE3p8uUbPibcTAGHuZE4TlPQPmvsIMdFxz8C3jC3vDWzTiL5rJTx3
	CsbkuOiSwlqznQ+DmlyBG2j5hJ5cgbHrV2qAPFfIlpTN8FrmZbuOrW4rqKWYiwgi
	p0LpnO1QF4DcDvSQFO6MUH9820OtmpZ1HG3i+lIRDOQy94yuTi4S+rBKjmgvdZpa
	/r4B3wZ+NUk+D8SV67CYhTOHezGl79nrKNFBCOddugCzj9OqPX5ROcPZIMvEJId4
	67iYSpz0E3tsPVUM1huABq9yM56+vubzoOu9eDFfwpERuecybmOJL3w7UqAd8kmI
	6Fypg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4g36v3dp86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 02:11:33 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 18 Aug 2026 02:11:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 18 Aug 2026 02:11:33 -0700
Received: from numbat.caveonetworks.com (unknown [10.29.36.45])
	by maili.marvell.com (Postfix) with ESMTP id 585973F7080;
	Tue, 18 Aug 2026 02:11:29 -0700 (PDT)
From: Subrat Pandey <subratp@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <sbhatta@marvell.com>,
        <rkannoth@marvell.com>, <gakula@marvell.com>, <sgoutham@marvell.com>,
        <subratp@marvell.com>
Subject: [PATCH net v4 1/2] octeontx2-pf: Fix aura BPID assignment when CONFIG_DCB is enabled
Date: Tue, 18 Aug 2026 14:41:22 +0530
Message-ID: <20260818091124.1832237-2-subratp@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818091124.1832237-1-subratp@marvell.com>
References: <20260818091124.1832237-1-subratp@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA2NyBTYWx0ZWRfX4D/2HuAy3QlL
 scaTs9YJb6vu/ftJYfGYpt0xWgmZYKwT+sZNuuByghRFETyXuAfWrpTSc5cekKP1j6KQuqVQKcD
 K9E3fE9+4ikXRam5/kHrFLGsYmPMF34=
X-Proofpoint-ORIG-GUID: 8x2la--9xocYq84G5oyEI3v6MLB9ErQ4
X-Authority-Analysis: v=2.4 cv=MatcfZ/f c=1 sm=1 tr=0 ts=6a8421c5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=JC75Ts7hcnNMBKXiZ1QA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 8x2la--9xocYq84G5oyEI3v6MLB9ErQ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA2NyBTYWx0ZWRfX7zOapcBhy+wC
 +52E64QUyBbO8TDq2MnFyutah/4oYltrOG3e5BKCK4xsysJxpuaAwrKFwii94OkbH5tc9g7kzV2
 uCGlP3Yk2ycN+fbA41ZS/dMgmIUEBpkkv2FKNrx2LtUnLa/kAJp+XyLVjG3nrYP7jy6TZ2uL6Jh
 q9t15PPGcopetKtFdcM23LAHImoJIHyvzWgJ/oJUyi5p9A5CRwiPeGRofxy+J22D6qWygrc1y9/
 YihOGXbJ/gBSLVEK2hkUvAiorcKPM7P09xSWz+HWffcZdgr5j5wPHBHqtxYLDGUvrZrhnTDUdsT
 vq9FyaC/ro7z5w2URDL5TBwjUOvV69z+xkQgONLbm/Xgctrbsa0rB86JYeh4WnM7XvZl+Xn0FwJ
 xLt1sWCfzhQQNW078CTsY6Umi27bk4MZ8H3w+gduinlYQU9lkjRhuMNwK16FWSwEBXyNVkSIznc
 oImOuVlh/7rBgU160gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01

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
index eecee612b7b2..f39b293cc837 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -1029,6 +1029,14 @@ static inline int otx2_tc_flower_rule_cnt(struct otx2_nic *pfvf)
 	return pfvf->flow_cfg->nr_flows;
 }
 
+static inline u8 otx2_get_bpid_idx(struct otx2_nic *pfvf, int qidx)
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

