Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752F34137A2;
	Mon, 31 Aug 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182435; cv=none; b=i38VTBCDNuyqI8aEAn2JICEexnv+EtkKcWugjiAMiil3SKu2Jblly3vFBvuqpOeI56F3COz+ywdb9tzeuAds6knT8qG4AqGyzWFozOpYQRMFlYT+6R8Kg8s16ihYJwZlhI9EaiSLAy5uNxx9KSF4HkzBnrycWef+elcuGPj6Sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182435; c=relaxed/simple;
	bh=U9fob+0AcBakT+kzdLlbxJwh8ZncMZN2DP7kvHyMa1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HzVREWJ0usCqGjDjjgAR0NTUJgwQtziFb4qbgNQGxCPFRIfTASVc9ZBYnfAoMROS8TbaiAPrMbRu1W58DXnCD+kwPbRHw/LWFu1sAEDkndR1aDMXCk6qDbgByM0PNjsWzOeYB6yYXRpiimml898DNgp7RsLe/Yl0ujSGFdjb+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MKL+p47P; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MKL+p47P"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBCJdo668834;
	Mon, 31 Aug 2026 06:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=X
	n3AtDdfAthXBdjOI88bs8WZKEo0Br8Lt4WG9UpBztw=; b=MKL+p47PzW1hVDfPg
	AJBjZxxu9wCbJm44Gq55v+Mn+GKDaclxqbzYRRsyC/3nQZlmu+ksYKsqQJ9QNNuZ
	DEELwDCCwno7/NUpL78+2LxSVa2QXbiMRfm4o/Q4BfcFQIstnZhvhGj2tkL61rGw
	ZROI3JlNPQuUYRZKIBX/kuKGNbETj7bThLwy1U2rGUQCx9gZm7AOWt0V35jk6t5A
	7vajwQNtZe0JSvNFi1TUg+lJjhIQoxevumm/UMcOXpp4O9w2MW6IjSUVbAD+yaMr
	LcQtJNDMbMhTsOazebOY3Rx4Mwutq9anjMv5zH7NltPLKmovoF2QmtLzRfnbAz7G
	5KncA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gcg68jmry-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:20:22 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:20:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:20:21 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 960B13F7090;
	Mon, 31 Aug 2026 06:20:18 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v9 net-next 8/8] octeontx2: switch: offload host FIB updates to switch via AF mailbox
Date: Mon, 31 Aug 2026 18:49:44 +0530
Message-ID: <20260831131944.2649362-9-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: Ca8KN7rdZbU4oBgP91QEKgOU8Eu6iTfJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX4wSbYYq/aG/m
 MWn/7hHgTlSSV1+GwgP3nAAUd0TbUw5BuRAf7kO0IAL5XM/srNgS55H95WgR1j/HnsAK4lBgukq
 QavB0098hUGnVhFzuWHqRtwgrFVQRTRsdDGfSHTQSe0rxF72QkTl46QYob3xErquqqeLD7miR5j
 XEfH9tHHsu6Nua9JWmQpTyVnin1pU1NC9eC17PKpdyqYq/9CJljibqG8iTCqDsiQ8ArRlkmH5cn
 MjRL/UzID6pkHk6COEIaisKSXnAguVxDadEYdURHEXBWM2mHxpp/bOCS2In7Obq/Mzc0QChUmjI
 ypoJDEWpKnFQR73zkMNAtSPyaN26W84uCQqD7ijx+coe7LeM2H6gblpdfmdJBiADxZuHayi/jT9
 GxQbH3qgr3DuFk9nl0T2Dfa80JZlDodCRn4ycFgPxES/FAkq1u6g51OZj1e/ubVmAQPnHjEwyzb
 7/5V3CxJFMCsELFge8w==
X-Authority-Analysis: v=2.4 cv=fZedDUQF c=1 sm=1 tr=0 ts=6a957f96 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=na5_BN2stuqMQk1fQYAA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ca8KN7rdZbU4oBgP91QEKgOU8Eu6iTfJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfXxMWb4ebc7rEQ
 3h7Rjo1sCk2lbZJIXclyEs29H6fkp3ebqd1fcHjr+yafvkkLunDw2/5AWArk3dbK4MvW+AJZ8Qz
 jQOtYo9NiYwECPRd7zBuKnZwcwiz3RA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

Queue IPv4/IPv6 FIB-derived updates from the switch notifier path
and handle fib_notify in the RVU AF by batching fib_entry
structures and sending them to the switch PF through the
AF-to-switchdev FIB_CMD. Require the switch firmware to
be ready before accepting offload work.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   8 +-
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   4 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 292 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |   2 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 242 +++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |  14 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |   8 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 192 +++++++-----
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   |  21 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  31 +-
 10 files changed, 720 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 8f7b2962a212..d63dd57999ae 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1915,18 +1915,20 @@ struct fib_entry {
 		__be32 gw;
 		__be32 gw6[4];
 	};
-	u16 port_id;
+	u32 port_id;
 	u8 nud_state;
 	u8 rsvd3;
 	u8 mac[ETH_ALEN];
 	u16 rsvd4; /* explicit tail padding */
 };
 
+#define RVU_SW_L3_ENTRY_MAX 12
+
 struct fib_notify_req {
 	struct  mbox_msghdr hdr;
 	u16 cnt;
 	u16 rsvd[3]; /* explicit padding for entry[] 8-byte alignment */
-	struct fib_entry entry[16];
+	struct fib_entry entry[RVU_SW_L3_ENTRY_MAX];
 };
 
 struct fl_tuple {
@@ -2000,7 +2002,7 @@ struct af2swdev_notify_req {
 		struct {
 			u8 cnt;
 			u8 rsvd[7]; /* explicit padding before fib_entry[] */
-			struct fib_entry entry[12];
+			struct fib_entry entry[RVU_SW_L3_ENTRY_MAX];
 		};
 
 		struct {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 71f113bded5e..12f77ffc3eb7 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -6,10 +6,10 @@
  */
 
 #include <linux/bitfield.h>
-
 #include "rvu.h"
 #include "rvu_sw.h"
 #include "rvu_sw_l2.h"
+#include "rvu_sw_l3.h"
 #include "rvu_sw_fl.h"
 
 /*
@@ -90,9 +90,11 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
+	rvu_sw_l3_shutdown();
 }
 
 void rvu_sw_clear_shutdown(void)
 {
 	rvu_sw_l2_clear_shutdown();
+	rvu_sw_l3_clear_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
index 2b798d5f0644..32735ae68e1d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,303 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_l3.h"
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
+struct l3_entry {
+	struct list_head list;
+	/* Always this AF driver's rvu; stored for clarity only (single RVU). */
+	struct rvu *rvu;
+	u32 port_id;
+	int cnt;
+	struct fib_entry entry[];
+};
+
+static DEFINE_MUTEX(l3_offl_llock);
+static LIST_HEAD(l3_offl_lh);
+static bool going_down;
+
+static struct workqueue_struct *sw_l3_offl_wq;
+static void sw_l3_offl_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(l3_offl_work, sw_l3_offl_work_handler);
+
+/*
+ * FIB offload to the switch ASIC: one octeontx2 AF driver instance, one
+ * switch PF (switchdev), and one sw_l3_offl_wq per SoC.
+ */
+
+static void rvu_sw_l3_drain_list(struct list_head *lh)
+{
+	struct l3_entry *entry;
+
+	while ((entry = list_first_entry_or_null(lh, struct l3_entry, list))) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
+static void rvu_sw_l3_queue_work_delay_locked(unsigned long delay_jiffies)
+{
+	lockdep_assert_held(&l3_offl_llock);
+
+	if (sw_l3_offl_wq && !going_down)
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work, delay_jiffies);
+}
+
+static void rvu_sw_l3_queue_work_delay(unsigned long delay_jiffies)
+{
+	mutex_lock(&l3_offl_llock);
+	rvu_sw_l3_queue_work_delay_locked(delay_jiffies);
+	mutex_unlock(&l3_offl_llock);
+}
+
+static void rvu_sw_l3_queue_work_locked(void)
+{
+	rvu_sw_l3_queue_work_delay_locked(msecs_to_jiffies(10));
+}
+
+static void rvu_sw_l3_queue_work(void)
+{
+	rvu_sw_l3_queue_work_delay(msecs_to_jiffies(10));
+}
+
+static int rvu_sw_l3_ensure_wq(void)
+{
+	lockdep_assert_held(&l3_offl_llock);
+
+	if (going_down)
+		return -ENODEV;
+
+	if (sw_l3_offl_wq)
+		return 0;
+
+	sw_l3_offl_wq = alloc_workqueue("sw_af_fib_wq", 0, 0);
+	if (!sw_l3_offl_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int rvu_sw_l3_offl_rule_push(struct list_head *lh)
+{
+	struct af2swdev_notify_req *req;
+	struct fib_entry *entry, *dst;
+	struct l3_entry *l3_entry;
+	struct rvu *rvu;
+	int tot_cnt = 0;
+	int swdev_pf;
+	int sz, cnt, i;
+	bool rc;
+
+	BUILD_BUG_ON(sizeof_field(struct af2swdev_notify_req, entry) !=
+		     sizeof(struct fib_entry) * RVU_SW_L3_ENTRY_MAX);
+	BUILD_BUG_ON(sizeof_field(struct fib_notify_req, entry) !=
+		     sizeof(struct fib_entry) * RVU_SW_L3_ENTRY_MAX);
+
+	l3_entry = list_first_entry_or_null(lh, struct l3_entry, list);
+	if (!l3_entry)
+		return 0;
+
+	/*
+	 * Octeontx2 has a single AF (one struct rvu) per RVU chip. All queued
+	 * entries therefore share the same rvu and the same switch PF below.
+	 * Host PF identity is carried per fib_entry (port_id), not by picking
+	 * a different switch PF here.
+	 */
+	rvu = l3_entry->rvu;
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	dst = &req->entry[0];
+	/*
+	 * Batch fib_entry records from multiple host PF notifies into one
+	 * af2swdev message. Safe on octeontx2: every l3_entry targets the
+	 * same switch PF; egress port is encoded in each fib_entry.port_id.
+	 *
+	 * Entries are removed from lh and freed once copied into the mbox
+	 * buffer, before the send attempt. If otx2_mbox_wait_for_zero() or
+	 * the upstream send fails, that batch is lost with no replay path and
+	 * the switch FIB may diverge from the host; tolerating that is a
+	 * known limitation for now.
+	 */
+	while ((l3_entry =
+		list_first_entry_or_null(lh,
+					 struct l3_entry, list)) != NULL) {
+		entry = l3_entry->entry;
+		cnt = l3_entry->cnt;
+
+		/* af2swdev_notify_req.entry[] holds RVU_SW_L3_ENTRY_MAX slots;
+		 * stop before copying the next l3_entry when the mbox buffer
+		 * would overflow. Leftovers stay on lh and are re-queued.
+		 */
+		if (tot_cnt + cnt > RVU_SW_L3_ENTRY_MAX)
+			break;
+
+		sz = sizeof(*entry) * cnt;
+
+		memcpy(dst, entry, sz);
+		for (i = 0; i < cnt; i++)
+			dst[i].port_id = l3_entry->port_id;
+		tot_cnt += cnt;
+		dst += cnt;
+
+		list_del_init(&l3_entry->list);
+		kfree(l3_entry);
+	}
+	if (!tot_cnt) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -EINVAL;
+	}
+
+	req->flags = OTX2_FIB_CMD;
+	req->cnt = tot_cnt;
+
+	rc = otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	if (rc)
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return rc ? 0 : -EFAULT;
+}
+
+static void sw_l3_offl_work_handler(struct work_struct *work)
+{
+	struct list_head l3lh;
+
+	INIT_LIST_HEAD(&l3lh);
+
+	mutex_lock(&l3_offl_llock);
+	if (list_empty(&l3_offl_lh)) {
+		mutex_unlock(&l3_offl_llock);
+		return;
+	}
+	if (going_down) {
+		rvu_sw_l3_drain_list(&l3_offl_lh);
+		mutex_unlock(&l3_offl_llock);
+		return;
+	}
+	list_splice_init(&l3_offl_lh, &l3lh);
+	mutex_unlock(&l3_offl_llock);
+
+	if (rvu_sw_l3_offl_rule_push(&l3lh))
+		pr_err("%s: Error to push rules\n", __func__);
+
+	/* rvu_sw_l3_offl_rule_push() may leave entries when a batch is full. */
+	if (!list_empty(&l3lh)) {
+		mutex_lock(&l3_offl_llock);
+		if (!going_down && sw_l3_offl_wq) {
+			list_splice(&l3lh, &l3_offl_lh);
+			mutex_unlock(&l3_offl_llock);
+			rvu_sw_l3_queue_work_delay(msecs_to_jiffies(100));
+		} else {
+			rvu_sw_l3_drain_list(&l3lh);
+			mutex_unlock(&l3_offl_llock);
+		}
+		return;
+	}
+
+	mutex_lock(&l3_offl_llock);
+	if (!going_down && !list_empty(&l3_offl_lh))
+		rvu_sw_l3_queue_work_locked();
+	mutex_unlock(&l3_offl_llock);
+}
 
 int rvu_mbox_handler_fib_notify(struct rvu *rvu,
 				struct fib_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct l3_entry *l3_entry;
+	int sz, rc;
+
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY))
+		return -EAGAIN;
+
+	/* Reject notifies larger than the source fib_notify_req.entry[]. */
+	if (!req->cnt || req->cnt > RVU_SW_L3_ENTRY_MAX)
+		return -EINVAL;
+
+	sz = req->cnt * sizeof(struct fib_entry);
+
+	l3_entry = kcalloc(1, sizeof(*l3_entry) + sz, GFP_KERNEL);
+	if (!l3_entry)
+		return -ENOMEM;
+
+	l3_entry->port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	l3_entry->rvu = rvu;
+	l3_entry->cnt = req->cnt;
+	INIT_LIST_HEAD(&l3_entry->list);
+	memcpy(l3_entry->entry, req->entry, sz);
+
+	/* Host PFs on this RVU share one AF and one switch PF offload path. */
+	mutex_lock(&l3_offl_llock);
+	if (going_down) {
+		mutex_unlock(&l3_offl_llock);
+		kfree(l3_entry);
+		return -ENODEV;
+	}
+
+	rc = rvu_sw_l3_ensure_wq();
+	if (rc) {
+		mutex_unlock(&l3_offl_llock);
+		kfree(l3_entry);
+		return rc;
+	}
+
+	list_add_tail(&l3_entry->list, &l3_offl_lh);
+	mutex_unlock(&l3_offl_llock);
+	rvu_sw_l3_queue_work();
+
 	return 0;
 }
+
+void rvu_sw_l3_shutdown(void)
+{
+	struct workqueue_struct *wq;
+
+	mutex_lock(&l3_offl_llock);
+	going_down = true;
+	wq = sw_l3_offl_wq;
+	sw_l3_offl_wq = NULL;
+	mutex_unlock(&l3_offl_llock);
+
+	if (!wq)
+		return;
+
+	cancel_delayed_work_sync(&l3_offl_work);
+	destroy_workqueue(wq);
+
+	mutex_lock(&l3_offl_llock);
+	rvu_sw_l3_drain_list(&l3_offl_lh);
+	mutex_unlock(&l3_offl_llock);
+}
+
+void rvu_sw_l3_clear_shutdown(void)
+{
+	mutex_lock(&l3_offl_llock);
+	going_down = false;
+	mutex_unlock(&l3_offl_llock);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
index ac8c4f9ba5ac..03836560077f 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
@@ -8,4 +8,6 @@
 #ifndef RVU_SW_L3_H
 #define RVU_SW_L3_H
 
+void rvu_sw_l3_shutdown(void);
+void rvu_sw_l3_clear_shutdown(void);
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
index f4c47111d763..318f7b68b8e4 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -8,13 +8,255 @@
 
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
 
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+#include <net/route.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "sw_nb.h"
+
+#define SW_FIB_LIST_MAX 4096
+#define SW_FIB_NOTIFY_RETRY_MAX 100
+
+/*
+ * One switch PF registers notifiers via otx2_sw_nb_register(); a second call
+ * returns -EBUSY. A single sw_fib_wq therefore serves the one switchdev
+ * instance on octeontx2, matching the FDB offload path.
+ */
+static DEFINE_SPINLOCK(sw_fib_llock);
+static LIST_HEAD(sw_fib_lh);
+static atomic_t sw_fib_list_cnt = ATOMIC_INIT(0);
+
+static struct workqueue_struct *sw_fib_wq;
+static void sw_fib_work_handler(struct work_struct *work);
+static DECLARE_DELAYED_WORK(sw_fib_work, sw_fib_work_handler);
+
+struct sw_fib_list_entry {
+	struct list_head lh;
+	struct otx2_nic *pf;
+	netdevice_tracker dev_tracker;
+	int cnt;
+	int retries;
+	struct fib_entry *entry;
+};
+
+static void sw_fib_list_cnt_warn(struct net_device *netdev)
+{
+	int n = atomic_read(&sw_fib_list_cnt);
+
+	if (n < 0)
+		netdev_warn(netdev, "FIB list count underflow: %d\n", n);
+	else if (n > SW_FIB_LIST_MAX)
+		netdev_warn(netdev, "FIB list count overflow: %d (max %d)\n",
+			    n, SW_FIB_LIST_MAX);
+}
+
+static int sw_fib_list_count(void)
+{
+	return atomic_read(&sw_fib_list_cnt);
+}
+
+static void sw_fib_list_cnt_inc(struct net_device *netdev)
+{
+	atomic_inc(&sw_fib_list_cnt);
+	sw_fib_list_cnt_warn(netdev);
+}
+
+static void sw_fib_list_cnt_dec(struct net_device *netdev)
+{
+	atomic_dec(&sw_fib_list_cnt);
+	sw_fib_list_cnt_warn(netdev);
+}
+
+static void sw_fib_list_entry_destroy(struct sw_fib_list_entry *lentry)
+{
+	struct net_device *dev = lentry->pf->netdev;
+
+	sw_fib_list_cnt_dec(dev);
+	netdev_put(dev, &lentry->dev_tracker);
+	kfree(lentry->entry);
+	kfree(lentry);
+}
+
+static int sw_fib_notify(struct otx2_nic *pf,
+			 int cnt,
+			 struct fib_entry *entry)
+{
+	struct fib_notify_req *req;
+	int rc;
+
+	if (cnt > RVU_SW_L3_ENTRY_MAX)
+		return -EINVAL;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fib_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	req->cnt = cnt;
+	memcpy(req->entry, entry, sizeof(*entry) * cnt);
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fib_work_handler(struct work_struct *work)
+{
+	struct sw_fib_list_entry *lentry;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock_bh(&sw_fib_llock);
+
+	while ((lentry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fib_list_entry, lh)) != NULL) {
+		list_del_init(&lentry->lh);
+		if (sw_fib_notify(lentry->pf, lentry->cnt, lentry->entry)) {
+			struct net_device *dev = lentry->pf->netdev;
+
+			lentry->retries++;
+			spin_lock_bh(&sw_fib_llock);
+			if (sw_fib_wq && lentry->retries < SW_FIB_NOTIFY_RETRY_MAX) {
+				/*
+				 * TODO: Preserve strict FIB notify ordering on
+				 * retry. Requeuing a failed ADD at the tail
+				 * while continuing the batch lets a later DEL
+				 * for the same route succeed first; when the
+				 * ADD is retried the switch can keep a stale
+				 * route the kernel already deleted.
+				 */
+				netdev_err(dev,
+					   "Failed to notify FIB update to AF, will retry (%d/%d)\n",
+					   lentry->retries, SW_FIB_NOTIFY_RETRY_MAX);
+				list_add_tail(&lentry->lh, &sw_fib_lh);
+				queue_delayed_work(sw_fib_wq, &sw_fib_work,
+						   msecs_to_jiffies(100));
+				spin_unlock_bh(&sw_fib_llock);
+				continue;
+			}
+			spin_unlock_bh(&sw_fib_llock);
+			netdev_err(dev,
+				   "Failed to notify FIB update to AF, giving up after %d tries\n",
+				   lentry->retries);
+			sw_fib_list_entry_destroy(lentry);
+			continue;
+		}
+		sw_fib_list_entry_destroy(lentry);
+	}
+
+	spin_lock_bh(&sw_fib_llock);
+	if (!list_empty(&sw_fib_lh) && sw_fib_wq)
+		queue_delayed_work(sw_fib_wq, &sw_fib_work,
+				   msecs_to_jiffies(10));
+	spin_unlock_bh(&sw_fib_llock);
+}
+
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt)
+{
+	struct otx2_nic *pf = netdev_priv(dev);
+	struct sw_fib_list_entry *lentry;
+	struct workqueue_struct *wq;
+
+	if (cnt <= 0 || cnt > RVU_SW_L3_ENTRY_MAX) {
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	spin_lock_bh(&sw_fib_llock);
+	if (!sw_fib_wq) {
+		spin_unlock_bh(&sw_fib_llock);
+		kfree(entry);
+		return -EINVAL;
+	}
+	spin_unlock_bh(&sw_fib_llock);
+
+	if (sw_fib_list_count() >= SW_FIB_LIST_MAX) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+
+	lentry = kcalloc(1, sizeof(*lentry), GFP_ATOMIC);
+	if (!lentry) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+
+	lentry->pf = pf;
+	lentry->cnt = cnt;
+	lentry->entry = entry;
+	INIT_LIST_HEAD(&lentry->lh);
+	netdev_hold(dev, &lentry->dev_tracker, GFP_ATOMIC);
+
+	spin_lock_bh(&sw_fib_llock);
+	wq = sw_fib_wq;
+	if (wq) {
+		list_add_tail(&lentry->lh, &sw_fib_lh);
+		sw_fib_list_cnt_inc(dev);
+		queue_delayed_work(wq, &sw_fib_work,
+				   msecs_to_jiffies(10));
+	}
+	spin_unlock_bh(&sw_fib_llock);
+
+	if (!wq) {
+		netdev_put(dev, &lentry->dev_tracker);
+		kfree(lentry);
+		kfree(entry);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int otx2_sw_fib_init(void)
 {
+	sw_fib_wq = alloc_workqueue("sw_pf_fib_wq", 0, 0);
+	if (!sw_fib_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void otx2_sw_fib_deinit(void)
 {
+	struct sw_fib_list_entry *lentry;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	spin_lock_bh(&sw_fib_llock);
+	wq = sw_fib_wq;
+	sw_fib_wq = NULL;
+	spin_unlock_bh(&sw_fib_llock);
+
+	if (!wq)
+		return;
+
+	cancel_delayed_work_sync(&sw_fib_work);
+	destroy_workqueue(wq);
+
+	spin_lock_bh(&sw_fib_llock);
+	list_splice_init(&sw_fib_lh, &tlist);
+	spin_unlock_bh(&sw_fib_llock);
+
+	while ((lentry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fib_list_entry, lh)) != NULL) {
+		list_del_init(&lentry->lh);
+		sw_fib_list_entry_destroy(lentry);
+	}
 }
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
index 448d5612133e..046fdee42674 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
@@ -8,11 +8,25 @@
 #define SW_FIB_H_
 
 #include <linux/kconfig.h>
+#include <linux/slab.h>
+
+struct fib_entry;
+struct net_device;
 
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fib_add_to_list(struct net_device *dev,
+		       struct fib_entry *entry, int cnt);
 void otx2_sw_fib_deinit(void);
 int otx2_sw_fib_init(void);
 #else
+static inline int sw_fib_add_to_list(struct net_device *dev,
+				     struct fib_entry *entry, int cnt)
+{
+	(void)dev;
+	(void)cnt;
+	kfree(entry);
+	return 0;
+}
 static inline void otx2_sw_fib_deinit(void) {}
 static inline int otx2_sw_fib_init(void) { return 0; }
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index c947f30becc8..b512d4152ac8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -185,6 +185,7 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	int rc = 0;
 
 	if (!sw_nb_is_valid_dev(dev))
 		return NOTIFY_DONE;
@@ -200,14 +201,17 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 		 * setups; only Cavium PF/representor netdevs are supported
 		 * as bridge ports today (VLAN/virt under bridge is TODO).
 		 */
-		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr,
-				   event == SWITCHDEV_FDB_ADD_TO_DEVICE);
+		rc = sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr,
+					event == SWITCHDEV_FDB_ADD_TO_DEVICE);
 		break;
 
 	default:
 		return NOTIFY_DONE;
 	}
 
+	if (rc)
+		netdev_err(dev, "%s: Error to add to list\n", __func__);
+
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
index 31009e00121f..7ee3a98fc50d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -12,6 +12,7 @@
 #include <net/arp.h>
 #include <net/route.h>
 #include <linux/inetdevice.h>
+#include <net/nexthop.h>
 
 #include "../otx2_reg.h"
 #include "../otx2_common.h"
@@ -43,7 +44,13 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 	if (!idev || !idev->ifa_list)
 		return NOTIFY_DONE;
 
-	/* Switch offload supports a single IPv4 address per interface for now. */
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	/* Switch offload supports a single IPv4 address per interface for
+	 * now. Only the head of ifa_list is offloaded on netdev events;
+	 * secondary addresses are not supported by the hardware path.
+	 */
 	ifa = rtnl_dereference(idev->ifa_list);
 
 	entry = kcalloc(1, sizeof(*entry), GFP_KERNEL);
@@ -69,6 +76,10 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 		entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
 	}
 
+	/* Switch offload is only enabled on OcteonTX2/CN10K SoCs. pf_dev is an
+	 * octeontx2 PF or representor netdev, so netdev_priv() is otx2_nic even
+	 * though sw_nb_is_cavium_dev() matches the shared Cavium PCI vendor ID.
+	 */
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
@@ -81,7 +92,7 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %pI4n, %pM, dev=%s\n",
 		   __func__, &entry->dst, entry->mac, dev->name);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 
 	return NOTIFY_DONE;
 }
@@ -106,7 +117,8 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 		return NOTIFY_DONE;
 
 	/* On NETDEV_DOWN the deleted address is passed in ifa; ifa_list may
-	 * already be empty when the last address is removed.
+	 * already be empty when the last address is unlinked before the
+	 * notifier runs.
 	 */
 	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
@@ -144,24 +156,27 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %pI4n, %pM, %s\n",
 		   __func__, &entry->dst, entry->mac, dev->name);
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
 int sw_nb_v4_fib_event(struct notifier_block *nb,
 		       unsigned long event, void *ptr)
 {
-	struct net_device *dev, *pf_dev = NULL, *nh_pf_dev;
 	struct fib_entry_notifier_info *fen_info = ptr;
-	struct fib_entry *entries, *iter;
+	struct net_device *host_pf_dev = NULL;
 	struct netdev_hw_addr *dev_addr;
+	struct net_device *nh_pf_dev;
+	struct fib_nh_common *nhc;
 	struct neighbour *neigh;
+	struct fib_entry *entry;
+	struct net_device *dev;
 	struct fib_nh *fib_nh;
 	struct fib_info *fi;
 	struct otx2_nic *pf;
+	int i, cnt, nhs;
 	__be32 *haddr;
 	int hcnt = 0;
-	int cnt, i;
 
 	/* Process only UNICAST routes add or del */
 	if (fen_info->type != RTN_UNICAST)
@@ -171,13 +186,17 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 	if (!fi)
 		return NOTIFY_DONE;
 
+	nhs = fib_info_num_path(fi);
+
 	if (fi->fib_nh_is_v6) {
-		struct net_device *log_dev = (fi->fib_nhs > 0) ?
-			fi->fib_nh->fib_nh_dev : NULL;
+		if (nhs > 0) {
+			nhc = fib_info_nhc(fi, 0);
 
-		if (log_dev)
-			netdev_dbg(log_dev, "%s: Received v6 notification\n",
-				   __func__);
+			if (nhc->nhc_dev)
+				netdev_dbg(nhc->nhc_dev,
+					   "%s: Received v6 notification\n",
+					   __func__);
+		}
 		return NOTIFY_DONE;
 	}
 
@@ -186,19 +205,16 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 	 * are walked below; nhid and nexthop-group installs are intentionally
 	 * skipped until fib_info_num_path()/fib_info_nhc() handling is added.
 	 */
-	entries = kcalloc(fi->fib_nhs, sizeof(*entries), GFP_ATOMIC);
-	if (!entries)
+	if (!nhs)
 		return NOTIFY_DONE;
 
-	haddr = kcalloc(fi->fib_nhs, sizeof(*haddr), GFP_ATOMIC);
-	if (!haddr) {
-		kfree(entries);
+	haddr = kcalloc(nhs, sizeof(*haddr), GFP_ATOMIC);
+	if (!haddr)
 		return NOTIFY_DONE;
-	}
 
-	iter = entries;
-	fib_nh = fi->fib_nh;
-	for (i = 0; i < fi->fib_nhs; i++, fib_nh++) {
+	for (i = 0; i < nhs; i++) {
+		nhc = fib_info_nhc(fi, i);
+		fib_nh = container_of(nhc, struct fib_nh, nh_common);
 		dev = fib_nh->fib_nh_dev;
 
 		if (!dev)
@@ -210,107 +226,118 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		if (!sw_nb_is_valid_dev(dev))
 			continue;
 
-		iter->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
-		iter->dst = htonl(fen_info->dst);
-		iter->dst_len = fen_info->dst_len;
-		iter->gw = fib_nh->fib_nh_gw4;
-
-		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4n dst_len=%u gw=%pI4n\n",
-			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw);
-
 		nh_pf_dev = sw_nb_resolve_pf_dev(dev);
 		if (!nh_pf_dev)
 			continue;
-		pf_dev = nh_pf_dev;
+
+		entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			break;
+
+		entry->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
+		entry->dst = htonl(fen_info->dst);
+		entry->dst_len = fen_info->dst_len;
+		entry->gw = fib_nh->fib_nh_gw4;
 
 		if (netif_is_bridge_master(dev)) {
-			iter->bridge = 1;
+			entry->bridge = 1;
 		} else if (is_vlan_dev(dev)) {
-			iter->vlan_valid = 1;
-			iter->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
+			entry->vlan_valid = 1;
+			entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
 		}
 
-		pf = netdev_priv(pf_dev);
-		iter->port_id = pf->pcifunc;
+		pf = netdev_priv(nh_pf_dev);
+		entry->port_id = pf->pcifunc;
 
 		/* Point-to-point routes, including default routes with no
 		 * gateway, are not supported for switch offload.
 		 */
-		if (!fib_nh->fib_nh_gw4)
+		if (!fib_nh->fib_nh_gw4) {
+			if (!entry->dst && !entry->dst_len) {
+				kfree(entry);
+				continue;
+			}
+			sw_fib_add_to_list(nh_pf_dev, entry, 1);
 			continue;
-		iter->gw_valid = 1;
+		}
+
+		entry->gw_valid = 1;
 
 		if (fib_nh->nh_saddr)
 			haddr[hcnt++] = fib_nh->nh_saddr;
 
+		/* TODO: No replay mechanism yet when the gateway neighbor is
+		 * unresolved. If ip_neigh_gw4() returns NULL the route is
+		 * skipped here; sw_nb_net_v4_neigh_update() only pushes the
+		 * MAC and does not replay the dropped route configuration.
+		 */
 		rcu_read_lock();
 		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
-		if (!neigh || IS_ERR(neigh)) {
+		if (IS_ERR_OR_NULL(neigh)) {
 			rcu_read_unlock();
+			kfree(entry);
 			continue;
 		}
 
-		neigh_ha_snapshot(iter->mac, neigh, fib_nh->fib_nh_dev);
-		if (is_valid_ether_addr(iter->mac))
-			iter->mac_valid = 1;
-
-		iter++;
+		neigh_ha_snapshot(entry->mac, neigh, fib_nh->fib_nh_dev);
+		if (is_valid_ether_addr(entry->mac))
+			entry->mac_valid = 1;
 		rcu_read_unlock();
-	}
 
-	cnt = iter - entries;
-	if (!cnt) {
-		kfree(entries);
-		kfree(haddr);
-		return NOTIFY_DONE;
+		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4n dst_len=%u gw=%pI4n\n",
+			   __func__, entry->cmd, &entry->dst, entry->dst_len,
+			   &entry->gw);
+		sw_fib_add_to_list(nh_pf_dev, entry, 1);
 	}
 
-	if (pf_dev)
-		netdev_dbg(pf_dev, "pf_dev is %s cnt=%d\n", pf_dev->name, cnt);
-	kfree(entries);
-
 	if (!hcnt) {
 		kfree(haddr);
 		return NOTIFY_DONE;
 	}
 
-	if (!pf_dev) {
-		kfree(haddr);
-		return NOTIFY_DONE;
-	}
+	for (i = 0; i < hcnt; i++) {
+		host_pf_dev = NULL;
+		for (cnt = 0; cnt < nhs; cnt++) {
+			nhc = fib_info_nhc(fi, cnt);
+			fib_nh = container_of(nhc, struct fib_nh, nh_common);
+			if (fib_nh->nh_saddr != haddr[i])
+				continue;
+			/* Skip blackhole or unresolved nexthops with no device. */
+			if (!fib_nh->fib_nh_dev)
+				continue;
+			host_pf_dev = sw_nb_resolve_pf_dev(fib_nh->fib_nh_dev);
+			break;
+		}
 
-	entries = kcalloc(hcnt, sizeof(*entries), GFP_ATOMIC);
-	if (!entries) {
-		kfree(haddr);
-		return NOTIFY_DONE;
-	}
+		if (!host_pf_dev)
+			continue;
 
-	iter = entries;
+		entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+		if (!entry)
+			break;
 
-	/* Host routes reuse pf_dev/pf from the last resolved Cavium netdev:
-	 * pf_dev only identifies the switch AF mailbox context for switchdev
-	 * programming; any previously resolved Cavium netdev is sufficient.
-	 */
-	for (i = 0; i < hcnt; i++, iter++) {
-		iter->cmd = sw_nb_fib_event_to_otx2_event(event, pf_dev);
-		iter->dst = haddr[i];
-		iter->dst_len = 32;
-		iter->mac_valid = 1;
-		iter->host = 1;
-		iter->port_id = pf->pcifunc;
+		pf = netdev_priv(host_pf_dev);
+		entry->cmd = sw_nb_fib_event_to_otx2_event(event, host_pf_dev);
+		entry->dst = haddr[i];
+		entry->dst_len = 32;
+		entry->mac_valid = 1;
+		entry->host = 1;
+		entry->port_id = pf->pcifunc;
 
 		rcu_read_lock();
-		for_each_dev_addr(pf_dev, dev_addr) {
-			ether_addr_copy(iter->mac, dev_addr->addr);
+		for_each_dev_addr(host_pf_dev, dev_addr) {
+			ether_addr_copy(entry->mac, dev_addr->addr);
 			break;
 		}
 		rcu_read_unlock();
 
-		netdev_dbg(pf_dev, "%s: FIB host Rule cmd=%llu dst=%pI4n dst_len=%u %s\n",
-			   __func__, iter->cmd, &iter->dst, iter->dst_len,
-			   pf_dev->name);
+		netdev_dbg(host_pf_dev,
+			   "%s: FIB host Rule cmd=%llu dst=%pI4n dst_len=%u %s\n",
+			   __func__, entry->cmd, &entry->dst, entry->dst_len,
+			   host_pf_dev->name);
+		sw_fib_add_to_list(host_pf_dev, entry, 1);
 	}
-	kfree(entries);
+
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -326,6 +353,9 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	if (n->tbl != &arp_tbl)
 		return NOTIFY_DONE;
 
+	if (!sw_nb_is_valid_dev(n->dev))
+		return NOTIFY_DONE;
+
 	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return NOTIFY_DONE;
@@ -353,7 +383,7 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
index 3497e60aedbe..2648bde47c18 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -97,15 +97,15 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "netdev event addr=%pI6c plen=%u mac=%pM\n",
 		   &addr, prefix_len, entry->mac);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
 int sw_nb_v6_fib_event(struct notifier_block *nb,
 		       unsigned long event, void *ptr)
 {
-	struct fib6_entry_notifier_info *f6_eni;
 	struct fib_notifier_info *info = ptr;
+	struct fib6_entry_notifier_info *f6_eni;
 	struct net_device *fib_dev, *pf_dev;
 	struct fib_entry *entry;
 	struct fib6_info *f6i;
@@ -143,6 +143,11 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 		   f6i->fib6_flags, f6i->fib6_protocol, f6i->fib6_type);
 
 	nh6 = f6i->nh ? nexthop_fib6_nh(f6i->nh) : f6i->fib6_nh;
+	/*
+	 * TODO: Offload directly connected IPv6 subnets without an IPv6
+	 * gateway. fib_nh_gw_family is only AF_INET6 when RTF_GATEWAY is set,
+	 * so connected routes are dropped here today.
+	 */
 	if (nh6->fib_nh_gw_family != AF_INET6)
 		return NOTIFY_DONE;
 
@@ -174,10 +179,14 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 	/* TODO: No replay mechanism yet when the gateway neighbor is unresolved.
 	 * If ip_neigh_gw6() returns NULL the route is skipped here; add replay
 	 * from the neighbor update handler once nexthop resolution completes.
+	 *
+	 * TODO: Bypass gateway neighbour lookup for directly connected IPv6
+	 * routes, similar to sw_nb_v4_fib_event(). Unconditional ip_neigh_gw6()
+	 * is incorrect when no gateway is configured.
 	 */
 	rcu_read_lock();
 	neigh = ip_neigh_gw6(fib_dev, &nh6->fib_nh_gw6);
-	if (!neigh || IS_ERR(neigh)) {
+	if (IS_ERR_OR_NULL(neigh)) {
 		rcu_read_unlock();
 		kfree(entry);
 		return NOTIFY_DONE;
@@ -189,8 +198,8 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	rcu_read_unlock();
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -234,7 +243,7 @@ int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
 	netdev_dbg(n->dev, "v6 neigh update %pI6c mac=%pM plen=%u\n",
 		   (struct in6_addr *)n->primary_key, entry->mac,
 		   n->tbl->key_len * 8);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 
 	return NOTIFY_DONE;
 }
@@ -294,7 +303,7 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
 
 	netdev_dbg(dev, "inetaddr addr=%pI6c len=%u %pM\n",
 		   &ifa6->addr, ifa6->prefix_len, entry->mac);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 
 	return NOTIFY_DONE;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
index f73efc98c311..78c0df5eb880 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.h
@@ -7,6 +7,9 @@
 #ifndef SW_NB_V6_H_
 #define SW_NB_V6_H_
 
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_IPV6)
 int sw_nb_v6_fib_event(struct notifier_block *nb,
 		       unsigned long event, void *ptr);
 
@@ -18,4 +21,30 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
 
 int sw_nb_v6_netdev_event(struct notifier_block *unused,
 			  unsigned long event, void *ptr);
-#endif // SW_NB_V6_H__
+#else
+static inline int sw_nb_v6_fib_event(struct notifier_block *nb,
+				     unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static inline int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
+					    unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static inline int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
+					  unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+
+static inline int sw_nb_v6_netdev_event(struct notifier_block *unused,
+					unsigned long event, void *ptr)
+{
+	return NOTIFY_DONE;
+}
+#endif
+
+#endif /* SW_NB_V6_H_ */
-- 
2.43.0

