Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE08E1AA1F4;
	Tue, 15 Sep 2026 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789440635; cv=none; b=pHEVoTGNnQeO+wwcyuYm1zS1P4nuvrsN7uh4QWqPoTmp9Ba7hMh1IoE8ROPknWK22OD4/CisXt35VeiZOa2r820jkk34SwZHGmjPH96p5+hz1plULEQDTQD90E6nve/iWyI9rz3cVvtp91RoLur0CSxXH9xX1R6eDqX2eBTnR9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789440635; c=relaxed/simple;
	bh=frh3ObrhjTVqNa6Jys6D7rvWIIWu8Y8eyUThhzNnUsk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGQjveYf/QfBfJJ2cbQHJUDV0n5K/NlAl273mGchrLNw86qOuOtAYG/qFoIpr08mdfPjCbmV0fg1IucFwhanCrdXuNogx8MHU8Db6XzntJtnJ4/Jlgbfoml24XLBn4G/YUYKwzZX7IGzXOEdUeu3I7FTXk54YkC7TNRYplZXRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=KbuzGd9I; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="KbuzGd9I"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F2nRHf2218664;
	Mon, 14 Sep 2026 19:50:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=fYczLW83hvbHqsKEdPQPC2z
	sHwxX6g6KY7iIOGACx6A=; b=KbuzGd9I565l5dZOsds5ShlyyjG1Fy7hpaorPEe
	gfr52AfD0+8NLwokBcILHuj2WcCqKWpRM8bixQyOSjUNnSYBwxOYQW3UyHU3ILh+
	izRnCplUUVhVCB1MNM5E3Zvv1cIkL2RCpIQWBINVBVF9wJjK6UJuYb+nbjEdE3un
	6oYA3EcDLuaaU75ywH5YY3a3daJN5xkSYE0ssaxdO3NZsvDW98LhYpdnD72yveY/
	0l7yxlahPOoi2n+RdpAW20qFTWge9cfmTSMtYZ+JHeb6A30/G5Bjh4K9t3Q/1Bvy
	DPjJ2UFVPDhrh5i97crQwbuIv/bJuBKWNh0mL4PT7/yaDNQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gpm9fjv3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 19:50:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 14 Sep 2026 19:50:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 14 Sep 2026 19:50:24 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5E2253F709B;
	Mon, 14 Sep 2026 19:50:21 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: Add tracepoints for NPC MCAM entry programming
Date: Tue, 15 Sep 2026 08:20:14 +0530
Message-ID: <20260915025014.928685-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VtS2kO2n c=1 sm=1 tr=0 ts=6aa8b271 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=aXzhG4ZTir5nOSg0BBgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAzNiBTYWx0ZWRfXz0NSa2ewg2yQ
 w880oV3tubTtE1e2EhU8vQYXbKoUcLrRCJKzcPZ7TQvjLFKiIdVEp85sLl8rQDLnJqIrPUsS8DC
 1INbqXuxkNWxEWO+lcFt9i6pVkAJYFu0zOIBNPMGRKHAhTaYXWH0cNnzgLloXw+FStb2f5xdW08
 uWxTcu7g0wWJhhUt+U+Qq98t7HvdBPOUq6J95mdaCWON4Xp9ebsIyG9uu5j4lGeZ4GL/rxDNw0G
 ZDK6O7ossIR3CaweAROH1F+YejyRLiVszVuQ50wYLpgfd9jR+RTcVrG5RsUwYZql+wz4tYE1WJM
 LHIjcDFbqehXD1+jmZRcuiMd+GVkttfZgeUXnilYFMh/Pk41HD4X4oQeHB1iXWFgRwAUKfgaffo
 qaxTb9CV5PofjGX1v65BDRK2pVNrgqWBPuIjEyZiFUIMO+M0k1gtCQaT89n3wKWMj4+RYzzfdb/
 ibcAyUT1/Zew2I4yJLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAzNiBTYWx0ZWRfX+UobVg8ijqWC
 lgk37O/hyIdwg6Poz9Pw3q4lb+cflgxeigD8ViAGJcQUNQMVTOIvXWZChYwwu3szvP68YtwqfLk
 SaLNA2O7XeP6slgF3zktacu1Hd0F4i8=
X-Proofpoint-ORIG-GUID: wmD8qyzUxhLRIflomvoDA_YodIX69rkS
X-Proofpoint-GUID: wmD8qyzUxhLRIflomvoDA_YodIX69rkS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Add ftrace events to observe NPC MCAM allocation, CAM keyword
programming, action/VLAN tag writes, and entry enable/disable in the
AF driver. Emit traces from npc_mcam_alloc_entries(),
npc_config_mcam_entry(), npc_read_mcam_entry(), and
npc_enable_mcam_entry() so live systems can correlate mailbox-driven
rule changes with the underlying MCAM state.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 46 +++++----
 .../ethernet/marvell/octeontx2/af/rvu_trace.c |  4 +
 .../ethernet/marvell/octeontx2/af/rvu_trace.h | 99 +++++++++++++++++++
 3 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index c34f8d86cc8a..ae373558975e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -20,6 +20,7 @@
 #include "rvu_npc.h"
 #include "cn20k/reg.h"
 #include "lmac_common.h"
+#include <rvu_trace.h>
 
 #define RSVD_MCAM_ENTRIES_PER_PF	3 /* Broadcast, Promisc and AllMulticast */
 #define RSVD_MCAM_ENTRIES_PER_NIXLF	1 /* Ucast for LFs */
@@ -259,6 +260,7 @@ void npc_enable_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	int bank = npc_get_bank(mcam, index);
 	int actbank = bank;
 
+	trace_otx2_npc_enable_mcam_entry(index, (u8)enable);
 	if (is_cn20k(rvu->pdev)) {
 		if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
 			dev_err(rvu->dev, "Error to %s mcam %u entry\n",
@@ -521,10 +523,10 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 				  struct mcam_entry *entry, bool enable)
 {
 	int bank = npc_get_bank(mcam, index);
+	u64 w0_cam0, w0_cam1, w1_cam0, w1_cam1;
 	int kw = 0, actbank, actindex;
 	u8 tx_intf_mask = ~intf & 0x3;
 	u8 tx_intf = intf;
-	u64 cam0, cam1;
 
 	actbank = bank; /* Save bank id, to set action later on */
 	actindex = index;
@@ -561,17 +563,18 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			    tx_intf_mask);
 
 		/* Set the match key */
-		npc_get_keyword(entry, kw, &cam0, &cam1);
+		npc_get_keyword(entry, kw, &w0_cam0, &w0_cam1);
 		rvu_write64(rvu, blkaddr,
-			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 1), cam1);
+			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 1), w0_cam1);
 		rvu_write64(rvu, blkaddr,
-			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 0), cam0);
+			    NPC_AF_MCAMEX_BANKX_CAMX_W0(index, bank, 0), w0_cam0);
 
-		npc_get_keyword(entry, kw + 1, &cam0, &cam1);
+		npc_get_keyword(entry, kw + 1, &w1_cam0, &w1_cam1);
 		rvu_write64(rvu, blkaddr,
-			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 1), cam1);
+			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 1), w1_cam1);
 		rvu_write64(rvu, blkaddr,
-			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 0), cam0);
+			    NPC_AF_MCAMEX_BANKX_CAMX_W1(index, bank, 0), w1_cam0);
+		trace_otx2_npc_cam(index, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
 	}
 
 	/* PF installing VF rule */
@@ -586,6 +589,8 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	rvu_write64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_TAG_ACT(index, actbank),
 		    entry->vtag_action);
 
+	trace_otx2_npc_action(index, actbank, tx_intf, (u8)enable,
+			      entry->action, entry->vtag_action);
 	/* Enable the entry */
 	if (enable)
 		npc_enable_mcam_entry(rvu, mcam, blkaddr, actindex, true);
@@ -596,24 +601,25 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 struct mcam_entry *entry, u8 *intf, u8 *ena)
 {
 	int sbank = npc_get_bank(mcam, src);
+	u64 w0_cam0, w0_cam1, w1_cam0, w1_cam1;
 	int bank, kw = 0;
-	u64 cam0, cam1;
 
 	src &= (mcam->banksize - 1);
 	bank = sbank;
 
 	for (; bank < (sbank + mcam->banks_per_entry); bank++, kw = kw + 2) {
-		cam1 = rvu_read64(rvu, blkaddr,
-				  NPC_AF_MCAMEX_BANKX_CAMX_W0(src, bank, 1));
-		cam0 = rvu_read64(rvu, blkaddr,
-				  NPC_AF_MCAMEX_BANKX_CAMX_W0(src, bank, 0));
-		npc_fill_entryword(entry, kw, cam0, cam1);
+		w0_cam1 = rvu_read64(rvu, blkaddr,
+				     NPC_AF_MCAMEX_BANKX_CAMX_W0(src, bank, 1));
+		w0_cam0 = rvu_read64(rvu, blkaddr,
+				     NPC_AF_MCAMEX_BANKX_CAMX_W0(src, bank, 0));
+		npc_fill_entryword(entry, kw, w0_cam0, w0_cam1);
 
-		cam1 = rvu_read64(rvu, blkaddr,
-				  NPC_AF_MCAMEX_BANKX_CAMX_W1(src, bank, 1));
-		cam0 = rvu_read64(rvu, blkaddr,
-				  NPC_AF_MCAMEX_BANKX_CAMX_W1(src, bank, 0));
-		npc_fill_entryword(entry, kw + 1, cam0, cam1);
+		w1_cam1 = rvu_read64(rvu, blkaddr,
+				     NPC_AF_MCAMEX_BANKX_CAMX_W1(src, bank, 1));
+		w1_cam0 = rvu_read64(rvu, blkaddr,
+				     NPC_AF_MCAMEX_BANKX_CAMX_W1(src, bank, 0));
+		npc_fill_entryword(entry, kw + 1, w1_cam0, w1_cam1);
+		trace_otx2_npc_cam(src, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
 	}
 
 	entry->action = rvu_read64(rvu, blkaddr,
@@ -625,6 +631,8 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			   NPC_AF_MCAMEX_BANKX_CAMX_INTF(src, sbank, 1)) & 3;
 	*ena = rvu_read64(rvu, blkaddr,
 			  NPC_AF_MCAMEX_BANKX_CFG(src, sbank)) & 1;
+	trace_otx2_npc_action(src, sbank, *intf, *ena,
+			      entry->action, entry->vtag_action);
 }
 
 static int npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
@@ -3197,6 +3205,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	rsp->free_count = -1;
 	mutex_unlock(&mcam->lock);
 
+	trace_otx2_npc_mcam_alloc_entries(pcifunc, req, rsp);
 	return 0;
 
 not_cn20k:
@@ -3383,6 +3392,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	rsp->free_count = mcam->bmap_fcnt;
 
 	mutex_unlock(&mcam->lock);
+	trace_otx2_npc_mcam_alloc_entries(pcifunc, req, rsp);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
index 19e0d16b12f6..0919c4398dc4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
@@ -13,3 +13,7 @@ EXPORT_TRACEPOINT_SYMBOL(otx2_msg_interrupt);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_process);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_status);
 EXPORT_TRACEPOINT_SYMBOL(otx2_parse_dump);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_mcam_alloc_entries);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_enable_mcam_entry);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_cam);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_action);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index 4cd0fc4b0d20..77dc1b4a4c64 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -159,6 +159,105 @@ TRACE_EVENT(otx2_parse_dump,
 		      __entry->w3, __entry->w4, __entry->w5)
 );
 
+TRACE_EVENT(otx2_npc_mcam_alloc_entries,
+	    TP_PROTO(u16 pcifunc,
+		     struct npc_mcam_alloc_entry_req *req,
+		     struct npc_mcam_alloc_entry_rsp *rsp),
+	    TP_ARGS(pcifunc, req, rsp),
+	    TP_STRUCT__entry(__field(u16, pcifunc)
+			     __field(u8, contig)
+			     __field(u8, ref_prio)
+			     __field(u16, ref_entry)
+			     __field(u16, req_count)
+			     __field(u8, kw_type)
+			     __field(u8, virt)
+			     __field(u16, start_mcam_idx)
+			     __field(u16, rsp_count)
+			     __field(u16, free_count)
+	    ),
+	    TP_fast_assign(__entry->contig = req->contig;
+			   __entry->ref_prio = req->ref_prio;
+			   __entry->ref_entry = req->ref_entry;
+			   __entry->req_count = req->count;
+			   __entry->kw_type = req->kw_type;
+			   __entry->virt = req->virt;
+			   __entry->start_mcam_idx = rsp->entry;
+			   __entry->rsp_count = rsp->count;
+			   __entry->free_count = rsp->free_count;
+	    ),
+	    TP_printk("pcifunc:%d req_contig:%d req_ref_prio:%d req->ref_entry:%d req->req_count:%d req->kw_type:%d req->virt:%d rsp_start_mcam_idx:%d rsp_count:%d rsp_free_count:%d\n",
+		      __entry->pcifunc, __entry->contig, __entry->ref_prio,
+		      __entry->ref_entry, __entry->req_count, __entry->kw_type,
+		      __entry->virt, __entry->start_mcam_idx, __entry->rsp_count,
+		      __entry->free_count)
+);
+
+TRACE_EVENT(otx2_npc_enable_mcam_entry,
+	    TP_PROTO(u16 index, u8 enable),
+	    TP_ARGS(index, enable),
+	    TP_STRUCT__entry(__field(u16, mcam_index)
+			     __field(u8, ena)
+	    ),
+	    TP_fast_assign(__entry->mcam_index = index;
+			   __entry->ena = enable;
+	    ),
+	    TP_printk("mcam_index:%d enable:%d\n", __entry->mcam_index, __entry->ena)
+);
+
+TRACE_EVENT(otx2_npc_cam,
+	    TP_PROTO(u16 index, u8 bank,
+		     u64 w0_cam0,
+		     u64 w0_cam1,
+		     u64 w1_cam0,
+		     u64 w1_cam1),
+	    TP_ARGS(index, bank,
+		    w0_cam0, w0_cam1,
+		    w1_cam0, w1_cam1),
+	    TP_STRUCT__entry(__field(u16, mcam_index)
+			     __field(u8, bank)
+			     __field(u64, w0_cam0)
+			     __field(u64, w0_cam1)
+			     __field(u64, w1_cam0)
+			     __field(u64, w1_cam1)
+	    ),
+	    TP_fast_assign(__entry->mcam_index = index;
+			   __entry->bank = bank;
+			   __entry->w0_cam0 = w0_cam0;
+			   __entry->w0_cam1 = w0_cam1;
+			   __entry->w1_cam0 = w1_cam0;
+			   __entry->w1_cam1 = w1_cam1;
+	    ),
+	    TP_printk("mcam_index:%d bank:%d w0_cam0:0x%llx w0_cam1:0x%llx, w1_cam0:0x%llx, w1_cam1:0x%llx\n",
+		      __entry->mcam_index, __entry->bank, __entry->w0_cam0, __entry->w0_cam1,
+		      __entry->w1_cam0, __entry->w1_cam1)
+);
+
+TRACE_EVENT(otx2_npc_action,
+	    TP_PROTO(u16 index, u8 bank,
+		     u8 tx_intf, u8 enable,
+		     u64 act, u64 vtag_act),
+	    TP_ARGS(index, bank,
+		    tx_intf, enable,
+		    act, vtag_act),
+	    TP_STRUCT__entry(__field(u16, mcam_index)
+			     __field(u8, bank)
+			     __field(u8, tx_intf)
+			     __field(u8, enable)
+			     __field(u64, act)
+			     __field(u64, vtag_act)
+	    ),
+	    TP_fast_assign(__entry->mcam_index = index;
+			   __entry->bank = bank;
+			   __entry->tx_intf = tx_intf;
+			   __entry->enable = enable;
+			   __entry->act = act;
+			   __entry->vtag_act = vtag_act;
+	    ),
+	    TP_printk("mcam_index:%d bank:%d tx_intf:%d enable:%d action:0x%llx vtag_action:0x%llx\n",
+		      __entry->mcam_index, __entry->bank, __entry->tx_intf,
+		      __entry->enable, __entry->act, __entry->vtag_act)
+);
+
 #endif /* __RVU_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.43.0

