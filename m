Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7576415F06;
	Mon, 31 Aug 2026 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788182431; cv=none; b=Y6LweSqGAL++u/yxb9aAnYzNag/NAIO8gt89PDjki9Ve9Hw+VUjnlxe2q+xpKq5TuPSoi0P6sWS6bhrFT0XOGCHgynJIndiVcXT80x1K4D4lha9kf0F5toduHZnpP8r9G4kNJXZGoJbsQeMvGCSpvqoPmUNEXmp1vje/7emIm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788182431; c=relaxed/simple;
	bh=7x20ebveY98oy8Vhdh0DsgAxaDBW13ulgBI37JRbI4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPwkhhHLIStdvtGrr9+IiMC5ABF8cWyRz4WjqNfoED0n2bwlWPZZwVd/gZlVdqtuEOtRqyCDJjHBHOoFLvjRL4PRuRAhJmVc9wPepdsFjkmEEEkrd7IzLZZCopXXrxKBpoJNGgtZ/1wtA6DOWDWEwBknw6QjhJnyR+GHJhVZWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YS2/jNHJ; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YS2/jNHJ"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBCNOS668847;
	Mon, 31 Aug 2026 06:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	jMjW7yoK3UhotIayoQq60B7JP4FFP2ZFu3bX40WrII=; b=YS2/jNHJHDFZkkOxZ
	EkZhpLVbiXbabVSGbRp6laY0SYF/YpTe1jlPbWLiGhCgkbOoabBlV8Z/P8DMJUoe
	TIqPAPaXR52vgoRNNoN+vOz9dWC/+AFrSaBVRmG2sKfpz1E8GMS0KZxeA3eFkqg0
	JvZ3BiQ2t8HDKbCm0/c7vO7nnxfGIqznTa/IzcLbeISvRRsl9YqbGq1oWEHeZyAf
	MMFPUHk3JejnKQD+bYcVHBi84CmoZpaz2lrTIUD+XiDl28JY8q7XyM56ANRj+wjv
	6XsPXl4IHqOJqqCCE0ebrxTI8F2XVHrEUJTMYHVsYaHSSe12x8s1/3GilqysoqoP
	Hc8QA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gcg68jmrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 06:20:19 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 31 Aug 2026 06:20:18 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 31 Aug 2026 06:20:18 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 5C1333F7089;
	Mon, 31 Aug 2026 06:20:15 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>
Subject: [PATCH v9 net-next 7/8] octeontx2: switch: plumb bridge FDB updates through AF and switchdev
Date: Mon, 31 Aug 2026 18:49:43 +0530
Message-ID: <20260831131944.2649362-8-rkannoth@marvell.com>
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
X-Proofpoint-ORIG-GUID: -A48U_sXPc05d8q1ZcdlKtFdvkS4nFCR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX7ZKM/SeBlm2N
 PyfDTlwId+9Po2M2YwacOESv4zjULcR7w7dq6N4NzD5Znzy6YFZP5IuXiHVUm1VFXnQeV2VLuxN
 NoHopD3MHmmHrrk6/jtF+7o0nQjXZKJI/q5IlEKnw8LB/qcrTQdwRKO8foWefLu158oYUAqoKhv
 2WYhC6xzOlnKCrDzsxqZMHebKt10tvzqi7HNj8kePuMd7CYCwL4F6+pGG7Y8cHV7sAQAZtjHMQc
 kFgGYZQrZ6+GTqDS8HYUzrVK0fcTUC2JJfC7Cpa8vEfG9VYYeLMN1m5U1Ie3Is84+cFFLhgpd7C
 4SuqzOj6c691T1vclnM3vJTKN155M4j9JNoYmbAkvXQ+c7EQid+Zr5EIcXMFOfWdOI4hueSq7do
 AutdCJOfkIG9ECxjWLwIGslS6TLNUQjP9mbQYEaaiV03Zbw5uOn8EnCINHsyPMn2egJa0pdyjs8
 vz4LpfJKR22OM/EVZug==
X-Authority-Analysis: v=2.4 cv=fZedDUQF c=1 sm=1 tr=0 ts=6a957f93 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=zjSZ3cS-AAAA:8
 a=3z2JWR2fr4yV80ubqD0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=ZdzWmiyDu4ucoLeQK2uw:22
X-Proofpoint-GUID: -A48U_sXPc05d8q1ZcdlKtFdvkS4nFCR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDExNSBTYWx0ZWRfX2yxGs6J88MUq
 sBqplqJLhW9sg00ygv6MDEYwDhoxncSUBv8BAAbSk5aZczccnvUS4W3PWtev7T4qLcq/BEPxRpb
 LmztdthKhy/SVkpCRr2QOVW6jaSBgU4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01

Handle switchdev FDB add and delete notifications on the PF by queuing
work that sends fdb_notify mailbox messages to the AF. The AF queues
those updates and pushes L2 rules toward the switchdev image with
af2swdev notify messages when firmware is ready.
Teach the AF swdev2af path to initialize L2 offload workqueues on
firmware up/down and to accept refresh requests that enqueue FDB
entries for AF to PF mailbox delivery. Add an AF to PF (and VF) upstream
message for FDB refresh, handle it in the VF driver, and treat it like
the CGX link event when acknowledging mailbox completion in the AF.
On refresh, invoke the switchdev notifier so the host bridge can learn
the updated FDB entry.

Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   2 +
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |   3 +
 .../marvell/octeontx2/af/switch/rvu_sw.c      |  59 +-
 .../marvell/octeontx2/af/switch/rvu_sw.h      |   2 +
 .../marvell/octeontx2/af/switch/rvu_sw_l2.c   | 608 ++++++++++++++++++
 .../marvell/octeontx2/af/switch/rvu_sw_l2.h   |   4 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   2 +
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  49 ++
 .../marvell/octeontx2/nic/switch/sw_fdb.c     | 262 +++++++-
 .../marvell/octeontx2/nic/switch/sw_fdb.h     |   3 +
 .../marvell/octeontx2/nic/switch/sw_nb.c      |  12 +-
 .../marvell/octeontx2/nic/switch/sw_nb.h      |   8 +-
 12 files changed, 1004 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index 2aa1aa6599a5..8f7b2962a212 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -2015,6 +2015,7 @@ struct af2pf_fdb_refresh_req {
 	struct mbox_msghdr hdr;
 	u16 pcifunc;
 	u8 mac[6];
+	u64 flags;
 };
 
 struct iface_info {
@@ -2054,6 +2055,7 @@ struct fl_info {
 struct swdev2af_notify_req {
 	struct  mbox_msghdr hdr;
 	u64 msg_type;
+/* Mutually exclusive message selectors (not a combinable bitmask). */
 #define SWDEV2AF_MSG_TYPE_FW_STATUS BIT_ULL(0)
 #define	SWDEV2AF_MSG_TYPE_REFRESH_FDB BIT_ULL(1)
 #define	SWDEV2AF_MSG_TYPE_REFRESH_FL BIT_ULL(2)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index e4d13adc2896..9d0c99d4c064 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -23,6 +23,7 @@
 #include "cn20k/reg.h"
 #include "cn20k/api.h"
 #include "cn20k/npc.h"
+#include "switch/rvu_sw.h"
 
 #define DRV_NAME	"rvu_af"
 #define DRV_STRING      "Marvell OcteonTX2 RVU Admin Function Driver"
@@ -3863,8 +3864,10 @@ static void rvu_remove(struct pci_dev *pdev)
 	rvu_cgx_exit(rvu);
 	rvu_fwdata_exit(rvu);
 	rvu_mcs_exit(rvu);
+	rvu_sw_shutdown();
 	rvu_mbox_destroy(&rvu->afpf_wq_info);
 	rvu_disable_sriov(rvu);
+	rvu_sw_clear_shutdown();
 	rvu_reset_all_blocks(rvu);
 	rvu_free_hw_resources(rvu);
 	rvu_clear_rvum_blk_revid(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
index 2451eb57ec4c..71f113bded5e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.c
@@ -9,6 +9,8 @@
 
 #include "rvu.h"
 #include "rvu_sw.h"
+#include "rvu_sw_l2.h"
+#include "rvu_sw_fl.h"
 
 /*
  * rep_cnt and rep2pfvf_map are populated once when the representor driver
@@ -33,9 +35,64 @@ u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc)
 	       FIELD_PREP(GENMASK_ULL(15, 0), pcifunc);
 }
 
+static bool rvu_sw_swdev2af_msg_valid(u64 msg_type)
+{
+	return msg_type == SWDEV2AF_MSG_TYPE_FW_STATUS ||
+	       msg_type == SWDEV2AF_MSG_TYPE_REFRESH_FDB ||
+	       msg_type == SWDEV2AF_MSG_TYPE_REFRESH_FL;
+}
+
+static int rvu_sw_swdev2af_sender_check(struct rvu *rvu,
+					struct swdev2af_notify_req *req,
+					u64 msg_type)
+{
+	u16 sender = req->hdr.pcifunc;
+
+	if (!rvu_sw_swdev2af_msg_valid(msg_type))
+		return -EINVAL;
+
+	if (msg_type == SWDEV2AF_MSG_TYPE_FW_STATUS && req->fw_up)
+		return 0;
+
+	if (!rvu_is_switch_pcifunc(rvu, sender))
+		return -EPERM;
+
+	return 0;
+}
+
 int rvu_mbox_handler_swdev2af_notify(struct rvu *rvu,
 				     struct swdev2af_notify_req *req,
 				     struct msg_rsp *rsp)
 {
-	return 0;
+	int rc;
+
+	rc = rvu_sw_swdev2af_sender_check(rvu, req, req->msg_type);
+	if (rc)
+		return rc;
+
+	switch (req->msg_type) {
+	case SWDEV2AF_MSG_TYPE_FW_STATUS:
+		rc = rvu_sw_l2_init_offl_wq(rvu, req->hdr.pcifunc, req->fw_up);
+		break;
+
+	case SWDEV2AF_MSG_TYPE_REFRESH_FDB:
+		rc = rvu_sw_l2_fdb_list_entry_add(rvu, req->pcifunc, req->mac);
+		break;
+
+	default:
+		rc = -EOPNOTSUPP;
+		break;
+	}
+
+	return rc;
+}
+
+void rvu_sw_shutdown(void)
+{
+	rvu_sw_l2_shutdown();
+}
+
+void rvu_sw_clear_shutdown(void)
+{
+	rvu_sw_l2_clear_shutdown();
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
index e9ad32c84576..539af01d917e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw.h
@@ -12,5 +12,7 @@
 #define RVU_SW_INVALID_PORT_ID	((u32)~0U)
 
 u32 rvu_sw_port_id(struct rvu *rvu, u16 pcifunc);
+void rvu_sw_shutdown(void);
+void rvu_sw_clear_shutdown(void);
 
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
index 5f805bfa81ed..448a442a6ffb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.c
@@ -4,11 +4,619 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+
+#include <linux/bitfield.h>
 #include "rvu.h"
+#include "rvu_sw.h"
+#include "rvu_sw_l2.h"
+
+#define M(_name, _id, _fn_name, _req_type, _rsp_type)			\
+static struct _req_type __maybe_unused					\
+*otx2_mbox_alloc_msg_ ## _fn_name(struct rvu *rvu, int devid)		\
+{									\
+	struct _req_type *req;						\
+									\
+	req = (struct _req_type *)otx2_mbox_alloc_msg_rsp(		\
+		&rvu->afpf_wq_info.mbox_up, devid, sizeof(struct _req_type), \
+		sizeof(struct _rsp_type));				\
+	if (!req)							\
+		return NULL;						\
+	req->hdr.sig = OTX2_MBOX_REQ_SIG;				\
+	req->hdr.id = _id;						\
+	return req;							\
+}
+
+MBOX_UP_AF2SWDEV_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
+#undef M
+
+#define RVU_SW_L2_LIST_MAX 4096
+
+struct l2_entry {
+	struct list_head list;
+	u64 flags;
+	u32 port_id;
+	u8  mac[ETH_ALEN];
+};
+
+static bool going_down;
+/* Serialize going_down, control workqueue alloc, and queue_work() so
+ * teardown cannot NULL the workqueue while a mailbox handler is between
+ * the going_down check and queue_work().
+ */
+static DEFINE_MUTEX(rvu_sw_l2_ctrl_lock);
+
+static DEFINE_MUTEX(l2_offl_list_lock);
+static LIST_HEAD(l2_offl_lh);
+static atomic_t l2_offl_list_cnt = ATOMIC_INIT(0);
+
+static DEFINE_MUTEX(fdb_refresh_list_lock);
+static LIST_HEAD(fdb_refresh_lh);
+static atomic_t fdb_refresh_list_cnt = ATOMIC_INIT(0);
+
+struct rvu_sw_l2_work {
+	struct rvu *rvu;
+	struct work_struct work;
+};
+
+struct rvu_sw_l2_ctrl_work {
+	struct work_struct work;
+	struct rvu *rvu;
+	u16 pcifunc;
+	bool fw_up;
+};
+
+/* Work queue for switchdev message handling. There is only one RVU AF
+ * and one switch block per SoC; rvu_probe() enforces a single AF bind via
+ * device_bound, so one global workqueue instance per type is sufficient.
+ */
+static struct rvu_sw_l2_work l2_offl_work;
+static struct workqueue_struct *rvu_sw_l2_offl_wq;
+
+static struct rvu_sw_l2_work fdb_refresh_work;
+static struct workqueue_struct *fdb_refresh_wq;
+
+/* Serialize FW bring-up/teardown outside the AF mailbox handler. The
+ * handler runs under rvu->mbox_lock, while offload/refresh workers take
+ * the same lock to send messages; synchronous teardown there deadlocks.
+ */
+static struct workqueue_struct *rvu_sw_l2_ctrl_wq;
+
+static bool fw_is_up;
+static DEFINE_SPINLOCK(rvu_sw_l2_state_lock);
+
+static void rvu_sw_l2_list_cnt_warn(struct device *dev, atomic_t *cnt,
+				    const char *name)
+{
+	int n = atomic_read(cnt);
+
+	if (n < 0)
+		dev_warn(dev, "L2 %s list count underflow: %d\n", name, n);
+	else if (n > RVU_SW_L2_LIST_MAX)
+		dev_warn(dev, "L2 %s list count overflow: %d (max %d)\n",
+			 name, n, RVU_SW_L2_LIST_MAX);
+}
+
+static void rvu_sw_l2_list_cnt_inc(struct device *dev, atomic_t *cnt,
+				   const char *name)
+{
+	atomic_inc(cnt);
+	rvu_sw_l2_list_cnt_warn(dev, cnt, name);
+}
+
+static void rvu_sw_l2_list_cnt_dec(struct device *dev, atomic_t *cnt,
+				   const char *name)
+{
+	atomic_dec(cnt);
+	rvu_sw_l2_list_cnt_warn(dev, cnt, name);
+}
+
+static void rvu_sw_l2_destroy_wqs(struct rvu *rvu)
+{
+	struct workqueue_struct *offl_wq, *refresh_wq;
+	struct l2_entry *entry;
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	rvu->rswitch.flags &= ~RVU_SWITCH_FLAG_FW_READY;
+	fw_is_up = false;
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	mutex_lock(&fdb_refresh_list_lock);
+	refresh_wq = fdb_refresh_wq;
+	fdb_refresh_wq = NULL;
+	mutex_unlock(&fdb_refresh_list_lock);
+
+	if (refresh_wq) {
+		cancel_work_sync(&fdb_refresh_work.work);
+		destroy_workqueue(refresh_wq);
+
+		mutex_lock(&fdb_refresh_list_lock);
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &fdb_refresh_list_cnt,
+					"fdb refresh");
+		while (1) {
+			entry = list_first_entry_or_null(&fdb_refresh_lh,
+							 struct l2_entry, list);
+			if (!entry)
+				break;
+
+			list_del_init(&entry->list);
+			kfree(entry);
+		}
+		atomic_set(&fdb_refresh_list_cnt, 0);
+		mutex_unlock(&fdb_refresh_list_lock);
+	}
+
+	mutex_lock(&l2_offl_list_lock);
+	offl_wq = rvu_sw_l2_offl_wq;
+	rvu_sw_l2_offl_wq = NULL;
+	mutex_unlock(&l2_offl_list_lock);
+
+	if (offl_wq) {
+		cancel_work_sync(&l2_offl_work.work);
+		destroy_workqueue(offl_wq);
+
+		mutex_lock(&l2_offl_list_lock);
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
+		while (1) {
+			entry = list_first_entry_or_null(&l2_offl_lh,
+							 struct l2_entry, list);
+			if (!entry)
+				break;
+
+			list_del_init(&entry->list);
+			kfree(entry);
+		}
+		atomic_set(&l2_offl_list_cnt, 0);
+		mutex_unlock(&l2_offl_list_lock);
+	}
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	rvu->rswitch.pcifunc = 0;
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+}
+
+/* High-frequency link state transitions or aggressive FDB
+ * aging intervals can induce rapid fdb churn. To prevent
+ * thrashing, inhibit hardware offloading of these transient
+ * forwarding states to the switching ASIC.  Events are queued
+ * at the tail and processed from the head; when enqueueing a
+ * new operation, drop older pending opposite operations for the
+ * same MAC and port that have not yet reached hardware. When an
+ * opposite entry is removed, the new operation is dropped as well.
+ */
+static bool rvu_sw_l2_offl_coalesce_pending_locked(struct rvu *rvu,
+						   struct l2_entry *new_entry)
+{
+	u64 opposite = (new_entry->flags & OTX2_FDB_ADD) ? OTX2_FDB_DEL : OTX2_FDB_ADD;
+	struct l2_entry *entry, *tmp;
+	bool coalesced = false;
+
+	lockdep_assert_held(&l2_offl_list_lock);
+
+	list_for_each_entry_safe(entry, tmp, &l2_offl_lh, list) {
+		if (!ether_addr_equal(new_entry->mac, entry->mac))
+			continue;
+
+		if (new_entry->port_id != entry->port_id)
+			continue;
+
+		if (!(entry->flags & opposite))
+			continue;
+
+		list_del_init(&entry->list);
+		rvu_sw_l2_list_cnt_dec(rvu->dev, &l2_offl_list_cnt, "offload");
+		kfree(entry);
+		coalesced = true;
+	}
+
+	return coalesced;
+}
+
+static int rvu_sw_l2_offl_rule_push(struct rvu *rvu, struct l2_entry *l2_entry)
+{
+	struct af2swdev_notify_req *req;
+	int swdev_pf;
+
+	swdev_pf = rvu_get_pf(rvu->pdev, rvu->rswitch.pcifunc);
+
+	mutex_lock(&rvu->mbox_lock);
+	req = otx2_mbox_alloc_msg_af2swdev_notify(rvu, swdev_pf);
+	if (!req) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENOMEM;
+	}
+
+	ether_addr_copy(req->mac, l2_entry->mac);
+	req->flags = l2_entry->flags;
+	req->port_id = l2_entry->port_id;
+
+	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, swdev_pf);
+
+	mutex_unlock(&rvu->mbox_lock);
+	return 0;
+}
+
+static int rvu_sw_l2_fdb_refresh_send(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct af2pf_fdb_refresh_req *req;
+	int pf, vf;
+
+	if (!is_pf_func_valid(rvu, pcifunc))
+		return -EINVAL;
+
+	pf = rvu_get_pf(rvu->pdev, pcifunc);
+	vf = (pcifunc & RVU_PFVF_FUNC_MASK) - 1;
+
+	mutex_lock(&rvu->mbox_lock);
+
+	/*
+	 * FDB refresh topology (VM bridge + SR-IOV VF ports + HW offload):
+	 *
+	 *   VM: br0 with eth0/eth1 (CGX VFs passed through via SR-IOV)
+	 *   Host: switch HW forwards between VF switch ports; accelerated
+	 *   traffic is not received on eth0/eth1 in the VM.
+	 *
+	 *   br0 still maintains a software FDB with ageing.  After the AF
+	 *   programs hardware, refresh must reach the VM so
+	 *   SWITCHDEV_FDB_ADD_TO_BRIDGE is raised on the bridge port netdev
+	 *   (eth0/eth1), keeping br0 FDB entries alive.
+	 *
+	 *   For CGX VFs (pf != 0), hdr.pcifunc carries the target VF
+	 *   identity so the parent PF mailbox forwards the message to the
+	 *   guest VF driver (otx2_pfaf_mbox_up_handler()).  Routing refresh
+	 *   into the VM is intentional: the bridge owning the FDB is in the
+	 *   guest, not on a host representor.
+	 *
+	 *   This differs from the host-side switchdev model where a Linux
+	 *   bridge on the host uses representor netdevs (RVU_REP) as ports.
+	 *
+	 *   AF-managed VFs on PF 0 (e.g. LBK, pf == 0): delivered directly
+	 *   via the AF VF mailbox; these VFs have no host PF mailbox.
+	 */
+	if (pf != 0) {
+		if (pf >= rvu->afpf_wq_info.mbox_up.ndevs) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -EINVAL;
+		}
+
+		req = otx2_mbox_alloc_msg_af2pf_fdb_refresh(rvu, pf);
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+		req->flags = OTX2_FDB_ADD;
+
+		otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
+		otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+	} else {
+		if (vf < 0 || vf >= rvu->afvf_wq_info.mbox_up.ndevs) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -EINVAL;
+		}
+
+		req = (struct af2pf_fdb_refresh_req *)
+			otx2_mbox_alloc_msg_rsp(&rvu->afvf_wq_info.mbox_up, vf,
+						sizeof(*req), sizeof(struct msg_rsp));
+		if (!req) {
+			mutex_unlock(&rvu->mbox_lock);
+			return -ENOMEM;
+		}
+		req->hdr.sig = OTX2_MBOX_REQ_SIG;
+		req->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
+
+		req->hdr.pcifunc = pcifunc;
+		ether_addr_copy(req->mac, mac);
+		req->pcifunc = pcifunc;
+		req->flags = OTX2_FDB_ADD;
+
+		otx2_mbox_wait_for_zero(&rvu->afvf_wq_info.mbox_up, vf);
+		otx2_mbox_msg_send_up(&rvu->afvf_wq_info.mbox_up, vf);
+	}
+
+	mutex_unlock(&rvu->mbox_lock);
+
+	return 0;
+}
+
+static void rvu_sw_l2_fdb_refresh_wq_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_work *fdb_work;
+	struct l2_entry *l2_entry;
+
+	fdb_work = container_of(work, struct rvu_sw_l2_work, work);
+
+	while (1) {
+		mutex_lock(&fdb_refresh_list_lock);
+		l2_entry = list_first_entry_or_null(&fdb_refresh_lh,
+						    struct l2_entry, list);
+		if (!l2_entry) {
+			mutex_unlock(&fdb_refresh_list_lock);
+			return;
+		}
+
+		list_del_init(&l2_entry->list);
+		rvu_sw_l2_list_cnt_dec(fdb_work->rvu->dev, &fdb_refresh_list_cnt,
+				       "fdb refresh");
+		mutex_unlock(&fdb_refresh_list_lock);
+
+		rvu_sw_l2_fdb_refresh_send(fdb_work->rvu, l2_entry->port_id,
+					   l2_entry->mac);
+		kfree(l2_entry);
+	}
+}
+
+static void rvu_sw_l2_offl_rule_wq_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_work *offl_work;
+	struct l2_entry *l2_entry;
+	int budget = 16;
+
+	offl_work = container_of(work, struct rvu_sw_l2_work, work);
+
+	while (budget--) {
+		mutex_lock(&l2_offl_list_lock);
+		l2_entry = list_first_entry_or_null(&l2_offl_lh, struct l2_entry, list);
+		if (!l2_entry) {
+			mutex_unlock(&l2_offl_list_lock);
+			return;
+		}
+
+		list_del_init(&l2_entry->list);
+		rvu_sw_l2_list_cnt_dec(offl_work->rvu->dev, &l2_offl_list_cnt,
+				       "offload");
+		mutex_unlock(&l2_offl_list_lock);
+
+		if (rvu_sw_l2_offl_rule_push(offl_work->rvu, l2_entry))
+			dev_err(offl_work->rvu->dev,
+				"%s: Error to push l2 rule\n",
+				__func__);
+		/*
+		 * TODO: Requeue l2_entry on transient rvu_sw_l2_offl_rule_push()
+		 * errors (e.g. ENOMEM, -EBUSY) to keep hardware FDB in sync with
+		 * the bridge. Drop-on-failure is known deferred work.
+		 */
+		kfree(l2_entry);
+	}
+
+	mutex_lock(&l2_offl_list_lock);
+	if (rvu_sw_l2_offl_wq && atomic_read(&l2_offl_list_cnt))
+		queue_work(rvu_sw_l2_offl_wq, &l2_offl_work.work);
+	mutex_unlock(&l2_offl_list_lock);
+}
+
+static void rvu_sw_l2_ctrl_work_handler(struct work_struct *work)
+{
+	struct rvu_sw_l2_ctrl_work *ctrl;
+	struct rvu_switch *rswitch;
+	struct rvu *rvu;
+	u16 pcifunc;
+	bool fw_up;
+
+	ctrl = container_of(work, struct rvu_sw_l2_ctrl_work, work);
+	rvu = ctrl->rvu;
+	pcifunc = ctrl->pcifunc;
+	fw_up = ctrl->fw_up;
+	kfree(ctrl);
+
+	rswitch = &rvu->rswitch;
+
+	if (!fw_up) {
+		rvu_sw_l2_destroy_wqs(rvu);
+		return;
+	}
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	if (fw_is_up && rvu_sw_l2_offl_wq && fdb_refresh_wq) {
+		rswitch->pcifunc = pcifunc;
+		rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
+		spin_unlock_bh(&rvu_sw_l2_state_lock);
+		return;
+	}
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	if (rvu_sw_l2_offl_wq || fdb_refresh_wq)
+		rvu_sw_l2_destroy_wqs(rvu);
+
+	l2_offl_work.rvu = rvu;
+	INIT_WORK(&l2_offl_work.work, rvu_sw_l2_offl_rule_wq_handler);
+	rvu_sw_l2_offl_wq = alloc_workqueue("swdev_rvu_sw_l2_offl_wq", 0, 0);
+	if (!rvu_sw_l2_offl_wq) {
+		dev_err(rvu->dev, "L2 offl workqueue allocation failed\n");
+		return;
+	}
+
+	fdb_refresh_work.rvu = rvu;
+	INIT_WORK(&fdb_refresh_work.work, rvu_sw_l2_fdb_refresh_wq_handler);
+	fdb_refresh_wq = alloc_workqueue("swdev_fdb_refresh_wq", 0, 0);
+	if (!fdb_refresh_wq) {
+		dev_err(rvu->dev, "fdb refresh workqueue allocation failed\n");
+		destroy_workqueue(rvu_sw_l2_offl_wq);
+		rvu_sw_l2_offl_wq = NULL;
+		return;
+	}
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	fw_is_up = true;
+	rswitch->pcifunc = pcifunc;
+	rswitch->flags |= RVU_SWITCH_FLAG_FW_READY;
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+}
+
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up)
+{
+	struct rvu_sw_l2_ctrl_work *ctrl;
+	struct workqueue_struct *wq;
+	int err = 0;
+
+	mutex_lock(&rvu_sw_l2_ctrl_lock);
+	if (going_down)
+		goto unlock;
+
+	if (!fw_up) {
+		spin_lock_bh(&rvu_sw_l2_state_lock);
+		rvu->rswitch.flags &= ~RVU_SWITCH_FLAG_FW_READY;
+		fw_is_up = false;
+		spin_unlock_bh(&rvu_sw_l2_state_lock);
+	}
+
+	if (!rvu_sw_l2_ctrl_wq) {
+		rvu_sw_l2_ctrl_wq = alloc_ordered_workqueue("rvu_sw_l2_ctrl",
+							    WQ_MEM_RECLAIM);
+		if (!rvu_sw_l2_ctrl_wq) {
+			err = -ENOMEM;
+			goto unlock;
+		}
+	}
+	wq = rvu_sw_l2_ctrl_wq;
+
+	ctrl = kzalloc_obj(*ctrl);
+	if (!ctrl) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	INIT_WORK(&ctrl->work, rvu_sw_l2_ctrl_work_handler);
+	ctrl->rvu = rvu;
+	ctrl->pcifunc = pcifunc;
+	ctrl->fw_up = fw_up;
+
+	queue_work(wq, &ctrl->work);
+
+unlock:
+	mutex_unlock(&rvu_sw_l2_ctrl_lock);
+	return err;
+}
+
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac)
+{
+	struct workqueue_struct *wq;
+	struct l2_entry *l2_entry;
+
+	if (!is_pf_func_valid(rvu, pcifunc))
+		return -EINVAL;
+
+	if (atomic_read(&fdb_refresh_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &fdb_refresh_list_cnt,
+					"fdb refresh");
+		return -ENOMEM;
+	}
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	l2_entry->port_id = pcifunc;
+	ether_addr_copy(l2_entry->mac, mac);
+
+	mutex_lock(&fdb_refresh_list_lock);
+	wq = fdb_refresh_wq;
+	if (!wq) {
+		mutex_unlock(&fdb_refresh_list_lock);
+		kfree(l2_entry);
+		return -EINVAL;
+	}
+
+	if (atomic_read(&fdb_refresh_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &fdb_refresh_list_cnt,
+					"fdb refresh");
+		mutex_unlock(&fdb_refresh_list_lock);
+		kfree(l2_entry);
+		return -ENOMEM;
+	}
+	list_add_tail(&l2_entry->list, &fdb_refresh_lh);
+	rvu_sw_l2_list_cnt_inc(rvu->dev, &fdb_refresh_list_cnt, "fdb refresh");
+	queue_work(wq, &fdb_refresh_work.work);
+	mutex_unlock(&fdb_refresh_list_lock);
+
+	return 0;
+}
 
 int rvu_mbox_handler_fdb_notify(struct rvu *rvu,
 				struct fdb_notify_req *req,
 				struct msg_rsp *rsp)
 {
+	struct workqueue_struct *wq;
+	struct l2_entry *l2_entry;
+	u32 port_id;
+
+	spin_lock_bh(&rvu_sw_l2_state_lock);
+	if (!(rvu->rswitch.flags & RVU_SWITCH_FLAG_FW_READY)) {
+		spin_unlock_bh(&rvu_sw_l2_state_lock);
+		return 0;
+	}
+	spin_unlock_bh(&rvu_sw_l2_state_lock);
+
+	port_id = rvu_sw_port_id(rvu, req->hdr.pcifunc);
+	if (port_id == RVU_SW_INVALID_PORT_ID)
+		return -EINVAL;
+
+	if (atomic_read(&l2_offl_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
+		return -ENOMEM;
+	}
+
+	l2_entry = kcalloc(1, sizeof(*l2_entry), GFP_KERNEL);
+	if (!l2_entry)
+		return -ENOMEM;
+
+	l2_entry->port_id = port_id;
+	ether_addr_copy(l2_entry->mac, req->mac);
+	l2_entry->flags = req->flags;
+
+	mutex_lock(&l2_offl_list_lock);
+	wq = rvu_sw_l2_offl_wq;
+	if (!wq) {
+		mutex_unlock(&l2_offl_list_lock);
+		kfree(l2_entry);
+		return 0;
+	}
+
+	if (atomic_read(&l2_offl_list_cnt) >= RVU_SW_L2_LIST_MAX) {
+		rvu_sw_l2_list_cnt_warn(rvu->dev, &l2_offl_list_cnt, "offload");
+		mutex_unlock(&l2_offl_list_lock);
+		kfree(l2_entry);
+		return -ENOMEM;
+	}
+	if (rvu_sw_l2_offl_coalesce_pending_locked(rvu, l2_entry)) {
+		mutex_unlock(&l2_offl_list_lock);
+		kfree(l2_entry);
+		return 0;
+	}
+	list_add_tail(&l2_entry->list, &l2_offl_lh);
+	rvu_sw_l2_list_cnt_inc(rvu->dev, &l2_offl_list_cnt, "offload");
+	queue_work(wq, &l2_offl_work.work);
+	mutex_unlock(&l2_offl_list_lock);
+
 	return 0;
 }
+
+void rvu_sw_l2_shutdown(void)
+{
+	struct workqueue_struct *wq;
+
+	mutex_lock(&rvu_sw_l2_ctrl_lock);
+	going_down = true;
+	wq = rvu_sw_l2_ctrl_wq;
+	rvu_sw_l2_ctrl_wq = NULL;
+	mutex_unlock(&rvu_sw_l2_ctrl_lock);
+
+	if (wq) {
+		flush_workqueue(wq);
+		destroy_workqueue(wq);
+	}
+
+	if (fdb_refresh_wq || rvu_sw_l2_offl_wq)
+		rvu_sw_l2_destroy_wqs(l2_offl_work.rvu);
+}
+
+void rvu_sw_l2_clear_shutdown(void)
+{
+	mutex_lock(&rvu_sw_l2_ctrl_lock);
+	going_down = false;
+	mutex_unlock(&rvu_sw_l2_ctrl_lock);
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
index ff28612150c9..3c250272e026 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/switch/rvu_sw_l2.h
@@ -8,4 +8,8 @@
 #ifndef RVU_SW_L2_H
 #define RVU_SW_L2_H
 
+int rvu_sw_l2_init_offl_wq(struct rvu *rvu, u16 pcifunc, bool fw_up);
+int rvu_sw_l2_fdb_list_entry_add(struct rvu *rvu, u16 pcifunc, u8 *mac);
+void rvu_sw_l2_shutdown(void);
+void rvu_sw_l2_clear_shutdown(void);
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index c995f2900859..6ee19aca194c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -28,6 +28,7 @@
 #include <rvu_trace.h>
 #include "cn10k_ipsec.h"
 #include "otx2_xsk.h"
+#include "switch/sw_nb.h"
 
 #define DRV_NAME	"rvu_nicpf"
 #define DRV_STRING	"Marvell RVU NIC Physical Function Driver"
@@ -993,6 +994,7 @@ static int otx2_process_mbox_msg_up(struct otx2_nic *pf,
 MBOX_UP_CGX_MESSAGES
 MBOX_UP_MCS_MESSAGES
 MBOX_UP_REP_MESSAGES
+MBOX_UP_AF2PF_FDB_REFRESH_MESSAGES
 #undef M
 		break;
 	default:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
index fcdf891f90b5..1d86cac5a7e8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_vf.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/net_tstamp.h>
+#include <net/switchdev.h>
 
 #include "otx2_common.h"
 #include "otx2_reg.h"
@@ -114,6 +115,38 @@ static void otx2vf_vfaf_mbox_handler(struct work_struct *work)
 	}
 }
 
+#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+static int otx2vf_mbox_af2pf_fdb_refresh(struct otx2_nic *vf,
+					 struct af2pf_fdb_refresh_req *req,
+					 struct msg_rsp *rsp)
+{
+	struct switchdev_notifier_fdb_info item = {0};
+
+	/* VM bridge + HW offload: vf->netdev is a br0 port in the guest.
+	 * SWITCHDEV_FDB_ADD_TO_BRIDGE on this netdev refreshes the guest
+	 * bridge FDB even when accelerated traffic bypasses eth0/eth1 RX
+	 * (see rvu_sw_l2_fdb_refresh_send()).
+	 */
+	item.addr = req->mac;
+	item.info.dev = vf->netdev;
+	if (req->flags & OTX2_FDB_DEL)
+		call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+	else
+		call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+
+	return 0;
+}
+#else
+static int otx2vf_mbox_af2pf_fdb_refresh(struct otx2_nic *vf,
+					 struct af2pf_fdb_refresh_req *req,
+					 struct msg_rsp *rsp)
+{
+	return 0;
+}
+#endif
+
 static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 				      struct mbox_msghdr *req)
 {
@@ -141,6 +174,22 @@ static int otx2vf_process_mbox_msg_up(struct otx2_nic *vf,
 		err = otx2_mbox_up_handler_cgx_link_event(
 				vf, (struct cgx_link_info_msg *)req, rsp);
 		return err;
+
+	case MBOX_MSG_AF2PF_FDB_REFRESH:
+		rsp = (struct msg_rsp *)otx2_mbox_alloc_msg(&vf->mbox.mbox_up, 0,
+							    sizeof(struct msg_rsp));
+		if (!rsp)
+			return -ENOMEM;
+
+		rsp->hdr.id = MBOX_MSG_AF2PF_FDB_REFRESH;
+		rsp->hdr.sig = OTX2_MBOX_RSP_SIG;
+		rsp->hdr.pcifunc = req->pcifunc;
+		rsp->hdr.rc = 0;
+		err = otx2vf_mbox_af2pf_fdb_refresh(vf,
+						    (struct af2pf_fdb_refresh_req *)req,
+						    rsp);
+		return err;
+
 	default:
 		otx2_reply_invalid_msg(&vf->mbox.mbox_up, 0, 0, req->id);
 		return -ENODEV;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
index 500451e85b50..e5e20b08ee8e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
@@ -4,16 +4,276 @@
  * Copyright (C) 2026 Marvell.
  *
  */
+#include <linux/kernel.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+#include <net/switchdev.h>
+#include <net/netevent.h>
+#include <net/arp.h>
+
+#include "../otx2_reg.h"
+#include "../otx2_common.h"
+#include "../otx2_struct.h"
+#include "../cn10k.h"
+#include "../rep.h"
+#include "sw_nb.h"
 #include "sw_fdb.h"
 
-#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+#if !IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp)
+{
+	return 0;
+}
+
+#else
+
+#define SW_FDB_LIST_MAX 4096
+
+static DEFINE_SPINLOCK(sw_fdb_llock);
+static LIST_HEAD(sw_fdb_lh);
+static atomic_t sw_fdb_list_cnt = ATOMIC_INIT(0);
+
+struct sw_fdb_list_entry {
+	struct list_head list;
+	u64 flags;
+	struct pci_dev *pdev;
+	struct net_device *dev;
+	netdevice_tracker dev_tracker;
+	u8  mac[ETH_ALEN];
+	bool add_fdb;
+};
+
+static struct workqueue_struct *sw_fdb_wq;
+static struct work_struct sw_fdb_work;
+
+static void sw_fdb_list_cnt_warn(struct net_device *netdev)
+{
+	int n = atomic_read(&sw_fdb_list_cnt);
+
+	if (n < 0)
+		netdev_warn(netdev, "FDB list count underflow: %d\n", n);
+	else if (n > SW_FDB_LIST_MAX)
+		netdev_warn(netdev, "FDB list count overflow: %d (max %d)\n",
+			    n, SW_FDB_LIST_MAX);
+}
+
+static int sw_fdb_list_count(void)
+{
+	return atomic_read(&sw_fdb_list_cnt);
+}
+
+static void sw_fdb_list_cnt_inc(struct net_device *netdev)
+{
+	atomic_inc(&sw_fdb_list_cnt);
+	sw_fdb_list_cnt_warn(netdev);
+}
+
+static void sw_fdb_list_cnt_dec(struct net_device *netdev)
+{
+	atomic_dec(&sw_fdb_list_cnt);
+	sw_fdb_list_cnt_warn(netdev);
+}
+
+static struct otx2_nic *sw_fdb_netdev_to_nic(struct net_device *dev)
+{
+	struct device *parent = dev->dev.parent;
+
+	if (parent && parent->bus == &pci_bus_type) {
+		struct pci_dev *pdev = to_pci_dev(parent);
+
+		if (otx2_rep_dev(pdev)) {
+			struct rep_dev *rep = netdev_priv(dev);
+
+			return rep->mdev;
+		}
+	}
+
+	return netdev_priv(dev);
+}
+
+static int sw_fdb_add_or_del(struct otx2_nic *pf,
+			     const unsigned char *addr,
+			     bool add_fdb)
+{
+	struct fdb_notify_req *req;
+	int rc;
+
+	mutex_lock(&pf->mbox.lock);
+	req = otx2_mbox_alloc_msg_fdb_notify(&pf->mbox);
+	if (!req) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	ether_addr_copy(req->mac, addr);
+	req->flags = add_fdb ? OTX2_FDB_ADD : OTX2_FDB_DEL;
+
+	rc = otx2_sync_mbox_msg(&pf->mbox);
+out:
+	mutex_unlock(&pf->mbox.lock);
+	return rc;
+}
+
+static void sw_fdb_entry_free(struct sw_fdb_list_entry *entry)
+{
+	netdev_put(entry->dev, &entry->dev_tracker);
+	pci_dev_put(entry->pdev);
+	kfree(entry);
+}
+
+static void sw_fdb_wq_handler(struct work_struct *work)
+{
+	struct sw_fdb_list_entry *entry;
+	struct otx2_nic *pf;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fdb_list_cnt_dec(entry->dev);
+
+		spin_lock(&sw_fdb_llock);
+		wq = sw_fdb_wq;
+		spin_unlock(&sw_fdb_llock);
+
+		pf = wq ? pci_get_drvdata(entry->pdev) : NULL;
+		if (pf && sw_fdb_add_or_del(pf, entry->mac, entry->add_fdb))
+			netdev_err(entry->dev,
+				   "Error to add/del fdb %pM entry\n",
+				   entry->mac);
+		/*
+		 * TODO: Requeue entry on transient sw_fdb_add_or_del() failure so
+		 * the switch FDB stays aligned with the bridge. Drop-on-failure
+		 * is known deferred work.
+		 */
+		sw_fdb_entry_free(entry);
+	}
+
+	spin_lock(&sw_fdb_llock);
+	wq = sw_fdb_wq;
+	if (wq && !list_empty(&sw_fdb_lh))
+		queue_work(wq, &sw_fdb_work);
+	spin_unlock(&sw_fdb_llock);
+}
+
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb)
+{
+	struct otx2_nic *pf = sw_fdb_netdev_to_nic(dev);
+	struct sw_fdb_list_entry *entry;
+	struct workqueue_struct *wq;
+
+	if (!pf)
+		return -EINVAL;
+
+	if (sw_fdb_list_count() >= SW_FDB_LIST_MAX)
+		return -ENOMEM;
+
+	entry = kcalloc(1, sizeof(*entry), GFP_ATOMIC);
+	if (!entry)
+		return -ENOMEM;
+
+	ether_addr_copy(entry->mac, mac);
+	entry->add_fdb = add_fdb;
+	entry->pdev = pci_dev_get(pf->pdev);
+	entry->dev = dev;
+	netdev_hold(dev, &entry->dev_tracker, GFP_ATOMIC);
+
+	spin_lock(&sw_fdb_llock);
+	wq = sw_fdb_wq;
+	if (!wq) {
+		spin_unlock(&sw_fdb_llock);
+		sw_fdb_entry_free(entry);
+		return -EINVAL;
+	}
+
+	if (sw_fdb_list_count() >= SW_FDB_LIST_MAX) {
+		spin_unlock(&sw_fdb_llock);
+		sw_fdb_entry_free(entry);
+		return -ENOMEM;
+	}
+
+	list_add_tail(&entry->list, &sw_fdb_lh);
+	sw_fdb_list_cnt_inc(dev);
+	queue_work(wq, &sw_fdb_work);
+	spin_unlock(&sw_fdb_llock);
+
+	return 0;
+}
+
 int sw_fdb_init(void)
 {
+	INIT_WORK(&sw_fdb_work, sw_fdb_wq_handler);
+	sw_fdb_wq = alloc_workqueue("sw_fdb_wq", 0, 0);
+	if (!sw_fdb_wq)
+		return -ENOMEM;
+
 	return 0;
 }
 
 void sw_fdb_deinit(void)
 {
+	struct sw_fdb_list_entry *entry;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tlist);
+
+	spin_lock(&sw_fdb_llock);
+	wq = sw_fdb_wq;
+	sw_fdb_wq = NULL;
+	spin_unlock(&sw_fdb_llock);
+
+	if (!wq)
+		return;
+
+	cancel_work_sync(&sw_fdb_work);
+	destroy_workqueue(wq);
+
+	spin_lock(&sw_fdb_llock);
+	list_splice_init(&sw_fdb_lh, &tlist);
+	spin_unlock(&sw_fdb_llock);
+
+	while ((entry =
+		list_first_entry_or_null(&tlist,
+					 struct sw_fdb_list_entry,
+					 list)) != NULL) {
+		list_del_init(&entry->list);
+		sw_fdb_list_cnt_dec(entry->dev);
+		sw_fdb_entry_free(entry);
+	}
 }
 
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp)
+{
+	struct switchdev_notifier_fdb_info item = {0};
+
+	/* FDB refresh is raised from the switch offload path (AF) after
+	 * switchdev FDB updates. PF-local ports are refreshed on pf->netdev.
+	 * TODO: When req->hdr.pcifunc targets a guest VF (VM-bridged offload),
+	 * forward the refresh via the PF-VF mailbox instead of applying it to
+	 * pf->netdev; otherwise guest-owned MACs may age out prematurely (see
+	 * rvu_sw_l2_fdb_refresh_send()).
+	 */
+	item.addr = req->mac;
+	item.info.dev = pf->netdev;
+	if (req->flags & OTX2_FDB_DEL)
+		call_switchdev_notifiers(SWITCHDEV_FDB_DEL_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+	else
+		call_switchdev_notifiers(SWITCHDEV_FDB_ADD_TO_BRIDGE,
+					 item.info.dev, &item.info, NULL);
+
+	return 0;
+}
 #endif
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
index dc427e8ab7c6..3083135c782c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.h
@@ -9,7 +9,10 @@
 
 #include <linux/kconfig.h>
 
+struct net_device;
+
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
+int sw_fdb_add_to_list(struct net_device *dev, u8 *mac, bool add_fdb);
 void sw_fdb_deinit(void);
 int sw_fdb_init(void);
 #else
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
index b51d8d2d01b8..c947f30becc8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
@@ -191,13 +191,17 @@ static int sw_nb_fdb_event(struct notifier_block *unused,
 
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
-		if (fdb_info->is_local)
-			break;
-		break;
-
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
 		if (fdb_info->is_local)
 			break;
+		/* dev is the bridge port that learned the FDB
+		 * (SWITCHDEV_FDB_*_TO_DEVICE), not the bridge master.
+		 * sw_nb_is_valid_dev() limits this to Cavium-offloaded
+		 * setups; only Cavium PF/representor netdevs are supported
+		 * as bridge ports today (VLAN/virt under bridge is TODO).
+		 */
+		sw_fdb_add_to_list(dev, (u8 *)fdb_info->addr,
+				   event == SWITCHDEV_FDB_ADD_TO_DEVICE);
 		break;
 
 	default:
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
index 39435f23427c..cb87c8ca56fe 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.h
@@ -14,6 +14,10 @@ struct otx2_nic;
 struct af2pf_fdb_refresh_req;
 struct msg_rsp;
 
+int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
+					   struct af2pf_fdb_refresh_req *req,
+					   struct msg_rsp *rsp);
+
 #if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
 enum {
 	OTX2_DEV_UP = 1,
@@ -32,10 +36,6 @@ int otx2_sw_nb_unregister(struct net_device *netdev);
 bool sw_nb_is_valid_dev(struct net_device *netdev);
 struct net_device *sw_nb_resolve_pf_dev(struct net_device *dev);
 
-int otx2_mbox_up_handler_af2pf_fdb_refresh(struct otx2_nic *pf,
-					   struct af2pf_fdb_refresh_req *req,
-					   struct msg_rsp *rsp);
-
 bool sw_nb_is_cavium_dev(struct net_device *netdev);
 int sw_nb_fib_event_to_otx2_event(int event, struct net_device *netdev);
 int sw_nb_inetaddr_event_to_otx2_event(int event, struct net_device *netdev);
-- 
2.43.0

