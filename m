Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A141737F;
	Mon, 31 Aug 2026 13:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182424; cv=none; b=S2RI8KCjYQdgYJcA9MPkzoFc7MQECy77E9rE0H6wLLnOzQXYk+68hlzDEyuZRzY/3w2S/Kg4MwjcvX2/YcURIT8fL7e3BXNne+7Pqqp4hwUYxl4+wlRwe2zFXnuIw+rgAkXWMtuAR1ApEbaqLOTb+njrY1esCGptlrNqzz3vqBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182424; c=relaxed/simple;
	bh=qxAGaZnbEOPEAUrdRflkMAw6HvkFBTx3/hppWVnmy6Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g6B8qe49zuDJ/aDUFIuFeRc15NhCilzSqItKJULNRmj7ktYavJ+DkQ8lYwNaBmKSls4X+j6uM+U6T7lC80SMtY+kY4/V7LUXOZOMErqJoUrPFMtFSGCsjne8zcziXICx8YjLD0Q7CEfUubRJz4Ubzk+LjMs5KUqEmfNwf+xUZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=e1ZpWUz4; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="e1ZpWUz4"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBCmBn1196232;
	Mon, 31 Aug 2026 06:20:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
	GzSKGrwxbUMiuzE2NtOfwrBo4AOcIan6so0XEX+NJQ=; b=e1ZpWUz43UkBT2Jzg
	bK8lyRH2urdlQiPIK73ZnZSaU0o1ZPr/vcAgewDCYfGmUtQe7lJcgjf+j4DOUUCX
	bvpPNBPl3EyGX8LtJ773hS7skx/c/iTCRVr53L5IXINxRPOpVcq3lEdEbSlevquD
	4dW/8Dd4PVBc2h8dCxzaKizhltWSfTEG6jA2yWI0nVYSTd9cW9myrvzQ9IXJVo3N
	W1Zv+MBPgFlbNiwkvoaJo3yFB4vCWV/1v9un/5FT1xPJEI88JpDXVP++7lF8dQX0
	MVUHoFLkxlObJa7Z+mS8X7fNAZQ+Vv2Rm0SmZavD3nQdObpyhd8/dDDINjx7DEnj
	vEsDA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gbxxj3y9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:20:09 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:20:08 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:20:08 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 682C33F7097;
	Mon, 31 Aug 2026 06:20:05 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v9 net-next 4/8] octeontx2-af: switch: Representor for switch port
Date: Mon, 31 Aug 2026 18:49:40 +0530
Message-ID: <20260831131944.2649362-5-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfXzLFSyhmtAUEF
 2Ohm6mPEKmH68HV5Ams+XT3MT9f6D3OoxX9QYEDnw0+vADIuZtJhiwNnq5tH7yzWXnu/pNPEr1q
 8lmnXvPmyEayj/iuWbjP5ZOnb6B2Z3U=
X-Proofpoint-GUID: _k_0Uh-mc4A1TOR5VideKekMIoIEtxmU
X-Proofpoint-ORIG-GUID: _k_0Uh-mc4A1TOR5VideKekMIoIEtxmU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX+uanNe0rr4ic
 7zdTCo38ulb1Iiqy4P7mKLRn1732PMKK9n2GtYZKzfLyGuMyK51DIGDQwdc69BIhLPyPG/fDQbw
 +p2b6jjQQbFRuRShxjd0UsupSXm7iEZba/1811WjfIIsKqAvy5gmnBHoAV8HC7puL2zJUdyf7VQ
 AxpncYxRF8aMrBPXPlYdscmyM6Ys3v72p5+0xzDp0ZKhZ9TxScZWanAlEjwkSffW4NzouCsA0Yv
 nJnaCI78FYK4EVsRcb4d8JXVeBqX9MkAcPIMpDiW6WMoCcSEREcMZkwp/Ad2UK4hvSTObczL0q6
 /c6GtulGQxAqcuDLz/PiWp3MfVP0aeXFAnTocrVSixX8WnJgFBFRWEezCM8MuKfCIkgOVowo2Aj
 a8tOCX8TPuhSlSKzwUuNGNiLV105A2blDeBVbMQfP94ixYS3r9yJr0Z5d+mtpQLNeuKatAqjZt+
 WusHWDJJtQ+Ojn1tE5A==
X-Authority-Analysis: v=2.4 cv=QuJuG1yd c=1 sm=1 tr=0 ts=6a957f89 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=ngmFYzvsSoveWwpVfgYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

Extends esw_cfg with a devlink-derived switch id, copies it into
rvu->rswitch on the AF, adds rvu_sw_port_id(), exports
rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  5 +++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 33 ++++++++++++++++++-
 .../marvell/octeontx2/af/switch/rvu_sw.c      | 26 +++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  5 +++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  4 +++
 6 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index e45e6e93ed08..8e3850f33751 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1841,6 +1841,7 @@ struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
 	u64 rsvd;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 };
 
 struct rep_evt_data {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 2876c76ae61b..9174b879850a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -576,6 +576,10 @@ struct rvu_switch {
 	u16 *entry2pcifunc;
 	u16 mode;
 	u16 start_entry;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
+	u64 flags;
+	u16 pcifunc;
 };
 
 struct rep_evtq_ent {
@@ -1199,4 +1203,5 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..672d54847c7b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -189,7 +190,7 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
 	return 0;
 }
 
-static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
 	int id;
 
@@ -429,6 +430,30 @@ int rvu_rep_pf_init(struct rvu *rvu)
 	return 0;
 }
 
+/* ESW_CFG is always the sole message in a mailbox transaction.
+ *
+ * The otx2 mailbox API does not batch multiple messages per sync: the
+ * representor driver allocates only ESW_CFG before calling
+ * otx2_sync_mbox_msg() (see rvu_eswitch_config()), and the AF processes
+ * one message per dispatch. next_msgoff is therefore the end offset of this
+ * message, not a cumulative offset across batched messages, so the length
+ * check below is safe. Batching is not supported; do not flag this path.
+ */
+static bool esw_cfg_req_has_switch_id(const struct esw_cfg_req *req)
+{
+	u16 hdr_len = ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+	u16 next_off = req->hdr.next_msgoff;
+	u16 msg_len;
+
+	if (next_off < hdr_len)
+		return false;
+
+	msg_len = next_off - hdr_len;
+
+	return msg_len >= offsetof(struct esw_cfg_req, switch_id) +
+			  MAX_PHYS_ITEM_ID_LEN;
+}
+
 int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 			     struct msg_rsp *rsp)
 {
@@ -436,6 +461,9 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	if (esw_cfg_req_has_switch_id(req))
+		memcpy(rvu->rswitch.switch_id, req->switch_id,
+		       MAX_PHYS_ITEM_ID_LEN);
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
@@ -449,6 +477,9 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 	int pf, vf, numvfs, hwvf, rep = 0;
 	u16 pcifunc;
 
+	/* Called once from representor driver probe during devlink eswitch
+	 * SWITCHDEV bring-up; not re-run during switch device operation.
+	 */
 	rvu->rep_pcifunc = req->hdr.pcifunc;
 	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
 	rvu->rep_cnt = rsp->rep_cnt;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index fe143ad3f944..2451eb57ec4c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -5,7 +5,33 @@
  *
  */
 
+#include <linux/bitfield.h>
+
 #include "rvu.h"
+#include "rvu_sw.h"
+
+/*
+ * rep_cnt and rep2pfvf_map are populated once when the representor driver
+ * probes via GET_REP_CNT (see rvu_get_rep_cnt() in rep.c), as part of
+ * devlink eswitch SWITCHDEV bring-up. They are not updated during switch
+ * device mailbox handling, so this lockless lookup cannot race with a
+ * concurrent rep2pfvf_map resize.
+ */
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u16 rep_id;
+
+	if (!rvu->rep2pfvf_map || !rvu->rep_cnt)
+		return RVU_SW_INVALID_PORT_ID;
+
+	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
+	if (rep_id >= rvu->rep_cnt ||
+	    rvu->rep2pfvf_map[rep_id] != pcifunc)
+		return RVU_SW_INVALID_PORT_ID;
+
+	return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+}
 
 int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
index f28dba556d80..e9ad32c84576 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -8,4 +8,9 @@
 #ifndef RVU_SWITCH_H
 #define RVU_SWITCH_H
 
+/* RVU Switch */
+#define RVU_SW_INVALID_PORT_ID	((u32)~0U)
+
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
+
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..257a2ae6a53e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -399,8 +399,11 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
+
 	mutex_lock(&priv->mbox.lock);
 	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
 	if (!req) {
@@ -408,6 +411,7 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 		return -ENOMEM;
 	}
 	req->ena = ena;
+	memcpy(req->switch_id, attrs.switch_id.id, attrs.switch_id.id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
 	return 0;
-- 
2.43.0

