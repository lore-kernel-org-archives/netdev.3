Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965C24248BB
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769794; cv=none; b=JONxdVPaU0omH2gmayad4/T2g3PQJnqQN7b9bg5mTedKsM1mXBAzLk51chHPSWctpmiXH2yTA6Ao4JUzuKIjJB4s3OfvTMbGlSIb3Sf+Ok+96BgVr8CixDdjkbPrkcCjx4u7WdXKCC6JU0f9CbyN0NBO5OKjPBLz6ozGz8z7Y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769794; c=relaxed/simple;
	bh=TZrwy/NjU9/0FRm7wXLGa46VFJ9KrkhU1oIMHOXFlUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0JXClcFhrLuAtmVz8yHND6Api2S7/fH6r1AKUzvKz6HxKJWwMlBXfpOVHj4drlehAmbKANg7lc/cireVcUezslAodl9GR9f4rt0l+KwRG+2gL8tWjisriGjmlz4I+pIjzxSxSIjElF+VNF807EZ3e+X67b5wxSKumTHiH7L9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HT/EzZ4y; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HT/EzZ4y"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39b35105ba4so2781986a91.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 01:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788769792; x=1789374592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZdJ+RvEPX0GBiCRnCQpssUOHlseb9BpuN1eXq/NMOjs=;
        b=HT/EzZ4yVt/MQzBFdKbs4V709OZmaV3k1/FRD5kyLjgZn6xoAiLPq+1J68FrQNJcAn
         +4s0rYqKYt3rlKcxPuYGdhye9fYs7wMXlVBoRjl06YsGAkaAjgJo2TGAkqgNQepkm0kY
         4g5q/8kAmhNLAY94iBZBPY16/HN1/ay9DiT8B340dIOcChJnopH6ROYFMBjPlCXDV3VS
         xT2T1u9fGTDTwOXBgcoJDTAP0a6gKGz06cjoc3dlrU2oaLbmQxBgPKJ4n/Umoxbzisnj
         9gNJWkpcIdbirpTEWA3PA45HesHIcc4rfULgeu/chx43OeqVYTrI2WnDLyYnySGbHZKt
         ku5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769792; x=1789374592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZdJ+RvEPX0GBiCRnCQpssUOHlseb9BpuN1eXq/NMOjs=;
        b=Jkjg+2LronbMDiUKdlJ0Qb88jsCYnC+pBXcjpbW9QAeRd/3mLD4W28MswMRL8K/Pkl
         aZjHlNQGdZDZqeUryCLpDQwNpcm22tqBLVdp+yk91azYploQ0uPYvqNjlSwzCdOXTc0z
         HaCNBNHLAXqU1DCcl/ii5CSQZ14KOuiWVYH8sL2BTgDgHBYSDLX9T9nl6dtZZlICYgry
         hv/2aMb8HvoPXkJUx1YgHt//TT6l537Ggf9+XFaMB58AvtJz6qld3X4eav5YgvNHo6HH
         +a1AoBVmW6Z504QqBkPbaG+apgQgVyj0N/Ubl//IobjLWJ9TIZDeqMQcNcyTCCTll+F1
         GPBA==
X-Gm-Message-State: AFuF++nvYuawFPzdlS8f6eXteBOUn3vHCW+6a+n+euhAi3qTAJWv99WY
	q1P3fNEPt4/uPKvqqqOxjRVg7MHNfd3dgs7+j5TnlKQIAe7N+OC4dDCEotUp5rWg
X-Gm-Gg: AYBFou3KVRExOq8QMqAkdkky0uC8x4yhxGwo49ZTrvMfTYfjUG5Ol5kD+G1Q58/+eBy
	gf+4Cd3wqyBlYL6+w/3cbkNgb8p2UYrNIQbt4nV1dW+1sNMR65oNtR7K/X8WHRLxlfsKQpjTrbO
	8ATsln6CkzxZydASIyklUJ4XdWDaxeeVZXScb0g+QV3CpceE+CI1ipK5fGO6Oq1VgZAcqR2SnlC
	XxccK4ai2SmacqgDB/O/hr3f1MoP2joM9nqi1C3rajXwXbdBy6TCtRHeJ1AL8T/sVa3ql7ge4cR
	tBaSxQjBKJk+FKHSTmE9HubXgpuNKLBCfNxCa0ELyPmTx+EvJxq0dQtadTs9kb8P2vnOrqR41t2
	SJ7PNMioBRflEuDR87a1VZj8DArqJIjS2up6Yuq/eOFphm/WP28mbYxKJN3lA9Y4y3GLaUTmXHK
	N5W5Yl4z13BTb37NtzN1UXAZQt6f2bRS1srOe25zBBrUuyv7jzhUDGiYGMSwXsok84eOhOQCOtp
	VLqBBnPvBU=
X-Received: by 2002:a17:90b:4a49:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39b26100cd2mr31547094a91.2.1788769791656;
        Mon, 07 Sep 2026 01:29:51 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612ba2bsm18848285a91.14.2026.09.07.01.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:29:50 -0700 (PDT)
From: Tim JH Chen <tim770802@gmail.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	simon.horman@ghnetworks.de,
	haijun.liu@mediatek.com,
	chandrashekar.devegowda@intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	tim.jh.chen@wnc.com.tw,
	Chih.Hung.Huang@wnc.com.tw,
	Tim JH Chen <tim770802@gmail.com>
Subject: [PATCH net v5] net: wwan: t7xx: fix race between TX path and system PM suspend
Date: Mon,  7 Sep 2026 16:29:38 +0800
Message-ID: <20260907082938.7500-1-tim770802@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several driver contexts call pm_runtime_resume_and_get() and then access
hardware registers without being quiesced during system suspend. System
suspend does not honour the runtime PM reference they hold, so they can
touch the hardware while the device suspend callbacks tear it down. With
ASPM L1 enabled and repeated suspend/resume cycles this ends in a CPU
soft lockup:

  watchdog: BUG: soft lockup - CPU#N stuck for 26s! [dpmaif_tx_hw_pu]
    __pm_runtime_resume+0x5b/0x80
    t7xx_dpmaif_tx_hw_push_thread+0xc4 [mtk_t7xx]

Runtime suspend is already safe: while any of these contexts holds its PM
reference the runtime suspend callback cannot run. Only system suspend,
which ignores that reference, is exposed.

Quiesce all hardware-accessing contexts with the PM freezer, which runs
before dpm_suspend() invokes the device suspend callbacks.

The TX push kthread (t7xx_dpmaif_tx_hw_push_thread):
  - Call set_freezable() at thread start.
  - Replace wait_event_interruptible() with wait_event_freezable() so the
    idle wait is also a freeze point.
  - Add try_to_freeze() before the pm_runtime_resume_and_get() / MMIO
    section so continuous TX traffic still reaches a freeze point.
  - Add a freezing(current) check inside the DRB-ring-full retry loop in
    t7xx_do_tx_hw_push(). When the TX-done workqueue is frozen first, it
    stops draining completed DRBs; the ring stays full and the kthread
    loops in the retry branch indefinitely, never reaching the
    try_to_freeze() above. Returning from t7xx_do_tx_hw_push() on
    freezing(current) lets the caller release the PM sleep lock and the
    runtime PM reference before the kthread is parked at try_to_freeze().

The TX-done (md_dpmaif_tx*_worker), BAT-release
(dpmaif_bat_release_work_queue), CLDMA TX (md_hif*_tx*_worker), and
CLDMA RX (md_hif*_rx*_worker) workqueues:
  - Mark all four WQ_FREEZABLE so the workqueue freezer drains and parks
    their pending work before the device suspend callbacks run.

Tasks and work items are thawed only after the resume callbacks have
re-armed the hardware, so none of these contexts can issue MMIO against
a torn-down or not-yet-rearmed device. No lock is shared with the PM
callbacks, so this cannot deadlock.

Tested with 500+ suspend/resume cycles, SIM registered and ASPM L1 enabled.

Fixes: 46e8f49ed7b3 ("net: wwan: t7xx: Introduce power management")
Signed-off-by: Tim JH Chen <tim770802@gmail.com>
---
v4 -> v5:
  - Fix freeze deadlock in t7xx_do_tx_hw_push(): when the TX-done
    workqueue (WQ_FREEZABLE) is frozen first it stops draining the DRB
    ring; the kthread then loops indefinitely in the ring-full retry
    branch and never reaches try_to_freeze(), causing a freezer timeout
    and suspend abort. Add a freezing(current) check in that branch so
    the kthread returns to its caller, which releases the PM sleep lock
    and runtime PM reference before try_to_freeze() parks the thread.
    (Simon Horman)
  - Extend WQ_FREEZABLE to the BAT-release workqueue
    (dpmaif_bat_release_work_queue) and the CLDMA TX/RX workqueues
    (md_hif*_tx*_worker, md_hif*_rx*_worker), which also access hardware
    registers and must not run after dpm_suspend() tears the device down.
    (Simon Horman)
  - The -EACCES usage-count underflow in pm_runtime_resume_and_get()
    callers and the stale kthread pointer on early thread exit are
    pre-existing issues; they will be addressed in a separate series.
v3 -> v4:
  - Drop the tx_pm_lock / state-snapshot approach entirely and use the PM
    freezer for both TX contexts instead. The previous approach deadlocked
    through the runtime PM wait queue (t7xx_dpmaif_suspend() is also the
    .runtime_suspend callback) and opened ISR windows by writing
    dpmaif_ctrl->state in suspend/resume.
  - Also cover t7xx_dpmaif_tx_done() (WQ_FREEZABLE), which has the same
    pm_runtime + MMIO pattern as the kthread.
  - Trim the changelog/commit message.
v2 -> v3: process fixes (Fixes tag, changelog placement).
v1 -> v2: save/restore pre-suspend state; wrap pm_runtime with a mutex.

 drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  4 ++--
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c |  2 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c | 26 +++++++++++++++++-----
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
index e10cb4f9104e..3d7712126761 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_cldma.c
@@ -1313,7 +1313,7 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 		md_cd_queue_struct_init(&md_ctrl->txq[i], md_ctrl, MTK_TX, i);
 		md_ctrl->txq[i].worker =
 			alloc_ordered_workqueue("md_hif%d_tx%d_worker",
-					WQ_MEM_RECLAIM | (i ? 0 : WQ_HIGHPRI),
+					WQ_MEM_RECLAIM | WQ_FREEZABLE | (i ? 0 : WQ_HIGHPRI),
 					md_ctrl->hif_id, i);
 		if (!md_ctrl->txq[i].worker)
 			goto err_workqueue;
@@ -1327,7 +1327,7 @@ int t7xx_cldma_init(struct cldma_ctrl *md_ctrl)
 
 		md_ctrl->rxq[i].worker =
 			alloc_ordered_workqueue("md_hif%d_rx%d_worker",
-						WQ_MEM_RECLAIM,
+						WQ_MEM_RECLAIM | WQ_FREEZABLE,
 						md_ctrl->hif_id, i);
 		if (!md_ctrl->rxq[i].worker)
 			goto err_workqueue;
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
index 5af90ca6e063..0fe2dd1363a4 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
@@ -1088,7 +1088,7 @@ static void t7xx_dpmaif_bat_release_work(struct work_struct *work)
 int t7xx_dpmaif_bat_rel_wq_alloc(struct dpmaif_ctrl *dpmaif_ctrl)
 {
 	dpmaif_ctrl->bat_release_wq = alloc_workqueue("dpmaif_bat_release_work_queue",
-						      WQ_MEM_RECLAIM | WQ_PERCPU,
+						      WQ_MEM_RECLAIM | WQ_PERCPU | WQ_FREEZABLE,
 						      1);
 	if (!dpmaif_ctrl->bat_release_wq)
 		return -ENOMEM;
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 236d632cf591..cce71c827e7b 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -22,6 +22,7 @@
 #include <linux/dma-direction.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
+#include <linux/freezer.h>
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
@@ -421,6 +422,12 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 
 		drb_send_cnt = t7xx_txq_burst_send_skb(txq);
 		if (drb_send_cnt <= 0) {
+			/* If a freeze is pending the TX-done worker may already be
+			 * frozen and unable to drain the DRB ring; return to the
+			 * caller so PM resources are released before try_to_freeze().
+			 */
+			if (freezing(current))
+				return;
 			usleep_range(10, 20);
 			cond_resched();
 			continue;
@@ -447,19 +454,28 @@ static int t7xx_dpmaif_tx_hw_push_thread(void *arg)
 	struct dpmaif_ctrl *dpmaif_ctrl = arg;
 	int ret;
 
+	set_freezable();
+
 	while (!kthread_should_stop()) {
 		if (t7xx_tx_lists_are_all_empty(dpmaif_ctrl) ||
 		    dpmaif_ctrl->state != DPMAIF_STATE_PWRON) {
-			if (wait_event_interruptible(dpmaif_ctrl->tx_wq,
-						     (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
-						     dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
-						     kthread_should_stop()))
+			if (wait_event_freezable(dpmaif_ctrl->tx_wq,
+						 (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) &&
+						  dpmaif_ctrl->state == DPMAIF_STATE_PWRON) ||
+						 kthread_should_stop()))
 				continue;
 
 			if (kthread_should_stop())
 				break;
 		}
 
+		/* Freeze here, outside the runtime-PM and MMIO section below, so
+		 * the system suspend freezer parks this thread before the device
+		 * suspend callbacks tear the DPMAIF hardware down.
+		 */
+		if (try_to_freeze())
+			continue;
+
 		ret = pm_runtime_resume_and_get(dpmaif_ctrl->dev);
 		if (ret < 0 && ret != -EACCES)
 			return ret;
@@ -617,7 +633,7 @@ int t7xx_dpmaif_txq_init(struct dpmaif_tx_queue *txq)
 	}
 
 	txq->worker = alloc_ordered_workqueue("md_dpmaif_tx%d_worker",
-				WQ_MEM_RECLAIM | (txq->index ? 0 : WQ_HIGHPRI),
+				WQ_MEM_RECLAIM | WQ_FREEZABLE | (txq->index ? 0 : WQ_HIGHPRI),
 				txq->index);
 	if (!txq->worker)
 		return -ENOMEM;
-- 
2.43.0

