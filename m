Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CC355F5F;
	Tue, 11 Aug 2026 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438519; cv=none; b=cPMiBl9qA5JAaj2yy++3U5P0nn/nbpBX7KgSWkS+0W7tIMoUxd73D4jvWNq7+KcstqfNZaqmTLX8XpDYBCMI/AE0YT5EBs+3IB9L4VreBnIjawrUo+IQzlFzAI9qJdWGAY5c0T0JeEHFKcB0RswB2MyICwFQDCL4IJb9ecX0rOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438519; c=relaxed/simple;
	bh=E7YfrmcRV5YxwC3Rwvqt3XZpMf+icbX9xj6GP3j2OUI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RM7SWhyRuBXZeMF88PO/3ch/TqLBpx0E7us0ACSNLB3Sy8CRascaV6pFkzWaVpAUmerLEh0YcHMhLbyKPhJdQn3k/nAlx8La3ViZ8Xcq/LFq/qV4g5y3xpCb5IpkGnUKiMX4r29Nd0Jo+Ji0LIavFMG2pHz+pd4qxh8wTEs9/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RSyYkyZZ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="RSyYkyZZ"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AMqLm01810466;
	Tue, 11 Aug 2026 01:55:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Y
	rz4Hft3YeEQqB6zcWFmZfIOw3hKpOLshmwf/zS6Rjs=; b=RSyYkyZZ+hr9rpO2s
	uNl6E7387GobPTO96/f8LNCCIVd/x9Al/SKldsmu43W8HlXvs7X9/6DRHwyI0EyH
	4C2PU5onkD7e2DowRnRw22MDsCEY9icPrs+oQZXilTUvxdsVLHAV2H/8Rh+0GZ5w
	VpPPw9xqHvyXkYXXKO6DIK3Mi+E7vX3u559LTM+pix2KZ3C8g52W3uP9C53UAZ+E
	Qr6fuOux+8BVieQUSskz5Mz4xOJA5ut/nUMGDev1hvlhb/pKq87ZSek62RQBQxD4
	G2QE2kpkGP8IdCSyflDgemKybqOwMU/4LdDtsuU+SmbwnTPDk+FSXmH+cFueav0o
	2FyCw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fx1tmg9xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 01:54:59 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 11 Aug 2026 01:54:58 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 11 Aug 2026 01:54:58 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3168E3F706C;
	Tue, 11 Aug 2026 01:54:54 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v8 net-next 9/9] octeontx2: switch: add TC flow offload path for switch flows
Date: Tue, 11 Aug 2026 14:24:06 +0530
Message-ID: <20260811085406.3227312-10-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811085406.3227312-1-rkannoth@marvell.com>
References: <20260811085406.3227312-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfX+9nroX8ThZdg
 lzBFhKHsqJDpKMhGTWyJHLDddwnPFqQ6Ciq3co8v/ZLfz+k5DKyeHf2AaFiGMmGL89ReiRX+Y7f
 z2i7jlZvVZQ4fRtPuGpKgMzfY7rw3OI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDA3MyBTYWx0ZWRfX8W3bCg8oXonb
 N7eEEPhPQ6PtG9NOkcO+1/8CxGkAPS0p8YgbBgkl/j/J5S/is+KHYjntN4x6XEZyCOGjB1KPDv+
 +5JpQeYsQSpPgfcc8MQ7iVlpNvOyLbdVktnBeWRGpvjMnflrMfGCfrNMnDqLokvS1WjbJgoBVZw
 Ys+RJ0POqG7o/xyluIL+hVrlA3RaugiFmiv6eS0wwURus/79ztyYGpo4G/eC7m9t1FD1KPrxLXZ
 ONjUuxNPBMxs5OvI5qUz3oRBFBoCrIy9MShkpK/TxF+zvBKwYR6hisz25zBGNN0+ZmUm4z+ZU/3
 0M9TV3RwbAG55uOo80XAHImEyoE60PaqsOzBIPMeMhrD1SWll8y0FacHO2MuKL1mf48OL8DNqgK
 OPl2OXCRxec2q0AePGaN8V642/+s57w+4KMZKSyXu9OV5J3TyMLqoinEAYJH/NW3OfoUXEz1HUV
 zO+QjHcrrPcZbQF7znQ==
X-Proofpoint-GUID: NaY4e7vqvMkGzuxw3IEeqReURbprLD4e
X-Proofpoint-ORIG-GUID: NaY4e7vqvMkGzuxw3IEeqReURbprLD4e
X-Authority-Analysis: v=2.4 cv=dPWWXuZb c=1 sm=1 tr=0 ts=6a7ae363 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=J17BKo0H7dPtVmajIpoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01

Register an ingress flow-table offload callback that translates TC
flower rules into fl_tuple state, resolves ingress and egress
pcifunc via FIB for accelerated ports, and notifies the RVU AF over
the PF mailbox.  The AF forwards flow updates to switchdev and
keeps per-cookie packet counters in sync using NPC MCAM multi-stats
when the switch requests SWDEV2AF refresh.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |    9 +-
 .../marvell/octeontx2/af/switch/rvu_sw_fl.c   |  370 ++++++
 .../marvell/octeontx2/af/switch/rvu_sw_fl.h   |    2 +
 .../ethernet/marvell/octeontx2/nic/Makefile   |    4 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |    2 +-
 .../ethernet/marvell/octeontx2/nic/otx2_tc.c  |   51 +
 .../marvell/octeontx2/nic/switch/sw_fl.c      | 1012 ++++++++++++++++-
 .../marvell/octeontx2/nic/switch/sw_fl.h      |    6 +
 .../marvell/octeontx2/nic/switch/sw_trace.c   |   11 +
 .../marvell/octeontx2/nic/switch/sw_trace.h   |   84 ++
 10 files changed, 1547 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.c
 create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_trace.h

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 588169fc2bc8..bd09775677a6 100644
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
 
 /*
  * rep_cnt and rep2pfvf_map are populated once when the representor driver
@@ -79,6 +79,12 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
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
@@ -91,6 +97,7 @@ void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
 	rvu_sw_l3_shutdown();
+	rvu_sw_fl_shutdown();
 }
 
 void rvu_sw_clear_shutdown(void)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
index 1f8b82a84a5d..d55545244826 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_fl.c
@@ -4,12 +4,316 @@
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
+static bool going_down;
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
+static void rvu_sw_fl_drain_list(struct list_head *lh)
+{
+	struct fl_entry *entry;
+
+	while ((entry = list_first_entry_or_null(lh, struct fl_entry, list))) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static void rvu_sw_fl_queue_work_locked(void)
+{
+	lockdep_assert_held(&fl_offl_llock);
+
+	if (sw_fl_offl_wq && !going_down)
+		queue_delayed_work(sw_fl_offl_wq, &fl_offl_work,
+				   msecs_to_jiffies(10));
+}
+
+static int rvu_sw_fl_ensure_wq(void)
+{
+	lockdep_assert_held(&fl_offl_llock);
+
+	if (going_down)
+		return -ENODEV;
+
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
+	req->port_id = fl_entry->port_id;
+
+	if (!otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf)) {
+		otx2_mbox_reset(&rvu->afpf_wq_info.mbox_up, swdev_pf);
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
+	if (going_down) {
+		rvu_sw_fl_drain_list(&fl_offl_lh);
+		mutex_unlock(&fl_offl_llock);
+		return;
+	}
+
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
+		if (!going_down && sw_fl_offl_wq) {
+			/*
+			 * TODO: Requeue at the tail (or stall the worker) on transient
+			 * offload failure to avoid head-of-line blocking. Prepending with
+			 * list_add() retries the same entry first and can starve later
+			 * flow updates when mailbox push keeps failing.
+			 *
+			 * TODO: Cap retries and drop the entry after a limit. There is no
+			 * retry counter today, so a persistent push failure requeues the
+			 * same fl_entry indefinitely and the worker never reaches later
+			 * queued flow updates.
+			 */
+			list_add(&fl_entry->list, &fl_offl_lh);
+			mutex_unlock(&fl_offl_llock);
+			queue_delayed_work(sw_fl_offl_wq, &fl_offl_work,
+					   msecs_to_jiffies(100));
+		} else {
+			mutex_unlock(&fl_offl_llock);
+			kfree(fl_entry);
+		}
+		return;
+	}
+
+	kfree(fl_entry);
+
+	mutex_lock(&fl_offl_llock);
+	if (!going_down && !list_empty(&fl_offl_lh))
+		rvu_sw_fl_queue_work_locked();
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
 
@@ -17,5 +321,71 @@ int rvu_mbox_handler_fl_notify(struct rvu *rvu,
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
+	if (going_down) {
+		mutex_unlock(&fl_offl_llock);
+		kfree(fl_entry);
+		return -ENODEV;
+	}
+
+	rc = rvu_sw_fl_ensure_wq();
+	if (rc) {
+		mutex_unlock(&fl_offl_llock);
+		kfree(fl_entry);
+		return rc;
+	}
+
+	list_add_tail(&fl_entry->list, &fl_offl_lh);
+	rvu_sw_fl_queue_work_locked();
+	mutex_unlock(&fl_offl_llock);
+
 	return 0;
 }
+
+void rvu_sw_fl_shutdown(void)
+{
+	struct sw_fl_stats_node *snode, *tmp;
+	struct workqueue_struct *wq;
+
+	mutex_lock(&sw_fl_stats_lock);
+	list_for_each_entry_safe(snode, tmp, &sw_fl_stats_lh, list) {
+		list_del_init(&snode->list);
+		kfree(snode);
+	}
+	mutex_unlock(&sw_fl_stats_lock);
+
+	mutex_lock(&fl_offl_llock);
+	going_down = true;
+	wq = sw_fl_offl_wq;
+	sw_fl_offl_wq = NULL;
+	mutex_unlock(&fl_offl_llock);
+
+	if (!wq)
+		goto drain;
+
+	cancel_delayed_work_sync(&fl_offl_work);
+	destroy_workqueue(wq);
+
+drain:
+	mutex_lock(&fl_offl_llock);
+	rvu_sw_fl_drain_list(&fl_offl_lh);
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
index 6050228be067..8e051d969296 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/Makefile
@@ -11,7 +11,8 @@ rvu_nicpf-y := otx2_pf.o otx2_common.o otx2_txrx.o otx2_ethtool.o \
                otx2_flows.o otx2_tc.o cn10k.o cn20k.o otx2_dmac_flt.o \
                otx2_devlink.o qos_sq.o qos.o otx2_xsk.o switch/sw_fdb.o \
 	       switch/sw_fl.o
-rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_nb.o switch/sw_fib.o \
+rvu_nicpf-$(CONFIG_OCTEONTX_SWITCH) += switch/sw_trace.o switch/sw_nb.o \
+				       switch/sw_fib.o \
 				       switch/sw_nb_v4.o
 # sw_nb_v6.o calls IPv6 symbols exported by the ipv6 module; only link it
 # when those symbols are reachable (IPv6 built-in, or both driver and IPv6
@@ -32,3 +33,4 @@ rvu_nicpf-$(CONFIG_MACSEC) += cn10k_macsec.o
 rvu_nicpf-$(CONFIG_XFRM_OFFLOAD) += cn10k_ipsec.o
 
 ccflags-y += -I$(srctree)/drivers/net/ethernet/marvell/octeontx2/af
+ccflags-y += -I$(src)/switch/
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 6ee19aca194c..403ae4717ba6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -679,7 +679,7 @@ static void otx2_pfvf_mbox_destroy(struct otx2_nic *pf)
 	}
 
 	if (mbox->mbox.hwbase && !is_cn20k(pf->pdev))
-		iounmap(mbox->mbox.hwbase);
+		iounmap((void __iomem *)mbox->mbox.hwbase);
 	else
 		qmem_free(&pf->pdev->dev, pf->pfvf_mbox_addr);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
index 039fd47ebf52..63bf40fd00f3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_tc.c
@@ -21,6 +21,12 @@
 #include "otx2_common.h"
 #include "qos.h"
 
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+#include "switch/sw_fl.h"
+#include "switch/sw_nb.h"
+#endif
+#include "sw_fl.h"
+
 #define CN10K_MAX_BURST_MANTISSA	0x7FFFULL
 #define CN10K_MAX_BURST_SIZE		8453888ULL
 
@@ -1600,14 +1606,59 @@ static int otx2_setup_tc_block(struct net_device *netdev,
 					  nic, nic, ingress);
 }
 
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+static int otx2_setup_tc_block_switch(struct net_device *netdev,
+				      struct flow_block_offload *f)
+{
+	struct otx2_nic *nic = netdev_priv(netdev);
+
+	if (f->block_shared)
+		return -EOPNOTSUPP;
+
+	/* OVS ports only support switch ingress flow offload (clsact ingress).
+	 * Standard host egress TC block setup via otx2_setup_tc_block() is not
+	 * supported on OVS ports; non-ingress binders are rejected here rather
+	 * than falling back to the PF NPC path.
+	 */
+	if (f->binder_type != FLOW_BLOCK_BINDER_TYPE_CLSACT_INGRESS)
+		return -EOPNOTSUPP;
+
+	return flow_block_cb_setup_simple(f, &otx2_block_cb_list,
+					  sw_fl_setup_ft_block_ingress_cb,
+					  nic, nic, true);
+}
+#endif
+
 int otx2_setup_tc(struct net_device *netdev, enum tc_setup_type type,
 		  void *type_data)
 {
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	struct otx2_nic *nic = netdev_priv(netdev);
+#endif
+
 	switch (type) {
 	case TC_SETUP_BLOCK:
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+		/* OVS ports offload ingress switch flows only. Do not fall back to
+		 * otx2_setup_tc_block() for these netdevs: egress TC block setup
+		 * is not supported on OVS ports.
+		 */
+		if (netif_is_ovs_port(netdev) && sw_nb_is_valid_dev(netdev))
+			return otx2_setup_tc_block_switch(netdev, type_data);
+#endif
 		return otx2_setup_tc_block(netdev, type_data);
+
 	case TC_SETUP_QDISC_HTB:
 		return otx2_setup_tc_htb(netdev, type_data);
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+	case TC_SETUP_FT:
+		if (!sw_nb_is_valid_dev(netdev))
+			return -EOPNOTSUPP;
+		return flow_block_cb_setup_simple(type_data,
+						  &otx2_block_cb_list,
+						  sw_fl_setup_ft_block_ingress_cb,
+						  nic, nic, true);
+#endif
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
index f2811d69f815..b802089776b9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.c
@@ -4,15 +4,1025 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+#include <linux/mutex.h>
+#include <linux/refcount.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/nexthop.h>
+#include <net/netfilter/nf_flow_table.h>
+#include <net/tc_act/tc_ct.h>
+#include <net/flow_dissector.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+#include "sw_trace.h"
 #include "sw_fl.h"
 
-#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
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
+#define SW_FL_NOTIFY_RETRY_MAX 100
+
+struct sw_fl_list_entry {
+	struct list_head list;
+	u64 flags;
+	unsigned long cookie;
+	struct otx2_nic *pf;
+	netdevice_tracker dev_tracker;
+	int retries;
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
+			struct net_device *dev = entry->pf->netdev;
+
+			entry->retries++;
+			spin_lock_bh(&sw_fl_lock);
+			if (sw_fl_wq && entry->retries < SW_FL_NOTIFY_RETRY_MAX) {
+				netdev_err(dev,
+					   "Failed to notify flow update to AF, will retry (%d/%d)\n",
+					   entry->retries, SW_FL_NOTIFY_RETRY_MAX);
+				/* TODO(follow-up): Known issue - requeueing at the tail can
+				 * reorder updates for the same flow cookie: a later delete may
+				 * run before this retried add, leaving a ghost flow in hardware.
+				 * Per-cookie chronological ordering on retry will be fixed in a
+				 * later patch.
+				 */
+				list_add_tail(&entry->list, &sw_fl_lh);
+				queue_delayed_work(sw_fl_wq, &sw_fl_work,
+						   msecs_to_jiffies(100));
+				spin_unlock_bh(&sw_fl_lock);
+				continue;
+			}
+			spin_unlock_bh(&sw_fl_lock);
+			netdev_err(dev,
+				   "Failed to notify flow update to AF, giving up after %d tries\n",
+				   entry->retries);
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
+	entry->flags = add_fl ? OTX2_FL_ADD : OTX2_FL_DEL;
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
+#define SW_FL_CT_ACTION_MAX 8
+
+static_assert(MANGLE_ARR_SZ <= 16,
+	      "mangle_map is a u16 bitmap per layer");
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
+	struct nf_flowtable *parsed_ct_ft[SW_FL_CT_ACTION_MAX];
+	struct otx2_nic *out_nic;
+	int parsed_ct_cnt = 0;
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
+			/*
+			 * TODO: Support redirect to stacked netdevs (VLAN, bridge
+			 * master, bridge port). Only native Cavium PF/representor
+			 * netdevs are supported today.
+			 */
+			if (netif_is_bridge_master(act->dev) ||
+			    is_vlan_dev(act->dev) ||
+			    netif_is_bridge_port(act->dev)) {
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
+
+			if (act->ct.action & TCA_CT_ACT_CLEAR || !act->ct.flow_table) {
+				err = -EOPNOTSUPP;
+				goto unwind_ct;
+			}
+			if (parsed_ct_cnt) {
+				err = -EOPNOTSUPP;
+				goto unwind_ct;
+			}
+			err = sw_fl_ct_cb_get(act->ct.flow_table, nic);
+			if (err) {
+				netdev_err(nic->netdev,
+					   "%s: Error to offload flow, err=%d\n",
+					   __func__, err);
+				goto unwind_ct;
+			}
+
+			parsed_ct_ft[parsed_ct_cnt++] = act->ct.flow_table;
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
+			err = -EOPNOTSUPP;
+			goto unwind_ct;
+		}
+	}
+
+	tuple->mangle_cnt = used;
+
+	if (!*op && !used) {
+		netdev_dbg(nic->netdev, "%s: Op is not valid\n", __func__);
+		err = -EOPNOTSUPP;
+		goto unwind_ct;
+	}
+
+	return 0;
+
+unwind_ct:
+	while (parsed_ct_cnt--)
+		sw_fl_ct_cb_put(parsed_ct_ft[parsed_ct_cnt], nic);
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
+		/* TODO(follow-up): L3-only - when the FIB nexthop is a bridge we
+		 * use the first bridge port. L2 flow offload is not supported
+		 * yet; per-port egress resolution via FDB/neighbor lookup will
+		 * be added in a later patch.
+		 */
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
+	struct flow_dissector *dissector;
+	struct flow_rule *rule;
+	u8 ip_proto = 0;
+
+	*features = 0;
+
+	rule = flow_cls_offload_flow_rule(f);
+	dissector = rule->match.dissector;
+
+	if (dissector->used_keys &
+	    ~(BIT_ULL(FLOW_DISSECTOR_KEY_BASIC) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
+	      BIT_ULL(FLOW_DISSECTOR_KEY_PORTS))) {
+		netdev_dbg(nic->netdev,
+			   "%s: unsupported flow match keys 0x%llx\n",
+			   __func__, dissector->used_keys);
+		return -EOPNOTSUPP;
+	}
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
+		if (!is_zero_ether_addr(match.key->dst) &&
+		    !is_unicast_ether_addr(match.key->dst))
+			return -EOPNOTSUPP;
+
+		if (!is_zero_ether_addr(match.key->src) &&
+		    !is_unicast_ether_addr(match.key->src))
+			return -EOPNOTSUPP;
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
+static bool sw_fl_flow_has_redirect(struct flow_cls_offload *f)
+{
+	struct flow_rule *rule = flow_cls_offload_flow_rule(f);
+	struct flow_action_entry *act;
+	int i;
+
+	flow_action_for_each(i, act, &rule->action) {
+		if (act->id == FLOW_ACTION_REDIRECT)
+			return true;
+	}
+
+	return false;
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
+	 * lookups below. IPv6 flow matching is not supported yet.
+	 *
+	 * TODO(follow-up): L2-only flow rules have no IPv4 match keys, so
+	 * tuple.ip4src/ip4dst stay 0.0.0.0 and the FIB lookups below can
+	 * bind to the default route instead of the offloading port. L2 flow
+	 * pcifunc resolution will be added in a later patch.
+	 */
+	if (!netif_is_ovs_port(nic->netdev) &&
+	    !(op & BIT_ULL(FLOW_ACTION_REDIRECT))) {
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
+	rc = sw_fl_add_to_list(nic, &tuple, f->cookie, true);
+	if (rc && ct_ft)
+		sw_fl_ct_cookie_put(f->cookie);
+	return rc;
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
+	if (type != TC_SETUP_CLSFLOWER)
+		return -EOPNOTSUPP;
+
+	if (cls->common.chain_index)
+		return -EOPNOTSUPP;
+
+	if (!smp_load_acquire(&init_done)) /* published in sw_fl_init() */
+		return -EOPNOTSUPP;
+
+	switch (cls->command) {
+	case FLOW_CLS_REPLACE:
+		/* OVS port offload requires REDIRECT to populate in_pf/xmit_pf.
+		 * Without it tuple.in_pf stays zero and hardware would scope the
+		 * rule to PF0.
+		 */
+		if (netif_is_ovs_port(nic->netdev) &&
+		    !sw_fl_flow_has_redirect(cls))
+			return -EOPNOTSUPP;
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
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
index 7648df59e215..c34d876a0ef5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fl.h
@@ -9,12 +9,18 @@
 
 #include <linux/kconfig.h>
 
+int sw_fl_setup_ft_block_ingress_cb(enum tc_setup_type type,
+				    void *type_data, void *cb_priv);
+
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+#include <net/pkt_cls.h>
+
 void sw_fl_deinit(void);
 int sw_fl_init(void);
 #else
 static inline void sw_fl_deinit(void) {}
 static inline int sw_fl_init(void) { return 0; }
+
 #endif
 
 #endif /* SW_FL_H_ */
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
index 000000000000..b42dc893886f
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
+		      ntohs(__entry->eth_type), __entry->ip_proto, __entry->uni_di,
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

