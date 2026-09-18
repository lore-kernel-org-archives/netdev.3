Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1633137C10D;
	Fri, 18 Sep 2026 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789707662; cv=none; b=vAgmJ5IRqLmx9oYFNJP50sfm8QAzr9VXmxWDAd/OXiyLps6Bug0Gd/eVE5xYQ1oDH7c8w0S3HDeFuaofItgPZPR5gHZmxc8bvqJVSEAXJA+J02l9dAtX6l/ms4GoQNuW9z4lC24ILYxJxaic5FPPjlpNGFLjNMEW+PqMTXnG/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789707662; c=relaxed/simple;
	bh=O0NPVRfCjRCUKCHcxapoM9IMG/3qkBBGTmmLKX2ZSmk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/IRUjp1boe8h2E8iLrDKeeJkaBoRhyNZfG8+lkGBNwEVNUBF0vPVifmuGcHt2gT2RpAvrJd87jqbusmdxVCHUNR1ZEZpwtSWYPyjXSrYC6zyvZB00u87LVYLbwwEYE9cqog09irVtvuIifIUby2HNzKX4mo81oTHZHUabtNCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ieG4WlCR; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="ieG4WlCR"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I3PWZA2584031;
	Thu, 17 Sep 2026 22:00:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ap2qG+f5XkHT87ePrzkmDB1
	q3IAQJelU4se4bQLwMNw=; b=ieG4WlCR07VCZR/k+3K83J8Ek/XqoLoMeiEiUc+
	ulVC/F1Ru27PTTnXdGZKroddaWIQkQqfGAaMG3YRGhbYwZFwLkQ9Dn/Hkxd+WXlH
	HmzcTZJg/r1VFZkwc+almii33JrEbN7G4TDEnvwBQji2D4SaD12KGLNvhN8mRdH8
	1j/KkiNo2owazJTkagD1Ob7H01L1cG6FV+uPXukkP3yeqKmGtLUPu7YHMn/7Uqtq
	IYchTB+MF6G9V9kyN/Owoph1stJfXV+388uMb4dSuO0O3xBhJDxjyydbNkeB8N2g
	cMScpHOoni/5S8W9vbGM8nJkOppK9AosEfE8gbFnn3Rv5Vg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4grwcjrcr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 22:00:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 17 Sep 2026 22:00:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 17 Sep 2026 22:00:37 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 4EBE83F7098;
	Thu, 17 Sep 2026 22:00:34 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH net-next] octeontx2-af: Representor devlink id and port mapping
Date: Fri, 18 Sep 2026 10:30:21 +0530
Message-ID: <20260918050021.1359606-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA2MyBTYWx0ZWRfX9+B9GKuLg1jT
 dXSfikBgu+91FZLP2Jqc9g3XLEalzS8/6m4+DPZ5QahjOULgviQIPESBW8x0XLstD8Ophxz1W02
 QgKhYAAo4MPffxSW2kzLDHjHTMfoR6dVHoBypERndQrjq94w775YN6I6HlyTV3c/BJw6oS4Huim
 IKveE748yqPIl6UpwMxi+9+c7zn2OflQ7LAwXw83zFqbenIXOfHOt1E69PKIFSm8iEAmFLhoBhD
 SXUcbTcH8WhNW4fGYUpF+7f9TpO+vcrlWHXZ2b3bzAMebTLcqWSo1J7tw0AYOrYu1JHgc645Luw
 GIMDMCx97NVjatlOCLXOLWbKvkiTCQqafX4cpozOYLltv12hzGRFFobRog+QbygkH8+4X1prIZ5
 f8lwAlQOoohSSx/PX87hvOCpZgJ0rtsWxLAQc2XxH94hT7iKH9P1P80wNUfAKybeso548UK3GO1
 2IqKc5Zwq+XFjF3piaw==
X-Authority-Analysis: v=2.4 cv=bYr+w+PB c=1 sm=1 tr=0 ts=6aacc575 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=5BIeNoMRWAjfrFRditUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA2MyBTYWx0ZWRfX/ofjN3u4Za+P
 oMfIhMH6leNU+aPJCMNU7kZLBWYmDrNCmRoeBEdUgmTxQsxVeVsEQd8uZ1fheoAurYSjUzF6KLn
 JM0zea9yOB1z38vs9Poet6w1uMmI77U=
X-Proofpoint-ORIG-GUID: L2yYt5uaq4NdbHSHNzzBWh_qwFAKqitN
X-Proofpoint-GUID: L2yYt5uaq4NdbHSHNzzBWh_qwFAKqitN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01

Extend ESW_CFG with a devlink-derived physical ID and copy it into
the AF representor configuration. Add a representor port id helper
and export rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  | 20 +++++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  8 ++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 78 +++++++++++++++----
 .../net/ethernet/marvell/octeontx2/nic/rep.c  | 10 +++
 4 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..cafb92b5d57c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1784,10 +1784,30 @@ struct get_rep_cnt_rsp {
 	u64 rsvd;
 };
 
+/*
+ * MBOX_MSG_ESW_CFG wire format.
+ *
+ * Transaction shape: the representor driver issues exactly one mailbox
+ * message per sync on this path.  rvu_eswitch_config() in nic/rep.c
+ * allocates only struct esw_cfg_req, then calls otx2_sync_mbox_msg()
+ * without enqueueing any other message IDs.  The AF handles one request
+ * per dispatch for this doorbell.
+ *
+ * Layout extensions are therefore confined to this message: fields cannot
+ * be confused with a batched successor because the representor driver
+ * never batches ESW_CFG with other messages.  otx2_mbox_alloc_msg_rsp()
+ * does advance hdr.next_msgoff cumulatively when multiple messages share
+ * a sync, but that API usage does not occur on the ESW_CFG caller path.
+ *
+ * PF and AF implementations are updated together in-tree; both sides
+ * must agree on the struct size carried by MBOX_MSG_ESW_CFG.
+ */
 struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
 	u64 rsvd;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+	u8 switch_id_len;
 };
 
 struct rep_evt_data {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index fb4870cd18e9..d1a9be6e4ac1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -570,6 +570,7 @@ struct npc_kpu_profile_adapter {
 };
 
 #define RVU_SWITCH_LBK_CHAN	63
+#define RVU_SW_INVALID_PORT_ID	((u32)~0U)
 
 struct rvu_switch {
 	struct mutex switch_lock; /* Serialize flow installation */
@@ -577,6 +578,11 @@ struct rvu_switch {
 	u16 *entry2pcifunc;
 	u16 mode;
 	u16 start_entry;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+	u8 switch_id_len;
+#define RVU_SWITCH_FLAG_FW_READY BIT_ULL(0)
+	u64 flags;
+	u16 pcifunc;
 };
 
 struct rep_evtq_ent {
@@ -1199,4 +1205,6 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..0e2d02b38b60 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -189,16 +190,41 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
 	return 0;
 }
 
-static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
 {
+	u16 *map = READ_ONCE(rvu->rep2pfvf_map);
+	u16 cnt = READ_ONCE(rvu->rep_cnt);
 	int id;
 
-	for (id = 0; id < rvu->rep_cnt; id++)
-		if (rvu->rep2pfvf_map[id] == pcifunc)
+	if (!map || !cnt)
+		return 0;
+
+	for (id = 0; id < cnt; id++)
+		if (map[id] == pcifunc)
 			return id;
 	return 0;
 }
 
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u16 rep_id, *map, cnt;
+
+	map = READ_ONCE(rvu->rep2pfvf_map);
+	cnt = READ_ONCE(rvu->rep_cnt);
+	if (!map || !cnt)
+		return RVU_SW_INVALID_PORT_ID;
+
+	for (rep_id = 0; rep_id < cnt; rep_id++) {
+		if (map[rep_id] != pcifunc)
+			continue;
+
+		return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+		       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
+	}
+
+	return RVU_SW_INVALID_PORT_ID;
+}
+
 static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
 			       u16 vlan_tci, int *vidx)
 {
@@ -429,6 +455,7 @@ int rvu_rep_pf_init(struct rvu *rvu)
 	return 0;
 }
 
+/* MBOX_MSG_ESW_CFG arrives as the sole message in its sync; see esw_cfg_req. */
 int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 			     struct msg_rsp *rsp)
 {
@@ -436,6 +463,13 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	memset(rvu->rswitch.switch_id, 0, sizeof(rvu->rswitch.switch_id));
+	rvu->rswitch.switch_id_len = 0;
+	if (req->switch_id_len && req->switch_id_len <= MAX_PHYS_ITEM_ID_LEN) {
+		memcpy(rvu->rswitch.switch_id, req->switch_id,
+		       req->switch_id_len);
+		rvu->rswitch.switch_id_len = req->switch_id_len;
+	}
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
@@ -447,31 +481,47 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 				 struct get_rep_cnt_rsp *rsp)
 {
 	int pf, vf, numvfs, hwvf, rep = 0;
-	u16 pcifunc;
+	u16 pcifunc, rep_cnt;
+	u16 *map;
 
-	rvu->rep_pcifunc = req->hdr.pcifunc;
-	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
-	rvu->rep_cnt = rsp->rep_cnt;
+	mutex_lock(&rvu->rsrc_lock);
+
+	if (rvu->rep2pfvf_map) {
+		rsp->rep_cnt = rvu->rep_cnt;
+		for (rep = 0; rep < rvu->rep_cnt; rep++)
+			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+		mutex_unlock(&rvu->rsrc_lock);
+		return 0;
+	}
 
-	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
-					 sizeof(u16), GFP_KERNEL);
-	if (!rvu->rep2pfvf_map)
+	rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
+	map = devm_kzalloc(rvu->dev, rep_cnt * sizeof(u16), GFP_KERNEL);
+	if (!map) {
+		mutex_unlock(&rvu->rsrc_lock);
 		return -ENOMEM;
+	}
 
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
 			continue;
 		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
-		rvu->rep2pfvf_map[rep] = pcifunc;
+		map[rep] = pcifunc;
 		rsp->rep_pf_map[rep] = pcifunc;
 		rep++;
 		rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
 		for (vf = 0; vf < numvfs; vf++) {
-			rvu->rep2pfvf_map[rep] = pcifunc |
-				((vf + 1) & RVU_PFVF_FUNC_MASK);
-			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+			map[rep] = pcifunc | ((vf + 1) & RVU_PFVF_FUNC_MASK);
+			rsp->rep_pf_map[rep] = map[rep];
 			rep++;
 		}
 	}
+
+	rvu->rep_pcifunc = req->hdr.pcifunc;
+	WRITE_ONCE(rvu->rep2pfvf_map, map);
+	WRITE_ONCE(rvu->rep_cnt, rep_cnt);
+	rsp->rep_cnt = rep_cnt;
+
+	mutex_unlock(&rvu->rsrc_lock);
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..97581d786abd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -399,8 +399,12 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
+
+	/* Sole message in this sync; see esw_cfg_req in af/mbox.h. */
 	mutex_lock(&priv->mbox.lock);
 	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
 	if (!req) {
@@ -408,6 +412,12 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 		return -ENOMEM;
 	}
 	req->ena = ena;
+	req->switch_id_len = attrs.switch_id.id_len;
+	if (req->switch_id_len > MAX_PHYS_ITEM_ID_LEN) {
+		mutex_unlock(&priv->mbox.lock);
+		return -EINVAL;
+	}
+	memcpy(req->switch_id, attrs.switch_id.id, req->switch_id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
 	return 0;
-- 
2.43.0

