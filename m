Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21B230566D;
	Mon, 28 Sep 2026 03:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566971; cv=none; b=FU2mpeQaq3bhnodxnwrwh1dogDxc0AQDuwPjZTyb/LtFr+8NXi7aTjottmrLW2uTCuf4cHi/xh36AE5y7rpUBUJ6eig3VEIdiZbwzGBlOtdxbV+i2gxu0WB5k64Hru6Py9SNPWZIrsrdTzRSQj+m1Hgrgyphb/y+T8JH3r2JIHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566971; c=relaxed/simple;
	bh=NJeCcIfAjhPjq6eFIV1eCgrV4OymG9gN6CWcECZ56Xk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YUO53pNIZMmkmoBsTM7MbRMt8I9pB+b+rJhdYURbuW8sya4gVf7gu9GMMYm0XX3YnS8pBH1Ahjmx4AyLY6UJ961Lw/rh/2WgPEb8qBTQBZLtryhvRt73Eyk2z7TBGXxps03pVK0RTBoQG81QrznCnPEygdlftVPOPbvn8eGuMAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=fMqrKJbp; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="fMqrKJbp"
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68S1vOSU1520056;
	Sun, 27 Sep 2026 20:42:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=UQ2pNb2ZVtLV+iye3MV2RVB
	LpmVxkljs/peui8qX8yA=; b=fMqrKJbp2u6SV4JcItHNurHORehC2ua2RQgvR+2
	KIJCWc0cCTTCYfzLgFiA64/Djtm0H5gfBcacozp5Ut+oTrfppBkzfok9grggvMr1
	GUlxnH2fKaf/fzkx9cEinv1LSr2UaXwCAucLwn/xzrqbYUNI1vGz+eeVAnYA82Db
	KMSpS+rvq03Ao+hBWd4AG8GsH86LE6qznKimfVmVxPBKgvm/FM6+KVXl7sMqkz1g
	GxnPndfdIqgdzE748vVgz90Brqb6iKuH6NgZtAZLdqsRuvW96srUNBInqPZfSX/P
	JyAd/9YhDuLYELtKjyD+uB9NdBUPoIgkJHo+Zg1/PcGd97g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4gxxt7stj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Sep 2026 20:42:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 27 Sep 2026 20:42:23 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 27 Sep 2026 20:42:23 -0700
Received: from kernel-ep2.caveonetworks.com (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with ESMTP id 01C823F709C;
	Sun, 27 Sep 2026 20:42:18 -0700 (PDT)
From: <nshettyj@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Geetha sowjanya <gakula@marvell.com>,
        Nitin Shetty J
	<nshettyj@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        "Ratheesh
 Kannoth" <rkannoth@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        "Paolo
 Abeni" <pabeni@redhat.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Harman
 Kalra" <hkalra@marvell.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v5] octeontx2-af: Fix rep link state sync and workqueue races
Date: Mon, 28 Sep 2026 09:12:11 +0530
Message-ID: <20260928034213.3173088-1-nshettyj@marvell.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAxNCBTYWx0ZWRfX+p4ZplvlBzgp
 2DI3SIYEHh9Idpxx24EobNTfLSzHleDFl0grIf+FPuniwQRl+LUMGpW4U5Y4QP9GlFaOl79Kjba
 itlE0Lhw2bz3Opq4ckP7aadmeTwTzqJNC2FAxAKM5kka5en/vdYdfc3GfdTxc9tqhpzXP8t880Z
 a+5rMPh+jU0msvPlVp5LiUQQTDS5Dx0KCSO/yhtsyYmNgEOx8K+NxWGsj9vDUEXLlzbe/qzXUsi
 rt7M6fWMOUSLLbhJR5jPRnhdcGQd/D6PXPTeL1SLUG5QxESYYxbGdGZvR33eovBUIC7MOmh/MUz
 VbBbx0SQg5nokmvy9Uc9DgLcZ5My0ixeWJXog1CBjQdlLB35sVs8yciJ4Xrnc/JYnLSKmAxsovU
 sC7HTXasr0m9C/TzGU86YntbpZ77qO8fmTXUW2GEkkDmCHMeLa+RUiUMZTDd4fwOcvV371XsxD7
 5uBU/h0jZuBdXpkSnZA==
X-Proofpoint-GUID: cRRNnFuA63VFOCX_6bBenZevteYCAgvT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAxNCBTYWx0ZWRfXwXWOU+NzpoYu
 DncbBAxdjc3jamYT/r4PIJ7XM2YxUJQdtzT9QlsqHZr5xr9N3MLhGZfV6eI7naRIvWyKNUBQM6u
 I3LnJNwSmvgYnHFX4/EaxBcXcLr5uQM=
X-Authority-Analysis: v=2.4 cv=YaEodARf c=1 sm=1 tr=0 ts=6ab9e221 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=Xr2ALTCuO8rUPy7eUNsA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: cRRNnFuA63VFOCX_6bBenZevteYCAgvT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01

From: Geetha sowjanya <gakula@marvell.com>

Move rep event workqueue init to rvu_mbox_handler_get_rep_cnt(),
fix use-after-free and race conditions in rep event handling,
add bounds checking, and serialize LBK link configuration.

Fixes: b8fea84a0468 ("octeontx2-pf: Add support to sync link state between representor and VFs")
Signed-off-by: Nitin Shetty J <nshettyj@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
changes in v5:
- Fix rvu_probe() leaking rep_evt_wq if probe fails after
  GET_REP_CNT has allocated it.
- Fix a race in rvu_mbox_handler_rep_event_notify() where an event
  could be queued after rep_mode is cleared during teardown.
- Drain rep_evtq_head when rep_mode is disabled to avoid leaking
  queued rep_evtq_ent entries.
- Sync initial link state in rvu_rep_install_mcam_rules() for
  PFs/VFs whose NIXLF was initialized before switchdev mode was
  enabled.
- Fix rvu_rep_up_notify() sending a mailbox notification after
  rep_mode has been disabled.
- Serialize rswitch->used_entries/entry2pcifunc[] access with
  switch_lock in rvu_rep_update_rules() and
  rvu_switch_update_rules().
- Fix a race in rvu_switch_enable() where used_entries was
  published before entry2pcifunc[] was fully populated.
- Serialize state reset with switch_lock in rvu_switch_disable()
  to fix a race against concurrent rule lookups.
- Fix a use-after-free/NULL dereference on priv->reps in
  rvu_rep_state_evt_handler() during teardown.
- Skip the spurious AF notification in rvu_rep_stop() when the
  interface is already going down (OTX2_FLAG_INTF_DOWN).
- Fix a use-after-free in rvu_rep_destroy() by flushing in-flight
  event work before freeing the reps array.
- Initialize rep_evtq_lock/rep_evtq_head/rep_evt_work even when
  cnt is 0, fixing a crash in esw_cfg's drain on an uninitialized list.

changes in v4:
- Addressed Sashiko review comments.
- Block get_rep_cnt() from allocating a new rep_evt_wq once RVU teardown starts.
- Flush the AF-VF mailbox workqueue too, in addition to AF-PF, before destroying rep_evt_wq.
- Drop queued representor events during teardown instead of blocking on mailbox timeouts.
- Publish/consume rep_evt_wq with smp_store_release()/smp_load_acquire() for correct ordering.
- Set rep_pcifunc only after the representor map and workqueue are successfully initialized.
- Reject GET_REP_CNT from VF callers; only a PF may register as the representor.
- Reject representor count exceeding RVU_MAX_REP instead of silently capping it.
- Disable the representor's own LBK link and reset MCAM bookkeeping on rule-install failure.

changes in v3:
- Introduce RVU_MAX_REP macro for the representor map array size.
- Fix use-after-free in rvu_remove() when rep_evt_wq is destroyed
  while a mbox handler is still running.
- Fix a race in rvu_mbox_handler_rep_event_notify() where rep_evt_wq
  could be freed between the NULL check and queue_work().
- Reject REP_EVENT_NOTIFY from non-owner PFs and invalid pcifunc values.
- Fix LBK link leak when MCAM rule installation fails midway.
- Fix a race in rvu_mbox_handler_get_rep_cnt() where concurrent mbox
  handlers could both initialize rep2pfvf_map.
- Reject GET_REP_CNT from non-owner callers with -EPERM.
- Cap rep_cnt to RVU_MAX_REP to prevent out-of-bounds map writes.
- Fix inconsistent rep_cnt state when get_rep_cnt initialization fails.
- Fix a race in rvu_switch_enable_lbk_link() where nix_blkaddr could
  change mid-call, and fix NULL dereference when nix_hw is not assigned.

changes in v2:
- Reject REP event notifications before workqueue setup and
    validate PF/VF state event pcifuncs.
- Make REP map initialization atomic by using a temporary map,
    handling zero-REP cases, and rolling back on workqueue allocation
    failure.
- Use an unbound REP event workqueue.
- Serialize LBK link TL2 configuration with rsrc_lock.
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   4 +-
 .../net/ethernet/marvell/octeontx2/af/rvu.c   |  41 +++
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   3 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 278 ++++++++++++++----
 .../marvell/octeontx2/af/rvu_switch.c         |  67 ++++-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  39 ++-
 .../net/ethernet/marvell/octeontx2/nic/rep.h  |   1 -
 7 files changed, 354 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index cece197d1074..d114faeba1bb 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -1777,10 +1777,12 @@ struct ptp_get_cap_rsp {
 	u64 cap;
 };
 
+#define RVU_MAX_REP	64
+
 struct get_rep_cnt_rsp {
 	struct mbox_msghdr hdr;
 	u16 rep_cnt;
-	u16 rep_pf_map[64];
+	u16 rep_pf_map[RVU_MAX_REP];
 	u64 rsvd;
 };
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 937b085582b5..baba56425943 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -3555,9 +3555,26 @@ static void rvu_update_module_params(struct rvu *rvu)
 
 static atomic_t device_bound = ATOMIC_INIT(0);
 
+static struct workqueue_struct *rvu_rep_evtq_disable(struct rvu *rvu)
+{
+	struct workqueue_struct *rep_wq;
+
+	mutex_lock(&rvu->rsrc_lock);
+	WRITE_ONCE(rvu->rep_evt_teardown, true);
+	rep_wq = rvu->rep_evt_wq;
+	WRITE_ONCE(rvu->rep_evt_wq, NULL);
+	mutex_unlock(&rvu->rsrc_lock);
+
+	if (rep_wq)
+		flush_workqueue(rep_wq);
+
+	return rep_wq;
+}
+
 static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
+	struct workqueue_struct *rep_wq;
 	struct rvu *rvu;
 	int    err;
 
@@ -3686,7 +3703,18 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_dl:
 	rvu_unregister_dl(rvu);
 err_irq:
+	/*
+	 * GET_REP_CNT may have allocated rep_evt_wq before this failure.
+	 * Drain it before unregistering interrupts.
+	 */
+	rep_wq = rvu_rep_evtq_disable(rvu);
+
 	rvu_unregister_interrupts(rvu);
+
+	if (rep_wq) {
+		flush_workqueue(rvu->afpf_wq_info.mbox_wq);
+		destroy_workqueue(rep_wq);
+	}
 err_flr:
 	rvu_flr_wq_destroy(rvu);
 err_mbox:
@@ -3715,12 +3743,25 @@ static int rvu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void rvu_remove(struct pci_dev *pdev)
 {
+	struct workqueue_struct *rep_wq;
 	struct rvu *rvu = pci_get_drvdata(pdev);
 
 	rvu_dbg_exit(rvu);
 	rvu_unregister_dl(rvu);
+
+	/* Block get_rep_cnt() from allocating a new rep_evt_wq. */
+	rep_wq = rvu_rep_evtq_disable(rvu);
+
 	rvu_unregister_interrupts(rvu);
 	rvu_flr_wq_destroy(rvu);
+
+	/* Flush both mbox workqueues before destroying rep_wq. */
+	flush_workqueue(rvu->afpf_wq_info.mbox_wq);
+	if (rvu->afvf_wq_info.mbox_wq)
+		flush_workqueue(rvu->afvf_wq_info.mbox_wq);
+	if (rep_wq)
+		destroy_workqueue(rep_wq);
+
 	rvu_cgx_exit(rvu);
 	rvu_fwdata_exit(rvu);
 	rvu_mcs_exit(rvu);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 9afb7ac8969b..16a75d568d23 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -571,7 +571,7 @@ struct npc_kpu_profile_adapter {
 #define RVU_SWITCH_LBK_CHAN	63
 
 struct rvu_switch {
-	struct mutex switch_lock; /* Serialize flow installation */
+	struct mutex switch_lock; /* Serialize flow installation and entry2pcifunc access */
 	u32 used_entries;
 	u16 *entry2pcifunc;
 	u16 mode;
@@ -675,6 +675,7 @@ struct rvu {
 	struct list_head	rep_evtq_head;
 	/* Representor event lock */
 	spinlock_t		rep_evtq_lock;
+	bool			rep_evt_teardown;
 
 	struct ng_rvu           *ng_rvu;
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index a2781e0f504e..4c4171515d74 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -44,7 +44,16 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
 	if (event->event & RVU_EVENT_MAC_ADDR_CHANGE)
 		ether_addr_copy(pfvf->mac_addr, event->evt_data.mac);
 
+	if (event->event & RVU_EVENT_PFVF_STATE)
+		pf = rvu_get_pf(rvu->pdev, event->hdr.pcifunc);
+
 	mutex_lock(&rvu->mbox_lock);
+
+	if (!READ_ONCE(rvu->rep_mode)) {
+		mutex_unlock(&rvu->mbox_lock);
+		return -ENODEV;
+	}
+
 	msg = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
 	if (!msg) {
 		mutex_unlock(&rvu->mbox_lock);
@@ -53,6 +62,10 @@ static int rvu_rep_up_notify(struct rvu *rvu, struct rep_event *event)
 
 	msg->hdr.pcifunc = event->pcifunc;
 	msg->event = event->event;
+	msg->pcifunc = event->pcifunc;
+
+	if (event->event & RVU_EVENT_PFVF_STATE)
+		msg->hdr.pcifunc = event->hdr.pcifunc;
 
 	memcpy(&msg->evt_data, &event->evt_data, sizeof(struct rep_evt_data));
 
@@ -87,7 +100,12 @@ static void rvu_rep_wq_handler(struct work_struct *work)
 
 		event = &qentry->event;
 
-		rvu_rep_up_notify(rvu, event);
+		/* Once teardown has started the AF-PF mbox interrupt may
+		 * already be disabled, so sending would just block until
+		 * otx2_mbox_wait_for_rsp() times out. Drop the event instead.
+		 */
+		if (!READ_ONCE(rvu->rep_evt_teardown))
+			rvu_rep_up_notify(rvu, event);
 		kfree(qentry);
 	} while (1);
 }
@@ -95,55 +113,71 @@ static void rvu_rep_wq_handler(struct work_struct *work)
 int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 				      struct msg_rsp *rsp)
 {
+	struct workqueue_struct *wq;
 	struct rep_evtq_ent *qentry;
 
-	/* The mailbox dispatcher normalises only the header pcifunc; the
-	 * nested struct rep_event::pcifunc body field is sender-controlled
-	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
-	 * rvu->hwvf[].  Reject out-of-range body selectors before queueing.
-	 */
+	wq = smp_load_acquire(&rvu->rep_evt_wq);
+	if (!wq)
+		return -EINVAL;
+
+	/* Only the registered representor PF may send REP_EVENT_NOTIFY. */
+	if (req->hdr.pcifunc != rvu->rep_pcifunc)
+		return -EPERM;
+
 	if (!is_pf_func_valid(rvu, req->pcifunc))
 		return -EINVAL;
 
+	/* Only CGX-mapped PFs are present in the representor map. */
+	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, req->pcifunc)))
+		return -EINVAL;
+
+	if ((req->event & RVU_EVENT_PFVF_STATE) &&
+	    rvu_get_pf(rvu->pdev, req->hdr.pcifunc) >= rvu->hw->total_pfs)
+		return -EINVAL;
+
 	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
 	if (!qentry)
 		return -ENOMEM;
 
 	qentry->event = *req;
 	spin_lock(&rvu->rep_evtq_lock);
+	if (!rvu->rep_mode) {
+		spin_unlock(&rvu->rep_evtq_lock);
+		kfree(qentry);
+		return -ENODEV;
+	}
 	list_add_tail(&qentry->node, &rvu->rep_evtq_head);
 	spin_unlock(&rvu->rep_evtq_lock);
-	queue_work(rvu->rep_evt_wq, &rvu->rep_evt_work);
+
+	queue_work(wq, &rvu->rep_evt_work);
 	return 0;
 }
 
-int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable)
+static void rvu_rep_evtq_drain(struct rvu *rvu)
 {
-	struct rep_event *req;
-	int pf;
-
-	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)))
-		return 0;
-
-	pf = rvu_get_pf(rvu->pdev, rvu->rep_pcifunc);
+	struct rep_evtq_ent *qentry;
 
-	mutex_lock(&rvu->mbox_lock);
-	req = otx2_mbox_alloc_msg_rep_event_up_notify(rvu, pf);
-	if (!req) {
-		mutex_unlock(&rvu->mbox_lock);
-		return -ENOMEM;
+	while (!list_empty(&rvu->rep_evtq_head)) {
+		qentry = list_first_entry(&rvu->rep_evtq_head,
+					  struct rep_evtq_ent, node);
+		list_del(&qentry->node);
+		kfree(qentry);
 	}
+}
 
-	req->hdr.pcifunc = rvu->rep_pcifunc;
-	req->event |= RVU_EVENT_PFVF_STATE;
-	req->pcifunc = pcifunc;
-	req->evt_data.vf_state = enable;
+int rvu_rep_notify_pfvf_state(struct rvu *rvu, u16 pcifunc, bool enable)
+{
+	struct rep_event req = { 0 };
+	struct msg_rsp rsp;
 
-	otx2_mbox_wait_for_zero(&rvu->afpf_wq_info.mbox_up, pf);
-	otx2_mbox_msg_send_up(&rvu->afpf_wq_info.mbox_up, pf);
+	if (!is_pf_cgxmapped(rvu, rvu_get_pf(rvu->pdev, pcifunc)))
+		return 0;
 
-	mutex_unlock(&rvu->mbox_lock);
-	return 0;
+	req.hdr.pcifunc = rvu->rep_pcifunc;
+	req.event = RVU_EVENT_PFVF_STATE;
+	req.pcifunc = pcifunc;
+	req.evt_data.vf_state = enable;
+	return rvu_mbox_handler_rep_event_notify(rvu, &req, &rsp);
 }
 
 #define RVU_LF_RX_STATS(reg) \
@@ -325,8 +359,10 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 	u16 start = rswitch->start_entry;
 	struct rvu_hwinfo *hw = rvu->hw;
 	u16 pcifunc, entry = 0;
+	struct rvu_pfvf *pfvf;
 	int pf, vf, numvfs;
 	int err, nixlf, i;
+	bool lbk_enabled;
 	u8 rep;
 
 	for (pf = 1; pf < hw->total_pfs; pf++) {
@@ -334,29 +370,43 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 			continue;
 
 		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+		pfvf = rvu_get_pfvf(rvu, pcifunc);
 		rvu_get_nix_blkaddr(rvu, pcifunc);
+		lbk_enabled = test_bit(NIXLF_INITIALIZED, &pfvf->flags);
+		if (lbk_enabled)
+			rvu_switch_enable_lbk_link(rvu, pcifunc, true);
 		rep = true;
 		for (i = 0; i < 2; i++) {
 			err = rvu_rep_install_rx_rule(rvu, pcifunc,
 						      start + entry, rep);
 			if (err)
-				return err;
+				goto err_disable_lbk;
 			rswitch->entry2pcifunc[entry++] = pcifunc;
 
 			err = rvu_rep_install_tx_rule(rvu, pcifunc,
 						      start + entry, rep);
 			if (err)
-				return err;
+				goto err_disable_lbk;
 			rswitch->entry2pcifunc[entry++] = pcifunc;
 			rep = false;
 		}
 
+		/* Sync initial link state for a PF brought up before
+		 * switchdev mode was enabled.
+		 */
+		if (lbk_enabled)
+			rvu_rep_notify_pfvf_state(rvu, pcifunc, true);
+
 		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
 		for (vf = 0; vf < numvfs; vf++) {
 			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+			pfvf = rvu_get_pfvf(rvu, pcifunc);
 			rvu_get_nix_blkaddr(rvu, pcifunc);
+			lbk_enabled = test_bit(NIXLF_INITIALIZED, &pfvf->flags);
+			if (lbk_enabled)
+				rvu_switch_enable_lbk_link(rvu, pcifunc, true);
 
-			/* Skip installimg rules if nixlf is not attached */
+			/* Skip installing rules if nixlf is not attached */
 			err = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
 			if (err)
 				continue;
@@ -366,47 +416,65 @@ int rvu_rep_install_mcam_rules(struct rvu *rvu)
 							      start + entry,
 							      rep);
 				if (err)
-					return err;
+					goto err_disable_lbk;
 				rswitch->entry2pcifunc[entry++] = pcifunc;
 
 				err = rvu_rep_install_tx_rule(rvu, pcifunc,
 							      start + entry,
 							      rep);
 				if (err)
-					return err;
+					goto err_disable_lbk;
 				rswitch->entry2pcifunc[entry++] = pcifunc;
 				rep = false;
 			}
+
+			/* Sync initial link state for a VF brought up before
+			 * switchdev mode was enabled.
+			 */
+			if (lbk_enabled)
+				rvu_rep_notify_pfvf_state(rvu, pcifunc, true);
 		}
 	}
+	return 0;
 
-	/* Initialize the wq for handling REP events */
-	spin_lock_init(&rvu->rep_evtq_lock);
-	INIT_LIST_HEAD(&rvu->rep_evtq_head);
-	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
-	rvu->rep_evt_wq = alloc_workqueue("rep_evt_wq", WQ_PERCPU, 0);
-	if (!rvu->rep_evt_wq) {
-		dev_err(rvu->dev, "REP workqueue allocation failed\n");
-		return -ENOMEM;
+err_disable_lbk:
+	/* Undo any LBK links enabled above before the MCAM rule failure.
+	 * Disabling a link that was never enabled is a safe no-op.
+	 */
+	for (pf = 1; pf < hw->total_pfs; pf++) {
+		if (!is_pf_cgxmapped(rvu, pf))
+			continue;
+		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+		rvu_switch_enable_lbk_link(rvu, pcifunc, false);
+		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
+		for (vf = 0; vf < numvfs; vf++) {
+			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+			rvu_switch_enable_lbk_link(rvu, pcifunc, false);
+		}
 	}
-	return 0;
+	return err;
 }
 
 void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
 {
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	struct npc_mcam *mcam = &rvu->hw->mcam;
-	u32 max = rswitch->used_entries;
 	int blkaddr;
 	u16 entry;
+	u32 max;
 
-	if (!rswitch->used_entries)
+	mutex_lock(&rswitch->switch_lock);
+	max = rswitch->used_entries;
+	if (!max) {
+		mutex_unlock(&rswitch->switch_lock);
 		return;
+	}
 
 	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
-
-	if (blkaddr < 0)
+	if (blkaddr < 0) {
+		mutex_unlock(&rswitch->switch_lock);
 		return;
+	}
 
 	rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
 	mutex_lock(&mcam->lock);
@@ -415,6 +483,7 @@ void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
 			npc_enable_mcam_entry(rvu, mcam, blkaddr, entry, ena);
 	}
 	mutex_unlock(&mcam->lock);
+	mutex_unlock(&rswitch->switch_lock);
 }
 
 int rvu_rep_pf_init(struct rvu *rvu)
@@ -435,10 +504,31 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 	if (req->hdr.pcifunc != rvu->rep_pcifunc)
 		return 0;
 
-	rvu->rep_mode = req->ena;
+	if (req->ena) {
+		rvu->rep_mode = true;
+	} else {
+		spin_lock(&rvu->rep_evtq_lock);
+		WRITE_ONCE(rvu->rep_mode, false);
+		rvu_rep_evtq_drain(rvu);
+		spin_unlock(&rvu->rep_evtq_lock);
 
-	if (!rvu->rep_mode)
 		rvu_npc_free_mcam_entries(rvu, req->hdr.pcifunc, -1);
+	}
+
+	return 0;
+}
+
+static int rvu_rep_get_rep_map(struct rvu *rvu, struct msg_req *req,
+			       struct get_rep_cnt_rsp *rsp)
+{
+	int rep;
+
+	if (req->hdr.pcifunc != rvu->rep_pcifunc)
+		return -EPERM;
+
+	rsp->rep_cnt = rvu->rep_cnt;
+	for (rep = 0; rep < rvu->rep_cnt; rep++)
+		rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
 
 	return 0;
 }
@@ -446,32 +536,96 @@ int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
 int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 				 struct get_rep_cnt_rsp *rsp)
 {
-	int pf, vf, numvfs, hwvf, rep = 0;
+	int pf, vf, numvfs, hwvf, rep = 0, cnt;
+	struct workqueue_struct *wq;
+	int ret = 0;
 	u16 pcifunc;
+	u16 *map;
 
-	rvu->rep_pcifunc = req->hdr.pcifunc;
-	rsp->rep_cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
-	rvu->rep_cnt = rsp->rep_cnt;
+	/* Serialize first-time initialization since mbox_wq is WQ_PERCPU. */
+	mutex_lock(&rvu->rsrc_lock);
 
-	rvu->rep2pfvf_map = devm_kzalloc(rvu->dev, rvu->rep_cnt *
-					 sizeof(u16), GFP_KERNEL);
-	if (!rvu->rep2pfvf_map)
-		return -ENOMEM;
+	if (rvu->rep_evt_teardown) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
+	if (rvu->rep2pfvf_map) {
+		ret = rvu_rep_get_rep_map(rvu, req, rsp);
+		goto unlock;
+	}
+
+	/* Only a PF can register as the representor, not a VF. */
+	if (req->hdr.pcifunc & RVU_PFVF_FUNC_MASK) {
+		ret = -EPERM;
+		goto unlock;
+	}
+
+	cnt = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
+	if (cnt > RVU_MAX_REP) {
+		dev_err(rvu->dev, "Representor count %d exceeds max %d\n",
+			cnt, RVU_MAX_REP);
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	/* Allocate at least one element so the pointer is always non-NULL
+	 * once published, keeping the fast-path check above reliable.
+	 */
+	map = devm_kzalloc(rvu->dev, (cnt ?: 1) * sizeof(u16), GFP_KERNEL);
+	if (!map) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
 
 	for (pf = 0; pf < rvu->hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
 			continue;
+		if (rep >= cnt)
+			break;
 		pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
-		rvu->rep2pfvf_map[rep] = pcifunc;
+		map[rep] = pcifunc;
 		rsp->rep_pf_map[rep] = pcifunc;
 		rep++;
 		rvu_get_pf_numvfs(rvu, pf, &numvfs, &hwvf);
-		for (vf = 0; vf < numvfs; vf++) {
-			rvu->rep2pfvf_map[rep] = pcifunc |
-				((vf + 1) & RVU_PFVF_FUNC_MASK);
-			rsp->rep_pf_map[rep] = rvu->rep2pfvf_map[rep];
+		for (vf = 0; vf < numvfs && rep < cnt; vf++) {
+			map[rep] = pcifunc | ((vf + 1) & RVU_PFVF_FUNC_MASK);
+			rsp->rep_pf_map[rep] = map[rep];
 			rep++;
 		}
 	}
-	return 0;
+
+	/* Initialize even when cnt is 0, so esw_cfg drain never sees an uninitialized list. */
+	spin_lock_init(&rvu->rep_evtq_lock);
+	INIT_LIST_HEAD(&rvu->rep_evtq_head);
+	INIT_WORK(&rvu->rep_evt_work, rvu_rep_wq_handler);
+
+	if (!cnt) {
+		rsp->rep_cnt = cnt;
+		rvu->rep_cnt = cnt;
+		rvu->rep2pfvf_map = map;
+		rvu->rep_pcifunc = req->hdr.pcifunc;
+		goto unlock;
+	}
+
+	wq = alloc_workqueue("rep_evt_wq", WQ_UNBOUND, 0);
+	if (!wq) {
+		dev_err(rvu->dev, "REP workqueue allocation failed\n");
+		devm_kfree(rvu->dev, map);
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	rvu->rep_cnt = cnt;
+	rsp->rep_cnt = cnt;
+	rvu->rep2pfvf_map = map;
+	rvu->rep_pcifunc = req->hdr.pcifunc;
+
+	/* Pairs with smp_load_acquire() in rvu_mbox_handler_rep_event_notify()
+	 * to publish the above initialization before wq becomes visible.
+	 */
+	smp_store_release(&rvu->rep_evt_wq, wq);
+unlock:
+	mutex_unlock(&rvu->rsrc_lock);
+	return ret;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index 49ce38685a7e..0897598c6ede 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -12,11 +12,18 @@ void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool enable)
 {
 	struct rvu_pfvf *pfvf = rvu_get_pfvf(rvu, pcifunc);
 	struct nix_hw *nix_hw;
+	int blkaddr;
 
-	nix_hw = get_nix_hw(rvu->hw, pfvf->nix_blkaddr);
+	mutex_lock(&rvu->rsrc_lock);
+	blkaddr = pfvf->nix_blkaddr;
+	nix_hw = get_nix_hw(rvu->hw, blkaddr);
 	/* Enable LBK links with channel 63 for TX MCAM rule */
-	rvu_nix_tx_tl2_cfg(rvu, pfvf->nix_blkaddr, pcifunc,
+	if (!nix_hw)
+		goto unlock;
+	rvu_nix_tx_tl2_cfg(rvu, blkaddr, pcifunc,
 			   &nix_hw->txsch[NIX_TXSCH_LVL_TL2], enable);
+unlock:
+	mutex_unlock(&rvu->rsrc_lock);
 }
 
 static int rvu_switch_install_rx_rule(struct rvu *rvu, u16 pcifunc,
@@ -188,7 +195,7 @@ void rvu_switch_enable(struct rvu *rvu)
 	if (!rswitch->entry2pcifunc)
 		goto free_entries;
 
-	rswitch->used_entries = alloc_rsp.count;
+	/* Publish used_entries only after entry2pcifunc[] is fully populated. */
 	rswitch->start_entry = alloc_rsp.entry;
 
 	if (rvu->rep_mode) {
@@ -200,13 +207,25 @@ void rvu_switch_enable(struct rvu *rvu)
 	if (ret)
 		goto uninstall_rules;
 
+	mutex_lock(&rswitch->switch_lock);
+	rswitch->used_entries = alloc_rsp.count;
+	mutex_unlock(&rswitch->switch_lock);
+
 	return;
 
 uninstall_rules:
+	if (rvu->rep_mode && rvu->rep_pcifunc)
+		rvu_switch_enable_lbk_link(rvu, rvu->rep_pcifunc, false);
+
 	uninstall_req.start = rswitch->start_entry;
-	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
+	uninstall_req.end =  rswitch->start_entry + alloc_rsp.count - 1;
 	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
+	mutex_lock(&rswitch->switch_lock);
+	rswitch->used_entries = 0;
+	rswitch->start_entry = 0;
 	kfree(rswitch->entry2pcifunc);
+	rswitch->entry2pcifunc = NULL;
+	mutex_unlock(&rswitch->switch_lock);
 free_entries:
 	free_req.all = 1;
 	rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
@@ -229,8 +248,23 @@ void rvu_switch_disable(struct rvu *rvu)
 	if (!rswitch->used_entries)
 		return;
 
-	if (rvu->rep_mode)
+	if (rvu->rep_mode) {
+		if (rvu->rep_pcifunc)
+			rvu_switch_enable_lbk_link(rvu, rvu->rep_pcifunc, false);
+
+		for (pf = 1; pf < hw->total_pfs; pf++) {
+			if (!is_pf_cgxmapped(rvu, pf))
+				continue;
+			pcifunc = rvu_make_pcifunc(rvu->pdev, pf, 0);
+			rvu_switch_enable_lbk_link(rvu, pcifunc, false);
+			rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
+			for (vf = 0; vf < numvfs; vf++) {
+				pcifunc = rvu_make_pcifunc(rvu->pdev, pf, vf + 1);
+				rvu_switch_enable_lbk_link(rvu, pcifunc, false);
+			}
+		}
 		goto free_ents;
+	}
 
 	for (pf = 1; pf < hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
@@ -260,35 +294,46 @@ void rvu_switch_disable(struct rvu *rvu)
 	}
 
 free_ents:
+	mutex_lock(&rswitch->switch_lock);
 	uninstall_req.start = rswitch->start_entry;
-	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
+	uninstall_req.end   = rswitch->start_entry + rswitch->used_entries - 1;
+	rswitch->used_entries = 0;
+	kfree(rswitch->entry2pcifunc);
+	rswitch->entry2pcifunc = NULL;
+	mutex_unlock(&rswitch->switch_lock);
+
 	free_req.all = 1;
 	rvu_mbox_handler_npc_delete_flow(rvu, &uninstall_req, &uninstall_rsp);
 	rvu_mbox_handler_npc_mcam_free_entry(rvu, &free_req, &rsp);
-	rswitch->used_entries = 0;
-	kfree(rswitch->entry2pcifunc);
 }
 
 void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
 {
 	struct rvu_switch *rswitch = &rvu->rswitch;
-	u32 max = rswitch->used_entries;
+	u16 start_entry;
 	u16 entry;
+	u32 max;
 
 	if (rvu->rep_mode)
 		return rvu_rep_update_rules(rvu, pcifunc, ena);
 
-	if (!rswitch->used_entries)
+	mutex_lock(&rswitch->switch_lock);
+	max = rswitch->used_entries;
+	if (!max) {
+		mutex_unlock(&rswitch->switch_lock);
 		return;
+	}
 
 	for (entry = 0; entry < max; entry++) {
 		if (rswitch->entry2pcifunc[entry] == pcifunc)
 			break;
 	}
+	start_entry = rswitch->start_entry;
+	mutex_unlock(&rswitch->switch_lock);
 
 	if (entry >= max)
 		return;
 
-	rvu_switch_install_tx_rule(rvu, pcifunc, rswitch->start_entry + entry);
+	rvu_switch_install_tx_rule(rvu, pcifunc, start_entry + entry);
 	rvu_switch_install_rx_rule(rvu, pcifunc, 0x0);
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index 0f5d5642d3f7..21b5802cb943 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -297,11 +297,27 @@ static int rvu_rep_notify_pfvf(struct otx2_nic *priv, u16 event,
 static void rvu_rep_state_evt_handler(struct otx2_nic *priv,
 				      struct rep_event *info)
 {
+	struct rep_dev **reps;
 	struct rep_dev *rep;
 	int rep_id;
 
+	/* Capture a stable snapshot.  rvu_rep_destroy() sets priv->reps to
+	 * NULL and then calls flush_work() to wait for any in-flight handler
+	 * to finish before freeing the array, so using the local copy here
+	 * is safe for the lifetime of this function.
+	 */
+	reps = READ_ONCE(priv->reps);
+	if (!reps)
+		return;
+
 	rep_id = rvu_rep_get_repid(priv, info->pcifunc);
-	rep = priv->reps[rep_id];
+	if (rep_id < 0) {
+		dev_warn_ratelimited(priv->dev,
+				     "REP state event for unknown pcifunc 0x%x (err %d)\n",
+				     info->pcifunc, rep_id);
+		return;
+	}
+	rep = reps[rep_id];
 	if (info->evt_data.vf_state)
 		rep->flags |= RVU_REP_VF_INITIALIZED;
 	else
@@ -459,6 +475,9 @@ static int rvu_rep_open(struct net_device *dev)
 	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 
+	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
+		return 0;
+
 	evt.event = RVU_EVENT_PORT_STATE;
 	evt.evt_data.port_state = 1;
 	evt.pcifunc = rep->pcifunc;
@@ -478,6 +497,13 @@ static int rvu_rep_stop(struct net_device *dev)
 	netif_carrier_off(dev);
 	netif_tx_disable(dev);
 
+	if (rep->pcifunc & RVU_PFVF_FUNC_MASK)
+		return 0;
+
+	/* Don't notify the AF during teardown */
+	if (priv->flags & OTX2_FLAG_INTF_DOWN)
+		return 0;
+
 	evt.event = RVU_EVENT_PORT_STATE;
 	evt.pcifunc = rep->pcifunc;
 	rvu_rep_notify_pfvf(priv, RVU_EVENT_PORT_STATE, &evt);
@@ -628,20 +654,27 @@ static int rvu_rep_rsrc_init(struct otx2_nic *priv)
 
 void rvu_rep_destroy(struct otx2_nic *priv)
 {
+	struct rep_dev **reps = priv->reps;
 	struct rep_dev *rep;
 	int rep_id;
 
 	rvu_eswitch_config(priv, false);
 	priv->flags |= OTX2_FLAG_INTF_DOWN;
 	rvu_rep_free_cq_rsrc(priv);
+
+	priv->reps = NULL;
+	/* Wait for any in-flight rvu_rep_state_evt_handler() using the old
+	 * reps snapshot to finish before freeing the entries below.
+	 */
+	flush_work(&priv->mbox.mbox_up_wrk);
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
-		rep = priv->reps[rep_id];
+		rep = reps[rep_id];
 		unregister_netdev(rep->netdev);
 		rvu_rep_devlink_port_unregister(rep);
 		free_netdev(rep->netdev);
 		kfree(rep->flow_cfg);
 	}
-	kfree(priv->reps);
+	kfree(reps);
 	rvu_rep_rsrc_free(priv);
 }
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
index 5bc9e2c7d800..b98fe191e83a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
@@ -16,7 +16,6 @@
 
 #define PCI_DEVID_RVU_REP	0xA0E0
 
-#define RVU_MAX_REP	OTX2_MAX_CQ_CNT
 
 struct rep_stats {
 	u64 rx_bytes;
-- 
2.48.1

