Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C6B438004
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785508; cv=none; b=BO5RAZ0neIcE7TQFKTnacoZOX963TTgIFlNzsOd6BtJaa5s3gHZq8V0QwIsGdLS0zFCUOYgiOsB5w9XeIYozW6LtW+j74PZ8/JZrDRgsHtiMkE600hd8KOdpRJnWvyAAfAf1EBsIyfYIcwbQvuKVbAPIsWcAbesWxBL/+5wTCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785508; c=relaxed/simple;
	bh=pOxNP2vY3UzL3c0l9cazZD+LgepzcmOwxPxHBtCkpbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKAO5nDUZ3eySVEGmKxCzD7f5iO1qUCoDDaoIOkp8V2ZkGp72WeCazCQ2MMUJG+DIgyXH0KTdXwkKIxq4BAfK5QmYBXPUxDpX59IjZxqsmBI489OclHoWswr8D96uHr5bIl9KaKmGGnRb4/hMzJ+IOtu2Ghdx7XHvDpgwV8eggw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGbpcXBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGbpcXBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 929211F00A3D;
	Mon,  3 Aug 2026 19:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785507;
	bh=FMO7XUoFfWC0RPACV1kyIdR614pDzPLLBKR8BodzKxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGbpcXBDULS8E3OzPXsPNeSCaMvh3cMGfkfyep8iL0oMqh9feh2QfHBF9Qd9RRdnK
	 p6KrkrfDDEGzzkN7L34tZxlOH3iVWPH+4tw1A1fmTuzGM+ewG2dx/4nq5te0+xDvu2
	 DIHvvAq7gqWYBQNnVpdiF7nY05FI7i3onMkTu/ALWHUkdJ2b1M+CXA9+nWOgSg/m3e
	 dhjg7IBuVtbUr4PB+0OCqgE3i0bV7WYSGZhCRYDpWGN2YMWrw73Lk6f6OGfAvMKOBK
	 pz1l+wM3eP6VwUzttYehaugGxgGoXJnq1JEEaOGT6+AgBhp6jbjJaI9A3xm0c5uhJe
	 uN892QtU6mAhw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	manoj.panicker2@amd.com,
	somnath.kotur@broadcom.com,
	andrew.gospodarek@broadcom.com,
	wei.huang2@amd.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 4/4] eth: bnxt: avoid deadlock when canceling IRQ affinity notifier
Date: Mon,  3 Aug 2026 12:31:35 -0700
Message-ID: <20260803193135.2030368-5-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803193135.2030368-1-kuba@kernel.org>
References: <20260803193135.2030368-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unregistering IRQ affinity notifiers waits for the callback synchronously.
bnxt takes the netdev instance lock in the notifier (to restart the queue)
and cancels the work under the same lock. This may obviously deadlock.

Move the restart to the async service task. The queue restart isn't
super time sensitive. Store the new TPH tag, schedule the task.
Safely canceling the service task is already ironed out.

In bnxt_request_irq() the order of registering notifier, affinity and
initial TPH programming has to be inverted. I think it was racy
previously since user may trigger an update as soon as notifier
is installed.

There's a small known gap - if pcie_tph_get_cpu_st() fails at init
and the target tag is 0 we may miss programming the entry.
This does not seem worth fixing, the code has skip-on-failure
all over the place, anyway.

Fixes: c214410c47d6 ("bnxt_en: Add TPH support in BNXT driver")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 86 ++++++++++++++++-------
 2 files changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6335dfc14c98..18eadbc491e7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1268,6 +1268,8 @@ struct bnxt_irq {
 	struct bnxt	*bp;
 	int		msix_nr;
 	int		ring_nr;
+	u16		tag;
+	u16		new_tag;
 	struct irq_affinity_notify affinity_notify;
 };
 
@@ -2641,6 +2643,7 @@ struct bnxt {
 #define BNXT_RING_COAL_NOW_SP_EVENT	17
 #define BNXT_FW_RESET_NOTIFY_SP_EVENT	18
 #define BNXT_FW_EXCEPTION_SP_EVENT	19
+#define BNXT_TPH_UPDATE_SP_EVENT	20
 #define BNXT_LINK_CFG_CHANGE_SP_EVENT	21
 #define BNXT_THERMAL_THRESHOLD_SP_EVENT	22
 #define BNXT_FW_ECHO_REQUEST_SP_EVENT	23
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 202a16170141..72d808c06def 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -11770,12 +11770,13 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 {
 	struct bnxt_irq *irq;
 	u16 tag;
-	int err;
 
 	irq = container_of(notify, struct bnxt_irq, affinity_notify);
 
 #ifdef CONFIG_RFS_ACCEL
 	if (irq->bp->dev->rx_cpu_rmap && irq->ring_nr < irq->bp->rx_nr_rings) {
+		int err;
+
 		err = cpu_rmap_update(irq->bp->dev->rx_cpu_rmap, irq->ring_nr,
 				      mask);
 		if (err)
@@ -11793,20 +11794,11 @@ static void bnxt_irq_affinity_notify(struct irq_affinity_notify *notify,
 		return;
 
 	if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
-				cpumask_first(irq->cpu_mask), &tag))
+				cpumask_first(mask), &tag))
 		return;
 
-	if (pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag))
-		return;
-
-	netdev_lock(irq->bp->dev);
-	if (netif_running(irq->bp->dev)) {
-		err = netdev_rx_queue_restart(irq->bp->dev, irq->ring_nr);
-		if (err)
-			netdev_err(irq->bp->dev,
-				   "RX queue restart failed: err=%d\n", err);
-	}
-	netdev_unlock(irq->bp->dev);
+	WRITE_ONCE(irq->new_tag, tag);
+	bnxt_queue_sp_work(irq->bp, BNXT_TPH_UPDATE_SP_EVENT);
 }
 
 static void bnxt_irq_affinity_release(struct kref *ref)
@@ -11877,6 +11869,8 @@ static void bnxt_free_irq(struct bnxt *bp)
 		}
 
 		irq->requested = 0;
+		irq->tag = 0;
+		irq->new_tag = 0;
 	}
 
 	/* Disable TPH support */
@@ -11914,6 +11908,7 @@ static int bnxt_request_irq(struct bnxt *bp)
 	for (i = 0, j = 0; i < bp->cp_nr_rings; i++) {
 		int map_idx = bnxt_cp_num_to_irq_num(bp, i);
 		struct bnxt_irq *irq = &bp->irq_tbl[map_idx];
+		unsigned int cpu_num;
 		u16 tag;
 
 		if (IS_ENABLED(CONFIG_RFS_ACCEL) &&
@@ -11939,8 +11934,19 @@ static int bnxt_request_irq(struct bnxt *bp)
 		irq->have_cpumask = 1;
 		irq->msix_nr = map_idx;
 		irq->ring_nr = i;
-		cpumask_set_cpu(cpumask_local_spread(i, numa_node),
-				irq->cpu_mask);
+		cpu_num = cpumask_local_spread(i, numa_node);
+		cpumask_set_cpu(cpu_num, irq->cpu_mask);
+
+		/* Init ST table entry if we can get the mapping */
+		if (!pcie_tph_get_cpu_st(bp->pdev, TPH_MEM_TYPE_VM,
+					 cpu_num, &tag)) {
+			pcie_tph_set_st_entry(bp->pdev, irq->msix_nr, tag);
+			irq->tag = tag;
+			irq->new_tag = tag;
+		}
+
+		bnxt_register_irq_notifier(bp, irq);
+
 		rc = irq_update_affinity_hint(irq->vector, irq->cpu_mask);
 		if (rc) {
 			netdev_warn(bp->dev,
@@ -11948,16 +11954,6 @@ static int bnxt_request_irq(struct bnxt *bp)
 				    irq->vector);
 			break;
 		}
-
-		bnxt_register_irq_notifier(bp, irq);
-
-		/* Init ST table entry */
-		if (pcie_tph_get_cpu_st(irq->bp->pdev, TPH_MEM_TYPE_VM,
-					cpumask_first(irq->cpu_mask),
-					&tag))
-			continue;
-
-		pcie_tph_set_st_entry(irq->bp->pdev, irq->msix_nr, tag);
 	}
 	return rc;
 }
@@ -14460,6 +14456,43 @@ static void bnxt_rtnl_unlock_sp(struct bnxt *bp)
 	rtnl_unlock();
 }
 
+static void bnxt_tph_update(struct bnxt *bp)
+{
+	struct net_device *dev = bp->dev;
+	int i;
+
+	bnxt_lock_sp(bp);
+	if (!test_bit(BNXT_STATE_OPEN, &bp->state))
+		goto unlock;
+
+	for (i = 0; i < bp->rx_nr_rings; i++) {
+		struct bnxt_irq *irq;
+		int map_idx, err;
+		u16 tag;
+
+		map_idx = bnxt_cp_num_to_irq_num(bp, i);
+		irq = &bp->irq_tbl[map_idx];
+		tag = READ_ONCE(irq->new_tag);
+		if (irq->tag == tag)
+			continue;
+
+		if (pcie_tph_set_st_entry(bp->pdev, irq->msix_nr, tag))
+			continue;
+
+		err = netdev_rx_queue_restart(dev, irq->ring_nr);
+		if (err) {
+			netdev_err(dev, "RX queue restart failed: err=%d\n",
+				   err);
+			continue;
+		}
+
+		irq->tag = tag;
+	}
+
+unlock:
+	bnxt_unlock_sp(bp);
+}
+
 /* Only called from bnxt_sp_task() */
 static void bnxt_reset(struct bnxt *bp, bool silent)
 {
@@ -14884,6 +14917,9 @@ static void bnxt_sp_task(struct work_struct *work)
 			bnxt_devlink_health_fw_report(bp);
 	}
 
+	if (test_and_clear_bit(BNXT_TPH_UPDATE_SP_EVENT, &bp->sp_event))
+		bnxt_tph_update(bp);
+
 	smp_mb__before_atomic();
 	clear_bit(BNXT_STATE_IN_SP_TASK, &bp->state);
 }
-- 
2.55.0

