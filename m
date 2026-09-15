Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D64A0919
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476971; cv=none; b=UYr2q4ycVndlHMA/0fgLmfqGBmL/hb4N3rxxYayY1iXlp6BPH30bULkCpxKa7zGdu41i3lCnwzD26e3i7ZQe675fYzP2h+8HecqKzHV+jUz8vQbZDvC+qvaQan4dVSy33vHd0XgGyvF/qeHcwnh1HJ4O1VFynm5JNfPi+f98TMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476971; c=relaxed/simple;
	bh=SVi2QyFt7LAfpt1ccmZ+QuM4IbdNUnhyGVGSXCmWt90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYPbFcxZbkQ3JyGuuMq1/tOFXFm3/rXxAwNmW3anL4HPHWSk+5LLz7794mALdpXX3FQxR3XnF5vvmcBHryXpp4IM5qro4XdFAfG0O74TTtcJmnmA+U73x4EeglLOgvGIl+SgcigjbYxjy+UqpjSVIKpHKbWgsjfXoma9aNggXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fFiaNLRH; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fFiaNLRH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789476969; x=1821012969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVi2QyFt7LAfpt1ccmZ+QuM4IbdNUnhyGVGSXCmWt90=;
  b=fFiaNLRHo/1ADviMCKdUup0KXV1WxtptT3O0++OnbSiKP+NsoKuL7U+D
   zQ9KfZFbX38EwoxlSugeslvJlDZBT4GfL4HgGlhNy1Nh4HkFQc0AOyDii
   4jQpMsaPOK2gF5vWhsb8uTGS35c94lm7oKYUtBuef8GLZUIegi3wWTyZg
   nwNGSkYGVLmLLw4dRBMaAHAsNCIoZ55PgM879yLHDhCWEojy6xe/L4gjb
   iGLjO0sYCMmYLtb9yT6oG3jsr71djdtYD9OBNWh5X+It9lqzHLZoV8M1b
   g5/Pp1+HtJk4RZHcY+BOkUb8CFkd6uaovyjLHjUBqyLCD2pXD71tpyiVw
   g==;
X-CSE-ConnectionGUID: MNJRkOkTQfOEu2HgVAZlVg==
X-CSE-MsgGUID: oIAt8dc3SSeVcr+vVygYBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="112607076"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="112607076"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 05:55:55 -0700
X-CSE-ConnectionGUID: Hg/7Z68QRw+R9IW5vH3RXw==
X-CSE-MsgGUID: cE0OiWPZRyW13+J2Pfgjkg==
X-ExtLoop1: 1
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa003.fm.intel.com with ESMTP; 15 Sep 2026 05:55:53 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kiran Patil <kiran.patil@intel.com>
Subject: [PATCH iwl-net v2 1/5] iavf: fix null pointer dereference in iavf_detect_recover_hung
Date: Tue, 15 Sep 2026 14:55:47 +0200
Message-ID: <20260915125551.3976068-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
References: <20260915125551.3976068-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kiran Patil <kiran.patil@intel.com>

iavf_watchdog_task() and iavf_reset_task() both run as work items on the
same ordered adapter->wq, so they can't race with each other. However,
iavf_set_ringparam() (and other ethtool ops) call iavf_reset_step()
directly from process context under the netdev instance lock, without
going through that workqueue at all. iavf_reset_step() can free and
reallocate adapter->tx_rings and the q_vectors array via
iavf_reinit_interrupt_scheme() while adapter->state still reads
__IAVF_RUNNING, so the watchdog task can concurrently call
iavf_detect_recover_hung() and dereference a NULL q_vector inside
iavf_force_wb(), or index into a NULL tx_rings array, causing a crash.

Guard against this by:
- returning early if vsi->back->tx_rings itself is NULL, since
  num_active_queues can still be nonzero while the array is being
  reallocated;
- skipping rings whose q_vector is NULL;
- reading tx_ring->q_vector once with READ_ONCE() into a local variable
  and reusing that same value for both the NULL check and the
  iavf_force_wb() call, instead of re-reading the field right before
  use, which would leave a window for the concurrent reset to swap it
  from underneath us in between.

Also move the tx_ring declaration into the loop body and drop the
redundant outer NULL initialisation, which the compiler can never
observe since an array-element address is always non-NULL.

Fixes: 07d44190a389 ("i40e/i40evf: Detect and recover hung queue scenario")
Cc: stable@vger.kernel.org
Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 50 ++++++++++++---------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c30abf1..f1c26a9 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -176,7 +176,6 @@ static void iavf_force_wb(struct iavf_vsi *vsi, struct iavf_q_vector *q_vector)
  **/
 void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 {
-	struct iavf_ring *tx_ring = NULL;
 	struct net_device *netdev;
 	unsigned int i;
 	int packets;
@@ -194,29 +193,38 @@ void iavf_detect_recover_hung(struct iavf_vsi *vsi)
 	if (!netif_carrier_ok(netdev))
 		return;
 
+	/* tx_rings can be freed/reallocated by a concurrent reset */
+	if (!vsi->back->tx_rings)
+		return;
+
 	for (i = 0; i < vsi->back->num_active_queues; i++) {
-		tx_ring = &vsi->back->tx_rings[i];
-		if (tx_ring && tx_ring->desc) {
-			/* If packet counter has not changed the queue is
-			 * likely stalled, so force an interrupt for this
-			 * queue.
-			 *
-			 * prev_pkt_ctr would be negative if there was no
-			 * pending work.
-			 */
-			packets = tx_ring->stats.packets & INT_MAX;
-			if (tx_ring->prev_pkt_ctr == packets) {
-				iavf_force_wb(vsi, tx_ring->q_vector);
-				continue;
-			}
+		struct iavf_ring *tx_ring = &vsi->back->tx_rings[i];
+		struct iavf_q_vector *q_vector;
 
-			/* Memory barrier between read of packet count and call
-			 * to iavf_get_tx_pending()
-			 */
-			smp_rmb();
-			tx_ring->prev_pkt_ctr =
-			  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
+		/* read once, q_vector can be reassigned by a concurrent reset */
+		q_vector = READ_ONCE(tx_ring->q_vector);
+		if (!q_vector || !tx_ring->desc)
+			continue;
+
+		/* If packet counter has not changed the queue is
+		 * likely stalled, so force an interrupt for this
+		 * queue.
+		 *
+		 * prev_pkt_ctr would be negative if there was no
+		 * pending work.
+		 */
+		packets = tx_ring->stats.packets & INT_MAX;
+		if (tx_ring->prev_pkt_ctr == packets) {
+			iavf_force_wb(vsi, q_vector);
+			continue;
 		}
+
+		/* Memory barrier between read of packet count and call
+		 * to iavf_get_tx_pending()
+		 */
+		smp_rmb();
+		tx_ring->prev_pkt_ctr =
+		  iavf_get_tx_pending(tx_ring, true) ? packets : -1;
 	}
 }
 
-- 
2.52.0

