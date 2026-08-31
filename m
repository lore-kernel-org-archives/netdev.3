Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2AC337BB8;
	Mon, 31 Aug 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182424; cv=none; b=acT0qQHT2HIzMmoWhPIMVsW5zML42/nE8D+b5GhrieIjzPhJhdY2Sh5CvXdP0E7XrXxlfS175kH60j7I6rS9jpyZOmR4+u6G4I+cTnmMSzZ9R4wHwrMRgH0VuiM9WtdJdLQPCFUBL3GtfpHRUpLi+sFQxEtIC1ihIVsI57jqX8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182424; c=relaxed/simple;
	bh=lDMXHtFAJhf3uJoultITaoUwhGMGlldnC9S2h3wi3U4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMpa6UqRfa6qXEGoa97xcxaW2Cy0m8DVzL4PiTq/vg7MBLrtuDXqMcuvPslfsO3PVgkPULb0Y14re34HPf3sE5x7Y43W1nNkCijUcnCCPZVaF3pxJlyoB10zr6zK9m0Dps71hef2nONbSw+ZldOEFWMHwDAtQzUCrXfGrkcmR54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MllY4RWd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MllY4RWd"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBCPT11195810;
	Mon, 31 Aug 2026 06:20:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=m
	Kt6IHe6ZzusWYOyV8Juqk87amk14y07U1dpuQLZSm8=; b=MllY4RWdTt7BNqb3r
	7lXR+Foz7g9DJhHBOVXWCAXeFbQuKYu/EmOFyRhBV+hlCGz4OtzZfgR+AXD7E9+t
	nK0HxCVUAIX470f7NkH3DtoZCxAuU8HWlky/y13UuVJClZB/wVOw2m5wGX2ehSDb
	TI/u/5sUm5rerDQVnn9Fb45hmvZ4+YF5x6oyrEB1yPTdAvmSfwGJ/sLAPj85aiH1
	jWsaJ3+hw+sGHoIwzzn/oRfCzdnZQV2pyFbBpd2G/ERBLQrMIg3dNzdxM3rHff0H
	pR+wNIrulIEhHEHvR4rFXLa7xLFETIAxNipbeb4jnKYXJNfKZmoViNBhrNDf6xFn
	KsH8g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj3y9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:20:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:20:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:20:11 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id A0D5C3F709A;
	Mon, 31 Aug 2026 06:20:08 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v9 net-next 5/8] octeontx2-af: switch: TL1 scheduling and NPC channel control
Date: Mon, 31 Aug 2026 18:49:41 +0530
Message-ID: <20260831131944.2649362-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831131944.2649362-1-rkannoth@marvell.com>
References: <20260831131944.2649362-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX6gcDgoxWWi+6
 5o3pcHHxurKEsFtMGel9DCHDzev0fQpM8ADYONegPqogC4ghRI2TvtnfZk9ud+KtSfNX3tgchYD
 pcA1LInIvWjnEn37L23OyhPdOIUNESI=
X-Proofpoint-GUID: YtBqCY8y0LLLXorzKdKq1KxiMucfPAec
X-Proofpoint-ORIG-GUID: YtBqCY8y0LLLXorzKdKq1KxiMucfPAec
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX8LiTe5yJzHHw
 tyVVgallScu8dWcw9neXVRvN7LLPpUgjKCyCdv+3bUCNkm8J1gDBiYd/VmhN4AynOBMoKF7GJcU
 aiqY49EHw4k2x9PyhOFznnJBnKkJe72Ahpcta920mfpW/wqvn6BS9ymUC63WSVE6N1r82I4ApwL
 owfutm+wZGjojGbn5ZOZa5bWswLn6eElVeqJvusklxcvZ2OSM0xUTb2B/+dvb8olkIApvMX2tBR
 K14d8luVY9vVIP/JvxxILT2XuKjFOksbeq5iW9XPN+Og3LG6+xxHjSmXWjKKgzXyqFaLAUSnkD8
 EScOfQ23p2YLXjqfWYCYmlxXwroji5GG62Yva0nHV9W/J2b37BdkEt+SghHidQsB+mB66paip2p
 K7wL/CqHf4qcntNg8X9IOnoWvPPDrT9QGmleTPzZj78H6XhuHRPXpdFnwJVbK3D5eSvpEbSq4q5
 LGUCdqgiuk2X5VVcWUQ==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a957f8c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=aWKLgiLATfyQSygvAMkA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

Switch (PAN) mode needs more than one TL1 scheduler queue index so the
hardware can steer traffic to different links according to NPC flow
rules, not only the PF/VF default Tx link.
Add NIX_TXSCH_ALLOC_FLAG_PAN to nix_txsch_alloc requests: use the PAN
link index for scheduler range calculation, allow multiple TL1 queues
when the aggregate level spans start..end, and allocate indices in
that range. Add TXSCHQ_FREE_PAN_TL1 so TL1 entries in that path can be
freed via nix_txsch_free where they were previously skipped.
For NPC install flow, add set_chanmask so callers can keep a non-default
chan_mask when the requester is not the AF; without it, chan_mask was
always forced to 0xFFF for non-AF functions.
Allocate the NIX LF SQ bitmap with the same span used by
bitmap_weight(..., BITS_PER_LONG * 16) in rvu_get_hwinfo().
Extend struct sg_list with cq_idx and len for transmit-side metadata.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  15 ++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  24 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 180 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  20 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   2 +
 6 files changed, 216 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 8e3850f33751..2aa1aa6599a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1162,6 +1162,13 @@ struct nix_txsch_alloc_req {
 	/* Scheduler queue count request at each level */
 	u16 schq_contig[NIX_TXSCH_LVL_CNT]; /* No of contiguous queues */
 	u16 schq[NIX_TXSCH_LVL_CNT]; /* No of non-contiguous queues */
+	/* Set only by the single switchdev PF (rvu->rswitch.pcifunc). This is
+	 * not the eswitch representor (rvu->rep_pcifunc). That PF requests two
+	 * aggregate-level TL2 queues on the PAN link, one for CGX and one for
+	 * SDP steering. No other PF or VF sets this flag.
+	 */
+#define NIX_TXSCH_ALLOC_FLAG_PAN BIT(0)
+	u32 flags;
 };
 
 struct nix_txsch_alloc_rsp {
@@ -1180,6 +1187,10 @@ struct nix_txsch_alloc_rsp {
 struct nix_txsch_free_req {
 	struct mbox_msghdr hdr;
 #define TXSCHQ_FREE_ALL BIT_ULL(0)
+	/* Frees PAN TL2 queues allocated with NIX_TXSCH_ALLOC_FLAG_PAN. Used
+	 * only by the switchdev PF (rvu->rswitch.pcifunc), not by other PFs/VFs.
+	 */
+#define TXSCHQ_FREE_PAN_TL1 BIT_ULL(1)
 	u16 flags;
 	/* Scheduler queue level to be freed */
 	u16 schq_lvl;
@@ -2135,6 +2146,10 @@ struct npc_install_flow_req {
 	u8 hw_prio;
 	u8  req_kw_type; /* Key type to be written */
 	u8 alloc_entry;	/* only for cn20k */
+	/* When set, keep caller chan_mask instead of the CPT default. Only
+	 * honored for the switchdev PF; see rvu_mbox_handler_npc_install_flow().
+	 */
+	u8 set_chanmask;
 /* For now use any priority, once AF driver is changed to
  * allocate least priority entry instead of mid zone then make
  * NPC_MCAM_LEAST_PRIO as 3
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 1402beccf661..e4d13adc2896 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1990,11 +1990,12 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
-static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
-				struct iface_info *info)
+static void rvu_iface_get_qcnts(struct rvu *rvu, u16 pcifunc,
+				struct rvu_pfvf *pfvf, struct iface_info *info)
 {
 	struct admin_queue *aq;
 	unsigned long flags;
+	int sq_bmap_bits;
 
 	info->sq_cnt = 0;
 	info->cq_cnt = 0;
@@ -2006,9 +2007,18 @@ static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
 
 	spin_lock_irqsave(&aq->lock, flags);
 
-	/* Use each LF queue context size; bitmaps are sized to qsize longs. */
-	if (pfvf->sq_ctx && pfvf->sq_bmap)
-		info->sq_cnt = bitmap_weight(pfvf->sq_bmap, pfvf->sq_ctx->qsize);
+	if (pfvf->sq_bmap) {
+		/* Match switchdev sq_bmap allocation size in nix_lf_alloc(). */
+		if (rvu_is_switch_pcifunc(rvu, pcifunc))
+			sq_bmap_bits = NIX_SQ_BMAP_BITS;
+		else if (pfvf->sq_ctx)
+			sq_bmap_bits = pfvf->sq_ctx->qsize;
+		else
+			sq_bmap_bits = 0;
+
+		if (sq_bmap_bits)
+			info->sq_cnt = bitmap_weight(pfvf->sq_bmap, sq_bmap_bits);
+	}
 	if (pfvf->cq_ctx && pfvf->cq_bmap)
 		info->cq_cnt = bitmap_weight(pfvf->cq_bmap, pfvf->cq_ctx->qsize);
 	if (pfvf->rq_ctx && pfvf->rq_bmap)
@@ -2072,7 +2082,7 @@ int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
 		if (is_sdp_pfvf(rvu, pcifunc))
 			info->is_sdp = 1;
 
-		rvu_iface_get_qcnts(rvu, pfvf, info);
+		rvu_iface_get_qcnts(rvu, pcifunc, pfvf, info);
 
 		if (pfvf->nix_blkaddr == BLKADDR_NIX0)
 			info->nix = 0;
@@ -2105,7 +2115,7 @@ int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
 			if (is_sdp_pfvf(rvu, pcifunc))
 				info->is_sdp = 1;
 
-			rvu_iface_get_qcnts(rvu, pfvf, info);
+			rvu_iface_get_qcnts(rvu, pcifunc, pfvf, info);
 
 			if (pfvf->nix_blkaddr == BLKADDR_NIX0)
 				info->nix = 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9174b879850a..0b0ba1350922 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -335,6 +335,7 @@ struct nix_txsch {
 	u8   lvl;
 #define NIX_TXSCHQ_FREE		      BIT_ULL(1)
 #define NIX_TXSCHQ_CFG_DONE	      BIT_ULL(0)
+#define NIX_SQ_BMAP_BITS	      (BITS_PER_LONG * 16)
 #define TXSCH_MAP_FUNC(__pfvf_map)    ((__pfvf_map) & 0xFFFF)
 #define TXSCH_MAP_FLAGS(__pfvf_map)   ((__pfvf_map) >> 16)
 #define TXSCH_MAP(__func, __flags)    (((__func) & 0xFFFF) | ((__flags) << 16))
@@ -904,6 +905,11 @@ static inline bool is_pffunc_af(u16 pcifunc)
 	return !pcifunc;
 }
 
+static inline bool rvu_is_switch_pcifunc(struct rvu *rvu, u16 pcifunc)
+{
+	return rvu->rswitch.pcifunc && pcifunc == rvu->rswitch.pcifunc;
+}
+
 static inline bool is_rvu_fwdata_valid(struct rvu *rvu)
 {
 	return (rvu->fwdata->header_magic == RVU_FWDATA_HEADER_MAGIC) &&
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index b8f4ad160afc..9ee6531afbf9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1104,6 +1104,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	u16 pcifunc = req->hdr.pcifunc;
 	int nixlf, blkaddr, rc = 0;
 	struct nix_aq_inst_s inst;
+	u64 sq_bmap_bits, max_q;
 	struct rvu_block *block;
 	struct admin_queue *aq;
 	struct rvu_pfvf *pfvf;
@@ -1138,10 +1139,25 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 		if (!pfvf->rq_ctx || req->qidx >= pfvf->rq_ctx->qsize)
 			rc = NIX_AF_ERR_AQ_ENQUEUE;
 		break;
-	case NIX_AQ_CTYPE_SQ:
-		if (!pfvf->sq_ctx || req->qidx >= pfvf->sq_ctx->qsize)
+	case NIX_AQ_CTYPE_SQ: {
+		if (!pfvf->sq_ctx) {
+			rc = NIX_AF_ERR_AQ_ENQUEUE;
+			break;
+		}
+
+		/* Switchdev PF uses a fixed sq_bmap (NIX_SQ_BMAP_BITS); cap qidx
+		 * to that span so __set_bit() cannot run past the allocation.
+		 * nix_lf_alloc() also rejects sq_cnt above NIX_SQ_BMAP_BITS.
+		 */
+		sq_bmap_bits = rvu_is_switch_pcifunc(rvu, pcifunc) ?
+			       NIX_SQ_BMAP_BITS :
+			       (u64)pfvf->sq_ctx->qsize * BITS_PER_LONG;
+		max_q = min_t(u64, pfvf->sq_ctx->qsize, sq_bmap_bits);
+
+		if ((u64)req->qidx >= max_q)
 			rc = NIX_AF_ERR_AQ_ENQUEUE;
 		break;
+	}
 	case NIX_AQ_CTYPE_CQ:
 		if (!pfvf->cq_ctx || req->qidx >= pfvf->cq_ctx->qsize)
 			rc = NIX_AF_ERR_AQ_ENQUEUE;
@@ -1566,18 +1582,28 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	struct qmem *rq_ctx, *sq_ctx, *cq_ctx;
 	u16 bcast, mcast, promisc, ucast;
 	struct rvu_hwinfo *hw = rvu->hw;
+	u64 cfg, ctx_cfg, sq_bmap_bits;
 	u16 pcifunc = req->hdr.pcifunc;
 	u8 cgx_id = 0, lmac_id = 0;
 	bool rules_created = false;
 	struct rvu_block *block;
 	struct rvu_pfvf *pfvf;
 	struct cgx *cgxd;
-	u64 cfg, ctx_cfg;
 	int blkaddr;
 
 	if (!req->rq_cnt || !req->sq_cnt || !req->cq_cnt)
 		return NIX_AF_ERR_PARAM;
 
+	/* Switchdev PF sq_bmap is fixed at NIX_SQ_BMAP_BITS; reject larger
+	 * sq_cnt before allocating context memory or the bitmap.
+	 */
+	sq_bmap_bits = rvu_is_switch_pcifunc(rvu, pcifunc) ?
+		NIX_SQ_BMAP_BITS :
+		(u64)req->sq_cnt * BITS_PER_LONG;
+
+	if ((u64)req->sq_cnt > sq_bmap_bits)
+		return NIX_AF_ERR_PARAM;
+
 	if (req->way_mask)
 		req->way_mask &= 0xFFFF;
 
@@ -1660,7 +1686,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (rc)
 		goto free_mem;
 
-	sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	if (rvu_is_switch_pcifunc(rvu, pcifunc))
+		/* Fixed-size bitmap; sq_cnt capped to NIX_SQ_BMAP_BITS above. */
+		sq_bmap = kcalloc(BITS_TO_LONGS(NIX_SQ_BMAP_BITS),
+				  sizeof(long), GFP_KERNEL);
+	else
+		sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
 	if (!sq_bmap) {
 		qmem_free(rvu->dev, sq_ctx);
 		rc = -ENOMEM;
@@ -2209,6 +2240,25 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
 	}
 }
 
+static int nix_get_pan_tx_link(struct rvu *rvu)
+{
+	struct rvu_hwinfo *hw = rvu->hw;
+
+	return hw->cgx_links + hw->lbk_links + 1;
+}
+
+static bool nix_txsch_is_pan_schq(struct rvu *rvu, int schq)
+{
+	int pan_link = nix_get_pan_tx_link(rvu);
+
+	return schq >= pan_link && schq <= pan_link + 1;
+}
+
+static bool nix_txsch_pan_allowed(struct rvu *rvu, u16 pcifunc)
+{
+	return rvu_is_switch_pcifunc(rvu, pcifunc);
+}
+
 static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 				      struct nix_hw *nix_hw,
 				      struct nix_txsch_alloc_req *req)
@@ -2224,12 +2274,27 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	if (!req_schq)
 		return 0;
 
-	link = nix_get_tx_link(rvu, pcifunc);
+	if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) {
+		if (!nix_txsch_pan_allowed(rvu, pcifunc))
+			return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		link = nix_get_pan_tx_link(rvu);
+	} else {
+		link = nix_get_tx_link(rvu, pcifunc);
+	}
 
 	/* For traffic aggregating scheduler level, one queue is enough */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
-		if (req_schq != 1)
+		if (req_schq != 1 && !(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN))
 			return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		if (req->schq[lvl] > MAX_TXSCHQ_PER_FUNC ||
+		    req->schq_contig[lvl] > MAX_TXSCHQ_PER_FUNC)
+			return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) {
+			if (link >= txsch->schq.max || link + 1 >= txsch->schq.max)
+				return NIX_AF_ERR_TLX_ALLOC_FAIL;
+			if (req_schq > 2)
+				return NIX_AF_ERR_TLX_ALLOC_FAIL;
+		}
 		return 0;
 	}
 
@@ -2258,9 +2323,9 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
 	return 0;
 }
 
-static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
-			    struct nix_txsch_alloc_rsp *rsp,
-			    int lvl, int start, int end)
+static int nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
+			   struct nix_txsch_alloc_rsp *rsp,
+			   int lvl, int start, int end)
 {
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = rsp->hdr.pcifunc;
@@ -2270,6 +2335,46 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 	 * on transmit link to which PF_FUNC is mapped to.
 	 */
 	if (lvl >= hw->cap.nix_tx_aggr_lvl) {
+		if (start != end) {
+			int want_contig = rsp->schq_contig[lvl];
+			int got_contig = 0, got = 0;
+			int want = rsp->schq[lvl];
+
+			for (schq = start; schq <= end; schq++) {
+				if (test_bit(schq, txsch->schq.bmap))
+					continue;
+
+				if (got_contig < want_contig) {
+					set_bit(schq, txsch->schq.bmap);
+					rsp->schq_contig_list[lvl][got_contig++] = schq;
+					continue;
+				}
+
+				if (got < want) {
+					set_bit(schq, txsch->schq.bmap);
+					rsp->schq_list[lvl][got++] = schq;
+				}
+			}
+
+			rsp->schq_contig[lvl] = got_contig;
+			rsp->schq[lvl] = got;
+
+			if (got_contig < want_contig || got < want) {
+				for (idx = 0; idx < got_contig; idx++)
+					clear_bit(rsp->schq_contig_list[lvl][idx],
+						  txsch->schq.bmap);
+				for (idx = 0; idx < got; idx++)
+					clear_bit(rsp->schq_list[lvl][idx],
+						  txsch->schq.bmap);
+				rsp->schq_contig[lvl] = 0;
+				rsp->schq[lvl] = 0;
+				dev_err(rvu->dev,
+					"Could not allocate schq at lvl=%u start=%u end=%u\n",
+					lvl, start, end);
+				return -ENOMEM;
+			}
+			return 0;
+		}
 		/* A single TL queue is allocated */
 		if (rsp->schq_contig[lvl]) {
 			rsp->schq_contig[lvl] = 1;
@@ -2284,7 +2389,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			rsp->schq[lvl] = 1;
 			rsp->schq_list[lvl][0] = start;
 		}
-		return;
+		return 0;
 	}
 
 	/* Adjust the queue request count if HW supports
@@ -2296,7 +2401,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		if (idx >= (end - start) || test_bit(schq, txsch->schq.bmap)) {
 			rsp->schq_contig[lvl] = 0;
 			rsp->schq[lvl] = 0;
-			return;
+			return 0;
 		}
 
 		if (rsp->schq_contig[lvl]) {
@@ -2309,7 +2414,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			set_bit(schq, txsch->schq.bmap);
 			rsp->schq_list[lvl][0] = schq;
 		}
-		return;
+		return 0;
 	}
 
 	/* Allocate contiguous queue indices requesty first */
@@ -2340,6 +2445,8 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		/* Update how many were allocated */
 		rsp->schq[lvl] = idx;
 	}
+
+	return 0;
 }
 
 int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
@@ -2364,6 +2471,10 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 	if (!nix_hw)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
+	if ((req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) &&
+	    !nix_txsch_pan_allowed(rvu, pcifunc))
+		return NIX_AF_ERR_TLX_ALLOC_FAIL;
+
 	mutex_lock(&rvu->rsrc_lock);
 
 	/* Check if request is valid as per HW capabilities
@@ -2386,11 +2497,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 		rsp->schq[lvl] = req->schq[lvl];
 		rsp->schq_contig[lvl] = req->schq_contig[lvl];
 
-		link = nix_get_tx_link(rvu, pcifunc);
+		if (req->flags & NIX_TXSCH_ALLOC_FLAG_PAN)
+			link = nix_get_pan_tx_link(rvu);
+		else
+			link = nix_get_tx_link(rvu, pcifunc);
 
 		if (lvl >= hw->cap.nix_tx_aggr_lvl) {
 			start = link;
-			end = link;
+			end = link + !!(req->flags & NIX_TXSCH_ALLOC_FLAG_PAN);
 		} else if (hw->cap.nix_fixed_txschq_mapping) {
 			nix_get_txschq_range(rvu, pcifunc, link, &start, &end);
 		} else {
@@ -2398,10 +2512,11 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 			end = txsch->schq.max;
 		}
 
-		nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end);
+		if (nix_txsch_alloc(rvu, txsch, rsp, lvl, start, end))
+			goto err;
 
 		/* Reset queue config */
-		for (idx = 0; idx < req->schq_contig[lvl]; idx++) {
+		for (idx = 0; idx < rsp->schq_contig[lvl]; idx++) {
 			schq = rsp->schq_contig_list[lvl][idx];
 			if (!(TXSCH_MAP_FLAGS(pfvf_map[schq]) &
 			    NIX_TXSCHQ_CFG_DONE))
@@ -2411,7 +2526,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
 		}
 
-		for (idx = 0; idx < req->schq[lvl]; idx++) {
+		for (idx = 0; idx < rsp->schq[lvl]; idx++) {
 			schq = rsp->schq_list[lvl][idx];
 			if (!(TXSCH_MAP_FLAGS(pfvf_map[schq]) &
 			    NIX_TXSCHQ_CFG_DONE))
@@ -2679,6 +2794,20 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
 	}
 	nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1,
 			  nix_get_tx_link(rvu, pcifunc));
+	/* TL1 is at nix_tx_aggr_lvl so the loop above skips it; also clear
+	 * PAN TL1 XOFF on switch-owned links before flushing SMQs.
+	 */
+	if (nix_txsch_pan_allowed(rvu, pcifunc)) {
+		txsch = &nix_hw->txsch[NIX_TXSCH_LVL_TL1];
+
+		for (schq = nix_get_pan_tx_link(rvu);
+		     schq < txsch->schq.max &&
+		     nix_txsch_is_pan_schq(rvu, schq); schq++) {
+			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
+				continue;
+			nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1, schq);
+		}
+	}
 
 	/* On PF cleanup, clear cfg done flag as
 	 * PF would have changed default config.
@@ -2706,11 +2835,11 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
 		 /* TLs above aggregation level are shared across all PF
 		  * and it's VFs, hence skip freeing them.
 		  */
-		if (lvl >= hw->cap.nix_tx_aggr_lvl)
-			continue;
-
 		txsch = &nix_hw->txsch[lvl];
 		for (schq = 0; schq < txsch->schq.max; schq++) {
+			if (lvl >= hw->cap.nix_tx_aggr_lvl &&
+			    !nix_txsch_is_pan_schq(rvu, schq))
+				continue;
 			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
 				continue;
 			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
@@ -2754,7 +2883,16 @@ static int nix_txschq_free_one(struct rvu *rvu,
 	schq = req->schq;
 	txsch = &nix_hw->txsch[lvl];
 
-	if (lvl >= hw->cap.nix_tx_aggr_lvl || schq >= txsch->schq.max)
+	if (req->flags & TXSCHQ_FREE_PAN_TL1) {
+		if (!nix_txsch_pan_allowed(rvu, pcifunc))
+			return NIX_AF_ERR_TLX_INVALID;
+		if (!nix_txsch_is_pan_schq(rvu, schq))
+			return NIX_AF_ERR_TLX_INVALID;
+	} else if (lvl >= hw->cap.nix_tx_aggr_lvl) {
+		return 0;
+	}
+
+	if (schq >= txsch->schq.max)
 		return 0;
 
 	pfvf_map = txsch->pfvf_map;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index e36c68ee5d84..40d49a323814 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1833,9 +1833,23 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
 		target = req->hdr.pcifunc;
 	}
 
-	/* ignore chan_mask in case pf func is not AF, revisit later */
-	if (!is_pffunc_af(req->hdr.pcifunc))
-		req->chan_mask = rvu_get_cpt_chan_mask(rvu);
+	/* Non-AF callers get the CPT default chan_mask unless the authorized
+	 * switchdev PF sets set_chanmask to preserve a caller-supplied mask.
+	 * VFs and other PFs must not use set_chanmask; that would bypass
+	 * channel isolation.
+	 */
+	if (!is_pffunc_af(req->hdr.pcifunc)) {
+		if (req->set_chanmask &&
+		    !rvu_is_switch_pcifunc(rvu, req->hdr.pcifunc)) {
+			rvu_npc_free_entry_for_flow_install(rvu,
+							    req->hdr.pcifunc,
+							    allocated,
+							    req->entry);
+			return NPC_FLOW_VF_PERM_DENIED;
+		}
+		if (!req->set_chanmask)
+			req->chan_mask = rvu_get_cpt_chan_mask(rvu);
+	}
 
 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
 	if (err) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index acf259d72008..73a98b94426b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -78,6 +78,8 @@ struct otx2_rcv_queue {
 struct sg_list {
 	u16	num_segs;
 	u16	flags;
+	u16	cq_idx;
+	u16	len;
 	u64	skb;
 	u64	size[OTX2_MAX_FRAGS_IN_SQE];
 	u64	dma_addr[OTX2_MAX_FRAGS_IN_SQE];
-- 
2.43.0

