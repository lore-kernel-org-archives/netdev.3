Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47257EDAF
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792091512; cv=none; b=kEic/2KYbVIAO5sCqUVsM7JN4I6/JEohFiEeKDZyNYumLkFeZRP3xbm3WHN9ds462UHPi/6ObJUcmKzmoTmjcjBKBam/9IwImTrei2kID+upa761g3xRenlVgj9JlOzYBGZ/1o2yWXTPWubaA26yKFVTP/61HGHInD+qy/iCJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792091512; c=relaxed/simple;
	bh=15uQQtOwfPln07OLVQzeQ/wLDpdnCe68Efh7uZLmnu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQt8FlOHg6HSBlYwWxWGC4RH058RE2ew2TwdQ2sSzYeK9EabxqQfVZCxay3TGEh8k9OvROswmvOW1Rry9MCYz4Giyi3ftcj7VvUggw6eGldBJwLW6kIpjbFy7M/zmETAQzf4E1k77a3PTvu1WosTj6OW7WiF57imUzbp4bkUr1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXI6qSkC; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXI6qSkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792091499; x=1823627499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15uQQtOwfPln07OLVQzeQ/wLDpdnCe68Efh7uZLmnu8=;
  b=JXI6qSkC/Cd8PB43d1EiZ5xgpqPMKncIecV4yjAuq9Qm52Ui/0Qe1O3i
   LGY6BNGYdYFOQKlGznhk4owZ3I57SF5oxc3vgyxUK4WkA8Gw1zGtCER/M
   FPhPda8Kk02Zy8NY/6Yas8yoUmQijboiNmUMa0Q9b0hyzGkZQ4I0oDAPc
   jcs6yNkqE5lZutCKDumKSGOsl3nnDsmZL4bcJiI0GSrqz3bHn4UtnUpJa
   +BO0N+NNxWtXc91ngHYbne8NDM7KVVFeKklBlhIvGAv5aDQ091a7dIxwv
   T0xiN0j6lRfKUBY9PnQIxdce9mbYa1mtvWGjuCOcA0JDmNsCj0OeFJE60
   w==;
X-CSE-ConnectionGUID: DnBhdSKBRU+Fdmu7E+WT7w==
X-CSE-MsgGUID: WFh+m8oETLOo03Uqi3F6Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="765617"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="765617"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 12:11:16 -0700
X-CSE-ConnectionGUID: pQ89Hx0FTo2FZl+e1djt/A==
X-CSE-MsgGUID: jYLWoVlXS2ejmy/o/biVrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="2078521"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 15 Oct 2026 12:11:16 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	maciej.machnikowski@intel.com,
	przemyslaw.korba@intel.com,
	grzegorz.nitka@intel.com,
	sergey.temerkhanov@intel.com,
	arkadiusz.kubalewski@intel.com,
	richardcochran@gmail.com,
	horms@kernel.org
Subject: [PATCH net v3 12/14] ice: keep Tx timestamp slots tracked until completion or timeout
Date: Thu, 15 Oct 2026 12:10:58 -0700
Message-ID: <20261015191102.1174111-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
References: <20261015191102.1174111-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Oros <poros@redhat.com>

When the link goes down the processing loop drops every outstanding
request, and a request whose timestamp is not ready yet is freed
without reading the PHY slot. The hardware completes the capture a
moment later, the orphaned ready bit blocks the port interrupt until
the next link-up sweep, and the freed index can meanwhile be reused
by a new request whose slot the hardware then overwrites. Captured on
a reproducer as ready bits with no in_use owner right after a link
bounce.

Stop dropping on link down. Mark the outstanding requests stale so
their completions are read and discarded, reject new requests while
the link is down, and free a not yet ready slot only after the two
second timeout. This way an index is never reused while the hardware
can still write it and never left untracked while a completion can
still arrive.

Since we're adding a new call to ice_ptp_mark_tx_tracker, notice that the
function previously did not check the tracker initialization state. Fix
this by only accessing the bitmaps if the init field is set.

To avoid continuously re-triggering the IRQ at the end of a processing loop
when we have a stale packet that is not timestamped, modify
ice_ptp_tx_tstamps_pending() to ignore stale timestamps when checking for
whether to re-arm the IRQ from the miscellaneous thread function. Instead,
only count stale packets as part of the check in the auxiliary work thread.
This way we do not keep spamming the IRQ when the timestamp won't be
reported anyways.

To ensure that forward progress is made on clearing stale timestamps, fix
the check for ice_ptp_maybe_trigger_tx_interrupt to properly apply for
devices that manage their own interrupt, instead of only checking on the
clock owner. In the case of a timestamp which never completes, this does
result in one extra IRQ every 500 msec until the timeout. In some sense
this is extra work, but we need to recheck to ensure that timestamp slots
do not remain locked forever, and the software can't reliably know whether
a given index will or won't complete.

Note that E810 does not have the ready bitmap in its hardware. It is
currently excluded from the ice_ptp_maybe_trigger_tx_interrupt() by a check
against the has_ready_bitmap field. This could lead to an interrupt stall
if every single Tx timestamp index slot becomes stale. However, just
removing the check against has_ready_bitmap would be problematic for the
low latency path which currently is not protected against another IRQ
happening while a request is outstanding. That is a pre-existing issue, but
we should avoid making it worse until the path can be addressed by another
fix. The low latency path also completely bypasses the
ice_ptp_process_tx_tstamp() flow. For now, skip the
ice_ptp_maybe_trigger_tx_interrupt() when ts_ll_int_read is set and the low
latency path is in use. The path still has preexisting issues but this
avoids making it worse.

This effectively reverts commit fcc2cef37fed ("ice/ptp: fix the PTP worker
retrying indefinitely if the link went down"), which tried to release an
index before this 2 second wait period.

Fixes: fcc2cef37fed ("ice/ptp: fix the PTP worker retrying indefinitely if the link went down")
Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Petr Oros <poros@redhat.com>
Reviewed-by: Maciek Machnikowski <maciej.machnikowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 56 ++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ptp.h    |  8 ++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c |  4 +-
 4 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index b4ee2cf7cd70..b48b9c455166 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -3248,7 +3248,7 @@ static irqreturn_t ice_misc_intr_thread_fn(int __always_unused irq, void *data)
 	ice_irq_dynamic_ena(hw, NULL, NULL);
 	ice_flush(hw);
 
-	if (ice_ptp_tx_tstamps_pending(pf)) {
+	if (ice_ptp_tx_tstamps_pending(pf, true)) {
 		/* If any new Tx timestamps happened while in interrupt,
 		 * re-arm the interrupt to trigger it again.
 		 */
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ca581490f3ed..57141e94c570 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -365,9 +365,12 @@ static u64 ice_ptp_extend_40b_ts(struct ice_pf *pf, u64 in_tstamp)
 static bool
 ice_ptp_is_tx_tracker_up(struct ice_ptp_tx *tx)
 {
+	struct ice_ptp_port *ptp_port =
+		container_of(tx, struct ice_ptp_port, tx);
+
 	lockdep_assert_held(&tx->lock);
 
-	return tx->init && !tx->calibrating;
+	return tx->init && !tx->calibrating && READ_ONCE(ptp_port->link_up);
 }
 
 /**
@@ -564,7 +567,6 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	u64 tstamp_ready;
-	bool link_up;
 	int err;
 	u8 idx;
 
@@ -582,14 +584,11 @@ static void ice_ptp_process_tx_tstamp(struct ice_ptp_tx *tx)
 			return;
 	}
 
-	/* Drop packets if the link went down */
-	link_up = READ_ONCE(ptp_port->link_up);
-
 	for_each_set_bit(idx, tx->in_use, tx->len) {
 		struct skb_shared_hwtstamps shhwtstamps = {};
 		u8 phy_idx = idx + tx->offset;
 		u64 raw_tstamp = 0, tstamp;
-		bool drop_ts = !link_up;
+		bool drop_ts = false;
 		struct sk_buff *skb;
 
 		/* Paired with smp_mb__before_atomic() in ice_ptp_request_ts()
@@ -1432,6 +1431,9 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
 
 	WRITE_ONCE(ptp_port->link_up, linkup);
 
+	if (!linkup)
+		ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
+
 	if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
 		goto out_unlock;
 
@@ -2829,21 +2831,22 @@ void ice_ptp_process_ts(struct ice_pf *pf)
 	}
 }
 
-static bool ice_port_has_timestamps(struct ice_ptp_tx *tx)
+static bool ice_port_has_timestamps(struct ice_ptp_tx *tx, bool in_irq)
 {
-	bool more_timestamps;
+	DECLARE_BITMAP(tstamps, INDEX_PER_PORT_MAX) = {};
 
 	scoped_guard(spinlock_irqsave, &tx->lock) {
 		if (!tx->init)
 			return false;
 
-		more_timestamps = !bitmap_empty(tx->in_use, tx->len);
+		if (in_irq)
+			return bitmap_andnot(tstamps, tx->in_use, tx->stale, tx->len);
+		else
+			return !bitmap_empty(tx->in_use, tx->len);
 	}
-
-	return more_timestamps;
 }
 
-static bool ice_any_port_has_timestamps(struct ice_pf *pf)
+static bool ice_any_port_has_timestamps(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_port_list *ports = &pf->adapter->ports;
 	bool have_tstamps = false;
@@ -2856,7 +2859,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 		if (!kref_get_unless_zero(&port->ref))
 			continue;
 
-		if (ice_port_has_timestamps(&port->tx))
+		if (ice_port_has_timestamps(&port->tx, in_irq))
 			have_tstamps = true;
 
 		kref_put(&port->ref, ice_ptp_release_port_srcu);
@@ -2869,7 +2872,7 @@ static bool ice_any_port_has_timestamps(struct ice_pf *pf)
 	return have_tstamps;
 }
 
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	struct ice_hw *hw = &pf->hw;
 	int ret;
@@ -2879,11 +2882,11 @@ bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
 	case ICE_PTP_TX_INTERRUPT_NONE:
 		return false;
 	case ICE_PTP_TX_INTERRUPT_SELF:
-		if (ice_port_has_timestamps(&pf->ptp.port.tx))
+		if (ice_port_has_timestamps(&pf->ptp.port.tx, in_irq))
 			return true;
 		break;
 	case ICE_PTP_TX_INTERRUPT_ALL:
-		if (ice_any_port_has_timestamps(pf))
+		if (ice_any_port_has_timestamps(pf, in_irq))
 			return true;
 		break;
 	default:
@@ -2959,7 +2962,7 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 		/* E830 can read timestamps in the top half using rd32() */
 		ice_ptp_process_ts(pf);
 
-		if (ice_ptp_tx_tstamps_pending(pf)) {
+		if (ice_ptp_tx_tstamps_pending(pf, true)) {
 			/* Process outstanding Tx timestamps. If there
 			 * is more work, re-arm the interrupt to trigger again.
 			 */
@@ -2981,27 +2984,24 @@ irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
  * current timestamp data is read. In rare circumstances, it is possible that
  * the driver fails to read all outstanding data.
  *
- * To avoid getting permanently stuck, periodically check if the PHY has
- * outstanding timestamp data. If so, trigger an interrupt from software to
- * process this data.
+ * To avoid getting permanently stuck, periodically check if there is any
+ * outstanding timestamps or if the PHY has marked any index as ready. If so,
+ * trigger an interrupt from software to process this data.
  */
 static void ice_ptp_maybe_trigger_tx_interrupt(struct ice_pf *pf)
 {
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
-	int ret;
 
-	if (!pf->ptp.port.tx.has_ready_bitmap)
+	/* Avoid re-triggering OICR on E810 with low latency interrupt path */
+	if (hw->dev_caps.ts_dev_info.ts_ll_int_read)
 		return;
 
-	if (!ice_pf_src_tmr_owned(pf))
+	if (pf->ptp.tx_interrupt_mode != ICE_PTP_TX_INTERRUPT_SELF &&
+	    !ice_pf_src_tmr_owned(pf))
 		return;
 
-	ret = ice_check_phy_tx_tstamp_ready(hw);
-	if (ret < 0) {
-		dev_dbg(dev, "PTP periodic task unable to read PHY timestamp ready bitmap, err %d\n",
-			ret);
-	} else if (ret) {
+	if (ice_ptp_tx_tstamps_pending(pf, false)) {
 		dev_dbg(dev, "PTP periodic task detected waiting timestamps. Triggering Tx timestamp interrupt now.\n");
 
 		wr32(hw, PFINT_OICR, PFINT_OICR_TSYN_TX_M);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
index 029ee4612d76..7810fefc546e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
@@ -132,6 +132,9 @@ struct ice_ptp_tx {
 #define INDEX_PER_PORT_E82X		16
 #define INDEX_PER_PORT			64
 
+/* Maximum number of timestamp indexes across all devices */
+#define INDEX_PER_PORT_MAX              INDEX_PER_PORT
+
 /**
  * struct ice_ptp_port - data used to initialize an external port for PTP
  *
@@ -314,7 +317,7 @@ void ice_ptp_req_tx_single_tstamp(struct ice_ptp_tx *tx, u8 idx);
 void ice_ptp_complete_tx_single_tstamp(struct ice_ptp_tx *tx);
 void ice_ptp_process_ts(struct ice_pf *pf);
 irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf);
-bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf);
+bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq);
 u64 ice_ptp_read_src_clk_reg(struct ice_pf *pf,
 			     struct ptp_system_timestamp *sts);
 
@@ -362,7 +365,8 @@ static inline irqreturn_t ice_ptp_ts_irq(struct ice_pf *pf)
 	return IRQ_HANDLED;
 }
 
-static inline bool ice_ptp_tx_tstamps_pending(struct ice_pf *pf)
+static inline bool
+ice_ptp_tx_tstamps_pending(struct ice_pf *pf, bool in_irq)
 {
 	return false;
 }
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 51442b26516e..bd14aa3a77f6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -5001,8 +5001,8 @@ ice_get_phy_tx_tstamp_ready_e810(struct ice_hw *hw, u8 port, u64 *tstamp_ready)
  * The E810 devices do not have a Tx memory status register. Note this is
  * intentionally different behavior from ice_get_phy_tx_tstamp_ready_e810
  * which always says that all bits are ready. This function is called in cases
- * where code will trigger interrupts if timestamps are waiting, and should
- * not be called for E810 hardware.
+ * where code will trigger interrupts if timestamps are waiting, and which
+ * should not trigger for E810.
  *
  * Return: 0.
  */
-- 
2.47.1

