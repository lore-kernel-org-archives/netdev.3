Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C4455199;
	Tue,  4 Aug 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840457; cv=none; b=gKBc1+f/zbXRsj6g9tbE00lupo6wFpQUDbFK8UmbnNvobF0bHOQsc5PefYslKiyUC4scfPevOpo6lH3kcGVluHcSp6efQm6B1KJ6/mkGKye1cwsAEE0S0r4ml21IoUUt5wXWsfevvKM0DPF4iI5C9HUs5Kix8/bCK+0OYZwprNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840457; c=relaxed/simple;
	bh=CmUzvgtKR/OkPpSw4bUAgaJyGq3P7CxE7Ik1Er3cCzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKrFB8+1KfUNgE5zjG1Qg8nFGogzvR3MHldj72RECwS2KBdx+6V2FYxqnN5NBNekDQ8em8OiiEcQQPbBdxMF6HdTPuv30qFxoY4oUwlYcWLLHaeeJoV0tY4AoI6xLxnpDuRtTis6o9pta4G8dW2J6R68whW/4e7Xv6mOXfIimCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=btQsiiKb; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="btQsiiKb"
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6749c2Ox2676660;
	Tue, 4 Aug 2026 03:47:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=w
	S762hsFKqayVzUB9/SkJlqX7cQWzBfpFmzC6uy3+Hk=; b=btQsiiKb1m0UwCHxm
	HEVKleFNB/VOTzS1izHXeOvkZrdUGJ4hCqifwgfcYOoRX13Q3t4fEq02511dt/nh
	okOWUVbE4dG34OPXy1a3Lov7vbe0o57CKGQLOzcT0jGCIa5i/0duKYXJ2OzjHra1
	dxBK7a0hDFaA+p7edUfwik0qJa7rtHU4eS7Y9jzwiD8GV+keE79VxlK1egod0cjo
	g1pgJrGTRie43hK/M+XDQM8ske/4PV1fjOLwsXCdt9M4xNUlUGZ9fy1xv6FjCZaN
	Ey0WA3+zKo+b1WXLa/05/4E0Mabsy0GPYppqNmxngGOX9wSRw5JTXCg8t4Bgtd1k
	sk+JQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ft5266q07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 03:47:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 4 Aug 2026 03:47:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 4 Aug 2026 03:47:27 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 9AA615B693A;
	Tue,  4 Aug 2026 03:47:24 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v7 net-next 4/9] octeontx2-af: switch: Representor for switch port
Date: Tue, 4 Aug 2026 16:17:01 +0530
Message-ID: <20260804104706.120996-5-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804104706.120996-1-rkannoth@marvell.com>
References: <20260804104706.120996-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VdbH+lp9 c=1 sm=1 tr=0 ts=6a71c340 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=NuewfLXoHotJXjtrcvQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: 86c2L-5hbZz8ffk6fnuhZlIN1s9ZD91X
X-Proofpoint-GUID: 86c2L-5hbZz8ffk6fnuhZlIN1s9ZD91X
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX2OhYJycXNWTQ
 m+kyfB/dG7O2OHeCOVHZigFCmVEU8cZj+0baPhSaxOYuePHFiWs8GUnxfeDqwLc4TkV4mmseqSB
 AjPWZDwUmIkYUX//njnC8BjUGKmIDqg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA4NSBTYWx0ZWRfX5kwJCDiVXBIX
 yjpBjSdqMHQd2M3Q/xPt13zfA3XVbGXe7OPlMSl6cqYr3Bdd5vZR5K9z/uLO3OjBIhNw0Mlx28L
 4n06W/nZFLF4l5d3rG6loBbdj8f+hcV6Rk3RkmAZRVLURE7ELweUr/vDFLv8j/mbk24xApawAe6
 pIAoGySdS8cVTgHBoN7SM/yzJgHpmBKfDLg0PmAELNUGA4RbXgsgcjxzKHLWxZESolvfQuDobFh
 Xqeod5/hcayxBPY0QzbxeVTynzJ3mNV67COJ1P4N5j/yvYgdF0FFLLhg9bcFhMQrItMDesgOgIV
 CNOTY5NoWC6fz/g1WHktQvOlZ384nAq+a/yl7O8R8xhF4A0Pe0HDui3I6XjnAwpRjh4+FFaJMNf
 Nz9eH+b1Bma66w/nESS/OxnuJ3467YA12kcdcQhuBOUfdmsc8Ad10wK6uikiUTpbI3iaL5208a/
 G2sjdF2FxFVOBNmwhvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01

Extends esw_cfg with a devlink-derived switch id, copies it into
rvu->rswitch on the AF, adds rvu_sw_port_id(), exports
rvu_rep_get_vlan_id().

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |  1 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  5 ++++
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 29 ++++++++++++++++++-
 .../marvell/octeontx2/af/switch/rvu_sw.c      | 26 +++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw.h      |  5 ++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  4 +++
 6 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 7b75e8af6e75..3176f952c969 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1839,6 +1839,7 @@ struct esw_cfg_req {
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
index a2781e0f504e..38e26329ff48 100644
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
 
@@ -429,6 +430,26 @@ int rvu_rep_pf_init(struct rvu *rvu)
 	return 0;
 }
 
+/* ESW_CFG is always sent as the sole message in a mailbox transaction
+ * (see rvu_eswitch_config()), so next_msgoff minus the mailbox header
+ * offset yields this message's size. The calculation is not valid if
+ * ESW_CFG were ever batched with other messages.
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
@@ -436,6 +457,9 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 		return 0;
 
 	rvu->rep_mode = req->ena;
+	if (esw_cfg_req_has_switch_id(req))
+		memcpy(rvu->rswitch.switch_id, req->switch_id,
+		       MAX_PHYS_ITEM_ID_LEN);
 
 	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
@@ -449,6 +473,9 @@ int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
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

