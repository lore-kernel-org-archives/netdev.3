Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8543DED6;
	Thu, 24 Sep 2026 08:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238397; cv=none; b=f9/XMA0YBWmh3IMUNpUyzKqNLQYDPd1iBXr4srB5lAei/vkVyZXD5HZbBzX9I/zvnYLgYWdzFtBu/iNxfv93NQQWLaTW2vndeozQJRdAA1GCRFROOu72IY+u+UZdJU+Nxu7y+tMTzaA3gVRJRIFxT81kBkARD0xKkLDt21NlVZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238397; c=relaxed/simple;
	bh=tM2aj62ehl4+FyPHsdTQyUJ1opv+agCkoZAPH4tHz/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfXiCsyH1L8/xgIUQ6/sQSyawCf1HJWO7U04OTIFOCwOuDzL/SnA67KTwWtqff2xsnE1FWYRvQMdl0T+Sp0s45xxpmziKZPT8Q9G4lg3Hkjf3KmpDnwLhSoB2ehlwN0IYQULotokOUTwhn/Bcw1VKHKxCbAy2XDhr+hzP4VGd8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Yd0t0AOk; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Yd0t0AOk"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5e6UT3974370;
	Thu, 24 Sep 2026 01:26:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=WITS5QZW/7KY0GERGGvSKfK
	T3WRQODEFYT9eNVqRfl4=; b=Yd0t0AOklOIJSiWXDf/xGzedxVoUDF5Ln4cnMdB
	SScfAEAgPXUmj3bUkXHGU77vK+uu8iieuSWcSx8eFYl4PCSKCpipb7uqs4XlURd/
	faDt6lPwSb05gk6xzW8JpMvVotsXem+wj6pfJ4IlP3TSviYfI0+FiDIgcryT8r7D
	KRmzAYKXvJSX/LQSMUMx8jjCc558iId/RJkOu+aS332M9CodrrSiB0BYeTwX7aMl
	9JpSgDtIysWUuC6Ibnm5U3lnIBEY+Ro9cBRM4DE8G2Tpyjng/I3B7syKdWovDCQ1
	FPd+YaOZsPuBnCsvvw28uRzA+Z3onvrD9sQUmC4NKmOwLZA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gvksntxba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 01:26:26 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 24 Sep 2026 01:26:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 24 Sep 2026 01:26:25 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id BFEB15B6950;
	Thu, 24 Sep 2026 01:26:21 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v3 net-next] octeontx2-af: pass devlink switch id and cache representor map
Date: Thu, 24 Sep 2026 13:56:14 +0530
Message-ID: <20260924082614.1947742-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzNSBTYWx0ZWRfX67vcAB6uZ93m
 i7VgjB1/2zEZQ2Rd7QEJrrKhqCmElie3GrkbZdU/7bE3kHJ3RXIjSph0RAmdv9AQ7DqMuA9kgFM
 t1x8fjaViNJ/tnehsd7hZ3veQL5ib6Q=
X-Authority-Analysis: v=2.4 cv=fcI4WEQF c=1 sm=1 tr=0 ts=6ab4deb2 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=M5GUcnROAAAA:8
 a=gqSagxGxYvX-DtDPPjEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzNSBTYWx0ZWRfXwdF08/qnpfhD
 bDeB7WKCKNcKBXk9U/rcAxRUNjqqA7AJKjzNAglHGMlHc4HV0k494wrgp3lgU0BbZhb2H4OBilX
 7HMNd2PbRo65awIpRULE4y3h3Ws47JCPeZaxK/XXnBfcPkdkXnuJebt/tCzwBywh6G8FI7qPcSU
 Q5fGZt32c+X8bIqgJ7+qnsJ2t7m/wznIsP5zdpFCpLOuKymPddWXfgCCLR8ARYPawNiGT4Ud8Nt
 5OKtx6A8pM30CPuQnGxMA/si/iHclPg00aGoIloN0tOtyIqDDpOQs4H5teWH0ywABHeOZbKhVvL
 jLoRW93aYmKgSw5OMqXLk1EE+Dr/Q633rtHu/np1nOBubhYa82Xewq55xdLwfTsTHRHph7oT+bW
 2Ucylpf4K9AHg+CJVSdJBZhlt9DLPdSYA+sLJCopWPdxqL2RZovXrSSSCg7bzL74O73lf0AmHWA
 9dsTkqqlK6LTNgJgmfA==
X-Proofpoint-GUID: Xm2j5ZUcs6lQjr7EKHT8XuMhEapxVJY4
X-Proofpoint-ORIG-GUID: Xm2j5ZUcs6lQjr7EKHT8XuMhEapxVJY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01

Extend MBOX_MSG_ESW_CFG with the representor devlink switch_id and
store it in the AF. Build rep2pfvf_map once on GET_REP_CNT, always
refresh rep_pcifunc, and protect map access with rsrc_lock. Reset the
cache on eswitch disable and representor FLR. Add rvu_sw_port_id()
and share the representor index lookup with rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

---
v2 -> v3:
- Fix compilation issue.
	https://lore.kernel.org/netdev/202609241557.82GuIoAK-lkp@intel.com/

v1 -> v2:
- Always refresh rep_pcifunc on GET_REP_CNT instead of pinning it to
  the first caller.
- Replace the READ_ONCE/WRITE_ONCE rep2pfvf_map fast path with
  rvu_rep_lookup_id() lookups under rsrc_lock.
- Add rvu_rep_cache_reset() and call it on eswitch disable and
  representor FLR so the cached map and switch_id are torn down.
- Ignore redundant ESW_CFG enable/disable requests when the mode is
  already in the requested state.
- Validate switch_id length before allocating the ESW_CFG mailbox
  message.
- Build the representor map from rvu_rep_create() via rvu_get_rep_cnt().
- Drop the ESW_CFG wire-format comment block; the layout change is
  carried only by the struct fields.
- Factor rvu_rep_get_vlan_id() and rvu_sw_port_id() through a shared
  rvu_rep_lookup_id() helper.
  https://lore.kernel.org/netdev/20260918050021.1359606-1-rkannoth@marvell.com/
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   3 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   9 ++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 117 +++++++++++++++---
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  81 ++++++------
 5 files changed, 160 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..45c03f9294a5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1788,6 +1788,8 @@ struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
 	u64 rsvd;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
+	u8 switch_id_len;
 };
 
 struct rep_evt_data {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 30e148291581..aeb6b4917f45 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -2924,6 +2924,9 @@ static void __rvu_flr_handler(struct rvu *rvu, u16 pcifunc)
 	if (rvu->mcs_blk_cnt)
 		rvu_mcs_flr_handler(rvu, pcifunc);
 
+	if (is_rep_dev(rvu, pcifunc))
+		rvu_rep_cache_reset(rvu);
+
 	mutex_unlock(&rvu->flr_lock);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index fb4870cd18e9..d5f69cba6d41 100644
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
@@ -1194,9 +1200,12 @@ void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena);
 void rvu_mcs_exit(struct rvu *rvu);
 
 /* Representor APIs */
+void rvu_rep_cache_reset(struct rvu *rvu);
 int rvu_rep_pf_init(struct rvu *rvu);
 int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..a3ad45f46742 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/stddef.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/module.h>
@@ -189,14 +190,47 @@ int rvu_mbox_handler_nix_lf_stats(struct rvu *rvu,
 	return 0;
 }
 
-static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+static bool rvu_rep_lookup_id(struct rvu *rvu, u16 pcifunc, u16 *rep_id)
 {
-	int id;
+	u16 *map;
+	int id, cnt;
+	bool found = false;
+
+	mutex_lock(&rvu->rsrc_lock);
+	map = rvu->rep2pfvf_map;
+	cnt = rvu->rep_cnt;
+	if (map && cnt) {
+		for (id = 0; id < cnt; id++) {
+			if (map[id] == pcifunc) {
+				*rep_id = id;
+				found = true;
+				break;
+			}
+		}
+	}
+	mutex_unlock(&rvu->rsrc_lock);
 
-	for (id = 0; id < rvu->rep_cnt; id++)
-		if (rvu->rep2pfvf_map[id] == pcifunc)
-			return id;
-	return 0;
+	return found;
+}
+
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+{
+	u16 rep_id;
+
+	if (!rvu_rep_lookup_id(rvu, pcifunc, &rep_id))
+		return 0;
+	return rep_id;
+}
+
+u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
+{
+	u16 rep_id;
+
+	if (!rvu_rep_lookup_id(rvu, pcifunc, &rep_id))
+		return RVU_SW_INVALID_PORT_ID;
+
+	return FIELD_PREP(GENMASK_ULL(31, 16), rep_id) |
+	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
 }
 
 static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
@@ -429,16 +463,48 @@ int rvu_rep_pf_init(struct rvu *rvu)
 	return 0;
 }
 
+void rvu_rep_cache_reset(struct rvu *rvu)
+{
+	u16 *map;
+
+	mutex_lock(&rvu->rsrc_lock);
+	rvu->rep_mode = 0;
+	rvu->rep_pcifunc = 0;
+	map = rvu->rep2pfvf_map;
+	rvu->rep_cnt = 0;
+	rvu->rep2pfvf_map = NULL;
+	memset(rvu->rswitch.switch_id, 0, sizeof(rvu->rswitch.switch_id));
+	rvu->rswitch.switch_id_len = 0;
+	mutex_unlock(&rvu->rsrc_lock);
+
+	devm_kfree(rvu->dev, map);
+}
+
 int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 			     struct msg_rsp *rsp)
 {
 	if (req->hdr.pcifunc != rvu->rep_pcifunc)
 		return 0;
 
+	if (rvu->rep_mode && req->ena)
+		return 0;
+
+	if (!rvu->rep_mode && !req->ena)
+		return 0;
+
 	rvu->rep_mode = req->ena;
+	memset(rvu->rswitch.switch_id, 0, sizeof(rvu->rswitch.switch_id));
+	rvu->rswitch.switch_id_len = 0;
+	if (req->switch_id_len && req->switch_id_len <= MAX_PHYS_ITEM_ID_LEN) {
+		memcpy(rvu->rswitch.switch_id, req->switch_id,
+		       req->switch_id_len);
+		rvu->rswitch.switch_id_len = req->switch_id_len;
+	}
 
-	if (!rvu->rep_mode)
+	if (!rvu->rep_mode) {
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
+		rvu_rep_cache_reset(rvu);
+	}
 
 	return 0;
 }
@@ -447,31 +513,48 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 				 struct get_rep_cnt_rsp *rsp)
 {
 	int pf, vf, numvfs, hwvf, rep = 0;
-	u16 pcifunc;
+	u16 pcifunc, rep_cnt;
+	u16 *map;
+
+	mutex_lock(&rvu->rsrc_lock);
 
 	rvu->rep_pcifunc = req->hdr.pcifunc;
-	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
-	rvu->rep_cnt = rsp->rep_cnt;
 
-	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
-					 sizeof(u16), GFP_KERNEL);
-	if (!rvu->rep2pfvf_map)
+	if (rvu->rep2pfvf_map) {
+		rsp->rep_cnt = rvu->rep_cnt;
+		for (rep = 0; rep < rvu->rep_cnt; rep++)
+			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+		mutex_unlock(&rvu->rsrc_lock);
+		return 0;
+	}
+
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
+	rvu->rep_cnt = rep_cnt;
+	rvu->rep2pfvf_map = map;
+	rsp->rep_cnt = rep_cnt;
+
+	mutex_unlock(&rvu->rsrc_lock);
+
 	return 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..80b47bb333b7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -399,8 +399,13 @@ static void rvu_rep_get_stats64(struct net_device *dev,
 
 static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 {
+	struct devlink_port_attrs attrs = {};
 	struct esw_cfg_req *req;
 
+	rvu_rep_devlink_set_switch_id(priv, &attrs.switch_id);
+	if (attrs.switch_id.id_len > MAX_PHYS_ITEM_ID_LEN)
+		return -EINVAL;
+
 	mutex_lock(&priv->mbox.lock);
 	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
 	if (!req) {
@@ -408,6 +413,8 @@ static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
 		return -ENOMEM;
 	}
 	req->ena = ena;
+	req->switch_id_len = attrs.switch_id.id_len;
+	memcpy(req->switch_id, attrs.switch_id.id, req->switch_id_len);
 	otx2_sync_mbox_msg(&priv->mbox);
 	mutex_unlock(&priv->mbox.lock);
 	return 0;
@@ -645,6 +652,41 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	rvu_rep_rsrc_free(priv);
 }
 
+static int rvu_get_rep_cnt(struct otx2_nic *priv)
+{
+	struct get_rep_cnt_rsp *rsp;
+	struct mbox_msghdr *msghdr;
+	struct msg_req *req;
+	int err, rep;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return -ENOMEM;
+	}
+	err = otx2_sync_mbox_msg(&priv->mbox);
+	if (err)
+		goto exit;
+
+	msghdr = otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(msghdr)) {
+		err = PTR_ERR(msghdr);
+		goto exit;
+	}
+
+	rsp = (struct get_rep_cnt_rsp *)msghdr;
+	priv->hw.tx_queues = rsp->rep_cnt;
+	priv->hw.rx_queues = rsp->rep_cnt;
+	priv->rep_cnt = rsp->rep_cnt;
+	for (rep = 0; rep < priv->rep_cnt; rep++)
+		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
+
+exit:
+	mutex_unlock(&priv->mbox.lock);
+	return err;
+}
+
 int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 {
 	int rep_cnt = priv->rep_cnt;
@@ -653,6 +695,10 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	int rep_id, err;
 	u16 pcifunc;
 
+	err = rvu_get_rep_cnt(priv);
+	if (err)
+		return err;
+
 	err = rvu_rep_rsrc_init(priv);
 	if (err)
 		return -ENOMEM;
@@ -730,41 +776,6 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	return err;
 }
 
-static int rvu_get_rep_cnt(struct otx2_nic *priv)
-{
-	struct get_rep_cnt_rsp *rsp;
-	struct mbox_msghdr *msghdr;
-	struct msg_req *req;
-	int err, rep;
-
-	mutex_lock(&priv->mbox.lock);
-	req = otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
-	if (!req) {
-		mutex_unlock(&priv->mbox.lock);
-		return -ENOMEM;
-	}
-	err = otx2_sync_mbox_msg(&priv->mbox);
-	if (err)
-		goto exit;
-
-	msghdr = otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
-	if (IS_ERR(msghdr)) {
-		err = PTR_ERR(msghdr);
-		goto exit;
-	}
-
-	rsp = (struct get_rep_cnt_rsp *)msghdr;
-	priv->hw.tx_queues = rsp->rep_cnt;
-	priv->hw.rx_queues = rsp->rep_cnt;
-	priv->rep_cnt = rsp->rep_cnt;
-	for (rep = 0; rep < priv->rep_cnt; rep++)
-		priv->rep_pf_map[rep] = rsp->rep_pf_map[rep];
-
-exit:
-	mutex_unlock(&priv->mbox.lock);
-	return err;
-}
-
 static int rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-- 
2.43.0

