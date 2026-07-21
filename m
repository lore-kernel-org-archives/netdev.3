Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91C73BAD9D;
	Tue, 21 Jul 2026 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621930; cv=none; b=Bweym2bBZa0PkYmyaH1+mDe2+3eK9gYYhBsYk+Q05Hsl36rKdH+GGXEhz+MGjJjkSVGzi6Xj1lPkk9KNUnaI3dP7LxtGrxKQffbTmNnTyA6I5rdVKgQV8Q/i9513FOelGqL7qBt39kyWLXLCLJK/z4uyfUP5nX9CEnbJlqYEWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621930; c=relaxed/simple;
	bh=bJ7nB6dpP/cHngUYhJ+Wod1Ch6Qi1Co15YkkMvEB8y8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEHVvyU9ZwDbAzbijHD7iMQzd49v4ue3LZpIzwdaBvM6eUJB3elsjLe2b9M+GcXj4gG3iRIN8NCbzVql6XEj+e/7u+Eu9uDfnuDAV/qK3PjiVnfbjsHUujmf84VH0GiSgcbiR3E6FtYN31ZaYQbK4PllkF1pcOq3cgAp8A9fClo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YOOLbjnq; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YOOLbjnq"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L7BWeG1527583;
	Tue, 21 Jul 2026 01:18:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=N
	rL1E677P29j5sj/MGmArIh+d4VqVCSnSPC08BInJio=; b=YOOLbjnqbdUbgdUqR
	o/f6bWTqdSTgUCUX7Go424sue17wKdpqgaOnUhYvMJDoDFMrSaUSDFoHIorIjE0/
	ZayvdcCxqF6kBsZgfwsq5AXxAZljGzPyYZc91q0fZtSohvPJX+guSeAQZlQo3KMk
	SldZAaXaBnruW2SzaVZ/1ShY5Fu5lYqdZ5xPRJgbJoWF5zjL+1vH6dPPN+xZeTn/
	pOnAwO2HOVxDTN7sT1pADVuYj1eNI0AsI4gXNYDH/1hDXODxrjmAmjtycPt0xWPH
	NX0yjvrOBVD1mNxIv729ekce3nC6bxnzZ6wkD1TpeFax4UijOPdg4SQFA0G1E51Y
	9hbXg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fgd7dfsxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:37 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:36 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 65FC63F7070;
	Tue, 21 Jul 2026 01:18:33 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 2/9] octeontx2-af: switch: Add switch dev to AF mboxes
Date: Tue, 21 Jul 2026 13:48:17 +0530
Message-ID: <20260721081824.1430607-3-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX7CcOxmCGc6DJ
 5itZlOyxOH4/IHifgkd9RFF4bpTdWXgdQR4MQsVPQZFRdJkcKt3rZsEvy+ZcbWj/4n7R26BqwZ0
 1+/4qgWOdltyv7H5/1f5uB9bdwq4z74=
X-Proofpoint-ORIG-GUID: vDphsOIs7dF6CktMJVLzu5FU-3avSfOU
X-Proofpoint-GUID: vDphsOIs7dF6CktMJVLzu5FU-3avSfOU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfXxuZz0itsgf6p
 AZwihf2xgo2gAxtjVX/assMOndhTuy8baRs+8zRzgT6yOVwb4TahXqRDyWAwYjNCjEVCoCx77Y+
 /UVyrYra8jrpDunNXDAQNefeLvKbsft72RmPTK8RYtus62XyqLoe2k6ezaGINBCKXOX752eZbPR
 TO5t3RPuMkv2cOBMc10u2665rPXuhRDwt1/8WCH955VsBDgLwVVedxu4ctSWYOstv8Bfwxjjqjm
 /DEqLTKTEGTxqPHENedo0N4/2Bg2CeSzLwv+R4nr/MZzIWbPlnWOU3gMCoIaQrnPW/hlMozYilb
 i3qCbgR/+ZHDYh8eQbt/kj1eb2cwblQJQSSV8Yy46uV4PRKZcY1c2WIowjQLZc1D86fthSr8s89
 EKTjDilF8DYde0GnZv0cW67pK8thAAsib+sv2gstAOrgRWjBYybV86EVD1zF43yRaA5Zv/4s6Na
 Pk24ktOHxQceonRhzdg==
X-Authority-Analysis: v=2.4 cv=I9tVgtgg c=1 sm=1 tr=0 ts=6a5f2b5e cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=g7MGyehL4oteeCUlPQQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

The Marvell switch hardware runs on a Linux OS. Switch
needs various information from AF driver. These mboxes are defined
to query those from AF driver.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/Makefile    |   2 +-
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 126 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 126 ++++++++++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   1 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   9 +-
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 111 +++++++++++++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  11 ++
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  15 +++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  11 ++
 9 files changed, 408 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/Makefile b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
index 82dd387308c9..73f20a44f1a0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/af/Makefile
@@ -12,6 +12,6 @@ rvu_af-y := cgx.o rvu.o rvu_cgx.o rvu_npa.o rvu_nix.o \
 		  rvu_reg.o rvu_npc.o rvu_debugfs.o ptp.o rvu_npc_fs.o \
 		  rvu_cpt.o rvu_devlink.o rpm.o rvu_cn10k.o rvu_switch.o \
 		  rvu_sdp.o rvu_npc_hash.o mcs.o mcs_rvu_if.o mcs_cnf10kb.o \
-		  switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o\
+		  switch/rvu_sw.o switch/rvu_sw_l2.o switch/rvu_sw_l3.o switch/rvu_sw_fl.o \
 		  rvu_rep.o cn20k/mbox_init.o cn20k/nix.o cn20k/debugfs.o \
 		  cn20k/npa.o cn20k/npc.o
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 2867da47d9f5..23bc66ed854e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -172,6 +172,10 @@ M(FL_NOTIFY,		0x012,  fl_notify,				\
 				fl_notify_req, msg_rsp)		\
 M(FL_GET_STATS,		0x013,  fl_get_stats,				\
 				fl_get_stats_req, fl_get_stats_rsp)	\
+M(IFACE_GET_INFO,	0x014, iface_get_info, msg_req,	\
+				iface_get_info_rsp)			\
+M(SWDEV2AF_NOTIFY,	0x015,  swdev2af_notify,		\
+				swdev2af_notify_req, msg_rsp)		\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -317,6 +321,14 @@ M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601e, npc_get_dft_rl_idxs,	\
 M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601f, npc_get_pfl_info,		\
 					msg_req,		\
 					npc_get_pfl_info_rsp)	\
+M(NPC_MCAM_FLOW_DEL_N_FREE,	0x6020, npc_flow_del_n_free,		\
+				 npc_flow_del_n_free_req, msg_rsp)	\
+M(NPC_MCAM_GET_MUL_STATS, 0x6021, npc_mcam_mul_stats,			\
+				   npc_mcam_get_mul_stats_req,		\
+				   npc_mcam_get_mul_stats_rsp)		\
+M(NPC_MCAM_GET_FEATURES, 0x6022, npc_mcam_get_features,			\
+				   msg_req,				\
+				   npc_mcam_get_features_rsp)		\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -446,6 +458,12 @@ M(MCS_INTR_NOTIFY,	0xE00, mcs_intr_notify, mcs_intr_info, msg_rsp)
 #define MBOX_UP_REP_MESSAGES						\
 M(REP_EVENT_UP_NOTIFY,	0xEF0, rep_event_up_notify, rep_event, msg_rsp) \
 
+#define MBOX_UP_AF2SWDEV_MESSAGES					\
+M(AF2SWDEV,	0xEF1, af2swdev_notify, af2swdev_notify_req, msg_rsp)
+
+#define MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES					\
+M(AF2PF_FDB_REFRESH,  0xEF2, af2pf_fdb_refresh, af2pf_fdb_refresh_req, msg_rsp)
+
 enum {
 #define M(_name, _id, _1, _2, _3) MBOX_MSG_ ## _name = _id,
 MBOX_MESSAGES
@@ -453,6 +471,8 @@ MBOX_UP_CGX_MESSAGES
 MBOX_UP_CPT_MESSAGES
 MBOX_UP_MCS_MESSAGES
 MBOX_UP_REP_MESSAGES
+MBOX_UP_AF2SWDEV_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
 #undef M
 };
 
@@ -1589,6 +1609,30 @@ struct npc_mcam_alloc_entry_rsp {
 	u16 entry_list[NPC_MAX_NONCONTIG_ENTRIES];
 };
 
+struct npc_flow_del_n_free_req {
+	struct mbox_msghdr hdr;
+	u16 cnt;
+	u16 entry[256]; /* Entry index to be freed */
+};
+
+struct npc_mcam_get_features_rsp {
+	struct mbox_msghdr hdr;
+	u64 rx_features;
+	u64 tx_features;
+};
+
+struct npc_mcam_get_mul_stats_req {
+	struct mbox_msghdr hdr;
+	u16 cnt;
+	u16 entry[256]; /* mcam entry */
+};
+
+struct npc_mcam_get_mul_stats_rsp {
+	struct mbox_msghdr hdr;
+	u16 cnt;
+	u64 stat[256];  /* counter stats */
+};
+
 struct npc_mcam_free_entry_req {
 	struct mbox_msghdr hdr;
 	u16 entry; /* Entry index to be freed */
@@ -1914,6 +1958,88 @@ struct fl_get_stats_rsp {
 	u64 pkts_diff;
 };
 
+struct af2swdev_notify_req {
+	struct mbox_msghdr hdr;
+	u64 flags;
+	u32 port_id;
+	u32 switch_id;
+	union {
+		struct {
+			u8 mac[6];
+		};
+		struct {
+			u8 cnt;
+			struct fib_entry entry[16];
+		};
+
+		struct {
+			u64 cookie;
+			u64 features;
+			struct fl_tuple tuple;
+		};
+	};
+};
+
+struct af2pf_fdb_refresh_req {
+	struct mbox_msghdr hdr;
+	u16 pcifunc;
+	u8 mac[6];
+};
+
+struct iface_info {
+	u8 is_vf : 1;
+	u8 is_sdp : 1;
+	u8 rsvd : 6;
+	u16 pcifunc;
+	u16 rx_chan_base;
+	u16 tx_chan_base;
+	u16 sq_cnt;
+	u16 cq_cnt;
+	u16 rq_cnt;
+	u8 rx_chan_cnt;
+	u8 tx_chan_cnt;
+	u8 tx_link;
+	u8 nix;
+};
+
+/* Max supported */
+#define IFACE_MAX (256 + 32) /* 32 PFs + 256 VFs */
+
+struct iface_get_info_rsp {
+	struct  mbox_msghdr hdr;
+	u16 cnt;
+	u8 truncated;
+	u8 rsvd[5];
+	struct iface_info info[IFACE_MAX];
+};
+
+struct fl_info {
+	u64 cookie;
+	u16 mcam_idx[2];
+	u8 dis : 1;
+	u8 uni_di : 1;
+};
+
+struct swdev2af_notify_req {
+	struct  mbox_msghdr hdr;
+	u64 msg_type;
+#define SWDEV2AF_MSG_TYPE_FW_STATUS BIT_ULL(0)
+#define	SWDEV2AF_MSG_TYPE_REFRESH_FDB BIT_ULL(1)
+#define	SWDEV2AF_MSG_TYPE_REFRESH_FL BIT_ULL(2)
+	u16 pcifunc;
+	union {
+		bool fw_up;		// FW_STATUS message
+
+		u8 mac[ETH_ALEN];	// fdb refresh message
+
+		struct {		// fl refresh message
+			u8 cnt;
+			u8 rsvd[7];
+			struct fl_info fl[64];
+		};
+	};
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index ffba56ee8a60..a0ae0ccc1b2b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1990,6 +1990,132 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
+				struct iface_info *info)
+{
+	mutex_lock(&rvu->rsrc_lock);
+
+	info->sq_cnt = 0;
+	info->cq_cnt = 0;
+	info->rq_cnt = 0;
+
+	/* Use each LF queue context size; bitmaps are sized to qsize longs. */
+	if (pfvf->sq_ctx && pfvf->sq_bmap)
+		info->sq_cnt = bitmap_weight(pfvf->sq_bmap, pfvf->sq_ctx->qsize);
+	if (pfvf->cq_ctx && pfvf->cq_bmap)
+		info->cq_cnt = bitmap_weight(pfvf->cq_bmap, pfvf->cq_ctx->qsize);
+	if (pfvf->rq_ctx && pfvf->rq_bmap)
+		info->rq_cnt = bitmap_weight(pfvf->rq_bmap, pfvf->rq_ctx->qsize);
+
+	mutex_unlock(&rvu->rsrc_lock);
+}
+
+int rvu_mbox_handler_iface_get_info(struct rvu *rvu, struct msg_req *req,
+				    struct iface_get_info_rsp *rsp)
+{
+	struct iface_info *info;
+	bool truncated = false;
+	struct rvu_pfvf *pfvf;
+	int pf, vf, numvfs;
+	int tot = 0;
+	u16 pcifunc;
+	u64 cfg;
+
+	/* Read-only topology snapshot for switch software; any PF/VF may
+	 * request it. Only channel and queue counts already visible to the
+	 * requester through AF are reported.
+	 */
+	rsp->cnt = 0;
+	rsp->truncated = 0;
+	/* Preserve mbox_msghdr fields pre-filled by the mbox framework. */
+	memset(rsp->info, 0, sizeof(rsp->info));
+	info = rsp->info;
+	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
+		if (tot >= IFACE_MAX) {
+			truncated = true;
+			goto done;
+		}
+
+		cfg = rvu_read64(rvu, BLKADDR_RVUM, RVU_PRIV_PFX_CFG(pf));
+		numvfs = (cfg >> 12) & 0xFF;
+
+		/* Skip not enabled PFs */
+		if (!(cfg & BIT_ULL(20)))
+			goto chk_vfs;
+
+		/* If Admin function, check on VFs */
+		if (cfg & BIT_ULL(21))
+			goto chk_vfs;
+
+		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+		/* Populate iff at least one Tx channel */
+		if (!pfvf->tx_chan_cnt)
+			goto chk_vfs;
+
+		info->is_vf = 0;
+		info->pcifunc = pcifunc;
+		info->rx_chan_base = pfvf->rx_chan_base;
+		info->rx_chan_cnt = pfvf->rx_chan_cnt;
+		info->tx_chan_base = pfvf->tx_chan_base;
+		info->tx_chan_cnt = pfvf->tx_chan_cnt;
+		info->tx_link = nix_get_tx_link(rvu, pcifunc);
+		if (is_sdp_pfvf(rvu, pcifunc))
+			info->is_sdp = 1;
+
+		rvu_iface_get_qcnts(rvu, pfvf, info);
+
+		if (pfvf->nix_blkaddr == BLKADDR_NIX0)
+			info->nix = 0;
+		else
+			info->nix = 1;
+
+		info++;
+		tot++;
+
+chk_vfs:
+		for (vf = 0; vf < numvfs; vf++) {
+			if (tot >= IFACE_MAX) {
+				truncated = true;
+				goto done;
+			}
+
+			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+			pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+			if (!pfvf->tx_chan_cnt)
+				continue;
+
+			info->is_vf = 1;
+			info->pcifunc = pcifunc;
+			info->rx_chan_base = pfvf->rx_chan_base;
+			info->rx_chan_cnt = pfvf->rx_chan_cnt;
+			info->tx_chan_base = pfvf->tx_chan_base;
+			info->tx_chan_cnt = pfvf->tx_chan_cnt;
+			info->tx_link = nix_get_tx_link(rvu, pcifunc);
+			if (is_sdp_pfvf(rvu, pcifunc))
+				info->is_sdp = 1;
+
+			rvu_iface_get_qcnts(rvu, pfvf, info);
+
+			if (pfvf->nix_blkaddr == BLKADDR_NIX0)
+				info->nix = 0;
+			else
+				info->nix = 1;
+
+			info++;
+
+			tot++;
+		}
+	}
+done:
+	rsp->cnt = tot;
+	rsp->truncated = truncated;
+
+	return 0;
+}
+
 int rvu_mbox_handler_free_rsrc_cnt(struct rvu *rvu, struct msg_req *req,
 				   struct free_rsrcs_rsp *rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index c5610f242687..73d2329b5c26 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1158,6 +1158,7 @@ void rvu_program_channels(struct rvu *rvu);
 
 /* CN10K NIX */
 void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw);
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 /* CN10K RVU - LMT*/
 void rvu_reset_lmt_map_tbl(struct rvu *rvu, u16 pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 78667a0977c0..0c6b2b425534 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -32,7 +32,6 @@ static int nix_free_all_bandprof(struct rvu *rvu, u16 pcifunc);
 static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 				     u32 leaf_prof);
 static const char *nix_get_ctx_name(int ctype);
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 enum mc_tbl_sz {
 	MC_TBL_SZ_256,
@@ -906,6 +905,8 @@ static void nix_setup_lso(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
 
 static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
 {
+	mutex_lock(&rvu->rsrc_lock);
+
 	kfree(pfvf->rq_bmap);
 	kfree(pfvf->sq_bmap);
 	kfree(pfvf->cq_bmap);
@@ -931,6 +932,8 @@ static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
 	pfvf->rss_ctx = NULL;
 	pfvf->nix_qints_ctx = NULL;
 	pfvf->cq_ints_ctx = NULL;
+
+	mutex_unlock(&rvu->rsrc_lock);
 }
 
 static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
@@ -2087,10 +2090,10 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
 	rvu_write64(rvu, blkaddr, reg, 0x0);
 }
 
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
 {
-	struct rvu_hwinfo *hw = rvu->hw;
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
+	struct rvu_hwinfo *hw = rvu->hw;
 	u8 cgx_id = 0, lmac_id = 0;
 
 	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 08b83de9beb4..9ba34c03db9c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -3544,6 +3544,46 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
 	return rc;
 }
 
+int rvu_mbox_handler_npc_flow_del_n_free(struct rvu *rvu,
+					 struct npc_flow_del_n_free_req *mreq,
+					 struct msg_rsp *rsp)
+{
+	struct npc_mcam_free_entry_req sreq = { 0 };
+	struct npc_delete_flow_req dreq = { 0 };
+	struct npc_delete_flow_rsp drsp = { 0 };
+	u16 entry[256];
+	int ret = 0, i;
+	bool err = false;
+	u16 cnt;
+
+	sreq.hdr.pcifunc = mreq->hdr.pcifunc;
+	dreq.hdr.pcifunc = mreq->hdr.pcifunc;
+
+	cnt = mreq->cnt;
+	if (!cnt || cnt > 256) {
+		dev_err(rvu->dev, "Invalid cnt=%u\n", cnt);
+		return -EINVAL;
+	}
+
+	/* Snapshot shared mailbox memory before processing the request. */
+	memcpy(entry, mreq->entry, cnt * sizeof(entry[0]));
+
+	for (i = 0; i < cnt; i++) {
+		dreq.entry = entry[i];
+		rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);
+
+		sreq.entry = entry[i];
+		ret = rvu_mbox_handler_npc_mcam_free_entry(rvu, &sreq, rsp);
+		if (ret) {
+			dev_err(rvu->dev, "free entry error for i=%d entry=%d\n",
+				i, entry[i]);
+			err = true;
+		}
+	}
+
+	return err ? -EINVAL : 0;
+}
+
 int rvu_mbox_handler_npc_mcam_read_entry(struct rvu *rvu,
 					 struct npc_mcam_read_entry_req *req,
 					 struct npc_mcam_read_entry_rsp *rsp)
@@ -4398,6 +4438,77 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
 	return 0;
 }
 
+int rvu_mbox_handler_npc_mcam_mul_stats(struct rvu *rvu,
+					struct npc_mcam_get_mul_stats_req *req,
+					struct npc_mcam_get_mul_stats_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u16 req_cnt, index, cntr, mcam_entry;
+	u16 pcifunc = req->hdr.pcifunc;
+	int blkaddr, cnt = 0, i;
+	u16 entry[256];
+	u64 regval;
+	u32 bank;
+
+	req_cnt = req->cnt;
+	if (!req_cnt || req_cnt > 256) {
+		dev_err(rvu->dev, "%s invalid request cnt=%u\n",
+			__func__, req_cnt);
+		return -EINVAL;
+	}
+
+	/* Snapshot shared mailbox memory before processing the request. */
+	memcpy(entry, req->entry, req_cnt * sizeof(entry[0]));
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+	if (blkaddr < 0)
+		return NPC_MCAM_INVALID_REQ;
+
+	mutex_lock(&mcam->lock);
+
+	for (i = 0; i < req_cnt; i++) {
+		mcam_entry = npc_cn20k_vidx2idx(entry[i]);
+
+		if (npc_mcam_verify_entry(mcam, pcifunc, mcam_entry)) {
+			mutex_unlock(&mcam->lock);
+			dev_err(rvu->dev, "%s invalid mcam index=%d\n",
+				__func__, entry[i]);
+			return -EINVAL;
+		}
+
+		index = mcam_entry & (mcam->banksize - 1);
+		bank = npc_get_bank(mcam, mcam_entry);
+
+		if (is_cn20k(rvu->pdev)) {
+			regval = rvu_read64(rvu, blkaddr,
+					    NPC_AF_CN20K_MCAMEX_BANKX_STAT_EXT(index,
+									       bank));
+			rsp->stat[cnt] = regval;
+			cnt++;
+			continue;
+		}
+
+		/* read MCAM entry STAT_ACT register */
+		regval = rvu_read64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_STAT_ACT(index, bank));
+
+		if (!(regval & rvu->hw->npc_stat_ena)) {
+			rsp->stat[cnt] = 0;
+			cnt++;
+			continue;
+		}
+
+		cntr = regval & 0x1FF;
+
+		rsp->stat[cnt] = rvu_read64(rvu, blkaddr, NPC_AF_MATCH_STATX(cntr));
+		rsp->stat[cnt] &= BIT_ULL(48) - 1;
+		cnt++;
+	}
+
+	rsp->cnt = cnt;
+	mutex_unlock(&mcam->lock);
+	return 0;
+}
+
 void rvu_npc_clear_ucast_entry(struct rvu *rvu, int pcifunc, int nixlf)
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 91b5947dae06..09c7ee8571df 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1926,6 +1926,17 @@ static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
 	return rvu_mbox_handler_npc_mcam_dis_entry(rvu, &dis_req, &dis_rsp);
 }
 
+int rvu_mbox_handler_npc_mcam_get_features(struct rvu *rvu,
+					   struct msg_req *req,
+					   struct npc_mcam_get_features_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+
+	rsp->rx_features = mcam->rx_features;
+	rsp->tx_features = mcam->tx_features;
+	return 0;
+}
+
 int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 				     struct npc_delete_flow_req *req,
 				     struct npc_delete_flow_rsp *rsp)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
new file mode 100644
index 000000000000..fe143ad3f944
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#include "rvu.h"
+
+int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
+				     struct swdev2af_notify_req *req,
+				     struct msg_rsp *rsp)
+{
+	return 0;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
new file mode 100644
index 000000000000..f28dba556d80
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#ifndef RVU_SWITCH_H
+#define RVU_SWITCH_H
+
+#endif
-- 
2.43.0

