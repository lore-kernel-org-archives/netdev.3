Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFE3BBFBB;
	Tue, 21 Jul 2026 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621936; cv=none; b=ESDglEc2vl+4E6jX4WQDNQYRFuO0DSCcpX/l3TFJKVXXkh+DyNfj8BNbk0BbxuYPZKa9st12tIdRVMSW+v/ogFyUy4p52fVNBdPLhXcL1YNIWK/aJZMhWdejI6Dhla67brgpW04TPznupJ5yzzBPOGflavQuNPJZ0f/kU7lnK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621936; c=relaxed/simple;
	bh=EOVplbuDWQWQGjNkDXeba19+oFfqGEO/h19jL7jxUhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epzXEpFT5qfYamm7DPJ7xryg12SveMocFcDU7a/Qa394KiNJlv4uj2xNbpNECA8GHYB8pMLYvynzC4KrKz7Bas5ZTKj2p4ph7heaRJUP/XHu1hUS7VTutevz8GuERbT1Lxt9OVeWVHsn+YoEUiF7c+C4+lDVEp0BRKlMIWnuK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=iF1w6P9l; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="iF1w6P9l"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcWLd3069960;
	Tue, 21 Jul 2026 01:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=c
	JdM3RVyDuux7cFTWnOfeR1Ua7B1zb8sts8Ni33Yzqo=; b=iF1w6P9ldg0+/cDqX
	eLx1nG7GgRKxijo6PH8vra0XhuiHbJOJxY5rByT2fmFpr08E4hgIXA/yPwqvqqkE
	Z7Ofbf+VTUy+4FO8rITZq6wIJ3uZbmWHCsotzMpllL9AR9dI2zOrtnUPshJ1KrtE
	G/LuwLepNi5SVC91JvVraS9DrMS5Y7/c6Ai5x+XRjLTP3rr6551J6udFPb8URpdP
	OaOaISImLaWlz3qJ6SBSPMeZ6hasZOkhwYaKPYMnXur0zw1q4brqB6d1JpZiBPcv
	zUmiBqZMDGcO90P/wmWiHiMp7OBWn8Jog9lrnUfJVbvV2GrGWcZQMezJkCOMEjh3
	txl+w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fhwdkh6yr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:44 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 522453F7070;
	Tue, 21 Jul 2026 01:18:42 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 5/9] octeontx2-af: switch: TL1 scheduling and NPC channel control
Date: Tue, 21 Jul 2026 13:48:20 +0530
Message-ID: <20260721081824.1430607-6-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721081824.1430607-1-rkannoth@marvell.com>
References: <20260721081824.1430607-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -4DMyJS-4fTrlffPYaMeDs9sTHB4eVSf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX/zfGafWj+av1
 qHUcSwhJtsrQgJLVPgA55qDaxoblYwSra7zJE/E+CttwFY3UGTdlUtBp6bRhwxbuj5R27v+ZngA
 JyfN+qUpH2ExRjWmE8Rc4zhQvWnDM98=
X-Authority-Analysis: v=2.4 cv=TrXWQjXh c=1 sm=1 tr=0 ts=6a5f2b65 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=b2e9Q_Z-T6RzkBTqyW8A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: -4DMyJS-4fTrlffPYaMeDs9sTHB4eVSf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX4TsWgPXOhG4w
 fXY9Mi5CG2AfMAE08kJ7LWWldsYtsBGc34F9zkfNHhnk+D5XOobZFEST/RjtvE2iwVYt7PipmK8
 jl6go8CLvl9zYV81KQyT+Gi1lH5WgCB21U6u3LKk3rPJrFp+odeVqaSu5W5maUBq3mY0kUrOypx
 KEZo7JRUm+0vjHldf2raXUlGTNP6Fk4IYS3JkjeO1Sq7SjeAvabPzYxeGHyVAx0R7Xx+drV1VBG
 swgmVH6x6GTD0YWra8nXe+hx3jjkbMKeNY2HIWpXQSkZDv0aICnADWo88EY9fqvgJKYRQ8tjDNT
 hVQb9ZqI/JdySouKowelEaO5/e7lefBsZR6qCab7gYVQuOMNIqb2OmAHc1A8GSqXVgFAlXHtx3M
 +LXVjR5EtkQiKumKRfEfI3ubxfS3ZVXIE8y5+IH0Hfzz8/hdNNPnwelS1Yaxj0jJ1B06JDXcJts
 t5Mn02MH2fv87Qhrg3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

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
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  25 ++-
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 179 ++++++++++++++++--
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  20 +-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   2 +
 6 files changed, 216 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cdfb5a8bafb9..a63771d7b102 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1158,6 +1158,13 @@ struct nix_txsch_alloc_req {
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
@@ -1176,6 +1183,10 @@ struct nix_txsch_alloc_rsp {
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
@@ -2115,6 +2126,10 @@ struct npc_install_flow_req {
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
index a0ae0ccc1b2b..168a50655351 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1990,18 +1990,29 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
-static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
-				struct iface_info *info)
+static void rvu_iface_get_qcnts(struct rvu *rvu, u16 pcifunc,
+				struct rvu_pfvf *pfvf, struct iface_info *info)
 {
+	int sq_bmap_bits;
+
 	mutex_lock(&rvu->rsrc_lock);
 
 	info->sq_cnt = 0;
 	info->cq_cnt = 0;
 	info->rq_cnt = 0;
 
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
@@ -2064,7 +2075,7 @@ int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
 		if (is_sdp_pfvf(rvu, pcifunc))
 			info->is_sdp = 1;
 
-		rvu_iface_get_qcnts(rvu, pfvf, info);
+		rvu_iface_get_qcnts(rvu, pcifunc, pfvf, info);
 
 		if (pfvf->nix_blkaddr == BLKADDR_NIX0)
 			info->nix = 0;
@@ -2097,7 +2108,7 @@ int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
 			if (is_sdp_pfvf(rvu, pcifunc))
 				info->is_sdp = 1;
 
-			rvu_iface_get_qcnts(rvu, pfvf, info);
+			rvu_iface_get_qcnts(rvu, pcifunc, pfvf, info);
 
 			if (pfvf->nix_blkaddr == BLKADDR_NIX0)
 				info->nix = 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 8cf1ad9ec749..0662cc6134b0 100644
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
index 0c6b2b425534..e3e2f0113328 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -1052,6 +1052,7 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
 	u16 pcifunc = req->hdr.pcifunc;
 	int nixlf, blkaddr, rc = 0;
 	struct nix_aq_inst_s inst;
+	u64 sq_bmap_bits, max_q;
 	struct rvu_block *block;
 	struct admin_queue *aq;
 	struct rvu_pfvf *pfvf;
@@ -1086,10 +1087,25 @@ static int rvu_nix_blk_aq_enq_inst(struct rvu *rvu, struct nix_hw *nix_hw,
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
@@ -1511,16 +1527,26 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	int nixlf, qints, hwctx_size, intf, rc = 0;
 	u16 bcast, mcast, promisc, ucast;
 	struct rvu_hwinfo *hw = rvu->hw;
+	u64 cfg, ctx_cfg, sq_bmap_bits;
 	u16 pcifunc = req->hdr.pcifunc;
 	bool rules_created = false;
 	struct rvu_block *block;
 	struct rvu_pfvf *pfvf;
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
 
@@ -1600,7 +1626,12 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	if (rc)
 		goto free_mem;
 
-	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	if (rvu_is_switch_pcifunc(rvu, pcifunc))
+		/* Fixed-size bitmap; sq_cnt capped to NIX_SQ_BMAP_BITS above. */
+		pfvf->sq_bmap = kcalloc(BITS_TO_LONGS(NIX_SQ_BMAP_BITS),
+					sizeof(long), GFP_KERNEL);
+	else
+		pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
 	if (!pfvf->sq_bmap) {
 		rc = -ENOMEM;
 		goto free_mem;
@@ -2127,6 +2158,25 @@ static void nix_get_txschq_range(struct rvu *rvu, u16 pcifunc,
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
@@ -2142,12 +2192,27 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
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
 
@@ -2176,9 +2241,9 @@ static int nix_check_txschq_alloc_req(struct rvu *rvu, int lvl, u16 pcifunc,
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
@@ -2188,6 +2253,46 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
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
@@ -2202,7 +2307,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			rsp->schq[lvl] = 1;
 			rsp->schq_list[lvl][0] = start;
 		}
-		return;
+		return 0;
 	}
 
 	/* Adjust the queue request count if HW supports
@@ -2214,7 +2319,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		if (idx >= (end - start) || test_bit(schq, txsch->schq.bmap)) {
 			rsp->schq_contig[lvl] = 0;
 			rsp->schq[lvl] = 0;
-			return;
+			return 0;
 		}
 
 		if (rsp->schq_contig[lvl]) {
@@ -2227,7 +2332,7 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 			set_bit(schq, txsch->schq.bmap);
 			rsp->schq_list[lvl][0] = schq;
 		}
-		return;
+		return 0;
 	}
 
 	/* Allocate contiguous queue indices requesty first */
@@ -2258,6 +2363,8 @@ static void nix_txsch_alloc(struct rvu *rvu, struct nix_txsch *txsch,
 		/* Update how many were allocated */
 		rsp->schq[lvl] = idx;
 	}
+
+	return 0;
 }
 
 int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
@@ -2282,6 +2389,10 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 	if (!nix_hw)
 		return NIX_AF_ERR_INVALID_NIXBLK;
 
+	if ((req->flags & NIX_TXSCH_ALLOC_FLAG_PAN) &&
+	    !nix_txsch_pan_allowed(rvu, pcifunc))
+		return NIX_AF_ERR_TLX_ALLOC_FAIL;
+
 	mutex_lock(&rvu->rsrc_lock);
 
 	/* Check if request is valid as per HW capabilities
@@ -2304,11 +2415,14 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
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
@@ -2316,10 +2430,11 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
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
@@ -2329,7 +2444,7 @@ int rvu_mbox_handler_nix_txsch_alloc(struct rvu *rvu,
 			nix_reset_tx_schedule(rvu, blkaddr, lvl, schq);
 		}
 
-		for (idx = 0; idx < req->schq[lvl]; idx++) {
+		for (idx = 0; idx < rsp->schq[lvl]; idx++) {
 			schq = rsp->schq_list[lvl][idx];
 			if (!(TXSCH_MAP_FLAGS(pfvf_map[schq]) &
 			    NIX_TXSCHQ_CFG_DONE))
@@ -2598,6 +2713,19 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
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
+		     nix_txsch_is_pan_schq(rvu, schq); schq++) {
+			if (TXSCH_MAP_FUNC(txsch->pfvf_map[schq]) != pcifunc)
+				continue;
+			nix_clear_tx_xoff(rvu, blkaddr, NIX_TXSCH_LVL_TL1, schq);
+		}
+	}
 
 	/* On PF cleanup, clear cfg done flag as
 	 * PF would have changed default config.
@@ -2625,11 +2753,11 @@ static int nix_txschq_free(struct rvu *rvu, u16 pcifunc)
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
@@ -2673,7 +2801,16 @@ static int nix_txschq_free_one(struct rvu *rvu,
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
index 09c7ee8571df..a1a82ddb7c50 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1828,9 +1828,23 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,
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

