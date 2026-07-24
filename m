Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECDF41F7EE;
	Fri, 24 Jul 2026 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784886054; cv=none; b=mPTwNcOwg/KRXDaeal04SG+StxU4oD4aVVpPaO6qTW2/fvOoCEKFcYjk1qPEbAlIMQWmiNN9bKG+K985rrVEIt16zoXXMIzcFszg/4PGO0qSYsNq2vs+8vszqSqFUM1nuX738ENKkv9VnGEzJeoi7a7KOVWaRfJUtGgouRaBH2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784886054; c=relaxed/simple;
	bh=m1KiwiCmSA16AKJ7ezfSuxFwiACEVzxmsNoSONRg8i8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Swv3ANCDYs42ZwUwdFxLnkmW/5jTYC0MZdNvK8eX6FM+8f45nsWuM364GSe+Dj8STLqTfFhp7T9twasqImjlNpQEAhflqJmrfSGjQxWDqvoHocZ38XSSeaEjK1Xq7D3uU9SwViGve456X+DXDani3qlxjAm5/KZMEbwptIfCvmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eWwIASZb; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eWwIASZb"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4mmbr922772;
	Fri, 24 Jul 2026 02:40:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=0
	rdedrlRldrKvNlyjSD/+xvZWG7IUsiywg1Dks6gFLw=; b=eWwIASZbvdIvsc4XO
	WpsrldQjEJvWuAHZfnOsV/5hDHnwl6N2/NCOqhXBvvZjXDycMnmSvRI60Y16jWfR
	s/Yqtqob3FXxC6yhWtAnv/hr/l8ZE1bOew8Mdks7tb6WLdH8Djzxlb2ANyQrtExi
	6F86GAV8sKmReo0Wl1pPrbkvrL+e1WgpbKZH40AOLLJyHbvdsUz6NEcX9smkKToJ
	XSmmrd4QirpPnSphKK7wvGg/mbhwezDFTx5LnKdFEEW3iKNtvy6EhRT6pOm8+Vhy
	ezQbGqcYcZNQSLiElrlIwObYqpOgReMUlSw8vCIJLI3N9YZC+pe3xAj9SNMqsyGL
	29CDg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fk7jkvw7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 02:40:44 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 24 Jul 2026 02:40:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 24 Jul 2026 02:40:43 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E37913F7076;
	Fri, 24 Jul 2026 02:40:40 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v5 net-next 4/9] octeontx2-af: switch: Representor for switch port
Date: Fri, 24 Jul 2026 15:10:13 +0530
Message-ID: <20260724094018.3213907-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724094018.3213907-1-rkannoth@marvell.com>
References: <20260724094018.3213907-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfXxjRqDo509j0z
 rTqp4P1M2ZWltlCA5Af7MGzcKwAKydL6PGPkhTV8cSKxNXxI0mWatEE4zdJg1GlaIlkVyhDjw31
 dK4wyj7JMhweEG+1SWGJkWv8RIJtx/pKJY8oep1rxcY7g3MoR17Jic3CXbzHx494c9+VL24n6dg
 3aBlRBjtXe+2DwuvfpDZTavdjm+w32y1IdWjifJ+el9cTTukANxZQNeWgAL044/XORhbfSr2BF2
 w9II+F2sglIZEzWJ3NpDGekuXh36fW60Brg2l04uu2Btqw0BqHrlxJa4xNz4/M7Ae1z8yXQ7TmV
 t2t4D/t/EuwGXQaEXC0c1vJGVxcZ8QRh/srHnpMldt+dexknj31rCd3nJhRDhR6hXimJ4/mGjrT
 OCrgtxjeaa4gvji9UT+N//P4zLP8IAy/AmBstEE9gDW9XoK7ZeHeg82+NnoStGoQXJFXdjC8WlC
 XvfeJhlzTOwUlXz6ckg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA4OCBTYWx0ZWRfX68R65VFRPKME
 H4NZK9y8H45/b/NOjDeDkEEx/PcXN2BdFKc0iK6JJt3OwPJIFfIWIjIKVIYt8LDjis7T+OuOTxF
 AUPOYfH4rQNLz6DlA3wccLtPA2wW9IA=
X-Proofpoint-GUID: mMi2JlM3thaB8TNpGxDGj-SnV7BdlJN9
X-Proofpoint-ORIG-GUID: mMi2JlM3thaB8TNpGxDGj-SnV7BdlJN9
X-Authority-Analysis: v=2.4 cv=Zrzd7d7G c=1 sm=1 tr=0 ts=6a63331c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=vKW80V-kDxkLz87EuU0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01

Extends esw_cfg with a devlink-derived switch id, copies it into
rvu->rswitch on the AF, adds rvu_sw_port_id(), exports
rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  5 +++++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 15 ++++++++++++++-
 .../marvell/octeontx2/af/switch/rvu_sw.c      | 19 +++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  4 ++++
 6 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index e8731301a474..e5c7ad1ed891 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1836,6 +1836,7 @@ struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
 	u64 rsvd;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 };
 
 struct rep_evt_data {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 73d2329b5c26..8cf1ad9ec749 100644
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
@@ -1197,4 +1201,5 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu);
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable);
 int npc_mcam_verify_entry(struct npc_mcam *mcam, u16 pcifunc, int entry);
+u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..0ee2fd935abf 100644
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
 
@@ -429,6 +430,15 @@ int rvu_rep_pf_init(struct rvu *rvu)
 	return 0;
 }
 
+static bool esw_cfg_req_has_switch_id(const struct esw_cfg_req *req)
+{
+	u16 msg_len = req->hdr.next_msgoff -
+		      ALIGN(sizeof(struct mbox_hdr), MBOX_MSG_ALIGN);
+
+	return msg_len >= offsetof(struct esw_cfg_req, switch_id) +
+			  MAX_PHYS_ITEM_ID_LEN;
+}
+
 int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 			     struct msg_rsp *rsp)
 {
@@ -436,6 +446,9 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	if (esw_cfg_req_has_switch_id(req))
+		memcpy(rvu->rswitch.switch_id, req->switch_id,
+		       MAX_PHYS_ITEM_ID_LEN);
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index fe143ad3f944..403d57870efe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -5,7 +5,26 @@
  *
  */
 
+#include <linux/bitfield.h>
+
 #include "rvu.h"
+#include "rvu_sw.h"
+
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

