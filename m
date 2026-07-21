Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD37E445AC3;
	Tue, 21 Jul 2026 08:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621951; cv=none; b=A5UI21jbx4evqTYMTF/VpkmywKrlYC74AxENL/PRLLIxXOu8b0Y/IY854YF8mQWFlqy8vVF1+uJwiYHCCgs8KS5xgfcbNq+bH9+TewKfvHk1qV5fbSCj2heHXPnu1w1JtXruJwkCif3e4THAPBmkA91B5e3pko4hq9c8kPkK2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621951; c=relaxed/simple;
	bh=X9K2ajUDVXuAvv73k51pZBzAyu1smc3rQLuBpZmxun8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUEI9GxTMJbWEv2Ro37p8dtmZc0OLUgPNu92BWO7L5YquLOdhk6+rfh6wYavS6Pi9E8CIPGHqRYdEot8krr3fWBRq8C6JOp+gFeks6tC6PH6bFYhpIhXChBZoTd7BahOrqgAYSh0uDrfb+iM6V7/0l7NiGY8xnb4U0uSQIGOvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=D+yveLwx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="D+yveLwx"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcbL53070050;
	Tue, 21 Jul 2026 01:18:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	MRT/yCdc/s9fuIDY4p+VKB1jZm0rgBQvvrGg7MX4kY=; b=D+yveLwxQhoMonl9r
	1kqV67G5icyulcMDE2g2Newn/NQDiK6W+S7w6NYVg7lMaKEB8TE8UVnqYvfI3Hus
	VvZnImFjwGzYHKWQ915ea0q/5adN3NnV46UvIrPNfrJmiIkx2hpNyxIMlt05RG16
	YdIoVdphkqZxYvFl9Ysir4F4044DtKpHza0l4Lug5kns4lhvtktBrzX8Fo5gZuYA
	t5P6URrKA/IP2gRlCH3U7+VCVfd8hwydcqr/ebbovYUQe12BTjMSb+LALMFs+ih3
	c1mb/RE+ZGA8mgLL9MwFOliUEUMfOqrY/O1YxAY52fbzgeuFL++Z4gjX02NUZeKb
	lnXaw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4fhwdkh701-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:57 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:56 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:56 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 27BDF3F7091;
	Tue, 21 Jul 2026 01:18:53 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 9/9] octeontx2: switch: add TC flow offload path for switch flows
Date: Tue, 21 Jul 2026 13:48:24 +0530
Message-ID: <20260721081824.1430607-10-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: wMiEyeukR-aBNutF8G3KzyN2OYA9DBEa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NyBTYWx0ZWRfX7CrpvUPPC5Uh
 TS9gyj2o9Q+JWkltcfON32fNPID0g+ZRwcyjd/3Opyd/C1O9b9MD9ZdNUkK4pXmfLMFohUfdZ5H
 +7mFfZdWd6N7T6gscFTMdsiN6c7FWV4=
X-Authority-Analysis: v=2.4 cv=TrXWQjXh c=1 sm=1 tr=0 ts=6a5f2b71 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=gxODTceSeL9lbQbNvVgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: wMiEyeukR-aBNutF8G3KzyN2OYA9DBEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NyBTYWx0ZWRfXxZp1n+leQTsK
 fleb5Mxt3AXcSxWhF4W3d8U7kKwSn2V9cBWTUT1f1yd4gPUWymsBVYDmnehVsuFnz8RwaMvERjz
 Dtqq9Ydq9w/Uc2+2ABNSH1MjBJJKz0i8kvruvBzD0SUkJ7omrK1Z7jpG0dkCRVTkGzBpwo1aYr/
 cWmLa9cU+rynlW4KjmjKlSGEYtjPdb+Ria8VW2/nnOP4VgcYXUI4Pb0y5hjsuGYSUqapQ+CnRbk
 P+6RNISQ9yJHHpPE20oOPsYOLwz1DX4S8vvrDucQd8q1aKXDm6waeaNL097viIOkJ+N+Opo2RVi
 NTvh5FSGqtDMpjDEpt26EMx4XBXrvjE6/IoDuH06Jhy2N/TfXpPqlkMn6JGfqCT76g+juy6qfBU
 VpLPQKCbUXveLHtpFAIS3UmqmNZqH5JIxDd2ijZUH2ZsqkigCcfSWWYciWqH2/GFV1FA+B67qmH
 x9wN4VzhVb4+aKw/tgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

Register an ingress flow-table offload callback that translates TC
flower rules into fl_tuple state, resolves ingress and egress
pcifunc via FIB for accelerated ports, and notifies the RVU AF over
the PF mailbox.  The AF forwards flow updates to switchdev and
keeps per-cookie packet counters in sync using NPC MCAM multi-stats
when the switch requests SWDEV2AF refresh.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   9 +-
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   | 327 +++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |   2 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |   3 +-
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 909 ++++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fl.h      |   2 +
 .../marvell/octeontx2/nic/switch/sw_trace.c   |  11 +
 .../marvell/octeontx2/nic/switch/sw_trace.h   |  84 ++
 8 files changed, 1345 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 1151ba47284b..f89633f4b821 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -7,10 +7,10 @@
 
 #include <linux/bitfield.h>
 #include "rvu.h"
-#include "rvu_sw.h"
 #include "rvu_sw_l2.h"
 #include "rvu_sw_l3.h"
 #include "rvu_sw_fl.h"
+#include "rvu_sw.h"
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 {
@@ -69,6 +69,12 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
 		break;
 
+	case SWDEV2AF_MSG_TYPE_REFRESH_FL:
+		if (req->cnt <= 0 || req->cnt > ARRAY_SIZE(req->fl))
+			return -EINVAL;
+		rc = rvu_sw_fl_stats_sync2db(rvu, req->fl, req->cnt);
+		break;
+
 	default:
 		rc = -EOPNOTSUPP;
 		break;
@@ -81,4 +87,5 @@ void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
 	rvu_sw_l3_shutdown();
+	rvu_sw_fl_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
index 1f8b82a84a5d..a75aa991d29e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -4,12 +4,275 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_fl.h"
+
+static struct af2swdev_notify_req __maybe_unused
+*otx2_mbox_alloc_msg_af2swdev_notify(struct rvu *rvu, int devid)
+{
+	struct af2swdev_notify_req *req;
+
+	req = (struct af2swdev_notify_req *)
+		otx2_mbox_alloc_msg_rsp(&rvu->afpf_wq_info.mbox_up, devid,
+					sizeof(*req), sizeof(struct msg_rsp));
+	if (!req)
+		return NULL;
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;
+	req->hdr.id = MBOX_MSG_AF2SWDEV;
+	return req;
+}
+
+#define RVU_SW_FL_REFRESH_MAX						\
+	((int)ARRAY_SIZE(((struct swdev2af_notify_req *)0)->fl))
+
+struct fl_entry {
+	struct list_head list;
+	struct rvu *rvu;
+	u32 port_id;
+	unsigned long cookie;
+	struct fl_tuple tuple;
+	u64 flags;
+	u64 features;
+};
+
+static DEFINE_MUTEX(fl_offl_llock);
+static LIST_HEAD(fl_offl_lh);
+
+static struct workqueue_struct *sw_fl_offl_wq;
+static void sw_fl_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(fl_offl_work, sw_fl_offl_work_handler);
+
+struct sw_fl_stats_node {
+	struct list_head list;
+	unsigned long cookie;
+	u16 mcam_idx[2];
+	u64 opkts, npkts;
+	bool uni_di;
+};
+
+static LIST_HEAD(sw_fl_stats_lh);
+static DEFINE_MUTEX(sw_fl_stats_lock);
+
+static void rvu_sw_fl_queue_work(void)
+{
+	if (sw_fl_offl_wq)
+		queue_delayed_work(sw_fl_offl_wq, &fl_offl_work,
+				   msecs_to_jiffies(10));
+}
+
+static int rvu_sw_fl_ensure_wq(void)
+{
+	if (sw_fl_offl_wq)
+		return 0;
+
+	sw_fl_offl_wq = alloc_workqueue("sw_af_fl_wq", 0, 0);
+	if (!sw_fl_offl_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int
+rvu_sw_fl_stats_sync2db_one_entry(unsigned long cookie, u8 disabled,
+				  u16 mcam_idx[2], bool uni_di, u64 pkts)
+{
+	struct sw_fl_stats_node *snode, *tmp;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		if (snode->cookie != cookie)
+			continue;
+
+		if (disabled) {
+			list_del_init(&snode->list);
+			mutex_unlock(&sw_fl_stats_lock);
+			kfree(snode);
+			return 0;
+		}
+
+		if (snode->uni_di != uni_di) {
+			snode->uni_di = uni_di;
+			snode->mcam_idx[1] = mcam_idx[1];
+		}
+
+		if (snode->opkts == pkts) {
+			mutex_unlock(&sw_fl_stats_lock);
+			return 0;
+		}
+
+		snode->npkts = pkts;
+		mutex_unlock(&sw_fl_stats_lock);
+		return 0;
+	}
+
+	if (disabled) {
+		mutex_unlock(&sw_fl_stats_lock);
+		return 0;
+	}
+
+	snode = kcalloc(1, sizeof(*snode), GFP_KERNEL);
+	if (!snode) {
+		mutex_unlock(&sw_fl_stats_lock);
+		return -ENOMEM;
+	}
+
+	snode->cookie = cookie;
+	snode->mcam_idx[0] = mcam_idx[0];
+	if (!uni_di)
+		snode->mcam_idx[1] = mcam_idx[1];
+
+	snode->npkts = pkts;
+	snode->uni_di = uni_di;
+	INIT_LIST_HEAD(&snode->list);
+
+	list_add_tail(&snode->list, &sw_fl_stats_lh);
+	mutex_unlock(&sw_fl_stats_lock);
+
+	return 0;
+}
+
+int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt)
+{
+	struct npc_mcam_get_mul_stats_req *req = NULL;
+	struct npc_mcam_get_mul_stats_rsp *rsp = NULL;
+	int i, idx;
+	int rc = 0;
+	u64 pkts;
+
+	if (cnt <= 0 || cnt > RVU_SW_FL_REFRESH_MAX)
+		return -EINVAL;
+
+	req = kcalloc(1, sizeof(*req), GFP_KERNEL);
+	if (!req) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	rsp = kcalloc(1, sizeof(*rsp), GFP_KERNEL);
+	if (!rsp) {
+		rc = -ENOMEM;
+		goto fail;
+	}
+
+	idx = 0;
+	for (i = 0; i < cnt; i++) {
+		req->entry[idx++] = fl[i].mcam_idx[0];
+		if (!fl[i].uni_di)
+			req->entry[idx++] = fl[i].mcam_idx[1];
+	}
+	req->cnt = idx;
+
+	if (idx > 256) {
+		rc = -EINVAL;
+		goto fail;
+	}
+
+	if (rvu_mbox_handler_npc_mcam_mul_stats(rvu, req, rsp)) {
+		dev_err(rvu->dev, "Error to get multiple stats\n");
+		rc = -EFAULT;
+		goto fail;
+	}
+
+	idx = 0;
+	for (i = 0; i < cnt; i++) {
+		pkts = rsp->stat[idx++];
+		if (!fl[i].uni_di)
+			pkts += rsp->stat[idx++];
+
+		rc |= rvu_sw_fl_stats_sync2db_one_entry(fl[i].cookie, fl[i].dis,
+							fl[i].mcam_idx,
+							fl[i].uni_di, pkts);
+	}
+
+fail:
+	kfree(req);
+	kfree(rsp);
+	return rc;
+}
+
+static int rvu_sw_fl_offl_rule_push(struct fl_entry *fl_entry)
+{
+	struct af2swdev_notify_req *req;
+	struct rvu *rvu;
+	int swdev_pf;
+
+	rvu = fl_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	req->tuple = fl_entry->tuple;
+	req->flags = fl_entry->flags;
+	req->cookie = fl_entry->cookie;
+	req->features = fl_entry->features;
+
+	if (!otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf)) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -EBUSY;
+	}
+
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static void sw_fl_offl_work_handler(struct work_struct *work)
+{
+	struct fl_entry *fl_entry;
+
+	mutex_lock(&fl_offl_llock);
+	fl_entry = list_first_entry_or_null(&fl_offl_lh, struct fl_entry, list);
+	if (!fl_entry) {
+		mutex_unlock(&fl_offl_llock);
+		return;
+	}
+
+	list_del_init(&fl_entry->list);
+	mutex_unlock(&fl_offl_llock);
+
+	if (rvu_sw_fl_offl_rule_push(fl_entry)) {
+		mutex_lock(&fl_offl_llock);
+		list_add_tail(&fl_entry->list, &fl_offl_lh);
+		mutex_unlock(&fl_offl_llock);
+		if (sw_fl_offl_wq)
+			queue_delayed_work(sw_fl_offl_wq, &fl_offl_work,
+					   msecs_to_jiffies(100));
+		return;
+	}
+
+	kfree(fl_entry);
+
+	mutex_lock(&fl_offl_llock);
+	if (!list_empty(&fl_offl_lh))
+		rvu_sw_fl_queue_work();
+	mutex_unlock(&fl_offl_llock);
+}
 
 int rvu_mbox_handler_fl_get_stats(struct rvu *rvu,
 				  struct fl_get_stats_req *req,
 				  struct fl_get_stats_rsp *rsp)
 {
+	struct sw_fl_stats_node *snode, *tmp;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		if (snode->cookie != req->cookie)
+			continue;
+
+		rsp->pkts_diff = snode->npkts - snode->opkts;
+		snode->opkts = snode->npkts;
+		break;
+	}
+	mutex_unlock(&sw_fl_stats_lock);
 	return 0;
 }
 
@@ -17,5 +280,69 @@ int rvu_mbox_handler_fl_notify(struct rvu *rvu,
 			       struct fl_notify_req *req,
 			       struct msg_rsp *rsp)
 {
+	struct fl_entry *fl_entry;
+	int rc;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return -EAGAIN;
+
+	fl_entry = kcalloc(1, sizeof(*fl_entry), GFP_KERNEL);
+	if (!fl_entry)
+		return -ENOMEM;
+
+	fl_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	fl_entry->rvu = rvu;
+	INIT_LIST_HEAD(&fl_entry->list);
+	fl_entry->tuple = req->tuple;
+	fl_entry->cookie = req->cookie;
+	fl_entry->flags = req->flags;
+	fl_entry->features = req->features;
+
+	mutex_lock(&fl_offl_llock);
+	rc = rvu_sw_fl_ensure_wq();
+	if (rc) {
+		mutex_unlock(&fl_offl_llock);
+		kfree(fl_entry);
+		return rc;
+	}
+
+	list_add_tail(&fl_entry->list, &fl_offl_lh);
+	rvu_sw_fl_queue_work();
+	mutex_unlock(&fl_offl_llock);
+
 	return 0;
 }
+
+void rvu_sw_fl_shutdown(void)
+{
+	struct sw_fl_stats_node *snode, *tmp;
+	struct workqueue_struct *wq;
+	struct fl_entry *entry;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		list_del_init(&snode->list);
+		kfree(snode);
+	}
+	mutex_unlock(&sw_fl_stats_lock);
+
+	if (!sw_fl_offl_wq)
+		return;
+
+	cancel_delayed_work_sync(&fl_offl_work);
+	wq = sw_fl_offl_wq;
+	sw_fl_offl_wq = NULL;
+	destroy_workqueue(wq);
+
+	mutex_lock(&fl_offl_llock);
+	while (1) {
+		entry = list_first_entry_or_null(&fl_offl_lh,
+						 struct fl_entry, list);
+		if (!entry)
+			break;
+
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	mutex_unlock(&fl_offl_llock);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
index cf3e5b884f77..f117a96fc33e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.h
@@ -7,5 +7,7 @@
 
 #ifndef RVU_SW_FL_H
 #define RVU_SW_FL_H
+int rvu_sw_fl_stats_sync2db(struct rvu *rvu, struct fl_info *fl, int cnt);
+void rvu_sw_fl_shutdown(void);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
index 02ab0634f58f..917a34a32ca8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_RVU_ESWITCH) += rvu_rep.o
 rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o \
-	       switch/sw_fdb.o switch/sw_fl.o
+	       switch/sw_fdb.o switch/sw_fl.o switch/sw_trace.o
 rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o \
 				       switch/sw_nb_v4.o
 ifneq ($(CONFIG_IPV6),)
@@ -25,3 +25,4 @@ rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
 rvu_nicpf-$(CONFIG_XFRM_OFFLOAD) += cn10k_ipsec.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
+ccflags-y += -I$(src)/switch/
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
index 36a2359a0a48..7c7d4f788442 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -4,13 +4,922 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/nexthop.h>
+#include <net/netfilter/nf_flow_table.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_trace.h"
 #include "sw_fl.h"
 
+#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv)
+{
+	return -EOPNOTSUPP;
+}
+
+#else
+
+static DEFINE_SPINLOCK(sw_fl_lock);
+static LIST_HEAD(sw_fl_lh);
+
+struct sw_fl_list_entry {
+	struct list_head list;
+	u64 flags;
+	unsigned long cookie;
+	struct otx2_nic *pf;
+	netdevice_tracker dev_tracker;
+	struct fl_tuple tuple;
+};
+
+static struct workqueue_struct *sw_fl_wq;
+static void sw_fl_wq_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(sw_fl_work, sw_fl_wq_handler);
+
+struct sw_fl_ct_cb {
+	struct list_head list;
+	struct nf_flowtable *ft;
+	struct otx2_nic *nic;
+	refcount_t ref;
+};
+
+struct sw_fl_ct_cookie {
+	struct list_head list;
+	unsigned long cookie;
+	struct nf_flowtable *ft;
+	struct otx2_nic *nic;
+};
+
+struct sw_fl_ct_drain {
+	struct list_head list;
+	struct nf_flowtable *ft;
+	struct otx2_nic *nic;
+};
+
+static LIST_HEAD(sw_fl_ct_cb_list);
+static LIST_HEAD(sw_fl_ct_drain_list);
+static DEFINE_MUTEX(sw_fl_ct_cb_lock);
+static LIST_HEAD(sw_fl_ct_cookie_list);
+static DEFINE_MUTEX(sw_fl_ct_cookie_lock);
+
+static struct sw_fl_ct_cb *sw_fl_ct_cb_find(struct nf_flowtable *ft,
+					    struct otx2_nic *nic)
+{
+	struct sw_fl_ct_cb *entry;
+
+	list_for_each_entry(entry, &sw_fl_ct_cb_list, list) {
+		if (entry->ft == ft && entry->nic == nic)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static bool sw_fl_ct_draining(struct nf_flowtable *ft, struct otx2_nic *nic)
+{
+	struct sw_fl_ct_drain *drain;
+
+	list_for_each_entry(drain, &sw_fl_ct_drain_list, list) {
+		if (drain->ft == ft && drain->nic == nic)
+			return true;
+	}
+
+	return false;
+}
+
+static int sw_fl_ct_cb_get(struct nf_flowtable *ft, struct otx2_nic *nic)
+{
+	struct sw_fl_ct_cb *entry;
+	int err;
+
+	mutex_lock(&sw_fl_ct_cb_lock);
+	if (sw_fl_ct_draining(ft, nic)) {
+		mutex_unlock(&sw_fl_ct_cb_lock);
+		return -EBUSY;
+	}
+	entry = sw_fl_ct_cb_find(ft, nic);
+	if (entry) {
+		refcount_inc(&entry->ref);
+		mutex_unlock(&sw_fl_ct_cb_lock);
+		return 0;
+	}
+	mutex_unlock(&sw_fl_ct_cb_lock);
+
+	err = nf_flow_table_offload_add_cb(ft, sw_fl_setup_ft_block_ingress_cb, nic);
+	if (err && err != -EEXIST)
+		return err;
+
+	mutex_lock(&sw_fl_ct_cb_lock);
+	if (sw_fl_ct_draining(ft, nic)) {
+		mutex_unlock(&sw_fl_ct_cb_lock);
+		if (!err)
+			nf_flow_table_offload_del_cb(ft,
+						     sw_fl_setup_ft_block_ingress_cb,
+						     nic);
+		return -EBUSY;
+	}
+	entry = sw_fl_ct_cb_find(ft, nic);
+	if (entry) {
+		refcount_inc(&entry->ref);
+		mutex_unlock(&sw_fl_ct_cb_lock);
+		if (!err)
+			nf_flow_table_offload_del_cb(ft,
+						     sw_fl_setup_ft_block_ingress_cb,
+						     nic);
+		return 0;
+	}
+
+	entry = kzalloc_obj(*entry, GFP_KERNEL);
+	if (!entry) {
+		mutex_unlock(&sw_fl_ct_cb_lock);
+		if (!err)
+			nf_flow_table_offload_del_cb(ft,
+						     sw_fl_setup_ft_block_ingress_cb,
+						     nic);
+		return -ENOMEM;
+	}
+
+	entry->ft = ft;
+	entry->nic = nic;
+	refcount_set(&entry->ref, 1);
+	list_add_tail(&entry->list, &sw_fl_ct_cb_list);
+	mutex_unlock(&sw_fl_ct_cb_lock);
+
+	return 0;
+}
+
+static void sw_fl_ct_cb_put(struct nf_flowtable *ft, struct otx2_nic *nic)
+{
+	struct sw_fl_ct_cb *entry;
+	struct sw_fl_ct_drain drain;
+
+	mutex_lock(&sw_fl_ct_cb_lock);
+	entry = sw_fl_ct_cb_find(ft, nic);
+	if (!entry || !refcount_dec_and_test(&entry->ref)) {
+		mutex_unlock(&sw_fl_ct_cb_lock);
+		return;
+	}
+
+	drain.ft = ft;
+	drain.nic = nic;
+	INIT_LIST_HEAD(&drain.list);
+	list_add_tail(&drain.list, &sw_fl_ct_drain_list);
+
+	list_del(&entry->list);
+	mutex_unlock(&sw_fl_ct_cb_lock);
+
+	nf_flow_table_offload_del_cb(ft, sw_fl_setup_ft_block_ingress_cb, nic);
+
+	mutex_lock(&sw_fl_ct_cb_lock);
+	list_del(&drain.list);
+	mutex_unlock(&sw_fl_ct_cb_lock);
+
+	kfree(entry);
+}
+
+static struct sw_fl_ct_cookie *sw_fl_ct_cookie_find(unsigned long cookie)
+{
+	struct sw_fl_ct_cookie *entry;
+
+	list_for_each_entry(entry, &sw_fl_ct_cookie_list, list) {
+		if (entry->cookie == cookie)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static int sw_fl_ct_cookie_add(unsigned long cookie, struct nf_flowtable *ft,
+			       struct otx2_nic *nic)
+{
+	struct sw_fl_ct_cookie *entry, *existing;
+
+	entry = kzalloc_obj(*entry, GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->cookie = cookie;
+	entry->ft = ft;
+	entry->nic = nic;
+
+	mutex_lock(&sw_fl_ct_cookie_lock);
+	existing = sw_fl_ct_cookie_find(cookie);
+	if (existing) {
+		if (existing->ft == ft && existing->nic == nic) {
+			mutex_unlock(&sw_fl_ct_cookie_lock);
+			kfree(entry);
+			sw_fl_ct_cb_put(ft, nic);
+			return 0;
+		}
+
+		list_del(&existing->list);
+		mutex_unlock(&sw_fl_ct_cookie_lock);
+		sw_fl_ct_cb_put(existing->ft, existing->nic);
+		kfree(existing);
+
+		mutex_lock(&sw_fl_ct_cookie_lock);
+	}
+
+	list_add_tail(&entry->list, &sw_fl_ct_cookie_list);
+	mutex_unlock(&sw_fl_ct_cookie_lock);
+
+	return 0;
+}
+
+static void sw_fl_ct_cookie_put(unsigned long cookie)
+{
+	struct sw_fl_ct_cookie *entry, *tmp;
+
+	mutex_lock(&sw_fl_ct_cookie_lock);
+	list_for_each_entry_safe(entry, tmp, &sw_fl_ct_cookie_list, list) {
+		if (entry->cookie != cookie)
+			continue;
+
+		list_del(&entry->list);
+		mutex_unlock(&sw_fl_ct_cookie_lock);
+		sw_fl_ct_cb_put(entry->ft, entry->nic);
+		kfree(entry);
+		return;
+	}
+	mutex_unlock(&sw_fl_ct_cookie_lock);
+}
+
+static void sw_fl_ct_cb_flush(void)
+{
+	struct sw_fl_ct_cookie *cookie, *ctmp;
+	struct sw_fl_ct_cb *entry;
+	struct sw_fl_ct_drain drain;
+	struct nf_flowtable *ft;
+	struct otx2_nic *nic;
+
+	mutex_lock(&sw_fl_ct_cookie_lock);
+	list_for_each_entry_safe(cookie, ctmp, &sw_fl_ct_cookie_list, list) {
+		list_del(&cookie->list);
+		kfree(cookie);
+	}
+	mutex_unlock(&sw_fl_ct_cookie_lock);
+
+	mutex_lock(&sw_fl_ct_cb_lock);
+	while ((entry = list_first_entry_or_null(&sw_fl_ct_cb_list,
+						 struct sw_fl_ct_cb, list))) {
+		ft = entry->ft;
+		nic = entry->nic;
+		drain.ft = ft;
+		drain.nic = nic;
+		INIT_LIST_HEAD(&drain.list);
+		list_add_tail(&drain.list, &sw_fl_ct_drain_list);
+
+		list_del(&entry->list);
+		mutex_unlock(&sw_fl_ct_cb_lock);
+
+		nf_flow_table_offload_del_cb(ft,
+					     sw_fl_setup_ft_block_ingress_cb,
+					     nic);
+
+		mutex_lock(&sw_fl_ct_cb_lock);
+		list_del(&drain.list);
+		kfree(entry);
+	}
+	mutex_unlock(&sw_fl_ct_cb_lock);
+}
+
+static int sw_fl_msg_send(struct otx2_nic *pf,
+			  struct fl_tuple *tuple,
+			  u64 flags,
+			  unsigned long cookie)
+{
+	struct fl_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fl_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	req->tuple = *tuple;
+	req->flags = flags;
+	req->cookie = cookie;
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fl_wq_handler(struct work_struct *work)
+{
+	struct sw_fl_list_entry *entry;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fl_lock);
+	list_splice_init(&sw_fl_lh, &tlist);
+	spin_unlock_bh(&sw_fl_lock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fl_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		if (sw_fl_msg_send(entry->pf, &entry->tuple,
+				   entry->flags, entry->cookie)) {
+			netdev_err(entry->pf->netdev,
+				   "Failed to notify flow update to AF, will retry\n");
+			spin_lock_bh(&sw_fl_lock);
+			if (sw_fl_wq) {
+				list_add(&entry->list, &sw_fl_lh);
+				queue_delayed_work(sw_fl_wq, &sw_fl_work,
+						   msecs_to_jiffies(100));
+				spin_unlock_bh(&sw_fl_lock);
+				continue;
+			}
+			spin_unlock_bh(&sw_fl_lock);
+			netdev_put(entry->pf->netdev, &entry->dev_tracker);
+			kfree(entry);
+			continue;
+		}
+		netdev_put(entry->pf->netdev, &entry->dev_tracker);
+		kfree(entry);
+	}
+
+	spin_lock_bh(&sw_fl_lock);
+	if (!list_empty(&sw_fl_lh) && sw_fl_wq)
+		queue_delayed_work(sw_fl_wq, &sw_fl_work, msecs_to_jiffies(10));
+	spin_unlock_bh(&sw_fl_lock);
+}
+
+static int
+sw_fl_add_to_list(struct otx2_nic *pf, struct fl_tuple *tuple,
+		  unsigned long cookie, bool add_fl)
+{
+	struct sw_fl_list_entry *entry;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	entry->pf = pf;
+	entry->flags = add_fl ? FL_ADD : FL_DEL;
+	if (add_fl)
+		entry->tuple = *tuple;
+	entry->cookie = cookie;
+	entry->tuple.uni_di = netif_is_ovs_port(pf->netdev);
+
+	spin_lock_bh(&sw_fl_lock);
+	if (!sw_fl_wq) {
+		spin_unlock_bh(&sw_fl_lock);
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	netdev_hold(pf->netdev, &entry->dev_tracker, GFP_ATOMIC);
+	list_add_tail(&entry->list, &sw_fl_lh);
+	queue_delayed_work(sw_fl_wq, &sw_fl_work, msecs_to_jiffies(10));
+	spin_unlock_bh(&sw_fl_lock);
+
+	return 0;
+}
+
+static int sw_fl_mangle_layer(enum flow_action_mangle_base htype)
+{
+	switch (htype) {
+	case FLOW_ACT_MANGLE_HDR_TYPE_ETH:
+		return 0;
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP4:
+	case FLOW_ACT_MANGLE_HDR_TYPE_IP6:
+		return 2;
+	case FLOW_ACT_MANGLE_HDR_TYPE_TCP:
+	case FLOW_ACT_MANGLE_HDR_TYPE_UDP:
+		return 3;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int sw_fl_parse_actions(struct otx2_nic *nic,
+			       struct flow_action *flow_action,
+			       struct flow_cls_offload *f,
+			       struct fl_tuple *tuple, u64 *op,
+			       struct nf_flowtable **ct_ft)
+{
+	struct flow_action_entry *act;
+	struct nf_flowtable *parsed_ct_ft = NULL;
+	struct otx2_nic *out_nic;
+	int parsed_ct_refs = 0;
+	int used = 0;
+	int err;
+	int i;
+
+	if (!flow_action_has_entries(flow_action))
+		return -EINVAL;
+
+	flow_action_for_each(i, act, flow_action) {
+		switch (act->id) {
+		case FLOW_ACTION_REDIRECT:
+			if (!act->dev || !sw_nb_is_valid_dev(act->dev)) {
+				err = -EOPNOTSUPP;
+				goto unwind_ct;
+			}
+			trace_sw_act_dump(__func__, "redirect to egress port", act->id);
+			tuple->in_pf = nic->pcifunc;
+			out_nic = netdev_priv(act->dev);
+			tuple->xmit_pf = out_nic->pcifunc;
+			*op |= BIT_ULL(FLOW_ACTION_REDIRECT);
+			break;
+
+		case FLOW_ACTION_CT:
+			trace_sw_act_dump(__func__, "register conntrack offload callback", act->id);
+			err = sw_fl_ct_cb_get(act->ct.flow_table, nic);
+			if (err) {
+				netdev_err(nic->netdev,
+					   "%s: Error to offload flow, err=%d\n",
+					   __func__, err);
+				goto unwind_ct;
+			}
+
+			parsed_ct_ft = act->ct.flow_table;
+			parsed_ct_refs++;
+			if (ct_ft)
+				*ct_ft = act->ct.flow_table;
+			*op |= BIT_ULL(FLOW_ACTION_CT);
+			break;
+
+		case FLOW_ACTION_MANGLE: {
+			int layer;
+
+			if (used >= MANGLE_ARR_SZ) {
+				netdev_err(nic->netdev,
+					   "%s: More mangle entries than supported %u\n",
+					   __func__, MANGLE_ARR_SZ);
+				err = -ENOMEM;
+				goto unwind_ct;
+			}
+
+			layer = sw_fl_mangle_layer(act->mangle.htype);
+			if (layer < 0) {
+				err = layer;
+				goto unwind_ct;
+			}
+
+			trace_sw_act_dump(__func__, "header mangle action", act->id);
+			tuple->mangle[used].type = act->mangle.htype;
+			tuple->mangle[used].val = act->mangle.val;
+			tuple->mangle[used].mask = act->mangle.mask;
+			tuple->mangle[used].offset = act->mangle.offset;
+			tuple->mangle_map[layer] |= BIT(used);
+			used++;
+			break;
+		}
+
+		default:
+			trace_sw_act_dump(__func__, "unsupported flow action", act->id);
+			break;
+		}
+	}
+
+	tuple->mangle_cnt = used;
+
+	if (!*op && !used) {
+		netdev_dbg(nic->netdev, "%s: Op is not valid\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+
+unwind_ct:
+	while (parsed_ct_refs--)
+		sw_fl_ct_cb_put(parsed_ct_ft, nic);
+	return err;
+}
+
+static int sw_fl_get_route(struct net *net, struct fib_result *res, __be32 addr)
+{
+	struct flowi4 fl4;
+
+	memset(&fl4, 0, sizeof(fl4));
+	fl4.daddr = addr;
+	return fib_lookup(net, &fl4, res, 0);
+}
+
+static int sw_fl_get_pcifunc(struct otx2_nic *pf, __be32 dst, u16 *pcifunc,
+			     struct fl_tuple *ftuple, bool is_in_dev)
+{
+	struct fib_nh_common *fib_nhc;
+	struct net_device *dev, *br;
+	struct fib_result res;
+	struct list_head *lh;
+	struct otx2_nic *nic;
+	int err;
+
+	rcu_read_lock();
+
+	err = sw_fl_get_route(dev_net(pf->netdev), &res, dst);
+	if (err) {
+		netdev_err(pf->netdev,
+			   "%s: Failed to find route to dst %pI4\n",
+			   __func__, &dst);
+		goto done;
+	}
+
+	if (res.fi->fib_type != RTN_UNICAST) {
+		netdev_err(pf->netdev,
+			   "%s: Not unicast  route to dst %pi4\n",
+			   __func__, &dst);
+		err = -EFAULT;
+		goto done;
+	}
+
+	fib_nhc = fib_info_nhc(res.fi, 0);
+	if (!fib_nhc) {
+		err = -EINVAL;
+		netdev_err(pf->netdev,
+			   "%s: Could not get fib_nhc for %pI4\n",
+			   __func__, &dst);
+		goto done;
+	}
+
+	if (unlikely(netif_is_bridge_master(fib_nhc->nhc_dev))) {
+		br = fib_nhc->nhc_dev;
+
+		if (is_in_dev)
+			ftuple->is_indev_br = 1;
+		else
+			ftuple->is_xdev_br = 1;
+
+		lh = &br->adj_list.lower;
+		if (list_empty(lh)) {
+			netdev_err(pf->netdev,
+				   "%s: Unable to find any slave device\n",
+				   __func__);
+			err = -EINVAL;
+			goto done;
+		}
+		dev = netdev_next_lower_dev_rcu(br, &lh);
+
+	} else {
+		dev = fib_nhc->nhc_dev;
+	}
+
+	if (!dev || !sw_nb_is_valid_dev(dev)) {
+		netdev_err(pf->netdev,
+			   "%s: flow acceleration support is only for cavium devices\n",
+			   __func__);
+		err = -EOPNOTSUPP;
+		goto done;
+	}
+
+	nic = netdev_priv(dev);
+	*pcifunc = nic->pcifunc;
+
+done:
+	rcu_read_unlock();
+	return err;
+}
+
+static int sw_fl_parse_flow(struct otx2_nic *nic, struct flow_cls_offload *f,
+			    struct fl_tuple *tuple, u64 *features)
+{
+	struct flow_rule *rule;
+	u8 ip_proto = 0;
+
+	*features = 0;
+
+	rule = flow_cls_offload_flow_rule(f);
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_BASIC)) {
+		struct flow_match_basic match;
+
+		flow_rule_match_basic(rule, &match);
+
+		/* All EtherTypes can be matched, no hw limitation */
+
+		if (match.mask->n_proto) {
+			tuple->eth_type = match.key->n_proto;
+			tuple->m_eth_type = match.mask->n_proto;
+			*features |= BIT_ULL(NPC_ETYPE);
+		}
+
+		if (match.mask->ip_proto) {
+			if (match.key->ip_proto != IPPROTO_TCP &&
+			    match.key->ip_proto != IPPROTO_UDP)
+				return -EOPNOTSUPP;
+
+			ip_proto = match.key->ip_proto;
+			if (ip_proto == IPPROTO_UDP)
+				*features |= BIT_ULL(NPC_IPPROTO_UDP);
+			else
+				*features |= BIT_ULL(NPC_IPPROTO_TCP);
+		}
+
+		tuple->proto = ip_proto;
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
+		struct flow_match_eth_addrs match;
+
+		flow_rule_match_eth_addrs(rule, &match);
+
+		/* Switch flow offload matches unicast L2 addresses only.
+		 * Multicast and broadcast MAC keys are not programmed in
+		 * hardware; rules that rely solely on those keys are not
+		 * supported here.
+		 */
+		if (!is_zero_ether_addr(match.key->dst) &&
+		    is_unicast_ether_addr(match.key->dst)) {
+			ether_addr_copy(tuple->dmac,
+					match.key->dst);
+
+			ether_addr_copy(tuple->m_dmac,
+					match.mask->dst);
+
+			*features |= BIT_ULL(NPC_DMAC);
+		}
+
+		if (!is_zero_ether_addr(match.key->src) &&
+		    is_unicast_ether_addr(match.key->src)) {
+			ether_addr_copy(tuple->smac,
+					match.key->src);
+			ether_addr_copy(tuple->m_smac,
+					match.mask->src);
+			*features |= BIT_ULL(NPC_SMAC);
+		}
+	}
+
+	/* Switch flow offload parses IPv4 address keys only; IPv6 flow
+	 * matching and FIB-based pcifunc resolution are not supported yet.
+	 */
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_IPV4_ADDRS)) {
+		struct flow_match_ipv4_addrs match;
+
+		flow_rule_match_ipv4_addrs(rule, &match);
+
+		if (match.mask->dst) {
+			tuple->ip4dst = match.key->dst;
+			tuple->m_ip4dst = match.mask->dst;
+			*features |= BIT_ULL(NPC_DIP_IPV4);
+		}
+
+		if (match.mask->src) {
+			tuple->ip4src = match.key->src;
+			tuple->m_ip4src = match.mask->src;
+			*features |= BIT_ULL(NPC_SIP_IPV4);
+		}
+	}
+
+	if (!(*features & BIT_ULL(NPC_DMAC))) {
+		if (!tuple->m_ip4src || !tuple->m_ip4dst) {
+			netdev_err(nic->netdev,
+				   "%s: Invalid src=%pI4 and dst=%pI4 addresses\n",
+				   __func__, &tuple->ip4src, &tuple->ip4dst);
+			return -EINVAL;
+		}
+
+		if ((tuple->ip4src & tuple->m_ip4src) == (tuple->ip4dst & tuple->m_ip4dst)) {
+			netdev_err(nic->netdev,
+				   "%s: Masked values are same; Invalid src=%pI4 and dst=%pI4 addresses\n",
+				   __func__, &tuple->ip4src, &tuple->ip4dst);
+			return -EINVAL;
+		}
+	}
+
+	if (flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_PORTS)) {
+		struct flow_match_ports match;
+
+		flow_rule_match_ports(rule, &match);
+
+		if (ip_proto == IPPROTO_UDP) {
+			if (match.mask->dst)
+				*features |= BIT_ULL(NPC_DPORT_UDP);
+
+			if (match.mask->src)
+				*features |= BIT_ULL(NPC_SPORT_UDP);
+		} else if (ip_proto == IPPROTO_TCP) {
+			if (match.mask->dst)
+				*features |= BIT_ULL(NPC_DPORT_TCP);
+
+			if (match.mask->src)
+				*features |= BIT_ULL(NPC_SPORT_TCP);
+		}
+
+		if (match.mask->src) {
+			tuple->sport = match.key->src;
+			tuple->m_sport = match.mask->src;
+		}
+
+		if (match.mask->dst) {
+			tuple->dport = match.key->dst;
+			tuple->m_dport = match.mask->dst;
+		}
+	}
+
+	if (!(*features & (BIT_ULL(NPC_DMAC) |
+			   BIT_ULL(NPC_SMAC) |
+			   BIT_ULL(NPC_DIP_IPV4) |
+			   BIT_ULL(NPC_SIP_IPV4) |
+			   BIT_ULL(NPC_DIP_IPV6) |
+			   BIT_ULL(NPC_SIP_IPV6) |
+			   BIT_ULL(NPC_DPORT_UDP) |
+			   BIT_ULL(NPC_SPORT_UDP) |
+			   BIT_ULL(NPC_DPORT_TCP) |
+			   BIT_ULL(NPC_SPORT_TCP)))) {
+		return -EINVAL;
+	}
+
+	tuple->features = *features;
+
+	return 0;
+}
+
+static int sw_fl_add(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	struct nf_flowtable *ct_ft = NULL;
+	struct fl_tuple tuple = { 0 };
+	struct flow_rule *rule;
+	u64 features = 0;
+	u64 op = 0;
+	int rc;
+
+	rule = flow_cls_offload_flow_rule(f);
+
+	rc = sw_fl_parse_actions(nic, &rule->action, f, &tuple, &op, &ct_ft);
+	if (rc)
+		return rc;
+
+	if (ct_ft) {
+		rc = sw_fl_ct_cookie_add(f->cookie, ct_ft, nic);
+		if (rc) {
+			sw_fl_ct_cb_put(ct_ft, nic);
+			return rc;
+		}
+	}
+
+	if (op == BIT_ULL(FLOW_ACTION_CT) && !tuple.mangle_cnt)
+		return 0;
+
+	rc  = sw_fl_parse_flow(nic, f, &tuple, &features);
+	if (rc) {
+		trace_sw_fl_dump(__func__, "flow key parse failed", &tuple);
+		if (ct_ft)
+			sw_fl_ct_cookie_put(f->cookie);
+		return -EFAULT;
+	}
+
+	/* Non-OVS ports resolve ingress and egress pcifunc via IPv4 FIB
+	 * lookups below. IPv6 and L2-only flows are not supported yet.
+	 */
+	if (!netif_is_ovs_port(nic->netdev)) {
+		rc = sw_fl_get_pcifunc(nic, tuple.ip4src, &tuple.in_pf,
+				       &tuple, true);
+		if (rc) {
+			trace_sw_fl_dump(__func__, "ingress pcifunc lookup failed", &tuple);
+			if (ct_ft)
+				sw_fl_ct_cookie_put(f->cookie);
+			return rc;
+		}
+
+		rc = sw_fl_get_pcifunc(nic, tuple.ip4dst,
+				       &tuple.xmit_pf, &tuple, false);
+		if (rc) {
+			trace_sw_fl_dump(__func__, "egress pcifunc lookup failed", &tuple);
+			if (ct_ft)
+				sw_fl_ct_cookie_put(f->cookie);
+			return rc;
+		}
+	}
+
+	trace_sw_fl_dump(__func__, "offload flow add queued", &tuple);
+	return sw_fl_add_to_list(nic, &tuple, f->cookie, true);
+}
+
+static int sw_fl_del(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	sw_fl_ct_cookie_put(f->cookie);
+	return sw_fl_add_to_list(nic, NULL, f->cookie, false);
+}
+
+static int sw_fl_stats(struct otx2_nic *nic, struct flow_cls_offload *f)
+{
+	struct fl_get_stats_req *req;
+	struct fl_get_stats_rsp *rsp;
+	u64 pkts_diff;
+	int rc = 0;
+
+	mutex_lock(&nic->mbox.lock);
+
+	req = otx2_mbox_alloc_msg_fl_get_stats(&nic->mbox);
+	if (!req) {
+		netdev_err(nic->netdev,
+			   "%s: Error happened while mcam alloc req\n",
+			   __func__);
+		rc = -ENOMEM;
+		goto fail;
+	}
+	req->cookie = f->cookie;
+
+	rc = otx2_sync_mbox_msg(&nic->mbox);
+	if (rc)
+		goto fail;
+
+	rsp = (struct fl_get_stats_rsp *)otx2_mbox_get_rsp
+		(&nic->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		rc = PTR_ERR(rsp);
+		goto fail;
+	}
+	pkts_diff = rsp->pkts_diff;
+	mutex_unlock(&nic->mbox.lock);
+
+	if (pkts_diff) {
+		flow_stats_update(&f->stats, 0x0, pkts_diff,
+				  0x0, jiffies,
+				  FLOW_ACTION_HW_STATS_IMMEDIATE);
+	}
+	return 0;
+fail:
+	mutex_unlock(&nic->mbox.lock);
+	return rc;
+}
+
+static bool init_done;
+
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv)
+{
+	struct flow_cls_offload *cls = type_data;
+	struct otx2_nic *nic = cb_priv;
+
+	if (!smp_load_acquire(&init_done)) /* published in sw_fl_init() */
+		return 0;
+
+	switch (cls->command) {
+	case FLOW_CLS_REPLACE:
+		return sw_fl_add(nic, cls);
+	case FLOW_CLS_DESTROY:
+		return sw_fl_del(nic, cls);
+	case FLOW_CLS_STATS:
+		return sw_fl_stats(nic, cls);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 int sw_fl_init(void)
 {
+	sw_fl_wq = alloc_workqueue("sw_fl_wq", 0, 0);
+	if (!sw_fl_wq)
+		return -ENOMEM;
+
+	smp_store_release(&init_done, true); /* visible to sw_fl_setup_ft_block_ingress_cb() */
 	return 0;
 }
 
 void sw_fl_deinit(void)
 {
+	struct sw_fl_list_entry *entry;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	smp_store_release(&init_done, false); /* visible to sw_fl_setup_ft_block_ingress_cb() */
+
+	spin_lock_bh(&sw_fl_lock);
+	wq = sw_fl_wq;
+	sw_fl_wq = NULL;
+	spin_unlock_bh(&sw_fl_lock);
+
+	if (!wq)
+		return;
+
+	cancel_delayed_work_sync(&sw_fl_work);
+	destroy_workqueue(wq);
+
+	spin_lock_bh(&sw_fl_lock);
+	list_splice_init(&sw_fl_lh, &tlist);
+	spin_unlock_bh(&sw_fl_lock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fl_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		netdev_put(entry->pf->netdev, &entry->dev_tracker);
+		kfree(entry);
+	}
+
+	sw_fl_ct_cb_flush();
 }
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
index cd018d770a8a..8dd816eb17d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -9,5 +9,7 @@
 
 void sw_fl_deinit(void);
 int sw_fl_init(void);
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv);
 
 #endif // SW_FL_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
new file mode 100644
index 000000000000..672f3405de85
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#define CREATE_TRACE_POINTS
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+#include "sw_trace.h"
+#endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
new file mode 100644
index 000000000000..f4e2832939e4
--- /dev/null
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Marvell RVU Admin Function driver
+ *
+ * Copyright (C) 2026 Marvell.
+ *
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rvu_sw
+
+#if !defined(SW_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define SW_TRACE_H
+
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+#include <linux/byteorder/generic.h>
+
+#include "mbox.h"
+
+TRACE_EVENT(sw_fl_dump,
+	    TP_PROTO(const char *fname, const char *info, struct fl_tuple *ftuple),
+	    TP_ARGS(fname, info, ftuple),
+	    TP_STRUCT__entry(__string(f, fname)
+			     __string(info, info)
+			     __array(u8, smac, ETH_ALEN)
+			     __array(u8, dmac, ETH_ALEN)
+			     __field_struct(__be16, eth_type)
+			     __field_struct(__be32, sip)
+			     __field_struct(__be32, dip)
+			     __field(u8, ip_proto)
+			     __field_struct(__be16, sport)
+			     __field_struct(__be16, dport)
+			     __field(u8, uni_di)
+			     __field(u16, in_pf)
+			     __field(u16, out_pf)
+	    ),
+	    TP_fast_assign(__assign_str(f);
+			   __assign_str(info);
+			   memcpy(__entry->smac, ftuple->smac, ETH_ALEN);
+			   memcpy(__entry->dmac, ftuple->dmac, ETH_ALEN);
+			   __entry->sip = ftuple->ip4src;
+			   __entry->dip = ftuple->ip4dst;
+			   __entry->eth_type = ftuple->eth_type;
+			   __entry->ip_proto = ftuple->proto;
+			   __entry->sport = ftuple->sport;
+			   __entry->dport = ftuple->dport;
+			   __entry->uni_di = ftuple->uni_di;
+			   __entry->in_pf = ftuple->in_pf;
+			   __entry->out_pf = ftuple->xmit_pf;
+	    ),
+	    TP_printk("[%s] %s: %pM %pI4:%u to %pM %pI4:%u eth_type=%#x proto=%u uni=%u in=%#x out=%#x",
+		      __get_str(f), __get_str(info),
+		      __entry->smac, &__entry->sip, __entry->sport,
+		      __entry->dmac, &__entry->dip, __entry->dport,
+		      __entry->eth_type, __entry->ip_proto, __entry->uni_di,
+		      __entry->in_pf, __entry->out_pf)
+);
+
+TRACE_EVENT(sw_act_dump,
+	    TP_PROTO(const char *fname, const char *info, u32 act),
+	    TP_ARGS(fname, info, act),
+	    TP_STRUCT__entry(__string(fname, fname)
+			     __string(info, info)
+			     __field(u32, act)
+	    ),
+
+	    TP_fast_assign(__assign_str(fname);
+			   __assign_str(info);
+			   __entry->act = act;
+	    ),
+
+	    TP_printk("[%s] %s: act=%u",
+		      __get_str(fname), __get_str(info), __entry->act)
+);
+
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE sw_trace
+
+#include <trace/define_trace.h>
-- 
2.43.0

