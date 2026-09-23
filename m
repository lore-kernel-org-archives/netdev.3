Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AC139AD3A;
	Wed, 23 Sep 2026 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134121; cv=none; b=n5A/OyP9pl3f77GDMMKxU9wXyPHMZh51AqQXUXFXsdYNZPaNPYNy2f5puVvL0oZpEx+ubmVncYFm58dWK12Wt12CcK6UFAxkybv2ImS+EqMScJmJWTwbUywpJwLUhhAPa4IuCCTXx4pR5Q8jkASEpwEAs6zbAc44qfZAK5fnxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134121; c=relaxed/simple;
	bh=eabBRZ/SKm+2GApNzvMlCiCUSYbT4FxoCtmDXcshQew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fSe4DLVPOIv1Aow1TRNcK0TTUWEaQ1ky8nDHW6orTc6WPOYUzUyLGCWG3csG1Ez+jyJ0Gu9c1rhF7Z65n9bCfxUP28URciqa33QicUa3kxYeaOg5nx/LvRRrLqQWJq6YeRgPIMuIr3QjKSSAV31ShJG/eVY3xrDn8idk1blMz3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=JThcLGoc; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="JThcLGoc"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIJnxc2187226;
	Tue, 22 Sep 2026 20:28:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=F/VLAfipbF2oq4mdFIleoed
	6h/6at8AyE2Vl4rd9S94=; b=JThcLGocA9Ai9D+xlJwCiuqxyNvx+hbzo6Cfghy
	48FAisowxZl6twzdRFM1GDCBhIEePvZE+t5Cob2FgYpzhJJKCbZIlsDqvLQ5SI+T
	HpVYMmwV3VQhWss5n3dlDS7Mhca2Bh5yhj1s7dVmZ4YkHZtkv88KMuYZx7EXe0mu
	o95XYDCAbqf1RV4MYb2RktQxoTPybhDYJSQODhdjQMIa1P8vllgJeXthhQ+Ci37m
	oHOqHqXC/XxRvvrjQ9mxdQvo4eb0mUwA93lj/Z9VLNiSSb1n6uNFee2oHGB33tOt
	CuVitVSmA8bmLqh84UFACvXTGfimGlHJpM003O0Yra1Gbaw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4guabug2uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 20:28:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 20:28:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 20:28:27 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 79BE03F704E;
	Tue, 22 Sep 2026 20:28:23 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-af: Add couple of mailbox support.
Date: Wed, 23 Sep 2026 08:58:16 +0530
Message-ID: <20260923032816.1740106-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: tNU_n7UvbQqhrB2pkdvRZcBz9c82SYRV
X-Proofpoint-GUID: tNU_n7UvbQqhrB2pkdvRZcBz9c82SYRV
X-Authority-Analysis: v=2.4 cv=PMOaavqC c=1 sm=1 tr=0 ts=6ab3475c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=Iv-71ZcKlferRnDPcn0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxMyBTYWx0ZWRfXx4Rv9aX+NL8D
 FSWZ27+4f2fr26lktktL3cz5Dx/bmb7ZRZm8vg0jyx/KM7TWdm1zyyjZRZ80NyRL2Bg/6Go+hQt
 3l0DWSXbI8e1sEgDkxPlquzNb3Nqi+8I6bwC+wUDWXaFFzSu6gXg8t0/bWODIuKUAxWTvseMBQU
 Udk90nDTQWd0vmGfO/gBpML1VsVFR8GTlwjuXJ9f/EVG/dIAquUWWjvijY/UFlVk+YzTjOe8/MM
 pUqKZEXidd3mEJ5o51W8u3jBNpYFIkGxIa963w/GZUCTdIOsmTIobJYEXT+H7P0LJp2I06Jrr5q
 ISxfP+sJS2qKStlgyjfgnZ+DxazdqDr+3lH+dppa9XcUfjFaIkymwzOLtKlt9z9d9voRaGg/HOd
 3aZOAPyvaFRB2wDZkCDilzlRNxBSzUkTMHPWkAVtwp8xfVfTdDix7xsxVF7YzNfWlFxo+q7oDpg
 wU2kY3DEnhd31UX5GFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxMyBTYWx0ZWRfX65bwc69vcDvS
 O8JYYs6r19EeQbzaTvpoor+I/eVJuA64SJNw3XfKDoYma7Cp4f2C/17LVIJQVwl1YSm+wRdY+Vv
 6NwoBGwEdFRIptZKl2S2tCORLyCkj94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01

Add IFACE_GET_INFO and NPC batch flow/stats/features handlers for the
RVU switch PF, with synchronized NIX context and channel publishing.

  IFACE_GET_INFO:           report PF/VF channel and queue topology
  NPC_MCAM_FLOW_DEL_N_FREE: delete flows and free MCAM entries in bulk
  NPC_MCAM_GET_MUL_STATS:   read MCAM counter stats in bulk
  NPC_MCAM_GET_FEATURES:    report supported MCAM features

Rework NIX LF context memory publish and teardown so queue context
pointers and bitmaps are assigned and cleared under the NIX admin queue
lock.  Publish interface channel fields under rsrc_lock so IFACE_GET_INFO
can read a consistent snapshot.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---

v1 -> v2:
- Drop SWDEV2AF_NOTIFY and the switch skeleton hooks from this patch;
  keep the series focused on the AF mailbox handlers above.
- Restrict IFACE_GET_INFO to the PAN RVU switch PF (rvu_is_switch_pcifunc())
  and return -EPERM for other callers.
- Hold rsrc_lock while building the IFACE_GET_INFO topology snapshot.
- Publish and clear NIX interface channel fields under rsrc_lock.
- Publish NIX LF queue context pointers and bitmaps under the admin queue
  lock; propagate assign failures and free partial allocations on error.
- Fix nix_get_tx_link() for representor and LBK VF devices.
- Propagate NPC flow deletion failures from npc_delete_flow() and the
  bulk delete/free handler; ratelimit bulk handler error logs.
- Read NPC MCAM features under mcam->lock and clear mul-stats response
  on entry verification failure.
  https://lore.kernel.org/netdev/20260918050021.1359606-1-rkannoth@marvell.com/
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  62 ++++
 .../net/ethernet/marvell/octeontx2/af/rvu.c   | 159 ++++++++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   2 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   | 291 ++++++++++++++----
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 124 ++++++++
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  23 +-
 6 files changed, 597 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..28f2b549780f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -164,6 +164,8 @@ M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
 M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
 M(REP_EVENT_NOTIFY,     0x00f, rep_event_notify, rep_event, msg_rsp) \
+M(IFACE_GET_INFO,	0x014, iface_get_info, msg_req,	\
+				iface_get_info_rsp)			\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -309,8 +311,16 @@ M(NPC_MCAM_GET_DFT_RL_IDXS, 0x601e, npc_get_dft_rl_idxs,	\
 M(NPC_MCAM_GET_NPC_PFL_INFO, 0x601f, npc_get_pfl_info,		\
 					msg_req,		\
 					npc_get_pfl_info_rsp)	\
+M(NPC_MCAM_FLOW_DEL_N_FREE,	0x6020, npc_flow_del_n_free,		\
+				 npc_flow_del_n_free_req, msg_rsp)	\
 M(NPC_MCAM_READ_DEFAULT_RULE, 0x6021, npc_read_default_rule, msg_req,	\
 					npc_mcam_read_base_rule_rsp)	\
+M(NPC_MCAM_GET_MUL_STATS, 0x6022, npc_mcam_mul_stats,			\
+				   npc_mcam_get_mul_stats_req,		\
+				   npc_mcam_get_mul_stats_rsp)		\
+M(NPC_MCAM_GET_FEATURES, 0x6023, npc_mcam_get_features,			\
+				   msg_req,				\
+				   npc_mcam_get_features_rsp)		\
 /* NIX mbox IDs (range 0x8000 - 0xFFFF) */				\
 M(NIX_LF_ALLOC,		0x8000, nix_lf_alloc,				\
 				 nix_lf_alloc_req, nix_lf_alloc_rsp)	\
@@ -1586,6 +1596,31 @@ struct npc_mcam_alloc_entry_rsp {
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
+	u16 rsvd[3]; /* explicit padding for stat[] 8-byte alignment */
+	u64 stat[256];  /* counter stats */
+};
+
 struct npc_mcam_free_entry_req {
 	struct mbox_msghdr hdr;
 	u16 entry; /* Entry index to be freed */
@@ -1812,6 +1847,33 @@ struct rep_event {
 	struct rep_evt_data evt_data;
 };
 
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
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 30e148291581..055e39746558 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1990,6 +1990,165 @@ int rvu_mbox_handler_msix_offset(struct rvu *rvu, struct msg_req *req,
 	return 0;
 }
 
+static bool rvu_is_switch_pcifunc(struct rvu *rvu, u16 pcifunc)
+{
+	int pf, domain_nr;
+	struct pci_dev *pdev;
+	bool is_switch;
+
+	if (pcifunc & RVU_PFVF_FUNC_MASK)
+		return false;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+	domain_nr = pci_domain_nr(rvu->pdev->bus);
+	pdev = pci_get_domain_bus_and_slot(domain_nr,
+					   pf + rvu->pdev->bus->number, 0);
+	if (!pdev)
+		return false;
+
+	is_switch = pdev->device == PCI_DEVID_PAN_RVU;
+	pci_dev_put(pdev);
+
+	return is_switch;
+}
+
+static void rvu_iface_get_qcnts(struct rvu *rvu, struct rvu_pfvf *pfvf,
+				struct iface_info *info)
+{
+	struct admin_queue *aq;
+
+	info->sq_cnt = 0;
+	info->cq_cnt = 0;
+	info->rq_cnt = 0;
+
+	aq = rvu->hw->block[pfvf->nix_blkaddr].aq;
+	if (!aq)
+		return;
+
+	spin_lock(&aq->lock);
+
+	/* Use each LF queue context size; bitmaps are sized to qsize longs. */
+	if (pfvf->sq_ctx && pfvf->sq_bmap)
+		info->sq_cnt = bitmap_weight(pfvf->sq_bmap, pfvf->sq_ctx->qsize);
+	if (pfvf->cq_ctx && pfvf->cq_bmap)
+		info->cq_cnt = bitmap_weight(pfvf->cq_bmap, pfvf->cq_ctx->qsize);
+	if (pfvf->rq_ctx && pfvf->rq_bmap)
+		info->rq_cnt = bitmap_weight(pfvf->rq_bmap, pfvf->rq_ctx->qsize);
+
+	spin_unlock(&aq->lock);
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
+	if (!rvu_is_switch_pcifunc(rvu, req->hdr.pcifunc))
+		return -EPERM;
+
+	/* Read-only topology snapshot for switch software. */
+	rsp->cnt = 0;
+	rsp->truncated = 0;
+	memset(rsp->rsvd, 0, sizeof(rsp->rsvd));
+	/* Preserve mbox_msghdr fields pre-filled by the mbox framework. */
+	memset(rsp->info, 0, sizeof(rsp->info));
+	info = rsp->info;
+
+	mutex_lock(&rvu->rsrc_lock);
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
+	mutex_unlock(&rvu->rsrc_lock);
+
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
index fb4870cd18e9..d3408b86f0de 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -24,6 +24,7 @@
 #define	PCI_DEVID_OCTEONTX2_RVU_AF		0xA065
 #define	PCI_DEVID_OCTEONTX2_RVU_AFVF		0xA0F8
 #define	PCI_DEVID_OCTEONTX2_LBK			0xA061
+#define	PCI_DEVID_PAN_RVU			0xA0E2
 
 /* Subsystem Device ID */
 #define PCI_SUBSYS_DEVID_98XX                  0xB100
@@ -1161,6 +1162,7 @@ void rvu_program_channels(struct rvu *rvu);
 
 /* CN10K NIX */
 void rvu_nix_block_cn10k_init(struct rvu *rvu, struct nix_hw *nix_hw);
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 /* CN10K RVU - LMT*/
 void rvu_reset_lmt_map_tbl(struct rvu *rvu, u16 pcifunc);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index d80d2c00bd84..354c575d4710 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -32,7 +32,6 @@ static int nix_free_all_bandprof(struct rvu *rvu, u16 pcifunc);
 static void nix_clear_ratelimit_aggr(struct rvu *rvu, struct nix_hw *nix_hw,
 				     u32 leaf_prof);
 static const char *nix_get_ctx_name(int ctype);
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc);
 
 enum mc_tbl_sz {
 	MC_TBL_SZ_256,
@@ -337,6 +336,28 @@ static bool is_valid_txschq(struct rvu *rvu, int blkaddr,
 	return true;
 }
 
+static void nix_interface_set_chan(struct rvu *rvu, struct rvu_pfvf *pfvf,
+				   u16 rx_chan_base, u8 rx_chan_cnt,
+				   u16 tx_chan_base, u8 tx_chan_cnt)
+{
+	mutex_lock(&rvu->rsrc_lock);
+	pfvf->rx_chan_base = rx_chan_base;
+	pfvf->rx_chan_cnt = rx_chan_cnt;
+	pfvf->tx_chan_base = tx_chan_base;
+	pfvf->tx_chan_cnt = tx_chan_cnt;
+	mutex_unlock(&rvu->rsrc_lock);
+}
+
+static void nix_interface_clear_chan(struct rvu *rvu, struct rvu_pfvf *pfvf)
+{
+	mutex_lock(&rvu->rsrc_lock);
+	pfvf->rx_chan_base = 0;
+	pfvf->rx_chan_cnt = 0;
+	pfvf->tx_chan_base = 0;
+	pfvf->tx_chan_cnt = 0;
+	mutex_unlock(&rvu->rsrc_lock);
+}
+
 static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 			      struct nix_lf_alloc_rsp *rsp, bool loop)
 {
@@ -365,10 +386,9 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 				"PF_Func 0x%x: Invalid pkind\n", pcifunc);
 			return -EINVAL;
 		}
-		pfvf->rx_chan_base = rvu_nix_chan_cgx(rvu, cgx_id, lmac_id, 0);
-		pfvf->tx_chan_base = pfvf->rx_chan_base;
-		pfvf->rx_chan_cnt = 1;
-		pfvf->tx_chan_cnt = 1;
+		nix_interface_set_chan(rvu, pfvf,
+				       rvu_nix_chan_cgx(rvu, cgx_id, lmac_id, 0), 1,
+				       rvu_nix_chan_cgx(rvu, cgx_id, lmac_id, 0), 1);
 		rsp->tx_link = cgx_id * hw->lmac_per_cgx + lmac_id;
 
 		if (rvu_cgx_check_permission_and_set_pkind(rvu, pcifunc, pkind))
@@ -410,12 +430,11 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 		 * loopback channels.Therefore if odd number of AF VFs are
 		 * enabled then the last VF remains with no pair.
 		 */
-		pfvf->rx_chan_base = rvu_nix_chan_lbk(rvu, lbkid, vf);
-		pfvf->tx_chan_base = vf & 0x1 ?
-					rvu_nix_chan_lbk(rvu, lbkid, vf - 1) :
-					rvu_nix_chan_lbk(rvu, lbkid, vf + 1);
-		pfvf->rx_chan_cnt = 1;
-		pfvf->tx_chan_cnt = 1;
+		nix_interface_set_chan(rvu, pfvf,
+				       rvu_nix_chan_lbk(rvu, lbkid, vf), 1,
+				       vf & 0x1 ?
+				       rvu_nix_chan_lbk(rvu, lbkid, vf - 1) :
+				       rvu_nix_chan_lbk(rvu, lbkid, vf + 1), 1);
 		rsp->tx_link = hw->cgx_links + lbkid;
 		pfvf->lbkid = lbkid;
 		rvu_npc_set_pkind(rvu, NPC_RX_LBK_PKIND, pfvf);
@@ -452,10 +471,8 @@ static int nix_interface_init(struct rvu *rvu, u16 pcifunc, int type, int nixlf,
 			req_chan_cnt = sdp_info->num_pf_rings;
 		}
 
-		pfvf->rx_chan_base = req_chan_base;
-		pfvf->rx_chan_cnt = req_chan_cnt;
-		pfvf->tx_chan_base = pfvf->rx_chan_base;
-		pfvf->tx_chan_cnt = pfvf->rx_chan_cnt;
+		nix_interface_set_chan(rvu, pfvf, req_chan_base, req_chan_cnt,
+				       req_chan_base, req_chan_cnt);
 
 		rsp->tx_link = hw->cgx_links + hw->lbk_links;
 		rvu_npc_install_promisc_entry(rvu, pcifunc, nixlf,
@@ -912,33 +929,114 @@ static void nix_setup_lso(struct rvu *rvu, struct nix_hw *nix_hw, int blkaddr)
 	nix_hw->lso.in_use++;
 }
 
+static int nix_qctx_assign(struct rvu *rvu, int blkaddr, struct qmem **ctx,
+			   unsigned long **bmap, struct qmem *new_ctx,
+			   unsigned long *new_bmap)
+{
+	struct admin_queue *aq = rvu->hw->block[blkaddr].aq;
+	unsigned long flags;
+
+	if (!aq) {
+		WARN_ON_ONCE(1);
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&aq->lock, flags);
+	*ctx = new_ctx;
+	*bmap = new_bmap;
+	spin_unlock_irqrestore(&aq->lock, flags);
+
+	return 0;
+}
+
+static int nix_ctx_assign(struct rvu *rvu, int blkaddr, struct qmem **ctx,
+			  struct qmem *new_ctx)
+{
+	struct admin_queue *aq = rvu->hw->block[blkaddr].aq;
+	unsigned long flags;
+
+	if (!aq) {
+		WARN_ON_ONCE(1);
+		return -ENODEV;
+	}
+
+	spin_lock_irqsave(&aq->lock, flags);
+	*ctx = new_ctx;
+	spin_unlock_irqrestore(&aq->lock, flags);
+
+	return 0;
+}
+
 static void nix_ctx_free(struct rvu *rvu, struct rvu_pfvf *pfvf)
 {
-	kfree(pfvf->rq_bmap);
-	kfree(pfvf->sq_bmap);
-	kfree(pfvf->cq_bmap);
-	if (pfvf->rq_ctx)
-		qmem_free(rvu->dev, pfvf->rq_ctx);
-	if (pfvf->sq_ctx)
-		qmem_free(rvu->dev, pfvf->sq_ctx);
-	if (pfvf->cq_ctx)
-		qmem_free(rvu->dev, pfvf->cq_ctx);
-	if (pfvf->rss_ctx)
-		qmem_free(rvu->dev, pfvf->rss_ctx);
-	if (pfvf->nix_qints_ctx)
-		qmem_free(rvu->dev, pfvf->nix_qints_ctx);
-	if (pfvf->cq_ints_ctx)
-		qmem_free(rvu->dev, pfvf->cq_ints_ctx);
+	struct admin_queue *aq = rvu->hw->block[pfvf->nix_blkaddr].aq;
+	unsigned long *rq_bmap, *sq_bmap, *cq_bmap;
+	struct qmem *rq_ctx, *sq_ctx, *cq_ctx;
+	struct qmem *rss_ctx, *nix_qints_ctx, *cq_ints_ctx;
+	unsigned long flags;
+
+	if (!aq) {
+		WARN_ON_ONCE(1);
+		rq_bmap = pfvf->rq_bmap;
+		sq_bmap = pfvf->sq_bmap;
+		cq_bmap = pfvf->cq_bmap;
+		rq_ctx = pfvf->rq_ctx;
+		sq_ctx = pfvf->sq_ctx;
+		cq_ctx = pfvf->cq_ctx;
+		rss_ctx = pfvf->rss_ctx;
+		nix_qints_ctx = pfvf->nix_qints_ctx;
+		cq_ints_ctx = pfvf->cq_ints_ctx;
+
+		pfvf->rq_bmap = NULL;
+		pfvf->sq_bmap = NULL;
+		pfvf->cq_bmap = NULL;
+		pfvf->rq_ctx = NULL;
+		pfvf->sq_ctx = NULL;
+		pfvf->cq_ctx = NULL;
+		pfvf->rss_ctx = NULL;
+		pfvf->nix_qints_ctx = NULL;
+		pfvf->cq_ints_ctx = NULL;
+		goto free_ctx;
+	}
+
+	spin_lock_irqsave(&aq->lock, flags);
+	rq_bmap = pfvf->rq_bmap;
+	sq_bmap = pfvf->sq_bmap;
+	cq_bmap = pfvf->cq_bmap;
+	rq_ctx = pfvf->rq_ctx;
+	sq_ctx = pfvf->sq_ctx;
+	cq_ctx = pfvf->cq_ctx;
+	rss_ctx = pfvf->rss_ctx;
+	nix_qints_ctx = pfvf->nix_qints_ctx;
+	cq_ints_ctx = pfvf->cq_ints_ctx;
 
 	pfvf->rq_bmap = NULL;
-	pfvf->cq_bmap = NULL;
 	pfvf->sq_bmap = NULL;
+	pfvf->cq_bmap = NULL;
 	pfvf->rq_ctx = NULL;
 	pfvf->sq_ctx = NULL;
 	pfvf->cq_ctx = NULL;
 	pfvf->rss_ctx = NULL;
 	pfvf->nix_qints_ctx = NULL;
 	pfvf->cq_ints_ctx = NULL;
+	spin_unlock_irqrestore(&aq->lock, flags);
+
+free_ctx:
+	kfree(rq_bmap);
+	kfree(sq_bmap);
+	kfree(cq_bmap);
+	if (rq_ctx)
+		qmem_free(rvu->dev, rq_ctx);
+	if (sq_ctx)
+		qmem_free(rvu->dev, sq_ctx);
+	if (cq_ctx)
+		qmem_free(rvu->dev, cq_ctx);
+	if (rss_ctx)
+		qmem_free(rvu->dev, rss_ctx);
+	if (nix_qints_ctx)
+		qmem_free(rvu->dev, nix_qints_ctx);
+	if (cq_ints_ctx)
+		qmem_free(rvu->dev, cq_ints_ctx);
 }
 
 static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
@@ -946,6 +1044,7 @@ static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
 			      int rss_sz, int rss_grps, int hwctx_size,
 			      u64 way_mask, bool tag_lsb_as_adder)
 {
+	struct qmem *rss_ctx;
 	int err, grp, num_indices;
 	u64 val;
 
@@ -955,12 +1054,14 @@ static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
 	num_indices = rss_sz * rss_grps;
 
 	/* Alloc NIX RSS HW context memory and config the base */
-	err = qmem_alloc(rvu->dev, &pfvf->rss_ctx, num_indices, hwctx_size);
-	if (err)
+	err = qmem_alloc(rvu->dev, &rss_ctx, num_indices, hwctx_size);
+	if (err) {
+		qmem_free(rvu->dev, rss_ctx);
 		return err;
+	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RSS_BASE(nixlf),
-		    (u64)pfvf->rss_ctx->iova);
+		    (u64)rss_ctx->iova);
 
 	/* Config full RSS table size, enable RSS and caching */
 	val = BIT_ULL(36) | BIT_ULL(4) | way_mask << 20 |
@@ -974,6 +1075,13 @@ static int nixlf_rss_ctx_init(struct rvu *rvu, int blkaddr,
 	for (grp = 0; grp < rss_grps; grp++)
 		rvu_write64(rvu, blkaddr, NIX_AF_LFX_RSS_GRPX(nixlf, grp),
 			    ((ilog2(rss_sz) - 1) << 16) | (rss_sz * grp));
+
+	err = nix_ctx_assign(rvu, blkaddr, &pfvf->rss_ctx, rss_ctx);
+	if (err) {
+		qmem_free(rvu->dev, rss_ctx);
+		return err;
+	}
+
 	return 0;
 }
 
@@ -1514,6 +1622,9 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 				  struct nix_lf_alloc_rsp *rsp)
 {
 	int nixlf, qints, hwctx_size, intf, rc = 0, pf;
+	unsigned long *rq_bmap, *sq_bmap, *cq_bmap;
+	struct qmem *cq_ints_ctx, *nix_qints_ctx;
+	struct qmem *rq_ctx, *sq_ctx, *cq_ctx;
 	u16 bcast, mcast, promisc, ucast;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc = req->hdr.pcifunc;
@@ -1584,59 +1695,92 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 
 	/* Alloc NIX RQ HW context memory and config the base */
 	hwctx_size = 1UL << ((ctx_cfg >> 4) & 0xF);
-	rc = qmem_alloc(rvu->dev, &pfvf->rq_ctx, req->rq_cnt, hwctx_size);
-	if (rc)
+	rc = qmem_alloc(rvu->dev, &rq_ctx, req->rq_cnt, hwctx_size);
+	if (rc) {
+		qmem_free(rvu->dev, rq_ctx);
 		goto free_mem;
+	}
 
-	pfvf->rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
-	if (!pfvf->rq_bmap) {
+	rq_bmap = kcalloc(req->rq_cnt, sizeof(long), GFP_KERNEL);
+	if (!rq_bmap) {
+		qmem_free(rvu->dev, rq_ctx);
 		rc = -ENOMEM;
 		goto free_mem;
 	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_BASE(nixlf),
-		    (u64)pfvf->rq_ctx->iova);
+		    (u64)rq_ctx->iova);
 
 	/* Set caching and queue count in HW */
 	cfg = BIT_ULL(36) | (req->rq_cnt - 1) | req->way_mask << 20;
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_RQS_CFG(nixlf), cfg);
 
+	rc = nix_qctx_assign(rvu, blkaddr, &pfvf->rq_ctx, &pfvf->rq_bmap,
+			     rq_ctx, rq_bmap);
+	if (rc) {
+		kfree(rq_bmap);
+		qmem_free(rvu->dev, rq_ctx);
+		goto free_mem;
+	}
+
 	/* Alloc NIX SQ HW context memory and config the base */
 	hwctx_size = 1UL << (ctx_cfg & 0xF);
-	rc = qmem_alloc(rvu->dev, &pfvf->sq_ctx, req->sq_cnt, hwctx_size);
-	if (rc)
+	rc = qmem_alloc(rvu->dev, &sq_ctx, req->sq_cnt, hwctx_size);
+	if (rc) {
+		qmem_free(rvu->dev, sq_ctx);
 		goto free_mem;
+	}
 
-	pfvf->sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
-	if (!pfvf->sq_bmap) {
+	sq_bmap = kcalloc(req->sq_cnt, sizeof(long), GFP_KERNEL);
+	if (!sq_bmap) {
+		qmem_free(rvu->dev, sq_ctx);
 		rc = -ENOMEM;
 		goto free_mem;
 	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_SQS_BASE(nixlf),
-		    (u64)pfvf->sq_ctx->iova);
+		    (u64)sq_ctx->iova);
 
 	cfg = BIT_ULL(36) | (req->sq_cnt - 1) | req->way_mask << 20;
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_SQS_CFG(nixlf), cfg);
 
+	rc = nix_qctx_assign(rvu, blkaddr, &pfvf->sq_ctx, &pfvf->sq_bmap,
+			     sq_ctx, sq_bmap);
+	if (rc) {
+		kfree(sq_bmap);
+		qmem_free(rvu->dev, sq_ctx);
+		goto free_mem;
+	}
+
 	/* Alloc NIX CQ HW context memory and config the base */
 	hwctx_size = 1UL << ((ctx_cfg >> 8) & 0xF);
-	rc = qmem_alloc(rvu->dev, &pfvf->cq_ctx, req->cq_cnt, hwctx_size);
-	if (rc)
+	rc = qmem_alloc(rvu->dev, &cq_ctx, req->cq_cnt, hwctx_size);
+	if (rc) {
+		qmem_free(rvu->dev, cq_ctx);
 		goto free_mem;
+	}
 
-	pfvf->cq_bmap = kcalloc(req->cq_cnt, sizeof(long), GFP_KERNEL);
-	if (!pfvf->cq_bmap) {
+	cq_bmap = kcalloc(req->cq_cnt, sizeof(long), GFP_KERNEL);
+	if (!cq_bmap) {
+		qmem_free(rvu->dev, cq_ctx);
 		rc = -ENOMEM;
 		goto free_mem;
 	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CQS_BASE(nixlf),
-		    (u64)pfvf->cq_ctx->iova);
+		    (u64)cq_ctx->iova);
 
 	cfg = BIT_ULL(36) | (req->cq_cnt - 1) | req->way_mask << 20;
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CQS_CFG(nixlf), cfg);
 
+	rc = nix_qctx_assign(rvu, blkaddr, &pfvf->cq_ctx, &pfvf->cq_bmap,
+			     cq_ctx, cq_bmap);
+	if (rc) {
+		kfree(cq_bmap);
+		qmem_free(rvu->dev, cq_ctx);
+		goto free_mem;
+	}
+
 	/* Initialize receive side scaling (RSS) */
 	hwctx_size = 1UL << ((ctx_cfg >> 12) & 0xF);
 	rc = nixlf_rss_ctx_init(rvu, blkaddr, pfvf, nixlf, req->rss_sz,
@@ -1649,29 +1793,45 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
 	qints = (cfg >> 24) & 0xFFF;
 	hwctx_size = 1UL << ((ctx_cfg >> 24) & 0xF);
-	rc = qmem_alloc(rvu->dev, &pfvf->cq_ints_ctx, qints, hwctx_size);
-	if (rc)
+	rc = qmem_alloc(rvu->dev, &cq_ints_ctx, qints, hwctx_size);
+	if (rc) {
+		qmem_free(rvu->dev, cq_ints_ctx);
 		goto free_mem;
+	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_BASE(nixlf),
-		    (u64)pfvf->cq_ints_ctx->iova);
+		    (u64)cq_ints_ctx->iova);
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_CINTS_CFG(nixlf),
 		    BIT_ULL(36) | req->way_mask << 20);
 
+	rc = nix_ctx_assign(rvu, blkaddr, &pfvf->cq_ints_ctx, cq_ints_ctx);
+	if (rc) {
+		qmem_free(rvu->dev, cq_ints_ctx);
+		goto free_mem;
+	}
+
 	/* Alloc memory for QINT's HW contexts */
 	cfg = rvu_read64(rvu, blkaddr, NIX_AF_CONST2);
 	qints = (cfg >> 12) & 0xFFF;
 	hwctx_size = 1UL << ((ctx_cfg >> 20) & 0xF);
-	rc = qmem_alloc(rvu->dev, &pfvf->nix_qints_ctx, qints, hwctx_size);
-	if (rc)
+	rc = qmem_alloc(rvu->dev, &nix_qints_ctx, qints, hwctx_size);
+	if (rc) {
+		qmem_free(rvu->dev, nix_qints_ctx);
 		goto free_mem;
+	}
 
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_BASE(nixlf),
-		    (u64)pfvf->nix_qints_ctx->iova);
+		    (u64)nix_qints_ctx->iova);
 	rvu_write64(rvu, blkaddr, NIX_AF_LFX_QINTS_CFG(nixlf),
 		    BIT_ULL(36) | req->way_mask << 20);
 
+	rc = nix_ctx_assign(rvu, blkaddr, &pfvf->nix_qints_ctx, nix_qints_ctx);
+	if (rc) {
+		qmem_free(rvu->dev, nix_qints_ctx);
+		goto free_mem;
+	}
+
 	/* Setup VLANX TPID's.
 	 * Use VLAN1 for 802.1Q
 	 * and VLAN0 for 802.1AD.
@@ -1711,8 +1871,8 @@ int rvu_mbox_handler_nix_lf_alloc(struct rvu *rvu,
 	}
 
 	if (is_rep_dev(rvu, pcifunc)) {
-		pfvf->tx_chan_base = RVU_SWITCH_LBK_CHAN;
-		pfvf->tx_chan_cnt = 1;
+		nix_interface_set_chan(rvu, pfvf, 0, 0,
+				       RVU_SWITCH_LBK_CHAN, 1);
 		goto exit;
 	}
 
@@ -1816,6 +1976,8 @@ int rvu_mbox_handler_nix_lf_free(struct rvu *rvu, struct nix_lf_free_req *req,
 	nix_interface_deinit(rvu, pcifunc, nixlf);
 
 free_lf:
+	nix_interface_clear_chan(rvu, pfvf);
+
 	/* Reset this NIX LF */
 	err = rvu_lf_reset(rvu, block, nixlf);
 	if (err) {
@@ -2109,15 +2271,22 @@ static void nix_clear_tx_xoff(struct rvu *rvu, int blkaddr,
 	rvu_write64(rvu, blkaddr, reg, 0x0);
 }
 
-static int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
+int nix_get_tx_link(struct rvu *rvu, u16 pcifunc)
 {
-	struct rvu_hwinfo *hw = rvu->hw;
 	int pf = rvu_get_pf(rvu->pdev, pcifunc);
+	struct rvu_hwinfo *hw = rvu->hw;
+	struct rvu_pfvf *pfvf;
 	u8 cgx_id = 0, lmac_id = 0;
 
-	if (is_lbk_vf(rvu, pcifunc)) {/* LBK links */
+	if (is_rep_dev(rvu, pcifunc))
 		return hw->cgx_links;
-	} else if (is_pf_cgxmapped(rvu, pf)) {
+
+	if (is_lbk_vf(rvu, pcifunc)) {
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
+		return hw->cgx_links + pfvf->lbkid;
+	}
+
+	if (is_pf_cgxmapped(rvu, pf)) {
 		rvu_get_cgx_lmac_id(rvu->pf2cgxlmac_map[pf], &cgx_id, &lmac_id);
 		return (cgx_id * hw->lmac_per_cgx) + lmac_id;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c34f8d86cc8a..25101541d20b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -3544,6 +3544,53 @@ int rvu_mbox_handler_npc_mcam_free_entry(struct rvu *rvu,
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
+		dev_err_ratelimited(rvu->dev, "Invalid cnt=%u\n", cnt);
+		return -EINVAL;
+	}
+
+	/* Snapshot shared mailbox memory before processing the request. */
+	memcpy(entry, mreq->entry, cnt * sizeof(entry[0]));
+
+	for (i = 0; i < cnt; i++) {
+		dreq.entry = entry[i];
+		ret = rvu_mbox_handler_npc_delete_flow(rvu, &dreq, &drsp);
+		if (ret) {
+			dev_err_ratelimited(rvu->dev,
+					    "delete flow error for i=%d entry=%d\n",
+					    i, entry[i]);
+			err = true;
+		}
+
+		sreq.entry = entry[i];
+		ret = rvu_mbox_handler_npc_mcam_free_entry(rvu, &sreq, rsp);
+		if (ret) {
+			dev_err_ratelimited(rvu->dev,
+					    "free entry error for i=%d entry=%d\n",
+					    i, entry[i]);
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
@@ -4443,6 +4490,83 @@ int rvu_mbox_handler_npc_mcam_entry_stats(struct rvu *rvu,
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
+	rsp->cnt = 0;
+	memset(rsp->rsvd, 0, sizeof(rsp->rsvd));
+	memset(rsp->stat, 0, sizeof(rsp->stat));
+
+	req_cnt = req->cnt;
+	if (!req_cnt || req_cnt > 256) {
+		dev_err_ratelimited(rvu->dev, "%s invalid request cnt=%u\n",
+				    __func__, req_cnt);
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
+			dev_err_ratelimited(rvu->dev, "%s invalid mcam index=%d\n",
+					    __func__, entry[i]);
+			memset(rsp->stat, 0, sizeof(rsp->stat));
+			rsp->cnt = 0;
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
index d422bdd5e8f8..30e55d44a7c4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1931,6 +1931,20 @@ static int npc_delete_flow(struct rvu *rvu, struct rvu_npc_mcam_rule *rule,
 	return rvu_mbox_handler_npc_mcam_dis_entry(rvu, &dis_req, &dis_rsp);
 }
 
+int rvu_mbox_handler_npc_mcam_get_features(struct rvu *rvu,
+					   struct msg_req *req,
+					   struct npc_mcam_get_features_rsp *rsp)
+{
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+
+	mutex_lock(&mcam->lock);
+	rsp->rx_features = mcam->rx_features;
+	rsp->tx_features = mcam->tx_features;
+	mutex_unlock(&mcam->lock);
+
+	return 0;
+}
+
 int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 				     struct npc_delete_flow_req *req,
 				     struct npc_delete_flow_rsp *rsp)
@@ -1939,7 +1953,7 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 	struct rvu_npc_mcam_rule *iter, *tmp;
 	u16 pcifunc = req->hdr.pcifunc;
 	struct list_head del_list;
-	int blkaddr;
+	int blkaddr, err;
 
 	req->entry = npc_cn20k_vidx2idx(req->entry);
 	req->start = npc_cn20k_vidx2idx(req->start);
@@ -1970,17 +1984,20 @@ int rvu_mbox_handler_npc_delete_flow(struct rvu *rvu,
 	}
 	mutex_unlock(&mcam->lock);
 
+	err = 0;
 	list_for_each_entry_safe(iter, tmp, &del_list, list) {
 		u16 entry = iter->entry;
 
 		/* clear the mcam entry target pcifunc */
 		mcam->entry2target_pffunc[entry] = 0x0;
-		if (npc_delete_flow(rvu, iter, pcifunc))
+		if (npc_delete_flow(rvu, iter, pcifunc)) {
 			dev_err(rvu->dev, "rule deletion failed for entry:%u",
 				entry);
+			err = -EINVAL;
+		}
 	}
 
-	return 0;
+	return err;
 }
 
 static int npc_update_dmac_value(struct rvu *rvu, int npcblkaddr,
-- 
2.43.0

