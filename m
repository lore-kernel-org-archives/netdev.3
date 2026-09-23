Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCAF3346BE;
	Wed, 23 Sep 2026 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790135367; cv=none; b=fc0ot8AuWJB3gKFaEPb8QL6BRnfTSZgXPaaGKMLK6k2VEYBmjIWP6jwrQtIpX+7sbvVdww5ZIlZXCUU/MZIw+zEP0O9g0pDBngFlKjarygIyqym1N86P52fzAKhwy5O+Fno5+VwmSxY1Fz4Kg7hdii8DYsK/0gEePE40xt3ctNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790135367; c=relaxed/simple;
	bh=oIXz9VeWfSFb+AYIbiqq6yhW8QuKqSK1jRxcoV5B42g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gbh8PkjcCRF8nLGcCXlSanW5t8N0gDR3Qj9fwe8G1KiPnNtR9Hs1qA45TMYzSGF8bRI1Ad6cCTdEjh87kqETNAYtwzpITP/QcL495R0RGQATfPFLouzsDvrg2ImT7FaZqLEb81ecg+QqTimAbLVhBQLKn8elTaA3dq1LOZlXCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=foWISRMn; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="foWISRMn"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3iLMf1066107;
	Tue, 22 Sep 2026 20:49:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=VvnFDo/YZI+DUPvGGt7pLtF
	u9CrmHexkxkzbIdEkY2s=; b=foWISRMn0p+CfWp6OqYfVGFJMB8q+X1EV3EC3Ba
	lO7vJhsCzppiFxSUpKkpKHgc14BLQzCDWlmdPZsyPV4K8t0sOrlTU3L5Cl83zWGD
	NZZWZWShcT9ArX65U13MOUtxm1prf7cO5KOHhTCZTxHWW63G4GzUMLU8MNVuI0NN
	f+RkhMjjjFYQKRUi4U+O5CIVcqr6oBglfITJq3gRi9KM9bPBqauL+nrbZstYmlwc
	zkJxDR0rL6/inh4/ISivGao65JQQS/LNocWxPW3WZ6p+K1J8UH92WnoMY4CqUmu+
	G8PJFL1I/MaPq/JELRk+groUvk9nwFlI+lhQJrspuTMH7aA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4guvwu3fn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 20:49:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 22 Sep 2026 20:49:09 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 22 Sep 2026 20:49:09 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id D8B4D3F7077;
	Tue, 22 Sep 2026 20:49:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Suman Ghosh
	<sumang@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net-next] octeontx2-af: add tracepoints for NPC MCAM entry programming
Date: Wed, 23 Sep 2026 09:18:58 +0530
Message-ID: <20260923034858.1764461-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 7vEq0x9wMlo5xbd8sVfg0h9KNLGb9KSD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxNCBTYWx0ZWRfX/Rfn9zxlMJox
 O8yHA53AlAJ+2qujScurL9LPlmzbjRTwXuQCxgExDQvsYQYhvA61Oz+6VRwCs12DxRNFDuhEFXO
 5ZKXDpC2usm9HJVb54viNQJxwSqwOGI=
X-Authority-Analysis: v=2.4 cv=b/UncdGx c=1 sm=1 tr=0 ts=6ab34c3c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=GYVh84BQpdABKaSdmJcA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxNCBTYWx0ZWRfX5CRZpxZ5EOi6
 A9hgy9OgG6tmT8NUfiX1LPeDorYSS2zzypbAaYbNQO75S/qDUiQ4KABf64te4oCAofaw2kcg2Fw
 IBxEnKRiz/EzlAn1f7W3VFEQryvjtdaSg/3hvM35EYAzCs9ql130RwFoYxYJyN60YScGJ7Hf4Lo
 5iIvH0pR8z+5/2p4Oowi8inWfcRO+K0EbZdp0BJvOIk9SPePhKvL4lhcLRKCZnjlghy8Wno9TYZ
 /ntVNyl+M0lD6jy90hM6/LNGahd3m7vgtzTboT6R+OcZOicjTQIjSotG+F5eZWfbXdW2MkB7TAC
 sHPG3YOKK4hZTL9uWhnFW1X1YkS8oCM3R9CqQAzJr+Tm8CXQDmGzzAa1HAs9t21Vvd0pYEcXWjQ
 JNuyMCGPl0F1OZmmj/ZfRQc4CIR6k5HHESQlHdZKqj7LDGzpIWsd2DY7HSmTvwah7FsiCmNs7n/
 j1kn75yghEPvlxSGppw==
X-Proofpoint-GUID: 7vEq0x9wMlo5xbd8sVfg0h9KNLGb9KSD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_02,2026-09-21_02,2025-10-01_01

From: Suman Ghosh <sumang@marvell.com>

Add ftrace events for MCAM allocation, CAM keyword writes, action/tag
programming, enable/disable, and entry copies. Emit them from the legacy
and CN20K NPC alloc, config, read, and shift paths so mailbox-driven
rule changes can be correlated with the programmed MCAM state.

---

v1 -> v2: Addressed sashiko comments.
- Assign pcifunc in otx2_npc_mcam_alloc_entries() and print it as 0x%x;
  record start_mcam_idx from rsp->entry_list[0] for non-contiguous
  allocations.
- Pass absolute actindex to cam/action traces and mask tx_intf to 0x1 on
  TX interfaces so emitters agree on mcam_index and tx_intf semantics.
- Add otx2_npc_mcam_copy and emit it from npc_copy_mcam_entry() to cover
  MCAM entry shifts; emit cam/action traces from the CN20K config path.
- Drop redundant TP_printk newlines; zero npc_mcam_alloc_entry_req on
  stack in alloc-and-write mailbox handlers before tracing kw_type/virt.
	https://lore.kernel.org/netdev/20260915025014.928685-1-rkannoth@marvell.com/

Signed-off-by: Suman Ghosh <sumang@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../ethernet/marvell/octeontx2/af/cn20k/npc.c |  51 +++++---
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   |  69 +++++++----
 .../ethernet/marvell/octeontx2/af/rvu_trace.c |   5 +
 .../ethernet/marvell/octeontx2/af/rvu_trace.h | 114 ++++++++++++++++++
 4 files changed, 196 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
index 7c829b1da3e5..0b485728f399 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/npc.c
@@ -15,6 +15,7 @@
 #include "cn20k/npc.h"
 #include "cn20k/reg.h"
 #include "rvu_npc_fs.h"
+#include <rvu_trace.h>
 
 static struct npc_priv_t *npc_priv;
 
@@ -973,13 +974,15 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
 				   struct cn20k_mcam_entry *entry,
 				   int bank, u8 kw_type, int kw,
-				   u8 req_kw_type)
+				   u8 req_kw_type, u16 actindex)
 {
+	u64 w0_cam0, w0_cam1, w1_cam0, w1_cam1;
+	u64 w2_cam0, w2_cam1, w3_cam0, w3_cam1;
 	u64 intf_ext = 0, intf_ext_mask = 0;
 	u8 tx_intf_mask = ~intf & 0x3;
 	u8 tx_intf = intf, kex_type;
 	u8 kw_type_mask = ~kw_type;
-	u64 cam0, cam1, kex_cfg;
+	u64 kex_cfg;
 
 	if (is_npc_intf_tx(intf)) {
 		/* Last bit must be set and rest don't care
@@ -1018,43 +1021,46 @@ static void npc_cn20k_config_kw_x2(struct rvu *rvu, struct npc_mcam *mcam,
 		    intf_ext_mask);
 
 	/* Set the match key */
-	npc_cn20k_get_keyword(entry, kw, &cam0, &cam1);
+	npc_cn20k_get_keyword(entry, kw, &w0_cam0, &w0_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 1),
-		    cam1);
+		    w0_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W0_EXT(index, bank, 0),
-		    cam0);
+		    w0_cam0);
 
-	npc_cn20k_get_keyword(entry, kw + 1, &cam0, &cam1);
+	npc_cn20k_get_keyword(entry, kw + 1, &w1_cam0, &w1_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 1),
-		    cam1);
+		    w1_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W1_EXT(index, bank, 0),
-		    cam0);
+		    w1_cam0);
 
-	npc_cn20k_get_keyword(entry, kw + 2, &cam0, &cam1);
+	npc_cn20k_get_keyword(entry, kw + 2, &w2_cam0, &w2_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 1),
-		    cam1);
+		    w2_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W2_EXT(index, bank, 0),
-		    cam0);
+		    w2_cam0);
 
-	npc_cn20k_get_keyword(entry, kw + 3, &cam0, &cam1);
+	npc_cn20k_get_keyword(entry, kw + 3, &w3_cam0, &w3_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 1),
-		    cam1);
+		    w3_cam1);
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_CN20K_MCAMEX_BANKX_CAMX_W3_EXT(index, bank, 0),
-		    cam0);
+		    w3_cam0);
+
+	trace_otx2_npc_cam(actindex, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
+	trace_otx2_npc_cam(actindex, bank, w2_cam0, w2_cam1, w3_cam0, w3_cam1);
 }
 
 static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 				   int blkaddr, int index, u8 intf,
 				   struct cn20k_mcam_entry *entry,
-				   u8 kw_type, u8 req_kw_type)
+				   u8 kw_type, u8 req_kw_type, u16 actindex)
 {
 	int kw = 0, bank;
 
@@ -1062,7 +1068,7 @@ static void npc_cn20k_config_kw_x4(struct rvu *rvu, struct npc_mcam *mcam,
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       index, intf,
 				       entry, bank, kw_type,
-				       kw, req_kw_type);
+				       kw, req_kw_type, actindex);
 }
 
 int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
@@ -1071,10 +1077,11 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 {
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	int mcam_idx = index % mcam->banksize;
+	int actbank = npc_get_bank(mcam, index);
 	int bank = index / mcam->banksize;
 	u64 bank_cfg = (u64)hw_prio << 24;
+	u8 kw_type, tx_intf = intf;
 	int kw = 0;
-	u8 kw_type;
 
 	if (index < 0 || index >= mcam->total_entries)
 		return -EINVAL;
@@ -1097,7 +1104,7 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 		npc_clear_x2_entry(rvu, blkaddr, bank, mcam_idx);
 		npc_cn20k_config_kw_x2(rvu, mcam, blkaddr,
 				       mcam_idx, intf, entry,
-				       bank, kw_type, kw, req_kw_type);
+				       bank, kw_type, kw, req_kw_type, index);
 		/* Set 'action' */
 		rvu_write64(rvu, blkaddr,
 			    NPC_AF_CN20K_MCAMEX_BANKX_ACTIONX_EXT(mcam_idx,
@@ -1128,7 +1135,7 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 
 		npc_cn20k_config_kw_x4(rvu, mcam, blkaddr,
 				       mcam_idx, intf, entry,
-				       kw_type, req_kw_type);
+				       kw_type, req_kw_type, index);
 		for (bank = 0; bank < mcam->banks_per_entry; bank++) {
 			/* Set 'action' */
 			rvu_write64(rvu, blkaddr,
@@ -1157,6 +1164,10 @@ int npc_cn20k_config_mcam_entry(struct rvu *rvu, int blkaddr, int index,
 
 	/* TODO: */
 	/* PF installing VF rule */
+	if (is_npc_intf_tx(intf))
+		tx_intf &= 0x1;
+	trace_otx2_npc_action(index, actbank, tx_intf, (u8)enable,
+			      entry->action, entry->vtag_action);
 	if (npc_cn20k_enable_mcam_entry(rvu, blkaddr, index, enable))
 		return -EINVAL;
 
@@ -1434,7 +1445,7 @@ int rvu_mbox_handler_npc_cn20k_mcam_alloc_and_write_entry(struct rvu *rvu,
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
 	struct npc_mcam_free_entry_req free_req = { 0 };
-	struct npc_mcam_alloc_entry_req entry_req;
+	struct npc_mcam_alloc_entry_req entry_req = { 0 };
 	struct npc_mcam_alloc_entry_rsp entry_rsp;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u16 entry = NPC_MCAM_ENTRY_INVALID;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 42a601976db3..fe8625ee4051 100644
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
+		trace_otx2_npc_cam(actindex, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
 	}
 
 	/* PF installing VF rule */
@@ -586,6 +589,10 @@ static void npc_config_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 	rvu_write64(rvu, blkaddr, NPC_AF_MCAMEX_BANKX_TAG_ACT(index, actbank),
 		    entry->vtag_action);
 
+	if (is_npc_intf_tx(intf))
+		tx_intf &= 0x1;
+	trace_otx2_npc_action(actindex, actbank, tx_intf, (u8)enable,
+			      entry->action, entry->vtag_action);
 	/* Enable the entry */
 	if (enable)
 		npc_enable_mcam_entry(rvu, mcam, blkaddr, actindex, true);
@@ -596,24 +603,27 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 struct mcam_entry *entry, u8 *intf, u8 *ena)
 {
 	int sbank = npc_get_bank(mcam, src);
+	u64 w0_cam0, w0_cam1, w1_cam0, w1_cam1;
+	u16 actindex = src;
+	u8 tx_intf;
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
+		trace_otx2_npc_cam(actindex, bank, w0_cam0, w0_cam1, w1_cam0, w1_cam1);
 	}
 
 	entry->action = rvu_read64(rvu, blkaddr,
@@ -625,18 +635,28 @@ void npc_read_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			   NPC_AF_MCAMEX_BANKX_CAMX_INTF(src, sbank, 1)) & 3;
 	*ena = rvu_read64(rvu, blkaddr,
 			  NPC_AF_MCAMEX_BANKX_CFG(src, sbank)) & 1;
+	tx_intf = *intf;
+	if (is_npc_intf_tx(tx_intf))
+		tx_intf &= 0x1;
+	trace_otx2_npc_action(actindex, sbank, tx_intf, *ena,
+			      entry->action, entry->vtag_action);
 }
 
 static int npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			       int blkaddr, u16 src, u16 dest)
 {
+	u64 cfg, sreg, dreg;
+	u16 orig_src = src, orig_dest = dest;
 	int dbank = npc_get_bank(mcam, dest);
 	int sbank = npc_get_bank(mcam, src);
-	u64 cfg, sreg, dreg;
-	int bank, i;
+	int bank, i, err;
 
-	if (is_cn20k(rvu->pdev))
-		return npc_cn20k_copy_mcam_entry(rvu, blkaddr, src, dest);
+	if (is_cn20k(rvu->pdev)) {
+		err = npc_cn20k_copy_mcam_entry(rvu, blkaddr, src, dest);
+		if (!err)
+			trace_otx2_npc_mcam_copy(orig_src, orig_dest);
+		return err;
+	}
 
 	src &= (mcam->banksize - 1);
 	dest &= (mcam->banksize - 1);
@@ -668,6 +688,7 @@ static int npc_copy_mcam_entry(struct rvu *rvu, struct npc_mcam *mcam,
 			 NPC_AF_MCAMEX_BANKX_CFG(src, sbank));
 	rvu_write64(rvu, blkaddr,
 		    NPC_AF_MCAMEX_BANKX_CFG(dest, dbank), cfg);
+	trace_otx2_npc_mcam_copy(orig_src, orig_dest);
 	return 0;
 }
 
@@ -3198,6 +3219,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	rsp->free_count = -1;
 	mutex_unlock(&mcam->lock);
 
+	trace_otx2_npc_mcam_alloc_entries(pcifunc, req, rsp);
 	return 0;
 
 not_cn20k:
@@ -3384,6 +3406,7 @@ static int npc_mcam_alloc_entries(struct npc_mcam *mcam, u16 pcifunc,
 	rsp->free_count = mcam->bmap_fcnt;
 
 	mutex_unlock(&mcam->lock);
+	trace_otx2_npc_mcam_alloc_entries(pcifunc, req, rsp);
 	return 0;
 }
 
@@ -4043,7 +4066,7 @@ int rvu_mbox_handler_npc_mcam_alloc_and_write_entry(struct rvu *rvu,
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, req->hdr.pcifunc);
 	struct npc_mcam_alloc_counter_req cntr_req;
 	struct npc_mcam_alloc_counter_rsp cntr_rsp;
-	struct npc_mcam_alloc_entry_req entry_req;
+	struct npc_mcam_alloc_entry_req entry_req = { 0 };
 	struct npc_mcam_alloc_entry_rsp entry_rsp;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
 	u16 entry = NPC_MCAM_ENTRY_INVALID;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
index 19e0d16b12f6..42797e7d13ba 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.c
@@ -13,3 +13,8 @@ EXPORT_TRACEPOINT_SYMBOL(otx2_msg_interrupt);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_process);
 EXPORT_TRACEPOINT_SYMBOL(otx2_msg_status);
 EXPORT_TRACEPOINT_SYMBOL(otx2_parse_dump);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_mcam_alloc_entries);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_mcam_copy);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_enable_mcam_entry);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_cam);
+EXPORT_TRACEPOINT_SYMBOL(otx2_npc_action);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
index 4cd0fc4b0d20..ea1c5d7f1007 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_trace.h
@@ -159,6 +159,120 @@ TRACE_EVENT(otx2_parse_dump,
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
+	    TP_fast_assign(__entry->pcifunc = pcifunc;
+			   __entry->contig = req->contig;
+			   __entry->ref_prio = req->ref_prio;
+			   __entry->ref_entry = req->ref_entry;
+			   __entry->req_count = req->count;
+			   __entry->kw_type = req->kw_type;
+			   __entry->virt = req->virt;
+			   __entry->start_mcam_idx = req->contig ? rsp->entry :
+				(rsp->count ? rsp->entry_list[0] :
+				 NPC_MCAM_ENTRY_INVALID);
+			   __entry->rsp_count = rsp->count;
+			   __entry->free_count = rsp->free_count;
+	    ),
+	    TP_printk("pcifunc:0x%x req_contig:%d req_ref_prio:%d req->ref_entry:%d req->req_count:%d req->kw_type:%d req->virt:%d rsp_start_mcam_idx:%d rsp_count:%d rsp_free_count:%d",
+		      __entry->pcifunc, __entry->contig, __entry->ref_prio,
+		      __entry->ref_entry, __entry->req_count, __entry->kw_type,
+		      __entry->virt, __entry->start_mcam_idx, __entry->rsp_count,
+		      __entry->free_count)
+);
+
+TRACE_EVENT(otx2_npc_mcam_copy,
+	    TP_PROTO(u16 src, u16 dest),
+	    TP_ARGS(src, dest),
+	    TP_STRUCT__entry(__field(u16, src)
+			     __field(u16, dest)
+	    ),
+	    TP_fast_assign(__entry->src = src;
+			   __entry->dest = dest;
+	    ),
+	    TP_printk("src:%d dest:%d", __entry->src, __entry->dest)
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
+	    TP_printk("mcam_index:%d enable:%d", __entry->mcam_index, __entry->ena)
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
+	    TP_printk("mcam_index:%d bank:%d w0_cam0:0x%llx w0_cam1:0x%llx w1_cam0:0x%llx w1_cam1:0x%llx",
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
+	    TP_printk("mcam_index:%d bank:%d tx_intf:%d enable:%d action:0x%llx vtag_action:0x%llx",
+		      __entry->mcam_index, __entry->bank, __entry->tx_intf,
+		      __entry->enable, __entry->act, __entry->vtag_act)
+);
+
 #endif /* __RVU_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.43.0

