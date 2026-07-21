Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795943787C;
	Tue, 21 Jul 2026 08:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621946; cv=none; b=o8+LWkmjQnBW45wAMtDg1rOQlPwOeU+mTJoC+xpDtixyO7QA1qlVpJLkzPTs82b/8oDN/hragOLocjOaqou5X3VPJZO3paYmlm0jBhGQpNx+6Lp0lSCzOSqSFNJnN3OZXdF6ykyGTLMuRVnCsgWhPKXGroDZ2b8azXafzJ47+9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621946; c=relaxed/simple;
	bh=oWGZZA7MGqt+4EbsXSdoppV1BfPsuPKVNYcT0Tj889k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmVMFlGt0r+I7i5hGC4FEWUXDkKsQ0A7RzNLfTSYm6tjdwTB+iBgoTpA8WSYFIEZQBc7t9vSEEdL3bB89Xp8wchIuLkuNQBefuyFmASAc+EPGg1EGynVmfPzKKqA5NLWVHgkVVqg+9Ee5lUFrs0QX1noCrSiquh2o4N5e2PglFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YSVEi1uM; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YSVEi1uM"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNcCU4652687;
	Tue, 21 Jul 2026 01:18:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=k
	YreaVhN6iv7oIKzWVE5zzZYtPQ/2eBj0NZiSTtFmWE=; b=YSVEi1uM8Z7MlMwv6
	93Xd6R2NiVVX7ro4k8Tn8V7IjwEvGk5sPdZaw+nVyGMRv1I8qfIMXYCTYjRtYUN7
	47v1+Xv6aoSMJXr1qs34VKmWU0hEwYMQOz0LrjYot/aR39awLgbObVbk/QvfR95v
	VV0YmEmPqnq4qj/pSGVlRisOEa5OKDhAxYJuoJ2F+68/T+mdKLVsg7udDwgDfrAF
	acBSTnFIvzsxrg5Wnf0Qk1S3M1w0wWUIxD748AJw5Sht+BZWRwzllWVY8rlOMkKr
	9y4rMEnXJ2swlC2oS7l/wv395jKmlwx4AyedJ/MW+ui5tUB7pFc03BPbBDk7JkYl
	6N68A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fgdbcyufc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 01:18:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 21 Jul 2026 01:18:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 21 Jul 2026 01:18:53 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 429DB3F7091;
	Tue, 21 Jul 2026 01:18:51 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v4 net-next 8/9] octeontx2: switch: offload host FIB updates to switch via AF mailbox
Date: Tue, 21 Jul 2026 13:48:23 +0530
Message-ID: <20260721081824.1430607-9-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: I5jlu9qIGy9qn37OMFUgFMULbyvHDK0M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NyBTYWx0ZWRfX8JaCVj++Byk7
 /kSiFzu6++klPukY5nAj6hfdXIEnLKEzB4wiezHwBsxVgrPFvxgFdEnWOR29gupIFwP3LhU1xM9
 wiRDp4l0tr4j6XKpj8N+pX48NWhwtPY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NyBTYWx0ZWRfX+dRNbMLBkWF+
 TAswjbETsashYD05F12LNICwOs0J6Rh0CrRV4H7ebSqM/m1TVQ/Nd6FhxCjkQjpwH6sv7NpJ/h9
 iQRjLc/lpMtQneYizxg1PgD/Rusi97ksbURm+HgTzNFpWAX8WgJWsSWaddIJ4Yc7/sSp2Vy4nxh
 67J7SJka/SdL0KUXXJzM3qCpzRxwxoe2PIA+d0bDgFiyEJVn0qH8yAPV/k3NVeSPql9VZpaLMaK
 sKxLuwhiJUxedgNN7tGn7x/JCABd4ukejTzWtgCEua/9HNomd4AiNiBCL2pGO2CP/Ci1pjzoycL
 KgPkOqKi6W+khWvR11BUfXTYtUWWRNmt2q3XbjQA3dzTPGA2/qbbT2zMICU1HIW7B3CjD95FnAT
 kX9A8U2fd6t/xQNeYKymONwlWeCx4sRV1KIGH9PtU4uZ7wtkqiyaSrtMP7dCJrjCZEbg9XnqdpY
 wb/u3AAN5XeVJpArjHw==
X-Proofpoint-GUID: I5jlu9qIGy9qn37OMFUgFMULbyvHDK0M
X-Authority-Analysis: v=2.4 cv=Nq3htcdJ c=1 sm=1 tr=0 ts=6a5f2b6e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=cLNcnrBKlAuJ8xe52PgA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01

Queue IPv4/IPv6 FIB-derived updates from the switch notifier path
and handle fib_notify in the RVU AF by batching fib_entry
structures and sending them to the switch PF through the
AF-to-switchdev FIB_CMD. Require the switch firmware to
be ready before accepting offload work.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../marvell/octeontx2/af/switch/rvu_sw.c      |   3 +-
 .../marvell/octeontx2/af/switch/rvu_sw_l3.c   | 243 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l3.h   |   1 +
 .../marvell/octeontx2/nic/switch/sw_fib.c     | 225 ++++++++++++++++
 .../marvell/octeontx2/nic/switch/sw_fib.h     |  14 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |  11 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v4.c   | 192 +++++++-------
 .../marvell/octeontx2/nic/switch/sw_nb_v6.c   |  22 +-
 .../marvell/octeontx2/nic/switch/sw_nb_v6.h   |  31 ++-
 9 files changed, 640 insertions(+), 102 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index b9cd7c7524b9..1151ba47284b 100644
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
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
@@ -80,4 +80,5 @@ int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 void rvu_sw_shutdown(void)
 {
 	rvu_sw_l2_shutdown();
+	rvu_sw_l3_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
index 2b798d5f0644..c47b93a66a3b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.c
@@ -4,11 +4,254 @@
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
+#define RVU_SW_L3_BATCH_MAX						\
+	((int)(sizeof_field(struct af2swdev_notify_req, entry) /	\
+	       sizeof(struct fib_entry)))
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
+static void rvu_sw_l3_queue_work(void)
+{
+	if (sw_l3_offl_wq)
+		queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+				   msecs_to_jiffies(10));
+}
+
+static int rvu_sw_l3_ensure_wq(void)
+{
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
+		     sizeof(struct fib_entry) * RVU_SW_L3_BATCH_MAX);
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
+		/* af2swdev_notify_req.entry[] holds RVU_SW_L3_BATCH_MAX slots;
+		 * stop before copying the next l3_entry when the mbox buffer
+		 * would overflow. Leftovers stay on lh and are re-queued.
+		 */
+		if (tot_cnt + cnt > RVU_SW_L3_BATCH_MAX)
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
+	req->flags = FIB_CMD;
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
+	list_splice_init(&l3_offl_lh, &l3lh);
+	mutex_unlock(&l3_offl_llock);
+
+	if (rvu_sw_l3_offl_rule_push(&l3lh))
+		pr_err("%s: Error to push rules\n", __func__);
+
+	/* rvu_sw_l3_offl_rule_push() may leave entries when a batch is full. */
+	if (!list_empty(&l3lh)) {
+		mutex_lock(&l3_offl_llock);
+		list_splice(&l3lh, &l3_offl_lh);
+		mutex_unlock(&l3_offl_llock);
+		if (sw_l3_offl_wq)
+			queue_delayed_work(sw_l3_offl_wq, &l3_offl_work,
+					   msecs_to_jiffies(100));
+		return;
+	}
+
+	mutex_lock(&l3_offl_llock);
+	if (!list_empty(&l3_offl_lh))
+		rvu_sw_l3_queue_work();
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
+	/* Reject single notifies larger than af2swdev_notify_req.entry[]. */
+	if (!req->cnt || req->cnt > RVU_SW_L3_BATCH_MAX)
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
+	rc = rvu_sw_l3_ensure_wq();
+	if (rc) {
+		mutex_unlock(&l3_offl_llock);
+		kfree(l3_entry);
+		return rc;
+	}
+
+	list_add_tail(&l3_entry->list, &l3_offl_lh);
+	if (sw_l3_offl_wq)
+		rvu_sw_l3_queue_work();
+	mutex_unlock(&l3_offl_llock);
+
 	return 0;
 }
+
+void rvu_sw_l3_shutdown(void)
+{
+	if (!sw_l3_offl_wq)
+		return;
+
+	cancel_delayed_work_sync(&l3_offl_work);
+	destroy_workqueue(sw_l3_offl_wq);
+	sw_l3_offl_wq = NULL;
+
+	mutex_lock(&l3_offl_llock);
+	rvu_sw_l3_drain_list(&l3_offl_lh);
+	mutex_unlock(&l3_offl_llock);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
index ac8c4f9ba5ac..153f1415466d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l3.h
@@ -8,4 +8,5 @@
 #ifndef RVU_SW_L3_H
 #define RVU_SW_L3_H
 
+void rvu_sw_l3_shutdown(void);
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
index 41a9c5fb58fa..308ce3048a8d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.c
@@ -8,13 +8,238 @@
 
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
+#define SW_FIB_BATCH_MAX 16
+#define SW_FIB_LIST_MAX 4096
+
+/*
+ * One switch PF registers notifiers via sw_nb_register(); a second call
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
+static int sw_fib_notify(struct otx2_nic *pf,
+			 int cnt,
+			 struct fib_entry *entry)
+{
+	struct fib_notify_req *req;
+	int rc;
+
+	if (cnt > SW_FIB_BATCH_MAX)
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
+			netdev_err(lentry->pf->netdev,
+				   "Failed to notify FIB update to AF, will retry\n");
+			spin_lock_bh(&sw_fib_llock);
+			if (sw_fib_wq) {
+				list_add(&lentry->lh, &sw_fib_lh);
+				queue_delayed_work(sw_fib_wq, &sw_fib_work,
+						   msecs_to_jiffies(100));
+				spin_unlock_bh(&sw_fib_llock);
+				continue;
+			}
+			spin_unlock_bh(&sw_fib_llock);
+			netdev_put(lentry->pf->netdev, &lentry->dev_tracker);
+			sw_fib_list_cnt_dec(lentry->pf->netdev);
+			kfree(lentry->entry);
+			kfree(lentry);
+			continue;
+		}
+		sw_fib_list_cnt_dec(lentry->pf->netdev);
+		netdev_put(lentry->pf->netdev, &lentry->dev_tracker);
+		kfree(lentry->entry);
+		kfree(lentry);
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
+	if (cnt <= 0 || cnt > SW_FIB_BATCH_MAX) {
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
 int sw_fib_init(void)
 {
+	sw_fib_wq = alloc_workqueue("sw_pf_fib_wq", 0, 0);
+	if (!sw_fib_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void sw_fib_deinit(void)
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
+		sw_fib_list_cnt_dec(lentry->pf->netdev);
+		netdev_put(lentry->pf->netdev, &lentry->dev_tracker);
+		kfree(lentry->entry);
+		kfree(lentry);
+	}
 }
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fib.h
index 9b72e95f2dd3..05a528931d14 100644
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
 void sw_fib_deinit(void);
 int sw_fib_init(void);
 #else
+static inline int sw_fib_add_to_list(struct net_device *dev,
+				     struct fib_entry *entry, int cnt)
+{
+	(void)dev;
+	(void)cnt;
+	kfree(entry);
+	return 0;
+}
 static inline void sw_fib_deinit(void) {}
 static inline int sw_fib_init(void) { return 0; }
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index e908cc50a611..f2597d413780 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -163,6 +163,7 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 {
 	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
 	struct switchdev_notifier_fdb_info *fdb_info = ptr;
+	int rc = 0;
 
 	if (!sw_nb_is_valid_dev(dev))
 		return NOTIFY_DONE;
@@ -178,14 +179,17 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
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
 
@@ -354,8 +358,8 @@ static int sw_nb_netdev_event(struct notifier_block *unused,
 	if (idev)
 		sw_nb_v4_netdev_event(unused, event, ptr);
 
-#if IS_ENABLED(CONFIG_IPV6)
 	i6dev = __in6_dev_get(dev);
+#if IS_ENABLED(CONFIG_IPV6)
 	if (i6dev)
 		sw_nb_v6_netdev_event(unused, event, ptr);
 #endif
@@ -432,6 +436,7 @@ int sw_nb_register(struct net_device *netdev)
 {
 	int err;
 
+	/* One switch PF / switchdev instance registers system-wide notifiers. */
 	if (sw_nb_registered)
 		return -EBUSY;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
index c773fce1bc50..38d2e8da9d31 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v4.c
@@ -12,6 +12,7 @@
 #include <net/arp.h>
 #include <net/route.h>
 #include <linux/inetdevice.h>
+#include <net/nexthop.h>
 
 #include "../otx2_reg.h"
 #include "../otx2_common.h"
@@ -40,7 +41,13 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
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
@@ -66,6 +73,10 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 		entry->vlan_tag = cpu_to_be16(vlan_dev_vlan_id(dev));
 	}
 
+	/* Switch offload is only enabled on OcteonTX2/CN10K SoCs. pf_dev is an
+	 * octeontx2 PF or representor netdev, so netdev_priv() is otx2_nic even
+	 * though sw_nb_is_cavium_dev() matches the shared Cavium PCI vendor ID.
+	 */
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
@@ -76,7 +87,7 @@ int sw_nb_v4_netdev_event(struct notifier_block *unused,
 
 	netdev_dbg(dev, "%s: pushing netdev event from HOST interface address %pI4, %pM, dev=%s\n",
 		   __func__, &entry->dst, entry->mac, dev->name);
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 
 	return NOTIFY_DONE;
 }
@@ -88,7 +99,6 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	struct net_device *dev = ifa->ifa_dev->dev;
 	struct netdev_hw_addr *dev_addr;
 	struct net_device *pf_dev;
-	struct in_device *idev;
 	struct fib_entry *entry;
 	struct otx2_nic *pf;
 
@@ -101,10 +111,9 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	if (!sw_nb_is_valid_dev(dev))
 		return NOTIFY_DONE;
 
-	idev = __in_dev_get_rtnl(dev);
-	if (!idev || !idev->ifa_list)
-		return NOTIFY_DONE;
-
+	/* Use ifa from the notifier; idev->ifa_list is already empty when the
+	 * final address is unlinked before NETDEV_DOWN is delivered.
+	 */
 	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return NOTIFY_DONE;
@@ -139,24 +148,27 @@ int sw_nb_v4_inetaddr_event(struct notifier_block *nb,
 	netdev_dbg(dev, "%s: pushing inetaddr event from HOST interface address %pI4, %pM, %s\n",
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
@@ -166,29 +178,30 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
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
@@ -200,115 +213,111 @@ int sw_nb_v4_fib_event(struct notifier_block *nb,
 		if (!sw_nb_is_valid_dev(dev))
 			continue;
 
-		iter->cmd = sw_nb_fib_event_to_otx2_event(event, dev);
-		iter->dst = (__force __be32)fen_info->dst;
-		iter->dst_len = fen_info->dst_len;
-		iter->gw = fib_nh->fib_nh_gw4;
-
-		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4\n",
-			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw);
-
 		nh_pf_dev = sw_nb_resolve_pf_dev(dev);
-		if (!nh_pf_dev) {
-			iter++;
+		if (!nh_pf_dev)
 			continue;
-		}
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
 		if (!fib_nh->fib_nh_gw4) {
-			if (iter->dst || iter->dst_len)
-				iter++;
-
+			if (!entry->dst && !entry->dst_len) {
+				kfree(entry);
+				continue;
+			}
+			sw_fib_add_to_list(nh_pf_dev, entry, 1);
 			continue;
 		}
-		iter->gw_valid = 1;
+
+		entry->gw_valid = 1;
 
 		if (fib_nh->nh_saddr)
 			haddr[hcnt++] = fib_nh->nh_saddr;
 
 		rcu_read_lock();
 		neigh = ip_neigh_gw4(fib_nh->fib_nh_dev, fib_nh->fib_nh_gw4);
-		if (!neigh) {
+		if (IS_ERR_OR_NULL(neigh)) {
 			rcu_read_unlock();
-			iter++;
+			kfree(entry);
 			continue;
 		}
 
 		if (is_valid_ether_addr(neigh->ha)) {
-			iter->mac_valid = 1;
-			neigh_ha_snapshot(iter->mac, neigh, fib_nh->fib_nh_dev);
+			entry->mac_valid = 1;
+			neigh_ha_snapshot(entry->mac, neigh, fib_nh->fib_nh_dev);
 		}
-
-		iter++;
 		rcu_read_unlock();
-	}
 
-	cnt = iter - entries;
-	if (!cnt) {
-		kfree(entries);
-		kfree(haddr);
-		return NOTIFY_DONE;
+		netdev_dbg(dev, "%s: FIB route Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4\n",
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
+			if (fib_nh->nh_saddr == haddr[i]) {
+				host_pf_dev = sw_nb_resolve_pf_dev(fib_nh->fib_nh_dev);
+				break;
+			}
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
 
-		netdev_dbg(pf_dev, "%s: FIB host Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4 %s\n",
-			   __func__, iter->cmd, &iter->dst, iter->dst_len, &iter->gw,
-			   pf_dev->name);
+		netdev_dbg(host_pf_dev,
+			   "%s: FIB host Rule cmd=%llu dst=%pI4 dst_len=%u gw=%pI4 %s\n",
+			   __func__, entry->cmd, &entry->dst, entry->dst_len,
+			   &entry->gw, host_pf_dev->name);
+		sw_fib_add_to_list(host_pf_dev, entry, 1);
 	}
-	kfree(entries);
+
 	kfree(haddr);
 	return NOTIFY_DONE;
 }
@@ -324,6 +333,9 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	if (n->tbl != &arp_tbl)
 		return NOTIFY_DONE;
 
+	if (!sw_nb_is_valid_dev(n->dev))
+		return NOTIFY_DONE;
+
 	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
 	if (!entry)
 		return NOTIFY_DONE;
@@ -351,7 +363,7 @@ int sw_nb_net_v4_neigh_update(struct notifier_block *nb,
 	pf = netdev_priv(pf_dev);
 	entry->port_id = pf->pcifunc;
 
-	kfree(entry);
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	return NOTIFY_DONE;
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
index 62ab00658879..0a2ad61412d6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb_v6.c
@@ -45,12 +45,18 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 	if (!i6dev)
 		return NOTIFY_DONE;
 
+	if (!sw_nb_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
 	/* Invoked from sw_nb_netdev_event() on NETDEV_UP/DOWN/CHANGE, which
 	 * run with RTNL held. IPv6 address list updates are also serialized
 	 * by RTNL, so addr_list cannot race with concurrent assignments.
 	 */
 	rcu_read_lock();
-	/* Switch offload supports a single IPv6 address per interface for now. */
+	/* Switch offload supports a single IPv6 address per interface for
+	 * now. Only the head of addr_list is offloaded on netdev events;
+	 * secondary addresses are not supported by the hardware path.
+	 */
 	ifp = list_first_entry_or_null(&i6dev->addr_list,
 				       struct inet6_ifaddr, if_list);
 	if (!ifp) {
@@ -94,15 +100,15 @@ int sw_nb_v6_netdev_event(struct notifier_block *unused,
 
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
@@ -171,7 +177,7 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 	 */
 	rcu_read_lock();
 	neigh = ip_neigh_gw6(fib_dev, &nh6->fib_nh_gw6);
-	if (!neigh) {
+	if (IS_ERR_OR_NULL(neigh)) {
 		rcu_read_unlock();
 		kfree(entry);
 		return NOTIFY_DONE;
@@ -183,8 +189,8 @@ int sw_nb_v6_fib_event(struct notifier_block *nb,
 		netdev_dbg(fib_dev, "fib found MAC=%pM\n", entry->mac);
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
 	rcu_read_unlock();
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -225,9 +231,10 @@ int sw_nb_net_v6_neigh_update(struct notifier_block *nb,
 	entry->mac_valid = 1;
 	entry->port_id = pf->pcifunc;
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(n->dev, "v6 neigh update %pI6c mac=%pM plen=%u\n",
 		   n->primary_key, entry->mac, n->tbl->key_len * 8);
-	kfree(entry);
 
 	return NOTIFY_DONE;
 }
@@ -283,9 +290,10 @@ int sw_nb_v6_inetaddr_event(struct notifier_block *nb,
 		break;
 	}
 
+	sw_fib_add_to_list(pf_dev, entry, 1);
+
 	netdev_dbg(dev, "inetaddr addr=%pI6c len=%u %pM\n",
 		   &ifa6->addr, ifa6->prefix_len, entry->mac);
-	kfree(entry);
 
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

