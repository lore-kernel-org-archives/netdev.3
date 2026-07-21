Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF43BADBD;
	Tue, 21 Jul 2026 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621932; cv=none; b=jxwCFX7bEK3b05zXcBq5wSDk+GXnWh/21zn7qoMWwOIzJv6g03k514w0fY8lto8fPIGYi4ppWJGMHolFrtGZgLgr/ZQm7zqlCbK7x8d6M+TzUYqNauJnmqHT5dbAvQno+yut9o1oEMDRzQ2O70/F0GswL1d8UzST+83Rvsc4YLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621932; c=relaxed/simple;
	bh=qwMx4eHK2LjiQI9xB1u8RM/SQTyf/Gc36f4YFksHcSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l9h/ObR7yO1/2iNJs3vgBrkt+FblI1aiKyBvyJNP0IYEyk4GrgdrgpMSkdufKJYnh7TNG4K4OC//3/wuG7SZJLKK5tH5vcx88RYQG3+GdJs21bplMGKxiA5voKh7w/mveG8qQZklPqwdx0DiADfQtuYj+Q41Q+1T1b1z+d3tPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bpmGObzW; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="bpmGObzW"
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNd49h667097;
	Tue, 21 Jul 2026 01:18:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	8Yxgnvqcr4VTA175HlZ/YVdCfD1u5VUVlIFqitFFgk=; b=bpmGObzWwFNUkb4F3
	E17Ud9Cuh+eh4RWxbJBKUBjvRBSj4438quYJXhCFLC8fc3zqFHC7MytoD1tSaLNt
	EGnbOA7ufkLx+9cdl+cSXdncurJ5+5iJnnTCvApsNr1bqsXJbX6EJJStv3XyY2Zi
	bH3+4IzPYfSBLliu6uEamZW8mBDjW2XRAK2pilrWC5myoOPeF0KQINigUxB2cAl3
	rVB9L+pJqtwfWTafpMGIL7QNpYr54i0u+GXFCvNslS3ljkYittiBQdZ4iBt1koRb
	x3Bb20IMQ5Y+rOkvT/+GxX9oy3arSQ9Ysb0KbFx5p2+gePEOR1B+yfe6xh8ccGbF
	PkRIQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fgd7dfsy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:42 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:42 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 6A94C3F7070;
	Tue, 21 Jul 2026 01:18:39 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 4/9] octeontx2-af: switch: Representor for switch port
Date: Tue, 21 Jul 2026 13:48:19 +0530
Message-ID: <20260721081824.1430607-5-rkannoth@marvell.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX6etiO8Qhyo+n
 TIXwJEF6BCfZ+rApX92IsoQ66TihHUMBjLGIhzyl4k/KTjsyOUpM9xj7ZebWOnOy61DBG/jCac3
 BSqoL1jJhgplAIavnnbNjGEBQOQOikE=
X-Proofpoint-ORIG-GUID: n_ZkrP6d55qgkXF8-Ri__NgJGOhAM3Xo
X-Proofpoint-GUID: n_ZkrP6d55qgkXF8-Ri__NgJGOhAM3Xo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NiBTYWx0ZWRfX6FzPrXx7mM4+
 4W7bdvkI8nrQ3pVANJmMU8iFJGUXvwf8CZ2b1Jed19ktIo7GTbqpAAikBXCS0/7YrBaC+IooVxi
 MUcpmcp0PbloPTBXXPByLD1vbPIfugwdCdNZpbc1Wau4BqrGjnAPg1IAEPiFidXllQ+lWuvLGxw
 BRRvpkwXshnymTrnJ47c56S9uPVD6LY0gDqW2q69JLJsDojerLckmsNIWk6+y2jhJuANok43vEr
 wxbXwhfYUtpuaU9rMQ1Z3HuwIr/2ov0eEqJ4IZRyRNk5NmVqwKko0S6TYQzxk4iiZ26WBvqVoXd
 G/RRUSxusIzg/nIly5fpN2vYM1gCK5QBI1vrbmxZzFZM4Z5Norwdpy2qfVN3MSdGryZ77U7L4tu
 399OYkYe0jakS5syOoxGON521FRh5u5awu6ypHqeaomnN3URtHejxjmK447rKBGmHTwy1Ijd8qQ
 n5hwGS3QYvDkehgz59w==
X-Authority-Analysis: v=2.4 cv=I9tVgtgg c=1 sm=1 tr=0 ts=6a5f2b62 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=vKW80V-kDxkLz87EuU0A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

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
index 23bc66ed854e..cdfb5a8bafb9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1834,6 +1834,7 @@ struct get_rep_cnt_rsp {
 struct esw_cfg_req {
 	struct mbox_msghdr hdr;
 	u8 ena;
+	unsigned char switch_id[MAX_PHYS_ITEM_ID_LEN];
 	u64 rsvd;
 };
 
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

